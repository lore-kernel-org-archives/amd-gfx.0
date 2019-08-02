From: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/display: Block immediate flips for non-fast
 updates
Date: Fri, 2 Aug 2019 15:24:08 +0000
Message-ID: <BN8PR12MB3217B2D3CE3341BE111B314CEFD90@BN8PR12MB3217.namprd12.prod.outlook.com>
References: <20190802151150.26628-1-nicholas.kazlauskas@amd.com>,
 <20190802151150.26628-2-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1154488033=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190802151150.26628-2-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>

--===============1154488033==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB3217B2D3CE3341BE111B314CEFD90BN8PR12MB3217namp_"

--_000_BN8PR12MB3217B2D3CE3341BE111B314CEFD90BN8PR12MB3217namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: David Francis <david.francis-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Nicholas=
 Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Sent: August 2, 2019 11:11:50 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Li, Sun peng (Leo) <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>; Francis, David <David.Francis@=
amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>; Kazlauskas, Nicho=
las <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/display: Block immediate flips for non-fast up=
dates

[Why]
Underflow can occur in the case where we change buffer pitch, DCC state,
rotation or mirroring for a plane while also performing an immediate
flip. It can also generate a p-state warning stack trace on DCN1 which
is typically observed during the cursor handler pipe locking because of
how frequent cursor updates can occur.

[How]
Store the update type on each CRTC - every plane will have access to
the CRTC state if it's flipping. If the update type is not
UPDATE_TYPE_FAST then the immediate flip should be disallowed.

No changes to the target vblank sequencing need to be done, we just
need to ensure that the surface registers do a double buffered update.

Cc: David Francis <david.francis-5C7GfCeVMHo@public.gmane.org>
Cc: Bhawanpreet Lakha <bhawanpreet.lakha-5C7GfCeVMHo@public.gmane.org>
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h    |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ffb3c7247ac6..e941d0d3794b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5690,8 +5690,14 @@ static void amdgpu_dm_commit_planes(struct drm_atomi=
c_state *state,
                 bundle->surface_updates[planes_count].plane_info =3D
                         &bundle->plane_infos[planes_count];

+               /*
+                * Only allow immediate flips for fast updates that don't
+                * change FB pitch, DCC state, rotation or mirroing.
+                */
                 bundle->flip_addrs[planes_count].flip_immediate =3D
-                               (crtc->state->pageflip_flags & DRM_MODE_PAG=
E_FLIP_ASYNC) !=3D 0;
+                       (crtc->state->pageflip_flags &
+                        DRM_MODE_PAGE_FLIP_ASYNC) !=3D 0 &&
+                       acrtc_state->update_type =3D=3D UPDATE_TYPE_FAST;

                 timestamp_ns =3D ktime_get_ns();
                 bundle->flip_addrs[planes_count].flip_timestamp_in_us =3D =
div_u64(timestamp_ns, 1000);
@@ -7311,6 +7317,14 @@ static int amdgpu_dm_atomic_check(struct drm_device =
*dev,
                 state->async_update =3D !drm_atomic_helper_async_check(dev=
, state);
         }

+       /* Store the overall update type for use later in atomic check. */
+       for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
+               struct dm_crtc_state *dm_new_crtc_state =3D
+                       to_dm_crtc_state(new_crtc_state);
+
+               dm_new_crtc_state->update_type =3D (int)overall_update_type=
;
+       }
+
         /* Must be success */
         WARN_ON(ret);
         return ret;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index da48a857949f..cbd6608f58e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -307,6 +307,7 @@ struct dm_crtc_state {
         bool cm_has_degamma;
         bool cm_is_degamma_srgb;

+       int update_type;
         int active_planes;
         bool interrupts_enabled;

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN8PR12MB3217B2D3CE3341BE111B314CEFD90BN8PR12MB3217namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Reviewed-by: David Francis =
&lt;david.francis-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Nicholas Kazlauskas &lt;nicho=
las.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> August 2, 2019 11:11:50 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Li, Sun peng (Leo) &lt;Sunpeng.Li-5C7GfCeVMHo@public.gmane.org&gt;; Francis, David &l=
t;David.Francis-5C7GfCeVMHo@public.gmane.org&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.c=
om&gt;; Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/display: Block immediate flips for non-=
fast updates</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
Underflow can occur in the case where we change buffer pitch, DCC state,<br=
>
rotation or mirroring for a plane while also performing an immediate<br>
flip. It can also generate a p-state warning stack trace on DCN1 which<br>
is typically observed during the cursor handler pipe locking because of<br>
how frequent cursor updates can occur.<br>
<br>
[How]<br>
Store the update type on each CRTC - every plane will have access to<br>
the CRTC state if it's flipping. If the update type is not<br>
UPDATE_TYPE_FAST then the immediate flip should be disallowed.<br>
<br>
No changes to the target vblank sequencing need to be done, we just<br>
need to ensure that the surface registers do a double buffered update.<br>
<br>
Cc: David Francis &lt;david.francis-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: Bhawanpreet Lakha &lt;bhawanpreet.lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c&nbsp;&nbsp;&nbsp; | 16 =
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
-<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h&nbsp;&nbsp;&nbsp; |&nbs=
p; 1 &#43;<br>
&nbsp;2 files changed, 16 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index ffb3c7247ac6..e941d0d3794b 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -5690,8 &#43;5690,14 @@ static void amdgpu_dm_commit_planes(struct drm_a=
tomic_state *state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bundle-&gt;surface_updates[planes_count].plane_info =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
bundle-&gt;plane_infos[planes_count];<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * Only allow immediate flips for fast updates that don=
't<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * change FB pitch, DCC state, rotation or mirroing.<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bundle-&gt;flip_addrs[planes_count].flip_immediate =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (crtc-&gt;state-&gt;pageflip_flags &amp; DR=
M_MODE_PAGE_FLIP_ASYNC) !=3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (crtc-&gt;st=
ate-&gt;pageflip_flags &amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_MO=
DE_PAGE_FLIP_ASYNC) !=3D 0 &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acrtc_state-=
&gt;update_type =3D=3D UPDATE_TYPE_FAST;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; timestamp_ns =3D ktime_get_ns();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bundle-&gt;flip_addrs[planes_count].flip_timestamp_in=
_us =3D div_u64(timestamp_ns, 1000);<br>
@@ -7311,6 &#43;7317,14 @@ static int amdgpu_dm_atomic_check(struct drm_dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; state-&gt;async_update =3D !drm_atomic_helper_async_c=
heck(dev, state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Store the overall update type =
for use later in atomic check. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_new_crtc_in_state (state=
, crtc, new_crtc_state, i) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct dm_crtc_state *dm_new_crtc_state =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to_dm_crtc_s=
tate(new_crtc_state);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dm_new_crtc_state-&gt;update_type =3D (int)overall_update_ty=
pe;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Must be success */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ret);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
index da48a857949f..cbd6608f58e6 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
@@ -307,6 &#43;307,7 @@ struct dm_crtc_state {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool cm_has_degamma;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool cm_is_degamma_srgb;<b=
r>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int update_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int active_planes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool interrupts_enabled;<b=
r>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN8PR12MB3217B2D3CE3341BE111B314CEFD90BN8PR12MB3217namp_--

--===============1154488033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1154488033==--
