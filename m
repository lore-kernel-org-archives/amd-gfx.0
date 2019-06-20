From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/amd/display: Enable fast plane updates when
 state->allow_modeset = true"
Date: Thu, 20 Jun 2019 14:35:06 +0000
Message-ID: <BN6PR12MB1809A334E8D4AB00D4BCB178F7E40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190620123403.10252-1-nicholas.kazlauskas@amd.com>,
 <BN8PR12MB3217FE6149291E3A7D053139EFE40@BN8PR12MB3217.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0426642754=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN8PR12MB3217FE6149291E3A7D053139EFE40-h6+T2+wrnx1RCczRXbE7rwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============0426642754==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809A334E8D4AB00D4BCB178F7E40BN6PR12MB1809namp_"

--_000_BN6PR12MB1809A334E8D4AB00D4BCB178F7E40BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Is there a bugzilla this fixes?  If so, can you add a link?

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Francis,=
 David <David.Francis-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, June 20, 2019 9:43 AM
To: Kazlauskas, Nicholas; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Wentland, Harry
Subject: Re: [PATCH] Revert "drm/amd/display: Enable fast plane updates whe=
n state->allow_modeset =3D true"


Reviewed-by: David Francis <david.francis-5C7GfCeVMHo@public.gmane.org>



________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Nicholas=
 Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Sent: June 20, 2019 8:34:03 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Francis, David; Wentland, Harry; Kazlauskas, Nicholas
Subject: [PATCH] Revert "drm/amd/display: Enable fast plane updates when st=
ate->allow_modeset =3D true"

This reverts commit ebc8c6f18322ad54275997a888ca1731d74b711f.

There are still missing corner cases with cursor interaction and these
fast plane updates on Picasso and Raven2 leading to endless PSTATE
warnings for typical desktop usage depending on the userspace.

This change should be reverted until these issues have been resolved.

Cc: David Francis <david.francis-5C7GfCeVMHo@public.gmane.org>
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 33dcd4187157..d6acbcfa570c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6471,6 +6471,14 @@ static bool should_reset_plane(struct drm_atomic_sta=
te *state,
         struct drm_crtc_state *new_crtc_state;
         int i;

+       /*
+        * TODO: Remove this hack once the checks below are sufficient
+        * enough to determine when we need to reset all the planes on
+        * the stream.
+        */
+       if (state->allow_modeset)
+               return true;
+
         /* Exit early if we know that we're adding or removing the plane. =
*/
         if (old_plane_state->crtc !=3D new_plane_state->crtc)
                 return true;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809A334E8D4AB00D4BCB178F7E40BN6PR12MB1809namp_
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
Is there a bugzilla this fixes?&nbsp; If so, can you add a link?</div>
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Francis, David &lt;David.Fran=
cis-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, June 20, 2019 9:43 AM<br>
<b>To:</b> Kazlauskas, Nicholas; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Wentland, Harry<br>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amd/display: Enable fast plane=
 updates when state-&gt;allow_modeset =3D true&quot;</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">Reviewed-by: David Francis &lt;d=
avid.francis-5C7GfCeVMHo@public.gmane.org&gt;</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Nicholas Kazlauskas &lt;nic=
holas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> June 20, 2019 8:34:03 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Francis, David; Wentland, Harry; Kazlauskas, Nicholas<br>
<b>Subject:</b> [PATCH] Revert &quot;drm/amd/display: Enable fast plane upd=
ates when state-&gt;allow_modeset =3D true&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">This reverts commit ebc8c6f18322ad54275997a888ca=
1731d74b711f.<br>
<br>
There are still missing corner cases with cursor interaction and these<br>
fast plane updates on Picasso and Raven2 leading to endless PSTATE<br>
warnings for typical desktop usage depending on the userspace.<br>
<br>
This change should be reverted until these issues have been resolved.<br>
<br>
Cc: David Francis &lt;david.francis-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 8 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 33dcd4187157..d6acbcfa570c 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -6471,6 &#43;6471,14 @@ static bool should_reset_plane(struct drm_atomic=
_state *state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc_state *new=
_crtc_state;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: Remove this hack on=
ce the checks below are sufficient<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * enough to determine when =
we need to reset all the planes on<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the stream.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state-&gt;allow_modeset)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Exit early if we know t=
hat we're adding or removing the plane. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old_plane_state-&gt;cr=
tc !=3D new_plane_state-&gt;crtc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB1809A334E8D4AB00D4BCB178F7E40BN6PR12MB1809namp_--

--===============0426642754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0426642754==--
