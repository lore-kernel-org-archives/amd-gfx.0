Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B75EEB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 16:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E9610E5DC;
	Thu, 20 Jul 2023 16:12:19 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B3B10E5DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 16:12:17 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1b730eb017bso729133fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689869536; x=1690474336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8A4YoKpXhj3KjeHaBaZdHD9CtdbiiCRa+Bj2kTYQOfM=;
 b=BzHpxq+ppG+o8t/n8Eq3XPykm2O8Yg2IRSRuozJ+E8duNYzJK7qoj7GYRZxf3Mr3jW
 7Z8ypDVAKguKTbfIUKVyk6fy1PoMkwQ4oXM0SCS4Yssx/az4/JsUTmzShQPEZpGx03kx
 2gcpdavF1SpGvAQRaJTcBZp+pf39wCvgBhC+nyz86j6Xd70xmmWdlQHjYzPbFwJ2ywmq
 NuYmqvCtuLMQ9M+b+ChudJkw7cYhxzBwekn5rwvu1FBG2Yv7sDikix4n5U7NZTge1erJ
 3yXF5VUN9VQPIaZRT1gWb/ZAF70LpR7ctXj+7heVJHSeM0coRiDOCl7tFhIU4sYILR5h
 Cgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689869536; x=1690474336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8A4YoKpXhj3KjeHaBaZdHD9CtdbiiCRa+Bj2kTYQOfM=;
 b=eBCMm8Q1iLdy+9kIV6Otdeb+rlCziwugAWEKoA0QJAu8fEjxSngb4SgMr0JbpidoS2
 qyYpe9XF+3wO3NNDb/ObB1J0yWCafu/WN9AbJC+tNvR0CVxDW0XRpT717G8p9KxiZtA0
 +74k897Tv617+GksK7AOihayUV6tFPOkEalAnQxLvSqz6YX6xW25s2myslt4DWtGqJMb
 X3h6bPdpu87YCmA+zpLUfdZJCy9EAoWIJfbt/YjXXO8pH3GiHa/J1z4cUqDVEb2lUR4d
 39PlDNQRt6LPN1T8uzvNKjfdVyazqOWpVEK6NNfXZVOs6fglqhaBEMLklEdN0Kfc7pFE
 11ow==
X-Gm-Message-State: ABy/qLbIvXBkt9OLtaQ788pwqVZWDHJkdljN6iOO4uVM4MWPXdoMu3gu
 qZrEK+8GCPOJoEwCF8J3zOWXqFHTDKckYumZhbMRJa3Hbio=
X-Google-Smtp-Source: APBJJlESj531eAIepbP4v/FWrPHgqev+gCl8bZPCov6UTQW62frcIqIAgvbRG2Aqi7e/gNvSO3Ik+mCrjH2YbV5kNEg=
X-Received: by 2002:a05:6870:2216:b0:1b0:83f5:e82a with SMTP id
 i22-20020a056870221600b001b083f5e82amr2476047oaf.29.1689869536462; Thu, 20
 Jul 2023 09:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230719051939.811520-2-srinivasan.shanmugam@amd.com>
 <20230720024229.78400-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230720024229.78400-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jul 2023 12:12:05 -0400
Message-ID: <CADnq5_OTAbC60vzrywFOpQTJfA42rRrt=ZihhxNa8+k7M4sQVg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: Fix warnings in amdgpu/amdgpu_display.c
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

On Wed, Jul 19, 2023 at 10:42=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the below checkpatch.pl warnings:
>
> WARNING: Block comments use * on subsequent lines
> WARNING: Block comments use a trailing */ on a separate line
> WARNING: suspect code indent for conditional statements (8, 12)
> WARNING: braces {} are not necessary for single statement blocks
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 42 ++++++++++++---------
>  1 file changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index b702f499f5fb..9a74eae50ad4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -124,7 +124,7 @@ static void amdgpu_display_flip_work_func(struct work=
_struct *__work)
>
>         struct drm_crtc *crtc =3D &amdgpu_crtc->base;
>         unsigned long flags;
> -       unsigned i;
> +       unsigned int i;
>         int vpos, hpos;
>
>         for (i =3D 0; i < work->shared_count; ++i)
> @@ -201,7 +201,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_c=
rtc *crtc,
>         u64 tiling_flags;
>         int i, r;
>
> -       work =3D kzalloc(sizeof *work, GFP_KERNEL);
> +       work =3D kzalloc(sizeof(*work), GFP_KERNEL);
>         if (work =3D=3D NULL)
>                 return -ENOMEM;
>
> @@ -332,13 +332,15 @@ int amdgpu_display_crtc_set_config(struct drm_mode_=
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
> @@ -507,11 +509,10 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connect=
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
> @@ -520,10 +521,12 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connect=
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
> @@ -1216,8 +1219,10 @@ amdgpu_display_user_framebuffer_create(struct drm_=
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

Can you rework this to be a single debug statement?  Maybe
               drm_dbg_kms(dev,
                           "No GEM object associated to handle 0x%08X,
can't create framebuffer\n"
                           mode_cmd->handles[0]);

With that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> +
>                 return ERR_PTR(-ENOENT);
>         }
>
> @@ -1410,6 +1415,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct =
drm_crtc *crtc,
>         }
>         if (amdgpu_crtc->rmx_type !=3D RMX_OFF) {
>                 fixed20_12 a, b;
> +
>                 a.full =3D dfixed_const(src_v);
>                 b.full =3D dfixed_const(dst_v);
>                 amdgpu_crtc->vsc.full =3D dfixed_div(a, b);
> @@ -1429,7 +1435,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct =
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
> @@ -1504,8 +1510,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_d=
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
> @@ -1527,7 +1533,7 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_d=
evice *dev,
>
>         /* In vblank? */
>         if (in_vbl)
> -           ret |=3D DRM_SCANOUTPOS_IN_VBLANK;
> +               ret |=3D DRM_SCANOUTPOS_IN_VBLANK;
>
>         /* Called from driver internal vblank counter query code? */
>         if (flags & GET_DISTANCE_TO_VBLANKSTART) {
> @@ -1635,6 +1641,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_dev=
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
> @@ -1642,9 +1649,9 @@ int amdgpu_display_suspend_helper(struct amdgpu_dev=
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
> @@ -1671,6 +1678,7 @@ int amdgpu_display_resume_helper(struct amdgpu_devi=
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
> --
> 2.25.1
>
