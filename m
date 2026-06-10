Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1411DCD98CC
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 06:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BA110E713;
	Wed, 10 Jun 2026 06:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K33dbz+2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E973E10E713
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 06:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahTtSEftP+gXSBwFxbrBFhKawFo/UzIk3XAeK9y3TFu0Jybx3cWMSxZv8fP5m1zHKJnQlN6b+x8mTFxkuAYkwGT9tR6nIRRCuH8apCMRZBJ8eJJA1dJRolj3At/NiPPsGphzPCMiFNG5B5EzKjYvkEk7eYi/Sd70+SUg/vofh/410vCOOlC75Iu1A/IUdNRDdOKCqYaq1CbBiDuQnViUy9EcZaqA8YRcuUGvSIbK+IfEeJ8reTVQjnfxM5ybq0oHaPLJD2V+JOPZuggsWETHyU9DcL/SHdyhllkh9bRCq1vbOwT6ddpVtQweJDEGfuGMeZa3Vh0VRIe8Xu7k73ZKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAIO3e5/wBMKajdZGyXwcrXL5b518+j6Xeibbsiso08=;
 b=LxwjOySmOCn3JjpML8rVU3+x9fIio0eUKULdE9Lo4D1eoG18CGbHm3Qq3FKOSplrHb+I4kcitikg9UcLDRSgmlQ5TLawlmVEa0n+beRqIh9jgvGBjlo3O/nXKVD8aymAmreHITzs1siGJ4wQdWXdv9Igg3zNKcheLQUBvTkDoGVi40WuoBQrjG0ykB41MKsiuCg//YAQRX7EaU+XQUV9gmvAkJQ749t2XXG/Uv3X0XbjbUTkXh3NdY48gofUUKST+xpsmvxk4kis16iNPxOAfM1uQPjuvK1V3h38JwmvFSdFY/yA7FQ5oM8Tt3ZcKndg99QE+ZgAdfwi2/wAbeghiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAIO3e5/wBMKajdZGyXwcrXL5b518+j6Xeibbsiso08=;
 b=K33dbz+2qOufxV2mZBpOf7RGEzuC8DujnNJx0nsaFzeThwdT9SygCjqsRpQk5y2y2ORjs5W1IEDL0n8BIpETaqcrSSLqjSWlQPt8hgBJHfRy4imsXGGZ6Lq8TY+Dk7AgMtRSj5EALikH3YZG9BU1I+9qQ5Axo7My57Tt90vCSGk=
Received: from IA4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::15)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 06:04:33 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:558:cafe::9a) by IA4P220CA0010.outlook.office365.com
 (2603:10b6:208:558::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 06:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:04:32 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 10 Jun 2026 01:04:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 1/9] drm/amdgpu: Add render-node EVENTFD manager core
Date: Wed, 10 Jun 2026 11:33:54 +0530
Message-ID: <20260610060402.2769642-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
References: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 7850f41f-cb01-4278-9065-08dec6b623ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: fiRF5hxAgot5chOT1qWXdEQHm5axmJlXE1segYKz8cPD3sL//9q2juHFncpUrpCUK6+Ca6G9GHWLpIJmSuzj2BuQYkpEyEAuh+e+lRERnCkQlKVCZLiRpSOWIi9oCmoGdbQugrcgVUix47/hXvSzPvoqovVzCbcuptgXox9BzaVRx9TvmKAOT0ZSucROxWBM8eOb5SRlSjW2qaUMw9AQafdZi5xoEyPPwJ3CtmpKo6ESLt/U0QdrgwllKeWENqIetZwnW7u4Frlg4xtjLRM2q7CuTitlj6qAHgu62fMFaGtCpMeJS+zqSolP1uimrOwRwyrLQYy3Rag4/MTIj37g8GEWP/ibIQ0eTkh5TII0lB2cLm/auDIZN1uDLcHxDwG7mQM53qaRRg7Ti7A9lZ3BaAS8LTLSAAqQdpoFGvCdhrvtZl8q7Me2t+HcvHxI5tjjL5MrhfAA/zquqqjZRLI09cCD2uIL+gsMOGvRemwphbXkwR9ws/xZ38iQflkiRCgvxW/n4orUnWlRLvqpAJ8uYmUHdVYlUGzwadYGsMm11EIhAh56yBcinak6QIOo9zoE+mGo4vIZ6sUApEXvkkvbLSWb1I4yOr/l02VGtwYiWUqtgBc/Gz0A1zb5l/42gEmyhjqRAjZrYw2j/UWVC6bctc+1RU2bANsc+7yx6NqTj5JTp6G30Gzawa0JtjC4SMGXMYLPnQaOQJKiYh/0wlqB/d4tLwq8GKX3el4Zq8eWOPc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FkuN8Dxwv8k/8OU+fwkVIpTISTmySkVIZkAgcbf2bPXhMTbj0v7awa60IKAQEH2izuGxgnbqdGXJXQI/imqTziA88h0pyqlBaNjozMFj/nj89xfSX3fHtqF5Jka9Aws8lFlXbDTjwpV7dPaqIeyJ5a1KgR58NOHhrQVmdeoIalX3vu8tB9qRo4dXECf+YBOLtEPqY+1YiXc/wCPJlfiZWSQcqJCdWlOXiFQPVdwkKNKGAbD5FxkRWftBbanrz7eZtp6hNdanU4dDIG5PbechJYXUf18wbkyHfRpORDL7Bm3O0SPnmHrxfhXPfdvKKtzkbKhqR5PxtxNpg736cDsbh1tfxeLUIeBKcqvqHFpSoRQHcmb4CJ+kd5NePcW5KjbnUSay6ZELuLF/v8nd9YZ2GBdK7TBUCgXUbdK/OKB9rtH1MkxJnP6Pr7qLseo0lPqL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:04:32.1846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7850f41f-cb01-4278-9065-08dec6b623ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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
- Rework event_id get/create helper so it is callable without
  holding xa lock
- Move event_id allocation into the helper and use xa_insert()
  for insertion
- Drop GFP_NOWAIT usage in xa insertion path
- Allocate eventfd entry only after ctx/id prerequisites
  are satisfied
- Simplify fini path by removing per-entry __xa_erase() and
  relying on xa_destroy()
- Keep duplicate (event_id, ctx) binds idempotent

v10: (per Christian)
- Avoid GFP_ATOMIC in the event_id insertion path while holding the
  xarray lock.
- Use the recommended xarray insertion pattern to allocate memory
  outside the xarray lock.
- Simplify the eventfd unbind loop for readability.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 385 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  59 +++
 3 files changed, 446 insertions(+), 1 deletion(-)
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
index 000000000000..3a6e08a3d0c1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
@@ -0,0 +1,385 @@
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

