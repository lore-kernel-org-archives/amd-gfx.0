Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04D4C52D73
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 21:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462D010E72D;
	Thu,  8 Aug 2024 21:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aeup7fvq";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1738B10E72D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 21:46:34 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-7a0e8b76813so1022307a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Aug 2024 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723153593; x=1723758393; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOQ+4l+8Whl8j5rzor706xm2kYo2mjsdHoSG4oKAGNI=;
 b=aeup7fvqW3GBdO40MHbXDkUTX5AvpZEwMqBSSgiS5cNAsFB01PNX0WyuK88ip5FxXW
 xDvg94KPjYXsAq8XICBCv+uzwgk+9aBUA+dgMSyxtzXIyR5R0nJmyt4y+gFoVfPXo/K0
 HII9l8XMTeQkOmqB93+lTN6WIDkL9Sm23J6Mh9LtUM4rGJ1it29ioSoR5UFwF5NJUz6U
 IVjqv0i9ajiTE/mEo+66d2HyoevH4dMFB8tlUwk56/dfn/WJSbnL0FO7npyv675qj14+
 xY5/8SycRSDFSqidXLWLdgjHGz9E5H9DtLKYRm+k7XN6S4pef7x7aZ3A2BANu+vRskry
 boTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723153593; x=1723758393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOQ+4l+8Whl8j5rzor706xm2kYo2mjsdHoSG4oKAGNI=;
 b=Mt02q+FDK21G0tnaLjRBrh9RgD46LV90BqxoI8go2QJAFpzYK8Y6+EpQ1jSmWoam0E
 21UuWBc/w4m/CiPuCmtpcp5m9+4ZlDz4VQ6ohTQk2PpNe84JfrTNO9ITuUrEQ3vkStW1
 NtigtHkoytueKN/JOq1vjex9YVnTMeIFw2I7o04NveJLyIPqFMUOrymXvdO8RQqGBaio
 IPkkBgSV9qjok2zwUkVup0o6pY3VfkTJjKRD8URWCKN5erTKDjjNyvc+4V8smzURAcH1
 MwviamILMsGtF78lOQUBj0L6gQOfhmVM3sA+cAHH1m4855Wi8cr/Rd57OUykIFPG9Vcc
 ThZA==
X-Gm-Message-State: AOJu0Yy7TrUxQES/d0HgnzN7v1535Wsmw0YcM5z0J5ck9iGC6c9nnMdk
 joNoPuaaABrhWOjc/eH/L2AOg+FlA+FLAwiRAFnuNhUzt5nnIGyy+yjkI9oNkcHjxP8sJQRVUoE
 RyRh661MK7JdOTn9/o+h9um4iQFQqMQ==
X-Google-Smtp-Source: AGHT+IGN4x4tL4lDJVOcx9y/P2wwLhURlfhPB3zU7UCUrewgeY2B01WdJBC8+aXc8Hk5WMJ/cKh+LkEbHKHqM7PQlko=
X-Received: by 2002:a17:90a:fd03:b0:2ca:5a46:cbc8 with SMTP id
 98e67ed59e1d1-2d1c34506b9mr4056919a91.26.1723153593527; Thu, 08 Aug 2024
 14:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240808174808.854282-1-victor.skvortsov@amd.com>
 <CADnq5_PJamzCwdzo9XrRkr8QrfeM_1ePzEzxd=MJPC+Me8ah8Q@mail.gmail.com>
 <SJ1PR12MB62927A1D7AEE22A419EF41828BB92@SJ1PR12MB6292.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB62927A1D7AEE22A419EF41828BB92@SJ1PR12MB6292.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Aug 2024 17:46:22 -0400
Message-ID: <CADnq5_Mcye9fk6pGbN7Y-w0Lictbkj76UoRwTGQ4tT9P=uk8cA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Block MMR_READ IOCTL in reset
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Luo,
 Zhigang" <Zhigang.Luo@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
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

On Thu, Aug 8, 2024 at 5:33=E2=80=AFPM Skvortsov, Victor
<Victor.Skvortsov@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Thu, Aug 8, 2024 at 1:48=E2=80=AFPM Victor Skvortsov
> > <victor.skvortsov@amd.com> wrote:
> > >
> > > Register access from userspace should be blocked until reset is
> > > complete.
> >
> > While you are at it, you should protect AMDGPU_INFO_SENSOR as well.
> > That queries PMFW which doesn't make sense during reset.  A few minor
> > comments below as well.
>
> In general, all PMFW queries are already blocked by pm.dpm_enabled flag. =
This flag is toggled off in pre_asic_reset, so generally I don't think it w=
ill be a problem. Only edge cases I can think of is GFX clock gating that i=
s setup later in hw_resume sequence. But I don't think it warrants this loc=
k.

Fair enough.  With the coding style comments below fixed, this patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> >
> > >
> > > Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44
> > > ++++++++++++++++++-------
> > >  1 file changed, 32 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > index 260cd0ad286d..038b400be437 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > @@ -778,6 +778,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d
> > *data, struct drm_file *filp)
> > >                                     ? -EFAULT : 0;
> > >         }
> > >         case AMDGPU_INFO_READ_MMR_REG: {
> > > +               int ret =3D 0;
> > >                 unsigned int n, alloc_size;
> > >                 uint32_t *regs;
> > >                 unsigned int se_num =3D (info->read_mmr_reg.instance =
>>
> > > @@ -787,24 +788,39 @@ int amdgpu_info_ioctl(struct drm_device *dev,
> > void *data, struct drm_file *filp)
> > >                                    AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
> > >                                   AMDGPU_INFO_MMR_SH_INDEX_MASK;
> > >
> > > +               if (!down_read_trylock(&adev->reset_domain->sem))
> > > +                       return -ENOENT;
> > > +
> > >                 /* set full masks if the userspace set all bits
> > >                  * in the bitfields
> > >                  */
> > > -               if (se_num =3D=3D AMDGPU_INFO_MMR_SE_INDEX_MASK)
> > > +               if (se_num =3D=3D AMDGPU_INFO_MMR_SE_INDEX_MASK) {
> > >                         se_num =3D 0xffffffff;
> > > -               else if (se_num >=3D AMDGPU_GFX_MAX_SE)
> > > -                       return -EINVAL;
> > > -               if (sh_num =3D=3D AMDGPU_INFO_MMR_SH_INDEX_MASK)
> > > +               }
> > > +               else if (se_num >=3D AMDGPU_GFX_MAX_SE) {
> >
> > Kernel coding style.  Put the } on the same line as the else.
> >
> > > +                       ret =3D -EINVAL;
> > > +                       goto out;
> > > +               }
> > > +
> > > +               if (sh_num =3D=3D AMDGPU_INFO_MMR_SH_INDEX_MASK) {
> > >                         sh_num =3D 0xffffffff;
> > > -               else if (sh_num >=3D AMDGPU_GFX_MAX_SH_PER_SE)
> > > -                       return -EINVAL;
> > > +               }
> > > +               else if (sh_num >=3D AMDGPU_GFX_MAX_SH_PER_SE) {
> >
> > Same here.
> >
> > > +                       ret =3D -EINVAL;
> > > +                       goto out;
> > > +               }
> > >
> > > -               if (info->read_mmr_reg.count > 128)
> > > -                       return -EINVAL;
> > > +               if (info->read_mmr_reg.count > 128) {
> > > +                       ret =3D -EINVAL;
> > > +                       goto out;
> > > +               }
> > >
> > >                 regs =3D kmalloc_array(info->read_mmr_reg.count, size=
of(*regs),
> > GFP_KERNEL);
> > > -               if (!regs)
> > > -                       return -ENOMEM;
> > > +               if (!regs) {
> > > +                       ret =3D -ENOMEM;
> > > +                       goto out;
> > > +               }
> > > +
> > >                 alloc_size =3D info->read_mmr_reg.count * sizeof(*reg=
s);
> > >
> > >                 amdgpu_gfx_off_ctrl(adev, false); @@ -816,13 +832,17
> > > @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct
> > drm_file *filp)
> > >                                               info->read_mmr_reg.dwor=
d_offset + i);
> > >                                 kfree(regs);
> > >                                 amdgpu_gfx_off_ctrl(adev, true);
> > > -                               return -EFAULT;
> > > +                               ret =3D -EFAULT;
> > > +                               goto out;
> > >                         }
> > >                 }
> > >                 amdgpu_gfx_off_ctrl(adev, true);
> > >                 n =3D copy_to_user(out, regs, min(size, alloc_size));
> > >                 kfree(regs);
> > > -               return n ? -EFAULT : 0;
> > > +               ret =3D (n ? -EFAULT : 0);
> > > +out:
> > > +               up_read(&adev->reset_domain->sem);
> > > +               return ret;
> > >         }
> > >         case AMDGPU_INFO_DEV_INFO: {
> > >                 struct drm_amdgpu_info_device *dev_info;
> > > --
> > > 2.34.1
> > >
