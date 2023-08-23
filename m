Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0533EE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C8410E471;
	Wed, 23 Aug 2023 16:04:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3BC10E46D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjOpP308jvsEvoWEEO9q5+NfNnAx1EFDwqcOOC2hma3XQyAv8VTmDWmty4a96M+6t7z+bbvrLsCv0ia8EvrYgbqCDltTuJa9TVtA6NtZi6sPYZbJD+v9DhtaUEtVTnrPM9C72oUvCx+d+Jne6rfWYbyULJDWrLQdmvZlQH00rXaVhvz80dDJht2FFnjEIYIWaKJYrOQG3YiNVMMkYfXg4CptPRc6Ap2pxiH0o6cQMjbSFyiv4NphmB/b3CxAorEmLBndykKePYa/4aBU/X9WG5Sez+ZltBp8a9QH/lkwoox/giC27FKIdY6zYzVVwJ3pOQSZa05AN+71d0vElgzP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IQ7H+7/OtoEt6WKWC8TsaD+5mYz9Lc+U035n4CFnIg=;
 b=kRzQfX9e9U8eyfgndTdpxaRLbiTVDNmG1/FLE6y2HM24Q/LSCkZL0Tg1gm2+f7pV0191K4pz3EDuPjuJ/Zpi9kAyqq62rOJBPs1A7mTXo9SzjqGWvNPAy2ygcitxoszOImUurI33t0T4otd82u+eYu0u4L7wqGadowC0P0Qq+jdQB5krgA4EeOW3qBP2przEnLqrKPeaQHWPpRQl7gbN4UI4o3X7KY4g3vKxlojoz7cTrrscFEx9DVwnN7AlagG8NhOqQSzo6L4af9Gslgg6SOP1iOx/UzKQ+RJ93gjZ0T4xYWyMUiEwPox+NZY8bmxPBkyW9af3p8CH1i2XRuca+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IQ7H+7/OtoEt6WKWC8TsaD+5mYz9Lc+U035n4CFnIg=;
 b=IR12Skd2DqeTQZpdV+sn/6F6Qkzbd4mbRYk6i0q6B549LVZXSAfqyJ8klAAKTCFEQIvIhhvKYKIcno+wScjzbfdNT2dMKmX/v5z4KoGHCcZ0QFNFglGQXgDnN8FaeB/+RXg5bKkb+roBZ6pkvfcAcPtjLxlyJ0jTTv4SlJs7xlM=
Received: from PA7P264CA0118.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::9)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 16:04:36 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::55) by PA7P264CA0118.outlook.office365.com
 (2603:10a6:102:34c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:34 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:31 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/21] drm/amd/display: use new pipe allocation interface in
 dcn32 fpu
Date: Wed, 23 Aug 2023 11:58:14 -0400
Message-ID: <20230823160347.176991-13-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d05fb0-14da-457c-1a3b-08dba3f2a4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MO+fptt2zLZzhDB7zdm9ax/NNfXpm8fRmaCaI5l9ZWJfo/xVetb8Ggwu853hfnOKXVH/DtTYrl95+noQ7uKEW7OVpcA76LzwjpRSJmWUjh1UVeQ16fXLo/Q7WPM/pezcmftKyIC5pb1rglXzLbWz5Yt52GXAxpcKORS6qdEcutlfLzfTiGo8yAW90OuXJLxGdzGA77pRyYM9JtC94DtZBvj5qceffOhmxsteznHG7sHKmg3PGVNjLYi7v0l7luin2x4f7dV2+wVqm/yFX2E5/sN/vPBSLa4H8GGP85r4pbpOglldEKBzGh1afP2wQvxjiHF8ICesCWOZI7a9uqzOT6bkrF/80+OrdUcaVk0Mihrt0srWl33g+bG9hlLl54dROYXIW6Jnw+Jb6IhGIDgZZHygiVS9tQ/DhEM1MdNP/vTLpRxi90Bt7l57UDGJbfLbmRnwWZJdZV2ZFjOe6k4P2EjAA0eURP5/V3xNHMDW3/u2CRL3DPrANg8WcoeWFSFO5WEgPjfoSmLSb83k9DsK6866lk7gQFzmV9cp4DxTvPjhIJQId3+tjhT94D7K/bCVKfiEdQ2q0UsQ33DB9kxw2Xmw30N3dqq7au9VkXOqhw7UUFHyNnkUfJ4OtI4JuMMcBGUBXxXozS3fCjspwHB9N7B/aeA3c4ZXG1gK679yAK4T+XP59PYWAgv9LAedrRK5VRwSMespH7Ry+xKOcnmWuxZP5Lt4bWPgmG+pCcvur7nXbXla9GxDYGxffh7kncS/ofYAGZP3kyM69b4Hyoo/G0uHr4YQqYdqZLSHon3WWj3dNpvXDOR5UvFmFMY74awT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(6666004)(40480700001)(2616005)(1076003)(40460700003)(86362001)(4326008)(5660300002)(44832011)(30864003)(2906002)(70206006)(70586007)(54906003)(8676002)(8936002)(36756003)(41300700001)(6916009)(316002)(81166007)(478600001)(82740400003)(36860700001)(83380400001)(356005)(426003)(47076005)(336012)(16526019)(26005)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:34.4120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d05fb0-14da-457c-1a3b-08dba3f2a4c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

This commit implements a new pipe resource allocation logic for DCN32
when windowed ODM MPO flag is set to enable testing. By default the
flag is not set. It will be toggled on after we complete testing.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 488 ++++++++++++------
 1 file changed, 339 insertions(+), 149 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 96e3075e6dd0..0c68cd97a461 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1654,6 +1654,188 @@ static bool dcn32_split_stream_for_mpc_or_odm(
 	return true;
 }
 
+struct pipe_slice_table {
+	struct {
+		struct dc_stream_state *stream;
+		int slice_count;
+	} odm_combines[MAX_STREAMS];
+	int odm_combine_count;
+
+	struct {
+		struct dc_plane_state *plane;
+		int slice_count;
+	} mpc_combines[MAX_SURFACES];
+	int mpc_combine_count;
+};
+
+static void update_slice_table_for_stream(struct pipe_slice_table *table,
+		struct dc_stream_state *stream, int diff)
+{
+	int i;
+
+	for (i = 0; i < table->odm_combine_count; i++) {
+		if (table->odm_combines[i].stream == stream) {
+			table->odm_combines[i].slice_count += diff;
+			break;
+		}
+	}
+
+	if (i == table->odm_combine_count) {
+		table->odm_combine_count++;
+		table->odm_combines[i].stream = stream;
+		table->odm_combines[i].slice_count = diff;
+	}
+}
+
+static void update_slice_table_for_plane(struct pipe_slice_table *table,
+		struct dc_plane_state *plane, int diff)
+{
+	int i;
+
+	for (i = 0; i < table->mpc_combine_count; i++) {
+		if (table->mpc_combines[i].plane == plane) {
+			table->mpc_combines[i].slice_count += diff;
+			break;
+		}
+	}
+
+	if (i == table->mpc_combine_count) {
+		table->mpc_combine_count++;
+		table->mpc_combines[i].plane = plane;
+		table->mpc_combines[i].slice_count = diff;
+	}
+}
+
+static void init_pipe_slice_table_from_context(
+		struct pipe_slice_table *table,
+		struct dc_state *context)
+{
+	int i, j;
+	struct pipe_ctx *otg_master;
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	struct dc_stream_state *stream;
+	int count;
+
+	memset(table, 0, sizeof(*table));
+
+	for (i = 0; i < context->stream_count; i++) {
+		stream = context->streams[i];
+		otg_master = resource_get_otg_master_for_stream(
+				&context->res_ctx, stream);
+		count = resource_get_odm_slice_count(otg_master);
+		update_slice_table_for_stream(table, stream, count);
+
+		count = resource_get_dpp_pipes_for_opp_head(otg_master,
+				&context->res_ctx, dpp_pipes);
+		for (j = 0; j < count; j++)
+			if (dpp_pipes[j]->plane_state)
+				update_slice_table_for_plane(table,
+						dpp_pipes[j]->plane_state, 1);
+	}
+}
+
+static bool update_pipe_slice_table_with_split_flags(
+		struct pipe_slice_table *table,
+		struct dc *dc,
+		struct dc_state *context,
+		struct vba_vars_st *vba,
+		int split[MAX_PIPES],
+		bool merge[MAX_PIPES])
+{
+	/* NOTE: we are deprecating the support for the concept of pipe splitting
+	 * or pipe merging. Instead we append slices to the end and remove
+	 * slices from the end. The following code converts a pipe split or
+	 * merge to an append or remove operation.
+	 *
+	 * For example:
+	 * When split flags describe the following pipe connection transition
+	 *
+	 * from:
+	 *  pipe 0 (split=2) -> pipe 1 (split=2)
+	 * to: (old behavior)
+	 *  pipe 0 -> pipe 2 -> pipe 1 -> pipe 3
+	 *
+	 * the code below actually does:
+	 *  pipe 0 -> pipe 1 -> pipe 2 -> pipe 3
+	 *
+	 * This is the new intended behavior and for future DCNs we will retire
+	 * the old concept completely.
+	 */
+	struct pipe_ctx *pipe;
+	bool odm;
+	int i;
+	bool updated = false;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (merge[i]) {
+			if (resource_is_pipe_type(pipe, OPP_HEAD))
+				/* merging OPP head means reducing ODM slice
+				 * count by 1
+				 */
+				update_slice_table_for_stream(table, pipe->stream, -1);
+			else if (resource_is_pipe_type(pipe, DPP_PIPE) &&
+					resource_get_odm_slice_index(resource_get_opp_head(pipe)) == 0)
+				/* merging DPP pipe of the first ODM slice means
+				 * reducing MPC slice count by 1
+				 */
+				update_slice_table_for_plane(table, pipe->plane_state, -1);
+			updated = true;
+		}
+
+		if (split[i]) {
+			odm = vba->ODMCombineEnabled[vba->pipe_plane[i]] !=
+					dm_odm_combine_mode_disabled;
+			if (odm && resource_is_pipe_type(pipe, OPP_HEAD))
+				update_slice_table_for_stream(
+						table, pipe->stream, split[i] - 1);
+			else if (!odm && resource_is_pipe_type(pipe, DPP_PIPE))
+				update_slice_table_for_plane(
+						table, pipe->plane_state, split[i] - 1);
+			updated = true;
+		}
+	}
+	return updated;
+}
+
+static void update_pipes_with_slice_table(struct dc *dc, struct dc_state *context,
+		struct pipe_slice_table *table)
+{
+	int i;
+
+	for (i = 0; i < table->odm_combine_count; i++) {
+		resource_update_pipes_for_stream_with_slice_count(context,
+				dc->current_state, dc->res_pool,
+				table->odm_combines[i].stream,
+				table->odm_combines[i].slice_count);
+		/* TODO: move this into the function above */
+		dcn20_build_mapped_resource(dc, context,
+				table->odm_combines[i].stream);
+	}
+
+	for (i = 0; i < table->mpc_combine_count; i++)
+		resource_update_pipes_for_plane_with_slice_count(context,
+				dc->current_state, dc->res_pool,
+				table->mpc_combines[i].plane,
+				table->mpc_combines[i].slice_count);
+}
+
+static bool update_pipes_with_split_flags(struct dc *dc, struct dc_state *context,
+		struct vba_vars_st *vba, int split[MAX_PIPES],
+		bool merge[MAX_PIPES])
+{
+	struct pipe_slice_table slice_table;
+	bool updated;
+
+	init_pipe_slice_table_from_context(&slice_table, context);
+	updated = update_pipe_slice_table_with_split_flags(
+			&slice_table, dc, context, vba,
+			split, merge);
+	update_pipes_with_slice_table(dc, context, &slice_table);
+	return updated;
+}
+
 bool dcn32_internal_validate_bw(struct dc *dc,
 				struct dc_state *context,
 				display_e2e_pipe_params_st *pipes,
@@ -1749,173 +1931,181 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		pipe_idx++;
 	}
 
-	/* merge pipes if necessary */
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+	if (dc->config.enable_windowed_mpo_odm) {
+		repopulate_pipes = update_pipes_with_split_flags(
+				dc, context, vba, split, merge);
+	} else {
+		/* the code below will be removed once windowed mpo odm is fully
+		 * enabled.
+		 */
+		/* merge pipes if necessary */
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		/*skip pipes that don't need merging*/
-		if (!merge[i])
-			continue;
+			/*skip pipes that don't need merging*/
+			if (!merge[i])
+				continue;
 
-		/* if ODM merge we ignore mpc tree, mpo pipes will have their own flags */
-		if (pipe->prev_odm_pipe) {
-			/*split off odm pipe*/
-			pipe->prev_odm_pipe->next_odm_pipe = pipe->next_odm_pipe;
-			if (pipe->next_odm_pipe)
-				pipe->next_odm_pipe->prev_odm_pipe = pipe->prev_odm_pipe;
-
-			/*2:1ODM+MPC Split MPO to Single Pipe + MPC Split MPO*/
-			if (pipe->bottom_pipe) {
-				if (pipe->bottom_pipe->prev_odm_pipe || pipe->bottom_pipe->next_odm_pipe) {
-					/*MPC split rules will handle this case*/
-					pipe->bottom_pipe->top_pipe = NULL;
-				} else {
-					/* when merging an ODM pipes, the bottom MPC pipe must now point to
-					 * the previous ODM pipe and its associated stream assets
-					 */
-					if (pipe->prev_odm_pipe->bottom_pipe) {
-						/* 3 plane MPO*/
-						pipe->bottom_pipe->top_pipe = pipe->prev_odm_pipe->bottom_pipe;
-						pipe->prev_odm_pipe->bottom_pipe->bottom_pipe = pipe->bottom_pipe;
+			/* if ODM merge we ignore mpc tree, mpo pipes will have their own flags */
+			if (pipe->prev_odm_pipe) {
+				/*split off odm pipe*/
+				pipe->prev_odm_pipe->next_odm_pipe = pipe->next_odm_pipe;
+				if (pipe->next_odm_pipe)
+					pipe->next_odm_pipe->prev_odm_pipe = pipe->prev_odm_pipe;
+
+				/*2:1ODM+MPC Split MPO to Single Pipe + MPC Split MPO*/
+				if (pipe->bottom_pipe) {
+					if (pipe->bottom_pipe->prev_odm_pipe || pipe->bottom_pipe->next_odm_pipe) {
+						/*MPC split rules will handle this case*/
+						pipe->bottom_pipe->top_pipe = NULL;
 					} else {
-						/* 2 plane MPO*/
-						pipe->bottom_pipe->top_pipe = pipe->prev_odm_pipe;
-						pipe->prev_odm_pipe->bottom_pipe = pipe->bottom_pipe;
+						/* when merging an ODM pipes, the bottom MPC pipe must now point to
+						 * the previous ODM pipe and its associated stream assets
+						 */
+						if (pipe->prev_odm_pipe->bottom_pipe) {
+							/* 3 plane MPO*/
+							pipe->bottom_pipe->top_pipe = pipe->prev_odm_pipe->bottom_pipe;
+							pipe->prev_odm_pipe->bottom_pipe->bottom_pipe = pipe->bottom_pipe;
+						} else {
+							/* 2 plane MPO*/
+							pipe->bottom_pipe->top_pipe = pipe->prev_odm_pipe;
+							pipe->prev_odm_pipe->bottom_pipe = pipe->bottom_pipe;
+						}
+
+						memcpy(&pipe->bottom_pipe->stream_res, &pipe->bottom_pipe->top_pipe->stream_res, sizeof(struct stream_resource));
 					}
+				}
 
-					memcpy(&pipe->bottom_pipe->stream_res, &pipe->bottom_pipe->top_pipe->stream_res, sizeof(struct stream_resource));
+				if (pipe->top_pipe) {
+					pipe->top_pipe->bottom_pipe = NULL;
 				}
-			}
 
-			if (pipe->top_pipe) {
-				pipe->top_pipe->bottom_pipe = NULL;
-			}
+				pipe->bottom_pipe = NULL;
+				pipe->next_odm_pipe = NULL;
+				pipe->plane_state = NULL;
+				pipe->stream = NULL;
+				pipe->top_pipe = NULL;
+				pipe->prev_odm_pipe = NULL;
+				if (pipe->stream_res.dsc)
+					dcn20_release_dsc(&context->res_ctx, dc->res_pool, &pipe->stream_res.dsc);
+				memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
+				memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
+				memset(&pipe->link_res, 0, sizeof(pipe->link_res));
+				repopulate_pipes = true;
+			} else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
+				struct pipe_ctx *top_pipe = pipe->top_pipe;
+				struct pipe_ctx *bottom_pipe = pipe->bottom_pipe;
+
+				top_pipe->bottom_pipe = bottom_pipe;
+				if (bottom_pipe)
+					bottom_pipe->top_pipe = top_pipe;
+
+				pipe->top_pipe = NULL;
+				pipe->bottom_pipe = NULL;
+				pipe->plane_state = NULL;
+				pipe->stream = NULL;
+				memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
+				memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
+				memset(&pipe->link_res, 0, sizeof(pipe->link_res));
+				repopulate_pipes = true;
+			} else
+				ASSERT(0); /* Should never try to merge master pipe */
 
-			pipe->bottom_pipe = NULL;
-			pipe->next_odm_pipe = NULL;
-			pipe->plane_state = NULL;
-			pipe->stream = NULL;
-			pipe->top_pipe = NULL;
-			pipe->prev_odm_pipe = NULL;
-			if (pipe->stream_res.dsc)
-				dcn20_release_dsc(&context->res_ctx, dc->res_pool, &pipe->stream_res.dsc);
-			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
-			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
-			memset(&pipe->link_res, 0, sizeof(pipe->link_res));
-			repopulate_pipes = true;
-		} else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
-			struct pipe_ctx *top_pipe = pipe->top_pipe;
-			struct pipe_ctx *bottom_pipe = pipe->bottom_pipe;
-
-			top_pipe->bottom_pipe = bottom_pipe;
-			if (bottom_pipe)
-				bottom_pipe->top_pipe = top_pipe;
-
-			pipe->top_pipe = NULL;
-			pipe->bottom_pipe = NULL;
-			pipe->plane_state = NULL;
-			pipe->stream = NULL;
-			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
-			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
-			memset(&pipe->link_res, 0, sizeof(pipe->link_res));
-			repopulate_pipes = true;
-		} else
-			ASSERT(0); /* Should never try to merge master pipe */
-
-	}
-
-	for (i = 0, pipe_idx = -1; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *hsplit_pipe = NULL;
-		bool odm;
-		int old_index = -1;
+		}
 
-		if (!pipe->stream || newly_split[i])
-			continue;
+		for (i = 0, pipe_idx = -1; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+			struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			struct pipe_ctx *hsplit_pipe = NULL;
+			bool odm;
+			int old_index = -1;
 
-		pipe_idx++;
-		odm = vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled;
+			if (!pipe->stream || newly_split[i])
+				continue;
 
-		if (!pipe->plane_state && !odm)
-			continue;
+			pipe_idx++;
+			odm = vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled;
 
-		if (split[i]) {
-			if (odm) {
-				if (split[i] == 4 && old_pipe->next_odm_pipe && old_pipe->next_odm_pipe->next_odm_pipe)
-					old_index = old_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
-				else if (old_pipe->next_odm_pipe)
+			if (!pipe->plane_state && !odm)
+				continue;
+
+			if (split[i]) {
+				if (odm) {
+					if (split[i] == 4 && old_pipe->next_odm_pipe && old_pipe->next_odm_pipe->next_odm_pipe)
+						old_index = old_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
+					else if (old_pipe->next_odm_pipe)
+						old_index = old_pipe->next_odm_pipe->pipe_idx;
+				} else {
+					if (split[i] == 4 && old_pipe->bottom_pipe && old_pipe->bottom_pipe->bottom_pipe &&
+							old_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+						old_index = old_pipe->bottom_pipe->bottom_pipe->pipe_idx;
+					else if (old_pipe->bottom_pipe &&
+							old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+						old_index = old_pipe->bottom_pipe->pipe_idx;
+				}
+				hsplit_pipe = dcn32_find_split_pipe(dc, context, old_index);
+				ASSERT(hsplit_pipe);
+				if (!hsplit_pipe)
+					goto validate_fail;
+
+				if (!dcn32_split_stream_for_mpc_or_odm(
+						dc, &context->res_ctx,
+						pipe, hsplit_pipe, odm))
+					goto validate_fail;
+
+				newly_split[hsplit_pipe->pipe_idx] = true;
+				repopulate_pipes = true;
+			}
+			if (split[i] == 4) {
+				struct pipe_ctx *pipe_4to1;
+
+				if (odm && old_pipe->next_odm_pipe)
 					old_index = old_pipe->next_odm_pipe->pipe_idx;
-			} else {
-				if (split[i] == 4 && old_pipe->bottom_pipe && old_pipe->bottom_pipe->bottom_pipe &&
-						old_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
-					old_index = old_pipe->bottom_pipe->bottom_pipe->pipe_idx;
-				else if (old_pipe->bottom_pipe &&
-						old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+				else if (!odm && old_pipe->bottom_pipe &&
+							old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
 					old_index = old_pipe->bottom_pipe->pipe_idx;
+				else
+					old_index = -1;
+				pipe_4to1 = dcn32_find_split_pipe(dc, context, old_index);
+				ASSERT(pipe_4to1);
+				if (!pipe_4to1)
+					goto validate_fail;
+				if (!dcn32_split_stream_for_mpc_or_odm(
+						dc, &context->res_ctx,
+						pipe, pipe_4to1, odm))
+					goto validate_fail;
+				newly_split[pipe_4to1->pipe_idx] = true;
+
+				if (odm && old_pipe->next_odm_pipe && old_pipe->next_odm_pipe->next_odm_pipe
+						&& old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe)
+					old_index = old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
+				else if (!odm && old_pipe->bottom_pipe && old_pipe->bottom_pipe->bottom_pipe &&
+						old_pipe->bottom_pipe->bottom_pipe->bottom_pipe &&
+						old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+					old_index = old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->pipe_idx;
+				else
+					old_index = -1;
+				pipe_4to1 = dcn32_find_split_pipe(dc, context, old_index);
+				ASSERT(pipe_4to1);
+				if (!pipe_4to1)
+					goto validate_fail;
+				if (!dcn32_split_stream_for_mpc_or_odm(
+						dc, &context->res_ctx,
+						hsplit_pipe, pipe_4to1, odm))
+					goto validate_fail;
+				newly_split[pipe_4to1->pipe_idx] = true;
 			}
-			hsplit_pipe = dcn32_find_split_pipe(dc, context, old_index);
-			ASSERT(hsplit_pipe);
-			if (!hsplit_pipe)
-				goto validate_fail;
-
-			if (!dcn32_split_stream_for_mpc_or_odm(
-					dc, &context->res_ctx,
-					pipe, hsplit_pipe, odm))
-				goto validate_fail;
-
-			newly_split[hsplit_pipe->pipe_idx] = true;
-			repopulate_pipes = true;
-		}
-		if (split[i] == 4) {
-			struct pipe_ctx *pipe_4to1;
-
-			if (odm && old_pipe->next_odm_pipe)
-				old_index = old_pipe->next_odm_pipe->pipe_idx;
-			else if (!odm && old_pipe->bottom_pipe &&
-						old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
-				old_index = old_pipe->bottom_pipe->pipe_idx;
-			else
-				old_index = -1;
-			pipe_4to1 = dcn32_find_split_pipe(dc, context, old_index);
-			ASSERT(pipe_4to1);
-			if (!pipe_4to1)
-				goto validate_fail;
-			if (!dcn32_split_stream_for_mpc_or_odm(
-					dc, &context->res_ctx,
-					pipe, pipe_4to1, odm))
-				goto validate_fail;
-			newly_split[pipe_4to1->pipe_idx] = true;
-
-			if (odm && old_pipe->next_odm_pipe && old_pipe->next_odm_pipe->next_odm_pipe
-					&& old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe)
-				old_index = old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
-			else if (!odm && old_pipe->bottom_pipe && old_pipe->bottom_pipe->bottom_pipe &&
-					old_pipe->bottom_pipe->bottom_pipe->bottom_pipe &&
-					old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
-				old_index = old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->pipe_idx;
-			else
-				old_index = -1;
-			pipe_4to1 = dcn32_find_split_pipe(dc, context, old_index);
-			ASSERT(pipe_4to1);
-			if (!pipe_4to1)
-				goto validate_fail;
-			if (!dcn32_split_stream_for_mpc_or_odm(
-					dc, &context->res_ctx,
-					hsplit_pipe, pipe_4to1, odm))
-				goto validate_fail;
-			newly_split[pipe_4to1->pipe_idx] = true;
+			if (odm)
+				dcn20_build_mapped_resource(dc, context, pipe->stream);
 		}
-		if (odm)
-			dcn20_build_mapped_resource(dc, context, pipe->stream);
-	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (pipe->plane_state) {
-			if (!resource_build_scaling_params(pipe))
-				goto validate_fail;
+			if (pipe->plane_state) {
+				if (!resource_build_scaling_params(pipe))
+					goto validate_fail;
+			}
 		}
 	}
 
-- 
2.41.0

