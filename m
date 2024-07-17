Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9059C3DA62
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A13E10E426;
	Wed, 17 Jul 2024 20:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ltDCnz82";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F60E10E41C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXS9SnOExjTNJf2tlpHiheI+WYqo1L0nM1TVouLTor8hm9svriWyMo+iFvHZb9KNMPaVp4VeUHJA/Lmvsp/9Ne/qjYgggXeoYriJJgwxzI97C7h07kSQ0ArjYbZl6nJaF0Y0z+pQtYDOshtBUHydZc/f4rP4JIr26yuzmIajcqOhdumtILE5WMSqvU4puNSEi9owXrH3/7zwUCcuFlgK0TBGw+NjUU5JATPEZ8T5JG7K6PlR/ULUKkt5bE45tO18h/GbrS7UTdmcpufhMvpmSuiSyYZQTJtfhyCl7e2uyBSedwqk4Y0eLzLcT8+ZNnlataJFYbhPWPvo9u0SGdvV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UafUG/LVqm5O6TRLhm19ngzbcl0uViHnsz1xw/3UbOU=;
 b=e4Tc1eoFN/rB6vwDt5R40TINr9+XWocE+2CVgLlB7D53QOpUPw4mtPG/BF2pMPs1DCUPsgAtMwGnKRPxH4VHZLP6PbUp5LAnazJlCsM3FJfkJONcKbGz05yEoLd/Dmz4WMK4WVJiPvGM+FWgD16ddRfDpSOnaafn6nZ4Oyc+k+ZQMrJ9O1Fs3ZsrnSe2MXROsqR9iCpV1a0+iXV88kFg/nKBhjcfBgYmM6geNy7QhRTzXu3Ieh2K4ajg5Lfg8+1DsEjUFQyeK3oOlYqPHqfyfgLss1oJFPg5YHxWAxm0kpZNvgh+e+zwA+RS9eADFpL5zYWL0/WQ56mFndeT7Eo8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UafUG/LVqm5O6TRLhm19ngzbcl0uViHnsz1xw/3UbOU=;
 b=ltDCnz82sRVYf4Wiiha7vdnCOBRxyBmH+zvHVxKYkUr1JgwoKgg94aSZdFlnKGg48UM8JwDEDCDhG9wiQ7dQ83k+RT51e5KLB6ZjIgk1/tR068EpvD6NycJRoewlOnLpC1s8QhDdY7x2qr+8k7jbRYs43jq/QEcAJkU5lPlda+w=
Received: from BN0PR02CA0039.namprd02.prod.outlook.com (2603:10b6:408:e5::14)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 20:39:08 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::fd) by BN0PR02CA0039.outlook.office365.com
 (2603:10b6:408:e5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 20:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 20:39:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:39:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/gfx10: properly handle error ints on all pipes
Date: Wed, 17 Jul 2024 16:38:44 -0400
Message-ID: <20240717203847.14600-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: d319c41d-d0b3-4225-4cc5-08dca6a08170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Nw+a87eLtpvltBstLCqR4frR6p1aXBY8Gea2O7pUGRTGwKm/A2Yc4B1Y8Bk?=
 =?us-ascii?Q?ktDV/ZEH5nrUWKDS38f9ZbOrPHnPWOfXxdl1tA614kE9qWpdGvwphSRu4zAS?=
 =?us-ascii?Q?yjg5IqT26eRHnXvl+o4tNb/YQa9166OClaSIz00mREux8zn2BQEMPdn4AKp/?=
 =?us-ascii?Q?bvoR6gs3lMx7vZzN1DDVdVz87YeUlXhGM+GN3Ocr27nJGQ1JhHxdzcJum4Fr?=
 =?us-ascii?Q?CKrNL1SpBFEHKEHjgkWRAKUpdjjjqekK2mtD4rZd5Xp041Lb+gyo8VnDPeIf?=
 =?us-ascii?Q?npmsjK26O+Nl+qLnd4Uah09m5G2V+2F8aQ33hE85jI0d15EWx+Fe+U/9VE/A?=
 =?us-ascii?Q?hAKwJSDMlKGS1rJd+dwNOfskjCESl4TkwrRGmnqgBc24nX7+3tCmJzSvGe0f?=
 =?us-ascii?Q?efOpzOOGnCpqSDG55EmvPVtXTVqoBzIQ85sEqxpENOAtKmKiXbnf5V2wbPmt?=
 =?us-ascii?Q?S/2A33NRNndGOHXxQvamCQn2556mTvZVuNLxKMwGN798FQ9/GGJbiUFHC7Mt?=
 =?us-ascii?Q?gVV+JkuILfIdvyr7I4sUBHGYLwyr2k1oYjLhhZyJGbXxTTMJYez5W825sqC7?=
 =?us-ascii?Q?+I0PgezpiNLcfO3SKoMHYl3GU7xqCSdoSi8YVKCQqB6+9+NOyiqZSSHIiggH?=
 =?us-ascii?Q?arXWJKFeJs/zDxZKT+UYLKyowneyLDA3TmSuJ1EosyG1coYZtcafosm5P1NN?=
 =?us-ascii?Q?r2qOf6CUMGEsqz4cpjXmo88y97j0R/NJWA5yIhSRgUXCYQWNyU6FNGvxEVNL?=
 =?us-ascii?Q?3jmVk3N+voYnjQwd1dd6FyeIc3nKbhsftqHvxy3kVlvMH6eSiHzrQJ0iGLIo?=
 =?us-ascii?Q?Ndmaxpp3btxTz5cZfbenVqp8atXmJgSM1kKHE3/k8O+hTGtazTXMAVpNvZOL?=
 =?us-ascii?Q?U88NYd0i92eic1oUQ73f0HhKwweYTEQqVRarXMKdR3vU7CabEcYqopw0DrLG?=
 =?us-ascii?Q?klZAEIanbOyo4o96Y82rQ0MwqG+0mv+urm+SA0T3eup15qaD3wTCQ+zt6NiM?=
 =?us-ascii?Q?s/uQ9K4sMWDvEFY9SQG0ariQNVOlCEUwixUz7tZs/ruIjqARS2REsfveJQGU?=
 =?us-ascii?Q?kWg1uYu/xets5t9ub87XSQIAbntKj+t+Vh2IW0pDK1PPWZd02e+K9VKVwIkr?=
 =?us-ascii?Q?Q/lSDNFlY+Db54N60qUL5HTsmbRidfo/AXAGPq4bOVp1WUcHWCAakdRYsioH?=
 =?us-ascii?Q?eBT5uXi2eP1yupZVFfv33SObQ2GqDZWhWJ7w2uw96bxJ57QkPgjVRQQ6NP0s?=
 =?us-ascii?Q?b7A6Ag+YjqgBcxmYx68Jwmw3wewt9pvSBTn48ZzxTcoQQoIDqashS3KkCVMM?=
 =?us-ascii?Q?hVu7cCXYlZfV26Q1kiBsGPd6ocAFyTusDls7aRD483Ww2mwq4y2ZgW4zEMql?=
 =?us-ascii?Q?djqWfboBRX5DqdRyTcqT6kYgZjreghwI2s509Zj5xarUd3Akf7S0PJRw+sTv?=
 =?us-ascii?Q?duF0MxW0mx+2DImw69QUYGiuX6ff5vSL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:39:07.5741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d319c41d-d0b3-4225-4cc5-08dca6a08170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
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

Need to handle the interrupt enables for all pipes.

v2: fix indexing (Jessie)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 130 +++++++++++++++++++++----
 1 file changed, 109 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c4002db6e569..66d80f3dc661 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5212,26 +5212,74 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 
 }
 
+static u32 gfx_v10_0_get_cpg_int_cntl(struct amdgpu_device *adev,
+				      int me, int pipe)
+{
+	if (me != 0)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_INT_CNTL_RING0);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_INT_CNTL_RING1);
+	default:
+		return 0;
+	}
+}
+
+static u32 gfx_v10_0_get_cpc_int_cntl(struct amdgpu_device *adev,
+				      int me, int pipe)
+{
+	/*
+	 * amdgpu controls only the first MEC. That's why this function only
+	 * handles the setting of interrupts for this specific MEC. All other
+	 * pipes' interrupts are set by amdkfd.
+	 */
+	if (me != 1)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE1_INT_CNTL);
+	case 2:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE2_INT_CNTL);
+	case 3:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE3_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 					       bool enable)
 {
-	u32 tmp;
+	u32 tmp, cp_int_cntl_reg;
+	int i, j;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
-
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE,
-			    enable ? 1 : 0);
-
-	WREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0, tmp);
+	for (i = 0; i < adev->gfx.me.num_me; i++) {
+		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+			cp_int_cntl_reg = gfx_v10_0_get_cpg_int_cntl(adev, i, j);
+
+			if (cp_int_cntl_reg) {
+				tmp = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE,
+						    enable ? 1 : 0);
+				WREG32_SOC15_IP(GC, cp_int_cntl_reg, tmp);
+			}
+		}
+	}
 }
 
 static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
@@ -9073,12 +9121,39 @@ static int gfx_v10_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					      unsigned int type,
 					      enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
-			       PRIV_REG_INT_ENABLE,
-			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+				cp_int_cntl_reg = gfx_v10_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v10_0_get_cpc_int_cntl(adev, i + 1, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
 		break;
 	default:
 		break;
@@ -9092,12 +9167,25 @@ static int gfx_v10_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					       unsigned int type,
 					       enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
-			       PRIV_INSTR_INT_ENABLE,
-			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+				cp_int_cntl_reg = gfx_v10_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    PRIV_INSTR_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
 		break;
 	default:
 		break;
@@ -9121,8 +9209,8 @@ static void gfx_v10_0_handle_priv_fault(struct amdgpu_device *adev,
 	case 0:
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
-			/* we only enabled 1 gfx queue per pipe for now */
-			if (ring->me == me_id && ring->pipe == pipe_id)
+			if (ring->me == me_id && ring->pipe == pipe_id &&
+			    ring->queue == queue_id)
 				drm_sched_fault(&ring->sched);
 		}
 		break;
-- 
2.45.2

