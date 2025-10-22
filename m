Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F111BCCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9317B10E6FC;
	Wed, 22 Oct 2025 07:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ypYr5ja7";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FC210E6FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNrRCNv70SnJL/1uyjtrEzJUvHOz/FucOEk6zC5DsRkuI3OoL9zVKBdQgcYPrEYxyPjuv3UshzK5BBJxrbA8ryADcqIe5VhIBLJ9TiHK8Go3ML25VBuZ/D06hs10tTkrRcVxibUtb6we5yVSrGHYuQop9g2TfX8E5JaqEzRDkmVUh+ysleXSkcIqs9ufcEaTe8NkQ7daBVmE9eToYyMH7GCzbt62ty9qmvKIGyZX2IfPwLyhqhiWxrQGf18wERcX4iAaFjiHeHWOv77XBFAJfq2haG/2erhL8MtM9pGJsB38ZtRUi86issmV+yLq2CMeYrTnEW0L+RYOlHG+kqu84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrNhjhACBf8amSuVD/5BiCEnBuSflE+VFGuHWZgTU0k=;
 b=O2jk2hk6w3p8cpnMBSN4yK+s3lI3mNAUfIyoxXOH1MH5L2lrejhRIWovbH3ijJ9kZipUWAg1+xZY2P+2nn2YDy1iG03b0gWF4RNeslRLylQMqN2BDG42karIWbUFzCfQIOh87MtccIoREB5keenLliiWZhn6ML4PnL83+uMXh7OO6YVuwwUGa+gD9090/TTBu2XJsA4x3uCbiw1zRJV36qAB+F0PAB6XClfKqYOJU+zF9gU7AA2ECNZOqAz0uMBMyoV5i3vSglnTRoiVTwp7P2HRP2mZJGP3r7HjDNFRaoe8ADLNPuG40M2HmUdWmkTyl4VaqlRLpJPVWPr1Cn6+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrNhjhACBf8amSuVD/5BiCEnBuSflE+VFGuHWZgTU0k=;
 b=ypYr5ja7OY8Z3vBv15+j1JsfWB6DR7DTuHjLFCKd3Fs3HU6jjl6GiQ1zFJ2tETNIdOeo1wLw6dznaWvUSG3Dc7lGvP3Kc5oY16+GadqWk+ctxM3uAGf6Hi8Dub2iIodbqODWzgpQP0PNfsAi9k82jlE2CjCXONIxYKIH6Bu9wss=
Received: from DM6PR02CA0118.namprd02.prod.outlook.com (2603:10b6:5:1b4::20)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 07:34:26 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::f4) by DM6PR02CA0118.outlook.office365.com
 (2603:10b6:5:1b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:34:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:25 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Oct
 2025 02:34:24 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:34:22 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 07/20] drm/amd/display: Update dml2 references to use dml2_0
 folder
Date: Wed, 22 Oct 2025 15:30:19 +0800
Message-ID: <20251022073332.666119-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cf6acc-4c78-4e87-88b1-08de113d6dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dfE9w9w2Al3HgMOAHnfMQnaavWy/E/tkz51uuccEjUhD6hNmmPTIyZYZnFw4?=
 =?us-ascii?Q?1/jbs+7mXmNWAAcHUbCaKwKTbPtp+dOUbAqlKPuarOSsm2yH56RO8VofhvdC?=
 =?us-ascii?Q?C3nU+dfBe0pqytPNTOSUyyFXCDnZNTb8eLbYB5noPz0ADQi+FTQkHntnBR1w?=
 =?us-ascii?Q?w/EOQUTDL8nbBFZd8S3al227N4P7s/wVuqolLKrlLGzXvnxA6x+diC0ajA3o?=
 =?us-ascii?Q?YQiFLW/z33P1jD6dfiRjv5aD9tPOZ3fCWhsZd9WJ917tYdO6OkFkB6rzbzUP?=
 =?us-ascii?Q?yjsBULKxnPzt+1UIkngCx4k+jXjNZt/17rRHLIHUuTyFSzsFBaW67gL6aUfP?=
 =?us-ascii?Q?yJ+ZkmySQks/CvfHv3yyxTVEHQekuKRjhrOoGIarADkAAikLcqnSZENEWwJk?=
 =?us-ascii?Q?cv0KdlhVX+tDAgUnjwsTC061pMqEWe5ilIGgQ6PYs+SHFC/YkWEO/hONCZ7w?=
 =?us-ascii?Q?qMFVgz1F0B8wSsqPpZ+JvHsmTdfAzUMJ2dmtMNBgm4LzQVTFxbQCOAjlx05T?=
 =?us-ascii?Q?wWNaXghhJFzBc1sNojnMIDOKHeijrj5A6VB7bi6/kGwVh68bFxMrCkQOC7fx?=
 =?us-ascii?Q?xfP8DQ88gXzdL0SykQPdq99iZrCYiplWAkY55MiW9ZocuM9C+ZyDlTMYCJul?=
 =?us-ascii?Q?NXUg4JwAxZQ2hxKNvW8g79rkF9d2TdzZYZvaHat5zqdXVRJBofUBdFiGIL0e?=
 =?us-ascii?Q?V54BzQORCPTMg1q1Uc5gLz5jVKJficNa7ZtOjFgldQBeN7MtqA50Udrhkas9?=
 =?us-ascii?Q?qbivnl602Ze4XkLktdb2xPAfHTpDhj4wos7t5fZmXti2uSiy+Sni8gunWrWe?=
 =?us-ascii?Q?HNz2yccIJJEfXI1Lpy6IHeTtpBkNO/KcE5d4t9CvNRyqKCVIve8/A2IWVWtm?=
 =?us-ascii?Q?50/pBe6VKkVNbvbrcMjU2bZj5cWo3p36ykd+tybP4WV8bjJAs14voub/7H4V?=
 =?us-ascii?Q?2P2bO9IYCvh3vIadzWXPqgIS5JhL/pg637bXinnuC5Ks8bahyUe8wNuaXrbk?=
 =?us-ascii?Q?dkOBf37M14IbBks0IM6Lt/yCMGm3Q9t1uvsXUu7Q2XamngA23G+T1QxPn++U?=
 =?us-ascii?Q?ZijqfNqM4zUQfbcVI6Rj2RrOJsh4vmZufq5P6G+9PrFnM0LdhDEmTA0JoxjQ?=
 =?us-ascii?Q?Yw+GpEI2323gbzGXXyLXcR68hRpb2zdJ7PIZxF5HhA+q+5zW+zR2cuvDJ9wj?=
 =?us-ascii?Q?61Xrt/qa9qdtQymIiToVuUq4c9u/HrV3jWIk6dUdezJBUh8dFkvStlvWeDnX?=
 =?us-ascii?Q?/cQmxBs3b68YB5WTs4UygASgeFb7I1fNhFPm/bD9jgfz2HjQOdvQgcmgFWuY?=
 =?us-ascii?Q?uCXOVOLWxp9kTQJSkH6fFUcvNn1x7ndMJcHbQgDfRkOZ2ybjG744E1wAzNFk?=
 =?us-ascii?Q?HGacppm4i11rqhjfwHSC0GleQZ44sbhj5ocgOrg2W/q+Ge61sBZqKsIYjTb4?=
 =?us-ascii?Q?cI64tjfz+Oa4RyJ3Rt3DcOOlHnEO15HVEqmtQOk7kDmPe6QjyCSYUOMjcIV/?=
 =?us-ascii?Q?TIe9IWeZi8HmmV1qm7XSw8ywqACDe4YUbzmWlmLUHQ99PPRtJ9Fj2kvAavwW?=
 =?us-ascii?Q?tir20geiv3vybJKYJ59zq6dVU8LIjQBytKUCe3iU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:34:26.5516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cf6acc-4c78-4e87-88b1-08de113d6dd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
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

[Why & How]
To switch to use dml2_0 folder, change all DML2 references to use
the dml2_0 folder instead of the dml2 folder.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile                       | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c                      | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c             | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c                | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h                           | 2 +-
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h      | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h               | 4 ++--
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h                  | 4 ++--
 drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h             | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c  | 2 +-
 .../dcn401/dcn401_soc_and_ip_translator.h                     | 2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index dc943abd6dba..7277ed21552f 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -36,7 +36,7 @@ DC_LIBS += dcn30
 DC_LIBS += dcn301
 DC_LIBS += dcn31
 DC_LIBS += dml
-DC_LIBS += dml2
+DC_LIBS += dml2_0
 DC_LIBS += soc_and_ip_translator
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c4ef63011f47..246ea9754810 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -83,7 +83,7 @@
 #include "hw_sequencer_private.h"
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
-#include "dml2/dml2_internal_types.h"
+#include "dml2_0/dml2_internal_types.h"
 #include "soc_and_ip_translator.h"
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index bc5dedf5f60c..8d0cdbf14e17 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -95,7 +95,7 @@
 #define DC_LOGGER \
 	dc->ctx->logger
 #define DC_LOGGER_INIT(logger)
-#include "dml2/dml2_wrapper.h"
+#include "dml2_0/dml2_wrapper.h"
 
 #define UNABLE_TO_SPLIT -1
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index c61300a7cb1c..2de8ef4a58ec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -35,8 +35,8 @@
 #include "link_enc_cfg.h"
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
-#include "dml2/dml2_wrapper.h"
-#include "dml2/dml2_internal_types.h"
+#include "dml2_0/dml2_wrapper.h"
+#include "dml2_0/dml2_internal_types.h"
 #endif
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 14fca9dfe272..769b2c2f9d7f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#include "dml2/dml2_wrapper.h"
+#include "dml2_0/dml2_wrapper.h"
 
 #include "dmub/inc/dmub_cmd.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index fdabbeec8ffa..4570b8016de5 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -31,7 +31,7 @@
 #include "dcn30/dcn30_hubp.h"
 #include "dcn31/dcn31_hubp.h"
 #include "dcn32/dcn32_hubp.h"
-#include "dml2/dml21/inc/dml_top_dchub_registers.h"
+#include "dml2_0/dml21/inc/dml_top_dchub_registers.h"
 
 #define HUBP_3DLUT_FL_REG_LIST_DCN401(inst)\
 	SRI_ARR_US(_3DLUT_FL_CONFIG, HUBP, inst),\
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index d11893f8c916..3fe590436e74 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -58,8 +58,8 @@
 #include "transform.h"
 #include "dpp.h"
 
-#include "dml2/dml21/inc/dml_top_dchub_registers.h"
-#include "dml2/dml21/inc/dml_top_types.h"
+#include "dml2_0/dml21/inc/dml_top_dchub_registers.h"
+#include "dml2_0/dml21/inc/dml_top_types.h"
 
 struct resource_pool;
 struct dc_state;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index b0c13b506c11..c62c4c1ed7c3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -41,8 +41,8 @@
 #include "mem_input.h"
 #include "cursor_reg_cache.h"
 
-#include "dml2/dml21/inc/dml_top_dchub_registers.h"
-#include "dml2/dml21/inc/dml_top_types.h"
+#include "dml2_0/dml21/inc/dml_top_dchub_registers.h"
+#include "dml2_0/dml21/inc/dml_top_types.h"
 
 #define OPP_ID_INVALID 0xf
 #define MAX_TTU 0xffffff
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
index 42fbc70f7056..d468bc85566a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
@@ -29,7 +29,7 @@
 #include "include/grph_object_id.h"
 
 #include "dml/display_mode_structs.h"
-#include "dml2/dml21/inc/dml_top_dchub_registers.h"
+#include "dml2_0/dml21/inc/dml_top_dchub_registers.h"
 
 struct dchub_init_data;
 struct cstate_pstate_watermarks_st {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 3965a7f1b64b..4c2e8aa96d1f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -92,7 +92,7 @@
 
 #include "dc_state_priv.h"
 
-#include "dml2/dml2_wrapper.h"
+#include "dml2_0/dml2_wrapper.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index fff57f23f4f7..3a83a63d2116 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -33,7 +33,7 @@
 #include "resource.h"
 #include "include/irq_service_interface.h"
 #include "dcn35_resource.h"
-#include "dml2/dml2_wrapper.h"
+#include "dml2_0/dml2_wrapper.h"
 
 #include "dcn20/dcn20_resource.h"
 #include "dcn30/dcn30_resource.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 0abd163b425e..d00cc4030be3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -83,7 +83,7 @@
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
 
-#include "dml2/dml2_wrapper.h"
+#include "dml2_0/dml2_wrapper.h"
 
 #include "link_enc_cfg.h"
 #define DC_LOGGER_INIT(logger)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index ca125ee6c2fb..f4b28617b2de 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -11,7 +11,7 @@
 #include "resource.h"
 #include "include/irq_service_interface.h"
 #include "dcn36_resource.h"
-#include "dml2/dml2_wrapper.h"
+#include "dml2_0/dml2_wrapper.h"
 
 #include "dcn20/dcn20_resource.h"
 #include "dcn30/dcn30_resource.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 1d18807e4749..8e2d3781752c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -73,7 +73,7 @@
 
 #include "dc_state_priv.h"
 
-#include "dml2/dml2_wrapper.h"
+#include "dml2_0/dml2_wrapper.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h
index 21d842857601..88c11b6be004 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h
@@ -9,7 +9,7 @@
 #include "dc.h"
 #include "clk_mgr.h"
 #include "soc_and_ip_translator.h"
-#include "dml2/dml21/inc/dml_top_soc_parameter_types.h"
+#include "dml2_0/dml21/inc/dml_top_soc_parameter_types.h"
 
 void dcn401_construct_soc_and_ip_translator(struct soc_and_ip_translator *soc_and_ip_translator);
 
-- 
2.43.0

