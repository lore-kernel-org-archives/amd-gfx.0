From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Update pitch on page flips without DC as well
Date: Mon, 29 Jul 2019 16:21:33 +0000
Message-ID: <BN6PR12MB180983B728C323E624827F6BF7DD0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190729162014.9476-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1384198737=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190729162014.9476-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1384198737==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180983B728C323E624827F6BF7DD0BN6PR12MB1809namp_"

--_000_BN6PR12MB180983B728C323E624827F6BF7DD0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Monday, July 29, 2019 12:20 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Update pitch on page flips without DC as well

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

DC already handles this correctly since amdgpu minor version 31. Bump
the minor version again so that xf86-video-amdgpu can take advantage of
this working without DC as well now.

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---

See https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/merge_requ=
ests/39
for the corresponding xf86-video-amdgpu change.

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c   | 4 ++++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c   | 4 ++++
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 800d0ceb14b4..cf334c465805 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -77,9 +77,10 @@
  * - 3.31.0 - Add support for per-flip tiling attribute changes with DC
  * - 3.32.0 - Add syncobj timeline support to AMDGPU_CS.
  * - 3.33.0 - Fixes for GDS ENOMEM failures in AMDGPU_CS.
+ * - 3.34.0 - Non-DC can flip correctly between buffers with different pit=
ches
  */
 #define KMS_DRIVER_MAJOR        3
-#define KMS_DRIVER_MINOR       33
+#define KMS_DRIVER_MINOR       34
 #define KMS_DRIVER_PATCHLEVEL   0

 #define AMDGPU_MAX_TIMEOUT_PARAM_LENTH  256
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/dce_v10_0.c
index 1f0426d2fc2a..c609b7af0b6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -233,6 +233,7 @@ static void dce_v10_0_page_flip(struct amdgpu_device *a=
dev,
                                 int crtc_id, u64 crtc_base, bool async)
 {
         struct amdgpu_crtc *amdgpu_crtc =3D adev->mode_info.crtcs[crtc_id]=
;
+       struct drm_framebuffer *fb =3D amdgpu_crtc->base.primary->fb;
         u32 tmp;

         /* flip at hsync for async, default is vsync */
@@ -240,6 +241,9 @@ static void dce_v10_0_page_flip(struct amdgpu_device *a=
dev,
         tmp =3D REG_SET_FIELD(tmp, GRPH_FLIP_CONTROL,
                             GRPH_SURFACE_UPDATE_H_RETRACE_EN, async ? 1 : =
0);
         WREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc->crtc_offset, tmp);
+       /* update pitch */
+       WREG32(mmGRPH_PITCH + amdgpu_crtc->crtc_offset,
+              fb->pitches[0] / fb->format->cpp[0]);
         /* update the primary scanout address */
         WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS_HIGH + amdgpu_crtc->crtc_off=
set,
                upper_32_bits(crtc_base));
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/dce_v11_0.c
index 2280b971d758..719db058b306 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -251,6 +251,7 @@ static void dce_v11_0_page_flip(struct amdgpu_device *a=
dev,
                                 int crtc_id, u64 crtc_base, bool async)
 {
         struct amdgpu_crtc *amdgpu_crtc =3D adev->mode_info.crtcs[crtc_id]=
;
+       struct drm_framebuffer *fb =3D amdgpu_crtc->base.primary->fb;
         u32 tmp;

         /* flip immediate for async, default is vsync */
@@ -258,6 +259,9 @@ static void dce_v11_0_page_flip(struct amdgpu_device *a=
dev,
         tmp =3D REG_SET_FIELD(tmp, GRPH_FLIP_CONTROL,
                             GRPH_SURFACE_UPDATE_IMMEDIATE_EN, async ? 1 : =
0);
         WREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc->crtc_offset, tmp);
+       /* update pitch */
+       WREG32(mmGRPH_PITCH + amdgpu_crtc->crtc_offset,
+              fb->pitches[0] / fb->format->cpp[0]);
         /* update the scanout addresses */
         WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS_HIGH + amdgpu_crtc->crtc_off=
set,
                upper_32_bits(crtc_base));
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/dce_v6_0.c
index bea32f076b91..8ee99651d01a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -186,10 +186,14 @@ static void dce_v6_0_page_flip(struct amdgpu_device *=
adev,
                                int crtc_id, u64 crtc_base, bool async)
 {
         struct amdgpu_crtc *amdgpu_crtc =3D adev->mode_info.crtcs[crtc_id]=
;
+       struct drm_framebuffer *fb =3D amdgpu_crtc->base.primary->fb;

         /* flip at hsync for async, default is vsync */
         WREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc->crtc_offset, async ?
                GRPH_FLIP_CONTROL__GRPH_SURFACE_UPDATE_H_RETRACE_EN_MASK : =
0);
+       /* update pitch */
+       WREG32(mmGRPH_PITCH + amdgpu_crtc->crtc_offset,
+              fb->pitches[0] / fb->format->cpp[0]);
         /* update the scanout addresses */
         WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS_HIGH + amdgpu_crtc->crtc_off=
set,
                upper_32_bits(crtc_base));
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/dce_v8_0.c
index 13da915991dd..7037e016493c 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -181,10 +181,14 @@ static void dce_v8_0_page_flip(struct amdgpu_device *=
adev,
                                int crtc_id, u64 crtc_base, bool async)
 {
         struct amdgpu_crtc *amdgpu_crtc =3D adev->mode_info.crtcs[crtc_id]=
;
+       struct drm_framebuffer *fb =3D amdgpu_crtc->base.primary->fb;

         /* flip at hsync for async, default is vsync */
         WREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc->crtc_offset, async ?
                GRPH_FLIP_CONTROL__GRPH_SURFACE_UPDATE_H_RETRACE_EN_MASK : =
0);
+       /* update pitch */
+       WREG32(mmGRPH_PITCH + amdgpu_crtc->crtc_offset,
+              fb->pitches[0] / fb->format->cpp[0]);
         /* update the primary scanout addresses */
         WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS_HIGH + amdgpu_crtc->crtc_off=
set,
                upper_32_bits(crtc_base));
--
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180983B728C323E624827F6BF7DD0BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Monday, July 29, 2019 12:20 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update pitch on page flips without DC a=
s well</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
DC already handles this correctly since amdgpu minor version 31. Bump<br>
the minor version again so that xf86-video-amdgpu can take advantage of<br>
this working without DC as well now.<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
<br>
See <a href=3D"https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu=
/merge_requests/39">
https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/merge_requests=
/39</a><br>
for the corresponding xf86-video-amdgpu change.<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 &#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/dce_v10_0.c&nbsp; | 4 &#43;&#43;&#43;&#43;=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/dce_v11_0.c&nbsp; | 4 &#43;&#43;&#43;&#43;=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/dce_v6_0.c&nbsp;&nbsp; | 4 &#43;&#43;&#43;=
&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/dce_v8_0.c&nbsp;&nbsp; | 4 &#43;&#43;&#43;=
&#43;<br>
&nbsp;5 files changed, 18 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 800d0ceb14b4..cf334c465805 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -77,9 &#43;77,10 @@<br>
&nbsp; * - 3.31.0 - Add support for per-flip tiling attribute changes with =
DC<br>
&nbsp; * - 3.32.0 - Add syncobj timeline support to AMDGPU_CS.<br>
&nbsp; * - 3.33.0 - Fixes for GDS ENOMEM failures in AMDGPU_CS.<br>
&#43; * - 3.34.0 - Non-DC can flip correctly between buffers with different=
 pitches<br>
&nbsp; */<br>
&nbsp;#define KMS_DRIVER_MAJOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<=
br>
-#define KMS_DRIVER_MINOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33<br>
&#43;#define KMS_DRIVER_MINOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 34<br>
&nbsp;#define KMS_DRIVER_PATCHLEVEL&nbsp;&nbsp; 0<br>
&nbsp;<br>
&nbsp;#define AMDGPU_MAX_TIMEOUT_PARAM_LENTH&nbsp; 256<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/dce_v10_0.c<br>
index 1f0426d2fc2a..c609b7af0b6b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c<br>
@@ -233,6 &#43;233,7 @@ static void dce_v10_0_page_flip(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int crtc_id, u64 crtc_base, bool=
 async)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu=
_crtc =3D adev-&gt;mode_info.crtcs[crtc_id];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_framebuffer *fb =3D am=
dgpu_crtc-&gt;base.primary-&gt;fb;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flip at hsync for async=
, default is vsync */<br>
@@ -240,6 &#43;241,9 @@ static void dce_v10_0_page_flip(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 GRPH_FLIP_CONTROL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; GRPH_SURFACE_UPDATE_H_RETRACE_EN, async ? 1 : 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_FLIP_CONTROL=
 &#43; amdgpu_crtc-&gt;crtc_offset, tmp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update pitch */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_PITCH &#43; amdgpu_=
crtc-&gt;crtc_offset,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; fb-&gt;pitches[0] / fb-&gt;format-&gt;cpp[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update the primary scan=
out address */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_PRIMARY_SURF=
ACE_ADDRESS_HIGH &#43; amdgpu_crtc-&gt;crtc_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; upper_32_bits(crtc_base));<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/dce_v11_0.c<br>
index 2280b971d758..719db058b306 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c<br>
@@ -251,6 &#43;251,7 @@ static void dce_v11_0_page_flip(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int crtc_id, u64 crtc_base, bool=
 async)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu=
_crtc =3D adev-&gt;mode_info.crtcs[crtc_id];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_framebuffer *fb =3D am=
dgpu_crtc-&gt;base.primary-&gt;fb;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flip immediate for asyn=
c, default is vsync */<br>
@@ -258,6 &#43;259,9 @@ static void dce_v11_0_page_flip(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 GRPH_FLIP_CONTROL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; GRPH_SURFACE_UPDATE_IMMEDIATE_EN, async ? 1 : 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_FLIP_CONTROL=
 &#43; amdgpu_crtc-&gt;crtc_offset, tmp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update pitch */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_PITCH &#43; amdgpu_=
crtc-&gt;crtc_offset,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; fb-&gt;pitches[0] / fb-&gt;format-&gt;cpp[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update the scanout addr=
esses */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_PRIMARY_SURF=
ACE_ADDRESS_HIGH &#43; amdgpu_crtc-&gt;crtc_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; upper_32_bits(crtc_base));<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/dce_v6_0.c<br>
index bea32f076b91..8ee99651d01a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c<br>
@@ -186,10 &#43;186,14 @@ static void dce_v6_0_page_flip(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int crtc_id, u64 crtc_base, bool async=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu=
_crtc =3D adev-&gt;mode_info.crtcs[crtc_id];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_framebuffer *fb =3D am=
dgpu_crtc-&gt;base.primary-&gt;fb;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flip at hsync for async=
, default is vsync */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_FLIP_CONTROL=
 &#43; amdgpu_crtc-&gt;crtc_offset, async ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; GRPH_FLIP_CONTROL__GRPH_SURFACE_UPDATE_H_RETRACE_EN_MASK : =
0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update pitch */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_PITCH &#43; amdgpu_=
crtc-&gt;crtc_offset,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; fb-&gt;pitches[0] / fb-&gt;format-&gt;cpp[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update the scanout addr=
esses */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_PRIMARY_SURF=
ACE_ADDRESS_HIGH &#43; amdgpu_crtc-&gt;crtc_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; upper_32_bits(crtc_base));<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/dce_v8_0.c<br>
index 13da915991dd..7037e016493c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
@@ -181,10 &#43;181,14 @@ static void dce_v8_0_page_flip(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int crtc_id, u64 crtc_base, bool async=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu=
_crtc =3D adev-&gt;mode_info.crtcs[crtc_id];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_framebuffer *fb =3D am=
dgpu_crtc-&gt;base.primary-&gt;fb;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flip at hsync for async=
, default is vsync */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_FLIP_CONTROL=
 &#43; amdgpu_crtc-&gt;crtc_offset, async ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; GRPH_FLIP_CONTROL__GRPH_SURFACE_UPDATE_H_RETRACE_EN_MASK : =
0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update pitch */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_PITCH &#43; amdgpu_=
crtc-&gt;crtc_offset,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; fb-&gt;pitches[0] / fb-&gt;format-&gt;cpp[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update the primary scan=
out addresses */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRPH_PRIMARY_SURF=
ACE_ADDRESS_HIGH &#43; amdgpu_crtc-&gt;crtc_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; upper_32_bits(crtc_base));<br>
-- <br>
2.22.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180983B728C323E624827F6BF7DD0BN6PR12MB1809namp_--

--===============1384198737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1384198737==--
