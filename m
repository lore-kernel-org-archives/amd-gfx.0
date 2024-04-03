Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3371CD128A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C88E112E8C;
	Wed,  3 Apr 2024 19:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4d7fDyff";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 037D1112E85
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyJnU85Ahxu7wKOYq/Ywj3aJ6tmrIC0cb7QHZP6HRC3A1pfudsR4Xd+eE9bJhzxCK1+nSD/4hVwuS3poDuQt1cxZWTNWG40GjpKrYYNuwrf4K1R2y19XYZeeYJm8pxTO9P93WZD76i+gDeMjfsVjpgZA23wxysxNSH7c4CNDppCM4t/4vwi4dQu6OEpIRXFP1Vfnpvk6W5/YpPdxmz1mBL8UGitu4+ap5RlhLx85O+Iqh2B412KFbnxtvZSweEi63OxipHC4LowH13pt1onFeG3Ipn9/mZ8TpyhynCkEWUCvmz4+WSDKzxpqmuhyVsPmcfSGos8qjec+qavArKuMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvRLT2fU/yU3fhfwhrVLzAskC17AiE62BKOP/kPDvqw=;
 b=e/OTTIW46kOQZTGIOr97+qW25x0t/nPiZMrHgy+tI9vKx/dYAX6Z7nS58yW2axvSIZGcco/fYR88q7LUr+zCcFjMaIgmj28QNLfrPo7aTnOqJudE+HmUBDFxKmbtp3c/MXHR1JPrcGjdTMBjAqtRAILFPQbQhRnvZeIbDuziM0+MGYOp6m5ulH9oBMjcMh0KgRQZ9yMUxDi2cLpKP3+1m5KmZMQSrp6yrv/dLHofn4VtSZiqeAqj31WwQl9qvjfODK4w7Vp+2lpwpQ2w4ExTdpCTYN6dmyxfb9yGYg3DDl54EF7A8ePCnhlXufhdI3TLxvVIlQax6xBVF9ASG7Fgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvRLT2fU/yU3fhfwhrVLzAskC17AiE62BKOP/kPDvqw=;
 b=4d7fDyff3ykymbSrzxPXqwojn7v3boxTApuNBj7GyhBdL/glbwyCoNQjCjM/R6KBQLpEVg6yfj2Wqufb4Zi95dtkMaO2CJhMgb3j54hRu8c5tyWSgham/xl48RS1dE/ZyIAYJPa7TiNHnVVRh6u35xNRXYybIdYUAhsON8eJuT8=
Received: from CH2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:610:20::19)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:52 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::bc) by CH2PR07CA0006.outlook.office365.com
 (2603:10b6:610:20::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:52 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:47 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 19/28] drm/amd/display: Adjust some includes used by display
Date: Wed, 3 Apr 2024 15:49:09 -0400
Message-ID: <20240403195116.25221-20-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6aa779-9a58-40d7-cc8e-08dc54178243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEOjJvyT+ZZ/F0YoLmFfYZaEfBVfEpSmoiYoFVvlQnrAgI+x3FnbnBH7/7DFrzcjn65NCJ17DFBFklU3RhCRMmv320L41sZYmYPAV+LQkUvUwM/tbG1X6VAb+QOZCd/uIxQ35D/+cO5XdlLEppUdUSYg/MBcDOASdhFp7t92indNfJmZw1OgQztomEvOwM9BYEVZQ0JXHXL6Jlka1r9LZhg8j3eBKOdGBSp4QE4alAoB88qIW0zwWQT5ePvTxTb/iriKvaOZGx13iyVSorFoWZpd2wTM+kmkC4f+pbi/fyX6SZU/zJaZP62uvvtghYzaW5pII+m3FfDq/smlPXWdCuFUSJak7JA/GmUMfFolBealw42e+aeWuw4iBi7WfDvZPdnN/2KGQ6niWIYiwdhfY4tRAX9oGTaRitcZjxAgQ+B/vXCCw2l9UcxBy6HbNX0jb1lotG52Ymb2wKqC+RRIUupPzHO9OF30TgTBRW8kPfRUKmYL0O1WlKa4BnZyQU/3NtBJDNWaoQv3Fz/oqGCoPhen/JzbjamUUG6np03qjNqFuH32VTQ4CxmvBgMY5YcRR2oiuybdCICCu5vcP/7KKgAJjH8h2j0V7Q8uJtio9i5cpth6kOyQ7NOJTJBey4xuastHsazPXs8Biot9OKbpKEEbhPTXlwVVuIY+Y7XHGuy+1UVVpMb1E5V1/1cjrgcP1f63/9O8gNvOKSZWt6g4VqUWBQy5LvkBqxjPgoLNxUu4hWl7lFlAj73JbzODh/sH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:52.5605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6aa779-9a58-40d7-cc8e-08dc54178243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Some of the includes used in the DC can be removed and others need to be
update. This commit adjusts some of those headers in the display code.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c      | 1 -
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c    | 1 -
 .../drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c    | 1 -
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c        | 1 -
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c      | 2 +-
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_trace.c | 1 -
 .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c    | 1 -
 7 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 2a74e2d74909..369421e46c52 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -23,7 +23,6 @@
  *
  */
 
-#include "reg_helper.h"
 #include "core_types.h"
 #include "clk_mgr_internal.h"
 #include "rv1_clk_mgr.h"
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
index 89b79dd39628..19897fa52e7e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
@@ -26,7 +26,6 @@
 #include "core_types.h"
 #include "clk_mgr_internal.h"
 #include "reg_helper.h"
-#include <linux/delay.h>
 
 #include "rv1_clk_mgr_vbios_smu.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
index 64c2b88dfc9f..3253115a153d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
@@ -23,7 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
 #include "dcn30_clk_mgr_smu_msg.h"
 
 #include "clk_mgr_internal.h"
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 6904e95113c1..f201628e4e98 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -23,7 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
 #include "core_types.h"
 #include "clk_mgr_internal.h"
 #include "reg_helper.h"
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
index 879f1494c4cd..2d14346b680e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
@@ -29,6 +29,7 @@
 #include "dm_helpers.h"
 #include "dcn315_smu.h"
 #include "mp/mp_13_0_5_offset.h"
+#include "logger_types.h"
 
 #define MAX_INSTANCE                                        6
 #define MAX_SEGMENT                                         6
@@ -69,7 +70,6 @@ static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D
 #define REG_NBIO(reg_name) \
 	(NBIO_BASE.instance[0].segment[regBIF_BX_PF2_ ## reg_name ## _BASE_IDX] + regBIF_BX_PF2_ ## reg_name)
 
-#include "logger_types.h"
 #undef DC_LOGGER
 #define DC_LOGGER \
 	CTX->logger
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_trace.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_trace.c
index fbcd8fb58ea8..c8c55f196f8d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_trace.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_trace.c
@@ -24,7 +24,6 @@
  */
 #include "link_dp_trace.h"
 #include "link/protocols/link_dpcd.h"
-#include "link.h"
 
 void dp_trace_init(struct dc_link *link)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 0d2974c9c823..bc65f82b111d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -55,7 +55,6 @@
 #include "dce110/dce110_resource.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
-#include "dcn201/dcn201_hubbub.h"
 #include "dcn10/dcn10_resource.h"
 
 #include "cyan_skillfish_ip_offset.h"
-- 
2.44.0

