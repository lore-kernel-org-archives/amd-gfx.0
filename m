Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6988C56202
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763F32224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="my8EMu/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763F32224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3686EDC0;
	Wed, 21 Oct 2020 14:23:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9286EDBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwsLd6XkkcpHmXeh6TKOca1l3Cla+M2WZ9Z+HQakM+WNGktwaHKaAUG9TsC7utJRUsgsquKhLexb+R714vxWgvvuUPBRXUspPreKJv7gkP8Km3EXOLK4/PoLY+5OLCyAqiF5fK4TkoKZtOVONblANkWfpO3r5eeAq1AofTi1ykXRLeZQHfDXnr83CcYMB/NlAiTM7sPatl/06IJDgZEHTIDaivlATNTkxnycBqDfwqcX5fJ1utRc+OkIc30qXW7RF/2ShB72a3jkPqXma5vooNYGJWvuIQRp7L2XQBxD8aNMIV1fPTaiCthy3TehciUksYs05g369MB1G6PM6PRIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT/aDjmD1coCHB55UbRtZ6cZ3298pNvJa+dMuGR5kJ0=;
 b=nM1voigObubW2jcvWicsO3CnAg2F0L+Ae9fHJAA6mrbEKkGUTizp+5qjXKPfAtZ32OYx5gF1mDtQg7l3U5SCJYurCApbgHJ0PcEUnBmTHyXQME3qNZwO9xL2MCwztWf5fr/P5OMCBYkG2c77/xYJ9qknOJNJ8FUyk75UAgSHn1bh6jcayqD52Dr6S04x1dvBS+rJNvmzJFR45wlAiaZbaXCBrh54ZXlP+0P0SxCqRJUTKPyz/bpgXE+WVJ4S0aHjnG7PO0FuJNH+QLXfDm066dF/41MD4oMoJ0tDL1M4VyPME17Pn4fSYHuCVWmYmdti6fYy6Z8dnnsMEuDpT5hhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT/aDjmD1coCHB55UbRtZ6cZ3298pNvJa+dMuGR5kJ0=;
 b=my8EMu/gWppiBh18zEB1ZTFaOp6ImdSnmnLlbxy591/IjDXmdVxtmFmvhkQOXRuX9OjMPhZaaVFEcsYTLuDoujBpQH0/lhbaL+sJRbBaToMMHhnlJ90qr1tp+k1Qa8L6TpfMvxajuL5fYlgNED8/Cfi7jrXBh04pF2DaSw9z05g=
Received: from DM5PR15CA0038.namprd15.prod.outlook.com (2603:10b6:4:4b::24) by
 BYAPR12MB2933.namprd12.prod.outlook.com (2603:10b6:a03:138::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Wed, 21 Oct
 2020 14:23:10 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::47) by DM5PR15CA0038.outlook.office365.com
 (2603:10b6:4:4b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:10 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:09 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:08 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/33] drm/amd/display: Raise DPG height during timing
 synchronization
Date: Wed, 21 Oct 2020 10:22:31 -0400
Message-ID: <20201021142257.190969-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ea9e403-d829-4552-762d-08d875ccd660
X-MS-TrafficTypeDiagnostic: BYAPR12MB2933:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2933DB6421EB2AA65B3674278B1C0@BYAPR12MB2933.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9XR3LcrcYahSZHLZJ3r0Z6LXrs+QI5/uTpxS8B3VkW4p7jX68ivX9aIcNc9ocumtmkncTxmwT2xN4mcF8ohPRKXnIdjcpeoxAUsYC6n8AoZLRLqVe6+vmIreRgKzZYGcYYj/y2YafkaEsqF1Jup4gMnH298j51DrvaPmCekHx+a66g0BFJCgmKXUuPiEeJQnhp76x/ljpRNaeBCXQSGr1h6au3lIoZw1RTKBFAMPqogx5zEHAOXwiCi0FkWTLo7VJnq3jQHzbodo3jtIIqFBSAow83mq8fmdexUOVIXpiOohE+U2hlek6Q4laeOTG+qejIXIx9XOpAd1iapCgc5ViNEvHtSTbi0GMc7ji+fS5pPJp56CDnvNVbXNVtiUVxsxhG3hSJObLJD/2QwMa0HGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966005)(186003)(336012)(356005)(6916009)(6666004)(4326008)(2616005)(36756003)(478600001)(83380400001)(44832011)(426003)(26005)(86362001)(5660300002)(1076003)(82740400003)(81166007)(2906002)(54906003)(316002)(82310400003)(8936002)(47076004)(70206006)(8676002)(70586007)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:10.2349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea9e403-d829-4552-762d-08d875ccd660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2933
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Taimur Hassan <syed.hassan@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why]
Underflow counter increases in AGM when performing some mode switches due
to timing sync, which is a known hardware issue.

[How]
Temporarily raise DPG height during timing sync so that underflow is not
reported.

Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 20 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.c  | 12 +++++++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.h  |  4 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  5 +++++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 9528e3a46b28..6b141c9f521f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1847,10 +1847,20 @@ void dcn10_enable_timing_synchronization(
 	struct pipe_ctx *grouped_pipes[])
 {
 	struct dc_context *dc_ctx = dc->ctx;
-	int i;
+	struct output_pixel_processor *opp;
+	struct timing_generator *tg;
+	int i, width, height;
 
 	DC_SYNC_INFO("Setting up OTG reset trigger\n");
 
+	for (i = 1; i < group_size; i++) {
+		opp = grouped_pipes[i]->stream_res.opp;
+		tg = grouped_pipes[i]->stream_res.tg;
+		tg->funcs->get_otg_active_size(tg, &width, &height);
+		if (opp->funcs->opp_program_dpg_dimensions)
+			opp->funcs->opp_program_dpg_dimensions(opp, width, 2*(height) + 1);
+	}
+
 	for (i = 1; i < group_size; i++)
 		grouped_pipes[i]->stream_res.tg->funcs->enable_reset_trigger(
 				grouped_pipes[i]->stream_res.tg,
@@ -1867,6 +1877,14 @@ void dcn10_enable_timing_synchronization(
 		grouped_pipes[i]->stream_res.tg->funcs->disable_reset_trigger(
 				grouped_pipes[i]->stream_res.tg);
 
+	for (i = 1; i < group_size; i++) {
+		opp = grouped_pipes[i]->stream_res.opp;
+		tg = grouped_pipes[i]->stream_res.tg;
+		tg->funcs->get_otg_active_size(tg, &width, &height);
+		if (opp->funcs->opp_program_dpg_dimensions)
+			opp->funcs->opp_program_dpg_dimensions(opp, width, height);
+	}
+
 	DC_SYNC_INFO("Sync complete\n");
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
index d79718fde5a6..d54d731415d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
@@ -403,6 +403,7 @@ static const struct opp_funcs dcn10_opp_funcs = {
 		.opp_program_stereo = opp1_program_stereo,
 		.opp_pipe_clock_control = opp1_pipe_clock_control,
 		.opp_set_disp_pattern_generator = NULL,
+		.opp_program_dpg_dimensions = NULL,
 		.dpg_is_blanked = NULL,
 		.opp_destroy = opp1_destroy
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
index 138321e151eb..0784d0198661 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
@@ -290,6 +290,17 @@ void opp2_set_disp_pattern_generator(
 	}
 }
 
+void opp2_program_dpg_dimensions(
+		struct output_pixel_processor *opp,
+		int width, int height)
+{
+	struct dcn20_opp *oppn20 = TO_DCN20_OPP(opp);
+
+	REG_SET_2(DPG_DIMENSIONS, 0,
+		DPG_ACTIVE_WIDTH, width,
+		DPG_ACTIVE_HEIGHT, height);
+}
+
 void opp2_dpg_set_blank_color(
 		struct output_pixel_processor *opp,
 		const struct tg_color *color)
@@ -350,6 +361,7 @@ static struct opp_funcs dcn20_opp_funcs = {
 		.opp_program_stereo = opp1_program_stereo,
 		.opp_pipe_clock_control = opp1_pipe_clock_control,
 		.opp_set_disp_pattern_generator = opp2_set_disp_pattern_generator,
+		.opp_program_dpg_dimensions = opp2_program_dpg_dimensions,
 		.dpg_is_blanked = opp2_dpg_is_blanked,
 		.opp_dpg_set_blank_color = opp2_dpg_set_blank_color,
 		.opp_destroy = opp1_destroy,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
index 64c5b429c79a..3ab221bdd27d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
@@ -153,6 +153,10 @@ void opp2_set_disp_pattern_generator(
 	int height,
 	int offset);
 
+void opp2_program_dpg_dimensions(
+		struct output_pixel_processor *opp,
+		int width, int height);
+
 bool opp2_dpg_is_blanked(struct output_pixel_processor *opp);
 
 void opp2_dpg_set_blank_color(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
index 2717352eb697..7617fabbd16e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
@@ -313,6 +313,11 @@ struct opp_funcs {
 			int height,
 			int offset);
 
+	void (*opp_program_dpg_dimensions)(
+				struct output_pixel_processor *opp,
+				int width,
+				int height);
+
 	bool (*dpg_is_blanked)(
 			struct output_pixel_processor *opp);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
