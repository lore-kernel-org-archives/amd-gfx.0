Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1520FC4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4165206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z1MiaoaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4165206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6085089EB7;
	Sun,  4 Oct 2020 17:19:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5AE689EB7
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8YTaXtnv5ES5bfBvFejtfJea15VGWm25949EV6aV1/UqvNBVZJ9k+7OnG3lY/u1sp1solftwtpJLtT7iUKv4hTmyuBxh6dt89nxrQiDVT+hEJilErLl3aYE/igPV/7AO3OWvG36kb5U6LYDvsZFE68Pb7OGqUGm0xmpKkKltcb0zSU+Jr3YK4AZ4LWV2sa4crDeJUcPbAbBn05hHVieOoQ9cnCk3zCrHINWv/w+PR2flVdp/hTrxGszYCyoIYInEIlgJMXVVjkbiDLTx/Ep8G7ucbGnQ/CZWXgYLIHgv5Ko5kQvm1b2x1a8V5GHIdXLP52IHnlkn5g7z8962qdn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Roa5/bRIYBsKlFA073sytl+ufI/rr/kU4cflJuJ1Sng=;
 b=ZdTFHLsF+VT/0BlVSiTW1blPZOALxhbHXdzV0bo1JO1kCEoY46r6/T1vDxBnSNi8aWBwb5X3guMCWy/4zMvdym4RgpeWQyg6+c6Vh/VCqO9JBPfwUpNfDBfmrMQG5Us5Qit7xRI36m25ADPqTVuukckMc6RUu7Fdj8liyDWt0tbQs6vTDjY6UEq1rNzmAokOBqqizhAbu8PDuv+9vNGqJJDDrj68GQpv9ZBTxAP5PPJN6dGZ4njg0F01WXQgnmBdKUcSM6n6zKGC8NZ8hH/TqYi/cqgbh30blR652QOioCxMwTlIn3T26WPCaoE4wZR91sf1TGgb8QuRCNNXDs/htA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Roa5/bRIYBsKlFA073sytl+ufI/rr/kU4cflJuJ1Sng=;
 b=Z1MiaoaKF1Au1vPgTRXL3BINKNd7wat+gR8xsz+QrFxBOUCqg2Qa+2wdX4H6A3VbAw1zFLLVrIN18wjhu0EForTtCmdejnmWg7gOGcs8HPIjkWo+CDhLxchOfepdDluFmWTdjT6xGd42aqpG0EnGspZl4/LyyXf9sjiR5f41v44=
Received: from MWHPR17CA0063.namprd17.prod.outlook.com (2603:10b6:300:93::25)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sun, 4 Oct
 2020 17:19:54 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::bf) by MWHPR17CA0063.outlook.office365.com
 (2603:10b6:300:93::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.42 via Frontend
 Transport; Sun, 4 Oct 2020 17:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:19:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:53 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:52 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:19:47 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/18] drm/amd/display: Fix OPTC_DATA_FORMAT programming
Date: Sun, 4 Oct 2020 13:18:06 -0400
Message-ID: <20201004171813.7819-12-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58914a03-46ec-4d73-c4f6-08d86889b5d6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4206:
X-Microsoft-Antispam-PRVS: <MN2PR12MB420691BD82924AF5C8EC1B0DE50F0@MN2PR12MB4206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7lwNdmW2QffiHPhsgl4t3RzU1nvaRsLmhHqbr1i6cPWFE8vaPoH2gIrRMn1cnE5IELonCKxIYAQ4OR6ukqyMO/XsY+aGzjdmGBa7NNIZmyLS04PVMftgEBE5zxZ+VD++AbaXFDD0CktKu8XLysHEL2cGBKhFwNDanNPvuzqqwk930HuQvDQs3zUbqStlWnt/BrMkFa9iSwERZ3UMEs1Ok7TzHQztqTRHhGXSuh3l7WzA+Ahh7RGU+CEWqNJz87CDgCWierNhZMXVl5q6Dqe1ludLHz9V6O0Rh5flBuu5Ett4z+cF22VpAMLjPLFykauQiHNFMuy9W65lIO+9eqqRN9T2uTW0XJPpUtzL1u5KABfXPGgyQzAzWmVur5dVYaFUkcnKFqSQPSUKh7kjdFZiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(396003)(346002)(376002)(46966005)(2906002)(478600001)(426003)(8676002)(4326008)(82740400003)(70206006)(2616005)(54906003)(26005)(6666004)(70586007)(83380400001)(86362001)(82310400003)(5660300002)(8936002)(44832011)(6916009)(47076004)(316002)(356005)(36756003)(336012)(186003)(81166007)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:19:54.1695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58914a03-46ec-4d73-c4f6-08d86889b5d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

This should be programmed with timing rather than with odm.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  8 --------
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  8 --------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 2972392f9788..800be2693fac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -288,6 +288,17 @@ void optc1_program_timing(
 	if (optc1_is_two_pixels_per_containter(&patched_crtc_timing) || optc1->opp_count == 2)
 		h_div = H_TIMING_DIV_BY2;
 
+	if (REG(OPTC_DATA_FORMAT_CONTROL)) {
+		uint32_t data_fmt = 0;
+
+		if (patched_crtc_timing.pixel_encoding == PIXEL_ENCODING_YCBCR422)
+			data_fmt = 1;
+		else if (patched_crtc_timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+			data_fmt = 2;
+
+		REG_UPDATE(OPTC_DATA_FORMAT_CONTROL, OPTC_DATA_FORMAT, data_fmt);
+	}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	if (optc1->tg_mask->OTG_H_TIMING_DIV_MODE != 0) {
 		if (optc1->opp_count == 4)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index 8c16967fe018..d8b18c515d06 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -239,7 +239,6 @@ void optc2_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_c
 	int mpcc_hactive = (timing->h_addressable + timing->h_border_left + timing->h_border_right)
 			/ opp_cnt;
 	uint32_t memory_mask;
-	uint32_t data_fmt = 0;
 
 	ASSERT(opp_cnt == 2);
 
@@ -262,13 +261,6 @@ void optc2_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_c
 		REG_SET(OPTC_MEMORY_CONFIG, 0,
 			OPTC_MEM_SEL, memory_mask);
 
-	if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422)
-		data_fmt = 1;
-	else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
-		data_fmt = 2;
-
-	REG_UPDATE(OPTC_DATA_FORMAT_CONTROL, OPTC_DATA_FORMAT, data_fmt);
-
 	REG_SET_3(OPTC_DATA_SOURCE_SELECT, 0,
 			OPTC_NUM_OF_INPUT_SEGMENT, 1,
 			OPTC_SEG0_SRC_SEL, opp_id[0],
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 6d13431ff693..b1f228fc119a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -209,7 +209,6 @@ static void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, in
 	int mpcc_hactive = (timing->h_addressable + timing->h_border_left + timing->h_border_right)
 			/ opp_cnt;
 	uint32_t memory_mask = 0;
-	uint32_t data_fmt = 0;
 
 	/* TODO: In pseudocode but does not affect maximus, delete comment if we dont need on asic
 	 * REG_SET(OTG_GLOBAL_CONTROL2, 0, GLOBAL_UPDATE_LOCK_EN, 1);
@@ -240,13 +239,6 @@ static void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, in
 		REG_SET(OPTC_MEMORY_CONFIG, 0,
 			OPTC_MEM_SEL, memory_mask);
 
-	if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422)
-		data_fmt = 1;
-	else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
-		data_fmt = 2;
-
-	REG_UPDATE(OPTC_DATA_FORMAT_CONTROL, OPTC_DATA_FORMAT, data_fmt);
-
 	if (opp_cnt == 2) {
 		REG_SET_3(OPTC_DATA_SOURCE_SELECT, 0,
 				OPTC_NUM_OF_INPUT_SEGMENT, 1,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
