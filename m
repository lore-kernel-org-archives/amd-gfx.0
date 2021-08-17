Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE69EC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 17:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C51E60FD9
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 17:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C51E60FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E946E20C;
	Tue, 17 Aug 2021 17:20:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7943A6E20C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 17:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Blr1gDbO47BQshxPyk/dFfZ3lab4mmfF7lY5Z0U+P/92LACDwY7qE8RQTSENX7XS8bnMU0wPUGnksURTakxqGWWMxXB5raJ+puYtGmuf4q66QMcEb/zUaSYxJABclWbrkUcJxxpNjcRafpipCUtWG4ys6jt2nuB1+ZYntGfaz2FL8lVMxL/cLQfx6S5x9AAFL0UrHQDt9CfLCKTBueYlu+mSCmWKRzQVAPIg0TIuPeRsrMcI2GRlrEYY1J4i3IGe2phupAGsJUyWcX+3lIOBoD4MtP2KJgN/3hoYR4k5TfCPxMlft33RFp38ci6oiWvOk5Y3NdZ5Pw4JADGSa0L8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPBMZkxGFnpg5iTBhE55E6sACvtwg14I5PC1eZdK+vM=;
 b=OtwQgS4hD+q1K6duw36HQb+O4IM07uXVZu8HWBgy9g7OzEiqsImAh15AwgJX4gsaurbkKGerSMkPBswoHZbEIMl0hrYnb8qaoJ+P/ED258HJxdJzb6rF90iDpgmx3aC8zCWJgKpPuHxnjvskxqWBGdladAX6mDu6kFbOcDFZ2JwsNzFYgeTLARmN5BCR+gf2H9cxqwaF0iaML5nuvEHpk5nJAJZx0oeE72Fp8wei65l58sjndYu/NXbLeBMFPh8iOVCWWbLSA8UefEcrU3i0lHBiRTb/mPYf7PgJA8J44usJ9jEskqqQlCIlwrX9PEslfhQPdOSFCCRJ4IcKpqiLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPBMZkxGFnpg5iTBhE55E6sACvtwg14I5PC1eZdK+vM=;
 b=dLRK3Hcp0yrBW3jfZr5Xxou5ekWXj8kTYpllW7Hv4IrzBm8oZ9jeLGTTKq/ZS8vZ9O7auVWtiX4EAfu/tvWUQ1D7LZWb8VfpeUolcV3WfMPWaFzFnulUG0IFQ6s2tUYjJ7MiEBnpkf41lVNk47YLgJdJ+DJO7FbQwYYkSLyGVNo=
Received: from DM3PR03CA0003.namprd03.prod.outlook.com (2603:10b6:0:50::13) by
 MN2PR12MB3120.namprd12.prod.outlook.com (2603:10b6:208:cf::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.15; Tue, 17 Aug 2021 17:20:48 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::ea) by DM3PR03CA0003.outlook.office365.com
 (2603:10b6:0:50::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 17 Aug 2021 17:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 17:20:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 12:20:47 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 17 Aug 2021 12:20:46 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v2 4/6] drm/amd/display: Add DP 2.0 DCCG
Date: Tue, 17 Aug 2021 13:20:04 -0400
Message-ID: <20210817172006.777655-5-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817172006.777655-1-Jerry.Zuo@amd.com>
References: <20210817172006.777655-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b6fbb42-30e4-4988-0dd0-08d961a35ad7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3120:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3120E57E5C6AFECF39FBED52E5FE9@MN2PR12MB3120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X239DzvBIElAVMh5phWHhkLvsGO3InGEH4OAjtl4lG0ELgH2KBIx83yCzlgWUm3KV/GaqU5B6HkjnEzyQmA4tRMvHMZVSwRGTvH0L/IqoIX8LiBFUHUmiUqV5RAxCuZvCb43vJeiQNsC+bQ1qGnmYkeMbTF3S5KGeZNaauGKVnozseG1WgY18YlrNi9i3XQBmNh1x7Ey3NpzGnHb/ZklPGPRrWdlo8WTJ9LUdQJ052kpCVDbOgLS2ecm6kHUyFV+DVEnjIql/AA6vfTce9sZ6C0gIpaZQeyvbHbd2mB9FNzt/PogHwC8exAGtKzIN6f0qdh/ddybtvyN4aRfwzYR8Biu8Efg9ueGZMh1exKRBDHZdvFJr3gnZp4lFebGRGRSWcCD/CFy8sVGnMBLAtL4hH7wA+aV115TwHIb/ABnYfpOxWz/kV9WHu57IkM8D5wtF9uMpIPtynLAMnmxfUkQwoa2H4nxYZdpHNc4oKUFfHyJC8P++C4k5KaJgOiR3P5I9wu3ODrFa2mHPil733HVtE7BmGSgV88PGRhowMUCyboZblp4F6zX141KobK43RAzqWZFIbyMaI7jQ5hsOLohM95lw1TwF1xyaKxovK5T+Q1akA/jSx4+StD9JtVxSXzW18wt0+U3o0SzJaWqEdIgTHZj+ZP5BpkAuRgiC73heohWr0bRcBIDkmYsjbsvfHi6y8c6OQZVtf9ACEDj5vHMYUepv/Tqp9jfoOVWELPYA6WxutvWjHuVaFYYWMv0RCpbIFqymh4tn4r9nrLAxoxxDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(6636002)(54906003)(316002)(110136005)(4326008)(36860700001)(47076005)(7696005)(70206006)(26005)(5660300002)(83380400001)(1076003)(81166007)(2906002)(426003)(2616005)(82740400003)(6666004)(36756003)(478600001)(8936002)(70586007)(8676002)(336012)(186003)(356005)(82310400003)(34020700004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 17:20:48.0303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6fbb42-30e4-4988-0dd0-08d961a35ad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3120
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
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  21 +++
 .../amd/display/dc/inc/hw/timing_generator.h  |   1 +
 4 files changed, 202 insertions(+)

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
index 0afa2364a986..f179af35ef61 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -79,7 +79,28 @@ struct dccg_funcs {
 	void (*otg_drop_pixel)(struct dccg *dccg,
 			uint32_t otg_inst);
 	void (*dccg_init)(struct dccg *dccg);
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
 	void (*set_physymclk)(
 			struct dccg *dccg,
 			int phy_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 03f47f23fb65..1216a71d02ce 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -100,6 +100,7 @@ enum crc_selection {
 
 enum otg_out_mux_dest {
 	OUT_MUX_DIO = 0,
+	OUT_MUX_HPO_DP = 2,
 };
 
 enum h_timing_div_mode {
-- 
2.25.1

