Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931BAC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6149820787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e59HdGv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6149820787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9286ECEE;
	Thu, 16 Jul 2020 21:23:18 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED116ECE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:16 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id q15so11737920wmj.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t63JSvVZ9IAtW198Bjbe22qehD/HPz+PiDyEG+5xOfM=;
 b=e59HdGv1j54W84pLc9thD5XkYE8c9JSQG2jZucEeTdb0eQE6/hb++Ao1wnjpYE7svI
 wNO13sogQw4nFgsAOY87vwXDhoPbmBcGIjuMWTpJxMwysaUdJlR/XGIaxJkfnrYN5BkG
 RBJo+3KuAWJPDIEUjOnGozM5ehwnpuJ3eH5xtwnyyVunKv0Orvp1X78zIMbZAopHc6+y
 s+W7WLH0nbQHxPOyLAPFDjUKUZEjuDgkhs0odA5btjZDH6QwCw0j2wfam5LowQ6nXkFk
 cOcs2JrXNidASUeCfYx2FL4bkbFc0uWCYh1rrdjr4aBe/EwxKXyTxg9L42km7BG71GG/
 KNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t63JSvVZ9IAtW198Bjbe22qehD/HPz+PiDyEG+5xOfM=;
 b=W61grnaBdDyLqeu4dUlraK/mXiTrKz+tfTfZXJh0z7ChnQrYC20SIr8R1i+smZvSdo
 S1lChS+q0GTOmBpqxtDNPQG3pqu8yC5jsZy2MXMLbLv5Jpxd9aK60oF6adjr//jJyzUe
 OpLlALK0vY8S2oSmDu5Is/dKq8oibiNznHTCdXuk0ObhwwJwlGpFOioRnAlCcUM1sp6T
 17wy/7vwN88oNCqBJQcFEN1UymPts1KFC/A8TA5+sUTKJwaX0Dp14penJm6Fc3Ev7eqV
 v91KOvktiO6uZgPr2t5kchUcx1H4eomPI4SS1V+qM3p0cSCui9oa/2Zn9iGS7fC1xC3X
 FTrg==
X-Gm-Message-State: AOAM530LABS7/dDCdpP+YjHFpUsnlDWaoMeCTbGCx9BBTEdKbSgKjQQg
 VYGclQ78auBBUaKJ7r6aoThTRMJhuOw=
X-Google-Smtp-Source: ABdhPJw+dCN/4PBITWuEd1PSaqBbFgFnQJzFoGepQSIJezMlo3rk0jRK1WHCCGEZ5mjYXZwjXVVn6g==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr6232076wmj.86.1594934593939; 
 Thu, 16 Jul 2020 14:23:13 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:13 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 06/27] drm/amd/display: dc/gpio: add support for DCE6 (v2)
Date: Thu, 16 Jul 2020 23:22:30 +0200
Message-Id: <20200716212251.1539094-7-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
hw_factory.c requires changes for DCE6 support

[How]
DCE6 targets added replicating and adapting existing DCE8 implementation.

(v2) changes due to following commit:
    91db931 ("drm/amd/display: refactor gpio to allocate hw_container in constructor")

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |  12 +
 .../display/dc/gpio/dce60/hw_factory_dce60.c  | 175 ++++++++
 .../display/dc/gpio/dce60/hw_factory_dce60.h  |  32 ++
 .../dc/gpio/dce60/hw_translate_dce60.c        | 411 ++++++++++++++++++
 .../dc/gpio/dce60/hw_translate_dce60.h        |  32 ++
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |  10 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |  10 +
 7 files changed, 682 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_factory_dce60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_factory_dce60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_translate_dce60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_translate_dce60.h

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
index 0f2f4508e564..74c0943ed644 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
@@ -30,6 +30,18 @@ AMD_DAL_GPIO = $(addprefix $(AMDDALPATH)/dc/gpio/,$(GPIO))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_GPIO)
 
+###############################################################################
+# DCE 6x
+###############################################################################
+# all DCE6.x are derived from DCE6.0
+ifdef CONFIG_DRM_AMD_DC_SI
+GPIO_DCE60 = hw_translate_dce60.o hw_factory_dce60.o
+
+AMD_DAL_GPIO_DCE60 = $(addprefix $(AMDDALPATH)/dc/gpio/dce60/,$(GPIO_DCE60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCE60)
+endif
+
 ###############################################################################
 # DCE 8x
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_factory_dce60.c b/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_factory_dce60.c
new file mode 100644
index 000000000000..cc69acd8ada7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_factory_dce60.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
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
+#include "dm_services.h"
+#include "include/gpio_types.h"
+#include "../hw_factory.h"
+
+#include "hw_factory_dce60.h"
+
+#include "../hw_gpio.h"
+#include "../hw_ddc.h"
+#include "../hw_hpd.h"
+#include "../hw_generic.h"
+
+#include "dce/dce_6_0_d.h"
+#include "dce/dce_6_0_sh_mask.h"
+
+
+#define REG(reg_name)\
+		mm ## reg_name
+
+#include "reg_helper.h"
+#include "../hpd_regs.h"
+
+#define HPD_REG_LIST_DCE6(id) \
+	HPD_GPIO_REG_LIST(id), \
+	.int_status = mmDC_HPD ## id ## _INT_STATUS,\
+	.toggle_filt_cntl = mmDC_HPD ## id ## _TOGGLE_FILT_CNTL
+
+#define HPD_MASK_SH_LIST_DCE6(mask_sh) \
+		.DC_HPD_SENSE_DELAYED = DC_HPD1_INT_STATUS__DC_HPD1_SENSE_DELAYED ## mask_sh,\
+		.DC_HPD_SENSE = DC_HPD1_INT_STATUS__DC_HPD1_SENSE ## mask_sh,\
+		.DC_HPD_CONNECT_INT_DELAY = DC_HPD1_TOGGLE_FILT_CNTL__DC_HPD1_CONNECT_INT_DELAY ## mask_sh,\
+		.DC_HPD_DISCONNECT_INT_DELAY = DC_HPD1_TOGGLE_FILT_CNTL__DC_HPD1_DISCONNECT_INT_DELAY ## mask_sh
+
+#define hpd_regs(id) \
+{\
+	HPD_REG_LIST_DCE6(id)\
+}
+
+static const struct hpd_registers hpd_regs[] = {
+	hpd_regs(1),
+	hpd_regs(2),
+	hpd_regs(3),
+	hpd_regs(4),
+	hpd_regs(5),
+	hpd_regs(6)
+};
+
+static const struct hpd_sh_mask hpd_shift = {
+		HPD_MASK_SH_LIST_DCE6(__SHIFT)
+};
+
+static const struct hpd_sh_mask hpd_mask = {
+		HPD_MASK_SH_LIST_DCE6(_MASK)
+};
+
+#include "../ddc_regs.h"
+
+ /* set field name */
+#define SF_DDC(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+static const struct ddc_registers ddc_data_regs[] = {
+	ddc_data_regs(1),
+	ddc_data_regs(2),
+	ddc_data_regs(3),
+	ddc_data_regs(4),
+	ddc_data_regs(5),
+	ddc_data_regs(6),
+	ddc_vga_data_regs,
+	ddc_i2c_data_regs
+};
+
+static const struct ddc_registers ddc_clk_regs[] = {
+	ddc_clk_regs(1),
+	ddc_clk_regs(2),
+	ddc_clk_regs(3),
+	ddc_clk_regs(4),
+	ddc_clk_regs(5),
+	ddc_clk_regs(6),
+	ddc_vga_clk_regs,
+	ddc_i2c_clk_regs
+};
+
+static const struct ddc_sh_mask ddc_shift = {
+		DDC_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct ddc_sh_mask ddc_mask = {
+		DDC_MASK_SH_LIST(_MASK)
+};
+
+static void define_ddc_registers(
+		struct hw_gpio_pin *pin,
+		uint32_t en)
+{
+	struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
+
+	switch (pin->id) {
+	case GPIO_ID_DDC_DATA:
+		ddc->regs = &ddc_data_regs[en];
+		ddc->base.regs = &ddc_data_regs[en].gpio;
+		break;
+	case GPIO_ID_DDC_CLOCK:
+		ddc->regs = &ddc_clk_regs[en];
+		ddc->base.regs = &ddc_clk_regs[en].gpio;
+		break;
+	default:
+		ASSERT_CRITICAL(false);
+		return;
+	}
+
+	ddc->shifts = &ddc_shift;
+	ddc->masks = &ddc_mask;
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
+static const struct hw_factory_funcs funcs = {
+	.init_ddc_data = dal_hw_ddc_init,
+	.init_generic = NULL,
+	.init_hpd = dal_hw_hpd_init,
+	.get_ddc_pin = dal_hw_ddc_get_pin,
+	.get_hpd_pin = dal_hw_hpd_get_pin,
+	.get_generic_pin = NULL,
+	.define_hpd_registers = define_hpd_registers,
+	.define_ddc_registers = define_ddc_registers
+};
+
+void dal_hw_factory_dce60_init(
+	struct hw_factory *factory)
+{
+	factory->number_of_pins[GPIO_ID_DDC_DATA] = 8;
+	factory->number_of_pins[GPIO_ID_DDC_CLOCK] = 8;
+	factory->number_of_pins[GPIO_ID_GENERIC] = 7;
+	factory->number_of_pins[GPIO_ID_HPD] = 6;
+	factory->number_of_pins[GPIO_ID_GPIO_PAD] = 31;
+	factory->number_of_pins[GPIO_ID_VIP_PAD] = 0;
+	factory->number_of_pins[GPIO_ID_SYNC] = 2;
+	factory->number_of_pins[GPIO_ID_GSL] = 4;
+
+	factory->funcs = &funcs;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_factory_dce60.h b/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_factory_dce60.h
new file mode 100644
index 000000000000..1fd54ff8979c
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_factory_dce60.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
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
+#ifndef __DAL_HW_FACTORY_DCE60_H__
+#define __DAL_HW_FACTORY_DCE60_H__
+
+void dal_hw_factory_dce60_init(
+	struct hw_factory *factory);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_translate_dce60.c b/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_translate_dce60.c
new file mode 100644
index 000000000000..255df31ec577
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_translate_dce60.c
@@ -0,0 +1,411 @@
+/*
+ * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
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
+#include "dm_services.h"
+
+/*
+ * Pre-requisites: headers required by header of this unit
+ */
+#include "include/gpio_types.h"
+#include "../hw_translate.h"
+
+#include "hw_translate_dce60.h"
+
+#include "dce/dce_6_0_d.h"
+#include "dce/dce_6_0_sh_mask.h"
+#include "smu/smu_6_0_d.h"
+
+/*
+ * @brief
+ * Returns index of first bit (starting with LSB) which is set
+ */
+static uint32_t index_from_vector(
+	uint32_t vector)
+{
+	uint32_t result = 0;
+	uint32_t mask = 1;
+
+	do {
+		if (vector == mask)
+			return result;
+
+		++result;
+		mask <<= 1;
+	} while (mask);
+
+	BREAK_TO_DEBUGGER();
+
+	return GPIO_ENUM_UNKNOWN;
+}
+
+static bool offset_to_id(
+	uint32_t offset,
+	uint32_t mask,
+	enum gpio_id *id,
+	uint32_t *en)
+{
+	switch (offset) {
+	/* GENERIC */
+	case mmDC_GPIO_GENERIC_A:
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
+			BREAK_TO_DEBUGGER();
+			return false;
+		}
+	break;
+	/* HPD */
+	case mmDC_GPIO_HPD_A:
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
+			BREAK_TO_DEBUGGER();
+			return false;
+		}
+	break;
+	/* SYNCA */
+	case mmDC_GPIO_SYNCA_A:
+		*id = GPIO_ID_SYNC;
+		switch (mask) {
+		case DC_GPIO_SYNCA_A__DC_GPIO_HSYNCA_A_MASK:
+			*en = GPIO_SYNC_HSYNC_A;
+			return true;
+		case DC_GPIO_SYNCA_A__DC_GPIO_VSYNCA_A_MASK:
+			*en = GPIO_SYNC_VSYNC_A;
+			return true;
+		default:
+			BREAK_TO_DEBUGGER();
+			return false;
+		}
+	break;
+	/* mmDC_GPIO_GENLK_MASK */
+	case mmDC_GPIO_GENLK_A:
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
+			BREAK_TO_DEBUGGER();
+			return false;
+		}
+	break;
+	/* GPIOPAD */
+	case mmGPIOPAD_A:
+		*id = GPIO_ID_GPIO_PAD;
+		*en = index_from_vector(mask);
+		return (*en <= GPIO_GPIO_PAD_MAX);
+	/* DDC */
+	/* we don't care about the GPIO_ID for DDC
+	 * in DdcHandle it will use GPIO_ID_DDC_DATA/GPIO_ID_DDC_CLOCK
+	 * directly in the create method */
+	case mmDC_GPIO_DDC1_A:
+		*en = GPIO_DDC_LINE_DDC1;
+		return true;
+	case mmDC_GPIO_DDC2_A:
+		*en = GPIO_DDC_LINE_DDC2;
+		return true;
+	case mmDC_GPIO_DDC3_A:
+		*en = GPIO_DDC_LINE_DDC3;
+		return true;
+	case mmDC_GPIO_DDC4_A:
+		*en = GPIO_DDC_LINE_DDC4;
+		return true;
+	case mmDC_GPIO_DDC5_A:
+		*en = GPIO_DDC_LINE_DDC5;
+		return true;
+	case mmDC_GPIO_DDC6_A:
+		*en = GPIO_DDC_LINE_DDC6;
+		return true;
+	case mmDC_GPIO_DDCVGA_A:
+		*en = GPIO_DDC_LINE_DDC_VGA;
+		return true;
+	/* GPIO_I2CPAD */
+	case mmDC_GPIO_I2CPAD_A:
+		*en = GPIO_DDC_LINE_I2C_PAD;
+		return true;
+	/* Not implemented */
+	case mmDC_GPIO_PWRSEQ_A:
+	case mmDC_GPIO_PAD_STRENGTH_1:
+	case mmDC_GPIO_PAD_STRENGTH_2:
+	case mmDC_GPIO_DEBUG:
+		return false;
+	/* UNEXPECTED */
+	default:
+		BREAK_TO_DEBUGGER();
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
+			info->offset = mmDC_GPIO_DDC1_A;
+		break;
+		case GPIO_DDC_LINE_DDC2:
+			info->offset = mmDC_GPIO_DDC2_A;
+		break;
+		case GPIO_DDC_LINE_DDC3:
+			info->offset = mmDC_GPIO_DDC3_A;
+		break;
+		case GPIO_DDC_LINE_DDC4:
+			info->offset = mmDC_GPIO_DDC4_A;
+		break;
+		case GPIO_DDC_LINE_DDC5:
+			info->offset = mmDC_GPIO_DDC5_A;
+		break;
+		case GPIO_DDC_LINE_DDC6:
+			info->offset = mmDC_GPIO_DDC6_A;
+		break;
+		case GPIO_DDC_LINE_DDC_VGA:
+			info->offset = mmDC_GPIO_DDCVGA_A;
+		break;
+		case GPIO_DDC_LINE_I2C_PAD:
+			info->offset = mmDC_GPIO_I2CPAD_A;
+		break;
+		default:
+			BREAK_TO_DEBUGGER();
+			result = false;
+		}
+	break;
+	case GPIO_ID_DDC_CLOCK:
+		info->mask = DC_GPIO_DDC6_A__DC_GPIO_DDC6CLK_A_MASK;
+		switch (en) {
+		case GPIO_DDC_LINE_DDC1:
+			info->offset = mmDC_GPIO_DDC1_A;
+		break;
+		case GPIO_DDC_LINE_DDC2:
+			info->offset = mmDC_GPIO_DDC2_A;
+		break;
+		case GPIO_DDC_LINE_DDC3:
+			info->offset = mmDC_GPIO_DDC3_A;
+		break;
+		case GPIO_DDC_LINE_DDC4:
+			info->offset = mmDC_GPIO_DDC4_A;
+		break;
+		case GPIO_DDC_LINE_DDC5:
+			info->offset = mmDC_GPIO_DDC5_A;
+		break;
+		case GPIO_DDC_LINE_DDC6:
+			info->offset = mmDC_GPIO_DDC6_A;
+		break;
+		case GPIO_DDC_LINE_DDC_VGA:
+			info->offset = mmDC_GPIO_DDCVGA_A;
+		break;
+		case GPIO_DDC_LINE_I2C_PAD:
+			info->offset = mmDC_GPIO_I2CPAD_A;
+		break;
+		default:
+			BREAK_TO_DEBUGGER();
+			result = false;
+		}
+	break;
+	case GPIO_ID_GENERIC:
+		info->offset = mmDC_GPIO_GENERIC_A;
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
+			BREAK_TO_DEBUGGER();
+			result = false;
+		}
+	break;
+	case GPIO_ID_HPD:
+		info->offset = mmDC_GPIO_HPD_A;
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
+			BREAK_TO_DEBUGGER();
+			result = false;
+		}
+	break;
+	case GPIO_ID_SYNC:
+		switch (en) {
+		case GPIO_SYNC_HSYNC_A:
+			info->offset = mmDC_GPIO_SYNCA_A;
+			info->mask = DC_GPIO_SYNCA_A__DC_GPIO_HSYNCA_A_MASK;
+		break;
+		case GPIO_SYNC_VSYNC_A:
+			info->offset = mmDC_GPIO_SYNCA_A;
+			info->mask = DC_GPIO_SYNCA_A__DC_GPIO_VSYNCA_A_MASK;
+		break;
+		case GPIO_SYNC_HSYNC_B:
+		case GPIO_SYNC_VSYNC_B:
+		default:
+			BREAK_TO_DEBUGGER();
+			result = false;
+		}
+	break;
+	case GPIO_ID_GSL:
+		switch (en) {
+		case GPIO_GSL_GENLOCK_CLOCK:
+			info->offset = mmDC_GPIO_GENLK_A;
+			info->mask = DC_GPIO_GENLK_A__DC_GPIO_GENLK_CLK_A_MASK;
+		break;
+		case GPIO_GSL_GENLOCK_VSYNC:
+			info->offset = mmDC_GPIO_GENLK_A;
+			info->mask =
+				DC_GPIO_GENLK_A__DC_GPIO_GENLK_VSYNC_A_MASK;
+		break;
+		case GPIO_GSL_SWAPLOCK_A:
+			info->offset = mmDC_GPIO_GENLK_A;
+			info->mask = DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_A_A_MASK;
+		break;
+		case GPIO_GSL_SWAPLOCK_B:
+			info->offset = mmDC_GPIO_GENLK_A;
+			info->mask = DC_GPIO_GENLK_A__DC_GPIO_SWAPLOCK_B_A_MASK;
+		break;
+		default:
+			BREAK_TO_DEBUGGER();
+			result = false;
+		}
+	break;
+	case GPIO_ID_GPIO_PAD:
+		info->offset = mmGPIOPAD_A;
+		info->mask = (1 << en);
+		result = (info->mask <= GPIO_GPIO_PAD_MAX);
+	break;
+	case GPIO_ID_VIP_PAD:
+	default:
+		BREAK_TO_DEBUGGER();
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
+static const struct hw_translate_funcs funcs = {
+		.offset_to_id = offset_to_id,
+		.id_to_offset = id_to_offset,
+};
+
+void dal_hw_translate_dce60_init(
+	struct hw_translate *translate)
+{
+	translate->funcs = &funcs;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_translate_dce60.h b/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_translate_dce60.h
new file mode 100644
index 000000000000..1e811f35cec7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dce60/hw_translate_dce60.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
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
+#ifndef __DAL_HW_TRANSLATE_DCE60_H__
+#define __DAL_HW_TRANSLATE_DCE60_H__
+
+void dal_hw_translate_dce60_init(
+	struct hw_translate *tr);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index e5cfe28bc7bf..6fc8a6e9dc15 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -42,6 +42,9 @@
  * Post-requisites: headers required by this unit
  */
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#include "dce60/hw_factory_dce60.h"
+#endif
 #include "dce80/hw_factory_dce80.h"
 #include "dce110/hw_factory_dce110.h"
 #include "dce120/hw_factory_dce120.h"
@@ -71,6 +74,13 @@ bool dal_hw_factory_init(
 	}
 
 	switch (dce_version) {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	case DCE_VERSION_6_0:
+	case DCE_VERSION_6_1:
+	case DCE_VERSION_6_4:
+		dal_hw_factory_dce60_init(factory);
+		return true;
+#endif
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index efea7cb0f17c..3a93c945e57d 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -40,6 +40,9 @@
  * Post-requisites: headers required by this unit
  */
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#include "dce60/hw_translate_dce60.h"
+#endif
 #include "dce80/hw_translate_dce80.h"
 #include "dce110/hw_translate_dce110.h"
 #include "dce120/hw_translate_dce120.h"
@@ -69,6 +72,13 @@ bool dal_hw_translate_init(
 	}
 
 	switch (dce_version) {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	case DCE_VERSION_6_0:
+	case DCE_VERSION_6_1:
+	case DCE_VERSION_6_4:
+		dal_hw_translate_dce60_init(translate);
+		return true;
+#endif
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
