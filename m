Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C32BC001DE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AEC10E4E4;
	Wed, 19 Jul 2023 18:35:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18E510E4E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPFigfwjxEnUDxULvc+jivOwa5U7e2RuZyqh7rNKtqlehHsLZOiJv+cWPdvOP3RUC4PfTOAp8+KqRM+j6IUehIhd4rdH1grAZYni2BFmYwzojIK5ILyC1peHThnXKcpLxVf8BuMXUkxzX6HngdcZvjdJ9pb1zfRTSOGYjdmtYyuDe2pxXQHOUu97dvuq+WaA5/2ZhgO+XqANdhZfWDBP7g5/DpG8PMqelhKiMUAbBD3G8CuADLugzq/URgHe8zkYKcyq9bXS9hbhuyN2KnTiCLBJl8hgLSqOTcfLqqRdQVN5+NTf8OFBZ0hrz1bsslJIn4Coc6C0dJWObvliNTYC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NLwpr4NzQgYJU9gKJlu9XvsR42MxCRHWbmpKaDQ+J0=;
 b=DB9NuNQ9DIpXbqVv41sXI64rnjm3L8UdnSwpFsc40LminUnhKs0P66rZ6AFNLo1ag8Lthkc2pb5xDR3eBW5vAjncAdjgN+XbSrQk1NJ+RVllHVbnXi+bC5xLOkWcDIhmSAXRjw+W4DjHx78JWsbpmOGpjix0wUFMRmXi7ogwRHIZHv90LU3wLq3qCiNhDOBLu1f/Np3dR+h5FdMYDYPbYFazw7LzmQ/ccl71AdP22g3AnC3SmWYtT0mAgX8+6ywVHZsxfGKm7qI9FASpp8ZQfT4hGk4+mlTKFtNdSf3cfIH1avfppYCPHKik+cLrmKNTPwu5MHu2oec96ol2VfaM+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NLwpr4NzQgYJU9gKJlu9XvsR42MxCRHWbmpKaDQ+J0=;
 b=nb6pbJkM5AR/kXtsa0CWMxQ4j4JgpiT5/e/VzlEgdl1nzhk1rSMlcx4MaIUV2idXnj9f4KTa4hQ6nkHiqGbZUVyyfHbdkz+ibbg4Kb/LnFortMLxfkXNcfaf8qYg0pdRfB0N64dPZSITcrpYHGLyFsmCgZVKrfk1G2QEkMzkJCc=
Received: from BN9PR03CA0774.namprd03.prod.outlook.com (2603:10b6:408:13a::29)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 18:34:56 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::18) by BN9PR03CA0774.outlook.office365.com
 (2603:10b6:408:13a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 18:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:34:56 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:34:53 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: Correct unit conversion for vstartup
Date: Wed, 19 Jul 2023 12:27:59 -0600
Message-ID: <20230719183211.153690-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: cb52b227-d1e5-4e63-2408-08db8886d9ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOK9ZIXFfb9m9KapMxK6t7U+5fgCnjm8ibrAEmaRk+NuSpcbfMjiAiYNAaKld6pZSv3VTWDw5/3MNNx+WtL2vKCBqxrjfExkmN2j+rihB6xG/cdx+mphluwmFQ8yqUopLi2En93n866Uhal7GsIm46tr3QM6RYuiy0KcVUkmHGneyHt81RXmS1/kZCVUA/CbevelonZ/sp+3JQExh01hfJ8TF5YiLGI0GAMO03zxXlQ1fSL8LuJxom27Ymw6MTbRIv2syTELIjiJuNsQgDfn7jHyEzSwjHOF8CNO8F15n7geltzYnL0P8gpbJkx88nuacwefkFyFBqJOqNeeZsBUM7sx8ODMSwgfOe053GlFmMN1i7+fs4oLNQrszKnryMzokWuUhrSuDx8pCu2CIYiVNlj6u6DuB+vBoJazjFvcu5XVzRNrspxDkRa9+iiEizFNspWey1R4PQcPuZUF2I/oW2sxA44Cl9ubxT9DisyqdaeY7/mhc0PAwQDtDS7Z0W/1xKe0zdwfTxqebGkz/eCw1l6wMZFexem2UM+HlKzQTM7ImBE3i3vaYYDetoKoEkHenwIzsGpNJKhu3PELJi/D6DXl8AWefNEft9VvMno/WFkDCT4gqChbLLWmkiBYSHHsi52Tc9+t23CLn4AsDZl41TlH8CX1QNyRq9gNrwTdyFL47WHaEO+yvPA2jJtBeBOZu6x728/ODfJsT1sRnFkqJnTRtkKRvvGjHfcOjq2btuv5jLhGtpJ3Fz45l5EuOYQ2Zlzcg+wFNyxKJx7wj2xpmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(54906003)(478600001)(82740400003)(2906002)(356005)(81166007)(86362001)(7696005)(70206006)(70586007)(6916009)(4326008)(47076005)(36860700001)(316002)(426003)(83380400001)(36756003)(186003)(1076003)(336012)(26005)(2616005)(40460700003)(8676002)(8936002)(41300700001)(16526019)(5660300002)(40480700001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:34:56.1455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb52b227-d1e5-4e63-2408-08db8886d9ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
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
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Reza Amini <reza.amini@amd.com>

[Why]
vstartup is calculated to be a large number. It works because
it is within vertical blank, but it reduces region of blank that
can be used for power gating.

[How]
Calculation needs to convert micro seconds to number of
vertical lines.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
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
2.41.0

