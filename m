Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E0BCD6E5D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 18:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FD010F49B;
	Tue,  2 Jun 2026 18:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vylOM0yn";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6400910F49B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 18:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzNlAyON2x6uPwWkHcOJkcvZhmv0h77akApvCLlu5NfkX0JEaiaClIwDkpn+vQG19EZK3j/KN6l2taadFIZUiNyY4Zi/UVnT+md89o0e//a5nUdcBf4ezu2VlYvaK6mQ/HPhpExpTTrgfQ/ffBKD/dYh2AKSlarSGKhWqcO/ZhHU2IQKkugQm8wC44qTD+TFu9wvk0EmQI9vwoJs8OpGgLp5PFJithelyCt2LXZGpNj9X7TpI5Nmb3ICZWdwEfg8ampoOQfB/rVQZNtASRQB1dF6g0qASvMI+QXzQi/1uGyw+jHyl2TZi2FoGLwNzYKn2IszJxMVXkBQciKZ55nfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7SaTJrwTrGv0O3VHehMu4LX8mvjMD2wOAu1RXm+RYI=;
 b=GOKIkvhs7YI/Q6+3hLvuxy1QWCrYIsDwpK0o2td5XCTx+TsQIWI7VjBrhl0Huez71V0kSZ6V+JxEV3kPXF4oQZ7YtrqW84vPsWiM0eyStn2/cHEAV0yLhSqg+537lC88kzoG6aH2LnXb7pi5mn+daeHZAMecyv4EJX3n3pSzH/4WoIiDP9n4UBUWKgtZ9VJJFHI/RvQ6aUtZo0BgRWRjlhXxBvgel/lkNcOeR63Au0TE575gGS2sCTVK7kOLxNI1u4IjlvGYc5FtBdoiiwxMWSbbbFxgRwXohY9LMfpjzSg3SFIpYbO3hI582IIPlenAg87qsjA0LQMNx65V+sr6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7SaTJrwTrGv0O3VHehMu4LX8mvjMD2wOAu1RXm+RYI=;
 b=vylOM0yn9lAuKKeitY/rOQbcjyY+IN2tvoNW2ji7YsxLHE69Ih1sBA6s8px/8Vw5dk7FnUQ+58kNcuD+NgdMEs7U6FC0CCgWokqNtliCUOX/m3Fr0kAsAHFjjCjuzIWF0wzxDis0WX1g1u1/bT1sI8HnIMbK4g9wQOrAUc4t/Ww=
Received: from BN0PR04CA0034.namprd04.prod.outlook.com (2603:10b6:408:e8::9)
 by IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 18:09:41 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::1f) by BN0PR04CA0034.outlook.office365.com
 (2603:10b6:408:e8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 18:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 18:09:40 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 13:09:38 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: Validate OD DPM triples before mutating tables
Date: Wed, 3 Jun 2026 02:09:24 +0800
Message-ID: <20260602180924.726003-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 65764fb1-5e35-49fb-ee1f-08dec0d21dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xo0GHqkR2guN+r/pOTkp8C+iHd+bOu2SuqlN5ULlQgplqdmHasKW3M8Chb+lqCVGQJerfxKiSOjC1Ih9/GO/p6hOtRntLoEG3fBbWse6Qose1L9D9maIeTE2DA58UwupfYnCpUG7P9UCWbdhFLcVg/qygRvxutB9aFj1NjuscnTRAFx6PRX9VI/I985FCkeoQz4RWIap4b27Vca38hXcUI2ItXYUAkyW+dY1MPVczXXRNFLUnfQHVwiPuQ17kgj4njA1urQMWQDkoPl9E7bz34P8hAup7U/Ecr5wjCsNX/LmK6DS9o3bpOhrhqoXmh1lXMWCriQQ5Mg8IA6OTQ70p52zDo1q24ZC7pQNIwe4AdtOcbLcBpXOGdjil5VtX905ZSlhtXGVdK4J4eETqJUYBHU1vmCtkEDzEF/GY+rOgsxmmTQnF/YbltiyGYZ9yhQcPuzdy7lJoX5CLVJxspS+NE9sJPuE5r0EgaT9ys8Xae4EVCU+dG+wpWcVPG9uEsF9fSy8X0PNleQBDyhtb0IS8EjgWlXTY/p4MpdJbUzikPADj41Gfb5vleb/pk+x1GRBqT9cme5vax6SqaMVAJzMr++Db7GGZ/k5rVlH6YhFQC6CXtqsgt1W5nccWX706iHWta7Wqqx9E4z/7ObNTQZoK2qvKeK/IrhssysjXpyuiRU3z67cHy00mA4Wb5wc18dAEsSGYdwXfg/+lFuNFbeXxSCrb1W8qN3Vcs+hUqjxdxY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PSoJZe/DA9DfoMClviOHLsc4fOlLQq1NH72UahZZLX87wKHJXQ4j/bxa81Bvh0ElNmC3sJaPnf+Q5NCYxlQ0V7lfhc2sXiZR0WHzgrKMzZO5vOWfyqPrJDayYNv1s27bnzllafTFV5blVHYn1L6IQUsk2q9PszdlbAYSBmg0njoLAqC8nUuxIS0IMm3WO0qc8sWuZwblnskRVPcrzpOxb55KlTW/0n60kNyC4M0lh+C36yjK+UMqCOOHT+p2rN+/rOKpUe5C9RDa8P4xz7f7safWhEh7aywQYLPNtGX/MiVFQVMi1ISSfaOhJzvXE114O5DU4ajsVTUMe2zhHm/tyRlRd2LYqxrrfeKvlWuqDQNrjtUCpLGffBIQKiUt0lMe7Qg1xezGokOBie1BgnDe32OdeZZ9c8WL6JmWXKmjCkvYg7V22zrdANE8R/i3kSW5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 18:09:40.7696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65764fb1-5e35-49fb-ee1f-08dec0d21dc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788
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

vega10_odn_edit_dpm_table() and smu7_odn_edit_dpm_table() could mutate
the live ODN table for valid triples, then return 0 after detecting a
truncated buffer or out-of-range index. Validate all (index, clock,
voltage) triples first and return -EINVAL on any failure; only then
apply updates.

v2: Use distinct message for different error case, removed unused
input_level from validation loop (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 34 +++++++++++--------
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 30 +++++++++-------
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 416b9380a70e..fb38247da8fc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5648,23 +5648,29 @@ static int smu7_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
 	}
 
 	for (i = 0; i < size; i += 3) {
-		if (i + 3 > size || input[i] >= podn_dpm_table_in_backend->num_of_pl) {
-			pr_info("invalid clock voltage input \n");
-			return 0;
+		if (i + 3 > size) {
+			pr_info("truncated clock/voltage input\n");
+			return -EINVAL;
 		}
-		input_level = input[i];
-		input_clk = input[i+1] * 100;
-		input_vol = input[i+2];
-
-		if (smu7_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol)) {
-			podn_dpm_table_in_backend->entries[input_level].clock = input_clk;
-			podn_vdd_dep_in_backend->entries[input_level].clk = input_clk;
-			podn_dpm_table_in_backend->entries[input_level].vddc = input_vol;
-			podn_vdd_dep_in_backend->entries[input_level].vddc = input_vol;
-			podn_vdd_dep_in_backend->entries[input_level].vddgfx = input_vol;
-		} else {
+		if (input[i] >= podn_dpm_table_in_backend->num_of_pl) {
+			pr_info("invalid clock/voltage level\n");
 			return -EINVAL;
 		}
+		input_clk = input[i + 1] * 100;
+		input_vol = input[i + 2];
+		if (!smu7_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol))
+			return -EINVAL;
+	}
+
+	for (i = 0; i < size; i += 3) {
+		input_level = input[i];
+		input_clk = input[i + 1] * 100;
+		input_vol = input[i + 2];
+		podn_dpm_table_in_backend->entries[input_level].clock = input_clk;
+		podn_vdd_dep_in_backend->entries[input_level].clk = input_clk;
+		podn_dpm_table_in_backend->entries[input_level].vddc = input_vol;
+		podn_vdd_dep_in_backend->entries[input_level].vddc = input_vol;
+		podn_vdd_dep_in_backend->entries[input_level].vddgfx = input_vol;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 8b8c4e899878..0bcba317a358 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5477,21 +5477,27 @@ static int vega10_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
 	}
 
 	for (i = 0; i < size; i += 3) {
-		if (i + 3 > size || input[i] >= podn_vdd_dep_table->count) {
-			pr_info("invalid clock voltage input\n");
-			return 0;
+		if (i + 3 > size) {
+			pr_info("truncated clock/voltage input\n");
+			return -EINVAL;
 		}
-		input_level = input[i];
-		input_clk = input[i+1] * 100;
-		input_vol = input[i+2];
-
-		if (vega10_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol)) {
-			dpm_table->dpm_levels[input_level].value = input_clk;
-			podn_vdd_dep_table->entries[input_level].clk = input_clk;
-			podn_vdd_dep_table->entries[input_level].vddc = input_vol;
-		} else {
+		if (input[i] >= podn_vdd_dep_table->count) {
+			pr_info("invalid clock/voltage level\n");
 			return -EINVAL;
 		}
+		input_clk = input[i + 1] * 100;
+		input_vol = input[i + 2];
+		if (!vega10_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol))
+			return -EINVAL;
+	}
+
+	for (i = 0; i < size; i += 3) {
+		input_level = input[i];
+		input_clk = input[i + 1] * 100;
+		input_vol = input[i + 2];
+		dpm_table->dpm_levels[input_level].value = input_clk;
+		podn_vdd_dep_table->entries[input_level].clk = input_clk;
+		podn_vdd_dep_table->entries[input_level].vddc = input_vol;
 	}
 	vega10_odn_update_soc_table(hwmgr, type);
 	return 0;
-- 
2.46.0

