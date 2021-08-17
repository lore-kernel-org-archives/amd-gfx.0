Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD86C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 13:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7414060F35
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 13:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7414060F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9BF189CBC;
	Tue, 17 Aug 2021 13:37:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E5D89CBC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 13:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4MNoaJrYMOfL9jHWGEFBMVF4wysBEmKIPAMzLz3HX2vipbyU8lHhGWC/rf0N6bN6C9DJ0ubjMi+h8qGkW1jWngapVTexPanwo64Sckbwt4yxpEODMkXrKOf0deN444ZW+AcdKmotpTmpBtUXoBSnQfFejcwZ4RY0bDmygzlQV9sSRl/fDi0c9vV/l3B/QK+2hYNNcV5g1kpt9l4/67aaGhzdoiFq4P/ptm3I5oeeids+vHWhIx23e8pxtRXP2PCwN6mLW8zP41Kk8/2N4tL6cZ/B8DtO0Vn/OQirzK0X7hXYqKr32K4HIAM5rAp5h6reKSfL0s3uPDHQb4H/79M1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBFCPG3cjgIqkTs3g1L85/1tvZs7/8B0bo3o0er368k=;
 b=DbsnHjsLhaiv1/dvMb3NKhIs9OOpOBdP0/aJWFSFUcFu/tZD6i4KF6LoY3Yz6UzCWfBAhTQAepbPikiH2ZVzU6dsNprHMs/v0ooU+x8a1Ajici112nlbHtmtuQ2wWzca4PhRuqQnqkyGjSJROYbfKKzTjX0rdjTmxv5f1kwtglTCyYUhr7a4B8JTHutpzVBx5SaGnhMqoVa2eqNPOSDA0XKUvL7IZI4/MxC12LcJaz2NnLiEkFesuNDA+yhactFKhG+ZXGZ7h3l1v4qCukWdYZBPj2ZJfLcvwuJZ6b8/iKVIT4oDDdFJIcM8wd2qw2+W40V7KHHomLDGdkcWBBTqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBFCPG3cjgIqkTs3g1L85/1tvZs7/8B0bo3o0er368k=;
 b=aVBxa0Dek6gxmbAJiajMb2+TdbwZeotE/JlIoNSlNN+PmgAtfvHdBipaTdAfk29GHCL6wc9xlMuX0dB7eiImogcYiZUKcwNS1CztbBDua5pmmv21x7elY7SOSOsyKRxPrzOX4LtikyhxpJT7R6XyOAuCa/lZMnXNX6osC2OImks=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 13:37:18 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400%5]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 13:37:18 +0000
Subject: Re: [PATCH] Revert "drm/scheduler: Avoid accessing freed bad job."
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, christian.koenig@amd.com
References: <20210817042815.1269454-1-Jingwen.Chen2@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <e5db89e8-22b9-2539-7a53-4a10b751ed88@amd.com>
Date: Tue, 17 Aug 2021 09:37:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210817042815.1269454-1-Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:230a:1a4d:daaa:2e8]
 (2607:fea8:3edf:49b0:230a:1a4d:daaa:2e8) by
 YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 13:37:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9be9a781-a894-42d8-f906-08d961842211
X-MS-TrafficTypeDiagnostic: SA0PR12MB4381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB438156C58815D0D70C93BD22EAFE9@SA0PR12MB4381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IVD+D+CtIiLFJHTOJ9RbUt+2kP7Jyl/JssNGnk/GA8iu4mz3+iMT/4DjRB2Pt+Am302GLwBWrFQBHMAphZY80gaWnMRgaVbahL9q0MR4ESW78XM0yNcaWIzhiuiH8M9IIzZQphcUIWNsQAFdIVXhpOfj61kvi/IjfC+zEoELAlVDKMxRi/nv9JGx8CKTZtMQniYwrrhAI0Ukht8ExKOhX82QD8dMuXnQUGGjHHHpxMi0Ak/Eh2x/gos4rL2Azf3NIEVwjJvzBM2kXuuIojeuDIwOYb6fxRG5nfJrktm5Opvy/ailLORjeuzHjhhnLU3zqpQhs6Z6B6OqgQI0zhvGF9Eeiuq649lQAWcC0CXA8iY1S+3WCnNOxNuxfD7c5QG//uumIEKv6fZ+lziAxKxqRdnYVjHAr4DpgK/Ml021ciG8iFspjM35mXQvGN5aYdTOcFxY6Atx90jmXVoSxRVWM3xXG3gu+zEUMaYmTJWkNuUPl1l8tnl13HjIb/Zgwop5aeplGqgRb4hrlZvWtkV2udXQlkrD07L+W/1sC85tcRUPa1WSG/F1VIW8OXQSThXExISyD5GY+/qDKmfzg8H2Ihxvb84u/8pmWe1ZKEKbmj1FNoKza4WNSu+C05I1tbbGHsFQpdDoUJHG9c1hnjwf8ck8ylBlVEowvwdCEDFCeYDjoGQB+I8TnC+le4BzQYzXrJa4Uw+zEBfr6KJ+Xn9ZMCvYzjeTK08wOcHu9VbQFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(316002)(4326008)(31696002)(66476007)(66556008)(6486002)(5660300002)(44832011)(53546011)(2906002)(2616005)(6666004)(38100700002)(66946007)(36756003)(8936002)(478600001)(8676002)(186003)(31686004)(83380400001)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDlicDQ4U1NzdS94eXYxTDQ1ZXZSNW5lbmdJelhrbWdrbnFId0dBUlBCWWpu?=
 =?utf-8?B?YUdyTDgzRkFIZFNJUDZ4VExRYnFRS3d5ZTVwVTUrTklCR2x3aU1BVUl6eVdm?=
 =?utf-8?B?SkFCb0IzMEN2UkZndVdFZjcxNjBWdXpUYS9xd3pEc2RBVXhkTVpoOEdvaHMr?=
 =?utf-8?B?Sk5ocHNFSVV0YzFJRWZBalpDZWZTTlBYQTdpRnZzY2gyZ3c3di9ZaUJ5ZFJw?=
 =?utf-8?B?N0xFM2hSdjhJdEVjbFZBbVdUWXU5Qkd6NDdVRVRHZnpzWW9lL2RsNURaNzhE?=
 =?utf-8?B?WHVmb1hNa0w1aUtkVzY2OG50cDBlTmhQWitDb2JYMmxDMUNFc1RoWWNIVXlE?=
 =?utf-8?B?WlBPSHJwbnhIQ0o1YVU4QU5DRHZObTJjT3NPWWw4bktsNmNQb3FzU2piUHpo?=
 =?utf-8?B?eHphcHd0c0FwSjdrc2tFaXF0c1Q0NW5BYlM0eHgyc0pjQ3VQMWU2OEJIdXRk?=
 =?utf-8?B?TEthcnlFM215R2x5QlJEaExRcUU4MDhCUmFMQWZlNW1YeWpBQ3NQalF4RUx1?=
 =?utf-8?B?UkdqeU5SK256eVplT2F6MERwT3JqYnBzalRrYXArVm1jaGdzc1lqTEhGRHlM?=
 =?utf-8?B?aFF0NXhaejFLRHRqSGFjSkhtd2k0ZElCQkVDWmV5SGZGWnZOblFUeGNZSlFW?=
 =?utf-8?B?Y1FNMldLUGlyR2wyeDBwK05FOUpkNWtoNlAyd3Q4UzQzVDJ4QUx1VFhUc3hp?=
 =?utf-8?B?eFprVmlQYkhBU2dXMEFtbDJVOUxidzYrN3Z3VHhZV0ZaTDZXSWcvbVRzQ2x0?=
 =?utf-8?B?ZThMSFI2NWJ4ZURqdFMzQWFrOGRlbVI0N0xwMVFmYVRFQkt5czVqL2JlQllG?=
 =?utf-8?B?SFZmMjQrd3ljSEd0TmtBM3RCcU0ya2RaSGU2MHVkZklXUVhEeWdBR3dsU3hG?=
 =?utf-8?B?VzJ6SzlMdkxpNUFCVUZJM1Y5a0xYaS9sOWxCNlFzN2VpQVVXSkhNd3dEWnVr?=
 =?utf-8?B?a1Yvem1ncGlaaDZpVjNnZGYycTVYV294SElvRy9rSmtwaTFIa3EwVTJVb1Vq?=
 =?utf-8?B?bzAxb1VCZU9PMHpPc01TNlMrTkVWL0JmOUx1RHFqaDRYZGZtMTJBbEVvTHgv?=
 =?utf-8?B?Q2xGZ0QzWW0weVhQYUZWcm9ML29acVJTMldSRm5tSDVEdDQ5bFltRld3aDdj?=
 =?utf-8?B?WDU2cDRTbno5SHdIWCtLYWxNSHN0czJJNUhWdVQ0Z0pGVVdXdnpIKys1T3dk?=
 =?utf-8?B?eU41dVJFYlVTWnJiRVhaMkZneVh0ckplMGtnT080ZGlBSzRjKytBTGtwVkVn?=
 =?utf-8?B?VzFuQlQ0TmxjYWVUQnprWk9aUW82Tkt6SXYwV1UvTGNPNi95N2tzV09oZTNU?=
 =?utf-8?B?SFZON2FLSjVOOTNoaDhObURwT2Rra0phbEtBbldUMUJBaENJemtxMmhKSkRs?=
 =?utf-8?B?ZnVrcnNQeTFpSS81dklCaVdrTkJzZTlod3E5cjFEbHNRcEk5RWFpd0N2Q3Nx?=
 =?utf-8?B?b20wZzlhMVY3S2FIWlFKVm1XK0RIaE9ldFBoZER6MzBmTUpZTkRQKzBZLzZK?=
 =?utf-8?B?TW5zSHdXZkFHVVdWaktYYkVSOXF0TTN3V0p6TU1jejhkeE93Ky9BT2toZDNs?=
 =?utf-8?B?SHNjcXJqYnZ1YndRa0VtMGc3aysyUjZ6cC9aZjZBTzJ2a1dNazMzOHUrSlZY?=
 =?utf-8?B?dXU3R3MxbzgrQ3FUUjhpNmRwZnFvamQrN0l2UjVtRTFqeW1sOVRuUUVCVTJ1?=
 =?utf-8?B?c29vcUFzSXVPNjBubGhkKy9iT0k5RmtzMEI1VHN5Nm5pVHhzeDlrcnlsK250?=
 =?utf-8?B?dCtKeHVsTjdYZDhxRm5nTkl0bXRpanJibElIbWxxVElJYUwzM3VQS0kyMG1l?=
 =?utf-8?B?aVp6V01ubkVGdmQzR1ZXZmhkaGVpL3BXTmR3d0JZbjRrNjMrRnUxTlV4S1Mx?=
 =?utf-8?Q?xIOMGS/bxU0Zt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be9a781-a894-42d8-f906-08d961842211
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 13:37:18.7045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBH9UcJDbtm/dmpsvHcXnbXtxpENHUptng8GqnyDGYh7mshgqInFglZ3xQNPxV5eGgp/rgBRhkNQn4itPCiRXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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

On 2021-08-17 12:28 a.m., Jingwen Chen wrote:
> [Why]
> for bailing job, this commit will delete it from pending list thus the
> bailing job will never have a chance to be resubmitted even in advance
> tdr mode.
>
> [How]
> after embeded hw_fence into amdgpu_job is done, the race condition that
> this commit tries to work around is completely solved.So revert this
> commit.
> This reverts commit 135517d3565b48f4def3b1b82008bc17eb5d1c90.


Can you elaborate please how this solves the race ?
As far as I see and  with this patch reverted, in drm_sched_job_timedout
you get a pointer to next job to process in timed out handler, immediately
next this job is actually finished and it's fence signaled, this in turn 
triggers
drm_sched_get_cleanup_job which fetches this job and returns to 
drm_sched_main
which in turn call free_job callabck->...->amdgpu_fence_free which frees 
the job
from the HW dma_fence release callback. After that you proceed with a 
freed job
in timed out handler.

If you could take the HW fence reference from drm_sched_job_timedout before
starting processing then yes, I think it would work.

Andrey


>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 27 --------------------------
>   1 file changed, 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index a2a953693b45..31d1176d939f 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -317,21 +317,10 @@ static void drm_sched_job_timedout(struct work_struct *work)
>   	enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_NOMINAL;
>   
>   	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
> -
> -	/* Protects against concurrent deletion in drm_sched_get_cleanup_job */
> -	spin_lock(&sched->job_list_lock);
>   	job = list_first_entry_or_null(&sched->pending_list,
>   				       struct drm_sched_job, list);
>   
>   	if (job) {
> -		/*
> -		 * Remove the bad job so it cannot be freed by concurrent
> -		 * drm_sched_cleanup_jobs. It will be reinserted back after sched->thread
> -		 * is parked at which point it's safe.
> -		 */
> -		list_del_init(&job->list);
> -		spin_unlock(&sched->job_list_lock);
> -
>   		status = job->sched->ops->timedout_job(job);
>   
>   		/*
> @@ -342,8 +331,6 @@ static void drm_sched_job_timedout(struct work_struct *work)
>   			job->sched->ops->free_job(job);
>   			sched->free_guilty = false;
>   		}
> -	} else {
> -		spin_unlock(&sched->job_list_lock);
>   	}
>   
>   	if (status != DRM_GPU_SCHED_STAT_ENODEV) {
> @@ -392,20 +379,6 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
>   
>   	kthread_park(sched->thread);
>   
> -	/*
> -	 * Reinsert back the bad job here - now it's safe as
> -	 * drm_sched_get_cleanup_job cannot race against us and release the
> -	 * bad job at this point - we parked (waited for) any in progress
> -	 * (earlier) cleanups and drm_sched_get_cleanup_job will not be called
> -	 * now until the scheduler thread is unparked.
> -	 */
> -	if (bad && bad->sched == sched)
> -		/*
> -		 * Add at the head of the queue to reflect it was the earliest
> -		 * job extracted.
> -		 */
> -		list_add(&bad->list, &sched->pending_list);
> -
>   	/*
>   	 * Iterate the job list from later to  earlier one and either deactive
>   	 * their HW callbacks or remove them from pending list if they already
