From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix amdgpu_display_supported_domains logic.
Date: Fri, 26 Jul 2019 14:29:31 +0000
Message-ID: <BN6PR12MB1809FAA22170477E1BE42CBFF7C00@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1564147692-13880-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0352988890=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1564147692-13880-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

--===============0352988890==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809FAA22170477E1BE42CBFF7C00BN6PR12MB1809namp_"

--_000_BN6PR12MB1809FAA22170477E1BE42CBFF7C00BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Andrey G=
rodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, July 26, 2019 9:28 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Grodzovsky, Andrey <And=
rey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>; michel-otUistvHUpPR7s880joybQ@public.gmane.org <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Koenig, C=
hristian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; S, Shirish <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Fix amdgpu_display_supported_domains logic.

Add restriction to dissallow GTT domain if the relevant BO
doesn't have USWC flag set to avoid the APU hang scenario.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 16 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c            | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c           |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 6 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 73045a3..4a8b1b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -189,7 +189,8 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crt=
c *crtc,
         }

         if (!adev->enable_virtual_display) {
-               r =3D amdgpu_bo_pin(new_abo, amdgpu_display_supported_domai=
ns(adev));
+               r =3D amdgpu_bo_pin(new_abo,
+                                 amdgpu_display_supported_domains(adev, ne=
w_abo->flags));
                 if (unlikely(r !=3D 0)) {
                         DRM_ERROR("failed to pin new abo buffer before fli=
p\n");
                         goto unreserve;
@@ -493,20 +494,25 @@ static const struct drm_framebuffer_funcs amdgpu_fb_f=
uncs =3D {
         .create_handle =3D drm_gem_fb_create_handle,
 };

-uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev)
+uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
+                                         uint64_t bo_flags)
 {
         uint32_t domain =3D AMDGPU_GEM_DOMAIN_VRAM;

 #if defined(CONFIG_DRM_AMD_DC)
         /*
-        * if amdgpu_bo_validate_uswc returns false it means that USWC mapp=
ings
+        * if amdgpu_bo_support_uswc returns false it means that USWC mappi=
ngs
          * is not supported for this board. But this mapping is required
          * to avoid hang caused by placement of scanout BO in GTT on certa=
in
          * APUs. So force the BO placement to VRAM in case this architectu=
re
          * will not allow USWC mappings.
+        * Also, don't allow GTT domain if the BO doens't have USWC falg se=
t.
          */
-       if (adev->asic_type >=3D CHIP_CARRIZO && adev->asic_type <=3D CHIP_=
RAVEN &&
-           adev->flags & AMD_IS_APU && amdgpu_bo_support_uswc(0) &&
+       if (adev->asic_type >=3D CHIP_CARRIZO &&
+           adev->asic_type <=3D CHIP_RAVEN &&
+           (adev->flags & AMD_IS_APU) &&
+           (bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
+           amdgpu_bo_support_uswc(bo_flags) &&
             amdgpu_device_asic_has_dc_support(adev->asic_type))
                 domain |=3D AMDGPU_GEM_DOMAIN_GTT;
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.h
index 06b922f..3620b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -38,7 +38,8 @@
 int amdgpu_display_freesync_ioctl(struct drm_device *dev, void *data,
                                   struct drm_file *filp);
 void amdgpu_display_update_priority(struct amdgpu_device *adev);
-uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev);
+uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
+                                         uint64_t bo_flags);
 struct drm_framebuffer *
 amdgpu_display_user_framebuffer_create(struct drm_device *dev,
                                        struct drm_file *file_priv,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c
index 4711cf1..6770eb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -301,7 +301,7 @@ static int amdgpu_dma_buf_begin_cpu_access(struct dma_b=
uf *dma_buf,
         struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(dma_buf->priv);
         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
         struct ttm_operation_ctx ctx =3D { true, false };
-       u32 domain =3D amdgpu_display_supported_domains(adev);
+       u32 domain =3D amdgpu_display_supported_domains(adev, bo->flags);
         int ret;
         bool reads =3D (direction =3D=3D DMA_BIDIRECTIONAL ||
                       direction =3D=3D DMA_FROM_DEVICE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_fb.c
index bf0c61b..4a6f29e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -130,21 +130,21 @@ static int amdgpufb_create_pinned_object(struct amdgp=
u_fbdev *rfbdev,
         int aligned_size, size;
         int height =3D mode_cmd->height;
         u32 cpp;
+       u64 flags =3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
+                              AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS     |
+                              AMDGPU_GEM_CREATE_VRAM_CLEARED          |
+                              AMDGPU_GEM_CREATE_CPU_GTT_USWC;

         cpp =3D drm_format_plane_cpp(mode_cmd->pixel_format, 0);

         /* need to align pitch with crtc limits */
         mode_cmd->pitches[0] =3D amdgpu_align_pitch(adev, mode_cmd->width,=
 cpp,
                                                   fb_tiled);
-       domain =3D amdgpu_display_supported_domains(adev);
+       domain =3D amdgpu_display_supported_domains(adev, flags);
         height =3D ALIGN(mode_cmd->height, 8);
         size =3D mode_cmd->pitches[0] * height;
         aligned_size =3D ALIGN(size, PAGE_SIZE);
-       ret =3D amdgpu_gem_object_create(adev, aligned_size, 0, domain,
-                                      AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRE=
D |
-                                      AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS   =
  |
-                                      AMDGPU_GEM_CREATE_VRAM_CLEARED      =
    |
-                                      AMDGPU_GEM_CREATE_CPU_GTT_USWC,
+       ret =3D amdgpu_gem_object_create(adev, aligned_size, 0, domain, fla=
gs,
                                        ttm_bo_type_kernel, NULL, &gobj);
         if (ret) {
                 pr_err("failed to allocate framebuffer (%d)\n", aligned_si=
ze);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c
index eeed089..e7af35c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -761,7 +761,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
         args->size =3D (u64)args->pitch * args->height;
         args->size =3D ALIGN(args->size, PAGE_SIZE);
         domain =3D amdgpu_bo_get_preferred_pin_domain(adev,
-                               amdgpu_display_supported_domains(adev));
+                               amdgpu_display_supported_domains(adev, flag=
s));
         r =3D amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
                                      ttm_bo_type_device, NULL, &gobj);
         if (r)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 066f04b..0401691 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4414,7 +4414,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plan=
e *plane,
         }

         if (plane->type !=3D DRM_PLANE_TYPE_CURSOR)
-               domain =3D amdgpu_display_supported_domains(adev);
+               domain =3D amdgpu_display_supported_domains(adev, rbo->flag=
s);
         else
                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809FAA22170477E1BE42CBFF7C00BN6PR12MB1809namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Andrey Grodzovsky &lt;andrey.=
grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, July 26, 2019 9:28 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Grodzovsky=
, Andrey &lt;Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;; michel-otUistvHUpPR7s880joybQ@public.gmane.org &lt;michel@d=
aenzer.net&gt;; Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; S, Shir=
ish &lt;Shirish.S-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix amdgpu_display_supported_domains lo=
gic.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add restriction to dissallow GTT domain if the rel=
evant BO<br>
doesn't have USWC flag set to avoid the APU hang scenario.<br>
<br>
Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_display.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 16 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_display.h&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 3 &#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 12 &#43;&#43;&#43;&#43;&#43;&#43;----=
--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |&nbsp; 2 &#43;-<br=
>
&nbsp;6 files changed, 22 insertions(&#43;), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 73045a3..4a8b1b1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -189,7 &#43;189,8 @@ int amdgpu_display_crtc_page_flip_target(struct drm=
_crtc *crtc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;enable_virtu=
al_display) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_bo_pin(new_abo, amdgpu_display_supported_domains(ad=
ev));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_bo_pin(new_abo,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_display_supported_do=
mains(adev, new_abo-&gt;flags));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;failed to pin new abo buffer before flip\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
unreserve;<br>
@@ -493,20 &#43;494,25 @@ static const struct drm_framebuffer_funcs amdgpu_=
fb_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .create_handle =3D drm_gem=
_fb_create_handle,<br>
&nbsp;};<br>
&nbsp;<br>
-uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev)<br>
&#43;uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; uint64_t bo_flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t domain =3D AMDGPU=
_GEM_DOMAIN_VRAM;<br>
&nbsp;<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if amdgpu_bo_validate_uswc re=
turns false it means that USWC mappings<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if amdgpu_bo_support_uswc=
 returns false it means that USWC mappings<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is not supported f=
or this board. But this mapping is required<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to avoid hang caus=
ed by placement of scanout BO in GTT on certain<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * APUs. So force the=
 BO placement to VRAM in case this architecture<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * will not allow USW=
C mappings.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Also, don't allow GTT dom=
ain if the BO doens't have USWC falg set.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_C=
ARRIZO &amp;&amp; adev-&gt;asic_type &lt;=3D CHIP_RAVEN &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;flag=
s &amp; AMD_IS_APU &amp;&amp; amdgpu_bo_support_uswc(0) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CH=
IP_CARRIZO &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;=
asic_type &lt;=3D CHIP_RAVEN &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;flags &amp; AMD_IS_APU) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bo_flags=
 &amp; AMDGPU_GEM_CREATE_CPU_GTT_USWC) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo=
_support_uswc(bo_flags) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_device_asic_has_dc_support(adev-&gt;asic_type))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; domain |=3D AMDGPU_GEM_DOMAIN_GTT;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.h<br>
index 06b922f..3620b24 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h<br>
@@ -38,7 &#43;38,8 @@<br>
&nbsp;int amdgpu_display_freesync_ioctl(struct drm_device *dev, void *data,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_file *fil=
p);<br>
&nbsp;void amdgpu_display_update_priority(struct amdgpu_device *adev);<br>
-uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev);<br>
&#43;uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; uint64_t bo_flags);<br>
&nbsp;struct drm_framebuffer *<br>
&nbsp;amdgpu_display_user_framebuffer_create(struct drm_device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct drm_file *file_priv,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c<br>
index 4711cf1..6770eb3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
@@ -301,7 &#43;301,7 @@ static int amdgpu_dma_buf_begin_cpu_access(struct d=
ma_buf *dma_buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo =3D g=
em_to_amdgpu_bo(dma_buf-&gt;priv);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_operation_ctx c=
tx =3D { true, false };<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 domain =3D amdgpu_display_support=
ed_domains(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 domain =3D amdgpu_display_sup=
ported_domains(adev, bo-&gt;flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool reads =3D (direction =
=3D=3D DMA_BIDIRECTIONAL ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; direction =3D=3D =
DMA_FROM_DEVICE);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_fb.c<br>
index bf0c61b..4a6f29e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c<br>
@@ -130,21 &#43;130,21 @@ static int amdgpufb_create_pinned_object(struct a=
mdgpu_fbdev *rfbdev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int aligned_size, size;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int height =3D mode_cmd-&g=
t;height;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 cpp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 flags =3D AMDGPU_GEM_CREATE_C=
PU_ACCESS_REQUIRED |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS&nbsp;&nbsp;=
&nbsp;&nbsp; |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_CREATE_VRAM_CLEARED&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_CREATE_CPU_GTT_USWC;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpp =3D drm_format_plane_c=
pp(mode_cmd-&gt;pixel_format, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* need to align pitch wit=
h crtc limits */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_cmd-&gt;pitches[0] =
=3D amdgpu_align_pitch(adev, mode_cmd-&gt;width, cpp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 fb_tiled);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D amdgpu_display_supported_d=
omains(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D amdgpu_display_support=
ed_domains(adev, flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; height =3D ALIGN(mode_cmd-=
&gt;height, 8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D mode_cmd-&gt;pitc=
hes[0] * height;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aligned_size =3D ALIGN(siz=
e, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_gem_object_create(adev=
, aligned_size, 0, domain,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MDGPU_GEM_CREATE_VRAM_CONTIGUOUS&nbsp;&nbsp;&nbsp;&nbsp; |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MDGPU_GEM_CREATE_VRAM_CLEARED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MDGPU_GEM_CREATE_CPU_GTT_USWC,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_gem_object_create(=
adev, aligned_size, 0, domain, flags,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; ttm_bo_type_kernel, NULL, &amp;gobj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_err(&quot;failed to allocate framebuffer (%d)\n&qu=
ot;, aligned_size);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c<br>
index eeed089..e7af35c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
@@ -761,7 &#43;761,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_p=
riv,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;size =3D (u64)arg=
s-&gt;pitch * args-&gt;height;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;size =3D ALIGN(ar=
gs-&gt;size, PAGE_SIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D amdgpu_bo_get_p=
referred_pin_domain(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_display_supported_domains(adev));<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_display_supported_domains(adev, =
flags));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gem_object_cr=
eate(adev, args-&gt;size, 0, domain, flags,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tt=
m_bo_type_device, NULL, &amp;gobj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 066f04b..0401691 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -4414,7 &#43;4414,7 @@ static int dm_plane_helper_prepare_fb(struct drm_=
plane *plane,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (plane-&gt;type !=3D DR=
M_PLANE_TYPE_CURSOR)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; domain =3D amdgpu_display_supported_domains(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; domain =3D amdgpu_display_supported_domains(adev, rbo-&gt;fl=
ags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809FAA22170477E1BE42CBFF7C00BN6PR12MB1809namp_--

--===============0352988890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0352988890==--
