Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB18ECD98F2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D15C10F5D3;
	Fri, 19 Jun 2026 13:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zL4YyBu9";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4553E10F5DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+EEP4fJlXur+MYy6sIdV4QWijZ0ulX6MgU7AFU78CwwA6pBVnsAffHGQC5XsuBHfM5XgqhZa86RRXTjKYiUOfAhh45pm+vE78gDX5N62qC/KO4TRCxmYFFIKrq05A8AP4H10VP59Ch4qZFg8X2iI0qbDG9SEzePuy0RLR4K8t9ouBWECFrY/zRPJrruqJ5F38aQnBooY0cM77kanW5QoSDX6CTlKWYjhZPPnXBisKhcaRpfsrRK2akL2kZQ45Jpq4GoYVrBJwkqlAzGLl4RS+FqixuckC8oz7v0cqxl/LSRkNTehcBulcVKfJQmWHMpiC9L0a/RomHG5uhlZPRFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmVMjAjuxEdwdGB+GWD2Gi0+BzZJv5tQys/tGcjqec0=;
 b=ZNMyWEAfrczvL9KpQbWT6x3VMfmrVA3Qdwvkb40T1Spqe3fGW5j3uvzf3UC6tX//jb11srT6gdkINv4ww7clHlsQPfs385kOvhxk/4t5dOpUJfdI1J7UnLWDPh/VX1k+YvmNFe3H8NmkL9424A++npxllkJJzgMAmrqenxt2t0u2a+IcK2mcMCUf4W9cMkvh3pVIbqrO3sL3W8Uc1gYskliKiiovQ6VtJCtO3q7Jar9iY/xeDKxv3J4KhOFb5MzzOnbYvFta4tMgykQKzT3kOOlC//gqLpONO77ZepWyWKow+PX2npbTuaQmiqRfXxfePXX0gZ9TwU/XNvWCPhtI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmVMjAjuxEdwdGB+GWD2Gi0+BzZJv5tQys/tGcjqec0=;
 b=zL4YyBu9GhxDhbJl/X7/QE8BlssvkroVif38GvV1R2YTSfDLmoH2ZQ5E8Xkou98ob8FmRZCADleFpUIJUFi809s7a0lBK8aXNZlsisKSjFAYXDOTSuaLdghUbodVYIS7avIHK3fxHjGiwPtd57mAwzdCo1P+3d7yL996r9TFR78=
Received: from BN9PR03CA0843.namprd03.prod.outlook.com (2603:10b6:408:13d::8)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:32:22 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::a7) by BN9PR03CA0843.outlook.office365.com
 (2603:10b6:408:13d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 13:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:22 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:21 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Lohita Mudimela <lohita.mudimela@amd.com>, "Josip
 Pavic" <josip.pavic@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 04/24] drm/amd/display: Integrate power_helpers.c
 functionality into power.c.
Date: Fri, 19 Jun 2026 09:21:19 -0400
Message-ID: <20260619133154.116746-5-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: e9532dc7-2a01-4d36-ba59-08dece07317d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hgGKnTN30Zv7vHFnFN4AU7dsZBJyWmIGcIRO+Ea0fbWeKt8yBnVwXkiRlTBbwIrpmBJk2OwVlVVd0ZG7kyT09/zpbSslz2KJ3b96CPIs3aud/G7VgMKhDUIA0XD9grk0ozh5v6hCxbTzbNqDAhqEQ3lNRxvbkhs/3DC8TAcYmkLJIM4G0dafm4KMo+zsU46OjxDgQ3NDWCL3er71Wbt7q/XmTmO9Ne8ug4EXnHrUuimAUqMVWDp1uKSr4OXBN7Svq2y3OFBWcoLbbOHjV03TyyUnaO7/WCd65CdbQQBFDpCA92Z+/ztH9EcYhU5XnUVWaQpW0lt6F+2RrxLVWYnkBEBvU7U7ssAUrDt9TdTXeQtNJ1rnrBWXktcMnXSxcTWJMq84nHclsbB2ENNLCWOg5Nn5dxtF9MGl05STfC9oBrkGf7On/PpRpeymMl0YbP/55IX2FdPfefEX8cy/1mlzXTjmYdoFrTRmhnGu0yRNxlNNGSvqV6PZ0Z0w3CnxPigC3e0RVEA8GV6W/mdgZKhMKpPL5lycPrHEQQoR318qJHYFS0mScujXalJK+FlY//7jD5RjMfbmMv8cQ9EGvy+NxNtdNMPn+yShuJ/gn4Nh/ZH6bw7cZT9vX8jXyqRdvyYZ9AAgcsYDv9eavemS2M9nrp0R1pIGAli94gr2QaHgUSVr32g+p/HS2S1ZhbAYC3HcbkFVx7xRr4AquXZ3+VJ3uA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vO6S+RV1J2deIIaRirmLYbowXsUmbtzqK/ax/etuvkZIRVr9wXpaDux1DoiRXRWRA0bYIVjtxqKUm+KkNkQDVWZ5Iix4HpQhi0WWk95X9TUNVtyLEnQybd8jklCDxD7xStMPXslSkAvi0lJvHGbH3lBJDc674tG7OU3hH1H+hnY3kvJxVFIdetTJrHVsm+HLtJm+gFhSnoAbbtuJw2q1OCOJvG+mndznrWQSLa1yULkZkjWCQWO4qK2UNxIxWu0vQ8CLokUxbjtCmQ6EL6lRts2NN479fjJ5QmPDiML6XB9nXl9tfRTDPyB4YXYB5aO+uaAia7xwmDvTJIaUWs06i3UC7A5hYvBA/2K1ZTxgIpn3nKNcvBkIPvoTSeZViGLDzM6JntnOHAc7kP2xM3zLw+DKQ+7o/+Pxzz6BIjD+7WJxyrkVNQBo6rKxDvLG+zGQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:22.3207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9532dc7-2a01-4d36-ba59-08dece07317d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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

From: Lohita Mudimela <lohita.mudimela@amd.com>

[Why]
Reduces file fragmentation in the power module by consolidating
power_helpers.c . The helper file contained minimal
functionality (single utility function and shared includes) that
didn't warrant a separate compilation unit, leading to increased
build complexity and maintenance overhead.

[How]
Consolidated power_helpers.c content into the internal module
implementation. Moved macro outside
platform-specific conditional block for wider availability.

Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Signed-off-by: Lohita Mudimela <lohita.mudimela@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/modules/power/Makefile    |  2 +-
 .../gpu/drm/amd/display/modules/power/power.c |  5 +++
 .../amd/display/modules/power/power_helpers.c | 39 -------------------
 3 files changed, 6 insertions(+), 40 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/modules/power/power_helpers.c

diff --git a/drivers/gpu/drm/amd/display/modules/power/Makefile b/drivers/gpu/drm/amd/display/modules/power/Makefile
index 3000f392bdbc..0746f671eb4d 100644
--- a/drivers/gpu/drm/amd/display/modules/power/Makefile
+++ b/drivers/gpu/drm/amd/display/modules/power/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'power' sub-module of DAL.
 #

-MOD_POWER = power_helpers.o power.o power_abm.o power_psr.o power_replay.o
+MOD_POWER = power.o power_abm.o power_psr.o power_replay.o

 AMD_DAL_MOD_POWER = $(addprefix $(AMDDALPATH)/modules/power/,$(MOD_POWER))
 #$(info ************  DAL POWER MODULE MAKEFILE ************)
diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gpu/drm/amd/display/modules/power/power.c
index 5659a38b3366..af6b162a337d 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power.c
@@ -501,3 +501,8 @@ bool mod_power_notify_mode_change(struct mod_power *mod_power,

 	return true;
 }
+
+bool mod_power_only_edp(const struct dc_state *context, const struct dc_stream_state *stream)
+{
+	return context && context->stream_count == 1 && dc_is_embedded_signal(stream->signal);
+}
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
deleted file mode 100644
index bf0c5901b4ee..000000000000
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/* Copyright 2018 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#include "power_helpers.h"
-#include "dc/inc/hw/dmcu.h"
-#include "dc/inc/hw/abm.h"
-#include "dc.h"
-#include "core_types.h"
-#include "dmub_cmd.h"
-
-#define DIV_ROUNDUP(a, b) (((a)+((b)/2))/(b))
-#define bswap16_based_on_endian(big_endian, value) \
-	((big_endian) ? cpu_to_be16(value) : cpu_to_le16(value))
-
-bool mod_power_only_edp(const struct dc_state *context, const struct dc_stream_state *stream)
-{
-	return context && context->stream_count == 1 && dc_is_embedded_signal(stream->signal);
-}
--
2.54.0

