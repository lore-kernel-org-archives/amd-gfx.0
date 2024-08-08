Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1F0C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 19:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3747F10E072;
	Thu,  8 Aug 2024 19:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WT92RZYN";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF21A10E072
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 19:36:38 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2cb6662ba3aso948183a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Aug 2024 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723145798; x=1723750598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAYhIJJzC2YZ2f9IF0oTDhrYiW56kltNsXYaM5ValZQ=;
 b=WT92RZYNtbStfYv9NBGBfI3s8Vr5pzkNU9B0xzz1uWMPDumR5ViEWT7pzQAOcOL6kl
 R7b7yt9ZKN9UOj187M9HFBy87I5GqkFjPc/H7hmMOSKOeW8fis2qUQyqpD/bCDzjWBcN
 jnQZvTWOfnKKV5lSDjE4M1SvPbaow5eGv88KaLxUCL8mivfi+ggjNGNhBSrPJYp94YC7
 odrm3bArTjKopzUcYZAKHq60u1+ZIyvkV+wr+xaoR4lG9ydWAZuQu8cmYZ+LCUolBvzO
 34LdyKkp9XQ7swjGWgpQVI/bn7X+Fmdd2veuagsNH0f7rjdcVMOHUWHx+LARq3CKs+86
 5ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723145798; x=1723750598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAYhIJJzC2YZ2f9IF0oTDhrYiW56kltNsXYaM5ValZQ=;
 b=jQrX/NOHxhtKX5/074mH/yiRTOyefCA/EEsvGwFvQJB4IvxlyrDllE7BpGs7XYWjIx
 3Oy59G3f744V/IKXDWdVCUveNBuUufYO+xvS88VGg2CyVfkt0k8wi7OxI5uw5Aju31yo
 vMXqpJGrIweQDgxcBKl30198WoOhAIg7ZxN0qPeeqYz/KmP8EG8pP2R1aq/qVu4P+gP0
 6QFJ/G5xjYSy65zi3Yab/TAvZQFc/w7/unp1qPTLGQtle+/i3fk/orASI6XRItfuxXJO
 nTjC2u7aXI8azNY9yuttIsLgthMwGBbT8MiaG5Z9/zxl0gBE73j53EedgNBpRopxC/Ps
 J3VQ==
X-Gm-Message-State: AOJu0YxOKIZuDx8JUCr0npTQH+wj+7dBqdFj2AQzEkOLRlwFvqPwp+Bc
 vLCohtKbUd2w/cocEXLjt0+7oEN8QHDsEK+7FN4hKlmzG9lfeTrfOvNOR4Bo91QYrIh13Jm+eW/
 Yj7Cdk/Ymk7soG6FTYpCRf65vth7ySKwv
X-Google-Smtp-Source: AGHT+IElkYb/DvnoJOKebl0wVGBIf4Ar71gLCsHOMHRgsPhlZBuX9qwIOl7L8UdkebUCccDoN+Sw/yyHrHKUiICKfy8=
X-Received: by 2002:a17:90b:398:b0:2c9:7f8b:f7d8 with SMTP id
 98e67ed59e1d1-2d1c4fa3098mr4432240a91.6.1723145797955; Thu, 08 Aug 2024
 12:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240808174808.854282-1-victor.skvortsov@amd.com>
In-Reply-To: <20240808174808.854282-1-victor.skvortsov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Aug 2024 15:36:26 -0400
Message-ID: <CADnq5_PJamzCwdzo9XrRkr8QrfeM_1ePzEzxd=MJPC+Me8ah8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Block MMR_READ IOCTL in reset
To: Victor Skvortsov <victor.skvortsov@amd.com>
Cc: amd-gfx@lists.freedesktop.org, zhigang.luo@amd.com, 
 christian.koenig@amd.com, lijo.lazar@amd.com
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

On Thu, Aug 8, 2024 at 1:48=E2=80=AFPM Victor Skvortsov
<victor.skvortsov@amd.com> wrote:
>
> Register access from userspace should be blocked until
> reset is complete.

While you are at it, you should protect AMDGPU_INFO_SENSOR as well.
That queries PMFW which doesn't make sense during reset.  A few minor
comments below as well.

>
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 ++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 260cd0ad286d..038b400be437 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -778,6 +778,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>                                     ? -EFAULT : 0;
>         }
>         case AMDGPU_INFO_READ_MMR_REG: {
> +               int ret =3D 0;
>                 unsigned int n, alloc_size;
>                 uint32_t *regs;
>                 unsigned int se_num =3D (info->read_mmr_reg.instance >>
> @@ -787,24 +788,39 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>                                    AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
>                                   AMDGPU_INFO_MMR_SH_INDEX_MASK;
>
> +               if (!down_read_trylock(&adev->reset_domain->sem))
> +                       return -ENOENT;
> +
>                 /* set full masks if the userspace set all bits
>                  * in the bitfields
>                  */
> -               if (se_num =3D=3D AMDGPU_INFO_MMR_SE_INDEX_MASK)
> +               if (se_num =3D=3D AMDGPU_INFO_MMR_SE_INDEX_MASK) {
>                         se_num =3D 0xffffffff;
> -               else if (se_num >=3D AMDGPU_GFX_MAX_SE)
> -                       return -EINVAL;
> -               if (sh_num =3D=3D AMDGPU_INFO_MMR_SH_INDEX_MASK)
> +               }
> +               else if (se_num >=3D AMDGPU_GFX_MAX_SE) {

Kernel coding style.  Put the } on the same line as the else.

> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
> +
> +               if (sh_num =3D=3D AMDGPU_INFO_MMR_SH_INDEX_MASK) {
>                         sh_num =3D 0xffffffff;
> -               else if (sh_num >=3D AMDGPU_GFX_MAX_SH_PER_SE)
> -                       return -EINVAL;
> +               }
> +               else if (sh_num >=3D AMDGPU_GFX_MAX_SH_PER_SE) {

Same here.

> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
>
> -               if (info->read_mmr_reg.count > 128)
> -                       return -EINVAL;
> +               if (info->read_mmr_reg.count > 128) {
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
>
>                 regs =3D kmalloc_array(info->read_mmr_reg.count, sizeof(*=
regs), GFP_KERNEL);
> -               if (!regs)
> -                       return -ENOMEM;
> +               if (!regs) {
> +                       ret =3D -ENOMEM;
> +                       goto out;
> +               }
> +
>                 alloc_size =3D info->read_mmr_reg.count * sizeof(*regs);
>
>                 amdgpu_gfx_off_ctrl(adev, false);
> @@ -816,13 +832,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>                                               info->read_mmr_reg.dword_of=
fset + i);
>                                 kfree(regs);
>                                 amdgpu_gfx_off_ctrl(adev, true);
> -                               return -EFAULT;
> +                               ret =3D -EFAULT;
> +                               goto out;
>                         }
>                 }
>                 amdgpu_gfx_off_ctrl(adev, true);
>                 n =3D copy_to_user(out, regs, min(size, alloc_size));
>                 kfree(regs);
> -               return n ? -EFAULT : 0;
> +               ret =3D (n ? -EFAULT : 0);
> +out:
> +               up_read(&adev->reset_domain->sem);
> +               return ret;
>         }
>         case AMDGPU_INFO_DEV_INFO: {
>                 struct drm_amdgpu_info_device *dev_info;
> --
> 2.34.1
>
