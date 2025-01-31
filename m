Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4202C0219F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3113B10E3EE;
	Fri, 31 Jan 2025 16:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Wk0L/ed";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6C610E3C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXzTLNBSB25/Mq/shu0qcJ38R2j8v8R0cHirCyL3dCx4dZIyrJ9xBiXGmk5UoJEIIwd4IM0f4WcpLIOue1LtIraA7MGM6vHZEvRin3B12Tw3ulISOE8LRXOcJKuHpt7opzbkrlqdSRQ8y9WyIjqBXVrmvB3UthCE6sAZ8hp4d5FX59t5nZwAYjPaJz6OnVXraRwCQ8jsmkd8rmfaMDq7Fns1xRE/gv1YWSgh8Aa0wBRN8NYoVMvXRqzo2+5I3bcaK25V414bN2mpHWPgcfcUHELMZ8HmU7foS6tczW+TPUleSrOVaR5yLwtAJe7KetIuXEKYnMhhBoom3VgbZCrcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pIxo+574ag79K1q6XrJOS1XXW9tigfvBQJZXFl1yqM=;
 b=NKX8FoAylZfHlWHdFSKtUUxqRe6Ni1EN5DVotKvkqqT+ZilyBQOrMscRE1MNfg1AoNzKerKIKbl/6xX6nk4X381YHvDSdsqj0MvFzlOYN+TsmCIditEHJqyYPxCgMLy2g1XOviuFS+yK0+r2D1mM4h9UFT52fi5khTuXdT2TrEkjHMZxLcaGEZZKEA9004UmgSN6exXB+GJ8OyYGUMQUzh+KUF4iPutIWObLbI0PmjDaXaQgnk3fu3Lo7IaX1mnoaJzs/WoUs8KCzWNW0BHxzhiZPLA0MJmiQJaSIC1Tqx7pQyW3RPnxaGQXU4dX6rusDoC0aQhW6kBZ1Q73B7YiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pIxo+574ag79K1q6XrJOS1XXW9tigfvBQJZXFl1yqM=;
 b=3Wk0L/edachk3A362NaO6S0Z2U1GEERLvghay3A8ZHYOeQrZjR8RP1DaEJau6KXRBXQgwS1eFJJ37pD6/jXXznC01uGKHZFfS+odwgDZFXnT2rBIhayhM0fvQcT7xWVAfSaPiSKZf+0Td9GI6Rq/+KskboKnLDoDPR+21eNDb8g=
Received: from DM6PR07CA0078.namprd07.prod.outlook.com (2603:10b6:5:337::11)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:15 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::64) by DM6PR07CA0078.outlook.office365.com
 (2603:10b6:5:337::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/44] drm/amdgpu/vcn4.0.3: convert internal functions to use
 vcn_inst
Date: Fri, 31 Jan 2025 11:57:13 -0500
Message-ID: <20250131165741.1798488-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: d265aad2-6513-4381-a97c-08dd42187435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9YmRiN4efqPnDxy3wqGSkByzBYpVXKf71/DxDH3dpwsSUzf5d7PsUDWrC617?=
 =?us-ascii?Q?Ib3ZGdPSQ1EDbPAp9mweK05hKYvvr3L0rkeIhyBnEpptIyfUmubPp6/T5Esm?=
 =?us-ascii?Q?WK0s4FnutkUyGAsFlJob09U8yWtI+RxYl2mqJAKODjZBsudAlmKc1KR9AEBe?=
 =?us-ascii?Q?g0MQo88n6OYJ8as2ku4R6yXVEMrCVhX/1z1tN0ppVmJg3yqJfxWR9zXNBJDj?=
 =?us-ascii?Q?TsVLbne+UFJjryheBslGR4syfkuL25w1k1mXaTtSAn0EMcmgB+ebAfIVRqGV?=
 =?us-ascii?Q?zlDsESf5rN/sI94l3ZtlG6qtHXvjESKh5Y7GInmsoCAgFzWokBllXiCQdTdf?=
 =?us-ascii?Q?HTQU+thHiStezcCICrEbR0eDuYJ+zPNBEHAKEiviwFJJ384glahqBx97XsvH?=
 =?us-ascii?Q?OQNyrNRnClPYXGJz9vK9eHxtiHvpN9LXLm0B796ggj1THjzpjlVQXrH4P+/0?=
 =?us-ascii?Q?8hrK3uAjNx95xEG+PYCvafyucOjprC1ROZAbQRbApH/iKE1lPtL3oioNy0cm?=
 =?us-ascii?Q?WOMoZZtzw531NLHaMbYFwxBZZLLaWUnqD0hDHexJ0Zx0onwhGsV77RZh1Zpb?=
 =?us-ascii?Q?aV/UkwlvJGl99d/0aaAFj/Qul+z5EWZ06zH7vIaSn/mXICJMd5Ct1yEQ6XNG?=
 =?us-ascii?Q?ZtqJFRDnkz9SGx3F0U5jFFpIyWZQ6fbUiVCGFiTWn8d58+2AIu6YHly0w2ZU?=
 =?us-ascii?Q?5mZgN2/TqYRs4aVAi7kyHfEtQIX0BVjzyxf3msN2xJRjoSe/lhAQNNfRFOKu?=
 =?us-ascii?Q?IUFHC0upiARiJiJfRiffiaVifuZY7ktqn2duok8DHgRdcHr9NGmj+CsHXYqk?=
 =?us-ascii?Q?nePip+XrwXA4xOvx8CLNR+wZVZh3h3znzHSPLMIM3FVnNezoNUyA4wxL5fQ9?=
 =?us-ascii?Q?Da0PY47xAcHKqd/pCUalp+47JUI0C7dQ+q2Yvprr9MT0uDRMS9TzW1CE3b6D?=
 =?us-ascii?Q?QasoKT2qazWS6dnCpkEwmPiRhqM4/iYdgqHnQMgqPReAoTY9lwBmcaf+v4rE?=
 =?us-ascii?Q?gsk8DW0lyAfHyz03VvA2Pg8bQyKU8zcjm4h3BUdkuu3M6PCKE+v061BR9JRi?=
 =?us-ascii?Q?lMKKAGYOQmIFAbbve586ziYEuTbExQC7SzyZjDSIyx8FRqSB/E3D7m5TjF6b?=
 =?us-ascii?Q?zpTBaFM2LQTfckPWBendTy8E/pFNhcyy2dfqVVYX+jQZUfMeFQrr+qM1OEXv?=
 =?us-ascii?Q?z4QdrsvzvS3CETd69NSPaF4k18iizg6QMs+Fo55qb0snP3G222BZ2VWOxxPo?=
 =?us-ascii?Q?cAxUnTkG9nnF1KSu57Ai8slZ+Nkh+ohulLdLmxYlPqdOrgrg+U87e19Ti+FS?=
 =?us-ascii?Q?82YqoFKcaLMgYpN9XQm1Re8uTHJXrFxTcIE9dIdCs28HycRTkASMcb4i1yOf?=
 =?us-ascii?Q?5m9xI7ngL2luPxv2BQXY6yzyqGG2+hLj16GwFjOvo1nd597Z+VFiMqOTfMWD?=
 =?us-ascii?Q?4x/rjZV4/OSGdt+ZUFOY49srAg+WAZ6jO3UihaeFYk9LS8HdWwlxaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:15.1706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d265aad2-6513-4381-a97c-08dd42187435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515
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

Pass the vcn instance structure to these functions rather
than adev and the instance number.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev->vcn.inst[].

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 93 ++++++++++++++-----------
 1 file changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 1407cb4b553b7..a3fbfaac76603 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -431,13 +431,14 @@ static int vcn_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v4_0_3_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v4_0_3_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t offset, size, vcn_inst;
 	const struct common_firmware_header *hdr;
 
@@ -505,14 +506,16 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v4_0_3_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Let the VCN memory controller know it's offsets with dpg mode
  */
-static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					  bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -619,13 +622,14 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 /**
  * vcn_v4_0_3_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t data;
 	int vcn_inst;
 
@@ -712,16 +716,18 @@ static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_device *adev, int inst
 /**
  * vcn_v4_0_3_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  * @sram_sel: sram select
- * @inst_idx: instance number index
  * @indirect: indirectly write sram
  *
  * Disable clock gating for VCN block with dpg mode
  */
-static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
-				int inst_idx, uint8_t indirect)
+static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+						     uint8_t sram_sel,
+						     uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t reg_data = 0;
 
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -763,13 +769,14 @@ static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v4_0_3_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t data;
 	int vcn_inst;
 
@@ -814,14 +821,16 @@ static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst_
 /**
  * vcn_v4_0_3_start_dpg_mode - VCN start with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Start VCN block with dpg mode
  */
-static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared =
 						adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
@@ -849,7 +858,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	}
 
 	/* enable clock gating */
-	vcn_v4_0_3_disable_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v4_0_3_disable_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -899,7 +908,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v4_0_3_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v4_0_3_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -1146,13 +1155,14 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
 /**
  * vcn_v4_0_3_start - VCN start
  *
- * @adev: amdgpu_device pointer
- * @i: instance to start
+ * @vinst: VCN instance
  *
  * Start VCN block
  */
-static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_3_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	int j, k, r, vcn_inst;
@@ -1162,7 +1172,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
 
 	vcn_inst = GET_INST(VCN, i);
 	/* set VCN status busy */
@@ -1171,7 +1181,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
 
 	/* SW clock gating */
-	vcn_v4_0_3_disable_clock_gating(adev, i);
+	vcn_v4_0_3_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
@@ -1225,7 +1235,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v4_0_3_mc_resume(adev, i);
+	vcn_v4_0_3_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
@@ -1319,13 +1329,14 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 /**
  * vcn_v4_0_3_stop_dpg_mode - VCN stop with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  *
  * Stop VCN block with dpg mode
  */
-static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t tmp;
 	int vcn_inst;
 
@@ -1351,13 +1362,14 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v4_0_3_stop - VCN stop
  *
- * @adev: amdgpu_device pointer
- * @i: instance to stop
+ * @vinst: VCN instance
  *
  * Stop VCN block
  */
-static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	int r = 0, vcn_inst;
 	uint32_t tmp;
@@ -1368,7 +1380,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
 	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v4_0_3_stop_dpg_mode(adev, i);
+		vcn_v4_0_3_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1425,7 +1437,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 
 	/* apply HW clock gating */
-	vcn_v4_0_3_enable_clock_gating(adev, i);
+	vcn_v4_0_3_enable_clock_gating(vinst);
 
 Done:
 	if (adev->pm.dpm_enabled)
@@ -1662,13 +1674,15 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (enable) {
 			if (RREG32_SOC15(VCN, GET_INST(VCN, i),
 					 regUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v4_0_3_enable_clock_gating(adev, i);
+			vcn_v4_0_3_enable_clock_gating(vinst);
 		} else {
-			vcn_v4_0_3_disable_clock_gating(adev, i);
+			vcn_v4_0_3_disable_clock_gating(vinst);
 		}
 	}
 	return 0;
@@ -1679,6 +1693,7 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -1694,9 +1709,9 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_3_stop(adev, i);
+		ret = vcn_v4_0_3_stop(vinst);
 	else
-		ret = vcn_v4_0_3_start(adev, i);
+		ret = vcn_v4_0_3_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst[i].cur_state = state;
-- 
2.48.1

