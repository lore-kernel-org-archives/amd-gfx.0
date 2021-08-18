Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042FBC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 08:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EEC60EB5
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 08:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1EEC60EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E0176E4A2;
	Wed, 18 Aug 2021 08:08:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33826E49B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 08:08:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VABjZDrYSMjWiwwk/o/9RGs41rBd87ypu3F/I4IwZD4mlGW1DRujwcGjQ0byxIvAMbW+T7eteV8jSmnJ+T8VcFRVI8gXK3oIeoNUrC2vMQBpmzqDJmLc21xUSph6zYrOJ8UbqI464UQrFQ2p3nY5bMoSFPzioNO8bB/fqePLxmx4RNf+nWosWsw3n4kvke7RNp76KHDHu8jTPxrKEWKseCc494YtIMvZzXEAa2IuuS1kdKX0jgFvwRyiQ6Jsqb0oY8KJNq2dTobHzMG+RLvF6Ng0olqpS3e+SHIlzMWqEInPxlGeXvzKwa29IgNGSlL2jpOswSANEpQyHt4zqtbrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JkKOXaiOOSai07ncWoFt24xS36EfgoFdJwJeAHT3oA=;
 b=QbI1Y6tkgIx3mnuq0Nt++o4juPp0+ndLNgVWLxDNy+j7OE36BwKhXbJrvV7ksCqgOfJH9gtilDQkOyPgJPdC0nUZB+++2f2CEVWDlFZInvCq8v50Bc5M595a2fRJJeY/A3cP1PbGx+IuorCY39SgD5sVlfEq5g28KR4iCcyTVG1IjOHMvEpQUYS7vXpWGqgchBJS5yEHNoboevUwO6TuDVvxH62X/2zHb1ixXnXb0acIlCVeGBBK/5fGwBNFhbS4t56kmDxJT/lwwjZdzHYp8vbFlkygFkTxGtWPlQZdmojBcdbv4ApwwmYCPst2pM+9z25elxzzlJ12DSAy00jUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JkKOXaiOOSai07ncWoFt24xS36EfgoFdJwJeAHT3oA=;
 b=ey+DpSSHOUGyyAMSD8IjcbbgW7mlBZyMXma1B0fusUesq2WQth2pwfext/AigLvVhFMMpgK4IypAEP08ybQBy7+Xv0zNmFbgVI1+Y6aXy+yCfbgDrqUrF2pABolh+Yl1JKvqfy6l2sDqw1KFKXsJa2VZnVQb8PVo6t0Go2Sojm8=
Received: from BN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:408:ee::7)
 by BY5PR12MB3746.namprd12.prod.outlook.com (2603:10b6:a03:1a7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 08:08:41 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::d0) by BN0PR04CA0002.outlook.office365.com
 (2603:10b6:408:ee::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 18 Aug 2021 08:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Wed, 18 Aug 2021 08:08:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 18 Aug
 2021 03:08:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 18 Aug
 2021 03:08:39 -0500
Received: from wayne-dev (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 18 Aug 2021 03:08:38 -0500
Date: Wed, 18 Aug 2021 16:08:37 +0800
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "Andrey
 Grodzovsky" <andrey.grodzovsky@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>
Subject: Re: [PATCH] Revert "drm/scheduler: Avoid accessing freed bad job."
Message-ID: <20210818080837.gnadncffueb6appu@wayne-dev>
References: <20210817042815.1269454-1-Jingwen.Chen2@amd.com>
 <e5db89e8-22b9-2539-7a53-4a10b751ed88@amd.com>
 <2126dab8-3484-7fd6-b99e-b94e830fd50b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2126dab8-3484-7fd6-b99e-b94e830fd50b@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30fd1e36-730b-4c63-ca78-08d9621f63e0
X-MS-TrafficTypeDiagnostic: BY5PR12MB3746:
X-Microsoft-Antispam-PRVS: <BY5PR12MB374619BF334354518B020C98B7FF9@BY5PR12MB3746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvdnUA7CZglfVDEIE91X+Q66mzXXB3RZb8hOeouPm+9HwAtfvzbm03BB4EQS72qILOK1h61AVJqamHPyR2LqVRKPeHcmK9KPAmFdlP5/pf+RTha9XWPQc4FuOCvbfWUdXIDuxuotLkyyDgHXEihslyC9DljvnmtPhsoCyUvEnNtnUn5+cuJGGL3TTLf+lsD6EPyotOhBJES6R/KV+C1yaSrv8r3y1s9P7rAaWwAhw+xSEOYGiEK8UP0voRc+HXKfS5/ymZpxjJKtwl2PDnnfTamQnUstvjjpdLfUvRQNX4jnk4YDibzOSzM7mIog4G1+upS8OCH7mVrw1tbYndUieO89JACXpXozgU2IAOX7szTOp2Dk+4+Net/oA8T6IfZHh3PLZvHC0n76mAlKcHVDdXhy7gaKmpJVF4JUIudmhN1HAN+ruZs7Belwr5OUopjZ74UD+KJw0O2KXZTjRne0/SoPFPgdswJlSfWf23nYlRl/vlhMnydyNMT4qXQEJHgK2hAa6JdqeOg28SmjzXCDQgFR11HXuiJ+RpzXL2lwAvHyJzcN0jPHO3u7GBKnhcA4Ed7ERcH3bM7sFPZE3iH3WgyqjWABfDqkokjxHnthG9aAvOFjGi+HkkfUN3j/mpPq541bzHfOp1G0Cl9jfZWq9so6w3IjlKL1+1Jw+Q7nv37R7/OthKSOCv8/KzU5JepNmBdCtk8zLLgWq2Vd8rVV1/8JUwl9XObbbLxxUxGKbvOkaXWspgtk8I0pvO8ug8irzdPCNDQ+v8K/ttCVEgvPwLt7jSjcrYQT0IP99NpTjps=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(36840700001)(82740400003)(9686003)(36860700001)(5660300002)(186003)(47076005)(478600001)(81166007)(316002)(110136005)(1076003)(26005)(86362001)(356005)(53546011)(83380400001)(70206006)(70586007)(82310400003)(2906002)(336012)(426003)(34020700004)(66574015)(55016002)(8676002)(33716001)(4326008)(8936002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 08:08:40.8390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fd1e36-730b-4c63-ca78-08d9621f63e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3746
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

On Tue Aug 17, 2021 at 03:43:58PM +0200, Christian König wrote:
> 
> 
> Am 17.08.21 um 15:37 schrieb Andrey Grodzovsky:
> > On 2021-08-17 12:28 a.m., Jingwen Chen wrote:
> > > [Why]
> > > for bailing job, this commit will delete it from pending list thus the
> > > bailing job will never have a chance to be resubmitted even in advance
> > > tdr mode.
> > > 
> > > [How]
> > > after embeded hw_fence into amdgpu_job is done, the race condition that
> > > this commit tries to work around is completely solved.So revert this
> > > commit.
> > > This reverts commit 135517d3565b48f4def3b1b82008bc17eb5d1c90.
> > 
> > 
> > Can you elaborate please how this solves the race ?
> > As far as I see and  with this patch reverted, in drm_sched_job_timedout
> > you get a pointer to next job to process in timed out handler,
> > immediately
> > next this job is actually finished and it's fence signaled, this in turn
> > triggers
> > drm_sched_get_cleanup_job which fetches this job and returns to
Hi Andrey,

if drm_sched_job_timedout is triggered first, drm_sched_get_cleanup_job will return
NULL when the timeout worker is running according to this code:
	if ((sched->timeout != MAX_SCHEDULE_TIMEOUT &&
	    !cancel_delayed_work(&sched->work_tdr)) ||
	    kthread_should_park())
		return NULL;

But yes a dma_fence_get(job->s_fence->parent) is needed before
processing timedout_job. When the bad job is signaled just before
processing, the amdgpu_fence_free can be triggered by the dma_fence_put() of HW fence.
And if I'm understanding this race condition correctly, the spin_lock is
still needed here to avoid the drm_sched_get_cleanup_job get the
spin_lock first and then enter the tdr work.
> > drm_sched_main
> > which in turn call free_job callabck->...->amdgpu_fence_free which frees
> > the job
> > from the HW dma_fence release callback. After that you proceed with a
> > freed job
> > in timed out handler.
> > 
> > If you could take the HW fence reference from drm_sched_job_timedout
> > before
> > starting processing then yes, I think it would work.
> 
> Yes, precisely that's what I had in mind as well and seems to be missing
> from this patch.
> 
> Regards,
> Christian.
> 
> > 
> > Andrey
> > 
> > 
> > > 
> > > Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> > > ---
> > >   drivers/gpu/drm/scheduler/sched_main.c | 27 --------------------------
> > >   1 file changed, 27 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > index a2a953693b45..31d1176d939f 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > @@ -317,21 +317,10 @@ static void drm_sched_job_timedout(struct
> > > work_struct *work)
> > >       enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_NOMINAL;
> > >         sched = container_of(work, struct drm_gpu_scheduler,
> > > work_tdr.work);
> > > -
> > > -    /* Protects against concurrent deletion in
> > > drm_sched_get_cleanup_job */
> > > -    spin_lock(&sched->job_list_lock);
> > >       job = list_first_entry_or_null(&sched->pending_list,
> > >                          struct drm_sched_job, list);
> > >         if (job) {
> > > -        /*
> > > -         * Remove the bad job so it cannot be freed by concurrent
> > > -         * drm_sched_cleanup_jobs. It will be reinserted back after
> > > sched->thread
> > > -         * is parked at which point it's safe.
> > > -         */
> > > -        list_del_init(&job->list);
> > > -        spin_unlock(&sched->job_list_lock);
> > > -
> > >           status = job->sched->ops->timedout_job(job);
> > >             /*
> > > @@ -342,8 +331,6 @@ static void drm_sched_job_timedout(struct
> > > work_struct *work)
> > >               job->sched->ops->free_job(job);
> > >               sched->free_guilty = false;
> > >           }
> > > -    } else {
> > > -        spin_unlock(&sched->job_list_lock);
> > >       }
> > >         if (status != DRM_GPU_SCHED_STAT_ENODEV) {
> > > @@ -392,20 +379,6 @@ void drm_sched_stop(struct drm_gpu_scheduler
> > > *sched, struct drm_sched_job *bad)
> > >         kthread_park(sched->thread);
> > >   -    /*
> > > -     * Reinsert back the bad job here - now it's safe as
> > > -     * drm_sched_get_cleanup_job cannot race against us and release the
> > > -     * bad job at this point - we parked (waited for) any in progress
> > > -     * (earlier) cleanups and drm_sched_get_cleanup_job will not be
> > > called
> > > -     * now until the scheduler thread is unparked.
> > > -     */
> > > -    if (bad && bad->sched == sched)
> > > -        /*
> > > -         * Add at the head of the queue to reflect it was the earliest
> > > -         * job extracted.
> > > -         */
> > > -        list_add(&bad->list, &sched->pending_list);
> > > -
> > >       /*
> > >        * Iterate the job list from later to  earlier one and either
> > > deactive
> > >        * their HW callbacks or remove them from pending list if they
> > > already
> 
