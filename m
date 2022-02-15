Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28128C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 13:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A651E10E376;
	Tue, 15 Feb 2022 13:04:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD62010E28F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 13:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/xsfrvhHur7NLNedSwuQnrWwt5qwx87MQL0shmRylqVoLdscByUJFZfm5cAgqtjzG1R+/kxOiO/VMeuumWxqHJmqj4U4yipJLNZkXaygq28swBePa2shONkcl57sGnoW7ZpFh9lrxhQm4rVZOgwxlrx3KwOYtJ0CzEmYAd64UlnuUsEE4GRpTyntrv3e0Jh8uVQDHu4/SfYe2kwjFEbi5DgQG2jHJTQLWXDD8bELnbqqhqsKp/kd85h5XNmfRh9Eka3HO43f/xtIiPwcrjbfkgwuCbPns1W6JY/KonSJPZCOkao+rEaoKz9cB8DTS8EnSfPT1wTHLkZ90TzNF3H+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl1eoqACaOvT+q6zv3lxOBBFD61c5EwJy2cVpLqu63I=;
 b=lj+VCGR1Eb6rlnK+J0fjx8qNDYp2EUu3hrvHi/hLQ1wH9vTACRyYGPkx4Ak5CjJQZo/m0ROCPpJ5+vlW9+TuYvT+EGfyNs7O9uVMPkzbvwI+yLtMcLEuYPyOz/ScHRqi0ilXicpct+w7dU6ZvGPtnZoFKYpX0zh/uSD78oPKnEQLuAfpPl20rZcqIKrewjVi8gqqE1T+m9HcpyfqHBwpayC/trJnSSY8PnRjtiaYUC4Auh7CFMitKm7d5Z9S1apFC2vUdKPQmwJO6r1nLHHWd0Cnb30HDSpBbiHCyqxku6eXtK+tbuOjA/DxsqfRBs13PInrHWy5fsdWoNaQHqT3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl1eoqACaOvT+q6zv3lxOBBFD61c5EwJy2cVpLqu63I=;
 b=ifGrwBGvm4Nu7B1u0KmAvieMPoiwNLgeLo3wqcwcTtm+uCKvWik0rCWKIItEAJob8j0aDgfa8XxSjZSUBEJuisoQLbTpgLoOBptVaFxxBoUw+tV2XL+eNhJF96ca7VRgSbI8e3ZDpvWBtIlF3cXWIG03tLbi3X5zqzFUP0Cf0fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MWHPR12MB1693.namprd12.prod.outlook.com (2603:10b6:301:10::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Tue, 15 Feb
 2022 13:04:50 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 13:04:50 +0000
Message-ID: <49ce635e-9f7c-e47e-d1e2-ef9f23f4d88e@amd.com>
Date: Tue, 15 Feb 2022 08:04:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/sched: Add device pointer to drm_gpu_scheduler
Content-Language: en-US
To: Jiawei Gu <Jiawei.Gu@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, monk.liu@amd.com, emily.deng@amd.com,
 horace.chen@amd.com
References: <20220215112950.13898-1-Jiawei.Gu@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220215112950.13898-1-Jiawei.Gu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::41) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d1367e4-6556-4b08-4ed3-08d9f083bfd6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1693:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1693C0F70BDA3AF84F90B8F8EA349@MWHPR12MB1693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:73;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vt38YJ8c7MtxEulkE8sqJq7fQujIQHtVbDEFxY5TrzUMp6nGhJHf9PmxZwKhLoOpiSHiQUtwxZx9LQvJCHwbY9ii+L1a53Gp7RWgAM0inL9Ry2i7LTdJksvbJIA4DKY10BANWvDMl0cyZK4v+HNa2m6Qm1BpdKtVbP/d+PN2Wh6i915SGqCPyFYjSF8eA/+WF098qrNEXlzH8pysB9bZRO4/8ZF3ca4h/WSEdWm59zMjU6N5pE5HZhoD9oMkCWbWlxIblnL3fA8GieMC+YVJWoQDUG9cP1CudzzFBKVIAEm/VzNpR6sGHzW04VVXyk6k/sNeO5+vup2HKHryV5Q/ibFrHY7+NbxMWBd52Ixd1w6cP2O/SUo9j8WVWxnvxpgX3KR5IZHTST6w0s7GEOhli+3PtOez9azJaIaXUnuhWiFUZDIPqCrSkBzwrXGnIgoXDzxDQD98uMlwndByOOJHU+bWFHGoZOiSj+ytdESHHGmH3FN6goPi62Qzj0zY3vMdPvtxmsT07wsxOOetkQXedMOW6O62QCwQRr6w0woTPG4OL+3ZDEkVYwsSvQsxJWlBUADB09XXzA4ybgmde/0wvVNIHS0NXCtVfUG3mWF2g/CKue6t3pR4duwQjU+5cxadb8X+x+orOXjBs28FcqSSCCr2jM1JseZn8Fnn0eYGxXINVnhXPj/BhR139B2WKsO7Mo7CqQVOsnHKY+UQY4qV+OjS0JiHlJPo7U6xlfVWfts=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(31686004)(53546011)(2616005)(36756003)(2906002)(186003)(8936002)(8676002)(6506007)(6512007)(6666004)(5660300002)(66556008)(508600001)(316002)(86362001)(6486002)(6636002)(38100700002)(44832011)(31696002)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzB5djdyRUNVVC9aZ2toRmRLdzBra3dxUklMK1FFM0dyK1U2cWErY0tsYWh3?=
 =?utf-8?B?ckFkVFFGV1dUaTFyaWRiRENQMDdlV3ZNZGZObFRRb2dsb0ZPWEJsUEwyS3Rl?=
 =?utf-8?B?aXNsbDVSWlhNYTJjRWtvSnNoTCtuM3NoSDFrTVhUVFh4c2gxOGJnaURDWlZB?=
 =?utf-8?B?c3lnSDhDYzdJMEJ6QTl2Z0dUL2ErMUJrQTZCN3dCaE9xMnBSZDRTRGc0bzNL?=
 =?utf-8?B?VUNKM1JmSUhVWHdlNE1aQ2lYOCtOZFFiYkhodlRLZ3hSN0xPc1ozVXJrZ2dT?=
 =?utf-8?B?aGljaDN1aEEyZnJnVlBIeGp5Tkhybk04N1doQzlROU9tSitYVHhXRXVQdzhu?=
 =?utf-8?B?ZUhzSFYxWXo1K3lZdk9nMEdDTlhkQy9EMC9QUUZWSVVGY1BLeGdVNWtIeXEx?=
 =?utf-8?B?K0ZvSjZoR3FUSVRyYkQ5TFV6RWt1UFVNV3hRdk9SMFZqYXphV1c5VFFiQWti?=
 =?utf-8?B?SVYrZzJnbGV1bmdtRTdrRzdzUUE3R2VZYkNYek9pMStEVE1XWGZJSis0VGxi?=
 =?utf-8?B?N0luUGJHSXZRUUN3TXg2TzdXeGVXaW42bGF4YjJhQiswUy8yREQ1cnBJaC91?=
 =?utf-8?B?WDgyVFl5V2VFTGU3QktDWXF6WHJBTWk5ZTdCZzcyWUFoKzNlay80a24ySXRW?=
 =?utf-8?B?WGpRNkMzU1R1VlRjY2V0bHRtMGp6RzNNVW84SEhBblB6YnRNNlNBWVhYbGN4?=
 =?utf-8?B?d3JVa2diMlp5eUtGMVZTVy85ZTRTMDhXSFkzcy9YRndxYm9oYXk4L0wxMUNi?=
 =?utf-8?B?bS9XSWJDcDVVNGZwRHZMV0tZRWV3QzZlME9BK0NVQmJPS0dRRSt4Q2kwNTh1?=
 =?utf-8?B?Qi9EOEJuK1pRdVhtbmxIWlpjeG1nU3Ywa1NEUEZFTUxlN2RuMHdKU3NUaUNT?=
 =?utf-8?B?OUxwUUpwWTV4VGgyeFlhRVRhQ3Z2OU9iMy81bTZ2a2JEaEZxRWZKc1VtdUJF?=
 =?utf-8?B?cC9GMFBnY2tHanl4SHVsYmxENWwyajBsdmlDUjRRMEtCeFdpeSt5SThRRk1s?=
 =?utf-8?B?Slkxd2NiMGdaSDdCTnpUWEdPcFgrWm16VCtveDNVY25Bb05BOTFqR0lPWDR0?=
 =?utf-8?B?alpFb0RVSkVucURHcEVVOVNIRTBKSDNwQkRDNGNLZ0lKNVNPTkszOTVSVkZS?=
 =?utf-8?B?NUZLK3lLNjQyQ0s0akVsejdOZk95ZVBrMHFXQk5IeDZIdlFEVUx6WGIxem5V?=
 =?utf-8?B?M3NDTUdKZHpWRGRwclVob281QUNpZncra2twWDRkUEtFNkRPU3ZlK2VSNWoy?=
 =?utf-8?B?VlRFQm5vY2ZMRlJnVHBzTkswTGw2MFZGQUp0b0ttK05iUzgzdGQ5bkZQRExu?=
 =?utf-8?B?V1g3Uk9tNVFOZ3MvdXhkcVQrRVBrbzZLcWRRR0Zsd2Q4akZ0cE9hSm1uWWN0?=
 =?utf-8?B?N1crS1M4ZHdKY2dKU3VNQTVBZlJ1anU3N2puaERueEg0ZTVCTXVTTXdMY0ov?=
 =?utf-8?B?YkFGRFpIUys0Zng5NElkUkliRUszTjJnWU02ZFJ6RjRsK3k5NnN5bTNzRlZz?=
 =?utf-8?B?ZEVFQWJhcVVXbTlSM2dCbTBReXNCWjZRdFlJY1BKY2JkNC9VcHpVWmFUWmk0?=
 =?utf-8?B?MktqS0p3OGZZTURpV0VCZTNyV0QvWFpHMVY3RlduWTR0V1VkK3VPMDQ5T0Rv?=
 =?utf-8?B?TnJWRUlrMTRBeWE2WmExYi9wVUJOYm9nK2w4L1ovVUkwdFRLTUt2RHhCTWYw?=
 =?utf-8?B?TkhUT1BRNThkbDNWQnJkK2ZGYXgvQm13TytVeHhCOEcySFJVRjBIVVUzVEw1?=
 =?utf-8?B?dVhFWnI4Y0hzNkpraFRxZStCSDgxS0lkZm91cGkwOE1wZUhNOTFUSG01VFdD?=
 =?utf-8?B?WjJHTnZnNC9iNWI0Umc0d01HMXZjYlVibWZ1WTJJQmNSYXorVU0zbHpFWHpN?=
 =?utf-8?B?eTdqL0g3eHh5UjRCRXR2dDNpNGR5SU9oaTVFQkF3YTNMaWFka21JWmI2dUl4?=
 =?utf-8?B?U3JSczluMjkvdWIvTEtFTTZma2hpVjJXUVVPRTU1NDFmVFYvWEdRK0tRMklZ?=
 =?utf-8?B?Z2JnNTA2NnZvdlVaS0k2dk5DcU8yVjlLMFdmM2VYdnlpeVcvSnV2cGt5WElW?=
 =?utf-8?B?YWc1RE9SdTJVcW9ybUZNbXJERjU0ZVZXNHFielVSZ2t6WURLUzBqZWx4dGg0?=
 =?utf-8?B?cjNTS2haa1JIRmRkTHFVQ01jcUlvSzlpUWpNZFBrMW9iRGMvY01Fak0zL1Rs?=
 =?utf-8?B?SGdWQS9GN0wzc2FVZm9CYithdjdrNzRZMS9rdWExM3ZZL3R4Wmw3TnpXMVVH?=
 =?utf-8?Q?yn+RiVPwUVM0OMxv/rXI1UOyF1PJ1OA2S+fZZ4AmLc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1367e4-6556-4b08-4ed3-08d9f083bfd6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 13:04:50.2323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajkq5Q/aOhcNVMGeJVO7NY2MAseduklOPLiqV5T+2/nC5XWokbPTIy1QbWOVb3Y1yqN8bkQzyh83Xla2BvwmiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1693
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

Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-02-15 06:29, Jiawei Gu wrote:
> Add device pointer so scheduler's printing can use
> DRM_DEV_ERROR() instead, which makes life easier under multiple GPU
> scenario.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 9 +++++----
>   include/drm/gpu_scheduler.h            | 3 ++-
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 3e0bbc797eaa..4404af323321 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -489,7 +489,7 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery)
>   			if (r == -ENOENT)
>   				drm_sched_job_done(s_job);
>   			else if (r)
> -				DRM_ERROR("fence add callback failed (%d)\n",
> +				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>   					  r);
>   		} else
>   			drm_sched_job_done(s_job);
> @@ -815,7 +815,7 @@ static int drm_sched_main(void *param)
>   			if (r == -ENOENT)
>   				drm_sched_job_done(sched_job);
>   			else if (r)
> -				DRM_ERROR("fence add callback failed (%d)\n",
> +				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>   					  r);
>   			dma_fence_put(fence);
>   		} else {
> @@ -846,7 +846,7 @@ static int drm_sched_main(void *param)
>   int drm_sched_init(struct drm_gpu_scheduler *sched,
>   		   const struct drm_sched_backend_ops *ops,
>   		   unsigned hw_submission, unsigned hang_limit, long timeout,
> -		   atomic_t *score, const char *name)
> +		   atomic_t *score, const char *name, struct device *dev)
>   {
>   	int i, ret;
>   	sched->ops = ops;
> @@ -855,6 +855,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>   	sched->timeout = timeout;
>   	sched->hang_limit = hang_limit;
>   	sched->score = score ? score : &sched->_score;
> +	sched->dev = dev;
>   	for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; i++)
>   		drm_sched_rq_init(sched, &sched->sched_rq[i]);
>   
> @@ -872,7 +873,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>   	if (IS_ERR(sched->thread)) {
>   		ret = PTR_ERR(sched->thread);
>   		sched->thread = NULL;
> -		DRM_ERROR("Failed to create scheduler for %s.\n", name);
> +		DRM_DEV_ERROR(sched->dev, "Failed to create scheduler for %s.\n", name);
>   		return ret;
>   	}
>   
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index d18af49fd009..38a479879fdb 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -302,12 +302,13 @@ struct drm_gpu_scheduler {
>   	atomic_t                        _score;
>   	bool				ready;
>   	bool				free_guilty;
> +	struct device			*dev;
>   };
>   
>   int drm_sched_init(struct drm_gpu_scheduler *sched,
>   		   const struct drm_sched_backend_ops *ops,
>   		   uint32_t hw_submission, unsigned hang_limit, long timeout,
> -		   atomic_t *score, const char *name);
> +		   atomic_t *score, const char *name, struct device *dev);
>   
>   void drm_sched_fini(struct drm_gpu_scheduler *sched);
>   int drm_sched_job_init(struct drm_sched_job *job,
