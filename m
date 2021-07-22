Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F4CC63793
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 16:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA45761D25
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 16:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA45761D25
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 921F36E804;
	Thu, 22 Jul 2021 16:47:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 519796E804
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 16:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrXDXFWYwlFeEqOnu9/t3NZwOZZKbSd8ms7kxqX/YdodlIYYeeEHPm2E87r+cXMnpMnPt4XQlUb8mtt9abHu/zOEYIrSReO/lV7aGZ1jzR2U/UqdDA9nYYgBBACjFQaNhXf5Dmoy+5Zql4GxIMrWUymox5SghzD/a18PCUPCYF4XnOPprrrVTlvvXXL8VzAp8wnA/YX+eUTHNWZjV5bq5RpxmDm+4wYA0A0P27M6LXeTUnJIN8achXNGFwJTVmTQ6A3nvJBa5D6YgHVkreWL2Bqzt4cVJ3EPZH6sr+ZjRvyOsHOu7OwwuKDzn3cR2WLxskeyvvL4O43Ucumwjany5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3Nd40pd17Lhs+rUl9eNExCkwg+4qct/wJTKMg2VWfA=;
 b=bFORxQtXuteDeioOE2Jd/L1lrbY6djGVShMYaV1k+SbG3mixY6pZ9su2nvfn8vCAkJ/GZnrp/o+NgCJaTRrJpHYBvVKCjONA/uCFJswf4pLGEXtIR3hNwZTk3ZhX0T59MGqYVsSgwV0IAVt22rpSVzA252hY/NNcZehkUoRKPXhdmMWHl9AcANfJQ3Pzb0ylq3YeHPDcdmXLLdxiTjlpdM6GcViF/s8tIZ9TrF1u1renfqg3QpEk/H6y5fHukQQQbnCfQibhH0JGrwdPKq/APIbVAWsgXoOv3crROpfudCd5xYUgp9jINP/nhe+V0Tjw3ypQqeyA/qmWl//IFF4s5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3Nd40pd17Lhs+rUl9eNExCkwg+4qct/wJTKMg2VWfA=;
 b=BjmOFlS9mumhskPI9zcv1E4Ocgjoutp6Ym6rMN4dqG/84HoqTWHk/qSBucOQjm/X0/mrVZxgUhKSBnAM02UDKrxTPsq8xnN+2R66CuynFuojAFQqRDmDhp+jCFXnZDE6KVL1TuDTfYCrmdguIN3RRAe+hAyKuBkO+ZAyqt1coT4=
Received: from MW4PR03CA0031.namprd03.prod.outlook.com (2603:10b6:303:8e::6)
 by DM5PR12MB1209.namprd12.prod.outlook.com (2603:10b6:3:6f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 22 Jul
 2021 16:47:08 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::ae) by MW4PR03CA0031.outlook.office365.com
 (2603:10b6:303:8e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Thu, 22 Jul 2021 16:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 16:47:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 11:47:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 11:47:07 -0500
Received: from wayne-build (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Jul 2021 11:47:05 -0500
Date: Fri, 23 Jul 2021 00:47:04 +0800
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>, "Andrey
 Grodzovsky" <andrey.grodzovsky@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm: add tdr support for embeded hw_fence
Message-ID: <20210722164704.age63nzbviqg4y7v@wayne-build>
References: <20210721031352.413888-1-Jingwen.Chen2@amd.com>
 <20210721031352.413888-2-Jingwen.Chen2@amd.com>
 <36f53a64-2d9c-947b-a5fb-21d9fc06c5e4@amd.com>
 <20210722104525.okcnb43goxg6uqej@wayne-build>
 <0699ff85-4aec-0e33-711b-665307fbbc24@amd.com>
 <9dacfe83-da10-9806-81e0-70077dedce9f@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9dacfe83-da10-9806-81e0-70077dedce9f@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34cd9e7c-59fb-4dc1-d619-08d94d30584f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1209:
X-Microsoft-Antispam-PRVS: <DM5PR12MB120993494CF06E34B16C9016B7E49@DM5PR12MB1209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcMhtm1Tr+4B/fJ8HOQjDJQQtR0Kd++kDkodwRC/8QqpS0bbdguoWtFDxEZlCfTYbC7USKt7hFmraq5Xv/5+FDYQjcxIum+t1cxrh719Buuj02Rd24WUffwkxqUki7fIGgkwOHlaW8hUmXG6qcDgVU4P36DhRgTMuPvGWzYAjpB0yymt5bZW0x59Zibonlz7YM6XDF92VGWJmjSJN2aD9qHFe2o5c7Z/gsNPmiYz+7vVRFPlfHvI3f/URmQLWoMooppKS9qT+eIeZSoBtc6WCRwWs1QIH47TmBQX8TR5BSdDpi/F51PhPbHvKdd8W3dNr3RQ6rjAmf3Oxbwc5reoeYNnysK/lmhlMYHsVnRQ2IH/kvlRdm2y+a6IYEpqp3EzX7C6PdbACNxM17or4VTEJRcoVhcGxzAbx7J892GBoPXhgTAvk+geUbd1H33947HBFSovpO8+BN4TW1uL1AjQY5iP7vbkUvZZiodwxl7mRJEsr7Keey8qvmy0VreP8IbGfPvb/TNyG8IoDkO233gKCtg1D1w4RmrprBbhDaKpncCLPksv+LPSUnoDDaeQJKsjM7agPlmMatorrAVv+1aqH4ZR0XIcx9l8iOIMYn7Rvm/JRaliBmc4vO0UL1u5eyD9/tULWhMs6O/YnkdA5/VV7SLYJNcBAtqBqHVqI5ak2KVXD01uS4oyU/p+oNos/iDPAIVZwWwqVbpdlge+bTjUHQOX+UIMYgvRX1XvxVONUMvMhEGOk1x+ql1eqHg2qw1b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(4326008)(47076005)(53546011)(186003)(9686003)(82310400003)(8676002)(110136005)(54906003)(8936002)(82740400003)(55016002)(83380400001)(478600001)(336012)(2906002)(426003)(36860700001)(81166007)(70586007)(1076003)(66574015)(5660300002)(33716001)(70206006)(316002)(356005)(86362001)(26005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 16:47:08.3372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cd9e7c-59fb-4dc1-d619-08d94d30584f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1209
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
Cc: horace.chen@amd.com, "jingwen.chen2@amd.com Jack
 Zhang" <Jack.Zhang1@amd.com>, monk.liu@amd.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu Jul 22, 2021 at 06:24:28PM +0200, Christian K=F6nig wrote:
> Am 22.07.21 um 16:45 schrieb Andrey Grodzovsky:
> > =

> > On 2021-07-22 6:45 a.m., Jingwen Chen wrote:
> > > On Wed Jul 21, 2021 at 12:53:51PM -0400, Andrey Grodzovsky wrote:
> > > > On 2021-07-20 11:13 p.m., Jingwen Chen wrote:
> > > > > [Why]
> > > > > After embeded hw_fence to amdgpu_job, we need to add tdr support
> > > > > for this feature.
> > > > > =

> > > > > [How]
> > > > > 1. Add a resubmit_flag for resubmit jobs.
> > > > > 2. Clear job fence from RCU and force complete vm flush fences in
> > > > > =A0=A0=A0=A0 pre_asic_reset
> > > > > 3. skip dma_fence_get for resubmit jobs and add a dma_fence_put
> > > > > =A0=A0=A0=A0 for guilty jobs.
> > > > > =

> > > > > Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> > > > > Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> > > > > ---
> > > > > =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++=
+-
> > > > > =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c=A0 | 16 ++++++++=
+++-----
> > > > > =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c=A0=A0=A0 |=A0 4 ++=
+-
> > > > > =A0=A0 drivers/gpu/drm/scheduler/sched_main.c=A0=A0=A0=A0 |=A0 1 +
> > > > > =A0=A0 include/drm/gpu_scheduler.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 1 +
> > > > > =A0=A0 5 files changed, 27 insertions(+), 7 deletions(-)
> > > > > =

> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > index 40461547701a..fe0237f72a09 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > @@ -4382,7 +4382,7 @@ int amdgpu_device_mode1_reset(struct
> > > > > amdgpu_device *adev)
> > > > > =A0=A0 int amdgpu_device_pre_asic_reset(struct amdgpu_device *ade=
v,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct =
amdgpu_reset_context *reset_context)
> > > > > =A0=A0 {
> > > > > -=A0=A0=A0 int i, r =3D 0;
> > > > > +=A0=A0=A0 int i, j, r =3D 0;
> > > > > =A0=A0=A0=A0=A0=A0 struct amdgpu_job *job =3D NULL;
> > > > > =A0=A0=A0=A0=A0=A0 bool need_full_reset =3D
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_bit(AMDGPU_NEED_FULL_RESET, &=
reset_context->flags);
> > > > > @@ -4406,6 +4406,16 @@ int
> > > > > amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!ring || !ring->sched.thread)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > > > +=A0=A0=A0=A0=A0=A0=A0 /*clear job fence from fence drv to avoid =
force_completion
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0 *leave NULL and vm flush fence in fence=
 drv */
> > > > > +=A0=A0=A0=A0=A0=A0=A0 for (j =3D 0; j <=3D ring->fence_drv.num_f=
ences_mask; j ++) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dma_fence *old,**ptr;
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ptr =3D &ring->fence_drv.fence=
s[j];
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 old =3D rcu_dereference_protec=
ted(*ptr, 1);
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (old && test_bit(DMA_FENCE_=
FLAG_USER_BITS,
> > > > > &old->flags))) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RCU_INIT_POINTER(*=
ptr, NULL);
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > =

> > > > Is this to avoid premature job free because of dma_fence_put inside
> > > > amdgpu_fence_process ?
> > > > I can't currently remember why but we probably want all the HW fenc=
es
> > > > currently in the ring to
> > > > be forced signaled - maybe better to test for DMA_FENCE_FLAG_USER_B=
ITS
> > > > inside amdgpu_fence_process
> > > > and still do the signaling but not the dma_fence_put part
> > > > =

> > > > Andrey
> > > Hi Andrey,
> > > =

> > > This is to avoid signaling the same fence twice. If we still do the
> > > signaling, then the job in the pending list will be signaled first in
> > > force_completion, and later be signaled in resubmit. This will go to
> > > BUG() in amdgpu_fence_process.
> > =

> > =

> > Oh, i see, how about just adding 'skip' flag to amdgpu_ring and setting
> > it before calling
> > amdgpu_fence_driver_force_completion and resetting it after, then inside
> > amdgpu_fence_driver_force_completion
> > you can just skip the signaling part with this flag for fences with
> > DMA_FENCE_FLAG_USER_BITS set
> > Less lines of code at least.
> =

> Still sounds quite a bit hacky.
> =

> I would rather suggest to completely drop the approach with
> amdgpu_fence_driver_force_completion(). I could never see why we would wa=
nt
> that in the first place.
> =

> Regards,
> Christian.
> =

Hi Christian,

I keep the amdgpu_fence_driver_force_completion here to make sure the vm
flush fence is signaled and put. =

So the key question is whether the fence of ib test should be the first
fence to be signaled after reset.
If it should be, it means not only fences with DMA_FENCE_FLAG_USER_BITS
but also vm flush fences should be removed from RCU fence array before
ib_test. Then we must do the force_completion here for vm flush
fence, otherwise there will be a memory leak here as no one will signal
and put it after we remove it from RCU.
If not, then the first fence to signal could be vm flush fence. And I'm
OK with drop amdgpu_fence_driver_force_completion here.


Best Regards,
JingWen Chen
> > =

> > Andrey
> > =

> > =

> > > =

> > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* after all hw jobs are reset, hw=
 fence is
> > > > > meaningless, so force_completion */
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_fence_driver_force_completi=
on(ring);
> > > > > =A0=A0=A0=A0=A0=A0 }
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > index eecf21d8ec33..815776c9a013 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > @@ -156,11 +156,17 @@ int amdgpu_fence_emit(struct
> > > > > amdgpu_ring *ring, struct dma_fence **f, struct amd
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 job->ring =3D ring;
> > > > > =A0=A0=A0=A0=A0=A0 }
> > > > > -=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > -=A0=A0=A0 dma_fence_init(fence, &amdgpu_fence_ops,
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &ring->fence_drv.lock,
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->fence_context +=
 ring->idx,
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seq);
> > > > > +=A0=A0=A0 if (job !=3D NULL && job->base.resubmit_flag =3D=3D 1)=
 {
> > > > > +=A0=A0=A0=A0=A0=A0=A0 /* reinit seq for resubmitted jobs */
> > > > > +=A0=A0=A0=A0=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > +=A0=A0=A0=A0=A0=A0=A0 fence->seqno =3D seq;
> > > > > +=A0=A0=A0 } else {
> > > > > +=A0=A0=A0=A0=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > =

> > > > Seems like you could do the above line only once above if-else
> > > > as it was
> > > > before
> > > Sure, I will modify this.
> > > =

> > > =

> > > Best Regards,
> > > JingWen Chen
> > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_init(fence, &amdgpu_fence_ops,
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &ring->fence_drv.l=
ock,
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->fence_contex=
t + ring->idx,
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seq);
> > > > > +=A0=A0=A0 }
> > > > > =A0=A0=A0=A0=A0=A0 if (job !=3D NULL) {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* mark this fence has a parent jo=
b */
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > index 7c426e225b24..d6f848adc3f4 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > @@ -241,6 +241,7 @@ static struct dma_fence
> > > > > *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_fence_set_error(finished, -ECA=
NCELED);/* skip
> > > > > IB as well if VRAM lost */
> > > > > =A0=A0=A0=A0=A0=A0 if (finished->error < 0) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_put(&job->hw_fence);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_INFO("Skip scheduling IBs!\n");
> > > > > =A0=A0=A0=A0=A0=A0 } else {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r =3D amdgpu_ib_schedule(ring, job=
->num_ibs, job->ibs, job,
> > > > > @@ -249,7 +250,8 @@ static struct dma_fence
> > > > > *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_ERROR("Error sched=
uling IBs (%d)\n", r);
> > > > > =A0=A0=A0=A0=A0=A0 }
> > > > > -=A0=A0=A0 dma_fence_get(fence);
> > > > > +=A0=A0=A0 if (!job->base.resubmit_flag)
> > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_get(fence);
> > > > > =A0=A0=A0=A0=A0=A0 amdgpu_job_free_resources(job);
> > > > > =A0=A0=A0=A0=A0=A0 fence =3D r ? ERR_PTR(r) : fence;
> > > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > index f4f474944169..5a36ab5aea2d 100644
> > > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > @@ -544,6 +544,7 @@ void drm_sched_resubmit_jobs_ext(struct
> > > > > drm_gpu_scheduler *sched, int max)
> > > > > dma_fence_set_error(&s_fence->finished, -ECANCELED);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_fence_put(s_job->s_fence->pare=
nt);
> > > > > +=A0=A0=A0=A0=A0=A0=A0 s_job->resubmit_flag =3D 1;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fence =3D sched->ops->run_job(s_jo=
b);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i++;
> > > > > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_schedu=
ler.h
> > > > > index 4ea8606d91fe..06c101af1f71 100644
> > > > > --- a/include/drm/gpu_scheduler.h
> > > > > +++ b/include/drm/gpu_scheduler.h
> > > > > @@ -198,6 +198,7 @@ struct drm_sched_job {
> > > > > =A0=A0=A0=A0=A0=A0 enum drm_sched_priority=A0=A0=A0=A0=A0=A0=A0 s=
_priority;
> > > > > =A0=A0=A0=A0=A0=A0 struct drm_sched_entity=A0=A0=A0=A0=A0=A0=A0=
=A0 *entity;
> > > > > =A0=A0=A0=A0=A0=A0 struct dma_fence_cb=A0=A0=A0=A0=A0=A0=A0 cb;
> > > > > +=A0=A0=A0 int resubmit_flag;
> > > > > =A0=A0 };
> > > > > =A0=A0 static inline bool drm_sched_invalidate_job(struct
> > > > > drm_sched_job *s_job,
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
