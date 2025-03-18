Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7098DC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 14:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53E710E4A2;
	Tue, 18 Mar 2025 14:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="feXd6Wr3";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBAD610E4A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 14:59:40 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff5f2c5924so475121a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742309980; x=1742914780; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=osaTWmuYu64I+KaJwmDqYJFFbsSZvJ6Hm+O4MjmnIEg=;
 b=feXd6Wr3mWVAmqVPFjR8JQpalnGyi4rd7hb/COXpjLqdO9/YPh9S7fgR87/qIivfPH
 eAlYvkbmzihxXqcbUXNgy2qSW3Ge0G1pHccJnq7MdEYcIVkqUX1l7s6fg5LlUnse+qa6
 hj/5+N8A+h9af4Ni1DVPZD2JQEvsKAI8BuWEWsO+nCLjusCDRemkONm5gQhmjzqfLTB9
 N8S8r7CFnWTulPX/HWE5L13SPqM4GcqNI9EldyCVfiPiGvr0/6EQ6rCBzhGcFVgGL4lj
 B+YFzYC4VmDFmUPM3oAizb0iw1XgZsTgA+NP3QvbEvr0tTGUz5viJiT8qZ5uGjfqCosn
 +zNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742309980; x=1742914780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=osaTWmuYu64I+KaJwmDqYJFFbsSZvJ6Hm+O4MjmnIEg=;
 b=JGvgtQTRmARyiCMkIlxjOns+Rre/GXU5r5PxKhBCBIlvbKcxTWK68Y//Jo29f4vPEL
 cSq9VfPoif9YPaSIrOtgPoi8fHxtbjqGBqhiYNNvXGJFMw6B8PfT1DWKdVjUiqBJmT+b
 qXld6QthXOX/stq+6sO3pFwkPculvrn/8eib+6TzalmHhpJldSIeNK9ek5KhrDpdjWup
 G5X03jpRtSJF7qbC5eeC+i5pEM3osWh0vzxNzJTarPReiBQaWRKyNNr0paIinOXuk9sb
 F0bY6bfcVKLvUm/a5ZYpGkNmIOfYDmCSnAvqTIQpw6r0lYvFTAiagejKU2CZnng8xqH5
 2kAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkdqRpg+2gcD4AwZQFXtJvpvnBgVknl3eBSsrUiyP5UnnoFrTQiaf7WycYCg+uAaW0CInEDA6a@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqvZFGLC7ljUEB37s1tbP7oIB0tL0LwUC4heI96zqT9UTdEJ/G
 eflh+QlU/X0mhXzeCQvWK2tpyi8MCW2HnUh65k1U33Uew0pc7i6INdTLohguut0qwgIaVqNGIqY
 Ef5s7uIQ3Ukh8HuFipi8X6nfDwrk=
X-Gm-Gg: ASbGncur+WRvm6EXMryZL/8oYA6eWeKL8tpvmgk+ufJTwjNhc+X7dcdremWFX1yDGwz
 aE80Ee1ky1Ih3LgngKaaCcSibsxjVACz3Mi2l7y8oeIsk5onuOmAkfb8KPpvLr4by2EOMh3zzTv
 u2jg6m70xJTHyChqCc8WN/2NhZcA==
X-Google-Smtp-Source: AGHT+IHQQPpnXyx5ZS2Jf30UaefVFleI+EYCfeBO8VEC5oVSS/W+YW0pBZevGfzIcaeN0JRYXFydKPajKZ6vdhRc1kA=
X-Received: by 2002:a17:90b:4b12:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-30151d8e5camr7671087a91.7.1742309980323; Tue, 18 Mar 2025
 07:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250317212919.1018717-1-alexander.deucher@amd.com>
 <DS7PR12MB600535BFFCEBF5CF5DE68B80FBDE2@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600535BFFCEBF5CF5DE68B80FBDE2@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Mar 2025 10:59:28 -0400
X-Gm-Features: AQ5f1JqowRXlYPa47joH9loS9SQOQr7DDegPdssKF9BneHPx_B9wOj-o3YY80QM
Message-ID: <CADnq5_PuCvvA_ysfYhmbPXAx1KEqcrDNnO0Q41DQ6P3E5swyOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add UAPI to query if user queues are supported
To: "Liang, Prike" <Prike.Liang@amd.com>, yogesh.mohanmarimuthu@amd.com, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>
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

On Tue, Mar 18, 2025 at 9:13=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> Reviewed-by: Prike Liang <Prike.Liang@amd.com>
>
> May I know when the counterpart part of Libdrm and Mesa can support this =
UAPI?

+ Yogesh

Assuming this is agreeable to the mesa team, I'd expect them to start
using it.  @yogesh.mohanmarimuthu@amd.com, @Marek Ol=C5=A1=C3=A1k  does thi=
s
look good to you?

Alex

>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Sent: Tuesday, March 18, 2025 5:29 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Olsak, Marek
> > <Marek.Olsak@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Khatri, Suni=
l
> > <Sunil.Khatri@amd.com>
> > Subject: [PATCH] drm/amdgpu: add UAPI to query if user queues are suppo=
rted
> >
> > Add an INFO query to check if user queues are supported.
> >
> > v2: switch to a mask of IPs (Marek)
> >
> > Cc: marek.olsak@amd.com
> > Cc: prike.liang@amd.com
> > Cc: sunil.khatri@amd.com
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
> >  include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index 3b7dfd56ccd0e..1d683c0487697 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -1340,6 +1340,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, vo=
id
> > *data, struct drm_file *filp)
> >                       return -EINVAL;
> >               }
> >       }
> > +     case AMDGPU_INFO_UQ_SUPPORTED: {
> > +             struct drm_amdgpu_info_uq_supported uq_supported =3D {};
> > +
> > +             if (adev->userq_funcs[AMDGPU_HW_IP_GFX])
> > +                     uq_supported.supported |=3D (1 << AMDGPU_HW_IP_GF=
X);
> > +             if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE])
> > +                     uq_supported.supported |=3D (1 <<
> > AMDGPU_HW_IP_COMPUTE);
> > +             if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
> > +                     uq_supported.supported |=3D (1 << AMDGPU_HW_IP_DM=
A);
> > +             ret =3D copy_to_user(out, &uq_supported,
> > +                                min((size_t)size, sizeof(uq_supported)=
)) ? -
> > EFAULT : 0;
> > +             return 0;
> > +     }
> >       default:
> >               DRM_DEBUG_KMS("Invalid request %d\n", info->query);
> >               return -EINVAL;
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index 5dbd9037afe75..4b64e91002c05 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -1195,6 +1195,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
> >  #define AMDGPU_INFO_GPUVM_FAULT                      0x23
> >  /* query FW object size and alignment */
> >  #define AMDGPU_INFO_UQ_FW_AREAS                      0x24
> > +/* query if user queues are supported */
> > +#define AMDGPU_INFO_UQ_SUPPORTED             0x25
> >
> >  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT       0
> >  #define AMDGPU_INFO_MMR_SE_INDEX_MASK        0xff
> > @@ -1572,6 +1574,12 @@ struct drm_amdgpu_info_uq_metadata {
> >       };
> >  };
> >
> > +struct drm_amdgpu_info_uq_supported {
> > +     /** returns a mask for each IP type (1 << AMDGPU_HW_IP_*) */
> > +     __u32   supported;
> > +     __u32   pad;
> > +};
> > +
> >  /*
> >   * Supported GPU families
> >   */
> > --
> > 2.48.1
>
