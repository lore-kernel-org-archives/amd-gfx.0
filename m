Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CCDCD98F2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 13:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1258410EB7E;
	Tue, 23 Jun 2026 13:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rV721XxT";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0108210EB6C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 13:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCeZChJS8SP1ciENGCwMIWzWB4IIBJyRgQjcG1TJYdCnQ9A/I/8lXas+16kd0dRbDL29cEDFswQuV85Kq8zY2rCyGM9CN7LI+azBKUFjcX2WPENI8BnBGl6LrMlHGDWyudC+1um0aVMOcBbqBxiFWdgavhgZtfFo62zTluoMJUAIlr+SBxKi2GnswnJcyhjd/4iGcQLACw60htvT3IOp6GuBuH2UxLKvmYuFHX3QGcgyk0gOdMUS8WQb3t5kfFMor3WueKoZj8cDHRQd+GxzSZLS3WrcNTpRLWMbo0GcQDtSnlrXYNo2raw2kysc+aOr2LsHMZQA1TZ9yWTvwnwouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKRSFx8zo/1F7htXe7fSREokHykYXBGMKt2Uc3FdvdI=;
 b=A22M5yy1L53a0ehPU3+94BZzXhAio5+KchhoFLS2/uH2g/pz20zKT8Y6Lg+Rv7EFjatLhM5M1OBy2//wK8adMRMLEIeA05T1l71Hn8p4Y8iliUZGQeTpKWDLC7BgII09REzMuUY6AlcoqKHsBUelUEFQTTvDqvtkhp1vRPo40ND5x//ydrxePrJJmxqyKtjfVxGjGsCMZ0SXJXGD3c0S0taPudqJYFp4LITI1DgcN1JesBxc1UukeaK+r3FYPuKEk7+WlE7Nto8txver3JB3BYqNvY+GGoil2QaAecjxxRLDpyqOQWtw7UeUdzaO0mbwulUljF9l3+v7/yX6BKovGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKRSFx8zo/1F7htXe7fSREokHykYXBGMKt2Uc3FdvdI=;
 b=rV721XxTR8Y1bIVDeijwNrDtZfaukw6xmhy3S9g7HrtI5XJ9mpiaWU1m7+ajqKcvKd5uxm5Cvh1zzkV9MrYancwFUWhS37h8g+n4dIS65vkywAGvayy4ye/to2lVIRtLIJSahZ8V7RxgVR9+vWMP199wjvs8qx/LnO1KA0klF2Q=
Received: from BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::15)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 13:49:36 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::63) by BY1P220CA0019.outlook.office365.com
 (2603:10b6:a03:5c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 13:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 13:49:35 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 08:49:32 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v2 3/3] drm/amd/pm: Validate remaining legacy PPLIB table
 bounds
Date: Tue, 23 Jun 2026 21:49:17 +0800
Message-ID: <20260623134917.443011-3-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bfbd16-d4ce-4d96-72b7-08ded12e42df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|6133799003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xoQFyaTj85nP+HDVAfJ+stZ45YepGwgdMf1XQs6iTsSY812jIwnIbWrw3TlOxUS+mrjS8WaTy4TAU9VHieQIoLB5jKPaBpnid3+gHrEaBvIsIMoFcw+nKjHz6KHxaObN8I1gBh6qANwhsbPdGYB66IukW7pWQbQwpAhT04AoQ+n02vBXatOmgJYpINYbP7dr1cwlhnDU+TIDxI4DHiHVfC9uAyfBldm/qrSXMy5D6zmAWdWBW2BhA++qx8Y9bfzAXSOAJWOqtr0iDTfYR3dL3RMdkrTUMsS1NPb/w6xw378Be7eCTQ7aoSdn7hFBu0rdN172e/aF8W53IdviFPntVAoxtXuNDOT5QaGrmU+erTZba5g94UTHkg2Foplc90LIQSifQmr5tvvZVboex11NSJTgpuo/WjdfDDi5tsMFzf/xYORZEp3+B/PodVUKaujO51mQTrnBnw90q34xOzqX7GgJ1guzzXMZqRZL76V28zc7vYp+dTj8ZKXvZflfNEsPqlALqZsvNOAouK/FjKoCTLbZyqgv6EDwSfuZxlenleHNrZELjrQ5Hjr0avz0doTvaofilwFced/q4ipQdKj3XG3Ea/68DRjK4STZMlg6lkuX/9VgbdBBcS3nCuFoO/nx4IykZPTTgNkeXLyVqUXL37AQF1GrlM264n7bFSGeQB2PSShe8sC7AwaV7LiqkXXNqP7aexLYCzwGUNGkz/M0Yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(6133799003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ov5sNk3yacNcRuPrXw55NW/lwxWCEqjO2VJyrApWFMxW/wPizptaLaw/izktzPJcpI07EyRsrULW8loUngsWaoDyxX0IN7iqjMkz5UOwvcPZhft3drYxvybaBN0TlWxKRqB9y8KWKEylQocOaiGMKXOdY0ChjTMPthzBqpDj1PvWmWmcmD7XJR1olrHZ9sW3+N5lLgV+mwJ0Vfa1FSsW2terAmQGvSlxOMMPQvWniSERy3ggR9flri9m5qRom0phWxx8K+tlbO4PO/7viUHjks1iCpZMGKOb99pyoCpsn+f7wTjM+xAuxMrgcT5DpJlTWqsOl9tZ1Ivj7kl9H845Bt+vsgyBPw4zYh1XXxZ/m0FLGeOG69WjQ2YuX/qXCJeZjR5spN+4xVvDCUgh+Xa+Brmgtm+dFbPW41SX8fFy3bg24mvHbb/TGcGaXbf1imU9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:49:35.2485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bfbd16-d4ce-4d96-72b7-08ded12e42df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
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

V2:
- Keep CAC/PowerTune bounds failures local so later SCLK, MCLK, VDDCI
  and MVDD dependency tables are still parsed.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../amd/pm/powerplay/hwmgr/processpptables.c  | 464 ++++++++++++++----
 1 file changed, 360 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index b2e1123844ec..ec7df2f11ed0 100644
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
@@ -1489,92 +1681,146 @@ static int init_clock_voltage_dependency(struct pp_hwmgr *hwmgr,
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
-
-		if (rev_id > 0) {
-			const ATOM_PPLIB_POWERTUNE_Table_V1 *tune_table =
-				(const ATOM_PPLIB_POWERTUNE_Table_V1 *)
-				(((unsigned long) powerplay_table) + table_offset);
-			result = get_cac_tdp_table(hwmgr, &hwmgr->dyn_state.cac_dtp_table,
-				&tune_table->power_tune_table,
-				le16_to_cpu(tune_table->usMaximumPowerDeliveryLimit));
-			hwmgr->dyn_state.cac_dtp_table->usDefaultTargetOperatingTemp =
-				le16_to_cpu(tune_table->usTjMax);
-		} else {
-			const ATOM_PPLIB_POWERTUNE_Table *tune_table =
-				(const ATOM_PPLIB_POWERTUNE_Table *)
-				(((unsigned long) powerplay_table) + table_offset);
-			result = get_cac_tdp_table(hwmgr,
-				&hwmgr->dyn_state.cac_dtp_table,
-				&tune_table->power_tune_table, 255);
+		const void *tune_table;
+		UCHAR rev_id;
+		int ret;
+
+		if (!pp_table_has_space(hwmgr, table_offset, sizeof(rev_id)))
+			goto skip_cac_tdp;
+
+		rev_id = *(UCHAR *)(((unsigned long)powerplay_table) + table_offset);
+		ret = get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+					 (rev_id > 0) ?
+					 sizeof(ATOM_PPLIB_POWERTUNE_Table_V1) :
+					 sizeof(ATOM_PPLIB_POWERTUNE_Table),
+					 (const void **)&tune_table);
+
+		if (!ret && rev_id > 0) {
+			const ATOM_PPLIB_POWERTUNE_Table_V1 *tune_table_v1 =
+				tune_table;
+			u16 max_power;
+
+			max_power = le16_to_cpu(tune_table_v1->usMaximumPowerDeliveryLimit);
+
+			ret = get_cac_tdp_table(hwmgr,
+						&hwmgr->dyn_state.cac_dtp_table,
+						&tune_table_v1->power_tune_table,
+						max_power);
+			if (!ret)
+				hwmgr->dyn_state.cac_dtp_table->usDefaultTargetOperatingTemp =
+					le16_to_cpu(tune_table_v1->usTjMax);
+		} else if (!ret) {
+			const ATOM_PPLIB_POWERTUNE_Table *tune_table_v0 =
+				tune_table;
+
+			ret = get_cac_tdp_table(hwmgr,
+						&hwmgr->dyn_state.cac_dtp_table,
+						&tune_table_v0->power_tune_table, 255);
 		}
 	}
+skip_cac_tdp:
 
 	if (le16_to_cpu(powerplay_table->usTableSize) >=
 		sizeof(ATOM_PPLIB_POWERPLAYTABLE4)) {
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
@@ -1589,11 +1835,14 @@ static int init_clock_voltage_dependency(struct pp_hwmgr *hwmgr,
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
 
@@ -1601,10 +1850,13 @@ static int init_clock_voltage_dependency(struct pp_hwmgr *hwmgr,
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
@@ -1676,12 +1928,6 @@ static int init_dpm2_parameters(struct pp_hwmgr *hwmgr,
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
@@ -1711,28 +1957,34 @@ static int init_dpm2_parameters(struct pp_hwmgr *hwmgr,
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
@@ -1750,13 +2002,17 @@ static int init_phase_shedding_table(struct pp_hwmgr *hwmgr,
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

