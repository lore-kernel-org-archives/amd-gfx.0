Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA71C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 10:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06B810EBBA;
	Thu, 17 Feb 2022 10:40:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453E710EBBF
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 10:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3YojYbRugGEq+SuAoLkOg5Hu48amP+1RyuHD0LcB9YcHew5O1kN3ILGpTPFQYeZ4Jhi5Ev7rGKuKsR2abO8ppK2jbd9gtqmdOr3T39GF3+vHTFEBit3kaNEx7+p+bBlZmQ3PFQ/u6ms/CVS/JlJbbbp3hC2wR6Me3PTq63THLrHvfBmYKJb4UBdC3fFWMI+OuvpAByaCItfhyowY3H9GsG0ZTd3X3RK+cbccXNmxKfMp/VM/nx4x/TIt9xAo4E3+pETvV6z30QgmwQIYZ5yd/bI3CtOTRVbK1Rj/ChOSfQuEeFSpffEYhHnYWsdUMcFb7GtfF6AEexcguQJmHOLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ5Xr4TdODVYrz56rLdWErFV6HHTE3Za0B+WAgOuJ4M=;
 b=mAlogwHe90lm5p3v8CfdYzU40v8uz/9f+f9AaTmyYcvqGxlg2Xmp6qbd72vNTFQ0LKRqxN119/UiPbJ9i64S9XcFumuNwxgzG4x7PwEnXhKa0mZxXToBx1HjSqKHIEjhfpA8EXtngjbEXb3Rh56JmNNDHLOikQqzD5XBhYkDmujkdQR6eC/Xh+d4oi4sqIlVHEeXayP5jRvGu8F5l2H4LVTf+DcCLVJPMBBXYL5EEccZIka2ySWa5gSUMVJppH+ENKc4PRVMKqG18+1SAMLC9bPzwwtFNd1VS3sT+OccnpP0eSSyOBNaapZE0EMHxOGOCvD3l8zBvrOsz1Hdre4l7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQ5Xr4TdODVYrz56rLdWErFV6HHTE3Za0B+WAgOuJ4M=;
 b=iQlJWmy3eVIBcQLplTmcxML1O89GEgkwtXFh7l8jAtd0aSMv2yAH3eId+XD3ADWkhrldSFbwXsdvJLMVM9Cv9mjhkaABnrbgtNxkwGz5yAIhtCu1noKXGRwqsON7w7UZkMOy5EwfKVyAECtwgSEQ3lC9TyQZpSAbTzMO2On/D7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 17 Feb
 2022 10:40:32 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e920:c950:24e1:1154]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e920:c950:24e1:1154%5]) with mapi id 15.20.4975.017; Thu, 17 Feb 2022
 10:40:32 +0000
Message-ID: <a6f5662b-e9e6-7440-40aa-4df532db350c@amd.com>
Date: Thu, 17 Feb 2022 11:40:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/sched: Add device pointer to drm_gpu_scheduler
Content-Language: en-US
To: Jiawei Gu <Jiawei.Gu@amd.com>, amd-gfx@lists.freedesktop.org,
 Andrey.Grodzovsky@amd.com, Monk.Liu@amd.com, Emily.Deng@amd.com,
 Horace.Chen@amd.com
References: <20220217103802.5918-1-Jiawei.Gu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220217103802.5918-1-Jiawei.Gu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0346.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::21) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d4f4acf-3710-4796-50f5-08d9f201ec13
X-MS-TrafficTypeDiagnostic: MN0PR12MB5785:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB578514C8F7E6379D1083DEF883369@MN0PR12MB5785.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhkLjglbGy+PNKM13Vz1Jj1732GPg2+My/7GHJZC4HVdgDpdgtCjhSnLqPrktIuz9o05AnE5yKUhnRZKRKJWBYuUbmsu6aCtvPPXlIMO4Tg84JiDWqXJK2Hi+PS144AY80b2IDjxwd62u5aGGoLe0ffOuwJMMg/Z/XKhiz15qh0AK2cR5QQBVtIGngLgGcn4Ua+ntDrfg5ngv0ODROgHrQQm4hKfAsvyjRwORGagfKXnazvIX4GtnldATDDR9ZKDqwtkRD4tFieATWMAXFKeNQ1voCQy5OoI03DFBImxFkwtX/tj/g4Q7WOmZtfEuyv+q95VP7gD71z60lf7RgSMIgLs0ilTBd6cya9ue4YEBSw6CcoWfsCgJqNit/vHXChCoaGhiazp00wJPasn0lp5ycJX5UwIiSPi0K/DisbLRNvl9aIuvwOIHRqLkGHIgvOdt8kATHa3FiFhTsdIsA6EX0AZcJJbecKgDiihBvFGZsTbU2pPoajzdeAqtnSM7xpuMQJikezlWRbFWpV392PhQ+5RXMoXx3W2TG7ptRFxeMWqEYcuTW1FoeUVZ7E389LoqMfIge19vs7a0W/RLVY1clDe8ZFJd/L0hGPVXD9qp0LjQya90m/cYyVdEkNmrcEAVH0W8GFAS+QFsNX7/AdBJ0N7cZHV/7vj7VC+62NRxfTTiC6K3uRiBIdksKS/qHpRQHUV1XKMNOi5FzLDCZCKedVueAk57Rsf3ytmIC8qumOgyrl3wTuBj4fx94ssfDFP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(38100700002)(36756003)(2906002)(6512007)(6506007)(6666004)(31696002)(6486002)(86362001)(508600001)(5660300002)(66476007)(316002)(31686004)(6636002)(186003)(66946007)(8676002)(2616005)(8936002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1IyZnJidGQwQlpoUlZkcVptVTM5VlZVaktDbC9NbzQvanc5clRIZDhIbUoz?=
 =?utf-8?B?blRKaHJ3dnNIQkNQQWF1K3EvREpzZE5ZY0hVMVJzblZhQ1hpLzNnK25BQUZN?=
 =?utf-8?B?SnUxN1lIOEE5U0x2d3h0ZDFYbExLWkppRS85SUFZZEF0Y21OZFFUaHlBT3l4?=
 =?utf-8?B?cjYwUnEwbkNsR1JlMitFMjhheVFQR2JjYWsvdUZvcnVGTDg4aUd3anJ1cGw4?=
 =?utf-8?B?SUNTQmNMc1g2N1AxcmpoZ3E1R2x4d0lNTUhEOFlhblZFWFpqNTVwQm1JbmZQ?=
 =?utf-8?B?a2tDQ0EvNkpDK1hzMkNhTWp6VGlTU21BY3VGdlhsbDdJZms2S0duZVZJekpC?=
 =?utf-8?B?Z2lVZ2p5VE51eG5uVFVZV3g0V2swdzNsT1hpZFd6emk2Y0Z5NjF2WmcwQ2ZW?=
 =?utf-8?B?dDdDZHFvaGNBcytLQWdHRllMK1FabEN4TFExVStpR3UzTkw4YVJkRExCWnZh?=
 =?utf-8?B?NVh2MmN0UzJCZTVCaGhpTUdlVjlBYTc3YzFVQk1NSHlzRmNLSUVDTnhPTjZD?=
 =?utf-8?B?UWhpNVhWUFFwaFl5Ukp2ekZ4TDAzT253SVNwR1ZDaWpzV0x0WU13bGRpWEI1?=
 =?utf-8?B?UzhLNVFWQ0FMWk1ZUnZWRFVKQjM2Wk1uY3loSFJTSk9ERlJFU0RLRTJiSWhK?=
 =?utf-8?B?c25NdnVrVzNKZTBEV2VOMFhnTWVOY1c1WURuWDJ5cWZvUTVMUmVMbUUvWGVX?=
 =?utf-8?B?enVTaHJNTnNPL05pNGhyN2toM1A5dkVUMXJSbGwvZWp0aVBLbXVOTXpMZkRp?=
 =?utf-8?B?V003NnRBYTE5Mk80UitnajBjeW9BZmd0UEpQVFlYU1NSV1NubGx6dTI3N05z?=
 =?utf-8?B?eStOWUhDcFdhYjY3VVBiZ3NnSnZXSk1xS3R1cU9FT05hMjRSZGI1UEs3Z0p0?=
 =?utf-8?B?eEk1elFrbWp3aHVHRGN3RW5vc3l6YmI1R3JqbFkxaVFlaGdxNVZld2k0WnRl?=
 =?utf-8?B?UlBRNThFMWZ0OXo1SlZEUlBvN1hBTyt1U1VjcFp0OXEzUUJITHREaUFIbzcr?=
 =?utf-8?B?Y1g0MEl6Nk1OZ1Q2b294R2JCK09RWmFSb2NidUY3b2Iwb1Zta1dMMDI4MDVY?=
 =?utf-8?B?Qys3NjlUNXoydGNIRnVNc1VHSjlac3cySDlmNDNuWjdPS2Jia0dHb0w0RytI?=
 =?utf-8?B?cnZkUzE3Ujg5ek5GMDZ5Z3BsVXNNSWpxSi9VZFhlL3B3NytFSEJtckRaSVdF?=
 =?utf-8?B?aWdiTTR5OXRmZHUvZ2RrQUFtUDVWaG1iUnRCVmNsVFREenEzZnhvdWJ5R01q?=
 =?utf-8?B?NVlaNFYrSTNaMTZyM3VZWUo2L1BTajdTOHRaQlB6K2RlSGE4RU1FS0RXWU5S?=
 =?utf-8?B?SVhVTk95ZjBMblFvdkROaGR1KzZQWVFmUlh5TEhaY3ZnSlZGdWwreS9RMXFy?=
 =?utf-8?B?NjFYUXlzOVZMejVFUExUVGIwcnhzZ3h4VFRjcUNocWpuemh0S1BGd1BTTmpR?=
 =?utf-8?B?VE1MS0dDcFdQS0NyN3U4R1g1b1NocWJLT1R1ZFdaZWtLYVhrZzVHUzVScndw?=
 =?utf-8?B?bmpScWhBWWEvQ0N5b0hWbGJRM0o1M3Y2aVJIcVdBWER0Q21WQ0ZZTWJPcnNy?=
 =?utf-8?B?Mk5mWGdaZXB6bmU1K0NoMW9KajRjbmpSazZRcTd2MXJaUGFMcjdpNFVYR0NN?=
 =?utf-8?B?eGxyd3kwcDBhUW9nejkrMExZSkx3ejdIS1BodUxkaHdxT0liS3RPT0tYSnE3?=
 =?utf-8?B?NzVIcXg1V3lFVWlpeitCRk93ZWxWdVJNRnJDRFJoM3o5eHVLMWNoRmRiMFNT?=
 =?utf-8?B?TUo3RnZMMkpqdndoQ1ZkUkkxQjR4R0ovclFYRTVHb0x5YXhDWnRVbDJBLzVW?=
 =?utf-8?B?eEovc0NheVphV1pjNXdLcHBBOHdnbElJekZiYlJ1Ulhoam02Wk5iNWZsTFJQ?=
 =?utf-8?B?ZWxHMEZRNG9NYWdMMlhiV1hqZGRPTXcrTDY3bWtDQVhINWloWUNvUU82dzRU?=
 =?utf-8?B?Ry8weU4xUHpnZnN3NUgxNHVmNDFVQm9VVUlnbGF1MHM2eTRFTUFWWkVYNFZy?=
 =?utf-8?B?cXE2ck1nRExxb0I5blF3TmpzY2RuNFlIZk5YOEVCMFV0eVA5NUVNZmkvUXlE?=
 =?utf-8?B?ci90SFQ2cUNtUVpCZU9TOUZ4WVI4aE5hV2I2SEl3Zk5USXc2R0czYkpMS3pw?=
 =?utf-8?B?dHJTb1RqcGNsaU9Id1BMQ0tqZ3NpUHMzamxPeDNySXh3UDZCc28zRE5wTjBl?=
 =?utf-8?Q?EIz4HAYNXQN3RnOVkbFNqvA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4f4acf-3710-4796-50f5-08d9f201ec13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 10:40:32.0463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDSP2lc3gikgJ+pxiezbuhRT/vA3PsJeXJhxEQmfqiywuHPPAigQHusP/dvMR6XD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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

Am 17.02.22 um 11:38 schrieb Jiawei Gu:
> Add device pointer so scheduler's printing can use
> DRM_DEV_ERROR() instead, which makes life easier under multiple GPU
> scenario.
>
> v2: amend all calls of drm_sched_init()

That looks better, but please send it to the dri-devel mailing list as well.

Thanks,
Christian.

>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  2 +-
>   drivers/gpu/drm/etnaviv/etnaviv_sched.c   |  2 +-
>   drivers/gpu/drm/lima/lima_sched.c         |  2 +-
>   drivers/gpu/drm/panfrost/panfrost_job.c   |  2 +-
>   drivers/gpu/drm/scheduler/sched_main.c    |  9 +++++----
>   drivers/gpu/drm/v3d/v3d_sched.c           | 10 +++++-----
>   include/drm/gpu_scheduler.h               |  3 ++-
>   7 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 4787cb3acaed..98217b1487fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -508,7 +508,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>   
>   	r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>   			   num_hw_submission, amdgpu_job_hang_limit,
> -			   timeout, sched_score, ring->name);
> +			   timeout, sched_score, ring->name, adev->dev);
>   	if (r) {
>   		DRM_ERROR("Failed to create scheduler on ring %s.\n",
>   			  ring->name);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> index 19826e504efc..4240f2ae0ab3 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> @@ -190,7 +190,7 @@ int etnaviv_sched_init(struct etnaviv_gpu *gpu)
>   
>   	ret = drm_sched_init(&gpu->sched, &etnaviv_sched_ops,
>   			     etnaviv_hw_jobs_limit, etnaviv_job_hang_limit,
> -			     msecs_to_jiffies(500), NULL, dev_name(gpu->dev));
> +			     msecs_to_jiffies(500), NULL, dev_name(gpu->dev), NULL);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> index ecf3267334ff..4b3a43a2b3e3 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -509,7 +509,7 @@ int lima_sched_pipe_init(struct lima_sched_pipe *pipe, const char *name)
>   
>   	return drm_sched_init(&pipe->base, &lima_sched_ops, 1,
>   			      lima_job_hang_limit, msecs_to_jiffies(timeout),
> -			      NULL, name);
> +			      NULL, name, NULL);
>   }
>   
>   void lima_sched_pipe_fini(struct lima_sched_pipe *pipe)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 2df3e999a38d..215709d61315 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -627,7 +627,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>   		ret = drm_sched_init(&js->queue[j].sched,
>   				     &panfrost_sched_ops,
>   				     1, 0, msecs_to_jiffies(JOB_TIMEOUT_MS),
> -				     NULL, "pan_js");
> +				     NULL, "pan_js", NULL);
>   		if (ret) {
>   			dev_err(pfdev->dev, "Failed to create scheduler: %d.", ret);
>   			goto err_sched;
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
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 8992480c88fa..6d68b155c3cc 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -403,7 +403,7 @@ v3d_sched_init(struct v3d_dev *v3d)
>   			     &v3d_bin_sched_ops,
>   			     hw_jobs_limit, job_hang_limit,
>   			     msecs_to_jiffies(hang_limit_ms),
> -			     NULL, "v3d_bin");
> +			     NULL, "v3d_bin", NULL);
>   	if (ret) {
>   		dev_err(v3d->drm.dev, "Failed to create bin scheduler: %d.", ret);
>   		return ret;
> @@ -413,7 +413,7 @@ v3d_sched_init(struct v3d_dev *v3d)
>   			     &v3d_render_sched_ops,
>   			     hw_jobs_limit, job_hang_limit,
>   			     msecs_to_jiffies(hang_limit_ms),
> -			     NULL, "v3d_render");
> +			     NULL, "v3d_render", NULL);
>   	if (ret) {
>   		dev_err(v3d->drm.dev, "Failed to create render scheduler: %d.",
>   			ret);
> @@ -425,7 +425,7 @@ v3d_sched_init(struct v3d_dev *v3d)
>   			     &v3d_tfu_sched_ops,
>   			     hw_jobs_limit, job_hang_limit,
>   			     msecs_to_jiffies(hang_limit_ms),
> -			     NULL, "v3d_tfu");
> +			     NULL, "v3d_tfu", NULL);
>   	if (ret) {
>   		dev_err(v3d->drm.dev, "Failed to create TFU scheduler: %d.",
>   			ret);
> @@ -438,7 +438,7 @@ v3d_sched_init(struct v3d_dev *v3d)
>   				     &v3d_csd_sched_ops,
>   				     hw_jobs_limit, job_hang_limit,
>   				     msecs_to_jiffies(hang_limit_ms),
> -				     NULL, "v3d_csd");
> +				     NULL, "v3d_csd", NULL);
>   		if (ret) {
>   			dev_err(v3d->drm.dev, "Failed to create CSD scheduler: %d.",
>   				ret);
> @@ -450,7 +450,7 @@ v3d_sched_init(struct v3d_dev *v3d)
>   				     &v3d_cache_clean_sched_ops,
>   				     hw_jobs_limit, job_hang_limit,
>   				     msecs_to_jiffies(hang_limit_ms),
> -				     NULL, "v3d_cache_clean");
> +				     NULL, "v3d_cache_clean", NULL);
>   		if (ret) {
>   			dev_err(v3d->drm.dev, "Failed to create CACHE_CLEAN scheduler: %d.",
>   				ret);
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

