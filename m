Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F36EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 14:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73EE5112B4C;
	Mon, 22 Apr 2024 14:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZZd3V6LP";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2FF112B4B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 14:16:27 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ac9e8e4e3dso2233549a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713795387; x=1714400187; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcOcK2zzD0F+a+pSAebobH/sa2nUS7JUsb8E0SlqRgI=;
 b=ZZd3V6LP1AO5lvmR10bhCLVl+72mY/fdCvsvLeEW7DpcBTbOXDgGEsOaZkKIqhQGD+
 5Vsy2Dc/eGXtfInGxSSTsRvZzu/bbgh5vGEvXS5fLTykgOOFGN0iF5sLnlIsfDciYS81
 Ovr+GWp6789giwox6vciwiOsumeN3GD7npmYXFWSqtLjpGgy5zZLFZGyAbrpZmINicwF
 l8F8mqfwjDOVfJtlkloY4PdRangyjxNBkkhHBig+B+y1NMCLpDiKSXz3v7WTHN6vt+bS
 Ae/dnj2R4pUtHqPkbxkizjw5nZ+r5zaqTyZn2dazQztsj7QJxfPjB7SmkMVqNtfBLy38
 XWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713795387; x=1714400187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcOcK2zzD0F+a+pSAebobH/sa2nUS7JUsb8E0SlqRgI=;
 b=wAI38MNS70f9YiNz0+pfXqINb/+ZDcxSZSA+FoLS1rG+suXopU+axLabuGEqbCh9jk
 2uRuE4BRb56XVXrmcb5yYlvvubCTqv0RCFiUzXyLUBD/ozAcwf1HnZukxfnr4sKESWOa
 XCM+eYqGxOqXnAKLrejtPLxb1Kk67VRc0KPaEqqfZLmhtPoeaV6zdq8HBKNZeqMNfu4E
 6C9pDa2+HodMd7LVUPmt2hiMWZn+0syW15XJJsvG17RdjHp++4twCn2pFcsDIjxaV4H7
 riqo8opvSKDn/r8QafCBsoyw3O+8BQ+JfzmreE50iCnWqti7q54wB++PHEfHCIfChPh9
 qSqg==
X-Gm-Message-State: AOJu0YzBeyGtP7NLxdAkc70H8/i8RVKj9Xwwb684aR5YSoja8npMflse
 aswS+0dHo/XKrF15OYAOk7YW+JItIdBjuxf0oM1S5YTWQ6N1Ui7XkSckzTgejVE1+Ljj5zHjtZV
 M6QCcHMbsoy/8f14TEoDvSPWK4ZT6tQ==
X-Google-Smtp-Source: AGHT+IFag6TfkzE50RJFgT98WEZefD1EzgIR/e9kXh6sMyzeiU/wTkJFrMW5xutqqihBNVjmTsuFBLUW9veRyEcBP8s=
X-Received: by 2002:a17:90a:67ce:b0:2ad:1e60:502a with SMTP id
 g14-20020a17090a67ce00b002ad1e60502amr4202615pjm.38.1713795387202; Mon, 22
 Apr 2024 07:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240422133524.1476394-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20240422133524.1476394-1-sathishkumar.sundararaju@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Apr 2024 10:16:14 -0400
Message-ID: <CADnq5_NwE8uksd_v2q4EsxZ3QfF8v-tV2=dewr1KCycgxZs25g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update jpeg max decode resolution
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Leo Liu <Leo.Liu@amd.com>
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

On Mon, Apr 22, 2024 at 10:12=E2=80=AFAM Sathishkumar S
<sathishkumar.sundararaju@amd.com> wrote:
>
> jpeg ip version v2.1 and higher supports 16kx16k resolution decode
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c    | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index b5303cd3cb53..12e54047bf79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -110,7 +110,7 @@ static const struct amdgpu_video_codec_info sc_video_=
codecs_decode_array_vcn0[]
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 409=
6, 4)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 186)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 40=
96, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 435=
2, 0)},
>  };
> @@ -121,7 +121,7 @@ static const struct amdgpu_video_codec_info sc_video_=
codecs_decode_array_vcn1[]
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 409=
6, 4)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 186)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 40=
96, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
>  };
>
> @@ -199,7 +199,7 @@ static const struct amdgpu_video_codec_info yc_video_=
codecs_decode_array[] =3D {
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 186)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 40=
96, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 435=
2, 0)},
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index a5d3c66b5868..170f02e96717 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -143,7 +143,7 @@ static const struct amdgpu_video_codec_info rn_video_=
codecs_decode_array[] =3D
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 409=
6, 4)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 186)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 40=
96, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
>  };
>
> @@ -156,7 +156,7 @@ static const struct amdgpu_video_codecs rn_video_code=
cs_decode =3D
>  static const struct amdgpu_video_codec_info vcn_4_0_3_video_codecs_decod=
e_array[] =3D {
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 186)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 40=
96, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 435=
2, 0)},
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index 27c26e42120e..fb6797467571 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -72,7 +72,7 @@ static const struct amdgpu_video_codecs vcn_4_0_0_video=
_codecs_encode_vcn1 =3D {
>  static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decod=
e_array_vcn0[] =3D {
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 186)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 40=
96, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 435=
2, 0)},
>  };
> @@ -80,7 +80,7 @@ static const struct amdgpu_video_codec_info vcn_4_0_0_v=
ideo_codecs_decode_array_
>  static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decod=
e_array_vcn1[] =3D {
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 43=
52, 186)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 40=
96, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
>  };
>
> --
> 2.25.1
>
