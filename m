Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E972C7EE30
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11AF410E525;
	Wed, 10 May 2023 20:49:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E89010E526
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wvdh7ZtDMXcpBvcbb5qoa9ECy1rF7AJ3YHt4Zx3CllamYZolUGFjcwfE8jozgKwR+Rq6bJks65EkIXYe/HcwN76+fZ4yGz/Xq729kI3yfHPatrUWxrms3W/YA8h2/VLUeN4G6+9GutbpUOM0/u5UgPEpSbtUJGrjy+Xb4SVPvnpjDhPreVISnYpVEXiHenXVPDj2XnXeFZ17sWHg1iOIMOXg2BnkK5xV2bJ8q/uuSPjHe8dz06Ffag+ggYQ9/zUP1ZXc7jr5z+kmVPa/b1Fz0w1gRBtL18vk116mfwwqq8oGiSWCbHvO/EujfAPXiszM0cW4JKe6PG6fgixDbrqyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6eAJvFi+GsPOO00oFJS595wpSryVlDxe33IJQvYGqA=;
 b=HAUUTwZgl+5W1WJ3zFogm44ssQduR+eFLeVKs+L1Mgut76t2hEii9JMI85K5xYb1VsASg3equ0erNmtdvCiClISPgC/uBYvbUeGmJcMA7eiBMVaPDVESa/aQFrsakEk80yAa8OK1fnnVNrASjGE4hQ1UB3UvLAykfzai/SM3AUWKWxsetP1n6u8ah3Q+lyGJqZYA77ZXlUDR3qaaXn7X3UTaIzMekREst4T5c6DCf/jOlx235rliF/YsjaigsITOqbJHF7vAMiSbuP3lVNlxqBlRtAgs+6i5fO97kk5KH1x/KjEaMWPlPswmH1hqz404K0dt9V8DilJE+zo74dpWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6eAJvFi+GsPOO00oFJS595wpSryVlDxe33IJQvYGqA=;
 b=wCw7V2RHI6SV0kVO7miwlPtP/bqOczUCmzGsCSQMy36LZp9a4VAxVFttpOHs3klon0I2SFWtAx3BKCUVP9VlNBPYcQ47lVu7oAVix17eK74wTt2zSTyhvLcGVHdJgteaRRxA6kkBLEb0YRMcNB0I+8W935T2fJBtpmxghzhPygg=
Received: from SJ0PR13CA0211.namprd13.prod.outlook.com (2603:10b6:a03:2c1::6)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 20:49:23 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c1:cafe::78) by SJ0PR13CA0211.outlook.office365.com
 (2603:10b6:a03:2c1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 20:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 20:49:22 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 13:49:21 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 May 2023 15:49:20 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/10] drm/amd/display: Remove v_startup workaround for dcn3+
Date: Wed, 10 May 2023 16:48:59 -0400
Message-ID: <20230510204900.949963-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510204900.949963-1-aurabindo.pillai@amd.com>
References: <20230510204900.949963-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: af594a5e-8851-4ca9-fe81-08db51980885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t00Kc7mLfg5vVnqnt2qWBpW6hxYG3A1hQJohdBjjiumsarecuensbKekHMEEbn/PAtgwrINQWgcMotKiq7nhtls4gAArd9mrPcz2lv+6c8NPC21i/Jb1jBKHrwmC5y/7DI3QXF0odwZ78UJX2X4/uxHCMNasmxDizyxcQMWASEmsf3PoRpspKbWQdVRVvP0FQIZ9qFnnv0sVSlh/FPQyRkHAtazdSvIzs7DPqZxzBX3HGci5Xoy/gYcs/4fNp2+QmNPPy6N0j3NZkZmz5/hd9RDxrJk+JCMTXJp2DzPdg281mLAZnx/+qJgw4uSAQJPMKMbYb742L5Z9DfF2zkBJZ5/6D+80BYSZ07t8pDy7+ZpL0YsEmWbZsuIHnpDCdwA6SudYnHbcfX1gZxjXwhsPg7WX7feKI9ospwaQmcM0s3iyRQacb30VbECrgF4UFnL02Fu/pfUwcivxoZweGAYZJGZ2mMB5CKlaJjtM3f4gmpLv3xOweRjyfRx9PYbndszfpp3K3IksCV2lEgpkEYRblv8Bj/hul93CEMMRGgNq7ccPGxLTtcfG6u77my77Kv2RgCBj+B3Eie17lGeSk8S509u7j94sczNFtWSxV6Ryti2kCMaAMaVuqh0aDuBfIQ/dFXrbdROcyk1c3DNGxMy3SefSQzSl9OaU1cNiMBs1gvkafg2OMHGhyub3Vsjj4pxqEYUWHmrNCx12RrlHyjF0+88JkF5BfjQyxQ2gpbT/Uqc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(54906003)(8676002)(8936002)(41300700001)(316002)(478600001)(44832011)(2906002)(6666004)(70206006)(4326008)(6916009)(70586007)(5660300002)(40480700001)(47076005)(7696005)(1076003)(26005)(186003)(82740400003)(83380400001)(40460700003)(36860700001)(2616005)(336012)(36756003)(426003)(82310400005)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:49:22.1216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af594a5e-8851-4ca9-fe81-08db51980885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why]
Calls to dcn20_adjust_freesync_v_startup are no longer
needed as of dcn3+ and can cause underflow in some cases

[How]
Move calls to dcn20_adjust_freesync_v_startup up into
validate_bandwidth for dcn2.x

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 3407f9a2c6a1..8ae5ddbd1b27 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1099,10 +1099,6 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz =
 						pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
-		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
-			dcn20_adjust_freesync_v_startup(
-				&context->res_ctx.pipe_ctx[i].stream->timing,
-				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
 
 		pipe_idx++;
 	}
@@ -1931,6 +1927,7 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
+	int i = 0;
 	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
@@ -1954,6 +1951,15 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	dcn20_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel, fast_validate);
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
+			dcn20_adjust_freesync_v_startup(
+				&context->res_ctx.pipe_ctx[i].stream->timing,
+				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
+	}
+
 	BW_VAL_TRACE_END_WATERMARKS();
 
 	goto validate_out;
@@ -2226,6 +2232,7 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc,
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
+	int i = 0;
 	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
@@ -2254,6 +2261,15 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc,
 	dcn21_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel, fast_validate);
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
+			dcn20_adjust_freesync_v_startup(
+				&context->res_ctx.pipe_ctx[i].stream->timing,
+				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
+	}
+
 	BW_VAL_TRACE_END_WATERMARKS();
 
 	goto validate_out;
-- 
2.40.0

