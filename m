Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B42BD609B7
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 16:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B5B10E711;
	Tue, 16 Dec 2025 16:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nIT8SVP7";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE1910E711
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 16:15:18 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7b8c7a4f214so323181b3a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 08:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765901718; x=1766506518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAIUG/wDiy6PShiXl/tHvJN4DX8edE8G4RDHZHRb34s=;
 b=nIT8SVP7gOlt1wXcByeiEZ9GY33LftfB83iMMLyyUFvBQXCBMRr1Wr7D6EQM9FwvBT
 en9OCz5FRP3q5C9aYzJqK4GNadX4wFJ/pUR/KLt7h0qTlAIQr0lar+7yJ6i4zTZiP+XF
 1dz3JSR78pLza1zEnWJ9YBokc80xDYEMyDPxx00kxX+2Ee7gfKkNFkPqpGinOfnzUKI5
 ZFwCBSqb4BjiOGJkxBQuy/v9O7gWuJf40WE30FOurPJgGLcbdJlV281Lssd50d9cRSVN
 jHBDL5qWR9W5OSfm/7TkX9Frf/FJoIxNowE4LydcHQjTDVK3MozzaUFqpBrC4ixCaive
 YrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765901718; x=1766506518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gAIUG/wDiy6PShiXl/tHvJN4DX8edE8G4RDHZHRb34s=;
 b=fbwmid6JENDwiRZb4uVQZww9Qi5NpnimOby2BuhqSrA1AwXoMnqIiEeWynFl8IxKbR
 GszK+Gya8C/hkNvXRWn0tbk+LrJFQTndPOkJ0kyTNMP82DP1/Pn10tz1aVlNqyL0+1ow
 A0sGCIwlUzMEf4vaifQ7reF5gtG6i9Cm6WGtLaawTREgT66yhQm5WsdANsygcqyWVAe5
 ZuYgrVNxrte9tU+jDTXls6yypej21sf6t6V57vFQ3/7Al3ZFqpZwrxek7E3IZVrGYodV
 J7ROo18VO18Pg2DIWJEyk/+0MB/TZi5P9L1RonClNBMMNkSRv+pjwwX8IGYDHRLL3ym3
 X6NA==
X-Gm-Message-State: AOJu0Yyhw2YRfyofF9JvbqxjxdBD/nxqcouGtoHwAjl237Af+TKC2/QL
 kc/1ZkOMlJVL4atVocx8YUUc/JZ0z6hM0L8nZ3CSzkHUa5XLLhGiivJoBJIDizKMdEpQj0P33qJ
 R2BPU1tqunvYwpu8UqVZHXOSlH52iy/g=
X-Gm-Gg: AY/fxX4j2nIK7BgMUtduCl8JsNnWtSvKUzLgJOsiqKF1mGFwHkiOYtvoTgniprwt4rA
 eQOUImFkhJXp5IiAsCxmEofQxBGmheARo+W7cU4SYNYnShQc0v4FkOqqcwj88gFwbSdjXZZqaqn
 46KXbAO70FHb529NSoXHTDswh62Dz/lvmatyIs0UmnDAE3S4748KXncVxgOo5Oc/ASr1dzDHfv1
 goan9N5A9JcUXo4gQUeK0/fPOcYL8OZKXgaYoSb2a/lIJ8q66IY9u49DD4zNHJbzbnG9hJSyOQx
 n+o3j24=
X-Google-Smtp-Source: AGHT+IGuKV+T/cG34af8duJPiu9oVe716UZPwzNebwqPNWkNZZg15nct991E9NOSn6FVZ0VkeYAnBdY3WwtFFdYxJhs=
X-Received: by 2002:a05:7022:6087:b0:119:e55a:95a3 with SMTP id
 a92af1059eb24-11f34c51c3dmr6164663c88.5.1765901717013; Tue, 16 Dec 2025
 08:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-5-lijo.lazar@amd.com>
In-Reply-To: <20251203130436.745633-5-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 11:15:05 -0500
X-Gm-Features: AQt7F2p2LOTImVHmK6yTd2bGVufcyqPcFmzc7tft0V4MuiNvS7bJsl0bNLvpMDM
Message-ID: <CADnq5_MbAt5qvLi2jVt1+ngUcrY7zE2gvPRRCwD073SQDUCHTg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/10] drm/amdgpu: Add user save area params
 validation
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Wed, Dec 3, 2025 at 8:05=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add an interface to validate user provided save area parameters. Address
> validation is not done and expected to be done outside.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 44 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h | 11 ++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.c
> index 4252c31eac4c..1b4483b5d5a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -63,6 +63,15 @@ static inline bool amdgpu_cwsr_is_supported(struct amd=
gpu_device *adev)
>         return true;
>  }
>
> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc=
)
> +{
> +       if (!amdgpu_cwsr_is_enabled(adev))
> +               return 0;
> +
> +       return num_xcc *
> +              (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_m=
em_sz);
> +}
> +
>  static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
>                                          struct amdgpu_cwsr_info *cwsr_in=
fo)
>  {
> @@ -406,6 +415,41 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>         return r;
>  }
>
> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> +                               struct amdgpu_cwsr_params *cwsr_params,
> +                               int num_xcc)
> +{
> +       struct amdgpu_cwsr_info *cwsr_info =3D adev->cwsr_info;
> +
> +       if (!amdgpu_cwsr_is_enabled(adev))
> +               return -EOPNOTSUPP;
> +
> +       if (!cwsr_params)
> +               return -EINVAL;
> +
> +       /*
> +        * Only control stack and save area size details checked. Address=
 validation needs to be
> +        * carried out separately.
> +        */
> +       if (cwsr_params->ctl_stack_sz !=3D
> +           (cwsr_info->xcc_ctl_stack_sz * num_xcc)) {

I think it should be ok if the size is greater than expected.

Alex

> +               dev_dbg(adev->dev,
> +                       "queue ctl stack size 0x%x not equal to node ctl =
stack size 0x%x\n",
> +                       cwsr_params->ctl_stack_sz,
> +                       num_xcc * cwsr_info->xcc_ctl_stack_sz);
> +               return -EINVAL;
> +       }
> +
> +       if (cwsr_params->cwsr_sz !=3D (cwsr_info->xcc_cwsr_sz * num_xcc))=
 {
> +               dev_dbg(adev->dev,
> +                       "queue cwsr size 0x%x not equal to node cwsr size=
 0x%x\n",
> +                       cwsr_params->cwsr_sz, num_xcc * cwsr_info->xcc_cw=
sr_sz);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                       struct amdgpu_cwsr_trap_obj **trap_obj)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.h
> index 3c80d057bbed..96b03a8ed99b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -56,6 +56,13 @@ struct amdgpu_cwsr_info {
>         uint32_t xcc_cwsr_sz;
>  };
>
> +struct amdgpu_cwsr_params {
> +       uint64_t ctx_save_area_address;
> +       /* cwsr size info */
> +       uint32_t ctl_stack_sz;
> +       uint32_t cwsr_sz;
> +};
> +
>  int amdgpu_cwsr_init(struct amdgpu_device *adev);
>  void amdgpu_cwsr_fini(struct amdgpu_device *adev);
>
> @@ -68,4 +75,8 @@ static inline bool amdgpu_cwsr_is_enabled(struct amdgpu=
_device *adev)
>         return adev->cwsr_info !=3D NULL;
>  }
>
> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc=
);
> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> +                               struct amdgpu_cwsr_params *cwsr_params,
> +                               int num_xcc);
>  #endif
> --
> 2.49.0
>
