Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582CAC021A1
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B097B10E3ED;
	Fri, 31 Jan 2025 16:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5SDzW5Kk";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1FEE10E3C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8fDUWeXgjjHfn6IZMFO+C43fBjoIr6+3zR9+3znxcrrpl05HoQ5GfR5EOeXcseNMEYojLrHrHIY/9F8hBVbqQ6ESBfNn6OTV4FRME0qxKxlJEa6BDxhMnoHeOTOctOml4sSdvi/KOp1CUSV9l6s/Wz6Pyka06MJf2R2bzpFW6H0Rl/Oj6evIj205it2UUxe7p8cNpMjl07i1CEa8SaLYF37219ZgIyZalvK9GAmB+xnbJMqdLXqL5s+8BBi7rZ+tzZ/p2FW3fgXa1T4mEvwQOh7yrW/4EddCSAQ+gcamgDQumpOgGrRjFydGUT8DMcjFE7Q+WWDGvbhlLfkrxSgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZEg/a9uz6QP6/lTSmNsxGZ2HdUmLndekl/1Wclt25o=;
 b=HR9+x++N/LzjlL8psFdpOKvPJvQX12/oAtkrnWzFwYzA7SGP0R0EVGyNj9u1ZscsBSv40As5hlDJx5ao36J91qu4mFCT08GEYtsxmGNE4B5rtnArWeUfCTkNXLU3VqxE1n6IlSmQezn0IadM0tQZcl4qbpsDBPHwrcXtsQPOF8U8oDU0KZXxxU9AbT3D+GacWyDs8JKVBm+hxNSuQ+4bjR/lz98y1PsQ84pcdZ9hekRkVNWaYRsVgay6tK3oA3XewBKA4BLybZCOIJAw4W2VmjbFKFMvkgG5lXgkH+PRT0ZsseSNfIDOACyteq/3iqlEPN+qTb5t83tFdI66qwgs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZEg/a9uz6QP6/lTSmNsxGZ2HdUmLndekl/1Wclt25o=;
 b=5SDzW5Kk3dq0gEsOOfrd209aZ32YPMOHyhvOMIMedEvWbE3o4J3IOrczVeND8clwN3CBk0BKu5FUxCBIJXxmI4skGefcZXHWpHQ0P7P5nllb7UmN1ZZAApOsThHagNamgSYhIy4qg4YdEKYviycL5zkLSjMRqBloNSU1K7pR1RU=
Received: from CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::10)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Fri, 31 Jan
 2025 16:58:13 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::77) by CH5P220CA0002.outlook.office365.com
 (2603:10b6:610:1ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/44] drm/amdgpu/vcn3.0: convert internal functions to use
 vcn_inst
Date: Fri, 31 Jan 2025 11:57:08 -0500
Message-ID: <20250131165741.1798488-13-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: f4068cd3-fd83-4708-9c05-08dd421872b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LThy/pDl6kaPStbZcxd1Ii8IJH6pH/uXQV/9kpIrF+zlhEV+wL23rvp7cUqL?=
 =?us-ascii?Q?NG9fut4iMqTi/5WNK+ZONUFXv4tl/FmbuXrOJ5XHSsOsAaiPKlY/ucaXastz?=
 =?us-ascii?Q?3sN6sBIB6XqeSVdTUjYUN8ZRwH7wBmmfUZlYYJzbReAzNKIK1q9u1DxJnDj/?=
 =?us-ascii?Q?ldMxbHl/C/TUTC3VzoNkylfwlDIcRh1VmwF+5mEaeCWfwTzO5ZqsEuFB9+SG?=
 =?us-ascii?Q?8pgF0hSRY6BXD7OCK+HpD9Zvs4X5d7GnH4e9NF5V6cSIe9fnso7gogLlqjpY?=
 =?us-ascii?Q?XeFn8IDSlxEy7PvRIDfQNSp+SCTlK6Jg6IrlRG/UUDvTqfU6kYeW8ormqZ9y?=
 =?us-ascii?Q?EtcEXulktx24qYS3Fm1g4iV7ptl7t19DydnTN5Cj7pa+0HF6DX5dsMhCywol?=
 =?us-ascii?Q?Uv3+HAGxI5IsnUK2fRWJ8iidOfmcHS9c9B8kgjCT/yWifFqZVPSITiCRXX7a?=
 =?us-ascii?Q?0PB2n1oyXe2DqqZtmjeGOK5p5FTN+zyhFTFQznpAgBqUFelqiD6BVJSvVufC?=
 =?us-ascii?Q?ZRWWzyw3s3cOSygOcjrncVbsigAvlx5XzJ4vhLj721wqQubsfHpbtsZF3TVC?=
 =?us-ascii?Q?hfFzcP5dnm9pFRrWhsPaxLZgavNjCFW9XF8sIBC7+Zl0/4nNJgzGXypH457X?=
 =?us-ascii?Q?zB9xuQhiuXzj/yUBskI6rqvixc/sT0ga8zapyYBB7MFOWJjTHLgSxMgEpT33?=
 =?us-ascii?Q?RDGpuxn1hkssK7vaqxmQhyx43H8Q/UYmz3GNuwifbHBvTof0hMseGjOCXOsY?=
 =?us-ascii?Q?7Hnjo/zI1i+d/Aje7C5onplLQQSV/G3ms6NEtCF9aiTcJwCeRRVQdS9vDIMf?=
 =?us-ascii?Q?h6BtV/551lUeRrxVR8bioPwpV5I6PBtPB5EmtUFZVM5xjAEA/3AMurY8yjBb?=
 =?us-ascii?Q?cbQhnmivDd1n7wTeXfwGQOPZiwATD5LVwcmdvgRfZt1pyb2RMZJ7G5qUw3nx?=
 =?us-ascii?Q?AnvVAqsTjis1kFrTK27nFUjX62qE+eMeZzsFQLgyGEap707brsvUL4vvIZHj?=
 =?us-ascii?Q?lKuy4QK6nqY01exeUtpqpA+OWpmynShb0DCzcThfsSa/4YwdnTSe1KbLh9es?=
 =?us-ascii?Q?wd2gDY2PiEEGyKViwxcJocfbY+IH469bMyyYQm1CKlyGO1ba0ceRkh83oixZ?=
 =?us-ascii?Q?EIfs04sSHXKQV+oqzp6HASg5BdJEIoRE6rfhDDZdpHed72LCa+bc21M+5/nj?=
 =?us-ascii?Q?i3mjJLduvSzvbmfUqUbc8vZWL8O/bffdP41RMxOmYRQQsVDr2tvT2HRDGpl5?=
 =?us-ascii?Q?lQ05kkBQ29+RYvSOOhTfIEpsD+lQTOhww7kTggy6RMZTvAEVNb1bz+1oL93w?=
 =?us-ascii?Q?PZ8C8/6JxaTG5Nxa3WqnqLtZR6EvoMe0JFzZg5aV9Q3JseaemNnG0r34QoMJ?=
 =?us-ascii?Q?TOcXZ0JnAGfHAeDja4duwt+pNKprUiHj9yL9HU/e20FoXkTMjmPN6N7AZJpv?=
 =?us-ascii?Q?YJh6Ka9Yzb+Mfm4yjWlYXMTOhCUmczgwU0lHdolslP2sPiz2VgKUiA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:12.6275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4068cd3-fd83-4708-9c05-08dd421872b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
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
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 79 ++++++++++++++++++---------
 1 file changed, 52 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 724f36467b068..f6f4f04d74339 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -510,13 +510,14 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v3_0_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst].fw->size + 4);
 	uint32_t offset;
 
@@ -565,8 +566,11 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 }
 
-static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].fw->size + 4);
 	uint32_t offset;
 
@@ -661,8 +665,10 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 		UVD, inst_idx, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
-static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data = 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -712,8 +718,10 @@ static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int
 	WREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS, data);
 }
 
-static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -765,8 +773,10 @@ static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	/* VCN disable CGC */
@@ -893,9 +903,12 @@ static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
-		uint8_t sram_sel, int inst_idx, uint8_t indirect)
+static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					   uint8_t sram_sel,
+					   uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	uint32_t reg_data = 0;
 
 	/* enable sw clock gating control */
@@ -949,8 +962,10 @@ static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
 	uint32_t data;
 
 	/* enable VCN CGC */
@@ -1009,8 +1024,10 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v3_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
@@ -1028,7 +1045,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v3_0_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v3_0_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -1077,7 +1094,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v3_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v3_0_mc_resume_dpg_mode(vinst, indirect);
 
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
@@ -1161,8 +1178,10 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
+static int vcn_v3_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
@@ -1175,17 +1194,17 @@ static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
+		return vcn_v3_0_start_dpg_mode(vinst, vinst->indirect_sram);
 
 	/* disable VCN power gating */
-	vcn_v3_0_disable_static_power_gating(adev, i);
+	vcn_v3_0_disable_static_power_gating(vinst);
 
 	/* set VCN status busy */
 	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
 
 	/* SW clock gating */
-	vcn_v3_0_disable_clock_gating(adev, i);
+	vcn_v3_0_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
@@ -1238,7 +1257,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
 		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v3_0_mc_resume(adev, i);
+	vcn_v3_0_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
@@ -1555,8 +1574,10 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static int vcn_v3_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
@@ -1586,8 +1607,10 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
+static int vcn_v3_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
 	uint32_t tmp;
 	int r = 0;
 
@@ -1595,7 +1618,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
 		return 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v3_0_stop_dpg_mode(adev, i);
+		return vcn_v3_0_stop_dpg_mode(vinst);
 
 	/* wait for vcn idle */
 	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
@@ -1646,10 +1669,10 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
 
 	/* apply HW clock gating */
-	vcn_v3_0_enable_clock_gating(adev, i);
+	vcn_v3_0_enable_clock_gating(vinst);
 
 	/* enable VCN power gating */
-	vcn_v3_0_enable_static_power_gating(adev, i);
+	vcn_v3_0_enable_static_power_gating(vinst);
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
@@ -2159,15 +2182,16 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
 		if (enable) {
 			if (RREG32_SOC15(VCN, i, mmUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v3_0_enable_clock_gating(adev, i);
+			vcn_v3_0_enable_clock_gating(vinst);
 		} else {
-			vcn_v3_0_disable_clock_gating(adev, i);
+			vcn_v3_0_disable_clock_gating(vinst);
 		}
 	}
 
@@ -2179,6 +2203,7 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2194,9 +2219,9 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v3_0_stop(adev, i);
+		ret = vcn_v3_0_stop(vinst);
 	else
-		ret = vcn_v3_0_start(adev, i);
+		ret = vcn_v3_0_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst[i].cur_state = state;
-- 
2.48.1

