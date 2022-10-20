Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFB2C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407AF10E663;
	Thu, 20 Oct 2022 15:48:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA9F10E177
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Scp1ayxFsmTUo4sYMPe6wx9CE9/+kyQPvn9w9TBzr2mCpGAthN9571I8j+O2EG+cd9Ee7Gc+mYgrczDW3lsAMs0Qs7KlSWRVI3Z4T+SpR18yGNYveMBOhdmXNRI7WJ1adO5FilL2DQvowvHIvkWQgRhOE9MqG/5oLV9EwmNUVcusviWvTEdF1Gj1VDAFHQISXEkqgHwpn4WJEVLKlt+cwUYbmTvly4bPt5Y8dfPuhfqTJGFTqUmjUnaR6RUYBGt3j/e40kO9GviWSIJox8U8ZgkSjR2ecXtwY1jSF0QP/E65NutbCZVgAlQyua8LQr17gXqTA3xkRvEc6ncTFeyRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL0X94mnRWBzN/lN5XEjoP5eYNoiQVm50cXxlzW9aNk=;
 b=E9A7XxeG0PzLKb009HRyplyKXqTLjMrwz8Dq26+GKthgkIF/t5j+Rt1EbdL8P0wEpVLZ35RUlsZeZc/JORWSwutPMYzk0S1EI/rQ1x0syYB7BbKaxxePlSCgiH9aRMfTRPbTRAHf2GVpuOtSRzEuaszpSVbsYe+BRiJipH6c6PynFoGPrpFF+0OhFMfsPj8Eyi0yJvotH/VPFDa62EJenGCIRJdEiq2RYL96Brbhe1qt7pC0zodxV0cxNjc4/wPKLlCa2IsBPd1+tf3m0le8Ek2QsPsc9RZCL5szAOUoBjX1X0CN/qcWicHAoO/vH/QgO7E6jUFgWAR8P/O5lHtHPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL0X94mnRWBzN/lN5XEjoP5eYNoiQVm50cXxlzW9aNk=;
 b=e5+HPTVvBB46CDRW+9dWHUdkUEcr5IwgNC28p9sqUpbhDduhR3Qhnk3LcPqaMuA/hxYKZoJdwnibEsgubNX9FG08Zu4rVYaG4QXM3oIRugXLQlXWvVN8go19LH3btz+peDsZ4paQUenuzalApzrz27JgsXMfvIG6zQ6OvGDWp3s=
Received: from DM6PR01CA0030.prod.exchangelabs.com (2603:10b6:5:296::35) by
 BY5PR12MB5511.namprd12.prod.outlook.com (2603:10b6:a03:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 15:47:56 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::3a) by DM6PR01CA0030.outlook.office365.com
 (2603:10b6:5:296::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:55 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:53 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/33] drm/amd/display: Limit dcn32 to 1950Mhz display clock
Date: Thu, 20 Oct 2022 11:46:44 -0400
Message-ID: <20221020154702.503934-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|BY5PR12MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: 394305d9-e644-46b4-922d-08dab2b274be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 103zqV9U1flPn+KlvQzJV/K1TXN1NonTbfm3xuVxYfuPA1Pfy5mJYGN2AGXI/VeQLkICZQfKu3PQI1DoyNHvHo6frFLKw3jtHoNms+wWTruOTsXWk01U+ICVOlpPdKa+as7xMGtAaHi77PMa2mAnU4V/HMLoyY01rWCQgXHeOkIddSakDf14M0mDCfIhKfVMgRoWQCYRWMmKk4ZchQQP79ajxC3RADgmpgBnVDaXzhxKV//UHu9QFQggfkXheR4JvFw9xVANigbS7L4UpSL79L8whRUhYxvq3rYBESijFB7Abcdd15RYpYz4pfArl/CEHmjCa0uyS9g8RbV7eVefiZEtpLjEmPPUt+Aq8Cp9+pC1KOO3FFuSq9dmZWIW5xibc0sLKwrrePCgXblyL7l0ALnne6NATsNJbB5EvBEbC7aDNzVzXLtSUkNcfvWrN88w6J3UlrVb0wqMskJSAYWCNCmJ7k38kyfIg1vLy82rAUBJn68w7wSr4QrJNJp3YhrRgIZ5G9caRQu1dBNywlzev4WhhdDE+GdC5/Eh++7PO2x2XgebEPPm8BQeYuCHIqrbOn2PY6Q6snzBVVR3hxvB/UScUtRjOMV41/avNkZ/lZOIO8bfoB0Oj7bPQZAbjlZYe2r2Ax0BuAR28i4+0Hbgt49QjunUFy56Ip7C13sw5OpaJKstV8sc2pINCZDfeKxTD7GfdEAiJrtP+QKiYJ2EDVleDhoJWibelAjziW0YceQ4i2y8qzpzzD7nLSXo37tHKTMrTg4SLVWnjzg4xajQ3mAOn9fRA/SFIYQVBp5hRRlRkaSY7rbrQs5Bs82z4xOX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(40460700003)(26005)(83380400001)(86362001)(478600001)(70586007)(70206006)(6666004)(7696005)(316002)(41300700001)(8936002)(4326008)(36756003)(6916009)(54906003)(186003)(2616005)(82310400005)(47076005)(426003)(356005)(2906002)(40480700001)(1076003)(16526019)(336012)(8676002)(5660300002)(82740400003)(36860700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:55.8290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 394305d9-e644-46b4-922d-08dab2b274be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5511
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <jun.lei@amd.com>

[why]
Hardware team recommends we limit dispclock to 1950Mhz for all DCN3.2.x

[how]
Limit to 1950 when initializing clocks.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jun Lei <jun.lei@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 1c612ccf1944..fd0313468fdb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -157,6 +157,7 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	unsigned int num_levels;
 	struct clk_limit_num_entries *num_entries_per_clk = &clk_mgr_base->bw_params->clk_table.num_entries_per_clk;
+	unsigned int i;
 
 	memset(&(clk_mgr_base->clks), 0, sizeof(struct dc_clocks));
 	clk_mgr_base->clks.p_state_change_support = true;
@@ -205,18 +206,17 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 		clk_mgr->dpm_present = true;
 
 	if (clk_mgr_base->ctx->dc->debug.min_disp_clk_khz) {
-		unsigned int i;
-
 		for (i = 0; i < num_levels; i++)
 			if (clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz
 					< khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz))
 				clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz
 					= khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz);
 	}
+	for (i = 0; i < num_levels; i++)
+		if (clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz > 1950)
+			clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz = 1950;
 
 	if (clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz) {
-		unsigned int i;
-
 		for (i = 0; i < num_levels; i++)
 			if (clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz
 					< khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz))
-- 
2.35.1

