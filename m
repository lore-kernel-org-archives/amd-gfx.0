Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A21FECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64C510EB7A;
	Sat, 27 Aug 2022 02:51:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A6710EB7A
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYAo5ycvwvhTx+1F1BVio1e74SuAnIDhJ4ypdYhCpiD+KmsyCBgUOgjqqwi18QqNVHjKBVUQr4cDtoFQtJlmr/Nxt9bWpvv69YLOVOQvDqNXDc9sAST7XSqP9agBX34YYS/MAdxLD2TYLnYJz3Xl+Yy2dnaAIC0pW2NZCjX2muFzXc6D3iIQKgncEjKZ2wAIgwhd/OjhUwZisWtQec+2DtECGc+xaOkEGXNl+/bNhsrTO7VA3QNqF2YQPA8yea/fAX/6foqav+d4k45JnRAjIrjPz6+txOXs3xeRlIGNtxSo0tOZQwjuyAPtn52Bg9nAwqW4k2tdaHIippITjrBt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYmwB1aBrJ9NfTMu0TzeJ5aOk9I4gAft7OmXrbXLdBA=;
 b=dHpDlsD48otgZoe5Gx2njMqjI9YMbxelylzL5W/6dTXmmyMWWZvYFKfEHuap6yRJWHbC+xL11rRJoRls8n3Hx+awzebVqFurGj0R/SXws9gt1SHOtLc8QfROj1JFERRVBpIOWEWkV8Khs9XZT4WgeItQA0MgsHXdyYWB2K7UoR2RjUX2lIlwIEk+aqcPP8XjVHYixs6wDbivmlzHNiScJcgWRg8ekOQiODGGp3doKnVAJF5mZ+6MMmyPoe3VImXZp/DpkYlAsRG7emo228VgEtX3Iedj0w7WgPxpMceS1zKEiZv/JBQEdFkmQ7xglBfXzC9i8ZSJPN7DwuABmP+CKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYmwB1aBrJ9NfTMu0TzeJ5aOk9I4gAft7OmXrbXLdBA=;
 b=q42zPeAha0p0FY5i02s03ie+ouxoHGyrKBShwLorBxq4a6+T5BlAUP8wUtG6q9cWck8LtDpmn0V56k60IIaATojJUH4BZI65YahgOHYVR4RzZR8OK0FL53chkj7SYlvvDWPylfK7aDV5VQSK9U4hPADgwbeT3KxveVh1+hQkHhI=
Received: from DS7PR05CA0008.namprd05.prod.outlook.com (2603:10b6:5:3b9::13)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:51:31 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::7c) by DS7PR05CA0008.outlook.office365.com
 (2603:10b6:5:3b9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:51:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:29 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:51:25
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/33] drm/amd/display: SubVP missing scaling case
Date: Sat, 27 Aug 2022 06:50:37 +0800
Message-ID: <20220826225053.1435588-18-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dff44a25-d9a3-457c-fb30-08da87d70bc8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4307:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VoojHVNmRJ6eoHwgxhFxNFcgJKV5WzdI71j0/ZmafRdcqWjlyIdY1aG3Aembt58dgF9zgAhf1RZh6FwqxWkfSztgSg2iCNU2uEEF0jH1e2J/Lk3PYJTZ0GE39l1tNnVoAqeXWFwXFUEG977545oQbWJOhMrYaDXFxs5fBpW3olXehFAWSl3UxALlOCi+LNJCuq5vG2RFn2mOxOtHEeDuCT//ZPq8ieh8Jym/TM4JsGSI20ZMVWet8MZQz/sb3YKwl8RRF1pCCGEqxAA6jlcwb/poStDAFGLhSyW1KWJ6GHxXb8HBqDVma8e7hM1lAurPtn1ELnzQENrtl+eDb7OQBWnbMIvX9NFrNblMsqA47cLWOVIDdttMkcIC1pbNmwhHbZstGfhlZa/ipXy97fAYBqDWFfR2wkCwjsqWoEyn3RtkwwLJHwPqd+AB3WlNF77LA2R7khu3A0cXO5Lv6EtP4jacBBeK7YE2+dGpdEhKF8PoIuPyfCBYzpQGjFG2kd2FLR9jfx0dO3UML0XgRDc/mcltH/Bmf9I1jgPFuqcTtBL4LBrnUVJoDxrrL66VIRILthHV3GZ+UJ71kAAAcY8lNqj4PvzUhJgvRYieyfcIrHcmKoD5K7EHReqoWMnSLbq/ctgQvgOr7wYrp9pL7QNC/a6n7JnWpmbXN5B5jYp/1ISpGcO5kTQRkxXK7qfsay0lsHbHUjBucTi+mw1ezjNBdqgDaPO5PPcaX6TxzSMcIRniFthD1uMAyv6txrjNOQ1rtWGaWs5BNQ++MWs2VtNG2nodZbzq5u/76USSj4pSGC7Jk82YrGtbhTxvC7P3xEPZg+yq3K2+NWyM3FnSZ5dRsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(6666004)(478600001)(41300700001)(47076005)(7696005)(83380400001)(1076003)(426003)(82310400005)(2906002)(26005)(336012)(5660300002)(8936002)(40460700003)(54906003)(186003)(316002)(40480700001)(6916009)(2616005)(4326008)(8676002)(70206006)(70586007)(36756003)(82740400003)(86362001)(81166007)(356005)(36860700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:31.0535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dff44a25-d9a3-457c-fb30-08da87d70bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
For SubVP scaling case we have to combine
the plane scaling and stream scaling.

Use UCLK dummy p-state WM for FCLK WM set C

[Description]
For DCN32/321 program dummy UCLK P-state watermark into FCLK
watermark set C register.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c         | 10 ++++++++--
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c |  6 +++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 61dfe5358d1c..81aba1f51974 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -632,7 +632,7 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 			&cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[cmd_pipe_index];
 	struct dc_crtc_timing *main_timing = &subvp_pipe->stream->timing;
 	struct dc_crtc_timing *phantom_timing = &subvp_pipe->stream->mall_stream_config.paired_stream->timing;
-	uint32_t out_num, out_den;
+	uint32_t out_num_stream, out_den_stream, out_num_plane, out_den_plane, out_num, out_den;
 
 	pipe_data->mode = SUBVP;
 	pipe_data->pipe_config.subvp_data.pix_clk_100hz = subvp_pipe->stream->timing.pix_clk_100hz;
@@ -649,8 +649,14 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 	/* Calculate the scaling factor from the src and dst height.
 	 * e.g. If 3840x2160 being downscaled to 1920x1080, the scaling factor is 1/2.
 	 * Reduce the fraction 1080/2160 = 1/2 for the "scaling factor"
+	 *
+	 * Make sure to combine stream and plane scaling together.
 	 */
-	reduce_fraction(subvp_pipe->stream->src.height, subvp_pipe->stream->dst.height, &out_num, &out_den);
+	reduce_fraction(subvp_pipe->stream->src.height, subvp_pipe->stream->dst.height,
+			&out_num_stream, &out_den_stream);
+	reduce_fraction(subvp_pipe->plane_state->src_rect.height, subvp_pipe->plane_state->dst_rect.height,
+			&out_num_plane, &out_den_plane);
+	reduce_fraction(out_num_stream * out_num_plane, out_den_stream * out_den_plane, &out_num, &out_den);
 	pipe_data->pipe_config.subvp_data.scale_factor_numerator = out_num;
 	pipe_data->pipe_config.subvp_data.scale_factor_denominator = out_den;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index e72213a20e75..23a661f541a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1796,7 +1796,11 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.c.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.fclk_pstate_change_ns = get_fclk_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	/* On DCN32/321, PMFW will set PSTATE_CHANGE_TYPE = 1 (FCLK) for UCLK dummy p-state.
+	 * In this case we must program FCLK WM Set C to use the UCLK dummy p-state WM
+	 * value.
+	 */
+	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.fclk_pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.c.usr_retraining_ns = get_usr_retraining_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 
 	if ((!pstate_en) && (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid)) {
-- 
2.25.1

