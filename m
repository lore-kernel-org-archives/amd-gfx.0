Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0EFC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB5660E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BB5660E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E48C6E1E8;
	Wed,  8 Sep 2021 14:55:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989396E1D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3juIjl4g1/8GlYuppUPj49SbpJorCicBi7jJpafnNNHYW3nc/3ZsALo822tXvuNVmbskYUAr3fCv/CddFed8kNzjNfzx9CwfWWOQxSKnfDyibbGQqDPBQGs2Bj/qRgwpqEPE1Hm46m3c9SUWiXtloA+H5JrOQ4hUDUVQq8IQf+YQUC3AOWQwHyL3UDZRMgvrJz8x9QN7+F63mXNePPyWx+m+lPdZ2MG+oBljBEKfQzqCjKYCIvHJ2HfjZpzJQAWbPwnxvj1MklO80QbbRgh/umdncqCiC2RGRVq+OokTxV/LCDKntAi+Jlocaefc9uQPOjJbHYBatJ/0uwhzsJJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=OQjjCsZ5rIZApBuB4Ecr3YLeThtseIKv50KE5u8sfj8=;
 b=D4lFHozAr4d97Y1b3zy69Q3aklI1zEUR4kF4um0JrNoUGWTqqpg2eiZxJlHB6vmzRs6w42cYeSkt3Y8+Q0iZIjtBlyn1BIH9E9AHRJ5FIWkDZW8emXEWpv44FV/gvyMc4f6dJkg2MTRGtfmj3lW6Xk8rRhPrmCXr5juC2v/f9FVxUbxSHw3XOdMynuUZDGeF06kbUJXWpjDD01SGyNo0H2LGVZ9CN+njO+1rOua46zCTyQ9q1xeVyEIiNmw/B4S1pptJM20LipRQpPSz+WuFjOgjKXhD7MfWnBBONFluIJ43+XBcI0hPAhkLxn0ycgTen7SeE6xalm+Vez7mkmNIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQjjCsZ5rIZApBuB4Ecr3YLeThtseIKv50KE5u8sfj8=;
 b=E0nDP+RmfbiwbwxF8GKjRTV64+Cb6XBb0UqkizDF8+kUDnNSWybUEWmWLUgkkjSwrDO5DtPqvq3J09SdApi66Y9+YjVc0BZJCMKvkmt7VTOvQfxLS63foBe4TNHjjDFzbebit3sYO0D8I9RonFOlnSHayI7NvGg31N2+g4p4nYk=
Received: from DS7PR06CA0021.namprd06.prod.outlook.com (2603:10b6:8:2a::23) by
 MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Wed, 8 Sep 2021 14:54:59 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::57) by DS7PR06CA0021.outlook.office365.com
 (2603:10b6:8:2a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:59 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:57 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Hersen Wu <hersenwu@amd.com>
Subject: [PATCH 19/33] drm/amd/display: Apply w/a for hard hang on HPD
Date: Wed, 8 Sep 2021 10:54:10 -0400
Message-ID: <20210908145424.3311-20-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3737fe27-081f-4234-b601-08d972d8a15c
X-MS-TrafficTypeDiagnostic: MW3PR12MB4492:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4492082B51D9A3AC6B4AF793E4D49@MW3PR12MB4492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGYAOtfzCutlqRlXLw7JADUpgmEd8i/Cg3b+m3gur9DkkIQvaLMd05ld6CEF3sfdbJWPAxnmWcghWIum8Uo+52Y5mXE/7SXBECI/zexr0CLuTG2FwkRnny7/ioSqTVwZYdZ+LehDe+2BipUmZ61qUC7aTDH83+PV01xYyez8H8+J3BzdyN15EV1ed+Geg9nzyrIPVqxzFq9HoZUdHrNJeNxw/79fjk8Xc7c6l9RJQkk/L2/leDnwHTUPb249oZ7VDxhCFY7RglpL46dvsAEd1zvWsYJSYUyhg+H6vEpuoZbfyir8bkF5GcZ0nYxdRYnEYKBxBZC31sk0jFWn7j4G/xIJX0qEpw+x1YHKMcqqqKhWtI6hdS/Ize9ybsi92mng/4UX19zu1MzBJMy0PbLYnoD4rpLouIrq109LfYiIx4xNw55l0ZbnnSdFu17+YXv2idPFofVAm69XvTDEduS6xGG2/PqTf+ai0V6sdmRTY62k4GJzZfZ7lw95g7Zn/gP31+SfUpuUv2U7b5Cuy8GE7WG/nvK2iBynQUgvzjV/5p7TK3swJtATAj3kH8RJlYNNy1bhZ9cK9fkEQI6pbeb6lcIanJkmZ3l6Jw+FhMYEFHppZJAiRSQMg28Hx8ekxnKw7eWS9a1eKeal3WdYQ5/EOyBYtqdMjHRt1NsMSpxVvQfS4fj84sR+7OU1xqvvOKRusMF7JkMfdetPLiy35xAHilncsaZLrX5LLW+UXm9YR7w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(46966006)(316002)(83380400001)(54906003)(86362001)(47076005)(44832011)(36860700001)(2906002)(356005)(36756003)(478600001)(81166007)(82740400003)(82310400003)(4326008)(26005)(16526019)(186003)(8676002)(70206006)(426003)(336012)(70586007)(8936002)(2616005)(6666004)(6916009)(1076003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:59.4366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3737fe27-081f-4234-b601-08d972d8a15c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
HPD disable and enable sequences are not mutually exclusive
on Linux. For HPDs that spans under 1s (i.e. HPD low = 1s),
part of the disable sequence (specifically, a request to SMU
to lower refclk) could come right before the call to PHY
enablement, causing DMUB to access an irresponsive PHY
and thus a hard hang on the system.

[How]
Disable 48mhz refclk off when there is any HPD status in
connected state.

Reviewed-by: Hersen Wu <hersenwu@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 12 ++++++++-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  | 25 +++++++++++++++++++
 .../display/dc/irq/dcn21/irq_service_dcn21.h  |  2 ++
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |  2 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |  4 +++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index c6f494f0dcea..3fabf32a0558 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -42,6 +42,7 @@
 #include "clk/clk_10_0_2_sh_mask.h"
 #include "renoir_ip_offset.h"
 
+#include "irq/dcn21/irq_service_dcn21.h"
 
 /* Constants */
 
@@ -129,9 +130,11 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int display_count;
+	int irq_src;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
+	uint32_t hpd_state;
 
 	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
 
@@ -147,8 +150,15 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
 
 			display_count = rn_get_active_display_cnt_wa(dc, context);
+
+			for (irq_src = DC_IRQ_SOURCE_HPD1; irq_src <= DC_IRQ_SOURCE_HPD5; irq_src++) {
+				hpd_state = dal_get_hpd_state_dcn21(dc->res_pool->irqs, irq_src);
+				if (hpd_state)
+					break;
+			}
+
 			/* if we can go lower, go lower */
-			if (display_count == 0) {
+			if (display_count == 0 && !hpd_state) {
 				rn_vbios_smu_set_dcn_low_power_state(clk_mgr, DCN_PWR_STATE_LOW_POWER);
 				/* update power state */
 				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index ed54e1c819be..685528734575 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -135,6 +135,31 @@ enum dc_irq_source to_dal_irq_source_dcn21(
 	return DC_IRQ_SOURCE_INVALID;
 }
 
+uint32_t dal_get_hpd_state_dcn21(struct irq_service *irq_service, enum dc_irq_source source)
+{
+	const struct irq_source_info *info;
+	uint32_t addr;
+	uint32_t value;
+	uint32_t current_status;
+
+	info = find_irq_source_info(irq_service, source);
+	if (!info)
+		return 0;
+
+	addr = info->status_reg;
+	if (!addr)
+		return 0;
+
+	value = dm_read_reg(irq_service->ctx, addr);
+	current_status =
+		get_reg_field_value(
+			value,
+			HPD0_DC_HPD_INT_STATUS,
+			DC_HPD_SENSE);
+
+	return current_status;
+}
+
 static bool hpd_ack(
 	struct irq_service *irq_service,
 	const struct irq_source_info *info)
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
index da2bd0e93d7a..3df2ceeb2b70 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.h
@@ -31,4 +31,6 @@
 struct irq_service *dal_irq_service_dcn21_create(
 	struct irq_service_init_data *init_data);
 
+uint32_t dal_get_hpd_state_dcn21(struct irq_service *irq_service, enum dc_irq_source source);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index a2a4fbeb83f8..4db1133e4466 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -79,7 +79,7 @@ void dal_irq_service_destroy(struct irq_service **irq_service)
 	*irq_service = NULL;
 }
 
-static const struct irq_source_info *find_irq_source_info(
+const struct irq_source_info *find_irq_source_info(
 	struct irq_service *irq_service,
 	enum dc_irq_source source)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
index dbfcb096eedd..e60b82480093 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
@@ -69,6 +69,10 @@ struct irq_service {
 	const struct irq_service_funcs *funcs;
 };
 
+const struct irq_source_info *find_irq_source_info(
+	struct irq_service *irq_service,
+	enum dc_irq_source source);
+
 void dal_irq_service_construct(
 	struct irq_service *irq_service,
 	struct irq_service_init_data *init_data);
-- 
2.25.1

