Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A21FEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6175910E799;
	Wed, 25 Mar 2026 07:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r9YsZ1t4";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D7E910E799
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn1RKvhsaEuFugFj5zul7Qywa7HYAMK2zIXUybNHLw3Bw0VgUtsLPt2TAfxvgjPEdvW0Y5agqN7uwB6esfvnJKRNSra3/bpgtfij3Nj2jLSWzqw0ZaFbnKmsC+ruv3OnF8SqcKGRhb6YD5mHf41FofK4+5Wmcw0c+LdiS2ee+7BwO9IU3133XUQl3jDHJ1gdGClIvHD1jZKfXZDzbUPQpbkl/0DbZ5HbnbblF+KBTZ4SN2N9EDbHoQgqaxpKtjYnVwyMSc5MxzIolFxgH8vjjCEiw3C5mme45FDI9Cpmjy4eEUeGLUFzCRSyz+2fcXFcYGsXiLdqU8K2R2AZubROCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnO9/sRL6yg4D6JjiBzLTr48LlDUHDZIqM9s+7XX0XE=;
 b=Rtdq9uCXjiIzXr4GdYIiW4KIzyjXW0TtO8+10KKzNE3JEV7G6mZkT+HC2TQRnDOL3RdJAdWnOBsITbmoUsN4MBpThB3X8fSaL0XdpB84e10Dkn89fl9dv6ITvrE3PIZQ4flaygc6G8WmfDllhYjwLS24VUh2XAn3DoE/U7uwXKa+uMNBY8PGwww7pNfR4mRzRYG0l8odbUQJGxsXWx8LS66oSV5omDXeX+XEa3Emstg7ntZQEbFliz9RrzlI+VFbQOQwvrlJJKt+FREW023wUKxHS1VhBr60IoSoBGe1T7QYVxvMEcL6vMsZM0UgvQVszEwY055kLHNH7YwGdQSNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnO9/sRL6yg4D6JjiBzLTr48LlDUHDZIqM9s+7XX0XE=;
 b=r9YsZ1t4YHUvuVOMIGkP/KdJvbkzfvXDnro/32psKABN0RIpEx9LGmoImTT8Mu9JUOdaGx220BbuFOsbnbrrj4P3HWIWZAt+59JVh9Z7G5uPaWXBKxTpSKJR+GYML1F5svxtQWf+7YrItVNUGTlzrk9bl2mbA/78RGonf7fz2gE=
Received: from BLAPR03CA0145.namprd03.prod.outlook.com (2603:10b6:208:32e::30)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Wed, 25 Mar 2026 07:08:55 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::82) by BLAPR03CA0145.outlook.office365.com
 (2603:10b6:208:32e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 07:08:55 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:08:50 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 05/29] drm/amd/display: Fix bounds checking in dml2_0 clock
 table array
Date: Wed, 25 Mar 2026 15:06:11 +0800
Message-ID: <20260325071003.4022594-6-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: c608b490-ac56-45d8-c5de-08de8a3d60f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: d6s7Giuc0WMnatC8aP9QioArJGtCfcIdWlK9QtVg/AsqlNrEf6ft1bR028sXpVSfYtFLWZQoeo4DSFjIrXD44L12tajzkppZnoeSmt15/VY1ohdD6JXqU6XyRBSFmv5QT5hKmV+mY9g7YdG+XgnG1djj2hECpHgBIf4HqbnOXEgsO1QdcpYHoN2y16rsJyskGOTpU51ffsRgDSeRzvrgjCiN+F50vHLMl2wP1eowxYhlx6laANUuvEEYNLXNcJGooj6v2rHl555pP89ZxSRUSPxduQcJsmXDEQWxM/3D3eDnInbbZFSWdO80++iUhJ1r1vVBfHeBJsUbiQIOJxDQGJYAxTAjQEQ9OJwIr0biRyyb/gGisWujL1SWDQ6OBk2L8R6i1+OlvmPYuOY1bJfXtSAf/miV6rOFnh7d90q0tmzbBDZoSijW3F0J8ytkvKWlgENMKFE//SUptT9oG+u670Luqgi9zHLN0MAlL41dJdUzCgSFUavZngv/m9aQQsC8Vug4Mlv2TmoO80VLI5znH1QW3dSWHVaJ4p96tzYozuXidMSGQKSxenWQoRsop5FOsKaZ7pccLrVZZdiAOpFGJTo/o4tpW3gRs1liwqFJM76JrhL8spR00ZYseAEvR4+R2F6RYYrk4Nl8XRXBm/RRfCr4N1eaikrydH+3CHMHh1jMPDT/oLATZtaOk13q6lmFW09XSAw8E5RGFJFkk2MKVNd3Lu5TLKlOShWixB8inoNQXomqPQRiCkqMWBYJLFcwfl42CRAhaYc6WNbrm2mwGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B/quZGERN53cuRSTfWSgCh16yFCbDekL3K0WL7/e+vvgKOFmcFJ/L7a1reZ0dcpx3V8ccet/R98KOBwrsfKUhfJTnrkqFSfX1V2QxcMMP98dqgekL5A2Y/j44q2yIZ2pnQWNzyTckmGyPjIb7VN8Vw2hwZT2FgmojPAc80PYXET7TXHBZzzJYcQA8pjJM680JDTb7YEUS0+awv+WVVdGolYf8/2jkVasD3/cdyJooBs0MXL8lFva1PU3xC9UpxHWp6tfhHo8PDi9AfZhzHlVL/vhs84SDcCj4IJhoJTUQd77ytoZ1M/s4iXPG1JiirrbGCfW1DBh8HN5MLLg5QGN70zH+sobenaStAbcRIw44Oewxym1kTNLTgcKo3ebLwDOEw5pVrt3YCp8FPmkreGCFcl9JFoo4h/p5hW0et+QcdAKD49JMYxVKDVyCrVxo4w1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:08:55.7195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c608b490-ac56-45d8-c5de-08de8a3d60f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
Multiple locations in dml2_0 used num_clk_values-1 as array index
without checking if num_clk_values > 0. When num_clk_values is 0,
this results in accessing array index -1, which wraps to 255 for
unsigned types, causing out-of-bounds memory access and potential
crashes.

[How]
Add proper bounds checking using ternary operators to guard all
num_clk_values-1 array accesses. When num_clk_values is 0, return 0
as fallback value instead of accessing invalid memory. This prevents
buffer overflows while maintaining backward compatibility and provides
sensible default behavior for empty clock tables.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      | 20 +++++++++++++++++++
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c |  9 ++++++---
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.c       |  9 ++++++---
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index d17e59d684fd..ab0b4a4b5d65 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -279,6 +279,26 @@ static bool round_up_and_copy_to_next_dpm(unsigned long min_value, unsigned long
 	bool result = false;
 	int index = 0;
 
+	/* Guard against empty clock tables (e.g. DTBCLK on DCN42B where the
+	 * clock is tied off and num_clk_values == 0).  Without this check the
+	 * else-if branch below would evaluate
+	 * clk_values_khz[num_clk_values - 1] with num_clk_values == 0, which
+	 * wraps the unsigned char index to 255 — a 235-element out-of-bounds
+	 * read on an array of DML_MAX_CLK_TABLE_SIZE (20) entries.
+	 *
+	 * Semantic: if the clock doesn't exist on this ASIC but no frequency
+	 * is required (min_value == 0), the request is trivially satisfied.
+	 * If a non-zero frequency is required but the clock is absent, the
+	 * configuration is unsupportable.
+	 */
+	if (clock_table->num_clk_values == 0) {
+		if (min_value == 0) {
+			*rounded_value = 0;
+			return true;
+		}
+		return false;
+	}
+
 	if (clock_table->num_clk_values > 2) {
 		while (index < clock_table->num_clk_values && clock_table->clk_values_khz[index] < min_value)
 			index++;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
index a265f254152c..eab13e1c96fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
@@ -178,9 +178,12 @@ static bool build_min_clock_table(const struct dml2_soc_bb *soc_bb, struct dml2_
 
 	min_table->max_clocks_khz.dispclk = soc_bb->clk_table.dispclk.clk_values_khz[soc_bb->clk_table.dispclk.num_clk_values - 1];
 	min_table->max_clocks_khz.dppclk = soc_bb->clk_table.dppclk.clk_values_khz[soc_bb->clk_table.dppclk.num_clk_values - 1];
-	min_table->max_clocks_khz.dscclk = soc_bb->clk_table.dscclk.clk_values_khz[soc_bb->clk_table.dscclk.num_clk_values - 1];
-	min_table->max_clocks_khz.dtbclk = soc_bb->clk_table.dtbclk.clk_values_khz[soc_bb->clk_table.dtbclk.num_clk_values - 1];
-	min_table->max_clocks_khz.phyclk = soc_bb->clk_table.phyclk.clk_values_khz[soc_bb->clk_table.phyclk.num_clk_values - 1];
+	min_table->max_clocks_khz.dscclk = (soc_bb->clk_table.dscclk.num_clk_values > 0) ?
+		soc_bb->clk_table.dscclk.clk_values_khz[soc_bb->clk_table.dscclk.num_clk_values - 1] : 0;
+	min_table->max_clocks_khz.dtbclk = (soc_bb->clk_table.dtbclk.num_clk_values > 0) ?
+		soc_bb->clk_table.dtbclk.clk_values_khz[soc_bb->clk_table.dtbclk.num_clk_values - 1] : 0;
+	min_table->max_clocks_khz.phyclk = (soc_bb->clk_table.phyclk.num_clk_values > 0) ?
+		soc_bb->clk_table.phyclk.clk_values_khz[soc_bb->clk_table.phyclk.num_clk_values - 1] : 0;
 
 	min_table->max_ss_clocks_khz.dispclk = (unsigned int)((double)min_table->max_clocks_khz.dispclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
 	min_table->max_ss_clocks_khz.dppclk = (unsigned int)((double)min_table->max_clocks_khz.dppclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
index 1f67cbc2c236..3eaeff39ee79 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
@@ -54,9 +54,12 @@ static bool build_min_clock_table(const struct dml2_soc_bb *soc_bb, struct dml2_
 
 	min_table->max_clocks_khz.dispclk = soc_bb->clk_table.dispclk.clk_values_khz[soc_bb->clk_table.dispclk.num_clk_values - 1];
 	min_table->max_clocks_khz.dppclk = soc_bb->clk_table.dppclk.clk_values_khz[soc_bb->clk_table.dppclk.num_clk_values - 1];
-	min_table->max_clocks_khz.dscclk = soc_bb->clk_table.dscclk.clk_values_khz[soc_bb->clk_table.dscclk.num_clk_values - 1];
-	min_table->max_clocks_khz.dtbclk = soc_bb->clk_table.dtbclk.clk_values_khz[soc_bb->clk_table.dtbclk.num_clk_values - 1];
-	min_table->max_clocks_khz.phyclk = soc_bb->clk_table.phyclk.clk_values_khz[soc_bb->clk_table.phyclk.num_clk_values - 1];
+	min_table->max_clocks_khz.dscclk = (soc_bb->clk_table.dscclk.num_clk_values > 0) ?
+		soc_bb->clk_table.dscclk.clk_values_khz[soc_bb->clk_table.dscclk.num_clk_values - 1] : 0;
+	min_table->max_clocks_khz.dtbclk = (soc_bb->clk_table.dtbclk.num_clk_values > 0) ?
+		soc_bb->clk_table.dtbclk.clk_values_khz[soc_bb->clk_table.dtbclk.num_clk_values - 1] : 0;
+	min_table->max_clocks_khz.phyclk = (soc_bb->clk_table.phyclk.num_clk_values > 0) ?
+		soc_bb->clk_table.phyclk.clk_values_khz[soc_bb->clk_table.phyclk.num_clk_values - 1] : 0;
 
 	min_table->max_ss_clocks_khz.dispclk = (unsigned int)((double)min_table->max_clocks_khz.dispclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
 	min_table->max_ss_clocks_khz.dppclk = (unsigned int)((double)min_table->max_clocks_khz.dppclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
-- 
2.43.0

