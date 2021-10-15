Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E118EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4AB960C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4AB960C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B612E6EDCF;
	Fri, 15 Oct 2021 18:44:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E2F6EDCA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NggGvgUSiug9KEQlKySTrvH/Ehqzm7lRQlrAAYerjrCxcZGYbpHUXAD7lJUN8RJoM3jX96IzbCCdmGp4BJuKaHZxe/MvMkuTNCVp+5ATda8LGI566pLUXDhe9of2mUD3/Gcm2Ho/GW/cpgUMVQtzE2Sokkt2LfMcPvl5W7SI+jVC0JWg6er0ei2VUSBixrJQyjx1wRJObMGKjq24vB8skM8KD//dGBH8t22GwUt9jYtahFSyGcAUtVfqhgsRqmc52Btdgrq14FwEJpfkEC+ngIrk59tft+r6RHz1nH4GoXiCE8H8kZpwXXV2uMykYhvMwxSjv0SgyZj19/vK6Uj60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9cps7bkY6tKZk7uDxvxB3NLWofjeYpr5BJtdPK54V0=;
 b=TejLH2FqhmkYt7QiAP5LHLd/tc6fu8b0TBTEXnZFxxa3epkAlUsQwWNPJj8cH55/XqGqkifUY9U9VpMR5cMXkVNC3DqCrUpxmfyuLCBoaF/d84jNRv32k07bAnymeuGIeGM9K4QdmPVdmJbBydnbAGEv9YMR4OgXLcSBHyf8aarWelCHXQEoScZXSv1LyYqUSmfSO38zEHoptOJ+tnN+nQ/I5HGSVOLNU6+Qk315VWWXRvfR0mGXeyw8vDjAcxX33BqSjcRP/a22N0auKJG/Bspswfx6NSlawEHNGSmYUf4IiCtAu2EtHNjcRL1/EgZZCQLmGm8zSFbArrvlEoSNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9cps7bkY6tKZk7uDxvxB3NLWofjeYpr5BJtdPK54V0=;
 b=2sqXhZ8DseogMMsUKT3UZIsrMwt6V4yT6NWa/Ngw7cqPHvzAxLb+7r4eADxzylmUhy5qkYBqFxP/JiScrEa//QZm0VtwDgegqux3PvHoH5nhRyJU32Lq8g1Qi+6Vnw24YrumCieMxIgvnzjmdE/KXeIJncn+DVOW48S5AM4wAQE=
Received: from DM6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:5:80::32) by
 MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 18:44:02 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::2c) by DM6PR08CA0019.outlook.office365.com
 (2603:10b6:5:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:02 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:00 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jake Wang <haonan.wang2@amd.com>, Nikola Cornij
 <Nikola.Cornij@amd.com>
Subject: [PATCH 14/27] drm/amd/display: Disable dsc root clock when not being
 used
Date: Fri, 15 Oct 2021 14:43:19 -0400
Message-ID: <20211015184332.221091-15-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9466b72-cacb-4e84-2fe0-08d9900bc1fa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4333:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43339F81F264A3511294CFD1F5B99@MN2PR12MB4333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLLN2SKy/gSVgSYD+fsjRrOF80B4XfLraAuiJQqR97+2A7v+QUBsLRzWAjSWNa3RPeaVdG9F4FyXonNEFSm/Lxb1L+laFkFEha5PlvOTUR8clE1B36R+ktl1eo2ZbALU/5Lb8aYTbCFrhDUwQc6PndMHu8/0HJouR88L/WtiCvijrNgPUQZhEK+0YXMLSN77Nml0D/B8fBWdVb2lLEniypsES5fr/vDqUgpbEnf6jytZhyzAHMSybViN5OnXLg/kkgBAJ3zf+XHQme/YzcMhjOu4WFwhMWIiXMUvswNXf4R8OCoEmkyj3VCYjdPmNddUM+tTQTofG3JHfucwsess3Vv4PZ2s4a5zrz7HKptAF8QPxSvtg59VCrPRs56ik7l2fT/Msp8qTOy34E84AP7eK/lfiAIfj0Txi0o3RXMGmaOUvxprvrF+GPz60AtQbbBJ+wE5E6p0snGvNy2RpORKPNZE5IU/KampUVB1aD5gXOaYASLYikpVKgNJjtsqLVuOKxerecATZ/vL86f8sbdw0vk0rWlV0XLyi4bugST7KV8RD35r4X3EbolPBqvAJKRtvs9y2IZouNXMTFVup77vmVNB+WRTIymXX2iQEzoA2Y+3+zD5AZEzkHR/PbVnEWM3gYi6ShvTqJhPX0ihbg9VRnMqc9qlSxraDl4C9fDzxBkCDdEN0XHL6gdci8Cz2D0yFYzussxBN41ggFfjxoUlkB+AQYmTLwZs+z6+SXKjPk0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(81166007)(82310400003)(186003)(16526019)(44832011)(356005)(8676002)(36860700001)(83380400001)(26005)(47076005)(86362001)(70206006)(2906002)(336012)(36756003)(5660300002)(70586007)(4326008)(2616005)(8936002)(316002)(6916009)(1076003)(54906003)(426003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:02.2261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9466b72-cacb-4e84-2fe0-08d9900bc1fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why & How]
Disable root clock for dsc when not being used.

Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Jake Wang <haonan.wang2@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h | 16 ++++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 72 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h | 18 ++++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 17 +++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  9 +++
 5 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index ede65100a050..f6f2d48a70c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -169,7 +169,17 @@
 	type DTBCLK_DTO_DIV[MAX_PIPES];\
 	type DCCG_AUDIO_DTO_SEL;\
 	type DCCG_AUDIO_DTO0_SOURCE_SEL;\
-	type DENTIST_DISPCLK_CHG_MODE;
+	type DENTIST_DISPCLK_CHG_MODE;\
+	type DSCCLK0_DTO_PHASE;\
+	type DSCCLK0_DTO_MODULO;\
+	type DSCCLK1_DTO_PHASE;\
+	type DSCCLK1_DTO_MODULO;\
+	type DSCCLK2_DTO_PHASE;\
+	type DSCCLK2_DTO_MODULO;\
+	type DSCCLK0_DTO_ENABLE;\
+	type DSCCLK1_DTO_ENABLE;\
+	type DSCCLK2_DTO_ENABLE;
+
 
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
@@ -205,6 +215,10 @@ struct dccg_registers {
 	uint32_t SYMCLK32_SE_CNTL;
 	uint32_t SYMCLK32_LE_CNTL;
 	uint32_t DENTIST_DISPCLK_CNTL;
+	uint32_t DSCCLK_DTO_CTRL;
+	uint32_t DSCCLK0_DTO_PARAM;
+	uint32_t DSCCLK1_DTO_PARAM;
+	uint32_t DSCCLK2_DTO_PARAM;
 };
 
 struct dcn_dccg {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 152adb597d48..3a325e4afe2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -247,6 +247,76 @@ void dccg31_disable_symclk32_le(
 	}
 }
 
+static void dccg31_disable_dscclk(struct dccg *dccg, int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
+		return;
+	//DTO must be enabled to generate a 0 Hz clock output
+	switch (inst) {
+	case 0:
+		REG_UPDATE(DSCCLK_DTO_CTRL,
+				DSCCLK0_DTO_ENABLE, 1);
+		REG_UPDATE_2(DSCCLK0_DTO_PARAM,
+				DSCCLK0_DTO_PHASE, 0,
+				DSCCLK0_DTO_MODULO, 1);
+		break;
+	case 1:
+		REG_UPDATE(DSCCLK_DTO_CTRL,
+				DSCCLK1_DTO_ENABLE, 1);
+		REG_UPDATE_2(DSCCLK1_DTO_PARAM,
+				DSCCLK1_DTO_PHASE, 0,
+				DSCCLK1_DTO_MODULO, 1);
+		break;
+	case 2:
+		REG_UPDATE(DSCCLK_DTO_CTRL,
+				DSCCLK2_DTO_ENABLE, 1);
+		REG_UPDATE_2(DSCCLK2_DTO_PARAM,
+				DSCCLK2_DTO_PHASE, 0,
+				DSCCLK2_DTO_MODULO, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg31_enable_dscclk(struct dccg *dccg, int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.dsc)
+		return;
+	//Disable DTO
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(DSCCLK0_DTO_PARAM,
+				DSCCLK0_DTO_PHASE, 0,
+				DSCCLK0_DTO_MODULO, 0);
+		REG_UPDATE(DSCCLK_DTO_CTRL,
+				DSCCLK0_DTO_ENABLE, 0);
+		break;
+	case 1:
+		REG_UPDATE_2(DSCCLK1_DTO_PARAM,
+				DSCCLK1_DTO_PHASE, 0,
+				DSCCLK1_DTO_MODULO, 0);
+		REG_UPDATE(DSCCLK_DTO_CTRL,
+				DSCCLK1_DTO_ENABLE, 0);
+		break;
+	case 2:
+		REG_UPDATE_2(DSCCLK2_DTO_PARAM,
+				DSCCLK2_DTO_PHASE, 0,
+				DSCCLK2_DTO_MODULO, 0);
+		REG_UPDATE(DSCCLK_DTO_CTRL,
+				DSCCLK2_DTO_ENABLE, 0);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
 void dccg31_set_physymclk(
 		struct dccg *dccg,
 		int phy_inst,
@@ -469,6 +539,8 @@ static const struct dccg_funcs dccg31_funcs = {
 	.set_dtbclk_dto = dccg31_set_dtbclk_dto,
 	.set_audio_dtbclk_dto = dccg31_set_audio_dtbclk_dto,
 	.set_dispclk_change_mode = dccg31_set_dispclk_change_mode,
+	.disable_dsc = dccg31_disable_dscclk,
+	.enable_dsc = dccg31_enable_dscclk,
 };
 
 struct dccg *dccg31_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index 1e5aabcb7799..61b457ab790d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -61,7 +61,11 @@
 	SR(DCCG_AUDIO_DTBCLK_DTO_MODULO),\
 	SR(DCCG_AUDIO_DTBCLK_DTO_PHASE),\
 	SR(DCCG_AUDIO_DTO_SOURCE),\
-	SR(DENTIST_DISPCLK_CNTL)
+	SR(DENTIST_DISPCLK_CNTL),\
+	SR(DSCCLK0_DTO_PARAM),\
+	SR(DSCCLK1_DTO_PARAM),\
+	SR(DSCCLK2_DTO_PARAM),\
+	SR(DSCCLK_DTO_CTRL)
 
 
 #define DCCG_MASK_SH_LIST_DCN31(mask_sh) \
@@ -119,7 +123,17 @@
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, DIV, 3, mask_sh),\
 	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh),\
 	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh),\
-	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_MODE, mask_sh)
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_MODE, mask_sh), \
+	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_PHASE, mask_sh),\
+	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_MODULO, mask_sh),\
+	DCCG_SF(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_PHASE, mask_sh),\
+	DCCG_SF(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_MODULO, mask_sh),\
+	DCCG_SF(DSCCLK2_DTO_PARAM, DSCCLK2_DTO_PHASE, mask_sh),\
+	DCCG_SF(DSCCLK2_DTO_PARAM, DSCCLK2_DTO_MODULO, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK0_DTO_ENABLE, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK1_DTO_ENABLE, mask_sh),\
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_DTO_ENABLE, mask_sh)
+
 
 
 struct dccg *dccg31_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 52947c03be31..fee385e37c9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -270,6 +270,12 @@ void dcn31_dsc_pg_control(
 	if (hws->ctx->dc->debug.disable_dsc_power_gate)
 		return;
 
+	if (hws->ctx->dc->debug.root_clock_optimization.bits.dsc &&
+		hws->ctx->dc->res_pool->dccg->funcs->enable_dsc &&
+		power_on)
+		hws->ctx->dc->res_pool->dccg->funcs->enable_dsc(
+			hws->ctx->dc->res_pool->dccg, dsc_inst);
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
@@ -306,6 +312,17 @@ void dcn31_dsc_pg_control(
 
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
+
+	if (hws->ctx->dc->debug.root_clock_optimization.bits.dsc) {
+		if (hws->ctx->dc->res_pool->dccg->funcs->disable_dsc && !power_on)
+			hws->ctx->dc->res_pool->dccg->funcs->disable_dsc(
+				hws->ctx->dc->res_pool->dccg, dsc_inst);
+
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		dc_z10_save_init(hws->ctx->dc);
+#endif
+	}
+
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 09237d5819f4..c940fdfda144 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -123,6 +123,15 @@ struct dccg_funcs {
 	void (*set_dispclk_change_mode)(
 			struct dccg *dccg,
 			enum dentist_dispclk_change_mode change_mode);
+
+	void (*disable_dsc)(
+		struct dccg *dccg,
+		int inst);
+
+	void (*enable_dsc)(
+		struct dccg *dccg,
+		int inst);
+
 };
 
 #endif //__DAL_DCCG_H__
-- 
2.25.1

