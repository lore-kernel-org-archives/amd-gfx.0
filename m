Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B98C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8942072C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aqjrmg3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8942072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1007D6E9CD;
	Fri, 13 Mar 2020 14:00:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FEAA6E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+1VsCyfDkhdCVxZbUQQMdf6dJxQEERzvRIAz5MukOXZRu+dau3UJsXqrZg9AAIuNb1616Zw7N0i6SNHR77v6dEv2yp5goDUKoNRQL5L7MTPlSLPc+T7A8kGZYzdUF3chP5vKlYRxa5DzA0Pz4EHdMQ5H7ifbA/c+cGcjqE1K7w9epvTrl+HM079qiTDoDdYdxU2OIu48mpRX6rhr4w8RdMAx+3PiW2JuayuZC2Fem562QpQiwIsbPMRUIE9XXfSqeYt3Cm/YbfzlHhYv856WM+gpw3x9BKVV2TUBiPPxaDqekTjxKt2vbJXmlXrCYT21InpJ5oKcYs286JlNbg65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojk+BbBKCBFiBcENeke5kxrwQ4rNrP0IabPpYbrmPZ4=;
 b=N0VS0XgnuNwCE6JVGOeVQE5PTXb8KvJqWvaso6qiZ06RjC6wQLYKKVuWYjxCX0Knv44pWmgRz4rMUcHzSTbBvvGCrk/1JFMQB/ptoNo6BjYkd9y+L1L5oaXcDXV0oTtdLsV9OLz3PValBYuRzxvvE4es3fL9W8PH5DycG3xk2GYEzOTPs/cV92eBdGU/GKJAJCK7Hk2OmeC9/tksT8vK954N+wKz31QvLtudNJkg8b+U2s2K9AumAuG1GzK5odHY6unBQspEgWqu4/pn+7OXnLaG6x2JhF1J+OmAcGbcKF9+zDTbluFVa99zBitp4R5H8M9MWvPMHQn7s2WS9pzaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojk+BbBKCBFiBcENeke5kxrwQ4rNrP0IabPpYbrmPZ4=;
 b=aqjrmg3H6arNMzdHXdwrHpqwCpZHGETjYyOgtmJLzVoKp2KpTVYPqsJu/lR5Wsbg+yiY6C8hRPt5IGbVxiASuetg0yuEFUXD4Zjs++G02Y1leeQs6RXaFDu9hksN4Wn4WFoky1zB8y5+9/WuAcQhpdkl6gUR71Yx9bn27RHJQek=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1769.namprd12.prod.outlook.com (2603:10b6:3:10f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 13 Mar 2020 14:00:07 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 14:00:07 +0000
Subject: Re: [PATCH v2 1/2] drm/sched: implement and export drm_sched_pick_best
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200313135953.68418-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <a536f004-fa82-1ed1-fb0a-420201047ad4@amd.com>
Date: Fri, 13 Mar 2020 15:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200313135953.68418-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0002.eurprd05.prod.outlook.com
 (2603:10a6:208:55::15) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f29:a900:db15:8106:d933:a960]
 (2003:c5:8f29:a900:db15:8106:d933:a960) by
 AM0PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:208:55::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Fri, 13 Mar 2020 14:00:05 +0000
X-Originating-IP: [2003:c5:8f29:a900:db15:8106:d933:a960]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f8df785-c950-4184-f517-08d7c756d645
X-MS-TrafficTypeDiagnostic: DM5PR12MB1769:|DM5PR12MB1769:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17692689BCA2CFFDB76EFBEF8BFA0@DM5PR12MB1769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(8676002)(6486002)(31686004)(36756003)(31696002)(66476007)(2616005)(16526019)(66556008)(186003)(8936002)(66946007)(81166006)(6666004)(5660300002)(4326008)(478600001)(316002)(2906002)(81156014)(53546011)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1769;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdQGtZ8xEVWNC6nxmOySkpEWtYgJsSQQNf4M88cYVgyNFkwJU+zD8nfR/aVYTicPF9Fqfw/4jh451ru+TGrCTqUc2oDt0q7S4nh4XxzaQx1J5JI1u75IbM9VXmwyrLMa1Zzm2GWlYuzaBTW2BNR4o+gHw7wRKSEoDrpV81qqSxcHdnOnA3Wd78T4thioBUcSr9lwutWWy/yW6IyC1W085Uwk7R/d0XflMr5bFP4JC+Q9m+gzEH490JE3kP0rNPGaD/QDH783o0oAtLinBoGBfBpUfEvWAeRrDpg6J36nHVfjQv3Q9b418Ro8xonHaqXQWniQttZOj4Q38wrZAtNC32aM/LTqJq7JgJ3dMuQYIrmEEtZkteavhudyqAYFuES84wicrwWHv7V9kKVHUgEYqmN5QbNG7ShxvTwbLUX1Pq48nyuBylNM/2raQVj8z/eK
X-MS-Exchange-AntiSpam-MessageData: 5CxMN5gJWWynSyDkRnRV31pAxETnBlq8p6AcI2hd7CCYRP0rCW5uYMdHQys2Hu4FOOEhNm5GOL18MU86o3M8gFSmyv8xyWpog5ApJCFE2GInQMV4FRsgyJkHD1JEium1wCzezLumWqii+oBkCh+TsIZimUGSYuKv2G/IdjTsxrkHwdT3W6zIk2BdW6A4XSx5uMmQnr4DruQQk9k5vgYwPQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8df785-c950-4184-f517-08d7c756d645
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 14:00:07.4217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1q2q5IJQ6uFGXz7E4ufkSqqjLJ0VMdpP/92rjjoYKNCUznV3SMTC9qXz8dpEygFcWCNT6Tq8NlU9Rn51eXob2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1769
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
Cc: Boyuan.Zhang@amd.com, nirmoy.das@amd.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ah please ignore this I forgot to change the "sched" -> "scheduler"

On 3/13/20 2:59 PM, Nirmoy Das wrote:
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
