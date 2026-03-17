Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8E0FD708D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A00DF10E5F1;
	Tue, 17 Mar 2026 20:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AyW1Xa94";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2731C10E639
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRpb802RzA6xy8uLc3Wc53/LLHKLoU3WgpHC4YnZxMTDySdPokL+zYaSwJcRbVhuCwiMP4Kq8uE43aEgtZg2zddtr3CnXJhagbwgk0yPBmYMwm4qg1Czvd4TPRK7FWJ93bLiZDVF391dUTFlM2NXd0idc0kWOT3OEm/ATEayoJKAiwWA+G2QgOA53d6SiQlKRfwV7lpVHnag3H8941wXKZjmb+FAF5LqQOy0yuaWLf1QPBMuKPwQPeZ0PBMUNGgh79KKUiZvekqexU5c3JkRnT6rdLXNa4n6J+MsvU0gOWiG+HbVd7T8bzhjjtEZU8zxuV9aqOl5PHs5/boJlr06sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcGNg1NzEZeZ51ckLt4jpJN1JILX8OG+rvXZqvifZFU=;
 b=ufyAWkhaTVP9G7KI//GH3Z557kVgn7h7prK434rSfZr+EoUapXKZe2y6bXRxlUYKmTWc+BPps4V/Si9IfLm6J7RW72YdqfvJOE1kdlawkoM0Rg3NjEl4CN1EcJKXKQ2A9JgNoTKUEjjgB2mVn7HdL9TXeOUZccZ46/+8Ox1c5J8PzTb/2DCEH1/alaVfTtSSaZucRS7SuUcFb/vFHMj8yrex5Gow4wXua5VjFRpqrlR72OVICt2Fsm+kixyad0w7Zs29Jdu5HJ2qC0CSFFjq8JBzyEO0KOPilpv7L5dg2tvSi0e5TbhsCbdJ6KzHuxV0GziAN9zPTb836Woyqqv1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcGNg1NzEZeZ51ckLt4jpJN1JILX8OG+rvXZqvifZFU=;
 b=AyW1Xa9441Edxd825rak7mWIA5NRkdZZCqcn6rcsp5q6GnzHWaHp79hCVUmUwDklgUZ52CfldcQA88B+7X8/pXu4SCWeNeRW/eLu2S7FVY2/fxjD9XltNq2Pzm/oYiljWkY5SY/w3/otA6LyGORhQwlLmmHFU558fxqUcDfUlB0=
Received: from PH2PEPF00003848.namprd17.prod.outlook.com (2603:10b6:518:1::65)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:13:08 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH2PEPF00003848.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 20:13:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 15:13:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/25] drm/amd/pm: Add get_pm_metrics support for smu 15.0.8
Date: Tue, 17 Mar 2026 16:12:26 -0400
Message-ID: <20260317201242.3808136-10-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dffea4e-d9a3-4232-37cc-08de84619b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6BzxqyREHsapVJEq6GkNOqwgZI7fCBM4Y31SZviz0ptc5rvgJCRT1dG5b7JRIJ93ISQuqv/BshO5iCFh/uRkKcIFuHiT5t3gAJeirB7OBOhaG4RLXdOICLrr9Ijthp//TI9zTxV3MJ4WL0T7daerjJpcid2GvI7Xj0RQ5V1hbERRxnPT5pSC+6YF4CEEktPA1FcF6p0EkYim9aUrilhj9wAS+s4uvqjeew0S2T8+mkVAwYtuVutU1TklP1uMRqzZlxx6gglINtbB5gKLKrRNTPMM0Dt8kANfniChMoQJqWtFPgjy4fwIjUQ0p9BmwjUm0sGCUmvFaI9PgraVyBOU2Z6+zCvIFNgniUp+FaHWN7I4PQtxlS9tIxZf1MEDyzZk+BJTWPUfNxMurEZiTj6DypvQ+HOstxHXSBbzt6z6KQ9BSaoBmGKTdhVScHDMVMHayU3i54B0Rueg6819hTk7Mh0s8jMMueKdzRCuHGJyM5aJeuj/0Yi1LhYBjsI1cpLEHo7pesNm7XGbyWZVS6oHDJsDxRrpnpecW3Npwu8SoMnjKRpU8S5dH1ZHcUA2tsYFLMC7X/Fq6DRul0IAEuV4qCZyTTYjaM6tbgKCxi6SHUgwoY2Ti5KsHkdZZWxUCMkY9IuQ905uWJmRZg3PVLcTIixCE0RQx/MAqc/ay5ObEIlbHjLWs8FnMljdud9DTD66s0ThA5NYuk+3jzfRarzscdoFCmERAbfOxWDxK60hr9Ym/wC59KPi/BQgij2omaTCwweDXBLGSUVJwp0V6ervig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 20fQeeDllYzLwugBa+4zxZi1QpUbJ4r8WJ1gmtuJOxaB8saUfBqotYIfzkFn0evkuM8G0OG/YwJE1RLjZ4kxfyv2tvXQ4UMBu6L6CZLkHtcctYvVKwnJEuAKY+it31ON4nOf458TQcsnqCaoEcsU+8GvqsLgC0xjrxwuUJIvbrppc65Ci1Ho6QBgyzcfuUyfrB42BlhN8NJFWY2ynFoNNxz4LJWp53gb9Q8bc5V3n1itdSnBGU/BCz8b0PhIZIejh5qE6p2AgZFVDSi8ERQ/+Dm28HvPPdVhog+FoVRnn4b4ThOLZJKgwWHIYudlRcixcBV6E0wTxWi1wn9Q+pTRBwcsnaK0N0/oKQldshwNrZYz/QbfHGwW7d1O70GvRaNXwWdxY7QereNVciX8KNO60RMZzfGvF6xSjsa7lbp07TMWKKPzwVPy5TCOYAGQoLIG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:08.0903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dffea4e-d9a3-4232-37cc-08de84619b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
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

export .get_pm_metrics interface for smu 15.0.8.

v2: Make tmo as unsigned (Lijo)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 149421b1c6cbf..60a43ce5648a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -263,6 +263,37 @@ static int smu_v15_0_8_init_allowed_features(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v15_0_8_get_metrics_table_internal(struct smu_context *smu, uint32_t tmo, void *data)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	struct smu_table *table = &smu_table->driver_table;
+	struct amdgpu_device *adev = smu->adev;
+	int ret;
+
+	mutex_lock(&smu_table->metrics_lock);
+
+	if (!tmo || !smu_table->metrics_time ||
+	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(tmo))) {
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsTable, NULL);
+		if (ret) {
+			dev_info(adev->dev,
+				 "Failed to export SMU metrics table!\n");
+			return ret;
+		}
+
+		amdgpu_device_invalidate_hdp(smu->adev, NULL);
+		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
+
+		smu_table->metrics_time = jiffies;
+	}
+
+	if (data)
+		memcpy(data, smu_table->metrics_table, table_size);
+	mutex_unlock(&smu_table->metrics_lock);
+	return ret;
+}
+
 static int smu_v15_0_8_get_dpm_ultimate_freq(struct smu_context *smu,
 					     enum smu_clk_type clk_type,
 					     uint32_t *min, uint32_t *max)
@@ -860,6 +891,39 @@ static bool smu_v15_0_8_is_dpm_running(struct smu_context *smu)
 					  smu_v15_0_8_dpm_features.bits);
 }
 
+static ssize_t smu_v15_0_8_get_pm_metrics(struct smu_context *smu,
+					  void *metrics, size_t max_size)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct amdgpu_pm_metrics *pm_metrics = (struct amdgpu_pm_metrics *)metrics;
+	uint32_t table_version = smu_table->tables[SMU_TABLE_SMU_METRICS].version;
+	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	uint32_t pmfw_version;
+	int ret;
+
+	if (!pm_metrics || !max_size)
+		return -EINVAL;
+
+	if (max_size < (table_size + sizeof(pm_metrics->common_header)))
+		return -EOVERFLOW;
+
+	/* Don't use cached metrics data */
+	ret = smu_v15_0_8_get_metrics_table_internal(smu, 0, pm_metrics->data);
+	if (ret)
+		return ret;
+
+	smu_cmn_get_smc_version(smu, NULL, &pmfw_version);
+	memset(&pm_metrics->common_header, 0, sizeof(pm_metrics->common_header));
+	pm_metrics->common_header.mp1_ip_discovery_version =
+		amdgpu_ip_version(smu->adev, MP1_HWIP, 0);
+	pm_metrics->common_header.pmfw_version = pmfw_version;
+	pm_metrics->common_header.pmmetrics_version = table_version;
+	pm_metrics->common_header.structure_size =
+		sizeof(pm_metrics->common_header) + table_size;
+
+	return pm_metrics->common_header.structure_size;
+}
+
 static int smu_v15_0_8_mode2_reset(struct smu_context *smu)
 {
 	struct smu_msg_ctl *ctl = &smu->msg_ctl;
@@ -923,6 +987,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.setup_pptable = smu_v15_0_8_setup_pptable,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.wait_for_event = smu_v15_0_wait_for_event,
+	.get_pm_metrics = smu_v15_0_8_get_pm_metrics,
 	.mode2_reset = smu_v15_0_8_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v15_0_8_get_dpm_ultimate_freq,
 };
-- 
2.53.0

