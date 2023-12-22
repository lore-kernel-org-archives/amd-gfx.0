Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10DEC46CD4
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 15:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7289510E7D2;
	Fri, 22 Dec 2023 15:27:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A7B10E7D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 15:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFXgXjoxJPTT0DwOnCCafBAtQNhprr4zpr52Eozz7lrbKBNNGwRPN3j+QMN1OmAWisjXkt8exN9yBq8tUgsX4tvY4CJVZVK9DQ7BkHzbjIAZ/2SPjlRDZbNULb/DIsSw+TwRJ6dNINlbwPwPoE8BshuWgvg1239pK9XK9L1dAhZ6OnAZEQ6THHyVMk9NWOq0cLclnD3ZQeaZFJ4vD28C1lUrFfEQ7+OVSUKSBqM1grODSJ+KzUiOvEpMqmm/hoJSoEJ1e4cLjx9fymc4Hi8aLZJzcWtqUYg3mcishKvhraBwz2X2mhDuMnVRvOluFha2wwREOJRyZ/ocFgctwOzBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sPTgDL8T+JUaW3R4yB0zlGdAvf2+mUoyzoevkAz6hc=;
 b=ED0OaK6N2Ybi8tkuWUydXOlfkcsQBUW+vOcxECdch6k7YYyfpBtk6ZZygOg/kJg7XuqmnLq5uRzaadO8QDoj1LUo+kleAjR85fSpManJaWuf4VTMgwZzU+ptPosm09JhQztdpk/9/yf/LondBod4ZbFVrA1ZHnfJamw/y3KjZZlL15MLtrij8fSJoPo85d9SylwdAToLeGbkSb/FJ0Z5WoeWCyKTmZE/3o5Mdj/dj3OzPXxRJUoFAA08FhHmcJ6IZMskiHlnREQ3ogbab3dlXzuSSusUWsSwZ2t8P41XfFlZB8NCxFxc86G9izwzxPvf5HUxQ+rayUK1EHY/Gj6oUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sPTgDL8T+JUaW3R4yB0zlGdAvf2+mUoyzoevkAz6hc=;
 b=WCx4/q7NCZfnR35QHbDSq1VHGhSgcevJ2gmGSMxysjeA3QgWKxbQZ9EqDIdvNZdA3eSynNnMK+cMGx0fSRlhxwiwr7FMVa2OC0XaL3R8G0NRKfh1T9liDktOFdfuXY/oSefpVcVwloym1+Puox/nTGW4oDNEODw6KQEUUXdScq8=
Received: from MW4PR03CA0034.namprd03.prod.outlook.com (2603:10b6:303:8e::9)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 15:27:43 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::e9) by MW4PR03CA0034.outlook.office365.com
 (2603:10b6:303:8e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 15:27:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.21 via Frontend Transport; Fri, 22 Dec 2023 15:27:43 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 22 Dec
 2023 09:27:39 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: Use separate metric table for APU
Date: Fri, 22 Dec 2023 23:27:24 +0800
Message-ID: <20231222152727.411440-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: b89d8d9e-4f3a-4f47-2803-08dc03028abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwiVUU1uH1qeKuU0k5ebLu5Ac9bZa+wXBsdBb8QjETFujOjwcSNHelZ7SplHFrL++dDcCrdp/qTQxVUPUZrkPi9T//E6youYtalMXGGfOaaH/wpZy9+W3oeqJBjxRcKPRwhISKmg28XUyn9bgjSEXWDM+5S+AHUhbB9UGyxfne06vLRtOrTcDWE0/hsNynn5kdnAJcwMUDt14wmcW0vatqioxcrJPMspzwmzspKQ0M02kbnG8bklRfLANsaVgj9O4A/m4ccs1iIHw2HtMOOZnWBdH9Y/FrEfXiDGi07AQs9VLiAMtL3ZFVGCaJFJgy1bLHwpTKBGazRKU6Z6LclT2uEU5ykgvhpGsJPaMEegz1L4CfmukBoVYxt2VWal2JVoDpbrk96agiPxgz9AfxQ+5Dcs0LBKD61JCTZ1RG/gLnXQXCqD2IvrbU3brHgkSA2rQWP38DUQlhOntVP0pScTlgXx8aff4GsnRETugtwP/oj+AjPhVLRbUPKKzNcUCvFKvzRNiSGUS3/QOH7GQgNrbpNBJZqdLdxfAGEfutFwdYXUxlshwttohGDuu+hp1UrZjq4KAZRRr62vZnrWxy50IAkcgtt06jGgvLLGHb6FL0/2E2piC7TmS6yubZjsqBtMVU9Rd6GIfviDBrlIpKAkGtdRJOVZNhXJJ+mrFux3w3PtVEnWyyb9XUVtPzWtf2+Q0h7SD/3R9S3RsAUD6kffzhBYf4otSjoBGkHYwF2+Y4BRUlFhcc44tIBzN/QjFcpYdeJ9h/t2wYTqaPJqhjWJlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(47076005)(478600001)(5660300002)(44832011)(7696005)(40480700001)(6666004)(40460700003)(426003)(336012)(16526019)(83380400001)(1076003)(26005)(2616005)(36860700001)(4326008)(8936002)(8676002)(81166007)(41300700001)(2906002)(86362001)(70586007)(70206006)(356005)(30864003)(6636002)(316002)(54906003)(110136005)(36756003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 15:27:43.0428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89d8d9e-4f3a-4f47-2803-08dc03028abe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
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
Cc: sepehr.khatir@amd.com, shiwu.zhang@amd.com, daniel.oliveira@amd.com,
 le.ma@amd.com, donald.cheung@amd.com, asad.kamal@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use separate metric table for APU and Non APU
systems for smu_v_13_0_6 to get metric data

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h   |  90 ++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 124 ++++++++++--------
 2 files changed, 156 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index fef2d290f3f2..8f166aa3043c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -219,7 +219,95 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint32_t PCIenReplayARolloverCountAcc;  // The Pcie counter itself is accumulated
   uint32_t PCIeNAKSentCountAcc;           // The Pcie counter itself is accumulated
   uint32_t PCIeNAKReceivedCountAcc;       // The Pcie counter itself is accumulated
-} MetricsTable_t;
+} MetricsTableX_t;
+
+typedef struct __attribute__((packed, aligned(4))) {
+  uint32_t AccumulationCounter;
+
+  //TEMPERATURE
+  uint32_t MaxSocketTemperature;
+  uint32_t MaxVrTemperature;
+  uint32_t MaxHbmTemperature;
+  uint64_t MaxSocketTemperatureAcc;
+  uint64_t MaxVrTemperatureAcc;
+  uint64_t MaxHbmTemperatureAcc;
+
+  //POWER
+  uint32_t SocketPowerLimit;
+  uint32_t MaxSocketPowerLimit;
+  uint32_t SocketPower;
+
+  //ENERGY
+  uint64_t Timestamp;
+  uint64_t SocketEnergyAcc;
+  uint64_t CcdEnergyAcc;
+  uint64_t XcdEnergyAcc;
+  uint64_t AidEnergyAcc;
+  uint64_t HbmEnergyAcc;
+
+  //FREQUENCY
+  uint32_t CclkFrequencyLimit;
+  uint32_t GfxclkFrequencyLimit;
+  uint32_t FclkFrequency;
+  uint32_t UclkFrequency;
+  uint32_t SocclkFrequency[4];
+  uint32_t VclkFrequency[4];
+  uint32_t DclkFrequency[4];
+  uint32_t LclkFrequency[4];
+  uint64_t GfxclkFrequencyAcc[8];
+  uint64_t CclkFrequencyAcc[96];
+
+  //FREQUENCY RANGE
+  uint32_t MaxCclkFrequency;
+  uint32_t MinCclkFrequency;
+  uint32_t MaxGfxclkFrequency;
+  uint32_t MinGfxclkFrequency;
+  uint32_t FclkFrequencyTable[4];
+  uint32_t UclkFrequencyTable[4];
+  uint32_t SocclkFrequencyTable[4];
+  uint32_t VclkFrequencyTable[4];
+  uint32_t DclkFrequencyTable[4];
+  uint32_t LclkFrequencyTable[4];
+  uint32_t MaxLclkDpmRange;
+  uint32_t MinLclkDpmRange;
+
+  //XGMI
+  uint32_t XgmiWidth;
+  uint32_t XgmiBitrate;
+  uint64_t XgmiReadBandwidthAcc[8];
+  uint64_t XgmiWriteBandwidthAcc[8];
+
+  //ACTIVITY
+  uint32_t SocketC0Residency;
+  uint32_t SocketGfxBusy;
+  uint32_t DramBandwidthUtilization;
+  uint64_t SocketC0ResidencyAcc;
+  uint64_t SocketGfxBusyAcc;
+  uint64_t DramBandwidthAcc;
+  uint32_t MaxDramBandwidth;
+  uint64_t DramBandwidthUtilizationAcc;
+  uint64_t PcieBandwidthAcc[4];
+
+  //THROTTLERS
+  uint32_t ProchotResidencyAcc;
+  uint32_t PptResidencyAcc;
+  uint32_t SocketThmResidencyAcc;
+  uint32_t VrThmResidencyAcc;
+  uint32_t HbmThmResidencyAcc;
+  uint32_t GfxLockXCDMak;
+
+  // New Items at end to maintain driver compatibility
+  uint32_t GfxclkFrequency[8];
+
+  //PSNs
+  uint64_t PublicSerialNumber_AID[4];
+  uint64_t PublicSerialNumber_XCD[8];
+  uint64_t PublicSerialNumber_CCD[12];
+
+  //XGMI Data tranfser size
+  uint64_t XgmiReadDataSizeAcc[8];//in KByte
+  uint64_t XgmiWriteDataSizeAcc[8];//in KByte
+} MetricsTableA_t;
 
 #define SMU_VF_METRICS_TABLE_VERSION 0x3
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 81b217bbdebb..96777a365133 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -248,6 +248,8 @@ struct PPTable_t {
 #define SMUQ10_TO_UINT(x) ((x) >> 10)
 #define SMUQ10_FRAC(x) ((x) & 0x3ff)
 #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
+#define GET_METRIC_FIELD(field) ((adev->flags & AMD_IS_APU) ?\
+		(metrics_a->field) : (metrics_x->field))
 
 struct smu_v13_0_6_dpm_map {
 	enum smu_clk_type clk_type;
@@ -330,7 +332,8 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU13_TOOL_SIZE,
 			       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
-	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(MetricsTable_t),
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
+		       max(sizeof(MetricsTableX_t), sizeof(MetricsTableA_t)),
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
@@ -338,7 +341,8 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
-	smu_table->metrics_table = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
+	smu_table->metrics_table = kzalloc(max(sizeof(MetricsTableX_t),
+		       sizeof(MetricsTableA_t)), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
@@ -469,9 +473,11 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
+	MetricsTableX_t *metrics_x = (MetricsTableX_t *)smu_table->metrics_table;
+	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
+	struct amdgpu_device *adev = smu->adev;
 	int ret, i, retry = 100;
 	uint32_t table_version;
 
@@ -483,7 +489,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 				return ret;
 
 			/* Ensure that metrics have been updated */
-			if (metrics->AccumulationCounter)
+			if (GET_METRIC_FIELD(AccumulationCounter))
 				break;
 
 			usleep_range(1000, 1100);
@@ -500,29 +506,29 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			table_version;
 
 		pptable->MaxSocketPowerLimit =
-			SMUQ10_ROUND(metrics->MaxSocketPowerLimit);
+			SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketPowerLimit));
 		pptable->MaxGfxclkFrequency =
-			SMUQ10_ROUND(metrics->MaxGfxclkFrequency);
+			SMUQ10_ROUND(GET_METRIC_FIELD(MaxGfxclkFrequency));
 		pptable->MinGfxclkFrequency =
-			SMUQ10_ROUND(metrics->MinGfxclkFrequency);
+			SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency));
 
 		for (i = 0; i < 4; ++i) {
 			pptable->FclkFrequencyTable[i] =
-				SMUQ10_ROUND(metrics->FclkFrequencyTable[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequencyTable)[i]);
 			pptable->UclkFrequencyTable[i] =
-				SMUQ10_ROUND(metrics->UclkFrequencyTable[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequencyTable)[i]);
 			pptable->SocclkFrequencyTable[i] = SMUQ10_ROUND(
-				metrics->SocclkFrequencyTable[i]);
+				GET_METRIC_FIELD(SocclkFrequencyTable)[i]);
 			pptable->VclkFrequencyTable[i] =
-				SMUQ10_ROUND(metrics->VclkFrequencyTable[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequencyTable)[i]);
 			pptable->DclkFrequencyTable[i] =
-				SMUQ10_ROUND(metrics->DclkFrequencyTable[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequencyTable)[i]);
 			pptable->LclkFrequencyTable[i] =
-				SMUQ10_ROUND(metrics->LclkFrequencyTable[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequencyTable)[i]);
 		}
 
 		/* use AID0 serial number by default */
-		pptable->PublicSerialNumber_AID = metrics->PublicSerialNumber_AID[0];
+		pptable->PublicSerialNumber_AID = GET_METRIC_FIELD(PublicSerialNumber_AID)[0];
 
 		pptable->Init = true;
 	}
@@ -824,7 +830,8 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 					    uint32_t *value)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
+	MetricsTableX_t *metrics_x = (MetricsTableX_t *)smu_table->metrics_table;
+	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	int xcc_id;
@@ -839,50 +846,50 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_GFXCLK:
 		if (smu->smc_fw_version >= 0x552F00) {
 			xcc_id = GET_INST(GC, 0);
-			*value = SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
+			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency)[xcc_id]);
 		} else {
 			*value = 0;
 		}
 		break;
 	case METRICS_CURR_SOCCLK:
 	case METRICS_AVERAGE_SOCCLK:
-		*value = SMUQ10_ROUND(metrics->SocclkFrequency[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency)[0]);
 		break;
 	case METRICS_CURR_UCLK:
 	case METRICS_AVERAGE_UCLK:
-		*value = SMUQ10_ROUND(metrics->UclkFrequency);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
 		break;
 	case METRICS_CURR_VCLK:
-		*value = SMUQ10_ROUND(metrics->VclkFrequency[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency)[0]);
 		break;
 	case METRICS_CURR_DCLK:
-		*value = SMUQ10_ROUND(metrics->DclkFrequency[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency)[0]);
 		break;
 	case METRICS_CURR_FCLK:
-		*value = SMUQ10_ROUND(metrics->FclkFrequency);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequency));
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = SMUQ10_ROUND(metrics->SocketGfxBusy);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy));
 		break;
 	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = SMUQ10_ROUND(metrics->DramBandwidthUtilization);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization));
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = SMUQ10_ROUND(metrics->SocketPower) << 8;
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower)) << 8;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = SMUQ10_ROUND(metrics->MaxHbmTemperature) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	/* This is the max of all VRs and not just SOC VR.
 	 * No need to define another data type for the same.
 	 */
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = SMUQ10_ROUND(metrics->MaxVrTemperature) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	default:
@@ -2071,63 +2078,66 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		(struct gpu_metrics_v1_4 *)smu_table->gpu_metrics_table;
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, xcc_id, inst, i;
-	MetricsTable_t *metrics;
+	MetricsTableX_t *metrics_x;
+	MetricsTableA_t *metrics_a;
 	u16 link_width_level;
 
-	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
-	ret = smu_v13_0_6_get_metrics_table(smu, metrics, true);
+	metrics_x = kzalloc(max(sizeof(MetricsTableX_t), sizeof(MetricsTableA_t)), GFP_KERNEL);
+	ret = smu_v13_0_6_get_metrics_table(smu, metrics_x, true);
 	if (ret) {
-		kfree(metrics);
+		kfree(metrics_x);
 		return ret;
 	}
 
+	metrics_a = (MetricsTableA_t *)metrics_x;
+
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 4);
 
 	gpu_metrics->temperature_hotspot =
-		SMUQ10_ROUND(metrics->MaxSocketTemperature);
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature));
 	/* Individual HBM stack temperature is not reported */
 	gpu_metrics->temperature_mem =
-		SMUQ10_ROUND(metrics->MaxHbmTemperature);
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature));
 	/* Reports max temperature of all voltage rails */
 	gpu_metrics->temperature_vrsoc =
-		SMUQ10_ROUND(metrics->MaxVrTemperature);
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature));
 
 	gpu_metrics->average_gfx_activity =
-		SMUQ10_ROUND(metrics->SocketGfxBusy);
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy));
 	gpu_metrics->average_umc_activity =
-		SMUQ10_ROUND(metrics->DramBandwidthUtilization);
+		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization));
 
 	gpu_metrics->curr_socket_power =
-		SMUQ10_ROUND(metrics->SocketPower);
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower));
 	/* Energy counter reported in 15.259uJ (2^-16) units */
-	gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
+	gpu_metrics->energy_accumulator = GET_METRIC_FIELD(SocketEnergyAcc);
 
 	for (i = 0; i < MAX_GFX_CLKS; i++) {
 		xcc_id = GET_INST(GC, i);
 		if (xcc_id >= 0)
 			gpu_metrics->current_gfxclk[i] =
-				SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency)[xcc_id]);
 
 		if (i < MAX_CLKS) {
 			gpu_metrics->current_socclk[i] =
-				SMUQ10_ROUND(metrics->SocclkFrequency[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency)[i]);
 			inst = GET_INST(VCN, i);
 			if (inst >= 0) {
 				gpu_metrics->current_vclk0[i] =
-					SMUQ10_ROUND(metrics->VclkFrequency[inst]);
+					SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency)[inst]);
 				gpu_metrics->current_dclk0[i] =
-					SMUQ10_ROUND(metrics->DclkFrequency[inst]);
+					SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency)[inst]);
 			}
 		}
 	}
 
-	gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
+	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
 
 	/* Throttle status is not reported through metrics now */
 	gpu_metrics->throttle_status = 0;
 
 	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
-	gpu_metrics->gfxclk_lock_status = metrics->GfxLockXCDMak >> GET_INST(GC, 0);
+	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak) >> GET_INST(GC, 0);
 
 	if (!(adev->flags & AMD_IS_APU)) {
 		link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
@@ -2139,38 +2149,38 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		gpu_metrics->pcie_link_speed =
 			smu_v13_0_6_get_current_pcie_link_speed(smu);
 		gpu_metrics->pcie_bandwidth_acc =
-				SMUQ10_ROUND(metrics->PcieBandwidthAcc[0]);
+				SMUQ10_ROUND(metrics_x->PcieBandwidthAcc[0]);
 		gpu_metrics->pcie_bandwidth_inst =
-				SMUQ10_ROUND(metrics->PcieBandwidth[0]);
+				SMUQ10_ROUND(metrics_x->PcieBandwidth[0]);
 		gpu_metrics->pcie_l0_to_recov_count_acc =
-				metrics->PCIeL0ToRecoveryCountAcc;
+				metrics_x->PCIeL0ToRecoveryCountAcc;
 		gpu_metrics->pcie_replay_count_acc =
-				metrics->PCIenReplayAAcc;
+				metrics_x->PCIenReplayAAcc;
 		gpu_metrics->pcie_replay_rover_count_acc =
-				metrics->PCIenReplayARolloverCountAcc;
+				metrics_x->PCIenReplayARolloverCountAcc;
 	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	gpu_metrics->gfx_activity_acc =
-		SMUQ10_ROUND(metrics->SocketGfxBusyAcc);
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusyAcc));
 	gpu_metrics->mem_activity_acc =
-		SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
+		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc));
 
 	for (i = 0; i < NUM_XGMI_LINKS; i++) {
 		gpu_metrics->xgmi_read_data_acc[i] =
-			SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
+			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc)[i]);
 		gpu_metrics->xgmi_write_data_acc[i] =
-			SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
+			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc)[i]);
 	}
 
-	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(metrics->XgmiWidth);
-	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(metrics->XgmiBitrate);
+	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth));
+	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate));
 
-	gpu_metrics->firmware_timestamp = metrics->Timestamp;
+	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp);
 
 	*table = (void *)gpu_metrics;
-	kfree(metrics);
+	kfree(metrics_x);
 
 	return sizeof(*gpu_metrics);
 }
-- 
2.42.0

