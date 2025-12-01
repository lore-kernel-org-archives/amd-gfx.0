Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4B4D116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFEC810E36B;
	Mon,  1 Dec 2025 10:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nSu+ZKBl";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620D510E359
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOtltuAu+3PROMuZ+r3MF1FIST9JNdKGXW1B0JZd57hyEvX5Ll9BxshOpkGVqg51wjTpV+9jTTb0AwT20SYpJDbk8Vc3QT84kFMkzO/1fJejk6nxIpi85cbQg3A5SxDxx2nO3Zj4NzKz+QHhjIvrWll7XXVwHRAlP/Qol5iP9fgTALZ871osWNeKDo9Qx36dTxy7i8YGNI9Z5aNrE4kQEnFdsQkR8Fpru7fK9Pl2SDg0spt+E0/1Wn6W6uHd5o1hEr3x1+tQm8eHUfJbCuVydql/2Mm6Vdk8dNquS42vupwgJpN3TlpYFVYWCHzDIiKvHTHAbrOxmLTarSPWrohhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHnJu1vuC9+amfIjbjx+xGhCPpxLp4SkESMQWeQNTOo=;
 b=scjmRQO0zbcFfbNWELiQnDnvqMopUVT7a7TQSgrKfmZXs2c9PmKhxFTUn4LDu3NMWQ4NaphQNGZ9FSUdKB4S5fXJOuxINQa1dOXRr0v/8B9W8uiTXTNAEAzAcu0veOzv2TncyS8qbwfylOo54+pJ00d90PMIYN0+c371TwTogAeJKsij1ms2m8jJm2QZnFXBgo3iK/nKObT2BmzjdUq8MDcYhEMYX0jNz/0MjdGP9Gjb7E5d/9OoFB1qkpcKO07bnB4J4x1znVBSU68UOhtni+2eLyGS+fr//tV5V/0mGiwliNdw9kkt3HplktRw8zWep2Ug4r3sn/V7oT4bgsWh3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHnJu1vuC9+amfIjbjx+xGhCPpxLp4SkESMQWeQNTOo=;
 b=nSu+ZKBlJOOO+zZG9tsCjvc8+Ap9NYSYiHvcskMLda+w3vJZKPkvYKb37Xr4NrLWLXmfjejg4+YB3a/1zTx9MJaHXtpFQ24MDroA9Q9Ur6z6tzqoBD76SbPBrbGW8+Z2v5A7MbNWq+xoThPD2O7wStgj9z9aPzWs4RzrEyhmLDg=
Received: from CH0PR03CA0441.namprd03.prod.outlook.com (2603:10b6:610:10e::34)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1eb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:31 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::1c) by CH0PR03CA0441.outlook.office365.com
 (2603:10b6:610:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:29 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 10/17] drm/amd/pm: Use common helper for arcturus dpm
Date: Mon, 1 Dec 2025 15:33:23 +0530
Message-ID: <20251201101331.101584-11-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c94131-c44b-4318-b4c0-08de30c26af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cGOd7nnYLTyYfHBWXJkjflHnQHUyNVDwDVH2UZaPPiJE0qYY4M4qqeSFy+UQ?=
 =?us-ascii?Q?jzaUxCUH4FoZXolok1zjNnYKPeC49Z5C48k3QnG/NL3Q/4hrQbGGmwYzcHJ0?=
 =?us-ascii?Q?dPA9fg7H/ZouJEck5L/fNqduqUvY7n6/U6v+Y9d/wRIqdZX3TGrbilr0kR28?=
 =?us-ascii?Q?PdLqwIe7Cc0X4zpw2Kd3UQ/LsUATaNqga6T2LWl7689QpQJXpQMPFk2Se4MH?=
 =?us-ascii?Q?IuwmnGjHN8LUpd4O7Fc5bebn1gFfAMKnuV0VJ/EwSfS3s3WEKFCkOsSYh4Xz?=
 =?us-ascii?Q?leBjikElQ80QtGJdm7dtap1ehrevMiKY8Qs7WClcuiUy0E8gjseRNLixng3l?=
 =?us-ascii?Q?HQmD8qytyr1NDNoQ+M+X1oKp1JniP+y55oNjKyj1jVfgU5fFppI38TvO1HW0?=
 =?us-ascii?Q?2LQj095PJkSRP2T5Sj+Xq+MtCPJ44kVuXu35LmNyIGiL9bY/sX1HXxUoLv7e?=
 =?us-ascii?Q?UA4UXwaKEeBWCX9Ik+ZMolba0nBJft3aMqSzVNyqW5xU2/36um7P1dW7SLkz?=
 =?us-ascii?Q?RlSE0tr/GeFzJukoJHStGGs7dgT883zX/Qdgc+47Xn9ylg1pzyETpTZLgzhB?=
 =?us-ascii?Q?5YifK21viSWAcmdBw27r8LdNEzslMCR8uIjPrGCX17cesoX/tbF5dyLzBFBF?=
 =?us-ascii?Q?7f0ag48a9jS1Kz7euIwvj/k6VtvJ6ziu+jqC8Qmpml3QVJ2caSeQDsxXc6tk?=
 =?us-ascii?Q?mI16uQjbAFuUIeNvxSA8ghpE4jYqV1VA9cR2BbvZn6ldOhAVdV7yPxcBbURC?=
 =?us-ascii?Q?0Y1WjZfrooHL0bIdHPghI6kN7FG4Bkoyc29loj9MCwwKBarHKwxpWggkzbyg?=
 =?us-ascii?Q?Iz2rIMS41TvLQQmwXsWlVj4cqk7GT/aq+0IzcwwSk7vnydBzFT9/Al8u49wJ?=
 =?us-ascii?Q?YNYxtzp/xT81Rm4sA9LWNWPxmMRq1hrl5ZTk7D+x8/r519ctDevZB9VXq3Jm?=
 =?us-ascii?Q?vus7ppklJUcwo2zA5jN2TSUWsAhe0wzrsTzvkVL26XChSX7AC21+UtbYTCZl?=
 =?us-ascii?Q?MXZBtaP3KQbP9iZI0tQNrKf7UJXHB+e1MTD9YLq7S94PpWnPtFR9qanhcoL1?=
 =?us-ascii?Q?MjVGOqbgs4z5sWXLBhWIQz3QDrS/MpZmS1kCkANgAwd4LbeGNO50GEUVEixX?=
 =?us-ascii?Q?ZVg4cZII1oDIEgPJCwEEEI4f/pEX6LoiwMnUFmIn6EHBPdLOBPA9hyvFHpP5?=
 =?us-ascii?Q?3VAszcKlZXD+xba/CqyCbN9BHMDdmqF8J0fUEk2Zt9mu+NPrwYh3i6URL5Ne?=
 =?us-ascii?Q?9JgjbkS2DPgKCILK3ep1M7Y+y76yYirFA3A5c+NIA3PT50sWlCZtOrhJQETQ?=
 =?us-ascii?Q?xMihsi49WiCCsMXARLhj4MEGvYizCNkpdbd7G44hQDk0uNKl+rar9nGZtega?=
 =?us-ascii?Q?p/Sdj25S8uOLQVmyu1k/FWl3U+JC/+WWc13PPrbScH5c7/YY7cK4/rtk5Yh9?=
 =?us-ascii?Q?3RAgiHcN2OcnnEnUNwlwVa+wywNRUUsrS6kFqXW5BuUQxfuCS6vMTQOPFpBc?=
 =?us-ascii?Q?KcYJ8T75lgPksU58EjozLeSPoG5e8105w3WEfiyrZbjpY3zYZYVkq66DmBrn?=
 =?us-ascii?Q?GTlO0wXAKrsN1Bl2DQk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:30.8935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c94131-c44b-4318-b4c0-08de30c26af5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
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

Use the helper function to print DPM clock levels to sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 133 +++++-------------
 1 file changed, 39 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 67d217f27264..0667a3f9282a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -74,9 +74,6 @@
 	FEATURE_DPM_FCLK_MASK | \
 	FEATURE_DPM_XGMI_MASK)
 
-/* possible frequency drift (1Mhz) */
-#define EPSILON				1
-
 #define smnPCIE_ESM_CTRL			0x111003D0
 
 #define mmCG_FDO_CTRL0_ARCT			0x8B
@@ -604,29 +601,6 @@ static int arcturus_populate_umd_state_clk(struct smu_context *smu)
 	return 0;
 }
 
-static void arcturus_get_clk_table(struct smu_context *smu,
-				   struct pp_clock_levels_with_latency *clocks,
-				   struct smu_dpm_table *dpm_table)
-{
-	uint32_t i;
-
-	clocks->num_levels = min_t(uint32_t,
-				   dpm_table->count,
-				   (uint32_t)PP_MAX_CLOCK_LEVELS);
-
-	for (i = 0; i < clocks->num_levels; i++) {
-		clocks->data[i].clocks_in_khz =
-			dpm_table->dpm_levels[i].value * 1000;
-		clocks->data[i].latency_in_us = 0;
-	}
-}
-
-static int arcturus_freqs_in_same_level(int32_t frequency1,
-					int32_t frequency2)
-{
-	return (abs(frequency1 - frequency2) <= EPSILON);
-}
-
 static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 					 MetricsMember_t member,
 					 uint32_t *value)
@@ -793,15 +767,12 @@ static int arcturus_get_current_clk_freq_by_table(struct smu_context *smu,
 static int arcturus_emit_clk_levels(struct smu_context *smu,
 				    enum smu_clk_type type, char *buf, int *offset)
 {
-	int ret = 0;
-	struct pp_clock_levels_with_latency clocks;
+	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_dpm_table *single_dpm_table;
-	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
-	struct smu_11_0_dpm_context *dpm_context = NULL;
+	struct smu_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
-	uint32_t i, cur_value = 0;
-	bool freq_match;
-	unsigned int clock_mhz;
+	uint32_t cur_value = 0;
+	int ret = 0;
 	static const char attempt_string[] = "Attempt to get current";
 
 	if (amdgpu_ras_intr_triggered()) {
@@ -809,8 +780,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		return -EBUSY;
 	}
 
-	dpm_context = smu_dpm->dpm_context;
-
 	switch (type) {
 	case SMU_SCLK:
 		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &cur_value);
@@ -818,10 +787,11 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 			dev_err(smu->adev->dev, "%s gfx clk Failed!", attempt_string);
 			return ret;
 		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
-		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-
+		ret = smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						   cur_value, buf, offset);
+		if (ret < 0)
+			return ret;
 		break;
 
 	case SMU_MCLK:
@@ -830,10 +800,11 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 			dev_err(smu->adev->dev, "%s mclk Failed!", attempt_string);
 			return ret;
 		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
-		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-
+		ret = smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						   cur_value, buf, offset);
+		if (ret < 0)
+			return ret;
 		break;
 
 	case SMU_SOCCLK:
@@ -842,10 +813,11 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 			dev_err(smu->adev->dev, "%s socclk Failed!", attempt_string);
 			return ret;
 		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
-		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-
+		ret = smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						   cur_value, buf, offset);
+		if (ret < 0)
+			return ret;
 		break;
 
 	case SMU_FCLK:
@@ -854,10 +826,11 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 			dev_err(smu->adev->dev, "%s fclk Failed!", attempt_string);
 			return ret;
 		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
-		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-
+		ret = smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						   cur_value, buf, offset);
+		if (ret < 0)
+			return ret;
 		break;
 
 	case SMU_VCLK:
@@ -866,10 +839,11 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 			dev_err(smu->adev->dev, "%s vclk Failed!", attempt_string);
 			return ret;
 		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
-		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-
+		ret = smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						   cur_value, buf, offset);
+		if (ret < 0)
+			return ret;
 		break;
 
 	case SMU_DCLK:
@@ -878,56 +852,27 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 			dev_err(smu->adev->dev, "%s dclk Failed!", attempt_string);
 			return ret;
 		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
-		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
-
+		ret = smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						   cur_value, buf, offset);
+		if (ret < 0)
+			return ret;
 		break;
 
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	switch (type) {
-	case SMU_SCLK:
-	case SMU_MCLK:
-	case SMU_SOCCLK:
-	case SMU_FCLK:
-	case SMU_VCLK:
-	case SMU_DCLK:
-		/*
-		 * For DPM disabled case, there will be only one clock level.
-		 * And it's safe to assume that is always the current clock.
-		 */
-		for (i = 0; i < clocks.num_levels; i++) {
-			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
-			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (clocks.num_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, clock_mhz,
-				freq_match ? "*" : "");
-		}
-		break;
-
-	case SMU_PCIE:
-		*offset += sysfs_emit_at(buf, *offset, "0: %s %s %dMhz *\n",
-				(gen_speed == 0) ? "2.5GT/s," :
-				(gen_speed == 1) ? "5.0GT/s," :
-				(gen_speed == 2) ? "8.0GT/s," :
-				(gen_speed == 3) ? "16.0GT/s," : "",
-				(lane_width == 1) ? "x1" :
-				(lane_width == 2) ? "x2" :
-				(lane_width == 3) ? "x4" :
-				(lane_width == 4) ? "x8" :
-				(lane_width == 5) ? "x12" :
-				(lane_width == 6) ? "x16" : "",
-				smu->smu_table.boot_values.lclk / 100);
+		pcie_table = &(dpm_context->dpm_tables.pcie_table);
+		/* Populate with current state - arcturus only has boot level lclk */
+		pcie_table->lclk_levels = 1;
+		pcie_table->pcie_gen[0] = gen_speed;
+		pcie_table->pcie_lane[0] = lane_width;
+		pcie_table->lclk_freq[0] =
+			smu->smu_table.boot_values.lclk / 100;
+		ret = smu_cmn_print_pcie_levels(smu, pcie_table, gen_speed,
+						lane_width, buf, offset);
+		if (ret < 0)
+			return ret;
 		break;
 
 	default:
-- 
2.49.0

