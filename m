Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE697C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9266A20409
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gYhwguy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9266A20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5761D6E9B2;
	Fri, 13 Mar 2020 13:39:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1584E6E9B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 13:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxC+jRD4MAcj/oOd7OUwGq3/7h00GOU3OrxUKp0H0bmXV2qsyyJd9J9Z21xKSZQ60VN0C10ruhG+VlFEgKU3PZ3GjxWBUA7MyRXRV+0jsmzXgso8fq62CfOpryM5A2f/ABIsP8NuYrEM83GaD+m33KaBeHYmX6erHk4jHmaHbRWxokESXgCNxgE/Tq3K3ClmUVvE6Tg1iY4rWqI0qVZ0mo6YCdL+wM7nKWMGdgJ7TFzovjyWsR7Rn26jeS5Xy1v9d8woaVhdzqSfYJrGz6mTNfM5MVLNyCjhOyRu6InhxGyuHpbxkzhtbqIUQL7KpsxBoX1g3FRxIskXQ1ntfGJHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RmzgTN1/ipqMrskyQ7N+77Qot30l7pSY6TYfG/HpJs=;
 b=VJ8did9IG7bqUg6M3uV1b1bTKtbgVT8dVfOrbTzitvkqirgRB9oNtIk3ePuEO3v/6ENKepefJZTlRkskNBv0cxltLFxe+VAzH1D2XYtjsaFvgORkvXKZ8cC/c4Aug2eIZKLme+qs9P9th/vBqRPenA/yrj6p3nc3PPRGPU6v3QhVATQujgTgpy2IAEE20rWX7t36xJ8Hei3JOcpNLvsTWDxNHfsL4SuRfJEOwKfQ67FvC188wNcqyAAa0OgDLU6L7e5m5uV+pba9Jk4/D6PK7Ek6X+lIVukR6aY7WyMosIOJ8hecWPRjhWSSSTxS0CyoRq4oy9Ve+CWonPAh1rHEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RmzgTN1/ipqMrskyQ7N+77Qot30l7pSY6TYfG/HpJs=;
 b=gYhwguy3VVlaOetESiHMW2f9DP3xWOmAaBTkC23bUStUeButWNGSrJzZk0rw7tzYw08etD4ek1Uoa379BuaHaUQODUWFKLXmhd62+5WdwwpnyLgF3WIis/WCRUuEZxA0w10WE23vnt4P6B/5hTPewnLyywZAzDXXzXJxstZ31mM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 13:39:08 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 13:39:08 +0000
Subject: Re: [PATCH 1/2] drm/sched: implement and export drm_sched_pick_best
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200313120508.36004-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <17bcfd9b-2540-ff00-925d-c6c4b8c4f820@amd.com>
Date: Fri, 13 Mar 2020 14:39:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200313120508.36004-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Fri, 13 Mar 2020 13:39:06 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5e28e88-3fed-4273-47d1-08d7c753e7b0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:|DM5PR12MB1658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1658C0F2EC8321019202F24A83FA0@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(199004)(66946007)(316002)(2906002)(66556008)(66476007)(36756003)(2616005)(8936002)(5660300002)(81156014)(52116002)(86362001)(31696002)(81166006)(31686004)(8676002)(186003)(16526019)(4326008)(6666004)(478600001)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1658;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4H1Tn8/Foffdx8ePiobl77ZYfqZJgYX9fqIlpSrRL1OJNCIvRo5082mIhZnfSubaUoigkUhzzwzE8D4HNtL8W6VndIho4e8AthRlBOdoYcurTn8E+cAGzZXCPNvhfcNremPwLyWMTu6m6A2u4k9OUeQqn9uFidQthE5tEnjWaPEhY4KuZAOv1WPcbGE0rt024Vq0GQPlHG80tia3HxtoY+XQ5tEbcuwittDcOA9nRvy/xLfA8fSZ8NxOBaJZkLuk8QDRZcggnfEMv7MJ9oe4CqrjbXugIMHy129KVtqqqDom3c9ihEORChIHaVueutcqEnZVJAbJquiKl5GjfifCAj1cpBBlApCQt+51E0fFHLdQfSjZyYqeu8EKw083AFSbFe2oPb+STe/aIlFcXvFCwNOHGC4x/vbXGbNLIwMv+gMEquAazGvNqrRNN0OqYDZ
X-MS-Exchange-AntiSpam-MessageData: 6Zt64TWHpq815S9olH/kQ0M5UUIOBAaOSToWoxlHYZ5T5tOb9YXC1Fg3o4MuZcqUZnYITYiH7KbFk5PEyfhE9yZcPIxLelXrjT5Niwx+aGXEDjyZduqa6B7eVBEli+S9THeVK5Et/dh2Z4GYN/Pj3KhVpFQpWhMwA4QK8tombzp8U3UapX3oZSA5Ge6GgEuJ6wR9KKmgs29QDxuY3MPGXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e28e88-3fed-4273-47d1-08d7c753e7b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 13:39:08.1356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9kB2mgZd5d8uMncS2cghoa3b8YOGltIDf1BTpbkuGERaidVBaEzF4fOAx2Jd6ih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
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

Am 13.03.20 um 13:05 schrieb Nirmoy Das:
> Refactor drm_sched_entity_get_free_sched() to move the logic of picking
> the least loaded drm scheduler from a drm scheduler list to implement
> drm_sched_pick_best(). This patch also exports drm_sched_pick_best() so
> that it can be utilized by other drm drivers.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 20 +++-----------
>   drivers/gpu/drm/scheduler/sched_main.c   | 35 ++++++++++++++++++++++++
>   include/drm/gpu_scheduler.h              |  3 ++
>   3 files changed, 42 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index d631521a9679..3f6397d60bff 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -147,24 +147,12 @@ bool drm_sched_entity_is_ready(struct drm_sched_entity *entity)
>   static struct drm_sched_rq *
>   drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
>   {
> +	struct drm_gpu_scheduler *sched;
>   	struct drm_sched_rq *rq = NULL;
> -	unsigned int min_jobs = UINT_MAX, num_jobs;
> -	int i;
> -
> -	for (i = 0; i < entity->num_sched_list; ++i) {
> -		struct drm_gpu_scheduler *sched = entity->sched_list[i];
>
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
> +	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
> +	if (sched)
> +		rq = &sched->sched_rq[entity->priority];

Keeping the function just for the two lines doesn't make much sense. 
IIRC it is called only once, just inline there.

>
>   	return rq;
>   }
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
> +	 	     unsigned int num_sched_list)
> +{
> +	struct drm_gpu_scheduler *sched, *picked_sched = NULL;
> +	unsigned int min_jobs = UINT_MAX, num_jobs;
> +	int i;
> +
> +	for (i = 0; i < num_sched_list; ++i) {
> +		sched = sched_list[i];
> +
> +		if (!sched->ready) {
> +			DRM_WARN("sched%s is not ready, skipping", sched->name);

There is a space missing here between "sched" and "%s". And maybe write 
"scheduler" in the message.

Apart from that looks good of hand,
Christian.

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
> +		    unsigned int num_sched_list);
>
>   #endif
> --
> 2.25.0
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
