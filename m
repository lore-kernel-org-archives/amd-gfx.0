Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CD0CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 11:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F3910EA5B;
	Tue, 16 Jun 2026 11:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mKhMuh8Y";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5384D10EA32
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZgMh6txwITlNfz8LgW6oBJJKogszooBG1qeT5qVNhyM19cbe7PRBYJerLe54fKAEFizT+7PrrPNODHIeFMGs4JAnHDuwty0fRZaxrUcylJj8CLoIJDsSyQ1IOyPSo1vWPvjeGlJwwV6UA3v92MRCEPKDrsAz+WaIo9bTrz0PacH2wcxuiYOie/GGanQrt+iHbKACsmE//DmjSv1xjSGe0I7WgAj3xMeQCrHigQ/1SxUNx/MSe9jX1Q53zcL2YnFyAuEuf8bvIfULj+G4Lt2qlrK7ozl/PyFpBgKkilUCNdGKd2gn0CdMZSW6llVlrFEl0g2ZhzcxYcCglBp26jX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n+cgPqcm6Ml6QAyRjFj50yFh3JdbQRjgJa+ukodtC8=;
 b=PtgQMdrvIm47ABfF4kVYiknsRtBfTcNRA6CsXJ+XVriOdHr0pbZat6GzTXPKzWzgZZs/n5PXy6itSwXEZSGktf1JLAJYjQi4JavuaC2uPuBqVLa4Nwa3b9dwGvaoFgpUpmtFuuWOsnAdaPqbb3NXw9i6whZ6Dx8zUF+u9dG1IGQC7LfGoMKc5P4HoXcEkQAg4P0PN2CY1WdV0yyBCypg9gf0y8ssUurWet1tqMsVkS7CKjJnohUzXqp9MkOYyQEQpcpEosprxOKKghjKxVBZCZNhmrhr1X/2u48l1I6IPxFLUu7OrtFtPPqbtmpZZd8iNtJOTB0G6lmOZXocFudWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n+cgPqcm6Ml6QAyRjFj50yFh3JdbQRjgJa+ukodtC8=;
 b=mKhMuh8Yd5eYtmbtYPqhvjKmph2D58gAiufh27qKTQV3DfHBivJsVjAaoTW6DkAAp2nfyGH1k9rGEzTgbH3VbczGux2XpTBKx3c5tOfF6bBmsa+XjPUgW4Q1hMPTetM+XhAjtwiZ03Q82SM357qPs+KY6TEryH1fH1riMmStzC8=
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 11:13:36 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::6e) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 11:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 11:13:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 16 Jun 2026 06:13:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 2/4] drm/amdgpu: Add wait-event manager and per-file
 lifetime plumbing
Date: Tue, 16 Jun 2026 16:42:40 +0530
Message-ID: <20260616111242.2922144-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616111242.2922144-1-srinivasan.shanmugam@amd.com>
References: <20260616111242.2922144-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cc0d9c-bef3-4141-4f25-08decb984f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OtlcnRxwUJWzP0J9XAWAUfEoiVCuZiFStpmOq6RMWmS9tnyCxXbRUfd4N1AH4d8E8gkVbWM/0AEmbefwmy//b8GIqBOERk4YwO9Qo/t3F2TQt2D07+jeuNTxn1aUxI2ihijDxIinTufh5Nk3sBTwOaR+gqh8M35RD0foi/6+hs3luJDATpljRB6ajVzIbbSIUTvpkxTMN3mThDraBOTAz28Lk6YVE/WybraBIPxhe3hNrQVFJhXXz8YDuDk/jcJQ0cju9yVV3wvxUrKUCXxg/ExtO00WEE8U2HG0TNiO0rqsOOCDSO69A2mhppEPlqJFnRkpn/778GDAC/El/gtvz70i4UDENRAiOU/+uAmLAxc9sd3+RbrtN2kUpnEs3/DhQEo5rkfAbESfe2nIMZUuNpRsQiW+TBrLVMFPr2riN8YtvnA709tmaWPBP21+Mfz3Ecm9Ds+WLKdj9Za6595gK46ih+HEmlKBvtXdxFD5SBrz1VifmqVhd+IiqWzRa2a10Sn7Sy93L9rR2VyQDO5hGgZ2WFGnhCnNJELXC3pJ7u7UUFrzPfRLVGGsVHTbBFWll2C/DCDAV9OxukALa0+lXDOQEAskd1/2oZC2c7RVfNHOHYBsYsv73KSNanQAkpkna/JZQWxoYh/TbKC/wUpBjRZP2VeHbwedCklnp/LJpAEX0RQtRIuCn9XHlPCPOoDYFPYwY5E++0UINXcWTeXmrhirtuPhgai4vvv3MX3bA1A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bgU5QwBSh6mNB/K+BrPpQZZCXe6ot/Z9ng04+BQ3YM7yEA9+wTJddCMn1QyIHnsOawasY840W01UUuto+6o/wsRY492SXH8RK50+XtKZxmXzCgLBvxTFJ+PsNDM1XtD58Dc8QWReG/A+uicqquKEr5mlmAY3dW31GJKXni63fmD3aKxn/FO3m6plJ+VFis5Mn6Gh/I6rXgQ7d+pvagM7nD2NJVTA0+5Cl66olbUQhta2CgTwYhMsKld5OAVaDy7oE9OcMVDjBYUQUGhtTwvuZa4zpM5amvvBpmeUcJ3haYg8lF7CD/eZcCJrifziWsTPKr76xGV/Aumgveem3DDEZwP9nakVHlVc03MqDutmnXvYDmVSv/0AOD3bu1ty7kaJU8E8pvzOdQou+nlwHJWkJcbT+TI/DoVe/TxrJh5lf2vyBAhLhjSpZJhaoGHzxrMz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:13:35.9497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cc0d9c-bef3-4141-4f25-08decb984f5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621
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
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 286 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  74 +++++
 5 files changed, 370 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index dd5a6fc5cbc2..0d3b08e4d9c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_eventfd.o
+	amdgpu_eventfd.o \
+	amdgpu_wait_event.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 54bc31ee795a..6edd3ea5cbd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -104,6 +104,7 @@
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
 #include "amdgpu_aca.h"
+#include "amdgpu_wait_event.h"
 #include "amdgpu_eventfd.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_cper.h"
@@ -458,13 +459,15 @@ struct amdgpu_fpriv {
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
index 3cb675a33945..c463308b02e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1555,6 +1555,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	}
 
 	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+	amdgpu_wait_event_mgr_init(&fpriv->wait_event_mgr);
 
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
@@ -1622,6 +1623,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (pasid)
 		amdgpu_pasid_free(pasid);
 
+	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
 	kfree(fpriv);
 
 out_suspend:
@@ -1652,8 +1654,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
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

