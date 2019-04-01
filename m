From: =?iso-8859-9?Q?Utku_Helvac=FD?= <proje.pdf-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: RX 540 gpu kernel bug, bisected
Date: Mon, 1 Apr 2019 18:25:46 +0000
Message-ID: <AM0PR03MB57647089521674D65F900795E2550@AM0PR03MB5764.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1742390794=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: tr-TR
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
To: "rex.zhu-5C7GfCeVMHo@public.gmane.org" <rex.zhu-5C7GfCeVMHo@public.gmane.org>, "evan.quan-5C7GfCeVMHo@public.gmane.org" <evan.quan-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David1.Zhou-5C7GfCeVMHo@public.gmane.org" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--===============1742390794==
Content-Language: tr-TR
Content-Type: multipart/alternative;
	boundary="_000_AM0PR03MB57647089521674D65F900795E2550AM0PR03MB5764eurp_"

--_000_AM0PR03MB57647089521674D65F900795E2550AM0PR03MB5764eurp_
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable

I have finally bisected the bug i have reported here: https://bugzilla.kern=
el.org/show_bug.cgi?id=3D201077

log files of individual tests are here: https://github.com/tuxutku/rx_540_k=
ernel_bisecting_files/


###################
[utku2@utku2 linux]$ git bisect bad
e1deba285156fb4023bb48f22068de5b60e34e15 is the first bad commit
commit e1deba285156fb4023bb48f22068de5b60e34e15
Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Date:   Tue Feb 27 18:27:54 2018 +0800

    drm/amd/pp: Use amdgpu acpi helper functions in powerplay

    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

:040000 040000 b8e6fd4f5269564ff9dba96359c4f26b02f68b4a
e3555ae88191d1a060f67998dabf977551d3a127 M drivers
[utku2@utku2 linux]$ git bisect log
# bad: [320b164abb32db876866a4ff8c2cb710524ac6ea] Merge tag
'drm-for-v4.17' of git://people.freedesktop.org/~airlied/linux
# good: [0adb32858b0bddf4ada5f364a84ed60b196dbcda] Linux 4.16
git bisect start '320b164abb32db876866a4ff8c2cb710524ac6ea'
'0adb32858b0bddf4ada5f364a84ed60b196dbcda' '--' 'drivers/gpu/drm/amd'
# good: [9021d2edd259d992cf8b5b48791ab50829129de7] drm/amdgpu: mitigate
workaround for i915
git bisect good 9021d2edd259d992cf8b5b48791ab50829129de7
# bad: [aa5a5777304228819a52562d346bc3eb1b4873fa] drm/amd/display:
Vari-bright looks disabled near end of MM14
git bisect bad aa5a5777304228819a52562d346bc3eb1b4873fa
# good: [81988f9c3d9907d7df0ea97e8e4842064b88b7b8] drm/amdgpu: use
separate status for buffer funcs availability v2
git bisect good 81988f9c3d9907d7df0ea97e8e4842064b88b7b8
# bad: [128ccceaba8656573b8b0f86d3ab6e38094cc754] Merge branch
'drm-next-4.17' of git://people.freedesktop.org/~agd5f/linux into
drm-next
git bisect bad 128ccceaba8656573b8b0f86d3ab6e38094cc754
# bad: [180a8bebdd50fc8ce4677e579d49d9b73880caa7] drm/amd/pp: Fix sclk
in highest two levels when compute on smu7
git bisect bad 180a8bebdd50fc8ce4677e579d49d9b73880caa7
# bad: [ada6770e956b7f7d298bfef56fed457ade5bad9e] drm/amd/pp: Remove
cgs_query_system_info
git bisect bad ada6770e956b7f7d298bfef56fed457ade5bad9e
# good: [a2c120ce6b686c753968b7b1293c7bb878440b7f] drm/amd/pp: Simplify
the create of powerplay instance
git bisect good a2c120ce6b686c753968b7b1293c7bb878440b7f
# good: [589941e1a2d65f5425c91a5859a5454df64b6982] drm/amdgpu: Notify
sbios device ready before send request
git bisect good 589941e1a2d65f5425c91a5859a5454df64b6982
# bad: [6848d73e889bb29cfede51df8c1d0496c9787454] drm/amd/pp: Remove the
wrap functions for acpi in powerplay
git bisect bad 6848d73e889bb29cfede51df8c1d0496c9787454
# bad: [e1deba285156fb4023bb48f22068de5b60e34e15] drm/amd/pp: Use amdgpu
acpi helper functions in powerplay
git bisect bad e1deba285156fb4023bb48f22068de5b60e34e15
# first bad commit: [e1deba285156fb4023bb48f22068de5b60e34e15]
drm/amd/pp: Use amdgpu acpi helper functions in powerplay
[utku2@utku2 linux]$


--_000_AM0PR03MB57647089521674D65F900795E2550AM0PR03MB5764eurp_
Content-Type: text/html; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
9">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
I have finally bisected the bug i have reported here: <a href=3D"https://bu=
gzilla.kernel.org/show_bug.cgi?id=3D201077" id=3D"LPlnk709147">
https://bugzilla.kernel.org/show_bug.cgi?id=3D201077</a><br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
log files of individual tests are here: <a href=3D"https://github.com/tuxut=
ku/rx_540_kernel_bisecting_files/" id=3D"LPlnk794366">
https://github.com/tuxutku/rx_540_kernel_bisecting_files/</a><br>
</div>
<br>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
###################</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span>[utku2@utku2 linux]$ git bisect bad<br>
</span>
<div>e1deba285156fb4023bb48f22068de5b60e34e15 is the first bad commit<br>
</div>
<div>commit e1deba285156fb4023bb48f22068de5b60e34e15<br>
</div>
<div>Author: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div>Date: &nbsp; Tue Feb 27 18:27:54 2018 &#43;0800<br>
</div>
<div><br>
</div>
<div>&nbsp; &nbsp; drm/amd/pp: Use amdgpu acpi helper functions in powerpla=
y<br>
</div>
<div>&nbsp; &nbsp; <br>
</div>
<div>&nbsp; &nbsp; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&=
gt;<br>
</div>
<div>&nbsp; &nbsp; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div>&nbsp; &nbsp; Signed-off-by: Alex Deucher &lt;alexander.deucher-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
</div>
<div><br>
</div>
<div>:040000 040000 b8e6fd4f5269564ff9dba96359c4f26b02f68b4a <br>
</div>
<div>e3555ae88191d1a060f67998dabf977551d3a127 M drivers<br>
</div>
<div>[utku2@utku2 linux]$ git bisect log<br>
</div>
<div># bad: [320b164abb32db876866a4ff8c2cb710524ac6ea] Merge tag <br>
</div>
<div>'drm-for-v4.17' of git://people.freedesktop.org/~airlied/linux<br>
</div>
<div># good: [0adb32858b0bddf4ada5f364a84ed60b196dbcda] Linux 4.16<br>
</div>
<div>git bisect start '320b164abb32db876866a4ff8c2cb710524ac6ea' <br>
</div>
<div>'0adb32858b0bddf4ada5f364a84ed60b196dbcda' '--' 'drivers/gpu/drm/amd'<=
br>
</div>
<div># good: [9021d2edd259d992cf8b5b48791ab50829129de7] drm/amdgpu: mitigat=
e <br>
</div>
<div>workaround for i915<br>
</div>
<div>git bisect good 9021d2edd259d992cf8b5b48791ab50829129de7<br>
</div>
<div># bad: [aa5a5777304228819a52562d346bc3eb1b4873fa] drm/amd/display: <br=
>
</div>
<div>Vari-bright looks disabled near end of MM14<br>
</div>
<div>git bisect bad aa5a5777304228819a52562d346bc3eb1b4873fa<br>
</div>
<div># good: [81988f9c3d9907d7df0ea97e8e4842064b88b7b8] drm/amdgpu: use <br=
>
</div>
<div>separate status for buffer funcs availability v2<br>
</div>
<div>git bisect good 81988f9c3d9907d7df0ea97e8e4842064b88b7b8<br>
</div>
<div># bad: [128ccceaba8656573b8b0f86d3ab6e38094cc754] Merge branch <br>
</div>
<div>'drm-next-4.17' of git://people.freedesktop.org/~agd5f/linux into <br>
</div>
<div>drm-next<br>
</div>
<div>git bisect bad 128ccceaba8656573b8b0f86d3ab6e38094cc754<br>
</div>
<div># bad: [180a8bebdd50fc8ce4677e579d49d9b73880caa7] drm/amd/pp: Fix sclk=
 <br>
</div>
<div>in highest two levels when compute on smu7<br>
</div>
<div>git bisect bad 180a8bebdd50fc8ce4677e579d49d9b73880caa7<br>
</div>
<div># bad: [ada6770e956b7f7d298bfef56fed457ade5bad9e] drm/amd/pp: Remove <=
br>
</div>
<div>cgs_query_system_info<br>
</div>
<div>git bisect bad ada6770e956b7f7d298bfef56fed457ade5bad9e<br>
</div>
<div># good: [a2c120ce6b686c753968b7b1293c7bb878440b7f] drm/amd/pp: Simplif=
y <br>
</div>
<div>the create of powerplay instance<br>
</div>
<div>git bisect good a2c120ce6b686c753968b7b1293c7bb878440b7f<br>
</div>
<div># good: [589941e1a2d65f5425c91a5859a5454df64b6982] drm/amdgpu: Notify =
<br>
</div>
<div>sbios device ready before send request<br>
</div>
<div>git bisect good 589941e1a2d65f5425c91a5859a5454df64b6982<br>
</div>
<div># bad: [6848d73e889bb29cfede51df8c1d0496c9787454] drm/amd/pp: Remove t=
he <br>
</div>
<div>wrap functions for acpi in powerplay<br>
</div>
<div>git bisect bad 6848d73e889bb29cfede51df8c1d0496c9787454<br>
</div>
<div># bad: [e1deba285156fb4023bb48f22068de5b60e34e15] drm/amd/pp: Use amdg=
pu <br>
</div>
<div>acpi helper functions in powerplay<br>
</div>
<div>git bisect bad e1deba285156fb4023bb48f22068de5b60e34e15<br>
</div>
<div># first bad commit: [e1deba285156fb4023bb48f22068de5b60e34e15] <br>
</div>
<div>drm/amd/pp: Use amdgpu acpi helper functions in powerplay<br>
</div>
<div>[utku2@utku2 linux]$ <br>
</div>
<span></span><br>
</div>
</body>
</html>

--_000_AM0PR03MB57647089521674D65F900795E2550AM0PR03MB5764eurp_--

--===============1742390794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1742390794==--
