Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D920FCDB47C
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 10:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DEA010EA77;
	Tue, 23 Jun 2026 10:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OjdbqP3c";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C62F10EA75
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 10:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZYRdOLvZvJpyYqpPBAcdNPYaG7ZSVo2LgbzV635ivLMyRciMxiinla+7OiqZwdVa91ipFsy8uljytpRI3Trq8B5NLyxGxAhnELAMxP3wJaJBEDZfbJ2FzEbOOfxd/jCSRqX/6SriWy0dKQ4yRPYbIfK952lUlIns6yLRqHKhMUf5kHHL+zUlfHzFgUIk6k57Ihe8HCNwM7q2U9jqTRd+A78ssk65oNXRFvg+S6+WNWFvXDFT4KhrOfqf/I1WvaefAXlOB/D5MSmxZw0a+sYNR1bUJnpVPxS02aw6h64USQPQBuik6m1OVdP2cafWFZm9ctvHK/K2DPm+mSIpI+6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3Pa+8F5XseVgiEXMTxGhy4IS9B2DJpbquIKs0/e5IM=;
 b=Pe6Na2ty8RyuBR3E+htE75/anA46lu3kkUWMAWNmN8XqZ660fQKLPJhYZvUNFTkJNrKpoKEJ3obNe0Y5KlQhMTyTjfkBIPXcjjavVNbwsq+egqyzgGQH6qOy1pzJ4eoAMZxJ5myDVJuaPbS0BUGzKpQ0UL1b6Am32hG+g+htHGfM37aZpsNZN8nfBlWXcm23Nirenk5hiLTsb/6nB3zhca6Q4vhyXCYPxleUx/lIZaMTn5QHjHeLf5SqDTwrjoFIWJOK//JFzYD0ORnnrt6Pd/arEgJJQ412UjMlEsuXn/tJy2CX23QcPtTDUQa8PG5qyHOoI3tHAoJtPAMbjlYcpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3Pa+8F5XseVgiEXMTxGhy4IS9B2DJpbquIKs0/e5IM=;
 b=OjdbqP3c1EFUVo7/l2Tr2QAHRl53eRgkOiDkFTld4I3N+8q5/Mp3Qs2gvasvnoj59SNq9UIrbkEvo9nJlzN6V0+/XPbXkaJVq8kT7LIUk/4zKa5Bm12gSBcO3l0fRUTIEmi/J7OrOMk6YAvRHL3J9dkL+/50+941e4ttefPcufw=
Received: from CH0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:610:119::15)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 10:23:35 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::14) by CH0PR03CA0364.outlook.office365.com
 (2603:10b6:610:119::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Tue,
 23 Jun 2026 10:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 10:23:34 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 05:23:33 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Validate Vega10 PPTable subtable bounds
Date: Tue, 23 Jun 2026 18:23:17 +0800
Message-ID: <20260623102319.413960-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b8d869-9657-46e0-4abe-08ded1117b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|18002099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: Jk/IL8StZ1qPiQvZNsqz2U/d0+L08cgd3mMRCSaoYhY+cYVOEiDnqE1OeoRuW/2M1U2JUlwFDvYaNwRRyY9eSf8+3LdPt5kyeZDcT27/NZXc+djN//OgGkBflvdpCSD1dcxmpqeyAwFYVhVdkih0/jxv//r6gTM8000OfwctkxV+pMXUmpwnfvtJUGqIRmVIh2VEp3McyhxmOxw1lsH/zZbD1Y5/Bjp3yCo1eJ3gVB5h0SbG+f/IxL3nC2XEk5G3pQGqZ5dD836ZKDYhp/W4bpfDscWkypgXo2t0fJ7PtUC/ChVCJnJ65W0uINWXxUfdSM55jCpBMmbl4UDlDhPyioXlJwKg/ceNzLRKqg6cVFeINRVf037gPtVOq2kV1ltfk93KlfPssN6GFgjX8jb8NIcpbpZkEMdR88KjVEELRMz/nOXfoxRtEHQIsgxZ9XtubkhiKyAwpHmotmuEFBOuoUjcPpdPp6iBhHGIV5VwVpQaHuH37t0c0B5UXRcIewrwuzJ9Q0VCNRDWi6Jt+7w2SaMDCKugHGYrZVptFyz/iQO7eCuog+FsfDVrZg1s78U5rBRfQQNh8XQdSc4v9pjw8G1zFHkelbs+zeg3q1/h6mWnoIK18QG/Zj8O9OVXAkxo8xqndpIXWOisQxAvFbW0K+gW+SMxE+frpvV1uuRvv0eNptiqvhCW6RoShXwE0V+W
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(18002099003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uA/qh10xhaIPnKAGiFWuvtf9eWztJLCWICcQQCo/hMSUlux5iqM+K468D0d9lA3vdqHDsfnBj0qK0/AU15cjyyuhxARbM13yc6eLD6h/xkt9yDxaVdara8Ul26rKdwHyp6jXA9lGVw7DE70DP610ZEFHkGVwVmaM4s1dc3nJwCe4Y9bEKBfHWk4Zli5AaL/YT9bnM/s49XizrfTzn1KbUz4hCveLHWZmrJ39u7xoHlLqB8D/4qPBsWf/fEoYzeUWfuUL/fSwjozd3BtKk7AGxhNsIcwA/7rb/ApLqIbtTmR+w8cjy7zMPpQVM4OuH7D8hCBJ5uYCzvKzWPa57aMsvTeN09JoKkiYorKB9YqS6ejyxN210K1kBRuelUwa4fA1z+MWQ882J6MECRn+4kT/Mk1ppOh5PSvJZhGyVtfayI27RnrudMorBsZQ/a5OaHed
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 10:23:34.8848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b8d869-9657-46e0-4abe-08ded1117b79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
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

Vega10 PPTable parsing uses VBIOS-provided offsets, revision fields
and entry counts to locate subtables. Malformed data can otherwise
drive out-of-bounds reads from soft_pp_table_size, and voltage lookup
tables can overrun their fixed-size destination arrays.

Add shared bounds helpers and validate fixed-size subtables, dynamic
entry arrays and revision-specific layouts before consuming thermal,
fan, power-tune, clock dependency, PCIE, hard-limit and voltage lookup
data.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../powerplay/hwmgr/vega10_processpptables.c  | 564 ++++++++++++++----
 1 file changed, 459 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index 64cff9f4850a..5dc6cd2b0c54 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -63,6 +63,46 @@ static const void *get_powerplay_table(struct pp_hwmgr *hwmgr)
 	return table_address;
 }
 
+static bool vega10_pp_table_has_space(struct pp_hwmgr *hwmgr, size_t offset,
+				      size_t size)
+{
+	size_t table_size = hwmgr->soft_pp_table_size;
+
+	return offset <= table_size && size <= table_size - offset;
+}
+
+static int get_vega10_subtable(struct pp_hwmgr *hwmgr,
+		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+		u16 table_offset, size_t table_size, const void **table)
+{
+	PP_ASSERT_WITH_CODE((table_offset != 0),
+			    "Invalid PowerPlay Table!", return -1);
+	PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+						       table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*table = (const void *)(((unsigned long)powerplay_table) + table_offset);
+
+	return 0;
+}
+
+static int validate_vega10_table_entries(struct pp_hwmgr *hwmgr,
+		u16 table_offset, size_t entries_offset,
+		u8 num_entries, size_t entry_size)
+{
+	size_t table_size;
+
+	PP_ASSERT_WITH_CODE((num_entries != 0),
+			    "Invalid PowerPlay Table!", return -1);
+
+	table_size = entries_offset + num_entries * entry_size;
+	PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+						       table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	return 0;
+}
+
 static int get_vega10_state_array(struct pp_hwmgr *hwmgr,
 	const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
 	const ATOM_Vega10_State_Array **state_array)
@@ -102,6 +142,293 @@ static int get_vega10_state_array(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
+static int get_vega10_gfxclk_dependency_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Vega10_GFXCLK_Dependency_Table **gfxclk_dep_table)
+{
+	const ATOM_Vega10_GFXCLK_Dependency_Table *table;
+	u16 table_offset;
+	size_t table_size;
+	size_t entry_size;
+
+	table_offset = le16_to_cpu(powerplay_table->usGfxclkDependencyTableOffset);
+	if (!table_offset)
+		return -EINVAL;
+
+	PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+						       sizeof(*table))),
+			    "Invalid PowerPlay Table!", return -1);
+
+	table = (const ATOM_Vega10_GFXCLK_Dependency_Table *)
+		(((unsigned long)powerplay_table) + table_offset);
+	PP_ASSERT_WITH_CODE((table->ucNumEntries != 0),
+			    "Invalid PowerPlay Table!", return -1);
+
+	if (table->ucRevId == 0)
+		entry_size = sizeof(ATOM_Vega10_GFXCLK_Dependency_Record);
+	else if (table->ucRevId == 1)
+		entry_size = sizeof(ATOM_Vega10_GFXCLK_Dependency_Record_V2);
+	else
+		PP_ASSERT_WITH_CODE(false,
+			"Unsupported GFXClockDependencyTable Revision!",
+			return -EINVAL);
+
+	table_size = offsetof(ATOM_Vega10_GFXCLK_Dependency_Table, entries) +
+		table->ucNumEntries * entry_size;
+	PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+						       table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*gfxclk_dep_table = table;
+
+	return 0;
+}
+
+static int get_vega10_clk_dependency_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+		u16 table_offset,
+		const ATOM_Vega10_SOCCLK_Dependency_Table **clk_dep_table)
+{
+	const ATOM_Vega10_SOCCLK_Dependency_Table *table;
+	int ret;
+
+	ret = get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+				  sizeof(*table), (const void **)&table);
+	if (ret)
+		return ret;
+
+	ret = validate_vega10_table_entries(hwmgr, table_offset,
+					    offsetof(ATOM_Vega10_SOCCLK_Dependency_Table,
+						     entries),
+					    table->ucNumEntries,
+					    sizeof(ATOM_Vega10_CLK_Dependency_Record));
+	if (ret)
+		return ret;
+
+	*clk_dep_table = table;
+
+	return 0;
+}
+
+static int get_vega10_mclk_dependency_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Vega10_MCLK_Dependency_Table **mclk_dep_table)
+{
+	const ATOM_Vega10_MCLK_Dependency_Table *table;
+	u16 table_offset;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usMclkDependencyTableOffset);
+	ret = get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+				  sizeof(*table), (const void **)&table);
+	if (ret)
+		return ret;
+
+	ret = validate_vega10_table_entries(hwmgr, table_offset,
+					    offsetof(ATOM_Vega10_MCLK_Dependency_Table,
+						     entries),
+					    table->ucNumEntries,
+					    sizeof(ATOM_Vega10_MCLK_Dependency_Record));
+	if (ret)
+		return ret;
+
+	*mclk_dep_table = table;
+
+	return 0;
+}
+
+static int get_vega10_mm_dependency_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Vega10_MM_Dependency_Table **mm_dep_table)
+{
+	const ATOM_Vega10_MM_Dependency_Table *table;
+	u16 table_offset;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usMMDependencyTableOffset);
+	ret = get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+				  sizeof(*table), (const void **)&table);
+	if (ret)
+		return ret;
+
+	ret = validate_vega10_table_entries(hwmgr, table_offset,
+					    offsetof(ATOM_Vega10_MM_Dependency_Table,
+						     entries),
+					    table->ucNumEntries,
+					    sizeof(ATOM_Vega10_MM_Dependency_Record));
+	if (ret)
+		return ret;
+
+	*mm_dep_table = table;
+
+	return 0;
+}
+
+static int get_vega10_pcie_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+		const Vega10_PPTable_Generic_SubTable_Header **pcie_table)
+{
+	const ATOM_Vega10_PCIE_Table *table;
+	u16 table_offset;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usPCIETableOffset);
+	ret = get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+				  sizeof(*table), (const void **)&table);
+	if (ret)
+		return ret;
+
+	if (!table->ucNumEntries) {
+		*pcie_table = (const Vega10_PPTable_Generic_SubTable_Header *)table;
+		return 0;
+	}
+
+	ret = validate_vega10_table_entries(hwmgr, table_offset,
+					    offsetof(ATOM_Vega10_PCIE_Table,
+						     entries),
+					    table->ucNumEntries,
+					    sizeof(ATOM_Vega10_PCIE_Record));
+	if (ret)
+		return ret;
+
+	*pcie_table = (const Vega10_PPTable_Generic_SubTable_Header *)table;
+
+	return 0;
+}
+
+static int get_vega10_hard_limit_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Vega10_Hard_Limit_Table **hard_limit_table)
+{
+	const ATOM_Vega10_Hard_Limit_Table *table;
+	u16 table_offset;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usHardLimitTableOffset);
+	ret = get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+				  sizeof(*table), (const void **)&table);
+	if (ret)
+		return ret;
+
+	ret = validate_vega10_table_entries(hwmgr, table_offset,
+					    offsetof(ATOM_Vega10_Hard_Limit_Table,
+						     entries),
+					    table->ucNumEntries,
+					    sizeof(ATOM_Vega10_Hard_Limit_Record));
+	if (ret)
+		return ret;
+
+	*hard_limit_table = table;
+
+	return 0;
+}
+
+static int get_vega10_thermal_controller_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+		const ATOM_Vega10_Thermal_Controller **thermal_controller)
+{
+	u16 table_offset;
+
+	table_offset = le16_to_cpu(powerplay_table->usThermalControllerOffset);
+
+	return get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+				   sizeof(**thermal_controller),
+				   (const void **)thermal_controller);
+}
+
+static int get_vega10_fan_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+		const Vega10_PPTable_Generic_SubTable_Header **fan_table)
+{
+	const Vega10_PPTable_Generic_SubTable_Header *header;
+	u16 table_offset;
+	size_t table_size;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usFanTableOffset);
+	ret = get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+				  sizeof(*header), (const void **)&header);
+	if (ret)
+		return ret;
+
+	if (header->ucRevId == 10)
+		table_size = sizeof(ATOM_Vega10_Fan_Table);
+	else if (header->ucRevId == 0xb)
+		table_size = sizeof(ATOM_Vega10_Fan_Table_V2);
+	else if (header->ucRevId > 0xb)
+		table_size = sizeof(ATOM_Vega10_Fan_Table_V3);
+	else
+		return -EINVAL;
+
+	PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+						       table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*fan_table = header;
+
+	return 0;
+}
+
+static int get_vega10_power_tune_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+		const Vega10_PPTable_Generic_SubTable_Header **power_tune_table)
+{
+	const Vega10_PPTable_Generic_SubTable_Header *header;
+	u16 table_offset;
+	size_t table_size;
+	int ret;
+
+	table_offset = le16_to_cpu(powerplay_table->usPowerTuneTableOffset);
+	ret = get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+				  sizeof(*header), (const void **)&header);
+	if (ret)
+		return ret;
+
+	if (header->ucRevId == 5)
+		table_size = sizeof(ATOM_Vega10_PowerTune_Table);
+	else if (header->ucRevId == 6)
+		table_size = sizeof(ATOM_Vega10_PowerTune_Table_V2);
+	else
+		table_size = sizeof(ATOM_Vega10_PowerTune_Table_V3);
+
+	PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+						       table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*power_tune_table = header;
+
+	return 0;
+}
+
+static int get_vega10_voltage_lookup_table(struct pp_hwmgr *hwmgr,
+		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+		u16 table_offset, uint32_t max_levels,
+		const ATOM_Vega10_Voltage_Lookup_Table **lookup_table)
+{
+	const ATOM_Vega10_Voltage_Lookup_Table *table;
+	size_t table_size;
+	int ret;
+
+	ret = get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+				  sizeof(*table), (const void **)&table);
+	if (ret)
+		return ret;
+
+	PP_ASSERT_WITH_CODE((table->ucNumEntries != 0 &&
+			     table->ucNumEntries <= max_levels),
+			    "Invalid PowerPlay Table!", return -1);
+
+	table_size = offsetof(ATOM_Vega10_Voltage_Lookup_Table, entries) +
+		table->ucNumEntries * sizeof(ATOM_Vega10_Voltage_Lookup_Record);
+	PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+						       table_size)),
+			    "Invalid PowerPlay Table!", return -1);
+
+	*lookup_table = table;
+
+	return 0;
+}
+
 static int check_powerplay_tables(struct pp_hwmgr *hwmgr,
 	const ATOM_Vega10_POWERPLAYTABLE *powerplay_table)
 {
@@ -149,14 +476,16 @@ static int init_thermal_controller(
 	const ATOM_Vega10_Fan_Table *fan_table_v1;
 	const ATOM_Vega10_Fan_Table_V2 *fan_table_v2;
 	const ATOM_Vega10_Fan_Table_V3 *fan_table_v3;
-
-	thermal_controller = (ATOM_Vega10_Thermal_Controller *)
-			(((unsigned long)powerplay_table) +
-			le16_to_cpu(powerplay_table->usThermalControllerOffset));
+	int ret;
 
 	PP_ASSERT_WITH_CODE((powerplay_table->usThermalControllerOffset != 0),
 			"Thermal controller table not set!", return -EINVAL);
 
+	ret = get_vega10_thermal_controller_table(hwmgr, powerplay_table,
+						  &thermal_controller);
+	if (ret)
+		return ret;
+
 	hwmgr->thermal_controller.ucType = thermal_controller->ucType;
 	hwmgr->thermal_controller.ucI2cLine = thermal_controller->ucI2cLine;
 	hwmgr->thermal_controller.ucI2cAddress = thermal_controller->ucI2cAddress;
@@ -185,9 +514,9 @@ static int init_thermal_controller(
 	if (!powerplay_table->usFanTableOffset)
 		return 0;
 
-	header = (const Vega10_PPTable_Generic_SubTable_Header *)
-			(((unsigned long)powerplay_table) +
-			le16_to_cpu(powerplay_table->usFanTableOffset));
+	ret = get_vega10_fan_table(hwmgr, powerplay_table, &header);
+	if (ret)
+		return ret;
 
 	if (header->ucRevId == 10) {
 		fan_table_v1 = (ATOM_Vega10_Fan_Table *)header;
@@ -332,12 +661,15 @@ static int init_over_drive_limits(
 		struct pp_hwmgr *hwmgr,
 		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table)
 {
-	const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table =
-			(const ATOM_Vega10_GFXCLK_Dependency_Table *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usGfxclkDependencyTableOffset));
+	const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table;
 	bool is_acg_enabled = false;
 	ATOM_Vega10_GFXCLK_Dependency_Record_V2 *patom_record_v2;
+	int ret;
+
+	ret = get_vega10_gfxclk_dependency_table(hwmgr, powerplay_table,
+						 &gfxclk_dep_table);
+	if (ret)
+		return ret;
 
 	if (gfxclk_dep_table->ucRevId == 1) {
 		patom_record_v2 =
@@ -900,51 +1232,13 @@ static int init_powerplay_extended_tables(
 	int result = 0;
 	struct phm_ppt_v2_information *pp_table_info =
 		(struct phm_ppt_v2_information *)(hwmgr->pptable);
-
-	const ATOM_Vega10_MM_Dependency_Table *mm_dependency_table =
-			(const ATOM_Vega10_MM_Dependency_Table *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usMMDependencyTableOffset));
-	const Vega10_PPTable_Generic_SubTable_Header *power_tune_table =
-			(const Vega10_PPTable_Generic_SubTable_Header *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usPowerTuneTableOffset));
-	const ATOM_Vega10_SOCCLK_Dependency_Table *socclk_dep_table =
-			(const ATOM_Vega10_SOCCLK_Dependency_Table *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usSocclkDependencyTableOffset));
-	const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table =
-			(const ATOM_Vega10_GFXCLK_Dependency_Table *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usGfxclkDependencyTableOffset));
-	const ATOM_Vega10_DCEFCLK_Dependency_Table *dcefclk_dep_table =
-			(const ATOM_Vega10_DCEFCLK_Dependency_Table *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usDcefclkDependencyTableOffset));
-	const ATOM_Vega10_MCLK_Dependency_Table *mclk_dep_table =
-			(const ATOM_Vega10_MCLK_Dependency_Table *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usMclkDependencyTableOffset));
-	const ATOM_Vega10_Hard_Limit_Table *hard_limits =
-			(const ATOM_Vega10_Hard_Limit_Table *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usHardLimitTableOffset));
-	const Vega10_PPTable_Generic_SubTable_Header *pcie_table =
-			(const Vega10_PPTable_Generic_SubTable_Header *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usPCIETableOffset));
-	const ATOM_Vega10_PIXCLK_Dependency_Table *pixclk_dep_table =
-			(const ATOM_Vega10_PIXCLK_Dependency_Table *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usPixclkDependencyTableOffset));
-	const ATOM_Vega10_PHYCLK_Dependency_Table *phyclk_dep_table =
-			(const ATOM_Vega10_PHYCLK_Dependency_Table *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usPhyClkDependencyTableOffset));
-	const ATOM_Vega10_DISPCLK_Dependency_Table *dispclk_dep_table =
-			(const ATOM_Vega10_DISPCLK_Dependency_Table *)
-			(((unsigned long) powerplay_table) +
-			le16_to_cpu(powerplay_table->usDispClkDependencyTableOffset));
+	const ATOM_Vega10_MM_Dependency_Table *mm_dependency_table;
+	const Vega10_PPTable_Generic_SubTable_Header *power_tune_table;
+	const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table;
+	const ATOM_Vega10_MCLK_Dependency_Table *mclk_dep_table;
+	const ATOM_Vega10_Hard_Limit_Table *hard_limits;
+	const Vega10_PPTable_Generic_SubTable_Header *pcie_table;
+	const ATOM_Vega10_SOCCLK_Dependency_Table *clk_dep_table;
 
 	pp_table_info->vdd_dep_on_socclk = NULL;
 	pp_table_info->vdd_dep_on_sclk = NULL;
@@ -956,63 +1250,114 @@ static int init_powerplay_extended_tables(
 	pp_table_info->vdd_dep_on_phyclk = NULL;
 	pp_table_info->vdd_dep_on_dispclk = NULL;
 
-	if (powerplay_table->usMMDependencyTableOffset)
-		result = get_mm_clock_voltage_table(hwmgr,
+	if (powerplay_table->usMMDependencyTableOffset) {
+		result = get_vega10_mm_dependency_table(hwmgr, powerplay_table,
+							&mm_dependency_table);
+		if (!result)
+			result = get_mm_clock_voltage_table(hwmgr,
 				&pp_table_info->mm_dep_table,
 				mm_dependency_table);
+	}
 
-	if (!result && powerplay_table->usPowerTuneTableOffset)
-		result = get_tdp_table(hwmgr,
+	if (!result && powerplay_table->usPowerTuneTableOffset) {
+		result = get_vega10_power_tune_table(hwmgr, powerplay_table,
+						     &power_tune_table);
+		if (!result)
+			result = get_tdp_table(hwmgr,
 				&pp_table_info->tdp_table,
 				power_tune_table);
+	}
 
-	if (!result && powerplay_table->usSocclkDependencyTableOffset)
-		result = get_socclk_voltage_dependency_table(hwmgr,
+	if (!result && powerplay_table->usSocclkDependencyTableOffset) {
+		result = get_vega10_clk_dependency_table(hwmgr, powerplay_table,
+				le16_to_cpu(powerplay_table->usSocclkDependencyTableOffset),
+				&clk_dep_table);
+		if (!result)
+			result = get_socclk_voltage_dependency_table(hwmgr,
 				&pp_table_info->vdd_dep_on_socclk,
-				socclk_dep_table);
+				(const ATOM_Vega10_SOCCLK_Dependency_Table *)
+				clk_dep_table);
+	}
 
-	if (!result && powerplay_table->usGfxclkDependencyTableOffset)
-		result = get_gfxclk_voltage_dependency_table(hwmgr,
-				&pp_table_info->vdd_dep_on_sclk,
-				gfxclk_dep_table);
+	if (!result && powerplay_table->usGfxclkDependencyTableOffset) {
+		result = get_vega10_gfxclk_dependency_table(hwmgr,
+			powerplay_table, &gfxclk_dep_table);
+		if (!result)
+			result = get_gfxclk_voltage_dependency_table(hwmgr,
+					&pp_table_info->vdd_dep_on_sclk,
+					gfxclk_dep_table);
+	}
 
-	if (!result && powerplay_table->usPixclkDependencyTableOffset)
-		result = get_pix_clk_voltage_dependency_table(hwmgr,
+	if (!result && powerplay_table->usPixclkDependencyTableOffset) {
+		result = get_vega10_clk_dependency_table(hwmgr, powerplay_table,
+				le16_to_cpu(powerplay_table->usPixclkDependencyTableOffset),
+				&clk_dep_table);
+		if (!result)
+			result = get_pix_clk_voltage_dependency_table(hwmgr,
 				&pp_table_info->vdd_dep_on_pixclk,
 				(const ATOM_Vega10_PIXCLK_Dependency_Table *)
-				pixclk_dep_table);
+				clk_dep_table);
+	}
 
-	if (!result && powerplay_table->usPhyClkDependencyTableOffset)
-		result = get_pix_clk_voltage_dependency_table(hwmgr,
+	if (!result && powerplay_table->usPhyClkDependencyTableOffset) {
+		result = get_vega10_clk_dependency_table(hwmgr, powerplay_table,
+				le16_to_cpu(powerplay_table->usPhyClkDependencyTableOffset),
+				&clk_dep_table);
+		if (!result)
+			result = get_pix_clk_voltage_dependency_table(hwmgr,
 				&pp_table_info->vdd_dep_on_phyclk,
 				(const ATOM_Vega10_PIXCLK_Dependency_Table *)
-				phyclk_dep_table);
+				clk_dep_table);
+	}
 
-	if (!result && powerplay_table->usDispClkDependencyTableOffset)
-		result = get_pix_clk_voltage_dependency_table(hwmgr,
+	if (!result && powerplay_table->usDispClkDependencyTableOffset) {
+		result = get_vega10_clk_dependency_table(hwmgr, powerplay_table,
+				le16_to_cpu(powerplay_table->usDispClkDependencyTableOffset),
+				&clk_dep_table);
+		if (!result)
+			result = get_pix_clk_voltage_dependency_table(hwmgr,
 				&pp_table_info->vdd_dep_on_dispclk,
 				(const ATOM_Vega10_PIXCLK_Dependency_Table *)
-				dispclk_dep_table);
+				clk_dep_table);
+	}
 
-	if (!result && powerplay_table->usDcefclkDependencyTableOffset)
-		result = get_dcefclk_voltage_dependency_table(hwmgr,
+	if (!result && powerplay_table->usDcefclkDependencyTableOffset) {
+		result = get_vega10_clk_dependency_table(hwmgr, powerplay_table,
+				le16_to_cpu(powerplay_table->usDcefclkDependencyTableOffset),
+				&clk_dep_table);
+		if (!result)
+			result = get_dcefclk_voltage_dependency_table(hwmgr,
 				&pp_table_info->vdd_dep_on_dcefclk,
-				dcefclk_dep_table);
+				(const ATOM_Vega10_DCEFCLK_Dependency_Table *)
+				clk_dep_table);
+	}
 
-	if (!result && powerplay_table->usMclkDependencyTableOffset)
-		result = get_mclk_voltage_dependency_table(hwmgr,
+	if (!result && powerplay_table->usMclkDependencyTableOffset) {
+		result = get_vega10_mclk_dependency_table(hwmgr, powerplay_table,
+							  &mclk_dep_table);
+		if (!result)
+			result = get_mclk_voltage_dependency_table(hwmgr,
 				&pp_table_info->vdd_dep_on_mclk,
 				mclk_dep_table);
+	}
 
-	if (!result && powerplay_table->usPCIETableOffset)
-		result = get_pcie_table(hwmgr,
+	if (!result && powerplay_table->usPCIETableOffset) {
+		result = get_vega10_pcie_table(hwmgr, powerplay_table,
+					       &pcie_table);
+		if (!result)
+			result = get_pcie_table(hwmgr,
 				&pp_table_info->pcie_table,
 				pcie_table);
+	}
 
-	if (!result && powerplay_table->usHardLimitTableOffset)
-		result = get_hard_limits(hwmgr,
+	if (!result && powerplay_table->usHardLimitTableOffset) {
+		result = get_vega10_hard_limit_table(hwmgr, powerplay_table,
+						     &hard_limits);
+		if (!result)
+			result = get_hard_limits(hwmgr,
 				&pp_table_info->max_clock_voltage_on_dc,
 				hard_limits);
+	}
 
 	hwmgr->dyn_state.max_clock_voltage_on_dc.sclk =
 			pp_table_info->max_clock_voltage_on_dc.sclk;
@@ -1140,30 +1485,39 @@ static int init_dpm_2_parameters(
 	}
 
 	if (powerplay_table->usVddcLookupTableOffset) {
-		const ATOM_Vega10_Voltage_Lookup_Table *vddc_table =
-				(ATOM_Vega10_Voltage_Lookup_Table *)
-				(((unsigned long)powerplay_table) +
-				le16_to_cpu(powerplay_table->usVddcLookupTableOffset));
-		result = get_vddc_lookup_table(hwmgr,
-				&pp_table_info->vddc_lookup_table, vddc_table, 8);
+		const ATOM_Vega10_Voltage_Lookup_Table *vddc_table;
+
+		result = get_vega10_voltage_lookup_table(hwmgr, powerplay_table,
+				le16_to_cpu(powerplay_table->usVddcLookupTableOffset),
+				8, &vddc_table);
+		if (!result)
+			result = get_vddc_lookup_table(hwmgr,
+					&pp_table_info->vddc_lookup_table,
+					vddc_table, 8);
 	}
 
-	if (powerplay_table->usVddmemLookupTableOffset) {
-		const ATOM_Vega10_Voltage_Lookup_Table *vdd_mem_table =
-				(ATOM_Vega10_Voltage_Lookup_Table *)
-				(((unsigned long)powerplay_table) +
-				le16_to_cpu(powerplay_table->usVddmemLookupTableOffset));
-		result = get_vddc_lookup_table(hwmgr,
-				&pp_table_info->vddmem_lookup_table, vdd_mem_table, 4);
+	if (!result && powerplay_table->usVddmemLookupTableOffset) {
+		const ATOM_Vega10_Voltage_Lookup_Table *vdd_mem_table;
+
+		result = get_vega10_voltage_lookup_table(hwmgr, powerplay_table,
+				le16_to_cpu(powerplay_table->usVddmemLookupTableOffset),
+				4, &vdd_mem_table);
+		if (!result)
+			result = get_vddc_lookup_table(hwmgr,
+					&pp_table_info->vddmem_lookup_table,
+					vdd_mem_table, 4);
 	}
 
-	if (powerplay_table->usVddciLookupTableOffset) {
-		const ATOM_Vega10_Voltage_Lookup_Table *vddci_table =
-				(ATOM_Vega10_Voltage_Lookup_Table *)
-				(((unsigned long)powerplay_table) +
-				le16_to_cpu(powerplay_table->usVddciLookupTableOffset));
-		result = get_vddc_lookup_table(hwmgr,
-				&pp_table_info->vddci_lookup_table, vddci_table, 4);
+	if (!result && powerplay_table->usVddciLookupTableOffset) {
+		const ATOM_Vega10_Voltage_Lookup_Table *vddci_table;
+
+		result = get_vega10_voltage_lookup_table(hwmgr, powerplay_table,
+				le16_to_cpu(powerplay_table->usVddciLookupTableOffset),
+				4, &vddci_table);
+		if (!result)
+			result = get_vddc_lookup_table(hwmgr,
+					&pp_table_info->vddci_lookup_table,
+					vddci_table, 4);
 	}
 
 	return result;
-- 
2.47.3

