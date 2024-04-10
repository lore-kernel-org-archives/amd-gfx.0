Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7DACD128A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D4210EA50;
	Wed, 10 Apr 2024 21:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hWHk2iD0";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C2810EA44
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD/m1E0X7BIBbyrgfMiYEKBVL8LtSZDU3DzVPPtPz44aoKgFDmHt+8OvDYuXrdCD40rMTulB61/7+eqdvkbpDzINK+yDnJBTln6QAf2lkNV6nEELRM7oQwC2lTsYJ6PmgP4UnTFdKzJajUzbYP9BbLMaqvbhCsRylpN8jRO9TmypXk0IvEWMe/WXcWopB7JF9ew8o4n/lPn0Dm5P9RE7gGitLktS94AfflUuy5ek6z4HDJKBYkfehyBTprzMQ/ZASn1CewLp2E7gGpQouV7BJy4SIW8/9syhAOSxTB1ZxJUIS4Ws/xRKossDncnb0Xa0lwlE9p1/ecCJUNU00dfRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf1YgynAg4+im+i7x4O65Ijn6r7XyDhkMo26vn1bt7o=;
 b=A4nLgY6eyhYNBLat6Itn9FSAK4oftcICDdu7rosVjK25EO0h7XMUYr3Ak8JaX6Hzga5LrD7ulVt4s073OS0wfWOiZh75E4T/qFgzAPqNh88emq02soZCmBK3Mpc7v0hRjSF1lF+JY+4EuvmLNRdXiGglYTPuwVcSl8bFBTXVACeAShikk7wMH+HsNFWl/CHRbSn9MfJZJr8wdpPsyLcQjIXP9PjY7YeY21K+mj3/KiFIU0mMYALpxmmDhc1+gCAijBxQ7nYeEGlhH/mVOXtgwof1JkSqFE3rcTSikeD7H0ilJ59zFS38n2MdyXqmcEw1NlZ09f98g10Fp82hcG5eQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf1YgynAg4+im+i7x4O65Ijn6r7XyDhkMo26vn1bt7o=;
 b=hWHk2iD0ABiGwWTbz+V9s0PozX0Zl1IhyDk39JDQfhQWEw0DIp5YxQT7GcpkNczmM8aZ8HybZheprx8yo3G4tGg7j4LOKsTqlZ4FEb1/K2Ap1uDD07Yf2EbRNNlxm4RJdzfJM20/Ajp3cEYAqqcvlWR01D+1tEhXO+R9k8T9/8Y=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:27:53 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::c2) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Wed, 10 Apr 2024 21:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:27:53 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:27:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Duncan Ma <duncan.ma@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 01/25] drm/amd/display: Modify power sequence
Date: Wed, 10 Apr 2024 15:25:50 -0600
Message-ID: <20240410212726.1312989-2-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddd7374-6a1d-4b33-24c2-08dc59a514c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQMsu77yCvsP2171IKpG2ZUxq7AZxH035siOV83wPaO20uFkUBbgA1NiVQZdxIu768t2ql6ml4qwcGUBNl0nhflFoPwfNyaT6+XajF+2SscuP/cMvF4IZ2WfyjOodutZm/iqjT3/JSWjFAOMgyYKf1s1NqcU+GZU0vBSed8KqKmi++BUs97LoBRSZJ/NiP3qrKkG6A4tYW2hrvQoZoEXyVlRfHqSH4LyPx2p5Nb07sQICBovJj1p/fgmUl+UcRz76xwKTAl+v1I02g/HFzi90sivHlOT37ra7HmVndBtDO1imESi7/AtsX2YrU3fwADkVxRToqpbZxMwqSCBlC8OP8oqvmOi+Cl0IRFiQmJ/gMdPi+BkYQcV9Kg8XAy4EBPTWadlbulpgP2rwsGKDetw28OQJfFh+0AdTIrYM8bS0hp3Add3UffKtzfroLH/AzuUk+e4MtcPT7mNufuHJMRcAGGYmt4bBXom7kffkkoFDAaOfAxOo2a6OkV+gnrV2bIIsW2hXazNLd7Mlx4RV9C7/pu7eSOvve6DhtQGXHIDr3ZD17wfPQ92c/BYE1JfFzLNthmxKOFgiXbrkn/fkokKyaczs+Ye+I7wHfkdh7/ssckeH9WGbe41co9qGehJMyXWXjFHy+8NiAXtI+oz3si2msJJ2qeUY7vZj4wMQlmgz/FadJAYO3OP+07HRvGb4lrJwFnraO7ODs7xYrZDUSc/WqkwATAyk+XO8qfnelbA2Di8RNu68wep3bXBYLOpXcPC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:27:53.1820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddd7374-6a1d-4b33-24c2-08dc59a514c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

Need to update the power sequence to help prevent potential issues like
multi-display or multi-plane.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |   2 +-
 .../drm/amd/display/dc/hwss/dcn351/Makefile   |  25 ++-
 .../amd/display/dc/hwss/dcn351/dcn351_hwseq.c | 182 ++++++++++++++++++
 .../amd/display/dc/hwss/dcn351/dcn351_hwseq.h |  41 ++++
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   9 +-
 5 files changed, 247 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.h

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/Makefile b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
index 9e8e9de51a92..cf8aa23b4415 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
@@ -180,7 +180,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN35)
 
 ###############################################################################
 
-HWSS_DCN351 = dcn351_init.o
+HWSS_DCN351 = dcn351_hwseq.o dcn351_init.o
 
 AMD_DAL_HWSS_DCN351 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn351/,$(HWSS_DCN351))
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/Makefile b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/Makefile
index b24ad27fe6ef..a4b3c1e99ec6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/Makefile
@@ -1,16 +1,27 @@
 #
-# (c) Copyright 2022 Advanced Micro Devices, Inc. All the rights reserved
+# Copyright (c) 2022-2024 Advanced Micro Devices, Inc.
 #
-#  All rights reserved.  This notice is intended as a precaution against
-#  inadvertent publication and does not imply publication or any waiver
-#  of confidentiality.  The year included in the foregoing notice is the
-#  year of creation of the work.
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
 #
-#  Authors: AMD
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
 #
 # Makefile for DCN351.
 
-DCN351 = dcn351_init.o
+DCN351 = dcn351_hwseq.o dcn351_init.o
 
 AMD_DAL_DCN351 = $(addprefix $(AMDDALPATH)/dc/dcn351/,$(DCN351))
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c
new file mode 100644
index 000000000000..93fe5b262a3d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
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
+#include "core_types.h"
+#include "resource.h"
+#include "dcn351_hwseq.h"
+#include "dcn35/dcn35_hwseq.h"
+
+#define DC_LOGGER_INIT(logger) \
+	struct dal_logger *dc_logger = logger
+
+#define DC_LOGGER \
+	dc_logger
+
+void dcn351_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
+	struct pg_block_update *update_state)
+{
+	int i, j;
+
+	dcn35_calc_blocks_to_gate(dc, context, update_state);
+
+	for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+		if (!update_state->pg_pipe_res_update[PG_HUBP][i] &&
+			!update_state->pg_pipe_res_update[PG_DPP][i]) {
+			for (j = i - 1; j >= 0; j--) {
+				update_state->pg_pipe_res_update[PG_HUBP][j] = false;
+				update_state->pg_pipe_res_update[PG_DPP][j] = false;
+			}
+
+			break;
+		}
+	}
+}
+
+void dcn351_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
+	struct pg_block_update *update_state)
+{
+	int i, j;
+
+	dcn35_calc_blocks_to_ungate(dc, context, update_state);
+
+	for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+		if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
+			update_state->pg_pipe_res_update[PG_DPP][i]) {
+			for (j = i - 1; j >= 0; j--) {
+				update_state->pg_pipe_res_update[PG_HUBP][j] = true;
+				update_state->pg_pipe_res_update[PG_DPP][j] = true;
+			}
+
+			break;
+		}
+	}
+}
+
+/**
+ * dcn351_hw_block_power_down() - power down sequence
+ *
+ * The following sequence describes the ON-OFF (ONO) for power down:
+ *
+ *	ONO Region 11, DCPG 19: dsc3
+ *	ONO Region 10, DCPG 3: dchubp3, dpp3
+ *	ONO Region 9, DCPG 18: dsc2
+ *	ONO Region 8, DCPG 2: dchubp2, dpp2
+ *	ONO Region 7, DCPG 17: dsc1
+ *	ONO Region 6, DCPG 1: dchubp1, dpp1
+ *	ONO Region 5, DCPG 16: dsc0
+ *	ONO Region 4, DCPG 0: dchubp0, dpp0
+ *	ONO Region 3, DCPG 25: hpo - SKIPPED. Should be kept on
+ *	ONO Region 2, DCPG 24: mpc opp optc dwb
+ *	ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will pwr dwn at IPS2 entry
+ *	ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED. will be pwr dwn after lono timer is armed
+ *
+ * @dc: Current DC state
+ * @update_state: update PG sequence states for HW block
+ */
+void dcn351_hw_block_power_down(struct dc *dc,
+	struct pg_block_update *update_state)
+{
+	int i = 0;
+	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
+
+	if (!pg_cntl || dc->debug.ignore_pg)
+		return;
+
+	for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
+			if (pg_cntl->funcs->dsc_pg_control)
+				pg_cntl->funcs->dsc_pg_control(pg_cntl, i, false);
+		}
+
+		if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
+			update_state->pg_pipe_res_update[PG_DPP][i]) {
+			if (pg_cntl->funcs->hubp_dpp_pg_control)
+				pg_cntl->funcs->hubp_dpp_pg_control(pg_cntl, i, false);
+		}
+	}
+
+	// domain25 currently always on.
+
+	/* this will need all the clients to unregister optc interrupts, let dmubfw handle this */
+	if (pg_cntl->funcs->plane_otg_pg_control)
+		pg_cntl->funcs->plane_otg_pg_control(pg_cntl, false);
+
+	// domain23 currently always on.
+	// domain22 currently always on.
+}
+
+/**
+ * dcn351_hw_block_power_up() - power up sequence
+ *
+ * The following sequence describes the ON-OFF (ONO) for power up:
+ *
+ *	ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED
+ *	ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will power up at IPS2 exit
+ *	ONO Region 2, DCPG 24: mpc opp optc dwb
+ *	ONO Region 3, DCPG 25: hpo - SKIPPED
+ *	ONO Region 4, DCPG 0: dchubp0, dpp0
+ *	ONO Region 5, DCPG 16: dsc0
+ *	ONO Region 6, DCPG 1: dchubp1, dpp1
+ *	ONO Region 7, DCPG 17: dsc1
+ *	ONO Region 8, DCPG 2: dchubp2, dpp2
+ *	ONO Region 9, DCPG 18: dsc2
+ *	ONO Region 10, DCPG 3: dchubp3, dpp3
+ *	ONO Region 11, DCPG 19: dsc3
+ *
+ * @dc: Current DC state
+ * @update_state: update PG sequence states for HW block
+ */
+void dcn351_hw_block_power_up(struct dc *dc,
+	struct pg_block_update *update_state)
+{
+	int i = 0;
+	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
+
+	if (!pg_cntl || dc->debug.ignore_pg)
+		return;
+
+	// domain22 currently always on.
+	// domain23 currently always on.
+
+	/* this will need all the clients to unregister optc interrupts, let dmubfw handle this */
+	if (pg_cntl->funcs->plane_otg_pg_control)
+		pg_cntl->funcs->plane_otg_pg_control(pg_cntl, true);
+
+	// domain25 currently always on.
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
+			update_state->pg_pipe_res_update[PG_DPP][i]) {
+			if (pg_cntl->funcs->hubp_dpp_pg_control)
+				pg_cntl->funcs->hubp_dpp_pg_control(pg_cntl, i, true);
+		}
+
+		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
+			if (pg_cntl->funcs->dsc_pg_control)
+				pg_cntl->funcs->dsc_pg_control(pg_cntl, i, true);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.h
new file mode 100644
index 000000000000..6d8f3bfb668e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
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
+#ifndef __DC_HWSS_DCN351_H__
+#define __DC_HWSS_DCN351_H__
+
+#include "hw_sequencer_private.h"
+
+void dcn351_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
+	struct pg_block_update *update_state);
+void dcn351_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
+	struct pg_block_update *update_state);
+void dcn351_hw_block_power_up(struct dc *dc,
+	struct pg_block_update *update_state);
+void dcn351_hw_block_power_down(struct dc *dc,
+	struct pg_block_update *update_state);
+
+#endif /* __DC_HWSS_DCN351_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index c54f3518c947..c4944478ed91 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -32,6 +32,7 @@
 #include "dcn31/dcn31_hwseq.h"
 #include "dcn32/dcn32_hwseq.h"
 #include "dcn35/dcn35_hwseq.h"
+#include "dcn351/dcn351_hwseq.h"
 
 #include "dcn351_init.h"
 
@@ -115,10 +116,10 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.apply_idle_power_optimizations = dcn35_apply_idle_power_optimizations,
 	.update_dsc_pg = dcn32_update_dsc_pg,
-	.calc_blocks_to_gate = dcn35_calc_blocks_to_gate,
-	.calc_blocks_to_ungate = dcn35_calc_blocks_to_ungate,
-	.hw_block_power_up = dcn35_hw_block_power_up,
-	.hw_block_power_down = dcn35_hw_block_power_down,
+	.calc_blocks_to_gate = dcn351_calc_blocks_to_gate,
+	.calc_blocks_to_ungate = dcn351_calc_blocks_to_ungate,
+	.hw_block_power_up = dcn351_hw_block_power_up,
+	.hw_block_power_down = dcn351_hw_block_power_down,
 	.root_clock_control = dcn35_root_clock_control,
 };
 
-- 
2.43.0

