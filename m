Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4DBC44501
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 16:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE19110EA6F;
	Mon, 13 Jul 2026 16:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rX6yczzP";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5C210EA63
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 16:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbWiYr6bbKBljtLAskz40vyIegZ+mzIYX0C3vHfvNgTRzPWHfGkahkOMEcUyT8vFkeYYXBzWSzT89tgX1aWpVEYG3hoECl4ds3bPcVOcdCD7ATNRRr9MgzmbMEPPgFWqpddyEZHD+SGsbx7Hr9WrS5PqBvhpLn50Su+GmUONaNc1IYnGN6YKwFeKzZAgIABrUeabmukBVa34bry5H4Cyz0iztUHm6utYb5O4jKpwakYK78LZi/etm3V6n8ocELCWxAzawZwUJSop1HBaoDYOW8+7HNPBoXEjhs1Vb+cruTzS7Jc/j8MgDw5evAJDtlrI8BFw+D9XIuNhJE/o47MmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2vyY49tIppdIXNFj5gC9PF3xmmT02JrTBjzvKt3CrM=;
 b=BqyPxpw/bZTu+8VbbMhUI1JCYd1ngB3gkp1npF21GAwOwMisSwozd7Su/v81Nxjh3afbEsP421o2ug9MiVPlRAJeHH/0QUjaunEevipFmYPEPWsnveLck6XC/ceyNCFpPvt8hlHWY+TWt22Lilbas9BeGwbaeJu8QwdzV+BHlql8904MMyFo3G7YROhE3YbYll7qjuTMslC277oOANl+oMfXUzJtrEWZFWlN0+ZEhyIK8G5oXJXnbkr3t+V9rfsKYXm4DXnvCzVBq2eviZJHY27cFQJSsJfyI0BNw7AIbEnCQ9ysiuwHcBwTeaAqIjK3mqOMJ2gnMl7lVDyo/wbDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2vyY49tIppdIXNFj5gC9PF3xmmT02JrTBjzvKt3CrM=;
 b=rX6yczzPnPACZt6eB0q4d29dC1DDnsPMks+1uWeviT6eWp0AmDaxh7KJlM66aX9cbvjpb0HpmN/exArPcSuXmVcT6xUW9pe/q21K1L4WeICRCssfRUkDOgQ7E+TV6uyJ8HUdmo2GXPjgaNLKty7qwrwjWfwsK/CwPJhrk5rZyIE=
Received: from SA0PR11CA0156.namprd11.prod.outlook.com (2603:10b6:806:1bb::11)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 16:43:51 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::62) by SA0PR11CA0156.outlook.office365.com
 (2603:10b6:806:1bb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 16:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 16:43:51 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 13 Jul 2026 11:43:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 2/6] drm/amdgpu: Add wait-event manager and per-file
 lifetime plumbing
Date: Mon, 13 Jul 2026 22:13:17 +0530
Message-ID: <20260713164321.3350036-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713164321.3350036-1-srinivasan.shanmugam@amd.com>
References: <20260713164321.3350036-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d19c6c-f7ca-4686-1760-08dee0fdeb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|3023799007|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5cIzQkC/DR0NJTqc9hl6v6ZRQ0aDKIFhhHTsWgm/WN9jP5Mlia1SQVLsnCYuP0e5FyoMhvZtFv+JMCbNEz7od+yLVP+jQXhedreorChtIW6q/rSnaWArerpn4jL2iUEMm0vfuq3UFwSNe/iBu9ylZh3vhtcULoeULX7NY7YJ6Ahc4UWi+EJIKRl61cfxa7eK+sKqnEwcBUNVNS6s0xKgGyknzAPtaE2SVM6ZBaYUrn70/Y6+3ZVpimWVTjv4eHmAN0as2EU++F1TR8clwrSgMvYE+5vkrwktIpeRZ8Tp74XpUDdMdmNHgDQd6HGiocNnaVDjxYFrOexRMODUdCnyXeXBG9oGmneRt3Q75zRIW/F8frjlvSj5MTDO+WGmVayj/x9o5ma99uyG7kEg2ax6qnhwugtjKiBkqJYT1TlSOPkPpw+M8WMBVtu4N4dz9RD3TlVqkMFhZhA7Gcsyj5JMxk/CGdmlmQ5cfbpM/FknTzKuFfPupilWKIze6UraWjjk8CNUfJJhfAoKqj/Sr8FvOKqPMGHcw/mHfUXXlFnl2Sk3Jufj39h/m8IwlB4jBOZFzn3G9OCDA7eAyFjAa5g+zTL6orA5JutTkISUs5VVxSyoCHGDTHhNpDy0zCo98auISJ6ElhOWNDhb8a+p+cEK02O8IKpA3OVm911jPvMekWYSVwvg83D4LS/Y/StBP4g1qAsyTIGxswraJW1B/7PLiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0545qH/WTLEvI6oFtfB0TJJHDK7v1nTD0KBvdEQiWOfKyejLJZe7byaxEoB00Wr9I+Z4FoQtGUPRn6vhziqpBGgYeyvjolUAK3HWL5x7iQ++qBcHyLJJ+eFgyxIb5Dx3cMo30v0BuIfinUPHdSCe9HzNzP53vcdDrPKxGnRWSgxHFx91BJLTWD24vojDSB0EW27DETDgU8BEC1sV23slGmerSn51gWe+zRgM2joFvCItKbHW58FfOiHroB8NMsvdBCfTaaTXq3p1jrMV83Bmsg5+WKaJx5yO9U0sbLs730FKYrHeMm5hZg35eFLupmVurbf7QZUkkRMBKxdF9CtnCnP4M8Rb+jAZfmhPEcpMhHx/V093XtFpLum+S9s+9PxOITgCtrcgPOmhSEDDQiQsTBsF3p5GNRj0yXyyFfnAR/7MEE67iZkttZsAH1IFMPNF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:43:51.4916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d19c6c-f7ca-4686-1760-08dee0fdeb80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427
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

Add a per-drm_file WAIT_EVENT manager for render-node events.

The manager maintains a list of pending WAIT_EVENT records, supports
blocking waits from userspace, copies the first matching event record to
userspace, and enforces single-consumer semantics by removing records
once they are consumed.

For queue-scoped events, queue_id is resolved to the corresponding
usermode queue object at the ioctl boundary. Pending records are matched
using queue pointer equality rather than queue_id values, avoiding
internal routing through reusable userspace handles.

Pending WAIT_EVENT records hold queue references while queued. Those
references are released when records are consumed, explicitly removed,
or destroyed during manager teardown.

Embed the WAIT_EVENT manager in amdgpu_fpriv and tie its lifetime to
drm_file. Initialize the manager during file open and destroy it during
file close so that pending records are cleaned up and blocked waiters
are released before file-private state is freed.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 286 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  74 +++++
 5 files changed, 369 insertions(+), 3 deletions(-)
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
index 000000000000..f98de1d94b56
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -0,0 +1,286 @@
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
+#include <linux/uaccess.h>
+
+#include "amdgpu.h"
+#include "amdgpu_userq_internal.h"
+#include "amdgpu_wait_event.h"
+
+static long amdgpu_wait_event_to_jiffies(__s64 timeout_ns)
+{
+	unsigned long long t;
+	long timeout;
+
+	if (timeout_ns < 0)
+		return MAX_SCHEDULE_TIMEOUT;
+	if (timeout_ns == 0)
+		return 0;
+
+	t = nsecs_to_jiffies(timeout_ns);
+	if (t > MAX_SCHEDULE_TIMEOUT)
+		timeout = MAX_SCHEDULE_TIMEOUT - 1;
+	else
+		timeout = t;
+
+	return timeout ?: 1;
+}
+
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
+static void
+amdgpu_wait_event_record_free(struct amdgpu_wait_event_record *rec)
+{
+	if (!rec)
+		return;
+
+	if (rec->queue)
+		amdgpu_userq_put(rec->queue);
+
+	kfree(rec);
+}
+
+static bool
+amdgpu_wait_event_match(const struct drm_amdgpu_wait_event *args,
+			struct amdgpu_usermode_queue *queue,
+			const struct amdgpu_wait_event_record *rec)
+{
+	if (rec->data.event_type != args->event_type)
+		return false;
+
+	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type))
+		return rec->queue == queue;
+
+	return !queue;
+}
+
+static bool
+amdgpu_wait_event_has_match(struct amdgpu_wait_event_mgr *mgr,
+			    const struct drm_amdgpu_wait_event *args,
+			    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_wait_event_record *rec;
+	bool found = false;
+	unsigned long flags;
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
+		if (amdgpu_wait_event_match(args, queue, rec)) {
+			list_del(&rec->node);
+			found = rec;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	return found;
+}
+
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
+void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr)
+{
+	spin_lock_init(&mgr->lock);
+	init_waitqueue_head(&mgr->wq);
+	INIT_LIST_HEAD(&mgr->pending);
+	atomic64_set(&mgr->seqno, 0);
+	mgr->dead = false;
+}
+
+void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr)
+{
+	struct amdgpu_wait_event_record *rec, *tmp;
+	unsigned long flags;
+	LIST_HEAD(removed);
+
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
+int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_amdgpu_wait_event *args = data;
+	struct amdgpu_usermode_queue *queue = NULL;
+	struct amdgpu_wait_event_mgr *mgr;
+	struct amdgpu_wait_event_record *rec;
+	long timeout;
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
+	timeout = amdgpu_wait_event_to_jiffies(args->timeout_ns);
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
+		if (!timeout) {
+			ret = -ETIME;
+			goto out_put_queue;
+		}
+
+		timeout = wait_event_interruptible_timeout(mgr->wq,
+							   READ_ONCE(mgr->dead) ||
+							   amdgpu_wait_event_has_match(mgr, args, queue),
+							   timeout);
+		if (timeout < 0) {
+			ret = timeout;
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
+	if (queue)
+		amdgpu_userq_put(queue);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
new file mode 100644
index 000000000000..e887fffdc4ac
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -0,0 +1,74 @@
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
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/atomic.h>
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+#include <uapi/drm/amdgpu_drm.h>
+
+struct amdgpu_usermode_queue;
+
+struct amdgpu_wait_event_record {
+	struct list_head node;
+	struct amdgpu_usermode_queue *queue;
+	struct drm_amdgpu_wait_event_data data;
+};
+
+struct amdgpu_wait_event_mgr {
+	/* Used when adding, removing, or checking pending events. */
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
+int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv);
+
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

