Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CD7FD88DF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 02:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645B810E2E8;
	Wed, 11 Mar 2026 02:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HW6voegf";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 941E610E79E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 02:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/lgouLNP/mV0C3tEMjCJzknOj/5XPjdskMrAY6JzPyzkmT7E4gqk3zwyhHcUIQHgN4WYB7JujtXSH3BlG2uk2rBvT7zXBMC2J8MBlx/qSFJZz9Xv5VP+qVTF6gTImM/ESZvq38VpKMtSppVvFWBHGB7GP6Hniy+c/ooCumuK3VJbwO0UnCFwjQY2XF71R5ClBdapZUeaWKdbjboi2fd9AwlRg5eFDkMFyhiSkd6MD/887gICg3YFBI651IRrRX99TGReLvt0uiDlTPM+vxvqJC4L3UD4rmcYPEfoTNtr23KrdYFm4s3Hru31e/51wXktdYF3fIfI8gKTLR1OVIdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PU4RqW4+mYgh/+y3xamhQe2Q3oUSnu2oBYI3d7xFpA=;
 b=wPK4Mja6cBJZKEVPh5ch5mJ3+oYbYWZVTC5f/I4XauzDdSKOhcNe6kALmLa2RYrilFnpMVs7NdIjBfMWjDDJHpQ6uy6eHD+Wf60MjPi68D+KnBuTnhU2ylTdqOn69Fsdd3uXCb9qwcc0XjU5Dp+AbxOE0rZnmMvGuVG0lpGBR2+ej2yvxTnJzURssvUEVdXZx9xzSCKvPKvbx5M7Fg34+eNqIUmb84vVXMyF7xpVY1l/qMNi+tqk9a/yKdNRYWXwT0cDBcGJNbec2zNgQ4/TFr7Rhl/sQL92kfgw3vkwflK/Ure7Ff8VSZ7KOs1MX59+O0If3d72Rsl5aDQtfdzo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PU4RqW4+mYgh/+y3xamhQe2Q3oUSnu2oBYI3d7xFpA=;
 b=HW6voegfytM2XLEF3qhhhAbL02fwqCqVnusqHXPWVXE1qH48BxBVIq0yBsDGOoOVQpve/4fK6BmqFtEj5H+ZTAoAvG6wSrvsfGHkT68iQ1ywhz+5TkFxIwLa+B7RoEiFslb2OafY5KcTEd3awwtQdusz7hiT2jEbsKcFHUDmhAQ=
Received: from SJ0PR13CA0183.namprd13.prod.outlook.com (2603:10b6:a03:2c3::8)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 02:45:52 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::4a) by SJ0PR13CA0183.outlook.office365.com
 (2603:10b6:a03:2c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Wed,
 11 Mar 2026 02:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 02:45:52 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 21:45:47 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 5/9] drm/amd/display: Silence C6001 warnings
Date: Wed, 11 Mar 2026 10:40:37 +0800
Message-ID: <20260311024652.2668570-6-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
References: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b1e563-db0d-4836-da57-08de7f184f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vaby3UP5xHcMYXcXx28ugPQ3K8HU04+U/6YLhDLhRwfRQfJFHQHZov6hAYufl5RmSo1MOPDx2IgCGQoYW6YMVAVOdTyiaGOJ/oiHyIem+oLVM4N/VSumPsxQD54xR0Be5zt1qm/s6rswQAxytsLjtafMwSFq3TYVVnUq2m1Iz7FE3qIKr2GsQfU4YPwx59JyZOQmDsQoM/WpsallquZTl9UhpongxltH0hvBiDB2S4XeWoOcq81DS8tyg8cmzpp5AKKsK2xS30ApJl1HPSXHwsTrc705DORUDMYPR5svAHuVKW23uK8YNOAcE+vihxhgUogz9HyNxTReZl1jDzVcWW4/XKz18CJBZS63nM/gjQqDb6oa87h24KVq73LG4KK/5vygakyN9cfLq1PE3L+M6ZFS2dMpIHSaNrhrg91hoOe+61V0bQJw8hl3J8pZYgxFYWP96PnBeccnM+SLtNc2NLnHnnJZqLEU3lCthAahu6N//F9V2NmIpBu4TFEreY0HqrERNytXlvRL52OHvFGLliOArIJ7W+CO0UxXLvjTG0TYh5u7ISfLlKrEo2qknjoXQhy0zOCEyBnTeDiudBMT/S9oGpZ2UYIX7OkZhhxfXgERoILRFGm+cVCUmMyA9GJvp527f3o0rjaxg0kMLBYwjsBQrYoGMD0sHuywxExnYU/hyOoLAKHkSErTnY4/106e1eqcgvqV29mcY3TkMXeOGE2U3xDVje2ozinwJynlkFWQmXzvWaFBtjZbjhAOPlaiAHj5ouJMYkz0a3Fo/rK1SQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CNudzd4VOFIeIG4Y1IaI5iavtK5T/z+0Rbp+R0i7ivtafROOL6MrgRCTuGA/KYtjqeQOtRc8p5g8ff2T8ERh+qYbh3UPbdF3GKcMs90tP8OHNOUTUbydPkQsdQXZtXHQVbgHPX87lGPUhFL0pSmmokZCePo4HxFLWKt1oKoY34VmnNNmU6vGPGAvnaPg1eumB7sE46caKwI3ox+54MokwfrOeVnDSpIO0BOrNBEtFho9MrxXH562NmzsX1N0ztym4x+QGJ0oeGX/CIC1srgDSln+4aO3FxOBviVLpMvXU59FWmPLtmczbtWQdDd0/sNaTwY2NM7jEtwsmp/CdL1hwCA+li7a9cdkhCHpCCTlmInU67U0hu4jSawRRM+NvgqtGHCNKY0O0mXOgHJr9A5m2ZJ7LU8aff41DG7qYAAGcc2pdteQSJ261zNH8R3tgWdD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:45:52.3128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b1e563-db0d-4836-da57-08de7f184f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

Silence MSVC static analysis warning C6001 by ensuring swath size
temporaries are initialized before use. No functional change intended.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c  | 2 +-
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index cd8cca651419..48905ca39b70 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -5304,7 +5304,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 	double LinesInDETC;
 	unsigned int LinesInDETYRoundedDownToSwath[DC__NUM_DPP__MAX];
 	unsigned int LinesInDETCRoundedDownToSwath;
-	double FullDETBufferingTimeY[DC__NUM_DPP__MAX];
+	double FullDETBufferingTimeY[DC__NUM_DPP__MAX] = { 0 };
 	double FullDETBufferingTimeC;
 	double ActiveDRAMClockChangeLatencyMarginY;
 	double ActiveDRAMClockChangeLatencyMarginC;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 0748ef36a16a..19b142412a84 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -459,8 +459,8 @@ void dml32_CalculateSwathAndDETConfiguration(
 {
 	unsigned int MaximumSwathHeightY[DC__NUM_DPP__MAX];
 	unsigned int MaximumSwathHeightC[DC__NUM_DPP__MAX];
-	unsigned int RoundedUpMaxSwathSizeBytesY[DC__NUM_DPP__MAX];
-	unsigned int RoundedUpMaxSwathSizeBytesC[DC__NUM_DPP__MAX];
+	unsigned int RoundedUpMaxSwathSizeBytesY[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int RoundedUpMaxSwathSizeBytesC[DC__NUM_DPP__MAX] = { 0 };
 	unsigned int RoundedUpSwathSizeBytesY;
 	unsigned int RoundedUpSwathSizeBytesC;
 	double SwathWidthdoubleDPP[DC__NUM_DPP__MAX];
@@ -2988,7 +2988,7 @@ void dml32_UseMinimumDCFCLK(
 		for  (j = 0; j <= 1; ++j) {
 			double PixelDCFCLKCyclesRequiredInPrefetch[DC__NUM_DPP__MAX];
 			double PrefetchPixelLinesTime[DC__NUM_DPP__MAX];
-			double DCFCLKRequiredForPeakBandwidthPerSurface[DC__NUM_DPP__MAX];
+			double DCFCLKRequiredForPeakBandwidthPerSurface[DC__NUM_DPP__MAX] = { 0 };
 			double DynamicMetadataVMExtraLatency[DC__NUM_DPP__MAX];
 			double MinimumTWait = 0.0;
 			double DPTEBandwidth;
-- 
2.43.0

