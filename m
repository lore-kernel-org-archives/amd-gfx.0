Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF6AC54F30
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579ED10E561;
	Wed, 28 May 2025 02:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lorkO8XP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006F510E561
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:53:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6xmot/NYuxLd6SMc84fgeH3EW0JcppcC1WR2foInkKjl41gT2GAa9PVF8mIodA1p0of5nxMOqpuPmZMizfhR+7vXNsiT09xAqX0CjDeWJs95Os0VkS/t9LxtpH8jj3zIwjOgzhhO8FJCMrRD8jq71XZJnHKC1BchZv7M415uQL5ihjyJr0u7g9lzM7h1pgEdyx9FsOeGnzBi3tvK5RIyl4fmnp5AH3MmpJBt0uiL6QWWCcoca0kNo1HOahK42at8P83QAR8H2MXUIb01tGfNwHF1AdE2ZvD/jlydic52Xch8MSS3NAaoDlkndnClvRIUQMuKiwNbv7mWO0Y1C2yHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71qxA3QqMKG0udze6l4oOVrA4NNWsXll/jxXElgro20=;
 b=nnjprDP9EVpdKMR/W/ihrr+YEIRQXHW4kffwodorZrtSKwn1mcxt5sF8kGRBuILnPXILTxh4zvt/ZTsPSPIIDZnLNLo5CJ/WD3StMzTxT508SblrdGWAhQ41RHpFRtxtqEro1mthKZXDeUXGdHp9fWxvzHtqjVCAdO5/Xbp3qPxaIYTHW03wO791VVejkEzKvRlMw5ffiMZMwZ24kXpFlriVCO5qt9SliwtBh1ZFV2jYpbsixbyZPVvunrAbJ0U/hdUOXUFRezJrWQzBT+6SzNfN1lXLAoFWwzxSReLgrDGDjy2EiGRJuRh4vD2pKCWjYOAByhpSkmuIvcMa0EIkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71qxA3QqMKG0udze6l4oOVrA4NNWsXll/jxXElgro20=;
 b=lorkO8XP9FCI0J6aBdQEUhRKelkUt6xFuB2yiABt6VYwjjewh1m0BaWPC1MvWQcIhnROW8Hdl8hAQVxJztnDnN8aCzkFcFhI8GI93PlvMJMNepRmqr3DRYvoHRzkeHcei1W8jZyo32RLmd5je0E9PpqdOnScmbdlbAU5dfOBsyU=
Received: from BN8PR04CA0019.namprd04.prod.outlook.com (2603:10b6:408:70::32)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 02:53:55 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:70:cafe::50) by BN8PR04CA0019.outlook.office365.com
 (2603:10b6:408:70::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Wed,
 28 May 2025 02:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:53:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:54 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:53:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>
Subject: [PATCH 18/24] drm/amd/display: Update DMCUB loading sequence for
 DCN3.5
Date: Wed, 28 May 2025 10:49:13 +0800
Message-ID: <20250528025204.79578-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 853b694e-d437-4eca-6a43-08dd9d92e2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j5AUyNDWbzQA3QA5YrtS02iYnkA2dFfNcxIzwf6NyIfK7Ey23zmhoNDBsq+L?=
 =?us-ascii?Q?9kluDjs8z3H3ZFGYz/TG9TkPcTbEl2lcRe5c7rA+2JogEZQQBZ3N3dSwIFJJ?=
 =?us-ascii?Q?8sNTHJFoDth/9JEdNpCoHa8IKyGedSwZunr7bHOLh+sN1MHNT606NNz86iMu?=
 =?us-ascii?Q?hKH8h76KCwr/b9UnCDfgDYEkJ1XNUE4aWFiEZubKhFD3KcvD/V7gA2YczYud?=
 =?us-ascii?Q?sNm1LvIdrVrAhVJtNOR+Id5W70x1xA2aybJsXj+vQn6TcLTFoXfW7pqSOfLf?=
 =?us-ascii?Q?U/okFlCYiuN6Dp3YeXZ1bMNC+i06j6vj4tIycdsQqA+v6Y8qNRTgMhdQEZpg?=
 =?us-ascii?Q?UqTfr6Gi1BJ3GshM3NHk1ZuoEQNc3uP+cCHt2AkhBEYlY2Tqt3GUBQPgK8f8?=
 =?us-ascii?Q?evQ8hOU0zcqF3M8xM0riqKIxFFio/QxJ28W+wiWmYMJL3qh2F8MaXCDLkbyl?=
 =?us-ascii?Q?QNvzqlls7h+AoaR8HB3rmDXprcjv06XjdX7cnk8zB5O3FgWuCuhjV33xv8m3?=
 =?us-ascii?Q?0w1ILFgd9pBDZlGTkEDaGWdxSujuVBJ7zRQ59w3FFNEazijbFv98QhAZ7PDg?=
 =?us-ascii?Q?7SGrUi67SoSAYZP5eJcjGJfPYhpn+OUi54BYIUqHaRxG98RYoSJ4wX3QY3Gb?=
 =?us-ascii?Q?tr1gpro/zsLV5gMh7f6Eqcj3Q0PMFCf6UzxQRrdfnu7Py2pWgPmhrMo/Oc7l?=
 =?us-ascii?Q?BEyP/dfBjgR7gqiBWpOe9J00xOz6z7CXjZa+8LYtb3rC70NNDd3zFoBoEWo6?=
 =?us-ascii?Q?LL+Eo0/QiQcSjJEBVLh1THb/wgefB/NAdaV0QwVjFtpKrJAhjqv5uMEgQFgz?=
 =?us-ascii?Q?1I4cPWFXbzM+XldBKjMyMpoeDGbbM7nLfEZF04XNK4Nenb7mlQheGKpIIR8b?=
 =?us-ascii?Q?2jG3LOK/dl6fh6q/LP1v7zx0kDkYThhtyF2arG18pwYslqNz2eZP5T6Oi5UD?=
 =?us-ascii?Q?2Ym5JDCyiGZ3iHW0Tm5eKU8tx5xnzr9WIQT1vmGA/f0YQzvcICuIkk/r+MYa?=
 =?us-ascii?Q?M+7sISvKfPP8U+8uYkHtQLiqXMiM+7DgNJykKzPw03ZJEqwJiQ04Xig2YPTR?=
 =?us-ascii?Q?9JcptDKmw2wFrxBS0VVpxPlhgGQp+S8TM4yfumPEcCBdvvKLNRZl/+XO4+LX?=
 =?us-ascii?Q?03WY7VqopdMDSU3K2g9YFfAknS/6+OIqagnN9sCN8/9sA9qYUh0ELpNbt/4t?=
 =?us-ascii?Q?+UvGK2BNBXg3I5bENVqmpzAXdGDSwxqRb+V8R/vwk6HnlAMzoDpRhGEjpHb3?=
 =?us-ascii?Q?tgintVdXfGLGNTbYP9D8WS0TF3/s+wNYwFay7tX0RJkMrpmOFtcjsXJolbg1?=
 =?us-ascii?Q?eDYw4FH4Ewr2uYQLI5ej4SBbcyO90lG1LfEfWhtmN+J7KDGDSlEaITCsiN4H?=
 =?us-ascii?Q?vSlsPVzUbDUsAqOLo2F2V5C5gT9f7GecQCSAJu5CdNhz6hAv2qEKpiilEbwt?=
 =?us-ascii?Q?jz2Cvq+7g49RNu8HRJHZg41HTaW+tISAPmq0UYdGELpn8AVQlQxWxEGymsJS?=
 =?us-ascii?Q?FLu9nUfVjddL5RzegTHwFixmkQCQym3WXx69?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:53:55.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 853b694e-d437-4eca-6a43-08dd9d92e2f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
New sequence from HW for reset and firmware reloading has been
provided that aims to stabilize the reload sequence in the case the
firmware is hung or has outstanding requests.

[How]
Update the sequence to remove the DMUIF reset and the redundant
writes in the release.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c    | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 72a0f078cd1a..2884977a3dd2 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -92,19 +92,15 @@ void dmub_dcn35_reset(struct dmub_srv *dmub)
 	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enabled);
 
-	if (in_reset == 0) {
+	if (in_reset == 0 && is_enabled != 0) {
 		cmd.bits.status = 1;
 		cmd.bits.command_code = DMUB_GPINT__STOP_FW;
 		cmd.bits.param = 0;
 
 		dmub->hw_funcs.set_gpint(dmub, cmd);
 
-		/**
-		 * Timeout covers both the ACK and the wait
-		 * for remaining work to finish.
-		 */
-
 		for (i = 0; i < timeout; ++i) {
 			if (dmub->hw_funcs.is_gpint_acked(dmub, cmd))
 				break;
@@ -130,11 +126,9 @@ void dmub_dcn35_reset(struct dmub_srv *dmub)
 		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
-	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enabled);
-
 	if (is_enabled) {
 		REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
-		REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+		udelay(1);
 		REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
 	}
 
@@ -160,11 +154,7 @@ void dmub_dcn35_reset_release(struct dmub_srv *dmub)
 		     LONO_SOCCLK_GATE_DISABLE, 1,
 		     LONO_DMCUBCLK_GATE_DISABLE, 1);
 
-	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
-	udelay(1);
 	REG_UPDATE_2(DMCUB_CNTL, DMCUB_ENABLE, 1, DMCUB_TRACEPORT_EN, 1);
-	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
-	udelay(1);
 	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 0);
 	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 0);
 }
-- 
2.43.0

