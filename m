Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE54CA5FF1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8508910F5A4;
	Wed,  7 Oct 2026 13:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1GO7opcr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0EE10F58A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFFkrWtmxjsns6P1T/ouUlKr+zOE01NTZBWstmfQbolKOWX5c36EnSHLUtsUUD/Oz9v5dk8qnT3ZJJG8bi+THh64IVHQnvJEUFgQyEIX+bq8NSfqx1pFDhbj5fsmmbwcKNcmnlJseQRkIh57XHf4RVSxi18coHdQXpeTojy/U87jfG5xuHR6Oewj092AQBMz4Zt3IkjQCGd95nibmGZg1pm0O65+pS8QnNw2Tf4MWoudOgWXluHvNL7YA3cikUZ/QrtrrKte25z90oENRMS5GyZLrRykEmaoXsKDh0vYmT7z6EKMAWo68s4oP0rxXwe7uPXNgqjbBiUrgzeWGOF5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcTpBmxUZn6pWFHovCm+BcZfB/aMBVVfgJZUv7G2tEw=;
 b=Z7ZfslPZxzxksId+36/bW0l9ptowOsJy2FHi6yvhxWyZ/Y/bbvLmzddQAi/AjIFAt5jtauK5ICzyUkvGxYczwhVfyPs/e8bBkwZc+4WjFaFv41OHyf1wzwWRBe5Z3figy/2v37aetM87JYYVgxcbiEzJTD9nmwyItQoqbAIXTl6P3YVmKxHFZK9UwoMkK/c9LzNoWu5ylJkqRM8wwDzfKQKCmz31BqIJeIipcR/pTtbEbduvxLtVoUCgicdxV1WhGSoVvAkKWYtCMkkj3BVhf/9DF+jb+8tgLLadu9r0zhn6p7DHZ5hd5FNnBp/fQt8X3atcxz3sQFvfEs91J9/q3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcTpBmxUZn6pWFHovCm+BcZfB/aMBVVfgJZUv7G2tEw=;
 b=1GO7opcr7b6eD3hgWka4iKgj5NtACAnswqs93jCo+TU2MHR8UJpArqPOUy1kXjaF4k40288a1fI4Sz8z1nir4vNMgGhzNuHJdIrHV4AuK37l2FZT56bDi39rEKPsgZXfaCGFyw8y4gSWo8JWLv9LMdXpCWOKxJssMJmYWsbfEe8=
Received: from BY5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:1e0::21)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 7 Oct
 2026 13:14:50 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::80) by BY5PR03CA0011.outlook.office365.com
 (2603:10b6:a03:1e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 7
 Oct 2026 13:14:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:14:49 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:14:45 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: Add NPM metrics reads and SetNpmLimit
Date: Wed, 7 Oct 2026 21:14:27 +0800
Message-ID: <20261007131428.351196-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261007131428.351196-1-asad.kamal@amd.com>
References: <20261007131428.351196-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: a40578a3-bbf9-48c8-c164-08df2474f73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wWr6FYH3TfgfciigL06Jj8UOOBgtQ/3P/g3/E5RhzAQNRDeVpz+or9SdF8twZ5mN8eWblY6uRXdHS9BFdEAGzs1YhfU9rbrOGHbN92AOyOft0Uo3yG9n0Jkzn4ELCi88KHh237e+KhewZtvmA3ijtgsfWSzyhpNRuGBSifyDRSVraevLs/2v2i3U9GaDcwcoccQr3PLIaoGrbKohrLWj71B5IEzfEEP8zYfG36VwZdgkFe+M4aRPQEVLjE2hdnnIFwRsI2GIv+tMn+CwBR7pqPQNhxK+Ha/lagHd10cx+MTnL+zH1LhIY/KFa7eULeMb8HsazI3N+LKA1Y+sv+nOofrkd2RDF8wMmAXnR53xwo+aTmJubL34Tm+Dp72jJdX8M2fn14SAUg01X3WSzAnKLRr513ApY1vP9+CJDL9zQpHLntL+5z0EfhEtZGtqoCNPBniHG/zTC2QwTnEONVaGAUMdxYOHwajnQX7t3mxARsg3tsi+ylM1y5Vx+N/X+RkpbXfShRx1EKXuSYGsyGd7NghsDsGxRfRsseEyqG98d07QD6JoqZ8nA1xq3jcmm6BIH+tzCoThgQUi/iBoptuAWsByPwTzhBnym0Nz3z9wA3ul3i3wFZ7fQoWWPuPqSbwyV4MNbuYH/VnaFkrf1Y97YuaIKGx/eGVgTF6p3sgTYS6kwsoQszbkVWBP93NJrwffo1zcHVMvZvilZWzmjGBkBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TCz11UmCDrmYTPcW8tbayI/f+6nVw6ONYG2cmTA++03cJwW7X4b4uF4FbrBgnf7Gq6fkMRpvajh/bPB16Bdg7EC6HFo4uYc4z+En0WbxUNY+QInolO/xzgeMXi4cTvkTN9Tqnox8a8yyCy6odL4JgA+UWpy/4xxQU9TDegy0A0rohyj2ikbNOKsX48iFOpacRemSl3iQLlsHfy4JzkCYnZbJEPDeISK2OcgVQJXpB+EYB/BgEgZFkSgVjnp68B8AmTo9SH9MTgleJN3tx6pi5d+6RKaWOxSxyIjyoMFJuyRfvnDq/HYbKT1rS/j6/M7LtaBAZX1faXVNB3pFtJHY5KRdv/dUYooDqMVypKhijUujDHTTR6c4dfVMv+i1gtSFCm+30BGzbwuDrMdlWRUvqnpJoeSe7hTg6zfE33fMS+1AZYc58d5+LgezjFizboDZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:14:49.1315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a40578a3-bbf9-48c8-c164-08df2474f73b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
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

Add NPM metrics reads, SetNpmLimit for smu_v15_0_8 and enable NPM
feature based on system metrics version

v2: Move init caps during pptable init

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 89 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h  |  2 +
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index a013ae2a877e..e7213f3ebf63 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -137,6 +137,7 @@ static const struct cmn2asic_msg_mapping smu_v15_0_8_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetSoftMaxGl2clk,                    PPSMC_MSG_SetSoftMaxGl2clk,		0),
 	MSG_MAP(SetSoftMinFclk,                      PPSMC_MSG_SetSoftMinFclk,			0),
 	MSG_MAP(SetSoftMaxFclk,                      PPSMC_MSG_SetSoftMaxFclk,			0),
+	MSG_MAP(SetNpmLimit,                         PPSMC_MSG_SetNpmLimit,			0),
 };
 
 /* TODO: Update the clk map once enum PPCLK is updated in smu15_driver_if_v15_0_8.h */
@@ -588,19 +589,86 @@ static int smu_v15_0_8_get_system_metrics_table(struct smu_context *smu)
 	return 0;
 }
 
+static inline void smu_v15_0_8_cap_set(struct smu_context *smu, u32 cap)
+{
+	struct smu_15_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+
+	dpm_context->caps |= BIT_ULL(cap);
+}
+
+static bool smu_v15_0_8_cap_supported(struct smu_context *smu, u32 cap)
+{
+	struct smu_15_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+
+	return !!(dpm_context->caps & BIT_ULL(cap));
+}
+
+static void smu_v15_0_8_init_npm_cap(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	SystemMetricsTable_t *metrics;
+	struct smu_table *sys_table;
+	uint32_t table_version;
+	int ret;
+
+	if (smu->adev->gmc.xgmi.physical_node_id != 0)
+		return;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsVersion,
+				   &table_version);
+	if (ret)
+		return;
+
+	if (table_version < SMU_SYSTEM_METRICS_TABLE_VERSION)
+		return;
+
+	ret = smu_v15_0_8_get_system_metrics_table(smu);
+	if (ret)
+		return;
+
+	sys_table = &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
+	metrics = (SystemMetricsTable_t *)sys_table->cache.buffer;
+	if (!metrics->NpmSupported)
+		return;
+
+	smu_v15_0_8_cap_set(smu, SMU_15_0_8_CAP_NPM);
+}
+
+static void smu_v15_0_8_init_caps(struct smu_context *smu)
+{
+	smu_v15_0_8_init_npm_cap(smu);
+}
+
+static u64 smu_v15_0_8_get_npm_cap(struct smu_context *smu)
+{
+	if (!smu_v15_0_8_cap_supported(smu, SMU_15_0_8_CAP_NPM))
+		return 0;
+
+	return AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_CUR_NODE_POWER_LIMIT) |
+	       AMDGPU_NPM_CAP_W(AMDGPU_NPM_CAP_CUR_NODE_POWER_LIMIT) |
+	       AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_NODE_POWER)           |
+	       AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_GLOBAL_PPT_RESID)     |
+	       AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_MAX_NODE_POWER_LIMIT) |
+	       AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_NPM_STATUS);
+}
+
 static int smu_v15_0_8_get_npm_data(struct smu_context *smu,
 				    enum amd_pp_sensors sensor,
 				    uint32_t *value)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	PPTable_t *pptable = (PPTable_t *)smu_table->driver_pptable;
 	struct smu_table *tables = smu_table->tables;
 	SystemMetricsTable_t *metrics;
 	struct smu_table *sys_table;
 	int ret;
 
+	if (!smu_v15_0_8_cap_supported(smu, SMU_15_0_8_CAP_NPM))
+		return -EOPNOTSUPP;
+
 	if (sensor == AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT) {
-		/*TBD as of now put 0 */
-		*value = 0;
+		*value = pptable->MaxNodePowerLimit;
 		return 0;
 	}
 
@@ -619,7 +687,7 @@ static int smu_v15_0_8_get_npm_data(struct smu_context *smu,
 		*value = SMUQ10_ROUND(metrics->NodePower);
 		break;
 	case AMDGPU_PP_SENSOR_NPMSTATUS:
-		*value = !!SMUQ10_ROUND(metrics->NodePower);
+		*value = !!metrics->NpmEnabled;
 		break;
 	case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
 		*value = SMUQ10_ROUND(metrics->NPMResidencyAcc);
@@ -631,6 +699,15 @@ static int smu_v15_0_8_get_npm_data(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v15_0_8_set_npm_limit(struct smu_context *smu, uint32_t limit)
+{
+	if (!smu_v15_0_8_cap_supported(smu, SMU_15_0_8_CAP_NPM))
+		return -EOPNOTSUPP;
+
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetNpmLimit,
+					       limit, NULL);
+}
+
 static int smu_v15_0_8_read_sensor(struct smu_context *smu,
 				   enum amd_pp_sensors sensor, void *data,
 				   uint32_t *size)
@@ -1149,6 +1226,10 @@ static int smu_v15_0_8_set_driver_pptable(struct smu_context *smu)
 				static_metrics->pldmVersion[0];
 		dpm_context->board_volt = static_metrics->InputTelemetryVoltageInmV;
 		smu_v15_0_8_init_xgmi_data(smu, static_metrics);
+		smu_v15_0_8_init_caps(smu);
+		if (smu_v15_0_8_cap_supported(smu, SMU_15_0_8_CAP_NPM))
+			pptable->MaxNodePowerLimit =
+				static_metrics->MaxNodePowerLimit;
 		pptable->init = true;
 	}
 
@@ -2382,6 +2463,8 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.get_unique_id = smu_v15_0_8_get_unique_id,
 	.get_ppt_limit = smu_v15_0_8_get_ppt_limit,
 	.set_ppt_limit = smu_v15_0_8_set_ppt_limit,
+	.get_npm_cap = smu_v15_0_8_get_npm_cap,
+	.set_npm_limit = smu_v15_0_8_set_npm_limit,
 	.emit_clk_levels = smu_v15_0_8_emit_clk_levels,
 	.read_sensor = smu_v15_0_8_read_sensor,
 	.populate_umd_state_clk = smu_v15_0_8_populate_umd_state_clk,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
index 46fce0a79c21..bc0f20e43e0a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h
@@ -32,6 +32,7 @@
 #define SMU_15_0_8_MAX_AID 2
 #define SMU_15_0_8_MAX_MID 2
 #define SMU_15_0_8_MAX_HBM_STACKS 12
+#define SMU_15_0_8_CAP_NPM			1
 extern void smu_v15_0_8_set_ppt_funcs(struct smu_context *smu);
 
 typedef struct {
@@ -61,6 +62,7 @@ typedef struct {
 	uint32_t PPT1Max;
 	uint32_t PPT1Min;
 	uint32_t PPT1Default;
+	uint32_t MaxNodePowerLimit;
 	bool init;
 } PPTable_t;
 
-- 
2.46.0

