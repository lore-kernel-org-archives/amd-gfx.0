Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27038C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 16:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C87E010EE69;
	Fri, 18 Feb 2022 16:59:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0A510EE63
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 16:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXB1pWA3YZcIEpYFnUDgGn29JVwSxFex+Bktcdzn0/92dglsuIZ52gDxvGfz74gW3+j7w0N8EfMQung0M0yEKuS3OHApc+OMNsA0ENacH07p8RkHXZTHdVEGuf82WHv+xNfSOh5nSS55LBbVZfydM4f8F/QCP0ocJmbQxGfsmjl2p2rQbBcYqfmaAsfC1AXPfxBFQsOSdHARGsvnazW1uW9dxINK0CfBEhd5/MNe9jOv7Maj6Jic54A0ZyfjJsHl4+PFH2YeCeIkcFWelKzM8e85BMJpypihF/+grRV9C6mZl9S4ala4y4pvwYxXwKFbWZV6J6cGqJzZKJ51B3LHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTlalmWcB0eqbfGHCG0MfYzjFp1/mCJS8hlSo3PSP/8=;
 b=VdVzpoObgevRQ3SnqY/wBpfGrHMus+/2szCpZWySsXtTSKTDSEe9jwecDMPgFktz9VIjMDYxZrC6rx0H52JW6LXN+Pi0t3gE1Tlc/7jVsvExITv08N904GiZX0iwdCzvVRX2V8NH8HF8pgHvDiJKR24KEYbWFPRLY5fkd58rNEwzG8XUQbNcMlFhMtSB5pdr9vaIocb9AGQNFMTRwIAlHTchXF5EsL1rTkHn9nfQ822TQpzJwzvwb/L1bDxpXXAeMoD/7uA7nmuslIPDjhN47YxHrjsFqw7c/o4PruZj52GCgcNH5mjo7hBQnZkmdTlrUn7OvQRfZl347L3o9sGCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTlalmWcB0eqbfGHCG0MfYzjFp1/mCJS8hlSo3PSP/8=;
 b=YoOdcXNRbyEkBD5uPgITCsveKubwE+hZc7IxabtSB25OGzHS5Q81B9MbJhU0cgk1EFKcD3M7Xsnel9ccFWMdotwLuU7uk8oyMF9PbkC1ahNXbDkpkLTXo0FBlMef2WstCBUZIdpneLO2WcUC49U3iVic2ERATLoqs8DKt/DxP9Y=
Received: from MW4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:303:8f::19)
 by CY4PR12MB1558.namprd12.prod.outlook.com (2603:10b6:910:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Fri, 18 Feb
 2022 16:59:14 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::c2) by MW4PR03CA0014.outlook.office365.com
 (2603:10b6:303:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Fri, 18 Feb 2022 16:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:59:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:59:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/13] drm/amd/display: Add DCN315 IRQ
Date: Fri, 18 Feb 2022 11:58:47 -0500
Message-ID: <20220218165854.1417733-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218165854.1417733-1-alexander.deucher@amd.com>
References: <20220218165854.1417733-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 326b2aba-5dff-4224-42d6-08d9f2fffdfd
X-MS-TrafficTypeDiagnostic: CY4PR12MB1558:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB155804FBBF2AB60B36968E6EF7379@CY4PR12MB1558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiydvrNSyPH0Fz3bLyjqAysPze8R1khpFsB+qmoGMFXDGY+HYLzyEMrvJq+hJ5lm4tulOkk+Pfhm3jn7/+aOtd4Wfn5TD3+s6IFYESfJZ7AaVXvNSSNU+qHpTHtnnXITE1LeR3FKlv032ro+XFkwZuIw/AN8zJLIGYayU7iA92mplCsgIeTpV93DUOG8AD+aiBeXkm/4fBhuVN2QveARCHgkRKan3z5Z1GLzZLxuIptRKoOMOekCGtIwQEUyGudOk2YMAHj5KBL4CiX+ATYEDy/JwYpxZckzKc69KrJpKSGaAY/VU4rHaxRlbxYsxBSAwFGqK3tDREjgmHGvjdfXp397Ww/IzNtB69I4mZ7mbHuwQke4A/E+9p4y88pMQEinVgnXAM+ShejRuI3rP1Vhz8fw2WQeEIQXGSlshyVV+RkZ3LqCicRYPIsxWNLd5R07w1YntVgkXlI5bloQzk+x+RZxzwR2PCaP4J6Tqpfb5kBiOrgBmv3kcZakfB3/GX6PShZW9n9otc8p3IYwe5UgEqlW85v3plQn5ti/NCINh1NX7BCyFruXL78TX/fzdSc7D9lHWLGfe2CieuVFCf4ZPMGabIBMR/uEZ01VgGDYpSdf9labT1ZdoIw7gcoMYWky/wxXFsOtf1s3/wdZoFDh1+NL+whMJt3ofPbHOYxegclCH7CeWMiNwYWnRPhQBsTQubHLWNfSwCd86PHk0/jXPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(7696005)(54906003)(316002)(336012)(6916009)(4326008)(26005)(47076005)(1076003)(36860700001)(6666004)(186003)(2906002)(508600001)(8676002)(83380400001)(16526019)(70206006)(81166007)(36756003)(2616005)(82310400004)(426003)(5660300002)(30864003)(8936002)(40460700003)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:59:13.9420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 326b2aba-5dff-4224-42d6-08d9f2fffdfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1558
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
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

Add irq interfaces for DCN 3.1.5.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |   8 +
 .../dc/irq/dcn315/irq_service_dcn315.c        | 438 ++++++++++++++++++
 .../dc/irq/dcn315/irq_service_dcn315.h        |  34 ++
 3 files changed, 480 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.h

diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index fd739aecf104..f305d4c9a122 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -137,3 +137,11 @@ AMD_DAL_IRQ_DCN31= $(addprefix $(AMDDALPATH)/dc/irq/dcn31/,$(IRQ_DCN31))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN31)
 endif
+###############################################################################
+# DCN 315
+###############################################################################
+IRQ_DCN315 = irq_service_dcn315.o
+
+AMD_DAL_IRQ_DCN315= $(addprefix $(AMDDALPATH)/dc/irq/dcn315/,$(IRQ_DCN315))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN315)
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
new file mode 100644
index 000000000000..33367773699b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
@@ -0,0 +1,438 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+
+#include "dcn/dcn_3_1_5_offset.h"
+#include "dcn/dcn_3_1_5_sh_mask.h"
+
+#include "irq_service_dcn315.h"
+
+#include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
+
+#define DCN_BASE__INST0_SEG0                       0x00000012
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+#define DCN_BASE__INST0_SEG3                       0x00009000
+#define DCN_BASE__INST0_SEG4                       0x02403C00
+#define DCN_BASE__INST0_SEG5                       0
+
+enum dc_irq_source to_dal_irq_source_dcn315(
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
+static const struct irq_source_info_funcs outbox_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
+static const struct irq_source_info_funcs vline0_irq_info_funcs = {
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
+#define SRI_DMUB(reg_name)\
+	BASE(reg ## reg_name ## _BASE_IDX) + \
+			reg ## reg_name
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
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
+	.enable_reg = SRI_DMUB(reg1),\
+	.enable_mask = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	.enable_value = {\
+		reg1 ## __ ## mask1 ## _MASK,\
+		~reg1 ## __ ## mask1 ## _MASK \
+	},\
+	.ack_reg = SRI_DMUB(reg2),\
+	.ack_mask = \
+		reg2 ## __ ## mask2 ## _MASK,\
+	.ack_value = \
+		reg2 ## __ ## mask2 ## _MASK \
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
+	}
+
+#define vline0_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
+		.funcs = &vline0_irq_info_funcs\
+	}
+#define dmub_outbox_int_entry()\
+	[DC_IRQ_SOURCE_DMCUB_OUTBOX] = {\
+		IRQ_REG_ENTRY_DMUB(\
+			DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX1_READY_INT_EN,\
+			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX1_READY_INT_ACK),\
+		.funcs = &outbox_irq_info_funcs\
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
+irq_source_info_dcn315[DAL_IRQ_SOURCES_NUMBER] = {
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
+	vline0_int_entry(0),
+	vline0_int_entry(1),
+	vline0_int_entry(2),
+	vline0_int_entry(3),
+	[DC_IRQ_SOURCE_DC5_VLINE1] = dummy_irq_entry(),
+	[DC_IRQ_SOURCE_DC6_VLINE1] = dummy_irq_entry(),
+	dmub_outbox_int_entry(),
+};
+
+static const struct irq_service_funcs irq_service_funcs_dcn315 = {
+		.to_dal_irq_source = to_dal_irq_source_dcn315
+};
+
+static void dcn315_irq_construct(
+	struct irq_service *irq_service,
+	struct irq_service_init_data *init_data)
+{
+	dal_irq_service_construct(irq_service, init_data);
+
+	irq_service->info = irq_source_info_dcn315;
+	irq_service->funcs = &irq_service_funcs_dcn315;
+}
+
+struct irq_service *dal_irq_service_dcn315_create(
+	struct irq_service_init_data *init_data)
+{
+	struct irq_service *irq_service = kzalloc(sizeof(*irq_service),
+						  GFP_KERNEL);
+
+	if (!irq_service)
+		return NULL;
+
+	dcn315_irq_construct(irq_service, init_data);
+	return irq_service;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.h b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.h
new file mode 100644
index 000000000000..a5a80486a8d6
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#ifndef __DAL_IRQ_SERVICE_DCN315_H__
+#define __DAL_IRQ_SERVICE_DCN315_H__
+
+#include "../irq_service.h"
+
+struct irq_service *dal_irq_service_dcn315_create(
+	struct irq_service_init_data *init_data);
+
+#endif /* __DAL_IRQ_SERVICE_DCN315_H__ */
-- 
2.35.1

