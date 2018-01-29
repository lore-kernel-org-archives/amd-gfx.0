From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Strange issue on Vega 8 Mobile (HP Envy x360 Laptop)
Date: Mon, 29 Jan 2018 20:06:58 +0000
Message-ID: <BN6PR12MB165259DBBCB8941EBFA9CBC2F7E50@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <CAJKuQOfP56P0Zq5kSmMjHAY74x_yTzcsgPbaRZj1h4K=iPBuwQ@mail.gmail.com>
 <BN6PR12MB134817C964BC95F8D2B05CEAE8E50@BN6PR12MB1348.namprd12.prod.outlook.com>
 <CAJKuQOcSdHQMWO-v4M84=YrxHnu5GudNtUaN=-JhjAnsQsuVNA@mail.gmail.com>,
 <CAJKuQOf7T7eiSfKrO+Zv4svt7yB==zLVKq6TxuwyMZuG6ehetA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0473026787=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAJKuQOf7T7eiSfKrO+Zv4svt7yB==zLVKq6TxuwyMZuG6ehetA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Min Xu <min.xu.public-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0473026787==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB165259DBBCB8941EBFA9CBC2F7E50BN6PR12MB1652namp_"

--_000_BN6PR12MB165259DBBCB8941EBFA9CBC2F7E50BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please file a bug (https://bugs.freedesktop.org) and attach your xorg log (=
if using X) and your dmesg output along with a description of the problem. =
 Please also specify what GPU you are using.  If this a a Raven system, you=
'll need to make sure CONFIG_DRM_AMD_DC_DCN1_0 and CONFIG_DRM_AMD_DC are se=
t in your kernel config.


Thanks,


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Min Xu <=
min.xu.public-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, January 29, 2018 3:03:40 PM
To: Bridgman, John
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: Strange issue on Vega 8 Mobile (HP Envy x360 Laptop)

Thanks for explaining that firmware is not permanently loaded. Then, I have=
 no ideas. Do you need my dmesg output?

On Mon, Jan 29, 2018 at 12:02 PM, Min Xu <min.xu.public-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:mi=
n.xu.public-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
I am running archlinux, the firmware version is very new:

linux-firmware-20180119.2a713be-1


On Mon, Jan 29, 2018 at 12:01 PM, Bridgman, John <John.Bridgman-5C7GfCeVMHo@public.gmane.org<mai=
lto:John.Bridgman-5C7GfCeVMHo@public.gmane.org>> wrote:

Microcode for the GPU hardware blocks is not permanently updated in the chi=
p, but rather is loaded at power-up. Usually the files will be distributed =
via a package with a name like linux-firmware.



I didn't see a mention of which distro/version you are using but along with=
 new kernel you will need a relatively new version of linux-firmware.



From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>] On Behalf Of Min Xu
Sent: Monday, January 29, 2018 2:57 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Strange issue on Vega 8 Mobile (HP Envy x360 Laptop)



Dear AMD GFX developers,



I just got a HP Envy x360 laptop and I am trying to run linux on it. I want=
 to first thank you all for the great work on the amdgpu driver. Without it=
, people like me wants to run Linux would be stuck with windows.



I suspect that my issue is a new issue that hasn't been reported before, th=
erefore, I am writing to you to see if there indeed is a new issue and whet=
her there is a workaround.



I have compiled the latest kernel from the amd-staging-drm-next branch last=
 night. I think the kernel "works" with my GPU. The previous two kernels I =
tried (4.14 and 4.15 final release) either doesn't support this card or jus=
t simply hang the system most of the time.



The issue I have is that the graphic card seems to never switch to the high=
 resolution mode of the monitor. The kernel would boot with the default 800=
x600 VGA graphics and then stuck. The monitor continuous to display the con=
tent written to the 800x600 console (some kernel booting messages) after am=
dgpu takes over. I can see from kernel dmesg the amdgpu driver found my car=
d and initialized it and seems to be all happy about it. Yet, nothing new i=
s displayed on the monitor. The monitor just stuck at the content of the 80=
0x600 graphics.



The keyboard works in this situation. Kernel is alive and I can reboot it b=
y pressing <ctrl>+<alt>+<del> and I saw from the log file the system restar=
ts just fine.



I have tried different noobs of the amdgpu driver, like amdgpu.exp_hw_suppo=
rt=3D1, si_support=3D0, etc. Nothing seems to work. I just stuck with not a=
ble to switch to 1920x1080.



I suspect that this is related to my firmware version. I confirmed the late=
st firmware is installed on my /usr/lib/firmware/ dir. The reason I suspect=
 that it is a firmware issue is that I got the machine just 2 days ago and =
I have updated windows 10 to build 1709, which is very new. I suspect that =
windows have updated the GPU's firmware and the linux driver isn't working =
with it. If so, is there a way to force a firmware load from the linux side=
 (i.e. a downgrade).



Other users on the internet has report success with this particular machine=
 with 4.15 kernel. Given that 4.15 doesn't work for me, the only thing that=
 I could think of is the firmware version.



Any other ideas?





Thanks a lot,

Min





--_000_BN6PR12MB165259DBBCB8941EBFA9CBC2F7E50BN6PR12MB1652namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Please file a bug (<a href=3D"htt=
ps://bugs.freedesktop.org" class=3D"OWAAutoLink" id=3D"LPlnk197565" preview=
removed=3D"true">https://bugs.freedesktop.org</a>) and attach your xorg log=
 (if using X) and your dmesg output along
 with a description of the problem.&nbsp; Please also specify what GPU you =
are using.&nbsp; If this a a Raven system, you'll need to make sure&nbsp;<s=
pan>CONFIG_DRM_AMD_DC_DCN1_0</span> and&nbsp;<span>CONFIG_DRM_AMD_DC are se=
t in your kernel config.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Min Xu &lt;min.xu.public@gmai=
l.com&gt;<br>
<b>Sent:</b> Monday, January 29, 2018 3:03:40 PM<br>
<b>To:</b> Bridgman, John<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: Strange issue on Vega 8 Mobile (HP Envy x360 Laptop)</f=
ont>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">Thanks for explaining that firmware is not permanently loa=
ded. Then, I have no ideas. Do you need my dmesg output?</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">On Mon, Jan 29, 2018 at 12:02 PM, Min Xu <span=
 dir=3D"ltr">
&lt;<a href=3D"mailto:min.xu.public-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">min.xu.pub=
lic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">I am running archlinux, the firmware version is very new:
<div><br>
</div>
<div>linux-firmware-20180119.<wbr>2a713be-1<br>
</div>
<div><br>
</div>
</div>
<div class=3D"x_HOEnZb">
<div class=3D"x_h5">
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">On Mon, Jan 29, 2018 at 12:01 PM, Bridgman, Jo=
hn <span dir=3D"ltr">
&lt;<a href=3D"mailto:John.Bridgman-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">John.Bridgma=
n@amd.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
<div lang=3D"EN-US">
<div class=3D"x_m_7672285436398560458m_-6995857010834165525WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;; color:#1f497d">Microcode for the GPU=
 hardware blocks is not permanently updated in the chip, but rather is load=
ed at power-up. Usually the files will be distributed via
 a package with a name like linux-firmware. <u></u><u></u></span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;; color:#1f497d"><u></u>&nbsp;<u></u><=
/span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;; color:#1f497d">I didn't see a mentio=
n of which distro/version you are using but along with new kernel you will =
need a relatively new version of linux-firmware.<u></u><u></u></span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;; color:#1f497d"><u></u>&nbsp;<u></u><=
/span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #b5c4df 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:10.0pt; font-family:&q=
uot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"fon=
t-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-=
gfx [mailto:<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=
=3D"_blank">amd-gfx-bounces@lists.<wbr>freedesktop.org</a>]
<b>On Behalf Of </b>Min Xu<br>
<b>Sent:</b> Monday, January 29, 2018 2:57 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Strange issue on Vega 8 Mobile (HP Envy x360 Laptop)<u></u>=
<u></u></span></p>
</div>
</div>
<div>
<div class=3D"x_m_7672285436398560458h5">
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
<div>
<p class=3D"x_MsoNormal">Dear AMD GFX developers,<u></u><u></u></p>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">I just got a HP Envy x360 laptop and I am trying t=
o run linux on it. I want to first thank you all for the great work on the =
amdgpu driver. Without it, people like me wants to run Linux would be stuck=
 with windows.<u></u><u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">I suspect that my issue is a new issue that hasn't=
 been reported before, therefore, I am writing to you to see if there indee=
d is a new issue and whether there is a workaround.<u></u><u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">I have compiled the latest kernel from the amd-sta=
ging-drm-next branch last night. I think the kernel &quot;works&quot; with =
my GPU. The previous two kernels I tried (4.14 and 4.15 final release) eith=
er doesn't support this card or just simply
 hang the system most of the time.<u></u><u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">The issue I have is that the graphic card seems to=
 never switch to the high resolution mode of the monitor. The kernel would =
boot with the default 800x600 VGA graphics and then stuck. The monitor cont=
inuous to display the content written
 to the 800x600 console (some kernel booting messages) after amdgpu takes o=
ver. I can see from kernel dmesg the amdgpu driver found my card and initia=
lized it and seems to be all happy about it. Yet, nothing new is displayed =
on the monitor. The monitor just
 stuck at the content of the 800x600 graphics.<u></u><u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">The keyboard works in this situation. Kernel is al=
ive and I can reboot it by pressing &lt;ctrl&gt;&#43;&lt;alt&gt;&#43;&lt;de=
l&gt; and I saw from the log file the system restarts just fine.<u></u><u><=
/u></p>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">I have tried different noobs of the amdgpu driver,=
 like amdgpu.exp_hw_support=3D1, si_support=3D0, etc. Nothing seems to work=
. I just stuck with not able to switch to 1920x1080.<u></u><u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">I suspect that this is related to my firmware vers=
ion. I confirmed the latest firmware is installed on my /usr/lib/firmware/ =
dir. The reason I suspect that it is a firmware issue is that I got the mac=
hine just 2 days ago and I have updated
 windows 10 to build 1709, which is very new. I suspect that windows have u=
pdated the GPU's firmware and the linux driver isn't working with it. If so=
, is there a way to force a firmware load from the linux side (i.e. a downg=
rade).<u></u><u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">Other users on the internet has report success wit=
h this particular machine with 4.15 kernel. Given that 4.15 doesn't work fo=
r me, the only thing that I could think of is the firmware version.<u></u><=
u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">Any other ideas?<u></u><u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;<u></u><u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">Thanks a lot,<u></u><u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal">Min<u></u><u></u></p>
</div>
<div>
<p class=3D"x_MsoNormal"><u></u>&nbsp;<u></u></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB165259DBBCB8941EBFA9CBC2F7E50BN6PR12MB1652namp_--

--===============0473026787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0473026787==--
