Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA85C7EE25
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 12:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0928A10E146;
	Fri,  9 Jun 2023 12:20:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD6910E146
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 12:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1oHa6Kqc08mcSxAzMsgZTGxZDH50ZIq0eqcC+zngmMILDigaGSBRn0Tu5fdTG/7x0t+Fxe/qvjSgGffIsM/Z/pdpEzoVItXZLKnlA9gp49FabnqkZE+IpKBhNEq/blLJ5cvKhgac0+5k1O4tYiT0mFfMlsFMBuLXgSgH4dWeNeEwUgn8arw6BGFIJHyfx9cxj0eoS5NdI+8PYrSsArTHAnJXvv7gjrWuRirl7z58QbsZzwEmzTzNxoBLn99ux61NAirRh2PFbK1TBJMxV1Mc0hibJuoqfwYx10mCEt970kWgAw4BXWAC6jHL4U/axluqPhwR6TSnGyozbnpHevnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPDWTs+Sov6hcAc/xccPWJpBbVhevAWCzMDjLUoBIW0=;
 b=HDfWYytsVPjhJxHg72JQopHXxWQM1chvbB7m2UVM+kcHWwEs4cj2T1AGeWN1eWuZbrm7w0xXkD/KKtZQOTTIif/64un2sigJed6dC6slid021g/NlrAJ4B2xrLCbuAHjAqP79JhtvZm2XuKRvlwX7xFSBilY7AIbHTeeOg4p+TQDgFIlMJzWBtaTgBN/cPdMxf7CvcpbnIwlkxQ8q4l3O9jKCVWwYyjOE53OTq6kJZUoH3x7kcDH1WKMQCF6EfqOuJsriZbzZ8EbeJ2YnNbG+1R9+AaLfzVi2lIeN65eX7LOv/Mcp9OkKnksGX5bGdp8jphSbQjUXzADIfZghk4AkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPDWTs+Sov6hcAc/xccPWJpBbVhevAWCzMDjLUoBIW0=;
 b=d4DBPvwnVLvFj/sB4zxValKw+pfLE9EV+jy5b7ub6JDlw7f/bun+SL7HPXUAd74Www1srrZ7+UiIAtf6hMpqsuPjqQXcHy0qz/cJ6K7foWODkZWMu5VJWpiYlfk4UVM+o0rrNyLISLn/1/LMvj/8bGTHfLd09310OYsN5o+2DHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 12:20:02 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6455.043; Fri, 9 Jun 2023
 12:20:02 +0000
Message-ID: <5d6759cd-92da-f22b-5f34-67c72c4724d4@amd.com>
Date: Fri, 9 Jun 2023 14:19:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC] drm/amdgpu: flush gpu tlb using sdma ring
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230609100257.900-1-shashank.sharma@amd.com>
 <fc9b8914-52dc-ba12-a485-61e9c61a696c@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <fc9b8914-52dc-ba12-a485-61e9c61a696c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::9) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: fade59f4-a7e2-4ae3-09b4-08db68e3d995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYVtXVsl5ii5s3ZprGweXdVCO/apouBiGlgQduPwRDyohO9t60mBCf6LLEr/JV9IWRUK4le3wP96mG2EqeuFO2XKZuNym6VqEQ5uKvG3A+/nuBdi++QwFpe1QRebx/x/3oHVugrxkBW/AHEPzcfxG+3ySfYMpX2F0jT8YVPzcvpi+iZeC0+9KYxeVjjYc9+dsmYSgvJlfzixa5ihEUYkC1FaiciZNMOhNbXFktuJOCSyUBpNwRFAGi4+eUQiWZ8OvYT7pVckoPaLB4cemmsYN2VCgkOu+1L1+j6W8JFjHvVbvp3GziuxiJcZ/B0RNfHrODAPjk/QPCCaHtx+WORTAVONAKFu4hG94qiIhiCKXLnVuqq/xSM6uJOhWxChNPHpXQcAGAvm5Ss9YhOSw+tPjQyb7etzhTIZjrA+xHDkmZWzJc/Wl2i6oJc5EK2dKsungusLuwOUN2S2XWWtRlnFi5CpSI5mm0anhqD3KKftix9qoAYHVTmgFl4lxC+lzSyMYqPtRlVMGcOvbe+veTqOwoU2BnJHr79UvunSnY3FiTJoXuND5rpGMZuqH1KvKSjT+T1kqXnGT3y4mHa0+CEYOq+wtMCwl6WSedalUOYjs2dFeczUgoDeVk7Hx9o4EvaSec1KHC4Psx4WsSnGxp/MCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(478600001)(8676002)(8936002)(4326008)(316002)(66946007)(66556008)(66476007)(2616005)(38100700002)(41300700001)(186003)(83380400001)(6666004)(66574015)(6486002)(6512007)(6506007)(26005)(5660300002)(53546011)(31696002)(2906002)(44832011)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG5xVnpscmdxcUU2VUE3ODB1OThtYVpGMUZNZjdLeGNWOWZ6T3QwMTZ3M0t0?=
 =?utf-8?B?SmZnOTFLekJyRnFLdzFWeFJ2bGRrZ3pKT1ladU1uVndzYUZmQVYvdEw0Rmhw?=
 =?utf-8?B?RnIzVkRjVFdESlV2RHliZVN3dzJDRGRrNys1K3o3K3FXeTlHMHcreEpmWUVk?=
 =?utf-8?B?bHQ4SmFvTmE1OEV0RHdTU25YR2JwRDRFdDgvNm4xT0RtaHZ2QVJhaGVJTDZz?=
 =?utf-8?B?cXRwRnpOZjhLT1liK0JPc0wydUI0dStMRnQxRGRRSTA4VE85K2o0WVpSb0Nr?=
 =?utf-8?B?NWNINitnUTFWK2twSXJaM1pHNWNNeHFYMnpxaFJwNWFmWCsvNlhScC80SDVq?=
 =?utf-8?B?WlFKM2RFaU84R1VKNitmcDFPTldyS1ppNGdndzFLUWZVbG9GN1NtTnpobVdZ?=
 =?utf-8?B?d3NlbVY4YllBQmt0MHdvYmpOQXRzallmSTcydWk2YVVHelhwWkF2TE1hV3pl?=
 =?utf-8?B?Z0NqT2xlMFI5YVRJSDlkMkdYN20wLzhSRmFYS0FYTlhLTlN5TEg5UXFhOHZr?=
 =?utf-8?B?MVdTVlBwTURqc2xBOGNpRHh5dW5RbDEydjBvOXkrLys2c240NEg5YW0yV1Yv?=
 =?utf-8?B?S0o0eDkzK0ZMWHB5NzlrQXVOWUpGeFZzTklWODBVd3Nrek9UWWo5ZzR5cmlr?=
 =?utf-8?B?NVA3dmhlUFZtUGRrU0FadXErTkRaMFRxVkpTVlhJVjFEbnQ5SnBTbWh6Rmxj?=
 =?utf-8?B?WnBLRFcvTEEzMm01M0ZmNm41VThER0J5Nnd3VWpzOWRibVo4cEVEdWZPTEdn?=
 =?utf-8?B?eTJiYS9FT20yOWFoeHlDZ2UwTmJkMk9qQkpCUUxmTnpVZ0d3Y2E2MHd1ekpW?=
 =?utf-8?B?emI2SXY5SGluZG5jczVuRkNETnc0MWMvMmFwZHVINERkYlhVdi9PdUtMejRU?=
 =?utf-8?B?djd6SkN0a1N4aFErZVVPYW9lemtWMkFLdVNycEcxZ0hUZW54bGQ5ZVZWMFpp?=
 =?utf-8?B?SXhjTm5TazFFWWhDNTRYRXJsTmkzLy9BYWNhZVZoNVFuRTUzZS9YRmdnZ3NS?=
 =?utf-8?B?dmhMTGpwYko3b0syNU1WaVJwT1JnaEtMdm1GcGhLS01zZHRvVGx6Q3krWm5R?=
 =?utf-8?B?RzRReDJ6TEpoNW4zT2drMHVZUWdrNDN2bEdrUTlYR3E5R25EN210RjdGV1Ix?=
 =?utf-8?B?UUxSN3hhWGU1bENVbEZod0U5UmRQR0NrKzRSNUNVT3I3cjFYaStZbXpyYVZC?=
 =?utf-8?B?c1BmdGd3Z1JlcnVDaGgwZzVzK2lVaEN1SzU0QXpLS04vU2xqdXE5aWdGSkg2?=
 =?utf-8?B?cktqZ2JqUWdEODJkRlRiM2R3VzBMdzRyQlV4TUE5MmVGRzBVNndsbnRiRm5P?=
 =?utf-8?B?dHg5TUE5RVpUeWlUTGt2blZ0VS9NZi9MRFZyOXZzaWYrdmNSb0dCU2VWT1Z6?=
 =?utf-8?B?Z3FUbEhwd0h5RjhrRkdBeExPMitwaDZGdDlMT09DRlJWVHdERUNSYm56R3lS?=
 =?utf-8?B?ZEZjWC9TbVpLVVkvMXZsMmV1bDBMMnhwWmNmYzVpL0F1SmU0em9lSzJka0d2?=
 =?utf-8?B?eks5VGFpL0lXRyttZVdtWUJacnVrYXNtNUY0WVg5NDlaRHFhaG9HOFZjb3dT?=
 =?utf-8?B?ZGd2SCszUWViaFBQTlZQT1RYaEM2eGYzZEp2THlFZGpMWkpRdzcxT2lUTmJ4?=
 =?utf-8?B?Si9aZktlWlY1N1N6OVRPWml4ZVppZkxyNE10R0VVNlNIOHg3VXY1SHZTNXlh?=
 =?utf-8?B?SGNJK2tzTk84NCtheTRhUktFcnZpbXVjZ0Y3cUVwYmVFWWZRK0dFTytNdWJI?=
 =?utf-8?B?RHZ3Z2wwSFlUTnRVYjltT0FMN1BEeWQ5VlAzeHY5VzUrNVNudTFWeUEvN25t?=
 =?utf-8?B?Y3RvNS9sbVdKNFYyZXZCM0VDSG5odWduZ3NicGc2cmhzSXp1NlVYazBLdUhW?=
 =?utf-8?B?V0V0KzdwQnVsZmlwOEovek5PTzdJY216aCtkSy9wa1lsN0RsL0VmajFLWmlC?=
 =?utf-8?B?ZEdHTGxWL1hJdExuWVBSTmZXeExEbk5jTzVrQ0NNUlFZT0tIVVcyTXN3Wnpn?=
 =?utf-8?B?ZVNQQ0JKWVpOamVDTkVEbGJDSnUwbDRwQmFlRWtlQTVEZ2lsQU5QYXNRQTl6?=
 =?utf-8?B?V3dCTHNKcTM5MTR6SUpqeU5FZHp4YUszamhYc25wQjVWOTZUaXA4dmlQbnhi?=
 =?utf-8?Q?x1HfoKwdlhCjybHTj9XLg+0hK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fade59f4-a7e2-4ae3-09b4-08db68e3d995
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 12:20:02.5158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ymm+oo/eJXtByhYPkOfa1DLU1xo3Sbo2/8Gk1yjUc5AMjIYQB5gV4W7PqifW76DY8cqODxlZoTuiujnZ1DVDjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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
Cc: felix.kuehling@amd.com, Amaranath.Somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 09/06/2023 13:36, Christian König wrote:
> Am 09.06.23 um 12:02 schrieb Shashank Sharma:
>> This RFC patch moves the code to flush TLB using SDMA ring to
>> a different place like a separate function. The idea is that
>> KFD/KGD code should be able to flush GPU TLB using SDMA if they
>> want to.
>>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 36 +++++----------------
>>   3 files changed, 50 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> index 231ca06bc9c7..20a5dad32bfc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> @@ -30,6 +30,47 @@
>>   /* SDMA CSA reside in the 3rd page of CSA */
>>   #define AMDGPU_CSA_SDMA_OFFSET (4096 * 2)
>>   +/**
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
>> +struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev)
>
> That function is actually not really SDMA related. It just happens 
> that the SDMA is used for buffer moves and we needed that as 
> workaround for HW problems.
>
> Maybe add a function to amdgpu_ttm.c with the implementation to use 
> any ring for TLB flush and a wrapper here to use the SDMA for TLB flush.
Noted,
>
>> +{
>> +    int r;
>> +    struct dma_fence *fence;
>> +    struct amdgpu_job *job;
>> +    struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>
> Variables like "r" last and longer lines first please.
>
Noted, I will do these changes and resend the patch.

- Shashank

> Apart from those nit picks looks good to me,
> Christian.
>
>> +
>> +    mutex_lock(&adev->mman.gtt_window_lock);
>> +    r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
>> +                     AMDGPU_FENCE_OWNER_UNDEFINED,
>> +                     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
>> +                     &job);
>> +    if (r)
>> +        goto error_alloc;
>> +
>> +    job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
>> +    job->vm_needs_flush = true;
>> +    job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>> +    amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>> +    fence = amdgpu_job_submit(job);
>> +
>> +    mutex_unlock(&adev->mman.gtt_window_lock);
>> +    return fence;
>> +
>> +error_alloc:
>> +    mutex_unlock(&adev->mman.gtt_window_lock);
>> +    return NULL;
>> +}
>> +
>>   /*
>>    * GPU SDMA IP block helpers function.
>>    */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> index fc8528812598..c895948f6e82 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> @@ -130,5 +130,6 @@ void amdgpu_sdma_destroy_inst_ctx(struct 
>> amdgpu_device *adev,
>>           bool duplicate);
>>   void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device 
>> *adev);
>>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>> +struct dma_fence *amdgpu_sdma_flush_tlb(struct amdgpu_device *adev);
>>     #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index ab2556ca984e..0bfaee00a838 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -52,6 +52,7 @@
>>   #include "athub_v2_1.h"
>>     #include "amdgpu_reset.h"
>> +#include "amdgpu_sdma.h"
>>     #if 0
>>   static const struct soc15_reg_golden golden_settings_navi10_hdp[] =
>> @@ -333,9 +334,6 @@ static void gmc_v10_0_flush_gpu_tlb(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>   {
>>       struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>>       struct dma_fence *fence;
>> -    struct amdgpu_job *job;
>> -
>> -    int r;
>>         /* flush hdp cache */
>>       adev->hdp.funcs->flush_hdp(adev, NULL);
>> @@ -378,34 +376,16 @@ static void gmc_v10_0_flush_gpu_tlb(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>           return;
>>       }
>>   -    /* The SDMA on Navi has a bug which can theoretically result 
>> in memory
>> -     * corruption if an invalidation happens at the same time as an VA
>> -     * translation. Avoid this by doing the invalidation from the SDMA
>> -     * itself.
>> -     */
>> -    r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
>> -                     AMDGPU_FENCE_OWNER_UNDEFINED,
>> -                     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
>> -                     &job);
>> -    if (r)
>> -        goto error_alloc;
>> -
>> -    job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
>> -    job->vm_needs_flush = true;
>> -    job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>> -    amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>> -    fence = amdgpu_job_submit(job);
>> -
>>       mutex_unlock(&adev->mman.gtt_window_lock);
>>   -    dma_fence_wait(fence, false);
>> -    dma_fence_put(fence);
>> -
>> -    return;
>> +    fence = amdgpu_sdma_flush_tlb(adev);
>> +    if (fence) {
>> +        dma_fence_wait(fence, false);
>> +        dma_fence_put(fence);
>> +        return;
>> +    }
>>   -error_alloc:
>> -    mutex_unlock(&adev->mman.gtt_window_lock);
>> -    DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
>> +    DRM_ERROR("Error flushing GPU TLB using the SDMA !\n");
>>   }
>>     /**
>
