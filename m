Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC02CD6E6D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054C4112852;
	Thu,  4 Jun 2026 14:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yjDhiWIc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF57D112852
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9X5u9R/K5w+TF2+Oyfzv7si2YE93+i2K7TFK+qT3dLxbSk5oaZmFobFQBNlZ8Jot8aK76WbgvC1i2dV5tVdcwgKUGovvEbiWSY2D4d3b48Z443s4HernL22XgAHoX4CCxgmImVg8O+kvXRH0zGpacHTGv5jUNUjLh7/zTzkiEAKz73/QXOT/XgwHLOYJpf4+VCX3Y307kkU25Ay6kEog65DYaZdyeh4LggX+3NP7PnXU5tFUbMWaae9YKzAxiMo09QyJznttfvZGTsSDjwG66gv4kOoXMFEStmQ0rg10FQnXXE5XwoEOAGEBp2EATOyuSTYIaor1PShy8+3KeDUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0s6+2vqeMtebnG0OuGxohp+YsnCnPgSR6tFNxXZBe0=;
 b=MpBLNzAhAKueSKUVIMQDgSLLmEt5dKhJZOs7C7McMl/RwHhXB/gG9fqSgSGpFiLCPEEhxFV3ZeJ5Olr5cnmaLc+3uRG3qfpxB8QmCa9QV5VG/+riqz0BD6WUkcvCat3L0PglQsa0TdPXIH27fR8uxnI2u8IcCaQoB6Xxc6l3gFBnDBRHPD01xJOnXLgCkdks0klSYMkFWYOfu5R770pnKeurbLyP4bXwqHf0OhLzPyHKKPdmHNV53uTqNJxMIjAu1vPNeI3m4rZ0Vi7H+CzTuTaTs2LygtSYL30w7HkrbV051x8XCqMNd3UcJQba6vd9nSZfqqc70FcvEwj9hF3lbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0s6+2vqeMtebnG0OuGxohp+YsnCnPgSR6tFNxXZBe0=;
 b=yjDhiWIcBL/QRmLJJJ0LH3Xa8sS59Ojm1yBmzv25PC7dgmgpLP93S7TcmXz3MVESFntj+Ygpg7UWHVVrpVa/S3MBdAdp93YX9XXzIicFH3m0V5vR4ERYo8pMi4Z2POY9sUX4oMxqkLLZ7ZzRNc4CzcqRSjXBvykGxeXYYiSfolw=
Received: from BL1PR13CA0387.namprd13.prod.outlook.com (2603:10b6:208:2c0::32)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:55:27 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::7f) by BL1PR13CA0387.outlook.office365.com
 (2603:10b6:208:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 14:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:09 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:08 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH 21/24] drm/amd/display: Retry link detection on hotplug
Date: Thu, 4 Jun 2026 10:52:15 -0400
Message-ID: <20260604145428.809959-22-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5e9d8a-370d-4c9c-0b73-08dec2494f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: UwmA4utSAdSV6MU0uL85Vf2b+mLk3kZo8QjxpLBFE41PO5Fev6j5mnSbVZhcaLnu+CGehd4n65PC5BDIVC5qADPY4/W383xZwZSCMJ1NYvtb2qcLC4u1/P6PRDs8sLFNupxutlxpgLRNKwJNhchGT8bDvB/qrvow5uuIXUORgaCf0gF61IK7llkqEmR9XudyHvlqNPEx1ijAFSNRQP5FhVwkPTWi2GDXwXRIfY25sGpvXn2+Cxh4eYsMW+W1kWBHTDlnQh8VOvMdnnz7iboD4J9v6iPv/hBFmuaj7L90lqZCCPJdrZR8caSQBIurCOP09Sa6tJbDtHFm+JK3/3sLyWrYlKustc7wxnOviDzN9yDc6X4bfqUBLHYEGM3P1QCHEIR29hwIZiqDthHRswIsnc6fNba5KlKteFlNUq7cYbdD7hzBPGzqPDzNDRAr8AllxQbfpNPGqQE8c9IchNw3lvf4robV8B0BTsycFMDt5+9a9Ppe/FPFnng/ZxoxXQWbF2G3yLT/wLIgb9mvhmumSDZpTDIo+2eHqJroj9ltmGfJoDeWPaHcPYJqZ7bezIwLs+640g+bfUAtbyMBj8L5Undim7qJq14s/mtxbINoEpa8aa0J5Imseh71Jby4utnnGH7RIFLtIFwi/aTVsviM9dT/AJ/mOgt24diClh0F/sshNnFNrO9MciM6C+Hw3TpUcOUL7z+T33Ry+8QYbNCJEV49t3Hn05BXSKecxZUrKgw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7WcCjfrCse/L0SKwnTFZfVgdNjUnMbyupGDO1wRDL4ldoToXanVB7Ydh3nO1Ivf2Z/c/quDfKaqBMfkJ7Crig/epDT/HSSD0AyjruvgEmIfK7yNgfzigM4ur/ie91FguKPE2Y04JBYYpHOu217gT2AoKKGLln3fwWuGpkyfMd89lMayHguLMclWc5EcJuV7o0wy2HjwHnFZwDJQnk4kJ9Es5OPzC1uSxR6mpOiJlQbwEN3dnohenXSO/jwkPpRl4B2uwtZ++9pGis/1HzyCMSnALiEYG9492oMQti9lv8Oo/RUmsNctPVJkbWvOWY0dOJ0cXgRnGAqRVr29eJ+c+hZovv7nSQZptMt+tDFqQ1wJGxbLEN4/d+wG9c/2iA/seyBdUPGJyDetq3torUo0qnM5uqddFSjwsMkFyDn0CVZ7mSNc+AvzMSOWD4TgZ36KC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:24.9315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5e9d8a-370d-4c9c-0b73-08dec2494f2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
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

From: Timur Kristóf <timur.kristof@gmail.com>

When dc_link_detect_connection_type thinks that a display is
connected, but dc_link_detect failed, enqueue delayed work to
retry the link detection again.

Useful when eg. HPD pin is high but the display isn't ready and
didn't respond to DDC.

- The display is "slow to wake up", ie. DDC isn't ready,
  for example we couldn't read EDID. Can happen with any
  connector type with certain "slow" displays.
  Some displays may take up to 15~20 sec or more to wake up.

- On hotplug, the HPD pin may make contact before the DDC pins,
  so we couldn't read the EDID. This most often happens with
  DVI connectors, rarely with HDMI. It is not impossible but
  extremely rare with other connector types.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 138 ++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  16 ++
 2 files changed, 154 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d1b1eb67d937..40295a5edbec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -161,6 +161,17 @@ MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
 #define FIRMWARE_DCN_42B_DMUB "amdgpu/dcn_4_2_1_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
 
+/**
+ * define AMDGPU_DM_HPD_MAX_NUM_RETRIES - maximum amount of retries for hotplug detection
+ */
+#define AMDGPU_DM_HPD_MAX_NUM_RETRIES 5
+
+/**
+ * define AMDGPU_DM_HPD_RETRY_DELAY_MSEC - millisecond delay between hotplug detection retries
+ */
+#define AMDGPU_DM_HPD_RETRY_DELAY_MSEC 1500
+
+
 /**
  * DOC: overview
  *
@@ -959,6 +970,125 @@ static void dm_handle_hpd_work(struct work_struct *work)
 
 }
 
+/**
+ * dm_handle_delayed_hpd_work() - Handle delayed HPD (hotplug detection)
+ *
+ * @w: Base work item structure
+ *
+ * Used for retrying HPD after a delay. Just calls the normal HPD helper.
+ */
+static void dm_handle_delayed_hpd_work(struct work_struct *work)
+{
+	struct delayed_work *dw = container_of(work, struct delayed_work, work);
+	struct delayed_hpd_work *w = container_of(dw, struct delayed_hpd_work, work);
+	struct amdgpu_dm_connector *aconn = w->aconn;
+	enum dc_detect_reason reason = w->reason;
+
+	kfree(w);
+	handle_hpd_irq_helper(aconn, reason);
+}
+
+/**
+ * dm_cancel_delayed_hpd_work() - Cancel pending hotplug detection work for a connector
+ *
+ * @aconnector: Connector on which the HPD event occurred
+ */
+static void dm_cancel_delayed_hpd_work(struct amdgpu_dm_connector *aconnector)
+{
+	if (!aconnector || !aconnector->delayed_hpd_work)
+		return;
+
+	cancel_delayed_work(&aconnector->delayed_hpd_work->work);
+	aconnector->delayed_hpd_work = NULL;
+}
+
+/**
+ * dm_cancel_all_delayed_hpd_work() - Cancel all pending hotplug detection work on the device
+ *
+ * @dev: DRM device pointer
+ */
+static void dm_cancel_all_delayed_hpd_work(struct drm_device *dev)
+{
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		dm_cancel_delayed_hpd_work(to_amdgpu_dm_connector(connector));
+	}
+	drm_connector_list_iter_end(&iter);
+}
+
+/**
+ * dm_queue_delayed_hpd_work() - Enqueue delayed work to handle hotplug detection
+ *
+ * @aconnector: Connector on which the HPD event occurred
+ * @reason: Reason why we are attempting the HPD
+ * @msecs: Millisecond delay after which the delayed work is going to happen
+ *
+ * When dc_link_detect_connection_type thinks that a display is connected,
+ * but dc_link_detect failed, enqueue delayed work to retry the link
+ * detection again.
+ *
+ * Useful when eg. HPD pin is high but the display isn't ready and
+ * didn't respond to DDC.
+ *
+ * - On boot or suspend/resume, the display is "slow to wake up",
+ *   ie. DDC isn't ready, for example we couldn't read DP link caps or EDID.
+ *   Can happen to any connector with certain "slow" displays.
+ *
+ * - On hotplug, the HPD pin may make contact before the DDC pins,
+ *   so we couldn't read the EDID. Can happen to any connector but
+ *   most often to DVI and sometimes to HDMI (rarely to DP).
+ *
+ */
+static void dm_queue_delayed_hpd_work(struct amdgpu_dm_connector *aconnector,
+				      const enum dc_detect_reason reason,
+				      const unsigned int msecs)
+{
+	struct drm_device *dev = aconnector->base.dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct delayed_hpd_work *w;
+
+	if (!aconnector || !aconnector->dc_link ||
+	    aconnector->dc_link->type == dc_connection_none)
+		return;
+
+	/* Don't retry polled connectors, the polling is going to detect it. */
+	if (aconnector->base.polled != DRM_CONNECTOR_POLL_HPD)
+		return;
+
+	++aconnector->num_hpd_retries;
+
+	drm_dbg(dev, "Can't detect link on %s on try %d\n",
+		aconnector->base.name, aconnector->num_hpd_retries);
+
+	if (aconnector->num_hpd_retries > AMDGPU_DM_HPD_MAX_NUM_RETRIES) {
+		drm_warn(dev, "Too many retries on %s: %d, giving up\n",
+			 aconnector->base.name, aconnector->num_hpd_retries);
+		aconnector->num_hpd_retries = 0;
+		return;
+	}
+
+	w = kzalloc(sizeof(*w), GFP_ATOMIC);
+
+	if (!w)
+		return;
+
+	INIT_DELAYED_WORK(&w->work, dm_handle_delayed_hpd_work);
+	w->aconn = aconnector;
+	w->reason = reason;
+	aconnector->delayed_hpd_work = w;
+
+	drm_warn(dev, "Enqueueing next retry on %s\n",
+		 aconnector->base.name);
+	queue_delayed_work(adev->dm.delayed_hpd_wq, &w->work,
+			   msecs_to_jiffies(msecs));
+}
+
 static const char *dmub_notification_type_str(enum dmub_notification_type e)
 {
 	switch (e) {
@@ -3249,6 +3379,7 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	dm_cancel_all_delayed_hpd_work(&adev->ddev);
 	amdgpu_dm_hpd_fini(adev);
 
 	amdgpu_dm_irq_fini(adev);
@@ -3422,6 +3553,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
 
+	dm_cancel_all_delayed_hpd_work(&adev->ddev);
+
 	if (amdgpu_in_reset(adev)) {
 		enum dc_status res;
 
@@ -4451,6 +4584,9 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 			if (aconnector->base.force == DRM_FORCE_UNSPECIFIED ||
 			    reason == DETECT_REASON_HPDRX)
 				drm_kms_helper_connector_hotplug_event(connector);
+		} else {
+			dm_queue_delayed_hpd_work(aconnector, reason,
+						  AMDGPU_DM_HPD_RETRY_DELAY_MSEC);
 		}
 	}
 }
@@ -4459,6 +4595,8 @@ static void handle_hpd_irq(void *param)
 {
 	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
 
+	/* Cancel any pending work */
+	dm_cancel_delayed_hpd_work(aconnector);
 	handle_hpd_irq_helper(aconnector, DETECT_REASON_HPD);
 
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 7d37c1612131..9a66c9e2b78d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -136,6 +136,18 @@ struct dmub_hpd_work {
 	struct amdgpu_device *adev;
 };
 
+/**
+ * struct delayed_hpd_work - Handle delayed HPD (hot plug detection) work
+ *
+ * @work: Base structure, kernel work data for the work event
+ * @aconn: Pointer to connector where the HPD event happened
+ */
+struct delayed_hpd_work {
+	struct delayed_work work;
+	struct amdgpu_dm_connector *aconn;
+	enum dc_detect_reason reason;
+};
+
 /**
  * struct vblank_control_work - Work data for vblank control
  * @work: Kernel work data for the work event
@@ -801,6 +813,10 @@ struct amdgpu_dm_connector {
 	/* number of modes generated from EDID at 'dc_sink' */
 	int num_modes;
 
+	/* number of retries on hot plug detection */
+	int num_hpd_retries;
+	struct delayed_hpd_work *delayed_hpd_work;
+
 	/* The 'old' sink - before an HPD.
 	 * The 'current' sink is in dc_link->sink. */
 	struct dc_sink *dc_sink;
-- 
2.54.0

