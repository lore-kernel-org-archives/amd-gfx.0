Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC31CD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA5510F5C4;
	Thu, 28 Mar 2024 19:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XUbbo5y5";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC8910F2F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1r5funmcsftPQbWdxywW1HOCv2Z7fxvPD0SFzcRB717Edle1MgX3Gs4SozoKm/AgRG7y015kNqTDtdIm2rZ9xEILSf47v9L+najN53ThAarsuLVRPp/UtDng9CWQKKNJM/v9miqMx1dsh3l/gwwlWStsC3gYQzo092WAHfnyO8CyBmendlc9rUVvJGpcNMEDDNIteuNxShYV8YCjTxV7iYH1nzo+JxldjgNNlVYhxtfPnshT5fGAcnsXc0m2pyTtharpBQWlVHqW4M5IHo/S7zbZpnnPLZWRJtAbLRAfX3LXJr1qP6aT8EgpxLVBrYWmq8xqH258ZXu9UGjISFZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIWqraHkq+XXxWR+ERTD/G19+/RAADDkExFhs8iyGHQ=;
 b=PGHI77SybEzbMV1R3HI33S+5DWA/mkLYr645tcYLhPZVtuPWfqPtGRxX3eqrAjJOVz8IWWeU52rwH/Dh4LcwULsMAfMV3bsByxSeM3YEXUtpLU1xcZifNW/FxBIgwDC3vrAJt1ZmkYj9P8RMAnXQqt8gzmvZLb7FIz4M+sPmwywoLHtwiTNRxxXIA8SA8L2a17ptEMqAxNGUO/AZF7FccmepE5tqz7oriwt9DAcr4HswUD1xGQ3NzoRE9pFZxNIN2amkQCl4nTHi6pTfg3+ytGMflLBrg3CxcuBy6piS8l/Ho47bbqVvEGk7M2BoAqeGh1+QAmen+BPNw3G0w2u6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIWqraHkq+XXxWR+ERTD/G19+/RAADDkExFhs8iyGHQ=;
 b=XUbbo5y58uWTtpImKv6qfJSkKMn8ptzt2GvJ7d+GeWiRyZQsroz/8Wgqc/tzGJ+39TkPPvVpMUzqTw2IemwS3HVwcMtKgVYfsSeMVwJthxm7WvPZiyoUXORgUWoDfG+UOrmVRv31FPvfj6JOzep/Z2TgDOgPtUcdQJvKNH7URgA=
Received: from CH2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:610:54::11)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:51:36 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::98) by CH2PR11CA0001.outlook.office365.com
 (2603:10b6:610:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:34 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:34 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Leon Huang
 <leon.huang1@amd.com>, Robin Chen <robin.chen@amd.com>
Subject: [PATCH 07/43] drm/amd/display: Expand supported Replay residency mode
Date: Thu, 28 Mar 2024 15:50:11 -0400
Message-ID: <20240328195047.2843715-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2e145d-187e-4f92-1ecc-08dc4f607a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +azXRtev5gaieUOJ6kZU9OVNeLquwcqtBYGLRTPvzuD948FNd2dOW5BFnYNkNrRYCzv+0gkaBOOdQGYIHzA7JSD49zTHeOFL4X68pV/LqLq5Aexw8YiZZzJ8G5ecf3ZvQ2YmLx/o8AAOpkrJ4/hLQLcPXGiT92M//0hfoup4APLCF23cFo5QEX0gUqKqC9YmAhk8jPBES0BZDyu7wOeH0BaHDNp8T7eCT+Mm3ZoS/XGdpnfBCctrN5K9NfevgUDqlIQ/RDO6YBWDZNpUMGH+1INQe/ah9yHAPwWZldD/iXuRRoJ/Zgxkg8scEs/O2mM2sUSpGKsRWcHevyE9wAgHkXEJPG3Afe6vVCW7V0mU4oYBvrJpy94NMDnCfWnfr3fC0OPtMHRF6lPw/v+VeARwbdXVm+y6BNwyfyuerV7I2UG6TC+Cm8eSjEAJzhVo/d6j2AG7jdo6gKuO1XsgO1NtCSdKRis8M4ObtpShKGV+6wK+1xXJECfrUO4utPTYUMhRYGHseShKlFcMtO5CXFn27gjhJ/dna25G6yZvCOmM1DH06ALXmc+EVORdVCAArpZZGVz4HYfIlh8lH/iOE8BhOMA2NBmZQmPbRIa9T9C7O4IGLU7Hv0EJ5zY9hHuX0HXsILPk1jOuEbacnj4uQVpFjlUdjiqDvl+U4nOpSVCLswaEEAyzO4K7fJfsU6hsp+RbjysEDsGGRpYurR8J39+IJbMR10b2ZLk0SJFZj6hqb/62sQT2E97H1tWXhKsARNM4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:36.2897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2e145d-187e-4f92-1ecc-08dc4f607a20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
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

From: Leon Huang <leon.huang1@amd.com>

[Why]
Dmub provides several Replay residency calculation methods,
but current interface only supports either ALPM or PHY mode

[How]
Modify the interface for supporting different types
of Replay residency calculation.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Leon Huang <leon.huang1@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/link.h                  | 2 +-
 .../amd/display/dc/link/protocols/link_edp_panel_control.c | 7 +++++--
 .../amd/display/dc/link/protocols/link_edp_panel_control.h | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index bf29fc58ea6a..7ab8ba5e23ed 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -288,7 +288,7 @@ struct link_service {
 			struct dc_link *link, uint32_t coasting_vtotal);
 	bool (*edp_replay_residency)(const struct dc_link *link,
 			unsigned int *residency, const bool is_start,
-			const bool is_alpm);
+			const enum pr_residency_mode mode);
 	bool (*edp_set_replay_power_opt_and_coasting_vtotal)(struct dc_link *link,
 			const unsigned int *power_opts, uint32_t coasting_vtotal);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 0682dbbad448..689c5fb44e86 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1056,7 +1056,7 @@ bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal)
 }
 
 bool edp_replay_residency(const struct dc_link *link,
-	unsigned int *residency, const bool is_start, const bool is_alpm)
+	unsigned int *residency, const bool is_start, const enum pr_residency_mode mode)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
@@ -1065,8 +1065,11 @@ bool edp_replay_residency(const struct dc_link *link,
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
 		return false;
 
+	if (!residency)
+		return false;
+
 	if (replay != NULL && link->replay_settings.replay_feature_enabled)
-		replay->funcs->replay_residency(replay, panel_inst, residency, is_start, is_alpm);
+		replay->funcs->replay_residency(replay, panel_inst, residency, is_start, mode);
 	else
 		*residency = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index eee8a4db6f85..cb6d95cc36e4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -61,7 +61,7 @@ bool edp_send_replay_cmd(struct dc_link *link,
 			union dmub_replay_cmd_set *cmd_data);
 bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal);
 bool edp_replay_residency(const struct dc_link *link,
-	unsigned int *residency, const bool is_start, const bool is_alpm);
+	unsigned int *residency, const bool is_start, const enum pr_residency_mode mode);
 bool edp_get_replay_state(const struct dc_link *link, uint64_t *state);
 bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
 	const unsigned int *power_opts, uint32_t coasting_vtotal);
-- 
2.34.1

