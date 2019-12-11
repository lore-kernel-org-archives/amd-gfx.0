Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC51C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09951206A5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWqVCM+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09951206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B156EB8B;
	Wed, 11 Dec 2019 20:41:50 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560166EB8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 20:41:49 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id d16so111409wre.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 12:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h9UxdK4fmi6JhMpxgtd+0dxrSPW6I3Mu9/IDf/4YyeQ=;
 b=DWqVCM+NzUAdbCqUzuRbPsfJ0PJPYW7NVYLMI/iGU685vXI1WuiE4HXmMNjtn+J3XP
 AeZzA8mwIpaLjBqWU/Bae73z2R3miv9ITWmiUAAs/jap13s4oGzomG32try3fdSvN5Pj
 B7EiJOu8WKaO0cYx1RazPTxPleKkogeYfxz/ZUY/HYvH3H0E+w+4KPR76Ne2QrfJpGIO
 zv2EMfqlQa9KC6go74YZekshFzXGJlb/owEAXWf09vP4rT/iAGeaHieU9F3gHhQdl+U+
 sHO4a+h7QMpzPf3PT3swbX+Fsk+VmejaVOWN3wFjKicsnbSpGfkAOYARU1LPcVV9dgiJ
 tSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h9UxdK4fmi6JhMpxgtd+0dxrSPW6I3Mu9/IDf/4YyeQ=;
 b=JRuvmRV0h395bY12/q4qddxaZ4YhrjxQNA25AvVuwY5aKTq7STKYqhGFBLCn14SY4a
 7cPt+pSNlC6Mg8bKM7Qlw+PgleJWsRQl0om/kY+NY97gwXBT5AA0UHuoV8tbbPdz/F00
 9ti0d/o5Uc+w92crOZtEt6uUk0bNPfb2313lHRbZY6+UQOlgbfT80Be1ocodyety3k03
 cPoBLcKK1cjPNcJOrWq6ejGf3myh7Ufi8MqGj8IV+F/QN9ridFIvpwLcZTu7ZEARpkEa
 Oq5GI/Zt8ZpcpO236MV0GsIf8OWfYRRv+Y/xqx5K2lPGMGmcq3713moS853d6GtK26HV
 um8g==
X-Gm-Message-State: APjAAAW0WpiKQ7j8dHKIpwOQkVzf6IjvfkHZgX7bxnE9j4AmSUQ8/thc
 B6c+Uv4crBlKMPdMRk2AtDFZpoJ09tybdiP98BA=
X-Google-Smtp-Source: APXvYqxE8+88GgwGSkXsgjvQC6zsJyEpAbagXLFKBWqy7fG0BoYyRi5+ytcZx9phO6QnBhlQLf5ch/7BSv2dUY7Id6I=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr1899489wru.40.1576096907309; 
 Wed, 11 Dec 2019 12:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20191211202542.637-1-Yong.Zhao@amd.com>
In-Reply-To: <20191211202542.637-1-Yong.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Dec 2019 15:41:35 -0500
Message-ID: <CADnq5_OmV8BuAuijC3r7NP=+D=a4NjOr8564ZHyugRpLnDSOVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add CU info print log
To: Yong Zhao <Yong.Zhao@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 11, 2019 at 3:26 PM Yong Zhao <Yong.Zhao@amd.com> wrote:
>
> The log will be useful for easily getting the CU info on various
> emulation models or ASICs.
>

You can probably just put this all in once place at the end of init
rather than sprinkling the print statements across all the IP modules.
Also, can we make it debug only?  Our driver is already pretty chatty.

Alex

> Change-Id: Ic1c914938aa3445d8dbfdf6a237bc1d58b0d5267
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 2 ++
>  7 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8992506541d8..df9732510012 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1529,6 +1529,12 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>                 adev->gfx.config.max_shader_engines = le32_to_cpu(gpu_info_fw->gc_num_se);
>                 adev->gfx.config.max_cu_per_sh = le32_to_cpu(gpu_info_fw->gc_num_cu_per_sh);
>                 adev->gfx.config.max_sh_per_se = le32_to_cpu(gpu_info_fw->gc_num_sh_per_se);
> +
> +               DRM_INFO("gpu_info: SE %d, SH per SE %d, CU per SH %d\n",
> +                               adev->gfx.config.max_shader_engines,
> +                               adev->gfx.config.max_sh_per_se,
> +                               adev->gfx.config.max_cu_per_sh);
> +
>                 adev->gfx.config.max_backends_per_se = le32_to_cpu(gpu_info_fw->gc_num_rb_per_se);
>                 adev->gfx.config.max_texture_channel_caches =
>                         le32_to_cpu(gpu_info_fw->gc_num_tccs);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index f95092741c38..8001a067700c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -388,6 +388,12 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
>         adev->gfx.config.max_cu_per_sh = 2 * (le32_to_cpu(gc_info->gc_num_wgp0_per_sa) +
>                                               le32_to_cpu(gc_info->gc_num_wgp1_per_sa));
>         adev->gfx.config.max_sh_per_se = le32_to_cpu(gc_info->gc_num_sa_per_se);
> +
> +       DRM_INFO("discovery: SE %d, SH per SE %d, CU per SH %d\n",
> +                       adev->gfx.config.max_shader_engines,
> +                       adev->gfx.config.max_sh_per_se,
> +                       adev->gfx.config.max_cu_per_sh);
> +
>         adev->gfx.config.max_backends_per_se = le32_to_cpu(gc_info->gc_num_rb_per_se);
>         adev->gfx.config.max_texture_channel_caches = le32_to_cpu(gc_info->gc_num_gl2c);
>         adev->gfx.config.max_gprs = le32_to_cpu(gc_info->gc_num_gprs);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 8cdef79de9d4..a26892e71680 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5432,6 +5432,8 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
>         cu_info->ao_cu_mask = ao_cu_mask;
>         cu_info->simd_per_cu = NUM_SIMD_PER_CU;
>
> +       DRM_INFO("active_cu_number: %d\n", cu_info->number);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 95bb2422b27c..bb05a94690d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -3620,6 +3620,8 @@ static void gfx_v6_0_get_cu_info(struct amdgpu_device *adev)
>
>         cu_info->number = active_cu_number;
>         cu_info->ao_cu_mask = ao_cu_mask;
> +
> +       DRM_INFO("active_cu_number: %d\n", cu_info->number);
>  }
>
>  const struct amdgpu_ip_block_version gfx_v6_0_ip_block =
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 648d767d14e7..6d16216d5c7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -5159,6 +5159,8 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
>         cu_info->max_scratch_slots_per_cu = 32;
>         cu_info->wave_front_size = 64;
>         cu_info->lds_size = 64;
> +
> +       DRM_INFO("active_cu_number: %d\n", cu_info->number);
>  }
>
>  const struct amdgpu_ip_block_version gfx_v7_0_ip_block =
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 8b9f440688ed..1073eb5c3cec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -7141,6 +7141,8 @@ static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev)
>         cu_info->max_scratch_slots_per_cu = 32;
>         cu_info->wave_front_size = 64;
>         cu_info->lds_size = 64;
> +
> +       DRM_INFO("active_cu_number: %d\n", cu_info->number);
>  }
>
>  const struct amdgpu_ip_block_version gfx_v8_0_ip_block =
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 147c08fb5531..e9d55ab33da7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -6562,6 +6562,8 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>         cu_info->ao_cu_mask = ao_cu_mask;
>         cu_info->simd_per_cu = NUM_SIMD_PER_CU;
>
> +       DRM_INFO("active_cu_number: %d\n", cu_info->number);
> +
>         return 0;
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
