Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFFCCD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C60F10E6C6;
	Tue, 26 May 2026 14:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZ2lohPz";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290EF10E6C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:56:45 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2f5ae07e2b5so880505eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807404; cv=none;
 d=google.com; s=arc-20240605;
 b=TBlRKUapyivRnINf89oka3P4flE4N6kzK8EbQSz530oZV+kGXGL7lxLUCIMgGjvEoB
 VDuem2nqhcJhRAqD1z3cPAZufs6Kj3YztBJwOJAcdLVFkTXSY3wsIWItCm0JU9JuV9Pv
 e/fj1ihCkFvnbw5r0SOoyo1mJp26Dxfv1dw2rMEXu2O9mxhXQewcW5zisGT8P5p6kgMI
 Z2jH/rIzyU/uylaOYx6ku6ivWfGkmialcNk6CqpHS8Tildk5HWvfMd1E+j9kbV0fMQQy
 iplX4Aw8YaDxkGKF7/pzXZ0hy1cCmTrII5v3l3kKGVmz9uejdOIci2aSEhwym1v+VgXe
 ATAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tI22CPFGaKrd01fmh2ZM4WpxkHdvHkakusZ+j/F0kqk=;
 fh=cwZWq2y/UFVxAjysJ5chknycDngSNUSdj6WZMuPulsM=;
 b=ZivTu/rUd9pZvz1wXDJwNLH0KPyxTvnFzeX3FLxHZdQ/4TKRkr+LTTjpBTWZGJ0sTm
 YUxRMGMbn6KmXUAyskMq2lNqG5uyn92KUZAjQ/ZP0oGsn9968R2rajZ8mEeDvzyu43Uo
 kf0dXt6mjflqcDU/T55gc+9huKSaBWC1XkUKEw5GtPM4PUcQjJgQIRX3SLIS/kLKk7V8
 YjhtE+o1w4+5Y04jOx1osjVVJuog9yLWXjGojzxwkSFlSNGwYIzjxasaFjQZf4ub1Ntr
 URB/igu3erSW/9rOOYYlrzcUiqH/y7JQGG0faP4Gahjg69Y471luo5NFKYA9q1OyTvWM
 Zn2A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779807404; x=1780412204; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tI22CPFGaKrd01fmh2ZM4WpxkHdvHkakusZ+j/F0kqk=;
 b=kZ2lohPzTYZI9qioi/zTf8JsgSTA5VgoUdhW91kV/OyMZ7s4gUH+V0Dilac9Cav7G9
 u7hDIH02bIswXJ0dMkoVoKWN+BNLbW3/bLpbWvUbC9FSR6BE4jvYntc8yI29iW6Ey5zR
 +I4kjs7s9MV1QDdPTRxIOCCCmRgn4HDEj1RFYNCvqvGCqgN2Wp3D3giG5XXG5gsmHs7r
 HxQyHsPps/kCc44hYjP+3y68JXEsu0bxgFsobG9AqiNJOUmo9s7ypaUrD2OwnX9z8hEs
 f7luy33Gr9hMhF0byzcO/AF2KqqaseyOKN4lmOLXpwE4G5xY+gf6cXcl86vES7IU3s6M
 SzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807404; x=1780412204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tI22CPFGaKrd01fmh2ZM4WpxkHdvHkakusZ+j/F0kqk=;
 b=B+C2rN8FcMBMi8beOvYjRz12uuM/6bHhkM2hP0QrcUv0SWiqq/UBNAKk9e517YgmDx
 P8z3pHoo7Ym6RWB3nVnnsOhZ89anlMUG0cMRiWh8GMG6HZqzBs19ydYhAj4sCOJfCOVN
 BOW28BDhmPZhFR/U10FiE+qSkUmpMYSYgGAd7VgDEvroW8Y2wQY456gXionB2JVBZPBW
 1VnedB3XWvqFjVUXJlbHNa8+lMv8Shtm8zdUEBMB7f1395FfcSqztHQxmOMEZcamPVLa
 m09ItHWxunynklCZIbLAmkPE7IQzslEZj8Tr01prG7CLhBxgqWQH3BCMilB945uU/C35
 xFOQ==
X-Gm-Message-State: AOJu0Yzf3q2SwNWqgiF5kbmeNRSHMXJZOsAc8bfc6M5fBi0v3uBBF6iV
 QLFub9fneVzKY/za3Cbdu0/VddEqFpRaWA/tpoGTXOrCoxz0ER5vkc/Qcpn98V3d+aiFNeqm679
 QSCCv2Rz3mNlieDsGpRejaNLGWcXNC+U=
X-Gm-Gg: Acq92OFGcD+BPNgh7fH3UizBvrnf9iXWP4sBEXzdkCpmiJot1yeQjPt/d0Hh8IPripy
 egAog1R2W1lz5c1LwKPABOKbrHsVNtUPUttErk10KaZUQV+HxgS1p7BkIaj/a9UM/csrRRb+TLH
 kjF5PJNAJua6Vcl1eP5OyBYKNIPYvUiy1Brmn2xKeFv8uesplRSZPynJLu2GnCnOKOGKp16DqzE
 eU6cXgBen/arxLfz6lz5JvhdFbNR5PFU64vF6J6dp47r588YV0SzkPnWwvxztg1uCzVuRQyUFaK
 PHP72EKtXbQgiSFs7HarqMeR8Eeh4/Vpj4tCo8+2h7REUbaao8yWVQqqblPWQ1h8W7KQqg==
X-Received: by 2002:a05:7022:68a3:b0:135:1b09:db43 with SMTP id
 a92af1059eb24-1365fb651b4mr3207115c88.6.1779807404343; Tue, 26 May 2026
 07:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260526072954.7665-1-cesun102@amd.com>
In-Reply-To: <20260526072954.7665-1-cesun102@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 10:56:33 -0400
X-Gm-Features: AVHnY4IJ8OsRWWzV2aooOjtP9jWJ4Cn4cFoObNnTKjAkUgcyOSY_iDPieDLp_u8
Message-ID: <CADnq5_OtqC1MSCyqWXauNbJPKXh43A3uDbNbttHMMo6gbG0LsA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix user-triggerable BUG()/BUG_ON() calls
To: Ce Sun <cesun102@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, YiPeng.Chai@amd.com, 
 Tao.Zhou1@amd.com, stanley.yang@amd.com
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

On Tue, May 26, 2026 at 3:30=E2=80=AFAM Ce Sun <cesun102@amd.com> wrote:
>
> Replace BUG()/BUG_ON() with error logs and safe returns in several
> places where they can be triggered by invalid userspace input,
> preventing DoS via kernel panic.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  7 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c     | 14 ++++++++++----
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c              |  2 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  2 +-
>  4 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5ccbe6c885cf..8fbaaf62f7a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -717,7 +717,12 @@ void amdgpu_device_mm_access(struct amdgpu_device *a=
dev, loff_t pos,
>         if (!drm_dev_enter(adev_to_drm(adev), &idx))
>                 return;
>
> -       BUG_ON(!IS_ALIGNED(pos, 4) || !IS_ALIGNED(size, 4));
> +       if (!IS_ALIGNED(pos, 4) || !IS_ALIGNED(size, 4)) {
> +               dev_err(adev->dev, "unaligned pos/size (pos=3D0x%llx, siz=
e=3D0x%zx)\n",
> +                       pos, size);
> +               drm_dev_exit(idx);
> +               return;
> +       }
>
>         spin_lock_irqsave(&adev->mmio_idx_lock, flags);
>         for (last =3D pos + size; pos < last; pos +=3D 4) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_reg_access.c
> index daefbeeee4d2..7468855c16a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> @@ -406,7 +406,10 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, =
uint32_t offset)
>
>         if (offset < adev->rmmio_size)
>                 return (readb(adev->rmmio + offset));
> -       BUG();
> +
> +       dev_err(adev->dev, "invalid MMIO read offset 0x%x (rmmio size 0x%=
x)\n",
> +               offset, (unsigned int)adev->rmmio_size);
> +       return 0;
>  }
>
>  /**
> @@ -469,10 +472,13 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, ui=
nt32_t offset, uint8_t value)
>         if (amdgpu_device_skip_hw_access(adev))
>                 return;
>
> -       if (offset < adev->rmmio_size)
> +       if (offset < adev->rmmio_size) {
>                 writeb(value, adev->rmmio + offset);
> -       else
> -               BUG();
> +       } else {
> +               dev_err(adev->dev, "invalid MMIO write offset 0x%x (rmmio=
 size 0x%x)\n",
> +                       offset, (unsigned int)adev->rmmio_size);
> +               return;
> +       }
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/=
amdgpu/mxgpu_vi.c
> index e1d63bed84bf..c3293e5a658c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -308,7 +308,7 @@ void xgpu_vi_init_golden_registers(struct amdgpu_devi=
ce *adev)
>                                                                 xgpu_tong=
a_golden_common_all));
>                 break;
>         default:
> -               BUG_ON("Doesn't support chip type.\n");
> +               dev_err(adev->dev, "Doesn't support chip type %d\n", adev=
->asic_type);
>                 break;
>         }
>  }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index c491af21a34c..0f6e2b55625a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -961,7 +961,7 @@ bool dm_helpers_is_dp_sink_present(struct dc_link *li=
nk)
>         struct amdgpu_dm_connector *aconnector =3D link->priv;
>
>         if (!aconnector) {
> -               BUG_ON("Failed to find connector for link!");
> +               DRM_ERROR("Failed to find connector for link!");
>                 return true;
>         }
>
> --
> 2.34.1
>
