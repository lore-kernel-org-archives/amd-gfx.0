Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DE7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 18:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E14A12A7D0;
	Thu, 30 Jun 2022 18:46:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52DBA12A7C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 18:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne5fwbuMnS1AZPgpkCWfMRM83/1toyvyyDdYwTrZ/220VxOeGsdDiJMCFhCkqLB5KNq+ruTxdInbJ/cbVb4u0YExfpSprRQY5HgJD7Hg0hP+aB0uyI/5yC6FUKRXMOfJY5gQfuVQs9GcAGIhjjyfEq34h1bovWq5P8mL6w15Yl3JumBSwWJHpSKeKNH8vCHgyrJqLf4B3L1y0exRbn5pQG6c0oO1l3nP3XXleNxJ+1f+7bQ28OsptEs98hJvDcV0OCjxmjxOuMAt2MIVuBst3KIrzijYIQO/pnVKuNAO7zMvCArDkp+FQrGmu+KJohvkYgGdSdb5X+w6j1yUMUO7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5GSy7r0PmWamPh9lyJdAuyIZX9E8zmCu8zQiKJ6ACM=;
 b=hZ9yFJUo1Fzd2RtLNYbmp4cgg9I9vPVWkfW9SvTN3TwBt3fwkcxpyN8auofRMlzUlJx/QPsUlnHRFbczMZ7bJK0ZDpq6Y9eDl+l3kJWiIQfb4sXG5BL8coCJAaF5QsklaLffCpo1RNjBko+iv6t3ZxZ/pXCUdcJgphg+Cf6hidTcBN7Wj4kU3c5Y184DcFMNash3IgQpJj380AshnKB+oX6kPLnfiKyQVDlb9A5q4kSHAdIKQqPYaSqu6bVxadCv5lTbm96wpkSrpaYybctw2Cu9CI5dsnALa07mq9XP9nhis43DPxOtaxGBQa45rdLg3SUXgaJVx9gngGLvPs2zgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5GSy7r0PmWamPh9lyJdAuyIZX9E8zmCu8zQiKJ6ACM=;
 b=Z6OTA5eyazTjlkhJhJhSns10tDXSpMgeRr/+Hq2lfSkle/lqxaw5lsAgI8B4jnrAPlqRqGAbBLasqk/jontkTmpDF6ZJN+oOZbbYOjXPIBAY+lx5pMiBx7tKePCm01VSaKCHB4APU9jxpqxzTRBqRdMOG83HhPb8yp8wSXOjP98=
Received: from BN9PR03CA0068.namprd03.prod.outlook.com (2603:10b6:408:fc::13)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 18:46:39 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::9a) by BN9PR03CA0068.outlook.office365.com
 (2603:10b6:408:fc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 18:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 18:46:38 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 13:46:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Randy Dunlap <rdunlap@infradead.org>, Leo Li <sunpeng.li@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amd/display: Fix __muldf3 undefined for 32 bit
 compilation
Date: Thu, 30 Jun 2022 14:46:20 -0400
Message-ID: <20220630184621.874253-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
References: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b5467b7-b7e6-41f6-63bf-08da5ac8dde0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjCCFJcF/nUQiI/hdtobuaKaVuWNmbdxy73TPhsoK8u5lX3nxMf+Rju+LC9rkAWLPOeABoILrdOk/3zWHghl49T7eqLbwH732RCGtV6nlrZTgWo6QuCb7Sbx2r1wWGwwtRKH3l2HI125gL1HoEHo+p6coc9O958oPbBHSh1d015m3QI8vv6efhApnWcQWi64rcZrrTmp4RvZaMsFS2UvOtyb2sLZccJlNQiLtTlfmosyTCJBWhzpevNqS79vyIHuoJbWIUiddpNRThU5Y1QKi6j3WaPAAhorL/SAj928wTx9Po1EWuqErc7wJEM0ojar6NMFMid6jeuxzBFw0+fbX5tgQQBK175w4IJnoDTh5bAF6r+yKlkPvJvIJRNHkM7RMtQc1cjYg6tCReKI4nNoHgb5B2JF9HH6TQFv2Fjr8peefRxG/Y0zE/T3W/V/pE+MEVFZ6fs3lMF+NYqP1WaYk4zqvJrmU/a3xHSmRM3S0A8es29YltgQsX8uSIhKf2PMx+zp4weQglmWT8EBWGMVKmDcs5URdGZPcLfqDWDIsL/8YDrDKtizUTNUKYZ+1s3WfNky8nCBkNqXfX5muoyFZJSvB8QupY9ZkMkLW1eD8dWN/fkxfp/03YAWEHEqibJQ2ruI0+ESDdtUC4ASDf268ooGSqfSXaAZQaQj/VGQI6SGtBmV1E05NMhlJ3qQCQjGM0SE8PFtI6yBzWvbhYt4TlZetRojryqsahoRgk16oJFIuOlHorDmlrDr9NFxha07bRJtdPdCmmJ13Ie56uW2FJIZeA7LIbZg/Bz/AE71A77TJIdsvpFrv86nm5A3hn20f13czPQcLDWXCizOXtus4Yt6e5EQVlDTZ5jTWh+4XB4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(40470700004)(36840700001)(46966006)(110136005)(5660300002)(82310400005)(82740400003)(41300700001)(36756003)(6636002)(2616005)(426003)(2906002)(40480700001)(54906003)(186003)(316002)(40460700003)(336012)(6666004)(478600001)(81166007)(26005)(16526019)(8676002)(70586007)(36860700001)(70206006)(47076005)(86362001)(4326008)(1076003)(356005)(83380400001)(8936002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 18:46:38.8150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5467b7-b7e6-41f6-63bf-08da5ac8dde0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sometimes when trying to enable some feature, we have to define some
values with educated guesses, but we mark those values as TBD, which
means "To Be Determined". However, the correct way to approach it is by
loading that information from the firmware. Anyway, some of the values
that we were experimenting with caused this issue:

ERROR: modpost: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

This commit fixes this issue by removing the division by two since it is
harmless in this case.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Fixes: 9b79abf79c414 ("drm/amd/display: add CLKMGR changes for DCN32/321")
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 4e8059f20007..b49a4e34d39b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -213,8 +213,8 @@ static void dcn32_build_wm_range_table(struct clk_mgr_internal *clk_mgr)
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].valid = true;
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us = clk_mgr->base.bw_params->dummy_pstate_table[3].dummy_pstate_latency_us;
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.fclk_change_latency_us = fclk_change_latency_us;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us = sr_exit_time_us / 2; // TBD
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us / 2; // TBD
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us = sr_exit_time_us; // TBD
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us; // TBD
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.wm_type = WATERMARKS_MALL;
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_dcfclk = 0xFFFF;
-- 
2.25.1

