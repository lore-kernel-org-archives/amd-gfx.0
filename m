Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF3BFD707A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8658F10E5E5;
	Tue, 17 Mar 2026 20:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MR3KHjeg";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE1810E649
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoLdnf21Is0GjkAeHQJsnGdGJIMzmy+xLU3ZSHLo37iYvCQ8zxWz2GXNFVahGKeijxeLwXHHKQreQ/UsvL2lbOPQ7Cz6c7eP1UQbVSF/oyKzGqVgmtCp+lqKEX12ftgCo+6catd8E9OwJwkDSDVwNbgxCnMt8rTlZGIJzrD/stQU0q7GODRF4LFObs4ENr0h8OiPJcWymNZhF03qPzNInbfRfKsc+LX6DFgFTnEflIHQvuYpfk3pLm7fQdJVb6g91HQflqejuyQqJB8iRme0JdsiWZTer7G3kS3XOEbAozaI3IT2CZSq4/y+4OvG1O7oDWU6kVshWEkyuI25U+E/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+OCeRWWsHzBhP+PQRjtXf3bmDgqEOOTmrPDQUGeL28=;
 b=F5aZ3WklefG65uudBlnzS8Y8ZtKYrmpn3AVkZPG3zspFVl19pEWF73nCbKaxqhHD446Ydb+XiFMzJyZ6hDzjDcNO1pgiZdKQPwTKUORveKbdsWy7SbNTpB7afr1o6UhrFA64jvwc43P4zAfftLs9MIZ4gOXJJJW0vllCXauZft53m/kDg4iuFfU+Xtc729pthuTINqo1wNwrp+Y50OrGKtiyxiqAEArrWYCxvEL6og3P1H1hbH6blgLxUeOpy1C+EMhqFzuUkCSCGgreKlCfVric+LLQisFTDN2UeOHxcFwALqH5crpLkbl2j1QD5c9LwQlHD8TFEMwWY1MXQ5vpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+OCeRWWsHzBhP+PQRjtXf3bmDgqEOOTmrPDQUGeL28=;
 b=MR3KHjeg+Webfb3lwL6kXwudXEfQj+eHv+y1JR4h2mK2U9lIWCVDmcHLxuQDM5t895+Ig3C1CBTDHPGvuSgm9b8ZPQwLcKMGGhQct7mb/Z7jkoYp5/RcPdzuev8Kk8vs7Z8nhQ0FhHLIPguw8tYLgX6DFLo0rye5trxTy+yQDUA=
Received: from SJ0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:33a::25)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:13:21 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::a2) by SJ0PR03CA0020.outlook.office365.com
 (2603:10b6:a03:33a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 20:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 15:13:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 20/25] drm/amd/pm: Add read sensor support
Date: Tue, 17 Mar 2026 16:12:36 -0400
Message-ID: <20260317201242.3808136-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da3b3d2-33d6-474e-7529-08de8461a293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Uq5/lXMdOfmvJIOsU6qqn1LWqnHIUdZwgAFEM8aDO5h6kQoUrBmMG3bjesaKizAQ0j4m/7W2UAYlrKPrHOgpalqh7/s2hOZL+qjnJz8+AGkAjWUjfg6COZer/eRERE4TNvOmRyLZnkoQcNKMQADdKzor783X2jInPvJ6yl7crqgodQOmULOVceSgjz24zurgdZf1FFblzGtGlaTTqXSuZYuq5e1bCKVMTRZa6BKLSeeILg+QuaCJ7UJLqqxks1IBy48xrDzuqIFrcXXlA8gIrNUvCOZHApm6atF/24ZV0WfgX+6MChSVrNpzOmuPJeVGTCtHGtsRBiA7PbemAcwNP5nPEGPYUrN+veD9TLcxn2kfnLATJ/S5H3Q9tBmxEuLVGcYeF+6aZY5idTY3Htii+eXBPS925pZ4CKtIHaBtIcw66RtZmZ4yS9M6sDtsLRxCgnpSZ+rHroyxrN4NYllJKAvAOmOtBiFoFLuyGLfGUMKcbghVziJ/B/3+RYhv4nOtyva7KRwoB6OGMEZa9C5Tmki4aOFAi9g3J+0c1RDiKuW6s3aiaN80g8+nUwmCub2Bt7UOJdTrzFB667B/RPdUVdC+fJlh7vGylrPETx1705roX8HOSsuFkoIt1ICzNpXdiEuaeo22yxzv97NcrQ1biiT6u7oX6u2xnZYT7mbzv1q2hSU2j7n6otQmSEy+uwH06NU65jpF52B/pnYMu1tD9q4w8L4pca8A9V+E0pp5vUW39e1ohWJbYQRPFke/2eyG89PltnB3KZo8gYuexClKVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JdOXz4wHyJRic52KPwsEkBpcwjMz3n36eraA+1eJvhicXqAYPPKOpwSU0Wez+cN2zD4X9EQbkBgQTxJIGjEMuVgR3E/MM0pqSGsvu2zGEbU6ObYbnJDuk1NHxyseYBgs9BHpyW289OZ8khqaxLtmbJ+GhQq1ehqAS+zEPMst40kXauFaRgNtE5hRIA05hlL3cwxIHwXGAzeGOi76VQrpqbzh9vfman2o/LEX6r2rvOD3BbRLIDO/+rxSqREEl+7hnZpkCNwHIOJ9dJhFer/lyWIbqbn36ouTmEb5AHuqr4u0Hd4Yt+ZZDHN2JrdJh9KNvTGCy0EqXv8NGPvj85/dbNuP2AWhgoWdivJoydWSeFEhF0z0MR+1NV8KQCaVxAQupxR4yucV5Rx5VhTjw4qPa2VoP+SiMieTPtizVhADAsbGKN9c0vvzoP6idPayK+q+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:20.5659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da3b3d2-33d6-474e-7529-08de8461a293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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

From: Asad Kamal <asad.kamal@amd.com>

Add read sensor support for smu_v15_0_8

v2: Remove gfx voltage support (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 7dc5100700808..a2a640aaa0775 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -434,6 +434,117 @@ static int smu_v15_0_8_get_current_clk_freq_by_table(struct smu_context *smu,
 	return smu_v15_0_8_get_smu_metrics_data(smu, member_type, value);
 }
 
+static int smu_v15_0_8_get_current_activity_percent(struct smu_context *smu,
+						    enum amd_pp_sensors sensor,
+						    uint32_t *value)
+{
+	int ret = 0;
+
+	if (!value)
+		return -EINVAL;
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		ret = smu_v15_0_8_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_GFXACTIVITY, value);
+		break;
+	case AMDGPU_PP_SENSOR_MEM_LOAD:
+		ret = smu_v15_0_8_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_MEMACTIVITY, value);
+		break;
+	default:
+		dev_err(smu->adev->dev,
+			"Invalid sensor for retrieving clock activity\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int smu_v15_0_8_thermal_get_temperature(struct smu_context *smu,
+					       enum amd_pp_sensors sensor,
+					       uint32_t *value)
+{
+	int ret = 0;
+
+	if (!value)
+		return -EINVAL;
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = smu_v15_0_8_get_smu_metrics_data(smu,
+						       METRICS_TEMPERATURE_HOTSPOT, value);
+		break;
+	case AMDGPU_PP_SENSOR_MEM_TEMP:
+		ret = smu_v15_0_8_get_smu_metrics_data(smu,
+						       METRICS_TEMPERATURE_MEM, value);
+		break;
+	default:
+		dev_err(smu->adev->dev, "Invalid sensor for retrieving temp\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int smu_v15_0_8_read_sensor(struct smu_context *smu,
+				   enum amd_pp_sensors sensor, void *data,
+				   uint32_t *size)
+{
+	struct smu_15_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	int ret = 0;
+
+	if (amdgpu_ras_intr_triggered())
+		return 0;
+
+	if (!data || !size)
+		return -EINVAL;
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_MEM_LOAD:
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		ret = smu_v15_0_8_get_current_activity_percent(smu, sensor,
+							       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
+		ret = smu_v15_0_8_get_smu_metrics_data(smu,
+						       METRICS_CURR_SOCKETPOWER,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+	case AMDGPU_PP_SENSOR_MEM_TEMP:
+		ret = smu_v15_0_8_thermal_get_temperature(smu, sensor,
+							  (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_MCLK:
+		ret = smu_v15_0_8_get_current_clk_freq_by_table(smu,
+								SMU_UCLK, (uint32_t *)data);
+		/* the output clock frequency in 10K unit */
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_SCLK:
+		ret = smu_v15_0_8_get_current_clk_freq_by_table(smu,
+								SMU_GFXCLK, (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDBOARD:
+		*(uint32_t *)data = dpm_context->board_volt;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
 static int smu_v15_0_8_emit_clk_levels(struct smu_context *smu,
 				       enum smu_clk_type type, char *buf,
 				       int *offset)
@@ -1816,6 +1927,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.set_power_limit = smu_v15_0_8_set_power_limit,
 	.get_ppt_limit = smu_v15_0_8_get_ppt_limit,
 	.emit_clk_levels = smu_v15_0_8_emit_clk_levels,
+	.read_sensor = smu_v15_0_8_read_sensor,
 	.populate_umd_state_clk = smu_v15_0_8_populate_umd_state_clk,
 	.set_performance_level = smu_v15_0_8_set_performance_level,
 	.od_edit_dpm_table = smu_v15_0_8_od_edit_dpm_table,
-- 
2.53.0

