From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Ryzen 5 2400g - colors/contrast messed up on amd-staging-drm-next
 and drm-next-4.17-wip
Date: Thu, 8 Mar 2018 14:28:27 +0000
Message-ID: <BN6PR12MB16523CC0AC34F2ABF75ADEB2F7DF0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <CABKQyRqt=jucZHmaDN9xdDeb-mWRmKDTL0yh9jmwDL=GqLzXeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1323352493=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CABKQyRqt=jucZHmaDN9xdDeb-mWRmKDTL0yh9jmwDL=GqLzXeg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?iso-8859-2?Q?Hubert_=A3=EApicki?= <hubert.lepicki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>

--===============1323352493==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16523CC0AC34F2ABF75ADEB2F7DF0BN6PR12MB1652namp_"

--_000_BN6PR12MB16523CC0AC34F2ABF75ADEB2F7DF0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

+ Harry, Leo


I saw this as well with tonga.  It seems to be related to the CTM/regamma c=
hanges.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Hubert =
=A3=EApicki <hubert.lepicki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, March 8, 2018 7:03:06 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Ryzen 5 2400g - colors/contrast messed up on amd-staging-drm-next =
and drm-next-4.17-wip

Hey,

I was giving a shot your work in progress branch for the AMDGPU
driver, hoping maybe it brings some fixes to Ryzen 5 2400g. It does
not look like it, but I might have discovered a bug (or you may be
well aware of it since it's work in progress...). Either way, just to
let you know:

Graphics is sort of messed up on drm-next-4.17-wip and
amd-staging-drm-next branches on my Ryzen 5 2400g. I am attaching
screenshots.

Correct colors/contrast on Ubuntu 18.04 / stock 4.15 kernel:
https://photos.app.goo.gl/3IXkgOXh955vygff2
https://photos.app.goo.gl/rD2aw7jvO6cbbTLh2
https://photos.app.goo.gl/3IXkgOXh955vygff2
https://photos.app.goo.gl/xLYC9N7drU687L8o2

Incorrect colors/contrast on Ubuntu 18.04 / amd-staging-drm-next branch:
https://photos.app.goo.gl/nDXM7LFgnkRDMtoh1
https://photos.app.goo.gl/aG94pY4o4L1zaLAj2
https://photos.app.goo.gl/FogNie21obF9w0ek2
https://photos.app.goo.gl/PHiQ9Npgo24DnoDD2


These are photos taken with a phone camera, as on any captured
screenshots everything is fine.

I can provide better / detailed photos if you need me to.

This has been observed on Ubuntu 18.04, and Arch Linux, Gigabyte
AB350m-gaming3, Ryzen 5 2400g, on both Wayland and Xorg.

Hope that helps,
All the best,
Hubert =A3epicki

--
Pozdrawiam,
Hubert =A3=EApicki
 -----------------------------------------------
[ http://hubertlepicki.com ]
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16523CC0AC34F2ABF75ADEB2F7DF0BN6PR12MB1652namp_
Content-Type: text/html; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
2">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">&#43; Harry, Leo</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I saw this as well with tonga.&nb=
sp; It seems to be related to the CTM/regamma changes.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Hubert =A3=EApicki &lt;hubert=
.lepicki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, March 8, 2018 7:03:06 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Ryzen 5 2400g - colors/contrast messed up on amd-staging-dr=
m-next and drm-next-4.17-wip</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hey,<br>
<br>
I was giving a shot your work in progress branch for the AMDGPU<br>
driver, hoping maybe it brings some fixes to Ryzen 5 2400g. It does<br>
not look like it, but I might have discovered a bug (or you may be<br>
well aware of it since it's work in progress...). Either way, just to<br>
let you know:<br>
<br>
Graphics is sort of messed up on drm-next-4.17-wip and<br>
amd-staging-drm-next branches on my Ryzen 5 2400g. I am attaching<br>
screenshots.<br>
<br>
Correct colors/contrast on Ubuntu 18.04 / stock 4.15 kernel:<br>
<a href=3D"https://photos.app.goo.gl/3IXkgOXh955vygff2">https://photos.app.=
goo.gl/3IXkgOXh955vygff2</a><br>
<a href=3D"https://photos.app.goo.gl/rD2aw7jvO6cbbTLh2">https://photos.app.=
goo.gl/rD2aw7jvO6cbbTLh2</a><br>
<a href=3D"https://photos.app.goo.gl/3IXkgOXh955vygff2">https://photos.app.=
goo.gl/3IXkgOXh955vygff2</a><br>
<a href=3D"https://photos.app.goo.gl/xLYC9N7drU687L8o2">https://photos.app.=
goo.gl/xLYC9N7drU687L8o2</a><br>
<br>
Incorrect colors/contrast on Ubuntu 18.04 / amd-staging-drm-next branch:<br=
>
<a href=3D"https://photos.app.goo.gl/nDXM7LFgnkRDMtoh1">https://photos.app.=
goo.gl/nDXM7LFgnkRDMtoh1</a><br>
<a href=3D"https://photos.app.goo.gl/aG94pY4o4L1zaLAj2">https://photos.app.=
goo.gl/aG94pY4o4L1zaLAj2</a><br>
<a href=3D"https://photos.app.goo.gl/FogNie21obF9w0ek2">https://photos.app.=
goo.gl/FogNie21obF9w0ek2</a><br>
<a href=3D"https://photos.app.goo.gl/PHiQ9Npgo24DnoDD2">https://photos.app.=
goo.gl/PHiQ9Npgo24DnoDD2</a><br>
<br>
<br>
These are photos taken with a phone camera, as on any captured<br>
screenshots everything is fine.<br>
<br>
I can provide better / detailed photos if you need me to.<br>
<br>
This has been observed on Ubuntu 18.04, and Arch Linux, Gigabyte<br>
AB350m-gaming3, Ryzen 5 2400g, on both Wayland and Xorg.<br>
<br>
Hope that helps,<br>
All the best,<br>
Hubert =A3epicki<br>
<br>
-- <br>
Pozdrawiam,<br>
Hubert =A3=EApicki<br>
&nbsp;-----------------------------------------------<br>
[ <a href=3D"http://hubertlepicki.com">http://hubertlepicki.com</a> ]<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB16523CC0AC34F2ABF75ADEB2F7DF0BN6PR12MB1652namp_--

--===============1323352493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1323352493==--
