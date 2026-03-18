Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B658107BCF2
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 10:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05D110E7B5;
	Wed, 18 Mar 2026 10:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vg0Q2gMx";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A567110E7B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:39:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wu0elhuHw4djW7Ut7iPemYHSlClfZZ5DuWqk1Q5aRn2x8A2K3VninoegHb1knzYBEy96o09wTn/0Tf7oP/OngSGP/Rv2mne/Gh7OEgHq28R0ZksZYWGgUmC60GSZciSEM8rgul3jqGiZsyjSNbUOEA2ug5UEhUC3OxXuAdYhuDEjupW86CWscNHVP7dbOi9nSzL2+fIURalVoJhz4v4AqSHeNPFEId2G6osSAnUJmhVJG/Al44cU0csEJ4N+Asv1kbnDAL6h2UmlLX3mvO/nRJIJNSCJXfuHdVtbjMnqyfWOkzZstieX9twvJyF6ZDxRn+Cs5TSq+ylU56qLc6gnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LHWgApZZpZOCrlxYtg93WwrpULxKX16Feiqmc//kH0=;
 b=wlLakozcMAimM/e32IMUBT1vKT30skcQukuNMU2wHNitxkbWKAcda4Oqhm0Ab8rR+A5juPAe7Tvg5ss6Ms3TwSX0lmHI2wB7vRHFwoKnmXqWt1+uLjJXtuCUljbeRgu9QPv6NFmnhWThSm8NSRUfzR1OVHaC/Zmg4FudlGIudzFIrRzXq+26uCcZceM7rOE4hjXxYw8M5YThMARWl9dd5G9ArC9vBrehJYqSSk4L6P4DydINoK/6xN2zWF0x0ZBQ1XRpK2PjzSmvjOu1isDTG2p1D4OD+6McEfbS3eDqDc+8G9P3Ooc0GbgIliuy4HD0JKeRwS1NcK9JxWMCCnHJiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LHWgApZZpZOCrlxYtg93WwrpULxKX16Feiqmc//kH0=;
 b=vg0Q2gMxZrNd+hPoGH9FyQnBAQ0Ou0o4+7eN9/R//vlLGSYSXtL+6Tj6iBBtrqMQ8/qxA4mGWf/GDquITkpg8dHBMLs2moLOLsQvRe0CdnKnaWsojfXBvNVNECAlb0DsPCABNDoSdm6T+F2wyVz/GlxlOGY5O19Fw3Jja8erI5g=
Received: from BL1P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::21)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 10:39:35 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::9b) by BL1P221CA0030.outlook.office365.com
 (2603:10b6:208:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 10:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 10:39:34 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 05:39:32 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v3 4/4] drm/amd/pm: Add custom fclk setting support
Date: Wed, 18 Mar 2026 18:39:06 +0800
Message-ID: <20260318103906.3107670-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260318103906.3107670-1-asad.kamal@amd.com>
References: <20260318103906.3107670-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b536288-c220-45f7-bce0-08de84daa564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FyvgFyrCoxaAPyP7HKYY0fbuVPFWGMr9lQB76jaTNAB8GeHqoO7VviU3qXGZXaEjPk/yjUpZWCWxIRQ2MN4INUI93V6aJNeb0nWWO2e2XJa53GoXwn20cVowElP7Mg7ius3QYhEyCOyGWLo2k5Ik+3f7brWZi1WUldr8c2/zxds++g91VsAXDBhpul0u/CAy7FNg9PqINb13JitAEzw2y6PvkayMizLV4rGm8Zzwr4QCk2f2GWNcbUgHynvasU7ZDtPxn9wM5q0B6zBTdjDi73JNWxBC0e83ByR7sUO+oRsqdu8sy+e61MxHnz+nVMdUOnSEVsv/er2Ysu9p0iHWKYooQ3Z63ApTSDuq4+4bpsjm80kNa3hVrBrYulOjEZncwHAIT0biROGkJbQzqqSrYfX8r9CHClBjlYuaMYlZMPhT4iwOJNCLHywK2hAzeYzfV2aikPCLahnIWybWcQ20g0oHHhzVfrKU0dyKLGHRCYQSRJv+v3KggQfAMXLxiAiHAGNavfkoV0G9QtK7KDjO1HnDqeYQ5DI287ENu4WKc2Dd3Oh2pKIRZQL+VmQ2ymrsoi0QmW0OWaJPgpazpuPOdkodgU3Yxi10ymn6yfPafoNYoZ0rlmuduDbyNT7Rucm/xeQFOoub3Rq+cmPo0pVwfDuMwPJGmKCxzPqf8Yh6XCAnTdwHQcZPIBr81+G8BMAMQUUkDhuqraOAYfhbWNhcvSrOfCIPDXFcAyUUaawJMDZpWNoXHMipJfj+IoAM9kd1mzPg8HddpYy3iDCxeqSamQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YXrAgW1avVp+aiuSxLr8DmhOA7J79z4EPYl3bXny92SuMB0OFA40ipyeYtYZdrJbHMww/cPH75hs9fPUmZVx5YBWhlVZCwyAPnl3Uuh+OPYM5pMxGY0txnCeBqONcSTSG4Mco8EUji6zij9Y9CDvds0wBAN8EXe+2JGRGwR5QqJiP1x1ttH1+EnpsD8vMMiXCBNp3YdmbM8Jh2FHy8cNdwBp/IxeNSkgQhUsjSzjGMjx56jxS1yvtt++iLm2W7VxMqfrL/jY7Gp3NDzVoPG5WGsqafFjzWeUqLg7JYiBwWkONecQG2ItpeUiG6SI5a55noCjOms2FOD1ijs4WvHk5TwcTJzE0GRpmtgzXYAGkoJ4vsuAl/xyfjzk+5Uqfib/B0aY6A3bf+WtvkadMuCG6/rJiK04WWQnNTorqaWBfhFTZ/cT3TmM9bSB9S492YHF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:39:34.5336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b536288-c220-45f7-bce0-08de84daa564
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959
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

Add custom fclk setting support for smu_v13_x_x

v2: Move uclk fix to separate patch, return EOPNOTSUPP in case of dpm
disabled (Lijo)

v3: remove dpm check for filling fclk pstate table (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 82 ++++++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index cf3781aba02a..d8a1c402a624 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2467,4 +2467,6 @@ void smu_v13_0_reset_custom_level(struct smu_context *smu)
 	pstate_table->uclk_pstate.custom.max = 0;
 	pstate_table->gfxclk_pstate.custom.min = 0;
 	pstate_table->gfxclk_pstate.custom.max = 0;
+	pstate_table->fclk_pstate.custom.min = 0;
+	pstate_table->fclk_pstate.custom.max = 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index bcf8921bf1c7..f76665c85bc3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1199,6 +1199,7 @@ static int smu_v13_0_6_populate_umd_state_clk(struct smu_context *smu)
 	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
 	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
 	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *fclk_table = &dpm_context->dpm_tables.fclk_table;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 
 	pstate_table->gfxclk_pstate.min = SMU_DPM_TABLE_MIN(gfx_table);
@@ -1216,6 +1217,12 @@ static int smu_v13_0_6_populate_umd_state_clk(struct smu_context *smu)
 	pstate_table->socclk_pstate.curr.min = SMU_DPM_TABLE_MIN(soc_table);
 	pstate_table->socclk_pstate.curr.max = SMU_DPM_TABLE_MAX(soc_table);
 
+	pstate_table->fclk_pstate.min = SMU_DPM_TABLE_MIN(fclk_table);
+	pstate_table->fclk_pstate.peak = SMU_DPM_TABLE_MAX(fclk_table);
+	pstate_table->fclk_pstate.curr.min = SMU_DPM_TABLE_MIN(fclk_table);
+	pstate_table->fclk_pstate.curr.max = SMU_DPM_TABLE_MAX(fclk_table);
+	pstate_table->fclk_pstate.standard = SMU_DPM_TABLE_MIN(fclk_table);
+
 	if (gfx_table->count > SMU_13_0_6_UMD_PSTATE_GFXCLK_LEVEL &&
 	    mem_table->count > SMU_13_0_6_UMD_PSTATE_MCLK_LEVEL &&
 	    soc_table->count > SMU_13_0_6_UMD_PSTATE_SOCCLK_LEVEL) {
@@ -1401,7 +1408,15 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
 				      pstate_table->uclk_pstate.curr.min,
 				      pstate_table->uclk_pstate.curr.max);
 		break;
+	case SMU_OD_FCLK:
+		if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT))
+			return -EOPNOTSUPP;
 
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_FCLK");
+		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				      pstate_table->fclk_pstate.curr.min,
+				      pstate_table->fclk_pstate.curr.max);
+		break;
 	case SMU_SCLK:
 	case SMU_GFXCLK:
 		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
@@ -2043,7 +2058,7 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 	int ret = 0;
 
 	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK &&
-	    clk_type != SMU_UCLK)
+	    clk_type != SMU_UCLK && clk_type != SMU_FCLK)
 		return -EINVAL;
 
 	if ((smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) &&
@@ -2084,6 +2099,15 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 				pstate_table->uclk_pstate.curr.max = max;
 		}
 
+		if (clk_type == SMU_FCLK) {
+			if (max == pstate_table->fclk_pstate.curr.max)
+				return 0;
+
+			ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_FCLK, 0, max, false);
+			if (!ret)
+				pstate_table->fclk_pstate.curr.max = max;
+		}
+
 		return ret;
 	}
 
@@ -2126,6 +2150,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
 	struct smu_dpm_table *uclk_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *fclk_table = &dpm_context->dpm_tables.fclk_table;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	uint32_t min_clk;
 	uint32_t max_clk;
@@ -2206,6 +2231,40 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			pstate_table->uclk_pstate.custom.max = input[1];
 		}
 		break;
+	case PP_OD_EDIT_FCLK_TABLE:
+		if (size != 2) {
+			dev_err(smu->adev->dev,
+				"Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		if (!smu_cmn_feature_is_enabled(smu,
+						SMU_FEATURE_DPM_FCLK_BIT)) {
+			dev_warn(smu->adev->dev,
+				 "FCLK limits setting not supported!\n");
+			return -EOPNOTSUPP;
+		}
+
+		max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.fclk_table);
+		if (input[0] == 0) {
+			dev_info(smu->adev->dev,
+				 "Setting min FCLK level is not supported\n");
+			return -EOPNOTSUPP;
+		} else if (input[0] == 1) {
+			if (input[1] > max_clk) {
+				dev_warn(smu->adev->dev,
+					 "Maximum FCLK (%ld) MHz specified is greater than the maximum allowed (%d) MHz\n",
+					 input[1], max_clk);
+				pstate_table->fclk_pstate.custom.max =
+					pstate_table->fclk_pstate.curr.max;
+				return -EINVAL;
+			}
+
+			pstate_table->fclk_pstate.custom.max = input[1];
+		} else {
+			return -EINVAL;
+		}
+		break;
 
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		if (size != 0) {
@@ -2235,6 +2294,17 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 				if (ret)
 					return ret;
 			}
+
+			if (SMU_DPM_TABLE_MAX(fclk_table) !=
+			    pstate_table->fclk_pstate.curr.max) {
+				max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.fclk_table);
+				min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.fclk_table);
+				ret = smu_v13_0_6_set_soft_freq_limited_range(smu,
+									      SMU_FCLK, min_clk,
+									      max_clk, false);
+				if (ret)
+					return ret;
+			}
 			smu_v13_0_reset_custom_level(smu);
 		}
 		break;
@@ -2261,6 +2331,16 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			if (ret)
 				return ret;
 
+			if (pstate_table->fclk_pstate.custom.max) {
+				min_clk = pstate_table->fclk_pstate.curr.min;
+				max_clk = pstate_table->fclk_pstate.custom.max;
+				ret = smu_v13_0_6_set_soft_freq_limited_range(smu,
+									      SMU_FCLK, min_clk,
+									      max_clk, false);
+				if (ret)
+					return ret;
+			}
+
 			if (!pstate_table->uclk_pstate.custom.max)
 				return 0;
 
-- 
2.46.0

