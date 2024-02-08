Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2FCC4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 20:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7B610EC5D;
	Thu,  8 Feb 2024 20:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XLEoOUWb";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 465AF10EC55
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 20:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1TZUCjvUfOkLSgtw6LHWssgKRVhJxO52aR0nEgXwaLkPYJI+pAb9Sse9jKpmb4u65lxe6Ud/YA4KNDhxoVOEPxFCAMEwgzBq2wrsmz16LfNqPsGP2XxvWhLZPhU1csYA5X51D4vQJfpp+xbQENQXRjgq/9/TO/5GNm3W4tfi1K+M06LrRM2hqUZdZ7VUc5kkrfFBg+Wi33wvmD/GWG+zqfO3YqwMVmqFRYIOZkoHiMm1Bckt3Z6HUcmTmloE0WpKPnQ+6iNN7E/JwzLgt7otMGBuYCPtHIxxxvz3Ts2QdhsvdhyDi+rlO3Vww+VJPEs7Bouz9VFPHMVYIE6wri84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+ER7NR5voNKcR95BhsYpmPZvjbxLuyV64wotVrLkgM=;
 b=Ts3oRQoJsoG9R8PSno9lt0V8ARZyWFgu7ilraa7xMQoCtkv4uGel6krf/mv+s9FmXmOm/xiFn076s7q7q832mvoe81TSZBrxAU9et8HAApJxMAG9Q0rvBkGNWzfVxYh7F/ld/H8nxw8F2hsGQWK7IqLKP/k+OhY05tiEZOOqdX+HFsqqpr7/J6jArOMJUSUgaCAkfutXSPaz6N9TeErcaPhigsZG0z2XiHe3NOzRqMSSapFWp3DKPLby7yUPuknl7TjsdzL22hh2Kq8iLc1ObDMcE3tzQf4sOCj5wN+O7/ROCjPIlkzBDCQH8/d6jT2c/XLVSm72iUqueS9abBCP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+ER7NR5voNKcR95BhsYpmPZvjbxLuyV64wotVrLkgM=;
 b=XLEoOUWbFbdjEIBpxvCFXb/DT2ij2fXHiqneF6QgaahsSHOBcgtESAPVe/G9xEBoxOO/i4X29yGgWrdq9GkhwVLRkaCymHp/KPC92FOZbwSrFM91M5M4efGdOPRu3VyIwmb6dBUrlGHJwChcP0rSvs6pOrYMgMNMmJtudPVRdXQ=
Received: from DS7PR03CA0143.namprd03.prod.outlook.com (2603:10b6:5:3b4::28)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 20:03:09 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::1b) by DS7PR03CA0143.outlook.office365.com
 (2603:10b6:5:3b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39 via Frontend
 Transport; Thu, 8 Feb 2024 20:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 8 Feb 2024 20:03:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 14:03:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add JPEG5 support
Date: Thu, 8 Feb 2024 15:02:50 -0500
Message-ID: <20240208200253.409130-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240208200253.409130-1-alexander.deucher@amd.com>
References: <20240208200253.409130-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d80704a-4d0c-47d9-9190-08dc28e0f883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQSFc8o6LvY9mcL5RPX6bjFhzOOe8ooP4rEINsRb4lbnmT18X6eCw/lt+9sonkXoCTA1dA1S7rXQ1gQ8XFuWesQbM72lnSahASV1l/29tDT5D+04/ZS+dvEMmkmw3RzWH1l6aXw56gRvs1tIWRydpYARG9z/QZ3VSeTYQFl3wjGqhl4j54zc4tMIvy8ScqlonViuKvwHwfL9lPWVgYtACox+mT+ykwX3k0SHpngASLWamoA+tRP34g/C3r3pMdA/WTDjzkh9V8cblo5jnC+m0jq0ITiJCWW+HEuh6uDDXvf5C8St0tMsV19jL56e/Fd1DL1WxaZE7PcXgqqAddx6mivu7zeyITYvwcLIO7wzuo5SHynqW4kyNrU5AIcIiKeyczQ98p0qeNgivh5ci49IE4ymrw2kbOY0vUoOV+IUP3Po06jw0uIBrC3eKLieJ1fptb/83VrtdJyhxCBadzk68svH+M78I3TBCkkiC4cWA1YzIv+eM6Mp23MX2z3amHLBrAPn7vxWLcISJGew12wuCHU3sGaV1Bp5RvWQxFSMyZyhvqVdHGs53YHDFigTeM48h1rmub/gHoWaLiVzDl925+c/gEXW27AzNX3E7KDPYlw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230273577357003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(66899024)(41300700001)(7696005)(6666004)(36756003)(426003)(26005)(336012)(1076003)(2616005)(81166007)(16526019)(86362001)(82740400003)(356005)(30864003)(8676002)(2906002)(8936002)(83380400001)(4326008)(5660300002)(6916009)(70206006)(316002)(54906003)(70586007)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:03:08.5831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d80704a-4d0c-47d9-9190-08dc28e0f883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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

From: Sonny Jiang <sonny.jiang@amd.com>

Add support for JPEG5

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  16 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  15 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 555 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  29 ++
 6 files changed, 611 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 84c1baf8f3cb..daccbc11176e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -217,7 +217,8 @@ amdgpu-y += \
 	jpeg_v3_0.o \
 	jpeg_v4_0.o \
 	jpeg_v4_0_3.o \
-	jpeg_v4_0_5.o
+	jpeg_v4_0_5.o \
+	jpeg_v5_0_0.o
 
 # add VPE block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index ab70395a0022..6df99cb00d9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -247,6 +247,8 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 			if (tmp == 0xDEADBEEF)
 				break;
 			udelay(1);
+			if (amdgpu_emu_mode == 1)
+				udelay(10);
 		}
 
 		if (i >= adev->usec_timeout)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 165448bed6c9..ab17dacd2310 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -650,7 +650,7 @@ static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
  *
  * Write a start command to the ring.
  */
-static void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)
+void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)
 {
 	if (!amdgpu_sriov_vf(ring->adev)) {
 		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
@@ -670,7 +670,7 @@ static void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)
  *
  * Write a end command to the ring.
  */
-static void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring)
+void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring)
 {
 	if (!amdgpu_sriov_vf(ring->adev)) {
 		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
@@ -693,7 +693,7 @@ static void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring)
  *
  * Write a fence and a trap command to the ring.
  */
-static void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
+void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 				unsigned int flags)
 {
 	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
@@ -762,7 +762,7 @@ static void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
  *
  * Write ring commands to execute the indirect buffer.
  */
-static void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
+void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
 				struct amdgpu_job *job,
 				struct amdgpu_ib *ib,
 				uint32_t flags)
@@ -813,7 +813,7 @@ static void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, 0x2);
 }
 
-static void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 				uint32_t val, uint32_t mask)
 {
 	uint32_t reg_offset = (reg << 2);
@@ -840,7 +840,7 @@ static void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_
 	amdgpu_ring_write(ring, mask);
 }
 
-static void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
+void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 				unsigned int vmid, uint64_t pd_addr)
 {
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
@@ -855,7 +855,7 @@ static void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	jpeg_v4_0_3_dec_ring_emit_reg_wait(ring, data0, data1, mask);
 }
 
-static void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
+void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
 {
 	uint32_t reg_offset = (reg << 2);
 
@@ -873,7 +873,7 @@ static void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t re
 	amdgpu_ring_write(ring, val);
 }
 
-static void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count)
+void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
index 22483dc66351..747a3e5f6856 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -48,4 +48,19 @@
 
 extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
 
+void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
+				struct amdgpu_job *job,
+				struct amdgpu_ib *ib,
+				uint32_t flags);
+void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
+				unsigned int flags);
+void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
+					unsigned int vmid, uint64_t pd_addr);
+void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
+void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring);
+void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring);
+void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
+void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+					uint32_t val, uint32_t mask);
+
 #endif /* __JPEG_V4_0_3_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
new file mode 100644
index 000000000000..fbc987e299f8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -0,0 +1,555 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#include "jpeg_v4_0_3.h"
+
+#include "vcn/vcn_5_0_0_offset.h"
+#include "vcn/vcn_5_0_0_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
+
+static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);
+static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
+static int jpeg_v5_0_0_set_powergating_state(void *handle,
+				enum amd_powergating_state state);
+
+/**
+ * jpeg_v5_0_0_early_init - set function pointers
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Set ring and irq function pointers
+ */
+static int jpeg_v5_0_0_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	adev->jpeg.num_jpeg_inst = 1;
+	adev->jpeg.num_jpeg_rings = 1;
+
+	jpeg_v5_0_0_set_dec_ring_funcs(adev);
+	jpeg_v5_0_0_set_irq_funcs(adev);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_0_sw_init - sw init for JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Load firmware and sw initialization
+ */
+static int jpeg_v5_0_0_sw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring;
+	int r;
+
+	/* JPEG TRAP */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		VCN_4_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
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
+	ring->use_doorbell = false;
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
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_0_sw_fini - sw fini for JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * JPEG suspend and free up sw allocation
+ */
+static int jpeg_v5_0_0_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_jpeg_suspend(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_sw_fini(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v5_0_0_hw_init - start and test JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ */
+static int jpeg_v5_0_0_hw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int r;
+
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+
+	DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_0_hw_fini - stop the hardware block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Stop the JPEG block, mark ring as not ready any more
+ */
+static int jpeg_v5_0_0_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
+	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
+		jpeg_v5_0_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_0_suspend - suspend JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * HW fini and suspend JPEG block
+ */
+static int jpeg_v5_0_0_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = jpeg_v5_0_0_hw_fini(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_suspend(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v5_0_0_resume - resume JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Resume firmware and hw init JPEG block
+ */
+static int jpeg_v5_0_0_resume(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_jpeg_resume(adev);
+	if (r)
+		return r;
+
+	r = jpeg_v5_0_0_hw_init(adev);
+
+	return r;
+}
+
+static void jpeg_v5_0_0_disable_clock_gating(struct amdgpu_device *adev)
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
+static void jpeg_v5_0_0_enable_clock_gating(struct amdgpu_device *adev)
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
+static int jpeg_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev)
+{
+	uint32_t data = 0;
+
+	data = 1 << UVD_IPX_DLDO_CONFIG__ONO1_PWR_CONFIG__SHIFT;
+	WREG32_SOC15(JPEG, 0, regUVD_IPX_DLDO_CONFIG, data);
+	SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS, 0,
+			UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
+
+	/* disable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	/* keep the JPEG in static PG mode */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
+		~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK);
+
+	return 0;
+}
+
+static int jpeg_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev)
+{
+	/* enable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+		UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_0_start - start JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Setup and start the JPEG block
+ */
+static int jpeg_v5_0_0_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int r;
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_jpeg(adev, true);
+
+	/* disable power gating */
+	r = jpeg_v5_0_0_disable_static_power_gating(adev);
+	if (r)
+		return r;
+
+	/* JPEG disable CGC */
+	jpeg_v5_0_0_disable_clock_gating(adev);
+
+	/* MJPEG global tiling registers */
+	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+
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
+	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_VMID, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_RPTR, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_CNTL, 0x00000002L);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_SIZE, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_0_stop - stop JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * stop the JPEG block
+ */
+static int jpeg_v5_0_0_stop(struct amdgpu_device *adev)
+{
+	int r;
+
+	/* reset JMI */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
+		UVD_JMI_CNTL__SOFT_RESET_MASK,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	jpeg_v5_0_0_enable_clock_gating(adev);
+
+	/* enable power gating */
+	r = jpeg_v5_0_0_enable_static_power_gating(adev);
+	if (r)
+		return r;
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_jpeg(adev, false);
+
+	return 0;
+}
+
+/**
+ * jpeg_v5_0_0_dec_ring_get_rptr - get read pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware read pointer
+ */
+static uint64_t jpeg_v5_0_0_dec_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	return RREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_RPTR);
+}
+
+/**
+ * jpeg_v5_0_0_dec_ring_get_wptr - get write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware write pointer
+ */
+static uint64_t jpeg_v5_0_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell)
+		return *ring->wptr_cpu_addr;
+	else
+		return RREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR);
+}
+
+/**
+ * jpeg_v5_0_0_dec_ring_set_wptr - set write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Commits the write pointer to the hardware
+ */
+static void jpeg_v5_0_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell) {
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
+	} else {
+		WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
+	}
+}
+
+static bool jpeg_v5_0_0_is_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret = 1;
+
+	ret &= (((RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS) &
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
+
+	return ret;
+}
+
+static int jpeg_v5_0_0_wait_for_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_JRBC_STATUS,
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+}
+
+static int jpeg_v5_0_0_set_clockgating_state(void *handle,
+					  enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+
+	if (enable) {
+		if (!jpeg_v5_0_0_is_idle(handle))
+			return -EBUSY;
+		jpeg_v5_0_0_enable_clock_gating(adev);
+	} else {
+		jpeg_v5_0_0_disable_clock_gating(adev);
+	}
+
+	return 0;
+}
+
+static int jpeg_v5_0_0_set_powergating_state(void *handle,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret;
+
+	if (state == adev->jpeg.cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = jpeg_v5_0_0_stop(adev);
+	else
+		ret = jpeg_v5_0_0_start(adev);
+
+	if (!ret)
+		adev->jpeg.cur_state = state;
+
+	return ret;
+}
+
+static int jpeg_v5_0_0_set_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
+				      struct amdgpu_irq_src *source,
+				      struct amdgpu_iv_entry *entry)
+{
+	DRM_DEBUG("IH: JPEG TRAP\n");
+
+	switch (entry->src_id) {
+	case VCN_4_0__SRCID__JPEG_DECODE:
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
+static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
+	.name = "jpeg_v5_0_0",
+	.early_init = jpeg_v5_0_0_early_init,
+	.late_init = NULL,
+	.sw_init = jpeg_v5_0_0_sw_init,
+	.sw_fini = jpeg_v5_0_0_sw_fini,
+	.hw_init = jpeg_v5_0_0_hw_init,
+	.hw_fini = jpeg_v5_0_0_hw_fini,
+	.suspend = jpeg_v5_0_0_suspend,
+	.resume = jpeg_v5_0_0_resume,
+	.is_idle = jpeg_v5_0_0_is_idle,
+	.wait_for_idle = jpeg_v5_0_0_wait_for_idle,
+	.check_soft_reset = NULL,
+	.pre_soft_reset = NULL,
+	.soft_reset = NULL,
+	.post_soft_reset = NULL,
+	.set_clockgating_state = jpeg_v5_0_0_set_clockgating_state,
+	.set_powergating_state = jpeg_v5_0_0_set_powergating_state,
+};
+
+static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_JPEG,
+	.align_mask = 0xf,
+	.get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
+	.get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
+	.set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
+		8 + /* jpeg_v5_0_0_dec_ring_emit_vm_flush */
+		22 + 22 + /* jpeg_v5_0_0_dec_ring_emit_fence x2 vm fence */
+		8 + 16,
+	.emit_ib_size = 22, /* jpeg_v5_0_0_dec_ring_emit_ib */
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
+static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.inst->ring_dec->funcs = &jpeg_v5_0_0_dec_ring_vm_funcs;
+	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
+}
+
+static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs = {
+	.set = jpeg_v5_0_0_set_interrupt_state,
+	.process = jpeg_v5_0_0_process_interrupt,
+};
+
+static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.inst->irq.num_types = 1;
+	adev->jpeg.inst->irq.funcs = &jpeg_v5_0_0_irq_funcs;
+}
+
+const struct amdgpu_ip_block_version jpeg_v5_0_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_JPEG,
+	.major = 5,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &jpeg_v5_0_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
new file mode 100644
index 000000000000..bd348336b215
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#ifndef __JPEG_V5_0_0_H__
+#define __JPEG_V5_0_0_H__
+
+extern const struct amdgpu_ip_block_version jpeg_v5_0_0_ip_block;
+
+#endif /* __JPEG_V5_0_0_H__ */
-- 
2.42.0

