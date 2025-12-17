Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615C6D66B9D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 19:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0895110E1B5;
	Wed, 17 Dec 2025 19:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WB0++YOG";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 875E410E1B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 19:32:40 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2a08ced9a36so11533675ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 11:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765999960; x=1766604760; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMpy36UEaMyT+waBnnzDRojb/3LCN8PmyQ/sBlcWCyo=;
 b=WB0++YOGE2jxJlnHGd7V7gC06tyIVhKD27tFiLdW7XpfIQj9H4hFxPIVPgjYnn9SOR
 LBooxuFhYEcRrZ6csSRFND5cr7A9+xq9OVjrDVwYi8qQQ9jlNfMqdWxcUtg/bX2di2pF
 hvZupqxV/1j1OWV/Zhjlk/TesGQXwYZSZqBZX/hcpzyxzpB1DWRhlfg2eH6Fp0cmzTTm
 JMdCCWRqosKQLpkE7hfPPaqzQQNGFDplRgNqTQiP4hO4VRzKLLBfkbXYuT1VzAhKyeO8
 vvbINrkWlfrIYmtCHC/wVsLW8SRTxeU++3CmGEALSKi5FpY7Cre/XdDM8Vy1Gda+wv7l
 F0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765999960; x=1766604760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jMpy36UEaMyT+waBnnzDRojb/3LCN8PmyQ/sBlcWCyo=;
 b=HsGFkjRdsBQuhOHBdq48N5UsbUmZ0B9VIiLKr7WpsCTW+rW1C8vZn7BOATrOdYadKn
 CVwERy5AGhoM2K3rSe11LPk7tWbZdUlTpVnJEZqMBNCSQWVbyqyHo9diSLCOKYDta0FS
 NQC1XZOriaRXPKiD8Ho36PWsz/Emwvhi35e11t/2/SyzZF9e6pjD0uVup2Sb4tV9c3EY
 pcdxfW8etg7CN5LZk8tBYJF221TtF/ErDm9XO9PbyR7cTx8fuv9CkxkgCLQPeSawN00V
 gUIKoAmqZtOPSxNOOsB3bNyjsdAdcF7yITqX49tKBSQcxRdOaLruj1wh9+wVd9oOrQCr
 6y/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQBQeqQrsqa4iGEor0X1pvKyyFi0mrYozqBqCVP6gqN3BDCA6ztCq9ghTGlyGii4fbHPljisUB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0TwZalKl7FUbtfyccpr3ZGdsSYp6E5Q2LNrUne7ro+HudM48l
 vajkV1+OuKjOz8INqoPPCB/1BPIw0cJmN2tOey463BmWQ2JkJXKSs7Cew/8XLkdWxsa20GACSq6
 uiFzWLDSsrW72qqSzbCp1FuGaOyKWe7YGSw==
X-Gm-Gg: AY/fxX7kiDO2NcqkDrgJlN6eDSWs0E53IDv4psAjw4NfWQbR2dWWp8D64tRGczXK2Ai
 vM14Ia0g+qKTdNR5yGIxnEQAeh2aqg36+f8wgRLBxfsRsOT5H0to6+ZBCmyBduvEkQIeXWLpO3a
 0wQyqdgcxg/kj/aMDf6jk/Z7NFKMWuIfT63wlhp4EpKjTk+th1VZl1ACrQsbm8CmlR9XTeE/rkY
 UTuuKa20E3+NrtahxIGG/H4vTh2rQ+iqQTvksiQdN+jPPctO4esCLLjD+lMOabggLxguWfY
X-Google-Smtp-Source: AGHT+IF3HV5HWTOvf2Lr+/wlQJlsx78M5QO+UY/vAGUmSNkbPoQjB3JQAeAYhwBNauvzksSf4YmoXwKxtLnjlsCbmdA=
X-Received: by 2002:a05:7022:ec0b:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-11f349a9d7emr9113376c88.2.1765999959762; Wed, 17 Dec 2025
 11:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20251217153521.2018841-1-alexander.deucher@amd.com>
 <20251217153521.2018841-3-alexander.deucher@amd.com>
 <7ef7c1d6-44f9-4819-8c32-887affc0cbec@amd.com>
In-Reply-To: <7ef7c1d6-44f9-4819-8c32-887affc0cbec@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Dec 2025 14:32:28 -0500
X-Gm-Features: AQt7F2r9vi98-fwPw5GVT7oS9smRr6ZV4p6DY-VuZmb-tWLlLaLVju7ORon-Xak
Message-ID: <CADnq5_P35AupM9eu==tDinDBp6spDKsm8OsBi4gazPfAYr_P_w@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu/discovery: add vcn and jpeg ip block
To: Mario Limonciello <mario.limonciello@amd.com>, Leo Liu <leo.liu@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
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

On Wed, Dec 17, 2025 at 2:25=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/17/25 9:35 AM, Alex Deucher wrote:
> > From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> >
> > Add VCN and jpeg IPs v5_3_0 blocks.
> >
> > Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 +++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  2 +
> >   drivers/gpu/drm/amd/amdgpu/soc21.c            | 39 +++++++++++++++++-=
-
> >   3 files changed, 44 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index ac1b95b9a4f6a..43e6216ca30f7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -112,6 +112,8 @@
> >   #include "vcn_v5_0_1.h"
> >   #include "jpeg_v5_0_0.h"
> >   #include "jpeg_v5_0_1.h"
> > +#include "jpeg_v5_3_0.h"
> > +
> >   #include "amdgpu_ras_mgr.h"
> >
> >   #include "amdgpu_vpe.h"
> > @@ -2538,6 +2540,10 @@ static int amdgpu_discovery_set_mm_ip_blocks(str=
uct amdgpu_device *adev)
> >                       amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_b=
lock);
> >                       amdgpu_device_ip_block_add(adev, &jpeg_v5_0_0_ip_=
block);
> >                       break;
> > +             case IP_VERSION(5, 3, 0):
> > +                     amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_b=
lock);
>
> This seems like a mistake.  Shouldn't there be a new vcn_v5_3_0_ip_block
> that sets major and minor properly?

+ Leo

My understanding is that the VCN part has no delta from 5.0.0, only JPEG do=
es.

Alex

>
> > +                     amdgpu_device_ip_block_add(adev, &jpeg_v5_3_0_ip_=
block);
> > +                     break;
> >               case IP_VERSION(5, 0, 1):
> >                       amdgpu_device_ip_block_add(adev, &vcn_v5_0_1_ip_b=
lock);
> >                       amdgpu_device_ip_block_add(adev, &jpeg_v5_0_1_ip_=
block);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vcn.c
> > index 5e0786ea911b3..75ae9b429420e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > @@ -63,6 +63,7 @@
> >   #define FIRMWARE_VCN4_0_6_1         "amdgpu/vcn_4_0_6_1.bin"
> >   #define FIRMWARE_VCN5_0_0           "amdgpu/vcn_5_0_0.bin"
> >   #define FIRMWARE_VCN5_0_1           "amdgpu/vcn_5_0_1.bin"
> > +#define FIRMWARE_VCN5_3_0            "amdgpu/vcn_5_3_0.bin"
> >
> >   MODULE_FIRMWARE(FIRMWARE_RAVEN);
> >   MODULE_FIRMWARE(FIRMWARE_PICASSO);
> > @@ -90,6 +91,7 @@ MODULE_FIRMWARE(FIRMWARE_VCN4_0_6);
> >   MODULE_FIRMWARE(FIRMWARE_VCN4_0_6_1);
> >   MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
> >   MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
> > +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
> >
> >   static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
> >   static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/a=
mdgpu/soc21.c
> > index 4e24aeecd9efb..2da733b45c21a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > @@ -141,6 +141,31 @@ static struct amdgpu_video_codecs sriov_vcn_4_0_0_=
video_codecs_decode_vcn1 =3D {
> >       .codec_array =3D sriov_vcn_4_0_0_video_codecs_decode_array_vcn1,
> >   };
> >
> > +static const struct amdgpu_video_codec_info vcn_5_3_0_video_codecs_enc=
ode_array_vcn0[] =3D {
> > +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, =
4096, 4096, 0)},
> > +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192,=
 4352, 0)},
> > +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, =
4352, 0)},
> > +};
> > +
> > +static const struct amdgpu_video_codecs vcn_5_3_0_video_codecs_encode_=
vcn0 =3D {
> > +        .codec_count =3D ARRAY_SIZE(vcn_5_3_0_video_codecs_encode_arra=
y_vcn0),
> > +        .codec_array =3D vcn_5_3_0_video_codecs_encode_array_vcn0,
> > +};
> > +
> > +static const struct amdgpu_video_codec_info vcn_5_3_0_video_codecs_dec=
ode_array_vcn0[] =3D {
> > +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, =
4096, 4096, 52)},
> > +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192,=
 4352, 186)},
> > +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384=
, 16384, 0)},
> > +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, =
4352, 0)},
> > +        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, =
4352, 0)},
> > +};
> > +
> > +static const struct amdgpu_video_codecs vcn_5_3_0_video_codecs_decode_=
vcn0 =3D {
> > +        .codec_count =3D ARRAY_SIZE(vcn_5_3_0_video_codecs_decode_arra=
y_vcn0),
> > +        .codec_array =3D vcn_5_3_0_video_codecs_decode_array_vcn0,
> > +};
> > +
> > +
> >   static int soc21_query_video_codecs(struct amdgpu_device *adev, bool =
encode,
> >                                const struct amdgpu_video_codecs **codec=
s)
> >   {
> > @@ -185,6 +210,12 @@ static int soc21_query_video_codecs(struct amdgpu_=
device *adev, bool encode,
> >               else
> >                       *codecs =3D &vcn_4_0_0_video_codecs_decode_vcn0;
> >               return 0;
> > +     case IP_VERSION(5, 3, 0):
> > +             if (encode)
> > +                     *codecs =3D &vcn_5_3_0_video_codecs_encode_vcn0;
> > +             else
> > +                     *codecs =3D &vcn_5_3_0_video_codecs_decode_vcn0;
> > +             return 0;
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -800,9 +831,11 @@ static int soc21_common_early_init(struct amdgpu_i=
p_block *ip_block)
> >               adev->external_rev_id =3D adev->rev_id + 0x50;
> >               break;
> >       case IP_VERSION(11, 5, 4):
> > -               adev->cg_flags =3D 0;
> > -               adev->pg_flags =3D 0;
> > -               adev->external_rev_id =3D adev->rev_id + 0x1;
> > +             adev->cg_flags =3D AMD_CG_SUPPORT_VCN_MGCG |
> > +                     AMD_CG_SUPPORT_JPEG_MGCG;
> > +             adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
> > +                     AMD_PG_SUPPORT_JPEG;
> > +             adev->external_rev_id =3D adev->rev_id + 0x1;
> >                  break;
> >       default:
> >               /* FIXME: not supported yet */
>
