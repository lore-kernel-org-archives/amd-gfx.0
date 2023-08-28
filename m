Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3BAC71153
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 09:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA1D10E263;
	Mon, 28 Aug 2023 09:40:52 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FCBF10E263
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 09:40:50 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so4088722a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693215649; x=1693820449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6cD0E0nTYpQFq9OU4OsYYTYTJpRJ7J8o8Qyeff4bzcs=;
 b=fwgYx23KAHycfvgAjbwI3cGFSAIetB4Hy0mG2qQ+AAPX1ujxyU/ulv85q0w1Nkk28L
 +ONcJme52s5SnVnubKT5Bg4gArBRbSbrodxktz1t4btW4H0fEv+b+fWqEyGeXyPfd+q9
 fPVkWoX0EfHfuqMgWXLrfu/cgT9hDYL1vUpJTUNdWn4ij8KbOU/Ty8MFx96zzpXWnTK/
 c6seuKtLA+9Th8re/qixlIWszdk8zhB5yqIhEoji8sNnTXnw8umgMhjmpA5cwSfiHW3Z
 WsqrgpXrBlP3fOQlwU1dt30ttELUtk3/opFk4Wua+4ZcCj1TU6ICARi7k77D1dWcSxH9
 rxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693215649; x=1693820449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cD0E0nTYpQFq9OU4OsYYTYTJpRJ7J8o8Qyeff4bzcs=;
 b=boQWWVhkkmh1cYhiI+U2/i3PrlGM8u0NzFQWsSiYuovFS1wDrwbifmyIMf2ghD/Hq6
 PNPgXH/ZqjKawRrkHPyVhsaBRxDVDU59EjF/rVngFIdwe83Zw8x6FsXt2kGwaiABQG0r
 Zqy9auYYJmuySpreymC4oaab1sWZM8TNlSJzMIlWItdUDpFz72ArugYR4vz3a4muyY/R
 Qf5pMNL+UgmLS08taSA7I84njFlRcthpLWuI6VeDyYNSOE7FN2LqcDLw+5vkSXyaRSJD
 w40xtpNBosmFiAtKI87LDFfMUwwSS9+A2vO6Hb2nN5vHgzaNfniLqyosbrQLg98AJQRl
 ngog==
X-Gm-Message-State: AOJu0YzEAqykvlkqdLq/jLrRHSOow7LqsnmAlPPNAzmiPtTKXdYBeFQn
 F5N/06VWhD16xNNKUO7ImrE=
X-Google-Smtp-Source: AGHT+IE9iDlWS5YRoIjHyPuedrUK24/4C7B76YMmuONgFrtB/ajbc88UAQ6XrCd+apGOdLlqkVRalw==
X-Received: by 2002:aa7:d0c4:0:b0:525:53b6:3ef9 with SMTP id
 u4-20020aa7d0c4000000b0052553b63ef9mr18257045edo.35.1693215648502; 
 Mon, 28 Aug 2023 02:40:48 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.98.175])
 by smtp.gmail.com with ESMTPSA id
 s1-20020aa7c541000000b0052333e5237esm4231011edr.88.2023.08.28.02.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 02:40:48 -0700 (PDT)
Message-ID: <4f64681c-11de-7c9d-c71c-d96b4099a9bf@gmail.com>
Date: Mon, 28 Aug 2023 11:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for
 gfx10 onwards APUs
Content-Language: en-US
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230825003348.3978418-1-yifan1.zhang@amd.com>
 <20230825003348.3978418-2-yifan1.zhang@amd.com>
 <IA1PR12MB635664DEA385477CF3996C8DC1E0A@IA1PR12MB6356.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <IA1PR12MB635664DEA385477CF3996C8DC1E0A@IA1PR12MB6356.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Is that now validated with IOMMU in non pass through mode?

Christian.

Am 28.08.23 um 10:58 schrieb Zhang, Yifan:
> [AMD Official Use Only - General]
>
> Ping
>
> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Friday, August 25, 2023 8:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for gfx10 onwards APUs
>
> To decrease VRAM pressure for APUs, put page tables to GTT domain for gfx10 and newer APUs.
>
> v2: only enable it for gfx10 and newer APUs (Alex, Christian)
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 96d601e209b8..4603d87c61a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -515,10 +515,13 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>          bp.size = amdgpu_vm_pt_size(adev, level);
>          bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
>
> -       if (!adev->gmc.is_app_apu)
> -               bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> -       else
> +       if (adev->gmc.is_app_apu ||
> +               ((adev->flags & AMD_IS_APU) &&
> +               (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 3))))
>                  bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> +       else
> +               bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> +
>
>          bp.domain = amdgpu_bo_get_preferred_domain(adev, bp.domain);
>          bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> --
> 2.37.3
>

