Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B54F433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6713110E7E2;
	Thu, 16 Apr 2026 03:27:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BvyCS+4Q";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010023.outbound.protection.outlook.com
 [52.101.193.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD52C10E7D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtDLli+2JXLROYX2J4sGRV0GpNKmPG05ICfLZKIQV/73twIP7xiFxzAg/FZZBIMgeDs3VlDZguOJ8yBKQT1UJOHvparM9Ia9+lc0LA9YkCm2NJrq3PLKpkv8Gkr+SZvOIWVRNqYRQWpzr0yAkJ91ZcyjaUSnmpb4d9v5R0Kodi0m6rYeRRk536Ln2nEg42qZ1EN+oGCiN5i9et45oDHNzHTBsgsUH8POpXNU0Odq6FlK0xHvAXZrf1JtSfxheKiDU7puEaAXVkH6YBXuVR+UEv+1LbTrLbkCr3gtCeYu08NV7+9yaLgzxekGCZe56TF4WnE5u561Pm08tQoNDqUz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=740DU/IzQjR0030E3L2pbdX8UG6SuLrb7KKrwIWsAmg=;
 b=kk0ZcGJA6S4Tp8gvu4weTk7LmKUxSmsMYpBV2Tgr7RIveH04Ox9jqnZYcS8G0anXcskynEVuB0C/R3fp/0PajwhV6IdBFTYGqJeu7xeyBF8FCXnMSIZmo3sBvHxmw8amxoHD7Eh5BEXK6BfYulRHCwKqPg4YCLB+o2XzfkJJ8faaK9H9HWHsJDNM6FlpPf5xNuIF27ROYhcSmSQlxgBbEwILZGrrfBza10tiOQpT2eEYf3FM/6AZKbTZuw9pPR1MMcXg2FENn176rc5lDrczBmMk2VXXLjNAZd5FH5lA9XlSzDq4eU78AhLZ2S0exZAgBBkwO4UXIZ85CWI9gffKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=740DU/IzQjR0030E3L2pbdX8UG6SuLrb7KKrwIWsAmg=;
 b=BvyCS+4QWMKCsvr88Vs/VBmGFc2+fXczkplfU0kvzco/L5K4W2AarSskCDnOK3l1qo15WFMJg7cBGBLZTV90YzqPzT2NBCskUcnWGqYxqPVpiQ0fCXpUYab2B8xTxgeh/Z3qNhr6q84bSFf0RxMMInVa2ZKFwHwA2dknGcv5TLg=
Received: from CH2PR17CA0008.namprd17.prod.outlook.com (2603:10b6:610:53::18)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 03:27:22 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::32) by CH2PR17CA0008.outlook.office365.com
 (2603:10b6:610:53::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 03:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:27:21 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:27:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 01/10] drm/amdgpu: Add render-node EVENTFD manager core
Date: Thu, 16 Apr 2026 08:56:50 +0530
Message-ID: <20260416032659.2368054-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
References: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 3639fedb-a1a3-44cf-bc38-08de9b68124e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003|22082099003|18096099003;
X-Microsoft-Antispam-Message-Info: OW7Q15BDS7pvVP1b/zL4Qi9wCL3ZMi1jbJ0AoQbEClYskNRBLdlwWP5oUoqAx0hLNo2yvMIVlrU8kZz6pMUAYcqb06SOGqGucrG96GCk6+MeBhhm2sG//JaWF8Su64Q3gmqktlqVJnW5cY3D05V6uvsCS3WhcxRtGhawaX3dsdxUPkHJilf7DgXXXnpb9uZDcYcloOq2EpulPYCYTcEMclPaD2gI0O0NwZOgcpjBAEb9Zo4c1/FtARdNp/mtYowdNDo9866Anjno0ZoLuWOhmDk4W54r0gjMGqHlt2IWwLyvjow9Q7Dyhz7LQwMXQkLoIfkPpQeK5YEsIdnNTQWtWax9QCK6C39sAj/eoQtQlf++0ed1S4EZtrNp/wqqUFwXrhQYDAwig0PT7LC/1nsrYwiKWBGuTYG+WPTi2Yd3H2gFEp0IzSszHji0lFTxrOfB71BHlxb70m5hRkkAhflODMWzbO60nnmJaAYsep7PHzOpLthxSZ0nvV3JrM6H7VVyq+qJn8O0a/qi5oEx/7J6VnFoDU3jyYo3kjnkqDOmNts4+8E03kkt8U0x+6y9wy9qWmxLXOuEeGDPGkwAhq7Pnj5hdJjDxGtSdBHjsMzW2vmKgt5MWwgbQRc0/t29S9Tqi+E7hV5hBlAzQCSfhPKYuRXDqkgawbhWao1U/oJfXHes2/uXrZagsgnVqyfGOTHO7akF5uitw+yjReNDwj+AaH78jQM10nMdhPeOkUl7muTYG6XzlQeP2xXhd8vU4gdeSXjTPzYROLk4CEJSbbq2TQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003)(22082099003)(18096099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iz34FuZK1S2w4QF9T4MkqqnBZ95WcYTnhqHE+wKmkTLRpHlQxazU2QaRAKEov3fWYEDzSFcB0iamlU21Y7wtDQnpnobUGnrKQdX6yWPFNb3QvV5cx7vXB4oROZRcyrfPOyHvv84S2YdVuxLX65jmr3YsZtR6pfxba+YJ99U3FkLkcdpNlxUNSEjYYY9zeZhvI4ChY4Qsn5LdNrOkeCucBXkSM3YyXdjJtPFIMEjFQSm/ZRrAO4O5xKhgHU0BolYu+64gVto8tAz4YziZDkQY2f6NjVNGnkAe6LCdEUmr5Di9ClLMrM20boKA3V2B6+lfGZnqwANIYjm39e+/UlADXXZILpgV2jPllug8F+Fdr/qgyjZ8NpMHV8b1rCBV2QCAK+evkwK5JuaW7mFmuxfqqIMyApX49HFV4/S6ETBh2B3+BUO4bl1vO0HKbbUQwDAk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:27:21.8518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3639fedb-a1a3-44cf-bc38-08de9b68124e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
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
drm_file (amdgpu_fpriv). It maps event_id -> eventfd_id object, where
each eventfd_id can have multiple eventfds bound (fan-out).

The design is IRQ-safe for signaling: IRQ path takes the xarray lock
(irqsave) and signals eventfds while still holding the lock.

This patch only adds the core manager

v4:
- Use eventfd_ctx pointer as binding identity instead of fd number
- Make duplicate (event_id, ctx) binds idempotent
- Replace mgr lock with atomic bind limit
- Add helper for xa get-or-create event_id

v5:
- Rework event_id get/create helper so it is callable without holding xa lock
- Move event_id allocation into the helper and use xa_insert() for insertion
- Drop GFP_NOWAIT usage in xa insertion path
- Allocate eventfd entry only after ctx/id prerequisites are satisfied
- Simplify fini path by removing per-entry __xa_erase() and relying on xa_destroy()
- Keep duplicate (event_id, ctx) binds idempotent

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 387 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  59 +++
 3 files changed, 448 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index db66c6372199..feea63b332fa 100644
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
index 000000000000..4cd80d8d1361
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
@@ -0,0 +1,387 @@
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
+ * (for example, user queue EOP events) without polling from userspace.
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
+	xa_lock_irqsave(&mgr->ids, flags);
+
+	/* Re-check after taking the lock in case another thread inserted it. */
+	id = xa_load(&mgr->ids, event_id);
+	if (id) {
+		xa_unlock_irqrestore(&mgr->ids, flags);
+		kfree(new_id);
+		return id;
+	}
+
+	/*
+	 * xa_insert() returns -EBUSY if an entry already exists.
+	 * Since we are in irqsave context here, use GFP_ATOMIC.
+	 */
+	r = xa_insert(&mgr->ids, event_id, new_id, GFP_ATOMIC);
+	if (r == -EBUSY)
+		id = xa_load(&mgr->ids, event_id);
+
+	xa_unlock_irqrestore(&mgr->ids, flags);
+
+	if (r == -EBUSY) {
+		kfree(new_id);
+		return id;
+	}
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
+	struct amdgpu_eventfd_entry *e, *it;
+	struct eventfd_ctx *ctx;
+	unsigned long flags;
+	bool dup = false;
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
+		eventfd_ctx_put(ctx);
+		atomic_dec(&mgr->bind_count);
+		return -ENOMEM;
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
+	if (dup) {
+		eventfd_ctx_put(ctx);
+		atomic_dec(&mgr->bind_count);
+		return 0;
+	}
+
+	/* Allocate entry only after ctx/id prerequisites are satisfied. */
+	e = kzalloc(sizeof(*e), GFP_KERNEL);
+	if (!e) {
+		eventfd_ctx_put(ctx);
+		atomic_dec(&mgr->bind_count);
+		return -ENOMEM;
+	}
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
+	if (dup) {
+		eventfd_ctx_put(ctx);
+		kfree(e);
+		atomic_dec(&mgr->bind_count);
+		return 0;
+	}
+
+	return 0;
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
+		if (e->ctx == ctx) {
+			hlist_del(&e->hnode);
+			id->n_entries--;
+			removed = true;
+
+			eventfd_ctx_put(e->ctx);
+			kfree(e);
+
+			atomic_dec(&mgr->bind_count);
+
+			if (!id->n_entries) {
+				__xa_erase(&mgr->ids, event_id);
+				kfree(id);
+			}
+			break;
+		}
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
+	 * IRQ-safe signaling path: keep xarray lock held while iterating and
+	 * signaling. eventfd_signal() is IRQ-safe.
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
\ No newline at end of file
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

