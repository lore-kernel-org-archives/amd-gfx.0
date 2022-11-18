Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39548C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0AFE10E792;
	Fri, 18 Nov 2022 17:02:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5724410E792
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJXzsMna6nr8PFeWwnwS6SvMYE3Ce1ZafwiyqDhB43TrRxWUYAqA0FSNF3/ZfyfQpGX/kKsCME7QfA7Hg2B46j/Hw7WTFChQYx2iJOc7lPko2iXfYXmwW4ntaIt6WV1pasnLOJe/+uQwJn6vDbuRgVfHPICUGdrf6zk7BM1wBeqf+FXyA0RQBY6sJShLO9FGnJs3qB6lFgxdKLo8dLqLCLmHVIb7JzGub7snKtQLMJ/2cKP3WGPryUx6iNRhCmqJL6weosyd3Jeo/6GURjTbUXVoGMADaR9ppvjI+f5GNjDT336O+bY4wyEoI0bjIDXTbuHQHQt+KXqnqMW+c+naXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aY3CDL/AawljBtipuufBI4/RzARgBS+JENOEjjaCGLY=;
 b=YfHlLVdEyjeuZ/CPdh4frNnP6w10yFAql+Jhd3qkNnPR97U4TjiuUpj9w7+Vg8D6GYdFQyAQMDVnwP38VLmzX+OzkBAxh0iNv33kTRrS/vbhe+7me4IaiQNBxb0HitrTbxfng45SvaDi4jsa9obCbtdnrRgXj1dITkGd2IOJ5w2TXFpdDsvTSxqwC1Zyi9MjSG4l5CIu4cTOU05LRe85DS19xQQw/OTZMtQxVXAQh+FIShO7ImI5bZbTI6qjkyIemlukIff4ICwv62J/R2nXMAixfB3bcfsopl1bLBs1QRJeS4Yi929sORmO3yfwkQOJ6lSGbN5lOYCuJ6zvFylNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY3CDL/AawljBtipuufBI4/RzARgBS+JENOEjjaCGLY=;
 b=ah3kosK+6RqnwP3bK+/9sMATDGaTuzfyAqCPtns1uqzBEMKU5uJcCvAX0LXfu+k0BkmuGi2905fwNe6RaqIum43sCcgInJCqYbxk4aMZxcvrd4+ye9/EY1y+O/EhpklrCzxmwixlKwvxMqdK9L3q0Xgxbuz+Z4YETJenTtBQIME=
Received: from DS7PR03CA0237.namprd03.prod.outlook.com (2603:10b6:5:3ba::32)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 17:01:56 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::f0) by DS7PR03CA0237.outlook.office365.com
 (2603:10b6:5:3ba::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 17:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:01:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:01:20 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:01:16
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/22] drm/amd/display: Avoid setting pixel rate divider to N/A
Date: Fri, 18 Nov 2022 20:59:31 +0800
Message-ID: <20221118125935.4013669-19-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 722f6b7a-1f6e-4fde-621f-08dac98699ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRw7Far0Y01VbN5qND96MvPQ2Px2FyQNhnEDeXlYGrajomhPXF5LIGsIibwIeqPiAwo3siyDyrrY7mZ3AAsnx2kjDDjwJQUbsltN7xv2JPhVVi/eDXMooYWP3O07c3UqMCyvl5r2XMQFftTi+7+Ficf/p+RG6Fq2Ux7RyEiidVFsSfmgyfKI3OpuT41yKlCvSGmvEs6+I6fxG86KGBNezVAZGBfn9F6WKjPajXdPvaWnbYW6rkIXyVk7MotLpKRfdEtqIa/NpmRZ0Zno3xeFaaIbuc90X+HV+yN/XhQYkZ8y1bNHROOvVzaR9XT/LrNAsoCDLY9O/05dI6JhxMvf8o/nHNlnzWE2sr693RFwD+Hu6hRE8PGIWX4An7BOvLYCfHOei1hzVdra0rDYs0/qkTWY4wxOKxPXGRgwFVVv/Ngd/lgIDi2lnPhOhsdD2OXcNZGCwNlnJWBioZ7tisKqe/xS8yJ2U9s75YSlOXqsXQiIld/dXhCIW5h+uegopJ0m0Nww9+sgxSRsN0eYbyrNNgfc75j0u/e7kYAAGvbltjQ8sxr4p8IYpkfsyLR7N5WmZmxgli4sB2UWqtEBx/Nvxj27lsvtCjiDTIho3yqylr8S2PIwSLtnNLgKBD44qSBx4jAx48T5gWm88mGmVimfDD8u1FdPN60NjVgQD8ddN9AUtS0d/y0Cp+Dd3qJ4G5HmFgkO6MM+l39ZEfS9am00QjKGR7ZC2suBHzTBJDfbuTMzznEr+cep1gzvq9MGh1aH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(81166007)(82740400003)(356005)(478600001)(40480700001)(82310400005)(86362001)(83380400001)(36860700001)(2906002)(5660300002)(426003)(2616005)(47076005)(40460700003)(26005)(4326008)(6666004)(7696005)(8936002)(186003)(70206006)(1076003)(70586007)(54906003)(6916009)(336012)(8676002)(316002)(41300700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:01:56.6511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 722f6b7a-1f6e-4fde-621f-08dac98699ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why]
Pixel rate divider values should never be set to N/A (0xF) as the K1/K2
field is only 1/2 bits wide.

[How]
Set valid divider values for virtual and FRL/DP2 cases.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c  | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c | 6 ++----
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c    | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c   | 4 +---
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 367cb6e6d074..0b769ee71405 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -96,6 +96,13 @@ static void dccg314_set_pixel_rate_div(
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
 
+	// Don't program 0xF into the register field. Not valid since
+	// K1 / K2 field is only 1 / 2 bits wide
+	if (k1 == PIXEL_RATE_DIV_NA || k2 == PIXEL_RATE_DIV_NA) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
 	dccg314_get_pixel_rate_div(dccg, otg_inst, &cur_k1, &cur_k2);
 	if (k1 == cur_k1 && k2 == cur_k2)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 588c1c71241f..a0741794db62 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -348,10 +348,8 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
-	if (pipe_ctx->stream->signal == SIGNAL_TYPE_VIRTUAL)
-		return odm_combine_factor;
-
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		*k1_div = PIXEL_RATE_DIV_BY_1;
 		*k2_div = PIXEL_RATE_DIV_BY_1;
 	} else if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) || dc_is_dvi_signal(pipe_ctx->stream->signal)) {
 		*k1_div = PIXEL_RATE_DIV_BY_1;
@@ -359,7 +357,7 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 			*k2_div = PIXEL_RATE_DIV_BY_2;
 		else
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal) || dc_is_virtual_signal(pipe_ctx->stream->signal)) {
 		if (two_pix_per_container) {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_2;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index e4daed44ef5f..df4f25119142 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -96,8 +96,10 @@ static void dccg32_set_pixel_rate_div(
 
 	// Don't program 0xF into the register field. Not valid since
 	// K1 / K2 field is only 1 / 2 bits wide
-	if (k1 == PIXEL_RATE_DIV_NA || k2 == PIXEL_RATE_DIV_NA)
+	if (k1 == PIXEL_RATE_DIV_NA || k2 == PIXEL_RATE_DIV_NA) {
+		BREAK_TO_DEBUGGER();
 		return;
+	}
 
 	dccg32_get_pixel_rate_div(dccg, otg_inst, &cur_k1, &cur_k2);
 	if (k1 == cur_k1 && k2 == cur_k2)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 61f129faf251..2f19f711d8be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1175,10 +1175,8 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
-	if (pipe_ctx->stream->signal == SIGNAL_TYPE_VIRTUAL)
-		return odm_combine_factor;
-
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		*k1_div = PIXEL_RATE_DIV_BY_1;
 		*k2_div = PIXEL_RATE_DIV_BY_1;
 	} else if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) || dc_is_dvi_signal(pipe_ctx->stream->signal)) {
 		*k1_div = PIXEL_RATE_DIV_BY_1;
-- 
2.25.1

