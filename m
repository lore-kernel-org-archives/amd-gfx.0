Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5CDC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 16:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8359E10EE4D;
	Fri, 18 Feb 2022 16:59:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D25310E2BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 16:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjT+3YVbsifdo0S2+HESjQpJLbBCNt7XiBXgybSxozhidex9ot3vrUmmH73vk1/31hEQZd4Wpl9RMrpAJMVtQvA9TxSjxZVYcfL92qBTarBBWLG3QQkNrabhH5W69l5hl9Y13uqpdAsS/EfrDEr9/UjkWscscMVCU2zkQob6dUcEdPRRSc7KrSE10MpHGswbsu0rVj7Orss89IujCLANVkp1ZxW0KsHFMCzFuoSoRnXoCh3nPV7vRo0+CrpBMc3FFHyP7hp6hQV6kbhDQLQaCwfd76Y7PxxwzUN7NYmjUC1QpW836IuL/HEnw0WwnPw6HRre3EvGQFjamc/nB1o40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+D+H/hAyM9+1hsBQSfRZrlAVooYQyg0Vfr87itPb54=;
 b=Ug8JBJuu9XaxMQMe3fLx0m8ksiKvGtMkpH5F8+41cwdZo1g6fGXnsanXNNcUYVBt4Q2qEfI/lA0SHMauakYLM5tI6u5SDaCwCYj4359sODhAJp4btJ9IJgbbxSTqYIPPJAH2cHStFS0Eet258EcME6Na8+s7Het+niGv1xOitgVT6IDoz58g4qiD2bBaQccrqjfmu2lRR/Rmc4meej9ebyhO303BKf0XCQ9podBEM0g+mjGXhVjw/u66dd8L/++BBcBwv3mor0XkOWIRvqDDf3NP4I77VuHF3xZbNN87mZ9dAKTjxaocbiru9J2O8mLZJJOOajR2yd2PVbUTpojyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+D+H/hAyM9+1hsBQSfRZrlAVooYQyg0Vfr87itPb54=;
 b=WdrYDKIU0CPEuBNlZZJi6BuNRA2Okyua9DinrsfQFaH1EFnTXfcpyr+b/Ej8IHnRiwZdQS9+FALrxeYi8Lw9LuZbJoVvqTnF4SceLOQ/HFx33vyFWao3wOapfXilU2R7b6pCB3a0QSvs3JmMuRp6ujWNmMR7HjE8dz6ntCtM+Jw=
Received: from MW4PR04CA0354.namprd04.prod.outlook.com (2603:10b6:303:8a::29)
 by BN6PR12MB1746.namprd12.prod.outlook.com (2603:10b6:404:104::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Fri, 18 Feb
 2022 16:59:13 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::a2) by MW4PR04CA0354.outlook.office365.com
 (2603:10b6:303:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Fri, 18 Feb 2022 16:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:59:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:59:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amd/display: Add DCN315 GPIO
Date: Fri, 18 Feb 2022 11:58:46 -0500
Message-ID: <20220218165854.1417733-4-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 712aef9b-d481-4644-0229-08d9f2fffcf0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1746:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1746F54CE18309C93A3D45BAF7379@BN6PR12MB1746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYX6YhTGKxZp5S/u7g8NkXJm5zt0LlzTB4SWlAwej2xdnZMNS34k8ZKqZcOfaqkj5E/q61ZFiwEfTRxTAYN1CGVVBzNjLFPZ9mqGzd5FCslTzqzdROQp8EfnV/SG9NTJN7KUWQ/nUmgcojstqBlHEJNY6+OkOhNYzwArmrwG+ynRea0TezXtU0Ujg/ApC23/bma5ctN4n/yhuPqbRKLCMquAtK3Y5VtZI+s2nBgWp4UDdHeqVJxB9o2QUR8K2KbUXtJet8LZS/TFe61oyHf3vKl3YqdwZ3oBPdQLWJdNufy/IN8GBXg5bs7oBGD/5yw5+6Ys5r7gQKIxGzzcQvpHgEvmw1k8aQdwibK/2XCwVhXNNf+RjsiYrfLun6r/FZYpl0FvVBKUvoOs2hAdy3JKhSkBU1zU+bfQRx2TXg34fWIIEdpDQF0TBrpT8VotKslEt29oqGDJLT2PvyhxC3joEF1lpat4rjY6MGqijUBwDEedGoZeQvMZxn6Ag3YRbvB7/KQiEbPlGlR63SzhcbJhwMdXE13z27oxa1rF6Ffwkodf77WxUHFC+rsbJKkgDlgYReBIu5UFDZZLSlFizvjvuepMg+P8JIZ4XRg2VvyjAl9sGMPHBhjuivfkDXc1IYsxDegnyPUUSPonoQSu7Gk5E6sN/WdbS8m4SpNREjsut8OI5QvbT0PjHVTVSuP2LiBA0x3KH//lguqoP+K95rOUXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(8676002)(81166007)(26005)(186003)(356005)(16526019)(4326008)(5660300002)(426003)(40460700003)(30864003)(336012)(508600001)(8936002)(86362001)(316002)(83380400001)(47076005)(6666004)(70586007)(70206006)(2616005)(7696005)(54906003)(36756003)(1076003)(36860700001)(2906002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:59:12.1774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712aef9b-d481-4644-0229-08d9f2fffcf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1746
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

Add GPIO interfaces for DCN 3.1.5.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |   8 +
 .../dc/gpio/dcn315/hw_factory_dcn315.c        | 260 ++++++++++++
 .../dc/gpio/dcn315/hw_factory_dcn315.h        |  31 ++
 .../dc/gpio/dcn315/hw_translate_dcn315.c      | 374 ++++++++++++++++++
 .../dc/gpio/dcn315/hw_translate_dcn315.h      |  33 ++
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |   4 +
 7 files changed, 714 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.h

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
index a1bf2128feba..e2ab98228a79 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
@@ -107,6 +107,14 @@ AMD_DAL_GPIO_DCN30 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn30/,$(GPIO_DCN30))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN30)
 
+###############################################################################
+# DCN 3.15
+###############################################################################
+GPIO_DCN315 = hw_translate_dcn315.o hw_factory_dcn315.o
+
+AMD_DAL_GPIO_DCN315 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn315/,$(GPIO_DCN315))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN315)
 endif
 ###############################################################################
 # Diagnostics on FPGA
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
new file mode 100644
index 000000000000..5feebb3b95ca
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
@@ -0,0 +1,260 @@
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
+#include "hw_factory_dcn315.h"
+
+#include "dcn/dcn_3_1_5_offset.h"
+#include "dcn/dcn_3_1_5_sh_mask.h"
+
+#include "reg_helper.h"
+#include "../hpd_regs.h"
+/* begin *********************
+ * macros to expend register list macro defined in HW object header file */
+
+#define DCN_BASE__INST0_SEG0                       0x00000012
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+#define DCN_BASE__INST0_SEG3                       0x00009000
+#define DCN_BASE__INST0_SEG4                       0x02403C00
+#define DCN_BASE__INST0_SEG5                       0
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
+ * dal_hw_factory_dcn10_init
+ *
+ * @brief
+ * Initialize HW factory function pointers and pin info
+ *
+ * @param
+ * struct hw_factory *factory - [out] struct of function pointers
+ */
+void dal_hw_factory_dcn315_init(struct hw_factory *factory)
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
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.h b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.h
new file mode 100644
index 000000000000..ffa71fa41cd4
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.h
@@ -0,0 +1,31 @@
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
+#ifndef __DAL_HW_FACTORY_DCN315_H__
+#define __DAL_HW_FACTORY_DCN315_H__
+
+/* Initialize HW factory function pointers and pin info */
+void dal_hw_factory_dcn315_init(struct hw_factory *factory);
+
+#endif /* __DAL_HW_FACTORY_DCN315_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.c
new file mode 100644
index 000000000000..fbdaba57f718
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.c
@@ -0,0 +1,374 @@
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
+#include "hw_translate_dcn315.h"
+
+#include "dm_services.h"
+#include "include/gpio_types.h"
+#include "../hw_translate.h"
+
+#include "dcn/dcn_3_1_5_offset.h"
+#include "dcn/dcn_3_1_5_sh_mask.h"
+
+/* begin *********************
+ * macros to expend register list macro defined in HW object header file */
+
+#define DCN_BASE__INST0_SEG0                       0x00000012
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+#define DCN_BASE__INST0_SEG3                       0x00009000
+#define DCN_BASE__INST0_SEG4                       0x02403C00
+#define DCN_BASE__INST0_SEG5                       0
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
+	 * directly in the create method
+	 */
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
+
+/*
+ *	case REG(DC_GPIO_I2CPAD_A): not exit
+ *	case REG(DC_GPIO_PWRSEQ_A):
+ *	case REG(DC_GPIO_PAD_STRENGTH_1):
+ *	case REG(DC_GPIO_PAD_STRENGTH_2):
+ *	case REG(DC_GPIO_DEBUG):
+ */
+	/* UNEXPECTED */
+	default:
+/*	case REG(DC_GPIO_SYNCA_A): not exist */
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
+ * dal_hw_translate_dcn30_init
+ *
+ * @brief
+ * Initialize Hw translate function pointers.
+ *
+ * @param
+ * struct hw_translate *tr - [out] struct of function pointers
+ *
+ */
+void dal_hw_translate_dcn315_init(struct hw_translate *tr)
+{
+	tr->funcs = &funcs;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.h b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.h
new file mode 100644
index 000000000000..d58def4884b2
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.h
@@ -0,0 +1,33 @@
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
+#ifndef __DAL_HW_TRANSLATE_DCN315_H__
+#define __DAL_HW_TRANSLATE_DCN315_H__
+
+struct hw_translate;
+
+/* Initialize Hw translate function pointers */
+void dal_hw_translate_dcn315_init(struct hw_translate *tr);
+
+#endif /* __DAL_HW_TRANSLATE_DCN315_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index c9ee212b2e80..5c00ffde3996 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -53,6 +53,7 @@
 #include "dcn20/hw_factory_dcn20.h"
 #include "dcn21/hw_factory_dcn21.h"
 #include "dcn30/hw_factory_dcn30.h"
+#include "dcn315/hw_factory_dcn315.h"
 #endif
 
 #include "diagnostics/hw_factory_diag.h"
@@ -117,6 +118,9 @@ bool dal_hw_factory_init(
 	case DCN_VERSION_3_16:
 		dal_hw_factory_dcn30_init(factory);
 		return true;
+	case DCN_VERSION_3_15:
+		dal_hw_factory_dcn315_init(factory);
+		return true;
 #endif
 	default:
 		ASSERT_CRITICAL(false);
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 42adba630125..7a39cbc01f63 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -51,6 +51,7 @@
 #include "dcn20/hw_translate_dcn20.h"
 #include "dcn21/hw_translate_dcn21.h"
 #include "dcn30/hw_translate_dcn30.h"
+#include "dcn315/hw_translate_dcn315.h"
 #endif
 
 #include "diagnostics/hw_translate_diag.h"
@@ -112,6 +113,9 @@ bool dal_hw_translate_init(
 	case DCN_VERSION_3_16:
 		dal_hw_translate_dcn30_init(translate);
 		return true;
+	case DCN_VERSION_3_15:
+		dal_hw_translate_dcn315_init(translate);
+		return true;
 #endif
 
 	default:
-- 
2.35.1

