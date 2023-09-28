Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB63EE732D0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 13:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9275B10E65F;
	Thu, 28 Sep 2023 13:41:18 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5608610E65F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 13:41:17 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3add37de892so6491991b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695908476; x=1696513276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCxMaA6rt4SZiWdQqKbh+6m6HTn0xzG2Uz7MWD6mtn0=;
 b=cuNZ8X9lkaA6RGNtxyEjRCftsg7L+enAAEQuPQW5UYAvUUriPCjIi3Tv7d2ya1Nh1f
 E6Ov9+yTWfdSB89i8pb4R8kqPnJwDwh8K2QaLXKqJTtE7+wVb9QoU2xsS/NELveJesVD
 jYv9JZbXUkSMl6EYdGs3v+Bgqr6hDbpuT3u+IFArMAJP4z35gPeqW/+M2ZWBANMgzRBL
 PN7B+vfU1ydKPG54HXmrl7iwwVwS0NJjcTuliVFzqvZaqFl38Ih8PqOZO8lxfIpGTOdE
 cZFx58M4Tjezf7Ir+JY9Ff1okXVbydSnl3nZy/ThXOGyNKfIAPAMRDhG6npMLpIiMrCR
 luXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695908476; x=1696513276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCxMaA6rt4SZiWdQqKbh+6m6HTn0xzG2Uz7MWD6mtn0=;
 b=cbRztSCBxBavGP5cN+cp3AnuULTGEPRp4p8uUI4Fb5tU4H7T4bPScsubQe7FaPggem
 h+2i9QNRUieBKjb4D5wp6wBr67BjhNP1c3S7YxN4JoRRaM9PvCjbjHOW0HRNdfJU6bwe
 hrmhNJYqrzMfB3ALlqrnI5+AnRrdLsZ3fLUoN/pT4zWDSNFkkElFTMNVqomjF2SG5wPZ
 gUYa8ZRAIaOh70M2vKDWTw1xPeASBCueloqGUEajWax0ja1xqHY+En8ENohV2e7goqbn
 ER/+yRfs6u4hNogL2RNX5R5f6t2QaKhWR2ixB3n12FdM7PW8iN0QEtqu3pyOGnVu++bQ
 W2xg==
X-Gm-Message-State: AOJu0YyNB1bOZ+wZtldmVwn+DnYyeQGs/UaU07BTALZsqvuXik9ma74r
 LPuZHeR8MQl1ohds5poivkciL8YlHtw7YP//JeKsKap4
X-Google-Smtp-Source: AGHT+IHd/KF/zXFu7sp90g6qudrRBzmOMSX3LZeBXUxjt6eO0ZyPLas/L5b8HQW7DsZ+mp6BQ+pIETlQ1cw7HpX5zg8=
X-Received: by 2002:a05:6870:79c:b0:1d0:dbdd:2792 with SMTP id
 en28-20020a056870079c00b001d0dbdd2792mr1148550oab.39.1695908476503; Thu, 28
 Sep 2023 06:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230928083311.2858681-1-yifan1.zhang@amd.com>
In-Reply-To: <20230928083311.2858681-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Sep 2023 09:41:05 -0400
Message-ID: <CADnq5_MOJaEYn2f51MSXfbr_1SgOu0E0ROprDkN=tAovquWzyg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: enable S/G display for for recent
 APUs by default
To: Yifan Zhang <yifan1.zhang@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 28, 2023 at 5:11=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> With S/G display becomes stable, enable S/G display for recent APUs
> by default rather than white list.
>
> v2: explicitly disable sg on pre-CZ chips (Alex)
>
> Co-authored-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 47 ++++++-------------
>  1 file changed, 14 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8e5dfdee22e6..8963d9c251f3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1627,41 +1627,22 @@ static int amdgpu_dm_init(struct amdgpu_device *a=
dev)
>                 break;
>         }
>
> -       switch (adev->asic_type) {
> -       case CHIP_CARRIZO:
> -       case CHIP_STONEY:
> -               init_data.flags.gpu_vm_support =3D true;
> -               break;
> -       default:
> -               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> -               case IP_VERSION(1, 0, 0):
> -               case IP_VERSION(1, 0, 1):
> -                       /* enable S/G on PCO and RV2 */
> -                       if ((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
> -                           (adev->apu_flags & AMD_APU_IS_PICASSO))
> -                               init_data.flags.gpu_vm_support =3D true;
> -                       break;
> -               case IP_VERSION(2, 1, 0):
> -               case IP_VERSION(3, 0, 1):
> -               case IP_VERSION(3, 1, 2):
> -               case IP_VERSION(3, 1, 3):
> -               case IP_VERSION(3, 1, 4):
> -               case IP_VERSION(3, 1, 5):
> -               case IP_VERSION(3, 1, 6):
> -               case IP_VERSION(3, 5, 0):
> -                       init_data.flags.gpu_vm_support =3D true;
> -                       break;
> -               default:
> -                       break;
> -               }
> -               break;
> -       }
> -       if (init_data.flags.gpu_vm_support &&
> -           (amdgpu_sg_display =3D=3D 0))
> +       /* APU support S/G display by default except:
> +        * ASICs before Carrizo,
> +        * RAVEN1 (Users repored stability issue)
> +        */
> +
> +       if (adev->asic_type < CHIP_CARRIZO)
>                 init_data.flags.gpu_vm_support =3D false;
> +       else if (adev->asic_type =3D=3D CHIP_RAVEN) {
> +               if (adev->apu_flags & AMD_APU_IS_RAVEN)
> +                       init_data.flags.gpu_vm_support =3D false;
> +               else
> +                       init_data.flags.gpu_vm_support =3D (amdgpu_sg_dis=
play !=3D 0);
> +       } else
> +               init_data.flags.gpu_vm_support =3D (amdgpu_sg_display !=
=3D 0) && (adev->flags & AMD_IS_APU);
>

per kernel coding style, if any clause has parens, every clause should
have parens.  With that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> -       if (init_data.flags.gpu_vm_support)
> -               adev->mode_info.gpu_vm_support =3D true;
> +       init_data.flags.gpu_vm_support =3D adev->mode_info.gpu_vm_support=
;
>
>         if (amdgpu_dc_feature_mask & DC_FBC_MASK)
>                 init_data.flags.fbc_support =3D true;
> --
> 2.37.3
>
