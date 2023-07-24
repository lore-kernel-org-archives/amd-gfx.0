Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496FBC001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 14:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DF110E328;
	Mon, 24 Jul 2023 14:25:09 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A95510E328
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 14:25:08 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3a3efebcc24so3082102b6e.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690208707; x=1690813507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sl/Yq4NrWFMwXsMkM5NPt51qaXkJvns5aXe/2N1jWZs=;
 b=j05cPoz09m/qMhgudkw041xr+StEAMeoYivcSuPDvLZZUOTaW0Wx4bbieHSR2SN1Wx
 w1aD9sFIuv31ZkrT8wZ+1TdkQrOHSX6KbpgtrWLbywoWMrKWor047yj91tg6QNS8nInx
 biRXPdASvLZC7bxJEFQqVfSI8cjQFrjeRpT+08J0TZ/bFGpmM85RLgTIoX8EGWhFqmpD
 4dCaqiN6u1xI+UKx2FjYG3Qbc6BMwLha/KKvvC2Djv/rmrpWD7A/zcXO6e3egnjbH0Pn
 O2A0Yb15BJ4aladMTlJ3T2jsLZB1ohvWW5fiDQGkK+3liVVSRq77P/V/0dkLMzZgQQzL
 akpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690208707; x=1690813507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sl/Yq4NrWFMwXsMkM5NPt51qaXkJvns5aXe/2N1jWZs=;
 b=fycBH+tX1+/LDyovjSq8ArzwwMyp8xCtfmimN7POwEXNTkyKFPazOLUHufUkjERQ8E
 xG0B0HudjM8+QQfvLtpFBy//j1q3WEAmdZ9odpxcy+mZ+lqjuQpFYf1EcpfrLnF+7FJm
 79t25mSfNpb7rmEEFmlo9NpmKHzG6DKCWnDTdlsvSoGABgEKX1v6zrgOxAfZBkGaWqX6
 9oTM+sS7nVDVMgDRNQngVbtfGUyI0goY2O0LiGj39OCK756jltVjTj7/fBFQBQzNAmNk
 XSMd29RDoLniMHlu2O2274+l+zPKzIshCssLMvqnA5flyhHVXoIWVUYgQwqkDlkJPO6G
 NvXg==
X-Gm-Message-State: ABy/qLbvDwpL6fpLVCkUjMLRsZnmm8E3onaVdVcy1jjrmAOvK0ZvJfNK
 cLIo49yv3yDd0TSVLP1aekWFuzZsqpeu/jKSd60QybJK
X-Google-Smtp-Source: APBJJlFqEa1aC9nrVVt+zyGf3E7x9K5KqNyimsor/Qfew4gsCjPMlg1Rs+uo5uO8h/argRH9B2ff7iOHN18d1TVWOcA=
X-Received: by 2002:a05:6808:1b14:b0:3a2:7f5:c4a with SMTP id
 bx20-20020a0568081b1400b003a207f50c4amr11938953oib.25.1690208707587; Mon, 24
 Jul 2023 07:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230723070527.2024673-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230723070527.2024673-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jul 2023 10:24:56 -0400
Message-ID: <CADnq5_OYvJhCFS5OUP_5y-vvqMp0GC_k9r0p2OdQ0PYVgDjgdQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Update min() to min_t() in 'amdgpu_info_ioctl'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jul 23, 2023 at 3:06=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following:
>
> WARNING: min() should probably be min_t(size_t, size, sizeof(ip))
> +               ret =3D copy_to_user(out, &ip, min((size_t)size, sizeof(i=
p)));
>
> And other style fixes:
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: Missing a blank line after declarations
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 12f3c7ad7d04..631c5ab3f7dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -557,6 +557,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>                         crtc =3D (struct drm_crtc *)minfo->crtcs[i];
>                         if (crtc && crtc->base.id =3D=3D info->mode_crtc.=
id) {
>                                 struct amdgpu_crtc *amdgpu_crtc =3D to_am=
dgpu_crtc(crtc);
> +
>                                 ui32 =3D amdgpu_crtc->crtc_id;
>                                 found =3D 1;
>                                 break;
> @@ -575,7 +576,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>                 if (ret)
>                         return ret;
>
> -               ret =3D copy_to_user(out, &ip, min((size_t)size, sizeof(i=
p)));
> +               ret =3D copy_to_user(out, &ip, min_t(size_t, size, sizeof=
(ip)));
>                 return ret ? -EFAULT : 0;
>         }
>         case AMDGPU_INFO_HW_IP_COUNT: {
> @@ -721,17 +722,18 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>                                     ? -EFAULT : 0;
>         }
>         case AMDGPU_INFO_READ_MMR_REG: {
> -               unsigned n, alloc_size;
> +               unsigned int n, alloc_size;
>                 uint32_t *regs;
> -               unsigned se_num =3D (info->read_mmr_reg.instance >>
> +               unsigned int se_num =3D (info->read_mmr_reg.instance >>
>                                    AMDGPU_INFO_MMR_SE_INDEX_SHIFT) &
>                                   AMDGPU_INFO_MMR_SE_INDEX_MASK;
> -               unsigned sh_num =3D (info->read_mmr_reg.instance >>
> +               unsigned int sh_num =3D (info->read_mmr_reg.instance >>
>                                    AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
>                                   AMDGPU_INFO_MMR_SH_INDEX_MASK;
>
>                 /* set full masks if the userspace set all bits
> -                * in the bitfields */
> +                * in the bitfields
> +                */
>                 if (se_num =3D=3D AMDGPU_INFO_MMR_SE_INDEX_MASK)
>                         se_num =3D 0xffffffff;
>                 else if (se_num >=3D AMDGPU_GFX_MAX_SE)
> @@ -896,7 +898,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>                 return ret;
>         }
>         case AMDGPU_INFO_VCE_CLOCK_TABLE: {
> -               unsigned i;
> +               unsigned int i;
>                 struct drm_amdgpu_info_vce_clock_table vce_clk_table =3D =
{};
>                 struct amd_vce_state *vce_state;
>
> --
> 2.25.1
>
