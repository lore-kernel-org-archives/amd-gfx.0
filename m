Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B4DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED4510E3CA;
	Fri,  6 May 2022 15:43:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7D510E3CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQviW5x/RMqKEut1+pvAaOhRzvYmusD88wY41yJuQpW2k0gpfrCLVKtf0rPwv/jH6NCoxStc+Cs0FpK9J897Lk14fN43ltprfrkWsGKRcZ8DnGXS9jT93DIjNHnf81HEGbeZK5zXB4JQFD2Kg/lDVSiT6tShT0AT0FERjnsm05aKBdeVIMrmTzRTGYJ8U+pGLhIJX9KBQeofllEpp7/dQtZDr/5WweSR3Bst/0EpvlgMF9rcPv9HjWcvkFmtcrv0kv1FBI8UKAJFtfNG8DOq/ncn7TyggPR1/eUwKn4m+F/Y/3dyd2LMoU+HeOmEshRUZL+yXaOiAeNaZrMrGpyKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3+oIHtWWNkLOvJcdP8E3i+5pnGNzJMQDpneJ481M3I=;
 b=GVGR9Sfneh72fb4zbLMaUfTH+EoTUMmVcOr4r7ZEYrcLXHpoC7+OLt/mWfnqWUDtdfokm1b+qpCj3cBdfYKyvmf5cDupjPLJshJozpoqYphumu587Ppcn8ky5euopJZaJ8GnlcANFdud0SZ16w6Huv+Kt3V+2hes9i1D0Gk4bkrnDxcT1NFad6ZYdBtmAmb6+lSGzyHWGpUUOydVc5qVh4K56beh1pFESAVYSSUtqr26gixil5DDPxbHGC3Ul5KtUNuMjBuIHlDt0g5nF17/RTGJm80u2zkmNuFPCZY13TOY0sNAMOjVXbulOkiZQuxnGi/UgFWUbY+9r4nS01YtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3+oIHtWWNkLOvJcdP8E3i+5pnGNzJMQDpneJ481M3I=;
 b=XMcGPAwIy6yWr0rPnJXiV8dhTYSuYSquF0sFmvOp9b3pZo/TBA8tdfKuifBBFfvnvMqoIeflr45nFk2HAjhtNfAIFl2wVyxqpIjL3xUdTv/I976tG76ARNx6KqlNMV3R5o/sF6oNPunhb8DgRbc4baYUlq+9aFO4hTDHjMJ+kZU=
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Fri, 6 May
 2022 15:43:31 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::55) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 6 May 2022 15:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:31 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:43:26 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/15] drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN
 in irq
Date: Fri, 6 May 2022 23:42:09 +0800
Message-ID: <20220506154214.3438665-11-stylon.wang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa762b61-9455-42d4-0264-08da2f772c41
X-MS-TrafficTypeDiagnostic: IA1PR12MB6457:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB64571C46823B5D75F96B637AFFC59@IA1PR12MB6457.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVXHFALHBYg82mMFOklx00d6Zfv/AqDAK0sku2j+xkv092sPDe28DZfPIcb5xzCe1XuBim8sKj87yBzqkHtUmq5apMMJCt8/rgCnY0UCw6dFeRfFyMoIS3qvcOBZMNSigu315yfF/rlEEFjQRjMODK+aE7L5KoZ33nM2CJoce7qnx9bWpNMv0Stb1tLhYH/uJrQjvrNSe7Lj0z6F63twHv696QtlNqCPWI4FrBCmJDee525r4K7xr3jZMrx4/+vIhdhI7xfPZ4JOaHgyQnIfTTag8/2ej/0l+extgfWJbS748N/pYCBbIAfLXGPvoDb2KZ4GzU3KQRcB/KtpHJ0s119cD7HXDJ0KT1uWatohDXOKno/gNMWgnx7vIhXcgFT3HBJurt5JnlZ9nkWKRL4rZGGBmrNxCEwPPrE1/sGSosfkrACFCW2Iwh1KhoBkrXPikJ2I/HUIg8jMBL51xBE2fsUyIAScRvLETsROxlyUrnyH3jmDqhb/McmkiK6JDtDfm7DQwJUV0gXOwgrfSH3FDDG59B3uy2Eqa+EnU11dMCqU4bFAJpMT8FcCUw1UEmNifKuMAw4MUUuQouh9U+Zi+2Nxt4KBZSooqKPINz7MXbuuo7dlWq+cq/vNskHnMD+uTVRbL3OVavv061U2Jey95uHTEiHw/LMEFGR04etppRf5pr4xcdT8/N4FrZ3aCnLGkvNu9uXs5S+c+JubeWZ41A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(82310400005)(40460700003)(83380400001)(36860700001)(1076003)(36756003)(186003)(16526019)(47076005)(70586007)(70206006)(4326008)(336012)(8676002)(426003)(2616005)(2906002)(8936002)(81166007)(356005)(7696005)(26005)(86362001)(5660300002)(44832011)(54906003)(6916009)(508600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:31.4387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa762b61-9455-42d4-0264-08da2f772c41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457
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
in irq directory.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/Makefile                  | 3 +--
 drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c | 3 ---
 drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.h | 3 ---
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c             | 5 -----
 4 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index f305d4c9a122..5f49048dde47 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -71,7 +71,6 @@ AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCE12)
 ###############################################################################
 # DCN 1x
 ###############################################################################
-ifdef CONFIG_DRM_AMD_DC_DCN
 IRQ_DCN1 = irq_service_dcn10.o
 
 AMD_DAL_IRQ_DCN1 = $(addprefix $(AMDDALPATH)/dc/irq/dcn10/,$(IRQ_DCN1))
@@ -136,7 +135,7 @@ IRQ_DCN31 = irq_service_dcn31.o
 AMD_DAL_IRQ_DCN31= $(addprefix $(AMDDALPATH)/dc/irq/dcn31/,$(IRQ_DCN31))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN31)
-endif
+
 ###############################################################################
 # DCN 315
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index ac0c6a62d17b..146cd1819912 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -22,8 +22,6 @@
  *
  */
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-
 #include "dm_services.h"
 
 #include "include/logger_interface.h"
@@ -450,4 +448,3 @@ struct irq_service *dal_irq_service_dcn30_create(
 	return irq_service;
 }
 
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.h b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.h
index 080e21239688..c6c7b184d3c1 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.h
@@ -23,8 +23,6 @@
  *
  */
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-
 #ifndef __DAL_IRQ_SERVICE_DCN30_H__
 #define __DAL_IRQ_SERVICE_DCN30_H__
 
@@ -34,4 +32,3 @@ struct irq_service *dal_irq_service_dcn30_create(
 	struct irq_service_init_data *init_data);
 
 #endif /* __DAL_IRQ_SERVICE_DCN30_H__ */
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index a2a4fbeb83f8..cb38d4c527d4 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -37,13 +37,8 @@
 #endif
 
 #include "dce80/irq_service_dce80.h"
-
 #include "dce120/irq_service_dce120.h"
-
-
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/irq_service_dcn10.h"
-#endif
 
 #include "reg_helper.h"
 #include "irq_service.h"
-- 
2.35.1

