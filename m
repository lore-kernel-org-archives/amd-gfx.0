Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68083C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E562010EE40;
	Wed, 26 Aug 2026 23:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2SWUhXi9";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B1210EE40
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9ciYNHLeWecXAwrg87oBv8mBDOe5UNFh+F5WVEKGrqPpVvie/8N9OIRufV6kl1x4yLBxECF6zWlqZrXCHP5uL09tcndLBJXk7NsfkD9g/gx90FOdcKQy8fYGU/5k9AGko0WonfgM37Iur4cXvnESqgzIhKU598ypPnRtIcRF06b0ey2gfK7QfOM0keZWAPavUobA/iM4mXwsyhg5dKlziUzxX7MoGvXGeBIRizr7SGsLE6uRftUnbvwL+mVyYtyW6s9JZO0n+IVbFVGdNvG8F/Wcsa2Thxp3JUXQLCDf0Btc5k9hut7umhPE9bu0G054mu7Y82N8oXROmrVcpQY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbClZxE2kYKkwGgb0c5dXTancXLUy27tjbYYmotAxoc=;
 b=WoeDfyhHOKn3Mx8HtWmnI+qoHU+oJGs0qIj80M6hn+z9izQhG2ZL57BAQNIM+fulj7CZs4RViW9Rovk1buVU34xrVUtD4IOc7gFt/pENEe9hERFMVQcEzp3OxVuGO3uup8k0alpCmfAVe3eu7qib7B8do7L1kVM3VQcQbtP4w+BTMcIW7n0oqz+qTP6rJoYFlPUsTa6KQpgOO7mhtpTCoCYSbSusY6KaRH4P8t8ZHnlx0v+Biwk47c3Q4vh9NEMHeOManFA6OeyQdVJkrD6ezoqChws/wd/hSbc2g3oBJlSMzOdbEE7OfbFvtcXOHEwE9B7eVfbIaffA2bIu3bMt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbClZxE2kYKkwGgb0c5dXTancXLUy27tjbYYmotAxoc=;
 b=2SWUhXi9f+ug3HDVWZqgCc3Nimj07DD6yBs16ih02GPNv38eJtzxC2dmxuuAdqZVlo4f+lGRmna7J6qQY5uZceZ4TTwrSemw9iHwQEZRvU+Of/MhZLdStTRfwMmG5RPgq9eJX3ixCR3uxHsK25TJZ2JcNUuZo0m+PttB8IoFqS4=
Received: from SJ0PR05CA0183.namprd05.prod.outlook.com (2603:10b6:a03:330::8)
 by DS2PR12MB9613.namprd12.prod.outlook.com (2603:10b6:8:276::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 23:21:34 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::29) by SJ0PR05CA0183.outlook.office365.com
 (2603:10b6:a03:330::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Wed, 26
 Aug 2026 23:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:21:34 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:21:29 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 17/59] drm/amd/display: Re-enable multi-dwb support
Date: Wed, 26 Aug 2026 17:04:48 -0600
Message-ID: <20260826231519.881949-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|DS2PR12MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: f939ab54-efa1-4eca-b410-08df03c8c4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|22082099003|18002099003|5023799004|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: eEhJVXyTrPCDjtZVSlTFbGxQnYpY0DHK7uhzrccz12ZujiFBuymzfZ+qiClZ8+EP5hdQm7iU9all6FPW/s/s6beluzmvfXDe6LBKFqZMny7nnodgzpxOOVU6ifg/CAwJs7GfC3etDsQPvqYdHmIhGUXP/j7XqZzu+xFXpGN1cZLBtSx3W/E/WVEtBGxc+Co7VKB+O963UQz16LDsVX2OI5sUhvfY11cZyXcifMB/xxcXP+DUW2fj9+B3jyyzKcvRdppfsxlEotrIlWN+9/Jk9Bsdgbko4F1rugQZJRG7abwYaRMmQYYPdKmF4NPlm/2Sb8PCkgQlMEreROyEvhMgFog9ZN+BRAMBmjeLMeMLZzGV3k1Co/1bye7OzNSdLHb+nn5PneupyJ3GkFN43yrCCjflfSCcjMHdQtz8i+S52zWfhWMLjGRCF3m1/8revmR+wbYLOETqMaoJ3v7VLHaRuxJ9nQVNi9AtAeR/9bOgil78U/AOiXNREeHSh6NRUx1OX0I21QzafdVsazFKUYnLzKqmQ3iMAlXHPBmgebSKOjw3Up0Y3n3WqYD+84DBu88CZiuO+JbTG7+kzZ0ZBUYCgutCgi2p9ku+urG1LrTIxknhewVrcF6grTqCsM2GU3nAFvP5dJNLG5RdkwuQJHC6l/SOsbQI+REHc0ime2yx0X2Q6KbHUjppYUreP9IMQekGANGr0oGCPu3k+B0pGgYADw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z9xwNICRGcn+fM1CIHhgxB+8lDZP4t5IlXGfI2qBRG9uW7m7e9q6X4I+PBAlcj2B9QI9VzOoSnarDmvR/PV5nfA9+fdMbVi6E1LrDa+6N6l7VAjKkjgBTI35fotPpdIw7KNuSsxxwZH0yzCNGiDOAnmuN0ZhTh0E7pd3hrrPPhCmmrSbiWBKy2pxySGcvCaXUTf1J0/+dG+ai8zOcFCThQL/LRe57M85hsYZs9viX2MDSOOvPLfsU9phq1P9tIDKKwdgjM2ruPX1aKxqUvsq6sirSaPo9u+iXucNg9c27vc3WcluHmPnE3Kd7Q0QvM8owCIy00ilhmcREX7kRcGaR7rNpPgV0D3L/D0wUKSspHRUAxdzP5HLYp+NIwvwvBHcoQJTBxwDETj1z8BfGPsMpa/6DpyD49c0d52wBTMagwwnEhXKp7WbInZn4w6hsZWT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:21:34.0081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f939ab54-efa1-4eca-b410-08df03c8c4e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9613
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
DCN5+ supports multi-dwb per stream.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c  | 4 ++--
 .../dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c  | 5 -----
 .../dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c  | 4 ----
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index bd2494c976ac..ab778fac34b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -4225,9 +4225,9 @@ static double dcn5_calculate_writeback_latency_hiding_us(
 		unsigned int dwb_index)
 {
 	double byte_per_pixel_luma_in_buffer = 1.0;
-	double buffer_for_luma_bytes = (double)writeback_buffer_size_bytes * 1024.0;
+	double buffer_for_luma_bytes = (double)writeback_buffer_size_bytes;
 	double line_time_us = (double)display_cfg->stream_descriptors[stream_index].timing.h_total /
-			(double)display_cfg->stream_descriptors[stream_index].timing.pixel_clock_khz / 1000.0;
+			((double)display_cfg->stream_descriptors[stream_index].timing.pixel_clock_khz / 1000.0);
 
 	if (display_cfg->stream_descriptors[stream_index].writeback.writeback_stream[dwb_index].pixel_format == dml2_444_64) {
 		byte_per_pixel_luma_in_buffer = 8.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
index 2e86a134e074..fde2e0ad2529 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
@@ -992,11 +992,6 @@ static bool dcn5_ms_check_writeback_count_support(
 	for (stream_idx = 0; stream_idx < display_cfg->num_streams; stream_idx++) {
 		totalNumberOfActiveWriteback +=
 				display_cfg->stream_descriptors[stream_idx].writeback.active_writebacks_per_stream;
-
-		/* >1 writeback per stream is currently not supported */
-		if (display_cfg->stream_descriptors[stream_idx].writeback.active_writebacks_per_stream > 1) {
-			writeback_per_stream_supported = false;
-		}
 	}
 
 	return writeback_per_stream_supported &&
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index ca3b8b82ec04..5de84d6c73c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -1292,10 +1292,6 @@ static bool dcn6_ms_check_writeback_count_support(
 
 		totalNumberOfActiveWriteback +=
 				display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.active_writebacks_per_stream;
-
-		/* >1 writeback per stream is currently not supported */
-		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.active_writebacks_per_stream > 1)
-			writeback_per_stream_supported = false;
 	}
 	outputs->support.EnoughWritebackUnits = writeback_per_stream_supported &&
 			totalNumberOfActiveWriteback <= ip->max_num_wb;
-- 
2.43.0

