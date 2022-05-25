Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B72AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEEC510EE21;
	Wed, 25 May 2022 16:20:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6390B10E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnY9Hq/q8UxYm6tGi3zcshID1AHoirlmlMMRPpyyE1+rxs7MguadkhAmaV8s4Rfg6Gtzl7F7BcDSKvGP+NgfE1Mlbt1t6+zsanhBooW6MBNegJmvhBvvUdKG+S2ShwGz0UgpSIuIcXZcyjbSC0Lp65uo59eGSAdLsXyrU7kJFmEQ8R8EzmeU3MAq7Ff7Tk/vUppGloaevORtoDAOv5nuikBGxURpC0TqC5Xa1MpmmHj6ODs9pz/FtjsrTCnUm2Wnxkmvri4V5zvVUyPA8MdF7Hsxl7by99GHBco6XN+oPuAFbDGOFTJeYVAQU2D5TXtWISdMlbnrOwJulnQW5ygF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X491pjVufkj54REAJrA7i9s99wXWzedRkdc4Ato9DNc=;
 b=Grwxijq9E7b6OoP4ftK26DZM55u3ClzR0iGF2CDclMDaVFJU80bOOi1HR19rxUteW1Er4CJ3LxgJXL64Z4/U0NYFIidcgPtwcZDXwkOb81im8zbLrrt+/Ys61k1EmBcIEglRug8pPpc5HrcqwGPy/XLlaw3uZw25wxJoTpGL3MOL0NXChOhceVjOx4L44L7Z4ewZoqqimeBguv7mcXrNO2EbkiFUgsyVC3LCVbSkQMGT2lxxWqf+t7btyof00G5+m96GwllV9ZO2xSoHnrkMI0QjNK0GP2OwGakESXGSA59EzwY0gcZKvYDw8cx/s8fe1Yu6u9mBXEQs93VJOpsY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X491pjVufkj54REAJrA7i9s99wXWzedRkdc4Ato9DNc=;
 b=zqvDVf37A1TI6UZjPF5Pt2izRR0nWkmfjFAhfmFlthitxWyvGwimQxgBiV2D+7D12JPgoEZarqusiNnhLxrwNiZ7wMmogeEPUMWWTQT0LMI11p6djtBouRWlidYvjA8EUJHczSYHMF9srbtYQbF19K2y75V5sc30mjqrt+A11Vs=
Received: from DS7PR05CA0105.namprd05.prod.outlook.com (2603:10b6:8:56::19) by
 BYAPR12MB2727.namprd12.prod.outlook.com (2603:10b6:a03:71::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Wed, 25 May 2022 16:20:16 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::ec) by DS7PR05CA0105.outlook.office365.com
 (2603:10b6:8:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/43] drm/amd/display: Select correct DTO source
Date: Wed, 25 May 2022 12:19:21 -0400
Message-ID: <20220525161941.2544055-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f30626b-599a-49b6-31e9-08da3e6a7420
X-MS-TrafficTypeDiagnostic: BYAPR12MB2727:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27276094F56CD523FB8B83C0F7D69@BYAPR12MB2727.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7N5B/Ie1zEgZ8fvgmWGZl+/eS8tXUQePDFqbUqE4TwhJcNW6IvSeRQchGfprjoqT8r/TzhxO6+DruGEa5+KVZlN0u4aUCY6GL6D+d9TDJ1Wm/JkNudC6/lbCs2nbe0KNgAwJfU+uYmSTSuMvxeuIe2NG0/no1SpskU9velnXdR9XeZmwODHzE58WxvQ36e9k4QPIQyd2dY+k8/j5J5ANqofz7rfKi+o3qEgi3VJHvChvlbVoTdamZPRRDgQpzP4mdgaTquju2WWge/RiSLPN6vNzJ2STPjFP1+9Rked44vie4o91MczP59CmTqt9vJpV8iHlT+amlZdrSoWOPB48rH6LLtXy5pGVwXkZclCNHr0qWrDa9FmioH891buXOVhszxd6JxJFLpwM0O43bfz7kvy/8HbVo8RDYAfpQyzJe44DCn5Ls0sIEBDWNU7oU6bhe+kPefrX8iW5E81YZpmRWxPQ18Zel6E3zAu5WK4aJ/nC2zVsquQ2PQuUWPnqJsB0NF9lchAV6jIkG3WIsz0iHozZ8yRb26KcNUU1WrTgAYpGaLDSPeXmKWvroNXoJvQxvI1uX2jd2ffaP27n0uVOD+Ky9aLgQ6+AUFNn2QV4g2zvcUxoD0lanaYpbAJgHKz53ixcvY5D9biEp/6N1O6tCctLGoFvU22LNrudzgtY8Rom1n5BxXqzUaI72EEHMcVt+4LCxo0Btfp12z6SJuRbDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(2616005)(83380400001)(356005)(26005)(70206006)(426003)(82310400005)(336012)(81166007)(7696005)(2906002)(8676002)(47076005)(4326008)(5660300002)(1076003)(8936002)(508600001)(186003)(36860700001)(36756003)(316002)(6916009)(54906003)(40460700003)(6666004)(16526019)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:16.1131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f30626b-599a-49b6-31e9-08da3e6a7420
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2727
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Dillon Varone <dillon.varone@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Change criteria for setting DTO source value, and always set it regardless of
the signal type.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dce/dce_clock_source.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 845aa8a1027d..4b57657b5322 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -992,7 +992,18 @@ static bool dcn31_program_pix_clk(
 			REG_WRITE(PHASE[inst], pll_settings->actual_pix_clk_100hz * 100);
 			REG_WRITE(MODULO[inst], dp_dto_ref_khz * 1000);
 		}
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		/* Enable DTO */
+		if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
+			REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
+					DP_DTO0_ENABLE, 1,
+					PIPE0_DTO_SRC_SEL, 1);
+		else
+			REG_UPDATE(PIXEL_RATE_CNTL[inst],
+					DP_DTO0_ENABLE, 1);
+#else
 		REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
+#endif
 	} else {
 		if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
 			unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
@@ -1004,10 +1015,26 @@ static bool dcn31_program_pix_clk(
 			REG_WRITE(MODULO[inst], dp_dto_ref_100hz);
 
 			/* Enable DTO */
+	#if defined(CONFIG_DRM_AMD_DC_DCN)
+			if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
+				REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
+						DP_DTO0_ENABLE, 1,
+						PIPE0_DTO_SRC_SEL, 1);
+			else
+				REG_UPDATE(PIXEL_RATE_CNTL[inst],
+						DP_DTO0_ENABLE, 1);
+	#else
 			REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
+	#endif
 			return true;
 		}
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
+			REG_UPDATE(PIXEL_RATE_CNTL[inst],
+					PIPE0_DTO_SRC_SEL, 0);
+#endif
+
 		/*ATOMBIOS expects pixel rate adjusted by deep color ratio)*/
 		bp_pc_params.controller_id = pix_clk_params->controller_id;
 		bp_pc_params.pll_id = clock_source->id;
-- 
2.35.3

