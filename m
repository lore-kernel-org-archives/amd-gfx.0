Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF37C2D0A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0593206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c0OLOs3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0593206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4248A6EB57;
	Fri,  6 Nov 2020 23:19:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D856EB53
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b93hQ1hZRpfLn4//a4cdv0PTP6FSGCj0Vv7MVXyK6zVzJhuV6Ck3SbYoOalAz2WHtyKN+qZ8Xv/k8y9Rt+snR+AfrBuqumupOBW7kHc4EZXlp6U7iPYmvVrAywUc78UQLQSSe/7CYzdpfvs4dEtgllXQDpWurHB1eHyjK0ewTXC7WmUDazuDqrcKy9ZzkyjKHLUTRsnHSpWwK9baS7OUgo9A4OCHRiOzsPmJz0vBEWOgifC5vPAWnSENfw5ArwzWKpMmbWSrABakfT3SKHssZqxveqvZi+dQhD/1reVf6daUOdx29G+yyoW+G6U1QplnYAO2/3QhA9lNp/MYUHkqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYjyUMFLXtp89lo1qVhzq+NYQfeefpVSdgY0PEkOjAM=;
 b=KJU1CjWD10jfsecFsQ+gnj/G/4ZG+aKbke6f+olCPKcnWzfNNAjmUbpwNl5JNeyT+lOi5vjsOBb2Mh72+nUTajonYD1jzvgWYzN8cRDOy82TEPqaT2OK1GGh0QvZXcCxofwiBIWqNUp0XQsBMvd9gMfvWIZ6K4U3SB0nK7ruCFYVBJ1Uuv6Fqjl9/SYaVZLQIn2/orXLYUrnEcvmyRx3ZSmEfJXdNn9U9Flqt4fxNcSR2IloEJnoTIR4bsMfylS+D+kB7Lu2iQuwL8wuzio00PA5zG675vACQ2xgxz9PP+s3oqGRUssY65EzIUhN4TUIZho29/RWomjUXn13ZRQv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYjyUMFLXtp89lo1qVhzq+NYQfeefpVSdgY0PEkOjAM=;
 b=c0OLOs3gckwaN20UlYfMCnUE+NRsZm4AIMBnCz4ZyIGJbha/Pj3pUyU+uuwBGlHwXwlDVh9TkhFx8RTRmbbczFY6Y2M7mbWi1bW6u6aKuGmNu+m7DuMXijBOsEw3id8HLGzGuRuK8be6QQQJx1gnNkQz/3SCItcFgcGOsAUTllM=
Received: from MW2PR2101CA0020.namprd21.prod.outlook.com (2603:10b6:302:1::33)
 by MWHPR12MB1277.namprd12.prod.outlook.com (2603:10b6:300:f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 23:19:30 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::c3) by MW2PR2101CA0020.outlook.office365.com
 (2603:10b6:302:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:29 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:29 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:28 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: update dpp dto phase and modulo.
Date: Fri, 6 Nov 2020 18:17:04 -0500
Message-ID: <20201106231710.1290392-9-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee82a190-697d-4788-ebbf-08d882aa699c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1277:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1277AE219CA3051127B42CE3F5ED0@MWHPR12MB1277.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcReo8k85hQEz1IiNq/ZZjf262R+iQOVdWjgvihoa3ldoCc0k8KjFtrccWG6U03/8rl/6uTaNlPNSH/RW210SXsTsa8DqXH1pbOtMTWGTezNpw4exKU6RWde7Zbj0s+zCBrmxlhyIgIFWt44rhjzqg2K28OV7eZGHa34gE706YEoWDkGQP4w5vQAjuciNrXC0OjhZBU1UF525pqJ3cz1TxG5DnKb9wOqi40FnyvV33o6fA7ze0fK706LodOtovJJQ1uQXVe3p9EdbT29gw8yaX1MV9buzIbVRrwthuHNtliz4FLM95y2vapQpYecapG3XKefUfA/1MwDJs4MUeJ1Vb0i7cu/H8k5Vsmi1iwlmsv/3I1k+vAXE7e7Ok/bFpVp5FHacqxLckSukjSgVFbFhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966005)(81166007)(70206006)(4326008)(1076003)(83380400001)(2906002)(47076004)(82740400003)(70586007)(336012)(7696005)(15650500001)(5660300002)(6666004)(54906003)(426003)(36756003)(186003)(2616005)(316002)(26005)(6916009)(82310400003)(478600001)(8676002)(8936002)(86362001)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:29.8939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee82a190-697d-4788-ebbf-08d882aa699c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1277
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Program modulo with ref dpp clk Mhz/10.
Program phase with pipe dpp clk Mhz /10.
DMUB FW could use these value to determine optimization clk
for PSR power saving.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c | 125 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h |  36 +++++
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   3 +-
 5 files changed, 166 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index c42d2f4e81e8..f30f3fdba433 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -158,10 +158,8 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
 	// Do not adjust dppclk if dppclk is 0 to avoid unexpected result
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-		if (new_clocks->dppclk_khz < 100000 && new_clocks->dppclk_khz > 0)
-			new_clocks->dppclk_khz = 100000;
-	}
+	if (new_clocks->dppclk_khz < 100000 && new_clocks->dppclk_khz > 0)
+		new_clocks->dppclk_khz = 100000;
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index 51a2f3d4c194..1ee5fc03b7b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -3,7 +3,7 @@
 # Makefile for DCN21.
 
 DCN21 = dcn21_init.o dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o \
-	 dcn21_hwseq.o dcn21_link_encoder.o
+	 dcn21_hwseq.o dcn21_link_encoder.o dcn21_dccg.o
 
 ifdef CONFIG_X86
 CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
new file mode 100644
index 000000000000..f9e3a2337fbf
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
@@ -0,0 +1,125 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
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
+#include "reg_helper.h"
+#include "core_types.h"
+#include "dcn20/dcn20_dccg.h"
+#include "dcn21_dccg.h"
+
+#define TO_DCN_DCCG(dccg)\
+	container_of(dccg, struct dcn_dccg, base)
+
+#define REG(reg) \
+	(dccg_dcn->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	dccg_dcn->dccg_shift->field_name, dccg_dcn->dccg_mask->field_name
+
+#define CTX \
+	dccg_dcn->base.ctx
+#define DC_LOGGER \
+	dccg->ctx->logger
+
+void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg->ref_dppclk) {
+		int ref_dppclk = dccg->ref_dppclk;
+		int modulo = ref_dppclk / 10000;
+
+		if (req_dppclk) {
+			int phase;
+
+			/*
+			 * program DPP DTO phase and modulo as below
+			 * phase = dpp_pipe_clk_mhz / 10
+			 * module = dpp_global_clk_mhz / 10
+			 * dmub FW will read phase value to
+			 * determine minimum dpp clk and notify smu
+			 * to set clks for more power saving in PSR state
+			 */
+			phase = (req_dppclk + 9999) / 10000;
+
+			if (phase > 0xff) {
+				ASSERT(false);
+				phase = 0xff;
+			}
+
+			REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+					DPPCLK0_DTO_PHASE, phase,
+					DPPCLK0_DTO_MODULO, modulo);
+			REG_UPDATE(DPPCLK_DTO_CTRL,
+					DPPCLK_DTO_ENABLE[dpp_inst], 1);
+		} else {
+			/*
+			 *  set phase to 10 if dpp isn't used to
+			 *  prevent hard hang if access dpp register
+			 *  on unused pipe
+			 */
+			REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+				DPPCLK0_DTO_PHASE, 10,
+				DPPCLK0_DTO_MODULO, modulo);
+
+			REG_UPDATE(DPPCLK_DTO_CTRL,
+				DPPCLK_DTO_ENABLE[dpp_inst], 0);
+		}
+	}
+
+	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
+}
+
+
+static const struct dccg_funcs dccg21_funcs = {
+	.update_dpp_dto = dccg21_update_dpp_dto,
+	.get_dccg_ref_freq = dccg2_get_dccg_ref_freq,
+	.dccg_init = dccg2_init
+};
+
+struct dccg *dccg21_create(
+	struct dc_context *ctx,
+	const struct dccg_registers *regs,
+	const struct dccg_shift *dccg_shift,
+	const struct dccg_mask *dccg_mask)
+{
+	struct dcn_dccg *dccg_dcn = kzalloc(sizeof(*dccg_dcn), GFP_KERNEL);
+	struct dccg *base;
+
+	if (dccg_dcn == NULL) {
+		BREAK_TO_DEBUGGER();
+		return NULL;
+	}
+
+	base = &dccg_dcn->base;
+	base->ctx = ctx;
+	base->funcs = &dccg21_funcs;
+
+	dccg_dcn->regs = regs;
+	dccg_dcn->dccg_shift = dccg_shift;
+	dccg_dcn->dccg_mask = dccg_mask;
+
+	return &dccg_dcn->base;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
new file mode 100644
index 000000000000..b7efa777ec73
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
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
+#ifndef __DCN21_DCCG_H__
+#define __DCN21_DCCG_H__
+
+struct dccg *dccg21_create(
+	struct dc_context *ctx,
+	const struct dccg_registers *regs,
+	const struct dccg_shift *dccg_shift,
+	const struct dccg_mask *dccg_mask);
+
+
+#endif /* __DCN21_DCCG_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index abc8af0ef141..ed3f62535301 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -58,6 +58,7 @@
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dcn20/dcn20_dccg.h"
+#include "dcn21/dcn21_dccg.h"
 #include "dcn21_hubbub.h"
 #include "dcn10/dcn10_resource.h"
 #include "dce110/dce110_resource.h"
@@ -2046,7 +2047,7 @@ static bool dcn21_resource_construct(
 		}
 	}
 
-	pool->base.dccg = dccg2_create(ctx, &dccg_regs, &dccg_shift, &dccg_mask);
+	pool->base.dccg = dccg21_create(ctx, &dccg_regs, &dccg_shift, &dccg_mask);
 	if (pool->base.dccg == NULL) {
 		dm_error("DC: failed to create dccg!\n");
 		BREAK_TO_DEBUGGER();
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
