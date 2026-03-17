Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80A9FD707A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8128110E62E;
	Tue, 17 Mar 2026 20:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XE0VD4Uq";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B841E10E5E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePJXlXcQtRuv9GXd/JMR6xgTzO/lH6eDByLjFo7Jluuj2MQUNOgMWT8TtEFearqjSf5hmrMPbivBGEs+0aEX0Ev2GqxsdDtxLZVOhA/OwEDvEWaD5IvktNXOTJwmXfN6twI8tWUJuOHITVeGponFaSVdCSeqQUBdKlO7GA+kT3bBjFVJzUgNB2oWbmRqXSod5OYy3eS1gX/UckARGiobFEPHn2qRbgxE45jqdOc/e16x2OOX0dMmgvHWI7NffnUHTbQJ8wvZY1nIMmCFWd7Xedygs2z8d3bNOnJ8+wIbq54iExfT7W9NcnR1UdjTx2c09m6mD42ld3R5caq5uWb2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvvSmupNv8pDHPoYSju9bb+uYPjxzJ1NDlfb8pjuswM=;
 b=PuJ/TH3mLBOYIflsmSO2/9/fDq6Jt6yCFcPSfmTYWXulv548TcDj/QYNyXA/UrYBvTX0c/7grfJY2qpSrB8hWsfI3nNHRCZmR4a7g615ZBmJjXlgfx/t2CAM/uH4GBq392O73Dy7zEgpo7CzTzbYBLd6ShSbRE3any4JWidzChs721DQG7W0RuWoIq9czOPLq/ZLmYkbMhByWeclgZa8iyYisXwZdZEJKGEuyx+g8OI6SCcrFBwgX3mNV35Q+ybtaVNKmSRseQTG4vogOYv7cW2lb+CqDEKyYR+bOKkfRlF7UOg1mcXlU9WEHkv4yX/GlNbWT5VNPH8rRw2bX+ynNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvvSmupNv8pDHPoYSju9bb+uYPjxzJ1NDlfb8pjuswM=;
 b=XE0VD4UqwkKGKN4jRvWQE7QtqHXP0bUIB87EQThuWZGNFjt3dc+WvLYiFE/yYCP6A7YjB/7j3uxLwzCHWDPYY4RRwF9orX6IV0MSFNFKysJG3islrgR1kKL+myA4caTZcg9aAZ1VhrK50z8HKsM1qdTyqAYEIfkW93A3xnCYemQ=
Received: from PH7PR17CA0012.namprd17.prod.outlook.com (2603:10b6:510:324::12)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 20:13:16 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::67) by PH7PR17CA0012.outlook.office365.com
 (2603:10b6:510:324::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/25] drm/amd/pm: Add set_performance_support
Date: Tue, 17 Mar 2026 16:12:32 -0400
Message-ID: <20260317201242.3808136-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0d319b-af16-469f-9fcd-08de84619f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: KsQu/hbEG1iHNssf9vlRs2l5Adwe2Z6ooasbAktqhADjR8PDfQKrTjKG5qr6N7+rU6aGe8jZVzJu8dkAZ9xLnDvT45pdUITaFAb039j54ur7hNu88qBTA+e0EssYQmu6VcwVVtIcq6tKlLt63vDFtueTRnET7i5zSccPSTKkwacSsdUnXyKpmFNXh70S69DZrrhBc2w8HanRh6fil7kHDxdyQRyV7mrKhgZzmFzJsO8L/Up7nm37fSHXDWPD1zY3ox7R29kBehi7EXpJe5FHV2fF+w3+qw5W2yJWMvEgcPUTSmAjUhX5vnrNKckxFBDmFn3ntL+kztG2GYSlknYVRW+c4tEDUy7PCtE4k3pAT1bdx8eFF3Y7JN5ybgAmVM2+G8ygt2BhlL3oTy8XjtYNhFXOWjPHmcbkG1sEMIUROvzcs3+AcMmtmxNX/Wgbz1QJZLsORQsatHAeIYwtR7pBfwAeYZwCTLDvaH4B6aK5Vj97Yb4yFpb8eU+sBBeTsAetCAOk5/fHiGKxr1cqWT1czgTj8SMs/iJ6/hRX9b6fmLdxMa1WvbecYQeVxJzhnZRL8nvATudZS6clQWvs16y8oBDcirjMo8lUUXhTGbSXTLet4LR+aO7ug+DvjwEW/V76I1rB+Va/2lITMIg0IXKovxRBTytpD7lo4DKxamQTDYbxS/BBT5bXLZ0p9OG2YjRcQwbQTEpbmc6BMNCNEr0YcchitTTnvRcYWvzZYFrVk98WFz8QiXZaJpD/413pLH16aSbxY5T6lzOJjqRK99Icwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Q03GHwei9c3uGh30U6nT3pS3YCWDfeaCrbqFDIH5BShVsze0MLB020EpDZgNajzHyYYORSW34v8hFao0qbnaAzbK1NRA1yzDd5ADCtf9fHUjbqmb99qB945JYV9nR8/DsV0Ns9zjIuCpbdRdgcXx6wZNAwETD/2f/0hpnr1wALiyyinoh9/QKg5fWdbN50RMVdJn23JOVtTf2KZ9hGw0Z5hcGmXTLLXStVmN0teJ0f+Z9WSyY8qzOV8Y2bRxrmg7OFws8U2UMYc4rHUuPLke/1Ux9YZH3vqDR/sp9jzC05ra66kf/kb0LtpDXnNfLkBKMQwg0lgVYBKsDkdtyL8OXuGYabVg5CWzvP9ipNL9+0Sk1F5Q3Niimzl1GXDYZhCBBSpeMrDuITCHQcm7FTmXJ5SfqE2TnZmZUZATih8TpfO+KxldzT1HiluYq7732gm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:15.2035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0d319b-af16-469f-9fcd-08de84619f53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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

Add set_performance_support for smu_v15_0_8

v2: Skip Gl2clk/fclk (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 141 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  10 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   1 +
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index f3378e73b6ccb..435798388b012 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1391,6 +1391,144 @@ static int smu_v15_0_8_populate_umd_state_clk(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v15_0_8_set_gfx_soft_freq_limited_range(struct smu_context *smu,
+						       uint32_t min,
+						       uint32_t max)
+{
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+					      max & 0xffff, NULL);
+	if (ret)
+		return ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinGfxclk,
+					      min & 0xffff, NULL);
+
+	return ret;
+}
+
+static int smu_v15_0_8_set_performance_level(struct smu_context *smu,
+					     enum amd_dpm_forced_level level)
+{
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_15_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *uclk_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+	int ret;
+
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
+		/* Determinism not supported on SMU v15.0.8 */
+		ret = -EOPNOTSUPP;
+		break;
+
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+		/* Restore GFXCLK to default range */
+		if ((SMU_DPM_TABLE_MIN(gfx_table) !=
+		     pstate_table->gfxclk_pstate.curr.min) ||
+		    (SMU_DPM_TABLE_MAX(gfx_table) !=
+		     pstate_table->gfxclk_pstate.curr.max)) {
+			ret = smu_v15_0_8_set_gfx_soft_freq_limited_range(
+				smu, SMU_DPM_TABLE_MIN(gfx_table),
+				SMU_DPM_TABLE_MAX(gfx_table));
+			if (ret)
+				goto out;
+
+			pstate_table->gfxclk_pstate.curr.min =
+				SMU_DPM_TABLE_MIN(gfx_table);
+			pstate_table->gfxclk_pstate.curr.max =
+				SMU_DPM_TABLE_MAX(gfx_table);
+		}
+
+		/* Restore UCLK to default max */
+		if (SMU_DPM_TABLE_MAX(uclk_table) !=
+		    pstate_table->uclk_pstate.curr.max) {
+			/* Min UCLK is not expected to be changed */
+			ret = smu_v15_0_set_soft_freq_limited_range(smu,
+								    SMU_UCLK, 0,
+								    SMU_DPM_TABLE_MAX(uclk_table),
+								    false);
+			if (ret)
+				goto out;
+
+			pstate_table->uclk_pstate.curr.max =
+				SMU_DPM_TABLE_MAX(uclk_table);
+		}
+
+		if (ret)
+			goto out;
+
+		smu_cmn_reset_custom_level(smu);
+
+		break;
+	case AMD_DPM_FORCED_LEVEL_MANUAL:
+		ret = 0;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+out:
+	return ret;
+}
+
+static int smu_v15_0_8_set_soft_freq_limited_range(struct smu_context *smu,
+						   enum smu_clk_type clk_type,
+						   uint32_t min, uint32_t max,
+						   bool automatic)
+{
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+	int ret = 0;
+
+	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK &&
+	    clk_type != SMU_UCLK)
+		return -EINVAL;
+
+	if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
+		return -EINVAL;
+
+	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
+		if (min >= max) {
+			dev_err(smu->adev->dev,
+				"Minimum clk should be less than the maximum allowed clock\n");
+			return -EINVAL;
+		}
+
+		if (clk_type == SMU_GFXCLK || clk_type == SMU_SCLK) {
+			if ((min == pstate_table->gfxclk_pstate.curr.min) &&
+			    (max == pstate_table->gfxclk_pstate.curr.max))
+				return 0;
+
+			ret = smu_v15_0_8_set_gfx_soft_freq_limited_range(smu,
+									  min, max);
+			if (!ret) {
+				pstate_table->gfxclk_pstate.curr.min = min;
+				pstate_table->gfxclk_pstate.curr.max = max;
+			}
+		}
+
+		if (clk_type == SMU_UCLK) {
+			if (max == pstate_table->uclk_pstate.curr.max)
+				return 0;
+
+			ret = smu_v15_0_set_soft_freq_limited_range(smu,
+								    SMU_UCLK,
+								    0, max,
+								    false);
+			if (!ret)
+				pstate_table->uclk_pstate.curr.max = max;
+		}
+
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.init_allowed_features = smu_v15_0_8_init_allowed_features,
 	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
@@ -1420,7 +1558,8 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.set_power_limit = smu_v15_0_set_power_limit,
 	.emit_clk_levels = smu_v15_0_8_emit_clk_levels,
 	.populate_umd_state_clk = smu_v15_0_8_populate_umd_state_clk,
-	};
+	.set_performance_level = smu_v15_0_8_set_performance_level,
+};
 
 static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
 				     const struct cmn2asic_msg_mapping *message_map)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a644579903f40..09b486ed3f1ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1305,6 +1305,16 @@ void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
 	}
 }
 
+void smu_cmn_reset_custom_level(struct smu_context *smu)
+{
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+
+	pstate_table->gfxclk_pstate.custom.min = 0;
+	pstate_table->gfxclk_pstate.custom.max = 0;
+	pstate_table->uclk_pstate.custom.min = 0;
+	pstate_table->uclk_pstate.custom.max = 0;
+}
+
 static inline bool smu_cmn_freqs_match(uint32_t freq1, uint32_t freq2)
 {
 	/* Frequencies within 25 MHz are considered equal */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index e4d282d8bcae3..b76e86df5da78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -204,6 +204,7 @@ int smu_cmn_print_pcie_levels(struct smu_context *smu,
 			       struct smu_pcie_table *pcie_table,
 			       uint32_t cur_gen, uint32_t cur_lane,
 			       char *buf, int *offset);
+void smu_cmn_reset_custom_level(struct smu_context *smu);
 
 int smu_cmn_dpm_pcie_gen_idx(int gen);
 int smu_cmn_dpm_pcie_width_idx(int width);
-- 
2.53.0

