Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4020DC2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 16:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F212073D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 16:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IyN+6NEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F212073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B5D6E9FD;
	Mon, 20 Jan 2020 16:43:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2C46E9FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 16:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQDXxQ5Tg6XdYNGMo+pABfxQNxH8j/mI7rRbaGp/Bp1OXuL0P2JKvD+1D0pKRnP/OMvUHUwqroYuGpvS6dHESqv2zMwKSCB/12wfRWM1QlNHF3HKiIVPfEFc/J2udNxC/uOOuh9AjXuumD6YjfjsvXA9bJgyrChHgfBB7oKsfdKD7ms01S2wcx0ZYNkcEyfmVR4Z223aM8LsWNIUhxuYWGjcrdGcHrkhOLgDSzyG/jXZH+e1ajelxrAOW39+adOfy+5LzCJUny4Ecmbb+neiUI98kYb+lwApsPMwAoc1P5RpUKyExgTI4UVdK8WWPo0on6xjaEZqEAR2TB0TySb1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzXuoXrRKhxuNhc4ypi93I98tPmQ873ARZG0nPe71D0=;
 b=GblTj1ciPjsJepUSlJ+cyj85KiQf7TzHiv1T4HNcGdM5IqXf+zyQxCS2YdUgySiMmRjFwSAJwQUz2Qffxl0vBPZMRnlP0rslc5oCL/kO1Ukk72XxG4ZrR32fGeYvZWAuz43SA3EP5v369ulgELn+muWzpnaubPDltYWjOP+r4VsSScGsJ1Ar2L01VVyn5PnCm3cxYfhcJy3rV7JmPnvMtr52CUhIhdPpw7Cb5Jf4D1tPy96ik71dZWX9r5WOj2WSRvkc1ZxNSDp9ztu7pCVApVqdBjqfDaVb3664uD6WmREEdFXYDIXnxeQHy4mXcqooKOk057UlkE87pRlQs9e0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzXuoXrRKhxuNhc4ypi93I98tPmQ873ARZG0nPe71D0=;
 b=IyN+6NEdynslzsZbUZ9LVvQxJJcWHejbu17/unrW5HVedpoEmUxa9R8OTQQ96bonxRCNKlO5tVhDSavuXd5j3mZzA80pjwJDcKatvSF4fB2YZJ0X4FT7+/IBi+1q4vexwFsuGEw9x7WqESat0Fldw7K7NiqXbWdOEMZiH7XLfDk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3737.namprd12.prod.outlook.com (10.255.173.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 16:43:29 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 16:43:29 +0000
Subject: Re: [PATCH] drm/amdgpu: fix doc by clarifying sched_list definition
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200120163536.28801-1-nirmoy.das@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <02c9baa3-f32b-f359-bfe5-329a329b1164@amd.com>
Date: Mon, 20 Jan 2020 11:43:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200120163536.28801-1-nirmoy.das@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::24) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 16:43:28 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8abfdd41-24b7-429d-d270-08d79dc7e0c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:|DM6PR12MB3737:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3737ABCAC84411FACF80A73499320@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(316002)(5660300002)(6486002)(81156014)(8676002)(66556008)(66476007)(66946007)(31686004)(36756003)(6512007)(4326008)(16526019)(6506007)(53546011)(478600001)(26005)(186003)(31696002)(2906002)(86362001)(956004)(81166006)(52116002)(44832011)(2616005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3737;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuhvMyl1oef/Y2aIU+/QiNIdaMuvFTSdlvp4DjFCMRaP+sGMI86DWmJleUuqh4xQ/M7Nld3BJaIvfUUj16euuxMy7F+K3Ais0zrTUbW+EstwHHEKoc4uGOUHnRh1vBnge9JRJbNq/nYSQSkNdyJ04pYZmB0pSZocRWOhjhTgod5Nh5SdqlpaWTRO/DUOrJp9WeaVaYRSM05QrDYs8FYxQ/UBJoHvBSK+tgWNbAqzEj6WpgIAO5DEYemHKIB11koj86VL4aeHkyVg85QY+rPtxawfzWZ0AqT4ifrdeqiUOdWwByZ9c3O59nMtw7yCImUtcFx10wZuHAuHH/hinpF1Bqe9z3wDCTIdEOrkvFKD0vnCD7kUOS5TVbJ12l2udY2RejTy4r6CljHR4t3lvoc1RLGvykt15B2x4pJHCOA6xroej0/2DBg9hhOOFtA0rFqL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abfdd41-24b7-429d-d270-08d79dc7e0c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 16:43:29.3403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgFKy3CCF2RJRE3WMfFC/lizWz3xyNTu6lt5W9VaCUbmyct1y8x0K9VNVNd34t74
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
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
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That looks excellent--thank you for submitting it.

Hopefully, the documentation would be more accessible
to everyone, so that everyone would contribute.

Regards,
Luben

On 2020-01-20 11:35 a.m., Nirmoy Das wrote:
> expand sched_list definition for better understanding.
> Also fix a typo atleast -> at least
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
>  include/drm/gpu_scheduler.h              | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index ec79e8e5ad3c..63bccd201b97 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -45,7 +45,7 @@
>   * @guilty: atomic_t set to 1 when a job on this queue
>   *          is found to be guilty causing a timeout
>   *
> - * Note: the sched_list should have atleast one element to schedule
> + * Note: the sched_list should have at least one element to schedule
>   *       the entity
>   *
>   * Returns 0 on success or a negative error code on failure.
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 9e71be129c30..9ebba61db177 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -52,8 +52,9 @@ enum drm_sched_priority {
>   * @list: used to append this struct to the list of entities in the
>   *        runqueue.
>   * @rq: runqueue on which this entity is currently scheduled.
> - * @sched_list: a list of drm_gpu_schedulers on which jobs from this entity can
> - *              be scheduled
> + * @sched_list: A list of schedulers (drm_gpu_schedulers).
> + *              Jobs from this entity, can be scheduled on any scheduler
> + *              on this list.
>   * @num_sched_list: number of drm_gpu_schedulers in the sched_list.
>   * @rq_lock: lock to modify the runqueue to which this entity belongs.
>   * @job_queue: the list of jobs of this entity.
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
