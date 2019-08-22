From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: atombios stuck executing D850 when trying to switch to 4k@60Hz on
 Polaris10
Date: Thu, 22 Aug 2019 12:45:43 +0000
Message-ID: <BN6PR12MB1809DE32DBA7017A974E8BDAF7A50@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <CAFvQSYT+Qd8_tE7yvnjLt8RAduAEwUOuh3rvh0X7e3--LqQ78w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1689185196=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFvQSYT+Qd8_tE7yvnjLt8RAduAEwUOuh3rvh0X7e3--LqQ78w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Clemens Eisserer <linuxhippy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1689185196==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809DE32DBA7017A974E8BDAF7A50BN6PR12MB1809namp_"

--_000_BN6PR12MB1809DE32DBA7017A974E8BDAF7A50BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

You need to use dc to support 4k@60.  Remove amdgpu.dc=3D0 from the kernel =
command line in grub.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Clemens =
Eisserer <linuxhippy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, August 22, 2019 4:39 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: atombios stuck executing D850 when trying to switch to 4k@60Hz on =
Polaris10

Hi there,

I am trying to connect a LG 32UD59 UHD monitor to a MSI Armor RX570 4G
card via a HDMI2 (cheap) certified cable.
Unfourtunatly the setup only runs at 30Hz, whereas when booting
Windows it automatically selects 3840x2160@59Hz.

I played a bit with adding the modelines manually, however when
enabling those new modes the screen goes black and in syslog I find
the following entries:

[  571.174813] [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in
loop for more than 5secs aborting
[  571.174862] [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR*
atombios stuck executing D850 (len 824, WS 0, PS 0) @ 0xD992
[  571.174908] [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR*
atombios stuck executing D70A (len 326, WS 0, PS 0) @ 0xD7A6

Xorg.0.log: https://pastebin.com/LmZ0bvyL
kernel log: https://pastebin.com/rXGVMTnV

Help would be really appreciated - I am rather latency sensitive and
those 30Hz are driving me nuts ;)

Best regards, Clemens
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809DE32DBA7017A974E8BDAF7A50BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You need to use dc to support 4k@60.&nbsp; Remove amdgpu.dc=3D0 from the ke=
rnel command line in grub.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Clemens Eisserer &lt;linuxhip=
py-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 22, 2019 4:39 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Subject:</b> atombios stuck executing D850 when trying to switch to 4k@6=
0Hz on Polaris10</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi there,<br>
<br>
I am trying to connect a LG 32UD59 UHD monitor to a MSI Armor RX570 4G<br>
card via a HDMI2 (cheap) certified cable.<br>
Unfourtunatly the setup only runs at 30Hz, whereas when booting<br>
Windows it automatically selects 3840x2160@59Hz.<br>
<br>
I played a bit with adding the modelines manually, however when<br>
enabling those new modes the screen goes black and in syslog I find<br>
the following entries:<br>
<br>
[&nbsp; 571.174813] [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in<b=
r>
loop for more than 5secs aborting<br>
[&nbsp; 571.174862] [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR*=
<br>
atombios stuck executing D850 (len 824, WS 0, PS 0) @ 0xD992<br>
[&nbsp; 571.174908] [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR*=
<br>
atombios stuck executing D70A (len 326, WS 0, PS 0) @ 0xD7A6<br>
<br>
Xorg.0.log: <a href=3D"https://pastebin.com/LmZ0bvyL">https://pastebin.com/=
LmZ0bvyL</a><br>
kernel log: <a href=3D"https://pastebin.com/rXGVMTnV">https://pastebin.com/=
rXGVMTnV</a><br>
<br>
Help would be really appreciated - I am rather latency sensitive and<br>
those 30Hz are driving me nuts ;)<br>
<br>
Best regards, Clemens<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809DE32DBA7017A974E8BDAF7A50BN6PR12MB1809namp_--

--===============1689185196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1689185196==--
