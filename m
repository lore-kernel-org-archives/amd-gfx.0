Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50CCCD1284
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F186010FEB2;
	Wed, 10 Apr 2024 21:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gWIvBju0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0743F10F948
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDj2wd6js629QNeiF17YIFEXCnSMe3FgEuPqmT6NeYaXejwvw62+hpz0bVDOkRLSQ4mQuGGcAF+b9VfT9WCTkw1WVnXhutAalNC94bFDyw5wTVNg9hI/RQLm5D155NTY/tijz92oRsmoSr+b383HQ4JnKQVS48LK/azSBw8xJzcxizyQRqknuJt8o3ez8rhQRueqiA0dbnqRgRyvugfr4Qy1r6akWKgGq+t1tmUeNgv5GXq/1lKKMuBaLjErkbiK+my/eGjXpJn4Itobs6jpsnetlbjYUwQjeGo+BWQhDAs3vuAHauJkoJmC1+oA+UTazJVbRxiu0QToIdspGqa8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJHggFHtsMERvRj2q7cV9hBM6PL8PfS2SBFiCuLSoUA=;
 b=R1gBqJkjpYlk/gQBhr6Ap995KHHMVVX+nHsM6IEeAgUirmlTTPJdlLzce6YmZJsCarDJLiTa4V+/bImBNT8c6OWO3WmhqojfbIVs0SidEX5YqMzKptu9A6Kcs0Tyd9HSGek/eqRcZ77WAWeRQT+qCAJ1pdeE5U8TLvXatITBg9vmtC7g2zn5qPAN6PXi+6fvNxKtJwnxtvsGZ3MSUOZg4mrH6Jp2DHUXsph6Z1ktIeoxUynAEmlJ+6XyvwwEgBlmz9PwO9qRZ0PZvVJhc9SBJTBeZB+E+AkmapehO/X6yLt49LRZDdKESBE6xV9GW3OoWn1MPn86PdGlMlLrMaAk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJHggFHtsMERvRj2q7cV9hBM6PL8PfS2SBFiCuLSoUA=;
 b=gWIvBju0NZr16WWX0syZN6VfYrnBqfr7TlbINpo8Yuj9l8jr/rbIQ94JvdHL9p/Ehm95fu9l3df+HtsV1FUkoGot+VLy+AVpz4lWaTRSJvxfLlPiV925bJAltqjb9+omRhn+HL3I3Zo2pyFEUPA5Y5qgmLlvVGwMp+wLyZmD/Lc=
Received: from BN9PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:fb::22)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 10 Apr 2024 21:28:19 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::f8) by BN9PR03CA0047.outlook.office365.com
 (2603:10b6:408:fb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:18 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 18/25] drm/amd/display: Remove unnecessary code
Date: Wed, 10 Apr 2024 15:26:07 -0600
Message-ID: <20240410212726.1312989-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: d54ebfdd-58d7-4b76-e1ac-08dc59a52471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqEnThdG41fcTwZ17KBwl+z+EXCYoisiWL80K12WFccExEkg0tD70kfZALGBqDtFqL58wcIOzgeZoiHCwDDEwGzTdyGScLhOvebjQbt99APOGYj8rSekT/hvvoU92pl3KCKlYD2HVo6W7MJCKsfgaePWd9aUOx7tg/8Mlcf85ymEdM1Zwm7GzvPQRswMljHSS1rvMndhFsNBP931JXC1AcjW1qUL+RfWswd+cvvdenu8XJ1QEdlgyp+01hQ0v5c8PeUtk2JoJ9c2TkmKJyIga7xh9PPdZxIb6H/Qqss1ajLUnqYmV/b9AQJ0+IZdSGNqpXNr7n5yab3XUrVsWejFkSLPpn64gvnZ0u3u72Hakt8JZutL8aKJGVRW+gvQjA2Qd/07zbeDxx0lXESu/3BcV6lIIgS4OSGl1Ud/ue0TIHrmOiNbaBv97aeiIYqNbcYFUUUjmj5JVkJ0KLiDklZkRTETDTuQmHNox28lP6MJ9YpRVZ2STUucHrE/C7bo3PAKH7PfReMokz953MNASxP5ebSvRl021Ob9TDwOOlrX8Hc5jVf79i5A0Fcm/fZyo/COhRqbjXvPreorAEn0iA1dJ5PMEMfQYJCGcUirci8uprarXIPhwi+8LcmpihxrYrPKxeffFEsIHCOmhuslHxX7QaXI8pn4Mj4hk78R4lQksczS7byqIOlo7q+oDab+yAg8r0K9QNVP0szZAdQIHwhGZjR7MyC7BHj7S/Vv5Ma5TyCfcrqbeMz6d37ldsW1W25J
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:19.4749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d54ebfdd-58d7-4b76-e1ac-08dc59a52471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
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

This commit groups many parts of the code that are redundant or not used
and drops all of them.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h            |  1 -
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |  3 ---
 .../amd/display/dc/dcn10/dcn10_link_encoder.h  |  6 ------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h  | 18 ------------------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c   |  2 --
 5 files changed, 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4e36a4f9a4a8..6a88423b7188 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1006,7 +1006,6 @@ struct dc_debug_options {
 	unsigned int force_cositing;
 };
 
-struct gpu_info_soc_bounding_box_v1_0;
 
 /* Generic structure that can be used to query properties of DC. More fields
  * can be added as required.
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index 744c335718a7..ee601a6897a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -312,9 +312,6 @@ static bool setup_engine(
 	/* we have checked I2c not used by DMCU, set SW use I2C REQ to 1 to indicate SW using it*/
 	REG_UPDATE(DC_I2C_ARBITRATION, DC_I2C_SW_USE_I2C_REG_REQ, 1);
 
-	/* we have checked I2c not used by DMCU, set SW use I2C REQ to 1 to indicate SW using it*/
-	REG_UPDATE(DC_I2C_ARBITRATION, DC_I2C_SW_USE_I2C_REG_REQ, 1);
-
 	/*set SW requested I2c speed to default, if API calls in it will be override later*/
 	set_speed(dce_i2c_hw, dce_i2c_hw->ctx->dc->caps.i2c_speed_in_khz);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
index d980e6bd6c66..b7a89c39f445 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
@@ -167,7 +167,6 @@ struct dcn10_link_enc_registers {
 	uint32_t DIO_LINKD_CNTL;
 	uint32_t DIO_LINKE_CNTL;
 	uint32_t DIO_LINKF_CNTL;
-	uint32_t DIG_FIFO_CTRL0;
 	uint32_t DIO_CLK_CNTL;
 	uint32_t DIG_BE_CLK_CNTL;
 };
@@ -475,9 +474,6 @@ struct dcn10_link_enc_registers {
 	type HPO_DP_ENC_SEL;\
 	type HPO_HDMI_ENC_SEL
 
-#define DCN32_LINK_ENCODER_REG_FIELD_LIST(type) \
-	type DIG_FIFO_OUTPUT_PIXEL_MODE
-
 #define DCN35_LINK_ENCODER_REG_FIELD_LIST(type) \
 	type DIG_BE_ENABLE;\
 	type DIG_RB_SWITCH_EN;\
@@ -512,7 +508,6 @@ struct dcn10_link_enc_shift {
 	DCN20_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN30_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN31_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
-	DCN32_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 	DCN35_LINK_ENCODER_REG_FIELD_LIST(uint8_t);
 };
 
@@ -521,7 +516,6 @@ struct dcn10_link_enc_mask {
 	DCN20_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 	DCN30_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 	DCN31_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
-	DCN32_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 	DCN35_LINK_ENCODER_REG_FIELD_LIST(uint32_t);
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
index 35a613bb08bf..08a57ea4591c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
@@ -29,13 +29,6 @@
 #include "dcn20/dcn20_dccg.h"
 
 
-#define DCCG_REG_LIST_DCN3AG() \
-	DCCG_COMMON_REG_LIST_DCN_BASE(),\
-	SR(PHYASYMCLK_CLOCK_CNTL),\
-	SR(PHYBSYMCLK_CLOCK_CNTL),\
-	SR(PHYCSYMCLK_CLOCK_CNTL)
-
-
 #define DCCG_REG_LIST_DCN30() \
 	DCCG_REG_LIST_DCN2(),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 2),\
@@ -46,17 +39,6 @@
 	SR(PHYBSYMCLK_CLOCK_CNTL),\
 	SR(PHYCSYMCLK_CLOCK_CNTL)
 
-#define DCCG_MASK_SH_LIST_DCN3AG(mask_sh) \
-	DCCG_MASK_SH_LIST_DCN2_1(mask_sh),\
-	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_EN, mask_sh),\
-	DCCG_SF(HDMICHARCLK0_CLOCK_CNTL, HDMICHARCLK0_SRC_SEL, mask_sh),\
-	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_EN, mask_sh),\
-	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_SRC_SEL, mask_sh),\
-	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_EN, mask_sh),\
-	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_SRC_SEL, mask_sh),\
-	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_EN, mask_sh),\
-	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_SRC_SEL, mask_sh)
-
 #define DCCG_MASK_SH_LIST_DCN3(mask_sh) \
 	DCCG_MASK_SH_LIST_DCN2(mask_sh),\
 	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_EN, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
index 1b9d9495f76d..fae98cf52020 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
@@ -251,9 +251,7 @@ static const struct dwbc_funcs dcn30_dwbc_funcs = {
 	.set_fc_enable		= dwb3_set_fc_enable,
 	.set_stereo		= dwb3_set_stereo,
 	.set_new_content	= dwb3_set_new_content,
-	.dwb_program_output_csc	= NULL,
 	.dwb_ogam_set_input_transfer_func	= dwb3_ogam_set_input_transfer_func, //TODO: rename
-	.dwb_set_scaler		= NULL,
 };
 
 void dcn30_dwbc_construct(struct dcn30_dwbc *dwbc30,
-- 
2.43.0

