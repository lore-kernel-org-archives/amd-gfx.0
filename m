Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67475EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07BF10E5AE;
	Thu, 22 Jun 2023 21:58:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0AC010E5AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCSUukjAHdwmEsIPftukfFIUD0g2T8axlFJMpME8BU21PK+Dq3V0pGYyvjLeUzwd/mxBOVPIrVtbFemIg5P/L7ZXQzhro70ERzILXpFOyz9F3HPTUf9mdCMuqinCwwb9Lx6v/O2JnfkKB7VgmXcwhrefACvacXYXMgwiTOUjzUi3P6rd5RbwiIK+F2OJjlOw8TYtrH6BV5hJKBCVQYKu/WKV3ysLNwkedPqsM7NZ8G6XTb+N0mVQdRoLxjt1iPNxRYAe5iDS/xV25AiNDLJBtzK2j4Mixpym8kDQCMv6ypU3CgivxDv0E+GvNnaOjYUP76JoWFjMTZZalEVFrgw7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDFCaEP7ZYkkTzYsm9XXL+d7s/RTRuCN7P01Jdv7o1w=;
 b=YU5K6KOIAHxt3hn0y0GbD2dGyV8Ov8uEVWKBQ09+PmoEE4kpw+E3ppZAsDMNJ+PMeEDdt6g9RDsCaSREOIUy6o/S0wz8OX+eM2DqJp8Wqn1EADANTa6whuJxHDN2RVlJB8qI8RHTs3bIZo/TeFNsJzfArB5V/nDf+1siEEI/sOMjNqPNt3zq0I8VXIofZxJU5dKJnMP80AkBwZSJpxoMUmE3ErL4rATZQRRvfqERhYmnA04FBEeLlL9WDoRKn5RcHkLufetOH+pYTAwyCsx1uO7IVgkeURb9Zb5sIpLITCp0UHsf3SpTbxl94SsiqUq1YBREOGqEwM5of/wrrfYDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDFCaEP7ZYkkTzYsm9XXL+d7s/RTRuCN7P01Jdv7o1w=;
 b=BXuboivsIqDsQ/phaLAtjOhNGrBmMWQbcBpqUCxTaNaG97RBZfBEwNMxC0XWbuOXd/jkzaEu1H9Es1f5tZfMctDU2LFtRaljVxMaxT+LjqgoWReOwUXOEiKiY0kq+9e8M98T5iCRWIniraFxyR9PSFkQ+nRjOxNV3pZK756ri+g=
Received: from DM6PR06CA0087.namprd06.prod.outlook.com (2603:10b6:5:336::20)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 21:58:17 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::c9) by DM6PR06CA0087.outlook.office365.com
 (2603:10b6:5:336::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:58:17 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:13 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] drm/amd/display: For new fast update path,
 loop through each surface
Date: Thu, 22 Jun 2023 15:57:31 -0600
Message-ID: <20230622215735.2026220-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
References: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 406b4519-1451-4acc-a22e-08db736bc8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgxfUbk9T+VaKL4PE7UXe4G5mlmVWIvbDy5OqLaonEoqsq2xCmuXo2Aq5vnYh6BvS0VTpdtYzfZKr+JlIjO7IpN63XlX+F2FCkG104zVH8goWer1MFIRQ4wojbueHcaLQ7JLeRs3QtEOMaimPpHC2AG/kCMsAMG20ejL5Gc4T7jEwclHUz5joQUWIxnuLotoGLh2fr8AO6+S8gCi2L44fD8Sx6IRixHXI4Fojna8GCCd6SlTqDD+pxRA6zMsCWqos+BpHz8rcfymvpoVcuh5M4kCxPZ8os9D31vKfhm2n1yo+e0u5kAibG4kWPNKVhsov2ABNbCiD26l7YvcN/LSphdig2A8HkWNYNvtOa+NipISYw4gdtEYbcL9xPNRc0+t1i4Jqrs5JaPARPD6/rlUVhK6gNhUP/OZth9ivgF84J6VQNMKOl+guFWPEHSiOceflkULfiR3oJvilFuU3NNbqZonr8dKeU1U1BsKVHokFEjLMagMkNv4ST6dooGq7PmHt4OU14KMSjaqBY0odLustMZ1hCavSFqpr4lmRw0TRKqHpvSBGw50m9SyDgfAvz8MM3ODizYG59Bt33UMaA4tevtFKQ3Wv7n+XXMjhTaSdQRizhqyxxKS9qgltGFtjloTbxwihx2Xz2G4Bnv1R+JVSKg6f34DGzud9pM8HlDEFBlZaIJNItGGgmP7emLtFORSgqlCTP4UjtqQ+ND2PMXstjV+JzqWE4hAwAOR7yYhPRM2ETpvXzmHT9F5LbUw7MxNypJxMo7JgRkYxLwHZ2mGew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(15650500001)(16526019)(40480700001)(47076005)(2616005)(1076003)(8676002)(8936002)(5660300002)(186003)(26005)(70206006)(2906002)(40460700003)(4326008)(41300700001)(6666004)(81166007)(82740400003)(356005)(83380400001)(426003)(70586007)(6916009)(336012)(36756003)(36860700001)(478600001)(82310400005)(54906003)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:17.1554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 406b4519-1451-4acc-a22e-08db736bc8e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
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
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- Previous implementation didn't consider multiple surfaces in a flip
- Loop through each surface in each flip to ensure the update path is
  correct

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 86 ++++++++++++++----------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b97c4dfa5098..68eabb5f3a39 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4245,48 +4245,64 @@ static void update_seamless_boot_flags(struct dc *dc,
 
 static void populate_fast_updates(struct dc_fast_update *fast_update,
 		struct dc_surface_update *srf_updates,
+		int surface_count,
 		struct dc_stream_update *stream_update)
 {
-	if (srf_updates) {
-		fast_update->flip_addr = srf_updates->flip_addr;
-		fast_update->gamma = srf_updates->gamma;
-		fast_update->gamut_remap_matrix = srf_updates->gamut_remap_matrix;
-		fast_update->input_csc_color_matrix = srf_updates->input_csc_color_matrix;
-		fast_update->coeff_reduction_factor = srf_updates->coeff_reduction_factor;
-	}
+	int i = 0;
+
 	if (stream_update) {
-		fast_update->out_transfer_func = stream_update->out_transfer_func;
-		fast_update->output_csc_transform = stream_update->output_csc_transform;
+		fast_update[0].out_transfer_func = stream_update->out_transfer_func;
+		fast_update[0].output_csc_transform = stream_update->output_csc_transform;
+	}
+
+	for (i = 0; i < surface_count; i++) {
+		fast_update[i].flip_addr = srf_updates[i].flip_addr;
+		fast_update[i].gamma = srf_updates[i].gamma;
+		fast_update[i].gamut_remap_matrix = srf_updates[i].gamut_remap_matrix;
+		fast_update[i].input_csc_color_matrix = srf_updates[i].input_csc_color_matrix;
+		fast_update[i].coeff_reduction_factor = srf_updates[i].coeff_reduction_factor;
 	}
 }
 
-static bool fast_updates_exist(struct dc_fast_update *fast_update)
+static bool fast_updates_exist(struct dc_fast_update *fast_update, int surface_count)
 {
-	if (fast_update->flip_addr ||
-			fast_update->gamma ||
-			fast_update->gamut_remap_matrix ||
-			fast_update->input_csc_color_matrix ||
-			fast_update->coeff_reduction_factor ||
-			fast_update->out_transfer_func ||
-			fast_update->output_csc_transform)
+	int i;
+
+	if (fast_update[0].out_transfer_func ||
+		fast_update[0].output_csc_transform)
 		return true;
 
+	for (i = 0; i < surface_count; i++) {
+		if (fast_update[i].flip_addr ||
+				fast_update[i].gamma ||
+				fast_update[i].gamut_remap_matrix ||
+				fast_update[i].input_csc_color_matrix ||
+				fast_update[i].coeff_reduction_factor)
+			return true;
+	}
+
 	return false;
 }
 
 static bool full_update_required(struct dc_surface_update *srf_updates,
+		int surface_count,
 		struct dc_stream_update *stream_update)
 {
-	if (srf_updates &&
-			(srf_updates->plane_info ||
-			srf_updates->scaling_info ||
-			(srf_updates->hdr_mult.value &&
-			srf_updates->hdr_mult.value != srf_updates->surface->hdr_mult.value) ||
-			srf_updates->in_transfer_func ||
-			srf_updates->func_shaper ||
-			srf_updates->lut3d_func ||
-			srf_updates->blend_tf))
-		return true;
+
+	int i;
+
+	for (i = 0; i < surface_count; i++) {
+		if (srf_updates &&
+				(srf_updates[i].plane_info ||
+				srf_updates[i].scaling_info ||
+				(srf_updates[i].hdr_mult.value &&
+				srf_updates[i].hdr_mult.value != srf_updates->surface->hdr_mult.value) ||
+				srf_updates[i].in_transfer_func ||
+				srf_updates[i].func_shaper ||
+				srf_updates[i].lut3d_func ||
+				srf_updates[i].blend_tf))
+			return true;
+	}
 
 	if (stream_update &&
 			(((stream_update->src.height != 0 && stream_update->src.width != 0) ||
@@ -4322,9 +4338,11 @@ static bool full_update_required(struct dc_surface_update *srf_updates,
 
 static bool fast_update_only(struct dc_fast_update *fast_update,
 		struct dc_surface_update *srf_updates,
+		int surface_count,
 		struct dc_stream_update *stream_update)
 {
-	return fast_updates_exist(fast_update) && !full_update_required(srf_updates, stream_update);
+	return fast_updates_exist(fast_update, surface_count)
+			&& !full_update_required(srf_updates, surface_count, stream_update);
 }
 
 bool dc_update_planes_and_stream(struct dc *dc,
@@ -4336,7 +4354,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	enum surface_update_type update_type;
 	int i;
 	struct mall_temp_config mall_temp_config;
-	struct dc_fast_update fast_update = {0};
+	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
 
 	/* In cases where MPO and split or ODM are used transitions can
 	 * cause underflow. Apply stream configuration with minimal pipe
@@ -4345,7 +4363,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	bool force_minimal_pipe_splitting;
 	bool is_plane_addition;
 
-	populate_fast_updates(&fast_update, srf_updates, stream_update);
+	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
 	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
 			dc,
 			stream,
@@ -4396,7 +4414,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	}
 
 	update_seamless_boot_flags(dc, context, surface_count, stream);
-	if (fast_update_only(&fast_update, srf_updates, stream_update) &&
+	if (fast_update_only(fast_update, srf_updates, surface_count, stream_update) &&
 			!dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
@@ -4454,9 +4472,9 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	struct dc_state *context;
 	struct dc_context *dc_ctx = dc->ctx;
 	int i, j;
-	struct dc_fast_update fast_update = {0};
+	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
 
-	populate_fast_updates(&fast_update, srf_updates, stream_update);
+	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
 	stream_status = dc_stream_get_status(stream);
 	context = dc->current_state;
 
@@ -4542,7 +4560,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
 
 	update_seamless_boot_flags(dc, context, surface_count, stream);
-	if (fast_update_only(&fast_update, srf_updates, stream_update) &&
+	if (fast_update_only(fast_update, srf_updates, surface_count, stream_update) &&
 			!dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
-- 
2.39.2

