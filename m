Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928F9C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 10:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D9010E710;
	Thu, 23 Nov 2023 10:07:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BDB010E710
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 10:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eC1IvD26HpWfJLZXb9Ru3T4iDt0bh2HA6dzN92lqPBZiU38N1OTnA6CoRnu8qzUi6azN/Zl817FWXK1h4kxDdQvIikr+SQIdMrnbyQC9mLi58rTh/g7Mcd/Y0LytihAFd+3r2HJCopmIBzgA7VKkL313UW+AE/fzDfzG85crG4mVfAdfSOKBth0n1qJu9Hn5Lc8wr4llM7ghxzbXYcJxEbK7nh+Lae7lQDQNh5efazsbAJhRX/1GK8d39T44x+fHtjvTW5qN/NSZ4hyBX7IyRwCuYnq5P47xe9jZaS0BAOf+wHRdIhch6vcIy/gzE3gR0yKyCyg8CVd/nUW3Spn2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkT7WdxiOfo8cU0HI0CTGXLyu9xEZOFysQ36UWBV+Is=;
 b=CaU1lFNdy8kdJwGgjnWjOkdvYbzknh6wPazK1myfihHcddb3OjSvlW3pWxxtwchwPOoBFlZrVeDA1UO0Qs8/GCCqXnzrsTqXsOIbeXYtLA/vqG/oSR2B7A4veSfvgl2jRlz6rkLzlwXe2tG2J/yMyXxrVC1oE0khsCfS05shHmv5dkmvwOTEK8qpAObdnNk/E3EgNy+CRWvd9y8E58Cyu9ZWDNsidrBdoHw6eplGt4gDe6VWDgbcirNAKPF2+TsoEJYM9KbYdojQpxCVBP6cpDp/Kaw67MkvvHRMipsps8QfCVUUGJ+Ihi+keXc2cDkJKxCz7fw9y70vsyXU9FJUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkT7WdxiOfo8cU0HI0CTGXLyu9xEZOFysQ36UWBV+Is=;
 b=gpRqgQ9WBMfUZbiErS+ea+dAgmOY000nkRmvYGhn61Ka3ht1qxQ2Hv7wu4zMBPz4a46bGGwDUtQfyBZqx86ZKdMIcrf2jhQVdbgPrcEd/6bmDMtovFTU2RRg4NsQ2oCh+HGUuCsJBSN81TsSe5Uq78UNdzthRADagijzC4mXUiQ=
Received: from MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18) by
 MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 10:06:58 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::4f) by MW2PR16CA0005.outlook.office365.com
 (2603:10b6:907::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Thu, 23 Nov 2023 10:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.3 via Frontend Transport; Thu, 23 Nov 2023 10:06:58 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 04:06:55 -0600
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/swsmu: update smu v14_0_0 driver if version and
 metrics table
Date: Thu, 23 Nov 2023 18:06:45 +0800
Message-ID: <20231123100645.235821-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: b6086e0e-e752-459c-559f-08dbec0bee1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vsr+X33dq8TLFZsVOD32wm6MMZG9aFLyiKyGtMoaZ3mLFsy+Fg8f/CXPvh01/69TDy8NiQiZ2SzCbcgvAPWErlDDSi48viPLLTbiJSYlVccPAX/WhJDOgR7kvQoLocQbJWJ7EkRDxyWofydq3KYx+L5LI57SAXAe0520wLKNJ+66/CjTh7OTnERjAiBRZWfxlndsyrD2RtOK5VfAswfjkE9SZ/muU+FgoWNMjUCgGfmje9YQhY8eRtd4EV9klZoTjs+1NBYFlu2bjxS274afUflC1xpcG37kALuxuewn4G6czkdoZBfZNSnuUTEUmzSrp/IhFkwmavLc8dRAnUjwLZUvG9M8HqHsw1C+gtiIjeIe4yRJ0THQ1K4t0QrZ30W4PI45tMyT4eTAOFucqFcPnD6PlokqxpXsD54K8ac1UGhHrsdyeoZUsQtW5BTQOug6TEi28c0WAl8MJnn+yzqUpbqySFzjjm0kcjF9ff5MUJlq43d+WtTpjQeFO+/DnqgrN1eCZ8el6AdUKNRX6rp73bizBLoOQpznlN4IbnQyk6rChWM9ldlmt/p2uhKM+QytVrGWpNAZy+J8noa5TD//1UJgMO4ai6g1VF20uk6ywwQaEsCd+BNx+xQFqTnzlWrccuELppXkKxEOS5yx5y1vpfJqFk3JMjYdxFcl74oyjrNSlc8aDJV2lx+VryORpS7YeUpm4L3Y7N6n1XuTSQJlMjbU4500ICeL/OrmAbXLuYI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(83380400001)(2616005)(1076003)(26005)(16526019)(336012)(356005)(82740400003)(81166007)(40460700003)(36756003)(86362001)(15650500001)(44832011)(5660300002)(2906002)(30864003)(6666004)(47076005)(7696005)(478600001)(426003)(36860700001)(6916009)(54906003)(8676002)(316002)(4326008)(41300700001)(8936002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 10:06:58.5189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6086e0e-e752-459c-559f-08dbec0bee1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, lang.yu@amd.com,
 christian.koenig@amd.com, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Increment the driver if version and add new mems to the mertics table.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 17 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 10 +++
 .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     | 77 +++++++++++--------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 46 ++++++++++-
 4 files changed, 115 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 8ebba87f4289..eaea1c65e526 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1086,6 +1086,10 @@ struct gpu_metrics_v3_0 {
 	uint16_t			average_dram_reads;
 	/* time filtered DRAM write bandwidth [MB/sec] */
 	uint16_t			average_dram_writes;
+	/* time filtered IPU read bandwidth [MB/sec] */
+	uint16_t			average_ipu_reads;
+	/* time filtered IPU write bandwidth [MB/sec] */
+	uint16_t			average_ipu_writes;
 
 	/* Driver attached timestamp (in ns) */
 	uint64_t			system_clock_counter;
@@ -1105,6 +1109,8 @@ struct gpu_metrics_v3_0 {
 	uint32_t			average_all_core_power;
 	/* calculated core power [mW] */
 	uint16_t			average_core_power[16];
+	/* time filtered total system power [mW] */
+	uint16_t			average_sys_power;
 	/* maximum IRM defined STAPM power limit [mW] */
 	uint16_t			stapm_power_limit;
 	/* time filtered STAPM power limit [mW] */
@@ -1117,6 +1123,8 @@ struct gpu_metrics_v3_0 {
 	uint16_t			average_ipuclk_frequency;
 	uint16_t			average_fclk_frequency;
 	uint16_t			average_vclk_frequency;
+	uint16_t			average_uclk_frequency;
+	uint16_t			average_mpipu_frequency;
 
 	/* Current clocks */
 	/* target core frequency [MHz] */
@@ -1126,6 +1134,15 @@ struct gpu_metrics_v3_0 {
 	/* GFXCLK frequency limit enforced on GFX [MHz] */
 	uint16_t			current_gfx_maxfreq;
 
+	/* Throttle Residency (ASIC dependent) */
+	uint32_t throttle_residency_prochot;
+	uint32_t throttle_residency_spl;
+	uint32_t throttle_residency_fppt;
+	uint32_t throttle_residency_sppt;
+	uint32_t throttle_residency_thm_core;
+	uint32_t throttle_residency_thm_gfx;
+	uint32_t throttle_residency_thm_soc;
+
 	/* Metrics table alpha filter time constant [us] */
 	uint32_t			time_filter_alphavalue;
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index c125253df20b..c2265e027ca8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1418,6 +1418,16 @@ typedef enum {
 	METRICS_PCIE_WIDTH,
 	METRICS_CURR_FANPWM,
 	METRICS_CURR_SOCKETPOWER,
+	METRICS_AVERAGE_VPECLK,
+	METRICS_AVERAGE_IPUCLK,
+	METRICS_AVERAGE_MPIPUCLK,
+	METRICS_THROTTLER_RESIDENCY_PROCHOT,
+	METRICS_THROTTLER_RESIDENCY_SPL,
+	METRICS_THROTTLER_RESIDENCY_FPPT,
+	METRICS_THROTTLER_RESIDENCY_SPPT,
+	METRICS_THROTTLER_RESIDENCY_THM_CORE,
+	METRICS_THROTTLER_RESIDENCY_THM_GFX,
+	METRICS_THROTTLER_RESIDENCY_THM_SOC,
 } MetricsMember_t;
 
 enum smu_cmn2asic_mapping_type {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index 22f88842a7fd..8f42771e1f0a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if
 // any structure is changed in this file
-#define PMFW_DRIVER_IF_VERSION 6
+#define PMFW_DRIVER_IF_VERSION 7
 
 typedef struct {
   int32_t value;
@@ -150,37 +150,50 @@ typedef struct {
 } DpmClocks_t;
 
 typedef struct {
-  uint16_t CoreFrequency[16];        //Target core frequency [MHz]
-  uint16_t CorePower[16];            //CAC calculated core power [mW]
-  uint16_t CoreTemperature[16];      //TSEN measured core temperature [centi-C]
-  uint16_t GfxTemperature;           //TSEN measured GFX temperature [centi-C]
-  uint16_t SocTemperature;           //TSEN measured SOC temperature [centi-C]
-  uint16_t StapmOpnLimit;            //Maximum IRM defined STAPM power limit [mW]
-  uint16_t StapmCurrentLimit;        //Time filtered STAPM power limit [mW]
-  uint16_t InfrastructureCpuMaxFreq; //CCLK frequency limit enforced on classic cores [MHz]
-  uint16_t InfrastructureGfxMaxFreq; //GFXCLK frequency limit enforced on GFX [MHz]
-  uint16_t SkinTemp;                 //Maximum skin temperature reported by APU and HS2 chassis sensors [centi-C]
-  uint16_t GfxclkFrequency;          //Time filtered target GFXCLK frequency [MHz]
-  uint16_t FclkFrequency;            //Time filtered target FCLK frequency [MHz]
-  uint16_t GfxActivity;              //Time filtered GFX busy % [0-100]
-  uint16_t SocclkFrequency;          //Time filtered target SOCCLK frequency [MHz]
-  uint16_t VclkFrequency;            //Time filtered target VCLK frequency [MHz]
-  uint16_t VcnActivity;              //Time filtered VCN busy % [0-100]
-  uint16_t VpeclkFrequency;          //Time filtered target VPECLK frequency [MHz]
-  uint16_t IpuclkFrequency;          //Time filtered target IPUCLK frequency [MHz]
-  uint16_t IpuBusy[8];               //Time filtered IPU per-column busy % [0-100]
-  uint16_t DRAMReads;                //Time filtered DRAM read bandwidth [MB/sec]
-  uint16_t DRAMWrites;               //Time filtered DRAM write bandwidth [MB/sec]
-  uint16_t CoreC0Residency[16];      //Time filtered per-core C0 residency % [0-100]
-  uint16_t IpuPower;                 //Time filtered IPU power [mW]
-  uint32_t ApuPower;                 //Time filtered APU power [mW]
-  uint32_t GfxPower;                 //Time filtered GFX power [mW]
-  uint32_t dGpuPower;                //Time filtered dGPU power [mW]
-  uint32_t SocketPower;              //Time filtered power used for PPT/STAPM [APU+dGPU] [mW]
-  uint32_t AllCorePower;             //Time filtered sum of core power across all cores in the socket [mW]
-  uint32_t FilterAlphaValue;         //Metrics table alpha filter time constant [us]
-  uint32_t MetricsCounter;           //Counter that is incremented on every metrics table update [PM_TIMER cycles]
-  uint32_t spare[16];
+  uint16_t CoreFrequency[16];          //Target core frequency [MHz]
+  uint16_t CorePower[16];              //CAC calculated core power [mW]
+  uint16_t CoreTemperature[16];        //TSEN measured core temperature [centi-C]
+  uint16_t GfxTemperature;             //TSEN measured GFX temperature [centi-C]
+  uint16_t SocTemperature;             //TSEN measured SOC temperature [centi-C]
+  uint16_t StapmOpnLimit;              //Maximum IRM defined STAPM power limit [mW]
+  uint16_t StapmCurrentLimit;          //Time filtered STAPM power limit [mW]
+  uint16_t InfrastructureCpuMaxFreq;   //CCLK frequency limit enforced on classic cores [MHz]
+  uint16_t InfrastructureGfxMaxFreq;   //GFXCLK frequency limit enforced on GFX [MHz]
+  uint16_t SkinTemp;                   //Maximum skin temperature reported by APU and HS2 chassis sensors [centi-C]
+  uint16_t GfxclkFrequency;            //Time filtered target GFXCLK frequency [MHz]
+  uint16_t FclkFrequency;              //Time filtered target FCLK frequency [MHz]
+  uint16_t GfxActivity;                //Time filtered GFX busy % [0-100]
+  uint16_t SocclkFrequency;            //Time filtered target SOCCLK frequency [MHz]
+  uint16_t VclkFrequency;              //Time filtered target VCLK frequency [MHz]
+  uint16_t VcnActivity;                //Time filtered VCN busy % [0-100]
+  uint16_t VpeclkFrequency;            //Time filtered target VPECLK frequency [MHz]
+  uint16_t IpuclkFrequency;            //Time filtered target IPUCLK frequency [MHz]
+  uint16_t IpuBusy[8];                 //Time filtered IPU per-column busy % [0-100]
+  uint16_t DRAMReads;                  //Time filtered DRAM read bandwidth [MB/sec]
+  uint16_t DRAMWrites;                 //Time filtered DRAM write bandwidth [MB/sec]
+  uint16_t CoreC0Residency[16];        //Time filtered per-core C0 residency % [0-100]
+  uint16_t IpuPower;                   //Time filtered IPU power [mW]
+  uint32_t ApuPower;                   //Time filtered APU power [mW]
+  uint32_t GfxPower;                   //Time filtered GFX power [mW]
+  uint32_t dGpuPower;                  //Time filtered dGPU power [mW]
+  uint32_t SocketPower;                //Time filtered power used for PPT/STAPM [APU+dGPU] [mW]
+  uint32_t AllCorePower;               //Time filtered sum of core power across all cores in the socket [mW]
+  uint32_t FilterAlphaValue;           //Metrics table alpha filter time constant [us]
+  uint32_t MetricsCounter;             //Counter that is incremented on every metrics table update [PM_TIMER cycles]
+  uint16_t MemclkFrequency;            //Time filtered target MEMCLK frequency [MHz]
+  uint16_t MpipuclkFrequency;          //Time filtered target MPIPUCLK frequency [MHz]
+  uint16_t IpuReads;                   //Time filtered IPU read bandwidth [MB/sec]
+  uint16_t IpuWrites;                  //Time filtered IPU write bandwidth [MB/sec]
+  uint32_t ThrottleResidency_PROCHOT;  //Counter that is incremented on every metrics table update when PROCHOT was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_SPL;      //Counter that is incremented on every metrics table update when SPL was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_FPPT;     //Counter that is incremented on every metrics table update when fast PPT was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_SPPT;     //Counter that is incremented on every metrics table update when slow PPT was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_THM_CORE; //Counter that is incremented on every metrics table update when CORE thermal throttling was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_THM_GFX;  //Counter that is incremented on every metrics table update when GFX thermal throttling was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_THM_SOC;  //Counter that is incremented on every metrics table update when SOC thermal throttling was engaged [PM_TIMER cycles]
+  uint16_t Psys;                       //Time filtered Psys power [mW]
+  uint16_t spare1;
+  uint32_t spare[6];
 } SmuMetrics_t;
 
 //ISP tile definitions
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 03b38c3a9968..94ccdbfd7090 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -246,11 +246,20 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 		*value = 0;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		*value = 0;
+		*value = metrics->MemclkFrequency;
 		break;
 	case METRICS_AVERAGE_FCLK:
 		*value = metrics->FclkFrequency;
 		break;
+	case METRICS_AVERAGE_VPECLK:
+		*value = metrics->VpeclkFrequency;
+		break;
+	case METRICS_AVERAGE_IPUCLK:
+		*value = metrics->IpuclkFrequency;
+		break;
+	case METRICS_AVERAGE_MPIPUCLK:
+		*value = metrics->MpipuclkFrequency;
+		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
 		*value = metrics->GfxActivity / 100;
 		break;
@@ -270,8 +279,26 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->SocTemperature / 100 *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
-	case METRICS_THROTTLER_STATUS:
-		*value = 0;
+	case METRICS_THROTTLER_RESIDENCY_PROCHOT:
+		*value = metrics->ThrottleResidency_PROCHOT;
+		break;
+	case METRICS_THROTTLER_RESIDENCY_SPL:
+		*value = metrics->ThrottleResidency_SPL;
+		break;
+	case METRICS_THROTTLER_RESIDENCY_FPPT:
+		*value = metrics->ThrottleResidency_FPPT;
+		break;
+	case METRICS_THROTTLER_RESIDENCY_SPPT:
+		*value = metrics->ThrottleResidency_SPPT;
+		break;
+	case METRICS_THROTTLER_RESIDENCY_THM_CORE:
+		*value = metrics->ThrottleResidency_THM_CORE;
+		break;
+	case METRICS_THROTTLER_RESIDENCY_THM_GFX:
+		*value = metrics->ThrottleResidency_THM_GFX;
+		break;
+	case METRICS_THROTTLER_RESIDENCY_THM_SOC:
+		*value = metrics->ThrottleResidency_THM_SOC;
 		break;
 	case METRICS_VOLTAGE_VDDGFX:
 		*value = 0;
@@ -498,6 +525,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 		sizeof(uint16_t) * 16);
 	gpu_metrics->average_dram_reads = metrics.DRAMReads;
 	gpu_metrics->average_dram_writes = metrics.DRAMWrites;
+	gpu_metrics->average_ipu_reads = metrics.IpuReads;
+	gpu_metrics->average_ipu_writes = metrics.IpuWrites;
 
 	gpu_metrics->average_socket_power = metrics.SocketPower;
 	gpu_metrics->average_ipu_power = metrics.IpuPower;
@@ -505,6 +534,7 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_gfx_power = metrics.GfxPower;
 	gpu_metrics->average_dgpu_power = metrics.dGpuPower;
 	gpu_metrics->average_all_core_power = metrics.AllCorePower;
+	gpu_metrics->average_sys_power = metrics.Psys;
 	memcpy(&gpu_metrics->average_core_power[0],
 		&metrics.CorePower[0],
 		sizeof(uint16_t) * 16);
@@ -515,6 +545,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_fclk_frequency = metrics.FclkFrequency;
 	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
 	gpu_metrics->average_ipuclk_frequency = metrics.IpuclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
+	gpu_metrics->average_mpipu_frequency = metrics.MpipuclkFrequency;
 
 	memcpy(&gpu_metrics->current_coreclk[0],
 		&metrics.CoreFrequency[0],
@@ -522,6 +554,14 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_core_maxfreq = metrics.InfrastructureCpuMaxFreq;
 	gpu_metrics->current_gfx_maxfreq = metrics.InfrastructureGfxMaxFreq;
 
+	gpu_metrics->throttle_residency_prochot = metrics.ThrottleResidency_PROCHOT;
+	gpu_metrics->throttle_residency_spl = metrics.ThrottleResidency_SPL;
+	gpu_metrics->throttle_residency_fppt = metrics.ThrottleResidency_FPPT;
+	gpu_metrics->throttle_residency_sppt = metrics.ThrottleResidency_SPPT;
+	gpu_metrics->throttle_residency_thm_core = metrics.ThrottleResidency_THM_CORE;
+	gpu_metrics->throttle_residency_thm_gfx = metrics.ThrottleResidency_THM_GFX;
+	gpu_metrics->throttle_residency_thm_soc = metrics.ThrottleResidency_THM_SOC;
+
 	gpu_metrics->time_filter_alphavalue = metrics.FilterAlphaValue;
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
-- 
2.25.1

