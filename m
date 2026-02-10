Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADE5EA811B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D595F10E573;
	Tue, 10 Feb 2026 13:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mh2sef7G";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E7710E573
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNWTZTM9y5aEaBTqxqGnSry7qFQniqiqNZC+vW/i2bYAzEV9+SKitRG7JYu6vnu0zqDKrRl398Nx6jfVQ8hKHdUqPMKZ8i02iia9pLVMRw9Vfad4s4J7lSVISzpKvi4NW36c8WQHwfuA2zIF8iuZmd8N15As27c1weYLqdmYT5JTTiSO3oVY1ANhtg+ShiX2nVOYcw58i0m1MkLisHW5YogMXYfPdgWeJEUQ7Rg2icvcqdRFqQsrW/tz7OOrzl4tkzqO59J+Q+ZbhR3DEsAaAYB+IOQWRfk8dc3FhqXeqBOR/FuzkYJkmk8OBcSfCzUP0Rhw/0cxv4LuIiXh25eRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXdEc+WIjCipzPob+R5pX/XkefuGS5WGfQfLcj9XEoc=;
 b=XEwHzik3hoFITUWH0650qFZWllPjk886JaYm5IwwAwaz25KARR5aSRZL8czWh/PB7xPJcCeATVX/5lGx4WguF7vAnLI1hDXaJ0Hn3xG9EIWYAbzs44en9sbSyYU565YPkxVt/fFFe4jRddYGlQOMwCxrzH/WEACxSS/4pAGQXFnKA8N+VlC5TTlb8k+o0y8FVT+U8JzIXNKXWRxJN0NmMHtYK4tV16Utu/nM5lgUJIZOv/Wuz3JW4SCA0CEiyTCDcmKAdlqKAfnH/5FyZPH+bfJMaj691XqLAkExLStrHdUileSuiHrHLBO6RqISJF6s2RLz1coS1gYa8XU/GBtUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXdEc+WIjCipzPob+R5pX/XkefuGS5WGfQfLcj9XEoc=;
 b=mh2sef7GFtreYwmh9VVqg6XC/DjfeNMCOGG9IqrYGJSVru0D4nE7VTaD8lh/z9xTP2EYWg/U9aQZyCPY5YiCPk4NxnJrtq5xpHaevVDiAGqSivjlwnvG3dmkj6cohU9q9G6lglOf3oPbntfxp3rP4BnMGhet/B63SyiKXvtIPvE=
Received: from PH3PEPF00004099.namprd05.prod.outlook.com (2603:10b6:518:1::45)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:55:14 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH3PEPF00004099.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Tue,
 10 Feb 2026 13:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 13:55:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:55:09 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:55:08 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:55:00 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 06/18] drm/amd/display: Disable SR feature on eDP1 by default
Date: Tue, 10 Feb 2026 21:49:59 +0800
Message-ID: <20260210135353.848421-7-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 7374716a-ab3b-4e99-9ccc-08de68ac0382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?96QBnWQ0KIY0Xx1pRTTCSnZoKo/TmXG5XYvJGnC17u4BvLZSLwQ7YsUs3KoX?=
 =?us-ascii?Q?FG1bwmt9rlSaRhQb26tbywzU3AmQ4VEZOE3EbpD8q3RzBD757dZ7gCqW+QHR?=
 =?us-ascii?Q?fyhJ2MSBMqqc8FJ38mLhRaLiKu2T/X+zdJHRxYuDJG7t4M9RL9eysU16Dqc1?=
 =?us-ascii?Q?DNoUGE2K/RB9C0ikm0mWKEFtzoLzkwq6PMQZ+sQSRcSdXL32vYlNBTGJpBFE?=
 =?us-ascii?Q?tEnC1MgEjz0Y0y72uBIVf67m1KRZdbna8N5Y2oyR+/Mt4/+PYZmCg0R5qceZ?=
 =?us-ascii?Q?OTwBJ88ptPJiGR2AhOj/IWns6HR1v3hZix/tefwbgCjRFQWBjB6A80f+HImP?=
 =?us-ascii?Q?UTA9Ku6pkzUNrbNEJ96+5P2dRCjcbxEY2h7R4mTy49FtwERy8RAlqgOfG2QO?=
 =?us-ascii?Q?jkyimG1uZCXpUONuOzEp5a08slYZeFccH9CIv+7k+URj2LjHUWCm1v1mxgwz?=
 =?us-ascii?Q?SzAfuYUJUTdO+oQM1V9pBdqwOSzhcDRm/0pfXNECweWPztvjAzIkJj26iH3h?=
 =?us-ascii?Q?PQ+SdbHSVMkgyeG6vaBiyLLS1uDOxBX94dXMelFUyk+kM7cF2LB1nFbLpcvO?=
 =?us-ascii?Q?vwqjqq1DD7KHsgAsBijfXChsb7IeNb+BX9uie2NnT7/ZEed8InWlclwolzzl?=
 =?us-ascii?Q?JBvhuIQ1RricUstsfG2rlL2ULB16NJg9Jj/0VieR1uq7XvY3xmwdsN8f44lZ?=
 =?us-ascii?Q?4sbbrgrmcX4JvxcYUb+qtv+ZyL7xsbQI4weNBoGX5gGlTMetpA2Hg0h9fi3u?=
 =?us-ascii?Q?DXGKM86pM3tcavL+a6CtJT9yzek2YMND8j43L21CzrvDhZGtl0i7W3OHz4T5?=
 =?us-ascii?Q?wRHH1//ELNRr2AseuxZ1OHPA6HLHo3SEug4gQwy2w0e1cI5W3mrMozJ23sVz?=
 =?us-ascii?Q?uaXZXhlnpJk7NiejrXnVcs6v1E9+Oa2S4NhNG8Uvp5uXgH26GTfjIvD/BZ+x?=
 =?us-ascii?Q?d8+i0ZgmOWhl2EmKdwSI/rxmecd4tHQbQvqxYdE7bRjM0LOg9f3UPygl/EIQ?=
 =?us-ascii?Q?PV+r+J6SJHgcatnNcKTtqUVzm0SwthxvuVGeXWdc0QWaEJ8GOWgQq+OhPM81?=
 =?us-ascii?Q?Z3XI2nqXcWVG1/77mqep8ksrHbLr3AjtjXUlbMTwd4fkpKiOOYRes+MTlcA1?=
 =?us-ascii?Q?rWWFj6+xtodBeBSmiV8jgRovGzHHgFyyk/tvsKKkvyziROTdMfNZ0rEgLklv?=
 =?us-ascii?Q?fB7LuI2bMfCt8YW7uKWo6LWoglJY60lcvwVng0i8HGu2/deUj95BogBzy+LY?=
 =?us-ascii?Q?P5KAX5bjSlPEtPUgYItXCQbRlPlgzQDJV3e2SSqC2uJoWdh0ealHO0IYZTqo?=
 =?us-ascii?Q?sCKcg6vHxX91ELBSy4b3dicMdZMvlYYPxOQbuBW/2564EXxhvzBLwwN8hspv?=
 =?us-ascii?Q?pci6fmUO2DTKcAgmD9agf/sEdMWVEg1tsKFAi1qybe33k0dB+4kf2dMrdFwm?=
 =?us-ascii?Q?OY4Milu34t3TbDZwuyJkJ0xmIbp9Uy9NDf4I5BIHtIjrLDP+d4v0R6s3QAtz?=
 =?us-ascii?Q?iUfXfeMtF8FwIIc32GQBi4HXhmwfoaH/8nMp4eIpQKYDKOpqLXLURaxUVTYt?=
 =?us-ascii?Q?xRagb7fYhx/1nLvbdscPU4BIWcLeZuITWVPBi4XOv523Xye0myHB3DTtbs8A?=
 =?us-ascii?Q?LK2HyaJZnaehfefbDwRUAzy4exOeox84/SXfg2NpYs72+RnWm8yKNt5xEZH9?=
 =?us-ascii?Q?wxyPlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IJ8uR0ITVmJhAP/6s/3H8fjZ5emEsIFsikziLGbDfVYfqfOOKpJlrpxB3pUcmN0uH4vso+2nnnI+6W9a8kSNJZAM7jGWHzGnCrpnBwjSWhnayZgfNt56S+p9rcXPy5D4G8vfql4VjwN3zvX8LYLtaEDZuPXnXONSxZYloVDssA8oy+Ct0GdV36qtk6q9Iq3QUc5sckW3/sBLXEkGkKuT2dn/04UVg1WD5obTOWoi/ZSRyA87FUHF6X7kyi6ES775Qpd9pHsXGRFuM0SS+jnZMWhdj7Op2dEbcndGaCIRKMs65NW8TGMuxKJ3elFdnkrguPxmzOnq8UNH0jpZnvr74+NAAVHjQgYg69tpHS9IH1/NlB1IZzMjyK2l3YQaYDGsGm0BmRbrE5T5AXS2exW7m/t71uyOmT0b0XeGCwm9/O/Qqy8Y2cd9+N7HaDIMK5GG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:55:13.4867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7374716a-ab3b-4e99-9ccc-08de68ac0382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why & How]
Disable SR feature on eDP1 by default.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 12 ++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c    |  8 ++++++++
 drivers/gpu/drm/amd/display/dc/dc.h                  |  1 -
 drivers/gpu/drm/amd/display/dc/dm_helpers.h          |  2 +-
 drivers/gpu/drm/amd/display/dc/link/link_detection.c |  2 +-
 5 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 1f41d6540b83..bf2a356b3475 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1153,11 +1153,19 @@ void dm_helpers_init_panel_settings(
 
 void dm_helpers_override_panel_settings(
 	struct dc_context *ctx,
-	struct dc_panel_config *panel_config)
+	struct dc_link *link)
 {
+	unsigned int panel_inst = 0;
+
 	// Feature DSC
 	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
-		panel_config->dsc.disable_dsc_edp = true;
+		link->panel_config.dsc.disable_dsc_edp = true;
+
+	if (dc_get_edp_link_panel_inst(ctx->dc, link, &panel_inst) && panel_inst == 1) {
+			link->panel_config.psr.disable_psr = true;
+			link->panel_config.psr.disallow_psrsu = true;;
+			link->panel_config.psr.disallow_replay = true;
+	}
 }
 
 void *dm_helpers_allocate_gpu_mem(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index fd491b7a3cd7..99d6d6c93561 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -80,12 +80,20 @@ void amdgpu_dm_set_psr_caps(struct dc_link *link)
 		link->psr_settings.psr_feature_enabled = false;
 
 	} else {
+		unsigned int panel_inst = 0;
+
 		if (link_supports_psrsu(link))
 			link->psr_settings.psr_version = DC_PSR_VERSION_SU_1;
 		else
 			link->psr_settings.psr_version = DC_PSR_VERSION_1;
 
 		link->psr_settings.psr_feature_enabled = true;
+
+		/*disable allow psr/psrsu/replay on eDP1*/
+		if (dc_get_edp_link_panel_inst(link->ctx->dc, link, &panel_inst) && panel_inst == 1) {
+			link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
+			link->psr_settings.psr_feature_enabled = false;
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ce08477d1ccd..4c4239cac863 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -505,7 +505,6 @@ union allow_lttpr_non_transparent_mode {
 	} bits;
 	unsigned char raw;
 };
-
 /* Structure to hold configuration flags set by dm at dc creation. */
 struct dc_config {
 	bool gpu_vm_support;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 7014b8c2c956..2818df555e62 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -209,7 +209,7 @@ void dm_helpers_init_panel_settings(
 	struct dc_sink *sink);
 void dm_helpers_override_panel_settings(
 	struct dc_context *ctx,
-	struct dc_panel_config *config);
+	struct dc_link *link);
 int dm_helper_dmub_aux_transfer_sync(
 		struct dc_context *ctx,
 		const struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 578509e8d0e2..b2c020071cbf 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1333,7 +1333,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			// Pickup base DM settings
 			dm_helpers_init_panel_settings(dc_ctx, &link->panel_config, sink);
 			// Override dc_panel_config if system has specific settings
-			dm_helpers_override_panel_settings(dc_ctx, &link->panel_config);
+			dm_helpers_override_panel_settings(dc_ctx, link);
 
 			//sink only can use supported link rate table, we are foreced to enable it
 			if (link->reported_link_cap.link_rate == LINK_RATE_UNKNOWN)
-- 
2.43.0

