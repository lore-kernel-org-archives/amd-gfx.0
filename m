Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97C4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 03:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D94610EAE0;
	Thu, 17 Mar 2022 03:30:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A0E10EAE0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 03:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnUfBPsy7kVEjoD52pgNOi2Laxq6hphJYk4YdjzPioAju9JN5OsKPibo8HL/7pSi5+XWhMlTf6toSknehb2jBjrdhapF6xu3E+6WRo22me2N1k1hxkbF86Y7cgwqwks4lWOUxnNIKAgHTMEjYGA4FFZlsCFY+NrZ2aKFL5nNl/KPVtNiL43ndsrLAtqJbk//IfbFdB3m5tXE0UbZ6k31Iy1iX2xMF5IXayi54I6/rK9qe62q/KiwI9QVognXFfBK/jP528bEA1hi8cPOXC5ab52uf93P5vb2vp1SJ0Ff//a+UxENL2RIo2OHRpCYcjVFlz9PXv5WrbgFXnLQGyIdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNH5AZ34Sq9dbsXvlhf6glJUHwuzz4fdq8Q6sXA0n9Q=;
 b=OCOkcZnL9lCgiv33J4WTZoq6mQIk/POFzs+FadCFvCTmN6ssnPEuUFgUS4VQJGozskOl9KhIsXZMsTFP39A6Pw7TPqIN5Hyjcdg79t8fJr4TimuWutsNN+MaJatP0b2tm17hqa3iYPtX4LQyNwj38jXSHrTjgcbgotgxIW84kx/mUcyZF5Oq1VI51nyEdEnledaVbvMP6yBrlevUgm3DLz4vgp3wsveZb4ROrzha8mbqWE75Q4psRDSw2QqCbqYhAzvvb6szgX2y9cHbvDVNYHYXmul7HskAAaWcIOoM36JHXq0me40Uqgc6a/HQHopwKgMlEm2+mzf8fT5D6OFxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNH5AZ34Sq9dbsXvlhf6glJUHwuzz4fdq8Q6sXA0n9Q=;
 b=YsVTBpN8k0pagWA5P5KR5zn7+xbNc0lpR8sTrdxQRCF3LawJ6D/aCi884D+VrBo1M7aDHMHeuVpiPzJLTmQ1iE2+Y7H10izsacREGFD71+mkmu84V1seagw61lz5AeYeJURXjdlQTIJ10ODiDtqaESqsUnlrp6gXfx0ln5+SRXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MWHPR1201MB0254.namprd12.prod.outlook.com (2603:10b6:301:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 03:30:02 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5061.028; Thu, 17 Mar 2022
 03:30:02 +0000
Date: Thu, 17 Mar 2022 11:29:40 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_test
Message-ID: <YjKrJJa3Ys72ZNSZ@amd.com>
References: <20220315102551.3581234-1-yifan1.zhang@amd.com>
 <YjCCqSQk165EKvZC@amd.com>
 <BN6PR12MB1187A91E34BB126B74B9CC7BC1109@BN6PR12MB1187.namprd12.prod.outlook.com>
 <BN6PR12MB1187C7E45A40C7063C185249C1129@BN6PR12MB1187.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR12MB1187C7E45A40C7063C185249C1129@BN6PR12MB1187.namprd12.prod.outlook.com>
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f5a73f6-2e36-4582-8dcd-08da07c66c10
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0254:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0254DEA5619C6D78A2E192E8EC129@MWHPR1201MB0254.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QxIV3LGSbJ1z5FDos97heh5djfHOy/etJcF2eGgWQR2i47KnHV86K/k4VQMngqFnreRyMmkNUV100cNUM1JbD+lrNzAIIoVIfnvORuhtMhRzyYNxb5Yeu7RjpOfHKfdxG4wNJEko/DIauzIxxRZsjzqGbyqFsulkm1NTNoTYfMs9w9SYPdA22vvJce4vIUmXylvC9yOpugEKz9FluwWLYwZjcipqxlc54+r9aGnw3KK4l0KHV70EqJ38a1PWRDXgdKY17yVrNqu5riH0I3mqk/coTa5XyZYsnGFXaQyRNFF3jCYERGlR/wEPdsxgdNpQuwke16gAKY5v2ZHPO68+f0mvaK6NMHsMekgVm1zQZxAhKLvrR2L0To2sODcfyUFojBmklqgt2OaKQr/xUE5qkCNZG/f+AyH4hpq+cF237muNPAjUG4who6BJab2oSdAWncXxcDLRxxIuxKu4dLAbhRhp3pmg72vGTBHYekUPkYc8E4fVBTdGxwBeblJC7nTUG0/QJpv08iQbAiAlL2VmB4szlc5DV/5cfAY+IPE2oQ69XXmISv2VEMmmcKsYHTNiMtnRRtdtp9RT3QOtw1gtgzAcqzQAZrkqv760K2pImaDitTWypeBIp8BcNWuUKGuBQ5D6OBHfeBKdzdPU5VAMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(6486002)(5660300002)(36756003)(8676002)(53546011)(86362001)(6506007)(6666004)(6512007)(6862004)(4326008)(66946007)(66476007)(66556008)(38100700002)(54906003)(6636002)(83380400001)(26005)(186003)(8936002)(2906002)(2616005)(316002)(37006003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ESg41moKI4k1bj9kI/5RXGqlXgyKGVdOVV5FjCqolf2jxJ4BO2UsMzxPQ/2?=
 =?us-ascii?Q?1m3UnkEAt4nF+A9osrE+5cGA/PXBdxs0ETw0vBP0jZXBH9rKaDe0+CmUAaIU?=
 =?us-ascii?Q?nf+8QcmBoYTF69Fq288N1HIefxSMaxnQDYFdzwNFj4K+D6TkGpMQR4xfz2Wf?=
 =?us-ascii?Q?oeJjijtjWV8/Pf/In+Inpe9BpEW7wK7K74EhhgmG+kSKPoa/aJOF9pGpHx94?=
 =?us-ascii?Q?in9Th1xv6Lx9zLY2Hj7CbdheULuLxy7AykB+re+OOm7hT9T0AFy5ClaNRDDo?=
 =?us-ascii?Q?go8J8tv1uZtaZDF4Aou1DaO3Sci1XBGDOog5h+z4rhgIpUwT5bhj5s1scRPq?=
 =?us-ascii?Q?8FEwKzievhGio/gB9gKOwAsQNTk9QuiKsHjQHmFPJPIz9ZRm04XMvO7sIu8z?=
 =?us-ascii?Q?l+VxswmMRC4Jp5dhSn8Qg3G9T9JlvV+lsjSf/yAgXN9GWe2x6BzKf09HY9NK?=
 =?us-ascii?Q?6U0GVnkr7csSguc+IobKwJpRMLku8AkW63I61Hbm/YLyqUGLxGmPJ4LTKoy9?=
 =?us-ascii?Q?BjyybGtxUJVXLvQdOeC6seujSjCC1eYu/BjYKGYH1pbc5TmWbf2p7Hpr67xN?=
 =?us-ascii?Q?zlH76u8X1P29VQv9aLG76ZO4wngsMpiyU8gTqPoUpXYFibJbJIEKmcG5yns8?=
 =?us-ascii?Q?ILOqcLQ/c1vdosxJAYm53YfyO+BcuvPt86Wl4qjGndghtCrL6P5klpPgeCg5?=
 =?us-ascii?Q?5P0X4eg0XSGMdUozbLsPvgGeTKvuUN0lFW9OPwVxdB47R22uUBHXwN097E+i?=
 =?us-ascii?Q?L9dW2Alt1LBcdvKXfb9au0T1T0us2mSmi+SxbRogEKUfF9oU4EIeAvkiJNp/?=
 =?us-ascii?Q?btNoPN876e9OcQkJ4L603dFR4gboXv97aMUGHdWZ/bu/F0wYmAJmVSW2vDyO?=
 =?us-ascii?Q?Xc00EPg2RDAlkxkr1ovmVgh4m110fqTUKrb0EvNcbv5gQzFba+WUvECxxnGK?=
 =?us-ascii?Q?49YDmLUvd/DYOgOhj/PNHh8Dv4BPVeB3xgPVbS7J2AUcKJyOKnA8U4yCglO5?=
 =?us-ascii?Q?xZaL0GM6o/tJehoTyOJO1WAXr5fYIKSTasMX5zwLbTxXcUb0373H+TSP1uR8?=
 =?us-ascii?Q?YcaAZGtL9AxsifLUh0Y2cAvmXhEYY2ZaNorsg8ARVmtiU1QKTjJDHZpnwEo7?=
 =?us-ascii?Q?cE/iXGfisiEGFOP919FEVwUE8ntqMDLsnEUn2jbLIlr5SCY4biw7xxPKCQLH?=
 =?us-ascii?Q?x7wBUHTqmOvrTsvW05h/t8ZGOnLKDVksiqX7Kvlu0cQEXeTmd/sH+gJH1fDa?=
 =?us-ascii?Q?gs0+8dn6VnSLsqLV21NYclP+z61x/qmfxj0XlfCkqJWixVu6eug+YE8/o55q?=
 =?us-ascii?Q?Aud4D9Kyk8jA5pcE+fU+3BfZpt9VW2Kff+ebYnC4nJjj3Hb2mCfNinwHNM+z?=
 =?us-ascii?Q?BlZf1Y/V2Du8Yl3aShj7xjGwD1n4TE42B/bMw1nqc2Uw1eNKezDBNHF53tpR?=
 =?us-ascii?Q?47JE5JJuvtwB7ZEl/1z34IwH7yW2uZmB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5a73f6-2e36-4582-8dcd-08da07c66c10
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 03:30:02.6008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XF5Bz9IJp2toTd6vDMvQEUe64uNZ8cuJ26/NjPDlPAOBfFrs8fYXmK2VMIpHT7vdw5sKB3IDQ0qIeZITmHZRLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0254
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 17, 2022 at 11:14:53AM +0800, Zhang, Yifan wrote:
> [AMD Official Use Only]
> 
> Since it is a generic swsmu issue, shall we merge it first as temporary fix to unblock amdgpu_test ? As most of swsmu_pm_funcs have an assumption that pm.dpm_enabled is true, if allow this value is be false, Lots of swsmu pm logic needs to be changed.

(+ Evan)

This is actually a common issue for APU series. The best solution is to
modify the swSMU driver to revise pm.dpm_enabled to indicate the real DPM
status of current platform.

For now, I am fine to give the quick fix to unblock the amdgpu_test. You
may add the comment (FIXME) around the code to describe this issue and what
you plan for next step.

With that fixed, patch is Acked-by: Huang Rui <ray.huang@amd.com>

> 
> -----Original Message-----
> From: Zhang, Yifan 
> Sent: Tuesday, March 15, 2022 8:42 PM
> To: Huang, Ray <Ray.Huang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_test
> 
> [AMD Official Use Only]
> 
> I think It is a swsmu issue rather than a smu 13.0.5 specific one, in current swsmu implementation, smu->adev->pm.dpm_enabled is always true after smu_hw_init, doesn't reflect the real DPM status; smu->pm_enabled indicates SMU functionality, also always true except in sriov.
> 
> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com> 
> Sent: Tuesday, March 15, 2022 8:12 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu/pm: fix the Stable pstate Test in amdgpu_test
> 
> On Tue, Mar 15, 2022 at 06:25:51PM +0800, Zhang, Yifan wrote:
> > If GFX DPM is disbaled, Stable pstate Test in amdgpu_test fails.
> > Check GFX DPM statue before change clock level
> > 
> > Log:
> > [   46.595274] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:02:00.0 on minor 0
> > [   46.599929] fbcon: amdgpudrmfb (fb0) is primary device
> > [   46.785753] Console: switching to colour frame buffer device 240x67
> > [   46.811765] amdgpu 0000:02:00.0: [drm] fb0: amdgpudrmfb frame buffer device
> > [  131.398407] amdgpu 0000:02:00.0: amdgpu: Failed to set performance level!
> > 
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c 
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> > index 7bfac029e513..b81711c4ff33 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> > @@ -991,7 +991,7 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (sclk_min && sclk_max) {
> > +	if (sclk_min && sclk_max && smu_v13_0_5_clk_dpm_is_enabled(smu, 
> > +SMU_SCLK)) {
> 
> SMU driver actually checked smu->pm_enabled and smu->adev->pm.dpm_enabled in smu_force_performance_level. I am confused why these two flags are true while the smu v13.0.5's dpm is disabled.
> 
> Thanks,
> Ray
