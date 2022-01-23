Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1F9C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9F910E857;
	Sun, 23 Jan 2022 18:21:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8C410E90C
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf3/+QGESfNSz1C131/iRzzm/zMToaBkuMKeUSyzq6y+I/XxzIEpiCr2jfiinVFTk6mRFgyZfiNZ5mpgILCk0AR5v7VoOwcGPWq+k/nxLupukMaMt1Nh6O+hvIWhv9Ik+HBD/Z1CmCvWtVAnsDeSIfHf84KQw/Q/oXRyZDlEF+Epqrf3TdSVIuat9irvlOk6HrKTDwnfWIjvi1e+dtKRh8yjS+AQj8gC3ft3Fsl66Mf7zPDjuXoPRcbJmicnHs5jNfbgrQJl+62zBYBxtqciAeZIVzFxivzoi0iObMqXGHCX4AqfXOuSMobCKnsXVwbE7EcJiphjajNSt5lFA/hFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDNfyPTPtxo7xHyyBH6JtuTGz/D/UMK2hbFYno3cjzQ=;
 b=XKgxxO2UE8jfcSJCSq4WdpdUB3sGSxbRPY0ePidJRXM5Jsi2Zs+5hFM7AFIiooWzDshKWqSFJIyE9AFuVJAcg5a4nTIHqbaIcvmLnWm9Ji3VKDiVPIVaH1q1A2TJCtQ80Bp0F9FX7IF2lgREm6E6hTcsG9om87faUmWlGXqfASTY6XgLDQZCpZC0+wAK5Vo/7LDhB7OmmA3WH0qGdehHOHyKqTC/ouQcfGRY8Kx2thXYvQnRI50oneUQ7tmqHJP+gEGlX+68Mt3TFGJIKLternCQ+8DoDsbFv4I/qujhd5bztktCEYjDXgFiGkocDDqKwq3zB9wb6B7pKzWFshX0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDNfyPTPtxo7xHyyBH6JtuTGz/D/UMK2hbFYno3cjzQ=;
 b=Ni3yfTEXPm797f9Om92nOPT5cHmQLiE7QcOTausmtLfdYK/H140tyAueVO91FJvUKREWEbN2jtJ87Et+Fm3FM58jWwK5BdkpR6fkw8WwfoLe76qTAhuzwEwN0QNe6a8+rIElk28cKZB2bDY0LVy4T0bu/SaOMpLR7dbiSEKUunY=
Received: from BN9PR03CA0966.namprd03.prod.outlook.com (2603:10b6:408:109::11)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Sun, 23 Jan
 2022 18:21:18 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::57) by BN9PR03CA0966.outlook.office365.com
 (2603:10b6:408:109::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:17 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:15 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/24] drm/amd/display: Disable physym clock
Date: Sun, 23 Jan 2022 13:20:19 -0500
Message-ID: <20220123182021.4154032-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caafa7df-bc92-4499-91d7-08d9de9d25c0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1549A13188F3BBA7E0B2F95A985D9@MWHPR12MB1549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAA6rWI1fnH/PUz4eKd1M8NgpGyVVx8qDWTcgp/SgU6jP54On8C2PPJSF5vO4whgHIdVj1/vJPyxqwzpaZ86ygbWa6VOAJUm5k7ItPDm3UbcyKiGkmsbKP9yZM0D03iqpJkKKU+1GGYASrWYsVkR0OdxZ9lg/4mpIRGXZge8HNgQ6lmKRO5MJKaB8aXRiiIq5THiv9+PF4JxfXgwBQUB/8hmWdxi32x4LhPRqPAangFGiUtlt62H1u5Q+diOsUGBlvYPQvWArJUd9F8sCXLLsSIDiK6/Op8fl7XSV/jjLHaS0CAy8YVON1+/KJdFWgFkCy5kmGCcVhSPhPVDprGeSlSn5/8ji02x6/DDRf4IwDQ2cIHiyAXQRhEEaPrkmMCFDGpOEoY+yLokxlOpxbGlozmFu/DsmxhTLUK0VRP/0zLjjAzq0L/dvb3/QCuH+u/+3kV3zx4HJJl9byD9wi2Tr/d3J9q1QLOM9KKWHHUSvJxPpPWCK9Opeatp5tfcsT+MSVNrAT1RRvoWVQrqtwRGowhf4DhD6PxlqUKbFcsXNZqRgQNE1UlaoX1W7OMNdGo1OdrZc1gfERRfRC7FU3atRjW5ZhtROC8g66ymDbTPhcZrriZRhAkWjFpRHkw5wdacM2Z10cSLKn5aytl9hhXGtr5sloO1/4jIQpR7+WYQnXgiy6QpyHrS/KroMCYbQVyLuZ1IvjYZukxcA++zqtPEFoT6t3mvFwPIL+YXGBbaGg4RRmA8wQy5zcFWgfZhcKAnZfzqhwADDRSjv9fzyH6aA4T3x+jVFTkAwZVJ3sDA5cc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(2616005)(86362001)(6916009)(2906002)(16526019)(186003)(82310400004)(70586007)(4326008)(316002)(36756003)(508600001)(81166007)(426003)(47076005)(1076003)(54906003)(356005)(336012)(83380400001)(5660300002)(70206006)(40460700003)(8936002)(26005)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:17.3776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caafa7df-bc92-4499-91d7-08d9de9d25c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
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
Cc: stylon.wang@amd.com, David Galiffi <David.Galiffi@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[How & Why]
Disable physym clock when it's not in use.

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  8 ++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 62 ++++++++++++++++---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |  5 ++
 3 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 493c47a3d06e..b3c9a9724efd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -196,8 +196,12 @@
 	type HDMISTREAMCLK0_DTO_PHASE;\
 	type HDMISTREAMCLK0_DTO_MODULO;\
 	type HDMICHARCLK0_GATE_DISABLE;\
-	type HDMICHARCLK0_ROOT_GATE_DISABLE;
-
+	type HDMICHARCLK0_ROOT_GATE_DISABLE; \
+	type PHYASYMCLK_GATE_DISABLE; \
+	type PHYBSYMCLK_GATE_DISABLE; \
+	type PHYCSYMCLK_GATE_DISABLE; \
+	type PHYDSYMCLK_GATE_DISABLE; \
+	type PHYESYMCLK_GATE_DISABLE;
 
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 720bd35582b0..287a1066b547 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -420,54 +420,89 @@ void dccg31_set_physymclk(
 	/* Force PHYSYMCLK on and Select phyd32clk as the source of clock which is output to PHY through DCIO */
 	switch (phy_inst) {
 	case 0:
-		if (force_enable)
+		if (force_enable) {
 			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
 					PHYASYMCLK_FORCE_EN, 1,
 					PHYASYMCLK_FORCE_SRC_SEL, clk_src);
-		else
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYASYMCLK_GATE_DISABLE, 1);
+		} else {
 			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
 					PHYASYMCLK_FORCE_EN, 0,
 					PHYASYMCLK_FORCE_SRC_SEL, 0);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYASYMCLK_GATE_DISABLE, 0);
+		}
 		break;
 	case 1:
-		if (force_enable)
+		if (force_enable) {
 			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
 					PHYBSYMCLK_FORCE_EN, 1,
 					PHYBSYMCLK_FORCE_SRC_SEL, clk_src);
-		else
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYBSYMCLK_GATE_DISABLE, 1);
+		} else {
 			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
 					PHYBSYMCLK_FORCE_EN, 0,
 					PHYBSYMCLK_FORCE_SRC_SEL, 0);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYBSYMCLK_GATE_DISABLE, 0);
+		}
 		break;
 	case 2:
-		if (force_enable)
+		if (force_enable) {
 			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
 					PHYCSYMCLK_FORCE_EN, 1,
 					PHYCSYMCLK_FORCE_SRC_SEL, clk_src);
-		else
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYCSYMCLK_GATE_DISABLE, 1);
+		} else {
 			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
 					PHYCSYMCLK_FORCE_EN, 0,
 					PHYCSYMCLK_FORCE_SRC_SEL, 0);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYCSYMCLK_GATE_DISABLE, 0);
+		}
 		break;
 	case 3:
-		if (force_enable)
+		if (force_enable) {
 			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
 					PHYDSYMCLK_FORCE_EN, 1,
 					PHYDSYMCLK_FORCE_SRC_SEL, clk_src);
-		else
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYDSYMCLK_GATE_DISABLE, 1);
+		} else {
 			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
 					PHYDSYMCLK_FORCE_EN, 0,
 					PHYDSYMCLK_FORCE_SRC_SEL, 0);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYDSYMCLK_GATE_DISABLE, 0);
+		}
 		break;
 	case 4:
-		if (force_enable)
+		if (force_enable) {
 			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
 					PHYESYMCLK_FORCE_EN, 1,
 					PHYESYMCLK_FORCE_SRC_SEL, clk_src);
-		else
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYESYMCLK_GATE_DISABLE, 1);
+		} else {
 			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
 					PHYESYMCLK_FORCE_EN, 0,
 					PHYESYMCLK_FORCE_SRC_SEL, 0);
+			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+					PHYESYMCLK_GATE_DISABLE, 0);
+		}
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
@@ -629,6 +664,13 @@ void dccg31_init(struct dccg *dccg)
 		dccg31_disable_dpstreamclk(dccg, 3);
 	}
 
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk) {
+		dccg31_set_physymclk(dccg, 0, PHYSYMCLK_FORCE_SRC_SYMCLK, false);
+		dccg31_set_physymclk(dccg, 1, PHYSYMCLK_FORCE_SRC_SYMCLK, false);
+		dccg31_set_physymclk(dccg, 2, PHYSYMCLK_FORCE_SRC_SYMCLK, false);
+		dccg31_set_physymclk(dccg, 3, PHYSYMCLK_FORCE_SRC_SYMCLK, false);
+		dccg31_set_physymclk(dccg, 4, PHYSYMCLK_FORCE_SRC_SYMCLK, false);
+	}
 }
 
 static const struct dccg_funcs dccg31_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index 4039273872be..269cabbea72a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -136,6 +136,11 @@
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK0_DTO_ENABLE, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK1_DTO_ENABLE, mask_sh),\
 	DCCG_SF(DSCCLK_DTO_CTRL, DSCCLK2_DTO_ENABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYBSYMCLK_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYCSYMCLK_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYDSYMCLK_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL2, PHYESYMCLK_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, DPSTREAMCLK_ROOT_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, DPSTREAMCLK_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE0_GATE_DISABLE, mask_sh),\
-- 
2.25.1

