Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD60C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 11:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C5110E4D1;
	Mon, 22 Jul 2024 11:29:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T7WmEJNx";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03ACA10E4D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 11:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUIqNxRu1O99jGiY/XZHu3pzo6llLjNhi0EkFGlTSXl2MePwPoUjmLDcD6CKbHJVJNFQI0rm7g+/l/0ZmAPqhId58hMATVg1iMSUSHmTzA+3FLXJYLmzjUoLdqpgg+Qk9C7L8eZmKGPbYUfBKYpDwVkxUbqL0Tebi2iPXGihDiITGLbGrv7PZ4VT14UyZBpyU0FaFhb61trvgPAw0HrmITkannSsQyaVaJyNz2gky0PYrt62nHqk03/BsfO7rjA5uaEn9pnveT9uJgY1HLp6J0riHFHcbsGkqWAE9KIyja0DSQPI5hW475QuNafeAtExbae4b5dYP8SQkyMNW666hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swNNEgCC7oZwMYdIRCxQLAB06C11aHv7YRB4du7txOE=;
 b=N4mvzqnwpT753SOYFH5zbzGsw5YOgQkPSYEB78Li+9KzBvKlDY7g7/lUFBShvyjc3hGqHim4+Q2OTb95/Y3gj7N1C6IenYl2iMUe6CfASYaEjuC6vLAVwyhxPgO6ooYny3SZUcW3HppbgPA+8NTsvhaDXQC3aCiImnkS1bXC0yFamvFuBx2vCiT7dLOXVq0YHirBOHXI1YWYk588gC7ueOoY2150feUKET2cT1JuzVF7BK9TaPZBg48LfyD1Jah4077EItMNel6fX5gYEhS03lPfSs0X3RL73Z8KBbrAdYtFKlmexMrN2MxUHVMUt9cp03HIJQQLfuggpKEtwA/wOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swNNEgCC7oZwMYdIRCxQLAB06C11aHv7YRB4du7txOE=;
 b=T7WmEJNxg8STE6FB/fRCL84NJNoxdpfjvzIheJiXyuvLxAx6J5aPlE3l18EuaWkwTGXIHl3OrQ7ugKzE6PYTOCwRBfG9USvuGVBgE7t4+6Z7SFdYPeYCgDqHNidJnUcVY5jbJnlb1h6zwlmPE3yGdsq2oKoiGKWNMZWMBZHWktU=
Received: from BN0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:e7::21)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Mon, 22 Jul
 2024 11:28:57 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:e7:cafe::23) by BN0PR03CA0046.outlook.office365.com
 (2603:10b6:408:e7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Mon, 22 Jul 2024 11:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Mon, 22 Jul 2024 11:28:56 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 06:28:53 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v2] drm/amd/display: Add NULL check for clk_mgr and
 clk_mgr->funcs in dcn401_init_hw
Date: Mon, 22 Jul 2024 16:58:32 +0530
Message-ID: <20240722112832.3908202-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721062216.3151119-3-srinivasan.shanmugam@amd.com>
References: <20240721062216.3151119-3-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d35d98-c527-475d-faa1-08dcaa417963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mxKSgOSM2LtOOb8XA7dNeHa6GptgNdJ0buyBzXdvVB9MUTEkvoeYDCLlNVd/?=
 =?us-ascii?Q?zRZ6r8Gwg1epYkAKCB7U+tv+clp33MXI6U/JBYjdD/TuxsWshxGLazox6Dn+?=
 =?us-ascii?Q?4vOobw0j3UuXKBa6SX0BxPBudT4qzGLdY9o92Y2l6ir/sY71FXkuxId3nRn8?=
 =?us-ascii?Q?Nn2ebO3S1P7TWD+a8s94TjQ5NmLOBJNKbyGcf2Z3y023/acotUaCrlFYOr5n?=
 =?us-ascii?Q?qz/D38eH0Q4nBZgGIQxx479tCafENMFfNQjoQOX6HTpi3vNa4C8a6aZ4ckb7?=
 =?us-ascii?Q?xV43qhV1FWZLZke6ilItv3r42wX2sXc4TGwtNxCs6kc8939xXTBeiTrZFE12?=
 =?us-ascii?Q?axuSzjzRcBHa5bAclQSAcb4fbjQeDHW1vZBh5yJwZTwIAOlpqggvi78eNfye?=
 =?us-ascii?Q?BAhnpu/YoKjWh065JiUok1GF80wSnghDFImY8Y+ttCd2ouPVw+Zx038wbLin?=
 =?us-ascii?Q?NV+RWp8pFBK7rt4YLmFVnKC/oLQiouPEzs9Wqqmr0QSPJlAGvlJxVM/86hFh?=
 =?us-ascii?Q?yVP7MOeH2MxbipDxC4lgByJVTexH7SsieNuGtybKoWXKbOAMsr8JrcUvtpux?=
 =?us-ascii?Q?XGvUrElll93XfCDMFculinUZiTOeGqH/DEDsljDQr72zJSLOVeaUAZSlmq5w?=
 =?us-ascii?Q?48d4hcLj93JlP3uFQup0/bpBZa0fy6DmwvGVIOgzWYldjaM7aVZOYuocwv61?=
 =?us-ascii?Q?oLTD7El5UKWduQ7Q5uEyKgvL1QyCbJSYukjsm5XK0T8bGK31tZBrUNq6tI2p?=
 =?us-ascii?Q?mc85JhdPIN0FyRB3KTgECNQNZ+nwIi4/pPAuUG4kCvCvHLzlDWpWWoxifjtZ?=
 =?us-ascii?Q?cLAl3Yc5jdTnt2QVFHWyW7ROJDpTHwaoy4AsEEn4/ME1gOnCVF/ZgrZcE77c?=
 =?us-ascii?Q?zMqVftmGbNriHYFwLsigWBzBBj7y3PCsNG0UbygSBfR99FbYhB1+9wZczGJl?=
 =?us-ascii?Q?F9kDxam+BZmoPmE4bSvOy8UlknOILO7D1nqpn8kP7RvST5QPvz0ENF6H6nRi?=
 =?us-ascii?Q?5rLgPpXiHuum9fSNT2tJ/nr8UgPLUy9uiCQUZ6Vq13msIpm1tpw8fTb6VkK/?=
 =?us-ascii?Q?/AxNUCy8onp7qBowkmf2yki1MFANX77zZMlWgKPZw1Qbs6F7Ay+erIcS8zcN?=
 =?us-ascii?Q?rkfURRDukoVvX3TV5hl2m8udOFhfWGzX42xZzzks759razTWKEHLD1VZBJux?=
 =?us-ascii?Q?1XpFJXtBA4nJWJy08AKnF+BxWRzYb2KQAh2O9jrXXgYXk0dywtak2wYLjCiX?=
 =?us-ascii?Q?7gZtpaCMeEf0wqmHsn4QF3Dq2oWMZpc5vn8459kAcBfHYB8ZGeprcLRtQEdl?=
 =?us-ascii?Q?2QokuoXIdOAKbQjkQPAKj9+PxVcRnvpbTVrSgcf3CuDkB8VDbRSk2Ss3rXS1?=
 =?us-ascii?Q?kaUZJWcvDU9d73Op93+0OKfVO3K0sMTIXP/gcP57T/xlLuFv0gYcwuQn792L?=
 =?us-ascii?Q?oFE7jVAFK+iUWgGclTsk+40tzH+tI4B9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:28:56.5177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d35d98-c527-475d-faa1-08dcaa417963
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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
`dcn401_init_hw` function. The issue could occur when `dc->clk_mgr` or
`dc->clk_mgr->funcs` is null.

The fix adds a check to ensure `dc->clk_mgr` and `dc->clk_mgr->funcs` is
not null before accessing its functions. This prevents a potential null
pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c:416 dcn401_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 225)

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

 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 87c5ef579ecb..0fa610590245 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -222,7 +222,7 @@ void dcn401_init_hw(struct dc *dc)
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks) {
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 		// mark dcmode limits present if any clock has distinct AC and DC values from SMU
@@ -413,7 +413,7 @@ void dcn401_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
@@ -435,7 +435,9 @@ void dcn401_init_hw(struct dc *dc)
 		dc->debug.fams2_config.bits.enable &= dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver == 2;
 		if (!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box) {
 			/* update bounding box if FAMS2 disabled */
-			dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
+			if (dc->clk_mgr)
+				dc->res_pool->funcs->update_bw_bounding_box(dc,
+									    dc->clk_mgr->bw_params);
 		}
 	}
 }
-- 
2.34.1

