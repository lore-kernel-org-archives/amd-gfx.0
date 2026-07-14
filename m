Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C56C44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DCEC10EC51;
	Tue, 14 Jul 2026 08:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hDUKyhg+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011069.outbound.protection.outlook.com
 [40.93.194.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4219B10EC51
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYRSZ0/lBmgJpdsfg3BT223RtJmaY6LJoXTRqwspuhaXj3D6rlWooOhBvciHgkRL9ZhiaTys2OxLL6ZbQXKaP/T9b2TgkHYefZ3Jf7jfBJRZos/0dhxmNBHaUVXyCe1DX+I/37lqncx854PAe6X/sG7gN+sUIm/okZtIIJCjGwkspLZm1cotFwLQre3BO0gALrnw/AtLyGv+P9UUHE39MCuFoJbtRffQWupfwsgn60EV/3XJ1pdmpPlrhF4fHRSS8dTs+7BIsZgnbR+1MUmWyi0Eq7GtEQURJk6lAhFsznbva8oWZx5JBObNYxRyzZVj8GomLIN5EQ3hXRG1XHBnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j2p5GNr7xhIolJKb8p+xNcYWu9EbbKVtyWP+vGV4vY=;
 b=sAqKoMn62jJbCL4wj5WdeKxuhaRMEtYOcAIf9qiAsCOsyVjz4zpZxIewoapJbC/9vftVQjlSTmv5cinrKy02aXx6vsWQ+JmkRmTFZZjoEr2oHyVWd/zJEPf38HTN1Qz4UIgPo+AEamIDSC5IOuhzXSI8nHicB3GfrFzdwMGtmyUaAJCsYSCGfSTrVgZhoa4QZgNbQ3wBXDiwWqloKn3GRkt3ryDQ6kYD66gY9XLl+ZfV3ns1TZWCjX0qIitiCMNU+U0EchgpJG5PvJvco2gPz14ojc+7UEt5MpbN41pMhvWc+0SZgX3VXosugysYF3aRw8A/uCRVYhZAvDN5e+M+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j2p5GNr7xhIolJKb8p+xNcYWu9EbbKVtyWP+vGV4vY=;
 b=hDUKyhg+N5AbDJK/LBEveH7/G+IkVmaE8ewpik9Ux0/HX721eqkCFJ4cTWkm++Apa57i29FyhvJcvhqJ92TDh1Td2NHngDt4sPpw/DJGruUVlWknZWdopoc/vCZUPpCLbaPPi2BfPzPMTi1fK8QFzUkVHlsEaBCrBNborDXNm6Q=
Received: from SJ0PR13CA0118.namprd13.prod.outlook.com (2603:10b6:a03:2c5::33)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 08:10:38 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::68) by SJ0PR13CA0118.outlook.office365.com
 (2603:10b6:a03:2c5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 08:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 08:10:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 03:10:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 2/5] drm/amdgpu: Add wait-event manager and per-file
 lifetime plumbing
Date: Tue, 14 Jul 2026 13:40:20 +0530
Message-ID: <20260714081023.3395485-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7e76cc-c27d-4d01-aa73-08dee17f63ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yGdIIc40vjG3B4ezusHbPDv9+NwOaNmKgR4+8SuuDbZkp1jsg7VdoaZzwnmeh+a40ieW5fzcH60qZqf+OZ5/OMjQ1pJG15B49NtPsWS7wQDNXq5MhIbxcOv1u/SXSUAxoB9m10PbKKBY3qNjQOwQped7B4J0Rr3YwN5hB1TqLH0ZnJjBIMbR0tW3IE2QdpKlnPxTiS6Ik4DpkVqTpGg3VqOYsteD26gIH6P3yU9OtiP5mZ0yMdczR5vOKd7W8h9flWqyl1pJkxoKO9x+dlDlEWPJBGcJSx9O1U07JVZNrMm0RcknyaXY3vQYLPakJCfEf/XoVKf+N4NmaaiFb6wdDafux+/+gRhF7A0Qw4yQviJhP6ow6QirujxeMuZfuSZoDaatrhOTxRgvDFl+5+rF4SCEyMN4aIrl3JVB83x4CmBgA5eRfvZkz/EFEOJ9EQGPEPgmuhFoMCsDAPfpEyBr70XRHeUQ/USlTpwi7mB5gm+N8e9V1gv4oOExTqD8r51CgOqvuRMme9DSClVbSRz9W4wY3JmXKfbaghebgjXmiHFa+WpWVyNwVvUdCXf+hMhngWsRsOkO4ZJl2WP9DGd58+hANmvUgVvr9cSu6Ex7B429Xu8ngxq9kEzODVWkUJyEao6wHYWB7BTHtjxYqgGsnSXIU6d7zWOYEarVxFktA40/88wTEKa9dDs30SaZObk+opKOJgUMwSWhESqBiX7cSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oq2gtVkz79KLRViHPhnmSU72HCRuXaLZlrcrD3U6Ot6HvYr8Cjivot1wZFR/0T4QWHAImI9xC+h6QgLLZfUs4n+YQm1ihWr+0g2vHlElBgH2Ovw90CAAumfCJyJoaM6chsU8Cez13PFKywqVkbB9RQ/NOm0YL8hdzdaeMCVhFNIxf6SyhyP6UEVdPU5LxPPlIQZD2Li3umB2WHJpJGzRwBLFHc7WYxXP7yZr5YT4PsU0vJCMFb4zRCn1MapCt8JbnTh1rqfsom+HWdLnBF9sSXOGaDOLIfmUxO9HnoQqnKwLJbqoN2MOaiM3IXEvOWsXhdAHflFqJ9kVKr2sLPalqlQ475thaN4ILH7UOUZ9qdYHXNzMOfUACq2QXHKkj+GadctzT4AbX3tdnxOYSI3y5FpxCmKjgnKY7bGcfGFHYBt7dSmmsUqM8rx16aKCktXQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:10:38.1591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7e76cc-c27d-4d01-aa73-08dee17f63ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
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
using queue pointer equality rather than queue_id values, avoiding
internal routing through reusable userspace handles.

Pending WAIT_EVENT records hold queue references while queued. Those
references are released when records are consumed, explicitly removed,
or destroyed during manager teardown.

Embed the WAIT_EVENT manager in amdgpu_fpriv and tie its lifetime to
drm_file. Initialize the manager during file open and destroy it during
file close so that pending records are cleaned up and blocked waiters
are released before file-private state is freed.

Changes since v8:
- Squashed "Register WAIT_EVENT ioctl" into "Add wait-event manager and
  per-file lifetime plumbing", as suggested by Alex.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 286 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  74 +++++
 6 files changed, 370 insertions(+), 3 deletions(-)
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

