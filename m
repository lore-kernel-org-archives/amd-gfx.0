Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C128C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 21:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1088E10E391;
	Wed, 28 Feb 2024 21:17:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qEqTD+ne";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B36410E391
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 21:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9+GRPHAh3NZd2x5wBHRKUII6ndU2xzEWgkb8rrJcyWOcjep8ocnhn3ote0wKTFz90oaVFdR+eckikaFb1/4he3rwj131jNE39pbj2b1YsCCI2YTyMyNcqjuaLnB5rmTPyTQIl2+RkYqv3wUAtPUaH/IJguoqoe2SIjNtPbIVAdGD6uTYPwGKxTUIKFDrWl6atG6Il9Iep3NruVvczjPSn1cWAUehOKj0H/u2S7EE9I4QFs012ZfFn3gpWd0U8SMxVi4+qQXlE082D3d+r7RVwB5+u/5HK92FEdCmeo9sj5Lvc/vcYbFtn5XnPxeSgZZuPP8+Hzl36uYJ/utrJt4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNbRKuZfixo8IWkTqhs7fskLcCZTvRGd2oNi5xghE10=;
 b=N1eD7H0s6s8Ku58n7QZd1ajFFQOLVNJxMKp4WyoEGFYleyLEkK1SdJZXL3U6uOXTTNDYGTEiXnz0fVx8u78DRWLVHxl0dgXVcKMnGfCnqzTFwxCBvk91vcmG1ioUw+ssb0eVG8lJV6Dv+GdRppZBIbMuSx+CmrDaaaUsaEmTkoOfYfggFtbZkvLauXIyectLHVmaJWoTjku7i8nEWzDaJRp42426jN1AEqWSOhkQoquh1vOa604JnVoaaqUD2ojVX8UpNW4ejW4eO6b+CcRXFz306lfh2K/rjELNEQaHiScH+cra7A/EnlHTGAIELEj5S8/YQwt4aXl5pNcMCMRU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNbRKuZfixo8IWkTqhs7fskLcCZTvRGd2oNi5xghE10=;
 b=qEqTD+neeVkHilWtm+Y7UFnlBl2VJuZvzejkk9d/KcHrKBVNW8wOzvyq1cfF0MIAYWIaKLqwbsyI5MJ24ouVK756oIIqiJ4HyoHAWeLrraCQb377ajGQ2Ith5hVFBlgveOcn64wE4qy04P2RacFGUHMAq2qboyvDf+gi1vhqlIA=
Received: from BN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:ee::34)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 21:17:04 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::2d) by BN0PR04CA0029.outlook.office365.com
 (2603:10b6:408:ee::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 21:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 21:17:03 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 15:17:01 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 4/6] drm/amd/display: add DCN351 IRQ changes
Date: Wed, 28 Feb 2024 16:16:35 -0500
Message-ID: <20240228211638.36109-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228211638.36109-1-hamza.mahfooz@amd.com>
References: <20240228211638.36109-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af6de5c-38c5-41f6-36d4-08dc38a29c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4GVP8igg7ZHURoTlWiW34eaXtmnz/68oel7lQV0iBiNQImW7h+XKDq2oQTK6Pq918GrNyfXTY9BAPfg4MevJHmCru6VZJcQRi53R3VbJxYFhF2Dx/9cOczTCov9ZOjnizEo7SJSTQflbwDX6AUSXwYaGs8t4+1Qz2uwaxeRrBzIn1tBA3vc2/Wvy5PzFdA0y8b9+O56EsUYPyDMcg5J7SbXMebKlQLTDrSUfuMH+id0an6K8OEO6grd20ud4oH/7D6W7G/FslSvd+WsC9rzQjEzQfYyTxi8dMGxm8/z53fJBtnad6sKLYGjTaLzzer11OsU098vHiooeZ0dvsRv/ocU1n3gigaG+15XizkPr/GzYGlgpIsZ2JAJj75iwhVVhwKVbxY731rrfjkjS3giP29zcBozT5nvejzXR8IrBhhzO5KRao6Qrx7txxVbf/kq4bqfNs7GR/PToINT+zhcBScmvUSL1tHAHIvHAmXAFwTQujDVyzzRql5AmLd00Pn8WMV352471IfoEdBCxN77sMbqzTGpfciV4VYI9V42isjP0KWOQhXtDYGYoEPJT9EewdZ/GMur/c6TPTNXr4u8WQOYhXMhvu0rX+ZfBjVCBqoTRrChXpF3HWen9Taro6blH5p9Lr0KYwZcV4Db7Ct0iyVjaNpr7nuEK4GaNeHKeg95GIvaIbMNgNLOJ9pdwKzNEamWZwwRutF6B1EWYTXUbCXG8ujdv3Gqupd7xCFWIen7tLm1yRpIRBJAYMuZv4KY+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:17:03.7986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af6de5c-38c5-41f6-36d4-08dc38a29c55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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

Add DCN3.5.1 interrupt support.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |  11 +-
 .../dc/irq/dcn351/irq_service_dcn351.c        | 409 ++++++++++++++++++
 .../dc/irq/dcn351/irq_service_dcn351.h        |  12 +
 3 files changed, 431 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.h

diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index 076f667a82f6..2d4378780c1a 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -170,4 +170,13 @@ IRQ_DCN35 = irq_service_dcn35.o
 
 AMD_DAL_IRQ_DCN35= $(addprefix $(AMDDALPATH)/dc/irq/dcn35/,$(IRQ_DCN35))
 
-AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN35)
\ No newline at end of file
+AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN35)
+
+###############################################################################
+# DCN 351
+###############################################################################
+IRQ_DCN351 = irq_service_dcn351.o
+
+AMD_DAL_IRQ_DCN351= $(addprefix $(AMDDALPATH)/dc/irq/dcn351/,$(IRQ_DCN351))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN351)
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
new file mode 100644
index 000000000000..7ec8e0de2f01
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
@@ -0,0 +1,409 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2024 Advanced Micro Devices, Inc. */
+
+#include "dm_services.h"
+#include "include/logger_interface.h"
+#include "../dce110/irq_service_dce110.h"
+
+
+#include "dcn/dcn_3_5_1_offset.h"
+#include "dcn/dcn_3_5_1_sh_mask.h"
+
+#include "irq_service_dcn351.h"
+
+#include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
+
+static enum dc_irq_source to_dal_irq_source_dcn351(
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
+	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC1_VLINE0;
+	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC2_VLINE0;
+	case DCN_1_0__SRCID__OTG3_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC3_VLINE0;
+	case DCN_1_0__SRCID__OTG4_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC4_VLINE0;
+	case DCN_1_0__SRCID__OTG5_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC5_VLINE0;
+	case DCN_1_0__SRCID__OTG6_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC6_VLINE0;
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
+	case DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT:
+		return DC_IRQ_SOURCE_DMCUB_OUTBOX;
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
+static struct irq_source_info_funcs hpd_irq_info_funcs = {
+	.set = NULL,
+	.ack = hpd_ack
+};
+
+static struct irq_source_info_funcs hpd_rx_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs pflip_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs vblank_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs outbox_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static struct irq_source_info_funcs vline0_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+#undef BASE_INNER
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
+
+/* compile time expand base address. */
+#define BASE(seg) \
+	BASE_INNER(seg)
+
+#define SRI(reg_name, block, id)\
+	BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+			reg ## block ## id ## _ ## reg_name
+
+#define SRI_DMUB(reg_name)\
+	BASE(reg ## reg_name ## _BASE_IDX) + \
+			reg ## reg_name
+
+#define IRQ_REG_ENTRY(base, block, reg_num, reg1, mask1, reg2, mask2)\
+	REG_STRUCT[base + reg_num].enable_reg = SRI(reg1, block, reg_num),\
+	REG_STRUCT[base + reg_num].enable_mask = \
+		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base + reg_num].enable_value[0] = \
+		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base + reg_num].enable_value[1] = \
+		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK, \
+	REG_STRUCT[base + reg_num].ack_reg = SRI(reg2, block, reg_num),\
+	REG_STRUCT[base + reg_num].ack_mask = \
+		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
+	REG_STRUCT[base + reg_num].ack_value = \
+		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK \
+
+#define IRQ_REG_ENTRY_DMUB(base, reg1, mask1, reg2, mask2)\
+	REG_STRUCT[base].enable_reg = SRI_DMUB(reg1),\
+	REG_STRUCT[base].enable_mask = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base].enable_value[0] = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	REG_STRUCT[base].enable_value[1] = \
+		~reg1 ## __ ## mask1 ## _MASK, \
+	REG_STRUCT[base].ack_reg = SRI_DMUB(reg2),\
+	REG_STRUCT[base].ack_mask = \
+		reg2 ## __ ## mask2 ## _MASK,\
+	REG_STRUCT[base].ack_value = \
+		reg2 ## __ ## mask2 ## _MASK \
+
+#define hpd_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_HPD1, HPD, reg_num,\
+			DC_HPD_INT_CONTROL, DC_HPD_INT_EN,\
+			DC_HPD_INT_CONTROL, DC_HPD_INT_ACK),\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1 + reg_num].funcs = &hpd_irq_info_funcs;\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1 + reg_num].status_reg = SRI(DC_HPD_INT_STATUS, HPD, reg_num);\
+
+#define hpd_rx_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_HPD1RX, HPD, reg_num,\
+			DC_HPD_INT_CONTROL, DC_HPD_RX_INT_EN,\
+			DC_HPD_INT_CONTROL, DC_HPD_RX_INT_ACK),\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1RX + reg_num].status_reg = SRI(DC_HPD_INT_STATUS, HPD, reg_num);\
+		REG_STRUCT[DC_IRQ_SOURCE_HPD1RX + reg_num].funcs = &hpd_rx_irq_info_funcs;\
+
+#define pflip_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_PFLIP1, HUBPREQ, reg_num,\
+			DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_INT_MASK,\
+			DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_PFLIP1 + reg_num].funcs = &pflip_irq_info_funcs\
+
+/* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match semantic
+ * of DCE's DC_IRQ_SOURCE_VUPDATEx.
+ */
+#define vupdate_no_lock_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_VUPDATE1, OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_EVENT_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_VUPDATE1 + reg_num].funcs = &vupdate_no_lock_irq_info_funcs\
+
+#define vblank_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_VBLANK1, OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VSTARTUP_EVENT_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_VBLANK1 + reg_num].funcs = &vblank_irq_info_funcs\
+
+#define vline0_int_entry(reg_num)\
+		IRQ_REG_ENTRY(DC_IRQ_SOURCE_DC1_VLINE0, OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
+		REG_STRUCT[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num].funcs = &vline0_irq_info_funcs\
+
+#define dmub_outbox_int_entry()\
+		IRQ_REG_ENTRY_DMUB(DC_IRQ_SOURCE_DMCUB_OUTBOX, \
+			DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX1_READY_INT_EN,\
+			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX1_READY_INT_ACK),\
+		REG_STRUCT[DC_IRQ_SOURCE_DMCUB_OUTBOX].funcs = &outbox_irq_info_funcs
+
+#define dummy_irq_entry(irqno) \
+	REG_STRUCT[irqno].funcs = &dummy_irq_info_funcs\
+
+#define i2c_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_I2C_DDC ## reg_num)
+
+#define dp_sink_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_DPSINK ## reg_num)
+
+#define gpio_pad_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_GPIOPAD ## reg_num)
+
+#define dc_underflow_int_entry(reg_num) \
+	dummy_irq_entry(DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW)
+
+static struct irq_source_info_funcs dummy_irq_info_funcs = {
+	.set = dal_irq_service_dummy_set,
+	.ack = dal_irq_service_dummy_ack
+};
+
+#define dcn351_irq_init_part_1() {\
+	dummy_irq_entry(DC_IRQ_SOURCE_INVALID); \
+	hpd_int_entry(0); \
+	hpd_int_entry(1); \
+	hpd_int_entry(2); \
+	hpd_int_entry(3); \
+	hpd_int_entry(4); \
+	hpd_rx_int_entry(0); \
+	hpd_rx_int_entry(1); \
+	hpd_rx_int_entry(2); \
+	hpd_rx_int_entry(3); \
+	hpd_rx_int_entry(4); \
+	i2c_int_entry(1); \
+	i2c_int_entry(2); \
+	i2c_int_entry(3); \
+	i2c_int_entry(4); \
+	i2c_int_entry(5); \
+	i2c_int_entry(6); \
+	dp_sink_int_entry(1); \
+	dp_sink_int_entry(2); \
+	dp_sink_int_entry(3); \
+	dp_sink_int_entry(4); \
+	dp_sink_int_entry(5); \
+	dp_sink_int_entry(6); \
+	dummy_irq_entry(DC_IRQ_SOURCE_TIMER); \
+	pflip_int_entry(0); \
+	pflip_int_entry(1); \
+	pflip_int_entry(2); \
+	pflip_int_entry(3); \
+	dummy_irq_entry(DC_IRQ_SOURCE_PFLIP5); \
+	dummy_irq_entry(DC_IRQ_SOURCE_PFLIP6); \
+	dummy_irq_entry(DC_IRQ_SOURCE_PFLIP_UNDERLAY0); \
+	gpio_pad_int_entry(0); \
+	gpio_pad_int_entry(1); \
+	gpio_pad_int_entry(2); \
+	gpio_pad_int_entry(3); \
+	gpio_pad_int_entry(4); \
+	gpio_pad_int_entry(5); \
+	gpio_pad_int_entry(6); \
+	gpio_pad_int_entry(7); \
+	gpio_pad_int_entry(8); \
+	gpio_pad_int_entry(9); \
+	gpio_pad_int_entry(10); \
+	gpio_pad_int_entry(11); \
+	gpio_pad_int_entry(12); \
+	gpio_pad_int_entry(13); \
+	gpio_pad_int_entry(14); \
+	gpio_pad_int_entry(15); \
+	gpio_pad_int_entry(16); \
+	gpio_pad_int_entry(17); \
+	gpio_pad_int_entry(18); \
+	gpio_pad_int_entry(19); \
+	gpio_pad_int_entry(20); \
+	gpio_pad_int_entry(21); \
+	gpio_pad_int_entry(22); \
+	gpio_pad_int_entry(23); \
+	gpio_pad_int_entry(24); \
+	gpio_pad_int_entry(25); \
+	gpio_pad_int_entry(26); \
+	gpio_pad_int_entry(27); \
+	gpio_pad_int_entry(28); \
+	gpio_pad_int_entry(29); \
+	gpio_pad_int_entry(30); \
+	dc_underflow_int_entry(1); \
+	dc_underflow_int_entry(2); \
+	dc_underflow_int_entry(3); \
+	dc_underflow_int_entry(4); \
+	dc_underflow_int_entry(5); \
+	dc_underflow_int_entry(6); \
+	dummy_irq_entry(DC_IRQ_SOURCE_DMCU_SCP); \
+	dummy_irq_entry(DC_IRQ_SOURCE_VBIOS_SW); \
+}
+
+#define dcn351_irq_init_part_2() {\
+	vupdate_no_lock_int_entry(0); \
+	vupdate_no_lock_int_entry(1); \
+	vupdate_no_lock_int_entry(2); \
+	vupdate_no_lock_int_entry(3); \
+	vblank_int_entry(0); \
+	vblank_int_entry(1); \
+	vblank_int_entry(2); \
+	vblank_int_entry(3); \
+	vline0_int_entry(0); \
+	vline0_int_entry(1); \
+	vline0_int_entry(2); \
+	vline0_int_entry(3); \
+	dummy_irq_entry(DC_IRQ_SOURCE_DC5_VLINE1); \
+	dummy_irq_entry(DC_IRQ_SOURCE_DC6_VLINE1); \
+	dmub_outbox_int_entry(); \
+}
+
+#define dcn351_irq_init() {\
+	dcn351_irq_init_part_1(); \
+	dcn351_irq_init_part_2(); \
+}
+
+static struct irq_source_info irq_source_info_dcn351[DAL_IRQ_SOURCES_NUMBER] = {0};
+
+static struct irq_service_funcs irq_service_funcs_dcn351 = {
+		.to_dal_irq_source = to_dal_irq_source_dcn351
+};
+
+static void dcn351_irq_construct(
+	struct irq_service *irq_service,
+	struct irq_service_init_data *init_data)
+{
+	struct dc_context *ctx = init_data->ctx;
+
+#define REG_STRUCT irq_source_info_dcn351
+	dcn351_irq_init();
+
+	dal_irq_service_construct(irq_service, init_data);
+
+	irq_service->info = irq_source_info_dcn351;
+	irq_service->funcs = &irq_service_funcs_dcn351;
+}
+
+struct irq_service *dal_irq_service_dcn351_create(
+	struct irq_service_init_data *init_data)
+{
+	struct irq_service *irq_service = kzalloc(sizeof(*irq_service),
+						  GFP_KERNEL);
+
+	if (!irq_service)
+		return NULL;
+
+	dcn351_irq_construct(irq_service, init_data);
+	return irq_service;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.h b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.h
new file mode 100644
index 000000000000..4094631ffec6
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2021 Advanced Micro Devices, Inc. */
+
+#ifndef __DAL_IRQ_SERVICE_DCN351_H__
+#define __DAL_IRQ_SERVICE_DCN351_H__
+
+#include "../irq_service.h"
+
+struct irq_service *dal_irq_service_dcn351_create(
+	struct irq_service_init_data *init_data);
+
+#endif /* __DAL_IRQ_SERVICE_DCN351_H__ */
-- 
2.43.0

