Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58659E77187
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AA910E9E1;
	Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vm+TFTfV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD91810E9D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QC+sI6IqRKbniqc85sXYgGeJiasx8onY4E8tNJd9HnMYb/OrqPg62JQ8/ctMejP3Mb25h2pniaCwuqfjJaT9htZMngIyF0D/WFKvzTBrSziW5zZDrvz+0eVCx/DKB7wQgzj4RmWEYlEdOoLS3FckeLdzfaHgf/Sb2OD6/VDvmaERxJSMVak9/E4CNdByj11K9aRgeKz/09rX/MTSrMQinZLx13IvsuNjJ4xKYgPTVPsGByr6olBV7v44Ulk392gPj+BPOVf8p/YeIIJFkJoZSuZ2P3KVJgHcig8n+nOptjj9IHGr27x4cmmB2MJIdVj2pVhlav9Y0fuhNGoTUwLFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PfVzddTHDq/rLJniphsxfTfE84lQ6pPVPowePmhF7M=;
 b=FYpaY9pQKVLasYKHVpeQTHo0VSkZXgvC5Xo+0rtgLYb/Mb3e7DvtdsUdRkst09r835sW2mb0/NOJ02anqh2brFHz5Gvby+NxO6xHNDNLh+dS0ru7zCeLOKNflBruejuglLRBTfLL3gC/zwe3D/dzc+DWUIU7NTExv144fhg6dQD1bGPbuD6uIFXSeQU7c5uJ6OFRAFGZO9br+2Z8rO2VM0lmcD8pex52LdoMl2Ugtk8NY6Exduc1ggNmmnxiX13EzRzyNt0MkrXvunAn3cBI3cwi+gRZcDyxjN3xWHOX5URwCReXnKlTmm5wUHcnxfprRXzcVc3MtVkhpotJZLS24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PfVzddTHDq/rLJniphsxfTfE84lQ6pPVPowePmhF7M=;
 b=vm+TFTfVuKLiapqustIunL/RQBCsyemmhDrGql097aa+owsRxbmtwH3m+XQUP05RTjnbkJcahwdhXNjg0YxJOQg+PTR1aEfVENPiwbtxezIAGo32T8kM8V7/S4ZrmJDSbZusdBXZd2pI462wkxHI6P++EVBm/J2qPSwmVCC+shI=
Received: from BN9PR03CA0214.namprd03.prod.outlook.com (2603:10b6:408:f8::9)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 22:54:04 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::66) by BN9PR03CA0214.outlook.office365.com
 (2603:10b6:408:f8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 10 Dec 2024 22:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/48] drm/amdgpu/vcn2.5: convert internal functions to use
 vcn_inst
Date: Tue, 10 Dec 2024 17:53:04 -0500
Message-ID: <20241210225337.75394-16-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc866de-c226-447e-e508-08dd196d8bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yXVtk3HFkYLIl2eWWN4JEqO0kILTuSUV5sVJClpVhind8fYC2E0TR1DSEwuS?=
 =?us-ascii?Q?2tUW2vic2sZmpenPKeylkRG77Tf7d/4Jp7M8rcuTqwOtRw9tZtPkjL/oUJWW?=
 =?us-ascii?Q?wktmC25IiHXz9RGhZYpsk+rXxrCKALNpszSoWbEdJgV5iMYACBYSOHvDr8l+?=
 =?us-ascii?Q?F5ChwXv4L6hH8qiwitr+i6zth5WGZ74z0YkTR2+NjO9NwWCcgE7Y2NtMLJXg?=
 =?us-ascii?Q?QWoy/KWuIt7YewxO/CNflPZn2INQk8Rx1yXG8c9pHFoHW1s/mEOffrnzIohS?=
 =?us-ascii?Q?RSOamlWSnpNQaK+SQN8kZrLdP6W/lzXDa7hRjA1Vit2U3rvAR6xBlVb6M3mw?=
 =?us-ascii?Q?JYxsapQkPoVuucUkE6Dz88v3SLtXCSFVHh9wWGcIegWTPSfqWus3VxPEbeqL?=
 =?us-ascii?Q?RuLUHsJHG8/V8G/jUZ95PiNBmoQmVjzkBV0X5o3/0Fspr0mX8SGhxNC9j8tJ?=
 =?us-ascii?Q?q4zqfRopoINuv+ScI25NsgRJzKQaHWLVOR1pkma162q1aQ7X1CURxkIfDI+F?=
 =?us-ascii?Q?EG7xesxeH/eF7DtZzdCDQvOANp1BUvLwy4Cn6/cmgkgfs1cfTBC164EnS1JL?=
 =?us-ascii?Q?I6B7si+N90XSolM/vJtzh3nwwrjVe8mfpwLZFF2s+hTtY6jVeS4KGZ4bmo5q?=
 =?us-ascii?Q?xcEm5jz+d5IGrMVs0sE2OTW3KmcXg9lRtt3orK4piGR/i9ZzeCQK6X/9lMRT?=
 =?us-ascii?Q?4ytVfufhmUdqkGLw/JSWCPS1XUA9oIa13dX0ufKluYI6EJwTbGi+sS+Msowm?=
 =?us-ascii?Q?w+NVV8w3YgcQn5FZgeXxaat93rHHmXC/VlprddaWfO0dK94Y63Nw2E5r4zpc?=
 =?us-ascii?Q?v7RVgL9betZ/SSm1k/GFUTA4dTs8AHQx/e7sVHG3VCOMkVn0W302B1pL8wRx?=
 =?us-ascii?Q?Rq9/EQ4cyk1mzTRsRCcuWRPSLSzs4MW3eyUfqgQRVYzLQWJIS/Uen5+EaR+Q?=
 =?us-ascii?Q?K2xt15h1HWAfatQbxCSCoPMH33q3KEWmd3M4oRXmfMp85LviNNoWdEWW+BBm?=
 =?us-ascii?Q?EgiZNS+DBgnhFcu33gDEebFoJ+MGiz9uHEKT9UHmTLLmS1ax7cDMauSJSajw?=
 =?us-ascii?Q?49Rb+P6E7OyCMwVk1tMur2XuJ1UpS4fd5yZf9t+EcSKiaOFxg0i6+Zgd/awZ?=
 =?us-ascii?Q?2r0WDnVg5JFKMzRuvPjKJU1IexgUehvwBn2YlTRqHGhpzYT6fYgSoGLUo/Iq?=
 =?us-ascii?Q?y8KyPlqvkWglG9gBpF8lroqSQm9OcY0UaZDLBwrlC1Ix+LM90XYWpXRv4QFh?=
 =?us-ascii?Q?ZiMYEXwvFov1XoYmvmeKV3ih18jwbPiPXnfvdkAJtIrLIsC6IF0x9BUHXo8g?=
 =?us-ascii?Q?5IK6XXQbmBVlSHYPu2AA3lNXHKVL9RUjrgBTSneIGhkr3Fcj777DLQIX6Pur?=
 =?us-ascii?Q?b7J6VruDf00pnPR6MBgzsojqlWSOOLJtd024MpY0J6Skk0775A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:04.3091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc866de-c226-447e-e508-08dd196d8bc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 79 +++++++++++++++++----------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 4f9f3de023ffd..69cf42a4a3f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -468,13 +468,14 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v2_5_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @i: instance to resume
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
+static void vcn_v2_5_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	uint32_t size;
 	uint32_t offset;
 
@@ -527,8 +528,11 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)
 		     AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 }
 
-static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].fw->size + 4);
 	uint32_t offset;
 
@@ -626,13 +630,14 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 /**
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @i: instance to disable clockgating on
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
+static void vcn_v2_5_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	uint32_t data;
 
 	if (adev->vcn.harvest_config & (1 << i))
@@ -738,9 +743,11 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
-		uint8_t sram_sel, int inst_idx, uint8_t indirect)
+static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+		uint8_t sram_sel, uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t reg_data = 0;
 
 	/* enable sw clock gating control */
@@ -789,13 +796,14 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v2_5_enable_clock_gating_inst - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @i: instance to enable clockgating on
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
+static void vcn_v2_5_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	uint32_t data = 0;
 
 	if (adev->vcn.harvest_config & (1 << i))
@@ -846,9 +854,11 @@ static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
+static void vcn_v2_6_enable_ras(struct amdgpu_vcn_inst *vinst,
 				bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t tmp;
 
 	if (amdgpu_ip_version(adev, UVD_HWIP, 0) != IP_VERSION(2, 6, 0))
@@ -873,8 +883,10 @@ static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
 			      tmp, 0, indirect);
 }
 
-static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
@@ -892,7 +904,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v2_5_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v2_5_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -941,7 +953,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v2_5_mc_resume_dpg_mode(vinst, indirect);
 
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
@@ -952,7 +964,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_CTRL2), 0, 0, indirect);
 
-	vcn_v2_6_enable_ras(adev, inst_idx, indirect);
+	vcn_v2_6_enable_ras(vinst, indirect);
 
 	/* unblock VCPU register access */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
@@ -1017,8 +1029,10 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
+static int vcn_v2_5_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_fw_shared *fw_shared =
 		adev->vcn.inst[i].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
@@ -1032,7 +1046,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v2_5_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
 
 	/* disable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
@@ -1046,7 +1060,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 		return 0;
 
 	/* SW clock gating */
-	vcn_v2_5_disable_clock_gating(adev, i);
+	vcn_v2_5_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
@@ -1091,7 +1105,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v2_5_mc_resume(adev, i);
+	vcn_v2_5_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
@@ -1396,8 +1410,10 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 	return vcn_v2_5_mmsch_start(adev, &adev->virt.mm_table);
 }
 
-static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static int vcn_v2_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t tmp;
 
 	/* Wait for power status to be 1 */
@@ -1424,15 +1440,17 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
+static int vcn_v2_5_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	uint32_t tmp;
 	int r;
 
 	if (adev->vcn.harvest_config & (1 << i))
 		return 0;
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v2_5_stop_dpg_mode(adev, i);
+		return vcn_v2_5_stop_dpg_mode(vinst);
 
 	/* wait for vcn idle */
 	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
@@ -1475,7 +1493,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
 	/* clear status */
 	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
 
-	vcn_v2_5_enable_clock_gating(adev, i);
+	vcn_v2_5_enable_clock_gating(vinst);
 
 	/* enable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
@@ -1810,12 +1828,14 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (enable) {
 			if (!vcn_v2_5_is_idle(adev))
 				return -EBUSY;
-			vcn_v2_5_enable_clock_gating(adev, i);
+			vcn_v2_5_enable_clock_gating(vinst);
 		} else {
-			vcn_v2_5_disable_clock_gating(adev, i);
+			vcn_v2_5_disable_clock_gating(vinst);
 		}
 	}
 
@@ -1827,6 +1847,7 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret;
 
 	if (amdgpu_sriov_vf(adev))
@@ -1836,9 +1857,9 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_5_stop(adev, i);
+		ret = vcn_v2_5_stop(vinst);
 	else
-		ret = vcn_v2_5_start(adev, i);
+		ret = vcn_v2_5_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst[i].cur_state = state;
-- 
2.47.1

