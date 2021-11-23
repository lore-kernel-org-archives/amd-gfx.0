Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01834C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 20:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E7E6E207;
	Tue, 23 Nov 2021 20:01:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D5A16E207
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 20:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXX5Lae6ziuaQUepVp0isLcqwmw8cw1/UNh2q8JvhaO6czKDps8puO6Uu6ALpNEfGXdyjFiP7GE/3ugWMpngl1MThRCOiiq0tD6f6v5Bp/2TjF3FkbQT0DzfxZssS2Z+G/pkFz1J5V3o1nrKFD6YJWqRQv7M7f3WuYT2WToDvqaMP0YPBatFbUkZhJaz1bkSkhTLcWqZ9/YD6GukIM60AFCSBwA8yR8usNoJG1Z9hE+TVPUe0VK30P7PAUMzzOXsIJ/dBessbRSfDhGDyPYdZAjzdBWq3hwMMFuqEL9bb7roJiUAxnzJIb2GvZjKmQVR3rEh6pchGgWadEa1VmvLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1kCW8jHMfIkQYowLpelsCjedSa5xmqLqXVrr1mw15Y=;
 b=XfO+qQS5JeYtUOkXtVIw32N180dT6DLNPtil68LKy+3YfryoNvLRgDiPzagwQ4orYShlx9MXnK4W8Z+c24z9pBVxpuXbNfhZqQd4IjaQkvO9zakaSrzMlylwb3tQUA8/DzlpEW4aQATklghIxJEGseWB4bbsvi/fg8W23pExbw9BYX2hncbRNIxCoZ7YPQd95XoqDCQeuc3vKv4B9Nb2ic2BvVDTTPvOzNuag3cLsHHRVB8zYuvzLN0RUuA5ewxsMVHBRSxWLy9BQ58DM5gPr5hWBmZtpdt0RIwhOWVOThii6TrU4p4CkHhERtd6B+6mcr4OQ6T3twfa+lYRHwF3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1kCW8jHMfIkQYowLpelsCjedSa5xmqLqXVrr1mw15Y=;
 b=En6lQX8fFPSjXxJyMEYeTh5ikiYssR3+/H/VujG0EPWKrrh+elVfGSrJplRwxXr1SxvalnK3neHbqiToiWfUbHXICdthv8p7QxNV5+cu+48NeWgv3XI9NZYK6onXERc+WGwUg1YeekdLnEJt3sqo2nEeWBv+jv/TkgevKyrgHH8=
Received: from BN0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:141::32)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 20:01:31 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::75) by BN0PR07CA0011.outlook.office365.com
 (2603:10b6:408:141::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Tue, 23 Nov 2021 20:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 20:01:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 14:01:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/pm: fix powerplay OD interface
Date: Tue, 23 Nov 2021 15:01:13 -0500
Message-ID: <20211123200113.1979433-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c28cebc-3486-4a02-969a-08d9aebc0af3
X-MS-TrafficTypeDiagnostic: MW3PR12MB4411:
X-Microsoft-Antispam-PRVS: <MW3PR12MB441140AA3F4332D2258F65C7F7609@MW3PR12MB4411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PJ8jOx2m2+eQIAZQaXv7JzmUhFqHG5z+grRilNMZSW8fswp1w2qyC4VYzl7RCBTTHDbes762cNGyq8q6YOY/69L8iCQJf0cufIC57tHJj+3PezqvpYXmtDtg81DIBjYxAwnf6fYPKtDCtfiGjRhx4AX1r56qVjJARpu4rzzoD7s9LMnoM6gFoZB+g9yb7CXWs2oubH75JtGRypbKBT0Q+SVwduxSfVpi/tHMPWIa13mFRaHwSFCD58JLGHxp0V5y86eKMFi4kk8oJv1coDgSbqHVS23qCZf1O8S7y9EC0RLp1FDhP5PyRXb+yOwYwdnxZDCbytjqWF3CBdU+RiPHllqEbPi8oRWIgDJo+KGlGUS1XqkmGYhBo04EQ7RcY0c4ols4IMWyfwdIRtrQxuqR8OPQfHpWr2Nkr1ky6SHe7jp4u41duPx8XHCzWAO4C6rs1piIjRe+MNYnxwO1PqRH0JJ72Xc654bab6mjtQYGV4j8Xzstml5Fvnr7tJDSHuZa0JWZMlaxB7l2SFcVJNjrfrh00COomdCLKx1iUn09KyvpKshWd3GJFTPMMUcWAiBfbnnihgTeCa6uTesz/MKnUvzw6DpHdnpfRuDmJExrV5Lz9s0mWwfnsuSZX2d3rmofYAAV2aJivBRvE3mQIEvtUU3MOEzhqY9ZI6oMT0o09FsbAzeLLLnsnbtjIERgMgc+UvjduYvV55yBka1z7CytqIO4QWh6VNWVrp7xIoC+Us=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(356005)(1076003)(81166007)(4326008)(316002)(86362001)(36860700001)(82310400004)(70206006)(6916009)(966005)(70586007)(336012)(5660300002)(83380400001)(36756003)(26005)(508600001)(16526019)(30864003)(7696005)(6666004)(2906002)(186003)(2616005)(47076005)(426003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 20:01:30.9996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c28cebc-3486-4a02-969a-08d9aebc0af3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The overclocking interface currently appends data to a
string.  Revert back to using sprintf().

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1774
Fixes: 6db0c87a0a8ee1 ("amdgpu/pm: Replace hwmgr smu usage of sprintf with sysfs_emit")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 20 +++----
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 24 ++++----
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  6 +-
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 28 +++++----
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 10 ++--
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 58 +++++++++----------
 6 files changed, 67 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 258c573acc97..1f406f21b452 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1024,8 +1024,6 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 	uint32_t min_freq, max_freq = 0;
 	uint32_t ret = 0;
 
-	phm_get_sysfs_buf(&buf, &size);
-
 	switch (type) {
 	case PP_SCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
@@ -1038,13 +1036,13 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		else
 			i = 1;
 
-		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
+		size += sprintf(buf + size, "0: %uMhz %s\n",
 					data->gfx_min_freq_limit/100,
 					i == 0 ? "*" : "");
-		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+		size += sprintf(buf + size, "1: %uMhz %s\n",
 					i == 1 ? now : SMU10_UMD_PSTATE_GFXCLK,
 					i == 1 ? "*" : "");
-		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n",
+		size += sprintf(buf + size, "2: %uMhz %s\n",
 					data->gfx_max_freq_limit/100,
 					i == 2 ? "*" : "");
 		break;
@@ -1052,7 +1050,7 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
 
 		for (i = 0; i < mclk_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 					i,
 					mclk_table->entries[i].clk / 100,
 					((mclk_table->entries[i].clk / 100)
@@ -1067,10 +1065,10 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 			if (ret)
 				return ret;
 
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
-			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
+			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
+			size += sprintf(buf + size, "0: %10uMhz\n",
 			(data->gfx_actual_soft_min_freq > 0) ? data->gfx_actual_soft_min_freq : min_freq);
-			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
+			size += sprintf(buf + size, "1: %10uMhz\n",
 			(data->gfx_actual_soft_max_freq > 0) ? data->gfx_actual_soft_max_freq : max_freq);
 		}
 		break;
@@ -1083,8 +1081,8 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 			if (ret)
 				return ret;
 
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
-			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
+			size += sprintf(buf + size, "%s:\n", "OD_RANGE");
+			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
 				min_freq, max_freq);
 		}
 		break;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index aceebf584225..611969bf4520 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -4914,8 +4914,6 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 	int size = 0;
 	uint32_t i, now, clock, pcie_speed;
 
-	phm_get_sysfs_buf(&buf, &size);
-
 	switch (type) {
 	case PP_SCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetSclkFrequency, &clock);
@@ -4928,7 +4926,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		now = i;
 
 		for (i = 0; i < sclk_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 					i, sclk_table->dpm_levels[i].value / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -4943,7 +4941,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		now = i;
 
 		for (i = 0; i < mclk_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 					i, mclk_table->dpm_levels[i].value / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -4957,7 +4955,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		now = i;
 
 		for (i = 0; i < pcie_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %s %s\n", i,
+			size += sprintf(buf + size, "%d: %s %s\n", i,
 					(pcie_table->dpm_levels[i].value == 0) ? "2.5GT/s, x8" :
 					(pcie_table->dpm_levels[i].value == 1) ? "5.0GT/s, x16" :
 					(pcie_table->dpm_levels[i].value == 2) ? "8.0GT/s, x16" : "",
@@ -4965,32 +4963,32 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 	case OD_SCLK:
 		if (hwmgr->od_enabled) {
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
 			for (i = 0; i < odn_sclk_table->num_of_pl; i++)
-				size += sysfs_emit_at(buf, size, "%d: %10uMHz %10umV\n",
+				size += sprintf(buf + size, "%d: %10uMHz %10umV\n",
 					i, odn_sclk_table->entries[i].clock/100,
 					odn_sclk_table->entries[i].vddc);
 		}
 		break;
 	case OD_MCLK:
 		if (hwmgr->od_enabled) {
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
+			size += sprintf(buf + size, "%s:\n", "OD_MCLK");
 			for (i = 0; i < odn_mclk_table->num_of_pl; i++)
-				size += sysfs_emit_at(buf, size, "%d: %10uMHz %10umV\n",
+				size += sprintf(buf + size, "%d: %10uMHz %10umV\n",
 					i, odn_mclk_table->entries[i].clock/100,
 					odn_mclk_table->entries[i].vddc);
 		}
 		break;
 	case OD_RANGE:
 		if (hwmgr->od_enabled) {
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
-			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
+			size += sprintf(buf + size, "%s:\n", "OD_RANGE");
+			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
 				data->golden_dpm_table.sclk_table.dpm_levels[0].value/100,
 				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
-			size += sysfs_emit_at(buf, size, "MCLK: %7uMHz %10uMHz\n",
+			size += sprintf(buf + size, "MCLK: %7uMHz %10uMHz\n",
 				data->golden_dpm_table.mclk_table.dpm_levels[0].value/100,
 				hwmgr->platform_descriptor.overdriveLimit.memoryClock/100);
-			size += sysfs_emit_at(buf, size, "VDDC: %7umV %11umV\n",
+			size += sprintf(buf + size, "VDDC: %7umV %11umV\n",
 				data->odn_dpm_table.min_vddc,
 				data->odn_dpm_table.max_vddc);
 		}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 8e28a8eecefc..03bf8f069222 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1550,8 +1550,6 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
 	uint32_t i, now;
 	int size = 0;
 
-	phm_get_sysfs_buf(&buf, &size);
-
 	switch (type) {
 	case PP_SCLK:
 		now = PHM_GET_FIELD(cgs_read_ind_register(hwmgr->device,
@@ -1561,7 +1559,7 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
 				CURR_SCLK_INDEX);
 
 		for (i = 0; i < sclk_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 					i, sclk_table->entries[i].clk / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -1573,7 +1571,7 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
 				CURR_MCLK_INDEX);
 
 		for (i = SMU8_NUM_NBPMEMORYCLOCK; i > 0; i--)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 					SMU8_NUM_NBPMEMORYCLOCK-i, data->sys_info.nbp_memory_clock[i-1] / 100,
 					(SMU8_NUM_NBPMEMORYCLOCK-i == now) ? "*" : "");
 		break;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index c981fc2882f0..e6336654c565 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -4639,8 +4639,6 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 
 	int i, now, size = 0, count = 0;
 
-	phm_get_sysfs_buf(&buf, &size);
-
 	switch (type) {
 	case PP_SCLK:
 		if (data->registry_data.sclk_dpm_key_disabled)
@@ -4654,7 +4652,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		else
 			count = sclk_table->count;
 		for (i = 0; i < count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 					i, sclk_table->dpm_levels[i].value / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -4665,7 +4663,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &now);
 
 		for (i = 0; i < mclk_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 					i, mclk_table->dpm_levels[i].value / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -4676,7 +4674,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentSocclkIndex, &now);
 
 		for (i = 0; i < soc_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 					i, soc_table->dpm_levels[i].value / 100,
 					(i == now) ? "*" : "");
 		break;
@@ -4688,7 +4686,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 				PPSMC_MSG_GetClockFreqMHz, CLK_DCEFCLK, &now);
 
 		for (i = 0; i < dcef_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 					i, dcef_table->dpm_levels[i].value / 100,
 					(dcef_table->dpm_levels[i].value / 100 == now) ?
 					"*" : "");
@@ -4702,7 +4700,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 			gen_speed = pptable->PcieGenSpeed[i];
 			lane_width = pptable->PcieLaneCount[i];
 
-			size += sysfs_emit_at(buf, size, "%d: %s %s %s\n", i,
+			size += sprintf(buf + size, "%d: %s %s %s\n", i,
 					(gen_speed == 0) ? "2.5GT/s," :
 					(gen_speed == 1) ? "5.0GT/s," :
 					(gen_speed == 2) ? "8.0GT/s," :
@@ -4721,34 +4719,34 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 
 	case OD_SCLK:
 		if (hwmgr->od_enabled) {
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
 			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_sclk;
 			for (i = 0; i < podn_vdd_dep->count; i++)
-				size += sysfs_emit_at(buf, size, "%d: %10uMhz %10umV\n",
+				size += sprintf(buf + size, "%d: %10uMhz %10umV\n",
 					i, podn_vdd_dep->entries[i].clk / 100,
 						podn_vdd_dep->entries[i].vddc);
 		}
 		break;
 	case OD_MCLK:
 		if (hwmgr->od_enabled) {
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
+			size += sprintf(buf + size, "%s:\n", "OD_MCLK");
 			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_mclk;
 			for (i = 0; i < podn_vdd_dep->count; i++)
-				size += sysfs_emit_at(buf, size, "%d: %10uMhz %10umV\n",
+				size += sprintf(buf + size, "%d: %10uMhz %10umV\n",
 					i, podn_vdd_dep->entries[i].clk/100,
 						podn_vdd_dep->entries[i].vddc);
 		}
 		break;
 	case OD_RANGE:
 		if (hwmgr->od_enabled) {
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
-			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
+			size += sprintf(buf + size, "%s:\n", "OD_RANGE");
+			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
 				data->golden_dpm_table.gfx_table.dpm_levels[0].value/100,
 				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
-			size += sysfs_emit_at(buf, size, "MCLK: %7uMHz %10uMHz\n",
+			size += sprintf(buf + size, "MCLK: %7uMHz %10uMHz\n",
 				data->golden_dpm_table.mem_table.dpm_levels[0].value/100,
 				hwmgr->platform_descriptor.overdriveLimit.memoryClock/100);
-			size += sysfs_emit_at(buf, size, "VDDC: %7umV %11umV\n",
+			size += sprintf(buf + size, "VDDC: %7umV %11umV\n",
 				data->odn_dpm_table.min_vddc,
 				data->odn_dpm_table.max_vddc);
 		}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index f7e783e1c888..a2f4d6773d45 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -2246,8 +2246,6 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 	int i, now, size = 0;
 	struct pp_clock_levels_with_latency clocks;
 
-	phm_get_sysfs_buf(&buf, &size);
-
 	switch (type) {
 	case PP_SCLK:
 		PP_ASSERT_WITH_CODE(
@@ -2260,7 +2258,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get gfx clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz / 1000 == now / 100) ? "*" : "");
 		break;
@@ -2276,7 +2274,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get memory clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz / 1000 == now / 100) ? "*" : "");
 		break;
@@ -2294,7 +2292,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get soc clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz / 1000 == now) ? "*" : "");
 		break;
@@ -2312,7 +2310,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
 				"Attempt to get dcef clk levels Failed!",
 				return -1);
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz / 1000 == now) ? "*" : "");
 		break;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 03e63be4ee27..85d55ab4e369 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -3366,8 +3366,6 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 	int ret = 0;
 	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
 
-	phm_get_sysfs_buf(&buf, &size);
-
 	switch (type) {
 	case PP_SCLK:
 		ret = vega20_get_current_clk_freq(hwmgr, PPCLK_GFXCLK, &now);
@@ -3376,13 +3374,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_sclks(hwmgr, &clocks)) {
-			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
+			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
 				now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
 		break;
@@ -3394,13 +3392,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_memclocks(hwmgr, &clocks)) {
-			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
+			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
 				now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
 		break;
@@ -3412,13 +3410,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_socclocks(hwmgr, &clocks)) {
-			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
+			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
 				now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
 		break;
@@ -3430,7 +3428,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		for (i = 0; i < fclk_dpm_table->count; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 				i, fclk_dpm_table->dpm_levels[i].value,
 				fclk_dpm_table->dpm_levels[i].value == (now / 100) ? "*" : "");
 		break;
@@ -3442,13 +3440,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 				return ret);
 
 		if (vega20_get_dcefclocks(hwmgr, &clocks)) {
-			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
+			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
 				now / 100);
 			break;
 		}
 
 		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
 				i, clocks.data[i].clocks_in_khz / 1000,
 				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
 		break;
@@ -3462,7 +3460,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 			gen_speed = pptable->PcieGenSpeed[i];
 			lane_width = pptable->PcieLaneCount[i];
 
-			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
+			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
 					(gen_speed == 0) ? "2.5GT/s," :
 					(gen_speed == 1) ? "5.0GT/s," :
 					(gen_speed == 2) ? "8.0GT/s," :
@@ -3483,18 +3481,18 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 	case OD_SCLK:
 		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
-			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
+			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
+			size += sprintf(buf + size, "0: %10uMhz\n",
 				od_table->GfxclkFmin);
-			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
+			size += sprintf(buf + size, "1: %10uMhz\n",
 				od_table->GfxclkFmax);
 		}
 		break;
 
 	case OD_MCLK:
 		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
-			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
+			size += sprintf(buf + size, "%s:\n", "OD_MCLK");
+			size += sprintf(buf + size, "1: %10uMhz\n",
 				od_table->UclkFmax);
 		}
 
@@ -3507,14 +3505,14 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
-			size += sysfs_emit_at(buf, size, "%s:\n", "OD_VDDC_CURVE");
-			size += sysfs_emit_at(buf, size, "0: %10uMhz %10dmV\n",
+			size += sprintf(buf + size, "%s:\n", "OD_VDDC_CURVE");
+			size += sprintf(buf + size, "0: %10uMhz %10dmV\n",
 				od_table->GfxclkFreq1,
 				od_table->GfxclkVolt1 / VOLTAGE_SCALE);
-			size += sysfs_emit_at(buf, size, "1: %10uMhz %10dmV\n",
+			size += sprintf(buf + size, "1: %10uMhz %10dmV\n",
 				od_table->GfxclkFreq2,
 				od_table->GfxclkVolt2 / VOLTAGE_SCALE);
-			size += sysfs_emit_at(buf, size, "2: %10uMhz %10dmV\n",
+			size += sprintf(buf + size, "2: %10uMhz %10dmV\n",
 				od_table->GfxclkFreq3,
 				od_table->GfxclkVolt3 / VOLTAGE_SCALE);
 		}
@@ -3522,17 +3520,17 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 
 	case OD_RANGE:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		size += sprintf(buf + size, "%s:\n", "OD_RANGE");
 
 		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
-			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FMIN].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_FMAX].max_value);
 		}
 
 		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
-			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
+			size += sprintf(buf + size, "MCLK: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_UCLK_FMAX].min_value,
 				od8_settings[OD8_SETTING_UCLK_FMAX].max_value);
 		}
@@ -3543,22 +3541,22 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
+			size += sprintf(buf + size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FREQ1].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_FREQ1].max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
+			size += sprintf(buf + size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
+			size += sprintf(buf + size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FREQ2].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_FREQ2].max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
+			size += sprintf(buf + size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
+			size += sprintf(buf + size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
 				od8_settings[OD8_SETTING_GFXCLK_FREQ3].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_FREQ3].max_value);
-			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
+			size += sprintf(buf + size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].min_value,
 				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].max_value);
 		}
-- 
2.31.1

