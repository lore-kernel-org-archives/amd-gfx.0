Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F653ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45CC310E84E;
	Wed, 14 Sep 2022 05:18:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D1F10E84B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn87g8uJ63QHP0wa544TNfpnmRqs8R45WV7CWeJdvgXorUYK12jzC/ETs8mviYAJsZwIMGqy4ndG1f5ABVHj7XViJpamFNiBno7Rsntlgo+1NPHqTqkjmC3PVXy2WCPc4GKlSLg4TkonyocDrtRi1b5X/uIshs+vNz6UgOIiDs6YdG+Ols3khm7PY44uRjmqtqLM2HTI9kTH5rE6d4bZtJkzh67gHFs2J1xcTwFiPYQ6oFGJ5oIw/A9Sjn42bxeUARGpHk8HxA+P2hnBqGGtt12E6P4bOpa6GaAbLPQ2flSF/xjQDrfu0LB/wueo32z/2gCJuzXbCn9b5HcwdpICTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0D7jINnPCgMJ9845vZ07/abMw4JvPLYZhrV1hKL//I=;
 b=VMMMkllJrqzWU1e36nqjcWcJVuD3vs9oaMI6xT/puSHTtM14ODyjkqeAieHTsDiHYlZ6K4eLRKHZD/dy4lQGneodWD6Cz/qzlHON83LP0h7/c7H1FcT23P95atKqO/FlxrdNv+ZLPq6oXnAxCF0g0Xt4rUurEt1FMi5jGIzfVb9uDKO9DKv+yuXEEXNGmamnNiLuMqARCsYpd0dQs+Q/MvracK2b170IWKLlACzL+/vWnju03Ao7g5CPGQ/8hKk19pSw9bl3V0WP7teIyDvgy+2Cg3lxhftd6bQ6maQ7r5OAxULBKRuF1K3KfHu3nqZ0sQXOxqlRfcwD6ePzLhnN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0D7jINnPCgMJ9845vZ07/abMw4JvPLYZhrV1hKL//I=;
 b=etN3hFcoruLY1sD7ZQXJ/6dsZ0Ma7u7/l2wE1SeZCxLYRZ517RKJrv+QdViJX4Fldd6vqAPk3UpLrK5oNmmrAO7ulmba3R9UbsMs6vn4baFhBVDJWAcEuP3UC75TvXYclVsUOletTp8cdwio/UJslotHVjbJoESQ7Q1WcaOl3ao=
Received: from SJ0PR03CA0372.namprd03.prod.outlook.com (2603:10b6:a03:3a1::17)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:18:27 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::4b) by SJ0PR03CA0372.outlook.office365.com
 (2603:10b6:a03:3a1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:18:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:17:52 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:17:34 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 34/47] drm/amd/display: do not compare integers of
 different widths
Date: Wed, 14 Sep 2022 13:10:33 +0800
Message-ID: <20220914051046.1131186-35-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 9beaa54d-de6e-4014-552b-08da96108d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgA7UyPmadULIByWGLoC0/Ndr+9KqLj/UCyNSgW/gD6A3f5pwc1epcM/OfkEqqfKhLyKlUpYe7s0FVXBd63a3APLWYmHiAelpgePhkppfcV73KbglIm+ahKZIuCkQ8kjTjPqFkFxzQsXg9zXMnmdnJiJYikKD2WqeAM/oRWsi+9CHyOrZYfCbiRzvYnJ8pziZ4xre3N7acEnzGLnjYNbuf9Q28ZO6U18BOoouTXFGjmBxmS33u/l57MdTmLXcSJazMFac7OzNfs/GF5V40NFoek5v77Y7iBczddCB94rcjDAkkRDjmnq/i93O1ZW/qBJnN6XcwAnVKlXOh/73tbnNUpDKZ7IP3zxkP8MudOjaV7lipgg+4Y53s1QjHCcT6lN6YjeS+8jCbnecNT0sW7Uy1O2M4IwYt4Wc5kA6Gou0Cu0CQ2TI48bAXzKXTFR/GUWkOP4JpZfyJ+K3SD6O/0Q/qEyqLUTmFtsxUtpthYUsqxKuLlEG9sAWNmzwEnGad5unF5+IFIdGRmt+vK6E6mIIi04lPQsIF7o8vefCHqb6foIEEYIjnmttcOL/Dwz8DK2zFhUKrikW3LDNVC9uNRtHCn9RX8lu+TFVLLtACFH0kvzLJRTNqsZql6jDKp/lzbKjhRgxZsC5QroIzjM7+ld0+ocRs59uhFMxVkzIdt9/gfzRnfLKIed51VRFRGLSVS+wqkZwD0X4z0ONpH6qP7LEE8Uo4CMlxSU+gTZR886E5huaBGjP+6J94GIjjM6z7ngr77ThuH4s3urOt12pH+ts8SQ63SaC9nVLhLVTbllU8mQyxGRXWc4JxFKn4T0af06
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(26005)(40480700001)(4326008)(8676002)(36860700001)(478600001)(70206006)(70586007)(7696005)(40460700003)(5660300002)(36756003)(83380400001)(336012)(47076005)(426003)(1076003)(41300700001)(86362001)(186003)(2616005)(8936002)(356005)(82310400005)(81166007)(6916009)(2906002)(82740400003)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:18:26.1457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9beaa54d-de6e-4014-552b-08da96108d76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Increase width of some variables to avoid comparing integers of
different widths

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 4a1954fe3f7e..8c5045711264 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -940,7 +940,7 @@ bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane, s
 void dcn30_hardware_release(struct dc *dc)
 {
 	bool subvp_in_use = false;
-	uint8_t i;
+	uint32_t i;
 
 	dc_dmub_srv_p_state_delegate(dc, false, NULL);
 	dc_dmub_setup_subvp_dmub_command(dc, dc->current_state, false);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index c1261cb0e001..b8326d41810e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1354,7 +1354,7 @@ void dcn32_update_phantom_vp_position(struct dc *dc,
 		struct dc_state *context,
 		struct pipe_ctx *phantom_pipe)
 {
-	uint8_t i;
+	uint32_t i;
 	struct dc_plane_state *phantom_plane = phantom_pipe->plane_state;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 5490b3705b41..160aefaac173 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -265,7 +265,8 @@ void dcn32_determine_det_override(struct dc *dc,
 		display_e2e_pipe_params_st *pipes,
 		uint8_t *is_pipe_split_expected)
 {
-	uint8_t i, j, pipe_plane_count, stream_segments, plane_segments, pipe_segments[MAX_PIPES] = {0};
+	uint32_t i, j;
+	uint8_t pipe_plane_count, stream_segments, plane_segments, pipe_segments[MAX_PIPES] = {0};
 	uint8_t pipe_counted[MAX_PIPES] = {0};
 	uint8_t pipe_cnt = 0;
 	struct dc_plane_state *current_plane = NULL;
-- 
2.37.3

