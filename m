Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E463DC43327
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 16:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826F710E9AC;
	Mon, 29 Jun 2026 16:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gmnT0ayC";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B1710E9AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 16:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbegJYHRISwxJ/HSwpktDPLnkZ2PGWU8NjEX+t6lJH9bWXf02/3mkU7mEeBkGm0OTlCeQ5GkJvgfkrxf91E1ya+CgVFFfU9NW+IoSIiXZFGINgWyEHl3aJo850fjl3Aakr6ecIHqDA3cos/nrlnKM6KstIvEDsipiXOIh/knRAua/49A6/kXBx97N0UjWz4fQK+GbGkrZKUmn8C1ZxhhJcZ6O1ddAVKfLnpBWGJc81/UTvOcUU41oKPxLPBvKsRgNUgTIGTNapi7CI/7MIWq2mc1fYUYx3W1qxDMw8YCkPV2qsjg+zSaaLaP9nWtlqR9OMMqT6wBlwDdScLdG+tSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKZg6pnCFXeLi412ZIxfXOcc8CDWaw+bw0OfLu2HZlw=;
 b=sVo7dba6dBVEozwOogIQMX81QPAyxLsHOJqDJVCysDda2BRiYDKrrj8oXyy90KCIzAW0/K9SRRUnBq3J8zzG8B6Y7pjX3wts6jZVGSHpiY8ZAXhb0RWk68THUJUr1AYndTRAudvo0DaCYx0HMZKeav95ORp2hu1VFHiXzV5+58xSzm1IPuwyRAcvCLabbTvcB+oyEk/rqrjqAFzwVWrb3lYex0LSEbinr0A9PDVJyS9Fc88g4LMRIqBN4u+pWrzEhwzxuQknwA3k9Y3Cg6tVdRNU98G03aPBL4+VucXIeB0YolMeoQ+hZ8iLi0THzORmrIa0+TTMzRAkCppBTD3l9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKZg6pnCFXeLi412ZIxfXOcc8CDWaw+bw0OfLu2HZlw=;
 b=gmnT0ayC0aIRy6RvccWwqYBeBZjiWnhRShdoQmWLTBU4bzc31B8j5GAbX/oOFbR1k/Pe/Xo3N79hU8/xbfKPkSAVnGJKSzEYfOH7SjL1wuRvol7FLOcm/j2AfzpHenCiYA5bHXlkDF1UBMgBZ42G27qHvbUI6A0B4Z30hX+6cqI=
Received: from SA1P222CA0142.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::24)
 by MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 16:51:46 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::a) by SA1P222CA0142.outlook.office365.com
 (2603:10b6:806:3c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 16:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 16:51:45 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 11:51:42 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 "Leo Li" <sunpeng.li@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Use unbound workqueues for deferred DM
 work
Date: Tue, 30 Jun 2026 02:51:29 +1000
Message-ID: <20260629165129.5550-2-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629165129.5550-1-geoffrey.mcrae@amd.com>
References: <20260629165129.5550-1-geoffrey.mcrae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7020d5-b903-417b-c021-08ded5feb476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: orv0x8BVaWGjwHG18ha2KVWiO6SNCPfobQ6ZUZ09z9jXDcbri3dDdcU115lG2Mb9CFGMy4D18QIETIA9fuo2+7sdkOuGMJBe07ui3Jo/b43pH69PUpkiRmDTqF1L3IMYCnUZeh0PlNvclx2WW//jC+1SjE1UAYbc9n7sT5RpS9oNwap/+22TjSPc/zzNyf0SYhYc7Gw/WDEjwW6zaALqBdemIHa+qtqf5Q3nYmSo+VyKbqX/KgjaXVtldyhBEzt5uJAB+WEIe6mY32HlsT8etMiNDwWHqspT7QEBvb5bTHPqp8omBqpyPgiJSJsDlWBGkuN02WHkerm6SkpTQ6rJ5h2P12yqyZ5AH4wEhUH+8Vu5mxJvWd4A2TF+tV09luDxglCdGogwSB9eKSg7QqPTeiON4sI570kAoW3u6yzZTxTW+JeaTX57YGrczpLPng0HlBxTX0oZiQWvjRg3nTuJ1MYO3N+FFWRa8s9F11K23Vf2Q2pTJVpWZbVsWjd1GL5GVOAFC3+VOmwPHgyTo+EReGxTW83lPELz4B50H4DjENeJ8qvmlXiNtYqkcoQAOsQsqhTsKJMOjYtxrucA+ozximd8TKSxUEeAVc6flcsTIYMJ0J7GO7eIQk14SWbtNZrtYgM1lVMs+vWYZKJd8G93bgbac4beBJyUPZZV0u3H50xAJfyJskTLNBfrczlhPFK6/IVa0OuVgd6w+qhuc2QStg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JiWaxgQIyNIKYf1SQYCOeTFWwi9Se9WwZaq+6Wnlm99Kcqy5+nvfybMTRYQ/I2qwWNrw5tfT3+5AoDsZmB05rfLsE28kjr/SfZXKH4MFra1ue465ydaLYNKqGy6qWJ16+e0gtin/kS7TvufC2C/rhW7dAgTjBS6VQRW+YsNbBQ93IiGiQGuMZBick3tacM9NLswHVMVp86JppfYm6MM8YwNzbLGDP/Xnpz4LOFWuDJ4KCALvAJpC69MC+AswK6n5/Rp7OyeDPPdCf+YkVdVvpJAV6u+KMsilHUJkgbqV0n23N+nygH7vKMGDUFn/+F9OfQuh4ZWZ1NjTuCpHze8cmtgR80Gp9vECHk9mnqQpD3CdVrIeCxD0+n2dMnfu8aEj7dCwW/FoSNh2hUXhHAjOewlTJhMzhS3k1hsFaizXD/WYmomQYYoJfzTTCCVwVotB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 16:51:45.8623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7020d5-b903-417b-c021-08ded5feb476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190
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
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 34 +++++++++++++++++--
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 88687a7e01a5..4a7965f76acb 100644
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
@@ -565,6 +567,8 @@ struct amdgpu_display_manager {
 	dmub_outbox_params[1];
 
 	spinlock_t irq_handler_list_table_lock;
+	struct workqueue_struct *irq_wq;
+	struct workqueue_struct *vmin_vmax_wq;
 
 	struct backlight_device *backlight_dev[AMDGPU_DM_MAX_NUM_EDP];
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 3a5de9364ed1..f4bfd7e42f9a 100644
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
@@ -491,6 +506,16 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
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
 
@@ -610,11 +635,14 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 	if (READ_ONCE(adev->dm.irq_fini_in_progress))
 		goto out_unlock;
 
+	if (!adev->dm.irq_wq)
+		goto out_unlock;
+
 	if (list_empty(handler_list))
 		goto out_unlock;
 
 	list_for_each_entry(handler_data, handler_list, list) {
-		if (queue_work(system_highpri_wq, &handler_data->work)) {
+		if (queue_work(adev->dm.irq_wq, &handler_data->work)) {
 			work_queued = true;
 			break;
 		}
@@ -642,7 +670,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 
 		INIT_WORK(&handler_data_add->work, dm_irq_work_func);
 
-		if (queue_work(system_highpri_wq, &handler_data_add->work))
+		if (queue_work(adev->dm.irq_wq, &handler_data_add->work))
 			DRM_DEBUG("Queued work for handling interrupt from "
 				  "display for IRQ source %d\n",
 				  irq_source);
@@ -1905,7 +1933,7 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
 	offload_work->stream = stream;
 	offload_work->adjust = adjust_copy;
 
-	queue_work(system_percpu_wq, &offload_work->work);
+	queue_work(adev->dm.vmin_vmax_wq, &offload_work->work);
 }
 
 static void dm_vupdate_high_irq(void *interrupt_params)
-- 
2.43.0

