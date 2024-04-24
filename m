Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69378C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FE910FE18;
	Wed, 24 Apr 2024 08:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I/bL/HAk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70AE310FE19
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1rhjlr3vXhip0a0TgiMo/E7uRjiT7OeSynniMO2a+vUFr286Z2fV/VTEfSXS7qcpw155joXhwX2zv7/8W3QsfDwgJ+5ps112BNX4B52U0G3EltPvEoBZH7QmmRtRfj1Pe5jMduJT3MvyGEcfF5y0ea3pXISsx0Lj989wpsLeRDOysfym9RC+sDvyjjTPfOEL8QdqxmJJy4xAIHAjroW7SnXD3F0l5t8lTCEk1yuMO/u3ePkdOL3Y2zzvjczq49phxpSZAmLXRmRi3FVXDBnBGPkXUBE28vyqcg0piQ9VuEzfwZMa4DHAkcP05UhIemSS3OWV7MDnIZH7NhoFtSFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLKKfL9h9iKVpb20/mPJNu92IHhBqEEQuSIKqXDcUBA=;
 b=EGkVN/kgMDwp+2F4+r+I7DaFg8AuTOLGm8URhKM+SO8/+ybf6XW4ShSWkBvIkUL6TyJowGfJoKHL6EGPABXak+bRntSMte69dErHXoJLiVfZDU30tns17uMr5XpOPFIbYxsnuIQJnMdm0voTHswhL8LRNsT9MKw3Xg+kUwRYBzgHu50P3n17G8y/twUqAe6eTUwETbnaln2obaXxvyJm/wAcUXYuMoJ2Kb72zRlb4JNlPl4h7WHKUuQCRKdNynTlyGrXHnOsvVZpp/mEotLJ+x4y3JsZkaw9KOU007MbC05fN3FUYwW99qzJu5k+H/GOrJpOXZWCl89dTeKgzeHPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLKKfL9h9iKVpb20/mPJNu92IHhBqEEQuSIKqXDcUBA=;
 b=I/bL/HAkz3uEXuA9vMvW6QixBY1orbyXRwRFHzNmPhFsCrLe8bJGPBpOWX+r+DfhK30vQSEHFrGK+4ecaFEwkiIj4nEb/o31WTrFqj3nUtomJMZ9I3UYMOwdEiTJwFKh7ElVZguD+sm66NxgQTnxxb5e9NgcqHccHEAc/IQGPn4=
Received: from BN6PR17CA0029.namprd17.prod.outlook.com (2603:10b6:405:75::18)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:52:57 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:405:75:cafe::3f) by BN6PR17CA0029.outlook.office365.com
 (2603:10b6:405:75::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:55 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Daniel Miess
 <daniel.miess@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 28/46] drm/amd/display: Enable RCO for PHYSYMCLK in DCN35
Date: Wed, 24 Apr 2024 16:49:13 +0800
Message-ID: <20240424084931.2656128-29-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 3920e4ff-a3ee-49ac-29b6-08dc643bef9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gti915w3+rKdxZCF9yD60srBbBcH9wJ4c4+DqahcX3y6Qa5POTJVH7HyhwaX?=
 =?us-ascii?Q?PmhTLgCxuawJg8saiD0StSSCoh/7rvffSrLIzZuC1HE1INQX2CzdNYLYQZ+l?=
 =?us-ascii?Q?axVLqRxbha6A7QzV2gH0OJdXCnRncrMnP72hFXB0MqzFn27Ibz6eItIjZLI3?=
 =?us-ascii?Q?fwAwS+5pJTjAA+WQjRiJySnDkzh/71n9DDyiLDcG4t9EWiMGvFcqpQtLkoku?=
 =?us-ascii?Q?mmUXtT3FLWLAD9be1tT6DLxJ0G6K1Ziy+VwG6XlUV12/T+z4BcBkg39Fqmk4?=
 =?us-ascii?Q?sPx0lOpsjf28I62+qUp1fFexWcY3q4IdH24FOqMdv5K0lMRL/xELqBSbG1BF?=
 =?us-ascii?Q?WUHlLsOIS/qy7U3zMROJJJLSwEgL1czRfkgC+H5cRLqx+CYJNKI2AqhVIomB?=
 =?us-ascii?Q?oGVH1O8ev2DFQxXd9YmoyY+xVJzc/iOTDrO/0X2WERHERLG7Dm/wF+Z9IMF3?=
 =?us-ascii?Q?SnTFqppRzArQ8F6UJHL86SqKN45Szzc7C1LeK7X25r67RHL9Dg2G5p0Ivyfk?=
 =?us-ascii?Q?XoVqSViVhczvpvDbGFQLDTJmgh2XzUBQtfe9NpDXtzS7Lnd0YukE/Q+sHNLa?=
 =?us-ascii?Q?s2a7BLD+PbJ/eFwXERHAuPs3AcepdlMqSH72kdeVETluksAcJbWrr5wQkeFy?=
 =?us-ascii?Q?ueOf4RhnCIHQoybivuR6rhzIUVgdvq2rnmsKQUHqocUeXWG0CZsIM5UjrXgb?=
 =?us-ascii?Q?aMX5szVC/U1u9L4SyMiIKCRmwO394oEKDbEtiAHeV3FYSwDcq+iVES1ebAzD?=
 =?us-ascii?Q?c0vNhplJH3J44/5zJ1RJzMIbRDfOp3z8eQujDwnHp9eLOd7dOJm0hmOb2QwC?=
 =?us-ascii?Q?SFbS++Za3AKMpxZ/jjidSkbL5lUFZ5cKgt9tLhQiPzjoRqk7SHHs6nX0dpDd?=
 =?us-ascii?Q?gvjgLPUW0zztcp3H9HJaLTtSrTHCO7cPvQ6VXwRkqP0lYqz61BN++tYFfQ5U?=
 =?us-ascii?Q?dQkTD4pLioUw6LlaR3hNgmMqCqoCs1FzozRgXgPRiFYYoktuO6PRc+71ZN4b?=
 =?us-ascii?Q?NCuiZHuBHkmuJz7M6eifG6KaX0OJt6CZvh00f7q4Xehems3scZLW313piULj?=
 =?us-ascii?Q?v5wuDZRif+0FiJgBhCB2c8jCQ+py/EoNnG1oL5b90/+ztd2PI/WvWCzMCnqz?=
 =?us-ascii?Q?8XZ4UNRZNBGhHvv/G2noTwKw/YZyaRAeBJR0BThd75Hy2frDX0DTaW7hYQiD?=
 =?us-ascii?Q?0iIWtYQYH6FrNQuTAM//MzU4kP1SXz50BmmbILUDiDvWPMYgCW7jqhvhnse7?=
 =?us-ascii?Q?lA4J0LdbggPF0d92ks8auN8iAoo2sxo4U1hGXR8bB8veQhP8sXwByOV3Tx6c?=
 =?us-ascii?Q?Fjmi+FFCYNJM3Rgk7zcFsHyfPeuc4MY3E648/UpmNkH5vEIkcINuiLrxlZ/R?=
 =?us-ascii?Q?74ZN8M4tWtI5vmORs/AX93JCAetI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:56.5136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3920e4ff-a3ee-49ac-29b6-08dc643bef9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316
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

From: Daniel Miess <daniel.miess@amd.com>

[Why & How]
Enable root clock optimization for PHYSYMCLK and only
disable it when it's actively being used

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 45 -------------------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 32 +++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
 .../display/dc/hwss/hw_sequencer_private.h    |  4 ++
 7 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3048d5a0e87d..dd8940c2a4bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -724,6 +724,7 @@ enum pg_hw_pipe_resources {
 	PG_OPTC,
 	PG_DPSTREAM,
 	PG_HDMISTREAM,
+	PG_PHYSYMCLK,
 	PG_HW_PIPE_RESOURCES_NUM_ELEMENT
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 4b282b7e0996..795320a25fd2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -461,32 +461,22 @@ static void dccg35_set_physymclk_root_clock_gating(
 	case 0:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
 				PHYASYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
-//		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//				PHYA_REFCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
 		break;
 	case 1:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
 				PHYBSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
-//		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//				PHYB_REFCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
 		break;
 	case 2:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
 				PHYCSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
-//		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//				PHYC_REFCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
 		break;
 	case 3:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
 				PHYDSYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
-//		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//				PHYD_REFCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
 		break;
 	case 4:
 		REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
 				PHYESYMCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
-//		REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//				PHYE_REFCLK_ROOT_GATE_DISABLE, enable ? 1 : 0);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
@@ -509,16 +499,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
 					PHYASYMCLK_EN, 1,
 					PHYASYMCLK_SRC_SEL, clk_src);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYA_REFCLK_ROOT_GATE_DISABLE, 0);
 		} else {
 			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
 					PHYASYMCLK_EN, 0,
 					PHYASYMCLK_SRC_SEL, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYA_REFCLK_ROOT_GATE_DISABLE, 1);
 		}
 		break;
 	case 1:
@@ -526,16 +510,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
 					PHYBSYMCLK_EN, 1,
 					PHYBSYMCLK_SRC_SEL, clk_src);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYB_REFCLK_ROOT_GATE_DISABLE, 0);
 		} else {
 			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
 					PHYBSYMCLK_EN, 0,
 					PHYBSYMCLK_SRC_SEL, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYB_REFCLK_ROOT_GATE_DISABLE, 1);
 		}
 		break;
 	case 2:
@@ -543,16 +521,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
 					PHYCSYMCLK_EN, 1,
 					PHYCSYMCLK_SRC_SEL, clk_src);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYC_REFCLK_ROOT_GATE_DISABLE, 0);
 		} else {
 			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
 					PHYCSYMCLK_EN, 0,
 					PHYCSYMCLK_SRC_SEL, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYC_REFCLK_ROOT_GATE_DISABLE, 1);
 		}
 		break;
 	case 3:
@@ -560,16 +532,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
 					PHYDSYMCLK_EN, 1,
 					PHYDSYMCLK_SRC_SEL, clk_src);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYD_REFCLK_ROOT_GATE_DISABLE, 0);
 		} else {
 			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
 					PHYDSYMCLK_EN, 0,
 					PHYDSYMCLK_SRC_SEL, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYD_REFCLK_ROOT_GATE_DISABLE, 1);
 		}
 		break;
 	case 4:
@@ -577,16 +543,10 @@ static void dccg35_set_physymclk(
 			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
 					PHYESYMCLK_EN, 1,
 					PHYESYMCLK_SRC_SEL, clk_src);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYE_REFCLK_ROOT_GATE_DISABLE, 0);
 		} else {
 			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
 					PHYESYMCLK_EN, 0,
 					PHYESYMCLK_SRC_SEL, 0);
-//			if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-//				REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
-//						PHYE_REFCLK_ROOT_GATE_DISABLE, 1);
 		}
 		break;
 	default:
@@ -724,11 +684,6 @@ void dccg35_init(struct dccg *dccg)
 			dccg35_set_dpstreamclk_root_clock_gating(dccg, otg_inst, false);
 		}
 
-	if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
-		for (otg_inst = 0; otg_inst < 5; otg_inst++)
-			dccg35_set_physymclk_root_clock_gating(dccg, otg_inst,
-					false);
-
 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
 		for (otg_inst = 0; otg_inst < 4; otg_inst++)
 			dccg35_set_dppclk_root_clock_gating(dccg, otg_inst, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index b94a85380d73..dea7e63a49d9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -506,6 +506,17 @@ void dcn35_dpstream_root_clock_control(struct dce_hwseq *hws, unsigned int dp_hp
 	}
 }
 
+void dcn35_physymclk_root_clock_control(struct dce_hwseq *hws, unsigned int phy_inst, bool clock_on)
+{
+	if (!hws->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+		return;
+
+	if (hws->ctx->dc->res_pool->dccg->funcs->set_physymclk_root_clock_gating) {
+		hws->ctx->dc->res_pool->dccg->funcs->set_physymclk_root_clock_gating(
+			hws->ctx->dc->res_pool->dccg, phy_inst, clock_on);
+	}
+}
+
 void dcn35_dsc_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int dsc_inst,
@@ -1020,6 +1031,13 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 		if (pipe_ctx->stream_res.hpo_dp_stream_enc)
 			update_state->pg_pipe_res_update[PG_DPSTREAM][pipe_ctx->stream_res.hpo_dp_stream_enc->inst] = false;
 	}
+
+	for (i = 0; i < dc->link_count; i++) {
+		update_state->pg_pipe_res_update[PG_PHYSYMCLK][i] = true;
+		if (dc->links[i]->type != dc_connection_none)
+			update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] = false;
+	}
+
 	/*domain24 controls all the otg, mpc, opp, as long as one otg is still up, avoid enabling OTG PG*/
 	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
 		struct timing_generator *tg = dc->res_pool->timing_generators[i];
@@ -1117,6 +1135,10 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		}
 	}
 
+	for (i = 0; i < dc->link_count; i++)
+		if (dc->links[i]->type != dc_connection_none)
+			update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] = true;
+
 	for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++) {
 		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i] &&
 				dc->res_pool->hpo_dp_stream_enc[i]) {
@@ -1267,6 +1289,11 @@ void dcn35_root_clock_control(struct dc *dc,
 					dc->hwseq->funcs.dpstream_root_clock_control(dc->hwseq, i, power_on);
 		}
 
+		for (i = 0; i < dc->res_pool->dig_link_enc_count; i++)
+			if (update_state->pg_pipe_res_update[PG_PHYSYMCLK][i])
+				if (dc->hwseq->funcs.physymclk_root_clock_control)
+					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
+
 	}
 	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
 		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
@@ -1292,6 +1319,11 @@ void dcn35_root_clock_control(struct dc *dc,
 					dc->hwseq->funcs.dpstream_root_clock_control(dc->hwseq, i, power_on);
 		}
 
+		for (i = 0; i < dc->res_pool->dig_link_enc_count; i++)
+			if (update_state->pg_pipe_res_update[PG_PHYSYMCLK][i])
+				if (dc->hwseq->funcs.physymclk_root_clock_control)
+					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
+
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index a731c8880d60..bc05beba5f2c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -39,6 +39,8 @@ void dcn35_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst,
 
 void dcn35_dpstream_root_clock_control(struct dce_hwseq *hws, unsigned int dp_hpo_inst, bool clock_on);
 
+void dcn35_physymclk_root_clock_control(struct dce_hwseq *hws, unsigned int phy_inst, bool clock_on);
+
 void dcn35_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
 void dcn35_set_dmu_fgcg(struct dce_hwseq *hws, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 0e87f3503265..7f2cbfac9099 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -149,6 +149,7 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.enable_power_gating_plane = dcn35_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
+	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn35_update_odm,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index ff772665d1ae..91484b71b7da 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -148,6 +148,7 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.enable_power_gating_plane = dcn35_enable_power_gating_plane,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
+	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn35_update_odm,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 939832372baf..7553d6816d36 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -124,6 +124,10 @@ struct hwseq_private_funcs {
 			struct dce_hwseq *hws,
 			unsigned int dpp_inst,
 			bool clock_on);
+	void (*physymclk_root_clock_control)(
+			struct dce_hwseq *hws,
+			unsigned int phy_inst,
+			bool clock_on);
 	void (*dpp_pg_control)(struct dce_hwseq *hws,
 			unsigned int dpp_inst,
 			bool power_on);
-- 
2.37.3

