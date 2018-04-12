From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Enable scatter gather display support
Date: Thu, 12 Apr 2018 19:03:00 +0200
Message-ID: <15196bc3-76cb-0a52-c05f-f23131f77e7f@amd.com>
References: <1522189371-13767-1-git-send-email-Samuel.Li@amd.com>
 <7cc47f78-66eb-148d-96a2-b97760f767bf@gmail.com>
 <CAAxE2A4msxZa19Cvv6giMDDYg57-M_qawgFRM2aaK6sUERuqSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1894656723=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A4msxZa19Cvv6giMDDYg57-M_qawgFRM2aaK6sUERuqSA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1894656723==
Content-Type: multipart/alternative;
 boundary="------------08E8E92E22B6D728F3B9A6F5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------08E8E92E22B6D728F3B9A6F5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> Can you be more specific, Christian? Mesa has this, I don't think it 
> needs anything else:
Completely agree, that's what I suggested to implement.

The point is this kernel change now needs to be reworked and adapted to 
what Mesa is doing.

Regards,
Christian.

Am 12.04.2018 um 18:40 schrieb Marek Olšák:
> Can you be more specific, Christian? Mesa has this, I don't think it 
> needs anything else:
> https://cgit.freedesktop.org/mesa/mesa/commit/?id=7d2079908d9ef05ec3f35b7078833e57846cab5b
>
> Marek
>
> On Wed, Mar 28, 2018 at 3:46 AM, Christian König 
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     Am 28.03.2018 um 00:22 schrieb Samuel Li:
>
>         It's auto by default. For CZ/ST, auto setting enables sg display
>         when vram size is small; otherwise still uses vram.
>         This patch fixed some potential hang issue introduced by change
>         "allow framebuffer in GART memory as well" due to CZ/ST hardware
>         limitation.
>
>
>     Well that is still a NAK.
>
>     As discussed now multiple times please implement the necessary
>     changes in Mesa.
>
>     Regards,
>     Christian.
>
>
>
>         v2: Change default setting to auto, also some misc changes.
>         Signed-off-by: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org
>         <mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org>>
>         ---
>           drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  1 +
>           drivers/gpu/drm/amd/amdgpu/amdgpu_display.c    | 10 ++++++++--
>           drivers/gpu/drm/amd/amdgpu/amdgpu_display.h    |  2 ++
>           drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 ++++
>           drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c   |  2 ++
>           drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++-
>           6 files changed, 19 insertions(+), 3 deletions(-)
>
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>         index a7e2229..c942362 100644
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>         @@ -129,6 +129,7 @@ extern int amdgpu_lbpw;
>           extern int amdgpu_compute_multipipe;
>           extern int amdgpu_gpu_recovery;
>           extern int amdgpu_emu_mode;
>         +extern int amdgpu_sg_display;
>             #ifdef CONFIG_DRM_AMDGPU_SI
>           extern int amdgpu_si_support;
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>         index 5495b29..1e7b950 100644
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>         @@ -513,8 +513,14 @@ uint32_t
>         amdgpu_display_framebuffer_domains(struct amdgpu_device *adev)
>           #if defined(CONFIG_DRM_AMD_DC)
>                 if (adev->asic_type >= CHIP_CARRIZO && adev->asic_type
>         < CHIP_RAVEN &&
>                     adev->flags & AMD_IS_APU &&
>         -           amdgpu_device_asic_has_dc_support(adev->asic_type))
>         -               domain |= AMDGPU_GEM_DOMAIN_GTT;
>         +           amdgpu_device_asic_has_dc_support(adev->asic_type)) {
>         +               if (amdgpu_sg_display == 1)
>         +                       domain = AMDGPU_GEM_DOMAIN_GTT;
>         +               else if (amdgpu_sg_display == -1) {
>         +                       if (adev->gmc.real_vram_size <
>         AMDGPU_SG_THRESHOLD)
>         +                               domain = AMDGPU_GEM_DOMAIN_GTT;
>         +               }
>         +       }
>           #endif
>                 return domain;
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
>         index 2b11d80..2b25393 100644
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
>         @@ -23,6 +23,8 @@
>           #ifndef __AMDGPU_DISPLAY_H__
>           #define __AMDGPU_DISPLAY_H__
>           +#define AMDGPU_SG_THRESHOLD  (256*1024*1024)
>         +
>           uint32_t amdgpu_display_framebuffer_domains(struct
>         amdgpu_device *adev);
>           struct drm_framebuffer *
>           amdgpu_display_user_framebuffer_create(struct drm_device *dev,
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>         index 1bfce79..19f11a5 100644
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>         @@ -132,6 +132,7 @@ int amdgpu_lbpw = -1;
>           int amdgpu_compute_multipipe = -1;
>           int amdgpu_gpu_recovery = -1; /* auto */
>           int amdgpu_emu_mode = 0;
>         +int amdgpu_sg_display = -1;
>             MODULE_PARM_DESC(vramlimit, "Restrict VRAM for testing, in
>         megabytes");
>           module_param_named(vramlimit, amdgpu_vram_limit, int, 0600);
>         @@ -290,6 +291,9 @@ module_param_named(gpu_recovery,
>         amdgpu_gpu_recovery, int, 0444);
>           MODULE_PARM_DESC(emu_mode, "Emulation mode, (1 = enable, 0 =
>         disable)");
>           module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);
>           +MODULE_PARM_DESC(sg_display, "Enable scatter gather
>         display, (1 = enable, 0 = disable, -1 = auto");
>         +module_param_named(sg_display, amdgpu_sg_display, int, 0444);
>         +
>           #ifdef CONFIG_DRM_AMDGPU_SI
>             #if defined(CONFIG_DRM_RADEON) ||
>         defined(CONFIG_DRM_RADEON_MODULE)
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>         index 1206301..f57c355 100644
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>         @@ -138,6 +138,8 @@ static int
>         amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
>                 mode_cmd->pitches[0] = amdgpu_align_pitch(adev,
>         mode_cmd->width, cpp,
>         fb_tiled);
>                 domain = amdgpu_display_framebuffer_domains(adev);
>         +       if (domain & AMDGPU_GEM_DOMAIN_GTT)
>         +               DRM_DEBUG_DRIVER("Scatter gather display:
>         enabled\n");
>                 height = ALIGN(mode_cmd->height, 8);
>                 size = mode_cmd->pitches[0] * height;
>         diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>         b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>         index 68ab325..7e9f247 100644
>         --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>         +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>         @@ -3074,7 +3074,8 @@ static int
>         dm_plane_helper_prepare_fb(struct drm_plane *plane,
>                         domain = AMDGPU_GEM_DOMAIN_VRAM;
>                 r = amdgpu_bo_pin(rbo, domain, &afb->address);
>         -
>         +       rbo->preferred_domains = domain;
>         +       rbo->allowed_domains = domain;
>                 amdgpu_bo_unreserve(rbo);
>                 if (unlikely(r != 0)) {
>
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>
>


--------------08E8E92E22B6D728F3B9A6F5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">Can you be more specific, Christian? Mesa
        has this, I don't think it needs anything else:</blockquote>
      Completely agree, that's what I suggested to implement.<br>
      <br>
      The point is this kernel change now needs to be reworked and
      adapted to what Mesa is doing.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 12.04.2018 um 18:40 schrieb Marek Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A4msxZa19Cvv6giMDDYg57-M_qawgFRM2aaK6sUERuqSA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div>Can you be more specific, Christian? Mesa has this, I don't
          think it needs anything else:<br>
          <a
href="https://cgit.freedesktop.org/mesa/mesa/commit/?id=7d2079908d9ef05ec3f35b7078833e57846cab5b"
            moz-do-not-send="true">https://cgit.freedesktop.org/mesa/mesa/commit/?id=7d2079908d9ef05ec3f35b7078833e57846cab5b</a><br>
          <br>
        </div>
        Marek<br>
      </div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">On Wed, Mar 28, 2018 at 3:46 AM,
          Christian König <span dir="ltr">&lt;<a
              href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
              target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex"><span
              class="">Am 28.03.2018 um 00:22 schrieb Samuel Li:<br>
              <blockquote class="gmail_quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                It's auto by default. For CZ/ST, auto setting enables sg
                display<br>
                when vram size is small; otherwise still uses vram.<br>
                This patch fixed some potential hang issue introduced by
                change<br>
                "allow framebuffer in GART memory as well" due to CZ/ST
                hardware<br>
                limitation.<br>
              </blockquote>
              <br>
            </span>
            Well that is still a NAK.<br>
            <br>
            As discussed now multiple times please implement the
            necessary changes in Mesa.<br>
            <br>
            Regards,<br>
            Christian.
            <div class="HOEnZb">
              <div class="h5"><br>
                <br>
                <blockquote class="gmail_quote" style="margin:0 0 0
                  .8ex;border-left:1px #ccc solid;padding-left:1ex">
                  <br>
                  v2: Change default setting to auto, also some misc
                  changes.<br>
                  Signed-off-by: Samuel Li &lt;<a
                    href="mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target="_blank"
                    moz-do-not-send="true">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                  ---<br>
                    drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu.h           
                     |  1 +<br>
                    drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_display.c   
                     | 10 ++++++++--<br>
                    drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_display.h   
                     |  2 ++<br>
                    drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_drv.c       
                     |  4 ++++<br>
                    drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_fb.c         
                    |  2 ++<br>
                    drivers/gpu/drm/amd/display/am<wbr>dgpu_dm/amdgpu_dm.c
                  |  3 ++-<br>
                    6 files changed, 19 insertions(+), 3 deletions(-)<br>
                  <br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu.h
                  b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu.h<br>
                  index a7e2229..c942362 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu.h<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu.h<br>
                  @@ -129,6 +129,7 @@ extern int amdgpu_lbpw;<br>
                    extern int amdgpu_compute_multipipe;<br>
                    extern int amdgpu_gpu_recovery;<br>
                    extern int amdgpu_emu_mode;<br>
                  +extern int amdgpu_sg_display;<br>
                      #ifdef CONFIG_DRM_AMDGPU_SI<br>
                    extern int amdgpu_si_support;<br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.c
                  b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.c<br>
                  index 5495b29..1e7b950 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.c<br>
                  @@ -513,8 +513,14 @@ uint32_t
                  amdgpu_display_framebuffer_dom<wbr>ains(struct
                  amdgpu_device *adev)<br>
                    #if defined(CONFIG_DRM_AMD_DC)<br>
                          if (adev-&gt;asic_type &gt;= CHIP_CARRIZO
                  &amp;&amp; adev-&gt;asic_type &lt; CHIP_RAVEN
                  &amp;&amp;<br>
                              adev-&gt;flags &amp; AMD_IS_APU &amp;&amp;<br>
                  -           amdgpu_device_asic_has_dc_sup<wbr>port(adev-&gt;asic_type))<br>
                  -               domain |= AMDGPU_GEM_DOMAIN_GTT;<br>
                  +           amdgpu_device_asic_has_dc_sup<wbr>port(adev-&gt;asic_type))
                  {<br>
                  +               if (amdgpu_sg_display == 1)<br>
                  +                       domain =
                  AMDGPU_GEM_DOMAIN_GTT;<br>
                  +               else if (amdgpu_sg_display == -1) {<br>
                  +                       if
                  (adev-&gt;gmc.real_vram_size &lt; AMDGPU_SG_THRESHOLD)<br>
                  +                               domain =
                  AMDGPU_GEM_DOMAIN_GTT;<br>
                  +               }<br>
                  +       }<br>
                    #endif<br>
                          return domain;<br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.h
                  b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.h<br>
                  index 2b11d80..2b25393 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.h<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.h<br>
                  @@ -23,6 +23,8 @@<br>
                    #ifndef __AMDGPU_DISPLAY_H__<br>
                    #define __AMDGPU_DISPLAY_H__<br>
                    +#define AMDGPU_SG_THRESHOLD  (256*1024*1024)<br>
                  +<br>
                    uint32_t amdgpu_display_framebuffer_dom<wbr>ains(struct
                  amdgpu_device *adev);<br>
                    struct drm_framebuffer *<br>
                    amdgpu_display_user_framebuffe<wbr>r_create(struct
                  drm_device *dev,<br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_drv.c
                  b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_drv.c<br>
                  index 1bfce79..19f11a5 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_drv.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_drv.c<br>
                  @@ -132,6 +132,7 @@ int amdgpu_lbpw = -1;<br>
                    int amdgpu_compute_multipipe = -1;<br>
                    int amdgpu_gpu_recovery = -1; /* auto */<br>
                    int amdgpu_emu_mode = 0;<br>
                  +int amdgpu_sg_display = -1;<br>
                      MODULE_PARM_DESC(vramlimit, "Restrict VRAM for
                  testing, in megabytes");<br>
                    module_param_named(vramlimit, amdgpu_vram_limit,
                  int, 0600);<br>
                  @@ -290,6 +291,9 @@ module_param_named(gpu_recover<wbr>y,
                  amdgpu_gpu_recovery, int, 0444);<br>
                    MODULE_PARM_DESC(emu_mode, "Emulation mode, (1 =
                  enable, 0 = disable)");<br>
                    module_param_named(emu_mode, amdgpu_emu_mode, int,
                  0444);<br>
                    +MODULE_PARM_DESC(sg_display, "Enable scatter gather
                  display, (1 = enable, 0 = disable, -1 = auto");<br>
                  +module_param_named(sg_display<wbr>,
                  amdgpu_sg_display, int, 0444);<br>
                  +<br>
                    #ifdef CONFIG_DRM_AMDGPU_SI<br>
                      #if defined(CONFIG_DRM_RADEON) ||
                  defined(CONFIG_DRM_RADEON_MODU<wbr>LE)<br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_fb.c
                  b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_fb.c<br>
                  index 1206301..f57c355 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_fb.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_fb.c<br>
                  @@ -138,6 +138,8 @@ static int
                  amdgpufb_create_pinned_object(<wbr>struct amdgpu_fbdev
                  *rfbdev,<br>
                          mode_cmd-&gt;pitches[0] =
                  amdgpu_align_pitch(adev, mode_cmd-&gt;width, cpp,<br>
                                                                   
                  fb_tiled);<br>
                          domain = amdgpu_display_framebuffer_dom<wbr>ains(adev);<br>
                  +       if (domain &amp; AMDGPU_GEM_DOMAIN_GTT)<br>
                  +               DRM_DEBUG_DRIVER("Scatter gather
                  display: enabled\n");<br>
                          height = ALIGN(mode_cmd-&gt;height, 8);<br>
                          size = mode_cmd-&gt;pitches[0] * height;<br>
                  diff --git a/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c
                  b/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c<br>
                  index 68ab325..7e9f247 100644<br>
                  --- a/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c<br>
                  +++ b/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c<br>
                  @@ -3074,7 +3074,8 @@ static int
                  dm_plane_helper_prepare_fb(str<wbr>uct drm_plane
                  *plane,<br>
                                  domain = AMDGPU_GEM_DOMAIN_VRAM;<br>
                          r = amdgpu_bo_pin(rbo, domain,
                  &amp;afb-&gt;address);<br>
                  -<br>
                  +       rbo-&gt;preferred_domains = domain;<br>
                  +       rbo-&gt;allowed_domains = domain;<br>
                          amdgpu_bo_unreserve(rbo);<br>
                          if (unlikely(r != 0)) {<br>
                </blockquote>
                <br>
              </div>
            </div>
            <div class="HOEnZb">
              <div class="h5">
                ______________________________<wbr>_________________<br>
                amd-gfx mailing list<br>
                <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                  target="_blank" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  rel="noreferrer" target="_blank"
                  moz-do-not-send="true">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a><br>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------08E8E92E22B6D728F3B9A6F5--

--===============1894656723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1894656723==--
