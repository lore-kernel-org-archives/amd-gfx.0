Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F2ECD1296
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E7710F201;
	Wed, 10 Apr 2024 21:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CBl6mT8f";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D474710F201
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8P1u8OWOQOTrhUA18K0vs3Teixh3blfk5po4N0Bl1AL14m0VI1mDQwa2d53WTo5h8EVfA4VcI4UfLzeRfRep2ZdXwBTYaCVs8HdCW3ZZi0Hp5S7B9Hx8kWGb3vE24L/zo9sxRuM6z5QOooooD7TWdaFqH+D7Gr+DZ3AshdurhexpHAHLf0fekCHxLQZt+kVIKyDuby+f9sRIaZhM0PoVbIzMRj/taBBsJRfbqfG5CNZIqsILpy26eEjBmERXwY8XB/gqypM6sIAlLGma2t9lAB8RrIkAhXZ9HBOGsdxUZHkLVgXSTCfR7etZAX4YD+S1KmG/BvsAnWIEvCdUG/ZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KooKhsLYEb9KhtCtzL05IKskysIgsiZETO7PomxktM=;
 b=PW0Vv9yFwWd4a9C3LiXKUuCGNSZsFUTydkestrmUQbE5S9Mx4KoAf7fAq23TpCZo78qFZ9zoavskjTsPrQ7mebcRpJ87VG+99loz7/N6zZ2cplgjjJdiQnzYprCDQta35vXeJW+sMtsEfwShuzT5DXZm+BqGFJ9FhM6l0xYirvG23ohhfCbxu/2kcuePvWPRLAWHLFcfBbBdEEzXMdI6h3iEBBhEKO84FxXaHpA7yzO9EpcxJ8/IpogJc6scED4kAY/KbqPFuzELctKEI9yWsFbM0ax+XcRtnK2CAIOFXxnPujQtVR5q6r+dyJJrud1kg4qxmeMhfzICvMu06Bvm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KooKhsLYEb9KhtCtzL05IKskysIgsiZETO7PomxktM=;
 b=CBl6mT8f1DrGPHVXawfLX9fffuiZn6G+f96KIkJq4OS2ncaF0npXUaKI3C+CBQYIek3ODAGjcvLLugHCxeJL4sjzcPxsv2sTxlCOHnBRACmEGg8sWpbfoMC7/C/Wa9bRpnEL9jrJN9Ad6rP4x/OKjibhWVyOZYO/1k5YeA+oSNg=
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 21:28:11 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::9e) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:11 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:09 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 12/25] drm/amd/display: Adjust headers
Date: Wed, 10 Apr 2024 15:26:01 -0600
Message-ID: <20240410212726.1312989-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 3019790a-01a0-4273-65e2-08dc59a51fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OdUfBhqLB/dDXFauGdJSI43l2LGLETj2XSR0qXBlBRNFneeuhkhxCWNjP/KJa+0rLWEb7vSyQyQW3O+8ODFfyjVl2Wd/TCH58rTwKZLH34EpitudJ4rT9TtKwL8rYYuOuOSHA3QBCBuHSxu3rSq4Mlzv+sV7flvGu+34vLEoSyQLvQ77hOGl2MuO+oLoM47I+Oy1nA7J2vo/pz1lnfuble8FTUz6n1vKh/iM+waNf42q+n4K+M07QlO7YxMjjZuGJ11UxtHP9dTiqGjdz3CSMZ1840ZbKNLr/i7pUpqZLyYdi272B0TY0tmiDCFB858l/QMI6iudcoVPxg6O4Qt5R0eHPyZaN76WtbpaAcruZUgMyiPtXmi6lTYzAc7aUzqXWZggrGi0NzAPayHp9PlwsRqr1bheSJgl17Wpdz35zlXnN0leHZ6WHxuvhk0Vt9MDhD6hcX1nhobJbEZrcYZHq9B5D45ms+195D8Lr1YQUTWmlXvBnbgE1oaoBZ5mp6VMkSjYeuCPqXk9yEwbHG8vH48KzrByFKbAjEX7JgkPe3RLbv8k8QKDKHKOI3b3xb61Nxwwtq5S93JbOlZ9tn5cuaCDn7jNXnwGRE89CfzbEhZQwEOweUUQSBaWJq5KLAxJFOR9uqbCYd+KkMqU3K1L0ddBoJogTdiCR23fYkzLsShIX6JEVbv3Cz7Q/NRfRWtkssdmIeJs2awM8K4oEXVz+9jPccO77rwT9EsKHtgsBWW2XR8Ih99w5ChFbWidUR/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:11.3498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3019790a-01a0-4273-65e2-08dc59a51fa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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

Update headers by removing two unecessary headers and include a new one.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c                | 3 ---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c    | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index bec252e1dd27..358a83b1114b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -29,6 +29,7 @@
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dce100/dce_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
+#include "dcn32/dcn32_clk_mgr.h"
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index a2f48d46d199..744c335718a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -22,9 +22,6 @@
  * Authors: AMD
  *
  */
-
-#include <linux/delay.h>
-
 #include "resource.h"
 #include "dce_i2c.h"
 #include "dce_i2c_hw.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index 8ed7125d230d..425b830b88d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -29,7 +29,6 @@
 #include "reg_helper.h"
 #include "hw_shared.h"
 #include "dc.h"
-#include "core_types.h"
 
 #define DC_LOGGER \
 		enc1->base.ctx->logger
-- 
2.43.0

