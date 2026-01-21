Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C958DC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 23:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF4510E19E;
	Wed, 21 Jan 2026 23:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hw5Yz7wd";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1917710E00E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 23:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVEEUrGGO5nteuHZtUeviHgR3ojh10cNhmSUoykD1c9luX4NOZE1E1YoAe/WpTbPP5eIrnUses0TNK8REC40OQpqzR2h197SPH6UIZHI2ZadpW4EXQ060tFr7yHlZU9pQCVjvye4SxIAEzdq134MfRVanq0Qnyyz7DJM68VYMd5264a/fhZ2qnOIlvJ4VpkhdBOAGMqt66ThxFJQHGa1QrteTAq05y629mpHFaMdLTlhttInuuQwAOb/A9ADPE7jxr7bvvyhYFhUblJ/DrFmCXHFb1JYBJBAaLblxkQfIqgnB5HIjXjEc8R2MbMXIp66wxG60JpkrFfIkbQAoBV+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTdhT/lTP1VC1FwxZYBLi2cpugl4PfklWGYk3P3eByw=;
 b=latPdrB1WUw8qiITG1WlPgWTMIvaLeN8BCXSQfipZfx4Kscms06hDavJe2KZ9lvBmQkE8TQWG0kAOgqU/A6ZF5Hri2JXvCcuFI0A/fkXBoDqZ8L0NnhXOmBcWJC9kDM/R4MPQtSyMwW0P1JbFJHKxPjmDWnNBEwEcvgC+9zLtjmuRQTi6Y/qVwJxHCPgtf28kkzgTJmyQP75zUYlE/Z+JRAsfgYUao6UjJ6wc6WvvViIp+RzxEdHT3nqCh8fRBuodzpOwMLZScIasD1g3BnwpjOnlgaaYfKpCbzw70QkkBYtdWW5RlARw40vcuMojnAMnTTKcwu5enVKFwtC8NiFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTdhT/lTP1VC1FwxZYBLi2cpugl4PfklWGYk3P3eByw=;
 b=hw5Yz7wdOZAiIlABSXqXrkjGi0SUUbkmz5edYZDKksITSc3SLiYVMprIe+3f6L3tgrOtoBdGMWObWoT+kJqxFQhhJdoNbk1uTszPL8VLIMTG0nSaK7shBpap/tLnPmCEILTeWQBkToTZAzfEFcpIW0twfRhxMJLngwQgKNiS/wM=
Received: from BN1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:408:e2::30)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:24:53 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com (2603:10b6:408:e2::4)
 by BN1PR13CA0025.outlook.office365.com (2603:10b6:408:e2::30) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9
 via Frontend Transport; Wed, 21 Jan 2026 23:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 23:24:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 17:24:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 17:24:52 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 21 Jan 2026 17:24:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH] Revert "drm/amd/display: pause the workload setting in dm"
Date: Wed, 21 Jan 2026 18:24:44 -0500
Message-ID: <20260121232444.59107-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d23f55-71c4-4275-30de-08de594447d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rJd1kBDd9zHTltSsMCGxsSGdAzi9KOr68bnR9elOuKeV7ZD07u9pR7aMxS2v?=
 =?us-ascii?Q?DCrXbgcJdPqmYOahGFr0IarUBLLqxKpIvS52fwmG+Za/o2XIP2i+GErOj5gf?=
 =?us-ascii?Q?BX6LbjW/7oF250WLANfq4vvJKjTl/NaFqpsxU/SWwIY0mNQZVC85C5kEPyrr?=
 =?us-ascii?Q?ImX2x8sTyVq+4Fl3PEo4z1sWlBL+4O8A6Ef2h/P18UVFbFim8Jg3DFIniwTT?=
 =?us-ascii?Q?guv838KUCbNa+zqcCR7yAApwf1RUTrYXBwOJNWrSeYL44SgN1lFbK4ObTVFa?=
 =?us-ascii?Q?nCeM5uoRRuUd98kL+mMp2TCwEf2l//CLtUuzTyS3qJxkAe5GRYqUrWXUJsCC?=
 =?us-ascii?Q?qtIRBIBKQJGD+v8tUUD3eRWJpGW5RG/YEQuOkgQzxsS/YE60L0wEk3vCcgRD?=
 =?us-ascii?Q?JD0HDJTjLjsZElyTHbjplr+OV7fA1p2s7/hxB+PfING/3HiLxqv+rUdqD5Li?=
 =?us-ascii?Q?kd1yIMhg8GibOxXtD9MnPwfaUnMvSySv0xwHvXxR0sJu5slkRVgznWhK/lBl?=
 =?us-ascii?Q?FDPDDBnINlezBSp7qnBMwgig/sSMBDja+MX2uDxq8uzA4GJ4dOmaM0Rg4c+F?=
 =?us-ascii?Q?Bqcnh6UnL+O/ZrJ+yEePC5LtvXYyK+5a4hK6i4qg0v6rdbN5t2cOwv8rVdXQ?=
 =?us-ascii?Q?tbX0Qc4WadcUZUHGFrbrQo94uZ7ncr9r9kIcMQwzM15/rT+qRRyI45VIKNqx?=
 =?us-ascii?Q?s0ihvi7UGmx+Py15mNFLanHIFElhKyXrTZkeMIDtSoVrtxfCKtwQ/iyWnr8W?=
 =?us-ascii?Q?a5Gl+YnRHRekLmyscYwh5wBZ+P2sLF5FhrUHHcqK3mwYXHNRL9PluffRcPHt?=
 =?us-ascii?Q?aDgxy1Gt9CulnZOPUxx6EZNVENXiHZiSl1VCOqB+bXWJiExbyFjhBdUKqbaN?=
 =?us-ascii?Q?lz81vxzhk5MlgeMH0wCYhitVrBdvA/txj7f0+ZBxerdKiUjGEY2sq3yni9Rr?=
 =?us-ascii?Q?x64c6JaTtndaTUWTZT53BASXApZgsVwakeTyu0bgmJANGfgX0JVA92nfp9Xv?=
 =?us-ascii?Q?OBiTnYVqcaFUTCe8Pg6eUdTVISx+0VMgHaoOChcMdaKt7a4ALx5pvUlFN8Ov?=
 =?us-ascii?Q?spQn1hpoOxKHAAg+1LISNh5wsNT29nAU3lQ9lJbwgVAnXUTuCCe4VMlyUqU9?=
 =?us-ascii?Q?WwGHzA+v6EN7yAfDJQDcGqndLNTQ8LRk62gtbap1SRm0qaBYBJN/afXE9BCz?=
 =?us-ascii?Q?h5G9cec9jAPOGwnfQfptCm6//PSKPeb/RA++emn1pEKu3vGLaiYFvQXIaXm8?=
 =?us-ascii?Q?yiNPIW4IFC/Jga/tuBoyyv1msroS/y0DphPi6iWz1Beq8oE/djtCIs9XX6e/?=
 =?us-ascii?Q?9wf0DcHuibZ9b3kOmdvXS5qau7ukYkXRxH124nYIzChTlK+HPZKQ84DnFT79?=
 =?us-ascii?Q?Icay075j94aA5d7iLgTdnzLhGVSw+yhKs1Bo8GRK/vAfD/MrPMGmri0KpFeI?=
 =?us-ascii?Q?19KnRGTL+imxSHc4mm8DDGDIxWzpkbCs3D+g1DSj5K2R4DB2WYhvpawgWkr6?=
 =?us-ascii?Q?RkKIvqMZg4UKP0SO3QsXfMsae+JyVpfgR1NB3imc301Av3wVJnBidit4s94E?=
 =?us-ascii?Q?DFeXqy9v8jN0MYKiYDCO3P127yEmkMMULsMZ/3u4CYdhIHmmW3cGZfgXqgSt?=
 =?us-ascii?Q?aUIAalwHTqnkpcDfX10bgp3dIFgAUkx1mB8krx9adcl+fepoSYVYwHaEqXvA?=
 =?us-ascii?Q?Dmm3hQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:24:53.0580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d23f55-71c4-4275-30de-08de594447d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
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

This reverts commit bc6d54ac7e7436721a19443265f971f890c13cc5.

The workload profile needs to be in the default state when
the dc idle optimizaion state is entered.  However, when
jobs come in for video or GFX or compute, the profile may
be set to a non-default profile resulting in the dc idle
optimizations not taking affect and resulting in higher
power usage.  As such we need to pause the workload profile
changes during this transition.  When this patch was originally
committed, it caused a regression with a Dell U3224KB display,
but no other problems were reported at the time.  When it
was reapplied (this patch) to address increased power usage, it
seems to have caused additional regressions.  This change seems
to have a number of side affects (audio issues, stuttering,
etc.).  I suspect the pause should only happen when all displays
are off or in static screen mode, but I think this call site
gets called more often than that which results in idle state
entry more often than intended.  For now revert.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4894
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4717
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4725
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4517
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4806
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 38f9ea313dcbb..2e7ee77c010e1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -248,8 +248,6 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
 	struct amdgpu_display_manager *dm = vblank_work->dm;
-	struct amdgpu_device *adev = drm_to_adev(dm->ddev);
-	int r;
 
 	mutex_lock(&dm->dc_lock);
 
@@ -279,16 +277,7 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 
 	if (dm->active_vblank_irq_count == 0) {
 		dc_post_update_surfaces_to_stream(dm->dc);
-
-		r = amdgpu_dpm_pause_power_profile(adev, true);
-		if (r)
-			dev_warn(adev->dev, "failed to set default power profile mode\n");
-
 		dc_allow_idle_optimizations(dm->dc, true);
-
-		r = amdgpu_dpm_pause_power_profile(adev, false);
-		if (r)
-			dev_warn(adev->dev, "failed to restore the power profile mode\n");
 	}
 
 	mutex_unlock(&dm->dc_lock);
-- 
2.52.0

