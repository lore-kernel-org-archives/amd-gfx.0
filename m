Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9F9C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A6610E8A2;
	Fri,  1 Dec 2023 13:28:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C24310E893
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbvJs9uJXX4fZX/oTCtCaXKzEgKyTIpUh+9IETAF4i7FthFCURrDeBboDoupudn86lhY1ssfeGlNXLe8L7Nfnz+Atb1s73n8UZdxELIKDBbgmOCX2A7Zma+INlPObNmYmobO4GJAVg33JYigPxvLyZntOlY+TjOJWrkbJON1KHt8vx+Is7u19AaJ0OfttuWH929yiMgMhJyakBm6/Swoxj6EGbma184SuBjxXxY4H6SBOnbYC43B4zCsnoiZ7rCy2WVaItOcgReDVTluM1+fwkg0wdc6VMYfC3heMo1+t0pfJJBGXCT52oDBlQOYoggaNPvyu/2LFyZgJbRifn9/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu7V4Kr0UGl/DYviHBelS17TnIE5BsMYxp19x9e8TDc=;
 b=hrlelb6Q2Mei6e2i9K5vi2YTKCshP2smKMNSFHeedHfFv/HxjsxK1mDPF2471YVLaOi5u9HTYcvujHpJKCQoCNv9TeW2MbxBbDmrfrm48Cc0iwDNi6iIt4D/qdwocZIaLsooz1ykR+zi/pmtuoe+4nKkHrzBlKSoDeDl/CRE0QeDQW2Xe5vEIlO1Poqh0KagMCfvbyb77aQwYavr3ZxjKJrWVyQzdug+8uHtD1Qw5eSRs+vwx1A10ZuSODVYFrkY6mDdSBBEg855mMrAaJDiKh+qaSF3E3Gjwz4Fgz7QD80TXi3ggQqYarmgAa6eoW/x7NtoesZs0o3lW+on3MRPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu7V4Kr0UGl/DYviHBelS17TnIE5BsMYxp19x9e8TDc=;
 b=5fr0DVs3tzO1dSPNaDwP2gC5TVbIPWKAPvB8g3q5X01NLmze1NWZkbHTOWoAC9teXOX98lfyKMiBN9ScfgTqLi7HcUcpXY4Ta4AqvzxJ6tKAyh24C2OGVvrDgYb4jixwK8DDMNRxy35GywbAGSTRvhfDUalS0YjkngIeKPycsr4=
Received: from DM6PR02CA0037.namprd02.prod.outlook.com (2603:10b6:5:177::14)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.27; Fri, 1 Dec 2023 13:28:46 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::65) by DM6PR02CA0037.outlook.office365.com
 (2603:10b6:5:177::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:46 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:43 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/47] drm/amd/display: add support for DTO genarated dscclk
Date: Fri, 1 Dec 2023 06:25:20 -0700
Message-ID: <20231201132731.2354141-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a9abc0-0692-4d83-d6af-08dbf2717225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvjjwePxEbIWmQx4AZQLpyF7jgG0Sya+7irKCzlOzGsmpq0bBT1bXdR/R13W+GUCgWQ0OocwB8BnTEW1J7LcxGwRUEN2K/HFkTBin3/rj5+AXosRerVcAq0aUtx7zqDSRNKdx+ot+fYB/29FE+u6ml7FN/rAzeXNpUXAD9qfupf9K4aSXxI05cRFz59jjAzTiv3Jgf/Ml6rywE5QvjFNmaWP+cr6sxsvY+QBQ0Mv3V+fHpCnIgXbKItl+HbfFII9w/0bZuMVulKkZ8T9Wn+1MKWzapAYQhChECI1E17M9GbLWQMAxh2ul9Fah3nKhx/eCwVTEqXfXBiAbttEIHH741OQ9gMKe8HZA0a6Zsa1HtoQTjvGkgtqnz/4y2k6FG2vhm3TcBqnRaUAvq5pTuidB0K657jQ8sCxlpglZDi8+CD3BT+cFO4vm5N0NMZR0ePGZzlI54iYdCeotWGsKasYySpUZQW5oTWjcy4t68Q+0ZS4dpbRKOHkZmdkw7h5DERrqcq0V1yWWwQH0S8FwiStVBDBZwG1lovyxqLCNumStflWCRytzGQwyHmIUIeJAo+exawmfgrRDVdDpW0oF32TcGfMJqsM8zPQDWee6OouTfsyPerYxQDbBo8vOlxlI4joAU7/hcQw8lQFI8eZbahcGif2+Q6L/SzE/2BJlDdfoZvhd3M/ELnn6DVJxdKfHtwqF9Cl6Wt1fzYoVw//m5UrEuQBD9W0Hb/OavjajN5u/hCGZa4rlymyuGmhwv7hXkO8TRUNw4jLlN+KpxYON16mWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(2616005)(426003)(336012)(8936002)(8676002)(86362001)(36860700001)(81166007)(47076005)(356005)(83380400001)(82740400003)(4326008)(16526019)(26005)(40480700001)(1076003)(40460700003)(478600001)(6666004)(70206006)(54906003)(6916009)(316002)(70586007)(2906002)(36756003)(41300700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:46.2584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a9abc0-0692-4d83-d6af-08dbf2717225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Current implementation will choose to use refclk as dscclk. This is not
recommended by hardware team as refclk is a fixed value which could
cause unnecessary power consumption or it could be not enough for large
DSC timings. So we are adding new interfaces so we could switch to use
dynamically generated DSCCLK by DTO. So DSCCLK is programmable based on
current pixel clock and dispclk.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 25 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  4 +++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 27 ++++++++++++++++++-
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 5f7f474ef51c..5c323718ec90 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -989,9 +989,22 @@ static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
 static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
+	struct dccg *dccg = dc->res_pool->dccg;
+	/* It has been found that when DSCCLK is lower than 16Mhz, we will get DCN
+	 * register access hung. When DSCCLk is based on refclk, DSCCLk is always a
+	 * fixed value higher than 16Mhz so the issue doesn't occur. When DSCCLK is
+	 * generated by DTO, DSCCLK would be based on 1/3 dispclk. For small timings
+	 * with DSC such as 480p60Hz, the dispclk could be low enough to trigger
+	 * this problem. We are implementing a workaround here to keep using dscclk
+	 * based on fixed value refclk when timing is smaller than 3x16Mhz (i.e
+	 * 48Mhz) pixel clock to avoid hitting this problem.
+	 */
+	bool should_use_dto_dscclk = (dccg->funcs->set_dto_dscclk != NULL) &&
+			stream->timing.pix_clk_100hz > 480000;
 
 	ASSERT(dsc);
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
@@ -1014,12 +1027,16 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
+		if (should_use_dto_dscclk)
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
 			ASSERT(odm_dsc);
 			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
+			if (should_use_dto_dscclk)
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst);
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
 		dsc_cfg.pic_width *= opp_cnt;
@@ -1039,9 +1056,13 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 				OPTC_DSC_DISABLED, 0, 0);
 
 		/* disable DSC block */
+		if (dccg->funcs->set_ref_dscclk)
+			dccg->funcs->set_ref_dscclk(dccg, pipe_ctx->stream_res.dsc->inst);
 		dsc->funcs->dsc_disable(pipe_ctx->stream_res.dsc);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			ASSERT(odm_pipe->stream_res.dsc);
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, odm_pipe->stream_res.dsc->inst);
 			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
 		}
 	}
@@ -1124,6 +1145,10 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		if (!pipe_ctx->next_odm_pipe && current_pipe_ctx->next_odm_pipe &&
 				current_pipe_ctx->next_odm_pipe->stream_res.dsc) {
 			struct display_stream_compressor *dsc = current_pipe_ctx->next_odm_pipe->stream_res.dsc;
+			struct dccg *dccg = dc->res_pool->dccg;
+
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, dsc->inst);
 			/* disconnect DSC block from stream */
 			dsc->funcs->dsc_disconnect(dsc);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index ce2f0c0e82bd..6b44557fcb1a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -201,6 +201,10 @@ struct dccg_funcs {
 			struct dccg *dccg,
 			enum streamclk_source src,
 			uint32_t otg_inst);
+	void (*set_dto_dscclk)(
+			struct dccg *dccg,
+			uint32_t dsc_inst);
+	void (*set_ref_dscclk)(struct dccg *dccg, uint32_t dsc_inst);
 };
 
 #endif //__DAL_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index b16b2e14312e..5fe8b4871c77 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -776,10 +776,26 @@ static bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
  */
 void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
+	/* TODO: Move this to HWSS as this is hardware programming sequence not a
+	 * link layer sequence
+	 */
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
+	struct dccg *dccg = dc->res_pool->dccg;
+	/* It has been found that when DSCCLK is lower than 16Mhz, we will get DCN
+	 * register access hung. When DSCCLk is based on refclk, DSCCLk is always a
+	 * fixed value higher than 16Mhz so the issue doesn't occur. When DSCCLK is
+	 * generated by DTO, DSCCLK would be based on 1/3 dispclk. For small timings
+	 * with DSC such as 480p60Hz, the dispclk could be low enough to trigger
+	 * this problem. We are implementing a workaround here to keep using dscclk
+	 * based on fixed value refclk when timing is smaller than 3x16Mhz (i.e
+	 * 48Mhz) pixel clock to avoid hitting this problem.
+	 */
+	bool should_use_dto_dscclk = (dccg->funcs->set_dto_dscclk != NULL) &&
+			stream->timing.pix_clk_100hz > 480000;
 	DC_LOGGER_INIT(dsc->ctx->logger);
 
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
@@ -802,11 +818,15 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
+		if (should_use_dto_dscclk)
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
 			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
+			if (should_use_dto_dscclk)
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst);
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
 		dsc_cfg.pic_width *= opp_cnt;
@@ -856,9 +876,14 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		}
 
 		/* disable DSC block */
+		if (dccg->funcs->set_ref_dscclk)
+			dccg->funcs->set_ref_dscclk(dccg, pipe_ctx->stream_res.dsc->inst);
 		pipe_ctx->stream_res.dsc->funcs->dsc_disable(pipe_ctx->stream_res.dsc);
-		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, odm_pipe->stream_res.dsc->inst);
 			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
+		}
 	}
 }
 
-- 
2.42.0

