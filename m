Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F60BC4829A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C6910E3F6;
	Wed,  7 Feb 2024 20:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dBhdwqhp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A707110E3F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilM5A/9aWOZaIDH8hVwESqNGvGywcGzITOefvnU9ai9Amn+N2v8ndEDEhc6wVl37dbZEjDjt9jHa19aIOpRAtjHNMUl5GXfO8oVZ5t9caIbXO35egLLutBPeZ4uTb2XddUjdqyy7lGUrbTABsSA5pdjXyK40t6frd66eXDkKZ+CmgcWpznxhhU/2JnEm6FtvhfDHLBcgUe77XuzG4bEkANE9uZEp/ML+ss5PlJnpxTjzHzsLGK6Di1b5NEBJP4+/zvoupJQjmYoqBY/aSZKLwdQD74P7OTJJd5Vu8Xl7fQJC9grnAKDtwtPfPYMlXGjHER1cdcN46jCLU0gyd0EZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/tlx9/30bubbC7cdFkGZINhuAaFTYE4cDfOHGl0594=;
 b=Yi6wiuo0+2uaI2h7XRNI6OWwoUc1k4DtZTpq/9fVHUcYprl6Obp8UDI8E2EG+jEOHy8RvUfM+5XB6U3Wt3GEPH4mMgV7nXEGUOL05B9tMKOREK3pYWBYq8X+rzu4leJUn/NmKt1lDmiXyC2UoXJcPzEuhtXy9sr8HlroGjCZ038ghOjMFlJnkpcACJU8ou1kfA78/kGd4tzFTExzGTB+670HLU5Pr9T7cGvzUPgHI8r0dDWW5a99KKdFPSW99dRq45Q/oGAAGTEX15g7S0HR6UECtQy9Lzn6navPvSP2JFIxBuqUhW0gdDwu2lrsblyGlzKkHO7R/Y98QpokuBh4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/tlx9/30bubbC7cdFkGZINhuAaFTYE4cDfOHGl0594=;
 b=dBhdwqhpinLkjSC2Dg1YGdqc8c4/2R0HPLEa2wqvtJVUGEgOsZJbL6E3VztN1m7Ngn7WjpfYWCa8l7LcYSpLDVID35hXtXpom1u10MeimIRvXcyKK5xEcTYVV4xhHN7scmxHS/M9j27NfJC8KKJf3BEXsnVo4CPewFSP/LXi6lg=
Received: from SJ0PR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:334::17)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 20:52:16 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::a9) by SJ0PR05CA0102.outlook.office365.com
 (2603:10b6:a03:334::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:11 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:11 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:10 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Gabe Teeger
 <gabe.teeger@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>
Subject: [PATCH 04/15] Revert "drm/amd/display: Send DTBCLK disable message on
 first commit"
Date: Wed, 7 Feb 2024 15:50:39 -0500
Message-ID: <20240207205200.1608684-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 47cd5604-7f68-40e4-676d-08dc281eaae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKhr8kw73GBcL2zc/6gPkunq1EjdD6jeTJXyDpUb2vjeM7WehGHdaNeI0nuAGi3tgqMHw96VyrroTgQnJCGz/cQLBe4q7Pcxf0TZsPW9fYNqFwNRcDKnZ7Eu0DP58kWz69tP0AqoHYP8D8Z/oQFg+CflyA9fUrUUZzfEtfz5sWjTbz/MvJVgzyls5nRi8IXEDLt7es7RI1yNxvOTglsplxb8lrvPk5aVAXGIAL7vCdayh5X2LJi9dsBWq5jwcdg8SNkXPDLnwBrQM4sYSbNDGISQ1LYcqLPnoMFkaZU88UYSrokhrXa7xruZU1prGXcgUuWmQhDsa2dd+2OhZAxBaDfLRpT/mtmNpsmCckdYVa3tiGja7vMZZsRLaMzVKBYb9unqwLX5bSRhnLeJeK/KGbOycJBMIXgZfz/I9ZyC4F/zrVSTYYhGY147dUxXqq5fwCL+BQ3E5sMCiU23XDHH4nLXCF4sMGmKpa8YAnyYNCsYkyG5pRD8OeMDTPrteWuvZSGp4YPHzI/BkIi6vlDml3elJ4Ie8ZGgM0+4/Cq2d3rKtMR7SpjJ4e3/Bk7aIve0Q8n8sm6jNQNZfb9L8DEWDiyhcXtrl6PSb4qkoO1TM3c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(5660300002)(44832011)(2906002)(41300700001)(83380400001)(86362001)(26005)(1076003)(336012)(82740400003)(426003)(2616005)(356005)(81166007)(7696005)(478600001)(6666004)(6916009)(54906003)(36756003)(316002)(70586007)(8676002)(4326008)(70206006)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:15.8508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cd5604-7f68-40e4-676d-08dc281eaae9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

From: Gabe Teeger <gabe.teeger@amd.com>

This reverts commit 3fda240dc2f6a4a9a3965b80cfb83d0ddfbf489c.

System hang observed, this commit is thought to be the
regression point.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 06edca50a8fa..36e5bb611fb1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -414,7 +414,6 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 
-	clk_mgr->clks.dtbclk_en = true;
 	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
 	clk_mgr->clks.p_state_change_support = true;
 	clk_mgr->clks.prev_p_state_change_support = true;
-- 
2.43.0

