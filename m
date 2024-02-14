Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D073BC48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B561210E327;
	Wed, 14 Feb 2024 18:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cueLWI9J";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4291A10E2B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+wLGc4i7KV6KRKYNT5ESGMwp7cizxqfM/J1kCVp1lDrSEBAAKWL4UFglprTYPuYe6Ta/9J2jLiQSMFwcwsw8yrKtJSFABFDWWyYPED89G+jm/gIifDtJcxlqiQLt1VzJS0145DsCbiQHrfvHG0fGxhxgl66aVbchvOMcpVTDUMyTlaJ7iWhEFYeNB/45htZ4Scvd96ECqD8Cx8ZZxdu6uPdnXNCqZKWgCmDNi48FtSyqaTS3std2sRu33AjCj1xI2ji6ejKgVXdf5uXOwUxc0k9G8XBOEKZ0QXCs7B/deIyB5+lb4qLgEHD4tVU96zyfRAz/Wwdj13O5/AnI1YJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDJVbRL7fjlBUhzxeQbhCnKB7QJmAkqGh7wcs3U8fkA=;
 b=gRtFL8b0KrRO4WHRr83XpMaW/6Unkg3kAm1ACywhI2+WWBYmbwAHMDyI/PwniTkciA1QxTfVF6V7l9ZfaYDS0w9T0DfOC/Mix6EsYjVwQSXmuS85H7cU0W9tXR9/xIl7BsOyLhJ6JwWPywreHzBNxqt2qAIw54wOyGi/rIpa7wLHPrPU2oNRuylHb8SkamuyDaY8jfcybDz5fPg25/tEhtpfGFte+OBnBSIj4wh4O6rmtHakC+FaBE6v8SpJCudJmpj5tDlM4nXgLQypP/dcH6q1rQ+jA275Rs2PvgCSiZDKSi9gfLIsPAdMfZ6i7j6+yqeaHSyX7qkQiAlUBkXwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDJVbRL7fjlBUhzxeQbhCnKB7QJmAkqGh7wcs3U8fkA=;
 b=cueLWI9JFS03V6jYTtB4syI081c053bs3tHRqSLcs7iOADUuMCXDnu1XxlJ63DGUNVxM491Q2PUTd9Q7DrIG6DluFCij7Ejk+SRZGjYavm/t6GJnB3KsqpHHCZnhQfRrt+MecbPREoh3YVIp6aHJ7i4ch6CooyphlaS/p8vbRQc=
Received: from CH0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:610:e6::25)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 18:40:35 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::2f) by CH0PR03CA0290.outlook.office365.com
 (2603:10b6:610:e6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:35 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:33 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 03/17] drm/amd/display: Remove unused file
Date: Wed, 14 Feb 2024 11:38:34 -0700
Message-ID: <20240214184006.1356137-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 06210c32-f7e5-4a73-efa3-08dc2d8c6e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/YTOHxl4Lep/AyZPDf9JWwGpjNNpQPLldZ/Kb0+PxskYKMPAYjk2Msm47lZEGB40LHzGe/KcOYPKS50/UDQNwzJDodSi3GD5wldG8vEOrpUV6mLcK5gBX5Lh8+wb9s/VakApGo1WKeedJYxG68NugsZ8i4/y4xy3nAE5ZX2IYYqEnyYMgvGKF68hFKpAfBdlqJO13PyGtEYFfr5uO3mdrsqfu4rBjEXEJqW4FGPOvv4kaY9MRuzlnGFIVXy/4dRkIvbn7zOmiKKneViXbVl/9KtLnc77WTwCHN2mAxaJYMhsYn80QJ31buhhVz1oHRJTNHh1mjYpdu54+Iyif2SvE1AL7fo8jmSoXWIjHPljCj1wEqBM6djnp+W23+uwZmsQl9AnDaNk8lt64iGV7Z9kvyiMiRY0ku/KFVasmlhc/1Iyn0qWw7luWijEev4SxpKQcC1iuI0OeTJ4XK8OSYkWcyYhgqdyTWykv5bZExnswkSu9a/hFAquHhpyXrtwEnRbKMUSYoPJiw4WQGY0PKD0imrTNUYNStIR4hIc8BlPLqCVbpjC0Qxlnmt2AIDrTyKztjaKhp+59mhKZd4l/ZWTpOI/LxQibU6OtNhB16QRvU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(36840700001)(40470700004)(46966006)(2906002)(8936002)(8676002)(5660300002)(4326008)(66899024)(426003)(16526019)(336012)(2616005)(83380400001)(26005)(1076003)(82740400003)(36756003)(356005)(81166007)(86362001)(6916009)(70206006)(54906003)(70586007)(316002)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:35.1838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06210c32-f7e5-4a73-efa3-08dc2d8c6e86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
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

The file rv1_clk_mgr_clk.c is not used and for this reason useless. Drop
the unnecessary file.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c        | 79 -------------------
 1 file changed, 79 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c
deleted file mode 100644
index 61dd12198a3c..000000000000
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * Copyright 2012-16 Advanced Micro Devices, Inc.
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
-#include "reg_helper.h"
-#include "clk_mgr_internal.h"
-#include "rv1_clk_mgr_clk.h"
-
-#include "ip/Discovery/hwid.h"
-#include "ip/Discovery/v1/ip_offset_1.h"
-#include "ip/CLK/clk_10_0_default.h"
-#include "ip/CLK/clk_10_0_offset.h"
-#include "ip/CLK/clk_10_0_reg.h"
-#include "ip/CLK/clk_10_0_sh_mask.h"
-
-#include "dce100/dce_clk_mgr.h"
-
-#define CLK_BASE_INNER(inst) \
-	CLK_BASE__INST ## inst ## _SEG0
-
-
-#define CLK_REG(reg_name, block, inst)\
-	CLK_BASE(mm ## block ## _ ## inst ## _ ## reg_name ## _BASE_IDX) + \
-					mm ## block ## _ ## inst ## _ ## reg_name
-
-#define REG(reg_name) \
-	CLK_REG(reg_name, CLK0, 0)
-
-
-/* Only used by testing framework*/
-void rv1_dump_clk_registers(struct clk_state_registers *regs, struct clk_bypass *bypass, struct clk_mgr *clk_mgr_base)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-
-		regs->CLK0_CLK8_CURRENT_CNT = REG_READ(CLK0_CLK8_CURRENT_CNT) / 10; //dcf clk
-
-		bypass->dcfclk_bypass = REG_READ(CLK0_CLK8_BYPASS_CNTL) & 0x0007;
-		if (bypass->dcfclk_bypass < 0 || bypass->dcfclk_bypass > 4)
-			bypass->dcfclk_bypass = 0;
-
-
-		regs->CLK0_CLK8_DS_CNTL = REG_READ(CLK0_CLK8_DS_CNTL) / 10;	//dcf deep sleep divider
-
-		regs->CLK0_CLK8_ALLOW_DS = REG_READ(CLK0_CLK8_ALLOW_DS); //dcf deep sleep allow
-
-		regs->CLK0_CLK10_CURRENT_CNT = REG_READ(CLK0_CLK10_CURRENT_CNT) / 10; //dpref clk
-
-		bypass->dispclk_pypass = REG_READ(CLK0_CLK10_BYPASS_CNTL) & 0x0007;
-		if (bypass->dispclk_pypass < 0 || bypass->dispclk_pypass > 4)
-			bypass->dispclk_pypass = 0;
-
-		regs->CLK0_CLK11_CURRENT_CNT = REG_READ(CLK0_CLK11_CURRENT_CNT) / 10; //disp clk
-
-		bypass->dprefclk_bypass = REG_READ(CLK0_CLK11_BYPASS_CNTL) & 0x0007;
-		if (bypass->dprefclk_bypass < 0 || bypass->dprefclk_bypass > 4)
-			bypass->dprefclk_bypass = 0;
-
-}
-- 
2.43.0

