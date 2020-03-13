Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DB6C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070162072C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h13FyWkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070162072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA14E6E9CD;
	Fri, 13 Mar 2020 14:02:27 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680049.outbound.protection.outlook.com [40.107.68.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F3A6E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk5P3euDMuwpEhv7FNpivwuPesmANeCp3Z3RLRKJtJBwKw62EHr3MMJiCYoxcdMEYsRNCXjksQ5fBZhIN4FGnngFKT1OBH+73G0L33zknMlG+UHZB65jCVbmdgUU7YtYrsz9lyKXeAh1WBrd/q7NIvFRNnaBgNev37UbgYzfryFQ3Q96mEliAtZ24UgOlDutnSPQAOKeWeacNPBSyGAn7E1bNDF5ziS40pertYSsNlSyqGJL0hoijBdiv7yxjrg2GW97oWLYYix4jFgDfXfqzkRd3IVo5ovog2ftIsQ19/qopMf+Pkscql+yzFs2JFkurwSgwFFh/y+dJFmhoJiEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhV4b3UHq7d77dWL77R0jmX9iIkM9JAxDbKwT4Ghgjc=;
 b=BfdSQmWJ7cReIlB4VaAL4TV/6BGxKotPSudzkWzpe8Q2akvtsH6JKj1NUfMT4NqTz8xFGTmA428SiPJnArWQC39E9cda/qQhvSPyeUi5C1b7WnCJeIGZQeilCbW9x/hIkJQHJU/v8GlzBY7OTkYI/wBAt1NFTVSeG3zZCg+mbv89NHgGJVhTRswmWSxpTu/MwFdShpgyOkY59kQRobYme1wS+qNMT5FelhNiqSRk4njxN/zBBipW2yQcN/FdTny+UnJEXh09yrp6pPt661YRToOiNp+9fqR0lWA/z5n2aIu0LcSgBKpkYiR4bicD8oLt2ChIpTdrcUrkcYKWRUG1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhV4b3UHq7d77dWL77R0jmX9iIkM9JAxDbKwT4Ghgjc=;
 b=h13FyWkXhci8Q9W8LDcs0Reo1YvlH7XUlZIX2PtEczPEqDFXdrYrCmncsIH2X0859tk1O/hufTaog1qxdK93vs5Ujlc/SewonsVEy0nx5Ij1bUBiwojv2kig+lUWuK0m0EtJ3rliUrH/YIDGz12FMKlyZ5p2nMKPV1x6oh/EAto=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1724.namprd12.prod.outlook.com (2603:10b6:3:10f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Fri, 13 Mar 2020 14:02:24 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 14:02:24 +0000
Subject: Re: [PATCH v2 1/2] drm/sched: implement and export drm_sched_pick_best
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200313135953.68418-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2674c3a0-7651-0f64-552f-ce3918fdac59@amd.com>
Date: Fri, 13 Mar 2020 15:02:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200313135953.68418-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::27) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.20 via Frontend Transport; Fri, 13 Mar 2020 14:02:23 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e67477e-6169-477d-b749-08d7c75727f8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1724:|DM5PR12MB1724:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB172438657A451515F1DB4DBA83FA0@DM5PR12MB1724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:261;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(316002)(52116002)(36756003)(2616005)(478600001)(66946007)(66476007)(66556008)(6666004)(5660300002)(6486002)(4326008)(31686004)(31696002)(86362001)(81166006)(8936002)(186003)(16526019)(2906002)(81156014)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1724;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axzPCoxerXImIRfpLxAlPm2QqY463MrkKY4znI9t/1AEPdRNKNXTZ9JqbT+psXxdKcVpOP+Pe341Mqf027Pfmtr48vJqD/3Y3lgaj5fhSFekLL134dbZOJ3tFJV/DD3Pu7E3/42lyBAXmMQcCuU/e+/FVu+aleiKkgQJlbNrqVhr+B+nHumZ9X14tXSktsRKnwyHNu7IXFb0FoUUIsbNbL5gJ7CNdzzIMO+I2bXicCEZOrYq/IFhozqIGdQdCb5OQgdmxunc2VRPlWA/d6ywbWtGYoQBd+9dfuSCBxqMgd6hfHMpJZP20SiLF35gYylwDd5eV9W9WipEGb+bMFB1vZI7Ye6LEkIBfZYxXqVY1g5g47MP64ppzp4dQaruGRvkrcdLo7BDuEO+75rx9UDiK9G31YC8gwf4D42N/NcBF2wBbkOg1vEXsVQhtMd4l5IW
X-MS-Exchange-AntiSpam-MessageData: EB51Ja/M61cXv2dGm2QdlrBoVWv1R7rcHSbOnPjit5rNniad5GOU4YgZntVOByUvFnxPAe6kJtZQePYATVbqafNIyjmW9DdKeb9DaTwjM+nH/noJkvUVuylUQudV4eTGElV82TvLPNQdPnzJdavpdfMHx0VCvLnz1+cmJCvV/iaXc/eIB4kJR6Jg5cuy4LevXJCMZ1ORj+zpjfS398ZQRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e67477e-6169-477d-b749-08d7c75727f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 14:02:24.5666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1rX/y9z9BszIdA6I2CaVyReF7CKx6eZEVaVA9jrthnLpEz35pfo5wHAPA7tU0rB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
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
Cc: alexander.deucher@amd.com, Boyuan.Zhang@amd.com, nirmoy.das@amd.com,
 Leo.Liu@amd.com, James.Zhu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.03.20 um 14:59 schrieb Nirmoy Das:
> Remove drm_sched_entity_get_free_sched() and use the logic of picking
> the least loaded drm scheduler from a drm scheduler list to implement
> drm_sched_pick_best(). This patch also exports drm_sched_pick_best() so
> that it can be utilized by other drm drivers.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 40 ++++--------------------
>   drivers/gpu/drm/scheduler/sched_main.c   | 35 +++++++++++++++++++++
>   include/drm/gpu_scheduler.h              |  3 ++
>   3 files changed, 44 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index d631521a9679..ffc8adb6ff25 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -137,38 +137,6 @@ bool drm_sched_entity_is_ready(struct drm_sched_entity *entity)
>   	return true;
>   }
>
> -/**
> - * drm_sched_entity_get_free_sched - Get the rq from rq_list with least load
> - *
> - * @entity: scheduler entity
> - *
> - * Return the pointer to the rq with least load.
> - */
> -static struct drm_sched_rq *
> -drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
> -{
> -	struct drm_sched_rq *rq = NULL;
> -	unsigned int min_jobs = UINT_MAX, num_jobs;
> -	int i;
> -
> -	for (i = 0; i < entity->num_sched_list; ++i) {
> -		struct drm_gpu_scheduler *sched = entity->sched_list[i];
> -
> -		if (!entity->sched_list[i]->ready) {
> -			DRM_WARN("sched%s is not ready, skipping", sched->name);
> -			continue;
> -		}
> -
> -		num_jobs = atomic_read(&sched->num_jobs);
> -		if (num_jobs < min_jobs) {
> -			min_jobs = num_jobs;
> -			rq = &entity->sched_list[i]->sched_rq[entity->priority];
> -		}
> -	}
> -
> -	return rq;
> -}
> -
>   /**
>    * drm_sched_entity_flush - Flush a context entity
>    *
> @@ -479,7 +447,8 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>   void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>   {
>   	struct dma_fence *fence;
> -	struct drm_sched_rq *rq;
> +	struct drm_gpu_scheduler *sched;
> +	struct drm_sched_rq *rq = NULL;
>
>   	if (spsc_queue_count(&entity->job_queue) || entity->num_sched_list <= 1)
>   		return;
> @@ -489,7 +458,10 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>   		return;
>
>   	spin_lock(&entity->rq_lock);
> -	rq = drm_sched_entity_get_free_sched(entity);
> +	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
> +	if (sched)
> +		rq = &sched->sched_rq[entity->priority];

Maybe write this as "rq = sched ? &sched->sched_rq[entity->priority] : 
NULL" and drop the NULL initialization above.

Apart from that looks good to me,
Christian.

> +
>   	if (rq != entity->rq) {
>   		drm_sched_rq_remove_entity(entity->rq, entity);
>   		entity->rq = rq;
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 3fad5876a13f..d640f4087795 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -705,6 +705,41 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>   	return job;
>   }
>
> +/**
> + * drm_sched_pick_best - Get a drm sched from a sched_list with the least load
> + * @sched_list: list of drm_gpu_schedulers
> + * @num_sched_list: number of drm_gpu_schedulers in the sched_list
> + *
> + * Returns pointer of the sched with the least load or NULL if none of the
> + * drm_gpu_schedulers are ready
> + */
> +struct drm_gpu_scheduler *
> +drm_sched_pick_best(struct drm_gpu_scheduler **sched_list,
> +		     unsigned int num_sched_list)
> +{
> +	struct drm_gpu_scheduler *sched, *picked_sched = NULL;
> +	int i;
> +	unsigned int min_jobs = UINT_MAX, num_jobs;
> +
> +	for (i = 0; i < num_sched_list; ++i) {
> +		sched = sched_list[i];
> +
> +		if (!sched->ready) {
> +			DRM_WARN("sched%s is not ready, skipping", sched->name);
> +			continue;
> +		}
> +
> +		num_jobs = atomic_read(&sched->num_jobs);
> +		if (num_jobs < min_jobs) {
> +			min_jobs = num_jobs;
> +			picked_sched = sched;
> +		}
> +	}
> +
> +	return picked_sched;
> +}
> +EXPORT_SYMBOL(drm_sched_pick_best);
> +
>   /**
>    * drm_sched_blocked - check if the scheduler is blocked
>    *
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index ae39eacee250..ca6b8b01fac9 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -341,5 +341,8 @@ void drm_sched_fence_finished(struct drm_sched_fence *fence);
>   unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sched);
>   void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,
>   		                unsigned long remaining);
> +struct drm_gpu_scheduler *
> +drm_sched_pick_best(struct drm_gpu_scheduler **sched_list,
> +		     unsigned int num_sched_list);
>
>   #endif
> --
> 2.25.0
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
