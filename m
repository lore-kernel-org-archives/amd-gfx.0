Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B263CF34D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D9B10E26D;
	Thu,  3 Oct 2024 23:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gxu2TUTo";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83C010E26D
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvuHPGkPYEylIXJV4qV2nlGKxuBkQEtvTo4ERhOYw5xaIwN4Ts/+/XzOAt5XXrZ59EiF/QFNtYgoUrdOckaoPaOYLhosrveAcFJIfj2eVmxTpUSikSITV9EvSU0u4Owr2LcYXD0FZdrO92Q/Ww/GDzqPwKL5cfalFo0GK4Y6IDyKCdUJnADhmAPG1pvHuJmcZcNnVbuNxmsR7JnRQ1XysbkMOUhFJR5k6NQO6qVrHlvzaHaIAdS6TFKZJWSbgaY7WEtMW55UYxMv+24EejnIAigUs/MQvRtYVmf2NXCbAp+AANBFGZKNnL6XVKB6fdYsltsBA4rHyqUi/XOj+fgqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0dsoSg6N+Kazvj+fdAKJoYDsR7oRaa65hQEuzNW3fM=;
 b=E2ulkySFC1T2koEguWZoK6yt4LigxvB9fRMp2z/FKrgAIp825jL9R2BkCRvlM/lPk78Ii5KifC8ZhzHuIzxVO7TxHl7Q3RRES8dWyCaAfgDNFG53wK1hWiOgl6OXIj4jPUj8enSBnx2H0AZ/QAEEOjqFl7WcTB9s/qzsWKwlVOr/GyAPKONN+lz+lb5auXVzqD9Qt/CjT+O2WajRs1viymUBF7cY20GNid3qBvm7H6H0z9Iol7P1cxWOs8PvQCghqlqVxq55ne3zdBerieZaDbURkZGY81TlSrjccfzymj55Q1155STDt45KFFKMnRiCcAWrS8tuVa41Iu23lBsh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0dsoSg6N+Kazvj+fdAKJoYDsR7oRaa65hQEuzNW3fM=;
 b=gxu2TUToOTUxutf6GEBAAvnLdHuYzdST9jci9FLgXx6VgOX2y5z+vjqZqsoDlMq4ZBqWTmmjdrmH43Ud63VDjgu2RKLsn7I/WVd5x9NaI57zddX1G8t/QsdcY1R60dmjwOKM/7rKiTJDFfDGNCWe1eG8EqPFzlYlfopRDXFgwx0=
Received: from DS7PR03CA0272.namprd03.prod.outlook.com (2603:10b6:5:3ad::7) by
 DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Thu, 3 Oct 2024 23:35:39 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::14) by DS7PR03CA0272.outlook.office365.com
 (2603:10b6:5:3ad::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 01/26] drm/amd/display: Unify blank_phantom and
 blank_pixel_data
Date: Thu, 3 Oct 2024 17:33:19 -0600
Message-ID: <20241003233509.210919-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: c861599f-cca9-4bc4-0598-08dce40416c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0CgB7MH4kT3LxMGnS8QMnlgbfPRd4DQxBjHhZU6fFWDwzwcEXehcHReFTtLD?=
 =?us-ascii?Q?QGpJx0yD/1WboIYFTL2ZOQEYxr18Q9nwjnrGRR2p4w61x2RGbhofRmaqDtSj?=
 =?us-ascii?Q?wTh4MCR60JjNcYH8T5dnJthPSttvdMhAZAt4ZRNbhUiL5G8L9QylGFkUEMvZ?=
 =?us-ascii?Q?MOxbktV9oarIyGg3OhmhbMvXddNxr0tE1GWOrbgYqlLDHbKINkIz3fg/c7Pz?=
 =?us-ascii?Q?GJERLeGpRIBp0oZtbGfEZWclRqzqa7OO1G8qnXTsj65GKbHXBqwXZiz8KHk+?=
 =?us-ascii?Q?q3YEuXz6UxASgADLuUdUNtNrMguMI2/TdJremv9AbKcG78ZEtkb74N8Rra3n?=
 =?us-ascii?Q?7lPJzcgn20DxNyBUC7pHXoJDoWPmeiOlJaEU29PXFWXCZQw5XAE6rCA9PAGY?=
 =?us-ascii?Q?m7A5ayfgkUbxgJKSq81+hRehHkn02Wb1sbw9wzeQZJuc1Bp3zzugLwYa6Lw8?=
 =?us-ascii?Q?CKCRV1qj4QB6ajGJ5oNbjjArWTBcIxhFK44Kb1tNBnc3E2vXBeCpQqg3ZFHs?=
 =?us-ascii?Q?AZf6iXf4OxqljvtxArI6SQgc4rkcLF90UGzsxi8fzlFwnERb045c+JO80ARR?=
 =?us-ascii?Q?HsfhZLrMHSn2x607OrIlPA8106YagcbhOhYHlDzpLBXjFJj56eMp6dIDSYu/?=
 =?us-ascii?Q?w9KyII1CyG/MoLhpE58qT7K+Zh37YPOHva15igxAfnQmpaRb+XnP0Z7sLuJU?=
 =?us-ascii?Q?gAQiv1ZUTndypEm/9xEMXYDOYAEuwyxIph11on+0I5eqDbA6oIzG5Bl51F5m?=
 =?us-ascii?Q?HefUG5AZ1UYRsWhibdqfixPfbGyM3ja3E2IYYZO7IFJuntzdSYNBavLAoBbk?=
 =?us-ascii?Q?lLhfl3uToY/OP8aaj7bjMqhmqYrbLKjrYuEYMO06mfuYdniIm/n083SW9nH9?=
 =?us-ascii?Q?oqfFY0qNmYzPMMh6DS9ZSgrujvPpyDTmp3CuVXASiQo/6qHRfcOpzhQzOgRH?=
 =?us-ascii?Q?e1VEyP1D0wICT10VQu/MClJggAIGi2AKRBJ6ShNA2xwkb54df3GDKSpeGQXf?=
 =?us-ascii?Q?vLrIOQfNxlH9fjGu08ucbwuX8uHgoS3ORXj7m/8C7jyQ1RUUsune1a4AGQHh?=
 =?us-ascii?Q?AxeoMD25Yb+zKm20uzrIRdOXoCI8HF1gmU5cplQBjFtAI1Q2ohO2i681EDl/?=
 =?us-ascii?Q?Ocn43p7tFaGv5+i7/7MbBJI06mP4Sc8n3sJlM1VgoGyDvLjzfS/tjBUMto5K?=
 =?us-ascii?Q?46vDuZDD+kPqItZ3nvDvslXWFRPwSWRMr55AmQ1zAhWyw7rIgAZOOdDr62Z3?=
 =?us-ascii?Q?9NXjqdjRryARBdhKeQhW3klQmB6sSngq/QibZNndoLf01XiT1QUxm9K/07v6?=
 =?us-ascii?Q?QD8BljpLKX9sQ2teK2qn1vjl1IjNTniqERArT3yZeA/CfVo8ZcYQP68wCMpO?=
 =?us-ascii?Q?DSl8Xi0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:39.0734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c861599f-cca9-4bc4-0598-08dce40416c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
dcn32_blank_phantom() does not consider the subVP+ODM case when blanking.
Only one of the pipes will get blanked. Remaining pipes are not blanked.
Will cause underflow in the phantom pipe when enabling the CRTC.

[How]
Use blank_pixel_data() instead of blank_phantom().
remove dcn32_blank_phantom() since logic is identical.
Different DPG dimensions get programmed when blanking phantom pipes.
Previously had phantom pipes use DPG dimensions of the main stream.
Now use DPG dimensions of the phantom streams

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 12 +----
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 15 ++----
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 46 -------------------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  5 --
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 -
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 -
 6 files changed, 6 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7df748ec0433..f4a5accf1db9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1235,16 +1235,8 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			 */
 			if (is_phantom) {
 				if (tg->funcs->enable_crtc) {
-					int main_pipe_width = 0, main_pipe_height = 0;
-					struct dc_stream_state *old_paired_stream = dc_state_get_paired_subvp_stream(dc->current_state, old_stream);
-
-					if (old_paired_stream) {
-						main_pipe_width = old_paired_stream->dst.width;
-						main_pipe_height = old_paired_stream->dst.height;
-					}
-
-					if (dc->hwss.blank_phantom)
-						dc->hwss.blank_phantom(dc, tg, main_pipe_width, main_pipe_height);
+					if (dc->hwseq->funcs.blank_pixel_data)
+						dc->hwseq->funcs.blank_pixel_data(dc, pipe, true);
 					tg->funcs->enable_crtc(tg);
 				}
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index e89499536c46..1a32e53c1b22 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2054,22 +2054,15 @@ void dcn20_program_front_end_for_ctx(
 	 */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct dc_stream_state *stream = dc->current_state->res_ctx.pipe_ctx[i].stream;
+		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable && stream &&
-				dc_state_get_pipe_subvp_type(dc->current_state, &dc->current_state->res_ctx.pipe_ctx[i]) == SUBVP_PHANTOM) {
+				dc_state_get_pipe_subvp_type(dc->current_state, pipe) == SUBVP_PHANTOM) {
 			struct timing_generator *tg = dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg;
 
 			if (tg->funcs->enable_crtc) {
-				if (dc->hwss.blank_phantom) {
-					int main_pipe_width = 0, main_pipe_height = 0;
-					struct dc_stream_state *phantom_stream = dc_state_get_paired_subvp_stream(dc->current_state, dc->current_state->res_ctx.pipe_ctx[i].stream);
-
-					if (phantom_stream) {
-						main_pipe_width = phantom_stream->dst.width;
-						main_pipe_height = phantom_stream->dst.height;
-					}
-
-					dc->hwss.blank_phantom(dc, tg, main_pipe_width, main_pipe_height);
+				if (dc->hwseq->funcs.blank_pixel_data) {
+					dc->hwseq->funcs.blank_pixel_data(dc, pipe, true);
 				}
 				tg->funcs->enable_crtc(tg);
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index a985d191f500..119c6d08200f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1698,52 +1698,6 @@ void dcn32_init_blank(
 		hws->funcs.wait_for_blank_complete(opp);
 }
 
-void dcn32_blank_phantom(struct dc *dc,
-		struct timing_generator *tg,
-		int width,
-		int height)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-	enum dc_color_space color_space;
-	struct tg_color black_color = {0};
-	struct output_pixel_processor *opp = NULL;
-	uint32_t num_opps, opp_id_src0, opp_id_src1;
-	uint32_t otg_active_width, otg_active_height;
-	uint32_t i;
-
-	/* program opp dpg blank color */
-	color_space = COLOR_SPACE_SRGB;
-	color_space_to_black_color(dc, color_space, &black_color);
-
-	otg_active_width = width;
-	otg_active_height = height;
-
-	/* get the OPTC source */
-	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
-	ASSERT(opp_id_src0 < dc->res_pool->res_cap->num_opp);
-
-	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
-		if (dc->res_pool->opps[i] != NULL && dc->res_pool->opps[i]->inst == opp_id_src0) {
-			opp = dc->res_pool->opps[i];
-			break;
-		}
-	}
-
-	if (opp && opp->funcs->opp_set_disp_pattern_generator)
-		opp->funcs->opp_set_disp_pattern_generator(
-				opp,
-				CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
-				CONTROLLER_DP_COLOR_SPACE_UDEFINED,
-				COLOR_DEPTH_UNDEFINED,
-				&black_color,
-				otg_active_width,
-				otg_active_height,
-				0);
-
-	if (tg->funcs->is_tg_enabled(tg))
-		hws->funcs.wait_for_blank_complete(opp);
-}
-
 /* phantom stream id's can change often, but can be identical between contexts.
 *  This function checks for the condition the streams are identical to avoid
 *  redundant pipe transitions.
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index cac4a08b92a4..0303a5953673 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -119,11 +119,6 @@ void dcn32_init_blank(
 		struct dc *dc,
 		struct timing_generator *tg);
 
-void dcn32_blank_phantom(struct dc *dc,
-		struct timing_generator *tg,
-		int width,
-		int height);
-
 bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 		const struct dc_state *cur_ctx,
 		const struct dc_state *new_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 8e0946fd5b7f..dbcd2dfb19c1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -117,7 +117,6 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.update_phantom_vp_position = dcn32_update_phantom_vp_position,
 	.update_dsc_pg = dcn32_update_dsc_pg,
 	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
-	.blank_phantom = dcn32_blank_phantom,
 	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.program_outstanding_updates = dcn32_program_outstanding_updates,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index af0d40a5cb77..a1392e776709 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -93,7 +93,6 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.update_phantom_vp_position = dcn32_update_phantom_vp_position,
 	.update_dsc_pg = dcn32_update_dsc_pg,
 	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
-	.blank_phantom = dcn32_blank_phantom,
 	.wait_for_dcc_meta_propagation = dcn401_wait_for_dcc_meta_propagation,
 	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
 	.fams2_global_control_lock = dcn401_fams2_global_control_lock,
-- 
2.45.2

