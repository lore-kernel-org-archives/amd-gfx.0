Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FA6C33CB7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DE12082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UNJQXv2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DE12082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D3B6FC4C;
	Fri, 31 Jan 2020 22:17:34 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe46::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB4DE6FC48
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY9Uw6Qy2wa9V0xrhZuiuWOcnrEKw0MUn+C3i3lNd27+q4zJ2W6Fwvzg5FEDDIEw3VZTbgdEL3QXSmAnB3GojNcqgbtKyK1lTYE2AKFFYaWQ6Evm2x0fYrmZpagwg5uzQqrbDoIah+8djKEfo71bSH7R4O7KDRQr9m9XXcU8jwGxfuH/XqHxImJ/3gIjkKgUdN/6sKFxMTGNENf9DDOQU5oB+Ox7Ym+N6k5xvHZrFfruSX+aEDyOwDK+KJ2aLTLc4pP5IA8JHWiAXFSg1l9nZ1E9rkqIUhbYzDm+PZhG1l4RSWS2S6jSWT74XTugqGG167DdfwVT8LDXNn0qCPstxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBb7jZa4vVy70RcWSfGN4nppzj/DJMI0+8PIsh4pioc=;
 b=ddvoq6VA6oMkR5EefSpJ4E2VYRdVU8dSUfLycoqs3ptDAFxJxi867GY71DkN2JyPobq178N4gbJqw/qepOCkctP+bg+pdNAo491viJwR6aCGgQgEcbuF2vlX7a4DEk4JLP/hjxltPTWOsy1poGbsMZhLEp6n74OA1Q+uq9Sm6yCCQQs+k8Mdn4YTkWlLxmMPUrQM2TwNQtPSNvI+FJAShPTmyCC4LfzKIAp+UOFraJ+HiB4Uek5haD6jMbzoGlLtFPyMWWvvgvTnJhkcnENsV6DhoyABuD7ZqczFkAMMF43bfo+od95JRQlBgPDZgR3Kilw3BgQ6X/l2LYIDYf+TFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBb7jZa4vVy70RcWSfGN4nppzj/DJMI0+8PIsh4pioc=;
 b=UNJQXv2PcBPJDzUi3mbSyXesKl/CbJy4lf9lq8g5YdWCZQPDFejMZ6vRr1bsoRD0kIqERBxr93dcjvD5uiWeSTrz3Ip427ZUhu71prw8irdMdAjkp3uJXRGYno/wlfc9mdk2UsvMOTMSuqUI80L1J/2mW/cDtF/0lQ7Z/0l770U=
Received: from DM3PR12CA0081.namprd12.prod.outlook.com (2603:10b6:0:57::25) by
 CY4PR12MB1751.namprd12.prod.outlook.com (2603:10b6:903:121::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.26; Fri, 31 Jan
 2020 22:17:25 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by DM3PR12CA0081.outlook.office365.com
 (2603:10b6:0:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:24 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:15 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:15 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:15 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/33] drm/amd/display: Add initialitions for PLL2 clock source
Date: Fri, 31 Jan 2020 17:16:42 -0500
Message-ID: <20200131221643.10035-33-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(428003)(189003)(199004)(478600001)(356004)(6666004)(54906003)(86362001)(7696005)(2906002)(70586007)(5660300002)(316002)(6916009)(1076003)(36756003)(70206006)(8936002)(186003)(26005)(4326008)(336012)(2616005)(8676002)(81166006)(81156014)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1751; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1833dca3-0a5b-418a-8f66-08d7a69b5944
X-MS-TrafficTypeDiagnostic: CY4PR12MB1751:
X-Microsoft-Antispam-PRVS: <CY4PR12MB175188FFE224E5B9669D43C0F9070@CY4PR12MB1751.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XIllsShHFZH03Mr7ClcAZQfsJcf40BiAMf2kes7d7teS3pIGdqCQYT5FXxmO1CPywGKDVNoKQd3EU5neZNPpQ/UEiAA40kn7/w6WPG+wky6tCMXzHWnCzP6sO0PxiuJUVsO50ujhCy8X3AIGdfD1s45mouPPRDSnzfwxrtr/CGQqibLRMykmGg/IHFyfb//eTMQBh0R5w2NDdg5GsbxlrxN8+uRD6E4EaB41vlKvMCDU1nY0jNJJYskQRGBUXbO6IugKfBCu8O0cBKHoVh6vk+X0BrAvz6uT2Zdrz7xznD4b/BxoEHNGvjJdbRYCfa7nZ7whLivL7virApIpmtHuOeUkNqAAY8jypRyqx5m07pJx2J/UkklZkubvcTot1Fd3RuXPrkPPTBGp8IzFD3KW1VmRAOFvie3HPtVyp+3q/d6gZ3ZD3x4aOwQ1/xK97Ag
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:24.2408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1833dca3-0a5b-418a-8f66-08d7a69b5944
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1751
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Isabel Zhang <isabel.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
Starting from 14nm, the PLL is built into the PHY and the PLL is mapped
to PHY on 1 to 1 basis. In the code, the DP port is mapped to a PLL that was not
initialized. This causes DP to HDMI dongle to not light up the display.

[How]
Initializations added for PLL2 when creating resources.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 5f6fb16f16e5..e7076b0d7afb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -60,6 +60,7 @@
 #include "dcn20/dcn20_dccg.h"
 #include "dcn21_hubbub.h"
 #include "dcn10/dcn10_resource.h"
+#include "dce110/dce110_resource.h"
 
 #include "dcn20/dcn20_dwb.h"
 #include "dcn20/dcn20_mmhubbub.h"
@@ -889,6 +890,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 enum dcn20_clk_src_array_id {
 	DCN20_CLK_SRC_PLL0,
 	DCN20_CLK_SRC_PLL1,
+	DCN20_CLK_SRC_PLL2,
 	DCN20_CLK_SRC_TOTAL_DCN21
 };
 
@@ -1803,6 +1805,10 @@ static bool dcn21_resource_construct(
 			dcn21_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL1,
 				&clk_src_regs[1], false);
+	pool->base.clock_sources[DCN20_CLK_SRC_PLL2] =
+			dcn21_clock_source_create(ctx, ctx->dc_bios,
+				CLOCK_SOURCE_COMBO_PHY_PLL2,
+				&clk_src_regs[2], false);
 
 	pool->base.clk_src_count = DCN20_CLK_SRC_TOTAL_DCN21;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
