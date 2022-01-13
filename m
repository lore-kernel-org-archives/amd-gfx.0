Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E8BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 15:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C380A10E159;
	Thu, 13 Jan 2022 15:24:40 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A423910E180
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 15:24:39 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id y14so8087340oia.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 07:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qQUu7EQIX9fD0Znv7IO7cwAT83piUdjYuS2Y82dcwtA=;
 b=XqW3ORBfcuxOzS5Ba7xBDM+WNeY5JFbEPDTN7ETBy22EximQqlQMyk78l5rFICUzvK
 Iu0TVIY0J3bBcVIp7rB0oyhfGhlLE5wbO9YKZFkBuTjWtF796W928eNHuwkF2s/yffS9
 Mo68Cr2lLq2DOUiL7SRe9F2CJKQYlJy04VSz2kghAbE8dzO/8MErrXC+sqbOyXpEhZPb
 GfhAOdNYPIlZJ8cLZm6FjdvV8d5c5CGOCGls12Eqz9zaeOJW+DAm9ASNyn/nF4aSoA2m
 /HKSJPZkrAsIxwg+6c462Njihf69HUtvBySvQ9HU9tbZZDvE8z5UOZ5zDeqMW4XWfPPm
 VabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qQUu7EQIX9fD0Znv7IO7cwAT83piUdjYuS2Y82dcwtA=;
 b=FC6zyeEFPGwbBH9k8cO1TZcGhdKKifk74562igwUybJZ+tgmvo2rysDZjyK90P5taz
 yopqLy5dUn5zSONwzKMP5lCiSjM9bzfR6cyT2z5k9OAWwqBOoI/BkNTUDQv1VpTJbNra
 +FNRHS1bLO6lMhxw3eKJ6B0RY62g9+Et+b3BJqZBrZK8oBd+9flfMyttpeILQuUXPIAk
 mfgc02T+wGygKbsJ5ZgEze36FtEpo7X9rgj9COqyjsWJzhaCS/CL3o+CVElpM7b8PxSM
 wKo9jILa5WBQ+2X2K30j5bOeFTOjGB8vGUjbz8wTHdkhSeaw1LEhU+cg7XBhyZff87rs
 Kg7A==
X-Gm-Message-State: AOAM532SPwCDhxlA6x6Z7/S8F59f4DrDZPNH9VVpshVd9nWxnJSMNq9N
 c0+qWru9mxH3wmmXu7Qm6vAUUNiTJM5NS1eN+g9rSPGccXQ=
X-Google-Smtp-Source: ABdhPJwppqVx8Jw/ce0YQdsQadBg4l1MC1q0H3PJu52340SRCdK2jXcPR6XRM37vfAbiEWliHTqfP6rbuYraJ1bsllk=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr3495078oib.120.1642087478828; 
 Thu, 13 Jan 2022 07:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20220113095913.30962-1-Xiaojian.Du@amd.com>
In-Reply-To: <20220113095913.30962-1-Xiaojian.Du@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Jan 2022 10:24:27 -0500
Message-ID: <CADnq5_Ph1PpmZrnxTr6Rcj0RDZ4UZeFk97wB4NewPbC6O1aVAQ@mail.gmail.com>
Subject: Re: [Patch v2] drm/amdgpu: add vram check function for GMC
To: Xiaojian Du <Xiaojian.Du@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 13, 2022 at 5:00 AM Xiaojian Du <Xiaojian.Du@amd.com> wrote:
>
> This will add vram check function for GMC, it will cover gmc v6/7/8/9/10
>

Please provide a better description.

Also, we should either protect the calls to this function with:
if (amdgpu_emu_mode == 1)
or return early in the function if amdgpu_emu_mode != 1.

Alex

> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 46 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  4 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  6 +++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  6 +++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  6 +++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  8 ++++-
>  7 files changed, 73 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 83f26bca7dac..96cabf3ed29e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -833,3 +833,49 @@ void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
>                 break;
>         }
>  }
> +
> +int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_bo        *vram_bo;
> +       uint64_t        vram_gpu;
> +       void    *vram_ptr;
> +
> +       int ret, size = 0x100000;
> +       uint8_t cptr[10];
> +
> +       ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +                               AMDGPU_GEM_DOMAIN_VRAM,
> +                               &vram_bo,
> +                               &vram_gpu,
> +                               &vram_ptr);
> +       if (ret)
> +               return ret;
> +
> +       memset(vram_ptr, 0x86, size);
> +       memset(cptr, 0x86, 10);
> +
> +       /**
> +       * Check the start, the mid, and the end of the memory if the content of
> +       * each byte is the pattern "0x86". If yes, we suppose the vram bo is
> +       * workable.
> +       *
> +       * Note: If check the each byte of whole 1M bo, it will cost too many
> +       * seconds, so here, we just pick up three parts for emulation.
> +       */
> +       ret = memcmp(vram_ptr, cptr, 10);
> +       if (ret)
> +               return ret;
> +
> +       ret = memcmp(vram_ptr + (size / 2), cptr, 10);
> +       if (ret)
> +               return ret;
> +
> +       ret = memcmp(vram_ptr + size - 10, cptr, 10);
> +       if (ret)
> +               return ret;
> +
> +       amdgpu_bo_free_kernel(&vram_bo, &vram_gpu,
> +                       &vram_ptr);
> +
> +       return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 82ec665b366c..f06af61378ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -343,4 +343,5 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
>  uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
>  uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>  uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
> +int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 3915ba837596..5e407c88c8d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1048,6 +1048,10 @@ static int gmc_v10_0_hw_init(void *handle)
>         if (r)
>                 return r;
>
> +       r = amdgpu_gmc_vram_checking(adev);
> +       if (r)
> +               return r;
> +
>         if (adev->umc.funcs && adev->umc.funcs->init_registers)
>                 adev->umc.funcs->init_registers(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 0fe714f54cca..17770c1017ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -923,7 +923,11 @@ static int gmc_v6_0_hw_init(void *handle)
>         if (r)
>                 return r;
>
> -       return r;
> +       r = amdgpu_gmc_vram_checking(adev);
> +       if (r)
> +               return r;
> +
> +       return 0;
>  }
>
>  static int gmc_v6_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 0a50fdaced7e..fa43905ae61f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1112,7 +1112,11 @@ static int gmc_v7_0_hw_init(void *handle)
>         if (r)
>                 return r;
>
> -       return r;
> +       r = amdgpu_gmc_vram_checking(adev);
> +       if (r)
> +               return r;
> +
> +       return 0;
>  }
>
>  static int gmc_v7_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 9a3fc0926903..6c94a9712a3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1241,7 +1241,11 @@ static int gmc_v8_0_hw_init(void *handle)
>         if (r)
>                 return r;
>
> -       return r;
> +       r = amdgpu_gmc_vram_checking(adev);
> +       if (r)
> +               return r;
> +
> +       return 0;
>  }
>
>  static int gmc_v8_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index ce7d438eeabe..1ea18b4ff63f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1771,8 +1771,14 @@ static int gmc_v9_0_hw_init(void *handle)
>                 adev->umc.funcs->init_registers(adev);
>
>         r = gmc_v9_0_gart_enable(adev);
> +       if (r)
> +               return r;
>
> -       return r;
> +       r = amdgpu_gmc_vram_checking(adev);
> +       if (r)
> +               return r;
> +
> +       return 0;
>  }
>
>  /**
> --
> 2.25.1
>
