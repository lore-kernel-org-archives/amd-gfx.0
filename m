From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Issue with amd-staging-4.7 on rx480
Date: Thu, 6 Oct 2016 13:41:06 +0000
Message-ID: <CY4PR12MB1768EB91BA59663BC700C2AAF7C70@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <CAHOSEu8-fa0RznKX7s-vbU_1g_eCaa-ZBp=0ySP5X_VqJA13Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1322073627=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHOSEu8-fa0RznKX7s-vbU_1g_eCaa-ZBp=0ySP5X_VqJA13Ng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Jeremy Newton <alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1322073627==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768EB91BA59663BC700C2AAF7C70CY4PR12MB1768namp_"

--_000_CY4PR12MB1768EB91BA59663BC700C2AAF7C70CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

If I read this correctly you reverted the commit which enables UVD PG on To=
nga?  I can't see how that impacts Polaris at all.


If I had to guess it's a dGPU state issue.  I've had on occasion to resort =
to cold reboots to bisect the kernel because the GPU firmware can get into =
states that aren't 100% resolved by a warm reboot.


There is a known bad commit which was reverted by Christian which I guess i=
sn't out on fdo yet.  https://cgit.freedesktop.org/~agd5f/linux/commit/?h=
=3Damd-staging-4.7&id=3D6691270952b6909218c520dcc71a342070c96874 that commi=
t seems to break dGPU support.


Cheers,

Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Jeremy N=
ewton <alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, October 5, 2016 22:54
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Issue with amd-staging-4.7 on rx480

Hello,

I'm currently regularly building and using the amd-staging-4.7 linux branch=
, which can be found here:

https://cgit.freedesktop.org/~agd5f/linux/log/?h=3Damd-staging-4.7

It seems that one of the commits pushed on 2016-10-03 broke something, and =
I just wanted to give the devs a heads up in case no one noticed. I'm guess=
ing it was caused by one of the commits in the range of e3bb40f all the way=
 up to 78d1842.

I'm using an RX480, polaris10. The issue seems to have two symptoms:
- Plymouth (the boot splash screen) seems to get visually corrupted or just=
 blacked out.
- After login, the screen just remains black until I hard reset.

Reverting back to 8f877a8 seems to fix it. I'm using Fedora 24 with GNOME. =
As well, I haven't had time to bisect, but I can do so if desired.

Thanks!

--_000_CY4PR12MB1768EB91BA59663BC700C2AAF7C70CY4PR12MB1768namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>If I read this correctly you reverted the commit which enables UVD PG on=
 Tonga? &nbsp;I can't see how that impacts Polaris at all. &nbsp;</p>
<p><br>
</p>
<p>If I had to guess it's a dGPU state issue. &nbsp;I've had on occasion to=
 resort to cold reboots to bisect the kernel because the GPU firmware can g=
et into states that aren't 100% resolved by a warm reboot.</p>
<p><br>
</p>
<p>There is a known bad commit which was reverted by Christian which I gues=
s isn't out on fdo yet. &nbsp;<a href=3D"https://cgit.freedesktop.org/~agd5=
f/linux/commit/?h=3Damd-staging-4.7&amp;id=3D6691270952b6909218c520dcc71a34=
2070c96874" class=3D"OWAAutoLink" id=3D"LPlnk533633" previewremoved=3D"true=
">https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Damd-staging-4.7&amp=
;id=3D6691270952b6909218c520dcc71a342070c96874</a>&nbsp;that
 commit seems to break dGPU support.</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Jeremy Newton &lt;alexjnewt@g=
mail.com&gt;<br>
<b>Sent:</b> Wednesday, October 5, 2016 22:54<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Issue with amd-staging-4.7 on rx480</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div><span style=3D"text-align:right">
<div style=3D"text-align:start">Hello,</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">I'm currently regularly building and using =
the amd-staging-4.7 linux branch, which can be found here:</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start"><a href=3D"https://cgit.freedesktop.org/~ag=
d5f/linux/log/?h=3Damd-staging-4.7" id=3D"LPlnk449083" previewremoved=3D"tr=
ue">https://cgit.freedesktop.org/~agd5f/linux/log/?h=3Damd-staging-4.7</a><=
/div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">It seems that one of the commits pushed on =
2016-10-03 broke something, and I just wanted to give the devs a heads up i=
n case no one noticed. I'm guessing it was caused by one of the commits in =
the range of e3bb40f all the way up
 to 78d1842.</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">I'm using an RX480, polaris10. The issue se=
ems to have two symptoms:</div>
<div style=3D"text-align:start">- Plymouth (the boot splash screen) seems t=
o get visually corrupted or just blacked out.</div>
<div style=3D"text-align:start">- After login, the screen just remains blac=
k until I hard reset.</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">Reverting back to 8f877a8 seems to fix it. =
I'm using Fedora 24 with GNOME. As well, I haven't had time to bisect, but =
I can do so if desired.</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">Thanks!</div>
</span></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1768EB91BA59663BC700C2AAF7C70CY4PR12MB1768namp_--

--===============1322073627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1322073627==--
