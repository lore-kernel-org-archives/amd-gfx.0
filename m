Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FFC433E7
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 08:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0A322247
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 08:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vQYjtqQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0A322247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350B76EC84;
	Fri,  9 Oct 2020 08:14:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247246EC83
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 08:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZ5e/edXQsImNG44ZAoDgX2RfpZqtjvULzP+xrozJ72cGbrU4dHV7x9YQOcr5yUmhbkg4/Q5RMyJR4OnEJzW6obfKg/z5zGaYxf5GUSsDX7vu5FAqefTgav7jfG1ljaOrkrkQXxy6ZtWJU/sc5wEtuj3WE+hN+j6PURfnAI3XjWrluTKPamefVbf1VBs52ARH5a/Yz9i8e9X/XOEJe4NYgNQpOuL0I93lj2W0WennEgBOEHJ0VzR6RGd7TsluEXowei0hDEGU8tt+BhP3IuiiE1RmHSII+On3/HEiYi8ZPtta6AzKpsCVi9qvHKd1EPeJ/TwSsMK25XxvnrB6+Mo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfp3E+m0DQjQcufJJ5AdJL7yX35HRnJDuJdoPvb49ak=;
 b=HHyRxa8wk2QqWtt0JLZojQzCwKUdoRWgJmc6pZPRkEcrR4KcoCpeku2Zn/2WM4UEQ5acpaygEYYx7JdltvPYifD63WO32nj2pf1IM8oxM8FO28LELLJ3SL0Ft1CVtDz57hS4nd3UVSQ6kYzMtjFm4IqVZypY3lR0tU1GSbnmwxgHb0pCW0hhsV1pvpdCEY6jPj0q4Vos3+b8btKWecu6jPxkKtMwAd75e2YjIHgZqLYZg+9Eh3qM3Jza2viXjiI4OnBDw2sOqmUTH6LWQda30OomJBycwieM26SERj5HAp4vuQFNVVDbjx54moR8Uq8yM+eThr3DWt1SW8163L/c2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfp3E+m0DQjQcufJJ5AdJL7yX35HRnJDuJdoPvb49ak=;
 b=vQYjtqQ46mGa1usd8ggAmoeaXXHlyvq2MXF5Zb+EYk42ooYgP5wo1/Qsc+WJfK5youBA2QeXRH6CRPkuTqEGEcmwO6OISio6I0T0xBzRMk+Qvi3QMVfNlnN7cB/QFE7xmhch3Hl3E54daaS6BPub6J4L1M6DfvWQBQhK2DlKCJE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1129.namprd12.prod.outlook.com (2603:10b6:3:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Fri, 9 Oct 2020 08:14:39 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3433.046; Fri, 9 Oct 2020
 08:14:39 +0000
Subject: Re: [PATCH] Revert "drm/scheduler: improve job distribution with
 multiple queues"
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "Zhu, Changfeng" <Changfeng.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201009061631.15383-1-Changfeng.Zhu@amd.com>
 <BN6PR12MB1425712D9E63A75FCF1BC3D4F0080@BN6PR12MB1425.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <a5703b1f-b35d-2985-cb99-0f20fa8f5b4d@amd.com>
Date: Fri, 9 Oct 2020 10:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <BN6PR12MB1425712D9E63A75FCF1BC3D4F0080@BN6PR12MB1425.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR11CA0068.namprd11.prod.outlook.com
 (2603:10b6:404:f7::30) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.0.35] (165.204.84.11) by
 BN6PR11CA0068.namprd11.prod.outlook.com (2603:10b6:404:f7::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Fri, 9 Oct 2020 08:14:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 399774d5-b548-451c-54e4-08d86c2b5e00
X-MS-TrafficTypeDiagnostic: DM5PR12MB1129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1129C62D409CAB0C1C59E2298B080@DM5PR12MB1129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /TtSFGnEIJc4oA6UerhIU9xmOkUAzsVDJF2IAG9Nfsnvwz0DpqiZEqUClFKk7iKg6E3cYhvAL6YQZoStyVREO2gwUBcg8lqo/2vmq73SdVEAtDF5tYjvH8u8yNGrhlsuHSbjCVOjmKr5TUZojOFsQ0qmLaDLwXEG/kcAC0Sx1T5FjNHMx18/9tdvCJzlS6IFHTnnBvxFd2/OwNsr7v/e2o249ULIUFdKuggUHI0+fD8uqTDMpH6o6SyFZEzIwHbaw9YSj6jG3NguetwwAD0twLD8weCM7QogsLzWrhnUiohry/rSwEasqLZUAK2bY/4VRX6pW6eXIaG9HXExyOoyepw7WQZD/Yv08or8aRYnvwgGt7E8ZwdMzUKFWopUeK3U+X+0yfZNiIwPaDrInlCBd6bAzuLQYpqSDWSV1oS17iQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(6666004)(5660300002)(966005)(31696002)(2906002)(8936002)(6486002)(83380400001)(956004)(2616005)(478600001)(66476007)(66556008)(186003)(26005)(16576012)(52116002)(53546011)(36756003)(31686004)(110136005)(316002)(66946007)(16526019)(45080400002)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fT4UKzwfEz9HfOWzkJcwZXjT9CxOItnvVJfKn2vVpTy66Tvuu9Td1PkpFpFRPpdjtExvvgt4PTh+5DXbSsegr39o5TP+jjWQX+FyeVqASims/bXGc8sbz5PKPG7Tv++OJTT2BgPWdY2t+CYWpxoOYtNfUOb06yvPjYK0KxwlH/QU7v5PuSVtXJ9+unMa19MVakXfrObxP5gCLd9gpW7r/hIUgpWlRJjpoFQxXKLEmMuNtfJhB6bmMgHs6FUZ+sU1yh2syiQeWjKHKdxHrStp7DFGR0j+3wG+k4AR8DoZmFbVrOMaqih/ZIURgQlG7va3qEzCm8i7Sdg47q5XHomegLAnRdwLUzHNbMvjAtFi4D+k4Qyz+7noFTBV2RpaHYjF4t4KwDrA7+oROc4mtr4DIEa/jbCQr31iRSS4cIyJ03sOb/xRstI7S0Xf4VAAgPPNJErTh4OwVCOxD0XHtUSjcLTJIcwGEAFnLWBuoZoNo+mlSGQnODBMBcuCelNQAtDALFCmqu1XRdCk0UdnDojnvQaTyt+VALn1zdpaEiKrnBHzJcsj6Js7G/7mlNPvc//CcGeU3Y76vz1nFRjQYW7i/hGNml3i01Nxq5453plVSJwl+4dHggcbO+hHsRuYvh9qGlXbb0lvhVWxx1qNuNd0gA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399774d5-b548-451c-54e4-08d86c2b5e00
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 08:14:39.2606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tl50Z5XZKpCN6iluuPHSnI+UgyZPwM+0JfKWRFqxpmeYNgg5BXCuf9hK3FLQTPEAOOXt2vbsP9q0IkJuGJaVyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1129
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please do not merge this yet without more debugging.

On 10/9/20 9:55 AM, Liu, Aaron wrote:
> [AMD Official Use Only - Approved for External Use]
>
> Acked-by: Aaron Liu <aaron.liu@amd.com>
>
> --
> Best Regards
> Aaron Liu
>
> -----Original Message-----
> From: Zhu, Changfeng <Changfeng.Zhu@amd.com>
> Sent: Friday, October 9, 2020 2:17 PM
> To: amd-gfx@lists.freedesktop.org; Liu, Aaron <Aaron.Liu@amd.com>
> Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
> Subject: [PATCH] Revert "drm/scheduler: improve job distribution with multiple queues"
>
> From: changzhu <Changfeng.Zhu@amd.com>
>
> From: Changfeng <Changfeng.Zhu@amd.com>
>
> It needs to revert this patch to avoid amdgpu_test compute hang problem on picasso/raven1
>
> Change-Id: I5c298bb0c6cd64c67de712db551d15974c41493e
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c |  2 +-
>   drivers/gpu/drm/scheduler/sched_main.c   | 14 ++++++--------
>   include/drm/gpu_scheduler.h              |  6 +++---
>   3 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 146380118962..c803e14eed91 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -486,7 +486,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job,
>   	bool first;
>   
>   	trace_drm_sched_job(sched_job, entity);
> -	atomic_inc(&entity->rq->sched->score);
> +	atomic_inc(&entity->rq->sched->num_jobs);
>   	WRITE_ONCE(entity->last_user, current->group_leader);
>   	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
>   
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 9a0d77a68018..851443a19ee0 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -92,7 +92,6 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
>   	if (!list_empty(&entity->list))
>   		return;
>   	spin_lock(&rq->lock);
> -	atomic_inc(&rq->sched->score);
>   	list_add_tail(&entity->list, &rq->entities);
>   	spin_unlock(&rq->lock);
>   }
> @@ -111,7 +110,6 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
>   	if (list_empty(&entity->list))
>   		return;
>   	spin_lock(&rq->lock);
> -	atomic_dec(&rq->sched->score);
>   	list_del_init(&entity->list);
>   	if (rq->current_entity == entity)
>   		rq->current_entity = NULL;
> @@ -649,7 +647,7 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
>   	struct drm_gpu_scheduler *sched = s_fence->sched;
>   
>   	atomic_dec(&sched->hw_rq_count);
> -	atomic_dec(&sched->score);
> +	atomic_dec(&sched->num_jobs);
>   
>   	trace_drm_sched_process_job(s_fence);
>   
> @@ -714,7 +712,7 @@ drm_sched_pick_best(struct drm_gpu_scheduler **sched_list,  {
>   	struct drm_gpu_scheduler *sched, *picked_sched = NULL;
>   	int i;
> -	unsigned int min_score = UINT_MAX, num_score;
> +	unsigned int min_jobs = UINT_MAX, num_jobs;
>   
>   	for (i = 0; i < num_sched_list; ++i) {
>   		sched = sched_list[i];
> @@ -725,9 +723,9 @@ drm_sched_pick_best(struct drm_gpu_scheduler **sched_list,
>   			continue;
>   		}
>   
> -		num_score = atomic_read(&sched->score);
> -		if (num_score < min_score) {
> -			min_score = num_score;
> +		num_jobs = atomic_read(&sched->num_jobs);
> +		if (num_jobs < min_jobs) {
> +			min_jobs = num_jobs;
>   			picked_sched = sched;
>   		}
>   	}
> @@ -861,7 +859,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>   	spin_lock_init(&sched->job_list_lock);
>   	atomic_set(&sched->hw_rq_count, 0);
>   	INIT_DELAYED_WORK(&sched->work_tdr, drm_sched_job_timedout);
> -	atomic_set(&sched->score, 0);
> +	atomic_set(&sched->num_jobs, 0);
>   	atomic64_set(&sched->job_id_count, 0);
>   
>   	/* Each scheduler will run on a seperate kernel thread */ diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h index 92436553fd6a..a33590e62108 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -264,7 +264,7 @@ struct drm_sched_backend_ops {
>    * @job_list_lock: lock to protect the ring_mirror_list.
>    * @hang_limit: once the hangs by a job crosses this limit then it is marked
>    *              guilty and it will be considered for scheduling further.
> - * @score: score to help loadbalancer pick a idle sched
> + * @num_jobs: the number of jobs in queue in the scheduler
>    * @ready: marks if the underlying HW is ready to work
>    * @free_guilty: A hit to time out handler to free the guilty job.
>    *
> @@ -285,8 +285,8 @@ struct drm_gpu_scheduler {
>   	struct list_head		ring_mirror_list;
>   	spinlock_t			job_list_lock;
>   	int				hang_limit;
> -	atomic_t                        score;
> -	bool				ready;
> +	atomic_t                        num_jobs;
> +	bool			ready;
>   	bool				free_guilty;
>   };
>   
> --
> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cnirmoy.das%40amd.com%7C75e1273ed6b9467044a308d86c28c590%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637378269699333590&amp;sdata=vv00jgI0dfdRbzPxmSoRWJRYik2dsKKxun48lgrSQUY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
