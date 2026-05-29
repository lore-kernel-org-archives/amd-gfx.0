Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9500DCD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 06:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3036310F941;
	Fri, 29 May 2026 06:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5OQrr8f8";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C8710F941
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xe9hKBwYTgcCNY6kUl5k6cNiADBaI/oTutiIqrwUNGpMwYcrEgFeJwdaHg2hh1GBk4iusK8fswNhzkTOw5q2FE+aBU7Z39Cvk3wAfQZ9lUrdu1pFTQvbDWplxoALwjX3M0XOpO08rQlzZHWq9gA2Q8mq54y0Jgv0S5ij/Vpke65Hea1qx9bjSwflyLlwHx+LOkXMLM8f574yzoOBzmxiZWgjvtUhV4FjcFSdQwd+oSxQw700G74dHTVIPqIseMAEkqzVq0zGdqqCCe3yzgbuV6VxqoSZmiCZg50mE7QONH2MSKWel8f8Ess+tkyKhBAgkHlMLAd4+meNw9WBLVVlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAuCIFxgvs7tNpHhw05/JPRhn5G/2j1YYkWzqfJIQ9o=;
 b=b6zuyZYz20gHOC25D/mcRcTyCJo1tcEI79BOF73CAqF2AGURcUYcWviEHU/RKbS1YU6z0gXwwDrYwFbeNxRJo609rI+J8xmcNI8mQS5SlR2OcMuaYgp/l/7AwPKrBfFEk2wazoPjmCnSK5/yc+nVWFHKg07RM0j6IrOk7d6nKoxEG1zx/bTz59u+tYdplSE/I/Z5HL3IgRRNKlBmTgn3xcnkHW76r2dADOSVr2TsULOrtVXfbZpmgOum/MdQIF8b5Na2QXCsWG/swWfMpOxBxkIlBCzK/ab078SRoBD4UZ4YKMK233xwBRrppyiLyEIkp97JaAx3F7+NOCCrUU9Xng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAuCIFxgvs7tNpHhw05/JPRhn5G/2j1YYkWzqfJIQ9o=;
 b=5OQrr8f8Dcv5omquib1jRxF9cZTpXh/Dp56Sp29Yzo5J1XYr/0ptD2io371rfTeEvrLG5Anf4ZUFJrJO1DTuR5ILWTxjvb73qowcAst+uJkiEtBCQEt5FQO5MkTtvw2mYOLDdsmY+X+Td9IVGknW1Wz8jFf2Z87feH46YSRH4IY=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by SA1PR12MB999108.namprd12.prod.outlook.com (2603:10b6:806:4a2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 06:17:29 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::6a) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Fri, 29
 May 2026 06:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 29 May 2026 06:17:28 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 01:17:25 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Validate OD DPM triples before mutating tables
Date: Fri, 29 May 2026 14:17:10 +0800
Message-ID: <20260529061710.356706-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SA1PR12MB999108:EE_
X-MS-Office365-Filtering-Correlation-Id: 2533474f-ac8b-4524-cd36-08debd49f5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: RCfbPwEFU4oO/ShyhoLSXHNuE+0zfiCkyNnOjwTZYoHGuV1xcU2EZGTRIOdqdqGr0FJ+l+hFGqNaohwUPZaBCplIRI3gXuEdXtAnrLSMi5rQCx5ODpL1U2+AKMqJ2iOeleqpcV0a4QfgaMDyXbplvu2j1M/59FUszt/9xrGDEiB7WZ6RwHEiTTcC2fKvar4ISnioXHyxcvuusg1Qc9rtMd9ySO+b+e3yS/VrpMIN5mEV3Y6q2+qJUtsWZnt0xHN1bE3ZeF0baiUfwwFZGyTdTe4JkJicVliL3/p1/jbF+BAB7Z8Xsvhfet0Bg1eqHwh+CUMiTw3snKmZwYR0J3t3fACoOIhGQfN+QbfRRukUTxaDdrTGxKUn6+GTIJ0n0IBn9xw0B1A6SfPoOup/Rc7NRAUd+SVy+PniqyF/NmiDCRrMQZVMuar9th+3zYJCA/uUtWHcw2qLby8ETf+vN/5JozRndRiOvKoy1IxVVdrhEQjVohrOMoeCampxzHADYg2NPyClj3GZPpuAhYwbCOPzxasijjvVSDN6ZEDuOqwqZjWm0uGTZcFbbdxvRhvS32B7MfIW7Y6m1BF8ieA2UceEnoKPP/u//ao2jYV/nDwJw/dqZvn7SJViCA/GMV7XpwgIALhbpHI70zGw7KHm1jei6cewwGtBA/3ewJMS1sRXjW4lwMqZtrYrHHMja/DKVJ7hGEbjywIJ7uUp0FMgSSK4Oqhr6+hvmoW+F79mG1M7jHc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mFOAQ3viKxNgcbropkkqobJHhTyuD4yEt1/qYBTzjfvxJhPTOZ3+r3H6W4V3kEh4r3O/LO3LKPMfHSKlzDnC9R+VV4AcjgABdScAQq+vHQEh0DyJM+qBdm98oa5oUiXOPW5RQtTweN1oS0R25uUSqul51/PZJXGGrdnDYX2wO+7Q/i0TPejgtIVEWRQ5cbyQDQs2riw69ocCRDMuZCSwN7qNtLrzTp9k8ZQsXU5EhuZyfvpS8AQ8ct5kY3sMFGurEH5cm4ANrPRUTFQVlx2bxNet7CNb0QW5pijl9bwe1vHy+WZJyTP30Y3X+s/5BF6w0Io4mVeqp31P/hIaLlnahf0a8xmOSYoJE9BNu/JJiwOaTzBlEZY2onUO345ko1LEjmCwJNZX8smKN4Zz4dkQkDOtVYegc0CPW6YKaAROsWnTuIy9bcnl1jgkXbpn7ngs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:17:28.7910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2533474f-ac8b-4524-cd36-08debd49f5e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999108
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
voltage) triples first and return -EINVAL on any failure, only then
apply updates.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 33 +++++++++++--------
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 27 +++++++++------
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 416b9380a70e..0a74e4f98496 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5648,23 +5648,30 @@ static int smu7_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
 	}
 
 	for (i = 0; i < size; i += 3) {
-		if (i + 3 > size || input[i] >= podn_dpm_table_in_backend->num_of_pl) {
+		if (i + 3 > size) {
 			pr_info("invalid clock voltage input \n");
-			return 0;
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
+			pr_info("invalid clock voltage input\n");
 			return -EINVAL;
 		}
+		input_level = input[i];
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
index 8b8c4e899878..ad06a2f26d91 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5477,21 +5477,28 @@ static int vega10_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
 	}
 
 	for (i = 0; i < size; i += 3) {
-		if (i + 3 > size || input[i] >= podn_vdd_dep_table->count) {
+		if (i + 3 > size) {
 			pr_info("invalid clock voltage input\n");
-			return 0;
+			return -EINVAL;
 		}
 		input_level = input[i];
-		input_clk = input[i+1] * 100;
-		input_vol = input[i+2];
-
-		if (vega10_check_clk_voltage_valid(hwmgr, type, input_clk, input_vol)) {
-			dpm_table->dpm_levels[input_level].value = input_clk;
-			podn_vdd_dep_table->entries[input_level].clk = input_clk;
-			podn_vdd_dep_table->entries[input_level].vddc = input_vol;
-		} else {
+		if (input_level >= podn_vdd_dep_table->count) {
+			pr_info("invalid clock voltage input\n");
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

