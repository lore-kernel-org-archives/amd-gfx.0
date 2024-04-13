Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8975AC04FF8
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Apr 2024 23:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DFE10F5A6;
	Sat, 13 Apr 2024 23:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ffzooqXd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338FD10F50B
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Apr 2024 23:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL4hMdoWcyML0zMvLUnzqyb/XSAtVL49Q32s0p8fdSpZi0mMmmBFVaMChxj4PKbBUIlG3CZNzXk0amRiIGwO+/eavNmWkVpczQDbeh63t8RCpJqDelsDYobxkzkfAEGv2KRDyDsch5uERgzuBavW/F0KcliuQWce6VkRv8UUw3FEomjs5j8nuHuIOdmYLDkukE4MGwlBei+s3DOkiwpzth4tMETDbMwFWdThAYm7U5UXksV1Wic1EkK8JpdhHJOPTpriz5N92Dr4lhRrHuU836+S85uLt+iz/1CQLqa6Kgseajw1hQLK/qL9zWMNWEAdOunGQNjT8GYQVvsssJQTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k9ySoe45kgQcc8iQTm2E0MNXTeNBLNldbBDkd+xqSg=;
 b=FFsj4xDUkc4feegQsrwEV3zh49O/I+dgCmOOpJgkBykJx9EXs2QJtgKOorssxH4R+X71O0yDxTqVNWQx9Nx5yhRXQQ3Fx0RTVYFy+5RgMbzZNv7JA9VUz6v0zjZNfBXspnYmS9E6hrx0zOkU66EqoKZ+BE2BkX8AAHo+H7yF10D/+dYcHtBB44+7q5u3VGROSk5Nt/AnJYh+d2KMRa1xPjHJMpRyXZ+D4eEWZ4oJBgUzKxYeXlTVCd1fF4JnkYPH+kqvEyx9ZWkdHDLEUyfvphroudy0q/K1qLaudFx6/5Jz07zLoTda+eSWuScDDxZCwdzaeYrkPQxNEcHtmzcvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k9ySoe45kgQcc8iQTm2E0MNXTeNBLNldbBDkd+xqSg=;
 b=ffzooqXdUr0xdXv79hCP+ssUFZKBvEoArmh2oR8+QfPHzquQ74NUEW/WDwMDB5AwiHqZs+JYzkXVcYhgEPgN41qVZPm47UDcV61gd7F47mseyOUulJaD0IcZ3SbXCRTw3a+zTe8mOhjGUs+GhRrXZOnYpvhdt3gIOgwkZ2hH2+I=
Received: from BY5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:1d0::13)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Sat, 13 Apr
 2024 23:40:23 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2d) by BY5PR04CA0003.outlook.office365.com
 (2603:10b6:a03:1d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Sat, 13 Apr 2024 23:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 23:40:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 13 Apr
 2024 18:40:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amd/swsmu: add pptable header for smu v14_0_2
Date: Sat, 13 Apr 2024 19:39:42 -0400
Message-ID: <20240413233945.4002886-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240413233945.4002886-1-alexander.deucher@amd.com>
References: <20240413233945.4002886-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: ad34c30a-d43d-4911-083d-08dc5c131632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jO6j4CRsTlze3JsOYzJU8RF+ajdzKQKb82MO4JdWkUSfiPmPFaOCu7b/F9y0EYgWjOdilmWyQ3GVqHVyrwB+f9IYuZEF7fvg1QYUskIgJvPRR+uP40E1g/JY3LUEYZMt1O20rIHaGjGWe1avJjHBGVclRXOtzsPtsbiF8lMbASTw5YTAXvLceTBskOmN2NPnMuy6iGZbAyrP3wRqolcGzuciv74xkpeu0MKa/E2WXL4cOMIzZ4ufuGa8cngROz1woFtDbWsohJPQW/xjZgDRaJHRBZ/NIaG80PwS5BnAbFcjdFgAhiMWBwuXJcWmRwLpE+9gF51MSQ7VHTtjewqm92yFUcWIf14V3rIKuDlgnNHd0JMjm7B+Gv5EqpiQ+gGVLfFsaSy1S01TePpqnccByyWyv+Ep2RNgOe6dXeumNCJPGf4bNyYxjjeD+0Mytw8icb0xzBJSmHFZnplynGUxuj5Pp7AZWfTCzv/LUfMr1KctyjNu4rlOIYJKIjpstZ2xEPeTa2Zl88graiOyNmE5pG6fyBO38yLb8i15eHdmXb5om8cr0i1+3gQuD8fixsIl2DvBHUCEO2ZtSzGYxNLNQSEldZkDUHCHDRMu4JSE+HatF4x5H70P6SWQNkcPV+VNjOXgO2qm+6Z27v95xnk8dCNcmLvwra9Gqb4QiRnobMeZ0sRsoiqj29lmOlgkdSCVzeCtea5ExQ+xpKYwlM5NGGaYFJF50Byn96j12K7nqgNUCZ1ME3tUgZtD0fDvo45q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 23:40:22.5185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad34c30a-d43d-4911-083d-08dc5c131632
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547
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

From: Likun Gao <Likun.Gao@amd.com>

Add pptable header for smu v14_0_2.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/swsmu/inc/smu_v14_0_2_pptable.h    | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h
new file mode 100644
index 0000000000000..4a3fde89aed73
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h
@@ -0,0 +1,164 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef SMU_14_0_2_PPTABLE_H
+#define SMU_14_0_2_PPTABLE_H
+
+
+#pragma pack(push, 1)
+
+#define SMU_14_0_2_TABLE_FORMAT_REVISION 3
+
+// POWERPLAYTABLE::ulPlatformCaps
+#define SMU_14_0_2_PP_PLATFORM_CAP_POWERPLAY        0x1     // This cap indicates whether CCC need to show Powerplay page.
+#define SMU_14_0_2_PP_PLATFORM_CAP_SBIOSPOWERSOURCE 0x2     // This cap indicates whether power source notificaiton is done by SBIOS instead of OS.
+#define SMU_14_0_2_PP_PLATFORM_CAP_HARDWAREDC       0x4     // This cap indicates whether DC mode notificaiton is done by GPIO pin directly.
+#define SMU_14_0_2_PP_PLATFORM_CAP_BACO             0x8     // This cap indicates whether board supports the BACO circuitry.
+#define SMU_14_0_2_PP_PLATFORM_CAP_MACO             0x10    // This cap indicates whether board supports the MACO circuitry.
+#define SMU_14_0_2_PP_PLATFORM_CAP_SHADOWPSTATE     0x20    // This cap indicates whether board supports the Shadow Pstate.
+#define SMU_14_0_2_PP_PLATFORM_CAP_LEDSUPPORTED     0x40    // This cap indicates whether board supports the LED.
+#define SMU_14_0_2_PP_PLATFORM_CAP_MOBILEOVERDRIVE  0x80    // This cap indicates whether board supports the Mobile Overdrive.
+
+// SMU_14_0_2_PP_THERMALCONTROLLER - Thermal Controller Type
+#define SMU_14_0_2_PP_THERMALCONTROLLER_NONE        0
+
+#define SMU_14_0_2_PP_OVERDRIVE_VERSION             0x1     // TODO: FIX OverDrive Version TBD
+#define SMU_14_0_2_PP_POWERSAVINGCLOCK_VERSION      0x01    // Power Saving Clock Table Version 1.00
+
+enum SMU_14_0_2_OD_SW_FEATURE_CAP
+{
+    SMU_14_0_2_ODCAP_AUTO_FAN_ACOUSTIC_LIMIT        = 0,
+    SMU_14_0_2_ODCAP_POWER_MODE                     = 1,
+    SMU_14_0_2_ODCAP_AUTO_UV_ENGINE                 = 2,
+    SMU_14_0_2_ODCAP_AUTO_OC_ENGINE                 = 3,
+    SMU_14_0_2_ODCAP_AUTO_OC_MEMORY                 = 4,
+    SMU_14_0_2_ODCAP_MEMORY_TIMING_TUNE             = 5,
+    SMU_14_0_2_ODCAP_MANUAL_AC_TIMING               = 6,
+    SMU_14_0_2_ODCAP_AUTO_VF_CURVE_OPTIMIZER        = 7,
+    SMU_14_0_2_ODCAP_AUTO_SOC_UV                    = 8,
+    SMU_14_0_2_ODCAP_COUNT                          = 9,
+};
+
+enum SMU_14_0_2_OD_SW_FEATURE_ID
+{
+    SMU_14_0_2_ODFEATURE_AUTO_FAN_ACOUSTIC_LIMIT      = 1 << SMU_14_0_2_ODCAP_AUTO_FAN_ACOUSTIC_LIMIT,      // Auto Fan Acoustic RPM
+    SMU_14_0_2_ODFEATURE_POWER_MODE                   = 1 << SMU_14_0_2_ODCAP_POWER_MODE,                   // Optimized GPU Power Mode
+    SMU_14_0_2_ODFEATURE_AUTO_UV_ENGINE               = 1 << SMU_14_0_2_ODCAP_AUTO_UV_ENGINE,               // Auto Under Volt GFXCLK
+    SMU_14_0_2_ODFEATURE_AUTO_OC_ENGINE               = 1 << SMU_14_0_2_ODCAP_AUTO_OC_ENGINE,               // Auto Over Clock GFXCLK
+    SMU_14_0_2_ODFEATURE_AUTO_OC_MEMORY               = 1 << SMU_14_0_2_ODCAP_AUTO_OC_MEMORY,               // Auto Over Clock MCLK
+    SMU_14_0_2_ODFEATURE_MEMORY_TIMING_TUNE           = 1 << SMU_14_0_2_ODCAP_MEMORY_TIMING_TUNE,           // Auto AC Timing Tuning
+    SMU_14_0_2_ODFEATURE_MANUAL_AC_TIMING             = 1 << SMU_14_0_2_ODCAP_MANUAL_AC_TIMING,             // Manual fine grain AC Timing tuning
+    SMU_14_0_2_ODFEATURE_AUTO_VF_CURVE_OPTIMIZER      = 1 << SMU_14_0_2_ODCAP_AUTO_VF_CURVE_OPTIMIZER,      // Fine grain auto VF curve tuning
+    SMU_14_0_2_ODFEATURE_AUTO_SOC_UV                  = 1 << SMU_14_0_2_ODCAP_AUTO_SOC_UV,                  // Auto Unver Volt VDDSOC
+};
+
+#define SMU_14_0_2_MAX_ODFEATURE 32 // Maximum Number of OD Features
+
+enum SMU_14_0_2_OD_SW_FEATURE_SETTING_ID
+{
+    SMU_14_0_2_ODSETTING_AUTO_FAN_ACOUSTIC_LIMIT    = 0,
+    SMU_14_0_2_ODSETTING_POWER_MODE                 = 1,
+    SMU_14_0_2_ODSETTING_AUTOUVENGINE               = 2,
+    SMU_14_0_2_ODSETTING_AUTOOCENGINE               = 3,
+    SMU_14_0_2_ODSETTING_AUTOOCMEMORY               = 4,
+    SMU_14_0_2_ODSETTING_ACTIMING                   = 5,
+    SMU_14_0_2_ODSETTING_MANUAL_AC_TIMING           = 6,
+    SMU_14_0_2_ODSETTING_AUTO_VF_CURVE_OPTIMIZER    = 7,
+    SMU_14_0_2_ODSETTING_AUTO_SOC_UV                = 8,
+    SMU_14_0_2_ODSETTING_COUNT                      = 9,
+};
+#define SMU_14_0_2_MAX_ODSETTING 64 // Maximum Number of ODSettings
+
+enum SMU_14_0_2_PWRMODE_SETTING
+{
+    SMU_14_0_2_PMSETTING_POWER_LIMIT_QUIET = 0,
+    SMU_14_0_2_PMSETTING_POWER_LIMIT_BALANCE,
+    SMU_14_0_2_PMSETTING_POWER_LIMIT_TURBO,
+    SMU_14_0_2_PMSETTING_POWER_LIMIT_RAGE,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_TEMP_QUIET,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_TEMP_BALANCE,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_TEMP_TURBO,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_TEMP_RAGE,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_TARGET_RPM_QUIET,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_TARGET_RPM_BALANCE,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_TARGET_RPM_TURBO,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_TARGET_RPM_RAGE,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_LIMIT_RPM_QUIET,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_LIMIT_RPM_BALANCE,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_LIMIT_RPM_TURBO,
+    SMU_14_0_2_PMSETTING_ACOUSTIC_LIMIT_RPM_RAGE,
+};
+#define SMU_14_0_2_MAX_PMSETTING 32 // Maximum Number of PowerMode Settings
+
+enum SMU_14_0_2_overdrive_table_id
+{
+    SMU_14_0_2_OVERDRIVE_TABLE_BASIC    = 0,
+    SMU_14_0_2_OVERDRIVE_TABLE_ADVANCED = 1,
+    SMU_14_0_2_OVERDRIVE_TABLE_COUNT    = 2,
+};
+
+struct smu_14_0_2_overdrive_table
+{
+    uint8_t revision;                                                           // Revision = SMU_14_0_2_PP_OVERDRIVE_VERSION
+    uint8_t reserve[3];                                                         // Zero filled field reserved for future use
+    uint8_t cap[SMU_14_0_2_OVERDRIVE_TABLE_COUNT][SMU_14_0_2_MAX_ODFEATURE];    // OD feature support flags
+    int32_t max[SMU_14_0_2_OVERDRIVE_TABLE_COUNT][SMU_14_0_2_MAX_ODSETTING];    // maximum settings
+    int32_t min[SMU_14_0_2_OVERDRIVE_TABLE_COUNT][SMU_14_0_2_MAX_ODSETTING];    // minimum settings
+    int16_t pm_setting[SMU_14_0_2_MAX_PMSETTING];                               // Optimized power mode feature settings
+};
+
+struct smu_14_0_2_powerplay_table
+{
+    struct atom_common_table_header header;                 // header.format_revision = 3 (HAS TO MATCH SMU_14_0_2_TABLE_FORMAT_REVISION), header.content_revision = ? structuresize is calculated by PPGen.
+    uint8_t table_revision;                                 // PPGen use only: table_revision = 3
+    uint8_t padding;                                        // Padding 1 byte to align table_size offset to 6 bytes (pmfw_start_offset, for PMFW to know the starting offset of PPTable_t).
+    uint16_t pmfw_pptable_start_offset;                     // The start offset of the pmfw portion. i.e. start of PPTable_t (start of SkuTable_t)
+    uint16_t pmfw_pptable_size;                             // The total size of pmfw_pptable, i.e PPTable_t.
+    uint16_t pmfw_pfe_table_start_offset;                   // The start offset of the PFE_Settings_t within pmfw_pptable.
+    uint16_t pmfw_pfe_table_size;                           // The size of PFE_Settings_t.
+    uint16_t pmfw_board_table_start_offset;                 // The start offset of the BoardTable_t within pmfw_pptable.
+    uint16_t pmfw_board_table_size;                         // The size of BoardTable_t.
+    uint16_t pmfw_custom_sku_table_start_offset;            // The start offset of the CustomSkuTable_t within pmfw_pptable.
+    uint16_t pmfw_custom_sku_table_size;                    // The size of the CustomSkuTable_t.
+    uint32_t golden_pp_id;                                  // PPGen use only: PP Table ID on the Golden Data Base
+    uint32_t golden_revision;                               // PPGen use only: PP Table Revision on the Golden Data Base
+    uint16_t format_id;                                     // PPGen use only: PPTable for different ASICs.
+    uint32_t platform_caps;                                 // POWERPLAYTABLE::ulPlatformCaps
+
+    uint8_t thermal_controller_type;                        // one of smu_14_0_2_PP_THERMALCONTROLLER
+
+    uint16_t small_power_limit1;
+    uint16_t small_power_limit2;
+    uint16_t boost_power_limit;                             // For Gemini Board, when the slave adapter is in BACO mode, the master adapter will use this boost power limit instead of the default power limit to boost the power limit.
+    uint16_t software_shutdown_temp;
+
+    uint8_t reserve[143];                                   // Zero filled field reserved for future use
+
+    struct smu_14_0_2_overdrive_table overdrive_table;
+
+    PPTable_t smc_pptable;                          // PPTable_t in driver_if.h -- as requested by PMFW, this offset should start at a 32-byte boundary, and the table_size above should remain at offset=6 bytes
+};
+
+#pragma pack(pop)
+
+#endif
-- 
2.44.0

