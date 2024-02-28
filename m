Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9474C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 06:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5324410E131;
	Wed, 28 Feb 2024 06:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IVg1CRub";
	dkim-atps=neutral
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE34610E131
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 06:41:49 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2d28051376eso50539371fa.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Feb 2024 22:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709102507; x=1709707307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lWD9mnq9nypF2Xxpw1oWV1T1tU3XzWs59y1YEBUCcH4=;
 b=IVg1CRubknNv95Ez1k+vAVIJlZyBXFCb3wijGg4E34PTmTtDIDnTf6BPKg93DtAtHz
 c753VNaw+VedxlqezcS/FX0TAYpWWcoF8/1u98zJKg7Kf4t3GHJ8LrkLsdA6BQgg4AGE
 hN1xVk/6PV0hxRlPiK0CyUU2Nk6k0C9DbZU1LgKH6q/4ZsnvdZYHGGzEjiii/F3qQCyR
 YD97/RU0y2Fx+ic+hOjdh0ccdFT6TD2DFilFB2MIeyFG8ggEH+qy6fdH5JfTQW7LHbuv
 LzB5WtslfkMi954rVXRqAA9VLl828iYUraUP2MRM2pIouo8mFrvbA0UKPoHs+ThJwoqy
 FqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709102507; x=1709707307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lWD9mnq9nypF2Xxpw1oWV1T1tU3XzWs59y1YEBUCcH4=;
 b=lFDwSGs8WZVFyJ3ErGyEtoUqMuSSXdey4AepupdxP9qjWrqWX1WfZ4d4Mga4tsYTDm
 mRDkm502D1tWhvEhNGhgz6F/D94cWnzOXXPPIu73wCZribrMtqNmwXioOIW7VRNtjXHJ
 RgDmBXIrP5Au8MzOlCC/WDURVO+4DNz9bAc5b9fLaEdUTaB6bSc1ECc4pmVw9f7aYR42
 NfxnTyPYeJy5nKTTLciXzpSnYut0gCzRAW89ckcFtIQ+X0Pk7+SAxDbbMSzEPU4Ny1KJ
 XWAIA/mRU8cq1a15yAGlbJjIkcxdozxarkUoFBYrEMDgYK60WdbbyMJbXFAWfWMxkLhL
 j70g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrVzFfaKG9k/DwuhxnKeCDVKZnGoeqCeH34jDq0JOuD27Getcv5YfKA+ukxlex3YQd7RN+CnO3UL26JnP4WhFUj7/BCxawJMHGs1E34A==
X-Gm-Message-State: AOJu0Yz+r0hhTOh3Hr4hIQLPn8s9mLCkTcF/2tIldQwnZ2EJEsCOgjVK
 GiDVzOTW28vKNmf11QOorZXVKPWqISAN52A8J8LfURZVOb0KFjOvSMSiPP1S
X-Google-Smtp-Source: AGHT+IFtBbWiywjWIgfdDZjKvPqTdePBIcAxnBxQ+3kAi5ssbw/Hn6o0KsS6kCoUsgJMHhIX0/usKA==
X-Received: by 2002:a2e:a694:0:b0:2d2:9906:6db2 with SMTP id
 q20-20020a2ea694000000b002d299066db2mr2109618lje.39.1709102507100; 
 Tue, 27 Feb 2024 22:41:47 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 bs17-20020a056000071100b0033df8854f0dsm1663657wrb.26.2024.02.27.22.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 22:41:46 -0800 (PST)
Message-ID: <b49d2f47-6e24-4c42-9a49-a65cca59fcc0@gmail.com>
Date: Wed, 28 Feb 2024 07:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute" for Raven
Content-Language: en-US
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Yifan1.Zhang@amd.com
References: <20240228050446.89436-1-Jesse.Zhang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240228050446.89436-1-Jesse.Zhang@amd.com>
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

Am 28.02.24 um 06:04 schrieb Jesse.Zhang:
> fix the issue when run clinfo:
> "amdgpu: Failed to create process VM object".
>
> when amdgpu initialized, seq64 do mampping and update bo mapping in vm page table.
> But when clifo run. It also initializes a vm for a process device through the function kfd_process_device_init_vm
> and ensure the root PD is clean through the function amdgpu_vm_pt_is_root_clean.
> So they have a conflict, and clinfo  always failed.

Big NAK for this, you removed the check but didn't solved the problem in 
any way.

When Raven still needs the ats feature than it is intentional that this 
fails.

Regards,
Christian.

>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ed4a8c5d26d7..0bc0bc75be15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2361,12 +2361,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	 * changing any other state, in case it fails.
>   	 */
>   	if (pte_support_ats != vm->pte_support_ats) {
> -		/* Sanity checks */
> -		if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
> -			r = -EINVAL;
> -			goto unreserve_bo;
> -		}
> -
>   		vm->pte_support_ats = pte_support_ats;
>   		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
>   				       false);

