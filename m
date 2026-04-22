Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FF4F94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90D610E1ED;
	Wed, 22 Apr 2026 03:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BgkT4sIe";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E3810E1ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOggnKkZqQ2automqZoYwgoGhuMNf1ZC2o21dWPf7gxggopl8tIDACHJVto+R+iqKCPn3Zhf+apJHKDzfdpytSThAH5TDuN9/4XWrZsd/AmKpySctCIMLSoOSOfaSebMh2T0riJoEuzxQiNPoBS1QZfRJ0w9DbmqU5qWVK08YTJDZiGMIyqRBzVGwazH9DWgffahHZLA3P3yk/27vH33lTXL/ycvhD7ORFU5vDftSjXNf9p925fgQ7Z14Lo81zkLg/40vVT7IchfEPmDGEC83UbzUsstmCzEIMUoWAoRHp8MU72n+YKOQeoVMS1DfG4y/33bjbZMo0Y8pa0CU6kL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gALFQr/3VtfP8+IcYRA4tbL1l3WA2wn/HoFo/5dd56o=;
 b=uR9mDsDwcWddt2wVNji5XiDoArNN/uuYIWzvWnN1HGOvxRpzdHhbxiNW1gX1sXm1apIUW8ZYJ2yTu4DachfEJJo4L3Uy/3uk36Z4jqhnujGvCBJ+ZiC5e3Zqi8906a624bm9zniZVJ1uVZDOi0UvOvNuTdMWMIB8KVC9At/VUTJFBrBF3geaVM6EaFHA4RoPVTz5t5TDnuaxKu4yrjCG65WJKy2+PgI6cAulQLwfwE00XCRb9my5lTHtDwkUZt1UedfZ9whTaMtUl9sYa2X9FdN1Ud+0ZrggPZnKQR7L3tUurUyV9fEAzVWT5dqh7BJlFPkYxUXlwtT+U/f5M43oTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gALFQr/3VtfP8+IcYRA4tbL1l3WA2wn/HoFo/5dd56o=;
 b=BgkT4sIeWqIH7y0T63acwCU9eVO6JmO5AKfBGG9gG9z/bONViPq+EgZj+clUyLfCyAf712FU/LAa69cJDJlrq5Kjr/FWHVDAyj/m+UPKEC7FNzwjvLI5wgwcDYSWeauPYTSAW0DOaMgD+djsx9wCcLMVLDH2yug7hougDyMoNFw=
Received: from BN9PR03CA0091.namprd03.prod.outlook.com (2603:10b6:408:fd::6)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 03:56:48 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::e0) by BN9PR03CA0091.outlook.office365.com
 (2603:10b6:408:fd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 03:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:56:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:45 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:56:41 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Leo Chen
 <leo.chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 06/14] drm/amd/display: Enable HUBP/OPTC/DPP power gating
Date: Wed, 22 Apr 2026 11:52:44 +0800
Message-ID: <20260422035611.1870316-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 66396615-6077-477a-4fc0-08dea0232cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: X/m87upApZMmsd7OeNZZAgmiJzhktYMRaKRj4BGdrgJNn6vMulu111xupub3FqIQ80+CZ5ugOXo/ld23r0oZvQYGU9+Kpr12E9YzUC+wuD+z81wEx3wu98K/E52RV7/aPoIWm+1OHgJya9nxdcBhUBaFysjadZWB+BKQy41J70Zt7TLX74JMwdrG4alYT1WleFCiL9tfVHCVr4dLCxppvI+xpKeq1gxeO9u+/ef/HEH1J8ZKS6kxXrrijnjueLwzAIKq+a/AVcaqMcvVGRU/C0BZ727fcfbyZr29j2Wqdaj/6b0+KFDMhitxFwlVxng0MWNTnhE0pqv/dmYWY+wlr0NxzYMjxlTyE9oK5DAOWJdmkTlSFemWqhV+WG9OVZRK4TDZG9pI/+Mx0tOSYSf/xvJ7uOFnwzg/ukQh7eLbvW2WPOnGXOlUzefu8Ljoj0wCZYKLMTezPHLnKsdBfyHn181FL5KDYMwfRcvUiGF4EFUGeqcRgXTqe/sEqDUH6isHRnNwgTmTnqNl23vRLZCktlRHZyzlUa1erLK177YIoOeIX+A5/+MVXnzRXJw2oXmmeZF31pvLIpDTEzGlhRQafI5idIHgLVGAtURO5GJQeamsiLo9nAiwky6tZnzag7Pdp7gf/RiMMY1iTkKcvmouDT22A2DVKlljK5U+Td4yQGCYVZAS0UlrGmIHLvyKmoFr00erbAlCBfohYhqe9nmaLke13HhyO77WcWsIFflGIg7v0JAVNALuMDQgvuAO8zrtRsPafpzjLpG+i8V079ZwhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gPFLJ4nkWMeKJqvNJJUF+jipHJpi8Tqbt0lExYBRtWgFBQcqvr5kre8x+cTicFyWqS4dBpWTOdBX4o87vIJ8hxbNUhYJdFhHbFAjithn8udjxDA5y15T7vIcCyMvLgvqE5LfvkBXRyWgcuOzAqVit7i28Ux1sSrINL953iSmc+EoDVY/1Q9dDMxZKXQk02E0LDuWVT6cwDadPvP4CALQoW0X85khj4Z2rRyJHErRaTD4+ges2AIDqftOtm9VZpgnc4dyd/nWS0t5+mH/3uuiNsM9xUuUGBKTKSAXAITBqQflretvvX/onQUqNAsGZ1oQ1dvX4atoloK+K6Po6u8aHVtO7qc33IR3EeWO5zmKljrPNcF2sfjJpvnR6Bwe6TijnVqRQbPdzD/ah7wjHYnQjzHkOWOgOsZBNHntMyIY6tqIycN7B9vfgB+0Oi4wdYAl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:56:47.1378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66396615-6077-477a-4fc0-08dea0232cf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
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

From: Leo Chen <leo.chen@amd.com>

[Why & How]
Enable HUBP/OPTC/DPP power gating.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/resource/dcn42/dcn42_resource.c    | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index c2f8554cdcd3..227eb1317663 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -694,9 +694,12 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.force_abm_enable = false,
 	.clock_trace = true,
 	.disable_pplib_clock_request = false,
-	.disable_dpp_power_gate = true,
-	.disable_hubp_power_gate = true,
-	.disable_optc_power_gate = true,
+	.ignore_pg = false,
+	.disable_dpp_power_gate = false,
+	.disable_hubp_power_gate = false,
+	.disable_optc_power_gate = false,
+	.disable_dsc_power_gate = false,
+	.disable_dio_power_gate = true,
 	.pipe_split_policy = MPC_SPLIT_AVOID,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
@@ -758,12 +761,10 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_disp_clk_khz = 50000,
 	.static_screen_wait_frames = 2,
 	.disable_z10 = false,
-	.ignore_pg = false,
 	.disable_stutter_for_wm_program = true,
 	.min_deep_sleep_dcfclk_khz = 8000,
 	.replay_skip_crtc_disabled = true,
 	.psr_skip_crtc_disable = true,
-	.disable_dio_power_gate = true,
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.43.0

