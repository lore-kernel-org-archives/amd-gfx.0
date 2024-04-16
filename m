Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9C3C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 09:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0462210EB8C;
	Tue, 16 Apr 2024 09:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jnxvPuE7";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62FF310EB95
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 09:07:50 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2da84f93c99so19809491fa.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713258468; x=1713863268; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2X3Vtvl0lWH/Wjr+3KDeywV6qXeUA1pkGg9bkg59RU=;
 b=jnxvPuE7/7/s36bOUFJ7i22Z60MbWpkKFO2yJs+dAx1lvbfxeKsb8Pg5UuFi0cCdme
 jFh7QYV8e0z+ZpVJYxDvrmr4YdjP5Q0owuN+DEFimBMbqOnOKF7WCNk6gdV+bju0ZTCt
 Aw/ZXwlHWVkITjPHwSO+hX9qFBlkeStedzT03ShAhetDTVB9EWd5DVpYc5HD63pRNFcC
 3Oi8Yatu63BR6/g2kmrcwphFUCcVgS76E3D6s/cW2PkVViIhGjp6w+DsGt4dwGLj8nxk
 oSh8KasR6wlSIrOGN9MXuBirtI4T6x+vQurcFpuyTbOeGSa8zEy0BDz4hE/RnSSbfSLu
 CAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713258468; x=1713863268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2X3Vtvl0lWH/Wjr+3KDeywV6qXeUA1pkGg9bkg59RU=;
 b=qaAyUyMpC95now5kEGh2OXjC5oJOVTOoHhIGJE2NgPEYOIAgzLHczaf15G9Nhppl9A
 aAme1YeoH+U1j3zPM4B8YDp0sUJ69+xhijzqpDF2SvSoRu5Nf2IUuoJ+HdWEoUyl5r+8
 GNO++8BsQlZa0xR5XvYmXnDYRU4MxSi6kFm0QZ1sb8peWQ+ovunb5Jyp1y7bQ8g9NyX2
 2IrxDueU8RSPDoku3AA0GdByY/DTERs7mh3plfp3LD/oolmEhhgpeeRHbXGSURwGp/vY
 2tbwNT7F14MgTfN1GDbIQpROGvW7EfcqLHUEOEOcnKZDSGKkdd2djsrpoOidpmx3oiOp
 ru/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKxYIubpjJhQiwmoqUKQmobKfUhE0vPQs22WO2IbGCdbQs3FjzGBJT8PuHqOn9Rlodo0V8ompzR5xAjreomI2tx1+EVTgZxbOtZbrTzA==
X-Gm-Message-State: AOJu0Yy+dKeOZfmzN2Bbj3LjarIdx2DTGHHX2psxBRcNiqIia6b/z9et
 xMvKqcEBeaaQq7tZyjF3tw+CkzWAPOf8NRHEiEOzGtTEEVgkM+HO
X-Google-Smtp-Source: AGHT+IHeP8ete9PGshfYMDPRdV1LVoXfTduDVkJMn/XtZ1VqpTqoQoAJ9zi0JqQ3aVxbHV+ujIXjow==
X-Received: by 2002:a2e:9b1a:0:b0:2d8:5e8b:7de4 with SMTP id
 u26-20020a2e9b1a000000b002d85e8b7de4mr9442164lji.6.1713258468308; 
 Tue, 16 Apr 2024 02:07:48 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a05600c0a4c00b00416770871f7sm22581159wmq.25.2024.04.16.02.07.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 02:07:47 -0700 (PDT)
Message-ID: <32368a9a-171a-449b-a743-834bfc24c2ac@gmail.com>
Date: Tue, 16 Apr 2024 11:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: make sure VM is ready for updating
 operations
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20240411081101.3883715-1-Lang.Yu@amd.com>
 <MW6PR12MB8898F0B4C9E26188E8FE69D5FB082@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <MW6PR12MB8898F0B4C9E26188E8FE69D5FB082@MW6PR12MB8898.namprd12.prod.outlook.com>
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

Looks valid to me of hand, but it's really Felix who needs to judge this.

On the other hand if it blocks any CI feel free to add my acked-by and 
submit it.

Christian.

Am 16.04.24 um 04:05 schrieb Yu, Lang:
> [Public]
>
> ping
>
>> -----Original Message-----
>> From: Yu, Lang <Lang.Yu@amd.com>
>> Sent: Thursday, April 11, 2024 4:11 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; Yu, Lang <Lang.Yu@amd.com>
>> Subject: [PATCH v2] drm/amdkfd: make sure VM is ready for updating
>> operations
>>
>> When page table BOs were evicted but not validated before updating page
>> tables, VM is still in evicting state, amdgpu_vm_update_range returns -EBUSY
>> and restore_process_worker runs into a dead loop.
>>
>> v2: Split the BO validation and page table update into two separate loops in
>> amdgpu_amdkfd_restore_process_bos. (Felix)
>>   1.Validate BOs
>>   2.Validate VM (and DMABuf attachments)
>>   3.Update page tables for the BOs validated above
>>
>> Fixes: 2fdba514ad5a ("drm/amdgpu: Auto-validate DMABuf imports in
>> compute VMs")
>>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> ---
>> .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 34 +++++++++++----
>> ----
>> 1 file changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 0ae9fd844623..e2c9e6ddb1d1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2900,13 +2900,12 @@ int
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>> __rcu *
>>
>>        amdgpu_sync_create(&sync_obj);
>>
>> -      /* Validate BOs and map them to GPUVM (update VM page tables).
>> */
>> +      /* Validate BOs managed by KFD */
>>        list_for_each_entry(mem, &process_info->kfd_bo_list,
>>                            validate_list) {
>>
>>                struct amdgpu_bo *bo = mem->bo;
>>                uint32_t domain = mem->domain;
>> -              struct kfd_mem_attachment *attachment;
>>                struct dma_resv_iter cursor;
>>                struct dma_fence *fence;
>>
>> @@ -2931,6 +2930,25 @@ int
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>> __rcu *
>>                                goto validate_map_fail;
>>                        }
>>                }
>> +      }
>> +
>> +      if (failed_size)
>> +              pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
>> +
>> +      /* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
>> +       * validations above would invalidate DMABuf imports again.
>> +       */
>> +      ret = process_validate_vms(process_info, &exec.ticket);
>> +      if (ret) {
>> +              pr_debug("Validating VMs failed, ret: %d\n", ret);
>> +              goto validate_map_fail;
>> +      }
>> +
>> +      /* Update mappings managed by KFD. */
>> +      list_for_each_entry(mem, &process_info->kfd_bo_list,
>> +                          validate_list) {
>> +              struct kfd_mem_attachment *attachment;
>> +
>>                list_for_each_entry(attachment, &mem->attachments, list) {
>>                        if (!attachment->is_mapped)
>>                                continue;
>> @@ -2947,18 +2965,6 @@ int
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>> __rcu *
>>                }
>>        }
>>
>> -      if (failed_size)
>> -              pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
>> -
>> -      /* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
>> -       * validations above would invalidate DMABuf imports again.
>> -       */
>> -      ret = process_validate_vms(process_info, &exec.ticket);
>> -      if (ret) {
>> -              pr_debug("Validating VMs failed, ret: %d\n", ret);
>> -              goto validate_map_fail;
>> -      }
>> -
>>        /* Update mappings not managed by KFD */
>>        list_for_each_entry(peer_vm, &process_info->vm_list_head,
>>                        vm_list_node) {
>> --
>> 2.25.1

