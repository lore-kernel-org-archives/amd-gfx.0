Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDF3ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B036B10EB72;
	Sat, 27 Aug 2022 02:51:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8126E10EB75
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4ldehAYu8GhjJHFcqMqKHAgd/yJUb34VnluwT9Jf/4TREKxwKoHXN+iVLxiGJSejb/GnjnRfAbmEuvmbLDQoPj+7kMQQm+8im7eRzagTKiISYm0AQmNzqoqLSXLmH60FGxlM/gUPU5wFdysuoiC04xu8MOF5itOo5SRMrGiPPrQdvlKTVcvy2JSoF9EBvKAfcSH/CsGYyNFS8lEt1gvlYuFkHkYif2nd7LiONERIhlwv0BlnI1yMJbUMYwJIjNE5rNihl9LBx5uhhUcefM9hIBLeAk3/iOpoZufi28Ktr+eVfmFtyHjJSieBswbdqUKxCo4aFup2AtCW/2VlLrGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcmfARrJWytvoRs4biLEezISQrNtnAYbY/ay84QMEqc=;
 b=DMnv1ddErDyp+IdGDMXWlBrW77OEjUw3LRkcI1CeX2Tz//MTCR136XfQ0tOlO6rsT2I7e6EzfL5UJzoW8Ta4eCMer1OcuzqKC4y2LKDBMLAJB6X3Ejf3C34c4rGDBpKZvvKm18v5lOIqCnKUt5Z1HfECC9SgWLLTg7O0IkNiKwCofRfZXQNxUmFIzyHzXP+x7k9lk5txyMy0+iEcsbJhHGQXwvjg8MZ5q0U6n9SIVm+HK8Bnbqq9c0s7PIXnutnXUeXCL9aiqXR+p/kK0bBKb17ptJj4bBkq2+gpB6dG51i9xd8lOF2eGUo0S0fpq85EhE5bzIDmNlmukeqlmVtOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcmfARrJWytvoRs4biLEezISQrNtnAYbY/ay84QMEqc=;
 b=SPQhUUKuFV2JFflaD/m0FeBd6g3qJemQ93n6lLlKxbIN+k1R9xK4uhjjs8zOevKZ/eALwCAT9K8EWbvm3ORWNTP3bGa58tBSic9s997CT9ecHm3y7hR06i+5qZnopGWxKNq39rbzk7yKrRad8BdswigIz2QiGnYQfs1ZHrt1gMY=
Received: from CY5PR19CA0003.namprd19.prod.outlook.com (2603:10b6:930:15::20)
 by BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 02:51:22 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::e3) by CY5PR19CA0003.outlook.office365.com
 (2603:10b6:930:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:51:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:21 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:51:17
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/33] drm/amd/display: Add visual confirm color support for
 SubVP
Date: Sat, 27 Aug 2022 06:50:35 +0800
Message-ID: <20220826225053.1435588-16-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad4778ff-7174-4cf2-f3e3-08da87d70674
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlkN5UADIDNOdOBU+jk360poHv5jvT0Zv16Xiv40R2wB6iNGodKA4pvrlO4nhdokvzaRopz4jnl4KIUMIvSuoV34pQiSFXfKteoZ37I90FTOuTnDuSzUmf63Z6OeqnKBOqcIk74IeIcxovgLcSiZlzBMWDw2lq3XzG18t4hjK5zeKN/BvrEkyEVAUL+R5nZqmwdxktGy6BsfVuZE07gzd7/cIAkd5F3fCEwNSOYAyctMxFMriCeFqsUfRPv89J/AcdvhCi/j6+IqMb6PuS34SdTwtb790HvbuUDWh/3jGQZOecuUwfBYGFWkyIBYhU4dG/ihMjVejbMf2n5GqDVXe6Z1zDQoDp1C9v7pQS+64opxeia5dV6NKy2ndc5at+C/nkyDgK+MLzR5ZC4Za8P12WOI9bWp0Ng8wXrnWuL5U3WZ0MgI7e94zmItURoz2LPETMsDAlO5zoFNp39ZEf9R2h1j0i8DNTH6qI3FWOUEZJJgxMcNxp5KPuL2Rh68WYU8KmZri+Qo0dIU8WEzCgIGPDSzvZvlKx1no9Q9qwf7QvOfgYGELwHNV1El4T71h/jTeuhSgmGum01XVhsY03a8faQ8YSDNHMSliqPYXoFJ44EoMXvq14HOMZU9MeReLlp5OXK8Sas/Gj8E8kE+LedJ0Osdz2I5geO/nnPqeexVm0cfbdTqNAP64ZbAxeFATPbg9rBa17PtSZXCq45l1FYz6EFQ1yjqDVHcLhXASYCKR38CHSib7MURc2izJpd7nlq19TWqiUAf3yW5DhrGflvtaeaLtNfCDh4znHxwuBVLGTx7h5zyaVaFeAdiMBd6yfhcqkVTLdYYE7LOslAvti7/cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(40470700004)(46966006)(4326008)(41300700001)(81166007)(70206006)(6666004)(70586007)(8936002)(82740400003)(5660300002)(8676002)(426003)(186003)(2616005)(356005)(47076005)(336012)(1076003)(478600001)(26005)(86362001)(7696005)(83380400001)(2906002)(40460700003)(6916009)(36860700001)(40480700001)(316002)(82310400005)(36756003)(54906003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:22.1142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4778ff-7174-4cf2-f3e3-08da87d70674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
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
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why && How]
We would like to have visual confirm color support for SubVP.
	1. Set visual confirm color to red: SubVP is enable on this
	display;
	2. Set visual confirm color to green: SubVP is enable on
	other display and DRR is on this display;
	3. Set visual confirm color to blue: SubVP is enable on
	other display and DRR is off on this display;

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 38 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  5 +++
 4 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 2a8007928210..9dd705b985b9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -402,6 +402,44 @@ void get_hdr_visual_confirm_color(
 	}
 }
 
+void get_subvp_visual_confirm_color(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE;
+	bool enable_subvp = false;
+	int i;
+
+	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx)
+		return;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+	if (pipe->stream && pipe->stream->mall_stream_config.paired_stream &&
+				pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
+			/* SubVP enable - red */
+			color->color_r_cr = color_value;
+			enable_subvp = true;
+
+			if (pipe_ctx->stream == pipe->stream)
+				return;
+			break;
+		}
+	}
+
+	if (enable_subvp && pipe_ctx->stream->mall_stream_config.type == SUBVP_NONE) {
+		color->color_r_cr = 0;
+		if (pipe_ctx->stream->ignore_msa_timing_param == 1)
+			/* SubVP enable and DRR on - green */
+			color->color_g_y = color_value;
+		else
+			/* SubVP enable and No DRR - blue */
+			color->color_b_cb = color_value;
+	}
+}
+
 void get_surface_tile_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index cffb91363b52..eef38d2e4753 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -417,6 +417,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_SWAPCHAIN = 6,
 	VISUAL_CONFIRM_FAMS = 7,
 	VISUAL_CONFIRM_SWIZZLE = 9,
+	VISUAL_CONFIRM_SUBVP = 14,
 };
 
 enum dc_psr_power_opts {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index cf439ed270de..4b4368456477 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2465,6 +2465,8 @@ void dcn20_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx,
 		get_mpctree_visual_confirm_color(pipe_ctx, color);
 	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SWIZZLE)
 		get_surface_tile_visual_confirm_color(pipe_ctx, color);
+	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SUBVP)
+		get_subvp_visual_confirm_color(dc, pipe_ctx, color);
 
 	if (mpc->funcs->set_bg_color)
 		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index a4e02b0ace24..8df493572a9a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -272,6 +272,11 @@ const uint16_t *find_color_matrix(
 void get_surface_visual_confirm_color(
 		const struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
+		
+void get_subvp_visual_confirm_color(
+	struct dc *dc,
+	struct pipe_ctx *pipe_ctx,
+	struct tg_color *color);
 
 void get_hdr_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
-- 
2.25.1

