Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE88CF885D
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 20:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACC810E7D6;
	Thu, 20 Nov 2025 20:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fsLw7z5d";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC4F110E7D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 20:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlABmqr3JQsomXssdFufE6MVl8sHneoTjHXu202k9dj/Gynh6737iyGxzavkoDoOihLmI/xete/Tf8Y41fPgKp/ARGrZkEXyf6FWA35r9ae6uy7XDqAbUR+PLinG19w6itpujoQObRLWr2EIoW7VDe1wd2R8GM+WUy2O5dymatL6qZ72lY35VsbKrI2YgtL6mTYjVfoGrZl64YsDyiIdMXuMpFf6t4ltRJOmmlueih29cqP0xdP2hfojbP2s/BrJtyZ6ImDIRR39EFQvUGxAmsXsrDPuJNSLdTH8QeXycFb7hdy3di1ROZvPcplI8rJ9NFDV2JS3h+a0YSljgA1vjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/mqOgIvM7Wsd70FqqNuj/q/OzsQ+PuzJnDyvJWAiJE=;
 b=d0SBaPTx5w1wBp1NBDRQt0eLWYE8imwWy3+YMn9I/Vjux6mkiIHrfeZHEg3Qhy4fCI+BnREmI2q77XT6zIFpegtqjlTX0mnVRrnhqCwi42wAAnuCgfbQLekUNy+ekIu94GkI09LV1SHGn67XFr9Vpe6/ZaxHdGHf7c0XCrYyh6ssjpt6JOLj4x/u1Qx3zR0imjYF980/2mr/WHuKMPC/f80Ea/KBubNrVX3//+J1hT8hPhFMtmM76FkfSBs4kjWvSgC5GWaPee3dqYlvH4ZKmHiv2gxHOWh610LiIQ5GhPd+WnlTasIkcnwAupXeKDRGoIqNaUFs3qSQjKnDxOcCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/mqOgIvM7Wsd70FqqNuj/q/OzsQ+PuzJnDyvJWAiJE=;
 b=fsLw7z5d12HMjT87ks2IcQgP4fcPutrVLwK3GpIxp5IA4FgC2GdG7Znw0TZudrK4XZXD6ZJESOjJ7Chz+ZNSYkOwJWA9aift29fQ2Ruw0AGBBDNHdD4tbjkVB1XvWsaf1ADjP9xlsvq6gAffj3crLzX2jDdX1WBO+rtjKbJdF6c=
Received: from PH7P220CA0125.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::18)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 20:53:08 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::d4) by PH7P220CA0125.outlook.office365.com
 (2603:10b6:510:327::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 20:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 20:53:07 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 12:53:03 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add soc v1_0 support
Date: Thu, 20 Nov 2025 15:52:50 -0500
Message-ID: <20251120205251.6727-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: dae51a0f-3205-4f7b-bd3d-08de2876cead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7zpPue0W3iK9pdh4xD1OUVRh4zTbkX+u6wufuPMKtXr6cJEKJK1chkgB7J/q?=
 =?us-ascii?Q?70DoUuAQeDcgJxztHF2rGGDdvm+VA+jlSIskmH9FidEp1uh4b/QaO1mf0UOw?=
 =?us-ascii?Q?lGe2z79304Zmm6JgykxIiCuYI9bYgcLCYvgyAsP9fzomPvnVA/lYR6Et2VpK?=
 =?us-ascii?Q?G+mH/8k6Au9HKHNYxKe3TAvvI3zor4lQBMJSspVm68G0llapFL2HGozy25KD?=
 =?us-ascii?Q?sXKdtHJ0pUwQ2vLPQ5XkM7rdredfnQhXD2k/ac44oI5p3aVr7R9r7fiAoN9k?=
 =?us-ascii?Q?H+kv9oHaWEf3Z+gdOu0GFFQGxxjd3/zIOdVBudjHaDaMsFaWh85oQ8oHZ30o?=
 =?us-ascii?Q?k4M4T/8iIBgDdpdd1IqiBXKFbsWRU4CpjWSaLSfC+NvxxKLphfQ04flD40nW?=
 =?us-ascii?Q?GyqIP8/aMDe97g+yEFKblOAVsudD/0xdvCkZb/9h74/dmiqM9SpzPjb6cbQS?=
 =?us-ascii?Q?/1vPd1H2tWVJGGbT9AP7kAs/wRZ4hth5e2defVpKJT4wpFu4AW3qhKMJqzCh?=
 =?us-ascii?Q?UoPVpnMMSSHy4DXMgLmlOS3P1xK70GCFdv+bpVmnr+wpJNt9Wna1KBBfctk7?=
 =?us-ascii?Q?h+QyxDetY1IKQzpCcHbAJLAyDOHOZFWST043DART2ZJaok/yd1ULYYb+jHiB?=
 =?us-ascii?Q?XtEX9FBC6BD07oyI2j308L6Ft9eXyoqO5IMU3NMg4n4oh4PdknJ8fZewK456?=
 =?us-ascii?Q?D81kUWErbQxjyPUWjNAZTtVvCWT0bv1/QhwdSvU9KrwzfDs9g82sR6dIjKfG?=
 =?us-ascii?Q?s7OTW4LPLp0RaUyxN0IoanLNZsUFUuyNYUKbbRgm0Ozaprvv6LuxoNJ0H6JS?=
 =?us-ascii?Q?CUY8pGb2NgpbR+cmMwFXAc4VBUNIyBuAXOwdT2UvEi/eT2JplD8EAApWMGSj?=
 =?us-ascii?Q?pGwrsOWyQGKZMQ5/cLUlSW4NiVzxc5Cg7QCsk106lh+RtTVMs2U4rTcIV4lg?=
 =?us-ascii?Q?VGRiFqEixl2aLNRFnyvPxzhIS9EjigfgQRyRkx/ZCba4B5zvNAoBYQWtFt9o?=
 =?us-ascii?Q?rW16+4sFxofEhDXb3uYI6/WjXQyhFtop9zEfVOO1La1Tx9wa+k9/RJ5qIpld?=
 =?us-ascii?Q?BUFb6jxr7rSbwDTaHjqeSNsKcJfbU7CTtWkeFjyxPvues5qnKHgQ7WV8wIa6?=
 =?us-ascii?Q?SqI7LR7TTQqkZ39Dy6+tnKjO7y9cl8QT3a1LgUVn/jNzo6o7bQZ6p0cT58ET?=
 =?us-ascii?Q?z58DCTBXhTl1nDDTLbphze6pD/bfByYLi+cFISsLULyCh2yOe62iS8JQrjTy?=
 =?us-ascii?Q?md5Ebky4Tk/6q1FCegFs5rZixulkjtJiHvXtutxKUdNM+gyPe0JKmgQpfsKB?=
 =?us-ascii?Q?TMYbzrQPqWqBEl4QR96oppCEGOlN82Fpx8+cMqznyvjb9Vf8BQv8N0zDF77m?=
 =?us-ascii?Q?ufSFwG85b9c9JkBAYXNRJ/JzXxdPKZ7puDql+DGC++Qx50WgGDEJZEK85e0X?=
 =?us-ascii?Q?hriwBP0IqlGPYbaBtWRJuywcyfDNbJrXItE59Rx5fgFnkeGCL+O0mD3ikRpi?=
 =?us-ascii?Q?gJza4+2tZ52wlJ38UhewF5sr6FW1lAf2RRat6VJrTTsbga/MXyKm9wBkRWjw?=
 =?us-ascii?Q?2yBUHc0whr0dPlKXZuc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 20:53:07.1066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae51a0f-3205-4f7b-bd3d-08de2876cead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

v1_0 is a new generation ip block

v2: squash in doorbell changes (Alex)
v3: squash in xclk, reset placeholders, pcie r|wreg ext callbacks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  30 ++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c        | 336 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h        |  33 ++
 4 files changed, 400 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index a9b89994c6de4..39d636eba52a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -86,7 +86,7 @@ amdgpu-y += \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o soc24.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
 	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
-	cyan_skillfish_reg_init.o
+	cyan_skillfish_reg_init.o soc_v1_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 2675689ef70f7..ebd14c292978d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -348,6 +348,36 @@ enum AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1 {
 	AMDGPU_DOORBELL_LAYOUT1_INVALID                 = 0xFFFF
 };
 
+enum AMDGPU_SOC_V1_0_DOORBELL_ASSIGNMENT {
+	/* KIQ/HIQ/DIQ */
+	AMDGPU_SOC_V1_0_DOORBELL_KIQ_START		= 0x000,
+	AMDGPU_SOC_V1_0_DOORBELL_HIQ			= 0x001,
+	AMDGPU_SOC_V1_0_DOORBELL_DIQ			= 0x002,
+	/* Compute: 0x03 ~ 0x20  */
+	AMDGPU_SOC_V1_0_DOORBELL_MEC_RING_START		= 0x003,
+	AMDGPU_SOC_V1_0_DOORBELL_MEC_RING_END		= 0x00A,
+	AMDGPU_SOC_V1_0_DOORBELL_MES_RING0		= 0x00B,
+	AMDGPU_SOC_V1_0_DOORBELL_MES_RING1		= 0x00C,
+	AMDGPU_SOC_V1_0_DOORBELL_USERQUEUE_START	= 0x00D,
+	AMDGPU_SOC_V1_0_DOORBELL_USERQUEUE_END		= 0x01F,
+	AMDGPU_SOC_V1_0_DOORBELL_XCC_RANGE		= 0x020,
+
+	/* SDMA: 0x100 ~ 0x19F */
+	AMDGPU_SOC_V1_0_DOORBELL_sDMA_ENGINE_START	= 0x100,
+	AMDGPU_SOC_V1_0_DOORBELL_sDMA_ENGINE_END	= 0x19F,
+	/* IH: 0x1A0 ~ 0x1AF */
+	AMDGPU_SOC_V1_0_DOORBELL_IH			= 0x1A0,
+	/* VCN: 0x1B0 ~ 0x1EF */
+	AMDGPU_SOC_V1_0_DOORBELL_VCN_START		= 0x1B0,
+	AMDGPU_SOC_V1_0_DOORBELL_VCN_END		= 0x1EF,
+
+	AMDGPU_SOC_V1_0_DOORBELL_FIRST_NON_CP		= AMDGPU_SOC_V1_0_DOORBELL_sDMA_ENGINE_START,
+	AMDGPU_SOC_V1_0_DOORBELL_LAST_NON_CP		= AMDGPU_SOC_V1_0_DOORBELL_VCN_END,
+
+	AMDGPU_SOC_V1_0_DOORBELL_MAX_ASSIGNMENT		= 0x1EF,
+	AMDGPU_SOC_V1_0_DOORBELL_INVALID		= 0xFFFF
+};
+
 u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index);
 void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v);
 u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
new file mode 100644
index 0000000000000..815f130f760c7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -0,0 +1,336 @@
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
+#include "amdgpu.h"
+#include "soc15.h"
+#include "soc15_common.h"
+#include "soc_v1_0.h"
+
+#include "gc/gc_12_1_0_offset.h"
+#include "gc/gc_12_1_0_sh_mask.h"
+#include "mp/mp_15_0_8_offset.h"
+
+/* Initialized doorbells for amdgpu including multimedia
+ * KFD can use all the rest in 2M doorbell bar */
+static void soc_v1_0_doorbell_index_init(struct amdgpu_device *adev)
+{
+	int i;
+
+	adev->doorbell_index.kiq = AMDGPU_SOC_V1_0_DOORBELL_KIQ_START;
+
+	adev->doorbell_index.mec_ring0 = AMDGPU_SOC_V1_0_DOORBELL_MEC_RING_START;
+	adev->doorbell_index.mes_ring0 = AMDGPU_SOC_V1_0_DOORBELL_MES_RING0;
+	adev->doorbell_index.mes_ring1 = AMDGPU_SOC_V1_0_DOORBELL_MES_RING1;
+
+	adev->doorbell_index.userqueue_start = AMDGPU_SOC_V1_0_DOORBELL_USERQUEUE_START;
+	adev->doorbell_index.userqueue_end = AMDGPU_SOC_V1_0_DOORBELL_USERQUEUE_END;
+	adev->doorbell_index.xcc_doorbell_range = AMDGPU_SOC_V1_0_DOORBELL_XCC_RANGE;
+
+	adev->doorbell_index.sdma_doorbell_range = 20;
+	for (i = 0; i < adev->sdma.num_instances; i++)
+		adev->doorbell_index.sdma_engine[i] =
+			AMDGPU_SOC_V1_0_DOORBELL_sDMA_ENGINE_START +
+			i * (adev->doorbell_index.sdma_doorbell_range >> 1);
+
+	adev->doorbell_index.ih = AMDGPU_SOC_V1_0_DOORBELL_IH;
+	adev->doorbell_index.vcn.vcn_ring0_1 = AMDGPU_SOC_V1_0_DOORBELL_VCN_START;
+
+	adev->doorbell_index.first_non_cp = AMDGPU_SOC_V1_0_DOORBELL_FIRST_NON_CP;
+	adev->doorbell_index.last_non_cp = AMDGPU_SOC_V1_0_DOORBELL_LAST_NON_CP;
+
+	adev->doorbell_index.max_assignment = AMDGPU_SOC_V1_0_DOORBELL_MAX_ASSIGNMENT << 1;
+}
+
+static u32 soc_v1_0_get_config_memsize(struct amdgpu_device *adev)
+{
+	return adev->nbio.funcs->get_memsize(adev);
+}
+
+static u32 soc_v1_0_get_xclk(struct amdgpu_device *adev)
+{
+	return adev->clock.spll.reference_freq;
+}
+
+void soc_v1_0_grbm_select(struct amdgpu_device *adev,
+			  u32 me, u32 pipe,
+			  u32 queue, u32 vmid,
+			  int xcc_id)
+{
+	u32 grbm_gfx_cntl = 0;
+	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, PIPEID, pipe);
+	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, MEID, me);
+	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMID, vmid);
+	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUEUEID, queue);
+
+	WREG32_SOC15_RLC_SHADOW(GC, xcc_id, regGRBM_GFX_CNTL, grbm_gfx_cntl);
+}
+
+static struct soc15_allowed_register_entry soc_v1_0_allowed_read_registers[] = {
+	{ SOC15_REG_ENTRY(GC, 0, regGRBM_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, regGRBM_STATUS2) },
+	{ SOC15_REG_ENTRY(GC, 0, regGRBM_STATUS3) },
+	{ SOC15_REG_ENTRY(GC, 0, regGRBM_STATUS_SE0) },
+	{ SOC15_REG_ENTRY(GC, 0, regGRBM_STATUS_SE1) },
+	{ SOC15_REG_ENTRY(GC, 0, regCP_STAT) },
+	{ SOC15_REG_ENTRY(GC, 0, regCP_STALLED_STAT1) },
+	{ SOC15_REG_ENTRY(GC, 0, regCP_STALLED_STAT2) },
+	{ SOC15_REG_ENTRY(GC, 0, regCP_STALLED_STAT3) },
+	{ SOC15_REG_ENTRY(GC, 0, regCP_CPF_BUSY_STAT) },
+	{ SOC15_REG_ENTRY(GC, 0, regCP_CPF_STALLED_STAT1) },
+	{ SOC15_REG_ENTRY(GC, 0, regCP_CPF_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, regCP_CPC_BUSY_STAT) },
+	{ SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1) },
+	{ SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
+};
+
+static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *adev,
+					       u32 se_num,
+					       u32 sh_num,
+					       u32 reg_offset)
+{
+	uint32_t val;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	if (se_num != 0xffffffff || sh_num != 0xffffffff)
+		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
+
+	val = RREG32(reg_offset);
+
+	if (se_num != 0xffffffff || sh_num != 0xffffffff)
+		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
+	mutex_unlock(&adev->grbm_idx_mutex);
+	return val;
+}
+
+static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev,
+					    bool indexed, u32 se_num,
+					    u32 sh_num, u32 reg_offset)
+{
+	if (indexed) {
+		return soc_v1_0_read_indexed_register(adev, se_num, sh_num, reg_offset);
+	} else {
+		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG_1) &&
+		    adev->gfx.config.gb_addr_config)
+			return adev->gfx.config.gb_addr_config;
+		return RREG32(reg_offset);
+	}
+}
+
+static int soc_v1_0_read_register(struct amdgpu_device *adev,
+				  u32 se_num, u32 sh_num,
+				  u32 reg_offset, u32 *value)
+{
+	uint32_t i;
+	struct soc15_allowed_register_entry  *en;
+
+	*value = 0;
+	for (i = 0; i < ARRAY_SIZE(soc_v1_0_allowed_read_registers); i++) {
+		en = &soc_v1_0_allowed_read_registers[i];
+		if (!adev->reg_offset[en->hwip][en->inst])
+			continue;
+		else if (reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
+					+ en->reg_offset))
+			continue;
+
+		*value = soc_v1_0_get_register_value(adev,
+				soc_v1_0_allowed_read_registers[i].grbm_indexed,
+				se_num, sh_num, reg_offset);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static bool soc_v1_0_need_full_reset(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 1, 0):
+	default:
+		return true;
+	}
+}
+
+static bool soc_v1_0_need_reset_on_init(struct amdgpu_device *adev)
+{
+	u32 sol_reg;
+
+	if (adev->flags & AMD_IS_APU)
+		return false;
+
+	/* Check sOS sign of life register to confirm sys driver and sOS
+	 * are already been loaded.
+	 */
+	sol_reg = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81);
+	if (sol_reg)
+		return true;
+
+	return false;
+}
+
+static int soc_v1_0_asic_reset(struct amdgpu_device *adev)
+{
+	return 0;
+}
+
+static const struct amdgpu_asic_funcs soc_v1_0_asic_funcs = {
+	.read_bios_from_rom = &amdgpu_soc15_read_bios_from_rom,
+	.read_register = &soc_v1_0_read_register,
+	.get_config_memsize = &soc_v1_0_get_config_memsize,
+	.get_xclk = &soc_v1_0_get_xclk,
+	.need_full_reset = &soc_v1_0_need_full_reset,
+	.init_doorbell_index = &soc_v1_0_doorbell_index_init,
+	.need_reset_on_init = &soc_v1_0_need_reset_on_init,
+	.reset = soc_v1_0_asic_reset,
+};
+
+static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->smc_rreg = NULL;
+	adev->smc_wreg = NULL;
+	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
+	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
+	adev->pcie_rreg_ext = &amdgpu_device_indirect_rreg_ext;
+	adev->pcie_wreg_ext = &amdgpu_device_indirect_wreg_ext;
+	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
+	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
+	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
+	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
+	adev->pcie_rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
+	adev->pcie_wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
+	adev->uvd_ctx_rreg = NULL;
+	adev->uvd_ctx_wreg = NULL;
+	adev->didt_rreg = NULL;
+	adev->didt_wreg = NULL;
+
+	adev->asic_funcs = &soc_v1_0_asic_funcs;
+
+	adev->rev_id = amdgpu_device_get_rev_id(adev);
+	adev->external_rev_id = 0xff;
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 1, 0):
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x50;
+		break;
+	default:
+		/* FIXME: not supported yet */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int soc_v1_0_common_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	/* Enable selfring doorbell aperture late because doorbell BAR
+	 * aperture will change if resize BAR successfully in gmc sw_init.
+	 */
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
+
+	return 0;
+}
+
+static int soc_v1_0_common_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	return 0;
+}
+
+static int soc_v1_0_common_hw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	/* enable the doorbell aperture */
+	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
+
+	return 0;
+}
+
+static int soc_v1_0_common_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
+	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
+
+	return 0;
+}
+
+static int soc_v1_0_common_suspend(struct amdgpu_ip_block *ip_block)
+{
+	return soc_v1_0_common_hw_fini(ip_block);
+}
+
+static int soc_v1_0_common_resume(struct amdgpu_ip_block *ip_block)
+{
+	return soc_v1_0_common_hw_init(ip_block);
+}
+
+static bool soc_v1_0_common_is_idle(struct amdgpu_ip_block *ip_block)
+{
+	return true;
+}
+
+static int soc_v1_0_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+						 enum amd_clockgating_state state)
+{
+	return 0;
+}
+
+static int soc_v1_0_common_set_powergating_state(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state)
+{
+	return 0;
+}
+
+static void soc_v1_0_common_get_clockgating_state(struct amdgpu_ip_block *ip_block,
+						  u64 *flags)
+{
+	return;
+}
+
+static const struct amd_ip_funcs soc_v1_0_common_ip_funcs = {
+	.name = "soc_v1_0_common",
+	.early_init = soc_v1_0_common_early_init,
+	.late_init = soc_v1_0_common_late_init,
+	.sw_init = soc_v1_0_common_sw_init,
+	.hw_init = soc_v1_0_common_hw_init,
+	.hw_fini = soc_v1_0_common_hw_fini,
+	.suspend = soc_v1_0_common_suspend,
+	.resume = soc_v1_0_common_resume,
+	.is_idle = soc_v1_0_common_is_idle,
+	.set_clockgating_state = soc_v1_0_common_set_clockgating_state,
+	.set_powergating_state = soc_v1_0_common_set_powergating_state,
+	.get_clockgating_state = soc_v1_0_common_get_clockgating_state,
+};
+
+const struct amdgpu_ip_block_version soc_v1_0_common_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_COMMON,
+	.major = 1,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &soc_v1_0_common_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
new file mode 100644
index 0000000000000..d9de040c37291
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
@@ -0,0 +1,33 @@
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
+#ifndef __SOC_V1_0_H__
+#define __SOC_V1_0_H__
+
+extern const struct amdgpu_ip_block_version soc_v1_0_common_ip_block;
+
+void soc_v1_0_grbm_select(struct amdgpu_device *adev,
+			  u32 me, u32 pipe,
+			  u32 queue, u32 vmid,
+			  int xcc_id);
+
+#endif
-- 
2.51.1

