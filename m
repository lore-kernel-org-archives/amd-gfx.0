Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C892AC02182
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 09:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B7E10E6B0;
	Wed, 22 Jan 2025 09:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mm1TGUWW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D74A610E6A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 09:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyqAvDHdS/du/r3NO/mS5cHAqjE/HbXAT8sNK5Bq+8mdOEIWlmZiWz1de4REZ2A80Sg3h/HSDd3N99zL1Q54HY4P0w9raWIEnl/AEuFELDk/a2/SZGUorQ9T7qL/tUY7EmKo0Tq87DaxfDP01YSoD/aCIOPN6PmRa0Uy8coUOavC3gpahWt/NOCpxNTUNZbS28hM7oZRUPXui+ZXWL8DNjqtOtNtO/zvSENUCk5LDAKQFpmQDTFKaFjj61h+wovxZaiilyQXVjhf/xG1ktoh4vmxQ2iPaNjnumltDJPbBxQxbKKBpzgxomoToWwP89VWgoL1a1H4DYKdpVRQY9oVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iZ4l9b4++P58meNVVy0eg8BXSnYIXoucat7PYJrE/g=;
 b=PJKAbw1Vn64dB/HeTURrEAWQr0yFUZxDGRJTFch/kSe4ecbk82edKg/dw0AUHpp+CN98RM2ryydnVmGAVMXlA/V4GNRomwacT2guAH2bfMVUTm+gAg4AaQqeXm1cF6k+LKOAvVmHsfEQzTOR2EDmXC+gVzRBdozd9WlXlOCeHLQjFojBP+VP2BNUbG0hZ5ccUuZd5y9JR9lnh0s39Lq91aYP+4e3iAz1yd3flxC1U9YyG5izxIM0WEL7XfveqEWMgFfeyxGMdSgEzhYaTtlIogZLuujohDc6AtwK+CuIcjvWjWJ4leU2xiRHWhdBpjV85sq///vX+FvbcpM69A8nvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iZ4l9b4++P58meNVVy0eg8BXSnYIXoucat7PYJrE/g=;
 b=mm1TGUWW4NuQb259ufESf+pQaxfkzEyn4eiwd/hthdjW3KTClTpmyvcKFLmJXBQ8W8UjjV0w7BTj/zrVx3qmMfFcsYHfgR7tr67lr3nRId0DfIaWtXAlm2nWN1mB7/n7+h7nDnn1qTTPosq1Nfbe0yh5+Q0azcYtQIh7tDi0fDI=
Received: from DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17) by
 LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Wed, 22 Jan
 2025 09:56:22 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::1a) by DM6PR01CA0012.outlook.office365.com
 (2603:10b6:5:296::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Wed,
 22 Jan 2025 09:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 09:56:22 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Jan
 2025 03:56:18 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 4/6] drm/amd/pm: Add metrics support for smuv13.0.12
Date: Wed, 22 Jan 2025 17:55:41 +0800
Message-ID: <20250122095543.148993-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250122095543.148993-1-asad.kamal@amd.com>
References: <20250122095543.148993-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e174543-6f07-4293-4422-08dd3acb06ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?twygcFfj8md89NCDTZ703dMADstTa8+Ed0rjub8bfF7ktish9Ox4Q5cVsYPc?=
 =?us-ascii?Q?z0rtgOjz5bw3Ydmc+tp/87IoDxwMcv6X0BIaUz+t/W6QhqMXSGXY/qy7LbHd?=
 =?us-ascii?Q?gZaxKcdnfCEv8qaUYuZ8s9RPxMjMHwZl174vk/UTjSH62v/+Dm1pDhb9/lPs?=
 =?us-ascii?Q?XgZ/P60qEt+OZK/LCx+5kBWrCD6K8/0ofoGxPiZpRTIQLf+tC3jlxZ3n9bdJ?=
 =?us-ascii?Q?u0x7/VvFYSOTsWPq2heXr4ntTgO5Cfw8pOpc/8OgHgy6XMYFxGHo1Gjwl5cX?=
 =?us-ascii?Q?o0hxS2p5D6CH56d83VtoQIeUjJMIVTv4EZC3WOLw3002Ivk1ZH0VpIymU7vs?=
 =?us-ascii?Q?4U10O1yWhgmO7HlzVnHZsauvbchb+JHwcr/NA0UKcVxma9CoVvy2Nsy+wZnV?=
 =?us-ascii?Q?qk4MlfgSAtc1KxJf6MFE4eF78dVudx9nb8xEGBWuVrX6c5ud67a8hHX0Sv0t?=
 =?us-ascii?Q?Oug46kkQFrF+hs92KHujmWqjsPTqlhIxL6td8DKlvs94yTpKcl0wUvgDq2+P?=
 =?us-ascii?Q?dJxPUCyh511lyY+Fy6XtgeqsychGFAgREWbCuUiV1UQeqWW/rxZG+0gTDQiv?=
 =?us-ascii?Q?Kl61KttEJozcVe79/jwaXgNyBC+y/EnfQb3YOGX3w8T1zHPa8OeK4Ge4QbhH?=
 =?us-ascii?Q?WhYe0IYC/RbG9sDFa/f32mJ7O7TL650rSqE3ecuWFPVkmUKvhyzwBut5EKAj?=
 =?us-ascii?Q?F+VJuNz5GS9jmhCz1rinkdQgwLO454yVipgLyUOVXNoahRCwFASpXDinXzQa?=
 =?us-ascii?Q?WfH8iq5AX4rMIGeFqvtzI0i/6inlAciRZWoIObEYv98683wTiFJg+Kek27TP?=
 =?us-ascii?Q?/fXAeC3wbZQgoXNf99W+ziwjg9KUOT0yX+dVEBoPqQqk2VZoYPqXdDnEMDVp?=
 =?us-ascii?Q?G1nXPSusAWo8rwOtyJP4QN82KUndzAfHfoyDQvHm7l5Aa6Aws9fzunEPof/N?=
 =?us-ascii?Q?2rnNgURVXyyuNLsFvIj7kfAf9ZKGAT+bReI4N2fg1YvZx4heKlPkgL30Tp+m?=
 =?us-ascii?Q?/FETKkW7jltLqm7lyFnIsNwVGd4XtZSodP8YQi4qZcWcE2L5irZSZ1/IBIVN?=
 =?us-ascii?Q?ONSi4/r2wRlIla+ief7CjyWvxf3o0FKWRNtChB9dyv2mCgE+MgshYjRPLs6e?=
 =?us-ascii?Q?4iy8z1x98v8ffm1D5I90sCbWwVQMRoN9/78oZeR2DMRzYSljVZ09QYU/TIYG?=
 =?us-ascii?Q?UtlQO0yhjwo7U6jMDEQuwlTWa3DV3z8RgUbJEjco0IB5N1+kBtWyea2U3Jzp?=
 =?us-ascii?Q?hbJ6zPwSssA3M9ahqM/zc4j5W9wbe6EYb2FNrN0FzcWpBE6uYoT1uzi5XSxf?=
 =?us-ascii?Q?o3d/KqoFXwiBCccq+E0XWgDpp7dAZgWDkEqTwyaxPHPRxoPDnaEKfqbI5DHu?=
 =?us-ascii?Q?5ZO8H6V3qnj5RbyDcV2qfHFPr6jWhrgt2N5kyICQTJ1Spuba4mcHgkkdp0eX?=
 =?us-ascii?Q?I7kaBxyN7aGAyKm0qSkhoxlPVf6382jig2S+Yo4tr5Ui6dEuQWXTupIX0/xh?=
 =?us-ascii?Q?xzS+ZcXfv/C3tWw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:56:22.0175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e174543-6f07-4293-4422-08dd3acb06ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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

Add metrics table support for smuv13.0.12 to
fetch data from metrics version v2

v2: Update get metric field and get metric size macro (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 186 ++++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   8 +
 2 files changed, 113 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d4a159bb5a65..72c18b1635c0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -105,7 +105,6 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 
 enum smu_v13_0_6_caps {
 	SMU_CAP(DPM),
-	SMU_CAP(UNI_METRICS),
 	SMU_CAP(DPM_POLICY),
 	SMU_CAP(OTHER_END_METRICS),
 	SMU_CAP(SET_UCLK_MAX),
@@ -272,8 +271,13 @@ struct PPTable_t {
 #define SMUQ10_TO_UINT(x) ((x) >> 10)
 #define SMUQ10_FRAC(x) ((x) & 0x3ff)
 #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
-#define GET_METRIC_FIELD(field, flag) ((flag) ?\
-		(metrics_v1->field) : (metrics_v0->field))
+#define GET_GPU_METRIC_FIELD(field, version) ((version == METRICS_VERSION_V0) ?\
+		(metrics_v0->field) : (metrics_v2->field))
+#define GET_METRIC_FIELD(field, version) ((version == METRICS_VERSION_V1) ?\
+		(metrics_v1->field) : GET_GPU_METRIC_FIELD(field, version))
+#define METRICS_TABLE_SIZE (max3(sizeof(MetricsTableV0_t),\
+				   sizeof(MetricsTableV1_t),\
+				   sizeof(MetricsTableV2_t)))
 
 struct smu_v13_0_6_dpm_map {
 	enum smu_clk_type clk_type;
@@ -282,6 +286,18 @@ struct smu_v13_0_6_dpm_map {
 	uint32_t *freq_table;
 };
 
+static inline int smu_v13_0_6_get_metrics_version(struct smu_context *smu)
+{
+	if ((smu->adev->flags & AMD_IS_APU) &&
+	    smu->smc_fw_version <= 0x4556900)
+		return METRICS_VERSION_V1;
+	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
+		 IP_VERSION(13, 0, 12))
+		return METRICS_VERSION_V2;
+
+	return METRICS_VERSION_V0;
+}
+
 static inline void smu_v13_0_6_cap_set(struct smu_context *smu,
 				       enum smu_v13_0_6_caps cap)
 {
@@ -309,7 +325,6 @@ static inline bool smu_v13_0_6_cap_supported(struct smu_context *smu,
 static void smu_v13_0_14_init_caps(struct smu_context *smu)
 {
 	enum smu_v13_0_6_caps default_cap_list[] = { SMU_CAP(DPM),
-						     SMU_CAP(UNI_METRICS),
 						     SMU_CAP(SET_UCLK_MAX),
 						     SMU_CAP(DPM_POLICY),
 						     SMU_CAP(PCIE_METRICS),
@@ -335,12 +350,14 @@ static void smu_v13_0_14_init_caps(struct smu_context *smu)
 static void smu_v13_0_12_init_caps(struct smu_context *smu)
 {
 	enum smu_v13_0_6_caps default_cap_list[] = { SMU_CAP(DPM),
-						     SMU_CAP(UNI_METRICS),
 						     SMU_CAP(PCIE_METRICS),
 						     SMU_CAP(CTF_LIMIT),
 						     SMU_CAP(MCA_DEBUG_MODE),
 						     SMU_CAP(RMA_MSG),
-						     SMU_CAP(ACA_SYND) };
+						     SMU_CAP(ACA_SYND),
+						     SMU_CAP(OTHER_END_METRICS),
+						     SMU_CAP(HST_LIMIT_METRICS),
+						     SMU_CAP(PER_INST_METRICS) };
 	uint32_t fw_ver = smu->smc_fw_version;
 
 	for (int i = 0; i < ARRAY_SIZE(default_cap_list); i++)
@@ -356,7 +373,6 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 static void smu_v13_0_6_init_caps(struct smu_context *smu)
 {
 	enum smu_v13_0_6_caps default_cap_list[] = { SMU_CAP(DPM),
-						     SMU_CAP(UNI_METRICS),
 						     SMU_CAP(SET_UCLK_MAX),
 						     SMU_CAP(DPM_POLICY),
 						     SMU_CAP(PCIE_METRICS),
@@ -382,8 +398,6 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
 		smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));
 
-		if (fw_ver <= 0x4556900)
-			smu_v13_0_6_cap_clear(smu, SMU_CAP(UNI_METRICS));
 		if (fw_ver >= 0x04556F00)
 			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
 		if (fw_ver >= 0x04556A00)
@@ -514,7 +528,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 			       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
-		       max(sizeof(MetricsTableV0_t), sizeof(MetricsTableV1_t)),
+		       METRICS_TABLE_SIZE,
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
@@ -522,8 +536,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
-	smu_table->metrics_table = kzalloc(max(sizeof(MetricsTableV0_t),
-					       sizeof(MetricsTableV1_t)), GFP_KERNEL);
+	smu_table->metrics_table = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
@@ -755,9 +768,10 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	struct smu_table_context *smu_table = &smu->smu_table;
 	MetricsTableV0_t *metrics_v0 = (MetricsTableV0_t *)smu_table->metrics_table;
 	MetricsTableV1_t *metrics_v1 = (MetricsTableV1_t *)smu_table->metrics_table;
+	MetricsTableV2_t *metrics_v2 = (MetricsTableV2_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
-	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
+	int version = smu_v13_0_6_get_metrics_version(smu);
 	int ret, i, retry = 100;
 	uint32_t table_version;
 
@@ -769,7 +783,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 				return ret;
 
 			/* Ensure that metrics have been updated */
-			if (GET_METRIC_FIELD(AccumulationCounter, flag))
+			if (GET_METRIC_FIELD(AccumulationCounter, version))
 				break;
 
 			usleep_range(1000, 1100);
@@ -786,29 +800,30 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			table_version;
 
 		pptable->MaxSocketPowerLimit =
-			SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketPowerLimit, flag));
+			SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketPowerLimit, version));
 		pptable->MaxGfxclkFrequency =
-			SMUQ10_ROUND(GET_METRIC_FIELD(MaxGfxclkFrequency, flag));
+			SMUQ10_ROUND(GET_METRIC_FIELD(MaxGfxclkFrequency, version));
 		pptable->MinGfxclkFrequency =
-			SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency, flag));
+			SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency, version));
 
 		for (i = 0; i < 4; ++i) {
 			pptable->FclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequencyTable, flag)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequencyTable, version)[i]);
 			pptable->UclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequencyTable, flag)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequencyTable, version)[i]);
 			pptable->SocclkFrequencyTable[i] = SMUQ10_ROUND(
-				GET_METRIC_FIELD(SocclkFrequencyTable, flag)[i]);
+				GET_METRIC_FIELD(SocclkFrequencyTable, version)[i]);
 			pptable->VclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequencyTable, flag)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequencyTable, version)[i]);
 			pptable->DclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequencyTable, flag)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequencyTable, version)[i]);
 			pptable->LclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequencyTable, flag)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequencyTable, version)[i]);
 		}
 
 		/* use AID0 serial number by default */
-		pptable->PublicSerialNumber_AID = GET_METRIC_FIELD(PublicSerialNumber_AID, flag)[0];
+		pptable->PublicSerialNumber_AID =
+			GET_METRIC_FIELD(PublicSerialNumber_AID, version)[0];
 
 		pptable->Init = true;
 	}
@@ -1130,7 +1145,8 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	MetricsTableV0_t *metrics_v0 = (MetricsTableV0_t *)smu_table->metrics_table;
 	MetricsTableV1_t *metrics_v1 = (MetricsTableV1_t *)smu_table->metrics_table;
-	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
+	MetricsTableV2_t *metrics_v2 = (MetricsTableV2_t *)smu_table->metrics_table;
+	int version = smu_v13_0_6_get_metrics_version(smu);
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	int xcc_id;
@@ -1145,50 +1161,50 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_GFXCLK:
 		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM))) {
 			xcc_id = GET_INST(GC, 0);
-			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, flag)[xcc_id]);
+			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, version)[xcc_id]);
 		} else {
 			*value = 0;
 		}
 		break;
 	case METRICS_CURR_SOCCLK:
 	case METRICS_AVERAGE_SOCCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency, flag)[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency, version)[0]);
 		break;
 	case METRICS_CURR_UCLK:
 	case METRICS_AVERAGE_UCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, flag));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, version));
 		break;
 	case METRICS_CURR_VCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency, flag)[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency, version)[0]);
 		break;
 	case METRICS_CURR_DCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency, flag)[0]);
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency, version)[0]);
 		break;
 	case METRICS_CURR_FCLK:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequency, flag));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequency, version));
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy, flag));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy, version));
 		break;
 	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, flag));
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, version));
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, flag)) << 8;
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, version)) << 8;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag)) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, flag)) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, version)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	/* This is the max of all VRs and not just SOC VR.
 	 * No need to define another data type for the same.
 	 */
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, flag)) *
+		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, version)) *
 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	default:
@@ -2479,17 +2495,18 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_7 *gpu_metrics =
 		(struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
-	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
+	int version = smu_v13_0_6_get_metrics_version(smu);
 	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
 	MetricsTableV0_t *metrics_v0;
 	MetricsTableV1_t *metrics_v1;
+	MetricsTableV2_t *metrics_v2;
 	struct amdgpu_xcp *xcp;
 	u16 link_width_level;
 	u32 inst_mask;
 	bool per_inst;
 
-	metrics_v0 = kzalloc(max(sizeof(MetricsTableV0_t), sizeof(MetricsTableV1_t)), GFP_KERNEL);
+	metrics_v0 = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
 	ret = smu_v13_0_6_get_metrics_table(smu, metrics_v0, true);
 	if (ret) {
 		kfree(metrics_v0);
@@ -2497,64 +2514,69 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	}
 
 	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
+	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
 
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 7);
 
 	gpu_metrics->temperature_hotspot =
-		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag));
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version));
 	/* Individual HBM stack temperature is not reported */
 	gpu_metrics->temperature_mem =
-		SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, flag));
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, version));
 	/* Reports max temperature of all voltage rails */
 	gpu_metrics->temperature_vrsoc =
-		SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, flag));
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, version));
 
 	gpu_metrics->average_gfx_activity =
-		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy, flag));
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy, version));
 	gpu_metrics->average_umc_activity =
-		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, flag));
+		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, version));
 
 	gpu_metrics->mem_max_bandwidth =
-		SMUQ10_ROUND(GET_METRIC_FIELD(MaxDramBandwidth, flag));
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxDramBandwidth, version));
 
 	gpu_metrics->curr_socket_power =
-		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, flag));
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, version));
 	/* Energy counter reported in 15.259uJ (2^-16) units */
-	gpu_metrics->energy_accumulator = GET_METRIC_FIELD(SocketEnergyAcc, flag);
+	gpu_metrics->energy_accumulator = GET_METRIC_FIELD(SocketEnergyAcc, version);
 
 	for (i = 0; i < MAX_GFX_CLKS; i++) {
 		xcc_id = GET_INST(GC, i);
 		if (xcc_id >= 0)
 			gpu_metrics->current_gfxclk[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, flag)[xcc_id]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, version)[xcc_id]);
 
 		if (i < MAX_CLKS) {
 			gpu_metrics->current_socclk[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency, flag)[i]);
+				SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency, version)[i]);
 			inst = GET_INST(VCN, i);
 			if (inst >= 0) {
 				gpu_metrics->current_vclk0[i] =
-					SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency, flag)[inst]);
+					SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency,
+								      version)[inst]);
 				gpu_metrics->current_dclk0[i] =
-					SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency, flag)[inst]);
+					SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency,
+								      version)[inst]);
 			}
 		}
 	}
 
-	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, flag));
+	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, version));
 
 	/* Total accumulated cycle counter */
-	gpu_metrics->accumulation_counter = GET_METRIC_FIELD(AccumulationCounter, flag);
+	gpu_metrics->accumulation_counter = GET_METRIC_FIELD(AccumulationCounter, version);
 
 	/* Accumulated throttler residencies */
-	gpu_metrics->prochot_residency_acc = GET_METRIC_FIELD(ProchotResidencyAcc, flag);
-	gpu_metrics->ppt_residency_acc = GET_METRIC_FIELD(PptResidencyAcc, flag);
-	gpu_metrics->socket_thm_residency_acc = GET_METRIC_FIELD(SocketThmResidencyAcc, flag);
-	gpu_metrics->vr_thm_residency_acc = GET_METRIC_FIELD(VrThmResidencyAcc, flag);
-	gpu_metrics->hbm_thm_residency_acc = GET_METRIC_FIELD(HbmThmResidencyAcc, flag);
+	gpu_metrics->prochot_residency_acc = GET_METRIC_FIELD(ProchotResidencyAcc, version);
+	gpu_metrics->ppt_residency_acc = GET_METRIC_FIELD(PptResidencyAcc, version);
+	gpu_metrics->socket_thm_residency_acc = GET_METRIC_FIELD(SocketThmResidencyAcc, version);
+	gpu_metrics->vr_thm_residency_acc = GET_METRIC_FIELD(VrThmResidencyAcc, version);
+	gpu_metrics->hbm_thm_residency_acc =
+		GET_METRIC_FIELD(HbmThmResidencyAcc, version);
 
 	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
-	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak, flag) >> GET_INST(GC, 0);
+	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak,
+							   version) >> GET_INST(GC, 0);
 
 	if (!(adev->flags & AMD_IS_APU)) {
 		/*Check smu version, PCIE link speed and width will be reported from pmfw metric
@@ -2562,9 +2584,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		 * for pf from registers
 		 */
 		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(PCIE_METRICS))) {
-			gpu_metrics->pcie_link_width = metrics_v0->PCIeLinkWidth;
+			gpu_metrics->pcie_link_width = GET_GPU_METRIC_FIELD(PCIeLinkWidth, version);
 			gpu_metrics->pcie_link_speed =
-				pcie_gen_to_speed(metrics_v0->PCIeLinkSpeed);
+				pcie_gen_to_speed(GET_GPU_METRIC_FIELD(PCIeLinkSpeed, version));
 		} else if (!amdgpu_sriov_vf(adev)) {
 			link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
 			if (link_width_level > MAX_LINK_WIDTH)
@@ -2577,37 +2599,37 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		}
 
 		gpu_metrics->pcie_bandwidth_acc =
-				SMUQ10_ROUND(metrics_v0->PcieBandwidthAcc[0]);
+				SMUQ10_ROUND(GET_GPU_METRIC_FIELD(PcieBandwidthAcc, version)[0]);
 		gpu_metrics->pcie_bandwidth_inst =
-				SMUQ10_ROUND(metrics_v0->PcieBandwidth[0]);
+				SMUQ10_ROUND(GET_GPU_METRIC_FIELD(PcieBandwidth, version)[0]);
 		gpu_metrics->pcie_l0_to_recov_count_acc =
-				metrics_v0->PCIeL0ToRecoveryCountAcc;
+				GET_GPU_METRIC_FIELD(PCIeL0ToRecoveryCountAcc, version);
 		gpu_metrics->pcie_replay_count_acc =
-				metrics_v0->PCIenReplayAAcc;
+				GET_GPU_METRIC_FIELD(PCIenReplayAAcc, version);
 		gpu_metrics->pcie_replay_rover_count_acc =
-				metrics_v0->PCIenReplayARolloverCountAcc;
+				GET_GPU_METRIC_FIELD(PCIenReplayARolloverCountAcc, version);
 		gpu_metrics->pcie_nak_sent_count_acc =
-				metrics_v0->PCIeNAKSentCountAcc;
+				GET_GPU_METRIC_FIELD(PCIeNAKSentCountAcc, version);
 		gpu_metrics->pcie_nak_rcvd_count_acc =
-				metrics_v0->PCIeNAKReceivedCountAcc;
+				GET_GPU_METRIC_FIELD(PCIeNAKReceivedCountAcc, version);
 		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(OTHER_END_METRICS)))
 			gpu_metrics->pcie_lc_perf_other_end_recovery =
-				metrics_v0->PCIeOtherEndRecoveryAcc;
+				GET_GPU_METRIC_FIELD(PCIeOtherEndRecoveryAcc, version);
 
 	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	gpu_metrics->gfx_activity_acc =
-		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusyAcc, flag));
+		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusyAcc, version));
 	gpu_metrics->mem_activity_acc =
-		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc, flag));
+		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc, version));
 
 	for (i = 0; i < NUM_XGMI_LINKS; i++) {
 		gpu_metrics->xgmi_read_data_acc[i] =
-			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc, flag)[i]);
+			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc, version)[i]);
 		gpu_metrics->xgmi_write_data_acc[i] =
-			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc, flag)[i]);
+			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc, version)[i]);
 		ret = amdgpu_get_xgmi_link_status(adev, i);
 		if (ret >= 0)
 			gpu_metrics->xgmi_link_status[i] = ret;
@@ -2627,11 +2649,11 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 				gpu_metrics->xcp_stats[i].jpeg_busy
 					[(idx * adev->jpeg.num_jpeg_rings) + j] =
-					SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy, flag)
+					SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy, version)
 							[(inst * adev->jpeg.num_jpeg_rings) + j]);
 			}
 			gpu_metrics->xcp_stats[i].vcn_busy[idx] =
-			       SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, flag)[inst]);
+			       SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, version)[inst]);
 			idx++;
 
 		}
@@ -2642,24 +2664,26 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			for_each_inst(k, inst_mask) {
 				inst = GET_INST(GC, k);
 				gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
-					SMUQ10_ROUND(metrics_v0->GfxBusy[inst]);
+					SMUQ10_ROUND(GET_GPU_METRIC_FIELD(GfxBusy, version)[inst]);
 				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
-					SMUQ10_ROUND(metrics_v0->GfxBusyAcc[inst]);
+					SMUQ10_ROUND(GET_GPU_METRIC_FIELD(GfxBusyAcc,
+									  version)[inst]);
 
 				if (smu_v13_0_6_cap_supported(
 					    smu, SMU_CAP(HST_LIMIT_METRICS)))
 					gpu_metrics->xcp_stats[i].gfx_below_host_limit_acc[idx] =
-						SMUQ10_ROUND(metrics_v0->GfxclkBelowHostLimitAcc
+						SMUQ10_ROUND(GET_GPU_METRIC_FIELD
+								(GfxclkBelowHostLimitAcc, version)
 								[inst]);
 				idx++;
 			}
 		}
 	}
 
-	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth, flag));
-	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate, flag));
+	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth, version));
+	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate, version));
 
-	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, flag);
+	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
 
 	*table = (void *)gpu_metrics;
 	kfree(metrics_v0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index f0fa42a645c0..717fe669882e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -27,6 +27,14 @@
 #define SMU_13_0_6_UMD_PSTATE_SOCCLK_LEVEL 0x4
 #define SMU_13_0_6_UMD_PSTATE_MCLK_LEVEL 0x2
 
+typedef enum {
+/*0*/   METRICS_VERSION_V0                  = 0,
+/*1*/   METRICS_VERSION_V1                  = 1,
+/*2*/   METRICS_VERSION_V2                  = 2,
+
+/*3*/   NUM_METRICS                         = 3
+} METRICS_LIST_e;
+
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
 
 #endif
-- 
2.46.0

