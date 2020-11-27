Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D8C64E75
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7187B21D7A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OPx+VnEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7187B21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146576EDE8;
	Fri, 27 Nov 2020 14:11:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58B26EDE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlO3gf6I0vlMUYxMBF2FUgSBKaCOYqgwbOgzSskOX4P2qHCIfEYBsPfpthEjHJI10s/7J63qFF2zMbFHUjVqdF+AD3kbf37muX9MpwT4Fe+ge/d0MDpVOCFy8jz+rhZdzDrKyQpYvVgQKTi9QVRNnMdEyAEK8DF5es/LRMGG84k6K2R0+hWJdEQYDeQz7EaDt8vXa/iYa/zgaLS/YRM+by6n5ExB/MeVKlcfKs4K1hkxnLuOucA3ggzsMB4F816y/D9p5hXQTGL3CyLUtUX/z+IDuAtTRr/vs1AonL4EKdaMf2K2F78WcaHQjs514jpLPnaU07Pp5f8Fpb/4qux5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg+cHfg7PhQrjJi0vkBerXVeTwS4oyX/gv4r3hVdlgY=;
 b=mfV8PEWapm+CGX58YonTSKI2Fqfu+Uu7tlVwzEOMswL9TZ8TeQY9BEoE7YZTJ8f5Fg+C906VD9/mEAklWTBfFp2I0tN9YdLoTOpBLDQqDqQQYLwjseJNPSKCWpsAq+W5i3rpyIWKr1gXY5rcoKD/nl4SvMp1T44cHhNNdIGuTAtLelbNJLXNkmZRPqUVlfFB1mnyi37Z8KphubwZfJRxqKWIBQzQ5G/I8QYfrcFrJdJtUl4PNqls4idJzjYqoCmU/XIWNvmfgDyOhFTZkMK+57/GcDo3n5Y1A6RZJthnJXjIQ2kAOn4xoMbwgvj1zbEfn9FDs+Kx/OX7BQomklNvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg+cHfg7PhQrjJi0vkBerXVeTwS4oyX/gv4r3hVdlgY=;
 b=OPx+VnECk20Wl36Tsjai3zi53/NRuzRoAuTC5l7TEubtBn7UMBttluuKwG63LYaPXdM2YVTQU30E37fsk8Ro5fPeeIhnSSt2/qSN+y+Nl4ZVF8KmXwN8oCjWsSeIeNsTtCzaSiW9jm/koA2KZSWKPDED3A/4Euos7kic5zotKkQ=
Received: from MWHPR21CA0070.namprd21.prod.outlook.com (2603:10b6:300:db::32)
 by DM5PR1201MB2538.namprd12.prod.outlook.com (2603:10b6:3:de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 27 Nov
 2020 14:11:20 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::d1) by MWHPR21CA0070.outlook.office365.com
 (2603:10b6:300:db::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.0 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:19 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:19 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:18 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] drm/amd/display: Add DSCL memory low power support
Date: Fri, 27 Nov 2020 09:11:03 -0500
Message-ID: <20201127141107.7731-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127141107.7731-1-aurabindo.pillai@amd.com>
References: <20201127141107.7731-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ceeae04-bc17-4e34-1f10-08d892de50b1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2538:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2538D44548B5E0801E87CA008BF80@DM5PR1201MB2538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVzfkmJMUtA42fMk/iVpBF1tUngXcZ216V5u1iLsfwLVc5uO13Rsm8V4uyZK8q4HRbvx7SCzZk8FP2A2LNOfE6ki+fRoJSAemk1e0FkVQ4lIUyV67uplBv2eJArX8R3H6JUIiWuUtBk7WvGaWtMh/NBPskkZfLDEOCguZgaFxpo2ZY1qvU279ZF9yUU43wv8cMGtlQfpromnGAqmbIIZg4vx2WGuQq15lNQLC4NHUiTRMIRo563DNu6uCpOXS9i+6urY6UwVKcc8bbfHABO5pMF4fxF1OrBuSPHjqoR8xbM+vKcznJdxFgkY3WUBgurqHM2diHmOiJlVNXZyD/g6/kSGWTlbmxNfn4ZDoy3ee/GYDqDpx3l1fk5cic9u+K74rse0YdSKZSkszqM4snvBmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966005)(26005)(4326008)(82310400003)(1076003)(82740400003)(8676002)(47076004)(81166007)(86362001)(6666004)(7696005)(356005)(70586007)(36756003)(8936002)(6916009)(2906002)(83380400001)(44832011)(336012)(54906003)(2616005)(5660300002)(186003)(426003)(316002)(478600001)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:20.5366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ceeae04-bc17-4e34-1f10-08d892de50b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2538
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
Cc: Eric Yang <eric.yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Jacky Liao <ziyu.liao@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jacky Liao <ziyu.liao@amd.com>

[Why]
The DSCL memory blocks should be powered down when they're not in use.
This will reduce power consumption.

[How]
1. Write to DSCL_MEM_PWR_FORCE to put memory to shutdown when DSCL is not
   used.
2. Added a debug option to allow this behaviour to be turned off

Signed-off-by: Jacky Liao <ziyu.liao@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h  |  8 +++++++
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 24 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h  |  6 ++---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |  5 +++-
 5 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 68a192e64418..7400b0b449eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -422,6 +422,7 @@ union mem_low_power_enable_options {
 	struct {
 		bool i2c: 1;
 		bool dmcu: 1;
+		bool dscl: 1;
 		bool cm: 1;
 		bool mpc: 1;
 		bool optc: 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h
index 2edf566b3a72..9a1f40eb5c47 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h
@@ -51,6 +51,8 @@
 	SRI(CM_GAMUT_REMAP_C33_C34, CM, id),\
 	SRI(DSCL_EXT_OVERSCAN_LEFT_RIGHT, DSCL, id), \
 	SRI(DSCL_EXT_OVERSCAN_TOP_BOTTOM, DSCL, id), \
+	SRI(DSCL_MEM_PWR_STATUS, DSCL, id), \
+	SRI(DSCL_MEM_PWR_CTRL, DSCL, id), \
 	SRI(OTG_H_BLANK, DSCL, id), \
 	SRI(OTG_V_BLANK, DSCL, id), \
 	SRI(SCL_MODE, DSCL, id), \
@@ -252,6 +254,8 @@
 	TF_SF(DSCL0_SCL_VERT_FILTER_INIT_BOT_C, SCL_V_INIT_INT_BOT_C, mask_sh),\
 	TF_SF(DSCL0_SCL_MODE, SCL_CHROMA_COEF_MODE, mask_sh),\
 	TF_SF(DSCL0_SCL_MODE, SCL_COEF_RAM_SELECT_CURRENT, mask_sh), \
+	TF_SF(DSCL0_DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, mask_sh), \
+	TF_SF(DSCL0_DSCL_MEM_PWR_STATUS, LUT_MEM_PWR_STATE, mask_sh), \
 	TF_SF(CM0_CM_ICSC_CONTROL, CM_ICSC_MODE, mask_sh), \
 	TF_SF(CM0_CM_ICSC_C11_C12, CM_ICSC_C11, mask_sh), \
 	TF_SF(CM0_CM_ICSC_C11_C12, CM_ICSC_C12, mask_sh), \
@@ -536,6 +540,8 @@
 	type SCL_V_INIT_INT_BOT_C; \
 	type SCL_CHROMA_COEF_MODE; \
 	type SCL_COEF_RAM_SELECT_CURRENT; \
+	type LUT_MEM_PWR_FORCE; \
+	type LUT_MEM_PWR_STATE; \
 	type CM_GAMUT_REMAP_MODE; \
 	type CM_GAMUT_REMAP_C11; \
 	type CM_GAMUT_REMAP_C12; \
@@ -1096,6 +1102,8 @@ struct dcn_dpp_mask {
 	uint32_t DSCL_EXT_OVERSCAN_TOP_BOTTOM; \
 	uint32_t OTG_H_BLANK; \
 	uint32_t OTG_V_BLANK; \
+	uint32_t DSCL_MEM_PWR_CTRL; \
+	uint32_t DSCL_MEM_PWR_STATUS; \
 	uint32_t SCL_MODE; \
 	uint32_t LB_DATA_FORMAT; \
 	uint32_t LB_MEMORY_CTRL; \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index 878b53d85694..efa86d5c6847 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -198,6 +198,20 @@ static enum dscl_mode_sel dpp1_dscl_get_dscl_mode(
 	return DSCL_MODE_SCALING_420_YCBCR_ENABLE;
 }
 
+static void dpp1_power_on_dscl(
+	struct dpp *dpp_base,
+	bool power_on)
+{
+	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
+
+	if (dpp->tf_regs->DSCL_MEM_PWR_CTRL) {
+		REG_UPDATE(DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, power_on ? 0 : 3);
+		if (power_on)
+			REG_WAIT(DSCL_MEM_PWR_STATUS, LUT_MEM_PWR_STATE, 0, 1, 5);
+	}
+}
+
+
 static void dpp1_dscl_set_lb(
 	struct dcn10_dpp *dpp,
 	const struct line_buffer_params *lb_params,
@@ -678,6 +692,11 @@ void dpp1_dscl_set_scaler_manual_scale(
 
 	dpp->scl_data = *scl_data;
 
+	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.dscl) {
+		if (dscl_mode != DSCL_MODE_DSCL_BYPASS)
+			dpp1_power_on_dscl(dpp_base, true);
+	}
+
 	/* Autocal off */
 	REG_SET_3(DSCL_AUTOCAL, 0,
 		AUTOCAL_MODE, AUTOCAL_MODE_OFF,
@@ -697,8 +716,11 @@ void dpp1_dscl_set_scaler_manual_scale(
 	/* SCL mode */
 	REG_UPDATE(SCL_MODE, DSCL_MODE, dscl_mode);
 
-	if (dscl_mode == DSCL_MODE_DSCL_BYPASS)
+	if (dscl_mode == DSCL_MODE_DSCL_BYPASS) {
+		if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.dscl)
+			dpp1_power_on_dscl(dpp_base, false);
 		return;
+	}
 
 	/* LB */
 	lb_config =  dpp1_dscl_find_lb_memory_config(dpp, scl_data);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
index 27610251c57f..e735363d0051 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
@@ -632,8 +632,7 @@
 	type CUR0_PIX_INV_MODE; \
 	type CUR0_PIXEL_ALPHA_MOD_EN; \
 	type CUR0_ROM_EN;\
-	type OBUF_MEM_PWR_FORCE;\
-	type LUT_MEM_PWR_FORCE
+	type OBUF_MEM_PWR_FORCE
 
 
 struct dcn2_dpp_shift {
@@ -659,8 +658,7 @@ struct dcn2_dpp_mask {
 	uint32_t COLOR_KEYER_RED; \
 	uint32_t COLOR_KEYER_GREEN; \
 	uint32_t COLOR_KEYER_BLUE; \
-	uint32_t OBUF_MEM_PWR_CTRL; \
-	uint32_t DSCL_MEM_PWR_CTRL
+	uint32_t OBUF_MEM_PWR_CTRL
 
 #define DPP_DCN2_REG_VARIABLE_LIST_CM_APPEND \
 	uint32_t CM_GAMUT_REMAP_B_C11_C12; \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
index 6415aaa01d24..3fa86cd090a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
@@ -163,6 +163,8 @@
 	SRI(CM_SHAPER_LUT_DATA, CM, id),\
 	SRI(CM_MEM_PWR_CTRL2, CM, id), \
 	SRI(CM_MEM_PWR_STATUS2, CM, id), \
+	SRI(DSCL_MEM_PWR_STATUS, DSCL, id), \
+	SRI(DSCL_MEM_PWR_CTRL, DSCL, id), \
 	SRI(CM_BLNDGAM_RAMA_START_SLOPE_CNTL_B, CM, id),\
 	SRI(CM_BLNDGAM_RAMA_START_SLOPE_CNTL_G, CM, id),\
 	SRI(CM_BLNDGAM_RAMA_START_SLOPE_CNTL_R, CM, id),\
@@ -342,7 +344,8 @@
 	TF_SF(CNVC_CUR0_CURSOR0_CONTROL, CUR0_PIXEL_ALPHA_MOD_EN, mask_sh), \
 	TF_SF(CNVC_CUR0_CURSOR0_CONTROL, CUR0_ROM_EN, mask_sh),\
 	TF_SF(DSCL0_OBUF_MEM_PWR_CTRL, OBUF_MEM_PWR_FORCE, mask_sh),\
-	TF_SF(DSCL0_DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, mask_sh)
+	TF_SF(DSCL0_DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, mask_sh),\
+	TF_SF(DSCL0_DSCL_MEM_PWR_STATUS, LUT_MEM_PWR_STATE, mask_sh)
 
 #define DPP_REG_LIST_SH_MASK_DCN30_UPDATED(mask_sh)\
 	TF_SF(CM0_CM_MEM_PWR_STATUS, BLNDGAM_MEM_PWR_STATE, mask_sh), \
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
