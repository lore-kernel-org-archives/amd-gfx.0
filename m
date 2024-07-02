Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740B0C3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 14:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D3110E05B;
	Tue,  2 Jul 2024 14:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r/BIXZQK";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AC910E05B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 14:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgdJ83qOEQQ7nJU/3pTgQuB/lOOh4JJlni9IHei0U/kSTFnRir8hn+zpC39PZFUEgRomX3IAG20q0y0DoFerfgcPI90p9fG/sBB2GIqyi5h9p4jLSkbTK2ERpuaIyhBh+eAlbR8QU/W4yBL/OjzmZBSjFFv4RMJE2vPaKrv9PWulVL77vZK3iZUCVzUdo9n5RnJBF2rM9h4oRT3Y4T7Ko+uUWkt20ElDIrXdYDUbI9c4jKD5gK8nVW/g9pXVXGjgK0bQzXazISOPvjPGFawelOKfcOAc3UQ8rddTBm3st8/nMR16ZEjUkCKi32TnsOXSYc3PXsnNIQrp2mivOWtUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOdgay7SM6xiEUKAT7EyLIRJCqkbMwH3928fGa87uVE=;
 b=crIna3xiks/sE5mH5rx1NuGxGPcjTnAZjiGiLqLFUBhYTLUH5ThYYDPP6FMYaDp+xahjBej+8UbDKbv8nQJITyH7nO6m8WDQWBSVjObI640NzHz2Qx9VHOD4120f+wzh2VrQWwN1uC1utkTlrqfq+AI1DRUGjjDmiSh3J/5m4J5MGCWiV45bVP3Wd6pF/G955UlXPQsCt+pZly5yKApZ7xu78K/5j3cAgkUtE0iDoR4u87XjRDX1Wl2smsUG22Yt2BljqbOfziUYzF45YApnJA+KTNxZVg82inCuc0GMnmf4ArRRBLHA8gAIm7S663b9zFe38LG4Ar9qHHjFI6j0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOdgay7SM6xiEUKAT7EyLIRJCqkbMwH3928fGa87uVE=;
 b=r/BIXZQKDKQM+y9W1g5naG5eEQCzXej0FuKl1TkZDy6/L6agAQOt+Q1G24rR1ZM3K6Fp4UbmINEjZCo2iNz2k6wRpKznBsnRU+P7ynljALxhKFDso+/6yhbUHUI2Bjjjp8yfxck1IPKYk3pV2EqCgw4DWBpde2RM/JKMY0LftRI=
Received: from SA9PR10CA0025.namprd10.prod.outlook.com (2603:10b6:806:a7::30)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 2 Jul
 2024 14:28:46 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::d1) by SA9PR10CA0025.outlook.office365.com
 (2603:10b6:806:a7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Tue, 2 Jul 2024 14:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 14:28:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 09:28:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/gfx10: properly handle error ints on all pipes
Date: Tue, 2 Jul 2024 10:28:25 -0400
Message-ID: <20240702142829.705019-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0adca7-26d6-4e3c-2757-08dc9aa34827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cr6RouQEFAq0YLiuCpBb8SUqi9COvAA2LaFor1qOrS9twD7FnQCbOQ2uX9gp?=
 =?us-ascii?Q?W8YrMQmaETF0rG1qmGzTsbmI7eSQrCIPSkIbOowXadiQR0rcCOjiVI0t9d+U?=
 =?us-ascii?Q?SXZpIS/Vg60IbaevQNYwr+ysmy1j1Pmk+LmbUqkiUPUqj4mg5YagDoQhgdG5?=
 =?us-ascii?Q?tiCgnV5OcWHBzO10HNBdENviFjQduA5WeymB1YOFraTCPZrtjFam++Ce3+cU?=
 =?us-ascii?Q?EP5+HOVI63BL6ijO53YXDBtiTg3Kd1MGeMMQGaODmoixp2bNzj9dhUC4OCzZ?=
 =?us-ascii?Q?32jXGPBNY7t7x8GmAmpCvXCseErNL6e8wIXVpoteIF/P/mAAuuOZhxFowAEi?=
 =?us-ascii?Q?lyLgWQ+G4DB2q+8bKXb1c1QsF5Sfh+e1+oO56YJlNAx1AYEE6gZBmx6/nsM7?=
 =?us-ascii?Q?+CoXCDw8+y5XSr+9e3HnNWc98XsgLuP2PQPBxi0hQs7niVW+8bQlzpuW+LcQ?=
 =?us-ascii?Q?8+ucJNojdosegxPOeWDr2oI+unIv3G6XAxGGZsOE1aIvh8EwXBQrza9cO7vG?=
 =?us-ascii?Q?YVSVT1JFc8RCQQCfh7Pw1yqx4vvbVsbgkXCkqJr3qHaWsyb4lvqQ9ggUfyj1?=
 =?us-ascii?Q?nG5scE1grah37KIzXm4rILOu/ji+0d7WkqeeTJKKBMQ5aqUIKoHz4ZzutTDh?=
 =?us-ascii?Q?4WoKidPaAwAGXTN1hFE8L1lM3JIU2yaIxtB8eiEeg/k/oWhqXFo6PgAPOaZl?=
 =?us-ascii?Q?eeKfQIIDOUppy3p3xM8nvto1cmQB2szY1wgDh5+ZtsGiVTqPvWCwPY8eUeup?=
 =?us-ascii?Q?ca+Gcvb4KkGBheALrqw0JumXBFDUUloDjWGIwvPAZdnfEf/7fEjzprsZXn5/?=
 =?us-ascii?Q?qSVqofBYxSy5zNVG4PeN5mI8OH9BUTu7pD6jDZrGJz+xK+15YW38RvHT1jAT?=
 =?us-ascii?Q?X+sS9jrxepTcNKOUxpFpjGeJBi+GM1HAtogF8DQ/5lEP+ZUHobSt9LmTR5Y7?=
 =?us-ascii?Q?KjFNwhFEdwYjpaouAWGxrpUxVK0qFv3KmVCkQokwQK7tG7yjr299NhzCqVfK?=
 =?us-ascii?Q?YRBJTiqQr38YblT94LoMVlpvP4k9hH6EjHTtj3XH7qYDGrbZ13oEjIEkwcCc?=
 =?us-ascii?Q?ZbHRthYVPR0pULcKqiW08ZhQ2n9dznQ/nJ/IPyYzSH87idNVkGbBOY+TR06y?=
 =?us-ascii?Q?7d6C8+WTC9kVUbL0mQWCD2Dp6W1R5bSoz2zBLKgl40ZWESv+xyn3Eb8ZPsbj?=
 =?us-ascii?Q?G41ZJUn82vTVgRFRyHXCNymJ9Xk8ib0RELvFuYB0r8EVJmd4DfZtaDwuG03W?=
 =?us-ascii?Q?0Or9U+qoHhZqyITIABgqiGHc69vQe3973th/1XfcTtfqFC2MoVc6XwyWSrUl?=
 =?us-ascii?Q?j4JSyS0cwcGWxrpvBtxKYgrpRVrR9Y4cf5iMzM3ZnhUNhZGOsfJNpZTGso6f?=
 =?us-ascii?Q?CNjD2BJ92WnDRLkYUdDNWqYdlSVV2e+whZJP3AKjLIyfFv23Mbj4QsEpitrl?=
 =?us-ascii?Q?4965iA4qxwh+cw/8KZCdaLN0dPVJXY6e?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 14:28:45.9390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0adca7-26d6-4e3c-2757-08dc9aa34827
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
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
index 6c3fa707e20b..3525cc72a137 100644
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

