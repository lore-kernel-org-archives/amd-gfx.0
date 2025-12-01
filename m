Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEC8D116FF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 23:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06DC10E4CB;
	Mon,  1 Dec 2025 23:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zMAzU1Gu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EDF10E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 23:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxP3hjQo90LJn2FyEadzjZGpLKsx+utYX4Q84im7raxXbs4Krfn2M/MYl38ql8sUCPdlTRaA2CNxrAVJseTfX6zuerJC5z6zLchu57v9VkssKX/ZxFqO1xUQB5AHD3pEBSW7A+JqyZSsTn/ftsbiZ6kUXAtpPD55fyKB2sAq65x7GQIAP8wp7PjZc7IElzPVifrK5tHjYBv1ZUgcROQmRRnDHH/Ic5n3R6fQZougZBdht0rBY0qyyO4hNNEnhoaNTUjltceh/9V/yZ2V75eaodusBzd0a25TqGp8YeNyN9dTLfG4JWcsgMcOvkxoLyzLlhIiOJ2kcjGmGthxzinp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSPAl8Gq3pw2Wb3IiV7OjpdV8cxbZsrk2DXjb10BQgM=;
 b=UpyUdS5VaV0PXCW6dfXclWPQ/+A94/7z368jmM+y6QX9ZLvpHCTlW75AZwrYBnu6WCpGdMF2Z+RwKC0tc4miRHIo2drSvRXIdexSXJWpcbowehzFQaelhXnkEbX5u7dIAtLNpG6jQJjlBd71omCqeRoox9/eyWCFN0QbUxElz3NBVugOEJKHH40HkK0YwLzOC4s2nCoX00G5fEmjSYcC1ZpHDstUPwN8fJiSM0PJHVO1rDeXWYAwDtwWbuh6EHB6+VfZYZQnE5Sl1874/mC6nXMqrOQnXWi1n4B+zuy+lGKxKoOkJL6xD8G3CEdP7H4yOzImFVZekFEl9KQpWPjwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSPAl8Gq3pw2Wb3IiV7OjpdV8cxbZsrk2DXjb10BQgM=;
 b=zMAzU1GuBr91XW1NuVvwYwcyEYvimkKhQbRysee6kdm6pRRDrBwMJNsIlbPBAKRxC9H7bHyMR2d7vtLhs2C34yshjnPYk2cu92D09Y7zGxxiV4KqBIp+VmmKTedmNjuvo/6Zwy0EaWeoI2OZc013HaS7U54JRcRLmE57uNwPUu8=
Received: from SA9PR13CA0035.namprd13.prod.outlook.com (2603:10b6:806:22::10)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:15:34 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::9f) by SA9PR13CA0035.outlook.office365.com
 (2603:10b6:806:22::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Mon, 1
 Dec 2025 23:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 23:15:32 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 17:15:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add imu support for gc 12_1
Date: Mon, 1 Dec 2025 18:15:09 -0500
Message-ID: <20251201231509.791954-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251201231509.791954-1-alexander.deucher@amd.com>
References: <20251201231509.791954-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4bd8fb-f4ac-42e2-b217-08de312f86ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Neeb3X05D3T4CPvhauOM6WtIYzsIZl0ikECtiyTNCgY3JyTO8Dy4cd39YNVr?=
 =?us-ascii?Q?0b+PtkO+c8gUJF3JSz3grUrCf5AkzudjI8fPj4AiSNOTI/xPbaeIB2/1lmsj?=
 =?us-ascii?Q?HA5l1DEwLBEPGe6bcgSF7mV4UaM9Ghwi+jpOq4faIoz0tf7GO8BNboyyskV4?=
 =?us-ascii?Q?lKpNPjHUNUMtL+QvyHAuODJSakzOTGACIr7eKm4ngfh6TTpgZls7JMSaQp/n?=
 =?us-ascii?Q?9+47tyNcAdMnL2yWHUdK0ObxqlTolNh5Q43I6tLRdrBHCidQp3cO392ICfcP?=
 =?us-ascii?Q?3xK7u1u8qSx0jVVCLC0q8suqDXshwXSmxfKfnHBdlOovxLFXVMMMigEC3cfK?=
 =?us-ascii?Q?OHe1FkOcXgCJsHhBKDaaN9hDJvdTsbL7diIqiiWiLefbnbfs74W5Eg/WVJdZ?=
 =?us-ascii?Q?zTMnWsVDNQouJNaMgAJHjLA9dZrCz4iEFdXDbHTzHSH7cSl9lGEUQ/62R07m?=
 =?us-ascii?Q?rBtEy2GYg2505BjkorPyYs1uCldw9Rqf0NqkcDAFaRjILFzws6dJsVTg73BO?=
 =?us-ascii?Q?n2i+7le4Q3L1yi+qJ9qz6//0gV5tKXfFWF+d/pAN1YU3VMObQ8Qu+pyxwS0d?=
 =?us-ascii?Q?ipqT8onPk375OvFw/BM7TkYyQ6m/APe24V1m4BXYOyetCoYASnx2/x2SpEX+?=
 =?us-ascii?Q?k5IjyJCgRBFH/NJSeZAjj9pHoZ8sD7jnPD5/iilniKjNVDcM14qnp28431yz?=
 =?us-ascii?Q?zceGmQFy9jSysJ6MQqO9dhXbJVUmyqehAei7uMKuWhXh3ocXa9M505rDoDbB?=
 =?us-ascii?Q?rJQ5NwIGlXbKqmEcrv+3WzQRaR+3suU9cVq1o1hBXJr+gWjPgd8a5CK9sa0U?=
 =?us-ascii?Q?KgSYTx4usMKvLRBEpcCFeAOPco55ITuIr9Qn/+GcWv8/SwDXZVUnl0ee0g11?=
 =?us-ascii?Q?c2AD16hpT2rkarO94IrjYpm3ig5yDGVtcQ5RNAMkISmle1k3fBNxF+1ajFR6?=
 =?us-ascii?Q?9YMdxUi2b1jNY8M5Os/mkX8LMvQrGyMNGtayG/ShK6hnzC5wyT56tIBTv3Iy?=
 =?us-ascii?Q?bFY3mnZLqami8UsD2WhnysQUcln774X/j4LQwciqFabFliJw8yQ9z2teFKae?=
 =?us-ascii?Q?muE1uzthQRC3TysVwQU/6Pe22sr8l0cgsDN2AdfkymFKCN8v53y/gwq1yez1?=
 =?us-ascii?Q?IsySQmlWmCtRJ1EthzTESuv1Lq5fYqvE9Ij0DkMW5bcSPVfrC3+SOAUhG/G+?=
 =?us-ascii?Q?gubDpa1rmX7SxsGGy+3GNwahb79KiNMsmWuBzz5qodRAP/fhgUdB0H2SeIsT?=
 =?us-ascii?Q?LKqx/l9IktLu/m4Z/qxGGmdCMFF0ow8MZo1uHw2zmaIgNrcsw16s6PQ73wqQ?=
 =?us-ascii?Q?b56tdtiW00yJ+g/b/MV9HwzZJEncu18YchYL7UF7XcJnAhtedtqfHIVRN4wZ?=
 =?us-ascii?Q?GiHzyVQwOVqtPgV18RNuBz/nOW6GDV0ppQZqPmajpagPht7Og/sEC57ShPmG?=
 =?us-ascii?Q?jeG9sHi3Qo+r85e7EErEPdqLaDnnAjnFTwmEjssBiszffMnS8GlSAkKZC1K6?=
 =?us-ascii?Q?B2M9d0tHYDO6Qp/ABGkX5fU6PEX/jPrb5vfYpBbwpwIYoQqBgd+QiGLPyxeQ?=
 =?us-ascii?Q?hRA3tcUaKjsKpJueZeE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 23:15:32.9665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4bd8fb-f4ac-42e2-b217-08de312f86ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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

From: Likun Gao <Likun.Gao@amd.com>

Add IMU support for gc version 12.1.0.
Only support imu fw loading for imu 12.1.0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c |  49 +++------
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c | 139 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.h |  30 ++++++
 4 files changed, 186 insertions(+), 35 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v12_1.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index f65021678fc07..d0c506a445695 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -159,7 +159,8 @@ amdgpu-y += \
 	imu_v11_0_3.o \
 	gfx_v12_0.o \
 	gfx_v12_1.o \
-	imu_v12_0.o
+	imu_v12_0.o \
+	imu_v12_1.o
 
 # add async DMA block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index a4886313d57d5..a1f9befc0841d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -30,7 +30,7 @@
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
 #include "amdgpu_atomfirmware.h"
-#include "imu_v12_0.h"
+#include "imu_v12_1.h"
 #include "soc_v1_0.h"
 #include "gfx_v12_1_pkt.h"
 
@@ -1065,27 +1065,19 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, GET_INST(GC, 0),
 		     regGFX_IMU_RLC_BOOTLOADER_SIZE, rlc_g_size);
 
-	if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
+	if (adev->gfx.imu.funcs) {
 		/* RLC autoload sequence 3: load IMU fw */
 		if (adev->gfx.imu.funcs->load_microcode)
 			adev->gfx.imu.funcs->load_microcode(adev);
-		/* RLC autoload sequence 4 init IMU fw */
-		if (adev->gfx.imu.funcs->setup_imu)
-			adev->gfx.imu.funcs->setup_imu(adev);
-		if (adev->gfx.imu.funcs->start_imu)
-			adev->gfx.imu.funcs->start_imu(adev);
-
-		/* RLC autoload sequence 5 disable gpa mode */
-		gfx_v12_1_xcc_disable_gpa_mode(adev, 0);
-	} else {
-		/* unhalt rlc to start autoload without imu */
-		data = RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPM_THREAD_ENABLE);
-		data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD0_ENABLE, 1);
-		data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD1_ENABLE, 1);
-		WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPM_THREAD_ENABLE, data);
-		WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CNTL, RLC_CNTL__RLC_ENABLE_F32_MASK);
 	}
 
+	/* unhalt rlc to start autoload */
+	data = RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPM_THREAD_ENABLE);
+	data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD0_ENABLE, 1);
+	data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD1_ENABLE, 1);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPM_THREAD_ENABLE, data);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CNTL, RLC_CNTL__RLC_ENABLE_F32_MASK);
+
 	return 0;
 }
 
@@ -2526,11 +2518,6 @@ static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
-		if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
-			/* RLC autoload sequence 1: Program rlc ram */
-			if (adev->gfx.imu.funcs->program_rlc_ram)
-				adev->gfx.imu.funcs->program_rlc_ram(adev);
-		}
 		/* rlc autoload firmware */
 		r = gfx_v12_1_rlc_backdoor_autoload_enable(adev);
 		if (r)
@@ -2539,16 +2526,12 @@ static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-			for (i = 0; i < num_xcc; i++) {
-				if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
-					if (adev->gfx.imu.funcs->load_microcode)
-						adev->gfx.imu.funcs->load_microcode(adev);
-					if (adev->gfx.imu.funcs->setup_imu)
-						adev->gfx.imu.funcs->setup_imu(adev);
-					if (adev->gfx.imu.funcs->start_imu)
-						adev->gfx.imu.funcs->start_imu(adev);
-				}
+			if (adev->gfx.imu.funcs) {
+				if (adev->gfx.imu.funcs->load_microcode)
+					adev->gfx.imu.funcs->load_microcode(adev);
+			}
 
+			for (i = 0; i < num_xcc; i++) {
 				/* disable gpa mode in backdoor loading */
 				gfx_v12_1_xcc_disable_gpa_mode(adev, i);
 			}
@@ -3730,14 +3713,12 @@ static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev)
 
 static void gfx_v12_1_set_imu_funcs(struct amdgpu_device *adev)
 {
-#if 0
 	if (adev->flags & AMD_IS_APU)
 		adev->gfx.imu.mode = MISSION_MODE;
 	else
 		adev->gfx.imu.mode = DEBUG_MODE;
 
-	adev->gfx.imu.funcs = &gfx_v12_0_imu_funcs;
-#endif
+	adev->gfx.imu.funcs = &gfx_v12_1_imu_funcs;
 }
 
 static void gfx_v12_1_set_rlc_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
new file mode 100644
index 0000000000000..28932604d986d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -0,0 +1,139 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/firmware.h>
+#include "amdgpu.h"
+#include "amdgpu_imu.h"
+#include "amdgpu_dpm.h"
+
+#include "imu_v12_1.h"
+
+#include "gc/gc_12_1_0_offset.h"
+#include "gc/gc_12_1_0_sh_mask.h"
+#include "mmhub/mmhub_4_2_0_offset.h"
+
+MODULE_FIRMWARE("amdgpu/gc_12_1_0_imu.bin");
+
+#define TRANSFER_RAM_MASK	0x001c0000
+
+static int imu_v12_1_init_microcode(struct amdgpu_device *adev)
+{
+	char ucode_prefix[15];
+	int err;
+	const struct imu_firmware_header_v1_0 *imu_hdr;
+	struct amdgpu_firmware_info *info = NULL;
+
+	DRM_DEBUG("\n");
+
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
+	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_imu.bin", ucode_prefix);
+	if (err)
+		goto out;
+
+	imu_hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
+	adev->gfx.imu_fw_version = le32_to_cpu(imu_hdr->header.ucode_version);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_I];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_I;
+		info->fw = adev->gfx.imu_fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(imu_hdr->imu_iram_ucode_size_bytes), PAGE_SIZE);
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_D];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_D;
+		info->fw = adev->gfx.imu_fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(imu_hdr->imu_dram_ucode_size_bytes), PAGE_SIZE);
+	}
+
+out:
+	if (err) {
+		dev_err(adev->dev,
+			"gfx12: Failed to load firmware \"%s_imu.bin\"\n",
+			ucode_prefix);
+		amdgpu_ucode_release(&adev->gfx.imu_fw);
+	}
+
+	return err;
+}
+
+static void imu_v12_1_xcc_load_microcode(struct amdgpu_device *adev,
+					 int xcc_id)
+{
+	const struct imu_firmware_header_v1_0 *hdr;
+	const __le32 *fw_data;
+	unsigned i, fw_size;
+
+	hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
+	fw_data = (const __le32 *)(adev->gfx.imu_fw->data +
+			le32_to_cpu(hdr->header.ucode_array_offset_bytes));
+	fw_size = le32_to_cpu(hdr->imu_iram_ucode_size_bytes) / 4;
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGFX_IMU_I_RAM_ADDR, 0);
+
+	for (i = 0; i < fw_size; i++)
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+			     regGFX_IMU_I_RAM_DATA,
+			     le32_to_cpup(fw_data++));
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+		     regGFX_IMU_I_RAM_ADDR,
+		     adev->gfx.imu_fw_version);
+
+	fw_data = (const __le32 *)(adev->gfx.imu_fw->data +
+			le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
+			le32_to_cpu(hdr->imu_iram_ucode_size_bytes));
+	fw_size = le32_to_cpu(hdr->imu_dram_ucode_size_bytes) / 4;
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGFX_IMU_D_RAM_ADDR, 0);
+
+	for (i = 0; i < fw_size; i++)
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+			     regGFX_IMU_D_RAM_DATA,
+			     le32_to_cpup(fw_data++));
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+		     regGFX_IMU_D_RAM_ADDR,
+		     adev->gfx.imu_fw_version);
+}
+
+static int imu_v12_1_load_microcode(struct amdgpu_device *adev)
+{
+	int i, num_xcc;
+
+	if (!adev->gfx.imu_fw)
+		return -EINVAL;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
+		imu_v12_1_xcc_load_microcode(adev, i);
+	}
+
+	return 0;
+}
+
+const struct amdgpu_imu_funcs gfx_v12_1_imu_funcs = {
+	.init_microcode = imu_v12_1_init_microcode,
+	.load_microcode = imu_v12_1_load_microcode,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.h b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.h
new file mode 100644
index 0000000000000..4a7c12bf7b0fb
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __IMU_V12_1_H__
+#define __IMU_V12_1_H__
+
+extern const struct amdgpu_imu_funcs gfx_v12_1_imu_funcs;
+
+#endif
+
-- 
2.51.1

