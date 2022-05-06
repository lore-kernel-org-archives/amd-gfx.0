Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F9BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 318ED10E61B;
	Fri,  6 May 2022 15:43:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A3010E61B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCDsdtCSueKTt0Q2pTq/EEi32wJrsQE1W6Yc+M0fnhH8AXEM6DVIfqe89KybUkAjm3CEgk/ZWjVKnWp2z7irozln71RLEOKWbEEopcVfo8iOfovmZkVCOyfaNJEdk9XSWurk67Mhe5P4OcaDvn2cE8lBGE1oYRgbPuZRSxpLvjhn6MrAgKXq8llLeCX3+gcKWkRLO27QL2LY4FqBw4nJKCKMG3eUVxPqjiFmM1fqy04wBc39C7s61oHN4YLDp6Xv7QsKquZqKtvivLc6e0qFcqtROMZcPVecvSM7RWvIevFe7IXqK3PmrX4tu/nW7icVvk/mlMRoquLuA5Qa6htlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heFxIkfc+2lOdMI8ZMMBzgHEvrk32tiOPZwg005NVJI=;
 b=FgOe/9Dg5D5Tt7Av+2LXQ0nxt0tjHRgn6QfnDWXE+CRjFtkHr8VY6qhg59jbM0xhW1CVMrcrgWER/7vBAIEXB/bFRtIy61d3WH/J4/qtAWirRft8mxm4SxGyrdoyTX/vpgV8EdgtAFvupKrpnlqpYj+hw8NqTODHUE50yI2Pb+enJa/WJoUgUhMhraPO2ZMT1MLF00WAW+J0NyKU23Mn2x/iGqTkq3pXLukxS+W8w4PZ4LLPPCqOyJSk8dKjzYGMZRAYL3wNFG88E4plPQ+ahb5CTLOAcfkeZJpw6fGkwwCyICwEjJzj7gL7u9Ta6gX53iv0ZLQsDrVwgmpfNBcuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heFxIkfc+2lOdMI8ZMMBzgHEvrk32tiOPZwg005NVJI=;
 b=LhiwMl3Xg9uhQRmTsVln1sxiZX/3JJrRyZBdhhiy2CoN343cO5ues4UY8RMA5okeBsKrJ49VpjZyt7luEUkgpnmccqKHm7DcbRZqvO4aHfw4fUS1J05HNYHU/GLAGBl7N0tnihPSSBHxMi176rcUOVgxETNsYy+5ho1dqPu1kAI=
Received: from MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::33)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 15:43:28 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::9a) by MW4P221CA0028.outlook.office365.com
 (2603:10b6:303:8b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Fri, 6 May 2022 15:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:27 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:43:22 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/15] drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN
 in gpio
Date: Fri, 6 May 2022 23:42:08 +0800
Message-ID: <20220506154214.3438665-10-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3e41bb8-dbc4-43f4-5ec1-08da2f772a2f
X-MS-TrafficTypeDiagnostic: DS7PR12MB6310:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6310FC79DF1BB984E25D9F2FFFC59@DS7PR12MB6310.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPsNVKkJCql3/nRmG4wtmKkKBa2SKX5+7WyZtZWDYL4Hy8n0ez5epH1ry3bAtH6LtT41ur5QZJCMe+4EMTDd+UN4o2TlqwtS10LtMwTbBOM5t5dPtjjl+PDE2mtPwa/iXARcM6S9oCDuutYhEJn70C1LFgrx+fmxipNOPbh6H1FqK4nQrLwf6SI8wk49hAF0v1j6N++Of8JrSZyyJwp7HSVygxiIy7t2Em0ObrSOVYvzmDUXbCSPI1xpEZSPafzcqAA0pDlNdUyMrofgoxtljotlRDHvbgD8yI1jldms8vDnDI0QxAO19HoWpQeql+tF6u3tlaqBtRe+nwrM2Fr2Mwk9oQlm9oipALmaBx4ILVSDqxWl8rS1JOS2ndKRsE0hkkXsxZGPYzZSWYBLkrcUnrQdPNHAXeIkx2wNUPOXv/kV7NlqUDMFP2hiAUo9j9uwce9p6YGYepFkYEBW/izN2nVKOVzka1pXd+6y7HiqzG3TBbdGFG+x9epa79eGDEyKy+dAG8tacx/+S66MK7cFv/f3+kfT0i1TqKJ9Taxh0KPZfuKsj448MGngzjNtgxkd9AbzFXe8l2wXgeGBoC9R7PVn8slclOp2CUD5uK1t+RDPWhxAtKexd2+rct6t/LAy5tmDFbzYUWmD3/KFCoJWOWIWw4Vy15bN5YyExFKx4AbP+ihojy1qj4F5mKv+dq8WJX+x5k5AZ6KejE7BwDTShQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(26005)(2906002)(508600001)(8936002)(356005)(6666004)(36756003)(44832011)(5660300002)(7696005)(4326008)(70586007)(83380400001)(70206006)(8676002)(81166007)(336012)(426003)(47076005)(40460700003)(82310400005)(1076003)(316002)(186003)(16526019)(54906003)(2616005)(6916009)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:27.9676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e41bb8-dbc4-43f4-5ec1-08da2f772a2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[Why & How]
CONFIG_DRM_AMD_DC_DCN is used by pass the compilation failures, but DC
code should be OS-agnostic.

This patch fixes it by removing unnecessasry CONFIG_DRM_AMD_DC_DCN
in gpio directory.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/Makefile                  | 3 +--
 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c  | 2 --
 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.h  | 2 --
 .../gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c    | 2 --
 .../gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.h    | 2 --
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c              | 4 ----
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c            | 4 ----
 7 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
index d1c2ec58676d..0f4a22be8c40 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
@@ -73,7 +73,6 @@ AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCE120)
 ###############################################################################
 # DCN 1x
 ###############################################################################
-ifdef CONFIG_DRM_AMD_DC_DCN
 GPIO_DCN10 = hw_translate_dcn10.o hw_factory_dcn10.o
 
 AMD_DAL_GPIO_DCN10 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn10/,$(GPIO_DCN10))
@@ -114,7 +113,7 @@ GPIO_DCN315 = hw_translate_dcn315.o hw_factory_dcn315.o
 AMD_DAL_GPIO_DCN315 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn315/,$(GPIO_DCN315))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN315)
-endif
+
 ###############################################################################
 # Diagnostics on FPGA
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
index 3b7df1ac26be..687d4f128480 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
@@ -22,7 +22,6 @@
  * Authors: AMD
  *
  */
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dm_services.h"
 #include "include/gpio_types.h"
 #include "../hw_factory.h"
@@ -266,4 +265,3 @@ void dal_hw_factory_dcn30_init(struct hw_factory *factory)
 	factory->funcs = &funcs;
 }
 
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.h b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.h
index 131e742b050a..e491af845b83 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.h
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.h
@@ -22,7 +22,6 @@
  * Authors: AMD
  *
  */
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #ifndef __DAL_HW_FACTORY_DCN30_H__
 #define __DAL_HW_FACTORY_DCN30_H__
 
@@ -30,4 +29,3 @@
 void dal_hw_factory_dcn30_init(struct hw_factory *factory);
 
 #endif /* __DAL_HW_FACTORY_DCN30_H__ */
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
index 6b6b7c7bd12f..3169c567475f 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
@@ -26,7 +26,6 @@
 /*
  * Pre-requisites: headers required by header of this unit
  */
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "hw_translate_dcn30.h"
 
 #include "dm_services.h"
@@ -384,4 +383,3 @@ void dal_hw_translate_dcn30_init(struct hw_translate *tr)
 	tr->funcs = &funcs;
 }
 
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.h b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.h
index ed55410b7a4e..511a0dd49140 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.h
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.h
@@ -22,7 +22,6 @@
  * Authors: AMD
  *
  */
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #ifndef __DAL_HW_TRANSLATE_DCN30_H__
 #define __DAL_HW_TRANSLATE_DCN30_H__
 
@@ -32,4 +31,3 @@ struct hw_translate;
 void dal_hw_translate_dcn30_init(struct hw_translate *tr);
 
 #endif /* __DAL_HW_TRANSLATE_DCN30_H__ */
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index 5c00ffde3996..ef4f69612097 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -48,13 +48,11 @@
 #include "dce80/hw_factory_dce80.h"
 #include "dce110/hw_factory_dce110.h"
 #include "dce120/hw_factory_dce120.h"
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/hw_factory_dcn10.h"
 #include "dcn20/hw_factory_dcn20.h"
 #include "dcn21/hw_factory_dcn21.h"
 #include "dcn30/hw_factory_dcn30.h"
 #include "dcn315/hw_factory_dcn315.h"
-#endif
 
 #include "diagnostics/hw_factory_diag.h"
 
@@ -98,7 +96,6 @@ bool dal_hw_factory_init(
 	case DCE_VERSION_12_1:
 		dal_hw_factory_dce120_init(factory);
 		return true;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	case DCN_VERSION_1_0:
 	case DCN_VERSION_1_01:
 		dal_hw_factory_dcn10_init(factory);
@@ -121,7 +118,6 @@ bool dal_hw_factory_init(
 	case DCN_VERSION_3_15:
 		dal_hw_factory_dcn315_init(factory);
 		return true;
-#endif
 	default:
 		ASSERT_CRITICAL(false);
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 7a39cbc01f63..1db4f1414d7e 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -46,13 +46,11 @@
 #include "dce80/hw_translate_dce80.h"
 #include "dce110/hw_translate_dce110.h"
 #include "dce120/hw_translate_dce120.h"
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/hw_translate_dcn10.h"
 #include "dcn20/hw_translate_dcn20.h"
 #include "dcn21/hw_translate_dcn21.h"
 #include "dcn30/hw_translate_dcn30.h"
 #include "dcn315/hw_translate_dcn315.h"
-#endif
 
 #include "diagnostics/hw_translate_diag.h"
 
@@ -93,7 +91,6 @@ bool dal_hw_translate_init(
 	case DCE_VERSION_12_1:
 		dal_hw_translate_dce120_init(translate);
 		return true;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	case DCN_VERSION_1_0:
 	case DCN_VERSION_1_01:
 		dal_hw_translate_dcn10_init(translate);
@@ -116,7 +113,6 @@ bool dal_hw_translate_init(
 	case DCN_VERSION_3_15:
 		dal_hw_translate_dcn315_init(translate);
 		return true;
-#endif
 
 	default:
 		BREAK_TO_DEBUGGER();
-- 
2.35.1

