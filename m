Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE2CC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 12:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956EC10E591;
	Tue, 22 Apr 2025 12:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G9oKzAdm";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D1910E591
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 12:55:50 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-301a8b7398cso845279a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745326549; x=1745931349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RX7MXRawcF6/OGEniy/QhQRFVOBApFL0duz2pDuyyg=;
 b=G9oKzAdmz4+gqgzkG0LpeL7WRc0jg/KXn7yBDv/6gn0lMjnHVlA+WhOqCNfJGRn6LU
 Jaqkddwsjv9b1sAjWh6CfAKQvDuJEU5T6TiHb7PkgtV6d3tR5VERR498ZS96xeDGt1/U
 HMT6neUiFs4yGMmWE2VHKGYq0VzEsr5bZGm1DRIPgSSe2oDJTK6OF+/EPJgFq6ODPoyl
 VKSXcmMUqnWldscXQhRlkguFnGkPT9X/sErIMbTDnCvhVBlNihIa3R4w84bnWtPSFbDE
 TOzoc6qAfbnFdQLTsea0+8+DKh/m37mTbCbnoPWVwozhcE/qrpQynMyNvi3eachiBFQk
 JPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745326549; x=1745931349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5RX7MXRawcF6/OGEniy/QhQRFVOBApFL0duz2pDuyyg=;
 b=kK6h8U8cerHDhL9npJzb5evsHCboIkBN4CDlzQ0ClVGL2+iAXbNC52Q9FNZdaJeDl1
 TXUStxqOBuXcd8miEOARENVg01BcMty5SeL99PDCbJfbuEBZopIELb4NOd9mV7PEY1eT
 hXKVG+4j6380daVoCOt3Z4lBJJU6ap3Pt67Jydgz4fUp26K/K1+e8Wxm200Zg6JS32RW
 oBVKHNmVJTEvKOBaHSvw5PHm/eyu2bxAZsPUJRoT6Xr9UGXCBAVtG96RNK8Lv0+Fp/0O
 RpKZc6NJdcyhy3HXkEhWA0WwkWYUASgZ6Rtg7KU0Db/a3aDlhdQPPyy1Ls0+K0WHc+1J
 iQRw==
X-Gm-Message-State: AOJu0YwCqPvP1oSftMDOAW3hj3cIPgrBwRD1ZK41RuYeyWQD+pRkG/I9
 REOOcTuMSDde8EdJ1nedssR4yzuEndRrqxugPHQIylOVo6hqfCu9UbCJzEAJ1ClUJ94acb+SNWb
 USdwXZB3JA0cFb/DWpxdsbN/XXH00ww==
X-Gm-Gg: ASbGncvhPYPIfM4+NyZusMwzGFkaDcbNQFHOG4lV1QhNSqaS5K0wSzLc/0wWA1BekS6
 v0yTMW7FCat83bxiXjYYA4I3pPKVcTfP28kfKWf52HqGAPmktzBWz65ksLOQJOaNMe7OhnSSzVb
 gm5pNqhJtjZ6vpAMnf0J38WA==
X-Google-Smtp-Source: AGHT+IFV856WhfjQ1F6Q1gLVeIxLQurbyhLiTuahY3JM1sovc61mTvD1kkbfM+i8v8vwI6MTwJZqPlmHmCf9P3xdATA=
X-Received: by 2002:a17:90b:38cc:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-3087bb3f2c3mr8192268a91.2.1745326549426; Tue, 22 Apr 2025
 05:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250422021051.1377427-1-Yifan.Zha@amd.com>
In-Reply-To: <20250422021051.1377427-1-Yifan.Zha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Apr 2025 08:55:36 -0400
X-Gm-Features: ATxdqUF09wQZIw_Q3kMgDQdYxz6PJR13gKP_TZ21yW5Tik_VnxIovDmVjAZKDbE
Message-ID: <CADnq5_OgX-asNhCLEEZ2Sf9hvB37RE2Ht23GF-uNfH26=si7ZA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: refine MES register print for devices of hive
To: Yifan Zha <Yifan.Zha@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, christian.koenig@amd.com, 
 ZhenGuo.Yin@amd.com, haijun.chang@amd.com
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

On Mon, Apr 21, 2025 at 10:18=E2=80=AFPM Yifan Zha <Yifan.Zha@amd.com> wrot=
e:
>
> [Why]
> Register access print missed device info.
>
> [How]
> Using dev_xxx instead of DRM_xxx to indicate which device
> of a hive is the message for.
>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 72e5677cd545..aeabe3c52bb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -907,7 +907,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, =
uint32_t reg)
>         uint32_t *read_val_ptr;
>
>         if (amdgpu_device_wb_get(adev, &addr_offset)) {
> -               DRM_ERROR("critical bug! too many mes readers\n");
> +               dev_err(adev->dev, "critical bug! too many mes readers\n"=
);
>                 goto error;
>         }
>         read_val_gpu_addr =3D adev->wb.gpu_addr + (addr_offset * 4);
> @@ -917,13 +917,13 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev=
, uint32_t reg)
>         op_input.read_reg.buffer_addr =3D read_val_gpu_addr;
>
>         if (!adev->mes.funcs->misc_op) {
> -               DRM_ERROR("mes rreg is not supported!\n");
> +               dev_err(adev->dev, "mes rreg is not supported!\n");
>                 goto error;
>         }
>
>         r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
>         if (r)
> -               DRM_ERROR("failed to read reg (0x%x)\n", reg);
> +               dev_err(adev->dev, "failed to read reg (0x%x)\n", reg);
>         else
>                 val =3D *(read_val_ptr);
>
> @@ -944,14 +944,14 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
>         op_input.write_reg.reg_value =3D val;
>
>         if (!adev->mes.funcs->misc_op) {
> -               DRM_ERROR("mes wreg is not supported!\n");
> +               dev_err(adev->dev, "mes wreg is not supported!\n");
>                 r =3D -EINVAL;
>                 goto error;
>         }
>
>         r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
>         if (r)
> -               DRM_ERROR("failed to write reg (0x%x)\n", reg);
> +               dev_err(adev->dev, "failed to write reg (0x%x)\n", reg);
>
>  error:
>         return r;
> @@ -971,14 +971,14 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_dev=
ice *adev,
>         op_input.wrm_reg.mask =3D mask;
>
>         if (!adev->mes.funcs->misc_op) {
> -               DRM_ERROR("mes reg_write_reg_wait is not supported!\n");
> +               dev_err(adev->dev, "mes reg_write_reg_wait is not support=
ed!\n");
>                 r =3D -EINVAL;
>                 goto error;
>         }
>
>         r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
>         if (r)
> -               DRM_ERROR("failed to reg_write_reg_wait\n");
> +               dev_err(adev->dev, "failed to reg_write_reg_wait\n");
>
>  error:
>         return r;
> @@ -996,14 +996,14 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev,=
 uint32_t reg,
>         op_input.wrm_reg.mask =3D mask;
>
>         if (!adev->mes.funcs->misc_op) {
> -               DRM_ERROR("mes reg wait is not supported!\n");
> +               dev_err(adev->dev, "mes reg wait is not supported!\n");
>                 r =3D -EINVAL;
>                 goto error;
>         }
>
>         r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
>         if (r)
> -               DRM_ERROR("failed to reg_write_reg_wait\n");
> +               dev_err(adev->dev, "failed to reg_write_reg_wait\n");
>
>  error:
>         return r;
> --
> 2.25.1
>
