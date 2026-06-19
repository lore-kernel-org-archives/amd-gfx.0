Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BB7CD98F6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A975510F5E2;
	Fri, 19 Jun 2026 13:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ec8GbzOS";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306A410F5E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSQlfqlMpPbN4rHNm6a7+qxX3pwYZzx2UQIXyhuz9F2qGC1jPdLVqxLwlq4xk20E3xD4ILcDsZOXJf9nx20P7bBfL0NPGgvpo3wzp9UerIDTbGRtOOZlQ7tqHQNeft0vvUwY4AgKlRGDGIsSaILRH9lq4dGrGFwkjf0lg+el83mYsr5kxc9APB4JjpJ728PdqooAUVACmDKXDCWOcqjE0TyG+VTkGkKIdw0SPKEU1DUN+zvM+n08/qTmgZo0ZziiySyyIXOLL/U8dDO01Nq0yXQB/ZW2lT42jDbUKWsaVtrv8WKvdAVkznsZDJeETI8RB+a/nHYahOL7KjQpj2kzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlCnc4JsIVM7+LrF8a9BzueI2dwPJnxHgx5vWy2K2Vk=;
 b=YwEqtXU1xPieIh45BtWAsSv7zXdTlEd7K9HaRWyFfN3UUvkDtqDEqT0H4mQrPlIDTMC+3Ar+yuDaL/rytz+76u3NqsbgtiUo+Ehi8D5hsjudOZsthspNn8yLNqHWLZuMaKDuqK5h2Sv6s9NxRnC0+CVfhaiVf19kyh93mJyzJh85LoPgJbZMHqhZR4ptQe+5TuWtpgTGuaG1258L3E9qsQY+7o0339uWvq+Jlz4Bpd8ePEl0KyVPz80vKv0swnetRrd0Uhsc+d3IvuvwKzoEtipDKtRLRame/0Xt4+C0LBPWTDIEWimY1w2WkwrX8leu7r5qE7H/WUPROzcXN30p2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlCnc4JsIVM7+LrF8a9BzueI2dwPJnxHgx5vWy2K2Vk=;
 b=Ec8GbzOSI8dwZeRYC96cvIlAbUaAeS0mffqLQNJV2N9KJkWnCJ3YnPDFnoNpUmAc6uVxZyuy+mElRk3MV4yem0rWKXqrzY43+IH6h06TtTbELFtXWxRkuHi/yzPKlP5TRtC4LYfoBR9sqlbsU+yOY+gPjkE1E7eezEfXhytE6n0=
Received: from BN0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:408:e6::32)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:32:25 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::88) by BN0PR03CA0027.outlook.office365.com
 (2603:10b6:408:e6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Fri,
 19 Jun 2026 13:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:25 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:24 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Ovidiu
 (Ovi) Bunea" <ovidiu.bunea@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 08/24] drm/amd/display: Rewrite dccg42_init
Date: Fri, 19 Jun 2026 09:21:23 -0400
Message-ID: <20260619133154.116746-9-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: eb72dcad-70c4-4208-ec06-08dece073357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CeQqtfhy8vXsT/ScrFDMbx+1Lo3/jjztTaNdrI6nK1IISjsIPcfrOyIqE+yYkOVEEOhy73vAM0+Nzye9ZUJlQQ5h777WUaZYecqubogkMUmaMgomiw4TiwLsQj9JT3bk3XEBYWcgByZ8NiK/Lw8DMIrpse0kTzN8QPMJeBGK0SjTpgUAeOzRxpeN+BLyrg6bLQn9nSEcCvBfDFLo0u5vbmCXpeFhiDC+0MlkWhD15g4x7W3q5MI++MHVW0xZZGnmc2p9kVV2U0qoU1KwDLKT5ICDkTcRRmJGgUgb1GGDReSDrOYiSp/f2lS3TEPlu3iJjOT6ZMJQBaU70yUtNEmxCrVcLhSgHOkiOoP+1KntuP1BmGpHyZ9E6YsnUN2U4HNlEmDQqPGm6QGTJJ7USHYz0ajOgmm7EXFuDIvVl6H34DbmwCvsPQFuFPYLks2xovuzT2YGl3XEqRgijLlnylYqxLXyOJWcfoCx3UXqaSFPgEifAyY685jXTuPQVBOhFgqtgXjlF5BfiX6dy8eIg/gIUhhZXbkFuuBVxvlOzLyRCqaWoOPmA0oRsgAufC1VCDNMPj41BN1kU+WH5XGjeU1tf37+/ppwHxiEXndsG+YU3TjN9q3rtya/mAJO1i0KBrq+YlGawmG1CL60aDtrsp+EuiTdiEzIUJxeRUwxCZsxoI5q3RHMgsMyjqskBxLQplqG+66lMDJvFdU0Gp4hkV7v+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /509bspVqVQVmUX0fnu4Z2PuMwUUfqisu8/Ul5xQLdy1TyZGf2t2+LdbtQN/uKoPhUCCSrqs9hKyQIYCJdVrWEw8YhdNAAHHi4Q3ewG/oRP++6ocVW+BGAuPQP5SZrlG10R/tsgJe9zyHiCV5NL4HWBh4MHB47WlbCpz2BDHUhv3wYpIsXgO7gkPoTLyXKcPMTL41NY5rvS5npoWPLxsiECkgc7mZip1WBAIO8RAj3dOEzwYpKCIhJgTrTL6WRLpvgZEXaJOI2IWmR3vfbJqp1bhl0eevVaYB6DE37m8+uDE+QuPJ5SWDVkOP7RHgV4o7B8skGrIQgkwmoXWUGwxLJ176+Hr+jtA/Arxc/1jEaVs68KqVwsD5V5SYKzAsH4EpJOySqXRQDdbWVVsTn8fQreyN+oOjmI7rTXKQ5poTujYKYSqnzGP+6E2XQxBKrVJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:25.4234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb72dcad-70c4-4208-ec06-08dece073357
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[why]

DCN42 reuses dccg42_init, which causes problems due to undefined masks.

[how]

- Read res_pool to determine the quantities of the respective resources
- Remove the physymclk root_clock_optimization check, as it seems like
  it shouldn't do anything (defaults to disabled already).

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    | 29 ++++++-------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
index adc453c81831..8989761c6078 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
@@ -269,37 +269,26 @@ void dccg42_trigger_dio_fifo_resync(struct dccg *dccg)

 static void dccg42_init(struct dccg *dccg)
 {
-	int otg_inst;
-	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	unsigned int i;
+	struct resource_pool *res_pool = dccg->ctx->dc->res_pool;

 	/* Set HPO stream encoder to use refclk to avoid case where PHY is
 	 * disabled and SYMCLK32 for HPO SE is sourced from PHYD32CLK which
 	 * will cause DCN to hang.
 	 */
-	for (otg_inst = 0; otg_inst < 4; otg_inst++)
-		dccg35_disable_symclk32_se(dccg, otg_inst);
+	for (i = 0; i < res_pool->hpo_dp_stream_enc_count; i++)
+		dccg35_disable_symclk32_se(dccg, i);

 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le) {
-		dccg401_disable_symclk32_le(dccg, 0);
-		dccg401_disable_symclk32_le(dccg, 1);
-		dccg401_disable_symclk32_le(dccg, 2);
-		dccg401_disable_symclk32_le(dccg, 3);
+		for (i = 0; i < res_pool->hpo_dp_link_enc_count; i++)
+			dccg401_disable_symclk32_le(dccg, i);
 	}

 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream) {
-		dccg401_disable_dpstreamclk(dccg, 0);
-		dccg401_disable_dpstreamclk(dccg, 1);
-		dccg401_disable_dpstreamclk(dccg, 2);
-		dccg401_disable_dpstreamclk(dccg, 3);
-	}
-	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk) {
-		REG_UPDATE_5(DCCG_GATE_DISABLE_CNTL2,
-			PHYASYMCLK_ROOT_GATE_DISABLE, 1,
-			PHYBSYMCLK_ROOT_GATE_DISABLE, 1,
-			PHYCSYMCLK_ROOT_GATE_DISABLE, 1,
-			PHYDSYMCLK_ROOT_GATE_DISABLE, 1,
-			PHYESYMCLK_ROOT_GATE_DISABLE, 1);
+		for (i = 0; i < res_pool->hpo_dp_stream_enc_count; i++)
+			dccg401_disable_dpstreamclk(dccg, i);
 	}
+
 	dccg42_disable_hdmistreamclk(dccg);
 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.hdmichar)
 		dccg42_disable_hdmicharclk(dccg, 0);
--
2.54.0

