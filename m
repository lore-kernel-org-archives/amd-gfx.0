Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE6CF513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A013C10E2FE;
	Fri,  6 Mar 2026 03:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xn/oUO7M";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5A610E2FE
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLBoxqszSj7FAj45Ls//OWoXCMUxNxCVAyRIlohDIg5WB3Dmhe4cfe8uiDzVxAT0Y3EWko6tX+FdDF/DEEp9JJN8euH2k1lI0FlVo0MZh4Sv8KwH+47dfjur3d4BpGEPh64/3shlSKKlvI8ejdEehcRDErabVm9XTTX0dO/VRgCECvVc8FBqocVKrEmybVcyKQfcTkJI6hZ690YGMSFkWhE7iDkCZnx3IEhn1wmLClnM8QDDxcHPDxJ2OhZzTepaY1JJCtJV5BUO0tDUZgYuj2qu+neRMv/VKsIJJDw1nvXm5S8RxZUuQjOyDa9KpnG4DxSlDpeNT8QOyDkvlgD1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xcH49V8ubjIcIkv85fhvlNmWibvewIq5V+UZ+A4fkE=;
 b=uwgjT7ryFhW6coOY2Xdos+CNPuHUMx1Qn0AC0XXYdVrc2VkFkll2FNfE5CgWn7eFV5au+VwjzPE0uO7y6xOW96sW7m5/TFaXEqRPhc/yeOuS2c2/m8A4o6WbPlgbNRscy7ltLYyG6Woyvgx/WvPtRUsSUIDQ0X+IoxC9qubNazk9ayQ+DNVEKo+xKG+DAs6Lu82wZaxzGgPu/Pw04DFVzazbz6mUFgPDEZMeSfI2H0pNi4YMlDRi6y7XqboUO5NcITbaImgnHfqJN1seZ/yxYaNPSJ5VGvMUezsbWGN7oxoNWFvjJUIqCxjQsAkSZCS3Ga8sFZYzauOhj+rcCT2rPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xcH49V8ubjIcIkv85fhvlNmWibvewIq5V+UZ+A4fkE=;
 b=Xn/oUO7M3eX9YvHHFOW3WN+0zQWq8bIEeghb8t2LsZDyKBoZr0rq7vNAm1gOuE4TgRlY711dTQJUE6AA0tdWe9Jog2Q2qAoLj8qc+Im3mq2n0gRpT2W5FhpJRj+aYOpUpM86XaPwKonRNg/VkESuIFPL2fNKMCbbcnqNvh1FOm0=
Received: from BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:25:38 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::41) by BY3PR04CA0027.outlook.office365.com
 (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 03:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:25:38 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:25:34 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Weiguang Li <wei-guang.li@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Robin Chen <robin.chen@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 08/21] drm/amd/display: Add ESD detection for replay recovery
Date: Thu, 5 Mar 2026 20:13:34 -0700
Message-ID: <20260306031932.136179-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 632b78a4-9cc0-40f0-6b8d-08de7b30098b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: izXfZPc3QvWqsddj0qAuPPWoCtcch5w7H+4JpF6Snq4ABcUpOuWs593ndCQc716NE545KSSli6E3p3fMvyOFbjph+TqvrHRJE/y/jiwQAFV2hV6hrOK0wbhQ4ZfMdDPqunnW7yNErpgeEuQ0kFpAbOfHPe5RZ9BfNYvjyfcuvo1mAQDwBk0lZ0rrFtflBCrcKIoG2MD6wBjTfYEE3mI8wqTMswOHMvCzOYMmRpOqCNFYcMZEqaPT5Li2wyQz4A8ofOoyYvOJrmaVm3CaT7xMn14KdhArP5KSqb7qveHScN5fAZO3PUdyVOktMeHsXgt5w4UDjU6vwFW58g88P8jiMX9My0pIK4dSVQpBYrd90cUY/Eo5PsSgdcr3OUTxYssmhX8VptU9b0MjbbYyqEhPWQTYci8hwQb7hprtQhSAWHRXZxoQeoY3bzW0/GuLsajoa+ZMRHGQI9RsF6GrPQHkhJk6R52HVx2bsGJeAxoY8l9V+rvwl0fHQ4EZgfh3otUxtKy6Q8Vfgibc10qCsxWMOKbj/gZhqxDhD/af2uYcDZz6ESAZXx8EmbLy9hKRXJgcd2D5tlo68rw/kuX4df1xxAiIhJp3v912b6mTUWbbF0zOH0x4us9My9r3YyOTkNQJnPAxmmrbhLOQFTzWod/WgYfHx+4fIbflX5cc1uhduI1SZgjRz4UncRZbdhCnAPMlB7rfJDDpNaGSwmcdsiaeFgULIz4wAc9/qhp7DFJFr2/n/DE4ykVaN/EboE/UhErDuAmCF5oc2dMg4BL6DoYVBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JSnjI0imTzLS66I52Uort4+iK1g7AAtbGlVgwJBR2q+gZaiRDmo5bz/k6/+T6i+t+Fdt/KMR+mmcFRIYC4BMOCRvpTYqZszlcC1LCoBX1QKzt1YCghalUrwctMAzkzOEgY2fOeVx38wuUzcnh0FH3YV2d5moiMQhSZnHjnqfmOQWIGzzZDr0v3bb9qvLfKRu1Kcif3c+AyLZrcB3hF9M7UBQDqwErYz6S0N8LUltpsZCu3uxaX03ysPJHSV4rUvDN8kr46EJCVszwxr3CinkuNxluPsecduZKTYlGDDDVXJyVGezo98PzC1WT0QgHCa+v6fKiO1cbZm9H2XgmN1EtNqawIaVwhcnMxW+NDTWWaOxldDNjGEHcDqnqv22cH126rP8NLv0wxLY2cG50wvfjzQRbWqlc6WqvGuHTiOjMsJQ6+/zFEd2jHQGG5Y8x56M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:25:38.0581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 632b78a4-9cc0-40f0-6b8d-08de7b30098b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
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

From: Weiguang Li <wei-guang.li@amd.com>

[HOW]
Add Replay recovery flow so that when HPD occurs and ESD is detected,
Replay can restore the system back to normal.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Weiguang Li <wei-guang.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/link/protocols/link_dp_irq_handler.c   | 36 +++++++++++++------
 .../gpu/drm/amd/display/include/dpcd_defs.h   |  3 ++
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index cc18a3bebef2..1860d44f63c1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -223,9 +223,10 @@ static void handle_hpd_irq_vesa_replay_sink(struct dc_link *link)
 	}
 }
 
-static void handle_hpd_irq_replay_sink(struct dc_link *link)
+static void handle_hpd_irq_replay_sink(struct dc_link *link, bool *need_re_enable)
 {
 	union dpcd_replay_configuration replay_configuration = {0};
+	union dpcd_replay_configuration replay_sink_status = {0};
 	/*AMD Replay version reuse DP_PSR_ERROR_STATUS for REPLAY_ERROR status.*/
 	union psr_error_status replay_error_status = {0};
 	bool ret = false;
@@ -265,9 +266,17 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 		&replay_error_status.raw,
 		sizeof(replay_error_status.raw));
 
+	dm_helpers_dp_read_dpcd(
+		link->ctx,
+		link,
+		DP_PR_REPLAY_SINK_STATUS,
+		&replay_sink_status.raw,
+		1);
+
 	if (replay_error_status.bits.LINK_CRC_ERROR ||
 		replay_configuration.bits.DESYNC_ERROR_STATUS ||
-		replay_configuration.bits.STATE_TRANSITION_ERROR_STATUS) {
+		replay_configuration.bits.STATE_TRANSITION_ERROR_STATUS ||
+		replay_sink_status.bits.SINK_DEVICE_REPLAY_STATUS == 0x7) {
 		bool allow_active;
 
 		link->replay_settings.config.replay_error_status.raw |= replay_error_status.raw;
@@ -299,8 +308,7 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 		if (link->replay_settings.replay_allow_active) {
 			allow_active = false;
 			edp_set_replay_allow_active(link, &allow_active, true, false, NULL);
-			allow_active = true;
-			edp_set_replay_allow_active(link, &allow_active, true, false, NULL);
+			*need_re_enable = true;
 		}
 	}
 }
@@ -460,6 +468,7 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 	union device_service_irq device_service_clear = {0};
 	enum dc_status result;
 	bool status = false;
+	bool replay_re_enable_needed = false;
 
 	if (out_link_loss)
 		*out_link_loss = false;
@@ -519,7 +528,7 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 		/* PSR-related error was detected and handled */
 		return true;
 
-	handle_hpd_irq_replay_sink(link);
+	handle_hpd_irq_replay_sink(link, &replay_re_enable_needed);
 
 	/* If PSR-related error handled, Main link may be off,
 	 * so do not handle as a normal sink status change interrupt.
@@ -538,16 +547,16 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 		return false;
 	}
 
-	/* For now we only handle 'Downstream port status' case.
+	/* Handle 'Downstream port status' case for all DP link types.
 	 * If we got sink count changed it means
 	 * Downstream port status changed,
 	 * then DM should call DC to do the detection.
-	 * NOTE: Do not handle link loss on eDP since it is internal link
+	 * NOTE: Now includes eDP link loss detection and retraining
 	 */
-	if ((link->connector_signal != SIGNAL_TYPE_EDP) &&
-			dp_parse_link_loss_status(
-					link,
-					&hpd_irq_dpcd_data)) {
+
+	if (dp_parse_link_loss_status(
+			link,
+			&hpd_irq_dpcd_data)) {
 		/* Connectivity log: link loss */
 		CONN_DATA_LINK_LOSS(link,
 					hpd_irq_dpcd_data.raw,
@@ -576,6 +585,11 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 			!= link->dpcd_sink_count)
 		status = true;
 
+	if (replay_re_enable_needed) {
+		bool allow_active = true;
+
+		edp_set_replay_allow_active(link, &allow_active, true, false, NULL);
+	}
 	/* reasons for HPD RX:
 	 * 1. Link Loss - ie Re-train the Link
 	 * 2. MST sideband message
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index 1afa10e85eb5..4a8ca0ac1266 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -64,6 +64,9 @@
 #ifndef DP_PR_ERROR_STATUS                  // can remove this once the define gets into linux drm_dp_helper.h
 #define DP_PR_ERROR_STATUS                  0x2020  /* DP 2.0 */
 #endif /* DP_PR_ERROR_STATUS */
+#ifndef DP_PR_REPLAY_SINK_STATUS            // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PR_REPLAY_SINK_STATUS            0x2022
+#endif /* DP_PR_REPLAY_SINK_STATUS */
 #ifndef DP_PR_LINK_CRC_ERROR               // can remove this once the define gets into linux drm_dp_helper.h
 #define DP_PR_LINK_CRC_ERROR               (1 << 0)
 #endif /* DP_PR_LINK_CRC_ERROR */
-- 
2.43.0

