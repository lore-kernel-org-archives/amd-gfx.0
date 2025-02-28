Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94735C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 14:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4855210ECB4;
	Fri, 28 Feb 2025 14:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k61r6W3m";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0136510ECB4
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 14:21:47 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2fe8f6a4bfaso565860a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 06:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740752507; x=1741357307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+H1WLfmTvSZB8CKv7++7ilNR2p3rc+VR2lHhJYJxBYI=;
 b=k61r6W3moUb5AKvC1lDtqNMPD7dDQvASXi+/Hk4rSjpcisOpKAlEasnECNuE14sKQJ
 t7o6BKR5K8K0lTUZkZz1/6wthzJLcE67FbV8v7WtANifXnp1+pPSJUuyO98xpR7y+Ee7
 iygsDsmNWuJVt6jd0ck9ChG5pi4BoUhYrediTorqzyBHEdglmCAKy8XGmDrOO9c3BUX9
 cYe8XtWPFyKSGi7z9rMMrokgy9LH37zdn/7vrEPrqyxn4guKg3KahSYSGsldLZCpGP1A
 2G3gHtzC2k0oZfjCqa8FXS0aEhLsIeBcH1D/uPYmUu2VbhkLOQPWidR3lBBeDvXGO9Vn
 MC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740752507; x=1741357307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+H1WLfmTvSZB8CKv7++7ilNR2p3rc+VR2lHhJYJxBYI=;
 b=qUiyNNQOJE15Y1wgUKd4K09l2sQbBGF2fCrXoSnyU6g+WP8qk5BgvfqGAJce9TUCtb
 Nv/FDJoIdlaEzovlyU4m52HYVXssVlTkeBKtuyrqKq/qeoQ4iw79l+k3LrS92RD2PtHa
 Nf5wtD/rL+jIA4jMxubWrrKZdD+6O0GGhTORHzrMDR6jYC6pXKV8fVjcMiefmt+/jD8p
 HBIzwm5DQ1rwquFNdPA8+wMLxAyM5DjCRXnol1lt0fLOXSP0nDMGmE1wTc+f9Sq1G3US
 tVTHp2nmWGhv+Hzb78befo9oibZHBufzDS14S68tpazOfrwGClO35XlkPdhVj/a1/Iox
 kJEA==
X-Gm-Message-State: AOJu0Yx2b9NuNhaasSEBhnneExwlmtbsE4irt9++Z6B1T1MQeRscUWIP
 dQHDnulmD+ZBaJAqgPPSlrvIop6Oo/durXZ8B/dFMTXc/d6JsbDIHlATXWS5NlXPBAHK6Em78/y
 3bP9PRAM4KxT1ZAnY5x9nINNOr/w=
X-Gm-Gg: ASbGnctH336vLtMk+92VXTYuGYBrEq1+dWNn5CJDNLN6Pl0aGCbZapc1AXohwHiFPCR
 WRfhVmLPTsjv0lnlAF9fetARrDJRlhKzADeoeuO85LVvmbdCQhagi983tQV/xWBSmsN1azTaYWd
 0l7j4Vmt0=
X-Google-Smtp-Source: AGHT+IHjh1nb7yuC4MHJPu6J9GKZy142PPO4qp03QNq9WEtMpeOcISsu+RSD29GH2boQ37EjtBbEW2SOtjxyzo4q+d4=
X-Received: by 2002:a17:90b:1b06:b0:2ee:a558:b6bf with SMTP id
 98e67ed59e1d1-2febac0cbcbmr2204724a91.8.1740752507233; Fri, 28 Feb 2025
 06:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20250228132429.4842-4-david.rosca@amd.com>
In-Reply-To: <20250228132429.4842-4-david.rosca@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Feb 2025 09:21:34 -0500
X-Gm-Features: AQ5f1Jr8jPWLezX7ExV4kYVKqaIfBBI5BzjVHezb3xua89xKUQrkRyoiYPoqWLI
Message-ID: <CADnq5_PP7CE0-Jowq8c4GZQaQ81Ldm98Oo4maeSbKwA=v4KF8g@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: Fix MPEG2,
 MPEG4 and VC1 video caps max size
To: David Rosca <david.rosca@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Fri, Feb 28, 2025 at 8:34=E2=80=AFAM David Rosca <david.rosca@amd.com> w=
rote:
>
> 1920x1088 is the maximum supported resolution.
>
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 18 ++++++++---------
>  drivers/gpu/drm/amd/amdgpu/vi.c | 36 ++++++++++++++++-----------------

I think soc15.c needs similar fixes?  Also, I think we need to bump
the driver version so mesa knows what kernel version has the proper
limits.

Alex

>  2 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 8068f384f56c..a18e6fb9fa3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -78,10 +78,10 @@ static const struct amdgpu_video_codecs nv_video_code=
cs_encode =3D {
>
>  /* Navi1x */
>  static const struct amdgpu_video_codec_info nv_video_codecs_decode_array=
[] =3D {
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4=
096, 3)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4=
096, 5)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1=
088, 3)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1=
088, 5)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 409=
6, 4)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 108=
8, 4)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 186)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 40=
96, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
> @@ -104,10 +104,10 @@ static const struct amdgpu_video_codecs sc_video_co=
decs_encode =3D {
>  };
>
>  static const struct amdgpu_video_codec_info sc_video_codecs_decode_array=
_vcn0[] =3D {
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4=
096, 3)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4=
096, 5)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1=
088, 3)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1=
088, 5)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 409=
6, 4)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 108=
8, 4)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 186)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
> @@ -115,10 +115,10 @@ static const struct amdgpu_video_codec_info sc_vide=
o_codecs_decode_array_vcn0[]
>  };
>
>  static const struct amdgpu_video_codec_info sc_video_codecs_decode_array=
_vcn1[] =3D {
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4=
096, 3)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4=
096, 5)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1=
088, 3)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1=
088, 5)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 409=
6, 4)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 108=
8, 4)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 186)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu=
/vi.c
> index 3bbbb75242d9..9b3510e53112 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -167,16 +167,16 @@ static const struct amdgpu_video_codec_info tonga_v=
ideo_codecs_decode_array[] =3D
>  {
>         {
>                 .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
> -               .max_width =3D 4096,
> -               .max_height =3D 4096,
> -               .max_pixels_per_frame =3D 4096 * 4096,
> +               .max_width =3D 1920,
> +               .max_height =3D 1088,
> +               .max_pixels_per_frame =3D 1920 * 1088,
>                 .max_level =3D 3,
>         },
>         {
>                 .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
> -               .max_width =3D 4096,
> -               .max_height =3D 4096,
> -               .max_pixels_per_frame =3D 4096 * 4096,
> +               .max_width =3D 1920,
> +               .max_height =3D 1088,
> +               .max_pixels_per_frame =3D 1920 * 1088,
>                 .max_level =3D 5,
>         },
>         {
> @@ -188,9 +188,9 @@ static const struct amdgpu_video_codec_info tonga_vid=
eo_codecs_decode_array[] =3D
>         },
>         {
>                 .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
> -               .max_width =3D 4096,
> -               .max_height =3D 4096,
> -               .max_pixels_per_frame =3D 4096 * 4096,
> +               .max_width =3D 1920,
> +               .max_height =3D 1088,
> +               .max_pixels_per_frame =3D 1920 * 1088,
>                 .max_level =3D 4,
>         },
>  };
> @@ -206,16 +206,16 @@ static const struct amdgpu_video_codec_info cz_vide=
o_codecs_decode_array[] =3D
>  {
>         {
>                 .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
> -               .max_width =3D 4096,
> -               .max_height =3D 4096,
> -               .max_pixels_per_frame =3D 4096 * 4096,
> +               .max_width =3D 1920,
> +               .max_height =3D 1088,
> +               .max_pixels_per_frame =3D 1920 * 1088,
>                 .max_level =3D 3,
>         },
>         {
>                 .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
> -               .max_width =3D 4096,
> -               .max_height =3D 4096,
> -               .max_pixels_per_frame =3D 4096 * 4096,
> +               .max_width =3D 1920,
> +               .max_height =3D 1088,
> +               .max_pixels_per_frame =3D 1920 * 1088,
>                 .max_level =3D 5,
>         },
>         {
> @@ -227,9 +227,9 @@ static const struct amdgpu_video_codec_info cz_video_=
codecs_decode_array[] =3D
>         },
>         {
>                 .codec_type =3D AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
> -               .max_width =3D 4096,
> -               .max_height =3D 4096,
> -               .max_pixels_per_frame =3D 4096 * 4096,
> +               .max_width =3D 1920,
> +               .max_height =3D 1088,
> +               .max_pixels_per_frame =3D 1920 * 1088,
>                 .max_level =3D 4,
>         },
>         {
> --
> 2.43.0
>
