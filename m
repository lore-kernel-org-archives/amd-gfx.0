Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF4AC25B74
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 20:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F290F112973;
	Wed,  8 May 2024 20:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZhh4qB/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A93011296E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 20:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/LD83Czr12pd3v+oQEN52mulzuBb8n8fE2CHGY1N6JnKEoPa5cXmL5QCm3ln+a4WLM8oBCvinFRb0QtoZxynW97MoYwxlcR+8pMHdcMtUDmkvK5FnnubPlsPn3tXppfgirxnuTS6dVO7TWGZTvSSSCO9iION6I/vALOsQ9MMSYKYYcnf2s1Kmt+Bq9e6kJPbAFzXSkTnLw/XfOoduhS2kF3Eavp9XsHO244FJr16diQogPmlAP3eFrB8S84C/D9vF4VTWMEwOwp7+hLh8BofJRe8KlQPpqdDYGDBmxrDYJxG0dEMKzE1xygpNhOODwCh6iY388Xz7uA5HdAFI4+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXNCUQa66KEeJPA66o3jHIpKMwcc83sbJ5t15B3hRBY=;
 b=Xi9z1ZzEWMjJpPnkNKTbQJuEVQ5sNZWeZRvD6JXQadrzaOIRRj/Zz3qE2rNlTOMChG7ALtauz0JYkgePteKnWyvPGiYNwA0NeIdis5ZB8KO9moyQyJUpC2SO0m0r9Gr7O4hybSv/1ltScgzWuxZT6w4nqBR7Qd3ZLc+Aq9TlBB50UTyj8q+UyrSEooV1jru87LdT7br3YWVs7C+2XzauticLG+AGnLLexdB5gpZqdHE8Zb0Tg8XGmHEGh9yNTw8HddQgCgsISs3Dc8RGT7OMUKv7RU0g8F21P+RlaMF5CKvMghEivB/4JHLLFzwOYZ0FKYj52Paa1kDh27aWzJKv5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXNCUQa66KEeJPA66o3jHIpKMwcc83sbJ5t15B3hRBY=;
 b=wZhh4qB/nnYJ7+fJGe+7TyWh6taQn2wtgG9aukprC28NGvyHeFcphRpVSfOkCoJ4afAaa0sNtrweXhvekOKH02lXCinyF7h4ziZN7ldGXW3tWn/PooPal9gLSAaDH+vqr/zGEPsOf6SaFeCTQ4g1OYr/ytIaXOVuK926/Ei8Au8=
Received: from DM6PR14CA0072.namprd14.prod.outlook.com (2603:10b6:5:18f::49)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 20:29:10 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::d0) by DM6PR14CA0072.outlook.office365.com
 (2603:10b6:5:18f::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 20:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 20:29:09 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 15:29:07 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Christian Koenig <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add gfx eviction fence helpers
Date: Wed, 8 May 2024 22:28:34 +0200
Message-ID: <20240508202837.1411-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240508202837.1411-1-shashank.sharma@amd.com>
References: <20240508202837.1411-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe17fdc-4371-4115-1906-08dc6f9d83c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lB8W2GVGHBtmaRyZtagh+OrVLEVxX8BhCr6OLX+KZO4iTRW09irb7bgDgYOM?=
 =?us-ascii?Q?Abg3hkO6Rem9WBXxnLkOqQrkTHWPvWckhuMsBLz1w6sVp9oVcxXuHaD3FE/Z?=
 =?us-ascii?Q?ldCTK7z4UyMdTNeKXo18eBn9V39ynB7gslcNCtnzHgoakT4gMhDtZApXwS4i?=
 =?us-ascii?Q?ueh9dLZqv7M29Ik9U04ttIl9gRUUpm+QK7cM1MVeh/6xzSr8WCOr86tYeGPl?=
 =?us-ascii?Q?TKaxwdvyySGEu/brti7cKLRy993acluLVplEn+L7/dfcbyIHqjN8WQkoUpGb?=
 =?us-ascii?Q?4ZwShRk7+2mg6PKReKefyhmW3fOntbutxGw+9TRewdJ3Z7mwNyuqxjKIS0C+?=
 =?us-ascii?Q?muR44fJUnPGwrV2lHRPL1AAa+K+uhECFeX1FcivHcJ/HQAXECXuO3E3SzOYi?=
 =?us-ascii?Q?ykTyXLaxMm5glHLsKaqF51vLIb1FO27KrZO5mfgyiny8uKu/qaZxcDDkCs7W?=
 =?us-ascii?Q?atzXd+PSeN0NcJCnDUqQ+OD8tAD9x/BQdk6y83kk1EWIDPRKHO8QtRSNFS30?=
 =?us-ascii?Q?q/PlGC9E9wDR07pPwYIyIhEZR10vQ0hhUMRPzTJrIE4pdAt02mykQPjmv5QU?=
 =?us-ascii?Q?7WHuZjPXqf6q/XUcrjwYLQmoIS83OQASR7UCyUuITjvKBD64+WGusnudYgrd?=
 =?us-ascii?Q?0QFfnDxaCaL2K+PXa+P2se56gQtO5uE8qYnHwwfIcFCcyaSXxqfmClFvqg6r?=
 =?us-ascii?Q?cYBCqTe99oYcyDPB8b2Jq6EHL7XeJDxlIIvBf3eoHKdL+GA2GGpYYpvwHfOK?=
 =?us-ascii?Q?JWhRukWng+wd7Wm8RNCv7rgKvUtY5fNii252p1PI1fixUWyqIl7zuQQdRnde?=
 =?us-ascii?Q?ZoDE99kcStw9hDTyD/JP5uO+ko+ZM/YONCdBiJXHHEdnmLv9ru63W0dXHsjU?=
 =?us-ascii?Q?BGalYGFmpTMbSohWnInA17nKBKLh76d4man4qfTIMU9hYwF3liVrDFAJAX02?=
 =?us-ascii?Q?kC4ayXbUqHR3TRDrVJPaJ9iADKeTGniEIjcxeR2hPpqgY1aDE82Lr8tuCw+O?=
 =?us-ascii?Q?TJoMqv/DNgIXeKjL2Z1Wxb7YJ4/FL5OGckxAL/m2+uvqXiroqA279kD6oLXb?=
 =?us-ascii?Q?hi1amAlW+pY0KfuR/tZ8oKNUkneFkpeFHcJ1Ay64mMomtkwt0oOUKn1UKgZk?=
 =?us-ascii?Q?ISO0YgWhVJiZbXEPExKLaYO4WtoR3181U+SDF4UGmLC7ln/nei2d0QZTxQSa?=
 =?us-ascii?Q?4mooaSYh97OdEbNlOELcaZK5C/ud+cjKMPn47lyQkq3RmCFtXT5T2iT7e6V9?=
 =?us-ascii?Q?Y0VgEK4M/Q1KP2FmJ+MyR8Igv3d3Dca3hD4xmxbjYzKo/9cREklOe/QV2A7e?=
 =?us-ascii?Q?6MdpQwISa2x4k27Tx4sNzFzaZcshpAYMBudGxYYIz1Ol2Wn8SCMU+vQWEmEn?=
 =?us-ascii?Q?cb3wkno10RNlxsdhvu1TukDoqIfz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:29:09.0201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe17fdc-4371-4115-1906-08dc6f9d83c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538
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

V2: Addressed review comments from Christian
    - keep fence_ctx and fence_seq directly in fpriv
    - evcition_fence should be dynamically allocated
    - do not save eviction fence instance in BO, there could be many
      such fences attached to one BO
    - use dma_resv_replace_fence() in detach

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  20 ++++
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 106 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   8 +-
 5 files changed, 143 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index b0103f404957..9743bf06d6aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -82,7 +82,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o \
-	amdgpu_userq_fence.o
+	amdgpu_userq_fence.o amdgpu_eviction_fence.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2d5ef2e74c71..a37193fc9ddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -465,6 +465,11 @@ struct amdgpu_flip_work {
 	bool				async;
 };
 
+struct amdgpu_eviction_fence {
+	struct dma_fence base;
+	spinlock_t	 lock;
+	char		 timeline_name[TASK_COMM_LEN];
+};
 
 /*
  * file private structure
@@ -479,6 +484,12 @@ struct amdgpu_fpriv {
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
+
+	/* Eviction fence infra */
+	u64			ev_fence_ctx;
+	atomic_t		ev_fence_seq;
+	struct amdgpu_eviction_fence *ev_fence;
+
 	/** GPU partition selection */
 	uint32_t		xcp_id;
 };
@@ -1480,6 +1491,15 @@ void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
 int amdgpu_info_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
 
+/* Eviction fence */
+struct amdgpu_eviction_fence *amdgpu_eviction_fence_create(struct amdgpu_fpriv *fpriv);
+void amdgpu_eviction_fence_destroy(struct amdgpu_fpriv *fpriv);
+int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence *ev_fence,
+				 struct amdgpu_bo *bo);
+void amdgpu_eviction_fence_detach(struct amdgpu_fpriv *fpriv,
+				  struct amdgpu_eviction_fence *ev_fence,
+				  struct amdgpu_bo *bo);
+
 /*
  * functions used by amdgpu_encoder.c
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
new file mode 100644
index 000000000000..1a03f040ccc8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -0,0 +1,106 @@
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
+struct amdgpu_eviction_fence *
+amdgpu_eviction_fence_create(struct amdgpu_fpriv *fpriv)
+{
+	struct amdgpu_eviction_fence *ev_fence;
+	atomic_t seq = ATOMIC_INIT(0);
+
+	ev_fence = kzalloc(sizeof(*ev_fence), GFP_KERNEL);
+	if (!ev_fence)
+		return NULL;
+
+	spin_lock_init(&ev_fence->lock);
+	fpriv->ev_fence_seq = seq;
+	fpriv->ev_fence_ctx = dma_fence_context_alloc(1);
+	dma_fence_init(&ev_fence->base, &amdgpu_eviction_fence_ops,
+		       &ev_fence->lock, fpriv->ev_fence_ctx,
+		       atomic_inc_return(&fpriv->ev_fence_seq));
+
+	return ev_fence;
+}
+
+void amdgpu_eviction_fence_destroy(struct amdgpu_fpriv *fpriv)
+{
+	kfree(fpriv->ev_fence);
+}
+
+int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence *ev_fence,
+				 struct amdgpu_bo *bo)
+{
+	struct dma_fence *ef = &ev_fence->base;
+	struct dma_resv *resv = bo->tbo.base.resv;
+	int ret;
+
+	ret = dma_resv_reserve_fences(resv, 1);
+	if (ret) {
+		dma_fence_wait(ef, false);
+		return ret;
+	}
+
+	dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
+	dma_fence_get(ef);
+	return 0;
+}
+
+void amdgpu_eviction_fence_detach(struct amdgpu_fpriv *fpriv,
+				  struct amdgpu_eviction_fence *ev_fence,
+				  struct amdgpu_bo *bo)
+{
+	struct dma_fence *stub;
+	struct dma_fence *ef = &ev_fence->base;
+
+	stub = dma_fence_get_stub();
+	dma_resv_replace_fences(bo->tbo.base.resv, fpriv->ev_fence_ctx,
+				stub, DMA_RESV_USAGE_BOOKKEEP);
+
+	if (!dma_fence_is_signaled(ef))
+		dma_fence_put(ef);
+	dma_fence_put(stub);
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 85f1c05890bb..3355b750a652 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -199,8 +199,14 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	 * but not for export, this is a different lock class that cannot lead to
 	 * circular lock dependencies.
 	 */
-	if (!vm->is_compute_context || !vm->process_info)
+	if (!vm->is_compute_context || !vm->process_info) {
+		/* attach gfx eviction fence */
+		if (amdgpu_eviction_fence_attach(fpriv->ev_fence, abo))
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
 
+	amdgpu_eviction_fence_detach(fpriv, fpriv->ev_fence, bo);
+
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_prepare_obj(&exec, &bo->tbo.base, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d78b06af834e..9f4ffd195fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1294,7 +1294,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 }
 
-
 /*
  * Outdated mess for old drm with Xorg being in charge (void function now).
  */
@@ -1387,6 +1386,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	mutex_init(&fpriv->bo_list_lock);
 	idr_init_base(&fpriv->bo_list_handles, 1);
 
+	fpriv->ev_fence = amdgpu_eviction_fence_create(fpriv);
+	if (!fpriv->ev_fence) {
+		DRM_ERROR("Failed to craete eviction fence\n");
+		goto error_vm;
+	}
+
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
@@ -1460,6 +1465,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_bo_unreserve(pd);
 	}
 
+	amdgpu_eviction_fence_destroy(fpriv);
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
 	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
-- 
2.43.2

