Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C84CA0EEB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 14:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D06110E247;
	Tue, 12 Sep 2023 14:10:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B00FF10E231
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 14:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5P4ex6W3n1RczvWmLBnmWA3AargziDgwDXir1rgWeLHOM+Brk9f+eVGZiv6BUnbkG68m1eO/0vW7ecSY9EP8XL4ToypEKNgtiHGN/XGiP+zw7dztRd75pzlLogmC3JsBAtQ5uF1BL0TDRax7SG/tEXG+r1XptYXSoP1q9BhYNj1saiQBIRVMY3kJc6xWqbaZrJ2S8EplEGCim0IUrBdmbxr10pCHMrp3d+3WTt7lL/F9cOKbETe05TYlqCFKzcWETC1JknjqlWPpvMiyqkl19MXDjE7UtkCHrI+GfB3BUnnluIAU+sqQoO5qY3Et7O3lycswTSMStNd2aC0Gk1MtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXeXYb7dMzn73BFB3qBpCzZ4929AmttUhNlcOiG5W98=;
 b=jyUdqG2OpkaWXDvI3PONDA9SLZrckAhOoOue42RAaJi6GAz9zirYQdLl8EfkNLdWDxybBcl2Q3aznRCsuZXg+KSXq4Rz9pd5zmveBWtfTa3j3z7BIOR4k5KtuHHT4q34goEK6eldi1ZCo/SBraHuw1EP72uh6skzoglYPKPq0cXPfNTLDY52+/s0IFxWhTLWRDylTzEulTqhL4Ufi6UNNaG1uedKj27axwNwIwCPmSgo6N5BAJI3yffhTdnvHNY3JIr/rhqYLIJpGQr91ZIILMW6lJHoqGnKdFIzXvreuBlTCLaDFSwJRzko9m+c0nNGWnaSov4wheJau95K5s67jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXeXYb7dMzn73BFB3qBpCzZ4929AmttUhNlcOiG5W98=;
 b=Rp8mbQwhRcwbNFOyhdPHFwyxW+y0+DCC3v3dBoaniFqNtXFPaC+rqtCW1ab1H4gKaE+hEQ3Gkk75TyhIQXfHYQjjp2s5B4Hz0RyrQOZZ2XknSdrZo5MBR1kwhJ9pVCIp+sdn0mkfkduz/1Xg4hHt2j5Yy5Rb3bijVq+jCIvl8JM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 14:10:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 14:10:51 +0000
Message-ID: <b4b8ac85-deaa-9943-b48e-9ff2152af0e8@amd.com>
Date: Tue, 12 Sep 2023 10:10:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 02/11] drm/amdgpu: rework gmc_v10_0_flush_gpu_tlb
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-3-christian.koenig@amd.com>
 <bd980fec-3844-1338-7ef1-20c41481e33d@amd.com>
 <824f66b8-7dc7-9141-801c-a290164d7c11@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <824f66b8-7dc7-9141-801c-a290164d7c11@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: b108a1d9-daa8-4391-4226-08dbb39a11f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brFPesVUpqxxaZQht1sVYjtcNe3WTezM0Z+XLf0+mcYOgug0H2asQS8MUk4ABdfN8LfqgjucJSEVnNq7C9zKf8cpF4UOWw/xOpNjz18C6VCToQ9zTjTB1q39lQSGLz/LG3BTsVxYNahV2r0Ay6Ivmg3XtFdx1kgmpWCLMS5sri7kfbpwpo+oLAoOPDPAfSlybplUofr2tpozd1e7vpUFsOjlRYHUMZ8JWPa4dkYRuMWErDoPcNW/dwheCe9WmSipYdkf4b5BDFSsnqPaSW7t9PQSdnjd3ZVm9prfuv0xmg9H31bO7aGJp2d/qP63OkQeQVpJ+PLKs3z2cD66o13mi+DplkNXnFnKfeqxiEn5os28vhJlSoRNp77l25CcX9VRYGaUEyCg2gsjRE0vgwJ8fe6y5rTNzuvIw+r9CUH/YFg5NEmJVHjdWdbljzhy3AHqQ7OujeABWwG05UqZE2boABHdy8TnJ/MkATjKtgSlG20NQT+8g0WIvVA+crmvJ+n2Ah+AGvJ6lAU365cuHP25l0YKDr0cFV20gUmE6UaHPgp1cPayy2aeMWCBB6ppeoykBOq2ar7EgQU7kYpDbeyUYDsyHrleaYHe0o+7QrOxzS02/dAN1Gx/NBgXKmkBEKvB27OcjxAsLx+Fx1CdT93Mjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(186009)(1800799009)(451199024)(6506007)(6666004)(53546011)(6486002)(6512007)(83380400001)(478600001)(41300700001)(2616005)(66574015)(66946007)(66476007)(2906002)(44832011)(8936002)(66556008)(4326008)(316002)(5660300002)(8676002)(26005)(86362001)(30864003)(31696002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFYvbUVHeDZ2Z1p1VjFuQ0ZLN053cXVqZnNrVWNTSWdaTlVSK3ZXM1lXOFFV?=
 =?utf-8?B?TWNkRVdDZENPQUE5alQ3UndCekN3d2tzQ3VtK0N5a1lPMFdlek1Yd2o0d0tL?=
 =?utf-8?B?WFNoVFNYU1JEcjZOY0lHaVdPdGpZTFBkWko4bHc4bDJUOVkwbU84ekRYNVB1?=
 =?utf-8?B?b0FwRFdyK0hWYnkvSnVJR1J1Y0tEd3NocGNJbGFmeEFOOXlOcldJVnkyOWNO?=
 =?utf-8?B?R2lFcEY3R1U0aWNsZFRURXFqdGxFS215VmxUaTl5d01nNUF6OEdYK2ZVTnRx?=
 =?utf-8?B?UUdBMW9mWVBycGJDbm02NUliUUNXQ3ZJZzcxREFtRll6ZjdLdi9HZWhBNVNk?=
 =?utf-8?B?ZlpIUkdUUHEvK3pOWXhReW9mZmU4YVpJdDBrMHJYcWxSR05kck9tVGFuUU13?=
 =?utf-8?B?TEx0VnJUM2JRYnNiSmdRakl0WHdLN2J3cGRKbzlvcTBxVlFLZmdsNmlFemkr?=
 =?utf-8?B?T1hudXpVYUJUUStTR0U0azNPNUEwa3JUMzNQU2hKWGNDc21jaFVqL2UvQjYv?=
 =?utf-8?B?L0RndFR3clRVM3pXalJ4ek0zY2RFYjBDT0dqUm9iMjhlT3dSNVR5UmVTQU9D?=
 =?utf-8?B?R2xtZG9XYkh2b3BhMUd1eU5WNWJZK2s2d2FENzZyNXBtM3FucGhIMmxSMmlr?=
 =?utf-8?B?ckJ4cGlZdmxOTUdiZG1Udnl4Zm8yb0g2Z3MyS0dJN2FHQ0M4OVNWZlpyQnAy?=
 =?utf-8?B?d2FkejZqL0VBeFFUZkdRWThnbG9WNVh4ZXRXUkNtbTZ4SHA0VjR4NTg4eFB3?=
 =?utf-8?B?RGh3TXpCOXRTd3hPTFZ0clV2Rlc5VWRoVDZDM2E3ekxZbXM5ejE0MDBEZm1t?=
 =?utf-8?B?aVRmaCtIRmlBcStJK2JoYzZwUTJhUGNVTEM5cCtseWllMUZqVGVITk1CU2VG?=
 =?utf-8?B?SkhIQm5YZ1hjUUZtS2hIekNtUkdCS1FWdVByZ2VFSGh3T3Y3VUg3OGI1b3pG?=
 =?utf-8?B?cEVNeXpVYXdYQUhxd05vdHp6K002OFc3RTRzaTBFMFVYMFF2ellQM1dIaC8y?=
 =?utf-8?B?Sks5clRKN3VMTjJtdEF1M29vSGt6UFhHS0cxK1BkdkxwRmpwamJSWlZQZElG?=
 =?utf-8?B?MnhPZCs2c2dyQzM1VW90OCsrMWI3MXR2WjhCc1R3WDlaaHVSOS9EYVNPT3BX?=
 =?utf-8?B?Mk9LMXJubVp2THQ3UnFnYmp2NVRBMHdBeHVkaG9hZ1ptdDg2dTBuS05PY3dK?=
 =?utf-8?B?d3BtTElVU2VBbWVCK2Z4UnAxRVpWRUZmMXJuVnNJOVR5OVlOVVkvZWxZTXZh?=
 =?utf-8?B?TlZIdld6dXhHdGJpSVh0N2t4WElJUk9rRUh1eXhJdmNESVF3bFRWZlBNbVZT?=
 =?utf-8?B?MXAzM1NoOWVibFp4L3RudXNZRHlVQjJOM3dJT3IvSHVYdGI3YTFxMFJtWWdC?=
 =?utf-8?B?MVNSTTY2TXVKQkVVQkJYNHQrQi93QkRvVzZVQ2o1L25WL3NQRStPMFJTZGZo?=
 =?utf-8?B?SnY4aWxCc3ZhQnhSSytjVklWRDNXc25jS1Z3VEJCMHNkc2gzdjdHYTgyYVVl?=
 =?utf-8?B?OGxqK2hvWlE2cnNlZDcwWGp4dUI4cmhGc0dZbHZwSURrcVdmQS8vSnE0RG1q?=
 =?utf-8?B?NVAyNFZ4TzlCeE9YMWJudGV4ekl4c3VlZlJCOWlOeEl1Z0tnOFhKSE5GVmlm?=
 =?utf-8?B?NFJQU3dPQkJ4WUVUbjNKU0FiMHdMMTM3ZSt5M21KM3RUL1lCOThFTy9LRlRy?=
 =?utf-8?B?Zml5ZXJDdlZmN2xlNkRQcEtMK1YrUVZuYWQvYmpkVnh6azdMamZPc290UGQv?=
 =?utf-8?B?Q2xZbFF3UjYyTnozTGVQL1ZuREl3YkpYYVlPejdjQzZuM2JwSFRhQU9xRnpi?=
 =?utf-8?B?VXNqSkZGTHd6M2pLWXZGVkVEZi9aVlRsUXlKTGxGazk2alQ1OFZCdjVacmxF?=
 =?utf-8?B?ZFN2UzhVaHZ5TWhyMVJaenhkZE1mUlpUek16clQzUS9kcFUvam1HRVkvRmZY?=
 =?utf-8?B?TFJUTWszeHRqYllYejU0ZERKRGcrSVNUdWR3bnpSUnJ2QXFocCtKdy91YzM5?=
 =?utf-8?B?bXBFYm00dkMyeFV2ZkZQRGhnOE8zenVOTnFsN0F4c1k3VE4xR1lDa1FlWmhu?=
 =?utf-8?B?Qy9FMWRCVEI3MCtFbjFBSGNONVQzSS9tcTBJaVdWRUlOWmRjWEhoU2swdS9D?=
 =?utf-8?Q?7h1CQw3TXm4lldN+c5e4rsy97?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b108a1d9-daa8-4391-4226-08dbb39a11f4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:10:51.2398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElPY8t7qksdoykw0NA/kJN4F5UXfAMun6oCaM3kJcuAxx0aZUu0SM4fsPMYuL+LR1AtfmCGPHZyp/x520hU38g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-12 3:49, Christian König wrote:
> Am 08.09.23 um 21:30 schrieb Felix Kuehling:
>> On 2023-09-05 02:04, Christian König wrote:
>>> Move the SDMA workaround necessary for Navi 1x into a higher layer.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  48 +++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |   5 +-
>>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c |   3 +
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 159 
>>> ++++++-----------------
>>>   4 files changed, 97 insertions(+), 118 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index d78bd9732543..857051093900 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -575,6 +575,54 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct 
>>> amdgpu_device *adev)
>>>       return 0;
>>>   }
>>>   +void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, 
>>> uint32_t vmid,
>>> +                  uint32_t vmhub, uint32_t flush_type)
>>> +{
>>> +    struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>>> +    struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>> +    struct dma_fence *fence;
>>> +    struct amdgpu_job *job;
>>> +    int r;
>>> +
>>> +    if (!hub->sdma_invalidation_workaround || vmid ||
>>
>> The "|| vmid" part of the condition is new. AFAICT, the workaround 
>> was applied to all VMIDs before this patch. Is this change intentional?
>
> Yes, applying the workaround to anything else than VMID0 never worked 
> in the first place.
>
> Always using the KIQ on Navi 1x looked a bit like avoiding that problem.

OK. The patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>> + !adev->mman.buffer_funcs_enabled ||
>>> +        !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
>>> +        !ring->sched.ready) {
>>> +        adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
>>> +                           flush_type);
>>> +        return;
>>> +    }
>>> +
>>> +    /* The SDMA on Navi 1x has a bug which can theoretically result 
>>> in memory
>>> +     * corruption if an invalidation happens at the same time as an VA
>>> +     * translation. Avoid this by doing the invalidation from the SDMA
>>> +     * itself at least for GART.
>>> +     */
>>> +    mutex_lock(&adev->mman.gtt_window_lock);
>>> +    r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
>>> +                     AMDGPU_FENCE_OWNER_UNDEFINED,
>>> +                     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>> +                     &job);
>>> +    if (r)
>>> +        goto error_alloc;
>>> +
>>> +    job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
>>> +    job->vm_needs_flush = true;
>>> +    job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>>> +    amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>>> +    fence = amdgpu_job_submit(job);
>>> +    mutex_unlock(&adev->mman.gtt_window_lock);
>>> +
>>> +    dma_fence_wait(fence, false);
>>> +    dma_fence_put(fence);
>>> +
>>> +    return;
>>> +
>>> +error_alloc:
>>> +    mutex_unlock(&adev->mman.gtt_window_lock);
>>> +    DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
>>>    * @adev: amdgpu_device pointer
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> index fdc25cd559b6..9e7df2f69123 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> @@ -117,6 +117,8 @@ struct amdgpu_vmhub {
>>>         uint32_t    vm_contexts_disable;
>>>   +    bool        sdma_invalidation_workaround;
>>> +
>>>       const struct amdgpu_vmhub_funcs *vmhub_funcs;
>>>   };
>>>   @@ -335,7 +337,6 @@ struct amdgpu_gmc {
>>>       u64 noretry_flags;
>>>   };
>>>   -#define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) 
>>> ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
>>>   #define amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, type, allhub, 
>>> inst) \
>>>       ((adev)->gmc.gmc_funcs->flush_gpu_tlb_pasid \
>>>       ((adev), (pasid), (type), (allhub), (inst)))
>>> @@ -401,6 +402,8 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device 
>>> *adev);
>>>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
>>>   void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
>>>   int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
>>> +void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t 
>>> vmid,
>>> +                  uint32_t vmhub, uint32_t flush_type);
>>>     extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
>>>   extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>>> index a041c6c970e1..8521c45e8f38 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>>> @@ -471,6 +471,9 @@ static void gfxhub_v2_0_init(struct 
>>> amdgpu_device *adev)
>>> GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
>>> GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
>>>   +    /* TODO: This is only needed on some Navi 1x revisions */
>>> +    hub->sdma_invalidation_workaround = true;
>>> +
>>>       hub->vmhub_funcs = &gfxhub_v2_0_vmhub_funcs;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index fa87a85e1017..1f70c57bcd69 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -230,20 +230,49 @@ static bool 
>>> gmc_v10_0_get_atc_vmid_pasid_mapping_info(
>>>    * by the amdgpu vm/hsa code.
>>>    */
>>>   -static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, 
>>> uint32_t vmid,
>>> -                   unsigned int vmhub, uint32_t flush_type)
>>> +/**
>>> + * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + * @vmid: vm instance to flush
>>> + * @vmhub: vmhub type
>>> + * @flush_type: the flush type
>>> + *
>>> + * Flush the TLB for the requested page table.
>>> + */
>>> +static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, 
>>> uint32_t vmid,
>>> +                    uint32_t vmhub, uint32_t flush_type)
>>>   {
>>>       bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, 
>>> vmhub);
>>>       struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>>       u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, 
>>> flush_type);
>>> -    u32 tmp;
>>>       /* Use register 17 for GART */
>>>       const unsigned int eng = 17;
>>> -    unsigned int i;
>>>       unsigned char hub_ip = 0;
>>> +    u32 sem, req, ack;
>>> +    unsigned int i;
>>> +    u32 tmp;
>>>   -    hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ?
>>> -           GC_HWIP : MMHUB_HWIP;
>>> +    sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
>>> +    req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>>> +    ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>>> +
>>> +    /* flush hdp cache */
>>> +    adev->hdp.funcs->flush_hdp(adev, NULL);
>>> +
>>> +    /* For SRIOV run time, driver shouldn't access the register 
>>> through MMIO
>>> +     * Directly use kiq to do the vm invalidation instead
>>> +     */
>>> +    if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
>>> +        (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
>>> + down_read_trylock(&adev->reset_domain->sem)) {
>>> +        amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>>> +                1 << vmid);
>>> +        up_read(&adev->reset_domain->sem);
>>> +        return;
>>> +    }
>>> +
>>> +    hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
>>>         spin_lock(&adev->gmc.invalidate_lock);
>>>       /*
>>> @@ -257,9 +286,7 @@ static void gmc_v10_0_flush_vm_hub(struct 
>>> amdgpu_device *adev, uint32_t vmid,
>>>       if (use_semaphore) {
>>>           for (i = 0; i < adev->usec_timeout; i++) {
>>>               /* a read return value of 1 means semaphore acuqire */
>>> -            tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
>>> -                     hub->eng_distance * eng, hub_ip);
>>> -
>>> +            tmp = RREG32_RLC_NO_KIQ(sem, hub_ip);
>>>               if (tmp & 0x1)
>>>                   break;
>>>               udelay(1);
>>> @@ -269,9 +296,7 @@ static void gmc_v10_0_flush_vm_hub(struct 
>>> amdgpu_device *adev, uint32_t vmid,
>>>               DRM_ERROR("Timeout waiting for sem acquire in VM 
>>> flush!\n");
>>>       }
>>>   -    WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
>>> -              hub->eng_distance * eng,
>>> -              inv_req, hub_ip);
>>> +    WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
>>>         /*
>>>        * Issue a dummy read to wait for the ACK register to be cleared
>>> @@ -279,14 +304,11 @@ static void gmc_v10_0_flush_vm_hub(struct 
>>> amdgpu_device *adev, uint32_t vmid,
>>>        */
>>>       if ((vmhub == AMDGPU_GFXHUB(0)) &&
>>>           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 3, 0)))
>>> -        RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
>>> -                  hub->eng_distance * eng, hub_ip);
>>> +        RREG32_RLC_NO_KIQ(req, hub_ip);
>>>         /* Wait for ACK with a delay.*/
>>>       for (i = 0; i < adev->usec_timeout; i++) {
>>> -        tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
>>> -                  hub->eng_distance * eng, hub_ip);
>>> -
>>> +        tmp = RREG32_RLC_NO_KIQ(ack, hub_ip);
>>>           tmp &= 1 << vmid;
>>>           if (tmp)
>>>               break;
>>> @@ -296,109 +318,12 @@ static void gmc_v10_0_flush_vm_hub(struct 
>>> amdgpu_device *adev, uint32_t vmid,
>>>         /* TODO: It needs to continue working on debugging with 
>>> semaphore for GFXHUB as well. */
>>>       if (use_semaphore)
>>> -        /*
>>> -         * add semaphore release after invalidation,
>>> -         * write with 0 means semaphore release
>>> -         */
>>> -        WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
>>> -                  hub->eng_distance * eng, 0, hub_ip);
>>> +        WREG32_RLC_NO_KIQ(sem, 0, hub_ip);
>>>         spin_unlock(&adev->gmc.invalidate_lock);
>>>   -    if (i < adev->usec_timeout)
>>> -        return;
>>> -
>>> -    DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
>>> -}
>>> -
>>> -/**
>>> - * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
>>> - *
>>> - * @adev: amdgpu_device pointer
>>> - * @vmid: vm instance to flush
>>> - * @vmhub: vmhub type
>>> - * @flush_type: the flush type
>>> - *
>>> - * Flush the TLB for the requested page table.
>>> - */
>>> -static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, 
>>> uint32_t vmid,
>>> -                    uint32_t vmhub, uint32_t flush_type)
>>> -{
>>> -    struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>>> -    struct dma_fence *fence;
>>> -    struct amdgpu_job *job;
>>> -
>>> -    int r;
>>> -
>>> -    /* flush hdp cache */
>>> -    adev->hdp.funcs->flush_hdp(adev, NULL);
>>> -
>>> -    /* For SRIOV run time, driver shouldn't access the register 
>>> through MMIO
>>> -     * Directly use kiq to do the vm invalidation instead
>>> -     */
>>> -    if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
>>> -        (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
>>> - down_read_trylock(&adev->reset_domain->sem)) {
>>> -        struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>> -        const unsigned int eng = 17;
>>> -        u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, 
>>> flush_type);
>>> -        u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>>> -        u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>>> -
>>> -        amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>>> -                1 << vmid);
>>> -
>>> -        up_read(&adev->reset_domain->sem);
>>> -        return;
>>> -    }
>>> -
>>> -    mutex_lock(&adev->mman.gtt_window_lock);
>>> -
>>> -    if (vmhub == AMDGPU_MMHUB0(0)) {
>>> -        gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB0(0), 0);
>>> -        mutex_unlock(&adev->mman.gtt_window_lock);
>>> -        return;
>>> -    }
>>> -
>>> -    BUG_ON(vmhub != AMDGPU_GFXHUB(0));
>>> -
>>> -    if (!adev->mman.buffer_funcs_enabled ||
>>> -        !adev->ib_pool_ready ||
>>> -        amdgpu_in_reset(adev) ||
>>> -        ring->sched.ready == false) {
>>> -        gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB(0), 0);
>>> -        mutex_unlock(&adev->mman.gtt_window_lock);
>>> -        return;
>>> -    }
>>> -
>>> -    /* The SDMA on Navi has a bug which can theoretically result in 
>>> memory
>>> -     * corruption if an invalidation happens at the same time as an VA
>>> -     * translation. Avoid this by doing the invalidation from the SDMA
>>> -     * itself.
>>> -     */
>>> -    r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
>>> -                     AMDGPU_FENCE_OWNER_UNDEFINED,
>>> -                     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
>>> -                     &job);
>>> -    if (r)
>>> -        goto error_alloc;
>>> -
>>> -    job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
>>> -    job->vm_needs_flush = true;
>>> -    job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>>> -    amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>>> -    fence = amdgpu_job_submit(job);
>>> -
>>> -    mutex_unlock(&adev->mman.gtt_window_lock);
>>> -
>>> -    dma_fence_wait(fence, false);
>>> -    dma_fence_put(fence);
>>> -
>>> -    return;
>>> -
>>> -error_alloc:
>>> -    mutex_unlock(&adev->mman.gtt_window_lock);
>>> -    DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
>>> +    if (i >= adev->usec_timeout)
>>> +        DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
>>>   }
>>>     /**
>
