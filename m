Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CDAC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 16:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 096EE11221A;
	Tue, 30 Apr 2024 16:24:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v2PPQNap";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8B911221A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 16:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE4YePFBBLvDE/3ge0mGt8hO33GCkfFXXOHUiLiz2BrYUaNi45ruSl3m93FMDgDkd+3d1GZXSMDUbZ6XVuubt2aeYFWbV4XzFY8FXiibvSwjiqX2WrdQTfEzs7GikXNTQ2lRxgWgdxFWgNqHsEqKzA3EkUDeYw1+HnhRxnq3CWqpyqt7ozrTPC+Tv9tXLTo1ALnlfNXp1wwOzoB92r8q2fI+Rips+ZrAHWMxUU+Dh+w0roIRMB0dKtjGDs2NA1IgauwlFy4au7UctbkIQydkYeHZP8byL7S/s057kX8AaXmcR+Tn3jWT/iIEZY0/s/XfgoQ7TOktsMPBQdutQTF+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVBiOYtwIfRK7FwUqRLLwlDj0K9PX6HBFoAXV7BT81A=;
 b=GBB8sqFEsqBGLtVEoq2Uz6ZcbtkSXnmzXqM3rDE3lZgWB2yY2PulrnFVksRAPEfqbC/2sMbmcBJJM8QXTB/7yapcdL211yzX4nI1ihrS6+o7lXYIQf+0aCASe0I5ZDqUSBTrTzTuGnhCDHBk6NzvKuxVNYYemReYFJ0KC3yBy/D9E2kJ2iKjhQvcTtvI31Ir6UnpqaTYizgqu8N27G8w7cCFH6bKidg1P9VpwPXDP8er0ZUtLsdtm1AVym60lPRC1BJiR0QImCrzRMPluO3SqJSbIbIdTQkpdRE4ISgcSc0L+divUC0zc0bDuNEjj+g8jKynvk+S3A7MdoM3r780ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVBiOYtwIfRK7FwUqRLLwlDj0K9PX6HBFoAXV7BT81A=;
 b=v2PPQNapYBHLVRFdhO+TRDxY4y2G5aKffksuLI3J5sO0lZnnoOGr+oRWebulGFVcd3vHr32LcsOpMNvTQPr4USEsJsq888VJtun9f8W76wApOgIwHogTSSI+Myvta+X1M0Xcea8BfROlfHa5AQamMGFjp+fwLSb6avy+NLBWil0=
Received: from PH7PR17CA0068.namprd17.prod.outlook.com (2603:10b6:510:325::12)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 16:24:00 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::88) by PH7PR17CA0068.outlook.office365.com
 (2603:10b6:510:325::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 16:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 16:24:00 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 11:23:56 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add gfx eviction fence helpers
Date: Tue, 30 Apr 2024 18:23:32 +0200
Message-ID: <20240430162333.1353-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2f20ad-b58b-412b-469b-08dc6931f14f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Or3W2ygMoLbiaXZxIdiCLjIq4y8B2qpXOYj2YqNvKCz82r0Xtl2ncBMgSsrV?=
 =?us-ascii?Q?ZxpXKN8kDdQ8cBoqQiInuSkGMT02JQXYizMoaHWw5HIbE2gpBEcwB6bjZmEO?=
 =?us-ascii?Q?c2aOh7bUSf3/R0ygDnk1XeHPBf2ayeSF8IrIrtPXqHj4gKftVhVrejqOlKb4?=
 =?us-ascii?Q?WvdXUo6in3yNBWiL2GjEcSSh/34o1VLRFSa4oTcE8v15v5d2WmJpDaXXSIOB?=
 =?us-ascii?Q?kE4X7PT0MtK5RHxxcYsm2A8IJ+1TeCWfeNbfSN5bj7PdpLPM51e8VQJykfWM?=
 =?us-ascii?Q?phJK8AUUOL+YhMN88Zibld6w49jyh2GtINRVgtYNeLAfkSgYn6S5h+Bd+E11?=
 =?us-ascii?Q?8s0r8GRf4Og8H1gIkFNS26TwLazc+VyGnhm02iO4Q+7444ltBMaWVlwEeTgj?=
 =?us-ascii?Q?MwTX1tDPrDgpN+NRu2YLtwCRw3iroV6HySEG3EOT0LmZrHdx95pBr7IaA9GD?=
 =?us-ascii?Q?1Ts/qwXZAAdJeQpjEiyXwTALtsB2a6VOYoHNyOMCrDLyrZ+fYUHhFvUbngwr?=
 =?us-ascii?Q?+hQnLDHSgmPgL+sZPdo04lh7zXJwy8ipmW1ssHi4rEkN5+aKOWzOFj3hDxsF?=
 =?us-ascii?Q?5NBU+PlybW9V3GWBFJupp2OAkg4nRIbFTAvWeYaMCW26pJEWxk6YpsuPY6NP?=
 =?us-ascii?Q?W7zeX8Lp0fkFhjCyB/mbaFrMJascD+flWjrjYEr6OZVP5PcvraLsCg2r58Zx?=
 =?us-ascii?Q?oD4bTcvP5zSiUrCE1aJQMzTxLXTt+62nfgRbsOD2KIgBjkXehvuteukQ6POJ?=
 =?us-ascii?Q?HlMBc6PaGLjVq4KxtQMd9MMsRmWldTlF+NwvMx+USU5ytYcoyWTG16O2oeFV?=
 =?us-ascii?Q?nkaPlQdOl6H0S2LCp8aqVRL87YGR5L0iNYmnTQvknbDdbcra+0aIiYWwYXnA?=
 =?us-ascii?Q?BkHpgS2BVJe3pxO69So5yipMJgteZvTHycZZ8jEZSbKjz4MsP58n3hMZxmQy?=
 =?us-ascii?Q?pit2yj+7E+YSj6eah5hblGU6PSCAHPAwxQdwrIA3WGmLniwhl+CzrWg9frcx?=
 =?us-ascii?Q?/OHoVStsQQyFGWEYhSz0ikLcIDzkcTgC9/PeV6SRawpJv5UXQGccjpLx7VVh?=
 =?us-ascii?Q?RwdQq2TGbgZJUlfJbTZjVxo90fwBHfxtmzke5J93V86k66yjHU83NqnfG6V2?=
 =?us-ascii?Q?LkZLAny6Ejwn8SitdBn5yC+i12SRUUaFQHKAVm7GRuxfq94VPg35TnmDAbo2?=
 =?us-ascii?Q?f6hjMtl/+gMfmRfXqItyqrIYXP2dYY9gWUb7QApdhVfqhtKWFap6bQLPWVig?=
 =?us-ascii?Q?DryFqoWeuGI/v++cTiyJMA+CDqGcEvMGDwgQ5+Nn82pjdO9LmwvFfcFoGF8r?=
 =?us-ascii?Q?qP3cmhfKNYXGJkwei4vzGNnnYwxOw3ZU+6+k3EcxDt2SSNtY8oV1LfWhnm6t?=
 =?us-ascii?Q?RK9/VMZUwlmQSWqoDQeN9CcM2Oa9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:24:00.1492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2f20ad-b58b-412b-469b-08dc6931f14f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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

This patch adds basic eviction fence framework for the gfx buffers.
The idea is to:
- One eviction fence is created per gfx process, at kms_open.
- This same fence is attached to all the gem buffers created
  by this process.

This framework will be further used for usermode queues.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 15 +++
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 96 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 +
 6 files changed, 127 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4536c8ad0e11..ba00789eb4ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -80,7 +80,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o
+	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o \
+	amdgpu_eviction_fence.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9c62552bec34..4a4b2680eb9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -463,6 +463,13 @@ struct amdgpu_flip_work {
 	bool				async;
 };
 
+struct amdgpu_eviction_fence {
+	u64		 fence_ctx;
+	atomic_t	 seq;
+	spinlock_t	 lock;
+	struct dma_fence base;
+	char		 timeline_name[TASK_COMM_LEN];
+};
 
 /*
  * file private structure
@@ -476,6 +483,7 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	struct amdgpu_eviction_fence eviction_fence;
 	/** GPU partition selection */
 	uint32_t		xcp_id;
 };
@@ -1474,6 +1482,13 @@ void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
 int amdgpu_info_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
 
+/* Eviction fence */
+void amdgpu_eviction_fence_create(struct amdgpu_fpriv *fpriv);
+int amdgpu_eviction_fence_attach(struct amdgpu_fpriv *fpriv,
+				 struct amdgpu_bo *bo);
+void amdgpu_eviction_fence_detach(struct amdgpu_fpriv *fpriv);
+void amdgpu_eviction_fence_signal(struct amdgpu_fpriv *fpriv);
+
 /*
  * functions used by amdgpu_encoder.c
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
new file mode 100644
index 000000000000..36009d89be03
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
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
+#include <linux/sched.h>
+#include "amdgpu.h"
+
+static const char *
+amdgpu_ev_fence_get_driver_name(struct dma_fence *fence)
+{
+	return "amdgpu";
+}
+
+static const char *
+amdgpu_ev_fence_get_timeline_name(struct dma_fence *f)
+{
+	struct amdgpu_eviction_fence *ef;
+
+	ef = container_of(f, struct amdgpu_eviction_fence, base);
+	return ef->timeline_name;
+}
+
+static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
+	.use_64bit_seqno = true,
+	.get_driver_name = amdgpu_ev_fence_get_driver_name,
+	.get_timeline_name = amdgpu_ev_fence_get_timeline_name,
+};
+
+void amdgpu_eviction_fence_create(struct amdgpu_fpriv *fpriv)
+{
+	struct amdgpu_eviction_fence *fence = &fpriv->eviction_fence;
+	atomic_t seq = ATOMIC_INIT(0);
+
+	spin_lock_init(&fence->lock);
+	fence->fence_ctx = dma_fence_context_alloc(1);
+	fence->seq = seq;
+	dma_fence_init(&fence->base, &amdgpu_eviction_fence_ops,
+		       &fence->lock, fence->fence_ctx,
+		       atomic_inc_return(&fence->seq));
+}
+
+int amdgpu_eviction_fence_attach(struct amdgpu_fpriv *fpriv,
+				 struct amdgpu_bo *bo)
+{
+	struct dma_fence *ef = &fpriv->eviction_fence.base;
+	struct dma_resv *resv = bo->tbo.base.resv;
+	int ret;
+
+	if (bo->eviction_fence)
+		return 0;
+
+	ret = dma_resv_reserve_fences(resv, 1);
+	if (ret) {
+		dma_fence_wait(ef, false);
+		return ret;
+	}
+
+	dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
+	bo->eviction_fence = dma_fence_get(ef);
+	return 0;
+}
+
+void amdgpu_eviction_fence_detach(struct amdgpu_fpriv *fpriv)
+{
+	struct dma_fence *ef = &fpriv->eviction_fence.base;
+
+	if (!dma_fence_is_signaled(ef))
+		dma_fence_put(ef);
+}
+
+void amdgpu_eviction_fence_signal(struct amdgpu_fpriv *fpriv)
+{
+	struct dma_fence *ef = &fpriv->eviction_fence.base;
+
+	if (!dma_fence_is_signaled(ef))
+		dma_fence_signal(ef);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 67c234bcf89f..b75a19a0b5aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -199,8 +199,14 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	 * but not for export, this is a different lock class that cannot lead to
 	 * circular lock dependencies.
 	 */
-	if (!vm->is_compute_context || !vm->process_info)
+	if (!vm->is_compute_context || !vm->process_info) {
+		/* attach gfx eviction fence */
+		if (amdgpu_eviction_fence_attach(fpriv, abo))
+			DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
+
 		return 0;
+	}
+
 	if (!obj->import_attach ||
 	    !dma_buf_is_dynamic(obj->import_attach->dmabuf))
 		return 0;
@@ -236,6 +242,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	struct drm_exec exec;
 	long r;
 
+	amdgpu_eviction_fence_detach(fpriv);
+
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_prepare_obj(&exec, &bo->tbo.base, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a2df3025a754..7804fe215d36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1293,7 +1293,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 }
 
-
 /*
  * Outdated mess for old drm with Xorg being in charge (void function now).
  */
@@ -1386,6 +1385,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	mutex_init(&fpriv->bo_list_lock);
 	idr_init_base(&fpriv->bo_list_handles, 1);
 
+	amdgpu_eviction_fence_create(fpriv);
+
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
@@ -1455,6 +1456,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_bo_unreserve(pd);
 	}
 
+	amdgpu_eviction_fence_signal(fpriv);
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index be679c42b0b8..91ae8d21ee5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -105,6 +105,8 @@ struct amdgpu_bo {
 	struct amdgpu_vm_bo_base	*vm_bo;
 	/* Constant after initialization */
 	struct amdgpu_bo		*parent;
+	/* Eviction fence attached to bo */
+	struct dma_fence		*eviction_fence;
 
 #ifdef CONFIG_MMU_NOTIFIER
 	struct mmu_interval_notifier	notifier;
-- 
2.43.2

