Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B930C8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 13:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171E310E469;
	Mon,  7 Jul 2025 13:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AvNjtUds";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E2610E46D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 13:22:52 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-234b9b01a76so2016575ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jul 2025 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751894572; x=1752499372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cu052TBqnNm0FC6LZsCt3uhjYEQyqdrtI+mNBtJj4O4=;
 b=AvNjtUdsDWAnPntfsMZAG3nkk6ixVFz8v5Qvsel/8bS5UmdrJli/xTxNXbwdvXU1Xx
 W7nvh+AMK0uNXUr0l+EBtdwZj6pcGnTqbD0MJlSxbmMModhwlkvXL6Ne+wI0r0TQEtXR
 6HotIkDQ+wZfDIH7EYX1uJIpaGyohPxWeDiT/5RSdP739aQKRW43Xn8MyQ8tFFWBWAcT
 pClHFuP/BeFT/w5U70YrKVi9oiHFIwaGsAikwN9JjlfpgxzsLL9bNFRH4IMr2x8LctP9
 L8Oo3/q63rANUx5hpst5JqJeIMghJECuI19UA8m5v3sOi9tXrAirgcefHIVNsITtD+tb
 H7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751894572; x=1752499372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cu052TBqnNm0FC6LZsCt3uhjYEQyqdrtI+mNBtJj4O4=;
 b=PRf3F2tPwt5KdAH/c+3TL2D98c6ASaiu8ws4CDFrL1RvBtAnXHjn/Gp2rYT0etDgJb
 FAHIKMFi7+by6ku7GmziguBydXhXJnKCkp+QsxB1xb/XUYUS24TfafCN6S1KJdGmvjBR
 pzo8T1lSgERxrBsapQsrpHlK3XhIdrML+UPT1N75O0a64v42/dff7NALWQLci4f3xsyx
 LxhPaoyxNjXOPfre+AyN/cNO8ZZHoNXYcZ+cOdD8Y7cTddB25+CYHuKuZnNXGtz/n4e/
 AUE+rxyAhPIDFRDNfGyZRShTY91JLE5tHjl+Xfa2xtMkpvq0s2FDAOlchYd2YIZHxrbE
 ePlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoh+zxZHNh6B4ZhMkUEGZF2JCos3pn3HfROb4+Q0lFYEbT5Hq6xLWahz+JnnYo/syRSBWxfrV0@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5uu2RFzbkz63rticLL7eRmLuCrdA/WwkWbHlkmxapLiOvZdRu
 VNb0jYbuIioPDsYl5g88iRTkgTv9xxWAmcxHksNWHwhdyOcfwwtlSWoJ0SruaDNpq/mUPKTnbIO
 0FIspb/OYSLTy2tO2sgO8qIj0Nc0J35lWug==
X-Gm-Gg: ASbGncvvxbawytWTY1v4id0up08N2Hanu39IqPuw7/jLnuzC0/IayP5m5dMpEXwJYyP
 6axsmd8HvC916tAkOFIlCzJpJh66kvB/SFVx3gX27rHGs4mwf3FgJkHd73/1U/bVbwTXTZ7cfgU
 ydyhBnF0/4THgpCcHi16KCEbwhtnZqV8eR/MPDALvDqzJ4
X-Google-Smtp-Source: AGHT+IEOpQA6OXAA58tbSAerX3dXM6mBwO69gEuUvKai6b2iV7Jac+ttFlB1UoJp4EN8yBTvlR8qEl08AYoxTKaqNYo=
X-Received: by 2002:a17:902:f690:b0:22e:6d69:1775 with SMTP id
 d9443c01a7336-23c85f8d949mr68522375ad.11.1751894572287; Mon, 07 Jul 2025
 06:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250704072657.553572-1-jesse.zhang@amd.com>
 <b5cf1085-5a0b-4b32-8e6a-348f173a247b@amd.com>
In-Reply-To: <b5cf1085-5a0b-4b32-8e6a-348f173a247b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Jul 2025 09:22:40 -0400
X-Gm-Features: Ac12FXxxzEHng2c4SgkXXA0d5C_wB_2II04cnec935psxUn7XgOWK0zvWmZxq-4
Message-ID: <CADnq5_PrV6RBuiy3vtogGyxhK3QyROCk14WLByfNpOMewh2KMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace HQD terminology with slots naming
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, Marek.Olsak@amd.com
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

On Mon, Jul 7, 2025 at 5:48=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 04.07.25 09:26, Jesse Zhang wrote:
> > The term "HQD" is CP-specific and doesn't
> > accurately describe the queue resources for other IP blocks like SDMA,
> > VCN, or VPE. This change:
> >
> > 1. Renames `num_hqds` to `num_slots` in amdgpu_kms.c to better reflect
> >    the generic nature of the resource counting
> > 2. Updates the UAPI struct member from `userq_num_hqds` to `userq_num_s=
lots`
> > 3. Maintains the same functionality while using more appropriate termin=
ology
> >
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> BTW: Why userspace needs to know that in the first place?

So IGT can determine how many queues to create to hit over subscription.

Alex

>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +++++-----
> >  include/uapi/drm/amdgpu_drm.h           |  4 ++--
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 4aab5e394ce2..e2aa2264fa0b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -399,7 +399,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >       uint32_t ib_size_alignment =3D 0;
> >       enum amd_ip_block_type type;
> >       unsigned int num_rings =3D 0;
> > -     uint32_t num_hqds =3D 0;
> > +     uint32_t num_slots =3D 0;
> >       unsigned int i, j;
> >
> >       if (info->query_hw_ip.ip_instance >=3D AMDGPU_HW_IP_INSTANCE_MAX_=
COUNT)
> > @@ -415,7 +415,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >
> >               if (!adev->gfx.disable_uq) {
> >                       for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> > -                             num_hqds +=3D hweight32(adev->mes.gfx_hqd=
_mask[i]);
> > +                             num_slots +=3D hweight32(adev->mes.gfx_hq=
d_mask[i]);
> >               }
> >
> >               ib_start_alignment =3D 32;
> > @@ -430,7 +430,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >
> >               if (!adev->sdma.disable_uq) {
> >                       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i=
++)
> > -                             num_hqds +=3D hweight32(adev->mes.compute=
_hqd_mask[i]);
> > +                             num_slots +=3D hweight32(adev->mes.comput=
e_hqd_mask[i]);
> >               }
> >
> >               ib_start_alignment =3D 32;
> > @@ -445,7 +445,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >
> >               if (!adev->gfx.disable_uq) {
> >                       for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> > -                             num_hqds +=3D hweight32(adev->mes.sdma_hq=
d_mask[i]);
> > +                             num_slots +=3D hweight32(adev->mes.sdma_h=
qd_mask[i]);
> >               }
> >
> >               ib_start_alignment =3D 256;
> > @@ -589,7 +589,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >       }
> >       result->capabilities_flags =3D 0;
> >       result->available_rings =3D (1 << num_rings) - 1;
> > -     result->userq_num_hqds =3D num_hqds;
> > +     result->userq_num_slots =3D num_slots;
> >       result->ib_start_alignment =3D ib_start_alignment;
> >       result->ib_size_alignment =3D ib_size_alignment;
> >       return 0;
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index 66c4a03ac9f9..bdedbaccf776 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -1493,8 +1493,8 @@ struct drm_amdgpu_info_hw_ip {
> >       __u32  available_rings;
> >       /** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
> >       __u32  ip_discovery_version;
> > -     /* Userq available hqds */
> > -     __u32  userq_num_hqds;
> > +     /* Userq available slots */
> > +     __u32  userq_num_slots;
> >  };
> >
> >  /* GFX metadata BO sizes and alignment info (in bytes) */
>
