Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125D4FA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F5910E694;
	Wed, 15 Apr 2026 07:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p+JGpKUf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44A410E694
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu7ii2V7+ViqmD9phMlndB615q4UG2lV05s3w1QtEyJkCjbtWfDinbHGR28FBmm2tYCpTPRXhZZ5vkh9BlJxPYB//8KsmNJhHvKVr1uZHXOnpVakfB+Q21hMkEO0o8hsRut8W41ParamUIMZ7Sic4kntmFMXPxkdeJm0teXFP40qtXjDbeOpwJBzgL5ijkcsd/kb5BN1bkAFJcFiHzsPp5/Hn3D9Tj3BjQGfm7dzXK1MnFpw9+BRuMu3bsXHidKzswqBtfOhS/eECenG5M8Pk3MxUwlLS8gg6B3zqMNA9eWQDTKz9dXwdSt4uEN235RKZe6LhoQU1vTkr4XHYX1ENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv7VPhk+jj4mq8SmxqXnJ6pr7RtJjQRAbNrW107rN0c=;
 b=fQn4bDKJ5kZa0pBXEB2OKFCuH+onbzCTxFxxNsX5rdoQtA/dzSpAm1YMdOQZTpHVr8/mpwy2Kflk0b1pgUuE/txB4VYnce2SzAJC0BkL+Wa/Fg2q1yFs3Zxu/5kgYvpPcvpAWDK0I1RmhiDCwV+YaoQzzylTfPd3kov5rgt/uHRpCjqA2eNc8qxoQmF5UsT6L1aD+DeIgBxWSWUxjponYZxBwUgxLi43QVxUqOoEY+knXU3s4m1EgL72p1XKzdSqojxgulLZviM/iBXxbik2eClLwzng7xlztS/MK6GRerwM+sNgGwCFX7E1rBOg9eLeZzLiXTD/68kOc1c90xoMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv7VPhk+jj4mq8SmxqXnJ6pr7RtJjQRAbNrW107rN0c=;
 b=p+JGpKUfM+exxxHpyknW3h54nsXAtEPgj08LDLOyVoQ5NG0ACZfnD88v0HljghkwlbWF/RqhrRfH5r2kly7aWtJ7waaExrTIuU9Pv2ksuW1SDpMkj6QXIRjG/OuEduGejvRdNaJJj9GKv7YJYMYA1RDK0rHcmv5OHY1stKf0WkI=
Received: from MN2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:208:239::8)
 by IA0PPFC855560D7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Wed, 15 Apr
 2026 07:43:08 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::dc) by MN2PR08CA0003.outlook.office365.com
 (2603:10b6:208:239::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 07:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:43:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 15 Apr
 2026 02:43:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Apr
 2026 02:43:07 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:42:59 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Allen Li
 <Allen.Li@amd.com>, Robin Chen <robin.chen@amd.com>, Allen Li
 <allen.li@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 04/19] drm/amd/display: Unset Replay desync error verification
 by default
Date: Wed, 15 Apr 2026 15:39:43 +0800
Message-ID: <20260415074223.34848-5-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|IA0PPFC855560D7:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b61ae5-881b-4f10-038c-08de9ac2a31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: uGwh8HJd30hEYttFo9/hGWwgwfViYj49nFABOd5fgmdi1roqZvWQGAvK2PPLFfIBvoCB2d+4v9n6u3YnqbbyCMIwh0chq3ZzM17XlnyBqYkS9mkGj41mv8XU4vOEV7vI6ffsz75AQk8Q+moiopOsTPJEmE7UmfKtaIW4xnk/iLZsIJPYs4jhyXC+1lekwdt4+gi4V3LsX7WTl4/ubTJa3msVbW69EIaTtcSeqX6BkfE0oVTg8JFDerc+LKNSk/XHNumQb+APVetfdl+YpsBF7PbnT8CTWq7HFSQZGO/705x4GEykeimvDUXuTStsjdVJb0BUP5pz07lexGKwuARynwlBF2QIZ5bR9uGDO7/KB/wcBLRqDlWVLu4VqjKFGpgNN7dse7iTLphkgS73IjKXb6H74c3vX4rwDzQ3Xhcw9uR4bA9p2IcKV395rGWDIsLTFIYMI2F1/zcH2uOAH+EtFTjyx9bjFysmykDsznHlDY2ck5duzWFNgClqHyJp45QAHurK1LBQCsSfIOVm7e3+t7IBr7eyUAlLvxw4KekS9QRUX9i+GEmJ95s0fEE33CMgI41BSY7ZGDCe9KQIVuGr43OZAIKXcbkT8tt37vxo2fi/+I1ROe7/b9VnCBiVMyNbOh0brgWHWrdI0ZO2AwHNWpkHNcuTW33aHo7hg6e0Cu5VfBA9WZFr2wyitCJAetBkxj/UP2gY8bOY5TgA7qXnFgXULAf8ejbLWj0efy99kuiVEt5UgGJAzz/gbIaU0DJA3irj3AJTsEP6sMuAcp1Y4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +V9vywvIjodLTGlE7TnFqrkkchn6PvRp0gSqnvns9F17kr8e3CyccIJ0GTrE0IcsfToiHP3TiTNiJ9rQDd+WC1/Edy3oWObFshDOIvpFqK6V16b72pUTNSdm7hBfqVBs0NDZ3aThODAhqEj4MIYmnfxCK/DWcOZGMx7cdgmWP6N5Jit+YdvR2StEq9wHMZnEBFAV99MjwRitlCJOkiCzL13od7SdM6A563p8VKtHQ/H/N0vwwtAzEJAzAS2Vv02ovsRn3VF+XN1VQNs8LA4s25WKDU5ko+3chtSVkBKB8UKwP/Tx0VS77Aa3z5iKZdB2knpOd1MpvqLO6z9xPQB6gVwauI3j6OiTB6KrdnvoOYxQbq3xpckLkCzckzlRC62oG0q3CgeqxvgiYDHCdd9rCXDxjFuNhqv0GuPmckYb11JpDwTI8OwG3CvgSdvl4ElP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:43:08.3545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b61ae5-881b-4f10-038c-08de9ac2a31b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7
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

From: Allen Li <Allen.Li@amd.com>

[Why & How]
There will be an unexpected desync error while doing PSR -> Replay transit,
so we want to disable the replay desync error detection by default.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Allen Li <allen.li@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 4a2699a374b7..4ae739dd9c7e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1050,8 +1050,7 @@ bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_stat
 	if (link->replay_settings.replay_feature_enabled) {
 
 		replay_config.bits.FREESYNC_PANEL_REPLAY_MODE = 1;
-		replay_config.bits.TIMING_DESYNC_ERROR_VERIFICATION =
-			link->replay_settings.config.replay_timing_sync_supported;
+		replay_config.bits.TIMING_DESYNC_ERROR_VERIFICATION = 0;
 		replay_config.bits.STATE_TRANSITION_ERROR_DETECTION = 1;
 		dm_helpers_dp_write_dpcd(link->ctx, link,
 			DP_SINK_PR_ENABLE_AND_CONFIGURATION,
-- 
2.43.0

