Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AACD116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F7610E365;
	Mon,  1 Dec 2025 10:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5QyPKowZ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012043.outbound.protection.outlook.com
 [40.93.195.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C562410E364
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g29W0QvrSWaHjCUxAkQRM61mu/JRUb+EZxt5vLKKGN98rXLI++28W/v5fdn4RBLdsxdY3ik5HTr/wincfwYsM3v0ScuYT9/HGzNvyp7I3/ILPP1ybQBhFcE5XiIa8j7iRsksKEsxaVupIaEujjCTq5bt+ZmOjeQ/J61/TpOKSvmFCGAIHM5d/HX2ZJ+XJyH2b3uuqEOqmSWUF3p3j1/8IoPjkucjW3abOfcpzHSGhDhud811xLEs8U8PPL14Wj0iTjf6taEEoMkj9K8YSNEsjhsUUPF28U5WcFfJbBPAChrgbXt4WO/2pyQJP2ehhzCw/bbUf3QhAaJ9EC7kyvouww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkDWqpdfcD+LZ0c/rYBE5ZfWJc1dgVe3hnxFIGhsr1c=;
 b=ky4bT76OjxqalXmvXjOcfkvsO8GKioWb5UEr8s1i1Y0gJrN/G+3Y5TetBPMis+9FjjuI7PNb8B6gY1KGdB/9tD3WGXIsYSVyKpIJU/LxWI+/ebzvPr/iUCVXgIijn+W61JfI+nvhAu9xO2wtUR47dJvX7OHU/9ZYvxIyzZgWIrumOfYHO7+t3xlQJLm2HNbpNwEnB7CTKSA9AGTCUVWlM2R5X+MKBFhoOPFdR4oA6Zn1SPNCqszYLjN41UjmT1mv4Kdb82MFOFTCE7Pnm5lyq6gseBY4YhtS0oQjb9Pusw1UohIOPSmdJRdln7B2coJCuGtZBg1VgT8+hThfdp12Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkDWqpdfcD+LZ0c/rYBE5ZfWJc1dgVe3hnxFIGhsr1c=;
 b=5QyPKowZf6IQGMZ/V/t+I4aME0snfE4qTI+upO15/Ik4LcL6jf7I5aROTnmDAToINyN0RdRCO5w2qotFHg1Gz1gU9h7Nqeu7IBlpchie6zR+ndw3DfPGRzsdH0P6ltx6mvd6iFT0mtpN/MyIabyJKcln+PEIg+VtUhPFekDYdOY=
Received: from CH0PR07CA0008.namprd07.prod.outlook.com (2603:10b6:610:32::13)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:18 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::da) by CH0PR07CA0008.outlook.office365.com
 (2603:10b6:610:32::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:16 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 03/17] drm/amd/pm: Use generic dpm table for SMUv13 SOCs
Date: Mon, 1 Dec 2025 15:33:16 +0530
Message-ID: <20251201101331.101584-4-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: c74986a2-68ba-4d6c-95ea-08de30c263c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZWLL0H9bPjkzi4KGKuww3ylCGhrgu1UPI7vDBdW2j+m3KFRva0YeP4HA6RC6?=
 =?us-ascii?Q?dulS3hb8uAfcfZfXPyfOa7d+W8Zi0Sgoj2BAqVWl6fVFMLY3Sai8c1Djy0g+?=
 =?us-ascii?Q?1LGIOb+52wMWcieB7WClSXTNt1GGx25i7rBOKnltTFF2PeIGgzU5JtQBAEGK?=
 =?us-ascii?Q?yLHvcAXmlwUXhYArS4g9PHAZKBENQIWJrX1W6icRicmDqdMn4RcXPvAl24sC?=
 =?us-ascii?Q?h06TLb62FAO/wKarAtuWrfwiJfIjS279mKpzSxrpGf2VjlauCx4xsLXzYZJk?=
 =?us-ascii?Q?RBsEcJ0xokIiVaptVcyhMogpbdXycBgS1CJSKz55CFfxVgAjX3nliD6L7eva?=
 =?us-ascii?Q?GOdKrAFPNQmWEzvFFGN7huy7A/txM0VK5IPDjUGU+k4c1J204+atO0Fz1QAj?=
 =?us-ascii?Q?wCIEVxdSAvZurK29NFM0ZcUijyvLZMovzn/NMKBvhLWuq2yqvWw5i4/2jWi8?=
 =?us-ascii?Q?+jsaX8R2s313XarsCEFKnmHcSR/Z/1Dg5bWWzUwrUo69EQn5lDI1ZpVv/0T1?=
 =?us-ascii?Q?IPQH00MqQ5G78Oeai71oA0hboq4+q4FVF9afJVZs9a/MgFROXKGSnSB7kDJo?=
 =?us-ascii?Q?FQ+qj8EglHLOTkTdrVTdb8EgyGqotlN9OBNjP+616l6+of2co+pr+BcyMOoh?=
 =?us-ascii?Q?78kkirvDjLwHU5KNOdOo/sp4NER6VYwDjXHZ603J0VzVxNUh4xklwCI24YRF?=
 =?us-ascii?Q?Dy91NtBsOXSR93mF6ln8/9SS2v/kXjtMAg1BBquORTVFxrb1jXVddx213gFu?=
 =?us-ascii?Q?S5aaWK5jDsX6yh4gnlRe3kUEY+ormK8Vcfs8JsTtLIIQnKIYwrYG+RKkNVfD?=
 =?us-ascii?Q?so3YbmWNdTJoohRjH6W+jehdfrVxhdt3G39hKrfnNDZSIU1pWrwj29iAC1zr?=
 =?us-ascii?Q?a6/YxGn3NTM68DpwW2768MH/8VBqz2O2qmdHWB6KVpM3xsog6/pi+TynwyHC?=
 =?us-ascii?Q?0jGFYiTymCjzyLldCueJ9Dp/kj6bVSOXNUO5kssQUWv/H4S2yQyWreu/5XPU?=
 =?us-ascii?Q?2r312H4T1NAdPiqLVPNf83/Wk7Ca//8R9i/kt4EiKbA7pw6bonHMo/BsKybS?=
 =?us-ascii?Q?VahCGYYvg+uvW0NzkrN6hHXod+88XX0MUGBbtDXZvui5PaHjzO/ZV2zxNS8Q?=
 =?us-ascii?Q?RjEXMDe4PJNysWazbZdpzHIplopk/ijB+YbHbG/AeAHBnkSO/XkXk4eCB09D?=
 =?us-ascii?Q?cZLHMPCggGz84tDiW8h80pgA2y7/wkjXqrCIZVhzSqy2LwDc2nSBtRo5rdiY?=
 =?us-ascii?Q?vmk9lrazyMDyb6Doec/N+LenQ2R6v5c3zsX3LAsYKLjDuXexZBH4BURe/SQX?=
 =?us-ascii?Q?XPBdGfQsn7LK8J8VGgLtTXQ6Y+TSKrqKU+Mxmt4B5pEn3sk9RR1/FzdlFYsu?=
 =?us-ascii?Q?i/yk0XEN9/h4i1EAVh5dElgRd9zYloa+wT/rs8TjZFKjKrTYuhBp7svVKI/g?=
 =?us-ascii?Q?iizVzySTe8LW67Ek/AZSF9VlXwalFkm1Txn4t78xNo+7tcSOnICnoQjDogpb?=
 =?us-ascii?Q?hkuFW0//OZxJiMg7lWj+M8godVNMh7bYZDfp4hY96s1MjwmNeCV0bGImmcUC?=
 =?us-ascii?Q?NSuxPjK+ymg0btsxWt8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:18.8010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c74986a2-68ba-4d6c-95ea-08de30c263c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
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

Use the generic dpm table structure instead of SMUv13 specific table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  38 ++---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 100 ++++++------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  81 +++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  97 +++++-------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 147 +++++++++---------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  97 +++++-------
 6 files changed, 253 insertions(+), 307 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 4263798d716b..4d1180030c8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -44,7 +44,6 @@
 
 #define SMU13_TOOL_SIZE			0x19000
 
-#define MAX_DPM_LEVELS 16
 #define MAX_PCIE_CONF 3
 
 #define CTF_OFFSET_EDGE			5
@@ -72,19 +71,6 @@ struct smu_13_0_max_sustainable_clocks {
 	uint32_t soc_clock;
 };
 
-struct smu_13_0_dpm_clk_level {
-	bool				enabled;
-	uint32_t			value;
-};
-
-struct smu_13_0_dpm_table {
-	uint32_t			min;        /* MHz */
-	uint32_t			max;        /* MHz */
-	uint32_t			count;
-	bool				is_fine_grained;
-	struct smu_13_0_dpm_clk_level	dpm_levels[MAX_DPM_LEVELS];
-};
-
 struct smu_13_0_pcie_table {
 	uint8_t  pcie_gen[MAX_PCIE_CONF];
 	uint8_t  pcie_lane[MAX_PCIE_CONF];
@@ -93,17 +79,17 @@ struct smu_13_0_pcie_table {
 };
 
 struct smu_13_0_dpm_tables {
-	struct smu_13_0_dpm_table        soc_table;
-	struct smu_13_0_dpm_table        gfx_table;
-	struct smu_13_0_dpm_table        uclk_table;
-	struct smu_13_0_dpm_table        eclk_table;
-	struct smu_13_0_dpm_table        vclk_table;
-	struct smu_13_0_dpm_table        dclk_table;
-	struct smu_13_0_dpm_table        dcef_table;
-	struct smu_13_0_dpm_table        pixel_table;
-	struct smu_13_0_dpm_table        display_table;
-	struct smu_13_0_dpm_table        phy_table;
-	struct smu_13_0_dpm_table        fclk_table;
+	struct smu_dpm_table        soc_table;
+	struct smu_dpm_table        gfx_table;
+	struct smu_dpm_table        uclk_table;
+	struct smu_dpm_table        eclk_table;
+	struct smu_dpm_table        vclk_table;
+	struct smu_dpm_table        dclk_table;
+	struct smu_dpm_table        dcef_table;
+	struct smu_dpm_table        pixel_table;
+	struct smu_dpm_table        display_table;
+	struct smu_dpm_table        phy_table;
+	struct smu_dpm_table        fclk_table;
 	struct smu_13_0_pcie_table       pcie_table;
 };
 
@@ -226,7 +212,7 @@ int smu_v13_0_set_power_source(struct smu_context *smu,
 
 int smu_v13_0_set_single_dpm_table(struct smu_context *smu,
 				   enum smu_clk_type clk_type,
-				   struct smu_13_0_dpm_table *single_dpm_table);
+				   struct smu_dpm_table *single_dpm_table);
 
 int smu_v13_0_get_dpm_freq_by_index(struct smu_context *smu,
 				    enum smu_clk_type clk_type, uint16_t level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 18d5d0704509..07adbec5c169 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -347,7 +347,7 @@ static int aldebaran_get_dpm_ultimate_freq(struct smu_context *smu,
 					   uint32_t *min, uint32_t *max)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_dpm_table *dpm_table;
+	struct smu_dpm_table *dpm_table;
 	uint32_t min_clk, max_clk;
 
 	if (amdgpu_sriov_vf(smu->adev)) {
@@ -376,8 +376,8 @@ static int aldebaran_get_dpm_ultimate_freq(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		min_clk = dpm_table->min;
-		max_clk = dpm_table->max;
+		min_clk = SMU_DPM_TABLE_MIN(dpm_table);
+		max_clk = SMU_DPM_TABLE_MAX(dpm_table);
 
 		if (min) {
 			if (!min_clk)
@@ -400,12 +400,13 @@ static int aldebaran_get_dpm_ultimate_freq(struct smu_context *smu,
 static int aldebaran_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_dpm_table *dpm_table = NULL;
+	struct smu_dpm_table *dpm_table = NULL;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	int ret = 0;
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
+	dpm_table->clk_type = SMU_SOCCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_SOCCLK,
@@ -416,12 +417,11 @@ static int aldebaran_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
+	dpm_table->clk_type = SMU_GFXCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
 		/* in the case of gfxclk, only fine-grained dpm is honored */
 		dpm_table->count = 2;
@@ -429,18 +429,15 @@ static int aldebaran_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->dpm_levels[0].enabled = true;
 		dpm_table->dpm_levels[1].value = pptable->GfxclkFmax;
 		dpm_table->dpm_levels[1].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[1].value;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* memclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.uclk_table;
+	dpm_table->clk_type = SMU_UCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_UCLK,
@@ -451,12 +448,11 @@ static int aldebaran_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* fclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.fclk_table;
+	dpm_table->clk_type = SMU_FCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_FCLK,
@@ -467,8 +463,6 @@ static int aldebaran_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	return 0;
@@ -593,29 +587,26 @@ static int aldebaran_populate_umd_state_clk(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context =
 		smu->smu_dpm.dpm_context;
-	struct smu_13_0_dpm_table *gfx_table =
-		&dpm_context->dpm_tables.gfx_table;
-	struct smu_13_0_dpm_table *mem_table =
-		&dpm_context->dpm_tables.uclk_table;
-	struct smu_13_0_dpm_table *soc_table =
-		&dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
 	struct smu_umd_pstate_table *pstate_table =
 		&smu->pstate_table;
 
-	pstate_table->gfxclk_pstate.min = gfx_table->min;
-	pstate_table->gfxclk_pstate.peak = gfx_table->max;
-	pstate_table->gfxclk_pstate.curr.min = gfx_table->min;
-	pstate_table->gfxclk_pstate.curr.max = gfx_table->max;
+	pstate_table->gfxclk_pstate.min = SMU_DPM_TABLE_MIN(gfx_table);
+	pstate_table->gfxclk_pstate.peak = SMU_DPM_TABLE_MAX(gfx_table);
+	pstate_table->gfxclk_pstate.curr.min = SMU_DPM_TABLE_MIN(gfx_table);
+	pstate_table->gfxclk_pstate.curr.max = SMU_DPM_TABLE_MAX(gfx_table);
 
-	pstate_table->uclk_pstate.min = mem_table->min;
-	pstate_table->uclk_pstate.peak = mem_table->max;
-	pstate_table->uclk_pstate.curr.min = mem_table->min;
-	pstate_table->uclk_pstate.curr.max = mem_table->max;
+	pstate_table->uclk_pstate.min = SMU_DPM_TABLE_MIN(mem_table);
+	pstate_table->uclk_pstate.peak = SMU_DPM_TABLE_MAX(mem_table);
+	pstate_table->uclk_pstate.curr.min = SMU_DPM_TABLE_MIN(mem_table);
+	pstate_table->uclk_pstate.curr.max = SMU_DPM_TABLE_MAX(mem_table);
 
-	pstate_table->socclk_pstate.min = soc_table->min;
-	pstate_table->socclk_pstate.peak = soc_table->max;
-	pstate_table->socclk_pstate.curr.min = soc_table->min;
-	pstate_table->socclk_pstate.curr.max = soc_table->max;
+	pstate_table->socclk_pstate.min = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->socclk_pstate.peak = SMU_DPM_TABLE_MAX(soc_table);
+	pstate_table->socclk_pstate.curr.min = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->socclk_pstate.curr.max = SMU_DPM_TABLE_MAX(soc_table);
 
 	if (gfx_table->count > ALDEBARAN_UMD_PSTATE_GFXCLK_LEVEL &&
 	    mem_table->count > ALDEBARAN_UMD_PSTATE_MCLK_LEVEL &&
@@ -640,7 +631,7 @@ static int aldebaran_populate_umd_state_clk(struct smu_context *smu)
 
 static void aldebaran_get_clk_table(struct smu_context *smu,
 				    struct pp_clock_levels_with_latency *clocks,
-				    struct smu_13_0_dpm_table *dpm_table)
+				    struct smu_dpm_table *dpm_table)
 {
 	uint32_t i;
 
@@ -829,7 +820,7 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 	int ret = 0;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	struct pp_clock_levels_with_latency clocks;
-	struct smu_13_0_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = NULL;
 	uint32_t i;
@@ -1040,7 +1031,7 @@ static int aldebaran_force_clk_levels(struct smu_context *smu,
 				      enum smu_clk_type type, uint32_t mask)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_dpm_table *single_dpm_table = NULL;
+	struct smu_dpm_table *single_dpm_table = NULL;
 	uint32_t soft_min_level, soft_max_level;
 	int ret = 0;
 
@@ -1322,8 +1313,7 @@ static int aldebaran_set_performance_level(struct smu_context *smu,
 {
 	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	struct smu_13_0_dpm_table *gfx_table =
-		&dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	int r;
 
@@ -1331,7 +1321,8 @@ static int aldebaran_set_performance_level(struct smu_context *smu,
 	if ((smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) &&
 	    (level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)) {
 		smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism, NULL);
-		pstate_table->gfxclk_pstate.curr.max = gfx_table->max;
+		pstate_table->gfxclk_pstate.curr.max =
+			SMU_DPM_TABLE_MAX(gfx_table);
 	}
 
 	switch (level) {
@@ -1372,7 +1363,8 @@ static int aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
 
 	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK)
 		return -EINVAL;
-
+	min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.gfx_table);
+	max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.gfx_table);
 	if ((smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
 			&& (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))
 		return -EINVAL;
@@ -1399,16 +1391,13 @@ static int aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
-		if (!max || (max < dpm_context->dpm_tables.gfx_table.min) ||
-			(max > dpm_context->dpm_tables.gfx_table.max)) {
+		if (!max || (max < min_clk) || (max > max_clk)) {
 			dev_warn(adev->dev,
 					"Invalid max frequency %d MHz specified for determinism\n", max);
 			return -EINVAL;
 		}
 
 		/* Restore default min/max clocks and enable determinism */
-		min_clk = dpm_context->dpm_tables.gfx_table.min;
-		max_clk = dpm_context->dpm_tables.gfx_table.max;
 		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk, false);
 		if (!ret) {
 			usleep_range(500, 1000);
@@ -1449,11 +1438,14 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 			dev_err(smu->adev->dev, "Input parameter number not correct\n");
 			return -EINVAL;
 		}
-
+		min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.gfx_table);
+		max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.gfx_table);
 		if (input[0] == 0) {
-			if (input[1] < dpm_context->dpm_tables.gfx_table.min) {
-				dev_warn(smu->adev->dev, "Minimum GFX clk (%ld) MHz specified is less than the minimum allowed (%d) MHz\n",
-					input[1], dpm_context->dpm_tables.gfx_table.min);
+			if (input[1] < min_clk) {
+				dev_warn(
+					smu->adev->dev,
+					"Minimum GFX clk (%ld) MHz specified is less than the minimum allowed (%d) MHz\n",
+					input[1], min_clk);
 				pstate_table->gfxclk_pstate.custom.min =
 					pstate_table->gfxclk_pstate.curr.min;
 				return -EINVAL;
@@ -1461,9 +1453,11 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 
 			pstate_table->gfxclk_pstate.custom.min = input[1];
 		} else if (input[0] == 1) {
-			if (input[1] > dpm_context->dpm_tables.gfx_table.max) {
-				dev_warn(smu->adev->dev, "Maximum GFX clk (%ld) MHz specified is greater than the maximum allowed (%d) MHz\n",
-					input[1], dpm_context->dpm_tables.gfx_table.max);
+			if (input[1] > max_clk) {
+				dev_warn(
+					smu->adev->dev,
+					"Maximum GFX clk (%ld) MHz specified is greater than the maximum allowed (%d) MHz\n",
+					input[1], max_clk);
 				pstate_table->gfxclk_pstate.custom.max =
 					pstate_table->gfxclk_pstate.curr.max;
 				return -EINVAL;
@@ -1480,8 +1474,10 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 			return -EINVAL;
 		} else {
 			/* Use the default frequencies for manual and determinism mode */
-			min_clk = dpm_context->dpm_tables.gfx_table.min;
-			max_clk = dpm_context->dpm_tables.gfx_table.max;
+			min_clk = SMU_DPM_TABLE_MIN(
+				&dpm_context->dpm_tables.gfx_table);
+			max_clk = SMU_DPM_TABLE_MAX(
+				&dpm_context->dpm_tables.gfx_table);
 
 			ret = aldebaran_set_soft_freq_limited_range(
 				smu, SMU_GFXCLK, min_clk, max_clk, false);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a89075e25717..417c6f42c4fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1585,18 +1585,12 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 {
 	struct smu_13_0_dpm_context *dpm_context =
 		smu->smu_dpm.dpm_context;
-	struct smu_13_0_dpm_table *gfx_table =
-		&dpm_context->dpm_tables.gfx_table;
-	struct smu_13_0_dpm_table *mem_table =
-		&dpm_context->dpm_tables.uclk_table;
-	struct smu_13_0_dpm_table *soc_table =
-		&dpm_context->dpm_tables.soc_table;
-	struct smu_13_0_dpm_table *vclk_table =
-		&dpm_context->dpm_tables.vclk_table;
-	struct smu_13_0_dpm_table *dclk_table =
-		&dpm_context->dpm_tables.dclk_table;
-	struct smu_13_0_dpm_table *fclk_table =
-		&dpm_context->dpm_tables.fclk_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *vclk_table = &dpm_context->dpm_tables.vclk_table;
+	struct smu_dpm_table *dclk_table = &dpm_context->dpm_tables.dclk_table;
+	struct smu_dpm_table *fclk_table = &dpm_context->dpm_tables.fclk_table;
 	struct smu_umd_pstate_table *pstate_table =
 		&smu->pstate_table;
 	struct amdgpu_device *adev = smu->adev;
@@ -1611,34 +1605,34 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-		sclk_min = sclk_max = gfx_table->max;
-		mclk_min = mclk_max = mem_table->max;
-		socclk_min = socclk_max = soc_table->max;
-		vclk_min = vclk_max = vclk_table->max;
-		dclk_min = dclk_max = dclk_table->max;
-		fclk_min = fclk_max = fclk_table->max;
+		sclk_min = sclk_max = SMU_DPM_TABLE_MAX(gfx_table);
+		mclk_min = mclk_max = SMU_DPM_TABLE_MAX(mem_table);
+		socclk_min = socclk_max = SMU_DPM_TABLE_MAX(soc_table);
+		vclk_min = vclk_max = SMU_DPM_TABLE_MAX(vclk_table);
+		dclk_min = dclk_max = SMU_DPM_TABLE_MAX(dclk_table);
+		fclk_min = fclk_max = SMU_DPM_TABLE_MAX(fclk_table);
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
-		sclk_min = sclk_max = gfx_table->min;
-		mclk_min = mclk_max = mem_table->min;
-		socclk_min = socclk_max = soc_table->min;
-		vclk_min = vclk_max = vclk_table->min;
-		dclk_min = dclk_max = dclk_table->min;
-		fclk_min = fclk_max = fclk_table->min;
+		sclk_min = sclk_max = SMU_DPM_TABLE_MIN(gfx_table);
+		mclk_min = mclk_max = SMU_DPM_TABLE_MIN(mem_table);
+		socclk_min = socclk_max = SMU_DPM_TABLE_MIN(soc_table);
+		vclk_min = vclk_max = SMU_DPM_TABLE_MIN(vclk_table);
+		dclk_min = dclk_max = SMU_DPM_TABLE_MIN(dclk_table);
+		fclk_min = fclk_max = SMU_DPM_TABLE_MIN(fclk_table);
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
-		sclk_min = gfx_table->min;
-		sclk_max = gfx_table->max;
-		mclk_min = mem_table->min;
-		mclk_max = mem_table->max;
-		socclk_min = soc_table->min;
-		socclk_max = soc_table->max;
-		vclk_min = vclk_table->min;
-		vclk_max = vclk_table->max;
-		dclk_min = dclk_table->min;
-		dclk_max = dclk_table->max;
-		fclk_min = fclk_table->min;
-		fclk_max = fclk_table->max;
+		sclk_min = SMU_DPM_TABLE_MIN(gfx_table);
+		sclk_max = SMU_DPM_TABLE_MAX(gfx_table);
+		mclk_min = SMU_DPM_TABLE_MIN(mem_table);
+		mclk_max = SMU_DPM_TABLE_MAX(mem_table);
+		socclk_min = SMU_DPM_TABLE_MIN(soc_table);
+		socclk_max = SMU_DPM_TABLE_MAX(soc_table);
+		vclk_min = SMU_DPM_TABLE_MIN(vclk_table);
+		vclk_max = SMU_DPM_TABLE_MAX(vclk_table);
+		dclk_min = SMU_DPM_TABLE_MIN(dclk_table);
+		dclk_max = SMU_DPM_TABLE_MAX(dclk_table);
+		fclk_min = SMU_DPM_TABLE_MIN(fclk_table);
+		fclk_max = SMU_DPM_TABLE_MAX(fclk_table);
 		auto_level = true;
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
@@ -1909,11 +1903,12 @@ static int smu_v13_0_get_fine_grained_status(struct smu_context *smu,
 
 int smu_v13_0_set_single_dpm_table(struct smu_context *smu,
 				   enum smu_clk_type clk_type,
-				   struct smu_13_0_dpm_table *single_dpm_table)
+				   struct smu_dpm_table *single_dpm_table)
 {
 	int ret = 0;
 	uint32_t clk;
 	int i;
+	bool is_fine_grained;
 
 	ret = smu_v13_0_get_dpm_level_count(smu,
 					    clk_type,
@@ -1924,13 +1919,14 @@ int smu_v13_0_set_single_dpm_table(struct smu_context *smu,
 	}
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 2)) {
-		ret = smu_v13_0_get_fine_grained_status(smu,
-							clk_type,
-							&single_dpm_table->is_fine_grained);
+		ret = smu_v13_0_get_fine_grained_status(smu, clk_type,
+							&is_fine_grained);
 		if (ret) {
 			dev_err(smu->adev->dev, "[%s] failed to get fine grained status!\n", __func__);
 			return ret;
 		}
+		if (is_fine_grained)
+			single_dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	}
 
 	for (i = 0; i < single_dpm_table->count; i++) {
@@ -1945,11 +1941,6 @@ int smu_v13_0_set_single_dpm_table(struct smu_context *smu,
 
 		single_dpm_table->dpm_levels[i].value = clk;
 		single_dpm_table->dpm_levels[i].enabled = true;
-
-		if (i == 0)
-			single_dpm_table->min = clk;
-		else if (i == single_dpm_table->count - 1)
-			single_dpm_table->max = clk;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e6ae77223b7c..bc8293f45a13 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -571,11 +571,12 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	struct smu_13_0_dpm_table *dpm_table;
+	struct smu_dpm_table *dpm_table;
 	int ret = 0;
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
+	dpm_table->clk_type = SMU_SOCCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_SOCCLK,
@@ -586,12 +587,11 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
+	dpm_table->clk_type = SMU_GFXCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_GFXCLK,
@@ -613,18 +613,16 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 		    skutable->DriverReportedClocks.GameClockAc)) {
 			dpm_table->dpm_levels[dpm_table->count - 1].value =
 				skutable->DriverReportedClocks.GameClockAc;
-			dpm_table->max = skutable->DriverReportedClocks.GameClockAc;
 		}
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* uclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.uclk_table;
+	dpm_table->clk_type = SMU_UCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_UCLK,
@@ -635,12 +633,11 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* fclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.fclk_table;
+	dpm_table->clk_type = SMU_FCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_FCLK,
@@ -651,12 +648,11 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* vclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.vclk_table;
+	dpm_table->clk_type = SMU_VCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_VCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_VCLK,
@@ -667,12 +663,11 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* dclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dclk_table;
+	dpm_table->clk_type = SMU_DCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_DCLK,
@@ -683,12 +678,11 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* dcefclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dcef_table;
+	dpm_table->clk_type = SMU_DCEFCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_DCEFCLK,
@@ -699,8 +693,6 @@ static int smu_v13_0_0_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	return 0;
@@ -876,7 +868,7 @@ static int smu_v13_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 {
 	struct smu_13_0_dpm_context *dpm_context =
 		smu->smu_dpm.dpm_context;
-	struct smu_13_0_dpm_table *dpm_table;
+	struct smu_dpm_table *dpm_table;
 
 	switch (clk_type) {
 	case SMU_MCLK:
@@ -913,9 +905,9 @@ static int smu_v13_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 	}
 
 	if (min)
-		*min = dpm_table->min;
+		*min = SMU_DPM_TABLE_MIN(dpm_table);
 	if (max)
-		*max = dpm_table->max;
+		*max = SMU_DPM_TABLE_MAX(dpm_table);
 
 	return 0;
 }
@@ -1193,7 +1185,7 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
 	int i, curr_freq, size = *offset, start_offset = *offset;
-	struct smu_13_0_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table;
 	struct smu_13_0_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
 	int32_t min_value, max_value;
@@ -1248,7 +1240,7 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 			return ret;
 		}
 
-		if (single_dpm_table->is_fine_grained) {
+		if (single_dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED) {
 			/*
 			 * For fine grained dpms, there are only two dpm levels:
 			 *   - level 0 -> min clock freq
@@ -1988,7 +1980,7 @@ static int smu_v13_0_0_force_clk_levels(struct smu_context *smu,
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	struct smu_13_0_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table;
 	uint32_t soft_min_level, soft_max_level;
 	uint32_t min_freq, max_freq;
 	int ret = 0;
@@ -2034,7 +2026,7 @@ static int smu_v13_0_0_force_clk_levels(struct smu_context *smu,
 	case SMU_VCLK1:
 	case SMU_DCLK:
 	case SMU_DCLK1:
-		if (single_dpm_table->is_fine_grained) {
+		if (single_dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED) {
 			/* There is only 2 levels for fine grained DPM */
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
@@ -2302,18 +2294,12 @@ static int smu_v13_0_0_populate_umd_state_clk(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context =
 				smu->smu_dpm.dpm_context;
-	struct smu_13_0_dpm_table *gfx_table =
-				&dpm_context->dpm_tables.gfx_table;
-	struct smu_13_0_dpm_table *mem_table =
-				&dpm_context->dpm_tables.uclk_table;
-	struct smu_13_0_dpm_table *soc_table =
-				&dpm_context->dpm_tables.soc_table;
-	struct smu_13_0_dpm_table *vclk_table =
-				&dpm_context->dpm_tables.vclk_table;
-	struct smu_13_0_dpm_table *dclk_table =
-				&dpm_context->dpm_tables.dclk_table;
-	struct smu_13_0_dpm_table *fclk_table =
-				&dpm_context->dpm_tables.fclk_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *vclk_table = &dpm_context->dpm_tables.vclk_table;
+	struct smu_dpm_table *dclk_table = &dpm_context->dpm_tables.dclk_table;
+	struct smu_dpm_table *fclk_table = &dpm_context->dpm_tables.fclk_table;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -2321,38 +2307,39 @@ static int smu_v13_0_0_populate_umd_state_clk(struct smu_context *smu)
 	DriverReportedClocks_t driver_clocks =
 			pptable->SkuTable.DriverReportedClocks;
 
-	pstate_table->gfxclk_pstate.min = gfx_table->min;
+	pstate_table->gfxclk_pstate.min = SMU_DPM_TABLE_MIN(gfx_table);
 	if (driver_clocks.GameClockAc &&
-	    (driver_clocks.GameClockAc < gfx_table->max))
+	    (driver_clocks.GameClockAc < SMU_DPM_TABLE_MAX(gfx_table)))
 		pstate_table->gfxclk_pstate.peak = driver_clocks.GameClockAc;
 	else
-		pstate_table->gfxclk_pstate.peak = gfx_table->max;
+		pstate_table->gfxclk_pstate.peak = SMU_DPM_TABLE_MAX(gfx_table);
 
-	pstate_table->uclk_pstate.min = mem_table->min;
-	pstate_table->uclk_pstate.peak = mem_table->max;
+	pstate_table->uclk_pstate.min = SMU_DPM_TABLE_MIN(mem_table);
+	pstate_table->uclk_pstate.peak = SMU_DPM_TABLE_MAX(mem_table);
 
-	pstate_table->socclk_pstate.min = soc_table->min;
-	pstate_table->socclk_pstate.peak = soc_table->max;
+	pstate_table->socclk_pstate.min = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->socclk_pstate.peak = SMU_DPM_TABLE_MAX(soc_table);
 
-	pstate_table->vclk_pstate.min = vclk_table->min;
-	pstate_table->vclk_pstate.peak = vclk_table->max;
+	pstate_table->vclk_pstate.min = SMU_DPM_TABLE_MIN(vclk_table);
+	pstate_table->vclk_pstate.peak = SMU_DPM_TABLE_MAX(vclk_table);
 
-	pstate_table->dclk_pstate.min = dclk_table->min;
-	pstate_table->dclk_pstate.peak = dclk_table->max;
+	pstate_table->dclk_pstate.min = SMU_DPM_TABLE_MIN(dclk_table);
+	pstate_table->dclk_pstate.peak = SMU_DPM_TABLE_MAX(dclk_table);
 
-	pstate_table->fclk_pstate.min = fclk_table->min;
-	pstate_table->fclk_pstate.peak = fclk_table->max;
+	pstate_table->fclk_pstate.min = SMU_DPM_TABLE_MIN(fclk_table);
+	pstate_table->fclk_pstate.peak = SMU_DPM_TABLE_MAX(fclk_table);
 
 	if (driver_clocks.BaseClockAc &&
-	    driver_clocks.BaseClockAc < gfx_table->max)
+	    driver_clocks.BaseClockAc < SMU_DPM_TABLE_MAX(gfx_table))
 		pstate_table->gfxclk_pstate.standard = driver_clocks.BaseClockAc;
 	else
-		pstate_table->gfxclk_pstate.standard = gfx_table->max;
-	pstate_table->uclk_pstate.standard = mem_table->max;
-	pstate_table->socclk_pstate.standard = soc_table->min;
-	pstate_table->vclk_pstate.standard = vclk_table->min;
-	pstate_table->dclk_pstate.standard = dclk_table->min;
-	pstate_table->fclk_pstate.standard = fclk_table->min;
+		pstate_table->gfxclk_pstate.standard =
+			SMU_DPM_TABLE_MAX(gfx_table);
+	pstate_table->uclk_pstate.standard = SMU_DPM_TABLE_MAX(mem_table);
+	pstate_table->socclk_pstate.standard = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->vclk_pstate.standard = SMU_DPM_TABLE_MIN(vclk_table);
+	pstate_table->dclk_pstate.standard = SMU_DPM_TABLE_MIN(dclk_table);
+	pstate_table->fclk_pstate.standard = SMU_DPM_TABLE_MIN(fclk_table);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7ba299d5d7ca..adf973ea2809 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -251,7 +251,7 @@ static const uint8_t smu_v13_0_6_throttler_map[] = {
 struct smu_v13_0_6_dpm_map {
 	enum smu_clk_type clk_type;
 	uint32_t feature_num;
-	struct smu_13_0_dpm_table *dpm_table;
+	struct smu_dpm_table *dpm_table;
 	uint32_t *freq_table;
 };
 
@@ -987,7 +987,7 @@ static int smu_v13_0_6_get_dpm_ultimate_freq(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
-	struct smu_13_0_dpm_table *dpm_table;
+	struct smu_dpm_table *dpm_table;
 	uint32_t min_clk, max_clk, param;
 	int ret = 0, clk_id = 0;
 
@@ -1018,9 +1018,8 @@ static int smu_v13_0_6_get_dpm_ultimate_freq(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		min_clk = dpm_table->min;
-		max_clk = dpm_table->max;
-
+		min_clk = SMU_DPM_TABLE_MIN(dpm_table);
+		max_clk = SMU_DPM_TABLE_MAX(dpm_table);
 		if (min)
 			*min = min_clk;
 		if (max)
@@ -1090,7 +1089,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_13_0_dpm_table *dpm_table = NULL;
+	struct smu_dpm_table *dpm_table = NULL;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
 	uint32_t gfxclkmin, gfxclkmax, levels;
@@ -1126,6 +1125,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 	smu_v13_0_6_pm_policy_init(smu);
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
+	dpm_table->clk_type = SMU_GFXCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
 		/* In the case of gfxclk, only fine-grained dpm is honored.
 		 * Get min/max values from FW.
@@ -1134,20 +1134,15 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 							&gfxclkmin, &gfxclkmax);
 		if (ret)
 			return ret;
-
 		dpm_table->count = 2;
 		dpm_table->dpm_levels[0].value = gfxclkmin;
 		dpm_table->dpm_levels[0].enabled = true;
 		dpm_table->dpm_levels[1].value = gfxclkmax;
 		dpm_table->dpm_levels[1].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[1].value;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = pptable->MinGfxclkFrequency;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	for (j = 0; j < ARRAY_SIZE(dpm_map); j++) {
@@ -1160,15 +1155,12 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 				return ret;
 		}
 		dpm_table->count = levels;
+		dpm_table->clk_type = dpm_map[j].clk_type;
 		for (i = 0; i < dpm_table->count; ++i) {
 			dpm_table->dpm_levels[i].value =
 				dpm_map[j].freq_table[i];
 			dpm_table->dpm_levels[i].enabled = true;
-
 		}
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[levels - 1].value;
-
 	}
 
 	return 0;
@@ -1205,28 +1197,25 @@ static int smu_v13_0_6_check_fw_status(struct smu_context *smu)
 static int smu_v13_0_6_populate_umd_state_clk(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_dpm_table *gfx_table =
-		&dpm_context->dpm_tables.gfx_table;
-	struct smu_13_0_dpm_table *mem_table =
-		&dpm_context->dpm_tables.uclk_table;
-	struct smu_13_0_dpm_table *soc_table =
-		&dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 
-	pstate_table->gfxclk_pstate.min = gfx_table->min;
-	pstate_table->gfxclk_pstate.peak = gfx_table->max;
-	pstate_table->gfxclk_pstate.curr.min = gfx_table->min;
-	pstate_table->gfxclk_pstate.curr.max = gfx_table->max;
+	pstate_table->gfxclk_pstate.min = SMU_DPM_TABLE_MIN(gfx_table);
+	pstate_table->gfxclk_pstate.peak = SMU_DPM_TABLE_MAX(gfx_table);
+	pstate_table->gfxclk_pstate.curr.min = SMU_DPM_TABLE_MIN(gfx_table);
+	pstate_table->gfxclk_pstate.curr.max = SMU_DPM_TABLE_MAX(gfx_table);
 
-	pstate_table->uclk_pstate.min = mem_table->min;
-	pstate_table->uclk_pstate.peak = mem_table->max;
-	pstate_table->uclk_pstate.curr.min = mem_table->min;
-	pstate_table->uclk_pstate.curr.max = mem_table->max;
+	pstate_table->uclk_pstate.min = SMU_DPM_TABLE_MIN(mem_table);
+	pstate_table->uclk_pstate.peak = SMU_DPM_TABLE_MAX(mem_table);
+	pstate_table->uclk_pstate.curr.min = SMU_DPM_TABLE_MIN(mem_table);
+	pstate_table->uclk_pstate.curr.max = SMU_DPM_TABLE_MAX(mem_table);
 
-	pstate_table->socclk_pstate.min = soc_table->min;
-	pstate_table->socclk_pstate.peak = soc_table->max;
-	pstate_table->socclk_pstate.curr.min = soc_table->min;
-	pstate_table->socclk_pstate.curr.max = soc_table->max;
+	pstate_table->socclk_pstate.min = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->socclk_pstate.peak = SMU_DPM_TABLE_MAX(soc_table);
+	pstate_table->socclk_pstate.curr.min = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->socclk_pstate.curr.max = SMU_DPM_TABLE_MAX(soc_table);
 
 	if (gfx_table->count > SMU_13_0_6_UMD_PSTATE_GFXCLK_LEVEL &&
 	    mem_table->count > SMU_13_0_6_UMD_PSTATE_MCLK_LEVEL &&
@@ -1249,9 +1238,10 @@ static int smu_v13_0_6_populate_umd_state_clk(struct smu_context *smu)
 	return 0;
 }
 
-static int smu_v13_0_6_get_clk_table(struct smu_context *smu,
-				     struct pp_clock_levels_with_latency *clocks,
-				     struct smu_13_0_dpm_table *dpm_table)
+static int
+smu_v13_0_6_get_clk_table(struct smu_context *smu,
+			  struct pp_clock_levels_with_latency *clocks,
+			  struct smu_dpm_table *dpm_table)
 {
 	int i, count;
 
@@ -1403,7 +1393,7 @@ static int smu_v13_0_6_get_current_clk_freq_by_table(struct smu_context *smu,
 }
 
 static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf, int size,
-				  struct smu_13_0_dpm_table *single_dpm_table,
+				  struct smu_dpm_table *single_dpm_table,
 				  uint32_t curr_clk, const char *clk_name)
 {
 	struct pp_clock_levels_with_latency clocks;
@@ -1460,7 +1450,7 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
 	int now, size = *offset, start_offset = *offset;
 	int ret = 0;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
-	struct smu_13_0_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = NULL;
 	uint32_t min_clk, max_clk;
@@ -1489,8 +1479,8 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
 		}
 
 		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
-		min_clk = single_dpm_table->min;
-		max_clk = single_dpm_table->max;
+		min_clk = SMU_DPM_TABLE_MIN(single_dpm_table);
+		max_clk = SMU_DPM_TABLE_MAX(single_dpm_table);
 
 		if (now < SMU_13_0_6_DSCLK_THRESHOLD) {
 			size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
@@ -1690,7 +1680,7 @@ static int smu_v13_0_6_force_clk_levels(struct smu_context *smu,
 					enum smu_clk_type type, uint32_t mask)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_dpm_table *single_dpm_table = NULL;
+	struct smu_dpm_table *single_dpm_table = NULL;
 	uint32_t soft_min_level, soft_max_level;
 	int ret = 0;
 
@@ -2156,10 +2146,8 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 {
 	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	struct smu_13_0_dpm_table *gfx_table =
-		&dpm_context->dpm_tables.gfx_table;
-	struct smu_13_0_dpm_table *uclk_table =
-		&dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *uclk_table = &dpm_context->dpm_tables.uclk_table;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	int ret;
 
@@ -2167,7 +2155,8 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 	if ((smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) &&
 	    (level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)) {
 		smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism, NULL);
-		pstate_table->gfxclk_pstate.curr.max = gfx_table->max;
+		pstate_table->gfxclk_pstate.curr.max =
+			SMU_DPM_TABLE_MAX(gfx_table);
 	}
 
 	switch (level) {
@@ -2175,24 +2164,32 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 		return 0;
 
 	case AMD_DPM_FORCED_LEVEL_AUTO:
-		if ((gfx_table->min != pstate_table->gfxclk_pstate.curr.min) ||
-		    (gfx_table->max != pstate_table->gfxclk_pstate.curr.max)) {
+		if ((SMU_DPM_TABLE_MIN(gfx_table) !=
+		     pstate_table->gfxclk_pstate.curr.min) ||
+		    (SMU_DPM_TABLE_MAX(gfx_table) !=
+		     pstate_table->gfxclk_pstate.curr.max)) {
 			ret = smu_v13_0_6_set_gfx_soft_freq_limited_range(
-				smu, gfx_table->min, gfx_table->max);
+				smu, SMU_DPM_TABLE_MIN(gfx_table),
+				SMU_DPM_TABLE_MAX(gfx_table));
 			if (ret)
 				return ret;
 
-			pstate_table->gfxclk_pstate.curr.min = gfx_table->min;
-			pstate_table->gfxclk_pstate.curr.max = gfx_table->max;
+			pstate_table->gfxclk_pstate.curr.min =
+				SMU_DPM_TABLE_MIN(gfx_table);
+			pstate_table->gfxclk_pstate.curr.max =
+				SMU_DPM_TABLE_MAX(gfx_table);
 		}
 
-		if (uclk_table->max != pstate_table->uclk_pstate.curr.max) {
+		if (SMU_DPM_TABLE_MAX(uclk_table) !=
+		    pstate_table->uclk_pstate.curr.max) {
 			/* Min UCLK is not expected to be changed */
 			ret = smu_v13_0_set_soft_freq_limited_range(
-				smu, SMU_UCLK, 0, uclk_table->max, false);
+				smu, SMU_UCLK, 0, SMU_DPM_TABLE_MAX(uclk_table),
+				false);
 			if (ret)
 				return ret;
-			pstate_table->uclk_pstate.curr.max = uclk_table->max;
+			pstate_table->uclk_pstate.curr.max =
+				SMU_DPM_TABLE_MAX(uclk_table);
 		}
 		smu_v13_0_reset_custom_level(smu);
 
@@ -2265,8 +2262,9 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
-		if (!max || (max < dpm_context->dpm_tables.gfx_table.min) ||
-		    (max > dpm_context->dpm_tables.gfx_table.max)) {
+		min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.gfx_table);
+		max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.gfx_table);
+		if (!max || (max < min_clk) || (max > max_clk)) {
 			dev_warn(
 				adev->dev,
 				"Invalid max frequency %d MHz specified for determinism\n",
@@ -2275,10 +2273,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 		}
 
 		/* Restore default min/max clocks and enable determinism */
-		min_clk = dpm_context->dpm_tables.gfx_table.min;
-		max_clk = dpm_context->dpm_tables.gfx_table.max;
 		ret = smu_v13_0_6_set_gfx_soft_freq_limited_range(smu, min_clk,
-								 max_clk);
+								  max_clk);
 		if (!ret) {
 			usleep_range(500, 1000);
 			ret = smu_cmn_send_smc_msg_with_param(
@@ -2320,14 +2316,14 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 				"Input parameter number not correct\n");
 			return -EINVAL;
 		}
-
+		min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.gfx_table);
+		max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.gfx_table);
 		if (input[0] == 0) {
-			if (input[1] < dpm_context->dpm_tables.gfx_table.min) {
+			if (input[1] < min_clk) {
 				dev_warn(
 					smu->adev->dev,
 					"Minimum GFX clk (%ld) MHz specified is less than the minimum allowed (%d) MHz\n",
-					input[1],
-					dpm_context->dpm_tables.gfx_table.min);
+					input[1], min_clk);
 				pstate_table->gfxclk_pstate.custom.min =
 					pstate_table->gfxclk_pstate.curr.min;
 				return -EINVAL;
@@ -2335,12 +2331,11 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 
 			pstate_table->gfxclk_pstate.custom.min = input[1];
 		} else if (input[0] == 1) {
-			if (input[1] > dpm_context->dpm_tables.gfx_table.max) {
+			if (input[1] > max_clk) {
 				dev_warn(
 					smu->adev->dev,
 					"Maximum GFX clk (%ld) MHz specified is greater than the maximum allowed (%d) MHz\n",
-					input[1],
-					dpm_context->dpm_tables.gfx_table.max);
+					input[1], max_clk);
 				pstate_table->gfxclk_pstate.custom.max =
 					pstate_table->gfxclk_pstate.curr.max;
 				return -EINVAL;
@@ -2364,18 +2359,18 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 				 "UCLK_LIMITS setting not supported!\n");
 			return -EOPNOTSUPP;
 		}
-
+		max_clk =
+			SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.uclk_table);
 		if (input[0] == 0) {
 			dev_info(smu->adev->dev,
 				 "Setting min UCLK level is not supported");
 			return -EINVAL;
 		} else if (input[0] == 1) {
-			if (input[1] > dpm_context->dpm_tables.uclk_table.max) {
+			if (input[1] > max_clk) {
 				dev_warn(
 					smu->adev->dev,
 					"Maximum UCLK (%ld) MHz specified is greater than the maximum allowed (%d) MHz\n",
-					input[1],
-					dpm_context->dpm_tables.uclk_table.max);
+					input[1], max_clk);
 				pstate_table->uclk_pstate.custom.max =
 					pstate_table->uclk_pstate.curr.max;
 				return -EINVAL;
@@ -2392,8 +2387,10 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			return -EINVAL;
 		} else {
 			/* Use the default frequencies for manual and determinism mode */
-			min_clk = dpm_context->dpm_tables.gfx_table.min;
-			max_clk = dpm_context->dpm_tables.gfx_table.max;
+			min_clk = SMU_DPM_TABLE_MIN(
+				&dpm_context->dpm_tables.gfx_table);
+			max_clk = SMU_DPM_TABLE_MAX(
+				&dpm_context->dpm_tables.gfx_table);
 
 			ret = smu_v13_0_6_set_soft_freq_limited_range(
 				smu, SMU_GFXCLK, min_clk, max_clk, false);
@@ -2401,8 +2398,10 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 			if (ret)
 				return ret;
 
-			min_clk = dpm_context->dpm_tables.uclk_table.min;
-			max_clk = dpm_context->dpm_tables.uclk_table.max;
+			min_clk = SMU_DPM_TABLE_MIN(
+				&dpm_context->dpm_tables.uclk_table);
+			max_clk = SMU_DPM_TABLE_MAX(
+				&dpm_context->dpm_tables.uclk_table);
 			ret = smu_v13_0_6_set_soft_freq_limited_range(
 				smu, SMU_UCLK, min_clk, max_clk, false);
 			if (ret)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 4e699d3ab1e3..8f664ef32570 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -578,11 +578,12 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
 	SkuTable_t *skutable = &driver_ppt->SkuTable;
-	struct smu_13_0_dpm_table *dpm_table;
+	struct smu_dpm_table *dpm_table;
 	int ret = 0;
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
+	dpm_table->clk_type = SMU_SOCCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_SOCCLK,
@@ -593,12 +594,11 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
+	dpm_table->clk_type = SMU_GFXCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_GFXCLK,
@@ -611,18 +611,16 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 			skutable->DriverReportedClocks.GameClockAc)) {
 			dpm_table->dpm_levels[dpm_table->count - 1].value =
 				skutable->DriverReportedClocks.GameClockAc;
-			dpm_table->max = skutable->DriverReportedClocks.GameClockAc;
 		}
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* uclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.uclk_table;
+	dpm_table->clk_type = SMU_UCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_UCLK,
@@ -633,12 +631,11 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* fclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.fclk_table;
+	dpm_table->clk_type = SMU_FCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_FCLK,
@@ -649,12 +646,11 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* vclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.vclk_table;
+	dpm_table->clk_type = SMU_VCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_VCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_VCLK,
@@ -665,12 +661,11 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* dclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dclk_table;
+	dpm_table->clk_type = SMU_DCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCLK_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_DCLK,
@@ -681,12 +676,11 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* dcefclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dcef_table;
+	dpm_table->clk_type = SMU_DCEFCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
 		ret = smu_v13_0_set_single_dpm_table(smu,
 						     SMU_DCEFCLK,
@@ -697,8 +691,6 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	return 0;
@@ -865,7 +857,7 @@ static int smu_v13_0_7_get_dpm_ultimate_freq(struct smu_context *smu,
 {
 	struct smu_13_0_dpm_context *dpm_context =
 		smu->smu_dpm.dpm_context;
-	struct smu_13_0_dpm_table *dpm_table;
+	struct smu_dpm_table *dpm_table;
 
 	switch (clk_type) {
 	case SMU_MCLK:
@@ -902,9 +894,9 @@ static int smu_v13_0_7_get_dpm_ultimate_freq(struct smu_context *smu,
 	}
 
 	if (min)
-		*min = dpm_table->min;
+		*min = SMU_DPM_TABLE_MIN(dpm_table);
 	if (max)
-		*max = dpm_table->max;
+		*max = SMU_DPM_TABLE_MAX(dpm_table);
 
 	return 0;
 }
@@ -1182,7 +1174,7 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
 	int i, curr_freq, size = *offset, start_offset = *offset;
-	struct smu_13_0_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table;
 	struct smu_13_0_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
 	int32_t min_value, max_value;
@@ -1237,7 +1229,7 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 			return ret;
 		}
 
-		if (single_dpm_table->is_fine_grained) {
+		if (single_dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED) {
 			/*
 			 * For fine grained dpms, there are only two dpm levels:
 			 *   - level 0 -> min clock freq
@@ -1977,7 +1969,7 @@ static int smu_v13_0_7_force_clk_levels(struct smu_context *smu,
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	struct smu_13_0_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table;
 	uint32_t soft_min_level, soft_max_level;
 	uint32_t min_freq, max_freq;
 	int ret = 0;
@@ -2023,7 +2015,7 @@ static int smu_v13_0_7_force_clk_levels(struct smu_context *smu,
 	case SMU_VCLK1:
 	case SMU_DCLK:
 	case SMU_DCLK1:
-		if (single_dpm_table->is_fine_grained) {
+		if (single_dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED) {
 			/* There is only 2 levels for fine grained DPM */
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
@@ -2288,18 +2280,12 @@ static int smu_v13_0_7_populate_umd_state_clk(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context =
 				smu->smu_dpm.dpm_context;
-	struct smu_13_0_dpm_table *gfx_table =
-				&dpm_context->dpm_tables.gfx_table;
-	struct smu_13_0_dpm_table *mem_table =
-				&dpm_context->dpm_tables.uclk_table;
-	struct smu_13_0_dpm_table *soc_table =
-				&dpm_context->dpm_tables.soc_table;
-	struct smu_13_0_dpm_table *vclk_table =
-				&dpm_context->dpm_tables.vclk_table;
-	struct smu_13_0_dpm_table *dclk_table =
-				&dpm_context->dpm_tables.dclk_table;
-	struct smu_13_0_dpm_table *fclk_table =
-				&dpm_context->dpm_tables.fclk_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *vclk_table = &dpm_context->dpm_tables.vclk_table;
+	struct smu_dpm_table *dclk_table = &dpm_context->dpm_tables.dclk_table;
+	struct smu_dpm_table *fclk_table = &dpm_context->dpm_tables.fclk_table;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -2307,38 +2293,39 @@ static int smu_v13_0_7_populate_umd_state_clk(struct smu_context *smu)
 	DriverReportedClocks_t driver_clocks =
 		pptable->SkuTable.DriverReportedClocks;
 
-	pstate_table->gfxclk_pstate.min = gfx_table->min;
+	pstate_table->gfxclk_pstate.min = SMU_DPM_TABLE_MIN(gfx_table);
 	if (driver_clocks.GameClockAc &&
-		(driver_clocks.GameClockAc < gfx_table->max))
+	    (driver_clocks.GameClockAc < SMU_DPM_TABLE_MAX(gfx_table)))
 		pstate_table->gfxclk_pstate.peak = driver_clocks.GameClockAc;
 	else
-		pstate_table->gfxclk_pstate.peak = gfx_table->max;
+		pstate_table->gfxclk_pstate.peak = SMU_DPM_TABLE_MAX(gfx_table);
 
-	pstate_table->uclk_pstate.min = mem_table->min;
-	pstate_table->uclk_pstate.peak = mem_table->max;
+	pstate_table->uclk_pstate.min = SMU_DPM_TABLE_MIN(mem_table);
+	pstate_table->uclk_pstate.peak = SMU_DPM_TABLE_MAX(mem_table);
 
-	pstate_table->socclk_pstate.min = soc_table->min;
-	pstate_table->socclk_pstate.peak = soc_table->max;
+	pstate_table->socclk_pstate.min = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->socclk_pstate.peak = SMU_DPM_TABLE_MAX(soc_table);
 
-	pstate_table->vclk_pstate.min = vclk_table->min;
-	pstate_table->vclk_pstate.peak = vclk_table->max;
+	pstate_table->vclk_pstate.min = SMU_DPM_TABLE_MIN(vclk_table);
+	pstate_table->vclk_pstate.peak = SMU_DPM_TABLE_MAX(vclk_table);
 
-	pstate_table->dclk_pstate.min = dclk_table->min;
-	pstate_table->dclk_pstate.peak = dclk_table->max;
+	pstate_table->dclk_pstate.min = SMU_DPM_TABLE_MIN(dclk_table);
+	pstate_table->dclk_pstate.peak = SMU_DPM_TABLE_MAX(dclk_table);
 
-	pstate_table->fclk_pstate.min = fclk_table->min;
-	pstate_table->fclk_pstate.peak = fclk_table->max;
+	pstate_table->fclk_pstate.min = SMU_DPM_TABLE_MIN(fclk_table);
+	pstate_table->fclk_pstate.peak = SMU_DPM_TABLE_MAX(fclk_table);
 
 	if (driver_clocks.BaseClockAc &&
-		driver_clocks.BaseClockAc < gfx_table->max)
+	    driver_clocks.BaseClockAc < SMU_DPM_TABLE_MAX(gfx_table))
 		pstate_table->gfxclk_pstate.standard = driver_clocks.BaseClockAc;
 	else
-		pstate_table->gfxclk_pstate.standard = gfx_table->max;
-	pstate_table->uclk_pstate.standard = mem_table->max;
-	pstate_table->socclk_pstate.standard = soc_table->min;
-	pstate_table->vclk_pstate.standard = vclk_table->min;
-	pstate_table->dclk_pstate.standard = dclk_table->min;
-	pstate_table->fclk_pstate.standard = fclk_table->min;
+		pstate_table->gfxclk_pstate.standard =
+			SMU_DPM_TABLE_MAX(gfx_table);
+	pstate_table->uclk_pstate.standard = SMU_DPM_TABLE_MAX(mem_table);
+	pstate_table->socclk_pstate.standard = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->vclk_pstate.standard = SMU_DPM_TABLE_MIN(vclk_table);
+	pstate_table->dclk_pstate.standard = SMU_DPM_TABLE_MIN(dclk_table);
+	pstate_table->fclk_pstate.standard = SMU_DPM_TABLE_MIN(fclk_table);
 
 	return 0;
 }
-- 
2.49.0

