Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2BBF34C60
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 14:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D7510E4AE;
	Mon, 13 Apr 2026 14:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y2hOfB4N";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0A710E4AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 14:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXyizjstaMW6aLnTykMfV1QsFCrNAKqC/QT2RSSut6PCbbNwQ4WCAEPLMwmDVp5HYzpD0oCkoYpHS10xJrLSJeIWhSU130KxUVIHeDoBKxAw6sKLjD3COlSzJ8rxGkT1POU6PDZ0WxrXZ10j/C/GXMIDMmQLjdd6Rh63aPwZXdQ9ePD9rAqLAaARwg+RwZKyTvrzqy6UCsBYsaIvDhOQjEzhdSN5jriTACeEh94WqIIsOaE0pWXvdS/MFhCbCzmBH0wEn0lIoT28tTVdStV22VczhR5KHUfc6oGqZ095tSiaILVLRMO9wKC53wM9iZbQwwT46mpBVvesIJ6ET4jz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D57l+DArU5uYio0HpCPIxwoLwSthiZA/J7wZiYAL98U=;
 b=qJVoW24Zvg71shJmRgSBfx4GBOdI8e1jKbOZOahydHGM8QZ8ghFwOdhti0Tm4tqFQEaRR9cR/CW2xovgVNDdk1qizvQNmd7QDatxbCU/EqIZ7EisjAB1xLjjwKeOVsOGDDegbhLamwQKdLS4BPIL/IkPUlIFnO5gC0XXd8BzAMy+Yx9m5o9QG41F4h0c3hCU9s3dyw7NF1IlTy8MwQ8eQYgN6yUmGoyrjgSGKSqx7dxv3xgcdBnwZZPh8vP8JFC1PML/VM1O7lCsDDDqcNypzr+uADYVwHnCT8LF3r7v1pavmjr52bLPoFo6nCBQMJl27YUy8/Exo6tTbukE0vrEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D57l+DArU5uYio0HpCPIxwoLwSthiZA/J7wZiYAL98U=;
 b=y2hOfB4NVays3EwDe1UuBifIXQ8ifP5tYkzE61FNIFj3kYICBL7gXSYEYVQdqJ5qifrkv4yn93+LopPpXGMoSWrQp2aWHxTFYDlX9mwtmTqdKNpF/M/9Kj6mpkrWSkBEJEHSAmJxZQjFdoj6dnlsd631nHRXusN6TogFhBX8zLw=
Received: from CH3P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::12)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.35; Mon, 13 Apr 2026 14:58:18 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::4) by CH3P220CA0013.outlook.office365.com
 (2603:10b6:610:1e8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 14:58:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Apr 2026 09:58:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 2/4] drm/amdgpu: Add wait-event manager and per-file
 lifetime plumbing
Date: Mon, 13 Apr 2026 20:27:43 +0530
Message-ID: <20260413145745.2326236-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413145745.2326236-1-srinivasan.shanmugam@amd.com>
References: <20260413145745.2326236-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 92399632-9bdb-418c-2454-08de996d18e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: KuTlC+G6SbcrlshgoByh5t5hD7QJ9berY9dosVaXNv4S9b0DptRCln/F62cZMK8UOnzGfYGtttWAQwpw2gIi76il6FdZFl0s4GFbMilG6KpcTHjAxZjPTl5+fx3ZvwaCEvSnjk6p000I1OSIKaZQ5/TELTHsZ5S0i1JHzJOjIr+yKuWckys/6skMaHjL5atSQ/HAp1NHROU4H/5Bcj/yalqyyAj7FKlOZZstnAXH/2i+OZLiQXjDCk8uinq9uBKzca7rxZKeJOQsSIgfE79jG9a5lEt/nZldwgspxSGCYyNtSSQZs3gJ/6f/iIC6F91SO8U8nWSsaFgVXHSD9D6YNXRpi614gJtOXzmXAmxhX4UTKfa+lTzVySRZi8Jwnl/0zoripuyhdT0prXRNUooPkNvhbJ/HMbvHZ/aoLrVpGgKIf1rWR44VI1bQ8lmcTUJwyjMPIG9keb6X7CV3hd0g9M/nqBySZMYla2o+JdydXpr5Ljb9pzilw4fGeLzAMq3bCd7YeGFzIZ/CuVmF11qKHczKushHidgcGWI3fYosRlfCtrQOQt1IQZDBIUAorE9cyZpHh2oFtx5jUWBVd+PddTpvHycehgyNJxoDzexp7zU8iH7sWDPa1AjnAaAXm18cTm9IAJdhfyVwzUswJe8W0Al45PpFVBORVKReYz0+oy4IJdGqDrC69q3Bux8I8gw+yWlgxVAe6gS0OKqDraBtnOuRZU/gLx+beBGojjG3OKsPlqLCFDzR1YcsmYqxp8P/xGMCaDAhma3xledkswE97A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1nu3YrliQlm2hcD5kVVzZ/Sah3iTldqQpLijhXIx2mgeqmMtdkkpgt+dlLmh+ldXArm58CAmbyFlE6Vj39MAIe0+0McIsBsK6RdLE78Ua1tbuxa6PoOABSKxO7jrGR3Xwl6W0fud9FybFEDYQGtShMzrUrAlrUoK1idQtildzZmELN1x0HQ3m6OSwiR1KCYJvvHu9x5ReST4eYxBkqfTzbDEH1V1QAlYV99BLDQXNQxAH7AWgi1mq/wRPheJft5ELlX1brrdtFkvMip9cHfQ/oINADa1Qy1iFsNc8Xu6Yz34RNb7r1WxJ8wzaNu3VOSuEmE2jIE1p4weK3i3uAAIzKAtfmfnD4cpxKQ7YN4KqI84bYWU2Iu0jp5EDux2keL2qaMt9Ffkjcr6OJw7gubc+tKQ1WSfckNDkz2ZJMEnOC85zWY0Mgiako1ax/RNvkNK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:58:18.0977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92399632-9bdb-418c-2454-08de996d18e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
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

Add a per-drm_file wait-event manager for render-node events.

The manager stores pending event records, supports blocking waits,
copies the first matching record to userspace, and enforces
single-consumer semantics by removing the record when a waiter
consumes it.

Embed the manager in amdgpu_fpriv and tie its lifetime to drm_file.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 250 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  60 +++++
 5 files changed, 318 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index feea63b332fa..c883e1840180 100644
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
index 42b8448c7e82..865c48da1524 100644
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
@@ -457,13 +458,15 @@ struct amdgpu_fpriv {
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
index 5e2abf32420f..e99059a4663e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1509,6 +1509,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	}
 
 	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+	amdgpu_wait_event_mgr_init(&fpriv->wait_event_mgr);
 
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
@@ -1608,6 +1609,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	/* Drop all subscriptions before fpriv goes away. */
 	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
+	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
 
 	pm_runtime_get_sync(dev->dev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
new file mode 100644
index 000000000000..a87c75f0ca48
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: MIT
+#include <linux/jiffies.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include "amdgpu.h"
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
+static bool amdgpu_wait_event_match(const struct drm_amdgpu_wait_event *args,
+				    const struct amdgpu_wait_event_record *rec)
+{
+	if (rec->data.event_type != args->event_type)
+		return false;
+
+	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type))
+		return rec->data.queue_id == args->queue_id;
+
+	return args->queue_id == 0;
+}
+
+static bool amdgpu_wait_event_has_match(struct amdgpu_wait_event_mgr *mgr,
+					const struct drm_amdgpu_wait_event *args)
+{
+	struct amdgpu_wait_event_record *rec;
+	bool found = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	list_for_each_entry(rec, &mgr->pending, node) {
+		if (amdgpu_wait_event_match(args, rec)) {
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
+			    const struct drm_amdgpu_wait_event *args)
+{
+	struct amdgpu_wait_event_record *rec, *tmp, *found = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	list_for_each_entry_safe(rec, tmp, &mgr->pending, node) {
+		if (amdgpu_wait_event_match(args, rec)) {
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
+static int amdgpu_wait_event_push_common(struct amdgpu_wait_event_mgr *mgr,
+					 struct drm_amdgpu_wait_event_data *data)
+{
+	struct amdgpu_wait_event_record *rec;
+	unsigned long flags;
+
+	rec = kzalloc(sizeof(*rec), GFP_ATOMIC);
+	if (!rec)
+		return -ENOMEM;
+
+	rec->data = *data;
+	rec->data.seqno = atomic64_inc_return(&mgr->seqno);
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	list_add_tail(&rec->node, &mgr->pending);
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	wake_up_interruptible_all(&mgr->wq);
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
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	mgr->dead = true;
+	list_for_each_entry_safe(rec, tmp, &mgr->pending, node) {
+		list_del(&rec->node);
+		kfree(rec);
+	}
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	wake_up_interruptible_all(&mgr->wq);
+}
+
+void amdgpu_wait_event_push_userq_eop(struct amdgpu_wait_event_mgr *mgr,
+				      u32 queue_id, u32 status,
+				      u64 data0, u64 data1)
+{
+	struct drm_amdgpu_wait_event_data data = {};
+
+	data.event_type = DRM_AMDGPU_EVENT_TYPE_USERQ_EOP;
+	data.queue_id = queue_id;
+	data.u.queue.queue_id = queue_id;
+	data.u.queue.status = status;
+	data.u.queue.data0 = data0;
+	data.u.queue.data1 = data1;
+
+	amdgpu_wait_event_push_common(mgr, &data);
+}
+
+void amdgpu_wait_event_push_queue_reset(struct amdgpu_wait_event_mgr *mgr,
+					u32 queue_id, u32 reset_cause,
+					u64 data0, u64 data1)
+{
+	struct drm_amdgpu_wait_event_data data = {};
+
+	data.event_type = DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET;
+	data.queue_id = queue_id;
+	data.u.reset.queue_id = queue_id;
+	data.u.reset.reset_cause = reset_cause;
+	data.u.reset.data0 = data0;
+	data.u.reset.data1 = data1;
+
+	amdgpu_wait_event_push_common(mgr, &data);
+}
+
+void amdgpu_wait_event_push_memory_exception(struct amdgpu_wait_event_mgr *mgr,
+					     u32 queue_id, u32 fault_status,
+					     u64 va, u64 data0)
+{
+	struct drm_amdgpu_wait_event_data data = {};
+
+	data.event_type = DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION;
+	data.queue_id = queue_id;
+	data.u.memory.queue_id = queue_id;
+	data.u.memory.fault_status = fault_status;
+	data.u.memory.va = va;
+	data.u.memory.data0 = data0;
+
+	amdgpu_wait_event_push_common(mgr, &data);
+}
+
+void amdgpu_wait_event_push_scratch(struct amdgpu_wait_event_mgr *mgr,
+				    u32 queue_id, u32 error_code,
+				    u64 requested_bytes,
+				    u64 available_bytes)
+{
+	struct drm_amdgpu_wait_event_data data = {};
+
+	data.event_type = DRM_AMDGPU_EVENT_TYPE_SCRATCH;
+	data.queue_id = queue_id;
+	data.u.scratch.queue_id = queue_id;
+	data.u.scratch.error_code = error_code;
+	data.u.scratch.requested_bytes = requested_bytes;
+	data.u.scratch.available_bytes = available_bytes;
+
+	amdgpu_wait_event_push_common(mgr, &data);
+}
+
+int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_amdgpu_wait_event *args = data;
+	struct amdgpu_wait_event_mgr *mgr;
+	struct amdgpu_wait_event_record *rec;
+	long timeout;
+	int ret = 0;
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
+	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type)) {
+		if (!args->queue_id)
+			return -EINVAL;
+	} else {
+		if (args->queue_id)
+			return -EINVAL;
+	}
+
+	mgr = &fpriv->wait_event_mgr;
+	timeout = amdgpu_wait_event_to_jiffies(args->timeout_ns);
+
+	for (;;) {
+		rec = amdgpu_wait_event_pop_match(mgr, args);
+		if (rec)
+			break;
+
+		if (READ_ONCE(mgr->dead))
+			return -EIO;
+
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+
+		if (!timeout)
+			return -ETIME;
+
+		timeout = wait_event_interruptible_timeout(
+			mgr->wq,
+			READ_ONCE(mgr->dead) ||
+			amdgpu_wait_event_has_match(mgr, args),
+			timeout);
+		if (timeout < 0)
+			return timeout;
+	}
+
+	if (copy_to_user(u64_to_user_ptr(args->out_ptr), &rec->data,
+			 sizeof(rec->data)))
+		ret = -EFAULT;
+
+	kfree(rec);
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
new file mode 100644
index 000000000000..ea1e780c3029
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: MIT */
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
+struct amdgpu_wait_event_record {
+	struct list_head node;
+	struct drm_amdgpu_wait_event_data data;
+};
+
+struct amdgpu_wait_event_mgr {
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
+int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv);
+
+void amdgpu_wait_event_push_userq_eop(struct amdgpu_wait_event_mgr *mgr,
+				      u32 queue_id, u32 status,
+				      u64 data0, u64 data1);
+void amdgpu_wait_event_push_queue_reset(struct amdgpu_wait_event_mgr *mgr,
+					u32 queue_id, u32 reset_cause,
+					u64 data0, u64 data1);
+void amdgpu_wait_event_push_memory_exception(struct amdgpu_wait_event_mgr *mgr,
+					     u32 queue_id, u32 fault_status,
+					     u64 va, u64 data0);
+void amdgpu_wait_event_push_scratch(struct amdgpu_wait_event_mgr *mgr,
+				    u32 queue_id, u32 error_code,
+				    u64 requested_bytes,
+				    u64 available_bytes);
+
+static inline bool amdgpu_wait_event_type_is_queue_scoped(u32 event_type)
+{
+	switch (event_type) {
+	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
+	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
+	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
+		return true;
+	case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
+		return false;
+	default:
+		return false;
+	}
+}
+
+#endif /* __AMDGPU_WAIT_EVENT_H__ */
-- 
2.34.1

