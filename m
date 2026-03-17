Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F22FEDA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC1D10E649;
	Tue, 17 Mar 2026 20:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pyUS8lSC";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44BCE10E5E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r084aRjRC1/dWZsGpCNVviEqS3pPycrY1xe/0kdYq1NmBza+F57cqrY4xmY7BElyik6whmcMF7D+C0QZIMy+q/lCndisYFBN0Dlf6wuUM+I4FkoWOy0SgsOfE6zSo2IWAJnOugrImdsuW5VIsdg8r1pn7Zje0yK44i0wJSAPJyQT47ojhqNJbTjaDMNKpoHAEPNreOAB4DTWRY9bIL+X3qE6NXDsCzSm2GIYFGfL5uuGFiohI5KI5vV73jXy5vBef/yIY8/PV8C6BPED3CZy0VMY1dgaf6/XRMeR770MTnVgImV5NExGwJ+fBpgJf+YA5mLfKHQ9hYiWZdtCyXZPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh/lZMliQYdRZflKwoOIPOMbN6FeTfw3r5JyiR33i8I=;
 b=rcXTseV9YIEMVZ0B+Y/XKhjkL9m7arlVelRa2V5Tmco1lHgZoMgnGmHNR/nMK9iC45Pa9zJbu0iTx2ReOKyrrYKKvJsPsqEntQny8Z9laIhpZtmXrFroqLp86gMLcKIRwTyTUqpqygMvGLAs6qlDzC/mFxqJqTIm6Ja3eZzRIximwwG7nFSr7YYJM/iw8kT5AE2oXwaYdfmn1zSCnt961zFf3kHIyOM6hQHtjgN1JlqL3W+uM4ySSnAaG1CCGK73uU5XTE9NNF89SEOY5AHGVur7ByW+ZL5S2ZIY/MioZXu2TXNQ2zO/Xh/bWnhLQ4DSInyVG2u8qkdvD2Ld2O4L+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh/lZMliQYdRZflKwoOIPOMbN6FeTfw3r5JyiR33i8I=;
 b=pyUS8lSCl8COL/QCChfJSqD7OiS9qx1nrfCGRU+y3HOpNY6CAz9yvvfW8QzMPXbd6lPnF+MkwIBwr4K8zIQcFcwKD4dclXWdaNIPhFPqa+2N3XIkMdNhHrL6hntn5QOESqfw8kB7IK0LQnV5VIGNBQstkpoo5uyTh90FiH2eGOk=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by CH1PR12MB9622.namprd12.prod.outlook.com (2603:10b6:610:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.12; Tue, 17 Mar
 2026 20:13:15 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::6a) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/25] drm/amd/pm: Add od_edit_dpm_table support
Date: Tue, 17 Mar 2026 16:12:33 -0400
Message-ID: <20260317201242.3808136-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|CH1PR12MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b68faf6-1fb8-49d3-bb81-08de84619f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vE5IdRI/163wtJ6PAooYy46VM6+EILknIfQf7KJln/V9JhzgOx3EDNwy0paj34ZGK7C4pqvbOlEB01dyKEHWge/0wvoNqOsDrqI5PXxGwWsWKQK734tuv7Rv+qP2w9cpjUMmwsqOscC436cBZG3NtjBHo7gOWHr5DPIFB0Gz637wfnXxg/41/r5RADDrJJp3dHhX+74eypThF1CIJnOEnk0kwtnjV7sPySKn63kqDP0i1+kXV1X7yIS+8zXlFihqZW8sBCPXXXiu/4F8JpgzqKEAwifHE/9jgTcZ8HMs4bCYFh9l6xyEGWcmQcjERKRDSi4J19lTbNCczgIto50Agbd+GfxDVewuzWljgC0qxvBFxdYme70EgH+LoaZXkUv5bb4wZ3GnaV97HUtb/52+C6/irFuwp0P0rxHuO9QTqE4ofn3F81MMAJ673pUu1wu6GTVEdruN/QrmykcF/bF5LkqPRfZkNCHle2s+nxonL4D+cOsNmT6exswgKt2QkMJwimGvMRdapHUA5KIFrFM0Pv4ISM5X4E+xjxrXinxFOBEeJ6g040f715t3Ze0hXlW4eZ/vx4/1SYHd7c/fpaD+vJ31dBOC7d9kCdfNfP7Ixzdb96yNPlaHAF/F2ha5XXMRRaoHDDiKahuy4iTs297G5sAVw/L6yEmUxczJ11YMDhoQ7qiS7x0iQSAfNI+QSU+8NXCKPPfJrhSqt9Wg+coRe0XZB9JYnMtTl7scURw1I9MCxrpdelRXhr8DnbwsMJ1uzVeZw2amsxGJIRwia0FwWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vUlk4DSwyiPmtAZm/VxO6lE3jWcevxWVwCnyBg4OoV6NpNvxPYc7LVhamWaY8TGkQvsR91NBNONAZfTVx+XbKmvSufWDWpeelca7LdAIzhPQRU4DqJC0dLLNtpzNP+jgsdhbvmi47RMCDFg9HT7pmWcopU3jGvdXBAAOnIuvRqbF4G18Cs341Hxy3a3n5vy+YFH0DGc/ZNpXzCw8wwl1X3FLGWi2hIwqMtO1iDUlFfX2ceYSSE3fPED14KYVEgDJJPRh6d7Py07Ca9IyOxNY/CKwdgkvzgdVMpY/nm20CFgKfcLPmdz8PyBq35jsHMIJOId7Y4/qLAv0kQhRxfft4ZYVJ3hgEqhHmr+CuVKWDRtEBYMOoNViDL1jCWd3DuEV8DvrUGk6289ew/LXaBSWCAD5JmU4TVJjDrVh4WQKGPza4VkL8dOImYc7N6y6A5gf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:14.9729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b68faf6-1fb8-49d3-bb81-08de84619f3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9622
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

Add od_edit_dpm_table support for smu_v15_0_8

v2: Skip Gl2clk/Fclk (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 155 ++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 435798388b012..04f16fd0633b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1529,6 +1529,160 @@ static int smu_v15_0_8_set_soft_freq_limited_range(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v15_0_8_od_edit_dpm_table(struct smu_context *smu,
+					 enum PP_OD_DPM_TABLE_COMMAND type,
+					 long input[], uint32_t size)
+{
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+	struct smu_15_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	uint32_t min_clk, max_clk;
+	int ret;
+
+	/* Only allowed in manual mode */
+	if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
+		return -EINVAL;
+
+	switch (type) {
+	case PP_OD_EDIT_SCLK_VDDC_TABLE:
+		if (size != 2) {
+			dev_err(smu->adev->dev,
+				"Input parameter number not correct\n");
+			return -EINVAL;
+		}
+		min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.gfx_table);
+		max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.gfx_table);
+		if (input[0] == 0) {
+			if (input[1] < min_clk) {
+				dev_warn(smu->adev->dev,
+					 "Minimum GFX clk (%ld) MHz specified is less than the minimum allowed (%d) MHz\n",
+					input[1], min_clk);
+				pstate_table->gfxclk_pstate.custom.min =
+					pstate_table->gfxclk_pstate.curr.min;
+				return -EINVAL;
+			}
+
+			pstate_table->gfxclk_pstate.custom.min = input[1];
+		} else if (input[0] == 1) {
+			if (input[1] > max_clk) {
+				dev_warn(smu->adev->dev,
+					 "Maximum GFX clk (%ld) MHz specified is greater than the maximum allowed (%d) MHz\n",
+					input[1], max_clk);
+				pstate_table->gfxclk_pstate.custom.max =
+					pstate_table->gfxclk_pstate.curr.max;
+				return -EINVAL;
+			}
+
+			pstate_table->gfxclk_pstate.custom.max = input[1];
+		} else {
+			return -EINVAL;
+		}
+		break;
+	case PP_OD_EDIT_MCLK_VDDC_TABLE:
+		if (size != 2) {
+			dev_err(smu->adev->dev,
+				"Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+			dev_warn(smu->adev->dev,
+				 "UCLK_LIMITS setting not supported!\n");
+			return -EOPNOTSUPP;
+		}
+		max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.uclk_table);
+		if (input[0] == 0) {
+			dev_info(smu->adev->dev,
+				 "Setting min UCLK level is not supported");
+			return -EINVAL;
+		} else if (input[0] == 1) {
+			if (input[1] > max_clk) {
+				dev_warn(smu->adev->dev,
+					 "Maximum UCLK (%ld) MHz specified is greater than the maximum allowed (%d) MHz\n",
+					input[1], max_clk);
+				pstate_table->uclk_pstate.custom.max =
+					pstate_table->uclk_pstate.curr.max;
+
+				return -EINVAL;
+			}
+
+			pstate_table->uclk_pstate.custom.max = input[1];
+		}
+		break;
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev,
+				"Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		/* Use the default frequencies for manual mode */
+		min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.gfx_table);
+		max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.gfx_table);
+
+		ret = smu_v15_0_8_set_soft_freq_limited_range(smu,
+							      SMU_GFXCLK,
+							      min_clk, max_clk,
+							      false);
+		if (ret)
+			return ret;
+
+		min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.uclk_table);
+		max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.uclk_table);
+		ret = smu_v15_0_8_set_soft_freq_limited_range(smu,
+							      SMU_UCLK,
+							      min_clk, max_clk,
+							      false);
+		if (ret)
+			return ret;
+
+		smu_cmn_reset_custom_level(smu);
+		break;
+	case PP_OD_COMMIT_DPM_TABLE:
+		if (size != 0) {
+			dev_err(smu->adev->dev,
+				"Input parameter number not correct\n");
+			return -EINVAL;
+		}
+
+		if (!pstate_table->gfxclk_pstate.custom.min)
+			pstate_table->gfxclk_pstate.custom.min =
+				pstate_table->gfxclk_pstate.curr.min;
+
+		if (!pstate_table->gfxclk_pstate.custom.max)
+			pstate_table->gfxclk_pstate.custom.max =
+				pstate_table->gfxclk_pstate.curr.max;
+
+		min_clk = pstate_table->gfxclk_pstate.custom.min;
+		max_clk = pstate_table->gfxclk_pstate.custom.max;
+
+		ret = smu_v15_0_8_set_soft_freq_limited_range(smu,
+							      SMU_GFXCLK,
+							      min_clk, max_clk,
+							      false);
+		if (ret)
+			return ret;
+
+		/* Commit UCLK custom range (only max supported) */
+		if (pstate_table->uclk_pstate.custom.max) {
+			min_clk = pstate_table->uclk_pstate.curr.min;
+			max_clk = pstate_table->uclk_pstate.custom.max;
+			ret = smu_v15_0_8_set_soft_freq_limited_range(smu,
+								      SMU_UCLK,
+								      min_clk, max_clk,
+								      false);
+			if (ret)
+				return ret;
+		}
+
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.init_allowed_features = smu_v15_0_8_init_allowed_features,
 	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
@@ -1559,6 +1713,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.emit_clk_levels = smu_v15_0_8_emit_clk_levels,
 	.populate_umd_state_clk = smu_v15_0_8_populate_umd_state_clk,
 	.set_performance_level = smu_v15_0_8_set_performance_level,
+	.od_edit_dpm_table = smu_v15_0_8_od_edit_dpm_table,
 };
 
 static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
-- 
2.53.0

