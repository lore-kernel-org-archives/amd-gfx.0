Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3787BC433FE
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB76E10EF29;
	Sat,  5 Feb 2022 04:33:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F8FC10ED91
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFRKlz5bc+gMi8cnL2NkKqLl4NPWb3q62rZTTqd2kMeXpnvC0aQIBsV429zm+q+QBjhOzPnJHpTgX3DEkzYblr8t3GifTezrTu78JTbFI1T7rMw2X63VI2CUcPyyAH8fxO86V1pU5RY7pjRgVT6fSDVeQ97WzFAcg7tBNve2O0Xw2MN67jwlwhVvczg4Q1/Zv1+E0zwi88t7ZkS4OFqKvt3MkdV/lweKUf7d00XjyPYqwEsbKuXg3cG5YGLy+aWQ1UQ/VCDJFIJ59zPOAFN8Ir7u5kxXQCSLoDI/OwzGAgBegcgzmeHLIchySWVthSbM3xsYxEAgu1EPlCwYd00iCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFBpREIfQrnN7vkKk39TGhQMYZi7R45jQgbGpUQr0z0=;
 b=GCiITcub54PicrH6YiE1fqSFxEVt0zoK1QSGcfB3DklNgrwFMoj1BFxMAZkTPY9B56glaenzvx09leLQonXvVJwyVz1j/5quxwJaNnUfpZPC1Na6Fm7wfsKbWuIiJ2Caj9xw+l3wqikav6S6g9WPgvFSX21O/bVJqjnDRdkH2bZS/U7eFlIRnn0EGCDrmCqjOTl77KEW+FPEQhIu/OugG1OyLNLpH9kbDHE1KhPsBAK/PoLz47+JshO+ZBAo++uOIWEXCnAV7z8R/f1+SZYIApOmlevHJOSVF8NmwYw0zTRVNzNHaOYCljsWxy2m4Sgxf3D3rQCIZc0+MimEP/ckBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFBpREIfQrnN7vkKk39TGhQMYZi7R45jQgbGpUQr0z0=;
 b=fXYy51owmb0/ECXvzv1VgD1fyg69qjFzcJ9gJJbjo/21rYjJIH3dkmZ8ktxvkXcB9Ld3S92QidY+bUTcCZwLmukth2sUnrtQzrxz74e09Bk3LfCMcsPLxqvNw7sJUkeBIiRcfuuZKkWIVMSp4q89LZbGh1DzHKmUq8IjwgVFp9k=
Received: from MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37) by
 PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 04:33:40 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::90) by MW2PR16CA0024.outlook.office365.com
 (2603:10b6:907::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 04:33:39 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:36 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amd/display: handle null link encoder
Date: Fri, 4 Feb 2022 23:33:09 -0500
Message-ID: <20220205043310.165991-13-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85fb257d-e272-45f3-3a1e-08d9e860aecf
X-MS-TrafficTypeDiagnostic: PH0PR12MB5608:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5608B400A6516282D7867DAAFB2A9@PH0PR12MB5608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wouJ0FI+FwjVx1lZtjbwOXijJyHG55fgBv9VeI25T3yey5984atdjLDO2iPBWH6KNbK9fQCjQ2aB0MKPKnUNxDvAOWz/mYSLxc6bUIuL+2hzfTss+Yh5Bi5U4q5ffbABqKR0TrdiEvg/B31DK5I5HJR8S1sf/JSPyH5sxBxMwl9V9XMfMlWi0t6X1ia+9RDEQ3jL8pob+4EVwVKbJ9caQaXrXKJz2MgHsuV9fU+n2b7NVLcaFwVASiizeClEwoaBdBQa4Q3EUVaLNmnkS732nVsu8ljmP3iWI6ZXV/BRIOY1FV29UBQ+72cGh0GRbl92TZ8m86Ta6y6p8h1hgjS4rnvqs/9mS1iC4rNoTOMXPkBr5hwFf8DkQWD4IPWCqXXEPL8tfRTKEEZDhjP1cVGQts4D2Gt07HCkEKf/6U18rgP5WFXqDmrvhPsIt432fouHGXZb/I3/kGrh5oNUYRDlnBi2XG4++b5cRF8r4KCN8K5vNjWsHjw+njtzi/y78rLIYCTf6bkkQK3SddVjYjvtOwvVM7o4OzpGP8lQcf31pz+YamEufC+h5uJXioMvWEMZ91LiUhq4sBJSiytlTrmuOropaUbDSvxX8tvnOozTSxTqkltUdiLpyFLthJKeRkaCe589fdyLr9Fzp8NZGRUie9yEcWVbF87UwqATNjFuV6TuXSTVu1M40UKGru2UEhu31UMPyIr+sLzcFd+8mFLKMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(5660300002)(508600001)(54906003)(8676002)(83380400001)(4326008)(36860700001)(6916009)(2616005)(40460700003)(26005)(47076005)(186003)(81166007)(2906002)(82310400004)(426003)(8936002)(36756003)(336012)(70206006)(356005)(1076003)(70586007)(16526019)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:39.5081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fb257d-e272-45f3-3a1e-08d9e860aecf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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
Cc: stylon.wang@amd.com, Martin Tsai <martin.tsai@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[Why]
The link encoder mapping could return a null one and causes system crash.

[How]
Let the mapping can get an available link encoder without endpoint
identification check.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 25 +++----------------
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 11 +-------
 2 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ec4b300ec067..b1718600fa02 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3530,11 +3530,7 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	DC_LOGGER_INIT(link->ctx->logger);
 
-	/* Link encoder may have been dynamically assigned to non-physical display endpoint. */
-	if (link->ep_type == DISPLAY_ENDPOINT_PHY)
-		link_encoder = link->link_enc;
-	else if (link->dc->res_pool->funcs->link_encs_assign)
-		link_encoder = link_enc_cfg_get_link_enc_used_by_stream(pipe_ctx->stream->ctx->dc, stream);
+	link_encoder = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_encoder);
 
 	/* enable_link_dp_mst already check link->enabled_stream_count
@@ -3823,11 +3819,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	const struct dc_link_settings empty_link_settings = {0};
 	DC_LOGGER_INIT(link->ctx->logger);
 
-	/* Link encoder may have been dynamically assigned to non-physical display endpoint. */
-	if (link->ep_type == DISPLAY_ENDPOINT_PHY)
-		link_encoder = link->link_enc;
-	else if (link->dc->res_pool->funcs->link_encs_assign)
-		link_encoder = link_enc_cfg_get_link_enc_used_by_stream(pipe_ctx->stream->ctx->dc, stream);
+	link_encoder = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_encoder);
 
 	/* deallocate_mst_payload is called before disable link. When mode or
@@ -3944,13 +3936,7 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 	if (cp_psp == NULL || cp_psp->funcs.update_stream_config == NULL)
 		return;
 
-	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY)
-		link_enc = pipe_ctx->stream->link->link_enc;
-	else if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
-			pipe_ctx->stream->link->dc->res_pool->funcs->link_encs_assign)
-		link_enc = link_enc_cfg_get_link_enc_used_by_stream(
-				pipe_ctx->stream->ctx->dc,
-				pipe_ctx->stream);
+	link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
 	ASSERT(link_enc);
 	if (link_enc == NULL)
 		return;
@@ -4100,10 +4086,7 @@ void core_link_enable_stream(
 			dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
 
-	if (dc->res_pool->funcs->link_encs_assign && stream->link->ep_type != DISPLAY_ENDPOINT_PHY)
-		link_enc = link_enc_cfg_get_link_enc_used_by_stream(dc, stream);
-	else
-		link_enc = stream->link->link_enc;
+	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	if (!dc_is_virtual_signal(pipe_ctx->stream->signal)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index fcf388b509db..b55868a0e0df 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1605,16 +1605,7 @@ static void get_pixel_clock_parameters(
 
 	pixel_clk_params->requested_pix_clk_100hz = stream->timing.pix_clk_100hz;
 
-	/* Links supporting dynamically assigned link encoder will be assigned next
-	 * available encoder if one not already assigned.
-	 */
-	if (link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign) {
-		link_enc = link_enc_cfg_get_link_enc_used_by_stream(stream->ctx->dc, stream);
-		if (link_enc == NULL)
-			link_enc = link_enc_cfg_get_next_avail_link_enc(stream->ctx->dc);
-	} else
-		link_enc = stream->link->link_enc;
+	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	if (link_enc)
-- 
2.25.1

