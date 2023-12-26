# Import the clipspy module
from clips import Environment

import sys
import wx

class ElectronicMusic(wx.App):
    def OnInit(self):
        # Create a CLIPS environment
        self.env = Environment()

        self.env.load("electronicMusic.clp")

        # Create the GUI
        self.dialog = wx.Dialog(None, -1, "Auto Demo", size=(1400, 300))

        sizer = wx.BoxSizer(wx.VERTICAL)

        self.question = wx.Panel(self.dialog, -1, name="Question")
        sizer.Add(self.question,
                  flag=wx.ALL |
                       wx.EXPAND,
                  border=10,
                  proportion=1)

        self.answers = wx.Panel(self.dialog, -1, name="Answers")
        sizer.Add(self.answers,
                  flag=wx.ALL |
                       wx.ALIGN_CENTRE,
                  border=5,
                  proportion=1)

        self.buttons = wx.Panel(self.dialog, -1, name="Buttons")
        sizer.Add(self.buttons,
                  flag=wx.ALL |
                       wx.ALIGN_CENTRE,
                  border=5,
                  proportion=1)

        self.dialog.SetSizer(sizer)

        self.env.reset()
        self.env.run()

        self.nextUIState()

        # Bind the close event to the exit function and show the GUI
        self.dialog.Bind(wx.EVT_CLOSE, self.exit)
        self.dialog.Show(True)

        return True

    def nextUIState(self):
        """
        Re-creates the Dialog window to match the current state in
        Working Memory.
        """

        # Get the state-list.
        factlist = list(fact for fact in self.env.facts() if fact.template.name == 'state-list')
        if not factlist:
            return

        currentID = factlist[0]['current']

        # Get the current UI state.
        factlist = list(
            fact for fact in self.env.facts() if fact.template.name == f'UI-state' and fact['id'] == currentID)
        if not factlist:
            return

        # Clear the Buttons panel and re-create it for this UI state
        self.buttons.DestroyChildren()

        sizer = wx.BoxSizer(wx.HORIZONTAL)
        prev = wx.Button(self.buttons, -1, "Prev")
        next = wx.Button(self.buttons, -1, "Next")

        sizer.Add(prev, flag=wx.ALL, border=5)
        sizer.Add(next, flag=wx.ALL, border=5)

        self.dialog.Bind(wx.EVT_BUTTON, self.handleEvent, prev)
        self.dialog.Bind(wx.EVT_BUTTON, self.handleEvent, next)

        self.buttons.SetSizer(sizer)

        self.buttons.Fit()

        # Determine the Next/Prev button states.
        state = factlist[0]['state']
        if state == "final":
            next.SetLabel("Restart")
            next.Show(True)
            prev.Show(True)

        elif state == "initial":
            next.SetLabel("Next")
            next.Show(True)
            prev.Show(False)

        else:
            next.SetLabel("Next")
            next.Show(True)
            prev.Show(True)

        self.buttons.SetSizer(sizer)

        # Set up the choices.
        valid_answers = factlist[0]['valid-answers']

        selected = factlist[0]['response']

        # Clear the Answers panel and re-create it for this UI state
        self.answers.DestroyChildren()

        sizer = wx.BoxSizer(wx.HORIZONTAL)

        self.answers._buttons = []
        for answer in valid_answers:
            r = wx.RadioButton(self.answers, -1, answer)
            if answer == selected:
                r.SetValue(True)

            sizer.Add(r, flag=wx.ALL, border=5)
            self.answers._buttons.append(r)

        self.answers.SetSizer(sizer)
        self.answers.Fit()

        # Set the label to the display text.
        theText = factlist[0]['display']

        self.question.DestroyChildren()

        sizer = wx.BoxSizer(wx.HORIZONTAL)
        sizer.Add(wx.StaticText(self.question, -1, theText, style=wx.ALIGN_CENTRE),
                  flag=wx.ALL |
                       wx.GROW |
                       wx.EXPAND,
                  border=5,
                  proportion=1)
        self.question.SetSizer(sizer)
        self.question.Fit()

        self.dialog.Layout()
        self.dialog.Refresh()

    def handleEvent(self, event):
        """
        Triggers the next state in Working Memory based on which wx.Button
        was pressed and triggers a re-generation of the GUI.
        """

        # Get the state-list.
        factlist = [fact for fact in self.env.facts() if fact.template.name == 'state-list']
        if not factlist:
            return

        currentID = factlist[0]['current']

        # Handle the Next button.
        if event.GetEventObject().GetLabel() == "Next":
            if len(self.answers._buttons) == 0:
                self.env.assert_string(f"(next {currentID})")

            else:
                # Get current selection
                for b in self.answers._buttons:
                    if b.GetValue():
                        break

                self.env.assert_string(f"(next {currentID} {b.GetLabel()})")

        elif event.GetEventObject().GetLabel() == "Restart":
            self.env.reset()

        elif event.GetEventObject().GetLabel() == "Prev":
            self.env.assert_string(f"(prev {currentID})")

        self.env.run()

        self.nextUIState()

    def exit(self, event):
        """
        Destroys the GUI and exits the application.
        """

        self.dialog.Destroy()
        sys.exit(0)

if __name__ == '__main__':
    app = ElectronicMusic(0)
    app.MainLoop()