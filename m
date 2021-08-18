Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E33C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 10:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB55460EB5
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 10:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB55460EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 419FD89182;
	Wed, 18 Aug 2021 10:39:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DF489182
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 10:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV4AWa16hQCnoUTLRFYCPfDAXDcNBmJU5YJMEp7qjmzxdFSZW/LLsNyArFtmLtkfAD7XIXjM/ygDR/jrgaTHjXX9BOD+Unk3YH1C8mDf/psko9RzVVBVNa1RLQlKRFaPbDOxTqgpYEfKWOHiU/lsODyA+SualFFBTTVPwFchAjFeHqTdNFj24OPEbFjuV92C+xpS2Zy+bnXsMqGEl2ubTwrCmqSlZBDjtaMxug0u0fVoPm/wIfp0N6Zh0qNH7aBY1zrh48a5QorzBoJT9Hg4A6yH7crIjOYrC//fYEPAQkqN60r7q4Zvn1dTGY9Ymtm6Mmu572q6cI2wguI0X9Wbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/aTvolJdd10OrvrVl+cqLw0g6lcxQhOmYB6xIkltrE=;
 b=UhoaDOL/Qy8PZMk13Cid1Jtd/jaKwq2+u7e1/zGp2MJv+m4HQBQuGyvf9f1rJyAft20QVdFrZnHl59nLo5YbtazkxYWq8uMafKgPjvpOM4dOgU6CbGRrBGypCJFxWlsQcjNvqhyUb3q8TAMs4IIIGwaLKujyCJNvsamZHE/nftn4GDUDwAt9arORdAY2Xh71XfepFIMBVdyft7J1xItHEQn5dqpb3GK0mbGbI/U/sgabt+NmgOY/JY/Mo4J1TzYW5ZBWRv8b0Ci519tKh4yLJKVsgnp0gUDq1njRTl5lWbgVRKvGvmKAVrh43zTnCTnRV3QuRtv1IKv50nfMFnUUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/aTvolJdd10OrvrVl+cqLw0g6lcxQhOmYB6xIkltrE=;
 b=hKiHlZCg99gbZnvyn9xqet18EGNdwI9QmcHYEq6BeWTdUgpMquHRQzXsn/CuF0z34vgr15J9FSRsNCr/gpdD+DXnrmLo/BROX28zhqYgLgn+7Cy1vQEuBEr43OxatC+OGZDplONLrh1UQJ1eXAJQTyAJV/aqaOPFGCmndx9DWOk=
Received: from CO2PR05CA0076.namprd05.prod.outlook.com (2603:10b6:102:2::44)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Wed, 18 Aug
 2021 10:39:38 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::61) by CO2PR05CA0076.outlook.office365.com
 (2603:10b6:102:2::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend
 Transport; Wed, 18 Aug 2021 10:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Wed, 18 Aug 2021 10:39:37 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 18 Aug
 2021 05:39:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 18 Aug
 2021 03:39:36 -0700
Received: from wayne-dev (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 18 Aug 2021 05:39:34 -0500
Date: Wed, 18 Aug 2021 18:39:34 +0800
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "Andrey
 Grodzovsky" <andrey.grodzovsky@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>
Subject: Re: [PATCH] Revert "drm/scheduler: Avoid accessing freed bad job."
Message-ID: <20210818103934.bokw4u5tkmkbwu25@wayne-dev>
References: <20210817042815.1269454-1-Jingwen.Chen2@amd.com>
 <e5db89e8-22b9-2539-7a53-4a10b751ed88@amd.com>
 <2126dab8-3484-7fd6-b99e-b94e830fd50b@amd.com>
 <20210818080837.gnadncffueb6appu@wayne-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210818080837.gnadncffueb6appu@wayne-dev>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fb6208b-f5b0-4f8b-f332-08d962347a14
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2892F1F2CE4E826E6CA5E60EB7FF9@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pv++gOIKRLsOAJeXV4VWWgrreq2kNE2OQ5WQeCUAJSJiH69MoNR/MiFSBBGVdSgfW6eKDMAuVLobjv2XF4ah7szUIuJPgihKgNb1+saCn4fcUQzp72grb1ABXdfyDXc1edRDdNLNsU70m2LhMhvFBTRiqL2fHtF0Gqjlvq1xnQAUFp02PeoiuxTRVqRhWIfGMPOm+cwWQMk1ryy+lDDZ1d+fjY/T6ee0hFmk0Z1IK2IJ69ObslqociEUXZJFBW6dSWY5fpLaFhaZyMCOGvH8f3U0Bzzcke3zZzSgwPoCWJW9TVaVR0hP6f86I0as8m0p0BIHSkbhlfMUUESwKLWSqxh/3Mu8wPAIXNyKAB07s8vdOTD1OMU3vR3Z8iKLcp2zhjja3JE+uLq3Rk14f0HLPqp7gDre5EBrU21PB0OFwhqOXcg/gwLhR5vpEVOxuG0RcEEQRJEHjDJACnoS0EOcBDKt/4pU7w+X4BaKhPtjxqn3xag8xiOksuEcbOtaY7m3/PyksHjqUJeV9W9jI7TaCPDugYtF/JvgyK/EwetTzIUDByqwm3698qTXMOQtgJSb/7QwWfwdaF+Ioj4afF+p8IqrdAqMO60zxuWPiTqErYTn2gRpUEfnDMEGqHb2s348dT7YtibGe8necBCaUumzkoxTpvfaJpQAwRpGvKCv+qsPlU3Qu/k2AaAJXZM0gyKzIqzXbF22jst2IuFxcUFREtfG/aK6Olcdn0aRQODFzPIRJkSXrwyJ6DdIRnkNt+A3ZWq57ihmhP9BKuxK8FG/ywpDzhGvO5iEdRuA5AdHMgE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(4326008)(9686003)(83380400001)(47076005)(5660300002)(34020700004)(1076003)(86362001)(8676002)(508600001)(8936002)(82310400003)(2906002)(356005)(110136005)(66574015)(316002)(426003)(186003)(81166007)(336012)(55016002)(26005)(70206006)(70586007)(53546011)(33716001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 10:39:37.4001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb6208b-f5b0-4f8b-f332-08d962347a14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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

Sorry, just get what you mean, will submit a v2 patch.

On Wed Aug 18, 2021 at 04:08:37PM +0800, Jingwen Chen wrote:
> On Tue Aug 17, 2021 at 03:43:58PM +0200, Christian König wrote:
> > 
> > 
> > Am 17.08.21 um 15:37 schrieb Andrey Grodzovsky:
> > > On 2021-08-17 12:28 a.m., Jingwen Chen wrote:
> > > > [Why]
> > > > for bailing job, this commit will delete it from pending list thus the
> > > > bailing job will never have a chance to be resubmitted even in advance
> > > > tdr mode.
> > > > 
> > > > [How]
> > > > after embeded hw_fence into amdgpu_job is done, the race condition that
> > > > this commit tries to work around is completely solved.So revert this
> > > > commit.
> > > > This reverts commit 135517d3565b48f4def3b1b82008bc17eb5d1c90.
> > > 
> > > 
> > > Can you elaborate please how this solves the race ?
> > > As far as I see and  with this patch reverted, in drm_sched_job_timedout
> > > you get a pointer to next job to process in timed out handler,
> > > immediately
> > > next this job is actually finished and it's fence signaled, this in turn
> > > triggers
> > > drm_sched_get_cleanup_job which fetches this job and returns to
> Hi Andrey,
> 
> if drm_sched_job_timedout is triggered first, drm_sched_get_cleanup_job will return
> NULL when the timeout worker is running according to this code:
> 	if ((sched->timeout != MAX_SCHEDULE_TIMEOUT &&
> 	    !cancel_delayed_work(&sched->work_tdr)) ||
> 	    kthread_should_park())
> 		return NULL;
> 
> But yes a dma_fence_get(job->s_fence->parent) is needed before
> processing timedout_job. When the bad job is signaled just before
> processing, the amdgpu_fence_free can be triggered by the dma_fence_put() of HW fence.
> And if I'm understanding this race condition correctly, the spin_lock is
> still needed here to avoid the drm_sched_get_cleanup_job get the
> spin_lock first and then enter the tdr work.
> > > drm_sched_main
> > > which in turn call free_job callabck->...->amdgpu_fence_free which frees
> > > the job
> > > from the HW dma_fence release callback. After that you proceed with a
> > > freed job
> > > in timed out handler.
> > > 
> > > If you could take the HW fence reference from drm_sched_job_timedout
> > > before
> > > starting processing then yes, I think it would work.
> > 
> > Yes, precisely that's what I had in mind as well and seems to be missing
> > from this patch.
> > 
> > Regards,
> > Christian.
> > 
> > > 
> > > Andrey
> > > 
> > > 
> > > > 
> > > > Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> > > > ---
> > > >   drivers/gpu/drm/scheduler/sched_main.c | 27 --------------------------
> > > >   1 file changed, 27 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > > index a2a953693b45..31d1176d939f 100644
> > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > @@ -317,21 +317,10 @@ static void drm_sched_job_timedout(struct
> > > > work_struct *work)
> > > >       enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_NOMINAL;
> > > >         sched = container_of(work, struct drm_gpu_scheduler,
> > > > work_tdr.work);
> > > > -
> > > > -    /* Protects against concurrent deletion in
> > > > drm_sched_get_cleanup_job */
> > > > -    spin_lock(&sched->job_list_lock);
> > > >       job = list_first_entry_or_null(&sched->pending_list,
> > > >                          struct drm_sched_job, list);
> > > >         if (job) {
> > > > -        /*
> > > > -         * Remove the bad job so it cannot be freed by concurrent
> > > > -         * drm_sched_cleanup_jobs. It will be reinserted back after
> > > > sched->thread
> > > > -         * is parked at which point it's safe.
> > > > -         */
> > > > -        list_del_init(&job->list);
> > > > -        spin_unlock(&sched->job_list_lock);
> > > > -
> > > >           status = job->sched->ops->timedout_job(job);
> > > >             /*
> > > > @@ -342,8 +331,6 @@ static void drm_sched_job_timedout(struct
> > > > work_struct *work)
> > > >               job->sched->ops->free_job(job);
> > > >               sched->free_guilty = false;
> > > >           }
> > > > -    } else {
> > > > -        spin_unlock(&sched->job_list_lock);
> > > >       }
> > > >         if (status != DRM_GPU_SCHED_STAT_ENODEV) {
> > > > @@ -392,20 +379,6 @@ void drm_sched_stop(struct drm_gpu_scheduler
> > > > *sched, struct drm_sched_job *bad)
> > > >         kthread_park(sched->thread);
> > > >   -    /*
> > > > -     * Reinsert back the bad job here - now it's safe as
> > > > -     * drm_sched_get_cleanup_job cannot race against us and release the
> > > > -     * bad job at this point - we parked (waited for) any in progress
> > > > -     * (earlier) cleanups and drm_sched_get_cleanup_job will not be
> > > > called
> > > > -     * now until the scheduler thread is unparked.
> > > > -     */
> > > > -    if (bad && bad->sched == sched)
> > > > -        /*
> > > > -         * Add at the head of the queue to reflect it was the earliest
> > > > -         * job extracted.
> > > > -         */
> > > > -        list_add(&bad->list, &sched->pending_list);
> > > > -
> > > >       /*
> > > >        * Iterate the job list from later to  earlier one and either
> > > > deactive
> > > >        * their HW callbacks or remove them from pending list if they
> > > > already
> > 
