Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B23FFA0C3D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA61610E69D;
	Wed, 15 Apr 2026 07:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ENKcWcyp";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E058E10E69F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYsTMCB+JxOlI5O6KH3ZbfHVhbqRVYoX9Oee1oXb9h49LUm9RlDdRT7Gur3YizXZnm7WMeV/oX69VadK4ivHXXRHi85NeSLBbLaY8x+W5vMxMKnP0tdrAh81Is+Ytbacwo/ll0n7UDN+BHhzei5IyGyMxBABqLbLDlaN80CqO+5fOazaAjGpLOk1z8QUIesDsoWg62V/IVOEYgwCKG9Rjl06vGbp7v5kAA4jBAznuG41J3WOgqWdUHZDWXr/zkgaqz3OR8cGa6J2z+ac0OVkKkCbo45e2W5/XqgG94B6V/4COxNzqeERaazqx7037z5pdzQA0MvuVkFloTo1YWtGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov/uE4G8G0fBfy9p3MAZRu35mKT0tST03vA5xMrHBvw=;
 b=Nqz/Mly90B87csWgLKbjnm5bOqQbQ3mt8TNt+ItvYYZohm3weTBjuk2/WnG6keUI0630boaBBldABHh7zCsv13BzAUo8JnYp8ewBbBHq+22Xn9FS+VekBeJQVzRn0NnYzykzsuyswWuRoFq6lUoP0xkLn9DDJfMP+bcZqUBBvYulG9ONbmstHLPhMp9cXVwqN5e0pS480y07vgfd0i97n0GXQ8I9giS8PWywy8xrDfvqRuiIej0UbkR0GNhA8GKw6aGm+DLlL4qTu6tmwn0ApU8Aq4iIt+sL7bg6boy82fcbS4X4yMrXdWK8rUfca3LoeSkrh/pR5VfXtxhrP3tmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov/uE4G8G0fBfy9p3MAZRu35mKT0tST03vA5xMrHBvw=;
 b=ENKcWcyp75EMJM9tvHGyMXMN4uZUExqzb/G65vdB9ANy6P6CZ3XFvALi2kpwo9/uQALmXSWv9zQGNs5TGapa8VLcqCULS2vBwHczHjk0o057Mhd/wZ1VRoWCHqu2x7i1duZBUrUCV1c16TT5BW00cJmYN259M7TXCdMSVk1sxT8=
Received: from MN2PR19CA0051.namprd19.prod.outlook.com (2603:10b6:208:19b::28)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Wed, 15 Apr
 2026 07:44:01 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::30) by MN2PR19CA0051.outlook.office365.com
 (2603:10b6:208:19b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.44 via Frontend Transport; Wed,
 15 Apr 2026 07:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:44:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:44:00 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:43:57 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Andrew Lichmanov
 <Andrew.Lichmanov@amd.com>, Charlene Liu <charlene.liu@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 12/19] drm/amd/display: Remove SYMCLK F and G values from link
 encoder and MANUAL_FLOW_CONTROL from optc
Date: Wed, 15 Apr 2026 15:39:51 +0800
Message-ID: <20260415074223.34848-13-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7a18e1-b12d-4ab0-cf6b-08de9ac2c299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /MFXmCyWGR4XmCXcdAyzmUlzs+IkjrL8uvEiF+DJfYMaVI4jdQy5au8gVGeLtUwhrrgI73w0SD6XSC8Q32m05SFLbiYGMRCTWnstmdbP3QE8MRjgrZbM32bWjvLltGK64pB/G2Xb7s4FnrQY2eXdJU3ugrKf6UlUdI3ZsAFfplKlJyqeoY3v6KO8Bf13Jz6mvKSVlIru7WqexPsQjonKwY/jc3XmrRzSHqXBUPzxsDlVYW44XR+SLuUBorJzdeER6k4r5drOQlOJ1s4/4z3UenSUlbAMfMy2wFRsuSUbYwFPnZOOOLL/RmN9wcwjYBNjzM95aUwSmnY6tT0bSY7MH69P5kR/j7tNKlM4WnojfYiaW8yUURWHVtVEDHb0Hzr8TS7YsY1YOHynjMgK05TK9S9Pz1cIsAPJFAF88YD0hoMk+Oqk/a/r3t9s8m45FlO9MrHY1BIbQDYueBRU2qcV2ScEqzXRuC3gAJ4jJxElwRhvQS5HThArSKzCGtf5FFnDklMxNFy67uFU0tZvDyOdeNz2kzqyt8QOIuarx/S6xoL8OeDRsXFz3BL7lgwNpZZhcjBs7bK2VlRe16ReEgT0zBG7+9rcbt8L8866+D23gcOkY3h/iEui/gOPhZUbj+7+9TMexuVzMYnZIAo8A7qGYCfAbqJNn9byNWPRUXHouPHWncSjvxVY8L9zj+EHLBmuX6eGvJovfafIUlBx/zuYZg1qYUGsIglVBD+ajmX1SM5n5NG+fa1aO2neMDFXYfqdaVpa0LMQYNuuzgkqkk20pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q/eJKvzA03hsFPNokf4fGiNdaJHzfgPjSst1+MgcxJwDWDVR39QZR6Xm70kdvteeRmGXQgnXBnowGmxJN+JHavDab+tiMa2zHozZbwmTVE/6FWgNqJNzWi3nxACGzWi77QUyiVMiH2XTpj9TwrEYsPlDJuJ6Uyxz1V/UMGfKwIBqROP7GY9+5Cxo8rqFS6eO138ahPXY+Q3x51bvDZ9vfcAk+9mB9T7KBi7VYfkqjP1W7wlCnqCuMUN46AyI05kB1mDhqeEp6/jQHvzJV2occ70HQjsWYD2a9A6LpQIIV9Oz66UbwZ99wap/MHzef4Rbz72h1RJGHGeQhWXpAV49ow/B4bL+GJYetlA+p0Sf8OiGgkaWZzN6BR7EKvGTyHTxwTkMDBaaO4LJZ8WvatTyFxURKV9wM98dtlbchFo2mNXyE6orN3R+RaKH4GPIan9x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:44:01.1935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7a18e1-b12d-4ab0-cf6b-08de9ac2c299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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

From: Andrew Lichmanov <Andrew.Lichmanov@amd.com>

[WHY]
Definitions were removed by HW from new headers.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Andrew Lichmanov <Andrew.Lichmanov@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c        | 1 -
 .../gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.h   | 2 --
 drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h          | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c
index c791bb1edb47..6d0012b7d6dc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c
@@ -428,4 +428,3 @@ void dcn42_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable)
 			enable);
 	smu_print("%s: smu_set_dtbclk = %d\n", __func__, enable ? 1 : 0);
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.h
index 4b5a9594f279..9c607b24ec1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.h
@@ -121,8 +121,6 @@
 	LE_SF(DIO_CLK_CNTL, SYMCLKC_G_HDCP_GATE_DIS, mask_sh),\
 	LE_SF(DIO_CLK_CNTL, SYMCLKD_G_HDCP_GATE_DIS, mask_sh),\
 	LE_SF(DIO_CLK_CNTL, SYMCLKE_G_HDCP_GATE_DIS, mask_sh),\
-	LE_SF(DIO_CLK_CNTL, SYMCLKF_G_HDCP_GATE_DIS, mask_sh),\
-	LE_SF(DIO_CLK_CNTL, SYMCLKG_G_HDCP_GATE_DIS, mask_sh)
 
 void dcn42_link_encoder_construct(
 	struct dcn20_link_encoder *enc20,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
index fc7192f01b33..8e7d65317e7c 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
@@ -164,7 +164,6 @@
 	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL2_READY_SOURCE_SEL, mask_sh),\
-	SF(OTG0_OTG_GLOBAL_CONTROL2, MANUAL_FLOW_CONTROL_SEL, mask_sh),\
 	SF(OTG0_OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, mask_sh),\
 	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_START_X, mask_sh),\
 	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_END_X, mask_sh), \
-- 
2.43.0

