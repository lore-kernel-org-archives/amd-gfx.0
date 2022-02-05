Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6025CC4332F
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABFB910E417;
	Sat,  5 Feb 2022 01:51:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6591810E417
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFFcFpfRV+3kunFTgyMDoi60ZAklv9AwHF3vIMvZ8LZqRD58sC0BDNys2qcZZunO3ue4Wiw/tvmUe7gXYmsSIt5isK9q94qKDmTupSxn057ayIU+/EWIYmLI+7OpyK+AJ0EY8/SARAYbHbz7wK8djhZNhIoyHNzZZgnGdTfgr+6foZ6JZxISj0bOqms/1VpPMEMONZCVOEbRGqELiDDWnyBJxGzNXzvbslqCZlkt9dgA3yiKlcYEV2+Uor1oqoFDe1GcdEyuXySl6bnz/OB22ErFCkKV58uukVd3XiwmuyVIfpyMtji+iACZ/8yoKYyn5CnaxU5HNoD64Cy+POj55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFBpREIfQrnN7vkKk39TGhQMYZi7R45jQgbGpUQr0z0=;
 b=kRaOzoNumfPV6o+bIU6JiOBRccLsWQm6/+8siH2VGkgCRUajjyBPXP0XyYxlWib6V1lax1UWpC1jXFvhQK908RJS9Q8gH+q+Ix+DiZq8nwQcREzBWTb72631JnKo58wrSvtZ0BJEgU17Xf8Bnd7D4VLimDGCcaDEH7A6+z53tEl0Ljj8mXSolZLkM7E4mY0WVnrZZ56orgJmz2t4eNAJIitIH5x5sdxtS+9WQjJE4uH5N36Jv5P4EySL57uQc9p0Q2T0GXssfaQcx2h4HP/eQik7KzurClZt8ve3yT7t6xTIaYCBZ6Mxz1An9EFL5ZanhSKGqJBEwnI2RottODD0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFBpREIfQrnN7vkKk39TGhQMYZi7R45jQgbGpUQr0z0=;
 b=l8MNckxuRrVbtIFSGe4BvclGI3pCR0M7nfX69JAF2qzpeKwTj8voJAWTZpOVB4mU8kYOZB1wFY8xY/fTKhOI1ZJ++ASK+wLxnmLXwQrAHIs5+UsyohR1wXJbeoUCyxloj9Jur+/kCDtCwnJ8sSj6qQvQqG+2JeajVFxjsbifhko=
Received: from MWHPR1701CA0022.namprd17.prod.outlook.com
 (2603:10b6:301:14::32) by DM5PR12MB2390.namprd12.prod.outlook.com
 (2603:10b6:4:b5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Sat, 5 Feb
 2022 01:51:09 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::e3) by MWHPR1701CA0022.outlook.office365.com
 (2603:10b6:301:14::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 01:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:51:08 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:51:03 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: handle null link encoder
Date: Fri, 4 Feb 2022 20:50:28 -0500
Message-ID: <20220205015029.143768-14-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7764a19-d2cc-4a98-8f0d-08d9e849faba
X-MS-TrafficTypeDiagnostic: DM5PR12MB2390:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2390F224427ABB8FAA3E9DE0FB2A9@DM5PR12MB2390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76xbaMd7jR1iBOHdHNUI7E3+RCkX2uQbw93rkHKEgPaszgMb4oiEjDH+gSWfRChfxFUfhfuq/z+TUrujzQPp0fF9YMkpqhWEQhdhp1QDlLVHdCfSMfWK8XeMlPfuOE9X63fkoKhAA324yg7aWOcsZLlAhWkHgol4FzAg0dmndfdmS8bp6JEH+Rpiu17C0i6OT8NngxEgjaKTwQx1n1Qh/nSl35ebqYSzmMtIc9R0B8in4UxNZZpAfDxxv0ZLNbGn6isHubsXPy0g9us+Hp2pqJ3L54VlV/h2ojbS9oQuU8Lo/PBO6cnI7DQzDg9/oAuvV2+2ifDGCfOORdrCzArs3LmSboFwgmEoOA33ApQyF13wnBsm8RyHFR87r/fyC+VHvwKv3/X4oI05jEyYXbzMhLKaR45fL5G7aMy+Zb/dEvWUHkDHMZ7Arz27gxcqBGmJbPmjSYEwlqk7RSYJr0r6I/FKY/yUvmNqIqI9yywQsZ728qJq4Igk7p5/GF6lxU8bIhcLlEtlSE2IxSLSbEE94o8XbWFzVZMgVfYYH3mk40ieyCr5E4WvjYRMf6S9i9q5wQnAaG+1fqhv8KH00RkCTjnT3eTiCJHGSn3iO/OvtrcekiTyY6AJ+UqnS2sVfO79SmgTaabJiG+M1OZHutORU+rLDbZWyWOImHvxwhwuVJo65veRxgK6fJeoDDkp4mDs4n5fhPyD7x7NDLNnhj80dQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(316002)(508600001)(6916009)(5660300002)(6666004)(83380400001)(2906002)(47076005)(82310400004)(54906003)(40460700003)(8676002)(2616005)(36756003)(70586007)(70206006)(16526019)(1076003)(4326008)(8936002)(26005)(356005)(186003)(81166007)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:51:08.4547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7764a19-d2cc-4a98-8f0d-08d9e849faba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2390
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

