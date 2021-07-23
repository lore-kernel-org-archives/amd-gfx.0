Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646FBC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 07:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC9F60EAF
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 07:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CC9F60EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C7C6E920;
	Fri, 23 Jul 2021 07:07:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34AE6F45D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 07:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQhtFwIkT8dwakBX+lVD+xYJYcdFG2lmn3xmKs14mLb6BdoAwjx+oDoKDBcguKmeRRiHUBXW1mVkvp6ptz1Tp6k0pDYW4hiNoToLjjSHRgE7bG/SZXq+0k1sHE+aLyHjXDs/MTSTS4XtdOglPVzxq1ol8jWgw5civdUBM8XHitxGb36t9rChP6SRH6oFflPN6l4dyZDai2hj831vj4d4GluYMy6Eyqe/WKPH7Uu1ex8aIZrQ8sWKg6yRt1wHLztP+nVLI2aWhqLCqTC9QyD5fYvbEkmcbMHdH+czkL1R2zZ9MnstU5mdZYBxvHNGSBLYtB8ew4n6G0aghY0Mi3IovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znQ+g52el8pkXrC1PMP5FUvGXZ2xJ2e3h1s37OkSdT8=;
 b=Ce6hIN7U4V8qeb0JfBIjm8PqEVJrBDFiu4e8hsKonjCuTZWJKlGlIHBGavZnBbB7Caxg78ZZUQsoqfl6qJRJwW8KTeppBCUVwqwe3OuVZ7fOQPPMDIKuH6EavBBgm9tHBytn1QFzCYp6J0C/qvJYNvTiF/kpR/U778642IUy04HF/3Tikfwfd9klmR1n5Z8adBzyw4eg8Zk+XSmEwi9bsSHK8GDMfFJJBBULPgsO0ovKm5pCzfklNrMqneNFLWuHGamwqoXgQKaF1HsDWQOTyVmwSBvnKYO8/E4r8a6uiUuZrCWB+2ffcZOg70Q/M5gF6JwPOLt32UNE3pOpjmg39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znQ+g52el8pkXrC1PMP5FUvGXZ2xJ2e3h1s37OkSdT8=;
 b=0TK4dlxspHfo9OGHNZsjQliY4G7HUXGjwxy+ZtkxAw+elSVhx+9v7O3gUsyZs3oiB1qAHRCp1A7X1czoC28FYaKpX3bXPrgo21LSttP6ydGNaCR0JLhQG5D+4VRlVEABk/VLgDQXTr64nZb6TgIz/6VLzwQqN8cJACcUUln82l8=
Received: from BN0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:408:e6::7)
 by BN8PR12MB3396.namprd12.prod.outlook.com (2603:10b6:408:45::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Fri, 23 Jul
 2021 07:07:18 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::a) by BN0PR03CA0002.outlook.office365.com
 (2603:10b6:408:e6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Fri, 23 Jul 2021 07:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 07:07:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 02:07:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 00:07:17 -0700
Received: from wayne-build (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 23 Jul 2021 02:07:16 -0500
Date: Fri, 23 Jul 2021 15:07:14 +0800
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>, "Andrey
 Grodzovsky" <andrey.grodzovsky@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm: add tdr support for embeded hw_fence
Message-ID: <20210723070714.6h5pmxjebopv4zge@wayne-build>
References: <20210721031352.413888-1-Jingwen.Chen2@amd.com>
 <20210721031352.413888-2-Jingwen.Chen2@amd.com>
 <36f53a64-2d9c-947b-a5fb-21d9fc06c5e4@amd.com>
 <20210722104525.okcnb43goxg6uqej@wayne-build>
 <0699ff85-4aec-0e33-711b-665307fbbc24@amd.com>
 <9dacfe83-da10-9806-81e0-70077dedce9f@gmail.com>
 <20210722164704.age63nzbviqg4y7v@wayne-build>
 <37b6c44f-2fa7-c507-7b77-13608285b362@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <37b6c44f-2fa7-c507-7b77-13608285b362@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adb8fbbd-5703-4676-2ea3-08d94da881f8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3396:
X-Microsoft-Antispam-PRVS: <BN8PR12MB33969B7CF3AE9F8986C1EA19B7E59@BN8PR12MB3396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9oWXrDBEQfl/GxNymhmxQa78sgOlvjcXeDI7L6oCaX6KPk5HTnKSWHtZ4SNa3zQQs0Qv6jrjblQNf0XQaXJzkIkWenji90KoU5XFkLR5IXaKp0BejCyLEuzeJiUtYAy6rtOAawDHxuyM9KmAPk/Tk2VL+lDjjSz62ToLChuRG1XTTaEFjjy2+AgnQ/V0bjMJLzOtgoUgzUnSi1QptSPZI/AXzb7Ig0b1tLlc3bipW7Ows3Or2iwLoZpJq/bcFQw/Seb1CTC26gPu6lA14gcbZpMg8CpvaD256UKyAFbrLmmrIRhRwudqOgYrhY7+bpaDddtnmO3EW0JsTWDbMY1Fooy1pf2C3oLpey7UGUELZDsrsTIJ4exlRiuMijKmSLLTJI33tC/QpQOGSWWx17mzCPhA/wJM/yFfZQK7UUUKyn69xAEr9LS/gdSUBdYmuKmbd9Mn89YX8W/06JpTtULSjkdvsAwc74q9sYP3X9sstiHGpkj+Xq9QVX1c5vuwa5F5ig1Jr/WXT/csBy0GLDQwvl1q8nlvWLBt0VbgJtgeh4EqBOgwCYSqoNtQ6tDJnE11aW/3sTFIUE3+d8zqqxG8PATDfy38I+xq33X8Kx0ZaRaS7DOJlIHRbHsGS7m6IzcgzscEN886+6wyLfR2ZQ5P9ZS1HNTdtC7yRGmfntGsyc91utdqdai9LCkhli/Ju7XuOlfX3FWXxShFME4/e9+1W6gFdXsOg0U1QzAcitgGbopb9fASG5golOfbQXNckT6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(9686003)(66574015)(356005)(70586007)(70206006)(336012)(5660300002)(8676002)(55016002)(186003)(8936002)(82740400003)(47076005)(110136005)(53546011)(1076003)(82310400003)(33716001)(30864003)(4326008)(54906003)(36860700001)(426003)(26005)(316002)(83380400001)(86362001)(478600001)(81166007)(2906002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 07:07:17.9476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb8fbbd-5703-4676-2ea3-08d94da881f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3396
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

On Fri Jul 23, 2021 at 08:33:02AM +0200, Christian K=F6nig wrote:
> Am 22.07.21 um 18:47 schrieb Jingwen Chen:
> > On Thu Jul 22, 2021 at 06:24:28PM +0200, Christian K=F6nig wrote:
> > > Am 22.07.21 um 16:45 schrieb Andrey Grodzovsky:
> > > > On 2021-07-22 6:45 a.m., Jingwen Chen wrote:
> > > > > On Wed Jul 21, 2021 at 12:53:51PM -0400, Andrey Grodzovsky wrote:
> > > > > > On 2021-07-20 11:13 p.m., Jingwen Chen wrote:
> > > > > > > [Why]
> > > > > > > After embeded hw_fence to amdgpu_job, we need to add tdr supp=
ort
> > > > > > > for this feature.
> > > > > > > =

> > > > > > > [How]
> > > > > > > 1. Add a resubmit_flag for resubmit jobs.
> > > > > > > 2. Clear job fence from RCU and force complete vm flush fence=
s in
> > > > > > >  =A0=A0=A0=A0 pre_asic_reset
> > > > > > > 3. skip dma_fence_get for resubmit jobs and add a dma_fence_p=
ut
> > > > > > >  =A0=A0=A0=A0 for guilty jobs.
> > > > > > > =

> > > > > > > Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> > > > > > > Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> > > > > > > ---
> > > > > > >  =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++=
++++++-
> > > > > > >  =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c=A0 | 16 +++=
++++++++-----
> > > > > > >  =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c=A0=A0=A0 |=A0=
 4 +++-
> > > > > > >  =A0=A0 drivers/gpu/drm/scheduler/sched_main.c=A0=A0=A0=A0 |=
=A0 1 +
> > > > > > >  =A0=A0 include/drm/gpu_scheduler.h=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> > > > > > >  =A0=A0 5 files changed, 27 insertions(+), 7 deletions(-)
> > > > > > > =

> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > > > index 40461547701a..fe0237f72a09 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > > > @@ -4382,7 +4382,7 @@ int amdgpu_device_mode1_reset(struct
> > > > > > > amdgpu_device *adev)
> > > > > > >  =A0=A0 int amdgpu_device_pre_asic_reset(struct amdgpu_device=
 *adev,
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st=
ruct amdgpu_reset_context *reset_context)
> > > > > > >  =A0=A0 {
> > > > > > > -=A0=A0=A0 int i, r =3D 0;
> > > > > > > +=A0=A0=A0 int i, j, r =3D 0;
> > > > > > >  =A0=A0=A0=A0=A0=A0 struct amdgpu_job *job =3D NULL;
> > > > > > >  =A0=A0=A0=A0=A0=A0 bool need_full_reset =3D
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_bit(AMDGPU_NEED_FULL_RES=
ET, &reset_context->flags);
> > > > > > > @@ -4406,6 +4406,16 @@ int
> > > > > > > amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!ring || !ring->sched.thr=
ead)
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 /*clear job fence from fence drv to av=
oid force_completion
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0 *leave NULL and vm flush fence in f=
ence drv */
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 for (j =3D 0; j <=3D ring->fence_drv.n=
um_fences_mask; j ++) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dma_fence *old,**pt=
r;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ptr =3D &ring->fence_drv.f=
ences[j];
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 old =3D rcu_dereference_pr=
otected(*ptr, 1);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (old && test_bit(DMA_FE=
NCE_FLAG_USER_BITS,
> > > > > > > &old->flags))) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RCU_INIT_POINT=
ER(*ptr, NULL);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > Is this to avoid premature job free because of dma_fence_put in=
side
> > > > > > amdgpu_fence_process ?
> > > > > > I can't currently remember why but we probably want all the HW =
fences
> > > > > > currently in the ring to
> > > > > > be forced signaled - maybe better to test for DMA_FENCE_FLAG_US=
ER_BITS
> > > > > > inside amdgpu_fence_process
> > > > > > and still do the signaling but not the dma_fence_put part
> > > > > > =

> > > > > > Andrey
> > > > > Hi Andrey,
> > > > > =

> > > > > This is to avoid signaling the same fence twice. If we still do t=
he
> > > > > signaling, then the job in the pending list will be signaled firs=
t in
> > > > > force_completion, and later be signaled in resubmit. This will go=
 to
> > > > > BUG() in amdgpu_fence_process.
> > > > =

> > > > Oh, i see, how about just adding 'skip' flag to amdgpu_ring and set=
ting
> > > > it before calling
> > > > amdgpu_fence_driver_force_completion and resetting it after, then i=
nside
> > > > amdgpu_fence_driver_force_completion
> > > > you can just skip the signaling part with this flag for fences with
> > > > DMA_FENCE_FLAG_USER_BITS set
> > > > Less lines of code at least.
> > > Still sounds quite a bit hacky.
> > > =

> > > I would rather suggest to completely drop the approach with
> > > amdgpu_fence_driver_force_completion(). I could never see why we woul=
d want
> > > that in the first place.
> > > =

> > > Regards,
> > > Christian.
> > > =

> > Hi Christian,
> > =

> > I keep the amdgpu_fence_driver_force_completion here to make sure the vm
> > flush fence is signaled and put.
> > So the key question is whether the fence of ib test should be the first
> > fence to be signaled after reset.
> > If it should be, it means not only fences with DMA_FENCE_FLAG_USER_BITS
> > but also vm flush fences should be removed from RCU fence array before
> > ib_test. Then we must do the force_completion here for vm flush
> > fence, otherwise there will be a memory leak here as no one will signal
> > and put it after we remove it from RCU.
> > If not, then the first fence to signal could be vm flush fence. And I'm
> > OK with drop amdgpu_fence_driver_force_completion here.
> =

> The key problem is that amdgpu_fence_driver_force_completion() goes over =
the
> RCU array and signals everything there.
> =

> What we should do instead is to go over the jobs and cleanup the ones we
> don't want to re-submit and keep the rest.
> =

Hi Christian,

The thing is vm flush fence has no job passed to amdgpu_fence_emit, so
go through the jobs cannot help find the vm flush fence. And keep the
rest fences in the RCU array will lead to signaling them in the ib_test
right after ASIC reset. While they will be signaled again during
resubmission. What I'm doning here is just trying to cleanup the fences
without a parent job and make sure the rest fences won't be signaled
twice.

> And please drop any usage of DMA_FENCE_FLAG_USER_BITS. That is not someth=
ing
> which should be abused for reset handling.
> =

The DMA_FENCE_FLAG_USER_BITS here is to mark this fence has a parent
job. If this is not a proper usage here, do you have any suggestions
about how to identify whether the fence has a parent job?

Best Regards,
JingWen Chen
> Regards,
> Christian.
> =

> > =

> > =

> > Best Regards,
> > JingWen Chen
> > > > Andrey
> > > > =

> > > > =

> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* after all hw jobs are rese=
t, hw fence is
> > > > > > > meaningless, so force_completion */
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_fence_driver_force_com=
pletion(ring);
> > > > > > >  =A0=A0=A0=A0=A0=A0 }
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > index eecf21d8ec33..815776c9a013 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > @@ -156,11 +156,17 @@ int amdgpu_fence_emit(struct
> > > > > > > amdgpu_ring *ring, struct dma_fence **f, struct amd
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 job->ring =3D ring;
> > > > > > >  =A0=A0=A0=A0=A0=A0 }
> > > > > > > -=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > > > -=A0=A0=A0 dma_fence_init(fence, &amdgpu_fence_ops,
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &ring->fence_drv.=
lock,
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->fence_conte=
xt + ring->idx,
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seq);
> > > > > > > +=A0=A0=A0 if (job !=3D NULL && job->base.resubmit_flag =3D=
=3D 1) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 /* reinit seq for resubmitted jobs */
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 fence->seqno =3D seq;
> > > > > > > +=A0=A0=A0 } else {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > > Seems like you could do the above line only once above if-else
> > > > > > as it was
> > > > > > before
> > > > > Sure, I will modify this.
> > > > > =

> > > > > =

> > > > > Best Regards,
> > > > > JingWen Chen
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_init(fence, &amdgpu_fence_op=
s,
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &ring->fence_d=
rv.lock,
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->fence_co=
ntext + ring->idx,
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seq);
> > > > > > > +=A0=A0=A0 }
> > > > > > >  =A0=A0=A0=A0=A0=A0 if (job !=3D NULL) {
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* mark this fence has a pare=
nt job */
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > index 7c426e225b24..d6f848adc3f4 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > @@ -241,6 +241,7 @@ static struct dma_fence
> > > > > > > *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_fence_set_error(finished,=
 -ECANCELED);/* skip
> > > > > > > IB as well if VRAM lost */
> > > > > > >  =A0=A0=A0=A0=A0=A0 if (finished->error < 0) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_put(&job->hw_fence);
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_INFO("Skip scheduling IBs=
!\n");
> > > > > > >  =A0=A0=A0=A0=A0=A0 } else {
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r =3D amdgpu_ib_schedule(ring=
, job->num_ibs, job->ibs, job,
> > > > > > > @@ -249,7 +250,8 @@ static struct dma_fence
> > > > > > > *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_ERROR("Error =
scheduling IBs (%d)\n", r);
> > > > > > >  =A0=A0=A0=A0=A0=A0 }
> > > > > > > -=A0=A0=A0 dma_fence_get(fence);
> > > > > > > +=A0=A0=A0 if (!job->base.resubmit_flag)
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_get(fence);
> > > > > > >  =A0=A0=A0=A0=A0=A0 amdgpu_job_free_resources(job);
> > > > > > >  =A0=A0=A0=A0=A0=A0 fence =3D r ? ERR_PTR(r) : fence;
> > > > > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > index f4f474944169..5a36ab5aea2d 100644
> > > > > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > @@ -544,6 +544,7 @@ void drm_sched_resubmit_jobs_ext(struct
> > > > > > > drm_gpu_scheduler *sched, int max)
> > > > > > > dma_fence_set_error(&s_fence->finished, -ECANCELED);
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_fence_put(s_job->s_fence-=
>parent);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 s_job->resubmit_flag =3D 1;
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fence =3D sched->ops->run_job=
(s_job);
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i++;
> > > > > > > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_sc=
heduler.h
> > > > > > > index 4ea8606d91fe..06c101af1f71 100644
> > > > > > > --- a/include/drm/gpu_scheduler.h
> > > > > > > +++ b/include/drm/gpu_scheduler.h
> > > > > > > @@ -198,6 +198,7 @@ struct drm_sched_job {
> > > > > > >  =A0=A0=A0=A0=A0=A0 enum drm_sched_priority=A0=A0=A0=A0=A0=A0=
=A0 s_priority;
> > > > > > >  =A0=A0=A0=A0=A0=A0 struct drm_sched_entity=A0=A0=A0=A0=A0=A0=
=A0=A0 *entity;
> > > > > > >  =A0=A0=A0=A0=A0=A0 struct dma_fence_cb=A0=A0=A0=A0=A0=A0=A0 =
cb;
> > > > > > > +=A0=A0=A0 int resubmit_flag;
> > > > > > >  =A0=A0 };
> > > > > > >  =A0=A0 static inline bool drm_sched_invalidate_job(struct
> > > > > > > drm_sched_job *s_job,
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
