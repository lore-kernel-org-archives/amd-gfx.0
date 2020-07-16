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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE31C433E8
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD9120787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcJ5IYuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD9120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18CDB6ECEF;
	Thu, 16 Jul 2020 21:23:19 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA3976ECE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:17 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z13so8639284wrw.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6L+YHvwbiSZwsb3C1dtH51zUsfbRd8q0jriqzTdndfE=;
 b=fcJ5IYuwioiEd3SRYnl6gKoLEmtpmFeTK0R3C3V0e7mVqeHCK7+mnKiJQ24lvMghoz
 hPpGjQXRYpv+LMmblufL2eUEIO761jmlGLTK7piYttERbifdyt2Ywm/gvLk3S4t8D+Fi
 oUV19ZfFdWBzL1Ni3KTC3UlTsyJNeBe4wO5Qw8nQYLjRq1HNYSUzYUfiv+gaB5diCf5G
 9RbDXuXK16QIy7qyO3JX/G3Y0Ula6U6mYpiRxNv65Hz73Y64YKb+p4dI1VOVxq8Jxoyb
 U0jBTgfLE4QorLBy3Sf/O29Qh2AYChlwcDGUbBYrYSkJEFg/4gzmYu1GllMvKvfnttnL
 NOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6L+YHvwbiSZwsb3C1dtH51zUsfbRd8q0jriqzTdndfE=;
 b=eLjzIRHJQOPuqvvJR5t+dhrtgP9DpQdgAhwL46N+NxZR5Je6/bsvdwpLCtTr6kx928
 CRNtSsQCBvqU+18F8sWVjsrpaXXxm+Szpt5DVBcszAxBl4wdFAO7RCx0FhHHVOXQ0aky
 KbTrbPl8q2+yRZr0jtpnqhK8E0ZB1nSztvRRp3/y1AUgv36opyUEfNoE/SWmnkUfTzOO
 kl7hRrm8d9QSeq/eBrKAvWWbW86+Pcq2qmHo4sVm9Czm4ai2jhFMix/JOWgPtRaUPK9p
 ftfUMICd53yb/EKzsCrFzPUgEt9wKDErhgQt6Pxi5xJsDHGSGKLxVUl0bolDjq6WdPAl
 b73w==
X-Gm-Message-State: AOAM532ykHhIi8YkzLxRmMeR6AzH9sMVsIL89t5hEzYfxVkUKiIESsze
 iWCezwRIlVzBMJeIwyA6rMZPhHrYgwM=
X-Google-Smtp-Source: ABdhPJzJTc3Khnbz/DYFf9oWe4mG/3T1PA8rB1UzmdXb3sfdWZonrrBZeevJ73zuJxRI5HgBCr8OyQ==
X-Received: by 2002:a5d:634e:: with SMTP id b14mr7179048wrw.423.1594934595578; 
 Thu, 16 Jul 2020 14:23:15 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:14 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 07/27] drm/amd/display: dc/irq: add support for DCE6 (v4)
Date: Thu, 16 Jul 2020 23:22:31 +0200
Message-Id: <20200716212251.1539094-8-issor.oruam@gmail.com>
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
irq service requires changes for DCE6 support

[How]
(v1) DCE6 targets are added replicating existing DCE8 implementation.
     due to missing CRTC_VERTICAL_INTERRUPT0_CONTROL registers/masks,
     dce/dce_8_0_{d,sh_mask}.h used instead of dce/dce_6_0_{d,sh_mask}.h

(v2) DCE6 headers used adding the necessary vblank irq registers
     (INT_MASK and VBLANK_STATUS) and vblank irq masks as implemented
     in amdgpu driver.
     Add vblank_irq_info_funcs_dce60 with .set and .ack as per commit
     b10d51f ("drm/amd/display: Add interrupt entries for VBLANK isr.")
     and use it in vblank_int_entry(reg_num) macro definition

(v3) updated due to following kernel 5.3 commit:
     4fc4dca ("drm/amd: drop use of drmp.h in os_types.h")

(v4) updated due to following kernel 5.6 commit:
     d9e3267 ("drm/amd/display: cleanup of construct and destruct funcs")

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |  11 +
 .../display/dc/irq/dce60/irq_service_dce60.c  | 395 ++++++++++++++++++
 .../display/dc/irq/dce60/irq_service_dce60.h  |  40 ++
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   3 +
 4 files changed, 449 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.h

diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index 3352b79fb1cb..405c25322607 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -30,6 +30,17 @@ AMD_DAL_IRQ = $(addprefix $(AMDDALPATH)/dc/irq/,$(IRQ))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ)
 
+###############################################################################
+# DCE 6x
+###############################################################################
+ifdef CONFIG_DRM_AMD_DC_SI
+IRQ_DCE60 = irq_service_dce60.o
+
+AMD_DAL_IRQ_DCE60 = $(addprefix $(AMDDALPATH)/dc/irq/dce60/,$(IRQ_DCE60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCE60)
+endif
+
 ###############################################################################
 # DCE 8x
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.c b/drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.c
new file mode 100644
index 000000000000..524481885fd0
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.c
@@ -0,0 +1,395 @@
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
+#include <linux/slab.h>
+
+#include "dm_services.h"
+
+#include "include/logger_interface.h"
+
+#include "irq_service_dce60.h"
+#include "../dce110/irq_service_dce110.h"
+
+#include "dce/dce_6_0_d.h"
+#include "dce/dce_6_0_sh_mask.h"
+
+#include "ivsrcid/ivsrcid_vislands30.h"
+
+#define VISLANDS30_IV_SRCID_D1_VBLANK                        1
+#define VISLANDS30_IV_SRCID_D2_VBLANK                        2
+#define VISLANDS30_IV_SRCID_D3_VBLANK                        3
+#define VISLANDS30_IV_SRCID_D4_VBLANK                        4
+#define VISLANDS30_IV_SRCID_D5_VBLANK                        5
+#define VISLANDS30_IV_SRCID_D6_VBLANK                        6
+
+#include "dc_types.h"
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
+			DC_HPD1_INT_STATUS,
+			DC_HPD1_SENSE_DELAYED);
+
+	dal_irq_service_ack_generic(irq_service, info);
+
+	value = dm_read_reg(irq_service->ctx, info->enable_reg);
+
+	set_reg_field_value(
+		value,
+		current_status ? 0 : 1,
+		DC_HPD1_INT_CONTROL,
+		DC_HPD1_INT_POLARITY);
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
+	.set = dce110_vblank_set,
+	.ack = NULL
+};
+
+static const struct irq_source_info_funcs vblank_irq_info_funcs_dce60 = {
+	.set = NULL,
+	.ack = NULL
+};
+
+#define hpd_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_INVALID + reg_num] = {\
+		.enable_reg = mmDC_HPD ## reg_num ## _INT_CONTROL,\
+		.enable_mask = DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_MASK,\
+		.enable_value = {\
+			DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_MASK,\
+			~DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_MASK\
+		},\
+		.ack_reg = mmDC_HPD ## reg_num ## _INT_CONTROL,\
+		.ack_mask = DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK,\
+		.ack_value = DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK,\
+		.status_reg = mmDC_HPD ## reg_num ## _INT_STATUS,\
+		.funcs = &hpd_irq_info_funcs\
+	}
+
+#define hpd_rx_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_HPD6 + reg_num] = {\
+		.enable_reg = mmDC_HPD ## reg_num ## _INT_CONTROL,\
+		.enable_mask = DC_HPD1_INT_CONTROL__DC_HPD1_RX_INT_EN_MASK,\
+		.enable_value = {\
+				DC_HPD1_INT_CONTROL__DC_HPD1_RX_INT_EN_MASK,\
+			~DC_HPD1_INT_CONTROL__DC_HPD1_RX_INT_EN_MASK },\
+		.ack_reg = mmDC_HPD ## reg_num ## _INT_CONTROL,\
+		.ack_mask = DC_HPD1_INT_CONTROL__DC_HPD1_RX_INT_ACK_MASK,\
+		.ack_value = DC_HPD1_INT_CONTROL__DC_HPD1_RX_INT_ACK_MASK,\
+		.status_reg = mmDC_HPD ## reg_num ## _INT_STATUS,\
+		.funcs = &hpd_rx_irq_info_funcs\
+	}
+
+#define pflip_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_PFLIP1 + reg_num] = {\
+		.enable_reg = mmDCP ## reg_num ## _GRPH_INTERRUPT_CONTROL,\
+		.enable_mask =\
+		GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK,\
+		.enable_value = {\
+			GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK,\
+			~GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK},\
+		.ack_reg = mmDCP ## reg_num ## _GRPH_INTERRUPT_STATUS,\
+		.ack_mask = GRPH_INTERRUPT_STATUS__GRPH_PFLIP_INT_CLEAR_MASK,\
+		.ack_value = GRPH_INTERRUPT_STATUS__GRPH_PFLIP_INT_CLEAR_MASK,\
+		.status_reg = mmDCP ## reg_num ##_GRPH_INTERRUPT_STATUS,\
+		.funcs = &pflip_irq_info_funcs\
+ 	}
+
+#define vupdate_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
+		.enable_reg = mmCRTC ## reg_num ## _CRTC_INTERRUPT_CONTROL,\
+		.enable_mask =\
+		CRTC_INTERRUPT_CONTROL__CRTC_V_UPDATE_INT_MSK_MASK,\
+		.enable_value = {\
+			CRTC_INTERRUPT_CONTROL__CRTC_V_UPDATE_INT_MSK_MASK,\
+			~CRTC_INTERRUPT_CONTROL__CRTC_V_UPDATE_INT_MSK_MASK},\
+		.ack_reg = mmCRTC ## reg_num ## _CRTC_V_UPDATE_INT_STATUS,\
+		.ack_mask =\
+		CRTC_V_UPDATE_INT_STATUS__CRTC_V_UPDATE_INT_CLEAR_MASK,\
+		.ack_value =\
+		CRTC_V_UPDATE_INT_STATUS__CRTC_V_UPDATE_INT_CLEAR_MASK,\
+		.funcs = &vblank_irq_info_funcs\
+	}
+
+#define vblank_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_VBLANK1 + reg_num] = {\
+		.enable_reg = mmLB ## reg_num ## _INT_MASK,\
+		.enable_mask =\
+			INT_MASK__VBLANK_INT_MASK,\
+		.enable_value = {\
+			INT_MASK__VBLANK_INT_MASK,\
+			~INT_MASK__VBLANK_INT_MASK},\
+		.ack_reg = mmLB ## reg_num ## _VBLANK_STATUS,\
+		.ack_mask =\
+		VBLANK_STATUS__VBLANK_ACK_MASK,\
+		.ack_value =\
+		VBLANK_STATUS__VBLANK_ACK_MASK,\
+		.funcs = &vblank_irq_info_funcs_dce60\
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
+
+static const struct irq_source_info_funcs dummy_irq_info_funcs = {
+	.set = dal_irq_service_dummy_set,
+	.ack = dal_irq_service_dummy_ack
+};
+
+static const struct irq_source_info
+irq_source_info_dce60[DAL_IRQ_SOURCES_NUMBER] = {
+	[DC_IRQ_SOURCE_INVALID] = dummy_irq_entry(),
+	hpd_int_entry(1),
+	hpd_int_entry(2),
+	hpd_int_entry(3),
+	hpd_int_entry(4),
+	hpd_int_entry(5),
+	hpd_int_entry(6),
+	hpd_rx_int_entry(1),
+	hpd_rx_int_entry(2),
+	hpd_rx_int_entry(3),
+	hpd_rx_int_entry(4),
+	hpd_rx_int_entry(5),
+	hpd_rx_int_entry(6),
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
+	pflip_int_entry(4),
+	pflip_int_entry(5),
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
+enum dc_irq_source to_dal_irq_source_dce60(
+		struct irq_service *irq_service,
+		uint32_t src_id,
+		uint32_t ext_id)
+{
+	switch (src_id) {
+	case VISLANDS30_IV_SRCID_D1_VBLANK:
+		return DC_IRQ_SOURCE_VBLANK1;
+	case VISLANDS30_IV_SRCID_D2_VBLANK:
+		return DC_IRQ_SOURCE_VBLANK2;
+	case VISLANDS30_IV_SRCID_D3_VBLANK:
+		return DC_IRQ_SOURCE_VBLANK3;
+	case VISLANDS30_IV_SRCID_D4_VBLANK:
+		return DC_IRQ_SOURCE_VBLANK4;
+	case VISLANDS30_IV_SRCID_D5_VBLANK:
+		return DC_IRQ_SOURCE_VBLANK5;
+	case VISLANDS30_IV_SRCID_D6_VBLANK:
+		return DC_IRQ_SOURCE_VBLANK6;
+	case VISLANDS30_IV_SRCID_D1_V_UPDATE_INT:
+		return DC_IRQ_SOURCE_VUPDATE1;
+	case VISLANDS30_IV_SRCID_D2_V_UPDATE_INT:
+		return DC_IRQ_SOURCE_VUPDATE2;
+	case VISLANDS30_IV_SRCID_D3_V_UPDATE_INT:
+		return DC_IRQ_SOURCE_VUPDATE3;
+	case VISLANDS30_IV_SRCID_D4_V_UPDATE_INT:
+		return DC_IRQ_SOURCE_VUPDATE4;
+	case VISLANDS30_IV_SRCID_D5_V_UPDATE_INT:
+		return DC_IRQ_SOURCE_VUPDATE5;
+	case VISLANDS30_IV_SRCID_D6_V_UPDATE_INT:
+		return DC_IRQ_SOURCE_VUPDATE6;
+	case VISLANDS30_IV_SRCID_D1_GRPH_PFLIP:
+		return DC_IRQ_SOURCE_PFLIP1;
+	case VISLANDS30_IV_SRCID_D2_GRPH_PFLIP:
+		return DC_IRQ_SOURCE_PFLIP2;
+	case VISLANDS30_IV_SRCID_D3_GRPH_PFLIP:
+		return DC_IRQ_SOURCE_PFLIP3;
+	case VISLANDS30_IV_SRCID_D4_GRPH_PFLIP:
+		return DC_IRQ_SOURCE_PFLIP4;
+	case VISLANDS30_IV_SRCID_D5_GRPH_PFLIP:
+		return DC_IRQ_SOURCE_PFLIP5;
+	case VISLANDS30_IV_SRCID_D6_GRPH_PFLIP:
+		return DC_IRQ_SOURCE_PFLIP6;
+
+	case VISLANDS30_IV_SRCID_HOTPLUG_DETECT_A:
+		/* generic src_id for all HPD and HPDRX interrupts */
+		switch (ext_id) {
+		case VISLANDS30_IV_EXTID_HOTPLUG_DETECT_A:
+			return DC_IRQ_SOURCE_HPD1;
+		case VISLANDS30_IV_EXTID_HOTPLUG_DETECT_B:
+			return DC_IRQ_SOURCE_HPD2;
+		case VISLANDS30_IV_EXTID_HOTPLUG_DETECT_C:
+			return DC_IRQ_SOURCE_HPD3;
+		case VISLANDS30_IV_EXTID_HOTPLUG_DETECT_D:
+			return DC_IRQ_SOURCE_HPD4;
+		case VISLANDS30_IV_EXTID_HOTPLUG_DETECT_E:
+			return DC_IRQ_SOURCE_HPD5;
+		case VISLANDS30_IV_EXTID_HOTPLUG_DETECT_F:
+			return DC_IRQ_SOURCE_HPD6;
+		case VISLANDS30_IV_EXTID_HPD_RX_A:
+			return DC_IRQ_SOURCE_HPD1RX;
+		case VISLANDS30_IV_EXTID_HPD_RX_B:
+			return DC_IRQ_SOURCE_HPD2RX;
+		case VISLANDS30_IV_EXTID_HPD_RX_C:
+			return DC_IRQ_SOURCE_HPD3RX;
+		case VISLANDS30_IV_EXTID_HPD_RX_D:
+			return DC_IRQ_SOURCE_HPD4RX;
+		case VISLANDS30_IV_EXTID_HPD_RX_E:
+			return DC_IRQ_SOURCE_HPD5RX;
+		case VISLANDS30_IV_EXTID_HPD_RX_F:
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
+static const struct irq_service_funcs irq_service_funcs_dce60 = {
+		.to_dal_irq_source = to_dal_irq_source_dce60
+};
+
+static void dce60_irq_construct(
+	struct irq_service *irq_service,
+	struct irq_service_init_data *init_data)
+{
+	dal_irq_service_construct(irq_service, init_data);
+
+	irq_service->info = irq_source_info_dce60;
+	irq_service->funcs = &irq_service_funcs_dce60;
+}
+
+struct irq_service *dal_irq_service_dce60_create(
+	struct irq_service_init_data *init_data)
+{
+	struct irq_service *irq_service = kzalloc(sizeof(*irq_service),
+						  GFP_KERNEL);
+
+	if (!irq_service)
+		return NULL;
+
+	dce60_irq_construct(irq_service, init_data);
+	return irq_service;
+}
+
+
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.h b/drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.h
new file mode 100644
index 000000000000..294db29e8115
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce60/irq_service_dce60.h
@@ -0,0 +1,40 @@
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
+#ifndef __DAL_IRQ_SERVICE_DCE60_H__
+#define __DAL_IRQ_SERVICE_DCE60_H__
+
+#include "../irq_service.h"
+
+enum dc_irq_source to_dal_irq_source_dce60(
+		struct irq_service *irq_service,
+		uint32_t src_id,
+		uint32_t ext_id);
+
+struct irq_service *dal_irq_service_dce60_create(
+	struct irq_service_init_data *init_data);
+
+#endif
+
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index 33053b9fe6bd..6bf27bde8724 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -32,6 +32,9 @@
 
 #include "dce110/irq_service_dce110.h"
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#include "dce60/irq_service_dce60.h"
+#endif
 
 #include "dce80/irq_service_dce80.h"
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
