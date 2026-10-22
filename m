Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A7606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3RxwtEAP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10301125E0;
	Thu, 22 Oct 2026 12:51:54 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72CEA1125E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 12:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8/C3LEeiM612sAGdJJgPoO169o8uNnD4B7r3ZbjzLiVTWXaok1X9A5hAnGiWHk681JSdNHaOwR9rW5J/X+iJS/uckTsepuUysaELokCbwTrgHFdIE1jPXVzWnnrMQmRS4frcIBh/HLn/RkDlJuoeVnEOsLVMQh8PkYFuKhhShluSSsgXCACpLge1iMzoIaqZsm/GPFw2cx4VHQT8giDjFcko8GlmmQaTiH0BiB/uZOeA6eihYnE13OT6gBGR2Yf8HkGZaQZc+gZGXnA9S8RwG8QoLhmeMx9xZ29YF3FglDnNO64scyS0f2wAAN+bAG+r2zP6YeNuwaneGJe5umj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL3py7IG+aaaYRbObxrY8YzFqjg+sw1dXHD2ECObh9Q=;
 b=oa0Zk9Y9bIKuYlGvjyMKVYZagz44486t+90EAEN8LVQIU4R8+lso7uWaX+sogBqrT6omILblQjzIW3UmkDdc5ArFvFL14TwBtIWcDqeeZXEJQiYWwqmIKwrp+w07kRtQviPMZpBIFTcTqboNtR+QKVwD3jDw6i8PS3o/Ln0uMZtgNKqsE4HA3/3Fr0P3Hd/2HkPWR4XSX5BU+XZmso5s4aKSBFDfhhAEigNHwfO9HPJWdoNQkT+OCE/mVDWSddVB+RazyDkTtwpCz7o7FA1TwhGr3bC4Ihp78HXXgs3TFr46qplNF1blPqpcVg34wMo7CI9LKwJoQ1OfwhBetctxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL3py7IG+aaaYRbObxrY8YzFqjg+sw1dXHD2ECObh9Q=;
 b=3RxwtEAPjANrTlQA2aEvn+EqA0uK6+er+R8HLpOUCuEH46rNZThi/a3VHs0TXifV31cyBfXnZi7Ad9VBdtCBffJ+9NoltqWMMeY8EeZJeTK800bu8UlqV2TVIvFSM4l0pAz5kqxr23pAwLOqPDRiww1VVs7f06BTeebiV5iiOxY=
Received: from SJ0PR03CA0195.namprd03.prod.outlook.com (2603:10b6:a03:2ef::20)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 22 Oct
 2026 12:51:45 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a9) by SJ0PR03CA0195.outlook.office365.com
 (2603:10b6:a03:2ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Thu,
 22 Oct 2026 12:51:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 12:51:44 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 07:51:24 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Add a metrics revision for SMU 15.0.8
Date: Thu, 22 Oct 2026 20:49:17 +0800
Message-ID: <20261022124917.2232285-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261022124917.2232285-1-asad.kamal@amd.com>
References: <20261022124917.2232285-1-asad.kamal@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af9b32e-8e03-49e6-6558-08df303b3a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|261009223027099003|18002099003|10067099003|22082099003|261021123027099003|261021121427099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jOkEKsUwwlhYb6o6kqcAcyKjLBcin+17WFq8d0C+Jf6OcPZKV8DNItoOV81PlWJ01CQdQGUHIgUfh7uQYar4qPSh9YiW7AXbRqNUvu8/Jc1lbY/Ake9Ag7kb3ESMJMcMGEmcpLkDkletWZ9EbvztfIhst5mh1MK+cbHGgs0ch93JZtF+FuTYmOB6wD8Wu9xklGg5OP3+auVgS3j2zbfdNi/SkI3vbZNpr1mty02+SWZTn93RjSZ5MBNEb8mUBsmsosgSApOsFxVJTYKquGwvTAM7es8HGZ0HI6UjoQf1CjgrdkUk8JQQau1Hl+1kygYXPY2tEqsajPPr6C0555tzZJSSizixCrjVk8VRO8WsDrpLJVzjP+5ibenV4fXtFf+UR5uDQrlqICqAtY2S3CzMhQ0FRkNT5YDF4aCg/qTL3B3IM699GwXRsdk62+R6k7sa+5EY+4dTKtW1UQjNMfLQ5dML0DM3QAPeUGGoL7FsQNzJrAdZduRgZpDHGtgefNX3279WLGXPuhYfL4dFOHIRTYKgwhM7UmeOFUx7ZpHPC2S3Km7olrBbXPFfItqvP75yOQ5bB+NUYegvuucvkBwF3BXTPCohd6Dkri2mumpd0e+Gr8M6w3upRULpewOw2AdiCHtBlfvD5ra+OWvSwVW0PFhTS7IHLdAbkUzdZ34OwO0tfsXAHzvsPEUkLqchjRus5+NBsPJaP1EyaqtmGIzkBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(261009223027099003)(18002099003)(10067099003)(22082099003)(261021123027099003)(261021121427099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jMtFAJ+wvp6vE88gYg1VrYzOxrpXUpVhmma0NhDWZEHTPRFM4yYO0AagjqOx7jRAYPj3YISflaG+xzYqIixfm4v59vH4x6AYHTMkcToowvvbyG+2p/Sl9zjgjFlgST7cNGag9i46K0FOZJ9nBiU5v9xedIp9SlolXdkJf7K1GAYkV8p1uW7n8aTC7fbnLp8AyIjlf7qMaf5sEI0SpdUYmFnruBUSL6caEG0p7CNcyHp2ANAqfat76IdVGfCTsTMLTHaHrnQk6kE/hvLiP8d9DLmSVmw9d0o5aY6MKwZW63PGVcmlQUoja6jKhdPSbMzoaEkZ+Sfdr/p60xFpvJu6mGw6gTAS2HayNoFI2TKMYqvDTddOlOrlJ69tYfHVNzwvSvbX9ZiQ03GWbMu1PeqUeS3MnTrUMEItJzxa+j7jTlMVE8QmuIXrPAbk5+j6VgD1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:51:44.4442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af9b32e-8e03-49e6-6558-08df303b3a17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Publish a revision attribute from the SMU 15.0.8 GPU, partition, and
temperature metrics tables. The value starts at 1.

Increment a table's revision when its fields change.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  |  6 ++++++
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h  | 20 +++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 82c2a379ba4b..22c8fe511fb0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1652,6 +1652,8 @@ static void smu_v15_0_8_fill_baseboard_temp_metrics(
 		metrics->SystemTemperatures[SYSTEM_TEMP_IBC_HSC];
 	baseboard_temp_metrics->system_temp_ibc =
 		metrics->SystemTemperatures[SYSTEM_TEMP_IBC];
+	baseboard_temp_metrics->revision =
+		SMU_15_0_8_BASEBOARD_TEMP_METRICS_REVISION;
 }
 
 static void smu_v15_0_8_fill_gpuboard_temp_metrics(
@@ -1717,6 +1719,8 @@ static void smu_v15_0_8_fill_gpuboard_temp_metrics(
 		metrics->VrTemperatures[SVI_PLANE_VDDIO_065_UCIEAM_C_TEMP];
 	gpuboard_temp_metrics->vr_temp_vddan_075 =
 		metrics->VrTemperatures[SVI_PLANE_VDDAN_075_TEMP];
+	gpuboard_temp_metrics->revision =
+		SMU_15_0_8_GPUBOARD_TEMP_METRICS_REVISION;
 }
 
 static ssize_t smu_v15_0_8_get_temp_metrics(struct smu_context *smu,
@@ -1833,6 +1837,7 @@ static ssize_t smu_v15_0_8_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 
 	xcp_metrics->accumulation_counter = metrics->AccumulationCounter;
 	xcp_metrics->firmware_timestamp = metrics->Timestamp;
+	xcp_metrics->revision = SMU_15_0_8_PARTITION_METRICS_REVISION;
 
 	return sizeof(*xcp_metrics);
 }
@@ -1993,6 +1998,7 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(metrics->XgmiBitrate);
 
 	gpu_metrics->firmware_timestamp = metrics->Timestamp;
+	gpu_metrics->revision = SMU_15_0_8_GPU_METRICS_REVISION;
 
 	*table = gpu_metrics;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index dff601bc0f9a..59fd8a31ae1f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -35,6 +35,10 @@
 #define SMU_15_0_8_CAP_NPM			1
 #define SMU_15_0_8_CAP_NODE_UNLOAD		2
 #define SMU_15_0_8_NODE_UNLOAD_MIN_FW_VERSION	0x027d0c00u /* 2.125.12.0 */
+#define SMU_15_0_8_GPU_METRICS_REVISION			1
+#define SMU_15_0_8_GPUBOARD_TEMP_METRICS_REVISION	1
+#define SMU_15_0_8_BASEBOARD_TEMP_METRICS_REVISION	1
+#define SMU_15_0_8_PARTITION_METRICS_REVISION		1
 extern void smu_v15_0_8_set_ppt_funcs(struct smu_context *smu);
 
 typedef struct {
@@ -181,7 +185,9 @@ typedef struct {
 		  SMU_15_0_8_MAX_XCC);                                         \
 	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
 		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
-		  SMU_15_0_8_MAX_XCC);
+		  SMU_15_0_8_MAX_XCC);                                         \
+	SMU_SCALAR(SMU_MATTR(REVISION), SMU_MUNIT(NONE),                       \
+		   SMU_MTYPE(U16), revision);
 
 DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpu_metrics, SMU_15_0_8_METRICS_FIELDS);
 
@@ -251,7 +257,9 @@ DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpu_metrics, SMU_15_0_8_METRICS_FIELDS);
 	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDIO_065_UCIEAM_C), SMU_MUNIT(TEMP_1),   \
 		   SMU_MTYPE(S16), vr_temp_vddio_065_ucieam_c);                \
 	SMU_SCALAR(SMU_MATTR(VR_TEMP_VDDAN_075), SMU_MUNIT(TEMP_1),            \
-		   SMU_MTYPE(S16), vr_temp_vddan_075);
+		   SMU_MTYPE(S16), vr_temp_vddan_075);                          \
+	SMU_SCALAR(SMU_MATTR(REVISION), SMU_MUNIT(NONE),                       \
+		   SMU_MTYPE(U16), revision);
 
 DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpuboard_temp_metrics,
 			  SMU_15_0_8_GPUBOARD_TEMP_METRICS_FIELDS);
@@ -309,7 +317,9 @@ DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpuboard_temp_metrics,
 	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_IBC_HSC), SMU_MUNIT(TEMP_1),          \
 		   SMU_MTYPE(S16), system_temp_ibc_hsc);                       \
 	SMU_SCALAR(SMU_MATTR(SYSTEM_TEMP_IBC), SMU_MUNIT(TEMP_1),              \
-		   SMU_MTYPE(S16), system_temp_ibc);
+		   SMU_MTYPE(S16), system_temp_ibc);                            \
+	SMU_SCALAR(SMU_MATTR(REVISION), SMU_MUNIT(NONE),                       \
+		   SMU_MTYPE(U16), revision);
 
 DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_baseboard_temp_metrics,
 			  SMU_15_0_8_BASEBOARD_TEMP_METRICS_FIELDS);
@@ -343,7 +353,9 @@ DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_baseboard_temp_metrics,
 	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
 		   SMU_MTYPE(U64), accumulation_counter);                      \
 	SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),           \
-		   SMU_MTYPE(U64), firmware_timestamp);
+		   SMU_MTYPE(U64), firmware_timestamp);                         \
+	SMU_SCALAR(SMU_MATTR(REVISION), SMU_MUNIT(NONE),                       \
+		   SMU_MTYPE(U16), revision);
 
 DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_partition_metrics,
 			  SMU_15_0_8_PARTITION_METRICS_FIELDS);
-- 
2.46.0

