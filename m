Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2C2EE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8353210E43D;
	Wed, 23 Aug 2023 15:51:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E297010E439
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkJnGE7qeXzD5JFnQD8BfGdH8RraGolLFMg6Xsc3sUVuHjO62h6nx2vS1DEiFPQhfKbzUTAFHU5+RqfLtDhn0QfD0gY6NkGKmlykiToPmQtqv0vN00KnTky2sifjLX9mjySCGz15/nK7WhMrT8iGrubmmaizOe4gfWRwjvZkl1DVubUoyJCb9h8uQVFHceupBtItz6vNh23MdS7G17TB2qm+dePasUl0X+NV8V3UjvbAdaLs0EBJIF2OhoYfpYllhlOkO4ehsGLuaKHMmPthuGNFRJOjgjb5Ov+2otUq0EDvgQWWIlKRT/4znn0QMFF0J3pRVKtzfw2rs+saK/2uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwKOB68FMJVU3AU5bHvInyVgTt+ktKruz2zmh90riDs=;
 b=KweYS2yIoxzLLVwdK+PSHnVZjpqxvDz/DaQrKeUlzdGGCvBwePfS3zavj+bNwCyXq+dQ/HNEHoxUOqg7M9miCx2eM+9HeGkDcjpwXlRUyyqaJodtL6FaYwAbHP33czRLVphAepe7rsoGRmsxGnNE80WCy5CJPGfdLxzpLxbH3enSs5QzY4r5F2uijBg7O7kLQ4p0VlftfORQiOTW99z8x3HxRaYGKD6pIwMqSSo3ZNdc40/hS+QDfzyPWwvTXVn+MJsyDfRph0Gppq2R9KYKf+Yzm61D1cFT3aWTfUAAb/qRA6drIUAZBNyBTCFaLl0FKdCrCHz0X3Gmo6LHFcGDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwKOB68FMJVU3AU5bHvInyVgTt+ktKruz2zmh90riDs=;
 b=TQXtW7iHkwTsXy3ASIM3R8W2dFRloQToCXm1gHHx22/UmCuOfG5RZTxudXByV8jvVolS00quc284XKOoyCRjlSSqPOWjrZ8CTK8PaEqHq4sulo+OZGGlW3jfoETIABLyxZtpPgPc8fZt1V4D83hUXF9NuUj+jXeXDYeXW12MqaM=
Received: from DM6PR21CA0021.namprd21.prod.outlook.com (2603:10b6:5:174::31)
 by DM4PR12MB5375.namprd12.prod.outlook.com (2603:10b6:5:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 15:51:10 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::60) by DM6PR21CA0021.outlook.office365.com
 (2603:10b6:5:174::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/35] drm/amd/display: Update DCN20 for DCN35 support
Date: Wed, 23 Aug 2023 11:50:19 -0400
Message-ID: <20230823155048.2526343-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM4PR12MB5375:EE_
X-MS-Office365-Filtering-Correlation-Id: 94673ede-c8f8-413e-c153-08dba3f0c563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1WypH2mL5JhV9pTlbU43gPBvZs0xc45x03q69uUsQi9LRNkTZvP92tCdhuiCqM9XjGYFkNwqEMJK3v5++/bAb0E3fJXSqwlGk7iMfa0kjFToP5Ek0KexdSrwSVfcL2JQbgscdZHgVvHlNbUQCs6PPrdOke3CAzKDVpc0V3u7E+oJK092VSsbrWpqQyKRsci40Wtuf/0f72125Mq6wrTYKyc/3KXmD3T/Fd4AhiOb4KZ+B/R4OmZXChWi+XnmlFaX1qC0OFYzmI67ZG6lzx1BzVIRiPbcMLiufJjPg+f7He8Zo630MPQHKzUmb0gSivgMrdILTuNkkQiRgint2DssXYuRXrqbn3atnDWp/+E4FH4f+/+4WlOKm/cnrvWcFqOkmYo6IBvxcXr/+cSRqMWYFYeL0UlYoewjKNaWb5NsrtC7MJ/k3RskHK8GjK8h/UH60BtVNHqOtHlZbsM9oJf+2ZYpC9YDresQA0XqdfWOH/l3akXpEPQiJt42CLwXeLF8HRtPB8g0iPcI8vXj3IEf/OxJQ+ykkXrJsonYhoNTkNQ0bLrm7YMPbSuQf0le+R0zMLb3Ln0DNFlDq3TdkwJIQhq1PvVtMxKo4yVmMahPtCth/nUGHeoPpJiIhfOjyNyd81wnwoFk7ReJtTQph0sw8SpAAvrcTqUmnfBzHEOkPpUnJ4WUJXK6iQjNbnR2rpHmkPQruyGgNIIcRV6fPVaXxzd34thoor4rFGXh0VKM8cxRdKGOkenjtCm0dwNRGzSijXbnAA4J1vp61NOKKPjig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(6666004)(40480700001)(2616005)(7696005)(1076003)(40460700003)(86362001)(15650500001)(4326008)(5660300002)(2906002)(70206006)(70586007)(54906003)(8676002)(8936002)(36756003)(41300700001)(6916009)(316002)(81166007)(478600001)(82740400003)(36860700001)(83380400001)(356005)(426003)(47076005)(336012)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:10.1091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94673ede-c8f8-413e-c153-08dba3f0c563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5375
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Update DCN20 files for DCN35 usage.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h | 64 +++++++++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  8 ++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  5 ++
 .../amd/display/dc/inc/hw_sequencer_private.h |  2 +
 4 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index c8602bcfa393..ab6d09c6fe34 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -240,12 +240,66 @@
 	type DTBCLK_P3_EN;\
 	type DENTIST_DISPCLK_CHG_DONE;
 
+#define DCCG35_REG_FIELD_LIST(type) \
+	type DPPCLK0_EN;\
+	type DPPCLK1_EN;\
+	type DPPCLK2_EN;\
+	type DPPCLK3_EN;\
+	type DSCCLK0_EN;\
+	type DSCCLK1_EN;\
+	type DSCCLK2_EN;\
+	type DSCCLK3_EN;\
+	type DISPCLK_DCCG_GATE_DISABLE;\
+	type DCCG_GLOBAL_FGCG_REP_DIS; \
+	type PHYASYMCLK_EN;\
+	type PHYASYMCLK_SRC_SEL;\
+	type PHYBSYMCLK_EN;\
+	type PHYBSYMCLK_SRC_SEL;\
+	type PHYCSYMCLK_EN;\
+	type PHYCSYMCLK_SRC_SEL;\
+	type PHYDSYMCLK_EN;\
+	type PHYDSYMCLK_SRC_SEL;\
+	type PHYESYMCLK_EN;\
+	type PHYESYMCLK_SRC_SEL;\
+	type PHYASYMCLK_ROOT_GATE_DISABLE;\
+	type PHYBSYMCLK_ROOT_GATE_DISABLE;\
+	type PHYCSYMCLK_ROOT_GATE_DISABLE;\
+	type PHYDSYMCLK_ROOT_GATE_DISABLE;\
+	type PHYESYMCLK_ROOT_GATE_DISABLE;\
+	type HDMISTREAMCLK0_GATE_DISABLE;\
+	type HDMISTREAMCLK1_GATE_DISABLE;\
+	type HDMISTREAMCLK2_GATE_DISABLE;\
+	type HDMISTREAMCLK3_GATE_DISABLE;\
+	type HDMISTREAMCLK4_GATE_DISABLE;\
+	type HDMISTREAMCLK5_GATE_DISABLE;\
+	type SYMCLKA_CLOCK_ENABLE;\
+	type SYMCLKB_CLOCK_ENABLE;\
+	type SYMCLKC_CLOCK_ENABLE;\
+	type SYMCLKD_CLOCK_ENABLE;\
+	type SYMCLKE_CLOCK_ENABLE;\
+	type SYMCLKA_FE_EN;\
+	type SYMCLKB_FE_EN;\
+	type SYMCLKC_FE_EN;\
+	type SYMCLKD_FE_EN;\
+	type SYMCLKE_FE_EN;\
+	type SYMCLKA_SRC_SEL;\
+	type SYMCLKB_SRC_SEL;\
+	type SYMCLKC_SRC_SEL;\
+	type SYMCLKD_SRC_SEL;\
+	type SYMCLKE_SRC_SEL;\
+	type SYMCLKA_FE_SRC_SEL;\
+	type SYMCLKB_FE_SRC_SEL;\
+	type SYMCLKC_FE_SRC_SEL;\
+	type SYMCLKD_FE_SRC_SEL;\
+	type SYMCLKE_FE_SRC_SEL;
+
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
 	DCCG3_REG_FIELD_LIST(uint8_t)
 	DCCG31_REG_FIELD_LIST(uint8_t)
 	DCCG314_REG_FIELD_LIST(uint8_t)
 	DCCG32_REG_FIELD_LIST(uint8_t)
+	DCCG35_REG_FIELD_LIST(uint8_t)
 };
 
 struct dccg_mask {
@@ -254,6 +308,7 @@ struct dccg_mask {
 	DCCG31_REG_FIELD_LIST(uint32_t)
 	DCCG314_REG_FIELD_LIST(uint32_t)
 	DCCG32_REG_FIELD_LIST(uint32_t)
+	DCCG35_REG_FIELD_LIST(uint32_t)
 };
 
 struct dccg_registers {
@@ -292,6 +347,15 @@ struct dccg_registers {
 	uint32_t DCCG_GATE_DISABLE_CNTL4;
 	uint32_t OTG_PIXEL_RATE_DIV;
 	uint32_t DTBCLK_P_CNTL;
+	uint32_t DPPCLK_CTRL;
+	uint32_t DCCG_GATE_DISABLE_CNTL5;
+	uint32_t DCCG_GATE_DISABLE_CNTL6;
+	uint32_t DCCG_GLOBAL_FGCG_REP_CNTL;
+	uint32_t SYMCLKA_CLOCK_ENABLE;
+	uint32_t SYMCLKB_CLOCK_ENABLE;
+	uint32_t SYMCLKC_CLOCK_ENABLE;
+	uint32_t SYMCLKD_CLOCK_ENABLE;
+	uint32_t SYMCLKE_CLOCK_ENABLE;
 };
 
 struct dcn_dccg {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index d3caba52d2fc..e20b75287f5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -94,7 +94,7 @@ static int find_free_gsl_group(const struct dc *dc)
  * gsl_0 <=> pipe_ctx->stream_res.gsl_group == 1
  * Using a magic value like -1 would require tracking all inits/resets
  */
-static void dcn20_setup_gsl_group_as_lock(
+ void dcn20_setup_gsl_group_as_lock(
 		const struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		bool enable)
@@ -1762,7 +1762,11 @@ static void dcn20_program_pipe(
 		hws->funcs.update_odm(dc, context, pipe_ctx);
 
 	if (pipe_ctx->update_flags.bits.enable) {
-		dcn20_enable_plane(dc, pipe_ctx, context);
+		if (hws->funcs.enable_plane)
+			hws->funcs.enable_plane(dc, pipe_ctx, context);
+		else
+			dcn20_enable_plane(dc, pipe_ctx, context);
+
 		if (dc->res_pool->hubbub->funcs->force_wm_propagate_to_pipes)
 			dc->res_pool->hubbub->funcs->force_wm_propagate_to_pipes(dc->res_pool->hubbub);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index 01901b08644c..351b66e3f38b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -150,5 +150,10 @@ void dcn20_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset);
 
+void dcn20_setup_gsl_group_as_lock(
+		const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool enable);
+
 #endif /* __DC_HWSS_DCN20_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 4ca4192c1e12..82c592166875 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -152,6 +152,8 @@ struct hwseq_private_funcs {
 	void (*PLAT_58856_wa)(struct dc_state *context,
 			struct pipe_ctx *pipe_ctx);
 	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
+	void (*enable_plane)(struct dc *dc, struct pipe_ctx *pipe_ctx,
+			       struct dc_state *context);
 #ifdef CONFIG_DRM_AMD_DC_FP
 	void (*program_mall_pipe_config)(struct dc *dc, struct dc_state *context);
 	void (*update_force_pstate)(struct dc *dc, struct dc_state *context);
-- 
2.41.0

