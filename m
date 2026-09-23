Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F7EC98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3017C10E969;
	Wed, 23 Sep 2026 19:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xAHIEf4E";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0527810E961
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MscCI5fvQmRDsN+B5MjiIti9PUMP5HiqljdSz0OHOraLdc8HfaVw2dzuc1FhiViZbki0MECtFcmgFs2VSvO61Wf/h7WdGuIPKUsA7juaph0t2yP27BBkGmeD1J0XKqfEwwCq7bDriIN34PEqjOHM3JVTCkVh6i2BkZilHtFC6xnjfnCOrY3Zy7JkOj2xk3VJUKW9fmqJrrF7B5mUloHG6ITzaP/J02FYqDsl7QWzfR5CoTIbD+GwhQvl5KUGW8mzU2ksrzPcrGpQ2POgUmhMtldN5VnreJIEZe+MF6gli84aSGTgLRfutdwpICfxbz+Z4xpNPzyMx5I+KIk8AjC5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMn0tVLJgrtCSC1ngBATlkQk3J00xAJ7JehWUD8iGcU=;
 b=VkYzck5naG0sbWG5QdolP9J029xrkRyTc6GbBxFabzCgYvU7J8hnOcMbrhy29gcMDPlxdTHuoMHE/CacQJR83yG1UhdKJkRIKU9L8W/hyksi4W/M6O6tWBPQzQFyHbO/zAg2TGXZtJmLfwebP6rYjm1UuLPWoOAIKJSI+yscaBwXpUVJca9svUJE5ebWnsLKR0f+FdsHhdpCwHf3NbjE8b4IgtJrCVIpb7QFLceZWpRxKQVtquCy3qkg5NEZ+qYNCb5TEeeIp5OwNBzSkuG1G0qRDiGuDqswPN5Dsh2AhOqBhc+mhEE8KZgKFWEKccQ9B5UQygkzroXh4yz2HXozGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMn0tVLJgrtCSC1ngBATlkQk3J00xAJ7JehWUD8iGcU=;
 b=xAHIEf4EmhGGG5WTH4JVEaAmhOibc577XXcfkLZ/rbulumtr7GFBAxFqLoNTWIKdGtFsEd/8/YmeI/hnl7ncQJIsC+Uqp3JhN2FzgXAG+z6KRnHfwvpehO7V4thtxETodV405PNjs7z9bIXrAOncsh7HRLz63dc6sgo6OwqI7hI=
Received: from MW4PR03CA0072.namprd03.prod.outlook.com (2603:10b6:303:b6::17)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Wed, 23 Sep
 2026 19:19:15 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::9c) by MW4PR03CA0072.outlook.office365.com
 (2603:10b6:303:b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 19:19:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:19:14 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 14:19:12 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add mes_dbgext core support
Date: Wed, 23 Sep 2026 15:18:59 -0400
Message-ID: <20260923191859.976556-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc41353-b19b-46bb-bb7a-08df19a78e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|5023799004|11063799006|3023799007|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: wTHv/VKLNFDfWF3tDA/a9yrp/0Lv+z8tXS3rPmoxDKxhJZEtmKUm94dPhzQQwF94EXM7wis9h9pdsqhsazYIhqWksywSxqPvR9YHSyXT5KMyyki7VHQYQDdiQhikZrJgnwVIxT2UMBtiAko5YFf8cFuBIXEn+3RpcHB0mg+ssPpl3IHtJW23kp/aa2U4nMd+rOtDRoDcOqE77OOTjA5NlT2SC6M6XhAAiTWmzi6q2hS+y1IQENgkjTl5IsSfcQZnsMUH291Vr9DEQeoegcqIDYVu21AtM8DTX7QG4qgQ5ry5UrOhWiVjuB5dYVaNw+4nC/SJUxNsGSFbz+v4VWIHIsd2WWrAvUVj4iV+l5RNoU3yz+1Q7M3oXSth7alFRhbPUjdAmgMncn9KhXDl4C6O51Wm5EGHianrfsgk0oE8i8zc5eUJeeF+i13xjWR/5ZblP8sCZr+4dvz7M9Y5dNBs9TO7c4bXRcIKTHfXHCbxpsw8TkR5MJ0ArCJmXfvKRaXrpghdHPWr3lKUyM5OBsuy9fYrlmYcI3FowM+N/Ptg2k28tocf6OEM6hyVCmQ9cLYDZMoNz1MfCQmcKBU/BVUUGMuctEmDiIS45VB7wM2Hs3xKDwRg4lw+MG7Zz/ZL/hlooWBoXbF75rzIqi5GweYc0D0As3UFs3KT/lWvhw0yWpiA3vk8WOdAU4sHbHF0VNiC5mcSt9LT9UP1ZXcPaK63eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(5023799004)(11063799006)(3023799007)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PO29Bz0yQGh4gcgY11w3eZ+i7P29HiqKcXkVrB+sOE908YBD88oJq6qdF//KwsOjgQbrSToCzKQtbKk2XS+1carY6a0BPBKPoy4pYz46/jopEZsG2WUU8+tJQPiJXTOUMcLI1ZEuP0b9YpVPP6zoyHisMiSjP+geHVBDgMXVx4p3vBmfa//kRpybrXqEtRC2Mra6T/WMZ4Wn+oKcdFb6BGCp5ebGvpYwa9c0iX08lF9IqRe0i9gutIaTJJ+CTayf3ZSThlmCV/gxihRpOYkcTgLMaO7ZNC5D6yN8q1dJ1zygWnJMu9sab+0nG6VhmlrHM9XEQzed/udwYsv1G7hx90tPGaPkoQ9gAqF8//dzDlXnocRzQ+SLm4se+aZO+vmsETpSK/ZUyyV1EwbsesUctg2nUy+/jVgF1yJjDgc9YMAWSbBGMGr7voU+DsHCYgm3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:19:14.5844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc41353-b19b-46bb-bb7a-08df19a78e47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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

Add the core MES debug-extension logging layer in amdgpu_mes: allocate
and initialize the firmware log buffer, and print messages to dmesg
via interrupt or polling collection modes, with start/stop/notify
and an amdgpu_mes_dbgext debugfs control.

Expose the mes_dbgext_buffer_size and mes_dbgext_options module
parameters to configure the buffer size and collection mode, and wire
the debugfs init (amdgpu_debugfs_mes_init).

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c     | 745 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |  59 +-
 6 files changed, 833 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6c1c775256fd..ce671731b700 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -217,6 +217,8 @@ extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
 extern int amdgpu_mes_log_enable;
+extern int amdgpu_mes_dbgext_buffer_size;
+extern int amdgpu_mes_dbgext_options;
 extern int amdgpu_uni_mes;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1b7673d239db..b2ca45fb24d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2178,7 +2178,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	amdgpu_debugfs_firmware_init(adev);
 	amdgpu_ta_if_debugfs_init(adev);
 
-	amdgpu_debugfs_mes_event_log_init(adev);
+	amdgpu_debugfs_mes_init(adev);
 
 #if defined(CONFIG_DRM_AMD_DC)
 	if (adev->dc_enabled)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index e88b4a1e564c..3f01e7537add 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -33,7 +33,7 @@ void amdgpu_debugfs_fini(struct amdgpu_device *adev);
 void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
-void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev);
+void amdgpu_debugfs_mes_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_vm_init(struct drm_file *file);
 void amdgpu_debugfs_userq_init(struct drm_file *file,
 			       struct amdgpu_usermode_queue *queue,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9c5e93cd3ee6..df8d529e5646 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -227,7 +227,9 @@ uint amdgpu_dc_visual_confirm;
 int amdgpu_async_gfx_ring = 1;
 int amdgpu_mcbp = -1;
 int amdgpu_discovery = -1;
-int amdgpu_mes_log_enable = 0;
+int amdgpu_mes_log_enable;
+int amdgpu_mes_dbgext_buffer_size;
+int amdgpu_mes_dbgext_options = 1;
 int amdgpu_uni_mes = 1;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
@@ -700,6 +702,33 @@ MODULE_PARM_DESC(mes_log_enable,
 	"Enable Micro Engine Scheduler log (0 = disabled (default), 1 = enabled)");
 module_param_named(mes_log_enable, amdgpu_mes_log_enable, int, 0444);
 
+/**
+ * DOC: mes_dbgext_buffer_size (int)
+ * Size in KB of the MES firmware debug-extension log buffer. The MES firmware
+ * writes log messages into this buffer and the driver drains and prints them to
+ * dmesg. Requires an MES firmware image built with debug extension support.
+ * (0 = disabled at boot (default))
+ *
+ * The feature can also be toggled at runtime via the per-device debugfs file
+ * <debugfs>/dri/N/amdgpu_mes_dbgext (echo 1/0 to enable/disable); when enabled
+ * at runtime with this parameter left at 0, a small default buffer is used.
+ */
+MODULE_PARM_DESC(mes_dbgext_buffer_size,
+	"MES firmware debug-extension log buffer size in KB (0 = disabled (default))");
+module_param_named(mes_dbgext_buffer_size, amdgpu_mes_dbgext_buffer_size, int, 0444);
+
+/**
+ * DOC: mes_dbgext_options (int)
+ * MES firmware debug-extension option bits sent to the firmware (u64_all).
+ * bit0 = trigger_interrupt_per_new_msg: when set, the firmware raises an
+ * interrupt per message and the driver collects them via the interrupt path;
+ * when clear, the driver polls the log buffer with a kthread instead.
+ * (default 1 = interrupt driven)
+ */
+MODULE_PARM_DESC(mes_dbgext_options,
+	"MES debug-extension option bits (bit0: 1 = interrupt (default), 0 = polling)");
+module_param_named(mes_dbgext_options, amdgpu_mes_dbgext_options, int, 0444);
+
 /**
  * DOC: uni_mes (int)
  * Enable Unified Micro Engine Scheduler. This is a new engine pipe for unified scheduler.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 4cb37cdbf821..97b12105e564 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -22,6 +22,11 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <drm/drm_exec.h>
 
 #include "amdgpu_mes.h"
@@ -120,6 +125,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	ida_init(&adev->mes.doorbell_ida);
 	spin_lock_init(&adev->mes.queue_id_lock);
 	mutex_init(&adev->mes.mutex_hidden);
+	mutex_init(&adev->mes.dbgext_lock);
 
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++)
 		spin_lock_init(&adev->mes.ring_lock[i]);
@@ -320,7 +326,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 
 	ida_destroy(&adev->mes.doorbell_ida);
 	mutex_destroy(&adev->mes.mutex_hidden);
-
+	mutex_destroy(&adev->mes.dbgext_lock);
 }
 
 int amdgpu_mes_suspend(struct amdgpu_device *adev, u32 xcc_id)
@@ -1239,6 +1245,658 @@ void amdgpu_mes_userq_queue_unmapped(struct amdgpu_device *adev)
 		cancel_delayed_work(&adev->mes.userq_notify_unmap_work);
 }
 
+/*
+ * MES firmware debug extension ("mes_dbgext")
+ *
+ * The driver hands the MES a log buffer; the MES firmware writes text log items
+ * into it and the driver drains and prints them.  The buffer is a single
+ * circular byte stream with a 16-byte header at offset 0:
+ *
+ *   dword0 : rptr        - driver reads/advances (with wrap)
+ *   dword1 : wptr        - firmware writes/advances (with wrap)
+ *   dword2 : buffer_size - total buffer size in bytes (set by the driver)
+ *   dword3 : header_size - size of this header / wrap-back offset (16)
+ *
+ * Item data starts at header_size and wraps from buffer_size back to
+ * header_size.  Each log item begins with a 4-byte header (type, xor-signature,
+ * 16-bit length including the header) followed by NUL-free text.
+ *
+ * The driver owns rptr; the firmware owns wptr.  The collection method is
+ * selectable via the mes_dbgext_options bit0: interrupt-driven (default - the
+ * FW raises its host interrupt per message, handled via the CP EOP path) or a
+ * polling kthread.  Polling is also used automatically as a fallback when the
+ * ASIC has no IRQ-enable hook.
+ *
+ * NOTE: this requires an MES firmware image built with debug-extension support.
+ */
+
+#define MES_DBGEXT_MAX_ITEM_SIZE	2048
+#define MES_DBGEXT_POLL_INTERVAL_MS	200
+/* Default log-buffer size (KB) used when enabled at runtime with no size set. */
+#define MES_DBGEXT_DEFAULT_KB		8
+
+/* Log item text record types (must match mes_aux LOG__* in mes_dbgext.cpp). */
+#define MES_DBGEXT_MSG			0x80
+#define MES_DBGEXT_MSG_ASSERT		0x81
+#define MES_DBGEXT_MSG_HALT		0x82
+
+/*
+ * Log buffer option bits, must match the MES firmware's MES_DBGEXT_INIT_DATA.
+ * bit0 = trigger_interrupt_per_new_msg: when SET, the firmware raises the
+ * debug-message host interrupt after each message
+ * (mes_dbgext.cpp: "if (trigger_interrupt_per_new_msg) SendIntToHost()").
+ * When CLEAR, the firmware only writes the buffer and the driver must poll.
+ */
+#define MES_DBGEXT_OPT_TRIGGER_INT_PER_MSG	(1ULL << 0)
+
+/*
+ * MES firmware routes mes_dbgext through the shared "mes_aux" component, which
+ * uses a zone-partitioned buffer layout:
+ *
+ *   offset 0: struct { u32 zone_count; struct {u32 offset, length}[zone_count]; }
+ *
+ * Each zone starts (at its byte offset from the buffer base) with a 16-byte
+ * LOG_ZONE_HEADER {rptr, wptr, buffer_size, header_size} whose rptr/wptr are
+ * relative to the zone start and wrap from buffer_size back to header_size.
+ * Every log item begins with an 8-byte header: type, xor-signature, a 24-bit
+ * big-endian length (total item size including the header, in bytes[2..4]),
+ * then level, seq and a reserved byte.  Zone 0 carries human-readable text
+ * (printed to dmesg); other zones carry binary event/interrupt/api records
+ * (types 0x93..0x95) that are not text and are skipped.
+ *
+ * The driver seeds only the total buffer size in the first dword; the firmware
+ * (mes_aux InitializeLogBuffer) reads it and writes the zone header in place.
+ */
+#define MES_DBGEXT_ITEM_HDR_SIZE	8
+#define MES_DBGEXT_MAX_ZONES		8
+
+/*
+ * mes_aux option word (struct MesExtConfig) layout, which differs from the
+ * gfx11 MES_DBGEXT_INIT_DATA: bit0 is host_poll_msg (INVERTED sense - when set,
+ * the firmware does not raise the per-message interrupt), bit1 enables logging,
+ * and bit3 enables an internal write-back cache (left off for prompt delivery).
+ */
+#define MES_DBGEXT_AUX_OPT_HOST_POLL		(1ULL << 0)
+#define MES_DBGEXT_AUX_OPT_ENABLE_MES_LOG	(1ULL << 1)
+#define MES_DBGEXT_AUX_OPT_ENABLE_LOG_CACHE	(1ULL << 3)
+
+struct mes_dbgext_zone_info {
+	u32 offset;
+	u32 length;
+};
+
+struct mes_dbgext_zone_header {
+	u32 rptr;
+	u32 wptr;
+	u32 buffer_size;
+	u32 header_size;
+};
+
+/*
+ * Copy @n bytes out of the circular data region starting at byte offset @off,
+ * wrapping back to @hdr_size when @buffer_size is reached.
+ */
+static void mes_dbgext_buf_read(const u8 *buf, u32 buffer_size, u32 hdr_size,
+				u32 off, u8 *dst, u32 n)
+{
+	while (n--) {
+		*dst++ = buf[off++];
+		if (off >= buffer_size)
+			off = hdr_size;
+	}
+}
+
+static void mes_dbgext_print_item(struct amdgpu_device *adev, int xcc,
+				  u32 type, char *text)
+{
+	size_t n = strlen(text);
+	char pfx[12] = "";
+
+	/* Normalize to exactly one trailing newline: the gfx11 firmware appends
+	 * one to the text, the gfx12/mes_aux firmware does not.
+	 */
+	while (n && (text[n - 1] == '\n' || text[n - 1] == '\r'))
+		text[--n] = '\0';
+
+	/* Tag with the source XCC only when more than one is being logged, so
+	 * single-XCC (gfx11/gfx12) output is unchanged.
+	 */
+	if (adev->mes.dbgext_num_xcc > 1)
+		snprintf(pfx, sizeof(pfx), " xcc%d", xcc);
+
+	switch (type) {
+	case MES_DBGEXT_MSG_ASSERT:
+		dev_err(adev->dev, "[mes_dbgext%s] ASSERT %s\n", pfx, text);
+		break;
+	case MES_DBGEXT_MSG:
+		dev_info(adev->dev, "[mes_dbgext%s] %s\n", pfx, text);
+		break;
+	default:
+		dev_warn(adev->dev, "[mes_dbgext%s] %s\n", pfx, text);
+		break;
+	}
+}
+
+/*
+ * Drain a single zone of the mes_aux buffer.  @zbase points at the
+ * zone start (its LOG_ZONE_HEADER); rptr/wptr are relative to @zbase.  @item is
+ * caller-provided scratch of at least MES_DBGEXT_MAX_ITEM_SIZE + 1 bytes.
+ */
+static void mes_dbgext_process_zone(struct amdgpu_device *adev, u8 *zbase,
+				    u8 *item, int xcc)
+{
+	struct mes_dbgext_zone_header *zh =
+		(struct mes_dbgext_zone_header *)zbase;
+	u32 rptr, wptr, buffer_size, hdr_size;
+
+	buffer_size = READ_ONCE(zh->buffer_size);
+	hdr_size = READ_ONCE(zh->header_size);
+	rptr = READ_ONCE(zh->rptr);
+	wptr = READ_ONCE(zh->wptr);
+
+	/* Nothing to do until the firmware has written a new message. */
+	if (rptr == wptr)
+		return;
+
+	/*
+	 * Order the wptr load ahead of the item-body loads below.  The firmware
+	 * publishes an item by writing its body first and advancing wptr last;
+	 * this barrier ensures we observe the body that wptr claims is present.
+	 */
+	dma_rmb();
+
+	if (hdr_size < sizeof(*zh) || buffer_size <= hdr_size ||
+	    rptr < hdr_size || rptr >= buffer_size ||
+	    wptr < hdr_size || wptr >= buffer_size)
+		return;
+
+	while (rptr != wptr) {
+		u8 hb[MES_DBGEXT_ITEM_HDR_SIZE];
+		u32 type, len;
+
+		mes_dbgext_buf_read(zbase, buffer_size, hdr_size, rptr,
+				    hb, sizeof(hb));
+		type = hb[0];
+		len = ((u32)hb[2] << 16) | ((u32)hb[3] << 8) | hb[4];
+
+		/* sign = xor of all header bytes except the sign byte itself. */
+		if ((u8)(hb[0] ^ hb[2] ^ hb[3] ^ hb[4] ^ hb[5] ^ hb[6]) != hb[1] ||
+		    len <= MES_DBGEXT_ITEM_HDR_SIZE ||
+		    len > MES_DBGEXT_MAX_ITEM_SIZE ||
+		    len > buffer_size - hdr_size) {
+			dev_dbg(adev->dev,
+				"mes_dbgext: bad item @%u (type 0x%x len %u), skipping to %u\n",
+				rptr, type, len, wptr);
+			rptr = wptr;
+			break;
+		}
+
+		/*
+		 * Zones also carry binary event/interrupt/api records (types
+		 * 0x93..0x95) whose payload is a NUL-terminated file name
+		 * followed by raw struct bytes - not human-readable text.  Only
+		 * print the text record types (MSG/ASSERT/HALT); consume and
+		 * skip everything else so the binary records' file-name prefix
+		 * is not dumped to dmesg.
+		 */
+		if (type == MES_DBGEXT_MSG ||
+		    type == MES_DBGEXT_MSG_ASSERT ||
+		    type == MES_DBGEXT_MSG_HALT) {
+			mes_dbgext_buf_read(zbase, buffer_size, hdr_size, rptr,
+					    item, len);
+			item[len] = '\0';
+			mes_dbgext_print_item(adev, xcc, type,
+				(char *)item + MES_DBGEXT_ITEM_HDR_SIZE);
+		}
+
+		rptr += len;
+		if (rptr >= buffer_size)
+			rptr -= (buffer_size - hdr_size);
+		if (rptr < hdr_size || rptr >= buffer_size) {
+			rptr = wptr;
+			break;
+		}
+	}
+
+	/*
+	 * Ensure all item-body reads complete before we publish the new rptr;
+	 * otherwise the firmware may observe the advanced rptr and reuse buffer
+	 * space we have not finished reading.
+	 */
+	dma_wmb();
+	WRITE_ONCE(zh->rptr, rptr);
+}
+
+/*
+ * Drain one per-XCC region: parse its zone table (a zone_count dword followed
+ * by per-zone {offset,length} descriptors) and drain each zone.  @base points
+ * at the region start; @xcc tags the output.
+ */
+static void mes_dbgext_process_region(struct amdgpu_device *adev, u8 *base, int xcc)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+	u32 zone_count, hdr_len, z;
+	u8 *item;
+
+	if (!base)
+		return;
+
+	zone_count = READ_ONCE(*(u32 *)base);
+	if (zone_count == 0 || zone_count > MES_DBGEXT_MAX_ZONES)
+		return;
+
+	hdr_len = sizeof(u32) + zone_count * sizeof(struct mes_dbgext_zone_info);
+	if (hdr_len >= mes->dbgext_log_size)
+		return;
+
+	/* Scratch to linearize a (possibly wrapped) item; +1 for NUL. */
+	item = kmalloc(MES_DBGEXT_MAX_ITEM_SIZE + 1, GFP_KERNEL);
+	if (!item)
+		return;
+
+	for (z = 0; z < zone_count; z++) {
+		struct mes_dbgext_zone_info *zi =
+			(struct mes_dbgext_zone_info *)(base + sizeof(u32)) + z;
+		u32 zoff = READ_ONCE(zi->offset);
+		u32 zlen = READ_ONCE(zi->length);
+
+		/* Skip a bogus zone descriptor rather than the whole buffer. */
+		if (zoff < hdr_len || zoff > mes->dbgext_log_size ||
+		    zlen < sizeof(struct mes_dbgext_zone_header) ||
+		    zlen > mes->dbgext_log_size - zoff)
+			continue;
+
+		mes_dbgext_process_zone(adev, base + zoff, item, xcc);
+	}
+
+	kfree(item);
+}
+
+static void mes_dbgext_process_all(struct amdgpu_device *adev)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+	u32 num_xcc = mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1;
+	u8 *buf = mes->dbgext_log_cpu_addr;
+	u32 xcc;
+
+	if (!buf)
+		return;
+
+	/*
+	 * The buffer holds num_xcc back-to-back per-XCC regions, each
+	 * dbgext_log_size bytes.  Drain each region and tag its output with the
+	 * source XCC (single-XCC ASICs have exactly one region).
+	 */
+	for (xcc = 0; xcc < num_xcc; xcc++) {
+		u8 *base = buf + xcc * mes->dbgext_log_size;
+
+		mes_dbgext_process_region(adev, base, xcc);
+	}
+}
+
+static int amdgpu_mes_dbgext_reader(void *param)
+{
+	struct amdgpu_device *adev = param;
+
+	while (!kthread_should_stop()) {
+		mes_dbgext_process_all(adev);
+		msleep_interruptible(MES_DBGEXT_POLL_INTERVAL_MS);
+	}
+	return 0;
+}
+
+/* Runs in process context; does the (sleepable) buffer drain. */
+static void amdgpu_mes_dbgext_work_fn(struct work_struct *work)
+{
+	struct amdgpu_mes *mes = container_of(work, struct amdgpu_mes,
+					      dbgext_work);
+	struct amdgpu_device *adev =
+		container_of(mes, struct amdgpu_device, mes);
+
+	mes_dbgext_process_all(adev);
+}
+
+/*
+ * Called from the MES interrupt handler (hard/soft IRQ context).  Decodes the
+ * MES->host interrupt type and, for a debug-message notification, schedules the
+ * drain on a workqueue (the parser sleeps / allocates, so it cannot run here).
+ */
+void amdgpu_mes_dbgext_notify(struct amdgpu_device *adev, u32 context_data)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+
+	/*
+	 * Caller has already matched MES_DBGMSG (type 7 in bits 31:26 of the
+	 * IH context dword).  Kick the drain; it is a no-op when the log has
+	 * no new data.
+	 */
+
+	/*
+	 * Only the interrupt path may schedule the drain work.  In polling mode
+	 * the kthread owns rptr; honoring a stale/spurious interrupt here would
+	 * let the work item and the kthread drain concurrently and race on rptr.
+	 */
+	if (!READ_ONCE(mes->dbgext_use_irq))
+		return;
+
+	if (READ_ONCE(mes->dbgext_log_cpu_addr))
+		schedule_work(&mes->dbgext_work);
+}
+
+static int amdgpu_mes_dbgext_setup_fw(struct amdgpu_device *adev, u32 xcc_id,
+				      u64 log_buffer_mc_addr, u64 log_options)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+	struct mes_misc_op_input op_input = {0};
+	int r;
+
+	if (!mes->funcs || !mes->funcs->misc_op)
+		return -EINVAL;
+
+	op_input.xcc_id = xcc_id;
+	op_input.op = MES_MISC_OP_SETUP_MES_DBGEXT;
+	op_input.setup_mes_dbgext.log_buffer_mc_addr = log_buffer_mc_addr;
+	op_input.setup_mes_dbgext.log_options = log_options;
+
+	amdgpu_mes_lock(mes);
+	r = mes->funcs->misc_op(mes, &op_input);
+	amdgpu_mes_unlock(mes);
+
+	return r;
+}
+
+static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+	struct task_struct *reader;
+	bool use_irq;
+	u64 fw_options;
+	u32 size;
+	u32 req_kb;
+	u32 num_xcc, xcc;
+	int r;
+
+	/*
+	 * Effective buffer size (KB): the module parameter wins (so a boot-time
+	 * request is honored), otherwise use the runtime-requested size set by
+	 * the debugfs on/off switch.  Zero means the feature is off.
+	 */
+	req_kb = amdgpu_mes_dbgext_buffer_size ?
+		 amdgpu_mes_dbgext_buffer_size : mes->dbgext_runtime_kb;
+	if (!req_kb)
+		return 0;
+
+	/*
+	 * Already armed for this hw bring-up.  hw_init() can run start() more
+	 * than once (e.g. kiq_hw_init() -> hw_init(), then the MES IP block's
+	 * own hw_init()); only the first should arm.  A post-suspend resume
+	 * comes back here with the buffer kept but dbgext_active cleared by
+	 * stop(), so re-arm runs below.
+	 */
+
+	if (mes->dbgext_active)
+		return 0;
+
+	if (!mes->funcs || !mes->funcs->misc_op) {
+		dev_warn(adev->dev, "mes_dbgext not supported by this MES\n");
+		return 0;
+	}
+
+	/*
+	 * Log every XCC's MES firmware.  Each XCC runs its own MES and gets its
+	 * own per-XCC region within one buffer (see dbgext_num_xcc); single-XCC
+	 * ASICs (gfx11/gfx12) collapse to a single region.
+	 */
+	num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+	mes->dbgext_num_xcc = num_xcc;
+
+	if (!mes->dbgext_log_gpu_obj) {
+		/* Clamp to a sane range (4 KB .. 1 MB), per XCC. */
+		size = clamp(req_kb, 4U, 1024U);
+		size = ALIGN((u32)size * SZ_1K, PAGE_SIZE);
+		/*
+		 * The mes_aux firmware splits the buffer into per-thread zones
+		 * and rejects buffers that are not larger than its 4 KB minimum,
+		 * so give it at least 8 KB.
+		 */
+		if (size < SZ_8K)
+			size = SZ_8K;
+
+		/* One buffer holds num_xcc back-to-back per-XCC regions. */
+		r = amdgpu_bo_create_kernel(adev, size * num_xcc, PAGE_SIZE,
+					    AMDGPU_GEM_DOMAIN_GTT,
+					    &mes->dbgext_log_gpu_obj,
+					    &mes->dbgext_log_gpu_addr,
+					    &mes->dbgext_log_cpu_addr);
+		if (r) {
+			dev_warn(adev->dev,
+				 "failed to create mes_dbgext log buffer (%d)\n", r);
+			return r;
+		}
+		mes->dbgext_log_size = size;
+		INIT_WORK(&mes->dbgext_work, amdgpu_mes_dbgext_work_fn);
+	} else {
+		/*
+		 * Resume: the log buffer is kept allocated across a suspend/
+		 * resume cycle (freeing a kernel BO while suspended is not
+		 * allowed), so reuse it and just re-arm the firmware below.
+		 */
+		size = mes->dbgext_log_size;
+	}
+
+	/*
+	 * (Re)initialize each per-XCC region's header.  On resume the MES was
+	 * reset and re-lays its header, and the driver's rptr/wptr must restart
+	 * clean.  Clear the whole buffer once, then seed every region.
+	 */
+	memset(mes->dbgext_log_cpu_addr, 0, size * num_xcc);
+	for (xcc = 0; xcc < num_xcc; xcc++) {
+		u8 *base = (u8 *)mes->dbgext_log_cpu_addr + xcc * size;
+
+		/*
+		 * mes_aux: seed only the total region size in the first dword.
+		 * The firmware (InitializeLogBuffer) reads it during setup and
+		 * lays out its own zone-partitioned header in place.
+		 */
+		*(u32 *)base = size;
+	}
+
+	/*
+	 * The options word is passed verbatim to the firmware.  bit0
+	 * (trigger_interrupt_per_new_msg) selects the collection method:
+	 *   set   -> firmware raises an interrupt per message; the driver
+	 *            collects them via the CP EOP path (gfx_v11_0_eop_irq).
+	 *   clear -> firmware only writes the buffer; the driver polls with a
+	 *            kthread.
+	 * If interrupts are requested but the ASIC has no CP enable hook, fall
+	 * back to polling and clear the bit so the firmware does not raise an
+	 * interrupt nobody will service.
+	 */
+	mes->dbgext_log_options = (u32)amdgpu_mes_dbgext_options;
+	use_irq = (mes->dbgext_log_options & MES_DBGEXT_OPT_TRIGGER_INT_PER_MSG) &&
+		  mes->funcs->enable_dbgext_irq;
+	if (!use_irq)
+		mes->dbgext_log_options &= ~MES_DBGEXT_OPT_TRIGGER_INT_PER_MSG;
+	mes->dbgext_use_irq = use_irq;
+
+	/*
+	 * Translate the options to the mes_aux firmware layout: enable logging
+	 * (bit1), select interrupt vs polling via host_poll_msg (bit0, inverted
+	 * sense), and leave the write-back cache off for prompt delivery.
+	 */
+	fw_options = MES_DBGEXT_AUX_OPT_ENABLE_MES_LOG;
+	if (!use_irq)
+		fw_options |= MES_DBGEXT_AUX_OPT_HOST_POLL;
+
+	/*
+	 * Mark the feature active *before* arming the firmware.  setup_fw()
+	 * below makes the firmware emit its first ("enabled") message and, in
+	 * interrupt mode, immediately raise the host interrupt for it.  The EOP
+	 * handler drops the drain unless dbgext_active is already set, so if it
+	 * were set only after setup_fw() the enable interrupt would race the
+	 * handler and be lost - and on emulation no further message/interrupt
+	 * follows to recover it.  Cleared again on the error paths below.
+	 */
+	mes->dbgext_active = true;
+
+	/* Enable delivery of the MES host interrupt at the CP (process ctx). */
+	if (use_irq)
+		mes->funcs->enable_dbgext_irq(mes, true);
+
+	/* Point each XCC's MES firmware at its own per-XCC region. */
+	for (xcc = 0; xcc < num_xcc; xcc++) {
+		r = amdgpu_mes_dbgext_setup_fw(adev, xcc,
+					       mes->dbgext_log_gpu_addr + xcc * size,
+					       fw_options);
+		if (r) {
+			dev_err(adev->dev,
+				"failed to setup mes_dbgext in FW on xcc%u (%d)\n",
+				xcc, r);
+			/* Detach the XCCs already armed before bailing. */
+			while (xcc--)
+				amdgpu_mes_dbgext_setup_fw(adev, xcc, 0, 0);
+			goto err_disable;
+		}
+	}
+
+	if (!use_irq) {
+		/*
+		 * Never leak a reader: if one is somehow still around (a missed
+		 * stop()), reap it before creating a new one so it cannot outlive
+		 * the module.
+		 */
+		if (WARN_ON(mes->dbgext_reader)) {
+			kthread_stop(mes->dbgext_reader);
+			mes->dbgext_reader = NULL;
+		}
+
+		reader = kthread_run(amdgpu_mes_dbgext_reader, adev,
+				     "amdgpu_mes_dbgext");
+		if (IS_ERR(reader)) {
+			r = PTR_ERR(reader);
+			dev_err(adev->dev,
+				"failed to start mes_dbgext reader (%d)\n", r);
+			goto err_fw_detach;
+		}
+		mes->dbgext_reader = reader;
+	}
+
+	dev_info(adev->dev,
+		 "mes_dbgext enabled: %u KB x %u xcc @ 0x%llx (%s, fw options 0x%llx)\n",
+		 size / SZ_1K, num_xcc, mes->dbgext_log_gpu_addr,
+		 use_irq ? "interrupt" : "polling", fw_options);
+
+	/*
+	 * In interrupt mode the firmware has already written its "enabled"
+	 * message (and raised the one-shot enable interrupt) during setup_fw()
+	 * above.  Kick an explicit drain now so that message is collected even
+	 * if that interrupt was missed, and so the log is not left waiting for
+	 * the next firmware message - which, on emulation, may never come.
+	 */
+	if (use_irq)
+		amdgpu_mes_dbgext_notify(adev, 0);
+
+	return 0;
+
+err_fw_detach:
+	for (xcc = 0; xcc < num_xcc; xcc++)
+		amdgpu_mes_dbgext_setup_fw(adev, xcc, 0, 0);
+err_disable:
+	/* Undo the early arming done before setup_fw(). */
+	mes->dbgext_active = false;
+	if (use_irq)
+		mes->funcs->enable_dbgext_irq(mes, false);
+	mes->dbgext_use_irq = false;
+	/* Never free a kernel BO while suspended; keep it for the next start. */
+	if (!adev->in_suspend) {
+		amdgpu_bo_free_kernel(&mes->dbgext_log_gpu_obj,
+				      &mes->dbgext_log_gpu_addr,
+				      &mes->dbgext_log_cpu_addr);
+		mes->dbgext_log_size = 0;
+	}
+	return r;
+}
+
+int amdgpu_mes_dbgext_start(struct amdgpu_device *adev)
+{
+	int r;
+
+	mutex_lock(&adev->mes.dbgext_lock);
+	r = amdgpu_mes_dbgext_start_locked(adev);
+	mutex_unlock(&adev->mes.dbgext_lock);
+
+	return r;
+}
+
+static void amdgpu_mes_dbgext_stop_locked(struct amdgpu_device *adev)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+
+	mes->dbgext_active = false;
+
+	/*
+	 * Tear down the reader kthread and the host interrupt first, and do so
+	 * independently of the buffer state.  The kthread runs code that lives
+	 * in this module, so it must never be left alive past module unload -
+	 * otherwise it faults on an instruction fetch once the module text is
+	 * freed.  A second stop() in a teardown/reset sequence, or one reached
+	 * after the buffer was already freed on an error path, must still be
+	 * able to reap a stale reader; hence this runs before the buffer guard.
+	 */
+	if (mes->dbgext_reader) {
+		kthread_stop(mes->dbgext_reader);
+		mes->dbgext_reader = NULL;
+	}
+
+	if (mes->dbgext_use_irq) {
+		mes->funcs->enable_dbgext_irq(mes, false);
+		mes->dbgext_use_irq = false;
+	}
+
+	if (!mes->dbgext_log_gpu_obj)
+		return;
+
+	/*
+	 * Detach the firmware from the buffer before we free it, on every XCC we
+	 * armed.  Skip this across a suspend: the MES is being torn down anyway,
+	 * the buffer is kept for resume, and submitting a packet on the suspend
+	 * path is unnecessary.
+	 */
+	if (!adev->in_suspend) {
+		u32 num_xcc = mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1;
+		u32 xcc;
+
+		for (xcc = 0; xcc < num_xcc; xcc++)
+			amdgpu_mes_dbgext_setup_fw(adev, xcc, 0, 0);
+	}
+
+	/* Make sure no drain work is still touching the buffer. */
+	cancel_work_sync(&mes->dbgext_work);
+
+	/* Drain anything the firmware wrote before we stopped. */
+	mes_dbgext_process_all(adev);
+
+	/*
+	 * Keep the buffer allocated across a suspend/resume cycle (freeing a
+	 * kernel BO while suspended is not allowed - it trips a WARN in
+	 * amdgpu_bo_free_kernel()); only free it on real teardown.
+	 */
+	if (adev->in_suspend)
+		return;
+
+	amdgpu_bo_free_kernel(&mes->dbgext_log_gpu_obj,
+			      &mes->dbgext_log_gpu_addr,
+			      &mes->dbgext_log_cpu_addr);
+	mes->dbgext_log_size = 0;
+}
+
+void amdgpu_mes_dbgext_stop(struct amdgpu_device *adev)
+{
+	mutex_lock(&adev->mes.dbgext_lock);
+	amdgpu_mes_dbgext_stop_locked(adev);
+	mutex_unlock(&adev->mes.dbgext_lock);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
@@ -1254,17 +1912,96 @@ static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_mes_event_log);
 
-#endif
+/*
+ * Runtime on/off switch for the MES firmware debug extension.
+ *
+ *   cat  <debugfs>/amdgpu_mes_dbgext   -> current state / size / mode
+ *   echo 1 > <debugfs>/amdgpu_mes_dbgext   -> enable
+ *   echo 0 > <debugfs>/amdgpu_mes_dbgext   -> disable
+ *
+ * When enabled with no boot-time size (mes_dbgext_buffer_size=0) a default
+ * buffer size is used; the collection method still follows mes_dbgext_options.
+ */
+static int amdgpu_debugfs_mes_dbgext_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_device *adev = m->private;
+	struct amdgpu_mes *mes = &adev->mes;
+
+	mutex_lock(&mes->dbgext_lock);
+	seq_printf(m, "state:   %s\n", mes->dbgext_active ? "on" : "off");
+	seq_printf(m, "size:    %u KB x %u xcc\n", mes->dbgext_log_size / SZ_1K,
+		   mes->dbgext_num_xcc ? mes->dbgext_num_xcc : 1);
+	seq_printf(m, "mode:    %s\n",
+		   mes->dbgext_use_irq ? "interrupt" : "polling");
+	seq_printf(m, "options: 0x%llx\n", mes->dbgext_log_options);
+	mutex_unlock(&mes->dbgext_lock);
 
-void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev)
+	return 0;
+}
+
+static int amdgpu_debugfs_mes_dbgext_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, amdgpu_debugfs_mes_dbgext_show,
+			   inode->i_private);
+}
+
+static ssize_t amdgpu_debugfs_mes_dbgext_write(struct file *file,
+					       const char __user *buf,
+					       size_t count, loff_t *ppos)
 {
+	struct amdgpu_device *adev =
+		((struct seq_file *)file->private_data)->private;
+	struct amdgpu_mes *mes = &adev->mes;
+	bool enable;
+	int r;
 
+	r = kstrtobool_from_user(buf, count, &enable);
+	if (r)
+		return r;
+
+	if (!mes->funcs || !mes->funcs->misc_op)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&mes->dbgext_lock);
+	if (enable) {
+		mes->dbgext_runtime_kb = amdgpu_mes_dbgext_buffer_size ?
+			amdgpu_mes_dbgext_buffer_size : MES_DBGEXT_DEFAULT_KB;
+		r = amdgpu_mes_dbgext_start_locked(adev);
+	} else {
+		amdgpu_mes_dbgext_stop_locked(adev);
+		mes->dbgext_runtime_kb = 0;
+		r = 0;
+	}
+	mutex_unlock(&mes->dbgext_lock);
+
+	return r ? r : count;
+}
+
+static const struct file_operations amdgpu_debugfs_mes_dbgext_fops = {
+	.owner = THIS_MODULE,
+	.open = amdgpu_debugfs_mes_dbgext_open,
+	.read = seq_read,
+	.write = amdgpu_debugfs_mes_dbgext_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+#endif
+
+void amdgpu_debugfs_mes_init(struct amdgpu_device *adev)
+{
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 	struct dentry *root = minor->debugfs_root;
-	if (adev->enable_mes && amdgpu_mes_log_enable)
+
+	if (!adev->enable_mes)
+		return;
+
+	if (amdgpu_mes_log_enable)
 		debugfs_create_file("amdgpu_mes_event_log", 0444, root,
 				    adev, &amdgpu_debugfs_mes_event_log_fops);
 
+	debugfs_create_file("amdgpu_mes_dbgext", 0644, root,
+			    adev, &amdgpu_debugfs_mes_dbgext_fops);
 #endif
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 5160b227943b..594fb817e0a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -155,6 +155,30 @@ struct amdgpu_mes {
 	uint64_t			event_log_gpu_addr;
 	void				*event_log_cpu_addr;
 
+	/* MES firmware debug extension ("mes_dbgext") log buffer */
+	uint32_t			dbgext_log_size;	/* per-XCC region size */
+	uint64_t			dbgext_log_options;
+	struct amdgpu_bo		*dbgext_log_gpu_obj;
+	uint64_t			dbgext_log_gpu_addr;
+	void				*dbgext_log_cpu_addr;
+	bool				dbgext_use_irq;
+
+	/*
+	 * Number of per-XCC log regions packed back-to-back in the buffer above;
+	 * each is dbgext_log_size bytes.  1 on single-XCC ASICs (gfx11/gfx12).
+	 */
+	uint32_t			dbgext_num_xcc;
+
+	/* armed: FW attached + reader/irq running */
+	bool					dbgext_active;
+
+	struct work_struct		dbgext_work;
+	struct task_struct		*dbgext_reader;		/* polling fallback */
+	struct mutex			dbgext_lock;		/* serializes runtime start/stop */
+
+	/* runtime-requested size (KB); 0 = follow module param */
+	uint32_t			dbgext_runtime_kb;
+
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
 
@@ -371,7 +395,8 @@ enum mes_misc_opcode {
 	MES_MISC_OP_WRM_REG_WR_WAIT,
 	MES_MISC_OP_SET_SHADER_DEBUGGER,
 	MES_MISC_OP_CHANGE_CONFIG,
-	MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
+	MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE,
+	MES_MISC_OP_SETUP_MES_DBGEXT,
 };
 
 struct mes_misc_op_input {
@@ -426,6 +451,11 @@ struct mes_misc_op_input {
 				uint32_t tdr_delay;
 			} tdr_config;
 		} change_config;
+
+		struct {
+			uint64_t log_buffer_mc_addr;
+			uint64_t log_options;
+		} setup_mes_dbgext;
 	};
 };
 
@@ -451,6 +481,13 @@ struct amdgpu_mes_funcs {
 	int (*misc_op)(struct amdgpu_mes *mes,
 		       struct mes_misc_op_input *input);
 
+	/*
+	 * Enable/disable the MES firmware debug-extension host interrupt at the
+	 * hardware level.  Runs in process context (may take srbm_mutex), unlike
+	 * the atomic irq .set callback.
+	 */
+	int (*enable_dbgext_irq)(struct amdgpu_mes *mes, bool enable);
+
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
 
@@ -518,6 +555,26 @@ void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev);
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);
 
+int amdgpu_mes_dbgext_start(struct amdgpu_device *adev);
+void amdgpu_mes_dbgext_stop(struct amdgpu_device *adev);
+void amdgpu_mes_dbgext_notify(struct amdgpu_device *adev, u32 context_data);
+
+/*
+ * MES host-interrupt context dword (IH src_data[0]), same overlay as KMD
+ * IRQMGR_INTERRUPT_CONTEXTDATA_MES and firmware MES_INT_CONTEXT_DATA:
+ *   bits 25:0  payload (doorbell / reserved)
+ *   bits 31:26 interrupt type (MES_DBGMSG = 7)
+ */
+#define AMDGPU_MES_IH_INT_TYPE_SHIFT	26
+#define AMDGPU_MES_IH_INT_TYPE_MASK	0x3f
+#define AMDGPU_MES_IH_INT_TYPE_DBGMSG	7
+
+static inline uint32_t amdgpu_mes_ih_int_type(uint32_t context_data)
+{
+	return (context_data >> AMDGPU_MES_IH_INT_TYPE_SHIFT) &
+	       AMDGPU_MES_IH_INT_TYPE_MASK;
+}
+
 int amdgpu_mes_suspend(struct amdgpu_device *adev, u32 xcc_id);
 int amdgpu_mes_resume(struct amdgpu_device *adev, u32 xcc_id);
 
-- 
2.43.0

