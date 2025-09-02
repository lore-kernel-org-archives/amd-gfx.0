Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEEBCA100C
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5C310E702;
	Tue,  2 Sep 2025 13:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qW6+2UEG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC6F10E702
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaBmFSJDOy+gNzs8tXaLVdLo9eobqLST+ITmuLdwz6VbEYgXxNR12pn+upjOgWh2ceSYeEBW+1wOYbz3UZHNQUY0dWC3xJwCQSXyClzNb7PhcJ2KMeshouuGO76hM+nWJ7Ql0T/BkqBH/Qx75cYYeuG37/wmjUNvh8Upr1mhYDMTibBLM6/m/irtPUkBYhvR7W1nqbXMnw7IPFHHOOYUFgNRPjxXMd4UCrOjm4aljWjoZCkKO+gDejYPTqbqjeYmjjUMDC5YVneOCo/m6t3/Gtlphc8/SIithVBBmPexo9dlxvcDQiSpcO66+qcJvUK2RZPEBC+4rAzSuMkCcmXd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZrJj+/zOcUHPQqbG0qA966dYi0gABw+33BhDZKLxcM=;
 b=iQ+ujWoQIH1uqHyyuIF9p+n1NnTcFRPBLTBJNv+GRHe7IiPCK/W2CkfY97c3dh6e6X3xHHE5Gzjrj1BH+S3wYVCTXrhzmT5aDw3XWzJKiaUXj7fN1Mf1Dhn9ce4Bv1HlywNe51NIm8TKIr0U4eCppL+sR68unzkuT7AysX/jRQbfwLcOR8i/Dw0NzGOFvw4Hsg8waN1lWzKU/hyqRR7TTS2jl/30aFLvdLooZ7ddHmqz7L9VbO7KpfweztoOco5zMGMDDTAGW5XQnKKxDQe0oGQkx4As+UYX0zvNJKipHeAeonFyRzF0GszoGOI0nVib4ocgYhs81VAL7KC+3n6M5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZrJj+/zOcUHPQqbG0qA966dYi0gABw+33BhDZKLxcM=;
 b=qW6+2UEGL/hG296+NLoyf8QA6dZDioyh0qyyiaIBKKIv8uccp9/OlMKel7lN1W5mdkqr/H3KmnTFqX3k06MckhtnCz3SKXDgzP6Uq8Ksj0MsYyTFiqFAp8YPUIaC+KybQDolpBbJXtXCQ/y479RHu7G5niQNlUsNxrxfM4Ts1Vg=
Received: from DS7PR03CA0207.namprd03.prod.outlook.com (2603:10b6:5:3b6::32)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 2 Sep
 2025 13:35:54 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::b5) by DS7PR03CA0207.outlook.office365.com
 (2603:10b6:5:3b6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 13:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 13:35:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:35:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 08:35:53 -0500
Received: from jzuo-laptop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 08:35:52 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 3/8] drm/amd/display: Add Component To Handle Bounding Box
 Values and IP Caps
Date: Tue, 2 Sep 2025 09:33:32 -0400
Message-ID: <20250902133529.4144-4-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902133529.4144-1-Jerry.Zuo@amd.com>
References: <20250902133529.4144-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2ca4f8-b60c-4fe3-853a-08ddea25a3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QdSWta8IxN+7lz3yYgDy0kabIh0vk1ictCpUsi43sDjGmq10NBtqEajuD+Uc?=
 =?us-ascii?Q?6acQa40RG87yHUFuUGH3No42KAUNthbMY9v/TtJmk4o/H0mPmFzIuxfRN7A6?=
 =?us-ascii?Q?9f/6qsBNhIwD5Bo/Of+WsfoqnB80BCbPWQBIHvi90pRd6nIbHYs2CaSWBAVF?=
 =?us-ascii?Q?t9eO958Irn7gKAVAYq8XU8ern0FZ3Uvppd+LI9oqfxDC4ZvhrscwMB2yjYcG?=
 =?us-ascii?Q?eikKuMU6HRYtwjWla+aZ15slcXRsLG78ZwBmjoNdox0zf1TRVTc3bzGlm/HU?=
 =?us-ascii?Q?u3chVZosLSX1uHrPkwa7rwGecMe3dgb3N8KHCFZo/MQ0NXtrVoYMkQmbQE1m?=
 =?us-ascii?Q?iztl4oq12njpG4MBKHITR704KcBEvDkSAcLTb5pigaAQqedPY+v550TzQ2kc?=
 =?us-ascii?Q?7DprWF9vAyT7NznLKElFqwIFruMGCWzLvvZGRzduXC59pdBZfi2GE2hBK2Qn?=
 =?us-ascii?Q?QF2OlMOKnyfg5TONnMITEg2dHQd3qktCZNfKVyCaYkYhOaLDj9p3U28MXAaw?=
 =?us-ascii?Q?ZwCJtwxEy4z8grZX8x7bXA+O1gUunicKjb/rVOJbbhklKTelXgO9NQ4o8ofA?=
 =?us-ascii?Q?j8BGsl56D6ALaNG8CA106AsoLb5qvjnfJf51JUAk01osyR24y+ggYh8Tn/uR?=
 =?us-ascii?Q?8vmlHdHMbNdhxKdDz+bcPyUijT7b0SGLILy7Ce8k+bsM2fwwfHt8t9U6D2hF?=
 =?us-ascii?Q?F/JprGmvqfenoTgclWInOhhy84bOFOcI95jE8nCSBzr3okSBW4QuSA/ekOjO?=
 =?us-ascii?Q?ywPz4rP0t9TGqckdPIoDTq5wZYHp9uRMGpCHSXplNBF2EkOpb9SE/RyOzUw/?=
 =?us-ascii?Q?6VEmBU8XhLWcezs51DuU2+lwcO/aBGatOkI+Lr3ypvI2qbueXdkBpV3rE90w?=
 =?us-ascii?Q?QSgub03k07Fssn5B8ydbeSlTW+GvLRvQpMjbblAvhHqLlRFW8M8aM73KGGwY?=
 =?us-ascii?Q?oyVga6rWMVlh1MoQdymlQ/ONoyrusNFKgLp70Gt3TKgFmQqdHcxSI4KRCmE4?=
 =?us-ascii?Q?E8K1x4ICT1yvc6NZT+8S2ZFxkVTU5Ry5EwyBRa2NGCGPD8mO8FMjiAD6+B90?=
 =?us-ascii?Q?8FnceLuQYk9eBTtXnhWDmYnIeEiFvsPkGbYBK8p6FXTweowaq6kt2SIfAeJj?=
 =?us-ascii?Q?vlsWpYCgH8zqe5Z6sWRyhJWeiFRctfXOJ8WrD6rgrYJo9klDXK7VRCj2Scci?=
 =?us-ascii?Q?g2QVMU4kazR3MminPJkjjJRpkTh/R3r3P0ZSk+2HHFlsEV6JtGwHLNOaeaCT?=
 =?us-ascii?Q?OpPkFFmgksdp0ToTog+MPXWJdOuFuMhJAEBqLyApDJsIBAYgGSlt20KnT90i?=
 =?us-ascii?Q?9JoDhyFGDLYMdyPe7HSuGl8Xq+DLRdgsMPHfQms7lf+x6bq5I1Ggi9EDO2TW?=
 =?us-ascii?Q?gB5QstoT1lvG+yWqjzHL/mLfy8UNmItKLb1TzaY72tvePVqF/6/zVMa2S2Zr?=
 =?us-ascii?Q?cLBZhLkACgDUEJlqHlat9FCZ0pY97b0FM6LC5G0GYAghVTzAA0/4E0TM/u3L?=
 =?us-ascii?Q?20s1OCadXIrA8JBhGySRQNet+q3kWLI/CRCW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:35:54.0220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2ca4f8-b60c-4fe3-853a-08ddea25a3e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
Bounding box values can be stored in multiple locations. (e.g. PMFW, VBIOS, DMUB).
The source and interpretation of these values can vary with DCN revision
so there should be a component that can gather these values and translate
them accordingly

[How]
Have component start with the statically defined values as a base.
Then update them as needed with DCN-specific logic
Guard this component with FPU flags since values need to be in float point.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/Makefile          |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  | 368 +-----------------
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   2 +-
 .../display/dc/inc/soc_and_ip_translator.h    |  24 ++
 .../display/dc/soc_and_ip_translator/Makefile |  19 +
 .../dcn401/dcn401_soc_and_ip_translator.c     | 304 +++++++++++++++
 .../dcn401/dcn401_soc_and_ip_translator.h     |  22 ++
 .../dcn42/dcn42_soc_and_ip_translator.c       |  27 ++
 .../dcn42/dcn42_soc_and_ip_translator.h       |  16 +
 .../soc_and_ip_translator.c                   |  37 ++
 13 files changed, 475 insertions(+), 356 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index 89d605de0595..0084a8d55254 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -44,6 +44,7 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/mmhubbub
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/mpc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/opp
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/pg
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/soc_and_ip_translator
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/freesync
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/color
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 3c9ecea7eebc..dc943abd6dba 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -37,6 +37,7 @@ DC_LIBS += dcn301
 DC_LIBS += dcn31
 DC_LIBS += dml
 DC_LIBS += dml2
+DC_LIBS += soc_and_ip_translator
 endif
 
 DC_LIBS += dce120
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c30d9ee51c83..261b7d43e91d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -84,6 +84,7 @@
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
 #include "dml2/dml2_internal_types.h"
+#include "soc_and_ip_translator.h"
 #endif
 
 #include "dce/dmub_outbox.h"
@@ -949,7 +950,9 @@ static void dc_destruct(struct dc *dc)
 	}
 
 	dc_destroy_resource_pool(dc);
-
+#ifdef CONFIG_DRM_AMD_DC_FP
+	dc_destroy_soc_and_ip_translator(&dc->soc_and_ip_translator);
+#endif
 	if (dc->link_srv)
 		link_destroy_link_service(&dc->link_srv);
 
@@ -1153,6 +1156,9 @@ static bool dc_construct(struct dc *dc,
 		dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
 		DC_FP_END();
 	}
+	dc->soc_and_ip_translator = dc_create_soc_and_ip_translator(dc_ctx->dce_version);
+	if (!dc->soc_and_ip_translator)
+		goto fail;
 #endif
 
 	if (!create_links(dc, init_params->num_virtual_links))
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c2bf583f30a7..e81b488cd72d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1776,7 +1776,7 @@ struct dc {
 	struct dml2_configuration_options dml2_options;
 	struct dml2_configuration_options dml2_dc_power_options;
 	enum dc_acpi_cm_power_state power_state;
-
+	struct soc_and_ip_translator *soc_and_ip_translator;
 };
 
 struct dc_scaling_info {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index d6c77d96e4f7..f6879e622271 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -8,7 +8,7 @@
 #include "dml2_internal_types.h"
 #include "dml21_utils.h"
 #include "dml21_translation_helper.h"
-#include "bounding_boxes/dcn4_soc_bb.h"
+#include "soc_and_ip_translator.h"
 
 static void dml21_populate_pmo_options(struct dml2_pmo_options *pmo_options,
 		const struct dc *in_dc,
@@ -38,375 +38,37 @@ static void dml21_populate_pmo_options(struct dml2_pmo_options *pmo_options,
 	pmo_options->disable_drr_clamped_when_var_active = in_dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE;
 }
 
-/*
- * Populate dml_init based on default static values in soc bb. The default
- * values are for reference and support at least minimal operation of current
- * SoC and DCN hardware. The values could be modifed by subsequent override
- * functions to reflect our true hardware capability.
- */
-static void populate_default_dml_init_params(struct dml2_initialize_instance_in_out *dml_init,
-		const struct dml2_configuration_options *config,
-		const struct dc *in_dc)
+static enum dml2_project_id dml21_dcn_revision_to_dml2_project_id(enum dce_version dcn_version)
 {
-	switch (in_dc->ctx->dce_version) {
+	enum dml2_project_id project_id;
+	switch (dcn_version) {
 	case DCN_VERSION_4_01:
-		dml_init->options.project_id = dml2_project_dcn4x_stage2_auto_drr_svp;
-		dml21_populate_pmo_options(&dml_init->options.pmo_options, in_dc, config);
-		dml_init->soc_bb = dml2_socbb_dcn401;
-		dml_init->soc_bb.qos_parameters = dml_dcn4_variant_a_soc_qos_params;
-		dml_init->ip_caps = dml2_dcn401_max_ip_caps;
+		project_id = dml2_project_dcn4x_stage2_auto_drr_svp;
 		break;
 	default:
-		memset(dml_init, 0, sizeof(*dml_init));
+		project_id = dml2_project_invalid;
 		DC_ERR("unsupported dcn version for DML21!");
-		return;
-	}
-}
-
-static void override_dml_init_with_values_from_hardware_default(struct dml2_initialize_instance_in_out *dml_init,
-		const struct dml2_configuration_options *config,
-		const struct dc *in_dc)
-{
-	dml_init->soc_bb.dchub_refclk_mhz = in_dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
-	dml_init->soc_bb.dprefclk_mhz = in_dc->clk_mgr->dprefclk_khz / 1000;
-	dml_init->soc_bb.dispclk_dppclk_vco_speed_mhz = in_dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
-}
-
-/*
- * SMU stands for System Management Unit. It is a power management processor.
- * It owns the initialization of dc's clock table and programming of clock values
- * based on dc's requests.
- * Our clock values in base soc bb is a dummy placeholder. The real clock values
- * are retrieved from SMU firmware to dc clock table at runtime.
- * This function overrides our dummy placeholder values with real values in dc
- * clock table.
- */
-static void override_dml_init_with_values_from_smu(
-		struct dml2_initialize_instance_in_out *dml_init,
-		const struct dml2_configuration_options *config,
-		const struct dc *in_dc)
-{
-	int i;
-	const struct clk_bw_params *dc_bw_params = in_dc->clk_mgr->bw_params;
-	const struct clk_limit_table *dc_clk_table = &dc_bw_params->clk_table;
-	struct dml2_soc_state_table *dml_clk_table = &dml_init->soc_bb.clk_table;
-
-	if (!in_dc->clk_mgr->funcs->is_smu_present ||
-			!in_dc->clk_mgr->funcs->is_smu_present(in_dc->clk_mgr))
-		/* skip if smu is not present */
-		return;
-
-	/* dcfclk */
-	if (dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
-		dml_clk_table->dcfclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
-		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-			if (i < dml_clk_table->dcfclk.num_clk_values) {
-				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dcfclk_mhz &&
-						dc_clk_table->entries[i].dcfclk_mhz > dc_bw_params->dc_mode_limit.dcfclk_mhz) {
-					if (i == 0 || dc_clk_table->entries[i-1].dcfclk_mhz < dc_bw_params->dc_mode_limit.dcfclk_mhz) {
-						dml_clk_table->dcfclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dcfclk_mhz * 1000;
-						dml_clk_table->dcfclk.num_clk_values = i + 1;
-					} else {
-						dml_clk_table->dcfclk.clk_values_khz[i] = 0;
-						dml_clk_table->dcfclk.num_clk_values = i;
-					}
-				} else {
-					dml_clk_table->dcfclk.clk_values_khz[i] = dc_clk_table->entries[i].dcfclk_mhz * 1000;
-				}
-			} else {
-				dml_clk_table->dcfclk.clk_values_khz[i] = 0;
-			}
-		}
-	}
-
-	/* fclk */
-	if (dc_clk_table->num_entries_per_clk.num_fclk_levels) {
-		dml_clk_table->fclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_fclk_levels;
-		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-			if (i < dml_clk_table->fclk.num_clk_values) {
-				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.fclk_mhz &&
-						dc_clk_table->entries[i].fclk_mhz > dc_bw_params->dc_mode_limit.fclk_mhz) {
-					if (i == 0 || dc_clk_table->entries[i-1].fclk_mhz < dc_bw_params->dc_mode_limit.fclk_mhz) {
-						dml_clk_table->fclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.fclk_mhz * 1000;
-						dml_clk_table->fclk.num_clk_values = i + 1;
-					} else {
-						dml_clk_table->fclk.clk_values_khz[i] = 0;
-						dml_clk_table->fclk.num_clk_values = i;
-					}
-				} else {
-					dml_clk_table->fclk.clk_values_khz[i] = dc_clk_table->entries[i].fclk_mhz * 1000;
-				}
-			} else {
-				dml_clk_table->fclk.clk_values_khz[i] = 0;
-			}
-		}
-	}
-
-	/* uclk */
-	if (dc_clk_table->num_entries_per_clk.num_memclk_levels) {
-		dml_clk_table->uclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_memclk_levels;
-		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-			if (i < dml_clk_table->uclk.num_clk_values) {
-				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.memclk_mhz &&
-						dc_clk_table->entries[i].memclk_mhz > dc_bw_params->dc_mode_limit.memclk_mhz) {
-					if (i == 0 || dc_clk_table->entries[i-1].memclk_mhz < dc_bw_params->dc_mode_limit.memclk_mhz) {
-						dml_clk_table->uclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.memclk_mhz * 1000;
-						dml_clk_table->uclk.num_clk_values = i + 1;
-					} else {
-						dml_clk_table->uclk.clk_values_khz[i] = 0;
-						dml_clk_table->uclk.num_clk_values = i;
-					}
-				} else {
-					dml_clk_table->uclk.clk_values_khz[i] = dc_clk_table->entries[i].memclk_mhz * 1000;
-				}
-			} else {
-				dml_clk_table->uclk.clk_values_khz[i] = 0;
-			}
-		}
-	}
-
-	/* dispclk */
-	if (dc_clk_table->num_entries_per_clk.num_dispclk_levels) {
-		dml_clk_table->dispclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dispclk_levels;
-		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-			if (i < dml_clk_table->dispclk.num_clk_values) {
-				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dispclk_mhz &&
-						dc_clk_table->entries[i].dispclk_mhz > dc_bw_params->dc_mode_limit.dispclk_mhz) {
-					if (i == 0 || dc_clk_table->entries[i-1].dispclk_mhz < dc_bw_params->dc_mode_limit.dispclk_mhz) {
-						dml_clk_table->dispclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dispclk_mhz * 1000;
-						dml_clk_table->dispclk.num_clk_values = i + 1;
-					} else {
-						dml_clk_table->dispclk.clk_values_khz[i] = 0;
-						dml_clk_table->dispclk.num_clk_values = i;
-					}
-				} else {
-					dml_clk_table->dispclk.clk_values_khz[i] = dc_clk_table->entries[i].dispclk_mhz * 1000;
-				}
-			} else {
-				dml_clk_table->dispclk.clk_values_khz[i] = 0;
-			}
-		}
-	}
-
-	/* dppclk */
-	if (dc_clk_table->num_entries_per_clk.num_dppclk_levels) {
-		dml_clk_table->dppclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dppclk_levels;
-		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-			if (i < dml_clk_table->dppclk.num_clk_values) {
-				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dppclk_mhz &&
-						dc_clk_table->entries[i].dppclk_mhz > dc_bw_params->dc_mode_limit.dppclk_mhz) {
-					if (i == 0 || dc_clk_table->entries[i-1].dppclk_mhz < dc_bw_params->dc_mode_limit.dppclk_mhz) {
-						dml_clk_table->dppclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dppclk_mhz * 1000;
-						dml_clk_table->dppclk.num_clk_values = i + 1;
-					} else {
-						dml_clk_table->dppclk.clk_values_khz[i] = 0;
-						dml_clk_table->dppclk.num_clk_values = i;
-					}
-				} else {
-					dml_clk_table->dppclk.clk_values_khz[i] = dc_clk_table->entries[i].dppclk_mhz * 1000;
-				}
-			} else {
-				dml_clk_table->dppclk.clk_values_khz[i] = 0;
-			}
-		}
-	}
-
-	/* dtbclk */
-	if (dc_clk_table->num_entries_per_clk.num_dtbclk_levels) {
-		dml_clk_table->dtbclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dtbclk_levels;
-		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-			if (i < dml_clk_table->dtbclk.num_clk_values) {
-				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dtbclk_mhz &&
-						dc_clk_table->entries[i].dtbclk_mhz > dc_bw_params->dc_mode_limit.dtbclk_mhz) {
-					if (i == 0 || dc_clk_table->entries[i-1].dtbclk_mhz < dc_bw_params->dc_mode_limit.dtbclk_mhz) {
-						dml_clk_table->dtbclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dtbclk_mhz * 1000;
-						dml_clk_table->dtbclk.num_clk_values = i + 1;
-					} else {
-						dml_clk_table->dtbclk.clk_values_khz[i] = 0;
-						dml_clk_table->dtbclk.num_clk_values = i;
-					}
-				} else {
-					dml_clk_table->dtbclk.clk_values_khz[i] = dc_clk_table->entries[i].dtbclk_mhz * 1000;
-				}
-			} else {
-				dml_clk_table->dtbclk.clk_values_khz[i] = 0;
-			}
-		}
+		break;
 	}
 
-	/* socclk */
-	if (dc_clk_table->num_entries_per_clk.num_socclk_levels) {
-		dml_clk_table->socclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_socclk_levels;
-		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-			if (i < dml_clk_table->socclk.num_clk_values) {
-				if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.socclk_mhz &&
-						dc_clk_table->entries[i].socclk_mhz > dc_bw_params->dc_mode_limit.socclk_mhz) {
-					if (i == 0 || dc_clk_table->entries[i-1].socclk_mhz < dc_bw_params->dc_mode_limit.socclk_mhz) {
-						dml_clk_table->socclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.socclk_mhz * 1000;
-						dml_clk_table->socclk.num_clk_values = i + 1;
-					} else {
-						dml_clk_table->socclk.clk_values_khz[i] = 0;
-						dml_clk_table->socclk.num_clk_values = i;
-					}
-				} else {
-					dml_clk_table->socclk.clk_values_khz[i] = dc_clk_table->entries[i].socclk_mhz * 1000;
-				}
-			} else {
-				dml_clk_table->socclk.clk_values_khz[i] = 0;
-			}
-		}
-	}
+	return project_id;
 }
 
-static void override_dml_init_with_values_from_vbios(
-		struct dml2_initialize_instance_in_out *dml_init,
+void dml21_populate_dml_init_params(struct dml2_initialize_instance_in_out *dml_init,
 		const struct dml2_configuration_options *config,
 		const struct dc *in_dc)
 {
-	const struct clk_bw_params *dc_bw_params = in_dc->clk_mgr->bw_params;
-	struct dml2_soc_bb *dml_soc_bb = &dml_init->soc_bb;
-	struct dml2_soc_state_table *dml_clk_table = &dml_init->soc_bb.clk_table;
-
-	if (in_dc->ctx->dc_bios->bb_info.dram_clock_change_latency_100ns > 0)
-		dml_soc_bb->power_management_parameters.dram_clk_change_blackout_us =
-				(in_dc->ctx->dc_bios->bb_info.dram_clock_change_latency_100ns + 9) / 10;
-
-	if (in_dc->ctx->dc_bios->bb_info.dram_sr_enter_exit_latency_100ns > 0)
-		dml_soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us =
-				(in_dc->ctx->dc_bios->bb_info.dram_sr_enter_exit_latency_100ns + 9) / 10;
-
-	if (in_dc->ctx->dc_bios->bb_info.dram_sr_exit_latency_100ns > 0)
-		dml_soc_bb->power_management_parameters.stutter_exit_latency_us =
-			(in_dc->ctx->dc_bios->bb_info.dram_sr_exit_latency_100ns + 9) / 10;
-
-	if (dc_bw_params->num_channels) {
-		dml_clk_table->dram_config.channel_count = dc_bw_params->num_channels;
-		dml_soc_bb->mall_allocated_for_dcn_mbytes = in_dc->caps.mall_size_total / 1048576;
-	} else if (in_dc->ctx->dc_bios->vram_info.num_chans) {
-		dml_clk_table->dram_config.channel_count = in_dc->ctx->dc_bios->vram_info.num_chans;
-		dml_soc_bb->mall_allocated_for_dcn_mbytes = in_dc->caps.mall_size_total / 1048576;
-	}
-
-	if (dc_bw_params->dram_channel_width_bytes) {
-		dml_clk_table->dram_config.channel_width_bytes = dc_bw_params->dram_channel_width_bytes;
-	} else if (in_dc->ctx->dc_bios->vram_info.dram_channel_width_bytes) {
-		dml_clk_table->dram_config.channel_width_bytes = in_dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
-	}
-
-	dml_init->soc_bb.xtalclk_mhz = in_dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency / 1000;
-}
+	dml_init->options.project_id = dml21_dcn_revision_to_dml2_project_id(in_dc->ctx->dce_version);
 
-
-static void override_dml_init_with_values_from_dmub(struct dml2_initialize_instance_in_out *dml_init,
-		const struct dml2_configuration_options *config,
-		const struct dc *in_dc)
-{
-	/*
-	 * TODO - There seems to be overlaps between the values overriden from
-	 * dmub and vbios. Investigate and identify the values that DMUB needs
-	 * to own.
-	 */
-// 	const struct dmub_soc_bb_params *dmub_bb_params =
-// 			(const struct dmub_soc_bb_params *)config->bb_from_dmub;
-
-// 	if (dmub_bb_params == NULL)
-// 		return;
-
-// 	if (dmub_bb_params->dram_clk_change_blackout_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.dram_clk_change_blackout_us =
-// 			(double) dmub_bb_params->dram_clk_change_blackout_ns / 1000.0;
-// 	if (dmub_bb_params->dram_clk_change_read_only_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.dram_clk_change_read_only_us =
-// 			(double) dmub_bb_params->dram_clk_change_read_only_ns / 1000.0;
-// 	if (dmub_bb_params->dram_clk_change_write_only_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.dram_clk_change_write_only_us =
-// 			(double) dmub_bb_params->dram_clk_change_write_only_ns / 1000.0;
-// 	if (dmub_bb_params->fclk_change_blackout_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.fclk_change_blackout_us =
-// 			(double) dmub_bb_params->fclk_change_blackout_ns / 1000.0;
-// 	if (dmub_bb_params->g7_ppt_blackout_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.g7_ppt_blackout_us =
-// 			(double) dmub_bb_params->g7_ppt_blackout_ns / 1000.0;
-// 	if (dmub_bb_params->stutter_enter_plus_exit_latency_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.stutter_enter_plus_exit_latency_us =
-// 			(double) dmub_bb_params->stutter_enter_plus_exit_latency_ns / 1000.0;
-// 	if (dmub_bb_params->stutter_exit_latency_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.stutter_exit_latency_us =
-// 			(double) dmub_bb_params->stutter_exit_latency_ns / 1000.0;
-// 	if (dmub_bb_params->z8_stutter_enter_plus_exit_latency_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.z8_stutter_enter_plus_exit_latency_us =
-// 			(double) dmub_bb_params->z8_stutter_enter_plus_exit_latency_ns / 1000.0;
-// 	if (dmub_bb_params->z8_stutter_exit_latency_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.z8_stutter_exit_latency_us =
-// 			(double) dmub_bb_params->z8_stutter_exit_latency_ns / 1000.0;
-// 	if (dmub_bb_params->z8_min_idle_time_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.z8_min_idle_time =
-// 			(double) dmub_bb_params->z8_min_idle_time_ns / 1000.0;
-// #ifndef TRIM_DML2_DCN6B_IP_SENSITIVE
-// 	if (dmub_bb_params->type_b_dram_clk_change_blackout_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.lpddr5_dram_clk_change_blackout_us =
-// 			(double) dmub_bb_params->type_b_dram_clk_change_blackout_ns / 1000.0;
-// 	if (dmub_bb_params->type_b_ppt_blackout_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.lpddr5_ppt_blackout_us =
-// 			(double) dmub_bb_params->type_b_ppt_blackout_ns / 1000.0;
-// #else
-// 	if (dmub_bb_params->type_b_dram_clk_change_blackout_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.type_b_dram_clk_change_blackout_us =
-// 			(double) dmub_bb_params->type_b_dram_clk_change_blackout_ns / 1000.0;
-// 	if (dmub_bb_params->type_b_ppt_blackout_ns > 0)
-// 		dml_init->soc_bb.power_management_parameters.type_b_ppt_blackout_us =
-// 			(double) dmub_bb_params->type_b_ppt_blackout_ns / 1000.0;
-// #endif
-// 	if (dmub_bb_params->vmin_limit_dispclk_khz > 0)
-// 		dml_init->soc_bb.vmin_limit.dispclk_khz = dmub_bb_params->vmin_limit_dispclk_khz;
-// 	if (dmub_bb_params->vmin_limit_dcfclk_khz > 0)
-// 		dml_init->soc_bb.vmin_limit.dcfclk_khz = dmub_bb_params->vmin_limit_dcfclk_khz;
-//	if (dmub_bb_params->g7_temperature_read_blackout_ns > 0)
-//		dml_init->soc_bb.power_management_parameters.g7_temperature_read_blackout_us =
-//				(double) dmub_bb_params->g7_temperature_read_blackout_ns / 1000.0;
-}
-
-static void override_dml_init_with_values_from_software_policy(struct dml2_initialize_instance_in_out *dml_init,
-		const struct dml2_configuration_options *config,
-		const struct dc *in_dc)
-{
-	if (!config->use_native_soc_bb_construction) {
+	if (config->use_native_soc_bb_construction) {
+		in_dc->soc_and_ip_translator->translator_funcs->get_soc_bb(&dml_init->soc_bb, in_dc, config);
+		in_dc->soc_and_ip_translator->translator_funcs->get_ip_caps(&dml_init->ip_caps);
+	} else {
 		dml_init->soc_bb = config->external_socbb_ip_params->soc_bb;
 		dml_init->ip_caps = config->external_socbb_ip_params->ip_params;
 	}
 
-	if (in_dc->bb_overrides.sr_exit_time_ns)
-		dml_init->soc_bb.power_management_parameters.stutter_exit_latency_us =
-				in_dc->bb_overrides.sr_exit_time_ns / 1000.0;
-
-	if (in_dc->bb_overrides.sr_enter_plus_exit_time_ns)
-		dml_init->soc_bb.power_management_parameters.stutter_enter_plus_exit_latency_us =
-				in_dc->bb_overrides.sr_enter_plus_exit_time_ns / 1000.0;
-
-	if (in_dc->bb_overrides.dram_clock_change_latency_ns)
-		dml_init->soc_bb.power_management_parameters.dram_clk_change_blackout_us =
-				in_dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
-
-	if (in_dc->bb_overrides.fclk_clock_change_latency_ns)
-		dml_init->soc_bb.power_management_parameters.fclk_change_blackout_us =
-				in_dc->bb_overrides.fclk_clock_change_latency_ns / 1000.0;
-}
-
-void dml21_populate_dml_init_params(struct dml2_initialize_instance_in_out *dml_init,
-		const struct dml2_configuration_options *config,
-		const struct dc *in_dc)
-{
-	populate_default_dml_init_params(dml_init, config, in_dc);
-
-	override_dml_init_with_values_from_hardware_default(dml_init, config, in_dc);
-
-	override_dml_init_with_values_from_smu(dml_init, config, in_dc);
-
-	override_dml_init_with_values_from_vbios(dml_init, config, in_dc);
-
-	override_dml_init_with_values_from_dmub(dml_init, config, in_dc);
-
-	override_dml_init_with_values_from_software_policy(dml_init, config, in_dc);
+	dml21_populate_pmo_options(&dml_init->options.pmo_options, in_dc, config);
 }
 
 static unsigned int calc_max_hardware_v_total(const struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 03de3cf06ae5..798abb2b2e67 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -60,7 +60,7 @@ static void dml21_init(const struct dc *in_dc, struct dml2_context *dml_ctx, con
 
 	DC_FP_START();
 
-	dml21_populate_dml_init_params(&dml_ctx->v21.dml_init, config, in_dc);
+	dml21_populate_dml_init_params(&dml_ctx->v21.dml_init, &dml_ctx->config, in_dc);
 
 	dml2_initialize_instance(&dml_ctx->v21.dml_init);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h b/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
new file mode 100644
index 000000000000..23daf98b8aa8
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#ifndef __SOC_AND_IP_TRANSLATOR_H__
+#define __SOC_AND_IP_TRANSLATOR_H__
+
+#include "dc.h"
+#include "dml_top_soc_parameter_types.h"
+
+struct soc_and_ip_translator_funcs {
+	void (*get_soc_bb)(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config);
+	void (*get_ip_caps)(struct dml2_ip_capabilities *dml_ip_caps);
+};
+
+struct soc_and_ip_translator {
+	const struct soc_and_ip_translator_funcs *translator_funcs;
+};
+
+struct soc_and_ip_translator *dc_create_soc_and_ip_translator(enum dce_version dc_version);
+void dc_destroy_soc_and_ip_translator(struct soc_and_ip_translator **soc_and_ip_translator);
+
+
+#endif // __SOC_AND_IP_TRANSLATOR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
new file mode 100644
index 000000000000..bc93356a0b5b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright 2025 Advanced Micro Devices, Inc.
+# Makefile for bounding box component.
+# Floating point required due to nature of bounding box values
+
+soc_and_ip_translator_ccflags := $(CC_FLAGS_FPU)
+soc_and_ip_translator_rcflags := $(CC_FLAGS_NO_FPU)
+
+CFLAGS_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.o := $(soc_and_ip_translator_ccflags)
+
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.o := $(soc_and_ip_translator_rcflags)
+
+soc_and_ip_translator := soc_and_ip_translator.o
+soc_and_ip_translator += dcn401/dcn401_soc_and_ip_translator.o
+
+AMD_DAL_soc_and_ip_translator := $(addprefix $(AMDDALPATH)/dc/soc_and_ip_translator/, $(soc_and_ip_translator))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_soc_and_ip_translator)
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
new file mode 100644
index 000000000000..3190c76eb482
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#include "dcn401_soc_and_ip_translator.h"
+#include "bounding_boxes/dcn4_soc_bb.h"
+
+/* soc_and_ip_translator component used to get up-to-date values for bounding box.
+ * Bounding box values are stored in several locations and locations can vary with DCN revision.
+ * This component provides an interface to get DCN-specific bounding box values.
+ */
+
+static void get_default_soc_bb(struct dml2_soc_bb *soc_bb)
+{
+	memcpy(soc_bb, &dml2_socbb_dcn401, sizeof(struct dml2_soc_bb));
+	memcpy(&soc_bb->qos_parameters, &dml_dcn4_variant_a_soc_qos_params, sizeof(struct dml2_soc_qos_parameters));
+}
+
+/*
+ * DC clock table is obtained from SMU during runtime.
+ * SMU stands for System Management Unit. It is a power management processor.
+ * It owns the initialization of dc's clock table and programming of clock values
+ * based on dc's requests.
+ * Our clock values in base soc bb is a dummy placeholder. The real clock values
+ * are retrieved from SMU firmware to dc clock table at runtime.
+ * This function overrides our dummy placeholder values with real values in dc
+ * clock table.
+ */
+static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
+		struct dml2_soc_state_table *dml_clk_table,
+		const struct clk_bw_params *dc_bw_params,
+		bool use_clock_dc_limits)
+{
+	int i;
+	const struct clk_limit_table *dc_clk_table;
+
+	if (dc_bw_params == NULL)
+		/* skip if bw params could not be obtained from smu */
+		return;
+
+	dc_clk_table = &dc_bw_params->clk_table;
+
+	/* dcfclk */
+	if (dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
+		dml_clk_table->dcfclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->dcfclk.num_clk_values) {
+				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.dcfclk_mhz &&
+						dc_clk_table->entries[i].dcfclk_mhz > dc_bw_params->dc_mode_limit.dcfclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].dcfclk_mhz < dc_bw_params->dc_mode_limit.dcfclk_mhz) {
+						dml_clk_table->dcfclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dcfclk_mhz * 1000;
+						dml_clk_table->dcfclk.num_clk_values = i + 1;
+					} else {
+						dml_clk_table->dcfclk.clk_values_khz[i] = 0;
+						dml_clk_table->dcfclk.num_clk_values = i;
+					}
+				} else {
+					dml_clk_table->dcfclk.clk_values_khz[i] = dc_clk_table->entries[i].dcfclk_mhz * 1000;
+				}
+			} else {
+				dml_clk_table->dcfclk.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* fclk */
+	if (dc_clk_table->num_entries_per_clk.num_fclk_levels) {
+		dml_clk_table->fclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_fclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->fclk.num_clk_values) {
+				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.fclk_mhz &&
+						dc_clk_table->entries[i].fclk_mhz > dc_bw_params->dc_mode_limit.fclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].fclk_mhz < dc_bw_params->dc_mode_limit.fclk_mhz) {
+						dml_clk_table->fclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.fclk_mhz * 1000;
+						dml_clk_table->fclk.num_clk_values = i + 1;
+					} else {
+						dml_clk_table->fclk.clk_values_khz[i] = 0;
+						dml_clk_table->fclk.num_clk_values = i;
+					}
+				} else {
+					dml_clk_table->fclk.clk_values_khz[i] = dc_clk_table->entries[i].fclk_mhz * 1000;
+				}
+			} else {
+				dml_clk_table->fclk.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* uclk */
+	if (dc_clk_table->num_entries_per_clk.num_memclk_levels) {
+		dml_clk_table->uclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_memclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->uclk.num_clk_values) {
+				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.memclk_mhz &&
+						dc_clk_table->entries[i].memclk_mhz > dc_bw_params->dc_mode_limit.memclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].memclk_mhz < dc_bw_params->dc_mode_limit.memclk_mhz) {
+						dml_clk_table->uclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.memclk_mhz * 1000;
+						dml_clk_table->uclk.num_clk_values = i + 1;
+					} else {
+						dml_clk_table->uclk.clk_values_khz[i] = 0;
+						dml_clk_table->uclk.num_clk_values = i;
+					}
+				} else {
+					dml_clk_table->uclk.clk_values_khz[i] = dc_clk_table->entries[i].memclk_mhz * 1000;
+				}
+			} else {
+				dml_clk_table->uclk.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* dispclk */
+	if (dc_clk_table->num_entries_per_clk.num_dispclk_levels) {
+		dml_clk_table->dispclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dispclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->dispclk.num_clk_values) {
+				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.dispclk_mhz &&
+						dc_clk_table->entries[i].dispclk_mhz > dc_bw_params->dc_mode_limit.dispclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].dispclk_mhz < dc_bw_params->dc_mode_limit.dispclk_mhz) {
+						dml_clk_table->dispclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dispclk_mhz * 1000;
+						dml_clk_table->dispclk.num_clk_values = i + 1;
+					} else {
+						dml_clk_table->dispclk.clk_values_khz[i] = 0;
+						dml_clk_table->dispclk.num_clk_values = i;
+					}
+				} else {
+					dml_clk_table->dispclk.clk_values_khz[i] = dc_clk_table->entries[i].dispclk_mhz * 1000;
+				}
+			} else {
+				dml_clk_table->dispclk.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* dppclk */
+	if (dc_clk_table->num_entries_per_clk.num_dppclk_levels) {
+		dml_clk_table->dppclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dppclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->dppclk.num_clk_values) {
+				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.dppclk_mhz &&
+						dc_clk_table->entries[i].dppclk_mhz > dc_bw_params->dc_mode_limit.dppclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].dppclk_mhz < dc_bw_params->dc_mode_limit.dppclk_mhz) {
+						dml_clk_table->dppclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dppclk_mhz * 1000;
+						dml_clk_table->dppclk.num_clk_values = i + 1;
+					} else {
+						dml_clk_table->dppclk.clk_values_khz[i] = 0;
+						dml_clk_table->dppclk.num_clk_values = i;
+					}
+				} else {
+					dml_clk_table->dppclk.clk_values_khz[i] = dc_clk_table->entries[i].dppclk_mhz * 1000;
+				}
+			} else {
+				dml_clk_table->dppclk.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* dtbclk */
+	if (dc_clk_table->num_entries_per_clk.num_dtbclk_levels) {
+		dml_clk_table->dtbclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dtbclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->dtbclk.num_clk_values) {
+				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.dtbclk_mhz &&
+						dc_clk_table->entries[i].dtbclk_mhz > dc_bw_params->dc_mode_limit.dtbclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].dtbclk_mhz < dc_bw_params->dc_mode_limit.dtbclk_mhz) {
+						dml_clk_table->dtbclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dtbclk_mhz * 1000;
+						dml_clk_table->dtbclk.num_clk_values = i + 1;
+					} else {
+						dml_clk_table->dtbclk.clk_values_khz[i] = 0;
+						dml_clk_table->dtbclk.num_clk_values = i;
+					}
+				} else {
+					dml_clk_table->dtbclk.clk_values_khz[i] = dc_clk_table->entries[i].dtbclk_mhz * 1000;
+				}
+			} else {
+				dml_clk_table->dtbclk.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* socclk */
+	if (dc_clk_table->num_entries_per_clk.num_socclk_levels) {
+		dml_clk_table->socclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_socclk_levels;
+		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
+			if (i < dml_clk_table->socclk.num_clk_values) {
+				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.socclk_mhz &&
+						dc_clk_table->entries[i].socclk_mhz > dc_bw_params->dc_mode_limit.socclk_mhz) {
+					if (i == 0 || dc_clk_table->entries[i-1].socclk_mhz < dc_bw_params->dc_mode_limit.socclk_mhz) {
+						dml_clk_table->socclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.socclk_mhz * 1000;
+						dml_clk_table->socclk.num_clk_values = i + 1;
+					} else {
+						dml_clk_table->socclk.clk_values_khz[i] = 0;
+						dml_clk_table->socclk.num_clk_values = i;
+					}
+				} else {
+					dml_clk_table->socclk.clk_values_khz[i] = dc_clk_table->entries[i].socclk_mhz * 1000;
+				}
+			} else {
+				dml_clk_table->socclk.clk_values_khz[i] = 0;
+			}
+		}
+	}
+
+	/* dram config */
+	dml_clk_table->dram_config.channel_count = dc_bw_params->num_channels;
+	dml_clk_table->dram_config.channel_width_bytes = dc_bw_params->dram_channel_width_bytes;
+}
+
+void dcn401_update_soc_bb_with_values_from_clk_mgr(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
+{
+	soc_bb->dprefclk_mhz = dc->clk_mgr->dprefclk_khz / 1000;
+	soc_bb->dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+	soc_bb->mall_allocated_for_dcn_mbytes = dc->caps.mall_size_total / (1024 * 1024);
+
+	if (dc->clk_mgr->funcs->is_smu_present &&
+			dc->clk_mgr->funcs->is_smu_present(dc->clk_mgr)) {
+		dcn401_convert_dc_clock_table_to_soc_bb_clock_table(&soc_bb->clk_table,
+			dc->clk_mgr->bw_params,
+			config->use_clock_dc_limits);
+	}
+}
+
+void dcn401_update_soc_bb_with_values_from_vbios(struct dml2_soc_bb *soc_bb, const struct dc *dc)
+{
+	soc_bb->dchub_refclk_mhz = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
+	soc_bb->xtalclk_mhz = dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency / 1000;
+
+	/* latencies in vbios are platform specific and should be used if provided */
+	if (dc->ctx->dc_bios->bb_info.dram_clock_change_latency_100ns)
+		soc_bb->power_management_parameters.dram_clk_change_blackout_us =
+				dc->ctx->dc_bios->bb_info.dram_clock_change_latency_100ns / 10.0;
+
+	if (dc->ctx->dc_bios->bb_info.dram_sr_enter_exit_latency_100ns)
+		soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us =
+				dc->ctx->dc_bios->bb_info.dram_sr_enter_exit_latency_100ns / 10.0;
+
+	if (dc->ctx->dc_bios->bb_info.dram_sr_exit_latency_100ns)
+		soc_bb->power_management_parameters.stutter_exit_latency_us =
+			dc->ctx->dc_bios->bb_info.dram_sr_exit_latency_100ns / 10.0;
+}
+
+void dcn401_update_soc_bb_with_values_from_software_policy(struct dml2_soc_bb *soc_bb, const struct dc *dc)
+{
+	/* set if the value is provided */
+	if (dc->bb_overrides.sr_exit_time_ns)
+		soc_bb->power_management_parameters.stutter_exit_latency_us =
+				dc->bb_overrides.sr_exit_time_ns / 1000.0;
+
+	if (dc->bb_overrides.sr_enter_plus_exit_time_ns)
+		soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us =
+				dc->bb_overrides.sr_enter_plus_exit_time_ns / 1000.0;
+
+	if (dc->bb_overrides.dram_clock_change_latency_ns)
+		soc_bb->power_management_parameters.dram_clk_change_blackout_us =
+				dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
+
+	if (dc->bb_overrides.fclk_clock_change_latency_ns)
+		soc_bb->power_management_parameters.fclk_change_blackout_us =
+				dc->bb_overrides.fclk_clock_change_latency_ns / 1000.0;
+
+	//Z8 values not expected nor used on DCN401 but still added for completeness
+	if (dc->bb_overrides.sr_exit_z8_time_ns)
+		soc_bb->power_management_parameters.z8_stutter_exit_latency_us =
+				dc->bb_overrides.sr_exit_z8_time_ns / 1000.0;
+
+	if (dc->bb_overrides.sr_enter_plus_exit_z8_time_ns)
+		soc_bb->power_management_parameters.z8_stutter_enter_plus_exit_latency_us =
+				dc->bb_overrides.sr_enter_plus_exit_z8_time_ns / 1000.0;
+}
+
+static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
+{
+	/* Individual modification can be overwritten even if it was obtained by a previous function.
+	 * Modifications are acquired in order of priority (lowest to highest).
+	 */
+	dc_assert_fp_enabled();
+
+	dcn401_update_soc_bb_with_values_from_clk_mgr(soc_bb, dc, config);
+	dcn401_update_soc_bb_with_values_from_vbios(soc_bb, dc);
+	dcn401_update_soc_bb_with_values_from_software_policy(soc_bb, dc);
+}
+
+void dcn401_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
+{
+	//get default soc_bb with static values
+	get_default_soc_bb(soc_bb);
+	//update soc_bb values with more accurate values
+	apply_soc_bb_updates(soc_bb, dc, config);
+}
+
+static void dcn401_get_ip_caps(struct dml2_ip_capabilities *ip_caps)
+{
+	*ip_caps = dml2_dcn401_max_ip_caps;
+}
+
+static struct soc_and_ip_translator_funcs dcn401_translator_funcs = {
+	.get_soc_bb = dcn401_get_soc_bb,
+	.get_ip_caps = dcn401_get_ip_caps,
+};
+
+void dcn401_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator)
+{
+	soc_and_ip_translator->translator_funcs = &dcn401_translator_funcs;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h
new file mode 100644
index 000000000000..21d842857601
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#ifndef _DCN401_SOC_AND_IP_TRANSLATOR_H_
+#define _DCN401_SOC_AND_IP_TRANSLATOR_H_
+
+#include "core_types.h"
+#include "dc.h"
+#include "clk_mgr.h"
+#include "soc_and_ip_translator.h"
+#include "dml2/dml21/inc/dml_top_soc_parameter_types.h"
+
+void dcn401_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator);
+
+/* Functions that can be re-used by higher DCN revisions of this component */
+void dcn401_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config);
+void dcn401_update_soc_bb_with_values_from_clk_mgr(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config);
+void dcn401_update_soc_bb_with_values_from_vbios(struct dml2_soc_bb *soc_bb, const struct dc *dc);
+void dcn401_update_soc_bb_with_values_from_software_policy(struct dml2_soc_bb *soc_bb, const struct dc *dc);
+
+#endif /* _DCN401_SOC_AND_IP_TRANSLATOR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
new file mode 100644
index 000000000000..c9e224d262c9
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#include "dcn42_soc_and_ip_translator.h"
+#include "soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h"
+#include "bounding_boxes/dcn42_soc_bb.h"
+
+/* soc_and_ip_translator component used to get up-to-date values for bounding box.
+ * Bounding box values are stored in several locations and locations can vary with DCN revision.
+ * This component provides an interface to get DCN-specific bounding box values.
+ */
+
+static void dcn42_get_ip_caps(struct dml2_ip_capabilities *ip_caps)
+{
+	*ip_caps = dml2_dcn42_max_ip_caps;
+}
+
+static struct soc_and_ip_translator_funcs dcn42_translator_funcs = {
+	.get_soc_bb = dcn401_get_soc_bb,
+	.get_ip_caps = dcn42_get_ip_caps,
+};
+
+void dcn42_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator)
+{
+	soc_and_ip_translator->translator_funcs = &dcn42_translator_funcs;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h
new file mode 100644
index 000000000000..914dcbb369a7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#ifndef _DCN42_SOC_AND_IP_TRANSLATOR_H_
+#define _DCN42_SOC_AND_IP_TRANSLATOR_H_
+
+#include "core_types.h"
+#include "dc.h"
+#include "clk_mgr.h"
+#include "dml_top_soc_parameter_types.h"
+#include "soc_and_ip_translator.h"
+
+void dcn42_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator);
+
+#endif /* _DCN42_SOC_AND_IP_TRANSLATOR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c
new file mode 100644
index 000000000000..0fc0e5a6c171
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/soc_and_ip_translator.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#include "soc_and_ip_translator.h"
+#include "soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h"
+
+static void dc_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator,
+		enum dce_version dc_version)
+{
+	switch (dc_version) {
+	case DCN_VERSION_4_01:
+		dcn401_construct_soc_and_ip_translator(soc_and_ip_translator);
+		break;
+	default:
+		break;
+	}
+}
+
+struct soc_and_ip_translator *dc_create_soc_and_ip_translator(enum dce_version dc_version)
+{
+	struct soc_and_ip_translator *soc_and_ip_translator;
+
+	soc_and_ip_translator = kzalloc(sizeof(*soc_and_ip_translator), GFP_KERNEL);
+	if (!soc_and_ip_translator)
+		return NULL;
+
+	dc_construct_soc_and_ip_translator(soc_and_ip_translator, dc_version);
+
+	return soc_and_ip_translator;
+}
+
+void dc_destroy_soc_and_ip_translator(struct soc_and_ip_translator **soc_and_ip_translator)
+{
+	kfree(*soc_and_ip_translator);
+	*soc_and_ip_translator = NULL;
+}
-- 
2.43.0

