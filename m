Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C38BC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 03:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0316D10F357;
	Thu,  9 Jul 2026 03:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nas5N6uY";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5E610F357
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 03:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVwh9INnt/cY/PhitREyq5sAXv4Eggf/KwucjAXVy+Zxrq5mx5DWIl6f/F50sUWwDQyYvCc8phWBNl9kUniUAHy/5EQWqy/Q66WDTbeFeQmBUDV2UZGeo/Y+xr3fjAOEiuwWkRhy1GRTxugNUk0oC6o/q/v+aUcRtyuxg1vTzbLcabt1OwCqlq88gCmDoT8oyqMchRBaHcluUPUkyPR4hgXWTuIL5Z73wuk/qDzDItUYAbf0vmYkaoYwCq74vSjUYr2oIE3xLJy/gIHWdbj5xvk07RBxS8dbPGm8SWGzJWwETeoVyGWzc1ZLCyBmIZqeh7PgYhGvmHa96B//SCmOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAsNOD6dg+kEYMZr5X/meTwiq7lZurT146h8KP+7ZfM=;
 b=Q4eUD50Nd/uXJv0IE6tRq2UbN91O6qoEPJSvLA7j8zrWbA3nILd0K0SBXXPr6uCH1MjNgMDhZaUZft+35Oh+XxvhW1OP7ial9rhLJief3p9IIglN31F2TC0qmD59Y6sR4H2ufCZQ5//CyF0MnfBVvcg+DIKp8LqeCIxkAwPEqp/SoqNr/H3DawvyddYpe2SvvTJ7Y5Hb9nzsHseFXHZC4aaeZ0HKHdzRhY6matrDxGVUrjZcBrdWOOCV5s1VibXSymG5pjXH6E8GJ9m9bTwa8dLStnnvzVMeYBFFDH0WtSsCqNrRyKd52HabuqIlfChwAL/ZySWOOnLO3j8pvEapTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAsNOD6dg+kEYMZr5X/meTwiq7lZurT146h8KP+7ZfM=;
 b=Nas5N6uYRyUNAcqmGFpw7mLN4BSVonPZGy7PzPIR0hV23tj8bMXblVnmeJCsMYp2jKUJnx4yA+UvZgmuU2l9ww2qYRH9yGndAQ9+vsVavk6b51Y7gdGVYNryUWl4bKOFXPrIpvV7FnAJb0NVnNboecWlMO25Gi7g4NOpI5ue33E=
Received: from DS7PR03CA0329.namprd03.prod.outlook.com (2603:10b6:8:2b::33) by
 PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.9; Thu, 9 Jul 2026 03:19:07 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::32) by DS7PR03CA0329.outlook.office365.com
 (2603:10b6:8:2b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 03:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 03:19:06 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 22:19:03 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <sunpeng.li@amd.com>, <Harry.Wentland@amd.com>, Geoffrey McRae
 <geoffrey.mcrae@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 2/2] drm/amd/display: Use unbound workqueues for deferred
 DM work
Date: Thu, 9 Jul 2026 13:18:35 +1000
Message-ID: <20260709031835.3395558-3-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709031835.3395558-1-geoffrey.mcrae@amd.com>
References: <20260709031835.3395558-1-geoffrey.mcrae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3a0a26-a53c-4bc1-d124-08dedd68d601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: vuaG6YO1+y0Fm/tyRvvZNeUJmhgkxEmnbLdJUfjpW+6ZoijshGf/6iH5HY4pThNRaa4ivT+AFhXfYESvHfn8s5YcwSEcVC6wFDXWd1bFYUWcepNKf/KTTOTQF2VM8o/Yjs9xGWlZNQaBx8+JTY44LVHE+KqWE0Oa/6VojtQ1uuFIyHDeVhlue+vshJD7O9VyyuL+8/jVzmeFmBetr03nQkXhXKTlnxZqZnYQtGhGcVZTnlZ+vnJ2906Z9d4Cb/uKqjbdfDcbp9z6oniSFsElu0lZFNTOlRbXgboJFse62UOyEI0xcv+dQqQWLfUkDgNNU84+MWzd4SULs5jHkK7kPEwl0FIoy7IopTXSISHMf5e53wg+zwFIa6m+7BF6+D9hjoRPx4zjS7AZ/TI0bHc6raAEdjw22bAsPvB2AltNRnmwGuAGyUSn0ysLGo2LxVsfU+zGHTDqlfSyyTdHMgQc0bsTE8aqT1j/7uBLc3UfGIUj0h4Qy1+eAZCfhjWccpLH5LGq+WSkYeD1wc/3PbzvINT1Yd9Zmbqxk6LCQ3S/PcPnv2hKrOoDtm9NdqS7iHl+T+w89JSXM7w83HW2/qlrKsZaWH6akq7g7q4v9aa1C82UCELNe/zihFpVnx/HbF9fYyn/j7KA6kUb+nmzzjsz0u054P7VqQxkjjPH+Gk3xOpieZ4D2N0H4BCdcbyODCr2WXD+9ynOKURzzLSQQXBSnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ETxDk4ecuKDsOOB+6ZjAyNUPm2f1l6swqDEbGiNXsb0bYUsSv6TIoZuU0lum92ox8FzGZw2f/sq4dVUA1x0AnrIkio93Hu18layPW26ZiV00IvzjWViW+RCEtfqucpQv1HyUYWPKNV4I7XpCIN+kXl4bLgj2NxwM4PDzT2NEafhQOewB5YyrMO6mQW0S+dfOY5sjD8slHJir4QxwYoCq4xUOpDuh8JNHAxzumJafmbFJIBL2hxm4mMMhwJN9ktbwdb0r0X5dsDcxT3i9yvHqwVlWgadJU2bZc1ENPBe1zcpBX8Psy2GdUQ7XtS4q6zRrMetZz69R8fXCH7rrLSYer2vThQbl5TJCgCxc/8DE7lQqjJ9DlhtliqX9h7hXF4VBFPAzcBHUABu80/MiH0Vv5LE70qCBX7RsQ2pEPafT3WrLr3PQWL6C+nqX/RQdgO2p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:19:06.9313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3a0a26-a53c-4bc1-d124-08dedd68d601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019
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

DM currently queues some deferred display work on system workqueues.
Low-context IRQ handlers are queued on system_highpri_wq, while deferred
vmin/vmax updates are queued on system_percpu_wq.

Both paths can execute long-running display work. HPD and HPD RX handling
may involve link detection, AUX transactions, connector state updates, and
hotplug notification. The vmin/vmax update path calls into DC under
dc_lock to adjust stream timing. These paths can therefore trigger the
workqueue CPU hog detector when run from per-CPU workers:

  workqueue: dm_irq_work_func [amdgpu] hogged CPU for >10000us
  workqueue: dm_handle_vmin_vmax_update [amdgpu] hogged CPU for >10000us

Move the deferred low-context IRQ work to a dedicated high-priority
unbound workqueue, preserving the priority of the previous
system_highpri_wq usage while avoiding long-running work on per-CPU
workers.

Move deferred vmin/vmax updates to a separate normal-priority unbound
workqueue.

High-context IRQ handlers remain unchanged and continue to run directly
from the IRQ path.

Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 +++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 31 +++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 909ee71d6d59..643d40dd6e20 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -324,6 +324,8 @@ struct hpd_rx_irq_offload_work {
  * @ddev: DRM base driver structure
  * @display_indexes_num: Max number of display streams supported
  * @irq_handler_list_table_lock: Synchronizes access to IRQ tables
+ * @irq_wq: Dedicated high-priority unbound workqueue for deferred IRQ work
+ * @vmin_vmax_wq: Dedicated unbound workqueue for deferred vmin/vmax updates
  * @backlight_dev: Backlight control device
  * @backlight_link: Link on which to control backlight
  * @backlight_caps: Capabilities of the backlight device
@@ -563,6 +565,8 @@ struct amdgpu_display_manager {
 	dmub_outbox_params[1];
 
 	spinlock_t irq_handler_list_table_lock;
+	struct workqueue_struct *irq_wq;
+	struct workqueue_struct *vmin_vmax_wq;
 
 	struct backlight_device *backlight_dev[AMDGPU_DM_MAX_NUM_EDP];
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 20fdf0578119..1df15f02615c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -397,6 +397,21 @@ int amdgpu_dm_irq_init(struct amdgpu_device *adev)
 
 	spin_lock_init(&adev->dm.irq_handler_list_table_lock);
 
+	adev->dm.irq_wq = alloc_workqueue("amdgpu_dm_irq",
+		WQ_UNBOUND | WQ_HIGHPRI, 0);
+
+	if (!adev->dm.irq_wq)
+		return -ENOMEM;
+
+	adev->dm.vmin_vmax_wq = alloc_workqueue("amdgpu_dm_vmin_vmax",
+		WQ_UNBOUND, 0);
+
+	if (!adev->dm.vmin_vmax_wq) {
+		destroy_workqueue(adev->dm.irq_wq);
+		adev->dm.irq_wq = NULL;
+		return -ENOMEM;
+	}
+
 	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
 		/* low context handler list init */
 		lh = &adev->dm.irq_handler_list_low_tab[src];
@@ -478,6 +493,16 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
 		list_del(&handler->list);
 		kfree(handler);
 	}
+
+	if (adev->dm.vmin_vmax_wq) {
+		destroy_workqueue(adev->dm.vmin_vmax_wq);
+		adev->dm.vmin_vmax_wq = NULL;
+	}
+
+	if (adev->dm.irq_wq) {
+		destroy_workqueue(adev->dm.irq_wq);
+		adev->dm.irq_wq = NULL;
+	}
 }
 EXPORT_IF_KUNIT(amdgpu_dm_irq_fini);
 
@@ -594,7 +619,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 		goto out_unlock;
 
 	list_for_each_entry(handler_data, handler_list, list) {
-		if (queue_work(system_highpri_wq, &handler_data->work)) {
+		if (queue_work(adev->dm.irq_wq, &handler_data->work)) {
 			work_queued = true;
 			break;
 		}
@@ -622,7 +647,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 
 		INIT_WORK(&handler_data_add->work, dm_irq_work_func);
 
-		if (queue_work(system_highpri_wq, &handler_data_add->work))
+		if (queue_work(adev->dm.irq_wq, &handler_data_add->work))
 			DRM_DEBUG("Queued work for handling interrupt from "
 				  "display for IRQ source %d\n",
 				  irq_source);
@@ -1882,7 +1907,7 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
 	offload_work->stream = stream;
 	offload_work->adjust = adjust_copy;
 
-	queue_work(system_percpu_wq, &offload_work->work);
+	queue_work(adev->dm.vmin_vmax_wq, &offload_work->work);
 }
 
 static void dm_vupdate_high_irq(void *interrupt_params)
-- 
2.43.0

