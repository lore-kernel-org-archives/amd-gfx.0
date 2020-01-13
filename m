Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C1BC33CAE
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 12:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98247207FF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 12:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jmbs0I8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98247207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF816E088;
	Mon, 13 Jan 2020 12:04:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B3C6E088
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 12:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkE4pspL7o5AEldY+n/akqBvfeh0tz7XwkKWeCSBnxzAOKuPaWBcpPlWv+PgU9BX/5UIOEeI6KCCrY1ogl8zs/M3f+zF132wF/eOyDAKZtrrFJgcFd7u2ZSi4pyz4maD7EDjRtZpdyeDzxVwhwpQuDE98xmXwYmE8eJ7Y2NZTRF4F7cXtewAE1F2QYKZgQ6X/xTyD0lTeXaQkji0GEjOXWqoj7K8q8ZfH9xLdEXCkoWbFgkwjPMHmX90zy8qsj0Rmt047YpMOIyHge6aQFhTfkQKDkVGsuJkdmOlN9Ne3vxklAk82rstAVSw4iwZ4ZGkgcDd+0K0ZdTWbeAxw8ssdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY/NthMUG5f1GhFyuBlQ37RUglsj/3Qi/GE5Wy0qc/c=;
 b=iB8OpXSanwaMxQgXNPNFdqfsMzDZ881vCx63ouqH8Yk9o4XlOiIKCz+N30Dh6lPjKM2AZJ27frU3YyT2rXPXOZawVt4V3vn2hY0ufGRhGazAtf6+D/+mrdIbrdp0alPS/rdfkKiQ9xiodMiUi8Q69RVTxuLb16dJijhlIcVrVwoHXtIVXYn5BDl4WXvLB5VcaQTefZIyldnFzuEbR/zjBqonw1FAhzgMcNfj5hmNQ3HDy3NTMDR+hzixeieljof97s/LlbscZtc4eE9m3w4ABMaZoF5PgkxEDg+waNzdfQ+eXN3DcKlc/ltMl747+3RNlVZQJE+czeyg1mARLSQHDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY/NthMUG5f1GhFyuBlQ37RUglsj/3Qi/GE5Wy0qc/c=;
 b=Jmbs0I8JOSOoyDmLUO+UVNv3RFI61++0nrZzR5WCVnSypBjADC/gcHE9HWbuthD0Gwev4tFOul04lxa6EuvAfrQCL6Ynd5c2xn9dewQtGdHJl5yBA+i8FnP4pIlDUFYX/iX2gbdBgnenhuljnD26+4wlo550CY9Sex+wkyLmm9s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1929.namprd12.prod.outlook.com (10.175.85.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 12:04:08 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 12:04:08 +0000
Subject: Re: [RFC PATCH] drm/scheduler: use idle time to do better loadbalance
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200112012507.7468-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3a97b721-a44c-1a3e-6f74-2eef885e8b2b@amd.com>
Date: Mon, 13 Jan 2020 13:04:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200112012507.7468-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0099.eurprd07.prod.outlook.com
 (2603:10a6:207:6::33) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0099.eurprd07.prod.outlook.com (2603:10a6:207:6::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.8 via Frontend Transport; Mon, 13 Jan 2020 12:04:07 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a69f701-b42a-4ed3-cea4-08d79820b199
X-MS-TrafficTypeDiagnostic: DM5PR12MB1929:|DM5PR12MB1929:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1929438F969627A46986280E83350@DM5PR12MB1929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(478600001)(5660300002)(81156014)(81166006)(31686004)(8936002)(8676002)(36756003)(31696002)(86362001)(4326008)(6486002)(66946007)(66556008)(66476007)(2906002)(6666004)(316002)(52116002)(186003)(2616005)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1929;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUh/Sy8FvJ5blX7Mx8FaLcxPuexZML37th6CCCFL6nTVC6Yp1FjY9pkWFRBoe4tDTjzcOOoXKa3pg6/IOuDEq/J3xuaqqL2S5yobNTcV3Wjkm4fonq7UX0d4fK/ZKXL++3ofqTrDGkzsS+tT1hU4cQeuvEGYbsi+jjUg9Ay9/I1Ldf8ZMQJFIFV/RcgjeEiRqCbsjGjNUPhsKz6RhpY6eyuyDK83WxNOBEAxJyYGW+rAwb6ACZrTYgMOL1uAvBT6bj35/R/jNYl5+8NbYw88bHOY841olLFCyeoGVF9H8y01cQW6YjyujR7Jyp72yvctNcVcvyuOUtNVyK0/8Co3iEp0AwUqjrhQoa9C42kGmk3QWlQfPgM/heAKd8m8NFXSWKnKyh+oIcyZbDz/fBBRAHv8H7izAQShvbKrGA6Z1rKRGY+HyW/bro+Vl7+kq/40
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a69f701-b42a-4ed3-cea4-08d79820b199
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 12:04:08.3836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbHKK93rBxg27FD9c2sb46i5HFsOAOnFIO7WhS0tncEfrSslrj56uAOhJz14TURZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1929
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 pierre-eric.pelloux-prayer@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.01.20 um 02:25 schrieb Nirmoy Das:
> This patch adds required fields to drm_sched_job and drm_gpu_scheduler
> structure to cumulatively calculate amount of time a drm_gpu_scheduler
> spend on serving a job.
>
> Using least used drm scheduler to choose a run queue
> improves drm_sched_entity_get_free_sched()'s job distribution
>
> Below are test results after running amdgpu_test from mesa drm
>
> Before this patch:
>
> sched_name     num of many times it got scheduled
> =========      ==================================
> sdma0	       314
> sdma1          32
> comp_1.0.0     56
>
> After this patch:
>
> sched_name     num of many times it got scheduled
> =========      ==================================
> sdma0	       113
> sdma1          383
> comp_1.0.0     9
> comp_1.0.1     9
> comp_1.1.0     8
> comp_1.1.1     8
> comp_1.2.0    12
> comp_1.2.1    13
> comp_1.3.0    16
> comp_1.3.1    9
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Well that is a nice start, but a couple of comments below.

> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 9 +++++----
>   drivers/gpu/drm/scheduler/sched_main.c   | 2 ++
>   include/drm/gpu_scheduler.h              | 2 ++
>   3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 2e3a058fc239..b5555af787d0 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -130,7 +130,7 @@ static struct drm_sched_rq *
>   drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
>   {
>   	struct drm_sched_rq *rq = NULL;
> -	unsigned int min_jobs = UINT_MAX, num_jobs;
> +	uint64_t min_time_consumed = -1, total_consumed_time;
>   	int i;
>   
>   	for (i = 0; i < entity->num_sched_list; ++i) {
> @@ -141,9 +141,9 @@ drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
>   			continue;
>   		}
>   
> -		num_jobs = atomic_read(&sched->num_jobs);
> -		if (num_jobs < min_jobs) {
> -			min_jobs = num_jobs;
> +		total_consumed_time = sched->total_consumed_time;
> +		if (total_consumed_time < min_time_consumed) {
> +			min_time_consumed = total_consumed_time;
>   			rq = &entity->sched_list[i]->sched_rq[entity->priority];

You might want to remove num_jobs now completely since it unused, but 
consider the whole algorithm first. See below for that.

>   		}
>   	}
> @@ -499,6 +499,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job,
>   
>   	trace_drm_sched_job(sched_job, entity);
>   	atomic_inc(&entity->rq->sched->num_jobs);
> +	sched_job->start_time = ktime_get_ns();
>   	WRITE_ONCE(entity->last_user, current->group_leader);
>   	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
>   
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 3fad5876a13f..67fdf4f248d4 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -653,6 +653,7 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
>   	struct drm_sched_job *s_job = container_of(cb, struct drm_sched_job, cb);
>   	struct drm_sched_fence *s_fence = s_job->s_fence;
>   	struct drm_gpu_scheduler *sched = s_fence->sched;
> +	uint64_t end = ktime_get_ns();
>   
>   	atomic_dec(&sched->hw_rq_count);
>   	atomic_dec(&sched->num_jobs);
> @@ -660,6 +661,7 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
>   	trace_drm_sched_process_job(s_fence);
>   
>   	drm_sched_fence_finished(s_fence);
> +	s_job->sched->total_consumed_time += end - s_job->start_time;

Don't use s_job->sched here, use the local variable sched (s_job might 
already be destroyed).

The next problem is that you somehow need to protect total_consumed_time 
from concurrent updates, a 64bit atomic should probably do it.

Another problem from the algorithm point of view is that the 
total_time_consumed of each scheduler doesn't necessary say anything 
about a good scheduling decision for the future.

For example there could have been a lot of work from a single queue to 
SDMA0 in the past, but now both SDMA0 and SDMA1 are idle.

Scheduling everything to SDMA1 until we catch up with SDMA0 is certainly 
not a good idea. Since this counters the whole idea of load balancing.

Regards,
Christian.

>   	wake_up_interruptible(&sched->wake_up_worker);
>   }
>   
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 96a1a1b7526e..496d9b209d12 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -191,6 +191,7 @@ struct drm_sched_job {
>   	struct dma_fence_cb		finish_cb;
>   	struct list_head		node;
>   	uint64_t			id;
> +	uint64_t			start_time;
>   	atomic_t			karma;
>   	enum drm_sched_priority		s_priority;
>   	struct drm_sched_entity  *entity;
> @@ -285,6 +286,7 @@ struct drm_gpu_scheduler {
>   	atomic_t                        num_jobs;
>   	bool			ready;
>   	bool				free_guilty;
> +	uint64_t			total_consumed_time;
>   };
>   
>   int drm_sched_init(struct drm_gpu_scheduler *sched,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
