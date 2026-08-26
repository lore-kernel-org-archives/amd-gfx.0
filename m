Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DC3C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 19:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD6810E335;
	Wed, 26 Aug 2026 19:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jHsYycPA";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C96610E335
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 19:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaQMbqV1w/TA+hrR3Cq8Pk67M14TPPpaCWKRw+HFOQ/H9tqwRIO6swOporVarcsZIvHzictQJFH8TuAWgVSvoPY+swam9vqbVlEqIzmUu2GHodg1yAEj/s6ck/Iix/vTCxcLiJEEoCXgvR7sTp6rf+tJ4KoxgcUPCOiihMj3rHBjX2MYvZk1jeK8XQZmBlmhJHOI1NDgfOSWF9qBIhwE5rayA5cfXUYidlCQrDGZR3Y1JwkZYj0A1PTSQAFHOFLr56jDz+flHHgEDc8vkqxB02O0mJoPfTEc1kAR5TgdbbnTMF0DA5QlCM1UHec6EN51XJz09QLzvlir6HKjeR/5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0l28V3wcZrAQTpXUfmXAAmHXREt2DTNHwOMeoQIFbA=;
 b=BUywK3ICKr53a9nLU/M+8y33bnoYSoZW/j7z5mwvQ4sIMeaNN8feWnIb3Kwj3lzmaTnhvF1T3XBZ5vfQXXvJrLgRBLkScu5yJ+LuWJGCtHySFIgpNXpY5NA69O32PN5FRcd0nW7OHZ5dr8xQGDi2CFwOX4EzJvgUWPkwMwPWX2hyA7d+d9oRcVfKDF+Bx7TrqUIa10nOHd1+ziNheM3Jl/xweTsNzmA9UUQwB5gH+yZqPaerFnN2WLb4dF4vpvHqRBt+dr6zjotESqWEVQcMyReYR6nqA+JN5Clz4X3f3sperX6tJM0UNgILXE1dgZYPTt513En/Ua+WZ9fJ+vCa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0l28V3wcZrAQTpXUfmXAAmHXREt2DTNHwOMeoQIFbA=;
 b=jHsYycPAmS/rL4itlx6QJfx57O5ZqiJ+pfvldoTRCaV3Lnnce6RgJLxE8YlSAj7v6WnsChwUQinL53tlkLItDt/ym2Y/+QsqcFiT7YI9FRpKqAlcUIU1PtHJoIqk25bWdmjcxpmQ9tfvUfh2ZSn62T/nAxNauCoex3KP/isvq4g=
Received: from MW4PR03CA0062.namprd03.prod.outlook.com (2603:10b6:303:b6::7)
 by DS2PR12MB9823.namprd12.prod.outlook.com (2603:10b6:8:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 19:32:16 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::35) by MW4PR03CA0062.outlook.office365.com
 (2603:10b6:303:b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 19:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 19:32:15 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 14:32:13 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add MES debug extension support for gfx11.
Date: Wed, 26 Aug 2026 15:31:56 -0400
Message-ID: <20260826193156.916441-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|DS2PR12MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: d220283a-994c-40a9-555a-08df03a8bbf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|6133799003|3023799007|56012099006|10067099003|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: muTWwk69iqKCLX2ni7weQIh2R1hrUdaZnKnlxnZFZAbOW6tUTYZI5rbi0N3WuWk7mIeucEyaYaUSClKPhQKOJMSgqwHE/yFyE2SeZEu1nmyhPo0LMO/evH9hr0BdzVa4LjaTSpvTeZI6Q0fZVhD++Z8xEFuvW/LzmNfOiWYKcuH+5aZZRRbMyhLl4yvqzdcBuMd8gm45fs1+lOCoR5lg8rsiDiy2wp9gJf3FgJXKo9jnDvfc9K3B1eKajGs7w+wNiKPVL8cMfEOtyHrahd9MeEb+4SSLoL6kOz2kAuZdAEuW6QM5bKfih50IlVu7h0wpORcQj1xYfYNzfvHDwa1rfihBd+SHhOcWKltCu/oERl69Mgq4YGkT7VKQRW4VOZWKcJdQp1EPEVftVQJPOjpXPSl4yg3AoHt+KBPC+VqDIVldmg6NUMfvRMCsD5BxY4wiA+7Hc6QGxeEhueFd5kq3WeRgtMfzdEvsLFdBcnMWOShE1QJL63aQ5NrZ9z4sJz1nq1gONRiLEfuQANT+4SSBLav81YsWN29SuHOhmiJgctoncfivtAZd1FyPnsOXN0HYhweYOtfr2sBDiTq09YN5KnxAVVxfolcNvQnnnbcGhniVl184wcM3eHOu/9n9wYOpFQI7leuX5XvS9EmJ/uWO8BE+LZvWqASL8uoZuODxol6GVMxfrGHo3zGTZgH0DyJNXuI+hduN0USW9ljO8UH1kg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ISV19ivkhwJ7i1b1VBKG37ji9Uq0IOz8gbULDst1DELcA7ji+ePfF3Wea7ZHxj1SVZUqFVpzFlv/cGqt21IcC+z6Bm0fY14TtRTqZb+g/9mb2ExAZ5RH75UR9uMElXYtrcXH+GJW9zYT/TNRVNCNby21FxR8GiJ9gVc0Dd6MD148Ts60Ni9FjCHHUIdsL816EWWX1+SbJgoHhnFjW4n84uDn5QPkzbzhhDOzi1olcJxLRVymosc0BjrEy2vCRlBZlR+O5waqjndVQ1SnozvOdNDvpQ2RnGBLtCaBkAenIfkDaM9Hp+qAU0wmfeTvmEe0ixu8Lzkes6hk/r+AMLF6pKEv3xaKWWSFKR7c82HrdUEZcZt1JhjZvlfla1OYunEPwDa0JWDkiErFrjFxHtoBjaWvEcVvfvmKQUMkj0TuS69djewx6UtzhQdJ2XQVmZja
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 19:32:15.1646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d220283a-994c-40a9-555a-08df03a8bbf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9823
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

Add configurable MES debug logging with interrupt and polling
collection modes. Initialize and parse the firmware ring buffer,
route GFX11 MES debug interrupts, and print messages to dmesg.

Expose mes_dbgext_buffer_size and mes_dbgext_options module
parameters to configure the buffer and collection mode.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 619 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  37 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  12 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  39 ++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  18 +
 9 files changed, 755 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8a7c89afc88e..bf9a787d46f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -216,6 +216,8 @@ extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
 extern int amdgpu_mes_log_enable;
+extern int amdgpu_mes_dbgext_buffer_size;
+extern int amdgpu_mes_dbgext_options;
 extern int amdgpu_uni_mes;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 132d054900b5..8e4c2b4519e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2175,7 +2175,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
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
index 53738b40c97f..90dd91599c00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -225,7 +225,9 @@ uint amdgpu_dc_visual_confirm;
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
@@ -698,6 +700,33 @@ MODULE_PARM_DESC(mes_log_enable,
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
index e0e38d6bcafc..01544c4f10e2 100644
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
@@ -320,6 +326,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 
 	ida_destroy(&adev->mes.doorbell_ida);
 	mutex_destroy(&adev->mes.mutex_hidden);
+	mutex_destroy(&adev->mes.dbgext_lock);
 
 }
 
@@ -1233,6 +1240,534 @@ void amdgpu_mes_userq_queue_unmapped(struct amdgpu_device *adev)
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
+#define MES_DBGEXT_ITEM_HDR_SIZE	4
+#define MES_DBGEXT_BUF_HDR_SIZE		16
+#define MES_DBGEXT_MAX_ITEM_SIZE	2048
+#define MES_DBGEXT_POLL_INTERVAL_MS	200
+/* Default log-buffer size (KB) used when enabled at runtime with no size set. */
+#define MES_DBGEXT_DEFAULT_KB		8
+
+/* Log item types, must match the MES firmware (mes_dbgext.h MesMsgType). */
+#define MES_DBGEXT_MSG			0x80
+#define MES_DBGEXT_MSG_ASSERT		0x81
+#define MES_DBGEXT_MSG_BTRACE		0x82
+#define MES_DBGEXT_MSG_HALT		0x83
+#define MES_DBGEXT_MSG_STEP		0x84
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
+ * Log buffer header at offset 0 (matches the MES firmware LOG_BUFF_HEADER).
+ * The buffer is a single circular byte stream: the driver owns rptr, the
+ * firmware owns wptr, both wrapping from buffer_size back to header_size.
+ * buffer_size and header_size are initialized by the driver in
+ * amdgpu_mes_dbgext_start().
+ */
+struct mes_dbgext_buf_header {
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
+enum mes_dbgext_kind {
+	MES_DBGEXT_KIND_MSG,
+	MES_DBGEXT_KIND_ASSERT,
+	MES_DBGEXT_KIND_HALT,
+};
+
+static void mes_dbgext_print_item(struct amdgpu_device *adev,
+				  enum mes_dbgext_kind kind, char *text)
+{
+	size_t n = strlen(text);
+
+	/* Normalize to exactly one trailing newline: the gfx11 firmware appends
+	 * one to the text, the gfx12/mes_aux firmware does not.
+	 */
+	while (n && (text[n - 1] == '\n' || text[n - 1] == '\r'))
+		text[--n] = '\0';
+
+	switch (kind) {
+	case MES_DBGEXT_KIND_ASSERT:
+		dev_warn(adev->dev, "[mes_dbgext] ASSERT %s\n", text);
+		break;
+	case MES_DBGEXT_KIND_HALT:
+		dev_warn(adev->dev, "[mes_dbgext] HALT %s\n", text);
+		break;
+	default:
+		dev_info(adev->dev, "[mes_dbgext] %s\n", text);
+		break;
+	}
+}
+
+static void mes_dbgext_process_flat(struct amdgpu_device *adev)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+	struct mes_dbgext_buf_header *bh = mes->dbgext_log_cpu_addr;
+	u32 rptr, wptr, buffer_size, hdr_size;
+	u8 *item;
+
+	if (!bh)
+		return;
+
+	buffer_size = READ_ONCE(bh->buffer_size);
+	hdr_size = READ_ONCE(bh->header_size);
+	rptr = READ_ONCE(bh->rptr);
+	wptr = READ_ONCE(bh->wptr);
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
+	/* Sanity-check the header against the allocation. */
+	if (hdr_size < sizeof(*bh) || buffer_size > mes->dbgext_log_size ||
+	    buffer_size <= hdr_size ||
+	    rptr < hdr_size || rptr >= buffer_size ||
+	    wptr < hdr_size || wptr >= buffer_size)
+		return;
+
+	/* Scratch to linearize a (possibly wrapped) item; +1 for NUL. */
+	item = kmalloc(MES_DBGEXT_MAX_ITEM_SIZE + 1, GFP_KERNEL);
+	if (!item)
+		return;
+
+	while (rptr != wptr) {
+		u8 hb[MES_DBGEXT_ITEM_HDR_SIZE];
+		enum mes_dbgext_kind kind;
+		u32 type, len;
+		u8 sign, len_hi, len_lo;
+
+		mes_dbgext_buf_read((u8 *)bh, buffer_size, hdr_size, rptr,
+				    hb, sizeof(hb));
+		type = hb[0];
+		sign = hb[1];
+		len_hi = hb[2];
+		len_lo = hb[3];
+		len = ((u32)len_hi << 8) | len_lo;
+
+		/* On corruption/desync, skip everything up to wptr. */
+		if ((u8)(type ^ len_hi ^ len_lo) != sign ||
+		    len <= MES_DBGEXT_ITEM_HDR_SIZE ||
+		    len > MES_DBGEXT_MAX_ITEM_SIZE) {
+			dev_dbg(adev->dev,
+				"mes_dbgext: bad item @%u (type 0x%x len %u), skipping to %u\n",
+				rptr, type, len, wptr);
+			rptr = wptr;
+			break;
+		}
+
+		mes_dbgext_buf_read((u8 *)bh, buffer_size, hdr_size, rptr,
+				    item, len);
+		item[len] = '\0';	/* NUL-terminate the text tail */
+		switch (type) {
+		case MES_DBGEXT_MSG_ASSERT:
+			kind = MES_DBGEXT_KIND_ASSERT;
+			break;
+		case MES_DBGEXT_MSG_HALT:
+			kind = MES_DBGEXT_KIND_HALT;
+			break;
+		default:
+			kind = MES_DBGEXT_KIND_MSG;
+			break;
+		}
+		mes_dbgext_print_item(adev, kind,
+				      (char *)item + MES_DBGEXT_ITEM_HDR_SIZE);
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
+	WRITE_ONCE(bh->rptr, rptr);
+	kfree(item);
+}
+
+static void mes_dbgext_process_all(struct amdgpu_device *adev)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+
+	if (!mes->dbgext_log_cpu_addr)
+		return;
+
+	mes_dbgext_process_flat(adev);
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
+	 * The MES->host interrupt "type" lives in the upper bits of the context
+	 * word, but on gfx12 the IH cookie truncates that field so a DBGMSG
+	 * cannot be reliably told apart from other MES host interrupts.  The
+	 * caller has already narrowed this down to the MES scheduler pipe, so
+	 * just kick the drain: it is a no-op when the log buffer has no new
+	 * data, which makes an occasional spurious poke harmless.
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
+static int amdgpu_mes_dbgext_setup_fw(struct amdgpu_device *adev,
+				      u64 log_buffer_mc_addr, u64 log_options)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+	struct mes_misc_op_input op_input = {0};
+	int r;
+
+	if (!mes->funcs || !mes->funcs->misc_op)
+		return -EINVAL;
+
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
+	if (!mes->dbgext_log_gpu_obj) {
+		/* Clamp to a sane range (4 KB .. 1 MB). */
+		size = clamp(req_kb, 4U, 1024U);
+		size = ALIGN((u32)size * SZ_1K, PAGE_SIZE);
+
+		r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
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
+	 * (Re)initialize the log buffer header.  On resume the MES was reset and
+	 * re-lays its header, and the driver's rptr/wptr must restart clean.
+	 */
+	memset(mes->dbgext_log_cpu_addr, 0, size);
+	{
+		/*
+		 * gfx11: initialize the LOG_BUFF_HEADER the firmware expects: a
+		 * single circular byte stream following the 16-byte header.  The
+		 * driver owns rptr, the firmware owns wptr; both start just past
+		 * the header and wrap from buffer_size back to header_size.  The
+		 * firmware reads buffer_size and header_size on every message,
+		 * so they must be set up before setup.
+		 */
+		struct mes_dbgext_buf_header *bh = mes->dbgext_log_cpu_addr;
+
+		bh->rptr = MES_DBGEXT_BUF_HDR_SIZE;
+		bh->wptr = MES_DBGEXT_BUF_HDR_SIZE;
+		bh->buffer_size = size;
+		bh->header_size = MES_DBGEXT_BUF_HDR_SIZE;
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
+	 * The options word (bit0 = trigger_interrupt_per_new_msg) is passed to
+	 * the firmware verbatim.
+	 */
+	fw_options = mes->dbgext_log_options;
+
+	/* Enable delivery of the MES host interrupt at the CP (process ctx). */
+	if (use_irq)
+		mes->funcs->enable_dbgext_irq(mes, true);
+
+	r = amdgpu_mes_dbgext_setup_fw(adev, mes->dbgext_log_gpu_addr,
+				       fw_options);
+	if (r) {
+		dev_err(adev->dev, "failed to setup mes_dbgext in FW (%d)\n", r);
+		goto err_disable;
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
+	mes->dbgext_active = true;
+
+	dev_info(adev->dev,
+		 "mes_dbgext enabled: %u KB @ 0x%llx (%s, fw options 0x%llx)\n",
+		 size / SZ_1K, mes->dbgext_log_gpu_addr,
+		 use_irq ? "interrupt" : "polling", fw_options);
+	return 0;
+
+err_fw_detach:
+	amdgpu_mes_dbgext_setup_fw(adev, 0, 0);
+err_disable:
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
+	 * Detach the firmware from the buffer before we free it.  Skip this
+	 * across a suspend: the MES is being torn down anyway, the buffer is
+	 * kept for resume, and submitting a packet on the suspend path is
+	 * unnecessary.
+	 */
+	if (!adev->in_suspend)
+		amdgpu_mes_dbgext_setup_fw(adev, 0, 0);
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
@@ -1248,17 +1783,95 @@ static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
 
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
+	seq_printf(m, "size:    %u KB\n", mes->dbgext_log_size / SZ_1K);
+	seq_printf(m, "mode:    %s\n",
+		   mes->dbgext_use_irq ? "interrupt" : "polling");
+	seq_printf(m, "options: 0x%llx\n", mes->dbgext_log_options);
+	mutex_unlock(&mes->dbgext_lock);
+
+	return 0;
+}
+
+static int amdgpu_debugfs_mes_dbgext_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, amdgpu_debugfs_mes_dbgext_show,
+			   inode->i_private);
+}
 
-void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev)
+static ssize_t amdgpu_debugfs_mes_dbgext_write(struct file *file,
+					       const char __user *buf,
+					       size_t count, loff_t *ppos)
 {
+	struct amdgpu_device *adev =
+		((struct seq_file *)file->private_data)->private;
+	struct amdgpu_mes *mes = &adev->mes;
+	bool enable;
+	int r;
+
+	r = kstrtobool_from_user(buf, count, &enable);
+	if (r)
+		return r;
 
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
index 5160b227943b..1cd02101f54e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -155,6 +155,24 @@ struct amdgpu_mes {
 	uint64_t			event_log_gpu_addr;
 	void				*event_log_cpu_addr;
 
+	/* MES firmware debug extension ("mes_dbgext") log buffer */
+	uint32_t			dbgext_log_size;
+	uint64_t			dbgext_log_options;
+	struct amdgpu_bo		*dbgext_log_gpu_obj;
+	uint64_t			dbgext_log_gpu_addr;
+	void				*dbgext_log_cpu_addr;
+	bool				dbgext_use_irq;
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
 
@@ -371,7 +389,8 @@ enum mes_misc_opcode {
 	MES_MISC_OP_WRM_REG_WR_WAIT,
 	MES_MISC_OP_SET_SHADER_DEBUGGER,
 	MES_MISC_OP_CHANGE_CONFIG,
-	MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
+	MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE,
+	MES_MISC_OP_SETUP_MES_DBGEXT,
 };
 
 struct mes_misc_op_input {
@@ -426,6 +445,11 @@ struct mes_misc_op_input {
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
 
@@ -451,6 +475,13 @@ struct amdgpu_mes_funcs {
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
 
@@ -518,6 +549,10 @@ void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev);
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);
 
+int amdgpu_mes_dbgext_start(struct amdgpu_device *adev);
+void amdgpu_mes_dbgext_stop(struct amdgpu_device *adev);
+void amdgpu_mes_dbgext_notify(struct amdgpu_device *adev, u32 context_data);
+
 int amdgpu_mes_suspend(struct amdgpu_device *adev, u32 xcc_id);
 int amdgpu_mes_resume(struct amdgpu_device *adev, u32 xcc_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a447562977ab..0ecfc0991e1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6530,6 +6530,18 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 
 	DRM_DEBUG("IH: CP EOP\n");
 
+	/*
+	 * MES firmware debug-extension ("mes_dbgext") messages are delivered as
+	 * an EOP interrupt from the MES pipe (me 3), carrying MES_DBGMSG (type 7)
+	 * in the top 6 bits of the context word.  Route them to the mes_dbgext
+	 * drain instead of the (gfx/compute) EOP fence handling below.
+	 */
+	if (((entry->ring_id & 0x0c) >> 2) == 3 &&
+	    (entry->src_data[0] >> 26) == 7) {
+		amdgpu_mes_dbgext_notify(adev, entry->src_data[0]);
+		return 0;
+	}
+
 	if (!adev->gfx.disable_kq) {
 		u8 me_id = (entry->ring_id & 0x0c) >> 2;
 		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 33ff1afd7c4c..f507e8ada3fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -966,6 +966,13 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
 		misc_pkt.queue_sch_level = AMD_PRIORITY_LEVEL_NORMAL;
 		break;
+	case MES_MISC_OP_SETUP_MES_DBGEXT:
+		misc_pkt.opcode = MESAPI_MISC__SETUP_MES_DBGEXT;
+		misc_pkt.dbgext_init_data.dbg_ext_mc_addr =
+				input->setup_mes_dbgext.log_buffer_mc_addr;
+		misc_pkt.dbgext_init_data.u64_all =
+				input->setup_mes_dbgext.log_options;
+		break;
 	default:
 		drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d)\n", input->op);
 		return -EINVAL;
@@ -1132,6 +1139,32 @@ static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+/*
+ * Enable/disable delivery of the MES firmware host interrupts at the CP.  The
+ * MES firmware debug-message interrupt is delivered as a CP EOP from the MES
+ * pipe (me 3) and handled in gfx_v11_0_eop_irq(); it is gated by CPC_INT_CNTL
+ * in that ME/pipe context, selected via GRBM_GFX_CNTL.  Mirrors the Windows KMD
+ * MES interrupt-enable path.  Must run in process context (takes srbm_mutex).
+ */
+static int mes_v11_0_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable)
+{
+	struct amdgpu_device *adev = mes->adev;
+	u32 cp_int_cntl;
+
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
+
+	cp_int_cntl = RREG32_SOC15(GC, 0, regCPC_INT_CNTL);
+	cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CPC_INT_CNTL,
+					TIME_STAMP_INT_ENABLE, enable ? 1 : 0);
+	WREG32_SOC15(GC, 0, regCPC_INT_CNTL, cp_int_cntl);
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	return 0;
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -1140,6 +1173,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.suspend_gang = mes_v11_0_suspend_gang,
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
+	.enable_dbgext_irq = mes_v11_0_enable_dbgext_irq,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
 	.detect_and_reset_hung_queues = mes_v11_0_detect_and_reset_hung_queues,
 };
@@ -2037,6 +2071,8 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.kiq[0].ring.sched.ready = false;
 	adev->mes.ring[0].sched.ready = true;
 
+	amdgpu_mes_dbgext_start(adev);
+
 	return 0;
 
 failure:
@@ -2046,6 +2082,9 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+
+	amdgpu_mes_dbgext_stop(adev);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index a8e6ccc7817c..e251ccc41f9c 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -622,6 +622,7 @@ enum MESAPI_MISC_OPCODE {
 	MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
 	MESAPI_MISC__CHANGE_CONFIG,
 	MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+	MESAPI_MISC__SETUP_MES_DBGEXT,
 
 	MESAPI_MISC__MAX,
 };
@@ -702,6 +703,22 @@ struct CHANGE_CONFIG {
 	} tdr_config;
 };
 
+/*
+ * MES firmware debug extension ("mes_dbgext"): the driver hands the MES a
+ * GART/GTT log buffer; the MES firmware writes text/binary log items into a
+ * circular, zone-partitioned buffer that the driver drains and prints.
+ */
+struct MES_DBGEXT_INIT_DATA {
+	uint64_t dbg_ext_mc_addr;
+	union {
+		struct {
+			uint64_t trigger_interrupt_per_new_msg : 1;
+			uint64_t reserved : 63;
+		};
+		uint64_t u64_all;
+	};
+};
+
 union MESAPI__MISC {
 	struct {
 		union MES_API_HEADER	header;
@@ -717,6 +734,7 @@ union MESAPI__MISC {
 			struct		SET_SHADER_DEBUGGER set_shader_debugger;
 			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
 			struct		CHANGE_CONFIG change_config;
+			struct		MES_DBGEXT_INIT_DATA dbgext_init_data;
 
 			uint32_t	data[MISC_DATA_MAX_SIZE_IN_DWORDS];
 		};
-- 
2.43.0

