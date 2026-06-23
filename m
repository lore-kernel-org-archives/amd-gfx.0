Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4BBCDB466
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 03:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AEF210E91F;
	Tue, 23 Jun 2026 03:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P9yAjaRV";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E0B10E91F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 03:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEzFHhdI7uyolVJjj+P8VkxsydxTfAaoDYK6gYQeKm3NpBPTFxG0CZSnvK+eGbe8017neFluSrvNoirEjwsaWKIzQN0WSIrORMyI+Jm4C+E59kG8tiffHWLKO5/s5p2tZUrntuAeY5tI1ncTSnt44+fNhqjhwnL3xnVLNoQR1LkKBNkG6Cx4v5zygNJa5xzVEO6+RL/yiah81o8c6RshjBENK4M0C3/CsmbaYE2ZTl7r8KiC4bv1iQ4BitftLhYA2Zsi8/1Eo1ivg1zHYL0xUOXjNFhpk1bQ+m16smZdKXhqThYRtjkl9Ewj7EVnvqq5/7NcBt4BF60RKMRf6QAt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaUL/pI5THohlh3k6HtJ08+g8iUvAZuEcHOBHhAr49w=;
 b=EriA/dl+V2Zb4PIbdBichHOT8wSB8AK+9oUAQvQwA7IN17mKQU+eG6eZWJOVp2m4w5KDLQzKZLunG/Y6R9MwEScJ471iOfY6MPO+u8Jijs6SIlkZaeuFlsZFnJMSjtLz0NiVDe+9l5q9iIwDE9dGRbts0TfnxJscobHsWFHeELS9UfU64yPxTpsB4Xupjp5G4zIuwewYxZJILf7rra3C3/CMOSsjZS42NJghG6djqwF9gXoOF8dh0Yl3dGfGEj2MKoKZPzFhgUOQJFYk92tw/eLK/ttYgX1lQbRYPxpPgmW37Ojc+K+/U+AAE2y6cQbTv1ertuDjCyJJZPseN6fEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaUL/pI5THohlh3k6HtJ08+g8iUvAZuEcHOBHhAr49w=;
 b=P9yAjaRVMoYWx0rSnbp3a6+LbCukB6U2sKx/UTi4X7cmGK4sO/A16OgyDC8lt2Bv4nATIrDXiDUvFB3yF5W1KoopSqIoboZUnsJiwsCHx2sh4QNnG6xXu7VZPjBz59Y2xi2iORP/MFjfeM4ChXshAuHhjcT7av+GMVLGTNUz9/g=
Received: from CY8PR12CA0009.namprd12.prod.outlook.com (2603:10b6:930:4e::29)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 03:42:14 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:4e:cafe::92) by CY8PR12CA0009.outlook.office365.com
 (2603:10b6:930:4e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.21 via Frontend Transport; Tue,
 23 Jun 2026 03:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 23 Jun 2026 03:42:13 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 22:42:10 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 5/5] drm/amd/pm: Validate legacy hwmgr PP table offsets
Date: Tue, 23 Jun 2026 11:41:51 +0800
Message-ID: <20260623034151.263746-5-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 0babe7fa-ee4f-4090-f2c8-08ded0d969fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 12ktlkoi/LdF4yHDtrbfrEVgc+xSD1ofcAkU9TSAEndQwY3vJlo5Wa4iRtaw9ZTRvMI5aPxwYGzOpAb7oEkhZJlsj+evBOUrWKtIm1ik2KUBcl1QghkVPCAOYQyBc9opcZLZatvF7e1UethhDvwNrWG5BA+ttueJrAL22WBhX9cXxsFFwA4H4TkijsiH54nvdp/pXf53JFE6S1AGnX5x+Az571y7LBcB54M1ktap4p7xyhbI1lti3VDw87nBk36LwC09VmB56bpVStPBmt/aMW7pnNL0nPiTDHMw30NeuRt5URIGzUxy21YN3RqsYFac+SkmxdSRTA0CzXuwPkXzEIYlLW3l+d1DyfUYeg4zg/nrG0hvLb60w95DcPbl4gCNsUrNG3spSMfiBND1rFV/WILLzMtQtU4mn0RWUyZRdsmL9/hULoMwl6OfcsHsmwGBxhSyR4x9xCEW6C/QLgh4CqNxqUA3iZtPNN4QpVW1uWUweONYQIvzZKJ9HCh3PEYVjvNVbRVBaIoUUrjQk8UrTqyFTe7iHsxFk3o8bBLOhZieVZc3BcSxUHnYuhjYlIV0D8OJtJgTy5Ah/cZoblJ/yYwUPl5i/0+Mji/sbeef2jZyopV1Ri0q32rYDgsvjdsrDNi2D9hO261ln6Wt3htTuUcvP3iLZ5FvmrPCrfd4Fa0vCDz6WfE2bvSkgul27c6yo/TLkDwFmPq3eg1O7ymrUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OXCvV0+eaPoOqy2SSD/Fk/qJKuu8ifXQC8Z/JuS16faMcnn5SDm+77MGgUWdvCMd0Nb/nQSRuI4RrystrKGGeILJfCf3SlpSgI5rZcb3N4RWH09SRGphw0lbAyWlsVkZCpIMPkeFDVXUuSvlpg58ot/j/BLnr74FtyT6HNYX8lUjH/ixDXHYuElGC7HDk9SMw44A0B1SDUV8Vsf8Hy48CsAS5esd+3Lcxk5i3XxZMl4pLicXTcCDCcaVmyARz+DQnQSNWGdu2AlzyGwr6h+1/qWmOLbl0CMBhpHjRNaQP4fDznak0EY3sDWl6S5M01AEtX3hdvJnwCaKQc8h24HGWEu8ow+jRz6L2E/wlzx/nWs9yD5FiIcyUWI5iHGsCZtq8vcPR1dE/L5vXaih3aO23K4P77mTkygFpMbV+faf0Vz5HCLBr2XaeBLTqQZvKZeO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:42:13.7660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0babe7fa-ee4f-4090-f2c8-08ded0d969fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
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

processpptables.c walks several variable-length PPLIB tables by
using offsets from the VBIOS PowerPlay table. Some paths dereference
extended headers, state arrays, clock arrays, non-clock arrays, or VCE
records before checking that the referenced data is inside the table
buffer.

Add local bounds helpers and validate the relevant offsets and entry
sizes before dereferencing them. This prevents truncated or malformed
legacy PowerPlay tables from driving out-of-bounds reads during hwmgr
initialization and table entry lookup.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../amd/pm/powerplay/hwmgr/processpptables.c  | 446 +++++++++++++-----
 1 file changed, 316 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 00e8f1be87e7..b2e1123844ec 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -47,26 +47,53 @@
 
 #define NUM_BITS_CLOCK_INFO_ARRAY_INDEX 6
 
+static bool pp_table_has_space(struct pp_hwmgr *hwmgr, size_t offset,
+			       size_t size)
+{
+	size_t table_size = hwmgr->soft_pp_table_size;
+
+	return offset <= table_size && size <= table_size - offset;
+}
+
+static const ATOM_PPLIB_EXTENDEDHEADER *
+get_extended_header(struct pp_hwmgr *hwmgr,
+		    const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table,
+		    size_t min_size)
+{
+	const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3;
+	const ATOM_PPLIB_EXTENDEDHEADER *extended_header;
+	u16 offset;
+
+	if (le16_to_cpu(powerplay_table->usTableSize) <
+	    sizeof(ATOM_PPLIB_POWERPLAYTABLE3) ||
+	    !pp_table_has_space(hwmgr, 0, sizeof(ATOM_PPLIB_POWERPLAYTABLE3)))
+		return NULL;
+
+	powerplay_table3 = (const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
+	offset = le16_to_cpu(powerplay_table3->usExtendendedHeaderOffset);
+	if (!offset || !pp_table_has_space(hwmgr, offset,
+					   sizeof(extended_header->usSize)))
+		return NULL;
+
+	extended_header = (const ATOM_PPLIB_EXTENDEDHEADER *)
+		(((unsigned long)powerplay_table) + offset);
+	if (le16_to_cpu(extended_header->usSize) < min_size ||
+	    !pp_table_has_space(hwmgr, offset, min_size))
+		return NULL;
+
+	return extended_header;
+}
+
 static uint16_t get_vce_table_offset(struct pp_hwmgr *hwmgr,
 			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 {
 	uint16_t vce_table_offset = 0;
+	const ATOM_PPLIB_EXTENDEDHEADER *extended_header;
 
-	if (le16_to_cpu(powerplay_table->usTableSize) >=
-	   sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
-		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =
-			(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
-
-		if (powerplay_table3->usExtendendedHeaderOffset > 0) {
-			const ATOM_PPLIB_EXTENDEDHEADER  *extended_header =
-						(const ATOM_PPLIB_EXTENDEDHEADER *)
-						(((unsigned long)powerplay_table3) +
-						le16_to_cpu(powerplay_table3->usExtendendedHeaderOffset));
-			if (le16_to_cpu(extended_header->usSize) >=
-			   SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V2)
-				vce_table_offset = le16_to_cpu(extended_header->usVCETableOffset);
-		}
-	}
+	extended_header = get_extended_header(hwmgr, powerplay_table,
+					      SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V2);
+	if (extended_header)
+		vce_table_offset = le16_to_cpu(extended_header->usVCETableOffset);
 
 	return vce_table_offset;
 }
@@ -93,7 +120,14 @@ static uint16_t get_vce_clock_info_array_size(struct pp_hwmgr *hwmgr,
 	if (table_offset > 0) {
 		const VCEClockInfoArray *p = (const VCEClockInfoArray *)
 			(((unsigned long) powerplay_table) + table_offset);
-		table_size = sizeof(uint8_t) + p->ucNumEntries * sizeof(VCEClockInfo);
+		size_t size;
+
+		if (!pp_table_has_space(hwmgr, table_offset, sizeof(p->ucNumEntries)))
+			return 0;
+
+		size = sizeof(uint8_t) + p->ucNumEntries * sizeof(VCEClockInfo);
+		if (pp_table_has_space(hwmgr, table_offset, size))
+			table_size = size;
 	}
 
 	return table_size;
@@ -104,10 +138,13 @@ static uint16_t get_vce_clock_voltage_limit_table_offset(struct pp_hwmgr *hwmgr,
 {
 	uint16_t table_offset = get_vce_clock_info_array_offset(hwmgr,
 							powerplay_table);
+	u16 table_size;
 
-	if (table_offset > 0)
-		return table_offset + get_vce_clock_info_array_size(hwmgr,
-							powerplay_table);
+	if (table_offset > 0) {
+		table_size = get_vce_clock_info_array_size(hwmgr, powerplay_table);
+		if (table_size)
+			return table_offset + table_size;
+	}
 
 	return 0;
 }
@@ -121,8 +158,15 @@ static uint16_t get_vce_clock_voltage_limit_table_size(struct pp_hwmgr *hwmgr,
 	if (table_offset > 0) {
 		const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *ptable =
 			(const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *)(((unsigned long) powerplay_table) + table_offset);
+		size_t size;
 
-		table_size = sizeof(uint8_t) + ptable->numEntries * sizeof(ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record);
+		if (!pp_table_has_space(hwmgr, table_offset, sizeof(ptable->numEntries)))
+			return 0;
+
+		size = sizeof(uint8_t) +
+			ptable->numEntries * sizeof(ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record);
+		if (pp_table_has_space(hwmgr, table_offset, size))
+			table_size = size;
 	}
 	return table_size;
 }
@@ -130,9 +174,13 @@ static uint16_t get_vce_clock_voltage_limit_table_size(struct pp_hwmgr *hwmgr,
 static uint16_t get_vce_state_table_offset(struct pp_hwmgr *hwmgr, const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 {
 	uint16_t table_offset = get_vce_clock_voltage_limit_table_offset(hwmgr, powerplay_table);
+	u16 table_size;
 
-	if (table_offset > 0)
-		return table_offset + get_vce_clock_voltage_limit_table_size(hwmgr, powerplay_table);
+	if (table_offset > 0) {
+		table_size = get_vce_clock_voltage_limit_table_size(hwmgr, powerplay_table);
+		if (table_size)
+			return table_offset + table_size;
+	}
 
 	return 0;
 }
@@ -143,8 +191,12 @@ static const ATOM_PPLIB_VCE_State_Table *get_vce_state_table(
 {
 	uint16_t table_offset = get_vce_state_table_offset(hwmgr, powerplay_table);
 
-	if (table_offset > 0)
-		return (const ATOM_PPLIB_VCE_State_Table *)(((unsigned long) powerplay_table) + table_offset);
+	if (table_offset > 0) {
+		if (pp_table_has_space(hwmgr, table_offset,
+				       sizeof(((ATOM_PPLIB_VCE_State_Table *)0)->numEntries)))
+			return (const ATOM_PPLIB_VCE_State_Table *)
+				(((unsigned long)powerplay_table) + table_offset);
+	}
 
 	return NULL;
 }
@@ -153,21 +205,13 @@ static uint16_t get_uvd_table_offset(struct pp_hwmgr *hwmgr,
 			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 {
 	uint16_t uvd_table_offset = 0;
+	const ATOM_PPLIB_EXTENDEDHEADER *extended_header;
+
+	extended_header = get_extended_header(hwmgr, powerplay_table,
+					      SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V3);
+	if (extended_header)
+		uvd_table_offset = le16_to_cpu(extended_header->usUVDTableOffset);
 
-	if (le16_to_cpu(powerplay_table->usTableSize) >=
-	    sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
-		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =
-			(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
-		if (powerplay_table3->usExtendendedHeaderOffset > 0) {
-			const ATOM_PPLIB_EXTENDEDHEADER  *extended_header =
-					(const ATOM_PPLIB_EXTENDEDHEADER *)
-					(((unsigned long)powerplay_table3) +
-				le16_to_cpu(powerplay_table3->usExtendendedHeaderOffset));
-			if (le16_to_cpu(extended_header->usSize) >=
-			    SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V3)
-				uvd_table_offset = le16_to_cpu(extended_header->usUVDTableOffset);
-		}
-	}
 	return uvd_table_offset;
 }
 
@@ -193,8 +237,14 @@ static uint16_t get_uvd_clock_info_array_size(struct pp_hwmgr *hwmgr,
 		const UVDClockInfoArray *p = (const UVDClockInfoArray *)
 					(((unsigned long) powerplay_table)
 					+ table_offset);
-		table_size = sizeof(UCHAR) +
-			     p->ucNumEntries * sizeof(UVDClockInfo);
+		size_t size;
+
+		if (!pp_table_has_space(hwmgr, table_offset, sizeof(p->ucNumEntries)))
+			return 0;
+
+		size = sizeof(UCHAR) + p->ucNumEntries * sizeof(UVDClockInfo);
+		if (pp_table_has_space(hwmgr, table_offset, size))
+			table_size = size;
 	}
 
 	return table_size;
@@ -206,10 +256,13 @@ static uint16_t get_uvd_clock_voltage_limit_table_offset(
 {
 	uint16_t table_offset = get_uvd_clock_info_array_offset(hwmgr,
 						     powerplay_table);
+	u16 table_size;
 
-	if (table_offset > 0)
-		return table_offset +
-			get_uvd_clock_info_array_size(hwmgr, powerplay_table);
+	if (table_offset > 0) {
+		table_size = get_uvd_clock_info_array_size(hwmgr, powerplay_table);
+		if (table_size)
+			return table_offset + table_size;
+	}
 
 	return 0;
 }
@@ -218,21 +271,12 @@ static uint16_t get_samu_table_offset(struct pp_hwmgr *hwmgr,
 			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 {
 	uint16_t samu_table_offset = 0;
+	const ATOM_PPLIB_EXTENDEDHEADER *extended_header;
 
-	if (le16_to_cpu(powerplay_table->usTableSize) >=
-	    sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
-		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =
-			(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
-		if (powerplay_table3->usExtendendedHeaderOffset > 0) {
-			const ATOM_PPLIB_EXTENDEDHEADER  *extended_header =
-				(const ATOM_PPLIB_EXTENDEDHEADER *)
-				(((unsigned long)powerplay_table3) +
-				le16_to_cpu(powerplay_table3->usExtendendedHeaderOffset));
-			if (le16_to_cpu(extended_header->usSize) >=
-			    SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V4)
-				samu_table_offset = le16_to_cpu(extended_header->usSAMUTableOffset);
-		}
-	}
+	extended_header = get_extended_header(hwmgr, powerplay_table,
+					      SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V4);
+	if (extended_header)
+		samu_table_offset = le16_to_cpu(extended_header->usSAMUTableOffset);
 
 	return samu_table_offset;
 }
@@ -254,21 +298,12 @@ static uint16_t get_acp_table_offset(struct pp_hwmgr *hwmgr,
 				const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 {
 	uint16_t acp_table_offset = 0;
+	const ATOM_PPLIB_EXTENDEDHEADER *extended_header;
 
-	if (le16_to_cpu(powerplay_table->usTableSize) >=
-	    sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
-		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =
-			(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
-		if (powerplay_table3->usExtendendedHeaderOffset > 0) {
-			const ATOM_PPLIB_EXTENDEDHEADER  *pExtendedHeader =
-				(const ATOM_PPLIB_EXTENDEDHEADER *)
-				(((unsigned long)powerplay_table3) +
-				le16_to_cpu(powerplay_table3->usExtendendedHeaderOffset));
-			if (le16_to_cpu(pExtendedHeader->usSize) >=
-			    SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V6)
-				acp_table_offset = le16_to_cpu(pExtendedHeader->usACPTableOffset);
-		}
-	}
+	extended_header = get_extended_header(hwmgr, powerplay_table,
+					      SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V6);
+	if (extended_header)
+		acp_table_offset = le16_to_cpu(extended_header->usACPTableOffset);
 
 	return acp_table_offset;
 }
@@ -290,21 +325,12 @@ static uint16_t get_cacp_tdp_table_offset(
 				const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 {
 	uint16_t cacTdpTableOffset = 0;
+	const ATOM_PPLIB_EXTENDEDHEADER *extended_header;
 
-	if (le16_to_cpu(powerplay_table->usTableSize) >=
-	    sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
-		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =
-				(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
-		if (powerplay_table3->usExtendendedHeaderOffset > 0) {
-			const ATOM_PPLIB_EXTENDEDHEADER  *pExtendedHeader =
-					(const ATOM_PPLIB_EXTENDEDHEADER *)
-					(((unsigned long)powerplay_table3) +
-				le16_to_cpu(powerplay_table3->usExtendendedHeaderOffset));
-			if (le16_to_cpu(pExtendedHeader->usSize) >=
-			    SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V7)
-				cacTdpTableOffset = le16_to_cpu(pExtendedHeader->usPowerTuneTableOffset);
-		}
-	}
+	extended_header = get_extended_header(hwmgr, powerplay_table,
+					      SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V7);
+	if (extended_header)
+		cacTdpTableOffset = le16_to_cpu(extended_header->usPowerTuneTableOffset);
 
 	return cacTdpTableOffset;
 }
@@ -341,22 +367,13 @@ static uint16_t get_sclk_vdd_gfx_table_offset(struct pp_hwmgr *hwmgr,
 			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 {
 	uint16_t sclk_vdd_gfx_table_offset = 0;
+	const ATOM_PPLIB_EXTENDEDHEADER *extended_header;
 
-	if (le16_to_cpu(powerplay_table->usTableSize) >=
-	    sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
-		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =
-				(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
-		if (powerplay_table3->usExtendendedHeaderOffset > 0) {
-			const ATOM_PPLIB_EXTENDEDHEADER  *pExtendedHeader =
-				(const ATOM_PPLIB_EXTENDEDHEADER *)
-				(((unsigned long)powerplay_table3) +
-				le16_to_cpu(powerplay_table3->usExtendendedHeaderOffset));
-			if (le16_to_cpu(pExtendedHeader->usSize) >=
-			    SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V8)
-				sclk_vdd_gfx_table_offset =
-					le16_to_cpu(pExtendedHeader->usSclkVddgfxTableOffset);
-		}
-	}
+	extended_header = get_extended_header(hwmgr, powerplay_table,
+					      SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V8);
+	if (extended_header)
+		sclk_vdd_gfx_table_offset =
+			le16_to_cpu(extended_header->usSclkVddgfxTableOffset);
 
 	return sclk_vdd_gfx_table_offset;
 }
@@ -770,20 +787,37 @@ static ULONG size_of_entry_v2(ULONG num_dpm_levels)
 }
 
 static const ATOM_PPLIB_STATE_V2 *get_state_entry_v2(
+					struct pp_hwmgr *hwmgr,
 					const StateArray * pstate_arrays,
+					u16 state_array_offset,
 							 ULONG entry_index)
 {
 	ULONG i;
 	const ATOM_PPLIB_STATE_V2 *pstate;
+	size_t entry_offset;
+	size_t entry_size;
+
+	if (entry_index >= pstate_arrays->ucNumEntries)
+		return NULL;
 
+	entry_offset = state_array_offset + sizeof(pstate_arrays->ucNumEntries);
 	pstate = pstate_arrays->states;
-	if (entry_index <= pstate_arrays->ucNumEntries) {
-		for (i = 0; i < entry_index; i++)
-			pstate = (ATOM_PPLIB_STATE_V2 *)(
-						  (unsigned long)pstate +
-			     size_of_entry_v2(pstate->ucNumDPMLevels));
+	for (i = 0; i <= entry_index; i++) {
+		if (!pp_table_has_space(hwmgr, entry_offset, sizeof(*pstate)))
+			return NULL;
+
+		entry_size = size_of_entry_v2(pstate->ucNumDPMLevels);
+		if (!pp_table_has_space(hwmgr, entry_offset, entry_size))
+			return NULL;
+
+		if (i == entry_index)
+			return pstate;
+
+		entry_offset += entry_size;
+		pstate = (ATOM_PPLIB_STATE_V2 *)((unsigned long)pstate + entry_size);
 	}
-	return pstate;
+
+	return NULL;
 }
 
 static const unsigned char soft_dummy_pp_table[] = {
@@ -851,6 +885,8 @@ int pp_tables_get_response_times(struct pp_hwmgr *hwmgr,
 
 	PP_ASSERT_WITH_CODE(NULL != powerplay_tab,
 			    "Missing PowerPlay Table!", return -EINVAL);
+	PP_ASSERT_WITH_CODE(pp_table_has_space(hwmgr, 0, sizeof(*powerplay_tab)),
+			    "Invalid PowerPlay Table!", return -EINVAL);
 
 	*vol_rep_time = (uint32_t)le16_to_cpu(powerplay_tab->usVoltageTime);
 	*bb_rep_time = (uint32_t)le16_to_cpu(powerplay_tab->usBackbiasTime);
@@ -863,13 +899,21 @@ int pp_tables_get_num_of_entries(struct pp_hwmgr *hwmgr,
 {
 	const StateArray *pstate_arrays;
 	const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table = get_powerplay_table(hwmgr);
+	u16 state_array_offset;
 
 	if (powerplay_table == NULL)
 		return -1;
+	if (!pp_table_has_space(hwmgr, 0, sizeof(*powerplay_table)))
+		return -1;
 
 	if (powerplay_table->sHeader.ucTableFormatRevision >= 6) {
+		state_array_offset = le16_to_cpu(powerplay_table->usStateArrayOffset);
+		if (!pp_table_has_space(hwmgr, state_array_offset,
+					sizeof(pstate_arrays->ucNumEntries)))
+			return -1;
+
 		pstate_arrays = (StateArray *)(((unsigned long)powerplay_table) +
-					le16_to_cpu(powerplay_table->usStateArrayOffset));
+					state_array_offset);
 
 		*num_of_entries = (unsigned long)(pstate_arrays->ucNumEntries);
 	} else
@@ -896,49 +940,128 @@ int pp_tables_get_entry(struct pp_hwmgr *hwmgr,
 	const NonClockInfoArray *pnon_clock_arrays;
 
 	const ATOM_PPLIB_STATE *pstate_entry;
+	u16 state_array_offset;
+	u16 clock_info_array_offset;
+	u16 non_clock_info_array_offset;
+	size_t clock_info_offset;
+	size_t non_clock_info_offset;
+	size_t state_entry_offset;
 
 	if (powerplay_table == NULL)
 		return -1;
+	if (!pp_table_has_space(hwmgr, 0, sizeof(*powerplay_table)))
+		return -1;
 
 	ps->classification.bios_index = entry_index;
 
 	if (powerplay_table->sHeader.ucTableFormatRevision >= 6) {
+		state_array_offset = le16_to_cpu(powerplay_table->usStateArrayOffset);
+		if (!pp_table_has_space(hwmgr, state_array_offset,
+					sizeof(pstate_arrays->ucNumEntries)))
+			return -1;
+
 		pstate_arrays = (StateArray *)(((unsigned long)powerplay_table) +
-					le16_to_cpu(powerplay_table->usStateArrayOffset));
+					state_array_offset);
+
+		if (entry_index >= pstate_arrays->ucNumEntries)
+			return -1;
 
-		if (entry_index > pstate_arrays->ucNumEntries)
+		pstate_entry_v2 = get_state_entry_v2(hwmgr, pstate_arrays,
+						     state_array_offset,
+						     entry_index);
+		if (!pstate_entry_v2)
+			return -1;
+
+		clock_info_array_offset =
+			le16_to_cpu(powerplay_table->usClockInfoArrayOffset);
+		if (!pp_table_has_space(hwmgr, clock_info_array_offset,
+					sizeof(*pclock_arrays)))
 			return -1;
 
-		pstate_entry_v2 = get_state_entry_v2(pstate_arrays, entry_index);
 		pclock_arrays = (ClockInfoArray *)(((unsigned long)powerplay_table) +
-					le16_to_cpu(powerplay_table->usClockInfoArrayOffset));
+					clock_info_array_offset);
+		if (!pclock_arrays->ucEntrySize)
+			return -1;
+
+		non_clock_info_array_offset =
+			le16_to_cpu(powerplay_table->usNonClockInfoArrayOffset);
+		if (!pp_table_has_space(hwmgr, non_clock_info_array_offset,
+					sizeof(*pnon_clock_arrays)))
+			return -1;
 
 		pnon_clock_arrays = (NonClockInfoArray *)(((unsigned long)powerplay_table) +
-						le16_to_cpu(powerplay_table->usNonClockInfoArrayOffset));
+						non_clock_info_array_offset);
+		if (!pnon_clock_arrays->ucEntrySize ||
+		    pnon_clock_arrays->ucEntrySize < ATOM_PPLIB_NONCLOCKINFO_VER1 ||
+		    (pnon_clock_arrays->ucEntrySize > ATOM_PPLIB_NONCLOCKINFO_VER1 &&
+		     pnon_clock_arrays->ucEntrySize < ATOM_PPLIB_NONCLOCKINFO_VER2) ||
+		    pstate_entry_v2->nonClockInfoIndex >= pnon_clock_arrays->ucNumEntries)
+			return -1;
 
+		non_clock_info_offset = non_clock_info_array_offset +
+			offsetof(NonClockInfoArray, nonClockInfo) +
+			pstate_entry_v2->nonClockInfoIndex * pnon_clock_arrays->ucEntrySize;
+		if (!pp_table_has_space(hwmgr, non_clock_info_offset,
+					pnon_clock_arrays->ucEntrySize))
+			return -1;
 		pnon_clock_info = (ATOM_PPLIB_NONCLOCK_INFO *)((unsigned long)(pnon_clock_arrays->nonClockInfo) +
 					(pstate_entry_v2->nonClockInfoIndex * pnon_clock_arrays->ucEntrySize));
 
 		result = init_non_clock_fields(hwmgr, ps, pnon_clock_arrays->ucEntrySize, pnon_clock_info);
 
 		for (i = 0; i < pstate_entry_v2->ucNumDPMLevels; i++) {
-			const void *pclock_info = (const void *)(
-							(unsigned long)(pclock_arrays->clockInfo) +
-							(pstate_entry_v2->clockInfoIndex[i] * pclock_arrays->ucEntrySize));
+			const void *pclock_info;
+
+			if (pstate_entry_v2->clockInfoIndex[i] >=
+			    pclock_arrays->ucNumEntries)
+				return -1;
+
+			clock_info_offset = clock_info_array_offset +
+				offsetof(ClockInfoArray, clockInfo) +
+				pstate_entry_v2->clockInfoIndex[i] * pclock_arrays->ucEntrySize;
+			if (!pp_table_has_space(hwmgr, clock_info_offset,
+						pclock_arrays->ucEntrySize))
+				return -1;
+
+			pclock_info = (const void *)
+					((unsigned long)(pclock_arrays->clockInfo) +
+					(pstate_entry_v2->clockInfoIndex[i] *
+					 pclock_arrays->ucEntrySize));
 			res = func(hwmgr, &ps->hardware, i, pclock_info);
 			if ((0 == result) && (0 != res))
 				result = res;
 		}
 	} else {
-		if (entry_index > powerplay_table->ucNumStates)
+		if (entry_index >= powerplay_table->ucNumStates ||
+		    !powerplay_table->ucStateEntrySize ||
+		    !powerplay_table->ucNonClockSize ||
+		    powerplay_table->ucNonClockSize < ATOM_PPLIB_NONCLOCKINFO_VER1 ||
+		    (powerplay_table->ucNonClockSize > ATOM_PPLIB_NONCLOCKINFO_VER1 &&
+		     powerplay_table->ucNonClockSize < ATOM_PPLIB_NONCLOCKINFO_VER2) ||
+		    !powerplay_table->ucClockInfoSize)
+			return -1;
+
+		state_array_offset = le16_to_cpu(powerplay_table->usStateArrayOffset);
+		state_entry_offset = state_array_offset +
+			entry_index * powerplay_table->ucStateEntrySize;
+		if (!pp_table_has_space(hwmgr, state_entry_offset,
+					powerplay_table->ucStateEntrySize))
 			return -1;
 
 		pstate_entry = (ATOM_PPLIB_STATE *)((unsigned long)powerplay_table +
-						    le16_to_cpu(powerplay_table->usStateArrayOffset) +
+						    state_array_offset +
 						    entry_index * powerplay_table->ucStateEntrySize);
 
+		non_clock_info_array_offset =
+			le16_to_cpu(powerplay_table->usNonClockInfoArrayOffset);
+		non_clock_info_offset = non_clock_info_array_offset +
+			pstate_entry->ucNonClockStateIndex * powerplay_table->ucNonClockSize;
+		if (!pp_table_has_space(hwmgr, non_clock_info_offset,
+					powerplay_table->ucNonClockSize))
+			return -1;
+
 		pnon_clock_info = (ATOM_PPLIB_NONCLOCK_INFO *)((unsigned long)powerplay_table +
-						le16_to_cpu(powerplay_table->usNonClockInfoArrayOffset) +
+						non_clock_info_array_offset +
 						pstate_entry->ucNonClockStateIndex *
 						powerplay_table->ucNonClockSize);
 
@@ -947,12 +1070,23 @@ int pp_tables_get_entry(struct pp_hwmgr *hwmgr,
 							pnon_clock_info);
 
 		for (i = 0; i < powerplay_table->ucStateEntrySize-1; i++) {
-			const void *pclock_info = (const void *)((unsigned long)powerplay_table +
-						le16_to_cpu(powerplay_table->usClockInfoArrayOffset) +
+			const void *pclock_info;
+
+			clock_info_array_offset =
+				le16_to_cpu(powerplay_table->usClockInfoArrayOffset);
+			clock_info_offset = clock_info_array_offset +
+				pstate_entry->ucClockStateIndices[i] *
+				powerplay_table->ucClockInfoSize;
+			if (!pp_table_has_space(hwmgr, clock_info_offset,
+						powerplay_table->ucClockInfoSize))
+				return -1;
+
+			pclock_info = (const void *)((unsigned long)powerplay_table +
+						clock_info_array_offset +
 						pstate_entry->ucClockStateIndices[i] *
 						powerplay_table->ucClockInfoSize);
 
-			int res = func(hwmgr, &ps->hardware, i, pclock_info);
+			res = func(hwmgr, &ps->hardware, i, pclock_info);
 
 			if ((0 == result) && (0 != res))
 					result = res;
@@ -1666,21 +1800,70 @@ static int get_vce_state_table_entry(struct pp_hwmgr *hwmgr,
 							unsigned long *flag)
 {
 	const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table = get_powerplay_table(hwmgr);
+	const ATOM_PPLIB_VCE_State_Table *vce_state_table;
+	const ATOM_PPLIB_VCE_State_Record *record;
+	const VCEClockInfoArray *vce_clock_info_array;
+	const VCEClockInfo *vce_clock_info;
+	const ClockInfoArray *clock_arrays;
+	u16 vce_state_table_offset;
+	u16 vce_clock_info_array_offset;
+	u16 clock_info_array_offset;
+	unsigned long clockInfoIndex;
+	size_t record_offset;
+	size_t vce_clock_info_offset;
+	size_t clock_info_offset;
+
+	if (!powerplay_table || !pp_table_has_space(hwmgr, 0, sizeof(*powerplay_table)))
+		return -1;
 
-	const ATOM_PPLIB_VCE_State_Table *vce_state_table = get_vce_state_table(hwmgr, powerplay_table);
+	vce_state_table_offset = get_vce_state_table_offset(hwmgr, powerplay_table);
+	vce_state_table = get_vce_state_table(hwmgr, powerplay_table);
+	if (!vce_state_table || i >= vce_state_table->numEntries)
+		return -1;
+
+	record_offset = vce_state_table_offset +
+		offsetof(ATOM_PPLIB_VCE_State_Table, entries) +
+		i * sizeof(*record);
+	if (!pp_table_has_space(hwmgr, record_offset, sizeof(*record)))
+		return -1;
+
+	record = &vce_state_table->entries[i];
+
+	vce_clock_info_array_offset =
+		get_vce_clock_info_array_offset(hwmgr, powerplay_table);
+	if (!pp_table_has_space(hwmgr, vce_clock_info_array_offset,
+				sizeof(vce_clock_info_array->ucNumEntries)))
+		return -1;
 
-	unsigned short vce_clock_info_array_offset = get_vce_clock_info_array_offset(hwmgr, powerplay_table);
+	vce_clock_info_array = (const VCEClockInfoArray *)
+		(((unsigned long)powerplay_table) + vce_clock_info_array_offset);
+	if (record->ucVCEClockInfoIndex >= vce_clock_info_array->ucNumEntries)
+		return -1;
 
-	const VCEClockInfoArray *vce_clock_info_array = (const VCEClockInfoArray *)(((unsigned long) powerplay_table) + vce_clock_info_array_offset);
+	vce_clock_info_offset = vce_clock_info_array_offset +
+		offsetof(VCEClockInfoArray, entries) +
+		record->ucVCEClockInfoIndex * sizeof(*vce_clock_info);
+	if (!pp_table_has_space(hwmgr, vce_clock_info_offset, sizeof(*vce_clock_info)))
+		return -1;
 
-	const ClockInfoArray *clock_arrays = (ClockInfoArray *)(((unsigned long)powerplay_table) +
-								le16_to_cpu(powerplay_table->usClockInfoArrayOffset));
+	vce_clock_info = &vce_clock_info_array->entries[record->ucVCEClockInfoIndex];
 
-	const ATOM_PPLIB_VCE_State_Record *record = &vce_state_table->entries[i];
+	clock_info_array_offset = le16_to_cpu(powerplay_table->usClockInfoArrayOffset);
+	if (!pp_table_has_space(hwmgr, clock_info_array_offset,
+				sizeof(*clock_arrays)))
+		return -1;
 
-	const VCEClockInfo *vce_clock_info = &vce_clock_info_array->entries[record->ucVCEClockInfoIndex];
+	clock_arrays = (ClockInfoArray *)(((unsigned long)powerplay_table) +
+					  clock_info_array_offset);
+	clockInfoIndex = record->ucClockInfoIndex & 0x3F;
+	if (!clock_arrays->ucEntrySize || clockInfoIndex >= clock_arrays->ucNumEntries)
+		return -1;
 
-	unsigned long clockInfoIndex = record->ucClockInfoIndex & 0x3F;
+	clock_info_offset = clock_info_array_offset +
+		offsetof(ClockInfoArray, clockInfo) +
+		clockInfoIndex * clock_arrays->ucEntrySize;
+	if (!pp_table_has_space(hwmgr, clock_info_offset, clock_arrays->ucEntrySize))
+		return -1;
 
 	*flag = (record->ucClockInfoIndex >> NUM_BITS_CLOCK_INFO_ARRAY_INDEX);
 
@@ -1704,6 +1887,10 @@ static int pp_tables_initialize(struct pp_hwmgr *hwmgr)
 	hwmgr->need_pp_table_upload = true;
 
 	powerplay_table = get_powerplay_table(hwmgr);
+	PP_ASSERT_WITH_CODE((powerplay_table),
+			    "Missing PowerPlay Table!", return -1);
+	PP_ASSERT_WITH_CODE(pp_table_has_space(hwmgr, 0, sizeof(*powerplay_table)),
+			    "Invalid PowerPlay Table!", return -1);
 
 	result = init_powerplay_tables(hwmgr, powerplay_table);
 
@@ -1806,4 +1993,3 @@ const struct pp_table_func pptable_funcs = {
 	.pptable_get_vce_state_table_entry =
 						get_vce_state_table_entry,
 };
-
-- 
2.47.3

