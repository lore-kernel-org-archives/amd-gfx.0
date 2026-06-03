Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56750CD6E60
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB4B1120D7;
	Wed,  3 Jun 2026 16:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2eqR7wat";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A516B1120D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkT1f5SIUPVVKymt5EF348dvcU+UhRknJ/BUJ0PMc+6Bu7itfhCsZjC2ghU/VOGotfpxmvLBknKAtbOe1SqupO9FX/ChK6IQ90PzMbS0YixZnJuUZeCVFvfbderKKYKOxyJ4ZXgPsn1hjxqOwU6BmKWrmrh3d4ElsoCverztiG8hlMqVcYkuriVu7Y9yeJbT9xaGhjclo5wVkEVsomzIkH8M1NnEgqC4CsP5f8XeLWCh1/+9tJrQKnxmFhBknBq6dP/6RnUi/vebcCUtxnL5+XrnCsmD4ijxxnpuwocte7qMX+JXgq94ikkY59uFpqjXKa3i2Ldk3XK7zRx8zGiQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPByEOiPL9G70MCBSAWN0D5QaObj0GIK6r4gHkGCkwA=;
 b=P+nsgUruH5Jl5LcVLtRNWkshoBNF1l+XS/p0LkJb17Q365uOAGJJDqa5mjJgWd4+L4WDT8b5WC/O0G8poACvNl4ExyJVYtEB8yXy8b1jpezPNwV/GF6BuOxFEi+h9nRHY0z3D5c6Em6Kd8VcMNRj5pBXdbR0X81yaD41Kh7ts6iGrV4RfB0jjI2ZhsRE3/Ek4ybg9ikGu3ebR/VOBC4NxRCIb1IlEoz3I7tnANz2EWWnc7nxq9pO4DceFkg9mGOOaDtZzVow48uHlE+5X5Ynzi5As31yCRAJSylNISYC2K2sYF7cgASKo3aAV/p2OkHNQpO+2i7YBfRMNRN9Pv9v/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPByEOiPL9G70MCBSAWN0D5QaObj0GIK6r4gHkGCkwA=;
 b=2eqR7wat7Wy1oJc+VCvDxsAGcy+LloicRjGrgNNe9vMDTwm1SfM9PKRAtJ9H9ZItFUetJ8rZDKWOydkQAPxjCwNuRKrKBlJig9B/ZyLuimfoCENF4VOhX/Kv6OjbtKfHlWGEUyXwo9MUspEuOEsSETIYXyUJIh1DZMLEiRb2M9I=
Received: from BLAPR03CA0077.namprd03.prod.outlook.com (2603:10b6:208:329::22)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 16:35:12 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:329:cafe::1d) by BLAPR03CA0077.outlook.office365.com
 (2603:10b6:208:329::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:35:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:35:08 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 02/11] drm/amdgpu: Add wait-event manager and per-file
 lifetime plumbing
Date: Wed, 3 Jun 2026 22:04:41 +0530
Message-ID: <20260603163450.2678374-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
References: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 7985f1a9-a8ac-4d3d-54ad-08dec18e1547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|6133799003|3023799007|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: m8Rw59FKBay4mt4zUzxP/PWIE3S4KQ8JvtPqJTJCVOn4Dl5YtvwugOnM+nZlQ+dl+bqJpaP3NorE2l/l56LzuaVn2Le0y4Kg/OIb2BsIrQLj2+p5iQY54wkUHizVA6UQ3bTQ+o++Sd04iA/GeOPkLR4WM8xfZfPtV/fPccjNS2U45nQMfE1yY3q78nQQ5oaI/ntkydUs01wEj04ERWlylaCyEsOlSx5nmMIWQMc20wcOlPGtVVEa0QuXxhrWXKl1fnzLFEGpABzPQELtjb5UZTHOljMw6pVKNr2qgZMlnUrwcX0QPr1p3jB5jnaUtK+MWymUXJot9Mn7pnhCC89cDJIxhK+dShzQDRj2r0FmekXbtfHVQfADr5pIkVkF2teX3uQZbsfyuZtYbTUUZpeOLFK6Ciglk788qkU2+emoivfVJi10Bld5Uus/uCFvFbQRDyFKWewbqdmtIBTdtw9mukjH6axvuHOkpgfoc8w7i77aR1wafR8QsH/m9lXtMklhFujpfLdAgegl33VEvcVAuhMQpo/JnwVvuRN7HQlzHVo+VWVvL14Tksy+N/YSBAElGnUT3/Cg6H+gY5lv/nMoU8CRegyjkEMZmx2KQqy0NWpjHsrtU6Ri/rH3sDTmpBvMnmg1QwixVnZRfE0k/6U0Sa+Xt6+WRQlRqSB3h9jdF9fTOCUVRz6l6JNdhDJINmSWgBf3nA7nOyHNFJ/bONrYtq+NAqzjzoPlBCdkGh9Ma+I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(6133799003)(3023799007)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: osb9LHZsbUu3J5GgPRtvu8Q3kx/ZiTa7MUSoroVJp+HN05lzo62NARsL3PIQx9bBQ/iqkipx3Gij16xSRNl5rqSCTlB6qg1oRIKYdnD7Qm5d+ZHl/C79MnkWJ41WW/pcjG+G0SmxM4hizuJw9V9/+j7Kz8lAgawZhRg7ni0laX+nizt0iSUEs2e14xMfo363aLFL8dLr51uBiorflMn5h0ORHI6gxL/FpDhtnxsl9zOws9m5KTwJNyF16H315Qe/3Bk0RgyIiUI0ZTUk/cxbQwV7vo8zRiusyChupr/OO2FY/ajGZKdLA6cH20jmV3KPsvFbCOjyXKe5pX2qwLJq7lFlHHFI1+e3IvXAuEQi0kNLXYJtgWi3FBKCJEPrTfpAMM/a4QmvhL44IRsPmoAhSy9VLnmYiP2eK9DDn9w+L9DF7nbnAJheieIAKPg+xSB7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:35:11.9351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7985f1a9-a8ac-4d3d-54ad-08dec18e1547
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 288 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  85 ++++++
 5 files changed, 381 insertions(+), 2 deletions(-)
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
index 22dfd22210c4..b768d4be7cc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1500,6 +1500,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	}
 
 	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+	amdgpu_wait_event_mgr_init(&fpriv->wait_event_mgr);
 
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
@@ -1599,6 +1600,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	/* Drop all subscriptions before fpriv goes away. */
 	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
+	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
 
 	pm_runtime_get_sync(dev->dev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
new file mode 100644
index 000000000000..c055b201c428
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -0,0 +1,288 @@
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
+void amdgpu_wait_event_push_gpu_reset(struct amdgpu_wait_event_mgr *mgr,
+				      u32 reset_cause)
+{
+	struct drm_amdgpu_wait_event_data data = {};
+
+	data.event_type = DRM_AMDGPU_EVENT_TYPE_GPU_RESET;
+	data.queue_id = 0;
+
+	data.u.reset.queue_id = 0;
+	data.u.reset.reset_cause = reset_cause;
+	data.u.reset.data0 = 0;
+	data.u.reset.data1 = 0;
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
index 000000000000..67de685647c7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -0,0 +1,84 @@
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
+void amdgpu_wait_event_push_gpu_reset(struct amdgpu_wait_event_mgr *mgr,
+				      u32 reset_cause);
+
+static inline bool amdgpu_wait_event_type_is_queue_scoped(u32 event_type)
+{
+	switch (event_type) {
+	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
+	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
+	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
+		return true;
+	case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
+	case DRM_AMDGPU_EVENT_TYPE_GPU_RESET:
+		return false;
+	default:
+		return false;
+	}
+}
+
+#endif /* __AMDGPU_WAIT_EVENT_H__ */
-- 
2.34.1

