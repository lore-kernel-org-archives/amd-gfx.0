Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82192C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 05:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E101A10E09B;
	Fri, 21 Apr 2023 05:23:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF76310E09B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 05:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSpgdFcLSg9eZBkD+kCw3f5Zt0EV0tAiPi8DeM5qqIwHdnJU91245l21HP7nr9bXnhSwzuSs664icxHGFcMme1RDHAVv0/dGOR8+Ei79G3QS4xfwsCng7CtKw7daSjsU6bBRzDfnMEsZ8/0HrVtzB8gSW2a6tlUJYzimseztNBZmApNyKJ0/WFrxmJQ1ajtrogWJOlY8nLkJY06vOaX6hVyJ1UksNmB5UBZHvxfYP4V3htfbLD6vo9Co52KOZzJv/wajOxkH6dxYInbc/XxV+ufbLPp1j/RdEMTufLTHYeFZ04DO7oYVrKVqAVGYSLo92Vm6Tc+fNhgcGS1yvjP+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKTaJf7E/Lve/w3qFuoWc7UCaemAcn9/b4jk7SVc9Jg=;
 b=UsIDolwQGAajihvX0kF27Xr6ENgxlxrj1iGCcwmzgnvEHDn6qCH9ZdBsxLihhj+OZhqbgBPltLG3tefSuNFT4Tre1gLaRAOt7mCU8fxo7EuHt6kYZlNCROjaLGgQ6zsk+sIPp5LQw8EJg1S6D84z9J8ZLJ5/6uP1eS3X0Vqr08nEfmmSj1HmXFVGQfyF5WIYDnotEZ+soriHojb+629VaU6c4dTkmVHgaCXMtm9V6BOIj18dJ66GxMi53XwYByOmCBYKebrb8GYJW350fqMZcFfIAt5H9ipGjgC7/P+2+h7tqtfCNCKnn8gMHA9xflU+ILCoxFJWmpL3w8362QODiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKTaJf7E/Lve/w3qFuoWc7UCaemAcn9/b4jk7SVc9Jg=;
 b=om4oabMn3OnYpXD9WJV5M6uXIBwcF87UHgVAgPjmS8FfTlc+t+P5AP9Tv9BtwsHBI/0Yi9R9AoVxougg1SNB0BoeYUu4oH0zquOCcp4KvKeWuXxDcbs6Ox7/4jAYdbLBpd2ri7icu8pFE+45oOeDLq3pH0ArqOvcYyuYWHf0q+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Fri, 21 Apr 2023 05:22:56 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 05:22:55 +0000
Message-ID: <3d5dc70c-982a-8d86-cab2-f205c90c869d@amd.com>
Date: Fri, 21 Apr 2023 01:22:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230420115752.31470-1-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 1/8] drm/scheduler: properly forward fence errors
In-Reply-To: <20230420115752.31470-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::9) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 8526c638-ac16-4edd-9a55-08db42287631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKnEWe0lZoTGGfDBp1kbGoiw9FwsRxDatts/5eVrWmkRkz2cjDM1PxUCKDTrF/M/O0iFd2Lsz9SYxEJhlNJpph8PmSmL0BAfLSiZYJyVYDCif2MfKzNtxVSF3fbcGwsDIAmnDIIi6KgY5qO/ow4gXPEpV9oiP2hQOSFGUXhA/ay0tupEJERkqPstJHS6XSBuiDbLQ7sevbBBmiiRTDZ/II0E/G9/4lv5XH1Hs8A8J8rRFYg9xikv2IRnEd6aaEG1AwT7zC0aeN5/TvM2WwYcSveiXcGq9W4rdiByFnTzeyKkirxJqQ7gHQkkeplk8sH7CeroHreRjkZWPIKuDefzB2RJwhP4xxgRXICeHSQ/JcqS5WmlkmhsjFS9qH9bMamOzoWd2gYLezlrST4xHmVNYkD1dgzQwqUBPu5xuBXJFITNYVSTrMYav/FTnwPuEiw994aIjVMFcMAtR78n67UwSiXJA6NgNjRLWcrdRnFw/3+X7r1xCu57xpJ6cm469IVw55nGmaMtU4FvMNwmKOnAotphyffiY57zPz1WNn2pXd69R23qeQDL6GjhPgGebQ7vspVfXPFJovCqElyTUkEEdd+cxYql6qmYRMgTUa2xzwN4Td4iLPHt0FyFJQvhd2E6/jotMgwJKhIa9blJuQ98YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199021)(38100700002)(41300700001)(5660300002)(44832011)(8676002)(2906002)(8936002)(36756003)(31696002)(86362001)(6486002)(26005)(6512007)(6506007)(478600001)(2616005)(31686004)(83380400001)(66574015)(53546011)(186003)(66476007)(66556008)(66946007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3luYWVIZEZIOXd6WFNWNm9BRWJmaVdRRnk0dWNpVHM1blVTakp6SWhtbFFL?=
 =?utf-8?B?MmJOWGxBVlB6SG1xTDU1ZDNTblBPaktLWW1OVXNMOUZFZFRiUW5ZcFgvMEho?=
 =?utf-8?B?dFZUd3Y1a1hPeW04ZEhRSFdzYmY4dlp5TlNXYkNxVjJGM0tMb2E5R24vZjJr?=
 =?utf-8?B?V0dxTmVlT2NtL05KejVibk1QeHNDamlwSllxQVhBS1o5TlM2cXJZcVBsYUx1?=
 =?utf-8?B?c25JK0IrOFl4RC8vSVlNdWtwRnJDeVVOWTZJZGtUUkF1WUYraWJQSXVvTFFi?=
 =?utf-8?B?Zjh6eHVicHZOZDJjRWFySVFZbHU3WDhzTGk5ZTNNTEFkNXVGWGJVMWxFSUdE?=
 =?utf-8?B?N3ZxK0RRWmc0SHdBUnA2WXVkVnZ0eDFZOTN6bVdqanZSUHFXSHZxc3NwMExU?=
 =?utf-8?B?NXRlRGREYndkNXMrMFBtS25vVmRGWU5vdFFRVHl2K1FzYTZzY3F4Ry9PY2NC?=
 =?utf-8?B?enFzYkZJVC8wNXhocU40Zzhod2UzLzBBVEgyN28xb0laNCt2SEFtZ1NucHJx?=
 =?utf-8?B?aklueHY1S0RDcUkrVWo2a0VQcWdnMUFDZ3ZNMDRXdW83NU5YYzA4MVlRM08v?=
 =?utf-8?B?T1JRSSs4cFBCMXZDU3QxLzFSY2RTelgxMnB4L2hDQ1BlbFJBMzJHemx6RVo2?=
 =?utf-8?B?ZHk0eWdBUUpIaWxGZ2NMSTQ3ZzIzbEhsUTA4Q0V3dWlDNXdDamNCUzE4N3VT?=
 =?utf-8?B?bEdtVURLT3hVMEZpbU41aGdFdE9VY2lkMlE1VXFFK1lzWlk5NXJQRnYyVGd5?=
 =?utf-8?B?Y0ZndHNDb2ZkMkpBc3dHbFpjdHM3VUNaYWE3bUF5Q2RDNmI0aWFoQUg2dnhM?=
 =?utf-8?B?Qk4wbDA1aFJ3dG9OTTZXTmZjSVFEWGVvNWNIYXV6dTNyQW9NQmhMUkNrMmZ2?=
 =?utf-8?B?U2VudThaOXFNakVtaXRVbGxUOXpxdHV6dXFjN1lFOHFiWjJkYTV2ZFViODVG?=
 =?utf-8?B?Y25qYXNGWmdJbUYrb2d4bW5qc3kwTE9yV2RmYVl6aDlTTW9yTUVMQ2loTW12?=
 =?utf-8?B?blNwVTNEQkZmVmRFVlJjeDY0OE5leWJZbktCSDgzU1cwNHJFcU13a3lIUjhD?=
 =?utf-8?B?T3AxcHpBVWVsbWlSUTR2VlpQbjB2UDNUWHI2aGZSYlZtSXRNajBFdlM4em9m?=
 =?utf-8?B?ZVVEUUVBTDBYL2RyMmRTY0JGTjFoenV1QVJKc0JoOTZvUGZ3R29WdVdoOXVw?=
 =?utf-8?B?a3JMTG8rakRRK1c1cytUbDZkUnR0Z2w1WWtHN0ZIWHFpaGg2dnNIeXNvbWF4?=
 =?utf-8?B?Y0w5VnhFR1V6Y0JoTHZuNW4wYW5SczhVa1FQUTJRUXZSemsrenVXdGhiQVZD?=
 =?utf-8?B?b21DVkU5SHY5dnM4aTVQRVozb3dtTDVDb1ZrZmI0QTM5WElJcTVwRjladVd6?=
 =?utf-8?B?eU9zOHZwdllZZlcyd3poNi9Vam4vT0JvOVFwQmdCQktubEEzVDdZNmIvMnVW?=
 =?utf-8?B?YWVPeVBHZWhpRGVQTkxqK2VuOGpHREh2ZmRSeS9MMFpWY0JVdmY1UGR3aitj?=
 =?utf-8?B?U0xhZ0tNa2pLTjRrRkN6eVdjYk1CeTMwTk9xM05xc21INlRVMFJrUmxlZWNH?=
 =?utf-8?B?Q0REbkVRM0ExU3YwUVcyNEp3L1lPeTQ3MU1XQlFBcC94ZVB2akt4aEp5WnB6?=
 =?utf-8?B?dWZqR2lhNFhLQlRTdGhWUjVQaDhJd0ExMWozcEErN2srLzlBTU9wb3ZEa2xz?=
 =?utf-8?B?aytsemFhZ2FydHlqY21ZT2NPazcwT0tsbE5VTWs1ZFZaL05PaFV6TjhkaWxw?=
 =?utf-8?B?WWRBU2c3MVdjenhmQkVoUk1qUlhhWE5aaTAwd1BacUplaXdOUXE0c0xESXl4?=
 =?utf-8?B?MG1LQWVsdUpyWVhYRDhCK2NFSGNMRVBzdGNlaGlHdHpwY2hxTGo0b2VNcWhM?=
 =?utf-8?B?dVB0bTBnYlpMWERZazNQL0hkTHB5WHNRVDZVVGRwb0hOL1BKTkg5bG9qTi9h?=
 =?utf-8?B?NXk1d1NiOGZxbWtPdE04bi80ZENiVyswYlZsRlVHamtMYzVidUVLUmFTTWFN?=
 =?utf-8?B?akwxUTFBbnZvRVgwMXNjMTVlZEpnanhyMy95YlpPdjhnNzBHYVNsSms2aFkw?=
 =?utf-8?B?ZzdFN2FLczBQOGNNeEtMS0hWSU1SMDBpUDJWb2lMdS95b0pXWmtWNHI3MU5P?=
 =?utf-8?Q?p6Xlusnzx0bP2ALCCD1IPfW9M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8526c638-ac16-4edd-9a55-08db42287631
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 05:22:55.6475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRmsj1VC5yQCEGtPnL+U1pIGOaBzLGO6gfaIyJ9YUzRJoA8mJAOZx4Mb/SpgHKfw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
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

Hi Christian,

Thanks for working on this.

Series is,
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-04-20 07:57, Christian König wrote:
> When a hw fence is signaled with an error properly forward that to the
> finished fence.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c |  4 +---
>  drivers/gpu/drm/scheduler/sched_fence.c  |  4 +++-
>  drivers/gpu/drm/scheduler/sched_main.c   | 18 ++++++++----------
>  include/drm/gpu_scheduler.h              |  2 +-
>  4 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 15d04a0ec623..eaf71fe15ed3 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -144,7 +144,7 @@ static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)
>  {
>  	struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
>  
> -	drm_sched_fence_finished(job->s_fence);
> +	drm_sched_fence_finished(job->s_fence, -ESRCH);
>  	WARN_ON(job->s_fence->parent);
>  	job->sched->ops->free_job(job);
>  }
> @@ -195,8 +195,6 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
>  	while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
>  		struct drm_sched_fence *s_fence = job->s_fence;
>  
> -		dma_fence_set_error(&s_fence->finished, -ESRCH);
> -
>  		dma_fence_get(&s_fence->finished);
>  		if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
>  					   drm_sched_entity_kill_jobs_cb))
> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
> index 7fd869520ef2..1a6bea98c5cc 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -53,8 +53,10 @@ void drm_sched_fence_scheduled(struct drm_sched_fence *fence)
>  	dma_fence_signal(&fence->scheduled);
>  }
>  
> -void drm_sched_fence_finished(struct drm_sched_fence *fence)
> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int result)
>  {
> +	if (result)
> +		dma_fence_set_error(&fence->finished, result);
>  	dma_fence_signal(&fence->finished);
>  }
>  
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index fcd4bfef7415..649fac2e1ccb 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -257,7 +257,7 @@ drm_sched_rq_select_entity_fifo(struct drm_sched_rq *rq)
>   *
>   * Finish the job's fence and wake up the worker thread.
>   */
> -static void drm_sched_job_done(struct drm_sched_job *s_job)
> +static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
>  {
>  	struct drm_sched_fence *s_fence = s_job->s_fence;
>  	struct drm_gpu_scheduler *sched = s_fence->sched;
> @@ -268,7 +268,7 @@ static void drm_sched_job_done(struct drm_sched_job *s_job)
>  	trace_drm_sched_process_job(s_fence);
>  
>  	dma_fence_get(&s_fence->finished);
> -	drm_sched_fence_finished(s_fence);
> +	drm_sched_fence_finished(s_fence, result);
>  	dma_fence_put(&s_fence->finished);
>  	wake_up_interruptible(&sched->wake_up_worker);
>  }
> @@ -282,7 +282,7 @@ static void drm_sched_job_done_cb(struct dma_fence *f, struct dma_fence_cb *cb)
>  {
>  	struct drm_sched_job *s_job = container_of(cb, struct drm_sched_job, cb);
>  
> -	drm_sched_job_done(s_job);
> +	drm_sched_job_done(s_job, f->error);
>  }
>  
>  /**
> @@ -533,12 +533,12 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery)
>  			r = dma_fence_add_callback(fence, &s_job->cb,
>  						   drm_sched_job_done_cb);
>  			if (r == -ENOENT)
> -				drm_sched_job_done(s_job);
> +				drm_sched_job_done(s_job, fence->error);
>  			else if (r)
>  				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>  					  r);
>  		} else
> -			drm_sched_job_done(s_job);
> +			drm_sched_job_done(s_job, 0);
>  	}
>  
>  	if (full_recovery) {
> @@ -1010,15 +1010,13 @@ static int drm_sched_main(void *param)
>  			r = dma_fence_add_callback(fence, &sched_job->cb,
>  						   drm_sched_job_done_cb);
>  			if (r == -ENOENT)
> -				drm_sched_job_done(sched_job);
> +				drm_sched_job_done(sched_job, fence->error);
>  			else if (r)
>  				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>  					  r);
>  		} else {
> -			if (IS_ERR(fence))
> -				dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
> -
> -			drm_sched_job_done(sched_job);
> +			drm_sched_job_done(sched_job, IS_ERR(fence) ?
> +					   PTR_ERR(fence) : 0);
>  		}
>  
>  		wake_up(&sched->job_scheduled);
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index ca857ec9e7eb..5c1df6b12ced 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -569,7 +569,7 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
>  void drm_sched_fence_free(struct drm_sched_fence *fence);
>  
>  void drm_sched_fence_scheduled(struct drm_sched_fence *fence);
> -void drm_sched_fence_finished(struct drm_sched_fence *fence);
> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int result);
>  
>  unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sched);
>  void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,

