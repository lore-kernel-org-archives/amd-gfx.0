Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500D1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 13:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DCC610D1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 13:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19DCC610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB8226E93A;
	Wed, 15 Sep 2021 13:57:21 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1123D6E93A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 13:57:20 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 z184-20020a1c7ec1000000b003065f0bc631so4921467wmc.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=PIVkNdzJdf94pYgDqX2EHb61kLNEqeGzVu8k8K2G8TA=;
 b=A+7OUkNuKA1tOid9tvK4L3pCCIDwuFias2pJ4ss6Ru+Pt/Np6ApD+QL+kc57MVPI2h
 vBic4IXMQONUZmRrQ0bD64S/oWv2iNacDVwTzXwSzYMJawUurI6ddNBHnjcO0JgRnUsw
 ET+yNQzfkITB6dtLK7BKRnbpQ24afrNntt66RUf6NGP0d/j62f2MU50J0XEVWQQiCTmv
 6sIMOhBfgT3boUnVpAOK7dlSCOKhUb/Su+ArsQalBzgXbwoKGtRvRJrMFdOvlZREfO//
 XCV2PvxbiLteoZeq53NGIyam1GOKUovHnxnSlNa/kJU05pI6fwF0HPi+NnGgw76B6Pob
 Ft+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=PIVkNdzJdf94pYgDqX2EHb61kLNEqeGzVu8k8K2G8TA=;
 b=cTO92IZSzWyK6KeYC1mj2y/nQ27MuYKY8S36G01YJiFys/5U417OA9qZOLyah4PavE
 3dfCeU9KXXq4NiZPus0Pg+YDhbO2w426iZKEPE4ZRaEEBZ9MsnsZBZw5nCTnc+Guac/Q
 N7hAOpWJPYrn4xTbJIVifVU+m4MdsmhykcYjQqcXk/mQu/lAohfbcTB5+EsAV08IF5fc
 lFNNoc3HaZXxWU3z8L4cQoOLSLgRcW+CxasV/HIkOM3kyVgDFgDsO1lMVAdazRs3VC6/
 TCnvNCFuknVRChzx9w54iDIY3r8OxeER7vzG6GnnDyhvgkf/0R8DDUkoIOmWRLFZb+kc
 xfBA==
X-Gm-Message-State: AOAM531pVWgpPbL2pJIyJHYwJRzPwXu4aBtV/dvmsf/ulIKEsxNUFN/t
 JcilA40f6XaMTSUXcEbTwuJqLXooVZQ=
X-Google-Smtp-Source: ABdhPJzdsJLNkvfFl2JLEsmI7ss06XIDN9uZjmh9NeIJ77YAtFj/629SVEaREnAE/HdXmo8vSDvKvw==
X-Received: by 2002:a1c:984c:: with SMTP id a73mr4405099wme.171.1631714238456; 
 Wed, 15 Sep 2021 06:57:18 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:d03d:8939:3840:1f95?
 ([2a02:908:1252:fb60:d03d:8939:3840:1f95])
 by smtp.gmail.com with ESMTPSA id z2sm22459wma.45.2021.09.15.06.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 06:57:17 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBQdXQgZHJt?=
 =?UTF-8?Q?=5fdev=5fenter/exit_outside_hot_codepath?=
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20210915063739.31244-1-xinhui.pan@amd.com>
 <DM4PR12MB51651F702F35D31B4B76F90287DB9@DM4PR12MB5165.namprd12.prod.outlook.com>
 <5a18c2bb-c919-817f-2dc1-a6bb0bfd9701@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <db1dd9bb-9879-216c-47c1-f21c7d2d9434@gmail.com>
Date: Wed, 15 Sep 2021 15:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5a18c2bb-c919-817f-2dc1-a6bb0bfd9701@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Am 15.09.21 um 15:52 schrieb Andrey Grodzovsky:
> On 2021-09-15 2:42 a.m., Pan, Xinhui wrote:
>> [AMD Official Use Only]
>>
>> Andrey
>> I hit panic with this plug/unplug test without this patch.
>
>
> Can you please tell which ASIC you are using and which kernel branch 
> and what is the tip commit ?
>
>
>> But as we add enter/exit in all its callers. maybe it would not 
>> impact plug/unplug.
>
>
> If you add enter/exit in all callers then why this solves the problem 
> ? Is it because in one or more callers
> amdgpu_gmc_set_pte_pde is called many times and so calling enter/exit 
> many times creates the problematic
> contention from multiple threads ?

The most likely cause of this is cache line bouncing I think and yes 
moving the enter/exit a level up should fix this.

But I strongly suggest to test this with lockdep enabled and hotplug/GPU 
reset a couple of times.

Christian.

>
> Andrey
>
>>
>> [ 1109.041095] BUG: unable to handle page fault for address: 
>> 00000000000010e1
>> [ 1109.086353] RIP: 0010:vega10_power_gate_vce+0x15/0x40 [amdgpu]
>> [ 1109.196706] Call Trace:
>> [ 1109.199374]  ? pp_set_powergating_by_smu+0x1f9/0x4a0 [amdgpu]
>> [ 1109.205843]  amdgpu_dpm_set_powergating_by_smu+0xa6/0x150 [amdgpu]
>> [ 1109.212776]  amdgpu_dpm_enable_vce+0x36/0x100 [amdgpu]
>> [ 1109.218563]  vce_v4_0_hw_fini+0xe1/0xf0 [amdgpu]
>> [ 1109.223747]  amdgpu_device_fini_hw+0x333/0x483 [amdgpu]
>> [ 1109.229650]  amdgpu_driver_unload_kms+0x80/0xe0 [amdgpu]
>> [ 1109.235577]  amdgpu_pci_remove+0x37/0x70 [amdgpu]
>> [ 1109.240853]  pci_device_remove+0x3b/0xb0
>> [ 1109.245127]  device_release_driver_internal+0x100/0x1d0
>> [ 1109.250857]  device_release_driver+0x12/0x20
>> [ 1109.255535]  pci_stop_bus_device+0x79/0xa0
>> [ 1109.260016]  pci_stop_and_remove_bus_device_locked+0x1b/0x30
>> [ 1109.266197]  remove_store+0x7b/0x90
>> [ 1109.269990]  dev_attr_store+0x14/0x30
>> [ 1109.274002]  sysfs_kf_write+0x48/0x60
>> [ 1109.277998]  kernfs_fop_write_iter+0x14e/0x1e0
>>
>> ________________________________________
>> 发件人: Pan, Xinhui <Xinhui.Pan@amd.com>
>> 发送时间: 2021年9月15日 14:37
>> 收件人: amd-gfx@lists.freedesktop.org
>> 抄送: Deucher, Alexander; Koenig, Christian; Grodzovsky, Andrey; Pan, 
>> Xinhui
>> 主题: [PATCH v2] drm/amdgpu: Put drm_dev_enter/exit outside hot codepath
>>
>> We hit soft hang while doing memory pressure test on one numa system.
>> After a qucik look, this is because kfd invalid/valid userptr memory
>> frequently with process_info lock hold.
>> Looks like update page table mapping use too much cpu time.
>>
>> perf top says below,
>> 75.81%  [kernel]       [k] __srcu_read_unlock
>>   6.19%  [amdgpu]       [k] amdgpu_gmc_set_pte_pde
>>   3.56%  [kernel]       [k] __srcu_read_lock
>>   2.20%  [amdgpu]       [k] amdgpu_vm_cpu_update
>>   2.20%  [kernel]       [k] __sg_page_iter_dma_next
>>   2.15%  [drm]          [k] drm_dev_enter
>>   1.70%  [drm]          [k] drm_prime_sg_to_dma_addr_array
>>   1.18%  [kernel]       [k] __sg_alloc_table_from_pages
>>   1.09%  [drm]          [k] drm_dev_exit
>>
>> So move drm_dev_enter/exit outside gmc code, instead let caller do it.
>> They are gart_unbind, gart_map, vm_clear_bo, vm_update_pdes and
>> gmc_init_pdb0. vm_bo_update_mapping already calls it.
>>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>> change from v1:
>> add enter/exit in more gmc_set_pte_pde callers
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 11 ++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 11 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 28 +++++++++++++++++-------
>>   3 files changed, 36 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> index 76efd5f8950f..d7e4f4660acf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> @@ -34,6 +34,7 @@
>>   #include <asm/set_memory.h>
>>   #endif
>>   #include "amdgpu.h"
>> +#include <drm/drm_drv.h>
>>
>>   /*
>>    * GART
>> @@ -230,12 +231,16 @@ int amdgpu_gart_unbind(struct amdgpu_device 
>> *adev, uint64_t offset,
>>          u64 page_base;
>>          /* Starting from VEGA10, system bit must be 0 to mean 
>> invalid. */
>>          uint64_t flags = 0;
>> +       int idx;
>>
>>          if (!adev->gart.ready) {
>>                  WARN(1, "trying to unbind memory from uninitialized 
>> GART !\n");
>>                  return -EINVAL;
>>          }
>>
>> +       if (!drm_dev_enter(&adev->ddev, &idx))
>> +               return 0;
>> +
>>          t = offset / AMDGPU_GPU_PAGE_SIZE;
>>          p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
>>          for (i = 0; i < pages; i++, p++) {
>> @@ -254,6 +259,7 @@ int amdgpu_gart_unbind(struct amdgpu_device 
>> *adev, uint64_t offset,
>>          for (i = 0; i < adev->num_vmhubs; i++)
>>                  amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>>
>> +       drm_dev_exit(idx);
>>          return 0;
>>   }
>>
>> @@ -276,12 +282,16 @@ int amdgpu_gart_map(struct amdgpu_device *adev, 
>> uint64_t offset,
>>   {
>>          uint64_t page_base;
>>          unsigned i, j, t;
>> +       int idx;
>>
>>          if (!adev->gart.ready) {
>>                  WARN(1, "trying to bind memory to uninitialized GART 
>> !\n");
>>                  return -EINVAL;
>>          }
>>
>> +       if (!drm_dev_enter(&adev->ddev, &idx))
>> +               return 0;
>> +
>>          t = offset / AMDGPU_GPU_PAGE_SIZE;
>>
>>          for (i = 0; i < pages; i++) {
>> @@ -291,6 +301,7 @@ int amdgpu_gart_map(struct amdgpu_device *adev, 
>> uint64_t offset,
>>                          page_base += AMDGPU_GPU_PAGE_SIZE;
>>                  }
>>          }
>> +       drm_dev_exit(idx);
>>          return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 54f059501a33..1427fd70310c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -153,10 +153,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device 
>> *adev, void *cpu_pt_addr,
>>   {
>>          void __iomem *ptr = (void *)cpu_pt_addr;
>>          uint64_t value;
>> -       int idx;
>> -
>> -       if (!drm_dev_enter(&adev->ddev, &idx))
>> -               return 0;
>>
>>          /*
>>           * The following is for PTE only. GART does not have PDEs.
>> @@ -165,8 +161,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device 
>> *adev, void *cpu_pt_addr,
>>          value |= flags;
>>          writeq(value, ptr + (gpu_page_idx * 8));
>>
>> -       drm_dev_exit(idx);
>> -
>>          return 0;
>>   }
>>
>> @@ -752,6 +746,10 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device 
>> *adev)
>>                  adev->gmc.xgmi.physical_node_id * 
>> adev->gmc.xgmi.node_segment_size;
>>          u64 vram_end = vram_addr + vram_size;
>>          u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>> +       int idx;
>> +
>> +       if (!drm_dev_enter(&adev->ddev, &idx))
>> +               return;
>>
>>          flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
>>          flags |= AMDGPU_PTE_WRITEABLE;
>> @@ -773,6 +771,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device 
>> *adev)
>>          flags |= AMDGPU_PDE_BFS(0) | AMDGPU_PTE_SNOOPED;
>>          /* Requires gart_ptb_gpu_pa to be 4K aligned */
>>          amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, 
>> gart_ptb_gpu_pa, flags);
>> +       drm_dev_exit(idx);
>>   }
>>
>>   /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 0126ece898da..daa16d2f89da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -800,7 +800,7 @@ static int amdgpu_vm_clear_bo(struct 
>> amdgpu_device *adev,
>>          struct amdgpu_bo *bo = &vmbo->bo;
>>          unsigned entries, ats_entries;
>>          uint64_t addr;
>> -       int r;
>> +       int r, idx;
>>
>>          /* Figure out our place in the hierarchy */
>>          if (ancestor->parent) {
>> @@ -845,9 +845,12 @@ static int amdgpu_vm_clear_bo(struct 
>> amdgpu_device *adev,
>>                          return r;
>>          }
>>
>> +       if (!drm_dev_enter(&adev->ddev, &idx))
>> +               return -ENODEV;
>> +
>>          r = vm->update_funcs->map_table(vmbo);
>>          if (r)
>> -               return r;
>> +               goto exit;
>>
>>          memset(&params, 0, sizeof(params));
>>          params.adev = adev;
>> @@ -856,7 +859,7 @@ static int amdgpu_vm_clear_bo(struct 
>> amdgpu_device *adev,
>>
>>          r = vm->update_funcs->prepare(&params, NULL, 
>> AMDGPU_SYNC_EXPLICIT);
>>          if (r)
>> -               return r;
>> +               goto exit;
>>
>>          addr = 0;
>>          if (ats_entries) {
>> @@ -872,7 +875,7 @@ static int amdgpu_vm_clear_bo(struct 
>> amdgpu_device *adev,
>>                  r = vm->update_funcs->update(&params, vmbo, addr, 0, 
>> ats_entries,
>>                                               value, flags);
>>                  if (r)
>> -                       return r;
>> +                       goto exit;
>>
>>                  addr += ats_entries * 8;
>>          }
>> @@ -895,10 +898,13 @@ static int amdgpu_vm_clear_bo(struct 
>> amdgpu_device *adev,
>>                  r = vm->update_funcs->update(&params, vmbo, addr, 0, 
>> entries,
>>                                               value, flags);
>>                  if (r)
>> -                       return r;
>> +                       goto exit;
>>          }
>>
>> -       return vm->update_funcs->commit(&params, NULL);
>> +       r = vm->update_funcs->commit(&params, NULL);
>> +exit:
>> +       drm_dev_exit(idx);
>> +       return r;
>>   }
>>
>>   /**
>> @@ -1384,11 +1390,14 @@ int amdgpu_vm_update_pdes(struct 
>> amdgpu_device *adev,
>>                            struct amdgpu_vm *vm, bool immediate)
>>   {
>>          struct amdgpu_vm_update_params params;
>> -       int r;
>> +       int r, idx;
>>
>>          if (list_empty(&vm->relocated))
>>                  return 0;
>>
>> +       if (!drm_dev_enter(&adev->ddev, &idx))
>> +               return -ENODEV;
>> +
>>          memset(&params, 0, sizeof(params));
>>          params.adev = adev;
>>          params.vm = vm;
>> @@ -1396,7 +1405,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>> *adev,
>>
>>          r = vm->update_funcs->prepare(&params, NULL, 
>> AMDGPU_SYNC_EXPLICIT);
>>          if (r)
>> -               return r;
>> +               goto exit;
>>
>>          while (!list_empty(&vm->relocated)) {
>>                  struct amdgpu_vm_bo_base *entry;
>> @@ -1414,10 +1423,13 @@ int amdgpu_vm_update_pdes(struct 
>> amdgpu_device *adev,
>>          r = vm->update_funcs->commit(&params, &vm->last_update);
>>          if (r)
>>                  goto error;
>> +       drm_dev_exit(idx);
>>          return 0;
>>
>>   error:
>>          amdgpu_vm_invalidate_pds(adev, vm);
>> +exit:
>> +       drm_dev_exit(idx);
>>          return r;
>>   }
>>
>> -- 
>> 2.25.1
>>

