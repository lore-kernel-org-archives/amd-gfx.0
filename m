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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBEAC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A202077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAfQ8V4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A202077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D229E6E9E5;
	Mon,  1 Jun 2020 18:30:07 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721046E9E5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:06 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id b11so8525798qtt.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aN+7vL557gzNeVSdVlzAve/VPjgjQIdVNANia9EnNn0=;
 b=kAfQ8V4qgWTq+oc2Ji5uDSms5TDO8FD78RxjmrzU9o1O3WwruE0vF+hHhfv6nQIPKm
 yAlzLttMHURhSwoL0uPj18MMjVVw2nzdWORaabodeKOmB7j3ys35Z487r3+t9rEdj1Xb
 IXXkUOp1mpIWtMXguUAmmYRiynN7PC4/rVh3o3QdRdLoQAXuFSsOHrB4guTnuQ0g8rMo
 GK7U9U6lUAiKYlXo2JtGPawWA0QNONVWQ/YPxiLeI91r6SDCBeUrMybxmHZ7jjLByuJn
 iR4u/obC180XpaOI7UZcmsXC6sx+JCpFUaCIdagviHeRChIOCv/XLjdsYKVcYoXAjRYK
 U9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aN+7vL557gzNeVSdVlzAve/VPjgjQIdVNANia9EnNn0=;
 b=I6sNQplv5GucHSxh14tdO/NiMEJNaz41sNO9NK6fjk/1UOG2bpKdmw2pOJpUNhOgqJ
 ug1F0CAEg6qtRge5bcf2F+nOLUE/cNqaMZYHJHiNwV3NYy0z1hIuTeQNUbw2WIBh4gjQ
 L9iqQ8d7eUAsu4Sc7KiZj9Dx+7iwfmejKNmLrt/bI65DYkKQs/Bi0BodJRPzRxyOxoon
 8J5w0pQX3ZIyTCGAQASiH6Lm3AYW5IsqsoKYtJuAGg8qVDY8CuNmXU95rp97bxkJxBbp
 3MmpzRaKATV6FiDOJoEwGK/woQW1GZ3anqBXepcJoeWrG3MOkGLGf/4gRO39zU00nli6
 UUiQ==
X-Gm-Message-State: AOAM532kPAPGThK8TbEnoif8jr1qw10TD5Si3WhIQbvFhLUs+1kPt3rw
 8v3AiQk3pWqNq21CbpYWYINZGvhe
X-Google-Smtp-Source: ABdhPJyfBwxGDuZwBrduvU9sEIMqhJZv+rcpULJzAwTRhWIJ1U4ajeXjONQhjgnfIsdfdro4ZEKysw==
X-Received: by 2002:ac8:7413:: with SMTP id p19mr22103413qtq.387.1591036205162; 
 Mon, 01 Jun 2020 11:30:05 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 194/207] drm/amd/display: Add DCN3 DMUB
Date: Mon,  1 Jun 2020 14:29:13 -0400
Message-Id: <20200601182926.1267958-16-alexander.deucher@amd.com>
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

DMUB (Display Micro-Controller Unit)

Used to read/write regs

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   3 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |   3 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c | 184 ++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.h |  50 +++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  15 ++
 5 files changed, 255 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 0ea702eeddad..93d6ff80b248 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -88,6 +88,9 @@ enum dmub_asic {
 	DMUB_ASIC_NONE = 0,
 	DMUB_ASIC_DCN20,
 	DMUB_ASIC_DCN21,
+#ifdef CONFIG_DRM_AMD_DC_DCN3_0
+	DMUB_ASIC_DCN30,
+#endif
 	DMUB_ASIC_MAX,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index e08dfeea24b0..bb584f39cad0 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -21,6 +21,9 @@
 #
 
 DMUB = dmub_srv.o dmub_reg.o dmub_dcn20.o dmub_dcn21.o
+ifdef CONFIG_DRM_AMD_DC_DCN3_0
+DMUB += dmub_dcn30.o
+endif
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
new file mode 100644
index 000000000000..ba8d0bfb5522
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -0,0 +1,184 @@
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
+#include "../dmub_srv.h"
+#include "dmub_reg.h"
+#include "dmub_dcn20.h"
+
+#include "sienna_cichlid_ip_offset.h"
+#include "dcn/dcn_3_0_0_offset.h"
+#include "dcn/dcn_3_0_0_sh_mask.h"
+
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG##seg
+#define CTX dmub
+#define REGS dmub->regs
+
+/* Registers. */
+
+const struct dmub_srv_common_regs dmub_srv_dcn30_regs = {
+#define DMUB_SR(reg) REG_OFFSET(reg),
+	{ DMUB_COMMON_REGS() },
+#undef DMUB_SR
+
+#define DMUB_SF(reg, field) FD_MASK(reg, field),
+	{ DMUB_COMMON_FIELDS() },
+#undef DMUB_SF
+
+#define DMUB_SF(reg, field) FD_SHIFT(reg, field),
+	{ DMUB_COMMON_FIELDS() },
+#undef DMUB_SF
+};
+
+/* Shared functions. */
+
+static void dmub_dcn30_get_fb_base_offset(struct dmub_srv *dmub,
+					  uint64_t *fb_base,
+					  uint64_t *fb_offset)
+{
+	uint32_t tmp;
+
+	if (dmub->fb_base || dmub->fb_offset) {
+		*fb_base = dmub->fb_base;
+		*fb_offset = dmub->fb_offset;
+		return;
+	}
+
+	REG_GET(DCN_VM_FB_LOCATION_BASE, FB_BASE, &tmp);
+	*fb_base = (uint64_t)tmp << 24;
+
+	REG_GET(DCN_VM_FB_OFFSET, FB_OFFSET, &tmp);
+	*fb_offset = (uint64_t)tmp << 24;
+}
+
+static inline void dmub_dcn30_translate_addr(const union dmub_addr *addr_in,
+					     uint64_t fb_base,
+					     uint64_t fb_offset,
+					     union dmub_addr *addr_out)
+{
+	addr_out->quad_part = addr_in->quad_part - fb_base + fb_offset;
+}
+
+void dmub_dcn30_backdoor_load(struct dmub_srv *dmub,
+			      const struct dmub_window *cw0,
+			      const struct dmub_window *cw1)
+{
+	union dmub_addr offset;
+	uint64_t fb_base, fb_offset;
+
+	dmub_dcn30_get_fb_base_offset(dmub, &fb_base, &fb_offset);
+
+	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
+
+	/* MEM_CTNL read/write space doesn't exist. */
+
+	dmub_dcn30_translate_addr(&cw0->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW0_BASE_ADDRESS, cw0->region.base);
+	REG_SET_2(DMCUB_REGION3_CW0_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW0_TOP_ADDRESS, cw0->region.top,
+		  DMCUB_REGION3_CW0_ENABLE, 1);
+
+	dmub_dcn30_translate_addr(&cw1->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW1_BASE_ADDRESS, cw1->region.base);
+	REG_SET_2(DMCUB_REGION3_CW1_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW1_TOP_ADDRESS, cw1->region.top,
+		  DMCUB_REGION3_CW1_ENABLE, 1);
+
+	REG_UPDATE_2(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 0, DMCUB_MEM_UNIT_ID,
+		     0x20);
+}
+
+void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
+			      const struct dmub_window *cw2,
+			      const struct dmub_window *cw3,
+			      const struct dmub_window *cw4,
+			      const struct dmub_window *cw5,
+			      const struct dmub_window *cw6)
+{
+	union dmub_addr offset;
+
+	/* sienna_cichlid  has hardwired virtual addressing for CW2-CW7 */
+
+	offset = cw2->offset;
+
+	if (cw2->region.base != cw2->region.top) {
+		REG_WRITE(DMCUB_REGION3_CW2_OFFSET, offset.u.low_part);
+		REG_WRITE(DMCUB_REGION3_CW2_OFFSET_HIGH, offset.u.high_part);
+		REG_WRITE(DMCUB_REGION3_CW2_BASE_ADDRESS, cw2->region.base);
+		REG_SET_2(DMCUB_REGION3_CW2_TOP_ADDRESS, 0,
+			  DMCUB_REGION3_CW2_TOP_ADDRESS, cw2->region.top,
+			  DMCUB_REGION3_CW2_ENABLE, 1);
+	} else {
+		REG_WRITE(DMCUB_REGION3_CW2_OFFSET, 0);
+		REG_WRITE(DMCUB_REGION3_CW2_OFFSET_HIGH, 0);
+		REG_WRITE(DMCUB_REGION3_CW2_BASE_ADDRESS, 0);
+		REG_WRITE(DMCUB_REGION3_CW2_TOP_ADDRESS, 0);
+	}
+
+	offset = cw3->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW3_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW3_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW3_BASE_ADDRESS, cw3->region.base);
+	REG_SET_2(DMCUB_REGION3_CW3_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW3_TOP_ADDRESS, cw3->region.top,
+		  DMCUB_REGION3_CW3_ENABLE, 1);
+
+	offset = cw4->offset;
+
+	REG_WRITE(DMCUB_REGION4_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, offset.u.high_part);
+	REG_SET_2(DMCUB_REGION4_TOP_ADDRESS, 0, DMCUB_REGION4_TOP_ADDRESS,
+		  cw4->region.top - cw4->region.base - 1, DMCUB_REGION4_ENABLE,
+		  1);
+
+	offset = cw5->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW5_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW5_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW5_BASE_ADDRESS, cw5->region.base);
+	REG_SET_2(DMCUB_REGION3_CW5_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW5_TOP_ADDRESS, cw5->region.top,
+		  DMCUB_REGION3_CW5_ENABLE, 1);
+
+	offset = cw6->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW6_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW6_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW6_BASE_ADDRESS, cw6->region.base);
+	REG_SET_2(DMCUB_REGION3_CW6_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW6_TOP_ADDRESS, cw6->region.top,
+		  DMCUB_REGION3_CW6_ENABLE, 1);
+}
+
+bool dmub_dcn30_is_auto_load_done(struct dmub_srv *dmub)
+{
+	return (REG_READ(DMCUB_SCRATCH0) > 0);
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
new file mode 100644
index 000000000000..4d8f52b8f12c
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
@@ -0,0 +1,50 @@
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
+#ifndef _DMUB_DCN30_H_
+#define _DMUB_DCN30_H_
+
+#include "dmub_dcn20.h"
+
+/* Registers. */
+
+extern const struct dmub_srv_common_regs dmub_srv_dcn30_regs;
+
+/* Hardware functions. */
+
+void dmub_dcn30_backdoor_load(struct dmub_srv *dmub,
+			      const struct dmub_window *cw0,
+			      const struct dmub_window *cw1);
+
+void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
+			      const struct dmub_window *cw2,
+			      const struct dmub_window *cw3,
+			      const struct dmub_window *cw4,
+			      const struct dmub_window *cw5,
+			      const struct dmub_window *cw6);
+
+bool dmub_dcn30_is_auto_load_done(struct dmub_srv *dmub);
+
+#endif /* _DMUB_DCN30_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 6bc65801a598..937f6c3c9911 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -27,6 +27,9 @@
 #include "dmub_dcn20.h"
 #include "dmub_dcn21.h"
 #include "dmub_cmd.h"
+#ifdef CONFIG_DRM_AMD_DC_DCN3_0
+#include "dmub_dcn30.h"
+#endif
 #include "os_types.h"
 /*
  * Note: the DMUB service is standalone. No additional headers should be
@@ -133,6 +136,9 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 	switch (asic) {
 	case DMUB_ASIC_DCN20:
 	case DMUB_ASIC_DCN21:
+#ifdef CONFIG_DRM_AMD_DC_DCN3_0
+	case DMUB_ASIC_DCN30:
+#endif
 		dmub->regs = &dmub_srv_dcn20_regs;
 
 		funcs->reset = dmub_dcn20_reset;
@@ -154,6 +160,15 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			funcs->is_auto_load_done = dmub_dcn21_is_auto_load_done;
 			funcs->is_phy_init = dmub_dcn21_is_phy_init;
 		}
+#ifdef CONFIG_DRM_AMD_DC_DCN3_0
+		if (asic == DMUB_ASIC_DCN30) {
+			dmub->regs = &dmub_srv_dcn30_regs;
+
+			funcs->is_auto_load_done = dmub_dcn30_is_auto_load_done;
+			funcs->backdoor_load = dmub_dcn30_backdoor_load;
+			funcs->setup_windows = dmub_dcn30_setup_windows;
+		}
+#endif
 		break;
 
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
