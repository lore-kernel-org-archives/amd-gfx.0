Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334E0ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 07:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8047B10E894;
	Wed, 14 Sep 2022 07:23:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E2110E894
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 07:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOK6KlmPHIL93JLUkkXxfaTW0Tt7qy0D65+EFqOhuzZ0xa08T/NbUJHfwnq1h1+1BAzBQ4SIVbpI//26Dxw+YUyoGb1oOG9YEv7H1/YsDpYcqeIVwyB1+Od5kRNsXJtS3JVVGA707ywtjFM3nK3BvrUnEldqKgYTTZZavFvbQWRfE5Nzw9cB/gRimWA2J/b/t6CXwpboQvZVhh9rC/1MqeSHW0aVuXucrJJFElXX2FWRnplRuvmrJs+uTLv1EU/pK9nb1pDWVUOFLvZOnCedMqSvKAho7qCxPJm5SpGl+k9d/cT4hvxm9ENLVfvMSKjWDJ5NrAhtCcIr3/jgK7jVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKysh9atvHpALFx2lv4RapBPkCdkqDWWi3/5ItP0F4g=;
 b=WGmRBBDUA8SRljKAz+oXQfSKcLuP5zY8OPtsDQC6KaYeZbHEMCDskj2Z959u1XOa+n4Tym0VvWsvH+4xsdJDuo9/9dY0MY46onPbGrh+42r0pqoOJZQTnt4w0n7EnYSKoU24IQn8aFsPyvx3fhOqHozrPQcv9OrhEUFdLZKyMi+ZhpfmVSjs9UfUIkT2SXRsgJFzRib+c9EbSS9YRvTUdjYoXItWJ8o49E1UGbUnXMG/AKcMD/gGe9950bQcSGvU3NjGr2y9FZBbxDCStqPZ/B+3tutbgwjmOwhrpHDbG6E53S2ZgXcoqGTDQobVFVA1561mOq1tnerk/MtMGqoVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKysh9atvHpALFx2lv4RapBPkCdkqDWWi3/5ItP0F4g=;
 b=Mn9CDXpr4z14wESeqkJSEGvbT4dWz7F1gxby7rtoZMJPrkxbtscugjTNA2PTJVM2PmYqP3TVwxOnetaj2Jl6j1NO+Ziw1TmfPa3LsgwKkYYL1Rpf0uoh+nT1jwKIa9Ub9Pp24h16g0TVuPds7g9Ni0xqG2B0xEqJH/iS33AMPRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 07:23:46 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 07:23:45 +0000
Message-ID: <d506f810-0cd7-5e61-cb17-7f518f7571a6@amd.com>
Date: Wed, 14 Sep 2022 09:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/7] drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20220912123640.20058-1-christian.koenig@amd.com>
 <20220912123640.20058-6-christian.koenig@amd.com>
 <448c338e-1b05-9de2-2dbd-6550b5c60f55@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <448c338e-1b05-9de2-2dbd-6550b5c60f55@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a675244-16ad-4b81-02b7-08da96220efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYt/DSmsZ4bB4HOnO1NVY4muome4p6/YrSdrxlwACa3AHr/thYjo88aDtF81HxQhteOc8JMNiXsTxm9Pxnf+hzaxmyK3dWDINlT7b+DPfv4SfQ0+viynzttqbPKLNIdjYAHUQfPam5UOXlXtFCXHeJJWWPIH2Fm+NBZUGJ5du42Bk6ZYdZw7AqlzEMd6C9PFbrVxDaM4OZgR3UaFPXDB/rjse88Wlj1cS3631MieRTN39eJrykiifJEXzNBjjPxIWtyZAZ5OyHvjrTK2a9ofHnNWyMth88It5b9orj8L7JsStBLnvEpzKNYDblsslFRQsmcAS2XaERAjhpJBpGrZt0g+2ANuPsh96t/bSZSwiKxyziuxoHbu7V4+HAILWbGWwsnHVADuddq7TuWrluQNrTHk23rez5uwMLDttLt87Z5WEvRvR1LcaPMeTfebuqXGzR73mjL4dR4LvGWG4KjwLC4Lwqh6+9oKMEBqfezF2oBXFo8mytqpz46gZNc8vOcqrMaAvTU2PNNLHjleY4KYjYFNcidU1dOkHbQ97nlnP/MjBeDkMfo7gzLPmxvfIDUcaWhdcEM6q9dBlrzNhcoGqfqyOcnOZRS7E1Qe3O1fYT4Z8GLrMW8W1w4O7yMXMg33alPxTNoIQ8l6qxbX8DYhv+bX5O+865iZDzG+zApbomB9yz8VXejWd5FUmt4xlNGCwxOQdaflUgspplBTps7NSCF5NGn24DXwLmRYNFDsO1Elqu3ywBoo+TPpbEGSXahP9yA3xNOtUOsIdfFIHZAkmMxZ4Um1aw9ec2aOD1jrBSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(31696002)(31686004)(2616005)(6666004)(86362001)(38100700002)(186003)(478600001)(110136005)(6506007)(66946007)(6486002)(66556008)(66476007)(36756003)(8676002)(83380400001)(66574015)(6512007)(8936002)(5660300002)(41300700001)(2906002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0N4M2svRm5sWlRoR2t6aERUZkx0OXcxMTV5aWhBbFRYeWFJc1dDWW9VWG94?=
 =?utf-8?B?a1VTalduM1pWN1JBUWFVOHdONHM2TzJSN0tpVi9UQzdtb2k4YTVzdlJBZ05B?=
 =?utf-8?B?T0psd2hKcVR5OFkwRlNCMVlaL3BUNE5Wc012cHhMdFVOcWQ1SkpHOHkyOFZW?=
 =?utf-8?B?aS9ua1dMYldpQnEyNGdhU2Ezamo2UFpWTk5QeFo2YzZFSFlJeEhqZ0U0MmdH?=
 =?utf-8?B?Tk1pL2VjOUsrdUQwdFczbXlBZEVaT0U4U1J4S0g2by8wT3o5VVJtNVZjV080?=
 =?utf-8?B?VTNzSDgxNnUzTjFJdlpoTXI0cUFJZFgraFFLcXhTY2JTeDJFZXhOL1JtN3k2?=
 =?utf-8?B?MEJ1bWdvemkxNWZkenAyTXVDandFRnhQOTE4WlBSdENSVXpteVVwNnEwNEJS?=
 =?utf-8?B?MUd4Q2JoeTFSRDB2QWZsYWozUDZZNVlTbEV5YWVXRWQwZ0FvckJSQmFsVldz?=
 =?utf-8?B?YlF1UDF0SGtsYVBuSVlnaDUzTjVLTCtxRUJRYjJnMlMzZ1YxN3pSMUcxa3hV?=
 =?utf-8?B?cDJBUGFLMGNRVEhYYnc5SGNXdFdEaFE0VW1DdHBBQVVjL0xURzVzM3ZJc0h0?=
 =?utf-8?B?TVRpR2lIK0lFbG1zZkhJUzdKcjA5ZS94aDJSc1QrVnVVVkdORlVxNTBqNUor?=
 =?utf-8?B?cEdLZWI3bU16UVVIaXROV3cxZllwZm9XNm5FUlIzZ0k4dmRHeFloa3FEQnJZ?=
 =?utf-8?B?dGR2Q1lpSXpoNnRSbkFDU2dTYmw1SG5GNHBJb2dmbmJhZWp1SnNIUE5GUmsv?=
 =?utf-8?B?UkRtOVp1RXViR1lnbXd5c0tlcmZWdW13OG9BU3NIRUNvT1graVllY3BFU0h4?=
 =?utf-8?B?dWFKUnFiZXFyaHlqZGNMVDZ4SVIrRFRtNmFyMlZvUkpQL0xGdVJLcm1hOVFm?=
 =?utf-8?B?Y3lvek9SQnJJNXZ0VTRtR3hzZUFkbjYwU0dDU0l0dktaeHduSkR1UVFMNVVy?=
 =?utf-8?B?Q3FJdGc1clFQaTE5a1BIbFJQcVhzeFhjVzdXdFh1WEhQK1VSRUJHZjB0NGdU?=
 =?utf-8?B?V1BzMVVNK1VJZmxJVEovLzUvdXl4d2JLV0JnYnJuUG9EVjVGUUQrVGlzMDRQ?=
 =?utf-8?B?aFNiaElnNkU4WlBlOVpFbWxwQ2YrbjYzMzJQT3VBVXUxbTI1S2ZjZ3hWR2Zr?=
 =?utf-8?B?blRYbG9Dd1h0cFdwQ3RZamVhQk90WTBkQnVubzdUaGZBQTgwRG4vU1hCeWZQ?=
 =?utf-8?B?d2F3SGlsYTdIRnhvZ2dwMTBUamxqckJOL0Q1MDFEQWFvdW53cG1wNkIrUFpx?=
 =?utf-8?B?dU11Vjhkd1RMcmpwbm1Xcmd0UnFBcjQwMGdPRytLTGZYbFJoOWZVcDBHamQ4?=
 =?utf-8?B?TDVLVGNGZmN1Y0xyMGRpQisxQXVyemk2YmxmQitYSjh3TlZ4TXZFZ215Ymd4?=
 =?utf-8?B?QnppbEZYbXF6bCtXb052WlJybnU4eTE2cW11dWdoQjh5elNuK2xrQndGbGNC?=
 =?utf-8?B?U0xYb0VVYXcvNE1EeDFkV09TOEpkcXhSbDZpNXk0RVplTWFSajNtVU5Xckth?=
 =?utf-8?B?SmMxVm1PTXBQM0RaS3draUlTMWVDdkVTZ3UxU1hBRGhhL0VkbDIvZW82ZDQ3?=
 =?utf-8?B?V1o1THpDQ05qeU15NzI3MXpQMklYVTUwc0FUelZVOVp0ajRlTkc0YkxkdW1N?=
 =?utf-8?B?bXh1aE4ySDF2TWFjYWU2TitOZzhFMXByVDBoNjc1OElWVXB4Rzdmayt4Ty9q?=
 =?utf-8?B?eWhFNEsrclYrNVk2dnRTejV2SUxuTk12cTc4eEl0NEtwZGY2N1NRM0xURnlN?=
 =?utf-8?B?NVcvYzJITlNGcWRVdGw0cEFTa0EwNVQyTEo1c2ZuSHgrOEliSzNxM0VaK1Nz?=
 =?utf-8?B?bS9WcnJzTmgxRjZwaEl5cjJvOVBRK3FOT0hOdlJkMUp0eDQ1aGQrQXBWOUpT?=
 =?utf-8?B?c2xjSG5OUWhmZTBjN3FvV3I1Z01keWNreFhIUy95ZUUwUHZUQTczL0VFM2Y4?=
 =?utf-8?B?UStFRWNteDNpbCsxVUNITTJIYm5GeXRCa1J0TmxvM0gxakpQRWtYbUszS1ox?=
 =?utf-8?B?RlJ4WVBpamZ6ekRVUDhaNkpLS0E0ZTJhdnZ5SnNXVVJ5OEI4TllXazNTWWgr?=
 =?utf-8?B?NFJvUWdOR3dIcTF5bjZSZEZSUlo2WVF6QmxkdWxIZVFveFZxYkNqQW9uWWtq?=
 =?utf-8?B?MC9pL0hYbGw2LzdtUXMvY2NZM3M0RFNlc1hQQU4vMlg2RnBzNVVXMUhxREVC?=
 =?utf-8?Q?s2jfcAZtVsU0jzG5YFquP7fn59gi7t60vaNjVK+wBn+R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a675244-16ad-4b81-02b7-08da96220efb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 07:23:45.4325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwmQGBTZ1zZLnFeHP3AbBMr2iOHB+zXLnmfcCodD9aOwDaZ7u43R6HWldfWXmHAc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
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

Am 13.09.22 um 22:52 schrieb Felix Kuehling:
> Am 2022-09-12 um 08:36 schrieb Christian König:
>> Use DMA_RESV_USAGE_BOOKKEEP for VM page table updates and KFD 
>> preemption fence.
>>
>> v2: actually update all usages for KFD
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 26 ++++++++++++-------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |  3 ++-
>>   2 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index f4c49537d837..978d3970b5cc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -298,7 +298,7 @@ static int 
>> amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>>        */
>>       replacement = dma_fence_get_stub();
>>       dma_resv_replace_fences(bo->tbo.base.resv, ef->base.context,
>> -                replacement, DMA_RESV_USAGE_READ);
>> +                replacement, DMA_RESV_USAGE_BOOKKEEP);
>>       dma_fence_put(replacement);
>>       return 0;
>>   }
>> @@ -1391,8 +1391,9 @@ static int init_kfd_vm(struct amdgpu_vm *vm, 
>> void **process_info,
>>       ret = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
>>       if (ret)
>>           goto reserve_shared_fail;
>> -    amdgpu_bo_fence(vm->root.bo,
>> - &vm->process_info->eviction_fence->base, true);
>> +    dma_resv_add_fence(vm->root.bo->tbo.base.resv,
>> + &vm->process_info->eviction_fence->base,
>> +               DMA_RESV_USAGE_BOOKKEEP);
>>       amdgpu_bo_unreserve(vm->root.bo);
>>         /* Update process info */
>> @@ -1989,9 +1990,9 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>>       }
>>         if (!amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) && 
>> !bo->tbo.pin_count)
>> -        amdgpu_bo_fence(bo,
>> - &avm->process_info->eviction_fence->base,
>> -                true);
>> +        dma_resv_add_fence(bo->tbo.base.resv,
>> + &avm->process_info->eviction_fence->base,
>> +                   DMA_RESV_USAGE_BOOKKEEP);
>
> This removes the implicit dma_resv_reserve_fences that amdgpu_bo_fence 
> used to do. Do we need to add back an explicit dma_resv_reserve_fences 
> somewhere here?

I was pondering the same thought. The extra reserve in amdgpu_bo_fence() 
is actually just a workaround. So when this here goes boom we really 
need to fix it in the KFD code.





>
>
>>       ret = unreserve_bo_and_vms(&ctx, false, false);
>>         goto out;
>> @@ -2760,15 +2761,18 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> **ef)
>>           if (mem->bo->tbo.pin_count)
>>               continue;
>>   -        amdgpu_bo_fence(mem->bo,
>> -            &process_info->eviction_fence->base, true);
>> +        dma_resv_add_fence(mem->bo->tbo.base.resv,
>> + &process_info->eviction_fence->base,
>> +                   DMA_RESV_USAGE_BOOKKEEP);
>
> Same as above.
>
>
>>       }
>>       /* Attach eviction fence to PD / PT BOs */
>>       list_for_each_entry(peer_vm, &process_info->vm_list_head,
>>                   vm_list_node) {
>>           struct amdgpu_bo *bo = peer_vm->root.bo;
>>   -        amdgpu_bo_fence(bo, &process_info->eviction_fence->base, 
>> true);
>> +        dma_resv_add_fence(bo->tbo.base.resv,
>> + &process_info->eviction_fence->base,
>> +                   DMA_RESV_USAGE_BOOKKEEP);
>
> Same as above.
>
>
>>       }
>>     validate_map_fail:
>> @@ -2822,7 +2826,9 @@ int amdgpu_amdkfd_add_gws_to_process(void 
>> *info, void *gws, struct kgd_mem **mem
>>       ret = dma_resv_reserve_fences(gws_bo->tbo.base.resv, 1);
>>       if (ret)
>>           goto reserve_shared_fail;
>> -    amdgpu_bo_fence(gws_bo, &process_info->eviction_fence->base, true);
>> +    dma_resv_add_fence(gws_bo->tbo.base.resv,
>> +               &process_info->eviction_fence->base,
>> +               DMA_RESV_USAGE_BOOKKEEP);
>>       amdgpu_bo_unreserve(gws_bo);
>>       mutex_unlock(&(*mem)->process_info->lock);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> index 1fd3cbca20a2..03ec099d64e0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> @@ -112,7 +112,8 @@ static int amdgpu_vm_sdma_commit(struct 
>> amdgpu_vm_update_params *p,
>>           swap(p->vm->last_unlocked, tmp);
>>           dma_fence_put(tmp);
>>       } else {
>> -        amdgpu_bo_fence(p->vm->root.bo, f, true);
>> + dma_resv_add_fence(p->vm->root.bo->tbo.base.resv, f,
>> +                   DMA_RESV_USAGE_BOOKKEEP);
>
> Same as above.

This one here should certainly have an associated dma_fence_reserve_fence().

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>       }
>>         if (fence && !p->immediate)

