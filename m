Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714F8C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 086A610F059;
	Wed, 15 Jul 2026 13:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eI1r3YWR";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D71410F051
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hp6axRM3yWlG9P8CKqRiXFNxGJIsUr1ow/LOoTBDtHJKZmgwvL71kPbTB0rcsutHPYcpzjU4DdR3M3S59Bg1uXPc0PtGpuU0hcXWxHT2saaiQa/DAOd1xVz9zJMUOGGu2AM5VaJ7sTaEBVzC+xy9dho1NQYnNT99utc9r+ZBuRmUSEmskb2RkLSuDE7wpRjsCAJ1pZzyFJmBw3xymXTyRF8aF4VmC6Ws5Wr4tRsioBbUZGWpZdQvxshEu8AdccCm1Dx1jfqwXUJRVv7oWb89xLSTkGSmIhwztWEhdzAs/H2TPqdz3QnXHbydaQQZfqdP6PIaDWCBG/EdQlbKbqvKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwzidzDT9MSchjPXaEkK3lSfnqFhxqda/hl8tnM/DcE=;
 b=q8q5bxwsqpGAXCszSYVVn7yzU0UKIStpLdI+2SOgSVH0XpEcUFDDsSw7AgYhjttdZiLN5F10al9p/KOvyi47MTMIXy7e1BFVTYaL21bpIQwIROAhNzU5FiS27TK5mvOsT26ZJS1yBug4gzTAXOayQOjcosKcVhuLX2WxjzmXLw9l/mvi7kj69k8zEJW7opphFJIm82qnMJnuQwmHXG3gkGPcj75sttseCNLrvrYYr33rU5jIlXVc7vZ0gavuMbL8nssAk8V8SMBO34A1A3Sh+pQQfwFB35xkoeow+Jui9O4YWnOeAA6JKPcwSEDt0/Xx6i7TyUU7KZ+ELKDHUI3x0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwzidzDT9MSchjPXaEkK3lSfnqFhxqda/hl8tnM/DcE=;
 b=eI1r3YWRJuGRMhZrjPXA8zJ3yRIAbZciWzwyzZIacmYwIomZ7vdW9+zR/Pzp68wGhA7s5rMApoiNlqc9WJ7d9hlV+OtgNpTsgd3jXJ5uihjGqiURL4yeJImWXT2s0CSfXxyIRmrz9Gdw/CdpKwPDOTNGXu7+JiE0SJOcB4Ddjww=
Received: from BN9PR03CA0134.namprd03.prod.outlook.com (2603:10b6:408:fe::19)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:17:25 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::13) by BN9PR03CA0134.outlook.office365.com
 (2603:10b6:408:fe::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 13:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 13:17:24 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 08:17:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 2/5] drm/amdgpu: Add wait-event manager and per-file
 lifetime plumbing
Date: Wed, 15 Jul 2026 18:47:01 +0530
Message-ID: <20260715131704.3452312-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715131704.3452312-1-srinivasan.shanmugam@amd.com>
References: <20260715131704.3452312-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: a98fb670-7fab-4e7c-c23b-08dee27368d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|3023799007|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hEiPGh9oBfCq0nhVBv5G2WTAYpg59Zxpdy/+Pvy6XApYTjbZoFHXU+J91MP0Q/ZdQdl+NBlbK17XTHEC/uTPNFMGz0CRnh6wYU0stYDASVinoEeHsJms3TOwx2LknVcVmhIOgWF31NHm84OVdY1r1ElMvsWoAtQmd8VtTZOJtDsztUKHIoIlNEvYB5So11A0e2Ivht+7VtmQVgQV+bmpd/rE0FN0uodi4cZAHGXOGllfWg8VIbHEscc68hWjA6qabAtzb/ChwgkAhElk590O17vQkRvZF+iw8T9k7fEeYnq6hw/g18+zi8GWcXdGlq5g854IXohyTtsBivfSVk+XhfF+HCaA6nQ2ZS1pzVfPmNlMjdfBPDqIFodxn44Y/hQYqO28XWxXQTv0/beTpFMlZIvcmiJTLuix+vnjnha4y/PRMYlA6sfnnHTPpZMXSZPw4V/zt3BBgMqBwndEEfT/+FP/mP4I68RzfsjG+Vw2o1XLdzvhC/wxYZfv7KfrWFtJWji3ZbhzDxrWysyC7F11KcYQ2tyOTF1rtHXn4wVIOchTV7m7v33nQtHctXIiAui/T/8qt46braTRTVzSyXG+nxz6gLkayXXGOLkahcftpHb3KvtT0Z4CptVR6p6GWwtZle3/WTyQnVy4KP877n6/3gomChEGdMlYQ02InBmWlusWUTFDKFcKC2J8qdFJl09mBd+TvEyklGzbwUkbG+/dmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hdfHdOVcvB8agiR7EsmMMATlP99ay7W4fj7OFT7wqC8WaA1VqL7iqseS2Al3b6h0GqwjpJPDazHT27ci8FCsSNQF9MlW2yrtqZPuxbZVGCJ/bPbI/ZQ1G2uwQBuIII1/SfAnYksTXsryiVZvirXHWPr0v6dADdNiEYbM/3yoWtVGH10lzAtNlqYaimy4vC0lfOuUJVB44Lgi1mLLeHhOg4oi1S8B3LS9gR5qaezJu92y9Hllo3xqPes7MbqLyrGtzyloUbCsHKigbMPK+VhNr93jN/aaaZcPnCjY5bfvL23uw0RpEu/SW8xJXBbSylWBH7kDZF4r3+SbQg+mtm5UOKMVCbgu1XGkuL6C9rQaJMY2uDg2Ap9UCOyT13vzqejFfUWIsEreHFox0iH82T0ZOGp45xk5DWV1xZ07aY+LGF7M1hwVI5szybgVAVIit/GV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:17:24.0848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a98fb670-7fab-4e7c-c23b-08dee27368d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
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

Add the per-file WAIT_EVENT manager and lifetime plumbing used to store
and retrieve event records for render-node clients.

The manager maintains a list of pending WAIT_EVENT records, supports
blocking waits from userspace, copies the first matching event record to
userspace, and enforces single-consumer semantics by removing records
once they are consumed.

Register the WAIT_EVENT ioctl so render-node clients can access the
per-file WAIT_EVENT manager.

For queue-scoped events, queue_id is resolved to the corresponding
usermode queue object at the ioctl boundary. Pending records are matched
internally using queue pointer equality, while queue_id remains a
userspace identifier used only at the UAPI boundary and returned in
event metadata.

WAIT_EVENT now uses an absolute CLOCK_MONOTONIC deadline for timeout
handling. The remaining timeout is recomputed after each wakeup so that
interrupted or spurious wakeups continue to honor the original userspace
deadline.

Pending WAIT_EVENT records hold queue references while queued. Those
references are released when records are consumed, explicitly removed,
or destroyed during manager teardown.

Embed the WAIT_EVENT manager in amdgpu_fpriv and tie its lifetime to
drm_file. During teardown, the manager is marked dead before pending
records are detached and blocked waiters are awakened, preventing new
records from being queued while shutdown is in progress.

The USERQ manager is torn down before the embedded WAIT_EVENT manager is
finalized, so queues are removed from the producer lookup paths before
the manager can go out of scope. This existing teardown ordering
provides the lifetime guarantee for WAIT_EVENT producers without
requiring an additional manager reference.

Changes since v9:
- Switch WAIT_EVENT timeout handling to an absolute CLOCK_MONOTONIC
  deadline, as suggested by Christian.
- Recompute the remaining timeout after each wakeup.
- Simplify queue reference cleanup using unconditional
  amdgpu_userq_put().
- Clarify that queue pointers are used internally for event matching,
  while queue_id remains a userspace-only identifier.
- Improve kerneldoc describing manager state, event matching, and
  teardown ordering.
- Document the existing teardown ordering that guarantees the embedded
  WAIT_EVENT manager remains valid while USERQ producers are active.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 427 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    | 101 +++++
 6 files changed, 538 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index b7897f98436c..c4cee6a6bc64 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_eventfd.o
+	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_eventfd.o amdgpu_wait_event.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4f42888e2647..91f1dc737aee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -104,6 +104,7 @@
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
 #include "amdgpu_eventfd.h"
+#include "amdgpu_wait_event.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_lockdep.h"
 #include "amdgpu_cper.h"
@@ -427,13 +428,15 @@ struct amdgpu_fpriv {
 	uint32_t		xcp_id;
 
 	struct amdgpu_eventfd_mgr	eventfd_mgr;
+	struct amdgpu_wait_event_mgr	wait_event_mgr;
 };
 
 struct drm_device;
 struct drm_file;
 
 int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
-
+int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv);
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e90cf67c1cd8..b738a1bdf9d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3097,6 +3097,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_EVENT, amdgpu_wait_event_drm_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ccc9c3f8aba7..72bea83d7408 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1681,6 +1681,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	}
 
 	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+	amdgpu_wait_event_mgr_init(&fpriv->wait_event_mgr);
 
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
@@ -1754,6 +1755,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (pasid)
 		amdgpu_pasid_free(pasid);
 
+	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
 	kfree(fpriv);
 
 out_suspend:
@@ -1784,8 +1786,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
-	/* Drop all subscriptions before fpriv goes away. */
+	/* Drop eventfd subscriptions and pending wait-event records. */
 	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
+	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
 
 	pm_runtime_get_sync(dev->dev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
new file mode 100644
index 000000000000..db612106fb12
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#include <linux/jiffies.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include <linux/timekeeping.h>
+#include <linux/uaccess.h>
+
+#include "amdgpu.h"
+#include "amdgpu_userq_internal.h"
+#include "amdgpu_wait_event.h"
+
+/**
+ * amdgpu_wait_event_deadline_to_jiffies - calculate remaining wait time
+ * @deadline_ns: absolute CLOCK_MONOTONIC deadline in nanoseconds
+ *
+ * Convert an absolute CLOCK_MONOTONIC deadline into the remaining number
+ * of jiffies. A negative deadline requests an indefinite wait.
+ *
+ * The caller recalculates the remaining time after every wakeup so that
+ * spurious wakeups do not extend the userspace deadline.
+ *
+ * Return:
+ * Remaining wait time in jiffies, zero if the deadline has expired, or
+ * MAX_SCHEDULE_TIMEOUT for an indefinite wait.
+ */
+static long
+amdgpu_wait_event_deadline_to_jiffies(__s64 deadline_ns)
+{
+	u64 remaining_ns;
+	u64 now_ns;
+	u64 timeout;
+
+	if (deadline_ns < 0)
+		return MAX_SCHEDULE_TIMEOUT;
+
+	now_ns = ktime_get_ns();
+	if ((u64)deadline_ns <= now_ns)
+		return 0;
+
+	remaining_ns = (u64)deadline_ns - now_ns;
+	timeout = nsecs_to_jiffies(remaining_ns);
+
+	/*
+	 * Reserve MAX_SCHEDULE_TIMEOUT for the explicit indefinite-wait
+	 * case above.
+	 */
+	if (timeout >= MAX_SCHEDULE_TIMEOUT)
+		return MAX_SCHEDULE_TIMEOUT - 1;
+
+	/*
+	 * A future deadline shorter than one jiffy must still wait for at
+	 * least one scheduler tick.
+	 */
+	return timeout ?: 1;
+}
+
+/**
+ * amdgpu_wait_event_valid_type - validate a WAIT_EVENT event type
+ * @event_type: kernel-defined AMDGPU event type
+ *
+ * Return:
+ * True when @event_type is supported by the WAIT_EVENT UAPI.
+ */
+static bool amdgpu_wait_event_valid_type(u32 event_type)
+{
+	switch (event_type) {
+	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
+	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
+	case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
+	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
+	case DRM_AMDGPU_EVENT_TYPE_GPU_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * amdgpu_wait_event_record_free - release a pending event record
+ * @rec: record to release
+ *
+ * Drop the queue reference owned by the record and free the record.
+ */
+static void
+amdgpu_wait_event_record_free(struct amdgpu_wait_event_record *rec)
+{
+	if (!rec)
+		return;
+
+	amdgpu_userq_put(rec->queue);
+	kfree(rec);
+}
+
+/**
+ * amdgpu_wait_event_match - test whether a record matches a wait request
+ * @args: WAIT_EVENT request
+ * @queue: resolved queue for a queue-scoped request, or NULL
+ * @rec: pending event record
+ *
+ * Queue-scoped records are matched using queue pointer equality.
+ * queue_id is used only at the UAPI boundary and as returned metadata.
+ *
+ * Return:
+ * True when @rec matches the requested event type and queue scope.
+ */
+static bool
+amdgpu_wait_event_match(const struct drm_amdgpu_wait_event *args,
+			struct amdgpu_usermode_queue *queue,
+			const struct amdgpu_wait_event_record *rec)
+{
+	if (rec->data.event_type != args->event_type)
+		return false;
+
+	/*
+	 * Queue pointers are the internal matching key. queue_id is used
+	 * only at the UAPI boundary and as returned event metadata.
+	 */
+	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type))
+		return rec->queue == queue;
+
+	return !queue;
+}
+
+/**
+ * amdgpu_wait_event_has_match - check for a matching pending record
+ * @mgr: per-file WAIT_EVENT manager
+ * @args: WAIT_EVENT request
+ * @queue: resolved queue for a queue-scoped request, or NULL
+ *
+ * This helper is used as the waitqueue condition. It does not remove the
+ * matching record.
+ *
+ * Return:
+ * True when a matching record is pending.
+ */
+static bool
+amdgpu_wait_event_has_match(struct amdgpu_wait_event_mgr *mgr,
+			    const struct drm_amdgpu_wait_event *args,
+			    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_wait_event_record *rec;
+	unsigned long flags;
+	bool found = false;
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	list_for_each_entry(rec, &mgr->pending, node) {
+		if (amdgpu_wait_event_match(args, queue, rec)) {
+			found = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	return found;
+}
+
+/**
+ * amdgpu_wait_event_pop_match - remove the first matching record
+ * @mgr: per-file WAIT_EVENT manager
+ * @args: WAIT_EVENT request
+ * @queue: resolved queue for a queue-scoped request, or NULL
+ *
+ * Remove and return the first pending record matching the requested event.
+ * Removal provides single-consumer delivery.
+ *
+ * Return:
+ * Matching record, or NULL when no matching record is pending.
+ */
+static struct amdgpu_wait_event_record *
+amdgpu_wait_event_pop_match(struct amdgpu_wait_event_mgr *mgr,
+			    const struct drm_amdgpu_wait_event *args,
+			    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_wait_event_record *rec, *tmp, *found = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	list_for_each_entry_safe(rec, tmp, &mgr->pending, node) {
+		if (!amdgpu_wait_event_match(args, queue, rec))
+			continue;
+
+		list_del(&rec->node);
+		found = rec;
+		break;
+	}
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	return found;
+}
+
+/**
+ * amdgpu_wait_event_get_queue - resolve the requested queue scope
+ * @fpriv: AMDGPU per-file private data
+ * @args: WAIT_EVENT request
+ * @queue: returned queue reference
+ *
+ * Validate the requested event type and resolve queue_id for queue-scoped
+ * events. Device-scoped events require queue_id to be zero.
+ *
+ * The caller owns the returned queue reference and must release it with
+ * amdgpu_userq_put().
+ *
+ * Return:
+ * Zero on success or a negative error code.
+ */
+static int
+amdgpu_wait_event_get_queue(struct amdgpu_fpriv *fpriv,
+			    const struct drm_amdgpu_wait_event *args,
+			    struct amdgpu_usermode_queue **queue)
+{
+	*queue = NULL;
+
+	if (!amdgpu_wait_event_valid_type(args->event_type))
+		return -EINVAL;
+
+	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type)) {
+		if (!args->queue_id)
+			return -EINVAL;
+
+		*queue = amdgpu_userq_get(&fpriv->userq_mgr, args->queue_id);
+		if (!*queue)
+			return -ENOENT;
+
+		return 0;
+	}
+
+	if (args->queue_id)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * amdgpu_wait_event_mgr_init - initialize a per-file WAIT_EVENT manager
+ * @mgr: manager to initialize
+ *
+ * Initialize the pending-record list, waitqueue, sequence counter and
+ * shutdown state.
+ */
+void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr)
+{
+	spin_lock_init(&mgr->lock);
+	init_waitqueue_head(&mgr->wq);
+	INIT_LIST_HEAD(&mgr->pending);
+	atomic64_set(&mgr->seqno, 0);
+	mgr->dead = false;
+}
+
+/**
+ * amdgpu_wait_event_mgr_fini - finalize a per-file WAIT_EVENT manager
+ * @mgr: manager to finalize
+ *
+ * Stop new records from being published, detach all pending records,
+ * release their queue references and wake blocked waiters.
+ *
+ * The manager is embedded in amdgpu_fpriv. The USERQ manager is torn down
+ * before drm_file postclose invokes this function. Queue teardown removes
+ * queues from producer lookup paths and drains queue work, ensuring that
+ * USERQ producers have stopped before @mgr goes out of scope.
+ */
+void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr)
+{
+	struct amdgpu_wait_event_record *rec, *tmp;
+	unsigned long flags;
+	LIST_HEAD(removed);
+
+	/*
+	 * Prevent new records from being published before detaching pending
+	 * records and waking blocked waiters.
+	 */
+	spin_lock_irqsave(&mgr->lock, flags);
+	mgr->dead = true;
+	list_splice_init(&mgr->pending, &removed);
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	list_for_each_entry_safe(rec, tmp, &removed, node) {
+		list_del(&rec->node);
+		amdgpu_wait_event_record_free(rec);
+	}
+
+	wake_up_interruptible_all(&mgr->wq);
+}
+
+/**
+ * amdgpu_wait_event_remove_queue - remove pending records for a queue
+ * @mgr: per-file WAIT_EVENT manager
+ * @queue: queue being removed
+ *
+ * Detach all pending records associated with @queue while holding the
+ * manager lock. Queue references are released after the lock is dropped.
+ */
+void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
+				    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_wait_event_record *rec, *tmp;
+	unsigned long flags;
+	LIST_HEAD(removed);
+
+	if (!mgr || !queue)
+		return;
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	list_for_each_entry_safe(rec, tmp, &mgr->pending, node) {
+		if (rec->queue != queue)
+			continue;
+
+		list_move_tail(&rec->node, &removed);
+	}
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	list_for_each_entry_safe(rec, tmp, &removed, node) {
+		list_del(&rec->node);
+		amdgpu_wait_event_record_free(rec);
+	}
+
+	wake_up_interruptible_all(&mgr->wq);
+}
+
+/**
+ * amdgpu_wait_event_drm_ioctl - wait for an AMDGPU render-node event
+ * @dev: DRM device
+ * @data: struct drm_amdgpu_wait_event request
+ * @file_priv: DRM file issuing the request
+ *
+ * Resolve the request scope, consume the first matching pending record and
+ * copy its metadata to userspace.
+ *
+ * deadline_ns is an absolute CLOCK_MONOTONIC deadline. The remaining wait
+ * interval is recomputed from the original deadline after every wakeup so
+ * that spurious wakeups cannot extend the requested deadline.
+ *
+ * Return:
+ * Zero on success or a negative error code.
+ */
+int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_amdgpu_wait_event *args = data;
+	struct amdgpu_usermode_queue *queue = NULL;
+	struct amdgpu_wait_event_mgr *mgr;
+	struct amdgpu_wait_event_record *rec;
+	long remaining;
+	int ret;
+
+	if (!fpriv)
+		return -EINVAL;
+
+	if (args->flags || !args->event_type || !args->out_ptr)
+		return -EINVAL;
+
+	if (args->out_size < sizeof(struct drm_amdgpu_wait_event_data))
+		return -EINVAL;
+
+	ret = amdgpu_wait_event_get_queue(fpriv, args, &queue);
+	if (ret)
+		return ret;
+
+	mgr = &fpriv->wait_event_mgr;
+
+	for (;;) {
+		rec = amdgpu_wait_event_pop_match(mgr, args, queue);
+		if (rec)
+			break;
+
+		if (READ_ONCE(mgr->dead)) {
+			ret = -EIO;
+			goto out_put_queue;
+		}
+
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			goto out_put_queue;
+		}
+
+		remaining = amdgpu_wait_event_deadline_to_jiffies(args->deadline_ns);
+		if (!remaining) {
+			ret = -ETIME;
+			goto out_put_queue;
+		}
+
+		remaining = wait_event_interruptible_timeout(mgr->wq,
+							     READ_ONCE(mgr->dead) ||
+							     amdgpu_wait_event_has_match(mgr, args, queue),
+							     remaining);
+		if (remaining < 0) {
+			ret = remaining;
+			goto out_put_queue;
+		}
+	}
+
+	if (copy_to_user(u64_to_user_ptr(args->out_ptr), &rec->data,
+			 sizeof(rec->data)))
+		ret = -EFAULT;
+	else
+		ret = 0;
+
+	amdgpu_wait_event_record_free(rec);
+
+out_put_queue:
+	amdgpu_userq_put(queue);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
new file mode 100644
index 000000000000..9da68eb6c9b0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_WAIT_EVENT_H__
+#define __AMDGPU_WAIT_EVENT_H__
+
+#include <linux/atomic.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+
+#include <uapi/drm/amdgpu_drm.h>
+
+struct amdgpu_usermode_queue;
+
+/**
+ * struct amdgpu_wait_event_record - pending WAIT_EVENT record
+ * @node: link in the manager's pending-record list
+ * @queue: referenced queue for queue-scoped events, or NULL
+ * @data: event metadata returned to userspace
+ */
+struct amdgpu_wait_event_record {
+	struct list_head node;
+	struct amdgpu_usermode_queue *queue;
+	struct drm_amdgpu_wait_event_data data;
+};
+
+/**
+ * struct amdgpu_wait_event_mgr - per-file WAIT_EVENT manager
+ * @lock: protects @pending and @dead
+ * @wq: waitqueue used by blocked WAIT_EVENT ioctls
+ * @pending: pending event records
+ * @seqno: per-file monotonically increasing event sequence number
+ * @dead: prevents new records from being queued during teardown
+ */
+struct amdgpu_wait_event_mgr {
+	/* Protects @pending and @dead. */
+	spinlock_t lock;
+	wait_queue_head_t wq;
+	struct list_head pending;
+	atomic64_t seqno;
+	bool dead;
+};
+
+void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr);
+void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
+
+void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
+				    struct amdgpu_usermode_queue *queue);
+
+void amdgpu_wait_event_add(struct amdgpu_wait_event_mgr *mgr,
+			   u32 event_type,
+			   struct amdgpu_usermode_queue *queue);
+
+int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv);
+
+/**
+ * amdgpu_wait_event_type_is_queue_scoped - test event queue scope
+ * @event_type: kernel-defined AMDGPU event type
+ *
+ * Return:
+ * True when @event_type requires a USERQ queue handle.
+ */
+static inline bool amdgpu_wait_event_type_is_queue_scoped(u32 event_type)
+{
+	switch (event_type) {
+	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
+	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
+	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+#endif /* __AMDGPU_WAIT_EVENT_H__ */
-- 
2.34.1

