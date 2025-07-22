Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0137FC83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1A510E72C;
	Tue, 22 Jul 2025 22:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WN2PDFaV";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC34C10E720
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVUk9NxPibVnJih1IqYS8jq3EN6pc0sCroqvIcs/cj1CcSxdBmJodhYGVhhqwdkgSiV4+/JzQBde67MorZlWhRbDtvG0INfSHg20qKtvPLb7u09lArJooF7kMIBExfWhHOU+LQWl/uiLHnGFQk1pJzcXPKlpcIcUZmyYHld5+4pQ+00U3pF6VwqrgCWxMWkK+yH4lTgqjJDtwD/LhaaBC51rovu3Qedu047a5d78s+42+eUerbq3X6rLwmnIrcok6vTwihV4NRU80zpw2y7yNW7MG4xwz95jB3fIIxBzIid4Hz88oBOnb2CKNK0aSgTdok0gphUwhuEolz9cjcOpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y1ycSf6UylBy0JiXOeXXoOwzexNqiom0Szb2xH+uYs=;
 b=uheoztv/rC6HIgvC9D3bf0JSKjyVtmen9fBiCrgqbCon3+h2SqAy7VPheP+054dDB6fSDz8WH4wAN5ZF+EynSp6t08Pj+BocWqxwFag8Krkp99F+cPic+IJWncbHthDANSdSiTrdEohdm4wKg+OWYJiZhuC6foRPPNGv3/gzfzxWCs5ZgSn1BwbYD1jcN9LxbiyO6Iq2Ful0x2Y23JHCEfIJqv7gosBDh+vS2corYqHpaqkCk7zW93CXx4Vgas3B2oqdvOyRUG1yGxx6Hg1XckVIxk3im7g444PbC0zYQxxPLa35Gc4m+8CgnHXgGWXJOA78F38461oBv+A/NskQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y1ycSf6UylBy0JiXOeXXoOwzexNqiom0Szb2xH+uYs=;
 b=WN2PDFaVHkxJJz1bWBqv4hQrsQf/o5soeWzdJnkwjlvA2LX9owpwfhq+xa2NXvGWVqaqWcXtLoA4SlQkkrewtBYFcYi7I2C+sT+6iQilWf0hLCVzR/9PzztHrDd7FRrzlyMLCLzFEQe9Q0ejbsGcUzKHMa1P9sss8hLOr/osMEc=
Received: from MN2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:c0::14)
 by DS5PPF884E1ABEC.namprd12.prod.outlook.com (2603:10b6:f:fc00::658)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:39:27 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::e5) by MN2PR05CA0001.outlook.office365.com
 (2603:10b6:208:c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:26 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:26 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 10/25] drm/amd/display: Remove unnecessary includes
Date: Tue, 22 Jul 2025 18:36:16 -0400
Message-ID: <20250722223911.2655505-11-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS5PPF884E1ABEC:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c594e1-7f7a-403f-3b60-08ddc9709dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rvlt+ZIemNnLjSOwmMcIpTyA2ETBV4SqCQj9g84Kg2efLbMrynZC40/7Qob2?=
 =?us-ascii?Q?uUY1EEVVCP1ldsa7NAdmrPoJ+GHLErXwU2DpusVYhXn0O9+NSwzygTo7oc/G?=
 =?us-ascii?Q?RdGkeRe9vf1idqxzIo6jcPXAiQpQFguiWPiIN4n/ZUkUZdz8HsEyEi42HaCx?=
 =?us-ascii?Q?etfyYCuSc61ATWfO86Xo00XLpMdTSQy5hXx9SqORjzvX/4sDBNS4zpC4gkGf?=
 =?us-ascii?Q?Cq0OS9uG0xxo033hYN86eqrkCFWtiISswWHVj/Vxlvf5Conr97uRXi2/toYa?=
 =?us-ascii?Q?2JygVLLTjVC5Vyit7iXa8Sfyjmj844j1c4OLgVc5ip0wLnGTeAyzYIKU81Uv?=
 =?us-ascii?Q?1mPQwY+44lsCksPnjXnxArfye2iXFBw/hZw18FdHzpWcdjsMObmwK/ziWxLH?=
 =?us-ascii?Q?sjNAd3OkRD4PzDwrWjrS2ONiwLkxJ12CUNxWr/Xt+UEKmfYbQF79iQtNHfLR?=
 =?us-ascii?Q?nrRbA++Q8pLaDGiaKzbiEfo0aMoRfN8BuhU6LUl5WgBPTv9lCWk1mfsZ5NXp?=
 =?us-ascii?Q?06QwAQxfK8gDkb3vC0Y6t5gBDthnXlNnNPCmAZBwU8tna2iyQ6Wp05GCMaKd?=
 =?us-ascii?Q?Jmt48CtmVVF34Hak4l9Lsmbo8zD4kLTrra6PGXjhDGae3BjUXKLByyxJFdnF?=
 =?us-ascii?Q?DRf4bZQe0nnbGZ/56jMuXJtJRHuDZYEF8ggfWd6c6iAYg7+ETBGGDztzWB05?=
 =?us-ascii?Q?dgw8xEJXh4oYJfCU6B77gLkvun1i8AFCnIbwXO6ZCRfnmbhJblUoRGBZLcAt?=
 =?us-ascii?Q?JQuA05xXzqw4JIa8THQN3Kb1pj776alu2s1CIAtVN0FkkiFbKknnXHVc8JZ5?=
 =?us-ascii?Q?bKHjiz2F13CZlCAyjmY5dMeQBLhizIsfa1pa0PtjA58QhKecKsvWGfUamyK4?=
 =?us-ascii?Q?TmGaxwI9gwnMUIR+tee+rLQT9l+2E5ZrJfcgppYwun/+MhoZm8hLeQ0IplGK?=
 =?us-ascii?Q?CaQSCOcEO3NG2g0dVlenPYDaWWgzaB5mc9RRno856e7z5QlPTZtiUZEOE4PM?=
 =?us-ascii?Q?HU4GBgz0R+4E0cXRyGKeL2+rd6lbKQT3NVb++oaxVXdNugg1m2bQc3LMxElK?=
 =?us-ascii?Q?PS2xCtYrDR96PjcOp/1p2fuajf1onBSPQuP/zCLYhcAF/x+PMu2npe5zWT+P?=
 =?us-ascii?Q?/0WFQo/ichVl69kA0upjO0kr06GFJszBazvxsY+i91Qqm2yNI/DN4Xx2wHmF?=
 =?us-ascii?Q?B3YUdBhvMCEKenQIjNoto9GvmgBt0/t5FWi9Cpe4UTkRfmI70tUYazOtDTr7?=
 =?us-ascii?Q?HTnrXay7uyGA+8HZYXUHhPPa7addgboPXID32/S+kDLHgD1lQf+lEakiwi8F?=
 =?us-ascii?Q?5FrfOaHKAOM2Wn2nclxOgICYCA6qtxEMMB+ZEm4PDW0S7LZ7ER3tPs8JPHtf?=
 =?us-ascii?Q?PCG1mSqFJ2LMvFLAoXPGOaS/W4krRQbqDZl1TGpHZwWAPdgj9vmJT/1VkfYq?=
 =?us-ascii?Q?qirfjHc96VKWQI5tA6Qy/nymWbuXyRXBtL1mm1b63TRZwpcntu6wkJ9Y0d45?=
 =?us-ascii?Q?PPp30woMPH48cLAVZ/99yk8iouWczFv9wvAV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:27.7613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c594e1-7f7a-403f-3b60-08ddc9709dd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF884E1ABEC
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
Extra includes aren't needed for compilation and can slow down the
preprocessor.

[How]
Drop unneeded includes.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 12 ------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c  |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 19b0689601e3..2d9132c60bef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -40,13 +40,11 @@
 #include "dc/dc_stat.h"
 #include "dc/dc_state.h"
 #include "amdgpu_dm_trace.h"
-#include "dpcd_defs.h"
 #include "link/protocols/link_dpcd.h"
 #include "link_service_types.h"
 #include "link/protocols/link_dp_capability.h"
 #include "link/protocols/link_ddc.h"
 
-#include "vid.h"
 #include "amdgpu.h"
 #include "amdgpu_display.h"
 #include "amdgpu_ucode.h"
@@ -57,7 +55,6 @@
 #include "amdgpu_dm_hdcp.h"
 #include <drm/display/drm_hdcp_helper.h>
 #include "amdgpu_dm_wb.h"
-#include "amdgpu_pm.h"
 #include "amdgpu_atombios.h"
 
 #include "amd_shared.h"
@@ -103,15 +100,6 @@
 
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
-#include "dcn/dcn_1_0_offset.h"
-#include "dcn/dcn_1_0_sh_mask.h"
-#include "soc15_hw_ip.h"
-#include "soc15_common.h"
-#include "vega10_ip_offset.h"
-
-#include "gc/gc_11_0_0_offset.h"
-#include "gc/gc_11_0_0_sh_mask.h"
-
 #include "modules/inc/mod_freesync.h"
 #include "modules/power/power_helpers.h"
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index ff97785b60a2..c7387af725d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -28,7 +28,6 @@
 #include "amdgpu_dm.h"
 #include "dc.h"
 #include "modules/color/color_gamma.h"
-#include "basics/conversion.h"
 
 /**
  * DOC: overview
-- 
2.43.0

