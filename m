Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8391EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 19:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458BF60EFD
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 19:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 458BF60EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27DB89E0D;
	Mon, 27 Sep 2021 19:17:32 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE4289E0D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 19:17:30 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id x124so26928304oix.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=h+G678zxTRNy+ObotE/FKbBlfNAHM072vsCplvAPsEQ=;
 b=UIjLNr3EL8hr7Po9/wuhxK0n4v+MySBr55Of6fye6DPmi5EZhTkmawfs/ciuznqD+p
 sqya0bpZBR1lxQBHel3BJSXpJ3v6g4YtPKEn/lrtwj+vsFhkFgcCtTlFI6bIoN6P9IXL
 mlSY4c73VTS+Jgrurk5YO0vbFvkysMdrerVHpBjqEmhTwgEA7m/c1WXeClr5XeC0aMdw
 WeN8bNgZ6LMjU/kU7NkBNqD7TKjjZheMoqXer/6SYCrWFCxZd9TlqrOfZslrugPYgjMo
 txSenfDrEj3fvvNqWY5s8HgfUDCDUE6m6TbquiBpZ3Zp39sZw6NAQzOI8OPrPA3jCQdq
 aQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=h+G678zxTRNy+ObotE/FKbBlfNAHM072vsCplvAPsEQ=;
 b=5lJVQhryBUNp8KhQY5vWD+h6/Rnv6lvx5OrL2KDFxqiBT/sCXlD66/NWHL1LYIkPvk
 qD5Axjen9c0hkXp07MRFNKzwjTIsNfByxb+Vx7wleoWuOeiYsFDnbluCy4a/tOTF85LG
 hQmsHBioST5m0iKw5QT58x+fduUS8SDDiSV3cuKPZl1Dmf66BhMGPAY47+UeMV53sxKf
 TTvI+ytHwASm6jNeU3P1JOz9aLgRiChM//ZLuXWFXZj9+4rD1rUj4f6wvgCT6m4YSeTb
 i65SlMjVfqJRWs+EBZ5lszTi4B/PX1hLgYX4OMiA9wayQVbU1v2iLlga/d1NIkSpg1mp
 f3fw==
X-Gm-Message-State: AOAM531QfHXtYPmgxWqVKuypvjlRt4Wt2m1BLECB2yyB2ZZ3khsURpwE
 2dL9onWPYt3Qul9TlPWBtSANzp/WPtzZAqGXmrGNIEbR
X-Google-Smtp-Source: ABdhPJzo0+qvBUpeSqQwZQadzMHzvW+MA+7T1FSaw9yy6sRIGTge8vuiHqKw63qiqTKhME6H7Djgjgws76L1YVnJBdg=
X-Received: by 2002:aca:ab4d:: with SMTP id u74mr561061oie.120.1632770249962; 
 Mon, 27 Sep 2021 12:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210927150821.389427-1-contact@emersion.fr>
In-Reply-To: <20210927150821.389427-1-contact@emersion.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Sep 2021 15:17:19 -0400
Message-ID: <CADnq5_MBVmec4MP5YizegcdQZe2XKBwsVdqSCWizo73n4x1Z=w@mail.gmail.com>
Subject: Re: [PATCH v2] amdgpu: check tiling flags when creating FB on GFX8-
To: Simon Ser <contact@emersion.fr>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "for 3.8" <stable@vger.kernel.org>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>, 
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 27, 2021 at 11:09 AM Simon Ser <contact@emersion.fr> wrote:
>
> On GFX9+, format modifiers are always enabled and ensure the
> frame-buffers can be scanned out at ADDFB2 time.
>
> On GFX8-, format modifiers are not supported and no other check
> is performed. This means ADDFB2 IOCTLs will succeed even if the
> tiling isn't supported for scan-out, and will result in garbage
> displayed on screen [1].
>
> Fix this by adding a check for tiling flags for GFX8 and older.
> The check is taken from radeonsi in Mesa (see how is_displayable
> is populated in gfx6_compute_surface).
>
> Changes in v2: use drm_WARN_ONCE instead of drm_WARN (Michel)
>
> [1]: https://github.com/swaywm/wlroots/issues/3185
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: stable@vger.kernel.org
> Acked-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

Applied.  Thanks.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 31 +++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index 58bfc7f00d76..5faf3ef28080 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -837,6 +837,28 @@ static int convert_tiling_flags_to_modifier(struct a=
mdgpu_framebuffer *afb)
>         return 0;
>  }
>
> +/* Mirrors the is_displayable check in radeonsi's gfx6_compute_surface *=
/
> +static int check_tiling_flags_gfx6(struct amdgpu_framebuffer *afb)
> +{
> +       u64 micro_tile_mode;
> +
> +       /* Zero swizzle mode means linear */
> +       if (AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) =3D=3D 0)
> +               return 0;
> +
> +       micro_tile_mode =3D AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TI=
LE_MODE);
> +       switch (micro_tile_mode) {
> +       case 0: /* DISPLAY */
> +       case 3: /* RENDER */
> +               return 0;
> +       default:
> +               drm_dbg_kms(afb->base.dev,
> +                           "Micro tile mode %llu not supported for scano=
ut\n",
> +                           micro_tile_mode);
> +               return -EINVAL;
> +       }
> +}
> +
>  static void get_block_dimensions(unsigned int block_log2, unsigned int c=
pp,
>                                  unsigned int *width, unsigned int *heigh=
t)
>  {
> @@ -1103,6 +1125,7 @@ int amdgpu_display_framebuffer_init(struct drm_devi=
ce *dev,
>                                     const struct drm_mode_fb_cmd2 *mode_c=
md,
>                                     struct drm_gem_object *obj)
>  {
> +       struct amdgpu_device *adev =3D drm_to_adev(dev);
>         int ret, i;
>
>         /*
> @@ -1122,6 +1145,14 @@ int amdgpu_display_framebuffer_init(struct drm_dev=
ice *dev,
>         if (ret)
>                 return ret;
>
> +       if (!dev->mode_config.allow_fb_modifiers) {
> +               drm_WARN_ONCE(dev, adev->family >=3D AMDGPU_FAMILY_AI,
> +                             "GFX9+ requires FB check based on format mo=
difier\n");
> +               ret =3D check_tiling_flags_gfx6(rfb);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (dev->mode_config.allow_fb_modifiers &&
>             !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
>                 ret =3D convert_tiling_flags_to_modifier(rfb);
> --
> 2.33.0
>
>
