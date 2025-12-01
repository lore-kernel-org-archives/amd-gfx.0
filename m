Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE3CD116F9
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D68F510E373;
	Mon,  1 Dec 2025 10:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yG7hjsgZ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010001.outbound.protection.outlook.com
 [52.101.193.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E262F10E372
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4TRIvJfV0dDc2I08pIdvicuT7x2d+JFN2Nszb2kjBW87+Lfcx/SfzTVdByQbbVGawAQXoYfvTdmL0RI1FDA0yvJwHgDpYBxWf2ilSIDMYqjnt1e3cO+pOBV2w5a0WFANyJQNPKmBYeREq3sDPO6BWEqtooI5aIIdjhoEp2L4TJVzXhDQadNr+aaCLuG09X0CGDau3xY977LwgnoHgX39cUWnhYs8TThet6JjJGtPjBffL8KRgeIv1HtVMABXiTOVCL4Zr5dTcRdFG4TCxJe6Fqc4PRNm59khn+KVROzAB12lX5psljanKn1mfws5DAOYb8O+QHMeJy3jzkB2GAkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFvuxKq4C/9jYSExVNYvUFjdeoLW5X57+JNUricydP8=;
 b=mKuT3DryByi9c43OSJZMCuPeqF+qYtoae4719WkLFY+yIVYb+tOIxwPwrCjFjZkkFw/vCpgDc1joGrwLt/IDkvZADUM1yIyS9z9j4S00hRPtqIBI8QgfJznZvp6Lio1DRMn97maNQGF5rcvZlr8Vl8tru2Qwu8OMJBX/7d4X8uz22T1un/mA6DEju9hxwhGogTrkXp1eVid/eXqhvMrlB97uo7Q4mYp/OaWylKQRWGWeMPzWQIOApphCiTt9ydFKZfuS5itujQ9bPVXW39n/u8CvOsLDj4Bkxoz7PQ5RWBEbzmnCnvN/nzzbp4qKsRiVSaRBgYTKsbdG4ap6DEuYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFvuxKq4C/9jYSExVNYvUFjdeoLW5X57+JNUricydP8=;
 b=yG7hjsgZ9/6tYGFqayefSHom/kTH+uXGAqkO0wUJQ5EuHXZgVpCm8wBWPqpfvnPkd6aboMtDI//Tcm1fklkzCRiNHSsmibbafgZy1o+MaCMMsqKspLSzfyruSbLgrwhS7dByfdR2P8zJNnf2YjVb43reMrPANP7NnhFVbSTBnGs=
Received: from CH0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:b0::25)
 by DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:36 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::e4) by CH0PR03CA0020.outlook.office365.com
 (2603:10b6:610:b0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:34 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 13/17] drm/amd/pm: Use common helper for aldebaran dpm table
Date: Mon, 1 Dec 2025 15:33:26 +0530
Message-ID: <20251201101331.101584-14-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 58514079-eb58-4ba2-c314-08de30c26e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MfDE3ZBxJ1NFtMSverxRjBi36Ba4wXz+vdvxrjrqOOdSF0356NbF6BmdorXG?=
 =?us-ascii?Q?eFu/Bc9/E7A/Sm58ZWh2fw9Ih49hl37kIP2QHxWlDtcNEUHzAVuqiD/mSgtt?=
 =?us-ascii?Q?RbMp3zVZec4iq5/gq2ScbXPGeebhtqrM3gzmW+hHcUiHueSgmBdNVdd9OL+H?=
 =?us-ascii?Q?IB+mdQvaR6hJbAgbhwnOfxk7RhScQ+6/ex+3A7QFwCXdZT3ZW61z/xp4VO7G?=
 =?us-ascii?Q?ZNuhk/q5vohNzHcB3srAcMGYQmxperCiQsARWqOM06EwLy2gndgqhbVOthwE?=
 =?us-ascii?Q?qYG5Kw32ggjoZqx80SVkmosnd0UvvhOzo/y/X/kbFASV1fXjtBPKfoYWnMJ0?=
 =?us-ascii?Q?S/RMUNw0BY2dS6Pyz5a7OsqAX1IFZBtt1uc5JeZpPFSkMwVnNV9W7sAEmZCk?=
 =?us-ascii?Q?dIKPVrr7HMLKfMgPx3LWrHNIwZ0AyYorF3Yu2omSvAmYwmPkYUKyaZhEHLIP?=
 =?us-ascii?Q?6Ajeu3TT6IYeGKbxanvsMhGNx3GFTvBsRwEjV7v4UeXXtucmhBQPDAEnMCJ3?=
 =?us-ascii?Q?XT+SNgiXN8hLthSg4xWfN2WZbtSVfyA2TFYlB63lR121HanvvxtkKAkeWgc/?=
 =?us-ascii?Q?xm2hkyI826dWQow5lgW0slKzAu/3WITyp9peCchrgDjtPntAAsphGz38pQuD?=
 =?us-ascii?Q?3AX7U6r4tf7LXL9UBRVlTeTKbWxDtA2+bGUPX1Z/Es8PFa83sCvPLIj9dK3b?=
 =?us-ascii?Q?OSzAXv9Z/tUj6ix1zlt9zEQ1wwSjJl7Dnj2kmgwlf0REtBqNwCC/SO6PTdj3?=
 =?us-ascii?Q?xoV0pvGDxRrfw2sgyEI0uQNtSMpMrdxZuqotTJ+7Mfe7YWNl1r5+hfIXTOYj?=
 =?us-ascii?Q?jqHN30siQ9nihbqsNd79dNNP20T3VCv4zTojY4KbYBAX5Oe4Aqmjcdv+4ffE?=
 =?us-ascii?Q?GCKeWLHx//Lh5PKjv8B9fKVMiyUFCqCx3YUlNmMURyrviGlpgAAiSc6ffh3M?=
 =?us-ascii?Q?y06VAKSbLJ3dNFHc49ppYxeRBBWdprOUReSxUNE2IAzNWSf+4ssGSK0/mRa+?=
 =?us-ascii?Q?uH3H1uNfumdzj7BRGb5+ZsrHlBijS8+zV2jydgGf3uA7GQ2Sntmd99vafxhP?=
 =?us-ascii?Q?ZURY+H9x4gN4k3SGSqI0fg7V2j9DIHbBl84I1i6vXcb6ysnoN4q4bgX7w169?=
 =?us-ascii?Q?Hq+KZ/NO4+1dB4h3IwS5GM8qmOzCmZgqSTXET+UnaaxgnV3KIgxdMo7VrI7Y?=
 =?us-ascii?Q?zLwVuXEWkSIOTz5D+T8sdoOqbOMeX8WtirDPQrWTJveetLG0B9kym6yQVAam?=
 =?us-ascii?Q?oStcRnLUGvqkujCSOeUaWVwQfZIt15StpDuUZJlOlgXCsvMEe0sVzDxAsNg/?=
 =?us-ascii?Q?S8dhHi66Yq7aDUA9fyX2zgj4nU1GJdSpZuUbPikZ4l3ovw4krp2RzdHylFHe?=
 =?us-ascii?Q?lXIcZJu5bsOkuwq8BpwLKbYVXs1aFAi5wD6VU6ZM98BlI6KSZgJIIF6vJzBp?=
 =?us-ascii?Q?Mk8USWItWgIwAgKPPSyd3x5T34TpRohoTYU+pKR/AlFe1mjLShb3KeZ1MzaM?=
 =?us-ascii?Q?BDRtTWxWayb+ujvOVPO3HKyZBM+gvApTibO95QB3zA3QDBuQum4RZqr0rxcU?=
 =?us-ascii?Q?2QXoi8fqjd7gXfoUx6c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:36.0449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58514079-eb58-4ba2-c314-08de30c26e07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
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

Use helper function to print aldebaran dpm tables to sysfs. Remove
unused functions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 153 +++---------------
 1 file changed, 18 insertions(+), 135 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 07adbec5c169..a72aaf36c282 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -71,9 +71,6 @@
 			  FEATURE_MASK(FEATURE_DPM_XGMI_BIT)	| \
 			  FEATURE_MASK(FEATURE_DPM_VCN_BIT))
 
-/* possible frequency drift (1Mhz) */
-#define EPSILON				1
-
 #define smnPCIE_ESM_CTRL			0x111003D0
 
 /*
@@ -629,30 +626,6 @@ static int aldebaran_populate_umd_state_clk(struct smu_context *smu)
 	return 0;
 }
 
-static void aldebaran_get_clk_table(struct smu_context *smu,
-				    struct pp_clock_levels_with_latency *clocks,
-				    struct smu_dpm_table *dpm_table)
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
-
-}
-
-static int aldebaran_freqs_in_same_level(int32_t frequency1,
-					 int32_t frequency2)
-{
-	return (abs(frequency1 - frequency2) <= EPSILON);
-}
-
 static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 					  MetricsMember_t member,
 					  uint32_t *value)
@@ -819,16 +792,10 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 {
 	int ret = 0;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
-	struct pp_clock_levels_with_latency clocks;
-	struct smu_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table = NULL;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_13_0_dpm_context *dpm_context = NULL;
-	uint32_t i;
-	int display_levels;
-	uint32_t freq_values[3] = {0};
-	uint32_t min_clk, max_clk, cur_value = 0;
-	bool freq_match;
-	unsigned int clock_mhz;
+	uint32_t cur_value = 0;
 	static const char attempt_string[] = "Attempt to get current";
 
 	if (amdgpu_ras_intr_triggered()) {
@@ -839,134 +806,50 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 	dpm_context = smu_dpm->dpm_context;
 
 	switch (type) {
-
 	case SMU_OD_SCLK:
 		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_SCLK");
 		*offset += sysfs_emit_at(buf, *offset, "0: %uMhz\n1: %uMhz\n",
-				      pstate_table->gfxclk_pstate.curr.min,
-				      pstate_table->gfxclk_pstate.curr.max);
+					 pstate_table->gfxclk_pstate.curr.min,
+					 pstate_table->gfxclk_pstate.curr.max);
 		return 0;
-	case SMU_SCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &cur_value);
-		if (ret) {
-			dev_err(smu->adev->dev, "%s gfx clk Failed!", attempt_string);
-			return ret;
-		}
-
-		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
-		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
-
-		display_levels = (clocks.num_levels == 1) ? 1 : 2;
-
-		min_clk = pstate_table->gfxclk_pstate.curr.min;
-		max_clk = pstate_table->gfxclk_pstate.curr.max;
-
-		freq_values[0] = min_clk;
-		freq_values[1] = max_clk;
-
-		/* fine-grained dpm has only 2 levels */
-		if (cur_value > min_clk && cur_value < max_clk) {
-			display_levels++;
-			freq_values[2] = max_clk;
-			freq_values[1] = cur_value;
-		}
-		break;
-
 	case SMU_OD_MCLK:
 		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_MCLK");
 		*offset += sysfs_emit_at(buf, *offset, "0: %uMhz\n1: %uMhz\n",
-				      pstate_table->uclk_pstate.curr.min,
-				      pstate_table->uclk_pstate.curr.max);
+					 pstate_table->uclk_pstate.curr.min,
+					 pstate_table->uclk_pstate.curr.max);
 		return 0;
-	case SMU_MCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &cur_value);
-		if (ret) {
-			dev_err(smu->adev->dev, "%s mclk Failed!", attempt_string);
-			return ret;
-		}
 
+	case SMU_SCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
+		break;
+	case SMU_MCLK:
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
-		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
-
 	case SMU_SOCCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &cur_value);
-		if (ret) {
-			dev_err(smu->adev->dev, "%s socclk Failed!", attempt_string);
-			return ret;
-		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
-		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
-
 	case SMU_FCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_FCLK, &cur_value);
-		if (ret) {
-			dev_err(smu->adev->dev, "%s fclk Failed!", attempt_string);
-			return ret;
-		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
-		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
-
 	case SMU_VCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_VCLK, &cur_value);
-		if (ret) {
-			dev_err(smu->adev->dev, "%s vclk Failed!", attempt_string);
-			return ret;
-		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
-		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
-
 	case SMU_DCLK:
-		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_DCLK, &cur_value);
-		if (ret) {
-			dev_err(smu->adev->dev, "%s dclk Failed!", attempt_string);
-			return ret;
-		}
-
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
-		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 		break;
-
 	default:
 		return -EINVAL;
 	}
 
-	switch (type) {
-	case SMU_SCLK:
-		for (i = 0; i < display_levels; i++) {
-			clock_mhz = freq_values[i];
-			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (display_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
-				clock_mhz,
-				(freq_match) ? "*" : "");
-		}
-		break;
-
-	case SMU_MCLK:
-	case SMU_SOCCLK:
-	case SMU_FCLK:
-	case SMU_VCLK:
-	case SMU_DCLK:
-		for (i = 0; i < clocks.num_levels; i++) {
-			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
-			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (clocks.num_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, clock_mhz,
-				(freq_match) ? "*" : "");
+	if (single_dpm_table) {
+		ret = aldebaran_get_current_clk_freq_by_table(smu, type,
+							      &cur_value);
+		if (ret) {
+			dev_err(smu->adev->dev, "%s Failed!", attempt_string);
+			return ret;
 		}
-		break;
-	default:
-		return -EINVAL;
+		return smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						    cur_value, buf, offset);
 	}
 
 	return 0;
-- 
2.49.0

