Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6038CCDE000
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 06:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA6010ED95;
	Wed, 24 Jun 2026 06:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XaaMi2Xg";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9594210ED95
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 06:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGspq/uQkVQFH3Oj9TjqIepnoG5jtgEIqMxhvlSKHXCbwMeOe/9L6lLExB0j4YdAnSTcEaTBA2JXp+56Frc36yImr0TADLBhN7wcq4HhpGaLqtu+SRAEuVLcSxlfEBlIeP8+3MyXOXUl5hOCY90IS1oYaVZBS9zcaBBddWO1zb4yXWSei6X3BolndY2hbofdLN7njJDV9iT6MBNponmBzGA9CMuk0fOHvn26Cwwmda2b05TNmHyCmmhDB0c2wdBxaLbbUk0jJ4XjkygCly8mXC4QmQjX+pzCke4qXueCgn8F9uGnIp5GQVTWbuoyAdyf2vI9Sum3686d3ECjfYEP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hOBhkKNeB2VIcYRO6hyejVLZ9InDYdMWhiTCS+c19Y=;
 b=hVIKpFCql47Ii7BEBBiIsP7hiR7LcMv5OriZyc1RZFwd/56gU4rhdLLrxCoQhucv4tfdL7DCFLO2DBEvWsk6+HLdxzimHkg9qsjVa9dNR009z6aGc5crmnWAymnLGHHkVdqk1YNJTTpOx7K3FkxbYBx5B0O3gBv6B5FRFGvp2k7RphPJQSQ6WTWHEOVWfB+lPvz1JbY/30NwFbhnoszPGs/9USSnDaTauIEMlLGgvvkr/GczVfPIQ06d9+Ah9F3LojCSS1uRn0bEAFNzsDlgmPPCV2WBB6drVowudQgozjb2DMunJFB/8p8PChKaYXWdLMJ66G6WZGCj3Oa4WPBjiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hOBhkKNeB2VIcYRO6hyejVLZ9InDYdMWhiTCS+c19Y=;
 b=XaaMi2XghtKtOq5vEF0ZQ8cSaTxDYABMBbj2Z4zhJlIXtk13+uiSgZ5fCCprEvrfH1ReUKs9bpGweXhMYHB2Xh2jSJewL7SEick2UirUe7M050hQWNH9IOeVxW9uZKPeaeOL1qTnnWvXxMXAR0abhzy/qMRjWxMEIX4tpOWCwgU=
Received: from SJ0PR05CA0121.namprd05.prod.outlook.com (2603:10b6:a03:33d::6)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 06:44:44 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::1b) by SJ0PR05CA0121.outlook.office365.com
 (2603:10b6:a03:33d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.5 via Frontend Transport; Wed, 24
 Jun 2026 06:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 06:44:44 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 01:44:40 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/pm/powerplay: clamp Vega10 PP sub-table
 ucNumEntries
Date: Wed, 24 Jun 2026 14:44:12 +0800
Message-ID: <20260624064414.144468-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260624064414.144468-1-asad.kamal@amd.com>
References: <20260624064414.144468-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|PH7PR12MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d01ffe-4088-4323-4db3-08ded1bc135d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xrHTihkAMfRJRkZcFwQZTM7Q4Mq4eBEMfpJPdibeJUKTG+y1035Mn3X8bnQeyPpnFHetcJL3gzJb/tFQYIzFIciVCBkhDRuqLZeZ+HdDcufTcNhX9lB2oQpvv3b63VoyYBqppuan5bsQMRkU6C5JaOxgTCCFWR1JSRZ0Ng+IoTe4/dDyeIBxI7kybljyKioVXNgHhtPsNfUKNbW/fWI+LNyOiifKA0PV5hNY88i3KPdpZ3Ju2xImzmYBnkVoKD9ulmJjTmOzlGDh2xNV06N9dhK1z6lhenpaxBNXaDRA1prF1J7dGzVXPzPNnATNxB3pnR1qOd6Do3C4UxEkUjHN1DjFdtRd/bUlN5uqzvhT35B0CQXVGCIHFx0wZQ+DI91TZ3oJtTvOSmAfedrOQ0wii4ESD73SmDx2I4mn7dL55zYnAx4IqGl7UAXy+wryvREVoyoANOp4lp4/SoJNmgy3nXQCrjO/G07uI7ZDeRhQ3UDO1PlY4JzrPb8PK3A9zyoc5aCBc8+i+Nj4SnBa2VeUqpoW8h/8WCYrcTa/tMqr9mfINEMssMoV7SHj7spfnng/fRbbCvs+RggxfHS9oSbG7JyToWcC9ELbW6q88Ae2FQ1k1Ki1MLD3kULTJUYL+ZCBU3tnjYFQ1tReA3aXuS52TZMMVC6akq5wY4r46BFENlglFeCMkZNC0ur4fRqep/R7BQU4/jeroRVQ6XCaFRQjbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p3ctJ0i3h7O3cB2stNcbxcZWQIq6GymBt6ECOCEbEg/AsYfm+IEMm+SQOv0tNEPPgqCUm4hCtPcKqApYJCUOtticPtFBtXFSYRdMaAc96nygEx5OOINo3fxKRONo03Hy54YzSNPcCk4tcCcemGlNpTyZDGcQdFjvcBxAUXdPmc8xwxqyoXGNZHlUZCmVk0Q0ntV6m8CzidUMMB7aBwLkCvgPQrqsPyE2VPdllimu37r/fH2m7EeVq/udzP/E/J0/TFerL8RfvGlNssejFI42rk5xKGDEdmvoEqnWLZTSkRV9npX3LkgZDW9Fipo6w/ZJgNDYPkb8DwmFhmSERIFF/rX0e7ZwSuIOF415fwdD1aCt9e4RlZKBfoXBTZH0opqaVpx5aRL8zCYXaNey5eFLSYr/IIf4Kqitk1x5umSMv2Abq9Pe9mfVzLVNuPxnTrYd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 06:44:44.1035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d01ffe-4088-4323-4db3-08ded1bc135d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178
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

Same write-OOB and read-OOB as the Tonga fix, across seven Vega10 sub-table
parsers: get_vddc_lookup_table(), get_mm_clock_voltage_table(),
get_socclk/mclk/gfxclk/pixclk/dcefclk_voltage_dependency_table().
The GFXCLK table selects the correct record size per revision.

Fixes: f83a9991648b ("drm/amd/powerplay: add Vega10 powerplay support (v5)")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../powerplay/hwmgr/vega10_processpptables.c  | 133 ++++++++++++++----
 1 file changed, 102 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index 3be616af327e..34646a562f3b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -344,20 +344,29 @@ static int get_mm_clock_voltage_table(
 		const ATOM_Vega10_MM_Dependency_Table *mm_dependency_table)
 {
 	uint32_t i;
+	uint32_t num_entries;
 	const ATOM_Vega10_MM_Dependency_Record *mm_dependency_record;
 	phm_ppt_v1_mm_clock_voltage_dependency_table *mm_table;
 
 	PP_ASSERT_WITH_CODE((mm_dependency_table->ucNumEntries != 0),
 			"Invalid PowerPlay Table!", return -1);
 
-	mm_table = kzalloc(struct_size(mm_table, entries, mm_dependency_table->ucNumEntries),
+	num_entries = min_t(uint32_t, mm_dependency_table->ucNumEntries,
+			    pp_entries_max(hwmgr, mm_dependency_table,
+					   sizeof(*mm_dependency_table),
+					   sizeof(ATOM_Vega10_MM_Dependency_Record)));
+	if (num_entries < mm_dependency_table->ucNumEntries)
+		pr_warn("amdgpu: Vega10 MM dependency table: clamping ucNumEntries %u -> %u\n",
+			mm_dependency_table->ucNumEntries, num_entries);
+
+	mm_table = kzalloc(struct_size(mm_table, entries, num_entries),
 			   GFP_KERNEL);
 	if (!mm_table)
 		return -ENOMEM;
 
-	mm_table->count = mm_dependency_table->ucNumEntries;
+	mm_table->count = num_entries;
 
-	for (i = 0; i < mm_dependency_table->ucNumEntries; i++) {
+	for (i = 0; i < num_entries; i++) {
 		mm_dependency_record = &mm_dependency_table->entries[i];
 		mm_table->entries[i].vddcInd = mm_dependency_record->ucVddcInd;
 		mm_table->entries[i].samclock =
@@ -568,19 +577,28 @@ static int get_socclk_voltage_dependency_table(
 		const ATOM_Vega10_SOCCLK_Dependency_Table *clk_dep_table)
 {
 	uint32_t i;
+	uint32_t num_entries;
 	phm_ppt_v1_clock_voltage_dependency_table *clk_table;
 
 	PP_ASSERT_WITH_CODE(clk_dep_table->ucNumEntries,
 		"Invalid PowerPlay Table!", return -1);
 
-	clk_table = kzalloc(struct_size(clk_table, entries, clk_dep_table->ucNumEntries),
+	num_entries = min_t(uint32_t, clk_dep_table->ucNumEntries,
+			    pp_entries_max(hwmgr, clk_dep_table,
+					   sizeof(*clk_dep_table),
+					   sizeof(ATOM_Vega10_CLK_Dependency_Record)));
+	if (num_entries < clk_dep_table->ucNumEntries)
+		pr_warn("amdgpu: Vega10 SOCCLK dependency table: clamping ucNumEntries %u -> %u\n",
+			clk_dep_table->ucNumEntries, num_entries);
+
+	clk_table = kzalloc(struct_size(clk_table, entries, num_entries),
 			    GFP_KERNEL);
 	if (!clk_table)
 		return -ENOMEM;
 
-	clk_table->count = (uint32_t)clk_dep_table->ucNumEntries;
+	clk_table->count = num_entries;
 
-	for (i = 0; i < clk_dep_table->ucNumEntries; i++) {
+	for (i = 0; i < num_entries; i++) {
 		clk_table->entries[i].vddInd =
 				clk_dep_table->entries[i].ucVddInd;
 		clk_table->entries[i].clk =
@@ -598,19 +616,28 @@ static int get_mclk_voltage_dependency_table(
 		const ATOM_Vega10_MCLK_Dependency_Table *mclk_dep_table)
 {
 	uint32_t i;
+	uint32_t num_entries;
 	phm_ppt_v1_clock_voltage_dependency_table *mclk_table;
 
 	PP_ASSERT_WITH_CODE(mclk_dep_table->ucNumEntries,
 		"Invalid PowerPlay Table!", return -1);
 
-	mclk_table = kzalloc(struct_size(mclk_table, entries, mclk_dep_table->ucNumEntries),
+	num_entries = min_t(uint32_t, mclk_dep_table->ucNumEntries,
+			    pp_entries_max(hwmgr, mclk_dep_table,
+					   sizeof(*mclk_dep_table),
+					   sizeof(ATOM_Vega10_MCLK_Dependency_Record)));
+	if (num_entries < mclk_dep_table->ucNumEntries)
+		pr_warn("amdgpu: Vega10 MCLK dependency table: clamping ucNumEntries %u -> %u\n",
+			mclk_dep_table->ucNumEntries, num_entries);
+
+	mclk_table = kzalloc(struct_size(mclk_table, entries, num_entries),
 			    GFP_KERNEL);
 	if (!mclk_table)
 		return -ENOMEM;
 
-	mclk_table->count = (uint32_t)mclk_dep_table->ucNumEntries;
+	mclk_table->count = num_entries;
 
-	for (i = 0; i < mclk_dep_table->ucNumEntries; i++) {
+	for (i = 0; i < num_entries; i++) {
 		mclk_table->entries[i].vddInd =
 				mclk_dep_table->entries[i].ucVddInd;
 		mclk_table->entries[i].vddciInd =
@@ -633,6 +660,7 @@ static int get_gfxclk_voltage_dependency_table(
 		const ATOM_Vega10_GFXCLK_Dependency_Table *clk_dep_table)
 {
 	uint32_t i;
+	uint32_t num_entries;
 	struct phm_ppt_v1_clock_voltage_dependency_table
 				*clk_table;
 	ATOM_Vega10_GFXCLK_Dependency_Record_V2 *patom_record_v2;
@@ -640,15 +668,35 @@ static int get_gfxclk_voltage_dependency_table(
 	PP_ASSERT_WITH_CODE((clk_dep_table->ucNumEntries != 0),
 			"Invalid PowerPlay Table!", return -1);
 
-	clk_table = kzalloc(struct_size(clk_table, entries, clk_dep_table->ucNumEntries),
+	if (clk_dep_table->ucRevId == 0) {
+		num_entries = min_t(uint32_t, clk_dep_table->ucNumEntries,
+				    pp_entries_max(hwmgr, clk_dep_table,
+						   sizeof(*clk_dep_table),
+						   sizeof(ATOM_Vega10_GFXCLK_Dependency_Record)));
+	} else if (clk_dep_table->ucRevId == 1) {
+		num_entries = min_t(uint32_t, clk_dep_table->ucNumEntries,
+				    pp_entries_max(hwmgr, clk_dep_table,
+						   sizeof(*clk_dep_table),
+						   sizeof(ATOM_Vega10_GFXCLK_Dependency_Record_V2)));
+	} else {
+		PP_ASSERT_WITH_CODE(false,
+			"Unsupported GFXClockDependencyTable Revision!",
+			return -EINVAL);
+	}
+
+	if (num_entries < clk_dep_table->ucNumEntries)
+		pr_warn("amdgpu: Vega10 GFXCLK dependency table: clamping ucNumEntries %u -> %u\n",
+			clk_dep_table->ucNumEntries, num_entries);
+
+	clk_table = kzalloc(struct_size(clk_table, entries, num_entries),
 			    GFP_KERNEL);
 	if (!clk_table)
 		return -ENOMEM;
 
-	clk_table->count = clk_dep_table->ucNumEntries;
+	clk_table->count = num_entries;
 
 	if (clk_dep_table->ucRevId == 0) {
-		for (i = 0; i < clk_table->count; i++) {
+		for (i = 0; i < num_entries; i++) {
 			clk_table->entries[i].vddInd =
 				clk_dep_table->entries[i].ucVddInd;
 			clk_table->entries[i].clk =
@@ -661,9 +709,9 @@ static int get_gfxclk_voltage_dependency_table(
 			clk_table->entries[i].sclk_offset =
 				le16_to_cpu(clk_dep_table->entries[i].usAVFSOffset);
 		}
-	} else if (clk_dep_table->ucRevId == 1) {
+	} else {
 		patom_record_v2 = (ATOM_Vega10_GFXCLK_Dependency_Record_V2 *)clk_dep_table->entries;
-		for (i = 0; i < clk_table->count; i++) {
+		for (i = 0; i < num_entries; i++) {
 			clk_table->entries[i].vddInd =
 					patom_record_v2->ucVddInd;
 			clk_table->entries[i].clk =
@@ -677,11 +725,6 @@ static int get_gfxclk_voltage_dependency_table(
 					le16_to_cpu(patom_record_v2->usAVFSOffset);
 			patom_record_v2++;
 		}
-	} else {
-		kfree(clk_table);
-		PP_ASSERT_WITH_CODE(false,
-			"Unsupported GFXClockDependencyTable Revision!",
-			return -EINVAL);
 	}
 
 	*pp_vega10_clk_dep_table = clk_table;
@@ -696,20 +739,29 @@ static int get_pix_clk_voltage_dependency_table(
 		const  ATOM_Vega10_PIXCLK_Dependency_Table *clk_dep_table)
 {
 	uint32_t i;
+	uint32_t num_entries;
 	struct phm_ppt_v1_clock_voltage_dependency_table
 				*clk_table;
 
 	PP_ASSERT_WITH_CODE((clk_dep_table->ucNumEntries != 0),
 			"Invalid PowerPlay Table!", return -1);
 
-	clk_table = kzalloc(struct_size(clk_table, entries, clk_dep_table->ucNumEntries),
+	num_entries = min_t(uint32_t, clk_dep_table->ucNumEntries,
+			    pp_entries_max(hwmgr, clk_dep_table,
+					   sizeof(*clk_dep_table),
+					   sizeof(ATOM_Vega10_CLK_Dependency_Record)));
+	if (num_entries < clk_dep_table->ucNumEntries)
+		pr_warn("amdgpu: Vega10 PIXCLK dependency table: clamping ucNumEntries %u -> %u\n",
+			clk_dep_table->ucNumEntries, num_entries);
+
+	clk_table = kzalloc(struct_size(clk_table, entries, num_entries),
 			    GFP_KERNEL);
 	if (!clk_table)
 		return -ENOMEM;
 
-	clk_table->count = clk_dep_table->ucNumEntries;
+	clk_table->count = num_entries;
 
-	for (i = 0; i < clk_table->count; i++) {
+	for (i = 0; i < num_entries; i++) {
 		clk_table->entries[i].vddInd =
 				clk_dep_table->entries[i].ucVddInd;
 		clk_table->entries[i].clk =
@@ -728,6 +780,7 @@ static int get_dcefclk_voltage_dependency_table(
 		const ATOM_Vega10_DCEFCLK_Dependency_Table *clk_dep_table)
 {
 	uint32_t i;
+	uint32_t safe_entries;
 	uint8_t num_entries;
 	struct phm_ppt_v1_clock_voltage_dependency_table
 				*clk_table;
@@ -738,6 +791,14 @@ static int get_dcefclk_voltage_dependency_table(
 	PP_ASSERT_WITH_CODE((clk_dep_table->ucNumEntries != 0),
 			"Invalid PowerPlay Table!", return -1);
 
+	safe_entries = min_t(uint32_t, clk_dep_table->ucNumEntries,
+			     pp_entries_max(hwmgr, clk_dep_table,
+					    sizeof(*clk_dep_table),
+					    sizeof(ATOM_Vega10_CLK_Dependency_Record)));
+	if (safe_entries < clk_dep_table->ucNumEntries)
+		pr_warn("amdgpu: Vega10 DCEFCLK dependency table: clamping ucNumEntries %u -> %u\n",
+			clk_dep_table->ucNumEntries, safe_entries);
+
 /*
  * workaround needed to add another DPM level for pioneer cards
  * as VBIOS is locked down.
@@ -747,12 +808,12 @@ static int get_dcefclk_voltage_dependency_table(
 	dev_id = adev->pdev->device;
 	rev_id = adev->pdev->revision;
 
-	if (dev_id == 0x6863 && rev_id == 0 &&
-		clk_dep_table->entries[clk_dep_table->ucNumEntries - 1].ulClk < 90000)
-		num_entries = clk_dep_table->ucNumEntries + 1 > NUM_DSPCLK_LEVELS ?
-				NUM_DSPCLK_LEVELS : clk_dep_table->ucNumEntries + 1;
+	if (dev_id == 0x6863 && rev_id == 0 && safe_entries > 0 &&
+		clk_dep_table->entries[safe_entries - 1].ulClk < 90000)
+		num_entries = safe_entries + 1 > NUM_DSPCLK_LEVELS ?
+				NUM_DSPCLK_LEVELS : safe_entries + 1;
 	else
-		num_entries = clk_dep_table->ucNumEntries;
+		num_entries = safe_entries;
 
 
 	clk_table = kzalloc(struct_size(clk_table, entries, num_entries),
@@ -762,7 +823,7 @@ static int get_dcefclk_voltage_dependency_table(
 
 	clk_table->count = (uint32_t)num_entries;
 
-	for (i = 0; i < clk_dep_table->ucNumEntries; i++) {
+	for (i = 0; i < safe_entries; i++) {
 		clk_table->entries[i].vddInd =
 				clk_dep_table->entries[i].ucVddInd;
 		clk_table->entries[i].clk =
@@ -1036,18 +1097,28 @@ static int get_vddc_lookup_table(
 		uint32_t max_levels)
 {
 	uint32_t i;
+	uint32_t num_entries;
 	phm_ppt_v1_voltage_lookup_table *table;
 
 	PP_ASSERT_WITH_CODE((vddc_lookup_pp_tables->ucNumEntries != 0),
 			"Invalid SOC_VDDD Lookup Table!", return 1);
 
-	table = kzalloc(struct_size(table, entries, max_levels), GFP_KERNEL);
+	num_entries = min_t(uint32_t, vddc_lookup_pp_tables->ucNumEntries,
+			    min_t(uint32_t, max_levels,
+				  pp_entries_max(hwmgr, vddc_lookup_pp_tables,
+						 sizeof(*vddc_lookup_pp_tables),
+						 sizeof(ATOM_Vega10_Voltage_Lookup_Record))));
+	if (num_entries < vddc_lookup_pp_tables->ucNumEntries)
+		pr_warn("amdgpu: Vega10 VddcLookup table: clamping ucNumEntries %u -> %u\n",
+			vddc_lookup_pp_tables->ucNumEntries, num_entries);
+
+	table = kzalloc(struct_size(table, entries, num_entries), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
 
-	table->count = vddc_lookup_pp_tables->ucNumEntries;
+	table->count = num_entries;
 
-	for (i = 0; i < vddc_lookup_pp_tables->ucNumEntries; i++)
+	for (i = 0; i < num_entries; i++)
 		table->entries[i].us_vdd =
 				le16_to_cpu(vddc_lookup_pp_tables->entries[i].usVdd);
 
-- 
2.46.0

