Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78720C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 06:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF94510E118;
	Mon, 11 Mar 2024 06:49:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gtl52xop";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5EFA10E118
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 06:49:52 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2d26227d508so60358381fa.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Mar 2024 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710139791; x=1710744591; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z84rFEXBGfKiGNHfx63zM8+des3CVbcUZ8KAfJ4vdDQ=;
 b=Gtl52xopgVWsieqtkWyNtZ6FnuMPkam1q3LPS9qNIlW3KMq1b7QvACTeCaU8uYY9jj
 YMcab9nfyaRKbTaSUa2bmwSRzLNCZuhNdSixmNobQwbtIiGrPfWqP/LGk4aQ6Af1VGNM
 3TeTH5dDA2KDNjG4VhOQJd57aVI4DXyxO5Dxheah0uC8oVEXSAdPrl1XncA2h18izpOJ
 yeD2ZAkAsaRedraqTv//p1ufce6n+LtcS9P1LD/mgkRHqdzwuaXmo0SVBGhx3S1nRsq0
 eG6AhODfFWE+He8pCeENxws8QVMd5aZYpvYYilQrGzczwYvFllSlxDxEd6Mw4en9Ae+a
 IHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710139791; x=1710744591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z84rFEXBGfKiGNHfx63zM8+des3CVbcUZ8KAfJ4vdDQ=;
 b=GIzLU5b9KMOzns/EdwIxNNsbTL3WJX6MmmRepMGfI127xhf/KS/YbQG3j9Ajsjo44o
 xPQmsQv6KZYgbm51gd/Yt6xLdZPuCvNGTWp3Tw/tyHAsO0ixAYUnmkluLlxs3PxN/l8p
 2Yzpj7W9qy3a+uKsFhR2Dqm7dW5GSa9zWhGWxsuFLWMsjN//VX3Tvh6U3Nk/PZk1QrFC
 VtZ20dMsM1s0/1G6zEYPFo4Xe76QyMoptxHwbJNdv+WoXOwSzjVRwIuYbPyPWIfUlHPQ
 wDpvv4nXjNaliCqWoZvKEJR2NkyjSxeCkouXA43amQw+V7X4aOAFb7qPmQmHCCnvnWvp
 m/gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHne+3EfAeSpARUzDXPl1id29DNR++oYjbJp2lXmcyboHQxX7MDOi1/T+8mn2rLTPkKuv7HPYqluYMVxz1cccTDFBZDKvza6G84aqawQ==
X-Gm-Message-State: AOJu0Yx8XJZFVNpNYbyfKP3YBJoMYOPeh7vkeKnEc2Eg13GstK+hV/qN
 fOMbfSY/FEoqZ3jS9+nMW3GTWwgBsOPu5jH3cJWkkbIBrFzuQt9AZjKrOOaeleQ=
X-Google-Smtp-Source: AGHT+IFqDAytfSWtUoPA6xMFSZ2s2YNaZrKX0DFDrAv7PUHsLWuXOOfUfeSro8WLzSnZByBLNOmz9g==
X-Received: by 2002:a19:3847:0:b0:513:7:fc3c with SMTP id
 d7-20020a193847000000b005130007fc3cmr3033348lfj.55.1710139790409; 
 Sun, 10 Mar 2024 23:49:50 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 jg26-20020a05600ca01a00b004132cc26f97sm771541wmb.25.2024.03.10.23.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Mar 2024 23:49:50 -0700 (PDT)
Message-ID: <4098f759-dc58-422d-b000-af8126775966@gmail.com>
Date: Mon, 11 Mar 2024 07:49:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240308162253.264154-1-mukul.joshi@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240308162253.264154-1-mukul.joshi@amd.com>
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

Am 08.03.24 um 17:22 schrieb Mukul Joshi:
> In certain situations, some apps can import a BO multiple times
> (through IPC for example). To restore such processes successfully,
> we need to tell drm to ignore duplicate BOs.
> While at it, also add additional logging to prevent silent failures
> when process restore fails.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index bf8e6653341f..65d808d8b5da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2869,14 +2869,16 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   
>   	mutex_lock(&process_info->lock);
>   
> -	drm_exec_init(&exec, 0);
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES);
>   	drm_exec_until_all_locked(&exec) {
>   		list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   				    vm_list_node) {
>   			ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
>   			drm_exec_retry_on_contention(&exec);
> -			if (unlikely(ret))
> +			if (unlikely(ret)) {
> +				pr_err("Locking VM PD failed, ret: %d\n", ret);
>   				goto ttm_reserve_fail;
> +			}

That's a bad idea. Locking can always be interrupted and that would 
print an error here.

Regards,
Christian.

>   		}
>   
>   		/* Reserve all BOs and page tables/directory. Add all BOs from
> @@ -2889,8 +2891,10 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   			gobj = &mem->bo->tbo.base;
>   			ret = drm_exec_prepare_obj(&exec, gobj, 1);
>   			drm_exec_retry_on_contention(&exec);
> -			if (unlikely(ret))
> +			if (unlikely(ret)) {
> +				pr_err("drm_exec_prepare_obj failed, ret: %d\n", ret);
>   				goto ttm_reserve_fail;
> +			}
>   		}
>   	}
>   
> @@ -2950,8 +2954,10 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   	 * validations above would invalidate DMABuf imports again.
>   	 */
>   	ret = process_validate_vms(process_info, &exec.ticket);
> -	if (ret)
> +	if (ret) {
> +		pr_err("Validating VMs failed, ret: %d\n", ret);
>   		goto validate_map_fail;
> +	}
>   
>   	/* Update mappings not managed by KFD */
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,

