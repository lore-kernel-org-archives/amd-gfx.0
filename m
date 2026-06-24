Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB79CDB470
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 06:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173F510EC69;
	Wed, 24 Jun 2026 06:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x/iHViAg";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB65810EC69
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 06:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWSU7bmWOdQVyNgRX11ydNDaM9DFEU4PKen38zSYe+LbZbzecJbltafD0scePLOwmq1w+gh3zUq7sExFwA6T1myL+v0Kj9ERtlOPjYHs3AduIVTPtbZHt/erHP1x2WyJcZKSFSywOyrPkGqqX5OlpgKd0tWSa0Tgljw2dOCGNWXqDCsK+O9V5vgXyhdhQJDegst82B4ZAaZJagOvh0X5FA4kfh9kc288dfLBUFT0g8fUSfP1ymdapS3EG1tmfTM+HEKPjJgQqI7+KZdWnzxX9qH9yx9eGyNVkc1f3Xxdcjp+EJ1jxTRiL1/ndcxMluu4Qd7q1ydkgM7/K9Bez96mwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQWqh5hgpv7tbvTo0IBdZR+9NCyoyPjFPuo5zlGYpwA=;
 b=lWiAo/MXGrIZHGgIoTSJKqKWani5D4A2l6X1dGiFtqCQNIbKCWsraQLnUrDyHDcftQcYF/TfnY9dFujN8TQjWymmvCjKUbBRnNX3WnogatLJg/2RxsnV+ENpc1vSXXNkENn3U+adJ0Ci1QxmRjjcT7EyH5uw/oQENtZnAAV8ArJiev/WoWHLRXMRv7O21tYOsq+evgpWFwj1HhsBFUR03eHA+wQlKKLdXCTLiA7bnZFA4cljtGf2qN29LQ837eSuAWwX4SBczWOfcxwg5Fwf8mcXI4NtK94zixr5kQHr+bCVFytEh+/Tx+XMXSxoTeHYwaRlg1FbZM+e/EH3CUYiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQWqh5hgpv7tbvTo0IBdZR+9NCyoyPjFPuo5zlGYpwA=;
 b=x/iHViAgmcoUJN7drwrGPGH4axxKc7pe02vCUDyhxSUwfn0GGmhUmcE2rU6TlKXnip7HX1ZACEmq5B/XFsbPmyb4k07w7y6NVrhhZ3SxoocanwQSHSIDL3bFxYQ3Xzqv5hqNCz9T34dyCe9mee/QHC52nNTHlu8QoDe6Lcafeuc=
Received: from SJ0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:2c0::7)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 06:44:41 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::29) by SJ0PR13CA0002.outlook.office365.com
 (2603:10b6:a03:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 06:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 06:44:40 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 01:44:38 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/pm/powerplay: clamp Tonga/Polaris PP sub-table
 ucNumEntries
Date: Wed, 24 Jun 2026 14:44:11 +0800
Message-ID: <20260624064414.144468-2-asad.kamal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5db3be-f70f-4ee4-5119-08ded1bc116c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: vi6e0GOQRI4O5MjPF8ECD+kmJb2zTrmUCQeHbm279nUrORQSOm0gtgY7LfH6cTNyf1+Dj51kcRn5eqaPYbwJJvlScldqrkOMm/WRm7DNDXA8BOUs2dwU1ZYScN/h/dBEVESkLJEiIEvKz7j4jUDJC4oQQrBW38ev37LwXOgUfgru3GkVml3fMKYD2DvMI6LgVQ2PwxQxZNwN4DENdeOpijpNQzljOJ8ziJn2Kn69fLXACBODKNeZO2e9SBlb/2okcQ9vVzhf/aFful8Y0iUK4BmuIa3OfLVKjRkRDotK5Dp+i6pNghYqhU8EjzYN7cJa+yIGsb6XkPAjZjKcOiROPW6wIJU+EJjaCV0HkbbYRL+FXH32QCsEzjbTT2y1bYhn61LBu8BHM1rDqQUKZh1sKInRcj9TttSAHpD43FNg4U47Yvf2kdebSc/TpEybtP67msf4Jdgsx8VbGQPIJG55Y12nCLIdTapCv5AdpTBSz+AzgK+8dUdER5qyAyKUCMSV11Ntu9ARN6H4BjuZpAbLpU+6gInBNec437eM3vU2NWpBX8alPUleauvGzi2nHitNlYXO5yC4bEmiycIEgdJbm5SwIEYYjBX4THLdEaz4nliv+mDDmAEQqXgmY5KAIGH0GcdXyyAcmsPB0o30q6+9AAChW0VOOM+V+g8ro6ktIU3AQgzCFAnz6tyBa16gGSxoi5jS9Htrj5I1I857tYdyhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DP00FRmwpix2Rn357jXgkHj9A8ef5KH1hyj+dwBfgxkr1iPrnVjQUyeJDkS8wcxV4np8YvDzGkkVIilzYFyiF6ljPGQseZF6dqX5jjC9AqPjVBM8OwchkiJf7Mh1najw9ASj93H3LMPJNYqQPYvfoJYOcQGjHs/Atz/SVfHszMtlQPoZp5ecjr0pfG1Lv5iiwqU9PtBNSmL9epQ+62ZnLBawvIlhESAgIhDNP/atgFsbFF2n4Ww/hIwBlHWfozZL7errmbWKzi9FGUImoGti5xt/Ewv/nJ2xl61bWHu/zVGpC4Us2Ktr+CKSDEgpvX6n3mVABzFC3F2s15okcMG5Idosi+PmoCrNazkWF2RqCajeJxRO2fRW9mHNarttv8TyHtNnp6IjDyCSjuESAvrx2QSrmFznqmXyliFQwJTu5s3BVESaHsiyorI+C+7y6+K6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 06:44:40.8199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5db3be-f70f-4ee4-5119-08ded1bc116c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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

ucNumEntries in the Tonga/Polaris PowerPlay sub-tables is used as both the
kzalloc count and loop bound without validation, allowing a crafted VBIOS
to overflow the destination heap object and read past the VBIOS image.

Clamp via pp_entries_max() in get_vddc_lookup_table(),
get_mclk_voltage_dependency_table(), get_sclk_voltage_dependency_table()
and get_mm_clock_voltage_table().

Fixes: c82baa281843 ("drm/amd/powerplay: add Tonga dpm support (v3)")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 76 +++++++++++++++----
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 6cfef1b295ab..aff30f609414 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -158,6 +158,7 @@ static int get_vddc_lookup_table(
 		)
 {
 	uint32_t i;
+	uint32_t num_entries;
 	phm_ppt_v1_voltage_lookup_table *table;
 	phm_ppt_v1_voltage_lookup_record *record;
 	ATOM_Tonga_Voltage_Lookup_Record *atom_record;
@@ -165,13 +166,22 @@ static int get_vddc_lookup_table(
 	PP_ASSERT_WITH_CODE((0 != vddc_lookup_pp_tables->ucNumEntries),
 		"Invalid CAC Leakage PowerPlay Table!", return 1);
 
-	table = kzalloc(struct_size(table, entries, max_levels), GFP_KERNEL);
+	num_entries = min_t(uint32_t, vddc_lookup_pp_tables->ucNumEntries,
+			    min_t(uint32_t, max_levels,
+				  pp_entries_max(hwmgr, vddc_lookup_pp_tables,
+						 sizeof(*vddc_lookup_pp_tables),
+						 sizeof(ATOM_Tonga_Voltage_Lookup_Record))));
+	if (num_entries < vddc_lookup_pp_tables->ucNumEntries)
+		pr_warn("amdgpu: VddcLookup table: clamping ucNumEntries %u -> %u\n",
+			vddc_lookup_pp_tables->ucNumEntries, num_entries);
+
+	table = kzalloc(struct_size(table, entries, num_entries), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
 
-	table->count = vddc_lookup_pp_tables->ucNumEntries;
+	table->count = num_entries;
 
-	for (i = 0; i < vddc_lookup_pp_tables->ucNumEntries; i++) {
+	for (i = 0; i < num_entries; i++) {
 		record = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
 					phm_ppt_v1_voltage_lookup_record,
 					entries, table, i);
@@ -364,6 +374,7 @@ static int get_mclk_voltage_dependency_table(
 		)
 {
 	uint32_t i;
+	uint32_t num_entries;
 	phm_ppt_v1_clock_voltage_dependency_table *mclk_table;
 	phm_ppt_v1_clock_voltage_dependency_record *mclk_table_record;
 	ATOM_Tonga_MCLK_Dependency_Record *mclk_dep_record;
@@ -371,14 +382,22 @@ static int get_mclk_voltage_dependency_table(
 	PP_ASSERT_WITH_CODE((0 != mclk_dep_table->ucNumEntries),
 		"Invalid PowerPlay Table!", return -1);
 
-	mclk_table = kzalloc(struct_size(mclk_table, entries, mclk_dep_table->ucNumEntries),
+	num_entries = min_t(uint32_t, mclk_dep_table->ucNumEntries,
+			    pp_entries_max(hwmgr, mclk_dep_table,
+					   sizeof(*mclk_dep_table),
+					   sizeof(ATOM_Tonga_MCLK_Dependency_Record)));
+	if (num_entries < mclk_dep_table->ucNumEntries)
+		pr_warn("amdgpu: MCLK dependency table: clamping ucNumEntries %u -> %u\n",
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
 		mclk_table_record = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
 					phm_ppt_v1_clock_voltage_dependency_record,
 						entries, mclk_table, i);
@@ -404,6 +423,7 @@ static int get_sclk_voltage_dependency_table(
 		)
 {
 	uint32_t i;
+	uint32_t num_entries;
 	phm_ppt_v1_clock_voltage_dependency_table *sclk_table;
 	phm_ppt_v1_clock_voltage_dependency_record *sclk_table_record;
 
@@ -415,14 +435,22 @@ static int get_sclk_voltage_dependency_table(
 		PP_ASSERT_WITH_CODE((0 != tonga_table->ucNumEntries),
 			"Invalid PowerPlay Table!", return -1);
 
-		sclk_table = kzalloc(struct_size(sclk_table, entries, tonga_table->ucNumEntries),
+		num_entries = min_t(uint32_t, tonga_table->ucNumEntries,
+				    pp_entries_max(hwmgr, tonga_table,
+						   sizeof(*tonga_table),
+						   sizeof(ATOM_Tonga_SCLK_Dependency_Record)));
+		if (num_entries < tonga_table->ucNumEntries)
+			pr_warn("amdgpu: Tonga SCLK dependency table: clamping ucNumEntries %u -> %u\n",
+				tonga_table->ucNumEntries, num_entries);
+
+		sclk_table = kzalloc(struct_size(sclk_table, entries, num_entries),
 				     GFP_KERNEL);
 		if (!sclk_table)
 			return -ENOMEM;
 
-		sclk_table->count = (uint32_t)tonga_table->ucNumEntries;
+		sclk_table->count = num_entries;
 
-		for (i = 0; i < tonga_table->ucNumEntries; i++) {
+		for (i = 0; i < num_entries; i++) {
 			sclk_dep_record = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
 						ATOM_Tonga_SCLK_Dependency_Record,
 						entries, tonga_table, i);
@@ -444,14 +472,22 @@ static int get_sclk_voltage_dependency_table(
 		PP_ASSERT_WITH_CODE((0 != polaris_table->ucNumEntries),
 			"Invalid PowerPlay Table!", return -1);
 
-		sclk_table = kzalloc(struct_size(sclk_table, entries, polaris_table->ucNumEntries),
+		num_entries = min_t(uint32_t, polaris_table->ucNumEntries,
+				    pp_entries_max(hwmgr, polaris_table,
+						   sizeof(*polaris_table),
+						   sizeof(ATOM_Polaris_SCLK_Dependency_Record)));
+		if (num_entries < polaris_table->ucNumEntries)
+			pr_warn("amdgpu: Polaris SCLK dependency table: clamping ucNumEntries %u -> %u\n",
+				polaris_table->ucNumEntries, num_entries);
+
+		sclk_table = kzalloc(struct_size(sclk_table, entries, num_entries),
 				     GFP_KERNEL);
 		if (!sclk_table)
 			return -ENOMEM;
 
-		sclk_table->count = (uint32_t)polaris_table->ucNumEntries;
+		sclk_table->count = num_entries;
 
-		for (i = 0; i < polaris_table->ucNumEntries; i++) {
+		for (i = 0; i < num_entries; i++) {
 			sclk_dep_record = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
 						ATOM_Polaris_SCLK_Dependency_Record,
 						entries, polaris_table, i);
@@ -718,20 +754,30 @@ static int get_mm_clock_voltage_table(
 		)
 {
 	uint32_t i;
+	uint32_t num_entries;
 	const ATOM_Tonga_MM_Dependency_Record *mm_dependency_record;
 	phm_ppt_v1_mm_clock_voltage_dependency_table *mm_table;
 	phm_ppt_v1_mm_clock_voltage_dependency_record *mm_table_record;
 
 	PP_ASSERT_WITH_CODE((0 != mm_dependency_table->ucNumEntries),
 		"Invalid PowerPlay Table!", return -1);
-	mm_table = kzalloc(struct_size(mm_table, entries, mm_dependency_table->ucNumEntries),
+
+	num_entries = min_t(uint32_t, mm_dependency_table->ucNumEntries,
+			    pp_entries_max(hwmgr, mm_dependency_table,
+					   sizeof(*mm_dependency_table),
+					   sizeof(ATOM_Tonga_MM_Dependency_Record)));
+	if (num_entries < mm_dependency_table->ucNumEntries)
+		pr_warn("amdgpu: MM dependency table: clamping ucNumEntries %u -> %u\n",
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
 		mm_dependency_record = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
 						ATOM_Tonga_MM_Dependency_Record,
 						entries, mm_dependency_table, i);
-- 
2.46.0

