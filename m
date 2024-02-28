Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F71C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D4E10E47F;
	Wed, 28 Feb 2024 18:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zoKbnlzM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C2C10E47F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUSx5oSnw//G50VobrqwZwNXzhmzSTEBMmCwbrXFuJAEOm5rjOHZWCAyG20LN9wVPcwMtOdvsLDi0fcJRYBHgr0kkCMXM7iC9+KT1bMr0KfBLl3uBRL35bvVfyLq+BizcSWyLA0vyFz1W2JAK4OeY1n42EVm/cc7zUCmxgpJUQWlNE0T7kr8oNmy7kt8aSxR6whhHv6cZaZHD/YpbIf9sPEDfkvc2rcCJ/8s/t4X1asnlPWpShDPKFRuZKQY4vTJs8l0SZQojnOdpExIOlUKPgQsJFiirshfuXh+moA6kb/CTJ4E8wmq/RzxoQEK/dOr9MM7NWEqnqlwKkEZKwOBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipUFec7YByyf8/ZZTcCzUF/J7Ovn05gsnxT/GZjehOQ=;
 b=gKGNtEtFh2/UanWoeCpVjDsMCGrt6+QLQTYddIQt7AYBZyMx+kKXYckaQr4njkca+06UZInzG8E68N9i+AgyhPVfwvRhsLDKNsoAYlG1N/IVpFqnh9r3tJsQGCjWYFLozD3KkvJ1xbxeXOBXYMVkiOAjLfONrIbBlQOFbXqzUZkLXr6dWIb4uibLblvlaL2oVpTmi6cHFqFCPJFddSGC9FxEOl5CtHZdyEncpxh6Ve9lfIfUwpxq3ilGDH0Jq4k3t08kGdDeJWReirBZ37QphQGVoJoJz4DHPtxGYxedn+x1dhPFm4ndP4SkqUCbRKNTUHfVYSUSALCq83rC/cEByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipUFec7YByyf8/ZZTcCzUF/J7Ovn05gsnxT/GZjehOQ=;
 b=zoKbnlzM8bjqQNDqQSXzZv9carBHv7HrEkgc/KI1ngVsWI4mp0GkiGHzyXv6XIxh4aDmZkA0sKNytl33kvmp23IEevswHoozGiK4HkpXywoeOXD2y9RdPy4qa1dV2JEjWrubu9vaSBI9gvA2sdkjUKHejqOBVregenxQzMzi/vQ=
Received: from CY5PR15CA0209.namprd15.prod.outlook.com (2603:10b6:930:82::27)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 18:43:02 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::32) by CY5PR15CA0209.outlook.office365.com
 (2603:10b6:930:82::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:43:02 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:42:59 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 10/34] drm/amd/display: Add debug prints for IPS testing
Date: Wed, 28 Feb 2024 11:39:16 -0700
Message-ID: <20240228183940.1883742-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4776421b-4977-48ba-2a6a-08dc388d17df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UyPtsNa/m/rSgh2ZNIBtFTprIUlv0E5XJonRlqVR05l/c7XPvmUOuvmlhP/6O7jce5y56zpHn+UyWc6SggNvKjiaCVD2B2ZTFxpuivRxIFjpcm/+15eSx8d1W/qkpAKA/6B2Zkedl7vH03EgQeUwv61uB6IIOokH0yzacsx2dIuAiYJT/7m14n8jNt5d7Y53LFJMXwXrrLIMtwG1AIEE1BNHYXAchfrmr4gavSlBlNrO87sgYJHM7aaAhi3ZGxb9b9NtQDmf7k9Onkkkw1IDp3j8vUK8Mf5IB21QwLonDmOcelXtqvFMy3W2dqxrEqspn+aoCI07fbrcTWMbA/3kzeQS3QWEY6uMkPN8AizzrNm8RhiZJHhZrZhqkZwP7dmShfoT35nsjH1eqXU6yjOSYj8z7SEWK/LX6XJF7iIOfw1hzHkd+nsurg87q0/3PCREgpzLJ4QOdOCIjHh3girs3Y2UGZxekGULVF9mNZPlc4E+bljhXAicFIsnWDq34DaAqSG1CL5cyf96DepCru0RDEwM0xpoIZ4ry3gTFH4sMe6Vx6jEgZrvidq7YTPeB6iiC+M9wnfeNGb6WwSloAmLP6PgQKKi4L1CZRqQjtHvVFcUHki70dKZV9bwG8892TzOL0MgxO4nmvYquG9gZ9qoyg/Nrk+WZEgPoYpnWfmfwChw5U2G0XHOHbx3I7jRSdbIEYqavYhWgfo/ymzmcf41ogpYPe15w2Iar0Tn7ucJN8U3+XsQxS6s2Wfn18jdM9Zp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:43:02.0875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4776421b-4977-48ba-2a6a-08dc388d17df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[WHY]
To log commit states and when we transition in/out of allow and idle
states and the caller.

[HOW]
Add a new logging helper and wrap idle optimization calls to receive
the caller.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 10 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  7 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 73 +++++++++++++++++++
 .../drm/amd/display/include/logger_types.h    |  1 +
 4 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 613d09c42f3b..501e0298623a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4820,11 +4820,15 @@ bool dc_set_replay_allow_active(struct dc *dc, bool active)
 	return true;
 }
 
-void dc_allow_idle_optimizations(struct dc *dc, bool allow)
+void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const *caller_name)
 {
 	if (dc->debug.disable_idle_power_optimizations)
 		return;
 
+	if (allow != dc->idle_optimizations_allowed)
+		DC_LOG_IPS("%s: allow_idle old=%d new=%d (caller=%s)\n", __func__,
+			   dc->idle_optimizations_allowed, allow, caller_name);
+
 	if (dc->caps.ips_support && (dc->config.disable_ips == DMUB_IPS_DISABLE_ALL))
 		return;
 
@@ -4839,10 +4843,10 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 		dc->idle_optimizations_allowed = allow;
 }
 
-void dc_exit_ips_for_hw_access(struct dc *dc)
+void dc_exit_ips_for_hw_access_internal(struct dc *dc, const char *caller_name)
 {
 	if (dc->caps.ips_support)
-		dc_allow_idle_optimizations(dc, false);
+		dc_allow_idle_optimizations_internal(dc, false, caller_name);
 }
 
 bool dc_dmub_is_ips_idle_state(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c1d8288a08b3..c9485a7744d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2339,8 +2339,11 @@ void dc_get_clock(struct dc *dc, enum dc_clock_type clock_type, struct dc_clock_
 bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_state *plane,
 				struct dc_cursor_attributes *cursor_attr);
 
-void dc_allow_idle_optimizations(struct dc *dc, bool allow);
-void dc_exit_ips_for_hw_access(struct dc *dc);
+#define dc_allow_idle_optimizations(dc, allow) dc_allow_idle_optimizations_internal(dc, allow, __func__)
+#define dc_exit_ips_for_hw_access(dc) dc_exit_ips_for_hw_access_internal(dc, __func__)
+
+void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, const char *caller_name);
+void dc_exit_ips_for_hw_access_internal(struct dc *dc, const char *caller_name);
 bool dc_dmub_is_ips_idle_state(struct dc *dc);
 
 /* set min and max memory clock to lowest and highest DPM level, respectively */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 6083b1dcf050..b168dfc79381 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -910,6 +910,8 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 		return;
 	}
 
+	DC_LOG_ERROR("%s: DMCUB error - collecting diagnostic data\n", __func__);
+
 	if (!dc_dmub_srv_get_diagnostic_data(dc_dmub_srv, &diag_data)) {
 		DC_LOG_ERROR("%s: dc_dmub_srv_get_diagnostic_data failed.", __func__);
 		return;
@@ -1201,6 +1203,7 @@ bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 
 static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 {
+	volatile const struct dmub_shared_state_ips_fw *ips_fw;
 	struct dc_dmub_srv *dc_dmub_srv;
 	union dmub_rb_cmd cmd = {0};
 
@@ -1211,6 +1214,7 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 		return;
 
 	dc_dmub_srv = dc->ctx->dmub_srv;
+	ips_fw = &dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_FW].data.ips_fw;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.idle_opt_notify_idle.header.type = DMUB_CMD__IDLE_OPT;
@@ -1226,6 +1230,12 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 			&dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_DRIVER].data.ips_driver;
 		union dmub_shared_state_ips_driver_signals new_signals;
 
+		DC_LOG_IPS(
+			"%s wait idle (ips1_commit=%d ips2_commit=%d)",
+			__func__,
+			ips_fw->signals.bits.ips1_commit,
+			ips_fw->signals.bits.ips2_commit);
+
 		dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
 
 		memset(&new_signals, 0, sizeof(new_signals));
@@ -1250,6 +1260,13 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 		ips_driver->signals = new_signals;
 	}
 
+	DC_LOG_IPS(
+		"%s send allow_idle=%d (ips1_commit=%d ips2_commit=%d)",
+		__func__,
+		allow_idle,
+		ips_fw->signals.bits.ips1_commit,
+		ips_fw->signals.bits.ips2_commit);
+
 	/* NOTE: This does not use the "wake" interface since this is part of the wake path. */
 	/* We also do not perform a wait since DMCUB could enter idle after the notification. */
 	dm_execute_dmub_cmd(dc->ctx, &cmd, allow_idle ? DM_DMUB_WAIT_TYPE_NO_WAIT : DM_DMUB_WAIT_TYPE_WAIT);
@@ -1276,38 +1293,92 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 
 		ips_driver->signals.all = 0;
 
+		DC_LOG_IPS(
+			"%s check (allow_ips1=%d allow_ips2=%d) (ips1_commit=%d ips2_commit=%d)",
+			__func__,
+			ips_driver->signals.bits.allow_ips1,
+			ips_driver->signals.bits.allow_ips2,
+			ips_fw->signals.bits.ips1_commit,
+			ips_fw->signals.bits.ips2_commit);
+
 		if (prev_driver_signals.bits.allow_ips2) {
+			DC_LOG_IPS(
+				"wait IPS2 eval (ips1_commit=%d ips2_commit=%d)",
+				ips_fw->signals.bits.ips1_commit,
+				ips_fw->signals.bits.ips2_commit);
+
 			udelay(dc->debug.ips2_eval_delay_us);
 
 			if (ips_fw->signals.bits.ips2_commit) {
+				DC_LOG_IPS(
+					"exit IPS2 #1 (ips1_commit=%d ips2_commit=%d)",
+					ips_fw->signals.bits.ips1_commit,
+					ips_fw->signals.bits.ips2_commit);
+
 				// Tell PMFW to exit low power state
 				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
+				DC_LOG_IPS(
+					"wait IPS2 entry delay (ips1_commit=%d ips2_commit=%d)",
+					ips_fw->signals.bits.ips1_commit,
+					ips_fw->signals.bits.ips2_commit);
+
 				// Wait for IPS2 entry upper bound
 				udelay(dc->debug.ips2_entry_delay_us);
 
+				DC_LOG_IPS(
+					"exit IPS2 #2 (ips1_commit=%d ips2_commit=%d)",
+					ips_fw->signals.bits.ips1_commit,
+					ips_fw->signals.bits.ips2_commit);
+
 				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
+				DC_LOG_IPS(
+					"wait IPS2 commit clear (ips1_commit=%d ips2_commit=%d)",
+					ips_fw->signals.bits.ips1_commit,
+					ips_fw->signals.bits.ips2_commit);
+
 				while (ips_fw->signals.bits.ips2_commit)
 					udelay(1);
 
+				DC_LOG_IPS(
+					"wait hw_pwr_up (ips1_commit=%d ips2_commit=%d)",
+					ips_fw->signals.bits.ips1_commit,
+					ips_fw->signals.bits.ips2_commit);
+
 				if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
 					ASSERT(0);
 
+				DC_LOG_IPS(
+					"resync inbox1 (ips1_commit=%d ips2_commit=%d)",
+					ips_fw->signals.bits.ips1_commit,
+					ips_fw->signals.bits.ips2_commit);
+
 				dmub_srv_sync_inbox1(dc->ctx->dmub_srv->dmub);
 			}
 		}
 
 		dc_dmub_srv_notify_idle(dc, false);
 		if (prev_driver_signals.bits.allow_ips1) {
+			DC_LOG_IPS(
+				"wait for IPS1 commit clear (ips1_commit=%d ips2_commit=%d)",
+				ips_fw->signals.bits.ips1_commit,
+				ips_fw->signals.bits.ips2_commit);
+
 			while (ips_fw->signals.bits.ips1_commit)
 				udelay(1);
 
+			DC_LOG_IPS(
+				"wait for IPS1 commit clear done (ips1_commit=%d ips2_commit=%d)",
+				ips_fw->signals.bits.ips1_commit,
+				ips_fw->signals.bits.ips2_commit);
 		}
 	}
 
 	if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
 		ASSERT(0);
+
+	DC_LOG_IPS("%s exited", __func__);
 }
 
 void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_cm_power_state powerState)
@@ -1335,6 +1406,8 @@ void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_
 	if (dc_dmub_srv->idle_allowed == allow_idle)
 		return;
 
+	DC_LOG_IPS("%s state change: old=%d new=%d", __func__, dc_dmub_srv->idle_allowed, allow_idle);
+
 	/*
 	 * Entering a low power state requires a driver notification.
 	 * Powering up the hardware requires notifying PMFW and DMCUB.
diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index f39e2785e618..83479951732a 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -64,6 +64,7 @@
 #define DC_LOG_DWB(...) drm_dbg((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_DP2(...) drm_dbg_dp((DC_LOGGER)->dev, __VA_ARGS__)
 #define DC_LOG_AUTO_DPM_TEST(...) pr_debug("[AutoDPMTest]: "__VA_ARGS__)
+#define DC_LOG_IPS(...) pr_debug("[IPS]: "__VA_ARGS__)
 
 struct dc_log_buffer_ctx {
 	char *buf;
-- 
2.34.1

