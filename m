Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC08C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 16:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEEC60041
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 16:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCEEC60041
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43ABB8991D;
	Mon,  9 Aug 2021 16:24:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E3BD89BF4
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 16:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK+IKBlsvY7p2DAQ0m+DypssNVkomtzERAXppUyyT87jDttltA4HoMmt/eckiiEmFiVV4WwxqFL5cZoyyk9qzCEZor9HKGteKSezcpotSTXp/Oo7Woqj5mxRtxolprPp2E+qEQiUg1XA81H1QhW0Vxg/ZFPcD476slko3jXPUEoDD40+Pn6KrmrJ/1r4hVIWUuuXcOsqkqRfS9RzlwBDjm6JO6yu+Yp5BPErXp+Fay8Ey+njALHxma+ebk2OEOrXMyQyi2O1KLcMjJxYd33Ni+hTmbHtAPulnaZo7eWemc2eCqW20n3Vt8ABQBP2k9CFUgXzmw/w/NyizuXPxPjqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooydngLPlaypcXFgYjBDLzolXWeMcf9oU6T5nsgJ4F0=;
 b=P3ANtgeQQF6jJcKGSSMDumwSKPSGani2/MslyOyEVhsypsfTCsgT2Q+pP6NU+ekWentqXYbZC78q1VMmKKVi6FcrEeNd/65TdMJeA/buEOpFTJEpnWNuePKyudD0+q+5cRNuds/AZ5ZpSWQ43kxdfbtPTNXFwVoohrfWhrMGN01hk53KSRvreMbXaFzUU7TIDxFuWVNPvGmSLiihH9uZl2NVndE4B+wAILlZ5t0nTVYZmjB64cOHnEdqtR2aLCvqUHABmlC8fGmdX/hnVEvbsxFHFlpe5pLurLL7gR3U6Cc5YpptlqDwX0n3NnaKBR6rFkDJ6+tucGepL2K5r6vshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooydngLPlaypcXFgYjBDLzolXWeMcf9oU6T5nsgJ4F0=;
 b=2lY0DSAjuXmRGOXcMcLpDGgBEZdo0/IeufwHDo+aZXvRrL+W7i8ky7tXpzCjP7I9yoh3BZ0FO8BVWs5FOFnfanjCCaIha0lp2l6MyC/gd8JtvkumIosaGTwAXcGNS92+OyjnShsAJJqeh0ZlTAHzVi90xuHoEv/GNxQR438hUkk=
Authentication-Results: hotmail.com; dkim=none (message not signed)
 header.d=none;hotmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 16:24:40 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:24:40 +0000
Subject: Re: [PATCHv2 2/2] drm/amd/amdgpu: add tdr support for embeded hw_fence
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, christian.koenig@amd.com,
 Jack Zhang <Jack.Zhang7@hotmail.com>
References: <20210805083146.324741-1-Jingwen.Chen2@amd.com>
 <20210805083146.324741-2-Jingwen.Chen2@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <f6c8da78-c925-e9a4-3591-0c27132962f3@amd.com>
Date: Mon, 9 Aug 2021 12:24:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210805083146.324741-2-Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::33) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:8981:9e07:a72d:f48d]
 (2607:fea8:3edf:49b0:8981:9e07:a72d:f48d) by
 YT1PR01CA0124.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 16:24:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f45e5f91-c109-456f-3925-08d95b522fec
X-MS-TrafficTypeDiagnostic: SA0PR12MB4416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB441667BB34059E84847FC537EAF69@SA0PR12MB4416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Wcoj+K2y6wT24eJjuLFpwEV/kHO8PF06EZrBu8zS3cw0AfFZ9pt1ESMePnIWW/S8U78sVLMI1j9ROtEas1bTwoF5LJvIvu6b5xTX06X5AmHJLcm+loOzOqeutquFRsmMjffUWO4jzFBmuHFF1BomMyAbWHOAS7hDnk5v+kWziscRviaWLMsXrUfeVEVT3WYBCBywKrUf2aMO/WSSzAsH9dp7UZNX0xA6mVx8wMsskYeDLqtdgCSzA5Scp72KufSfgy5B/dOqSJsSNW/gR9IIggDtSlqjoZGmoHmhi1ENVrO3QuT2imcYafsyAsvgEoMGtrSs6+Xlb91FhkL27ThA9a9SALM+iBAhkLKme1Zw8JHU85ty8AkbU7i7PPwCjr7QQnBjTGfOHm57XkRyfTAr8euD06tspy0tb4elz6o+r7GlC/J1MExgCoyD5SySRW66NFxiHvW4bC003pcsJ5BEIhKjnKaa6p/oJepYHF/7RXj5NZv/ldXnBnhRz+safw5vH/FyINe/nPswP1lkvsqdoOKOYbYhfP0qIb6JFiwZqVpCl+q7CiiRwtXwqcKKaXQQl8IO1oOQZf0fDuLnvRIN602ARO5xRVAWmXM01KDQmKkSewSx6P91R3dyruyDo5HPhU1ySmFCrMeXpiKUzwpS4cZDrP9aKD+VI7Eb8wO7GYULxTTm9L3lMAEesWCRcQI3+aP3cUKLkHWMh6MQh8kXhhUsI9vIhn3IsgT/iqgLIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(4326008)(31696002)(86362001)(316002)(2616005)(5660300002)(186003)(31686004)(83380400001)(8676002)(8936002)(2906002)(38100700002)(53546011)(478600001)(36756003)(66946007)(45080400002)(66476007)(66556008)(44832011)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGh0N0xOMzVXUmZ4U0MzWUpNblpRd2Z0T2Rpakd0WU56QkhncHowbzlhZ1JX?=
 =?utf-8?B?YW5jK2tUVG9lMndZaTNZYlJBTm1DeWNZbGhwMERsV2RWZkZOeDJnUHYwRzI0?=
 =?utf-8?B?ZVF6Qi9YTGc2aXkzRUJMaGVSdy9YQnI1TjdHL2ppM2QyZGU0U3V4aStxZHNj?=
 =?utf-8?B?M2hCblc4OEYvQk0xK2RBdkVXRXlCaStza2h1eW9jeDBZd0oxVGpjMUdzUVFY?=
 =?utf-8?B?UldJRU14cGhsdGY0T2treU5XZEJQUnhDUk5nOWdrNlRxUVZpNUpOZW04eDV5?=
 =?utf-8?B?SmwxWGo5T1B6eHlaSFN2c0Uwdis0eFpWU0sxeWpaZzBkOEM3N1NyV2wxUkln?=
 =?utf-8?B?Z0hSalB0Qk1NYU5CeGk1MjYrWnpSaGE3ZFlCNTdCb3N0U3hiRGxnSGt0RXdJ?=
 =?utf-8?B?ajdueUU4ZnV4MDRSZUkrTEJISUxveVZKQ1pkbU5zK2V4eFQ2bWp5MXIwNmE4?=
 =?utf-8?B?b0NsMWZOdlNqTjZqa2tHNTVlMk54V0VSdnpSVTQyRFVXeVB5cGxaU0M2aFRV?=
 =?utf-8?B?OFJ4YngvY1dqL3JWaUo4SWtZazNKZkFTakFwQko2Q2RxNWZSOXNtMzUxcnZv?=
 =?utf-8?B?R1E3czhlK21UWkxIWHNZQjRVelg3bzB2WENaRkhJaCtIUS9KWlMrUmcxQW9X?=
 =?utf-8?B?UWFidFl2bHZFUzNBamJuTEJaeExERVZlZUVNOHQrT3o4OWpzNVEyVTJ2Yk1u?=
 =?utf-8?B?dm1NN2ZYQ0RXckNpTjh6R0dRMEdHMG5qMHNKR0kxTFdTbW5hM2Fya2hYenFN?=
 =?utf-8?B?RG9ORGZncUN2am9vVGtyWWdUVDcyZ3pZVXI3bWhib0tqcTE4VlMycFp2bnJw?=
 =?utf-8?B?MjkrLzAyeC81YzJEN25HM1FicnUyK0hMcWkvOWdIeFZTeFh2Q2kyeFhrU1hj?=
 =?utf-8?B?VWIvWmtadU1udGV4NHhpOFlzY01ydzZxUWN1aHRJdzRuWTIvUktWVmRMWjgv?=
 =?utf-8?B?VVFnWlF1WVNGV0s1N1MvdStJRG9nRytNMHpiQVZaNVFMV3pHL29wVDVyRnFH?=
 =?utf-8?B?SUNqU00zb2RnaGRWLys2R0VCbzdMWGRKQlZrWlF0S0tYeEo2ZE1UZEcxbWFw?=
 =?utf-8?B?aWcyU1pLNlVPcnV6OFFhaFcxYzhJc1RvcEt4S3k3SUxtL0xvN2xXRFJ0bXBk?=
 =?utf-8?B?WmZHaDZ0OE1CbXBNUUhkUThRR1AyTVM0d0hNUHRRaGNILzlYVFZROGg0MzJL?=
 =?utf-8?B?M29rZm8xV3k5YlZiakl3WDRCU1RNWXVoVHh0TEVLQUdHUzFCQkVwZXpYUWcw?=
 =?utf-8?B?Rkl3QUVYTUVobExrZ3BacVltK05TenZEM1ZQdGVLMEpNRU93NklUU05qL01y?=
 =?utf-8?B?Y1cxRVhPOTVrWlkxdlNjTys5cTZ3ZjBDUytTa0JmYVJhbm9lZ3VPM0FlNmNB?=
 =?utf-8?B?Wjg5cGgycngyQVNlQko1K3h3anNPekJzbkY0ZHVmWVVQNXBOK3E5Z1BPZmdw?=
 =?utf-8?B?d3E1MklpUDBjalJCVVFTZGU2SG5RNThiYk9nUzZ3emdQY1NJWkw0Z1g1U2dN?=
 =?utf-8?B?ZnhjTmhrVUhldi9FRHF4K0FMeGF4cElBTXBZcytGWkQ4bDMxYXIwSEhnVlNU?=
 =?utf-8?B?OEdIeWpoVzZhQWROMXZmTWNINis5N3JIczhFc094a1FROUt5ZVEwR0hEbVBo?=
 =?utf-8?B?bERmekhtNWNPdkhXdktSc3B4RlErZG40ZWlKL00wMWdRTGkvYTNreDAyUHB2?=
 =?utf-8?B?RWtlREkyQkhiNUpPQ01zUWJzN2tEbVNFRXJyYXdOT0ozNCtYYTIzVyt6Q3JK?=
 =?utf-8?B?TlVkMzdnSWFSWlN4SVJDb2czYUh3WWtIdy9BNGEvYlJ2VUNXU2dRWW5pcnIy?=
 =?utf-8?B?RUF6RDgwaGVPRUNaMThJTGRweUp0QjhFNXdoNW02WDJ5QmhBZ1V4NFBRZU5n?=
 =?utf-8?Q?xJFSydAPA6n4I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45e5f91-c109-456f-3925-08d95b522fec
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:24:40.0351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHzdrfa6oOWbcjyGLbErTDF8EZBUctrYjPBcre4zlobjsgsaqCU7Ha+AsamZGthASNb9bH2mzlCGVsowqmBFzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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


On 2021-08-05 4:31 a.m., Jingwen Chen wrote:
> [Why]
> After embeded hw_fence to amdgpu_job, we need to add tdr support
> for this feature.
>
> [How]
> 1. Add a resubmit_flag for resubmit jobs.
> 2. Clear job fence from RCU and force complete vm flush fences in
>     pre_asic_reset
> 3. skip dma_fence_get for resubmit jobs and add a dma_fence_put
>     for guilty jobs.
> v2:
> use a job_run_counter in amdgpu_job to replace the resubmit_flag in
> drm_sched_job. When the job_run_counter >= 1, it means this job is a
> resubmit job.
>
> Signed-off-by: Jack Zhang <Jack.Zhang7@hotmail.com>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 13 +++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  5 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  3 +++
>   4 files changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9e53ff851496..ade2fa07a50a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4447,7 +4447,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>   int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   				 struct amdgpu_reset_context *reset_context)
>   {
> -	int i, r = 0;
> +	int i, j, r = 0;
>   	struct amdgpu_job *job = NULL;
>   	bool need_full_reset =
>   		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> @@ -4471,6 +4471,16 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		if (!ring || !ring->sched.thread)
>   			continue;
>   
> +		/*clear job fence from fence drv to avoid force_completion
> +		 *leave NULL and vm flush fence in fence drv */
> +		for (j = 0; j <= ring->fence_drv.num_fences_mask; j ++) {
> +			struct dma_fence *old,**ptr;
> +			ptr = &ring->fence_drv.fences[j];
> +			old = rcu_dereference_protected(*ptr, 1);
> +			if (old && test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &old->flags)) {
> +				RCU_INIT_POINTER(*ptr, NULL);
> +			}
> +		}
>   		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>   		amdgpu_fence_driver_force_completion(ring);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 5e29d797a265..c9752cf794fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -159,10 +159,15 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>   	}
>   
>   	seq = ++ring->fence_drv.sync_seq;
> -	dma_fence_init(fence, &amdgpu_fence_ops,
> -		       &ring->fence_drv.lock,
> -		       adev->fence_context + ring->idx,
> -		       seq);
> +	if (job != NULL && job->job_run_counter) {
> +		/* reinit seq for resubmitted jobs */
> +		fence->seqno = seq;
> +	} else {
> +		dma_fence_init(fence, &amdgpu_fence_ops,
> +				&ring->fence_drv.lock,
> +				adev->fence_context + ring->idx,
> +				seq);
> +	}


I think this should be in the first patch actually (and the counter too),
without it the first patch is buggy.


>   
>   	if (job != NULL) {
>   		/* mark this fence has a parent job */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 65a395060de2..19b13a65c73b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -254,6 +254,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
>   
>   	if (finished->error < 0) {
> +		dma_fence_put(&job->hw_fence);


Would put this check bellow with the job_run_counter check


>   		DRM_INFO("Skip scheduling IBs!\n");
>   	} else {
>   		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
> @@ -262,7 +263,9 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
>   	}
>   
> -	dma_fence_get(fence);
> +	if (!job->job_run_counter)
> +		dma_fence_get(fence);
> +	job->job_run_counter ++;
>   	amdgpu_job_free_resources(job);


Here you  modify code you already changed in patch 1, looks to me
like those 2 patches should be squashed into one patch as the changes are
directly dependent and it's hard to follow

Andrey


>   
>   	fence = r ? ERR_PTR(r) : fence;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 92324c978534..1fa667f245e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -64,6 +64,9 @@ struct amdgpu_job {
>   	/* user fence handling */
>   	uint64_t		uf_addr;
>   	uint64_t		uf_sequence;
> +
> +	/* job_run_counter >= 1 means a resubmit job */
> +	uint32_t		job_run_counter;
>   };
>   
>   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
