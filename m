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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED518C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDCC920776
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtn1aics"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCC920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9FA6E9E2;
	Mon,  1 Jun 2020 18:30:05 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CA36E9DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:03 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id u17so7392012qtq.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E0t8UXJTkUSqNk9RGJiDXxcnUbBUy+dcsvq17Hercgs=;
 b=Gtn1aicshWWDF6Zw+gIUOrdJ8qwuQDsofaGqbUD5p0c4M2avJUjkzIhSnOvRVXBxVK
 jCRPyUyt64XJjdZEmnMsBoPyLZwwq2KvUE6kWsOt420ocUDa+McZqRqgRczTs2i/xkM7
 U94eUWC64YEqQsf19srRrA+flGaWHfqx9j7mR567lDfAAlkw8MNG0nv1EjjcsDBHM3VE
 Ica7UVZTdkowOcDL/Gd/amUu7nIDCJU7QgZ4+RuMITyBhteQnVo75+sZT+XUsuANKmvm
 fvTJUF4oTxhfc97nzNVXV/Ipmz4i3l0BOGFew5hgAoseWfk/mcxU4ki/xFuVcNSVxlD2
 UaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E0t8UXJTkUSqNk9RGJiDXxcnUbBUy+dcsvq17Hercgs=;
 b=XVvCvIjx9X/ui7/6bdo9e4B7YYUX3+2oqysOuwRHrE04vWKxGvMCQLM+oWOUp3BA5n
 4lXTXsCwUI/srZ0hgVJiU0JWPw2HS59cHXjSgbiYNOQvBvaGQJohKswz8ji5jlWmoLUh
 nLE22K4DTB7F9W9UAknwE76sZKR8PTFjnegxzmCXsIwzVhPbAWDKezi5ndFLnewlIbDx
 A0J18BDrDB5c6R432VJlIvBLhQhW6BGiqWrVjVxr/to/C1dzEFT73DVo7QCIZy7bdZql
 +hJcM7r5FDp6gVKWfYoOTO0sM+dlUd5C+pN9yx8ZMCsSEXly/VflYyTq/u8544u5caam
 2Z4w==
X-Gm-Message-State: AOAM533t2zsqFmMJeVj3qObc/tVoDFiGOJl7jLe9PiLRB9U+zqFsRyEU
 b9MHaP4wMO27HcGXOugyAD4FNu/F
X-Google-Smtp-Source: ABdhPJxNMvF77UK4/QYQSf+eJd7dPd53N7lBToD3pO5EgjrKbTGqSAyBIHd45WC4oI4gezNMYJrl7g==
X-Received: by 2002:ac8:2a55:: with SMTP id l21mr23319460qtl.151.1591036202527; 
 Mon, 01 Jun 2020 11:30:02 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:02 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 192/207] drm/amd/display: Add DCN3 IRQ
Date: Mon,  1 Jun 2020 14:29:11 -0400
Message-Id: <20200601182926.1267958-14-alexander.deucher@amd.com>
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

Add IWQ services for DCN3,

This allows us to create/init and manage irqs for DCN3

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |  10 +
 .../display/dc/irq/dcn30/irq_service_dcn30.c  | 384 ++++++++++++++++++
 .../display/dc/irq/dcn30/irq_service_dcn30.h  |  37 ++
 3 files changed, 431 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.h

diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index 0f682ac53bb2..3352b79fb1cb 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -83,3 +83,13 @@ AMD_DAL_IRQ_DCN21= $(addprefix $(AMDDALPATH)/dc/irq/dcn21/,$(IRQ_DCN21))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN21)
 endif
+###############################################################################
+# DCN 30
+###############################################################################
+ifdef CONFIG_DRM_AMD_DC_DCN3_0
+IRQ_DCN3 = irq_service_dcn30.o
+
+AMD_DAL_IRQ_DCN3 = $(addprefix $(AMDDALPATH)/dc/irq/dcn30/,$(IRQ_DCN3))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN3)
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
new file mode 100644
index 000000000000..dd4d7a1dc3b6
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -0,0 +1,384 @@
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
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
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
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+
+#include "dm_services.h"
+
+#include "include/logger_interface.h"
+
+#include "../dce110/irq_service_dce110.h"
+
+
+#include "sienna_cichlid_ip_offset.h"
+#include "dcn/dcn_3_0_0_offset.h"
+#include "dcn/dcn_3_0_0_sh_mask.h"
+
+#include "nbio/nbio_7_4_offset.h"
+
+#include "dcn/dpcs_3_0_0_offset.h"
+#include "dcn/dpcs_3_0_0_sh_mask.h"
+
+#include "mmhub/mmhub_2_0_0_offset.h"
+#include "mmhub/mmhub_2_0_0_sh_mask.h"
+
+#include "irq_service_dcn30.h"
+
+#include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
+
+enum dc_irq_source to_dal_irq_source_dcn30(
+		struct irq_service *irq_service,
+		uint32_t src_id,
+		uint32_t ext_id)
+{
+	switch (src_id) {
+	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK1;
+	case DCN_1_0__SRCID__DC_D2_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK2;
+	case DCN_1_0__SRCID__DC_D3_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK3;
+	case DCN_1_0__SRCID__DC_D4_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK4;
+	case DCN_1_0__SRCID__DC_D5_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK5;
+	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
+		return DC_IRQ_SOURCE_VBLANK6;
+	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP1;
+	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP2;
+	case DCN_1_0__SRCID__HUBP2_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP3;
+	case DCN_1_0__SRCID__HUBP3_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP4;
+	case DCN_1_0__SRCID__HUBP4_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP5;
+	case DCN_1_0__SRCID__HUBP5_FLIP_INTERRUPT:
+		return DC_IRQ_SOURCE_PFLIP6;
+	case DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE1;
+	case DCN_1_0__SRCID__OTG1_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE2;
+	case DCN_1_0__SRCID__OTG2_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE3;
+	case DCN_1_0__SRCID__OTG3_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE4;
+	case DCN_1_0__SRCID__OTG4_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE5;
+	case DCN_1_0__SRCID__OTG5_IHC_V_UPDATE_NO_LOCK_INTERRUPT:
+		return DC_IRQ_SOURCE_VUPDATE6;
+
+	case DCN_1_0__SRCID__DC_HPD1_INT:
+		/* generic src_id for all HPD and HPDRX interrupts */
+		switch (ext_id) {
+		case DCN_1_0__CTXID__DC_HPD1_INT:
+			return DC_IRQ_SOURCE_HPD1;
+		case DCN_1_0__CTXID__DC_HPD2_INT:
+			return DC_IRQ_SOURCE_HPD2;
+		case DCN_1_0__CTXID__DC_HPD3_INT:
+			return DC_IRQ_SOURCE_HPD3;
+		case DCN_1_0__CTXID__DC_HPD4_INT:
+			return DC_IRQ_SOURCE_HPD4;
+		case DCN_1_0__CTXID__DC_HPD5_INT:
+			return DC_IRQ_SOURCE_HPD5;
+		case DCN_1_0__CTXID__DC_HPD6_INT:
+			return DC_IRQ_SOURCE_HPD6;
+		case DCN_1_0__CTXID__DC_HPD1_RX_INT:
+			return DC_IRQ_SOURCE_HPD1RX;
+		case DCN_1_0__CTXID__DC_HPD2_RX_INT:
+			return DC_IRQ_SOURCE_HPD2RX;
+		case DCN_1_0__CTXID__DC_HPD3_RX_INT:
+			return DC_IRQ_SOURCE_HPD3RX;
+		case DCN_1_0__CTXID__DC_HPD4_RX_INT:
+			return DC_IRQ_SOURCE_HPD4RX;
+		case DCN_1_0__CTXID__DC_HPD5_RX_INT:
+			return DC_IRQ_SOURCE_HPD5RX;
+		case DCN_1_0__CTXID__DC_HPD6_RX_INT:
+			return DC_IRQ_SOURCE_HPD6RX;
+		default:
+			return DC_IRQ_SOURCE_INVALID;
+		}
+		break;
+
+	default:
+		return DC_IRQ_SOURCE_INVALID;
+	}
+}
+
+static bool hpd_ack(
+	struct irq_service *irq_service,
+	const struct irq_source_info *info)
+{
+	uint32_t addr = info->status_reg;
+	uint32_t value = dm_read_reg(irq_service->ctx, addr);
+	uint32_t current_status =
+		get_reg_field_value(
+			value,
+			HPD0_DC_HPD_INT_STATUS,
+			DC_HPD_SENSE_DELAYED);
+
+	dal_irq_service_ack_generic(irq_service, info);
+
+	value = dm_read_reg(irq_service->ctx, info->enable_reg);
+
+	set_reg_field_value(
+		value,
+		current_status ? 0 : 1,
+		HPD0_DC_HPD_INT_CONTROL,
+		DC_HPD_INT_POLARITY);
+
+	dm_write_reg(irq_service->ctx, info->enable_reg, value);
+
+	return true;
+}
+
+static const struct irq_source_info_funcs hpd_irq_info_funcs = {
+	.set = NULL,
+	.ack = hpd_ack
+};
+
+static const struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static const struct irq_source_info_funcs pflip_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static const struct irq_source_info_funcs vblank_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+#undef BASE_INNER
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
+
+/* compile time expand base address. */
+#define BASE(seg) \
+	BASE_INNER(seg)
+
+
+#define SRI(reg_name, block, id)\
+	BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+			mm ## block ## id ## _ ## reg_name
+
+
+#define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\
+	.enable_reg = SRI(reg1, block, reg_num),\
+	.enable_mask = \
+		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
+	.enable_value = {\
+		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
+		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+	},\
+	.ack_reg = SRI(reg2, block, reg_num),\
+	.ack_mask = \
+		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
+	.ack_value = \
+		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK \
+
+
+
+#define hpd_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_HPD1 + reg_num] = {\
+		IRQ_REG_ENTRY(HPD, reg_num,\
+			DC_HPD_INT_CONTROL, DC_HPD_INT_EN,\
+			DC_HPD_INT_CONTROL, DC_HPD_INT_ACK),\
+		.status_reg = SRI(DC_HPD_INT_STATUS, HPD, reg_num),\
+		.funcs = &hpd_irq_info_funcs\
+	}
+
+#define hpd_rx_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_HPD1RX + reg_num] = {\
+		IRQ_REG_ENTRY(HPD, reg_num,\
+			DC_HPD_INT_CONTROL, DC_HPD_RX_INT_EN,\
+			DC_HPD_INT_CONTROL, DC_HPD_RX_INT_ACK),\
+		.status_reg = SRI(DC_HPD_INT_STATUS, HPD, reg_num),\
+		.funcs = &hpd_rx_irq_info_funcs\
+	}
+#define pflip_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_PFLIP1 + reg_num] = {\
+		IRQ_REG_ENTRY(HUBPREQ, reg_num,\
+			DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_INT_MASK,\
+			DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_CLEAR),\
+		.funcs = &pflip_irq_info_funcs\
+	}
+
+#define vupdate_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_EVENT_CLEAR),\
+		.funcs = &vblank_irq_info_funcs\
+	}
+
+#define vblank_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_VBLANK1 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_EVENT_CLEAR),\
+		.funcs = &vblank_irq_info_funcs\
+	}
+
+#define dummy_irq_entry() \
+	{\
+		.funcs = &dummy_irq_info_funcs\
+	}
+
+#define i2c_int_entry(reg_num) \
+	[DC_IRQ_SOURCE_I2C_DDC ## reg_num] = dummy_irq_entry()
+
+#define dp_sink_int_entry(reg_num) \
+	[DC_IRQ_SOURCE_DPSINK ## reg_num] = dummy_irq_entry()
+
+#define gpio_pad_int_entry(reg_num) \
+	[DC_IRQ_SOURCE_GPIOPAD ## reg_num] = dummy_irq_entry()
+
+#define dc_underflow_int_entry(reg_num) \
+	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
+
+static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+	.set = dal_irq_service_dummy_set,
+	.ack = dal_irq_service_dummy_ack
+};
+
+static const struct irq_source_info
+irq_source_info_dcn30[DAL_IRQ_SOURCES_NUMBER] = {
+	[DC_IRQ_SOURCE_INVALID] = dummy_irq_entry(),
+	hpd_int_entry(0),
+	hpd_int_entry(1),
+	hpd_int_entry(2),
+	hpd_int_entry(3),
+	hpd_int_entry(4),
+	hpd_int_entry(5),
+	hpd_rx_int_entry(0),
+	hpd_rx_int_entry(1),
+	hpd_rx_int_entry(2),
+	hpd_rx_int_entry(3),
+	hpd_rx_int_entry(4),
+	hpd_rx_int_entry(5),
+	i2c_int_entry(1),
+	i2c_int_entry(2),
+	i2c_int_entry(3),
+	i2c_int_entry(4),
+	i2c_int_entry(5),
+	i2c_int_entry(6),
+	dp_sink_int_entry(1),
+	dp_sink_int_entry(2),
+	dp_sink_int_entry(3),
+	dp_sink_int_entry(4),
+	dp_sink_int_entry(5),
+	dp_sink_int_entry(6),
+	[DC_IRQ_SOURCE_TIMER] = dummy_irq_entry(),
+	pflip_int_entry(0),
+	pflip_int_entry(1),
+	pflip_int_entry(2),
+	pflip_int_entry(3),
+	[DC_IRQ_SOURCE_PFLIP5] = dummy_irq_entry(),
+	[DC_IRQ_SOURCE_PFLIP6] = dummy_irq_entry(),
+	[DC_IRQ_SOURCE_PFLIP_UNDERLAY0] = dummy_irq_entry(),
+	gpio_pad_int_entry(0),
+	gpio_pad_int_entry(1),
+	gpio_pad_int_entry(2),
+	gpio_pad_int_entry(3),
+	gpio_pad_int_entry(4),
+	gpio_pad_int_entry(5),
+	gpio_pad_int_entry(6),
+	gpio_pad_int_entry(7),
+	gpio_pad_int_entry(8),
+	gpio_pad_int_entry(9),
+	gpio_pad_int_entry(10),
+	gpio_pad_int_entry(11),
+	gpio_pad_int_entry(12),
+	gpio_pad_int_entry(13),
+	gpio_pad_int_entry(14),
+	gpio_pad_int_entry(15),
+	gpio_pad_int_entry(16),
+	gpio_pad_int_entry(17),
+	gpio_pad_int_entry(18),
+	gpio_pad_int_entry(19),
+	gpio_pad_int_entry(20),
+	gpio_pad_int_entry(21),
+	gpio_pad_int_entry(22),
+	gpio_pad_int_entry(23),
+	gpio_pad_int_entry(24),
+	gpio_pad_int_entry(25),
+	gpio_pad_int_entry(26),
+	gpio_pad_int_entry(27),
+	gpio_pad_int_entry(28),
+	gpio_pad_int_entry(29),
+	gpio_pad_int_entry(30),
+	dc_underflow_int_entry(1),
+	dc_underflow_int_entry(2),
+	dc_underflow_int_entry(3),
+	dc_underflow_int_entry(4),
+	dc_underflow_int_entry(5),
+	dc_underflow_int_entry(6),
+	[DC_IRQ_SOURCE_DMCU_SCP] = dummy_irq_entry(),
+	[DC_IRQ_SOURCE_VBIOS_SW] = dummy_irq_entry(),
+	vupdate_int_entry(0),
+	vupdate_int_entry(1),
+	vupdate_int_entry(2),
+	vupdate_int_entry(3),
+	vupdate_int_entry(4),
+	vupdate_int_entry(5),
+	vblank_int_entry(0),
+	vblank_int_entry(1),
+	vblank_int_entry(2),
+	vblank_int_entry(3),
+	vblank_int_entry(4),
+	vblank_int_entry(5),
+};
+
+static const struct irq_service_funcs irq_service_funcs_dcn30 = {
+		.to_dal_irq_source = to_dal_irq_source_dcn30
+};
+
+static void dcn30_irq_construct(
+	struct irq_service *irq_service,
+	struct irq_service_init_data *init_data)
+{
+	dal_irq_service_construct(irq_service, init_data);
+
+	irq_service->info = irq_source_info_dcn30;
+	irq_service->funcs = &irq_service_funcs_dcn30;
+}
+
+struct irq_service *dal_irq_service_dcn30_create(
+	struct irq_service_init_data *init_data)
+{
+	struct irq_service *irq_service = kzalloc(sizeof(*irq_service),
+						  GFP_KERNEL);
+
+	if (!irq_service)
+		return NULL;
+
+	dcn30_irq_construct(irq_service, init_data);
+	return irq_service;
+}
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.h b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.h
new file mode 100644
index 000000000000..5a00acaa1a18
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.h
@@ -0,0 +1,37 @@
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
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+
+#ifndef __DAL_IRQ_SERVICE_DCN30_H__
+#define __DAL_IRQ_SERVICE_DCN30_H__
+
+#include "../irq_service.h"
+
+struct irq_service *dal_irq_service_dcn30_create(
+	struct irq_service_init_data *init_data);
+
+#endif /* __DAL_IRQ_SERVICE_DCN30_H__ */
+#endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
