Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A31AF9D0F1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B070510E659;
	Tue, 14 Apr 2026 19:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sMNkStiu";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AA610E119
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOLs9Wwb7Gcj5ZQBXY9aeAC1iHFGM7CBr0k5ZpAO+rlvrMEFsAJIpDd0rzO6jVl7ZXBekaKAzXqRBY8xeiprtK8SH1QDIGb3X9N2pTqpwxyvcxEfeNntutMJ4t9LVkhjt8XgEaAYV0TnQ5ewcFBO+rMT1Imt+IYIPsbPnlyTEePaQ1jbY2TxIDNL8E93hMj3uROJTHWDwgoyBPjtRiGpzIJAYueSfnlMoaEEohftBAgDUYJg8agPRcRcbUJ+Et7sMZiT90yN33UJy2OTP9P01sTaQliIQ9irgss6So+L76QyB572gXb0c/rjs7Oy3is2eiok9I8XFzBgGR0YA/nPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xglX8hi5qwY/aLIDdloTKbco9t4jjJX/LFVb4UV84LA=;
 b=yD8bjdfqTJzH7mOYeYJ537fgkQ3ZYdAh72qReKyivuC57pCjrari9eix/DfWNTfttzbmwDAD8En1tGLn5Coj4mkFVd22serhNtBuzHwC2nhF/yoaSrjfv1U4WS8R3Sr8Gl7x1olSjZ8l4cz6iRXlqN12nfh4bhvos9upuQjUHdt0FzJjRM62E9Dds5HC2FaPbLNFhVzHa1rJ/CTND6C1Xp1NFffCgAuvxatjJ2leTYReZbO1XR67OLt1pLFTUfBJULBD0ev5Ur3PiqLiZG1vCOYoq3VgHuD4x1PkzZxCB1PFImeTMu/QtFLBskRYkCDUGXZy85eegsXOnr5aZzBf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xglX8hi5qwY/aLIDdloTKbco9t4jjJX/LFVb4UV84LA=;
 b=sMNkStiueqIOOcrocVDH6TAqEKF3IBuw78sJhznXHDOgdertOW8xjrm9aIAz0a7cfxMMH3NtapGTJT2NiETrCsu+clu8bq8clbMXPOEpCcs3jboPQns5WS4qZlCtJM9MQxDny5MpqWD7hHLXQYuHsYOMfHyg28gnshk6cFB1/Qs=
Received: from DM6PR05CA0053.namprd05.prod.outlook.com (2603:10b6:5:335::22)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:45:57 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::4d) by DM6PR05CA0053.outlook.office365.com
 (2603:10b6:5:335::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:45:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Apr
 2026 14:45:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Apr
 2026 14:45:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:45:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: Add partition metrics support
Date: Tue, 14 Apr 2026 15:45:45 -0400
Message-ID: <20260414194547.2213525-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414194547.2213525-1-alexander.deucher@amd.com>
References: <20260414194547.2213525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: f860349b-5819-4158-3c61-08de9a5e7225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6YAPm2qmcrgY3D/2px4wlJwniaffrs7K1fVk8BdWWL1879DJ49jrkf17fYlxUvwuWFycLeOZA76U72sDRCRAZUX4jK2aAncs4XDK41TX49NQtrjZGP3Pla/iR7FgeVQWb0YX5XDg1Mv7OEN1F+UGY08WzMMKj82N4WFuxKWxAADbpN2tmUUCD3CW6q4chLmjHzBg+gGFNs35YS5zXs0U7iVa/ixwwqRWk+VvdPvhbs8eNA+U4lNAmfNgcss/6DNyKjEGOkI6raoCoffBCTRcs/QXBseAnNLCTeMlzOi5wKt7d3YVxyzrAp9QMtTsynB01eHTf16aKisWNgx56lYGeA0LXW5JweiW9N9eny8JlMdomap2KUtfMpekimsAkZREKXj5DVa8e6NI6LOHW2c4g8q/v+VQRhh44eviDQkQY2FktrQ+R3thT8n1k8NJMXJaNgMV7u7x5LGrOclo2iEJCxN+RhFXiLNXYzzia74wg6KimvjS65dFDqqq4vf9M8YF4AifZHKWbnlWFE6JIxV5nNEOOK8pfwsPVjauz5VBjll5Q7DSjdVVAVMydF4uGnKVLRZTCM2LpgDvtHx9hANmSowoIqcSoQGC/KdFmrd8t5hDqPuGx/BDA7+9zMX78IYBrlDhIEFUv+VpXrVb6WpJM/j743uDXOh8UqMr/IhKfUIZUFYggVifsG8m6rWrXmAf51Qpv/MV3zmZsbFPChUjbdCb4U3jn2GODgAozlU01CQj6QAXEtaor0PW2IwVHDF0S48RYFw10KV7658z7scpDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lA4Ocu0QGgRRufD6riStK8bzZg71CKadFgDoqH9F3gXh3NoRMS/G45i9dZtdkr+17aa/blDzoEtdastakJ6rIIwNMbTjUHYRJidx5IK62Wo+7GJZcjlSw1+8/b0uIWwQ9fJNT6F7eZRbAwPYyaB95OOFJcoYVYaUGdDh/BA0bWl5oolzKKgN0PvPZv9J0/Lak1sXd/IulVLG0sboVebPEGG5ghUrS+qDL3kQ0I9SftxvxVIdtjdWtBq3LCNUdNbPa9wx+H7rwOYH+PTGLzIBKBvuFl0ii/91TpfFzUytYY27gCVfZVCT4ZOnBAy2Bw+8dG5d5E5VaPwmm7toflc2r0Qhzfq2g5NKRUMZ07l7qR9sGw/HshwYwrjxzbL5hpY7WxAC7u8y2jWbaly0BWJBUllKQuJUVdVc9osCB17rcOZMEuDzX6lEZk4UM47iNF4o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:45:56.5038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f860349b-5819-4158-3c61-08de9a5e7225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
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

Add partition metrics support for smu_v15_0_8

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 78 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h  | 34 ++++++++
 2 files changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 912a1e1e0cd6a..288fab5ee5e53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -63,6 +63,8 @@
 	for ((stack_idx) = 0; (umc_mask); \
 	     (umc_mask) >>= 4, (stack_idx)++) \
 
+#define NUM_JPEG_RINGS_FW	10
+
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
 #define SMU_15_0_8_FEA_MAP(smu_feature, smu_15_0_8_feature)                    \
@@ -1593,6 +1595,81 @@ static ssize_t smu_v15_0_8_get_temp_metrics(struct smu_context *smu,
 	}
 }
 
+static ssize_t smu_v15_0_8_get_xcp_metrics(struct smu_context *smu, int xcp_id,
+					   void *table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	const u8 num_jpeg_rings = NUM_JPEG_RINGS_FW;
+	struct smu_v15_0_8_partition_metrics *xcp_metrics;
+	MetricsTable_t *metrics;
+	struct amdgpu_device *adev = smu->adev;
+	int ret, inst, i, j, k, idx;
+	struct amdgpu_xcp *xcp;
+	u32 inst_mask;
+
+	if (!table)
+		return sizeof(*xcp_metrics);
+
+	for_each_xcp(adev->xcp_mgr, xcp, i) {
+		if (xcp->id == xcp_id)
+			break;
+	}
+	if (i == adev->xcp_mgr->num_xcps)
+		return -EINVAL;
+
+	xcp_metrics = (struct smu_v15_0_8_partition_metrics *)table;
+	smu_v15_0_8_partition_metrics_init(xcp_metrics, 1, 1);
+
+	ret = smu_v15_0_8_get_metrics_table_internal(smu, 1, NULL);
+	if (ret)
+		return ret;
+
+	metrics = (MetricsTable_t *)smu_table->metrics_table;
+
+	amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+	idx = 0;
+	for_each_inst(k, inst_mask) {
+		/* Both JPEG and VCN has same instances */
+		inst = GET_INST(VCN, k);
+		for (j = 0; j < num_jpeg_rings; ++j) {
+			xcp_metrics->jpeg_busy[(idx * num_jpeg_rings) + j] =
+				SMUQ10_ROUND(metrics->JpegBusy[(inst * num_jpeg_rings) + j]);
+		}
+		xcp_metrics->vcn_busy[idx] =
+			SMUQ10_ROUND(metrics->VcnBusy[inst]);
+
+		xcp_metrics->current_vclk[idx] = SMUQ10_ROUND(metrics->VclkFrequency[inst]);
+		xcp_metrics->current_dclk[idx] = SMUQ10_ROUND(metrics->DclkFrequency[inst]);
+
+		idx++;
+	}
+
+	amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
+	idx = 0;
+	for_each_inst(k, inst_mask) {
+		inst = GET_INST(GC, k);
+		xcp_metrics->current_gfxclk[idx] =
+			SMUQ10_ROUND(metrics->GfxclkFrequency[inst]);
+
+		xcp_metrics->gfx_busy_inst[idx] = SMUQ10_ROUND(metrics->GfxBusy[inst]);
+		xcp_metrics->gfx_busy_acc[idx] = SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
+		xcp_metrics->gfx_below_host_limit_ppt_acc[idx] =
+			SMUQ10_ROUND(metrics->GfxclkBelowHostLimitPptAcc[inst]);
+		xcp_metrics->gfx_below_host_limit_thm_acc[idx] =
+			SMUQ10_ROUND(metrics->GfxclkBelowHostLimitThmAcc[inst]);
+		xcp_metrics->gfx_low_utilization_acc[idx] =
+			SMUQ10_ROUND(metrics->GfxclkLowUtilizationAcc[inst]);
+		xcp_metrics->gfx_below_host_limit_total_acc[idx] =
+			SMUQ10_ROUND(metrics->GfxclkBelowHostLimitTotalAcc[inst]);
+		idx++;
+	}
+
+	xcp_metrics->accumulation_counter = metrics->AccumulationCounter;
+	xcp_metrics->firmware_timestamp = metrics->Timestamp;
+
+	return sizeof(*xcp_metrics);
+}
+
 static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -2222,6 +2299,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.wait_for_event = smu_v15_0_wait_for_event,
 	.get_pm_metrics = smu_v15_0_8_get_pm_metrics,
+	.get_xcp_metrics = smu_v15_0_8_get_xcp_metrics,
 	.mode2_reset = smu_v15_0_8_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v15_0_8_get_dpm_ultimate_freq,
 	.get_gpu_metrics = smu_v15_0_8_get_gpu_metrics,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index 398ce44821741..4dfc40aaffcb4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -309,5 +309,39 @@ DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpuboard_temp_metrics,
 
 DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_baseboard_temp_metrics,
 			  SMU_15_0_8_BASEBOARD_TEMP_METRICS_FIELDS);
+#define SMU_15_0_8_PARTITION_METRICS_FIELDS(SMU_SCALAR, SMU_ARRAY)             \
+	SMU_ARRAY(SMU_MATTR(CURRENT_GFXCLK), SMU_MUNIT(CLOCK_1),               \
+		  SMU_MTYPE(U16), current_gfxclk, SMU_15_0_8_MAX_XCC);         \
+	SMU_ARRAY(SMU_MATTR(CURRENT_VCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_vclk, SMU_15_0_8_MAX_VCN);          \
+	SMU_ARRAY(SMU_MATTR(CURRENT_DCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_dclk, SMU_15_0_8_MAX_VCN);          \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_INST), SMU_MUNIT(PERCENT),                \
+		  SMU_MTYPE(U8), gfx_busy_inst, SMU_15_0_8_MAX_XCC);          \
+	SMU_ARRAY(SMU_MATTR(JPEG_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U8),    \
+		  jpeg_busy, SMU_15_0_8_MAX_JPEG);                             \
+	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U8),     \
+		  vcn_busy, SMU_15_0_8_MAX_VCN);                               \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(NONE), SMU_MTYPE(U64),    \
+		  gfx_busy_acc, SMU_15_0_8_MAX_XCC);                           \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),    \
+		  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,                \
+		  SMU_15_0_8_MAX_XCC);                                         \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_THM_ACC), SMU_MUNIT(NONE),    \
+		  SMU_MTYPE(U64), gfx_below_host_limit_thm_acc,                \
+		  SMU_15_0_8_MAX_XCC);                                         \
+	SMU_ARRAY(SMU_MATTR(GFX_LOW_UTILIZATION_ACC), SMU_MUNIT(NONE),         \
+		  SMU_MTYPE(U64), gfx_low_utilization_acc,                     \
+		  SMU_15_0_8_MAX_XCC);                                         \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
+		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
+		  SMU_15_0_8_MAX_XCC);					       \
+	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
+		   SMU_MTYPE(U64), accumulation_counter);                      \
+	SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),           \
+		   SMU_MTYPE(U64), firmware_timestamp);
+
+DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_partition_metrics,
+			  SMU_15_0_8_PARTITION_METRICS_FIELDS);
 #endif
 #endif
-- 
2.53.0

