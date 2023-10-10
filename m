Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFDDCD80D5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 13:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E2E10E36D;
	Tue, 10 Oct 2023 13:48:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C8B10E36D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 13:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG0S6/RyDX2BE62e+bb8e8yqqQ4hDaQct1XbFbhitSjX1h/DtgcHgb+YJ3z52lxRaPwYX4JHkIPlHjJMb/F5Ib/NPC5YRwdDDadnqxK4RZXtvYcZqmjxaJ1HnBK44puYLnHgtRNyft0Vjs+PCoReZPw+u/dfA2xROydZnNWbw0JJAhBml2iKBGQuy+wQI75Uk0EY2Puj2CJkDVk1lX6PexVHN9OAGqbSRSkA9C+6kPccHOQbg2vHzIw+2rrvsROQieJVYNmEm/8h9wJmx6fJUXPbpJompt0XWp4YKBGdam5cYrjMdezFpA6EV4OPjk+gw8o/9M/FRc4nZactedURYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsoQafv+2AmwMA8i36xlGCC8pjoIvWbfUnaEtxDyuVY=;
 b=Eqcpn5EFfuNVqPYLKJvr7YCxYrVP+3+KrNs2HxY9GKti6RjkjhieyfQgDnHoWwD3WNzYyBKEo4iUmc/Xg3v9J0Aeso+hk6BcmtvvjCRnoGAillWz4aj2B571DTVtrMxIKyCkxt0JXyy1HQOpYRG6AGfQ6M8Br64FmQtdIfvlayc2N3zsGFEaGFntL0WVN3uedQsrpL/454Dq/7dYbtqQ81EtcQOvb4f9nsQ+VVyxQuSOIc8PqZFjELjJ5WLr2oIlj1CE/UtTxAgbIYe4dQ0tZjIzxQBgXeRg0Vs+7W/H7/DhP8JW4fblBsuEzYGChXPa6tFDL4rogKF2GX94CZ2EHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsoQafv+2AmwMA8i36xlGCC8pjoIvWbfUnaEtxDyuVY=;
 b=dEVWCutOzFqgLo67puSPIuNNeErrA1vMUI63yct3DcmZ5WIwEj4Sq4hpGEVKTAllMMCecQ4/PhzMYY/FDfFRqS0wPYO6Nka2YMO0++AkEpzX43xUO6ig/a30SKbUEbY79r3tZcLrs1EYTiTdo5f+f4+EM415PbCQpNen7bnUepE=
Received: from PA7P264CA0245.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::6)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 13:47:57 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10a6:102:371:cafe::61) by PA7P264CA0245.outlook.office365.com
 (2603:10a6:102:371::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 13:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 13:47:55 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 08:47:53 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/swsmu: update smu v14_0_0 header files and metrics
 table
Date: Tue, 10 Oct 2023 21:47:30 +0800
Message-ID: <20231010134730.458857-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bbed82-e158-4f22-4092-08dbc997819b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWHVaJBMYGA+XUHnjAgkhq1an10tTLpU2ST4QOUOHlEHP8ywEXQXMYcOG3zPAkd12oeHbBcL602h1XmpoHRmoYfHib+SKn9nF9GPeQSj4Vr3jM0yt+q9w6Wr9YRRtS22wxaWNfErtOif/acAy/7fzkIBfm7ccwBvCES16tgycCK4AfqGGEvBLnyFRVtFs0TZE2GlZJUJtoCZbLQ1VWkZM+OKT7YqFujCWaj9hsO4DvRb1bQLujl4XCbPM0ADpgtN4XKaTNZPBReDhWjVWvVRw1m/2352oja1y+ZdiiMJcswVzs6MyZPZ84a4M0WfxcDM+kQxbmTopWDubQARDLVlWmbTcllydzevEgxI7jm6eBQmYuavOSlmYERZIkINi3k0u/A/C1pUW6zgd/XInUa8sR6OpB7pwCR390yokFt5SCnu7ZYHdqObw6fAsrRVxLvzooJldIJrBMLwpp7QqGLMAe/hbcNhOJNLkhmg3a2m7NX6dJ0q1e/i4KD2kr9sFPco3dJHUVGj6jaQVOZWSmIyIpercYZDZi/eW1Y/fYFhK1GIGFRwbX7YRYWzs8AtM6Tnvu3q51rACFBtRJxQYaz/XZxLDqmDYepSG1E+EQNtBpnGqDDFm2fyrMMaA9kAYghJus6ymHMDv1Zyjy7l8GsutaEdpbw5z/82CaahfEA6GTxCBTBynweSAFEQqeXZ5v9YnvcWwbo80IYrxTxyP9vaHcK/5O9i4F88bdcQ7b7Sxk0TpgsB94VrJBk7DUuU8lD1NiC+bq2qBJQZDqo+liG7eA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(26005)(40480700001)(40460700003)(16526019)(1076003)(2616005)(426003)(336012)(36860700001)(19627235002)(478600001)(36756003)(7696005)(6666004)(86362001)(47076005)(41300700001)(5660300002)(70586007)(70206006)(54906003)(110136005)(316002)(356005)(6636002)(30864003)(2906002)(8676002)(82740400003)(8936002)(4326008)(44832011)(81166007)(15650500001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:47:55.4268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bbed82-e158-4f22-4092-08dbc997819b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034
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
Cc: Alexander.Deucher@amd.com, yifan1.zhang@amd.com, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update driver if, pmfw and ppsmc header files.
Add new gpu_metrics_v3_0 for metrics table updated in driver if
and reserve legacy metrics table to maintain backward compatibility.

Signed-off-by: Li Ma <li.ma@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  68 ++++
 .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     |  66 ++--
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h   |  24 +-
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h  |   6 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 345 ++++++++++++++----
 5 files changed, 393 insertions(+), 116 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index cdba7ba11e44..2d54c89b1bd2 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -893,4 +893,72 @@ struct gpu_metrics_v2_3 {
 	uint16_t			average_temperature_core[8]; // average CPU core temperature on APUs
 	uint16_t			average_temperature_l3[2];
 };
+
+struct gpu_metrics_v3_0 {
+	struct metrics_table_header	common_header;
+
+	/* Temperature */
+	/* gfx temperature on APUs */
+	uint16_t			temperature_gfx;
+	/* soc temperature on APUs */
+	uint16_t			temperature_soc;
+	/* CPU core temperature on APUs */
+	uint16_t			temperature_core[16];
+	/* skin temperature on APUs */
+	uint16_t			temperature_skin;
+
+	/* Utilization */
+	/* time filtered GFX busy % [0-100] */
+	uint16_t			average_gfx_activity;
+	/* time filtered VCN busy % [0-100] */
+	uint16_t			average_vcn_activity;
+	/* time filtered IPU per-column busy % [0-100] */
+	uint16_t 			average_ipu_activity[8];
+	/* time filtered per-core C0 residency % [0-100]*/
+	uint16_t 			average_core_c0_activity[16];
+	/* time filtered DRAM read bandwidth [GB/sec] */
+	uint16_t 			average_dram_reads;
+	/* time filtered DRAM write bandwidth [GB/sec] */
+	uint16_t 			average_dram_writes;
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
+
+	/* Power/Energy */
+	/* average dGPU + APU power on A + A platform */
+	uint16_t			average_socket_power;
+	/* average IPU power [W] */
+	uint16_t			average_ipu_power;
+	/* average APU power [W] */
+	uint16_t			average_apu_power;
+	/* average dGPU power [W] */
+	uint16_t			average_dgpu_power;
+	/* sum of core power across all cores in the socket [W] */
+	uint16_t			average_core_power;
+	/* calculated core power [W] */
+	uint16_t 			core_power[16];
+	/* maximum IRM defined STAPM power limit [W] */
+	uint16_t 			stapm_power_limit;
+	/* time filtered STAPM power limit [W] */
+	uint16_t 			current_stapm_power_limit;
+
+	/* Average clocks */
+	uint16_t			average_gfxclk_frequency;
+	uint16_t			average_socclk_frequency;
+	uint16_t			average_vpeclk_frequency;
+	uint16_t			average_ipuclk_frequency;
+	uint16_t			average_fclk_frequency;
+	uint16_t			average_vclk_frequency;
+
+	/* Current clocks */
+	/* target core frequency */
+	uint16_t			current_coreclk[16];
+	/* CCLK frequency limit enforced on classic cores [MHz] */
+	uint16_t 			current_core_maxfreq;
+	/* GFXCLK frequency limit enforced on GFX [MHz] */
+	uint16_t 			current_gfx_maxfreq;
+
+	/* Metrics table alpha filter time constant [us] */
+	uint32_t 			time_filter_alphavalue;
+};
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index 61f007987b35..83a2ca1e5947 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -149,23 +149,37 @@ typedef struct {
   uint32_t MaxGfxClk;
 } DpmClocks_t;
 
-
-// Throttler Status Bitmask
-#define THROTTLER_STATUS_BIT_SPL              0
-#define THROTTLER_STATUS_BIT_FPPT             1
-#define THROTTLER_STATUS_BIT_SPPT             2
-#define THROTTLER_STATUS_BIT_SPPT_APU         3
-#define THROTTLER_STATUS_BIT_THM_CORE         4
-#define THROTTLER_STATUS_BIT_THM_GFX          5
-#define THROTTLER_STATUS_BIT_THM_SOC          6
-#define THROTTLER_STATUS_BIT_TDC_VDD          7
-#define THROTTLER_STATUS_BIT_TDC_VDDCCX       8
-#define THROTTLER_STATUS_BIT_TDC_SOC          9
-#define THROTTLER_STATUS_BIT_PROCHOT_CPU      10
-#define THROTTLER_STATUS_BIT_PROCHOT_GFX      11
-#define THROTTLER_STATUS_BIT_EDC_CPU_CLASSIC  12
-#define THROTTLER_STATUS_BIT_EDC_CPU_DENSE    13
-#define THROTTLER_STATUS_BIT_EDC_GFX          14
+typedef struct {
+  uint16_t CoreFrequency[16];           //Target core frequency [MHz]
+  uint16_t CorePower[16];               //CAC calculated core power [W] [Q8.8]
+  uint16_t CoreTemperature[16];         //TSEN measured core temperature [C] [Q8.8]
+  uint16_t GfxTemperature;              //TSEN measured GFX temperature [C] [Q8.8]
+  uint16_t SocTemperature;              //TSEN measured SOC temperature [C] [Q8.8]
+  uint16_t StapmOpnLimit;               //Maximum IRM defined STAPM power limit [W] [Q8.8]
+  uint16_t StapmCurrentLimit;           //Time filtered STAPM power limit [W] [Q8.8]
+  uint16_t InfrastructureCpuMaxFreq;    //CCLK frequency limit enforced on classic cores [MHz]
+  uint16_t InfrastructureGfxMaxFreq;    //GFXCLK frequency limit enforced on GFX [MHz]
+  uint16_t SkinTemp;                    //Maximum skin temperature reported by APU and HS2 chassis sensors [C] [Q8.8]
+  uint16_t AverageGfxclkFrequency;      //Time filtered target GFXCLK frequency [MHz]
+  uint16_t AverageFclkFrequency;        //Time filtered target FCLK frequency [MHz]
+  uint16_t AverageGfxActivity;          //Time filtered GFX busy % [0-100] [Q8.8]
+  uint16_t AverageSocclkFrequency;      //Time filtered target SOCCLK frequency [MHz]
+  uint16_t AverageVclkFrequency;        //Time filtered target VCLK frequency [MHz]
+  uint16_t AverageVcnActivity;          //Time filtered VCN busy % [0-100] [Q8.8]
+  uint16_t AverageVpeclkFrequency;      //Time filtered target VPECLK frequency [MHz]
+  uint16_t AverageIpuclkFrequency;      //Time filtered target IPUCLK frequency [MHz]
+  uint16_t AverageIpuBusy[8];           //Time filtered IPU per-column busy % [0-100] [Q8.8]
+  uint16_t AverageDRAMReads;            //Time filtered DRAM read bandwidth [GB/sec] [Q8.8]
+  uint16_t AverageDRAMWrites;           //Time filtered DRAM write bandwidth [GB/sec] [Q8.8]
+  uint16_t AverageCoreC0Residency[16];  //Time filtered per-core C0 residency % [0-100] [Q8.8]
+  uint16_t IpuPower;                    //Time filtered IPU power [W] [Q8.8]
+  uint32_t ApuPower;                    //Time filtered APU power [W] [Q24.8]
+  uint32_t dGpuPower;                   //Time filtered dGPU power [W] [Q24.8]
+  uint32_t AverageSocketPower;          //Time filtered power used for PPT/STAPM [APU+dGPU] [W] [Q24.8]
+  uint32_t AverageCorePower;            //Time filtered sum of core power across all cores in the socket [W] [Q24.8]
+  uint32_t FilterAlphaValue;            //Metrics table alpha filter time constant [us]
+  uint32_t MetricsCounter;              //Counter that is incremented on every metrics table update [PM_TIMER cycles]
+} SmuMetrics_t;
 
 typedef struct {
   uint16_t GfxclkFrequency;             //[MHz]
@@ -225,18 +239,7 @@ typedef struct {
   uint16_t AverageCoreC0Residency[16]; //Filtered of [average C0 residency % per core]
   uint16_t spare1;
   uint32_t MetricsCounter;            //Counts the # of metrics table parameter reads per update to the metrics table, i.e. if the metrics table update happens every 1 second, this value could be up to 1000 if the smu collected metrics data every cycle, or as low as 0 if the smu was asleep the whole time. Reset to 0 after writing.
-} SmuMetrics_t;
-
-typedef struct {
-  uint16_t StapmMaxPlatformLimit;            //[W]
-  uint16_t StapmMinPlatformLimit;            //[W]
-  uint16_t FastPptMaxPlatformLimit;          //[W]
-  uint16_t FastPptMinPlatformLimit;          //[W]
-  uint16_t SlowPptMaxPlatformLimit;          //[W]
-  uint16_t SlowPptMinPlatformLimit;          //[W]
-  uint16_t SlowPptApuMaxPlatformLimit;       //[W]
-  uint16_t SlowPptApuMinPlatformLimit;       //[W]
-} PmfInfo_t;
+} SmuMetrics_legacy_t;
 
 //ISP tile definitions
 typedef enum {
@@ -274,7 +277,6 @@ typedef enum {
 #define TABLE_SPARE0                5 // Unused
 #define TABLE_MODERN_STDBY          6 // Called by Tools for Modern Standby Log
 #define TABLE_SMU_METRICS           7 // Called by Driver and SMF/PMF
-#define TABLE_INFRASTRUCTURE_LIMITS 8 // Called by SMF/PMF
-#define TABLE_COUNT                 9
+#define TABLE_COUNT                 8
 
-#endif
\ No newline at end of file
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h
index f376be97eafb..356e0f57a426 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h
@@ -58,7 +58,7 @@
 #define FEATURE_DS_LCLK_BIT                 23
 #define FEATURE_LOW_POWER_DCNCLKS_BIT       24  // for all DISP clks
 #define FEATURE_DS_SHUBCLK_BIT              25
-#define FEATURE_GFX_TEMP_VMIN_BIT           26
+#define FEATURE_SPARE0_BIT                  26  //SPARE
 #define FEATURE_ZSTATES_BIT                 27
 #define FEATURE_IOMMUL2_PG_BIT              28
 #define FEATURE_DS_FCLK_BIT                 29
@@ -67,7 +67,7 @@
 #define FEATURE_WHISPER_MODE_BIT            32
 #define FEATURE_SMU_LOW_POWER_BIT           33
 #define FEATURE_SMART_L3_RINSER_BIT         34
-#define FEATURE_SPARE0                      35
+#define FEATURE_SPARE1_BIT                  35  //SPARE
 #define FEATURE_PSI_BIT                     36
 #define FEATURE_PROCHOT_BIT                 37
 #define FEATURE_CPUOFF_BIT                  38
@@ -81,7 +81,7 @@
 #define FEATURE_CPPC_BIT                    46
 #define FEATURE_CPPC_PREFERRED_CORES        47
 #define FEATURE_DF_CSTATES_BIT              48
-#define FEATURE_SPARE1                      49
+#define FEATURE_SPARE2_BIT                  49  //SPARE
 #define FEATURE_ATHUB_PG_BIT                50
 #define FEATURE_VDDOFF_ECO_BIT              51
 #define FEATURE_ZSTATES_ECO_BIT             52
@@ -89,12 +89,12 @@
 #define FEATURE_DS_UMCCLK_BIT               54
 #define FEATURE_DS_ISPCLK_BIT               55
 #define FEATURE_DS_HSPCLK_BIT               56
-#define FEATURE_RESERVED1                   57  //SPARE
+#define FEATURE_P3T_BIT                     57
 #define FEATURE_DS_IPUCLK_BIT               58
 #define FEATURE_DS_VPECLK_BIT               59
 #define FEATURE_VPE_DPM_BIT                 60
-#define FEATURE_BABYPHASE_SVI3_BIT          61
-#define FEATURE_FP_DIDT_BIT                 62
+#define FEATURE_SPARE_61                    61
+#define FEATURE_FP_DIDT                     62
 #define NUM_FEATURES                        63
 
 // Firmware Header/Footer
@@ -123,13 +123,13 @@ typedef struct {
   uint32_t DpmHubTask           : 4;
   // MP1_EXT_SCRATCH1
   uint32_t CclkSyncStatus       : 8;
+  uint32_t Ccx0CpuOff           : 2;
+  uint32_t Ccx1CpuOff           : 2;
   uint32_t GfxOffStatus         : 2;
-  uint32_t CpuOff               : 2;
   uint32_t VddOff               : 1;
-  uint32_t spare0               : 2;
   uint32_t InWhisperMode        : 1;
   uint32_t ZstateStatus         : 4;
-  uint32_t spare1               : 4;
+  uint32_t spare0               : 4;
   uint32_t DstateFun            : 4;
   uint32_t DstateDev            : 4;
   // MP1_EXT_SCRATCH2
@@ -141,10 +141,10 @@ typedef struct {
   uint32_t MsgPortBusy          :24;
   uint32_t RsmuPmiP1Pending     : 1;
   uint32_t DfCstateExitPending  : 1;
-  uint32_t Pc6EntryPending      : 1;
-  uint32_t Pc6ExitPending       : 1;
+  uint32_t Ccx0Pc6ExitPending   : 1;
+  uint32_t Ccx1Pc6ExitPending   : 1;
   uint32_t WarmResetPending     : 1;
-  uint32_t spare2               : 3;
+  uint32_t spare1               : 3;
   // MP1_EXT_SCRATCH5
   uint32_t IdleMask             :32;
   // MP1_EXT_SCRATCH6 = RTOS threads' status
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
index e671cb6aa65c..8a8a57c56bc0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
@@ -75,8 +75,8 @@
 
 #define PPSMC_MSG_EnableGfxImu                  0x16 ///< Enable GFX IMU
 
-#define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
-#define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
+#define PPSMC_MSG_spare_0x17                    0x17
+#define PPSMC_MSG_spare_0x18                    0x18
 #define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of allowing GFXOFF entry
 #define PPSMC_MSG_DisallowGfxOff                0x1A ///< Inform PMFW of disallowing GFXOFF entry
 #define PPSMC_MSG_SetSoftMaxGfxClk              0x1B ///< Set soft max for GFX CLK
@@ -85,7 +85,7 @@
 #define PPSMC_MSG_SetSoftMaxSocclkByFreq        0x1D ///< Set soft max for SOC CLK
 #define PPSMC_MSG_SetSoftMaxFclkByFreq          0x1E ///< Set soft max for FCLK
 #define PPSMC_MSG_SetSoftMaxVcn                 0x1F ///< Set soft max for VCN clocks (VCLK and DCLK)
-#define PPSMC_MSG_SetPowerLimitPercentage       0x20 ///< Set power limit percentage
+#define PPSMC_MSG_spare_0x20                    0x20
 #define PPSMC_MSG_PowerDownJpeg                 0x21 ///< Power down Jpeg
 #define PPSMC_MSG_PowerUpJpeg                   0x22 ///< Power up Jpeg; VCN is power gated by default
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 247a6182d4bd..d57a220bdaba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -67,48 +67,45 @@
 	FEATURE_MASK(FEATURE_VPE_DPM_BIT))
 
 static struct cmn2asic_msg_mapping smu_v14_0_0_message_map[SMU_MSG_MAX_COUNT] = {
-	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
-	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetPmfwVersion,		1),
-	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,		1),
-	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			1),
-	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			1),
-	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		1),
-	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,		1),
-	MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnload,		1),
-	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	1),
-	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,		1),
-	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,	1),
-	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	1),
-	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,		1),
-	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,	1),
-	MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq,	1),
-	MSG_MAP(SetSoftMinFclk,              	PPSMC_MSG_SetSoftMinFclk,		1),
-	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,		1),
-	MSG_MAP(EnableGfxImu,              		PPSMC_MSG_EnableGfxImu,		1),
-	MSG_MAP(GetGfxclkFrequency,             PPSMC_MSG_GetGfxclkFrequency,		1),
-	MSG_MAP(GetFclkFrequency,               PPSMC_MSG_GetFclkFrequency,		1),
-	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,			1),
-	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff,		1),
-	MSG_MAP(SetSoftMaxGfxClk,               PPSMC_MSG_SetSoftMaxGfxClk,		1),
-	MSG_MAP(SetHardMinGfxClk,               PPSMC_MSG_SetHardMinGfxClk,		1),
-	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,	1),
-	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,		1),
-	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,		1),
-	MSG_MAP(SetPowerLimitPercentage,        PPSMC_MSG_SetPowerLimitPercentage,	1),
-	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,		1),
-	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,			1),
-	MSG_MAP(SetHardMinFclkByFreq,           PPSMC_MSG_SetHardMinFclkByFreq,		1),
-	MSG_MAP(SetSoftMinSocclkByFreq,         PPSMC_MSG_SetSoftMinSocclkByFreq,	1),
-	MSG_MAP(PowerDownIspByTile,             PPSMC_MSG_PowerDownIspByTile,		1),
-	MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile,		1),
+	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,					1),
+	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetPmfwVersion,				1),
+	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,			1),
+	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,					1),
+	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,					1),
+	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,				1),
+	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,				1),
+	MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnload,			1),
+	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,		1),
+	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,			1),
+	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,		1),
+	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,		1),
+	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,			1),
+	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,		1),
+	MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq,		1),
+	MSG_MAP(SetSoftMinFclk,              	PPSMC_MSG_SetSoftMinFclk,				1),
+	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,				1),
+	MSG_MAP(EnableGfxImu,              		PPSMC_MSG_EnableGfxImu,					1),
+	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,					1),
+	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff,				1),
+	MSG_MAP(SetSoftMaxGfxClk,               PPSMC_MSG_SetSoftMaxGfxClk,				1),
+	MSG_MAP(SetHardMinGfxClk,               PPSMC_MSG_SetHardMinGfxClk,				1),
+	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,		1),
+	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,			1),
+	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,				1),
+	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,				1),
+	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,					1),
+	MSG_MAP(SetHardMinFclkByFreq,           PPSMC_MSG_SetHardMinFclkByFreq,			1),
+	MSG_MAP(SetSoftMinSocclkByFreq,         PPSMC_MSG_SetSoftMinSocclkByFreq,		1),
+	MSG_MAP(PowerDownIspByTile,             PPSMC_MSG_PowerDownIspByTile,			1),
+	MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile,				1),
 	MSG_MAP(SetHardMinIspiclkByFreq,        PPSMC_MSG_SetHardMinIspiclkByFreq,		1),
 	MSG_MAP(SetHardMinIspxclkByFreq,        PPSMC_MSG_SetHardMinIspxclkByFreq,		1),
-	MSG_MAP(PowerUpVpe,        				PPSMC_MSG_PowerUpVpe,		1),
-	MSG_MAP(PowerDownVpe,        			PPSMC_MSG_PowerDownVpe,		1),
-	MSG_MAP(PowerUpUmsch,        			PPSMC_MSG_PowerUpUmsch,		1),
-	MSG_MAP(PowerDownUmsch,        			PPSMC_MSG_PowerDownUmsch,	1),
-	MSG_MAP(SetSoftMaxVpe,        			PPSMC_MSG_SetSoftMaxVpe,		1),
-	MSG_MAP(SetSoftMinVpe,        			PPSMC_MSG_SetSoftMinVpe,	1),
+	MSG_MAP(PowerUpVpe,        				PPSMC_MSG_PowerUpVpe,					1),
+	MSG_MAP(PowerDownVpe,        			PPSMC_MSG_PowerDownVpe,					1),
+	MSG_MAP(PowerUpUmsch,        			PPSMC_MSG_PowerUpUmsch,					1),
+	MSG_MAP(PowerDownUmsch,        			PPSMC_MSG_PowerDownUmsch,				1),
+	MSG_MAP(SetSoftMaxVpe,        			PPSMC_MSG_SetSoftMaxVpe,				1),
+	MSG_MAP(SetSoftMinVpe,        			PPSMC_MSG_SetSoftMinVpe,				1),
 };
 
 static struct cmn2asic_mapping smu_v14_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -154,28 +151,44 @@ static int smu_v14_0_0_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	uint32_t if_version;
+	uint32_t smu_version;
+	uint32_t ret;
+
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
+	if (ret) {
+		return ret;
+	}
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
-		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	if (smu_version > 0x5d3500) {
+		SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+		smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
+	} else {
+		SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_legacy_t),
+			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+		smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_legacy_t), GFP_KERNEL);
+	}
+	if (!smu_table->metrics_table)
+		goto err0_out;
+	smu_table->metrics_time = 0;
 
 	smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
 	if (!smu_table->clocks_table)
-		goto err0_out;
-
-	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
-	if (!smu_table->metrics_table)
 		goto err1_out;
-	smu_table->metrics_time = 0;
 
 	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
+	if (smu_version > 0x5d3500)
+		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v3_0);
+	else
+		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err3_out;
@@ -185,9 +198,9 @@ static int smu_v14_0_0_init_smc_tables(struct smu_context *smu)
 err3_out:
 	kfree(smu_table->watermarks_table);
 err2_out:
-	kfree(smu_table->metrics_table);
+	kfree(smu_table->clocks_table);	
 err1_out:
-	kfree(smu_table->clocks_table);
+	kfree(smu_table->metrics_table);
 err0_out:
 	return -ENOMEM;
 }
@@ -231,6 +244,95 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
+	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	if (ret)
+		return ret;
+
+	switch (member) {
+	case METRICS_AVERAGE_GFXCLK:
+		*value = metrics->AverageGfxclkFrequency;
+		break;
+	case METRICS_AVERAGE_SOCCLK:
+		*value = metrics->AverageSocclkFrequency;
+		break;
+	case METRICS_AVERAGE_VCLK:
+		*value = metrics->AverageVclkFrequency;
+		break;
+	case METRICS_AVERAGE_DCLK:
+		*value = 0;
+		break;
+	case METRICS_AVERAGE_UCLK:
+		*value = 0;
+		break;
+	case METRICS_AVERAGE_FCLK:
+		*value = metrics->AverageFclkFrequency;
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = metrics->AverageGfxActivity >> 8;
+		break;
+	case METRICS_AVERAGE_VCNACTIVITY:
+		*value = metrics->AverageVcnActivity >> 8;
+		break;
+	case METRICS_AVERAGE_SOCKETPOWER:
+		*value =(metrics->AverageSocketPower & 0xff00) +
+		((metrics->AverageSocketPower & 0xff) * 100 >> 8);
+		break;
+	case METRICS_TEMPERATURE_EDGE:
+		*value = (metrics->GfxTemperature >> 8) *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = (metrics->SocTemperature >> 8) *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_THROTTLER_STATUS:
+		*value = 0;
+		break;
+	case METRICS_VOLTAGE_VDDGFX:
+		*value = 0;
+		break;
+	case METRICS_VOLTAGE_VDDSOC:
+		*value = 0;
+		break;
+	case METRICS_SS_APU_SHARE:
+		/* return the percentage of APU power with respect to APU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if (metrics->StapmOpnLimit > 0)
+			*value = (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
+		else
+			*value = 0;
+		break;
+	case METRICS_SS_DGPU_SHARE:
+		/* return the percentage of dGPU power with respect to dGPU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if ((metrics->dGpuPower > 0) &&
+		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
+			*value = (metrics->dGpuPower * 100) /
+				 (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
+		else
+			*value = 0;
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	return ret;
+}
+
+static int smu_v14_0_0_legacy_get_smu_metrics_data(struct smu_context *smu,
+					    MetricsMember_t member,
+					    uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	SmuMetrics_legacy_t *metrics = (SmuMetrics_legacy_t *)smu_table->metrics_table;
+	int ret = 0;
+
 	ret = smu_cmn_get_metrics_table(smu, NULL, false);
 	if (ret)
 		return ret;
@@ -251,6 +353,9 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_UCLK:
 		*value = metrics->MemclkFrequency;
 		break;
+	case METRICS_AVERAGE_FCLK:
+		*value = metrics->AverageFclkFrequency;
+		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
 		*value = metrics->GfxActivity / 100;
 		break;
@@ -307,6 +412,29 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v14_0_0_common_get_smu_metrics_data(struct smu_context *smu,
+					    MetricsMember_t member,
+					    uint32_t *value)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t smu_version;
+	int ret = 0;
+
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret) {
+		dev_err(adev->dev, "Failed to get smu version!\n");
+		return ret;
+	}
+
+	if (smu_version > 0x5d3500)
+		ret = smu_v14_0_0_get_smu_metrics_data(smu, member, value);
+	else
+		ret = smu_v14_0_0_legacy_get_smu_metrics_data(smu, member, value);
+
+	return ret;
+
+}
+
 static int smu_v14_0_0_read_sensor(struct smu_context *smu,
 				   enum amd_pp_sensors sensor,
 				   void *data, uint32_t *size)
@@ -318,63 +446,63 @@ static int smu_v14_0_0_read_sensor(struct smu_context *smu,
 
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		ret = smu_v14_0_0_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_GFXACTIVITY,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GPU_POWER:
-		ret = smu_v14_0_0_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_SOCKETPOWER,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
-		ret = smu_v14_0_0_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
 						       METRICS_TEMPERATURE_EDGE,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-		ret = smu_v14_0_0_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
 						       METRICS_TEMPERATURE_HOTSPOT,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		ret = smu_v14_0_0_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_UCLK,
 						       (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = smu_v14_0_0_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_GFXCLK,
 						       (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VDDGFX:
-		ret = smu_v14_0_0_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
 						       METRICS_VOLTAGE_VDDGFX,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VDDNB:
-		ret = smu_v14_0_0_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
 						       METRICS_VOLTAGE_VDDSOC,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
-		ret = smu_v14_0_0_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
 						       METRICS_SS_APU_SHARE,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
-		ret = smu_v14_0_0_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
 						       METRICS_SS_DGPU_SHARE,
 						       (uint32_t *)data);
 		*size = 4;
@@ -460,11 +588,74 @@ static int smu_v14_0_0_set_watermarks_table(struct smu_context *smu,
 
 static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 						void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v3_0 *gpu_metrics =
+		(struct gpu_metrics_v3_0 *)smu_table->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	if (ret)
+		return ret;
+
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+
+	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
+	gpu_metrics->temperature_soc = metrics.SocTemperature;
+	memcpy(&gpu_metrics->temperature_core[0],
+		&metrics.CoreTemperature[0],
+		sizeof(uint16_t) * 16);
+	gpu_metrics->temperature_skin = metrics.SkinTemp;
+
+	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
+	gpu_metrics->average_vcn_activity = metrics.AverageVcnActivity;
+	memcpy(&gpu_metrics->average_ipu_activity[0],
+		&metrics.AverageIpuBusy[0],
+		sizeof(uint16_t) * 8);
+	memcpy(&gpu_metrics->average_core_c0_activity[0],
+		&metrics.AverageCoreC0Residency[0],
+		sizeof(uint16_t) * 16);
+	gpu_metrics->average_dram_reads = metrics.AverageDRAMReads;
+	gpu_metrics->average_dram_writes = metrics.AverageDRAMWrites;
+
+	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
+	gpu_metrics->average_ipu_power = metrics.IpuPower;
+	gpu_metrics->average_apu_power = metrics.ApuPower;
+	gpu_metrics->average_dgpu_power = metrics.dGpuPower;
+	gpu_metrics->average_core_power = metrics.AverageCorePower;
+	memcpy(&gpu_metrics->core_power[0],
+		&metrics.CorePower[0],
+		sizeof(uint16_t) * 16);
+
+	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
+	gpu_metrics->average_vpeclk_frequency = metrics.AverageVpeclkFrequency;
+	gpu_metrics->average_fclk_frequency = metrics.AverageFclkFrequency;
+	gpu_metrics->average_vclk_frequency = metrics.AverageVclkFrequency;
+	gpu_metrics->average_ipuclk_frequency = metrics.AverageIpuclkFrequency;
+
+	memcpy(&gpu_metrics->current_coreclk[0],
+		&metrics.CoreFrequency[0],
+		sizeof(uint16_t) * 16);
+	gpu_metrics->current_core_maxfreq = metrics.InfrastructureCpuMaxFreq;
+	gpu_metrics->current_gfx_maxfreq = metrics.InfrastructureGfxMaxFreq;
+
+	gpu_metrics->time_filter_alphavalue = metrics.FilterAlphaValue;
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v3_0);
+}
+
+static ssize_t smu_v14_0_0_get_legacy_gpu_metrics(struct smu_context *smu,
+						void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v2_1 *gpu_metrics =
 		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
-	SmuMetrics_t metrics;
+	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
 	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
@@ -510,6 +701,25 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v2_1);
 }
 
+static ssize_t smu_v14_0_0_common_get_gpu_metrics(struct smu_context *smu,
+				      void **table)
+{
+	uint32_t smu_version;
+	int ret = 0;
+
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret) {
+		return ret;
+	}
+
+	if (smu_version > 0x5d3500)
+			ret = smu_v14_0_0_get_gpu_metrics(smu, table);
+	else
+			ret = smu_v14_0_0_get_legacy_gpu_metrics(smu, table);
+
+	return ret;
+}
+
 static int smu_v14_0_0_mode2_reset(struct smu_context *smu)
 {
 	int ret;
@@ -728,20 +938,17 @@ static int smu_v14_0_0_get_current_clk_freq(struct smu_context *smu,
 		member_type = METRICS_AVERAGE_UCLK;
 		break;
 	case SMU_FCLK:
-		return smu_cmn_send_smc_msg_with_param(smu,
-						       SMU_MSG_GetFclkFrequency,
-						       0, value);
+		member_type = METRICS_AVERAGE_FCLK;
+		break;
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		return smu_cmn_send_smc_msg_with_param(smu,
-						       SMU_MSG_GetGfxclkFrequency,
-						       0, value);
+		member_type = METRICS_AVERAGE_GFXCLK;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	return smu_v14_0_0_get_smu_metrics_data(smu, member_type, value);
+	return smu_v14_0_0_common_get_smu_metrics_data(smu, member_type, value);
 }
 
 static int smu_v14_0_0_get_dpm_level_count(struct smu_context *smu,
@@ -1043,7 +1250,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.read_sensor = smu_v14_0_0_read_sensor,
 	.is_dpm_running = smu_v14_0_0_is_dpm_running,
 	.set_watermarks_table = smu_v14_0_0_set_watermarks_table,
-	.get_gpu_metrics = smu_v14_0_0_get_gpu_metrics,
+	.get_gpu_metrics = smu_v14_0_0_common_get_gpu_metrics,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v14_0_set_driver_table_location,	
-- 
2.25.1

