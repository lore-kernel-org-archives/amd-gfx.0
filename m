Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBFBC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 22:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34DC10ED64;
	Fri,  8 Jul 2022 22:09:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DB810ED64
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 22:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZgalDTUjYZVclgW8HvKf4ySE86HNMPNbGLCfjyfWI6/j67LehSRpYueZcCs0guPD6x2GTx2EgwBO6XsANLiROK0JTcDfzzTamPOL7vGM79pmDIDt0KOVNa0ouTpONGo34yDrAuaggE4wKQi1RMJhE7kpL8xFgIaO42sdJycUh0c+PXA6zrRPBONGmK4QYuQ4aQxdRQJ2JC/VPznRkNJx394jTI5V5HPeLjPfb9zr6PcI6zoykDRRk+Fw3jG9B9AKix3Iaolmofw/M2XFG/aw4/r4XwuDuSUrpREzsnKtItVIo6CHpEisRkXUMRb91Z3wCL980F9RjG5nrjwaxDvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd5kocW9JLQ1M8H9Ew+cL+CUVh1YbQV5lR3ib0eryWI=;
 b=OAdb8D9zcQkxIw56lon5Ix8lSSDk+B9khlK6t4QVsp/ihJVv8/mm9npCFmGJi8ejzGKhGFpnOYhJozhcyLCgKk1nOgTGbx1qjibMTzpuU/KKDvQceYm5prIQI4DZkmjoj0x3tyATXGYcdYeZfvZUNlum85J712rLz1I6S/nF+gAvNPr3RePAjkUG0nkMczs2ORpsbHbNDquEuxaANqgypXd81Xu2wNH2cygzpxLWcQAakA8HyIaXHzKb+i3AyE4gFNmxBccypl4HWDhjttUVwVeHi6TgpfXi+3M83g8Ng8JSoNLHYZMDjx2/S12+tEXyncbxcVWSfDB5vxhT0iW6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd5kocW9JLQ1M8H9Ew+cL+CUVh1YbQV5lR3ib0eryWI=;
 b=eR40PxdhKN9qWRfvKh4HeH2oxcwDRvcDyfRL4BynOt66yaWK7G4atOS2AUPS1QdxuN12zMe1qTInfd+IP8yMrX+R0270sl3byPhCfqwR26NriKaDxoiQsTOJXVF0pGh4v7SrVBsMXdRFdUEWAOXQxk1GjyMvLBsQTtuCh5UXT3A=
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 DM5PR1201MB0266.namprd12.prod.outlook.com (2603:10b6:4:57::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Fri, 8 Jul 2022 22:09:09 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::5d) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18 via Frontend
 Transport; Fri, 8 Jul 2022 22:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 22:09:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 17:09:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/9] drm/amd/display: Add DCN314 IRQ services
Date: Fri, 8 Jul 2022 18:08:48 -0400
Message-ID: <20220708220855.1475213-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220708220855.1475213-1-alexander.deucher@amd.com>
References: <20220708220855.1475213-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42ca4ea0-befa-4cda-0bc2-08da612e7baa
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0266:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmECVIaZ1wYZ2s3TuA371qOtMKkQIMgME+xiJz+/yJUWZ8GVVP03KSDiw4utHzt+ysBO+1S0pEC+2NGFZw0heCAEVd6+qdMSDozzWzYfRtKJozEhp5afdgOvLDJKnHNR1p/spBeODF6vWVU2sBdnBrvcQBNfLmCk8Ms8/XGnSRhbKAEL23dhEB0PAja8jEku8SC8GEaT5bDgzZmYFCNlHCHqn2+/lXfWjunorjSzsipUGNEJuKiwI7LkxU72wqYIqUYBgrd7ENzLFLQZ8ZkNd2F9Cc2Tb+eLem2EH9FRD5S9bmXJBc68m48Ja1b+HS2tq68GLEF4NXarZgITWpoV8Ax1mPtMWuQYp7pV5mtK0m3Ehlj5hr/b9ufslbaDB1Rh/VyxYH4hpETfhB+fni3TQAz65kN5GpOU73ssdkuuwKwTNQ3lCt+F1hm7u4Y4aYxDL5iTeUg96yT+x5ZgguCMDD3ljMSJ1no1sD8ar5BwPJgsh839kJtCDG/n/WRaPWx1JabFtQQdJ06GDoD0AhvTLJcgT1EVIVjcAhxP6jJylVUPtHv+Dns+AV+iSrPMPEQVQ0/ZaPqFmhJldY2cBiEa+B2buQXMc6bLGmMxURXtqbp85d1DSafeFlsMLsB4M8XA+JVL7MnXkIEML2Hl3Gy5BwreS2hMUdcLeF8ANyAOIstFoF/368WM0PHZNGTDZf6klwuusyfBVMQ9P32ZhHx092k0Tbso8zP75WO9VQRYzUqzctJP+ECEzi5fHPKCZ8V1GCSeLRCfARfrAvMhNeFjbjdf2C1xPt0CnJHU4pmvqEOmqSODuBQrOljGfmIOXIDIYn59Fjet2WyF1GyW6kUHplP8SUx9BRS5gBmmJQ2kEV39xXOAGZQc+2R3NJ6KiWcr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(82310400005)(5660300002)(86362001)(6916009)(70206006)(8676002)(36860700001)(356005)(70586007)(316002)(30864003)(426003)(8936002)(41300700001)(54906003)(6666004)(4326008)(47076005)(82740400003)(40460700003)(34020700004)(2616005)(2906002)(36756003)(336012)(7696005)(16526019)(81166007)(186003)(1076003)(26005)(478600001)(40480700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 22:09:09.6384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ca4ea0-befa-4cda-0bc2-08da612e7baa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0266
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

IRQ services to support DCN 3.1.4 interrupts.

Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../dc/irq/dcn314/irq_service_dcn314.c        | 434 ++++++++++++++++++
 .../dc/irq/dcn314/irq_service_dcn314.h        |  35 ++
 2 files changed, 469 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.h

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
new file mode 100644
index 000000000000..bea6f157cbb7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: MIT
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
+
+#include "dcn/dcn_3_1_4_offset.h"
+#include "dcn/dcn_3_1_4_sh_mask.h"
+
+#include "irq_service_dcn314.h"
+
+#include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
+
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+
+enum dc_irq_source to_dal_irq_source_dcn314(
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
+	(BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+			reg ## block ## id ## _ ## reg_name)
+
+#define SRI_DMUB(reg_name)\
+	(BASE(reg ## reg_name ## _BASE_IDX) + \
+			reg ## reg_name)
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
+irq_source_info_dcn314[DAL_IRQ_SOURCES_NUMBER] = {
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
+static const struct irq_service_funcs irq_service_funcs_dcn314 = {
+		.to_dal_irq_source = to_dal_irq_source_dcn314
+};
+
+static void dcn314_irq_construct(
+	struct irq_service *irq_service,
+	struct irq_service_init_data *init_data)
+{
+	dal_irq_service_construct(irq_service, init_data);
+
+	irq_service->info = irq_source_info_dcn314;
+	irq_service->funcs = &irq_service_funcs_dcn314;
+}
+
+struct irq_service *dal_irq_service_dcn314_create(
+	struct irq_service_init_data *init_data)
+{
+	struct irq_service *irq_service = kzalloc(sizeof(*irq_service),
+						  GFP_KERNEL);
+
+	if (!irq_service)
+		return NULL;
+
+	dcn314_irq_construct(irq_service, init_data);
+	return irq_service;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.h b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.h
new file mode 100644
index 000000000000..1f73d2b242f5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: MIT */
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
+#ifndef __DAL_IRQ_SERVICE_DCN314_H__
+#define __DAL_IRQ_SERVICE_DCN314_H__
+
+#include "../irq_service.h"
+
+struct irq_service *dal_irq_service_dcn314_create(
+	struct irq_service_init_data *init_data);
+
+#endif /* __DAL_IRQ_SERVICE_DCN314_H__ */
-- 
2.35.3

