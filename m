Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06400C4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03DB206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2+KZL2CX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03DB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7721289EB4;
	Sun,  4 Oct 2020 17:19:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42A0989EAE
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3sE8ZIWClN/RtL58aEeiRqbno8AqGMZHCN6LdYqo4YHXAwX2yxdVhJvwLqCeS65HunQ5cr+CP6syMqDBihRXHaL2YW54ITGHyzmnqF/w3TZZ6gf7ItmcokqQ0BtQjLMI+VD6KkoTl4HF6+YAWk6vG+qDAY6Y4G4bPICCodNvHfySmja0ksgRhnWMuvxc7UxIX8tt8HMRmaLgA0js4XFXB14osbwbxP1ULcrI5qFfY3qAL2fAOdqN0/8aaqbi0n2H4k5wvIbMD+e7nD7xAMh+FUCC6aV/CiTlpahRrVV5ui1oQJMeNJbR3T3fK8ib+56yEHx9WRfF2Qw8pDfD/CvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abrkFF4dsKwQOwLYfSCWBFkna46qKFSUcp6q+7+G+HQ=;
 b=Rbvo2Am/I6RSVvqD1OUJ3F0chiOKaQ6OVQI0PS+53qJNa5MhI1VHjZ7ZKL7c8tCUij1Gjc9BXKsu+866j/EXLdF/C7GwRQSAnBv6//b/yNN2oLcE6CIZFctr5K2JSLmmMvW/pE7ipBDsrUmoPuWOK5wsVWQw2/x6uAelrVO8AgR4fOcFBPobke70UoR5uCoW2nNnoKrB+K6qEdJpfv/Qksujub+bnJdkDoUywNEPriotCsgCRwrlRJqAfrvpwYOIfZo3geMZRVvlRusgH4L5H9o0KMupE9w9R9nCHhKei+eokAWsFw1FJpGphs7zO2o2bt0lV+rgYydZ/PX2zqHjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abrkFF4dsKwQOwLYfSCWBFkna46qKFSUcp6q+7+G+HQ=;
 b=2+KZL2CXHpbL+cY2atY01SJB33GBf0Jha5C3Y/T+5tb93HcuHo9dX+3XtZpqARf/Du6PMo7NoREtNIaC3dwhz6pKleI6I+bND7Bvt2b7mrVcxyhOiEkvZPeEDF1zTAFiKfpu8lwyfPuS0yrCeA7FC2i0AbAAZrkVlMMrU1cEOfU=
Received: from MWHPR21CA0034.namprd21.prod.outlook.com (2603:10b6:300:129::20)
 by MW2PR12MB2570.namprd12.prod.outlook.com (2603:10b6:907:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Sun, 4 Oct
 2020 17:19:43 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::fb) by MWHPR21CA0034.outlook.office365.com
 (2603:10b6:300:129::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.15 via Frontend
 Transport; Sun, 4 Oct 2020 17:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:19:42 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:41 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:19:35 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/18] drm/amd/display: Add i2c speed arbitration for dc_i2c
 and hdcp_i2c
Date: Sun, 4 Oct 2020 13:18:04 -0400
Message-ID: <20201004171813.7819-10-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b64d11eb-af52-4d38-dd6b-08d86889aeb4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2570:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2570B9FFDFE83E65D6BF4B36E50F0@MW2PR12MB2570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eEHfpY3WReStLPEurhwgPfaJ5UIiDdVaPZxV56agzFGRbR/g0hKmEwej9FTpqnsZ+N9aHdmX9ytDbFutgtQAlODHl1lJ9tZFjD5oJLT5l+izRn1nbqb+BtwhQlgUAlcOu45uPjIv5I+uBzVcg5XmSZfaNda47vuU3e+h60W7dH3eJZCtQ0beCyRBvJTC3bXrsG3TEWhwqzseEvpA5L2c21FRJ1J6GKR9ItBXavCnA0P9HQh/B5GLcX0kBcnHTuxa/FLTYcCuKBQkL8oE76yZEEwfLJWBaT4Fe/s/LsrNLE5yyHF8o4f50i8HvOvv+0VTKBgNbaJb9fIB/Yfu0bHXdhymzuev5VPeGy7rw3oZtY/oE838r2H/Tsvf+HJ6doAgu+aoC1K+NsweWkr43le3kA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39850400004)(376002)(46966005)(4326008)(86362001)(478600001)(36756003)(6916009)(8676002)(2906002)(1076003)(8936002)(82310400003)(82740400003)(47076004)(44832011)(426003)(2616005)(81166007)(6666004)(5660300002)(70586007)(336012)(54906003)(70206006)(83380400001)(186003)(26005)(356005)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:19:42.2083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b64d11eb-af52-4d38-dd6b-08d86889aeb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2570
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Chris Park <Chris.Park@amd.com>, Eryk
 Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
HDCP 1.4 failed on SL8800 SW w/a test driver use.

[how]
Slow down the HW i2c speed when used by HW i2c.
This request: each acquired_i2c_engine setup the i2c speed needed
and sets the I2c engine for HDCP use at release_engine.

This covers SW using HW i2c engine and HDCP using HW i2c engine.
for dmcu using HW i2c engine, needs add similar logic in dmcu fw.

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c         | 9 +++++++--
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 1 +
 11 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d893211977ff..d2d2032a40e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -152,6 +152,7 @@ struct dc_caps {
 	uint32_t max_planes;
 	uint32_t max_downscale_ratio;
 	uint32_t i2c_speed_in_khz;
+	uint32_t i2c_speed_in_khz_hdcp;
 	uint32_t dmdata_alloc_size;
 	unsigned int max_cursor_size;
 	unsigned int max_video_width;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 24adec407972..3e34afe8c504 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -299,8 +299,12 @@ static bool setup_engine(
 	/* we have checked I2c not used by DMCU, set SW use I2C REQ to 1 to indicate SW using it*/
 	REG_UPDATE(DC_I2C_ARBITRATION, DC_I2C_SW_USE_I2C_REG_REQ, 1);
 
+	/*set SW requested I2c speed to default, if API calls in it will be override later*/
+	set_speed(dce_i2c_hw, dce_i2c_hw->ctx->dc->caps.i2c_speed_in_khz);
+
 	if (dce_i2c_hw->setup_limit != 0)
 		i2c_setup_limit = dce_i2c_hw->setup_limit;
+
 	/* Program pin select */
 	REG_UPDATE_6(DC_I2C_CONTROL,
 		     DC_I2C_GO, 0,
@@ -339,8 +343,6 @@ static void release_engine(
 {
 	bool safe_to_reset;
 
-	/* Restore original HW engine speed */
-	set_speed(dce_i2c_hw, dce_i2c_hw->default_speed);
 
 	/* Reset HW engine */
 	{
@@ -360,6 +362,9 @@ static void release_engine(
 	/* HW I2c engine - clock gating feature */
 	if (!dce_i2c_hw->engine_keep_power_up_count)
 		REG_UPDATE_N(SETUP, 1, FN(SETUP, DC_I2C_DDC1_ENABLE), 0);
+
+	/*for HW HDCP Ri polling failure w/a test*/
+	set_speed(dce_i2c_hw, dce_i2c_hw->ctx->dc->caps.i2c_speed_in_khz_hdcp);
 	/* Release I2C after reset, so HW or DMCU could use it */
 	REG_UPDATE_2(DC_I2C_ARBITRATION, DC_I2C_SW_DONE_USING_I2C_REG, 1,
 		DC_I2C_SW_USE_I2C_REG_REQ, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index a28c4ae0f259..d741787f75dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -1071,6 +1071,7 @@ static bool dce100_resource_construct(
 	pool->base.timing_generator_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
+	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 128;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.disable_dp_clk_share = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 1d5385072a39..2bbfa2e176a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -1372,7 +1372,8 @@ static bool dce110_resource_construct(
 	pool->base.underlay_pipe_index = pool->base.pipe_count;
 	pool->base.timing_generator_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 150;
-	dc->caps.i2c_speed_in_khz = 100;
+	dc->caps.i2c_speed_in_khz = 40;
+	dc->caps.i2c_speed_in_khz_hdcp = 40;
 	dc->caps.max_cursor_size = 128;
 	dc->caps.is_apu = true;
 	dc->caps.extended_aux_timeout_support = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 0853bc9917c7..b622b4b1dac3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -1240,6 +1240,7 @@ static bool dce112_resource_construct(
 	pool->base.timing_generator_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 100;
+	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a not applied by default*/
 	dc->caps.max_cursor_size = 128;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 8f362e8c1787..16fe7344702f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -1080,6 +1080,7 @@ static bool dce120_resource_construct(
 
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 100;
+	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a not applied by default*/
 	dc->caps.max_cursor_size = 128;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.psp_setup_panel_mode = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index a19be9de2df7..0eae8cd35f9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -970,6 +970,7 @@ static bool dce80_construct(
 	pool->base.timing_generator_count = res_cap.num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
+	dc->caps.i2c_speed_in_khz_hdcp = 40;
 	dc->caps.max_cursor_size = 128;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
@@ -1168,6 +1169,7 @@ static bool dce81_construct(
 	pool->base.timing_generator_count = res_cap_81.num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
+	dc->caps.i2c_speed_in_khz_hdcp = 40;
 	dc->caps.max_cursor_size = 128;
 	dc->caps.is_apu = true;
 
@@ -1365,6 +1367,7 @@ static bool dce83_construct(
 	pool->base.timing_generator_count = res_cap_83.num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
+	dc->caps.i2c_speed_in_khz_hdcp = 40;
 	dc->caps.max_cursor_size = 128;
 	dc->caps.is_apu = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index a78712caf124..634171f63a2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1416,6 +1416,7 @@ static bool dcn10_resource_construct(
 	dc->caps.max_video_width = 3840;
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 100;
+	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a not applied by default*/
 	dc->caps.max_cursor_size = 256;
 	dc->caps.max_slave_planes = 1;
 	dc->caps.is_apu = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d50a9c370637..1b3b6ba20d18 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3801,6 +3801,7 @@ static bool dcn20_resource_construct(
 
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 100;
+	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a not applied by default*/
 	dc->caps.max_cursor_size = 256;
 	dc->caps.dmdata_alloc_size = 2048;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index e73785e74cba..0ab718fd43b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1808,6 +1808,7 @@ static bool dcn21_resource_construct(
 
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 100;
+	dc->caps.i2c_speed_in_khz_hdcp = 5; /*1.4 w/a applied by default*/
 	dc->caps.max_cursor_size = 256;
 	dc->caps.dmdata_alloc_size = 2048;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 7f3354b3512d..e1be47dcfbce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2519,6 +2519,7 @@ static bool dcn30_resource_construct(
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
 	dc->caps.i2c_speed_in_khz = 100;
+	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a not applied by default*/
 	dc->caps.max_cursor_size = 256;
 	dc->caps.dmdata_alloc_size = 2048;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
