Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF41FD111A8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2B710E35E;
	Mon,  1 Dec 2025 10:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xuxIDm5S";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24BBC10E359
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTLYwC5TLGzXJ/VmJCyPoKmgBrlRRKX1MwbfEw0jhTc3OaPG5/QmI17Ruusy9s+dKRlSv+b8ujD+FA5VxJ1sXCB6X5ncuKIojT90ls5OM1bijsTDl7O+G2hueW5fmQzN8gQcPdYBc3qf6PNnqgGeir77EPdXXHBtmRocSVLW21/SUP0bIWfd/CpBvSIu47jR70yxOTAfO9XTMbVrSMxysOu0kYYUPKaMJVQR0NLLvuEUq2ENLDfo9qAK8W4WAsBAfllMMqjqRySUeMe5wX9IXT21KjCqeHWdji18N7yO5CglKPK6DLa9H6kc95iRsUW2bLQXZLF8OxdUK+cfTtvX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTlGatqp/uedDrwE6XP7ylMTpBV6uuK3X6NezMxolYk=;
 b=X4HgOs1k+70/v4/MqU1cMcF0wUgOB0o3SHaPYO7QTRnZRsPuNnZPTWqXBBwLav39cGlCO5pAuRCOkDKsr1hbXTuTlhA+Cy6q5mw4vAlDjmtiq4sIHWLKF+Ze88OIRkDAfQgHfth6JbPXO+zhS5sh5wSp9ehMP3noz+mhdZCp+HT4GrjUZ9LS60iYT+/9HxMD30odPvpMFEKFyEKq0PKUORGkIByXR2/hidlur3dNYSPGIDCEv7HW3oGgud4aN7VB9f00+sdfKIhq75k0b8KXPMumw8hmxmDRi5orcZklCj73EUZfSGXtnTXhCtBAJvZxD920cftJxbdpNYsblnIWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTlGatqp/uedDrwE6XP7ylMTpBV6uuK3X6NezMxolYk=;
 b=xuxIDm5ST3gMLDFuRaGq13BZBj+7uITZoRqI8BUBTNOBFImPQw+9hfq6VqrjeZCN7tBnvh83AWRWzZYVXvxsDkNcZG6bUjQfqM7yZR8TU/Gl3r3D3JwiL+rd2hIICfj3P4afdG3NbUMgkdD+Oj+Z5tk90zYCMy9Xd+SeIlmfIcI=
Received: from CH0PR03CA0448.namprd03.prod.outlook.com (2603:10b6:610:10e::11)
 by DS5PPF5E0E7945E.namprd12.prod.outlook.com (2603:10b6:f:fc00::650)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:17 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::aa) by CH0PR03CA0448.outlook.office365.com
 (2603:10b6:610:10e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:14 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 02/17] drm/amd/pm: Use generic dpm table for SMUv11 SOCs
Date: Mon, 1 Dec 2025 15:33:15 +0530
Message-ID: <20251201101331.101584-3-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DS5PPF5E0E7945E:EE_
X-MS-Office365-Filtering-Correlation-Id: df8c154b-4b3b-4900-1977-08de30c2627f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uov/Mgfxx4nYLz1GizVVd8403KnSA5djRDkBrfkoghiwM2Y/m/h9KAjKnMSP?=
 =?us-ascii?Q?CsfesuV1K/OO6Newa3nismqyuuELu8aQh9oKM/kQrfQdjat7R6Y8vsNey7YT?=
 =?us-ascii?Q?ywmpdYFimYI8f3oaqzTZmzYcj2lsau2oCBVo24qYUrb9no0Wt6dawW6CYr4Z?=
 =?us-ascii?Q?9patGRfK3XA9umO9mXyIkDdqunEEnrxZ/bklqEco+vzMb1tuYcFlhifYZ0Yh?=
 =?us-ascii?Q?a+6Tuzr0lnto6swpwkk3UUNTmFMu3uPQAySaWL7TykDWzVK3iyIGpdx/1mmn?=
 =?us-ascii?Q?6d0Pfch1KZ9oJhFQJZRtDAUjB8ZA0zQPYqeQWHKfUgbFO2h6ap4eLb72Jehw?=
 =?us-ascii?Q?pk2VLBANd6fY1fNmThHXAhIN0KSJMn9gITWiN4nThykEeEiB9SxH7TIuv4ic?=
 =?us-ascii?Q?Spz/dMG0GVeCi8ec9ZhsYZznxyUI51LDHHGJORRWidZQYKPDYcXqQmBn5Lkz?=
 =?us-ascii?Q?PbcBQ+g0Yovye04SjYCZNNsA+ILeHqcAC4pSeHVRPvclW6ZLo7ZrK0PQWdyE?=
 =?us-ascii?Q?Ns4EBQPUhmpfv/ABblNRuORuCu2fVkrQF3D+o8aC2E3Sc4oaa5oqj5Bi6kNC?=
 =?us-ascii?Q?bZ12ISL9S0wLkK5NIy5/uHRGL7d1NP8ox15AQB5pZEYfMm26Dw1Zhf1LA+Pj?=
 =?us-ascii?Q?Gb59yxXCuE/YAylAsdMBS567WGEZwK7VOf0kqbdBkM1SRFw5h/J8aqtLsPmN?=
 =?us-ascii?Q?2ZUCOMLtT3kGuRCSViifU/UY6Xq/wpIT4x5s7/RPw0Uln7ViryDJcAgCqt1g?=
 =?us-ascii?Q?8YexLqoa545W5rFJ/WEYP8Cko61NBaRDfBTcNDeSaj4zD2cSqTeJHn0NeCRv?=
 =?us-ascii?Q?0RWh+tM83zcFHt6TZhR/Ifus1s9PIbuSOzcFxyyGraXbapmZ+J6hulHxHYyZ?=
 =?us-ascii?Q?hV2rpwDw9xEDb2aEKZWMfWjJ0yt/Y1xTomTVXvT4WE+rbP0q4zxGsN/BKSAF?=
 =?us-ascii?Q?pB9PgWlWyqnzIPR567EYLquux7o6Qmg2pWdx6JKFp6IdegyBQh8cfvorSJ11?=
 =?us-ascii?Q?hiLOVaDP/U8PHiBCXskji1JvFHKTlit4ML3IbSdQCQM/1HqtZEu+YpCLOx88?=
 =?us-ascii?Q?UtmvVuPK/+jartRO1/cP1ySS1mQt+WlNaM6XBe2k+tNCVK0bGq0N7CtadCtI?=
 =?us-ascii?Q?zAEu+VWKyLjCNHJ7Tb9VGC/Bk+QB5mY7PyMvkfoSLgp6JE5Xfr0OPJUw/ass?=
 =?us-ascii?Q?ulmJ6H6mzx3A96m171kq0M7PJFjWhGYD2ajs/m62KmHW/7GI47i7N+tVpoE2?=
 =?us-ascii?Q?2bF4B8nJlSQAFfTSHLNphQdKP3e6HLqdVtUnHcS7t6w5yxq/Y5VTMAALwywV?=
 =?us-ascii?Q?DUBmHlGROIPRggOAOYILrwKBAKL530VAbsEbQBzS8Gya26X5oaLGoWtBxLvF?=
 =?us-ascii?Q?fAPA/2Wn0bnLA+S59v/kBfvPrkagAPb35FqJSF4RVqMdBgfv8mQXxG9Nh6Eo?=
 =?us-ascii?Q?YOqPyMiQ3dMs8C4OK1MojfoPycH1xavB3DXMaL6QTp2KjjI/hjGlHT/uXT7q?=
 =?us-ascii?Q?GJH4UvBXNGbr7mSD6g+fGt1J9OXVjUk4dtXxgJk9uvS+QtyCyvv8Yyre22wS?=
 =?us-ascii?Q?ESOr8jyR73hTITT69fI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:16.6924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8c154b-4b3b-4900-1977-08de30c2627f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5E0E7945E
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

Remove SMUv11 specific DPM table and use the generic dpm table
structure.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  | 41 +++-----
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 57 +++++------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 90 ++++++++----------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 95 ++++++++-----------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 40 ++++----
 5 files changed, 136 insertions(+), 187 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index 56ae555bb52a..02c4072f57d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -53,7 +53,6 @@
 
 #define SMU11_TOOL_SIZE			0x19000
 
-#define MAX_DPM_LEVELS 16
 #define MAX_PCIE_CONF 2
 
 #define CTF_OFFSET_EDGE			5
@@ -80,18 +79,6 @@ struct smu_11_0_max_sustainable_clocks {
 	uint32_t soc_clock;
 };
 
-struct smu_11_0_dpm_clk_level {
-	bool				enabled;
-	uint32_t			value;
-};
-
-struct smu_11_0_dpm_table {
-	uint32_t			min;        /* MHz */
-	uint32_t			max;        /* MHz */
-	uint32_t			count;
-	bool				is_fine_grained;
-	struct smu_11_0_dpm_clk_level	dpm_levels[MAX_DPM_LEVELS];
-};
 
 struct smu_11_0_pcie_table {
 	uint8_t  pcie_gen[MAX_PCIE_CONF];
@@ -99,19 +86,19 @@ struct smu_11_0_pcie_table {
 };
 
 struct smu_11_0_dpm_tables {
-	struct smu_11_0_dpm_table        soc_table;
-	struct smu_11_0_dpm_table        gfx_table;
-	struct smu_11_0_dpm_table        uclk_table;
-	struct smu_11_0_dpm_table        eclk_table;
-	struct smu_11_0_dpm_table        vclk_table;
-	struct smu_11_0_dpm_table        vclk1_table;
-	struct smu_11_0_dpm_table        dclk_table;
-	struct smu_11_0_dpm_table        dclk1_table;
-	struct smu_11_0_dpm_table        dcef_table;
-	struct smu_11_0_dpm_table        pixel_table;
-	struct smu_11_0_dpm_table        display_table;
-	struct smu_11_0_dpm_table        phy_table;
-	struct smu_11_0_dpm_table        fclk_table;
+	struct smu_dpm_table             soc_table;
+	struct smu_dpm_table             gfx_table;
+	struct smu_dpm_table             uclk_table;
+	struct smu_dpm_table             eclk_table;
+	struct smu_dpm_table             vclk_table;
+	struct smu_dpm_table             vclk1_table;
+	struct smu_dpm_table             dclk_table;
+	struct smu_dpm_table             dclk1_table;
+	struct smu_dpm_table             dcef_table;
+	struct smu_dpm_table             pixel_table;
+	struct smu_dpm_table             display_table;
+	struct smu_dpm_table             phy_table;
+	struct smu_dpm_table             fclk_table;
 	struct smu_11_0_pcie_table       pcie_table;
 };
 
@@ -279,7 +266,7 @@ int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
 
 int smu_v11_0_set_single_dpm_table(struct smu_context *smu,
 				   enum smu_clk_type clk_type,
-				   struct smu_11_0_dpm_table *single_dpm_table);
+				   struct smu_dpm_table *single_dpm_table);
 
 int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4fff78da81ff..67d217f27264 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -362,79 +362,75 @@ static int arcturus_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
-	struct smu_11_0_dpm_table *dpm_table = NULL;
+	struct smu_dpm_table *dpm_table = NULL;
 	int ret = 0;
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
+	dpm_table->clk_type = SMU_SOCCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_SOCCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_SOCCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_SOCCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
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
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_GFXCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_GFXCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_GFXCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
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
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_UCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
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
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_FCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_FCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_FCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* XGMI PLPD is supported by 54.23.0 and onwards */
@@ -572,23 +568,20 @@ static int arcturus_populate_umd_state_clk(struct smu_context *smu)
 {
 	struct smu_11_0_dpm_context *dpm_context =
 				smu->smu_dpm.dpm_context;
-	struct smu_11_0_dpm_table *gfx_table =
-				&dpm_context->dpm_tables.gfx_table;
-	struct smu_11_0_dpm_table *mem_table =
-				&dpm_context->dpm_tables.uclk_table;
-	struct smu_11_0_dpm_table *soc_table =
-				&dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 
-	pstate_table->gfxclk_pstate.min = gfx_table->min;
-	pstate_table->gfxclk_pstate.peak = gfx_table->max;
+	pstate_table->gfxclk_pstate.min = SMU_DPM_TABLE_MIN(gfx_table);
+	pstate_table->gfxclk_pstate.peak = SMU_DPM_TABLE_MAX(gfx_table);
 
-	pstate_table->uclk_pstate.min = mem_table->min;
-	pstate_table->uclk_pstate.peak = mem_table->max;
+	pstate_table->uclk_pstate.min = SMU_DPM_TABLE_MIN(mem_table);
+	pstate_table->uclk_pstate.peak = SMU_DPM_TABLE_MAX(mem_table);
 
-	pstate_table->socclk_pstate.min = soc_table->min;
-	pstate_table->socclk_pstate.peak = soc_table->max;
+	pstate_table->socclk_pstate.min = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->socclk_pstate.peak = SMU_DPM_TABLE_MAX(soc_table);
 
 	if (gfx_table->count > ARCTURUS_UMD_PSTATE_GFXCLK_LEVEL &&
 	    mem_table->count > ARCTURUS_UMD_PSTATE_MCLK_LEVEL &&
@@ -613,7 +606,7 @@ static int arcturus_populate_umd_state_clk(struct smu_context *smu)
 
 static void arcturus_get_clk_table(struct smu_context *smu,
 				   struct pp_clock_levels_with_latency *clocks,
-				   struct smu_11_0_dpm_table *dpm_table)
+				   struct smu_dpm_table *dpm_table)
 {
 	uint32_t i;
 
@@ -802,7 +795,7 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 {
 	int ret = 0;
 	struct pp_clock_levels_with_latency clocks;
-	struct smu_11_0_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_11_0_dpm_context *dpm_context = NULL;
 	uint32_t gen_speed, lane_width;
@@ -1003,7 +996,7 @@ static int arcturus_force_clk_levels(struct smu_context *smu,
 			enum smu_clk_type type, uint32_t mask)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_11_0_dpm_table *single_dpm_table = NULL;
+	struct smu_dpm_table *single_dpm_table = NULL;
 	uint32_t soft_min_level, soft_max_level;
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 2ea33c41aadb..4ad59c107a33 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -967,169 +967,160 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
-	struct smu_11_0_dpm_table *dpm_table;
+	struct smu_dpm_table *dpm_table;
 	int ret = 0;
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
+	dpm_table->clk_type = SMU_SOCCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_SOCCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_SOCCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_SOCCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
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
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_GFXCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_GFXCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_GFXCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
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
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_UCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* vclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.vclk_table;
+	dpm_table->clk_type = SMU_VCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_VCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_VCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_VCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* dclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dclk_table;
+	dpm_table->clk_type = SMU_DCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_DCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_DCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* dcefclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dcef_table;
+	dpm_table->clk_type = SMU_DCEFCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DCEFCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_DCEFCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_DCEFCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* pixelclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.pixel_table;
+	dpm_table->clk_type = SMU_PIXCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_PIXCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_PIXCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_PIXCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* displayclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.display_table;
+	dpm_table->clk_type = SMU_DISPCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DISPCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_DISPCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_DISPCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* phyclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.phy_table;
+	dpm_table->clk_type = SMU_PHYCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_PHYCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_PHYCLK].SnapToDiscrete;
+		if (!driver_ppt->DpmDescriptor[PPCLK_PHYCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	return 0;
@@ -1519,18 +1510,15 @@ static int navi10_populate_umd_state_clk(struct smu_context *smu)
 {
 	struct smu_11_0_dpm_context *dpm_context =
 				smu->smu_dpm.dpm_context;
-	struct smu_11_0_dpm_table *gfx_table =
-				&dpm_context->dpm_tables.gfx_table;
-	struct smu_11_0_dpm_table *mem_table =
-				&dpm_context->dpm_tables.uclk_table;
-	struct smu_11_0_dpm_table *soc_table =
-				&dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t sclk_freq;
 
-	pstate_table->gfxclk_pstate.min = gfx_table->min;
+	pstate_table->gfxclk_pstate.min = SMU_DPM_TABLE_MIN(gfx_table);
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(11, 0, 0):
 		switch (adev->pdev->revision) {
@@ -1579,15 +1567,15 @@ static int navi10_populate_umd_state_clk(struct smu_context *smu)
 	}
 	pstate_table->gfxclk_pstate.peak = sclk_freq;
 
-	pstate_table->uclk_pstate.min = mem_table->min;
-	pstate_table->uclk_pstate.peak = mem_table->max;
+	pstate_table->uclk_pstate.min = SMU_DPM_TABLE_MIN(mem_table);
+	pstate_table->uclk_pstate.peak = SMU_DPM_TABLE_MAX(mem_table);
 
-	pstate_table->socclk_pstate.min = soc_table->min;
-	pstate_table->socclk_pstate.peak = soc_table->max;
+	pstate_table->socclk_pstate.min = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->socclk_pstate.peak = SMU_DPM_TABLE_MAX(soc_table);
 
-	if (gfx_table->max > NAVI10_UMD_PSTATE_PROFILING_GFXCLK &&
-	    mem_table->max > NAVI10_UMD_PSTATE_PROFILING_MEMCLK &&
-	    soc_table->max > NAVI10_UMD_PSTATE_PROFILING_SOCCLK) {
+	if (SMU_DPM_TABLE_MAX(gfx_table) > NAVI10_UMD_PSTATE_PROFILING_GFXCLK &&
+	    SMU_DPM_TABLE_MAX(mem_table) > NAVI10_UMD_PSTATE_PROFILING_MEMCLK &&
+	    SMU_DPM_TABLE_MAX(soc_table) > NAVI10_UMD_PSTATE_PROFILING_SOCCLK) {
 		pstate_table->gfxclk_pstate.standard =
 			NAVI10_UMD_PSTATE_PROFILING_GFXCLK;
 		pstate_table->uclk_pstate.standard =
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 1530a25f7237..1e47dd2d915e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -954,13 +954,14 @@ static int sienna_cichlid_init_smc_tables(struct smu_context *smu)
 static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_11_0_dpm_table *dpm_table;
+	struct smu_dpm_table *dpm_table;
 	struct amdgpu_device *adev = smu->adev;
 	int i, ret = 0;
 	DpmDescriptor_t *table_member;
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
+	dpm_table->clk_type = SMU_SOCCLK;
 	GET_PPTABLE_MEMBER(DpmDescriptor, &table_member);
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
@@ -968,68 +969,63 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!table_member[PPCLK_SOCCLK].SnapToDiscrete;
+		if (!table_member[PPCLK_SOCCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
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
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_GFXCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!table_member[PPCLK_GFXCLK].SnapToDiscrete;
+		if (!table_member[PPCLK_GFXCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
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
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_UCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!table_member[PPCLK_UCLK].SnapToDiscrete;
+		if (!table_member[PPCLK_UCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
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
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_FCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!table_member[PPCLK_FCLK].SnapToDiscrete;
+		if (!table_member[PPCLK_FCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* vclk0/1 dpm table setup */
@@ -1038,20 +1034,20 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 			continue;
 
 		dpm_table = &dpm_context->dpm_tables.vclk_table;
+		dpm_table->clk_type = i ? SMU_VCLK1 : SMU_VCLK;
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_v11_0_set_single_dpm_table(smu,
 							     i ? SMU_VCLK1 : SMU_VCLK,
 							     dpm_table);
 			if (ret)
 				return ret;
-			dpm_table->is_fine_grained =
-				!table_member[i ? PPCLK_VCLK_1 : PPCLK_VCLK_0].SnapToDiscrete;
+			if (!table_member[i ? PPCLK_VCLK_1 : PPCLK_VCLK_0]
+				     .SnapToDiscrete)
+				dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 		} else {
 			dpm_table->count = 1;
 			dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
 			dpm_table->dpm_levels[0].enabled = true;
-			dpm_table->min = dpm_table->dpm_levels[0].value;
-			dpm_table->max = dpm_table->dpm_levels[0].value;
 		}
 	}
 
@@ -1060,93 +1056,89 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 		dpm_table = &dpm_context->dpm_tables.dclk_table;
+		dpm_table->clk_type = i ? SMU_DCLK1 : SMU_DCLK;
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_v11_0_set_single_dpm_table(smu,
 							     i ? SMU_DCLK1 : SMU_DCLK,
 							     dpm_table);
 			if (ret)
 				return ret;
-			dpm_table->is_fine_grained =
-				!table_member[i ? PPCLK_DCLK_1 : PPCLK_DCLK_0].SnapToDiscrete;
+			if (!table_member[i ? PPCLK_DCLK_1 : PPCLK_DCLK_0]
+				     .SnapToDiscrete)
+				dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 		} else {
 			dpm_table->count = 1;
 			dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
 			dpm_table->dpm_levels[0].enabled = true;
-			dpm_table->min = dpm_table->dpm_levels[0].value;
-			dpm_table->max = dpm_table->dpm_levels[0].value;
 		}
 	}
 
 	/* dcefclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dcef_table;
+	dpm_table->clk_type = SMU_DCEFCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DCEFCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!table_member[PPCLK_DCEFCLK].SnapToDiscrete;
+		if (!table_member[PPCLK_DCEFCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* pixelclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.pixel_table;
+	dpm_table->clk_type = SMU_PIXCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_PIXCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!table_member[PPCLK_PIXCLK].SnapToDiscrete;
+		if (!table_member[PPCLK_PIXCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* displayclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.display_table;
+	dpm_table->clk_type = SMU_DISPCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DISPCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!table_member[PPCLK_DISPCLK].SnapToDiscrete;
+		if (!table_member[PPCLK_DISPCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	/* phyclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.phy_table;
+	dpm_table->clk_type = SMU_PHYCLK;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_PHYCLK,
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!table_member[PPCLK_PHYCLK].SnapToDiscrete;
+		if (!table_member[PPCLK_PHYCLK].SnapToDiscrete)
+			dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
 		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
 	return 0;
@@ -1486,24 +1478,21 @@ static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)
 {
 	struct smu_11_0_dpm_context *dpm_context =
 				smu->smu_dpm.dpm_context;
-	struct smu_11_0_dpm_table *gfx_table =
-				&dpm_context->dpm_tables.gfx_table;
-	struct smu_11_0_dpm_table *mem_table =
-				&dpm_context->dpm_tables.uclk_table;
-	struct smu_11_0_dpm_table *soc_table =
-				&dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	struct amdgpu_device *adev = smu->adev;
 
-	pstate_table->gfxclk_pstate.min = gfx_table->min;
-	pstate_table->gfxclk_pstate.peak = gfx_table->max;
+	pstate_table->gfxclk_pstate.min = SMU_DPM_TABLE_MIN(gfx_table);
+	pstate_table->gfxclk_pstate.peak = SMU_DPM_TABLE_MAX(gfx_table);
 
-	pstate_table->uclk_pstate.min = mem_table->min;
-	pstate_table->uclk_pstate.peak = mem_table->max;
+	pstate_table->uclk_pstate.min = SMU_DPM_TABLE_MIN(mem_table);
+	pstate_table->uclk_pstate.peak = SMU_DPM_TABLE_MAX(mem_table);
 
-	pstate_table->socclk_pstate.min = soc_table->min;
-	pstate_table->socclk_pstate.peak = soc_table->max;
+	pstate_table->socclk_pstate.min = SMU_DPM_TABLE_MIN(soc_table);
+	pstate_table->socclk_pstate.peak = SMU_DPM_TABLE_MAX(soc_table);
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(11, 0, 7):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b0d6487171d7..b8d9cc5fe3d1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1859,12 +1859,9 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 {
 	struct smu_11_0_dpm_context *dpm_context =
 				smu->smu_dpm.dpm_context;
-	struct smu_11_0_dpm_table *gfx_table =
-				&dpm_context->dpm_tables.gfx_table;
-	struct smu_11_0_dpm_table *mem_table =
-				&dpm_context->dpm_tables.uclk_table;
-	struct smu_11_0_dpm_table *soc_table =
-				&dpm_context->dpm_tables.soc_table;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	struct amdgpu_device *adev = smu->adev;
@@ -1876,22 +1873,22 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-		sclk_min = sclk_max = gfx_table->max;
-		mclk_min = mclk_max = mem_table->max;
-		socclk_min = socclk_max = soc_table->max;
+		sclk_min = sclk_max = SMU_DPM_TABLE_MAX(gfx_table);
+		mclk_min = mclk_max = SMU_DPM_TABLE_MAX(mem_table);
+		socclk_min = socclk_max = SMU_DPM_TABLE_MAX(soc_table);
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
-		sclk_min = sclk_max = gfx_table->min;
-		mclk_min = mclk_max = mem_table->min;
-		socclk_min = socclk_max = soc_table->min;
+		sclk_min = sclk_max = SMU_DPM_TABLE_MIN(gfx_table);
+		mclk_min = mclk_max = SMU_DPM_TABLE_MIN(mem_table);
+		socclk_min = socclk_max = SMU_DPM_TABLE_MIN(soc_table);
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
-		sclk_min = gfx_table->min;
-		sclk_max = gfx_table->max;
-		mclk_min = mem_table->min;
-		mclk_max = mem_table->max;
-		socclk_min = soc_table->min;
-		socclk_max = soc_table->max;
+		sclk_min = SMU_DPM_TABLE_MIN(gfx_table);
+		sclk_max = SMU_DPM_TABLE_MAX(gfx_table);
+		mclk_min = SMU_DPM_TABLE_MIN(mem_table);
+		mclk_max = SMU_DPM_TABLE_MAX(mem_table);
+		socclk_min = SMU_DPM_TABLE_MIN(soc_table);
+		socclk_max = SMU_DPM_TABLE_MAX(soc_table);
 		auto_level = true;
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
@@ -2028,7 +2025,7 @@ int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
 
 int smu_v11_0_set_single_dpm_table(struct smu_context *smu,
 				   enum smu_clk_type clk_type,
-				   struct smu_11_0_dpm_table *single_dpm_table)
+				   struct smu_dpm_table *single_dpm_table)
 {
 	int ret = 0;
 	uint32_t clk;
@@ -2054,11 +2051,6 @@ int smu_v11_0_set_single_dpm_table(struct smu_context *smu,
 
 		single_dpm_table->dpm_levels[i].value = clk;
 		single_dpm_table->dpm_levels[i].enabled = true;
-
-		if (i == 0)
-			single_dpm_table->min = clk;
-		else if (i == single_dpm_table->count - 1)
-			single_dpm_table->max = clk;
 	}
 
 	return 0;
-- 
2.49.0

