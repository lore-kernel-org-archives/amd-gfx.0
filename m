Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E507C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C961130B0;
	Wed,  1 May 2024 07:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0uMG3pEK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BFD91130B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsMCkLhvSi9FA0JIVYN04oUqmQJ9HkR8nUTionGpgJF4MJXDMJa1vtnFQCoO6igWou5q2EkA8d0lF+qNUj19HW90fdA+RojdG3GE5bZ/+/mj+XPeI80X+9lxEb6E3J9tXjR5ghXhsgUKrh+xVhC1Ek9HeAlNQt04a8ATeom0tnnqW4LV+u+Q786PrmwIa7Wln9llqTqLIokL1zngFVP2vvdTwr8BP4sDjJMKTB0XkAjJlfdzJIZuLc2dnqQHu0gEQ62pg7w3mxX4jyi4u4bBYqOLJmPVkc9cU0Vwumj/e1e6jhhjENsmq6yh4cIWHLFi/JU0/TdzpX5gMefYEZMnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th6T715ixjdPbV15Cy/5d8CXDh+dUxm0W1jM6S+PswU=;
 b=PIZzpJbcTi9XUL7mqOkWpKVjnsyq/bmWM9lC9BuObAhZ4M+o6f9EMGVie3HZWFrc87cF/As52AKrQfzdcUZIFMEqvZOGfocX2xYBmJwl/t2YIOxzIlctilu0LL9VVwqBRWkIO1J+9XLjDxDiLKXcnXVS1gmNVpNMxLyPyKYOkjl2urwODvhFrmN6mpt0QM45RKSaXMNW6KTNIIIzUfUzzcTny4ph6yhNDtyh/C0drvJcSkbRmX0xxtDLUZGFjaCcmk2co9ON/OVUuZf0gtTZhaitShaTtZOteGwX46EMK/e6zeYndVMP5eVHfS8xzoRDFzs66ruF6/mHPUruY/Ltng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th6T715ixjdPbV15Cy/5d8CXDh+dUxm0W1jM6S+PswU=;
 b=0uMG3pEK6oaVE8BI8vBpajgeIWA/pDS3iuhhrIHprqX3dgpg4UWd/C8UCxeiHeIqPXm63wbud3CilPcOEp+1iFE8PFaYBFBvYjtNBUy/9gntDn88YyQotB6W41UoV+SR8OBTGFawATc4FfpSbKmYCusfYANQ5UQuMNljY+0Ao1g=
Received: from CH0PR03CA0244.namprd03.prod.outlook.com (2603:10b6:610:e5::9)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.28; Wed, 1 May 2024 07:17:17 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::6a) by CH0PR03CA0244.outlook.office365.com
 (2603:10b6:610:e5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.27 via Frontend
 Transport; Wed, 1 May 2024 07:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:17:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:15 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:17:07 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sun peng Li <sunpeng.li@amd.com>
Subject: [PATCH 04/45] drm/amd/display: Add Replay capability and state in
 debugfs
Date: Wed, 1 May 2024 15:16:10 +0800
Message-ID: <20240501071651.3541919-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c5d7b8-9510-472d-a994-08dc69aebbb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8iRZIbqgujlpqwyDlgFyevs+O6WSKKnjtHcGZxVBJoYAiy6JTAQ8SkAi/5xt?=
 =?us-ascii?Q?uTLyJzReaQW+8DhCko4i86rM2B4wY8U0rpgm1MkhsrmNpdaAGC5ERXqLkTsE?=
 =?us-ascii?Q?qvPpA1/F+aQrIVrKPZlQ7hR2obbtVyRiODQV9xDBbTBYjIetym0/8sis8HTL?=
 =?us-ascii?Q?lUVNsyvZENhXHU4g3FqnnSujL2ADZCHkAfon2iOqmg790sYi3Fgo4M4tcqAh?=
 =?us-ascii?Q?McyLbfrbHx/Dlz79mgnauIU0eTM5JjHiV4t+JfaqBAmNiUOg1+e4GYE/MWfw?=
 =?us-ascii?Q?FND66OsGfNbLMUZReOrldTOEJfZWeeIoAVafQumMlCdCZvpgozTmLuDS0Sg+?=
 =?us-ascii?Q?VE82AQesmCT1Qz4EfbxmtbJYPcG4g3fS6hVWT9I7u7MYzjzNozwOaGl2aZTj?=
 =?us-ascii?Q?ng3Ph9KBNnVVLUQgv1JhlwVcKom6rwbs3GmOtXEZQOcRXrLBt8qQ5WQwlqcN?=
 =?us-ascii?Q?b/qlhcR8Z5zjWoGYuzRbM7FMQKPp0m9p40aHzaAiLzPsfCE+gA+BrJ6JmgE+?=
 =?us-ascii?Q?FUVruSHl2lfJnHtf4WCSbTm6moBTHZzJqyRxyagd+nnXA3On9p4VreB/+MK7?=
 =?us-ascii?Q?wXsH1+02tzmW4seT+Cx/aH7iQ/cSuDtbRcgcgS1nnhSYY4wx+Z1iDuT/oAEC?=
 =?us-ascii?Q?sPrI7hiZOuN3O0FKbn06CipmR9H+4E9olBu+L37ntmXxTA5ZBkh3De+4NR5K?=
 =?us-ascii?Q?zI5xtJL7RGjJYZt8Shj7jQ0G8DOq+hezxQpJaENb860l1qmdjaG26/A27YSC?=
 =?us-ascii?Q?wuFMFuZIwk4oIfvRTEPvNGj4McRk6elwT/Ti5iKSoVBTjyxi2RCOf/wTA5mU?=
 =?us-ascii?Q?p2xsCjJWIcImSGz1OoFUXnm7N66lp66s0NhnNeet2CM2Tz8bmYA9jZf2MYOH?=
 =?us-ascii?Q?6l4+ozxO1isjryhIeBr8a8aBbbhA9XiGgJBD0h0PxKudRcF1Mx+yAaLBcsYS?=
 =?us-ascii?Q?EZAuag0afxqDrBdK5qU/rytH0d8CROMNeM1xIicgNYp5ix53jpm4IBbJ/waN?=
 =?us-ascii?Q?uCP0co2O5ifb4jXBAtCyQYN6zv9dGoXKW5kEd6IuP4oW61kO5jx+8Q60YdVR?=
 =?us-ascii?Q?oBQDPnV/f1po7rKsfwhfJGceYsgEG4ieiQoCjZy1IlK/9ZVS04/ovmQ3ihKy?=
 =?us-ascii?Q?ZT3dhOeJvg8+dh+DmvopGTdFYE8452W5H3hA963gh4cPTlb4wgRX4LNb2i5K?=
 =?us-ascii?Q?yasOx8vJCziwxsL+I+NyurXPRUfxC4YGdQsAq05wpHcn7p7bVH4bxYwRfQKc?=
 =?us-ascii?Q?/9n+17UNkbHsfptlHdpjgJ0AWbYOL0+/1i1qGG18+J9kA6LL3PKme+ss/L4i?=
 =?us-ascii?Q?O9/FK5GxHLlD1L2xjwP4q3X5GPoPffCfNbcvTn4oAIXWRweC7MEZCdFaUqTQ?=
 =?us-ascii?Q?yOQXYoxDaYuOj4P/WUEEovn+2qb8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:17:17.3744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c5d7b8-9510-472d-a994-08dc69aebbb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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

[Why & How]
User can get the panel replay capability and state for debug.

sudo cat /sys/kernel/debug/dri/0/eDP-1/replay_capability
"Sink support: no" - if panel doesn't support Replay
"Sink support: yes" - if panel supports Replay
"Driver support: no\n" - if driver doesn't support Replay
"Driver support: yes\n" - if driver supports Replay

sudo cat /sys/kernel/debug/dri/0/eDP-1/replay_state
It will return current panel replay state

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 74 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 12 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |  2 +-
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 4d7a5d470b1e..7d97fdd9da92 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -30,6 +30,7 @@
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_debugfs.h"
+#include "amdgpu_dm_replay.h"
 #include "dm_helpers.h"
 #include "dmub/dmub_srv.h"
 #include "resource.h"
@@ -960,6 +961,57 @@ static int dmub_fw_state_show(struct seq_file *m, void *data)
 	return seq_write(m, state_base, state_size);
 }
 
+/* replay_capability_show() - show eDP panel replay capability
+ *
+ * The read function: replay_capability_show
+ * Shows if sink and driver has Replay capability or not.
+ *
+ *	cat /sys/kernel/debug/dri/0/eDP-X/replay_capability
+ *
+ * Expected output:
+ * "Sink support: no\n" - if panel doesn't support Replay
+ * "Sink support: yes\n" - if panel supports Replay
+ * "Driver support: no\n" - if driver doesn't support Replay
+ * "Driver support: yes\n" - if driver supports Replay
+ */
+static int replay_capability_show(struct seq_file *m, void *data)
+{
+	struct drm_connector *connector = m->private;
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct dc_link *link = aconnector->dc_link;
+	bool sink_support_replay = false;
+	bool driver_support_replay = false;
+
+	if (!link)
+		return -ENODEV;
+
+	if (link->type == dc_connection_none)
+		return -ENODEV;
+
+	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
+		return -ENODEV;
+
+	/* If Replay is already set to support, skip the checks */
+	if (link->replay_settings.config.replay_supported) {
+		sink_support_replay = true;
+		driver_support_replay = true;
+	} else if ((amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
+		sink_support_replay = amdgpu_dm_link_supports_replay(link, aconnector);
+	} else {
+		struct dc *dc = link->ctx->dc;
+
+		sink_support_replay = amdgpu_dm_link_supports_replay(link, aconnector);
+		if (dc->ctx->dmub_srv && dc->ctx->dmub_srv->dmub)
+			driver_support_replay =
+				(bool)dc->ctx->dmub_srv->dmub->feature_caps.replay_supported;
+	}
+
+	seq_printf(m, "Sink support: %s\n", str_yes_no(sink_support_replay));
+	seq_printf(m, "Driver support: %s\n", str_yes_no(driver_support_replay));
+
+	return 0;
+}
+
 /* psr_capability_show() - show eDP panel PSR capability
  *
  * The read function: sink_psr_capability_show
@@ -2768,6 +2820,7 @@ DEFINE_SHOW_ATTRIBUTE(dp_lttpr_status);
 DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
 DEFINE_SHOW_ATTRIBUTE(internal_display);
 DEFINE_SHOW_ATTRIBUTE(odm_combine_segments);
+DEFINE_SHOW_ATTRIBUTE(replay_capability);
 DEFINE_SHOW_ATTRIBUTE(psr_capability);
 DEFINE_SHOW_ATTRIBUTE(dp_is_mst_connector);
 DEFINE_SHOW_ATTRIBUTE(dp_mst_progress_status);
@@ -2937,6 +2990,22 @@ static int force_yuv420_output_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(force_yuv420_output_fops, force_yuv420_output_get,
 			 force_yuv420_output_set, "%llu\n");
 
+/*
+ *  Read Replay state
+ */
+static int replay_get_state(void *data, u64 *val)
+{
+	struct amdgpu_dm_connector *connector = data;
+	struct dc_link *link = connector->dc_link;
+	uint64_t state = REPLAY_STATE_INVALID;
+
+	dc_link_get_replay_state(link, &state);
+
+	*val = state;
+
+	return 0;
+}
+
 /*
  *  Read PSR state
  */
@@ -3155,6 +3224,8 @@ static int dmcub_trace_event_state_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(dmcub_trace_event_state_fops, dmcub_trace_event_state_get,
 			 dmcub_trace_event_state_set, "%llu\n");
 
+DEFINE_DEBUGFS_ATTRIBUTE(replay_state_fops, replay_get_state, NULL, "%llu\n");
+
 DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
 DEFINE_DEBUGFS_ATTRIBUTE(psr_residency_fops, psr_read_residency, NULL,
 			 "%llu\n");
@@ -3328,6 +3399,9 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 		}
 	}
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
+		debugfs_create_file("replay_capability", 0444, dir, connector,
+					&replay_capability_fops);
+		debugfs_create_file("replay_state", 0444, dir, connector, &replay_state_fops);
 		debugfs_create_file_unsafe("psr_capability", 0444, dir, connector, &psr_capability_fops);
 		debugfs_create_file_unsafe("psr_state", 0444, dir, connector, &psr_fops);
 		debugfs_create_file_unsafe("psr_residency", 0444, dir,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index 738a58eebba7..41f07f13a7b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -24,6 +24,7 @@
  */
 
 #include "amdgpu_dm_replay.h"
+#include "dc_dmub_srv.h"
 #include "dc.h"
 #include "dm_helpers.h"
 #include "amdgpu_dm.h"
@@ -32,12 +33,12 @@
 #include "dc/inc/link.h"
 
 /*
- * link_supports_replay() - check if the link supports replay
+ * amdgpu_dm_link_supports_replay() - check if the link supports replay
  * @link: link
  * @aconnector: aconnector
  *
  */
-static bool link_supports_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
+bool amdgpu_dm_link_supports_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
 {
 	struct dm_connector_state *state = to_dm_connector_state(aconnector->base.state);
 	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
@@ -78,6 +79,7 @@ bool amdgpu_dm_set_replay_caps(struct dc_link *link, struct amdgpu_dm_connector
 {
 	struct replay_config pr_config = { 0 };
 	union replay_debug_flags *debug_flags = NULL;
+	struct dc *dc = link->ctx->dc;
 
 	// If Replay is already set to support, return true to skip checks
 	if (link->replay_settings.config.replay_supported)
@@ -89,7 +91,11 @@ bool amdgpu_dm_set_replay_caps(struct dc_link *link, struct amdgpu_dm_connector
 	if (link->panel_config.psr.disallow_replay)
 		return false;
 
-	if (!link_supports_replay(link, aconnector))
+	if (!amdgpu_dm_link_supports_replay(link, aconnector))
+		return false;
+
+	if (!dc->ctx->dmub_srv || !dc->ctx->dmub_srv->dmub ||
+		!dc->ctx->dmub_srv->dmub->feature_caps.replay_supported)
 		return false;
 
 	// Mark Replay is supported in pr_config
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
index f0d30eb47312..8126bdb1eb6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
@@ -38,7 +38,7 @@ enum replay_enable_option {
 	pr_enable_option_full_screen_video_coasting = 0x40000,
 };
 
-
+bool amdgpu_dm_link_supports_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
 bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool enable);
 bool amdgpu_dm_set_replay_caps(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
 bool amdgpu_dm_link_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
-- 
2.34.1

