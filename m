Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE0FC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 11:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB5ED10E256;
	Wed, 28 Feb 2024 11:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a6dacmQL";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5E910E256
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 11:34:22 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-412ae087378so12454725e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 03:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709120060; x=1709724860; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ly+SUVOstwCkRf5u9OenZRvyKRhBH9T7LHh5lx6qal4=;
 b=a6dacmQLmu6a5U9mV8xuAM9QkqVcV1RBWGT48McUc6BQC6eqjPeI2gA/g7AJA3sSU3
 zruY/ojU8Un/OJ71IZy9iFTL5W6eWdROV2MQjPmoy6BWQdrdPRsWzhMXp4pwBqbdrFBp
 9H+NdEhOm6JkCnVHueJ/pCQZHtb1rMzs7om/Yb0YIG4e6lkYkY3cOOtYwuCLojJbRqPj
 RGfmHnJmTXbuuAM3D9wnlJtx/cxxChxUrm20p4gX3LHkpGBVktcqj/gQnRaJ0sgLxe4t
 ZZEcT+W0SilbEwFwVNqTUZKJMoXb/m8nm8yJ4tHaZSoh+EzpXEDSOuC1/i6PdX4C436b
 /RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120060; x=1709724860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ly+SUVOstwCkRf5u9OenZRvyKRhBH9T7LHh5lx6qal4=;
 b=BM/euKo8WrgfR/PpzDqqhJOSSoeGjIvl41U1xigor5MEAXXAJwNQ00tU/Fw1wnJUQ5
 VDU/UPXSt1dJj5zs/OHoOYisQUL+tL9SEZr4d1DM4Rl6D3bDEcwmVmkOqa3WSW87OxAE
 RE+mFYfmbv7Of7HwrofQbZYI5a9eiCcOnsmVZqxsGKEp3bJzOgmoCwFt3vDCR1FqH9H5
 z1nEcMYTtd8FdCHCf5WGU7ZXHabYIAYvWfrKg/El0cK31fMHRRqPHmRL7LCXKTzzAj6Y
 hajbs/F+XSLjEsRaZjXpskUzd2oe/w//oPOQZPwnszqfG+dwLPz0af3D229y2qOzSo8X
 3dyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtgVldF/fuRxDLzH11zHmXXYClT1HeMe1OnGI6Y9ZbXMHcKwqo42lmmQ7ulXCQEYFIO1WW1COFWYx+YK+/H7maZjnXUO1emSkgBlZSwQ==
X-Gm-Message-State: AOJu0YykxFbjnkBrWrvM9O4sy+7DmmN16YV2ocw6EiqExR1D8e06OqAE
 OHMLBUzLGjbqQ8cDQ8YXU1l/b3Es2GlmJkl6VgufCZH1OH41nJo/
X-Google-Smtp-Source: AGHT+IE5HEx7m4bjcu44FhiskVuScGLkpBMua7FH/4G/1yyN0IvBhfkzaktnHVlOucSdNsuPIBJnzA==
X-Received: by 2002:a05:600c:1da2:b0:412:ae96:10c5 with SMTP id
 p34-20020a05600c1da200b00412ae9610c5mr2798360wms.40.1709120060151; 
 Wed, 28 Feb 2024 03:34:20 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c3b9000b00411e3cc0e0asm1849766wms.44.2024.02.28.03.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:34:19 -0800 (PST)
Message-ID: <a7fcaf8b-8036-418d-b28c-5e38e8f65978@gmail.com>
Date: Wed, 28 Feb 2024 12:34:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute" for Raven
Content-Language: en-US
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Arunpravin.PaneerSelvam@amd.com,
 Felix.Kuehling@amd.com
References: <20240228084316.124843-1-jesse.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240228084316.124843-1-jesse.zhang@amd.com>
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

Hi Jesse,

Am 28.02.24 um 09:43 schrieb jesse.zhang@amd.com:
> From: "Jesse.Zhang" <Jesse.Zhang@amd.com>
>
> fix the issue:
> "amdgpu: Failed to create process VM object".
>
> [Why]when amdgpu initialized, seq64 do mampping and update bo mapping in vm page table.
> But when clifo run. It also initializes a vm for a process device through the function kfd_process_device_init_vm
> and ensure the root PD is clean through the function amdgpu_vm_pt_is_root_clean.
> So they have a conflict, and clinfo  always failed.
>
> [HOW]
> Skip the seq64 entry check in vm page table.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a160265ddc07..bdae5381887e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -746,8 +746,21 @@ bool amdgpu_vm_pt_is_root_clean(struct amdgpu_device *adev,
>   	enum amdgpu_vm_level root = adev->vm_manager.root_level;
>   	unsigned int entries = amdgpu_vm_pt_num_entries(adev, root);
>   	unsigned int i = 0;
> +	u64 seq64_addr = (adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT) - AMDGPU_VA_RESERVED_TOP;
> +
> +	seq64_addr /= AMDGPU_GPU_PAGE_SIZE;
> +	mask = amdgpu_vm_pt_entries_mask(adev, adev->vm_manager.root_level);
> +	shift = amdgpu_vm_pt_level_shift(adev, adev->vm_manager.root_level);
> +	seq64_entry = (seq64_addr >> shift) & mask;
>   
>   	for (i = 0; i < entries; i++) {
> +		/* seq64  reserve 2M memory from top of address space.
> +		 * Then do the mapping and update the vm page table at amdgpu initialize.
> +		 * So skip the know result.
> +		 */
> +
> +		if(i == seq64_entry)
> +			continue;

Once more it is intentional that this fails!

Renoir shouldn't be using the ATS setting any more because that 
functionality was removed.

But it looks like the setting is somehow still active and because of 
this you run into this issue here.

Regards,
Christian.

>   		if (to_amdgpu_bo_vm(vm->root.bo)->entries[i].bo)
>   			return false;
>   	}

