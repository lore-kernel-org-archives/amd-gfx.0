Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6232BC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 04:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2122D60E95
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 04:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2122D60E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B8D6E027;
	Fri, 23 Jul 2021 04:36:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79C16E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 04:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFbH7521ffE1SB+3vreXHI1J27HazWS3rgp/SL2qW+MZS0hPC6lCsvtPOeRpBpbbRc3sl992LGlsKuW5yP6TFumk71bIwVsbNO4SJBfoU28eP/rarRk+ToiFZCXTr12xofPHVCcBjFpAC41W+yKVkV2KIG8jfOD/HHH4Q40GTeAg1zS5sKFUWeIMRcLwUfz4JVt6+85cG1SXedetgixnG5AU/nfiIhtA0Hb9DNHj+Nvv7auj4rOBB1SOCcEEf75z6Sm4028hK9yv+gTHHspVPg/3DUvDhFuHUEePBoLMYsZEGutpNfChqyDQQ43usgEk5AFXr8ZsdXbJaefsBhZeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI8Wz0nux8qjhrDhOinw9jTGSu4syrddRoETe3DeKCo=;
 b=Q0yseZJGnKDY9pmf5H8tz4mXf2e6NTarn00vbB/kE6gkHth811CVlFoKrsZjwupsl6KwnrgA5OtMfLTudX1y2BIkZSxzt7RbfzpJTqhYyhFNRo8dzjoN2Z3NGNIuAr5FFhiSDml0dopTM2jyXKoNw61x9Yixuc9511orZWNfOCd8BeusPomNa6fSiqzvIn5lyq1YEutuCmiRv+Grq+SvTrZ0XP3vI7AaRoIIzjammgfJ0ozbws6RNIpbkOiSOa8Q0iVT2jg93TdtsOi6Wv6oXSJhlHBabRBRxXIAsj6Q0iTdWbRwUblU81QyTAsJuwNoEHh2XeViE6oM8Vldtn+Deg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI8Wz0nux8qjhrDhOinw9jTGSu4syrddRoETe3DeKCo=;
 b=qSPtIS3zpvHUseywz3H2rU79TF2NPeXNMlNLRv6dVz8dAzKRQHBJ5SObYYjTj6JdHlzeQEBPDeF4AslOyKN55VHdhbT7JKEcgW0gAQ54/OfYm7nYmVH2wGwZFci2+4Ufd/k/24xnc5dHzazhdq9WDKVLehmPqWpLnhs6viGuCjc=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by DM5PR1201MB2473.namprd12.prod.outlook.com (2603:10b6:3:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 23 Jul
 2021 04:36:16 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::30) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Fri, 23 Jul 2021 04:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 04:36:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 23:36:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 23:36:15 -0500
Received: from wayne-build (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Jul 2021 23:36:13 -0500
Date: Fri, 23 Jul 2021 12:36:12 +0800
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Christian
 =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm: add tdr support for embeded hw_fence
Message-ID: <20210723043612.pwiwuljtze6tien6@wayne-build>
References: <36f53a64-2d9c-947b-a5fb-21d9fc06c5e4@amd.com>
 <20210722104525.okcnb43goxg6uqej@wayne-build>
 <0699ff85-4aec-0e33-711b-665307fbbc24@amd.com>
 <9dacfe83-da10-9806-81e0-70077dedce9f@gmail.com>
 <20210722164704.age63nzbviqg4y7v@wayne-build>
 <50f8a8b9-4b83-a3e3-302a-643cd81d1463@amd.com>
 <20210722172718.nqqpskc6wdevs4af@wayne-build>
 <397daa59-5c96-9c17-aec7-ef58196790e3@amd.com>
 <20210723002009.wkm2nb2lvfp64ayr@wayne-build>
 <384a7f35-17ce-7313-1111-5d2c690bdbd3@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <384a7f35-17ce-7313-1111-5d2c690bdbd3@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce94f7b0-37e8-4aed-5ba9-08d94d9368e3
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2473:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB247350D41EFCFF28249B0AAFB7E59@DM5PR1201MB2473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BQKMRL960amYcdsj/1w0mmteIxIP3m82yDujNGUGcS/BT5rYCoE4lqD8zWnUAVhL9WfDZCCkyjkfFBoVPaI+9l5i9ghrtsHbQ75kaGmTxSndtPkQ53ux9AouYReioBK3HFq6yYrTmMHPiEpSWpCWyxqpHSGOfoN4u87XVaIg/uMvkGC0cWctP8tV5nq0gkyvuRlyEgJIQDeuh14n6wwiBuoj46TLXLwYvUp5kzEGX6a+/fYoPVXd6gp98rcB0/FX+sW0b4Fg14f0NENHMS3PjGedZ7V3iVNwX6fx7KBEhr53p36PE90mLezDS31QBUfoT9TxpGtXVMKhEh6qIFasdzw8HKNT5a/6yI9/3ftQyy6VBNmB0mf0stJrhsEBxPqysextvTA2Um0gV+hgDelS9X+RY5Tv2e2OM5oH9fkdy1NEwp5XC1wWifdF1rXwSHbeLa8Hqvzeqm8V+FozqD/0B+cXum5+MP6qVFMKc6kKHaASZoIfo6GitIKCPhFeGjcN0apVoyrSqSoNyy9CnteN4oUR75c46kpTtttK5Y6i7IY0YmBanAZRNrBaDmeZtRJlRbjWFQqsV0Bih7kFWFKbo68YzRsoKqGmXZIpEpKhK0AkSXdlkPi07sirzX5u/NzYPzzUhiIey7DmdMApdeTZsS/qWoa0xHuz+1Iouv5rcMLk/PQqScVcD+1YC1fVnMi0nZJke/MYNH3zH1udvJOKlBM7syTM4VCyV1XPnambzI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(84040400004)(46966006)(36840700001)(316002)(53546011)(66574015)(54906003)(33716001)(26005)(9686003)(966005)(8676002)(55016002)(110136005)(70586007)(45080400002)(83380400001)(47076005)(426003)(336012)(86362001)(82310400003)(36860700001)(2906002)(4326008)(508600001)(30864003)(356005)(1076003)(5660300002)(81166007)(8936002)(70206006)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 04:36:16.3088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce94f7b0-37e8-4aed-5ba9-08d94d9368e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2473
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
Cc: horace.chen@amd.com, monk.liu@amd.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri Jul 23, 2021 at 12:06:32AM -0400, Andrey Grodzovsky wrote:
> =

> On 2021-07-22 8:20 p.m., Jingwen Chen wrote:
> > On Thu Jul 22, 2021 at 01:50:09PM -0400, Andrey Grodzovsky wrote:
> > > On 2021-07-22 1:27 p.m., Jingwen Chen wrote:
> > > > On Thu Jul 22, 2021 at 01:17:13PM -0400, Andrey Grodzovsky wrote:
> > > > > On 2021-07-22 12:47 p.m., Jingwen Chen wrote:
> > > > > > On Thu Jul 22, 2021 at 06:24:28PM +0200, Christian K=F6nig wrot=
e:
> > > > > > > Am 22.07.21 um 16:45 schrieb Andrey Grodzovsky:
> > > > > > > > On 2021-07-22 6:45 a.m., Jingwen Chen wrote:
> > > > > > > > > On Wed Jul 21, 2021 at 12:53:51PM -0400, Andrey Grodzovsk=
y wrote:
> > > > > > > > > > On 2021-07-20 11:13 p.m., Jingwen Chen wrote:
> > > > > > > > > > > [Why]
> > > > > > > > > > > After embeded hw_fence to amdgpu_job, we need to add =
tdr support
> > > > > > > > > > > for this feature.
> > > > > > > > > > > =

> > > > > > > > > > > [How]
> > > > > > > > > > > 1. Add a resubmit_flag for resubmit jobs.
> > > > > > > > > > > 2. Clear job fence from RCU and force complete vm flu=
sh fences in
> > > > > > > > > > >    =A0=A0=A0=A0 pre_asic_reset
> > > > > > > > > > > 3. skip dma_fence_get for resubmit jobs and add a dma=
_fence_put
> > > > > > > > > > >    =A0=A0=A0=A0 for guilty jobs.
> > > > > > > > > > > =

> > > > > > > > > > > Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> > > > > > > > > > > Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> > > > > > > > > > > ---
> > > > > > > > > > >    =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c =
| 12 +++++++++++-
> > > > > > > > > > >    =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c=
=A0 | 16 +++++++++++-----
> > > > > > > > > > >    =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c=A0=
=A0=A0 |=A0 4 +++-
> > > > > > > > > > >    =A0=A0 drivers/gpu/drm/scheduler/sched_main.c=A0=
=A0=A0=A0 |=A0 1 +
> > > > > > > > > > >    =A0=A0 include/drm/gpu_scheduler.h=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> > > > > > > > > > >    =A0=A0 5 files changed, 27 insertions(+), 7 deleti=
ons(-)
> > > > > > > > > > > =

> > > > > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device=
.c
> > > > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > > > > > > > index 40461547701a..fe0237f72a09 100644
> > > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > > > > > > > @@ -4382,7 +4382,7 @@ int amdgpu_device_mode1_reset(s=
truct
> > > > > > > > > > > amdgpu_device *adev)
> > > > > > > > > > >    =A0=A0 int amdgpu_device_pre_asic_reset(struct amd=
gpu_device *adev,
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 struct amdgpu_reset_context *reset_context)
> > > > > > > > > > >    =A0=A0 {
> > > > > > > > > > > -=A0=A0=A0 int i, r =3D 0;
> > > > > > > > > > > +=A0=A0=A0 int i, j, r =3D 0;
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 struct amdgpu_job *job =3D NULL;
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 bool need_full_reset =3D
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_bit(AMDGPU_NEE=
D_FULL_RESET, &reset_context->flags);
> > > > > > > > > > > @@ -4406,6 +4406,16 @@ int
> > > > > > > > > > > amdgpu_device_pre_asic_reset(struct amdgpu_device *ad=
ev,
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!ring || !ring-=
>sched.thread)
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continu=
e;
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 /*clear job fence from fence d=
rv to avoid force_completion
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0 *leave NULL and vm flush fe=
nce in fence drv */
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 for (j =3D 0; j <=3D ring->fen=
ce_drv.num_fences_mask; j ++) {
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dma_fence *=
old,**ptr;
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ptr =3D &ring->fen=
ce_drv.fences[j];
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 old =3D rcu_derefe=
rence_protected(*ptr, 1);
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (old && test_bi=
t(DMA_FENCE_FLAG_USER_BITS,
> > > > > > > > > > > &old->flags))) {
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RCU_IN=
IT_POINTER(*ptr, NULL);
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > > > > Is this to avoid premature job free because of dma_fenc=
e_put inside
> > > > > > > > > > amdgpu_fence_process ?
> > > > > > > > > > I can't currently remember why but we probably want all=
 the HW fences
> > > > > > > > > > currently in the ring to
> > > > > > > > > > be forced signaled - maybe better to test for DMA_FENCE=
_FLAG_USER_BITS
> > > > > > > > > > inside amdgpu_fence_process
> > > > > > > > > > and still do the signaling but not the dma_fence_put pa=
rt
> > > > > > > > > > =

> > > > > > > > > > Andrey
> > > > > > > > > Hi Andrey,
> > > > > > > > > =

> > > > > > > > > This is to avoid signaling the same fence twice. If we st=
ill do the
> > > > > > > > > signaling, then the job in the pending list will be signa=
led first in
> > > > > > > > > force_completion, and later be signaled in resubmit. This=
 will go to
> > > > > > > > > BUG() in amdgpu_fence_process.
> > > > > > > > Oh, i see, how about just adding 'skip' flag to amdgpu_ring=
 and setting
> > > > > > > > it before calling
> > > > > > > > amdgpu_fence_driver_force_completion and resetting it after=
, then inside
> > > > > > > > amdgpu_fence_driver_force_completion
> > > > > > > > you can just skip the signaling part with this flag for fen=
ces with
> > > > > > > > DMA_FENCE_FLAG_USER_BITS set
> > > > > > > > Less lines of code at least.
> > > > > > > Still sounds quite a bit hacky.
> > > > > > > =

> > > > > > > I would rather suggest to completely drop the approach with
> > > > > > > amdgpu_fence_driver_force_completion(). I could never see why=
 we would want
> > > > > > > that in the first place.
> > > > > > > =

> > > > > > > Regards,
> > > > > > > Christian.
> > > > > > > =

> > > > > > Hi Christian,
> > > > > > =

> > > > > > I keep the amdgpu_fence_driver_force_completion here to make su=
re the vm
> > > > > > flush fence is signaled and put.
> > > > > Right, so we need to do force completion for the sake of all the =
fences
> > > > > without parent jobs since there is code which wait directly on th=
em.
> > > > > =

> > > > > =

> > > > > > So the key question is whether the fence of ib test should be t=
he first
> > > > > > fence to be signaled after reset.
> > > > > What do you mean by 'after reset' - at this point in the code the=
re was
> > > > > no ASIC reset yet, we just stopped the schedulers and detached the
> > > > > HW fences from their parent jobs (sched_fence)
> > > > I mean the ASIC reset. There will be a ib_test for each ring after =
ASIC
> > > > reset.
> > > =

> > > Then why wouldn't they be the first ? They will emit new fences into =
the
> > > ring
> > > which will be signaled right away because the ASIC went through reset=
 and is
> > > not
> > > hung anymore.=A0 All the previous fences, including VM flush once fro=
m before
> > > the
> > > reset will be already signaled by this time from
> > > amdgpu_fence_driver_force_completion.
> > > =

> > Hi Andrey,
> > =

> > Sorry I didn't make it clear. I mean if we drop force_completion here,
> > and keep other code unchanged, then the ib_test wouldn't be the first to
> > be signaled.
> =

> =

> At least in my opinion the order is not important of who will be signaled
> first. I do think it's important
> to force signal all the old fences before HW reset for 2 reasons: 1st - i=
t's
> conceptually wrong to leave them
> unsignaled and let them be signaled post ASIC reset because=A0 it's not t=
hem
> who actually completed whatever
> they were doing but rather ASIC reset allowed later fences (with higher
> sync_seq) to signal (e.g. ring test) and
> those earlier remaining fences (e.g. VM_FLUSH)=A0 just were signaled as p=
art
> of this. 2nd - Possible deadlock where
> ring->fence_drv.fences is full with fences before ASIC reset because we
> don't force signal and so don't empty it and then
> after reset we call amdgpu_fence_emit as part of ib_test but it
> de-references old yet unsignaled=A0 fence and does
> dma_fence_wait to make sure it completed which it didn't and will not
> because EOP ISR will be called only after actual
> fence emission which is blocked by the wait.
> =

> Andrey
Hi Andrey

Yes, I forget to talk about the deadlock previously. Actually I have
encountered a deadlock during debug already which is exactly the same
reason you mentioned.

I totally agree with not dropping force_completion.
> =

> =

> > =

> > =

> > Best Regards,
> > JingWen Chen
> > > > > > If it should be, it means not only fences with DMA_FENCE_FLAG_U=
SER_BITS
> > > > > > but also vm flush fences should be removed from RCU fence array=
 before
> > > > > > ib_test.
> > > =

> > > As I mentioned above, not clear to me why VM fences should get special
> > > treatment here.
> > > =

> > > Andrey
> > > =

> > > =

> > > > > Which ib_test is it, the one after ASIC reset ?
> > > > > =

> > > > Yes
> > > > =

> > > > =

> > > > Best Regards,
> > > > JingWen Chen
> > > > > Andrey
> > > > > =

> > > > > >     Then we must do the force_completion here for vm flush
> > > > > > fence, otherwise there will be a memory leak here as no one wil=
l signal
> > > > > > and put it after we remove it from RCU.
> > > > > > If not, then the first fence to signal could be vm flush fence.=
 And I'm
> > > > > > OK with drop amdgpu_fence_driver_force_completion here.
> > > > > > =

> > > > > > =

> > > > > > Best Regards,
> > > > > > JingWen Chen
> > > > > > > > Andrey
> > > > > > > > =

> > > > > > > > =

> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* after all hw job=
s are reset, hw fence is
> > > > > > > > > > > meaningless, so force_completion */
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_fence_driver=
_force_completion(ring);
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 }
> > > > > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > > > > > index eecf21d8ec33..815776c9a013 100644
> > > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > > > > > @@ -156,11 +156,17 @@ int amdgpu_fence_emit(struct
> > > > > > > > > > > amdgpu_ring *ring, struct dma_fence **f, struct amd
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 job->ring =3D ring;
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 }
> > > > > > > > > > > -=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > > > > > > > -=A0=A0=A0 dma_fence_init(fence, &amdgpu_fence_ops,
> > > > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &ring->fe=
nce_drv.lock,
> > > > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->fen=
ce_context + ring->idx,
> > > > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seq);
> > > > > > > > > > > +=A0=A0=A0 if (job !=3D NULL && job->base.resubmit_fl=
ag =3D=3D 1) {
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 /* reinit seq for resubmitted =
jobs */
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 seq =3D ++ring->fence_drv.sync=
_seq;
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 fence->seqno =3D seq;
> > > > > > > > > > > +=A0=A0=A0 } else {
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 seq =3D ++ring->fence_drv.sync=
_seq;
> > > > > > > > > > Seems like you could do the above line only once above =
if-else
> > > > > > > > > > as it was
> > > > > > > > > > before
> > > > > > > > > Sure, I will modify this.
> > > > > > > > > =

> > > > > > > > > =

I will modify this part and upload a v2 patch. Can you help add a ACK or
review by?

Best Regards,
JingWen Chen
> > > > > > > > > Best Regards,
> > > > > > > > > JingWen Chen
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_init(fence, &amdgpu_=
fence_ops,
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &ring-=
>fence_drv.lock,
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->=
fence_context + ring->idx,
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seq);
> > > > > > > > > > > +=A0=A0=A0 }
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 if (job !=3D NULL) {
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* mark this fence =
has a parent job */
> > > > > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > > > > > index 7c426e225b24..d6f848adc3f4 100644
> > > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > > > > > @@ -241,6 +241,7 @@ static struct dma_fence
> > > > > > > > > > > *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_fence_set_error=
(finished, -ECANCELED);/* skip
> > > > > > > > > > > IB as well if VRAM lost */
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 if (finished->error < 0) {
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_put(&job->hw_fence);
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_INFO("Skip sche=
duling IBs!\n");
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 } else {
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r =3D amdgpu_ib_sch=
edule(ring, job->num_ibs, job->ibs, job,
> > > > > > > > > > > @@ -249,7 +250,8 @@ static struct dma_fence
> > > > > > > > > > > *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_ERR=
OR("Error scheduling IBs (%d)\n", r);
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 }
> > > > > > > > > > > -=A0=A0=A0 dma_fence_get(fence);
> > > > > > > > > > > +=A0=A0=A0 if (!job->base.resubmit_flag)
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_get(fence);
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 amdgpu_job_free_resources(job);
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 fence =3D r ? ERR_PTR(r) : fenc=
e;
> > > > > > > > > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > > > > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > > > > > index f4f474944169..5a36ab5aea2d 100644
> > > > > > > > > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > > > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > > > > > @@ -544,6 +544,7 @@ void drm_sched_resubmit_jobs_ext(=
struct
> > > > > > > > > > > drm_gpu_scheduler *sched, int max)
> > > > > > > > > > > dma_fence_set_error(&s_fence->finished, -ECANCELED);
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_fence_put(s_job=
->s_fence->parent);
> > > > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 s_job->resubmit_flag =3D 1;
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fence =3D sched->op=
s->run_job(s_job);
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i++;
> > > > > > > > > > > diff --git a/include/drm/gpu_scheduler.h b/include/dr=
m/gpu_scheduler.h
> > > > > > > > > > > index 4ea8606d91fe..06c101af1f71 100644
> > > > > > > > > > > --- a/include/drm/gpu_scheduler.h
> > > > > > > > > > > +++ b/include/drm/gpu_scheduler.h
> > > > > > > > > > > @@ -198,6 +198,7 @@ struct drm_sched_job {
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 enum drm_sched_priority=A0=A0=
=A0=A0=A0=A0=A0 s_priority;
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 struct drm_sched_entity=A0=A0=
=A0=A0=A0=A0=A0=A0 *entity;
> > > > > > > > > > >    =A0=A0=A0=A0=A0=A0 struct dma_fence_cb=A0=A0=A0=A0=
=A0=A0=A0 cb;
> > > > > > > > > > > +=A0=A0=A0 int resubmit_flag;
> > > > > > > > > > >    =A0=A0 };
> > > > > > > > > > >    =A0=A0 static inline bool drm_sched_invalidate_job=
(struct
> > > > > > > > > > > drm_sched_job *s_job,
> > > > > > _______________________________________________
> > > > > > amd-gfx mailing list
> > > > > > amd-gfx@lists.freedesktop.org
> > > > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C0=
1%7Candrey.grodzovsky%40amd.com%7C9749ced7ce6645bd832408d94d305aaa%7C3dd896=
1fe4884e608e11a82d994e183d%7C0%7C0%7C637625692355112825%7CUnknown%7CTWFpbGZ=
sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1=
000&amp;sdata=3DOhLndCUDlWcrhg%2FA0QQ%2FoONxdmQ46CT7P%2F8uvSTGnQ8%3D&amp;re=
served=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
