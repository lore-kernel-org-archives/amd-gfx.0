Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CD6CD4F4C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 00:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8579310E5DE;
	Thu,  5 Sep 2024 00:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GeX3pEKv";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C32E10E5DE
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 00:35:58 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-20549ca1fe3so170515ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Sep 2024 17:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725496558; x=1726101358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcG+IhqT91vvkqGACANJ8pa16Yt98bQwJX3LBwGlx/8=;
 b=GeX3pEKvRclMfhGb7L2nFK8Kot8UbPfXtWUYeLHwIl4DopmC9RqBKUt7roNvdjU+In
 OalpxU6QSr4zSzHG+neqRjuUQiQFMRnUXNpOfm2SGquFG0eLvEVTPL2XM0kMPRnqgCzS
 8m99RjeRhkOGaKAmT0cDp2l8M7JvQf7VGG35VB3s8OtaGiPG9pVje7fp6nK42r6RdkfQ
 +Bf/W+nalxIOOQ8rHqUGV/FcMBCjqqeScEESw8ZfJ3+l0azCYn0QC64ziB8vv7+Uk7/5
 7jKPaiTG69RyVOZpWbNwnO0FPx9mzznMiDpYmcLpwBZLh2H9PiEf7CsMVsS9gHfqB+4G
 tQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725496558; x=1726101358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcG+IhqT91vvkqGACANJ8pa16Yt98bQwJX3LBwGlx/8=;
 b=Q72gGYWTx5ZqUPMQLxYFI11Q5nb9TY76l+tg2P5xM/g4FhBP3JUtGBQV7j5tmCHxUR
 GBVKxgS3vj5Znj0dkm3IEYwSlcFsOlNrgGkXUW6kYQOfjEAoCQohXhbofKx+5b2e0E3n
 aNmDwlprSKuaDxcmlSnQ5j8zekkUQ/uqLEg84b/vkr0lPY0LVGl6YsdYzORS1waoWLc/
 neW/55v7Tdy6tlbLNeLd58nebmIq0R9BQfiG/1ltRSrxWVQbnsfJPeQb6LvaAt+chVeu
 n1cHtf8vvn8wb04pt+v5f+3jPHPQTnLDgPa/i1aN4+N3c2pW2MBjQIupEq/FoMfYBen0
 q8vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFt5dGa+gbyjRdPRt/BIhCVoGbQGyL89YMZ6DNqEao6Krf2A3N168Fl1kXZ7rcZGLI9bH7lxcw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAuVMcW5YTOGvOyuHK791fwaLh2nkm/tlLe9lsOht088RTeJC1
 FiaLgyvgqpniuepCGWNu6dRI/kBBssGgwcKbpocf74rdNYA/23y8ha331roIW04GARND7z6dtsJ
 omT7JxDZEVitiScDgvXDwpAm5CvAe7sFk
X-Google-Smtp-Source: AGHT+IFyzsV2sOX3uPS+SBvNZ8ZH9lR8fouqY59WeghnFJUPTT/5XfldtvlNuJxNbgHv7dt64YzOpc6Zl9LlNbuFuDY=
X-Received: by 2002:a17:903:2444:b0:206:99a2:b058 with SMTP id
 d9443c01a7336-20699a2b2c5mr44499225ad.5.1725496557693; Wed, 04 Sep 2024
 17:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240904132729.1948224-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240904132729.1948224-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Sep 2024 20:35:45 -0400
Message-ID: <CADnq5_PzoFxL7Vvg8uwOAdaDRDQuToe19c_Q7CQsz42ac1o4VA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Refactor cleaner shader initialization in
 amdgpu
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Sep 4, 2024 at 9:27=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit refactors the cleaner shader initialization process. The
> changes remove unnecessary checks for adev->gfx.enable_cleaner_shader in
> the amdgpu_gfx_cleaner_shader_sw_init,
> amdgpu_gfx_cleaner_shader_sw_fini, and amdgpu_gfx_cleaner_shader_init
> functions. These checks are now performed before these functions are
> called, which simplifies the functions and makes the control flow of the
> program clearer.
>
> Additionally, the cleaner_shader_size and cleaner_shader_ptr parameters
> have been removed from the amdgpu_gfx_cleaner_shader_sw_init and
> amdgpu_gfx_cleaner_shader_init functions. These values are now obtained
> directly from the adev->gfx structure inside the functions.
>
> Fixes: 63063b6c5a8d ("drm/amdgpu: Add infrastructure for Cleaner Shader f=
eature")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 21 ++++++---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  7 ++-----
>  2 files changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 83e54697f0ee..9891114ae6d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1655,13 +1655,10 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struc=
t amdgpu_device *adev)
>         device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
>  }
>
> -int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
> -                                     unsigned int cleaner_shader_size)
> +int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev)
>  {
> -       if (!adev->gfx.enable_cleaner_shader)
> -               return -EOPNOTSUPP;
>
> -       return amdgpu_bo_create_kernel(adev, cleaner_shader_size, PAGE_SI=
ZE,
> +       return amdgpu_bo_create_kernel(adev, adev->gfx.cleaner_shader_siz=
e, PAGE_SIZE,
>                                        AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GE=
M_DOMAIN_GTT,
>                                        &adev->gfx.cleaner_shader_obj,
>                                        &adev->gfx.cleaner_shader_gpu_addr=
,
> @@ -1670,24 +1667,18 @@ int amdgpu_gfx_cleaner_shader_sw_init(struct amdg=
pu_device *adev,
>
>  void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev)
>  {
> -       if (!adev->gfx.enable_cleaner_shader)
> -               return;
>
>         amdgpu_bo_free_kernel(&adev->gfx.cleaner_shader_obj,
>                               &adev->gfx.cleaner_shader_gpu_addr,
>                               (void **)&adev->gfx.cleaner_shader_cpu_ptr)=
;
>  }
>
> -void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
> -                                   unsigned int cleaner_shader_size,
> -                                   const void *cleaner_shader_ptr)
> +void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev)
>  {
> -       if (!adev->gfx.enable_cleaner_shader)
> -               return;
>
> -       if (adev->gfx.cleaner_shader_cpu_ptr && cleaner_shader_ptr)
> -               memcpy_toio(adev->gfx.cleaner_shader_cpu_ptr, cleaner_sha=
der_ptr,
> -                           cleaner_shader_size);
> +       if (adev->gfx.cleaner_shader_cpu_ptr && adev->gfx.cleaner_shader_=
ptr)

This is confusing.  Two cpu pointers with pretty much the same name.

Alex

> +               memcpy_toio(adev->gfx.cleaner_shader_cpu_ptr, adev->gfx.c=
leaner_shader_ptr,
> +                           adev->gfx.cleaner_shader_size);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 5644e10a86a9..07bd27c066c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -573,12 +573,9 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device =
*adev,
>                 void *ras_error_status,
>                 void (*func)(struct amdgpu_device *adev, void *ras_error_=
status,
>                                 int xcc_id));
> -int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
> -                                     unsigned int cleaner_shader_size);
> +int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev);
>  void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
> -void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
> -                                   unsigned int cleaner_shader_size,
> -                                   const void *cleaner_shader_ptr);
> +void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev);
>  int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
>  void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
>  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
> --
> 2.34.1
>
