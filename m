Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1055C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F75410E2DA;
	Wed, 16 Aug 2023 06:08:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7552810E2DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0eOs5cN17DqZ3tZSI8GEf24mdFwBO4SgLnAftE+6KyPKpk5JOohfJuQNBBL8DxCpL7s3zPaIiRypVjiw+27ij8J8pkxREhZcMf+4grCcoXyyMBmqOD5A2gDv1ck0mWFR7OlL5CPYb9M+VL5euOUl+GMwdcZtG9H8ZKJ/0MQhdaxncTggmdXFl/XLverIJC6GOQ82Ron6dZoJkcWdWoXsmHqAr1rGtER9dwapX0LmPTCWMJbXj8WCp8j2GNB/XbuFh3sq2OYHklVWwgDmc3NiMu3PyxN27uBeEd9O54Sp7B4rTw5j3UTpfu6Efv/xPG09AflSiWTXPKDmBTSFRIwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmrDsTL1LBtUthToDggbkgvonLr+wUgjwTFUub6N1Zk=;
 b=Z+XgPSmXk5k5G49P1vmImDyVWisYvj5K+TgEmm1w9czw2ZAfvqHhc/W0qpI7ZF7iy6hfuogUlm6Chiqh2jo9Aer7wBBsITqeJ7dxyCnReYoFZl6jc8Jud6its+V0Lhs7Do9DV6N4K/WZ2sWVqyllx4+oN+XatgIqdYI8jvBXVu0ZonGI06cX1EfTRu0yHkFkJfvAd1WoXebfqehcxz0FsiktL6BAkT8hYaxP7G+YfWjwNGJy1dsGCwo1bt9oWPI95JtgIUXUe1hJbg42CeDF9xRY91cOQ2kECrFcE5csls10UfUcNdVEgQdxBoyXgEnh/u/+pALt5W4WWufuHDIfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmrDsTL1LBtUthToDggbkgvonLr+wUgjwTFUub6N1Zk=;
 b=UuTej6gBDCb1hILdIHwF1cYMsKoiiQy8+7y1Vg6sUaMpy4nQlwCy8xvJksfv6LFyfl9vn6FJM8c/4dswq0jIRxxxJr7R4Y456tivH+0NFLoatgGng6373or7ItZhNnEx5jpG3wf9qQVeYaMqp/eaimb9/RoFsxVMeo+6UMWOsjI=
Received: from MW4PR04CA0307.namprd04.prod.outlook.com (2603:10b6:303:82::12)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 06:08:24 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::72) by MW4PR04CA0307.outlook.office365.com
 (2603:10b6:303:82::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 06:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 06:08:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:08:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 23:08:21 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:08:16 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Correct unit conversion for vstartup
Date: Wed, 16 Aug 2023 14:06:50 +0800
Message-ID: <20230816060658.2141009-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|BN9PR12MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 74083d92-e98d-4ecf-7925-08db9e1f32a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4y0kC+vHSggO2VjhFCKpvZ4paVDUy4g+ZnZ87Wwln9hWbw4prTHCz1LhpFmzV4bGs85jrjhl00YpbcDP2xQsPNYuvBZVyacRDowOLXRaDPl6+Z9aNJW6mEYJb343K6BK3i5RknCZtqqQcTwbjsC9VU1nz/pUrTwuNicREgLK6syRHsVHuhej9XhNzkGEwbsKZ6AA1ccvrrhGl0vyUb74qT+wW7svyqD/PuGpTqdDTtC2K0AJ49WPy2+F3xbh2Eo24hdCTQFNRM4lQdaYIpVPm8Fx3KJ0ll+dypu4hQj9ndPEtqN/EYp0d82SDnzaJ0+OMIfYgCBG+XAOj/8eUUkeffFsvMjW/WK1M6pUZ1c5StUibC2M+V+dyMMyDt1e21GsJqOKKtj9qMAG2RgA9q1qR8xr9im/4kHFFNODu/ENkRWXn3/5ktm2bxxyNcHhRPKGbBKh+UDDx8iJz4LmxE5r6lvkxBaxprMYha3nuCNhiYHuzhQuexzJNh30aSyng2+QTHMJq0bkRt9oZUBsfcPT93GbG5lxnla1hyb6GyAbSEu1huBhloLu39kj6Rf4pNd9I8IbmesoXOwfKfm3Vcto247EQd+t651zcqcNMCTCV+bTBhheBvow2rB9YLbkjxqXyeRx1IwTnI2R+Cv5XUgYUMQzRNlLwE0S9bfxYnQyj2GQOSLrSs/F+N311N6x+kcdNpjCxvRCwRkOjW8uIrwMRSAcN+toJCvguEvPFc0YHS82mnYvwM9YGmhHlbXGOLH5JS4zICkNgpsUOvE5cbZtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:08:23.2218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74083d92-e98d-4ecf-7925-08db9e1f32a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
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
Cc: stylon.wang@amd.com, Reza Amini <reza.amini@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Reza Amini <reza.amini@amd.com>

[why]
vstartup is calculated to be a large number. it works because
it is within vertical blank, but it reduces region of blank that
can be used for power gating.

[how]
Calculation needs to convert micro seconds to number of
vertical lines.

Reviewed-by: Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Reza Amini <reza.amini@amd.com>
---
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index ed8ddb75b333..07adb614366e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -31,6 +31,7 @@
 #include "dml/dcn20/dcn20_fpu.h"
 #include "dml/dcn31/dcn31_fpu.h"
 #include "dml/display_mode_vba.h"
+#include "dml/dml_inline_defs.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
 	.VBlankNomDefaultUS = 668,
@@ -273,6 +274,25 @@ static bool is_dual_plane(enum surface_pixel_format format)
 	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
 }
 
+/*
+ * micro_sec_to_vert_lines () - converts time to number of vertical lines for a given timing
+ *
+ * @param: num_us: number of microseconds
+ * @return: number of vertical lines. If exact number of vertical lines is not found then
+ *          it will round up to next number of lines to guarantee num_us
+ */
+static unsigned int micro_sec_to_vert_lines(unsigned int num_us, struct dc_crtc_timing *timing)
+{
+	unsigned int num_lines = 0;
+	unsigned int lines_time_in_ns = 1000.0 *
+			(((float)timing->h_total * 1000.0) /
+			 ((float)timing->pix_clk_100hz / 10.0));
+
+	num_lines = dml_ceil(1000.0 * num_us / lines_time_in_ns, 1.0);
+
+	return num_lines;
+}
+
 int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *context,
 					       display_e2e_pipe_params_st *pipes,
 					       bool fast_validate)
@@ -289,19 +309,22 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 		struct dc_crtc_timing *timing;
+		unsigned int num_lines = 0;
 
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
+		num_lines = micro_sec_to_vert_lines(dcn3_14_ip.VBlankNomDefaultUS, timing);
+
 		if (pipe->stream->adjust.v_total_min != 0)
 			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
 		else
 			pipes[pipe_cnt].pipe.dest.vtotal = timing->v_total;
 
 		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
-		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, dcn3_14_ip.VBlankNomDefaultUS);
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, num_lines);
 		pipes[pipe_cnt].pipe.dest.vblank_nom = max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width);
 		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, max_allowed_vblank_nom);
 
-- 
2.37.3

