Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E226C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973F910E222;
	Wed, 20 Dec 2023 16:36:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B7110E5D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey5uTK0siGaiQ9ecom1q6vzsmRfbec0L6bI+RJwE4NamtWfLxYouNH3p+Aud7wQ6W2uCi70GiLT8b/xy00a8oRF+O4fXH5ZYc2k0fP3wuF8zp+apOcN2GmQXuZMceZXg6VjY4THZoNL6EWe4L/T8s+mQAJSPB5JxCSKCqqM/4nyzKXJpbVZlnwhCiVhHAXHczoMo5Lhn4R2NjAyqZbNbjnRc/Bc6WrsIuNciLBoYup+oiA0Tg3tCcgjoV+hq1svPqNNIyFLxY5nr0fRwaIcsK/g1yJZKI+gCnn4pDr5colTY+slHpZCVhD18pp6xDLfrQsqQS/sxngB0p5iSSe91bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhrpKVZcILroL9XGzLeAVq5w/Yyjam+Mx8jTONR+T0c=;
 b=WGMBM0pPajy9EN3/DcaffrOFxeiNTM7SAET0VCHDbjGGWcui9ZYka/hFQAEq3JEJvMMzizse+0EnL/+R7mdPYnjWLT1NIiz6KKMnBvto4bTnY1W1cbug9BPAY6c+TRILt2XkbKA2f0Q6aZeik3mknA/sVbyr5UZ4LSIGw5PtCnUd4J7KmT0CBUWsw0MMnfwmi26lOlNZPV8XKBaCRDZdHC8ohjn7dG9gdzv6tlPomFqI2VPwNlKox5pbn/vukGnWZm5e65PabtR/BJyV3aEj4RD3U28I3qPw+Y8atdqTfT6GWCJvwRuCHJMALmJTHOVH2ijK43dFt9PkHBQjrdvhug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhrpKVZcILroL9XGzLeAVq5w/Yyjam+Mx8jTONR+T0c=;
 b=LJfaOgUyocZS4YUo8gyVOEDVhHCU8yqHw+rnQn5Fmn1uXclThZVZz6YbwE9xtA/5f8kqb8/hlB4MtihDlQYsXqbKpnX6DkJEAgJwFRfV5VaI5/bNYPY4fnF9ha5Uy5NFM2PW9Q7yvfP9lUUoVAR5e05aR0rpoMDB9UihUki0AEg=
Received: from MN2PR14CA0017.namprd14.prod.outlook.com (2603:10b6:208:23e::22)
 by BL0PR12MB4851.namprd12.prod.outlook.com (2603:10b6:208:1c1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:36:54 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:23e:cafe::7) by MN2PR14CA0017.outlook.office365.com
 (2603:10b6:208:23e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Wed, 20 Dec 2023 16:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:36:54 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:52 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/20] drm/amd/display: Correctly restore user_level
Date: Wed, 20 Dec 2023 09:33:39 -0700
Message-ID: <20231220163538.1742834-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BL0PR12MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: a21528fd-fa5c-4c80-c5f1-08dc0179e00e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPkN+k6EM2gX66hLeboRbJUZ6+bqzhKV6Ooe6BK3VQhJHZoyO4/jVId0Q+vKVc2ZG8nt7FokAjVMNUOnsaeFWkunCqQDfAN/DPTrTInROfHPHAJXv2gpstR5i8qHzr4YWf2WWOSFtUKNc0wBGjHZS9IuXPusNUqCKrYS79j7lLdfIU1zyp96syRyMDcelbQ5pTJvFXVvhsYCnRrSTFn25SJ1yi4T0tCNaBhJABwuAL7G7h4GnMe9WM9vNPxBe/7LLMznXHEuLY3SSVN9qMeruJtfBTO2ArSqBA3LrFbYFkd8+DvaSt0O1ZhwlIFDjuALk+/eCVCjxzEQD0rXr735XEGpVQhJ8tMRkQdYK7ca0qCRJ4jrEILBbSzESxPxJ4l5BM4iscWbJIfK02SH4/+ZyO8Vp8r8osY2JnKxqvd0osOQXQWzsbXc+6hdEszNzvDd04wYdZcu+2QLVxqHarmXy/grm+pR1VHu5LKvyZt59uUnDFUXrnFyjaqxLB5nE3uvvEx0SxKan6+E4/5NLaIFVtsihkQ0jXFsHzgxyAR21zpQj+agOy3m5+EE5qChUcjeK/ziENSmE+K+eGihTjfxiHELiouAn/I6B0giPDbSWxrhUm0vaO8gmifH/SBdKR4zNcmRs8rKWRulFnCnHMncSQnApM5VPzYKI9mkuXXLRD70IKYOsT1FhQbR769hVwHP/GBoYNKz1x5xnpmSlzZW+i6z+WQsJQ3HFERAIqH6150c2ztD1xwS1j7fHnSvuh9JrfIDtrMyQ/qHoOG7rdPfKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(6666004)(478600001)(81166007)(356005)(2616005)(16526019)(426003)(1076003)(336012)(83380400001)(47076005)(26005)(36860700001)(40480700001)(86362001)(70586007)(41300700001)(316002)(6916009)(54906003)(70206006)(8936002)(30864003)(8676002)(2906002)(5660300002)(36756003)(4326008)(82740400003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:36:54.1034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a21528fd-fa5c-4c80-c5f1-08dc0179e00e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4851
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Anthony Koo <anthony.koo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Camille Cho <camille.cho@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Camille Cho <camille.cho@amd.com>

[Why]
BL1_PWM_USER_LEVEL is meant for the user brightness level setting from
OS. However, we update it along with other ABM levels to the real PWM
value which could be ABMed.

[How]
Driver to cache and restore the user brightness level setting so that
DMUB can retrieve the last user setting in ABM config initialization.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Camille Cho <camille.cho@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c               | 4 ++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c              | 4 ++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c          | 4 ++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h          | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  | 7 +++++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    | 7 +++++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    | 7 +++++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    | 7 +++++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    | 7 +++++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    | 7 +++++--
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h                | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h         | 1 +
 .../amd/display/dc/link/protocols/link_edp_panel_control.c | 3 +++
 13 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index 874b132fe1d7..a6006776333d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -135,7 +135,7 @@ static void dmcu_set_backlight_level(
 			0, 1, 80000);
 }
 
-static void dce_abm_init(struct abm *abm, uint32_t backlight)
+static void dce_abm_init(struct abm *abm, uint32_t backlight, uint32_t user_level)
 {
 	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
 
@@ -162,7 +162,7 @@ static void dce_abm_init(struct abm *abm, uint32_t backlight)
 			BL1_PWM_TARGET_ABM_LEVEL, backlight);
 
 	REG_UPDATE(BL1_PWM_USER_LEVEL,
-			BL1_PWM_USER_LEVEL, backlight);
+			BL1_PWM_USER_LEVEL, user_level);
 
 	REG_UPDATE_2(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES,
 			ABM1_LS_MIN_PIXEL_VALUE_THRES, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 8c5e7f858be3..ccc154b0281c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -57,9 +57,9 @@ static unsigned int abm_feature_support(struct abm *abm, unsigned int panel_inst
 	return ret;
 }
 
-static void dmub_abm_init_ex(struct abm *abm, uint32_t backlight)
+static void dmub_abm_init_ex(struct abm *abm, uint32_t backlight, uint32_t user_level)
 {
-	dmub_abm_init(abm, backlight);
+	dmub_abm_init(abm, backlight, user_level);
 }
 
 static unsigned int dmub_abm_get_current_backlight_ex(struct abm *abm)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index 4cff36351f40..f9d6a181164a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -79,7 +79,7 @@ static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
-void dmub_abm_init(struct abm *abm, uint32_t backlight)
+void dmub_abm_init(struct abm *abm, uint32_t backlight, uint32_t user_level)
 {
 	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
 
@@ -106,7 +106,7 @@ void dmub_abm_init(struct abm *abm, uint32_t backlight)
 			BL1_PWM_TARGET_ABM_LEVEL, backlight);
 
 	REG_UPDATE(BL1_PWM_USER_LEVEL,
-			BL1_PWM_USER_LEVEL, backlight);
+			BL1_PWM_USER_LEVEL, user_level);
 
 	REG_UPDATE_2(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES,
 			ABM1_LS_MIN_PIXEL_VALUE_THRES, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
index 07ea6c8d414f..761685e5b8c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
@@ -30,7 +30,7 @@
 
 struct abm_save_restore;
 
-void dmub_abm_init(struct abm *abm, uint32_t backlight);
+void dmub_abm_init(struct abm *abm, uint32_t backlight, uint32_t user_level);
 bool dmub_abm_set_level(struct abm *abm, uint32_t level, uint8_t panel_mask);
 unsigned int dmub_abm_get_current_backlight(struct abm *abm);
 unsigned int dmub_abm_get_target_backlight(struct abm *abm);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index b943d47583e5..d6260b8b476f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -2592,6 +2592,7 @@ static void init_hw(struct dc *dc)
 	struct dmcu *dmcu;
 	struct dce_hwseq *hws = dc->hwseq;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
+	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
 	bp = dc->ctx->dc_bios;
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -2641,13 +2642,15 @@ static void init_hw(struct dc *dc)
 	for (i = 0; i < dc->link_count; i++) {
 		struct dc_link *link = dc->links[i];
 
-		if (link->panel_cntl)
+		if (link->panel_cntl) {
 			backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
+			user_level = link->panel_cntl->stored_backlight_registers.USER_LEVEL;
+		}
 	}
 
 	abm = dc->res_pool->abm;
 	if (abm != NULL)
-		abm->funcs->abm_init(abm, backlight);
+		abm->funcs->abm_init(abm, backlight, user_level);
 
 	dmcu = dc->res_pool->dmcu;
 	if (dmcu != NULL && abm != NULL)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 1c5e3bb6f0ee..51dd2ae09b2a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1490,6 +1490,7 @@ void dcn10_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
+	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 	bool   is_optimized_init_done = false;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
@@ -1587,12 +1588,14 @@ void dcn10_init_hw(struct dc *dc)
 		for (i = 0; i < dc->link_count; i++) {
 			struct dc_link *link = dc->links[i];
 
-			if (link->panel_cntl)
+			if (link->panel_cntl) {
 				backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
+				user_level = link->panel_cntl->stored_backlight_registers.USER_LEVEL;
+			}
 		}
 
 		if (abm != NULL)
-			abm->funcs->abm_init(abm, backlight);
+			abm->funcs->abm_init(abm, backlight, user_level);
 
 		if (dmcu != NULL && !dmcu->auto_load_dmcu)
 			dmcu->funcs->dmcu_init(dmcu);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 327c227a10ea..c34c13e1e0a4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -476,6 +476,7 @@ void dcn30_init_hw(struct dc *dc)
 	int i;
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
+	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -612,13 +613,15 @@ void dcn30_init_hw(struct dc *dc)
 	for (i = 0; i < dc->link_count; i++) {
 		struct dc_link *link = dc->links[i];
 
-		if (link->panel_cntl)
+		if (link->panel_cntl) {
 			backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
+			user_level = link->panel_cntl->stored_backlight_registers.USER_LEVEL;
+		}
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (abms[i] != NULL)
-			abms[i]->funcs->abm_init(abms[i], backlight);
+			abms[i]->funcs->abm_init(abms[i], backlight, user_level);
 	}
 
 	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 260860c259f3..7423880fabb6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -113,6 +113,7 @@ void dcn31_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
+	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 	int i;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
@@ -224,13 +225,15 @@ void dcn31_init_hw(struct dc *dc)
 	for (i = 0; i < dc->link_count; i++) {
 		struct dc_link *link = dc->links[i];
 
-		if (link->panel_cntl)
+		if (link->panel_cntl) {
 			backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
+			user_level = link->panel_cntl->stored_backlight_registers.USER_LEVEL;
+		}
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (abms[i] != NULL)
-			abms[i]->funcs->abm_init(abms[i], backlight);
+			abms[i]->funcs->abm_init(abms[i], backlight, user_level);
 	}
 
 	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 6f360f008f67..6c9299c7683d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -753,6 +753,7 @@ void dcn32_init_hw(struct dc *dc)
 	int i;
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
+	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -907,13 +908,15 @@ void dcn32_init_hw(struct dc *dc)
 	for (i = 0; i < dc->link_count; i++) {
 		struct dc_link *link = dc->links[i];
 
-		if (link->panel_cntl)
+		if (link->panel_cntl) {
 			backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
+			user_level = link->panel_cntl->stored_backlight_registers.USER_LEVEL;
+		}
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (abms[i] != NULL && abms[i]->funcs != NULL)
-			abms[i]->funcs->abm_init(abms[i], backlight);
+			abms[i]->funcs->abm_init(abms[i], backlight, user_level);
 	}
 
 	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index ad710b4036de..c40f4a06abdb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -134,6 +134,7 @@ void dcn35_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
+	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 	int i;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
@@ -280,13 +281,15 @@ void dcn35_init_hw(struct dc *dc)
 	for (i = 0; i < dc->link_count; i++) {
 		struct dc_link *link = dc->links[i];
 
-		if (link->panel_cntl)
+		if (link->panel_cntl) {
 			backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
+			user_level = link->panel_cntl->stored_backlight_registers.USER_LEVEL;
+		}
 	}
 	if (dc->ctx->dmub_srv) {
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (abms[i] != NULL && abms[i]->funcs != NULL)
-			abms[i]->funcs->abm_init(abms[i], backlight);
+			abms[i]->funcs->abm_init(abms[i], backlight, user_level);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index 9f521cf0fc5a..3f0161d64675 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -36,7 +36,7 @@ struct abm {
 };
 
 struct abm_funcs {
-	void (*abm_init)(struct abm *abm, uint32_t back_light);
+	void (*abm_init)(struct abm *abm, uint32_t back_light, uint32_t user_level);
 	bool (*set_abm_level)(struct abm *abm, unsigned int abm_level);
 	bool (*set_abm_immediate_disable)(struct abm *abm, unsigned int panel_inst);
 	bool (*set_pipe)(struct abm *abm, unsigned int controller_id, unsigned int panel_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
index 248adc1705e3..5dcbaa2db964 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -40,6 +40,7 @@ struct panel_cntl_backlight_registers {
 	unsigned int BL_PWM_PERIOD_CNTL;
 	unsigned int LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV;
 	unsigned int PANEL_PWRSEQ_REF_DIV2;
+	unsigned int USER_LEVEL;
 };
 
 struct panel_cntl_funcs {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index bf53a86ea817..e8de68e62403 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -529,6 +529,9 @@ bool edp_set_backlight_level(const struct dc_link *link,
 	if (dc_is_embedded_signal(link->connector_signal)) {
 		struct pipe_ctx *pipe_ctx = get_pipe_from_link(link);
 
+		if (link->panel_cntl)
+			link->panel_cntl->stored_backlight_registers.USER_LEVEL = backlight_pwm_u16_16;
+
 		if (pipe_ctx) {
 			/* Disable brightness ramping when the display is blanked
 			 * as it can hang the DMCU
-- 
2.42.0

