Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6626CD1297
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 15:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE1910E75E;
	Wed, 12 Nov 2025 15:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gOq2laQu";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3658010E75B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 15:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZLyI8fVkgybBIEFX4+mRGecrhVE7VYbK1C7/G68CFnfFR6mTr4SZIWzDInh+pN2ih+SEpY55pmKCi9NBVRDSw1T1g4PvsjNt0odY/OIRyU616Brct5+1yiS65Anjt0lDDH/pEdTvNCXEIdKrRgHUDEd1R2QDsswFKOofx9+gt6WDRelYuuWCoHvAZzW4hgNrAde2TJe/5xDRLst/pFatF0cz79wTQDS9JjuKtPBthF3w7bqk0mvxj+I6/UhKlnUSc3ti8pE6eSCV55/+txeHaasrq8P1jTl5mPp7rRdDviymZazep3jE6IspZboBIQaJhZLIpWZDC89zy7IOblsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plkOAZKM6lHfjfBeyPz6IMNacMUz8z2s88QYKM7NNSw=;
 b=o/LHO9RYptV+Hg5CIuRiDtmH6pcj7n33E1h5//ZXXmR5CsWyDVPDoelsnjg9Dsr4CNnHYDPVL+S0YRpe9mm0gkBHMGdTQX+eDZEQNWaxbpp1Q+UFA3FcExGsuj4rEm8qjPsm8P8TNQQCJDE+wc1sSyy4f5+nNmWC2Gwfzz30p3qMPzCyhRQK033Xe2fVaFgWeArS18CZFqiuTaqp3iFb+hveGmKAqD2HpfAmq3KWhMltukN8oz8gfRLFyc7TbGqVTd4OCIag9IKI1T3eMyNVwKOt+Gkfs3WD6mQNAwb3hS1rT94fIuZl5SEKTbzXnSiYu6ZMn4Le5H6N9j+4G/WzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plkOAZKM6lHfjfBeyPz6IMNacMUz8z2s88QYKM7NNSw=;
 b=gOq2laQum3FhQDS325m2zjRaBEMPS2ohWTke3OkHoX8Rh/uuAJTmVs/7PenoWiMEbkkUZsaEechuDXmDEpZAwxTaAj9H5n8SxTf5AZAvpCqyKCYy8S3SYBW8jk+VsqErQeW3CBwhFWMzGNdzqsraD0n/+iyyeSHUvxd8YjXg/Ic=
Received: from BYAPR05CA0065.namprd05.prod.outlook.com (2603:10b6:a03:74::42)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:28:44 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::dd) by BYAPR05CA0065.outlook.office365.com
 (2603:10b6:a03:74::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 15:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:28:44 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 07:28:32 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v2 3/4] drm/amd/pm: Fetch ubb power for smu_v13_0_12
Date: Wed, 12 Nov 2025 23:28:14 +0800
Message-ID: <20251112152815.203110-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251112152815.203110-1-asad.kamal@amd.com>
References: <20251112152815.203110-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: c0956731-5bc5-4055-f588-08de22002ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3RMJxOVFN6n3tCtM44wpzPjarLVH3gEEWCDNvCANMqAibTOgI3av1Hj3jtbp?=
 =?us-ascii?Q?vUHk2Gp7c8ufDlO1Ai1aCFGjA4bwTEbRShGfwpVDVqnEOgdvR/ZwSHRfEiwm?=
 =?us-ascii?Q?ZMYgTKtwR8q7KzqYmBBkNFpbDfqtcC0kuUtYS9Dn564BAMWFvjsWTjy7AhQ9?=
 =?us-ascii?Q?Hd6m39ZLMqZSAwb21ueDXNsgW64uechY3NUgIZwS5MmDacLIj5/l856pIXXk?=
 =?us-ascii?Q?C88QJgYdv4GZ8WGxvBDKpDH5cDQibuFcA/UeLn2iVyO76C9JkDg3+BZQudQs?=
 =?us-ascii?Q?QtPInRBTqfvHytr6oDU765VJivGordnO9sEyLw3kP5uzoAuv5QTTzovP+6Ll?=
 =?us-ascii?Q?cQHQlWR2gIVr9SdPKESY1cE6GB2af5pLsF4lmTK4pUPiBazbQVuNU3l8/a9H?=
 =?us-ascii?Q?3FhRFufz73jzRG8s2ciRF1FC4BNoGMXThgzGVu1IF7r11PldXfpYbleoGAd9?=
 =?us-ascii?Q?0NewAGXMOy65PQ6D01JccS9eq2JIcqOQNK40xvLS8hufZyfdUAGonrdKVwG0?=
 =?us-ascii?Q?AwKxWTvXutaqNWyK/DhdEQ/hjiIyNhaWnXSamiI7ZBqCSHlXMbJ2ZSsz8K/d?=
 =?us-ascii?Q?YWBzkFOQz+jmhX6zFLzXlNwfOs+eDoGoUKMB30Wd8o5deT4/B/seYHa7hy3J?=
 =?us-ascii?Q?yMCETV/8ZubrFbEdp+IP8X0w+G8UvA2fdV16LR8IAUh3bapfEFSe3NAbXHKT?=
 =?us-ascii?Q?PVHxP510LpRk9IrneB6ytIAYyvuF9dkefMBRVU6cXC/rTbGbg7EV6hyoRimI?=
 =?us-ascii?Q?c22CU12iBSMfkmgsPNFj3JRIWFh5QMzUpw2qUjqX3o7kDzzWk7Uls7q1vCbS?=
 =?us-ascii?Q?TQ/zmwWiC8eJVnolPX/DpOPQ44SMvdI8QGnYCcQLOkf4uRMUpUGAH/Y50D9Z?=
 =?us-ascii?Q?WolxomZLd+2ZCb9tD5wz/WGubwWovbsKFagY3zPpTzL/Rsh22TD4PNnPQtaY?=
 =?us-ascii?Q?F9fm2mvS2RmIBbw6prwtSNbLfhTqX7SqQHGyzCR3b/KzmtY4UcAs1jPz7gqU?=
 =?us-ascii?Q?GtNklCX+L2q51HWEMZg7bXfV75ieAlEV6MME4sAJ7xEj9ea8LorddyjS7WO4?=
 =?us-ascii?Q?RW8qsgyI6tJqnOfXlpuXlOy3QYzba0VngCX+kevGmrt8Ozw2m+3uXMaO2DEC?=
 =?us-ascii?Q?rdgxmAaWjG2urBJOZ3zBF+rvrd7q51PDNY16nQ8dca3NgWzQEWKx6RhUjaX9?=
 =?us-ascii?Q?DQ9HkPkXAAHYr8Z5Z/sQdOed+xMK/OovQBCGeTL5z21YY/iUOonDqOmvzUPq?=
 =?us-ascii?Q?XyL0aACF5TV+HRUevBowHn6OgtEJQeIcEDENWaizQPSSYE7pIK/TFITEOwhI?=
 =?us-ascii?Q?tgHM/ukXi7G39KeUr6YtADCvi6v6JOPhhetL0PL65uiZzHDB20XmX13KyxY3?=
 =?us-ascii?Q?Wo4Z0Cmv6ipPmWlAXcMHDMh1GIC/mM038YEQhUqDFGC8dh3Bl5N7+KPZv8e/?=
 =?us-ascii?Q?nDm5KMTZrNaloekWRABPKfyFXFlpYal1E234yvhcI8EF9maHoGqwq7FTARQj?=
 =?us-ascii?Q?yoIQqLT+a/kgDr92yq18q8H318Atpq4z5WtI91LVja2tXUiLkhxJQ10udgrN?=
 =?us-ascii?Q?fxlmYkG/4xqKoEz7elk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:28:44.5977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0956731-5bc5-4055-f588-08de22002ad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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

Feth ubb power from system metrics table for smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 34 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  7 ++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  4 +++
 3 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 9e635f733fbf..07bee1f32f54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -601,6 +601,40 @@ static bool smu_v13_0_12_is_temp_metrics_supported(struct smu_context *smu,
 	return false;
 }
 
+int smu_v13_0_12_get_system_power(struct smu_context *smu,
+				  enum amd_pp_sensors sensor,
+				  uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	SystemMetricsTable_t *metrics;
+	struct smu_table *sys_table;
+	int ret;
+
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SYSTEM_POWER_METRICS)))
+		return -EOPNOTSUPP;
+
+	ret = smu_v13_0_12_get_system_metrics_table(smu);
+	if (ret)
+		return ret;
+
+	sys_table = &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
+	metrics = (SystemMetricsTable_t *)sys_table->cache.buffer;
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_UBB_POWER:
+		*value = metrics->SystemPower[SYSTEM_POWER_UBB_POWER];
+		break;
+	case AMDGPU_PP_SENSOR_UBB_POWER_LIMIT:
+		*value = metrics->SystemPower[SYSTEM_POWER_UBB_POWER_THRESHOLD];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 int smu_v13_0_12_get_npm_data(struct smu_context *smu,
 			      enum amd_pp_sensors sensor,
 			      uint32_t *value)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 44e1cd821eec..2fefd258bc0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1860,6 +1860,13 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
 			return ret;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_UBB_POWER:
+	case AMDGPU_PP_SENSOR_UBB_POWER_LIMIT:
+		ret = smu_v13_0_12_get_system_power(smu, sensor, (uint32_t *)data);
+		if (ret)
+			return ret;
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 	default:
 		ret = -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 6cbdd7c5ded9..0588a5aa952d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -77,6 +77,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(NPM_METRICS),
 	SMU_CAP(RAS_EEPROM),
 	SMU_CAP(FAST_PPT),
+	SMU_CAP(SYSTEM_POWER_METRICS),
 	SMU_CAP(ALL),
 };
 
@@ -107,6 +108,9 @@ void smu_v13_0_12_tables_fini(struct smu_context *smu);
 int smu_v13_0_12_get_npm_data(struct smu_context *smu,
 			      enum amd_pp_sensors sensor,
 			      uint32_t *value);
+int smu_v13_0_12_get_system_power(struct smu_context *smu,
+				  enum amd_pp_sensors sensor,
+				  uint32_t *value);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
-- 
2.46.0

