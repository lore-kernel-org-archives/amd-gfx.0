Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06548C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F7510F484;
	Fri, 17 Jun 2022 19:36:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C5710F400
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9gDT2C/Er+97VJoRnNjgUvJgCWv/CfItHMcJrCQdCc6Sun08s0+CjYUIQLpneDQJsalO7qP7etLiXdzWo51rOf9VLfQO0yXfrqsiWrZML/BtImhIV95nqkNjWIceFt+Gx9JtO6i8tbVGc49RuwGWhjsx1fBGqp/eLdjz23oYntGlZeKhbMOOiL5m9vPw5t20orxbKRqIxLHCZK9/D1JmO6S/DUnn8pFDUXjN0IThtjY0KaAbhzBSwoCe2uP4eCzIviEr5T+4xYSIrv/r3TwhbzSVXtzPaJfi8aXDlR/Qd1HHvLRy0tjJxnDELdAlhwZoSnxZXSxrAOZF59d7LHEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6g7F2Pas2KAPy9glU5zEhlMOzsrvP8e+nBEdom2iX8=;
 b=ixPDvPcot+p8h84oyCOsVk0t3mVHpqgnRcO5+nXYAw2GWYBt3oYdGIkAuVzSFQm+T82gPvYmuWRYDwxWCV3mn8KugzISt66qU5uSh/ig1T/hPL01PrGwLF3brRAdQ+5DGTscYRBE9yzSuJDX4WOwN5vPVOm/r72CjLYamvaVvqUgCjMvEk9hNmfleSUGZ5eMRThHWBNChyT1OO0+I+ZYuJl3JF0MAHh9mbO7469XHd5Uso2kWa3eSrzIAU1yK1h7czT6fthsY0zoo4aOx47h8SXlu/A5y8qjUHTBShsCs12krNGJkvr6f6QKP5Ltkc2CUDWqkjh7Iu8wYx6q+bSyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6g7F2Pas2KAPy9glU5zEhlMOzsrvP8e+nBEdom2iX8=;
 b=K8fGBCRhtzR5+28G4WoWJTe+uJ9KxMOLG9EUDC3QEpSOzIHwZ8TuXptlTpv7RhCo3WKdHUQuOW6NCMzyavh2xLfjSDGh729qfgtjy46+wH5P+eo0j/8ilhRuOGsGm20PAeLCFfc2c2ckZPUfTPf8oQhS3WIR6NZDopeAuoLbn7g=
Received: from BN9PR03CA0767.namprd03.prod.outlook.com (2603:10b6:408:13a::22)
 by MN2PR12MB2927.namprd12.prod.outlook.com (2603:10b6:208:103::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 17 Jun
 2022 19:36:07 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::6e) by BN9PR03CA0767.outlook.office365.com
 (2603:10b6:408:13a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:06 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:59 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/31] drm/amd/display: Check minimum disp_clk and dpp_clk
 debug option
Date: Fri, 17 Jun 2022 15:35:04 -0400
Message-ID: <20220617193512.3471076-24-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4dbdea6-2e46-4f9f-9a97-08da50989fa3
X-MS-TrafficTypeDiagnostic: MN2PR12MB2927:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29274392D25954CCE9821E4C98AF9@MN2PR12MB2927.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07U421KSz6ZWKDa/GPBtwgxZCN0USishsSvOTSr0nEcvNiPqio/TpfA9KiQT0+TgCBtPtOIugaX7QwEmHpZx9vn9mGe90fq1Zu9fzOxO1QWvthugROpjK8ZSAXkYa74r3dS1XfGbjMeBv+eXofGRGO2YWm63qPcWeBQ81Om2FnjaxD93JDc2GC6XL7LD3+m107304i+nfaKfmZcr7HRjsyAWSaZUc4bCgevYwbuX0Scr9S9amg84h3S6HeFMbmQAW8jccb+mnMr/1JvaRVGSzKXRAm/p1Kx2N27lf71kwPl0xXI7c0B+l4ebs6NTyKEmmTawq56OyBlY0tGdoGickZieWu2s69vuCYDElPhfFcKhRO0t11pRyr04K+s9nRX0iB86+eWDboKKV7J2GEJwTJvAOvWzmJU/DETPFvkDNC2YlL1xwS3ZHmjgteezBVBOBEI/TMljqTEwqUXf46MbNQIUbZDU9UM6PQ3mGe5NesVlLLwF73phgy9ddP5Q0kucIvY+41RMarFNjYbR98GH/l1q9BPqgy1hooAYA4pu1WqfAUVSRMcDsRkfkhFR3pC2o96fbFnXjAaj6AEk3KtSZqroGYeHCXI+cjYvCgd7o1uSlXQ6I915oSuVQbocnSQUNVsGnt9j1LS8IGOnFB8nZsF4f8TB8vXIwSLXKURRQC5nF+ItwTkzyKWnBv9VNH+V6xgupmAHJYBxSlLlJGW7Xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(26005)(54906003)(7696005)(47076005)(1076003)(2616005)(86362001)(16526019)(5660300002)(186003)(82310400005)(6916009)(426003)(316002)(40460700003)(498600001)(336012)(81166007)(36860700001)(36756003)(6666004)(2906002)(356005)(8936002)(70206006)(8676002)(70586007)(4326008)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:06.9271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dbdea6-2e46-4f9f-9a97-08da50989fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2927
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Our debug struct has the min_disp_clk_khz and min_dpp_clk_khz options,
which we ignore in the DCN32. This commit introduces those checks and
the necessary calculation.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index ed70ae10bdb1..b32880afb3fb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -265,6 +265,25 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 			&clk_mgr_base->bw_params->clk_table.entries[0].dispclk_mhz,
 			&num_levels);
 
+	if (clk_mgr_base->ctx->dc->debug.min_disp_clk_khz) {
+		unsigned int i;
+
+		for (i = 0; i < num_levels; i++)
+			if (clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz
+					< khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz))
+				clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz
+					= khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz);
+	}
+
+	if (clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz) {
+		unsigned int i;
+
+		for (i = 0; i < num_levels; i++)
+			if (clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz
+					< khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz))
+				clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz
+					= khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz);
+	}
 
 	/* Get UCLK, update bounding box */
 	clk_mgr_base->funcs->get_memclk_states_from_smu(clk_mgr_base);
-- 
2.25.1

