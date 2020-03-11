Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5114AC0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 17:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBC120736
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 17:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZtvxTcMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBC120736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9096E9C4;
	Wed, 11 Mar 2020 17:23:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A856E9C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 17:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diObx7TRn2QqJo9af4f9RVzg8QmYvIvhlPBKMtYW6kaFAaHvZaZ8qAGmW23DiA9lDQWqcyVs5ZBE3VoVC4lDhCDSKnYjF4CyS+FbjyTsTi+ScGhJy44lgFr0FZ9qwwHBaXv+6WKF8EdtVFhE4/tXAPb1cZcJ94xXGpvpxyK0Yzi8zxkx4x3Mt2O961DOxlF/eMinYoiNcq0oJ1F9oHPCD27YhEeWdiDvWgJgkRROMkcPWHc0JV6eenNpz5N8odLDT8tXVM2O4g5cpcWu8THZ/x2JPmSS+6rB83i4q7PbPzKu2Ezj8FHFdDjKAK9yagYhtk4BO0WAaP6FLvQiB1nlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7gFt3aJtHWV1lq4nDeZQlXbVnaTXvYIgNPnmDDAC+U=;
 b=fgiY69Ko3JKz11JAi5tWJB2BjWoSiNBYZ/Nkd2eSLnKiFdUVj6/zSnmKupU905WfMrKtrD8YkXjpro/SQmHAY3nvEHzJ2TiyDNjcMznPpbJ2bq1iHE9OveXbsQwhMKi9b77l+Yi2dZXa/LUbZx0/tFmiQEvZg6SnRJsJnv3JUsJ1EsiUKsAv2W2U1FZSe4E/WSB92VLzQS2yb8iL0eb5b8jzH9Ex3UvKutZ0w0fyS6kD7GeGdcJS7V/MMZ4djtesQAyKpA6tuw99tMDpUC2NXjNPEsm7v5kaOc825p4A2M/Eqhzy/d0NytnwewK3HUbgFAlC8xMbRYNPymajdMoNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7gFt3aJtHWV1lq4nDeZQlXbVnaTXvYIgNPnmDDAC+U=;
 b=ZtvxTcMeiNvG6w38ckNAfk1rhGnkDUbPjV4Jqh6CtMJlcUT7dqQyU7IXbhnYuv9Lefo2wIcocc2PxXjlz4bI7QxYn1dIo6xaXb4KLC59f0pMReIjaZEmqdcQAdU/6MmK9wXNhoQ6r5RqwIlmFfVd0FXAuQ6QgnDCMtUBbyqD2SY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1871.namprd12.prod.outlook.com (2603:10b6:300:10b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 17:23:54 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 17:23:54 +0000
Subject: Re: [RFC PATCH 1/2] drm/sched: implement drm_sched_entity_num_jobs
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200311171809.7115-1-nirmoy.das@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <98391772-ecca-035e-73ff-26a3d5c8286b@amd.com>
Date: Wed, 11 Mar 2020 13:23:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200311171809.7115-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::32)
 To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YT1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 17:23:53 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56133274-a22b-4778-9d90-08d7c5e0f94f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1871:|MWHPR12MB1871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1871E090D26BD43051766A23EAFC0@MWHPR12MB1871.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(66946007)(5660300002)(66476007)(66556008)(2906002)(16576012)(4326008)(316002)(16526019)(81156014)(81166006)(956004)(2616005)(8676002)(31696002)(26005)(186003)(86362001)(36756003)(53546011)(478600001)(6486002)(8936002)(31686004)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1871;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5E2Hii001j7Kelo1SpXTGwCKh+C4mEQOkpmMmcbwkznJK5vEEWIRNsVA0GLKJjd3sP7ZfNn6upsBElC8so9SBoU8cBUV9/FxncWgUgywGISY2069hcyE6rLtoqs5Vh63ZK23z7GaXZm7cD+vUN+kl27QHZONh42i/2EhVcBg2WM7H8OJSYOS1DCvSAEcGurz1NJwSia3jzhB3lDi3H5hHmq7Uv11Wruevf9alVx+7qto2hl1pZdPyeBysAm95BJpGTPJcQp15vjNhR3HgHsNoa+YlevtyrzKTDMs9A1QAoNK715o0vr+7ix0lG8X1fpabXyvx+dDseVoQfQmxkVAY1xIR+lqzjURuhQb8IM9MbXjXfXPJFVqqt7kVsL9mVynfNzGmQo3tyCiyQlZYdlQ7k5/A15Iw6E9XPFLR0AAWwYl8wsK+94C0vOJAJ8cyorV
X-MS-Exchange-AntiSpam-MessageData: L88n6Dw8oAI9UBeBeqRFYPbOfs8TtJvJ8fl73vgA2ALapMuBX0c7dkndnvMDSU6B3m/Tbl1O4GJyKnjkeS2sDMfkng4GZJBArYW/oiqiaZI0kEjr5W11qrcFvuHKz7hz4nQrJYXG8vsiU3k6mm0CJg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56133274-a22b-4778-9d90-08d7c5e0f94f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 17:23:54.4993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqEH7BBfVs6xzvlFbjy3AAh1EZ+r2QIsssatvkxI5cmt1HzFdZLjHU/JAANIIett/nF0dg0tXjf8eUoRlQC8Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1871
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


On 3/11/20 1:18 PM, Nirmoy Das wrote:
> Implement drm_sched_entity_num_jobs() so that drm drivers can
> query number of jobs in an entity.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 15 +++++++++++++++
>   include/drm/gpu_scheduler.h              |  1 +
>   2 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 90fd9c30ae5a..dfe8216f2d52 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -119,6 +119,21 @@ static bool drm_sched_entity_is_idle(struct drm_sched_entity *entity)
>   	return false;
>   }
>   
> +/**
> + * drm_sched_entity_num_job - Get number of jobs in the entity
> + *
> + * @entity: scheduler entity
> + *
> + * Returns number of jobs in the entity
> + */
> +int drm_sched_entity_num_jobs(struct drm_sched_entity *entity)
> +{
> +	if (drm_sched_entity_is_idle(entity))
> +		return 0;
> +
> +	return spsc_queue_count(&entity->job_queue);
> +}


What about the jobs which already have been dequeued from job_queue and 
are in progress in the HW ring but yet to complete - don't they count ?

Andrey



> +EXPORT_SYMBOL(drm_sched_entity_num_jobs);
>   /**
>    * drm_sched_entity_is_ready - Check if entity is ready
>    *
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index d8972836d248..b5ceff75cbbe 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -341,5 +341,6 @@ void drm_sched_fence_finished(struct drm_sched_fence *fence);
>   unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sched);
>   void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,
>   		                unsigned long remaining);
> +int drm_sched_entity_num_jobs(struct drm_sched_entity *entity);
>   
>   #endif
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
