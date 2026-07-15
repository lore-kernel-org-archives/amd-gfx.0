Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEDDC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 15:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15CFD10E1C0;
	Wed, 15 Jul 2026 15:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cKEn57jJ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010016.outbound.protection.outlook.com
 [40.93.198.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590D910E1A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 15:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0PYZje0QiEO+iQMSYJuFCxv27ljNBL1/cGxxBjK3a6LbrSiWVbbU1CHTaMzmasQ6erm8RWZ+xiL6dL7+l4vSnzOo0E2SV+Usvn52fI5qd5FAz+xrM+ZoQeZ+wHWzHWgyNmiVc2UhmMrEPoHKNpWPuSBMSS/sX4wkXj/9gj+mmG8nXNRKt2EkU1ty2qVfxI3p3UBqLypK175DyS5c2XLgeU2i8tEhj+Iu19mIIDndm13tO6DXshIS2FjacrBZvocPf82eZ6E8FI7y0uNhK+6kuOZ5L7Hi8ddBARiAfAjvw3EWO+VlPhjrZKdpd4lzXHavtlqdT0dDdtT80Q+SQaPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TWdJTIWT9m38wN4o+6r3cWkVrkd3xzAEINfYjvWfTI=;
 b=ItfKboN7xcTF764plBP+eR6pcDt0xeA9d2EQhHFhuAUoakpqdU51dSCAgWvAsxV7ZaK+AfcLC71RvEuMQsqFuczKdguAFuZr7fGF46aw4Tg5iCc3HYpwIbpWPybkGc0fmGRUCNevuLJRDTaXPgklkr4v0OD+qMr44FDVfgjpmzjbrsq7XKByPXmtV3LwSaKf5uG5O/tTPZRMYr3eHHgoF8oaZ3ko2AFrq59TjNJQarP7pRFtDkPp+d5VFLpKZE8MdVey8wp5TeiRxZVmlT7Gv89nvCpfYgcq0BEr7HZgOkNbZ4lk30Wsdvpwpv8Eo8EAygUoHrWyeZZCgl+MqJQkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TWdJTIWT9m38wN4o+6r3cWkVrkd3xzAEINfYjvWfTI=;
 b=cKEn57jJx7p751+9bIsBYWic4kIzqwfcgE/LU9J3f+iC+ZtZBKUs1egVFzse0RBFI1SOPN0xE8Ln1ENDvV9dBvqNmb/LRx0J7WggIDtPgmAA22RRebMXdwF8fXldeUw2t9NH0UQOCv+d+e98kPoEVOjSSSCkPzmUdGFS0RMj3G0=
Received: from BL1P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::33)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Wed, 15 Jul
 2026 15:19:50 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::5) by BL1P221CA0007.outlook.office365.com
 (2603:10b6:208:2c5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Wed, 15
 Jul 2026 15:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 15:19:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 10:19:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 10:19:48 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 10:19:48 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Nick Haghiri <nick@haghiri.net>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
Subject: [RFC PATCH] drm/amd/display: extend HPD debounce to DVI/DP SST with
 per-EDID policy
Date: Wed, 15 Jul 2026 11:19:35 -0400
Message-ID: <20260715151935.2060107-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c0e2c5-28ff-4f58-bf5c-08dee28482e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|3023799007|56012099006|18002099003|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: LGb/2VxlAvBCck61+l+tklLejn59ZrrtIHTfMnT+8FEEplWgP7iKdgyTzXp0kZeTm58IqfoPN7kC0D8Hs7ZFkrX1/Sehpez7Cjje04XBo4y0yiDrpZEhHpeCBCedAPCnK9weKfv8NluXJZi+rSDvesX8GVN2w32aHMKBDFNRIFpQlWK3RE2equGZePSFZ4KkTJO+0lJjjYNBxZngrtY2uVmoIPbElm8QOay9ifdzc0Qat2YYOQWl/l+cNLBkXcZmYtSM/sqtzLcSNk07Y9MSsTOd90DFhhBWB4zIv9C180hpIZJ/okGnD3FqSosHimsm5D2zBoigM4+6ol1gAxPcep+y/3MHQpwvjW6vsw11gbZ6xB9HTXbduNPdYt8EAG+qCCFCKlXK37ZemZVa7++EDZoN5Iiq0wfHmtT2PRr7NPDWpgQwNOKfdEoHAzsGvBvYvk/bU/t/l2zK4zxFuq0zjsplY/zhOeBj8piA0Nv9Mihebl8NI4K+RZ5wzDlFRyd2YxwcNQSQQF0r+z5UUKUf013xguCulIWjCXlFLlhB/1hjpPe8o7RhO7fGGndDtv+QYxNLZO6YxpHcoL9gCktkLTn1Bwrui6s+Z7f3zveloFG6cEUsz0LjrIef8lgeWnVT3lfqlz9SreIdnHv/UTTUNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(3023799007)(56012099006)(18002099003)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yb7mPvGVbwN1RNDt6zS7MvNUq7K7NN61HS6TI3ykkvduiurpwwS0tiNXH205myL/DQutd2S5WfsDHFBz4gDwnaLQ9gXPI5WnaLz4PD6kkDVoNTlurV61B3JVn8xbjDfpNtG6aB1ys9urZjP5gex3j7CM+fryKyhSA/LbjgeinmMgCVBpPTH3CHoShMXsAkSBxDsPMyXFk7phO7mFOjHAzZz9cfd4rLOYCBRlbYMn6Bm/l93ZMtP0sHBRDCI6vJjejs8d7nJSnfHd0QVTQR+v4xwykM93Zn/Avu75LR2w5GbSMR4AbTwXwl98N4rHi8GioyHriNqo0SP9m7s7a5XepedXAp5hTeMzfecrRTkZl5bGtfHQzaFn0lB90IRc5nX1Sljt/P1JLyjMO1Wsgl9zubLQkaiQNy3oiSjMTDG2UmYhiQho/0mcNKWwzkWt4x0/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 15:19:49.2548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c0e2c5-28ff-4f58-bf5c-08dee28482e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
Some sinks perform rapid "autoscan" HPD re-assertions right after a
disconnect or when entering a power saving mode. These appear as a quick
disconnect->reconnect with an identical EDID. Since there is no HPD
filter, these quick reconnects are seen as hotplug events, which can
unintentionally wake a system with DPMS off.

An example: https://gitlab.freedesktop.org/drm/amd/-/issues/2876

The existing debounce only covered HDMI and used a single connector-wide
delay driven by the module parameter. However, a monitor that needs a
debounce delay on HDMI may not need one on DisplayPort (and vice versa),
so the delay should be differentiated per connector type. Well-behaved
monitors should also carry no debounce cost or regression risk by
default.

[How]
- Extend HPD debounce eligibility to HDMI, DVI, and DisplayPort SST, and
rename the shared connector fields, work, and cached sink from hdmi_* to
generic hpd_*. eDP and MST remain intentionally excluded.

- Move the per-monitor delay into struct dc_panel_patch as two fields,
hdmi_hpd_debounce_delay_ms and dp_hpd_debounce_delay_ms, so a delay can
be set for a specific monitor and specific connector type via
apply_edid_quirks().

- Add a quirk for the MSI MPG 274U
(drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0)) that enables a 1500ms
DP debounce (experimentally chosen a while ago), leaving HDMI untouched.

- Rework the amdgpu_hpd_debounce_delay_ms module parameter into a tristate
policy:
 - -1 = auto (default): debounce only known-problematic panels via EDID
        quirks, using the per-panel, per-connector-type delay
 -  0 = force off on all connectors (ignores EDID quirks)
 - >0 = force on for all eligible connectors, using this delay in ms

Auto keeps debounce targeted to quirked panels; explicit enable/disable to
be used for triaging.

- Factor the eligibility and policy decision into a hpd_debounce_delay_ms()
helper that returns the resolved delay (or 0 to skip), keeping
handle_hpd_irq_helper() readable.

Signed-off-by: Nick Haghiri <nick@haghiri.net>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>

---
Initially Nick proposed expanding HPD Debounce to non-HDMI connectors, so
adding Nick's SOB.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  22 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  12 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  31 +++---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 104 ++++++++++++------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 8 files changed, 116 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f5d65bd0ac25..5119b5188770 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -266,7 +266,7 @@ extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
 extern int amdgpu_ptl;
 
-extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
+extern int amdgpu_hpd_debounce_delay_ms;
 
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5362705143bc..a7873a3191cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -245,7 +245,7 @@ int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
 int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
-uint amdgpu_hdmi_hpd_debounce_delay_ms;
+int amdgpu_hpd_debounce_delay_ms = -1; /* auto */
 int amdgpu_ptl = -1; /* auto */
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
@@ -1104,14 +1104,22 @@ MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disab
 module_param_named(user_queue, amdgpu_user_queue, int, 0444);
 
 /*
- * DOC: hdmi_hpd_debounce_delay_ms (uint)
- * HDMI HPD disconnect debounce delay in milliseconds.
+ * DOC: hpd_debounce_delay_ms (int)
+ * HDMI/DVI/DP SST HPD disconnect debounce policy. eDP and MST are not affected.
  *
- * Used to filter short disconnect->reconnect HPD toggles some HDMI sinks
- * generate while entering/leaving power save. Set to 0 to disable by default.
+ * Some sinks briefly toggle HPD (a quick disconnect->reconnect with an
+ * identical EDID) when entering/leaving power save. Since there is no HPD
+ * filter, these are seen as hotplug events and can wake a DPMS-off system.
+ * Debounce coalesces them by delaying disconnect processing and comparing the
+ * EDID after the delay.
+ *
+ * - -1 = auto (default): debounce only known-problematic panels via EDID
+ *        quirks, using a per-panel, per-connector-type delay
+ * -  0 = force off on all connectors (ignores EDID quirks)
+ * - >0 = force on for all eligible connectors, using this delay in milliseconds
  */
-MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
-module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
+MODULE_PARM_DESC(hpd_debounce_delay_ms, "HDMI/DVI/DP SST HPD disconnect debounce delay in milliseconds (-1 = auto/per-EDID-quirk (default), 0 = force off, >0 = force on with this delay, 1500 is common)");
+module_param_named(hpd_debounce_delay_ms, amdgpu_hpd_debounce_delay_ms, int, 0644);
 
 /**
  * DOC: ptl (int)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f396803d1485..e6b13ee82a8c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -61,9 +61,9 @@ enum amd_vsdb_panel_type {
 #define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
 
 /*
- * Maximum HDMI HPD debounce delay in milliseconds
+ * Maximum HDMI/DVI/DP SST HPD debounce delay in milliseconds
  */
-#define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
+#define AMDGPU_DM_MAX_HPD_DEBOUNCE_MS 5000
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
@@ -884,10 +884,10 @@ struct amdgpu_dm_connector {
 	enum adaptive_sync_type as_type;
 	struct amdgpu_hdmi_vsdb_info vsdb_info;
 
-	/* HDMI HPD debounce support */
-	unsigned int hdmi_hpd_debounce_delay_ms;
-	struct delayed_work hdmi_hpd_debounce_work;
-	struct dc_sink *hdmi_prev_sink;
+	/* HDMI/DVI/DP SST HPD debounce support */
+	int hpd_debounce_override;
+	struct delayed_work hpd_debounce_work;
+	struct dc_sink *hpd_prev_sink;
 
 	/* HDMI compliance automation */
 	bool hdmi_comp_auto;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 16e157f4bd10..ff5a33991d35 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1806,13 +1806,11 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	if (aconnector->mst_mgr.dev)
 		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
 
-	/* Cancel and flush any pending HDMI HPD debounce work */
-	if (aconnector->hdmi_hpd_debounce_delay_ms) {
-		cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
-		if (aconnector->hdmi_prev_sink) {
-			dc_sink_release(aconnector->hdmi_prev_sink);
-			aconnector->hdmi_prev_sink = NULL;
-		}
+	/* Cancel and flush any pending HPD debounce work */
+	cancel_delayed_work_sync(&aconnector->hpd_debounce_work);
+	if (aconnector->hpd_prev_sink) {
+		dc_sink_release(aconnector->hpd_prev_sink);
+		aconnector->hpd_prev_sink = NULL;
 	}
 
 	if (aconnector->bl_idx != -1) {
@@ -2896,17 +2894,16 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	mutex_init(&aconnector->handle_mst_msg_ready);
 
 	/*
-	 * If HDMI HPD debounce delay is set, use the minimum between selected
-	 * value and AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS
+	 * Global HPD debounce policy from the module parameter:
+	 *   < 0 : auto  -> per-panel decision via EDID quirks
+	 *   = 0 : force off on all connectors (ignores quirks)
+	 *   > 0 : force on for all eligible connectors (clamped to the maximum)
 	 */
-	if (amdgpu_hdmi_hpd_debounce_delay_ms) {
-		aconnector->hdmi_hpd_debounce_delay_ms = min(amdgpu_hdmi_hpd_debounce_delay_ms,
-							     AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS);
-		INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, amdgpu_dm_hdmi_hpd_debounce_work);
-		aconnector->hdmi_prev_sink = NULL;
-	} else {
-		aconnector->hdmi_hpd_debounce_delay_ms = 0;
-	}
+	aconnector->hpd_debounce_override = amdgpu_hpd_debounce_delay_ms > 0 ?
+		min(amdgpu_hpd_debounce_delay_ms, AMDGPU_DM_MAX_HPD_DEBOUNCE_MS) :
+		amdgpu_hpd_debounce_delay_ms;
+	aconnector->hpd_prev_sink = NULL;
+	INIT_DELAYED_WORK(&aconnector->hpd_debounce_work, amdgpu_dm_hpd_debounce_work);
 
 	dm->hdmi_frl_status_polling_delay_ms = 200;
 	INIT_DELAYED_WORK(&dm->hdmi_frl_status_polling_work, hdmi_frl_status_polling_work);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 30ac1f32fad5..3596766bb843 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -137,6 +137,12 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		drm_dbg_driver(dev, "Skip PHY SSC reduction on panel id %X\n", panel_id);
 		link->wa_flags.skip_phy_ssc_reduction = true;
 		break;
+	/* Workaround for monitors that toggle HPD on DisplayPort entering deep sleep */
+	case drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0):
+		drm_dbg_driver(dev, "Enabling DP HPD debounce on panel id %X\n", panel_id);
+		edid_caps->panel_patch.dp_hpd_debounce_delay_ms =
+			min(1500U, AMDGPU_DM_MAX_HPD_DEBOUNCE_MS);
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index ae3f81f53074..f6eece130987 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1258,13 +1258,13 @@ EXPORT_IF_KUNIT(are_sinks_equal);
 
 
 /**
- * DOC: amdgpu_dm_hdmi_hpd_debounce_work
+ * DOC: amdgpu_dm_hpd_debounce_work
  *
- * HDMI HPD debounce delay in milliseconds. When an HDMI display toggles HPD
+ * HDMI/DVI/DP SST HPD debounce delay in milliseconds. When a display toggles HPD
  * (such as during power save transitions), this delay determines how long to
  * wait before processing the HPD event. This allows distinguishing between a
- * physical unplug (>hdmi_hpd_debounce_delay)
- * and a spontaneous RX HPD toggle (<hdmi_hpd_debounce_delay).
+ * physical unplug (>hpd_debounce_delay)
+ * and a spontaneous RX HPD toggle (<hpd_debounce_delay).
  *
  * If the toggle is less than this delay, the driver compares sink capabilities
  * and permits a hotplug event if they changed.
@@ -1272,11 +1272,11 @@ EXPORT_IF_KUNIT(are_sinks_equal);
  * The default value of 1500ms was chosen based on experimental testing with
  * various monitors that exhibit spontaneous HPD toggling behavior.
  */
-void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
+void amdgpu_dm_hpd_debounce_work(struct work_struct *work)
 {
 	struct amdgpu_dm_connector *aconnector =
 		container_of(to_delayed_work(work), struct amdgpu_dm_connector,
-			     hdmi_hpd_debounce_work);
+			     hpd_debounce_work);
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -1300,11 +1300,12 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
 		/* Apply workaround delay for certain panels */
 		amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
 		/* Compare sinks to determine if this was a spontaneous HPD toggle */
-		if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hdmi_prev_sink)) {
+		if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hpd_prev_sink)) {
 			/*
-			 * Sinks match - this was a spontaneous HDMI HPD toggle.
+			 * Sinks match - this was a spontaneous HPD toggle.
 			 */
-			drm_dbg_kms(dev, "HDMI HPD: Sink unchanged after debounce, internal re-enable\n");
+			drm_dbg_kms(dev,
+				    "HPD: Sink unchanged after debounce, internal re-enable\n");
 			fake_reconnect = true;
 		}
 
@@ -1321,9 +1322,9 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
 	}
 
 	/* Release the cached sink reference */
-	if (aconnector->hdmi_prev_sink) {
-		dc_sink_release(aconnector->hdmi_prev_sink);
-		aconnector->hdmi_prev_sink = NULL;
+	if (aconnector->hpd_prev_sink) {
+		dc_sink_release(aconnector->hpd_prev_sink);
+		aconnector->hpd_prev_sink = NULL;
 	}
 
 	scoped_guard(mutex, &adev->dm.dc_lock) {
@@ -1331,7 +1332,46 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
 			dc_allow_idle_optimizations(dc, true);
 	}
 }
-EXPORT_IF_KUNIT(amdgpu_dm_hdmi_hpd_debounce_work);
+EXPORT_IF_KUNIT(amdgpu_dm_hpd_debounce_work);
+
+/**
+ * hpd_debounce_delay_ms - resolve the HPD debounce delay for a connector
+ * @aconnector: connector whose current link is being evaluated
+ *
+ * HDMI, DVI, and DisplayPort SST use a per-monitor, per-connector-type delay
+ * set via EDID quirks (dc_panel_patch). eDP and MST are intentionally excluded.
+ * The hpd_debounce_override policy (from the module parameter) is then applied:
+ *
+ *   < 0 : auto  -> use the per-panel quirk delay
+ *   = 0 : force off on all connectors (ignores the quirk)
+ *   > 0 : force on for all eligible connectors, using this delay
+ *
+ * Return: the debounce delay in milliseconds, or 0 to process HPD immediately.
+ */
+static unsigned int hpd_debounce_delay_ms(struct amdgpu_dm_connector *aconnector)
+{
+	struct dc_link *link = aconnector->dc_link;
+	struct dc_sink *local_sink = link->local_sink;
+	unsigned int quirk_delay_ms;
+
+	if (dc_is_hdmi_signal(link->connector_signal) ||
+	    dc_is_dvi_signal(link->connector_signal))
+		quirk_delay_ms = local_sink ?
+			local_sink->edid_caps.panel_patch.hdmi_hpd_debounce_delay_ms : 0;
+	else if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
+		 link->type != dc_connection_mst_branch)
+		quirk_delay_ms = local_sink ?
+			local_sink->edid_caps.panel_patch.dp_hpd_debounce_delay_ms : 0;
+	else
+		return 0; /* not an eligible connector type */
+
+	if (aconnector->hpd_debounce_override == 0)
+		return 0; /* force off */
+	if (aconnector->hpd_debounce_override > 0)
+		return aconnector->hpd_debounce_override; /* force on */
+
+	return quirk_delay_ms; /* auto: per-EDID-quirk */
+}
 
 STATIC_IFN_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 				  enum dc_detect_reason reason)
@@ -1342,8 +1382,9 @@ STATIC_IFN_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnect
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
 	struct dc *dc = aconnector->dc_link->ctx->dc;
-	bool ret = false;
+	unsigned int debounce_delay_ms;
 	bool debounce_required = false;
+	bool ret = false;
 
 	if (adev->dm.disable_hpd_irq)
 		return;
@@ -1366,11 +1407,8 @@ STATIC_IFN_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnect
 	if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
 		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
-	/*
-	 * Check for HDMI disconnect with debounce enabled.
-	 */
-	debounce_required = (aconnector->hdmi_hpd_debounce_delay_ms > 0 &&
-			      dc_is_hdmi_signal(aconnector->dc_link->connector_signal) &&
+	debounce_delay_ms = hpd_debounce_delay_ms(aconnector);
+	debounce_required = (debounce_delay_ms > 0 &&
 			      new_connection_type == dc_connection_none &&
 			      aconnector->dc_link->local_sink != NULL);
 
@@ -1386,30 +1424,30 @@ STATIC_IFN_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnect
 			drm_kms_helper_connector_hotplug_event(connector);
 	} else if (debounce_required) {
 		/*
-		 * HDMI disconnect detected - schedule delayed work instead of
+		 * Disconnect detected - schedule delayed work instead of
 		 * processing immediately. This allows us to coalesce spurious
-		 * HDMI signals from physical unplugs.
+		 * HDMI/DVI/DP HPD signals from physical unplugs.
 		 */
-		drm_dbg_kms(dev, "HDMI HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
-			    aconnector->hdmi_hpd_debounce_delay_ms);
+		drm_dbg_kms(dev, "HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
+			    debounce_delay_ms);
 
 		/* Cache the current sink for later comparison */
-		if (aconnector->hdmi_prev_sink)
-			dc_sink_release(aconnector->hdmi_prev_sink);
-		aconnector->hdmi_prev_sink = aconnector->dc_link->local_sink;
-		if (aconnector->hdmi_prev_sink)
-			dc_sink_retain(aconnector->hdmi_prev_sink);
+		if (aconnector->hpd_prev_sink)
+			dc_sink_release(aconnector->hpd_prev_sink);
+		aconnector->hpd_prev_sink = aconnector->dc_link->local_sink;
+		if (aconnector->hpd_prev_sink)
+			dc_sink_retain(aconnector->hpd_prev_sink);
 
 		/* Schedule delayed detection. */
 		if (mod_delayed_work(system_percpu_wq,
-				 &aconnector->hdmi_hpd_debounce_work,
-				 msecs_to_jiffies(aconnector->hdmi_hpd_debounce_delay_ms)))
-			drm_dbg_kms(dev, "HDMI HPD: Re-scheduled debounce work\n");
+				 &aconnector->hpd_debounce_work,
+				 msecs_to_jiffies(debounce_delay_ms)))
+			drm_dbg_kms(dev, "HPD: Re-scheduled debounce work\n");
 
 	} else {
 
-		/* If the aconnector->hdmi_hpd_debounce_work is scheduled, exit early */
-		if (delayed_work_pending(&aconnector->hdmi_hpd_debounce_work))
+		/* If the aconnector->hpd_debounce_work is scheduled, exit early */
+		if (delayed_work_pending(&aconnector->hpd_debounce_work))
 			return;
 
 		scoped_guard(mutex, &adev->dm.dc_lock) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 4c200a9614a7..407456ea1f19 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -113,7 +113,7 @@ void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev);
 struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(struct amdgpu_device *adev);
 void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm);
 int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev);
-void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work);
+void amdgpu_dm_hpd_debounce_work(struct work_struct *work);
 
 /* IRQ handlers */
 struct amdgpu_crtc *amdgpu_dm_get_crtc_by_otg_inst(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 5ba7a2fffcf0..335b1b72935d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -193,6 +193,8 @@ struct dc_panel_patch {
 	bool oled_optimize_display_on;
 	unsigned int force_mst_blocked_discovery;
 	unsigned int wait_after_dpcd_poweroff_ms;
+	unsigned int hdmi_hpd_debounce_delay_ms;
+	unsigned int dp_hpd_debounce_delay_ms;
 };
 
 /**
-- 
2.43.0

