Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90564C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5564361381
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5564361381
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B0456ED6B;
	Fri,  1 Oct 2021 14:41:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2697F6ED29
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya7P5iwHs6voOLbEeeOTM61FZjgkV+oxO8c2iHujgUs1kgLABdcEZM4BQhsCNWdIEB0I50VfgaGj7HkQk7ksVHx3mvqA3g+ln6v+Uu8T33KJeXaWkWi0i52y1K3uCFnWq/pQmRYBxZuX11740qLjwd5OFbaMxMlLnEpBf2pAY+PeSeUAYpop2bXLHu9EElJtYvIsu+n3rc2K4awcV8hjLjpr2/gY4ECl99PbXzrhrfZxlxIWjC6PuqvXML1wQKEl+9UsqOLN5GbTYYO5/JFNOp5qlsixVfCmNULlMpQ+tVW4c0N5rAAoFHr2vAXpJxy8ca4Zq4HSm8dlLYJZSRTddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1Bg5LxHV2MwQLATtnzIa9L/CXINwtTchenngqJ0PKw=;
 b=dAo+XvPj9LjoErv50mrPKCzrFp5UiFFUDTMqVeNSyU+UgljdjTXJi0L0wqZC5WJVM4ssxd0hRXXQ8vffWIopbM1e2XcB0O/y15F1s6o5Ajxh6mE7zl1IEVKBfKYRUekGva1oEtRd1bYk1H5yyFknYbf6Bnc+GkwVbwO+ASMzfHyAzcFcejV8FzwX2Q86Z4OPmFeEJQzDenatFMQO5yy0fg9k/86ekbqedcPmxmoJ0LFoFnupx8xvx2jDrQJbivUfTYVepHK8NNQ1RwWTOI1FopZnMFfYGnP8c4rxzM12FjtoZB8jV+l7JcNEeR+X+jsXqLk1RvxiVgqVSO4YR+q+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1Bg5LxHV2MwQLATtnzIa9L/CXINwtTchenngqJ0PKw=;
 b=UdhpPogOfv48trooeXAKyVRBrW+Yi2DPGH4NHIx/AFS+rjgb8o4+Nq6ozTMDNtvTbimCQDzcI2AtmZ1CV5JXwZpbjipBeQi3ZA5Bq0teeU3VTePYigDAK/9ENZ5NQCjz8aIIzWI29mC3KcC36yriQmPcf650JMg/k0e6O0gCRhg=
Received: from MW4PR03CA0006.namprd03.prod.outlook.com (2603:10b6:303:8f::11)
 by BN8PR12MB3538.namprd12.prod.outlook.com (2603:10b6:408:96::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 1 Oct
 2021 14:41:15 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::37) by MW4PR03CA0006.outlook.office365.com
 (2603:10b6:303:8f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Fri, 1 Oct 2021 14:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:41:15 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:41:10 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>
Subject: [PATCH 04/14] drm/amd/display: Re-arrange FPU code structure for dcn2x
Date: Fri, 1 Oct 2021 22:36:10 +0800
Message-ID: <20211001143620.192679-5-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ed9e752-1590-4314-9b4f-08d984e985ab
X-MS-TrafficTypeDiagnostic: BN8PR12MB3538:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3538440F7009D4AD86ED14AA97AB9@BN8PR12MB3538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8BjcyJ7IvjRf0KyDZ9sm3tjgXjBoiPoiEHrbKRQav8sBzCDCwjjwFtE5BWM06K68Qu568g309dLGUToTJXCdtq2xAy5j9Vd9yk3Z9remVdlx2LPLSy78tZI/LHXm18PkHKYa98601uKUvie8C0UXvp4gs6dWhcFElhHRRxNf5nljospNdsrJnYWhrOHgN+wublvFKXA1sUm41FskV5fTtTB4cPoI1/MRdxGINLIbKVB1nD2ZsPeZRyLPnAh8cCOZK/rP/Cuzex6DfbqJxLCkNYxMOLtvFfv9vUL2j2iAlKZf8UbR4qmuZPZaS3HGYfXx0Wo4TnzljZgGce3uy03DBFEYQkFrVV0t9vu4WPiSTvlNdWXIJF6LPx0HH8YNCWJcguJ2pYX01azmOF97xZ+BVKDLeV1oaDiEeDI2gA1N3HrcNWZyhFS3i9zw3RsIgm3k4dglo6+ScjI5JAogxdmsguOmUmagFNjo/sDRCXEqyDH13ZgSTA1RWkgtlrghfvEqgaaarPUiOf3eHtkzl+nOpvepHiURxf9ikc6Ox9cWDh7QjFkC66hA1/0T/DGVpxgK2PsjN54fcpRO1hnOEQQWKweLpi53FIpvD5ww4I86J1FOyHDjZe8tcfrT0K5uKLWd4ripwDi0lAXrI6yVvCcOPjx3P3dROcTbZeeed7Eci8w4lhU8uNp70SNAl5u5G1AMY4tkGZE7nlukvaXYwbvCYzqvuZh7QuE/xaClanZl70=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(54906003)(44832011)(508600001)(6916009)(86362001)(36860700001)(356005)(70586007)(4326008)(2906002)(5660300002)(316002)(70206006)(7696005)(16526019)(186003)(336012)(2616005)(47076005)(426003)(82310400003)(26005)(8936002)(1076003)(83380400001)(81166007)(8676002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:41:15.3039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed9e752-1590-4314-9b4f-08d984e985ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3538
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

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
Current FPU code for DCN2x is located under dml/dcn2x.
This is not aligned with DC's general source tree
structure.

[How]
Move FPU code for DCN2x to dml/dcn20.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c              | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile                 | 4 ++--
 .../amd/display/dc/dml/{dcn2x/dcn2x.c => dcn20/dcn20_fpu.c} | 2 +-
 .../amd/display/dc/dml/{dcn2x/dcn2x.h => dcn20/dcn20_fpu.h} | 6 +++---
 7 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/dml/{dcn2x/dcn2x.c => dcn20/dcn20_fpu.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/dml/{dcn2x/dcn2x.h => dcn20/dcn20_fpu.h} (94%)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index b1bf80da3a55..ab0c6d191038 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -52,7 +52,7 @@ static DEFINE_PER_CPU(int, fpu_recursion_depth);
  * This function tells if the code is already under FPU protection or not. A
  * function that works as an API for a set of FPU operations can use this
  * function for checking if the caller invoked it after DC_FP_START(). For
- * example, take a look at dcn2x.c file.
+ * example, take a look at dcn20_fpu.c file.
  */
 inline void dc_assert_fp_enabled(void)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 899d0086ffbe..756f5d411d9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -35,7 +35,7 @@
 #include "include/irq_service_interface.h"
 #include "dcn20/dcn20_resource.h"
 
-#include "dml/dcn2x/dcn2x.h"
+#include "dml/dcn20/dcn20_fpu.h"
 
 #include "dcn10/dcn10_hubp.h"
 #include "dcn10/dcn10_ipp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index aec276e1db65..5881dc49f7c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -27,7 +27,7 @@
 #include "dc.h"
 
 #include "dcn201_init.h"
-#include "dml/dcn2x/dcn2x.h"
+#include "dml/dcn20/dcn20_fpu.h"
 #include "resource.h"
 #include "include/irq_service_interface.h"
 #include "dcn201_resource.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index fbbdf9976183..d452a0d1777e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -35,7 +35,7 @@
 #include "include/irq_service_interface.h"
 #include "dcn20/dcn20_resource.h"
 
-#include "dml/dcn2x/dcn2x.h"
+#include "dml/dcn20/dcn20_fpu.h"
 
 #include "clk_mgr.h"
 #include "dcn10/dcn10_hubp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 56055df2e8d2..169a4e68f86e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -58,7 +58,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
@@ -93,8 +93,8 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_rcflags)
 DML = display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
 
 ifdef CONFIG_DRM_AMD_DC_DCN
+DML += dcn20/dcn20_fpu.o
 DML += display_mode_vba.o dcn20/display_rq_dlg_calc_20.o dcn20/display_mode_vba_20.o
-DML += dcn2x/dcn2x.o
 DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
 DML += dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
 DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.c
rename to drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index c58522436291..d590dc917363 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -26,7 +26,7 @@
 
 #include "resource.h"
 
-#include "dcn2x.h"
+#include "dcn20_fpu.h"
 
 /**
  * DOC: DCN2x FPU manipulation Overview
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.h b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
similarity index 94%
rename from drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.h
rename to drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
index 331547ba0713..36f26126d574 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn2x/dcn2x.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
@@ -24,11 +24,11 @@
  *
  */
 
-#ifndef __DCN2X_H__
-#define __DCN2X_H__
+#ifndef __DCN20_FPU_H__
+#define __DCN20_FPU_H__
 
 void dcn20_populate_dml_writeback_from_context(struct dc *dc,
 					       struct resource_context *res_ctx,
 					       display_e2e_pipe_params_st *pipes);
 
-#endif /* __DCN2X_H__ */
+#endif /* __DCN20_FPU_H__ */
-- 
2.25.1

