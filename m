Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C632CDB475
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 03:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B7610E91B;
	Tue, 23 Jun 2026 03:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q04KyOCX";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62EA410E91B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 03:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSnApFAJvVidB3SMUkyx7JlaJWibj66xZfJCZUpNX+DKzYnCEwSxT8Jfc0H9d3GSy5yje95UVGWiIWCj4r0cX45MDuJ6tJ87BwiylipK7+43ze9QmEgLTCb969sd5JrTP7ViNYh341OjEtfrdiZro0VrUpzyvvLQjt6791HqBDgAj1L6K107yXXimg4/e8F29jiZtEdgB1FzAZBd8ObzvWstBxRV6zYSMnGyyzNi5JwZRN0NySnu2f9vtDUoZEJOfJB55a82jsWh01p7H+Hj2BMo1xhnkHHCPzONRQS43Aksorj6DfMDV7C4/1EA8fY1RRKuM29g32YDirLUMiZdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D22Ns8BP2kACf/qI/yL6Ne+Rfs6SsYzoEBOW0GaMLA=;
 b=R3V0qkZ9atrVUBGyKh01WjU023br1Fid9hkejGnAi/YzAOT0UH4drD3QuIRAowyYfReu1BFiKvwJ00euCyN0EuOFEUZKP9EJZSoq+ewGztDKX2EFPcTVEe8RgxB9xvg7BBSi3Y+R8sTVjQYXlOOjSkCqu780zfS78t3AJQBXoAmw7gVDHe/jVbf04rSouycLOVgGtgyJIsqLgssMMbmUtzOYIHtk5VltPLVniUSy4YgSV+CfGHNjplktO93oa9La9KQs3+sOL9SGzxNeNGuBjhtCdonDj1YO3KLcUxQ6T/jaMUkbYtB9cSezMV6WFZIok/6ws4BTabt6wdE8qrqpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D22Ns8BP2kACf/qI/yL6Ne+Rfs6SsYzoEBOW0GaMLA=;
 b=Q04KyOCXv0Z6JtIZesMiuzu2GvtAmFjdtnlin36lFteWS3YKTzd0sZ+vP34i6IoC9Dd+587jSLSDfCsFoHyJdxmrZYziCBjjDkiqXLD5H3OfVPXclU307qCm9rvzPuSjagRcIEwxs3nSJKWUzhNAXUm89ZXWA0Y/9rLwRHIoHDY=
Received: from CH0PR04CA0064.namprd04.prod.outlook.com (2603:10b6:610:74::9)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Tue, 23 Jun 2026 03:42:11 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::67) by CH0PR04CA0064.outlook.office365.com
 (2603:10b6:610:74::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Tue,
 23 Jun 2026 03:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 03:42:10 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 22:42:07 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 3/5] drm/amd/pm: Validate Tonga PowerPlay state array bounds
Date: Tue, 23 Jun 2026 11:41:49 +0800
Message-ID: <20260623034151.263746-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623034151.263746-1-kevinyang.wang@amd.com>
References: <20260623034151.263746-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4b1a67-362c-46e0-7c5f-08ded0d96840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: UcC/fWig6aoxZCFeuZ51bh6PHxLmNNLXCYomTyuDra7WoPKmCozzAdg/RAKuWB/uTmQrOM3XXT4Kmebl/jixWjS8Bup34Kto6COJzqo8J7A1GUqKFcVuX9b/BFuq2TlQFeLVNXZhymFCTqBm/Uqvpd41Uod7oMig8uzyMRs1gptmsFgzQci1fotYtdjPk8y86ArOnESJL52DARqUkRHf12SB+2FZCOWsQBjiShBCD4iMyXa39HCnuZcRSF7YmX2Kzsx6mevjqKLd/2GBdeOYwIJZusBKQYYY1pywtbUKXGocGH4pSAvXBOfqwZBq5VgECoHy8Q2lQtaoWabnOuN7GjrDm+xPmOlXx3OiuIdAaiw/3gVEpmHFAa6go35dFKYfggwfVI+WTItvsqxSS8GZmgG++xo2CNxA99BgKEKumHI0CvQJvo5IQgbAcOUjQeZeIQErFTDRAfst1V9fj8/a5m6lTi6mYOOazLbxeEl3Ff9VGX3lGs6jLc0RGE3/Nb9aJtmhvdWZsi55aglmU8wzP6oo8E0VXd14ps+xBNoBl0A1MXfyEDI2ywXe/XBrNtDdSS3+XVHwVhJ5dQeHDI0LpNDd9BhIRcN7gHagILXHl9gXb8azWBFjxF7VAieUzyh6MJpnuLEb+Tv8Kprhaqw4nP/ReN1zCTfMYBoOWA2Ilos7lPekvgK8rnViracyPLy3cer7OGtFjU+RRdnBYi7X0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X72jfi/h4198+coi4FjaGJgjocCEV9MmsCi+6klkQo/Z8hiebOHmsykjruJXsmSrouOK9oteUarWS4r07ZNEDUJFm4nbOSOnPGymm9RygNoRrFSrdgdEgSb/x0qZCCCbyHXBw4F0W8NmgWhw3IfZ1AVNDQXesW9OjZUHA/c8pGejBvWxtX5mMCsKRKH3B6ex2jkunGjiJyF4XGaW1hnjseEfT4V1H2WDORBECyBEsbpJHjGqEgHr0vU6RPzMA2UM8BSFGwv0zyKX4K+sHPYuKNRrLQZW3LS6e+KpR4PyQhO/QUFIYMP3UrqW7V4IB4WbWOeSpo81ueT3sxIbdzjMvXXdu8WPdZ4hfIe1JhkUh2gCtRKvn++sfHMqzpNs6Bu+azrG9xqOacGGeMPLExGWAGYHSAA9gn6SLtiVYilGo4Tid1Te1+VOHFjBS0EZcbfE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:42:10.8481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4b1a67-362c-46e0-7c5f-08ded0d96840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
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

process_pptables_v1_0.c builds the Tonga state array pointer
from usStateArrayOffset before checking that the table buffer covers
the referenced data. A truncated PowerPlay table can therefore lead to
out-of-bounds reads while validating the state array.

Validate the fixed table size first, then check the state array offset
and entry range before dereferencing the state array.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 62 ++++++++++++-------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 6cfef1b295ab..94c1e2c10370 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -1113,15 +1113,17 @@ static int init_thermal_controller(
  * @powerplay_table: Pointer to the PowerPlay Table.
  * Exception:  2 if the powerplay table is incorrect.
  */
-static int check_powerplay_tables(
-		struct pp_hwmgr *hwmgr,
-		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table
-		)
+static int get_tonga_state_array(struct pp_hwmgr *hwmgr,
+	const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+	const ATOM_Tonga_State_Array **state_array)
 {
 	const ATOM_Tonga_State_Array *state_arrays;
+	u16 state_array_offset;
+	size_t state_array_size;
+	size_t table_size = hwmgr->soft_pp_table_size;
 
-	state_arrays = (ATOM_Tonga_State_Array *)(((unsigned long)powerplay_table) +
-		le16_to_cpu(powerplay_table->usStateArrayOffset));
+	PP_ASSERT_WITH_CODE((table_size >= sizeof(*powerplay_table)),
+			    "Invalid PowerPlay Table!", return -1);
 
 	PP_ASSERT_WITH_CODE((ATOM_Tonga_TABLE_REVISION_TONGA <=
 		powerplay_table->sHeader.ucTableFormatRevision),
@@ -1130,12 +1132,34 @@ static int check_powerplay_tables(
 		"State table is not set!", return -1);
 	PP_ASSERT_WITH_CODE((0 < powerplay_table->sHeader.usStructureSize),
 		"Invalid PowerPlay Table!", return -1);
+
+	state_array_offset = le16_to_cpu(powerplay_table->usStateArrayOffset);
+	PP_ASSERT_WITH_CODE((state_array_offset <=
+			     table_size - sizeof(*state_arrays)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	state_arrays = (ATOM_Tonga_State_Array *)(((unsigned long)powerplay_table) +
+		state_array_offset);
 	PP_ASSERT_WITH_CODE((0 < state_arrays->ucNumEntries),
 		"Invalid PowerPlay Table!", return -1);
 
+	state_array_size = struct_size(state_arrays, entries, state_arrays->ucNumEntries);
+	PP_ASSERT_WITH_CODE((state_array_size <= table_size - state_array_offset),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*state_array = state_arrays;
+
 	return 0;
 }
 
+static int check_powerplay_tables(struct pp_hwmgr *hwmgr,
+	const ATOM_Tonga_POWERPLAYTABLE *powerplay_table)
+{
+	const ATOM_Tonga_State_Array *state_arrays;
+
+	return get_tonga_state_array(hwmgr, powerplay_table, &state_arrays);
+}
+
 static int pp_tables_v1_0_initialize(struct pp_hwmgr *hwmgr)
 {
 	int result = 0;
@@ -1239,17 +1263,16 @@ const struct pp_table_func pptable_v1_0_funcs = {
 
 int get_number_of_powerplay_table_entries_v1_0(struct pp_hwmgr *hwmgr)
 {
-	ATOM_Tonga_State_Array const *state_arrays;
+	const ATOM_Tonga_State_Array *state_arrays;
 	const ATOM_Tonga_POWERPLAYTABLE *pp_table = get_powerplay_table(hwmgr);
+	int result;
 
 	PP_ASSERT_WITH_CODE((NULL != pp_table),
 			"Missing PowerPlay Table!", return -1);
-	PP_ASSERT_WITH_CODE((pp_table->sHeader.ucTableFormatRevision >=
-			ATOM_Tonga_TABLE_REVISION_TONGA),
-			"Incorrect PowerPlay table revision!", return -1);
 
-	state_arrays = (ATOM_Tonga_State_Array *)(((unsigned long)pp_table) +
-			le16_to_cpu(pp_table->usStateArrayOffset));
+	result = get_tonga_state_array(hwmgr, pp_table, &state_arrays);
+	PP_ASSERT_WITH_CODE((result == 0),
+			    "Invalid PowerPlay Table State Array.", return result);
 
 	return (uint32_t)(state_arrays->ucNumEntries);
 }
@@ -1380,15 +1403,11 @@ int get_powerplay_table_entry_v1_0(struct pp_hwmgr *hwmgr,
 
 	if (pp_table->sHeader.ucTableFormatRevision >=
 			ATOM_Tonga_TABLE_REVISION_TONGA) {
-		state_arrays = (ATOM_Tonga_State_Array *)(((unsigned long)pp_table) +
-				le16_to_cpu(pp_table->usStateArrayOffset));
-
-		PP_ASSERT_WITH_CODE((0 < pp_table->usStateArrayOffset),
-				"Invalid PowerPlay Table State Array Offset.", return -1);
-		PP_ASSERT_WITH_CODE((0 < state_arrays->ucNumEntries),
-				"Invalid PowerPlay Table State Array.", return -1);
-		PP_ASSERT_WITH_CODE((entry_index <= state_arrays->ucNumEntries),
-				"Invalid PowerPlay Table State Array Entry.", return -1);
+		result = get_tonga_state_array(hwmgr, pp_table, &state_arrays);
+		PP_ASSERT_WITH_CODE((result == 0),
+				    "Invalid PowerPlay Table State Array.", return result);
+		PP_ASSERT_WITH_CODE((entry_index < state_arrays->ucNumEntries),
+				    "Invalid PowerPlay Table State Array Entry.", return -1);
 
 		state_entry = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
 						ATOM_Tonga_State, entries,
@@ -1414,4 +1433,3 @@ int get_powerplay_table_entry_v1_0(struct pp_hwmgr *hwmgr,
 
 	return result;
 }
-
-- 
2.47.3

