Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E688BCCD195
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 02:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8258810E23C;
	Mon, 20 Oct 2025 02:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rdkMfIxH";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F8010E23C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 02:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2ziOPPDZyUthSlMcesGN30+tnncyp1gaIMSfHRY5chFF4wrN9ol4agN3wTj/GiLXw8A+LYQYaUbHQs0qYt8KOBejv7a47UJs7bNwGGHJacbY1m+e2Fbo4pE0DnqYqpBiXiy6gWoueupfcjhu3uRLemoPs7zfEZhq34VMTMjzp+NFNdBtQ6yadceDnmWxJFDTMPFZXT3HsDSacdB4nK4Jt5SvcNcLFqLGoZOnu+nh9iaO/yXOLgQjjLfMkOLv/qemd1RaRVMfWZYC8LC+mMeD6ogc6BFpN/VEB67/FkntXPxSPcrQxlSaQkdlDBYllBZpAx3U06etAaI9DDbZeLylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDUl/oxSCsqKOa++BwtMwAyNGUYSwHNJGWXOvR78qTs=;
 b=GpQ+m0Iq5tsa7tMMXf2eGDfOph2cpl6l4DaHxTeJd8f0rRAraCMXuUbi3gkioAI0lo8alNAZZSq8j0Dgt3heEsJJf7umVe+5ZS+jaFqjoSH5t+naN4Vit8jHLBXaxOUX915pQwc9z5oyDybhINhQcjOkSsmcIumVQdLo/OMJB1MhVxrOaJh50LmN1UNSADspu5lY/cVgWgw9ZqORN4IabkaExtwsQjEjvcUYnY1Z6Dm5QSskUC4mwWJtgA3Nsl0sgQYSt5FXaMoBMnfY1YGFpRju5V4diYFqo1Aw9H0EXDNykmO492gWCiR4B7UKV4ZuCxDusczyAwYC2Ke2ib9+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDUl/oxSCsqKOa++BwtMwAyNGUYSwHNJGWXOvR78qTs=;
 b=rdkMfIxH9jehNiamIb/PuhSU74vnHS5q4TkBWrde3hkJN1dWbiZO2KK0phf6aJEtf6ylvDAfaNOU/GAXSSONeUjWmjH1jgpraj2DHcc2p6GODIWr4iado+zCCp1iK6qYaSlEVtmN793SGLSDaL/aGcNLyBli1tGcFD2hlN7/lJQ=
Received: from BN9PR03CA0578.namprd03.prod.outlook.com (2603:10b6:408:10d::13)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 02:27:12 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::e4) by BN9PR03CA0578.outlook.office365.com
 (2603:10b6:408:10d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.14 via Frontend Transport; Mon,
 20 Oct 2025 02:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Mon, 20 Oct 2025 02:27:11 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 19 Oct 2025 19:27:10 -0700
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amdgpu: get rev_id from strap register or IP-discovery
 table
Date: Mon, 20 Oct 2025 10:26:50 +0800
Message-ID: <20251020022650.2969365-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae5f337-ec3d-4038-eff9-08de0f802cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FkszQg33SFOFh8oUm4Ifvh/fTkoyjvhN5b99pVGPJh16FPk6JoAabl2jA0bs?=
 =?us-ascii?Q?MpjtjHswxYglQcMrSE5sYZU8eu0FLXoJZxSIXI8JRnnO7Mf24f5m2//btfxC?=
 =?us-ascii?Q?K0Jjx9jOs020GO4bV6NUUCQH45k9lnpapGupsRSdF8wvZCVS5t+zXjmvCzoB?=
 =?us-ascii?Q?ggOGwrLLhJZ2A/PzaRcbJGPRJySh9LoTh4bJ5R/PMVSOkuOHXiLPVkzSdsYs?=
 =?us-ascii?Q?hLc8e12ZPv+Jb3yRGayiyXayd/OwBj33UnjV1jqSRRsjTaMVK+SzPDsI14BB?=
 =?us-ascii?Q?P8P7MFcVqAPkXJuUjERO4kq/nTauJNV8FcAAHAH/Jn7bcXTZN79R+Tg1UErI?=
 =?us-ascii?Q?o09amxbbM8LcvFKgP0Sr9WYQ9xyvVFgf71kR1afbD1maWH/oXEdcTbRXYBAX?=
 =?us-ascii?Q?dmzijWseXX2T1hTsnH0JvbJTVOJAhyoqBvPNbK6KgZfZnaALYdFszSRGaH8K?=
 =?us-ascii?Q?gzAP5TskFC3Rx1JjDu+08hmk2bqLcTcJGIpizk5bVoDwdCGZrwFpAaTA3ZMH?=
 =?us-ascii?Q?v6C91yZMHgolnLcuH0RgSqHrgsIM5zkkGgeOtxpoLhxtfB+l2iyiDujAP8YV?=
 =?us-ascii?Q?lM0mSsQQE+g2eqXa/11YQCtBRBOJ4PFn4GhZwAq+ZL4hJIpHB+l11H9PUglT?=
 =?us-ascii?Q?E2nN/fL1OtUmi/bvd4HPVSiU31TqgQO7waoIN43TUuHbv+Lc9T3yLaGvwo7H?=
 =?us-ascii?Q?iY7V6m/PGbhG0OAxJtEoVGR3qW7tSCC6Orkj++cLYNLPG2MW/gh+mL+LJ97h?=
 =?us-ascii?Q?As2tOYtyPCnpxDPpp+p6/a+wF0Puz6w6KKm8s+CHzd+dX84Dvt5S/AJB1SAF?=
 =?us-ascii?Q?8rZtB0ej/XtaCZRdL5IGJAqR8Qw09UbcZeS8o2XnHBegseqyrRRRv7wvo6qu?=
 =?us-ascii?Q?7pYFcAigm8/xoVsskY8Sx+0zIZ/Bh0+TxmeX0uoyLODqRX84c0B6jv1VKaiz?=
 =?us-ascii?Q?4S13h+eq8jI0lakX+ZJ110ccTabPKjRTBYHcECSLgpa7i48b270W+sXs0hcu?=
 =?us-ascii?Q?UbPxwtFKKUkIN5ivRkQSgELYa43048jDcpankEGEjzlZlHlF0y5JLOsWLTxY?=
 =?us-ascii?Q?gZpwomsIPpaMWgQpnCgU20pJjLBLfmvGfpFUNXGhZfI74yb7cmz9X4VRP7aP?=
 =?us-ascii?Q?gBKJsQwiq8B99QsffmAMqlFYnJUplw8xtHbpFfoTTL/lxq6PpNtgxcJzPMBt?=
 =?us-ascii?Q?4CSZk7yHtk9Nt/1BEEA1FoSo8zCDDs1DNyBzEsSRFnnLGqOM971t8NdbMbyp?=
 =?us-ascii?Q?6h5AUgFvGuE4WssiQPVhpNLUq8QesPkoOsGxMy0PtvtF37A1Vn30PVn3AhAg?=
 =?us-ascii?Q?GsA9O7F0fQdp6Kgtls6EE4wYyhf6+MQyJlfUf5/RL9P3anXmNqYe/M60Hgd+?=
 =?us-ascii?Q?0+nc68AaoSJVnzXbvRAF6yjaKdQO3wfUw9MCGt3bHk+kcLp2t6C26M03D1kK?=
 =?us-ascii?Q?HmmMQn2oasO7FAMSR/NB+bTD7CPmtSCl53kpGZ2S5egAtlCUqigLf1bOo4Gm?=
 =?us-ascii?Q?UXQuGXCtKo4vY9oz2+y1ahagqixXxmhmwFrJz7mG1IQdPJrlxPnRIPKo1HvS?=
 =?us-ascii?Q?QriBwzlt4OIxppa+NHg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 02:27:11.6988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae5f337-ec3d-4038-eff9-08de0f802cf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
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

Query the sub-revision field in the IP Discovery table for the VFs
to obtain their revision ID.
Meanwhile, read the revision ID from the strap register for the PF.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  4 ++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 24 +++++++++++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2041737a5fbe..72897cf1ac81 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1841,6 +1841,10 @@ static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
+		adev->rev_id == 0x3)
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+
 	if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
 		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
 		adev->gmc.vram_vendor = vram_info & 0xF;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 1c22bc11c1f8..bdfd2917e3ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -41,19 +41,21 @@ static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)
 
 static u32 nbio_v7_9_get_rev_id(struct amdgpu_device *adev)
 {
-	u32 tmp;
-
-	tmp = IP_VERSION_SUBREV(amdgpu_ip_version_full(adev, NBIO_HWIP, 0));
-	/* If it is VF or subrevision holds a non-zero value, that should be used */
-	if (tmp || amdgpu_sriov_vf(adev))
-		return tmp;
+	u32 rev_id;
 
-	/* If discovery subrev is not updated, use register version */
-	tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
-	tmp = REG_GET_FIELD(tmp, RCC_STRAP0_RCC_DEV0_EPF0_STRAP0,
-			    STRAP_ATI_REV_ID_DEV0_F0);
+	/*
+	 * fetch the sub-revision field from the IP-discovery table
+	 * (returns zero if the table entry is not populated).
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		rev_id = IP_VERSION_SUBREV(amdgpu_ip_version_full(adev, NBIO_HWIP, 0));
+	} else {
+		rev_id = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+		rev_id = REG_GET_FIELD(rev_id, RCC_STRAP0_RCC_DEV0_EPF0_STRAP0,
+				STRAP_ATI_REV_ID_DEV0_F0);
+	}
 
-	return tmp;
+	return rev_id;
 }
 
 static void nbio_v7_9_mc_access_enable(struct amdgpu_device *adev, bool enable)
-- 
2.34.1

