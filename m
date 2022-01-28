Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95C2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884DA10EF93;
	Fri, 28 Jan 2022 14:06:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3595D10EF94
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0UU6abLPxShPVPF2p0PahsIliDZChpKTVGeJ1zu8+KdJMVdP8ouTZvF1L8qA8RKffScTTLD4DQoG2BZb3S245XJyjDm1rgDG/p/smDsapx7xRKq2HQatHoo38YqMsbdfGc3u6LZo+gyf64zGsYGUO2df3Tf8NAfde3yEkSvOojy9JVZmp1WfQuBrYlp5a735Zs+00CoDiYO3GM21s1PU1FN1XLPmqCl0GuCGK44AMC1NBXsdLOggSPLyqQRw8R3KibsoXjS+kqViyJ+GB402xWgvAwz46jG7XAJEUKwz592LvcPj0zbozYUY2um5iDcFNEUp5MEu6vc4J6GqVoILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCxv5Pf2Ft/2nkycCvj3EnnpgMM7ONqncBB0C1lYBvk=;
 b=cb5oeAEhhiiMUPyMFUtVtPY8A+010LkpFEAIVIOvTKtm1Rc148p5gurHyfU6x4LPj5hz7r1r98Lg+1d8QFNFkF951AHz9P6QESrUk4nTC643YMUqSK5qdbrZgm2h0cdLJ/YaE4dz5UvF6ZMZjhhCUJvRWmjIfS6JkZdDhGbmOQzRzScH4xA9dMVgPqJerdna03D/BSgvqXH64IYv8L+wVwIdi+BHKBZgkBihRiegS18Ux0HD6ncGey8KV/lB66+BxXEf5UiGmDigHtEYxn6i8rAgl1arMNXGkDp7lTqTj0Y6/+Jmy52Sd2i6qD0T4cA4RffkCbVdz+MeAET4tzpIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCxv5Pf2Ft/2nkycCvj3EnnpgMM7ONqncBB0C1lYBvk=;
 b=2QWv9UO4uhuSbA8GPMjWt3IcbsvyPHmryjcb9wSny9SgWqPmtUbAaxZK8/VwwIae3s1T1zf4ExK/cxJ/jraWgltLc8IbexnWFsiVnvYvEiSlwGltn7d/7q1cHnuqGt6h1xE5LLDsjUMELNIOvRDoaB6QUeYo4f+zn6Oh6FluCQ8=
Received: from DM5PR10CA0015.namprd10.prod.outlook.com (2603:10b6:4:2::25) by
 CH0PR12MB5329.namprd12.prod.outlook.com (2603:10b6:610:d4::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.17; Fri, 28 Jan 2022 14:05:57 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::4) by DM5PR10CA0015.outlook.office365.com
 (2603:10b6:4:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 14:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:05:56 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:05:51 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/17] drm/amd/display: move link_hwss to link folder and
 break down to files
Date: Fri, 28 Jan 2022 22:04:07 +0800
Message-ID: <20220128140411.3683309-14-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5b112a7-f024-468c-a15b-08d9e2674e14
X-MS-TrafficTypeDiagnostic: CH0PR12MB5329:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5329A35F022E2F60F5853498FF229@CH0PR12MB5329.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gclOHAFK3YjBdWXzc0jgr6xx5AdSYXQKH6uE3U7pyD1MYnn2LaUuZfF4okTF9fLQpfUW//ldXG3kXPUO/H+FMkJfwJQrm0My8dhdGet7jwB4N08srj0P6sFUdjux9r10sCEmzMx0VQmVxUA8zCg2U27CEjWqL2bmdyPkYFl51z++MrTirl+1N6996+GBmDX6V8h8QhbKuEY/1DHQLl+K+rlx61Vw5DtR1YrNdl2WbeCXbf2yffPIe9YCJz21mC2KZC0fmaAtLi8xsz311sncR7DVbPqIH/rwILMvDTQG5oRAe7xkqe2miTiA/q1Br+LR60cMYvm2Vglx4hauawSLotAluxRSo6hlzcgTPE7R/mFrKiOi0g0TVRtWExgv2o7WPowAbjxdU9PRj8AHZWyAn1XkX3P2NFvUvH1K6T021Q94a2b7WBjIL8fhTcqdbLVD0C5wv/i0w1HdF3VtICnrviJ5QZ3Yl2NNrrD9d01OJGhcLnnvDLY+tBOiwNeV3qVPCvz2b+z5eCNa/jyTB+xQKA/wkT4LSVnWlJLhzEOWzVA+d2gh/5EMaxp5Ft+ZgfC+tnG/VMlfyZ5T6d2AgPRhvvslQ+chNJ/E6zOEA6jUvh/KwreEHm3Ra6ii87IRMyz5t9GcOBPgJp1QTJ8zzJRv5X8WNfKI0AmQxRfLnXujiiAIsNaxo9HQkofR2+xikIL1UUUmdl2+BD8vfhEWbrNlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(44832011)(70586007)(70206006)(26005)(186003)(1076003)(16526019)(6916009)(54906003)(5660300002)(426003)(4326008)(8676002)(336012)(316002)(82310400004)(356005)(8936002)(81166007)(6666004)(83380400001)(2616005)(47076005)(86362001)(30864003)(40460700003)(36860700001)(7696005)(36756003)(2906002)(508600001)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:56.8025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b112a7-f024-468c-a15b-08d9e2674e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5329
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Move link_hwss to its own folder as part of DC LIB and break it down
to separate file one for each type of backend for code isolation.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   1 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  18 --
 drivers/gpu/drm/amd/display/dc/link/Makefile  |  30 +++
 .../drm/amd/display/dc/link/link_hwss_dio.c   | 137 +++++++++++
 .../drm/amd/display/dc/link/link_hwss_dio.h   |  53 +++++
 .../drm/amd/display/dc/link/link_hwss_dpia.c  |  51 +++++
 .../drm/amd/display/dc/link/link_hwss_dpia.h  |  34 +++
 .../link_hwss_hpo_dp.c}                       | 213 ++----------------
 .../amd/display/dc/link/link_hwss_hpo_dp.h    |  35 +++
 .../amd/display/dc/link/link_hwss_hpo_frl.c   |  43 ++++
 .../amd/display/dc/link/link_hwss_hpo_frl.h   |  34 +++
 .../gpu/drm/amd/display/dc/virtual/Makefile   |   2 +-
 .../display/dc/virtual/virtual_link_hwss.c    |  43 ++++
 .../display/dc/virtual/virtual_link_hwss.h    |  34 +++
 17 files changed, 528 insertions(+), 209 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.h
 rename drivers/gpu/drm/amd/display/dc/{core/dc_link_hwss.c => link/link_hwss_hpo_dp.c} (54%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_frl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index a4ef8f314307..0aaf394b73ff 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -23,7 +23,7 @@
 # Makefile for Display Core (dc) component.
 #
 
-DC_LIBS = basics bios clk_mgr dce dml gpio irq virtual
+DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 DC_LIBS += dcn20
@@ -58,7 +58,7 @@ AMD_DC = $(addsuffix /Makefile, $(addprefix $(FULL_AMD_DISPLAY_PATH)/dc/,$(DC_LI
 include $(AMD_DC)
 
 DISPLAY_CORE = dc.o  dc_stat.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
-dc_surface.o dc_link_hwss.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_stream.o \
+dc_surface.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_stream.o \
 dc_link_enc_cfg.o dc_link_dpia.o dc_link_dpcd.o
 
 ifdef CONFIG_DRM_AMD_DC_DCN
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 51347e1d3d95..65ebfbcf3019 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -6842,6 +6842,7 @@ bool edp_receiver_ready_T9(struct dc_link *link)
 	unsigned char sinkstatus = 0;
 	unsigned char edpRev = 0;
 	enum dc_status result = DC_OK;
+
 	result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
 
 	/* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 19e06331169d..e82aa0559bdf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -43,6 +43,10 @@
 #include "dpcd_defs.h"
 #include "link_enc_cfg.h"
 #include "dc_link_dp.h"
+#include "virtual/virtual_link_hwss.h"
+#include "link/link_hwss_dio.h"
+#include "link/link_hwss_dpia.h"
+#include "link/link_hwss_hpo_dp.h"
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/dce60_resource.h"
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index e90123b0ee0e..951c9b60917d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -54,6 +54,7 @@ void enable_surface_flip_reporting(struct dc_plane_state *plane_state,
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 #include "dm_cp_psp.h"
 #endif
+#include "link_hwss.h"
 
 /************ link *****************/
 struct link_init_data {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index fd4bfa22eda8..3b3090e3d327 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -27,7 +27,6 @@
 #define __DC_LINK_HWSS_H__
 
 /* include basic type headers only */
-#include "os_types.h"
 #include "dc_dp_types.h"
 #include "signal_types.h"
 #include "grph_object_id.h"
@@ -74,22 +73,5 @@ struct link_hwss {
 	void (*setup_stream_encoder)(struct pipe_ctx *pipe_ctx);
 	void (*reset_stream_encoder)(struct pipe_ctx *pipe_ctx);
 };
-
-
-/*********************** below goes to virtual_link_hwss **********************/
-const struct link_hwss *get_virtual_link_hwss(void);
-/*********************** below goes to dpia_link_hwss *************************/
-bool can_use_dpia_link_hwss(const struct dc_link *link,
-		const struct link_resource *link_res);
-const struct link_hwss *get_dpia_link_hwss(void);
-/*********************** below goes to hpo_dp_link_hwss ***********************/
-bool can_use_hpo_dp_link_hwss(const struct dc_link *link,
-		const struct link_resource *link_res);
-const struct link_hwss *get_hpo_dp_link_hwss(void);
-/************************* below goes to dio_link_hwss ************************/
-bool can_use_dio_link_hwss(const struct dc_link *link,
-		const struct link_resource *link_res);
-const struct link_hwss *get_dio_link_hwss(void);
-
 #endif /* __DC_LINK_HWSS_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
new file mode 100644
index 000000000000..c4a69ba7cb62
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -0,0 +1,30 @@
+#
+# Copyright 2022 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Makefile for the link sub-component of DAL.
+# It abstracts the control and status of back end pipe such as DIO, HPO, DPIA,
+# PHY, HPD, DDC and etc).
+
+LINK = link_hwss_dio.o link_hwss_dpia.o link_hwss_hpo_dp.o
+
+AMD_DAL_LINK = $(addprefix $(AMDDALPATH)/dc/link/,$(LINK))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_LINK)
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
new file mode 100644
index 000000000000..0f845113a6aa
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
@@ -0,0 +1,137 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#include "link_hwss_dio.h"
+#include "core_types.h"
+#include "dc_link_dp.h"
+#include "link_enc_cfg.h"
+
+void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
+		struct fixed31_32 throttled_vcp_size)
+{
+	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
+
+	stream_encoder->funcs->set_throttled_vcp_size(
+				stream_encoder,
+				throttled_vcp_size);
+}
+
+void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+
+	link_enc->funcs->connect_dig_be_to_fe(link_enc,
+			pipe_ctx->stream_res.stream_enc->id, true);
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_source_sequence_trace(pipe_ctx->stream->link,
+				DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
+}
+
+void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+
+	link_enc->funcs->connect_dig_be_to_fe(
+			link_enc,
+			pipe_ctx->stream_res.stream_enc->id,
+			false);
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_source_sequence_trace(pipe_ctx->stream->link,
+				DPCD_SOURCE_SEQ_AFTER_DISCONNECT_DIG_FE_BE);
+
+}
+
+void enable_dio_dp_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		const struct dc_link_settings *link_settings)
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+
+	if (dc_is_dp_sst_signal(signal))
+		link_enc->funcs->enable_dp_output(
+				link_enc,
+				link_settings,
+				clock_source);
+	else
+		link_enc->funcs->enable_dp_mst_output(
+				link_enc,
+				link_settings,
+				clock_source);
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
+}
+
+void disable_dio_dp_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+
+	link_enc->funcs->disable_output(link_enc, signal);
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
+}
+
+void set_dio_dp_link_test_pattern(struct dc_link *link,
+		const struct link_resource *link_res,
+		struct encoder_set_dp_phy_pattern_param *tp_params)
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+
+	link_enc->funcs->dp_set_phy_pattern(link_enc, tp_params);
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
+}
+
+void set_dio_dp_lane_settings(struct dc_link *link,
+		const struct link_resource *link_res,
+		const struct dc_link_settings *link_settings,
+		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
+{
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+
+	link_enc->funcs->dp_set_lane_settings(link_enc, link_settings, lane_settings);
+}
+
+static const struct link_hwss dio_link_hwss = {
+	.setup_stream_encoder = setup_dio_stream_encoder,
+	.reset_stream_encoder = reset_dio_stream_encoder,
+	.ext = {
+		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
+		.enable_dp_link_output = enable_dio_dp_link_output,
+		.disable_dp_link_output = disable_dio_dp_link_output,
+		.set_dp_link_test_pattern = set_dio_dp_link_test_pattern,
+		.set_dp_lane_settings = set_dio_dp_lane_settings,
+	},
+};
+
+bool can_use_dio_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res)
+{
+	return link->link_enc != NULL;
+}
+
+const struct link_hwss *get_dio_link_hwss(void)
+{
+	return &dio_link_hwss;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
new file mode 100644
index 000000000000..680df20b1fa3
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#ifndef __LINK_HWSS_DIO_H__
+#define __LINK_HWSS_DIO_H__
+
+#include "link_hwss.h"
+
+const struct link_hwss *get_dio_link_hwss(void);
+bool can_use_dio_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res);
+void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
+		struct fixed31_32 throttled_vcp_size);
+void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx);
+void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx);
+void enable_dio_dp_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		const struct dc_link_settings *link_settings);
+void disable_dio_dp_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal);
+void set_dio_dp_link_test_pattern(struct dc_link *link,
+		const struct link_resource *link_res,
+		struct encoder_set_dp_phy_pattern_param *tp_params);
+void set_dio_dp_lane_settings(struct dc_link *link,
+		const struct link_resource *link_res,
+		const struct dc_link_settings *link_settings,
+		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
+
+#endif /* __LINK_HWSS_DIO_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
new file mode 100644
index 000000000000..35b206225201
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#include "link_hwss_dpia.h"
+#include "core_types.h"
+#include "link_hwss_dio.h"
+
+static const struct link_hwss dpia_link_hwss = {
+	.setup_stream_encoder = setup_dio_stream_encoder,
+	.reset_stream_encoder = reset_dio_stream_encoder,
+	.ext = {
+		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
+		.enable_dp_link_output = enable_dio_dp_link_output,
+		.disable_dp_link_output = disable_dio_dp_link_output,
+		.set_dp_link_test_pattern = set_dio_dp_link_test_pattern,
+		.set_dp_lane_settings = set_dio_dp_lane_settings,
+	},
+};
+
+bool can_use_dpia_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res)
+{
+	return link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign;
+}
+
+const struct link_hwss *get_dpia_link_hwss(void)
+{
+	return &dpia_link_hwss;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.h b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.h
new file mode 100644
index 000000000000..ad16ec5d9bb7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#ifndef __LINK_HWSS_DPIA_H__
+#define __LINK_HWSS_DPIA_H__
+
+#include "link_hwss.h"
+
+const struct link_hwss *get_dpia_link_hwss(void);
+bool can_use_dpia_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res);
+
+#endif /* __LINK_HWSS_DPIA_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
similarity index 54%
rename from drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
rename to drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
index dab532cf52b9..74919491675f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
@@ -1,10 +1,31 @@
-/* Copyright 2015 Advanced Micro Devices, Inc. */
-
-#include "link_hwss.h"
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#include "link_hwss_hpo_dp.h"
 #include "dm_helpers.h"
 #include "core_types.h"
 #include "dccg.h"
-#include "link_enc_cfg.h"
 #include "dc_link_dp.h"
 
 static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
@@ -25,122 +46,6 @@ static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
 	}
 }
 
-static void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx);
-static void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx);
-
-/************************* below goes to dio_link_hwss ************************/
-static void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
-		struct fixed31_32 throttled_vcp_size)
-{
-	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
-
-	stream_encoder->funcs->set_throttled_vcp_size(
-				stream_encoder,
-				throttled_vcp_size);
-}
-
-static void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
-{
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
-
-	link_enc->funcs->connect_dig_be_to_fe(link_enc,
-			pipe_ctx->stream_res.stream_enc->id, true);
-	if (dc_is_dp_signal(pipe_ctx->stream->signal))
-		dp_source_sequence_trace(pipe_ctx->stream->link,
-				DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
-}
-
-static void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
-{
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
-
-	link_enc->funcs->connect_dig_be_to_fe(
-			link_enc,
-			pipe_ctx->stream_res.stream_enc->id,
-			false);
-	if (dc_is_dp_signal(pipe_ctx->stream->signal))
-		dp_source_sequence_trace(pipe_ctx->stream->link,
-				DPCD_SOURCE_SEQ_AFTER_DISCONNECT_DIG_FE_BE);
-
-}
-
-static void enable_dio_dp_link_output(struct dc_link *link,
-		const struct link_resource *link_res,
-		enum signal_type signal,
-		enum clock_source_id clock_source,
-		const struct dc_link_settings *link_settings)
-{
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
-
-	if (dc_is_dp_sst_signal(signal))
-		link_enc->funcs->enable_dp_output(
-				link_enc,
-				link_settings,
-				clock_source);
-	else
-		link_enc->funcs->enable_dp_mst_output(
-				link_enc,
-				link_settings,
-				clock_source);
-	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
-}
-
-
-static void disable_dio_dp_link_output(struct dc_link *link,
-		const struct link_resource *link_res,
-		enum signal_type signal)
-{
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
-
-	link_enc->funcs->disable_output(link_enc, signal);
-	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
-}
-
-static void set_dio_dp_link_test_pattern(struct dc_link *link,
-		const struct link_resource *link_res,
-		struct encoder_set_dp_phy_pattern_param *tp_params)
-{
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
-
-	ASSERT(link_enc);
-	link_enc->funcs->dp_set_phy_pattern(link_enc, tp_params);
-	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
-}
-
-static void set_dio_dp_lane_settings(struct dc_link *link,
-		const struct link_resource *link_res,
-		const struct dc_link_settings *link_settings,
-		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
-{
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
-
-	link_enc->funcs->dp_set_lane_settings(link_enc, link_settings, lane_settings);
-}
-
-static const struct link_hwss dio_link_hwss = {
-	.setup_stream_encoder = setup_dio_stream_encoder,
-	.reset_stream_encoder = reset_dio_stream_encoder,
-	.ext = {
-		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
-		.enable_dp_link_output = enable_dio_dp_link_output,
-		.disable_dp_link_output = disable_dio_dp_link_output,
-		.set_dp_link_test_pattern = set_dio_dp_link_test_pattern,
-		.set_dp_lane_settings = set_dio_dp_lane_settings,
-	},
-};
-
-bool can_use_dio_link_hwss(const struct dc_link *link,
-		const struct link_resource *link_res)
-{
-	return link->link_enc != NULL;
-}
-
-const struct link_hwss *get_dio_link_hwss(void)
-{
-	return &dio_link_hwss;
-}
-
-/*********************** below goes to hpo_dp_link_hwss ***********************/
 static void set_hpo_dp_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size)
 {
@@ -347,71 +252,3 @@ const struct link_hwss *get_hpo_dp_link_hwss(void)
 	return &hpo_dp_link_hwss;
 }
 
-/*********************** below goes to dpia_link_hwss *************************/
-static const struct link_hwss dpia_link_hwss = {
-	.setup_stream_encoder = setup_dio_stream_encoder,
-	.reset_stream_encoder = reset_dio_stream_encoder,
-	.ext = {
-		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
-		.enable_dp_link_output = enable_dio_dp_link_output,
-		.disable_dp_link_output = disable_dio_dp_link_output,
-		.set_dp_link_test_pattern = set_dio_dp_link_test_pattern,
-		.set_dp_lane_settings = set_dio_dp_lane_settings,
-	},
-};
-
-bool can_use_dpia_link_hwss(const struct dc_link *link,
-		const struct link_resource *link_res)
-{
-	return link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign;
-}
-
-const struct link_hwss *get_dpia_link_hwss(void)
-{
-	return &dpia_link_hwss;
-}
-/*********************** below goes to virtual_link_hwss ******************************/
-static void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx)
-{
-}
-
-static void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx)
-{
-}
-static const struct link_hwss virtual_link_hwss = {
-	.setup_stream_encoder = virtual_setup_stream_encoder,
-	.reset_stream_encoder = virtual_reset_stream_encoder,
-};
-
-const struct link_hwss *get_link_hwss(const struct dc_link *link,
-		const struct link_resource *link_res)
-{
-	if (can_use_dp_hpo_link_hwss(link, link_res))
-		/* TODO: some assumes that if decided link settings is 128b/132b
-		 * channel coding format hpo_dp_link_enc should be used.
-		 * Others believe that if hpo_dp_link_enc is available in link
-		 * resource then hpo_dp_link_enc must be used. This bound between
-		 * hpo_dp_link_enc != NULL and decided link settings is loosely coupled
-		 * with a premise that both hpo_dp_link_enc pointer and decided link
-		 * settings are determined based on single policy function like
-		 * "decide_link_settings" from upper layer. This "convention"
-		 * cannot be maintained and enforced at current level.
-		 * Therefore a refactor is due so we can enforce a strong bound
-		 * between those two parameters at this level.
-		 *
-		 * To put it simple, we want to make enforcement at low level so that
-		 * we will not return link hwss if caller plans to do 8b/10b
-		 * with an hpo encoder. Or we can return a very dummy one that doesn't
-		 * do work for all functions
-		 */
-		return &hpo_dp_link_hwss;
-	else if (can_use_dpia_link_hwss(link, link_res))
-		return &dpia_link_hwss;
-	else if (can_use_dio_link_hwss(link, link_res))
-		return &dio_link_hwss;
-	else
-		return &virtual_link_hwss;
-}
-
-#undef DC_LOGGER
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.h b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.h
new file mode 100644
index 000000000000..57d447ec27b8
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#ifndef __LINK_HWSS_HPO_DP_H__
+#define __LINK_HWSS_HPO_DP_H__
+
+#include "link_hwss.h"
+
+bool can_use_hpo_dp_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res);
+const struct link_hwss *get_hpo_dp_link_hwss(void);
+
+
+#endif /* __LINK_HWSS_HPO_DP_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_frl.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_frl.c
new file mode 100644
index 000000000000..9df273ca699b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_frl.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#include "link_hwss_hpo_frl.h"
+#include "core_types.h"
+#include "virtual/virtual_link_hwss.h"
+
+static const struct link_hwss hpo_frl_link_hwss = {
+	.setup_stream_encoder = virtual_setup_stream_encoder,
+	.reset_stream_encoder = virtual_reset_stream_encoder,
+};
+
+bool can_use_hpo_frl_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res)
+{
+	return link_res->hpo_frl_link_enc != NULL;
+}
+
+const struct link_hwss *get_hpo_frl_link_hwss(void)
+{
+	return &hpo_frl_link_hwss;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_frl.h b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_frl.h
new file mode 100644
index 000000000000..ea8d9760132f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_frl.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#ifndef __LINK_HWSS_HPO_FRL_H__
+#define __LINK_HWSS_HPO_FRL_H__
+
+#include "link_hwss.h"
+
+bool can_use_hpo_frl_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res);
+const struct link_hwss *get_hpo_frl_link_hwss(void);
+
+#endif /* __LINK_HWSS_HPO_FRL_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/Makefile b/drivers/gpu/drm/amd/display/dc/virtual/Makefile
index 07326d244d50..931facd4dab5 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/virtual/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the virtual sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
-VIRTUAL = virtual_link_encoder.o virtual_stream_encoder.o
+VIRTUAL = virtual_link_encoder.o virtual_stream_encoder.o virtual_link_hwss.o
 
 AMD_DAL_VIRTUAL = $(addprefix $(AMDDALPATH)/dc/virtual/,$(VIRTUAL))
 
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
new file mode 100644
index 000000000000..525eba2a3354
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "virtual_link_hwss.h"
+
+void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx)
+{
+}
+
+void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx)
+{
+}
+static const struct link_hwss virtual_link_hwss = {
+	.setup_stream_encoder = virtual_setup_stream_encoder,
+	.reset_stream_encoder = virtual_reset_stream_encoder,
+};
+
+const struct link_hwss *get_virtual_link_hwss(void)
+{
+	return &virtual_link_hwss;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
new file mode 100644
index 000000000000..e6bcb4bb0f3a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#ifndef __DC_VIRTUAL_LINK_HWSS_H__
+#define __DC_VIRTUAL_LINK_HWSS_H__
+
+#include "core_types.h"
+
+void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx);
+void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx);
+const struct link_hwss *get_virtual_link_hwss(void);
+
+#endif /* __DC_VIRTUAL_LINK_HWSS_H__ */
-- 
2.34.1

