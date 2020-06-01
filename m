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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001F6C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE7620776
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g39/quie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE7620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538D86E9E6;
	Mon,  1 Jun 2020 18:30:17 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9097C6E9DA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:14 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id v79so9996710qkb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nK1DUH8Z21gp7YxTDGDaTFWG6u09yLYqu5aPK63Stj0=;
 b=g39/quie3cZrbn2yX/7pMR/Nl9Pi9NjJ5NkQkpbR5BBh1CswCLCiPlXwbtkZkADRDD
 pU31phHyY3sxs1s4gA92Ikq59+5oTdKVL6NtWS7GM/SCHivfoHWwQv8HjDwsT2ycKZT/
 K8a5VJnzW9uOOcKlfOxEOhich3XK9wd2AzOvdByKQOqwnVI9ZimoIajbZnLbcbCdV2S3
 rgiVqbcErGaBGliuDUAf4I5+rIqomimn95Ujr2TVM3blDUw+SedrH2HyY3Gu/RKzkPtU
 yQoj9CfNu4tgliYX5NWIs/E6VckwF+1KUEjBS/etJfYQJXedCoaWGsciPAjC+kSXeLBb
 Z16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nK1DUH8Z21gp7YxTDGDaTFWG6u09yLYqu5aPK63Stj0=;
 b=cWpNLjjLLJMkJP0uSfHwALwp86gdw8h1ZAX7qYRiNKnLeTpxOxpTA5vUv5BDAr7dxe
 6tANykyW3DIL9vMdFgfebcaYCnk95j5NtKZLDWgELV5JFeKdLsC37Hi5zR1Z7S5E/kSX
 W96YaublDnr1iCelT49d75ThnyBto/PmgVLGU8WOcE7NrC+tE49TqDKIqxQyMBsprUKs
 bNURaz+hd5OTXGUAJIpkmp2M4R7q3sA0k9BacGNdQuquvOzxnNdojGKj8DHs3lqNLXZP
 zt3OuPk01L4Ed+ohoGsTDkW+FjGVbG3t+JGJOSLdIRhnA359qJd78MwjxLFyz5rqkMSj
 CTOA==
X-Gm-Message-State: AOAM530svGbG32h+K5OWrHmEleMJ3y9VNhL+2gWw1cyRGbAXzKh8UVbV
 I1uTplqmAtW/ZZfJ/1eGaStFTvEs
X-Google-Smtp-Source: ABdhPJxljD41EqX7xJdatM7NO8HiMn4t52OfAGIi5uU+y8kbWPnj6fm/E1GLHjvb5M6IX9wrK7itdA==
X-Received: by 2002:a37:414f:: with SMTP id o76mr20499047qka.375.1591036213268; 
 Mon, 01 Jun 2020 11:30:13 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:12 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 200/207] drm/amd/display: Add DCN3 VPG
Date: Mon,  1 Jun 2020 14:29:19 -0400
Message-Id: <20200601182926.1267958-22-alexander.deucher@amd.com>
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

Video Package generator.

used to prepare avi info, DP info etc

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c  | 194 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  | 133 ++++++++++++
 2 files changed, 327 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c
new file mode 100644
index 000000000000..9c0020c8a730
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c
@@ -0,0 +1,194 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ *  and/or sell copies of the Software, and to permit persons to whom the
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
+
+#include "dc_bios_types.h"
+#include "dcn30_vpg.h"
+#include "reg_helper.h"
+
+#define DC_LOGGER \
+		vpg3->base.ctx->logger
+
+#define REG(reg)\
+	(vpg3->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	vpg3->vpg_shift->field_name, vpg3->vpg_mask->field_name
+
+
+#define CTX \
+	vpg3->base.ctx
+
+
+static void vpg3_update_generic_info_packet(
+	struct vpg *vpg,
+	uint32_t packet_index,
+	const struct dc_info_packet *info_packet)
+{
+	struct dcn30_vpg *vpg3 = DCN30_VPG_FROM_VPG(vpg);
+	uint32_t i;
+
+	/* TODOFPGA Figure out a proper number for max_retries polling for lock
+	 * use 50 for now.
+	 */
+	uint32_t max_retries = 50;
+
+	if (packet_index > 14)
+		ASSERT(0);
+
+	/* poll dig_update_lock is not locked -> asic internal signal
+	 * assume otg master lock will unlock it
+	 */
+	/* REG_WAIT(AFMT_VBI_PACKET_CONTROL, AFMT_GENERIC_LOCK_STATUS,
+	 * 		0, 10, max_retries);
+	 */
+
+	/* TODO: Check if this is required */
+	/* check if HW reading GSP memory */
+	REG_WAIT(VPG_GENERIC_STATUS, VPG_GENERIC_CONFLICT_OCCURED,
+			0, 10, max_retries);
+
+	/* HW does is not reading GSP memory not reading too long ->
+	 * something wrong. clear GPS memory access and notify?
+	 * hw SW is writing to GSP memory
+	 */
+	REG_UPDATE(VPG_GENERIC_STATUS, VPG_GENERIC_CONFLICT_CLR, 1);
+
+	/* choose which generic packet to use */
+	REG_UPDATE(VPG_GENERIC_PACKET_ACCESS_CTRL,
+			VPG_GENERIC_DATA_INDEX, packet_index*9);
+
+	/* write generic packet header
+	 * (4th byte is for GENERIC0 only)
+	 */
+	REG_SET_4(VPG_GENERIC_PACKET_DATA, 0,
+			VPG_GENERIC_DATA_BYTE0, info_packet->hb0,
+			VPG_GENERIC_DATA_BYTE1, info_packet->hb1,
+			VPG_GENERIC_DATA_BYTE2, info_packet->hb2,
+			VPG_GENERIC_DATA_BYTE3, info_packet->hb3);
+
+	/* write generic packet contents
+	 * (we never use last 4 bytes)
+	 * there are 8 (0-7) mmDIG0_AFMT_GENERIC0_x registers
+	 */
+	{
+		const uint32_t *content =
+			(const uint32_t *) &info_packet->sb[0];
+
+		for (i = 0; i < 8; i++) {
+			REG_WRITE(VPG_GENERIC_PACKET_DATA, *content++);
+		}
+	}
+
+	/* atomically update double-buffered GENERIC0 registers in frame mode
+	 * (update at next block_update when block_update_lock == 0).
+	 */
+	switch (packet_index) {
+	case 0:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC0_FRAME_UPDATE, 1);
+		break;
+	case 1:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC1_FRAME_UPDATE, 1);
+		break;
+	case 2:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC2_FRAME_UPDATE, 1);
+		break;
+	case 3:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC3_FRAME_UPDATE, 1);
+		break;
+	case 4:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC4_FRAME_UPDATE, 1);
+		break;
+	case 5:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC5_FRAME_UPDATE, 1);
+		break;
+	case 6:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC6_FRAME_UPDATE, 1);
+		break;
+	case 7:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC7_FRAME_UPDATE, 1);
+		break;
+	case 8:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC8_FRAME_UPDATE, 1);
+		break;
+	case 9:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC9_FRAME_UPDATE, 1);
+		break;
+	case 10:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC10_FRAME_UPDATE, 1);
+		break;
+	case 11:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC11_FRAME_UPDATE, 1);
+		break;
+	case 12:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC12_FRAME_UPDATE, 1);
+		break;
+	case 13:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC13_FRAME_UPDATE, 1);
+		break;
+	case 14:
+		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
+				VPG_GENERIC14_FRAME_UPDATE, 1);
+		break;
+	default:
+		break;
+	}
+}
+
+static struct vpg_funcs dcn30_vpg_funcs = {
+	.update_generic_info_packet	= vpg3_update_generic_info_packet,
+};
+
+void vpg3_construct(struct dcn30_vpg *vpg3,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dcn30_vpg_registers *vpg_regs,
+	const struct dcn30_vpg_shift *vpg_shift,
+	const struct dcn30_vpg_mask *vpg_mask)
+{
+	vpg3->base.ctx = ctx;
+
+	vpg3->base.inst = inst;
+	vpg3->base.funcs = &dcn30_vpg_funcs;
+
+	vpg3->regs = vpg_regs;
+	vpg3->vpg_shift = vpg_shift;
+	vpg3->vpg_mask = vpg_mask;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
new file mode 100644
index 000000000000..0284092630f1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
@@ -0,0 +1,133 @@
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
+#ifndef __DAL_DCN30_VPG_H__
+#define __DAL_DCN30_VPG_H__
+
+
+#define DCN30_VPG_FROM_VPG(vpg)\
+	container_of(vpg, struct dcn30_vpg, base)
+
+#define VPG_DCN3_REG_LIST(id) \
+	SRI(VPG_GENERIC_STATUS, VPG, id), \
+	SRI(VPG_GENERIC_PACKET_ACCESS_CTRL, VPG, id), \
+	SRI(VPG_GENERIC_PACKET_DATA, VPG, id), \
+	SRI(VPG_GSP_FRAME_UPDATE_CTRL, VPG, id)
+
+struct dcn30_vpg_registers {
+	uint32_t VPG_GENERIC_STATUS;
+	uint32_t VPG_GENERIC_PACKET_ACCESS_CTRL;
+	uint32_t VPG_GENERIC_PACKET_DATA;
+	uint32_t VPG_GSP_FRAME_UPDATE_CTRL;
+};
+
+#define DCN3_VPG_MASK_SH_LIST(mask_sh)\
+	SE_SF(VPG0_VPG_GENERIC_STATUS, VPG_GENERIC_CONFLICT_OCCURED, mask_sh),\
+	SE_SF(VPG0_VPG_GENERIC_STATUS, VPG_GENERIC_CONFLICT_CLR, mask_sh),\
+	SE_SF(VPG0_VPG_GENERIC_PACKET_ACCESS_CTRL, VPG_GENERIC_DATA_INDEX, mask_sh),\
+	SE_SF(VPG0_VPG_GENERIC_PACKET_DATA, VPG_GENERIC_DATA_BYTE0, mask_sh),\
+	SE_SF(VPG0_VPG_GENERIC_PACKET_DATA, VPG_GENERIC_DATA_BYTE1, mask_sh),\
+	SE_SF(VPG0_VPG_GENERIC_PACKET_DATA, VPG_GENERIC_DATA_BYTE2, mask_sh),\
+	SE_SF(VPG0_VPG_GENERIC_PACKET_DATA, VPG_GENERIC_DATA_BYTE3, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC0_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC1_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC2_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC3_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC4_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC5_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC6_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC7_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC8_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC9_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC10_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC11_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC12_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC13_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC14_FRAME_UPDATE, mask_sh)
+
+#define VPG_DCN3_REG_FIELD_LIST(type) \
+	type VPG_GENERIC_CONFLICT_OCCURED;\
+	type VPG_GENERIC_CONFLICT_CLR;\
+	type VPG_GENERIC_DATA_INDEX;\
+	type VPG_GENERIC_DATA_BYTE0;\
+	type VPG_GENERIC_DATA_BYTE1;\
+	type VPG_GENERIC_DATA_BYTE2;\
+	type VPG_GENERIC_DATA_BYTE3;\
+	type VPG_GENERIC0_FRAME_UPDATE;\
+	type VPG_GENERIC1_FRAME_UPDATE;\
+	type VPG_GENERIC2_FRAME_UPDATE;\
+	type VPG_GENERIC3_FRAME_UPDATE;\
+	type VPG_GENERIC4_FRAME_UPDATE;\
+	type VPG_GENERIC5_FRAME_UPDATE;\
+	type VPG_GENERIC6_FRAME_UPDATE;\
+	type VPG_GENERIC7_FRAME_UPDATE;\
+	type VPG_GENERIC8_FRAME_UPDATE;\
+	type VPG_GENERIC9_FRAME_UPDATE;\
+	type VPG_GENERIC10_FRAME_UPDATE;\
+	type VPG_GENERIC11_FRAME_UPDATE;\
+	type VPG_GENERIC12_FRAME_UPDATE;\
+	type VPG_GENERIC13_FRAME_UPDATE;\
+	type VPG_GENERIC14_FRAME_UPDATE
+
+
+struct dcn30_vpg_shift {
+	VPG_DCN3_REG_FIELD_LIST(uint8_t);
+};
+
+struct dcn30_vpg_mask {
+	VPG_DCN3_REG_FIELD_LIST(uint32_t);
+};
+
+struct vpg;
+
+struct vpg_funcs {
+	void (*update_generic_info_packet)(
+		struct vpg *vpg,
+		uint32_t packet_index,
+		const struct dc_info_packet *info_packet);
+};
+
+struct vpg {
+	const struct vpg_funcs *funcs;
+	struct dc_context *ctx;
+	int inst;
+};
+
+struct dcn30_vpg {
+	struct vpg base;
+	const struct dcn30_vpg_registers *regs;
+	const struct dcn30_vpg_shift *vpg_shift;
+	const struct dcn30_vpg_mask *vpg_mask;
+};
+
+void vpg3_construct(struct dcn30_vpg *vpg3,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dcn30_vpg_registers *vpg_regs,
+	const struct dcn30_vpg_shift *vpg_shift,
+	const struct dcn30_vpg_mask *vpg_mask);
+
+
+#endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
