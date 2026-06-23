Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145A0CDB46F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 13:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160DF10EB80;
	Tue, 23 Jun 2026 13:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bsliDGvB";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A20310EB6C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 13:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnCg7SMLgprYkW7yZkZ18Tm1SK/9Qz5UNQmEVFYN9dNwaPZduptI/LJhhL2kqY2gJWu62STuth5iybJaFHD3iVUEDJLqSrMREMQaEmqKtllBk+/I9WMBosbn6bgxv1CVQkkHbPZr3swjwbWeMjkSgDBqZKxxrgM15KozvN9Jisi7r4DKZ0O44mCyCUxWbjFSo6AulxQfYgWFLoYhHr9WQgZyNX2xabMdNtsvFw8yGBPCkLNxjy9AVMw6gVuM3CO0y/ldagVIlzJoQ/kaAIBwza0x7RCrIwEHS7JHzxfQPxoOy1ocrPkItse79sP8UrDT/aCz/pmVdY9ASyr25o+x3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=io0B1BTonzW47Dx2rc4pAMMPhbVRTSfuXsBvdl7L99M=;
 b=JZFreEIwoSt0L35rdYD5aV1oLjHiRAkZmGx8jrc5eSNhR3SRJqSfGVxJqzcqkUNivBbDiBC0Zk17pix3ArJpZgHUug0IfpM0I2vCHEbtpb84lDoBvh02BDI7PMfJGzzYosx89TZJd1/ul7HgnZP/HC1//cEb9ENnu0xR4ITkBBtZsd/FySSxEOXCDQGJZ1BoH4EPRIm9nB7I5+1HOigRrsrYC4SwnmuHLB4aaglV/ppP6kvgdeCiaaklWDjBWx+nH/CR+VaIDI2/8hFpbFMR6bXJ0xnbJkf2kT+KTIvdQwduEoaKD5IHOTDTA3cJ8msRo83FDy027unf7uXixhVZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io0B1BTonzW47Dx2rc4pAMMPhbVRTSfuXsBvdl7L99M=;
 b=bsliDGvBlIxfnTkZYLoTbkh0FJr23bYsK14ps68VJ/9fIs49WgmUJfUxhacKzJkbEAhu0gZ2VNQC7fxu6/pf7V9noGZJA7chDQYVzUBQVtZKdO5K0vPq2W7FJ4Wm+bXNWlaWkTDwE86XHEcnAayah+Y645dyQrgdq1GR5Z8iMYQ=
Received: from BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::11)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 13:49:32 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::9c) by BY1P220CA0023.outlook.office365.com
 (2603:10b6:a03:5c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 13:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 13:49:32 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 08:49:30 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v2 2/3] drm/amd/pm: Validate Tonga PPTable subtable bounds
Date: Tue, 23 Jun 2026 21:49:16 +0800
Message-ID: <20260623134917.443011-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623134917.443011-1-kevinyang.wang@amd.com>
References: <20260623134917.443011-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: a6331c5c-844f-4e9d-f769-08ded12e40f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|3023799007|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: r+87nW0XNHo+j1l1ft+cWv8uN7nVCHT3OCwL8bIDr1hhd2SqonASAg6xQXYeXm9boLyvpJULXkCduO8ALWeGWii/VVPazJVDtnYecdbEHfPvF1DTqTn5XN5j8BTQAQQxq4TqGB6gytloXAouDGy3KM9/ks6xKOLI4SdigUotd764i1BubGaP+X/+QrSglIcvzqLehrW5eTID47DOH6hhi9bszOVoSv12yIx/QL/AUYnvwyRoIK+IoeFpyU8kt4860SfZLAABNfIIU4XEBRK6Ug5QITfCexjqujNlHAsmE5Eee+OuyhFOI9gNpr6TaaQ4B5pEf0wY+W6/WonmyuIcOXPxoJ4Tc8x0smS+uB+aDZPYdgaDdexQlO7EGrnWBPaar+9unHPnqBIWlBQjvc/85AhTwa2ZbLIWlIs4ug2IZ8cPMq16tHmCyORSyNhBKHkNNAgj5nL7lqytm8XtypwUWLsamJFs2PaaKu6Pksli5AHOYyKH7FwMXaOf3p8mKd8ctSyloAz7loVHbnxtZOowtCGUfC0YTYgL2qqSISGP4eW52HbvpaG6nDB1Gs6lxJI6jM2lJUj1P0+8RZbQXJDs7NwbXq5CkOByheWT4q2Ujwjhe2AWVBxOWOHwrjeQXRDDRnTHVRK9VGXI5mQcGeLPzEaBo4HucoETt/ybTGjUDGGUsJguR2v1lhwD4cn9GGpu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(3023799007)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4ZQO0OIkbzyMKPiZ4xNHzPOKtz7NC8aZtsLI0fSmKRrRk3l+gFDTVwzZfwuVrG/0X1Vhcgk3c/B86gaPOvg3Kx1MKGivNJ9JM5Uq8KeiU5oNBQyTX1jgwcUYhL8MATj9jCy+3xb7DqC/up9KqrQ2S2azAZfVkFU5FBKtwYhngEQyIVQY4iTs8UpPvm8MfKTErgLC+wE7Y8UMdLRsyWTxEGZuZqC/T4Na1lKLGSbyt5PUTZWvcjVOamFTfimpDZISy97dgUqMyixBkSDUJCwu90g8OC5+unBvManYjNZXQjj1v1Gv1ZPisy1lcF5jiI9SQTXhVpfKDXeXMkUg8Ht+SDnRyKrREdwnJ+reqDQBdYp6sGnV8Nl/S1gBdD1U45tBrQ0xweP3YzjY9elpdIuoB8g/dPXD7B3Ew8NLG4i0ZGeb6YGS83ohWaI268kd6um5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:49:32.0776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6331c5c-844f-4e9d-f769-08ded12e40f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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

v1:
Tonga PPTable parsing also relies on VBIOS offsets, revision fields
and entry counts for several subtables. Malformed data can cause
out-of-bounds reads, while voltage lookup tables can overrun their
fixed-size destination arrays.

Add common bounds helpers and validate fixed subtables, dynamic entry
arrays and revision-specific layouts before consuming voltage lookup,
dependency, PCIE, power-tune, hard-limit, thermal, fan, GPIO, PPM and
VCE state data.

v2:
correct to handle get_tonga_ppm_table() return value.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 606 +++++++++++++++---
 1 file changed, 521 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 94c1e2c10370..78037edb4752 100644
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
 
@@ -275,30 +637,39 @@ static int init_dpm_2_parameters(
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
+			int ret;
+
+			ret = get_tonga_ppm_table(hwmgr, powerplay_table,
+						  &atom_ppm_table);
+			if (!ret &&
+			    get_platform_power_management_table(hwmgr,
+							       atom_ppm_table) == 0) {
 				phm_cap_set(hwmgr->platform_descriptor.platformCaps,
 					PHM_PlatformCaps_EnablePlatformPowerManagement);
 			}
@@ -792,28 +1163,13 @@ static int init_clock_voltage_dependency(
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
@@ -821,29 +1177,58 @@ static int init_clock_voltage_dependency(
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
@@ -864,9 +1249,13 @@ static int init_clock_voltage_dependency(
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
@@ -911,14 +1300,17 @@ static int init_thermal_controller(
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
@@ -946,12 +1338,13 @@ static int init_thermal_controller(
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
 
@@ -1313,13 +1706,15 @@ static int ppt_get_num_of_vce_state_table_entries_v1_0(struct pp_hwmgr *hwmgr)
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
@@ -1328,18 +1723,39 @@ static int ppt_get_vce_state_table_entry_v1_0(struct pp_hwmgr *hwmgr, uint32_t i
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
@@ -1348,10 +1764,27 @@ static int ppt_get_vce_state_table_entry_v1_0(struct pp_hwmgr *hwmgr, uint32_t i
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
@@ -1360,7 +1793,10 @@ static int ppt_get_vce_state_table_entry_v1_0(struct pp_hwmgr *hwmgr, uint32_t i
 
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

