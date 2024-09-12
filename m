Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6480EEB59D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 12:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 691B110EB77;
	Thu, 12 Sep 2024 12:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SomyfkmV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A067410EB6D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 12:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VY/sOrgtET8FALL8WWj1icY1gPPgAyitPCXfKuAQdpLMKWZdXxBrA1TLT9P3j2e5iuCC6/TmiYE5huUZ09kzMtYeBFThx4KsAa7SaUzYwBjpY8m4G72y+6M6m0ZArGKlXgxoeSxFmYGKrtn/Wn5heeIHsT7IoeiFbkM/ElG3v8CVl4ZpmYziSRwzRi4biam7Dj66ALrB8QP6gWRR9fET4BsN7DkEivvQ6cI6WMabKjKbuEQ3TARTeTKkGL7l5XqE7s1bnyUyaM/1ImBsq3ds7BtY8L650rtIg0M7ptQno+MapyZh203RfEjVfDQU2f0AvFb/AdrWBOTPIVphekngQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXM14WCv7NdDUQJD19OsWShIc9sT2lCSM264A8jn5lA=;
 b=e1DYf4jBscSqI/Zu/Z78TqS1Zy7yrNykclxzU17fXhSLNNjreJSJF9ljxPNPbUW0bLddHZsUSTwx9MWv2HEMi9jCPtqNS7fjs6M6yhOfvNXxU7rpmbmEhV1Coh70xlRgqHHOiHrloGus0aaQJDiC3E26UlQ1ZqW/vmDzlDigqsSt6xsJpdiueiA3/GJkl4ABLLpzPhSjkruORw9Eq5I4xDRgtv/qwPDfWeUsQ9YG4LIELqRkYNS3GGj+4YOducs196fA960jBJxJmeTHtlMnVgX0vL6MBF0nDgfYZjb3Yysd/1lEiZYgnCAdZhxWlI+9YGMcbMZX/b44onviSZn+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXM14WCv7NdDUQJD19OsWShIc9sT2lCSM264A8jn5lA=;
 b=SomyfkmV3DuEg7Qo+Ywr47NV2Z7LzKjNu9sWr+M2aNydGAR/CCuy9270l6dgv8J33S2ovNR+ya54PzjjvrxXiRFjprnYC8z+kMFynxQN0/Xl0u2PmvnJNTlUgFE/y30qXMC4jLuu/akygv9hRyQUSk+WG2UOElruivbcX9609r4=
Received: from CH2PR02CA0026.namprd02.prod.outlook.com (2603:10b6:610:4e::36)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 12:00:14 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::a) by CH2PR02CA0026.outlook.office365.com
 (2603:10b6:610:4e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 12:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 12:00:13 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 07:00:10 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 2/5] drm/amd/pm: Use same metric table for APU
Date: Thu, 12 Sep 2024 19:59:44 +0800
Message-ID: <20240912115947.2208807-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912115947.2208807-1-asad.kamal@amd.com>
References: <20240912115947.2208807-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d614df-d219-4dbd-7fdb-08dcd32275c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9wlK24tA1XPghXcbC0zo5FCW0jIi/9mPuj7rLlxADa13vlM6uzWcJ6tPSOZy?=
 =?us-ascii?Q?n5L4HZkW3e2iplhcMpN1uTyQwsuBFlImX5aRW026dONQk3mn68C6kPINhoep?=
 =?us-ascii?Q?lLr68NM6Mvtz9ovbc9MsfCg1QaAI5bZo3qKlwh3RgMj8758IeMaOv6ZbbFV4?=
 =?us-ascii?Q?NOTUbFoInHxBWXGutBu3qjmsdZJeNZ5FUow0rHX9VDdtalseD1NMwXRBFTwr?=
 =?us-ascii?Q?FZ4+ia20SXFjbAgtZhYeHPSSgtsfPo1lQCgGxtlDNwOSXNXMuSetfMW8ehjV?=
 =?us-ascii?Q?EcwZ8NKlGL9FYvahroOP/LC7P0vPURaX7dp6sXAQNUi3tGF0Q1H/eflFWQTL?=
 =?us-ascii?Q?pn1aAirI+w3yYh+GfixKSTfGSmWddFlki1dKPGGggymARGkhYUAPOUfkv4Zt?=
 =?us-ascii?Q?dkcEId/Mj0zCfZmWplcMwYufi70GkdEcEl35Ie1114zLXbGK6FtA0SFb/kbv?=
 =?us-ascii?Q?w1Ikeietfi8wX7JjEIG13Cv1lUTx7LzEfuJMWsf4Y6hGtZSw/kRGa8+MFiZ4?=
 =?us-ascii?Q?Nez1QC/TAPDyrL6yWqG8VaAsa7vJ5sc3nEyWSochNlFrOvMrWQhOtvWcFIFr?=
 =?us-ascii?Q?JCGkvMwR3OhILN+m8YfU+JRBk0wd8Bli/RgrEPecnTZE4m5G8L1hNl1sPEdi?=
 =?us-ascii?Q?u2IWmj0Z7KtDZLFSZFnHBx7CHh9qyCKg0aZVJE8YjJN6WOhai54OzawOhUNh?=
 =?us-ascii?Q?e+Zq/kdRQuBrbKQfQZCeNURNKca6+fMQfbXP08OK6PnYXEnyvwLsJpqY8N6N?=
 =?us-ascii?Q?ip32ByIfFZ9wbELe3t4S82BYW+MIUXYtpBh6adm8lopn1ns5Un3HjWSzQ/9l?=
 =?us-ascii?Q?O3UYNWd0sdNeDUdKgUsQmMpYHyXeEml4C4MaMKCcYihI691TnK4kklzl6UJt?=
 =?us-ascii?Q?Ga8mlqb+9JG+CyxY2MBaIRXG+FSIMFMypzhvYo4didHt5MZ5XDcvFyFUQpBf?=
 =?us-ascii?Q?xJeInKx62PwVFgXjz1mrCwpPC/m68AveWHz+KSVIZAzS9lQBm+iqiKw59Liv?=
 =?us-ascii?Q?eBtuK3JpgXlFnjGkcIqMnXfkunZ2O6I+tKtPivwWBDt2yQ4OvPVQznAnp0CO?=
 =?us-ascii?Q?BKprDMyM6khjvdi8XEihUnwPEiMJtKZU5r9VvTvh3Aq3hlKmkO2w1JEFT5QD?=
 =?us-ascii?Q?UKelTR/2EfCfKrbY3SYBrLV8e3HnHT3yxKVpqjOtvHJKlY3xeoseGdJ4RXNc?=
 =?us-ascii?Q?uTsjMd5Ege2fTr+m5eVSosIrE0W8lFL66Piat1ZjNFz+dOF1aRIjhYcAIF/w?=
 =?us-ascii?Q?qSTFsgy4nt5MddOzX1+1NX23LKdW45ep9825sa2LdUbf2Xt8ccOOJfHNZVXK?=
 =?us-ascii?Q?LnSXeTOwwQoJh1udQRJ2wwDuoCNAMz2uHbLRXznpAu4j1BvYebR2CKRJxZg9?=
 =?us-ascii?Q?uTzoyJb338MKtxsZs2UaXfOqoMlIMQfiFWOqGTpqXRhh/4oLQeLeA6hr7pRd?=
 =?us-ascii?Q?nrZiaNUzW9wzwQWTxJqSJ09JqHXgJoz2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 12:00:13.7278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d614df-d219-4dbd-7fdb-08dcd32275c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
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

Use same metric table for APU and Non APU systems
for smu_v_13_0_6 to get metric data based on newer pmfw
versions

v2: Use inline func to check for ubified metrics support

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 102 ++++++++++--------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9974c9f8135e..ee178914ca53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -102,6 +102,12 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
 	[AMDGPU_MCA_IP_##_ip] = { .hwid = _hwid, .mcatype = _type, }
 
+static inline bool smu_v13_0_6_is_unified_metrics(struct smu_context *smu)
+{
+	return (smu->adev->flags & AMD_IS_APU) &&
+		smu->smc_fw_version <= 0x4556900;
+}
+
 struct mca_bank_ipid {
 	enum amdgpu_mca_ip ip;
 	uint16_t hwid;
@@ -253,7 +259,7 @@ struct PPTable_t {
 #define SMUQ10_TO_UINT(x) ((x) >> 10)
 #define SMUQ10_FRAC(x) ((x) & 0x3ff)
 #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
-#define GET_METRIC_FIELD(field) ((adev->flags & AMD_IS_APU) ?\
+#define GET_METRIC_FIELD(field, flag) ((flag) ?\
 		(metrics_a->field) : (metrics_x->field))
 
 struct smu_v13_0_6_dpm_map {
@@ -583,7 +589,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
-	struct amdgpu_device *adev = smu->adev;
+	bool flag = smu_v13_0_6_is_unified_metrics(smu);
 	int ret, i, retry = 100;
 	uint32_t table_version;
 
@@ -595,7 +601,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 				return ret;
 
 			/* Ensure that metrics have been updated */
-			if (GET_METRIC_FIELD(AccumulationCounter))
+			if (GET_METRIC_FIELD(AccumulationCounter, flag))
 				break;
 
 			usleep_range(1000, 1100);
@@ -612,29 +618,29 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			table_version;
 
 		pptable->MaxSocketPowerLimit =
-			SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketPowerLimit));
+			SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketPowerLimit, flag));
 		pptable->MaxGfxclkFrequency =
-			SMUQ10_ROUND(GET_METRIC_FIELD(MaxGfxclkFrequency));
+			SMUQ10_ROUND(GET_METRIC_FIELD(MaxGfxclkFrequency, flag));
 		pptable->MinGfxclkFrequency =
-			SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency));
+			SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency, flag));
 
 		for (i = 0; i < 4; ++i) {
 			pptable->FclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequencyTable)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequencyTable, flag)[i]);
 			pptable->UclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequencyTable)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequencyTable, flag)[i]);
 			pptable->SocclkFrequencyTable[i] = SMUQ10_ROUND(
-				GET_METRIC_FIELD(SocclkFrequencyTable)[i]);
+				GET_METRIC_FIELD(SocclkFrequencyTable, flag)[i]);
 			pptable->VclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequencyTable)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequencyTable, flag)[i]);
 			pptable->DclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequencyTable)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequencyTable, flag)[i]);
 			pptable->LclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequencyTable)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequencyTable, flag)[i]);
 		}
 
 		/* use AID0 serial number by default */
-		pptable->PublicSerialNumber_AID = GET_METRIC_FIELD(PublicSerialNumber_AID)[0];
+		pptable->PublicSerialNumber_AID = GET_METRIC_FIELD(PublicSerialNumber_AID, flag)[0];
 
 		pptable->Init = true;
 	}
@@ -957,6 +963,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	MetricsTableX_t *metrics_x = (MetricsTableX_t *)smu_table->metrics_table;
 	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
+	bool flag = smu_v13_0_6_is_unified_metrics(smu);
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	int xcc_id;
@@ -971,50 +978,50 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_GFXCLK:
 		if (smu->smc_fw_version >= 0x552F00) {
 			xcc_id = GET_INST(GC, 0);
-			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency)[xcc_id]);
+			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, flag)[xcc_id]);
 		} else {
 			*value = 0;
 		}
 		break;
 	case METRICS_CURR_SOCCLK:
 	case METRICS_AVERAGE_SOCCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency)[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency, flag)[0]);
 		break;
 	case METRICS_CURR_UCLK:
 	case METRICS_AVERAGE_UCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, flag));
 		break;
 	case METRICS_CURR_VCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency)[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency, flag)[0]);
 		break;
 	case METRICS_CURR_DCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency)[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency, flag)[0]);
 		break;
 	case METRICS_CURR_FCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequency));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequency, flag));
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy, flag));
 		break;
 	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, flag));
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower)) << 8;
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, flag)) << 8;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature)) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature)) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, flag)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	/* This is the max of all VRs and not just SOC VR.
 	 * No need to define another data type for the same.
 	 */
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature)) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, flag)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	default:
@@ -2298,6 +2305,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_5 *gpu_metrics =
 		(struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
+	bool flag = smu_v13_0_6_is_unified_metrics(smu);
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, xcc_id, inst, i, j;
 	MetricsTableX_t *metrics_x;
@@ -2316,50 +2324,50 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 5);
 
 	gpu_metrics->temperature_hotspot =
-		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature));
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag));
 	/* Individual HBM stack temperature is not reported */
 	gpu_metrics->temperature_mem =
-		SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature));
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, flag));
 	/* Reports max temperature of all voltage rails */
 	gpu_metrics->temperature_vrsoc =
-		SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature));
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, flag));
 
 	gpu_metrics->average_gfx_activity =
-		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy));
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy, flag));
 	gpu_metrics->average_umc_activity =
-		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization));
+		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, flag));
 
 	gpu_metrics->curr_socket_power =
-		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower));
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, flag));
 	/* Energy counter reported in 15.259uJ (2^-16) units */
-	gpu_metrics->energy_accumulator = GET_METRIC_FIELD(SocketEnergyAcc);
+	gpu_metrics->energy_accumulator = GET_METRIC_FIELD(SocketEnergyAcc, flag);
 
 	for (i = 0; i < MAX_GFX_CLKS; i++) {
 		xcc_id = GET_INST(GC, i);
 		if (xcc_id >= 0)
 			gpu_metrics->current_gfxclk[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency)[xcc_id]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, flag)[xcc_id]);
 
 		if (i < MAX_CLKS) {
 			gpu_metrics->current_socclk[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency, flag)[i]);
 			inst = GET_INST(VCN, i);
 			if (inst >= 0) {
 				gpu_metrics->current_vclk0[i] =
-					SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency)[inst]);
+					SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency, flag)[inst]);
 				gpu_metrics->current_dclk0[i] =
-					SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency)[inst]);
+					SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency, flag)[inst]);
 			}
 		}
 	}
 
-	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
+	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, flag));
 
 	/* Throttle status is not reported through metrics now */
 	gpu_metrics->throttle_status = 0;
 
 	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
-	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak) >> GET_INST(GC, 0);
+	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak, flag) >> GET_INST(GC, 0);
 
 	if (!(adev->flags & AMD_IS_APU)) {
 		/*Check smu version, PCIE link speed and width will be reported from pmfw metric
@@ -2400,22 +2408,22 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	gpu_metrics->gfx_activity_acc =
-		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusyAcc));
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusyAcc, flag));
 	gpu_metrics->mem_activity_acc =
-		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc));
+		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc, flag));
 
 	for (i = 0; i < NUM_XGMI_LINKS; i++) {
 		gpu_metrics->xgmi_read_data_acc[i] =
-			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc)[i]);
+			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc, flag)[i]);
 		gpu_metrics->xgmi_write_data_acc[i] =
-			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc)[i]);
+			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc, flag)[i]);
 	}
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		inst = GET_INST(JPEG, i);
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			gpu_metrics->jpeg_activity[(i * adev->jpeg.num_jpeg_rings) + j] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy)
+				SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy, flag)
 				[(inst * adev->jpeg.num_jpeg_rings) + j]);
 		}
 	}
@@ -2423,13 +2431,13 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		inst = GET_INST(VCN, i);
 		gpu_metrics->vcn_activity[i] =
-			SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy)[inst]);
+			SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, flag)[inst]);
 	}
 
-	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth));
-	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate));
+	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth, flag));
+	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate, flag));
 
-	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp);
+	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, flag);
 
 	*table = (void *)gpu_metrics;
 	kfree(metrics_x);
-- 
2.46.0

