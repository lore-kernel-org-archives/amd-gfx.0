Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46364C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F8C10E5AD;
	Thu, 22 Jun 2023 21:58:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4CE10E5AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdCafxozDRxZ6GWo506Zun6Cf2qbDMwEJFCf750j/1iOj/+43yGZ4dnBy2VUlOCa7lO+ViheTE/FX/pw2qZpkXs9AwLs+byGZDp4emhdHf79yySKwUqk4MhHFKECV+vjyHEdXQbjbNxchbtXc4M2kGnfNk1bRBaY7lCH5DnrCOz55pHgwRR4vnqh0AMR2iA0HR0C4BR+JRjXI7J3qfZ3k3/2Fir3/aZg+HWkfPlwQ6h8pVgM3eM9nlKAoibBanjaudGwcQsamEnubI29ygTUQ/hXCCSfUudipHQ+PgPmHbAH+hFaPd+xQi2N8XQiFohqCav7HyFDWvdSAOcUWAAOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEd2YqBJq2kLNJKqYVE9Eu3WVuqAgdoQhnAyvBm7KUo=;
 b=U49NALtMKbAewUZN5PtBJNzTT5cXIax23ptGNeJRnxCOTfT75NyQ6yZY2LowEUhRefJcAR+aea+OEFgIhMVu2805Dg4HVlQ8XRqOjLWJW/aHvoqXmwj8kKowOES4BSSAcCk9hOwFQ/AhGo3HulbxTaWU5pJOFi6kNQmkkFCY7LA9yKVuJjbfyc3+BT6B5hwFHeokbA9wxFE7ESh0ehqyeFkIXvnjv+bjtktyUqnFCsLTQXHB/bQeTt4t0aYTjNsRcDX7YAFfQC9A4dGhK77dlmsRjmr39WRkWUs/HjUEjGA8FYzDLI3cCT+3qX4wvR8HnGMHEN6jsqNiMGuo0CKxPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEd2YqBJq2kLNJKqYVE9Eu3WVuqAgdoQhnAyvBm7KUo=;
 b=SCAS8JpIs9ANTmDuuyfx90oBhnLv0sWy9vaT0JjPliAe6Fzw0PtCvvHSwKx6fswA0pnnlGmwvtN9adMoPfwUIqsSwhqNV3gzRhQYT/n+8VeHxOeoo7kdmFwXHdQkCrgslV8akQfSVI4e7XdaYCk41tw7UQ1gg4JE6cWu8ssVdpI=
Received: from SA0PR12CA0030.namprd12.prod.outlook.com (2603:10b6:806:6f::35)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Thu, 22 Jun
 2023 21:58:12 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::11) by SA0PR12CA0030.outlook.office365.com
 (2603:10b6:806:6f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:58:12 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:09 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/11] drm/amd/display: Limit new fast update path to addr and
 gamma / color
Date: Thu, 22 Jun 2023 15:57:29 -0600
Message-ID: <20230622215735.2026220-6-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f03dbee-955a-4556-1320-08db736bc609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+N8cqGNFCpBCOJWhiFnfLSbmvWezD0Vx8PSXhC/fljAY1XSs6SqKSCzlE9WC/NAujBvQsxPCcE/rBGM1lue5CnxxA2+DAxFIn2t8Z4YL23HPZVIuAvVghK4e91agzg4tl84wbe36edKJho3SS2aCF3v12rK3g4zJeLuf36muoduXHKfWktwUi+AuIqJKOkIr2b6XGRDVGh5yp7Z68jkTw7YOpoAbesYFhdYr93JgZp/qTX6PJ7w8pBp1GJq03jmvYUDKjiHpknZOmkUOsdrundg0vMTAwEYR8frS8Jr25pRhio9QqmfYHd4C0OwVpHWWrejXchE1CoR9ZruxIzSVBzEhYqgWhsPVs34+V5eELcTQD0pi5Dv7M3B+VKapAryO5T/N7nuDpS3J7ULsTUR7yjCnEvyzYuotFh8oqYRmuMAy5GlmvQ0T1/ns++DuFUlmvQBaj6Z44lEuM1mkG41FfUgg0IMZebUPcpUOMY1KTHS8YCB3mQdR5x3nrV1dHVhoNw/U5bHzvuayimO5LpyrJmP3SVu1jydqoKtXJavivndVqEjmjKlvRNxfIuqcvBsp2vkIHSImGPcvP9SMf4dmHKAT/Rs0Lhqq90NQcnmmAt1fK3X+G+eMqTg3a2TvDBg3zOcY3AmFyzmJybK34YgfF4Fqodd2bHSB6LXei9xtKYI+V7Sa6Q597zgO7OjD5/vfbR1bTSSermv4tiFhsj2XiqAHzLH0lsF5fv1wK9hK7iIWITxtxM6u1V8S+F2TMOT3vZmQDpb0GDfammD9G6mcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(26005)(186003)(2616005)(36756003)(426003)(336012)(6666004)(16526019)(47076005)(54906003)(82740400003)(81166007)(356005)(478600001)(83380400001)(36860700001)(70206006)(4326008)(70586007)(6916009)(82310400005)(316002)(41300700001)(8936002)(8676002)(40460700003)(2906002)(15650500001)(5660300002)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:12.3454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f03dbee-955a-4556-1320-08db736bc609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- We want to limit the new fast update path to address and gamma updates
  only.
- Add a check in dc_update_planes_and_stream to only take the new fast
  update path if we only have the specific fast updates defined.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 94 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h      | 10 +++
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f413998ff253..b97c4dfa5098 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4243,6 +4243,90 @@ static void update_seamless_boot_flags(struct dc *dc,
 	}
 }
 
+static void populate_fast_updates(struct dc_fast_update *fast_update,
+		struct dc_surface_update *srf_updates,
+		struct dc_stream_update *stream_update)
+{
+	if (srf_updates) {
+		fast_update->flip_addr = srf_updates->flip_addr;
+		fast_update->gamma = srf_updates->gamma;
+		fast_update->gamut_remap_matrix = srf_updates->gamut_remap_matrix;
+		fast_update->input_csc_color_matrix = srf_updates->input_csc_color_matrix;
+		fast_update->coeff_reduction_factor = srf_updates->coeff_reduction_factor;
+	}
+	if (stream_update) {
+		fast_update->out_transfer_func = stream_update->out_transfer_func;
+		fast_update->output_csc_transform = stream_update->output_csc_transform;
+	}
+}
+
+static bool fast_updates_exist(struct dc_fast_update *fast_update)
+{
+	if (fast_update->flip_addr ||
+			fast_update->gamma ||
+			fast_update->gamut_remap_matrix ||
+			fast_update->input_csc_color_matrix ||
+			fast_update->coeff_reduction_factor ||
+			fast_update->out_transfer_func ||
+			fast_update->output_csc_transform)
+		return true;
+
+	return false;
+}
+
+static bool full_update_required(struct dc_surface_update *srf_updates,
+		struct dc_stream_update *stream_update)
+{
+	if (srf_updates &&
+			(srf_updates->plane_info ||
+			srf_updates->scaling_info ||
+			(srf_updates->hdr_mult.value &&
+			srf_updates->hdr_mult.value != srf_updates->surface->hdr_mult.value) ||
+			srf_updates->in_transfer_func ||
+			srf_updates->func_shaper ||
+			srf_updates->lut3d_func ||
+			srf_updates->blend_tf))
+		return true;
+
+	if (stream_update &&
+			(((stream_update->src.height != 0 && stream_update->src.width != 0) ||
+			(stream_update->dst.height != 0 && stream_update->dst.width != 0) ||
+			stream_update->integer_scaling_update) ||
+			stream_update->hdr_static_metadata ||
+			stream_update->abm_level ||
+			stream_update->periodic_interrupt ||
+			stream_update->vrr_infopacket ||
+			stream_update->vsc_infopacket ||
+			stream_update->vsp_infopacket ||
+			stream_update->hfvsif_infopacket ||
+			stream_update->vtem_infopacket ||
+			stream_update->adaptive_sync_infopacket ||
+			stream_update->dpms_off ||
+			stream_update->allow_freesync ||
+			stream_update->vrr_active_variable ||
+			stream_update->vrr_active_fixed ||
+			stream_update->gamut_remap ||
+			stream_update->output_color_space ||
+			stream_update->dither_option ||
+			stream_update->wb_update ||
+			stream_update->dsc_config ||
+			stream_update->mst_bw_update ||
+			stream_update->func_shaper ||
+			stream_update->lut3d_func ||
+			stream_update->pending_test_pattern ||
+			stream_update->crtc_timing_adjust))
+		return true;
+
+	return false;
+}
+
+static bool fast_update_only(struct dc_fast_update *fast_update,
+		struct dc_surface_update *srf_updates,
+		struct dc_stream_update *stream_update)
+{
+	return fast_updates_exist(fast_update) && !full_update_required(srf_updates, stream_update);
+}
+
 bool dc_update_planes_and_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
@@ -4252,6 +4336,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	enum surface_update_type update_type;
 	int i;
 	struct mall_temp_config mall_temp_config;
+	struct dc_fast_update fast_update = {0};
 
 	/* In cases where MPO and split or ODM are used transitions can
 	 * cause underflow. Apply stream configuration with minimal pipe
@@ -4260,6 +4345,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	bool force_minimal_pipe_splitting;
 	bool is_plane_addition;
 
+	populate_fast_updates(&fast_update, srf_updates, stream_update);
 	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
 			dc,
 			stream,
@@ -4310,7 +4396,8 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	}
 
 	update_seamless_boot_flags(dc, context, surface_count, stream);
-	if (!dc->debug.enable_legacy_fast_update && update_type == UPDATE_TYPE_FAST) {
+	if (fast_update_only(&fast_update, srf_updates, stream_update) &&
+			!dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
@@ -4367,7 +4454,9 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	struct dc_state *context;
 	struct dc_context *dc_ctx = dc->ctx;
 	int i, j;
+	struct dc_fast_update fast_update = {0};
 
+	populate_fast_updates(&fast_update, srf_updates, stream_update);
 	stream_status = dc_stream_get_status(stream);
 	context = dc->current_state;
 
@@ -4453,7 +4542,8 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
 
 	update_seamless_boot_flags(dc, context, surface_count, stream);
-	if (!dc->debug.enable_legacy_fast_update && update_type == UPDATE_TYPE_FAST) {
+	if (fast_update_only(&fast_update, srf_updates, stream_update) &&
+			!dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 24f580bdac6a..90e71c3e766f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1264,6 +1264,16 @@ struct dc_scaling_info {
 	struct scaling_taps scaling_quality;
 };
 
+struct dc_fast_update {
+	const struct dc_flip_addrs *flip_addr;
+	const struct dc_gamma *gamma;
+	const struct colorspace_transform *gamut_remap_matrix;
+	const struct dc_csc_transform *input_csc_color_matrix;
+	const struct fixed31_32 *coeff_reduction_factor;
+	struct dc_transfer_func *out_transfer_func;
+	struct dc_csc_transform *output_csc_transform;
+};
+
 struct dc_surface_update {
 	struct dc_plane_state *surface;
 
-- 
2.39.2

