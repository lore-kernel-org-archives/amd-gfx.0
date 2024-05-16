Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C68AC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 16:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2214F10E204;
	Thu, 16 May 2024 16:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LEp5lQxp";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E896210E204
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 16:07:15 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-65b4d0a7391so388057a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715875635; x=1716480435; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2hJn77cMlkGBGi9Lv/D889LZ7yDKke96CbtN1ur9bQ=;
 b=LEp5lQxpwIDpkcauBc8sbPyY0Ev2JeSUHCnI2x3OBeFIkqxRNTlLgb5fXy9hqT3jjR
 J38D9ib8cHwqJGdZXi5DQiitN8v3Kq3iUbEp2h7xn9LnWN132rHUcjBnUYX+Z/V4PAyy
 pVhbwZUWxfbOwm/hn+X5ezZ4v6LTQiKlym5VYnTkHelrwbZCn0w8qlDocuJt2tmrasfl
 oNGMGCrmQzY+ZgRxF/elLzJKhJP6S+29FFd2QrUyKFeNAHV9efN+Z2Td7ppRGH9jg7D/
 qPnVR7jePvFMPcFX5TOdY20wAfEeHI0xaDpyT7Vs3QlG+Oamn3daar4Jn1IjAXnHEj1h
 Vc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715875635; x=1716480435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2hJn77cMlkGBGi9Lv/D889LZ7yDKke96CbtN1ur9bQ=;
 b=H9Kc+fNWEjpV/dui9SQV+s9xja2mcIZyNu81cjdoFBBIiVGXFUB4+6koaztLxjZNvZ
 O4RmILQdzNWM4WwNRrXJ3na1zR+kPTyz2gjUSx2yvFRsi5tyQKsQouWx2aonXDgNLCe/
 sXj7/SoRADHKOpqFVZqqTq+8Mm7PkHdOxkvsK8/BYVIPQcXl6SFig4ZZqS4NlQh0ezPA
 2HAlK2SGYWs7z+2gBpxo8KEaQoIBJ3EpNyw2tZlXmnqtjezEOzFqr0oSSaQqg8hm4Efh
 NsTktOSz38yJ10rV4rYJE9bWSkKSFOHAXTWLtREyrig/7RDcs4g7iUEmCITn31uM+Tct
 f/+A==
X-Gm-Message-State: AOJu0YyhOgTqVy43JWpm+AKKfd6X2ajcwW8A1DGv6ePy/wGn1doxk0ll
 DgbVce1qyHOy7XpCgk/yLBoNqCmf3CKgnHN/2Ox40GgxGjD3s4aTDWnsN/QSQoJAZHkpQmvoaQi
 nUjw4WE6MT1r6WYbAJQUzZ2cwfAc=
X-Google-Smtp-Source: AGHT+IFw5HPWXhphVLekh1dwWivCgUzZbTyoTblWMSixZCtiNCtWk3d72Tj9p1x3AGHSIGUJrB2K9hCjbETrz9XBKY0=
X-Received: by 2002:a17:90a:6542:b0:2b3:be55:bf6f with SMTP id
 98e67ed59e1d1-2b6cc76bdf6mr17746206a91.22.1715875634967; Thu, 16 May 2024
 09:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240515191954.2605211-1-ruijing.dong@amd.com>
In-Reply-To: <20240515191954.2605211-1-ruijing.dong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 May 2024 12:07:03 -0400
Message-ID: <CADnq5_MycO8K0m=Z8OUSF7W8g3cMuitK0DcPFAbdDK2NR9=WOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: update vcn5 enc/dec capabilities
To: Ruijing Dong <ruijing.dong@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, leo.liu@amd.com
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

On Wed, May 15, 2024 at 3:57=E2=80=AFPM Ruijing Dong <ruijing.dong@amd.com>=
 wrote:
>
> Update the capabilities for supporting 8k encoding/decoding.
>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc24.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amd=
gpu/soc24.c
> index b2b9e0f83bdf..d065649c7c78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -48,9 +48,9 @@
>  static const struct amd_ip_funcs soc24_common_ip_funcs;
>
>  static const struct amdgpu_video_codec_info vcn_5_0_0_video_codecs_encod=
e_array_vcn0[] =3D {
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 384=
0, 2160, 0)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 7680, 43=
20, 0)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 7680, 432=
0, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 2304, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 435=
2, 0)},
>  };
>
>  static const struct amdgpu_video_codecs vcn_5_0_0_video_codecs_encode_vc=
n0 =3D {
> @@ -59,8 +59,8 @@ static const struct amdgpu_video_codecs vcn_5_0_0_video=
_codecs_encode_vcn0 =3D {
>  };
>
>  static const struct amdgpu_video_codec_info vcn_5_0_0_video_codecs_decod=
e_array_vcn0[] =3D {
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 2160, 52)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
20, 183)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 186)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 435=
2, 0)},
> --
> 2.44.0.326.g07fa98e8e8
>
