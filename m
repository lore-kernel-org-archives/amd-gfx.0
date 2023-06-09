Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4592CC7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 13:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B620810E06B;
	Fri,  9 Jun 2023 13:44:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C245810E06B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 13:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPmPG/Zn4GHdt2p87u4B2maJIMzWhteyVpQz6l5z9FLtqObtZQwxMHZr8RqDv/KGDE3hBXhVk1iijlCf5BLg+Uj4PdYW+nN5wqDqeH/mvio67OwC1cm75klli6GQ0Eu3XYEh+rFa/HEOlUCjB+VYEExjEh+QfrsW4gNRkedDq1AunIDgd+hd1PTOVM7njXemdvwNySwfAzwRGPy1wtLezdN7YuGQ7U87VaR1xbTfqVmwhJ4yDV48IhTM5JhL2Yjqd+p6v7oaftfy15FvhYfn3ckiYcqt75DGR9tWtTSg+EvIeBunsHPL3tuJcg5LcvFqw/0DcgFGopkmy7Rhgb5omg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDJs8A3+QT1dgfriMns6CBX41s7AzM0B8Wc+nBHvoVQ=;
 b=Nx/Zy1678kMdASqTo3P3GXvu02hYtDwOsPUs6fjXQiynbwgCFzmJpDWq/hI3DMU9Vc2Fb3eEioZGEBU8WHu13pkMPIn9r4HhxMeZuZaGrmyKaVZnPM5FrAN2H2c2/Mq5PiUl2pIyo4M64ZV+8VVl+dLXPZU9rcuxFXF2g52ViP6jmdv8tu4B5ZbrhF0gjrVuVCkKcfKjRRxUH3acujvprlIfC6n9WiUeSnXG+oF4w/trm7YD01Ty0rMgmyGUVUGbATt4/UIOA4q28IV9fErvz3xNBDA5wbdFcO5y230nWHeP1bZb+Ydw99vYaUyqTy1/hmQmc3lP7nSHk4+cls8XXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDJs8A3+QT1dgfriMns6CBX41s7AzM0B8Wc+nBHvoVQ=;
 b=W6rGUh9nxOMmstOX3LXkdWlak3ldsGJGjgnjkfiMx5z9J2+H8HRQh3nz32ubrTDB1ntjt+uXbN/PQ0iTNf8aS2w10lMGAd/ZnQY/5LjiUqw2OIwDi0Ou4v9EAIiciQ3A8T2DvamPTBKwQG2eBfDUy0uQpH0MCUGOoGRYUVh/XhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.25; Fri, 9 Jun
 2023 13:43:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::6729:a735:9814:97ea]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::6729:a735:9814:97ea%6]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 13:43:56 +0000
Message-ID: <7cd112e4-fcd6-5ea5-7b4a-c8175d2672a3@amd.com>
Date: Fri, 9 Jun 2023 15:43:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] drm/amdgpu: flush gpu tlb using sdma ring
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230609100257.900-1-shashank.sharma@amd.com>
 <3633a37c-f9d5-c797-72a5-7ab584277ab3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <3633a37c-f9d5-c797-72a5-7ab584277ab3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: c98bde51-23d4-41bb-0ea9-08db68ef920e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXPdKTw7FNu+ZlmkthnfEAGTpS90Ys7UYj2O7X+N6of9NMx1Fe7d7Kw4LpmvSQsztxnl39nXyuGM7CGh7UaZytckmRzxJoGkmrVJSqiXlNsyuZM9/Ugx4DKCdZ7F6ArElGaJGr3tLuMV7kTAGvm0SBCQAe3xeEoiTZ9LzEZ+Rpost2vzSBjijOiHeo1WsuCr8TKOHYRamSIZZdmmQBcpUpizxCYXJ4pSsmpGgmpScCy0Nsw/0oT8zAF/D7cHmCCrq3wYcyv46PuUa8LSZ7I2CvMiG1eNDY8bL5TmSRDazqB6uOzQj5UvU7gdTnkezo0sFWOPSI0rdCKF+KUyVAnpLEZx9Z9Wvun+cpXQbkpdl0CcpcOotD9wEX0RYw73/APculn2wsWg+vd+5oL0fXGJgn1UggJywxOeB6IjQSblS6wTsRMjMSfRpKbclbkPLjGSIaF/dU6jLO0us8tMzyu2aMWYWoFChkvpbioMfx8DeWXcN5J/UMtUiI+hRnxlXbCACRADZ4uSnFccxTIgGGF1IF6zlCAvXPE8j4GkbQWd98kSZkdrdk5ESrUTmA5r5Q0rsgegpDG36QsIWYleHOHIkwpOMvqZpfu8ZfBNo8nmuuIs0GoIOv2Stsl5Mow+fd5b0gj1ytfIJhpJSEh0CfEUfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(478600001)(2906002)(36756003)(6486002)(6666004)(83380400001)(2616005)(53546011)(86362001)(31696002)(38100700002)(6512007)(186003)(6506007)(5660300002)(316002)(31686004)(8676002)(41300700001)(66946007)(8936002)(4326008)(66476007)(66556008)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZncmpjT001eG9YVDBjMHRmTzRCbGtDZjNCK2lrdjVvSFAzQVBxUC8rTFZD?=
 =?utf-8?B?cFE5U1BPNXdzK3ZOY0EzTG9zc3BjdEpnaDNGcHlFOVJYMUVkUjZEcVVVWEsx?=
 =?utf-8?B?a3lwMW5IVWZaZElqb2N4UG10QTA0b2xrQXJXdzdEbGFZSkF5UGJlL2pMMWVM?=
 =?utf-8?B?MFRyZzh6bStReEVINXNXT2NQTUo4ZHUySEJCeDFwUXk2YUdGUXhKVExvWDEv?=
 =?utf-8?B?NU44RGRuRVE1RDMycXM0d01MT21xTWhtSGJra2h0Ri9TWmtoL2pxaklNZ0Uv?=
 =?utf-8?B?QXpWcHQvVFRsaVFGcStGcjdnSW5kVDVTekFZZXVKeTN3dnJuMTY0U0lvSzh1?=
 =?utf-8?B?Z2k3K1BQVmx1bURFa1dpT0tVRmcrZ2M2YlBocnpHQ1Q4RWUxcG52ajdhNVVQ?=
 =?utf-8?B?N1BwaUVGSkl5anhWWG9YL1FsaTkvWE5KeC9qOWpDVk8yUDBkU1p6bldJdXQw?=
 =?utf-8?B?aVdQZ3hpYytOcUVCTVlBS0VpOWc2ZWN1SDNMeTc0TWd6V0xVKzJrVWNJQWo4?=
 =?utf-8?B?cVJJOTZJYmlVbFQ1SlQzRnpQUlVhdll5amY3TTZ0OXFCaUtMdTNHNkhld3c1?=
 =?utf-8?B?N0J5Vis4SjFLYlBQWTFWZktWQjlpRlBxSmZxTFR5SDkzaGxEVjdONDZJbTlm?=
 =?utf-8?B?SlQwazF2Tnl4clRNSFZCdFdzTUhzQzA1SEJTR0p1SUR5SHFtRGJHYnZFQlBG?=
 =?utf-8?B?d0wrc3ZxZUdrM2RCRjVoS0c1b1FEcUd4Q2RKTHN2NXR2bDNqN0pkVk40MVVQ?=
 =?utf-8?B?RHc0T0xsNTJzSnIzSFpaa2s4SUFNY3htVFlqa2lMVWlTSjhMbFV0RXBTanJO?=
 =?utf-8?B?UEkxSENvYm5JcXNqaEFBK1VtblM5bFhtQ01vRkg0ZDQzL3hFYitFK3REd0d1?=
 =?utf-8?B?YWxWQnJDMW9aVTdnZGxFUXVBNVI0YzQzUzhhTGNUamJyZElsUndZNldzK3FW?=
 =?utf-8?B?bTllVFlZeGJXZVA3U0xGSW9QTm85TzQ0MmY4VTE1WkdYK3Z1QVh1NVRuc0pK?=
 =?utf-8?B?UEtmdlNVc095Q2JhaU9FQnlMcXVkdUEzOWI3ckkzM2Y1R0JlRmpMdG1WODN6?=
 =?utf-8?B?eFFqV2NOZ0QzWE5nV2FYcDBLMlFaQWZnYXJtcmZCdDBSRlNlWTFHWVdZcjZD?=
 =?utf-8?B?Y20xQ1N5cFZtelJucDkxMGt3R1MzUS9RQURsaTgxc2JKa0prSlpSYmIwM2Nk?=
 =?utf-8?B?SVJTOVowazluRU9HZ1dmbzJhK3hBaWtablZQMXVDZnQ4YW5kczBiNkhFb25S?=
 =?utf-8?B?RjdOZm0zSFY3bXZUWGFOVVJwNXdOLzJVeXF6dUEzWVFTR1dDclN1SVEzUis4?=
 =?utf-8?B?eWZ5cjl1Nk9EUkpPdkR3Z2xLK0Myd3VDc3ViYzNEOHhkNUxOelpnUE85R3B3?=
 =?utf-8?B?M0pWVmtKT040VWhLM2x3THRhaHJRTE8wMGp4a0ZxUzVET09SUWErRWVsY1I0?=
 =?utf-8?B?ejlnZ0NNb3NHYWVSaTB3WklrcEhQcmxNMjBBbkZtanVCQzFpYU1CeVRqVHE3?=
 =?utf-8?B?dzEwZmxKZW8zbVdXQzdwaFZVRW85RFd5OStJQlE5Y3RMYStiYngwT2t6dGVk?=
 =?utf-8?B?QWdwR2JCUU1HUFV3WFQ3Ky9YNnhyWVY3VzAxWXhhVkhKcVdORG1tL0c5bjJB?=
 =?utf-8?B?VVNlait5eTlEdkxtcUd0ODFHdi9GYnJXeklzUExMaE9zMVJRanF3bU1XcnJn?=
 =?utf-8?B?eVNBMmUzMmZiNktnVE9tQmVIQWRnbHR1VGUyRzdBQTBFQzIwck9iQ29SbytE?=
 =?utf-8?B?N0xoeDFCWlJxRVpoZDJXdXliaVJheUpNMmtWWWlVVjlHVUN5ZzkxcE1nWC9D?=
 =?utf-8?B?QUJlSFNvMlRoOFEvSCtkMGFEZWtIcFNnQmpCcW82RWE1YTlrMUErQTRVbGxi?=
 =?utf-8?B?YlAreW1BRTB4bzZZcU5XUHY1SUg5VXNLME1ucE1CUEhNeWI4STI1a2Nkcmlw?=
 =?utf-8?B?YXZleGgyOGVzV3FLcGcxaDRBbTY5VVVNZ0pWOTU4TnQvYzBOMXJBbzFmL0hW?=
 =?utf-8?B?TzAwVVB1OTcza2s3YTBSS2I3OUMyelJRKyt0S2dpZWt2YW1YL3kwQnRjbTli?=
 =?utf-8?B?UVpFU0wzYzlLNHVGNzFuZUtqV3lPei9ScWpkOFpLbE1vVHQxSWRUZXExN3d0?=
 =?utf-8?B?QjR4Y3JaQWl1dEZLWHg5SEZVK3BlUEd2aUFFaTFhaVExZERUUFZoSXJwM3Mw?=
 =?utf-8?Q?Kcz6MTHv8GLaTpMSqpmNB9TyeXB1pqZEXIK5L7DR0LjV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98bde51-23d4-41bb-0ea9-08db68ef920e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 13:43:56.1632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xp1CJkIIxs3zow3YnWJZ8JtlK8HufHTSAfGNYXmVGtQyBrQwx7YVqXsx4QLY+g2/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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

Am 09.06.23 um 15:32 schrieb Philip Yang:
>
> On 2023-06-09 06:02, Shashank Sharma wrote:
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
>> +{
>> +    int r;
>> +    struct dma_fence *fence;
>> +    struct amdgpu_job *job;
>> +    struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>> +
>> +    mutex_lock(&adev->mman.gtt_window_lock);
>
> gtt_window_lock is for GART copy buffer/window sharing, here we use 
> copy ring but don't use copy buffer, and ring ib sa and job submit has 
> spinlock, so I think gtt_window_lock is not needed.

We need something to protect the entity while pushing jobs to it and 
that's the gtt_window_lock, so that can't be removed here.

Christian.

>
> gtt_window_lock should be removed from gmc_v10_0_flush_gpu_tlb too.
>
> Regards,
>
> Philip
>
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

