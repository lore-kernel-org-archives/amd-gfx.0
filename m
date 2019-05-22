From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: WARNING: locking bug in inet_autobind
Date: Wed, 22 May 2019 03:21:15 +0000
Message-ID: <DM6PR12MB27788B3B39A41027C62CEF5EF0000@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <00000000000033a0120588fac894@google.com>,
 <0000000000008b645c058971629b@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1655426836=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0000000000008b645c058971629b-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
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
To: syzbot <syzbot+94cc2a66fc228b23f360-Pl5Pbv+GP7P466ipTTIvnc23WoclnBCfAL8bYrjMMd8@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>, "daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org" <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, "davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Quan,
 Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "kafai-b10kYP2dOMg@public.gmane.org" <kafai-b10kYP2dOMg@public.gmane.org>, "kuznet-v/Mj1YrvjDBInbfyfbPRSQ@public.gmane.org" <kuznet-v/Mj1YrvjDBInbfyfbPRSQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>"netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <net>

--===============1655426836==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB27788B3B39A41027C62CEF5EF0000DM6PR12MB2778namp_"

--_000_DM6PR12MB27788B3B39A41027C62CEF5EF0000DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This commit was reverted later. I guess the revert was probably not picked =
up properly.

Regards,
Yong
________________________________
From: syzbot <syzbot+94cc2a66fc228b23f360-Pl5Pbv+GP7P466ipTTIvnc23WoclnBCfAL8bYrjMMd8@public.gmane.org>
Sent: Tuesday, May 21, 2019 11:16 PM
To: Zhao, Yong; airlied-cv59FeDIM0c@public.gmane.org; Deucher, Alexander; amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org; ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Koenig, Christian; daniel@ff=
wll.ch; daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org; davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org; Zhou, David(ChunMing); d=
ri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Quan, Evan; Kuehling, Felix; Wentland, Harr=
y; kafai-b10kYP2dOMg@public.gmane.org; kuznet-v/Mj1YrvjDBInbfyfbPRSQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; netdev=
@vger.kernel.org; Zeng, Oak; Huang, Ray; rex.zhu-5C7GfCeVMHo@public.gmane.org; songliubraving@fb=
.com; syzkaller-bugs-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; yhs-b10kYP2dOMg@public.gmane.org; Zhao, Yong; yoshfuji@lin=
ux-ipv6.org
Subject: Re: WARNING: locking bug in inet_autobind

[CAUTION: External Email]

syzbot has bisected this bug to:

commit c0d9271ecbd891cdeb0fad1edcdd99ee717a655f
Author: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Date:   Fri Feb 1 23:36:21 2019 +0000

     drm/amdgpu: Delete user queue doorbell variables

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1433ece4a000=
00
start commit:   f49aa1de Merge tag 'for-5.2-rc1-tag' of git://git.kernel.o.=
.
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D1633ece4a000=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D1233ece4a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfc045131472947d=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D94cc2a66fc228b23f=
360
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D163731f8a0000=
0

Reported-by: syzbot+94cc2a66fc228b23f360-Pl5Pbv+GP7P466ipTTIvnc23WoclnBCfAL8bYrjMMd8@public.gmane.org
Fixes: c0d9271ecbd8 ("drm/amdgpu: Delete user queue doorbell variables")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

--_000_DM6PR12MB27788B3B39A41027C62CEF5EF0000DM6PR12MB2778namp_
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
This commit was reverted later. I guess the revert was probably not picked =
up properly.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> syzbot &lt;syzbot&#43=
;94cc2a66fc228b23f360-Pl5Pbv+GP7P466ipTTIvnc23WoclnBCfAL8bYrjMMd8@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, May 21, 2019 11:16 PM<br>
<b>To:</b> Zhao, Yong; airlied-cv59FeDIM0c@public.gmane.org; Deucher, Alexander; amd-gfx@lists.=
freedesktop.org; ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Koenig, Christian; da=
niel-/w4YWyX8dFk@public.gmane.org; daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org; davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org; Zhou, David(ChunM=
ing); dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org;
 Quan, Evan; Kuehling, Felix; Wentland, Harry; kafai-b10kYP2dOMg@public.gmane.org; kuznet-BV4Dd6KD/ZI@public.gmane.org=
.ac.ru; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Zeng, Oak; Hu=
ang, Ray; rex.zhu-5C7GfCeVMHo@public.gmane.org; songliubraving-b10kYP2dOMg@public.gmane.org; syzkaller-bugs@googlegrou=
ps.com; yhs-b10kYP2dOMg@public.gmane.org; Zhao, Yong;
 yoshfuji-VfPWfsRibaP+Ru+s062T9g@public.gmane.org<br>
<b>Subject:</b> Re: WARNING: locking bug in inet_autobind</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[CAUTION: External Email]<br>
<br>
syzbot has bisected this bug to:<br>
<br>
commit c0d9271ecbd891cdeb0fad1edcdd99ee717a655f<br>
Author: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
Date:&nbsp;&nbsp; Fri Feb 1 23:36:21 2019 &#43;0000<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm/amdgpu: Delete user queue doorbell variables<b=
r>
<br>
bisection log:&nbsp; <a href=3D"https://syzkaller.appspot.com/x/bisect.txt?=
x=3D1433ece4a00000">
https://syzkaller.appspot.com/x/bisect.txt?x=3D1433ece4a00000</a><br>
start commit:&nbsp;&nbsp; f49aa1de Merge tag 'for-5.2-rc1-tag' of git://git=
.kernel.o..<br>
git tree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; net-next<br>
final crash:&nbsp;&nbsp;&nbsp; <a href=3D"https://syzkaller.appspot.com/x/r=
eport.txt?x=3D1633ece4a00000">
https://syzkaller.appspot.com/x/report.txt?x=3D1633ece4a00000</a><br>
console output: <a href=3D"https://syzkaller.appspot.com/x/log.txt?x=3D1233=
ece4a00000">
https://syzkaller.appspot.com/x/log.txt?x=3D1233ece4a00000</a><br>
kernel config:&nbsp; <a href=3D"https://syzkaller.appspot.com/x/.config?x=
=3Dfc045131472947d7">
https://syzkaller.appspot.com/x/.config?x=3Dfc045131472947d7</a><br>
dashboard link: <a href=3D"https://syzkaller.appspot.com/bug?extid=3D94cc2a=
66fc228b23f360">
https://syzkaller.appspot.com/bug?extid=3D94cc2a66fc228b23f360</a><br>
syz repro:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://syzkaller.appsp=
ot.com/x/repro.syz?x=3D163731f8a00000">
https://syzkaller.appspot.com/x/repro.syz?x=3D163731f8a00000</a><br>
<br>
Reported-by: syzbot&#43;94cc2a66fc228b23f360-Pl5Pbv+GP7P466ipTTIvnc23WoclnBCfAL8bYrjMMd8@public.gmane.org<br>
Fixes: c0d9271ecbd8 (&quot;drm/amdgpu: Delete user queue doorbell variables=
&quot;)<br>
<br>
For information about bisection process see: <a href=3D"https://goo.gl/tpsm=
EJ#bisection">
https://goo.gl/tpsmEJ#bisection</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB27788B3B39A41027C62CEF5EF0000DM6PR12MB2778namp_--

--===============1655426836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1655426836==--
