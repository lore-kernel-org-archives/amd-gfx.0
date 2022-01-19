Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A8CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 08:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0580310E666;
	Wed, 19 Jan 2022 08:25:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A365210E67B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 08:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr82ejD08Gvdf8VPbKnlzNl59MqVU2Hwrv+83zG9jh7Y7HPH0gbqZLFH2ReGkQSzsRPqXjtSksAUsDk+vb8QUlevkUpwH0NppBxZQCyDyad8CJUIyTzdEW/CqEd5EXuX6+NAXwnAmSjBLZ7lw8rj2WFK3t2exmX4hgx5+gfWTSpmZNk8ETmHo//ic0Ma0ONZwTnTeV/nodyAxpQK5EkmMobWSH8hS8/WngyC/hO8scj4rYHajublLBHyEjMYVvwo7lQI1iaeuJmhN4GLqvGrck/EBp+vS8SaCmUosZl77TryYPF81bRB8MMsUYkkQd7Lqb3BpgoWrz2zmZDAEw9EYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qduR2nFEHZix/0gChfO58FjX08YXmi9dxLPP8Tw+odM=;
 b=iu+Eo92AGKnAop7dttwPaJCoZrbU65J0RzaElB8w0p4DsRlbcma+aWjP9f0aeDqjZ5A7pZZUIrr44bn/UF/sdMI+6rbBG3LXhn+pOfy6REJpvHldk81aIXJp5K38Q5KTuZ+DinetRukMO4oq5ywXduJQBCZqtmXHFo6uq9BSkMWxBG+tOm9iv07HgBv8dP6keKza8Xum2eWmYroUcQV61zE37UFa867xfp3NwCYbb8GIy+Kj2suciprZAlvcV+mAAUf3oU7aJAPD8NUiG/Bn/vUT2uwwiwLMoty9fbj3H1oOT52/Gsiba/TqdR/OC/o7dllJhZ02eeqkpEv7AJPv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qduR2nFEHZix/0gChfO58FjX08YXmi9dxLPP8Tw+odM=;
 b=DZE3vXLMDmzJIh0nitOxDK73Jf84YSMBHS8+AiBYXSFPBew2fYvfyEnYLiZTiBHJISGaQMyYpK1fIdriNGF+3E+aUqCs3cwjZECQm+uXWFrCKCxhHBQCEzWYW3pVsI1j/8TTgRYJI8FNXSZh4HqSn+CUZRd266qpsq1Aco9sJ4U=
Received: from MWHPR19CA0023.namprd19.prod.outlook.com (2603:10b6:300:d4::33)
 by CH2PR12MB4889.namprd12.prod.outlook.com (2603:10b6:610:68::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 08:25:22 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::4) by MWHPR19CA0023.outlook.office365.com
 (2603:10b6:300:d4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 08:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 08:25:22 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:25:21 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 00:25:20 -0800
Received: from wayne-Celadon-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Wed, 19 Jan 2022 02:25:17 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amd/display: abstract encoder related hwseq across
 different types
Date: Wed, 19 Jan 2022 16:24:39 +0800
Message-ID: <20220119082443.1046810-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119082443.1046810-1-Wayne.Lin@amd.com>
References: <20220119082443.1046810-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d783e053-199d-4a16-cd04-08d9db253c58
X-MS-TrafficTypeDiagnostic: CH2PR12MB4889:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB48898049E48A4BC5416F048CFC599@CH2PR12MB4889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1h2AopMO4p2fOyk3E115qJYFGsK3JEOM5scK5C/mg0+g8I6PifPt8AtrtK1oG9JRzvw+m3C+0UsMk3iwwf86UZ4NYarkpMnR2XIeXBdVXIfcyTGNbZW5F6F4nLduH46S7rJqj/ZSe7mlhVkcZxxAsl6sp5dixZefb+vvCgsA837EPViDmxr98UuCju13QS+ygdKuBMaDFjFBPuXUUFGxnphYhpNphncbG4Vt7HA5shx1B3cboPZ/0XN/Vyh+VA3DvNlKQYKg+SD6mwHSYSz+CBnnzCFvsiF5Q/d6mBSC7RrkJK08d83AGxnnkFnigNp94hLxZgQT9Y0eiH7Uei8uzJpr0OK4FVqgR13iFu0PUjAESy4iv45Cigu8JNz6IcHxpeqvycEilL7P23eF1WRvkLpfk/HINCwk6PsoKUNY3cs9TVNXZhmoAJ/D+Vpv6Gkl+dYWmwOBUSFdD2eV4e/ME7it1yAT2D91xW63ebwLRZhbylRdelRGzJ5jY0ImuIs3phDKcUsed8L0OgUgM48PddRQS5sa2+CVEj9BhUqKDKkeMg4VVmBbtpYDLEPx/f3vr5Fd+ho+/K1FM7yO0+Rxc7XmxJqvp5wBEMxGsv+7NAh+uxFuG8uJBiwVDUW+Bx6JN4feKOUeTc67ali9pcUEuxmip7+fTvOvqcVU+IfYvUOeMc6NpVGR9k74UmwArOYYeJCr2sI5k9xGqfGKX3UrrtjiMX2a1zP8rTRgKdI+fUgSoAWlkPbG4b/7+d/aUHDcVzp79XwbhXLM0KJKazVVi97lSZUuinkweaHtAW371k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(86362001)(508600001)(54906003)(316002)(1076003)(36860700001)(356005)(4326008)(70206006)(7696005)(2616005)(5660300002)(186003)(82310400004)(47076005)(2906002)(36756003)(26005)(8936002)(83380400001)(6916009)(30864003)(8676002)(70586007)(336012)(426003)(6666004)(40460700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:25:22.0798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d783e053-199d-4a16-cd04-08d9db253c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4889
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Current we have hundreds of if/else or switch statement to check
encoder type in dc_link level. The reason is because depending
on the type of encoder dc_link needs to perform similar programming
task but with different encoder interfaces. The story is to abstract
these interfaces so dc_link can just perform the programming task
without knowing the detail of which encoder it's dealing with.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 83 ++++++++----------
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 85 +++++++++++++++++++
 .../amd/display/dc/inc/hw/stream_encoder.h    |  4 +
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    | 19 +++++
 4 files changed, 143 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 33a22c90cf4a..6e10d3e7fefa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3432,6 +3432,8 @@ static enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx,
 	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
 	struct link_mst_stream_allocation_table proposed_table = {0};
 	struct fixed31_32 avg_time_slots_per_mtp;
+	const struct dc_link_settings empty_link_settings = {0};
+	const struct dc_link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	/* slot X.Y for SST payload deallocate */
@@ -3440,10 +3442,11 @@ static enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx,
 
 		dc_log_vcp_x_y(link, avg_time_slots_per_mtp);
 
-		hpo_dp_link_encoder->funcs->set_throttled_vcp_size(
-				hpo_dp_link_encoder,
-				hpo_dp_stream_encoder->inst,
-				avg_time_slots_per_mtp);
+		link_hwss->set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
+		if (link_hwss->set_hblank_min_symbol_width)
+			link_hwss->set_hblank_min_symbol_width(pipe_ctx,
+					&empty_link_settings,
+					avg_time_slots_per_mtp);
 	}
 
 	/* calculate VC payload and update branch with new payload allocation table*/
@@ -3487,10 +3490,11 @@ static enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx,
 
 		dc_log_vcp_x_y(link, avg_time_slots_per_mtp);
 
-		hpo_dp_link_encoder->funcs->set_throttled_vcp_size(
-				hpo_dp_link_encoder,
-				hpo_dp_stream_encoder->inst,
-				avg_time_slots_per_mtp);
+		link_hwss->set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
+		if (link_hwss->set_hblank_min_symbol_width)
+			link_hwss->set_hblank_min_symbol_width(pipe_ctx,
+					&link->cur_link_settings,
+					avg_time_slots_per_mtp);
 	}
 
 	/* Always return DC_OK.
@@ -3507,15 +3511,14 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
 	struct link_encoder *link_encoder = NULL;
-	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
 	struct hpo_dp_link_encoder *hpo_dp_link_encoder = pipe_ctx->link_res.hpo_dp_link_enc;
-	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	struct fixed31_32 avg_time_slots_per_mtp;
 	struct fixed31_32 pbn;
 	struct fixed31_32 pbn_per_slot;
 	int i;
 	enum act_return_status ret;
+	const struct dc_link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	/* Link encoder may have been dynamically assigned to non-physical display endpoint. */
@@ -3621,22 +3624,13 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	pbn = get_pbn_from_timing(pipe_ctx);
 	avg_time_slots_per_mtp = dc_fixpt_div(pbn, pbn_per_slot);
 
-	switch (dp_get_link_encoding_format(&link->cur_link_settings)) {
-	case DP_8b_10b_ENCODING:
-		stream_encoder->funcs->set_throttled_vcp_size(
-			stream_encoder,
-			avg_time_slots_per_mtp);
-		break;
-	case DP_128b_132b_ENCODING:
-		hpo_dp_link_encoder->funcs->set_throttled_vcp_size(
-				hpo_dp_link_encoder,
-				hpo_dp_stream_encoder->inst,
+	dc_log_vcp_x_y(link, avg_time_slots_per_mtp);
+
+	link_hwss->set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
+	if (link_hwss->set_hblank_min_symbol_width)
+		link_hwss->set_hblank_min_symbol_width(pipe_ctx,
+				&link->cur_link_settings,
 				avg_time_slots_per_mtp);
-		break;
-	case DP_UNKNOWN_ENCODING:
-		DC_LOG_ERROR("Failure: unknown encoding format\n");
-		return DC_ERROR_UNEXPECTED;
-	}
 
 	return DC_OK;
 
@@ -3650,10 +3644,10 @@ enum dc_status dc_link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw
 	struct fixed31_32 pbn;
 	struct fixed31_32 pbn_per_slot;
 	struct link_encoder *link_encoder = link->link_enc;
-	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	uint8_t i;
 	enum act_return_status ret;
+	const struct dc_link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	/* decrease throttled vcp size */
@@ -3661,8 +3655,10 @@ enum dc_status dc_link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw
 	pbn = get_pbn_from_bw_in_kbps(bw_in_kbps);
 	avg_time_slots_per_mtp = dc_fixpt_div(pbn, pbn_per_slot);
 
-	stream_encoder->funcs->set_throttled_vcp_size(
-				stream_encoder,
+	link_hwss->set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
+	if (link_hwss->set_hblank_min_symbol_width)
+		link_hwss->set_hblank_min_symbol_width(pipe_ctx,
+				&link->cur_link_settings,
 				avg_time_slots_per_mtp);
 
 	/* send ALLOCATE_PAYLOAD sideband message with updated pbn */
@@ -3730,10 +3726,10 @@ enum dc_status dc_link_increase_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t
 	struct fixed31_32 pbn;
 	struct fixed31_32 pbn_per_slot;
 	struct link_encoder *link_encoder = link->link_enc;
-	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	uint8_t i;
 	enum act_return_status ret;
+	const struct dc_link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	/* notify immediate branch device table update */
@@ -3792,8 +3788,10 @@ enum dc_status dc_link_increase_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t
 	pbn_per_slot = get_pbn_per_slot(stream);
 	avg_time_slots_per_mtp = dc_fixpt_div(pbn, pbn_per_slot);
 
-	stream_encoder->funcs->set_throttled_vcp_size(
-				stream_encoder,
+	link_hwss->set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
+	if (link_hwss->set_hblank_min_symbol_width)
+		link_hwss->set_hblank_min_symbol_width(pipe_ctx,
+				&link->cur_link_settings,
 				avg_time_slots_per_mtp);
 
 	return DC_OK;
@@ -3804,13 +3802,13 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
 	struct link_encoder *link_encoder = NULL;
-	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
 	struct hpo_dp_link_encoder *hpo_dp_link_encoder = pipe_ctx->link_res.hpo_dp_link_enc;
-	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	struct fixed31_32 avg_time_slots_per_mtp = dc_fixpt_from_int(0);
 	int i;
 	bool mst_mode = (link->type == dc_connection_mst_branch);
+	const struct dc_link_hwss *link_hwss = dc_link_hwss_get(link, &pipe_ctx->link_res);
+	const struct dc_link_settings empty_link_settings = {0};
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	/* Link encoder may have been dynamically assigned to non-physical display endpoint. */
@@ -3828,22 +3826,11 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	 */
 
 	/* slot X.Y */
-	switch (dp_get_link_encoding_format(&link->cur_link_settings)) {
-	case DP_8b_10b_ENCODING:
-		stream_encoder->funcs->set_throttled_vcp_size(
-			stream_encoder,
-			avg_time_slots_per_mtp);
-		break;
-	case DP_128b_132b_ENCODING:
-		hpo_dp_link_encoder->funcs->set_throttled_vcp_size(
-				hpo_dp_link_encoder,
-				hpo_dp_stream_encoder->inst,
+	link_hwss->set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
+	if (link_hwss->set_hblank_min_symbol_width)
+		link_hwss->set_hblank_min_symbol_width(pipe_ctx,
+				&empty_link_settings,
 				avg_time_slots_per_mtp);
-		break;
-	case DP_UNKNOWN_ENCODING:
-		DC_LOG_ERROR("Failure: unknown encoding format\n");
-		return DC_ERROR_UNEXPECTED;
-	}
 
 	/* TODO: which component is responsible for remove payload table? */
 	if (mst_mode) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index c84822cd7e53..93392c67c909 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -844,4 +844,89 @@ void setup_dp_hpo_stream(struct pipe_ctx *pipe_ctx, bool enable)
 	}
 }
 
+/******************************* dio_link_hwss ********************************/
+static void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
+		struct fixed31_32 throttled_vcp_size)
+{
+	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
+
+	stream_encoder->funcs->set_throttled_vcp_size(
+				stream_encoder,
+				throttled_vcp_size);
+}
+
+/***************************** hpo_dp_link_hwss *******************************/
+static void set_dp_hpo_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
+		struct fixed31_32 throttled_vcp_size)
+{
+	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
+	struct hpo_dp_link_encoder *hpo_dp_link_encoder = pipe_ctx->link_res.hpo_dp_link_enc;
+
+	hpo_dp_link_encoder->funcs->set_throttled_vcp_size(hpo_dp_link_encoder,
+			hpo_dp_stream_encoder->inst,
+			throttled_vcp_size);
+}
+
+static void set_dp_hpo_hblank_min_symbol_width(struct pipe_ctx *pipe_ctx,
+		const struct dc_link_settings *link_settings,
+		struct fixed31_32 throttled_vcp_size)
+{
+	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
+	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
+	struct fixed31_32 h_blank_in_ms, time_slot_in_ms, mtp_cnt_per_h_blank;
+	uint32_t link_bw_in_kbps = dc_link_bandwidth_kbps(pipe_ctx->stream->link, link_settings);
+	uint16_t hblank_min_symbol_width = 0;
+
+	if (link_bw_in_kbps > 0) {
+		h_blank_in_ms = dc_fixpt_div(dc_fixpt_from_int(timing->h_total-timing->h_addressable),
+				dc_fixpt_from_fraction(timing->pix_clk_100hz, 10));
+		time_slot_in_ms = dc_fixpt_from_fraction(32 * 4, link_bw_in_kbps);
+		mtp_cnt_per_h_blank = dc_fixpt_div(h_blank_in_ms, dc_fixpt_mul_int(time_slot_in_ms, 64));
+		hblank_min_symbol_width = dc_fixpt_floor(
+				dc_fixpt_mul(mtp_cnt_per_h_blank, throttled_vcp_size));
+	}
+
+	hpo_dp_stream_encoder->funcs->set_hblank_min_symbol_width(hpo_dp_stream_encoder,
+			hblank_min_symbol_width);
+}
+
+static const struct dc_link_hwss hpo_dp_link_hwss = {
+	.set_throttled_vcp_size = set_dp_hpo_throttled_vcp_size,
+
+	/* function pointers below this point require check for NULL
+	 * *********************************************************************
+	 */
+	.set_hblank_min_symbol_width = set_dp_hpo_hblank_min_symbol_width,
+};
+
+static const struct dc_link_hwss dio_link_hwss = {
+	.set_throttled_vcp_size = set_dio_throttled_vcp_size,
+};
+
+const struct dc_link_hwss *dc_link_hwss_get(const struct dc_link *link,
+		const struct link_resource *link_res)
+{
+	if (link_res->hpo_dp_link_enc)
+		/* TODO: some assumes that if decided link settings is 128b/132b
+		 * channel coding format hpo_dp_link_enc should be used.
+		 * Others believe that if hpo_dp_link_enc is available in link
+		 * resource then hpo_dp_link_enc must be used. This bound between
+		 * hpo_dp_link_enc != NULL and decided link settings is loosely coupled
+		 * with a premise that both hpo_dp_link_enc pointer and decided link
+		 * settings are determined based on single policy function like
+		 * "decide_link_settings" from upper layer. This "convention"
+		 * cannot be maintained and enforced at current level.
+		 * Therefore a refactor is due so we can enforce a strong bound
+		 * between those two parameters at this level.
+		 *
+		 * To put it simple, we want to make enforcement at low level so that
+		 * we will not return link hwss if caller plans to do 8b/10b
+		 * with an hpo encoder. Or we can return a very dummy one that doesn't
+		 * do work for all functions
+		 */
+		return &hpo_dp_link_hwss;
+	else
+		return &dio_link_hwss;
+}
+
 #undef DC_LOGGER
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index d9a3a204cc23..36ec56524afd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -327,6 +327,10 @@ struct hpo_dp_stream_encoder_funcs {
 	void (*read_state)(
 			struct hpo_dp_stream_encoder *enc,
 			struct hpo_dp_stream_encoder_state *state);
+
+	void (*set_hblank_min_symbol_width)(
+			struct hpo_dp_stream_encoder *enc,
+			uint16_t width);
 };
 
 #endif /* STREAM_ENCODER_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index 69d63763a10e..bd3b2b807431 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -72,4 +72,23 @@ void dp_retrain_link_dp_test(struct dc_link *link,
 		struct dc_link_settings *link_setting,
 		bool skip_video_pattern);
 
+struct dc_link;
+struct link_resource;
+struct fixed31_32;
+struct pipe_ctx;
+
+struct dc_link_hwss {
+	void (*set_throttled_vcp_size)(struct pipe_ctx *pipe_ctx,
+			struct fixed31_32 throttled_vcp_size);
+
+	/* function pointers below this point require check for NULL
+	 * *********************************************************************
+	 */
+	void (*set_hblank_min_symbol_width)(struct pipe_ctx *pipe_ctx,
+			const struct dc_link_settings *link_settings,
+			struct fixed31_32 throttled_vcp_size);
+};
+
+const struct dc_link_hwss *dc_link_hwss_get(const struct dc_link *link, const struct link_resource *link_res);
+
 #endif /* __DC_LINK_HWSS_H__ */
-- 
2.25.1

