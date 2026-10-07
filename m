Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF03CCA600B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B774B10F6FD;
	Wed,  7 Oct 2026 17:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N6c+gqpq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E7F10F6F9
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JknHr6MOndDQilU7aTGSqgj2caMyk774ee1DBqhWq+T8guiLzMaGRHcU1BfbGxjuTa5k6AvZzofb0dH/dely+qhLe0IEsp+XYeGmbFQeW4uo7gVhh7+R4hwpqzfitb9B3BCNCuSRYpB9tcbzY/wmQd1yxq1oEXI+zIC8z9ssUKn3v3LtbFwHY5uZXd6ObpFD9MRjsBWEs1s/IOFWAhCzHS32OokxMQOCV5tYwk5Lw0rAapSsbcwuCUrt04en8gyP7WRNs/1gh6vcDHAF007h922ZFYzKFYm94371pFfvP6LkC7dnwJtChMTKSpM6E9eVK+jC6s8OTf39i3Akg1+ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYbSZ9gPt2zrSelXuGJmYX2VHty8FspOxeuTle2gvDs=;
 b=Wur+k6t5yfxwqtObwpDlbShdjQ8uKe32A12sCqbA1/Ra1tFlqvet4el5g65Twth5o3brnNEEAiKFAFbNDN1G/ZT2tWVSrqVe7PHuFI4ufWudk68DKgEUn4OUz+VzWfqtU1QQgKytIhlfJPYvc7aVJA9Z8SCP7rfZc825Xov85NXG6Ho/HYcSR8CXXPQHL6hD0re7WA4Ju5C35JPrzYQW4DuIvtqV3kuqszTCapu4QkRT2+dwSlaB0Y5GLKbWikpEPxGm1A4CHAeCXZccDItRCGQy1gIZakc1BaasL9DVbXiirBK3cH3UtqwfgDdM3h6a/wxYFnd1V2R1Mcmtiggy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYbSZ9gPt2zrSelXuGJmYX2VHty8FspOxeuTle2gvDs=;
 b=N6c+gqpqXPAB1GwG106YOd6cV8rQT4oWESDCNhnZlszhVqEMtWujZPmFj0sRs4V+aZ9uYZtPtT41TpQPM8/4BEjjQhVEyvVfy20rE0sqJzeNdPQqzMrfN+LGpJH42bPBe1+HKxXvJzSUzUg7Azdg96Fq9HCqg580OUMkF35thWY=
Received: from SJ2P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::15)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 17:04:30 +0000
Received: from MW1PEPF00018894.namprd03.prod.outlook.com
 (2603:10b6:a03:5db:cafe::a1) by SJ2P221CA0001.outlook.office365.com
 (2603:10b6:a03:5db::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018894.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:24 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:19 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Sridevi Arvindekar <Sridevi.Arvindekar@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Sridevi Arvindekar
 <sridevi.arvindekar@amd.com>
Subject: [PATCH 04/19] drm/amd/display: Fix upsampling for linear scaling of
 subsampled YUV
Date: Wed, 7 Oct 2026 12:59:37 -0400
Message-ID: <20261007170412.1898315-5-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018894:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1ba9ca-f2aa-45af-bd3e-08df24950d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|22082099003|18002099003|6133799003|10067099003|260925021911599003|56012099006|260925021311599003|260925022911599003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: kmGQRHS4nIbhtKrYxyhQ3gZgWa7pTRPoctt2NMXzI32g4DK4VKKmi/puIaqG6nshAJqojq2ZcY4X0VWjVg91gJyJphfhjbqReRhbukQe18jtSRBsoc/73eEvy75ewSn2CzRGa/vBo5AeY+jU7auP3ms4aBZNncTVaN6fymKKmsbffzVqHcQ4eyH0iHitdp98FuYluI1j0spR7Z5SO+vbD4lFFSOXJqedUs9/qIiqjtg8PUiJZxnihXlfz4yEJJR1Zj9omlzNzjFx6aI4CON/BxkSqVxfp1N2jNeaqUbigdHgK3Tb9Cgpyul2ItUvPPTIIrg6byVCogqq8F0/zQHY1sdAmKkrJIUQfCkf98SHaurmfrJEKAm1YBNI0430T/tu8IXb9ALFwBAQJHW+We0kX8eiAiEvvtvrtGEF3L7xdW5HA49zygISv0vqk9cqCF2YkJPz7bGhHs8v2gnF9Sq+anWHwC6fxdVFB1oXvQcUJLJ6Qjai5wQtgQ/bDUsF97jms5Dj5WuSGm0WpmhmicdqCpJs9L+OfFVH8WO8Lk9IJ57VThw7y6suPPb0P1ohBA31L/WkLV5h9YSq+crevSaQq3qHLrNG9m1xSRZRPJdyoEie9f3EHLK3AR5DMnkQA5UDcc6FWOVLyrhi47/JfEhyhnIB3dHohQ+qzTcxR4PABJXc8vfD0hTd5cusI/9J3mpnYtJ1OojavoXq7I8bFmf7Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(6133799003)(10067099003)(260925021911599003)(56012099006)(260925021311599003)(260925022911599003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t6KtFWG487hjB6UUOMJuogFSVqfpo2h6uYx6+TkDl57+9aDxLBl/7bRYlzpUZDHTP8UIZFkqiSdax7nvt6azo9v0H23T52KiXuVZ1iVgZtv8HNemxrOXhR/hyksR8Ku0y/ix0XZBox32BugKFh5dRdgURRQ/5B9HAKVMWUzAUks/gTCKphOeNpqc/NQYIuTBBeIgnqUI8go7AzuvB/cfpjwcBRDRNFyrC/SUv+Am8bsos/XAj5Q8ro8RaGdtI6PzkR313KmoIVIpa49tk+3FeZgQTtkUJDk5qFgMeoLlrGuu/WmZrcCQcdIrAHa9fec8+u9cjIlh18LeihRJMPkJ81f7kw9EXtTyzIV/v8kzzpzApEuUS43qSqrhxWXieFwJqwCq7sRM27ObgcKc+P39ebUybSGhGpdFh2u7pN1Jyf4VjmlUen6qGThI/s54Uu3l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:29.9135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1ba9ca-f2aa-45af-bd3e-08df24950d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018894.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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

From: Sridevi Arvindekar <Sridevi.Arvindekar@amd.com>

[Why]
When a subsampled YUV surface is scaled in linear space, the chroma
planes are interpolated before being upsampled to 4:4:4, producing
incorrect chroma on the scaled output.

[How]
Enable the CNVC chroma upsampler for these cases:
- resource_is_upsp_required() selects the mode from the surface format
- DPP programs the pre-CSC matrix
- DCN60 programs the CNVC_UPSP coefficients
- SPL and DSCL treat a pipe with upsp enabled as 4:4:4 RGB

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  1 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 19 -----
 .../amd/display/dc/core/dc_resource_helper.c  | 46 +++++++++++
 .../gpu/drm/amd/display/dc/dc_spl_translate.c | 22 ++++--
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |  4 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |  3 +-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c  |  4 +-
 .../amd/display/dc/dpp/dcn201/dcn201_dpp.c    |  4 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  | 76 ++++++++++++++++++-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |  9 ++-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |  4 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |  3 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  8 +-
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |  4 +-
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c  |  4 +-
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h  |  3 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  | 38 ++++++++--
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h  | 15 ++--
 .../amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c | 13 ++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |  3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  3 +-
 .../dc/resource/dcn60/dcn60_resource.h        |  6 ++
 26 files changed, 237 insertions(+), 66 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index f868999515dd..1cbf284bb2fd 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -75,6 +75,7 @@ FILES += core/dc_hw_sequencer.o
 FILES += core/dc_link_enc_cfg.o
 FILES += core/dc_link_exports.o
 FILES += core/dc_resource.o
+FILES += core/dc_resource_helper.o
 FILES += core/dc_sink.o
 FILES += core/dc_stat.o
 FILES += core/dc_state.o
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 430dc7a220ef..f881a3be6f0a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -2964,7 +2964,8 @@ void hwss_setup_dpp(union block_sequence_params *params)
 				EXPANSION_MODE_ZERO,
 				p->input_csc_color_matrix,
 				p->color_space,
-				NULL);
+				NULL,
+				p->upsp_mode);
 	}
 }
 
@@ -5722,6 +5723,7 @@ void hwss_add_dpp_setup_dpp(struct block_sequence_state *seq_state,
 		p->format = plane_state->format;
 		p->input_csc_color_matrix = plane_state->input_csc_color_matrix;
 		p->color_space = plane_state->color_space;
+		p->upsp_mode = resource_is_upsp_required(plane_state->format, plane_state->scaling_linearity);
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 187486d978da..fa44c68b3340 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1557,25 +1557,6 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 	}
 }
 
-enum upsp_mode resource_is_upsp_required(enum surface_pixel_format format,
-		enum dc_scaling_linearity scaling_linearity)
-{
-	bool scaling_in_linear = (scaling_linearity == DC_SCALING_LINEARITY_LINEAR);
-	bool is_420_format = (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
-			format <= SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb);
-	bool is_422_format = (format > SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb &&
-			format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
-
-	/* UPSP (chroma upsampling) is only needed when subsampled YUV is scaled in
-	 * linear space.
-	 */
-	if (scaling_in_linear && is_420_format)
-		return UPSP_HORIZONTAL_VERTICAL_UPSAMPLING;
-	if (scaling_in_linear && is_422_format)
-		return UPSP_HORIZONTAL_UPSAMPLING_ONLY;
-	return UPSP_BYPASS;
-}
-
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c
new file mode 100644
index 000000000000..55dfa465163f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ * SPDX-License-Identifier: MIT
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
+ */
+
+#include "dc_types.h"
+#include "sspl/dc_spl_types.h"
+#include "resource.h"
+
+enum upsp_mode resource_is_upsp_required(enum surface_pixel_format format,
+		enum dc_scaling_linearity scaling_linearity)
+{
+	bool scaling_in_linear = (scaling_linearity == DC_SCALING_LINEARITY_LINEAR);
+	bool is_420_format = (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
+		format <= SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb);
+	bool is_422_format = (format > SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb &&
+		format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
+
+	/* UPSP (chroma upsampling) is only needed when subsampled YUV is scaled in
+	 * linear space.
+	 */
+	if (scaling_in_linear && is_420_format)
+		return UPSP_HORIZONTAL_VERTICAL_UPSAMPLING;
+	if (scaling_in_linear && is_422_format)
+		return UPSP_HORIZONTAL_UPSAMPLING_ONLY;
+	return UPSP_BYPASS;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 76c0d62031b6..00e121bb8ef7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -209,21 +209,27 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 		}
 	}
 	// Translate linear light scaling preference
-	if (pipe_ctx->stream->ctx->dc->debug.force_lls > 0)
+	if (pipe_ctx->stream->ctx->dc->debug.force_lls > 0) {
 		spl_in->lls_pref = pipe_ctx->stream->ctx->dc->debug.force_lls;
-	else
+		spl_in->upsp_mode = pipe_ctx->plane_res.scl_data.upsp;
+	} else {
 		if ((plane_state->ctx->dce_version == DCN_VERSION_4_01) ||
 			(plane_state->ctx->dce_version == DCN_VERSION_4_2) ||
-			(plane_state->ctx->dce_version == DCN_VERSION_4_2B))
+			(plane_state->ctx->dce_version == DCN_VERSION_4_2B)) {
 			spl_in->lls_pref = LLS_PREF_DONT_CARE;
-		else
+			spl_in->upsp_mode = UPSP_BYPASS;
+		} else {
 			set_linear_light_scaling_preference(plane_state, spl_in);
-	/* Translate upsampling mode*/
-	spl_in->upsp_mode = pipe_ctx->plane_res.scl_data.upsp;
+			/* Translate upsampling mode*/
+			spl_in->upsp_mode = pipe_ctx->plane_res.scl_data.upsp;
+		}
+	}
 	/* Translate chroma subsampling offset ( cositing ) */
-	if (pipe_ctx->stream->ctx->dc->debug.force_cositing)
+	if (pipe_ctx->stream->ctx->dc->debug.force_cositing) {
 		spl_in->basic_in.cositing = pipe_ctx->stream->ctx->dc->debug.force_cositing - 1;
-	else
+		if (spl_in->upsp_mode && spl_in->basic_in.cositing == CHROMA_COSITING_NONE)
+			spl_in->basic_in.cositing = CHROMA_COSITING_TOPLEFT;
+	} else
 		spl_in->basic_in.cositing = plane_state->cositing;
 	/* Translate transfer function */
 	spl_in->basic_in.tf_type = (enum spl_transfer_func_type) plane_state->in_transfer_func.type;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index ef605e0a75e3..de420cdf1514 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -286,9 +286,11 @@ void dpp1_cnv_setup (
 		enum expansion_mode mode,
 		struct dc_csc_transform input_csc_color_matrix,
 		enum dc_color_space input_color_space,
-		struct cnv_alpha_2bit_lut *alpha_2bit_lut)
+		struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+		enum upsp_mode upsp_mode)
 {
 	(void)alpha_2bit_lut;
+	(void)upsp_mode;
 	uint32_t pixel_format;
 	uint32_t alpha_en;
 	enum pixel_format_description fmt ;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
index 890d04b1ddaf..b04d5fa2cd32 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
@@ -1501,7 +1501,8 @@ void dpp1_cnv_setup (
 		enum expansion_mode mode,
 		struct dc_csc_transform input_csc_color_matrix,
 		enum dc_color_space input_color_space,
-		struct cnv_alpha_2bit_lut *alpha_2bit_lut);
+		struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+		enum upsp_mode upsp_mode);
 
 void dpp1_dppclk_control(
 		struct dpp *dpp_base,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
index 8d5000790904..0f3b1717563b 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
@@ -103,8 +103,10 @@ static void dpp2_cnv_setup (
 		enum expansion_mode mode,
 		struct dc_csc_transform input_csc_color_matrix,
 		enum dc_color_space input_color_space,
-		struct cnv_alpha_2bit_lut *alpha_2bit_lut)
+		struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+		enum upsp_mode upsp_mode)
 {
+	(void)upsp_mode;
 	struct dcn20_dpp *dpp = TO_DCN20_DPP(dpp_base);
 	uint32_t pixel_format = 0;
 	uint32_t alpha_en = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
index d78ab3ffd95d..a2079db62f63 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
@@ -47,8 +47,10 @@ static void dpp201_cnv_setup(
 		enum expansion_mode mode,
 		struct dc_csc_transform input_csc_color_matrix,
 		enum dc_color_space input_color_space,
-		struct cnv_alpha_2bit_lut *alpha_2bit_lut)
+		struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+		enum upsp_mode upsp_mode)
 {
+	(void)upsp_mode;
 	struct dcn201_dpp *dpp = TO_DCN201_DPP(dpp_base);
 	uint32_t pixel_format = 0;
 	uint32_t alpha_en = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 2ebc738c37f2..3db10019fa84 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -100,6 +100,78 @@ void dpp30_read_reg_state(struct dpp *dpp_base, struct dcn_dpp_reg_state *dpp_re
 	dpp_reg_state->mpc_size = REG_READ(MPC_SIZE);
 }
 
+void dpp3_program_pre_csc(
+		struct dpp *dpp_base,
+		enum dc_color_space color_space,
+		enum dcn10_input_csc_select input_select,
+		const struct out_csc_color_matrix *tbl_entry)
+{
+	int i;
+	enum dcn10_input_csc_select select;
+	struct color_matrices_reg gam_regs;
+	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
+	int arr_size = sizeof(dpp_input_csc_matrix)/sizeof(struct dpp_input_csc_matrix);
+	const uint16_t *regval = NULL;
+	uint32_t cur_select = 0;
+
+	if (input_select == INPUT_CSC_SELECT_BYPASS) {
+		REG_SET(PRE_CSC_MODE, 0, PRE_CSC_MODE, 0);
+		return;
+	}
+
+	if (tbl_entry == NULL) {
+		for (i = 0; i < arr_size; i++)
+			if (dpp_input_csc_matrix[i].color_space == color_space) {
+				regval = dpp_input_csc_matrix[i].regval;
+				break;
+			}
+
+		if (regval == NULL) {
+			BREAK_TO_DEBUGGER();
+			return;
+		}
+	} else {
+		regval = tbl_entry->regval;
+	}
+
+	/* determine which CSC matrix (icsc or coma) we are using
+	 * currently.  select the alternate set to double buffer
+	 * the CSC update so CSC is updated on frame boundary
+	 */
+	REG_GET(PRE_CSC_MODE,
+			PRE_CSC_MODE_CURRENT, &cur_select);
+
+	if (cur_select != INPUT_CSC_SELECT_ICSC)
+		select = INPUT_CSC_SELECT_ICSC;
+	else
+		select = INPUT_CSC_SELECT_COMA;
+
+	gam_regs.shifts.csc_c11 = dpp->tf_shift->PRE_CSC_C11;
+	gam_regs.masks.csc_c11  = dpp->tf_mask->PRE_CSC_C11;
+	gam_regs.shifts.csc_c12 = dpp->tf_shift->PRE_CSC_C12;
+	gam_regs.masks.csc_c12 = dpp->tf_mask->PRE_CSC_C12;
+
+	if (select == INPUT_CSC_SELECT_ICSC) {
+
+		gam_regs.csc_c11_c12 = REG(PRE_CSC_C11_C12);
+		gam_regs.csc_c33_c34 = REG(PRE_CSC_C33_C34);
+
+	} else {
+
+		gam_regs.csc_c11_c12 = REG(PRE_CSC_B_C11_C12);
+		gam_regs.csc_c33_c34 = REG(PRE_CSC_B_C33_C34);
+
+	}
+
+	cm_helper_program_color_matrices(
+			dpp->base.ctx,
+			regval,
+			&gam_regs);
+
+	REG_SET(PRE_CSC_MODE, 0,
+			PRE_CSC_MODE, select);
+}
+
 /*program post scaler scs block in dpp CM*/
 void dpp3_program_post_csc(
 		struct dpp *dpp_base,
@@ -223,8 +295,10 @@ void dpp3_cnv_setup (
 		enum expansion_mode mode,
 		struct dc_csc_transform input_csc_color_matrix,
 		enum dc_color_space input_color_space,
-		struct cnv_alpha_2bit_lut *alpha_2bit_lut)
+		struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+		enum upsp_mode upsp_mode)
 {
+	(void)upsp_mode;
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 	uint32_t pixel_format = 0;
 	uint32_t alpha_en = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
index f397e8222ac9..349a1b9ee916 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
@@ -629,7 +629,8 @@ void dpp3_cnv_setup(
 		enum expansion_mode mode,
 		struct dc_csc_transform input_csc_color_matrix,
 		enum dc_color_space input_color_space,
-		struct cnv_alpha_2bit_lut *alpha_2bit_lut);
+		struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+		enum upsp_mode upsp_mode);
 
 void dpp3_program_CM_bias(
 		struct dpp *dpp_base,
@@ -650,6 +651,12 @@ void dpp3_set_cursor_attributes(
 		struct dpp *dpp_base,
 		struct dc_cursor_attributes *cursor_attributes);
 
+void dpp3_program_pre_csc(
+		struct dpp *dpp_base,
+		enum dc_color_space color_space,
+		enum dcn10_input_csc_select input_select,
+		const struct out_csc_color_matrix *tbl_entry);
+
 void dpp3_program_post_csc(
 		struct dpp *dpp_base,
 		enum dc_color_space color_space,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
index 8e0fa7be34ee..7a3a7678c71a 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
@@ -58,8 +58,10 @@ void dpp401_dpp_setup(
 	enum expansion_mode mode,
 	struct dc_csc_transform input_csc_color_matrix,
 	enum dc_color_space input_color_space,
-	struct cnv_alpha_2bit_lut *alpha_2bit_lut)
+	struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+	enum upsp_mode upsp_mode)
 {
+	(void)upsp_mode;
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
 	uint32_t pixel_format = 0;
 	uint32_t alpha_en = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
index e34d291de37b..f1530e8805cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
@@ -712,7 +712,8 @@ void dpp401_dpp_setup(
 	enum expansion_mode mode,
 	struct dc_csc_transform input_csc_color_matrix,
 	enum dc_color_space input_color_space,
-	struct cnv_alpha_2bit_lut *alpha_2bit_lut);
+	struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+	enum upsp_mode upsp_mode);
 
 void dpp401_set_cursor_attributes(
 	struct dpp *dpp_base,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 81f287c89562..6e85890e44f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -478,8 +478,9 @@ enum lb_memory_config dpp401_dscl_find_lb_memory_config(struct dcn401_dpp *dpp,
 	int ceil_vratio_c = dc_fixpt_ceil(scl_data->ratios.vert_c);
 
 	if (dpp->base.ctx->dc->debug.use_max_lb) {
-		if (scl_data->format == PIXEL_FORMAT_420BPP8
+		if ((scl_data->format == PIXEL_FORMAT_420BPP8
 				|| scl_data->format == PIXEL_FORMAT_420BPP10)
+				&& !scl_data->upsp)
 			return LB_MEMORY_CONFIG_3;
 		return LB_MEMORY_CONFIG_0;
 	}
@@ -498,8 +499,9 @@ enum lb_memory_config dpp401_dscl_find_lb_memory_config(struct dcn401_dpp *dpp,
 			&& dpp401_dscl_is_lb_conf_valid(ceil_vratio_c, num_part_c, vtaps_c))
 		return LB_MEMORY_CONFIG_2;
 
-	if (scl_data->format == PIXEL_FORMAT_420BPP8
-			|| scl_data->format == PIXEL_FORMAT_420BPP10) {
+	if ((scl_data->format == PIXEL_FORMAT_420BPP8
+			|| scl_data->format == PIXEL_FORMAT_420BPP10)
+			&& !scl_data->upsp) {
 		dpp->base.caps->dscl_calc_lb_num_partitions(
 				scl_data, LB_MEMORY_CONFIG_3, &num_part_y, &num_part_c);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
index eed86f5ae731..2ce0694e3725 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
@@ -118,8 +118,10 @@ static void dpp42_dpp_setup(
 	enum expansion_mode mode,
 	struct dc_csc_transform input_csc_color_matrix,
 	enum dc_color_space input_color_space,
-	struct cnv_alpha_2bit_lut *alpha_2bit_lut)
+	struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+	enum upsp_mode upsp_mode)
 {
+	(void)upsp_mode;
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
 	uint32_t pixel_format = 0;
 	uint32_t alpha_en = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
index 38739ed048fa..5382fc656169 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
@@ -90,8 +90,10 @@ void dpp50_dpp_setup(
 	enum expansion_mode mode,
 	struct dc_csc_transform input_csc_color_matrix,
 	enum dc_color_space input_color_space,
-	struct cnv_alpha_2bit_lut *alpha_2bit_lut)
+	struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+	enum upsp_mode upsp_mode)
 {
+	(void)upsp_mode;
 	struct dcn50_dpp *dpp = TO_DCN50_DPP(dpp_base);
 	uint32_t pixel_format = 0;
 	uint32_t alpha_en = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
index c81e910ae095..fb9ed75ae901 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
@@ -77,7 +77,8 @@ void dpp50_dpp_setup(
 	enum expansion_mode mode,
 	struct dc_csc_transform input_csc_color_matrix,
 	enum dc_color_space input_color_space,
-	struct cnv_alpha_2bit_lut *alpha_2bit_lut);
+	struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+	enum upsp_mode upsp_mode);
 
 void dpp50_set_pregam_state(
 	struct dpp *dpp_base,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
index be2effb14fc3..4218863d2a04 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
@@ -24,7 +24,8 @@ void dpp60_dpp_setup(
 	enum expansion_mode mode,
 	struct dc_csc_transform input_csc_color_matrix,
 	enum dc_color_space input_color_space,
-	struct cnv_alpha_2bit_lut *alpha_2bit_lut)
+	struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+	enum upsp_mode upsp_mode)
 {
 	struct dcn60_dpp *dpp = TO_DCN60_DPP(dpp_base);
 	uint32_t pixel_format = 8;
@@ -249,25 +250,47 @@ void dpp60_dpp_setup(
 		PRE_REALPHA_EN, realpha_en,
 		PRE_REALPHA_ABLND_EN, realpha_ablnd_en);
 
-	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN ||
-			format >= SURFACE_PIXEL_FORMAT_SUBSAMPLE_END ||
-			color_space != COLOR_SPACE_SRGB) {
-		/* If input adjustment exists, program the ICSC with those values. */
+	// color matrix applied PreCSC for upsp mode
+	if (upsp_mode) {
 		if (input_csc_color_matrix.enable_adjustment == true) {
 			for (i = 0; i < 12; i++)
 				tbl_entry.regval[i] = input_csc_color_matrix.matrix[i];
 
 			tbl_entry.color_space = input_color_space;
 
+			// Re-use post csc function to program pre csc as
+			// the programming is same for both
 			if (dpp3_should_bypass_post_csc_for_colorspace(color_space))
 				select = INPUT_CSC_SELECT_BYPASS;
 			else
 				select = INPUT_CSC_SELECT_ICSC;
 
-			dpp3_program_post_csc(dpp_base, color_space, select,
+			dpp3_program_pre_csc(dpp_base, color_space, select,
 				&tbl_entry);
 		} else {
-			dpp3_program_post_csc(dpp_base, color_space, select, NULL);
+			dpp3_program_pre_csc(dpp_base, color_space, select, NULL);
+		}
+	} else {
+		if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN ||
+			format >= SURFACE_PIXEL_FORMAT_SUBSAMPLE_END ||
+			color_space != COLOR_SPACE_SRGB) {
+			/* If input adjustment exists, program the ICSC with those values. */
+			if (input_csc_color_matrix.enable_adjustment == true) {
+				for (i = 0; i < 12; i++)
+					tbl_entry.regval[i] = input_csc_color_matrix.matrix[i];
+
+				tbl_entry.color_space = input_color_space;
+
+				if (dpp3_should_bypass_post_csc_for_colorspace(color_space))
+					select = INPUT_CSC_SELECT_BYPASS;
+				else
+					select = INPUT_CSC_SELECT_ICSC;
+
+				dpp3_program_post_csc(dpp_base, color_space,
+						select, &tbl_entry);
+			} else {
+				dpp3_program_post_csc(dpp_base, color_space, select, NULL);
+			}
 		}
 	}
 }
@@ -317,6 +340,7 @@ static struct dpp_funcs dcn60_dpp_funcs = {
 	.dpp_cm_hist_read			= dpp42_dpp_cm_hist_read,
 	.dpp_read_reg_state			= dpp30_read_reg_state,
 	.dpp_set_pregam_state		= dpp50_set_pregam_state,
+	.dpp_program_upsp			= dpp60_dscl_program_upsp
 };
 
 static struct dpp_caps dcn60_dpp_cap = {
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
index 5d09fcd04553..f12a6061e5fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
@@ -448,12 +448,12 @@
 #define DPP_REG_VARIABLE_LIST_DCN60 \
 	DPP_REG_VARIABLE_LIST_DCN50; \
 	uint32_t SCL_BLACK_COLOR; \
-	uint32_t UPSP_MODE; \
-	uint32_t UPSP_V_COEF_P0; \
-	uint32_t UPSP_V_COEF_P1; \
-	uint32_t UPSP_H_COEF_P0; \
-	uint32_t UPSP_H_COEF_P1; \
-	uint32_t UPSP_CLAMP
+	uint32_t CNVC_UPSP_MODE; \
+	uint32_t CNVC_UPSP_V_COEF_P0; \
+	uint32_t CNVC_UPSP_V_COEF_P1; \
+	uint32_t CNVC_UPSP_H_COEF_P0; \
+	uint32_t CNVC_UPSP_H_COEF_P1; \
+	uint32_t CNVC_UPSP_CLAMP
 
 struct dcn60_dpp_registers {
 	DPP_REG_VARIABLE_LIST_DCN60;
@@ -490,7 +490,8 @@ void dpp60_dpp_setup(
 	enum expansion_mode mode,
 	struct dc_csc_transform input_csc_color_matrix,
 	enum dc_color_space input_color_space,
-	struct cnv_alpha_2bit_lut *alpha_2bit_lut);
+	struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+	enum upsp_mode upsp_mode);
 
 void dpp60_full_bypass(struct dpp *dpp_base);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c
index 0898148ba704..f030b2a0a1f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c
@@ -187,6 +187,7 @@ void dpp60_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 		v_num_taps_c = scl_data->dscl_prog_data.taps.v_taps_c;
 		h_num_taps = scl_data->dscl_prog_data.taps.h_taps;
 		h_num_taps_c = scl_data->dscl_prog_data.taps.h_taps_c;
+		ycbcr = ycbcr && !scl_data->dscl_prog_data.upsp_mode;
 	}
 
 	/* Unconditionally power on DSCL - can be in light sleep otherwise. */
@@ -280,7 +281,7 @@ void dpp60_dscl_program_upsp(struct dpp *dpp_base,
 {
 	struct dcn60_dpp *dpp = TO_DCN60_DPP(dpp_base);
 
-	REG_SET_8(UPSP_MODE, 0,
+	REG_SET_8(CNVC_UPSP_MODE, 0,
 			UPSP_MODE, dscl_prog_data->upsp_mode,
 			UPSP_V_NUM_TAPS, dscl_prog_data->upsp_v_num_taps,
 			UPSP_V_INIT_INT, dscl_prog_data->upsp_v_init_int,
@@ -289,27 +290,27 @@ void dpp60_dscl_program_upsp(struct dpp *dpp_base,
 			UPSP_H_INIT_INT, dscl_prog_data->upsp_h_init_int,
 			UPSP_H_INIT_FRAC, dscl_prog_data->upsp_h_init_frac,
 			UPSP_BOUNDARY_MODE, dscl_prog_data->upsp_boundary_mode);
-	REG_SET_4(UPSP_V_COEF_P0, 0,
+	REG_SET_4(CNVC_UPSP_V_COEF_P0, 0,
 			UPSP_V_COEF_TAP0_P0, dscl_prog_data->upsp_v_coef_tap0_p0,
 			UPSP_V_COEF_TAP1_P0, dscl_prog_data->upsp_v_coef_tap1_p0,
 			UPSP_V_COEF_TAP2_P0, dscl_prog_data->upsp_v_coef_tap2_p0,
 			UPSP_V_COEF_TAP3_P0, dscl_prog_data->upsp_v_coef_tap3_p0);
-	REG_SET_4(UPSP_V_COEF_P1, 0,
+	REG_SET_4(CNVC_UPSP_V_COEF_P1, 0,
 			UPSP_V_COEF_TAP0_P1, dscl_prog_data->upsp_v_coef_tap0_p1,
 			UPSP_V_COEF_TAP1_P1, dscl_prog_data->upsp_v_coef_tap1_p1,
 			UPSP_V_COEF_TAP2_P1, dscl_prog_data->upsp_v_coef_tap2_p1,
 			UPSP_V_COEF_TAP3_P1, dscl_prog_data->upsp_v_coef_tap3_p1);
-	REG_SET_4(UPSP_H_COEF_P0, 0,
+	REG_SET_4(CNVC_UPSP_H_COEF_P0, 0,
 			UPSP_H_COEF_TAP0_P0, dscl_prog_data->upsp_h_coef_tap0_p0,
 			UPSP_H_COEF_TAP1_P0, dscl_prog_data->upsp_h_coef_tap1_p0,
 			UPSP_H_COEF_TAP2_P0, dscl_prog_data->upsp_h_coef_tap2_p0,
 			UPSP_H_COEF_TAP3_P0, dscl_prog_data->upsp_h_coef_tap3_p0);
-	REG_SET_4(UPSP_H_COEF_P1, 0,
+	REG_SET_4(CNVC_UPSP_H_COEF_P1, 0,
 			UPSP_H_COEF_TAP0_P1, dscl_prog_data->upsp_h_coef_tap0_p1,
 			UPSP_H_COEF_TAP1_P1, dscl_prog_data->upsp_h_coef_tap1_p1,
 			UPSP_H_COEF_TAP2_P1, dscl_prog_data->upsp_h_coef_tap2_p1,
 			UPSP_H_COEF_TAP3_P1, dscl_prog_data->upsp_h_coef_tap3_p1);
-	REG_SET_2(UPSP_CLAMP, 0,
+	REG_SET_2(CNVC_UPSP_CLAMP, 0,
 			UPSP_CLAMP_MAX, dscl_prog_data->upsp_clamp_max,
 			UPSP_CLAMP_MIN, dscl_prog_data->upsp_clamp_min);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index c42e493720bc..2ab247d9748b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2943,7 +2943,8 @@ static void dcn10_update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state
 			EXPANSION_MODE_ZERO,
 			plane_state->input_csc_color_matrix,
 			plane_state->color_space,
-			NULL);
+			NULL,
+			0);
 
 	//set scale and bias registers
 	build_prescale_params(&bns_params, plane_state);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 27b886e78998..6b8c5b1e436c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1787,7 +1787,8 @@ void dcn20_update_dchubp_dpp(
 				EXPANSION_MODE_ZERO,
 				plane_state->input_csc_color_matrix,
 				plane_state->color_space,
-				NULL);
+				NULL,
+				pipe_ctx->plane_res.scl_data.upsp);
 
 		if (dpp->funcs->set_cursor_matrix) {
 			dpp->funcs->set_cursor_matrix(dpp,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
index 7a82aaa6d1d6..151ec838f613 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
@@ -153,7 +153,8 @@ void dcn50_update_dchubp_dpp(
 			EXPANSION_MODE_ZERO,
 			plane_state->input_csc_color_matrix,
 			plane_state->color_space,
-			NULL);
+			NULL,
+			pipe_ctx->plane_res.scl_data.upsp);
 
 		if (dpp->funcs->set_cursor_matrix) {
 			dpp->funcs->set_cursor_matrix(dpp,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 7e7054608d74..7de59001453c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -155,6 +155,7 @@ struct setup_dpp_params {
 	enum surface_pixel_format format;
 	struct dc_csc_transform input_csc_color_matrix;
 	enum dc_color_space color_space;
+	enum upsp_mode upsp_mode;
 };
 
 struct program_bias_and_scale_params {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 71244d3b6c90..562176e8d7d1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -314,7 +314,8 @@ struct dpp_funcs {
 			enum expansion_mode mode,
 			struct dc_csc_transform input_csc_color_matrix,
 			enum dc_color_space input_color_space,
-			struct cnv_alpha_2bit_lut *alpha_2bit_lut);
+			struct cnv_alpha_2bit_lut *alpha_2bit_lut,
+			enum upsp_mode upsp_mode);
 
 	void (*dpp_full_bypass)(struct dpp *dpp_base);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
index b1a802f9f4b4..34cfdc6eb8e5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
@@ -370,6 +370,12 @@ bool dcn50_program_mcache_pipe_config(struct dc_state *context,
 	SRI_ARR(CM_TEST_DEBUG_DATA, CM, id),                                     \
 	SRI_ARR(FORMAT_CONTROL, CNVC_CFG, id),                                   \
 	SRI_ARR(CNVC_SURFACE_PIXEL_FORMAT, CNVC_CFG, id),                        \
+	SRI_ARR(CNVC_UPSP_CLAMP, CNVC_CFG, id),                                  \
+	SRI_ARR(CNVC_UPSP_MODE, CNVC_CFG, id),                                   \
+	SRI_ARR(CNVC_UPSP_H_COEF_P0, CNVC_CFG, id),                              \
+	SRI_ARR(CNVC_UPSP_H_COEF_P1, CNVC_CFG, id),                              \
+	SRI_ARR(CNVC_UPSP_V_COEF_P0, CNVC_CFG, id),                              \
+	SRI_ARR(CNVC_UPSP_V_COEF_P1, CNVC_CFG, id),                              \
 	SRI_ARR(CURSOR0_CONTROL, CM_CUR, id),                                    \
 	SRI_ARR(CURSOR0_COLOR0, CM_CUR, id),                                     \
 	SRI_ARR(CURSOR0_COLOR1, CM_CUR, id),                                     \
-- 
2.43.0

