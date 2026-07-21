Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5B9C44532
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 14:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88B710E338;
	Tue, 21 Jul 2026 14:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbUqeyVY";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B6210E338
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 14:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXtWehWZq/dvf+/hZkbw0wt69fePH/8ez5ymDSiWULIiP8G4yRx9WH+hF0sfGCrgknMdIMjHgct+pnN9x9hMDMlN37L/7wxVggTZGrYrWM95oUPiCdLXf8r0w6Taui52VdDNT7MQoRj6zWLk92K/TwKb6LsppQNEc5CfNDw0s6KT+79SOc7xmhRC9uVdkyqsSrXBbX9BGpR/0ZYpZt9uboizVel0tI1pQJQginu+PpTlNqWvtqGNWXxH9OPuZB3N1YDOo4+u31by11ailN2zg1hL1Cd2noDmlYYuuWmU2smNClETCGck6D9U+x0irJdhE7osdaQ460AWOohWLaVvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMZ93xjaYa3yni2LfVQE6ENbXCQe9fMc51BDpIUBztA=;
 b=XO3q/uRT0gTHQluHMRupsUbfkxUzgYYaxKLHv6Tb9WryCOk91d6SDfkA6001Z025IsSLvMkwAMCCxCQRMwkNGIYpnewXvhRzXNeNIbLBd9K1P8bem3vZQs0cgU/CuUNDdcbhyPxbpIXR7qBsyVeXEfyWi8qoxjjRj51SUE2cIlOSFhVJGQVFcT+8tw1m+uWtjVrzAZ6y+wmali8sRC9VN0j8f+9YY81MKjyQ02tjqCy15rVR8a92ove84Q8N5RJtyOB/Dw6w3wnlcmzrZVVHjDIcwJ0ydjfyWdIlSio6nwpGcd0YXjjGScOWr0wXhTo7/G67egbvVmLex7cWn3l0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMZ93xjaYa3yni2LfVQE6ENbXCQe9fMc51BDpIUBztA=;
 b=bbUqeyVYL7FSs71KRkMeh39++QaM+2o3r47kOi0Y0aXooOprvmVMfbsadcoxVL943jRjzOiT/muPN92S4veYyZRhm7xbAEzmj8jtJgM0Ujyt00J0TSlPhwCevNnNMUItRipSDQrjfuWZAJmEZowgbBw0A5k0USoeFfM14hVqQ98=
Received: from CYXPR02CA0029.namprd02.prod.outlook.com (2603:10b6:930:cc::27)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 14:51:16 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:cc:cafe::4) by CYXPR02CA0029.outlook.office365.com
 (2603:10b6:930:cc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 14:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 14:51:16 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 09:51:09 -0500
From: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <Mario.Limonciello@amd.com>,
 <Christian.Koenig@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Lijo.Lazar@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Veerabadhran.Gopalakrishnan@amd.com>, <Pierre.Jabbour@amd.com>, "Kanala
 Ramalingeswara Reddy" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH] drm/amdgpu: Update driver if header for SMU V15.0.5
Date: Tue, 21 Jul 2026 20:20:54 +0530
Message-ID: <20260721145054.1295003-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: d41248ce-89ef-456d-904d-08dee7378452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|10067099003|3023799007|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: WS7seaS6zzuBYUtAmuyTpTihbKdaHsCct1z+O+GTChEa1s8h6H4kfx9OgLOmNyxUMX0OfUONDvkHeiKw+jtyqAWGkIbi/sWk0UieIjn+I/cuZzFpC72uThgfkb632lOafqgBY33E/1kgd/pvBtu70z0vtdUsNKi0df6B2qv5VKnmD2FYFx9T6ad0ccG+MxM2I5Ih9hr/+auQhEcigQNhMTke3sMGlWTlpBj/wJgQmMtvg9wmUeO5MvsPZdRrkgctdCJGwlKfSEef/JZPuRV8rkNovR8+ZwRHOq6vGXFDTtFl4dKKgKobUKui8OrNwnfew3V9jc9Dtbe9glYYejwSXF2QZlEoJHD4Dn98RJ9Yp6eeIPoX2Zpb4FFggptFZPFwJkt9my+Wkgv1nXYiXnT1mtzKWzH82YKkOqNPX17i8vsnmrLnKPILpHKo8gcBcLmmm0BoOYVvamNbGrlrHYSSFsD+Yq+LlQtRaONR9hV5Q8mM3Tkc1KHHBSNGIqaFNVbqZNnk5KmQwnL4n8kEhaCpyLpHlpa2C/edZrBUvhMuqLedWduXaHZmSOyBwPL/DPnaS97MsULwo1BSfder8rAGfLyapqD8KxiODAYNv7ZcFEmyg15iZKqfRW2mELEsA/iVMARftSeTTQ4Sl+oFxuRdjEB7LkvF7l6mZfpOC5cRgvn6FJjJtELXraJzRX/A4JkJWAu9gUTzt92U6/MajfM9FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(10067099003)(3023799007)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CnCX26Nm47mg+/CqWaLj+hUVaOQAQ9RANUcWDNimH9VqE7pxo9rh4JI+/j9apRWtoKchMQ1q1VB/B3C5Z35xMKvJqxUYW/gvio3YDE710hTpflOTKsA8Pd/oFI/I4RfQiEFL9tKGUvCmtzEJhy9txR0qBnQg/Nq4cBqUUUCD/tWCrUK/MMHYkGtH5eJWMWyfLAjow3v1XWwK4EY9pwaLKklZ1XsoMNohn7HR4ShVCSIa6AGmM2UckWCbfZqKvZVaxRW3JqM313KCdJeuADoo9YZf9fChjM5jTtCE/RJFQ/bv7kgGMjcuTJ3Idq8aJZOx/aztK5xWrzpVzMALxNrOm7ecR9AKOfujcJ5fqeNcvPjjLfYT2A99AlS/XjKQ1q2QQjle5XCq4rUQ1EVTLVU2/awXXAhIazW4AhKVHk62gnDzL7cS7AOUSj1xcIoHWIGM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 14:51:16.1522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41248ce-89ef-456d-904d-08dee7378452
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
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

Update smu v15.0.0 driver if header to be v15.0.5 compatible.

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
---
 .../inc/pmfw_if/smu15_driver_if_v15_0_0.h     |  38 +++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |   2 +-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 222 +++++++++++++++++-
 3 files changed, 255 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
index 47ddf533b08f..3676f8946dc8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
@@ -144,6 +144,44 @@ typedef struct {
   uint32_t MaxGfxClk;
 } DpmClocks_t;
 
+//Freq in MHz
+//Voltage in milli volts with 2 fractional bits
+typedef struct {
+	uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
+	uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
+	uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
+	uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
+
+	uint32_t VPEClocks[NUM_VPE_DPM_LEVELS];
+	uint32_t FclkClocks_Freq[NUM_FCLK_DPM_LEVELS];
+	uint32_t FclkClocks_Voltage[NUM_FCLK_DPM_LEVELS];
+	uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
+	MemPstateTable_t MemPstateTable[NUM_MEM_PSTATE_LEVELS];
+
+	uint8_t  NumDcfClkLevelsEnabled;
+	uint8_t  NumDispClkLevelsEnabled; //Applies to both Dispclk and Dppclk
+	uint8_t  NumSocClkLevelsEnabled;
+
+	uint8_t  VpeClkLevelsEnabled;
+
+	uint8_t  NumMemPstatesEnabled;
+	uint8_t  NumFclkLevelsEnabled;
+	uint8_t  Spare1;
+	uint8_t  Spare2;
+
+	uint8_t  Spare3;
+	uint8_t  SPare4;
+	uint8_t  spare5[2];
+
+	uint32_t MinGfxClk;
+	uint32_t MaxGfxClk;
+
+	uint32_t spare6[8];
+	uint32_t spare7[8];
+	uint32_t spare8[8];
+	uint32_t spare9[8];
+} DpmClocks_t_v15_0_5;
+
 typedef struct {
   uint16_t CoreFrequency[16];          //Target core frequency [MHz]
   uint16_t CorePower[16];              //CAC calculated core power [mW]
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index 13723d45a7de..38e625cda97d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -26,7 +26,7 @@
 #include "amdgpu_smu.h"
 
 #define SMU15_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU15_DRIVER_IF_VERSION_SMU_V15_0 0x7
+#define SMU15_DRIVER_IF_VERSION_SMU_V15_0 0x9
 
 
 #define FEATURE_MASK(feature) (1ULL << feature)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index bb8d09e73c7d..79ad8b612d61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -168,7 +168,8 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
+	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS,
+		max(sizeof(DpmClocks_t), sizeof(DpmClocks_t_v15_0_5)),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -178,7 +179,8 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->clocks_table = kzalloc_obj(DpmClocks_t);
+	smu_table->clocks_table = kzalloc(max(sizeof(DpmClocks_t), sizeof(DpmClocks_t_v15_0_5)),
+		GFP_KERNEL);
 	if (!smu_table->clocks_table)
 		goto err1_out;
 
@@ -752,11 +754,48 @@ static int smu_v15_0_0_get_dpm_freq_by_index(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v15_0_5_get_dpm_freq_by_index(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t dpm_level,
+						uint32_t *freq)
+{
+	DpmClocks_t_v15_0_5 *clk_table = smu->smu_table.clocks_table;
+
+	if (!clk_table || clk_type >= SMU_CLK_COUNT)
+		return -EINVAL;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		if (dpm_level >= clk_table->NumSocClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->SocClocks[dpm_level];
+		break;
+	case SMU_UCLK:
+	case SMU_MCLK:
+		if (dpm_level >= clk_table->NumMemPstatesEnabled)
+			return -EINVAL;
+		*freq = clk_table->MemPstateTable[dpm_level].MemClk;
+		break;
+	case SMU_FCLK:
+		if (dpm_level >= clk_table->NumFclkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->FclkClocks_Freq[dpm_level];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int smu_v15_0_common_get_dpm_freq_by_index(struct smu_context *smu,
 						enum smu_clk_type clk_type,
 						uint32_t dpm_level,
 						uint32_t *freq)
 {
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 5))
+		smu_v15_0_5_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
+	else
 		smu_v15_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
 
 	return 0;
@@ -907,12 +946,116 @@ static int smu_v15_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v15_0_5_get_dpm_ultimate_freq(struct smu_context *smu,
+							enum smu_clk_type clk_type,
+							uint32_t *min,
+							uint32_t *max)
+{
+	DpmClocks_t_v15_0_5 *clk_table = smu->smu_table.clocks_table;
+	uint32_t clock_limit;
+	uint32_t max_dpm_level, min_dpm_level;
+	int ret = 0;
+
+	if (!smu_v15_0_0_clk_dpm_is_enabled(smu, clk_type)) {
+		switch (clk_type) {
+		case SMU_MCLK:
+		case SMU_UCLK:
+			clock_limit = smu->smu_table.boot_values.uclk;
+			break;
+		case SMU_FCLK:
+			clock_limit = smu->smu_table.boot_values.fclk;
+			break;
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			clock_limit = smu->smu_table.boot_values.gfxclk;
+			break;
+		case SMU_SOCCLK:
+			clock_limit = smu->smu_table.boot_values.socclk;
+			break;
+		default:
+			clock_limit = 0;
+			break;
+		}
+
+		/* clock in Mhz unit */
+		if (min)
+			*min = clock_limit / 100;
+		if (max)
+			*max = clock_limit / 100;
+
+		return 0;
+	}
+
+	if (max) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*max = clk_table->MaxGfxClk;
+			break;
+		case SMU_MCLK:
+		case SMU_UCLK:
+			max_dpm_level = 0;
+			break;
+		case SMU_FCLK:
+			max_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
+			break;
+		case SMU_SOCCLK:
+			max_dpm_level = clk_table->NumSocClkLevelsEnabled - 1;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
+			ret = smu_v15_0_common_get_dpm_freq_by_index(smu, clk_type,
+				max_dpm_level, max);
+			if (ret)
+				goto failed;
+		}
+	}
+
+	if (min) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*min = clk_table->MinGfxClk;
+			break;
+		case SMU_MCLK:
+		case SMU_UCLK:
+			min_dpm_level = clk_table->NumMemPstatesEnabled - 1;
+			break;
+		case SMU_FCLK:
+			min_dpm_level = 0;
+			break;
+		case SMU_SOCCLK:
+			min_dpm_level = 0;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
+			ret = smu_v15_0_common_get_dpm_freq_by_index(smu, clk_type,
+				min_dpm_level, min);
+			if (ret)
+				goto failed;
+		}
+	}
+
+failed:
+	return ret;
+}
+
 static int smu_v15_0_common_get_dpm_ultimate_freq(struct smu_context *smu,
 							enum smu_clk_type clk_type,
 							uint32_t *min,
 							uint32_t *max)
 {
-	if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 5))
+		smu_v15_0_5_get_dpm_ultimate_freq(smu, clk_type, min, max);
+	else if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
 		smu_v15_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
 
 	return 0;
@@ -986,11 +1129,36 @@ static int smu_v15_0_0_get_dpm_level_count(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v15_0_5_get_dpm_level_count(struct smu_context *smu,
+					   enum smu_clk_type clk_type,
+					   uint32_t *count)
+{
+	DpmClocks_t_v15_0_5 *clk_table = smu->smu_table.clocks_table;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		*count = clk_table->NumSocClkLevelsEnabled;
+		break;
+	case SMU_MCLK:
+		*count = clk_table->NumMemPstatesEnabled;
+		break;
+	case SMU_FCLK:
+		*count = clk_table->NumFclkLevelsEnabled;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int smu_v15_0_common_get_dpm_level_count(struct smu_context *smu,
 					   enum smu_clk_type clk_type,
 					   uint32_t *count)
 {
-	if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 5))
+		smu_v15_0_5_get_dpm_level_count(smu, clk_type, count);
+	else if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
 		smu_v15_0_0_get_dpm_level_count(smu, clk_type, count);
 
 	return 0;
@@ -1363,9 +1531,24 @@ static int smu_v15_0_0_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
 	return 0;
 }
 
+static int smu_v15_0_5_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
+{
+	DpmClocks_t_v15_0_5 *clk_table = smu->smu_table.clocks_table;
+
+	smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
+	smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
+	smu->gfx_actual_hard_min_freq = 0;
+	smu->gfx_actual_soft_max_freq = 0;
+
+	return 0;
+}
+
 static int smu_v15_0_common_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 {
-	smu_v15_0_0_set_fine_grain_gfx_freq_parameters(smu);
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 5))
+		smu_v15_0_5_set_fine_grain_gfx_freq_parameters(smu);
+	else
+		smu_v15_0_0_set_fine_grain_gfx_freq_parameters(smu);
 
 	return 0;
 }
@@ -1405,9 +1588,36 @@ static int smu_v15_0_0_get_dpm_table(struct smu_context *smu, struct dpm_clocks
 	return 0;
 }
 
+static int smu_v15_0_5_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
+{
+	DpmClocks_t_v15_0_5 *clk_table = smu->smu_table.clocks_table;
+	uint8_t idx;
+
+	/*
+	 * Only the Clock information of SOC and
+	 * VPE is copied to provide VPE DPM settings for use.
+	 */
+	for (idx = 0; idx < NUM_SOCCLK_DPM_LEVELS; idx++) {
+		clock_table->SocClocks[idx].Freq =
+			(idx < clk_table->NumSocClkLevelsEnabled) ? clk_table->SocClocks[idx]:0;
+		clock_table->SocClocks[idx].Vol = 0;
+	}
+
+	for (idx = 0; idx < NUM_VPE_DPM_LEVELS; idx++) {
+		clock_table->VPEClocks[idx].Freq =
+			(idx < clk_table->VpeClkLevelsEnabled) ? clk_table->VPEClocks[idx]:0;
+		clock_table->VPEClocks[idx].Vol = 0;
+	}
+
+	return 0;
+}
+
 static int smu_v15_0_common_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
 {
-	smu_v15_0_0_get_dpm_table(smu, clock_table);
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 5))
+		smu_v15_0_5_get_dpm_table(smu, clock_table);
+	else
+		smu_v15_0_0_get_dpm_table(smu, clock_table);
 
 	return 0;
 }
-- 
2.53.0

