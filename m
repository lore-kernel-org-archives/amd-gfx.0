Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EEAC282C1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 15:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A50D910ECD2;
	Fri, 28 Feb 2025 15:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m8AmOtMT";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85EBE10ECD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 15:20:00 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2f74e6c6cbcso609275a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 07:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740755999; x=1741360799; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeSnxk0KmJsjFK8rDS8qrzU5fKu/3PUi2cFHip9zTCg=;
 b=m8AmOtMTY44f1vvPk77wWXXH8Rtg/bl/RPeqbMzyMyzlrKYmbK97jthuPPwhruRKhE
 S/LEVCEV6J8LYXZbW4kNXEfCXEHz8EM+RVInAapVkE8bbOdoPmqCXwpeQh/qIkF5+g8R
 NxTB9ZzTBUjnmXsYowAIpF7YwWThYJ5JaYbpeI1vsMonAapM6zNZSb0HmTBHyL4kE1vv
 fbId9vFuVzoHoa3te2Dd0t0nIlaGI0xXEjVL63Vvz6TUTl/wFfj+xGG4KjV8wVLYF5xo
 Q06zku8FPV1x/jUikrXiPWCtrXjhqrRUkeVIspi9LQXjeXzPDEluo7R6XsLDs2Fbxya7
 yWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740755999; x=1741360799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xeSnxk0KmJsjFK8rDS8qrzU5fKu/3PUi2cFHip9zTCg=;
 b=fORF004MtRwaYzaF+PtfGMN5KdC+NkBXzMxOXW/ykVAcT20C+jIrQVvEFBSaDPJihs
 cGZR952dFG5Tv6oiCHsxCCXCE+PHX/iwawU2fVU+1wsEFPvCtpbuOawDAIkADfC7pkG+
 zq5VGomKnkbuDgNefdyUQqUEc/3OEbhZOVD/cuSXyVmf0BeuNOtiIVIS8yhVOmAZlGDG
 way134iBNSJur2bVExlr29ZbMXFWtBChFJVxBAdsMehYZuHfE6d1/Vlj370paix371yQ
 7gaKrXWBXp/lRNqH8ZaagumENJq1h8J8KpUUBZueffX7AZ/pg8Rr8eQjKtxztrvZJGIj
 8qSw==
X-Gm-Message-State: AOJu0YweN9Ub6sqWLephDbf4/OPdI/kjgjOitpdx4S8+wCw/6zd3j488
 BRUM3a22uehnVFJFZSkCghIKK/8xnMHYfSfSJlqO3i3rpmp1c2TqPYxnj9vP5gBrc13rIbaujce
 x4vKNp3+oynKVPCWCwZnKmc07WPhj8g==
X-Gm-Gg: ASbGncvFY8X8UZkOu9X/1ZjqlL9VzfPZesQ6rDJoMmVNF8jrJa5xJlDYNwEm/TLYUe7
 ZD9NKOl/ljWBOaZ5sRuoPsvXX9TYzuG1UW1/7yQ2IW5sIZkncorLr14u+IH4UAflxqjbU8zrCmq
 9eibMqX40=
X-Google-Smtp-Source: AGHT+IF9Czk8yjmuPSl8Ga35/QHmP0fhhlRRWa/AMDFINboGA7YvuJ3S8CnAtN2EfsRue9kqCrsamZd5E2wmQdP36ks=
X-Received: by 2002:a17:90b:4b87:b0:2fe:b54a:78 with SMTP id
 98e67ed59e1d1-2febabdc238mr2341337a91.4.1740755999249; Fri, 28 Feb 2025
 07:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20250228144832.50699-2-david.rosca@amd.com>
 <20250228144832.50699-5-david.rosca@amd.com>
In-Reply-To: <20250228144832.50699-5-david.rosca@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Feb 2025 10:19:47 -0500
X-Gm-Features: AQ5f1Jqym-JZemC8rEHQTL1IRi9H0c6ssSmtcb-A3woyMBFkV0P3lFkcU4evWAU
Message-ID: <CADnq5_Pu4-JiGycOYzevBf0f5FtQHPGCkUFUSBtQq5WAg-xg5A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/amdgpu: Update SRIOV video codec caps
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

1-3 are:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
for this patch, you might want to check with the SR-IOV team.  I think
there are some limitations in VFs that require different settings?  If
not, you can add my AB to this one as well.

Alex

On Fri, Feb 28, 2025 at 9:59=E2=80=AFAM David Rosca <david.rosca@amd.com> w=
rote:
>
> There have been multiple fixes to the video caps that are missing for
> SRIOV. Update the SRIOV caps with correct values.
>
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c    | 16 ++++++++--------
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 10 ++--------
>  2 files changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 32b824c3658f..50e77d9b30af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -141,23 +141,23 @@ static struct amdgpu_video_codec_info sriov_sc_vide=
o_codecs_encode_array[] =3D {
>  };
>
>  static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array=
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
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 40=
96, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 435=
2, 0)},
>  };
>
>  static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array=
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
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 40=
96, 0)},
> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 1=
6384, 0)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 435=
2, 0)},
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index dd5d04c068f9..ad36c96478a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -117,23 +117,17 @@ static struct amdgpu_video_codecs sriov_vcn_4_0_0_v=
ideo_codecs_encode_vcn1 =3D {
>  };
>
>  static struct amdgpu_video_codec_info sriov_vcn_4_0_0_video_codecs_decod=
e_array_vcn0[] =3D {
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4=
096, 3)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4=
096, 5)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 409=
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
>
>  static struct amdgpu_video_codec_info sriov_vcn_4_0_0_video_codecs_decod=
e_array_vcn1[] =3D {
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4=
096, 3)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4=
096, 5)},
>         {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 409=
6, 4096, 52)},
> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 409=
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
> --
> 2.43.0
>
