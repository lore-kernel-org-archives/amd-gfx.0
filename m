Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD75AC3A5A9
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC582072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cx84Ngyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC582072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689136E126;
	Sat,  2 May 2020 21:34:54 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700089.outbound.protection.outlook.com [40.107.70.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554C86E124
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyD2zKO7mhnuxrYN2zzWKPkjyHOzE5xma82zR5ftZwDjrbdxLDLj1IL5qVgSDcspUHLtTf2FLxbecQWSda0mKXJmojYz/z9tyr+4XK1rNhSvWIl2DUxUEzSBn4xgL3tXWqyy6lv4WOxsvHSpJKWOwhz71T0Yc1GKkejrMR9gdU803PYSbLKEgbA3sW1QRe3aY2fNUvVmR+GDvmIJ9zgJCUeURVik1wMwAK9o1JyvSSNhEkXBLx1W8juZL/BeXrT72uxff7ExNUBwVpcN/mvIIKDHBSs01sfiEnqB+mqHgwZSCl+uSYHRQYDrealf3/vG79/XsSqvjP9T79AHTgXaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lEMQM+ZiB5zRd+5s1JJGNMD8y/Ho5b9dZCl6SEVGws=;
 b=l9qViMzguwy4Elk5FmGKfns74Yspr0ABBHmWds2xvhLik/A8I7bW4uALu33zgK3KYt0O4gVUh6Q1C4sqDGY2Y2fDLZjHthvXB+bguia2W1eelx9eH0BQE64VdVWJLx2E9LebLDeKxwvsFhFB8GdIuZieB5Nt6M9Q9t12UxNjaAzHTYIjUkuSr4RK3ZAIcm5YG0uICJStqRJIO7N9mZbrctkcU7NnipCcGzeNFomLRl7sv+5/gw+V10i7gCGFb0AD7JN1bXJMMHNZys4wq7jpWh0WiaK+NAnD7CoI+dlcHhVv/UTMQAyL/we5jpaRAhRjPbG30rJ2pcKsfsEwjXCahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lEMQM+ZiB5zRd+5s1JJGNMD8y/Ho5b9dZCl6SEVGws=;
 b=Cx84NgyqjtzhxFXNlO2hawXwLiOts5W5P51Kv5wE5drc+eUmD4Txc1ticAo3M2G48WbRnML2Lb4kI6TkjR/S4mVz9+x3e043BPhd1qdtqhnTUXsufxnWnK9YmWJn8IJcZGokH1MZGTdtFTpYcVRmXC+lcmEEOfDSAlgK+Yj+MTI=
Received: from MWHPR22CA0060.namprd22.prod.outlook.com (2603:10b6:300:12a::22)
 by BN6PR12MB1604.namprd12.prod.outlook.com (2603:10b6:405:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Sat, 2 May
 2020 21:34:50 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::25) by MWHPR22CA0060.outlook.office365.com
 (2603:10b6:300:12a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29 via Frontend
 Transport; Sat, 2 May 2020 21:34:50 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:49 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:48 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:47 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: Mode change with same timing causing
 long display blank
Date: Sat, 2 May 2020 17:34:30 -0400
Message-ID: <20200502213443.39232-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966005)(82740400003)(70206006)(316002)(54906003)(47076004)(6916009)(4326008)(44832011)(336012)(8936002)(426003)(8676002)(2616005)(478600001)(186003)(82310400002)(356005)(86362001)(1076003)(2906002)(26005)(36756003)(7696005)(70586007)(81166007)(6666004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e74e9ea-01cf-484a-b9cd-08d7eee0a4c2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1604:
X-Microsoft-Antispam-PRVS: <BN6PR12MB160485B297CFEA8F2077AF658BA80@BN6PR12MB1604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6yrPMv0By5a/eQP/G5TD+zAUNiMppcxT2CZhJnDalCWdAH4I8dn4m18zKmGEx0wWYNULB1GDDE3P9JGMAw8Jfwd/G8+vHC+yCuTeYhcl2ZT8hALQ0FrMLsm8p+0H4OTr2nrQPcpjDAT4X28XBiWobAHRUpng9I6SMRGCITu+ia/bVoqMam1ALY1a+rh8uBGrID+Jo5ArGK4vUIAbVU0VDN7/7FB4lDqN5H73a43BnJOVmFxr5Ce5/mkJOtvgzVjNCZ2RXzjnSrLr2srDpSVvHQchfK+/XptJzbCUe6TdI/kE+wZbo8/OyAD6jkKx68ib5+G9NcaVo3/Dan3u1oJXrq609j9XNnmm2rL9JGXf+LzbO+9sV5xrsiQ6HkdsBYQdotnc8fWVKf9WNx4uXuKrTI9a/njff+5QCZisgEeCHvkPJKGClI99VWsl769dsWtRCpBLDi94q2Oh8mATWS0ZbjRW9KCGpmKcFPS6gJRe5pWk6y9VVtmA6YeN5/Ob8pDjYRi3L54yu6djfJM2mQqeA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:49.8825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e74e9ea-01cf-484a-b9cd-08d7eee0a4c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1604
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
Cc: Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
What a mode change is requested for the same timing a full stream reset
can occur in some cases which causes monitor to blank for a few seconds.

[How]
Do not consider infoframe updates as needing a full stream reset as they
will be handled on the first flip after a modeset when surface
information is available.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 67 -------------------
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 18 -----
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 18 -----
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 -
 4 files changed, 106 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1a01c038632b..cb5d11f11cad 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1547,35 +1547,6 @@ bool dc_add_all_planes_for_stream(
 	return add_all_planes_for_stream(dc, stream, &set, 1, context);
 }
 
-
-static bool is_hdr_static_meta_changed(struct dc_stream_state *cur_stream,
-	struct dc_stream_state *new_stream)
-{
-	if (cur_stream == NULL)
-		return true;
-
-	if (memcmp(&cur_stream->hdr_static_metadata,
-			&new_stream->hdr_static_metadata,
-			sizeof(struct dc_info_packet)) != 0)
-		return true;
-
-	return false;
-}
-
-static bool is_vsc_info_packet_changed(struct dc_stream_state *cur_stream,
-		struct dc_stream_state *new_stream)
-{
-	if (cur_stream == NULL)
-		return true;
-
-	if (memcmp(&cur_stream->vsc_infopacket,
-			&new_stream->vsc_infopacket,
-			sizeof(struct dc_info_packet)) != 0)
-		return true;
-
-	return false;
-}
-
 static bool is_timing_changed(struct dc_stream_state *cur_stream,
 		struct dc_stream_state *new_stream)
 {
@@ -1610,15 +1581,9 @@ static bool are_stream_backends_same(
 	if (is_timing_changed(stream_a, stream_b))
 		return false;
 
-	if (is_hdr_static_meta_changed(stream_a, stream_b))
-		return false;
-
 	if (stream_a->dpms_off != stream_b->dpms_off)
 		return false;
 
-	if (is_vsc_info_packet_changed(stream_a, stream_b))
-		return false;
-
 	return true;
 }
 
@@ -1758,21 +1723,6 @@ static struct audio *find_first_free_audio(
 	return 0;
 }
 
-bool resource_is_stream_unchanged(
-	struct dc_state *old_context, struct dc_stream_state *stream)
-{
-	int i;
-
-	for (i = 0; i < old_context->stream_count; i++) {
-		struct dc_stream_state *old_stream = old_context->streams[i];
-
-		if (are_stream_backends_same(old_stream, stream))
-				return true;
-	}
-
-	return false;
-}
-
 /**
  * dc_add_stream_to_ctx() - Add a new dc_stream_state to a dc_state.
  */
@@ -2027,17 +1977,6 @@ enum dc_status resource_map_pool_resources(
 	int pipe_idx = -1;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 
-	/* TODO Check if this is needed */
-	/*if (!resource_is_stream_unchanged(old_context, stream)) {
-			if (stream != NULL && old_context->streams[i] != NULL) {
-				stream->bit_depth_params =
-						old_context->streams[i]->bit_depth_params;
-				stream->clamping = old_context->streams[i]->clamping;
-				continue;
-			}
-		}
-	*/
-
 	calculate_phy_pix_clks(stream);
 
 	/* TODO: Check Linux */
@@ -2720,15 +2659,9 @@ bool pipe_need_reprogram(
 	if (is_timing_changed(pipe_ctx_old->stream, pipe_ctx->stream))
 		return true;
 
-	if (is_hdr_static_meta_changed(pipe_ctx_old->stream, pipe_ctx->stream))
-		return true;
-
 	if (pipe_ctx_old->stream->dpms_off != pipe_ctx->stream->dpms_off)
 		return true;
 
-	if (is_vsc_info_packet_changed(pipe_ctx_old->stream, pipe_ctx->stream))
-		return true;
-
 	if (false == pipe_ctx_old->stream->link->link_state_valid &&
 		false == pipe_ctx_old->stream->dpms_off)
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index bacf865f55c0..17d5cb422025 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1121,24 +1121,6 @@ static enum dc_status build_mapped_resource(
 {
 	struct pipe_ctx *pipe_ctx = resource_get_head_pipe_for_stream(&context->res_ctx, stream);
 
-	/*TODO Seems unneeded anymore */
-	/*	if (old_context && resource_is_stream_unchanged(old_context, stream)) {
-			if (stream != NULL && old_context->streams[i] != NULL) {
-				 todo: shouldn't have to copy missing parameter here
-				resource_build_bit_depth_reduction_params(stream,
-						&stream->bit_depth_params);
-				stream->clamping.pixel_encoding =
-						stream->timing.pixel_encoding;
-
-				resource_build_bit_depth_reduction_params(stream,
-								&stream->bit_depth_params);
-				build_clamping_params(stream);
-
-				continue;
-			}
-		}
-	*/
-
 	if (!pipe_ctx)
 		return DC_ERROR_UNEXPECTED;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 60ea499c1ca8..1a525c423911 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1653,24 +1653,6 @@ enum dc_status dcn20_build_mapped_resource(const struct dc *dc, struct dc_state
 	enum dc_status status = DC_OK;
 	struct pipe_ctx *pipe_ctx = resource_get_head_pipe_for_stream(&context->res_ctx, stream);
 
-	/*TODO Seems unneeded anymore */
-	/*	if (old_context && resource_is_stream_unchanged(old_context, stream)) {
-			if (stream != NULL && old_context->streams[i] != NULL) {
-				 todo: shouldn't have to copy missing parameter here
-				resource_build_bit_depth_reduction_params(stream,
-						&stream->bit_depth_params);
-				stream->clamping.pixel_encoding =
-						stream->timing.pixel_encoding;
-
-				resource_build_bit_depth_reduction_params(stream,
-								&stream->bit_depth_params);
-				build_clamping_params(stream);
-
-				continue;
-			}
-		}
-	*/
-
 	if (!pipe_ctx)
 		return DC_ERROR_UNEXPECTED;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index ca4c36c0c9bc..109c589eb97c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -138,9 +138,6 @@ struct pipe_ctx *find_idle_secondary_pipe(
 		const struct resource_pool *pool,
 		const struct pipe_ctx *primary_pipe);
 
-bool resource_is_stream_unchanged(
-	struct dc_state *old_context, struct dc_stream_state *stream);
-
 bool resource_validate_attach_surfaces(
 		const struct dc_validation_set set[],
 		int set_count,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
