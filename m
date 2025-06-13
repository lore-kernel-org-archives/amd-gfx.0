Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E26C71136
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 14:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1675310E9F0;
	Fri, 13 Jun 2025 14:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AT4on3uz";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B5F10EA03
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 14:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0vjptoNnbuxUxgRlxdGk8ZfEY+jmCYfLCanxre0WbXHSL/JMLDW8OZbliiSc78805NC+pX6TdXXdYh2R2R6MlO6LNQ0CRcKVmCNc+1qAzm/wcPVCunp4PJ8jqSrJqVrHLXRu5qiKckl4x3idWVZWX0SIUCQzXHRBKIXTMtV875hGZuiPNFDqQ0hTAt7zslQ39Wlk7gona5oXP3kg3TwpnzTXBdl9o0iBLyxptkVyzBhgJweSklNqzSelCY5lEf4C80mk+grqNZ6mJhjl7gKI43/ej9tRe/jdyzj4d0SpZMHbqIOY1x4B33Uzh/USEZuJkog9Bl3aIYPuGJ1TpBARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unvitnYnhxCGAUEGMDQeNdkXpkYFKJfcr0Fbz0wg/h0=;
 b=dr8PPD7c4Xxm5lwTq6LobmfKFE7EtMcaJPv7FQ0dHJVlpWKsxG95qIfE3GX9N4+iO8KeoJlD94QjiRss6AhP9ZvLh5T75wt1mvw9w9lifh5nJZsBfTsvqMb3WabtUux+dhVjhLmeHj28m2DOJJxOSxVXM4betCTdizb+aYPUMgGW0VZ0kjfNzMgoBK9z0TNfxXfl1RqPljZesfdXjmD21glQx4qBidO6V8YuL65e7kPD/iUjXwH2wjemlm5Y67DYxQHZ2WBIvyBhgyPBy3XODUCzSawLCzktCwyLOATb4PCXyp39xn6LvWTVFB834vpgBBrdV8zYv2AdQz4Lc5ZvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unvitnYnhxCGAUEGMDQeNdkXpkYFKJfcr0Fbz0wg/h0=;
 b=AT4on3uzT6pOwTAmAqne08bYh0kcI+STZxbX3sgJPb2E9mXFe6fWJ7xA2irY/l0ktUneg25Dats70Z4SQLLu7vWudTc59Re18z7OyRnS5m9g9eooDK3TNuZbd61xi/UCeqa9PbC+RoNYn4WsEzYx1asNhzyZkQs+FFXiCgdNI7o=
Received: from BYAPR07CA0044.namprd07.prod.outlook.com (2603:10b6:a03:60::21)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 14:42:16 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::38) by BYAPR07CA0044.outlook.office365.com
 (2603:10b6:a03:60::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Fri,
 13 Jun 2025 14:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 14:42:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 09:42:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 09:42:10 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 13 Jun 2025 09:42:09 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: set pcie default dpm table when updating pcie
 dpm parameters
Date: Fri, 13 Jun 2025 22:42:03 +0800
Message-ID: <20250613144203.441129-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613144203.441129-1-kenneth.feng@amd.com>
References: <20250613144203.441129-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a23490-e7d5-48f5-cae8-08ddaa887d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B/GiC2X4YAAa1Jwg228yufdu2yVSGZEf6k3dQoJi5wTMcSGF3zoWLPdZUdp4?=
 =?us-ascii?Q?NzYoypqkyhI4Qz4c9+GXTBfCbGdsMLfQI6So5BIv9eDsy1hyJM47zU5RSn00?=
 =?us-ascii?Q?UQdmaHL1gIAzYpBsalB4CSG9bLRY10jo2TWzQ7yTQQImoSxi9LY6Qhy2gqu0?=
 =?us-ascii?Q?VQWDw2HCBrQmhU0m+ZZ3w9iubYT0UtmYw4NCfzmL1fC9funaeex6wKiyfLgu?=
 =?us-ascii?Q?t9NGAHoibu22lK9ItJn6AjmSUuPzAOSlIQ4yXBw31jLfhsXsL5bJeHlr9hhA?=
 =?us-ascii?Q?cZ0cNC4yhib5nx/qS2t27/DD73fmSfFkszXEmYs3j7Day23E8JSPjV+7Sot6?=
 =?us-ascii?Q?0JlWjQwoQ7UoS8I3MM7Ions+ZmJXwt4fa87wwznGtJGs+0418dq+kKx0kwh5?=
 =?us-ascii?Q?K1I68nsDaPKGN3lJHWu/obDeVC4zZDxhMTEi89L7JOXqpSPe2IkBgxMY9MHB?=
 =?us-ascii?Q?Q6CLGcT0dFWTA+K2lIADG8tmxmALpNaSfLgMgBRvlnuzITntyFtQQTcJBQns?=
 =?us-ascii?Q?gtWMkA1MJOTSam3AVVuuIBZ7JPf8SIPYPEqDevmXKOmEw7n/mMxk+nL4qtPx?=
 =?us-ascii?Q?eUQ6P00fd9FK8Yd2ZfS8Yp3VXB83gudJAlGcLKQ2oV35BWdCX5KzhUYWM0Et?=
 =?us-ascii?Q?QC2EGAEmoOVW4EpUGaD2fQTdpAXRvocnJT/qba4R6Gp7MTn+VY/jyd4G9hdj?=
 =?us-ascii?Q?NN1lVuQu77Okb0INvZ9VNqIICNZ0UKa5Ozhd77xkPaJA0mMHLVzDHZf48pWp?=
 =?us-ascii?Q?rXu4+nkFqPiXGZLw3/DjzSke2MaBu0XJUk1hDA+tNu7vIqmVeGo3HfB5/JbT?=
 =?us-ascii?Q?WHORSZWjCsRA/tu8zvjM3ZwjWInLfro3vz+xfV5mWUm5ebJV6CDRvsnTD6ve?=
 =?us-ascii?Q?jR3G/p7YPfYUit/UcmjCQsUfPH862iBXXao+Sm/x29AjAJsPMcAWxQK+ZF7c?=
 =?us-ascii?Q?ipYPU65jWS1XBajf7c19z5Kl/Bq4tC555tV1t7K7qcVyl7aKHCfNJxGmdEZv?=
 =?us-ascii?Q?qQdm2az+gruTvBZ9tZnzqfchKIjA4OUTdh3GBs2k2YJY14fuvrv4uXzs6obe?=
 =?us-ascii?Q?SUKYPafyzatwF+mGC2fZPABjXAYdLZ7pMef/ZR9ejlEtAoTbt5Zo3KKjZsg9?=
 =?us-ascii?Q?05yFsazuTht33ipCVe4INVu8Hf2Uv4+mULFdmYjomYkFuvChBmWVWjdvGTaz?=
 =?us-ascii?Q?sfryuPom4zl3lb4tMV3liHS38VaLL5RI+Kmp9PROkQ/aUhBLg2vIix4GLeBM?=
 =?us-ascii?Q?9AmeC9TkM/d8lJjV3QzoJNDCnPV2sbpkO2VL3MvbeFpzMRXwiPDHgPfR3WEf?=
 =?us-ascii?Q?MVgDMXbSobUCoMt1X2Xx+IMOTLdnz5pOcQLVLeXrm/Fpe599KOwZEmzM419C?=
 =?us-ascii?Q?i1vaOmy9xrJCKKY1N3Ak41sF9eNokZFLsDZi+fHx7BbsvDJxSRmaLzi98eMx?=
 =?us-ascii?Q?4GjjcE+67UF5iVdSfaDLXIPYNe0UupAtuMh4UipENo0HXSso8aLyi9oN8N98?=
 =?us-ascii?Q?LgyyNjyx43e5NY0MXsgklHXi/yqBlXrJ70no?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 14:42:15.1832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a23490-e7d5-48f5-cae8-08ddaa887d6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465
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

set pcie default dpm table when updating pcie dpm parameters

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 104 ++++++++++++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 103 +++++++++++++----
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  45 ++++----
 3 files changed, 186 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5a9711e8cf68..257082c03865 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -572,8 +572,6 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
 	struct smu_13_0_dpm_table *dpm_table;
-	struct smu_13_0_pcie_table *pcie_table;
-	uint32_t link_level;
 	int ret = 0;
 
 	/* socclk dpm table setup */
@@ -689,24 +687,6 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
-	/* lclk dpm table setup */
-	pcie_table = &dpm_context->dpm_tables.pcie_table;
-	pcie_table->num_of_link_levels = 0;
-	for (link_level = 0; link_level < NUM_LINK_LEVELS; link_level++) {
-		if (!skutable->PcieGenSpeed[link_level] &&
-		    !skutable->PcieLaneCount[link_level] &&
-		    !skutable->LclkFreq[link_level])
-			continue;
-
-		pcie_table->pcie_gen[pcie_table->num_of_link_levels] =
-					skutable->PcieGenSpeed[link_level];
-		pcie_table->pcie_lane[pcie_table->num_of_link_levels] =
-					skutable->PcieLaneCount[link_level];
-		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
-					skutable->LclkFreq[link_level];
-		pcie_table->num_of_link_levels++;
-	}
-
 	/* dcefclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dcef_table;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
@@ -3150,6 +3130,88 @@ static int smu_v13_0_0_set_power_limit(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
+				     uint8_t pcie_gen_cap,
+				     uint8_t pcie_width_cap)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_13_0_pcie_table *pcie_table =
+				&dpm_context->dpm_tables.pcie_table;
+	int num_of_levels;
+	uint32_t smu_pcie_arg;
+	uint32_t link_level;
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	SkuTable_t *skutable = &pptable->SkuTable;
+	int ret = 0;
+	int i;
+
+	pcie_table->num_of_link_levels = 0;
+
+	for (link_level = 0; link_level < NUM_LINK_LEVELS; link_level++) {
+		if (!skutable->PcieGenSpeed[link_level] &&
+		    !skutable->PcieLaneCount[link_level] &&
+		    !skutable->LclkFreq[link_level])
+			continue;
+
+		pcie_table->pcie_gen[pcie_table->num_of_link_levels] =
+					skutable->PcieGenSpeed[link_level];
+		pcie_table->pcie_lane[pcie_table->num_of_link_levels] =
+					skutable->PcieLaneCount[link_level];
+		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
+					skutable->LclkFreq[link_level];
+		pcie_table->num_of_link_levels++;
+	}
+
+	num_of_levels = pcie_table->num_of_link_levels;
+	if (!num_of_levels)
+		return 0;
+
+	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
+		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
+
+		if (pcie_table->pcie_lane[num_of_levels - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[num_of_levels - 1];
+
+		/* Force all levels to use the same settings */
+		for (i = 0; i < num_of_levels; i++) {
+			pcie_table->pcie_gen[i] = pcie_gen_cap;
+			pcie_table->pcie_lane[i] = pcie_width_cap;
+			smu_pcie_arg = i << 16;
+			smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+			smu_pcie_arg |= pcie_table->pcie_lane[i];
+
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+								SMU_MSG_OverridePcieParameters,
+								smu_pcie_arg,
+								NULL);
+			if (ret)
+				break;
+		}
+	} else {
+		for (i = 0; i < num_of_levels; i++) {
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap ||
+				pcie_table->pcie_lane[i] > pcie_width_cap) {
+				pcie_table->pcie_gen[i] = pcie_gen_cap;
+				pcie_table->pcie_lane[i] = pcie_width_cap;
+				smu_pcie_arg = i << 16;
+				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+				smu_pcie_arg |= pcie_table->pcie_lane[i];
+
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+									SMU_MSG_OverridePcieParameters,
+									smu_pcie_arg,
+									NULL);
+				if (ret)
+					break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -3179,7 +3241,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.print_clk_levels = smu_v13_0_0_print_clk_levels,
 	.force_clk_levels = smu_v13_0_0_force_clk_levels,
-	.update_pcie_parameters = smu_v13_0_update_pcie_parameters,
+	.update_pcie_parameters = smu_v13_0_0_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v13_0_0_get_thermal_temperature_range,
 	.register_irq_handler = smu_v13_0_register_irq_handler,
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c8f4f6fb4083..e96364856e74 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -579,8 +579,6 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 	PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
 	SkuTable_t *skutable = &driver_ppt->SkuTable;
 	struct smu_13_0_dpm_table *dpm_table;
-	struct smu_13_0_pcie_table *pcie_table;
-	uint32_t link_level;
 	int ret = 0;
 
 	/* socclk dpm table setup */
@@ -687,24 +685,6 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
-	/* lclk dpm table setup */
-	pcie_table = &dpm_context->dpm_tables.pcie_table;
-	pcie_table->num_of_link_levels = 0;
-	for (link_level = 0; link_level < NUM_LINK_LEVELS; link_level++) {
-		if (!skutable->PcieGenSpeed[link_level] &&
-		    !skutable->PcieLaneCount[link_level] &&
-		    !skutable->LclkFreq[link_level])
-			continue;
-
-		pcie_table->pcie_gen[pcie_table->num_of_link_levels] =
-					skutable->PcieGenSpeed[link_level];
-		pcie_table->pcie_lane[pcie_table->num_of_link_levels] =
-					skutable->PcieLaneCount[link_level];
-		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
-					skutable->LclkFreq[link_level];
-		pcie_table->num_of_link_levels++;
-	}
-
 	/* dcefclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dcef_table;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
@@ -2739,6 +2719,87 @@ static int smu_v13_0_7_set_power_limit(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
+				     uint8_t pcie_gen_cap,
+				     uint8_t pcie_width_cap)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_13_0_pcie_table *pcie_table =
+				&dpm_context->dpm_tables.pcie_table;
+	int num_of_levels;
+	int link_level;
+	uint32_t smu_pcie_arg;
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	SkuTable_t *skutable = &pptable->SkuTable;
+	int ret = 0;
+	int i;
+
+	pcie_table->num_of_link_levels = 0;
+	for (link_level = 0; link_level < NUM_LINK_LEVELS; link_level++) {
+		if (!skutable->PcieGenSpeed[link_level] &&
+		    !skutable->PcieLaneCount[link_level] &&
+		    !skutable->LclkFreq[link_level])
+			continue;
+
+		pcie_table->pcie_gen[pcie_table->num_of_link_levels] =
+					skutable->PcieGenSpeed[link_level];
+		pcie_table->pcie_lane[pcie_table->num_of_link_levels] =
+					skutable->PcieLaneCount[link_level];
+		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
+					skutable->LclkFreq[link_level];
+		pcie_table->num_of_link_levels++;
+	}
+
+	num_of_levels = pcie_table->num_of_link_levels;
+	if (!num_of_levels)
+		return 0;
+
+	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
+		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
+
+		if (pcie_table->pcie_lane[num_of_levels - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[num_of_levels - 1];
+
+		/* Force all levels to use the same settings */
+		for (i = 0; i < num_of_levels; i++) {
+			pcie_table->pcie_gen[i] = pcie_gen_cap;
+			pcie_table->pcie_lane[i] = pcie_width_cap;
+			smu_pcie_arg = i << 16;
+			smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+			smu_pcie_arg |= pcie_table->pcie_lane[i];
+
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+								SMU_MSG_OverridePcieParameters,
+								smu_pcie_arg,
+								NULL);
+			if (ret)
+				break;
+		}
+	} else {
+		for (i = 0; i < num_of_levels; i++) {
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap ||
+				pcie_table->pcie_lane[i] > pcie_width_cap) {
+				pcie_table->pcie_gen[i] = pcie_gen_cap;
+				pcie_table->pcie_lane[i] = pcie_width_cap;
+				smu_pcie_arg = i << 16;
+				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+				smu_pcie_arg |= pcie_table->pcie_lane[i];
+
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+									SMU_MSG_OverridePcieParameters,
+									smu_pcie_arg,
+									NULL);
+				if (ret)
+					break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -2768,7 +2829,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.print_clk_levels = smu_v13_0_7_print_clk_levels,
 	.force_clk_levels = smu_v13_0_7_force_clk_levels,
-	.update_pcie_parameters = smu_v13_0_update_pcie_parameters,
+	.update_pcie_parameters = smu_v13_0_7_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v13_0_7_get_thermal_temperature_range,
 	.register_irq_handler = smu_v13_0_register_irq_handler,
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index d5a4abd60d06..581a4e59130a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -502,8 +502,6 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
 	struct smu_14_0_dpm_table *dpm_table;
-	struct smu_14_0_pcie_table *pcie_table;
-	uint32_t link_level;
 	int ret = 0;
 
 	/* socclk dpm table setup */
@@ -619,27 +617,6 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
-	/* lclk dpm table setup */
-	pcie_table = &dpm_context->dpm_tables.pcie_table;
-	pcie_table->num_of_link_levels = 0;
-	for (link_level = 0; link_level < NUM_LINK_LEVELS; link_level++) {
-		if (!skutable->PcieGenSpeed[link_level] &&
-		    !skutable->PcieLaneCount[link_level] &&
-		    !skutable->LclkFreq[link_level])
-			continue;
-
-		pcie_table->pcie_gen[pcie_table->num_of_link_levels] =
-					skutable->PcieGenSpeed[link_level];
-		pcie_table->pcie_lane[pcie_table->num_of_link_levels] =
-					skutable->PcieLaneCount[link_level];
-		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
-					skutable->LclkFreq[link_level];
-		pcie_table->num_of_link_levels++;
-
-		if (link_level == 0)
-			link_level++;
-	}
-
 	/* dcefclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dcef_table;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
@@ -1487,11 +1464,31 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 	struct smu_14_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_14_0_pcie_table *pcie_table =
 				&dpm_context->dpm_tables.pcie_table;
-	int num_of_levels = pcie_table->num_of_link_levels;
+	int num_of_levels;
 	uint32_t smu_pcie_arg;
+	uint32_t link_level;
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	SkuTable_t *skutable = &pptable->SkuTable;
 	int ret = 0;
 	int i;
 
+	pcie_table->num_of_link_levels = 0;
+	for (link_level = 0; link_level < NUM_LINK_LEVELS; link_level++) {
+		if (!skutable->PcieGenSpeed[link_level] &&
+		    !skutable->PcieLaneCount[link_level] &&
+		    !skutable->LclkFreq[link_level])
+			continue;
+
+		pcie_table->pcie_gen[pcie_table->num_of_link_levels] =
+					skutable->PcieGenSpeed[link_level];
+		pcie_table->pcie_lane[pcie_table->num_of_link_levels] =
+					skutable->PcieLaneCount[link_level];
+		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
+					skutable->LclkFreq[link_level];
+		pcie_table->num_of_link_levels++;
+	}
+	num_of_levels = pcie_table->num_of_link_levels;
 	if (!num_of_levels)
 		return 0;
 
-- 
2.34.1

