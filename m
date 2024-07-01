Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686DCC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 21:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FA910E4E9;
	Mon,  1 Jul 2024 21:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h5mG4orF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC3E10E45B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 21:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TD4AuKF5Mav+kEhl8Bsw3tPwu+XtGiANulAdI+6cHUN/w3pnUg/ZuWGtmdJ6wGV2A+LLDfX8cBBYrxcrGvLK0ozJp73UmoCGUzSogReek5HS9X3EBJRTMM1Hjx9OvKZemI9k2oVIZ8QlcRVCKH1qiSjOZIXD7CPdefslql0OP6aOMgOYmAFyFInxESLxwXDcgD4WkTy8WrX16Fg1zAx6qsHuYTQX1riC32+6Dl3dGPFsiyb1mjsy25ppcTeZNLJC9woLSfdBPJ6uFd4ow7U6NeAMLeHvigl/AE8hO8M72Iriys7ljhJY0ySavVXBVO5YdcqOPgHgoBT89fPNd0S5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETJJto6ZVHLdy3hkk1dCbgKq3RAB31hvbt761cTgf7w=;
 b=bg+iYPK38n/rTgQC7r/3CXyvTFdv11ey6xjZCGYk8g4YDHRjqI6ZvApSYNWS5lSSKoapSlhzKbSFxLZgyT9hOFr6FWHA2Rc/vixbSQo2HcKZ08JX4OR1Qf5gPWIGgEqoupAI64/kYLhCJI4TtLUE3tJZBBbvSeRDzEu93DCageT0z0H0pEMcCsQZ4PA4bYTNVNWDMiqt4iQEDbMWiVirNpDcOtWAIBaqEqQXxXbH60NpQHYGrQpmL/3aDWUruhcqRkIrJZ/dZcwckashhnNBQLfNJzl9Fpp7rgDQtsgXltHqxHSHjXcYCK5SSWBMB0lWi6ohwwscd52x7TafNVzxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETJJto6ZVHLdy3hkk1dCbgKq3RAB31hvbt761cTgf7w=;
 b=h5mG4orFTrTXysLZfc7ILZp7zlKdtTkKB+RoOf/IOv27esq44A8YH4jLb0B5cu6f9A5LYOrXgwfw+kFq5RlACXZsp7iCkqAn/wh7oErJoYtK+O86AgSFa46OvOUwVOKa/lJYA5Bz3x1D3X/qiPZ61xq1on46AaDvCnOKuWlaZR8=
Received: from SJ0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:a03:39e::20)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 21:31:44 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::fd) by SJ0PR03CA0285.outlook.office365.com
 (2603:10b6:a03:39e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 21:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 21:31:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 16:31:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/gfx10: properly handle error ints on all pipes
Date: Mon, 1 Jul 2024 17:31:26 -0400
Message-ID: <20240701213128.7596-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bf4d2d-7053-4448-5410-08dc9a153421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fjj3YFPP1mtGzswrZxAb8WssWV/Z2FsrfT94HRYjdBfhM+7paX4bvdAhaYAe?=
 =?us-ascii?Q?8izxDzW/lAicPG4uB0mG+nHxGvUyIi7qvLrEyyfobepmz8he8etqM8oNbmLm?=
 =?us-ascii?Q?vE0zLbOO86lODMPIYCnJr3n0SQlj7bwkFzLlFwlbcjrBeMeY1+98dYZkCC4i?=
 =?us-ascii?Q?HzEGUdx8QxZDYh+DlnEEWFomguIjB5n9k+TJIz6VEtn/ZLDLMxGeyt+0HTDI?=
 =?us-ascii?Q?lqmgPEClRwfKLus+4OnZdPups1EuUrri1OTQZ9bqm181482bsxvxi7jtyXMf?=
 =?us-ascii?Q?Iqu5rVzd9TNtQKDNotZ86hIsrwUBsHEdvpIBHvpUqJ7U+ojz+TfLAqMqng+I?=
 =?us-ascii?Q?4yEqZM7aYPpNS+Jv/ylcs3EoiQJRF1OkoeIpUhns/y1WfKd8d3ugfu2zmUg/?=
 =?us-ascii?Q?iq9aDmgE9iAc/gy1tj6OXopjBmyKG6sr+AWEsPs9qL8qgw/SeR3tDuxttOLO?=
 =?us-ascii?Q?CO9t38h91h5Np1pU5XQnE8tvBOQOGSv3uscUrwOxKtyxtCFuG2W+CbXFvTZR?=
 =?us-ascii?Q?8W24LBckKjsdPGtBbZThzDIUUXukap4T+mPUYPgRMG0eGDwSuJfB3+ik173T?=
 =?us-ascii?Q?wlFuwSZ7zD1MM53sxztujZsBzsmJGouerFxwpZJINKF9vrYyTnr3aJya8FNZ?=
 =?us-ascii?Q?QeWoVzYKZ3BG7jCd89hb2/+wfL3Ex4AhBxktXjHRp1tgWDUsLI8C9K8R62oE?=
 =?us-ascii?Q?pbbRLw+8kbLIZrVuGR7MNXlbrpbQU3tSBAjgY1ReUeEHKy2BWrwnPuDCxm5R?=
 =?us-ascii?Q?5G/DxX6wlPTppDVoYiO6j29uiP8BojrAg4F70awnyjY6EtrL4j40Lrn7OxJa?=
 =?us-ascii?Q?cibjQBvhOAXHQg5Ieca5WZGXfFZZI004kYqsCzcYAcGUnBkRV61TvzpEF01O?=
 =?us-ascii?Q?rvoVaylYW4P5apcKxXb81EIzaQtBQYCjeKg7oOIaF5jiPzKgEIKCAk1341+a?=
 =?us-ascii?Q?L1CHoOxPZ04KPe4BZ5OLJy1MRVo5tLMTKVLOBV7SdS86OdoAsx+toA3Gh8Tw?=
 =?us-ascii?Q?Swa/+e4aiWl1MplC71P+fKu5jZ/PcZByaVl1ksWPxdvvYRHpyuWc9HyU7bX0?=
 =?us-ascii?Q?xjKDXGyVfYTC6U8c+qxlmHbEeXTgvDB8UCGz2Q2ydYRC5EfhMndC9//kqtlY?=
 =?us-ascii?Q?a1B0I1vzcZW1J56bvgEpCJ99DWy+u3TWLztuCdHxsnsLBqxY8dSLa+oz8WrK?=
 =?us-ascii?Q?pbNQsgdrcAssfGZ5ng+umWewWHDO8kkChR/ML4eiXSJanWh18rTQz3A++5/r?=
 =?us-ascii?Q?HfcI7agp34+fjiUh6EnsF7dMs6bnBhHBGQZwJZSdU8+Tj78gS7qcCyaANs8+?=
 =?us-ascii?Q?F7cbe2nOdhoISA9s9aq3j19xNJ+E8/q574hR+FeXbqzemxMk8hHezXnC1+ln?=
 =?us-ascii?Q?ctvKNMqXpHA5EsOWhen1fFT3x9A3uH+qIexvgDcrmbqoE8iwYDroGOWFk5i9?=
 =?us-ascii?Q?WZR1hZSziW4SXC4+ZlqFxsJSDnvYHj/Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 21:31:43.7951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bf4d2d-7053-4448-5410-08dc9a153421
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 130 +++++++++++++++++++++----
 1 file changed, 109 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6c3fa707e20b..eb74e1975cab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5269,26 +5269,74 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 
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
+		for (i = 0; i < adev->gfx.me.num_pipe_per_me; i++) {
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
@@ -9134,12 +9182,39 @@ static int gfx_v10_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
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
+			for (i = 0; i < adev->gfx.me.num_pipe_per_me; i++) {
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
+			for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
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
@@ -9153,12 +9228,25 @@ static int gfx_v10_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
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
+			for (i = 0; i < adev->gfx.me.num_pipe_per_me; i++) {
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
@@ -9182,8 +9270,8 @@ static void gfx_v10_0_handle_priv_fault(struct amdgpu_device *adev,
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

