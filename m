Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C7EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 16:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8643510EDE2;
	Fri, 14 Jan 2022 16:59:30 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93C610EDE2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 16:59:29 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 b15-20020a4a9bcf000000b002dc83a61053so2736837ook.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 08:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5cThNBdmifX5fjZDzGTufhPtxnTPpDZseICZVG8X7bs=;
 b=isoSpKsCm5ZpGCuYkDFDYlrFvQYtQXCZuuZy6UaIX5BtkIJbr+RomSIGnDM/kit2Ai
 +gl/jIYFZEeiQSceyMBlnJ6RQ4Mp64RFyoS4iBGLhnT9hz3aOZYxerFetYCGPmh6aMgu
 igm3ybcvbapX0WK8IU4Jm3hChWoy8+tAEe5pKsf3JGsZmgmeJwWGqwlZTej0RdqSDwY6
 W7Jlc+hE1fs/EiSgooGaBhMTvz8LNuGEU2OMEz7IVSbeIIFTHcGETEVmZsCTO/dhUpqO
 k1bgujPLcKlp1UbEYg6yZOrTT++SFdq75rYRg/b2LYQztb+T/FlRgCBWcUHtgvi3mewx
 OunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5cThNBdmifX5fjZDzGTufhPtxnTPpDZseICZVG8X7bs=;
 b=L9vB3EasGurX/MEPx0zYMcmjGI6Mf+CNgb9cX3vpEZfyojlxp9Vc5sFDbQVegCXXxj
 dIKccrgmZ4KV2955hbeeZCDh1Xv0LtucE9Ktjx5F6j6NZJTNgmwZLXEXFea0toSMlfy/
 SLxxKyw7QCxMi4NdH3RlziwecYHUa3ED3u34FHV67ki0718YB2rqyUZ9Z8gS/SERtv59
 sHpNrqtxPFLRb/pi+T700oESroW+IwimQ1ysoBmEYIxx0ONeyaTzAOS+SygYGLM8uJ4P
 EkuZKobkn1hKOX55ZlvVu48hPja/gkLsBfOJtQ1NR13867Skw7xf6K8ypKUkpN373kWK
 wXfQ==
X-Gm-Message-State: AOAM533fzU7hH4gPh/5z4TsyzJhza3FUIk9hv/7Wf+0EgjCEvF5kWwUx
 4nF0E3uSekYidVPrPCRPBPugrODaKvGomnU0jos=
X-Google-Smtp-Source: ABdhPJx1EKV5ZyaOI+xQnYlcVar1DmmVP/sQhIT7xqxFIN2i0vw/QBqnfJhcERfytHKBoVlBPW9HKTR7RqT4VwLc61Q=
X-Received: by 2002:a4a:374c:: with SMTP id r73mr1470159oor.68.1642179568821; 
 Fri, 14 Jan 2022 08:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20220114092338.10004-1-Xiaojian.Du@amd.com>
In-Reply-To: <20220114092338.10004-1-Xiaojian.Du@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Jan 2022 11:59:17 -0500
Message-ID: <CADnq5_NFbvxS8xvHL+xtyeU+U8FooCeturG+BE3abJxxRwowuA@mail.gmail.com>
Subject: Re: [Patch v3] drm/amdgpu: add vram check function for GMC
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 14, 2022 at 4:24 AM Xiaojian Du <Xiaojian.Du@amd.com> wrote:
>
> This will add vram check function for GMC block.
> It will write pattern data to the vram and then read back from the vram,
> so that to verify the work status of vram.
> This patch  will cover gmc v6/7/8/9/10.
>
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 46 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  5 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  7 +++-
>  7 files changed, 70 insertions(+), 4 deletions(-)
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
> index 3915ba837596..41b11c1f8db0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1048,6 +1048,11 @@ static int gmc_v10_0_hw_init(void *handle)
>         if (r)
>                 return r;
>
> +       if (amdgpu_emu_mode == 1) {
> +               r = amdgpu_gmc_vram_checking(adev);
> +               if (r)
> +                       return r;
> +       }
>         if (adev->umc.funcs && adev->umc.funcs->init_registers)
>                 adev->umc.funcs->init_registers(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 0fe714f54cca..dec5539fe779 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -923,7 +923,10 @@ static int gmc_v6_0_hw_init(void *handle)
>         if (r)
>                 return r;
>
> -       return r;
> +       if (amdgpu_emu_mode == 1)
> +               return amdgpu_gmc_vram_checking(adev);
> +       else
> +               return r;
>  }
>
>  static int gmc_v6_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 0a50fdaced7e..b249aa9b3724 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1112,7 +1112,10 @@ static int gmc_v7_0_hw_init(void *handle)
>         if (r)
>                 return r;
>
> -       return r;
> +       if (amdgpu_emu_mode == 1)
> +               return amdgpu_gmc_vram_checking(adev);
> +       else
> +               return r;
>  }
>
>  static int gmc_v7_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 9a3fc0926903..78ce7828b348 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1241,7 +1241,10 @@ static int gmc_v8_0_hw_init(void *handle)
>         if (r)
>                 return r;
>
> -       return r;
> +       if (amdgpu_emu_mode == 1)
> +               return amdgpu_gmc_vram_checking(adev);
> +       else
> +               return r;
>  }
>
>  static int gmc_v8_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index ce7d438eeabe..ebbd212ed795 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1771,8 +1771,13 @@ static int gmc_v9_0_hw_init(void *handle)
>                 adev->umc.funcs->init_registers(adev);
>
>         r = gmc_v9_0_gart_enable(adev);
> +       if (r)
> +               return r;
>
> -       return r;
> +       if (amdgpu_emu_mode == 1)
> +               return amdgpu_gmc_vram_checking(adev);
> +       else
> +               return r;
>  }
>
>  /**
> --
> 2.25.1
>
