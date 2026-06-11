Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB9BCD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 14:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D583210EF86;
	Thu, 11 Jun 2026 14:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a/VXhn+H";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012036.outbound.protection.outlook.com
 [40.93.195.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5FF010EF69
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 14:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XacnuXYNjfH+VgkQpOP5uBn38gxUq1XHLA3ycPI3LnSXEles1JNjpkuOm9CUCWRwkpcbx0RjdNrxWr7AmMzsTWp+w3clJt7fse9aXUM2Pog5gEgOEG0AEDl0pyFxO87CKyi98e1qJTSxvRu04s8/K5wF6Ffrf1mnCx+Kres8WHcTGOzhwp5UEOyrTiWF3bZqRGEJIdpgtug9oTGnjOr2TKiK0X4baE3zOqBze9Q4YuDliG5FcFCtxqbwdrmw6gUp6smWrtXnl7Pp/mjZj4eRSZ5oZO9MY3i/wAUmbvQJENJI1nQ27hOIP+/XsYa1nSVOWf8Vzh9N4daUeVanPkBWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTMDpnulWMVDqUV0mzUsjVhaRYcNZMJnZvd+BNOusEE=;
 b=IesUiDCwO4cWOmDpQeBITHDxew4AuKIo/riNwtxTIoCCXn6ABPivDnOvKmHgWZdiJ9lpTn2WaBsTYuS5FyeMTZDRiGultDiWYhlDepweXyVMHctAwxzcrsdeFcRMnVDJ0tmelYP/M65uIA8uQBCRq5W3ha69esPyhSGH1FG1NEmooK4siO5SKTPFsvIy2ngJUgxodc1ws6uWW+AnAGGh4Vgk56UV7NvEiHFjJMvrv00L6+RwzwEwBgUTgZggSiHOyF01YWpykkFK5DO/LxDMij+12T4oGkbWA5imJnsEBNyQ/lt5aETxIgIw2RToFgjZGNNJMK06Z13Jo7zD6FGvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTMDpnulWMVDqUV0mzUsjVhaRYcNZMJnZvd+BNOusEE=;
 b=a/VXhn+Hu5HSyw73v86u/ppVPhEYFPRisWKzb1mjI/4JxymlaIcEbTog+xIIQ8hPx0RtbnQxXGLfSQLnU+Kn75JNDOeYKs1qvq+JzA6uLfVCAdqId9/bkUKWMpIDtccPJyIAfWcHUGUHlJDkmLooohYlQBGK/Mxxg1Koa6U1lpc=
Received: from SJ0PR03CA0264.namprd03.prod.outlook.com (2603:10b6:a03:3a0::29)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.17; Thu, 11 Jun 2026 14:34:12 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::31) by SJ0PR03CA0264.outlook.office365.com
 (2603:10b6:a03:3a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 14:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 14:34:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 11 Jun 2026 09:33:50 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 1/5] drm/amdgpu: Add render-node EVENTFD manager core
Date: Thu, 11 Jun 2026 20:03:22 +0530
Message-ID: <20260611143326.2870571-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
References: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: de8d5bd9-54e6-4b4e-a872-08dec7c68142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|22082099003|18002099003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: Y1SwDzt8azjE8sLUqukmMpc6ptWXwYVgDmw9lBDpIDcrbH2NSneX2qLPQq0nddJ4faJ2QHEZRnst/Hi8UpcBLexMaNYuUepsMRO6szNZuiPudrzjrgFa0nMwO31w+gc+TWPspZJDAcpbOQtkN/BklVrBBrElg0SIuvjoYRUnfeXbhupodf7EhQMb24L0BOAyTKdkunYLutFdjdA1sJcN9JhBc4KK5xyVGrPsr8Trza8WHRCdtxvY5lJgsN0JVvHWVeP8hzwNqljhevk9Mrh2d+VrdGeY/O96EHWnH04O2K8M4GB54GlGxzK9TsNfqMOtMFST55gpqJ4liAHrOJKRQCEds0XXqp0Fd+KfN3JKBG6T3u6sOWbliYfNnP5KpMV3P0PKXdoFKm0mzbaWTs88CRDNf18grCImQ7kHZ8NMJLC32LoGRA9fG7Dn7SwbY5E91PAFVdmPaRmVPp8ygyE6A0pxaKMT4Yo41XqRf1q4R55x0rVV2sOEROAKCQM7p4iublYAaE9V5oWiG6hQQHhvxyWuQ68BaYpJjJYPzNaah+OIrsfujxLh2cEHHIkY8DOTUbSjplmJrYJFqMKfUVdhmmafryUpKMTvGeWrZ8o0Bf+dNy9Z2J/9JM4iJZm8rOhCKRZFjnFtCb8GSjXt4p014lSOmLvSKOcLPRceJ+CC84UPgd7doBr0o6xV4GNgUqim4P/5Ka0qe4di+RwpTh76qrDI1Xw2cuSCTzqD1vySYeE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(3023799007)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O6khsVRVw4bZUYRCg0XsZUW4OODuARbCrW4Obp0qhL5dgPFCKkRQpWjIZ8+Jrr/yGdg5GK5kCyqRZJgstKI4mdt7wkk3OvY3a55g7UU2S/pJlBBnZoCYynDJMiEio1LaD2gClWeCDU5N1OyavAwF+4Rnh4fAkUoRg6c1f+LRqS3mmtc+XbnjNEXKHYTPE8BbRDswClEvlcm0HSIclTvv21r3YBxTM9BUg3bM84jJ3fHfq1seMR4rwWAAtAhB5I2E78yPJBz1Q8ShdnMoxIeqYMzk8wIenZW8pe1zv+NpHB5IYmPzCfwT4BjuU6V5Y1IBD7ADae7WK79q3cthuyubeW/lG79WaluJeDt3MoIDJogE+BHYkGhSE/dVDyS/eyfXUMFZ9OotIu3M8qWC3sPv+c16uZmXpV+KnSKYGt3HTojneK9S887WZjOxwLk/sRXF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:34:11.7937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de8d5bd9-54e6-4b4e-a872-08dec7c68142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795
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

Introduce a per-drm_file eventfd manager to support render-node event
subscriptions.

The manager is implemented in amdgpu_eventfd.[ch] and is owned by the
drm_file (amdgpu_fpriv). It maps an event identifier to an eventfd_id
object, where each eventfd_id can have multiple eventfds bound
(fan-out).

The design is IRQ-safe for signaling: IRQ path takes the xarray lock
(irqsave) and signals eventfds while still holding the lock.

This patch only adds the core manager.

Duplicate binds are treated as success, allowing userspace to
re-register subscriptions without errors.

v10: (per Christian)
- Avoid GFP_ATOMIC in the event identifier insertion path.
- Use the recommended xarray insertion pattern with memory allocation
  outside the xarray lock.
- Simplify the eventfd unbind loop for readability.

v11: (per Christian)
- Use goto-style cleanup in amdgpu_eventfd_bind() to avoid repeated
  cleanup paths.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 386 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  59 +++
 3 files changed, 447 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ee3574797bc2..dd5a6fc5cbc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
+	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
+	amdgpu_eventfd.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
new file mode 100644
index 000000000000..4955ee942a1c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
@@ -0,0 +1,386 @@
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
+/*
+ * Render-node eventfd subscription infrastructure.
+ *
+ * This module provides a simple event notification mechanism for render-node
+ * clients using Linux eventfd objects.
+ *
+ * Userspace can bind an eventfd to a userspace-defined event_id. When the
+ * driver signals that event_id, all eventfds bound to it are notified.
+ *
+ * This mechanism is intended to support lightweight GPU event notifications
+ * without polling from userspace.
+ */
+
+#include <linux/slab.h>
+#include <linux/err.h>
+
+#include "amdgpu_eventfd.h"
+
+#define AMDGPU_EVENTFD_MAX_BINDS 4096
+
+/**
+ * amdgpu_eventfd_id_alloc - allocate an event id container
+ * @event_id: userspace-defined event identifier
+ *
+ * Each event_id represents a notification category. Multiple eventfds can
+ * be bound to the same event_id.
+ *
+ * This function allocates the container which stores the list of eventfds
+ * associated with that event_id.
+ *
+ * Return:
+ * Pointer to the newly allocated structure or NULL on failure.
+ */
+static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
+{
+	struct amdgpu_eventfd_id *id;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id)
+		return NULL;
+
+	id->event_id = event_id;
+	INIT_HLIST_HEAD(&id->entries);
+	id->n_entries = 0;
+	return id;
+}
+
+/**
+ * amdgpu_eventfd_id_get_or_create - find or create an event_id entry
+ * @mgr: eventfd manager
+ * @event_id: event identifier
+ *
+ * This helper returns the container associated with the given event_id.
+ * If it does not exist, it will create one.
+ *
+ * The function is designed to be callable without holding any locks.
+ * Memory allocation is done outside the xarray lock to avoid blocking
+ * inside critical sections.
+ *
+ * Return:
+ * Pointer to the event_id structure or NULL on failure.
+ */
+static struct amdgpu_eventfd_id *
+amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
+{
+	struct amdgpu_eventfd_id *id;
+	struct amdgpu_eventfd_id *new_id;
+	XA_STATE(xas, &mgr->ids, event_id);
+	unsigned long flags;
+	int r;
+
+	xa_lock_irqsave(&mgr->ids, flags);
+	id = xa_load(&mgr->ids, event_id);
+	xa_unlock_irqrestore(&mgr->ids, flags);
+	if (id)
+		return id;
+
+	new_id = amdgpu_eventfd_id_alloc(event_id);
+	if (!new_id)
+		return NULL;
+
+	/*
+	 * Allocate xarray memory outside the lock if needed.
+	 * This avoids using GFP_ATOMIC while holding the lock.
+	 */
+	do {
+		xas_lock_irqsave(&xas, flags);
+
+		id = xas_load(&xas);
+		if (id) {
+			xas_unlock_irqrestore(&xas, flags);
+			kfree(new_id);
+			return id;
+		}
+
+		xas_store(&xas, new_id);
+		r = xas_error(&xas);
+
+		xas_unlock_irqrestore(&xas, flags);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	if (r) {
+		kfree(new_id);
+		return NULL;
+	}
+
+	return new_id;
+}
+
+/**
+ * amdgpu_eventfd_mgr_init - initialize eventfd manager
+ * @mgr: manager instance
+ *
+ * Each DRM file (amdgpu_fpriv) owns one eventfd manager.
+ *
+ * The manager stores mappings:
+ *
+ *   event_id -> list of eventfds
+ *
+ * The xarray provides efficient lookup of event_id containers.
+ */
+void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr)
+{
+	xa_init_flags(&mgr->ids, XA_FLAGS_LOCK_IRQ);
+	atomic_set(&mgr->bind_count, 0);
+}
+
+/**
+ * amdgpu_eventfd_mgr_fini - destroy eventfd manager
+ * @mgr: manager instance
+ *
+ * Frees all registered eventfd bindings.
+ *
+ * The caller is expected to ensure that no IRQ-side signaling can occur
+ * after this function begins. This typically happens during drm_file
+ * teardown.
+ */
+void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
+{
+	unsigned long index;
+	struct amdgpu_eventfd_id *id;
+
+	/*
+	 * Expected teardown ordering: caller ensures no further IRQ-side
+	 * signaling can race with this before fini() is called.
+	 */
+	xa_lock(&mgr->ids);
+	xa_for_each(&mgr->ids, index, id) {
+		struct amdgpu_eventfd_entry *e;
+		struct hlist_node *tmp;
+
+		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
+			hlist_del(&e->hnode);
+			eventfd_ctx_put(e->ctx);
+			kfree(e);
+		}
+
+		kfree(id);
+	}
+	xa_unlock(&mgr->ids);
+
+	xa_destroy(&mgr->ids);
+}
+
+/**
+ * amdgpu_eventfd_bind - bind eventfd to an event_id
+ * @mgr: eventfd manager
+ * @event_id: userspace event identifier
+ * @eventfd: eventfd file descriptor
+ *
+ * This function allows userspace to subscribe to notifications for a
+ * specific event_id.
+ *
+ * Multiple eventfds can be bound to the same event_id.
+ *
+ * Duplicate bindings of the same eventfd are treated as success and do
+ * not create additional entries.
+ *
+ * Return:
+ * 0 on success, negative error code on failure.
+ */
+int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
+{
+	struct amdgpu_eventfd_id *id;
+	struct amdgpu_eventfd_entry *e = NULL, *it;
+	struct eventfd_ctx *ctx;
+	unsigned long flags;
+	bool dup = false;
+	int r = 0; /* duplicate binds are treated as success */
+
+	if (!mgr || !event_id || eventfd < 0)
+		return -EINVAL;
+
+	/*
+	 * Enforce total bind limit without a separate manager lock.
+	 * For duplicate binds, we decrement back before returning success.
+	 */
+	if (atomic_inc_return(&mgr->bind_count) > AMDGPU_EVENTFD_MAX_BINDS) {
+		atomic_dec(&mgr->bind_count);
+		return -ENOSPC;
+	}
+
+	ctx = eventfd_ctx_fdget(eventfd);
+	if (IS_ERR(ctx)) {
+		atomic_dec(&mgr->bind_count);
+		return PTR_ERR(ctx);
+	}
+
+	id = amdgpu_eventfd_id_get_or_create(mgr, event_id);
+	if (!id) {
+		r = -ENOMEM;
+		goto out_put_ctx;
+	}
+
+	/* check for duplicate binding */
+	xa_lock_irqsave(&mgr->ids, flags);
+	hlist_for_each_entry(it, &id->entries, hnode) {
+		if (it->ctx == ctx) {
+			dup = true;
+			break;
+		}
+	}
+	xa_unlock_irqrestore(&mgr->ids, flags);
+
+	if (dup)
+		goto out_put_ctx; /* duplicate bind: success */
+
+	/* Allocate entry only after ctx/id prerequisites are satisfied. */
+	e = kzalloc(sizeof(*e), GFP_KERNEL);
+	if (!e) {
+		r = -ENOMEM;
+		goto out_put_ctx;
+	}
+
+	e->ctx = ctx;
+
+	/*
+	 * Re-check duplicate under lock to close the race with another bind()
+	 * for the same (event_id, ctx).
+	 */
+	xa_lock_irqsave(&mgr->ids, flags);
+	hlist_for_each_entry(it, &id->entries, hnode) {
+		if (it->ctx == ctx) {
+			dup = true;
+			break;
+		}
+	}
+
+	if (!dup) {
+		hlist_add_head(&e->hnode, &id->entries);
+		id->n_entries++;
+		e = NULL; /* consumed */
+	}
+	xa_unlock_irqrestore(&mgr->ids, flags);
+
+	if (dup)
+		goto out_free_entry;
+
+	return 0;
+
+out_free_entry:
+	kfree(e);
+out_put_ctx:
+	eventfd_ctx_put(ctx);
+	atomic_dec(&mgr->bind_count);
+
+	return r;
+}
+
+/**
+ * amdgpu_eventfd_unbind - remove eventfd binding
+ * @mgr: eventfd manager
+ * @event_id: event identifier
+ * @eventfd: eventfd file descriptor
+ *
+ * Removes an existing binding between an event_id and an eventfd.
+ *
+ * Return:
+ * 0 if removed, -ENOENT if binding does not exist.
+ */
+int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
+{
+	struct amdgpu_eventfd_id *id;
+	struct amdgpu_eventfd_entry *e;
+	struct hlist_node *tmp;
+	struct eventfd_ctx *ctx;
+	unsigned long flags;
+	bool removed = false;
+
+	if (!mgr || !event_id || eventfd < 0)
+		return -EINVAL;
+
+	ctx = eventfd_ctx_fdget(eventfd);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	xa_lock_irqsave(&mgr->ids, flags);
+
+	id = xa_load(&mgr->ids, event_id);
+	if (!id)
+		goto out_unlock;
+
+	hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
+		if (e->ctx != ctx)
+			continue;
+
+		hlist_del(&e->hnode);
+		id->n_entries--;
+		removed = true;
+
+		eventfd_ctx_put(e->ctx);
+		kfree(e);
+
+		atomic_dec(&mgr->bind_count);
+
+		if (!id->n_entries) {
+			__xa_erase(&mgr->ids, event_id);
+			kfree(id);
+		}
+
+		break;
+	}
+
+out_unlock:
+	xa_unlock_irqrestore(&mgr->ids, flags);
+	eventfd_ctx_put(ctx);
+
+	return removed ? 0 : -ENOENT;
+}
+
+/**
+ * amdgpu_eventfd_signal - notify all eventfds bound to event_id
+ * @mgr: eventfd manager
+ * @event_id: event identifier
+ *
+ * This function is typically called from interrupt context.
+ *
+ * All eventfds registered for the given event_id will be signaled.
+ * Userspace processes waiting on those eventfds will wake up.
+ */
+void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
+{
+	struct amdgpu_eventfd_id *id;
+	struct amdgpu_eventfd_entry *e;
+	unsigned long flags;
+
+	if (!mgr || !event_id)
+		return;
+
+	/*
+	 * This can run from IRQ context. Keep the lock while walking the list
+	 * so entries cannot disappear during signaling.
+	 */
+	xa_lock_irqsave(&mgr->ids, flags);
+
+	id = xa_load(&mgr->ids, event_id);
+	if (id) {
+		hlist_for_each_entry(e, &id->entries, hnode)
+			eventfd_signal(e->ctx);
+	}
+
+	xa_unlock_irqrestore(&mgr->ids, flags);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
new file mode 100644
index 000000000000..248afb1f2f14
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
@@ -0,0 +1,59 @@
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
+/*
+ * Render-node eventfd subscription infrastructure.
+ */
+
+#ifndef __AMDGPU_EVENTFD_H__
+#define __AMDGPU_EVENTFD_H__
+
+#include <linux/eventfd.h>
+#include <linux/xarray.h>
+#include <linux/atomic.h>
+
+struct amdgpu_eventfd_entry {
+	struct eventfd_ctx *ctx;
+	struct hlist_node hnode;
+};
+
+struct amdgpu_eventfd_id {
+	u32 event_id;
+	struct hlist_head entries;
+	u32 n_entries;
+};
+
+struct amdgpu_eventfd_mgr {
+	struct xarray ids;          /* event_id -> struct amdgpu_eventfd_id* */
+	atomic_t bind_count;        /* total binds across all event_ids */
+};
+
+void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
+void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
+
+int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
+int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
+
+void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id);
+
+#endif /* __AMDGPU_EVENTFD_H__ */
-- 
2.34.1

