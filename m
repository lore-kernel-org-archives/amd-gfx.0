Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E7C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F1460FEA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F1460FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D856E949;
	Mon,  7 Jun 2021 16:49:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A866E940
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfmZRsq6gGE6IZW80kt2rLOBX1tA8YyTQUMrX5LaQIRaTE9qeQgbWWbTgeoruTe9FR7gBc5P5XpdzarKNKRaCFdQjrRi2L4RpbCeClhp65P2YxP1Pga9bS+OVJCNxyy7QAWtLGpdNeX+Td5fDWrLtoPB0SJUnaix9K7PVHukrowyaVCGDZE4yiv9kgv8PLUS2aLIKpkbEvxJNNKy0E939Du1/mVy9F2PujOy/lAAjGTwKqBr3TcmrgYlZznof91tqogVyt+yfzHOUeG2vQZuD6cj77iWMbMEZUdL+r9hVk0tjKLYHlMOKQURY8VPlcRLb5M9k7K1vbXfqJPjGR3XNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwI2Kxl+TNXrgoMhRNx8wo0A7VTNldygJMwStfACGjQ=;
 b=lnTlC1wL+vb+2P/zE7SUd8nE6c/vwn9lYhWW/jKhzjf0GjrVlaBAWlLoilYAV6rwyKKB1NBfLQQpQnSDr3seg/RWHUn+xEi4Wh0K9+Hdp5mKge4r7zP7G1PoPNm5jdz+/KCnVjB1DFdnT7QGSd3zvb0VKNgkJc+JNRI8n22DkJgwKuvSr/8HhnpDqkRa+GTLVYvQDRGXLwA6hPCGNBWK41huS9WszQJppnjfb4uskxk6tT17HG3z2vHHSCJmEIAjxSS7xUVvQ1+LhHqUNj5681oMswv9uEcC6ipOztPFYd/1kNhm7BfthsPE7F95WqqWOrDHfVXniGcHA6EldjOUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwI2Kxl+TNXrgoMhRNx8wo0A7VTNldygJMwStfACGjQ=;
 b=A96UHUHezxaIyg5q9DP8UDu7+VtWFHf201kiSOT+9uuzJK6gU2ENt2p9FRJmzbjWvAcCPZEvQzQp+Zk6faxjeWbQrKOERpa07o+I+LhzHC0gEqPUVaRp+SUoIPvh4tDbA45xDMpkMSCvCQuecX39C3aS+gWbx2al88i76k58BPU=
Received: from BN6PR13CA0004.namprd13.prod.outlook.com (2603:10b6:404:10a::14)
 by DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:49:20 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::f7) by BN6PR13CA0004.outlook.office365.com
 (2603:10b6:404:10a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Mon, 7 Jun 2021 16:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:49:20 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:49:16 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/30] drm/amd/display: Add swizzle visual confirm mode
Date: Tue, 8 Jun 2021 00:47:12 +0800
Message-ID: <20210607164714.311325-29-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65cdd8f9-ebae-4c24-5819-08d929d43260
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129AAC52AAE62B20E5D48DAFF389@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TycwUQwZuc3OKB6d8MZVbeh8fUYc3TQfcD4ii0CiPERlEH93CLURerDtfkE3X2P5D2RefmFAAk32Et6nX0J1tm8Vhj6H7x3eXbyXbrGQJTwIF9RwepQ7mHn7fdVZW+iKbzcAjBNjtr5BCtzTC0gQ6ZB58TyWontnP91xJcLgT1LfvGcEaFXBnVvPQobLPbj5XyTKhBn/V9lAdysmA/Rprsp7C3xGJjr8HLYMfV3f7Jd/tmD5D8RitwNur+sAeignw+lh5nQBZP/Nj6Ior3Rxo2hmyIXSYckQ3w7kESKOjpeX2tZL00D9nurudK/vwQFowi/yFFSsJEcaRPfJQOS0qLa0Bt95o/ritN72Hj2H5i6HrKvw4hiCKiIig6PoSRVSxHprA1heQ8DqveadMXUXVnpeNGNm0UvtrBRyozIV5WN/j/Xvn/MxIYEPjH1KMN5sKsUC5U0gjz/Ux+c88bH+ZRkJDyGur4qG9IFjQuEcaxtyJrdVfor0FvhKt97wliyZ5de/UIKtqbNbF2yotvEsP7ANdEDiZyWk8cypCG3nCBFnUXyQdgfflhpRjGlu3JCDS98PVRjyNKxkhWjMFWo6Dcq/zFmXDBJ+0+Yz9XJJKQhcJJBF2/QvmEOrIyjTnfxIDMYxIH4Wo5yogyHfA9OCm0XcuN5rRhfGt7uKSlkxB6mxEerIAkl3zKXbtGDQ2fka
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(136003)(346002)(376002)(46966006)(36840700001)(6916009)(36756003)(70586007)(5660300002)(2906002)(6666004)(86362001)(70206006)(82740400003)(47076005)(81166007)(83380400001)(356005)(7696005)(4326008)(36860700001)(8936002)(316002)(336012)(54906003)(8676002)(44832011)(426003)(2616005)(1076003)(16526019)(26005)(186003)(478600001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:49:20.4187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cdd8f9-ebae-4c24-5819-08d929d43260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Po-Ting Chen <robin.chen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Po-Ting Chen <robin.chen@amd.com>

[Why]
To support a new visual confirm mode: swizzle to show the specific
color at the screen border according to different surface swizzle mode.
Currently we only support the Linear mode with red color.

Signed-off-by: Po-Ting Chen <robin.chen@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 21 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  2 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  2 ++
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 +++-
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index ee3eef5a1f44..15f987a63025 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -403,3 +403,24 @@ void get_hdr_visual_confirm_color(
 		break;
 	}
 }
+
+void get_surface_tile_visual_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE;
+	/* Determine the overscan color based on the top-most (desktop) plane's context */
+	struct pipe_ctx *top_pipe_ctx  = pipe_ctx;
+
+	while (top_pipe_ctx->top_pipe != NULL)
+		top_pipe_ctx = top_pipe_ctx->top_pipe;
+
+	switch (top_pipe_ctx->plane_state->tiling_info.gfx9.swizzle) {
+	case DC_SW_LINEAR:
+		/* LINEAR Surface - set border color to red */
+		color->color_r_cr = color_value;
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 356e15c9df60..b4104b7422d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -318,6 +318,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_HDR = 2,
 	VISUAL_CONFIRM_MPCTREE = 4,
 	VISUAL_CONFIRM_PSR = 5,
+	VISUAL_CONFIRM_SWIZZLE = 9,
 };
 
 enum dcc_option {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index be5287e39dc0..3b175af97388 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2433,6 +2433,8 @@ void dcn10_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx,
 		get_hdr_visual_confirm_color(pipe_ctx, color);
 	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
 		get_surface_visual_confirm_color(pipe_ctx, color);
+	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SWIZZLE)
+		get_surface_tile_visual_confirm_color(pipe_ctx, color);
 	else
 		color_space_to_black_color(
 				dc, pipe_ctx->stream->output_color_space, color);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index a48467d75e3d..477e136ca8de 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2257,6 +2257,8 @@ void dcn20_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx,
 		get_surface_visual_confirm_color(pipe_ctx, color);
 	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_MPCTREE)
 		get_mpctree_visual_confirm_color(pipe_ctx, color);
+	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SWIZZLE)
+		get_surface_tile_visual_confirm_color(pipe_ctx, color);
 
 	if (mpc->funcs->set_bg_color)
 		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 25b3933375c7..420997e0b853 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -263,5 +263,7 @@ void get_hdr_visual_confirm_color(
 void get_mpctree_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
-
+void get_surface_tile_visual_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color);
 #endif /* __DC_HW_SEQUENCER_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
