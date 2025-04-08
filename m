Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2F5C3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 08:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3D610E60E;
	Tue,  8 Apr 2025 08:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hGpblyim";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C8FC10E60E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 08:37:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfUDo/FzEsZ5NmPtSVYwFyhzflq8paHwQCXf6wXIfov4QiX/5jaddkEfMzDzUH10J6TMmcyHzyk3FelgGIjY2MrwE3j2k+1+W9U8m1iOsAjtWhMMwTPdAp7WNYaZkBe+aWnWJFII9NS04qa5KPAzo7uaKySgS0HG72iaTdkO5SuMbsyjB8WTa74Cz9Hjsv+YYXpYwMrCasB5n6kI0qPBQtmNlSM7DrX7BvKfJzZtRqn8OPdsLvoC0ZLFb2Yzz+nUeFNHkhkpKQ9PWOEGzCJdgo4/UZ2jlAbHm6tGDmkF2nVi5eAyWb4owIAYvRsb7RkN3R8vUwVfsu8BEZy2Wq3ROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEjWZADeBmaEz+hFixgts7rLlfxzr+dEiGU7wwZcGRk=;
 b=aPxUVaelOslZL/qtITSbdk5zZkZ339tAedE9eafYwpJTDLOF8xkpEISvPe8/lwte+6yiqtBX3wqAvaL8xMdjASC7h3rDbvVcXhOOnv8mp7gf7n1N9B+bGl4fypUEypvHeT8Ti7Eb6by7Ih//A7xitw/zY/3PJqoI1SfPzphGlI07OSk2jn5xEZJTHOYu5iVSyVVf0O+WHusoMWkUQrqJNetoU+GrqEHlICvN8MT6TSPX87ErdAISVt4h7r4h2xfJegiDUFLiMfTNIcAOj1kZF2YxdieAs1Fpi0Pxoy13bngP1IpIwgookUZqCnQaNOfWrnt9NqrfhqgVR6ttrP6lHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEjWZADeBmaEz+hFixgts7rLlfxzr+dEiGU7wwZcGRk=;
 b=hGpblyimMJXN97UrUUKPr8jgwQjZPMjjouInIIXA7iWiBWs7ibVcSPl47lN52Vl6A1rXFHpbegRn3HrQP3BW0loP9Nk4+gQahxfEi2FaZcdtFb2S9o2I/qr0GZZwPyO5O65qa/Gcv7xz7gGQV6LDF/+DYtSmcw/SwJxXGoCloNk=
Received: from CH2PR08CA0012.namprd08.prod.outlook.com (2603:10b6:610:5a::22)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 08:37:00 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com (2603:10b6:610:5a::4)
 by CH2PR08CA0012.outlook.office365.com (2603:10b6:610:5a::22) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33
 via Frontend Transport; Tue, 8 Apr 2025 08:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 08:37:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:36:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:36:58 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 8 Apr 2025 03:36:46 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [v4 2/7] drm/amd/amdgpu: Implement SDMA soft reset directly for sdma
 v5
Date: Tue, 8 Apr 2025 16:36:28 +0800
Message-ID: <20250408083633.2300420-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408083633.2300420-1-jesse.zhang@amd.com>
References: <20250408083633.2300420-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 9958c0dd-2aee-45f0-ad2c-08dd767887bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Euk3TjnxTvTQ9hbZZ801D92Z1rPLnt2RZcpR6Jkb73dsdQgTjS0Ysu/dW59+?=
 =?us-ascii?Q?Szx+33eZcufqgu/16jDrMJ5griwzUmFyY5yrxvqHFu8URMluBj6fpssKtSpb?=
 =?us-ascii?Q?oKHgRvNCtiMbXMtdHm+v1lhFL4mjHsZQmjy/ESUIJDhzQFoj7asN0NjAajcR?=
 =?us-ascii?Q?gh1W9uQWeUlglXEogNQghCJxDX+1KXvkd9bBxPPii2BRLKi9Xn/Q1r07YlD5?=
 =?us-ascii?Q?koJSnKvvwpAkkpktr8XHrlicUoUYOJR7JXgHOJFgjOmYbYuT5SUn3Wxjg4J9?=
 =?us-ascii?Q?R5xPAunmlfKSg6nBxn8HnUXyEl3i3DUQf1CH7/5dfiNAYFtMOx6pPIN3GEA6?=
 =?us-ascii?Q?B8hxsGS9f9wVgvbbRROlTpISsWBSxj5RBFQv2lIm9DhYKu82aw4iQ9GLCuET?=
 =?us-ascii?Q?2dxoJPlLAqPiwdd33yFqdTtpbSG4ynZqFgvsi4Ak53wK/HyuEllsPwvNZao/?=
 =?us-ascii?Q?oGPxegKUCaCGev05iQP1UvESAdL2JFYc7fiUYzDUQrOd3mIkGjFlEO3pcVns?=
 =?us-ascii?Q?9n+e7TjEHn0rCI2zia3oiuioxhIcug7wQPVQc3Cx75fV2RY+pfGs4ibIgtFt?=
 =?us-ascii?Q?mXt0aN3Kqg+UrnhF/Q2eplS+O9qPS9GJetVKfnrjsnQvBsWLgYeAwBLMYmRc?=
 =?us-ascii?Q?QEKcD9IcMIEjeOGZogcA1yWrbz1CTTaCg/Jz5sjMAXkoAAxfCu7+7GuWHJ5f?=
 =?us-ascii?Q?IdR6DIzkhEEYBohliAZlKOC3h0GLtVgVAFW4ICL9g0eQfq/tsa0IBubBhK5N?=
 =?us-ascii?Q?hrMfUyl3VPsNs4+cZV09eoSIjySMXNpXNzVh4SDb+v8RycY5qP+z3MIxFCX9?=
 =?us-ascii?Q?xdh649PNw8oTxnVLW/8/GtZIiqqLZpXAMBgZXD9Qx8yvmenW+iT6r6A1CC/z?=
 =?us-ascii?Q?ZkoX6genj6aAnY6pFaGcaZFuwljJCvoTa+0+nVYhaQzp3RDPZVzJWv2H06aF?=
 =?us-ascii?Q?lrD6HtiWYB+JEDzi5fvujn74hOucUvfEnl2TmfmQQ99EXfExFEeStDSnjIWu?=
 =?us-ascii?Q?QhB3N2LeBV2sRmv5J6JWPwLK8mQQaRf0MNo+3kzHNQpfiF56Qii/poCw1nyt?=
 =?us-ascii?Q?4kK9L7hlUSPcz9YUz9xjuVyN5GkOlg2x5TURIoX0TP0Nv+NsNjjJhciW5zm+?=
 =?us-ascii?Q?M+6I4RliONP8HQwi1/DuSRc8g69ucwf6ZD8GOm7N2KacL678ALfx1Qukngo3?=
 =?us-ascii?Q?5recnL8TbCukWyv57AFtq4pETnR251rKJCmG2oRI4KG6DlDmG2q8FfheyZWl?=
 =?us-ascii?Q?nQszTLgC34HVpGrRAvZQN5mX3b5Kddz/u1SEowHoEhuPKupEZhhARXeffyzd?=
 =?us-ascii?Q?Nca/gf30bne9i+OPVgt9mJSGtFNlywe8NaQlNFPgUfcZKJ8275a/rRiQ/l2o?=
 =?us-ascii?Q?0MC+yZeiTvKBBfm4j2f/NLXrYX/rf+tfa4RhhBU8DV9ktOTZh9xZ6ucttiUJ?=
 =?us-ascii?Q?zq4u7Lb8cHctMdbFh+F41L3ulV3oCXpLYKQ/qFqYtXDM7s5rRxvVqzzfIClo?=
 =?us-ascii?Q?x9J7BifPQ+NvRD8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:37:00.1336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9958c0dd-2aee-45f0-ad2c-08dd767887bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch introduces a new function `amdgpu_sdma_soft_reset` to handle SDMA soft resets directly,
rather than relying on the DPM interface.

1. **New `amdgpu_sdma_soft_reset` Function**:
   - Implements a soft reset for SDMA engines by directly writing to the hardware registers.
   - Handles SDMA versions 4.x and 5.x separately:
     - For SDMA 4.x, the existing `amdgpu_dpm_reset_sdma` function is used for backward compatibility.
     - For SDMA 5.x, the driver directly manipulates the `GRBM_SOFT_RESET` register to reset the specified SDMA instance.

2. **Integration into `amdgpu_sdma_reset_engine`**:
   - The `amdgpu_sdma_soft_reset` function is called during the SDMA reset process, replacing the previous call to `amdgpu_dpm_reset_sdma`.

v2: move soft reset into a helper funciton (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 38 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 29 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 45 +++++++++++++++---------
 4 files changed, 95 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 541b349e0310..96d0350c7754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -26,6 +26,8 @@
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
+#include "gc/gc_10_1_0_offset.h"
+#include "gc/gc_10_3_0_sh_mask.h"
 
 #define AMDGPU_CSA_SDMA_SIZE 64
 /* SDMA CSA reside in the 3rd page of CSA */
@@ -553,6 +555,40 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
 	list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
 }
 
+static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
+{
+	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
+	int r = 0;
+
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(4, 4, 2):
+	case IP_VERSION(4, 4, 4):
+	case IP_VERSION(4, 4, 5):
+		/* For SDMA 4.x, use the existing DPM interface for backward compatibility */
+		r = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+		break;
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 1):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 5):
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 4):
+	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 6):
+	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 1):
+	case IP_VERSION(5, 2, 7):
+		if (sdma_instance->funcs->soft_reset_kernel_queue)
+			r = sdma_instance->funcs->soft_reset_kernel_queue(adev, instance_id);
+		break;
+	default:
+		break;
+	}
+
+	return r;
+}
+
 /**
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
@@ -587,7 +623,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		sdma_instance->funcs->stop_kernel_queue(sdma_gfx_ring);
 
 	/* Perform the SDMA reset for the specified instance */
-	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+	ret = amdgpu_sdma_soft_reset(adev, instance_id);
 	if (ret) {
 		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
 		goto exit;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 620fd7663526..bf83d6646238 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -53,6 +53,7 @@ enum amdgpu_sdma_irq {
 struct amdgpu_sdma_funcs {
 	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
 	int (*start_kernel_queue)(struct amdgpu_ring *ring);
+	int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32 instance_id);
 };
 
 struct amdgpu_sdma_instance {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index e1348b6d9c6a..d516add85dd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1323,6 +1323,34 @@ static void sdma_v5_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 	amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
 }
 
+static int sdma_v5_0_soft_reset_engine(struct amdgpu_device *adev, u32 instance_id)
+{
+	u32 grbm_soft_reset;
+	u32 tmp;
+
+	grbm_soft_reset = REG_SET_FIELD(0,
+					GRBM_SOFT_RESET, SOFT_RESET_SDMA0,
+					1);
+	grbm_soft_reset <<= instance_id;
+
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	tmp |= grbm_soft_reset;
+	DRM_DEBUG("GRBM_SOFT_RESET=0x%08X\n", tmp);
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+
+	udelay(50);
+
+	tmp &= ~grbm_soft_reset;
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	return 0;
+}
+
+static const struct amdgpu_sdma_funcs sdma_v5_0_sdma_funcs = {
+	.soft_reset_kernel_queue = &sdma_v5_0_soft_reset_engine,
+};
+
 static int sdma_v5_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1365,6 +1393,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
+		adev->sdma.instance[i].funcs = &sdma_v5_0_sdma_funcs;
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 964f12afac9e..6f9a5ff7880e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -759,37 +759,47 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int sdma_v5_2_soft_reset(struct amdgpu_ip_block *ip_block)
+static int sdma_v5_2_soft_reset_engine(struct amdgpu_device *adev, u32 instance_id)
 {
-	struct amdgpu_device *adev = ip_block->adev;
 	u32 grbm_soft_reset;
 	u32 tmp;
-	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		grbm_soft_reset = REG_SET_FIELD(0,
-						GRBM_SOFT_RESET, SOFT_RESET_SDMA0,
-						1);
-		grbm_soft_reset <<= i;
+	grbm_soft_reset = REG_SET_FIELD(0,
+					GRBM_SOFT_RESET, SOFT_RESET_SDMA0,
+					1);
+	grbm_soft_reset <<= instance_id;
 
-		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-		tmp |= grbm_soft_reset;
-		DRM_DEBUG("GRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	tmp |= grbm_soft_reset;
+	DRM_DEBUG("GRBM_SOFT_RESET=0x%08X\n", tmp);
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
 
-		udelay(50);
+	udelay(50);
+
+	tmp &= ~grbm_soft_reset;
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	return 0;
+}
 
-		tmp &= ~grbm_soft_reset;
-		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+static int sdma_v5_2_soft_reset(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		sdma_v5_2_soft_reset_engine(adev, i);
 		udelay(50);
 	}
 
 	return 0;
 }
 
+static const struct amdgpu_sdma_funcs sdma_v5_2_sdma_funcs = {
+	.soft_reset_kernel_queue = &sdma_v5_2_soft_reset_engine,
+};
+
 /**
  * sdma_v5_2_start - setup and start the async dma engines
  *
@@ -1302,6 +1312,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
+		adev->sdma.instance[i].funcs = &sdma_v5_2_sdma_funcs;
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
-- 
2.25.1

