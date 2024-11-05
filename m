Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21069D2B92E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B7710E5B9;
	Tue,  5 Nov 2024 14:30:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iW17JkUn";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE99110E5B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:30:40 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2e2da8529e1so496431a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2024 06:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730817040; x=1731421840; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYykljY8CxALvJR9rVt1BFCMtVAEoI5jiYkvmE58Bqc=;
 b=iW17JkUnqx/pJfZdJr+a133oQ7yrenozzfvGnTJ5kAA1zKopOd3/PunannC3rtyXyO
 qAYb0+7iibZe1s2QNayi5UOw/NJ3sHjhANlOjDmqXkE10H3Qml6Tv/9cc7oP0VdpmYTW
 jPwR4+r2NAZczpWS28pRL5R2M6VnWFlk63V5DooT8FzJ95VFDwFnr6WBPDFsO2959jwP
 gyYAYY+P/hm7z/XtWimmzuojtD7iSym3DjN4Z/dqxIkNsI6CDAQ6/QtChNmRiJg3dJdE
 4WYXsyPpIXre1mXQQ9I7q0JXPBW4Rt35+jkbhnw4PkGfidtVZ0dJcsenECJ/Nl4OzyEd
 5SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730817040; x=1731421840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYykljY8CxALvJR9rVt1BFCMtVAEoI5jiYkvmE58Bqc=;
 b=cE7qwc0T8fZAbG1kiRX9CiNZDwkaz4X9wWMM6vh3ElUCHNlQ8O5OY0slv+9ai4tfJ+
 +Zea9rwOo5Uw9DENYwit5a0qZOV/u+U/4cS3PqmOmY0N6/1VoojV1YnEnRNl4CLAXgD+
 UAh6Nlrs2B7Yrv5vL5Yycn7k0ytSTbR9eLJheBTUMBnw4ARSsTTJI2nPL1cMFoE7DETx
 5KoblzDWjyK5ivmUqujbXcg53KNLbH0CFde7iy6SffXSdgOgBPwBwp74J2k1/u02F8O3
 /HcJflOhqswPAHxbQT8fZALncqdk4c2i+xwF44HBVYF4WUN2Y5P/0ns5cPpbkGh4d7sx
 waOg==
X-Gm-Message-State: AOJu0YwhzIeQJo705/qxt/Jj8FLc20asSYLQSHzRqVHkXUl7JXxlwgwo
 YTXQg6vnGJFginLp45m6Ulgjh/9kYIbNh855zqDoDvbPdWqqlfA4xXARbJY2Cl7ReazYgO7Cg8w
 awMt4itAHngtGEA6Dku1aeI7sGlQ=
X-Google-Smtp-Source: AGHT+IH+AfsDCqLvLHO0U70kgfAuMa8BsTSr7OfVxc13fRvIJlGZuQDBTKaDmW6Cf8ZwmvFZhqqfge51OvDbMnsJB2I=
X-Received: by 2002:a17:90a:4bc5:b0:2e2:c04b:da94 with SMTP id
 98e67ed59e1d1-2e8f11a71b2mr17655765a91.5.1730817037996; Tue, 05 Nov 2024
 06:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20241105092454.40017-1-chongli2@amd.com>
In-Reply-To: <20241105092454.40017-1-chongli2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Nov 2024 09:30:26 -0500
Message-ID: <CADnq5_NDkN3yWYAkrsJSc4Q22K_=6HuR+aFpcq2b5oiq-xw9kA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix return random value when multiple threads
 read registers via mes.
To: Chong Li <chongli2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 Emily.Deng@amd.com, lincao12@amd.com, dandjelk@amd.com, zhengyin@amd.com
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

On Tue, Nov 5, 2024 at 4:39=E2=80=AFAM Chong Li <chongli2@amd.com> wrote:
>
> The currect code use the address "adev->mes.read_val_ptr" to
> store the value read from register via mes.
> So when multiple threads read register,
> multiple threads have to share the one address,
> and overwrite the value each other.
>
> Assign an address by "amdgpu_device_wb_get" to store register value.
> each thread will has an address to store register value.
>
> Signed-off-by: Chong Li <chongli2@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 30 +++++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ---
>  2 files changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 83d0f731fb65..a8f7173b2663 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -189,17 +189,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                         (uint64_t *)&adev->wb.wb[adev->mes.query_status_f=
ence_offs[i]];
>         }
>
> -       r =3D amdgpu_device_wb_get(adev, &adev->mes.read_val_offs);
> -       if (r) {
> -               dev_err(adev->dev,
> -                       "(%d) read_val_offs alloc failed\n", r);
> -               goto error;
> -       }
> -       adev->mes.read_val_gpu_addr =3D
> -               adev->wb.gpu_addr + (adev->mes.read_val_offs * 4);
> -       adev->mes.read_val_ptr =3D
> -               (uint32_t *)&adev->wb.wb[adev->mes.read_val_offs];
> -
>         r =3D amdgpu_mes_doorbell_init(adev);
>         if (r)
>                 goto error;
> @@ -220,8 +209,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                         amdgpu_device_wb_free(adev,
>                                       adev->mes.query_status_fence_offs[i=
]);
>         }
> -       if (adev->mes.read_val_ptr)
> -               amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
>
>         idr_destroy(&adev->mes.pasid_idr);
>         idr_destroy(&adev->mes.gang_id_idr);
> @@ -246,8 +233,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>                         amdgpu_device_wb_free(adev,
>                                       adev->mes.query_status_fence_offs[i=
]);
>         }
> -       if (adev->mes.read_val_ptr)
> -               amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
>
>         amdgpu_mes_doorbell_free(adev);
>
> @@ -918,10 +903,19 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev=
, uint32_t reg)
>  {
>         struct mes_misc_op_input op_input;
>         int r, val =3D 0;
> +       uint32_t addr_offset =3D 0;
> +       uint64_t read_val_gpu_addr;
> +       uint32_t *read_val_ptr;
>
> +       if (amdgpu_device_wb_get(adev, &addr_offset)) {
> +               DRM_ERROR("critical bug! too many mes readers\n");
> +               goto error;
> +       }
> +       read_val_gpu_addr =3D adev->wb.gpu_addr + (addr_offset * 4);
> +       read_val_ptr =3D (uint32_t *)&adev->wb.wb[addr_offset];
>         op_input.op =3D MES_MISC_OP_READ_REG;
>         op_input.read_reg.reg_offset =3D reg;
> -       op_input.read_reg.buffer_addr =3D adev->mes.read_val_gpu_addr;
> +       op_input.read_reg.buffer_addr =3D read_val_gpu_addr;
>
>         if (!adev->mes.funcs->misc_op) {
>                 DRM_ERROR("mes rreg is not supported!\n");
> @@ -932,9 +926,11 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev,=
 uint32_t reg)
>         if (r)
>                 DRM_ERROR("failed to read reg (0x%x)\n", reg);
>         else
> -               val =3D *(adev->mes.read_val_ptr);
> +               val =3D *(read_val_ptr);
>
>  error:
> +       if (addr_offset)
> +               amdgpu_device_wb_free(adev, addr_offset);
>         return val;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 45e3508f0f8e..83f45bb48427 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -119,9 +119,6 @@ struct amdgpu_mes {
>         uint32_t                        query_status_fence_offs[AMDGPU_MA=
X_MES_PIPES];
>         uint64_t                        query_status_fence_gpu_addr[AMDGP=
U_MAX_MES_PIPES];
>         uint64_t                        *query_status_fence_ptr[AMDGPU_MA=
X_MES_PIPES];
> -       uint32_t                        read_val_offs;
> -       uint64_t                        read_val_gpu_addr;
> -       uint32_t                        *read_val_ptr;
>
>         uint32_t                        saved_flags;
>
> --
> 2.34.1
>
