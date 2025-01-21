Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD448C0218C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 19:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ECA410E631;
	Tue, 21 Jan 2025 19:40:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f8MNMRpE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB8210E636
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 19:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCsxtgxtwXmnRuDTM448lM9cWTGBMgUCDL1o9iWDG14ASoUFJRooEvZY4ddr1IFMpjXZOFBCeM1IQvK/m+6axMHT5COt7EaSMhMblaMOkv5y9nq+C+Mz3FXQ+WViKqSYQjaPcXdk9uuRAsK/tJt1fERvq16/czbNadMDCBR6t/mw8admDzHTsCquikSh87ERgHmDMKo4c/yhYXzOK7a8CoXTfLBsHGN5SHMrGFqBlNBJZ3ekp9/W90CV4MJ6tmzmThGdhMksQxetJzGNjSUrGnNdnkvZ1K0RFWPkAvb/NWoYpTX6W6EKzKAdYno7BcCI+QpVFBjR29V7u6hhtSA0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X2JOokrwSwMEn1skXTS7AP+3PVT2yZN2+1jB1eLj7k=;
 b=w3OSuw9wEPpz1idTfjK3fz1G0D5BT/EaFSjqfN3q/GQ+ZKAmdCj1QIZVn51LesbUaYnymdT3nyaO65aWKEe82LUUO7/OkcQlgLIs5z5u+Il770J2/dMZkc/qPnaW1I05rsUDU4tI91ND+jtXTTl2Ctm2HSgZNK1iHuwGse43rXIAzg5h3O7/ZrVk5OjuzSeACfGSsoa0c447rwBcURW3gQYtR6Cu73nWR01oYi0MR5SVG/02Bf3bj2jzzJTbw5tKe68q3GbSFpY+GmajjE7DwAApPtNysA5O4pgKCgzgSTXCeRqZMOYDkORHwX/K5TjQHitkCOTfj3lHkwxp8zpLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X2JOokrwSwMEn1skXTS7AP+3PVT2yZN2+1jB1eLj7k=;
 b=f8MNMRpEKEB16Hve55TMG9NRtlqQ2d25tNT82tRH/31LhkYAMSKht+FgjuRDmd8EknZW4e1hU+xwKvrRp7BgbgxAz9DtW/l3rMP38bf/QroQO2LXtxUHBezlKLJTP+nZeQW748pfBDvobr8DutKqTakJrdguzqWFhj37GaGtCUQ=
Received: from BL6PEPF0001641A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:6) by CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 19:40:17 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2a01:111:f403:f901::7) by BL6PEPF0001641A.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Tue,
 21 Jan 2025 19:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 19:40:17 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 13:40:12 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Sung Lee
 <Sung.Lee@amd.com>, Joshua Aberback <joshua.aberback@amd.com>
Subject: [PATCH 11/14] drm/amd/display: Guard Possible Null Pointer Dereference
Date: Tue, 21 Jan 2025 14:39:16 -0500
Message-ID: <20250121193919.3342348-12-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: b63d3682-f3e9-4e26-5c5e-08dd3a536f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vLyH9QWhiONZ29/vRw87iFscuNS5NP0Dznuj6dICac+sk9B6V/yJcRkfjTjE?=
 =?us-ascii?Q?e+6cd3AFsSp68ImWpobacbxVnrEYRletyaRigQD6/Kzkm1lmstG2+6S7Usfc?=
 =?us-ascii?Q?BKqdRo31WLyJj4Al7Kdoy4scc1TgurM2HnYdiqIG9dFOY3e77+8dM7+8VGli?=
 =?us-ascii?Q?+DOxfH5Vg6uV0D+DgGv9eoFep8Kgg/cnhljC6QB4ha9KxHG+gHER5Gm1Tslm?=
 =?us-ascii?Q?ehWNSpa0Q6Jj8DK0OFnvyH4KeoEvlvw4hFC/hBwKeXsW33MliSVVInYNoFLR?=
 =?us-ascii?Q?RV9l0B/lNVG+0LMldeXPfKH8diUwEg5+Lk/Pr0LeEn5oJvoKJ/5zm1aB2UuM?=
 =?us-ascii?Q?FjcN3TD8QDEh3hKzyWgADAKo9HJDBAH55hYCEQUVUNEvRGYujVT5HI6EuWJ4?=
 =?us-ascii?Q?IMaPLkrO3uCYWVcZqiCHQg/DzHGrZ3Kj53CBENYcq4VHiVgnuIC10J6KNKAV?=
 =?us-ascii?Q?ZafP+kXnnOPVQ0aM1hfpzqNr/j99SUekMunac0YeOvg4JIZ+EiiPg2764t/9?=
 =?us-ascii?Q?jU6ClBjAtRT289Ap8TCu7T/cQUBl2AObsnzyBtaT3rZOOKN0XDK+KwZrrvC3?=
 =?us-ascii?Q?4oDMH0NrVuvdo41/Mf/LObKDTdw7bFBIAkzbVfJjKgmqCpYJcb97r/dway0A?=
 =?us-ascii?Q?xB8HGNuW5qOyLyZO8j+EP4UW1oOHv9mqZcislxnQsXxgURp/tnt1bBc/g21x?=
 =?us-ascii?Q?zJP9hZhd25hOgIMV37C77caK7LAX5hFyDZnoW1orhEHLzr6YWgEnXe9da+DQ?=
 =?us-ascii?Q?viq3F05PYlJLv+QHLBqgLCi4z316nhLJWpaxPNGDZLP9PQjLXZQFtG22gey7?=
 =?us-ascii?Q?HAuJQi7j5plvK5fpBzUNSTcASUPZK+KUIBM1eav1Y9+HMxRoXZa/AKZ+0HZU?=
 =?us-ascii?Q?44wjXjYP93T1YJ0ndEiZnM332NKqE4Jy/laICdOsw/4PBrN/bFcy7dI6U02m?=
 =?us-ascii?Q?J66RVc4sz02qKHNYp3U/g4ZyPgkFNc0194n9+sIpRry//Xqz6H86hp/ZFL67?=
 =?us-ascii?Q?NMpqFKtJIcDLnGRyf/Ra2gtN/HBEjTmT16/VDyNn7XPXctzxHVW4tMaYEotd?=
 =?us-ascii?Q?r+3GhQ/r1qcxqrDmHz5vHi9pDFjMGmYNdGBRdASmP9h6lucdCG2ArUl04gOk?=
 =?us-ascii?Q?xQxZ5powqePZ3UlAG39TMwi8rrDZ946pa0/PeLur37wnD2NazX+q79tQngAO?=
 =?us-ascii?Q?EvJDt9laF4AksJ2VaZ6QD7p4Y6Vv5wyTVIbYogPKmLMWSCiTCnH6Y77/Ff6+?=
 =?us-ascii?Q?iYRHvtRoZSO6Cvmp7ZYzg9OZg1j5kOUSi2jY8iehsZeYg4+q5WnrkSCCoaBk?=
 =?us-ascii?Q?dmz37DX0ZlwhE3MiwYh98fvWl/9jR70LFpKC4NhoCz1m0QPYJIpfjGnKup1T?=
 =?us-ascii?Q?2HOF8rdhogrGPWClEJd8EqOX7Z9VJCBjg53ju253p8Cg7C6lTwLuSCZR3gNK?=
 =?us-ascii?Q?r0/Bzjk9yN93j9pflE7oGSOTZP9bFX5I0XbrPyTh/r7rikJQn8Ce5J4x2aHP?=
 =?us-ascii?Q?RLBRqlqCSlOKJqg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:40:17.6614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b63d3682-f3e9-4e26-5c5e-08dd3a536f1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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

From: Sung Lee <Sung.Lee@amd.com>

[WHY]
In some situations, dc->res_pool may be null.

[HOW]
Check if pointer is null before dereference.

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Sung Lee <Sung.Lee@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a8b0d558b132..3ebbb59a22e3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5553,9 +5553,11 @@ void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const
 	if (dc->clk_mgr != NULL && dc->clk_mgr->funcs->get_hard_min_memclk)
 		idle_dramclk_khz = dc->clk_mgr->funcs->get_hard_min_memclk(dc->clk_mgr);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe = &context->res_ctx.pipe_ctx[i];
-		subvp_pipe_type[i] = dc_state_get_pipe_subvp_type(context, pipe);
+	if (dc->res_pool && context) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &context->res_ctx.pipe_ctx[i];
+			subvp_pipe_type[i] = dc_state_get_pipe_subvp_type(context, pipe);
+		}
 	}
 
 	DC_LOG_DC("%s: allow_idle=%d\n HardMinUClk_Khz=%d HardMinDramclk_Khz=%d\n Pipe_0=%d Pipe_1=%d Pipe_2=%d Pipe_3=%d Pipe_4=%d Pipe_5=%d (caller=%s)\n",
-- 
2.34.1

