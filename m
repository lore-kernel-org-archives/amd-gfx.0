Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A814CC4450F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3931410F0AB;
	Wed, 15 Jul 2026 13:48:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QLgGaEd1";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F3A10F0AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9MYS82sK8uXlTlBg06H6ERvP3uwI1yPybq/zx6r/LyokrAwORk2iAXEIKlddVdFr7YKEcjfcoxaqUpw7FdT0ofsZ5YNxAvaGuxAOcOJ9/FiLMz+R8kQUoWYGjwfh+tlga6oeu1VIcLG4s2psNH7qrbOljhqN/2UeOThMHFeXLPfDj/O38A9GxBagWXzvuNr4GXMIrmdq6ttQBCm3rvh2Jkg+090Vj/dOmJ+OoZVS6dE0ZcnYShl56XKfVD7xf9a5x64uTRdd6OpJfjixgR3OvtakMNeS+32CQIIXN24QsWyF9V1KNXIotx9mNr5XWbMjy2G/9YKKV2bSEtjPktasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjhLdMbJ0O+XCkh1OhD+nh+d6RMzUuQFbPQNJDJ57BI=;
 b=K8CsqT1EWqiw541d8ioK0p1aK5hk8jBc/qDqIHacr0TUmv9H3mNbj9naYUlpDhwXyrp0fNrwSlDOMRQNPrzV+TMLNfJFPgv5BZaxIcYmgL+bkN/+dGfnIOwerW0rN4gtA5bdb+ZDPuaApc1bkg4GHqggUaTg5L2pwp45PygpOc4FTFfeDMvX2y9j2M7xWJaw7chsOQa752X7Md6jTsAaMSqX0DzRWCW+caG/UM8puRG2hKWOUt9xSx74BpRtL501sWPQPL6Lp6H/YZ5EsBJcIilh+Ycg/lpBpM6HC6mw5WTHiO09WLEHOHlFv62WFFfRwMCwXTP9xZGP5cNrkNdCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjhLdMbJ0O+XCkh1OhD+nh+d6RMzUuQFbPQNJDJ57BI=;
 b=QLgGaEd1M4EMR1VSjeB8t6ZexqCAR4jpKrdOX3coaC4QxSLti6RBko1NaJWF2JkdAEDsnr9oPNiYxEECWHRsIZQ3RgX8Yck2ESfpnhF3qq267+vEC7HewNIQ9vMhgipCYMwUMPN7urN7nU80WP3yN6EmMZcj8TAinKEZnXw5nMs=
Received: from BY5PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:1e0::40)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 13:48:28 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::99) by BY5PR03CA0030.outlook.office365.com
 (2603:10b6:a03:1e0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 13:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:24 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:21 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dominik Kaszewski
 <dominik.kaszewski@amd.com>
Subject: [PATCH 56/70] drm/amd/display: Wire probe commit path into
 dc_update_state
Date: Wed, 15 Jul 2026 21:38:06 +0800
Message-ID: <20260715134432.1975118-57-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd358a2-6aee-4c44-57bf-08dee277bffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|6133799003|56012099006|5023799004|11063799006|18002099003|22082099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: qjMMGsJBHJnklw0BxQQKSQGq118/DN3NvJCqpeXbXw8IC0WtBRf+IK/QbI03Pz2uiq2ljgk8bYLz2p4MmrnsjESURLukCct1tAKm6BS0OSgv0hhC0ZQC5+S7j6CVBx5Npnwt9dwVsSCUkqEpcHkl7e3p8h5gPxDD74NiBD2yzAyv6Bdc59ZM3tkdGhOGiIek6+a7LeaVevmSqnVQTQ2jVCAZOcLPuyzzwK+w7GNa6p3baNWOCwOgSxCwE0Zb3AeXOkK45uAKJ9HP2c7/oopyongnhedgquFIqb9df7+S6AAgT+IxUIguqZyWnVRhIP1j3uLGYTfZsPyotlSIVoHaEOzAFJQKgnjfm8vSWWOFsDUai7KeIKCzYq3L2Up22dhgeGYbyB28dD6ry2BqgSWPs/40+iupAduaqkweT3GeDvVXJjBvPiNSJerkOWiMgMTeGD6UMH3cPei7JhZ+qTYyDfL/5xrdt1q3DeBtn448Gf8p0Hplli8rY2P0/+4b+BywmTE7lHoa1MAweudT6ZMmsngwwDZ8Z2cXJADOP3NEODeKNC8ktqjPKQ1InoC1WTe3VoU+VYkkfcIWqioY6yyPukQOTp2MUOM6+hC/3aN5I4lJqBo4AhLqLv+RcCE9DZkDTX7UlRddw/iJ2IzXm9mD+L3g0vc6VlVhqEwgGcldnB+VNCscETYdHVziCwC6qTZH6mHmgb0L9gqJjbcgZMW8uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eEOmx2GnfTy1tCNAaV92EbrCSZebGfh8xccekmB5yZKBFOA6GpPA69Sc2vX/weEj/1PJlMnF+H6qCc85gAXhLTi+ZQMI9I3QhvKk7z3QezTYOVlIbwxu0XbMQAtiUA9te3dLFegFTCbzyKg0sBOxa/Lv1k/x0QoSUf9rsGH47aJ2jqSvpjgutnNK3AP3mkimRc++d4Uf8mncID+TW4eRrV9YsGnVX9K8Yh7uIl+xBSlgNVsQV4tp32ki/fQ2fqwI12uSgcT1SrKgsV8VgrUR/7XXQytRFIJaFGEc+dAn6n426YbS4EGAhLxUOc5QcxQ5pr5BKW/z6Lti4LAXx3ixBsuj4zSQzk+Bu7FbsOG2+pN8dF495A3uPftvq0Fv4XWiH802qEdtmxl/5qgPDhKtgTpT1PjyJCdJIfa1VNuf6Jzd9cqMF3lq+pD/L+7y7voC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:28.1894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd358a2-6aee-4c44-57bf-08dee277bffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
The dc_update_state commit interface and the dc_probe object model existed
but were not connected: there was no path to validate, commit, and program
a probe through the update pipeline, nor to read the result back. The
measurement waits on OTG frame edges and must not block fast updates.

[How]
- Move the per-commit scratch off dc_stream_state onto a dc-owned pool;
  acquire at init, release on cleanup or prepare failure, serialized by the
  DM global lock every commit path already holds.
- dc_update_state drives stream commits, probe-only commits, or both through
  one staged init/prepare/execute/cleanup loop with a null-arg guard. prepare
  releases the scratch slot on failure; cleanup releases it on success.
- Probe prepare installs the absolute probe set in place; execute calls the
  perfmon programming hook in the unlocked window and latches results.
- Add resource_validate_probe_set, a context-free achievability check shared
  by dc_validate_global_state (full update) and probe prepare (probe-only).
- dc_state_get_status gains a probe status class with a probe filter and a
  by-type mapping; dc_validation_set gains probes/probe_count. Drop the dead
  actual_* fields from struct dc_qos_info.

Reviewed-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 314 +++++++++++++-----
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  38 +++
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  11 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  22 +-
 drivers/gpu/drm/amd/display/dc/dc.h           | 122 ++++++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  27 --
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   4 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  56 ++--
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   6 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 +
 11 files changed, 428 insertions(+), 180 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a3665c49a381..2bd579340b64 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -898,6 +898,32 @@ void dc_stream_set_static_screen_params(struct dc *dc,
 	dc->hwss.set_static_screen_control(pipes_affected, num_pipes_affected, params);
 }
 
+static void dc_destruct_update_scratch_pool(struct dc *dc)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dc->update_scratch_pool); i++) {
+		kfree(dc->update_scratch_pool[i]);
+		dc->update_scratch_pool[i] = NULL;
+		dc->update_scratch_in_use[i] = false;
+	}
+}
+
+static bool dc_construct_update_scratch_pool(struct dc *dc)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dc->update_scratch_pool); i++) {
+		dc->update_scratch_pool[i] = kzalloc(
+				sizeof(struct dc_update_scratch_space), GFP_KERNEL);
+		if (!dc->update_scratch_pool[i])
+			return false;
+		dc->update_scratch_in_use[i] = false;
+	}
+
+	return true;
+}
+
 static void dc_destruct(struct dc *dc)
 {
 	// reset link encoder assignment table on destruct
@@ -905,6 +931,8 @@ static void dc_destruct(struct dc *dc)
 			!dc->config.unify_link_enc_assignment)
 		link_enc_cfg_init(dc, dc->current_state);
 
+	dc_destruct_update_scratch_pool(dc);
+
 	if (dc->current_state) {
 		dc_state_release(dc->current_state);
 		dc->current_state = NULL;
@@ -1148,6 +1176,11 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 	}
 
+	if (!dc_construct_update_scratch_pool(dc)) {
+		dm_error("%s: failed to create update scratch pool\n", __func__);
+		goto fail;
+	}
+
 	return true;
 
 fail:
@@ -3235,11 +3268,6 @@ static struct dc_update_descriptor check_update_surfaces_for_stream(
 	return overall_type;
 }
 
-/*
- * dc_check_update_surfaces_for_stream() - Determine update type (fast, med, or full)
- *
- * See :c:type:`enum dc_update_type <dc_update_type>` for explanation of update types
- */
 /**
  * dc_check_state_update - Classify a dc_state_update by locking / re-entrancy requirements.
  * @check_config:  ASIC capabilities and display configuration context
@@ -3247,7 +3275,8 @@ static struct dc_update_descriptor check_update_surfaces_for_stream(
  *
  * Determines whether the update requires a fast, medium, or full lock
  * by inspecting the stream, stream_update, and surface_updates carried on
- * the root object. Perfmon classification is reserved for a future slice.
+ * the root object. A probe update elevates the result to at least MED with
+ * the PROBE lock, so a probe-carrying commit takes the probe mutex.
  *
  * Return: dc_update_descriptor with update_type and lock_descriptor.
  */
@@ -3255,13 +3284,20 @@ struct dc_update_descriptor dc_check_state_update(
 		const struct dc_check_config *check_config,
 		struct dc_state_update *updates)
 {
+	struct dc_update_descriptor desc = {0};
+
 	if (updates->stream_update)
 		stream_update_flags_clear(&updates->stream_update->stream->update_flags);
 	for (int i = 0; i < updates->surface_count; i++)
 		dc_pipe_update_bits_clear(&updates->surface_updates[i].surface->update_bits);
 
-	return check_update_surfaces_for_stream(check_config, updates->surface_updates,
+	desc = check_update_surfaces_for_stream(check_config, updates->surface_updates,
 			updates->surface_count, updates->stream_update);
+
+	if (updates->probe_updates && updates->probe_updates->probe_count > 0)
+		elevate_update_type(&desc, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_PROBE);
+
+	return desc;
 }
 
 /**
@@ -3283,9 +3319,11 @@ struct dc_update_descriptor dc_check_update_surfaces_for_stream(
 		struct dc_stream_update *stream_update)
 {
 	struct dc_state_update root = {
+		.stream          = stream_update ? stream_update->stream : NULL,
+		.stream_update   = stream_update,
 		.surface_updates = updates,
 		.surface_count   = surface_count,
-		.stream_update   = stream_update,
+		.probe_updates   = NULL
 	};
 
 	return dc_check_state_update(check_config, &root);
@@ -3704,13 +3742,6 @@ static bool full_update_required_weak(
 		const struct dc_stream_update *stream_update,
 		const struct dc_stream_state *stream);
 
-struct pipe_split_policy_backup {
-	bool dynamic_odm_policy;
-	bool subvp_policy;
-	enum pipe_split_policy mpc_policy;
-	char force_odm[MAX_PIPES];
-};
-
 static void backup_and_set_minimal_pipe_split_policy(struct dc *dc,
 		struct dc_state *context,
 		struct pipe_split_policy_backup *policy)
@@ -6197,30 +6228,60 @@ static void clear_update_bits(struct dc_surface_update *srf_updates,
 			dc_pipe_update_bits_clear(&srf_updates[i].surface->update_bits);
 }
 
+static struct dc_update_scratch_space *dc_update_scratch_acquire(struct dc *dc)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dc->update_scratch_pool); i++) {
+		if (dc->update_scratch_in_use[i])
+			continue;
+
+		dc->update_scratch_in_use[i] = true;
+		return dc->update_scratch_pool[i];
+	}
+
+	/* TODO: add recoverable scratch acquisition failure handling. */
+	ASSERT(false);
+	return NULL;
+}
+
+static void dc_update_scratch_release(struct dc *dc,
+		struct dc_update_scratch_space *scratch)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dc->update_scratch_pool); i++) {
+		if (dc->update_scratch_pool[i] == scratch) {
+			dc->update_scratch_in_use[i] = false;
+			return;
+		}
+	}
+}
+
 /**
  * dc_update_state - Commit an absolute dc_state_update.
  * @dc:      DC structure
  * @updates: root update object carrying stream, plane, and probe updates
- *
- * When stream is non-NULL the stream and its plane updates are committed via
- * the init/prepare/execute/cleanup pipeline. Probe commit is reserved for a
- * future slice. dc_update_planes_and_stream() is now a shim over this function.
- *
  * Return: true on success, false on failure.
  */
 bool dc_update_state(struct dc *dc, struct dc_state_update *updates)
 {
-	if (updates->stream != NULL) {
-		struct dc_update_scratch_space *scratch = dc_update_state_init(dc, updates);
-		bool more = true;
+	struct dc_update_scratch_space *scratch;
+	bool more = true;
 
-		while (more) {
-			if (!dc_update_state_prepare(scratch))
-				return false;
+	if (!dc || !updates)
+		return false;
 
-			dc_update_state_execute(scratch);
-			more = dc_update_state_cleanup(scratch);
-		}
+	scratch = dc_update_state_init(dc, updates);
+	if (!scratch)
+		return false;
+
+	while (more) {
+		if (!dc_update_state_prepare(scratch))
+			return false;
+
+		dc_update_state_execute(scratch);
+		more = dc_update_state_cleanup(scratch);
 	}
 
 	return true;
@@ -8129,8 +8190,6 @@ bool dc_get_qos_info(struct dc *dc, struct dc_qos_info *info)
 
 	memset(info, 0, sizeof(*info));
 
-	/* TODO: remove the actual_* fields from struct dc_qos_info once all callers
-	 * read measured QoS from dc_state probe_status instead of this struct. */
 	info->dcn_bandwidth_ub_in_mbps = (uint32_t)(clk->fclk_khz / 1000 * 64);
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->get_requested_memory_qos) {
@@ -8156,38 +8215,6 @@ unsigned int dc_override_memory_bandwidth_request(
 			dc->clk_mgr, bw_mbps * 1000) / 1000;
 }
 
-enum update_v3_flow {
-	UPDATE_V3_FLOW_INVALID,
-	UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST,
-	UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL,
-	UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS,
-	UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW,
-	UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT,
-};
-
-struct dc_update_scratch_space {
-	struct dc *dc;
-	struct dc_surface_update *surface_updates;
-	int surface_count;
-	struct dc_stream_state *stream;
-	struct dc_stream_update *stream_update;
-	bool update_v3;
-	bool do_clear_update_bits;
-	enum dc_update_type update_type;
-	struct dc_state *new_context;
-	enum update_v3_flow flow;
-	struct dc_state *backup_context;
-	struct dc_state *intermediate_context;
-	struct pipe_split_policy_backup intermediate_policy;
-	struct dc_surface_update intermediate_updates[MAX_SURFACES];
-	int intermediate_count;
-};
-
-size_t dc_update_scratch_space_size(void)
-{
-	return sizeof(struct dc_update_scratch_space);
-}
-
 static bool update_planes_and_stream_prepare_v2(
 		struct dc_update_scratch_space *scratch
 )
@@ -8354,6 +8381,19 @@ static bool update_planes_and_stream_prepare_v3(
 	return false;
 }
 
+/**
+ * should_commit_intermediate_context - Does this flow commit a transient
+ * minimal-transition intermediate context
+ * @flow: the commit flow selected for this iteration
+ *
+ * Return: true if this iteration commits the intermediate context.
+ */
+static bool should_commit_intermediate_context(enum update_v3_flow flow)
+{
+	return flow == UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW
+			|| flow == UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT;
+}
+
 static void update_planes_and_stream_execute_v3_commit(
 		const struct dc_update_scratch_space *scratch,
 		bool intermediate_update,
@@ -8377,6 +8417,8 @@ static void update_planes_and_stream_execute_v3(
 		const struct dc_update_scratch_space *scratch
 )
 {
+	bool intermediate_context = should_commit_intermediate_context(scratch->flow);
+
 	switch (scratch->flow) {
 	case UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST:
 		commit_planes_for_stream_fast(
@@ -8392,16 +8434,16 @@ static void update_planes_and_stream_execute_v3(
 
 	case UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL:
 	case UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS:
-		update_planes_and_stream_execute_v3_commit(scratch, false, false, true);
+		update_planes_and_stream_execute_v3_commit(scratch, false, intermediate_context, true);
 		break;
 
 	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW:
-		update_planes_and_stream_execute_v3_commit(scratch, false, true,
+		update_planes_and_stream_execute_v3_commit(scratch, false, intermediate_context,
 				scratch->dc->check_config.deferred_transition_state);
 		break;
 
 	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT:
-		update_planes_and_stream_execute_v3_commit(scratch, true, true, false);
+		update_planes_and_stream_execute_v3_commit(scratch, true, intermediate_context, false);
 		break;
 
 	case UPDATE_V3_FLOW_INVALID:
@@ -8482,45 +8524,139 @@ struct dc_update_scratch_space *dc_update_state_init(
 )
 {
 	const enum dce_version version = dc->ctx->dce_version;
-	struct dc_update_scratch_space *scratch = updates->stream->update_scratch;
-
-	*scratch = (struct dc_update_scratch_space){
-		.dc = dc,
-		.surface_updates = updates->surface_updates,
-		.surface_count = updates->surface_count,
-		.stream = updates->stream,
-		.stream_update = updates->stream_update,
-		.update_v3 = version >= DCN_VERSION_4_01 || version == DCN_VERSION_3_2 || version == DCN_VERSION_3_21,
-		.do_clear_update_bits = version >= DCN_VERSION_1_0,
-	};
+	struct dc_update_scratch_space *scratch = dc_update_scratch_acquire(dc);
+	bool has_stream_or_plane = updates->stream || updates->stream_update || updates->surface_updates;
+	bool has_probe = updates->probe_updates;
+	bool surface_without_stream = updates->surface_updates && !updates->stream;
+	bool stream_update_without_stream = updates->stream_update && !updates->stream;
+	bool bad_surface_count = updates->surface_count > 0 && !updates->surface_updates;
+
+	if (!scratch)
+		return NULL;
+
+	if (!has_stream_or_plane && !has_probe) {
+		dc_update_scratch_release(dc, scratch);
+		return NULL;
+	}
+
+	if (surface_without_stream || stream_update_without_stream || bad_surface_count) {
+		dc_update_scratch_release(dc, scratch);
+		return NULL;
+	}
+
+	memset(scratch, 0, sizeof(*scratch));
+
+	scratch->dc = dc;
+	scratch->surface_updates = updates->surface_updates;
+	scratch->surface_count = updates->surface_count;
+	scratch->stream = updates->stream;
+	scratch->stream_update = updates->stream_update;
+	scratch->probe_updates = updates->probe_updates;
+	scratch->update_v3 = version >= DCN_VERSION_4_01
+			|| version == DCN_VERSION_3_2
+			|| version == DCN_VERSION_3_21;
+	scratch->do_clear_update_bits = version >= DCN_VERSION_1_0;
+	scratch->new_context = NULL;
+	scratch->flow = UPDATE_V3_FLOW_INVALID;
 
 	return scratch;
 }
 
-bool dc_update_state_prepare(
-		struct dc_update_scratch_space *scratch
-)
+/**
+ * dc_update_probes_prepare - Commit the desired probe set into new_context.
+ * @scratch: commit scratch carrying the probe updates
+ *
+ * Return: true on success or when there is nothing to do; false when the
+ * desired set is unachievable.
+ */
+static bool dc_update_probes_prepare(struct dc_update_scratch_space *scratch)
+{
+	struct dc *dc = scratch->dc;
+	const struct dc_probe_updates *probe_updates = scratch->probe_updates;
+	uint8_t i;
+
+	if (!probe_updates)
+		return true;
+
+	if (resource_validate_probe_set(dc, probe_updates->probes,
+			(uint8_t)probe_updates->probe_count) != DC_OK)
+		return false;
+
+	if (!scratch->new_context)
+		scratch->new_context = dc->current_state;
+
+	for (i = 0; i < probe_updates->probe_count && i < MAX_PROBES; i++)
+		scratch->new_context->probes[i] = probe_updates->probes[i];
+	scratch->new_context->probe_count = probe_updates->probe_count;
+
+	return true;
+}
+
+/**
+ * dc_update_probes_execute - Program the committed probes.
+ * @scratch: commit scratch carrying the probe updates
+ *
+ */
+static void dc_update_probes_execute(const struct dc_update_scratch_space *scratch)
+{
+	struct dc *dc = scratch->dc;
+
+	if (should_commit_intermediate_context(scratch->flow))
+		return;
+
+	if (dc->hwss.program_perfmon)
+		dc->hwss.program_perfmon(dc, scratch->new_context);
+}
+
+bool dc_update_state_prepare(struct dc_update_scratch_space *scratch)
 {
-	return scratch->update_v3
-			? update_planes_and_stream_prepare_v3(scratch)
-			: update_planes_and_stream_prepare_v2(scratch);
+	if (scratch->stream) {
+		bool ok = scratch->update_v3
+				? update_planes_and_stream_prepare_v3(scratch)
+				: update_planes_and_stream_prepare_v2(scratch);
+
+		if (!ok)
+			goto release_scratch;
+	}
+
+	if (!dc_update_probes_prepare(scratch))
+		goto release_scratch;
+
+	return true;
+
+release_scratch:
+	/* execute and cleanup never run on this path, so release here. */
+	dc_update_scratch_release(scratch->dc, scratch);
+	return false;
 }
 
 void dc_update_state_execute(
 		const struct dc_update_scratch_space *scratch
 )
 {
-	scratch->update_v3
-			? update_planes_and_stream_execute_v3(scratch)
-			: update_planes_and_stream_execute_v2(scratch);
+	if (scratch->stream)
+		scratch->update_v3
+				? update_planes_and_stream_execute_v3(scratch)
+				: update_planes_and_stream_execute_v2(scratch);
+
+	if (scratch->probe_updates)
+		dc_update_probes_execute(scratch);
 }
 
 bool dc_update_state_cleanup(
 		struct dc_update_scratch_space *scratch
 )
 {
-	return scratch->update_v3
-			? update_planes_and_stream_cleanup_v3(scratch)
-			: update_planes_and_stream_cleanup_v2(scratch);
+	bool more = false;
+
+	if (scratch->stream)
+		more = scratch->update_v3
+				? update_planes_and_stream_cleanup_v3(scratch)
+				: update_planes_and_stream_cleanup_v2(scratch);
+
+	if (!more)
+		dc_update_scratch_release(scratch->dc, scratch);
+
+	return more;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 07ec00e11f2d..8b54bab98283 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -3388,7 +3388,7 @@ void hwss_hubbub_perfmon_get_memory_latencies(union block_sequence_params *param
 {
 	struct hubbub *hubbub = params->hubbub_perfmon_get_memory_latencies_params.hubbub;
 	uint32_t refclk_mhz  = params->hubbub_perfmon_get_memory_latencies_params.refclk_mhz;
-	struct hubbub_system_latencies *result = params->hubbub_perfmon_get_memory_latencies_params.result;
+	struct dc_probe_latencies *result = params->hubbub_perfmon_get_memory_latencies_params.result;
 
 	if (hubbub && hubbub->funcs->perfmon.get_memory_latencies_ns && result)
 		hubbub->funcs->perfmon.get_memory_latencies_ns(
@@ -4711,7 +4711,7 @@ void hwss_add_hubbub_perfmon_get_in_order_bw(struct block_sequence_state *seq_st
 
 void hwss_add_hubbub_perfmon_get_memory_latencies(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub, uint32_t refclk_mhz,
-		struct hubbub_system_latencies *result)
+		struct dc_probe_latencies *result)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_GET_MEMORY_LATENCIES;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d9492a460c2a..b970f152d67f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4383,6 +4383,40 @@ static bool add_all_planes_for_stream(
 	return true;
 }
 
+/**
+ * resource_validate_probe_set - Validate a probe descriptor set against the ASIC.
+ * @dc:          DC instance providing the HWSS capability hooks
+ * @probes:      desired probe descriptors
+ * @probe_count: number of valid entries in @probes
+ *
+ * Return: DC_OK if achievable, otherwise a DC error.
+ */
+enum dc_status resource_validate_probe_set(struct dc *dc,
+		const struct dc_probe_state *probes,
+		uint8_t probe_count)
+{
+	uint8_t i;
+
+	if (probe_count == 0)
+		return DC_OK;
+
+	if (!dc->hwss.program_perfmon)
+		return DC_NOT_SUPPORTED;
+
+	if (probe_count > MAX_PROBES)
+		return DC_NOT_SUPPORTED;
+
+	for (i = 0; i < probe_count; i++) {
+		if (probes[i].target_state == DC_PROBE_MEASURING)
+			return DC_NOT_SUPPORTED;
+
+		if (probes[i].scope.type != DC_PROBE_SCOPE_GLOBAL)
+			return DC_NOT_SUPPORTED;
+	}
+
+	return DC_OK;
+}
+
 /**
  * dc_validate_with_context - Validate and update the potential new stream in the context object
  *
@@ -4754,6 +4788,10 @@ enum dc_status dc_validate_global_state(
 	if (result == DC_OK)
 		result = dc->res_pool->funcs->validate_bandwidth(dc, new_ctx, validate_mode);
 
+	if (result == DC_OK)
+		result = resource_validate_probe_set(dc, new_ctx->probes,
+				(uint8_t)new_ctx->probe_count);
+
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index a62a435054c6..5c5f38bc04de 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -709,6 +709,17 @@ enum dc_status dc_state_get_status(struct dc_state_status *status,
 		}
 	}
 
+	if (options->types & DC_GET_STATUS_PROBE) {
+		status->probe_count = 0;
+		for (i = 0; i < options->state->probe_count; i++) {
+			if (options->probe &&
+					options->probe->type != options->state->probes[i].type)
+				continue;
+			status->probe_status[status->probe_count++] =
+					&options->state->probe_status[i];
+		}
+	}
+
 	return DC_OK;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index a32b6eb796f7..562accfeff79 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -194,7 +194,6 @@ static void dc_stream_free(struct kref *kref)
 	struct dc_stream_state *stream = container_of(kref, struct dc_stream_state, refcount);
 
 	dc_stream_destruct(stream);
-	kfree(stream->update_scratch);
 	kfree(stream);
 }
 
@@ -219,13 +218,6 @@ struct dc_stream_state *dc_create_stream_for_sink(
 	if (stream == NULL)
 		goto fail;
 
-	DC_RUN_WITH_PREEMPTION_ENABLED(stream->update_scratch =
-					kzalloc((int32_t) dc_update_scratch_space_size(),
-						GFP_ATOMIC));
-
-	if (stream->update_scratch == NULL)
-		goto fail;
-
 	if (dc_stream_construct(stream, sink) == false)
 		goto fail;
 
@@ -234,10 +226,8 @@ struct dc_stream_state *dc_create_stream_for_sink(
 	return stream;
 
 fail:
-	if (stream) {
-		kfree(stream->update_scratch);
+	if (stream)
 		kfree(stream);
-	}
 
 	return NULL;
 }
@@ -250,16 +240,6 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
 	if (!new_stream)
 		return NULL;
 
-	// Scratch is not meant to be reused across copies, as might have self-referential pointers
-	new_stream->update_scratch = kzalloc(
-			(int32_t) dc_update_scratch_space_size(),
-			GFP_KERNEL
-	);
-	if (!new_stream->update_scratch) {
-		kfree(new_stream);
-		return NULL;
-	}
-
 	if (new_stream->sink)
 		dc_sink_retain(new_stream->sink);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2da89c7470de..0913fab7504c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -530,6 +530,7 @@ enum dc_lock_descriptor {
 	LOCK_DESCRIPTOR_STREAM = 0x1,
 	LOCK_DESCRIPTOR_LINK = 0x2,
 	LOCK_DESCRIPTOR_GLOBAL = 0x4,
+	LOCK_DESCRIPTOR_PROBE = 0x8,
 };
 
 struct dc_update_descriptor {
@@ -1018,14 +1019,9 @@ struct dc_bounding_box_overrides {
 };
 
 struct dc_qos_info {
-	uint32_t actual_peak_bw_in_mbps;
 	uint32_t qos_bandwidth_lb_in_mbps;
-	uint32_t actual_avg_bw_in_mbps;
 	uint32_t calculated_avg_bw_in_mbps;
-	uint32_t actual_max_latency_in_ns;
-	uint32_t actual_min_latency_in_ns;
 	uint32_t qos_max_latency_ub_in_ns;
-	uint32_t actual_avg_latency_in_ns;
 	uint32_t qos_avg_latency_ub_in_ns;
 	uint32_t dcn_bandwidth_ub_in_mbps;
 	uint32_t qos_max_bw_budget_in_mbps;
@@ -1987,6 +1983,12 @@ struct dc {
 	struct dc_state *current_state;
 	struct resource_pool *res_pool;
 
+	/**
+	 * @update_scratch_pool: Per-commit scratch buffers for dc_update_state.
+	 */
+	struct dc_update_scratch_space *update_scratch_pool[MAX_STREAMS + 1];
+	bool update_scratch_in_use[MAX_STREAMS + 1];
+
 	struct clk_mgr *clk_mgr;
 
 	/* Display Engine Clock levels */
@@ -2114,25 +2116,107 @@ struct dc_state_update {
 	const struct dc_probe_updates *probe_updates;
 };
 
+/**
+ * dc_check_state_update() - Classify an update without committing it.
+ * @check_config: DC check configuration
+ * @updates:      root update object to classify
+ *
+ * Return: descriptor indicating update type and required lock scope.
+ */
+struct dc_update_descriptor dc_check_state_update(
+		const struct dc_check_config *check_config,
+		struct dc_state_update *updates);
+
 /**
  * dc_update_state - Commit an absolute dc_state_update.
  * @dc:      DC structure
  * @updates: root update object carrying stream, plane, and probe updates
  *
- * When stream is non-NULL the stream and its plane updates are committed via
- * the init/prepare/execute/cleanup pipeline. Probe commit is reserved for a
- * future slice. dc_update_planes_and_stream() is now a shim over this function.
- *
  * Return: true on success, false on failure.
  */
 bool dc_update_state(struct dc *dc, struct dc_state_update *updates);
 
+struct dc_update_scratch_space;
+
+/**
+ * dc_update_state_init - Acquire and initialise a commit scratch buffer.
+ * @dc:      DC structure
+ * @updates: update descriptor; validated before the slot is acquired
+ *
+ * Return: a scratch slot on success, NULL if validation fails or the pool
+ * is exhausted. The slot must be released via dc_update_state_cleanup() on
+ * success, or automatically by dc_update_state_prepare() on failure.
+ */
+struct dc_update_scratch_space *dc_update_state_init(
+		struct dc *dc,
+		const struct dc_state_update *updates
+);
+
+/**
+ * dc_update_state_prepare - Prepare the commit under the global lock.
+ * @scratch: commit scratch from dc_update_state_init()
+ *
+ * On failure the scratch slot is released and false is returned; the caller
+ * must not call execute or cleanup.
+ */
+bool dc_update_state_prepare(struct dc_update_scratch_space *scratch);
+
+/**
+ * dc_update_state_execute - Program hardware; called without the global lock.
+ * @scratch: commit scratch from dc_update_state_init()
+ */
+void dc_update_state_execute(const struct dc_update_scratch_space *scratch);
+
+/**
+ * dc_update_state_cleanup - Finalise the commit and release the scratch slot.
+ * @scratch: commit scratch from dc_update_state_init()
+ *
+ * Must be called with the global lock held. Returns true if the caller must
+ * loop back to prepare (SEAMLESS continuation).
+ */
+bool dc_update_state_cleanup(struct dc_update_scratch_space *scratch);
+
+/**
+ * struct dc_probe_latencies - min/max/avg memory latency in ns.
+ * @max_latency_ns: maximum latency in nanoseconds
+ * @avg_latency_ns: average latency in nanoseconds
+ * @min_latency_ns: minimum latency in nanoseconds
+ */
+struct dc_probe_latencies {
+	uint32_t max_latency_ns;
+	uint32_t avg_latency_ns;
+	uint32_t min_latency_ns;
+};
+
+/**
+ * struct dc_probe_status - results for a probe.
+ * @valid: true if a measurement was latched.
+ * @type: type of the probe that produced this result.
+ * @u.bandwidth_mbps:         peak BW in Mbps (DC_PROBE_PEAK_MEM_BW).
+ * @u.latency:                min/max/avg memory latency in ns (DC_PROBE_MEM_LATENCY),
+ *                            stored as struct dc_probe_latencies.
+ * @u.urgent_assertion_count: number of urgent assertion events (DC_PROBE_URGENT_ASSERTION_COUNT).
+ * @u.prefetch_data_size:     total prefetch data in bytes (DC_PROBE_PREFETCH_DATA_SIZE).
+ */
+struct dc_probe_status {
+	bool                       valid;
+	enum dc_probe_type         type;
+	union {
+		uint32_t bandwidth_mbps;
+		struct dc_probe_latencies latency;
+		uint32_t urgent_assertion_count;
+		uint32_t prefetch_data_size;
+	} u;
+};
+
 /**
  * enum dc_get_status_type - Bitmask selecting which status classes to populate.
  * @DC_GET_STATUS_STREAM: populate stream_status fields in dc_state_status
+ * @DC_GET_STATUS_PROBE:  populate probe_status fields in dc_state_status
  */
 enum dc_get_status_type {
 	DC_GET_STATUS_STREAM = (1u << 0),
+	DC_GET_STATUS_PROBE  = (1u << 1),
 };
 
 /**
@@ -2141,21 +2225,28 @@ enum dc_get_status_type {
  * @types:  OR of dc_get_status_type values selecting classes to populate
  * @stream: optional stream filter for DC_GET_STATUS_STREAM. NULL means
  *          populate status for all streams in the state
+ * @probe:  optional probe filter for DC_GET_STATUS_PROBE. NULL means
+ *          populate status for all probes in the state
  */
 struct dc_get_status_options {
 	struct dc_state              *state;
 	uint32_t                      types;
 	const struct dc_stream_state *stream;
+	const struct dc_probe_state  *probe;
 };
 
 /**
  * struct dc_state_status - Output-only status object from dc_state_get_status.
  * @stream_count: number of valid entries in stream_status (DC_GET_STATUS_STREAM)
  * @stream_status: pointers to live per-stream status entries
+ * @probe_count: number of valid entries in probe_status (DC_GET_STATUS_PROBE)
+ * @probe_status: pointers to live per-probe status entries
  */
 struct dc_state_status {
 	int                     stream_count;
 	struct dc_stream_status *stream_status[MAX_STREAMS];
+	int                     probe_count;
+	struct dc_probe_status *probe_status[MAX_PROBES];
 };
 
 /**
@@ -2163,9 +2254,6 @@ struct dc_state_status {
  * @status:  output object populated according to options->types
  * @options: selects the source state, status classes to fill, and filters
  *
- * dc_state_get_stream_status() is a thin shim over this function with
- * types = DC_GET_STATUS_STREAM and a stream filter.
- *
  * Return: DC_OK on success, DC_ERROR_UNEXPECTED if state is NULL.
  */
 enum dc_status dc_state_get_status(struct dc_state_status *status,
@@ -2258,6 +2346,16 @@ struct dc_validation_set {
 	 * @stream_count: Number of active entries in @streams
 	 */
 	uint8_t stream_count;
+
+	/**
+	 * @probes: Global probe descriptors to validate alongside the streams
+	 */
+	struct dc_probe_state probes[MAX_PROBES];
+
+	/**
+	 * @probe_count: Number of active entries in @probes
+	 */
+	uint8_t probe_count;
 };
 
 bool dc_validate_boot_timing(const struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index a866688ad9db..4530f294f1c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -329,7 +329,6 @@ struct dc_stream_state {
 
 	enum dc_drr_trigger_mode drr_trigger_mode;
 
-	struct dc_update_scratch_space *update_scratch;
 	bool firmware_controlled_hdr_info_packet;
 };
 
@@ -408,30 +407,8 @@ bool dc_update_planes_and_stream(struct dc *dc,
 		struct dc_stream_state *dc_stream,
 		struct dc_stream_update *stream_update);
 
-struct dc_update_scratch_space;
 struct dc_state_update;
 
-size_t dc_update_scratch_space_size(void);
-
-struct dc_update_scratch_space *dc_update_state_init(
-		struct dc *dc,
-		const struct dc_state_update *updates
-);
-
-// Locked, false is failed
-bool dc_update_state_prepare(
-		struct dc_update_scratch_space *scratch
-);
-
-// Unlocked
-void dc_update_state_execute(
-		const struct dc_update_scratch_space *scratch
-);
-
-// Locked, true if call again
-bool dc_update_state_cleanup(
-		struct dc_update_scratch_space *scratch
-);
 
 /*
  * Set up surface attributes and associate to a stream
@@ -516,10 +493,6 @@ void dc_enable_stereo(
 /* Triggers multi-stream synchronization. */
 void dc_trigger_sync(struct dc *dc, struct dc_state *context);
 
-struct dc_update_descriptor dc_check_state_update(
-		const struct dc_check_config *check_config,
-		struct dc_state_update *updates);
-
 /* Shim: packs args into dc_state_update and calls dc_check_state_update(). */
 struct dc_update_descriptor dc_check_update_surfaces_for_stream(
 		const struct dc_check_config *check_config,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 6754da1e6ee2..4549c435501a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -631,7 +631,7 @@ struct hubbub_perfmon_get_in_order_bw_params {
 struct hubbub_perfmon_get_memory_latencies_params {
 	struct hubbub                        *hubbub;
 	uint32_t                              refclk_mhz;
-	struct hubbub_system_latencies       *result;
+	struct dc_probe_latencies            *result;
 };
 
 struct hubbub_perfmon_get_urgent_assertion_count_params {
@@ -2377,7 +2377,7 @@ void hwss_add_hubbub_perfmon_get_in_order_bw(struct block_sequence_state *seq_st
 
 void hwss_add_hubbub_perfmon_get_memory_latencies(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub, uint32_t refclk_mhz,
-		struct hubbub_system_latencies *result);
+		struct dc_probe_latencies *result);
 
 void hwss_add_hubbub_perfmon_get_urgent_assertion_count(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub, uint32_t refclk_mhz,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index ac3e9eaa569c..e87f9fd60bcb 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -610,27 +610,6 @@ struct dc_dmub_cmd {
 	enum dm_dmub_wait_type wait_type;
 };
 
-/**
- * struct dc_probe_status - DC-internal latched perfmon results for a probe.
- * @valid: true if a measurement was latched this commit.
- * @type: type of the probe that produced this result.
- * @u.bandwidth_mbps:         peak BW in Mbps (DC_PROBE_PEAK_MEM_BW).
- * @u.latency:                min/max/avg memory latency in ns (DC_PROBE_MEM_LATENCY),
- *                            stored as struct hubbub_system_latencies.
- * @u.urgent_assertion_count: number of urgent assertion events (DC_PROBE_URGENT_ASSERTION_COUNT).
- * @u.prefetch_data_size:     total prefetch data in bytes (DC_PROBE_PREFETCH_DATA_SIZE).
- */
-struct dc_probe_status {
-	bool                       valid;
-	enum dc_probe_type         type;
-	union {
-		uint32_t bandwidth_mbps;
-		struct hubbub_system_latencies latency;
-		uint32_t urgent_assertion_count;
-		uint32_t prefetch_data_size;
-	} u;
-};
-
 /**
  * struct dc_state - The full description of a state requested by users
  */
@@ -774,4 +753,39 @@ struct dc_requested_memory_qos {
 	uint32_t max_bw_budget_in_mbps;
 };
 
+enum update_v3_flow {
+	UPDATE_V3_FLOW_INVALID,
+	UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST,
+	UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL,
+	UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS,
+	UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW,
+	UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT,
+};
+
+struct pipe_split_policy_backup {
+	bool dynamic_odm_policy;
+	bool subvp_policy;
+	enum pipe_split_policy mpc_policy;
+	char force_odm[MAX_PIPES];
+};
+
+struct dc_update_scratch_space {
+	struct dc *dc;
+	struct dc_surface_update *surface_updates;
+	int surface_count;
+	struct dc_stream_state *stream;
+	struct dc_stream_update *stream_update;
+	const struct dc_probe_updates *probe_updates;
+	bool update_v3;
+	bool do_clear_update_bits;
+	enum dc_update_type update_type;
+	struct dc_state *new_context;
+	enum update_v3_flow flow;
+	struct dc_state *backup_context;
+	struct dc_state *intermediate_context;
+	struct pipe_split_policy_backup intermediate_policy;
+	struct dc_surface_update intermediate_updates[MAX_SURFACES];
+	int intermediate_count;
+};
+
 #endif /* _CORE_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index fd742b320128..02bc0010e565 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -145,12 +145,6 @@ struct dcn_hubbub_reg_state {
 	uint32_t compbuf_ctrl;
 };
 
-struct hubbub_system_latencies {
-	uint32_t max_latency_ns;
-	uint32_t avg_latency_ns;
-	uint32_t min_latency_ns;
-};
-
 struct hubbub_urgent_latency_params {
 	uint32_t refclk_mhz;
 	uint32_t t_win_ns;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index b64ba8c0adb1..d3171e70e07c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -582,6 +582,10 @@ bool resource_validate_attach_surfaces(
 		struct dc_state *context,
 		const struct resource_pool *pool);
 
+enum dc_status resource_validate_probe_set(struct dc *dc,
+		const struct dc_probe_state *probes,
+		uint8_t probe_count);
+
 enum dc_status resource_map_clock_resources(
 		const struct dc *dc,
 		struct dc_state *context,
-- 
2.43.0

