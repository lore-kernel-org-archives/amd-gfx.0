Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0256CDB47F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 10:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C13610EA7B;
	Tue, 23 Jun 2026 10:23:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tF0id5Rd";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B0210EA75
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 10:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqPcF8k89Sk2dzgwXq1NAaPnfOE1uDPaoamoHKD8dpRfQSHElE9ZNcqLuc269D+LuA2wNNmGZ0VjtFzOiK0QPajMixiGjui3YaKa1nlW8jZW+aWrg20Ju2JwYxquJVcDr0gHI0yA2rF5u8Oeyu976LZgA4GnKa1icwQhdYYERa4IiAkYNJBfnSjNrtwOlI9PM+9BEo5Q8Svd6DZBIH5RNGjsTU6XTA8CN51i+BmPymODUflYAU8UfBH0pOMd0wAgB5U1E6eCgY+vN/LCxQu4s/KO1UEkDKsrSt+uIKLRyZLPtKExwB2nhR7xrtVVDZ3MD5usdOgycg0gFzCYxcKuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieWHXWJNRa6v/yQUej4Qr9ak9UPsno5OkPzH8n2FLDw=;
 b=VPehOzOjCw0+UvjVhVCntrEpcJv/+C3MCgvfZExDYNdL0q0mDPGNYzGDaaB31bBoAtR8GNDuKIOBQetiFtPSvfu1jTjkc3NyWAuTdrtsbxXC7qGAEyltuGl0xI3yvvE54I/7kPZg5cmcRWfKZPYpD8dxKTkaRPXGdvamCwAAr8N84ZVN1rnL7b0eoD7phcOOfPUzArHAD6p9Jg/WDz7KaJZY69UQ7g+AbnASCS8/fuyoxQCCwXMJ3r1c/Inw+wvE5zDULyYkEbxpgkbZry9Hf1Kjje4GBDd8UlxMKfKR/+QcdDBVeJpSjnfwbQrU0z6IPSnNafQ/oYn5Lzz9MbGcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieWHXWJNRa6v/yQUej4Qr9ak9UPsno5OkPzH8n2FLDw=;
 b=tF0id5RdbRZYUDazBfnUfLrVjbl/I2ztjaJ3Y2wnqxqFU7fSHgZlZ+YR16pkYEbHL7NRRfRHoRXKjdKstguYu1s/5XAByFALInvEdn6GUzjZ6nKEOvzWNKw3l76oTGT3okmxUokX1m7vuM3ax54WXee7BtXgjYJJNeGixdft5M4=
Received: from CH2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:5a::40)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 10:23:38 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::67) by CH2PR08CA0030.outlook.office365.com
 (2603:10b6:610:5a::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 10:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 10:23:38 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 05:23:36 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Validate remaining legacy PPLIB table bounds
Date: Tue, 23 Jun 2026 18:23:19 +0800
Message-ID: <20260623102319.413960-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623102319.413960-1-kevinyang.wang@amd.com>
References: <20260623102319.413960-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e34b7bf-c0dc-4dc5-e972-08ded1117d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: aGWjeK6ryN8+RLn8eAQaXbv3aEbiFS2CP+9NrQ3gtsmcp2YlwHoTVW0QT51RieH3xByG89MOFB0cB2DIZ47GiF0c/7a2qVrnkkhglcidHZiGsOpY+wYcvA9Lxr6/Arfskwr0Q/fitSaxC1OVg+dugrxgaOMYz4ut3Jr1hwbGboykpJpbjqfsNLDSUkZEAPLS6mxMV3/IR9xme9tBxUD3EtIyIAsEzF+6NKhLZlf6havRNJ5WRe7S+yHxUc6TweldIkn0xWrtFla0gsyQzZ5Of07S2ihaBldNjAmCrdUNKD/uqm3sBIsSPJxs7ZDUt+CwcldBP1Y1+3EPvFEZKNYMPjuXjdJHkjh0qX/8vdtACKCXGxY2V9BGmTX/930BNrSrFOOqRKy8RTVQTa2ec+tiFULQ2AknD4M6+6YNsJJTg1feryBvhI4WugUlNLKjkqia+OtnVSQfs8Wjd4hpbg9YN6E0c99/DJyfi5Kq8fu++Y/YH4BPwLyoDmawr8Xutf92sZjSK41iWuB+LnejmGkzJJ/heqmK17gJ4A0NEP1vKwgCQjh/7Le3H7pCGiOcqLrvCDtOtV5wjZu0sXAZH6r26fBmgaPH+yay5TsbFjJKxGN8U2nZt8Gi3Yyq6bItkeb7uFL5VyfhJxZo/0+zbNlcBcXu+6CeJJ5XMbH26p0KnFZvgJSNH+T/Q7yUpt1xXL9gRMqDy6W7pb4ofVmhbT9SVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l2JMRfNs0WFfq46WMhFshqnBhLIwoELjUMYf8FjCTUGfCcLb2KtDiWPwv+Sss7peVjvgY6QiYRLLiXTOENVUk65IA0kLJuZEDKNWV0ldzD1B2ypueBJK9Q1GIqkjshVnNiiR2nnCKDaxqmubndwx8SCUfVoQfbIaFjn/v4xVDJ8wyh0NgGWSST6m9sYVe3xixlwjxg/F1uH6DVlmYkpGeqQ1P9L8cjbCwl9CBGbzLB7GtEthD1hzJWeOBuAJafnW72pAqTkFTSzYc6kEFJ2TWJ1BubAJPfBADq4Oj887s/BAzDVqgDsNZSq3O5B96vhP8YDxOZyfuVqc8F4DK4TJMdqzhxWkzfh9J12nzOdDzlDbFq4zjxtX+3hI3Y8cJEAr0WP7hEZf/U1wCKbeGXM+4bfdwWXh2CoMpGJs9FfMbJxvX/DVk0Y1lQ0fWwcsUrrH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 10:23:38.0130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e34b7bf-c0dc-4dc5-e972-08ded1117d56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
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

The legacy PPLIB parser still had paths that consumed VBIOS offsets,
entry counts and clock-info indices before proving the referenced data
fit within soft_pp_table_size. Malformed tables can trigger
out-of-bounds reads while parsing clock-voltage, CAC, fan, PPM and
phase-shedding data.

Add shared bounds checks for the remaining fixed and variable-length
legacy subtables. Also validate UVD/VCE clock-info indices before
indexing their clock-info arrays.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../amd/pm/powerplay/hwmgr/processpptables.c  | 427 ++++++++++++++----
 1 file changed, 338 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index b2e1123844ec..678c31abe4c4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -55,6 +55,159 @@ static bool pp_table_has_space(struct pp_hwmgr *hwmgr, size_t offset,
 	return offset <= table_size && size <= table_size - offset;
 }
 
+static int get_pplib_subtable(struct pp_hwmgr *hwmgr,
+			      const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table,
+			      u16 table_offset, size_t table_size,
+			      const void **table)
+{
+	PP_ASSERT_WITH_CODE((table_offset != 0),
+			    "Invalid PowerPlay Table!", return -1);
+	PP_ASSERT_WITH_CODE((pp_table_has_space(hwmgr, table_offset,
+						table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*table = (const void *)(((unsigned long)powerplay_table) + table_offset);
+
+	return 0;
+}
+
+static int validate_pplib_table_entries(struct pp_hwmgr *hwmgr,
+					u16 table_offset, size_t entries_offset,
+					u8 num_entries, size_t entry_size)
+{
+	size_t table_size;
+
+	PP_ASSERT_WITH_CODE((num_entries != 0),
+			    "Invalid PowerPlay Table!", return -1);
+
+	table_size = entries_offset + num_entries * entry_size;
+	PP_ASSERT_WITH_CODE((pp_table_has_space(hwmgr, table_offset,
+						table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	return 0;
+}
+
+static int validate_pplib_optional_table_entries(struct pp_hwmgr *hwmgr,
+					u16 table_offset, size_t entries_offset,
+					u8 num_entries, size_t entry_size)
+{
+	size_t table_size;
+
+	table_size = entries_offset + num_entries * entry_size;
+	PP_ASSERT_WITH_CODE((pp_table_has_space(hwmgr, table_offset,
+						table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	return 0;
+}
+
+static int get_pplib_clock_voltage_dependency_table(struct pp_hwmgr *hwmgr,
+			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table,
+			u16 table_offset,
+			const ATOM_PPLIB_Clock_Voltage_Dependency_Table **table)
+{
+	const ATOM_PPLIB_Clock_Voltage_Dependency_Table *dep_table;
+	int ret;
+
+	ret = get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*dep_table), (const void **)&dep_table);
+	if (ret)
+		return ret;
+
+	ret = validate_pplib_table_entries(hwmgr, table_offset,
+					   offsetof(ATOM_PPLIB_Clock_Voltage_Dependency_Table,
+						    entries),
+					   dep_table->ucNumEntries,
+					   sizeof(ATOM_PPLIB_Clock_Voltage_Dependency_Record));
+	if (ret)
+		return ret;
+
+	*table = dep_table;
+
+	return 0;
+}
+
+static int get_pplib_clock_voltage_limit_table(struct pp_hwmgr *hwmgr,
+			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table,
+			u16 table_offset,
+			const ATOM_PPLIB_Clock_Voltage_Limit_Table **table)
+{
+	const ATOM_PPLIB_Clock_Voltage_Limit_Table *limit_table;
+	int ret;
+
+	ret = get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*limit_table),
+				 (const void **)&limit_table);
+	if (ret)
+		return ret;
+
+	ret = validate_pplib_table_entries(hwmgr, table_offset,
+					   offsetof(ATOM_PPLIB_Clock_Voltage_Limit_Table,
+						    entries),
+					   limit_table->ucNumEntries,
+					   sizeof(ATOM_PPLIB_Clock_Voltage_Limit_Record));
+	if (ret)
+		return ret;
+
+	*table = limit_table;
+
+	return 0;
+}
+
+static int get_pplib_cac_leakage_table(struct pp_hwmgr *hwmgr,
+			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table,
+			u16 table_offset,
+			const ATOM_PPLIB_CAC_Leakage_Table **table)
+{
+	const ATOM_PPLIB_CAC_Leakage_Table *leakage_table;
+	int ret;
+
+	ret = get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*leakage_table),
+				 (const void **)&leakage_table);
+	if (ret)
+		return ret;
+
+	ret = validate_pplib_optional_table_entries(hwmgr, table_offset,
+					   offsetof(ATOM_PPLIB_CAC_Leakage_Table,
+						    entries),
+					   leakage_table->ucNumEntries,
+					   sizeof(ATOM_PPLIB_CAC_Leakage_Record));
+	if (ret)
+		return ret;
+
+	*table = leakage_table;
+
+	return 0;
+}
+
+static int get_pplib_phase_shedding_table(struct pp_hwmgr *hwmgr,
+			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table,
+			u16 table_offset,
+			const ATOM_PPLIB_PhaseSheddingLimits_Table **table)
+{
+	const ATOM_PPLIB_PhaseSheddingLimits_Table *phase_table;
+	int ret;
+
+	ret = get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*phase_table), (const void **)&phase_table);
+	if (ret)
+		return ret;
+
+	ret = validate_pplib_optional_table_entries(hwmgr, table_offset,
+					   offsetof(ATOM_PPLIB_PhaseSheddingLimits_Table,
+						    entries),
+					   phase_table->ucNumEntries,
+					   sizeof(ATOM_PPLIB_PhaseSheddingLimits_Record));
+	if (ret)
+		return ret;
+
+	*table = phase_table;
+
+	return 0;
+}
+
 static const ATOM_PPLIB_EXTENDEDHEADER *
 get_extended_header(struct pp_hwmgr *hwmgr,
 		    const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table,
@@ -1143,14 +1296,36 @@ static int init_thermal_controller(
         if (powerplay_table->usTableSize >= sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
 		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =
 			(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
+		u16 fan_table_offset;
 
 		if (0 == le16_to_cpu(powerplay_table3->usFanTableOffset)) {
 			hwmgr->thermal_controller.use_hw_fan_control = 1;
 			return 0;
 		} else {
-			const ATOM_PPLIB_FANTABLE *fan_table =
-				(const ATOM_PPLIB_FANTABLE *)(((unsigned long)powerplay_table) +
-							      le16_to_cpu(powerplay_table3->usFanTableOffset));
+			const ATOM_PPLIB_FANTABLE *fan_table;
+			size_t fan_table_size;
+
+			fan_table_offset = le16_to_cpu(powerplay_table3->usFanTableOffset);
+			if (!pp_table_has_space(hwmgr, fan_table_offset,
+						sizeof(*fan_table)))
+				return -EINVAL;
+
+			fan_table = (const ATOM_PPLIB_FANTABLE *)
+				(((unsigned long)powerplay_table) + fan_table_offset);
+			if (fan_table->ucFanTableFormat >= 7)
+				fan_table_size = sizeof(ATOM_PPLIB_FANTABLE5);
+			else if (fan_table->ucFanTableFormat >= 6)
+				fan_table_size = sizeof(ATOM_PPLIB_FANTABLE4);
+			else if (fan_table->ucFanTableFormat >= 3)
+				fan_table_size = sizeof(ATOM_PPLIB_FANTABLE3);
+			else if (fan_table->ucFanTableFormat >= 2)
+				fan_table_size = sizeof(ATOM_PPLIB_FANTABLE2);
+			else
+				fan_table_size = sizeof(ATOM_PPLIB_FANTABLE);
+
+			if (!pp_table_has_space(hwmgr, fan_table_offset,
+						fan_table_size))
+				return -EINVAL;
 
 			if (1 <= fan_table->ucFanTableFormat) {
 				hwmgr->thermal_controller.advanceFanControlParameters.ucTHyst =
@@ -1176,16 +1351,14 @@ static int init_thermal_controller(
 
 			if (2 <= fan_table->ucFanTableFormat) {
 				const ATOM_PPLIB_FANTABLE2 *fan_table2 =
-					(const ATOM_PPLIB_FANTABLE2 *)(((unsigned long)powerplay_table) +
-								       le16_to_cpu(powerplay_table3->usFanTableOffset));
+					(const ATOM_PPLIB_FANTABLE2 *)fan_table;
 				hwmgr->thermal_controller.advanceFanControlParameters.usTMax =
 					le16_to_cpu(fan_table2->usTMax);
 			}
 
 			if (3 <= fan_table->ucFanTableFormat) {
 				const ATOM_PPLIB_FANTABLE3 *fan_table3 =
-					(const ATOM_PPLIB_FANTABLE3 *) (((unsigned long)powerplay_table) +
-									le16_to_cpu(powerplay_table3->usFanTableOffset));
+					(const ATOM_PPLIB_FANTABLE3 *)fan_table;
 
 				hwmgr->thermal_controller.advanceFanControlParameters.ucFanControlMode =
 					fan_table3->ucFanControlMode;
@@ -1206,8 +1379,7 @@ static int init_thermal_controller(
 
 			if (6 <= fan_table->ucFanTableFormat) {
 				const ATOM_PPLIB_FANTABLE4 *fan_table4 =
-					(const ATOM_PPLIB_FANTABLE4 *)(((unsigned long)powerplay_table) +
-								       le16_to_cpu(powerplay_table3->usFanTableOffset));
+					(const ATOM_PPLIB_FANTABLE4 *)fan_table;
 
 				phm_cap_set(hwmgr->platform_descriptor.platformCaps,
 					    PHM_PlatformCaps_FanSpeedInTableIsRPM);
@@ -1218,8 +1390,7 @@ static int init_thermal_controller(
 
 			if (7 <= fan_table->ucFanTableFormat) {
 				const ATOM_PPLIB_FANTABLE5 *fan_table5 =
-					(const ATOM_PPLIB_FANTABLE5 *)(((unsigned long)powerplay_table) +
-								       le16_to_cpu(powerplay_table3->usFanTableOffset));
+					(const ATOM_PPLIB_FANTABLE5 *)fan_table;
 
 				if (0x67A2 == adev->pdev->device ||
 				    0x67A9 == adev->pdev->device ||
@@ -1351,8 +1522,14 @@ static int get_uvd_clock_voltage_limit_table(struct pp_hwmgr *hwmgr,
 	uvd_table->count = table->numEntries;
 
 	for (i = 0; i < table->numEntries; i++) {
-		const UVDClockInfo *entry =
-			&array->entries[table->entries[i].ucUVDClockInfoIndex];
+		const UVDClockInfo *entry;
+
+		if (table->entries[i].ucUVDClockInfoIndex >= array->ucNumEntries) {
+			kfree(uvd_table);
+			return -EINVAL;
+		}
+
+		entry = &array->entries[table->entries[i].ucUVDClockInfoIndex];
 		uvd_table->entries[i].v = (unsigned long)le16_to_cpu(table->entries[i].usVoltage);
 		uvd_table->entries[i].vclk = ((unsigned long)entry->ucVClkHigh << 16)
 					 | le16_to_cpu(entry->usVClkLow);
@@ -1380,7 +1557,14 @@ static int get_vce_clock_voltage_limit_table(struct pp_hwmgr *hwmgr,
 
 	vce_table->count = table->numEntries;
 	for (i = 0; i < table->numEntries; i++) {
-		const VCEClockInfo *entry = &array->entries[table->entries[i].ucVCEClockInfoIndex];
+		const VCEClockInfo *entry;
+
+		if (table->entries[i].ucVCEClockInfoIndex >= array->ucNumEntries) {
+			kfree(vce_table);
+			return -EINVAL;
+		}
+
+		entry = &array->entries[table->entries[i].ucVCEClockInfoIndex];
 
 		vce_table->entries[i].v = (unsigned long)le16_to_cpu(table->entries[i].usVoltage);
 		vce_table->entries[i].evclk = ((unsigned long)entry->ucEVClkHigh << 16)
@@ -1474,12 +1658,20 @@ static int init_clock_voltage_dependency(struct pp_hwmgr *hwmgr,
 		const VCEClockInfoArray *array = (const VCEClockInfoArray *)
 				(((unsigned long) powerplay_table) +
 				vce_clock_info_array_offset);
-		const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *table =
-				(const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *)
-				(((unsigned long) powerplay_table) + table_offset);
-		result = get_vce_clock_voltage_limit_table(hwmgr,
-				&hwmgr->dyn_state.vce_clock_voltage_dependency_table,
-				table, array);
+		const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *table;
+
+		result = get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+				sizeof(*table), (const void **)&table);
+		if (!result)
+			result = validate_pplib_optional_table_entries(hwmgr, table_offset,
+				offsetof(ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table,
+					 entries),
+				table->numEntries,
+				sizeof(ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record));
+		if (!result)
+			result = get_vce_clock_voltage_limit_table(hwmgr,
+					&hwmgr->dyn_state.vce_clock_voltage_dependency_table,
+					table, array);
 	}
 
 	uvd_clock_info_array_offset = get_uvd_clock_info_array_offset(hwmgr, powerplay_table);
@@ -1489,40 +1681,78 @@ static int init_clock_voltage_dependency(struct pp_hwmgr *hwmgr,
 		const UVDClockInfoArray *array = (const UVDClockInfoArray *)
 				(((unsigned long) powerplay_table) +
 				uvd_clock_info_array_offset);
-		const ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table *ptable =
-				(const ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table *)
-				(((unsigned long) powerplay_table) + table_offset);
-		result = get_uvd_clock_voltage_limit_table(hwmgr,
-				&hwmgr->dyn_state.uvd_clock_voltage_dependency_table, ptable, array);
+		const ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table *ptable;
+
+		result = get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+				sizeof(*ptable), (const void **)&ptable);
+		if (!result)
+			result = validate_pplib_optional_table_entries(hwmgr, table_offset,
+				offsetof(ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table,
+					 entries),
+				ptable->numEntries,
+				sizeof(ATOM_PPLIB_UVD_Clock_Voltage_Limit_Record));
+		if (!result)
+			result = get_uvd_clock_voltage_limit_table(hwmgr,
+					&hwmgr->dyn_state.uvd_clock_voltage_dependency_table,
+					ptable, array);
 	}
 
 	table_offset = get_samu_clock_voltage_limit_table_offset(hwmgr,
 							    powerplay_table);
 
 	if (table_offset > 0) {
-		const ATOM_PPLIB_SAMClk_Voltage_Limit_Table *ptable =
-				(const ATOM_PPLIB_SAMClk_Voltage_Limit_Table *)
-				(((unsigned long) powerplay_table) + table_offset);
-		result = get_samu_clock_voltage_limit_table(hwmgr,
-				&hwmgr->dyn_state.samu_clock_voltage_dependency_table, ptable);
+		const ATOM_PPLIB_SAMClk_Voltage_Limit_Table *ptable;
+
+		result = get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+				sizeof(*ptable), (const void **)&ptable);
+		if (!result)
+			result = validate_pplib_optional_table_entries(hwmgr, table_offset,
+				offsetof(ATOM_PPLIB_SAMClk_Voltage_Limit_Table,
+					 entries),
+				ptable->numEntries,
+				sizeof(ATOM_PPLIB_SAMClk_Voltage_Limit_Record));
+		if (!result)
+			result = get_samu_clock_voltage_limit_table(hwmgr,
+					&hwmgr->dyn_state.samu_clock_voltage_dependency_table,
+					ptable);
 	}
 
 	table_offset = get_acp_clock_voltage_limit_table_offset(hwmgr,
 							     powerplay_table);
 
 	if (table_offset > 0) {
-		const ATOM_PPLIB_ACPClk_Voltage_Limit_Table *ptable =
-				(const ATOM_PPLIB_ACPClk_Voltage_Limit_Table *)
-				(((unsigned long) powerplay_table) + table_offset);
-		result = get_acp_clock_voltage_limit_table(hwmgr,
-				&hwmgr->dyn_state.acp_clock_voltage_dependency_table, ptable);
+		const ATOM_PPLIB_ACPClk_Voltage_Limit_Table *ptable;
+
+		result = get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+				sizeof(*ptable), (const void **)&ptable);
+		if (!result)
+			result = validate_pplib_optional_table_entries(hwmgr, table_offset,
+				offsetof(ATOM_PPLIB_ACPClk_Voltage_Limit_Table,
+					 entries),
+				ptable->numEntries,
+				sizeof(ATOM_PPLIB_ACPClk_Voltage_Limit_Record));
+		if (!result)
+			result = get_acp_clock_voltage_limit_table(hwmgr,
+					&hwmgr->dyn_state.acp_clock_voltage_dependency_table,
+					ptable);
 	}
 
 	table_offset = get_cacp_tdp_table_offset(hwmgr, powerplay_table);
 	if (table_offset > 0) {
-		UCHAR rev_id = *(UCHAR *)(((unsigned long)powerplay_table) + table_offset);
+		const void *tune_table;
+		UCHAR rev_id;
 
-		if (rev_id > 0) {
+		if (!pp_table_has_space(hwmgr, table_offset, sizeof(rev_id)))
+			return -EINVAL;
+
+		rev_id = *(UCHAR *)(((unsigned long)powerplay_table) + table_offset);
+		result = get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+				(rev_id > 0) ?
+				sizeof(ATOM_PPLIB_POWERTUNE_Table_V1) :
+				sizeof(ATOM_PPLIB_POWERTUNE_Table),
+				(const void **)&tune_table);
+
+		if (!result && rev_id > 0) {
 			const ATOM_PPLIB_POWERTUNE_Table_V1 *tune_table =
 				(const ATOM_PPLIB_POWERTUNE_Table_V1 *)
 				(((unsigned long) powerplay_table) + table_offset);
@@ -1531,7 +1761,7 @@ static int init_clock_voltage_dependency(struct pp_hwmgr *hwmgr,
 				le16_to_cpu(tune_table->usMaximumPowerDeliveryLimit));
 			hwmgr->dyn_state.cac_dtp_table->usDefaultTargetOperatingTemp =
 				le16_to_cpu(tune_table->usTjMax);
-		} else {
+		} else if (!result) {
 			const ATOM_PPLIB_POWERTUNE_Table *tune_table =
 				(const ATOM_PPLIB_POWERTUNE_Table *)
 				(((unsigned long) powerplay_table) + table_offset);
@@ -1546,35 +1776,44 @@ static int init_clock_voltage_dependency(struct pp_hwmgr *hwmgr,
 		const ATOM_PPLIB_POWERPLAYTABLE4 *powerplay_table4 =
 				(const ATOM_PPLIB_POWERPLAYTABLE4 *)powerplay_table;
 		if (0 != powerplay_table4->usVddcDependencyOnSCLKOffset) {
-			table = (ATOM_PPLIB_Clock_Voltage_Dependency_Table *)
-				(((unsigned long) powerplay_table4) +
-				 le16_to_cpu(powerplay_table4->usVddcDependencyOnSCLKOffset));
-			result = get_clock_voltage_dependency_table(hwmgr,
-				&hwmgr->dyn_state.vddc_dependency_on_sclk, table);
+			result = get_pplib_clock_voltage_dependency_table(hwmgr,
+				powerplay_table,
+				le16_to_cpu(powerplay_table4->usVddcDependencyOnSCLKOffset),
+				(const ATOM_PPLIB_Clock_Voltage_Dependency_Table **)&table);
+			if (!result)
+				result = get_clock_voltage_dependency_table(hwmgr,
+					&hwmgr->dyn_state.vddc_dependency_on_sclk, table);
 		}
 
 		if (result == 0 && (0 != powerplay_table4->usVddciDependencyOnMCLKOffset)) {
-			table = (ATOM_PPLIB_Clock_Voltage_Dependency_Table *)
-				(((unsigned long) powerplay_table4) +
-				 le16_to_cpu(powerplay_table4->usVddciDependencyOnMCLKOffset));
-			result = get_clock_voltage_dependency_table(hwmgr,
-				&hwmgr->dyn_state.vddci_dependency_on_mclk, table);
+			result = get_pplib_clock_voltage_dependency_table(hwmgr,
+				powerplay_table,
+				le16_to_cpu(powerplay_table4->usVddciDependencyOnMCLKOffset),
+				(const ATOM_PPLIB_Clock_Voltage_Dependency_Table **)&table);
+			if (!result)
+				result = get_clock_voltage_dependency_table(hwmgr,
+					&hwmgr->dyn_state.vddci_dependency_on_mclk, table);
 		}
 
 		if (result == 0 && (0 != powerplay_table4->usVddcDependencyOnMCLKOffset)) {
-			table = (ATOM_PPLIB_Clock_Voltage_Dependency_Table *)
-				(((unsigned long) powerplay_table4) +
-				 le16_to_cpu(powerplay_table4->usVddcDependencyOnMCLKOffset));
-			result = get_clock_voltage_dependency_table(hwmgr,
-				&hwmgr->dyn_state.vddc_dependency_on_mclk, table);
+			result = get_pplib_clock_voltage_dependency_table(hwmgr,
+				powerplay_table,
+				le16_to_cpu(powerplay_table4->usVddcDependencyOnMCLKOffset),
+				(const ATOM_PPLIB_Clock_Voltage_Dependency_Table **)&table);
+			if (!result)
+				result = get_clock_voltage_dependency_table(hwmgr,
+					&hwmgr->dyn_state.vddc_dependency_on_mclk, table);
 		}
 
 		if (result == 0 && (0 != powerplay_table4->usMaxClockVoltageOnDCOffset)) {
-			limit_table = (ATOM_PPLIB_Clock_Voltage_Limit_Table *)
-				(((unsigned long) powerplay_table4) +
-				 le16_to_cpu(powerplay_table4->usMaxClockVoltageOnDCOffset));
-			result = get_clock_voltage_limit(hwmgr,
-				&hwmgr->dyn_state.max_clock_voltage_on_dc, limit_table);
+			result = get_pplib_clock_voltage_limit_table(hwmgr,
+				powerplay_table,
+				le16_to_cpu(powerplay_table4->usMaxClockVoltageOnDCOffset),
+				(const ATOM_PPLIB_Clock_Voltage_Limit_Table **)&limit_table);
+			if (!result)
+				result = get_clock_voltage_limit(hwmgr,
+					&hwmgr->dyn_state.max_clock_voltage_on_dc,
+					limit_table);
 		}
 
 		if (result == 0 && (NULL != hwmgr->dyn_state.vddc_dependency_on_mclk) &&
@@ -1589,11 +1828,14 @@ static int init_clock_voltage_dependency(struct pp_hwmgr *hwmgr,
 				hwmgr->dyn_state.vddc_dependency_on_sclk);
 
 		if (result == 0 && (0 != powerplay_table4->usMvddDependencyOnMCLKOffset)) {
-			table = (ATOM_PPLIB_Clock_Voltage_Dependency_Table *)
-				(((unsigned long) powerplay_table4) +
-				 le16_to_cpu(powerplay_table4->usMvddDependencyOnMCLKOffset));
-			result = get_clock_voltage_dependency_table(hwmgr,
-				&hwmgr->dyn_state.mvdd_dependency_on_mclk, table);
+			result = get_pplib_clock_voltage_dependency_table(hwmgr,
+				powerplay_table,
+				le16_to_cpu(powerplay_table4->usMvddDependencyOnMCLKOffset),
+				(const ATOM_PPLIB_Clock_Voltage_Dependency_Table **)&table);
+			if (!result)
+				result = get_clock_voltage_dependency_table(hwmgr,
+					&hwmgr->dyn_state.mvdd_dependency_on_mclk,
+					table);
 		}
 	}
 
@@ -1601,10 +1843,13 @@ static int init_clock_voltage_dependency(struct pp_hwmgr *hwmgr,
 								powerplay_table);
 
 	if (table_offset > 0) {
-		table = (ATOM_PPLIB_Clock_Voltage_Dependency_Table *)
-			(((unsigned long) powerplay_table) + table_offset);
-		result = get_clock_voltage_dependency_table(hwmgr,
-			&hwmgr->dyn_state.vdd_gfx_dependency_on_sclk, table);
+		result = get_pplib_clock_voltage_dependency_table(hwmgr,
+			powerplay_table, table_offset,
+			(const ATOM_PPLIB_Clock_Voltage_Dependency_Table **)&table);
+		if (!result)
+			result = get_clock_voltage_dependency_table(hwmgr,
+				&hwmgr->dyn_state.vdd_gfx_dependency_on_sclk,
+				table);
 	}
 
 	return result;
@@ -1676,12 +1921,6 @@ static int init_dpm2_parameters(struct pp_hwmgr *hwmgr,
 	    sizeof(ATOM_PPLIB_POWERPLAYTABLE5)) {
 		const  ATOM_PPLIB_POWERPLAYTABLE5 *ptable5 =
 				(const ATOM_PPLIB_POWERPLAYTABLE5 *)powerplay_table;
-		const  ATOM_PPLIB_POWERPLAYTABLE4 *ptable4 =
-				(const ATOM_PPLIB_POWERPLAYTABLE4 *)
-				(&ptable5->basicTable4);
-		const  ATOM_PPLIB_POWERPLAYTABLE3 *ptable3 =
-				(const ATOM_PPLIB_POWERPLAYTABLE3 *)
-				(&ptable4->basicTable3);
 		const  ATOM_PPLIB_EXTENDEDHEADER  *extended_header;
 		uint16_t table_offset;
 		ATOM_PPLIB_PPM_Table *atom_ppm_table;
@@ -1711,28 +1950,34 @@ static int init_dpm2_parameters(struct pp_hwmgr *hwmgr,
 		hwmgr->dyn_state.cac_leakage_table = NULL;
 
 		if (0 != ptable5->usCACLeakageTableOffset) {
-			const ATOM_PPLIB_CAC_Leakage_Table *pCAC_leakage_table =
-				(ATOM_PPLIB_CAC_Leakage_Table *)(((unsigned long)ptable5) +
-				le16_to_cpu(ptable5->usCACLeakageTableOffset));
-			result = get_cac_leakage_table(hwmgr,
-				&hwmgr->dyn_state.cac_leakage_table, pCAC_leakage_table);
+			const ATOM_PPLIB_CAC_Leakage_Table *pCAC_leakage_table;
+
+			result = get_pplib_cac_leakage_table(hwmgr, powerplay_table,
+				le16_to_cpu(ptable5->usCACLeakageTableOffset),
+				&pCAC_leakage_table);
+			if (!result)
+				result = get_cac_leakage_table(hwmgr,
+					&hwmgr->dyn_state.cac_leakage_table,
+					pCAC_leakage_table);
 		}
 
 		hwmgr->platform_descriptor.LoadLineSlope = le16_to_cpu(ptable5->usLoadLineSlope);
 
 		hwmgr->dyn_state.ppm_parameter_table = NULL;
 
-		if (0 != ptable3->usExtendendedHeaderOffset) {
-			extended_header = (const ATOM_PPLIB_EXTENDEDHEADER *)
-					(((unsigned long)powerplay_table) +
-					le16_to_cpu(ptable3->usExtendendedHeaderOffset));
+		extended_header = get_extended_header(hwmgr, powerplay_table,
+						      SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V5);
+		if (extended_header) {
 			if ((extended_header->usPPMTableOffset > 0) &&
 				le16_to_cpu(extended_header->usSize) >=
 				    SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V5) {
 				table_offset = le16_to_cpu(extended_header->usPPMTableOffset);
-				atom_ppm_table = (ATOM_PPLIB_PPM_Table *)
-					(((unsigned long)powerplay_table) + table_offset);
-				if (0 == get_platform_power_management_table(hwmgr, atom_ppm_table))
+				result = get_pplib_subtable(hwmgr, powerplay_table,
+					table_offset, sizeof(*atom_ppm_table),
+					(const void **)&atom_ppm_table);
+				if (!result &&
+				    !get_platform_power_management_table(hwmgr,
+									 atom_ppm_table))
 					phm_cap_set(hwmgr->platform_descriptor.platformCaps,
 						PHM_PlatformCaps_EnablePlatformPowerManagement);
 			}
@@ -1750,13 +1995,17 @@ static int init_phase_shedding_table(struct pp_hwmgr *hwmgr,
 				(const ATOM_PPLIB_POWERPLAYTABLE4 *)powerplay_table;
 
 		if (0 != powerplay_table4->usVddcPhaseShedLimitsTableOffset) {
-			const ATOM_PPLIB_PhaseSheddingLimits_Table *ptable =
-				(ATOM_PPLIB_PhaseSheddingLimits_Table *)
-				(((unsigned long)powerplay_table4) +
-				le16_to_cpu(powerplay_table4->usVddcPhaseShedLimitsTableOffset));
+			const ATOM_PPLIB_PhaseSheddingLimits_Table *ptable;
 			struct phm_phase_shedding_limits_table *table;
 			unsigned long i;
+			int result;
 
+			result = get_pplib_phase_shedding_table(hwmgr,
+				powerplay_table,
+				le16_to_cpu(powerplay_table4->usVddcPhaseShedLimitsTableOffset),
+				&ptable);
+			if (result)
+				return result;
 
 			table = kzalloc(struct_size(table, entries, ptable->ucNumEntries),
 					GFP_KERNEL);
-- 
2.47.3

