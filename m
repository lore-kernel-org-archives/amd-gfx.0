Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B62CC3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 07:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D09710E2D9;
	Thu, 15 Aug 2024 07:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gNfHzxGb";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D8310E2D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 07:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUtZpp89bqQISuXQeMGP72O/4hVVz9+4Rs5tKfP97VdUDKQDuVOwmhvQirMVdls1DpORCKf/xv2NEfeXiCHg5lQb95Aj6pU76x6K0CjMWzK9ikq+1DwDw+wpipF2bPWi5YOOPx7DJ5oAaolXm5PJGBm0ViGBTybDmm9t8kLO4xzT43jTFyhFTM487S9/E8lPBTgApC4Xg16BIrjjh2jo3rRixkjxl7S+71Qb0aQGJGtXWBu6r22aOYcjzbfEa0AqwPJzC+el/P3RVAqTff9fYWgWTrQyDsjrhssLvDO4MO8t2oDkjs4K8n5cK49xFD9xuxNQJA+abcq+r//qF2xAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBKtDHrfQhsnL4YQ+6zJ0f50RrEnqDSZjua7wJdnaMg=;
 b=FBbFdoTO/zczUk4QYzHziy9ogpLkNQnVIHzRjRJe7GftA+qf7CrkotPcTl1Wvzc95ByHx041hgmCDbC4SO0qqWgNpfaMFFS4U+4QTPu/ulS048DiqtpnhQgxw4ZvhSU0g+skP4ymZrLpv4GRnWbN9Fstj0MagAdF3B9w0ojio7Bi6HEBnI1ofZMJhW6cZSO/SByHC+JEWgyzyAwOZzfj8gHiRQkVP/n4/9w5qpF4lZIwWay+QbPZAC8uvf+m4S6OlE7+xNDOlqNZyJRYdXe8UVZvtlK9/meOov331T2wbavMJ1rDqI30YTdXYNSvjlXKRFiJ/+3hts0FK9Yft+ISmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBKtDHrfQhsnL4YQ+6zJ0f50RrEnqDSZjua7wJdnaMg=;
 b=gNfHzxGbelvpJ1sT1BoQUIPlUZ7gY0QV0fIA0jHt1qzUuUvTPWygiwA69zRwCZf2BBB04DZ2QwYo1OZEaVO34swqQZug5L5MuZfWweVDZN3a4jKnmzkSZpVizcmcBc9rvRi+cEgZoIBWPQB8nJmcwTYttLs30RArR8z8/UCaREA=
Received: from SA9PR13CA0010.namprd13.prod.outlook.com (2603:10b6:806:21::15)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24; Thu, 15 Aug
 2024 07:50:15 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::27) by SA9PR13CA0010.outlook.office365.com
 (2603:10b6:806:21::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 07:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 07:50:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 02:50:14 -0500
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 02:50:14 -0500
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shikang Fan <shikang.fan@amd.com>
Subject: [PATCH] drm/amdgpu: use cpu to query utcl2 poison status
Date: Thu, 15 Aug 2024 15:50:08 +0800
Message-ID: <20240815075008.51490-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shikang.fan@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: fd546da4-8949-4ba9-0a30-08dcbcfee699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lrbO4P5CeeH87asuHz8WmqCpNeJdTrO90pS/keMO+Y3oy9dSTpIYx4jTtbd5?=
 =?us-ascii?Q?sq11lAb+fmG4pZL6u36tehe5FO2TgGwMjqvtJU0asSUoS+AVj7IvH8lcUTSm?=
 =?us-ascii?Q?hvk7os3vh/uc/V7xonS2Lnkm7diZmLWUAnuhnnBkd0OZiChmNAAzKUIlg7m1?=
 =?us-ascii?Q?7Uc+bLFR1RePV6cLjJJXvtHqJWVYvgPqfHppm4VeO8AhgJcCBEGlYRH+l9eY?=
 =?us-ascii?Q?+XN6u3ym/A41EYPA6oObmxdzILYNoPezfmtdP6c+k5CuLg6xo3yh7HFwHJ4h?=
 =?us-ascii?Q?ajOeJ4nXHy6P85RcHPwylJpb2aleHrX2soid/ac3hxdNvbUs5+qzlo81wtqT?=
 =?us-ascii?Q?6192wbcs2H6gZFGsuCjjQEMHPtw1SBOLjsr05ys8/tX/Y7vwQBiSl28zHIx2?=
 =?us-ascii?Q?vBTxizUri35PHUqtw6xBMNn2yDxq4x0x6xP054YFRcpeR8BFHvTQ+gKrDugc?=
 =?us-ascii?Q?sAcUMw2Pn3NTJ9H7EgPz0GQRLJfjUIdaRavdwqiPgYMXR/kC+yV3YuI4jSNr?=
 =?us-ascii?Q?RrG4T4YSfkKsSJiTSehr4cysV2Z3EiCj4SsRufU59QTXa2n4owf8vvdYWZVV?=
 =?us-ascii?Q?yBlP2/96N2K6VjPd4qxs/PJhovjrbtjvbMc3KK+6QS6325lkeWPxezl0KNRV?=
 =?us-ascii?Q?PoAOIKcFOj1Ag6slB5H8t+jjMqRNkB2Geqi7mcHq6qm3wxCvNQ8D9gSrwEVn?=
 =?us-ascii?Q?tgFzMHmg+oBkd0sKivO8p/jSR+dRVmcUAeB14r1hPIgCyk4HzWLsaGpcsDUD?=
 =?us-ascii?Q?xwAhRCqI09u/m3ZrEucrrluHhRO7W7Q4NFVBuANPxVXOPq1sSGYZYvSFfX20?=
 =?us-ascii?Q?cqGZrFl7gEwA9orxRSf52+xljsmrRByqqkMd2Qicashi4MYrSScJ/d3HOqFZ?=
 =?us-ascii?Q?uaf1LO/skt1TV33SrEPPb4ngtwPL//FTSn3vrhs7wNCcBv+RjYGfGF/ffvXK?=
 =?us-ascii?Q?BuWAKHp0aJF2TZYs4adCv/oH18rP4da9nB9XNQfmn7Cs6onDMEAtFFh+pP6D?=
 =?us-ascii?Q?/cI1shOWjWsbQtMhSxDiLetuT+GMTKXexm6pRE426NOnSEShNkucLhyjTYvB?=
 =?us-ascii?Q?tzLrnDEV3L34GVV9f5q0A8/UKsUsSL3RNyf5tnKhPM2dZwW/Zyt2s55orzBw?=
 =?us-ascii?Q?1s1EuF8kx1KCOf7jc33e72UB5fGv4j+zKWPp671sRAkxjADpWd54yhX1uDVx?=
 =?us-ascii?Q?N3PcRyNnC5YynbAd+16KK17fw6hNWCxZRygquZ9eVLfyKJW6rreak1wXOMkP?=
 =?us-ascii?Q?4DNpST4Hp8Ch2VXFsK39nwh+qWcFeNi0HnIBSKgS5ETY6cWnbYIuFVFHPdkO?=
 =?us-ascii?Q?18/JffimCkP7A2mCGg8b4QmSuWwKIIstfJdaw9Eos+s+pIon5nW/7yRESL6L?=
 =?us-ascii?Q?tTgAy6NBdyVCx4uglns620tBLiFxWAne3g67oWCpPhDTK4SI1fJXbVg01kGe?=
 =?us-ascii?Q?O2n4BqBnpxWrY1xnpOs+aUhg/lnwtpgs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 07:50:15.5490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd546da4-8949-4ba9-0a30-08dcbcfee699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

Use CPU to read registers in interrupt situation.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index d200310d1731..3659c2fa08b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -453,7 +453,7 @@ static bool gfxhub_v1_0_query_utcl2_poison_status(struct amdgpu_device *adev,
 		return false;
 
 	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	status = RREG32(hub->vm_l2_pro_fault_status);
+	status = RREG32_NO_KIQ(hub->vm_l2_pro_fault_status);
 	/* reset page fault status */
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 72109abe7c86..b36089d7f0e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -627,7 +627,7 @@ static bool gfxhub_v1_2_query_utcl2_poison_status(struct amdgpu_device *adev,
 {
 	u32 fed, status;
 
-	status = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regVM_L2_PROTECTION_FAULT_STATUS);
+	status = RREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regVM_L2_PROTECTION_FAULT_STATUS);
 	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
 	if (!amdgpu_sriov_vf(adev)) {
 		/* clear page fault status and address */
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 915203b91c5f..4f552846960b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -564,7 +564,7 @@ static bool mmhub_v1_8_query_utcl2_poison_status(struct amdgpu_device *adev,
 {
 	u32 fed, status;
 
-	status = RREG32_SOC15(MMHUB, hub_inst, regVM_L2_PROTECTION_FAULT_STATUS);
+	status = RREG32_SOC15_NO_KIQ(MMHUB, hub_inst, regVM_L2_PROTECTION_FAULT_STATUS);
 	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
 	if (!amdgpu_sriov_vf(adev)) {
 		/* clear page fault status and address */
-- 
2.34.1

