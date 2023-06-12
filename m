Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AC5C7EE25
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 09:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA85210E1EB;
	Mon, 12 Jun 2023 09:42:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B126310E0B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 09:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkzGjNOoVjPY+C2F57PIeEjf2GuJYoXyFwdNP1zVHO00AUzQxrfKUCqDE61QgKtrCrDXGVNMmR3oQSOkY2lo/kHXpLpQpVjd03ZzhFbnfNnmwJLG18HqTHNRMBT7oFDq4C67s8iTOZctNXNwBcAGJzrBtDn8UzXa/tcOGBUvo/BSseEMhtsSylOboTSJERiAqfWmtuUUXHb+InvJcgXhC0tMIQUSBi43ccio0nsph7F6po5FmCGgSappjdBnbFwR2+Di+80fzSDtUXUxdBQI+1cxhirLPpm1ZCFhEzeUO4VMze+Ysf3TAgqeOYuuE1qUbVHAUlix/acKnx7KFy7O4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFqISwehn9IIBITvO4kk75gXGauZvOxYuzkg7mP5zYE=;
 b=lEYZ7WfYufI4ZN/jgimfE3pdYvowxm98Y7ZAVq+ZOMFmStK+nTL2jXH0WC62kBgsnufKZSsQdBsTibSOjw6lk4cer5kK3/yGP/WzetxMZ/Ln5MpJcFAXWwAKOt17fI1SC7EnXLblyD/sf0Ea/8Sf1Se3zxAyzbDpK0FGY6BpnEjeFbrebeQ07l9PcZYnDQTCdfooHmjXjCOckMlTLyvchqPkLHzjtYtUkvHjZYY8Rbd+qko6HMQ1MFhIujDfxex2vWDx8+hlwThoJc5f7ZHz+YdME/58nhhz1xvDUkdb5AEBJh44D3w3/aOyJElWy1zGUhgHFahiIUd8paVSpKaT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFqISwehn9IIBITvO4kk75gXGauZvOxYuzkg7mP5zYE=;
 b=oBaNXByD1yVt3zvQUQZOugT1VqoIZEU8hv15RFp95PVRC0yZi/A985v/ddBevFu2hAity72zAkJnnRa80/NNZguiwjaM4/NMGReA8IGV9yLZmOOj5hoG8a0hKnMzbB7NsDMhDDby6U8yu1OGZAOlKxE2nd6fdrJjkIhL43/96d8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 09:42:44 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 09:42:44 +0000
Message-ID: <4944d628-d0b1-63cb-41ef-c9222ca58d67@amd.com>
Date: Mon, 12 Jun 2023 11:42:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC] drm/amdgpu: flush gpu tlb using sdma ring
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230609100257.900-1-shashank.sharma@amd.com>
 <DM5PR12MB2469B9F1325438F0C91F8DCCF154A@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <DM5PR12MB2469B9F1325438F0C91F8DCCF154A@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c68e4f3-7843-4938-53fe-08db6b295f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4/QVN0YX+HQtCB7Sxo3dJkzMqjRh9a11EkQuMJSST27h7hSdc1sUQPZgAohMFAvAu7soLDJx6qW0Z25wOdsfOQ0UkEflO2gd4K+hNvdiNddr8ft/c4g1AkypVlpnaVlRUM6PkHGh+mKjnN/iYb+Sh8B9W+I9TYlfWaoUyATv+xXd/8RYUrH36Qnr4k3lsM1JiPRKf6XJH/FqUNsm5MkREqi5ezcxIZdvPBTehPDc18+hmQisbSoEhmrqmmtloFKS8RXavB027n+r/QZQ0pMYwDcQb0lXlPwmuv3KUxoiizLzsNpVE5PYGNhO08DF8CpVqJGLtkrCbqCgf1LX36uKROyD12cQX9kYYb7aF7yMZR293l6gcZZ6FK0VCb14F4dvowbiLBX33rlK0+QycCfPZOZC+t8xErVOJLMNTBqT9scfpyrwls9KF/yfg+nmajzpXfmC5nTnKgotLVg6q2CUWwDL05bk3XRkbm79RrJ8AWBZMQW1uQkkAuppgR9ig9M4bYlJHEDwS2TFEOT01qI48rpnwdBedvPEoKahgxQPfgQkHQM+cVpd1zYiiGKJQd83Kp+/pdRh1okfQyz4vuaRg0YXjol98PzNwQZnmYg9lZI8w9beP/ZP3kvy4CQHkvFAgx5d3httY/bp5GjTT2rBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(53546011)(6512007)(26005)(2616005)(6506007)(83380400001)(186003)(31686004)(6666004)(66946007)(6486002)(66556008)(66476007)(2906002)(41300700001)(38100700002)(36756003)(44832011)(5660300002)(8936002)(8676002)(110136005)(54906003)(478600001)(316002)(86362001)(31696002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXBFZ1hvVmNnbmlxcWp6MUhWNHdLK0VqbDUwU3pubU03RWVhejg0NlZEb0Rt?=
 =?utf-8?B?UlJpWmxoSy8xdVIyQ3dMdWJjV25kVEU4YUU1RmZmb3NNV1Jpb1R4OTdhRWJ3?=
 =?utf-8?B?SFV0ZUxjS3lyMk0yRkJyWk1PYTdrTzFUN2k2Qm5UbGp1L3BHN0JINEZsclJU?=
 =?utf-8?B?SUhOemlHMHpWcVFSa0hTY2JVTktaZCszTDE2NU1EcmYwTWM4QlE1RHl5VG9K?=
 =?utf-8?B?T0tkWUMyd09hbVpEemZsOE5YS1JMNUhidSsrOEJlQkZyNExvZXJjRmFPL1p6?=
 =?utf-8?B?YU9TUWppQk9NcVF2by9YT2U1eVB0a3B4QUJKcmhmS2dRUzRhalBZVWExdzNl?=
 =?utf-8?B?TnFUSGNkTU45Y3RpYytwUEFMMFpMUFZOaXNsdVBTcVdUUW5odHduVTcxQ2Jn?=
 =?utf-8?B?a2dtVEtPaTRnVkgvc1p0OEZiUEIrejhYODZYRXFEd0tYOWUwcTA0bWQrbFg5?=
 =?utf-8?B?US9qcGRjaHV6TkFJL0M3L053TlpLWjNEVU5WYmRHVDFEZUFGcjBOeFRCQVZ5?=
 =?utf-8?B?Y284NWNUQWZSblZVcDZVWDBIN0gvZVpvbTI1L2NhYWRiNW85Z3dLMWdERUUr?=
 =?utf-8?B?UHA1STlBcStrSU5UcFhyN0JadGZhck5PV05XNldXU3g2ZitJcUdjTEVpOUNa?=
 =?utf-8?B?R283V1owcENFSTV0dEFGc2ZtT1pRZlM0aG8rQndxNlVnSlNpN1VQZndYU3NG?=
 =?utf-8?B?ak5HWnREeHZjNFNyUlhaUnhzNkxtSkhxaFA2NWN2MTlIbXhkdXpSWWM5dFFK?=
 =?utf-8?B?cVRXOGxPandOaVdBSnF4TTE4R1kxWVQ0cTRPNWI0RHM2S2lyTE8rdlI2NUg3?=
 =?utf-8?B?T2g3eWNtekdIR3RSQm90SUkrNlhvbm01RHlsSW9pK3F3aFRMUWFLQXJWSEhj?=
 =?utf-8?B?ckx1Qzhtb0U1ZDIwUU1sYStUdVRLWWlYZUF3NU85b0xpVVdqWHNaVFI2TjZF?=
 =?utf-8?B?Yk9hOWplOVZLMmhIZ1VPNWtzMGVKeHViY3lDTzh3ZWpOM1JtTE5xQnFRRmlV?=
 =?utf-8?B?dHhhMFl1SkJ2Q0t0aWZuZjlzRGRQRE45eWx2UjBkTDhvaGw2TjRIUWFWRktl?=
 =?utf-8?B?TXlpSUh2VWtHaUZMTFo5MFByM2xOcFdJa2N5bXlMREo1VXRsK0lCMU9vMTc0?=
 =?utf-8?B?MDlBSDR5bUltbitnZ0RrcUZjeEN5Y0xQa2txVDgyUUZFd0RqRGNCcUNQODBY?=
 =?utf-8?B?a01ZeFdxYWtlbVN1MjV0dnRKQzZlYlNUZjFBUVY2Q3dVNlA5L0gyc1BRVFhG?=
 =?utf-8?B?MVNiNFNRNVBoRyszWGRhN3FoZFVoQ2d5TFhGL0xIRDhmUGVDSHc0UTd4N2RF?=
 =?utf-8?B?TSt0VlBzdkFkNkVRK01nVStVK1FNL3J3SzB4SHZEU0l3b1o5aUtQbTNVYVFC?=
 =?utf-8?B?dS8rMjNEbzQydHNTOHVUQnM3N0J4WXErRG5MR09YMVNXS3BhUGdNUXlvR2lT?=
 =?utf-8?B?bjFGbm8yODF4V1gyWkN2WDJNNDRwOGZucXhORU1xSkdvNzZmVU9jUDlKQU5r?=
 =?utf-8?B?Q3NFN3pDclowWVJ5aGhmdWtHOVBQaW1Qbll3QmlDQk1VWlRMcTdld3hRUVg5?=
 =?utf-8?B?ZE1hbmpNRHRwbU9pd0lIZkFxYmIyMytGbjlDMXpLV25wL1Y4ZFNqVStTVnlt?=
 =?utf-8?B?bmdXZ0p0TlZ4c2xYNWdIMDhqWTE3OW9sQ2RBUytzOHhEaEJsN1prR3NRdG8x?=
 =?utf-8?B?NElJZE8xV0tockduRFBoWVVrNTZWUGFTUCszZkZNRUVwbzR5RE5oS3FOdkg3?=
 =?utf-8?B?NC9oUGF5MDU5bkZKZzQ2c3JTdXBKaVpXSTV6R1dBS1NWQndLUFFveGhyd3NU?=
 =?utf-8?B?eFBUVE4zclVXeC85d0pjYWZBbE90dW9XWktiZ1NZY0ZNcXRodzFNZm84REdM?=
 =?utf-8?B?b09BdDZhQThWdXMxUVBDSm5EaUpLNGlHMmxBQ3hncHh3YWd0aCt3dDRLUUQr?=
 =?utf-8?B?a29vbHZ6VHhXRkdkdU16Y3hZQU4wa0IyRjhpSTZ0U1paV3BRa1AwdGhNRTgy?=
 =?utf-8?B?My8xVG01MVgvS3pmQ29IT2RaZDB3Vm56VXBQS05TRzJnTWdzaWFzQU8xd1NI?=
 =?utf-8?B?RjJxaFVmeWJSTGFIV1l1Q3BZRGZGRGYzRVV4U3JEek1PZzhZUFBBS25USE1X?=
 =?utf-8?Q?PW/H4GIe3QMcQb2AZcq5A5QJ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c68e4f3-7843-4938-53fe-08db6b295f10
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 09:42:43.9325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iawoYqgY9GzJ/Sr/VgrxM0SUEsDiX7L+bAyrM7wJVj7oEzWQoEjEM79FQ4aIc1dXdu3ls4JisHa9KoY+H9V6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Guchun,

Thanks for your comments.

On 12/06/2023 08:52, Chen, Guchun wrote:
> [Public]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Shashank Sharma
>> Sent: Friday, June 9, 2023 6:03 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Somalapuram, Amaranath
>> <Amaranath.Somalapuram@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Sharma, Shashank
>> <Shashank.Sharma@amd.com>
>> Subject: [RFC] drm/amdgpu: flush gpu tlb using sdma ring
>>
>> This RFC patch moves the code to flush TLB using SDMA ring to a different
>> place like a separate function. The idea is that KFD/KGD code should be able
>> to flush GPU TLB using SDMA if they want to.
>>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41
>> ++++++++++++++++++++++++
>> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 36 +++++----------------
>>   3 files changed, 50 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> index 231ca06bc9c7..20a5dad32bfc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> @@ -30,6 +30,47 @@
>>   /* SDMA CSA reside in the 3rd page of CSA */  #define
>> AMDGPU_CSA_SDMA_OFFSET (4096 * 2)
>>
>> +/**
>> + * amdgpu_sdma_flush_tlb - flush gpu TLB using SDMA ring
>> + *
>> + * @adev: amdgpu device pointer
>> + *
>> + * return: returns dma fence which must be put by caller
>> + *
>> + * The SDMA on Navi has a bug which can theoretically result in memory
>> + * corruption if an invalidation happens at the same time as an VA
>> + * translation. Avoid this by doing the invalidation from the SDMA
>> + * itself.
>> + */
>> +struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev) {
>> +     int r;
>> +     struct dma_fence *fence;
>> +     struct amdgpu_job *job;
>> +     struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>> +
>> +     mutex_lock(&adev->mman.gtt_window_lock);
>> +     r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
> I guess this patch needs to be reworked on top of recent entity rename to high_pr code.

Probably, my code was based on V6.3, I might have to fast forward.

- Shashank

> Regards,
> Guchun
>
>> +                                  AMDGPU_FENCE_OWNER_UNDEFINED,
>> +                                  16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
>> +                                  &job);
>> +     if (r)
>> +             goto error_alloc;
>> +
>> +     job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
>> +     job->vm_needs_flush = true;
>> +     job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>> +     amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>> +     fence = amdgpu_job_submit(job);
>> +
>> +     mutex_unlock(&adev->mman.gtt_window_lock);
>> +     return fence;
>> +
>> +error_alloc:
>> +     mutex_unlock(&adev->mman.gtt_window_lock);
>> +     return NULL;
>> +}
>> +
>>   /*
>>    * GPU SDMA IP block helpers function.
>>    */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> index fc8528812598..c895948f6e82 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> @@ -130,5 +130,6 @@ void amdgpu_sdma_destroy_inst_ctx(struct
>> amdgpu_device *adev,
>>           bool duplicate);
>>   void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device
>> *adev);  int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>> +struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev);
>>
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index ab2556ca984e..0bfaee00a838 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -52,6 +52,7 @@
>>   #include "athub_v2_1.h"
>>
>>   #include "amdgpu_reset.h"
>> +#include "amdgpu_sdma.h"
>>
>>   #if 0
>>   static const struct soc15_reg_golden golden_settings_navi10_hdp[] = @@ -
>> 333,9 +334,6 @@ static void gmc_v10_0_flush_gpu_tlb(struct
>> amdgpu_device *adev, uint32_t vmid,  {
>>        struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>>        struct dma_fence *fence;
>> -     struct amdgpu_job *job;
>> -
>> -     int r;
>>
>>        /* flush hdp cache */
>>        adev->hdp.funcs->flush_hdp(adev, NULL); @@ -378,34 +376,16 @@
>> static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t
>> vmid,
>>                return;
>>        }
>>
>> -     /* The SDMA on Navi has a bug which can theoretically result in
>> memory
>> -      * corruption if an invalidation happens at the same time as an VA
>> -      * translation. Avoid this by doing the invalidation from the SDMA
>> -      * itself.
>> -      */
>> -     r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
>> -                                  AMDGPU_FENCE_OWNER_UNDEFINED,
>> -                                  16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
>> -                                  &job);
>> -     if (r)
>> -             goto error_alloc;
>> -
>> -     job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
>> -     job->vm_needs_flush = true;
>> -     job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>> -     amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>> -     fence = amdgpu_job_submit(job);
>> -
>>        mutex_unlock(&adev->mman.gtt_window_lock);
>>
>> -     dma_fence_wait(fence, false);
>> -     dma_fence_put(fence);
>> -
>> -     return;
>> +     fence = amdgpu_sdma_flush_tlb(adev);
>> +     if (fence) {
>> +             dma_fence_wait(fence, false);
>> +             dma_fence_put(fence);
>> +             return;
>> +     }
>>
>> -error_alloc:
>> -     mutex_unlock(&adev->mman.gtt_window_lock);
>> -     DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
>> +     DRM_ERROR("Error flushing GPU TLB using the SDMA !\n");
>>   }
>>
>>   /**
>> --
>> 2.40.1
