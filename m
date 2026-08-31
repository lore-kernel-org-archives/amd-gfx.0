Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31168C61DF0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 04:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C8710E5CE;
	Mon, 31 Aug 2026 04:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uv5hwWy8";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD6210E25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 04:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3Hc1FaDcBvw0+sQBzADpZU3R0xqxbYRNnFXpXJNaYBqJSA/Pk16iN0mh+xzVDgFX0mEgAGk31pPWR3pnwaoDBPTG3f/HdyeweLSJWtwhVnFiT6CiIlUDYihLV0jd/txS2jDKfpyG/MWsEaNUB7MlzYZWmg7KvB8jqGHL6hmujk9sSFfBRo3Z+l+nUzoZkNzFCB5+yQ5X9RdzrlKe4dNYp918KBWZo4OTtPtVvEyOi3hsBcST1G7W3WlCrbWc5nkfuap9IAFvo25aMT7CN/ZiCYCmMVCHQ8xpJJ3/hfgTzuruKVOmO2fMY461nzsxqYFIIJu9/IbzvLpCY8j5CX3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIp39XgaRWKz7YuMEbQxPjsZhvT2QlgqhAF11ogCJFw=;
 b=UxLgoIZcIp7Vh9c9YsmOa2/4rL346oWqiI4YlCz2nGThCm/oDRk0Mr0HWiNfDKmYS2px4qc/09u8uPVO1g8xSeQiNR26PoB1s76qqXO2OivpqLp4oWjRI0Ea4WfWCbDdeMMZHfNCdjCAq8byurlGT6cXgMphAqCvv5CJIddLP0GQM1PsClqwb8FeqlDJoCwrZTQz41iyEmO0/3838BtMx0ySux4Pi8YI09JRiZtWOWn+pNGZEheD0OeieWx/3sXGWH3UsqRmXlIEFgiOE9GfT1cveXakRDYDHhDUmvKg+pY3t/b9NWDjtCT+9wNmp9O8GRaIK60qZwmYki6t0CyURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIp39XgaRWKz7YuMEbQxPjsZhvT2QlgqhAF11ogCJFw=;
 b=uv5hwWy8ocIGPd1Cczo6xtYM+t2KbTpkdmhURYy9Ijg4qFpTC+wHV0Wx7EvKH88Y+1pCZE7gF5AxfwV1td/NDglWmTMVYlUR4cFbzJHHWYSPwv+ci+19goQrkXuONX1rbeaeRwNC7TO2j5BhXBbx9JfBtKbx9kqv/9H8OsZ8ym8=
Received: from BN9PR03CA0943.namprd03.prod.outlook.com (2603:10b6:408:108::18)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 04:35:28 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::4d) by BN9PR03CA0943.outlook.office365.com
 (2603:10b6:408:108::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Mon,
 31 Aug 2026 04:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 04:35:28 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 23:35:26 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 4/7] drm/amd/pm: stage od reset for smu 13.0.6
Date: Mon, 31 Aug 2026 12:35:04 +0800
Message-ID: <20260831043507.523599-5-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831043507.523599-1-kevin.wang@amd.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: a2893c04-8012-4b74-0134-08df071948b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BZMRkc9qHsyB5B2YTxDIs0q8zSDCP9oHjH8nSgCQSpXKasXfwHTUa6+aGQ14Hc1BXwMySvI1KQ6XqazQQ/HcZ5mDPruwFqeO4yXpMVf22WH8hhwwIgaOGoWTTGvYsbrNqUPkCJKw/Orfb/knf9mFAcsoVfpNnqeRxLBfgKbXSfRRDYl5yeSZs1oPan8Z1UXBrwyxGHnFncEPAZsGDWjrhGX0PIPtSVCoLnJDd3o07ZBwBakPdyTODo+UnALi+Qg41q3SHrs6atVm7o6K3vZPsQJrQYHIh/ytF4IXBMxeDT8DW+UFVpDsKbvn4QwPgPhXJj9ZM+9oBckDAG+tY5W5FSwi9BNy2ErXQfrMl3Ze5P1+7VUe17LMsEuok7JkBVpdW9G3Kpmodw9GPYic64vPkJlduvURRtLBzNkyUFqX4TyDG0sjKnlHIBQc7GEar6+aPt4QVKptMnToqBeEel3V6OFgzvv9CIP/aWj27IvwS3890Jz/5JQ80E+I+VNM7lyS9uylCPlHBe4e5DM2DB+CTRvQianMe2E7/iWoCdIlGVhWcBlitUca3wUs2N1w4M7iNeCDGOUz20vCH3yQoF+3zl24Fkr6OnHcrJEz3YfY9chUQuGJGfaXLU7a+MKbAc3sMDMmKNqnIHOSiWWruEHrZW19vDJx5Q227PUQAp+LQ2cg6UaonDFP3aU2FOeav5YzmqR1YeXyeCK2tzCemCXIyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dfL2IhYpGD3P1RiuDzmC9ttv9MmUnpqc1RLFLfkbkbnc82G7xeadiErSRAa1bD+/QacB0EUaIB01aa1x7JkqPCzX02B2kXwvT+DuXlpsAMI2zcWjWQB39qczuPl0JOVVoObzoRnrtRmdmJ8uJmYpNvpCVms+VXR5+BN7D3vCTATusaEG5gc06QabOSnBTjOVMeFDAicI6zMPlA9/K1SCsPAIeVXw66xQjIKlwSleL7UNZr0T7iZjnvrqmtRgNLpgAsEpgUmW6ehv5dQeQcnjR7XJysc0jRoqyWLGOte9cGpP2EOsi3KRBLizorkWqz0wy2Rje7dqfxAh4BL0mbgtbi0xZtaUYENhQjlzusBfqEKeKh3jdPiuer+MGnZZVQpkDRqMqk/SfbhE6L+/2TeIQWKatLVP2C2d8XEcS7obUY4+GV74ryxHuPXsRa7xlEm3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 04:35:28.5092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2893c04-8012-4b74-0134-08df071948b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314
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

SMU 13.0.6 applies default GFXCLK, UCLK, and FCLK ranges directly from
PP_OD_RESTORE_DEFAULT_TABLE. This bypasses the staged OD transaction.

Stage defaults through one helper and let c submit them. Gate UCLK and
FCLK staging and commit on their DPM features, and require the UCLK
firmware capability before staging or submitting its limit.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 85 ++++++++++---------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4dec3a93cb3d..169e38db629d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2130,14 +2130,45 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 	return ret;
 }
 
+static void smu_v13_0_6_stage_default_dpm_limits(struct smu_context *smu)
+{
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+
+	pstate_table->gfxclk_pstate.custom.min =
+		SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.gfx_table);
+	pstate_table->gfxclk_pstate.custom.max =
+		SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.gfx_table);
+
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(SET_UCLK_MAX))) {
+		pstate_table->uclk_pstate.custom.min =
+			SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.uclk_table);
+		pstate_table->uclk_pstate.custom.max =
+			SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.uclk_table);
+	} else {
+		pstate_table->uclk_pstate.custom.min = 0;
+		pstate_table->uclk_pstate.custom.max = 0;
+	}
+
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
+		pstate_table->fclk_pstate.custom.min =
+			SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.fclk_table);
+		pstate_table->fclk_pstate.custom.max =
+			SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.fclk_table);
+	} else {
+		pstate_table->fclk_pstate.custom.min = 0;
+		pstate_table->fclk_pstate.custom.max = 0;
+	}
+}
+
 static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 					  enum PP_OD_DPM_TABLE_COMMAND type,
 					  long input[], uint32_t size)
 {
 	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	struct smu_dpm_table *uclk_table = &dpm_context->dpm_tables.uclk_table;
-	struct smu_dpm_table *fclk_table = &dpm_context->dpm_tables.fclk_table;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	uint32_t min_clk;
 	uint32_t max_clk;
@@ -2258,42 +2289,8 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			dev_err(smu->adev->dev,
 				"Input parameter number not correct\n");
 			return -EINVAL;
-		} else {
-			/* Use the default frequencies for manual and determinism mode */
-			min_clk = SMU_DPM_TABLE_MIN(
-				&dpm_context->dpm_tables.gfx_table);
-			max_clk = SMU_DPM_TABLE_MAX(
-				&dpm_context->dpm_tables.gfx_table);
-
-			ret = smu_v13_0_6_set_soft_freq_limited_range(
-				smu, SMU_GFXCLK, min_clk, max_clk, false);
-
-			if (ret)
-				return ret;
-
-			if (SMU_DPM_TABLE_MAX(uclk_table) !=
-			    pstate_table->uclk_pstate.curr.max) {
-				min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.uclk_table);
-				max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.uclk_table);
-				ret = smu_v13_0_6_set_soft_freq_limited_range(smu,
-									      SMU_UCLK, min_clk,
-									      max_clk, false);
-				if (ret)
-					return ret;
-			}
-
-			if (SMU_DPM_TABLE_MAX(fclk_table) !=
-			    pstate_table->fclk_pstate.curr.max) {
-				max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.fclk_table);
-				min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.fclk_table);
-				ret = smu_v13_0_6_set_soft_freq_limited_range(smu,
-									      SMU_FCLK, min_clk,
-									      max_clk, false);
-				if (ret)
-					return ret;
-			}
-			smu_v13_0_reset_custom_level(smu);
 		}
+		smu_v13_0_6_stage_default_dpm_limits(smu);
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
 		if (size != 0) {
@@ -2318,8 +2315,10 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			if (ret)
 				return ret;
 
-			if (pstate_table->fclk_pstate.custom.max) {
-				min_clk = pstate_table->fclk_pstate.curr.min;
+			if (pstate_table->fclk_pstate.custom.max &&
+			    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
+				min_clk = pstate_table->fclk_pstate.custom.min ?:
+					pstate_table->fclk_pstate.curr.min;
 				max_clk = pstate_table->fclk_pstate.custom.max;
 				ret = smu_v13_0_6_set_soft_freq_limited_range(smu,
 									      SMU_FCLK, min_clk,
@@ -2328,10 +2327,14 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 					return ret;
 			}
 
-			if (!pstate_table->uclk_pstate.custom.max)
+			if (!pstate_table->uclk_pstate.custom.max ||
+			    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) ||
+			    !smu_v13_0_6_cap_supported(smu,
+							     SMU_CAP(SET_UCLK_MAX)))
 				return 0;
 
-			min_clk = pstate_table->uclk_pstate.curr.min;
+			min_clk = pstate_table->uclk_pstate.custom.min ?:
+				pstate_table->uclk_pstate.curr.min;
 			max_clk = pstate_table->uclk_pstate.custom.max;
 			return smu_v13_0_6_set_soft_freq_limited_range(
 				smu, SMU_UCLK, min_clk, max_clk, false);
-- 
2.55.0

