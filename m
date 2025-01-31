Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A1CC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F8A10E40D;
	Fri, 31 Jan 2025 16:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DvZ1LoUs";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1427310E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP0zE2fJFRyLtvwsJnKrhm1hOz8Ky+0o6qUzKXvQIuNY5DXKuvqNgFKr7NCeLNcHqwsN5hGt5JFABHIfWFe/KrYss0St8qO1s4wLP3nRheoFqKbNnsB7bumauOM89IZ3dvtY0c3F4+5pL586G++bSZsv5vlB6dVmTm1HJFp5NGf7hDjsgpW+K+3ss2Mx60nr6BZZIZmdHWeUESVPHQk4s+odw/g/C1EBC3DO/KSKPylnU/riKwwdMjGHVYWzX2dZpvCexFnl0/Ur95eMThIMl4F9Tt9aAw7UR87a4K6sMwgfJXJd7VWtpDcmO1Nws6q+RED47xCjVEiIB58Tub6QAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lS5omj+rgjR+YgICPyUEegVqw3QLY3WH/LNjVj6EPUc=;
 b=jBquC0xAmZpPg6+xcbMfAnqS5I974l0c1QS1YreLfyd/RxxEyQF60/a/R44TWylUDGV/B7kFHmrWs9yiUGyed4zt6EGlkSZEhhpNSy2hQsDR+vma8jYI7GzMt7sYR20jiYYiSsWg1ch85fXaSLdqhX4ClrXuBupSxs/OJo5+W9OaXwcEOKR0f4cSdsQa0ey0/SwuQ956Dv4LpPLZWAk8M72s0ZkJo/ROSKlYT+lWhKl3rm7Ieicvt4QPezCKhsmbQjon+NQy+cwyZrBfYDkMj5f0JxW0beLRYPZk4W/XEIo8uPe42qFytGjzNBf1y2DwdrzbwZM3gyojq6LjWf153g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS5omj+rgjR+YgICPyUEegVqw3QLY3WH/LNjVj6EPUc=;
 b=DvZ1LoUswW0qxoKW/Kzj18GKwOlWiliXO9q1bAll4QivqBxDS1veW4E/CMBPMaUfg70qj1d3DKVlk741wpUZV/ftdjyI5+fXOpNBhru7ecJRd2ydyoEitnjWKgc0QSSV8+W5kpHKY5RxPWrtkdb8cDkdxv0ZXQXEoePIYwPjmI8=
Received: from CH5P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::8)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 31 Jan
 2025 16:58:15 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::5f) by CH5P220CA0017.outlook.office365.com
 (2603:10b6:610:1ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/44] drm/amdgpu/vcn4.0: convert internal functions to use
 vcn_inst
Date: Fri, 31 Jan 2025 11:57:12 -0500
Message-ID: <20250131165741.1798488-17-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3ca740-ed20-45c6-1707-08dd421873f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vo+d6dl4hTg7ZDiSSD/pTTkitIXgNXKRhWQvVaBrjVgxjbMRQkSA/2WWaop9?=
 =?us-ascii?Q?jh0ikgyuaIH3fK0GVLv4zN0TUa3NBIkrIzpDd2KHNEKOC4k8jw52X1Gdt4c8?=
 =?us-ascii?Q?/ITnUNoSKQUVDSLGERho2eKrkZf4yMksqUfJGh5i3tqVBJEPwD+vj21OrZxY?=
 =?us-ascii?Q?3mh7Aw1Oyja6n+kxvf1xKKwx4RbmvEJdrVIxlvr0W3W52N5wmmUA8pyc9w3o?=
 =?us-ascii?Q?aW1LSXi/+j0V49FmMzKb0YEOc8vJdY2mGJ8vwmrLWE5fOLmmm6iC9pwRIr/J?=
 =?us-ascii?Q?inzOoYrG1ni3W2LWgQdxq4PW9CTzR8ve6uZVgZUra6fpbIxMqu6upLDIExT9?=
 =?us-ascii?Q?YZ1kdxLcoX07xoV7Qk7NsSImx85DfbmaTB/P35f+oqaGKbZQOcrKvj0ZdRqV?=
 =?us-ascii?Q?5wax9mn7kU5scM1Ibh5xFTf/pW63p1cXkOVADZV9lcckyGa+y1o6cKYIzqyY?=
 =?us-ascii?Q?GvVeepaa+aK08l6tVls4MV9uHJU6yvxQHNwVZ/zsWE7zdYcyQkAZiJlccQSO?=
 =?us-ascii?Q?Uov3PFYGBeg47f2iGM6Ffj3ghZYV4+RIE2ak7gpQlV+kLrKhDR7goPZmaiE6?=
 =?us-ascii?Q?GX/9ifklPTSeWYwi/su65ScWBCsB8eDz7MPkmqgH9FBcEh7z5on3tULgjJRk?=
 =?us-ascii?Q?6x+eg6SShDpRp8+XCK0RksSskhdUGZe8yR783bgK7DEXwmcuA2F4VTYEBmOn?=
 =?us-ascii?Q?QBQJqC2mLO7Uf1faXRMluO627EcB6m3isLo6mix57eBFWdQ5C7fVlUfqouT+?=
 =?us-ascii?Q?3W/xuIQtKIdV3DjA9Bxq9G/dnFVutqqNZKGn4b+S/r6FiS6je57VLPbl4uqS?=
 =?us-ascii?Q?xTsA0pxAXLqMmOK7GKuggHvhjeDwKaYKTUE5SidHJcmfZ535YdeUr2X1vPNx?=
 =?us-ascii?Q?LUAjX4gUUbMqW8y9ElBzQll27TFQujetht73hxasOHl3khhkkfar4ejjjyU8?=
 =?us-ascii?Q?PmVlC0eRqKppbtnhvkppweFGmp3lPg8u/3tUbjGSvblB7pgbfXb5xmfdjjt0?=
 =?us-ascii?Q?JtYtNU+AKbrMm2QXjKe6xBctOUdaOdbuC2pLeqZ1IHl4xgHmHalOQMb9B5cy?=
 =?us-ascii?Q?mbDhSh3JptbgS12WjnTn8pS/8WQY+o9R6U2KMqnkpXFPHdTtBZm47TgHrIKW?=
 =?us-ascii?Q?w9yuVM+fZltQ59iNjVuDUyfED6K+pbTvs43cqareebcXfMgvszAVq3YqsN/h?=
 =?us-ascii?Q?htQXB2kcgkI54YGEUYWLjkPt11gLu+t/0ShC1jn8iD1znSmemlXIYQ6zczk7?=
 =?us-ascii?Q?6xTS7P3uAsQ/SWBEoY8zRL5k1kQOb3OOr0SOJGwiNDqHotKrRiNr2jQrShPD?=
 =?us-ascii?Q?+8DXfq4Iazz5c4v87EAtNP2geZ1f/hqDIVcB133GEEudUVicdXy5SQarv3UO?=
 =?us-ascii?Q?82MFMovg1wg/bt+MdkOpDj9SKRL56GA1Eptnl/mktVAsjJm2FEz1oobYJTLW?=
 =?us-ascii?Q?QEKc4TCTZQVqHaJVtbOPxoZH3tVJDGLJeTGfTC+0GRmNNG5XyTKF2w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:14.7212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3ca740-ed20-45c6-1707-08dd421873f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175
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
2.48.1

