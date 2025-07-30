Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C0FC83F26
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4EF10E6C6;
	Wed, 30 Jul 2025 19:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jxpoSIpw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DD910E6CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1nwnDDYBjrNn/0ZV9xt4fMoNERz2jUpAneZsuCv29LK3Qc81LonUqN02QpQFsZSc+K7Grf3FNV2glb5QXQh4fuhDNkJJ9wOXcQ2pUr56v4P5SQaWFyCnH27CeUYVKVCdtCOu1ihqL+E6Nzdp/XOK74h1fxYeIBdQUvzMz/omrBfg7IAjpvh+XCjHe6BEIDjn6++I+/WlR2ctuYVRUPS++rcUwMU4do3g+/pTTIOcCtEkle3+0QS+wCu1/SwiLyD+eOvfWykGDoB4KsEovWJbmB17PHTNiMRpe9WZnYdeeUKGA707G34hRfRBCJPZTI8DXFV1/iRfB28k6/6pWT8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiYhZHZ6iOlCJexphTyQ5LTUkjjas23xKLuT3xVfU/k=;
 b=lbdDfYpLOkZ15395Tf5jjwaocaVVgeTn2uxCMBS6Ak9hXwJ9p2pCr4gH48AG7gVupJKcDa1tz0DQ5psKKXYs8LRG+eP7f0W080dfudg8Q7jIjkcDXyrgezhYuP1cP2A48WVRVmWMqfndq5SdpxuNeDus1d1UCDeEI/KWzoBFn7ArJAAVpKismVHbVFQye3j/l3UZ7am+qeXFQ6i/TZlMG4p4kPgfh5JGXwIJimL2TIQKVAiDTXIJH4SKa9pFn5R3WobyCZ9w/C3eARwcpbYXmTqo1p5+mcPBuFfs8FwVuP7sZRXOYvpZXKM5ZntRq43Wu7v4OnLAMi0a5kl9UABuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiYhZHZ6iOlCJexphTyQ5LTUkjjas23xKLuT3xVfU/k=;
 b=jxpoSIpwJAJqYbaIeL/ELNLBhL8u7ETYwNFGu/ugzFDQZCMQjZ4WTGI2Gfyl/fCvfGzngD02RYGbfI/JIWvoGLvGVdKl7dZQSyI0KSh56Hsau8tgvzinLG/1RbOZZcIGS97ggNCpGJPmDow1pa2N+pLVI7l2LbGlVZG6+bv+WwQ=
Received: from MN2PR22CA0028.namprd22.prod.outlook.com (2603:10b6:208:238::33)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Wed, 30 Jul
 2025 19:00:51 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::dd) by MN2PR22CA0028.outlook.office365.com
 (2603:10b6:208:238::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 19:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:00:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:49 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:00:48 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Paul Hsieh <Paul.Hsieh@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 05/12] drm/amd/display: update dpp/disp clock from smu clock
 table
Date: Wed, 30 Jul 2025 14:58:56 -0400
Message-ID: <20250730185903.1023256-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: ed092412-4dbf-463d-f6e5-08ddcf9b66b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YBNIxzHi4rC1tQuMOushotvZ8t4qGBBqsKo0FUkI9/KqRILa5s1UJGsRjngc?=
 =?us-ascii?Q?2wuoEd1Vh2Pq1fJwalYJuWEqJuu0DZKxB0KL4TkzZkykc3lMHCh1gyCTPVMy?=
 =?us-ascii?Q?mSKvTqkOYYoVwS4EUWg1iA7nXl61LwX9jrVFIOyq7CTIEXKHzjkh0P+nWDim?=
 =?us-ascii?Q?r+wwd8wGKEMvKAabDegwF9hzvwcZ/0Kc/FOCkG+BJCnNzcbFph+Vv7tm3xb0?=
 =?us-ascii?Q?xZCDQdA+ZQEiPPsRQrW26rezUhViQbq7767FqDC2xKYz7ZyMtfvMV+b37CU8?=
 =?us-ascii?Q?/Ozru9mBOExSut/vwEFR8SylwMsomf/vUmzOw9Wq6fUq/xBDefQAo8W61SY/?=
 =?us-ascii?Q?1Nd83fNDGDodLLYQyULOwCmshmSyY1GllJTfzPMG4zqOntSkWBvx47NgPd5T?=
 =?us-ascii?Q?HuoKB4/SlZM2nLKQxfnhuQGxR2B3NLat0vPIQ9SEb+j7KblQf0fGbZh0/2Ku?=
 =?us-ascii?Q?zudi9Teom17TyLefPWCw/zJN2cGMPtL+W1EVHxUTSkWnQxA08xONXH8QolN5?=
 =?us-ascii?Q?+WxflQrUQ7QuDwxYxwZrhYkaspeILZzp/f5v1yqBKLMz2ZbPIS2KRkSC9mpA?=
 =?us-ascii?Q?pvu6mGjkOCqOCm7/yHlyf50oIuGMgyQRE+/vWvhfW6Fxhq3W6vnrMviS1c4c?=
 =?us-ascii?Q?yRpH53mUGNYE6l7fSdra4EcWUtuGPh2aW/3AtaoMXgtFh06b5XSVq0E+1KlZ?=
 =?us-ascii?Q?nqmkWCtxotfwThYEzxEjt4Dxq7pZg2u0HIlK9CGYosNjKt9ADi2C7fAndSMu?=
 =?us-ascii?Q?47ZXF+O1E+KG77ccCXyBokPe909kC8Er/5RyiD9Mp2Q14C5DtWbZOXgZof92?=
 =?us-ascii?Q?oZQaIFPSjr79PnmzrxRGXaQ3vQ0ntXXgzc8rhgqIWvpyQFUl12TFhvoUSpyG?=
 =?us-ascii?Q?LBVqo/4Il8GPMNGbHW4w+GzJNQTe050tJlDAgf872UgEQJppHrRhDRDWSZcR?=
 =?us-ascii?Q?j6D5b6o/EjFu7urOfrlk0U/ToNHmxbj7pxx9ulrFyorBNElUOKNh35lnGuc/?=
 =?us-ascii?Q?dHvLM1woR+5LK4CzZWgjOte3X8lzOMJoDMoJdg7ELGUsAJRvwes+KKZ/C6wu?=
 =?us-ascii?Q?6PCqHJ3pslyT60M4CU9ICpGEwsQptmkI/Bt+eU3PBb+ig8SN/UZ+rNg9KSF7?=
 =?us-ascii?Q?QnDmQDARk/lLLVRcQgwfeBUdB5URJIAyAmTcX354QO2cJzvtnGUCASARaQaw?=
 =?us-ascii?Q?/Sm518i5BxtoHeOhMR609tRGf0QKaNwMskKfXr9tjxHAD3waeYBdb/CIYAw3?=
 =?us-ascii?Q?AZFSU6aKUDo3s8sFuTe+ZiBjtY3vbZPPv1OrCRb+GfvV6htnSwICpg/heTXR?=
 =?us-ascii?Q?FjTz/zzTBIb+gjm13iNKmATqWZCegf98jRv4eO1OsH8nPJ/2sM9Eqw/tZYE2?=
 =?us-ascii?Q?WIkKBMkYxvOdQyJ5LiDW6AN6yzqBsm0u/mLrx/W91MnSB7+4xUcIlj+Qvtey?=
 =?us-ascii?Q?irT8J1egYaSwHlz4rZ+GjJ3/YHURtQQqZoDHroTNz8Wg8yDbHWJmRNRP4eUw?=
 =?us-ascii?Q?nJfaOg+Wg5JJ5yaS4OMkj8EkRgzPnB5aQwem?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:00:50.6070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed092412-4dbf-463d-f6e5-08ddcf9b66b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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

From: Paul Hsieh <Paul.Hsieh@amd.com>

[Why]
The reason some high-resolution monitors fail to display properly
is that this platform does not support sufficiently high DPP and
DISP clock frequencies

[How]
Update DISP and DPP clocks from the smu clock table then DML can
filter these mode if not support.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Paul Hsieh <Paul.Hsieh@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 16 +++++++++++++++
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 20 ++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 9e2ef0e724fc..7aee02d56292 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -563,6 +563,7 @@ static void vg_clk_mgr_helper_populate_bw_params(
 {
 	int i, j;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
+	uint32_t max_dispclk = 0, max_dppclk = 0;
 
 	j = -1;
 
@@ -584,6 +585,15 @@ static void vg_clk_mgr_helper_populate_bw_params(
 		return;
 	}
 
+	/* dispclk and dppclk can be max at any voltage, same number of levels for both */
+	if (clock_table->NumDispClkLevelsEnabled <= VG_NUM_DISPCLK_DPM_LEVELS &&
+	    clock_table->NumDispClkLevelsEnabled <= VG_NUM_DPPCLK_DPM_LEVELS) {
+		max_dispclk = find_max_clk_value(clock_table->DispClocks, clock_table->NumDispClkLevelsEnabled);
+		max_dppclk = find_max_clk_value(clock_table->DppClocks, clock_table->NumDispClkLevelsEnabled);
+	} else {
+		ASSERT(0);
+	}
+
 	bw_params->clk_table.num_entries = j + 1;
 
 	for (i = 0; i < bw_params->clk_table.num_entries - 1; i++, j--) {
@@ -591,11 +601,17 @@ static void vg_clk_mgr_helper_populate_bw_params(
 		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].memclk;
 		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].voltage;
 		bw_params->clk_table.entries[i].dcfclk_mhz = find_dcfclk_for_voltage(clock_table, clock_table->DfPstateTable[j].voltage);
+
+		/* Now update clocks we do read */
+		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
+		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
 	}
 	bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].fclk;
 	bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].memclk;
 	bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].voltage;
 	bw_params->clk_table.entries[i].dcfclk_mhz = find_max_clk_value(clock_table->DcfClocks, VG_NUM_DCFCLK_DPM_LEVELS);
+	bw_params->clk_table.entries[i].dispclk_mhz = find_max_clk_value(clock_table->DispClocks, VG_NUM_DISPCLK_DPM_LEVELS);
+	bw_params->clk_table.entries[i].dppclk_mhz = find_max_clk_value(clock_table->DppClocks, VG_NUM_DPPCLK_DPM_LEVELS);
 
 	bw_params->vram_type = bios_info->memory_type;
 	bw_params->num_channels = bios_info->ma_channel_number;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 0c0b2d67c9cd..2066a65c69bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -326,7 +326,7 @@ void dcn301_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 	struct dcn301_resource_pool *pool = TO_DCN301_RES_POOL(dc->res_pool);
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	unsigned int i, closest_clk_lvl;
-	int j;
+	int j = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 
 	dc_assert_fp_enabled();
 
@@ -338,6 +338,15 @@ void dcn301_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 	dcn3_01_soc.num_chans = bw_params->num_channels;
 
 	ASSERT(clk_table->num_entries);
+
+	/* Prepass to find max clocks independent of voltage level. */
+	for (i = 0; i < clk_table->num_entries; ++i) {
+		if (clk_table->entries[i].dispclk_mhz > max_dispclk_mhz)
+			max_dispclk_mhz = clk_table->entries[i].dispclk_mhz;
+		if (clk_table->entries[i].dppclk_mhz > max_dppclk_mhz)
+			max_dppclk_mhz = clk_table->entries[i].dppclk_mhz;
+	}
+
 	for (i = 0; i < clk_table->num_entries; i++) {
 		/* loop backwards*/
 		for (closest_clk_lvl = 0, j = dcn3_01_soc.num_states - 1; j >= 0; j--) {
@@ -353,8 +362,13 @@ void dcn301_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 		s[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
 		s[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
 
-		s[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-		s[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+		/* Clocks independent of voltage level. */
+		s[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
+			dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+
+		s[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
+			dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+
 		s[i].dram_bw_per_chan_gbps =
 			dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
 		s[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-- 
2.34.1

