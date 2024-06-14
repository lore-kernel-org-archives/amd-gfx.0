Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C913C27C77
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 17:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1CDE10EDF5;
	Fri, 14 Jun 2024 17:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4G8QJJ0n";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 935DF10EDF5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 17:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6QpFqOUM8FFXhhz78j+ttaJhkVVHatPRXYuM0KPMSgwnJXX8PPKKkZTmb28qvUgSldPTCXXLl7HF4V+3i8BqAOWtMu1G7fO+PQQ0R6gI7xprzHeLHSFW1AFg/XcH8JaGMcrbmCmFanZemLqh5rB7wFMYptEafgp9ViGvs2BckwxSbybDZq9YuPX2o9py1IkG8zlEwKx14204m5Q4/B8GEpCSXV64na961bQ2ClWcCMpOEi96wduDWnxsfz5nHMwjNXo7jjFu3mtCD/3WoGqNzWKivN9fpLLRkgKi3EpvAhFULjP2b3pzbHfCrRvb6jjm1ePlEZpwypoLOzbnLNZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qafqegoDU0q+QRNf41r7O4PQ2cWxQrHGyV7wCWutZtk=;
 b=MYK+dGPVHW8ny8kxDxPEDjc22i+OTTvRJfmSMVqYwZ+2fiGVYNt0vov/X9JR4R40DPMdI34nJOJ/y9XVvI6cawUhVSBgcCZRGWZpomNpihCH7ymP9xWVHE0ItIaA4ko9IUAw60+JyCWJVAgTgN8MaWT3/oQlD16mbSUOZnoe1vX8hZOV33o2cVteDVJDf2cvD5aT5ZBLndzg7ivQNrzMuFbfwcmjC9fVdKqoagfDvXjBheqqduuvx2X1J2SfCj0CIOg06EWkAmHi5q4gfgfTISmF2UNY2wo5MIQyzV3/c0zQYH8Lt8gS2w183cVXRyfCg0zYXWSc6XuGSUid8UCFUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qafqegoDU0q+QRNf41r7O4PQ2cWxQrHGyV7wCWutZtk=;
 b=4G8QJJ0nSrzXahtQL7ODMZH8fgEU0uwgax3LEXbGmdxe0ITvAUqN4Umcqb/ChguJDfdE610DiJ/71bIKIHiKDcKbei8xcHzQGp2h2W8tk9vlryjkQGwb78wUXINzjgWqGaO6Q1x4IeANrUdgP3QksO+lhcQA5xs4lEp+aQMYmks=
Received: from SJ0PR13CA0073.namprd13.prod.outlook.com (2603:10b6:a03:2c4::18)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 17:06:03 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::9f) by SJ0PR13CA0073.outlook.office365.com
 (2603:10b6:a03:2c4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Fri, 14 Jun 2024 17:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 17:06:03 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 12:06:01 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: powerplay: Add `__counted_by` attribute for
 flexible arrays
Date: Fri, 14 Jun 2024 12:05:51 -0500
Message-ID: <20240614170551.6195-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614170551.6195-1-mario.limonciello@amd.com>
References: <20240614170551.6195-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: c14a0907-0409-4223-6a4d-08dc8c9445f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DbEd25afrnGo6sIH0g48VBmi0CscVJSgpptAAP2/PsaopRNVP0TQFo3EP+8b?=
 =?us-ascii?Q?7/sjPeloKBcfDlfQkdBo09/AjuYWJPRrH6AuIh/USqwwhkF9WcLIAhUYH2VX?=
 =?us-ascii?Q?/dNYy22jNtgV6iKxDLqkr0cRwxSmkKmGiFz7fqcemCS9Q0E/yTj+dN5tSy0A?=
 =?us-ascii?Q?DMq7Cjwa6v5myLP1H3BIEyKRMXuLYLFQOD4U0qlM1q3LCMHlqDfUt1aYaBob?=
 =?us-ascii?Q?HmaIdupBJq9h0/fjWOmB1ZeoZC8Mfha6jwCWUlYDfC3zps+Rgofj5+fy8OP/?=
 =?us-ascii?Q?52z7j/xWgMIN8Q7sAq1P02MUXuviaxpgtMYwmcOzhG9Wnin5zJ5KRoL+AU5j?=
 =?us-ascii?Q?dd0HA7knDTrByukLP9etJdZw79CZMq9D+Kq5d4HO9S7Sb7VFgQSmMvuAWA63?=
 =?us-ascii?Q?8/sDMfy9H235axyX3PiAbyB8ZBIcIrvUFsGHvFMO87Xh698AeCtE40hOAUCf?=
 =?us-ascii?Q?FJRu34FjyAsqJO5ftgPp2f81PKZ+etdEF902P4eiHNW/DSHBLtYd3nXJ2UNk?=
 =?us-ascii?Q?+jfUBqcpRjRypM3ziBILTGts864zzQU9TuL0GUA9cqw1oqmbTD0IP33L1VSM?=
 =?us-ascii?Q?jtIfb3kc+aGiAEpHO9fnYU0sGNd6FK7dX8qBcqUiVDyaTcDyA4e6gy/swv5v?=
 =?us-ascii?Q?TzHA6c+n3PMecRbmHzBs4pLZraa9XuuAaV1rvrWfyUDXu9s21azPUMf6Inf5?=
 =?us-ascii?Q?fj0RQooYgh4u7LE2d2yXRmrczjfWdkDUAE6Xlw3x7J40u+URcFwKuD10o6wt?=
 =?us-ascii?Q?J95lFkLvgFqYQy6JNo1M7z9UtQmBE0KxktL1kMeNm4jptEfGIGs7XDK6Pdr+?=
 =?us-ascii?Q?NnHnzK7ECxpaMbLDiqx1BusJSF6fVVdLqXbfytjhRMdRDRhBYJFjz9LaLomX?=
 =?us-ascii?Q?2+wGSTMfkPUQS/+DRt58aPdk2fDv0zzYdZur6p3gxDXIEFu+KcLGVA99wQyi?=
 =?us-ascii?Q?gFs1jVvjEeV/Ui3gMONME5KSkQUz2jbAYh5tJDcRC/wf/aIJmED/8r4XC6wi?=
 =?us-ascii?Q?qiM4CVXFCqx/kEwHRh20XLHcePXBztPsqyifvdEiZkuGXfQVxFumbQXcLGLM?=
 =?us-ascii?Q?rALB7EZI9a+6ZZLNuH4IBlElqSn1wwa3EfkiZy0LHFoJ0sJGcLoN1LS+wUid?=
 =?us-ascii?Q?oGFlyz0tBawpaQtG96jhfYaVIkvjokX81wBwpcs7N5bzjMS/SrXI0tmsdSDe?=
 =?us-ascii?Q?Eidug2XpbwbjeTvSjycfNl4MpmJ6cIRvaa+8J8H3XIwfNvXxf7Q2Y9Kf3qzs?=
 =?us-ascii?Q?kodyaOfn8jkHOJOLFGaZhvRgiVymWLdjqaDLICAkVD0IccEgGmsNUCG1Z0J8?=
 =?us-ascii?Q?zZS3vB5vgJlWy7NuHHKmXOeeCeL+TU4MARVWQhUgY7eX03fW5bwg6GFf468o?=
 =?us-ascii?Q?FNkiWWvks4UXsuSYRYdUvRwzEpr7eRDeDtkg34G0tTsWElYvdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 17:06:03.2828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14a0907-0409-4223-6a4d-08dc8c9445f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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

This attribute is used to hint the length of flexible arrays to
compiler and sanitizers.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h | 36 +++++++++---------
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  | 38 +++++++++----------
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
index 2cf2a7b12623..7711e892c31f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
@@ -163,8 +163,8 @@ typedef struct _ATOM_Tonga_State {
 
 typedef struct _ATOM_Tonga_State_Array {
 	UCHAR ucRevId;
-	UCHAR ucNumEntries;		/* Number of entries. */
-	ATOM_Tonga_State entries[];	/* Dynamically allocate entries. */
+	UCHAR ucNumEntries;
+	ATOM_Tonga_State entries[] __counted_by(ucNumEntries);
 } ATOM_Tonga_State_Array;
 
 typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
@@ -178,8 +178,8 @@ typedef struct _ATOM_Tonga_MCLK_Dependency_Record {
 
 typedef struct _ATOM_Tonga_MCLK_Dependency_Table {
 	UCHAR ucRevId;
-	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_MCLK_Dependency_Record entries[];				/* Dynamically allocate entries. */
+	UCHAR ucNumEntries;
+	ATOM_Tonga_MCLK_Dependency_Record entries[] __counted_by(ucNumEntries);
 } ATOM_Tonga_MCLK_Dependency_Table;
 
 typedef struct _ATOM_Tonga_SCLK_Dependency_Record {
@@ -193,8 +193,8 @@ typedef struct _ATOM_Tonga_SCLK_Dependency_Record {
 
 typedef struct _ATOM_Tonga_SCLK_Dependency_Table {
 	UCHAR ucRevId;
-	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_SCLK_Dependency_Record entries[];				 /* Dynamically allocate entries. */
+	UCHAR ucNumEntries;
+	ATOM_Tonga_SCLK_Dependency_Record entries[] __counted_by(ucNumEntries);
 } ATOM_Tonga_SCLK_Dependency_Table;
 
 typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
@@ -209,8 +209,8 @@ typedef struct _ATOM_Polaris_SCLK_Dependency_Record {
 
 typedef struct _ATOM_Polaris_SCLK_Dependency_Table {
 	UCHAR ucRevId;
-	UCHAR ucNumEntries;							/* Number of entries. */
-	ATOM_Polaris_SCLK_Dependency_Record entries[];				 /* Dynamically allocate entries. */
+	UCHAR ucNumEntries;
+	ATOM_Polaris_SCLK_Dependency_Record entries[] __counted_by(ucNumEntries);
 } ATOM_Polaris_SCLK_Dependency_Table;
 
 typedef struct _ATOM_Tonga_PCIE_Record {
@@ -221,8 +221,8 @@ typedef struct _ATOM_Tonga_PCIE_Record {
 
 typedef struct _ATOM_Tonga_PCIE_Table {
 	UCHAR ucRevId;
-	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_PCIE_Record entries[];							/* Dynamically allocate entries. */
+	UCHAR ucNumEntries;
+	ATOM_Tonga_PCIE_Record entries[] __counted_by(ucNumEntries);
 } ATOM_Tonga_PCIE_Table;
 
 typedef struct _ATOM_Polaris10_PCIE_Record {
@@ -234,8 +234,8 @@ typedef struct _ATOM_Polaris10_PCIE_Record {
 
 typedef struct _ATOM_Polaris10_PCIE_Table {
 	UCHAR ucRevId;
-	UCHAR ucNumEntries;                                         /* Number of entries. */
-	ATOM_Polaris10_PCIE_Record entries[];                      /* Dynamically allocate entries. */
+	UCHAR ucNumEntries;
+	ATOM_Polaris10_PCIE_Record entries[] __counted_by(ucNumEntries);
 } ATOM_Polaris10_PCIE_Table;
 
 
@@ -251,8 +251,8 @@ typedef struct _ATOM_Tonga_MM_Dependency_Record {
 
 typedef struct _ATOM_Tonga_MM_Dependency_Table {
 	UCHAR ucRevId;
-	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_MM_Dependency_Record entries[]; 			   /* Dynamically allocate entries. */
+	UCHAR ucNumEntries;
+	ATOM_Tonga_MM_Dependency_Record entries[] __counted_by(ucNumEntries);
 } ATOM_Tonga_MM_Dependency_Table;
 
 typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
@@ -264,8 +264,8 @@ typedef struct _ATOM_Tonga_Voltage_Lookup_Record {
 
 typedef struct _ATOM_Tonga_Voltage_Lookup_Table {
 	UCHAR ucRevId;
-	UCHAR ucNumEntries; 										/* Number of entries. */
-	ATOM_Tonga_Voltage_Lookup_Record entries[];				/* Dynamically allocate entries. */
+	UCHAR ucNumEntries;
+	ATOM_Tonga_Voltage_Lookup_Record entries[] __counted_by(ucNumEntries);
 } ATOM_Tonga_Voltage_Lookup_Table;
 
 typedef struct _ATOM_Tonga_Fan_Table {
@@ -367,7 +367,7 @@ typedef struct _ATOM_Tonga_VCE_State_Record {
 typedef struct _ATOM_Tonga_VCE_State_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;
-	ATOM_Tonga_VCE_State_Record entries[];
+	ATOM_Tonga_VCE_State_Record entries[] __counted_by(ucNumEntries);
 } ATOM_Tonga_VCE_State_Table;
 
 typedef struct _ATOM_Tonga_PowerTune_Table {
@@ -481,7 +481,7 @@ typedef struct _ATOM_Tonga_Hard_Limit_Record {
 typedef struct _ATOM_Tonga_Hard_Limit_Table {
 	UCHAR ucRevId;
 	UCHAR ucNumEntries;
-	ATOM_Tonga_Hard_Limit_Record entries[];
+	ATOM_Tonga_Hard_Limit_Record entries[] __counted_by(ucNumEntries);
 } ATOM_Tonga_Hard_Limit_Table;
 
 typedef struct _ATOM_Tonga_GPIO_Table {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 69928a4a074b..9118fcddbf11 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -60,7 +60,7 @@ struct vi_dpm_level {
 
 struct vi_dpm_table {
 	uint32_t count;
-	struct vi_dpm_level dpm_level[];
+	struct vi_dpm_level dpm_level[] __counted_by(count);
 };
 
 #define PCIE_PERF_REQ_REMOVE_REGISTRY   0
@@ -91,7 +91,7 @@ struct phm_set_power_state_input {
 
 struct phm_clock_array {
 	uint32_t count;
-	uint32_t values[];
+	uint32_t values[] __counted_by(count);
 };
 
 struct phm_clock_voltage_dependency_record {
@@ -122,8 +122,8 @@ struct phm_acpclock_voltage_dependency_record {
 };
 
 struct phm_clock_voltage_dependency_table {
-	uint32_t count;							/* Number of entries. */
-	struct phm_clock_voltage_dependency_record entries[];		/* Dynamically allocate count entries. */
+	uint32_t count;
+	struct phm_clock_voltage_dependency_record entries[] __counted_by(count);
 };
 
 struct phm_phase_shedding_limits_record {
@@ -140,7 +140,7 @@ struct phm_uvd_clock_voltage_dependency_record {
 
 struct phm_uvd_clock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_uvd_clock_voltage_dependency_record entries[];
+	struct phm_uvd_clock_voltage_dependency_record entries[] __counted_by(count);
 };
 
 struct phm_acp_clock_voltage_dependency_record {
@@ -150,7 +150,7 @@ struct phm_acp_clock_voltage_dependency_record {
 
 struct phm_acp_clock_voltage_dependency_table {
 	uint32_t count;
-	struct phm_acp_clock_voltage_dependency_record entries[];
+	struct phm_acp_clock_voltage_dependency_record entries[] __counted_by(count);
 };
 
 struct phm_vce_clock_voltage_dependency_record {
@@ -160,33 +160,33 @@ struct phm_vce_clock_voltage_dependency_record {
 };
 
 struct phm_phase_shedding_limits_table {
-	uint32_t                           count;
-	struct phm_phase_shedding_limits_record  entries[];
+	uint32_t count;
+	struct phm_phase_shedding_limits_record  entries[] __counted_by(count);
 };
 
 struct phm_vceclock_voltage_dependency_table {
-	uint8_t count;                                    /* Number of entries. */
-	struct phm_vceclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	uint8_t count;
+	struct phm_vceclock_voltage_dependency_record entries[] __counted_by(count);
 };
 
 struct phm_uvdclock_voltage_dependency_table {
-	uint8_t count;                                    /* Number of entries. */
-	struct phm_uvdclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	uint8_t count;
+	struct phm_uvdclock_voltage_dependency_record entries[] __counted_by(count);
 };
 
 struct phm_samuclock_voltage_dependency_table {
-	uint8_t count;                                    /* Number of entries. */
-	struct phm_samuclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	uint8_t count;
+	struct phm_samuclock_voltage_dependency_record entries[] __counted_by(count);
 };
 
 struct phm_acpclock_voltage_dependency_table {
-	uint32_t count;                                    /* Number of entries. */
-	struct phm_acpclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	uint32_t count;
+	struct phm_acpclock_voltage_dependency_record entries[] __counted_by(count);
 };
 
 struct phm_vce_clock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_vce_clock_voltage_dependency_record entries[];
+	struct phm_vce_clock_voltage_dependency_record entries[] __counted_by(count);
 };
 
 
@@ -393,7 +393,7 @@ union phm_cac_leakage_record {
 
 struct phm_cac_leakage_table {
 	uint32_t count;
-	union phm_cac_leakage_record entries[];
+	union phm_cac_leakage_record entries[] __counted_by(count);
 };
 
 struct phm_samu_clock_voltage_dependency_record {
@@ -404,7 +404,7 @@ struct phm_samu_clock_voltage_dependency_record {
 
 struct phm_samu_clock_voltage_dependency_table {
 	uint8_t count;
-	struct phm_samu_clock_voltage_dependency_record entries[];
+	struct phm_samu_clock_voltage_dependency_record entries[] __counted_by(count);
 };
 
 struct phm_cac_tdp_table {
-- 
2.43.0

