Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D841C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9122074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOp62nPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9122074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D854C6E593;
	Mon,  1 Jun 2020 18:29:43 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21906E52E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:29:42 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id w3so10018902qkb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fl/MMeX9ESkcyrM4QlaRTi/4w2GcnLMhUo9h5kXAm10=;
 b=nOp62nPJXzaqzDEFzo3W8bieUNwSGGZDtIxhliYVkoM1r4ohxT1eN9NhJRUznyZZk/
 8Y4S2NBpt1QnH3dkNSaqNE121O1/clPrZSzZXIgKL0Zf/topKi8TRqlq4lGBdr0ueWbh
 vmS/4mGotCOQtlbuApVeejBLKf1uC7UTWuft7Env8f5nqp4VrXtJjRnHFKzWo9TZsBEm
 B2ilDyzvYnD9DFo8r9qDtBBjY0I+p8nAZCsYRSZyGTbWsLipAQDDjVxIQUhjWN3wbz/B
 IaRzDUFI+vG0GmEDFk0TxICS+rq2jXs8UMlpF9MvOrhCqWZ9+o1FnuxCoMn3v8hCN18i
 sqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fl/MMeX9ESkcyrM4QlaRTi/4w2GcnLMhUo9h5kXAm10=;
 b=gBquSwLrS/lv+IkLr8Ckut53sZjh7n2GOnQKo6dfOloukO1xLgs5dZb/IPpdRWjukJ
 mWbewrH6QdoLAWmm5JpGbVvQRdtscKVy+tFnftFJZf/91ikO2qbl/FSWwkKONnKiTCpu
 XhTGbQhGh25Kt34YS7ze5Q5ZCO18ML0IaPN9oa5OOF5OgXjCbO+1OFT4kbYnJ7ynwvt5
 NV4ulrITnLGGV3wwma30d/uSYE3h/rJ6oixdfrKvFNkKXbu0qQ1UPXa8BqQyztXZ7XY/
 tLB8umdMzazb/IOWZILLTgcRbowKoHFckF7/rXbPP6EcTulM97H8vNttrrwCCp8jwgXt
 LGqw==
X-Gm-Message-State: AOAM532KVVpN64C6xLANPvvtLVUS/m9PdhvPJ0BiJiLM3ghLCmkDHcVb
 uYLzW5gxEutzM7wEG7VJcRcAVcV8
X-Google-Smtp-Source: ABdhPJwIpkdQ9D2KKBqu+AH2LAXo5jYSqzzGPPO7Sh1/ByMDjf1UC4s4qRFL2WYBCCMLr5UusKGGPw==
X-Received: by 2002:a37:8883:: with SMTP id k125mr20861069qkd.14.1591036181618; 
 Mon, 01 Jun 2020 11:29:41 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:29:41 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 182/207] drm/amd/display: Add DCN3 DCCG
Date: Mon,  1 Jun 2020 14:29:01 -0400
Message-Id: <20200601182926.1267958-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182926.1267958-1-alexander.deucher@amd.com>
References: <20200601182926.1267958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Add programming of the DCCG (Display Controller Clock Generator)
block:

HW Blocks:

    +--------+       +--------+
    |  DIO   |       |  DCCG  |
    +--------+       +--------+

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  22 ++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c | 100 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h |  66 ++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 2205cb0204e7..06daf35bb587 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -76,18 +76,40 @@
 	type REFCLK_CLOCK_EN;\
 	type REFCLK_SRC_SEL;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+#define DCCG3_REG_FIELD_LIST(type) \
+	type PHYASYMCLK_FORCE_EN;\
+	type PHYASYMCLK_FORCE_SRC_SEL;\
+	type PHYBSYMCLK_FORCE_EN;\
+	type PHYBSYMCLK_FORCE_SRC_SEL;\
+	type PHYCSYMCLK_FORCE_EN;\
+	type PHYCSYMCLK_FORCE_SRC_SEL;
+#endif
+
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	DCCG3_REG_FIELD_LIST(uint8_t)
+#endif
 };
 
 struct dccg_mask {
 	DCCG_REG_FIELD_LIST(uint32_t)
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	DCCG3_REG_FIELD_LIST(uint32_t)
+#endif
 };
 
 struct dccg_registers {
 	uint32_t DPPCLK_DTO_CTRL;
 	uint32_t DPPCLK_DTO_PARAM[6];
 	uint32_t REFCLK_CNTL;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	uint32_t HDMICHARCLK_CLOCK_CNTL[6];
+	uint32_t PHYASYMCLK_CLOCK_CNTL;
+	uint32_t PHYBSYMCLK_CLOCK_CNTL;
+	uint32_t PHYCSYMCLK_CLOCK_CNTL;
+#endif
 };
 
 struct dcn_dccg {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c
new file mode 100644
index 000000000000..b822a13e40ce
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#include "reg_helper.h"
+#include "core_types.h"
+#include "dcn30_dccg.h"
+
+#define TO_DCN_DCCG(dccg)\
+	container_of(dccg, struct dcn_dccg, base)
+
+#define REG(reg) \
+	(dccg_dcn->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	dccg_dcn->dccg_shift->field_name, dccg_dcn->dccg_mask->field_name
+
+#define CTX \
+	dccg_dcn->base.ctx
+#define DC_LOGGER \
+	dccg->ctx->logger
+
+
+static const struct dccg_funcs dccg3_funcs = {
+	.update_dpp_dto = dccg2_update_dpp_dto,
+	.get_dccg_ref_freq = dccg2_get_dccg_ref_freq,
+	.dccg_init = dccg2_init
+};
+
+struct dccg *dccg3_create(
+	struct dc_context *ctx,
+	const struct dccg_registers *regs,
+	const struct dccg_shift *dccg_shift,
+	const struct dccg_mask *dccg_mask)
+{
+	struct dcn_dccg *dccg_dcn = kzalloc(sizeof(*dccg_dcn), GFP_KERNEL);
+	struct dccg *base;
+
+	if (dccg_dcn == NULL) {
+		BREAK_TO_DEBUGGER();
+		return NULL;
+	}
+
+	base = &dccg_dcn->base;
+	base->ctx = ctx;
+	base->funcs = &dccg3_funcs;
+
+	dccg_dcn->regs = regs;
+	dccg_dcn->dccg_shift = dccg_shift;
+	dccg_dcn->dccg_mask = dccg_mask;
+
+	return &dccg_dcn->base;
+}
+
+struct dccg *dccg30_create(
+	struct dc_context *ctx,
+	const struct dccg_registers *regs,
+	const struct dccg_shift *dccg_shift,
+	const struct dccg_mask *dccg_mask)
+{
+	struct dcn_dccg *dccg_dcn = kzalloc(sizeof(*dccg_dcn), GFP_KERNEL);
+	struct dccg *base;
+
+	if (dccg_dcn == NULL) {
+		BREAK_TO_DEBUGGER();
+		return NULL;
+	}
+
+	base = &dccg_dcn->base;
+	base->ctx = ctx;
+	base->funcs = &dccg3_funcs;
+
+	dccg_dcn->regs = regs;
+	dccg_dcn->dccg_shift = dccg_shift;
+	dccg_dcn->dccg_mask = dccg_mask;
+
+	return &dccg_dcn->base;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
new file mode 100644
index 000000000000..029dda13a464
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h
@@ -0,0 +1,66 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifndef __DCN30_DCCG_H__
+#define __DCN30_DCCG_H__
+
+#include "dcn20/dcn20_dccg.h"
+
+
+#define DCCG_REG_LIST_DCN3AG() \
+	DCCG_COMMON_REG_LIST_DCN_BASE(),\
+	SR(PHYASYMCLK_CLOCK_CNTL),\
+	SR(PHYBSYMCLK_CLOCK_CNTL),\
+	SR(PHYCSYMCLK_CLOCK_CNTL)
+
+
+#define DCCG_REG_LIST_DCN30() \
+	DCCG_REG_LIST_DCN2(),\
+	SR(PHYASYMCLK_CLOCK_CNTL),\
+	SR(PHYBSYMCLK_CLOCK_CNTL),\
+	SR(PHYCSYMCLK_CLOCK_CNTL)
+
+#define DCCG_MASK_SH_LIST_DCN3(mask_sh) \
+	DCCG_MASK_SH_LIST_DCN2(mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_SRC_SEL, mask_sh)
+
+struct dccg *dccg3_create(
+	struct dc_context *ctx,
+	const struct dccg_registers *regs,
+	const struct dccg_shift *dccg_shift,
+	const struct dccg_mask *dccg_mask);
+
+struct dccg *dccg30_create(
+	struct dc_context *ctx,
+	const struct dccg_registers *regs,
+	const struct dccg_shift *dccg_shift,
+	const struct dccg_mask *dccg_mask);
+
+#endif //__DCN30_DCCG_H__
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
