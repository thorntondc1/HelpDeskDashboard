import wx
import wx.html2


class AccountDashboard(wx.Frame):
    def __init__(self):
        wx.Frame.__init__(self, None, title="University of Central Arkansas Account Tool", pos=(100,150), size=(1250,780))

        self.panel = wx.Panel(self)

        #Enter account username text 
        self.Prompt = wx.StaticText(self.panel, label = "Enter Account Username:", pos = (20,650))
        font = self.Prompt.GetFont()
        font.PointSize = 10
        font = font.Bold()
        self.Prompt.SetFont(font)


        #Making buttons 
        self.button1 = wx.Button(self.panel, label = "Unlock", pos = (400,640), size= (90,37))
        self.button2 = wx.Button(self.panel, label = "Reset", pos = (500,640), size=(90,37))
        self.button3 = wx.Button(self.panel, label = "Clear", pos = (600,640), size = (90,37))

        #edit message under textbox
        self.Result = wx.StaticText(self.panel, pos = (190,680))
        font2 = self.Result.GetFont()
        font2.PointSize = 10
        self.Result.SetFont(font2)
        
        #edit textbox
        self.Username = wx.TextCtrl(self.panel, pos = (185,647), size=(197,25))
        font3 = self.Username.GetFont()
        font3.PointSize = 10
        self.Username.SetFont(font3)

        #browser
        self.Browser = wx.html2.WebView.New(self.panel, pos = (20,10), size = (1200,600))
        self.Browser.LoadURL("https://argos.uca.edu/Argos/AWV/#shortcut/private//datablock/Network%20Account%20Lookup%20with%20student%20data")
        self.Browser.Show()



        #button events 
        self.button1.Bind(wx.EVT_BUTTON, self.Unlock)
        self.button2.Bind(wx.EVT_BUTTON, self.Reset)
        self.button3.Bind(wx.EVT_BUTTON, self.Clear)


    def Unlock(self, event):
        self.Result.SetLabel(self.Username.GetValue())
        
    def Reset(self, event):
        pass

    def Clear(self, event):
        self.Username.SetValue("")
        self.Result.SetLabel("")


app = wx.App(False)
frame = AccountDashboard()
frame.Show()


app.MainLoop()
