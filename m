Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7FCEFCE5A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 03:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA0310EAE5;
	Thu,  5 Mar 2026 03:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZqUvDN3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC8310EAE5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 03:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DH5qf9r+wBnF5YJrh+qF4h5vDc9oXetxsnvIly19HwxHK9XiEk0yh9aNsocPcDvFFbsVpUt77Ad/SwvLyCxwJVipH0GLd+huFfeMjw7V96Oi/rA1latmblEkOKRuaQoTk0KJLr0cdsl2uFaxDPfHsC52LpOSblx9/xd54m0dz96GNLTg8UqqB9C+wBsgco/IDHwAdVjxBtDlfdGzSKsHc2CA9OSKooGQ7CdEMADmgK9utagKCHFxtz50w5hygc48l0uG79ZFeeWBgyoIGfghgeqo4lYTL4UmQaNh0vViFkBeyhEROvqOpJkDRsa5y+jJa0Y4wanjZEoDboQ8irKVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UBOcNUioaPwACzPhE+BH1sTcAmmVCurwuvWqlG00W0=;
 b=CoaEZhEZE/WTd8BePEnR7bav7gqbcl8TKlm5GxnHh31W5q9iwWw0rbNeUWEYG2VVpnCJaEHekFnRqsrlRJaEy0gJ8wIJNZmWbERPMB2eb+6kTga6EHyzzEgZMgozv7FtY9sKEyijjV8AtHDBxntMZmk2kB9dvFyPiCDiSfnTs8nNQo+cyPHviIJLvchFT15qNa+nAykJwOupJpYOFBk0Vnorbran/ByQfJPf3YpXLQiu1Md8JiLESC0Dh0rTYJkBUZJsgiv+f0o2LFvZfqgjFCNEqVRS7Cx5jrDNyyOqXXdYjh7m/IfFbqQs1rBOgta76nlh4+517NNYSLAg8HNVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UBOcNUioaPwACzPhE+BH1sTcAmmVCurwuvWqlG00W0=;
 b=TZqUvDN3n4kJxC2irYcIxByCdh+oALwOo3HrtWjO+a2cgpDqzK7ipqDtPNXAgWhxCpgRKxrWZjqrPUPwYMGOhTVbW2OKEWwEoMNOWf/r2nuLkyB7hE36nqACoN75kXwfBPRn+9fs5TY/eU/WWanzOzE/1OS5WmYu1M8bQwpuyZo=
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by CH1PPF93AB4E694.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 03:07:52 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::68) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Thu,
 5 Mar 2026 03:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 03:07:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 4 Mar 2026 21:07:49 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 1/4] drm/amdgpu: Add render-node EVENTFD manager core
Date: Thu, 5 Mar 2026 08:37:23 +0530
Message-ID: <20260305030726.1779794-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305030726.1779794-1-srinivasan.shanmugam@amd.com>
References: <20260305030726.1779794-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|CH1PPF93AB4E694:EE_
X-MS-Office365-Filtering-Correlation-Id: c4847d4b-7e05-42b3-2a33-08de7a6463e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: n7E0NYPARXgyb+qy4B1FkvRJ5MyeyLfPd6LW0KBQ4hA4O6eeE9OvYV816A5SzbLwjoQ3M5e7SEFsOu5gfB/RifBVzNBC1i8A4ZgH4BRK50W3RokkzrJ9rTv+6cVCGvJDFLzBiuRp7iUX27h8h/NWGflSpN0Qc+KZckKt0kI4tmN/eTHhxXPAqDgOYsInhbzHmyjNz2ekgaZLT3fnxBj5HnQwWjbfyrO+m9ii8BQFYc1UEkl44C4TdzU/BqWclyxXxuLNhQN9zUGPBppfnwACv1vCek22XSvFnlJH3He0jE5GJ4dIkkdp9xZjUBzdZba4wSHjpTTxBNpnN12sowxTbNALBE5Wbg6kfn8pjFWb3I5E8WzNhHAivbARqaUXegvfKumDxDcsQIKr97ypK6z17vs39yYsUp4iKLdpXcGvf6DtItopxaplELcvB5YJbhTDBlT8ex6imC6+RjQuDpdVNoxF79r2K+IImtMFZhjOTYy8iMJEm16VuDENO9uAnqi9DoDtALBbbH7ofbO+OrYGYqp/IL7tspfSF/4casupjh/begb6tsNUtHYPD4kWoTaKOzy7CEuAQFblnCZORYadKQjbHHYWvY+l2oNIhphljBgE3cu5q/tN8X193dEuP+qIYo0ZO5vTIc5X4JIUM4KP6lQOB12GNEvqEuRj7x4xEbdudCayYPDUQOH1Jro6naGr6/jn3F0NAx96XpUjbrGLQGQ/Lr/g+5OPZjtCADgQhU/NlwIvd3h7RUIcWTykdG7M1NpqWepSOhrdfDEP6hSGag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1NgI9AYB/tNtUuWMEXWeD44ThhG4Ck4HNoekmYWoJT3ff1bj3qqUcDULDQ9spAh+PyP4JqFiDHH9pU9E8oYFG4V81vXLoO6Mb8phxX8dm3jYddhLPeK3XhEbjZ75tilWrKqMrU/5ymqR9no/O31sDSSVcgTELMtym5B1JMkgmZTll2wsb3svNwJayAk0FxANWsGnS8cxnChv9jrsI23bi47QtciKvxurU+EMg3S2y/kta95UE9XIsOmesUBvh7Y2eIHAFdYhkpifRWFYk9OQsTb811Rbk9saz5U6DdaHkYfN5wE3aQgYboiFpXmIfxgegcWXwT5aOAjPKYCvmjnccbACGDDCkPd6PVQ2N+wakQGeFXT+SIoQX2n324xJmZeO+y27C6koKFqAH+bBWVLq0SMuDhGbD2LXVLF9VTSPvrLo0Fjh+UUWA2BT8P6PtP3N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:07:52.2982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4847d4b-7e05-42b3-2a33-08de7a6463e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF93AB4E694
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 279 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  59 +++++
 3 files changed, 340 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 006d49d6b4af..30b1cf3c6cdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -67,7 +67,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
+	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
+	amdgpu_eventfd.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
new file mode 100644
index 000000000000..9806ec515cfc
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
@@ -0,0 +1,279 @@
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
+#include <linux/slab.h>
+#include <linux/err.h>
+
+#include "amdgpu_eventfd.h"
+
+#define AMDGPU_EVENTFD_MAX_BINDS 4096
+
+/*
+ * Helper: caller holds xa_lock_irqsave(&mgr->ids, flags).
+ *
+ * If id exists -> returns it, keeps new_id untouched (caller frees it).
+ * If id missing -> stores new_id and consumes it (sets *new_id = NULL).
+ */
+static struct amdgpu_eventfd_id *
+amdgpu_eventfd_get_or_create_id_locked(struct amdgpu_eventfd_mgr *mgr,
+				       u32 event_id,
+				       struct amdgpu_eventfd_id **new_id)
+{
+	struct amdgpu_eventfd_id *id;
+
+	id = xa_load(&mgr->ids, event_id);
+	if (id)
+		return id;
+
+	if (!*new_id)
+		return NULL;
+
+	if (xa_err(__xa_store(&mgr->ids, event_id, *new_id, GFP_NOWAIT)))
+		return NULL;
+
+	id = *new_id;
+	*new_id = NULL;
+	return id;
+}
+
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
+/*
+ * mgr lifetime is tied to fpriv:
+ * - init at open
+ * - fini at postclose (after unregister / wait for ongoing IRQs if needed)
+ */
+void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr)
+{
+	xa_init_flags(&mgr->ids, XA_FLAGS_LOCK_IRQ);
+	atomic_set(&mgr->bind_count, 0);
+}
+
+void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
+{
+	unsigned long index;
+	struct amdgpu_eventfd_id *id;
+
+	/*
+	 * Final teardown: keep xa locked while we remove ids and
+	 * drop all eventfd references (IRQ-safe).
+	 */
+	xa_lock_irq(&mgr->ids);
+	xa_for_each(&mgr->ids, index, id) {
+		struct amdgpu_eventfd_entry *e;
+		struct hlist_node *tmp;
+
+		__xa_erase(&mgr->ids, index);
+
+		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
+			hlist_del(&e->hnode);
+			id->n_entries--;
+			eventfd_ctx_put(e->ctx);
+			kfree(e);
+		}
+
+		kfree(id);
+	}
+	xa_unlock_irq(&mgr->ids);
+
+	xa_destroy(&mgr->ids);
+}
+
+int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
+{
+	struct amdgpu_eventfd_id *id, *new_id = NULL;
+	struct amdgpu_eventfd_entry *e = NULL;
+	struct eventfd_ctx *ctx;
+	unsigned long flags;
+	bool found = false;
+	int r;
+
+	if (!mgr || !event_id || eventfd < 0)
+		return -EINVAL;
+
+	/* Enforce total bind limit (atomic, no mgr lock). */
+	if (atomic_inc_return(&mgr->bind_count) > AMDGPU_EVENTFD_MAX_BINDS) {
+		atomic_dec(&mgr->bind_count);
+		return -ENOSPC;
+	}
+
+	/*
+	 * Allocate objects first (can sleep). Take references later.
+	 * new_id is cheap even if unused.
+	 */
+	new_id = amdgpu_eventfd_id_alloc(event_id);
+	e = kzalloc(sizeof(*e), GFP_KERNEL);
+	if (!e) {
+		r = -ENOMEM;
+		goto err_dec_limit;
+	}
+
+	ctx = eventfd_ctx_fdget(eventfd);
+	if (IS_ERR(ctx)) {
+		r = PTR_ERR(ctx);
+		goto err_free_entry;
+	}
+	e->ctx = ctx;
+
+	xa_lock_irqsave(&mgr->ids, flags);
+
+	id = amdgpu_eventfd_get_or_create_id_locked(mgr, event_id, &new_id);
+	if (!id) {
+		xa_unlock_irqrestore(&mgr->ids, flags);
+		r = -ENOMEM;
+		goto err_put_ctx_free_newid;
+	}
+
+	/* Duplicate bind policy: idempotent no-op. Compare ctx pointers. */
+	{
+		struct amdgpu_eventfd_entry *it;
+
+		hlist_for_each_entry(it, &id->entries, hnode) {
+			if (it->ctx == ctx) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			hlist_add_head(&e->hnode, &id->entries);
+			id->n_entries++;
+		}
+	}
+
+	xa_unlock_irqrestore(&mgr->ids, flags);
+
+	/* If event_id already existed, drop unused allocation. */
+	kfree(new_id);
+
+	if (found) {
+		/* Drop the new reference + entry; keep existing binding. */
+		eventfd_ctx_put(ctx);
+		kfree(e);
+		atomic_dec(&mgr->bind_count);
+	}
+
+	return 0;
+
+err_put_ctx_free_newid:
+	kfree(new_id);
+	eventfd_ctx_put(ctx);
+err_free_entry:
+	kfree(e);
+err_dec_limit:
+	atomic_dec(&mgr->bind_count);
+	return r;
+}
+
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
+			if (id->n_entries == 0) {
+				__xa_erase(&mgr->ids, event_id);
+				kfree(id);
+			}
+			break;
+		}
+	}
+
+out_unlock:
+	xa_unlock_irqrestore(&mgr->ids, flags);
+
+	/* Drop the temporary ref from fdget */
+	eventfd_ctx_put(ctx);
+
+	return removed ? 0 : -ENOENT;
+}
+
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
+	 * IRQ-safe: keep xa locked while signaling.
+	 * eventfd_signal(ctx) is IRQ-safe.
+	 */
+	xa_lock_irqsave(&mgr->ids, flags);
+
+	id = xa_load(&mgr->ids, event_id);
+	if (!id) {
+		xa_unlock_irqrestore(&mgr->ids, flags);
+		return;
+	}
+
+	hlist_for_each_entry(e, &id->entries, hnode)
+		eventfd_signal(e->ctx);
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

