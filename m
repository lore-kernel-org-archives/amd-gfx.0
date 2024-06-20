Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4AEC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF5610EB1E;
	Thu, 20 Jun 2024 16:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="22R2hlV8";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E58E810EB1E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbGR7mT5wUfM3VVA2sJGudCNOg5KBVyqrTChxibV0oFAOQ10XNJ6KM0X96jO++t98crmKhFgTrtDlkEdsEAbI57TPQLJrhMcosD88mDcVsgNCAOBez1HSCJdknhBzBPkiNHznqMoOxSVM9vXEdt8OgbLrZ5ICQKS2BHzE8N2n9idu9KIjeeOBXDXwri8574/j9FrOn8qTRiw/YBza6J51HyhDP4CaJvlDk7ad8hMj7yeRNSK8wlxkYSLq/cA0Oqm0zPQgbZ8VRqdKyEazsCgaKPjDR4iZRsOgTaI8QIAgx4oVtq/65Yi0z/aoBl1CTdZisLU1YhMSdRtrgOMEYIydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K96wOpRJegZqDtVsnR+HI+gS9egQ+TYTn1gYle1ztY=;
 b=OJdfT6aSUx68whPuRgV4kIc4WUBqQXQ6JBg5Gnex8s3GjYyBvK9VE5DPGb8TGI1p7nqS8xf3AH614ubXGcd5oUby2IswbvhFNDaiTeXxdUdXvYkvfIYzJ5RHSvqhy/u9Jutq/A3QPh1Q+1Z8J8Ziw7HAWJlj+bbuRLb4HEJG/1xo+hHwmmiJXYzHIwbk2M/0pv7CmWrq+e2SgkX9+PjczuzPiNjF0hZedsadng9RgOYRbSh0/gKy7iWIuXb6wWpfd2uzP1vEK5mBx6SXF6BDsS2H/Udwft1x/6mMr3re1e9zcnL5aNzEx1XPFQZ6fA0YF5NlYB6B/I2V/E0dfcfvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K96wOpRJegZqDtVsnR+HI+gS9egQ+TYTn1gYle1ztY=;
 b=22R2hlV8RmZ+0DHwZVnIzz+52QR/jZfPB7OcbYErZfHdiMRsZaAjCih1juwBjGF6zhQ5eBIwm6SjE91iK87Mz+suH4pwPrhUZCypqlVQDFFX5g3p5GzuyWHhO/5dqoNxzzxIRsyLMGAvCVfBPutsnO7w7FWRR4+QpMYinlMVXlI=
Received: from CH5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:1f1::19)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:20:32 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::7f) by CH5PR03CA0003.outlook.office365.com
 (2603:10b6:610:1f1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 16:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:20:32 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:20:30 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 35/39] drm/amd/display: Remove always true condition
Date: Thu, 20 Jun 2024 10:11:41 -0600
Message-ID: <20240620161145.2489774-36-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d568634-52af-4d4a-5186-08dc9144e877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|36860700010|376011|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FNEskAIUq5OCdi2f7osMeTTKq9NwXeVjresD22hQQT/1Kj5k9f2H47aYTovO?=
 =?us-ascii?Q?Y9JbHbA/hqTTYChOX9vaEqD/rIdARTW0gZKyAbkRnqKIBkZQ2jG0FIvXngUY?=
 =?us-ascii?Q?DmWp9g5rJiHFKRwdh3SO3+KncjFVUHp7IVvXf00b1Z8Zwhh6shBOa6Dzr245?=
 =?us-ascii?Q?be0mHy6epyNzN9+3p4BEh4u6U0sq1TASFgYTt5SOcm8YI5a4M2ThF0L15fEL?=
 =?us-ascii?Q?KyRrLDh86shAFYg/6f9NO4pcM1Z1poHQ8lUpVAUZ6Y3Pqku7v3WtlpkYtS9u?=
 =?us-ascii?Q?KaYVnuAom76NjkMUIPdO6ovy3udFXVTMqaHlbTKORxMXv3lBrAOABk+DmKKX?=
 =?us-ascii?Q?FNjlvjlBVXCNX++Tu2QIv7CW1JeTahZbkyzQgqOwAey2UyRrlMTduT+iBwDw?=
 =?us-ascii?Q?ZMXl2CSNAna+l84I8DCcjIcgYCrVDU6XZ3hKwwzf6yZbN0JPv1W9k7ahCsQQ?=
 =?us-ascii?Q?CSBys6pLaR7TTSJlE10fdabswNjUH01b6ujjxe3lLZja1L09aJp4hDEuysRA?=
 =?us-ascii?Q?PYKE/bwlelgIORqYa/Iy4dMEuHCAI1H0z87jQXce9+6KWi870u/FEEozMXfq?=
 =?us-ascii?Q?Z4lnDOAki6fG8bCfaJzV6EGa4kbGLzXpbdrQo4Er/rNjpsZI4f6Q7ZMJNbZd?=
 =?us-ascii?Q?oDeskrH0QB7Xm3WdNZXweRrSSw7UCzWW/p72IwlWnhq54CvoH54shjrGBve3?=
 =?us-ascii?Q?SkEXpmHKclO/8ZZL/awTHxxmkS4/3YsYzntkB7zZKIqzjY0/PXPTVWj04uJ1?=
 =?us-ascii?Q?0fXkUvlap7MGakwMiWlbx76/6qRz8GCG98MlXRKQPo4C/VUVqysugtZCEkVt?=
 =?us-ascii?Q?Gx7JlZdOwDKa8RuaPQeuhy8Fw+1s0IKfVMRQ4sgolKOJhdtlFu4fF5j/lkA2?=
 =?us-ascii?Q?7o+cFsoiWj08iV5WPTPNM5sQs1yMmr4lxBCJlKaVjVskrRSeaaUJWV+qNawj?=
 =?us-ascii?Q?xpg+pnPZJ+5kwlu38al33xkIN/iTxRDA0+wFZn3ixYw5h+CewO8AnJhhlp75?=
 =?us-ascii?Q?UDAb6yCS8Q6LEtTGNIXnI1UcIIDUH6lX/sQw1uL6NBk2kLErWH68qaDF+MDq?=
 =?us-ascii?Q?DnX+urc5VyAylagfBIAqtj6mqzuymdhg2OQ9KLDsW92LTZjVm42xPrm52X/a?=
 =?us-ascii?Q?wx+wj5BAe2LK8wwlh1jUhtONKJfNTmEvuB0DDW/oiVCa3kvp3s3u8FSMiTw5?=
 =?us-ascii?Q?cUIP4vR/oXG4gnF7tu2Jg/65PxjqtV/Ov/rmGjWNSUPbQG+Cpc7Y6yv+7d59?=
 =?us-ascii?Q?QtsW4u+VQlEl3eynCrddHqpxunpEfa8j3+7q4dYVJdG+ymqzy5HinEwHPnoP?=
 =?us-ascii?Q?1HDXUDvAHRqDXH2ePHNF4NnUAxV7OUC7hPOcS1mAgtmYi7OKVgqH4FOgLAUg?=
 =?us-ascii?Q?1WqJIkwpvWSuXmhAQGwABrlcoa8hzwVPPxWHzULd4COW0yAmEg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(36860700010)(376011)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:20:32.2767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d568634-52af-4d4a-5186-08dc9144e877
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
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

[WHAT & HOW]
advanced_pstate_switching was initialized to false and never assigned to
another value; as a result !advanced_pstate_switching is always true and
should be removed.

This fixes 2 DEADCODE issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 90bb6e718301..60e2bf4ae6de 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -442,7 +442,6 @@ static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct d
 	bool result = false;
 	int drr_display_index = 0, non_svp_streams = 0;
 	bool force_svp = dml2->config.svp_pstate.force_enable_subvp;
-	bool advanced_pstate_switching = false;
 
 	display_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
 	display_state->bw_ctx.bw.dcn.legacy_svp_drr_stream_index_valid = false;
@@ -451,8 +450,7 @@ static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct d
 
 	if (!result) {
 		pstate_optimization_done = true;
-	} else if (!advanced_pstate_switching ||
-		(s->mode_support_info.DRAMClockChangeSupport[0] != dml_dram_clock_change_unsupported && !force_svp)) {
+	} else if (s->mode_support_info.DRAMClockChangeSupport[0] != dml_dram_clock_change_unsupported && !force_svp) {
 		pstate_optimization_success = true;
 		pstate_optimization_done = true;
 	}
-- 
2.34.1

