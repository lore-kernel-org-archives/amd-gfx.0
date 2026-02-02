Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA937E7FDDC
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 21:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377FF10E065;
	Mon,  2 Feb 2026 21:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="duwuHiUT";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B08310E065
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 21:10:02 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-124a5810e41so120296c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 13:10:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770066601; cv=none;
 d=google.com; s=arc-20240605;
 b=K1jVqRtCtjD0xxSXXGZikle5r0oGc6Mw4QxjMdxxiIrRXB793+aZbXi1lmw8hu42Ua
 PJiOAqhsb0M/lnXmHJJmTdsg2gtPxpAbqgUFbEPSvAZKlDzSkLZ7OKnPnsa3Mkw/tNSQ
 J62XgITnKjd7KXPCPewRqhMkJXrbhvzwQWwVhqvOoPDd711bmwa4ogSff4LLOCgBzDmG
 B+OhhmhuTnZEJvTmiQKnFNi/GxwHs6gEFqX+KRFnBTqvWzqSr58gbZsVL0puO+f7YUnt
 oJshYe9LYz51yUNkZK9Fgu9EH6ACT1bW+6s4LV4MsdFBYsTSGU0wgT7OdoIH0tRKSIJq
 RwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DC+AytD6Y0jY/e+hFgv6dtGPrdpgHD6MSL2d020Y+yg=;
 fh=jrj2zacaXiuElwmT/59HCjZUVEPuL3U3OF0ylmi9raM=;
 b=a51BfQBhJVJGdyKSMq0GY1fl3gvZpdAKqepwyam6YhltLltQClRGuU6ORjH7Gxo9Tc
 Yh595VfD+2U4GpjexWHjIc7aAQBL4peLWcTZNiBW1l66aYAFa/IZnw+M13ybloJYKm2v
 ggWyFMN6Ma2IEIoH5JphPI8rwejuP2d4tDWBHuJYo18hD6mrPjDwZ7BLW9FBUIsiw1OU
 KK8Wha03sm68HWcUI6q4OsaHoTnd/CPgl8AY+/RmDv0x0/kyprfRl8flpvyee1WL0Ipy
 W6PGaJwU7vCaZKRudf+So1sMt1dZkkLC7tlSRadC170KwBaqsUAT80SXW9rdtRSSZZMd
 DJlw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770066601; x=1770671401; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DC+AytD6Y0jY/e+hFgv6dtGPrdpgHD6MSL2d020Y+yg=;
 b=duwuHiUTNn0eDg38KuY0VuLWIezRJtQCSwkrXLPLX2I3Vj1EJ+kf2iUiB9XhtCNcUu
 OY+0be7ouxeYFpa1mwSxXnu3axVDSo3NdJLypn5kkbSeud1XIkkSV+n3tkKg2/VmsQGv
 kc4jhqY7I6rmIO6s2zS1w60PXIYE/ZqkUwIraLU4RAY5elIINSyyZhsV26F/xMr1GPZC
 gX4B29fBfc1RJVoaAKWUynukE45MmZfYLs1aboSXRKXh+k1/PEjako2ZdU5KQFZbOPQX
 ZQJ6AS5XsKY8g98yUjg3UaVXEt4lYwKEY0aH02e/4s0RewWhsPFFXV+RM9ngU4XvlJgi
 bz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066601; x=1770671401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DC+AytD6Y0jY/e+hFgv6dtGPrdpgHD6MSL2d020Y+yg=;
 b=AzRAlgqlBWxRhZpuZ2fZpdq4SSEaIT0FfvUQo1z4ioZN3NwKYP0ZpwiNWCgejmLzL9
 8V5ysjiSR0NldxAOlPC2yVH4fw8Vh2Av5DYUCy9AbMuvwnUN4k4NAnHh9h3HsJfxtZe7
 iFqnoOhdRBO9TQjUDlx9/6Ffjmip2ser4ve712sjyutQzYGa2h8v/vP/5xvxz2F+yHEj
 1LUxvHMldN8VIUE9vsCyu8giPMDbhCRomHURyJb11MJNWwaSnRkZGpAf5Zw1jaby2omq
 Big6RSSKmfTkOLOuCAx7pdJKs+jldih8vxZjQL9guunogmxdYcCu/jVbPWjcUeFH12AG
 phZA==
X-Gm-Message-State: AOJu0YxDddLNmOunefiLkUOgexNkJrjuMTShM8edgRV6HUC3EIw9nARA
 gYkBmGBqUSofaJOw6AMF63ZuFgfWvvDXGrrj4cZHSx7TrgrcN24qbbn/JVTJirtNbcFnAi7HZ91
 sI8o+uk2KJHmMwdahzke9eVixMLwceCQ=
X-Gm-Gg: AZuq6aKiA1Khg3PmZ5Ki2GytrA19Rl/nHokdeDN27pcHMPutRgfDRgMQGwiJniSVL0Q
 49Vd1QmYEFHJiYx2wGDBjvSvY6MmB/VIKJq1+HLsd9dT8xiPxWLFNxVYPun9OI8DNHPeV+K1EOF
 67VXDOQl3xBTPQPgi1gLZh9gCHHQZLAdNrpsFO/31c3R/AZcBbowi9lsyGlC7q6Zl8K4WDNY+ms
 0VYGa5wYlZTMPN3Rn2Q43P54QPYwNp07M6CbnclrlzuqvO945aFl5LXBBO6s2tNsRnWE2o+dh2F
 eCUaMjE=
X-Received: by 2002:a05:7022:fa07:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-125c0fa8ff1mr3390823c88.1.1770066601259; Mon, 02 Feb 2026
 13:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
 <20260130084137.2906792-5-lijo.lazar@amd.com>
In-Reply-To: <20260130084137.2906792-5-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 16:09:49 -0500
X-Gm-Features: AZwV_QjVwnn2cFLYXxAIchUlO7eTfaFlvEPNNIVOdwrSFqtRFwWRj4_tCdogTeE
Message-ID: <CADnq5_N9igO2yAtnuRHe82di4xfO5QE-oa3s3cTqumNxO+s3kw@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] drm/amdgpu: Add user save area params validation
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.YatSin@amd.com, 
 Lancelot.Six@amd.com, jonathan.kim@amd.com, Jesse.Zhang@amd.com
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

On Fri, Jan 30, 2026 at 4:22=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add an interface to validate user provided save area parameters. Address
> validation is not done and expected to be done outside.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 39 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h | 10 ++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.c
> index 80020fd33ce6..f4907172ebeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -64,6 +64,15 @@ static inline bool amdgpu_cwsr_is_supported(struct amd=
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
> @@ -425,6 +434,36 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>         return r;
>  }
>
> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> +                               struct amdgpu_cwsr_params *cwsr_params,
> +                               int num_xcc)
> +{
> +       uint32_t min_size, max_size;
> +
> +       if (!amdgpu_cwsr_is_enabled(adev))
> +               return -EOPNOTSUPP;
> +
> +       if (!cwsr_params)
> +               return -EINVAL;
> +
> +       min_size =3D amdgpu_cwsr_size_needed(adev, num_xcc);
> +       max_size =3D 2 * min_size;
> +       /*
> +        * Only save area size details checked. Address validation needs =
to be
> +        * carried out separately. User is expected to pass a cwsr buffer=
 area
> +        * with size >=3D ctl stack size + wg data size + debug memory si=
ze
> +        */
> +       if (cwsr_params->cwsr_sz < min_size ||
> +           cwsr_params->cwsr_sz > max_size) {
> +               dev_dbg(adev->dev,
> +                       "queue cwsr size 0x%x should be within min %u : m=
ax %u\n",
> +                       cwsr_params->cwsr_sz, min_size, max_size);
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
> index 3c80d057bbed..7f922559e297 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -56,6 +56,12 @@ struct amdgpu_cwsr_info {
>         uint32_t xcc_cwsr_sz;
>  };
>
> +struct amdgpu_cwsr_params {
> +       uint64_t ctx_save_area_address;
> +       /* cwsr size info */
> +       uint32_t cwsr_sz;
> +};
> +
>  int amdgpu_cwsr_init(struct amdgpu_device *adev);
>  void amdgpu_cwsr_fini(struct amdgpu_device *adev);
>
> @@ -68,4 +74,8 @@ static inline bool amdgpu_cwsr_is_enabled(struct amdgpu=
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
