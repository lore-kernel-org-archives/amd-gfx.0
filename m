Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A344FC3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 11:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B6510E4BC;
	Mon, 22 Jul 2024 11:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="edBagTZQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 849C010E4BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 11:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNoHBbXN9b+bfG+W11aofvBJFCsTzu6UjIt7Xe3FmNhm15DcSWMyVU649rg12yUGdpP5vW+B9/usf/cvDYkp5rEDpF3spYOI4CVjwLdCADmS277ZUURjbXKMghL0WfmdXrTUqGK9Q9qdOQCkewpb6jnN8xKr8a5lb7U4hdQ3S40IIdY4sv5PBRft1lh2tPlUOS8dTbVMwMgXaBOc8OCTEG0H3+a8APiW6vSOyUbOdo8uHgtMgU0b36gnBEB6uRNMVfly/rDD2k4tq7RH+imxRjNNWcLeGtziRCldWUg0jnso5QYD8+V4VGEXrc65mSuu5bIv7lYSHIastCFUOoiHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MfxtyMd/2akz+kqsGj/wOAVZnARKxJKD6MebmfuzlY=;
 b=WQaaGFHsdKA0Bny100AWLXpQ98S48rZLYIMp+FxNKXQtUvl7Hr8YseMY9TgR4MBk1wWl3cYyc7AZmfjsYaAZVZefiMA7S2xJ/60Qfq00u4INFkX/36qCEUnlQOcViSuY0rmXZPNoF2/IUc057/XkviNZyjltcATy6uHCq3jwSujqCCUQuISkx/bvq9OI2kwFaXvbkut/mV8WB04KFKvlA12ps4xMWnDdoYuSCiJJVSqyakQopIkSacbh6GhXELW3yUV46elVnkISyjEnFV3++3RRw2uOP58KOAKkg0u7lXC0UJLrNA0dfyX0s8eYoEy/rYtbhTUzZOuasMcVK+d/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MfxtyMd/2akz+kqsGj/wOAVZnARKxJKD6MebmfuzlY=;
 b=edBagTZQR6BcnEPv+Mbo9Yz9AZTarvH4Oe7t+I0Yj4fLpcWO0T57wlHIOBSkFKw+aEQmEyWVyUb29attllQ0JOX3ZMNZrQX+ETiUi/BOHbv2xI+DX7bMbmx7tSEf4b1usg9B45qWwbvghIL2Xb7dxvLNzyxdydIc8FpnRYzhM9Y=
Received: from CH5P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::27)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 11:14:56 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::75) by CH5P221CA0002.outlook.office365.com
 (2603:10b6:610:1f2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Mon, 22 Jul 2024 11:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 11:14:56 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 06:14:53 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v2] drm/amd/display: Add NULL check for clk_mgr in
 dcn32_init_hw
Date: Mon, 22 Jul 2024 16:44:40 +0530
Message-ID: <20240722111440.3898146-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721062216.3151119-2-srinivasan.shanmugam@amd.com>
References: <20240721062216.3151119-2-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 33739343-f238-407f-94ee-08dcaa3f848a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vM9ecyR+QL/2dg3tzrBAGDR2aC5uOZTlxSlsQUsAVfVf1y7Wv8Xtcs9bzuXQ?=
 =?us-ascii?Q?z6PaZc6/CUyT4sLdDukykeUvP8epzjrfDdVL2Q1TD3bk75u+Nc07FNhCSq/Q?=
 =?us-ascii?Q?kNjlDPjCDLpSXGKoMrdGhYLsnmYWTRNpH1d71pKanL+loQkIbcCKJH1G41km?=
 =?us-ascii?Q?4hapIBXRwcmy4e1lVKvRpADe5XGc04TzTxrWpkAiid2Uv/7sCJIDzUeK4Xur?=
 =?us-ascii?Q?GY9LtOYpSbL5yXq4tiZ2qvGW918lAvaxwwgY8Uk+HlzqMbOmdtc7BWxchW1y?=
 =?us-ascii?Q?mxFi+AQFh4w3ruJSNQEzzMjb6uC2WkdDg04uQdw2+AXXlhdi6BPTQ+ETBehz?=
 =?us-ascii?Q?IzbBax4QT4hFVgT03IgP4HY76vogxBem0IkvQ46T3tT0aRm/lCSS92rJFKcD?=
 =?us-ascii?Q?wd+qAcHOSPX+XmphSfcI/4OxhNaTmD8TjDXyOgTvbfENhhUPXD3Kx4Gz4lOB?=
 =?us-ascii?Q?Xf7kaVHHeoRo906Yc7VXHTkfgeKEgkUIr03yMf6BHnQf2DPO+qatGNNOV20l?=
 =?us-ascii?Q?rcWPn3gEKQp53t9rHWWckpZ2sQqHzy12mDU1TGyQz2u9CXwzL7oWf/hxHVnm?=
 =?us-ascii?Q?UvXQgAGDoR3UPO/+GisyzNgTB5Ul4ovAK8kN98IsdNCMrtNX6ja0NGDeOlvV?=
 =?us-ascii?Q?pJfk2D63teM5Cl86ApQvcm+4zVvRIQaKkXELBT7qQY9234FEPl0AIfY8G6Ep?=
 =?us-ascii?Q?8Mlx+ZL7OUYN1sTx1YMG/Ff1w9ZwVeWExDZbMSywxc1WZmShwhfK+uONYTMV?=
 =?us-ascii?Q?wnL5LsoV66OIHAllXQ4Dbn5/kb5xjuAe/5H2t9e8U4W/lo9RpNP3xzOIuxVC?=
 =?us-ascii?Q?xKQ5CI2OXM8ekmvARlVVjSfeyPMq+Kzx+ppKHLAcl25uhb8iFdraymQdQSNH?=
 =?us-ascii?Q?RZN3ylEWmSaclH013zgvpYdDfHhLC1P/dUslimc8LybA7Ok/JbXLJEhLTF1N?=
 =?us-ascii?Q?aCK3WUmKjx/cj+ah8nUgNTsh9DvyCV7rWULZujQirgyHCJz8OVaAuJriw5NP?=
 =?us-ascii?Q?5ioSRK4cPdsCRoeNgga3XaKrGjrjqTTrpmDuneUGE2IcYIKqfvBAVZjEyZSB?=
 =?us-ascii?Q?mRQA7dJQxdJnvGCThHz9zLJLP4+VK2asphZNzsjBc2fFXRed60M3AA8O94+2?=
 =?us-ascii?Q?fTtwOJwrcqILl+n2tesfgahatJDsUTJ5b9Bv8Ci5XkK6Q+mLxCyA7lXvCwgM?=
 =?us-ascii?Q?aIrFFwSO6Wg3w5uNl42BjlYwav61yC6x1I4qU1oKpE4TKwp9rWwPoO5aghvp?=
 =?us-ascii?Q?g1pU4YHiizgKQfDWw4xB3E8QMiUXtpUB4V8ewGwIgNHpbAvUCiBSNH/EHb6u?=
 =?us-ascii?Q?M/MZycYQcNCwHA53NHFaAzZg6rnI65iWYMzT9rdhUXFq2bqp7bkzpmSd2NHV?=
 =?us-ascii?Q?VVdktma3tzF9jb8a+0iLvQURJa1sm6AIR5lz2iHypbtBMIDGgNytLyGSOHt8?=
 =?us-ascii?Q?FavQsxYLeet+l7OOxLQXuay6eib3uxDv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:14:56.2166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33739343-f238-407f-94ee-08dcaa3f848a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162
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
`dcn32_init_hw` function. The issue could occur when `dc->clk_mgr` is
null.

The fix adds a check to ensure `dc->clk_mgr` is not null before
accessing its functions. This prevents a potential null pointer
dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn32/dcn32_hwseq.c:961 dcn32_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 782)

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

 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index a7cb003f1dfb..fcaabad204a2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -779,7 +779,7 @@ void dcn32_init_hw(struct dc *dc)
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 	// Initialize the dccg
@@ -958,10 +958,11 @@ void dcn32_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->set_hard_max_memclk &&
+	    !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-- 
2.34.1

