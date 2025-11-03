Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577EDCCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 21:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC19410E498;
	Mon,  3 Nov 2025 21:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ftEebDf7";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DF810E498
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 21:22:22 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b9a2e3c4afcso132403a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 13:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762204942; x=1762809742; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rE58hiRTUlrMIT0NpYlRD5TeFsqNiDpC2v9wB4IFQxM=;
 b=ftEebDf7d0aHezJUmk4PwWpaWPNWxPtiap6jmNpIXjh9cscGpMSXZZNFdU1B0X/pTx
 d1RcFgkZ1ANDkta4jmcGwintt4wkfWoOAgM31TehmP8kJSDZf9fftehdgUiSG/C3G4gk
 zxvkbY0C/tpEAXc5TslpG3mt0crKcFGDJnAXwM1icO4rDsL1T8Uv0qyvw968G7ACdRmu
 8JJ/dPuQ3ylyui0WC1zW/KWnqKs4CUd4+yAxagGDXsNxBHAqXiA61yugCxWQl8OdMSg3
 RV4Trb0F1yHjyESch3hnsHAfrdCM0M2/FhB0zzzKK1xt1pUWdpMtyyXDNegheVXg2ic7
 lxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204942; x=1762809742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rE58hiRTUlrMIT0NpYlRD5TeFsqNiDpC2v9wB4IFQxM=;
 b=GeZVTC7Jz8K7WhVPNBs+DDQXPvDVltAm+L2563mfK7oQAhS7gZzBmhOwke6VUIFE9c
 KmRzD6qY66BTYYcuDByGMh207umQwLh6DW/yzyMBcnBdMLvy79avenyZNCJwpaQoPDMl
 kAXqKOuSB/nlcHf2l7i7DRA2ryKy02lLt3k2fWvwvBjwRUjtVzxHXfrDCYkN9DA0E3m4
 cnl9J8Kvl8z5AhoqYAUlF8KA0r9LEMAcJj8wciDJ/c5PrE7SMj20wLYQAoQMff/gU+Wk
 6FwtmpfCuGkkt5zQ0dRkYt5/aV7AZlQnMbybZGCBK9TER/Vyp7dGZ8qHqJ9HW0AOQuPy
 xdeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOhOo22qF41cyBHHberKKloc3ea7xPGRphCefOMdGarq+w0GjWWyJIEjJbsk2zjLBpYrrJC+QV@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/c8+m5XmrE6RNDUzA9/NW7Mv6d49y4k1BhDYVQOkU/btjJTFk
 xUVTJkv+xlxbkttUaN7y0RHboyyNGh4x7E2ru6+0e2F5dej6qmewUhlKsEEMjppvjU6BzwWqt5X
 7kSWxzZUhRbvcJbrFaJmlxFFFdMt8gqgG8Q==
X-Gm-Gg: ASbGnctTyBiGZCIUnI4n/sfWHvizDLtAtv0xN2jlqNdXAqmLF2JOnHiIzRGsAbCnFnC
 HrYcrq9Tq5c5UgLLodFJIirH6oVRXOLdLXaYiZiEJPqu05FHQ82mr0qtkKbgWEuhjqwGjOM4ydF
 aWLooOS3fkxFAakm45x3CFzHsivdLE1mBAAMHhJwfUdF4B10MF+mnmd2hsCFoiRXHKwkgx1uiO6
 MRKFVjTb888qp4jMCVt650H3rg9FzKrgTtBdgGQk2u7nFZ0qyOGty6iVoTY
X-Google-Smtp-Source: AGHT+IF+pa7nAIZJIzPewlRle8Ustg8pMZwlv03Og8EB/KzMFu1aqoYGB9P15oduASqkSOuCDnhkCrkbBG7VOwG5Py0=
X-Received: by 2002:a17:902:c40a:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-2951a3bbbe7mr109882355ad.4.1762204941993; Mon, 03 Nov 2025
 13:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20251103-vram-carveout-tuning-for-upstream-v1-0-17e2a72639c5@amd.com>
 <20251103-vram-carveout-tuning-for-upstream-v1-2-17e2a72639c5@amd.com>
In-Reply-To: <20251103-vram-carveout-tuning-for-upstream-v1-2-17e2a72639c5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Nov 2025 16:22:09 -0500
X-Gm-Features: AWmQ_bmeOchvSm4HGcyqJCHq618GmRuqKM6n2IV2ncTp0L5vtC9OpsiExT2E_x0
Message-ID: <CADnq5_PS7pfseo84hVPfBevJqrfBxHEAct0w35xVjNg0cjREqg@mail.gmail.com>
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

On Mon, Nov 3, 2025 at 2:54=E2=80=AFAM Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.c=
om> wrote:
>
> Currently, the available UMA allocation configs in the integrated system
> information table have not been parsed. Add a helper function to retrieve
> and store these configs.
>
> Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c     | 32 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 75 ++++++++++++++++++=
++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/atom.h                |  4 ++
>  4 files changed, 107 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_atombios.c
> index 763f2b8dcf13..58cc3bc9d42d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -28,6 +28,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_atombios.h"
>  #include "amdgpu_atomfirmware.h"
> +#include "atomfirmware.h"
>  #include "amdgpu_i2c.h"
>  #include "amdgpu_display.h"
>
> @@ -1877,6 +1878,10 @@ void amdgpu_atombios_fini(struct amdgpu_device *ad=
ev)
>         if (adev->mode_info.atom_context) {
>                 kfree(adev->mode_info.atom_context->scratch);
>                 kfree(adev->mode_info.atom_context->iio);
> +               kfree(adev->mode_info.atom_context->uma_carveout_options)=
;
> +               adev->mode_info.atom_context->uma_carveout_options =3D NU=
LL;
> +               adev->mode_info.atom_context->uma_carveout_nr =3D 0;
> +               adev->mode_info.atom_context->uma_carveout_index =3D 0;
>         }
>         kfree(adev->mode_info.atom_context);
>         adev->mode_info.atom_context =3D NULL;
> @@ -1891,16 +1896,19 @@ void amdgpu_atombios_fini(struct amdgpu_device *a=
dev)
>   *
>   * Initializes the driver info and register access callbacks for the
>   * ATOM interpreter (r4xx+).
> - * Returns 0 on sucess, -ENOMEM on failure.
> + * Returns 0 on success, -ENOMEM on memory allocation error, or -EINVAL =
on ATOM ROM parsing error
>   * Called at driver startup.
>   */
>  int amdgpu_atombios_init(struct amdgpu_device *adev)
>  {
>         struct card_info *atom_card_info =3D
>             kzalloc(sizeof(struct card_info), GFP_KERNEL);
> +       int rc;
>
> -       if (!atom_card_info)
> -               return -ENOMEM;
> +       if (!atom_card_info) {
> +               rc =3D -ENOMEM;
> +               goto out_card_info;
> +       }
>
>         adev->mode_info.atom_card_info =3D atom_card_info;
>         atom_card_info->dev =3D adev_to_drm(adev);
> @@ -1913,8 +1921,16 @@ int amdgpu_atombios_init(struct amdgpu_device *ade=
v)
>
>         adev->mode_info.atom_context =3D amdgpu_atom_parse(atom_card_info=
, adev->bios);
>         if (!adev->mode_info.atom_context) {
> -               amdgpu_atombios_fini(adev);
> -               return -ENOMEM;
> +               rc =3D -ENOMEM;
> +               goto out_atom_ctx;
> +       }
> +
> +       rc =3D amdgpu_atomfirmware_get_uma_carveout_info(adev);
> +
> +       if (rc) {
> +               drm_dbg(adev_to_drm(adev), "Failed to get UMA carveout in=
fo: %d\n", rc);
> +               if (rc !=3D -ENODEV)
> +                       goto out_uma_info;
>         }
>
>         mutex_init(&adev->mode_info.atom_context->mutex);
> @@ -1930,6 +1946,12 @@ int amdgpu_atombios_init(struct amdgpu_device *ade=
v)
>         }
>
>         return 0;
> +
> +out_uma_info:
> +out_atom_ctx:
> +       amdgpu_atombios_fini(adev);
> +out_card_info:
> +       return rc;
>  }
>
>  int amdgpu_atombios_get_data_table(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 636385c80f64..698416e84f1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -21,12 +21,14 @@
>   *
>   */
>
> +#include "linux/slab.h"
>  #include <drm/amdgpu_drm.h>
>  #include "amdgpu.h"
>  #include "atomfirmware.h"
>  #include "amdgpu_atomfirmware.h"
>  #include "atom.h"
>  #include "atombios.h"
> +#include "atomfirmware.h"
>  #include "soc15_hw_ip.h"
>
>  union firmware_info {
> @@ -296,6 +298,79 @@ static int convert_atom_mem_type_to_vram_type(struct=
 amdgpu_device *adev,
>         return vram_type;
>  }
>
> +static int __amdgpu_atomfirmware_get_uma_carveout_info_v2_3(struct amdgp=
u_device *adev,
> +                                                           union igp_inf=
o *igp_info)
> +{
> +       struct atom_context *ctx =3D adev->mode_info.atom_context;
> +       struct uma_carveout_option *opts;
> +
> +       opts =3D kzalloc(sizeof(igp_info->v23.UMASizeControlOption), GFP_=
KERNEL);
> +
> +       if (!opts)
> +               goto out_mem;
> +
> +       memcpy(opts, igp_info->v23.UMASizeControlOption,
> +               sizeof(igp_info->v23.UMASizeControlOption));
> +
> +       ctx->uma_carveout_index =3D igp_info->v23.UMACarveoutIndex;
> +       ctx->uma_carveout_nr =3D igp_info->v23.UMACarveoutIndexMax;
> +       ctx->uma_carveout_options =3D opts;
> +
> +       return 0;
> +
> +out_mem:
> +       return -ENOMEM;
> +}
> +
> +static int __amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_dev=
ice *adev,
> +                                                      u8 frev, u8 crev,
> +                                                      union igp_info *ig=
p_info)
> +{
> +       switch (frev) {
> +       case 2:
> +               switch (crev) {
> +               case 3:
> +                       return __amdgpu_atomfirmware_get_uma_carveout_inf=
o_v2_3(adev, igp_info);
> +               break;
> +               default:
> +                       break;
> +               }
> +               break;
> +       default:
> +               break;
> +       }
> +       return -ENODEV;
> +}

I think this function can be moved into
amdgpu_atomfirmware_get_uma_carveout_info().

> +
> +int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev=
)
> +{
> +       struct amdgpu_mode_info *mode_info =3D &adev->mode_info;
> +       union igp_info *igp_info;
> +       u16 data_offset, size;
> +       u8 frev, crev;
> +       int index;
> +
> +       if (!(adev->flags & AMD_IS_APU))
> +               return -ENODEV;
> +
> +       if (!amdgpu_acpi_is_set_uma_allocation_size_supported())
> +               return -ENODEV;
> +
> +       index =3D get_index_into_master_table(atom_master_list_of_data_ta=
bles_v2_1,
> +                                           integratedsysteminfo);
> +
> +       if (!amdgpu_atom_parse_data_header(mode_info->atom_context,
> +                                         index, &size,
> +                                         &frev, &crev, &data_offset)) {
> +               return -EINVAL;
> +       }
> +
> +       igp_info =3D (union igp_info *)
> +                       (mode_info->atom_context->bios + data_offset);
> +
> +       return __amdgpu_atomfirmware_get_uma_carveout_info(adev, frev, cr=
ev, igp_info);
> +}
> +
>  int
>  amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>                                   int *vram_width, int *vram_type,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> index 649b5530d8ae..fb3f34a36569 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> @@ -32,6 +32,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgp=
u_device *adev);
>  int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>         int *vram_width, int *vram_type, int *vram_vendor);
> +int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev=
);
>  int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
>  bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdg=
pu/atom.h
> index 825ff28731f5..f07c612f0386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -153,6 +153,10 @@ struct atom_context {
>         uint8_t vbios_ver_str[STRLEN_NORMAL];
>         uint8_t date[STRLEN_NORMAL];
>         uint8_t build_num[STRLEN_NORMAL];
> +
> +       uint8_t uma_carveout_index;
> +       uint8_t uma_carveout_nr;
> +       struct uma_carveout_option *uma_carveout_options;

I don't think these really belong in the atom context.  They don't
really have anything to do with atombios.  I think it makes more sense
to do this in amdgpu_acpi_init() if atcs supports uma resizing.  If
the atcs support is present, then call the atomfirmware function to
parse the atom table and if all of that is ok, then register the sysfs
interface.

Alex


>  };
>
>  extern int amdgpu_atom_debug;
>
> --
> 2.43.0
>
