Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB450C4363D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75EAA20789
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jJ08Ubwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EAA20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5DC6E8E4;
	Wed,  7 Oct 2020 12:42:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D246E8E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 12:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPssxGW/nP9/Oln3Z44bxyeMYZ8HgDokzJrAlCreQ8ce4N2FRpgPiI7e+d2Z7GllauOfqzZp4blm4QtH5TO+4mEsOoLbOcawDIKi31FtJgjfZxHKhGJCvbzm+ymfMn1zgoJKj3q3JsqJwQj9Ps5vD1j3ZhLsqrBpx4WcJdrP3wzV+NxPrKmPHco6UHlH//x0UaEbXRM9gXdVYA1DEummplEmsU5/nYnq7O8D7zeLofGs+DZ6C001Ry2uPqBKf/zMInDaElha8PBLlaD5SX3DwgZEsbSEWhJi+Nb5nuhT4GtAteTd6HJasqrnwh3cCmMYMYVmcNb5WLXFh1gZnPtI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT/aDjmD1coCHB55UbRtZ6cZ3298pNvJa+dMuGR5kJ0=;
 b=I/Zsn5nCDvtvTlkt1UQnQ9Tw8vjHFLTmbPWdVjSRzozXvhZF4N7B58zoo58zdHhHvJsU8TPbO9rB7dWwSxDMavsUAKP8xX++60pZ+DhCIRGhmexwdjIzfEQRcZXlpd6JFKqxyeoeszuGsjYOldw0y5SnVZdfZlh9lP+EdhqznztbXiMbMiUU6SUOLykY2kGXxxAAXWarVN5CEIAuTJbGK7YgtrvtP15T3FFbN+9vlCs2J85MGdhNEawJQTpib1S4Gw7ULoFpjkIhA5/sV+T6oCSOD8QlkksFuyTd7WwMvIlqvhZqYfAziAZQVnxpXcRjH+Po5nTHaFXoGKoC17d+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT/aDjmD1coCHB55UbRtZ6cZ3298pNvJa+dMuGR5kJ0=;
 b=jJ08UbweYG6KEBHP+7fo2RxDaLRReM49XgwT6RxXk833faiQ+pIhUU62Re4s8kZLZyMZcR89g7bsXX0zcuTOLAP8VLWq7xPJKRf+kIfT8HmBaVGqhlRRrgg3O2KF6Rj0Rag1JX049ls30GT6Jfd4OQFae/Hwt3lB+1CsExURVRg=
Received: from MW2PR16CA0072.namprd16.prod.outlook.com (2603:10b6:907:1::49)
 by BN6PR1201MB0210.namprd12.prod.outlook.com (2603:10b6:405:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 7 Oct
 2020 12:42:37 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::b1) by MW2PR16CA0072.outlook.office365.com
 (2603:10b6:907:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28 via Frontend
 Transport; Wed, 7 Oct 2020 12:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:42:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:36 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:36 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 7 Oct 2020 07:42:35 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/display: Raise DPG height during timing
 synchronization
Date: Wed, 7 Oct 2020 08:42:20 -0400
Message-ID: <20201007124224.18789-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007124224.18789-1-aurabindo.pillai@amd.com>
References: <20201007124224.18789-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e4d1317-24e1-4aed-fa8d-08d86abe7892
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0210:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0210DE1C7D4A8C8BE39EDA018B0A0@BN6PR1201MB0210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlwcxj5a/FKUwxBzgZ+AUs/Gz2LH4fKfC66R3R7j1I4GuMsmjAQGbPtTiXJj6mF6tVxevB91U3uYWXKdc5wQpkTs7n4UJkKu1Z9V9E2QfuCK9z0j+G4oj468QedbvU0Q1gucI/fiisx1IaUPIvCH8Z0YaIAv9MxoG/wVrqwp+Ik7QUOAaRpSBvcqmvSXA2gnhV2wBdVPqWfn+ESNYs5VhFjNr5TxwDMbGKimVNnhz6rhhCytg3UhSJWueF6jVNX1RRX3klo8rT4WiiE9T7mc4Zt3KO/Ankt7h2DCfdX+Y9Y0XxFEGiZWTnuf9TUbA2erApepdilaFE1mNjIkNfbNmSozhILbU5f1079oXzV0DMxyJ7Nr07Acqk7es8fENB5/Md2qD9b+Pv8aCaRNkewcoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966005)(6666004)(8676002)(54906003)(1076003)(5660300002)(316002)(478600001)(82310400003)(70586007)(70206006)(82740400003)(47076004)(4326008)(36756003)(6916009)(2616005)(26005)(81166007)(356005)(186003)(44832011)(83380400001)(86362001)(7696005)(8936002)(426003)(336012)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 12:42:37.0604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4d1317-24e1-4aed-fa8d-08d86abe7892
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0210
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
