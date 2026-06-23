Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC4BCDB46F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 10:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF9E10EA74;
	Tue, 23 Jun 2026 10:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iHyq2h5N";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B35E10EA5C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 10:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZvHp75kMcYmYSg2ROh3gs7bvcVWR4ZBkozeZEUSha8jNfas/i/WD2H+cUQJ5Hn/QMrO1sR6iayvc3Bivte/K+Rv+f7GSj14ddpSQO4QKXICDsMXgOlFqSbYrOaq1iC8r1YS3tLxptyCazyAdWlDv3IGKxj57/9zC2GR+nVApVYf4ZJDpCqAV16HcEblPVAhz0n5dqNTOicfAdGPcBOX/YZNxKnfndQ2ybr6sQYzHVKTYlarE4OxBnpbbHCynQwWrn1Bh3tcwPPWwz3RUQM6TufRLqcadn8L2vKGF2UGodCtWKocf3K0zS1veU5lTGzoixRDkgF+JSE0wGi04weEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qALKC8YFZDOb6yULuKER5HobwmINbhvpSuS8PkiL7I=;
 b=hPobjU2hdoROcv6hwOV0Jh2//4nY0mWY+5i4ssO+T0Pua5CZiOdHmEtzEC0uovVWc1gSusnmQt5mzq6Q+5a9nCuEXF6Qc8NP2wXHQ52uU3+Sr0IXlyhpDR31b+NX6uHZ2LHnNDIAiArx5fLmSB1DYQUblaufO73UJ2g8DgfdyZ96Hns37vR2PVKSzp5Y/uK5mFnSwi8ItpkhBIGQSC7a1yIDUqOcwfFI9BLGRWLDvBv3WmGeMwcfue9HcwBOlH18Muz/7Vd0RxyB9JXxd5yOfHqNVW0ceh4byo8CmNqMD0tu176C0tWr2ZkFgVnIrQuQmHmffehGCm3ZPcUNs0gMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qALKC8YFZDOb6yULuKER5HobwmINbhvpSuS8PkiL7I=;
 b=iHyq2h5NftP2SbD4nIWXwuIciYjDXgjDIQSM2HLNyp5urgeM6p0bceOP3hRHNESHSml5I7WhPcO/FuxS2rSVdxNg8IFRKP5kZp/0j8vlgzm7exhQm8ApRKWUxOc5RS4xtej+Emia4b545Sw8Roh+8VVuFyyUwjwC78yuYKYyaoA=
Received: from CH0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:610:119::15)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 10:23:36 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::8f) by CH0PR03CA0364.outlook.office365.com
 (2603:10b6:610:119::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Tue,
 23 Jun 2026 10:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 10:23:36 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 05:23:34 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Validate Tonga PPTable subtable bounds
Date: Tue, 23 Jun 2026 18:23:18 +0800
Message-ID: <20260623102319.413960-2-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: d875f048-729b-42ec-ac91-08ded1117c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|11063799006|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: zqEHjkiVsL3w4qwH19hLmgApz/w6QULtLeN6Y8zkw6R6LiGjYsTQvHWG34a5r1FpbqOdeWWVJjjz6oAIdLPGageFIvYw9jOd+YejpYPK1nye/dod3lSH2nMs61W/2L/jT+m5uH8zQkE/Lpq2GbtMkjj1RrCz9Xi5EehBOQKg54A+4eKYG09KswvYSFC7HtkwwcCtQdAdXVHfMbowgbmu2cUjra9MlXCY3bYPa7WqsaxPVCicZB0hMPv5g4qRylSFF9hvb0G6eac9NLp/VTKsh3BBuLh/7lHI7wFmMRRFz7uIq0HsKfk4IgtUiir0nhAVfz55B0fq0IfqUmE6eR34BexIWaaMTnqrlH+76KX3FDMMJnFJ4d3RntPHzz06l0lPVwXA60B4GNYhEpdZyBl9JMJ/9HupyexhjSwSyrKIHq9Wikuif0hCJnnp6+pF/qjOKFerEVY3yzgtTv8RPRr2AIE7KsaSSwI+yS7YwCOlZN6PtZ4d/UbEPs8DiSYLrGYTnLNd59OzG6IkKultyj31iYehoJ55T8wrLRP9PaoWYDWfitIZ1ifG43S6y4W9tQkiA4/Nw48ywAJMunWbJuoUkm3arCqynynhvDLk32PVIdLZwBGVUCHzEIJQ1sD8OSm5SzzkYPsZmdxtIjvSQbjCwEWaqBElrrCinPnUjRTduWWM5OJzsCcfVdeJDjQAkdxW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wZRnGD6Rebx82lYBPXLYxTCw8les6KM3yH76nR/w0SSSYXywx/gMZXfuYJajRGlH0TgPwvhOtAaX7MSBS4w568tuBAn6bDDv/DrkGMKXYt7MIb7rKiH7BIC1lLptfZKndvxpg/Ux47CtWveLaTw4sBu6vTEK67Hfn9lp1y6HmpkLT2ox0GYUQ+bqwpekP1TcBTZIDNFQj6Gjv2jG9hLpoUIQa8fxyjb/wZXyfLVNLELycu/tc5DT+PSGa0zr9FuJSgl2QG/tEJBxz0jrCA6onSO6hlECNJJwUP3jnD9pl9SLWiwReL02QevxyqIwDUnsphDJE332/ZAj1Nb1OTy7lPuMjL/sZRyIDJYZcOf7EcsrM4fjow0c4Uxi3cWK5Tab6776e7gynRoFBJ3WlM/oQCdgjzTVrqg9nIf46parK0C0g7vxadbkKHm5gO9bOuUP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 10:23:36.4727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d875f048-729b-42ec-ac91-08ded1117c6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
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

Tonga PPTable parsing also relies on VBIOS offsets, revision fields
and entry counts for several subtables. Malformed data can cause
out-of-bounds reads, while voltage lookup tables can overrun their
fixed-size destination arrays.

Add common bounds helpers and validate fixed subtables, dynamic entry
arrays and revision-specific layouts before consuming voltage lookup,
dependency, PCIE, power-tune, hard-limit, thermal, fan, GPIO, PPM and
VCE state data.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 604 +++++++++++++++---
 1 file changed, 519 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 94c1e2c10370..831f5e240105 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -150,6 +150,368 @@ static const void *get_powerplay_table(struct pp_hwmgr *hwmgr)
 	return table_address;
 }
 
+static bool tonga_pp_table_has_space(struct pp_hwmgr *hwmgr, size_t offset,
+				     size_t size)
+{
+	size_t table_size = hwmgr->soft_pp_table_size;
+
+	return offset <= table_size && size <= table_size - offset;
+}
+
+static int get_tonga_subtable(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		u16 table_offset, size_t table_size, const void **table)
+{
+	PP_ASSERT_WITH_CODE((table_offset != 0),
+			    "Invalid PowerPlay Table!", return -1);
+	PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr, table_offset,
+						      table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*table = (const void *)(((unsigned long)powerplay_table) + table_offset);
+
+	return 0;
+}
+
+static int validate_tonga_table_entries(struct pp_hwmgr *hwmgr,
+		u16 table_offset, size_t entries_offset,
+		u8 num_entries, size_t entry_size)
+{
+	size_t table_size;
+
+	PP_ASSERT_WITH_CODE((num_entries != 0),
+			    "Invalid PowerPlay Table!", return -1);
+
+	table_size = entries_offset + num_entries * entry_size;
+	PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr, table_offset,
+						      table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	return 0;
+}
+
+static int get_tonga_voltage_lookup_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		u16 table_offset, uint32_t max_levels,
+		const ATOM_Tonga_Voltage_Lookup_Table **lookup_table)
+{
+	const ATOM_Tonga_Voltage_Lookup_Table *table;
+	size_t table_size;
+	int ret;
+
+	ret = get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*table), (const void **)&table);
+	if (ret)
+		return ret;
+
+	PP_ASSERT_WITH_CODE((table->ucNumEntries != 0 &&
+			     table->ucNumEntries <= max_levels),
+			    "Invalid PowerPlay Table!", return -1);
+
+	table_size = offsetof(ATOM_Tonga_Voltage_Lookup_Table, entries) +
+		table->ucNumEntries * sizeof(ATOM_Tonga_Voltage_Lookup_Record);
+	PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr, table_offset,
+						      table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*lookup_table = table;
+
+	return 0;
+}
+
+static int get_tonga_mclk_dependency_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Tonga_MCLK_Dependency_Table **mclk_dep_table)
+{
+	const ATOM_Tonga_MCLK_Dependency_Table *table;
+	u16 table_offset;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usMclkDependencyTableOffset);
+	ret = get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*table), (const void **)&table);
+	if (ret)
+		return ret;
+
+	ret = validate_tonga_table_entries(hwmgr, table_offset,
+					   offsetof(ATOM_Tonga_MCLK_Dependency_Table,
+						    entries),
+					   table->ucNumEntries,
+					   sizeof(ATOM_Tonga_MCLK_Dependency_Record));
+	if (ret)
+		return ret;
+
+	*mclk_dep_table = table;
+
+	return 0;
+}
+
+static int get_tonga_mm_dependency_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Tonga_MM_Dependency_Table **mm_dep_table)
+{
+	const ATOM_Tonga_MM_Dependency_Table *table;
+	u16 table_offset;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usMMDependencyTableOffset);
+	ret = get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*table), (const void **)&table);
+	if (ret)
+		return ret;
+
+	ret = validate_tonga_table_entries(hwmgr, table_offset,
+					   offsetof(ATOM_Tonga_MM_Dependency_Table,
+						    entries),
+					   table->ucNumEntries,
+					   sizeof(ATOM_Tonga_MM_Dependency_Record));
+	if (ret)
+		return ret;
+
+	*mm_dep_table = table;
+
+	return 0;
+}
+
+static int get_tonga_sclk_dependency_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		const PPTable_Generic_SubTable_Header **sclk_dep_table)
+{
+	const PPTable_Generic_SubTable_Header *header;
+	u16 table_offset;
+	size_t entries_offset;
+	size_t entry_size;
+	u8 num_entries;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usSclkDependencyTableOffset);
+	ret = get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*header), (const void **)&header);
+	if (ret)
+		return ret;
+
+	if (header->ucRevId < 1) {
+		const ATOM_Tonga_SCLK_Dependency_Table *table =
+			(const ATOM_Tonga_SCLK_Dependency_Table *)header;
+
+		entries_offset = offsetof(ATOM_Tonga_SCLK_Dependency_Table, entries);
+		entry_size = sizeof(ATOM_Tonga_SCLK_Dependency_Record);
+		num_entries = table->ucNumEntries;
+	} else {
+		const ATOM_Polaris_SCLK_Dependency_Table *table =
+			(const ATOM_Polaris_SCLK_Dependency_Table *)header;
+
+		entries_offset = offsetof(ATOM_Polaris_SCLK_Dependency_Table, entries);
+		entry_size = sizeof(ATOM_Polaris_SCLK_Dependency_Record);
+		num_entries = table->ucNumEntries;
+	}
+
+	ret = validate_tonga_table_entries(hwmgr, table_offset, entries_offset,
+					   num_entries, entry_size);
+	if (ret)
+		return ret;
+
+	*sclk_dep_table = header;
+
+	return 0;
+}
+
+static int get_tonga_pcie_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		const PPTable_Generic_SubTable_Header **pcie_table)
+{
+	const PPTable_Generic_SubTable_Header *header;
+	u16 table_offset;
+	size_t entries_offset;
+	size_t entry_size;
+	u8 num_entries;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usPCIETableOffset);
+	ret = get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*header), (const void **)&header);
+	if (ret)
+		return ret;
+
+	if (header->ucRevId < 1) {
+		const ATOM_Tonga_PCIE_Table *table =
+			(const ATOM_Tonga_PCIE_Table *)header;
+
+		entries_offset = offsetof(ATOM_Tonga_PCIE_Table, entries);
+		entry_size = sizeof(ATOM_Tonga_PCIE_Record);
+		num_entries = table->ucNumEntries;
+	} else {
+		const ATOM_Polaris10_PCIE_Table *table =
+			(const ATOM_Polaris10_PCIE_Table *)header;
+
+		entries_offset = offsetof(ATOM_Polaris10_PCIE_Table, entries);
+		entry_size = sizeof(ATOM_Polaris10_PCIE_Record);
+		num_entries = table->ucNumEntries;
+	}
+
+	ret = validate_tonga_table_entries(hwmgr, table_offset, entries_offset,
+					   num_entries, entry_size);
+	if (ret)
+		return ret;
+
+	*pcie_table = header;
+
+	return 0;
+}
+
+static int get_tonga_hard_limit_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Tonga_Hard_Limit_Table **hard_limit_table)
+{
+	const ATOM_Tonga_Hard_Limit_Table *table;
+	u16 table_offset;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usHardLimitTableOffset);
+	ret = get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*table), (const void **)&table);
+	if (ret)
+		return ret;
+
+	ret = validate_tonga_table_entries(hwmgr, table_offset,
+					   offsetof(ATOM_Tonga_Hard_Limit_Table,
+						    entries),
+					   table->ucNumEntries,
+					   sizeof(ATOM_Tonga_Hard_Limit_Record));
+	if (ret)
+		return ret;
+
+	*hard_limit_table = table;
+
+	return 0;
+}
+
+static int get_tonga_thermal_controller_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Tonga_Thermal_Controller **thermal_controller)
+{
+	u16 table_offset;
+
+	table_offset = le16_to_cpu(powerplay_table->usThermalControllerOffset);
+
+	return get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				  sizeof(**thermal_controller),
+				  (const void **)thermal_controller);
+}
+
+static int get_tonga_fan_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		const PPTable_Generic_SubTable_Header **fan_table)
+{
+	const PPTable_Generic_SubTable_Header *header;
+	u16 table_offset;
+	size_t table_size;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usFanTableOffset);
+	ret = get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*header), (const void **)&header);
+	if (ret)
+		return ret;
+
+	if (header->ucRevId < 8)
+		table_size = sizeof(ATOM_Tonga_Fan_Table);
+	else if (header->ucRevId == 8)
+		table_size = sizeof(ATOM_Fiji_Fan_Table);
+	else
+		table_size = sizeof(ATOM_Polaris_Fan_Table);
+
+	PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr, table_offset,
+						      table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*fan_table = header;
+
+	return 0;
+}
+
+static int get_tonga_power_tune_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		const PPTable_Generic_SubTable_Header **power_tune_table)
+{
+	const PPTable_Generic_SubTable_Header *header;
+	u16 table_offset;
+	size_t table_size;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usPowerTuneTableOffset);
+	ret = get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*header), (const void **)&header);
+	if (ret)
+		return ret;
+
+	if (header->ucRevId < 3)
+		table_size = sizeof(ATOM_Tonga_PowerTune_Table);
+	else if (header->ucRevId < 4)
+		table_size = sizeof(ATOM_Fiji_PowerTune_Table);
+	else
+		table_size = sizeof(ATOM_Polaris_PowerTune_Table);
+
+	PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr, table_offset,
+						      table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*power_tune_table = header;
+
+	return 0;
+}
+
+static int get_tonga_ppm_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Tonga_PPM_Table **ppm_table)
+{
+	u16 table_offset;
+
+	table_offset = le16_to_cpu(powerplay_table->usPPMTableOffset);
+
+	return get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				  sizeof(**ppm_table), (const void **)ppm_table);
+}
+
+static int get_tonga_gpio_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Tonga_GPIO_Table **gpio_table)
+{
+	u16 table_offset;
+
+	table_offset = le16_to_cpu(powerplay_table->usGPIOTableOffset);
+
+	return get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				  sizeof(**gpio_table), (const void **)gpio_table);
+}
+
+static int get_tonga_vce_state_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Tonga_VCE_State_Table **vce_state_table)
+{
+	const ATOM_Tonga_VCE_State_Table *table;
+	u16 table_offset;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usVCEStateTableOffset);
+	ret = get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+				 sizeof(*table), (const void **)&table);
+	if (ret)
+		return ret;
+
+	ret = validate_tonga_table_entries(hwmgr, table_offset,
+					   offsetof(ATOM_Tonga_VCE_State_Table,
+						    entries),
+					   table->ucNumEntries,
+					   sizeof(ATOM_Tonga_VCE_State_Record));
+	if (ret)
+		return ret;
+
+	*vce_state_table = table;
+
+	return 0;
+}
+
 static int get_vddc_lookup_table(
 		struct pp_hwmgr	*hwmgr,
 		phm_ppt_v1_voltage_lookup_table	**lookup_table,
@@ -198,7 +560,7 @@ static int get_vddc_lookup_table(
  */
 static int get_platform_power_management_table(
 		struct pp_hwmgr *hwmgr,
-		ATOM_Tonga_PPM_Table *atom_ppm_table)
+		const ATOM_Tonga_PPM_Table *atom_ppm_table)
 {
 	struct phm_ppm_table *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
 	struct phm_ppt_v1_information *pp_table_information =
@@ -246,7 +608,7 @@ static int init_dpm_2_parameters(
 {
 	int result = 0;
 	struct phm_ppt_v1_information *pp_table_information = (struct phm_ppt_v1_information *)(hwmgr->pptable);
-	ATOM_Tonga_PPM_Table *atom_ppm_table;
+	const ATOM_Tonga_PPM_Table *atom_ppm_table;
 	uint32_t disable_ppm = 0;
 	uint32_t disable_power_control = 0;
 
@@ -275,30 +637,37 @@ static int init_dpm_2_parameters(
 	}
 
 	if (0 != powerplay_table->usVddcLookupTableOffset) {
-		const ATOM_Tonga_Voltage_Lookup_Table *pVddcCACTable =
-			(ATOM_Tonga_Voltage_Lookup_Table *)(((unsigned long)powerplay_table) +
-			le16_to_cpu(powerplay_table->usVddcLookupTableOffset));
-
-		result = get_vddc_lookup_table(hwmgr,
-			&pp_table_information->vddc_lookup_table, pVddcCACTable, 16);
+		const ATOM_Tonga_Voltage_Lookup_Table *pVddcCACTable;
+
+		result = get_tonga_voltage_lookup_table(hwmgr, powerplay_table,
+				le16_to_cpu(powerplay_table->usVddcLookupTableOffset),
+				16, &pVddcCACTable);
+		if (!result)
+			result = get_vddc_lookup_table(hwmgr,
+				&pp_table_information->vddc_lookup_table,
+				pVddcCACTable, 16);
 	}
 
-	if (0 != powerplay_table->usVddgfxLookupTableOffset) {
-		const ATOM_Tonga_Voltage_Lookup_Table *pVddgfxCACTable =
-			(ATOM_Tonga_Voltage_Lookup_Table *)(((unsigned long)powerplay_table) +
-			le16_to_cpu(powerplay_table->usVddgfxLookupTableOffset));
+	if (!result && 0 != powerplay_table->usVddgfxLookupTableOffset) {
+		const ATOM_Tonga_Voltage_Lookup_Table *pVddgfxCACTable;
 
-		result = get_vddc_lookup_table(hwmgr,
-			&pp_table_information->vddgfx_lookup_table, pVddgfxCACTable, 16);
+		result = get_tonga_voltage_lookup_table(hwmgr, powerplay_table,
+				le16_to_cpu(powerplay_table->usVddgfxLookupTableOffset),
+				16, &pVddgfxCACTable);
+		if (!result)
+			result = get_vddc_lookup_table(hwmgr,
+				&pp_table_information->vddgfx_lookup_table,
+				pVddgfxCACTable, 16);
 	}
 
 	disable_ppm = 0;
 	if (0 == disable_ppm) {
-		atom_ppm_table = (ATOM_Tonga_PPM_Table *)
-			(((unsigned long)powerplay_table) + le16_to_cpu(powerplay_table->usPPMTableOffset));
-
 		if (0 != powerplay_table->usPPMTableOffset) {
-			if (get_platform_power_management_table(hwmgr, atom_ppm_table) == 0) {
+			result = get_tonga_ppm_table(hwmgr, powerplay_table,
+						     &atom_ppm_table);
+			if (!result &&
+			    get_platform_power_management_table(hwmgr,
+							       atom_ppm_table) == 0) {
 				phm_cap_set(hwmgr->platform_descriptor.platformCaps,
 					PHM_PlatformCaps_EnablePlatformPowerManagement);
 			}
@@ -792,28 +1161,13 @@ static int init_clock_voltage_dependency(
 	int result = 0;
 	struct phm_ppt_v1_information *pp_table_information =
 		(struct phm_ppt_v1_information *)(hwmgr->pptable);
-
-	const ATOM_Tonga_MM_Dependency_Table *mm_dependency_table =
-		(const ATOM_Tonga_MM_Dependency_Table *)(((unsigned long) powerplay_table) +
-		le16_to_cpu(powerplay_table->usMMDependencyTableOffset));
-	const PPTable_Generic_SubTable_Header *pPowerTuneTable =
-		(const PPTable_Generic_SubTable_Header *)(((unsigned long) powerplay_table) +
-		le16_to_cpu(powerplay_table->usPowerTuneTableOffset));
-	const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table =
-		(const ATOM_Tonga_MCLK_Dependency_Table *)(((unsigned long) powerplay_table) +
-		le16_to_cpu(powerplay_table->usMclkDependencyTableOffset));
-	const PPTable_Generic_SubTable_Header *sclk_dep_table =
-		(const PPTable_Generic_SubTable_Header *)(((unsigned long) powerplay_table) +
-		le16_to_cpu(powerplay_table->usSclkDependencyTableOffset));
-	const ATOM_Tonga_Hard_Limit_Table *pHardLimits =
-		(const ATOM_Tonga_Hard_Limit_Table *)(((unsigned long) powerplay_table) +
-		le16_to_cpu(powerplay_table->usHardLimitTableOffset));
-	const PPTable_Generic_SubTable_Header *pcie_table =
-		(const PPTable_Generic_SubTable_Header *)(((unsigned long) powerplay_table) +
-		le16_to_cpu(powerplay_table->usPCIETableOffset));
-	const ATOM_Tonga_GPIO_Table *gpio_table =
-		(const ATOM_Tonga_GPIO_Table *)(((unsigned long) powerplay_table) +
-		le16_to_cpu(powerplay_table->usGPIOTableOffset));
+	const ATOM_Tonga_MM_Dependency_Table *mm_dependency_table;
+	const PPTable_Generic_SubTable_Header *pPowerTuneTable;
+	const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table;
+	const PPTable_Generic_SubTable_Header *sclk_dep_table;
+	const ATOM_Tonga_Hard_Limit_Table *pHardLimits;
+	const PPTable_Generic_SubTable_Header *pcie_table;
+	const ATOM_Tonga_GPIO_Table *gpio_table;
 
 	pp_table_information->vdd_dep_on_sclk = NULL;
 	pp_table_information->vdd_dep_on_mclk = NULL;
@@ -821,29 +1175,58 @@ static int init_clock_voltage_dependency(
 	pp_table_information->pcie_table = NULL;
 	pp_table_information->gpio_table = NULL;
 
-	if (powerplay_table->usMMDependencyTableOffset != 0)
-		result = get_mm_clock_voltage_table(hwmgr,
-		&pp_table_information->mm_dep_table, mm_dependency_table);
+	if (powerplay_table->usMMDependencyTableOffset != 0) {
+		result = get_tonga_mm_dependency_table(hwmgr, powerplay_table,
+						       &mm_dependency_table);
+		if (!result)
+			result = get_mm_clock_voltage_table(hwmgr,
+				&pp_table_information->mm_dep_table,
+				mm_dependency_table);
+	}
 
-	if (result == 0 && powerplay_table->usPowerTuneTableOffset != 0)
-		result = get_cac_tdp_table(hwmgr,
-		&pp_table_information->cac_dtp_table, pPowerTuneTable);
+	if (result == 0 && powerplay_table->usPowerTuneTableOffset != 0) {
+		result = get_tonga_power_tune_table(hwmgr, powerplay_table,
+						    &pPowerTuneTable);
+		if (!result)
+			result = get_cac_tdp_table(hwmgr,
+				&pp_table_information->cac_dtp_table,
+				pPowerTuneTable);
+	}
 
-	if (result == 0 && powerplay_table->usSclkDependencyTableOffset != 0)
-		result = get_sclk_voltage_dependency_table(hwmgr,
-		&pp_table_information->vdd_dep_on_sclk, sclk_dep_table);
+	if (result == 0 && powerplay_table->usSclkDependencyTableOffset != 0) {
+		result = get_tonga_sclk_dependency_table(hwmgr, powerplay_table,
+							 &sclk_dep_table);
+		if (!result)
+			result = get_sclk_voltage_dependency_table(hwmgr,
+				&pp_table_information->vdd_dep_on_sclk,
+				sclk_dep_table);
+	}
 
-	if (result == 0 && powerplay_table->usMclkDependencyTableOffset != 0)
-		result = get_mclk_voltage_dependency_table(hwmgr,
-		&pp_table_information->vdd_dep_on_mclk, mclk_dep_table);
+	if (result == 0 && powerplay_table->usMclkDependencyTableOffset != 0) {
+		result = get_tonga_mclk_dependency_table(hwmgr, powerplay_table,
+							 &mclk_dep_table);
+		if (!result)
+			result = get_mclk_voltage_dependency_table(hwmgr,
+				&pp_table_information->vdd_dep_on_mclk,
+				mclk_dep_table);
+	}
 
-	if (result == 0 && powerplay_table->usPCIETableOffset != 0)
-		result = get_pcie_table(hwmgr,
-		&pp_table_information->pcie_table, pcie_table);
+	if (result == 0 && powerplay_table->usPCIETableOffset != 0) {
+		result = get_tonga_pcie_table(hwmgr, powerplay_table,
+					      &pcie_table);
+		if (!result)
+			result = get_pcie_table(hwmgr,
+				&pp_table_information->pcie_table, pcie_table);
+	}
 
-	if (result == 0 && powerplay_table->usHardLimitTableOffset != 0)
-		result = get_hard_limits(hwmgr,
-		&pp_table_information->max_clock_voltage_on_dc, pHardLimits);
+	if (result == 0 && powerplay_table->usHardLimitTableOffset != 0) {
+		result = get_tonga_hard_limit_table(hwmgr, powerplay_table,
+						    &pHardLimits);
+		if (!result)
+			result = get_hard_limits(hwmgr,
+				&pp_table_information->max_clock_voltage_on_dc,
+				pHardLimits);
+	}
 
 	hwmgr->dyn_state.max_clock_voltage_on_dc.sclk =
 		pp_table_information->max_clock_voltage_on_dc.sclk;
@@ -864,9 +1247,13 @@ static int init_clock_voltage_dependency(
 		result = get_valid_clk(hwmgr, &pp_table_information->valid_sclk_values,
 		pp_table_information->vdd_dep_on_sclk);
 
-	if (!result && gpio_table)
-		result = get_gpio_table(hwmgr, &pp_table_information->gpio_table,
-				gpio_table);
+	if (!result && powerplay_table->usGPIOTableOffset) {
+		result = get_tonga_gpio_table(hwmgr, powerplay_table,
+					      &gpio_table);
+		if (!result)
+			result = get_gpio_table(hwmgr,
+				&pp_table_information->gpio_table, gpio_table);
+	}
 
 	return result;
 }
@@ -911,14 +1298,17 @@ static int init_thermal_controller(
 		)
 {
 	const PPTable_Generic_SubTable_Header *fan_table;
-	ATOM_Tonga_Thermal_Controller *thermal_controller;
+	const ATOM_Tonga_Thermal_Controller *thermal_controller;
+	int ret;
 
-	thermal_controller = (ATOM_Tonga_Thermal_Controller *)
-		(((unsigned long)powerplay_table) +
-		le16_to_cpu(powerplay_table->usThermalControllerOffset));
 	PP_ASSERT_WITH_CODE((0 != powerplay_table->usThermalControllerOffset),
 		"Thermal controller table not set!", return -1);
 
+	ret = get_tonga_thermal_controller_table(hwmgr, powerplay_table,
+						 &thermal_controller);
+	if (ret)
+		return ret;
+
 	hwmgr->thermal_controller.ucType = thermal_controller->ucType;
 	hwmgr->thermal_controller.ucI2cLine = thermal_controller->ucI2cLine;
 	hwmgr->thermal_controller.ucI2cAddress = thermal_controller->ucI2cAddress;
@@ -946,12 +1336,13 @@ static int init_thermal_controller(
 		return 0;
 	}
 
-	fan_table = (const PPTable_Generic_SubTable_Header *)
-		(((unsigned long)powerplay_table) +
-		le16_to_cpu(powerplay_table->usFanTableOffset));
-
 	PP_ASSERT_WITH_CODE((0 != powerplay_table->usFanTableOffset),
 		"Fan table not set!", return -1);
+
+	ret = get_tonga_fan_table(hwmgr, powerplay_table, &fan_table);
+	if (ret)
+		return ret;
+
 	PP_ASSERT_WITH_CODE((0 < fan_table->ucRevId),
 		"Unsupported fan table format!", return -1);
 
@@ -1313,13 +1704,15 @@ static int ppt_get_num_of_vce_state_table_entries_v1_0(struct pp_hwmgr *hwmgr)
 {
 	const ATOM_Tonga_POWERPLAYTABLE *pp_table = get_powerplay_table(hwmgr);
 	const ATOM_Tonga_VCE_State_Table *vce_state_table;
+	int ret;
 
 
 	if (pp_table == NULL)
 		return 0;
 
-	vce_state_table = (void *)pp_table +
-			le16_to_cpu(pp_table->usVCEStateTableOffset);
+	ret = get_tonga_vce_state_table(hwmgr, pp_table, &vce_state_table);
+	if (ret)
+		return 0;
 
 	return vce_state_table->ucNumEntries;
 }
@@ -1328,18 +1721,39 @@ static int ppt_get_vce_state_table_entry_v1_0(struct pp_hwmgr *hwmgr, uint32_t i
 		struct amd_vce_state *vce_state, void **clock_info, uint32_t *flag)
 {
 	const ATOM_Tonga_VCE_State_Record *vce_state_record;
-	ATOM_Tonga_SCLK_Dependency_Record *sclk_dep_record;
+	ATOM_Tonga_SCLK_Dependency_Record *sclk_dep_record = NULL;
+	ATOM_Polaris_SCLK_Dependency_Record *polaris_sclk_dep_record = NULL;
 	ATOM_Tonga_MCLK_Dependency_Record *mclk_dep_record;
 	ATOM_Tonga_MM_Dependency_Record *mm_dep_record;
 	const ATOM_Tonga_POWERPLAYTABLE *pptable = get_powerplay_table(hwmgr);
-	const ATOM_Tonga_VCE_State_Table *vce_state_table = (ATOM_Tonga_VCE_State_Table *)(((unsigned long)pptable)
-							  + le16_to_cpu(pptable->usVCEStateTableOffset));
-	const ATOM_Tonga_SCLK_Dependency_Table *sclk_dep_table = (ATOM_Tonga_SCLK_Dependency_Table *)(((unsigned long)pptable)
-							  + le16_to_cpu(pptable->usSclkDependencyTableOffset));
-	const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table = (ATOM_Tonga_MCLK_Dependency_Table *)(((unsigned long)pptable)
-							  + le16_to_cpu(pptable->usMclkDependencyTableOffset));
-	const ATOM_Tonga_MM_Dependency_Table *mm_dep_table = (ATOM_Tonga_MM_Dependency_Table *)(((unsigned long)pptable)
-							  + le16_to_cpu(pptable->usMMDependencyTableOffset));
+	const ATOM_Tonga_VCE_State_Table *vce_state_table;
+	const PPTable_Generic_SubTable_Header *sclk_dep_table_header;
+	const ATOM_Tonga_SCLK_Dependency_Table *sclk_dep_table;
+	const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table;
+	const ATOM_Tonga_MM_Dependency_Table *mm_dep_table;
+	int ret;
+
+	if (!pptable)
+		return -EINVAL;
+
+	ret = get_tonga_vce_state_table(hwmgr, pptable, &vce_state_table);
+	if (ret)
+		return ret;
+
+	ret = get_tonga_sclk_dependency_table(hwmgr, pptable,
+					      &sclk_dep_table_header);
+	if (ret)
+		return ret;
+	sclk_dep_table = (const ATOM_Tonga_SCLK_Dependency_Table *)
+		sclk_dep_table_header;
+
+	ret = get_tonga_mclk_dependency_table(hwmgr, pptable, &mclk_dep_table);
+	if (ret)
+		return ret;
+
+	ret = get_tonga_mm_dependency_table(hwmgr, pptable, &mm_dep_table);
+	if (ret)
+		return ret;
 
 	PP_ASSERT_WITH_CODE((i < vce_state_table->ucNumEntries),
 			 "Requested state entry ID is out of range!",
@@ -1348,10 +1762,27 @@ static int ppt_get_vce_state_table_entry_v1_0(struct pp_hwmgr *hwmgr, uint32_t i
 	vce_state_record = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
 					ATOM_Tonga_VCE_State_Record,
 					entries, vce_state_table, i);
-	sclk_dep_record = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
-					ATOM_Tonga_SCLK_Dependency_Record,
-					entries, sclk_dep_table,
-					vce_state_record->ucSCLKIndex);
+	PP_ASSERT_WITH_CODE((vce_state_record->ucSCLKIndex <
+			     sclk_dep_table->ucNumEntries),
+			    "Invalid PowerPlay Table!", return -EINVAL);
+	PP_ASSERT_WITH_CODE((vce_state_record->ucVCEClockIndex <
+			     mm_dep_table->ucNumEntries),
+			    "Invalid PowerPlay Table!", return -EINVAL);
+	PP_ASSERT_WITH_CODE((mclk_dep_table->ucNumEntries != 0),
+			    "Invalid PowerPlay Table!", return -EINVAL);
+
+	if (sclk_dep_table_header->ucRevId < 1)
+		sclk_dep_record = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
+						ATOM_Tonga_SCLK_Dependency_Record,
+						entries, sclk_dep_table,
+						vce_state_record->ucSCLKIndex);
+	else
+		polaris_sclk_dep_record = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
+						ATOM_Polaris_SCLK_Dependency_Record,
+						entries,
+						(ATOM_Polaris_SCLK_Dependency_Table *)
+						sclk_dep_table_header,
+						vce_state_record->ucSCLKIndex);
 	mm_dep_record = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
 					ATOM_Tonga_MM_Dependency_Record,
 					entries, mm_dep_table,
@@ -1360,7 +1791,10 @@ static int ppt_get_vce_state_table_entry_v1_0(struct pp_hwmgr *hwmgr, uint32_t i
 
 	vce_state->evclk = le32_to_cpu(mm_dep_record->ulEClk);
 	vce_state->ecclk = le32_to_cpu(mm_dep_record->ulEClk);
-	vce_state->sclk = le32_to_cpu(sclk_dep_record->ulSclk);
+	if (sclk_dep_record)
+		vce_state->sclk = le32_to_cpu(sclk_dep_record->ulSclk);
+	else
+		vce_state->sclk = le32_to_cpu(polaris_sclk_dep_record->ulSclk);
 
 	if (vce_state_record->ucMCLKIndex >= mclk_dep_table->ucNumEntries)
 		mclk_dep_record = GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
-- 
2.47.3

