Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1305C33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 17:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F05D246AF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 17:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xfdZcbV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F05D246AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 715566EE20;
	Thu, 16 Jan 2020 17:13:57 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1256EE20
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 17:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOSW+nDw01iCF64wmw3lqisfGqRa7QFk1n5J3yRAmmflh+reHEecyPeMbDFlKNtBX32vQy7VyVSuNh/6aFtbkPq4i6ZDLzhKi3IKmQk/Iw1niR0xj93MuNmhsxPmNU4J+HmtDJHuEWjL6rDO3IGQZZmUpdcE9B5LE7n53Z6d1xT2h3DMEazACEcNOHHPEFuUxVW8gir9WyBLIaNdfjKQ4RHejMAIoEKA3euX5T3ypxGek7R4C0Xm1uuDAxN2rg/qXEcVWLQ5Sep0OTOck7YAFe7vVLcNwZbdQxIoJWVjuBhjwInqqENAndQ84ZP/juMoLRpUmUXESCPZwfLWnx2wBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag8PY5QWmPmvHg2PXNsUB1UGsSPMYexoscu1S4vSKsI=;
 b=azAWbmb4qYJWIF/AxD6yppavnYY4GSQETtGILXQMdSt/2LeO1BZZz5X7q20+nkyxZTWy6sOq2xvI3gowL8Xdgf9+kOSrnMmhV+mk2PwAfXruf+4IYx5fSHqL8SdMv+eOtFrP+zR8D/Zdpqf/bOzZGVlcfrj/IohSXBW41O8V7qhPqMtHbd2Io/m5ZuklzEzLmnVX0KzX/cfY6uUl9QMd+QzuYe5Oz65gISDNAg4PSP4TkuRIa0QgVUoq0MKrWoshqfXu2h42xxW9kwBiR47eUcnUamLpqtwD+4VedQzfKNj9BSHxa7GVnnOtPSh1kpSotk7GbxyZdnTvuLDc9On/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag8PY5QWmPmvHg2PXNsUB1UGsSPMYexoscu1S4vSKsI=;
 b=xfdZcbV3Amr/su9Sa+OweVYFrZ66jSplgOqQ07iteWadmMBSSa80eqQQvn0xzIMnNcD0k7bpKKcFCpEp31/3UEd7QGMtsTrjTFB2t+4tU7Ym385kSFt9DIuZQvRQYNOlF43BSahT9nTlJBIVjwdqQSvXb8eEIrj0vO6mijWXjp0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3499.namprd12.prod.outlook.com (20.178.31.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Thu, 16 Jan 2020 17:13:54 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2623.015; Thu, 16 Jan 2020
 17:13:54 +0000
Subject: Re: [PATCH] drm/scheduler: fix documentation by replacing rq_list
 with sched_list
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200116144320.109044-1-nirmoy.das@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <cec773a9-8040-ee55-c73b-f7165a117696@amd.com>
Date: Thu, 16 Jan 2020 12:13:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200116144320.109044-1-nirmoy.das@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from [192.168.1.2] (108.162.131.176) by
 YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Thu, 16 Jan 2020 17:13:53 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 069ce196-0c3b-4bbe-b322-08d79aa7771b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3499:|DM6PR12MB3499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB349927FC90BD9B91ED371AC699360@DM6PR12MB3499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02843AA9E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(26005)(55236004)(5660300002)(36756003)(53546011)(16526019)(186003)(52116002)(2906002)(956004)(66946007)(66476007)(66556008)(2616005)(86362001)(31696002)(8676002)(8936002)(81156014)(81166006)(478600001)(4326008)(44832011)(31686004)(16576012)(6486002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3499;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/k3JYUBmBOdu9YZpPYuQbYiSuh4jVanMmpi4PwLQg+0ztinpO0hoiJ/K6ETUCHkmBixcdjyROy5+rxwXxwfNNIv2aw4R5REFFo8yjl5C92YFk630cJdkkKk2h44UPaPyRAPkwohv56nGi0yGJIGmJWEg1fPi637qf+cu6k+1wa20zV/OHgd9eqoiCEIMFAAVurfRKxgDsK08b5A2c40e8IhEzFcT3Z6E7wZirFdXs50eoEh484UyXc5RLZEc25oYBs27t/W0S70AVCaV873GxEU9Kx3MJ2+Q7KogQho6m7DwpI/fMfSvTV8LvEG2Xk5gu/hknCbndtEpCAWphgCiG9pqkZXcCqyQhpcBDZUbyb+Dq1cbjarqUAxMVr5r1mN0aGkJGYfi6ACILAGAPYGeQ+PdLdG92EG/2YEiw9jshdVMclDV0svfxqE4VkRa3V3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069ce196-0c3b-4bbe-b322-08d79aa7771b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 17:13:54.7273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zboRexJXh6aaIyP+NwdLftkgxw++txRBmgl+jgITB+Sgas+j7lD7ZeB6c7an7e9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3499
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-16 09:43, Nirmoy Das wrote:
> This also replaces old artifacts with a correct one in drm_sched_entity_init()
> declaration
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c |  2 +-
>  include/drm/gpu_scheduler.h              | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 33e2cd1089a2..ec79e8e5ad3c 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -45,7 +45,7 @@
>   * @guilty: atomic_t set to 1 when a job on this queue
>   *          is found to be guilty causing a timeout
>   *
> - * Note: the rq_list should have atleast one element to schedule
> + * Note: the sched_list should have atleast one element to schedule

"atleast" --> "at least".

>   *       the entity
>   *
>   * Returns 0 on success or a negative error code on failure.
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 537f7a4655a5..9e71be129c30 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -52,9 +52,9 @@ enum drm_sched_priority {
>   * @list: used to append this struct to the list of entities in the
>   *        runqueue.
>   * @rq: runqueue on which this entity is currently scheduled.
> - * @rq_list: a list of run queues on which jobs from this entity can
> - *           be scheduled
> - * @num_rq_list: number of run queues in the rq_list
> + * @sched_list: a list of drm_gpu_schedulers on which jobs from this entity can
> + *              be scheduled

I had to read this a few times to understand it. I wonder if splitting
it into two sentences would make it clearer:

"A list of schedulers (drm_gpu_schedulers). Jobs from this entity,
 can be scheduled on any scheduler on this list."

Regards,
Luben


> + * @num_sched_list: number of drm_gpu_schedulers in the sched_list.
>   * @rq_lock: lock to modify the runqueue to which this entity belongs.
>   * @job_queue: the list of jobs of this entity.
>   * @fence_seq: a linearly increasing seqno incremented with each
> @@ -81,8 +81,8 @@ enum drm_sched_priority {
>  struct drm_sched_entity {
>  	struct list_head		list;
>  	struct drm_sched_rq		*rq;
> -	unsigned int                    num_sched_list;
>  	struct drm_gpu_scheduler        **sched_list;
> +	unsigned int                    num_sched_list;
>  	enum drm_sched_priority         priority;
>  	spinlock_t			rq_lock;
>  
> @@ -315,7 +315,7 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
>  int drm_sched_entity_init(struct drm_sched_entity *entity,
>  			  enum drm_sched_priority priority,
>  			  struct drm_gpu_scheduler **sched_list,
> -			  unsigned int num_rq_list,
> +			  unsigned int num_sched_list,
>  			  atomic_t *guilty);
>  long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout);
>  void drm_sched_entity_fini(struct drm_sched_entity *entity);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
