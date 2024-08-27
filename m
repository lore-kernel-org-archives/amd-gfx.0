Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45288C5472F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 14:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E455B895B9;
	Tue, 27 Aug 2024 14:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jx3jeDTd";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7FF895B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 14:14:43 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso47678655e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724768082; x=1725372882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dXHHjYlk3Kjqxdzv6j0EufS8Jwiu/pG7PIYYX3ESrn8=;
 b=jx3jeDTdgRp/8flPno1cPe0xBAGS1daUzVqO72X/Sp6P0dENq1e4vIzZxWTm97U7Vo
 6+9pJyxkZMFci20qdE2ju4LinykxoGjNyD4eVMAuT7LGw4FrGtaL/oxFiP6e37g+4Mdh
 +qBfrQDXS9CP0x5Th0IRd/oBT+YNYgGCmD34updFN5alb4XzePpkFrzq9cI9/hJ/QiQQ
 kzobI1EeaMIfo9NO6g7pW/tl+2gGxyS/XljCVum5lNfcFlRVdofwk8hSPrJ2AjendEtI
 aKWbIUwQcOemd0Y3AyZEt4bEaOj9OrvUMxbhcKRMBG20tztB5YX4HypFspvoEkH1HBif
 D6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724768082; x=1725372882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dXHHjYlk3Kjqxdzv6j0EufS8Jwiu/pG7PIYYX3ESrn8=;
 b=GNrYqZTH1qNUnN0xIvD5y5FlZUxB5mS7/6Ca9A4bKazFbMH7gTyXKwY3ETdqlTVqq1
 2Z+eh6nsG86Iew6RXoYTOEtzaQB5ThnRZxQ/5KrnigiHy9K4WAqZ8zgT3JK8Tww2bUCK
 OYJSjg1UH91ok4dYDlLrH+XdW68Whe9UjdH+FdKspdjyTgR4mv2GeV6b7mmG0gT6367I
 4fbXaoqBMW1vct6TsUujlQZYOTnzZNGkW0zNkpHZ33HJlNzC2ZYJ4jUSJklb50YADrwW
 nIAsV/7zbn1yzKUsjbWNPXJa+QzpAy3pOYB2F5LN1MFMnYYOwV3W/OyZ8rP6GcTd1EOp
 on4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsjSlWNf644TjwzZeEPeBorME2FItUD094LpXhn7FMxrVWzw8n74i4PjoggcQ9c8jWhTvwyTYL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzN4xhE7u3G6j5ALJeuavok5N/Z7Ez1aJ8qILyAx1p+TF8UoS9I
 AoslhB+kULivcAPZITUxRxPf/ZEg5AcfUrOkTNPC1jICZqBsztwPKIKmwsZn
X-Google-Smtp-Source: AGHT+IFw2g1G9cuZkumZeH+bKN6YLAzHrfHAtzxEoo7LQ6LWk76WDR2ZoR/7X65BkFYlm5jFnudJGg==
X-Received: by 2002:a05:600c:1546:b0:426:6b85:bafb with SMTP id
 5b1f17b1804b1-42acd578731mr96670125e9.20.1724768081718; 
 Tue, 27 Aug 2024 07:14:41 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abef8175fsm222181015e9.25.2024.08.27.07.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 07:14:41 -0700 (PDT)
Message-ID: <7a6b1592-283b-4c17-928e-f8f939b685e2@gmail.com>
Date: Tue, 27 Aug 2024 16:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: use CPU for page table update if SDMA is
 unavailable
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Jesse.Zhang@amd.com
References: <20240730043652.1455274-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240730043652.1455274-1-yifan1.zhang@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.07.24 um 06:36 schrieb Yifan Zhang:
> avoid using SDMA if it is unavailable.

That is clearly not something we should do. The SDMA is mandatory for 
the driver to work.

We could do this for emulation and bringup, but in those cases the 
engineer should probably enabled CPU based updates manually.

Regards,
Christian.

>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a060c28f0877..bcb729094521 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2397,6 +2397,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		   int32_t xcp_id)
>   {
> +	struct amdgpu_ip_block *ip_block;
>   	struct amdgpu_bo *root_bo;
>   	struct amdgpu_bo_vm *root;
>   	int r, i;
> @@ -2426,6 +2427,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>   				    AMDGPU_VM_USE_CPU_FOR_GFX);
>   
> +	/* use CPU for page table update if SDMA is unavailable */
> +	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_SDMA);
> +	if (!ip_block || ip_block->status.valid == false)
> +		vm->use_cpu_for_update = true;
> +
>   	DRM_DEBUG_DRIVER("VM update mode is %s\n",
>   			 vm->use_cpu_for_update ? "CPU" : "SDMA");
>   	WARN_ONCE((vm->use_cpu_for_update &&

