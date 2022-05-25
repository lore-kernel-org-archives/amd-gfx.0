Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB9BC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0022310F270;
	Wed, 25 May 2022 16:20:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8D810F3A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUlqAF9VWzaE3/gIs+mFVbZalHdlnaGdlb2BNjGJyakoGJ3ZIPFyvAHuURjpiWkgAPwtvCxLrpErCZn7FfgPFWbHO0V1Up5mHYOlRQkr91Cl26BHCxCbheay+9la/hfxY2VzqvRsz4k0ZEyZ8nd32nIXzqmCpe8wKDxJfb+uxlh/0+m2Zo6lHovp+/QWHf7IOuRvsyI/AN34Pe/dodu2aNtjUM5Tys9wk0eYqR5B9lkCD1kSvaarrWs1yVzxilzYAbV13eqyq9q7s+nCLnDlmZWQ/jmeuMpZYLIPuhy4G77C9sqabCE9r70M7pejqAKvRobkX4N5hlN00BY/kXTI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPPRlkz8TBBeMNhTN9ybVr3Mqy87X2EDaFKBDaY9ZQI=;
 b=WqqKPl6fN/JprDMCeYj0NBXxOJfNQjtTa4c59edQuxYhnSUOkmTDTYCgexd/mN/cML8kTvgDWwtjAU2cq0bgasRfHskgR28rgmV4W7tpTpNiml3dIDdsKHnY36LJ1/7RZmj4re6SkcJW2X/BqPZXKiDB3M4Z6es493r2tygl6tSGdwT/cEyWGviAlcZ3EgXw0ijSZc6OgiwcMWD/Ku6jcCmcAequYC8g1Q+ruIOEF5bT1CQ4NAxMpM15OQpjjbNwECe1pZSSLhbB0pih2SLzbGaVVO57B/wV1HjpYRIN8CCANTU0005L2MliAJI4EYRAq+AsrSwoc/Mb4eLV4Imu8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPPRlkz8TBBeMNhTN9ybVr3Mqy87X2EDaFKBDaY9ZQI=;
 b=u0Y+oRiqJcWveRfAQ1kIiTIlCbpGi01SrhueFssk66BNtTlHp31lYY78y/r8hQyV6sPRIbNbFm8n1ygnnRzdKbkCGlFBOPNjm2O4FzE6dkk4M7yOSM8zBKVqGOx+Q3uarlJswKCpl0gi/JkP0OquuLO3hW/CrW2AmXriirObvL8=
Received: from DM6PR06CA0086.namprd06.prod.outlook.com (2603:10b6:5:336::19)
 by MWHPR1201MB0255.namprd12.prod.outlook.com (2603:10b6:301:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 16:20:28 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::be) by DM6PR06CA0086.outlook.office365.com
 (2603:10b6:5:336::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 16:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 40/43] drm/amd/display: Updates for OTG and DCCG clocks
Date: Wed, 25 May 2022 12:19:38 -0400
Message-ID: <20220525161941.2544055-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 095758fe-0732-4442-15e3-08da3e6a7ab8
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0255:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0255186DCB6F1AD770F3900DF7D69@MWHPR1201MB0255.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TvPsZjnPagJ5W8g+W0/br+TTqb1kXQW1FLAixqua+wTFDT4fqwympD7Ou7kPrA8Ao8jemx5UQFDUsFrch7j1Mky6UfVlq35iX08udCWizrIAdKm9RGI3OoTSxho+W/P8dOe/dvYidZWRojZ04cC6zuEOiLv4flTt0DQN/QbMGCF3jFAC061mLzdEeLTXIe8ZHZjB8yrpbC8m4NbqLMLQQek4e21gK0nanVLhHI8AVXMZySLgbICatUW6UvP01l/QB5++pvQbFSYi2EHuFG6ieAwy/uoF0MeQVHq/AC9iCbnxERMxPimPzBDbt8WmNtJ9Y9TE72iADdRlVHOlSMcdkkctUJJifhoDs+vjLWxQJBazTzPfq6wf1XC3b+83MtF919OXP8PIFIxaMqGYnssVlbkLZn+Ahax0YdV9ylwGUDlWkY4inJL34kxzRxCpBq4OipOSP9cvEPl8fpQb+qE4au15jNDj7gv6CklUhgwplYuXFId1k3aOMOJYsk9vKgB2CoE1FFz88jj9imtLp3NUn7IrvFCNzdAZ/RoXlYfrL8Vc5RfZ3uzcqrNJKquZ4sArIj8hntqcAieLplZbzh/xyqxX5SToIXNMI3/y16PaRiFKQhIm3ZGth4vNJrKWhUpoYQiw6RxyMvABzQWW8WLnqGt1w3uNTwt4iC/z2E7hDKf9CRwi4mTsBmTMUNxHF0d8h9MzbhM8QdN0A0IKKs0g4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(47076005)(336012)(426003)(1076003)(8936002)(16526019)(5660300002)(186003)(2906002)(81166007)(36860700001)(36756003)(83380400001)(7696005)(356005)(82310400005)(86362001)(2616005)(70206006)(70586007)(40460700003)(316002)(508600001)(26005)(4326008)(54906003)(8676002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:27.1592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 095758fe-0732-4442-15e3-08da3e6a7ab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0255
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Samson Tam <Samson.Tam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

Use DTBCLK for valid pixel clock generation

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h | 4 ++++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h | 1 +
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index df155cc2bfea..3fe5882ed018 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -514,7 +514,6 @@ struct dcn_optc_registers {
 	type DIG_UPDATE_POSITION_X;\
 	type DIG_UPDATE_POSITION_Y;\
 	type OTG_H_TIMING_DIV_MODE;\
-	type OTG_H_TIMING_DIV_MODE_MANUAL;\
 	type OTG_DRR_TIMING_DBUF_UPDATE_MODE;\
 	type OTG_CRC_DSC_MODE;\
 	type OTG_CRC_DATA_STREAM_COMBINE_MODE;\
@@ -522,13 +521,17 @@ struct dcn_optc_registers {
 	type OTG_CRC_DATA_FORMAT;\
 	type OTG_V_TOTAL_LAST_USED_BY_DRR;
 
+#define TG_REG_FIELD_LIST_DCN3_2(type) \
+	type OTG_H_TIMING_DIV_MODE_MANUAL;
 
 struct dcn_optc_shift {
 	TG_REG_FIELD_LIST(uint8_t)
+	TG_REG_FIELD_LIST_DCN3_2(uint8_t)
 };
 
 struct dcn_optc_mask {
 	TG_REG_FIELD_LIST(uint32_t)
+	TG_REG_FIELD_LIST_DCN3_2(uint32_t)
 };
 
 struct optc {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index c7d07203d21a..828a72c0720c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -148,8 +148,8 @@ void dccg32_set_dtbclk_dto(
 		uint32_t modulo, phase;
 
 		// phase / modulo = dtbclk / dtbclk ref
-		modulo = 0xffffffff;
-		phase = (((unsigned long long)modulo * req_dtbclk_khz) + dccg->ref_dtbclk_khz - 1) / dccg->ref_dtbclk_khz;
+		modulo = dccg->ref_dtbclk_khz * 1000;
+		phase = req_dtbclk_khz * 1000;
 
 		REG_WRITE(DTBCLK_DTO_MODULO[otg_inst], modulo);
 		REG_WRITE(DTBCLK_DTO_PHASE[otg_inst], phase);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
index 0e54c0a105a1..1c46fad0977b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
@@ -45,6 +45,7 @@
 	SR(PHYDSYMCLK_CLOCK_CNTL),\
 	SR(PHYESYMCLK_CLOCK_CNTL),\
 	SR(DPSTREAMCLK_CNTL),\
+	SR(HDMISTREAMCLK_CNTL),\
 	SR(SYMCLK32_SE_CNTL),\
 	SR(SYMCLK32_LE_CNTL),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 0),\
@@ -98,6 +99,8 @@
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK2_SRC_SEL, mask_sh),\
 	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK3_SRC_SEL, mask_sh),\
 	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_EN, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_DTO_FORCE_DIS, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE0_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE1_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE2_SRC_SEL, mask_sh),\
@@ -143,6 +146,7 @@
 	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P2_EN, mask_sh),\
 	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P3_SRC_SEL, mask_sh),\
 	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P3_EN, mask_sh),\
+	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh),\
 	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh)
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
index e07b317ed3f4..5e57c39235fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
@@ -245,6 +245,7 @@
 	SF(OTG0_OTG_DRR_TRIGGER_WINDOW, OTG_DRR_TRIGGER_WINDOW_END_X, mask_sh),\
 	SF(OTG0_OTG_DRR_V_TOTAL_CHANGE, OTG_DRR_V_TOTAL_CHANGE_LIMIT, mask_sh),\
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
+	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE_MANUAL, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
 	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
 
-- 
2.35.3

