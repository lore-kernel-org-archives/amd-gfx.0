Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76254ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D563D10EB7D;
	Sat, 27 Aug 2022 02:51:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5979F10EB7A
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv6T1R2yPSW3r1uBPXMWYywXCj5lkEVWp53JP495vtnSctjF2VJ10HMdjUu4AG623G+rC1iK0D+lP4i0orUEXc6CkhUocbMCfVZx1CPpwairvVlwbI3L8gmuC/4S3PpMjz641ajKHxxuxgNps0y4ZXQLgTIeQYTu8V3tJ6Dcy2vqQXd3x2W5EcgJmIZ1sP1P9QS5Pv2JzK7acttVv7PHspj0n4OOSHJvAyJN7uv5DXM6F/cPjkCkPPAY+hHwj7ACW3nnZmngiU9CXYcpLE7yoJX76HYeQwV65Kbty5/sw9GLck58YC1L7tfI2jiw9VBH5Q2oB67tVCZU7RtlaUUhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/gQVZVLF3gZVRkdzZGcPMpn/QE6pQE8fS5GoJhET0w=;
 b=i0R7vw1RfEibQ/xDlfx1zPVLB90IltnqBPCl1eE0rzwcAq9psHqXIpbqk8tH0XaMTjOXA1ALfgzhjYXDQa1SqkfYakErL3rZGWFUIUYyrNx63pIhtNm+9c8UyYQGAhC0B9WQXamtDC7wnZkRdKEnDQK0hzCkQ35mJ3pg2Ph31tVVZRo7NpeIe/g9HliK1VpqWg8p61F3B4/3zzX6ZChPzrvekisF7V5lgu8q61eIR+aM+BPgz/ZnU0xKsRl/3j6oI8RlimLJMMk0ASdBPe9X8/IcaMuOKDfgjDTA2lxnUYkXopj1AXR7WFW1Z/t+ArEcFyALyw7L8kqLkW8t4ud5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/gQVZVLF3gZVRkdzZGcPMpn/QE6pQE8fS5GoJhET0w=;
 b=x//gi3J/QxEm6Ek5KnYVeiqlun/rwFyVFzndyBvTIPjK4I08Ga1GB/aZiUrUFLDN4BksBL3fZ+bxCohLygwqodJ1CmuQ5C2ud0RzKXgWyAM60jY65WWIBigNXVMt7tU6OD6MGwLgQ4pjIHCHXrvab1cdx3sGRQOEv7nufYgRZ5k=
Received: from DS7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::33) by
 MWHPR12MB1200.namprd12.prod.outlook.com (2603:10b6:300:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Sat, 27 Aug 2022 02:51:34 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::df) by DS7P222CA0018.outlook.office365.com
 (2603:10b6:8:2e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:51:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 19:51:33 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:51:30
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/33] drm/amd/display: Refactor edp dsc codes.
Date: Sat, 27 Aug 2022 06:50:38 +0800
Message-ID: <20220826225053.1435588-19-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f431ba69-9665-4c61-6ec9-08da87d70de8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1200:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZh2X+SuRwKenm1nMmrslDCoJtLB8yVGO1HH7uubvAXK9/pxYQf2hNYz1pRFdaZHAf7Z4781mQUVh0PDmgzwRGh6Copi/111Bm3SfoaEtCAMzQeYGbi2l/gkpnhfxp6dpS5hJ0jAPCYM5ctAzTRs9lI27DFag5It87iGUdWT3Kt/hpN1lFOSYRIItbrkumM8Jo7ySEiVS5UajEXNSswIQBmhsFKmZhNxqwi7M8syyB3aEoKVH3/34rA3yHU8uVlT1iJ6+mnRqI9hc6lWE2Vr+U8bA7CjfWz6cDjoDNVqzmsuwpsRPtITMri5C6DzBIDLOBSH82ALBv+Vqi7BKqHHaH3AFtjW34MUUMv32TlTWTwqrx3m6J3QS9oqEiSLlTk9zuo6N1w0BPWL9K71u7XdMcaQ5smFu2mGqQCu3HIS7J9yHzmgn4sJWm3tM+9iESfEB8dAbEcdoQ+qrdcVuIyvuzK3xeO2zs/XKAycuDn7x+SpJB7WnhaazjwKrWzCQu1oICxibWOGFyKFAA9HhnEw8KdNEGo/u5dDR7gcuBZjNEdjFnW0MfE9QEmvT7fsctQWvArhxpvb/wEehSiBWpRmP+DTCQBneSzU2F8DUkepZyKay17YKSuyMJ4aiMGM4474uqXztpxIAbBAgMAebBkYpO/W6WWGj//Aw0jeZToRvpmJANFAaxPZ+lJi60X3H6wLl/nH2HKeSwlSQSZwa13vrlOrObmWxitHkvt/zxC/Z+tZkRY3sbrOptc0SXwmKiZ7Ts2K2BifVpStUUyz5CVkHxfhcACDkoVUs1e2H+q6zq/ApqZlDHT4uZ4CpVt5oOeU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(40470700004)(36840700001)(46966006)(1076003)(2616005)(426003)(47076005)(5660300002)(82310400005)(70206006)(4326008)(8676002)(8936002)(41300700001)(36756003)(336012)(83380400001)(186003)(26005)(478600001)(7696005)(40480700001)(81166007)(356005)(40460700003)(82740400003)(86362001)(36860700001)(6916009)(54906003)(2906002)(316002)(70586007)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:34.6463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f431ba69-9665-4c61-6ec9-08da87d70de8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1200
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>,
 Mike Hsieh <mike.hsieh@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

Refactor edp dsc codes.

We split out edp dsc config from "global" to "per-panel" config settings.

Reviewed-by: Mike Hsieh <mike.hsieh@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 10 +++++++++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 --
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  7 ++++++-
 7 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 35b0d6a28726..62378f8694c0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1527,7 +1527,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC) {
 		adev->dm.dc->debug.disable_dsc = true;
-		adev->dm.dc->debug.disable_dsc_edp = true;
 	}
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
@@ -5627,7 +5626,8 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	dc_dsc_policy_set_enable_dsc_when_not_needed(
 		aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
 
-	if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_EDP && !dc->debug.disable_dsc_edp &&
+	if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_EDP &&
+	    !aconnector->dc_link->panel_config.dsc.disable_dsc_edp &&
 	    dc->caps.edp_dsc_support && aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE) {
 
 		apply_dsc_policy_for_edp(aconnector, sink, stream, dsc_caps, max_dsc_target_bpp_limit_override);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index bd364d2cc4f7..0b7440b92c10 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -916,6 +916,25 @@ void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigne
 	//amdgpu_device_gpu_recover(dc_context->driver-context, NULL);
 }
 
+void dm_helpers_init_panel_settings(
+	struct dc_context *ctx,
+	struct dc_panel_config *panel_config)
+{
+	// Feature DSC
+	panel_config->dsc.disable_dsc_edp = false;
+	panel_config->dsc.force_dsc_edp_policy = 0;
+}
+
+void dm_helpers_override_panel_settings(
+	struct dc_context *ctx,
+	struct dc_panel_config *panel_config)
+{
+	// Feature DSC
+	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC) {
+		panel_config->dsc.disable_dsc_edp = true;
+	}
+}
+
 void *dm_helpers_allocate_gpu_mem(
 		struct dc_context *ctx,
 		enum dc_gpu_mem_alloc_type type,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 66d2ae7aacf5..74db87f3dc6f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1311,6 +1311,14 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 				sink->edid_caps.audio_modes[i].sample_rate,
 				sink->edid_caps.audio_modes[i].sample_size);
 		}
+
+		if (link->connector_signal == SIGNAL_TYPE_EDP) {
+			// Init dc_panel_config
+			dm_helpers_init_panel_settings(dc_ctx, &link->panel_config);
+			// Override dc_panel_config if system has specific settings
+			dm_helpers_override_panel_settings(dc_ctx, &link->panel_config);
+		}
+
 	} else {
 		/* From Connected-to-Disconnected. */
 		link->type = dc_connection_none;
@@ -4736,7 +4744,7 @@ bool dc_link_should_enable_fec(const struct dc_link *link)
 	else if (link->connector_signal == SIGNAL_TYPE_EDP
 			&& (link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.
 			 dsc_support.DSC_SUPPORT == false
-				|| link->dc->debug.disable_dsc_edp
+				|| link->panel_config.dsc.disable_dsc_edp
 				|| !link->dc->caps.edp_dsc_support))
 		force_disable = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 7e97265b76e8..11e13c45a338 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3743,7 +3743,7 @@ static bool decide_edp_link_settings_with_dsc(struct dc_link *link,
 
 	unsigned int policy = 0;
 
-	policy = link->ctx->dc->debug.force_dsc_edp_policy;
+	policy = link->panel_config.dsc.force_dsc_edp_policy;
 	if (max_link_rate == LINK_RATE_UNKNOWN)
 		max_link_rate = link->verified_link_cap.link_rate;
 	/*
@@ -3909,7 +3909,7 @@ bool decide_link_settings(struct dc_stream_state *stream,
 		if (stream->timing.flags.DSC) {
 			enum dc_link_rate max_link_rate = LINK_RATE_UNKNOWN;
 
-			if (link->ctx->dc->debug.force_dsc_edp_policy) {
+			if (link->panel_config.dsc.force_dsc_edp_policy) {
 				/* calculate link max link rate cap*/
 				struct dc_link_settings tmp_link_setting;
 				struct dc_crtc_timing tmp_timing = stream->timing;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a53863bddee0..9cde9465f5ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -803,8 +803,6 @@ struct dc_debug_options {
 	bool validate_dml_output;
 	bool enable_dmcub_surface_flip;
 	bool usbc_combo_phy_reset_wa;
-	bool disable_dsc_edp;
-	unsigned int  force_dsc_edp_policy;
 	bool enable_dram_clock_change_one_display_vactive;
 	/* TODO - remove once tested */
 	bool legacy_dp2_lt;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index d1214944839f..43d250918fd0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -113,6 +113,15 @@ struct psr_settings {
 	unsigned int psr_power_opt;
 };
 
+/* To split out "global" and "per-panel" config settings.
+ * Add a struct dc_panel_config under dc_link
+ */
+struct dc_panel_config {
+	struct dsc {
+		bool disable_dsc_edp;
+		unsigned int force_dsc_edp_policy;
+	} dsc;
+};
 /*
  * A link contains one or more sinks and their connected status.
  * The currently active signal type (HDMI, DP-SST, DP-MST) is also reported.
@@ -233,6 +242,7 @@ struct dc_link {
 
 	struct gpio *hpd_gpio;
 	enum dc_link_fec_state fec_state;
+	struct dc_panel_config panel_config;
 	enum phy_state phy_state;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index fb6a2d7b6470..6e4d3df0454e 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -171,7 +171,12 @@ void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigne
 // 0x1 = Result_OK, 0xFE = Result_UnkmownCmd, 0x0 = Status_Busy
 #define IS_SMU_TIMEOUT(result) \
 	(result == 0x0)
-
+void dm_helpers_init_panel_settings(
+	struct dc_context *ctx,
+	struct dc_panel_config *config);
+void dm_helpers_override_panel_settings(
+	struct dc_context *ctx,
+	struct dc_panel_config *config);
 int dm_helper_dmub_aux_transfer_sync(
 		struct dc_context *ctx,
 		const struct dc_link *link,
-- 
2.25.1

