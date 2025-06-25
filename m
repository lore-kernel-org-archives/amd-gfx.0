Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AE0C7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C702E10E658;
	Wed, 25 Jun 2025 04:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hJRkwTMH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05B310E655
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:05:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfGPTwnBfu0ROqzaHwl6esfMYSYD4y4gXCJxDPqMY6uCDH7WgUVpAq7rrpAvqjjBjIucuEjixfIwp8s+6cWWIb0EJ/LSNrpeIrtwO6oiJLdMF/y48c6jCmfMYM203YW3GRYINpgK9bXIPnDz52o4mchR1Vjd2bXSDnglHmSunv6mJpXgdgrl423BMR5K+mcLv2NXt9I9xnUI+bPyFUKUsd+mjH5jwKA10OVjxhrv2tr9l5PAW9k+udS5kuLTil9qKp9ldPm8KZjh1NkOAG8MDeXX4hUKHBiCpsCFoiQeAA8r4T7Yjlxso794jVrlat5N55m5dttX7GTugTShEpTtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOqLXQ8Skosvi1Yj4xf8/WqRiwgkaA9M8sZJMN1WH3k=;
 b=CwJEcne9JnhE2rG8J+3LQYCXEAjkT4M9XWtfwYI5ZdNz5Mj8p9MS/nMW6PVspORXAhIlZxCdfKy8snA4h/qp6ULwkBrCjf0S8+RDGWuLrqJl/r84uxeuGS3yevKTYAbfUniuKJGWxuzgmnvqqIZQw90uX1h+PoVOLxruWAud1gdjFYWocyB+aGxmuFuJRjKcsFdGdYnF9quOenZquoBQ4ZC5D45OXDPbgkINvNgNIKpNtvoaObLCoAp3VF6MXwQ4srBzHerWxNe7fOSXVxFWE49ky0emyypSKY7dMpGGd7KQRNTzRnPQTDd/lzmHfHpg9+v3oCbhaMYRbYFamArjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOqLXQ8Skosvi1Yj4xf8/WqRiwgkaA9M8sZJMN1WH3k=;
 b=hJRkwTMHfme5OjMtSFlwnn4THubuatsaSwpn2vwjhHiHpY4qlqrgbj46Dhuq+SEwgqwvMIa3LKu9S9XxZkZcISnvVvGr7X/oM2DoZI1yAixfJ5RocSrLV1GFuIf64NcK1p/8DC8slfBvuepXKbyLzIJ8KGiPScT9l9NvS8S6hLg=
Received: from DM6PR02CA0121.namprd02.prod.outlook.com (2603:10b6:5:1b4::23)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 04:05:30 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::5) by DM6PR02CA0121.outlook.office365.com
 (2603:10b6:5:1b4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 04:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:05:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:29 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:25 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Austin Zheng <austin.zheng@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 04/11] drm/amd/display: Refactor DML21 Initialization and
 Configuration
Date: Wed, 25 Jun 2025 12:02:22 +0800
Message-ID: <20250625040420.886013-5-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625040420.886013-1-ray.wu@amd.com>
References: <20250625040420.886013-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: eb433b13-48b1-4f8b-e05c-08ddb39d8666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+aZTyJiZ13ixh1YJcqnu4HjowvdZSIaSy3QosQBB8zPBxj22Bsgs9jhxHGpM?=
 =?us-ascii?Q?utGut3hrDnOX6HBoSoccwt7XxU15/DtPT/JxlPHhOM3r8xedf1OaC4gHQaZZ?=
 =?us-ascii?Q?aJF5LOk5b21vQSyvTJRFu33vkN41z2KE/iLhKy49/UZB05Ne0NdEzvu1cuYJ?=
 =?us-ascii?Q?7PMvD6weK2kEfUMuEvIyEg5JBbF3e+mZbYtinf8HiDHbnjEKngJO2RXIXg3p?=
 =?us-ascii?Q?Fkvy+So8jn4BgKG1wi3MRpcDLgH0d7BzNptvhT2enREVx+UsyEY8ZqtGLUi5?=
 =?us-ascii?Q?0Zix6RBP8HlZI+zO/JZsoVqifkNNd9wW8Gtd9ggYzwqd8WmDvGpeTYZywscv?=
 =?us-ascii?Q?dZNDjkIdHAJY7BWLgi9fICvvndZ4Q/47sQe7z3WaPwYfVrsqcJ5LIccmETIV?=
 =?us-ascii?Q?IhAKaTU9xUZMexHx2ytY0hwQpVIA+xrPfH3ZYWmNTHSf7JM7KR9OXCwJMoeA?=
 =?us-ascii?Q?yCmIqt0sx185LIx3+Krnt2N+K2S7Nb32eCfybqMcghU4kQHjaCvNmxY3ltlv?=
 =?us-ascii?Q?6sJyZUsNIZbkeRUGaCKxT4MnASgZu9nSJv3avD6o5BMWcCYmTVf8r5FugheB?=
 =?us-ascii?Q?BGbx0LXbgqTvGoYmGCGtJWnvdwNHmeAS2jRTHiCe9IZ1dFHM5Ygeq/XRO+g6?=
 =?us-ascii?Q?0IaRDveJAG6jhHg4Kz9NSqnYAOIkVQWpA4sJBcwovzEepJmQTzlUFu7Y3rry?=
 =?us-ascii?Q?smKPUoQcD7/rptI/EJTR8JSnwzx6ZlqFnyeV2jpMdyUOKvHzrBxxJXDkJ7Js?=
 =?us-ascii?Q?A2HE4IjTKwqdktBO5HaRFZSqAZZmjmB5u3JrXsjB86lK8LzYe3MzrnaL7I31?=
 =?us-ascii?Q?Fmy6732BjiIyfNddEyy0EFZeBYnRzt4tkIemfV4QhjrH3P4vUUNT19Cp5tbD?=
 =?us-ascii?Q?RqoxnJ8TItiYro/qhOMW9j35jsaW44qOF0zfoFGwTymtTi73hs0MWSLpHbC5?=
 =?us-ascii?Q?YLsYf4dSi/wzSSNl7WJcrEkQ63onN3SLyuBVXBVtH3+lj8BNXkBA8OX7mKzj?=
 =?us-ascii?Q?uHZ4fj1MmqsAjFmWEgI27zRX67++kAsY1rxI5+Cqaucw44sfoLGfADwUx7za?=
 =?us-ascii?Q?tZPKztfD9YzwLc5G9iaIE95ZYb6OpyYBHFYpcQWdcIP7RKYD2mWfR/nZtSEp?=
 =?us-ascii?Q?Uul6UPbQigrkXCsHY8MJkkO4rYdi/mt8eZeuLbu/shT6fdGN9OEHw9Cs3Mi1?=
 =?us-ascii?Q?PRF5gtoiVNMPjyYG6VKWPc6DRx9laF6gccfpwZQ9BCInQu3/SA5TtsrOl4+Z?=
 =?us-ascii?Q?La3aSoq9mf6TY5iVW7HT2kFGwsCAraIH0bVEF0F564AArNNOTDkt616uaICw?=
 =?us-ascii?Q?mez6QdEDx31rva3gs5xuZLNuSTWLTY30BjxlR+HSsw6zZAqaorG2HSigVdsl?=
 =?us-ascii?Q?Wq2ttNlnoZcA0qXwnjBezOIwylGals3/1gPMnwwJtHM9y4HT6CbNBIzUcKEC?=
 =?us-ascii?Q?JTSW7lLmF9wZp/4CCOkuxZZw56WReaUHwXMR++nuC6FnCmlZOYeCP5dYGABo?=
 =?us-ascii?Q?Kv8bix2VnGLvlW2K11RHfySgF64avAagszpq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:05:30.1816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb433b13-48b1-4f8b-e05c-08ddb39d8666
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why & How]
- Consolidated the initialization of DML21 parameters into a single
function `dml21_populate_dml_init_params` to streamline the process
and improve code readability.
- Updated the function signatures in the header files to reflect changes
in parameter passing for DML context.
- Removed redundant debug option handling and integrated it into the new
configuration population function.
- Adjusted the DML21 initialization logic in the wrapper to accommodate
the new structure, ensuring compatibility with different DCN versions.
- Enhanced the handling of clock parameters and bounding box configurations
from various sources, including hardware defaults and software policies.
- Improved the clarity of the code by renaming functions and variables for
better understanding of their purposes.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dc/dml2/dml21/dml21_translation_helper.c  | 512 ++++++++++--------
 .../dc/dml2/dml21/dml21_translation_helper.h  |   4 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |  58 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.h |   2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  12 +-
 5 files changed, 306 insertions(+), 282 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 42bc6e4cf509..a06217a9eef6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -2,7 +2,6 @@
 //
 // Copyright 2024 Advanced Micro Devices, Inc.
 
-
 #include "dml21_wrapper.h"
 #include "dml2_core_dcn4_calcs.h"
 #include "dml2_internal_shared_types.h"
@@ -11,286 +10,263 @@
 #include "dml21_translation_helper.h"
 #include "bounding_boxes/dcn4_soc_bb.h"
 
-static void dml21_apply_dmub_bb_params(struct dml2_soc_bb *soc_bb, const void *dmub_bb_params, const struct dc *in_dc)
-{
-	switch (in_dc->ctx->dce_version) {
-	case DCN_VERSION_4_01:
-	default:
-		break;
-	}
-}
-
-static void dml21_init_socbb_params(struct dml2_initialize_instance_in_out *dml_init,
-		const struct dml2_configuration_options *config,
-		const struct dc *in_dc)
-{
-	const struct dml2_soc_bb *soc_bb;
-	const struct dml2_soc_qos_parameters *qos_params;
-
-	switch (in_dc->ctx->dce_version) {
-	case DCN_VERSION_4_01:
-	default:
-		soc_bb = &dml2_socbb_dcn401;
-
-		qos_params = &dml_dcn4_variant_a_soc_qos_params;
-	}
-
-	/* patch soc bb */
-	memcpy(&dml_init->soc_bb, soc_bb, sizeof(struct dml2_soc_bb));
-
-	if (config->bb_from_dmub)
-		dml21_apply_dmub_bb_params(&dml_init->soc_bb, config->bb_from_dmub, in_dc);
-
-	/* patch qos params */
-	memcpy(&dml_init->soc_bb.qos_parameters, qos_params, sizeof(struct dml2_soc_qos_parameters));
-}
-
-static void dml21_external_socbb_params(struct dml2_initialize_instance_in_out *dml_init,
-		const struct dml2_configuration_options *config)
-{
-	memcpy(&dml_init->soc_bb, &config->external_socbb_ip_params->soc_bb, sizeof(struct dml2_soc_bb));
-}
-
-static void dml21_external_ip_params(struct dml2_initialize_instance_in_out *dml_init,
+static void dml21_populate_pmo_options(struct dml2_pmo_options *pmo_options,
+		const struct dc *in_dc,
 		const struct dml2_configuration_options *config)
 {
-	memcpy(&dml_init->ip_caps, &config->external_socbb_ip_params->ip_params, sizeof(struct dml2_ip_capabilities));
+	bool disable_fams2 = !in_dc->debug.fams2_config.bits.enable;
+
+	/* ODM options */
+	pmo_options->disable_dyn_odm = !config->minimize_dispclk_using_odm;
+	pmo_options->disable_dyn_odm_for_multi_stream = true;
+	pmo_options->disable_dyn_odm_for_stream_with_svp = true;
+
+	pmo_options->disable_vblank = ((in_dc->debug.dml21_disable_pstate_method_mask >> 1) & 1);
+
+	/* NOTE: DRR and SubVP Require FAMS2 */
+	pmo_options->disable_svp = ((in_dc->debug.dml21_disable_pstate_method_mask >> 2) & 1) ||
+			in_dc->debug.force_disable_subvp ||
+			disable_fams2;
+	pmo_options->disable_drr_clamped = ((in_dc->debug.dml21_disable_pstate_method_mask >> 3) & 1) ||
+			disable_fams2;
+	pmo_options->disable_drr_var = ((in_dc->debug.dml21_disable_pstate_method_mask >> 4) & 1) ||
+			disable_fams2;
+	pmo_options->disable_fams2 = disable_fams2;
+
+	pmo_options->disable_drr_var_when_var_active = in_dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE ||
+			in_dc->debug.disable_fams_gaming == INGAME_FAMS_MULTI_DISP_CLAMPED_ONLY;
+	pmo_options->disable_drr_clamped_when_var_active = in_dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE;
 }
 
-static void dml21_init_ip_params(struct dml2_initialize_instance_in_out *dml_init,
+/*
+ * Populate dml_init based on default static values in soc bb. The default
+ * values are for reference and support at least minimal operation of current
+ * SoC and DCN hardware. The values could be modifed by subsequent override
+ * functions to reflect our true hardware capability.
+ */
+static void populate_default_dml_init_params(struct dml2_initialize_instance_in_out *dml_init,
 		const struct dml2_configuration_options *config,
 		const struct dc *in_dc)
 {
-	const struct dml2_ip_capabilities *ip_caps;
-
 	switch (in_dc->ctx->dce_version) {
 	case DCN_VERSION_4_01:
+		dml_init->options.project_id = dml2_project_dcn4x_stage2_auto_drr_svp;
+		dml21_populate_pmo_options(&dml_init->options.pmo_options, in_dc, config);
+		dml_init->soc_bb = dml2_socbb_dcn401;
+		dml_init->soc_bb.qos_parameters = dml_dcn4_variant_a_soc_qos_params;
+		dml_init->ip_caps = dml2_dcn401_max_ip_caps;
+		break;
 	default:
-		ip_caps = &dml2_dcn401_max_ip_caps;
+		memset(dml_init, 0, sizeof(*dml_init));
+		DC_ERR("unsupported dcn version for DML21!");
+		return;
 	}
-
-	memcpy(&dml_init->ip_caps, ip_caps, sizeof(struct dml2_ip_capabilities));
 }
 
-void dml21_initialize_soc_bb_params(struct dml2_initialize_instance_in_out *dml_init,
+static void override_dml_init_with_values_from_hardware_default(struct dml2_initialize_instance_in_out *dml_init,
 		const struct dml2_configuration_options *config,
 		const struct dc *in_dc)
 {
-	if (config->use_native_soc_bb_construction)
-		dml21_init_socbb_params(dml_init, config, in_dc);
-	else
-		dml21_external_socbb_params(dml_init, config);
+	dml_init->soc_bb.dchub_refclk_mhz = in_dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
+	dml_init->soc_bb.dprefclk_mhz = in_dc->clk_mgr->dprefclk_khz / 1000;
+	dml_init->soc_bb.dispclk_dppclk_vco_speed_mhz = in_dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 }
 
-void dml21_initialize_ip_params(struct dml2_initialize_instance_in_out *dml_init,
+/*
+ * SMU stands for System Management Unit. It is a power management processor.
+ * It owns the initialization of dc's clock table and programming of clock values
+ * based on dc's requests.
+ * Our clock values in base soc bb is a dummy placeholder. The real clock values
+ * are retrieved from SMU firmware to dc clock table at runtime.
+ * This function overrides our dummy placeholder values with real values in dc
+ * clock table.
+ */
+static void override_dml_init_with_values_from_smu(
+		struct dml2_initialize_instance_in_out *dml_init,
 		const struct dml2_configuration_options *config,
 		const struct dc *in_dc)
-{
-	if (config->use_native_soc_bb_construction)
-		dml21_init_ip_params(dml_init, config, in_dc);
-	else
-		dml21_external_ip_params(dml_init, config);
-}
-
-void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_init,
-		const struct dml2_configuration_options *config, const struct dc *in_dc)
 {
 	int i;
-
 	const struct clk_bw_params *dc_bw_params = in_dc->clk_mgr->bw_params;
 	const struct clk_limit_table *dc_clk_table = &dc_bw_params->clk_table;
-	struct dml2_soc_bb *dml_soc_bb = &dml_init->soc_bb;
-	struct dml2_soc_state_table *dml_clk_table = &dml_soc_bb->clk_table;
-
-	/* override clocks if smu is present */
-	if (in_dc->clk_mgr->funcs->is_smu_present && in_dc->clk_mgr->funcs->is_smu_present(in_dc->clk_mgr)) {
-		/* dcfclk */
-		if (dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
-			dml_clk_table->dcfclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
-			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-				if (i < dml_clk_table->dcfclk.num_clk_values) {
-					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dcfclk_mhz &&
-							dc_clk_table->entries[i].dcfclk_mhz > dc_bw_params->dc_mode_limit.dcfclk_mhz) {
-						if (i == 0 || dc_clk_table->entries[i-1].dcfclk_mhz < dc_bw_params->dc_mode_limit.dcfclk_mhz) {
-							dml_clk_table->dcfclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dcfclk_mhz * 1000;
-							dml_clk_table->dcfclk.num_clk_values = i + 1;
-						} else {
-							dml_clk_table->dcfclk.clk_values_khz[i] = 0;
-							dml_clk_table->dcfclk.num_clk_values = i;
-						}
+	struct dml2_soc_state_table *dml_clk_table = &dml_init->soc_bb.clk_table;
+
+	if (!in_dc->clk_mgr->funcs->is_smu_present ||
+			!in_dc->clk_mgr->funcs->is_smu_present(in_dc->clk_mgr))
+		/* skip if smu is not present */
+		return;
+
+	/* dcfclk */
+	if (dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
+		dml_clk_table->dcfclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->dcfclk.num_clk_values) {
+				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dcfclk_mhz &&
+						dc_clk_table->entries[i].dcfclk_mhz > dc_bw_params->dc_mode_limit.dcfclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].dcfclk_mhz < dc_bw_params->dc_mode_limit.dcfclk_mhz) {
+						dml_clk_table->dcfclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dcfclk_mhz * 1000;
+						dml_clk_table->dcfclk.num_clk_values = i + 1;
 					} else {
-						dml_clk_table->dcfclk.clk_values_khz[i] = dc_clk_table->entries[i].dcfclk_mhz * 1000;
+						dml_clk_table->dcfclk.clk_values_khz[i] = 0;
+						dml_clk_table->dcfclk.num_clk_values = i;
 					}
 				} else {
-					dml_clk_table->dcfclk.clk_values_khz[i] = 0;
+					dml_clk_table->dcfclk.clk_values_khz[i] = dc_clk_table->entries[i].dcfclk_mhz * 1000;
 				}
+			} else {
+				dml_clk_table->dcfclk.clk_values_khz[i] = 0;
 			}
 		}
+	}
 
-		/* fclk */
-		if (dc_clk_table->num_entries_per_clk.num_fclk_levels) {
-			dml_clk_table->fclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_fclk_levels;
-			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-				if (i < dml_clk_table->fclk.num_clk_values) {
-					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.fclk_mhz &&
-							dc_clk_table->entries[i].fclk_mhz > dc_bw_params->dc_mode_limit.fclk_mhz) {
-						if (i == 0 || dc_clk_table->entries[i-1].fclk_mhz < dc_bw_params->dc_mode_limit.fclk_mhz) {
-							dml_clk_table->fclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.fclk_mhz * 1000;
-							dml_clk_table->fclk.num_clk_values = i + 1;
-						} else {
-							dml_clk_table->fclk.clk_values_khz[i] = 0;
-							dml_clk_table->fclk.num_clk_values = i;
-						}
+	/* fclk */
+	if (dc_clk_table->num_entries_per_clk.num_fclk_levels) {
+		dml_clk_table->fclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_fclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->fclk.num_clk_values) {
+				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.fclk_mhz &&
+						dc_clk_table->entries[i].fclk_mhz > dc_bw_params->dc_mode_limit.fclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].fclk_mhz < dc_bw_params->dc_mode_limit.fclk_mhz) {
+						dml_clk_table->fclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.fclk_mhz * 1000;
+						dml_clk_table->fclk.num_clk_values = i + 1;
 					} else {
-						dml_clk_table->fclk.clk_values_khz[i] = dc_clk_table->entries[i].fclk_mhz * 1000;
+						dml_clk_table->fclk.clk_values_khz[i] = 0;
+						dml_clk_table->fclk.num_clk_values = i;
 					}
 				} else {
-					dml_clk_table->fclk.clk_values_khz[i] = 0;
+					dml_clk_table->fclk.clk_values_khz[i] = dc_clk_table->entries[i].fclk_mhz * 1000;
 				}
+			} else {
+				dml_clk_table->fclk.clk_values_khz[i] = 0;
 			}
 		}
+	}
 
-		/* uclk */
-		if (dc_clk_table->num_entries_per_clk.num_memclk_levels) {
-			dml_clk_table->uclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_memclk_levels;
-			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-				if (i < dml_clk_table->uclk.num_clk_values) {
-					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.memclk_mhz &&
-							dc_clk_table->entries[i].memclk_mhz > dc_bw_params->dc_mode_limit.memclk_mhz) {
-						if (i == 0 || dc_clk_table->entries[i-1].memclk_mhz < dc_bw_params->dc_mode_limit.memclk_mhz) {
-							dml_clk_table->uclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.memclk_mhz * 1000;
-							dml_clk_table->uclk.num_clk_values = i + 1;
-						} else {
-							dml_clk_table->uclk.clk_values_khz[i] = 0;
-							dml_clk_table->uclk.num_clk_values = i;
-						}
+	/* uclk */
+	if (dc_clk_table->num_entries_per_clk.num_memclk_levels) {
+		dml_clk_table->uclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_memclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->uclk.num_clk_values) {
+				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.memclk_mhz &&
+						dc_clk_table->entries[i].memclk_mhz > dc_bw_params->dc_mode_limit.memclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].memclk_mhz < dc_bw_params->dc_mode_limit.memclk_mhz) {
+						dml_clk_table->uclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.memclk_mhz * 1000;
+						dml_clk_table->uclk.num_clk_values = i + 1;
 					} else {
-						dml_clk_table->uclk.clk_values_khz[i] = dc_clk_table->entries[i].memclk_mhz * 1000;
+						dml_clk_table->uclk.clk_values_khz[i] = 0;
+						dml_clk_table->uclk.num_clk_values = i;
 					}
 				} else {
-					dml_clk_table->uclk.clk_values_khz[i] = 0;
+					dml_clk_table->uclk.clk_values_khz[i] = dc_clk_table->entries[i].memclk_mhz * 1000;
 				}
+			} else {
+				dml_clk_table->uclk.clk_values_khz[i] = 0;
 			}
 		}
+	}
 
-		/* dispclk */
-		if (dc_clk_table->num_entries_per_clk.num_dispclk_levels) {
-			dml_clk_table->dispclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dispclk_levels;
-			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-				if (i < dml_clk_table->dispclk.num_clk_values) {
-					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dispclk_mhz &&
-							dc_clk_table->entries[i].dispclk_mhz > dc_bw_params->dc_mode_limit.dispclk_mhz) {
-						if (i == 0 || dc_clk_table->entries[i-1].dispclk_mhz < dc_bw_params->dc_mode_limit.dispclk_mhz) {
-							dml_clk_table->dispclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dispclk_mhz * 1000;
-							dml_clk_table->dispclk.num_clk_values = i + 1;
-						} else {
-							dml_clk_table->dispclk.clk_values_khz[i] = 0;
-							dml_clk_table->dispclk.num_clk_values = i;
-						}
+	/* dispclk */
+	if (dc_clk_table->num_entries_per_clk.num_dispclk_levels) {
+		dml_clk_table->dispclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dispclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->dispclk.num_clk_values) {
+				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dispclk_mhz &&
+						dc_clk_table->entries[i].dispclk_mhz > dc_bw_params->dc_mode_limit.dispclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].dispclk_mhz < dc_bw_params->dc_mode_limit.dispclk_mhz) {
+						dml_clk_table->dispclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dispclk_mhz * 1000;
+						dml_clk_table->dispclk.num_clk_values = i + 1;
 					} else {
-						dml_clk_table->dispclk.clk_values_khz[i] = dc_clk_table->entries[i].dispclk_mhz * 1000;
+						dml_clk_table->dispclk.clk_values_khz[i] = 0;
+						dml_clk_table->dispclk.num_clk_values = i;
 					}
 				} else {
-					dml_clk_table->dispclk.clk_values_khz[i] = 0;
+					dml_clk_table->dispclk.clk_values_khz[i] = dc_clk_table->entries[i].dispclk_mhz * 1000;
 				}
+			} else {
+				dml_clk_table->dispclk.clk_values_khz[i] = 0;
 			}
 		}
+	}
 
-		/* dppclk */
-		if (dc_clk_table->num_entries_per_clk.num_dppclk_levels) {
-			dml_clk_table->dppclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dppclk_levels;
-			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-				if (i < dml_clk_table->dppclk.num_clk_values) {
-					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dppclk_mhz &&
-							dc_clk_table->entries[i].dppclk_mhz > dc_bw_params->dc_mode_limit.dppclk_mhz) {
-						if (i == 0 || dc_clk_table->entries[i-1].dppclk_mhz < dc_bw_params->dc_mode_limit.dppclk_mhz) {
-							dml_clk_table->dppclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dppclk_mhz * 1000;
-							dml_clk_table->dppclk.num_clk_values = i + 1;
-						} else {
-							dml_clk_table->dppclk.clk_values_khz[i] = 0;
-							dml_clk_table->dppclk.num_clk_values = i;
-						}
+	/* dppclk */
+	if (dc_clk_table->num_entries_per_clk.num_dppclk_levels) {
+		dml_clk_table->dppclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dppclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->dppclk.num_clk_values) {
+				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dppclk_mhz &&
+						dc_clk_table->entries[i].dppclk_mhz > dc_bw_params->dc_mode_limit.dppclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].dppclk_mhz < dc_bw_params->dc_mode_limit.dppclk_mhz) {
+						dml_clk_table->dppclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dppclk_mhz * 1000;
+						dml_clk_table->dppclk.num_clk_values = i + 1;
 					} else {
-						dml_clk_table->dppclk.clk_values_khz[i] = dc_clk_table->entries[i].dppclk_mhz * 1000;
+						dml_clk_table->dppclk.clk_values_khz[i] = 0;
+						dml_clk_table->dppclk.num_clk_values = i;
 					}
 				} else {
-					dml_clk_table->dppclk.clk_values_khz[i] = 0;
+					dml_clk_table->dppclk.clk_values_khz[i] = dc_clk_table->entries[i].dppclk_mhz * 1000;
 				}
+			} else {
+				dml_clk_table->dppclk.clk_values_khz[i] = 0;
 			}
 		}
+	}
 
-		/* dtbclk */
-		if (dc_clk_table->num_entries_per_clk.num_dtbclk_levels) {
-			dml_clk_table->dtbclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dtbclk_levels;
-			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-				if (i < dml_clk_table->dtbclk.num_clk_values) {
-					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dtbclk_mhz &&
-							dc_clk_table->entries[i].dtbclk_mhz > dc_bw_params->dc_mode_limit.dtbclk_mhz) {
-						if (i == 0 || dc_clk_table->entries[i-1].dtbclk_mhz < dc_bw_params->dc_mode_limit.dtbclk_mhz) {
-							dml_clk_table->dtbclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dtbclk_mhz * 1000;
-							dml_clk_table->dtbclk.num_clk_values = i + 1;
-						} else {
-							dml_clk_table->dtbclk.clk_values_khz[i] = 0;
-							dml_clk_table->dtbclk.num_clk_values = i;
-						}
+	/* dtbclk */
+	if (dc_clk_table->num_entries_per_clk.num_dtbclk_levels) {
+		dml_clk_table->dtbclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dtbclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->dtbclk.num_clk_values) {
+				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dtbclk_mhz &&
+						dc_clk_table->entries[i].dtbclk_mhz > dc_bw_params->dc_mode_limit.dtbclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].dtbclk_mhz < dc_bw_params->dc_mode_limit.dtbclk_mhz) {
+						dml_clk_table->dtbclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dtbclk_mhz * 1000;
+						dml_clk_table->dtbclk.num_clk_values = i + 1;
 					} else {
-						dml_clk_table->dtbclk.clk_values_khz[i] = dc_clk_table->entries[i].dtbclk_mhz * 1000;
+						dml_clk_table->dtbclk.clk_values_khz[i] = 0;
+						dml_clk_table->dtbclk.num_clk_values = i;
 					}
 				} else {
-					dml_clk_table->dtbclk.clk_values_khz[i] = 0;
+					dml_clk_table->dtbclk.clk_values_khz[i] = dc_clk_table->entries[i].dtbclk_mhz * 1000;
 				}
+			} else {
+				dml_clk_table->dtbclk.clk_values_khz[i] = 0;
 			}
 		}
+	}
 
-		/* socclk */
-		if (dc_clk_table->num_entries_per_clk.num_socclk_levels) {
-			dml_clk_table->socclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_socclk_levels;
-			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-				if (i < dml_clk_table->socclk.num_clk_values) {
-					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.socclk_mhz &&
-							dc_clk_table->entries[i].socclk_mhz > dc_bw_params->dc_mode_limit.socclk_mhz) {
-						if (i == 0 || dc_clk_table->entries[i-1].socclk_mhz < dc_bw_params->dc_mode_limit.socclk_mhz) {
-							dml_clk_table->socclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.socclk_mhz * 1000;
-							dml_clk_table->socclk.num_clk_values = i + 1;
-						} else {
-							dml_clk_table->socclk.clk_values_khz[i] = 0;
-							dml_clk_table->socclk.num_clk_values = i;
-						}
+	/* socclk */
+	if (dc_clk_table->num_entries_per_clk.num_socclk_levels) {
+		dml_clk_table->socclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_socclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->socclk.num_clk_values) {
+				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.socclk_mhz &&
+						dc_clk_table->entries[i].socclk_mhz > dc_bw_params->dc_mode_limit.socclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].socclk_mhz < dc_bw_params->dc_mode_limit.socclk_mhz) {
+						dml_clk_table->socclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.socclk_mhz * 1000;
+						dml_clk_table->socclk.num_clk_values = i + 1;
 					} else {
-						dml_clk_table->socclk.clk_values_khz[i] = dc_clk_table->entries[i].socclk_mhz * 1000;
+						dml_clk_table->socclk.clk_values_khz[i] = 0;
+						dml_clk_table->socclk.num_clk_values = i;
 					}
 				} else {
-					dml_clk_table->socclk.clk_values_khz[i] = 0;
+					dml_clk_table->socclk.clk_values_khz[i] = dc_clk_table->entries[i].socclk_mhz * 1000;
 				}
+			} else {
+				dml_clk_table->socclk.clk_values_khz[i] = 0;
 			}
 		}
-
-		/* do not override phyclks for now */
-		/* phyclk */
-		// dml_clk_table->phyclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_phyclk_levels;
-		// for (i = 0; i < DML_MAX_CLK_TABLE_SIZE; i++) {
-		// 	dml_clk_table->phyclk.clk_values_khz[i] = dc_clk_table->entries[i].phyclk_mhz * 1000;
-		// }
-
-		/* phyclk_d18 */
-		// dml_clk_table->phyclk_d18.num_clk_values = dc_clk_table->num_entries_per_clk.num_phyclk_d18_levels;
-		// for (i = 0; i < DML_MAX_CLK_TABLE_SIZE; i++) {
-		// 	dml_clk_table->phyclk_d18.clk_values_khz[i] = dc_clk_table->entries[i].phyclk_d18_mhz * 1000;
-		// }
-
-		/* phyclk_d32 */
-		// dml_clk_table->phyclk_d32.num_clk_values = dc_clk_table->num_entries_per_clk.num_phyclk_d32_levels;
-		// for (i = 0; i < DML_MAX_CLK_TABLE_SIZE; i++) {
-		// 	dml_clk_table->phyclk_d32.clk_values_khz[i] = dc_clk_table->entries[i].phyclk_d32_mhz * 1000;
-		// }
 	}
+}
 
-	dml_soc_bb->dchub_refclk_mhz = in_dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
-	dml_soc_bb->dprefclk_mhz = in_dc->clk_mgr->dprefclk_khz / 1000;
-	dml_soc_bb->xtalclk_mhz = in_dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency / 1000;
-	dml_soc_bb->dispclk_dppclk_vco_speed_mhz = in_dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+static void override_dml_init_with_values_from_vbios(
+		struct dml2_initialize_instance_in_out *dml_init,
+		const struct dml2_configuration_options *config,
+		const struct dc *in_dc)
+{
+	const struct clk_bw_params *dc_bw_params = in_dc->clk_mgr->bw_params;
+	struct dml2_soc_bb *dml_soc_bb = &dml_init->soc_bb;
+	struct dml2_soc_state_table *dml_clk_table = &dml_init->soc_bb.clk_table;
 
-	/* override bounding box paramters from VBIOS */
 	if (in_dc->ctx->dc_bios->bb_info.dram_clock_change_latency_100ns > 0)
 		dml_soc_bb->power_management_parameters.dram_clk_change_blackout_us =
 				(in_dc->ctx->dc_bios->bb_info.dram_clock_change_latency_100ns + 9) / 10;
@@ -317,32 +293,120 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 		dml_clk_table->dram_config.channel_width_bytes = in_dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
 	}
 
-	/* override bounding box paramters from DC config */
-	if (in_dc->bb_overrides.sr_exit_time_ns) {
-		dml_soc_bb->power_management_parameters.stutter_exit_latency_us =
-				in_dc->bb_overrides.sr_exit_time_ns / 1000.0;
+	dml_init->soc_bb.xtalclk_mhz = in_dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency / 1000;
+}
+
+
+static void override_dml_init_with_values_from_dmub(struct dml2_initialize_instance_in_out *dml_init,
+		const struct dml2_configuration_options *config,
+		const struct dc *in_dc)
+{
+	/*
+	 * TODO - There seems to be overlaps between the values overriden from
+	 * dmub and vbios. Investigate and identify the values that DMUB needs
+	 * to own.
+	 */
+// 	const struct dmub_soc_bb_params *dmub_bb_params =
+// 			(const struct dmub_soc_bb_params *)config->bb_from_dmub;
+
+// 	if (dmub_bb_params == NULL)
+// 		return;
+
+// 	if (dmub_bb_params->dram_clk_change_blackout_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.dram_clk_change_blackout_us =
+// 			(double) dmub_bb_params->dram_clk_change_blackout_ns / 1000.0;
+// 	if (dmub_bb_params->dram_clk_change_read_only_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.dram_clk_change_read_only_us =
+// 			(double) dmub_bb_params->dram_clk_change_read_only_ns / 1000.0;
+// 	if (dmub_bb_params->dram_clk_change_write_only_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.dram_clk_change_write_only_us =
+// 			(double) dmub_bb_params->dram_clk_change_write_only_ns / 1000.0;
+// 	if (dmub_bb_params->fclk_change_blackout_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.fclk_change_blackout_us =
+// 			(double) dmub_bb_params->fclk_change_blackout_ns / 1000.0;
+// 	if (dmub_bb_params->g7_ppt_blackout_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.g7_ppt_blackout_us =
+// 			(double) dmub_bb_params->g7_ppt_blackout_ns / 1000.0;
+// 	if (dmub_bb_params->stutter_enter_plus_exit_latency_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.stutter_enter_plus_exit_latency_us =
+// 			(double) dmub_bb_params->stutter_enter_plus_exit_latency_ns / 1000.0;
+// 	if (dmub_bb_params->stutter_exit_latency_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.stutter_exit_latency_us =
+// 			(double) dmub_bb_params->stutter_exit_latency_ns / 1000.0;
+// 	if (dmub_bb_params->z8_stutter_enter_plus_exit_latency_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.z8_stutter_enter_plus_exit_latency_us =
+// 			(double) dmub_bb_params->z8_stutter_enter_plus_exit_latency_ns / 1000.0;
+// 	if (dmub_bb_params->z8_stutter_exit_latency_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.z8_stutter_exit_latency_us =
+// 			(double) dmub_bb_params->z8_stutter_exit_latency_ns / 1000.0;
+// 	if (dmub_bb_params->z8_min_idle_time_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.z8_min_idle_time =
+// 			(double) dmub_bb_params->z8_min_idle_time_ns / 1000.0;
+// #ifndef TRIM_DML2_DCN6B_IP_SENSITIVE
+// 	if (dmub_bb_params->type_b_dram_clk_change_blackout_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.lpddr5_dram_clk_change_blackout_us =
+// 			(double) dmub_bb_params->type_b_dram_clk_change_blackout_ns / 1000.0;
+// 	if (dmub_bb_params->type_b_ppt_blackout_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.lpddr5_ppt_blackout_us =
+// 			(double) dmub_bb_params->type_b_ppt_blackout_ns / 1000.0;
+// #else
+// 	if (dmub_bb_params->type_b_dram_clk_change_blackout_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.type_b_dram_clk_change_blackout_us =
+// 			(double) dmub_bb_params->type_b_dram_clk_change_blackout_ns / 1000.0;
+// 	if (dmub_bb_params->type_b_ppt_blackout_ns > 0)
+// 		dml_init->soc_bb.power_management_parameters.type_b_ppt_blackout_us =
+// 			(double) dmub_bb_params->type_b_ppt_blackout_ns / 1000.0;
+// #endif
+// 	if (dmub_bb_params->vmin_limit_dispclk_khz > 0)
+// 		dml_init->soc_bb.vmin_limit.dispclk_khz = dmub_bb_params->vmin_limit_dispclk_khz;
+// 	if (dmub_bb_params->vmin_limit_dcfclk_khz > 0)
+// 		dml_init->soc_bb.vmin_limit.dcfclk_khz = dmub_bb_params->vmin_limit_dcfclk_khz;
+//	if (dmub_bb_params->g7_temperature_read_blackout_ns > 0)
+//		dml_init->soc_bb.power_management_parameters.g7_temperature_read_blackout_us =
+//				(double) dmub_bb_params->g7_temperature_read_blackout_ns / 1000.0;
+}
+
+static void override_dml_init_with_values_from_software_policy(struct dml2_initialize_instance_in_out *dml_init,
+		const struct dml2_configuration_options *config,
+		const struct dc *in_dc)
+{
+	if (!config->use_native_soc_bb_construction) {
+		dml_init->soc_bb = config->external_socbb_ip_params->soc_bb;
+		dml_init->ip_caps = config->external_socbb_ip_params->ip_params;
 	}
 
-	if (in_dc->bb_overrides.sr_enter_plus_exit_time_ns) {
-		dml_soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us =
+	if (in_dc->bb_overrides.sr_exit_time_ns)
+		dml_init->soc_bb.power_management_parameters.stutter_exit_latency_us =
+				in_dc->bb_overrides.sr_exit_time_ns / 1000.0;
+
+	if (in_dc->bb_overrides.sr_enter_plus_exit_time_ns)
+		dml_init->soc_bb.power_management_parameters.stutter_enter_plus_exit_latency_us =
 				in_dc->bb_overrides.sr_enter_plus_exit_time_ns / 1000.0;
-	}
 
-	if (in_dc->bb_overrides.dram_clock_change_latency_ns) {
-		dml_soc_bb->power_management_parameters.dram_clk_change_blackout_us =
+	if (in_dc->bb_overrides.dram_clock_change_latency_ns)
+		dml_init->soc_bb.power_management_parameters.dram_clk_change_blackout_us =
 				in_dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
-	}
 
-	if (in_dc->bb_overrides.fclk_clock_change_latency_ns) {
-		dml_soc_bb->power_management_parameters.fclk_change_blackout_us =
+	if (in_dc->bb_overrides.fclk_clock_change_latency_ns)
+		dml_init->soc_bb.power_management_parameters.fclk_change_blackout_us =
 				in_dc->bb_overrides.fclk_clock_change_latency_ns / 1000.0;
-	}
+}
+
+void dml21_populate_dml_init_params(struct dml2_initialize_instance_in_out *dml_init,
+		const struct dml2_configuration_options *config,
+		const struct dc *in_dc)
+{
+	populate_default_dml_init_params(dml_init, config, in_dc);
+
+	override_dml_init_with_values_from_hardware_default(dml_init, config, in_dc);
+
+	override_dml_init_with_values_from_smu(dml_init, config, in_dc);
+
+	override_dml_init_with_values_from_vbios(dml_init, config, in_dc);
+
+	override_dml_init_with_values_from_dmub(dml_init, config, in_dc);
 
-	//TODO
-	// if (in_dc->bb_overrides.dummy_clock_change_latency_ns) {
-	// 	dml_soc_bb->power_management_parameters.dram_clk_change_blackout_us =
-	// 			in_dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
-	// }
+	override_dml_init_with_values_from_software_policy(dml_init, config, in_dc);
 }
 
 static unsigned int calc_max_hardware_v_total(const struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
index 73a013be1e48..9880d3e0398e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
@@ -17,9 +17,7 @@ struct dml2_context;
 struct dml2_configuration_options;
 struct dml2_initialize_instance_in_out;
 
-void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_init, const struct dml2_configuration_options *config, const struct dc *in_dc);
-void dml21_initialize_soc_bb_params(struct dml2_initialize_instance_in_out *dml_init, const struct dml2_configuration_options *config, const struct dc *in_dc);
-void dml21_initialize_ip_params(struct dml2_initialize_instance_in_out *dml_init, const struct dml2_configuration_options *config, const struct dc *in_dc);
+void dml21_populate_dml_init_params(struct dml2_initialize_instance_in_out *dml_init, const struct dml2_configuration_options *config, const struct dc *in_dc);
 bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml_ctx);
 void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state *context);
 void dml21_extract_watermark_sets(const struct dc *in_dc, union dcn_watermark_set *watermarks, struct dml2_context *in_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 2127078b73b0..03de3cf06ae5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -35,15 +35,11 @@ static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 	return true;
 }
 
-static void dml21_apply_debug_options(const struct dc *in_dc, struct dml2_context *dml_ctx, const struct dml2_configuration_options *config)
+static void dml21_populate_configuration_options(const struct dc *in_dc,
+		struct dml2_context *dml_ctx,
+		const struct dml2_configuration_options *config)
 {
-	bool disable_fams2;
-	struct dml2_pmo_options *pmo_options = &dml_ctx->v21.dml_init.options.pmo_options;
-
-	/* ODM options */
-	pmo_options->disable_dyn_odm = !config->minimize_dispclk_using_odm;
-	pmo_options->disable_dyn_odm_for_multi_stream = true;
-	pmo_options->disable_dyn_odm_for_stream_with_svp = true;
+	dml_ctx->config = *config;
 
 	/* UCLK P-State options */
 	if (in_dc->debug.dml21_force_pstate_method) {
@@ -53,52 +49,20 @@ static void dml21_apply_debug_options(const struct dc *in_dc, struct dml2_contex
 	} else {
 		dml_ctx->config.pmo.force_pstate_method_enable = false;
 	}
-
-	pmo_options->disable_vblank = ((in_dc->debug.dml21_disable_pstate_method_mask >> 1) & 1);
-
-	/* NOTE: DRR and SubVP Require FAMS2 */
-	disable_fams2 = !in_dc->debug.fams2_config.bits.enable;
-	pmo_options->disable_svp = ((in_dc->debug.dml21_disable_pstate_method_mask >> 2) & 1) ||
-			in_dc->debug.force_disable_subvp ||
-			disable_fams2;
-	pmo_options->disable_drr_clamped = ((in_dc->debug.dml21_disable_pstate_method_mask >> 3) & 1) ||
-			disable_fams2;
-	pmo_options->disable_drr_var = ((in_dc->debug.dml21_disable_pstate_method_mask >> 4) & 1) ||
-			disable_fams2;
-	pmo_options->disable_fams2 = disable_fams2;
-
-	pmo_options->disable_drr_var_when_var_active = in_dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE ||
-			in_dc->debug.disable_fams_gaming == INGAME_FAMS_MULTI_DISP_CLAMPED_ONLY;
-	pmo_options->disable_drr_clamped_when_var_active = in_dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE;
 }
 
-static void dml21_init(const struct dc *in_dc, struct dml2_context **dml_ctx, const struct dml2_configuration_options *config)
+static void dml21_init(const struct dc *in_dc, struct dml2_context *dml_ctx, const struct dml2_configuration_options *config)
 {
-	switch (in_dc->ctx->dce_version) {
-	case DCN_VERSION_4_01:
-		(*dml_ctx)->v21.dml_init.options.project_id = dml2_project_dcn4x_stage2_auto_drr_svp;
-		break;
-	default:
-		(*dml_ctx)->v21.dml_init.options.project_id = dml2_project_invalid;
-	}
 
-	(*dml_ctx)->architecture = dml2_architecture_21;
+	dml_ctx->architecture = dml2_architecture_21;
 
-	/* Store configuration options */
-	(*dml_ctx)->config = *config;
+	dml21_populate_configuration_options(in_dc, dml_ctx, config);
 
 	DC_FP_START();
 
-	/*Initialize SOCBB and DCNIP params */
-	dml21_initialize_soc_bb_params(&(*dml_ctx)->v21.dml_init, config, in_dc);
-	dml21_initialize_ip_params(&(*dml_ctx)->v21.dml_init, config, in_dc);
-	dml21_apply_soc_bb_overrides(&(*dml_ctx)->v21.dml_init, config, in_dc);
+	dml21_populate_dml_init_params(&dml_ctx->v21.dml_init, config, in_dc);
 
-	/* apply debug overrides */
-	dml21_apply_debug_options(in_dc, *dml_ctx, config);
-
-	/*Initialize DML21 instance */
-	dml2_initialize_instance(&(*dml_ctx)->v21.dml_init);
+	dml2_initialize_instance(&dml_ctx->v21.dml_init);
 
 	DC_FP_END();
 }
@@ -109,7 +73,7 @@ bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const s
 	if (!dml21_allocate_memory(dml_ctx))
 		return false;
 
-	dml21_init(in_dc, dml_ctx, config);
+	dml21_init(in_dc, *dml_ctx, config);
 
 	return true;
 }
@@ -495,7 +459,7 @@ bool dml21_create_copy(struct dml2_context **dst_dml_ctx,
 	return true;
 }
 
-void dml21_reinit(const struct dc *in_dc, struct dml2_context **dml_ctx, const struct dml2_configuration_options *config)
+void dml21_reinit(const struct dc *in_dc, struct dml2_context *dml_ctx, const struct dml2_configuration_options *config)
 {
 	dml21_init(in_dc, dml_ctx, config);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h
index 204ff97d50fa..15f92029d2e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h
@@ -34,7 +34,7 @@ void dml21_copy(struct dml2_context *dst_dml_ctx,
 	struct dml2_context *src_dml_ctx);
 bool dml21_create_copy(struct dml2_context **dst_dml_ctx,
 	struct dml2_context *src_dml_ctx);
-void dml21_reinit(const struct dc *in_dc, struct dml2_context **dml_ctx, const struct dml2_configuration_options *config);
+void dml21_reinit(const struct dc *in_dc, struct dml2_context *dml_ctx, const struct dml2_configuration_options *config);
 
 /**
  * dml21_validate - Determines if a display configuration is supported or not.
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 0524a33a88b3..0318260370ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -580,8 +580,8 @@ static inline struct dml2_context *dml2_allocate_memory(void)
 
 static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
 {
-	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version == DCN_VERSION_4_01)) {
-		dml21_reinit(in_dc, dml2, config);
+	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >= DCN_VERSION_4_01)) {
+		dml21_reinit(in_dc, *dml2, config);
 		return;
 	}
 
@@ -626,9 +626,7 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
 {
 	// TODO : Temporarily add DCN_VERSION_3_2 for N-1 validation. Remove DCN_VERSION_3_2 after N-1 validation phase is complete.
-	if ((in_dc->debug.using_dml21)
-			&& (in_dc->ctx->dce_version == DCN_VERSION_4_01
-		))
+	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >= DCN_VERSION_4_01))
 		return dml21_create(in_dc, dml2, config);
 
 	// Allocate Mode Lib Ctx
@@ -697,8 +695,8 @@ void dml2_reinit(const struct dc *in_dc,
 				 const struct dml2_configuration_options *config,
 				 struct dml2_context **dml2)
 {
-	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version == DCN_VERSION_4_01)) {
-		dml21_reinit(in_dc, dml2, config);
+	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >= DCN_VERSION_4_01)) {
+		dml21_reinit(in_dc, *dml2, config);
 		return;
 	}
 
-- 
2.43.0

