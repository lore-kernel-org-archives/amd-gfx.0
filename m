Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7C1D116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B402610E377;
	Mon,  1 Dec 2025 10:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bICq81Qt";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013055.outbound.protection.outlook.com
 [40.93.196.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC24F10E37C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGfx0bkM2gLjj8DWPq15MJ4hdhdI9wGgZhyw+CNa26SB3NHBhoNZtLGPNCRIzuw+pIhtVc58fPUVSTJPk4X/Vs5nFhLYfygwJYyMxBXbpqIy9vfkzNpVp/3gEJfbPd+fPdECSDVvmXgHxKGr697IKKI5NGpBMH/1yL5IOfYgstmO1UzrF9V4D2Hwbe9POgkkTMogM6DR6fgoCoZ8wVz9+QSsf+G5HL8T8pRjtGT5HpnjUx1HfOQQnPNg+o2/tRmcFJpowYOrajY1KL1Bf1qnrmZH8LQIFrAT7TIkwpkxZhfrOVzAdLooxU6LjTdDR/Uf4F0yIS0hb969pTWu5vWaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiTgBiJUVdx9jFbJQtXlsa1gEOphxcvcfG/LqPF+U+Y=;
 b=a9+0BXXEBRg7g2+8JSFP4bmELHOnvYOiegFQ35mEIjFokYqOXLXqpR3txXmDYpvjfnOHHlhWOL0uTXCs5x4OJy8B4b2neGEo7tWZgKBS5eucl/1K9tdFoWEX4rV70nhZQV9dty4Ey1e44sbFh6uE82ssTL+McTh1HZFzYZZ8a29i/umfilkQY0wi3pws+gslFD+n+g/9HPIleGaKSgz1KD2MrOa/lUDvCVi8olQrkPUk5uQmM43EA3kFvcnreLmo+MOa18ObziZzyk9jNM52f+k6lBHQ3oO1HsA+y11OywY1Ag1Z4GjbCe9Wd354KdNLsucLGgtAs0aUMKk7kheW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiTgBiJUVdx9jFbJQtXlsa1gEOphxcvcfG/LqPF+U+Y=;
 b=bICq81QtTLx3+WZMuxMBWVbsR6HbiczdorEmpMFYhqs/ynD53xKDH1TnflNifY2iHuhb7UC8KsvIcHoy/XLSscOl6FCR50VgpL2S4w4MQwYR41cxMsPwUCJCbn67gOmCbBtwR46nlTQDl0ZlZbJWfzi/GszItiSMecnelTyihLc=
Received: from CH0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::35)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:41 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::c6) by CH0P220CA0015.outlook.office365.com
 (2603:10b6:610:ef::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:41 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:39 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 16/17] drm/amd/pm: Use common helper for smuv13.0.7 dpm
Date: Mon, 1 Dec 2025 15:33:29 +0530
Message-ID: <20251201101331.101584-17-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251201101331.101584-1-lijo.lazar@amd.com>
References: <20251201101331.101584-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 85666f4c-4257-4542-7daf-08de30c27119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YEIxqHLx4+kurpT9xwplxB/7Rpqyw3rCeVmxdaBZK1H2iH3R7BBUIFEfl6VP?=
 =?us-ascii?Q?O1EI1RE+2VrbixOVwYJMciigr+MApm9KxtIRi3qUlND3eNtiTnmXTZq0LkBs?=
 =?us-ascii?Q?DxoPURabup477Ut6LiZ0FWYwc0tulxTGaeLbXSLoyf4X/bqVwGXaVYm7cIKg?=
 =?us-ascii?Q?3TJGKvmKggxdHO9WA+Dd44B7H0Kgo9oW0lq3nmUjZ66+NiYVF+Vuh2Dano7p?=
 =?us-ascii?Q?StDvMZHyRATCzWnWfJ+Qsdd5+CP6ylLuGTOqLR8997hlJsOol6tqgn1sXHWB?=
 =?us-ascii?Q?3hU7KEThok6gxR9xSsJaJiLmMfS89iI8oJUbn3KCKYv8OEF7y5eFVWnRusMN?=
 =?us-ascii?Q?F2gS4jexS0K+/e+0cZ2P4RtjpiUIjmELXi4IXBXxT2ZoGSIbUGWnP0tB6aP0?=
 =?us-ascii?Q?FYxV+0o3HYllpdY8L3Om38xRzt3B6sMgZqarMBlisheen0yygL0Rtx8Kk1Sd?=
 =?us-ascii?Q?9DPxo53IWB7iRG1pgkObFpxD+qbIy2IeYSSVCMv7d8FmNz6YFLBTSqcvFG+z?=
 =?us-ascii?Q?UYk7uISkleyDu58kniF2O3dg3ElRX4cbiGauyRqpWfzYjyaeULtFQ75hZYrW?=
 =?us-ascii?Q?3/+HTOpHekeZXLFoqc6wHYxlK5L4NNtVB7QxgQf7YnCxPTtB7OSQ8Wf2+w/S?=
 =?us-ascii?Q?p5CgEsNRI0J2NbaCefw2uyabKzwy7nvGEfMNgxSAfdO4Y00pV1ZhqbpsNLSB?=
 =?us-ascii?Q?M6HJtB5yk1R5s6TIHIqs7ciMo94A98SvnX39GBeOkgGiB6I4a0y4blYAFBxy?=
 =?us-ascii?Q?wI9HLTQrLm5SfMqXsq4HFLHpEQ5YVZV5CJHd/jZ2UEYKCmC7bGp4qh+Y4Asr?=
 =?us-ascii?Q?Rz2ug835OZgI8tciMch6VsTr/NDjTTYFf3pBM71uXiyavFEeGXqcGMLUun4M?=
 =?us-ascii?Q?OToIshCE9BZqCqtdHuKpnlfHo8FH0Kd7uaFwiSXNwKmWL66McE3MSZBq2ZjJ?=
 =?us-ascii?Q?R3LG0ddtOBjKlD4q2MQvKNDE6lz6TZj9bWYmGFCGFqQauzsuvpBS9lDc8Nl5?=
 =?us-ascii?Q?DcSz4gPXgAX/umVu9ZKKghQerZoeADqKXIJahok3EPdTdVQc90YiWhuC/S5w?=
 =?us-ascii?Q?DKDf4yml7ndn6Y16KliZfxhzySoAzhNgBQv+7lSwa87Vk9rWD2DMlPpt5SfO?=
 =?us-ascii?Q?A0baZ8qrGwoRwiDAtewPTKwvaJOWGi+LQlSh8Jrlz0+CKeERx+B5SWZqBkzC?=
 =?us-ascii?Q?XSYCC2OibyGQd4ir9xphXxq+xCu/qoQ1ZfD0AIIRABRiGEipgKRG1HNVsWIN?=
 =?us-ascii?Q?nkGVhp6t4SjjX6ou9rl2628X36WXpTS5LOQMTcYWiUV/NIJGPRaEbeF9CK2o?=
 =?us-ascii?Q?IxygIe6ARl5QJqtjuvUDeYxpEburqtJwltq3kerWOFguGsZ+cNVVOJYCQBNe?=
 =?us-ascii?Q?HMIhDSaORfxqD/HfiEE+WzBiQud+HzRYy1xfPN3gctMEj2nYWzzV1uTrfZcF?=
 =?us-ascii?Q?VrSPg2jYbwEUEoE3TKbxxvtMkZfZk8V3JrBuwA/aSshAdXjFJKH9mMnwBMu+?=
 =?us-ascii?Q?4yDZvfhy4QxMuuAlJY8tRRm36J9M7P0NZEQ4Z26UaEcbbt1IDqLYv/twir67?=
 =?us-ascii?Q?hFZCayXZIKYZQvHe3m8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:41.1935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85666f4c-4257-4542-7daf-08de30c27119
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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

Use helper function to print smuv13.0.7 dpm tables to sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 98 +++----------------
 1 file changed, 15 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index ff9ad5bdf138..1465e0c80175 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1174,9 +1174,8 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
 	int i, curr_freq, size = *offset, start_offset = *offset;
-	struct smu_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table = NULL;
 	struct smu_pcie_table *pcie_table;
-	uint32_t pcie_speed, pcie_width;
 	uint32_t gen_speed, lane_width;
 	int32_t min_value, max_value;
 	int ret = 0;
@@ -1210,61 +1209,6 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 	case SMU_DCEFCLK:
 		single_dpm_table = &(dpm_context->dpm_tables.dcef_table);
 		break;
-	default:
-		break;
-	}
-
-	switch (clk_type) {
-	case SMU_SCLK:
-	case SMU_MCLK:
-	case SMU_SOCCLK:
-	case SMU_FCLK:
-	case SMU_VCLK:
-	case SMU_VCLK1:
-	case SMU_DCLK:
-	case SMU_DCLK1:
-	case SMU_DCEFCLK:
-		ret = smu_v13_0_7_get_current_clk_freq_by_table(smu, clk_type, &curr_freq);
-		if (ret) {
-			dev_err(smu->adev->dev, "Failed to get current clock freq!");
-			return ret;
-		}
-
-		if (single_dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED) {
-			/*
-			 * For fine grained dpms, there are only two dpm levels:
-			 *   - level 0 -> min clock freq
-			 *   - level 1 -> max clock freq
-			 * And the current clock frequency can be any value between them.
-			 * So, if the current clock frequency is not at level 0 or level 1,
-			 * we will fake it as three dpm levels:
-			 *   - level 0 -> min clock freq
-			 *   - level 1 -> current actual clock freq
-			 *   - level 2 -> max clock freq
-			 */
-			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
-			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
-				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
-						single_dpm_table->dpm_levels[0].value);
-				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
-						curr_freq);
-				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
-						single_dpm_table->dpm_levels[1].value);
-			} else {
-				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
-						single_dpm_table->dpm_levels[0].value,
-						single_dpm_table->dpm_levels[0].value == curr_freq ? "*" : "");
-				size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
-						single_dpm_table->dpm_levels[1].value,
-						single_dpm_table->dpm_levels[1].value == curr_freq ? "*" : "");
-			}
-		} else {
-			for (i = 0; i < single_dpm_table->count; i++)
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
-						i, single_dpm_table->dpm_levels[i].value,
-						single_dpm_table->dpm_levels[i].value == curr_freq ? "*" : "");
-		}
-		break;
 	case SMU_PCIE:
 		ret = smu_v13_0_7_get_smu_metrics_data(smu,
 						       METRICS_PCIE_RATE,
@@ -1279,32 +1223,8 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 			return ret;
 
 		pcie_table = &(dpm_context->dpm_tables.pcie_table);
-		for (i = 0; i < pcie_table->lclk_levels; i++) {
-			pcie_speed = DECODE_GEN_SPEED(pcie_table->pcie_gen[i]);
-			pcie_width =
-				DECODE_LANE_WIDTH(pcie_table->pcie_lane[i]);
-			size += sysfs_emit_at(
-				buf, size, "%d: %s %s %dMhz %s\n", i,
-				(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
-				(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
-				(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
-				(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," :
-								 "",
-				(pcie_table->pcie_lane[i] == 1) ? "x1" :
-				(pcie_table->pcie_lane[i] == 2) ? "x2" :
-				(pcie_table->pcie_lane[i] == 3) ? "x4" :
-				(pcie_table->pcie_lane[i] == 4) ? "x8" :
-				(pcie_table->pcie_lane[i] == 5) ? "x12" :
-				(pcie_table->pcie_lane[i] == 6) ? "x16" :
-								  "",
-				pcie_table->lclk_freq[i],
-				(gen_speed == pcie_speed &&
-				 lane_width == pcie_width) ?
-					"*" :
-					"");
-		}
-		break;
-
+		return smu_cmn_print_pcie_levels(smu, pcie_table, gen_speed,
+						 lane_width, buf, offset);
 	case SMU_OD_SCLK:
 		if (!smu_v13_0_7_is_od_feature_supported(smu,
 							 PP_OD_FEATURE_GFXCLK_BIT))
@@ -1522,6 +1442,18 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 		break;
 	}
 
+	if (single_dpm_table) {
+		ret = smu_v13_0_7_get_current_clk_freq_by_table(smu, clk_type,
+								&curr_freq);
+		if (ret) {
+			dev_err(smu->adev->dev,
+				"Failed to get current clock freq!");
+			return ret;
+		}
+		return smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						    curr_freq, buf, offset);
+	}
+
 	*offset += size - start_offset;
 
 	return 0;
-- 
2.49.0

