Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D25CC07E97
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B233D10E885;
	Fri,  1 Dec 2023 13:28:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7395B10E874
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIB8gjk5mymSicMhSjuyLw2+sNqT5lx/Gz/GHY1kL1GFHHPuCnKCqNrsF6Hb+c0d0ddHvJgmw98Wr9vKRYHWFJEURMHZVt84qYAogZIrkX3m/eVCia6ie3TbxrUAh5ATVfLJUcwLrnvnRZuoGdyOzcErzxxalWoGiiIruFaETRg43yGfo8EB30eiJYCePBov9PHLGTLBVMOIzOQ1/LWM54KlRJLkL0rKrohwR8e/WO8q6LuKxgef1coDnRi96b6s3UYrNApUNz/LWUXTmrZ/3MvaQ1g9dcodDopze+PW2nUYVoVgW3Y3jog7PUHjLf7EGuVVg42xe5M2uK9zd3GVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRBwbnPLeeR5NzCvMuncwhjF/7XyAeLUTxOOun4YsW8=;
 b=BolKlx6HF1fkVw+n+TbIVKBVyca8kdmINmaq1hAN+MuRxNNHUlPqKqt6+A8jvP+jR9TssFghjqTrYfrAiqmOqZwD1X8dvuoOEw4eKUAPsQ3x1ineDyGzLUfOeI/7Z1Hz8wJ+JiLV7fuDEfhDPizyoK8PTUC/Xz88NOf39gli15EKyKpwnJDJLbi856I+aHCz7L2omeZLhw91ToPFsdo0Zhyts+TSp+wxVZlfK0YqCpIKDgbLulEO1rp3ZdTir8q3RmDtpURCP7oVS2tf6xH4vfplBAAQ6df/J8Q6gmBAaF3qpP0/kI7HlJr9uw32T7HbHwUeHt2mTh+4oylen8RNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRBwbnPLeeR5NzCvMuncwhjF/7XyAeLUTxOOun4YsW8=;
 b=oOVxAeF6lyUayt8fTCYa2Wa50rHwU7R3O4AXYSlZ6RpMUeEtgoRyNKEja/ZvDPUu3V/aSHnw1AmYhxdOmDhoKym7aKVQLrvjni69WCZ4aw+AasWkqQH9WxvSu+z6Tj9IvwPWNV56gThqDiKsA+sVC8xOw6oUFXjiu+kFxxuPeQI=
Received: from DM6PR02CA0132.namprd02.prod.outlook.com (2603:10b6:5:1b4::34)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:05 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::68) by DM6PR02CA0132.outlook.office365.com
 (2603:10b6:5:1b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:05 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:02 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/47] drm/amd/display: Add missing dcn35 RCO registers
Date: Fri, 1 Dec 2023 06:25:01 -0700
Message-ID: <20231201132731.2354141-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CH0PR12MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a552f6-6730-406b-ba61-08dbf27159b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNtqRjT1oAVx8+hAM95cmnzatOQRzJkhp86Z6KfTAQiE22TPU7uymmrd21gqpT4dOs0aOG5YCqZ7x+ffhqk3bbZ8CbKVfTEA63ieuE/eGzp/6aIM5HpJiaXMbZziYpuxNGS9XVkrtyxqVdWGtg9HDozZ47xg1r3FCgfEdx+tFhBSzGnCsKCS3SZyXO7bvHMM5Q4OqhhAPdcSW7RGopAzZ5MVWE581jolGpTlru14aZjerHZR+a3Gu2gols3ExknyhvPvwshdPzzxtu1PsRw4ZvqaQGOk1wtNPRpvOWE3V7sy0xQYWO3opN5Wo50bXg03xGyE4M6Wsd0S7ve7Lfaf4IGWFmIafYDhkGC3thFOag+ZXrkX9phe+JKztDuqZFEGLZ/bbDF+ezVN6P/qNi8nGYZieESVM/JMKHXsybDqeWVX14uM+OOQ7ERt/sURJbpi+PNjTAJvMv15aAHD/cWidnfhuewcGBMP/kDE151XWyTzCuRLqba67NsWq2yxAGl3UH9vZfNy+lS67HWUo2l3ohwl17XpmpDQsglqOWTuq6m6m5VUQtThuwYzNaRYqZkzaG1uFBpXQ5PUPKbDKbSXAu6egHMzt852I0V0FjR1KAn2jXV3YkrgPnSIDIxl8QvK/c65DsEjKfEGII8dm1rZQzK9WjvyqHYy4BlR884dlBuJ6oI+757e1Ku50nA1Yvv2c8qcRm6GBSsi2NQRzMYmNyjiW4q1FklT+OQREklbvT+EwulGjAL9C/Z6jCULUrFUM1TbGyIVHUSzoypQyM9i2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(86362001)(70586007)(70206006)(54906003)(6916009)(356005)(81166007)(82740400003)(36756003)(26005)(47076005)(36860700001)(83380400001)(336012)(1076003)(16526019)(2616005)(426003)(2906002)(316002)(478600001)(8936002)(5660300002)(8676002)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:05.2518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a552f6-6730-406b-ba61-08dbf27159b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>, jerry.zuo@amd.com,
 Charlene Liu <charlene.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why]
Some registers needed for root clock gating in dcn35 are not defined in
the dccg header.

[How]
Add the needed registers and temporarily disable some register writes
that are now taking place successfully until the registers can be
properly enabled.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h | 32 ++++++++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 62 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h | 51 +++++++++++++++
 3 files changed, 143 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 76da59d8caaf..ef5c22f41563 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -296,6 +296,38 @@
 	type DTBCLK_P1_GATE_DISABLE;\
 	type DTBCLK_P2_GATE_DISABLE;\
 	type DTBCLK_P3_GATE_DISABLE;\
+	type DSCCLK0_ROOT_GATE_DISABLE;\
+	type DSCCLK1_ROOT_GATE_DISABLE;\
+	type DSCCLK2_ROOT_GATE_DISABLE;\
+	type DSCCLK3_ROOT_GATE_DISABLE;\
+	type SYMCLKA_FE_ROOT_GATE_DISABLE;\
+	type SYMCLKB_FE_ROOT_GATE_DISABLE;\
+	type SYMCLKC_FE_ROOT_GATE_DISABLE;\
+	type SYMCLKD_FE_ROOT_GATE_DISABLE;\
+	type SYMCLKE_FE_ROOT_GATE_DISABLE;\
+	type DPPCLK0_ROOT_GATE_DISABLE;\
+	type DPPCLK1_ROOT_GATE_DISABLE;\
+	type DPPCLK2_ROOT_GATE_DISABLE;\
+	type DPPCLK3_ROOT_GATE_DISABLE;\
+	type HDMISTREAMCLK0_ROOT_GATE_DISABLE;\
+	type SYMCLKA_ROOT_GATE_DISABLE;\
+	type SYMCLKB_ROOT_GATE_DISABLE;\
+	type SYMCLKC_ROOT_GATE_DISABLE;\
+	type SYMCLKD_ROOT_GATE_DISABLE;\
+	type SYMCLKE_ROOT_GATE_DISABLE;\
+	type PHYA_REFCLK_ROOT_GATE_DISABLE;\
+	type PHYB_REFCLK_ROOT_GATE_DISABLE;\
+	type PHYC_REFCLK_ROOT_GATE_DISABLE;\
+	type PHYD_REFCLK_ROOT_GATE_DISABLE;\
+	type PHYE_REFCLK_ROOT_GATE_DISABLE;\
+	type DPSTREAMCLK0_ROOT_GATE_DISABLE;\
+	type DPSTREAMCLK1_ROOT_GATE_DISABLE;\
+	type DPSTREAMCLK2_ROOT_GATE_DISABLE;\
+	type DPSTREAMCLK3_ROOT_GATE_DISABLE;\
+	type DPSTREAMCLK0_GATE_DISABLE;\
+	type DPSTREAMCLK1_GATE_DISABLE;\
+	type DPSTREAMCLK2_GATE_DISABLE;\
+	type DPSTREAMCLK3_GATE_DISABLE;\
 
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 142efd390d86..f1ba7bb792ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -506,6 +506,64 @@ static void dccg35_dpp_root_clock_control(
 	dccg->dpp_clock_gated[dpp_inst] = !clock_on;
 }
 
+static void dccg35_disable_symclk32_se(
+		struct dccg *dccg,
+		int hpo_se_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* set refclk as the source for symclk32_se */
+	switch (hpo_se_inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE0_SRC_SEL, 0,
+				SYMCLK32_SE0_EN, 0);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se) {
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE0_GATE_DISABLE, 0);
+//			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+//					SYMCLK32_ROOT_SE0_GATE_DISABLE, 0);
+		}
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE1_SRC_SEL, 0,
+				SYMCLK32_SE1_EN, 0);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se) {
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE1_GATE_DISABLE, 0);
+//			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+//					SYMCLK32_ROOT_SE1_GATE_DISABLE, 0);
+		}
+		break;
+	case 2:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE2_SRC_SEL, 0,
+				SYMCLK32_SE2_EN, 0);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se) {
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE2_GATE_DISABLE, 0);
+//			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+//					SYMCLK32_ROOT_SE2_GATE_DISABLE, 0);
+		}
+		break;
+	case 3:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE3_SRC_SEL, 0,
+				SYMCLK32_SE3_EN, 0);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se) {
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE3_GATE_DISABLE, 0);
+//			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+//					SYMCLK32_ROOT_SE3_GATE_DISABLE, 0);
+		}
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
 void dccg35_init(struct dccg *dccg)
 {
 	int otg_inst;
@@ -514,7 +572,7 @@ void dccg35_init(struct dccg *dccg)
 	 * will cause DCN to hang.
 	 */
 	for (otg_inst = 0; otg_inst < 4; otg_inst++)
-		dccg31_disable_symclk32_se(dccg, otg_inst);
+		dccg35_disable_symclk32_se(dccg, otg_inst);
 
 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
 		for (otg_inst = 0; otg_inst < 2; otg_inst++)
@@ -788,7 +846,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.dccg_init = dccg35_init,
 	.set_dpstreamclk = dccg35_set_dpstreamclk,
 	.enable_symclk32_se = dccg31_enable_symclk32_se,
-	.disable_symclk32_se = dccg31_disable_symclk32_se,
+	.disable_symclk32_se = dccg35_disable_symclk32_se,
 	.enable_symclk32_le = dccg31_enable_symclk32_le,
 	.disable_symclk32_le = dccg31_disable_symclk32_le,
 	.set_symclk32_le_root_clock_gating = dccg31_set_symclk32_le_root_clock_gating,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h
index bde48bee0119..1586a45ca3bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h
@@ -34,6 +34,7 @@
 #define DCCG_REG_LIST_DCN35() \
 	DCCG_REG_LIST_DCN314(),\
 	SR(DPPCLK_CTRL),\
+	SR(DCCG_GATE_DISABLE_CNTL4),\
 	SR(DCCG_GATE_DISABLE_CNTL5),\
 	SR(DCCG_GATE_DISABLE_CNTL6),\
 	SR(DCCG_GLOBAL_FGCG_REP_CNTL),\
@@ -180,6 +181,56 @@
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P1_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P2_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DSCCLK0_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DSCCLK1_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DSCCLK2_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DSCCLK3_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_FE_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_FE_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_FE_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_FE_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_FE_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DPPCLK0_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DPPCLK1_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DPPCLK2_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, DPPCLK3_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, HDMICHARCLK0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, HDMICHARCLK0_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL6, HDMISTREAMCLK0_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE2_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE2_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_LE0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_LE1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, PHYA_REFCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, PHYB_REFCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, PHYC_REFCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, PHYD_REFCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL4, PHYE_REFCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK0_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK1_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK2_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK3_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK0_DTO_PARAM, HDMISTREAMCLK0_DTO_PHASE, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK0_DTO_PARAM, HDMISTREAMCLK0_DTO_MODULO, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL, DISPCLK_DCCG_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, HDMISTREAMCLK0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK2_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK3_GATE_DISABLE, mask_sh),\
 
 struct dccg *dccg35_create(
 		struct dc_context *ctx,
-- 
2.42.0

