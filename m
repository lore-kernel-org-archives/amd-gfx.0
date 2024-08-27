Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F19DC5472F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 16:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D685D10E39F;
	Tue, 27 Aug 2024 16:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y3Vwg+eX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E9B10E38F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 16:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3psO6HEibPXFh1UxeRhkgl7C0MSKcqIxdZUvRvypqZl86yiSTjgb7tdSbpCIjnUURIJnmT63jQ3FRy5QXkrNTzMgehP88rBGoTGe9ZvO/wB3FIYf8H7D0GrRSR62T9XZkOQzJ5mT80RoHazErF3iVG44RxI+LmRxAAwRsl8e89Gz8MJibnfIeYLVK2dTvlXVAY5JJXZ/5MrXiQCA/WKymaKijvqB1vxXZab8/N9hvSdCugRpuiiJLgmouTjlmEpf9zLeKTRn1+TiuFP9yJal72qj6h13yRBA/H2Ihky7Sob9jAM+8WbrTFQFdltnOZ45CLZPdoXzIKZG+mohQ0SvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m/79tI4S5QXcfU7MSQpl0k6noeekLZMy2NK69sxA6A=;
 b=CexwPG6bmAKys9yEtOo2xGG5H/Zme/loYGwv/z/FxBRANGModxeZ0cBuMo+j8jgLqtOKxbw4owySXXQvQrolFJ2Np9zlk+FpIgniIfy674jXn8Jx/rw0WnsmFNdDSWHpUp3WCnTHoYCKYeWNPWO8WYv1IAkGQN16rQMBW5/x+wDkWv6QC6OyCsDxip+6kW8S1TmLhBcxR6ihhnxnZRdEiCrZXJqEkF3lbH+cfaS9i6qsw5YU6UhHh+QAsjfN383Zg6KkpKTwd26ZeYu4ggIsV67/rCZBJRsKYdcpeCzHRwvTwBsB2uK2sTfR+7491wN97MJnDU3ldBbGzgwIuVLR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m/79tI4S5QXcfU7MSQpl0k6noeekLZMy2NK69sxA6A=;
 b=y3Vwg+eXYxNLK70eQcRlssR0ZfFOKfZDUW3jbr43iwTVlxzrcWO2WSRQpdjO4PFNPbBiE+zD5+Z4i+okBAfCdz9iIR+la6sVvD2m9wGJaIQU+P3hM0BiNzFrX8VmK1APgqaGYWXlgABWgFo1q1vciC3ox6ZjH5IhXNwDGlMGm+A=
Received: from BN9PR03CA0710.namprd03.prod.outlook.com (2603:10b6:408:ef::25)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 16:41:11 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::64) by BN9PR03CA0710.outlook.office365.com
 (2603:10b6:408:ef::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:11 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:09 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
 <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
 <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Nicholas
 Susanto" <Nicholas.Susanto@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 07/14] drm/amd/display: Refactor
 dccg35_get_other_enabled_symclk_fe
Date: Tue, 27 Aug 2024 12:37:27 -0400
Message-ID: <20240827164045.167557-8-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 906a1b39-6ad2-4259-bc0c-08dcc6b70ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OpmcauCrq793cM6o2+37neLLUWJzKsgxP7d29W/tPFLEm1eO3MGjzCuSeM8o?=
 =?us-ascii?Q?/KH+Gj3xbX98n/RHiTZ8Z6GBJBe6qGp9ahvMIqazaSlLdjn6r3C2jRwB8Upo?=
 =?us-ascii?Q?+QPmyQpkVuM+sAfAYELF/UTlZeH3CUjzGT99y9UJd4l/bIm6VnLTIdqgeRpG?=
 =?us-ascii?Q?nRC9ZF/U01Wj1iabjDEDx7/HZxhAZWqv0jqmV//8APqG3ptH5Hi77txXXGju?=
 =?us-ascii?Q?9+j6LzEW3ksfsmxbfiSksWfzhVZdEeW95ApebnKedooaimmadTelYvRxUD7i?=
 =?us-ascii?Q?LJ6AelECoYhOBCUf+IcgnjR4d72kogE/48mUujeX3j/2SScPMso3Zhhortrc?=
 =?us-ascii?Q?5pxMHH41gHzGEcbIU9MVfUMmnyk/k/vNfzcCcln7CX/04WB1U9yg1J3zGymz?=
 =?us-ascii?Q?mciNAJ7mvnRnMY/kwmzHChxUQvMHBDDlyPtGp4YGlIh1MP+44mrWy8d0/8Wa?=
 =?us-ascii?Q?4qQsKqJCLgPLCZe28aPyGqUcFwDYiGMHbaqgicA0Y2U+D1/OgCpaNLcw+smg?=
 =?us-ascii?Q?NfuvXZ5XL3mOtYT/aOnC911A0HDwUWDnQW5TTL8V3aIMnt2/5HNAlTHywlF3?=
 =?us-ascii?Q?WkqyQ4sekVUtrG5kWBzKJ+iu3iIUN9IsX+gCBb/AWH5EcjA/3vf1KbuGF+/L?=
 =?us-ascii?Q?HJKzcaqPV8a2sWODSUvZXcak4HPSFqxQ4UJ7EjgV5drX9v8zxHUoy17ZBet8?=
 =?us-ascii?Q?KT656EGCwJY3n+5iYYDlBhza5jjBYMZ7pJek0yLOICNgMpT1w+HlTOQL3RYi?=
 =?us-ascii?Q?RDOp5wQRw6typzAExqqMsRO/l0E25e35u7gIE/68MXrG/mwWdqKqPNJCY9gv?=
 =?us-ascii?Q?szRLN7mArw4pIYyh8ch+kx93wOWD72uItGrA7MXSQmKaQ7HKyqrxJZfeqefg?=
 =?us-ascii?Q?uF5g46QWjqiZy22yDPqXXqtDN+XrUbFShLFqxj8uljrpX05cD4oZ9t4+e7mE?=
 =?us-ascii?Q?epKwqOejRz0diMXOzs4ITCGgiGG4NqPracHeIRQtn2KLmAywjFs2J8/+hiRb?=
 =?us-ascii?Q?F5a9w8wO1pCGShZ6+XuD48YV43xpud9jJWGyjfQWQVV0f/pRjssCE+hSnBp1?=
 =?us-ascii?Q?9w/usssQ8r26jLp3+CDfKVrQjMqyswOTkggtmKE+MnSgc4bEL++SdhCTwUK4?=
 =?us-ascii?Q?fOFIXGBoqELEYfvQhN+phn9JZEny1PnEzMMCkQ2vDUvopf3DizTPDDITSJu4?=
 =?us-ascii?Q?RT1DBQmTcZrcpjJaHPXSe86/cjQ3uMMEF8DFFc5k7ylCzRtM1UOPiC1lVnSj?=
 =?us-ascii?Q?mfnzzPM/BRgBrfnXFOedEfbyKW/PZN9Hgkpil5LEe2ll/4p3+TZWOy6pG4Uh?=
 =?us-ascii?Q?vt2RMK1Hwxd1KuGag0UUGy9T9g6pugLJBm3J776hdPqOAYccDm6Iso59iX5A?=
 =?us-ascii?Q?zPIYFBYfky802Hxg6M59vunaP2/Ly5shKrZ4UQtUcg3yaFuaZ2UdsZX+N8qj?=
 =?us-ascii?Q?vjOkRGGrchQ17PE/TJn5nrNTw1VH2efs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:11.0263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906a1b39-6ad2-4259-bc0c-08dcc6b70ee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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

From: Nicholas Susanto <Nicholas.Susanto@amd.com>

[Why]

Function used to check the number of FEs connected to the current BE.
This was then used to determine if the symclk could be disabled, if
all FEs were disconnected. However, the function would skip over the
primary FE and return 0 when the primary FE was still connected. This
caused black screens on driver disable with an MST daisy chain hooked
up.

[How]

Refactor the function to correctly return the number of FEs connected
to the input BE. Also, rename it for clarity.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Nicholas Susanto <Nicholas.Susanto@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 65 +++++++------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 60a84de4c5d1..889f39694cb7 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1905,47 +1905,32 @@ static void dccg35_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst,
 }
 
 /*get other front end connected to this backend*/
-static uint8_t dccg35_get_other_enabled_symclk_fe(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+static uint8_t dccg35_get_number_enabled_symclk_fe_connected_to_be(struct dccg *dccg, uint32_t link_enc_inst)
 {
 	uint8_t num_enabled_symclk_fe = 0;
-	uint32_t be_clk_en = 0, fe_clk_en[5] = {0}, be_clk_sel[5] = {0};
+	uint32_t fe_clk_en[5] = {0}, be_clk_sel[5] = {0};
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	switch (link_enc_inst) {
-	case 0:
-		REG_GET_3(SYMCLKA_CLOCK_ENABLE, SYMCLKA_CLOCK_ENABLE, &be_clk_en,
-				SYMCLKA_FE_EN, &fe_clk_en[0],
-				SYMCLKA_FE_SRC_SEL, &be_clk_sel[0]);
-				break;
-	case 1:
-		REG_GET_3(SYMCLKB_CLOCK_ENABLE, SYMCLKB_CLOCK_ENABLE, &be_clk_en,
-				SYMCLKB_FE_EN, &fe_clk_en[1],
-				SYMCLKB_FE_SRC_SEL, &be_clk_sel[1]);
-				break;
-	case 2:
-			REG_GET_3(SYMCLKC_CLOCK_ENABLE, SYMCLKC_CLOCK_ENABLE, &be_clk_en,
-				SYMCLKC_FE_EN, &fe_clk_en[2],
-				SYMCLKC_FE_SRC_SEL, &be_clk_sel[2]);
-				break;
-	case 3:
-			REG_GET_3(SYMCLKD_CLOCK_ENABLE, SYMCLKD_CLOCK_ENABLE, &be_clk_en,
-				SYMCLKD_FE_EN, &fe_clk_en[3],
-				SYMCLKD_FE_SRC_SEL, &be_clk_sel[3]);
-				break;
-	case 4:
-			REG_GET_3(SYMCLKE_CLOCK_ENABLE, SYMCLKE_CLOCK_ENABLE, &be_clk_en,
-				SYMCLKE_FE_EN, &fe_clk_en[4],
-				SYMCLKE_FE_SRC_SEL, &be_clk_sel[4]);
-				break;
-	}
-	if (be_clk_en) {
-	/* for DPMST, this backend could be used by multiple front end.
-	only disable the backend if this stream_enc_ins is the last active stream enc connected to this back_end*/
-		uint8_t i;
-		for (i = 0; i != link_enc_inst && i < ARRAY_SIZE(fe_clk_en); i++) {
-			if (fe_clk_en[i] && be_clk_sel[i] == link_enc_inst)
-				num_enabled_symclk_fe++;
-		}
+	REG_GET_2(SYMCLKA_CLOCK_ENABLE, SYMCLKA_FE_EN, &fe_clk_en[0],
+		SYMCLKA_FE_SRC_SEL, &be_clk_sel[0]);
+
+	REG_GET_2(SYMCLKB_CLOCK_ENABLE, SYMCLKB_FE_EN, &fe_clk_en[1],
+		SYMCLKB_FE_SRC_SEL, &be_clk_sel[1]);
+
+	REG_GET_2(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_EN, &fe_clk_en[2],
+		SYMCLKC_FE_SRC_SEL, &be_clk_sel[2]);
+
+	REG_GET_2(SYMCLKD_CLOCK_ENABLE,	SYMCLKD_FE_EN, &fe_clk_en[3],
+		SYMCLKD_FE_SRC_SEL, &be_clk_sel[3]);
+
+	REG_GET_2(SYMCLKE_CLOCK_ENABLE,	SYMCLKE_FE_EN, &fe_clk_en[4],
+		SYMCLKE_FE_SRC_SEL, &be_clk_sel[4]);
+
+	uint8_t i;
+
+	for (i = 0; i < ARRAY_SIZE(fe_clk_en); i++) {
+		if (fe_clk_en[i] && be_clk_sel[i] == link_enc_inst)
+			num_enabled_symclk_fe++;
 	}
 	return num_enabled_symclk_fe;
 }
@@ -1993,9 +1978,9 @@ static void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 		break;
 	}
 
-	/*check other enabled symclk fe */
-	num_enabled_symclk_fe = dccg35_get_other_enabled_symclk_fe(dccg, stream_enc_inst, link_enc_inst);
-	/*only turn off backend clk if other front end attachecd to this backend are all off,
+	/*check other enabled symclk fe connected to this be */
+	num_enabled_symclk_fe = dccg35_get_number_enabled_symclk_fe_connected_to_be(dccg, link_enc_inst);
+	/*only turn off backend clk if other front end attached to this backend are all off,
 	 for mst, only turn off the backend if this is the last front end*/
 	if (num_enabled_symclk_fe == 0) {
 		switch (link_enc_inst) {
-- 
2.46.0

