Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBC0C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DBB10EB59;
	Tue,  8 Sep 2026 11:38:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="29HD30Jq";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6710410EB56
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OegZgY1dO9zhmtF8lRrcOQrSHFUiLFYa3mmZqQaFwdY86Jw9eKzTMWRI2RkZ023AClM+ovEYt8qiuaq9+95APlCuetE8U2qWV0xqc7pLvNUdYgLyM+Dl9PGFS+M3Dqrq5hQiBgQvwbAX8hdNitcSA+w3b9rGGejoKWx+kUaBjQznMzw5XNwWfNrypHBQqSJ/Mh2MheF92f/fTVEgd4um4zPFHwRjuTD1tIXwkNdrS8Ckqwoiz2OMVl2TQ49cLjcm1W+kZIqW1xy6I1zngxbEfRL/PtiSDmVaDlUZSIptoS5xPIyeyFOHbFHCjFuxt2dXY5hV7QR+HkPlZtZBOMN6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTMPZS9CKSrrlK/Sg8NQFqEAOcUaFG0Y5I0cmJ/ZNrY=;
 b=kPBC8pADkPKxhOBTlc2PvghjdQjN7c4onVjafcUapW0oyOCIHGXlGaTKxxsDwfJQg4357FuLqxdwQLzUjZGF0+Ox51jr5Wv6yxphrPTj4fRAHGinJCuLRdKDvYYqZtbE+H6+GkbOBSVwOyJryGiE8o0yZk78ls7y8c+1I9BJ9OIi0/THuLR9OSYtPyysPh6nWRKh/F4Hx5ackycoual0Sdj4a3CMTioGV8b1SaPyCUPbS/xHQRzX8x0OmOMwZ7eHq2+t0xwoI4y1fW8EN9NDsFr1DzfJoT4n3TG6DeM7KH+Nu+I54E+WfbzGhGoT2dqmf9WJXMLy6xSBRY1MB5lulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTMPZS9CKSrrlK/Sg8NQFqEAOcUaFG0Y5I0cmJ/ZNrY=;
 b=29HD30JqDpsTgORlP0jmjnLx3r9bjIqcfT6QCZaKNfXc/97xi89i7xrAj1zU/P5ACBcVkdVsydI0OWEy/6KLhmQDXmDJK+KkVWrvv2U7SbUrnDKI3Rr3j8h9xcmIyDZno60z5GVau6cD2cRt5T5EvZV8DqYCiIJfXOr9pkgHeU0=
Received: from BN9PR03CA0245.namprd03.prod.outlook.com (2603:10b6:408:ff::10)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:38:50 +0000
Received: from BN2PEPF0000A88E.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::ad) by BN9PR03CA0245.outlook.office365.com
 (2603:10b6:408:ff::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88E.mail.protection.outlook.com (10.167.248.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:38:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:38:49 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:38:40 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wei-Guang Li <wei-guang.li@amd.com>, Jack Chang
 <jack.chang@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 34/66] drm/amd/display: Add Replay cumulative residency query
Date: Tue, 8 Sep 2026 19:31:27 +0800
Message-ID: <20260908113338.2433445-35-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88E:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e425c2-a45a-4e59-2dd5-08df0d9dc077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|6133799003|56012099006|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: D8sxXk+Gk4949wPhkggg6BGi8GcrmSZ3hW+LMOyKys8rbx/jSKkwjfwkNR8KjrtS3Fb/k2fPfU+mNN+4lvNMOb4d3MJ09Fak7Db6KIyWAxgEAVFdMf8cQZ3zXs2eoVPKC1VEeiOVBPJOFQKkwKolcDnuxrLRTgYZ5CYcUKYeBypQUNojggdLm8G4a7a/wmr0+AscqVw1tLSFJ6dwU1lJS8BaUKL+2POcfYYAInal2teJUIzCH8buA4qK7amdZewCNk2IniMnX7WMTVLywGDtGyWBlNIXYEcdNLe63JZOucfub3laZZp1eEiIp2rZKXcfkYU/mtvqAxWIJDo7/UqFqtqvr/XoXOI2K+Uks7CUQTXRavQ8TWyCk2D4FMQLJAE2VQFa7p2OHe/jdhNQo0SFVpdXRuOj+wAf2qDHUAlMhTMn+dYblRpGFPvLPA0uH7BN2LtAP0iqjhpE52l8hfdpBm8uKA8E+r/h82hpuM2wRzGKQctw3VpIR4kHlEqJnSehcvKolou2XgBzu81wEqS6qEiU0zFl2NAVzNDtTDu5V8mCU/5t32yXRTSfQP5B72A2f+4Ui6RJSfQoCHVwaVglncVF+Qx4Hyr0/vA2O2Ogdxt8HONghqmzKmMuRT+hXvhOIat/M3dGxDX6rtErUju/ongg0VuDiz/KpXB2Vhzh+Xo/o7yAb/OkI3ivTaUokzHyZDjGvRbT0xWsDDHmuMrQ9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(6133799003)(56012099006)(3023799007)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bi0IC9E9gyFzlg5CDFXqB9RJdegIVShF7XS1EE5viaGCyTTJoZzuJUXdnCl3bfCVjzPEg23Y2u2g4vJ6bD47LrPMKaTd+azF7kvYdPWIMp6vdd6GQLkwkxibqNXcK02TBZrIzUWyVppn1zXU4CDa9N7egQHAxfZ6YTVHviLWl63+ELUioe9FXdzpcGuyKDoGq+OV0H8dEBnOilMEXY2jafKjKtC9l74VTdywW+Gvfaqz5CRi9n1CmK3xLDBVLsqpJs4MAOUSAjSwZzjB/WSf4aAdCHQE1spN4dtgYD+2fTf3iRKIWXR8+A3278pyM2BogLoFb2m8YasX+Fq3GEmK8lb5geHyDDGCwBHIGuA/iAS5ZbYcAiNNBm2xnxyc6VOFboJ96OwonVzyq1J8COWHtvQzXUL6MvPfy4P7K/lnMMFP08ev4kh1kKkHnPXV4bXB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:38:49.9568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e425c2-a45a-4e59-2dd5-08df0d9dc077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
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

From: Wei-Guang Li <wei-guang.li@amd.com>

[Why&How]
Add driver-side support for querying boot-time cumulative PHY-off
residency via the REPLAY_SNAPSHOT_CUMULATIVE_RESIDENCY GPINT command
implemented in DMUB FW.

Reviewed-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Wei-Guang Li <wei-guang.li@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 25 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  2 ++
 .../gpu/drm/amd/display/dc/inc/link_service.h |  2 ++
 .../drm/amd/display/dc/link/link_factory.c    |  1 +
 .../link/protocols/link_edp_panel_control.c   | 22 ++++++++++++++++
 .../link/protocols/link_edp_panel_control.h   |  2 ++
 .../drm/amd/display/modules/inc/mod_power.h   |  3 +++
 .../amd/display/modules/power/power_replay.c  | 13 ++++++++++
 8 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index eda3a2f1402c..0785a30eb643 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -415,6 +415,30 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 	dc_wake_and_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
+static bool dmub_replay_get_cumulative_residency(struct dmub_replay *dmub,
+	uint8_t panel_inst, uint32_t *residency_milli_pct)
+{
+	uint32_t milli_pct = 0;
+	uint16_t param = (uint16_t)panel_inst;
+
+	if (!residency_milli_pct)
+		return false;
+
+	/* Zero on failure so the caller never reads a stale value, and report
+	 * false so a failed query is still distinguishable from a genuine 0%.
+	 */
+	*residency_milli_pct = 0;
+
+	if (!dc_wake_and_execute_gpint(dmub->ctx,
+			DMUB_GPINT__REPLAY_SNAPSHOT_CUMULATIVE_RESIDENCY,
+			param, &milli_pct, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+		return false;
+
+	*residency_milli_pct = milli_pct;
+
+	return true;
+}
+
 static const struct dmub_replay_funcs replay_funcs = {
 	.replay_copy_settings				= dmub_replay_copy_settings,
 	.replay_enable					= dmub_replay_enable,
@@ -424,6 +448,7 @@ static const struct dmub_replay_funcs replay_funcs = {
 	.replay_residency				= dmub_replay_residency,
 	.replay_set_power_opt_and_coasting_vtotal	= dmub_replay_set_power_opt_and_coasting_vtotal,
 	.replay_send_cmd				= dmub_replay_send_cmd,
+	.replay_get_cumulative_residency		= dmub_replay_get_cumulative_residency,
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index 07c79739a980..271a42a226e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -33,6 +33,8 @@ struct dmub_replay_funcs {
 	void (*replay_set_power_opt_and_coasting_vtotal)(struct dmub_replay *dmub,
 		unsigned int power_opt, uint8_t panel_inst, uint32_t coasting_vtotal,
 		uint16_t frame_skip_number);
+	bool (*replay_get_cumulative_residency)(struct dmub_replay *dmub,
+		uint8_t panel_inst, uint32_t *residency_milli_pct);
 };
 
 struct dmub_replay *dmub_replay_create(struct dc_context *ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index eaf20ca14bcc..b2f86c51d470 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -297,6 +297,8 @@ struct link_service {
 	bool (*edp_replay_residency)(const struct dc_link *link,
 			unsigned int *residency, const bool is_start,
 			const enum pr_residency_mode mode);
+	bool (*edp_replay_get_cumulative_residency)(const struct dc_link *link,
+			uint32_t *residency_milli_pct);
 	bool (*edp_set_replay_power_opt_and_coasting_vtotal)(struct dc_link *link,
 			const unsigned int *power_opts, uint32_t coasting_vtotal, uint16_t frame_skip_number);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index fa281de1d566..3b192c539f8b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -223,6 +223,7 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 	link_srv->edp_send_replay_cmd = edp_send_replay_cmd;
 	link_srv->edp_set_coasting_vtotal = edp_set_coasting_vtotal;
 	link_srv->edp_replay_residency = edp_replay_residency;
+	link_srv->edp_replay_get_cumulative_residency = edp_replay_get_cumulative_residency;
 	link_srv->edp_set_replay_power_opt_and_coasting_vtotal = edp_set_replay_power_opt_and_coasting_vtotal;
 
 	link_srv->edp_wait_for_t12 = edp_wait_for_t12;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 9883216dcc9d..e904c7dd320e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1154,6 +1154,28 @@ bool edp_replay_residency(const struct dc_link *link,
 	return true;
 }
 
+bool edp_replay_get_cumulative_residency(const struct dc_link *link,
+	uint32_t *residency_milli_pct)
+{
+	struct dc *dc = link->ctx->dc;
+	struct dmub_replay *replay = dc->res_pool->replay;
+	unsigned int panel_inst;
+
+	if (!dp_pr_get_pr_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	if (replay && link->replay_settings.replay_feature_enabled &&
+	    replay->funcs->replay_get_cumulative_residency)
+		return replay->funcs->replay_get_cumulative_residency(replay,
+			(uint8_t)panel_inst, residency_milli_pct);
+
+	if (residency_milli_pct)
+		*residency_milli_pct = 0;
+
+	return true;
+}
+
+
 bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
 	const unsigned int *power_opts, uint32_t coasting_vtotal, uint16_t frame_skip_number)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 51de13e2387e..0082f5e91878 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -60,6 +60,8 @@ bool edp_send_replay_cmd(struct dc_link *link,
 bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal, uint16_t frame_skip_number);
 bool edp_replay_residency(const struct dc_link *link,
 	unsigned int *residency, const bool is_start, const enum pr_residency_mode mode);
+bool edp_replay_get_cumulative_residency(const struct dc_link *link,
+	uint32_t *residency_milli_pct);
 bool edp_get_replay_state(const struct dc_link *link, uint64_t *state);
 bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
 	const unsigned int *power_opts, uint32_t coasting_vtotal, uint16_t frame_skip_number);
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
index 5d1275b7cd46..25a0c96ac754 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
@@ -375,6 +375,9 @@ bool mod_power_replay_set_coasting_vtotal(struct mod_power *mod_power,
 void mod_power_replay_residency(const struct dc_stream_state *stream,
 	unsigned int *residency, const bool is_start, const bool is_alpm);
 
+bool mod_power_replay_get_cumulative_residency(const struct dc_stream_state *stream,
+	uint32_t *residency_milli_pct);
+
 bool mod_power_replay_set_power_opt_and_coasting_vtotal(struct mod_power *mod_power,
 	const struct dc_stream_state *stream, unsigned int active_replay_events, uint32_t coasting_vtotal,
 	bool is_ultra_sleep_mode, uint16_t frame_skip_number);
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_replay.c b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
index 31d9cb3a12ba..7861e46c612d 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_replay.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
@@ -761,6 +761,19 @@ void mod_power_replay_residency(const struct dc_stream_state *stream,
 		link->dc->link_srv->edp_replay_residency(link, residency, is_start, mode);
 }
 
+bool mod_power_replay_get_cumulative_residency(const struct dc_stream_state *stream,
+	uint32_t *residency_milli_pct)
+{
+	const struct dc_link *link = dc_stream_get_link(stream);
+
+	if (!link || !link->dc || !link->dc->link_srv)
+		return false;
+
+	return link->dc->link_srv->edp_replay_get_cumulative_residency(
+		link, residency_milli_pct);
+}
+
+
 bool mod_power_replay_set_power_opt_and_coasting_vtotal(struct mod_power *mod_power,
 	const struct dc_stream_state *stream, unsigned int active_replay_events, uint32_t coasting_vtotal,
 	bool is_ultra_sleep_mode, uint16_t frame_skip_number)
-- 
2.43.0

