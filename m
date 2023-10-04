Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E87E8FDD9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 07:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014F010E343;
	Wed,  4 Oct 2023 07:58:59 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A5510E343
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 07:58:57 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3231d6504e1so1711033f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Oct 2023 00:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696406336; x=1697011136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tVMK00wv6W1RyhxbkVU/Jao+FGYrh0AlR4gcDh0Lz+w=;
 b=mCOxY6jj59yNAyW5W2uvA1RCKwMO9N+9h1i3c9RJkC77+3ug0PxHemvJyOPPab43u+
 NOzvWG9O9d7xVarvRVtAKsYidtC4mAFY3EnIUR21q+z3L9+5Ioahbd58cPY3gfOo2Fer
 OFV8HnQAqlyvs8sI2xoXiXMg3cbKWkEg7D4+SyfI+CyjpY2Mh6UO9+ib/gPfAattowuX
 06mR9oC919BoHpaSH/BcXe3EOCaF0TQkkYwih8JtBgsJQ1eZK2smTkFhBCzkdGuBco+J
 ZQRpY+vCg1gLHneswZYawdj2rmA9SSruw8ylTHxO7Veih99TxMe8njtgcLvVZnuUBeEQ
 03ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696406336; x=1697011136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tVMK00wv6W1RyhxbkVU/Jao+FGYrh0AlR4gcDh0Lz+w=;
 b=ltmtiDTvJmrB9GwGAJOYSiyAJfLu+KX/Nj0vyf0PDTw/Yv3mT0glaNeoiYcWpD5SxI
 sDMKp1yWN2aa5DRwveyec0ItoijnKUzL0CpuFQz0J6uI6O51xhibF+0UxNUyBxAZ2ueQ
 lAoYEIpUcZNznL2fBScRltSfHbKKpYzhAjBCLq9/HmoXhqsPCnH/+04tuHKOt9XguD2e
 /VoDPNzoNZarQbMA3waWr71TUd17C+A0ukX3XUrRYK8UpX1Ph6R/7RClwfUQWG/fMzI+
 hntZ1hjCdO4SuYbPdqWQcuNa/a9tdae66vjA45Mzxtzt4E/QlIWmfrEyyT4U9PEZ3+6H
 FrmA==
X-Gm-Message-State: AOJu0Yx/EFDoXOzUzB4vVcOHt0GG39wMq8kkHH3tiIq6NQq2qD9fqFQt
 3J/ekvrN/Rz1qUIdn809n80=
X-Google-Smtp-Source: AGHT+IF2UvbveQPtYy6lylMVlBi/sPTFWWES5WbzlQz9csANNV/EXXIQE6Yq3iX/sHQi/Fno4+qqsg==
X-Received: by 2002:a5d:460e:0:b0:31f:f1f4:ca85 with SMTP id
 t14-20020a5d460e000000b0031ff1f4ca85mr1389317wrq.37.1696406336096; 
 Wed, 04 Oct 2023 00:58:56 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.15])
 by smtp.gmail.com with ESMTPSA id
 r3-20020adff703000000b00326b8a0e817sm3359048wrp.84.2023.10.04.00.58.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 00:58:55 -0700 (PDT)
Message-ID: <e5e70e75-5030-b000-3f09-86bba06b1c20@gmail.com>
Date: Wed, 4 Oct 2023 09:58:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 1/2] drm/amdgpu: Rework KFD memory max limits
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231002202117.2690645-1-rajneesh.bhardwaj@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231002202117.2690645-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: philip.yang@amd.com, felix.kuehling@amd.com, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.10.23 um 22:21 schrieb Rajneesh Bhardwaj:
> To allow bigger allocations specially on systems such as GFXIP 9.4.3
> that use GTT memory for VRAM allocations, relax the limits to
> maximize ROCm allocations.
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b5b940485059..c55907ff7dcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -42,6 +42,7 @@
>    * changes to accumulate
>    */
>   #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
> +#define AMDGPU_RESERVE_MEM_LIMIT			(3UL << 29)
>   
>   /*
>    * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
> @@ -115,11 +116,16 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>   		return;
>   
>   	si_meminfo(&si);
> -	mem = si.freeram - si.freehigh;
> +	mem = si.totalram - si.totalhigh;
>   	mem *= si.mem_unit;
>   
>   	spin_lock_init(&kfd_mem_limit.mem_limit_lock);
> -	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
> +	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6);
> +	if (kfd_mem_limit.max_system_mem_limit < 2 * AMDGPU_RESERVE_MEM_LIMIT)
> +		kfd_mem_limit.max_system_mem_limit >>= 1;
> +	else
> +		kfd_mem_limit.max_system_mem_limit -= AMDGPU_RESERVE_MEM_LIMIT;
> +
>   	kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() << PAGE_SHIFT;
>   	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>   		(kfd_mem_limit.max_system_mem_limit >> 20),

