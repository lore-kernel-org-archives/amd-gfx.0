Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D92AC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 12:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B411410E2C0;
	Fri, 21 Feb 2025 12:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p55jf434";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9C010E2C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 12:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4Zx1lyhAbUNiNzn3uUh+bDRkI6xyUcGnACFaAk0X88zhVrKA5I25x4lLoFc5DHuj20lHUAQZUejSBuGKQ0UVOVLZtwv8p9Q32EwodPa3k8qiI4qY3WF0zsb/F9Fq4vh4c/H0wjjqXlQARgkY97kkajzENOfml0Z5Z5Hw6JxBJWcgtpem8UXH5UuZ3hclXVN9Z66DbwLXDUkxA1YjR+gtPNRB5cd0R8BU3BEGy683cb2BDm/IeGQ2fNM/BiNXR1f7c1U6fOpYNDOBzhiE7Q1FwdROdUSsKfn9tfA2tZTBiCE+pz7g47SUUvsSadJkE1KTvcKwGiUMkHFKqCtir5GzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdYYyK6+Uv6tFyrfEWd+uUT1htOYyWaTyVO2WvEhbXM=;
 b=MUSllu9+oHcuUUKB8um1uwrtQPY+L4pv4FH8C+fe2WVTacHnyPvnJlqaRbGWNrTVG9k0oMRR6IJl2d0KYK60eUTGbD0J8jNDrWnGEpIfKAaX/eI5CxkL00LmR0ooosAZ/FFiZDIkMjit8gTXI/Xe0L9SBSMcUA+FktVgZxYX1matcJVsagAW94yDL0D3qbSKbddBVGaqF9MZKxBw6sbqx/RPnS7yLdk+EnoftGC1AD9ZJyWBgM9N6Ze9+7bz4RZ5bkx1hbUE700+jreZ5KsT0AMTK+PMRq0OAu5x5GgxP2gBZc2bHggaDpi1CA+o87fkhXYqlnsQ/uX86MWvP4UAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdYYyK6+Uv6tFyrfEWd+uUT1htOYyWaTyVO2WvEhbXM=;
 b=p55jf434RIXmCWBdhCnrKPayYJ/Xrjz1rP79E5Iz8yItjPfCUWzhjx2Xn0HbRiX/waVHp/uM/MID8erZ3UinwswDpmRsHzEzZMlc4HiIWJEeH/wZ0pUAgbgXNizjUCuXGEmx5zkvoQCoWBBtvECg1tIe0QWvC2aVFAeK7URctq0=
Received: from BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::32)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Fri, 21 Feb 2025 12:19:41 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::1b) by BL1P222CA0027.outlook.office365.com
 (2603:10b6:208:2c7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 12:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 12:19:40 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 06:19:38 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amd/pm: Fetch static metrics table
Date: Fri, 21 Feb 2025 20:19:17 +0800
Message-ID: <20250221121920.779576-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250221121920.779576-1-asad.kamal@amd.com>
References: <20250221121920.779576-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: d5073ddf-7998-4f90-2957-08dd5272045b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DqR3QucpcRcVTMM+xUYlSsy4XXB6phJsk6eyW9XaMBWXQ+RqL+tTSx/Q7orv?=
 =?us-ascii?Q?Kh2AiEYsLXGPyDhgPRgtAC6XDxX/4sKetz6jxH9dR8F7N4kV7O88noLN12Q8?=
 =?us-ascii?Q?OXIGGjItTU80dhL7ccHLUTou54ktiVoUcDgIh9R7BJnM05dLUEtASY18pmhJ?=
 =?us-ascii?Q?Cjwts7zN6//FKP5ba2trbU8Vg2bQ5uUuV1nQ8qI3wEpf+rTP7OR/rPwgPHUF?=
 =?us-ascii?Q?qoCxwWuQWYNlyP35noaLD1bkvgPCiQrpYlYTYNsG8SPmPCMQlg9ta6mQ5hmP?=
 =?us-ascii?Q?mSsguR59lHMs9ViAxeVT2+C0DnFgV85MHAmcgJfJufPJ9JzexJYNYPrWBHn9?=
 =?us-ascii?Q?vg4AqcgPDfMUH5hop5l3Sf+dOaGydIPcFXRBU4L/UeQGGBxhrJuThNGhtoc1?=
 =?us-ascii?Q?+UIvfQqeBAq9thqFIK/XtsCVCWQYKmvVk44EKW0Qr+cCuWnL8lB+BZpQnz/r?=
 =?us-ascii?Q?shY9O3/SLo0PZoNL9TiCDedwIUdMk6HsfLOWbHAmdE3tV93uIECBdiX1lX2m?=
 =?us-ascii?Q?5fT44xj9gXjZNCPuwzCN5/t2qrEKVrqO4GHTDNABI/g/uYkGZ9cahmF2g3IC?=
 =?us-ascii?Q?4Dog90Lgbur0RnLw/UL9D01Vtup1H5H1LBLbvs1fWJpqHfZUWwJq4O9zmPnr?=
 =?us-ascii?Q?fQwVi2T0HDg2Cjfom+acMAt5ZMivYJnMzD/R176vTIefeHEkkD2qJwwcl7rq?=
 =?us-ascii?Q?7afFP6VA+2aYEnG1ZcrF/pqJCvxshgjs0TZZ7S0/i0YyFPeK2dxHrVietPuf?=
 =?us-ascii?Q?JeEcY1VM+X0R1yGvT2H7TLn1XLYZ7EyeUQkDXpGxfbaI5yRmLI3LhTKTg2k0?=
 =?us-ascii?Q?9DrzOyz51xwf9TAmCQyIbObLBDxNfSaFRtSFmH4xQqhI9xuEEtQwtWyIrora?=
 =?us-ascii?Q?Rx+0eqL9BrDPl6Tkyhbvgohn91lsaq8Ba+ObOpzyXVTTBYNCI5aT7J9iLWAu?=
 =?us-ascii?Q?kCeTxBj+DWXoKAd64LKruqIg64Tqw0QZ9DgDDFhCuvhNZSvNMiUjZA2w7WTn?=
 =?us-ascii?Q?CQUKxAKTaVrcNCj3ythHS7JB+OPi7h7ShToKTaHbuIH4A8wJUoTorTmt77cg?=
 =?us-ascii?Q?UmC2IphlAFML4T+EDJ/K2IkNu/m8tPXDBYO8VXzIxAut1DILt5aQry6wo0My?=
 =?us-ascii?Q?coY9UCBtL7fRn9HwCbDbuPj3K9v4Q9vOeTdcUI6v5U/NN0ky3hQxkZ9s3+Ir?=
 =?us-ascii?Q?2UsqZ4dqUnC6Lmez9GRfnPj/6zDyqdg+a8hEocFtd48qMxzdpYhQLnk5SHPh?=
 =?us-ascii?Q?ZsFT2uRiu7Tc+aiM5+iWb/nGVbPDM2cNnip1t2YYPC9Rqk1ayGKL9/pRDWKm?=
 =?us-ascii?Q?ow8zEC+iHnyC4KcBRt++PN7TFeIOv7ik8C5UPBacUELwMvMs+0X48lQ3TiXy?=
 =?us-ascii?Q?4XFIasU7AXLAj3Le23nd8Ifr+T5Mpj+oMDMLKOvmtPXE9PAAYVtZfwGyb4sF?=
 =?us-ascii?Q?wvXdFjvboL4hReDsSi7kbgs/LN2mUBJGVkoxue6y3yUFPKx0TT7FjXqg28Tv?=
 =?us-ascii?Q?oTbRXskbVKrMwBA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 12:19:40.8842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5073ddf-7998-4f90-2957-08dd5272045b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
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

Fetch clock frequency table from static metrics table for
smu_v13_0_12

v2: Move PPTable definition, remove unnecessary checks for getting
static metrics table(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  6 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 70 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 29 +++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 16 +++++
 4 files changed, 101 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 609a04c75129..4dc3b37d52b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -53,6 +53,10 @@
 
 #define SMU_13_VCLK_SHIFT		16
 
+#define SMUQ10_TO_UINT(x) ((x) >> 10)
+#define SMUQ10_FRAC(x) ((x) & 0x3ff)
+#define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
+
 extern const int pmfw_decoded_link_speed[5];
 extern const int pmfw_decoded_link_width[7];
 
@@ -307,6 +311,8 @@ int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
 
 void smu_v13_0_interrupt_work(struct smu_context *smu);
 bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
+int smu_v13_0_12_get_max_metrics_size(void);
+int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 5ad5dd879e81..1555fb954487 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -145,6 +145,76 @@ static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
 	return ret;
 }
 
+int smu_v13_0_12_get_max_metrics_size(void)
+{
+	return sizeof(StaticMetricsTable_t);
+}
+
+static int smu_v13_0_12_get_static_metrics_table(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	struct smu_table *table = &smu_table->driver_table;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetStaticMetricsTable, NULL);
+	if (ret) {
+		dev_info(smu->adev->dev,
+			 "Failed to export static metrics table!\n");
+		return ret;
+	}
+
+	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
+	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
+
+	return 0;
+}
+
+int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	StaticMetricsTable_t *static_metrics = (StaticMetricsTable_t *)smu_table->metrics_table;
+	struct PPTable_t *pptable =
+		(struct PPTable_t *)smu_table->driver_pptable;
+	int ret, i;
+
+	if (!pptable->Init) {
+		ret = smu_v13_0_12_get_static_metrics_table(smu);
+		if (ret)
+			return ret;
+
+		pptable->MaxSocketPowerLimit =
+			SMUQ10_ROUND(static_metrics->MaxSocketPowerLimit);
+		pptable->MaxGfxclkFrequency =
+			SMUQ10_ROUND(static_metrics->MaxGfxclkFrequency);
+		pptable->MinGfxclkFrequency =
+			SMUQ10_ROUND(static_metrics->MinGfxclkFrequency);
+
+		for (i = 0; i < 4; ++i) {
+			pptable->FclkFrequencyTable[i] =
+				SMUQ10_ROUND(static_metrics->FclkFrequencyTable[i]);
+			pptable->UclkFrequencyTable[i] =
+				SMUQ10_ROUND(static_metrics->UclkFrequencyTable[i]);
+			pptable->SocclkFrequencyTable[i] =
+				SMUQ10_ROUND(static_metrics->SocclkFrequencyTable[i]);
+			pptable->VclkFrequencyTable[i] =
+				SMUQ10_ROUND(static_metrics->VclkFrequencyTable[i]);
+			pptable->DclkFrequencyTable[i] =
+				SMUQ10_ROUND(static_metrics->DclkFrequencyTable[i]);
+			pptable->LclkFrequencyTable[i] =
+				SMUQ10_ROUND(static_metrics->LclkFrequencyTable[i]);
+		}
+
+		/* use AID0 serial number by default */
+		pptable->PublicSerialNumber_AID =
+			static_metrics->PublicSerialNumber_AID[0];
+
+		pptable->Init = true;
+	}
+
+	return 0;
+}
+
 bool smu_v13_0_12_is_dpm_running(struct smu_context *smu)
 {
 	int ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c43fce62df1c..c3e0da680cf8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -116,6 +116,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(RMA_MSG),
 	SMU_CAP(ACA_SYND),
 	SMU_CAP(SDMA_RESET),
+	SMU_CAP(STATIC_METRICS),
 	SMU_CAP(ALL),
 };
 
@@ -252,25 +253,6 @@ static const uint8_t smu_v13_0_6_throttler_map[] = {
 	[THROTTLER_PROCHOT_BIT]		= (SMU_THROTTLER_PROCHOT_GFX_BIT),
 };
 
-struct PPTable_t {
-	uint32_t MaxSocketPowerLimit;
-	uint32_t MaxGfxclkFrequency;
-	uint32_t MinGfxclkFrequency;
-	uint32_t FclkFrequencyTable[4];
-	uint32_t UclkFrequencyTable[4];
-	uint32_t SocclkFrequencyTable[4];
-	uint32_t VclkFrequencyTable[4];
-	uint32_t DclkFrequencyTable[4];
-	uint32_t LclkFrequencyTable[4];
-	uint32_t MaxLclkDpmRange;
-	uint32_t MinLclkDpmRange;
-	uint64_t PublicSerialNumber_AID;
-	bool Init;
-};
-
-#define SMUQ10_TO_UINT(x) ((x) >> 10)
-#define SMUQ10_FRAC(x) ((x) & 0x3ff)
-#define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
 #define GET_GPU_METRIC_FIELD(field, version) ((version == METRICS_VERSION_V0) ?\
 		(metrics_v0->field) : (metrics_v2->field))
 #define GET_METRIC_FIELD(field, version) ((version == METRICS_VERSION_V1) ?\
@@ -368,6 +350,9 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 
 	if (fw_ver >= 0x00561700)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
+
+	if (fw_ver >= 0x00561E00)
+		smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
 }
 
 static void smu_v13_0_6_init_caps(struct smu_context *smu)
@@ -523,13 +508,14 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
 	struct amdgpu_device *adev = smu->adev;
+	int gpu_metrcs_size = METRICS_TABLE_SIZE;
 
 	if (!(adev->flags & AMD_IS_APU))
 		SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU13_TOOL_SIZE,
 			       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
-		       METRICS_TABLE_SIZE,
+		       max(gpu_metrcs_size, smu_v13_0_12_get_max_metrics_size()),
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
@@ -776,6 +762,9 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	int ret, i, retry = 100;
 	uint32_t table_version;
 
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+		return smu_v13_0_12_setup_driver_pptable(smu);
+
 	/* Store one-time values in driver PPTable */
 	if (!pptable->Init) {
 		while (--retry) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 717fe669882e..83745909e564 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -35,6 +35,22 @@ typedef enum {
 /*3*/   NUM_METRICS                         = 3
 } METRICS_LIST_e;
 
+struct PPTable_t {
+	uint32_t MaxSocketPowerLimit;
+	uint32_t MaxGfxclkFrequency;
+	uint32_t MinGfxclkFrequency;
+	uint32_t FclkFrequencyTable[4];
+	uint32_t UclkFrequencyTable[4];
+	uint32_t SocclkFrequencyTable[4];
+	uint32_t VclkFrequencyTable[4];
+	uint32_t DclkFrequencyTable[4];
+	uint32_t LclkFrequencyTable[4];
+	uint32_t MaxLclkDpmRange;
+	uint32_t MinLclkDpmRange;
+	uint64_t PublicSerialNumber_AID;
+	bool Init;
+};
+
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
 
 #endif
-- 
2.46.0

