Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41F0E77184
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4949410E9ED;
	Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IV73d/Bm";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF8F210E9EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVWx45uQ3AaCHKRanNNS7KN1dnuo294TfXyTcxnKOzNggpdulK9iZei1BaTzSR2rZBeuvnWhf/71pn5vzVLlMv4yEtil6K+Errs0+ms10GfbM5UX0eG3cXDPQCLQyFN3KfDY69Bo+RKd3CekFW0idFDRwWG7XoTdK2Ox6FaebWtbHtUQpkQnaaE7x7m2vy9k2oIRl2r+sgRHZtCv/keU8cMxsupxANAO5ePYtEv0hUcRlGH9A9BMqNffFDYoBAsPBWRhkMl10X2ssJ2xL6jp/dhMY6/Dce2i3zndYiQK1SdGmELk7hcOzbkAHVUxOIKFuRYdVeubmTwySSNrMy3CyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkevcRwlpIcNlRLsCnKf9JI6rpBeQgLb5weZYVRWfAQ=;
 b=wJhZUaMKRK3IYFF7Fv5/UwYLldYqB1TPqwudLzNbabfNvxoL19s5Lp28R2Lg7YjKrzTapglKiP2ApInnsYtW5fJmJJSmXlA93i/1Fjfv1bsR3iBvXFK4SxxP/1JN5vfaS703sWThiaaPXyKReyzlnjTFuP96dhcaS43f0caNRfVYKdh/1WcC7wwGNmRpvILtyaCagZVhB16xDU4WueKK1ckK5f0efVbTLPFBisdY3Ffc/DVyW44IJvqk0px1Cu3HIjNbKFTTfHNbuiK5gEcN7f1Rra6GL62hYhE/NYTjjKVzYK5IOzeC9G1857MT5fIbgqsrKJt/ehxMwCtrXdIpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkevcRwlpIcNlRLsCnKf9JI6rpBeQgLb5weZYVRWfAQ=;
 b=IV73d/Bm0FeFJtgx6KMtSX6lzS8vhL85fve1jGmZ6VjkSn3hFHVmsLHVxXJa9gQYfkHJWEQM0zs0XrU/yT5R4RIvN3vcvryQh/9eJbfN+Hp+AfxI0e8kIHc6ToaEmvJW/mo05RpokX4aGdyh0g7lQUmXpu3sM7rT/2Uv/xePKzw=
Received: from BN9PR03CA0224.namprd03.prod.outlook.com (2603:10b6:408:f8::19)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 22:54:05 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::a9) by BN9PR03CA0224.outlook.office365.com
 (2603:10b6:408:f8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Tue,
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
Subject: [PATCH 16/48] drm/amdgpu/vcn4.0: convert internal functions to use
 vcn_inst
Date: Tue, 10 Dec 2024 17:53:05 -0500
Message-ID: <20241210225337.75394-17-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: d69cfefa-0fbc-4161-1bed-08dd196d8c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vCSF/CDuzgWfA1ik98/yodWCzFSDvGwrTr4yLpuGgIAh5IjhIY4vFmhYPA3/?=
 =?us-ascii?Q?4VJ8CQK2m22lt+/f30+4ZcueSk0no9XaU4AfrhQSrkgLKCpI/XtNCbarn4CK?=
 =?us-ascii?Q?YIg7pOc3pHCWzDGK7A5veHgmYutM4BQXxR4DxTvObvSa5U/I8466u36L8Vhb?=
 =?us-ascii?Q?NfAXbgFWEoaiy6T8hYXZ7J8DtzYQwWGMj5IL2jYaT7yX+Ki4kOQfrPeHhQmB?=
 =?us-ascii?Q?SMeKFblCw+IO8j8xPBRIiGkfPtnkHFK+C7m6OyU03xSLNWfKmf08g4pXUC2M?=
 =?us-ascii?Q?b7CyTzMaQN/C19pAUN1L2GqhCXqietkW6UtBqGvYtWDmczBmQg8XUyF+z90C?=
 =?us-ascii?Q?aEl0uUcmDrtTWyAQgyqoaOxoe8823ar+DRMB9J1gUCc8Ep1sF28gaEladVDW?=
 =?us-ascii?Q?VqaLd8fseTjJM71Wh1cAog6QwPds7PFMtE50Mfai/MGw0hozZpaFvMlaj+YG?=
 =?us-ascii?Q?7mlXE6BLQCah4F3E7o8th5ciaVXONBfnCU4reCM3D2ZC8XLRwEEomdKNEp8J?=
 =?us-ascii?Q?GgK5zZ6Md8DCLCcUH3O76kaRixvH41Mcvrzbb7MbdZQtLkC1utfhk8hKL+CQ?=
 =?us-ascii?Q?MPZzKDhFx1SG+qDm608shPgMx9aR/Plwckv1vLklF77Lx2jJfau3MRXMpH9K?=
 =?us-ascii?Q?UHcFUm39IqIkXRikGsHsGWffFtsAW5TBCfnD6Ttn/Gv2xUsnbgBu1VNNKwV8?=
 =?us-ascii?Q?h/XolPIsNUOFByK3SEwCQtmAtIBv2+zjtXNYLo0uYMIbQjVKi6UJCdgkPRrK?=
 =?us-ascii?Q?IJu46wCzXvK61ZZICJDNFE+twIBziTXkwEa8UWGBRwXNbnwHSXOAu8hKwczo?=
 =?us-ascii?Q?ZLtfHIH/JEQYVxdDazRt5BE0sROpzAoGNoceEP/KWq8xkVCIWjmWJHY3x5Zx?=
 =?us-ascii?Q?qJ+BEezY/QiNWSHjmYGQ/sWZvc40eHhxoOKMqVpOEqd75Ufcu9GeiYg7Nf24?=
 =?us-ascii?Q?M0RnQJjv49KmRrWR7ZmWPvQQfQUENiWuv+w54LQdqI63mYCOC/rU9PVWsKVm?=
 =?us-ascii?Q?Q4lpRWMlb0zNMNINiNOtjOmgeOkABMUs8xwtbS1OMafK3GrqVlfFHlVnZDGn?=
 =?us-ascii?Q?v5CF+yRrZ+kozYCRkIKpi5LI7HuxZFn+3GL7OLbT9Db9AZnMHRp34Sg2wkf4?=
 =?us-ascii?Q?zouH7GCJe2JzOZn4RE+a4QY8hj1SaIxYJMqBnIaXoJGqDBqc31tJpNtC0zyB?=
 =?us-ascii?Q?VRY1ROcW5EQvac5qzJC4bH6kEBRlU1VkOpc1wcbSOVWIBZVEuGA3WXeessBE?=
 =?us-ascii?Q?XfUYy6UbOfXHnTFmBuyRn2ehBk4EdeGDtVK1Ru1LBZFSl1hJJIobMCL64Rze?=
 =?us-ascii?Q?3UIEv1spSVJbRguX15QGx0/2aTfMt0kda7u+rcCK2Sfwt/9x7pFitcbhUouq?=
 =?us-ascii?Q?HTwxr+DN8Fzjfv9A9BixFnIH1Ud7+3ytNmgLPb1dmkBvIXmAlg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:04.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d69cfefa-0fbc-4161-1bed-08dd196d8c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 116 +++++++++++++++-----------
 1 file changed, 67 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1200815b3eee8..3d70e2cc81982 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -449,13 +449,14 @@ static int vcn_v4_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v4_0_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v4_0_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -509,14 +510,16 @@ static void vcn_v4_0_mc_resume(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v4_0_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Let the VCN memory controller know it's offsets with dpg mode
  */
-static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
@@ -616,13 +619,14 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 /**
  * vcn_v4_0_disable_static_power_gating - disable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable static power gating for VCN block
  */
-static void vcn_v4_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data = 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -681,13 +685,14 @@ static void vcn_v4_0_disable_static_power_gating(struct amdgpu_device *adev, int
 /**
  * vcn_v4_0_enable_static_power_gating - enable VCN static power gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable static power gating for VCN block
  */
-static void vcn_v4_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -736,13 +741,14 @@ static void vcn_v4_0_enable_static_power_gating(struct amdgpu_device *adev, int
 /**
  * vcn_v4_0_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v4_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -847,16 +853,18 @@ static void vcn_v4_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v4_0_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  * @sram_sel: sram select
- * @inst_idx: instance number index
  * @indirect: indirectly write sram
  *
  * Disable clock gating for VCN block with dpg mode
  */
-static void vcn_v4_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
-      int inst_idx, uint8_t indirect)
+static void vcn_v4_0_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+						   uint8_t sram_sel,
+						   uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t reg_data = 0;
 
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -904,13 +912,14 @@ static void vcn_v4_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, u
 /**
  * vcn_v4_0_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v4_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v4_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -960,9 +969,11 @@ static void vcn_v4_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(VCN, inst, regUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v4_0_enable_ras(struct amdgpu_device *adev, int inst_idx,
+static void vcn_v4_0_enable_ras(struct amdgpu_vcn_inst *vinst,
 				bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t tmp;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
@@ -985,14 +996,15 @@ static void vcn_v4_0_enable_ras(struct amdgpu_device *adev, int inst_idx,
 /**
  * vcn_v4_0_start_dpg_mode - VCN start with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Start VCN block with dpg mode
  */
-static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -1010,7 +1022,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v4_0_disable_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v4_0_disable_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -1058,7 +1070,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v4_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v4_0_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -1070,7 +1082,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, regUVD_LMI_CTRL2), tmp, 0, indirect);
 
-	vcn_v4_0_enable_ras(adev, inst_idx, indirect);
+	vcn_v4_0_enable_ras(vinst, indirect);
 
 	/* enable master interrupt */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
@@ -1114,13 +1126,14 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 /**
  * vcn_v4_0_start - VCN start
  *
- * @adev: amdgpu_device pointer
- * @i: instance to start
+ * @vinst: VCN instance
  *
  * Start VCN block
  */
-static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -1135,17 +1148,17 @@ static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v4_0_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
 
 	/* disable VCN power gating */
-	vcn_v4_0_disable_static_power_gating(adev, i);
+	vcn_v4_0_disable_static_power_gating(vinst);
 
 	/* set VCN status busy */
 	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
 
 	/*SW clock gating */
-	vcn_v4_0_disable_clock_gating(adev, i);
+	vcn_v4_0_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
@@ -1198,7 +1211,7 @@ static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
 		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v4_0_mc_resume(adev, i);
+	vcn_v4_0_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
@@ -1541,13 +1554,14 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 /**
  * vcn_v4_0_stop_dpg_mode - VCN stop with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  *
  * Stop VCN block with dpg mode
  */
-static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v4_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
@@ -1571,13 +1585,14 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v4_0_stop - VCN stop
  *
- * @adev: amdgpu_device pointer
- * @i: instance to stop
+ * @vinst: VCN instance
  *
  * Stop VCN block
  */
-static int vcn_v4_0_stop(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0;
@@ -1589,7 +1604,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev, int i)
 	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v4_0_stop_dpg_mode(adev, i);
+		vcn_v4_0_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1642,10 +1657,10 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
 
 	/* apply HW clock gating */
-	vcn_v4_0_enable_clock_gating(adev, i);
+	vcn_v4_0_enable_clock_gating(vinst);
 
 	/* enable VCN power gating */
-	vcn_v4_0_enable_static_power_gating(adev, i);
+	vcn_v4_0_enable_static_power_gating(vinst);
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
@@ -2044,15 +2059,17 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
 		if (enable) {
 			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v4_0_enable_clock_gating(adev, i);
+			vcn_v4_0_enable_clock_gating(vinst);
 		} else {
-			vcn_v4_0_disable_clock_gating(adev, i);
+			vcn_v4_0_disable_clock_gating(vinst);
 		}
 	}
 
@@ -2064,6 +2081,7 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2079,9 +2097,9 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_stop(adev, i);
+		ret = vcn_v4_0_stop(vinst);
 	else
-		ret = vcn_v4_0_start(adev, i);
+		ret = vcn_v4_0_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst[i].cur_state = state;
-- 
2.47.1

