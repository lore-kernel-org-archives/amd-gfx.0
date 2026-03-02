Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25815D58E4B
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 03:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48BE10E348;
	Mon,  2 Mar 2026 03:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0wErwtGE";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF1110E348
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 03:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VX2XmEiQUjXIDqaYCQTysbHZJQ86eZBPugJ3MhR/8FCzd+NRPyvocJa5kRfr187Y5mHA2DGYZuliCQPUo2ls8Ej4P+y6hZqt6RQmAwgQq2dtbITtqn87t1vWzPrdP1WIagk9WQS8FTaPaHVK3TwnXGurdJztr5Xc9EY3To/MLuhoPu+UUlZuvLPUonMkrxAzHyIxbxN8Bfs3jiwVRZ/OAfgcvxWV4NEplgodjTLswjKW68R3oLti1E/vh7u4WgwiWdltvJfL2eOZZQy4hSGpDiJobNwb8s4sn8H11cG00SKp/u5GLckw3A+7+p/HOIuNxgOQ8a1ECmmNUlXS771N2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foRMkNvd/SDXabaPdRgUWHn6sda54jkNnjMuzULvK10=;
 b=RHoux+TITFalAre9XhDAFW72VAySD0mWHwHb8QD4rDZ+caSXPiTAvEBLeC9JXM2je3Rk/ZgdRuOz45b/A4paXMQvDMlbBqYUq54BxYQsBvDom+DpHLPTqI1PwO9+x5d7HUt9fg0HDIlaBGXbEfTrwvHyLyzKLOOcEqg2vbs9RSxdkJl/31t7MvSQzwBVOO3Mh5wsgGFMyvL2asL1pgmW9q+7y11TqWYZ0D9e5vxQpuh3Lmcorvbl7DsrJy3NYknn7EO6vpCDg0s28UCNhvbLfkuyl7n1Tq4HXLfM8RJNlVLlWuizrIMmSiRcFKj4J/yENuNRJ74ffU/lBXfSoRzjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foRMkNvd/SDXabaPdRgUWHn6sda54jkNnjMuzULvK10=;
 b=0wErwtGEK/cXhgboIEmp0ob2BBlCpVXsUpvTeAkXFi8a8alAgaWq54nCC3IzvdTEoHg5YPPv6bHipUREqxdD3HPcHiq9cwZqT2t9ZMvqUFF3SIYvrFZhrSmPGmAjHlQjGxhov7c+Pw3K/xZUSkLXIIj1SGGLL/H/TNpT6BCJnpM=
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 03:02:44 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::d6) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Mon,
 2 Mar 2026 03:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 03:02:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 1 Mar 2026 21:02:41 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v3 1/4] drm/amdgpu: Add render-node EVENTFD manager core
Date: Mon, 2 Mar 2026 08:32:16 +0530
Message-ID: <20260302030219.1734986-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302030219.1734986-1-srinivasan.shanmugam@amd.com>
References: <20260302030219.1734986-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb878aa-5348-43f1-ad6a-08de78082cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: fD6evjdEISikqtTOzC98PRFXQRUKRI4fADciSEiD8gZsDKHIeFBHRQDK/M1THf/yMFLZj0mL56j3jZuajnMa2My8CAPUjPhySgiOjVdAJl69N/L+mVfORz+Y8WN4nsCe7YX+hV4c+QVjJ11quex7itwnRUvO23g7AhDRmAtTuErTrJG8DtpNIHX+AE1DBz9OSgObjwsvEh0Mfvp4jb0gZT+le5Fvmmd88kabfBe21spw3DEcGiYC0BKhYBOJfr577OkHAbGE0YexEI+iP7J6Mq1sNjIWvRtzrDeU8OEKwl9a426pxghDqtbyleV+m5O4c2ReHZHVlr3BjG8DA+cXqWbiT3vlo3Vf+rwoDQTrfgqUxzYLLKmIdTSu5rMs/cHvRddO2Q4zza0Zpol/txHef9s6cS61MFQ5P9Yq9cqa6Dc/PsfEYwM5wu5zJaOqgW3gQgz7fMh2M105Fr8NY/4hCMCQ7k4bDlQqE/vhLvAQuN6Pq0E8U2bDJWWA6w/w1Oj/CWoGssvBJaKTDlArv9GGTS+LGxnQ+1ZpAjHBnVyIM0akifKBFlh1C6aWjooxiH1t/vhLCOF0EmA1gv3k5/sDo73NZIFA/LwbLsSBa+YdrTEB135JhfssQXOXDzvkd5ETJ6+VVwNEImjMBSX4G3wHOUKsv/f+2VNaJC/vxC6NSAzoQgVDjjxlMiVivExjBE5YdEO4TuYZ7RR9TzN1+hBc24WMVdx/dULpNfKulijHbI5ZXXs1yhxwP5h0qdPdi/oGzuiCGEq6AGW3QebKGejWgWz9ZLi9v47vrMTAjKll6TcQYRmORcK922WVZbIsyA6AK3w6rV+c9XBkYCQdqCFYAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pBEqI0Et/lp4I84jIhG3yhxaWmDx+MK+CZ6xtkov2tInH9QZIW2a6atPC+4FEsEYD24ztpoNqoP3L93kCJmGkWtAh8uG9Pog2U8W8R+qbpyAqg+dG9WVZhijxXeKkv+l7VPtAfPgd+G+vLwB0D0mvazM9lEtOuDxBCiyFlYA6+qo4WYTDmHOcz5dr7kDwPCY57Km2sWhh4OUjrD2vjzfJL7APdhuG/uNupgwKwhSRRLQdhXjOYTxxqLbPFUiL7ZX8Inrg8vZ4pRp98QJozLQX+eke6IMLZetsV1l9+8BnmEyzH4k6Kk4dqbi7IWq8mg9Z/H4g4i1mHo5JMr5zZN8AJAKKl0/voxuRZ2mWsg0gEo8xY2m6nxxm/FaeL+sJgHj0kRVnaseRbI4ps1+RQYfcY4AU+mlyl72832F33DB5hlJaX0Jkng+2LUQuISUoYlN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 03:02:43.9406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb878aa-5348-43f1-ad6a-08de78082cd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
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

This patch only adds the core manager and wires its lifetime into
open/postclose.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: Iac025dcb7c1b4f9ed74ac4190085e1925e2c8e68
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 321 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  76 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  28 +-
 5 files changed, 430 insertions(+), 3 deletions(-)
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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1e71a03c8bba..9e650b3707e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -44,6 +44,7 @@
 #include <linux/hashtable.h>
 #include <linux/dma-fence.h>
 #include <linux/pci.h>
+#include <linux/xarray.h>
 
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_placement.h>
@@ -434,6 +435,8 @@ struct amdgpu_flip_work {
 	bool				async;
 };
 
+struct amdgpu_eventfd_mgr;
+
 /*
  * file private structure
  */
@@ -453,6 +456,8 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+
+	struct amdgpu_eventfd_mgr	*eventfd_mgr;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
new file mode 100644
index 000000000000..15ffb74c1de3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
@@ -0,0 +1,321 @@
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
+/*
+ * Render-node eventfd subscription infrastructure.
+ */
+
+#include <linux/slab.h>
+#include <linux/err.h>
+
+#include "amdgpu_eventfd.h"
+
+static void amdgpu_eventfd_mgr_release(struct kref *ref)
+{
+	struct amdgpu_eventfd_mgr *mgr =
+		container_of(ref, struct amdgpu_eventfd_mgr, refcount);
+	unsigned long index;
+	struct amdgpu_eventfd_id *id;
+
+	/* Final teardown: remove all ids and drop all eventfd references. */
+	spin_lock(&mgr->lock);
+	mgr->fd_closing = true;
+	spin_unlock(&mgr->lock);
+
+	xa_lock(&mgr->ids);
+	xa_for_each(&mgr->ids, index, id) {
+		struct amdgpu_eventfd_entry *e;
+		struct hlist_node *tmp;
+
+		__xa_erase(&mgr->ids, index);
+
+		spin_lock(&id->lock);
+		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
+			hlist_del(&e->hnode);
+			id->n_entries--;
+			if (e->ctx)
+				eventfd_ctx_put(e->ctx);
+			kfree(e);
+		}
+		spin_unlock(&id->lock);
+		kfree(id);
+	}
+	xa_unlock(&mgr->ids);
+
+	xa_destroy(&mgr->ids);
+	kfree(mgr);
+}
+
+struct amdgpu_eventfd_mgr *amdgpu_eventfd_mgr_alloc(void)
+{
+	struct amdgpu_eventfd_mgr *mgr;
+
+	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+	if (!mgr)
+		return NULL;
+
+	kref_init(&mgr->refcount);
+	xa_init(&mgr->ids);
+	spin_lock_init(&mgr->lock);
+	mgr->bind_count = 0;
+	mgr->fd_closing = false;
+
+	return mgr;
+}
+
+void amdgpu_eventfd_mgr_get(struct amdgpu_eventfd_mgr *mgr)
+{
+	if (mgr)
+		kref_get(&mgr->refcount);
+}
+
+void amdgpu_eventfd_mgr_put(struct amdgpu_eventfd_mgr *mgr)
+{
+	if (mgr)
+		kref_put(&mgr->refcount, amdgpu_eventfd_mgr_release);
+}
+
+void amdgpu_eventfd_mgr_mark_closing(struct amdgpu_eventfd_mgr *mgr)
+{
+	if (!mgr)
+		return;
+
+	spin_lock(&mgr->lock);
+	mgr->fd_closing = true;
+	spin_unlock(&mgr->lock);
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
+	spin_lock_init(&id->lock);
+	INIT_HLIST_HEAD(&id->entries);
+	id->n_entries = 0;
+	return id;
+}
+
+int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
+{
+	struct amdgpu_eventfd_id *id, *new_id = NULL;
+	struct amdgpu_eventfd_entry *e;
+	struct eventfd_ctx *ctx;
+	unsigned long flags;
+	bool found = false;
+
+	if (!mgr || !event_id || eventfd < 0)
+		return -EINVAL;
+
+	/* If file is closing, refuse new binds. */
+	spin_lock(&mgr->lock);
+	if (mgr->fd_closing) {
+		spin_unlock(&mgr->lock);
+		return -EBADF;
+	}
+	spin_unlock(&mgr->lock);
+
+	ctx = eventfd_ctx_fdget(eventfd);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	e = kzalloc(sizeof(*e), GFP_KERNEL);
+	if (!e) {
+		eventfd_ctx_put(ctx);
+		return -ENOMEM;
+	}
+	e->ctx = ctx;
+	e->eventfd = eventfd;
+
+	/*
+	 * Prepare id object outside xa_lock_irqsave(): kzalloc(GFP_KERNEL)
+	 * must not happen while holding spinlock/irqs-disabled.
+	 */
+	new_id = amdgpu_eventfd_id_alloc(event_id);
+
+	/*
+	 * IRQ-safe design:
+	 *  - protect id lookup + insertion under xarray lock (irqsave)
+	 *  - protect entry list under id->lock
+	 */
+	xa_lock_irqsave(&mgr->ids, flags);
+
+	id = xa_load(&mgr->ids, event_id);
+	if (!id) {
+		if (!new_id) {
+			xa_unlock_irqrestore(&mgr->ids, flags);
+			eventfd_ctx_put(ctx);
+			kfree(e);
+			return -ENOMEM;
+		}
+		if (xa_err(xa_store(&mgr->ids, event_id, new_id, GFP_NOWAIT))) {
+			xa_unlock_irqrestore(&mgr->ids, flags);
+			kfree(new_id);
+			eventfd_ctx_put(ctx);
+			kfree(e);
+			return -ENOMEM;
+		}
+		id = new_id;
+		new_id = NULL;
+	}
+
+	/* Enforce total bind limit. */
+	spin_lock(&mgr->lock);
+	if (mgr->bind_count >= AMDGPU_EVENTFD_MAX_BINDS) {
+		spin_unlock(&mgr->lock);
+		xa_unlock_irqrestore(&mgr->ids, flags);
+		kfree(new_id);
+		eventfd_ctx_put(ctx);
+		kfree(e);
+		return -ENOSPC;
+	}
+	spin_unlock(&mgr->lock);
+
+	spin_lock(&id->lock);
+	{
+		struct amdgpu_eventfd_entry *it;
+
+		hlist_for_each_entry(it, &id->entries, hnode) {
+			if (it->eventfd == eventfd) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			hlist_add_head(&e->hnode, &id->entries);
+			id->n_entries++;
+		}
+	}
+	spin_unlock(&id->lock);
+
+	if (!found) {
+		spin_lock(&mgr->lock);
+		mgr->bind_count++;
+		spin_unlock(&mgr->lock);
+	}
+
+	xa_unlock_irqrestore(&mgr->ids, flags);
+
+	/* If event_id already existed, drop unused allocation. */
+	kfree(new_id);
+
+	/* If already bound, keep existing and drop the new reference. */
+	if (found) {
+		eventfd_ctx_put(ctx);
+		kfree(e);
+	}
+	return 0;
+}
+
+int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
+{
+	struct amdgpu_eventfd_id *id;
+	struct amdgpu_eventfd_entry *e;
+	struct hlist_node *tmp;
+	unsigned long flags;
+	bool removed = false;
+
+	if (!mgr || !event_id || eventfd < 0)
+		return -EINVAL;
+
+	xa_lock_irqsave(&mgr->ids, flags);
+	id = xa_load(&mgr->ids, event_id);
+	if (!id) {
+		xa_unlock_irqrestore(&mgr->ids, flags);
+		return -ENOENT;
+	}
+
+	spin_lock(&id->lock);
+	hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
+		if (e->eventfd == eventfd) {
+			hlist_del(&e->hnode);
+			id->n_entries--;
+			removed = true;
+			if (e->ctx)
+				eventfd_ctx_put(e->ctx);
+			kfree(e);
+			break;
+		}
+	}
+	spin_unlock(&id->lock);
+
+	if (removed) {
+		spin_lock(&mgr->lock);
+		if (mgr->bind_count)
+			mgr->bind_count--;
+		spin_unlock(&mgr->lock);
+	}
+
+	/* If no more eventfds bound to this event_id, remove id object. */
+	if (removed && id->n_entries == 0) {
+		(void)xa_erase(&mgr->ids, event_id);
+		kfree(id);
+	}
+
+	xa_unlock_irqrestore(&mgr->ids, flags);
+
+	return removed ? 0 : -ENOENT;
+}
+
+void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id, u64 count)
+{
+	struct amdgpu_eventfd_id *id;
+	struct amdgpu_eventfd_entry *e;
+	unsigned long flags;
+	bool closing;
+
+	if (!mgr || !event_id || !count)
+		return;
+
+	/* Fast closing check (best-effort). */
+	spin_lock(&mgr->lock);
+	closing = mgr->fd_closing;
+	spin_unlock(&mgr->lock);
+	if (closing)
+		return;
+
+	/*
+	 * IRQ path: keep xarray locked while signaling, as suggested.
+	 * eventfd_signal() is IRQ-safe.
+	 */
+	xa_lock_irqsave(&mgr->ids, flags);
+	id = xa_load(&mgr->ids, event_id);
+	if (!id) {
+		xa_unlock_irqrestore(&mgr->ids, flags);
+		return;
+	}
+
+	spin_lock(&id->lock);
+	hlist_for_each_entry(e, &id->entries, hnode) {
+		if (e->ctx)
+			eventfd_signal(e->ctx);
+	}
+	spin_unlock(&id->lock);
+
+	xa_unlock_irqrestore(&mgr->ids, flags);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
new file mode 100644
index 000000000000..542a1d65e13b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
@@ -0,0 +1,76 @@
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
+/*
+ * Render-node eventfd subscription infrastructure.
+ */
+
+#ifndef __AMDGPU_EVENTFD_H__
+#define __AMDGPU_EVENTFD_H__
+
+#include <linux/kref.h>
+#include <linux/spinlock.h>
+#include <linux/xarray.h>
+#include <linux/eventfd.h>
+
+/*
+ * Manager lifetime:
+ *  - owned by drm_file (amdgpu_fpriv)
+ *  - can also be referenced by longer-lived producer objects (e.g. USERQ fence
+ *    driver) via kref.
+ */
+struct amdgpu_eventfd_mgr {
+	struct kref		refcount;
+	struct xarray		ids;     /* key: event_id(u32) -> struct amdgpu_eventfd_id* */
+	spinlock_t		lock;    /* protects ids + counts */
+	u32			bind_count;
+	bool			fd_closing;
+};
+
+struct amdgpu_eventfd_entry {
+	struct hlist_node	hnode;
+	struct eventfd_ctx	*ctx;
+	int			eventfd;
+};
+
+struct amdgpu_eventfd_id {
+	u32			event_id;
+	spinlock_t		lock;    /* protects entries */
+	struct hlist_head	entries; /* struct amdgpu_eventfd_entry */
+	u32			n_entries;
+};
+
+/* Per-file cap to align with common KFD-style event-id space and avoid abuse */
+#define AMDGPU_EVENTFD_MAX_BINDS 4096U
+
+struct amdgpu_eventfd_mgr *amdgpu_eventfd_mgr_alloc(void);
+void amdgpu_eventfd_mgr_get(struct amdgpu_eventfd_mgr *mgr);
+void amdgpu_eventfd_mgr_put(struct amdgpu_eventfd_mgr *mgr);
+void amdgpu_eventfd_mgr_mark_closing(struct amdgpu_eventfd_mgr *mgr);
+
+int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
+int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
+void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id, u64 count);
+
+#endif /* __AMDGPU_EVENTFD_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f69332eed051..8ab8f9dc4cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -42,6 +42,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gem.h"
 #include "amdgpu_display.h"
+#include "amdgpu_eventfd.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
 #include "amd_pcie.h"
@@ -1469,10 +1470,17 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
+	fpriv->eventfd_mgr = amdgpu_eventfd_mgr_alloc();
+	if (!fpriv->eventfd_mgr) {
+		r = -ENOMEM;
+		goto free_fpriv;
+	}
+
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
 		pasid = 0;
+		goto error_pasid;
 	}
 
 	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
@@ -1538,6 +1546,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (pasid)
 		amdgpu_pasid_free(pasid);
 
+free_fpriv:
+	if (fpriv && fpriv->eventfd_mgr) {
+		amdgpu_eventfd_mgr_put(fpriv->eventfd_mgr);
+		fpriv->eventfd_mgr = NULL;
+	}
+
 	kfree(fpriv);
 
 out_suspend:
@@ -1568,6 +1582,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	amdgpu_eventfd_mgr_mark_closing(fpriv->eventfd_mgr);
 	pm_runtime_get_sync(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
@@ -1605,10 +1620,19 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	idr_destroy(&fpriv->bo_list_handles);
 	mutex_destroy(&fpriv->bo_list_lock);
 
+	pm_runtime_put_autosuspend(dev->dev);
+
+	/*
+	 * Drop the eventfd manager BEFORE freeing fpriv.
+	 * (mgr can be refcounted by longer-lived producers)
+	 */
+	if (fpriv->eventfd_mgr) {
+		amdgpu_eventfd_mgr_put(fpriv->eventfd_mgr);
+		fpriv->eventfd_mgr = NULL;
+	}
+
 	kfree(fpriv);
 	file_priv->driver_priv = NULL;
-
-	pm_runtime_put_autosuspend(dev->dev);
 }
 
 
-- 
2.34.1

