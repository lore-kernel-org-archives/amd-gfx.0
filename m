Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F069FC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 15:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E91F10F99E;
	Mon, 18 Mar 2024 15:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uOK//I/e";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7582210F99E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 15:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJYA/3qSMnjxHroJx4Fxc8XRNUpgR9MeilnAjV9b4BQWTwP0qnSZXS2wOxAGYrgQ9kX/rnq2ZzOy1OpD2QXQqJqRGxCn9YIV4FXO0/arfoCClz8R0WxxTvFs0J8uSWjQ1YtmUFeX/GivvbPVeAtllxHpZuqQz3P9sz0UvEnf/K23TDP25ZdsN+vy99ZSTRA3Ra41zu0ygb8PAEzyd4CE1sSd74cJ+y9aEeV21AvSz6ya9qf+wnBNTalYgNA3ABHAZH2Bt0G5NOGnJ7W43VAmV9JIUbUIBrPsiqhEKVDMsWdjVASf4WOtVGvceUV0uSbAheesWgTwvzOgKu12vcsRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DI2pJKRTnklJSvnA/N8EsW9HWXs6EDoJe9ivCKf4sA=;
 b=IpuLueXkXwNnGEPsdQnphIxFUs6ZGB+cZANgPRKOUAC9nvulI2UIjiEBwIE/PmlUNM4qT70XuaD4ineuyKpO4WN6YvnDTTI6Gaiu/V+BR/V12kKnyCi5lYBgDgG+FeKNdE7hsmW+QcckFDBUZNbFKVq+Lk8piaQiqI3211LfOy4IdJoRlo2L6GUP91Q4ltB7qkHHSqwAbhjBm0v4GBBcPH5L7gw3fcQcF/ELiORHmL5N298xiae79hGxHd/tBvoWTAFCWWPwBDbfrKXarahreqX2khCbtUcotnbyBI8fFjUV2B7ljj4kU/RqW2tPmoOkdKndbaRklvwmY6ndKjfzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DI2pJKRTnklJSvnA/N8EsW9HWXs6EDoJe9ivCKf4sA=;
 b=uOK//I/ejKB4lANweEvz8wg+u0bfo8Q/mkInU/FiWkLbaJrBvNS1RoQk5EaaZJJSvCmg13wMmUK/otrC8GsNynt688rQAzsOjrgzl0GIAjpVi4PfAL3yv2SRxRk/bFiduB5pT8YYrt/YUo18HfX0naO9jqF/BMSvzqFWWSATPVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 15:19:48 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 15:19:48 +0000
Message-ID: <1d908e22-d3bb-8a5f-d38b-9912486df5d6@amd.com>
Date: Mon, 18 Mar 2024 16:19:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 1/2] drm/amdgpu: implement TLB flush fence
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240318120837.2011-1-shashank.sharma@amd.com>
 <553b7925-e2bf-4865-b42d-b5fa05f4f508@amd.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <553b7925-e2bf-4865-b42d-b5fa05f4f508@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 99dacc12-4b9c-469a-6ff0-08dc475ed933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wpt5fH3lIiZNPLOjteeszvbDlH4oScB2S8oNsRDyTJDopvKUh68kbpy1GVWNlKdoWlMV4aEsDgVGS0AmKOvWgPBb+8Uf6wAsNnM8LHvmgI2HQNMbC2xzkhdjXJQDgNIYRZli1BY/VPY9aHuO9U1qwWpOhue9s0jDjzx9Z/1tALIHqrqrVb7J+uEMwmxe22CTPQJZn91m+oxmdcTRCcg+Fy4AQsTaieGmMC4eCnSvIIOTpzZBSv8A1MvTR/feeAquqqzViDDay0qWfQmz1187bv8Z+1osnk0E+Yw+MtxqcE6Fn4x7Szx4V2fiN6dy0pF6RLYvy97NTE2UJhq7MMxiygeEbFsIuXt7Ry3ndNDwcdvXKSEH8mm+fu13if0ndBk+QskfFeWz49S8r53IksRylKOkvqA0hpF8Efafn4ivrDNTUs8M0/Si/IpEx2VgWDpaz0gR3Edpevja5I2Xk6jrQZNOYzmK2pGh1mjIDsPC1SYf6kJiCls+hM/TCVDOJbEyB/Oaz+HATzEDSodm8wica5+1dJpzbfH805+cBw6BL5Lp84y6CyBjN9sJb/kcV2yZKyTh0I+VeSx/aAQnjpZ+KMMb/QKantkyK0WJNIC6MGrDUH1fCeIDvUViSZ28qHuix5bKmmc/mogp46/JrRLYNDCYrH4ogpFidk5J3weVkUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFZheWkyMWNEaG1ic296TnFiclpuTmdNclF5eUFZdlZJT1E1d0lIdlZidkFv?=
 =?utf-8?B?QWFQSC9kMmlNYmUycFo2bU5CMlVQRFVldnA2V05GZmN5QzdRbndhRW5YYWtZ?=
 =?utf-8?B?NEFYbWFiWlpwTHlIbmpqZmIza0lIb0d1ditIK3RiN1c5UzBZYnE2Zk5DVVBu?=
 =?utf-8?B?dUZ1eGdyYmFXNjRpNGcrbkpqemhzRlF6Q3FaNmRDNW9NVUdXa05tclduajhY?=
 =?utf-8?B?aUFoOTVMRDI3akV2eE5MT1haa0ZtM2wrQ0FZN3JSV1Y5Y1BJUi8vZGlQQ1Jz?=
 =?utf-8?B?VnB2R0dveGE4MGYzMVNJYjlJZHpxVyswSlVIb24xSEY4MFFUZFlrVWdsWHkv?=
 =?utf-8?B?UzVXZ3kzaEtYdStFOC9TNEdCeWNFUitJVTB4NDM5cmxSRGtYY0pCeEtSbUtO?=
 =?utf-8?B?WmhoVVZEUUQraEtMeTlyUHRKR0gvcS9tSUhCdUlVS1paMXFMMXZOZC9nSmNO?=
 =?utf-8?B?YnpmLzlXY0twUllZZzZ6WUZoYk03aXRFSmlEUlhwdy9NTXZmM29zeFo1d0Y5?=
 =?utf-8?B?Q3Fhc1BsQXFHM1E4R1QvSWJBMlphWXdiZFZTbnJ1anY1LzF6TnB2WExSNUlT?=
 =?utf-8?B?R3VKTW5PTGxUajFlVWxFSlhLa1RyZnd4NGQ2UmJJMEYwNzBacm5hSDJXdlRC?=
 =?utf-8?B?SkRpNEtSV0puYnFuRENDR2hjNmJNYzdXTThtSk5MZ3Evb1lrdUV0M3BuSGJL?=
 =?utf-8?B?a0FpZU1pL0l2Q2hOSzFUbWN2SEluTWNUQ2hncmdlL29tTUVPZGxzODZyclVj?=
 =?utf-8?B?VVJWZUZLaE9KL3pmWWxmcGh4WmFMcm4yU1Naakd2dWRqbzB6Z1N6ZXZPSWZB?=
 =?utf-8?B?b3VZenNMS3lUcVRBQ0hiUzB2TEo2WFRvWE1tWlFMUkc2Rkw2Y0NXeGV3VzYr?=
 =?utf-8?B?NHdvNXc5YmkxL0syWG0yVHNlcjhIY3pxWEJOa3B3YzhwSU9BenJzRy8rMnZZ?=
 =?utf-8?B?a3h2R1dJaTU2dVoyZkZDZC9ZQlcvQkM3N3psNTVtQTJoUllWeGp6L1VOWCth?=
 =?utf-8?B?dUs4amFYdnFkSUplNFlWUThXQktPNmh6b0NOOVVHYTVJT24wc3VIQUpKeHdh?=
 =?utf-8?B?dEU1ekVUaExkcUQ0bTVBQ1Zsb3VCZ0VDOXlsTEpqNDBpM251NkRScExoNEs4?=
 =?utf-8?B?bkpSZmxQTy9PdlRtOGZnMXZXVGdHMkovbHBHUjlTUWxaakFmckFzZk8yd1VB?=
 =?utf-8?B?RHJycUdGVG9jZ0tlbURSQzFMMG80LzRVTU1uNWFTLzErUXA5d3U4b084R01R?=
 =?utf-8?B?d3FHaTViVmdQajA4ZW9LSG8wNHdGSkpsRURkY2sxRGFzdS94UmtJL3VwakNG?=
 =?utf-8?B?Z1lXekhSNlNEaXZ5WkxyaEVCNS8rL084QldtNkNGM1NiOHBBSzdkVkV0ckFR?=
 =?utf-8?B?STV6TThCU0g3WVpuVU9iTGlMeHlZUitkZzZoQ2Y0ZXA5VzhGWkRUWVNSY0tT?=
 =?utf-8?B?UWlQTVh2YlY0OWFGbE5vL0wyOUNySXczaDE2dEFJaVMzNUpaNlVnSWNBaUxU?=
 =?utf-8?B?OXQrVVYzVkFFamcxd1pRQnVLdzZEVStHalc2MkJvbUhzZVZOeTFKakNxR0FZ?=
 =?utf-8?B?TkdFa0c0MTIzb3laUWpjc2preTNGNy81Wnk3TnhHQUM4dTk0OGdhQjF4U2o4?=
 =?utf-8?B?TllMeEJoSElUSnNaN0c3czI5YkNQUzVSZGQ1NmVIdEtJcDdXWUpoSkVXMmUx?=
 =?utf-8?B?VlhKc3oyLzF1OGJET1BGWFFGUGsvb1Z4ZExVUTNSelh0U2hTaElYV0NKTnBu?=
 =?utf-8?B?WWZCL0FlVzY5RWZwSk8vN2txMGI2R0V6MkdORVhtQ242NnBWNVJ6RVRWYUJr?=
 =?utf-8?B?S1lnUkplZXJJTmJwaGFPTk80WFhzYWZxT2VUaDVVTzUwT3pjZnBlUDVQbGU4?=
 =?utf-8?B?TnJGOVhmVmhMUFVHL1pUcHlWcXltSU9TR2F1TUxHYUhFM1kxOU14SjFubHds?=
 =?utf-8?B?K2YvbkYxTWI3ZnVpZitRZ2ZRZnhCSDM2UDlLWFBHQTJIN1lpTVA0YS9nVGZ0?=
 =?utf-8?B?SEVFL3Y3UnRIU0N1b21oRGJ6bkV0VGsyZjgwcWdidWlJRURrb0R1RlNDcHVq?=
 =?utf-8?B?K2djRkhzbGUyV2VqL3F6TUZYVERSZkZPV3IzN3dnRlc3VzBheVhkU1BoaE92?=
 =?utf-8?Q?51De//ddgUsunI4z+6VJr/TDR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dacc12-4b9c-469a-6ff0-08dc475ed933
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 15:19:47.9035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3s59Mxu7AeMUro03h+3vA2m5M/wwpohMUJmzodwbThaHVPTeo4DDcB8DZ6m9f99qkuZfGGtCe7zXE2lYU+Coxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
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


On 18/03/2024 15:58, Christian König wrote:
> Am 18.03.24 um 13:08 schrieb Shashank Sharma:
>> From: Christian Koenig <christian.koenig@amd.com>
>>
>> The problem is that when (for example) 4k pages are replaced
>> with a single 2M page we need to wait for change to be flushed
>> out by invalidating the TLB before the PT can be freed.
>>
>> Solve this by moving the TLB flush into a DMA-fence object which
>> can be used to delay the freeing of the PT BOs until it is signaled.
>>
>> V2: (Shashank)
>>      - rebase
>>      - set dma_fence_error only in case of error
>>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>>      - use vm->pasid when f is NULL (Mukul)
>>
>> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>>      - move the misplaced fence_create call to the end (Philip)
>>
>> V5: - free the f->dependency properly
>>
>> V6: (Shashank)
>>      - light code movement, moved all the clean-up in previous patch
>>      - introduce params.needs_flush and its usage in this patch
>>      - rebase without TLB HW sequence patch
>>
>> V7:
>>     - Keep the vm->last_update_fence and tlb_cb code until
>>       we can fix the HW sequencing (Christian)
>>     - Move all the tlb_fence related code in a separate function so that
>>       its easier to read and review
>>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  68 +++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   4 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 ++++++++++++++++++
>>   7 files changed, 171 insertions(+), 30 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 4536c8ad0e11..f24f11ac3e92 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o 
>> amdgpu_kms.o \
>>       amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>> -    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>> amdgpu_pll.o \
>> +    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
>> +    amdgpu_ib.o amdgpu_pll.o \
>>       amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>> amdgpu_virt.o \
>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 81fb3465e197..26f1c3359642 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -885,6 +885,40 @@ static void amdgpu_vm_tlb_seq_cb(struct 
>> dma_fence *fence,
>>       kfree(tlb_cb);
>>   }
>>   +static int
>> +amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params, struct 
>> dma_fence **fence)
>> +{
>> +    struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>> +    struct amdgpu_vm *vm = params->vm;
>> +
>> +    if (!fence || !*fence)
>> +        return 0;
>> +
>> +    tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
>> +    if (!tlb_cb)
>> +        return -ENOMEM;
>
> That won't work like this. The page tables are already updated, so you 
> need to have the callback no matter what.
>
> That's why the code previously allocated the tlb_cb structure before 
> updating the page tables.


I could see from the previous code that there was also handling of cb 
being OOM, but I think your point is 'do not start the PT update until 
we have memory for callback', so I will accommodate that.

- Shashank

>
> Regards,
> Christian.
>
>> +
>> +    tlb_cb->vm = vm;
>> +    if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
>> +                    amdgpu_vm_tlb_seq_cb)) {
>> +        dma_fence_put(vm->last_tlb_flush);
>> +        vm->last_tlb_flush = dma_fence_get(*fence);
>> +    } else {
>> +        amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>> +    }
>> +
>> +    /* Prepare a TLB flush fence to be attached to PTs */
>> +    if (!params->unlocked && vm->is_compute_context) {
>> +        amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>> +
>> +        /* Makes sure no PD/PT is freed before the flush */
>> +        dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>> +                   DMA_RESV_USAGE_BOOKKEEP);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * amdgpu_vm_update_range - update a range in the vm page table
>>    *
>> @@ -917,7 +951,6 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>                  struct dma_fence **fence)
>>   {
>>       struct amdgpu_vm_update_params params;
>> -    struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>>       struct amdgpu_res_cursor cursor;
>>       enum amdgpu_sync_mode sync_mode;
>>       int r, idx;
>> @@ -925,12 +958,6 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>       if (!drm_dev_enter(adev_to_drm(adev), &idx))
>>           return -ENODEV;
>>   -    tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
>> -    if (!tlb_cb) {
>> -        r = -ENOMEM;
>> -        goto error_unlock;
>> -    }
>> -
>>       /* Vega20+XGMI where PTEs get inadvertently cached in L2 
>> texture cache,
>>        * heavy-weight flush TLB unconditionally.
>>        */
>> @@ -948,6 +975,7 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>       params.immediate = immediate;
>>       params.pages_addr = pages_addr;
>>       params.unlocked = unlocked;
>> +    params.needs_flush = flush_tlb;
>>       params.allow_override = allow_override;
>>         /* Implicitly sync to command submissions in the same VM before
>> @@ -961,7 +989,7 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>       amdgpu_vm_eviction_lock(vm);
>>       if (vm->evicting) {
>>           r = -EBUSY;
>> -        goto error_free;
>> +        goto error_unlock;
>>       }
>>         if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>> @@ -974,7 +1002,7 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>         r = vm->update_funcs->prepare(&params, resv, sync_mode);
>>       if (r)
>> -        goto error_free;
>> +        goto error_unlock;
>>         amdgpu_res_first(pages_addr ? NULL : res, offset,
>>                (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &cursor);
>> @@ -1024,29 +1052,18 @@ int amdgpu_vm_update_range(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>           tmp = start + num_entries;
>>           r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>>           if (r)
>> -            goto error_free;
>> +            goto error_unlock;
>>             amdgpu_res_next(&cursor, num_entries * 
>> AMDGPU_GPU_PAGE_SIZE);
>>           start = tmp;
>>       }
>>         r = vm->update_funcs->commit(&params, fence);
>> +    if (r)
>> +        goto error_unlock;
>>   -    if (flush_tlb || params.table_freed) {
>> -        tlb_cb->vm = vm;
>> -        if (fence && *fence &&
>> -            !dma_fence_add_callback(*fence, &tlb_cb->cb,
>> -                       amdgpu_vm_tlb_seq_cb)) {
>> -            dma_fence_put(vm->last_tlb_flush);
>> -            vm->last_tlb_flush = dma_fence_get(*fence);
>> -        } else {
>> -            amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>> -        }
>> -        tlb_cb = NULL;
>> -    }
>> -
>> -error_free:
>> -    kfree(tlb_cb);
>> +    if (params.needs_flush)
>> +        r = amdgpu_vm_tlb_flush(&params, fence);
>>     error_unlock:
>>       amdgpu_vm_eviction_unlock(vm);
>> @@ -2391,6 +2408,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm,
>>         mutex_init(&vm->eviction_lock);
>>       vm->evicting = false;
>> +    vm->tlb_fence_context = dma_fence_context_alloc(1);
>>         r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>>                   false, &root, xcp_id);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 8efa8422f4f7..b0a4fe683352 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -257,9 +257,9 @@ struct amdgpu_vm_update_params {
>>       unsigned int num_dw_left;
>>         /**
>> -     * @table_freed: return true if page table is freed when updating
>> +     * @needs_flush: true whenever we need to invalidate the TLB
>>        */
>> -    bool table_freed;
>> +    bool needs_flush;
>>         /**
>>        * @allow_override: true for memory that is not uncached: 
>> allows MTYPE
>> @@ -342,6 +342,7 @@ struct amdgpu_vm {
>>       atomic64_t        tlb_seq;
>>       struct dma_fence    *last_tlb_flush;
>>       atomic64_t        kfd_last_flushed_seq;
>> +    uint64_t        tlb_fence_context;
>>         /* How many times we had to re-generate the page tables */
>>       uint64_t        generation;
>> @@ -611,5 +612,8 @@ void amdgpu_vm_update_fault_cache(struct 
>> amdgpu_device *adev,
>>                     uint64_t addr,
>>                     uint32_t status,
>>                     unsigned int vmhub);
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>> +                 struct amdgpu_vm *vm,
>> +                 struct dma_fence **fence);
>>     #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> index 6e31621452de..3895bd7d176a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> @@ -108,7 +108,9 @@ static int amdgpu_vm_cpu_update(struct 
>> amdgpu_vm_update_params *p,
>>   static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>>                   struct dma_fence **fence)
>>   {
>> -    /* Flush HDP */
>> +    if (p->needs_flush)
>> +        atomic64_inc(&p->vm->tlb_seq);
>> +
>>       mb();
>>       amdgpu_device_flush_hdp(p->adev, NULL);
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 124389a6bf48..601df0ce8290 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -972,7 +972,7 @@ int amdgpu_vm_ptes_update(struct 
>> amdgpu_vm_update_params *params,
>>               while (cursor.pfn < frag_start) {
>>                   /* Make sure previous mapping is freed */
>>                   if (cursor.entry->bo) {
>> -                    params->table_freed = true;
>> +                    params->needs_flush = true;
>>                       amdgpu_vm_pt_free_dfs(adev, params->vm,
>>                                     &cursor,
>>                                     params->unlocked);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> index 349416e176a1..66e8a016126b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> @@ -126,6 +126,10 @@ static int amdgpu_vm_sdma_commit(struct 
>> amdgpu_vm_update_params *p,
>>         WARN_ON(ib->length_dw == 0);
>>       amdgpu_ring_pad_ib(ring, ib);
>> +
>> +    if (p->needs_flush)
>> +        atomic64_inc(&p->vm->tlb_seq);
>> +
>>       WARN_ON(ib->length_dw > p->num_dw_left);
>>       f = amdgpu_job_submit(p->job);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> new file mode 100644
>> index 000000000000..51cddfa3f1e8
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include <linux/dma-fence.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_gmc.h"
>> +
>> +struct amdgpu_tlb_fence {
>> +    struct dma_fence    base;
>> +    struct amdgpu_device    *adev;
>> +    struct dma_fence    *dependency;
>> +    struct work_struct    work;
>> +    spinlock_t        lock;
>> +    uint16_t        pasid;
>> +
>> +};
>> +
>> +static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence 
>> *fence)
>> +{
>> +    return "amdgpu tlb fence";
>> +}
>> +
>> +static const char *amdgpu_tlb_fence_get_timeline_name(struct 
>> dma_fence *f)
>> +{
>> +    return "amdgpu tlb timeline";
>> +}
>> +
>> +static void amdgpu_tlb_fence_work(struct work_struct *work)
>> +{
>> +    struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
>> +    int r;
>> +
>> +    if (f->dependency) {
>> +        dma_fence_wait(f->dependency, false);
>> +        dma_fence_put(f->dependency);
>> +        f->dependency = NULL;
>> +    }
>> +
>> +    r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
>> +    if (r) {
>> +        dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
>> +            f->pasid);
>> +        dma_fence_set_error(&f->base, r);
>> +    }
>> +
>> +    dma_fence_signal(&f->base);
>> +    dma_fence_put(&f->base);
>> +}
>> +
>> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>> +    .use_64bit_seqno = true,
>> +    .get_driver_name = amdgpu_tlb_fence_get_driver_name,
>> +    .get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>> +};
>> +
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm,
>> +                struct dma_fence **fence)
>> +{
>> +    struct amdgpu_tlb_fence *f;
>> +
>> +    f = kmalloc(sizeof(*f), GFP_KERNEL);
>> +    if (!f) {
>> +        /*
>> +         * We can't fail since the PDEs and PTEs are already 
>> updated, so
>> +         * just block for the dependency and execute the TLB flush
>> +         */
>> +        if (*fence)
>> +            dma_fence_wait(*fence, false);
>> +
>> +        amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>> +        *fence = dma_fence_get_stub();
>> +        return;
>> +    }
>> +
>> +    f->adev = adev;
>> +    f->dependency = *fence;
>> +    f->pasid = vm->pasid;
>> +    INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>> +    spin_lock_init(&f->lock);
>> +
>> +    dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
>> +               vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
>> +
>> +    /* TODO: We probably need a separate wq here */
>> +    dma_fence_get(&f->base);
>> +    schedule_work(&f->work);
>> +
>> +    *fence = &f->base;
>> +}
>
