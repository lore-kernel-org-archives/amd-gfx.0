Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF9C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44A7208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Do0t2/IV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44A7208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8E88945B;
	Fri, 19 Jun 2020 20:13:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BD96EA0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUFSiGfKbzJe0U9JKE+8zH1OrxFfo825wKq2kvfZsX7fUWlYiQQC4pHJnKMMuBazoNf/XnojIz6C+Ga4E7XMx3W7rzI8AI6sesU10qDjXdnEfgsbzLk+fZeGat55gTXEI+5V8v7Ah8OlSCXXBQ9BfeChUK/OpMW9EJauTidyu6hzBNCgc59CaGA5JxIN7jXNvT25gxeiLlItMNrJ98hkmLzjPu8IzI9Kwh2YRsQ7oUtatDgF75PsKm3Kpkr8S3O5VraaUierPJG1dj6jLeOc9ZO+6ZXH4om6N5H/Fr4pZuO6hD3379tUZaPhZBNBdbL/5yJUYk3CbO8xIKtLi7HdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K0+OgHFaLmbz3bMzxroECZH5Nt7s+UjagfqypoqkdI=;
 b=Gy8y7DA83b8GI1ypz9Q77cUJX9psai8hVxKknu6z9wxYfhy6982kI5RGHY5hhjGhXQ8JnMf80X1M4nxKSFVeO/orRWU+nYkMHmqkbhO7rjoasLAgIkMs9GX0MkCgQWdZum1V8K/t6r7os2TYZPLg4JNHgGtzVMA7PQDU2P+wXdl16G/yomMnwl/+uhgBrGC7Qi7ZgZbNfY+Gi4C5GrdyLPK6xASW7Ff+ee1aMglRalqjvlUKrA1xGJHEX8BmqeImZ4/neHtzPn1sm7Ln9F7/KU4sZULBqg73t2Wl5oMp9Gum0wE9Jo2Ec98Efg1RskXMub/yBcASL4JrbWIKhQ0BcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K0+OgHFaLmbz3bMzxroECZH5Nt7s+UjagfqypoqkdI=;
 b=Do0t2/IVfjqPE4Y2SAI0+X3/33D0eVGV1IGkKqllRfdIPs+21C9P7nWqMcusNVSv/I7lnsvguHBQaqzU06M9eOFziGathWzG0hnaXJiIziiTF78T/bNg/uLxo0MoqW2d4Ba2LSEcFsNXYJWk/TBbCwwttDLfI9+f+MD32wjl6lE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:49 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/30] drm/amd/display: Use dmub fw to lock pipe, cursor, dig
Date: Fri, 19 Jun 2020 16:11:53 -0400
Message-Id: <20200619201222.2916504-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:48 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1db91e9-ee6e-4624-1f4c-08d8148d234c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB37178BF5104B0FF083FCEA0598980@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qTOSYRXEgujmcOTEGd9jvDN0GF/WMh9b8XO9V8rnn6+ZI4aL3vjX3lMbm53mxw7G4/biefP0WcQ49ymp5+Nvl4wTNBe+Do8tGUN4ZuagnbYH0kzdHIaUqbUV/H/qLmqLu327OK6SNcx9CjEPeeiP+1ZnfpYKkpO4JOClEN75fZDwcMD38Ykxnd3c3hwErvZRTVtICppXlUbPFVBCL3Jh+mPwgspFSOXirVV0kpUdZpBADcD1AUjGklsoqw/YMNlQl7qobJCOYuCao/cW6L0GgWCXfTBykBag1ksPM2ELjTrvpj1utQO8prO9eidgsTYnIZ0iv5DE0YHJCLGjMDqBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(5660300002)(66476007)(16526019)(86362001)(6916009)(83380400001)(478600001)(66556008)(66946007)(8676002)(6512007)(1076003)(30864003)(6666004)(6506007)(4326008)(52116002)(8936002)(2906002)(316002)(6486002)(36756003)(186003)(2616005)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5JxmkT/5T1O9aKvEDo2FivT8GfClthwBMaj0ENlSboG/8BdGFMX8oBhX2+ybUaRkrmbucWHBQeS/kfGknl/JnXKmIshfTSS8X06KJJdbo0x5tFs/NI3am1ULrH8UpvuATigCu1ZV5uw/Cr2wpS+5SfoR6mln/G7UYJkpIAbiB23JsNkQQTZtMH0OrItXLtDuKaBZoSay5MGt8fL814PV3vy4PbvRQ5BOTGr8g3MGYvDmnjEcF8RsD4TNr+gGQvchI3+p3RRkLX8CGbTsBBLr+i3TJsW2j5WVKwzJ2OJX9S+nX6xz8cILp70OFcdAOpSf9YV9J0hAmhXYy+m17WoXokaBaeJPjjAlx5KHeyHoLhsrecxlf8p/rq/0w5X5lIiCvlZPF9g6URf/0KnJF+a+ajkQJwpHpz8P7UcLPlL/G+j3aOXYJmBGej4C+BBTe0JeHZP28oZ9WM022yxbcZSoz1ZystTPqV3nOO8XUQHemGan0ktCVqJ59jBYmd6yDhYi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1db91e9-ee6e-4624-1f4c-08d8148d234c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:48.9768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /46cAky6cbDff5vXBeL0q+27nO+aiK1VOwsH4j1cCFkSVT5GVNRco8vdFbu0p+gvEOABqyIqAI3i2XoDp8P1VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Hw lock manager adds the ability to lock pipe, cursor, and dig in fw.

[How]
Send hw lock command to fw to lock pipe, cursor, and dig.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 36 ++++++++++--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 43 ++++++++++++--
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |  3 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 57 +++++++++++++++++++
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h | 39 +++++++++++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 17 +++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 18 +++++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  1 +
 8 files changed, 200 insertions(+), 14 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 49dd310ed588..db5feb89d4af 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -68,6 +68,8 @@
 
 #include "dmub/dmub_srv.h"
 
+#include "dce/dmub_hw_lock_mgr.h"
+
 #define CTX \
 	dc->ctx
 
@@ -2321,9 +2323,22 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
-		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable)
-			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable(
-					top_pipe_to_program->stream_res.tg);
+		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
+			if (stream && should_use_dmub_lock(stream->link)) {
+				union dmub_hw_lock_flags hw_locks = { 0 };
+				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+
+				hw_locks.bits.lock_dig = 1;
+				inst_flags.dig_inst = top_pipe_to_program->stream_res.tg->inst;
+
+				dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
+							true,
+							&hw_locks,
+							&inst_flags);
+			} else
+				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable(
+						top_pipe_to_program->stream_res.tg);
+		}
 
 	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
 		dc->hwss.interdependent_update_lock(dc, context, true);
@@ -2493,7 +2508,20 @@ static void commit_planes_for_stream(struct dc *dc,
 			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
 					top_pipe_to_program->stream_res.tg,
 					CRTC_STATE_VACTIVE);
-			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_disable(
+
+			if (stream && should_use_dmub_lock(stream->link)) {
+				union dmub_hw_lock_flags hw_locks = { 0 };
+				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+
+				hw_locks.bits.lock_dig = 1;
+				inst_flags.dig_inst = top_pipe_to_program->stream_res.tg->inst;
+
+				dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
+							false,
+							&hw_locks,
+							&inst_flags);
+			} else
+				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_disable(
 					top_pipe_to_program->stream_res.tg);
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 484a6849f3de..3da5d76ee8b6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -12,6 +12,8 @@
 #include "dc_link_ddc.h"
 #include "core_status.h"
 #include "dpcd_defs.h"
+#include "dc_dmub_srv.h"
+#include "dce/dmub_hw_lock_mgr.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
@@ -4030,9 +4032,23 @@ bool dc_link_dp_set_test_pattern(
 			break;
 		}
 
-		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_enable)
-			pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_enable(
-					pipe_ctx->stream_res.tg);
+		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_enable) {
+			if (pipe_ctx->stream && should_use_dmub_lock(pipe_ctx->stream->link)) {
+				union dmub_hw_lock_flags hw_locks = { 0 };
+				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+
+				hw_locks.bits.lock_dig = 1;
+				inst_flags.dig_inst = pipe_ctx->stream_res.tg->inst;
+
+				dmub_hw_lock_mgr_cmd(link->ctx->dmub_srv,
+							true,
+							&hw_locks,
+							&inst_flags);
+			} else
+				pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_enable(
+						pipe_ctx->stream_res.tg);
+		}
+
 		pipe_ctx->stream_res.tg->funcs->lock(pipe_ctx->stream_res.tg);
 		/* update MSA to requested color space */
 		pipe_ctx->stream_res.stream_enc->funcs->dp_set_stream_attribute(pipe_ctx->stream_res.stream_enc,
@@ -4059,9 +4075,24 @@ bool dc_link_dp_set_test_pattern(
 				CRTC_STATE_VBLANK);
 		pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg,
 				CRTC_STATE_VACTIVE);
-		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_disable)
-			pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_disable(
-					pipe_ctx->stream_res.tg);
+
+		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_disable) {
+			if (pipe_ctx->stream && should_use_dmub_lock(pipe_ctx->stream->link)) {
+				union dmub_hw_lock_flags hw_locks = { 0 };
+				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+
+				hw_locks.bits.lock_dig = 1;
+				inst_flags.dig_inst = pipe_ctx->stream_res.tg->inst;
+
+				dmub_hw_lock_mgr_cmd(link->ctx->dmub_srv,
+							false,
+							&hw_locks,
+							&inst_flags);
+			} else
+				pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_disable(
+						pipe_ctx->stream_res.tg);
+		}
+
 		/* Set Test Pattern state */
 		link->test_pattern_enabled = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/Makefile b/drivers/gpu/drm/amd/display/dc/dce/Makefile
index f704a8fd52e8..973be8f9fd10 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce/Makefile
@@ -29,7 +29,8 @@
 DCE = dce_audio.o dce_stream_encoder.o dce_link_encoder.o dce_hwseq.o \
 dce_mem_input.o dce_clock_source.o dce_scl_filters.o dce_transform.o \
 dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o dce_aux.o \
-dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o dce_panel_cntl.o
+dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o dce_panel_cntl.o \
+dmub_hw_lock_mgr.o
 
 AMD_DAL_DCE = $(addprefix $(AMDDALPATH)/dc/dce/,$(DCE))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
new file mode 100644
index 000000000000..d399270fd17e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -0,0 +1,57 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
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
+#include "dmub_hw_lock_mgr.h"
+#include "dc_dmub_srv.h"
+#include "dc_types.h"
+#include "core_types.h"
+
+void dmub_hw_lock_mgr_cmd(struct dc_dmub_srv *dmub_srv,
+				bool lock,
+				union dmub_hw_lock_flags *hw_locks,
+				struct dmub_hw_lock_inst_flags *inst_flags)
+{
+	union dmub_rb_cmd cmd = { 0 };
+
+	cmd.lock_hw.header.type = DMUB_CMD__HW_LOCK;
+	cmd.lock_hw.header.sub_type = 0;
+	cmd.lock_hw.header.payload_bytes = sizeof(struct dmub_cmd_lock_hw_data);
+	cmd.lock_hw.lock_hw_data.client = HW_LOCK_CLIENT_DRIVER;
+	cmd.lock_hw.lock_hw_data.lock = lock;
+	cmd.lock_hw.lock_hw_data.hw_locks.u8All = hw_locks->u8All;
+	memcpy(&cmd.lock_hw.lock_hw_data.inst_flags, inst_flags, sizeof(struct dmub_hw_lock_inst_flags));
+
+	if (!lock)
+		cmd.lock_hw.lock_hw_data.should_release = 1;
+
+	dc_dmub_srv_cmd_queue(dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dmub_srv);
+	dc_dmub_srv_wait_idle(dmub_srv);
+}
+
+bool should_use_dmub_lock(struct dc_link *link)
+{
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
new file mode 100644
index 000000000000..bc5906347493
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright 2012-16 Advanced Micro Devices, Inc.
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
+#ifndef _DMUB_HW_LOCK_MGR_H_
+#define _DMUB_HW_LOCK_MGR_H_
+
+#include "dc_dmub_srv.h"
+#include "core_types.h"
+
+void dmub_hw_lock_mgr_cmd(struct dc_dmub_srv *dmub_srv,
+				bool lock,
+				union dmub_hw_lock_flags *hw_locks,
+				struct dmub_hw_lock_inst_flags *inst_flags);
+
+bool should_use_dmub_lock(struct dc_link *link);
+
+#endif /*_DMUB_HW_LOCK_MGR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 8d3a125a0cae..845e7f823a3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -51,6 +51,7 @@
 #include "link_hwss.h"
 #include "dpcd_defs.h"
 #include "dsc.h"
+#include "dce/dmub_hw_lock_mgr.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1763,8 +1764,20 @@ void dcn10_cursor_lock(struct dc *dc, struct pipe_ctx *pipe, bool lock)
 	if (lock)
 		delay_cursor_until_vupdate(dc, pipe);
 
-	dc->res_pool->mpc->funcs->cursor_lock(dc->res_pool->mpc,
-			pipe->stream_res.opp->inst, lock);
+	if (pipe->stream && should_use_dmub_lock(pipe->stream->link)) {
+		union dmub_hw_lock_flags hw_locks = { 0 };
+		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+
+		hw_locks.bits.lock_cursor = 1;
+		inst_flags.opp_inst = pipe->stream_res.opp->inst;
+
+		dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
+					lock,
+					&hw_locks,
+					&inst_flags);
+	} else
+		dc->res_pool->mpc->funcs->cursor_lock(dc->res_pool->mpc,
+				pipe->stream_res.opp->inst, lock);
 }
 
 static bool wait_for_reset_trigger_to_occur(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index db57cb619a0c..789e33fae016 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -49,6 +49,8 @@
 #include "dc_link_dp.h"
 #include "vm_helper.h"
 #include "dccg.h"
+#include "dc_dmub_srv.h"
+#include "dce/dmub_hw_lock_mgr.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1194,7 +1196,21 @@ void dcn20_pipe_control_lock(
 		    (!flip_immediate && pipe->stream_res.gsl_group > 0))
 			dcn20_setup_gsl_group_as_lock(dc, pipe, flip_immediate);
 
-	if (pipe->plane_state != NULL && pipe->plane_state->triplebuffer_flips) {
+	if (pipe->stream && should_use_dmub_lock(pipe->stream->link)) {
+		union dmub_hw_lock_flags hw_locks = { 0 };
+		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+
+		hw_locks.bits.lock_pipe = 1;
+		inst_flags.otg_inst =  pipe->stream_res.tg->inst;
+
+		if (pipe->plane_state != NULL)
+			hw_locks.bits.triple_buffer_lock = pipe->plane_state->triplebuffer_flips;
+
+		dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
+					lock,
+					&hw_locks,
+					&inst_flags);
+	} else if (pipe->plane_state != NULL && pipe->plane_state->triplebuffer_flips) {
 		if (lock)
 			pipe->stream_res.tg->funcs->triplebuffer_lock(pipe->stream_res.tg);
 		else
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7c03c4798348..44f74047050a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -619,6 +619,7 @@ struct dmub_rb_cmd_abm_init_config {
 };
 
 union dmub_rb_cmd {
+	struct dmub_rb_cmd_lock_hw lock_hw;
 	struct dmub_rb_cmd_read_modify_write read_modify_write;
 	struct dmub_rb_cmd_reg_field_update_sequence reg_field_update_seq;
 	struct dmub_rb_cmd_burst_write burst_write;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
