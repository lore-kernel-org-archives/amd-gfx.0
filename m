Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABD1C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A03710E785;
	Wed,  1 Nov 2023 20:09:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCEB710E783
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wy8ULw/aDLqdPRS65ECuWP0qzbS8paniFSPoLGGf6e1J8On7poAg4+upbt+gwJiqS1EpWiABR0FKXa81bhzMlNxP+sMet5z5qeWppgKxYQ4JKKpK4xO0oq0dvf5X2QIiNMTvqoT95cVEO9LvtQCQayI2eH98Fnu6pAI6YoJwRQjYmN8CkM1kMQIBO5F5Ze74qdWfn9450U8uc2tGfKYZJ0GHs7PWHbbrKrJjwamIeYt0YyGhNOFFm6IsUgO6ss6lRhgErjuxujTX78OQPvWXA4AGC5jAFQFZ3qZ0r4rgfaAZHV776I/BCmev9m9XjTtQ0XL5sSkTbwD0nKqr69+gSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTBGuBNMJkpL4OTrhD3sdjMiRbse5RoyzfC9qezXluo=;
 b=T+ksrz3OoW2zcWCVj7ec2WdwJpM07+zcZcrJZIL7wjWIMuBrpkLp5FxMlIGz4oamuGmiJewg3EBG7Yk3bn3EzoxrYr8/JkzGk3Ly5rwPI7HDP7WT2ViMA99h8ublLVLHNXqXvoA7nyMxJIijURqGbe+w/FROQ8YAS4W89skvlaNyb6+51vv5F6QKjrXGPKg7h5Rx8ggDwdzmQ0v/qFrm7gLa60dE1QprKm4enaSXQIuDTuveEyFYgGO3AblMSGz5vOAHqdy25jqo5tTmruHVZtMMyg3CGGk1XhZlgE4JdJAep+NKf7sSyDUXqjyhRy0/c2349zyuqgUIR6iUirPnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTBGuBNMJkpL4OTrhD3sdjMiRbse5RoyzfC9qezXluo=;
 b=SOjqb1WdkmscGfYl73sBGooo4kXdnnFAJwV32OjGXuMSa0CVJ0myg8Gk+79dICWrsBtjqUAlddCtAuPLgs8y0CFcUhdxVumioehYDRBdUd7Hh33/TeBWa+b3mCKXOrHv/DQSSFilWUhEZqAGR/FlwKf3HCAyUUuIGre2zihV6QM=
Received: from MN2PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:160::22)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 20:09:08 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::fd) by MN2PR13CA0009.outlook.office365.com
 (2603:10b6:208:160::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 20:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:09:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:09:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 13:09:05 -0700
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:09:04 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/display: Enable physymclk RCO
Date: Wed, 1 Nov 2023 16:08:30 -0400
Message-ID: <20231101200832.995436-11-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM4PR12MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 51785ece-5303-499e-1979-08dbdb1667f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A70XzHbG4avdr5ytbvemU58VCRBvy4yLDl1lxkFJ09IEf39Gh463/55GnMAbOHd3BQtJzjMXEHXjRtlFRvIIvInJUvZRxJKqbdBTY4kQmt/yPNhSNh+bOF0ieJAHJ8HNN8qaPL2Hlur66jREJ15Zx8I976IMGmGHVSEyH/NAWmiyQa6AtXAo+G0GQo+5p/8LLIcyFCXA6NeRY+HOnfcrSrlUjNXNjEnJnGQGBkOn0izJr88bR0gK1iQMXxAXdUPqx7laErgTIVBFz+hc7LgW3gFcumSL83Cm5SfSsM0u0fR7/YQ2Wz+L98ZNCj+mWJVMB+JEk9dpKNOX6BGVnZacVmaV0IsT6a6aQPFNLpRUrF0v359icMdsJmaSKIzbBRfjOBCF1vr/sNwXKtNjAFCY73Qry8J6e0p3S+IUbN0R050HeVtT5esdDy5L6GuiPyVc+CzJRDR1InyS2/miXm/Wxdt6M2vGvAvu2iP36FcfRgtEII2XsbbFT4LOQp5f6rZd78YYynPiKna9u8n54Y9Ihs4n7silLh2Cg7mYkwfHzdcM52sBCmyMA+WtPsfaJy7DvISw0CoM+rPWz8B2wQQtmIw8Gnlk6xPlpGELxpKsP6YDPvtFbeiJrn6fPNHXykuDNR5fXekQKQXULwo6RDP2SqjL2Crk8r9izhnLP5rK3NxXC7slSByoggYSfm0gQr1dbCtt0upHwjzMPjV5WR26H25dl1Us9pT2dyJjsn0jfxwwdYI7daYXVZPiqPPRQ7TY4FEC9u59B8BawdIr9eC/+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(1076003)(2616005)(26005)(478600001)(426003)(47076005)(6666004)(30864003)(83380400001)(5660300002)(36860700001)(7696005)(4326008)(41300700001)(70586007)(70206006)(316002)(8676002)(8936002)(6916009)(54906003)(356005)(40460700003)(336012)(81166007)(2906002)(36756003)(82740400003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:09:07.9368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51785ece-5303-499e-1979-08dbdb1667f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why]
Enable the last of the RCO options for dcn35

[How]
Breakout RCO from dccg35_set_physymclk so that
physymclk RCO can be set in dccg_init without
disabling physymclk

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 72 ++++++++++---------
 .../drm/amd/display/dc/dcn35/dcn35_resource.c | 20 +++++-
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   | 18 ++++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 24 ++++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  5 ++
 5 files changed, 102 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 277aae811eea..479f3683c0b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -325,6 +325,43 @@ static void dccg35_set_dpstreamclk(
 	}
 }
 
+static void dccg35_set_physymclk_root_clock_gating(
+		struct dccg *dccg,
+		int phy_inst,
+		bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+		return;
+
+	switch (phy_inst) {
+	case 0:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				PHYASYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 1:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				PHYBSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 2:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				PHYCSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 3:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				PHYDSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 4:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
+				PHYESYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
 static void dccg35_set_physymclk(
 		struct dccg *dccg,
 		int phy_inst,
@@ -340,16 +377,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
 					PHYASYMCLK_EN, 1,
 					PHYASYMCLK_SRC_SEL, clk_src);
-			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-					PHYASYMCLK_ROOT_GATE_DISABLE, 1);
 		} else {
 			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
 					PHYASYMCLK_EN, 0,
 					PHYASYMCLK_SRC_SEL, 0);
-			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-					PHYASYMCLK_ROOT_GATE_DISABLE, 0);
 		}
 		break;
 	case 1:
@@ -357,16 +388,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
 					PHYBSYMCLK_EN, 1,
 					PHYBSYMCLK_SRC_SEL, clk_src);
-			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-					PHYBSYMCLK_ROOT_GATE_DISABLE, 1);
 		} else {
 			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
 					PHYBSYMCLK_EN, 0,
 					PHYBSYMCLK_SRC_SEL, 0);
-			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-					PHYBSYMCLK_ROOT_GATE_DISABLE, 0);
 		}
 		break;
 	case 2:
@@ -374,16 +399,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
 					PHYCSYMCLK_EN, 1,
 					PHYCSYMCLK_SRC_SEL, clk_src);
-			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-					PHYCSYMCLK_ROOT_GATE_DISABLE, 1);
 		} else {
 			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
 					PHYCSYMCLK_EN, 0,
 					PHYCSYMCLK_SRC_SEL, 0);
-			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-					PHYCSYMCLK_ROOT_GATE_DISABLE, 0);
 		}
 		break;
 	case 3:
@@ -391,16 +410,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
 					PHYDSYMCLK_EN, 1,
 					PHYDSYMCLK_SRC_SEL, clk_src);
-			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-					PHYDSYMCLK_ROOT_GATE_DISABLE, 1);
 		} else {
 			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
 					PHYDSYMCLK_EN, 0,
 					PHYDSYMCLK_SRC_SEL, 0);
-			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-					PHYDSYMCLK_ROOT_GATE_DISABLE, 0);
 		}
 		break;
 	case 4:
@@ -408,16 +421,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
 					PHYESYMCLK_EN, 1,
 					PHYESYMCLK_SRC_SEL, clk_src);
-			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-					PHYESYMCLK_ROOT_GATE_DISABLE, 1);
 		} else {
 			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
 					PHYESYMCLK_EN, 0,
 					PHYESYMCLK_SRC_SEL, 0);
-			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-				REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
-					PHYESYMCLK_ROOT_GATE_DISABLE, 0);
 		}
 		break;
 	default:
@@ -490,8 +497,8 @@ void dccg35_init(struct dccg *dccg)
 
 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
 		for (otg_inst = 0; otg_inst < 5; otg_inst++)
-			dccg35_set_physymclk(dccg, otg_inst,
-					     PHYSYMCLK_FORCE_SRC_SYMCLK, false);
+			dccg35_set_physymclk_root_clock_gating(dccg, otg_inst,
+					false);
 /*
 	dccg35_enable_global_fgcg_rep(
 		dccg, dccg->ctx->dc->debug.enable_fine_grain_clock_gating.bits
@@ -756,6 +763,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.disable_symclk32_le = dccg31_disable_symclk32_le,
 	.set_symclk32_le_root_clock_gating = dccg31_set_symclk32_le_root_clock_gating,
 	.set_physymclk = dccg35_set_physymclk,
+	.set_physymclk_root_clock_gating = dccg35_set_physymclk_root_clock_gating,
 	.set_dtbclk_dto = dccg35_set_dtbclk_dto,
 	.set_audio_dtbclk_dto = dccg31_set_audio_dtbclk_dto,
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index e35d4c028d01..9fb8d2fa5e53 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -610,7 +610,23 @@ static struct dce_hwseq_registers hwseq_reg;
 	HWS_SF(, DMU_CLK_CNTL, LONO_FGCG_REP_DIS, mask_sh),\
 	HWS_SF(, DMU_CLK_CNTL, LONO_DISPCLK_GATE_DISABLE, mask_sh),\
 	HWS_SF(, DMU_CLK_CNTL, LONO_SOCCLK_GATE_DISABLE, mask_sh),\
-	HWS_SF(, DMU_CLK_CNTL, LONO_DMCUBCLK_GATE_DISABLE, mask_sh)
+	HWS_SF(, DMU_CLK_CNTL, LONO_DMCUBCLK_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKA_FE_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKB_FE_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKC_FE_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKD_FE_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKE_FE_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, HDMICHARCLK0_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKA_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKB_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKC_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKD_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKE_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_ROOT_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYBSYMCLK_ROOT_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYCSYMCLK_ROOT_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYDSYMCLK_ROOT_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYESYMCLK_ROOT_GATE_DISABLE, mask_sh)
 
 static const struct dce_hwseq_shift hwseq_shift = {
 		HWSEQ_DCN35_MASK_SH_LIST(__SHIFT)
@@ -725,7 +741,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.symclk32_se = true,
 			.symclk32_le = true,
 			.symclk_fe = true,
-			.physymclk = false, // Prevents eDP light up
+			.physymclk = true,
 			.dpiasymclk = true,
 		}
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
index 2fefdf40612d..44b4df6469d1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
@@ -1183,7 +1183,23 @@ struct dce_hwseq_registers {
 	type LONO_FGCG_REP_DIS;\
 	type LONO_DISPCLK_GATE_DISABLE;\
 	type LONO_SOCCLK_GATE_DISABLE;\
-	type LONO_DMCUBCLK_GATE_DISABLE;
+	type LONO_DMCUBCLK_GATE_DISABLE;\
+	type SYMCLKA_FE_GATE_DISABLE;\
+	type SYMCLKB_FE_GATE_DISABLE;\
+	type SYMCLKC_FE_GATE_DISABLE;\
+	type SYMCLKD_FE_GATE_DISABLE;\
+	type SYMCLKE_FE_GATE_DISABLE;\
+	type HDMICHARCLK0_GATE_DISABLE;\
+	type SYMCLKA_GATE_DISABLE;\
+	type SYMCLKB_GATE_DISABLE;\
+	type SYMCLKC_GATE_DISABLE;\
+	type SYMCLKD_GATE_DISABLE;\
+	type SYMCLKE_GATE_DISABLE;\
+	type PHYASYMCLK_ROOT_GATE_DISABLE;\
+	type PHYBSYMCLK_ROOT_GATE_DISABLE;\
+	type PHYCSYMCLK_ROOT_GATE_DISABLE;\
+	type PHYDSYMCLK_ROOT_GATE_DISABLE;\
+	type PHYESYMCLK_ROOT_GATE_DISABLE;
 
 struct dce_hwseq_shift {
 	HWSEQ_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 0569fa6f7600..5a8258287438 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -146,7 +146,15 @@ void dcn35_init_hw(struct dc *dc)
 	}
 
 	REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-	REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0x3F000000);
+	REG_WRITE(DCCG_GATE_DISABLE_CNTL2,  0);
+
+	/* Disable gating for PHYASYMCLK. This will be enabled in dccg if needed */
+	REG_UPDATE_5(DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_ROOT_GATE_DISABLE, 1,
+			PHYBSYMCLK_ROOT_GATE_DISABLE, 1,
+			PHYCSYMCLK_ROOT_GATE_DISABLE, 1,
+			PHYDSYMCLK_ROOT_GATE_DISABLE, 1,
+			PHYESYMCLK_ROOT_GATE_DISABLE, 1);
+
 	REG_WRITE(DCCG_GATE_DISABLE_CNTL5, 0x1f7c3fcf);
 
 	// Initialize the dccg
@@ -275,7 +283,19 @@ void dcn35_init_hw(struct dc *dc)
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
 		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+
+		REG_UPDATE_5(DCCG_GATE_DISABLE_CNTL2, SYMCLKA_FE_GATE_DISABLE, 0,
+				SYMCLKB_FE_GATE_DISABLE, 0,
+				SYMCLKC_FE_GATE_DISABLE, 0,
+				SYMCLKD_FE_GATE_DISABLE, 0,
+				SYMCLKE_FE_GATE_DISABLE, 0);
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2, HDMICHARCLK0_GATE_DISABLE, 0);
+		REG_UPDATE_5(DCCG_GATE_DISABLE_CNTL2, SYMCLKA_GATE_DISABLE, 0,
+				SYMCLKB_GATE_DISABLE, 0,
+				SYMCLKC_GATE_DISABLE, 0,
+				SYMCLKD_GATE_DISABLE, 0,
+				SYMCLKE_GATE_DISABLE, 0);
+
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 13f12f2a3f81..ce2f0c0e82bd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -141,6 +141,11 @@ struct dccg_funcs {
 			enum physymclk_clock_source clk_src,
 			bool force_enable);
 
+	void (*set_physymclk_root_clock_gating)(
+			struct dccg *dccg,
+			int phy_inst,
+			bool enable);
+
 	void (*set_dtbclk_dto)(
 			struct dccg *dccg,
 			const struct dtbclk_dto_params *params);
-- 
2.25.1

