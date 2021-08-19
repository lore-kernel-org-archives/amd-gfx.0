Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1625C4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 18:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C98F6109E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 18:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C98F6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 177DE6E9CB;
	Thu, 19 Aug 2021 18:59:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 908DB6E9C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 18:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvH4lVmCmOIzWB4DzrDmMMkiSPBs2tqGdBaa2xPIA+Cwb9LvAhCD+clYkq2CKngxMWkIsBk96xUheUF0lvCsRbgD3dn9fjSr48j6Oj/YmWB9aR8XpRuiAL/QqIGqUWDgoX9Wvz6WjlzqRz9hreZZd5toq31kS7jkExFhfXavZwsdsfK5Q2eJRt7iYSC6ajXBdM98Z5eNeO9c6/D5nOKnjXi4kHCntqaPflkz+SmC9q7KdqJwy1jQtnL66zAfJ+oSvINHCVXO2pH71TcjBe6vTFzqRzfCHchS/AOJMjOpXv0p3vEcvhZTto9ClS06pF/ZnvFUOo7E3241B3+25tLbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz0cKoPrSKPKAWCoJcBBey3seuB9aBPnaQq50ya5nNY=;
 b=Cuz34YIUdFnQerKefir267RIl74hCBgwQLcqTrBAbrOnhBE6xEYudrLDearwjgq4Fe8TLMdjubaz3bAhPtPqglpVpHWTrc/DREQog5j/Gtwdw40feAayy8QmKeywRyat6QxuCgfvaIs1mJyFpHDSGxQtGC7RBkGcxb5/uayaZWdxmHnHqlZ8/M3guu4iV4mMUE0qZjrP7vo+dAEZ73n6ILBpw3qInNP1LzcK1dvw9xTL04QqNRyHaNyHnY7F5LKt1GnPSuWWLg56hoLhDSEo4cIOe7x8HW6R80GlqYw3SsszLvBtgcwTSYPqHEC+mVCsTjC5NxtpqZ4N5RFdJtGkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz0cKoPrSKPKAWCoJcBBey3seuB9aBPnaQq50ya5nNY=;
 b=0c2s+kguITFZXsq6BdvX+qInKkr1aXYivU2uHY4goI1quVOlPpFyH+TGDiZIZpunU/i6FAxNlKvmzbD8V81AXQ2LhZhKX/FypIdLJQEv2RIZte1KqkESV6wHgpFBP8sRaw0iSnfW4GLu0lyiw1xN0dR6pcsWTxXDPDwWeDthoy0=
Received: from DM5PR16CA0025.namprd16.prod.outlook.com (2603:10b6:4:15::11) by
 BN7PR12MB2676.namprd12.prod.outlook.com (2603:10b6:408:2d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.19; Thu, 19 Aug 2021 18:59:08 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::be) by DM5PR16CA0025.outlook.office365.com
 (2603:10b6:4:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 18:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 18:59:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 13:59:07 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 19 Aug 2021 13:59:06 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v3 4/6] drm/amd/display: Add DP 2.0 DCCG
Date: Thu, 19 Aug 2021 14:58:38 -0400
Message-ID: <20210819185840.3682559-5-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819185840.3682559-1-Jerry.Zuo@amd.com>
References: <20210819185840.3682559-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4388c92-d009-4159-74a4-08d963436c4b
X-MS-TrafficTypeDiagnostic: BN7PR12MB2676:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2676434F72BDFF6969829FC4E5C09@BN7PR12MB2676.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ly7RLwLIW7c6OTuY5YnjSHfqXjj6Ki79afd/ACSzwwKvUX5+qN1gf0KVZYYIGXyrsl7wSAR4Zw8zY5v3aYoYhvQtpNsYbDc4dAjd6v1lu95AVCsMi//PxJhPLp3XT5TtR/gQJt1uHJWcQr2cIoDq04fThRDrgLWzWSmBDCDWhiaG4r6roH7wq4dpc8uPPWra9xo3lupvXHkDkTvZtfbBMXXHu5ytpSk9KXx7AxjUVlHumSnaJhDrU/yAz8RP1nUYMTvm+AM5tfE2beduNSH6v3Fuau8ht1jjnjRD094NZPhAwT12DVLlYG8R39SneKpYNkB6HUsIYDg6OszSKfyYBIaZIWl52U1eb0aOGKCncAIpccFax/MeYQEHadEGSbVW7qkO1UYVboMbV3rC6xyZoSkZafSU6yipG4HQsDs3+7UdVB3CoVHNviqBHsbKNNbBylvqWc69k8gEIp5fkJekVnnTV0AZOebcT78D3JuGWM0DLDGfrZ4HS6UidrVbX89jK1aGUIW2zUtbG3dCcX04tlMGi6Efmn/xWYNYJVDyYHpNkUmdRLtaKmLRmra2ZeWvW7dlN9HMIIWdQDpnOGi0pd4Mq4l2m1LfHOEa6hUOepBrENFszToVSzj0cS5dItAKYg/7QCbFDk7+kiSQCgtMor9M6GB200A9vNfuOkEOZG4FQnmUAQN7toQ0/qlQO/ZqUbtMS46a9tJLJkrXpN1gruqTxoZ5Pq+YL6F7fv6lFJgCOzqu2sKDrertYs6WyIFt83Z5H7mN7T+MMSCYk3O8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(316002)(36756003)(1076003)(86362001)(5660300002)(2906002)(82310400003)(34020700004)(8676002)(81166007)(8936002)(2616005)(54906003)(426003)(110136005)(336012)(26005)(478600001)(47076005)(83380400001)(70586007)(70206006)(6636002)(82740400003)(36860700001)(186003)(7696005)(356005)(4326008)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 18:59:07.9559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4388c92-d009-4159-74a4-08d963436c4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2676
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

HW Blocks:

        +--------+  +-----+  +------+
        |  OPTC  |  | HDA |  | HUBP |
        +--------+  +-----+  +------+
            |          |        |
            |          |        |
    HPO ====|==========|========|====
     |      |          v        |
     |      |       +-----+     |
     |      |       | APG |     |
     |      |       +-----+     |
     |      |          |        |
     |      v          v        v
     |     +---------------------+
     |     |  HPO Stream Encoder |
     |     +---------------------+
     |                 |
     |                 v
     |      +--------------------+
     |      |  HPO Link Encoder  |
     |      +--------------------+
     |                 |
     v  ===============|=============
                       v
              +------------------+
              |  DIO Output Mux  |
              +------------------+
                       |
                       v
                    +-----+
                    | PHY |
                    +-----+
                       | PHYD32CLK[0]
                       v
                    +------+
                    | DCCG |
                    +------+
                       |
                       v
                   SYMCLK32

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 162 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |  18 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  23 +++
 .../amd/display/dc/inc/hw/timing_generator.h  |   3 +
 4 files changed, 206 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 696c9307715d..9896adf67425 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -42,6 +42,155 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
+void dccg31_set_dpstreamclk(
+		struct dccg *dccg,
+		enum hdmistreamclk_source src,
+		int otg_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* enabled to select one of the DTBCLKs for pipe */
+	switch (otg_inst) {
+	case 0:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE0_EN, (src == REFCLK) ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE1_EN, (src == REFCLK) ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE2_EN, (src == REFCLK) ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE3_EN, (src == REFCLK) ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg31_enable_symclk32_se(
+		struct dccg *dccg,
+		int hpo_se_inst,
+		enum phyd32clk_clock_source phyd32clk)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* select one of the PHYD32CLKs as the source for symclk32_se */
+	switch (hpo_se_inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE0_SRC_SEL, phyd32clk,
+				SYMCLK32_SE0_EN, 1);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE1_SRC_SEL, phyd32clk,
+				SYMCLK32_SE1_EN, 1);
+		break;
+	case 2:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE2_SRC_SEL, phyd32clk,
+				SYMCLK32_SE2_EN, 1);
+		break;
+	case 3:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE3_SRC_SEL, phyd32clk,
+				SYMCLK32_SE3_EN, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg31_disable_symclk32_se(
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
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE1_SRC_SEL, 0,
+				SYMCLK32_SE1_EN, 0);
+		break;
+	case 2:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE2_SRC_SEL, 0,
+				SYMCLK32_SE2_EN, 0);
+		break;
+	case 3:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+				SYMCLK32_SE3_SRC_SEL, 0,
+				SYMCLK32_SE3_EN, 0);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg31_enable_symclk32_le(
+		struct dccg *dccg,
+		int hpo_le_inst,
+		enum phyd32clk_clock_source phyd32clk)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* select one of the PHYD32CLKs as the source for symclk32_le */
+	switch (hpo_le_inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLK32_LE_CNTL,
+				SYMCLK32_LE0_SRC_SEL, phyd32clk,
+				SYMCLK32_LE0_EN, 1);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLK32_LE_CNTL,
+				SYMCLK32_LE1_SRC_SEL, phyd32clk,
+				SYMCLK32_LE1_EN, 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg31_disable_symclk32_le(
+		struct dccg *dccg,
+		int hpo_le_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* set refclk as the source for symclk32_le */
+	switch (hpo_le_inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLK32_LE_CNTL,
+				SYMCLK32_LE0_SRC_SEL, 0,
+				SYMCLK32_LE0_EN, 0);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLK32_LE_CNTL,
+				SYMCLK32_LE1_SRC_SEL, 0,
+				SYMCLK32_LE1_EN, 0);
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
@@ -241,12 +390,25 @@ static void dccg31_set_dispclk_change_mode(
 
 void dccg31_init(struct dccg *dccg)
 {
+	/* Set HPO stream encoder to use refclk to avoid case where PHY is
+	 * disabled and SYMCLK32 for HPO SE is sourced from PHYD32CLK which
+	 * will cause DCN to hang.
+	 */
+	dccg31_disable_symclk32_se(dccg, 0);
+	dccg31_disable_symclk32_se(dccg, 1);
+	dccg31_disable_symclk32_se(dccg, 2);
+	dccg31_disable_symclk32_se(dccg, 3);
 }
 
 static const struct dccg_funcs dccg31_funcs = {
 	.update_dpp_dto = dccg2_update_dpp_dto,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
 	.dccg_init = dccg31_init,
+	.set_dpstreamclk = dccg31_set_dpstreamclk,
+	.enable_symclk32_se = dccg31_enable_symclk32_se,
+	.disable_symclk32_se = dccg31_disable_symclk32_se,
+	.enable_symclk32_le = dccg31_enable_symclk32_le,
+	.disable_symclk32_le = dccg31_disable_symclk32_le,
 	.set_physymclk = dccg31_set_physymclk,
 	.set_dtbclk_dto = dccg31_set_dtbclk_dto,
 	.set_audio_dtbclk_dto = dccg31_set_audio_dtbclk_dto,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index 706ad80ba873..1e5aabcb7799 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -130,6 +130,24 @@ struct dccg *dccg31_create(
 
 void dccg31_init(struct dccg *dccg);
 
+void dccg31_enable_symclk32_se(
+		struct dccg *dccg,
+		int hpo_se_inst,
+		enum phyd32clk_clock_source phyd32clk);
+
+void dccg31_disable_symclk32_se(
+		struct dccg *dccg,
+		int hpo_se_inst);
+
+void dccg31_enable_symclk32_le(
+		struct dccg *dccg,
+		int hpo_le_inst,
+		enum phyd32clk_clock_source phyd32clk);
+
+void dccg31_disable_symclk32_le(
+		struct dccg *dccg,
+		int hpo_le_inst);
+
 void dccg31_set_physymclk(
 		struct dccg *dccg,
 		int phy_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 0afa2364a986..09237d5819f4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -79,7 +79,30 @@ struct dccg_funcs {
 	void (*otg_drop_pixel)(struct dccg *dccg,
 			uint32_t otg_inst);
 	void (*dccg_init)(struct dccg *dccg);
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	void (*set_dpstreamclk)(
+			struct dccg *dccg,
+			enum hdmistreamclk_source src,
+			int otg_inst);
+
+	void (*enable_symclk32_se)(
+			struct dccg *dccg,
+			int hpo_se_inst,
+			enum phyd32clk_clock_source phyd32clk);
+
+	void (*disable_symclk32_se)(
+			struct dccg *dccg,
+			int hpo_se_inst);
+
+	void (*enable_symclk32_le)(
+			struct dccg *dccg,
+			int hpo_le_inst,
+			enum phyd32clk_clock_source phyd32clk);
 
+	void (*disable_symclk32_le)(
+			struct dccg *dccg,
+			int hpo_le_inst);
+#endif
 	void (*set_physymclk)(
 			struct dccg *dccg,
 			int phy_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 03f47f23fb65..7390baf916b5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -100,6 +100,9 @@ enum crc_selection {
 
 enum otg_out_mux_dest {
 	OUT_MUX_DIO = 0,
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	OUT_MUX_HPO_DP = 2,
+#endif
 };
 
 enum h_timing_div_mode {
-- 
2.25.1

