Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB5DC6FA90
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 10:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 921DD10E1B5;
	Tue, 27 Sep 2022 10:04:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F313910E1B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 10:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSa8+v2ktkwmv7Bs8bb5HRkXStNERuNsXIZFLoFmArddHGgiIfFTxf3wrXFydEbkvPRWs7Drrp7ENGt7fTQ2It5nE7sCkvvPR4odO2SplrGwS22lcFDq/Q2BGL1X2tNZN1wG1V651U5ZudaUCXOwBj9izpL9CZt0TsrFq/EKQLg97T3Urks1atyyAdQ08RRw+7LrO/M1cZmR2EcwkyXkQtl+zr8qNSZAqhC0LubbfI4CGN+eTrcCLuVikFKXn8gvZTmL6nli72GGaWPGhbjoaKru6MXK+rn3RKpO9Ifwxu9gH3d+3KFXs+l/fWnh9WCI+64mAb99eYBNm0Tg+X8kPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5moI4q6BOnio3SO83TOHVbvzlxzL1Sa524Nsc/9IIOM=;
 b=THrecjVsZFvGIapj/jI7p7KyL5MXOYYbaoyX9ORrSvatEYda63K0epPXMEe9qk8nvcmyC6L/k9b1EVCf2UhMnefgfEVzUm49hBaA6HjpWpp2tTVNPNNh/fKRSuwEtclOAfXSXfzth4PpXQfc6hg7Ut4M/mRwpkeoL5hpPKU+lQo0rXEnLWkcgE0LZ57IHVcSvMPs7rBrQaKb5neEvZb60y+9cPXHnnLlfIdQPlQn4Stbfgv15kim+zQI16hqcnLy8uC13A1NUvfzrMxZPLbwk5gSy4BzFqaRXOuAiGFNKxxF3pV9HUOMPagBPqplpn5eVhGet4jlHZAzybBQ7qb5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5moI4q6BOnio3SO83TOHVbvzlxzL1Sa524Nsc/9IIOM=;
 b=Jqbsm/3X/SsF1jPj0+h31sfDrBuMbosgzbR0w74SWIkjBmI9Am4LrnOwk7TawzMz6TYBXjt+g3oWhTTxcu6mu+ximS4J9yMSIP8M7VmTjjVsAQOkgVt0t51gY2K01X/nQY8/kTwazaBwzUsxuqw7DCQ4jKumUdwNcdf5Pcmzva8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 10:04:07 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 10:04:07 +0000
Message-ID: <538ae193-37e6-40b2-cff7-bcbeab6e4fe6@amd.com>
Date: Tue, 27 Sep 2022 15:33:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 4/5] drm/amdgpu: switch GPU workload profile
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-5-shashank.sharma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220926214014.5450-5-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bb7a99-429d-4655-6398-08daa06f9d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huuOlWTkA4lLPPvkNfhtGcDkbhLDY/tCEOb3tIKvEYObhimM7AkoBPGaYnnu4NkdxXp6MFCSZ4axioOqBTfUs76qwM4/3DrA6xOUUupihxtkILSkixhUEWoFwv3hKDi+DXVlYnS8lHqSkY+NPwT6rQQDduqfOEmqEVtDck+yehfQJZjDNV5TKWm0lumqy/KjoQdp1ydXLkck3Kyef+bz25jRfplm7wZaqqAKNoNFN6+Krf7ZiC/Bt36An9k2w+67RCSothc8zv1mYEcgs+Vz9GdtK6sm3NNN8YTbLd+QqX5/U5UenFGj0b4Mhd7TxTF3d/VyUX3nyxgGgfLpAtDiDPnXhi9eKLRtjcMDWuKQCk4p97SVh8J+tBd0+3Qg1P0a23XlxkJYTPd+A7xSRbM8iS/+cBo37ZGZgH58/QhkDwvHyav9cNNjI4oH/sl2iVhNTv558PammPMa48twrHvjtmw6QTamABPvJLvYuoEvZXRWbo2CSpkXIv2MVf5XRS5V5j5k6qQlVM8ZrztE9ZDSLd+bodFOkxD47X79XWzZEa+WPRI4lTtG/h/NrLqeYLFLmabJSgXirYKnb99MnrhIYYDzs3Ga0Al3yPwovLI6+m3leav8ywL7P9YvfLWyOmpUuSefWKIrmqkv8szEOqw7qIDJAwOmJn28CFY2uASNPeqcfjM3ODJIgCyB3EObk38SAH6wSb3tsl4OcIrmjiNB2BGxv5wkbCmHIJOpbkfWo4htWaBPs5CC+EChiQqlUfYXdAyhIFD0sm9Y9XZUKfStUJOieiOBmLRJn62jdN/Me/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(66946007)(2906002)(6506007)(66556008)(66476007)(26005)(6512007)(5660300002)(6666004)(8676002)(316002)(53546011)(4326008)(6486002)(478600001)(38100700002)(186003)(41300700001)(8936002)(86362001)(36756003)(83380400001)(31696002)(31686004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFVVG5kR1cxNS9Qa0puclVta0lTNlZoY2g4ZE02L3BiUnMwUkFCSkRKMDZz?=
 =?utf-8?B?dDUrUGR2QkZqSmlVMkVWYzNKTlliaGdxQlJUcXduUXM2UE5KWmphKys4bm9p?=
 =?utf-8?B?TXBhMEg2ZnhxdXdQYU15WEJ3T2ZjRmtKa2dJT1B0MDR0ZzcreDFwVWUvdW5j?=
 =?utf-8?B?VzFtL1lLV1E2bDMzTStHVUJDUlFpSTdESWtKNnVQaXYzRml1L0VvWDdIWkRj?=
 =?utf-8?B?WDB2VUFPYm43am8vakU0cUdWOEVBVU9mVnRFYnFVL3ZremVJWkFPb2lqMmlv?=
 =?utf-8?B?RTc2dmZialVlREF3c21MYStNWDlQTDNEUlFaaFYvcmk3ZG9zVGp6R0YyS3Ns?=
 =?utf-8?B?SVZmaTIwT2NHS0RmUmg4b1hqcGMzS1RFRTJaWFVMQ1BNSVJOdFdtTWlRbUZh?=
 =?utf-8?B?RFU4MkUrZ0FsbzlhU3I3N1dPYzRIYzZzMVVQTThXTnpYbkJiR1daNk9JMDdF?=
 =?utf-8?B?dG9SY3QwOHZmY1RMTWtncElQWU8vdjl5bkk5ZGt5aUs1VVdpTm55YWYzOGo2?=
 =?utf-8?B?NnhJckp3VHBDRFhlcmRRa3BjRkFRaDU2ODNKbUR1MjBod0FjRm1yTWhZMFc5?=
 =?utf-8?B?TFYwY1B2M2tTby9TeCs4SEF4c2xwL3E0bkluQmFnd3dmVVpUSmZTdENCOEM3?=
 =?utf-8?B?QXVLcjNaR092V1NpUis1aDVjWERKWHZzdUVBWU8yNTZQeVRJcmZLdlpTNDIy?=
 =?utf-8?B?L0xBMHJzclZLaVE3d0gzeHZ2OUowR3VlRWgrbnhhNCtMbEhBSmVNc1RiVkdJ?=
 =?utf-8?B?Z2RRVHZUVjhxbzk5V1pHc2NLRFVJOXV0bG1EZXVZVGpGbjVTSDQzWXM4akVM?=
 =?utf-8?B?TlRlS001dEg3clVXZ3RjRjZQYi9pN3k0c0F2SEoxWS9VVURQYjFRT3hNeVpx?=
 =?utf-8?B?N0RjWGlJdnFKVTVZWjg0S3pERktJQzFhL3FiaWhHRjhNTENwU1FjUnlGLzUx?=
 =?utf-8?B?cXlQektna2Nrb1J1d1lhM1lrTEprSy9kTXR5THIxV2F1cXZLRWQwL0RjSHhW?=
 =?utf-8?B?WWFwMWdIZG5PNDN2WVZSbCs2dVYzUE9EOVhQa3F6bWc4SkN2WmJHam5OaHVa?=
 =?utf-8?B?UkJwM3lLWHlPSk5wbmVWZFdmQ2xwa3hvM2FBNU0xNnlaU1dDZkx6aGZZbGJl?=
 =?utf-8?B?SXduK00xUmNYZU5BeEJrRER6bW1HWllyZHltOEM5a3lyaFRwUUE5UlBrMXI4?=
 =?utf-8?B?MDJ6d2ZYQW1yazFVQmt4ZEZ0VlVhSGdLb1htTzRaN010VnpLRjJBT1h3OVRp?=
 =?utf-8?B?eGt1bUxFK1IxTFZPMGQ2b0RkVkRRMDZaM1F4OEFHdHRUdFhkYTNwN1lxSHdT?=
 =?utf-8?B?SHQzSzBDNXFOOWNZWCsyVGFrV21HR0lYYkZySEtyMzBUTTJpL080bnFaYUlL?=
 =?utf-8?B?VHc3ZGNIUzBBTlQ5RVVha3lrZUdOeWIybXlRdE52Y0JscXVldVZqVVVlcmd0?=
 =?utf-8?B?MmlVaG4vSHE0RVdIV2YrRU4wek1YWktjK2RwYnltY2poYkZNR2N1Z0VYTnhU?=
 =?utf-8?B?U3FhRVE0ZGFDSFU1aGY2bmlIN2pxcmFrb2ZvRzZDeXJOTjBDMXpzN21MOHhl?=
 =?utf-8?B?S0lNL3ZLZ01xNHhsend0d0lUS01pYkI2U3V4bW9TYkZyYmM5cWpYMjJXVmtq?=
 =?utf-8?B?V3MzNUEwWjRWMGF1Y0o2U3dlZ1dFQjJiaEJYdlhSVzFmRDhxeE1jVmw5bGgr?=
 =?utf-8?B?ZEg1MGtsWGRodlJGQ0hlK21BNktYckVZbTRRcG50MUovb2lSbFpER2UvVC9r?=
 =?utf-8?B?YlpPN3FuZWI4eldiSXRJQXlQYm0vZlpkcTI1NStDc3BVR1o3MU1pWW0zd3ps?=
 =?utf-8?B?RE0zUlhXaFBiQUdRaHBMcXc4NUV4b3RxcXE1SmxMcFpQK2lQaFhKdVFsQXZi?=
 =?utf-8?B?dzczcEg5TTNEUmlNc0Z3OGhUR3c4blg0VnZiR1ZBOFVBSFRRVXorcE5SZERR?=
 =?utf-8?B?K0hVdnFISXE0Z29lVzl6RGNtVVg2blhaZytpOFhFd2lmQ2RvVXVtMmYySDNN?=
 =?utf-8?B?Y05DZGpFaTN6Szh6M3pJVUxTREExSEtTMjBBOGxpRHFLQWxLSmZFY0Q5SXVo?=
 =?utf-8?B?T0RyWG5RQlUwV0VMdU82cndXeUg3RDBKUkl2OHZlN0xvUXkwQ3YrNURNRnBP?=
 =?utf-8?Q?Y8Wjcgbdj/JWsxu5Em9zkVZUi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bb7a99-429d-4655-6398-08daa06f9d6b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 10:04:07.2814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD6DjxOpvDdtpNRaM6FpSD3HBEhGOU+0bF6tIcEPOlKKNZlVBpTLKmucDS3NTbHF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 3:10 AM, Shashank Sharma wrote:
> This patch and switches the GPU workload based profile based
> on the workload hint information saved in the workload context.
> The workload profile is reset to NONE when the job is done.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c |  4 ----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          | 15 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h          |  3 +++
>   4 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index b7bae833c804..de906a42144f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -237,6 +237,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   		goto free_all_kdata;
>   	}
>   
> +	p->job->workload_mode = p->ctx->workload_mode;
> +
>   	if (p->uf_entry.tv.bo)
>   		p->job->uf_addr = uf_offset;
>   	kvfree(chunk_array);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
> index a11cf29bc388..625114804121 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
> @@ -55,15 +55,11 @@ int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>   
>   	mutex_lock(&adev->pm.smu_workload_lock);
>   
> -	if (adev->pm.workload_mode == hint)
> -		goto unlock;
> -

What is the expectation when a GFX job + VCN job together (or in general 
two jobs running in separate schedulers) and each prefers a different 
workload type? FW will switch as requested.

Thanks,
Lijo

>   	ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>   	if (!ret)
>   		adev->pm.workload_mode = hint;
>   	atomic_inc(&adev->pm.workload_switch_ref);
>   
> -unlock:
>   	mutex_unlock(&adev->pm.smu_workload_lock);
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index c2fd6f3076a6..9300e86ee7c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -30,6 +30,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_reset.h"
> +#include "amdgpu_ctx_workload.h"
>   
>   static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   {
> @@ -144,6 +145,14 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>   static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   {
>   	struct amdgpu_job *job = to_amdgpu_job(s_job);
> +	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
> +
> +	if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
> +		if (amdgpu_clear_workload_profile(ring->adev, job->workload_mode))
> +			DRM_WARN("Failed to come out of workload profile %s\n",
> +				amdgpu_workload_profile_name(job->workload_mode));
> +		job->workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
> +	}
>   
>   	drm_sched_job_cleanup(s_job);
>   
> @@ -256,6 +265,12 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
>   	}
>   
> +	if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
> +		if (amdgpu_set_workload_profile(ring->adev, job->workload_mode))
> +			DRM_WARN("Failed to set workload profile to %s\n",
> +				  amdgpu_workload_profile_name(job->workload_mode));
> +	}
> +
>   	job->job_run_counter++;
>   	amdgpu_job_free_resources(job);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index babc0af751c2..573e8692c814 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -68,6 +68,9 @@ struct amdgpu_job {
>   	/* job_run_counter >= 1 means a resubmit job */
>   	uint32_t		job_run_counter;
>   
> +	/* workload mode hint for pm */
> +	uint32_t		workload_mode;
> +
>   	uint32_t		num_ibs;
>   	struct amdgpu_ib	ibs[];
>   };
> 
