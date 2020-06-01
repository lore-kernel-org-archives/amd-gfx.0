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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E60C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E252920776
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX5C6G3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E252920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B156E9DC;
	Mon,  1 Jun 2020 18:30:06 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FB06E9DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:05 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id b11so8525735qtt.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=koo/ETFX5vxkH2xei6s4cfk5HjPgGSWjcfiWchDO6gs=;
 b=aX5C6G3HHfOgWdW2rzeuLCdUKBohc8xBRm0yXykqqLwndyZ83Q9JZLPv53BfaDxrxj
 LkqxaLG1g/PHuMuJP2VglHs/vJRcplzdF50vghWGmTHsN2uGNaJxbGV4i6d5sW2HA+6L
 MDQ9R6LjvytU4xOgI9ilYGFO3FGgSBhAp0CVMZd15G1aKUnQjbOHCjbfwj3eyvUjJ7Vu
 Uf3HaPvZIvDjKZMQpfzLZAYcv9FUmwIRIsmHGrMX1gy2dWATfH6jqPpcdVHCDhN3gbKR
 4dkhvVxhCYMy7+xE6qL2BAf9AvtePODhlgj21U7a3Ui5nl0gL4B5lW8tjnhWXLsNvNqN
 wv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=koo/ETFX5vxkH2xei6s4cfk5HjPgGSWjcfiWchDO6gs=;
 b=PAJNWZPN77/v1vesWg39vBoWp3g4VOxTgc8nfr2U9ct3e9k1SJazwqc/JbZFD1poA3
 +1sfzny+gVL+Zzytb4xS1d+TpeH0mEoZiMNAdqATomLC2Qs6WjYyPAhtmUNRg1UQrMXi
 lflY8WlG4nm0Tx5iMDilT46qmECuHY2c0T62BOS9siYopcX+zcFwzb1uiPyRmt+DZTui
 dyE07aOvHq3MAKdq1HQKlDGffNLX+BazAgux3LvzNDDW6cyrYPXphGdta6OqMp+OKLc7
 ryvpDp6mNrZ6u1ElYD1qm+PCsGRB+Fl508gcYjt607StDqyoHpULn3GXM81lkjMSryfv
 TaAQ==
X-Gm-Message-State: AOAM531Avm5ggVEXIWlYe+PrbwLpj0g1o13JRxPCUPoMgIeTZCNhCXnO
 ULr+wWAl2tDKnsaxcCa8Ib9jUwuT
X-Google-Smtp-Source: ABdhPJw39ueeKMQfk4pnw6XArru6HUjLiLzvEyJqkt0G7wGoSXYmWhjGy0zGph1yBvv9v1SPLrmSSQ==
X-Received: by 2002:ac8:2a3a:: with SMTP id k55mr23076818qtk.294.1591036203665; 
 Mon, 01 Jun 2020 11:30:03 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:03 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 193/207] drm/amd/display: Add DCN3 GPIO
Date: Mon,  1 Jun 2020 14:29:12 -0400
Message-Id: <20200601182926.1267958-15-alexander.deucher@amd.com>
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

Add support to program GPIO HW block

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |  10 +
 .../display/dc/gpio/dcn30/hw_factory_dcn30.c  | 257 ++++++++++++
 .../display/dc/gpio/dcn30/hw_factory_dcn30.h  |  33 ++
 .../dc/gpio/dcn30/hw_translate_dcn30.c        | 387 ++++++++++++++++++
 .../dc/gpio/dcn30/hw_translate_dcn30.h        |  35 ++
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   9 +-
 .../drm/amd/display/dc/gpio/hw_translate.c    |   8 +
 7 files changed, 738 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.h

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
index 202baa210cc8..0f2f4508e564 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
@@ -87,6 +87,16 @@ AMD_DAL_GPIO_DCN21 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn21/,$(GPIO_DCN21))
 AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN21)
 endif
 ###############################################################################
+# DCN 3
+###############################################################################
+ifdef CONFIG_DRM_AMD_DC_DCN3_0
+GPIO_DCN30 = hw_translate_dcn30.o hw_factory_dcn30.o
+
+AMD_DAL_GPIO_DCN30 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn30/,$(GPIO_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN30)
+endif
+###############################################################################
 # Diagnostics on FPGA
 ###############################################################################
 GPIO_DIAG_FPGA = hw_translate_diag.o hw_factory_diag.o
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
new file mode 100644
index 000000000000..7e7fb6572107
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
@@ -0,0 +1,257 @@
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
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+#include "dm_services.h"
+#include "include/gpio_types.h"
+#include "../hw_factory.h"
+
+
+#include "../hw_gpio.h"
+#include "../hw_ddc.h"
+#include "../hw_hpd.h"
+#include "../hw_generic.h"
+
+#include "hw_factory_dcn30.h"
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
+#include "reg_helper.h"
+#include "../hpd_regs.h"
+/* begin *********************
+ * macros to expend register list macro defined in HW object header file */
+
+/* DCN */
+#define block HPD
+#define reg_num 0
+
+#undef BASE_INNER
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
+
+#define BASE(seg) BASE_INNER(seg)
+
+
+
+#define REG(reg_name)\
+		BASE(mm ## reg_name ## _BASE_IDX) + mm ## reg_name
+
+#define SF_HPD(reg_name, field_name, post_fix)\
+	.field_name = HPD0_ ## reg_name ## __ ## field_name ## post_fix
+
+#define REGI(reg_name, block, id)\
+	BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+				mm ## block ## id ## _ ## reg_name
+
+#define SF(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+/* macros to expend register list macro defined in HW object header file
+ * end *********************/
+
+
+
+#define hpd_regs(id) \
+{\
+	HPD_REG_LIST(id)\
+}
+
+static const struct hpd_registers hpd_regs[] = {
+	hpd_regs(0),
+	hpd_regs(1),
+	hpd_regs(2),
+	hpd_regs(3),
+	hpd_regs(4),
+	hpd_regs(5),
+};
+
+static const struct hpd_sh_mask hpd_shift = {
+		HPD_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct hpd_sh_mask hpd_mask = {
+		HPD_MASK_SH_LIST(_MASK)
+};
+
+#include "../ddc_regs.h"
+
+ /* set field name */
+#define SF_DDC(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+static const struct ddc_registers ddc_data_regs_dcn[] = {
+	ddc_data_regs_dcn2(1),
+	ddc_data_regs_dcn2(2),
+	ddc_data_regs_dcn2(3),
+	ddc_data_regs_dcn2(4),
+	ddc_data_regs_dcn2(5),
+	ddc_data_regs_dcn2(6),
+};
+
+static const struct ddc_registers ddc_clk_regs_dcn[] = {
+	ddc_clk_regs_dcn2(1),
+	ddc_clk_regs_dcn2(2),
+	ddc_clk_regs_dcn2(3),
+	ddc_clk_regs_dcn2(4),
+	ddc_clk_regs_dcn2(5),
+	ddc_clk_regs_dcn2(6),
+};
+
+static const struct ddc_sh_mask ddc_shift[] = {
+	DDC_MASK_SH_LIST_DCN2(__SHIFT, 1),
+	DDC_MASK_SH_LIST_DCN2(__SHIFT, 2),
+	DDC_MASK_SH_LIST_DCN2(__SHIFT, 3),
+	DDC_MASK_SH_LIST_DCN2(__SHIFT, 4),
+	DDC_MASK_SH_LIST_DCN2(__SHIFT, 5),
+	DDC_MASK_SH_LIST_DCN2(__SHIFT, 6)
+};
+
+static const struct ddc_sh_mask ddc_mask[] = {
+	DDC_MASK_SH_LIST_DCN2(_MASK, 1),
+	DDC_MASK_SH_LIST_DCN2(_MASK, 2),
+	DDC_MASK_SH_LIST_DCN2(_MASK, 3),
+	DDC_MASK_SH_LIST_DCN2(_MASK, 4),
+	DDC_MASK_SH_LIST_DCN2(_MASK, 5),
+	DDC_MASK_SH_LIST_DCN2(_MASK, 6)
+};
+
+#include "../generic_regs.h"
+
+/* set field name */
+#define SF_GENERIC(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+#define generic_regs(id) \
+{\
+	GENERIC_REG_LIST(id)\
+}
+
+static const struct generic_registers generic_regs[] = {
+	generic_regs(A),
+	generic_regs(B),
+};
+
+static const struct generic_sh_mask generic_shift[] = {
+	GENERIC_MASK_SH_LIST(__SHIFT, A),
+	GENERIC_MASK_SH_LIST(__SHIFT, B),
+};
+
+static const struct generic_sh_mask generic_mask[] = {
+	GENERIC_MASK_SH_LIST(_MASK, A),
+	GENERIC_MASK_SH_LIST(_MASK, B),
+};
+
+static void define_generic_registers(struct hw_gpio_pin *pin, uint32_t en)
+{
+	struct hw_generic *generic = HW_GENERIC_FROM_BASE(pin);
+
+	generic->regs = &generic_regs[en];
+	generic->shifts = &generic_shift[en];
+	generic->masks = &generic_mask[en];
+	generic->base.regs = &generic_regs[en].gpio;
+}
+
+static void define_ddc_registers(
+		struct hw_gpio_pin *pin,
+		uint32_t en)
+{
+	struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
+
+	switch (pin->id) {
+	case GPIO_ID_DDC_DATA:
+		ddc->regs = &ddc_data_regs_dcn[en];
+		ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
+		break;
+	case GPIO_ID_DDC_CLOCK:
+		ddc->regs = &ddc_clk_regs_dcn[en];
+		ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
+		break;
+	default:
+		ASSERT_CRITICAL(false);
+		return;
+	}
+
+	ddc->shifts = &ddc_shift[en];
+	ddc->masks = &ddc_mask[en];
+
+}
+
+static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
+{
+	struct hw_hpd *hpd = HW_HPD_FROM_BASE(pin);
+
+	hpd->regs = &hpd_regs[en];
+	hpd->shifts = &hpd_shift;
+	hpd->masks = &hpd_mask;
+	hpd->base.regs = &hpd_regs[en].gpio;
+}
+
+
+/* fucntion table */
+static const struct hw_factory_funcs funcs = {
+	.init_ddc_data = dal_hw_ddc_init,
+	.init_generic = dal_hw_generic_init,
+	.init_hpd = dal_hw_hpd_init,
+	.get_ddc_pin = dal_hw_ddc_get_pin,
+	.get_hpd_pin = dal_hw_hpd_get_pin,
+	.get_generic_pin = dal_hw_generic_get_pin,
+	.define_hpd_registers = define_hpd_registers,
+	.define_ddc_registers = define_ddc_registers,
+	.define_generic_registers = define_generic_registers
+};
+/*
+ * dal_hw_factory_dcn10_init
+ *
+ * @brief
+ * Initialize HW factory function pointers and pin info
+ *
+ * @param
+ * struct hw_factory *factory - [out] struct of function pointers
+ */
+void dal_hw_factory_dcn30_init(struct hw_factory *factory)
+{
+	/*TODO check ASIC CAPs*/
+	factory->number_of_pins[GPIO_ID_DDC_DATA] = 8;
+	factory->number_of_pins[GPIO_ID_DDC_CLOCK] = 8;
+	factory->number_of_pins[GPIO_ID_GENERIC] = 4;
+	factory->number_of_pins[GPIO_ID_HPD] = 6;
+	factory->number_of_pins[GPIO_ID_GPIO_PAD] = 28;
+	factory->number_of_pins[GPIO_ID_VIP_PAD] = 0;
+	factory->number_of_pins[GPIO_ID_SYNC] = 0;
+	factory->number_of_pins[GPIO_ID_GSL] = 0;/*add this*/
+
+	factory->funcs = &funcs;
+}
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.h b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.h
new file mode 100644
index 000000000000..7ad15f5aa95f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.h
@@ -0,0 +1,33 @@
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
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+#ifndef __DAL_HW_FACTORY_DCN30_H__
+#define __DAL_HW_FACTORY_DCN30_H__
+
+/* Initialize HW factory function pointers and pin info */
+void dal_hw_factory_dcn30_init(struct hw_factory *factory);
+
+#endif /* __DAL_HW_FACTORY_DCN30_H__ */
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
new file mode 100644
index 000000000000..c2f42e0248b3
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.c
@@ -0,0 +1,387 @@
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
+/*
+ * Pre-requisites: headers required by header of this unit
+ */
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+#include "hw_translate_dcn30.h"
+
+#include "dm_services.h"
+#include "include/gpio_types.h"
+#include "../hw_translate.h"
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
+/* begin *********************
+ * macros to expend register list macro defined in HW object header file */
+
+/* DCN */
+#define block HPD
+#define reg_num 0
+
+#undef BASE_INNER
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
+
+#define BASE(seg) BASE_INNER(seg)
+
+#undef REG
+#define REG(reg_name)\
+		BASE(mm ## reg_name ## _BASE_IDX) + mm ## reg_name
+#define SF_HPD(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+
+/* macros to expend register list macro defined in HW object header file
+ * end *********************/
+
+
+static bool offset_to_id(
+	uint32_t offset,
+	uint32_t mask,
+	enum gpio_id *id,
+	uint32_t *en)
+{
+	switch (offset) {
+	/* GENERIC */
+	case REG(DC_GPIO_GENERIC_A):
+		*id = GPIO_ID_GENERIC;
+		switch (mask) {
+		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICA_A_MASK:
+			*en = GPIO_GENERIC_A;
+			return true;
+		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICB_A_MASK:
+			*en = GPIO_GENERIC_B;
+			return true;
+		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICC_A_MASK:
+			*en = GPIO_GENERIC_C;
+			return true;
+		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICD_A_MASK:
+			*en = GPIO_GENERIC_D;
+			return true;
+		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICE_A_MASK:
+			*en = GPIO_GENERIC_E;
+			return true;
+		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICF_A_MASK:
+			*en = GPIO_GENERIC_F;
+			return true;
+		case DC_GPIO_GENERIC_A__DC_GPIO_GENERICG_A_MASK:
+			*en = GPIO_GENERIC_G;
+			return true;
+		default:
+			ASSERT_CRITICAL(false);
+			return false;
+		}
+	break;
+	/* HPD */
+	case REG(DC_GPIO_HPD_A):
+		*id = GPIO_ID_HPD;
+		switch (mask) {
+		case DC_GPIO_HPD_A__DC_GPIO_HPD1_A_MASK:
+			*en = GPIO_HPD_1;
+			return true;
+		case DC_GPIO_HPD_A__DC_GPIO_HPD2_A_MASK:
+			*en = GPIO_HPD_2;
+			return true;
+		case DC_GPIO_HPD_A__DC_GPIO_HPD3_A_MASK:
+			*en = GPIO_HPD_3;
+			return true;
+		case DC_GPIO_HPD_A__DC_GPIO_HPD4_A_MASK:
+			*en = GPIO_HPD_4;
+			return true;
+		case DC_GPIO_HPD_A__DC_GPIO_HPD5_A_MASK:
+			*en = GPIO_HPD_5;
+			return true;
+		case DC_GPIO_HPD_A__DC_GPIO_HPD6_A_MASK:
+			*en = GPIO_HPD_6;
+			return true;
+		default:
+			ASSERT_CRITICAL(false);
+			return false;
+		}
+	break;
+	/* REG(DC_GPIO_GENLK_MASK */
+	case REG(DC_GPIO_GENLK_A):
+		*id = GPIO_ID_GSL;
+		switch (mask) {
+		case DC_GPIO_GENLK_A__DC_GPIO_GENLK_CLK_A_MASK:
+			*en = GPIO_GSL_GENLOCK_CLOCK;
+			return true;
+		case DC_GPIO_GENLK_A__DC_GPIO_GENLK_VSYNC_A_MASK:
+			*en = GPIO_GSL_GENLOCK_VSYNC;
+			return true;
+		case DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_A_A_MASK:
+			*en = GPIO_GSL_SWAPLOCK_A;
+			return true;
+		case DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_B_A_MASK:
+			*en = GPIO_GSL_SWAPLOCK_B;
+			return true;
+		default:
+			ASSERT_CRITICAL(false);
+			return false;
+		}
+	break;
+	/* DDC */
+	/* we don't care about the GPIO_ID for DDC
+	 * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
+	 * directly in the create method */
+	case REG(DC_GPIO_DDC1_A):
+		*en = GPIO_DDC_LINE_DDC1;
+		return true;
+	case REG(DC_GPIO_DDC2_A):
+		*en = GPIO_DDC_LINE_DDC2;
+		return true;
+	case REG(DC_GPIO_DDC3_A):
+		*en = GPIO_DDC_LINE_DDC3;
+		return true;
+	case REG(DC_GPIO_DDC4_A):
+		*en = GPIO_DDC_LINE_DDC4;
+		return true;
+	case REG(DC_GPIO_DDC5_A):
+		*en = GPIO_DDC_LINE_DDC5;
+		return true;
+	case REG(DC_GPIO_DDC6_A):
+		*en = GPIO_DDC_LINE_DDC6;
+		return true;
+	case REG(DC_GPIO_DDCVGA_A):
+		*en = GPIO_DDC_LINE_DDC_VGA;
+		return true;
+
+//	case REG(DC_GPIO_I2CPAD_A): not exit
+//	case REG(DC_GPIO_PWRSEQ_A):
+//	case REG(DC_GPIO_PAD_STRENGTH_1):
+//	case REG(DC_GPIO_PAD_STRENGTH_2):
+//	case REG(DC_GPIO_DEBUG):
+	/* UNEXPECTED */
+	default:
+//	case REG(DC_GPIO_SYNCA_A): not exist
+		ASSERT_CRITICAL(false);
+		return false;
+	}
+}
+
+static bool id_to_offset(
+	enum gpio_id id,
+	uint32_t en,
+	struct gpio_pin_info *info)
+{
+	bool result = true;
+
+	switch (id) {
+	case GPIO_ID_DDC_DATA:
+		info->mask = DC_GPIO_DDC6_A__DC_GPIO_DDC6DATA_A_MASK;
+		switch (en) {
+		case GPIO_DDC_LINE_DDC1:
+			info->offset = REG(DC_GPIO_DDC1_A);
+		break;
+		case GPIO_DDC_LINE_DDC2:
+			info->offset = REG(DC_GPIO_DDC2_A);
+		break;
+		case GPIO_DDC_LINE_DDC3:
+			info->offset = REG(DC_GPIO_DDC3_A);
+		break;
+		case GPIO_DDC_LINE_DDC4:
+			info->offset = REG(DC_GPIO_DDC4_A);
+		break;
+		case GPIO_DDC_LINE_DDC5:
+			info->offset = REG(DC_GPIO_DDC5_A);
+		break;
+		case GPIO_DDC_LINE_DDC6:
+			info->offset = REG(DC_GPIO_DDC6_A);
+		break;
+		case GPIO_DDC_LINE_DDC_VGA:
+			info->offset = REG(DC_GPIO_DDCVGA_A);
+		break;
+		case GPIO_DDC_LINE_I2C_PAD:
+		default:
+			ASSERT_CRITICAL(false);
+			result = false;
+		}
+	break;
+	case GPIO_ID_DDC_CLOCK:
+		info->mask = DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK;
+		switch (en) {
+		case GPIO_DDC_LINE_DDC1:
+			info->offset = REG(DC_GPIO_DDC1_A);
+		break;
+		case GPIO_DDC_LINE_DDC2:
+			info->offset = REG(DC_GPIO_DDC2_A);
+		break;
+		case GPIO_DDC_LINE_DDC3:
+			info->offset = REG(DC_GPIO_DDC3_A);
+		break;
+		case GPIO_DDC_LINE_DDC4:
+			info->offset = REG(DC_GPIO_DDC4_A);
+		break;
+		case GPIO_DDC_LINE_DDC5:
+			info->offset = REG(DC_GPIO_DDC5_A);
+		break;
+		case GPIO_DDC_LINE_DDC6:
+			info->offset = REG(DC_GPIO_DDC6_A);
+		break;
+		case GPIO_DDC_LINE_DDC_VGA:
+			info->offset = REG(DC_GPIO_DDCVGA_A);
+		break;
+		case GPIO_DDC_LINE_I2C_PAD:
+		default:
+			ASSERT_CRITICAL(false);
+			result = false;
+		}
+	break;
+	case GPIO_ID_GENERIC:
+		info->offset = REG(DC_GPIO_GENERIC_A);
+		switch (en) {
+		case GPIO_GENERIC_A:
+			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICA_A_MASK;
+		break;
+		case GPIO_GENERIC_B:
+			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICB_A_MASK;
+		break;
+		case GPIO_GENERIC_C:
+			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICC_A_MASK;
+		break;
+		case GPIO_GENERIC_D:
+			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICD_A_MASK;
+		break;
+		case GPIO_GENERIC_E:
+			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICE_A_MASK;
+		break;
+		case GPIO_GENERIC_F:
+			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICF_A_MASK;
+		break;
+		case GPIO_GENERIC_G:
+			info->mask = DC_GPIO_GENERIC_A__DC_GPIO_GENERICG_A_MASK;
+		break;
+		default:
+			ASSERT_CRITICAL(false);
+			result = false;
+		}
+	break;
+	case GPIO_ID_HPD:
+		info->offset = REG(DC_GPIO_HPD_A);
+		switch (en) {
+		case GPIO_HPD_1:
+			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD1_A_MASK;
+		break;
+		case GPIO_HPD_2:
+			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD2_A_MASK;
+		break;
+		case GPIO_HPD_3:
+			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD3_A_MASK;
+		break;
+		case GPIO_HPD_4:
+			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD4_A_MASK;
+		break;
+		case GPIO_HPD_5:
+			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD5_A_MASK;
+		break;
+		case GPIO_HPD_6:
+			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD6_A_MASK;
+		break;
+		default:
+			ASSERT_CRITICAL(false);
+			result = false;
+		}
+	break;
+	case GPIO_ID_GSL:
+		switch (en) {
+		case GPIO_GSL_GENLOCK_CLOCK:
+				/*not implmented*/
+			ASSERT_CRITICAL(false);
+			result = false;
+		break;
+		case GPIO_GSL_GENLOCK_VSYNC:
+			/*not implmented*/
+			ASSERT_CRITICAL(false);
+			result = false;
+		break;
+		case GPIO_GSL_SWAPLOCK_A:
+			/*not implmented*/
+			ASSERT_CRITICAL(false);
+			result = false;
+		break;
+		case GPIO_GSL_SWAPLOCK_B:
+			/*not implmented*/
+			ASSERT_CRITICAL(false);
+			result = false;
+
+		break;
+		default:
+			ASSERT_CRITICAL(false);
+			result = false;
+		}
+	break;
+	case GPIO_ID_SYNC:
+	case GPIO_ID_VIP_PAD:
+	default:
+		ASSERT_CRITICAL(false);
+		result = false;
+	}
+
+	if (result) {
+		info->offset_y = info->offset + 2;
+		info->offset_en = info->offset + 1;
+		info->offset_mask = info->offset - 1;
+
+		info->mask_y = info->mask;
+		info->mask_en = info->mask;
+		info->mask_mask = info->mask;
+	}
+
+	return result;
+}
+
+/* function table */
+static const struct hw_translate_funcs funcs = {
+	.offset_to_id = offset_to_id,
+	.id_to_offset = id_to_offset,
+};
+
+/*
+ * dal_hw_translate_dcn10_init
+ *
+ * @brief
+ * Initialize Hw translate function pointers.
+ *
+ * @param
+ * struct hw_translate *tr - [out] struct of function pointers
+ *
+ */
+void dal_hw_translate_dcn30_init(struct hw_translate *tr)
+{
+	tr->funcs = &funcs;
+}
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.h b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.h
new file mode 100644
index 000000000000..fe6c3f84aef9
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_translate_dcn30.h
@@ -0,0 +1,35 @@
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
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+#ifndef __DAL_HW_TRANSLATE_DCN30_H__
+#define __DAL_HW_TRANSLATE_DCN30_H__
+
+struct hw_translate;
+
+/* Initialize Hw translate function pointers */
+void dal_hw_translate_dcn30_init(struct hw_translate *tr);
+
+#endif /* __DAL_HW_TRANSLATE_DCN30_H__ */
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index f252af1947c3..e5cfe28bc7bf 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -50,6 +50,9 @@
 #include "dcn20/hw_factory_dcn20.h"
 #include "dcn21/hw_factory_dcn21.h"
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+#include "dcn30/hw_factory_dcn30.h"
+#endif
 
 #include "diagnostics/hw_factory_diag.h"
 
@@ -99,7 +102,11 @@ bool dal_hw_factory_init(
 		dal_hw_factory_dcn21_init(factory);
 		return true;
 #endif
-
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	case DCN_VERSION_3_0:
+		dal_hw_factory_dcn30_init(factory);
+		return true;
+#endif
 	default:
 		ASSERT_CRITICAL(false);
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 04e2c0f74cb0..efea7cb0f17c 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -48,6 +48,9 @@
 #include "dcn20/hw_translate_dcn20.h"
 #include "dcn21/hw_translate_dcn21.h"
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+#include "dcn30/hw_translate_dcn30.h"
+#endif
 
 #include "diagnostics/hw_translate_diag.h"
 
@@ -94,6 +97,11 @@ bool dal_hw_translate_init(
 		dal_hw_translate_dcn21_init(translate);
 		return true;
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	case DCN_VERSION_3_0:
+		dal_hw_translate_dcn30_init(translate);
+		return true;
+#endif
 
 	default:
 		BREAK_TO_DEBUGGER();
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
