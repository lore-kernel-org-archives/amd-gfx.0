Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754C6CDB466
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 03:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1171910E916;
	Tue, 23 Jun 2026 03:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fKwSIoTN";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3619110E916
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 03:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUrsaIRLL/MI2fZSM86f9ccGbG07BwTC5xcAkMgpECQnwKzEGJVyP4y5bSzTxvVAjOb1yroZ6jomZ41gppZI9+wP6g/+ID70Gjew40pHGu3+noxoP5S5Mo2zFid3dk5AnSxyFm2lSUpK+kOum/aiylx88go9Kpn7aGjHD5uFEyJ9rmkIY8mguRkB4zCKLGmBEBDo64MzsrW3gUG/7SVe7eWFgM4Ac/7IGE+cLl50xoBkWjs8dMmUlc/k2hajaOm36XAb96JRIKytJM0zc6OFDpKNQrW1u/r58p/MMdcqeiv/Ni8DVEzwn/EJ69r+4Jn0SGZ3vrsHjVtjuN97vFU7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGBPidizohoQpdbeA0i+gWG+KqTJ4QC3F+/t3GiDPc4=;
 b=dTA8Tyjg+CUxzUF6Fxj9UHqa87l/gBrtmIBlmm3mP8se4ZlQBC1n+reuG3hmNWDzAtjtCkex0+2LAra5pasQHA0cklP3HToSS0vl+vOer9LnKo4oywC0bAcLlBvJWgvtoNHVT5ZHF1vSXuCVB0yb724FAp/RW1oW5XmDXD9U69BYMoK4Ab/01EpQ3fqyvacPPyQleRKMTUCip1TroXtCF0d4iCNcTwRSGcMIKOJfqSs4T1dp04/71gdLwFR/65wDufWGaxw6b7QUtKliGvWfjzepO9IiIkVlWfcLLhTTaIJDEbnq63a7TV6hwOTH+UCLj1DVbLGPmanBK8G83pJ9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGBPidizohoQpdbeA0i+gWG+KqTJ4QC3F+/t3GiDPc4=;
 b=fKwSIoTNt678GJyg0/HYiBAbVnNB9LnOosdDwn61AqyJswM6e+yBvG2lXpDnDRbZYHEiL0+z86eCenlFE48sZxR4fAe5BKNVPnCRyhPzAZnvS46QPj8bBqMbq+UhyKrxJ7PIGWjcWlj07AUK/aA3M8Ln+aMBul+uZh2pupvvNQQ=
Received: from CY8PR12CA0022.namprd12.prod.outlook.com (2603:10b6:930:4e::17)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 03:42:13 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:4e:cafe::26) by CY8PR12CA0022.outlook.office365.com
 (2603:10b6:930:4e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 03:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 23 Jun 2026 03:42:12 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 22:42:08 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 4/5] drm/amd/pm: Validate Vega hwmgr PowerPlay table bounds
Date: Tue, 23 Jun 2026 11:41:50 +0800
Message-ID: <20260623034151.263746-4-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 2436381c-99a4-4526-f614-08ded0d96936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: vf+bRxJBiRIakB24B4kV22ywuao05hsUrrpJkiDbjLrvLtqbv7b2ccJlrha5WmehvH614SCmUOp8Ys+ijuLExEpkh2p6jw//XpnhUu2l7XrgUZso61yZ3p/jLHnLr7Ex5oR9o01hEL1lauWgHH7SWBX7lgjoD4wLMQ0gqA5+IZ41ppkGZoojJ8fYrm+A7OD2Db/mWVUcYCdTicyjbK5VgREazWDa3FPlt8vKh/i+gqyuzzot9Fw+NDtugtANExwZXpIsoYTDKfACcrOj0aowjxf1jKdrBqcxzl/5oAj4Aioxvu+oTA1GM/src3cxL+eFQiHVKUpe6KGz8xrrLAzP02EGXsJ0g6GWNSbIxCAIZrh4vwjJKCkE1TP9iVUZxIp7NRsO1pPbQ3n9v7UIFWBWZrl7UNtCTEwVH0qmXunar1/ixIw+D8mO9fznbrluMf3pY1DOwNvfEuF3rMpqyKoFwQaz89wKACdDy4lpFCrbRI9JY93N24FW4ZkrlywBFdeB5NBVUNO9psvcSPNcRzvtp1dfRz0+4bjGN9yGOIjc5IofwzBrie2cEfvgxy+/qm4lZMaMT2wfyZ8yuaj7LgL5WO4UJ/ymEgXU251D8h7wHMkzzvO7SB4XqD5ThmQCggtKLv85lDl+3OodZA01lQTcMgrq3ebFCnQJ8fJTfX45brMWSM6vNDxXdxfzd+jTqIQTeMLm4uGraHebE4aaqEzBgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lRN/eO41eWo0G+nNUpIAygUKd6MzCYmUBGyVb3fnnen37Kv5J4NsK4zgofd169+U5XcetR8S9IlPxMNVyCf75YnVgngLVbVsDFFVnE2fVGyPunklXJQy8sO5YB0SksrLNcl3snrAqSgVbJ2rpxlb/bRm3wNyJmyAWAKvagEicEI/Ju9Oy1xw17MOE3HiY4szgF+tRCMvZmpKZPvzXzQ/Bww6uHNlJ4G/yt2U7GAskAw70oKIljuUqiQQSmlKQIxNXu/pSvV6bBqgEpQwLxZYAwxjUAJct2kjn/OyfYsamvNV2c2vJQ8xsCpRX+twocr3r4tkLPtmuDXmfJQEKwUWCd0TBDhLGADrTFyG9QD3rlyt2DqMXXATVPb/hBNwDumgXHohOUeH4gjNCyn/+ExrWYW0kaA3mfGMuGQrdWGwhUapo8jS/aSyeFEY8nVP8Yns
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:42:12.4324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2436381c-99a4-4526-f614-08ded0d96936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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

The Vega hwmgr PowerPlay table parsers read fixed table fields,
state array entries, or SMC PPT fields before validating that the
VBIOS table buffer covers those structures. A truncated table can
therefore lead to out-of-bounds reads during hwmgr initialization.

Reject tables smaller than the fixed PowerPlay table. For Vega10, also
validate the state array offset and entry range before dereferencing
the state array.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../powerplay/hwmgr/vega10_processpptables.c  | 59 ++++++++++++-------
 .../powerplay/hwmgr/vega12_processpptables.c  |  7 +++
 .../powerplay/hwmgr/vega20_processpptables.c  |  7 +++
 3 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index 3be616af327e..64cff9f4850a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -63,14 +63,17 @@ static const void *get_powerplay_table(struct pp_hwmgr *hwmgr)
 	return table_address;
 }
 
-static int check_powerplay_tables(
-		struct pp_hwmgr *hwmgr,
-		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table)
+static int get_vega10_state_array(struct pp_hwmgr *hwmgr,
+	const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+	const ATOM_Vega10_State_Array **state_array)
 {
 	const ATOM_Vega10_State_Array *state_arrays;
+	u16 state_array_offset;
+	size_t state_array_size;
+	size_t table_size = hwmgr->soft_pp_table_size;
 
-	state_arrays = (ATOM_Vega10_State_Array *)(((unsigned long)powerplay_table) +
-		le16_to_cpu(powerplay_table->usStateArrayOffset));
+	PP_ASSERT_WITH_CODE((table_size >= sizeof(*powerplay_table)),
+			    "Invalid PowerPlay Table!", return -1);
 
 	PP_ASSERT_WITH_CODE((powerplay_table->sHeader.format_revision >=
 			ATOM_Vega10_TABLE_REVISION_VEGA10),
@@ -79,12 +82,34 @@ static int check_powerplay_tables(
 		"State table is not set!", return -1);
 	PP_ASSERT_WITH_CODE(powerplay_table->sHeader.structuresize > 0,
 		"Invalid PowerPlay Table!", return -1);
+
+	state_array_offset = le16_to_cpu(powerplay_table->usStateArrayOffset);
+	PP_ASSERT_WITH_CODE((state_array_offset <=
+			     table_size - sizeof(*state_arrays)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	state_arrays = (ATOM_Vega10_State_Array *)(((unsigned long)powerplay_table) +
+		state_array_offset);
 	PP_ASSERT_WITH_CODE(state_arrays->ucNumEntries > 0,
 		"Invalid PowerPlay Table!", return -1);
 
+	state_array_size = struct_size(state_arrays, states, state_arrays->ucNumEntries);
+	PP_ASSERT_WITH_CODE((state_array_size <= table_size - state_array_offset),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*state_array = state_arrays;
+
 	return 0;
 }
 
+static int check_powerplay_tables(struct pp_hwmgr *hwmgr,
+	const ATOM_Vega10_POWERPLAYTABLE *powerplay_table)
+{
+	const ATOM_Vega10_State_Array *state_arrays;
+
+	return get_vega10_state_array(hwmgr, powerplay_table, &state_arrays);
+}
+
 static int set_platform_caps(struct pp_hwmgr *hwmgr, uint32_t powerplay_caps)
 {
 	set_hw_cap(
@@ -1249,15 +1274,14 @@ int vega10_get_number_of_powerplay_table_entries(struct pp_hwmgr *hwmgr)
 {
 	const ATOM_Vega10_State_Array *state_arrays;
 	const ATOM_Vega10_POWERPLAYTABLE *pp_table = get_powerplay_table(hwmgr);
+	int result;
 
 	PP_ASSERT_WITH_CODE((pp_table != NULL),
 			"Missing PowerPlay Table!", return -1);
-	PP_ASSERT_WITH_CODE((pp_table->sHeader.format_revision >=
-			ATOM_Vega10_TABLE_REVISION_VEGA10),
-			"Incorrect PowerPlay table revision!", return -1);
 
-	state_arrays = (ATOM_Vega10_State_Array *)(((unsigned long)pp_table) +
-			le16_to_cpu(pp_table->usStateArrayOffset));
+	result = get_vega10_state_array(hwmgr, pp_table, &state_arrays);
+	PP_ASSERT_WITH_CODE((result == 0),
+			    "Invalid PowerPlay Table State Array.", return result);
 
 	return (uint32_t)(state_arrays->ucNumEntries);
 }
@@ -1308,17 +1332,11 @@ int vega10_get_powerplay_table_entry(struct pp_hwmgr *hwmgr,
 
 	if (pp_table->sHeader.format_revision >=
 			ATOM_Vega10_TABLE_REVISION_VEGA10) {
-		state_arrays = (ATOM_Vega10_State_Array *)
-				(((unsigned long)pp_table) +
-				le16_to_cpu(pp_table->usStateArrayOffset));
-
-		PP_ASSERT_WITH_CODE(pp_table->usStateArrayOffset > 0,
-				"Invalid PowerPlay Table State Array Offset.",
-				return -1);
-		PP_ASSERT_WITH_CODE(state_arrays->ucNumEntries > 0,
+		result = get_vega10_state_array(hwmgr, pp_table, &state_arrays);
+		PP_ASSERT_WITH_CODE((result == 0),
 				"Invalid PowerPlay Table State Array.",
-				return -1);
-		PP_ASSERT_WITH_CODE((entry_index <= state_arrays->ucNumEntries),
+				return result);
+		PP_ASSERT_WITH_CODE((entry_index < state_arrays->ucNumEntries),
 				"Invalid PowerPlay Table State Array Entry.",
 				return -1);
 
@@ -1360,4 +1378,3 @@ int vega10_baco_set_cap(struct pp_hwmgr *hwmgr)
 			PHM_PlatformCaps_BACO);
 	return result;
 }
-
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
index 89148f73b514..8e6b1565d00d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
@@ -64,6 +64,13 @@ static int check_powerplay_tables(
 		struct pp_hwmgr *hwmgr,
 		const ATOM_Vega12_POWERPLAYTABLE *powerplay_table)
 {
+	size_t smc_pptable_size =
+		offsetofend(ATOM_Vega12_POWERPLAYTABLE, smcPPTable);
+	size_t table_size = hwmgr->soft_pp_table_size;
+
+	PP_ASSERT_WITH_CODE((table_size >= smc_pptable_size),
+			    "Invalid PowerPlay Table!", return -1);
+
 	PP_ASSERT_WITH_CODE((powerplay_table->sHeader.format_revision >=
 		ATOM_VEGA12_TABLE_REVISION_VEGA12),
 		"Unsupported PPTable format!", return -1);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
index 2b446f8866ba..0d008573c038 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
@@ -66,6 +66,13 @@ static int check_powerplay_tables(
 		struct pp_hwmgr *hwmgr,
 		const ATOM_Vega20_POWERPLAYTABLE *powerplay_table)
 {
+	size_t smc_pptable_size =
+		offsetofend(ATOM_Vega20_POWERPLAYTABLE, smcPPTable);
+	size_t table_size = hwmgr->soft_pp_table_size;
+
+	PP_ASSERT_WITH_CODE((table_size >= smc_pptable_size),
+			    "Invalid PowerPlay Table!", return -1);
+
 	PP_ASSERT_WITH_CODE((powerplay_table->sHeader.format_revision >=
 		ATOM_VEGA20_TABLE_REVISION_VEGA20),
 		"Unsupported PPTable format!", return -1);
-- 
2.47.3

