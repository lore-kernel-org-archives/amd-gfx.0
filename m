Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D836E77182
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9F910E9DC;
	Tue, 10 Dec 2024 22:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O9XnfRiM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D011A10E9DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSHeKL6PCuOXQo2X/WhiMOGr9iRoV0BSG/A1yX0dvd7ANGXac8SHAMjqIKT9FcNDGeUkd6EKHjfs4pFmk+v2WcqUcrm/hw8aRiK+eIe7ZpigupPsOGlFCYuzy26o7obKSxIlX1z3vyg0ty1za6+QR6XxqvPDX2yYTM786uk7+GNHqRFyiDIfWoY0r5Yg2zZd+RU8Xlh0XnUDXZVn+oDpfyA89XqMYmwbX5zkm+ZECshSRwtjNppbz6/gB71eQZWLG3TBedlhWi6bUl52VMkUm3FF2phbVh9bxQiyd3380ItozrclyulLRqk8BpQsTJK1WyYWtS9oJk0C7wwIwOo3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5YFSrtsVk2ssn5otE2csrfAKOT0INpCpNLaBL2VijM=;
 b=kLoIjKSfgmVUKh6fSJy9mbPtP1lYFVRF7D+MIi87NgfkCDnqNBIvGxAEy5lB9nKBDTzmLjtrbnSmTG9ljOlForDEEqxhN8DcelwENw2mshQLBIUe8k/gh5mTNOikOA/FdFSTT66Gz8FEstxsnFKxI8oKQb/lxg2rK4v34wJ5BrLCFfQlBvG7SG00ubmFc+xMbbeWdB8Wtwl9PO3PqJSli+Q+BJSR9EMi4lp0FXL1O9iUdPEN52/Z/+4O3VEbfsDHaHsMCe8d+e7v2549ea5hM6Akg/7vzgtQbtTeAcyW/hd/3PqAXoEPBLQIrdHRjyl8eWl34uFkqJlB3uvtLWdXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5YFSrtsVk2ssn5otE2csrfAKOT0INpCpNLaBL2VijM=;
 b=O9XnfRiM/xEWbhvqjkN2W4x8VX1bKrJLQsipF1BKZCasVVwo08BxVd9dS6/oG6LCzDmlJBIKSXuvyJ8S+8TYzWmE5PBZAO8TzMyMOER5fW1hRRnkBzktJgt7Si1CC+38dJiTN0Jqmq405m4axAkVgbcodsNK/RxZSQ7CE8PQzU4=
Received: from MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44) by
 CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Tue, 10 Dec 2024 22:54:04 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::7e) by MN2PR01CA0031.outlook.office365.com
 (2603:10b6:208:10c::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Tue,
 10 Dec 2024 22:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:53:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/48] drm/amdgpu/vcn1.0: convert internal functions to use
 vcn_inst
Date: Tue, 10 Dec 2024 17:53:02 -0500
Message-ID: <20241210225337.75394-14-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: ec464944-c3dd-43ba-37b0-08dd196d8adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5RvFTOYPW+JZcJSMzr6nqEtdYlSUZA5f7/d/tSBz/Q0X8giR/uZFX27dG/Zs?=
 =?us-ascii?Q?XFBD5qDQ7xI4cZ58b8FfyymcQgpy1QTfMBSgBOv9BXAZn7kXu1rEuc2JIIKP?=
 =?us-ascii?Q?SkGOYfxgRzLyQurtkhVxtF1DsK/aA7Qe462fMlnp4pSWd1joyFnPtQBb5V1N?=
 =?us-ascii?Q?JvZnajyj64c8qVOTHN/XBQbbFhKdSsBBQdAhQFW7XzAt5cZWYEtOg7+B0LOo?=
 =?us-ascii?Q?nyKx+/XrU9khI0X9NUEaK926KRSJKZFnADKf1FXDFVNIk1ZFZYhY7lgaKZIb?=
 =?us-ascii?Q?0tR4kl8iljt41LRr+i0V4DsNqLHM/VVHs9HC1ZDpYs6LJUTKPmsR5X7xILcC?=
 =?us-ascii?Q?sl1Ci4gXT6g0nGun+oUjENyg1Xda1QfeTgxsu8gwp6bfcQHFVJRUGyaRmsnP?=
 =?us-ascii?Q?VT5/u/gZwQtQGMRdKKiC/zQMfmhGInUrCiTrhVIQ9OoPNEhue8SuA2HRw4w3?=
 =?us-ascii?Q?uTUGjhJg3XSCrUBKwQ4XO5vA9efq3s45HoUIgLutfrWmABrB0PsvtObgB/Ix?=
 =?us-ascii?Q?x2Wbviw5aPWopZOlC3u1yzCk7bk9Ao2OQyuH+YNq33VXTf3BRqnfzcged+Xk?=
 =?us-ascii?Q?icaKD+x3CZ/uIROgmtGopNT0uO/fOwoELgkD5DWjjsvEp40NlaoGGpwbCRB4?=
 =?us-ascii?Q?hlGN3J0+JsocJkNGh7eGGtiWXJ26STvcwnMZ3hCkJkK6DANpQIspahaTnre+?=
 =?us-ascii?Q?VsBRX0bGbcfTTJ1E5SsoPN0bDDq5XoGuv1VJpbcjd4c9hosbKRJW5YzcGMbk?=
 =?us-ascii?Q?K53Lk2gXj/bcAFW3WH6I94loilTW3q1SsGWWlwopZyItOisI3B6+XoK1K2UF?=
 =?us-ascii?Q?XirTyhi8N5M6034CGJT5NzRyuQtoUxUwiUKnZqS7qHEhl1TuU84oH53ATP/B?=
 =?us-ascii?Q?R57guqpXo8FF9+5JZKYEYWfUjiYd8Tp0MgXlF2yQEXhHnWD/PJnvZRY5HQBy?=
 =?us-ascii?Q?ucmYvuLFo4QuZx63YKk3NibLy79dOJjsrswyHa7nq0WzwcLocfG9JDONw07c?=
 =?us-ascii?Q?hvePm08TwgcJDoWw7mBkjoV3z7BSvJaHvH4xHK6aHdja71poWJRlIzuMeirR?=
 =?us-ascii?Q?tMCe13jjA7u5zOMIWykRg586/nNHybU0CHYPJC4V7QgSu+BloYSb/YjoT1om?=
 =?us-ascii?Q?rI7yAdSKETbcAWR1fy07FnypBmgOZKZ9316RdM0Fhc+atfSBev0EjaiHBVx1?=
 =?us-ascii?Q?4M0xkKjqWXqidi62R3vRJmXqx39pbh+qIoYGTFKsgUgvfWoz9Di4nFYvG3Nq?=
 =?us-ascii?Q?EzT87lkllK9GeTMS3BX8tVf7v1/61zBpbiRVHPvFtbeSXhgwgnmq1Uhb60lc?=
 =?us-ascii?Q?cQOHAyVN/JqEZ10VS8v8NGNzbxCCmSxZlXJhSrn8/J7iPGVfO7nMNvNcYSuh?=
 =?us-ascii?Q?uantD9QaFUUtkEB1v55wQXmAcPXAK5p7XMQBaxFKe3DqugwJew=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:02.7671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec464944-c3dd-43ba-37b0-08dd196d8adc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 85 ++++++++++++++++-----------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 346f465624443..c01563441ea76 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -81,7 +81,7 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_1_0[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_DPG_PAUSE)
 };
 
-static int vcn_v1_0_stop(struct amdgpu_device *adev);
+static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst);
 static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
@@ -339,12 +339,13 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v1_0_mc_resume_spg_mode - memory controller programming
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
+static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
@@ -410,8 +411,9 @@ static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
 			adev->gfx.config.gb_addr_config);
 }
 
-static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
+static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
@@ -485,12 +487,13 @@ static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
 /**
  * vcn_v1_0_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v1_0_disable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v1_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data;
 
 	/* JPEG disable CGC */
@@ -615,8 +618,9 @@ static void vcn_v1_0_disable_clock_gating(struct amdgpu_device *adev)
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v1_0_enable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v1_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data = 0;
 
 	/* enable JPEG CGC */
@@ -680,8 +684,10 @@ static void vcn_v1_0_enable_clock_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel)
+static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					   uint8_t sram_sel)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t reg_data = 0;
 
 	/* disable JPEG CGC */
@@ -734,8 +740,9 @@ static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t s
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_SUVD_CGC_CTRL, 0, 0xFFFFFFFF, sram_sel);
 }
 
-static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
+static void vcn_1_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data = 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -779,8 +786,9 @@ static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_POWER_STATUS, data);
 }
 
-static void vcn_1_0_enable_static_power_gating(struct amdgpu_device *adev)
+static void vcn_1_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t data = 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
@@ -823,12 +831,13 @@ static void vcn_1_0_enable_static_power_gating(struct amdgpu_device *adev)
 /**
  * vcn_v1_0_start_spg_mode - start VCN block
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Setup and start the VCN block
  */
-static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
 	uint32_t lmi_swap_cntl;
@@ -837,13 +846,13 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
 	/* disable byte swapping */
 	lmi_swap_cntl = 0;
 
-	vcn_1_0_disable_static_power_gating(adev);
+	vcn_1_0_disable_static_power_gating(vinst);
 
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(UVD, 0, mmUVD_STATUS, tmp);
 
 	/* disable clock gating */
-	vcn_v1_0_disable_clock_gating(adev);
+	vcn_v1_0_disable_clock_gating(vinst);
 
 	/* disable interupt */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_MASTINT_EN), 0,
@@ -885,7 +894,7 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
 		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v1_0_mc_resume_spg_mode(adev);
+	vcn_v1_0_mc_resume_spg_mode(vinst);
 
 	WREG32_SOC15(UVD, 0, mmUVD_REG_XX_MASK_1_0, 0x10);
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK_1_0,
@@ -1001,8 +1010,9 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
 	uint32_t lmi_swap_cntl;
@@ -1010,7 +1020,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	/* disable byte swapping */
 	lmi_swap_cntl = 0;
 
-	vcn_1_0_enable_static_power_gating(adev);
+	vcn_1_0_enable_static_power_gating(vinst);
 
 	/* enable dynamic power gating mode */
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS);
@@ -1019,7 +1029,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	WREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS, tmp);
 
 	/* enable clock gating */
-	vcn_v1_0_clock_gating_dpg_mode(adev, 0);
+	vcn_v1_0_clock_gating_dpg_mode(vinst, 0);
 
 	/* enable VCPU clock */
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -1068,7 +1078,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0xFFFFFFFF, 0);
 
-	vcn_v1_0_mc_resume_dpg_mode(adev);
+	vcn_v1_0_mc_resume_dpg_mode(vinst);
 
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_REG_XX_MASK, 0x10, 0xFFFFFFFF, 0);
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK, 0x3, 0xFFFFFFFF, 0);
@@ -1085,7 +1095,7 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MASTINT_EN,
 			UVD_MASTINT_EN__VCPU_EN_MASK, UVD_MASTINT_EN__VCPU_EN_MASK, 0);
 
-	vcn_v1_0_clock_gating_dpg_mode(adev, 1);
+	vcn_v1_0_clock_gating_dpg_mode(vinst, 1);
 	/* setup mmUVD_LMI_CTRL */
 	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_CTRL,
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
@@ -1145,21 +1155,24 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v1_0_start(struct amdgpu_device *adev)
+static int vcn_v1_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
+
 	return (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ?
-		vcn_v1_0_start_dpg_mode(adev) : vcn_v1_0_start_spg_mode(adev);
+		vcn_v1_0_start_dpg_mode(vinst) : vcn_v1_0_start_spg_mode(vinst);
 }
 
 /**
  * vcn_v1_0_stop_spg_mode - stop VCN block
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * stop the VCN block
  */
-static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_stop_spg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	int tmp;
 
 	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
@@ -1199,13 +1212,14 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
 
 	WREG32_SOC15(UVD, 0, mmUVD_STATUS, 0);
 
-	vcn_v1_0_enable_clock_gating(adev);
-	vcn_1_0_enable_static_power_gating(adev);
+	vcn_v1_0_enable_clock_gating(vinst);
+	vcn_1_0_enable_static_power_gating(vinst);
 	return 0;
 }
 
-static int vcn_v1_0_stop_dpg_mode(struct amdgpu_device *adev)
+static int vcn_v1_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	uint32_t tmp;
 
 	/* Wait for power status to be UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF */
@@ -1237,14 +1251,15 @@ static int vcn_v1_0_stop_dpg_mode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v1_0_stop(struct amdgpu_device *adev)
+static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	int r;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		r = vcn_v1_0_stop_dpg_mode(adev);
+		r = vcn_v1_0_stop_dpg_mode(vinst);
 	else
-		r = vcn_v1_0_stop_spg_mode(adev);
+		r = vcn_v1_0_stop_spg_mode(vinst);
 
 	return r;
 }
@@ -1399,16 +1414,17 @@ static int vcn_v1_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
 		/* wait for STATUS to clear */
 		if (!vcn_v1_0_is_idle(adev))
 			return -EBUSY;
-		vcn_v1_0_enable_clock_gating(adev);
+		vcn_v1_0_enable_clock_gating(vinst);
 	} else {
 		/* disable HW gating and enable Sw gating */
-		vcn_v1_0_disable_clock_gating(adev);
+		vcn_v1_0_disable_clock_gating(vinst);
 	}
 	return 0;
 }
@@ -1812,14 +1828,15 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 */
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
 	if (state == adev->vcn.inst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v1_0_stop(adev);
+		ret = vcn_v1_0_stop(vinst);
 	else
-		ret = vcn_v1_0_start(adev);
+		ret = vcn_v1_0_start(vinst);
 
 	if (!ret)
 		adev->vcn.inst->cur_state = state;
-- 
2.47.1

