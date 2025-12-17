Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA311D6409B
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 793FE10E009;
	Wed, 17 Dec 2025 15:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ejYuKSy";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A4D410E009
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+6+CggJke5GJJleSQ07uoXxzIwtqpi4iyNTI2TypMX/WKN+L7Hl3zdHE7RCBt8/MI3Y8f5QYPZPDzfzcTo+zLOVnNGVtnTGeD/vLJ4cRLyojwkvX2Q8eyGAtHDNRtP9zUkuMNA42kr6tKrYyJHp/xiDzMtR+Pgz6nlvEG10aEui/AinyDZ5EgyyzJICuXFA7Nrc2Amn2/7MCeGa7WbiiORQMmN1jMyPoZxKUSt7AHZZRZNT2O/8FYNUvlLtg8MQVtb6QOtFLBKPrFkrUG0dNvqTwL4d5SQa81dCppGZ4DOj1Nf5R59znbCCW4YUoD/6EmJYWNCLewzbmIJhxE6CEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tioF/em9ehvBj2reod/JHNu/KpRlfkGyeTfUsAgomwU=;
 b=YS+/+mzadejBG6Fs/aWBSoPe+5hyK9ono5qfpv+/2l/eRm87PtLCL9R8Lons+G6c46EodYwdu/PyrAwEkw410ys9bORyqRBhA5e8+4UCj5Aid2N1/bxnXI0Is5kjdgx/fAuiB1kye1ct3bHiD0MgQBESr6Qh9NTiWPS6bZO/eNCsMTL4glzqHzoedFkihUcAyqLzkT0yr03GQ/tCWNd2PdOsE96MJv2XU+J2SANWovuYzkODhvR7CxYOsGACVHueoJKQ6DK1A6GMeufuK+ez3hbYK46nVtYUqOf12Ycfwhk3Zh+fY6MB3pUSZW2fS1+4+ZIO64M5XqOSX/t0xXTxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tioF/em9ehvBj2reod/JHNu/KpRlfkGyeTfUsAgomwU=;
 b=4ejYuKSymrzWDYImwWOc9fuBwgjfJY7d3+49RMwZozgXGaxws1TRcxHRGSrOIj3mG3IaW0E9HorIF3vAPhnPxzURJ/A9xyJPfbZkwKh5ba8+/1YUoXFuACVj44/zQCuucBsL10JgjCEYYrzUqISC07LFvXoKwBeQR9P865Etno8=
Received: from BN9PR03CA0405.namprd03.prod.outlook.com (2603:10b6:408:111::20)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:35:40 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::8f) by BN9PR03CA0405.outlook.office365.com
 (2603:10b6:408:111::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 15:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 15:35:40 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 09:35:37 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/jpeg: Add jpeg 5.3.0 support
Date: Wed, 17 Dec 2025 10:35:18 -0500
Message-ID: <20251217153521.2018841-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217153521.2018841-1-alexander.deucher@amd.com>
References: <20251217153521.2018841-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 77960229-77c2-41cf-c0d8-08de3d81eee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZTv1oE7b0qeoPE0JzGanZskfULPPlIy5UPY0tlpPWGPJwjhFrGUXzQ4B9oCD?=
 =?us-ascii?Q?LXkHRIyi7CLWKqDU+D2gHcYw8rtuHC9ZbRFKxq4+ce/dt1XlozHM0/KjsQK6?=
 =?us-ascii?Q?75MkQeHxRYrrWC9JdtV2pVcAWIGwu5XMulnZ+VtyfP/zqQ09y994BE+AHvc2?=
 =?us-ascii?Q?MFSBAN+q9qcP9/CoGrQCMLwKzayGgEhK+4tzZ0GN6iaubI8cf5nt/WxWe4IL?=
 =?us-ascii?Q?KPOUJzlO4DQ+LCE3qstkIgYd7KMXWB1B8m3yvzQyWvupz8ErMcasyT9X7iE/?=
 =?us-ascii?Q?vZRtSlEufFM7/QWGWd0CQd5vfw7+kzLMrHvmSEFK4IdXotJDO1NbS3MC5zby?=
 =?us-ascii?Q?F5YUWKNb/wKMlsP/zbfcrdB8PkBEy2VFmQCgZ8hb9h7r1UoIfy66s1eCph3N?=
 =?us-ascii?Q?NL4fcCCMmlJYpWvJCAOqvK+DyxPWlV/ZiFsJRcHv5wCCnu9iivLDEpIsOfG7?=
 =?us-ascii?Q?mgOimurGgItN+/6NbjR+CugcDb4wCMZq8nU03D8MoWMXjvCuK+w3HM9ohjex?=
 =?us-ascii?Q?Pn32AmBvuFtLv3QX1HuQeUPGx5O2dDBu6KreQddRJi+EA/sZyIXRkQ6S9jni?=
 =?us-ascii?Q?S247lD85eNDsHmJ5fmypi0UJG3ylD00tdeu62kmXyystjRD9LSf7Cx77c+1/?=
 =?us-ascii?Q?/qmNGw0KAwJirl/sS1lOX8UanDMrWPYchjnK3184yPrvPGrHSZfJU3ivm+b4?=
 =?us-ascii?Q?gnxBYdgVCwGC1nbNYBp52x8h9SjcKV5mFwnxbUoecFP19wrO6HXWznnpYZMJ?=
 =?us-ascii?Q?pmGDzEIqFxXeNQjK56UqsIEK3rj6e2I8aAi3mNzwBcaPmv0saHcFAmopGZMk?=
 =?us-ascii?Q?SZ6R9oOi//EW9xIliwyEKyCLF/kW6T3POpXVnMZ/1kK01S8IHXsidVsUI0s4?=
 =?us-ascii?Q?+mDSBfGnHlILzZsTVL8ewd9Jcy6pDqLNNufq/Ytu1bvvx+ej3mnscFytpAh0?=
 =?us-ascii?Q?SCgvEnBGseRelFY88BE+1Zv5TdA6Ypi35RKRTm4jyNLkHREKFUUQY42wPmu0?=
 =?us-ascii?Q?cNnp8mqO4P/y4jtOjeNEaHytCR2bWTjPw+JEN9WcsEAB9ELYaj9DsWhb3eO6?=
 =?us-ascii?Q?xz0KfG/ae8Zt8GSg0I08yWNPm9pArB8QtA+KShoWPq/Sv50ZB69KpvqdIUU0?=
 =?us-ascii?Q?b2iDMj6l4+SPFgDkekKvG0M6Py2XoLKyUu47VjxUFmKoehr8rmFAVZEwDK7p?=
 =?us-ascii?Q?Q606YvrY26dnzN9RMmrqC1d4kI4wDBl+kpQXrE80hTeDnspsxipFFgtcrHYd?=
 =?us-ascii?Q?ErT9DlYz74p6VdEEj4FyCKXce5gZZS4NR1VCk0ePIvFaa/wFIZZGt4V4Kte4?=
 =?us-ascii?Q?ZsU2b43l3B9zJqIT+nVFHhjy32zTOmRBDlYHWBfrsDZHIAgYVFU9YAEioVOS?=
 =?us-ascii?Q?375egXtxTL7+kK0EZknhmnOWVUYwCXtBPYnlKqBky4/V3TPKQxc+aqJFBybn?=
 =?us-ascii?Q?zZxHXMvITmBF/0U/41G3dJC6FvZqOLoYFWDp0NcknZ1RGnVZh3sFPIhDbCIR?=
 =?us-ascii?Q?VMhC3KnSyCADMSvWzUAub1aUvSzYyaHaB6RCIFdU0PgWhwvNLJAegwKTP3iU?=
 =?us-ascii?Q?ZQ39vye6AM/t68E6B0s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:35:40.0676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77960229-77c2-41cf-c0d8-08de3d81eee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
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

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Add the Jpeg IP v5_3_0 code base.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 695 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h |  35 ++
 3 files changed, 732 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index d0c506a445695..4b9cb9b681b65 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -221,7 +221,8 @@ amdgpu-y += \
 	jpeg_v4_0_3.o \
 	jpeg_v4_0_5.o \
 	jpeg_v5_0_0.o \
-	jpeg_v5_0_1.o
+	jpeg_v5_0_1.o \
+	jpeg_v5_3_0.o
 
 # add VPE block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
new file mode 100644
index 0000000000000..084e592fb838f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -0,0 +1,695 @@
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
+#include "amdgpu.h"
+#include "amdgpu_jpeg.h"
+#include "amdgpu_pm.h"
+#include "soc15.h"
+#include "soc15d.h"
+#include "jpeg_v2_0.h"
+#include "jpeg_v4_0_3.h"
+
+#include "vcn/vcn_5_3_0_offset.h"
+#include "vcn/vcn_5_3_0_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
+#include "jpeg_v5_3_0.h"
+
+static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
+static void jpeg_v5_3_0_set_irq_funcs(struct amdgpu_device *adev);
+static int jpeg_v5_3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+				enum amd_powergating_state state);
+
+
+/**
+ * jpeg_v5_3_0_early_init - set function pointers
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Set ring and irq function pointers
+ */
+static int jpeg_v5_3_0_early_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->jpeg.num_jpeg_inst = 1;
+	adev->jpeg.num_jpeg_rings = 1;
+
+	jpeg_v5_3_0_set_dec_ring_funcs(adev);
+	jpeg_v5_3_0_set_irq_funcs(adev);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_3_0_sw_init - sw init for JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Load firmware and sw initialization
+ */
+static int jpeg_v5_3_0_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ring *ring;
+	int r;
+
+	/* JPEG TRAP */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		VCN_5_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_sw_init(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_resume(adev);
+	if (r)
+		return r;
+
+	ring = adev->jpeg.inst->ring_dec;
+	ring->use_doorbell = true;
+	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
+
+	sprintf(ring->name, "jpeg_dec");
+	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
+			     AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (r)
+		return r;
+
+	adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
+	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
+
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+	return 0;
+}
+
+/**
+ * jpeg_v5_3_0_sw_fini - sw fini for JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * JPEG suspend and free up sw allocation
+ */
+static int jpeg_v5_3_0_sw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_jpeg_suspend(adev);
+	if (r)
+		return r;
+
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+	r = amdgpu_jpeg_sw_fini(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v5_3_0_hw_init - start and test JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ */
+static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int r;
+
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+			(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
+
+	/* Skip ring test because pause DPG is not implemented. */
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG)
+		return 0;
+
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_3_0_hw_fini - stop the hardware block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Stop the JPEG block, mark ring as not ready any more
+ */
+static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+
+	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
+	      RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
+		jpeg_v5_3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_3_0_suspend - suspend JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * HW fini and suspend JPEG block
+ */
+static int jpeg_v5_3_0_suspend(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+
+	r = jpeg_v5_3_0_hw_fini(ip_block);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_suspend(ip_block->adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v5_3_0_resume - resume JPEG block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Resume firmware and hw init JPEG block
+ */
+static int jpeg_v5_3_0_resume(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+
+	r = amdgpu_jpeg_resume(ip_block->adev);
+	if (r)
+		return r;
+
+	r = jpeg_v5_3_0_hw_init(ip_block);
+
+	return r;
+}
+
+static void jpeg_v5_3_0_disable_clock_gating(struct amdgpu_device *adev)
+{
+	uint32_t data = 0;
+
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
+
+	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
+	data &= ~(JPEG_CGC_CTRL__JPEG0_DEC_MODE_MASK
+		| JPEG_CGC_CTRL__JPEG_ENC_MODE_MASK);
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
+}
+
+static void jpeg_v5_3_0_enable_clock_gating(struct amdgpu_device *adev)
+{
+	uint32_t data = 0;
+
+	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
+
+	data |= 1 << JPEG_CGC_CTRL__JPEG0_DEC_MODE__SHIFT;
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
+
+	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
+	data |= (JPEG_CGC_GATE__JPEG0_DEC_MASK
+		|JPEG_CGC_GATE__JPEG_ENC_MASK
+		|JPEG_CGC_GATE__JMCIF_MASK
+		|JPEG_CGC_GATE__JRBBM_MASK);
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
+}
+
+static int jpeg_v5_3_0_disable_power_gating(struct amdgpu_device *adev)
+{
+	uint32_t data = 0;
+
+	data = 1 << UVD_IPX_DLDO_CONFIG_ONO1__ONO1_PWR_CONFIG__SHIFT;
+	WREG32_SOC15(JPEG, 0, regUVD_IPX_DLDO_CONFIG_ONO1, data);
+	SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS, 0,
+			UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
+
+	/* disable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	return 0;
+}
+
+static int jpeg_v5_3_0_enable_power_gating(struct amdgpu_device *adev)
+{
+	/* enable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+		UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
+		WREG32(SOC15_REG_OFFSET(JPEG, 0, regUVD_IPX_DLDO_CONFIG_ONO1),
+			2 << UVD_IPX_DLDO_CONFIG_ONO1__ONO1_PWR_CONFIG__SHIFT);
+		SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS,
+			1 << UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS__SHIFT,
+			UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
+	}
+
+	return 0;
+}
+
+static void jpeg_engine_5_0_0_dpg_clock_gating_mode(struct amdgpu_device *adev,
+	       int inst_idx, uint8_t indirect)
+{
+	uint32_t data = 0;
+
+	// JPEG disable CGC
+	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
+		data = 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data = 0 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+
+	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+
+	if (indirect) {
+		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_CTRL, data, indirect);
+
+		// Turn on All JPEG clocks
+		data = 0;
+		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
+	} else {
+		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_CTRL, data, indirect);
+
+		// Turn on All JPEG clocks
+		data = 0;
+		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
+	}
+}
+
+/**
+ * jpeg_v5_3_0_start_dpg_mode - Jpeg start with dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ * @indirect: indirectly write sram
+ *
+ * Start JPEG block with dpg mode
+ */
+static int jpeg_v5_3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+{
+	struct amdgpu_ring *ring = adev->jpeg.inst[inst_idx].ring_dec;
+	uint32_t reg_data = 0;
+
+	jpeg_v5_3_0_enable_power_gating(adev);
+
+	// enable dynamic power gating mode
+	reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
+	reg_data |= UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
+
+	if (indirect)
+		adev->jpeg.inst[inst_idx].dpg_sram_curr_addr =
+			(uint32_t *)adev->jpeg.inst[inst_idx].dpg_sram_cpu_addr;
+
+	jpeg_engine_5_0_0_dpg_clock_gating_mode(adev, inst_idx, indirect);
+
+	/* MJPEG global tiling registers */
+	if (indirect)
+		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
+			adev->gfx.config.gb_addr_config, indirect);
+	else
+		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
+			adev->gfx.config.gb_addr_config, 1);
+
+	/* enable System Interrupt for JRBC */
+	if (indirect)
+		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_SYS_INT_EN,
+			JPEG_SYS_INT_EN__DJRBC0_MASK, indirect);
+	else
+		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_SYS_INT_EN,
+			JPEG_SYS_INT_EN__DJRBC0_MASK, 1);
+
+	if (indirect) {
+		/* add nop to workaround PSP size check */
+		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipUVD_NO_OP, 0, indirect);
+
+		amdgpu_jpeg_psp_update_sram(adev, inst_idx, 0);
+	}
+
+	WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
+		ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+		VCN_JPEG_DB_CTRL__EN_MASK);
+
+	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_VMID, 0);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_RPTR, 0);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_WPTR, 0);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_CNTL, 0x00000002L);
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_SIZE, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_WPTR);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_3_0_stop_dpg_mode - Jpeg stop with dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ *
+ * Stop JPEG block with dpg mode
+ */
+static void jpeg_v5_3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+{
+	uint32_t reg_data = 0;
+
+	reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
+	reg_data &= ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
+	WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
+}
+
+/**
+ * jpeg_v5_3_0_start - start JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Setup and start the JPEG block
+ */
+static int jpeg_v5_3_0_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int r;
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_jpeg(adev, true);
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
+		r = jpeg_v5_3_0_start_dpg_mode(adev, 0, adev->jpeg.indirect_sram);
+		return r;
+	}
+
+	/* disable power gating */
+	r = jpeg_v5_3_0_disable_power_gating(adev);
+	if (r)
+		return r;
+
+	/* JPEG disable CGC */
+	jpeg_v5_3_0_disable_clock_gating(adev);
+
+	/* MJPEG global tiling registers */
+	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+
+	/* enable JMI channel */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	/* enable System Interrupt for JRBC */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regJPEG_SYS_INT_EN),
+		JPEG_SYS_INT_EN__DJRBC0_MASK,
+		~JPEG_SYS_INT_EN__DJRBC0_MASK);
+
+	WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
+		ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+		VCN_JPEG_DB_CTRL__EN_MASK);
+
+	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_VMID, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, 0x00000002L);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_SIZE, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_3_0_stop - stop JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * stop the JPEG block
+ */
+static int jpeg_v5_3_0_stop(struct amdgpu_device *adev)
+{
+	int r;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
+		jpeg_v5_3_0_stop_dpg_mode(adev, 0);
+	} else {
+
+		/* reset JMI */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
+			UVD_JMI_CNTL__SOFT_RESET_MASK,
+			~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+		jpeg_v5_3_0_enable_clock_gating(adev);
+
+		/* enable power gating */
+		r = jpeg_v5_3_0_enable_power_gating(adev);
+		if (r)
+			return r;
+	}
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_jpeg(adev, false);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_3_0_dec_ring_get_rptr - get read pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware read pointer
+ */
+static uint64_t jpeg_v5_3_0_dec_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	return RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR);
+}
+
+/**
+ * jpeg_v5_3_0_dec_ring_get_wptr - get write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware write pointer
+ */
+static uint64_t jpeg_v5_3_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell)
+		return *ring->wptr_cpu_addr;
+	else
+		return RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR);
+}
+
+/**
+ * jpeg_v5_3_0_dec_ring_set_wptr - set write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Commits the write pointer to the hardware
+ */
+static void jpeg_v5_3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell) {
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
+	} else {
+		WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
+	}
+}
+
+static bool jpeg_v5_3_0_is_idle(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 1;
+
+	ret &= (((RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS) &
+		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
+
+	return ret;
+}
+
+static int jpeg_v5_3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	return SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS,
+		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+}
+
+static int jpeg_v5_3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+
+	if (enable) {
+		if (!jpeg_v5_3_0_is_idle(ip_block))
+			return -EBUSY;
+		jpeg_v5_3_0_enable_clock_gating(adev);
+	} else {
+		jpeg_v5_3_0_disable_clock_gating(adev);
+	}
+
+	return 0;
+}
+
+static int jpeg_v5_3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret;
+
+	if (state == adev->jpeg.cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = jpeg_v5_3_0_stop(adev);
+	else
+		ret = jpeg_v5_3_0_start(adev);
+
+	if (!ret)
+		adev->jpeg.cur_state = state;
+
+	return ret;
+}
+
+static int jpeg_v5_3_0_set_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+static int jpeg_v5_3_0_process_interrupt(struct amdgpu_device *adev,
+				      struct amdgpu_irq_src *source,
+				      struct amdgpu_iv_entry *entry)
+{
+	DRM_DEBUG("IH: JPEG TRAP\n");
+
+	switch (entry->src_id) {
+	case VCN_5_0__SRCID__JPEG_DECODE:
+		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
+		break;
+	default:
+		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
+			  entry->src_id, entry->src_data[0]);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs = {
+	.name = "jpeg_v5_3_0",
+	.early_init = jpeg_v5_3_0_early_init,
+	.sw_init = jpeg_v5_3_0_sw_init,
+	.sw_fini = jpeg_v5_3_0_sw_fini,
+	.hw_init = jpeg_v5_3_0_hw_init,
+	.hw_fini = jpeg_v5_3_0_hw_fini,
+	.suspend = jpeg_v5_3_0_suspend,
+	.resume = jpeg_v5_3_0_resume,
+	.is_idle = jpeg_v5_3_0_is_idle,
+	.wait_for_idle = jpeg_v5_3_0_wait_for_idle,
+	.set_clockgating_state = jpeg_v5_3_0_set_clockgating_state,
+	.set_powergating_state = jpeg_v5_3_0_set_powergating_state,
+};
+
+static const struct amdgpu_ring_funcs jpeg_v5_3_0_dec_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_JPEG,
+	.align_mask = 0xf,
+	.get_rptr = jpeg_v5_3_0_dec_ring_get_rptr,
+	.get_wptr = jpeg_v5_3_0_dec_ring_get_wptr,
+	.set_wptr = jpeg_v5_3_0_dec_ring_set_wptr,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
+		8 + /* jpeg_v5_3_0_dec_ring_emit_vm_flush */
+		22 + 22 + /* jpeg_v5_3_0_dec_ring_emit_fence x2 vm fence */
+		8 + 16,
+	.emit_ib_size = 22, /* jpeg_v5_3_0_dec_ring_emit_ib */
+	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
+	.emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
+	.emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
+	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
+	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
+	.insert_nop = jpeg_v4_0_3_dec_ring_nop,
+	.insert_start = jpeg_v4_0_3_dec_ring_insert_start,
+	.insert_end = jpeg_v4_0_3_dec_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_jpeg_ring_begin_use,
+	.end_use = amdgpu_jpeg_ring_end_use,
+	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
+	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
+static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.inst->ring_dec->funcs = &jpeg_v5_3_0_dec_ring_vm_funcs;
+}
+
+static const struct amdgpu_irq_src_funcs jpeg_v5_3_0_irq_funcs = {
+	.set = jpeg_v5_3_0_set_interrupt_state,
+	.process = jpeg_v5_3_0_process_interrupt,
+};
+
+static void jpeg_v5_3_0_set_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.inst->irq.num_types = 1;
+	adev->jpeg.inst->irq.funcs = &jpeg_v5_3_0_irq_funcs;
+}
+
+const struct amdgpu_ip_block_version jpeg_v5_3_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_JPEG,
+	.major = 5,
+	.minor = 3,
+	.rev = 0,
+	.funcs = &jpeg_v5_3_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
new file mode 100644
index 0000000000000..c1e7537d0f183
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
@@ -0,0 +1,35 @@
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
+#ifndef __JPEG_V5_3_0_H__
+#define __JPEG_V5_3_0_H__
+
+#define vcnipJPEG_CGC_GATE                                 0x4160
+#define vcnipJPEG_CGC_CTRL                                 0x4161
+#define vcnipJPEG_SYS_INT_EN                               0x4141
+#define vcnipUVD_NO_OP                                     0x0029
+#define vcnipJPEG_DEC_GFX10_ADDR_CONFIG                    0x404A
+
+extern const struct amdgpu_ip_block_version jpeg_v5_3_0_ip_block;
+
+#endif /* __JPEG_V5_0_0_H__ */
-- 
2.52.0

