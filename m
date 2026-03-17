Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEDBFD707A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BAE10E69C;
	Tue, 17 Mar 2026 20:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NMepL1Sx";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302B210E5E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6O/w8KVTzYM2+8oH3SSDd5XfDGnyTzVJLiG0hYV2atRbALZSB7o9D30u9Ror/Ep8kZT/5cJadYrTCAlt3SSEiqnyWJTpvTejfTYntNSGU4u2CCjcox1kMl4gl+vbgpMh1a6rE+VTyQ2xiBO8CTAM9abNT0K0C3681SOHfmwFSBXg8+KxaKWKZAAcZTjAkosyJTkUE0vqs5spnbV4ur5NbLcuzoP2ZFxuECfuVZXtWZLjThqNx5GdHdyr+tFdXQu0JMLY8YPZnqhAsUU+5H1HVF7ax7oNuBp3z7XQFU9ilrrQ8/cKHn7jE4VDri/yRcDHnGr2ZqeneQCBrvBnDgqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRf70Q9T2M8DJucokidkfqcLSHi9+51gaYtzcneukTQ=;
 b=LoK7Oub7+yDOXovKz9h13w9aBnUBPs1gAry6UgahRd0YcnWohY6RW4/26G23WgB9Bg+1P2Z/OSYQ8+2aRdE/UxP17lt6m4UeFustiKZnN4vsuJoxXrIu5h8xwqreTHH0ih1iMek+jSkgtUqza7ZlPXSbH3J+gaXvPD4QwTXH2Ndu0psp6ANXRe8dREcJRwL1jAl34/sOdMioktEWh4J3mAHIt9OAlIQh/WpGdDo8VZ5+kwPWEIwMoUlIjwG51MRrlB0DVY4oxyKYlonfA4AFftt7CvkVqvk2mQPu/YmemdpzbSRhVBJddWVY6IVJfoy1nPdhI+G2NvIcPvhACJs89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRf70Q9T2M8DJucokidkfqcLSHi9+51gaYtzcneukTQ=;
 b=NMepL1SxybeVDDkJRZJb7j38fu3ZfQWfJ+OGsvh2REwzN+aNekcCvTeqLRNcSKhdgkh/w4V3sgOJm8QkmvjPgTOJuZh88g4ZM4EueSf3mBiKoZiDTIagGp04G/bMSROghZTmNU2tkw7U3AkIcCgH+XNfI1n4WjdgBu0g4yyTmtk=
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 20:13:13 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::ac) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yang Wang <kevinyang.wang@amd.com>, Asad Kamal <asad.kamal@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/25] drm/amd/pm: add get_gpu_metrics support for 15.0.8
Date: Tue, 17 Mar 2026 16:12:27 -0400
Message-ID: <20260317201242.3808136-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 9463813b-7224-4681-2996-08de84619dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: rntT5NReAnvDrK3pbgUGVhQMRug8A/ZX6Cto1uRbGOO35PGGqj4/K3cPmokUS00MNusNEQ83DFO9/oYMJjg3mTF0BEKgVDVV2IBciNTF/6sOBRDIlXC32OToYrdRxYJtGG9774OeApl47NGYyqS++YWd7sakqTMDxx0mGBf5if46J/trGckxATHyNClms92/DQci4jBlcHPhaZ65g7X3hS2jjkI1eeR6q5pTsIhb99RQ7RtvwP+rbCMkK7B5YH1Gx1DoZaIpUIOWsrI9IcezOY/7S+uoYt2N9CnsB5qGcEXNgEgkLIXyc8zzH7xbPvjkAizlbLkzYHaCpt242HqCF3cKFLxJtZcySFoe6Ta2QnDCnf/d9UPcwxLU0swSFHZKpSzYPZWOHaax6ju8cRSI8bhapoL3i2Ck92KyVfC+jEZ7Fy2JP3JDDikPsUDNyspMNRQ4Q6CgI6v6gwxAsIxHUGVDga5RiiwMkZSoSeAyDHzD8fZID2b+KZVEo14BPanUGuc6lKVE7H88+A7lhkfI3SJ2hotchCWeN4/8EkNxud+knS7wmUitXFNZtOYjnTbL8pwdX5w1GtDAwJSZuCY2VpHHB3No2OuUoWD9+dlUvjnyQXVoYGrNwb4mOnqvAAPmMInsTq7nGrB/3UQYBMrUUXA01Ybr8E3mpTgCckTTMd/POljAnldMGm4Kw96bfw5rRD9iS4Swl2NukGgiYaRNA3Mqo59hBWc2V9TrlwNZlEDVfcY0000SkwA/GHBIbnNJUR6jMfkhC++ZRjnbCdFrew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qGCaEXtHV9eKcDtf5x5lWhN8iqiLglhu1ozNgHxYVx3silIVSOyvP6/cwGrStckAO9Fnu8Y3Z10P20RSE8UQwDlL1qL43BtPpFHN3ayek0pvVRJWX3KfMTww+WXwKNNFgPD0v2SdRKqFQWVHlTZXYwpU835cvSdeeQG/ww1bf4FZp5fxikJLsiUb9EfFyaFo1qGprjtm4cMtjDIMF4S/v+uY2Rj3eFlzV+CfLT5/kUUE6RVmTfiyQ2y4/++Nvw+qF5nqlGZmbWiT72Yc0gvIvd/6pwpmA9zpyTJlXT/H7IkTRxzFZUFQR4wghl1pyjclgQ29BfD9zs/HGtyUVIzlgWFMaBkVVGgc2EuGkbcd+6OUxV7a6Y5NWYUfQHi858PHK5MlP2fINOPieqD6oIReBBoVMBCSOlzPIvR7kLWJysvJM1ZZYKkMvc6WXPgLqXGA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:12.7550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9463813b-7224-4681-2996-08de84619dec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
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

From: Yang Wang <kevinyang.wang@amd.com>

export .get_gpu_metrics interface for 15.0.8

v2: Remove members already exposed by other interfaces, use mask,
logical conversion (Lijo)

v3: Use correct logic for hbm stacks loop (Lijo)
Remove buffer allocation

v4: Make out of bound check outside loop (Lijo)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 174 +++++++++++++++++-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h  | 126 +++++++++++++
 3 files changed, 300 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a9b73f4fd4661..22ee30f514c0a 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -585,6 +585,7 @@ enum amdgpu_metrics_attr_id {
 	AMDGPU_METRICS_ATTR_ID_GFX_LOW_UTILIZATION_ACC,
 	AMDGPU_METRICS_ATTR_ID_GFX_BELOW_HOST_LIMIT_TOTAL_ACC,
 	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_HBM,
+	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_MID,
 	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_AID,
 	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_XCD,
 	AMDGPU_METRICS_ATTR_ID_MAX,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 60a43ce5648a5..c13804c32e706 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -56,6 +56,13 @@
 #define SMUQ10_FRAC(x) ((x) & 0x3ff)
 #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
 
+#define hbm_stack_mask_valid(umc_mask) \
+	(((umc_mask) & 0xF) == 0xF)
+
+#define for_each_hbm_stack(stack_idx, umc_mask) \
+	for ((stack_idx) = 0; (umc_mask); \
+	     (umc_mask) >>= 4, (stack_idx)++) \
+
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
 #define SMU_15_0_8_FEA_MAP(smu_feature, smu_15_0_8_feature)                    \
@@ -167,8 +174,9 @@ static const struct cmn2asic_mapping smu_v15_0_8_table_map[SMU_TABLE_COUNT] = {
 static int smu_v15_0_8_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	int ret, gpu_metrcs_size = sizeof(MetricsTable_t);
 	struct smu_table *tables = smu_table->tables;
-	int gpu_metrcs_size = sizeof(MetricsTable_t);
+	struct smu_v15_0_8_gpu_metrics *gpu_metrics;
 	void *driver_pptable __free(kfree) = NULL;
 	void *metrics_table __free(kfree) = NULL;
 
@@ -190,6 +198,15 @@ static int smu_v15_0_8_tables_init(struct smu_context *smu)
 	if (!driver_pptable)
 		return -ENOMEM;
 
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				    sizeof(struct smu_v15_0_8_gpu_metrics),
+				    SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret)
+		return ret;
+
+	gpu_metrics = (struct smu_v15_0_8_gpu_metrics *)smu_driver_table_ptr(smu,
+		       SMU_DRIVER_TABLE_GPU_METRICS);
+	smu_v15_0_8_gpu_metrics_init(gpu_metrics, 1, 9);
 	smu_table->metrics_table = no_free_ptr(metrics_table);
 	smu_table->driver_pptable = no_free_ptr(driver_pptable);
 
@@ -967,6 +984,160 @@ static int smu_v15_0_8_mode2_reset(struct smu_context *smu)
 	return ret;
 }
 
+static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_v15_0_8_gpu_metrics *gpu_metrics;
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0, xcc_id, inst, i, j, idx;
+	uint32_t aid_mask = adev->aid_mask;
+	uint32_t mid_mask = adev->aid_mask;
+	MetricsTable_t *metrics;
+
+	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
+
+	ret = smu_v15_0_8_get_metrics_table_internal(smu, 1, NULL);
+	if (ret)
+		return ret;
+
+	metrics = (MetricsTable_t *)smu_table->metrics_table;
+	gpu_metrics = (struct smu_v15_0_8_gpu_metrics *)smu_driver_table_ptr(smu,
+		       SMU_DRIVER_TABLE_GPU_METRICS);
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	gpu_metrics->temperature_hotspot = SMUQ10_ROUND(metrics->MaxSocketTemperature);
+
+	/* Per-HBM stack temperatures */
+	if (adev->umc.active_mask) {
+		u64 mask = adev->umc.active_mask;
+		int out_idx = 0;
+		int stack_idx;
+
+		if (unlikely(hweight64(mask)/4 > SMU_15_0_8_MAX_HBM_STACKS))
+			dev_warn(adev->dev, "Invalid umc mask %lld\n", mask);
+		else  {
+			for_each_hbm_stack(stack_idx, mask) {
+				if (!hbm_stack_mask_valid(mask))
+					continue;
+				gpu_metrics->temperature_hbm[out_idx++] =
+					SMUQ10_ROUND(metrics->HbmTemperature[stack_idx]);
+			}
+		}
+	}
+
+	/* Reports max temperature of all voltage rails */
+	gpu_metrics->temperature_vrsoc = SMUQ10_ROUND(metrics->MaxVrTemperature);
+	/* MID, AID, XCD temperatures */
+	idx = 0;
+	for_each_inst(i, mid_mask) {
+		gpu_metrics->temperature_mid[idx] = SMUQ10_ROUND(metrics->MidTemperature[i]);
+		idx++;
+	}
+
+	idx = 0;
+	for_each_inst(i, aid_mask) {
+		gpu_metrics->temperature_aid[idx] = SMUQ10_ROUND(metrics->AidTemperature[i]);
+		idx++;
+	}
+
+	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); ++i) {
+		xcc_id = GET_INST(GC, i);
+		if (xcc_id >= 0)
+			gpu_metrics->temperature_xcd[i] = SMUQ10_ROUND(metrics->XcdTemperature[xcc_id]);
+	}
+	/* Power */
+	gpu_metrics->curr_socket_power = SMUQ10_ROUND(metrics->SocketPower);
+
+	gpu_metrics->average_gfx_activity = SMUQ10_ROUND(metrics->SocketGfxBusy);
+	gpu_metrics->average_umc_activity = SMUQ10_ROUND(metrics->DramBandwidthUtilization);
+	gpu_metrics->mem_max_bandwidth = SMUQ10_ROUND(metrics->MaxDramBandwidth);
+
+	/* Energy counter reported in 15.259uJ (2^-16) units */
+	gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
+
+	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); ++i) {
+		xcc_id = GET_INST(GC, i);
+		if (xcc_id >= 0) {
+			gpu_metrics->current_gfxclk[i] =
+				SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
+		}
+	}
+
+	/* Per-MID clocks */
+	idx = 0;
+	for_each_inst(i, mid_mask) {
+		gpu_metrics->current_socclk[idx] = SMUQ10_ROUND(metrics->SocclkFrequency[i]);
+		idx++;
+	}
+
+	/* Per-VCN clocks */
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		inst = GET_INST(VCN, i);
+		if (inst >= 0) {
+			gpu_metrics->current_vclk0[i] = SMUQ10_ROUND(metrics->VclkFrequency[inst]);
+			gpu_metrics->current_dclk0[i] = SMUQ10_ROUND(metrics->DclkFrequency[inst]);
+		}
+	}
+
+	/* Per-AID clocks */
+	idx = 0;
+	for_each_inst(i, aid_mask) {
+		gpu_metrics->current_uclk[idx] = SMUQ10_ROUND(metrics->UclkFrequency[i]);
+		idx++;
+	}
+
+	/* Total accumulated cycle counter */
+	gpu_metrics->accumulation_counter = metrics->AccumulationCounter;
+
+	/* Accumulated throttler residencies */
+	gpu_metrics->prochot_residency_acc = metrics->ProchotResidencyAcc;
+	gpu_metrics->ppt_residency_acc = metrics->PptResidencyAcc;
+	gpu_metrics->socket_thm_residency_acc = metrics->SocketThmResidencyAcc;
+	gpu_metrics->vr_thm_residency_acc = metrics->VrThmResidencyAcc;
+	gpu_metrics->hbm_thm_residency_acc = metrics->HbmThmResidencyAcc;
+
+	gpu_metrics->gfx_activity_acc = SMUQ10_ROUND(metrics->SocketGfxBusyAcc);
+	gpu_metrics->mem_activity_acc = SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
+
+	for (i = 0; i < NUM_XGMI_LINKS; i++) {
+		j = amdgpu_xgmi_get_ext_link(adev, i);
+		if (j < 0 || j >= NUM_XGMI_LINKS)
+			continue;
+		ret = amdgpu_get_xgmi_link_status(adev, i);
+		if (ret >= 0)
+			gpu_metrics->xgmi_link_status[j] = ret;
+	}
+
+	gpu_metrics->xgmi_read_data_acc = SMUQ10_ROUND(metrics->XgmiReadBandwidthAcc);
+	gpu_metrics->xgmi_write_data_acc = SMUQ10_ROUND(metrics->XgmiWriteBandwidthAcc);
+
+	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); ++i) {
+		inst = GET_INST(GC, i);
+		gpu_metrics->gfx_busy_inst[i] = SMUQ10_ROUND(metrics->GfxBusy[inst]);
+		gpu_metrics->gfx_busy_acc[i] = SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
+		gpu_metrics->gfx_below_host_limit_ppt_acc[i] =
+			SMUQ10_ROUND(metrics->GfxclkBelowHostLimitPptAcc[inst]);
+		gpu_metrics->gfx_below_host_limit_thm_acc[i] =
+			SMUQ10_ROUND(metrics->GfxclkBelowHostLimitThmAcc[inst]);
+		gpu_metrics->gfx_low_utilization_acc[i] =
+			SMUQ10_ROUND(metrics->GfxclkLowUtilizationAcc[inst]);
+		gpu_metrics->gfx_below_host_limit_total_acc[i] =
+			SMUQ10_ROUND(metrics->GfxclkBelowHostLimitTotalAcc[inst]);
+	}
+
+	gpu_metrics->xgmi_link_width = metrics->XgmiWidth;
+	gpu_metrics->xgmi_link_speed = metrics->XgmiBitrate;
+
+	gpu_metrics->firmware_timestamp = metrics->Timestamp;
+
+	*table = gpu_metrics;
+
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
+	return sizeof(*gpu_metrics);
+}
+
 static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.init_allowed_features = smu_v15_0_8_init_allowed_features,
 	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
@@ -990,6 +1161,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.get_pm_metrics = smu_v15_0_8_get_pm_metrics,
 	.mode2_reset = smu_v15_0_8_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v15_0_8_get_dpm_ultimate_freq,
+	.get_gpu_metrics = smu_v15_0_8_get_gpu_metrics,
 };
 
 static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index 6c85f23d31116..8fc16796788b5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -23,6 +23,15 @@
 #ifndef __SMU_15_0_8_PPT_H__
 #define __SMU_15_0_8_PPT_H__
 
+#define SMU_15_0_8_NUM_XGMI_LINKS 8
+#define SMU_15_0_8_MAX_GFX_CLKS 8
+#define SMU_15_0_8_MAX_CLKS 4
+#define SMU_15_0_8_MAX_XCC 8
+#define SMU_15_0_8_MAX_VCN 4
+#define SMU_15_0_8_MAX_JPEG 40
+#define SMU_15_0_8_MAX_AID 2
+#define SMU_15_0_8_MAX_MID 2
+#define SMU_15_0_8_MAX_HBM_STACKS 12
 extern void smu_v15_0_8_set_ppt_funcs(struct smu_context *smu);
 
 typedef struct {
@@ -55,4 +64,121 @@ typedef struct {
 	bool init;
 } PPTable_t;
 
+#if defined(SWSMU_CODE_LAYER_L2)
+#include "smu_cmn.h"
+
+/* SMUv 15.0.8 GPU metrics*/
+#define SMU_15_0_8_METRICS_FIELDS(SMU_SCALAR, SMU_ARRAY)                       \
+	SMU_SCALAR(SMU_MATTR(TEMPERATURE_HOTSPOT), SMU_MUNIT(TEMP_1),          \
+		   SMU_MTYPE(U16), temperature_hotspot);                       \
+	SMU_SCALAR(SMU_MATTR(TEMPERATURE_MEM), SMU_MUNIT(TEMP_1),              \
+		   SMU_MTYPE(U16), temperature_mem);                           \
+	SMU_SCALAR(SMU_MATTR(TEMPERATURE_VRSOC), SMU_MUNIT(TEMP_1),            \
+		   SMU_MTYPE(U16), temperature_vrsoc);                         \
+	SMU_ARRAY(SMU_MATTR(TEMPERATURE_HBM), SMU_MUNIT(TEMP_1),               \
+		  SMU_MTYPE(U16), temperature_hbm,                             \
+		  SMU_15_0_8_MAX_HBM_STACKS);                                  \
+	SMU_ARRAY(SMU_MATTR(TEMPERATURE_MID), SMU_MUNIT(TEMP_1),               \
+		  SMU_MTYPE(U16), temperature_mid, SMU_15_0_8_MAX_MID);        \
+	SMU_ARRAY(SMU_MATTR(TEMPERATURE_AID), SMU_MUNIT(TEMP_1),               \
+		  SMU_MTYPE(U16), temperature_aid, SMU_15_0_8_MAX_AID);        \
+	SMU_ARRAY(SMU_MATTR(TEMPERATURE_XCD), SMU_MUNIT(TEMP_1),               \
+		  SMU_MTYPE(U16), temperature_xcd, SMU_15_0_8_MAX_XCC);        \
+	SMU_SCALAR(SMU_MATTR(CURR_SOCKET_POWER), SMU_MUNIT(POWER_1),           \
+		   SMU_MTYPE(U16), curr_socket_power);                         \
+	SMU_SCALAR(SMU_MATTR(AVERAGE_GFX_ACTIVITY), SMU_MUNIT(PERCENT),        \
+		   SMU_MTYPE(U16), average_gfx_activity);                      \
+	SMU_SCALAR(SMU_MATTR(AVERAGE_UMC_ACTIVITY), SMU_MUNIT(PERCENT),        \
+		   SMU_MTYPE(U16), average_umc_activity);                      \
+	SMU_SCALAR(SMU_MATTR(MEM_MAX_BANDWIDTH), SMU_MUNIT(BW_1),              \
+		   SMU_MTYPE(U64), mem_max_bandwidth);                         \
+	SMU_SCALAR(SMU_MATTR(ENERGY_ACCUMULATOR), SMU_MUNIT(NONE),             \
+		   SMU_MTYPE(U64), energy_accumulator);                        \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_CLOCK_COUNTER), SMU_MUNIT(TIME_1),         \
+		   SMU_MTYPE(U64), system_clock_counter);                      \
+	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
+		   SMU_MTYPE(U64), accumulation_counter);                      \
+	SMU_SCALAR(SMU_MATTR(PROCHOT_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
+		   SMU_MTYPE(U64), prochot_residency_acc);                     \
+	SMU_SCALAR(SMU_MATTR(PPT_RESIDENCY_ACC), SMU_MUNIT(NONE),              \
+		   SMU_MTYPE(U64), ppt_residency_acc);                         \
+	SMU_SCALAR(SMU_MATTR(SOCKET_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),       \
+		   SMU_MTYPE(U64), socket_thm_residency_acc);                  \
+	SMU_SCALAR(SMU_MATTR(VR_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),           \
+		   SMU_MTYPE(U64), vr_thm_residency_acc);                      \
+	SMU_SCALAR(SMU_MATTR(HBM_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
+		   SMU_MTYPE(U64), hbm_thm_residency_acc);                     \
+	SMU_SCALAR(SMU_MATTR(GFXCLK_LOCK_STATUS), SMU_MUNIT(NONE),             \
+		   SMU_MTYPE(U32), gfxclk_lock_status);                        \
+	SMU_SCALAR(SMU_MATTR(PCIE_LINK_WIDTH), SMU_MUNIT(NONE),                \
+		   SMU_MTYPE(U16), pcie_link_width);                           \
+	SMU_SCALAR(SMU_MATTR(PCIE_LINK_SPEED), SMU_MUNIT(SPEED_2),             \
+		   SMU_MTYPE(U16), pcie_link_speed);                           \
+	SMU_SCALAR(SMU_MATTR(XGMI_LINK_WIDTH), SMU_MUNIT(NONE),                \
+		   SMU_MTYPE(U16), xgmi_link_width);                           \
+	SMU_SCALAR(SMU_MATTR(XGMI_LINK_SPEED), SMU_MUNIT(SPEED_1),             \
+		   SMU_MTYPE(U16), xgmi_link_speed);                           \
+	SMU_SCALAR(SMU_MATTR(GFX_ACTIVITY_ACC), SMU_MUNIT(NONE),               \
+		   SMU_MTYPE(U64), gfx_activity_acc);                          \
+	SMU_SCALAR(SMU_MATTR(MEM_ACTIVITY_ACC), SMU_MUNIT(NONE),               \
+		   SMU_MTYPE(U64), mem_activity_acc);                          \
+	SMU_ARRAY(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(NONE),              \
+		  SMU_MTYPE(U64), pcie_bandwidth_acc, SMU_15_0_8_MAX_MID);     \
+	SMU_ARRAY(SMU_MATTR(PCIE_BANDWIDTH_INST), SMU_MUNIT(BW_1),             \
+		  SMU_MTYPE(U32), pcie_bandwidth_inst, SMU_15_0_8_MAX_MID);    \
+	SMU_SCALAR(SMU_MATTR(PCIE_L0_TO_RECOV_COUNT_ACC), SMU_MUNIT(NONE),     \
+		   SMU_MTYPE(U64), pcie_l0_to_recov_count_acc);                \
+	SMU_SCALAR(SMU_MATTR(PCIE_REPLAY_COUNT_ACC), SMU_MUNIT(NONE),          \
+		   SMU_MTYPE(U64), pcie_replay_count_acc);                     \
+	SMU_SCALAR(SMU_MATTR(PCIE_REPLAY_ROVER_COUNT_ACC), SMU_MUNIT(NONE),    \
+		   SMU_MTYPE(U64), pcie_replay_rover_count_acc);               \
+	SMU_SCALAR(SMU_MATTR(PCIE_NAK_SENT_COUNT_ACC), SMU_MUNIT(NONE),        \
+		   SMU_MTYPE(U64), pcie_nak_sent_count_acc);                   \
+	SMU_SCALAR(SMU_MATTR(PCIE_NAK_RCVD_COUNT_ACC), SMU_MUNIT(NONE),        \
+		   SMU_MTYPE(U64), pcie_nak_rcvd_count_acc);                   \
+	SMU_ARRAY(SMU_MATTR(XGMI_LINK_STATUS), SMU_MUNIT(NONE),                \
+		  SMU_MTYPE(U16), xgmi_link_status,                            \
+		  SMU_15_0_8_NUM_XGMI_LINKS);                                  \
+	SMU_SCALAR(SMU_MATTR(XGMI_READ_DATA_ACC), SMU_MUNIT(DATA_1),           \
+		   SMU_MTYPE(U64), xgmi_read_data_acc);                        \
+	SMU_SCALAR(SMU_MATTR(XGMI_WRITE_DATA_ACC), SMU_MUNIT(DATA_1),          \
+		   SMU_MTYPE(U64), xgmi_write_data_acc);                                  \
+	SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),           \
+		   SMU_MTYPE(U64), firmware_timestamp);                        \
+	SMU_ARRAY(SMU_MATTR(CURRENT_GFXCLK), SMU_MUNIT(CLOCK_1),               \
+		  SMU_MTYPE(U16), current_gfxclk, SMU_15_0_8_MAX_GFX_CLKS);    \
+	SMU_ARRAY(SMU_MATTR(CURRENT_SOCCLK), SMU_MUNIT(CLOCK_1),               \
+		  SMU_MTYPE(U16), current_socclk, SMU_15_0_8_MAX_MID);         \
+	SMU_ARRAY(SMU_MATTR(CURRENT_VCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_vclk0, SMU_15_0_8_MAX_VCN);          \
+	SMU_ARRAY(SMU_MATTR(CURRENT_DCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_dclk0, SMU_15_0_8_MAX_VCN);          \
+	SMU_ARRAY(SMU_MATTR(CURRENT_UCLK), SMU_MUNIT(CLOCK_1),                 \
+		  SMU_MTYPE(U16), current_uclk, SMU_15_0_8_MAX_AID);           \
+	SMU_SCALAR(SMU_MATTR(PCIE_LC_PERF_OTHER_END_RECOVERY),                 \
+		   SMU_MUNIT(NONE), SMU_MTYPE(U64),                            \
+		   pcie_lc_perf_other_end_recovery);                           \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_INST), SMU_MUNIT(PERCENT),                \
+		  SMU_MTYPE(U32), gfx_busy_inst, SMU_15_0_8_MAX_XCC);          \
+	SMU_ARRAY(SMU_MATTR(JPEG_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),    \
+		  jpeg_busy, SMU_15_0_8_MAX_JPEG);                             \
+	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),     \
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
+		  SMU_15_0_8_MAX_XCC);
+
+DECLARE_SMU_METRICS_CLASS(smu_v15_0_8_gpu_metrics, SMU_15_0_8_METRICS_FIELDS);
+#endif
 #endif
-- 
2.53.0

