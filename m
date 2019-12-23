Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71076C2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 08:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE80206B7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 08:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DMJF5xg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE80206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D77916E194;
	Mon, 23 Dec 2019 08:05:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7A46E194
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 08:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR4KD/CVATW25WfcnXAVM/Wztt5VF1fPkV1biC9A8gKYaenrYGmeHnc69fJp2hubU7ZHEgrGpT5nKBtH02FNBViQTtVZsFH4Rd0GO9HD9WoOXvVvHmKcWxllI+AjqOmfnEUPEOxaGVto+KFaHoyKjups5gMCOzNFq2Z4ilPDACOo0nVdNYmCoSe+R5RV/n+NA0vIFD0aAmRBdj5hK3FICzpJuhKoVgpNOFrRs48dfvE5/nLKs8ZA2Oib6RHeCI0b4lHiVPaKWvHaNdNLn78SB4j7cL9xQjRsw3gnbsbAz5OiHQ/8MrYRZPVF1AMTIMs5+f50vqDocejWL6xLlJjVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMH4KxA9iZfwWh7YXDtomoefarmSNvPCyuScj16TGy8=;
 b=G0JB3pEBcH8Qlja81YF4J/yMzJkXAMEhktrmrgznGPuhacgNek6X3GiQQp+ZCGgEYpxENpGsG/YO+ekBENLeIY/4VxyxQYz99XCIbUn/4NXDNAH/zKIOfbZQWuR0/VcuVA0MFsqMQcp/lNcPPmtYl7/Fh2DTdafvm+2JntyM7ySAHysiAKssjlOOobvfsqdf7NH44RAuNn9ErdlEH/AZhMkfpwN695gOD8U0xXOeBmxxLEtWrtJSEj7eXvUA22/Ioqxq7ycChB2WJXMqP3jsoleWwegH/PyTnopVesAa4MrmiW7eC4gntzJtgByr6fYfMkwZ+nen6/+6zyXeDxFViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMH4KxA9iZfwWh7YXDtomoefarmSNvPCyuScj16TGy8=;
 b=DMJF5xg7UjVA++mPmrTBGKw//vSInHe5UUD5mwDHidd4xJkCETPTPyQMgp5xL+X8bYlZ0P6ECvIhdcavuNyaWnKpiKC8iBcw69ZKj2B4dd0CGIgsSkOF6qC4oB24HdYtgxuwBEGBMlegcm2KJQRP79en50zC/TtdzHamARGpFa8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3120.namprd12.prod.outlook.com (20.178.243.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Mon, 23 Dec 2019 08:05:38 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 08:05:37 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: support custom power profile setting
Date: Mon, 23 Dec 2019 16:05:18 +0800
Message-Id: <20191223080518.28754-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.8 via Frontend Transport; Mon, 23 Dec 2019 08:05:36 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edf6fecf-cb19-4aa3-2748-08d7877ee4fa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3120:|MN2PR12MB3120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB31208841AEAF36F78A3349D2E42E0@MN2PR12MB3120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-Forefront-PRVS: 0260457E99
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(189003)(66556008)(66946007)(66476007)(6486002)(6666004)(5660300002)(19627235002)(2906002)(36756003)(4326008)(81166006)(81156014)(8676002)(6916009)(44832011)(26005)(478600001)(16526019)(186003)(316002)(86362001)(52116002)(7696005)(1076003)(8936002)(2616005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3120;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjG8Iywoieh7j/O2fhHm8wM8431rrdKtQP1TTNqYTBOL8284QYQb7YZgcgW1Crw2kTOKr74g/AU+ulFO+PqggGIG7jTa+uGQSxcoBSIDBVdEazfboFjcsb3N2cYfPwZUpiobgJazGMD/WEabJucgl5+E9muZcYd75vKTeUhK3thdPy6kt5gqQ+pHdD9MbCdDrwPB0fFgoTysK7gJeffEYgwsPXrU4VpvE+IRzDeEMaU2Zl+zDAZZ+BF8nlWF0hywfDUSHuUGj72lqq5RyF73i8aO1HhEZtgCDVGfP8b44HkjLzdaRCe/XgVDFBRamIcqwLBm51ihmbnl044ZnGX2ea9eDwrbTv81TFYI63DLLGo4ORhjaMNrHLIxQj7+GBp5Bi+rnD5sM9HBrQD1FmjZGVEdMMQzd4NvW/tWFmG0Lx6pTnBeZ+LkcSezdi4P8CJQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf6fecf-cb19-4aa3-2748-08d7877ee4fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 08:05:37.7050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4h2O/54PoadKjwCgmPA6JiG3Bzv/wAz3h4mlfkI41Sgcsi743Sm4HKvrt1CUeXaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3120
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support custom power profile mode settings on Arcturus.

Change-Id: Id14f9a1cced41433b7487f447c452f8852964891
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 132 +++++++++++++++++-
 .../powerplay/inc/smu11_driver_if_arcturus.h  |   6 +-
 2 files changed, 128 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 9610b9b8a54c..043ac2ab0496 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -179,6 +179,7 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(DRIVER_SMU_CONFIG),
 	TAB_MAP(OVERDRIVE),
 	TAB_MAP(I2C_COMMANDS),
+	TAB_MAP(ACTIVITY_MONITOR_COEFF),
 };
 
 static struct smu_11_0_cmn2aisc_mapping arcturus_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -302,6 +303,10 @@ static int arcturus_tables_init(struct smu_context *smu, struct smu_table *table
 	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
 			       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
+	SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+		       sizeof(DpmActivityMonitorCoeffInt_t), PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM);
+
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		return -ENOMEM;
@@ -1314,6 +1319,7 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 static int arcturus_get_power_profile_mode(struct smu_context *smu,
 					   char *buf)
 {
+	DpmActivityMonitorCoeffInt_t activity_monitor;
 	static const char *profile_name[] = {
 					"BOOTUP_DEFAULT",
 					"3D_FULL_SCREEN",
@@ -1323,14 +1329,35 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 					"COMPUTE",
 					"CUSTOM"};
 	static const char *title[] = {
-			"PROFILE_INDEX(NAME)"};
+			"PROFILE_INDEX(NAME)",
+			"CLOCK_TYPE(NAME)",
+			"FPS",
+			"UseRlcBusy",
+			"MinActiveFreqType",
+			"MinActiveFreq",
+			"BoosterFreqType",
+			"BoosterFreq",
+			"PD_Data_limit_c",
+			"PD_Data_error_coeff",
+			"PD_Data_error_rate_coeff"};
 	uint32_t i, size = 0;
 	int16_t workload_type = 0;
+	int result = 0;
+	uint32_t smu_version;
 
-	if (!smu->pm_enabled || !buf)
+	if (!buf)
 		return -EINVAL;
 
-	size += sprintf(buf + size, "%16s\n",
+	result = smu_get_smc_version(smu, NULL, &smu_version);
+	if (result)
+		return result;
+
+	if (smu_version >= 0x360d00)
+		size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
+			title[0], title[1], title[2], title[3], title[4], title[5],
+			title[6], title[7], title[8], title[9], title[10]);
+	else
+		size += sprintf(buf + size, "%16s\n",
 			title[0]);
 
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
@@ -1342,8 +1369,50 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		if (workload_type < 0)
 			continue;
 
+		if (smu_version >= 0x360d00) {
+			result = smu_update_table(smu,
+						  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+						  workload_type,
+						  (void *)(&activity_monitor),
+						  false);
+			if (result) {
+				pr_err("[%s] Failed to get activity monitor!", __func__);
+				return result;
+			}
+		}
+
 		size += sprintf(buf + size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
+
+		if (smu_version >= 0x360d00) {
+			size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+				" ",
+				0,
+				"GFXCLK",
+				activity_monitor.Gfx_FPS,
+				activity_monitor.Gfx_UseRlcBusy,
+				activity_monitor.Gfx_MinActiveFreqType,
+				activity_monitor.Gfx_MinActiveFreq,
+				activity_monitor.Gfx_BoosterFreqType,
+				activity_monitor.Gfx_BoosterFreq,
+				activity_monitor.Gfx_PD_Data_limit_c,
+				activity_monitor.Gfx_PD_Data_error_coeff,
+				activity_monitor.Gfx_PD_Data_error_rate_coeff);
+
+			size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
+				" ",
+				1,
+				"UCLK",
+				activity_monitor.Mem_FPS,
+				activity_monitor.Mem_UseRlcBusy,
+				activity_monitor.Mem_MinActiveFreqType,
+				activity_monitor.Mem_MinActiveFreq,
+				activity_monitor.Mem_BoosterFreqType,
+				activity_monitor.Mem_BoosterFreq,
+				activity_monitor.Mem_PD_Data_limit_c,
+				activity_monitor.Mem_PD_Data_error_coeff,
+				activity_monitor.Mem_PD_Data_error_rate_coeff);
+		}
 	}
 
 	return size;
@@ -1353,18 +1422,69 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 					   long *input,
 					   uint32_t size)
 {
+	DpmActivityMonitorCoeffInt_t activity_monitor;
 	int workload_type = 0;
 	uint32_t profile_mode = input[size];
 	int ret = 0;
-
-	if (!smu->pm_enabled)
-		return -EINVAL;
+	uint32_t smu_version;
 
 	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
 		pr_err("Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
+	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
+		return ret;
+
+	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
+	     (smu_version >=0x360d00)) {
+		ret = smu_update_table(smu,
+				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				       WORKLOAD_PPLIB_CUSTOM_BIT,
+				       (void *)(&activity_monitor),
+				       false);
+		if (ret) {
+			pr_err("[%s] Failed to get activity monitor!", __func__);
+			return ret;
+		}
+
+		switch (input[0]) {
+		case 0: /* Gfxclk */
+			activity_monitor.Gfx_FPS = input[1];
+			activity_monitor.Gfx_UseRlcBusy = input[2];
+			activity_monitor.Gfx_MinActiveFreqType = input[3];
+			activity_monitor.Gfx_MinActiveFreq = input[4];
+			activity_monitor.Gfx_BoosterFreqType = input[5];
+			activity_monitor.Gfx_BoosterFreq = input[6];
+			activity_monitor.Gfx_PD_Data_limit_c = input[7];
+			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
+			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
+			break;
+		case 1: /* Uclk */
+			activity_monitor.Mem_FPS = input[1];
+			activity_monitor.Mem_UseRlcBusy = input[2];
+			activity_monitor.Mem_MinActiveFreqType = input[3];
+			activity_monitor.Mem_MinActiveFreq = input[4];
+			activity_monitor.Mem_BoosterFreqType = input[5];
+			activity_monitor.Mem_BoosterFreq = input[6];
+			activity_monitor.Mem_PD_Data_limit_c = input[7];
+			activity_monitor.Mem_PD_Data_error_coeff = input[8];
+			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
+			break;
+		}
+
+		ret = smu_update_table(smu,
+				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				       WORKLOAD_PPLIB_CUSTOM_BIT,
+				       (void *)(&activity_monitor),
+				       true);
+		if (ret) {
+			pr_err("[%s] Failed to set activity monitor!", __func__);
+			return ret;
+		}
+	}
+
 	/*
 	 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
 	 * Not all profile modes are supported on arcturus.
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
index a886f0644d24..910226ec512e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
@@ -823,7 +823,6 @@ typedef struct {
   uint32_t MmHubPadding[8]; // SMU internal use
 } AvfsFuseOverride_t;
 
-/* NOT CURRENTLY USED
 typedef struct {
   uint8_t   Gfx_ActiveHystLimit;
   uint8_t   Gfx_IdleHystLimit;
@@ -866,7 +865,6 @@ typedef struct {
 
   uint32_t  MmHubPadding[8]; // SMU internal use
 } DpmActivityMonitorCoeffInt_t;
-*/
 
 // These defines are used with the following messages:
 // SMC_MSG_TransferTableDram2Smu
@@ -878,11 +876,11 @@ typedef struct {
 #define TABLE_PMSTATUSLOG             4
 #define TABLE_SMU_METRICS             5
 #define TABLE_DRIVER_SMU_CONFIG       6
-//#define TABLE_ACTIVITY_MONITOR_COEFF  7
 #define TABLE_OVERDRIVE               7
 #define TABLE_WAFL_XGMI_TOPOLOGY      8
 #define TABLE_I2C_COMMANDS            9
-#define TABLE_COUNT                   10
+#define TABLE_ACTIVITY_MONITOR_COEFF  10
+#define TABLE_COUNT                   11
 
 // These defines are used with the SMC_MSG_SetUclkFastSwitch message.
 typedef enum {
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
