Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9285FE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409EB10F05F;
	Fri, 20 Dec 2024 21:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IQlOcdbA";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E97810F068
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecm7d2c4LhCWRRKm5QbD75NjpcCU0W9K7GwqjyKUtdCB4jLy8YoUDQTZMhUL2Yla6vzggX6sbySjh4qb3Sdwx6EATedO/BeuqoVvLOfEbz4MbVhYPjUjwCzAXagOib6vqoHwa8jWKP36hSTHqlQuUgsAPDZbfUUo3KLhmMuFsdfsOPHlZjbW945j93BthNwrf1Am8xAgtWfaxUdCXsqnQ8NX4tgafvBDq4g/80FWj3H9ixsp/Rgg1TWDuwJlwZXWWeph12wBk71HfjToE0EEUpct+uW4HHqZUru3lNTqPsfdXiSH5UXB/mm2Eu6JgOA3a8p3+1yTQg4OxxYnDfNazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAQl1MLwNogAbs99WWVKuXgXsGJ/q2ulsag6KseFQDA=;
 b=iH6KngB8SvZtHqNUe2lpJrfS9oOIQOI1dG+BiHNKMRj1J8SjAp0mEUz4g0KUj616FBu70YSXslnhvWu9NXBV9LObklCzYnMFwxOaZy6V5w4A39GKFPVQgHaLxsKo0JSfYNewzY63nB1cS97lLbdE/miOd/QZ9E3couIG9YFusGZX2dVC09l7xIcOCbEi+tolXs+cNo4Cm+fMcis2CNlw8JO1Iqv6UbwyJRZFxQxHSS1rwpX2coKtM5RH0yWnu5RDsNKgSrwzh7c3vH6I+fPbY1pvQRcO85zDe48yMULEkqLdc1TH7kaep0IvPIHCkhI40QlSOpUi82+ul4jL39mn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAQl1MLwNogAbs99WWVKuXgXsGJ/q2ulsag6KseFQDA=;
 b=IQlOcdbA+4BklyyXPRT/JxRdOG++0MesW1upDpyqQDdotV6ujEGr6hve7a5n+LRZ0ItmSUjcPjtE+xI/OvkJJtoWU9t8ZumELSAe/aaAbEEdTnpZ1prkkERpJVDiijARR9+K91TIiG28l80f910tIh0sEsVcKR/l2JhlgHSyqvM=
Received: from SJ0PR03CA0076.namprd03.prod.outlook.com (2603:10b6:a03:331::21)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:50:57 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::e) by SJ0PR03CA0076.outlook.office365.com
 (2603:10b6:a03:331::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 20 Dec 2024 21:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:50:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:56 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:50:50 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, HaoPing Liu <haoping.liu@amd.com>
Subject: [PATCH 07/28] drm/amd/display: Add support for setting multiple CRC
 windows in dc
Date: Fri, 20 Dec 2024 16:48:34 -0500
Message-ID: <20241220214855.2608618-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fea6d0-6942-43c7-bc01-08dd2140629e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fKowMB17H6/Pw/hX289iuHgi1G+89/0sNt9QI7U8p/Ma+fVUT6eBV/9FRER4?=
 =?us-ascii?Q?QThDomwIXV0pjSg78vYQrTTLNJkOMFBaF9QMbDe0kOXjVmYkSts+WPCO7jnc?=
 =?us-ascii?Q?DlPOnYn0vioL2GgYk9ErqgoOPFZ1vd3NcKNtpeBNWo6DqVp8d1zSKdeLon8A?=
 =?us-ascii?Q?MyzoPPdkJiQyY2Q/cLSk0RIkPAH0jSkiGFXJjUW8FBlHVdPYOZPFA95KZ1Ta?=
 =?us-ascii?Q?B+IXr7DD8t2rOFitw0PJZZQooYSPFaqEC+QCqN7vptNQdnfFZsbdel2m/UlA?=
 =?us-ascii?Q?0kOmafOjakU4ho0UyuJXZ19KO1EYFCq4hse5OdqFzj9rxD4mHfwJyt90jD4l?=
 =?us-ascii?Q?BFcxO3PYr2AyQVNLDdiO1dVqrm+D97PfDzDcBAQhk1jkSGT0kpn6OqE5b2S5?=
 =?us-ascii?Q?gBr4jRDSbWE6pCVPd8NjdyLjndXvMZkiOOawth4SScMllyY6Ui+ZzlgG6h1z?=
 =?us-ascii?Q?PzsjTwP7SbklSIS3mX7x5A50yA4Gn3RPItwwrdNmdvwZWz/Uj0WusjD+fjI9?=
 =?us-ascii?Q?urhX0XkZHaV9DZSb911z/UmZlAyD4lZjatgpt6h8I6sxtCDZpihm/4mJMhrO?=
 =?us-ascii?Q?tWBL8KFjU95YpSfWtjiMcnujB2u6pPdkj8Ci72HB8+dILb+uGfXEN9H8ZsK7?=
 =?us-ascii?Q?3TNX5BRHq5uKe1Je6tm5derRZpo7iwoKBDDhj3a7YnzKHWMdFwnufo8pHWW1?=
 =?us-ascii?Q?qBdJlQ0t03zTRwrdWVnjh1qS4hkqoPcwojDE/pZMbHuYRTC5pMEGhklMoBWx?=
 =?us-ascii?Q?x/x+nx9skbowBjC4AZxmZad50nlxSVy5qVG9LhcE42EVBpA8jyL4b0z4CFRE?=
 =?us-ascii?Q?fkswilRRA+QwfGrYF4mrNHMkHmlNRmRIdKyJF25hHAQIGWz8j2YwmvJ8DIHb?=
 =?us-ascii?Q?BZnI5dI/xUfoQjPZu8EC14tLDz5aKEXPhbR35makAIyUqlFxsNqWsAOOMpXt?=
 =?us-ascii?Q?iHK1Tm5zkYFUrsRsy7gobtNlTlqslp5t6Hteglr8gJVWexULBKzCYlzqXITD?=
 =?us-ascii?Q?cFvEsbPilqqa2rSZA8k7EUIZd1qiGfHOnzGU+F6ztm41PrMkkTURsP5mGN7Q?=
 =?us-ascii?Q?npx4SIRVqPp88lpo2zSKLqJJXqZNIMyfOXeQBOncGicjQWc3F4MRGp1Ln0f6?=
 =?us-ascii?Q?ksktYy8P4/+W6+wNouB/hVZdEA6jvaLOjIzANAJsUdTNAAqjze+7fnvtwM+z?=
 =?us-ascii?Q?D5eY/8fb91bbQzBIc0aIgbP9sFbAu3IluRoggkHWcrN2u+haezbsTBqod7pc?=
 =?us-ascii?Q?RTKHMMAk9lOdvtBZlXZDDd0tJeLfsRnd9aFfQ5uD0+sk6Ah/8NNeiPXsAYPc?=
 =?us-ascii?Q?cfNWD2Hz/JIPmOo2vyTZLj8dSqTnR6DZcTuTK4BIR28AeUo5uDKURePsfxJz?=
 =?us-ascii?Q?zD2MOJB4VNOzcLln+1TOhLM5bmaMXnxGCLbfvDzvX/tFqrZb3u8B3zXb5UrC?=
 =?us-ascii?Q?mC+g03sy02HXl7V9NmqBMSoQZfF8x5un7xqQWh6iHvEQN7Q/R9eo1qyEQdTj?=
 =?us-ascii?Q?KwXYw22pTj2Xl60=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:50:57.0953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fea6d0-6942-43c7-bc01-08dd2140629e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
Have to support multiple CRC windows setting to dmub. Add new dmub forward
functions for supporting/forwarding multiple crc windows setting to dmub.

Reviewed-by: HaoPing Liu <haoping.liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 62 ++++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h |  5 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h  |  7 +++
 3 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dfa36368ae63..deda18e07e9b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -615,6 +615,68 @@ dc_stream_forward_crc_window(struct dc_stream_state *stream,
 
 	return true;
 }
+
+static void
+dc_stream_forward_dmub_multiple_crc_window(struct dc_dmub_srv *dmub_srv,
+		struct crc_window *window, struct otg_phy_mux *mux_mapping, bool stop)
+{
+	int i;
+	union dmub_rb_cmd cmd = {0};
+
+	cmd.secure_display.mul_roi_ctl.phy_id = mux_mapping->phy_output_num;
+	cmd.secure_display.mul_roi_ctl.otg_id = mux_mapping->otg_output_num;
+
+	cmd.secure_display.header.type = DMUB_CMD__SECURE_DISPLAY;
+
+	if (stop) {
+		cmd.secure_display.header.sub_type = DMUB_CMD__SECURE_DISPLAY_MULTIPLE_CRC_STOP_UPDATE;
+	} else {
+		cmd.secure_display.header.sub_type = DMUB_CMD__SECURE_DISPLAY_MULTIPLE_CRC_WIN_NOTIFY;
+		for (i = 0; i < MAX_CRC_WINDOW_NUM; i++) {
+			cmd.secure_display.mul_roi_ctl.roi_ctl[i].x_start = window[i].rect.x;
+			cmd.secure_display.mul_roi_ctl.roi_ctl[i].y_start = window[i].rect.y;
+			cmd.secure_display.mul_roi_ctl.roi_ctl[i].x_end = window[i].rect.x + window[i].rect.width;
+			cmd.secure_display.mul_roi_ctl.roi_ctl[i].y_end = window[i].rect.y + window[i].rect.height;
+			cmd.secure_display.mul_roi_ctl.roi_ctl[i].enable = window[i].enable;
+		}
+	}
+
+	dc_wake_and_execute_dmub_cmd(dmub_srv->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
+}
+
+bool
+dc_stream_forward_multiple_crc_window(struct dc_stream_state *stream,
+		struct crc_window *window, uint8_t phy_id, bool stop)
+{
+	struct dc_dmub_srv *dmub_srv;
+	struct otg_phy_mux mux_mapping;
+	struct pipe_ctx *pipe;
+	int i;
+	struct dc *dc = stream->ctx->dc;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe->stream == stream && !pipe->top_pipe && !pipe->prev_odm_pipe)
+			break;
+	}
+
+	/* Stream not found */
+	if (i == MAX_PIPES)
+		return false;
+
+	mux_mapping.phy_output_num = phy_id;
+	mux_mapping.otg_output_num = pipe->stream_res.tg->inst;
+
+	dmub_srv = dc->ctx->dmub_srv;
+
+	/* forward to dmub only. no dmcu support*/
+	if (dmub_srv)
+		dc_stream_forward_dmub_multiple_crc_window(dmub_srv, window, &mux_mapping, stop);
+	else
+		return false;
+
+	return true;
+}
 #endif /* CONFIG_DRM_AMD_SECURE_DISPLAY */
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 713884103aea..ac22bfe8c9a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -539,6 +539,11 @@ bool dc_stream_forward_crc_window(struct dc_stream_state *stream,
 		struct rect *rect,
 		uint8_t phy_id,
 		bool is_stop);
+
+bool dc_stream_forward_multiple_crc_window(struct dc_stream_state *stream,
+		struct crc_window *window,
+		uint8_t phy_id,
+		bool stop);
 #endif
 
 bool dc_stream_configure_crc(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 2792ef448d01..81ec7c79f4c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -940,10 +940,17 @@ enum backlight_control_type {
 };
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+#define MAX_CRC_WINDOW_NUM	2
+
 struct otg_phy_mux {
 	uint8_t phy_output_num;
 	uint8_t otg_output_num;
 };
+
+struct crc_window {
+	struct rect rect;
+	bool enable;
+};
 #endif
 
 enum dc_detect_reason {
-- 
2.34.1

