Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32602C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0254961040
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0254961040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86FE86EDE2;
	Fri, 15 Oct 2021 18:44:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E8A6EDE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+aqK8Dmfbk2CZArhevrR39si88dAxAXJ4+kMyr+Uqp4oAUFG28RCDBP+LlAS+FsKN92wHIdl0qFubLBp8X86IAhLVclb4uH8nCxuO0Z3iV/zhlkIeXExM453K2qwflQRpFgOzABs9ZVU8yWY5kQ44U0rT+BWnP8WFoM1LNm8G240XD/HTmbBkYoNcU9jnMNdVN5mTRMliM2l1ZwIi50mlK3r3YRiBI6YFy151N2gdyRtbzJj5ocD8tIY495Mtmdogljg9aoWkkSMwcgjlqRlItqy55rvLqFqkMkEyx2YsvemWHgVsUchS3MutJJ4MDpN3OcGuukzi9RWMidW2rB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smabCP0zAkqBGI3d5FZvu1cNSdSMe+eHFXZEzlQiucQ=;
 b=OLyTNcs/yN210Wi8SXCTI1vh2UWnJP0OnqHNWMKOltSUV+Ihc2neS/OUsVNomvLosi8FBH9jBfsxPFogdlY+LFRLBnYlpvpLzq4GtPYFu3j30pXaSEYYzqedJfx/g0AdsJcEdATle0YNsdVkA/ASd/osWOuwRrUcOy/Cnls0jTnBpWBiYbst6+rn5ahE/wL++Q16AByh9IHFCcZNFeRCd/qMgjo65RLLcDi6LtCy3rC5haGpYM4iLZkbdjuI0wgCLy5BvRAWkd5ybCP3zSyGaSVSNAWZqUCkFLLaUmOTjlcDoy19n3Dvb9T0OKKswKkbw8fKJT2QCUjRjZSuRgkzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smabCP0zAkqBGI3d5FZvu1cNSdSMe+eHFXZEzlQiucQ=;
 b=iZyCRMSmxWHtADHTj2B2nMK8tTSGIErDlmJQp5+mEhp7aJIB27FV4zPhl1EEx5XIC7aqGjAEVci+ufI7Akv/E5gALXACmz0BJD2XipyhCJcFUykBu+q32o+W88/rFBZJdB9TMhM+7lKWiZHNpyZtkAaw3IssyuxdhZxH+ywBnSc=
Received: from DS7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:8:54::27) by
 MWHPR12MB1374.namprd12.prod.outlook.com (2603:10b6:300:12::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 18:44:10 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::8a) by DS7PR06CA0047.outlook.office365.com
 (2603:10b6:8:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:09 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:05 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jake Wang <haonan.wang2@amd.com>, "Ariel
 Bernstein" <eric.yang2@amd.com>
Subject: [PATCH 18/27] drm/amd/display: Disable dpstreamclk, symclk32_se,
 and symclk32_le
Date: Fri, 15 Oct 2021 14:43:23 -0400
Message-ID: <20211015184332.221091-19-agustin.gutierrez@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8a0ca54b-e60c-47c1-9431-08d9900bc69b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1374:
X-Microsoft-Antispam-PRVS: <MWHPR12MB13740EF2E97572D1D565B91DF5B99@MWHPR12MB1374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHvQ621RHuK86QrupkKiHACX7WSP+OzqK8NN99SNEeI+pt/ub7sfnrgXq/NyfQj6LxplL5xcRXaAThktKxD20zZZktDF6b4Ek/ohpFfu4G231AUL0++MnWqgK+h0V/EWN8E3Zf+WaruKP/yBSh5A6oavAk7T/w3/z7hUfFCrgBwdCKgTzodqJhpB6IikKwTGwmQEnD7S+3FRorbctO2eFlqNN6RGq2ji2+LASZ049r/+RKs28KS2sXIsPZoVjE2yYtDSTm07H2FXCezeq1uHTdzbPGR2amGSkQ4kWyxe8NS9CiCuu0E6x0nF3t6m1DygQkACNTzObGh4mEpYjArwHjesHYesl49rj/IBW8vB9tlcV11HyXVVl6Ad5+YIEmVs68opsrhXnCKRRpmqn/NNc/qHqL9Iw+f2LVVq+11H1wK31Dq59I3dBf4y8P9zuY0aiiE3dSgOOVwOaOVdzvwAZkg4/S+TGX5Wyt3sn6oJBQVX75VFCZw0w0stwy9irjVcCTENjFnxvzuvKRgCfiOgReI6jbYEtMoLjRPxFXkoe6Alxx+WeSXgmP5pDXt0l+F4PPw9bhuCs5B5vmX+MSSGfBif0RCr1+Q0v6Jukojb/bMDWb5pC9W89mN/6PFO8wdeZ3IgsTnTqy4bSN4yrnsCRcw8jwqWzMToEnrQhFSR8aJ4tufkQGyA+A48Yp1Tsd/2z79L8Mi5Ja8+W58aD5yd0mJa2r6TC6cslgd+F2JnQDg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(70586007)(70206006)(26005)(186003)(36756003)(316002)(5660300002)(54906003)(6666004)(4326008)(86362001)(6916009)(47076005)(83380400001)(8676002)(2906002)(44832011)(508600001)(356005)(2616005)(426003)(8936002)(81166007)(336012)(82310400003)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:09.9921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0ca54b-e60c-47c1-9431-08d9900bc69b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1374
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
Disable dpstreamclk, symclk32_se, and symclk32_le when not in use.

Reviewed-by: Ariel Bernstein <eric.yang2@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Jake Wang <haonan.wang2@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  15 ++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 107 ++++++++++++++++--
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |  19 +++-
 3 files changed, 130 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index f6f2d48a70c1..4098669a0c1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -178,7 +178,16 @@
 	type DSCCLK2_DTO_MODULO;\
 	type DSCCLK0_DTO_ENABLE;\
 	type DSCCLK1_DTO_ENABLE;\
-	type DSCCLK2_DTO_ENABLE;
+	type DSCCLK2_DTO_ENABLE;\
+	type SYMCLK32_ROOT_SE0_GATE_DISABLE;\
+	type SYMCLK32_ROOT_SE1_GATE_DISABLE;\
+	type SYMCLK32_ROOT_SE2_GATE_DISABLE;\
+	type SYMCLK32_ROOT_SE3_GATE_DISABLE;\
+	type SYMCLK32_ROOT_LE0_GATE_DISABLE;\
+	type SYMCLK32_ROOT_LE1_GATE_DISABLE;\
+	type DPSTREAMCLK_ROOT_GATE_DISABLE;\
+	type DPSTREAMCLK_GATE_DISABLE;
+
 
 
 struct dccg_shift {
@@ -219,6 +228,10 @@ struct dccg_registers {
 	uint32_t DSCCLK0_DTO_PARAM;
 	uint32_t DSCCLK1_DTO_PARAM;
 	uint32_t DSCCLK2_DTO_PARAM;
+	uint32_t DPSTREAMCLK_ROOT_GATE_DISABLE;
+	uint32_t DPSTREAMCLK_GATE_DISABLE;
+	uint32_t DCCG_GATE_DISABLE_CNTL3;
+
 };
 
 struct dcn_dccg {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 3a325e4afe2f..815481a3ef54 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -94,10 +94,7 @@ static enum phyd32clk_clock_source get_phy_mux_symclk(
 	return src;
 }
 
-void dccg31_set_dpstreamclk(
-		struct dccg *dccg,
-		enum hdmistreamclk_source src,
-		int otg_inst)
+static void dccg31_enable_dpstreamclk(struct dccg *dccg, int otg_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
@@ -105,24 +102,69 @@ void dccg31_set_dpstreamclk(
 	switch (otg_inst) {
 	case 0:
 		REG_UPDATE(DPSTREAMCLK_CNTL,
-				DPSTREAMCLK_PIPE0_EN, (src == REFCLK) ? 0 : 1);
+				DPSTREAMCLK_PIPE0_EN, 1);
 		break;
 	case 1:
 		REG_UPDATE(DPSTREAMCLK_CNTL,
-				DPSTREAMCLK_PIPE1_EN, (src == REFCLK) ? 0 : 1);
+				DPSTREAMCLK_PIPE1_EN, 1);
 		break;
 	case 2:
 		REG_UPDATE(DPSTREAMCLK_CNTL,
-				DPSTREAMCLK_PIPE2_EN, (src == REFCLK) ? 0 : 1);
+				DPSTREAMCLK_PIPE2_EN, 1);
 		break;
 	case 3:
 		REG_UPDATE(DPSTREAMCLK_CNTL,
-				DPSTREAMCLK_PIPE3_EN, (src == REFCLK) ? 0 : 1);
+				DPSTREAMCLK_PIPE3_EN, 1);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream)
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			DPSTREAMCLK_ROOT_GATE_DISABLE, 1);
+}
+
+static void dccg31_disable_dpstreamclk(struct dccg *dccg, int otg_inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream)
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+				DPSTREAMCLK_ROOT_GATE_DISABLE, 0);
+
+	switch (otg_inst) {
+	case 0:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE0_EN, 0);
+		break;
+	case 1:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE1_EN, 0);
+		break;
+	case 2:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE2_EN, 0);
+		break;
+	case 3:
+		REG_UPDATE(DPSTREAMCLK_CNTL,
+				DPSTREAMCLK_PIPE3_EN, 0);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg31_set_dpstreamclk(
+		struct dccg *dccg,
+		enum hdmistreamclk_source src,
+		int otg_inst)
+{
+	if (src == REFCLK)
+		dccg31_disable_dpstreamclk(dccg, otg_inst);
+	else
+		dccg31_enable_dpstreamclk(dccg, otg_inst);
 }
 
 void dccg31_enable_symclk32_se(
@@ -137,21 +179,33 @@ void dccg31_enable_symclk32_se(
 	/* select one of the PHYD32CLKs as the source for symclk32_se */
 	switch (hpo_se_inst) {
 	case 0:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_SE0_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE0_SRC_SEL, phyd32clk,
 				SYMCLK32_SE0_EN, 1);
 		break;
 	case 1:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_SE1_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE1_SRC_SEL, phyd32clk,
 				SYMCLK32_SE1_EN, 1);
 		break;
 	case 2:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_SE2_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE2_SRC_SEL, phyd32clk,
 				SYMCLK32_SE2_EN, 1);
 		break;
 	case 3:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_SE3_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE3_SRC_SEL, phyd32clk,
 				SYMCLK32_SE3_EN, 1);
@@ -174,21 +228,33 @@ void dccg31_disable_symclk32_se(
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE0_SRC_SEL, 0,
 				SYMCLK32_SE0_EN, 0);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_SE0_GATE_DISABLE, 0);
 		break;
 	case 1:
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE1_SRC_SEL, 0,
 				SYMCLK32_SE1_EN, 0);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_SE1_GATE_DISABLE, 0);
 		break;
 	case 2:
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE2_SRC_SEL, 0,
 				SYMCLK32_SE2_EN, 0);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_SE2_GATE_DISABLE, 0);
 		break;
 	case 3:
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE3_SRC_SEL, 0,
 				SYMCLK32_SE3_EN, 0);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_SE3_GATE_DISABLE, 0);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
@@ -208,11 +274,17 @@ void dccg31_enable_symclk32_le(
 	/* select one of the PHYD32CLKs as the source for symclk32_le */
 	switch (hpo_le_inst) {
 	case 0:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_LE0_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_LE_CNTL,
 				SYMCLK32_LE0_SRC_SEL, phyd32clk,
 				SYMCLK32_LE0_EN, 1);
 		break;
 	case 1:
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_LE1_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_LE_CNTL,
 				SYMCLK32_LE1_SRC_SEL, phyd32clk,
 				SYMCLK32_LE1_EN, 1);
@@ -235,11 +307,17 @@ void dccg31_disable_symclk32_le(
 		REG_UPDATE_2(SYMCLK32_LE_CNTL,
 				SYMCLK32_LE0_SRC_SEL, 0,
 				SYMCLK32_LE0_EN, 0);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_LE0_GATE_DISABLE, 0);
 		break;
 	case 1:
 		REG_UPDATE_2(SYMCLK32_LE_CNTL,
 				SYMCLK32_LE1_SRC_SEL, 0,
 				SYMCLK32_LE1_EN, 0);
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_ROOT_LE1_GATE_DISABLE, 0);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
@@ -524,6 +602,19 @@ void dccg31_init(struct dccg *dccg)
 	dccg31_disable_symclk32_se(dccg, 1);
 	dccg31_disable_symclk32_se(dccg, 2);
 	dccg31_disable_symclk32_se(dccg, 3);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le) {
+		dccg31_disable_symclk32_le(dccg, 0);
+		dccg31_disable_symclk32_le(dccg, 1);
+	}
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream) {
+		dccg31_disable_dpstreamclk(dccg, 0);
+		dccg31_disable_dpstreamclk(dccg, 1);
+		dccg31_disable_dpstreamclk(dccg, 2);
+		dccg31_disable_dpstreamclk(dccg, 3);
+	}
+
 }
 
 static const struct dccg_funcs dccg31_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index 61b457ab790d..602bf461298b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -65,7 +65,8 @@
 	SR(DSCCLK0_DTO_PARAM),\
 	SR(DSCCLK1_DTO_PARAM),\
 	SR(DSCCLK2_DTO_PARAM),\
-	SR(DSCCLK_DTO_CTRL)
+	SR(DSCCLK_DTO_CTRL),\
+	SR(DCCG_GATE_DISABLE_CNTL3)
 
 
 #define DCCG_MASK_SH_LIST_DCN31(mask_sh) \
@@ -132,7 +133,16 @@
 	DCCG_SF(DSCCLK2_DTO_PARAM, DSCCLK2_DTO_MODULO, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK0_DTO_ENABLE, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK1_DTO_ENABLE, mask_sh),\
-	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_DTO_ENABLE, mask_sh)
+	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_DTO_ENABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, DPSTREAMCLK_ROOT_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, DPSTREAMCLK_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE2_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE1_GATE_DISABLE, mask_sh)
+
 
 
 
@@ -144,6 +154,11 @@ struct dccg *dccg31_create(
 
 void dccg31_init(struct dccg *dccg);
 
+void dccg31_set_dpstreamclk(
+		struct dccg *dccg,
+		enum hdmistreamclk_source src,
+		int otg_inst);
+
 void dccg31_enable_symclk32_se(
 		struct dccg *dccg,
 		int hpo_se_inst,
-- 
2.25.1

