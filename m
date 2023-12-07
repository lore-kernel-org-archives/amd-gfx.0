Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E8DC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 17:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2694410E04C;
	Thu,  7 Dec 2023 17:36:23 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D92E10E04C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 17:36:21 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b9d65d184aso794625b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701970580; x=1702575380; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdMqrUqV04fcYsSlAHng0O3rjZikKGvLabUP+um2kbg=;
 b=Glr2fXJwjNzJkcR5zQoPBhOqiQsRFTLK5GRMbOAXW28Hqxdh8U7/QPvfkaAhHiqpgI
 NDPAd0arSvQ1VILhhBxmYcCo+f9aAWbiHe1GsRCWyYn7gtRx3iRG4fFGt4kFeAPNHs8+
 +XccWqmUbChMJw8n7U4jKkZ+Ahd1SPsFhImfAAg2XKEdwyKmXkttaGdguwMZtLP2F9e3
 eDlrlb/f88wWzSxks0Uz4hHqPsAubOVlKAVNLGpNEZAMv6LhzTvRwdoL5mVeu95w88Cr
 IAhVTtNpvFAWpDOTicBOfRJpJYk5CE6t3Fyb7fc6Zdy2psTI5AnPLtooF98K/lNiMG48
 0l8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701970580; x=1702575380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IdMqrUqV04fcYsSlAHng0O3rjZikKGvLabUP+um2kbg=;
 b=fOv81HKslF9cx3kVGDXDDZyGg1xuv1iIkGg447azLD7qVJsiAxCWrhhEjIqRlJ/vlp
 AgT9hpg13ijSdU06WGXXiEPXVdOV/IejYZOQizmyfE73UXuz9h53yenaINR1CagKqU48
 1bjN0i3WV7CM9bcxDPpuKXbLuOBf2L1QiDCFMf0x04/vhPnM7lY5m4AEXNc7vJo2UUvO
 Hsd14BtudDZdCXPj2IUzT4pjwOwEy01kb5QowvsTztfXltlcE5dIXKSp3MR4u95aFNpm
 TXwtqI3UB+Gz+UhPe+2MVxzmn4OtHKDKppfiuJyrmYNL4Wag5sHinw3R4UKzhgk7Wz+Z
 Z5/A==
X-Gm-Message-State: AOJu0Yy/aFqtI27xO770SOnMDvqKu33PEYcmDkrioeXkt21V61dPQyMB
 na39OUhYa2C1xZClUCVeNQUFFL2kbS967g9k6ILTpjQ7hmQ=
X-Google-Smtp-Source: AGHT+IEn5qAN4os6gLrALmw7dQtRi5usMEHbD+X+3afBtmI1CCmFauJWywAsUL+FHPGiR1z68w1JjWhJzfnzvQi1MsA=
X-Received: by 2002:a05:6870:b6a7:b0:1fa:efdc:b49a with SMTP id
 cy39-20020a056870b6a700b001faefdcb49amr3102315oab.56.1701970580427; Thu, 07
 Dec 2023 09:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20231109221400.936847-1-alexander.deucher@amd.com>
 <20231109221400.936847-3-alexander.deucher@amd.com>
 <d3610129-9e74-b565-fa74-e3faa8924bdd@amd.com>
In-Reply-To: <d3610129-9e74-b565-fa74-e3faa8924bdd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Dec 2023 12:36:09 -0500
Message-ID: <CADnq5_MNj5yTtLjwZzNje7P1_qe__010nFqdqJm1y7vXKSqe-w@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: add new INFO IOCTL query for input power
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 10, 2023 at 3:22=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 11/10/2023 3:44 AM, Alex Deucher wrote:
> > Some chips provide both average and input power.  Previously
> > we just exposed average power, add a new query for input
> > power.
> >
>
> Input looks like a misnomer (not the supply side, but the power
> consumed). Better to rename to instantaneous or current power. I guess
> that will require rename of AMDGPU_PP_SENSOR_GPU_INPUT_POWER too.

It aligns with the sysfs naming.  E.g.,
https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface

power[1-*]_input  Instantaneous power use
                            Unit: microWatt
                            RO

Alex

>
> Thanks,
> Lijo
>
> > Example userspace:
> > https://github.com/Umio-Yasuno/libdrm-amdgpu-sys-rs/tree/input_power
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
> >   include/uapi/drm/amdgpu_drm.h           | 2 ++
> >   2 files changed, 11 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index bf4f48fe438d..48496bb585c7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -1114,6 +1114,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, vo=
id *data, struct drm_file *filp)
> >                       }
> >                       ui32 >>=3D 8;
> >                       break;
> > +             case AMDGPU_INFO_SENSOR_GPU_INPUT_POWER:
> > +                     /* get input GPU power */
> > +                     if (amdgpu_dpm_read_sensor(adev,
> > +                                                AMDGPU_PP_SENSOR_GPU_I=
NPUT_POWER,
> > +                                                (void *)&ui32, &ui32_s=
ize)) {
> > +                             return -EINVAL;
> > +                     }
> > +                     ui32 >>=3D 8;
> > +                     break;
> >               case AMDGPU_INFO_SENSOR_VDDNB:
> >                       /* get VDDNB in millivolts */
> >                       if (amdgpu_dpm_read_sensor(adev,
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index ad21c613fec8..96e32dafd4f0 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -865,6 +865,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
> >       #define AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_SCLK                 0=
xa
> >       /* Subquery id: Query GPU peak pstate memory clock */
> >       #define AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_MCLK                 0=
xb
> > +     /* Subquery id: Query input GPU power   */
> > +     #define AMDGPU_INFO_SENSOR_GPU_INPUT_POWER      0xc
> >   /* Number of VRAM page faults on CPU access. */
> >   #define AMDGPU_INFO_NUM_VRAM_CPU_PAGE_FAULTS        0x1E
> >   #define AMDGPU_INFO_VRAM_LOST_COUNTER               0x1F
