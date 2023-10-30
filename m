Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B598C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 10:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F0110E0E5;
	Mon, 30 Oct 2023 10:55:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B289710E0E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 10:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYKIhpiuvnhSIpxxLm9lXtaXjU5DEixTTvzk6fz0wrhFLfS6aHd153mowRXRyAnKwvOl6bzkPPFoVRNYVKo3HLCTLDGCzDQqZ3W6ZAziQhxJgNQOxZ5dcd/TyuPoUDUg9weuQ58bs+/RwQnH/M0yAlwiimdQkar2FIJ4PzqahACLbk20kZDFVDjOHA2uullUXlNmUAeRv/DFB83SUBmtgw+/lvNyiXLYUsZ0gYeBJ/o9Wg1NGdSyjrIfez1+Hsguu3y37BwFur5nrqPFJEMi0GA7l3G+KlHrT1iVlqt0HRXzo4XAPdkYcSzlgSuLO01PU9RBfYa1YREZqow6Ui0kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsmPx/RtEumM9lf07lFs1jw+MAqpzVEPuCOyfMPfm5w=;
 b=HApSBfdCg1xUXWZWiGKsSL13Jj3LNzLDJb8j+4c/BTVTjo6yFC5dpWiDPKPedY85FfPxdKz2g5pTGrxUQgwtcSIEcAkkKcENxO3n9ykQdNFRCiEs4i137yn/pPJlsYocyFvs3dDMyZrpmHTCa03E7GnxeUvQGMruUtAD3mv2GSu4RZ0XmUvus9sdzdjOivQ142LoPsCm0HY+4urBW/byBj3RXQieBRNCB+LQSBgI3mNgrtFK/ygJ391hU8AY+xdnq4BFC5gz7fOr8H0EQmp+KCsbTUgvV+jcwk1ZyDztPvTzQ7mKzCA4w3yOCp7OmFUJEzkToH0PM/dLqtMnG5KkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsmPx/RtEumM9lf07lFs1jw+MAqpzVEPuCOyfMPfm5w=;
 b=eadRoUOOcmdgVUHSQNjrmuzz3shlqeNCYuYpHAkcnggnCw1M/RiVmak6UeV4XPz9jG3XmMTPbAhiv6HVl0vQZRizC5NNJjz1tAxBpQh9pLPU/SqdBAiSJlpqD2yZY+Snh6xtcwxgNWnqwMRgRw3CGtreimyMohJJc2mcZDi9a4k=
Received: from MN2PR20CA0057.namprd20.prod.outlook.com (2603:10b6:208:235::26)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 10:55:43 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::5c) by MN2PR20CA0057.outlook.office365.com
 (2603:10b6:208:235::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 10:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 10:55:43 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 05:55:40 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/swsmu: update smu v14_0_0 driver if and metrics
 table
Date: Mon, 30 Oct 2023 18:55:19 +0800
Message-ID: <20231030105519.1961123-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: d49daa5d-82c8-45ae-2152-08dbd936c377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wR0uD7kEJxW0LNnVr3qCl32sHB3+XV+Txduq+sDSD+ko7na4feC7xdKdkZEBfWZe+ZyF39JGiSWBoEelqMWhTbBmB1H6uJ8eMm+++C6joGfy9fqk0ccBRrQglri0r5CeWamq2uRUlInGzgcecowOQD6ouaNQIUUhArrvZpJ4KwzemDCuKqeplUDqw0pK7DwLQxydgP/tDubkJXeAAcYAKR73nrhuFgu/yh5HTne/ImLsS3ftOr3UcLKCcfWUhhOXFsa1piiRUBl/RfsRFrWyM9i9N4sn+YyQwwqmtVGFJQoOuQXGszmG9rXRuzqpQLgAeodlIj5vd2xmk6cGW9Bks8+Vw70sRPIxwmphmqiTe9W1M0W+9p7dohu5+0jzLFeSagP4UXWExopFIMGQmCkWifI9pKb/PIxUbKzN1ka/ov/2nu4IWaW7LO7H8dbsR9xadG/VeDXLrm5NjmCniKUlWCDhXwxjAzOa/mHsC+u8mrxsRrvWNmn6lQgVzCHpJZ65G8TdEEddI89OVmqXk9kVnTSm9+Ol/DdwXmTR5yYKTGAib/KMAM1QiJM8reVXFI6B2XurhoalaVtCmSW/hqjfqR5wqG5f0TPXr6n6cTBV5piTojUM4lbWjOb4hagDxWv34RVm4bJYmBuGe8OO9MYmnFttWWFKiB7E8RTERFRq1Yjj8j8Mr39g4yFlYtl/Tv6ZbJEiJXZsknRWx2JHlbe6CNbgXu+Nwpm8IsCgWq4Ygern2sdYDdYQNhsoAQorxz6q/4OBRbI4u1AXQXWmKgzIGfjzCf/iUePdlCOB6fWfL2gIWRMxvsI6RP8+ia0SY0vH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(230173577357003)(230273577357003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(2906002)(40480700001)(40460700003)(36860700001)(316002)(70206006)(81166007)(6916009)(54906003)(47076005)(82740400003)(356005)(6666004)(478600001)(7696005)(83380400001)(426003)(70586007)(5660300002)(26005)(2616005)(16526019)(336012)(1076003)(41300700001)(44832011)(15650500001)(30864003)(4326008)(86362001)(8676002)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 10:55:43.3414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49daa5d-82c8-45ae-2152-08dbd936c377
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, kenneth.feng@amd.com,
 Li Ma <li.ma@amd.com>, xiaojian.du@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update driver if headers and metrics table in smu v14_0_0 after smu fw promotion. And drop the legacy metrics table.
v1:
update header files
v2:
drop legacy metrics table and add warning of checking pmfw version.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  30 +-
 .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     | 120 +++-----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   2 +
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 260 +++---------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   3 +
 5 files changed, 97 insertions(+), 318 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 3201808c2dd8..cd3c40a86029 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1080,33 +1080,35 @@ struct gpu_metrics_v3_0 {
 	uint16_t			average_ipu_activity[8];
 	/* time filtered per-core C0 residency % [0-100]*/
 	uint16_t			average_core_c0_activity[16];
-	/* time filtered DRAM read bandwidth [GB/sec] */
+	/* time filtered DRAM read bandwidth [MB/sec] */
 	uint16_t			average_dram_reads;
-	/* time filtered DRAM write bandwidth [GB/sec] */
+	/* time filtered DRAM write bandwidth [MB/sec] */
 	uint16_t			average_dram_writes;
 
 	/* Driver attached timestamp (in ns) */
 	uint64_t			system_clock_counter;
 
 	/* Power/Energy */
-	/* average dGPU + APU power on A + A platform */
+	/* time filtered power used for PPT/STAPM [APU+dGPU] [mW] */
 	uint32_t			average_socket_power;
-	/* average IPU power [W] */
+	/* time filtered IPU power [mW] */
 	uint16_t			average_ipu_power;
-	/* average APU power [W] */
+	/* time filtered APU power [mW] */
 	uint32_t			average_apu_power;
-	/* average dGPU power [W] */
+	/* time filtered GFX power [mW] */
+	uint32_t			average_gfx_power;
+	/* time filtered dGPU power [mW] */
 	uint32_t			average_dgpu_power;
-	/* sum of core power across all cores in the socket [W] */
-	uint32_t			average_core_power;
-	/* calculated core power [W] */
-	uint16_t			core_power[16];
-	/* maximum IRM defined STAPM power limit [W] */
+	/* time filtered sum of core power across all cores in the socket [mW] */
+	uint32_t			average_all_core_power;
+	/* calculated core power [mW] */
+	uint16_t			average_core_power[16];
+	/* maximum IRM defined STAPM power limit [mW] */
 	uint16_t			stapm_power_limit;
-	/* time filtered STAPM power limit [W] */
+	/* time filtered STAPM power limit [mW] */
 	uint16_t			current_stapm_power_limit;
 
-	/* Average clocks */
+	/* time filtered clocks [MHz] */
 	uint16_t			average_gfxclk_frequency;
 	uint16_t			average_socclk_frequency;
 	uint16_t			average_vpeclk_frequency;
@@ -1115,7 +1117,7 @@ struct gpu_metrics_v3_0 {
 	uint16_t			average_vclk_frequency;
 
 	/* Current clocks */
-	/* target core frequency */
+	/* target core frequency [MHz] */
 	uint16_t			current_coreclk[16];
 	/* CCLK frequency limit enforced on classic cores [MHz] */
 	uint16_t			current_core_maxfreq;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index b483c8e096e7..22f88842a7fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -150,97 +150,39 @@ typedef struct {
 } DpmClocks_t;
 
 typedef struct {
-  uint16_t CoreFrequency[16];           //Target core frequency [MHz]
-  uint16_t CorePower[16];               //CAC calculated core power [W] [Q8.8]
-  uint16_t CoreTemperature[16];         //TSEN measured core temperature [C] [Q8.8]
-  uint16_t GfxTemperature;              //TSEN measured GFX temperature [C] [Q8.8]
-  uint16_t SocTemperature;              //TSEN measured SOC temperature [C] [Q8.8]
-  uint16_t StapmOpnLimit;               //Maximum IRM defined STAPM power limit [W] [Q8.8]
-  uint16_t StapmCurrentLimit;           //Time filtered STAPM power limit [W] [Q8.8]
-  uint16_t InfrastructureCpuMaxFreq;    //CCLK frequency limit enforced on classic cores [MHz]
-  uint16_t InfrastructureGfxMaxFreq;    //GFXCLK frequency limit enforced on GFX [MHz]
-  uint16_t SkinTemp;                    //Maximum skin temperature reported by APU and HS2 chassis sensors [C] [Q8.8]
-  uint16_t AverageGfxclkFrequency;      //Time filtered target GFXCLK frequency [MHz]
-  uint16_t AverageFclkFrequency;        //Time filtered target FCLK frequency [MHz]
-  uint16_t AverageGfxActivity;          //Time filtered GFX busy % [0-100] [Q8.8]
-  uint16_t AverageSocclkFrequency;      //Time filtered target SOCCLK frequency [MHz]
-  uint16_t AverageVclkFrequency;        //Time filtered target VCLK frequency [MHz]
-  uint16_t AverageVcnActivity;          //Time filtered VCN busy % [0-100] [Q8.8]
-  uint16_t AverageVpeclkFrequency;      //Time filtered target VPECLK frequency [MHz]
-  uint16_t AverageIpuclkFrequency;      //Time filtered target IPUCLK frequency [MHz]
-  uint16_t AverageIpuBusy[8];           //Time filtered IPU per-column busy % [0-100] [Q8.8]
-  uint16_t AverageDRAMReads;            //Time filtered DRAM read bandwidth [GB/sec] [Q8.8]
-  uint16_t AverageDRAMWrites;           //Time filtered DRAM write bandwidth [GB/sec] [Q8.8]
-  uint16_t AverageCoreC0Residency[16];  //Time filtered per-core C0 residency % [0-100] [Q8.8]
-  uint16_t IpuPower;                    //Time filtered IPU power [W] [Q8.8]
-  uint32_t ApuPower;                    //Time filtered APU power [W] [Q24.8]
-  uint32_t dGpuPower;                   //Time filtered dGPU power [W] [Q24.8]
-  uint32_t AverageSocketPower;          //Time filtered power used for PPT/STAPM [APU+dGPU] [W] [Q24.8]
-  uint32_t AverageCorePower;            //Time filtered sum of core power across all cores in the socket [W] [Q24.8]
-  uint32_t FilterAlphaValue;            //Metrics table alpha filter time constant [us]
-  uint32_t MetricsCounter;              //Counter that is incremented on every metrics table update [PM_TIMER cycles]
+  uint16_t CoreFrequency[16];        //Target core frequency [MHz]
+  uint16_t CorePower[16];            //CAC calculated core power [mW]
+  uint16_t CoreTemperature[16];      //TSEN measured core temperature [centi-C]
+  uint16_t GfxTemperature;           //TSEN measured GFX temperature [centi-C]
+  uint16_t SocTemperature;           //TSEN measured SOC temperature [centi-C]
+  uint16_t StapmOpnLimit;            //Maximum IRM defined STAPM power limit [mW]
+  uint16_t StapmCurrentLimit;        //Time filtered STAPM power limit [mW]
+  uint16_t InfrastructureCpuMaxFreq; //CCLK frequency limit enforced on classic cores [MHz]
+  uint16_t InfrastructureGfxMaxFreq; //GFXCLK frequency limit enforced on GFX [MHz]
+  uint16_t SkinTemp;                 //Maximum skin temperature reported by APU and HS2 chassis sensors [centi-C]
+  uint16_t GfxclkFrequency;          //Time filtered target GFXCLK frequency [MHz]
+  uint16_t FclkFrequency;            //Time filtered target FCLK frequency [MHz]
+  uint16_t GfxActivity;              //Time filtered GFX busy % [0-100]
+  uint16_t SocclkFrequency;          //Time filtered target SOCCLK frequency [MHz]
+  uint16_t VclkFrequency;            //Time filtered target VCLK frequency [MHz]
+  uint16_t VcnActivity;              //Time filtered VCN busy % [0-100]
+  uint16_t VpeclkFrequency;          //Time filtered target VPECLK frequency [MHz]
+  uint16_t IpuclkFrequency;          //Time filtered target IPUCLK frequency [MHz]
+  uint16_t IpuBusy[8];               //Time filtered IPU per-column busy % [0-100]
+  uint16_t DRAMReads;                //Time filtered DRAM read bandwidth [MB/sec]
+  uint16_t DRAMWrites;               //Time filtered DRAM write bandwidth [MB/sec]
+  uint16_t CoreC0Residency[16];      //Time filtered per-core C0 residency % [0-100]
+  uint16_t IpuPower;                 //Time filtered IPU power [mW]
+  uint32_t ApuPower;                 //Time filtered APU power [mW]
+  uint32_t GfxPower;                 //Time filtered GFX power [mW]
+  uint32_t dGpuPower;                //Time filtered dGPU power [mW]
+  uint32_t SocketPower;              //Time filtered power used for PPT/STAPM [APU+dGPU] [mW]
+  uint32_t AllCorePower;             //Time filtered sum of core power across all cores in the socket [mW]
+  uint32_t FilterAlphaValue;         //Metrics table alpha filter time constant [us]
+  uint32_t MetricsCounter;           //Counter that is incremented on every metrics table update [PM_TIMER cycles]
+  uint32_t spare[16];
 } SmuMetrics_t;
 
-typedef struct {
-  uint16_t GfxclkFrequency;             //[MHz]
-  uint16_t SocclkFrequency;             //[MHz]
-  uint16_t VclkFrequency;               //[MHz]
-  uint16_t DclkFrequency;               //[MHz]
-  uint16_t MemclkFrequency;             //[MHz]
-  uint16_t spare;
-  uint16_t UvdActivity;                 //[centi]
-  uint16_t GfxActivity;                 //[centi]
-
-  uint16_t Voltage[2];                  //[mV] indices: VDDCR_VDD, VDDCR_SOC
-  uint16_t Current[2];                  //[mA] indices: VDDCR_VDD, VDDCR_SOC
-  uint16_t Power[2];                    //[mW] indices: VDDCR_VDD, VDDCR_SOC
-
-  uint16_t CoreFrequency[8];            //[MHz]
-  uint16_t CorePower[8];                //[mW]
-  uint16_t CoreTemperature[8];          //[centi-Celsius]
-  uint16_t L3Frequency[2];              //[MHz]
-  uint16_t L3Temperature[2];            //[centi-Celsius]
-
-  uint16_t spare2[24];
-
-  uint16_t GfxTemperature;              //[centi-Celsius]
-  uint16_t SocTemperature;              //[centi-Celsius]
-  uint16_t ThrottlerStatus;
-
-  uint16_t CurrentSocketPower;          //[mW]
-  uint16_t StapmOpnLimit;               //[W]
-  uint16_t StapmCurrentLimit;           //[W]
-  uint32_t ApuPower;                    //[mW]
-  uint32_t dGpuPower;                   //[mW]
-
-  uint16_t VddTdcValue;                 //[mA]
-  uint16_t SocTdcValue;                 //[mA]
-  uint16_t VddEdcValue;                 //[mA]
-  uint16_t SocEdcValue;                 //[mA]
-
-  uint16_t InfrastructureCpuMaxFreq;    //[MHz]
-  uint16_t InfrastructureGfxMaxFreq;    //[MHz]
-
-  uint16_t SkinTemp;
-  uint16_t DeviceState;
-  uint16_t CurTemp;                     //[centi-Celsius]
-  uint16_t FilterAlphaValue;            //[m]
-
-  uint16_t AverageGfxclkFrequency;
-  uint16_t AverageFclkFrequency;
-  uint16_t AverageGfxActivity;
-  uint16_t AverageSocclkFrequency;
-  uint16_t AverageVclkFrequency;
-  uint16_t AverageVcnActivity;
-  uint16_t AverageDRAMReads;          //Filtered DF Bandwidth::DRAM Reads
-  uint16_t AverageDRAMWrites;         //Filtered DF Bandwidth::DRAM Writes
-  uint16_t AverageSocketPower;        //Filtered value of CurrentSocketPower
-  uint16_t AverageCorePower[2];       //Filtered of [sum of CorePower[8] per ccx])
-  uint16_t AverageCoreC0Residency[16]; //Filtered of [average C0 residency % per core]
-  uint16_t spare1;
-  uint32_t MetricsCounter;            //Counts the # of metrics table parameter reads per update to the metrics table, i.e. if the metrics table update happens every 1 second, this value could be up to 1000 if the smu collected metrics data every cycle, or as low as 0 if the smu was asleep the whole time. Reset to 0 after writing.
-} SmuMetrics_legacy_t;
-
 //ISP tile definitions
 typedef enum {
   TILE_XTILE = 0,         //ONO0
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 01f2ab456724..d8f8ad0e7137 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -229,6 +229,8 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_2;
 		break;
 	case IP_VERSION(14, 0, 0):
+		if ((smu->smc_fw_version < 0x5d3a00))
+			dev_warn(smu->adev->dev, "The PMFW version(%x) is behind in this BIOS!\n", smu->smc_fw_version);
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index c36fc10b63c8..03b38c3a9968 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -156,15 +156,10 @@ static int smu_v14_0_0_init_smc_tables(struct smu_context *smu)
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-	if (smu->smc_fw_version > 0x5d3500) {
-		SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
-			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-		smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
-	} else {
-		SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_legacy_t),
-			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-		smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_legacy_t), GFP_KERNEL);
-	}
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+
+	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		goto err0_out;
 	smu_table->metrics_time = 0;
@@ -177,10 +172,7 @@ static int smu_v14_0_0_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	if (smu->smc_fw_version > 0x5d3500)
-		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v3_0);
-	else
-		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v3_0);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err3_out;
@@ -242,13 +234,13 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 
 	switch (member) {
 	case METRICS_AVERAGE_GFXCLK:
-		*value = metrics->AverageGfxclkFrequency;
+		*value = metrics->GfxclkFrequency;
 		break;
 	case METRICS_AVERAGE_SOCCLK:
-		*value = metrics->AverageSocclkFrequency;
+		*value = metrics->SocclkFrequency;
 		break;
 	case METRICS_AVERAGE_VCLK:
-		*value = metrics->AverageVclkFrequency;
+		*value = metrics->VclkFrequency;
 		break;
 	case METRICS_AVERAGE_DCLK:
 		*value = 0;
@@ -257,25 +249,25 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 		*value = 0;
 		break;
 	case METRICS_AVERAGE_FCLK:
-		*value = metrics->AverageFclkFrequency;
+		*value = metrics->FclkFrequency;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = metrics->AverageGfxActivity >> 8;
+		*value = metrics->GfxActivity / 100;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
-		*value = metrics->AverageVcnActivity >> 8;
+		*value = metrics->VcnActivity / 100;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
 	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->AverageSocketPower & 0xff00) +
-		((metrics->AverageSocketPower & 0xff) * 100 >> 8);
+		*value = (metrics->SocketPower / 1000 << 8) +
+		(metrics->SocketPower % 1000 / 10);
 		break;
 	case METRICS_TEMPERATURE_EDGE:
-		*value = (metrics->GfxTemperature >> 8) *
+		*value = metrics->GfxTemperature / 100 *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = (metrics->SocTemperature >> 8) *
+		*value = metrics->SocTemperature / 100 *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
@@ -317,107 +309,6 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v14_0_0_legacy_get_smu_metrics_data(struct smu_context *smu,
-					    MetricsMember_t member,
-					    uint32_t *value)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-
-	SmuMetrics_legacy_t *metrics = (SmuMetrics_legacy_t *)smu_table->metrics_table;
-	int ret = 0;
-
-	ret = smu_cmn_get_metrics_table(smu, NULL, false);
-	if (ret)
-		return ret;
-
-	switch (member) {
-	case METRICS_AVERAGE_GFXCLK:
-		*value = metrics->GfxclkFrequency;
-		break;
-	case METRICS_AVERAGE_SOCCLK:
-		*value = metrics->SocclkFrequency;
-		break;
-	case METRICS_AVERAGE_VCLK:
-		*value = metrics->VclkFrequency;
-		break;
-	case METRICS_AVERAGE_DCLK:
-		*value = metrics->DclkFrequency;
-		break;
-	case METRICS_AVERAGE_UCLK:
-		*value = metrics->MemclkFrequency;
-		break;
-	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = metrics->GfxActivity / 100;
-		break;
-	case METRICS_AVERAGE_FCLK:
-		*value = metrics->AverageFclkFrequency;
-		break;
-	case METRICS_AVERAGE_VCNACTIVITY:
-		*value = metrics->UvdActivity;
-		break;
-	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = (metrics->AverageSocketPower << 8) / 1000;
-		break;
-	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->CurrentSocketPower << 8) / 1000;
-		break;
-	case METRICS_TEMPERATURE_EDGE:
-		*value = metrics->GfxTemperature / 100 *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = metrics->SocTemperature / 100 *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
-		break;
-	case METRICS_VOLTAGE_VDDGFX:
-		*value = metrics->Voltage[0];
-		break;
-	case METRICS_VOLTAGE_VDDSOC:
-		*value = metrics->Voltage[1];
-		break;
-	case METRICS_SS_APU_SHARE:
-		/* return the percentage of APU power with respect to APU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
-		 */
-		if (metrics->StapmOpnLimit > 0)
-			*value =  (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
-		else
-			*value = 0;
-		break;
-	case METRICS_SS_DGPU_SHARE:
-		/* return the percentage of dGPU power with respect to dGPU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
-		 */
-		if ((metrics->dGpuPower > 0) &&
-		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
-			*value = (metrics->dGpuPower * 100) /
-				 (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
-		else
-			*value = 0;
-		break;
-	default:
-		*value = UINT_MAX;
-		break;
-	}
-
-	return ret;
-}
-
-static int smu_v14_0_0_common_get_smu_metrics_data(struct smu_context *smu,
-					    MetricsMember_t member,
-					    uint32_t *value)
-{
-	if (smu->smc_fw_version > 0x5d3500)
-		return smu_v14_0_0_get_smu_metrics_data(smu, member, value);
-	else
-		return smu_v14_0_0_legacy_get_smu_metrics_data(smu, member, value);
-}
-
 static int smu_v14_0_0_read_sensor(struct smu_context *smu,
 				   enum amd_pp_sensors sensor,
 				   void *data, uint32_t *size)
@@ -429,69 +320,69 @@ static int smu_v14_0_0_read_sensor(struct smu_context *smu,
 
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_GFXACTIVITY,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
-		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_SOCKETPOWER,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
-		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_CURR_SOCKETPOWER,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
-		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_TEMPERATURE_EDGE,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_TEMPERATURE_HOTSPOT,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_UCLK,
 						       (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_GFXCLK,
 						       (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VDDGFX:
-		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_VOLTAGE_VDDGFX,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VDDNB:
-		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_VOLTAGE_VDDSOC,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
-		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_SS_APU_SHARE,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
-		ret = smu_v14_0_0_common_get_smu_metrics_data(smu,
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_SS_DGPU_SHARE,
 						       (uint32_t *)data);
 		*size = 4;
@@ -588,7 +479,7 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 3, 0);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -597,32 +488,33 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 		sizeof(uint16_t) * 16);
 	gpu_metrics->temperature_skin = metrics.SkinTemp;
 
-	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
-	gpu_metrics->average_vcn_activity = metrics.AverageVcnActivity;
+	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
+	gpu_metrics->average_vcn_activity = metrics.VcnActivity;
 	memcpy(&gpu_metrics->average_ipu_activity[0],
-		&metrics.AverageIpuBusy[0],
+		&metrics.IpuBusy[0],
 		sizeof(uint16_t) * 8);
 	memcpy(&gpu_metrics->average_core_c0_activity[0],
-		&metrics.AverageCoreC0Residency[0],
+		&metrics.CoreC0Residency[0],
 		sizeof(uint16_t) * 16);
-	gpu_metrics->average_dram_reads = metrics.AverageDRAMReads;
-	gpu_metrics->average_dram_writes = metrics.AverageDRAMWrites;
+	gpu_metrics->average_dram_reads = metrics.DRAMReads;
+	gpu_metrics->average_dram_writes = metrics.DRAMWrites;
 
-	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
+	gpu_metrics->average_socket_power = metrics.SocketPower;
 	gpu_metrics->average_ipu_power = metrics.IpuPower;
 	gpu_metrics->average_apu_power = metrics.ApuPower;
+	gpu_metrics->average_gfx_power = metrics.GfxPower;
 	gpu_metrics->average_dgpu_power = metrics.dGpuPower;
-	gpu_metrics->average_core_power = metrics.AverageCorePower;
-	memcpy(&gpu_metrics->core_power[0],
+	gpu_metrics->average_all_core_power = metrics.AllCorePower;
+	memcpy(&gpu_metrics->average_core_power[0],
 		&metrics.CorePower[0],
 		sizeof(uint16_t) * 16);
 
-	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
-	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
-	gpu_metrics->average_vpeclk_frequency = metrics.AverageVpeclkFrequency;
-	gpu_metrics->average_fclk_frequency = metrics.AverageFclkFrequency;
-	gpu_metrics->average_vclk_frequency = metrics.AverageVclkFrequency;
-	gpu_metrics->average_ipuclk_frequency = metrics.AverageIpuclkFrequency;
+	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
+	gpu_metrics->average_vpeclk_frequency = metrics.VpeclkFrequency;
+	gpu_metrics->average_fclk_frequency = metrics.FclkFrequency;
+	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
+	gpu_metrics->average_ipuclk_frequency = metrics.IpuclkFrequency;
 
 	memcpy(&gpu_metrics->current_coreclk[0],
 		&metrics.CoreFrequency[0],
@@ -638,68 +530,6 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v3_0);
 }
 
-static ssize_t smu_v14_0_0_get_legacy_gpu_metrics(struct smu_context *smu,
-						void **table)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
-	SmuMetrics_legacy_t metrics;
-	int ret = 0;
-
-	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
-	if (ret)
-		return ret;
-
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
-
-	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
-	gpu_metrics->temperature_soc = metrics.SocTemperature;
-	memcpy(&gpu_metrics->temperature_core[0],
-		&metrics.CoreTemperature[0],
-		sizeof(uint16_t) * 8);
-	gpu_metrics->temperature_l3[0] = metrics.L3Temperature[0];
-	gpu_metrics->temperature_l3[1] = metrics.L3Temperature[1];
-
-	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
-	gpu_metrics->average_mm_activity = metrics.UvdActivity;
-
-	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
-	gpu_metrics->average_gfx_power = metrics.Power[0];
-	gpu_metrics->average_soc_power = metrics.Power[1];
-	memcpy(&gpu_metrics->average_core_power[0],
-		&metrics.CorePower[0],
-		sizeof(uint16_t) * 8);
-
-	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
-	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
-	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
-	gpu_metrics->average_fclk_frequency = metrics.MemclkFrequency;
-	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
-	gpu_metrics->average_dclk_frequency = metrics.DclkFrequency;
-
-	memcpy(&gpu_metrics->current_coreclk[0],
-		&metrics.CoreFrequency[0],
-		sizeof(uint16_t) * 8);
-
-	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
-	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
-
-	*table = (void *)gpu_metrics;
-
-	return sizeof(struct gpu_metrics_v2_1);
-}
-
-static ssize_t smu_v14_0_0_common_get_gpu_metrics(struct smu_context *smu,
-				      void **table)
-{
-
-	if (smu->smc_fw_version > 0x5d3500)
-		return smu_v14_0_0_get_gpu_metrics(smu, table);
-	else
-		return smu_v14_0_0_get_legacy_gpu_metrics(smu, table);
-}
-
 static int smu_v14_0_0_mode2_reset(struct smu_context *smu)
 {
 	int ret;
@@ -928,7 +758,7 @@ static int smu_v14_0_0_get_current_clk_freq(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	return smu_v14_0_0_common_get_smu_metrics_data(smu, member_type, value);
+	return smu_v14_0_0_get_smu_metrics_data(smu, member_type, value);
 }
 
 static int smu_v14_0_0_get_dpm_level_count(struct smu_context *smu,
@@ -1230,7 +1060,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.read_sensor = smu_v14_0_0_read_sensor,
 	.is_dpm_running = smu_v14_0_0_is_dpm_running,
 	.set_watermarks_table = smu_v14_0_0_set_watermarks_table,
-	.get_gpu_metrics = smu_v14_0_0_common_get_gpu_metrics,
+	.get_gpu_metrics = smu_v14_0_0_get_gpu_metrics,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v14_0_set_driver_table_location,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 6e57c94379a9..001a5cf09657 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1004,6 +1004,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(2, 4):
 		structure_size = sizeof(struct gpu_metrics_v2_4);
 		break;
+	case METRICS_VERSION(3, 0):
+		structure_size = sizeof(struct gpu_metrics_v3_0);
+		break;
 	default:
 		return;
 	}
-- 
2.25.1

