Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C0AC48BF6
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 12:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB72510F7CF;
	Mon,  4 Mar 2024 12:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MhH+wILT";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48C510E233
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 12:51:08 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-33e17fc5aceso1991380f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Mar 2024 04:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709556667; x=1710161467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mr5ehkabRBtZi422qWuxoXMMfhibg0edlXdEaZ1BVzo=;
 b=MhH+wILTuh6TqECZ/xhcarrs9+lH3AignmF6aDkL+HBfFksEONVhhF4QgEuFQrfNGW
 oUvJpt95WbpD3nN+orex2eZC5twjhhSAcIy+WkM6og34rFxGOvsCSi+v6lyrI+/7jxu3
 4Gn/W/3MxJlPn2jXMO7mz57VouYyBS+Tej9hhlyJrZ4k22s8iFqUhSVY1rJ1z8zXfcz0
 eY90c3z6F/oQCnZRxCNMTgTJMaZiF43ksVu3wotV8TQA3dG5CurnUxDZxxJac5jVx6Tz
 VW410ZVr3NKj/0LsweRzxo4mS/xo9XP2WIa3L2O+tqDFGR2AqWO2U4N01Cj/J4ejiJrw
 nrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709556667; x=1710161467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mr5ehkabRBtZi422qWuxoXMMfhibg0edlXdEaZ1BVzo=;
 b=OKQJ4J+Z+HxtG5/mQFN4/knhE+dWyXZ8qwx/ggpY3q/Ph87wTwliTrBt+4tlLtWWMR
 cUwC0egHE5HpB9sTPuK0lw/HD0Ii6GRnznNbPUVnm+oJ7E9Q6D0RpatNEoB1Fg3nnPa+
 Nwp7ZzwI4LpX/Vd65EUG6od8CaodoWV5D/ZiyerFF0G41peV1qfqCxpzAYGDncMhWKry
 8VsykvxzCTCFKCNMoY+qcSkhpwt4wLjbPcXp4M3PG9ccO/GMeRQCmkSDcINt2c7WiZ1e
 ErdoWeLNYFGll+5SmFxfazkuYwpxFd4diflUinbJD+FnwWovmyY5vUJjUBxs53LRCjZh
 EhSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1hry3vygBaFDFKi+AH+oAretbcgY5ZV+Wg/PS/Xm/T9ZGh8RiZlT9v3VxqYtU5wOMo1nB3TDR6keIbDgA+cCjzffkjQwe/eMGj/rXLQ==
X-Gm-Message-State: AOJu0YzAJkFldr6bZws9apYL8kezU1vYyula5BPI9i3cnb/QqyvP+ixz
 yrbtf5tKHFs+WzrOFgXiWmnJ1+xDvS11cPBYjvUgZRcYYSVxzwhV
X-Google-Smtp-Source: AGHT+IGEIxbujw1k6dQ1/qb+g5t23D3u5ZfE5f7Vf9bzbC0VPyrzRP9MXFMK7rk3tMbl3x9ZhTYrPg==
X-Received: by 2002:adf:9c8b:0:b0:33e:30a:c6bd with SMTP id
 d11-20020adf9c8b000000b0033e030ac6bdmr9531053wre.6.1709556666648; 
 Mon, 04 Mar 2024 04:51:06 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 bs19-20020a056000071300b0033daaef7afcsm12427076wrb.83.2024.03.04.04.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 04:51:06 -0800 (PST)
Message-ID: <0162bf19-4cb5-4f2c-85a3-234fe4f79837@gmail.com>
Date: Mon, 4 Mar 2024 13:51:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu : remove unused code
Content-Language: en-US
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, aaron.liu@amd.com, Felix.Kuehling@amd.com
References: <20240304091617.534109-1-jesse.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240304091617.534109-1-jesse.zhang@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.03.24 um 10:16 schrieb jesse.zhang@amd.com:
> From: Jesse Zhang <jesse.zhang@amd.com>
>
> Remove the unused function - amdgpu_vm_pt_is_root_clean
> and remove the impossible condition
>
> v1: entries == 0 is not possible any more,
>     so this condition could probably be removed (Felix)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 61 ++++++-----------------
>   2 files changed, 16 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 7f95039bb37d..047ec1930d12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -537,8 +537,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
>   			int32_t xcp_id);
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> -bool amdgpu_vm_pt_is_root_clean(struct amdgpu_device *adev,
> -				struct amdgpu_vm *vm);
>   
>   int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   			 struct amdgpu_vm_bo_base *entry);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 8bce4da67131..7ecddb77b3ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -367,6 +367,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	struct amdgpu_bo *bo = &vmbo->bo;
>   	uint64_t addr;
>   	int r, idx;
> +	uint64_t value = 0, flags = 0;

Please don't initialize the values here.

Rather move that before the if (... >= VEGA10) below.

With that fixed feel free to add Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

>   
>   	/* Figure out our place in the hierarchy */
>   	if (ancestor->parent) {
> @@ -409,27 +410,24 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	addr = 0;
>   
> -	if (entries) {
> -		uint64_t value = 0, flags = 0;
> -
> -		if (adev->asic_type >= CHIP_VEGA10) {
> -			if (level != AMDGPU_VM_PTB) {
> -				/* Handle leaf PDEs as PTEs */
> -				flags |= AMDGPU_PDE_PTE;
> -				amdgpu_gmc_get_vm_pde(adev, level,
> -						      &value, &flags);
> -			} else {
> -				/* Workaround for fault priority problem on GMC9 */
> -				flags = AMDGPU_PTE_EXECUTABLE;
> -			}
> -		}
>   
> -		r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
> -					     value, flags);
> -		if (r)
> -			goto exit;
> +	if (adev->asic_type >= CHIP_VEGA10) {
> +		if (level != AMDGPU_VM_PTB) {
> +			/* Handle leaf PDEs as PTEs */
> +			flags |= AMDGPU_PDE_PTE;
> +			amdgpu_gmc_get_vm_pde(adev, level,
> +					      &value, &flags);
> +		} else {
> +			/* Workaround for fault priority problem on GMC9 */
> +			flags = AMDGPU_PTE_EXECUTABLE;
> +		}
>   	}
>   
> +	r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
> +				     value, flags);
> +	if (r)
> +		goto exit;
> +
>   	r = vm->update_funcs->commit(&params, NULL);
>   exit:
>   	drm_dev_exit(idx);
> @@ -673,33 +671,6 @@ void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>   }
>   
> -/**
> - * amdgpu_vm_pt_is_root_clean - check if a root PD is clean
> - *
> - * @adev: amdgpu_device pointer
> - * @vm: the VM to check
> - *
> - * Check all entries of the root PD, if any subsequent PDs are allocated,
> - * it means there are page table creating and filling, and is no a clean
> - * VM
> - *
> - * Returns:
> - *	0 if this VM is clean
> - */
> -bool amdgpu_vm_pt_is_root_clean(struct amdgpu_device *adev,
> -				struct amdgpu_vm *vm)
> -{
> -	enum amdgpu_vm_level root = adev->vm_manager.root_level;
> -	unsigned int entries = amdgpu_vm_pt_num_entries(adev, root);
> -	unsigned int i = 0;
> -
> -	for (i = 0; i < entries; i++) {
> -		if (to_amdgpu_bo_vm(vm->root.bo)->entries[i].bo)
> -			return false;
> -	}
> -	return true;
> -}
> -
>   /**
>    * amdgpu_vm_pde_update - update a single level in the hierarchy
>    *

