Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455DACAC59A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 09:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E624E10E745;
	Tue, 16 Sep 2025 09:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EpePzba+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C5210E745
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 09:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRudMHbRLUvBkK27F3JOKCxnFheXbT6t9+/sF71099od9WcFQNhlILeN6Kk+ENlihAH0MAsE8vBxmy05+XKGci5pDKgObxCRipPK9Hc5/q0QQxB81fpWlI9yIda7jEDMNn5533tErKvbC4hlrrX9R4jlS+7d0UK+ARS1wQXdl2ILFMWpzhSJFhmsxNDn+EKFobfZYPGdLCYySH0rqPzqItUTn4BJZsf1HVEh/T1MNnnuLBwQ3PG8JG7qpTY3cLIUIGinxi3RehnB0Farxy5CoxknYTm1sR7KI0GYK/SULFhU5bG+S7xLjKVenmWVK0Nr4GN+etiRNRd8OzvF08Q6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR8n028g6AZTE73PUc3MLBR3Eraq1SOUHHXefvJV70w=;
 b=CIwhaGD1rBaNDRjl5Qgfg6OvzirNif7GmOyPCRuHRb+JSHTyFSKEAl1PXOeECrKie0dH9XqNkgUyvAL3TBrveFdOrN4zEV3bmCDpFfsdhpBiUTvPj4Isb2ssLLmc2ccvvGoaqDpUJ7LV3VfWWb1itYwD5TjgNkzvdRgY/tRnZejQtih9+PxzFO2xY/l1c4kPJ1kEyHAW3/cEVMYZPj24+lz6GDFHLPFU7wW4oWY+h1YLZTYWJPw+Q+OXLvSfWQFhIJY4TGbNqYAZo4CJxouMQjQ2Tra5TRzohxNbAz6qWGDBlUpGkowRVdP9dkms9y8MXSYoyos0nWILSk3bJ4KSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR8n028g6AZTE73PUc3MLBR3Eraq1SOUHHXefvJV70w=;
 b=EpePzba+d9mxg9G7JSfU6gL4bCeECTgPsW+Cfza+WSU4FdUlU9Dz8wxfqsnKBGlDJ7X2/Wo7GaKBFqe+MAw1IhcYt1aBEuNZe35bx2qYJ5wBBzVTHUrTPfsrH4OUJ+tl5a5LbBfMERAV4k010j5NPyAxm6/USG8kPHFal4td6C4=
Received: from CY5PR15CA0027.namprd15.prod.outlook.com (2603:10b6:930:14::20)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 09:05:54 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::64) by CY5PR15CA0027.outlook.office365.com
 (2603:10b6:930:14::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 09:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 09:05:54 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 02:05:50 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v3 5/6] drm/amd/pm: Fetch npm data from system metrics table
Date: Tue, 16 Sep 2025 17:05:26 +0800
Message-ID: <20250916090527.2727930-5-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250916090527.2727930-1-asad.kamal@amd.com>
References: <20250916090527.2727930-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcc73ef-5677-4198-c73f-08ddf5003dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HJbohsOCpNAcLJEh89RisFZWpc/oAQKKULpgBN8LeINgUiac0sPmhvqdJsi/?=
 =?us-ascii?Q?bVXl+mpZFNGGcPhOjxMQYHZsQTM1AQLws7tZX2xO6rBPQ73fy/b38AM9AtE3?=
 =?us-ascii?Q?ZJw3FR0tNFg9I9HcpW1B/UF66aR8eWRE9kVNlAhUfO19Zm30pCELKYUDL8mj?=
 =?us-ascii?Q?itTCzg475QulQQUyEgwoK3PdVmBS/O1fYUuPTwscYbfcNA7+TPRy6qXLLn9v?=
 =?us-ascii?Q?QUo5yEia5FrJ1Z4no6GMFBkVjoV1AWIodda3q8p8nfc+CCm73nIbC8TRdhhA?=
 =?us-ascii?Q?eGg5F1uSeBpMOdW9xcmecpGhk+oMN72f7JmOnWpa5TVvRcphsQssNmgJXm0i?=
 =?us-ascii?Q?7xmQszgn04THa/+n25jkD5/oKQ97h0jQNGIKkblcvcqrcuWDi3s1qnflR9M8?=
 =?us-ascii?Q?w6kJEFxhWiwDF0ZE176PejSoqJaxAUvy5FDtOXgqw2wQR9ZG8VsNQxTmgBbh?=
 =?us-ascii?Q?x/OnDN85mseo9MpRrfWSgotlMQZN23AuXrkMNs/CZ+JU/mDjmmS0DDPyDpu7?=
 =?us-ascii?Q?zvkjZiuL8xOTDOj5mXPY3J0mDVl/y61gxxjoQnvhw1A+8jQVU84mcO+/f+5H?=
 =?us-ascii?Q?JF8R582EY8hlcqWpDg7ZAoZ6eS/xQjBnNSp9Bc8BNRIn3v8lmNg4IBr2HkQg?=
 =?us-ascii?Q?05nOuAHREQDR3xACTCVBD6ngVUUwetXxemAoAQOAuVRi9sfIwYxwfW/JNPr3?=
 =?us-ascii?Q?p1oMv2wWzQkpbLOH24XP6/gg3X73APSMLj8F33QyAFLYKfsvjwnQUdx0csWL?=
 =?us-ascii?Q?cD1TdwWcNYVf8yh30d/fL2yUyM2mIwV6/V+thcPIXbNE+FXZ8JqgvjFrn8pP?=
 =?us-ascii?Q?86dkUMSNUT3r6bkChlpRFYDRFjhMwU2sU/w7m7i/lCGJumN87Y+esfivUh3j?=
 =?us-ascii?Q?CaSicjUL8FHOX3upSkpHuGx+eCzJlIp7RlMeprI795MNZLwf8y6yI2w2mu7w?=
 =?us-ascii?Q?vJh7DICxFwTrsb6fHk7552e+GQ3q6sPhM6AcXZTy1/sjZgnYIXQiBv/pr72D?=
 =?us-ascii?Q?FbMt+XVn3j5LyQWUc8h6//exq3GNBow0bDZXztc+I/+HPojGw/YIxDZyKDL0?=
 =?us-ascii?Q?vfvqI8NxP2oqOwTRsZM598SukizT2bFO+Hp7bO0YQZBEn2OnQayBvzQAfOox?=
 =?us-ascii?Q?c/lRAqGkUG5+Y+ctlE9pocHFWq+zaMRVPrCcn33+smnyR9qR0ldKNm2wob2u?=
 =?us-ascii?Q?PYRf2yO20jfjG493U+Y+anDnNicdO+5rI14pwZMIwYS0JhrIE8ZKdH67+cXL?=
 =?us-ascii?Q?MAY6lJBeKdQLLCZGbjKBdxh2JeNjQYCr1kELI4CRl6EWVajxzxtBn+wrmNQW?=
 =?us-ascii?Q?8XEu6BO4YI0zHm1auai5uyp0DGxu/8pzAd6jezGG3RuFMr2aOb4L1sCDFxcv?=
 =?us-ascii?Q?a57eOIf2t+b3BMkttOW5Mg7yJzy/7w55TSRxdEHg1r0QSbncm26jtHjz0oUy?=
 =?us-ascii?Q?AbmPS4UzhmJta/NjTRBIjFejxPmej5Xgb7Izz+TD2Zr6F/MiIfDrkQb9mlVn?=
 =?us-ascii?Q?J4VaImNMm+Ue3GWO2DdNMtDWnkKrN05Wq72u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:05:54.1334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcc73ef-5677-4198-c73f-08ddf5003dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777
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

Fetch npm data from system metrics table for smu_v13_0_12

v3: Remove intermittent type for npm data, remove node id check,
move npm caps check to npm_get_data function (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 48 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  9 ++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  5 ++
 3 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index f10228de416c..48d9ab52be85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -341,6 +341,9 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 			static_metrics->pldmVersion[0] != 0xFFFFFFFF)
 			smu->adev->firmware.pldm_version =
 				static_metrics->pldmVersion[0];
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(NPM_METRICS)))
+			pptable->MaxNodePowerLimit =
+				SMUQ10_ROUND(static_metrics->MaxNodePowerLimit);
 		smu_v13_0_12_init_xgmi_data(smu, static_metrics);
 		pptable->Init = true;
 	}
@@ -580,6 +583,51 @@ static bool smu_v13_0_12_is_temp_metrics_supported(struct smu_context *smu,
 	return false;
 }
 
+int smu_v13_0_12_get_npm_data(struct smu_context *smu,
+			      enum amd_pp_sensors sensor,
+			      uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct PPTable_t *pptable =
+		(struct PPTable_t *)smu_table->driver_pptable;
+	struct smu_table *tables = smu_table->tables;
+	SystemMetricsTable_t *metrics;
+	struct smu_table *sys_table;
+	int ret;
+
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(NPM_METRICS)))
+		return -EOPNOTSUPP;
+
+	if (sensor == AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT) {
+		*value = pptable->MaxNodePowerLimit;
+		return 0;
+	}
+
+	ret = smu_v13_0_12_get_system_metrics_table(smu);
+	if (ret)
+		return ret;
+
+	sys_table = &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
+	metrics = (SystemMetricsTable_t *)sys_table->cache.buffer;
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_NODEPOWERLIMIT:
+		*value = SMUQ10_ROUND(metrics->NodePowerLimit);
+		break;
+	case AMDGPU_PP_SENSOR_NODEPOWER:
+		*value = SMUQ10_ROUND(metrics->NodePower);
+		break;
+	case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
+		*value = SMUQ10_ROUND(metrics->GlobalPPTResidencyAcc);
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	return ret;
+}
+
 static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 					     enum smu_temp_metric_type type, void *table)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 85c0777d6e3e..f749acc7d48e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1801,6 +1801,15 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
 			ret = -EOPNOTSUPP;
 			break;
 		}
+	case AMDGPU_PP_SENSOR_NODEPOWERLIMIT:
+	case AMDGPU_PP_SENSOR_NODEPOWER:
+	case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
+	case AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT:
+		ret = smu_v13_0_12_get_npm_data(smu, sensor, (uint32_t *)data);
+		if (ret)
+			return ret;
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 	default:
 		ret = -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 4652fcd5e068..7ef5f3e66c27 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -49,6 +49,7 @@ struct PPTable_t {
 	uint32_t MaxLclkDpmRange;
 	uint32_t MinLclkDpmRange;
 	uint64_t PublicSerialNumber_AID;
+	uint32_t MaxNodePowerLimit;
 	bool Init;
 };
 
@@ -70,6 +71,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(BOARD_VOLTAGE),
 	SMU_CAP(PLDM_VERSION),
 	SMU_CAP(TEMP_METRICS),
+	SMU_CAP(NPM_METRICS),
 	SMU_CAP(ALL),
 };
 
@@ -91,6 +93,9 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu,
 				     void *smu_metrics);
 int smu_v13_0_12_tables_init(struct smu_context *smu);
 void smu_v13_0_12_tables_fini(struct smu_context *smu);
+int smu_v13_0_12_get_npm_data(struct smu_context *smu,
+			      enum amd_pp_sensors sensor,
+			      uint32_t *value);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
-- 
2.46.0

