Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98614C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF2010E6AB;
	Wed, 25 May 2022 16:20:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D291810E2AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnqLlhC4en+AhpweHyid4Lpuee72+ISDT455+2PF0jhrm5KZ7E3pRPlfnJinNT4yFhqrrrUF50y42VO3PlCxM+wn/iVyA0YFUhU7aOewFCMaF//IKPxzI3dlVqaVX7bF/eAJNn+s8dlsHyXZqaW5qfyQV/gwwZVsw2maGPkpQsFtay/3AYZ4RjqopkXTGERIDHW9gLiMgNkfeVRJnxhGjD/AoJ3Bd3Lkfpdj0Es96cLh844IL6UltgyiIyQuHrm3OhjKENroQ5G+6/+VTVqJKHjFcOMe6NJ8MQSORV+U4y4uEwFA+h5CxveQ3cF71ub+Zj0K+zsFAREClP8a80Vuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31NFqnQywqrEb76IXhl9xdE4XVUUbTYtTBzj7MsCDg0=;
 b=MFGaeF9Z+XGTIPz6H1xhB8lVn/WRm7z23KxpsSKsJDo73YY4MPq8aeyp16uyyY4nVXvWi5o/dyBm7GUxAH7duZ6rbcoM8onXLMsR7FJBG+9v8FgFz6Vfcc/AZV5WZUUUesUiiKLePrP8Fyy33Y3vZlfB6LJ73imMnoeQxpcdNAJJbODET3EVYP124aSn/Huwbo4c0hPgKig63lt2afQaTSuwfPjZzgIgM3pYEYCguzoSBUF0rlRHVHn79koo/5pBqNMiD7YDjgJYTcc5h+0GoT9MkwzZKRNw1jjVkGZPVi9+46HRRewgoi+2a/FRAqdHG2S4Zb7peRYwQy9shQe/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31NFqnQywqrEb76IXhl9xdE4XVUUbTYtTBzj7MsCDg0=;
 b=f7WB349IXqfBDKxjbWgTiQsfAx4jFy2WIbTsBe78dgjN6rqeVTKOGbTA2m862MX47xcMdS5LTRjALEZkk6jjTZeRcKw0zp9+1lgb88OJzmgIvxyR+58XA6oVsBtPr1R8pKjKQsgKH9yzLz1+qjg/c+ZzdJUtPSFnkn6LhpUADYE=
Received: from DM6PR04CA0030.namprd04.prod.outlook.com (2603:10b6:5:334::35)
 by BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 16:20:04 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::ee) by DM6PR04CA0030.outlook.office365.com
 (2603:10b6:5:334::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
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
 2022 11:20:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/43] drm/amd/display: add GPIO changes for DCN32/321
Date: Wed, 25 May 2022 12:19:05 -0400
Message-ID: <20220525161941.2544055-7-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6537a864-561f-48dd-f6ed-08da3e6a6d42
X-MS-TrafficTypeDiagnostic: BN9PR12MB5382:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB538290AF74681661A302040FF7D69@BN9PR12MB5382.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/11fnVJMHuQtaks6HE//qC2qMdFI4TipDZLlAzrR7PVmWW3GBqHyeuYsR+oxhvZ23SgBDx9aHboALs6fzgM5vqgf0Ladb8qjdcofkR+B7RXzI5IKTXBEFw5iSXAp2JdNG8apxgmibIPRbEbmJnmkI339g+05HFKcQrAmW+LYvuxZLQM30JkH2w9bF4JzNaBzNrMThi/3NfGTVjAB2uBnUw+jMxU5Yc5vskJVbReI31TFwdtioAbg1C7iCmA7WvZJSNmjTfwU1djb3WAvzkADzqTv0i4UvEJ+Pky8i1iisvwvZD8zBaR85R4jxZo36TdevaEMkvxU4uyiaspdd1aso05kvd0e3KORW0ySowa6Fuske6/nIDnkxNgERRtfz1XeYq16Ib3cEGlrM13Yf7xvV3j/Cge3AzWxvddKqOQo3Z2vBrV86MPeRCnmcDg7DvzuRmv2XUaatBqy1LuJxI4pmLOlBzO5ADwcUwS79mP/LlVhji1fptxjFSG3Ko30BFZ7mFI4wSj+ELsBhnKMYQqkU9kOPJXTChVb1Tm3PMq7nMAeG/4/jQIE59F7ESyST8ODetaTMgABTDhx4sfO+987EVx0r3hfY5RYyLEIq4WIEmbGbzyFR1NTNQDnMfdJxrDPxnbC/xLNKwIZnWWY9n5H8bV9Y+Vz/Cnv0RS0+cXvL/tfrRwIImWbXaZxm38+N9Zf7NZiTn0581B0gsIAAVnhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(16526019)(186003)(4326008)(26005)(81166007)(30864003)(82310400005)(316002)(47076005)(426003)(336012)(2616005)(1076003)(36756003)(2906002)(83380400001)(6916009)(5660300002)(86362001)(36860700001)(54906003)(356005)(40460700003)(8936002)(508600001)(70586007)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:04.5813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6537a864-561f-48dd-f6ed-08da3e6a6d42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382
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

Add support for the GPIO changes for DCN3.2.x.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |   8 +-
 .../display/dc/gpio/dcn32/hw_factory_dcn32.c  | 255 +++++++++++++
 .../hw_factory_dcn32.h}                       |  13 +-
 .../dc/gpio/dcn32/hw_translate_dcn32.c        | 349 ++++++++++++++++++
 .../hw_translate_dcn32.h}                     |  11 +-
 .../dc/gpio/diagnostics/hw_factory_diag.c     |  62 ----
 .../dc/gpio/diagnostics/hw_translate_diag.c   |  41 --
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |  16 +-
 .../drm/amd/display/dc/gpio/hw_translate.c    |  13 +-
 .../display/dc/irq/dcn32/irq_service_dcn32.c  |   2 +
 10 files changed, 630 insertions(+), 140 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
 rename drivers/gpu/drm/amd/display/dc/gpio/{diagnostics/hw_factory_diag.h => dcn32/hw_factory_dcn32.h} (81%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.c
 rename drivers/gpu/drm/amd/display/dc/gpio/{diagnostics/hw_translate_diag.h => dcn32/hw_translate_dcn32.h} (82%)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
index 0f4a22be8c40..bc47481a158e 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
@@ -115,10 +115,10 @@ AMD_DAL_GPIO_DCN315 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn315/,$(GPIO_DCN315))
 AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN315)
 
 ###############################################################################
-# Diagnostics on FPGA
+# DCN 3.2
 ###############################################################################
-GPIO_DIAG_FPGA = hw_translate_diag.o hw_factory_diag.o
+GPIO_DCN32 = hw_translate_dcn32.o hw_factory_dcn32.o
 
-AMD_DAL_GPIO_DIAG_FPGA = $(addprefix $(AMDDALPATH)/dc/gpio/diagnostics/,$(GPIO_DIAG_FPGA))
+AMD_DAL_GPIO_DCN32 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn32/,$(GPIO_DCN32))
 
-AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DIAG_FPGA)
+AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN32)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
new file mode 100644
index 000000000000..d635b73af46f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
@@ -0,0 +1,255 @@
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
+#include "hw_factory_dcn32.h"
+
+#include "dcn/dcn_3_2_0_offset.h"
+#include "dcn/dcn_3_2_0_sh_mask.h"
+
+#include "reg_helper.h"
+#include "../hpd_regs.h"
+
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+
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
+		BASE(reg ## reg_name ## _BASE_IDX) + reg ## reg_name
+
+#define SF_HPD(reg_name, field_name, post_fix)\
+	.field_name = HPD0_ ## reg_name ## __ ## field_name ## post_fix
+
+#define REGI(reg_name, block, id)\
+	BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+				reg ## block ## id ## _ ## reg_name
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
+	{
+			DDC_GPIO_VGA_REG_LIST(DATA),
+			.ddc_setup = 0,
+			.phy_aux_cntl = 0,
+			.dc_gpio_aux_ctrl_5 = 0
+	}
+};
+
+static const struct ddc_registers ddc_clk_regs_dcn[] = {
+	ddc_clk_regs_dcn2(1),
+	ddc_clk_regs_dcn2(2),
+	ddc_clk_regs_dcn2(3),
+	ddc_clk_regs_dcn2(4),
+	ddc_clk_regs_dcn2(5),
+	{
+			DDC_GPIO_VGA_REG_LIST(CLK),
+			.ddc_setup = 0,
+			.phy_aux_cntl = 0,
+			.dc_gpio_aux_ctrl_5 = 0
+	}
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
+ * dal_hw_factory_dcn32_init
+ *
+ * @brief
+ * Initialize HW factory function pointers and pin info
+ *
+ * @param
+ * struct hw_factory *factory - [out] struct of function pointers
+ */
+void dal_hw_factory_dcn32_init(struct hw_factory *factory)
+{
+	factory->number_of_pins[GPIO_ID_DDC_DATA] = 6;
+	factory->number_of_pins[GPIO_ID_DDC_CLOCK] = 6;
+	factory->number_of_pins[GPIO_ID_GENERIC] = 4;
+	factory->number_of_pins[GPIO_ID_HPD] = 5;
+	factory->number_of_pins[GPIO_ID_GPIO_PAD] = 28;
+	factory->number_of_pins[GPIO_ID_VIP_PAD] = 0;
+	factory->number_of_pins[GPIO_ID_SYNC] = 0;
+	factory->number_of_pins[GPIO_ID_GSL] = 0;/*add this*/
+
+	factory->funcs = &funcs;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.h
similarity index 81%
rename from drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h
rename to drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.h
index bf68eb1d9a1d..71138d0e192b 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.h
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2013-16 Advanced Micro Devices, Inc.
+ * Copyright 2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -22,13 +22,10 @@
  * Authors: AMD
  *
  */
-
-#ifndef __DAL_HW_FACTORY_DIAG_FPGA_H__
-#define __DAL_HW_FACTORY_DIAG_FPGA_H__
-
-struct hw_factory;
+#ifndef __DAL_HW_FACTORY_DCN32_H__
+#define __DAL_HW_FACTORY_DCN32_H__
 
 /* Initialize HW factory function pointers and pin info */
-void dal_hw_factory_diag_fpga_init(struct hw_factory *factory);
+void dal_hw_factory_dcn32_init(struct hw_factory *factory);
 
-#endif /* __DAL_HW_FACTORY_DIAG_FPGA_H__ */
+#endif /* __DAL_HW_FACTORY_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.c
new file mode 100644
index 000000000000..8493b9981f9e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.c
@@ -0,0 +1,349 @@
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
+/*
+ * Pre-requisites: headers required by header of this unit
+ */
+#include "hw_translate_dcn32.h"
+
+#include "dm_services.h"
+#include "include/gpio_types.h"
+#include "../hw_translate.h"
+
+#include "dcn/dcn_3_2_0_offset.h"
+#include "dcn/dcn_3_2_0_sh_mask.h"
+
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+
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
+		BASE(reg ## reg_name ## _BASE_IDX) + reg ## reg_name
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
+	case REG(DC_GPIO_DDCVGA_A):
+		*en = GPIO_DDC_LINE_DDC_VGA;
+		return true;
+	default:
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
+		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1DATA_A_MASK;
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
+		info->mask = DC_GPIO_DDC1_A__DC_GPIO_DDC1CLK_A_MASK;
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
+ * dal_hw_translate_dcn32_init
+ *
+ * @brief
+ * Initialize Hw translate function pointers.
+ *
+ * @param
+ * struct hw_translate *tr - [out] struct of function pointers
+ *
+ */
+void dal_hw_translate_dcn32_init(struct hw_translate *tr)
+{
+	tr->funcs = &funcs;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.h b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.h
similarity index 82%
rename from drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.h
rename to drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.h
index 4f053241fe96..af64e104d84c 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.h
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2013-16 Advanced Micro Devices, Inc.
+ * Copyright 2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -22,13 +22,12 @@
  * Authors: AMD
  *
  */
-
-#ifndef __DAL_HW_TRANSLATE_DIAG_FPGA_H__
-#define __DAL_HW_TRANSLATE_DIAG_FPGA_H__
+#ifndef __DAL_HW_TRANSLATE_DCN32_H__
+#define __DAL_HW_TRANSLATE_DCN32_H__
 
 struct hw_translate;
 
 /* Initialize Hw translate function pointers */
-void dal_hw_translate_diag_fpga_init(struct hw_translate *tr);
+void dal_hw_translate_dcn32_init(struct hw_translate *tr);
 
-#endif /* __DAL_HW_TRANSLATE_DIAG_FPGA_H__ */
+#endif /* __DAL_HW_TRANSLATE_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c
deleted file mode 100644
index c6e28f6bf1a2..000000000000
--- a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright 2013-16 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-/*
- * Pre-requisites: headers required by header of this unit
- */
-
-#include "dm_services.h"
-#include "hw_factory_diag.h"
-#include "include/gpio_types.h"
-#include "../hw_factory.h"
-
-/*
- * Header of this unit
- */
-
-#include "../hw_gpio.h"
-#include "../hw_ddc.h"
-#include "../hw_hpd.h"
-#include "../hw_generic.h"
-
-/* function table */
-static const struct hw_factory_funcs funcs = {
-	.init_ddc_data = NULL,
-	.init_generic = NULL,
-	.init_hpd = NULL,
-};
-
-void dal_hw_factory_diag_fpga_init(struct hw_factory *factory)
-{
-	factory->number_of_pins[GPIO_ID_DDC_DATA] = 8;
-	factory->number_of_pins[GPIO_ID_DDC_CLOCK] = 8;
-	factory->number_of_pins[GPIO_ID_GENERIC] = 7;
-	factory->number_of_pins[GPIO_ID_HPD] = 6;
-	factory->number_of_pins[GPIO_ID_GPIO_PAD] = 31;
-	factory->number_of_pins[GPIO_ID_VIP_PAD] = 0;
-	factory->number_of_pins[GPIO_ID_SYNC] = 2;
-	factory->number_of_pins[GPIO_ID_GSL] = 4;
-	factory->funcs = &funcs;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c
deleted file mode 100644
index e5138a5a8eb5..000000000000
--- a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Copyright 2013-16 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#include "dm_services.h"
-#include "hw_translate_diag.h"
-#include "include/gpio_types.h"
-
-#include "../hw_translate.h"
-
-/* function table */
-static const struct hw_translate_funcs funcs = {
-	.offset_to_id = NULL,
-	.id_to_offset = NULL,
-};
-
-void dal_hw_translate_diag_fpga_init(struct hw_translate *tr)
-{
-	tr->funcs = &funcs;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index ef4f69612097..9756640411b9 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -53,23 +53,13 @@
 #include "dcn21/hw_factory_dcn21.h"
 #include "dcn30/hw_factory_dcn30.h"
 #include "dcn315/hw_factory_dcn315.h"
-
-#include "diagnostics/hw_factory_diag.h"
-
-/*
- * This unit
- */
+#include "dcn32/hw_factory_dcn32.h"
 
 bool dal_hw_factory_init(
 	struct hw_factory *factory,
 	enum dce_version dce_version,
 	enum dce_environment dce_environment)
 {
-	if (IS_FPGA_MAXIMUS_DC(dce_environment)) {
-		dal_hw_factory_diag_fpga_init(factory);
-		return true;
-	}
-
 	switch (dce_version) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
 	case DCE_VERSION_6_0:
@@ -118,6 +108,10 @@ bool dal_hw_factory_init(
 	case DCN_VERSION_3_15:
 		dal_hw_factory_dcn315_init(factory);
 		return true;
+	case DCN_VERSION_3_2:
+	case DCN_VERSION_3_21:
+		dal_hw_factory_dcn32_init(factory);
+		return true;
 	default:
 		ASSERT_CRITICAL(false);
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 1db4f1414d7e..82aad7bc0300 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -51,8 +51,7 @@
 #include "dcn21/hw_translate_dcn21.h"
 #include "dcn30/hw_translate_dcn30.h"
 #include "dcn315/hw_translate_dcn315.h"
-
-#include "diagnostics/hw_translate_diag.h"
+#include "dcn32/hw_translate_dcn32.h"
 
 /*
  * This unit
@@ -63,11 +62,6 @@ bool dal_hw_translate_init(
 	enum dce_version dce_version,
 	enum dce_environment dce_environment)
 {
-	if (IS_FPGA_MAXIMUS_DC(dce_environment)) {
-		dal_hw_translate_diag_fpga_init(translate);
-		return true;
-	}
-
 	switch (dce_version) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
 	case DCE_VERSION_6_0:
@@ -113,7 +107,10 @@ bool dal_hw_translate_init(
 	case DCN_VERSION_3_15:
 		dal_hw_translate_dcn315_init(translate);
 		return true;
-
+	case DCN_VERSION_3_2:
+	case DCN_VERSION_3_21:
+		dal_hw_translate_dcn32_init(translate);
+		return true;
 	default:
 		BREAK_TO_DEBUGGER();
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
index 5c87057a6abc..3f9d6531c563 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
@@ -34,6 +34,8 @@
 
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+
 enum dc_irq_source to_dal_irq_source_dcn32(
 		struct irq_service *irq_service,
 		uint32_t src_id,
-- 
2.35.3

