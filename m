Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D414C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C234A10E2AA;
	Wed, 25 May 2022 16:20:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F64110E5F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM2cdxPKs3dVI3lu/LFzMqmhk8qQrJsTVxj0WXmaDQ1ahJY4kpw/vJwoWB7Z7ZsjKOC1Y0BsLduMvDMbzy6mV0Gs3AgyHvgLxwH4O9Fex9Dn0uD7egpMxmKECaCa4XD4lvLkbgi0lwX5wXuTgDsjpIcs8JNmWXiBEHse6dZ20ZuCkpGp5NEEFVLe9LpsCaL4GW4+RpuWl9v4nmIn8eML4sFpVoS0i8N0og6gETo4xMtkKM6iCfCY+1lO1qr9NvAnaEVRib/+tHDqfNbR890z3rJ/rI3eZvzaln2Jix3BYnjPpdd4prqbUNTS7K9y22qaXFLhEpLmIP5owvznNQbwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lke/yHXkJd6hLs+56ADoVf7jt+BAFHpLAOGZHK5lX50=;
 b=T66IPj3nPmqmHIb/H2roDhXlH9up1vMXQjXTFcN1uKweNqIL7YboyjeDxo10gO0bZPquzmFkWEkaL329JgXZR9MOg7IeEMK++ls2I3AYgOJZkSRfZAdU5U+f/pXXw5Ya7a02mlAS+qIg4miYDE9GN2JFEgDLoxGCvR9nZUG39Ae4rBu93n4BUCS4UgQ9kHrg6YxDheCt5GaPpiuhlkrCDkOrIwiOlLSKvxBek71b/XgtqB6c4nKlv1Cmapra/R5nR0BMDzfuBBcw9U4QCPjEjSrXEVdzqDfxBRGHm5HZEMAnkQEQ5de0fJZiW/5ZNVDdvLHu4ZDehaMLV7MIoZa6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lke/yHXkJd6hLs+56ADoVf7jt+BAFHpLAOGZHK5lX50=;
 b=vto64XmkFyisivvWCC5bIERF9Ywbqwgzd2R0+nwYBTEzAXzUv8TdmY6xXmukY0XwHTwa4XArkUpukFYjJMJCN2fMy2LbgAxIgDwk7E7LwaopG76JzAoOGAynEQO0DrQpvxRkNl9QgsHMIUwjSZxY4skasarRjGSjAEj/ynS26vk=
Received: from DM6PR04CA0011.namprd04.prod.outlook.com (2603:10b6:5:334::16)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 16:20:04 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::7a) by DM6PR04CA0011.outlook.office365.com
 (2603:10b6:5:334::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Wed, 25 May 2022 16:20:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/43] drm/amd/display: add dcn32 IRQ changes
Date: Wed, 25 May 2022 12:19:04 -0400
Message-ID: <20220525161941.2544055-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c48af6f0-7967-4b6e-71fe-08da3e6a6cfb
X-MS-TrafficTypeDiagnostic: CH2PR12MB4167:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4167E1D601E9CDAC2486AEA2F7D69@CH2PR12MB4167.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAMy9UadrCJ9KZEUpJXfLU8w9+KmbAu2A2owwUCJI6pUGrW7CbTVHBNR4XaHUO/SLyOxHvRSTi7eMotNhigP7joS8EMdpCSNQ1NGDp8JT5LBcVeB9/NxRpus9bpswAKpfAjeptjB3H0gWCqQFvSRVMKqj0dpVmea/Zix/iD43m/SkEg5ZRqUxRii05xqaXeR048qLy0xXedHHc31pV2R9F3Ce+Kv2B6KnaWiLJ8FcwQkX3WCtOUuz8MO0CWtdGt7yfvR3neGmiX+SPvabalIwf+4WQ66zo3uSC6TGJjAlP+1dfK8K/QLeWJoGBzrtTcHMKoQVqKOHIbj1gYZnZdsdLOHSrIt7LTJ+TA1kmIfrtsJ6ZzdlMoqjWSEyyNZVrVs7iTUWBKt6QLFoyxH6PmNg7d9SSRsnzRo9/s9gxGRqwbU3sw3mn/Kp4bbB7WQooBZuD/S7xgJRndO4UAnnI5nsk5AOBhLEsrjKoQOrRS4TQAnv4kZewl0T6e9Ta4zc4R+7G4MB17OaWNttB5nb7NMqd9ii2Fn0LrPs8knGuyY2gqepTESTPX7VQneHgkTjPGa//Q9VGwYcdsdZGa7LIhLYHjvzvoaJN7R5sMrIitUJzA3QMXns8uvd+69LgrHnih+3QQ5bxgB+QZAhz8oU6F+DkMWUxCOmFro65me6WoJcxdv91UPMIG65eYO6g7OYgc1FBKKIukIaxPsrDtAe9eTog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(6916009)(1076003)(54906003)(356005)(36860700001)(8936002)(186003)(4326008)(8676002)(16526019)(36756003)(70586007)(81166007)(2616005)(70206006)(82310400005)(336012)(47076005)(83380400001)(316002)(40460700003)(2906002)(5660300002)(86362001)(30864003)(508600001)(26005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:04.1126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c48af6f0-7967-4b6e-71fe-08da3e6a6cfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Add DCN3.2.x interrupt support.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |  10 +-
 .../display/dc/irq/dcn32/irq_service_dcn32.c  | 367 ++++++++++++++++++
 .../display/dc/irq/dcn32/irq_service_dcn32.h  |  35 ++
 3 files changed, 411 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.h

diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index 5f49048dde47..41da81c85fdc 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -135,7 +135,6 @@ IRQ_DCN31 = irq_service_dcn31.o
 AMD_DAL_IRQ_DCN31= $(addprefix $(AMDDALPATH)/dc/irq/dcn31/,$(IRQ_DCN31))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN31)
-
 ###############################################################################
 # DCN 315
 ###############################################################################
@@ -144,3 +143,12 @@ IRQ_DCN315 = irq_service_dcn315.o
 AMD_DAL_IRQ_DCN315= $(addprefix $(AMDDALPATH)/dc/irq/dcn315/,$(IRQ_DCN315))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN315)
+
+###############################################################################
+# DCN 32
+###############################################################################
+IRQ_DCN32 = irq_service_dcn32.o
+
+AMD_DAL_IRQ_DCN32= $(addprefix $(AMDDALPATH)/dc/irq/dcn32/,$(IRQ_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN32)
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
new file mode 100644
index 000000000000..5c87057a6abc
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
@@ -0,0 +1,367 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#include "include/logger_interface.h"
+#include "../dce110/irq_service_dce110.h"
+
+#include "dcn/dcn_3_2_0_offset.h"
+#include "dcn/dcn_3_2_0_sh_mask.h"
+
+#include "irq_service_dcn32.h"
+
+#include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
+
+enum dc_irq_source to_dal_irq_source_dcn32(
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
+static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
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
+#define SRI(reg_name, block, id)\
+	BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+			reg ## block ## id ## _ ## reg_name
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
+/* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match semantic
+ * of DCE's DC_IRQ_SOURCE_VUPDATEx.
+ */
+#define vupdate_no_lock_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_EVENT_CLEAR),\
+		.funcs = &vupdate_no_lock_irq_info_funcs\
+	}
+
+#define vblank_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_VBLANK1 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_EVENT_CLEAR),\
+		.funcs = &vblank_irq_info_funcs\
+}
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
+irq_source_info_dcn32[DAL_IRQ_SOURCES_NUMBER] = {
+	[DC_IRQ_SOURCE_INVALID] = dummy_irq_entry(),
+	hpd_int_entry(0),
+	hpd_int_entry(1),
+	hpd_int_entry(2),
+	hpd_int_entry(3),
+	hpd_int_entry(4),
+	hpd_rx_int_entry(0),
+	hpd_rx_int_entry(1),
+	hpd_rx_int_entry(2),
+	hpd_rx_int_entry(3),
+	hpd_rx_int_entry(4),
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
+	vupdate_no_lock_int_entry(0),
+	vupdate_no_lock_int_entry(1),
+	vupdate_no_lock_int_entry(2),
+	vupdate_no_lock_int_entry(3),
+	vblank_int_entry(0),
+	vblank_int_entry(1),
+	vblank_int_entry(2),
+	vblank_int_entry(3),
+};
+
+static const struct irq_service_funcs irq_service_funcs_dcn32 = {
+		.to_dal_irq_source = to_dal_irq_source_dcn32
+};
+
+static void dcn32_irq_construct(
+	struct irq_service *irq_service,
+	struct irq_service_init_data *init_data)
+{
+	dal_irq_service_construct(irq_service, init_data);
+
+	irq_service->info = irq_source_info_dcn32;
+	irq_service->funcs = &irq_service_funcs_dcn32;
+}
+
+struct irq_service *dal_irq_service_dcn32_create(
+	struct irq_service_init_data *init_data)
+{
+	struct irq_service *irq_service = kzalloc(sizeof(*irq_service),
+						  GFP_KERNEL);
+
+	if (!irq_service)
+		return NULL;
+
+	dcn32_irq_construct(irq_service, init_data);
+	return irq_service;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.h b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.h
new file mode 100644
index 000000000000..a0d9c9e4e17f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+
+#ifndef __DAL_IRQ_SERVICE_DCN32_H__
+#define __DAL_IRQ_SERVICE_DCN32_H__
+
+#include "../irq_service.h"
+
+struct irq_service *dal_irq_service_dcn32_create(
+	struct irq_service_init_data *init_data);
+
+#endif /* __DAL_IRQ_SERVICE_DCN32_H__ */
-- 
2.35.3

