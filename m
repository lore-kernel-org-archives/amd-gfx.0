Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78822EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 13:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 059B510E4A4;
	Wed, 19 Jul 2023 13:10:50 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BA810E4A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 13:10:47 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-56352146799so4630527eaf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689772247; x=1692364247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjc8yTxv1YDiwufMZdokM2ZP50jJSc97lX44c55Ckhc=;
 b=XpQy7DXgnCfnW0YZu9bGGC9Qnylz1X3j6mMvurgHuY+cKrNHT0VeZOOQrNUzfmzdhp
 AV5se/4Xjb9r2HJBdP8Kar21Mra2W/k1PbV65a889aLsUqmviUEQExO8UBnh4uOTy1+g
 p7sGBzrMWoNIIrF9KlYaUy3aEBZZ2Bhw3Thajdqr5XsMuY/Wt9ISGvh+kGEwBNP2MN6E
 eR9DHyS/op5ewttfF7dN4MgaCWtmWChhfbcz7d8GCegwjJjgKVbZAUxSMdmCVv6UbSgm
 lEtp+YpQjAgzGVupGDoDG+FR6EjKVfkLMaAHo/kB5VdADdjnwNneFlN7V+F52A4MBfRH
 Ct2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689772247; x=1692364247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjc8yTxv1YDiwufMZdokM2ZP50jJSc97lX44c55Ckhc=;
 b=eFDHoV6IZoYXEdZJIcuzdX0kcIWiEWcy4aHnOphA9LqB9wq/g68t4v6gVOtpwhxqXX
 7VHzg6DI//EyUZjEEHhVlXsAH4COz0rpqHR4cgJNSYnWylFVYgpxMcVJcgXTNYmetCvs
 Ai7qrPYky+kM2nMTrc0QH3WK3PLSmUPhXMQd5zJk3FcZZPEKAriU8PBUdr7asJNfn2p5
 Idcg4dUqoN8TTXoHWz4RE3ikPKO6IBexuskCw330uKG3TbbvUbK8sBUnZLeCU17fUyrB
 pUz8m2BNVVXoiMj7NAODOk7CzTRmHg0aA4QtZywugYJxFHc8B/ldNGEpaFS14ty+6hUX
 ePgQ==
X-Gm-Message-State: ABy/qLbicXxJZ3GbZ186UFZ6tBAK6B6d0qePV6nxJ2cvYmKF1SBkS1x6
 6E8+Rq2/IPQTJ2ly6Ryy/ZpQbZsFh4NWn4rS3McLyfq3
X-Google-Smtp-Source: APBJJlGR1m9XZCiYB9r5NSIM9r3+ir1kFC7trG+cu+/TBkm+M761U+fn/GIe/M8Z/su2klAVXYSx8CDqfgdbwX8BrlU=
X-Received: by 2002:a4a:91d6:0:b0:563:624b:430f with SMTP id
 e22-20020a4a91d6000000b00563624b430fmr9397365ooh.1.1689772246558; Wed, 19 Jul
 2023 06:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230719051939.811520-1-srinivasan.shanmugam@amd.com>
 <20230719051939.811520-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230719051939.811520-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Jul 2023 09:10:35 -0400
Message-ID: <CADnq5_MC7Wwf1V8Jd0gZPCN=n51GqoiyirUDkd3HHMykssdz0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Convert macros to functions in
 amdgpu_display.c & amdgpu_display.h
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 19, 2023 at 1:20=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Convert macros to functions to fix the following & for better readability=
:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:26: Macro argument reuse 'ade=
v' - possible side-effects?
> drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:32: Macro argument reuse 'ade=
v' - possible side-effects?
> drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:34: Macro argument reuse 'ade=
v' - possible side-effects?
> drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:36: Macro argument reuse 'ade=
v' - possible side-effects?
> drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:38: Macro argument reuse 'ade=
v' - possible side-effects?
> drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:40: Macro argument reuse 'ade=
v' - possible side-effects?
> drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:42: Macro argument reuse 'ade=
v' - possible side-effects?
> drivers/gpu/drm/amd/amdgpu/amdgpu_display.h:44: Macro argument reuse 'ade=
v' - possible side-effects?
>

I would drop this part.  I don't think it's a net win.

> And other warnings:
>
> WARNING: Block comments use * on subsequent lines
> WARNING: Block comments use a trailing */ on a separate line
> WARNING: suspect code indent for conditional statements (8, 12)
> WARNING: braces {} are not necessary for single statement blocks

This part looks good.  Maybe split this out as a separate patch.

Alex

>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 118 +++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h |  46 ++++++--
>  2 files changed, 136 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index b702f499f5fb..6eea92cef97c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -45,6 +45,82 @@
>  #include <drm/drm_modeset_helper.h>
>  #include <drm/drm_vblank.h>
>
> +u32 amdgpu_display_vblank_get_counter(struct amdgpu_device *adev, int cr=
tc)
> +{
> +       return (adev)->mode_info.funcs->vblank_get_counter((adev), (crtc)=
);
> +}
> +
> +void amdgpu_display_backlight_set_level(struct amdgpu_device *adev,
> +                                       struct amdgpu_encoder *amdgpu_enc=
oder,
> +                                       u8 level)
> +{
> +       (adev)->mode_info.funcs->backlight_set_level((amdgpu_encoder), (l=
evel));
> +}
> +
> +u8 amdgpu_display_backlight_get_level(struct amdgpu_device *adev,
> +                                     struct amdgpu_encoder *amdgpu_encod=
er)
> +{
> +       return (adev)->mode_info.funcs->backlight_get_level(amdgpu_encode=
r);
> +}
> +
> +bool amdgpu_display_hpd_sense(struct amdgpu_device *adev,
> +                             enum amdgpu_hpd_id hpd)
> +{
> +       return (adev)->mode_info.funcs->hpd_sense((adev), (hpd));
> +}
> +
> +void amdgpu_display_hpd_set_polarity(struct amdgpu_device *adev,
> +                                    enum amdgpu_hpd_id hpd)
> +{
> +       (adev)->mode_info.funcs->hpd_set_polarity((adev), (hpd));
> +}
> +
> +u32 amdgpu_display_hpd_get_gpio_reg(struct amdgpu_device *adev)
> +{
> +       return (adev)->mode_info.funcs->hpd_get_gpio_reg(adev);
> +}
> +
> +void amdgpu_display_bandwidth_update(struct amdgpu_device *adev)
> +{
> +       (adev)->mode_info.funcs->bandwidth_update(adev);
> +}
> +
> +void amdgpu_display_page_flip(struct amdgpu_device *adev,
> +                             int crtc_id, u64 crtc_base,
> +                             bool async)
> +{
> +       (adev)->mode_info.funcs->page_flip((adev), (crtc_id), (crtc_base)=
, (async));
> +}
> +
> +int amdgpu_display_page_flip_get_scanoutpos(struct amdgpu_device *adev, =
int crtc,
> +                                           u32 *vbl, u32 *pos)
> +{
> +       return (adev)->mode_info.funcs->page_flip_get_scanoutpos((adev), =
(crtc), (vbl), (pos));
> +}
> +
> +void amdgpu_display_add_encoder(struct amdgpu_device *adev,
> +                               u32 encoder_enum,
> +                               u32 supported_device,
> +                               u16 caps)
> +{
> +       (adev)->mode_info.funcs->add_encoder((adev), (encoder_enum), (sup=
ported_device), (caps));
> +}
> +
> +void amdgpu_display_add_connector(struct amdgpu_device *adev,
> +                                 u32 connector_id,
> +                                 u32 supported_device,
> +                                 int connector_type,
> +                                 struct amdgpu_i2c_bus_rec *i2c_bus,
> +                                 u16 connector_object_id,
> +                                 struct amdgpu_hpd *hpd,
> +                                 struct amdgpu_router *router)
> +{
> +       (adev)->mode_info.funcs->add_connector((adev), (connector_id),
> +                                              (supported_device), (conne=
ctor_type),
> +                                              (i2c_bus), (connector_obje=
ct_id),
> +                                              (hpd), (router));
> +}
> +
>  /**
>   * amdgpu_display_hotplug_work_func - work handler for display hotplug e=
vent
>   *
> @@ -124,7 +200,7 @@ static void amdgpu_display_flip_work_func(struct work=
_struct *__work)
>
>         struct drm_crtc *crtc =3D &amdgpu_crtc->base;
>         unsigned long flags;
> -       unsigned i;
> +       unsigned int i;
>         int vpos, hpos;
>
>         for (i =3D 0; i < work->shared_count; ++i)
> @@ -201,7 +277,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_c=
rtc *crtc,
>         u64 tiling_flags;
>         int i, r;
>
> -       work =3D kzalloc(sizeof *work, GFP_KERNEL);
> +       work =3D kzalloc(sizeof(*work), GFP_KERNEL);
>         if (work =3D=3D NULL)
>                 return -ENOMEM;
>
> @@ -332,13 +408,15 @@ int amdgpu_display_crtc_set_config(struct drm_mode_=
set *set,
>
>         adev =3D drm_to_adev(dev);
>         /* if we have active crtcs and we don't have a power ref,
> -          take the current one */
> +        * take the current one
> +        */
>         if (active && !adev->have_disp_power_ref) {
>                 adev->have_disp_power_ref =3D true;
>                 return ret;
>         }
>         /* if we have no active crtcs, then drop the power ref
> -          we got before */
> +        * we got before
> +        */
>         if (!active && adev->have_disp_power_ref) {
>                 pm_runtime_put_autosuspend(dev->dev);
>                 adev->have_disp_power_ref =3D false;
> @@ -507,11 +585,10 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connect=
or *amdgpu_connector,
>         if (amdgpu_connector->router.ddc_valid)
>                 amdgpu_i2c_router_select_ddc_port(amdgpu_connector);
>
> -       if (use_aux) {
> +       if (use_aux)
>                 ret =3D i2c_transfer(&amdgpu_connector->ddc_bus->aux.ddc,=
 msgs, 2);
> -       } else {
> +       else
>                 ret =3D i2c_transfer(&amdgpu_connector->ddc_bus->adapter,=
 msgs, 2);
> -       }
>
>         if (ret !=3D 2)
>                 /* Couldn't find an accessible DDC on this connector */
> @@ -520,10 +597,12 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connect=
or *amdgpu_connector,
>          * EDID header starts with:
>          * 0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00.
>          * Only the first 6 bytes must be valid as
> -        * drm_edid_block_valid() can fix the last 2 bytes */
> +        * drm_edid_block_valid() can fix the last 2 bytes
> +        */
>         if (drm_edid_header_is_valid(buf) < 6) {
>                 /* Couldn't find an accessible EDID on this
> -                * connector */
> +                * connector
> +                */
>                 return false;
>         }
>         return true;
> @@ -1216,8 +1295,10 @@ amdgpu_display_user_framebuffer_create(struct drm_=
device *dev,
>
>         obj =3D drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
>         if (obj =3D=3D  NULL) {
> -               drm_dbg_kms(dev, "No GEM object associated to handle 0x%0=
8X, "
> -                           "can't create framebuffer\n", mode_cmd->handl=
es[0]);
> +               drm_dbg_kms(dev, "No GEM object associated to handle 0x%0=
8X\n",
> +                           mode_cmd->handles[0]);
> +               drm_dbg_kms(dev, "  - Can't create framebuffer\n");
> +
>                 return ERR_PTR(-ENOENT);
>         }
>
> @@ -1410,6 +1491,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct =
drm_crtc *crtc,
>         }
>         if (amdgpu_crtc->rmx_type !=3D RMX_OFF) {
>                 fixed20_12 a, b;
> +
>                 a.full =3D dfixed_const(src_v);
>                 b.full =3D dfixed_const(dst_v);
>                 amdgpu_crtc->vsc.full =3D dfixed_div(a, b);
> @@ -1429,7 +1511,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct =
drm_crtc *crtc,
>   *
>   * \param dev Device to query.
>   * \param pipe Crtc to query.
> - * \param flags Flags from caller (DRM_CALLED_FROM_VBLIRQ or 0).
> + * \param flags from caller (DRM_CALLED_FROM_VBLIRQ or 0).
>   *              For driver internal use only also supports these flags:
>   *
>   *              USE_REAL_VBLANKSTART to use the real start of vblank ins=
tead
> @@ -1504,8 +1586,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_d=
evice *dev,
>
>         /* Called from driver internal vblank counter query code? */
>         if (flags & GET_DISTANCE_TO_VBLANKSTART) {
> -           /* Caller wants distance from real vbl_start in *hpos */
> -           *hpos =3D *vpos - vbl_start;
> +               /* Caller wants distance from real vbl_start in *hpos */
> +               *hpos =3D *vpos - vbl_start;
>         }
>
>         /* Fudge vblank to start a few scanlines earlier to handle the
> @@ -1527,7 +1609,7 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_d=
evice *dev,
>
>         /* In vblank? */
>         if (in_vbl)
> -           ret |=3D DRM_SCANOUTPOS_IN_VBLANK;
> +               ret |=3D DRM_SCANOUTPOS_IN_VBLANK;
>
>         /* Called from driver internal vblank counter query code? */
>         if (flags & GET_DISTANCE_TO_VBLANKSTART) {
> @@ -1635,6 +1717,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_dev=
ice *adev)
>
>                 if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_displ=
ay) {
>                         struct amdgpu_bo *aobj =3D gem_to_amdgpu_bo(amdgp=
u_crtc->cursor_bo);
> +
>                         r =3D amdgpu_bo_reserve(aobj, true);
>                         if (r =3D=3D 0) {
>                                 amdgpu_bo_unpin(aobj);
> @@ -1642,9 +1725,9 @@ int amdgpu_display_suspend_helper(struct amdgpu_dev=
ice *adev)
>                         }
>                 }
>
> -               if (fb =3D=3D NULL || fb->obj[0] =3D=3D NULL) {
> +               if (!fb || !fb->obj[0])
>                         continue;
> -               }
> +
>                 robj =3D gem_to_amdgpu_bo(fb->obj[0]);
>                 if (!amdgpu_display_robj_is_fb(adev, robj)) {
>                         r =3D amdgpu_bo_reserve(robj, true);
> @@ -1671,6 +1754,7 @@ int amdgpu_display_resume_helper(struct amdgpu_devi=
ce *adev)
>
>                 if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_displ=
ay) {
>                         struct amdgpu_bo *aobj =3D gem_to_amdgpu_bo(amdgp=
u_crtc->cursor_bo);
> +
>                         r =3D amdgpu_bo_reserve(aobj, true);
>                         if (r =3D=3D 0) {
>                                 r =3D amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMA=
IN_VRAM);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.h
> index 9d19940f73c8..4cefaec6a495 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> @@ -23,17 +23,41 @@
>  #ifndef __AMDGPU_DISPLAY_H__
>  #define __AMDGPU_DISPLAY_H__
>
> -#define amdgpu_display_vblank_get_counter(adev, crtc) (adev)->mode_info.=
funcs->vblank_get_counter((adev), (crtc))
> -#define amdgpu_display_backlight_set_level(adev, e, l) (adev)->mode_info=
.funcs->backlight_set_level((e), (l))
> -#define amdgpu_display_backlight_get_level(adev, e) (adev)->mode_info.fu=
ncs->backlight_get_level((e))
> -#define amdgpu_display_hpd_sense(adev, h) (adev)->mode_info.funcs->hpd_s=
ense((adev), (h))
> -#define amdgpu_display_hpd_set_polarity(adev, h) (adev)->mode_info.funcs=
->hpd_set_polarity((adev), (h))
> -#define amdgpu_display_hpd_get_gpio_reg(adev) (adev)->mode_info.funcs->h=
pd_get_gpio_reg((adev))
> -#define amdgpu_display_bandwidth_update(adev) (adev)->mode_info.funcs->b=
andwidth_update((adev))
> -#define amdgpu_display_page_flip(adev, crtc, base, async) (adev)->mode_i=
nfo.funcs->page_flip((adev), (crtc), (base), (async))
> -#define amdgpu_display_page_flip_get_scanoutpos(adev, crtc, vbl, pos) (a=
dev)->mode_info.funcs->page_flip_get_scanoutpos((adev), (crtc), (vbl), (pos=
))
> -#define amdgpu_display_add_encoder(adev, e, s, c) (adev)->mode_info.func=
s->add_encoder((adev), (e), (s), (c))
> -#define amdgpu_display_add_connector(adev, ci, sd, ct, ib, coi, h, r) (a=
dev)->mode_info.funcs->add_connector((adev), (ci), (sd), (ct), (ib), (coi),=
 (h), (r))
> +u32 amdgpu_display_vblank_get_counter(struct amdgpu_device *adev,
> +                                     int crtc);
> +bool amdgpu_display_hpd_sense(struct amdgpu_device *adev,
> +                             enum amdgpu_hpd_id hpd);
> +void amdgpu_display_hpd_set_polarity(struct amdgpu_device *adev,
> +                                    enum amdgpu_hpd_id hpd);
> +void amdgpu_display_backlight_set_level(struct amdgpu_device *adev,
> +                                       struct amdgpu_encoder *amdgpu_enc=
oder,
> +                                       u8 level);
> +u8 amdgpu_display_backlight_get_level(struct amdgpu_device *adev,
> +                                     struct amdgpu_encoder *amdgpu_encod=
er);
> +bool amdgpu_display_hpd_sense(struct amdgpu_device *adev,
> +                             enum amdgpu_hpd_id hpd);
> +void amdgpu_display_hpd_set_polarity(struct amdgpu_device *adev,
> +                                    enum amdgpu_hpd_id hpd);
> +u32 amdgpu_display_hpd_get_gpio_reg(struct amdgpu_device *adev);
> +void amdgpu_display_bandwidth_update(struct amdgpu_device *adev);
> +void amdgpu_display_page_flip(struct amdgpu_device *adev,
> +                             int crtc_id, u64 crtc_base,
> +                              bool async);
> +int amdgpu_display_page_flip_get_scanoutpos(struct amdgpu_device *adev, =
int crtc,
> +                                           u32 *vbl, u32 *position);
> +
> +void amdgpu_display_add_encoder(struct amdgpu_device *adev,
> +                               u32 encoder_enum,
> +                               u32 supported_device,
> +                               u16 caps);
> +void amdgpu_display_add_connector(struct amdgpu_device *adev,
> +                                 u32 connector_id,
> +                                 u32 supported_device,
> +                                 int connector_type,
> +                                 struct amdgpu_i2c_bus_rec *i2c_bus,
> +                                 u16 connector_object_id,
> +                                 struct amdgpu_hpd *hpd,
> +                                 struct amdgpu_router *router);
>
>  void amdgpu_display_hotplug_work_func(struct work_struct *work);
>  void amdgpu_display_update_priority(struct amdgpu_device *adev);
> --
> 2.25.1
>
