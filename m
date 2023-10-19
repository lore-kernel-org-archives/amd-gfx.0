Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE731CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4254010E4E1;
	Thu, 19 Oct 2023 13:32:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C25FD10E002
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbPmrI4in5iL8PijrmX9eKWvL9z5cnNmmAKauqhnTEf5Th96mf4j6EMhuSUeJQoTZI4Q2pTfnZM0rUyH2qi+vfWc2R+FG3NDS1VAQKYUJHbPDDfeGN476WMDW8B+qEZ73byeH83AH5QdjgjfSJCyov9EbCuW47u2qkKldPTkRyu9Y5Pp72secpu5M8hbjFrWnAHx39mEpdPYt8qwhuONwRQGwMMjc6BspAPS80BrguW3pTOTB/THsV+f877o48IE8hugl/QIsZQnXiuSahLdxeY5Dj8RAGaW5LPiJCMTkZdeBYZ+CJET0WxlcZodv9DNj01MVVdas1VV0Q84exDvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c63OjxI+jD4x/46eeIWn7EKUBGO8oIRLckHOhgm4Oao=;
 b=Baq3Pn+R+ohOd7SubL4y+VCAXNmIVyCAjLOALqnyn/DRswRkhIUbBPo9aea4Kv/+W+KYGv/+HBwjrTHhQMeJ4SlLOlzZ9a3KEnLnYirCCWvQDa/Ov+3bk06Yyw4xlZBz0iNYIKZwbInmccIeR0BQ3ahZ2C3RfAYLohXrP1segnWXfIsIRN0+l4OxNEq9BUZwTverm8n3hduXWX5Y4Qizrx+tm9DHlcC8gw58hGdtpMP2+586Bi6BBq0oCwGxIxRgqAeklmC4Fu0TIUuflaqgJda9AO+srs1UVhcyxocOdmmK+DI+keKwCsmwxQfwEgoWbhRT4mAzdxbfkKHm2T97Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c63OjxI+jD4x/46eeIWn7EKUBGO8oIRLckHOhgm4Oao=;
 b=MSmbOyPjSCIXQCHZj6yi+YRH5qpWsT5ovshUbLXYpkhi6DFU9SBP4qi6Kdo3s1cPf1jZGNASFjKw385gtVp7g+hIjtEmGaNayNTjj4S789ENr+bs3yLheHqoL7d2gaABzJwvyatTOWq6OritMREIw9lhHsi/UctVFVzYFCxyd5o=
Received: from MN2PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:c0::31)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 13:32:41 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::1a) by MN2PR05CA0018.outlook.office365.com
 (2603:10b6:208:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8 via Frontend
 Transport; Thu, 19 Oct 2023 13:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:32:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:32:40 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:32:39 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 05/24] drm/amd/display: Add a check for idle power
 optimization
Date: Thu, 19 Oct 2023 09:32:03 -0400
Message-ID: <20231019133222.1633077-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|CH0PR12MB5369:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c5e29b-6e11-4ed6-2ce8-08dbd0a7de34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGRgdMn2opZ6NapcJXsH6eCaMpc/MW5+3EF4eHQbjnb5WoD3S0wZu6QjvC4RMVxP8jDVUqXnhn3uKC+h39qtiU9oz95+97t4cFdQAoEIyx8MmjcUD4LeEg9ucWzUZ4qyIJ12yX/iiSUjUgl/QNSBdpWMwDf7IHFnj3+FR2UVNcxP8QtVp5JwxKnkRb4K0vQnRyU6+k6rXOAeEtEYqyP6oyKqR4JuMBe7OuGWcnFIirt9YzCMAIrnM6u5n9400YrrygEVagA98F7aG37hdEakqdMJ81mZ4TBHzMu19wlVBeOS8Cdtunk6viwdMjzADpxTtRebSTaIct17hHLG83j7XeMbptQT6YW38hvuQe5YLp6IcjCBPvy/v48x12nn64DB9oNjBR1zPOuHB2Z9aWiAyckMV3Y8EkSw/Cy8KWwmpj+A8fIy66gfSvkNUbEcKb8X4E8VWHCArJPA+GLl43XB9CRxEy5WCpkTAGs+9e1QASVAShYm8D+az/yt9Fee9PhZMD8RjiQ0RHvWPgoy1OZYxdrXm2i1fx0NW/mley+QU2Q+DPtMLtWI5OHptPS0RHFwquyOsj3sLjRapikyIrHn/Va/6KdVQWCjJpHVoxaeqmk6j0STcWPpXyz2OzwaZhfyR1w/8BhzlXusszLpOU4+ua42LtsxjrJ6mHt/wRyK4fwSdVxSoG44bA9zgaT4/S4t7gOVWOGMH6jzMmQYsJpVa9z/ycFVqDsDQ8FrCXHFO1/DC5o74RvyRrZsS7cTvT5Qi3GUd/zuPPIoP16WpB4s9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(2876002)(40460700003)(5660300002)(8676002)(4326008)(36756003)(8936002)(40480700001)(41300700001)(316002)(54906003)(70586007)(70206006)(86362001)(6916009)(478600001)(6666004)(2616005)(7696005)(1076003)(426003)(81166007)(356005)(26005)(82740400003)(336012)(36860700001)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:32:40.8665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c5e29b-6e11-4ed6-2ce8-08dbd0a7de34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Sung Joon Kim <sungkim@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Nicholas Choi <nicholas.choi@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Need a helper function to check idle power is allowed
so that dc doesn't access any registers that are power-gated.

[how]
Implement helper function to check idle power optimization.
Enable a hook to check if detection is allowed.

V2:
Add function hooks for set and get idle states.
Check if function hook was properly initialized.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Nicholas Choi <nicholas.choi@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 23 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  4 +++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  8 ++-----
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  2 ++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  2 ++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  1 +
 7 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f602ff0d4146..c4962cc4bb93 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4883,6 +4883,9 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 	if (dc->debug.disable_idle_power_optimizations)
 		return;
 
+	if (dc->caps.ips_support && dc->config.disable_ips)
+		return;
+
 	if (dc->clk_mgr != NULL && dc->clk_mgr->funcs->is_smu_present)
 		if (!dc->clk_mgr->funcs->is_smu_present(dc->clk_mgr))
 			return;
@@ -4894,6 +4897,26 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 		dc->idle_optimizations_allowed = allow;
 }
 
+bool dc_dmub_is_ips_idle_state(struct dc *dc)
+{
+	uint32_t idle_state = 0;
+
+	if (dc->debug.disable_idle_power_optimizations)
+		return false;
+
+	if (!dc->caps.ips_support || dc->config.disable_ips)
+		return false;
+
+	if (dc->hwss.get_idle_state)
+		idle_state = dc->hwss.get_idle_state(dc);
+
+	if ((idle_state & DMUB_IPS1_ALLOW_MASK) ||
+		(idle_state & DMUB_IPS2_ALLOW_MASK))
+		return true;
+
+	return false;
+}
+
 /* set min and max memory clock to lowest and highest DPM level, respectively */
 void dc_unlock_memory_clock_frequency(struct dc *dc)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index cc1cae4d7329..e3b8c71e2c31 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2362,6 +2362,7 @@ bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_
 				struct dc_cursor_attributes *cursor_attr);
 
 void dc_allow_idle_optimizations(struct dc *dc, bool allow);
+bool dc_dmub_is_ips_idle_state(struct dc *dc);
 
 /* set min and max memory clock to lowest and highest DPM level, respectively */
 void dc_unlock_memory_clock_frequency(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 5daedd893923..5d62805f3bdf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -586,7 +586,9 @@ void dcn31_reset_hw_ctx_wrap(
 			struct clock_source *old_clk = pipe_ctx_old->clock_source;
 
 			/* Reset pipe which is seamless boot stream. */
-			if (!pipe_ctx_old->plane_state) {
+			if (!pipe_ctx_old->plane_state &&
+				dc->res_pool->hubbub->funcs->program_det_size &&
+				dc->res_pool->hubbub->funcs->wait_for_det_apply) {
 				dc->res_pool->hubbub->funcs->program_det_size(
 					dc->res_pool->hubbub, pipe_ctx_old->plane_res.hubp->inst, 0);
 				/* Wait det size changed. */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 12821cb9ab6c..36d2b91aa337 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -627,12 +627,8 @@ void dcn35_power_down_on_boot(struct dc *dc)
 	if (dc->clk_mgr->funcs->set_low_power_state)
 		dc->clk_mgr->funcs->set_low_power_state(dc->clk_mgr);
 
-	if (dc->clk_mgr->clks.pwr_state == DCN_PWR_STATE_LOW_POWER) {
-		if (!dc->idle_optimizations_allowed) {
-			dc_dmub_srv_notify_idle(dc, true);
-			dc->idle_optimizations_allowed = true;
-		}
-	}
+	if (dc->clk_mgr->clks.pwr_state == DCN_PWR_STATE_LOW_POWER)
+		dc_allow_idle_optimizations(dc, true);
 }
 
 bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index d45302035e3f..c43d1f6c2a06 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -418,6 +418,8 @@ struct hw_sequencer_funcs {
 		struct pg_block_update *update_state, bool power_on);
 	void (*root_clock_control)(struct dc *dc,
 		struct pg_block_update *update_state, bool power_on);
+	void (*set_idle_state)(const struct dc *dc, bool allow_idle);
+	uint32_t (*get_idle_state)(const struct dc *dc);
 
 	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
 			const struct dc_state *cur_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index cb2dc3f75ae2..fa9614bcb160 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -262,6 +262,8 @@ struct clk_mgr_funcs {
 	void (*set_low_power_state)(struct clk_mgr *clk_mgr);
 	void (*exit_low_power_state)(struct clk_mgr *clk_mgr);
 	bool (*is_ips_supported)(struct clk_mgr *clk_mgr);
+	void (*set_idle_state)(struct clk_mgr *clk_mgr, bool allow_idle);
+	uint32_t (*get_idle_state)(struct clk_mgr *clk_mgr);
 
 	void (*init_clocks)(struct clk_mgr *clk_mgr);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index b99db771e071..e43e8d4bfe37 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -352,6 +352,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			funcs->init_reg_offsets = dmub_srv_dcn35_regs_init;
 
 			funcs->is_hw_powered_up = dmub_dcn35_is_hw_powered_up;
+			funcs->should_detect = dmub_dcn35_should_detect;
 			break;
 
 	default:
-- 
2.34.1

