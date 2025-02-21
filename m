Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859CCC021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3498110EADA;
	Fri, 21 Feb 2025 15:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kWb9jNch";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9F210EADA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJ+9WCuwf2ve19jNaeBuBrYvgH4ZVRnAjWTlSF64I7fsQspVjRecwfFGFqVPXnMwa2ImCtDHgqK4lMpXeL2M8Ta81kpZB9/RqRip+UuPrqFZGvCNOpUQtunSruYsFryBayBvXNnHUkm5JoZPdhdgWNpfaLyr/ofUaGX559llpOiTWw6kmwVeElkhxh4dLDXNVkARQ50oHxIVx2MOqW3D38q/K7TNTinBTmVyiyJlpHJnifZlffUSajS8AgcTIh7dXE6M+2OPn1llix92wI+mYwRLIPED/+o8nNQQWy/ytYZhEeytzeEe4afDWqn7sc9jRm2KCdZBRwi9wuI9uvJ8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpsymxPNJZ50/O42y6ThgUb3weSVePoJWV9pQg/Zi30=;
 b=jt1rd6vA6ttS7obJQjkPzsBtYPLiFQNq7H2aUIbmt0jpsAIrg1WLVvnS+6dtQdrSN7M7V7Ekrf56UB9iM8r2pnve0uSdeQmPC4A4corCdcpDJxNDk9HIMF7oaj+5bMYVTHv8axx09TfEGrvo40raRGIk634ZXJc/09kFhMMpmlQouCwbctJNDFp6PmMkoBVFFiywFiKW0XSTsMNOAQuzogw80mQThj6KnGWHpAefaOBOxFt4VrFobPrx5p/zT9uf2hCIX8R74Jf6WvNWAJ8uAmVTOVhF6Oc1YuTQ3OfaYFKRp1S88WDSJtkH53b9kHKTwUYIXAtjHuF+tu/7dtY6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpsymxPNJZ50/O42y6ThgUb3weSVePoJWV9pQg/Zi30=;
 b=kWb9jNchmyYJa0Tg8dDwgpLMu6bxLGaC5XDqV6FNBzpliTM18VIAiCIbY/UAfDjfwfVOcbDp/R6AY2uVawpUFKZ5DrvOehTbcZPaJ7+J91VxYXNUXNNbjBpSl2SLORp/2uZqT+p2gsivxiJ9cutOfVbwrnLgu4H4ItMScGUWrNg=
Received: from BN1PR12CA0009.namprd12.prod.outlook.com (2603:10b6:408:e1::14)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:58:05 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::1b) by BN1PR12CA0009.outlook.office365.com
 (2603:10b6:408:e1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:58:04 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:58:02 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Patel, Swapnil" <Swapnil.Patel@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 13/24] drm/amd/display: Refactor DCN4x and related code
Date: Fri, 21 Feb 2025 10:57:10 -0500
Message-ID: <20250221155721.1727682-14-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 9522f324-647d-4fa1-dc2e-08dd529086c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8OtfQSQ9eW/9/qlUqNWeLxHhHUF7phIa0dPum/xTPfCV2uk4YMG/2OdASwPy?=
 =?us-ascii?Q?LQVn+IsrQ5oRFPXuTsS5PAL11A0adxpaf0t1lgigRbDzPNeuMvXrOnzzHGAo?=
 =?us-ascii?Q?QgdysCOgH/g41JseM7keLfAOFyxA+aO+57Dmu9W9VLxf84f+zjMvhj0M1WCU?=
 =?us-ascii?Q?8dDXOTtygZDfHWS2VmlSTtszFpOmd7/X8So8tMJ/9kYGIosXqBxmPuGqy5l4?=
 =?us-ascii?Q?YIfgafGsGE7o5h6sCUZ1aDubhcNyvugyobMT6TnOKGxjRd/fTpOZgY5x5BL2?=
 =?us-ascii?Q?DAEtxylDGVpxTZg9TtHgDxhMS0AXzOBaDqiDpnaba3CCKGGhWtGIGiffg43u?=
 =?us-ascii?Q?InHbyEuzx6By0ASYzqH6y6pyiOdx5z8UyFzX3M+WPZjgKRU2l5F4JOoO/9yG?=
 =?us-ascii?Q?k2m5cJ1AE1pVfByo0Fei2KbfC6EmUCXg5xib4dRg13ktrq526bVGq0LyiKEV?=
 =?us-ascii?Q?FBqlNVbLyDrRok//iDCMWTRnKTJ6g+riCvUe2/vwN+uTOi4VK7Q5CZl4FlaT?=
 =?us-ascii?Q?JfAdyWkfsZUWH+xrumG6fmFqR4DLV2g5ntkGgHobsNOVyjtW9Qav5/s6HBvi?=
 =?us-ascii?Q?acTD4ouin+GutpcqaGIpdUWZuVmaGbyiNL9fwpNt7YyLFm/pbQazE7oXhTJP?=
 =?us-ascii?Q?dEQHSqlYvSOtfw4gVjC4LwzvqLjcMeoXKTZUBPMDH7yIPVqCR9+LMXX39Tpm?=
 =?us-ascii?Q?UFego5Wvk+YjzaGgKRQw55V61re28gMe/JnETgJ2Cz9egBANCjfxfwYjafvy?=
 =?us-ascii?Q?PYcEPkTcPr2DOPNQaSmXZ5FqtUX9a05wN/L5QeJ2I9A7irCh7sGtny+M+7NQ?=
 =?us-ascii?Q?j7sgVcNhZ4L47MC34eucgbNtQDyEKxfBply+KszM0hXPEKKmT6YuBv3Iiq7g?=
 =?us-ascii?Q?rTSgrz8erkCSxiTThAYTcP+3s9puWaj0a6gS94alLW52fICkj6ahNTLm0dpx?=
 =?us-ascii?Q?RyGpjpwnavBCatMcFp4UbVVrNuzdKFNv0TCQqz0+UJ32rIc0LvqjCj52cWaM?=
 =?us-ascii?Q?+C1hrnwkDm8WsWjCQB+wv49N0F3qt3dotVzc+Ud7GU4ZxnJOVTtkmXN7c8gu?=
 =?us-ascii?Q?AsPFjVR+Rup93gMV54RmWa/Nl8abX+rQG74/6u/CYDN5bM4YV/YuidOvruqm?=
 =?us-ascii?Q?Ug2WvDgl5kOZCAqGqSFwop0O67Sd0XSggOXMr/kvpcfXfZodKWCUspIAst52?=
 =?us-ascii?Q?+zZnGQmMrT7FC02lYskENOs6CAlpqfIIQPeFHvXYbjBF92+YmWXEvLiKWnR7?=
 =?us-ascii?Q?wGPoFhJSDJWKAlaVckYAas1nik6MtTcFFu8zUa6pENvkqdEkFviVJyodLPbZ?=
 =?us-ascii?Q?vI/HgM6/EqGZCc6KvkITni/2wNnV9zHhd0TAoC1hJDFLnHqcdt07/jU2WtWe?=
 =?us-ascii?Q?Wt3HMpzQ6asH75/FQYNwafzw8swkBjrY7CvZ+de+tOiLiNqtFOFu/otiY1wL?=
 =?us-ascii?Q?GxLa+53BCIJ11utsIet8l5v3MBMSbAH8XykogXBYCe6ySDxkH3ellTy8lQ0D?=
 =?us-ascii?Q?VK0Irzf2XWVyHug=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:58:04.5488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9522f324-647d-4fa1-dc2e-08dd529086c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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

From: "Patel, Swapnil" <Swapnil.Patel@amd.com>

[why & how]
Refactor existing code related to DCN4x for better code sharing with
other modules

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Swapnil Patel <Swapnil.Patel@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |  94 ++++----
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   2 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |   5 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |   2 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.h |   5 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   3 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    | 148 ++++++------
 .../dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.c  |  10 +-
 .../dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.h  |   6 +
 .../dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h  |   3 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |   1 +
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  31 ++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    | 221 +++++++++---------
 13 files changed, 282 insertions(+), 249 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
index 160c299419b7..a9b88f5e0c04 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
@@ -379,53 +379,55 @@ struct dccg_mask {
 	DCCG401_REG_FIELD_LIST(uint32_t)
 };
 
+#define DCCG_REG_VARIABLE_LIST \
+	uint32_t DPPCLK_DTO_CTRL; \
+	uint32_t DPPCLK_DTO_PARAM[6]; \
+	uint32_t REFCLK_CNTL; \
+	uint32_t DISPCLK_FREQ_CHANGE_CNTL; \
+	uint32_t OTG_PIXEL_RATE_CNTL[MAX_PIPES]; \
+	uint32_t HDMICHARCLK_CLOCK_CNTL[6]; \
+	uint32_t PHYASYMCLK_CLOCK_CNTL; \
+	uint32_t PHYBSYMCLK_CLOCK_CNTL; \
+	uint32_t PHYCSYMCLK_CLOCK_CNTL; \
+	uint32_t PHYDSYMCLK_CLOCK_CNTL; \
+	uint32_t PHYESYMCLK_CLOCK_CNTL; \
+	uint32_t DTBCLK_DTO_MODULO[MAX_PIPES]; \
+	uint32_t DTBCLK_DTO_PHASE[MAX_PIPES]; \
+	uint32_t DCCG_AUDIO_DTBCLK_DTO_MODULO; \
+	uint32_t DCCG_AUDIO_DTBCLK_DTO_PHASE; \
+	uint32_t DCCG_AUDIO_DTO_SOURCE; \
+	uint32_t DPSTREAMCLK_CNTL; \
+	uint32_t HDMISTREAMCLK_CNTL; \
+	uint32_t SYMCLK32_SE_CNTL; \
+	uint32_t SYMCLK32_LE_CNTL; \
+	uint32_t DENTIST_DISPCLK_CNTL; \
+	uint32_t DSCCLK_DTO_CTRL; \
+	uint32_t DSCCLK0_DTO_PARAM; \
+	uint32_t DSCCLK1_DTO_PARAM; \
+	uint32_t DSCCLK2_DTO_PARAM; \
+	uint32_t DSCCLK3_DTO_PARAM; \
+	uint32_t DPSTREAMCLK_ROOT_GATE_DISABLE; \
+	uint32_t DPSTREAMCLK_GATE_DISABLE; \
+	uint32_t DCCG_GATE_DISABLE_CNTL; \
+	uint32_t DCCG_GATE_DISABLE_CNTL2; \
+	uint32_t DCCG_GATE_DISABLE_CNTL3; \
+	uint32_t HDMISTREAMCLK0_DTO_PARAM; \
+	uint32_t DCCG_GATE_DISABLE_CNTL4; \
+	uint32_t OTG_PIXEL_RATE_DIV; \
+	uint32_t DTBCLK_P_CNTL; \
+	uint32_t DPPCLK_CTRL; \
+	uint32_t DCCG_GATE_DISABLE_CNTL5; \
+	uint32_t DCCG_GATE_DISABLE_CNTL6; \
+	uint32_t DCCG_GLOBAL_FGCG_REP_CNTL; \
+	uint32_t SYMCLKA_CLOCK_ENABLE; \
+	uint32_t SYMCLKB_CLOCK_ENABLE; \
+	uint32_t SYMCLKC_CLOCK_ENABLE; \
+	uint32_t SYMCLKD_CLOCK_ENABLE; \
+	uint32_t SYMCLKE_CLOCK_ENABLE; \
+	uint32_t DP_DTO_MODULO[MAX_PIPES]; \
+	uint32_t DP_DTO_PHASE[MAX_PIPES]
 struct dccg_registers {
-	uint32_t DPPCLK_DTO_CTRL;
-	uint32_t DPPCLK_DTO_PARAM[6];
-	uint32_t REFCLK_CNTL;
-	uint32_t DISPCLK_FREQ_CHANGE_CNTL;
-	uint32_t OTG_PIXEL_RATE_CNTL[MAX_PIPES];
-	uint32_t HDMICHARCLK_CLOCK_CNTL[6];
-	uint32_t PHYASYMCLK_CLOCK_CNTL;
-	uint32_t PHYBSYMCLK_CLOCK_CNTL;
-	uint32_t PHYCSYMCLK_CLOCK_CNTL;
-	uint32_t PHYDSYMCLK_CLOCK_CNTL;
-	uint32_t PHYESYMCLK_CLOCK_CNTL;
-	uint32_t DTBCLK_DTO_MODULO[MAX_PIPES];
-	uint32_t DTBCLK_DTO_PHASE[MAX_PIPES];
-	uint32_t DCCG_AUDIO_DTBCLK_DTO_MODULO;
-	uint32_t DCCG_AUDIO_DTBCLK_DTO_PHASE;
-	uint32_t DCCG_AUDIO_DTO_SOURCE;
-	uint32_t DPSTREAMCLK_CNTL;
-	uint32_t HDMISTREAMCLK_CNTL;
-	uint32_t SYMCLK32_SE_CNTL;
-	uint32_t SYMCLK32_LE_CNTL;
-	uint32_t DENTIST_DISPCLK_CNTL;
-	uint32_t DSCCLK_DTO_CTRL;
-	uint32_t DSCCLK0_DTO_PARAM;
-	uint32_t DSCCLK1_DTO_PARAM;
-	uint32_t DSCCLK2_DTO_PARAM;
-	uint32_t DSCCLK3_DTO_PARAM;
-	uint32_t DPSTREAMCLK_ROOT_GATE_DISABLE;
-	uint32_t DPSTREAMCLK_GATE_DISABLE;
-	uint32_t DCCG_GATE_DISABLE_CNTL;
-	uint32_t DCCG_GATE_DISABLE_CNTL2;
-	uint32_t DCCG_GATE_DISABLE_CNTL3;
-	uint32_t HDMISTREAMCLK0_DTO_PARAM;
-	uint32_t DCCG_GATE_DISABLE_CNTL4;
-	uint32_t OTG_PIXEL_RATE_DIV;
-	uint32_t DTBCLK_P_CNTL;
-	uint32_t DPPCLK_CTRL;
-	uint32_t DCCG_GATE_DISABLE_CNTL5;
-	uint32_t DCCG_GATE_DISABLE_CNTL6;
-	uint32_t DCCG_GLOBAL_FGCG_REP_CNTL;
-	uint32_t SYMCLKA_CLOCK_ENABLE;
-	uint32_t SYMCLKB_CLOCK_ENABLE;
-	uint32_t SYMCLKC_CLOCK_ENABLE;
-	uint32_t SYMCLKD_CLOCK_ENABLE;
-	uint32_t SYMCLKE_CLOCK_ENABLE;
-	uint32_t DP_DTO_MODULO[MAX_PIPES];
-	uint32_t DP_DTO_PHASE[MAX_PIPES];
+	DCCG_REG_VARIABLE_LIST;
 };
 
 struct dcn_dccg {
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 332094ad2b05..ffd172231fdf 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -531,7 +531,7 @@ static void dccg401_enable_dpstreamclk(struct dccg *dccg, int otg_inst, int dp_h
 			DPSTREAMCLK_ROOT_GATE_DISABLE, 1);
 }
 
-static void dccg401_disable_dpstreamclk(struct dccg *dccg, int dp_hpo_inst)
+void dccg401_disable_dpstreamclk(struct dccg *dccg, int dp_hpo_inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
index b9905c73e754..55e8718aad22 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
@@ -208,6 +208,8 @@ void dccg401_enable_symclk32_le(
 void dccg401_disable_symclk32_le(
 		struct dccg *dccg,
 		int hpo_le_inst);
+void dccg401_disable_dpstreamclk(struct dccg *dccg, int dp_hpo_inst);
+void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst);
 void dccg401_set_ref_dscclk(struct dccg *dccg,
 				uint32_t dsc_inst);
 void dccg401_set_src_sel(
@@ -228,14 +230,11 @@ void dccg401_set_dp_dto(
 		const struct dp_dto_params *params);
 void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst);
 void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst);
-
 void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst);
 void dccg401_set_dtbclk_p_src(
 		struct dccg *dccg,
 		enum streamclk_source src,
 		uint32_t otg_inst);
-
-
 struct dccg *dccg401_create(
 	struct dc_context *ctx,
 	const struct dccg_registers *regs,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
index 4bab180e1938..d5fa551dd3c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
@@ -100,7 +100,7 @@ void enc401_stream_encoder_dvi_set_stream_attribute(
 }
 
 /* setup stream encoder in hdmi mode */
-static void enc401_stream_encoder_hdmi_set_stream_attribute(
+void enc401_stream_encoder_hdmi_set_stream_attribute(
 	struct stream_encoder *enc,
 	struct dc_crtc_timing *crtc_timing,
 	int actual_pix_clk_khz,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h
index 25cc8f72d8d3..d6b00cd246b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h
@@ -232,4 +232,9 @@ void enc401_stream_encoder_map_to_link(
 		uint32_t stream_enc_inst,
 		uint32_t link_enc_inst);
 void enc401_read_state(struct stream_encoder *enc, struct enc_state *s);
+void enc401_stream_encoder_hdmi_set_stream_attribute(
+	struct stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing,
+	int actual_pix_clk_khz,
+	bool enable_audio);
 #endif /* __DC_DIO_STREAM_ENCODER_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 45584e2f5dfe..939ee0708bd2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -33,7 +33,6 @@
 #include "dml2_dc_resource_mgmt.h"
 #include "dml21_wrapper.h"
 
-
 static void initialize_dml2_ip_params(struct dml2_context *dml2, const struct dc *in_dc, struct ip_params_st *out)
 {
 	if (dml2->config.use_native_soc_bb_construction)
@@ -792,7 +791,7 @@ bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options
 	// TODO : Temporarily add DCN_VERSION_3_2 for N-1 validation. Remove DCN_VERSION_3_2 after N-1 validation phase is complete.
 	if ((in_dc->debug.using_dml21)
 			&& (in_dc->ctx->dce_version == DCN_VERSION_4_01
-				))
+		))
 		return dml21_create(in_dc, dml2, config);
 
 	// Allocate Mode Lib Ctx
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
index 4bc85aaf17da..ecaa976e1f52 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
@@ -567,80 +567,82 @@
 	type ISHARP_NLDELTA_SCLIP_PIVOT_N;	\
 	type ISHARP_NLDELTA_SCLIP_SLOPE_N
 
+#define DPP_REG_VARIABLE_LIST_DCN401 \
+	DPP_DCN3_REG_VARIABLE_LIST_COMMON; \
+	uint32_t CURSOR0_FP_SCALE_BIAS_G_Y; \
+	uint32_t CURSOR0_FP_SCALE_BIAS_RB_CRCB; \
+	uint32_t CUR0_MATRIX_MODE; \
+	uint32_t CUR0_MATRIX_C11_C12_A; \
+	uint32_t CUR0_MATRIX_C13_C14_A; \
+	uint32_t CUR0_MATRIX_C21_C22_A; \
+	uint32_t CUR0_MATRIX_C23_C24_A; \
+	uint32_t CUR0_MATRIX_C31_C32_A; \
+	uint32_t CUR0_MATRIX_C33_C34_A; \
+	uint32_t CUR0_MATRIX_C11_C12_B; \
+	uint32_t CUR0_MATRIX_C13_C14_B; \
+	uint32_t CUR0_MATRIX_C21_C22_B; \
+	uint32_t CUR0_MATRIX_C23_C24_B; \
+	uint32_t CUR0_MATRIX_C31_C32_B; \
+	uint32_t CUR0_MATRIX_C33_C34_B; \
+	uint32_t DSCL_SC_MODE; \
+	uint32_t DSCL_EASF_H_MODE; \
+	uint32_t DSCL_EASF_H_BF_CNTL; \
+	uint32_t DSCL_EASF_H_RINGEST_EVENTAP_REDUCE; \
+	uint32_t DSCL_EASF_H_RINGEST_EVENTAP_GAIN; \
+	uint32_t DSCL_EASF_H_BF_FINAL_MAX_MIN; \
+	uint32_t DSCL_EASF_H_BF1_PWL_SEG0; \
+	uint32_t DSCL_EASF_H_BF1_PWL_SEG1; \
+	uint32_t DSCL_EASF_H_BF1_PWL_SEG2; \
+	uint32_t DSCL_EASF_H_BF1_PWL_SEG3; \
+	uint32_t DSCL_EASF_H_BF1_PWL_SEG4; \
+	uint32_t DSCL_EASF_H_BF1_PWL_SEG5; \
+	uint32_t DSCL_EASF_H_BF1_PWL_SEG6; \
+	uint32_t DSCL_EASF_H_BF1_PWL_SEG7; \
+	uint32_t DSCL_EASF_H_BF3_PWL_SEG0; \
+	uint32_t DSCL_EASF_H_BF3_PWL_SEG1; \
+	uint32_t DSCL_EASF_H_BF3_PWL_SEG2; \
+	uint32_t DSCL_EASF_H_BF3_PWL_SEG3; \
+	uint32_t DSCL_EASF_H_BF3_PWL_SEG4; \
+	uint32_t DSCL_EASF_H_BF3_PWL_SEG5; \
+	uint32_t DSCL_EASF_V_MODE; \
+	uint32_t DSCL_EASF_V_BF_CNTL; \
+	uint32_t DSCL_EASF_V_RINGEST_3TAP_CNTL1; \
+	uint32_t DSCL_EASF_V_RINGEST_3TAP_CNTL2; \
+	uint32_t DSCL_EASF_V_RINGEST_3TAP_CNTL3; \
+	uint32_t DSCL_EASF_V_RINGEST_EVENTAP_REDUCE; \
+	uint32_t DSCL_EASF_V_RINGEST_EVENTAP_GAIN; \
+	uint32_t DSCL_EASF_V_BF_FINAL_MAX_MIN; \
+	uint32_t DSCL_EASF_V_BF1_PWL_SEG0; \
+	uint32_t DSCL_EASF_V_BF1_PWL_SEG1; \
+	uint32_t DSCL_EASF_V_BF1_PWL_SEG2; \
+	uint32_t DSCL_EASF_V_BF1_PWL_SEG3; \
+	uint32_t DSCL_EASF_V_BF1_PWL_SEG4; \
+	uint32_t DSCL_EASF_V_BF1_PWL_SEG5; \
+	uint32_t DSCL_EASF_V_BF1_PWL_SEG6; \
+	uint32_t DSCL_EASF_V_BF1_PWL_SEG7; \
+	uint32_t DSCL_EASF_V_BF3_PWL_SEG0; \
+	uint32_t DSCL_EASF_V_BF3_PWL_SEG1; \
+	uint32_t DSCL_EASF_V_BF3_PWL_SEG2; \
+	uint32_t DSCL_EASF_V_BF3_PWL_SEG3; \
+	uint32_t DSCL_EASF_V_BF3_PWL_SEG4; \
+	uint32_t DSCL_EASF_V_BF3_PWL_SEG5; \
+	uint32_t DSCL_SC_MATRIX_C0C1; \
+	uint32_t DSCL_SC_MATRIX_C2C3; \
+	uint32_t ISHARP_MODE; \
+	uint32_t ISHARP_NOISEDET_THRESHOLD; \
+	uint32_t ISHARP_NOISE_GAIN_PWL; \
+	uint32_t ISHARP_LBA_PWL_SEG0; \
+	uint32_t ISHARP_LBA_PWL_SEG1; \
+	uint32_t ISHARP_LBA_PWL_SEG2; \
+	uint32_t ISHARP_LBA_PWL_SEG3; \
+	uint32_t ISHARP_LBA_PWL_SEG4; \
+	uint32_t ISHARP_LBA_PWL_SEG5; \
+	uint32_t ISHARP_DELTA_CTRL; \
+	uint32_t ISHARP_DELTA_DATA; \
+	uint32_t ISHARP_DELTA_INDEX; \
+	uint32_t ISHARP_NLDELTA_SOFT_CLIP
 struct dcn401_dpp_registers {
-	DPP_DCN3_REG_VARIABLE_LIST_COMMON;
-	uint32_t CURSOR0_FP_SCALE_BIAS_G_Y;
-	uint32_t CURSOR0_FP_SCALE_BIAS_RB_CRCB;
-	uint32_t CUR0_MATRIX_MODE;
-	uint32_t CUR0_MATRIX_C11_C12_A;
-	uint32_t CUR0_MATRIX_C13_C14_A;
-	uint32_t CUR0_MATRIX_C21_C22_A;
-	uint32_t CUR0_MATRIX_C23_C24_A;
-	uint32_t CUR0_MATRIX_C31_C32_A;
-	uint32_t CUR0_MATRIX_C33_C34_A;
-	uint32_t CUR0_MATRIX_C11_C12_B;
-	uint32_t CUR0_MATRIX_C13_C14_B;
-	uint32_t CUR0_MATRIX_C21_C22_B;
-	uint32_t CUR0_MATRIX_C23_C24_B;
-	uint32_t CUR0_MATRIX_C31_C32_B;
-	uint32_t CUR0_MATRIX_C33_C34_B;
-	uint32_t DSCL_SC_MODE;
-	uint32_t DSCL_EASF_H_MODE;
-	uint32_t DSCL_EASF_H_BF_CNTL;
-	uint32_t DSCL_EASF_H_RINGEST_EVENTAP_REDUCE;
-	uint32_t DSCL_EASF_H_RINGEST_EVENTAP_GAIN;
-	uint32_t DSCL_EASF_H_BF_FINAL_MAX_MIN;
-	uint32_t DSCL_EASF_H_BF1_PWL_SEG0;
-	uint32_t DSCL_EASF_H_BF1_PWL_SEG1;
-	uint32_t DSCL_EASF_H_BF1_PWL_SEG2;
-	uint32_t DSCL_EASF_H_BF1_PWL_SEG3;
-	uint32_t DSCL_EASF_H_BF1_PWL_SEG4;
-	uint32_t DSCL_EASF_H_BF1_PWL_SEG5;
-	uint32_t DSCL_EASF_H_BF1_PWL_SEG6;
-	uint32_t DSCL_EASF_H_BF1_PWL_SEG7;
-	uint32_t DSCL_EASF_H_BF3_PWL_SEG0;
-	uint32_t DSCL_EASF_H_BF3_PWL_SEG1;
-	uint32_t DSCL_EASF_H_BF3_PWL_SEG2;
-	uint32_t DSCL_EASF_H_BF3_PWL_SEG3;
-	uint32_t DSCL_EASF_H_BF3_PWL_SEG4;
-	uint32_t DSCL_EASF_H_BF3_PWL_SEG5;
-	uint32_t DSCL_EASF_V_MODE;
-	uint32_t DSCL_EASF_V_BF_CNTL;
-	uint32_t DSCL_EASF_V_RINGEST_3TAP_CNTL1;
-	uint32_t DSCL_EASF_V_RINGEST_3TAP_CNTL2;
-	uint32_t DSCL_EASF_V_RINGEST_3TAP_CNTL3;
-	uint32_t DSCL_EASF_V_RINGEST_EVENTAP_REDUCE;
-	uint32_t DSCL_EASF_V_RINGEST_EVENTAP_GAIN;
-	uint32_t DSCL_EASF_V_BF_FINAL_MAX_MIN;
-	uint32_t DSCL_EASF_V_BF1_PWL_SEG0;
-	uint32_t DSCL_EASF_V_BF1_PWL_SEG1;
-	uint32_t DSCL_EASF_V_BF1_PWL_SEG2;
-	uint32_t DSCL_EASF_V_BF1_PWL_SEG3;
-	uint32_t DSCL_EASF_V_BF1_PWL_SEG4;
-	uint32_t DSCL_EASF_V_BF1_PWL_SEG5;
-	uint32_t DSCL_EASF_V_BF1_PWL_SEG6;
-	uint32_t DSCL_EASF_V_BF1_PWL_SEG7;
-	uint32_t DSCL_EASF_V_BF3_PWL_SEG0;
-	uint32_t DSCL_EASF_V_BF3_PWL_SEG1;
-	uint32_t DSCL_EASF_V_BF3_PWL_SEG2;
-	uint32_t DSCL_EASF_V_BF3_PWL_SEG3;
-	uint32_t DSCL_EASF_V_BF3_PWL_SEG4;
-	uint32_t DSCL_EASF_V_BF3_PWL_SEG5;
-	uint32_t DSCL_SC_MATRIX_C0C1;
-	uint32_t DSCL_SC_MATRIX_C2C3;
-	uint32_t ISHARP_MODE;
-	uint32_t ISHARP_NOISEDET_THRESHOLD;
-	uint32_t ISHARP_NOISE_GAIN_PWL;
-	uint32_t ISHARP_LBA_PWL_SEG0;
-	uint32_t ISHARP_LBA_PWL_SEG1;
-	uint32_t ISHARP_LBA_PWL_SEG2;
-	uint32_t ISHARP_LBA_PWL_SEG3;
-	uint32_t ISHARP_LBA_PWL_SEG4;
-	uint32_t ISHARP_LBA_PWL_SEG5;
-	uint32_t ISHARP_DELTA_CTRL;
-	uint32_t ISHARP_DELTA_DATA;
-	uint32_t ISHARP_DELTA_INDEX;
-	uint32_t ISHARP_NLDELTA_SOFT_CLIP;
+	DPP_REG_VARIABLE_LIST_DCN401;
 };
 
 struct dcn401_dpp_shift {
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.c
index 03b4ac2f1991..0d2ae21abbdd 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.c
@@ -262,7 +262,7 @@ void dcn31_hpo_dp_link_enc_set_link_test_pattern(
 	}
 }
 
-static void fill_stream_allocation_row_info(
+void dcn31_fill_stream_allocation_row_info(
 		const struct link_mst_stream_allocation *stream_allocation,
 		uint32_t *src,
 		uint32_t *slots)
@@ -296,7 +296,7 @@ void dcn31_hpo_dp_link_enc_update_stream_allocation_table(
 	/* we should clean-up table each time */
 
 	if (table->stream_count >= 1) {
-		fill_stream_allocation_row_info(
+		dcn31_fill_stream_allocation_row_info(
 			&table->stream_allocations[0],
 			&src,
 			&slots);
@@ -310,7 +310,7 @@ void dcn31_hpo_dp_link_enc_update_stream_allocation_table(
 			SAT_SLOT_COUNT, slots);
 
 	if (table->stream_count >= 2) {
-		fill_stream_allocation_row_info(
+		dcn31_fill_stream_allocation_row_info(
 			&table->stream_allocations[1],
 			&src,
 			&slots);
@@ -324,7 +324,7 @@ void dcn31_hpo_dp_link_enc_update_stream_allocation_table(
 			SAT_SLOT_COUNT, slots);
 
 	if (table->stream_count >= 3) {
-		fill_stream_allocation_row_info(
+		dcn31_fill_stream_allocation_row_info(
 			&table->stream_allocations[2],
 			&src,
 			&slots);
@@ -338,7 +338,7 @@ void dcn31_hpo_dp_link_enc_update_stream_allocation_table(
 			SAT_SLOT_COUNT, slots);
 
 	if (table->stream_count >= 4) {
-		fill_stream_allocation_row_info(
+		dcn31_fill_stream_allocation_row_info(
 			&table->stream_allocations[3],
 			&src,
 			&slots);
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.h
index 51f5781325e8..40859660e4dc 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.h
@@ -226,4 +226,10 @@ void dcn31_hpo_dp_link_enc_set_ffe(
 	const struct dc_link_settings *link_settings,
 	uint8_t ffe_preset);
 
+
+void dcn31_fill_stream_allocation_row_info(
+		const struct link_mst_stream_allocation *stream_allocation,
+		uint32_t *src,
+		uint32_t *slots);
+
 #endif   // __DAL_DCN31_HPO_LINK_ENCODER_H__
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h
index 48ef3d29b370..bea4e1a8ff90 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h
@@ -62,4 +62,7 @@ void hpo_dp_link_encoder32_construct(struct dcn31_hpo_dp_link_encoder *enc31,
 	const struct dcn31_hpo_dp_link_encoder_shift *hpo_le_shift,
 	const struct dcn31_hpo_dp_link_encoder_mask *hpo_le_mask);
 
+bool dcn32_hpo_dp_link_enc_is_in_alt_mode(
+		struct hpo_dp_link_encoder *enc);
+
 #endif   // __DAL_DCN32_HPO_DP_LINK_ENCODER_H__
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
index 09049aa3c4f3..f66a38f43a09 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
@@ -1244,6 +1244,7 @@ struct dce_hwseq_registers {
 	type DOMAIN24_PGFSM_PWR_STATUS; \
 	type DOMAIN25_PGFSM_PWR_STATUS; \
 	type DOMAIN_DESIRED_PWR_STATE;
+
 struct dce_hwseq_shift {
 	HWSEQ_REG_FIELD_LIST(uint8_t)
 	HWSEQ_DCN_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
index 9267cdf88e9a..ce6fbcf14d7a 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
@@ -63,8 +63,7 @@
 	uint32_t MPC_MCM_SECOND_GAMUT_REMAP_C31_C32_B[MAX_MPCC]; \
 	uint32_t MPC_MCM_SECOND_GAMUT_REMAP_C33_C34_B[MAX_MPCC]; \
 	uint32_t MPCC_MCM_3DLUT_FAST_LOAD_SELECT[MAX_MPCC]; \
-	uint32_t MPCC_MCM_3DLUT_FAST_LOAD_STATUS[MAX_MPCC]; \
-	uint32_t MPCC_CONTROL2[MAX_MPCC]
+	uint32_t MPCC_MCM_3DLUT_FAST_LOAD_STATUS[MAX_MPCC];
 
 #define MPC_COMMON_MASK_SH_LIST_DCN4_01(mask_sh) \
 	MPC_COMMON_MASK_SH_LIST_DCN32(mask_sh), \
@@ -184,7 +183,7 @@ struct dcn401_mpc_mask {
 };
 
 struct dcn401_mpc_registers {
-	MPC_REG_VARIABLE_LIST_DCN4_01;
+	MPC_REG_VARIABLE_LIST_DCN4_01
 };
 
 struct dcn401_mpc {
@@ -236,7 +235,29 @@ void mpc401_get_gamut_remap(
 	struct mpc *mpc,
 	int mpcc_id,
 	struct mpc_grph_gamut_adjustment *adjust);
-void mpc401_update_3dlut_fast_load_select(struct mpc *mpc, int mpcc_id, int hubp_idx);
-void mpc401_get_3dlut_fast_load_status(struct mpc *mpc, int mpcc_id, uint32_t *done, uint32_t *soft_underflow, uint32_t *hard_underflow);
+
+void mpc401_update_3dlut_fast_load_select(
+	struct mpc *mpc,
+	int mpcc_id,
+	int hubp_idx);
+
+void mpc401_get_3dlut_fast_load_status(
+	struct mpc *mpc,
+	int mpcc_id,
+	uint32_t *done,
+	uint32_t *soft_underflow,
+	uint32_t *hard_underflow);
+
+void mpc401_update_3dlut_fast_load_select(
+	struct mpc *mpc,
+	int mpcc_id,
+	int hubp_idx);
+
+void mpc401_get_3dlut_fast_load_status(
+	struct mpc *mpc,
+	int mpcc_id,
+	uint32_t *done,
+	uint32_t *soft_underflow,
+	uint32_t *hard_underflow);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index a6d4dbe82c13..8b2a8455eb56 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -104,120 +104,115 @@
 	SRI(OTG_MANUAL_FLOW_CONTROL, OTG, inst)
 
 
+#define OPTC_REG_VARIABLE_LIST_DCN \
+	uint32_t OTG_GLOBAL_CONTROL1; \
+	uint32_t OTG_GLOBAL_CONTROL2; \
+	uint32_t OTG_VERT_SYNC_CONTROL; \
+	uint32_t OTG_MASTER_UPDATE_MODE; \
+	uint32_t OTG_GSL_CONTROL; \
+	uint32_t OTG_VSTARTUP_PARAM; \
+	uint32_t OTG_VUPDATE_PARAM; \
+	uint32_t OTG_VREADY_PARAM; \
+	uint32_t OTG_BLANK_CONTROL; \
+	uint32_t OTG_MASTER_UPDATE_LOCK; \
+	uint32_t OTG_GLOBAL_CONTROL0; \
+	uint32_t OTG_DOUBLE_BUFFER_CONTROL; \
+	uint32_t OTG_H_TOTAL; \
+	uint32_t OTG_H_BLANK_START_END; \
+	uint32_t OTG_H_SYNC_A; \
+	uint32_t OTG_H_SYNC_A_CNTL; \
+	uint32_t OTG_H_TIMING_CNTL; \
+	uint32_t OTG_V_TOTAL; \
+	uint32_t OTG_V_BLANK_START_END; \
+	uint32_t OTG_V_SYNC_A; \
+	uint32_t OTG_V_SYNC_A_CNTL; \
+	uint32_t OTG_INTERLACE_CONTROL; \
+	uint32_t OTG_CONTROL; \
+	uint32_t OTG_STEREO_CONTROL; \
+	uint32_t OTG_3D_STRUCTURE_CONTROL; \
+	uint32_t OTG_STEREO_STATUS; \
+	uint32_t OTG_V_TOTAL_MAX; \
+	uint32_t OTG_V_TOTAL_MID; \
+	uint32_t OTG_V_TOTAL_MIN; \
+	uint32_t OTG_V_TOTAL_CONTROL; \
+	uint32_t OTG_V_COUNT_STOP_CONTROL; \
+	uint32_t OTG_V_COUNT_STOP_CONTROL2; \
+	uint32_t OTG_TRIGA_CNTL; \
+	uint32_t OTG_TRIGA_MANUAL_TRIG; \
+	uint32_t OTG_MANUAL_FLOW_CONTROL; \
+	uint32_t OTG_FORCE_COUNT_NOW_CNTL; \
+	uint32_t OTG_STATIC_SCREEN_CONTROL; \
+	uint32_t OTG_STATUS_FRAME_COUNT; \
+	uint32_t OTG_STATUS; \
+	uint32_t OTG_STATUS_POSITION; \
+	uint32_t OTG_NOM_VERT_POSITION; \
+	uint32_t OTG_BLACK_COLOR; \
+	uint32_t OTG_TEST_PATTERN_PARAMETERS; \
+	uint32_t OTG_TEST_PATTERN_CONTROL; \
+	uint32_t OTG_TEST_PATTERN_COLOR; \
+	uint32_t OTG_CLOCK_CONTROL; \
+	uint32_t OTG_VERTICAL_INTERRUPT0_CONTROL; \
+	uint32_t OTG_VERTICAL_INTERRUPT0_POSITION; \
+	uint32_t OTG_VERTICAL_INTERRUPT1_CONTROL; \
+	uint32_t OTG_VERTICAL_INTERRUPT1_POSITION; \
+	uint32_t OTG_VERTICAL_INTERRUPT2_CONTROL; \
+	uint32_t OTG_VERTICAL_INTERRUPT2_POSITION; \
+	uint32_t OPTC_INPUT_CLOCK_CONTROL; \
+	uint32_t OPTC_DATA_SOURCE_SELECT; \
+	uint32_t OPTC_MEMORY_CONFIG; \
+	uint32_t OPTC_INPUT_GLOBAL_CONTROL; \
+	uint32_t CONTROL; \
+	uint32_t OTG_GSL_WINDOW_X; \
+	uint32_t OTG_GSL_WINDOW_Y; \
+	uint32_t OTG_VUPDATE_KEEPOUT; \
+	uint32_t OTG_CRC_CNTL; \
+	uint32_t OTG_CRC_CNTL2; \
+	uint32_t OTG_CRC0_DATA_RG; \
+	uint32_t OTG_CRC0_DATA_B; \
+	uint32_t OTG_CRC1_DATA_B; \
+	uint32_t OTG_CRC2_DATA_B; \
+	uint32_t OTG_CRC3_DATA_B; \
+	uint32_t OTG_CRC1_DATA_RG; \
+	uint32_t OTG_CRC2_DATA_RG; \
+	uint32_t OTG_CRC3_DATA_RG; \
+	uint32_t OTG_CRC0_WINDOWA_X_CONTROL; \
+	uint32_t OTG_CRC0_WINDOWA_Y_CONTROL; \
+	uint32_t OTG_CRC0_WINDOWB_X_CONTROL; \
+	uint32_t OTG_CRC0_WINDOWB_Y_CONTROL; \
+	uint32_t OTG_CRC1_WINDOWA_X_CONTROL; \
+	uint32_t OTG_CRC1_WINDOWA_Y_CONTROL; \
+	uint32_t OTG_CRC1_WINDOWB_X_CONTROL; \
+	uint32_t OTG_CRC1_WINDOWB_Y_CONTROL; \
+	uint32_t GSL_SOURCE_SELECT; \
+	uint32_t DWB_SOURCE_SELECT; \
+	uint32_t OTG_DSC_START_POSITION; \
+	uint32_t OPTC_DATA_FORMAT_CONTROL; \
+	uint32_t OPTC_BYTES_PER_PIXEL; \
+	uint32_t OPTC_WIDTH_CONTROL; \
+	uint32_t OTG_DRR_CONTROL; \
+	uint32_t OTG_BLANK_DATA_COLOR; \
+	uint32_t OTG_BLANK_DATA_COLOR_EXT; \
+	uint32_t OTG_DRR_TRIGGER_WINDOW; \
+	uint32_t OTG_M_CONST_DTO0; \
+	uint32_t OTG_M_CONST_DTO1; \
+	uint32_t OTG_DRR_V_TOTAL_CHANGE; \
+	uint32_t OTG_GLOBAL_CONTROL4; \
+	uint32_t OTG_CRC0_WINDOWA_X_CONTROL_READBACK; \
+	uint32_t OTG_CRC0_WINDOWA_Y_CONTROL_READBACK; \
+	uint32_t OTG_CRC0_WINDOWB_X_CONTROL_READBACK; \
+	uint32_t OTG_CRC0_WINDOWB_Y_CONTROL_READBACK; \
+	uint32_t OTG_CRC1_WINDOWA_X_CONTROL_READBACK; \
+	uint32_t OTG_CRC1_WINDOWA_Y_CONTROL_READBACK; \
+	uint32_t OTG_CRC1_WINDOWB_X_CONTROL_READBACK; \
+	uint32_t OTG_CRC1_WINDOWB_Y_CONTROL_READBACK; \
+	uint32_t OPTC_CLOCK_CONTROL; \
+	uint32_t OPTC_WIDTH_CONTROL2; \
+	uint32_t OTG_PSTATE_REGISTER; \
+	uint32_t OTG_PIPE_UPDATE_STATUS; \
+	uint32_t INTERRUPT_DEST
+
 struct dcn_optc_registers {
-	uint32_t OTG_GLOBAL_CONTROL1;
-	uint32_t OTG_GLOBAL_CONTROL2;
-	uint32_t OTG_VERT_SYNC_CONTROL;
-	uint32_t OTG_MASTER_UPDATE_MODE;
-	uint32_t OTG_GSL_CONTROL;
-	uint32_t OTG_VSTARTUP_PARAM;
-	uint32_t OTG_VUPDATE_PARAM;
-	uint32_t OTG_VREADY_PARAM;
-	uint32_t OTG_BLANK_CONTROL;
-	uint32_t OTG_MASTER_UPDATE_LOCK;
-	uint32_t OTG_GLOBAL_CONTROL0;
-	uint32_t OTG_DOUBLE_BUFFER_CONTROL;
-	uint32_t OTG_H_TOTAL;
-	uint32_t OTG_H_BLANK_START_END;
-	uint32_t OTG_H_SYNC_A;
-	uint32_t OTG_H_SYNC_A_CNTL;
-	uint32_t OTG_H_TIMING_CNTL;
-	uint32_t OTG_V_TOTAL;
-	uint32_t OTG_V_BLANK_START_END;
-	uint32_t OTG_V_SYNC_A;
-	uint32_t OTG_V_SYNC_A_CNTL;
-	uint32_t OTG_INTERLACE_CONTROL;
-	uint32_t OTG_CONTROL;
-	uint32_t OTG_STEREO_CONTROL;
-	uint32_t OTG_3D_STRUCTURE_CONTROL;
-	uint32_t OTG_STEREO_STATUS;
-	uint32_t OTG_V_TOTAL_MAX;
-	uint32_t OTG_V_TOTAL_MID;
-	uint32_t OTG_V_TOTAL_MIN;
-	uint32_t OTG_V_TOTAL_CONTROL;
-	uint32_t OTG_V_COUNT_STOP_CONTROL;
-	uint32_t OTG_V_COUNT_STOP_CONTROL2;
-	uint32_t OTG_TRIGA_CNTL;
-	uint32_t OTG_TRIGA_MANUAL_TRIG;
-	uint32_t OTG_MANUAL_FLOW_CONTROL;
-	uint32_t OTG_FORCE_COUNT_NOW_CNTL;
-	uint32_t OTG_STATIC_SCREEN_CONTROL;
-	uint32_t OTG_STATUS_FRAME_COUNT;
-	uint32_t OTG_STATUS;
-	uint32_t OTG_STATUS_POSITION;
-	uint32_t OTG_NOM_VERT_POSITION;
-	uint32_t OTG_BLACK_COLOR;
-	uint32_t OTG_TEST_PATTERN_PARAMETERS;
-	uint32_t OTG_TEST_PATTERN_CONTROL;
-	uint32_t OTG_TEST_PATTERN_COLOR;
-	uint32_t OTG_CLOCK_CONTROL;
-	uint32_t OTG_VERTICAL_INTERRUPT0_CONTROL;
-	uint32_t OTG_VERTICAL_INTERRUPT0_POSITION;
-	uint32_t OTG_VERTICAL_INTERRUPT1_CONTROL;
-	uint32_t OTG_VERTICAL_INTERRUPT1_POSITION;
-	uint32_t OTG_VERTICAL_INTERRUPT2_CONTROL;
-	uint32_t OTG_VERTICAL_INTERRUPT2_POSITION;
-	uint32_t OPTC_INPUT_CLOCK_CONTROL;
-	uint32_t OPTC_DATA_SOURCE_SELECT;
-	uint32_t OPTC_MEMORY_CONFIG;
-	uint32_t OPTC_INPUT_GLOBAL_CONTROL;
-	uint32_t CONTROL;
-	uint32_t OTG_GSL_WINDOW_X;
-	uint32_t OTG_GSL_WINDOW_Y;
-	uint32_t OTG_VUPDATE_KEEPOUT;
-	uint32_t OTG_CRC_CNTL;
-	uint32_t OTG_CRC_CNTL2;
-	uint32_t OTG_CRC0_DATA_RG;
-	uint32_t OTG_CRC1_DATA_RG;
-	uint32_t OTG_CRC2_DATA_RG;
-	uint32_t OTG_CRC3_DATA_RG;
-	uint32_t OTG_CRC0_DATA_B;
-	uint32_t OTG_CRC1_DATA_B;
-	uint32_t OTG_CRC2_DATA_B;
-	uint32_t OTG_CRC3_DATA_B;
-	uint32_t OTG_CRC0_DATA_R;
-	uint32_t OTG_CRC1_DATA_R;
-	uint32_t OTG_CRC2_DATA_R;
-	uint32_t OTG_CRC3_DATA_R;
-	uint32_t OTG_CRC0_DATA_G;
-	uint32_t OTG_CRC1_DATA_G;
-	uint32_t OTG_CRC2_DATA_G;
-	uint32_t OTG_CRC3_DATA_G;
-	uint32_t OTG_CRC0_WINDOWA_X_CONTROL;
-	uint32_t OTG_CRC0_WINDOWA_Y_CONTROL;
-	uint32_t OTG_CRC0_WINDOWB_X_CONTROL;
-	uint32_t OTG_CRC0_WINDOWB_Y_CONTROL;
-	uint32_t OTG_CRC1_WINDOWA_X_CONTROL;
-	uint32_t OTG_CRC1_WINDOWA_Y_CONTROL;
-	uint32_t OTG_CRC1_WINDOWB_X_CONTROL;
-	uint32_t OTG_CRC1_WINDOWB_Y_CONTROL;
-	uint32_t GSL_SOURCE_SELECT;
-	uint32_t DWB_SOURCE_SELECT;
-	uint32_t OTG_DSC_START_POSITION;
-	uint32_t OPTC_DATA_FORMAT_CONTROL;
-	uint32_t OPTC_BYTES_PER_PIXEL;
-	uint32_t OPTC_WIDTH_CONTROL;
-	uint32_t OTG_DRR_CONTROL;
-	uint32_t OTG_BLANK_DATA_COLOR;
-	uint32_t OTG_BLANK_DATA_COLOR_EXT;
-	uint32_t OTG_DRR_TRIGGER_WINDOW;
-	uint32_t OTG_M_CONST_DTO0;
-	uint32_t OTG_M_CONST_DTO1;
-	uint32_t OTG_DRR_V_TOTAL_CHANGE;
-	uint32_t OTG_GLOBAL_CONTROL4;
-	uint32_t OTG_CRC0_WINDOWA_X_CONTROL_READBACK;
-	uint32_t OTG_CRC0_WINDOWA_Y_CONTROL_READBACK;
-	uint32_t OTG_CRC0_WINDOWB_X_CONTROL_READBACK;
-	uint32_t OTG_CRC0_WINDOWB_Y_CONTROL_READBACK;
-	uint32_t OTG_CRC1_WINDOWA_X_CONTROL_READBACK;
-	uint32_t OTG_CRC1_WINDOWA_Y_CONTROL_READBACK;
-	uint32_t OTG_CRC1_WINDOWB_X_CONTROL_READBACK;
-	uint32_t OTG_CRC1_WINDOWB_Y_CONTROL_READBACK;
-	uint32_t OPTC_CLOCK_CONTROL;
-	uint32_t OPTC_WIDTH_CONTROL2;
-	uint32_t OTG_PSTATE_REGISTER;
-	uint32_t OTG_PIPE_UPDATE_STATUS;
-	uint32_t INTERRUPT_DEST;
+	OPTC_REG_VARIABLE_LIST_DCN;
 };
 
 #define TG_COMMON_MASK_SH_LIST_DCN(mask_sh)\
-- 
2.34.1

