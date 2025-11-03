Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7016CCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 21:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B4610E4A7;
	Mon,  3 Nov 2025 21:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iLboBzRe";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60DBD10E4A7
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 21:29:57 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-295395ceda3so2511675ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 13:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762205397; x=1762810197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4XciE1v3d425Yg8+SVgZX2uGUdZgJu8kcY1cbUvbk4=;
 b=iLboBzReIcUkGwYEaV1dryShFWM4A5YJWh6RmWbaWUXBr2rlJqnGj2brJcuWnD5Ll+
 iAtqRuSG6q0+EAwhMqRPBxDs/AFxbw+rmdzZLMoX7whDLdbrGJQHHqjTBM1YvWou6tnw
 xYGStYfO0k9qg32eEJzDM4VeqHZDUNzT2zxZRMILW1SFziL7W9/QCg01NmOwbmnUMd/Q
 pplm0QB7qahzn3HwOBGVg3cL0mGxosUp+Kxuqq16D/1lCjdfoyE7L7swndco+TmusD6B
 j2x0eTZ4E7xbbgZpLvjDeef4vV5GzDu4I3slLaWWjSWo8bWngtxxzXpRfQ6JyyhCliCn
 ve0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762205397; x=1762810197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4XciE1v3d425Yg8+SVgZX2uGUdZgJu8kcY1cbUvbk4=;
 b=mLbGRz1n3OipsdHiK4qJrZioIr+ONg4UNe243ySvtqkk//5vUnctdhrHHpIsUkgLjn
 yl1TuR9PwqQLdjWGUEanpPB4SwFOCuPxP/0FVIfXVN+lfr/Mhv+7MFa7ijvHkYBZnlHK
 kEfmMf7jX/MGZxKQYAI1eE3tOZcmoQgTtPKmHn3hPufjh2dKgN37mIpj4Ha+zr9oiy/s
 z7pZlMFyJ8HodQVVzz6NfxQMbM4GdJzL6/7TJ5GKhbC1up2Sx/rDdFadoZ9zGQaowppi
 cCfwaEfZZg355+EzcoAii9euW0hzYfHZGqZ9e8cuIenylCYUF5FEharF+T85n5qKakfC
 OEVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUktY7ipTlJRu2+BE+jvB3FmlwPj8c9gEaSIzbX4R5O4P7KPh9x/LZ7W9U8Ig4tIhVlMjgYU29m@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYrf1VWeAwUrypl6PbGXvc12DEtBo+ZE6eEpzB1aIaP+V/+cn0
 1aBOLWVOiq1n2awesAtA4uxOYnjcBqQhavbN4iZTLCTEVr/D2xuYVB+Q9m4ptGG2gORvu/JWwtn
 anSssgoSUgt3mNJ1yKzzJ1QYsZqDlaYY=
X-Gm-Gg: ASbGncuSTFdfiN70n821StP5a2vtMjR4fSvGSnj4vUM6G+5orblR/HuX1IeR179akJ8
 hYF1qTMl0bEIyy/eAmEaoySlxfSuEYPeXWoPtXpJb7SzZy+Fx+eM2kTd0RYU4k9QragYVGdpzUt
 CBfQuSupXW7IgHD4/B/uCUv+Ll5s10rHaa1UFJXIRulROXazgdGOlawv3kns6NR6ZRidJLpi0NE
 AzzczrlJiTzmo9T0mqIfOeQa2v58QTXBQbiQYpYSpzlLm0NOrQPs8RBjGJn
X-Google-Smtp-Source: AGHT+IFGjAG12gyps7EIGj6OchstIIBXN8xtgInT/iresEDcuo6iHItk60H5JV4vDTnvsodmKY4vGNKPQEPQQNXFlCw=
X-Received: by 2002:a17:902:ecc1:b0:290:ccf2:9371 with SMTP id
 d9443c01a7336-29519a8e2c3mr93746015ad.0.1762205396811; Mon, 03 Nov 2025
 13:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20251103-vram-carveout-tuning-for-upstream-v1-0-17e2a72639c5@amd.com>
 <20251103-vram-carveout-tuning-for-upstream-v1-2-17e2a72639c5@amd.com>
 <CADnq5_PS7pfseo84hVPfBevJqrfBxHEAct0w35xVjNg0cjREqg@mail.gmail.com>
In-Reply-To: <CADnq5_PS7pfseo84hVPfBevJqrfBxHEAct0w35xVjNg0cjREqg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Nov 2025 16:29:45 -0500
X-Gm-Features: AWmQ_bktL_JqFXc2luru6LJbggBsVhihvtD9KacBd_Z9jgLjkQk-zRQDtk7U6-I
Message-ID: <CADnq5_PwcJ2J9Enc2GFYHPgyX4DO_+gHf=8fDvDz1eVmq6+L6w@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: add helper to read UMA carveout info
To: "Yo-Jung Leo Lin (AMD)" <Leo.Lin@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, anson.tsao@amd.com, superm1@kernel.org
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

On Mon, Nov 3, 2025 at 4:22=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Mon, Nov 3, 2025 at 2:54=E2=80=AFAM Yo-Jung Leo Lin (AMD) <Leo.Lin@amd=
.com> wrote:
> >
> > Currently, the available UMA allocation configs in the integrated syste=
m
> > information table have not been parsed. Add a helper function to retrie=
ve
> > and store these configs.
> >
> > Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > Signed-off-by: Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c     | 32 ++++++++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 75 ++++++++++++++++=
++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h |  1 +
> >  drivers/gpu/drm/amd/amdgpu/atom.h                |  4 ++
> >  4 files changed, 107 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atombios.c
> > index 763f2b8dcf13..58cc3bc9d42d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > @@ -28,6 +28,7 @@
> >  #include "amdgpu.h"
> >  #include "amdgpu_atombios.h"
> >  #include "amdgpu_atomfirmware.h"
> > +#include "atomfirmware.h"
> >  #include "amdgpu_i2c.h"
> >  #include "amdgpu_display.h"
> >
> > @@ -1877,6 +1878,10 @@ void amdgpu_atombios_fini(struct amdgpu_device *=
adev)
> >         if (adev->mode_info.atom_context) {
> >                 kfree(adev->mode_info.atom_context->scratch);
> >                 kfree(adev->mode_info.atom_context->iio);
> > +               kfree(adev->mode_info.atom_context->uma_carveout_option=
s);
> > +               adev->mode_info.atom_context->uma_carveout_options =3D =
NULL;
> > +               adev->mode_info.atom_context->uma_carveout_nr =3D 0;
> > +               adev->mode_info.atom_context->uma_carveout_index =3D 0;
> >         }
> >         kfree(adev->mode_info.atom_context);
> >         adev->mode_info.atom_context =3D NULL;
> > @@ -1891,16 +1896,19 @@ void amdgpu_atombios_fini(struct amdgpu_device =
*adev)
> >   *
> >   * Initializes the driver info and register access callbacks for the
> >   * ATOM interpreter (r4xx+).
> > - * Returns 0 on sucess, -ENOMEM on failure.
> > + * Returns 0 on success, -ENOMEM on memory allocation error, or -EINVA=
L on ATOM ROM parsing error
> >   * Called at driver startup.
> >   */
> >  int amdgpu_atombios_init(struct amdgpu_device *adev)
> >  {
> >         struct card_info *atom_card_info =3D
> >             kzalloc(sizeof(struct card_info), GFP_KERNEL);
> > +       int rc;
> >
> > -       if (!atom_card_info)
> > -               return -ENOMEM;
> > +       if (!atom_card_info) {
> > +               rc =3D -ENOMEM;
> > +               goto out_card_info;
> > +       }
> >
> >         adev->mode_info.atom_card_info =3D atom_card_info;
> >         atom_card_info->dev =3D adev_to_drm(adev);
> > @@ -1913,8 +1921,16 @@ int amdgpu_atombios_init(struct amdgpu_device *a=
dev)
> >
> >         adev->mode_info.atom_context =3D amdgpu_atom_parse(atom_card_in=
fo, adev->bios);
> >         if (!adev->mode_info.atom_context) {
> > -               amdgpu_atombios_fini(adev);
> > -               return -ENOMEM;
> > +               rc =3D -ENOMEM;
> > +               goto out_atom_ctx;
> > +       }
> > +
> > +       rc =3D amdgpu_atomfirmware_get_uma_carveout_info(adev);
> > +
> > +       if (rc) {
> > +               drm_dbg(adev_to_drm(adev), "Failed to get UMA carveout =
info: %d\n", rc);
> > +               if (rc !=3D -ENODEV)
> > +                       goto out_uma_info;
> >         }
> >
> >         mutex_init(&adev->mode_info.atom_context->mutex);
> > @@ -1930,6 +1946,12 @@ int amdgpu_atombios_init(struct amdgpu_device *a=
dev)
> >         }
> >
> >         return 0;
> > +
> > +out_uma_info:
> > +out_atom_ctx:
> > +       amdgpu_atombios_fini(adev);
> > +out_card_info:
> > +       return rc;
> >  }
> >
> >  int amdgpu_atombios_get_data_table(struct amdgpu_device *adev,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > index 636385c80f64..698416e84f1f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > @@ -21,12 +21,14 @@
> >   *
> >   */
> >
> > +#include "linux/slab.h"
> >  #include <drm/amdgpu_drm.h>
> >  #include "amdgpu.h"
> >  #include "atomfirmware.h"
> >  #include "amdgpu_atomfirmware.h"
> >  #include "atom.h"
> >  #include "atombios.h"
> > +#include "atomfirmware.h"
> >  #include "soc15_hw_ip.h"
> >
> >  union firmware_info {
> > @@ -296,6 +298,79 @@ static int convert_atom_mem_type_to_vram_type(stru=
ct amdgpu_device *adev,
> >         return vram_type;
> >  }
> >
> > +static int __amdgpu_atomfirmware_get_uma_carveout_info_v2_3(struct amd=
gpu_device *adev,
> > +                                                           union igp_i=
nfo *igp_info)
> > +{
> > +       struct atom_context *ctx =3D adev->mode_info.atom_context;
> > +       struct uma_carveout_option *opts;
> > +
> > +       opts =3D kzalloc(sizeof(igp_info->v23.UMASizeControlOption), GF=
P_KERNEL);
> > +
> > +       if (!opts)
> > +               goto out_mem;
> > +
> > +       memcpy(opts, igp_info->v23.UMASizeControlOption,
> > +               sizeof(igp_info->v23.UMASizeControlOption));
> > +
> > +       ctx->uma_carveout_index =3D igp_info->v23.UMACarveoutIndex;
> > +       ctx->uma_carveout_nr =3D igp_info->v23.UMACarveoutIndexMax;
> > +       ctx->uma_carveout_options =3D opts;
> > +
> > +       return 0;
> > +
> > +out_mem:
> > +       return -ENOMEM;
> > +}
> > +
> > +static int __amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_d=
evice *adev,
> > +                                                      u8 frev, u8 crev=
,
> > +                                                      union igp_info *=
igp_info)
> > +{
> > +       switch (frev) {
> > +       case 2:
> > +               switch (crev) {
> > +               case 3:
> > +                       return __amdgpu_atomfirmware_get_uma_carveout_i=
nfo_v2_3(adev, igp_info);
> > +               break;
> > +               default:
> > +                       break;
> > +               }
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +       return -ENODEV;
> > +}
>
> I think this function can be moved into
> amdgpu_atomfirmware_get_uma_carveout_info().
>
> > +
> > +int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *ad=
ev)
> > +{
> > +       struct amdgpu_mode_info *mode_info =3D &adev->mode_info;
> > +       union igp_info *igp_info;
> > +       u16 data_offset, size;
> > +       u8 frev, crev;
> > +       int index;
> > +
> > +       if (!(adev->flags & AMD_IS_APU))
> > +               return -ENODEV;
> > +
> > +       if (!amdgpu_acpi_is_set_uma_allocation_size_supported())
> > +               return -ENODEV;
> > +
> > +       index =3D get_index_into_master_table(atom_master_list_of_data_=
tables_v2_1,
> > +                                           integratedsysteminfo);
> > +
> > +       if (!amdgpu_atom_parse_data_header(mode_info->atom_context,
> > +                                         index, &size,
> > +                                         &frev, &crev, &data_offset)) =
{
> > +               return -EINVAL;
> > +       }
> > +
> > +       igp_info =3D (union igp_info *)
> > +                       (mode_info->atom_context->bios + data_offset);
> > +
> > +       return __amdgpu_atomfirmware_get_uma_carveout_info(adev, frev, =
crev, igp_info);
> > +}
> > +
> >  int
> >  amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
> >                                   int *vram_width, int *vram_type,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> > index 649b5530d8ae..fb3f34a36569 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> > @@ -32,6 +32,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amd=
gpu_device *adev);
> >  int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev=
);
> >  int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
> >         int *vram_width, int *vram_type, int *vram_vendor);
> > +int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *ad=
ev);
> >  int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
> >  int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
> >  bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)=
;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/am=
dgpu/atom.h
> > index 825ff28731f5..f07c612f0386 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> > @@ -153,6 +153,10 @@ struct atom_context {
> >         uint8_t vbios_ver_str[STRLEN_NORMAL];
> >         uint8_t date[STRLEN_NORMAL];
> >         uint8_t build_num[STRLEN_NORMAL];
> > +
> > +       uint8_t uma_carveout_index;
> > +       uint8_t uma_carveout_nr;
> > +       struct uma_carveout_option *uma_carveout_options;
>
> I don't think these really belong in the atom context.  They don't
> really have anything to do with atombios.  I think it makes more sense
> to do this in amdgpu_acpi_init() if atcs supports uma resizing.  If
> the atcs support is present, then call the atomfirmware function to
> parse the atom table and if all of that is ok, then register the sysfs
> interface.

Also, I think it would be better to abstract struct
uma_carveout_option in case the structure changes in future vbios
tables.

Alex

>
> Alex
>
>
> >  };
> >
> >  extern int amdgpu_atom_debug;
> >
> > --
> > 2.43.0
> >
