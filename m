Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9852FE936E8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127B010E3BD;
	Wed,  4 Oct 2023 21:21:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF19110E3BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMMHIpwoxMFEBYzA4NMw52U2GzjXZ4oOS9wiAIiEg4QJgi8uHk/5peMnJRdTMHHzeN8x/PAa8loMaeUUJmgfMydmxtpDrOANDqDjcbRfSCVK8mU8BJm+KVy3Z8A7Gx7oN8bdzb6n+MuL67WbCV1K7wj1ECZN3vLlHju+w9g/KGmlVz2zKWaFEk2glfF1/pDH0C4jVueD5GgA2IQu2Fy4mNWLpe40fexzxy6aGDiON6LwFQ21y1sACOfWPbL+/pDVI2y4vIUVtjMdYHD0lLMU9/aGiyGvHuOcu1z4s9ryAVKErZ5m/3HilpYy86cUd4YEJyrkFlTmkVBBqp+n2MeuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do0mmjJjrMMlvbOvvYAGdIKHRkibTgQH6m2xiaf+a8s=;
 b=a/QLUL4U802xpC17NZRwy0t1JsSFjNDoS7nj4BWro3aZXofDGZiA/LeJBqsP2GnHVBs3sUyqNBu4a1fq+I+oPUBJB+WPl8A9Y6YloWUZ4vI/L9u9uIXzjZcTLKHDgMuxOcukeD8k0K7gfHC5ZrjDuMjmwwqofHty9rPO41ftaOroL8vnui6L9x9Wk3Frtq9dLcf/Obu87EtkA/9PgwR6WMAL5CgZQNvELVroB4tO8GFaxTxXSkNVDRNU1kTJAeg+v4s8eAX2C39s15nft6S6T8cdrfOdKils2SrGDpM7cBwsojTYXnPR/q86qWOXotPZNP/054r74LoRoyuSiVuIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do0mmjJjrMMlvbOvvYAGdIKHRkibTgQH6m2xiaf+a8s=;
 b=F0tNnGJEGxLccHyIx1s83l1TQ0bO7fyZh8PJ2gmwGHXvGT6foVVVwRvjqJ4n+ekQ6NzWzBNdx3DK2rLgwuH8KNl6+rwdX2tX7WK3KiPIaBT4eAWbfx3TA98IS0QJ89ovC5+zTTs2vn5QDE4rFwmqDPisgg3ytvb2+6JGlJW6zTQ=
Received: from MN2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:236::7)
 by BN9PR12MB5307.namprd12.prod.outlook.com (2603:10b6:408:104::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 4 Oct
 2023 21:21:41 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::58) by MN2PR05CA0038.outlook.office365.com
 (2603:10b6:208:236::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 21:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:21:41 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:39 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 03/16] drm/amd/display: Move bw_fixed outside DML folder
Date: Wed, 4 Oct 2023 15:20:57 -0600
Message-ID: <20231004212110.3753955-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|BN9PR12MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d28d593-eebe-4151-a031-08dbc51fe6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WKXCl6QXJ6MMevpdVJE5MnrzjNfDWxnrHoMnBnZic3E8uAflMgGzhKVP4eVmssKNmlmL7Xd3741Ust/ZuAjixscx27xvcxnqqcGZG9FxBkoMbhQ9LnMXTwlO8L2Qy+krLE5k+AFMd0+mJk0rycKLwbwSGf5NDw3F+qYlVDp5aMzTTGBM6H22aPPJbz4EpT4d1kgXbTSYPiSCeBVc8/4QKZEi1roTF+5HTtJmqXosSJors6jI8DU/Nd+frgtWT4c/i5/nxgv2hGYxcvGNsDG3rV+2eYaVyzPhyLS7xIeZDeSZw60+rg6p3MKfLje0WAevGtWQ/xB5Xh0qZ1AU5yS9oTEwuj/Y353IJhGkC2wEiNvQDO7B8ppfJifkLwqB6UFAjPLU7LZydLTbDKMjC18ytUwgJd14wDmI0y01x1A5a2FeM0OdubaHS6/cfsIt+Q7EUNKQcdw0UdTjZRecglomY25H1yLSphpwsH4ux2jLL4rhIIflnsnGHL+2cfVn5kPvzDmviKQVEx4DixwJI3DnnWI9Y7PZJlc3dlApbxV/yUkEotJnqtsseC3VH5Kyyk/yubskPR/wmteGd7/lVJLIIVtmgzpOfG9xgn8kO2lAFwJA/4AL0Nim3DFhRWu54ORljii/qc3V6xNSp3qgDoh64C/1CcMvP7yiWbYu540I5ReYh1QU+RlELrAoRVhdq+S6kbn49haNqDi679abX1o8/ymvk/ngimaMdPbS/Ylz/TZkDqmuR3VS6V545/1A4HeWhgnFp/cT8jwCQCYk+xBIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(83380400001)(478600001)(6666004)(16526019)(26005)(1076003)(356005)(2616005)(82740400003)(81166007)(36860700001)(426003)(336012)(47076005)(70586007)(70206006)(316002)(54906003)(8936002)(8676002)(4326008)(41300700001)(86362001)(40480700001)(5660300002)(2906002)(36756003)(6916009)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:21:41.2169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d28d593-eebe-4151-a031-08dbc51fe6f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5307
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
Cc: Sunpeng.Li@amd.com, richard.gong@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

bw_fixed does not need any FPU operation, and it is used on DCE and DCN.
For this reason, this commit moves bw_fixed to the basic folder outside
DML.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/basics/Makefile      |  3 ++-
 .../amd/display/dc/{dml/calcs => basics}/bw_fixed.c | 13 ++++++-------
 drivers/gpu/drm/amd/display/dc/dml/Makefile         |  2 --
 3 files changed, 8 insertions(+), 10 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{dml/calcs => basics}/bw_fixed.c (94%)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/Makefile b/drivers/gpu/drm/amd/display/dc/basics/Makefile
index 65d713aff407..aabcebf69049 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/basics/Makefile
@@ -30,7 +30,8 @@ BASICS := \
 	vector.o \
 	dc_common.o \
 	dce_calcs.o \
-	custom_float.o
+	custom_float.o \
+	bw_fixed.o
 
 AMD_DAL_BASICS = $(addprefix $(AMDDALPATH)/dc/basics/,$(BASICS))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c b/drivers/gpu/drm/amd/display/dc/basics/bw_fixed.c
similarity index 94%
rename from drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
rename to drivers/gpu/drm/amd/display/dc/basics/bw_fixed.c
index 3aa8dd0acd5e..c8cb89e0d4d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/bw_fixed.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2015 Advanced Micro Devices, Inc.
+ * Copyright 2023 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -106,9 +107,8 @@ struct bw_fixed bw_frc_to_fixed(int64_t numerator, int64_t denominator)
 	return res;
 }
 
-struct bw_fixed bw_floor2(
-	const struct bw_fixed arg,
-	const struct bw_fixed significance)
+struct bw_fixed bw_floor2(const struct bw_fixed arg,
+			  const struct bw_fixed significance)
 {
 	struct bw_fixed result;
 	int64_t multiplicand;
@@ -119,9 +119,8 @@ struct bw_fixed bw_floor2(
 	return result;
 }
 
-struct bw_fixed bw_ceil2(
-	const struct bw_fixed arg,
-	const struct bw_fixed significance)
+struct bw_fixed bw_ceil2(const struct bw_fixed arg,
+			 const struct bw_fixed significance)
 {
 	struct bw_fixed result;
 	int64_t multiplicand;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 2fe8588a070a..ea7d60f9a9b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -134,8 +134,6 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
 
-DML = calcs/bw_fixed.o
-
 ifdef CONFIG_DRM_AMD_DC_FP
 DML += display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o
 DML += dcn10/dcn10_fpu.o
-- 
2.40.1

