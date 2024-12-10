Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6BFE77183
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B0110E9E3;
	Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X16irja7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD6610E9D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfvBF+Fk1kHvfcjodME5As6NiiyZs+gOSFIdvH++Ama3UIOUSZ6zVaEfacuUWB4LXPooHzOl0CusbiMJZvrIdjd5X/+huwoTxrtURqOL6K4a5ByL0/BY1y+RDa9UVnlC4RquOkX7brnCtAw7WyhAzocj1O5qr4DMq3Ayl26ypoeMkp9Bh6WxC4t89vH+LxDTlkBE0mwk3QS4viWuv9mTnmzk/hgeWZA0Qcj3IQNBx0f8kGfyeWuVWI+ja8w8oxvTzz7v5gVokEwGceLq9oPHwAXf5loK9G3l5h6IYkwEA2k1PyhH/SoA6ikhDK7aKblfDCF6yoNfSlfk/E7dzx1jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MDhdRpnyuDcDzfZDUJg0DrMwQfzQ62Pj9exQ8xZPhE=;
 b=mnQ27NSbawzHpVpzc6Q6ZsE/3mS668Huog7iXYlqFvJt2UaA9fwYHBQE8ikpQb1qtqoqlnqh46uaenXv3BvLSqxLkHapYOkVvUFtOtVwbhzNw5C4I1IKxmrnRl9n2Yn/iJFewPmwXSlZbZbYpC1MVljGlaAA+wti8GWgQBxfoA0DguZljqys4xdaZ/NdF8pakZpxaYgzQu8h12W6QVA35rvp1bVnBx0VhSR2NKWJWabqSgRkxGBzvNBN7VZR4CviBMkIExlllVrrOPDJhxBUxRAWrXd4J/MmmSUUCOiDifMCO/qv/oG4WsAhjeot1nnehhloLwHn4+HA2BzcQM0Kaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MDhdRpnyuDcDzfZDUJg0DrMwQfzQ62Pj9exQ8xZPhE=;
 b=X16irja7Ly7MJj2ZZFpKeTmzuptVApZw/OLF87eYuY7yizIeo2BCdgMBebioUjg/BZ8536XsHKFMCfwpfp/juXYNb/4DyspcQ8SQijtCl3XtjAMWqwon1J8AoCUOPzuboKiLEigOhH+CeD1DL7ZLDksj84wuZm2FmT3iURVz5p0=
Received: from MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) by
 SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 10 Dec
 2024 22:54:05 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::71) by MN2PR01CA0024.outlook.office365.com
 (2603:10b6:208:10c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Tue,
 10 Dec 2024 22:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/48] drm/amdgpu/vcn4.0.3: convert internal functions to use
 vcn_inst
Date: Tue, 10 Dec 2024 17:53:06 -0500
Message-ID: <20241210225337.75394-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 76eae56f-9023-47de-5fbe-08dd196d8c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RVi7T41lVMyWpUjf4qRZXDkwo2ooxVp5jheew+1esRBon78F4T8hgZsbll9G?=
 =?us-ascii?Q?4ufXWSrJ3q05L3OkASBX+gJ+zRpBAwQ4KsKNvy3+fs0reTLitMdwaeBXC3Bb?=
 =?us-ascii?Q?2D1dyFmI9QXD9k76yjOR3maoeP7J+cd+5Aeu/IrMcR+wThOIdTWRcwM7+n/T?=
 =?us-ascii?Q?XPaOacMr7ya7dhIP7yA5khBBiptNodxa3zGY78CnL9jjAa+Ubjli8w0JRgBK?=
 =?us-ascii?Q?c8xcAtpX0fKgVlpIOBthjAhWd0rgyQtGwIrVSUmshy18gYWQ8EjobBdy0KKk?=
 =?us-ascii?Q?bvbjbJWOWdYJaQ5L7CdIC3+Cs/mkuKhP+0ZyRlO0mvk+9xPou7o896JrIKLs?=
 =?us-ascii?Q?xlrYjn/WRQ77q/stTRSDXKyjYWy/diOFKzTOlvKBbXdu/ZTa7pyX05Rz8MGE?=
 =?us-ascii?Q?U5lX/rSwq2CScTT9/J3/u+cjVN9B0ZlXbhdIdm+e7ok2X71WJSBGhcaIUVHK?=
 =?us-ascii?Q?UK8cVN5uOso9w3iYTG9T4V/lJ1xu24DHN33j8JHU6avrQyRYXp52IL8PTMGA?=
 =?us-ascii?Q?BJ3j/MbmpQBh87gVhSoUwKlqmd3V6OXCOzFXeGMBsDDqsUNpdZ63HZv6h8YQ?=
 =?us-ascii?Q?tJFTCjHsz4MBrIpcxI0Xy15mr8Rmm8RERgunE2+4Uy4y4ZKzg4s+ttMvsJQI?=
 =?us-ascii?Q?UavAVo/lD0gL4VtTn96RhsV50NBI4WumhHWlIiB0mqLDs/EQp4enqTZPhq/4?=
 =?us-ascii?Q?NAKV5Z9ORzNKm7nIOIVtxkp2MRECpGiT2EU6ejIkAD7+8R0Hf8MRuXwJnwBh?=
 =?us-ascii?Q?iT6gJY9PNyLsmiKmFQAjpk3k5ZHAo3AmbtmTGxswXwjR0VJs6lP9Sl1am/5u?=
 =?us-ascii?Q?m6pb0OaOCmE9rEDEJw3nIcwBIGrtG08T8Vs2s/mmqoF68vTs6iLsDpMMTSdg?=
 =?us-ascii?Q?mGESqAWOzrax97M8qZJiCHgyfduviJd6r+udB5DJX46/J4PDMV4dkPIPwNMO?=
 =?us-ascii?Q?Cu45oMh69vSfuMNRkT4qa8KOAnRw5ZyZ+ecLs59lTtgbEaJU0HJgTkGG+VAH?=
 =?us-ascii?Q?tMD74XV6bQOm/J7JIb8rbfb5Vzn1WQRn8vYrhvALH5RKCbCs7yZuibWopYpq?=
 =?us-ascii?Q?aam9+oOUvIZHVFXrA+jf8Uyb0Nkxozv4bp59+4vu0AzztcLSNjn0y9dTGbhK?=
 =?us-ascii?Q?O82qjqPUIbD/gy8JYxAtpq3rdY7At6oqEtUz1CcHHhOfV/FsDkxkXZYxWeeY?=
 =?us-ascii?Q?x0kpNRJ6USZSe4TKZkaF3691yZRkb7z56CBJGxhLBN4SDQMfW5FtNWkWaO0q?=
 =?us-ascii?Q?+9mDak2JlOWBRrYKsWUTohCzBVKsRdi38TrSWpX0MhStvNNXtJ0fPp5HoDmb?=
 =?us-ascii?Q?gDAYTNeLvbz5YKItE/e5sDrgJkcR3J2zyV1UxJZKE+zy6pGn4hsBoYQfF6MZ?=
 =?us-ascii?Q?ZL1ZgEsYqTObfNOvHP1OgrJzzi7euF0DSu21WeakOrFhXcoxxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:05.3764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eae56f-9023-47de-5fbe-08dd196d8c6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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
index 3378dcd5ea545..2562b25710b5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -427,13 +427,14 @@ static int vcn_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
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
 
@@ -501,14 +502,16 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
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
 
@@ -615,13 +618,14 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
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
 
@@ -708,16 +712,18 @@ static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_device *adev, int inst
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
@@ -759,13 +765,14 @@ static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
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
 
@@ -810,14 +817,16 @@ static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst_
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
@@ -845,7 +854,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	}
 
 	/* enable clock gating */
-	vcn_v4_0_3_disable_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v4_0_3_disable_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -895,7 +904,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v4_0_3_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v4_0_3_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -1140,13 +1149,14 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
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
@@ -1156,7 +1166,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
 
 	vcn_inst = GET_INST(VCN, i);
 	/* set VCN status busy */
@@ -1165,7 +1175,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
 
 	/* SW clock gating */
-	vcn_v4_0_3_disable_clock_gating(adev, i);
+	vcn_v4_0_3_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
@@ -1219,7 +1229,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v4_0_3_mc_resume(adev, i);
+	vcn_v4_0_3_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
@@ -1313,13 +1323,14 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
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
 
@@ -1345,13 +1356,14 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
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
@@ -1362,7 +1374,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
 	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v4_0_3_stop_dpg_mode(adev, i);
+		vcn_v4_0_3_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1419,7 +1431,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 
 	/* apply HW clock gating */
-	vcn_v4_0_3_enable_clock_gating(adev, i);
+	vcn_v4_0_3_enable_clock_gating(vinst);
 
 Done:
 	if (adev->pm.dpm_enabled)
@@ -1656,13 +1668,15 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
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
@@ -1673,6 +1687,7 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -1688,9 +1703,9 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
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
2.47.1

