Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72345CAC59B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E784210E7A4;
	Tue, 16 Sep 2025 19:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wo+jc2HU";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630AD10E3DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwaGYnrEF0xbDqR5DNa9CQJJA5Ob0kluFXfC1bweVDr/kAV5x/DGp8QmuktuBet65gyxK7SBTmnjTfOW/RZAMMoXjIUY6twUKhwjqEfwR4ARW25DvQgt4LMHN9gmh7COa/UGMYc7FZ2J+5Ry+7p+4iogePQPFTxA02Ryr5y9CAx2uGATLX+5ANrZAM/DCPkujtMu4WSeEbYFOQhlAlAgBjcbFEMZASodW/jJacnNZyPL2yPVUU1xr51P6j5Yn15jDnhiE/vzICVOWIPqv2SMvu8Q9yZtwb08i4Y1txcnpqtPLMlfki3xJ23VxzSUoNddqfFWHDjPymBDWGcWleGQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l05cOUofJ6iliRLQSMRVEIOdyEx8Cvl1aSNoVdCQpI=;
 b=VTwxujnrQ7BhGSJf+DDtj40FB1fZhYEUgdDIBaIj4/gfQQtCJtPHkMJrnOO9UuIOitN0wba2QubLM14Cn7DEmFARx7yqo892MGQFQouzIA8JozGQXM4TsqpJFWD9RMdAeidNcT56sgRmblGUScX7BxRMR8VaNnPMi9s1mzuWzWc+ndAcI01oSMusGgx95hUj3TWw/9EyN1R67GXhoJOEoMxHulc76OsEMqoi+VVuEnQ9lB5AqAIr4CApVixPcikfaHPvhhmrvBsNOUyQsBCQW6ePRszLTKnSNeN7J3ynwER+4riAxXwUYCsjEYgjrZMaP+Gj/8XOhh9bA1gfFGjUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l05cOUofJ6iliRLQSMRVEIOdyEx8Cvl1aSNoVdCQpI=;
 b=Wo+jc2HURtL2t33nbKbsF26LQBXR+2hqKejDYc6dfN8bRK78+yM0EvP8yNvMRufyCPmkNU32qL74OdacCFqnggIMMlLp5WE8oAVSVmeofuufWk8AcuOUupjvbLo+KPgGseXRqNWH7tFh9ILMmWDMYUCdCKGmRMIbABECeDdzREs=
Received: from BN9PR03CA0134.namprd03.prod.outlook.com (2603:10b6:408:fe::19)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:25 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::36) by BN9PR03CA0134.outlook.office365.com
 (2603:10b6:408:fe::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 19:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:16 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:16 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:15 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>, Yihan Zhu <yihan.zhu@amd.com>
Subject: [PATCH 15/20] drm/amd/display: Insert dccg log for easy debug
Date: Tue, 16 Sep 2025 15:09:35 -0400
Message-ID: <20250916191142.3504643-16-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: b0060b95-3a50-47ba-eeff-08ddf554f880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vh5hB1Cc1u4W3spDH9+2Ja6DN+2B9rx/kKFtd9hzZjzxIbEbHP2cV9LNBcV9?=
 =?us-ascii?Q?CbPYaSia1bZGAHpeOL+B97tOi1YuT1sTPyLrhQzx9q7vjMOPbUem7k5QIV0Y?=
 =?us-ascii?Q?/hmWeuvTPt/j6Nn7e8bovo10HlKCLxXYTXBQ735+FJOgMIbYPdRyZmsFZMv1?=
 =?us-ascii?Q?yuL04lDX5Z7qAbTIX4G9DFRWJriJlnkV9VYJjYxIqoaw4TzQtCg8lENYt6O/?=
 =?us-ascii?Q?yCjAIHkvVJPqIQ7B7fHXWGpscEa9b7gpG/f6dBub6jkqeykBYgwv9tQu3woP?=
 =?us-ascii?Q?5wvg5P8c8Xclu9QE+F1+gaZsvzQAbopB/F4TVHFGLCclc0PS0ro3Og//i8YH?=
 =?us-ascii?Q?ml+6Mo9BsgIcbpoubiWe4+QiDJfqRyc+zAPr8O3FuYBLXckyAkH2X63i3zIl?=
 =?us-ascii?Q?KDZAVBsOwisVkdFl7vetcWRekJpKynZvrIK9KtIzrzizoRteQ0zFwZGx9kmx?=
 =?us-ascii?Q?ipThjs7hGX1g4auutjnf/MakbyrTQnicrh1IzZ5+JzDgP/RM+2rjRdI26ipb?=
 =?us-ascii?Q?QIzSD4iLmFEl1E3UI44B4hEEVSaQsh9rDirco3e3VCPxDO7MGyO+8qOP2HRI?=
 =?us-ascii?Q?Xfgc8KXn0PppG99bmYIIFMh/uy7oIyVcaISrB5pkXAIagu90ZDlzuLlkrKY5?=
 =?us-ascii?Q?deszcMZiKMiLLXXhAoV7tUhYN1VnO20ith6l752sj8qWzHgTOICRt06ZPMV+?=
 =?us-ascii?Q?vpKG5VvI8z8EupF7jOe1gUFz/HOe3M2lKCXYzhCLNGCU3kIRDtQxe2pr4sXt?=
 =?us-ascii?Q?IVAsqVgSU7oVAJmkBXAQzX4CXgPFMegIhrVldjJuSnZ0dZjFeFP/5LHrbaB+?=
 =?us-ascii?Q?aFXCv5UnLQ3UQBLb1LSW4n129Fs3sjvCEcShDpo6AwWaq2sxAsNs2S+xIbDh?=
 =?us-ascii?Q?fn57XqN2bza18bXATB3Yx1Yp3Fkr7RvAQ5mJA6CIMiN28KWdxuuQ5c7y3bcF?=
 =?us-ascii?Q?tMn7QwuOWHpDO62R3I9SBzbAx+IenvmTgVxYHCxv0ur2VHfxFd++9XwMeRMI?=
 =?us-ascii?Q?bJeZboZnxJYpqktLaYf7mAxTxdIfZuCbpodIMoxAuk3XOzJ2G6iRlG/CCc/d?=
 =?us-ascii?Q?tyaqbfhMwxefE7uatSW++QShl/EoaqQTRQRBRv8wPBR/idTdsL/grFJBk38U?=
 =?us-ascii?Q?+AKOHPeTBO8L8lxWWzFHs0E4cE4NIdHQ0TWCVdgxc8F5pCghUkX5xY5uqYlo?=
 =?us-ascii?Q?2DU1dfG2HZNA/rKYz3MHg4nB+i30mrLYaYBVNuz/DcYgy5QsjI1G7FNoUA/u?=
 =?us-ascii?Q?C5vVOdBF6v6VPb8CBuxnXmC9rHulfKkLybya9spc4cv/a4stEaFrCLPFMzbI?=
 =?us-ascii?Q?czXDTSvOic7JuX/qFoKeXInYpFInvvYeAqnf7PXR8aLuXGDgGZ5GUE7klLO6?=
 =?us-ascii?Q?8m5z4vdXHNmlINI9Brie+XPLdGLBmtIx4V/wiARWOgAbBo40+4Z/lClhC1y8?=
 =?us-ascii?Q?/KWO4rMimN44Ke+HDetNgOJBA725OqPHOU91+Vf/vkPD4xfQajv08roDf2Q3?=
 =?us-ascii?Q?fvNmc7+iY3PRRkDQxiTTGRc4L/4JDi+9hRlh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:25.1290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0060b95-3a50-47ba-eeff-08ddf554f880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
Log for sequence tracking

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 0ce9489ac6b7..de6d62401362 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -39,6 +39,7 @@
 
 #define CTX \
 	dccg_dcn->base.ctx
+#include "logger_types.h"
 #define DC_LOGGER \
 	dccg->ctx->logger
 
@@ -1136,7 +1137,7 @@ static void dcn35_set_dppclk_enable(struct dccg *dccg,
 	default:
 		break;
 	}
-	//DC_LOG_DEBUG("%s: dpp_inst(%d) DPPCLK_EN = %d\n", __func__, dpp_inst, enable);
+	DC_LOG_DEBUG("%s: dpp_inst(%d) DPPCLK_EN = %d\n", __func__, dpp_inst, enable);
 
 }
 
@@ -1406,6 +1407,10 @@ static void dccg35_set_dtbclk_dto(
 		 * PIPEx_DTO_SRC_SEL should not be programmed during DTBCLK update since OTG may still be on, and the
 		 * programming is handled in program_pix_clk() regardless, so it can be removed from here.
 		 */
+		DC_LOG_DEBUG("%s: OTG%d DTBCLK DTO enabled: pixclk_khz=%d, ref_dtbclk_khz=%d, req_dtbclk_khz=%d, phase=%d, modulo=%d\n",
+				__func__, params->otg_inst, params->pixclk_khz,
+				params->ref_dtbclk_khz, req_dtbclk_khz, phase, modulo);
+
 	} else {
 		switch (params->otg_inst) {
 		case 0:
@@ -1431,6 +1436,8 @@ static void dccg35_set_dtbclk_dto(
 
 		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
 		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
+
+		DC_LOG_DEBUG("%s: OTG%d DTBCLK DTO disabled\n", __func__, params->otg_inst);
 	}
 }
 
@@ -1475,6 +1482,8 @@ static void dccg35_set_dpstreamclk(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	DC_LOG_DEBUG("%s: dp_hpo_inst(%d) DPSTREAMCLK_EN = %d, DPSTREAMCLK_SRC_SEL = %d\n",
+			__func__, dp_hpo_inst, (src == REFCLK) ? 0 : 1, otg_inst);
 }
 
 
@@ -1514,6 +1523,8 @@ static void dccg35_set_dpstreamclk_root_clock_gating(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	DC_LOG_DEBUG("%s: dp_hpo_inst(%d) DPSTREAMCLK_ROOT_GATE_DISABLE = %d\n",
+			__func__, dp_hpo_inst, enable ? 1 : 0);
 }
 
 
@@ -1553,7 +1564,7 @@ static void dccg35_set_physymclk_root_clock_gating(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
-	//DC_LOG_DEBUG("%s: dpp_inst(%d) PHYESYMCLK_ROOT_GATE_DISABLE:\n", __func__, phy_inst, enable ? 0 : 1);
+	DC_LOG_DEBUG("%s: dpp_inst(%d) PHYESYMCLK_ROOT_GATE_DISABLE: %d\n", __func__, phy_inst, enable ? 0 : 1);
 
 }
 
@@ -1626,6 +1637,8 @@ static void dccg35_set_physymclk(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	DC_LOG_DEBUG("%s: phy_inst(%d) PHYxSYMCLK_EN = %d, PHYxSYMCLK_SRC_SEL = %d\n",
+			__func__, phy_inst, force_enable ? 1 : 0, clk_src);
 }
 
 static void dccg35_set_valid_pixel_rate(
@@ -1673,6 +1686,7 @@ static void dccg35_dpp_root_clock_control(
 	}
 
 	dccg->dpp_clock_gated[dpp_inst] = !clock_on;
+	DC_LOG_DEBUG("%s: dpp_inst(%d) clock_on = %d\n", __func__, dpp_inst, clock_on);
 }
 
 static void dccg35_disable_symclk32_se(
@@ -1731,6 +1745,7 @@ static void dccg35_disable_symclk32_se(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+
 }
 
 static void dccg35_init_cb(struct dccg *dccg)
@@ -1738,7 +1753,6 @@ static void dccg35_init_cb(struct dccg *dccg)
 	(void)dccg;
 	/* Any RCG should be done when driver enter low power mode*/
 }
-
 void dccg35_init(struct dccg *dccg)
 {
 	int otg_inst;
@@ -1753,6 +1767,8 @@ void dccg35_init(struct dccg *dccg)
 		for (otg_inst = 0; otg_inst < 2; otg_inst++) {
 			dccg31_disable_symclk32_le(dccg, otg_inst);
 			dccg31_set_symclk32_le_root_clock_gating(dccg, otg_inst, false);
+			DC_LOG_DEBUG("%s: OTG%d SYMCLK32_LE disabled and root clock gating disabled\n",
+					__func__, otg_inst);
 		}
 
 //	if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
@@ -1765,6 +1781,8 @@ void dccg35_init(struct dccg *dccg)
 			dccg35_set_dpstreamclk(dccg, REFCLK, otg_inst,
 						otg_inst);
 			dccg35_set_dpstreamclk_root_clock_gating(dccg, otg_inst, false);
+			DC_LOG_DEBUG("%s: OTG%d DPSTREAMCLK disabled and root clock gating disabled\n",
+					__func__, otg_inst);
 		}
 
 /*
-- 
2.43.0

