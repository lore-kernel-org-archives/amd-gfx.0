Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E34C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 10:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E22710E4C1;
	Mon, 22 Jul 2024 10:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qOwRRHYD";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1617610E4C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 10:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eirdFEq/du1GMJjfhBsW7fvkUYVhHqOikcB8vORZzUFh1vnZHP1ybHUmUGThgWYHeIMlA4o3ytK2GILWYfT3tfDsgR4NNvJ+9he9Rz4uac90SFDSWQZGwk2yq5DmumSB6qbjGD8ZlcIYaKWc6pq2OgoSPV+Cj0fP1NsNdfzCpYqmJ6NzBa8cIl38oQjaEzwxzA7NUzpi7ovSuN7SJfhuLOPJQ7Q+WLWrmJUhwc3SBibyYR5s3i4ICv/jfadcT/nlv0YiDLGj0sOEbjZaoAAPeHKBUI5MIFkCq2yhCHbD6dlK0VfVi2BQZagXUnvWjcZZ4lNsV8S98hXY8grmL376wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBrLfta/lhPzdcNPASVjB6OqDpgGWkntuiVm0khnzyM=;
 b=aCthKXt4vScUwoW1+P4PtqxxwccQPFwprdaZ5xuHLZKiTh07gXStqDwqtIiTCK/qAmq/jeyy3Ojm4qsfkn2NUANclTBXO8UUKZASeVIwee3ZP0iJUWRuTC1pNxEW69OZSGdC/kZ2IB1jB92vFXCqPBrS/jyXFDq/i6yCOntxuKNySlX0425xkGeyuO+mqHFy8To1YXfc3oN8diwGrEYXzyG6NliiLblyvHtLfIhGweljWAFBiH8Vp/p8j+bim8pHSo5+gdU9PhxvY1qeU3s/zt+ZWCDbq+jm13MCxoOSyby1RrWrsNGbqbhmziZNu06iikHBu10jKuIKJQDR2eO+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBrLfta/lhPzdcNPASVjB6OqDpgGWkntuiVm0khnzyM=;
 b=qOwRRHYD8Qp7VhEUxpUguidyhjAHvj4ZHso8ltonCR5viR+IbCWKXvf1ck9xm/gk6u5fvR3rzRkZrRP9iIcxmWwzFwgl0k3mQJkyRpjVKEZAHWrMhlucPSM84ya5Fkt43KKGEHWEqU64INMu09ho7tjncpvvu9oMP/RmIL9i3tk=
Received: from SN1PR12CA0113.namprd12.prod.outlook.com (2603:10b6:802:21::48)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 22 Jul
 2024 10:51:38 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:802:21:cafe::e9) by SN1PR12CA0113.outlook.office365.com
 (2603:10b6:802:21::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 22 Jul 2024 10:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 10:51:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 05:51:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v2] drm/amd/display: Add NULL check for clk_mgr and
 clk_mgr->funcs in dcn30_init_hw
Date: Mon, 22 Jul 2024 16:21:19 +0530
Message-ID: <20240722105119.3849289-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
References: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: e664f822-9ae6-46a1-be0b-08dcaa3c4340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FBo1XhjlBWDBr/OG9wT+eip8ldpWxrIlVbcvurKfEFVyXFBiILBb3OHp+rb2?=
 =?us-ascii?Q?7nVF9y47SKfFMFxLZsfSVkrvS8eBntHmX7knHiTr3uRZq96FtXJ3mftyyFN+?=
 =?us-ascii?Q?pWNlJzvmW2eDxb4cLlYeaGzAr49jz0pLypgRr1w/vIg15a4Yye3Olk8+f+nG?=
 =?us-ascii?Q?reZMezvdsyZ4eQe6IxyuMTdUVcBpfE2uUBRoMMzFqsXDcz9LaIrVJXd7geHs?=
 =?us-ascii?Q?3MWqcd7ufbHearp9dZQ/aH1ALuMfvmfiyYVAE9mHlrYowwNX4OCidp2xCH1x?=
 =?us-ascii?Q?Ob7i0wHykCc1uwGFXAqZzrAmaxyiQw8Lma+WV5B2XsEDAfiQHD6N88G2xzSy?=
 =?us-ascii?Q?IS1OQEYPtsu82mzsMx0hZsxztsbVvEdTWfwFoup4CvHit5MPGWdPwkbPUAKu?=
 =?us-ascii?Q?gyKq3ldXKQf/5asUFlvZW+UXfytSKBK2/BKUQyc444oXk7niuMQnx/1CMjpH?=
 =?us-ascii?Q?apM19zSpUlq4eSk5vVmJxsjXQOMEjWin7dsru8JCYNDqVauOeLMY2hJINurC?=
 =?us-ascii?Q?XGG0H1RfIPUGhLWsJJnPV34KIVu6edcMOO3NS6q0P69NG0z8oQSPSe/QOlhH?=
 =?us-ascii?Q?hOSFEJcZsKLuhcwsNBRSrNRhptei3596rd893a86dZw7RAim/yYJTDCnvPsy?=
 =?us-ascii?Q?VeApp+VdY/w3VEAmnkM7ljSaaqE96oSUftCqT0aJTzziEe6akmxb0Je3ec8R?=
 =?us-ascii?Q?DcUPQWO6WKRJv2pcy1lvOz5oKmq+pL0vUbtNe2ktAiiHK7QVkWcnDd2ZSfpZ?=
 =?us-ascii?Q?5HxguUTvFQ/gjxWF4qR96BDh7BRb3xzvYz0m0KYuUfL91J8oEwPGiKy9bXB3?=
 =?us-ascii?Q?y6MnhgWX1xRr3+ggKpAD6RATlZeWgS4M6WT2lfoBghQYh/MzayzP05/PDxGi?=
 =?us-ascii?Q?9fBpNNnn/13wQvyQTIM2VqNedFuezJIgSqvn4WUCvRxYrck8dsSK/pUs+qUZ?=
 =?us-ascii?Q?VKQtJsz0DsKy5wrLiLYHj4cJjrC7wwiTbod4DEJ2Ui8ez+V7/AWofrVyGpWb?=
 =?us-ascii?Q?mjHRTldoyrSE252MymMO3l9STQXj4+GFM6aMMriF3Uu2H8YhcbXet+0io2KK?=
 =?us-ascii?Q?vHMe71GBv0axTJ/hc6AVqYoVViH59yPu3Js/OQii3c8ZSlGCoo8iK9TU0JEk?=
 =?us-ascii?Q?L17NnkMdXeCjoIY+cSEALdAcyEcYDsN+9g7ytKz4L+fZ2tbyEjzkWfC/ztZV?=
 =?us-ascii?Q?U1ypWpb1uydHuYmOC1gdV7bVf3qeD36h0C5ZsdJMZvHvx49WZcQv4GlIOzOi?=
 =?us-ascii?Q?b471vTTQmb1kCYsLEFeQ/Acwy4S6GvzeqkacljUPEbm4BlHyY+waDqY9hLjb?=
 =?us-ascii?Q?DJWaSxybNKGGmdgJWDb5tWccqaDbThALja+EgaPR1PhPYEWW+Ibd4zuuswzp?=
 =?us-ascii?Q?xR40dsHvlaHn8HIVvMVNGeVZLvXjZ1MGzEbJc9TxySbBUE6nrfUOzFm6eYhu?=
 =?us-ascii?Q?kvNYPj5ZuR7jDVfYX7lRng19ozKr32cK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 10:51:38.1906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e664f822-9ae6-46a1-be0b-08dcaa3c4340
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846
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

This commit addresses a potential null pointer dereference issue in the
`dcn30_init_hw` function. The issue could occur when `dc->clk_mgr` or
`dc->clk_mgr->funcs` is null.

The fix adds a check to ensure `dc->clk_mgr` and `dc->clk_mgr->funcs` is
not null before accessing its functions. This prevents a potential null
pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:789 dcn30_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 628)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2: Along with "dc->clk_mgr" add check for even dc->clk_mgr->funcs" (Tom)

 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index fc5936460ac2..98a40d46aaae 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -625,7 +625,7 @@ void dcn30_init_hw(struct dc *dc)
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 	// Initialize the dccg
@@ -786,11 +786,12 @@ void dcn30_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
 	//if softmax is enabled then hardmax will be set by a different call
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->set_hard_max_memclk &&
+	    !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-- 
2.34.1

