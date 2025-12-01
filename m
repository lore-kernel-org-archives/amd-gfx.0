Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90561D116F9
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D00810E378;
	Mon,  1 Dec 2025 10:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L6CocEct";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013004.outbound.protection.outlook.com
 [40.93.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322BD10E378
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fo/0HRw9HqJ1ES4/72SonMf8wXfi41ZjzV6OlPo3lPZZSlmdp1EsCzTbGS3aHfYryvRFAvqSiQLGTDcvzsg8CU/eH6yeoSlRykjWnrv+ntUHAJVdEFCt40eDjILXqyJ+DmxQbaMFbA7Qxbj0wRLDc5Zb2GE8OWm/XA1YCJySSzpFWlJQkY0CyhNx4MyniNev4P118sQMvFr0aL+9Mp4eaoXTMh3i/EIWXnqoqlMviE6GDI4HZ15mh8UW32zLFyRuihbygzlR/NHRmZk2RkDhzoZaQ7iQsX7rg4AsTe/6vquEpBUQauWwqpvn+2wShI/I1Vq0ba2JijsEwlacvo3VCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbbO7t7w+k4K+uRIlfBYQ1QDXNOAd28KT33k9LRQLBs=;
 b=an4xf2Yip0k15TIhXiVMyOQaMfyCWz4Vf79mJhQVtkMh4e7W7lmPzxok8V2F2H9bhHxoh8OQJq21HsWVqt2qx4Qtspd1/p4MiI8IjYzGD/ySRPbjrvVg3adOEOWCejx1hVi+V9ir760QSb3x0x40L5PNIrMqUnwjWoFJZzCA/8//+pU/pK9lBzBvsdXPl0BQcjihMIcH0A7K7eQAq/bUBzbf71MZJQt3I9+Xf8M1AwhXp1guimYwn8jZaOHWpt2owO/uhlaVca74enza754bbSIwiuNh8o9tQ7fu9BO1J6JEAFUrReMLVPJcoamX56cpXZ4har7ERQz8nRXGAfKcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbbO7t7w+k4K+uRIlfBYQ1QDXNOAd28KT33k9LRQLBs=;
 b=L6CocEctlg19iihKyQ9A89xTF/Z5sPmdkrtR+DTiOhva4clClThSrwNRzDWPwOY5KxIlGQObqxWoqcyqIXdJxSAcLGZZmWvuAIveIQRVw8l5t86Uz7F6O7ZVNoRjpbIZWqbD+oAr+MsLNzQI3W/2w8IiWPM/PVNOLdL0V+xX2Uw=
Received: from CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::30)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:39 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::e7) by CH0P223CA0013.outlook.office365.com
 (2603:10b6:610:116::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:39 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:37 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 15/17] drm/amd/pm: Use common helper for smuv13.0.6 dpm
Date: Mon, 1 Dec 2025 15:33:28 +0530
Message-ID: <20251201101331.101584-16-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c33fda-25cb-4788-73ba-08de30c27013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DDjopGzZ6oH2hVE1nZdQtphS/gJx6gjArzvpooUJvhjzfYMm5P4CRcdjn+tm?=
 =?us-ascii?Q?uenTt9xfqxU4MVC22TcxlOz/qOo8ck7dmL5tL5tpMTAEfoA8Qfo9t97Iyyzn?=
 =?us-ascii?Q?vFcy58X79VONqhQGPp8IaY1xOrgjXoUfujiMirW878L7P3AxwqayNk1F53Ay?=
 =?us-ascii?Q?r4Vn1DhVJwPgeL8mLrarDh7qRYOj9vs3IKoRAheuhxcbHN0KnFRSgv3Sf/s8?=
 =?us-ascii?Q?I0wa6JdcBoZcJF2sZASiKDcLfCT/lrxwemw8cZY4K/BLsCseW78cGjspaixz?=
 =?us-ascii?Q?LDcOUWwhNWe0E+J9t2xsK+8yIEdALtPKEGkw15yphk/yM9u5gZtbnvTDWfwE?=
 =?us-ascii?Q?dwC8x8nPGxboz0OFxSGoBq8J57+72BKJhj4JgW0JCGUsbVSaZFiHfXlE5Snj?=
 =?us-ascii?Q?M/s9NAQSnaxZGeGcKunXsN8TETQSv29yALy6T96j925bnwWKP3KYr7NguvIk?=
 =?us-ascii?Q?tKzGRwZkZ1pNdxeC7ijYGGPmmHz5hgA2x+82/cuHeIipwU5PV+FLC2qXrWHK?=
 =?us-ascii?Q?TgL63fvf3jAJREgaB37B2cMAhszTR+ReBImCFsESu1lB1nIhJ/Z/0+O8NNLQ?=
 =?us-ascii?Q?WeKFcERbzzdLvWtLSFb9Tdnb1GN6cHeVxrMRQ2u/SMaVVymZYwT5Y4/yLqql?=
 =?us-ascii?Q?zKtB4wckoIokKUYRwlhDTCe0HtjRe8+YVZWMyKY+MlIzI+40+wiQwrK/1BbI?=
 =?us-ascii?Q?QMLuhHwsDS0yhAEjH6U1JryTyNYlhrAVc125oeMbxS7n6lMquNXjZOABb5sQ?=
 =?us-ascii?Q?/sHoup07Z4nddkWyTpb3M1YV0RbtaqdP1jUdqBMeXqxf/oM6MQGeYrq1Eu3x?=
 =?us-ascii?Q?XGNjcuHNbj5a/rDVteeU8qyk6bXGyZJa81IHVYk9BXsPHKQuujGHg576TAWu?=
 =?us-ascii?Q?koD/WcirTMCQeFe2semqgiabL0DglAnITkZ7Gb9blJBkZJpaqj6lmFxdEY3v?=
 =?us-ascii?Q?6+GiFeE+/wj6/6KhDya/GjakrpXIGBfNRJCv4EfJfS9arxKNkoK5aulZGWXB?=
 =?us-ascii?Q?z7AR+kMs6OdfQkOjZhT33bBu5vJooGL4A9o8V0kXm/LX9O3fz8S/NGJg6Q5S?=
 =?us-ascii?Q?WKp/1gtBPR8Xo3aSQqTygjFKdGl0/wE61TI4crqAlNs6oY3Bfw0rsqYUUTQR?=
 =?us-ascii?Q?LVggCa0xS9RVuopJbgb5zU4VcBplM6JDe+8LD7ZrAhkPWqILJrCUVjtfH7ut?=
 =?us-ascii?Q?0M92Sif5LA1NY1QEfdUiDFCZB5rXAoc9rQhFSNKs1YSF3Bikdy/nH+Ka9AoS?=
 =?us-ascii?Q?2ZbwNvo7bOnAqzOy31WzybCvfmr2qaA/sQYF6ZWb0612YX2Yov/nrP5Dd9Rk?=
 =?us-ascii?Q?4BqRntcG3P/LkqNmFvI+k3HVQaLEFyHeGPIvr8fmFR469p7R24yPdS2I7tCq?=
 =?us-ascii?Q?F9BhGLUXVrLszgi6FVdKWVEuoZb56GnJ8+gm1QWKKmwnlhwWxR42MYw+l5eo?=
 =?us-ascii?Q?/oHLijsVHKtrX6S8lpL7A1PzBTzG9Vsfc4xD6NrdyD0FZKYCz1lSGcXJs9k1?=
 =?us-ascii?Q?NF5Zq+ndcnpjiHnOezK9JcwauDPdtvNambeabDVWN84MmjFF5WZqTGQiLrFf?=
 =?us-ascii?Q?G9V4RdoMDc2505PJbe8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:39.4759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c33fda-25cb-4788-73ba-08de30c27013
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
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

Use helper function to print navi10 dpm tables to sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 222 ++----------------
 1 file changed, 22 insertions(+), 200 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index adf973ea2809..57ce7a38bba8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -83,9 +83,6 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 	 FEATURE_MASK(FEATURE_DPM_LCLK) | FEATURE_MASK(FEATURE_DPM_XGMI) |     \
 	 FEATURE_MASK(FEATURE_DPM_VCN))
 
-/* possible frequency drift (1Mhz) */
-#define EPSILON 1
-
 #define smnPCIE_ESM_CTRL 0x93D0
 #define smnPCIE_LC_LINK_WIDTH_CNTL 0x1a340288
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
@@ -95,9 +92,7 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 #define smnPCIE_LC_SPEED_CNTL                   0x1a340290
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xE0
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
-#define LINK_SPEED_MAX				4
-#define SMU_13_0_6_DSCLK_THRESHOLD 140
-
+#define LINK_SPEED_MAX 4
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
 	[AMDGPU_MCA_IP_##_ip] = { .hwid = _hwid, .mcatype = _type, }
 
@@ -1238,32 +1233,6 @@ static int smu_v13_0_6_populate_umd_state_clk(struct smu_context *smu)
 	return 0;
 }
 
-static int
-smu_v13_0_6_get_clk_table(struct smu_context *smu,
-			  struct pp_clock_levels_with_latency *clocks,
-			  struct smu_dpm_table *dpm_table)
-{
-	int i, count;
-
-	count = (dpm_table->count > MAX_NUM_CLOCKS) ? MAX_NUM_CLOCKS :
-						      dpm_table->count;
-	clocks->num_levels = count;
-
-	for (i = 0; i < count; i++) {
-		clocks->data[i].clocks_in_khz =
-			dpm_table->dpm_levels[i].value * 1000;
-		clocks->data[i].latency_in_us = 0;
-	}
-
-	return 0;
-}
-
-static int smu_v13_0_6_freqs_in_same_level(int32_t frequency1,
-					   int32_t frequency2)
-{
-	return (abs(frequency1 - frequency2) <= EPSILON);
-}
-
 static uint32_t smu_v13_0_6_get_throttler_status(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
@@ -1368,9 +1337,11 @@ static int smu_v13_0_6_get_current_clk_freq_by_table(struct smu_context *smu,
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
+	case SMU_SCLK:
 		member_type = METRICS_CURR_GFXCLK;
 		break;
 	case SMU_UCLK:
+	case SMU_MCLK:
 		member_type = METRICS_CURR_UCLK;
 		break;
 	case SMU_SOCCLK:
@@ -1392,57 +1363,6 @@ static int smu_v13_0_6_get_current_clk_freq_by_table(struct smu_context *smu,
 	return smu_v13_0_6_get_smu_metrics_data(smu, member_type, value);
 }
 
-static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf, int size,
-				  struct smu_dpm_table *single_dpm_table,
-				  uint32_t curr_clk, const char *clk_name)
-{
-	struct pp_clock_levels_with_latency clocks;
-	int i, ret, level = -1;
-	uint32_t clk1, clk2;
-
-	ret = smu_v13_0_6_get_clk_table(smu, &clocks, single_dpm_table);
-	if (ret) {
-		dev_err(smu->adev->dev, "Attempt to get %s clk levels failed!",
-			clk_name);
-		return ret;
-	}
-
-	if (!clocks.num_levels)
-		return -EINVAL;
-
-	if (curr_clk < SMU_13_0_6_DSCLK_THRESHOLD) {
-		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", curr_clk);
-		for (i = 0; i < clocks.num_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %uMhz\n", i,
-					      clocks.data[i].clocks_in_khz /
-						      1000);
-
-	} else {
-		if ((clocks.num_levels == 1) ||
-		    (curr_clk < (clocks.data[0].clocks_in_khz / 1000)))
-			level = 0;
-		for (i = 0; i < clocks.num_levels; i++) {
-			clk1 = clocks.data[i].clocks_in_khz / 1000;
-
-			if (i < (clocks.num_levels - 1))
-				clk2 = clocks.data[i + 1].clocks_in_khz / 1000;
-
-			if (curr_clk == clk1) {
-				level = i;
-			} else if (curr_clk >= clk1 && curr_clk < clk2) {
-				level = (curr_clk - clk1) <= (clk2 - curr_clk) ?
-						i :
-						i + 1;
-			}
-
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
-					      clk1, (level == i) ? "*" : "");
-		}
-	}
-
-	return size;
-}
-
 static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
 				       enum smu_clk_type type, char *buf,
 				       int *offset)
@@ -1450,10 +1370,9 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
 	int now, size = *offset, start_offset = *offset;
 	int ret = 0;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
-	struct smu_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table = NULL;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = NULL;
-	uint32_t min_clk, max_clk;
 
 	if (amdgpu_ras_intr_triggered()) {
 		sysfs_emit_at(buf, size, "unavailable\n");
@@ -1469,46 +1388,6 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
 				      pstate_table->gfxclk_pstate.curr.min,
 				      pstate_table->gfxclk_pstate.curr.max);
 		break;
-	case SMU_SCLK:
-		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_GFXCLK,
-								&now);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get current gfx clk Failed!");
-			return ret;
-		}
-
-		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
-		min_clk = SMU_DPM_TABLE_MIN(single_dpm_table);
-		max_clk = SMU_DPM_TABLE_MAX(single_dpm_table);
-
-		if (now < SMU_13_0_6_DSCLK_THRESHOLD) {
-			size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
-					      now);
-			size += sysfs_emit_at(buf, size, "0: %uMhz\n",
-					      min_clk);
-			size += sysfs_emit_at(buf, size, "1: %uMhz\n",
-					      max_clk);
-
-		} else if (!smu_v13_0_6_freqs_in_same_level(now, min_clk) &&
-		    !smu_v13_0_6_freqs_in_same_level(now, max_clk)) {
-			size += sysfs_emit_at(buf, size, "0: %uMhz\n",
-					      min_clk);
-			size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
-					      now);
-			size += sysfs_emit_at(buf, size, "2: %uMhz\n",
-					      max_clk);
-		} else {
-			size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
-					      min_clk,
-					      smu_v13_0_6_freqs_in_same_level(now, min_clk) ? "*" : "");
-			size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
-					      max_clk,
-					      smu_v13_0_6_freqs_in_same_level(now, max_clk) ? "*" : "");
-		}
-
-		break;
-
 	case SMU_OD_MCLK:
 		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SET_UCLK_MAX)))
 			return 0;
@@ -1518,100 +1397,43 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
 				      pstate_table->uclk_pstate.curr.min,
 				      pstate_table->uclk_pstate.curr.max);
 		break;
-	case SMU_MCLK:
-		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_UCLK,
-								&now);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get current mclk Failed!");
-			return ret;
-		}
 
+	case SMU_SCLK:
+	case SMU_GFXCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
+		break;
+	case SMU_MCLK:
+	case SMU_UCLK:
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
-
-		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					     now, "mclk");
-		if (ret < 0)
-			return ret;
-
-		size = ret;
 		break;
 	case SMU_SOCCLK:
-		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_SOCCLK,
-								&now);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get current socclk Failed!");
-			return ret;
-		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
-
-		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					     now, "socclk");
-		if (ret < 0)
-			return ret;
-
-		size = ret;
 		break;
 	case SMU_FCLK:
-		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_FCLK,
-								&now);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get current fclk Failed!");
-			return ret;
-		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
-
-		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					     now, "fclk");
-		if (ret < 0)
-			return ret;
-
-		size = ret;
 		break;
 	case SMU_VCLK:
-		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_VCLK,
-								&now);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get current vclk Failed!");
-			return ret;
-		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
-
-		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					     now, "vclk");
-		if (ret < 0)
-			return ret;
-
-		size = ret;
 		break;
 	case SMU_DCLK:
-		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_DCLK,
-							       &now);
-		if (ret) {
-			dev_err(smu->adev->dev,
-				"Attempt to get current dclk Failed!");
-			return ret;
-		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
-
-		ret = smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
-					     now, "dclk");
-		if (ret < 0)
-			return ret;
-
-		size = ret;
 		break;
 	default:
 		break;
 	}
 
+	if (single_dpm_table) {
+		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, type,
+								&now);
+		if (ret) {
+			dev_err(smu->adev->dev,
+				"Attempt to get current clk Failed!");
+			return ret;
+		}
+		return smu_cmn_print_dpm_clk_levels(smu, single_dpm_table, now,
+						    buf, offset);
+	}
+
 	*offset += size - start_offset;
 
 	return 0;
-- 
2.49.0

