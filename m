Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2CAC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 17:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7158D61212
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 17:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7158D61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C9C6E039;
	Fri, 17 Sep 2021 17:47:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A61796E039
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 17:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAmGfXLNYLmmjmMIfUV99LCSQ56UyrJ3ZAUPDEVs37lS2ykQclpKWPyXJzEBhcvgaJXu52EhjtJyTtpVhLHTCVzNRAU9gTaf+QJIq38y0ghQpAizkAF+V8teOO7G8p/h9IRizoIYRQ0yWvdh+/I0EzH2nBi3tkmOP2YMhgMFTVgPzx7wNE5VSCBq0Jj4AwT+tmo0uw1/5A4fUoEsgCIWCdbaecQJejofU3LEJrD61vHv6nONW8KsB+8lloR53ZhUhOQ88ERmSDKpY6DFWByOPhpL/ftHxEm2fXeh+8pUcAdQQsDgaA5Xufmm+XBhgRDEFOmb43P+PvkofC+PKYcBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=6ciS+Zwnm1phzzU11dJ4EknTVU9U3XbvIdhW1Ia6PV0=;
 b=nASo3ofzXN+ULg+IrrEIXCT4Gc2jTwTCkqDU3Wzv0AMbkltwj+1Qs758YfuufIRDN9f98bw6tLyyXRRN3j+bx8xCX0g1u8DG7Q7irpFkDWqUtU6yGJshmkdVUhPjRFxS6Hlbwoe4Z+BE1a4KAvMTFd5vyNQAUoE/lwCrBIX9VRd8/i8g2++Ha+sAz+9bW9CBi1frgkNBkG77QXzPYaVH/12GoaNOAo/FU2/qxxqHZqTmrcinD3bMRITtKBr4W7KWuTFtirZYlNELaBlZiSJdZwL6hf3wOlL8S6XX3wdxw8iroHHyN+yX4wNGcU+kfeIj1z2KJkZjYKYsB+eoe+hkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ciS+Zwnm1phzzU11dJ4EknTVU9U3XbvIdhW1Ia6PV0=;
 b=RwRsyjaYkVQzruCv2/pP4sLecojVMLvoRr8WG4PvyTSWvbrNzQ6C46L/OWkmcSt53O2ENMth19eG6cihReeXbPkZqBO066pcvd+gSNs/Ijnq2S7iIcHktkqyywcdmkqT5cIHEiFWyoV3V5Zab4zhGv++pCEV+JW8zmADO10MDr0=
Received: from BN8PR04CA0005.namprd04.prod.outlook.com (2603:10b6:408:70::18)
 by BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 17:47:39 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::7a) by BN8PR04CA0005.outlook.office365.com
 (2603:10b6:408:70::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 17:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 17:47:39 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 12:47:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>
Subject: [PATCH 01/18] drm/amd/display: Extend w/a for hard hang on HPD to
 dcn20
Date: Fri, 17 Sep 2021 13:46:59 -0400
Message-ID: <20210917174716.3011466-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917174716.3011466-1-Rodrigo.Siqueira@amd.com>
References: <20210917174716.3011466-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d1ccb01-7780-4d00-b9c4-08d97a033de0
X-MS-TrafficTypeDiagnostic: BY5PR12MB3939:
X-Microsoft-Antispam-PRVS: <BY5PR12MB393913514170FE4194F5A03C98DD9@BY5PR12MB3939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjkM9fL92DuSkqOS+73nVUFVWu98rpvBFTwUuSgVUR2qp0fucFlCuNUpT9SoRhLGYDOUV+V4HikooF3UZg3I0Oe+4RshmNM8qCLrj7skxxbFtykbwbRTuerNwRfwFyyOFCzUlQLytVQZ7A9mtZFVPlVc+ztTS2QgJ7S6ZZ36VYTfVO66WREvwzYAp2DcApE6WzdvkDgR64S72Rj0u3Hjau+T09BMw++6kB+2JsE3K5VLrSMpHHUZzeW3LZWydtfxenl3vhoLxW94ISc+mNL17OdLVvA+WWpLdtbzECxnJsSM1zgutK2EmUZBBAurN95ggvxLdY6s90PLX0LOMHYGODqcJrQhLBOAOYXUv4x3tT09wQE7F4BfqqKKZERnkD2l4Z4VKKItEQib6LsnYnafF0MSPy2ylfY0PAeQ9dsGSNUj6fmzk4E//+wDPMW+Ci0T2zi++a5/um5pqrQrFjINQcc4d6tkeUpqcYThYJVPTWKmLnHUMvCZUOEbdE1S1RT3lpDx2w7549B8pNa1L5ejcp/TjKOZqKoHY+SWT11Vf5OGJKoicE9Nyxd74PCq5OBhvI6qm1+i2U73ihS+axaG+KQI8WtiwLvSEEcaCR98/wZ1rbHzPNuxru0CxZ/hOHBlU2JGBmZGWEbKlNtruTlCAfKaWnXZ+4PeN0zGKHG/1NYgWLTU0FEprD2xuWkID1qihiHBrk2vua4G7qXiLj7UF90p9bDwYa/gtqZbfkBEZ+c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(2616005)(70586007)(36756003)(5660300002)(2906002)(6666004)(83380400001)(8936002)(70206006)(186003)(86362001)(336012)(81166007)(16526019)(54906003)(1076003)(356005)(26005)(6916009)(508600001)(316002)(82310400003)(47076005)(4326008)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 17:47:39.0824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1ccb01-7780-4d00-b9c4-08d97a033de0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3939
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
HPD disable and enable sequences are not mutually exclusive on Linux.
For HPDs that spans under 1s (i.e. HPD low = 1s), part of the disable
sequence (specifically, a request to SMU to lower refclk) could come
right before the call to PHY enablement, causing DMUB to access an
irresponsive PHY and thus a hard hang on the system.

[How]
Disable 48mhz refclk off when there is any HPD status in connected state
for dcn20.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 12 ++++++++-
 .../display/dc/irq/dcn20/irq_service_dcn20.c  | 25 +++++++++++++++++++
 .../display/dc/irq/dcn20/irq_service_dcn20.h  |  2 ++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 0d01aa9f15a6..315466f5aade 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -38,6 +38,8 @@
 #include "clk/clk_11_0_0_offset.h"
 #include "clk/clk_11_0_0_sh_mask.h"
 
+#include "irq/dcn20/irq_service_dcn20.h"
+
 #undef FN
 #define FN(reg_name, field_name) \
 	clk_mgr->clk_mgr_shift->field_name, clk_mgr->clk_mgr_mask->field_name
@@ -221,6 +223,8 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool force_reset = false;
 	bool p_state_change_support;
 	int total_plane_count;
+	int irq_src;
+	uint32_t hpd_state;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
@@ -238,7 +242,13 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (dc->res_pool->pp_smu)
 		pp_smu = &dc->res_pool->pp_smu->nv_funcs;
 
-	if (display_count == 0)
+	for (irq_src = DC_IRQ_SOURCE_HPD1; irq_src <= DC_IRQ_SOURCE_HPD6; irq_src++) {
+		hpd_state = dal_get_hpd_state_dcn20(dc->res_pool->irqs, irq_src);
+		if (hpd_state)
+			break;
+	}
+
+	if (display_count == 0 && !hpd_state)
 		enter_display_off = true;
 
 	if (enter_display_off == safe_to_lower) {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
index c4b067d01895..49d87fe5c167 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
@@ -132,6 +132,31 @@ enum dc_irq_source to_dal_irq_source_dcn20(
 	}
 }
 
+uint32_t dal_get_hpd_state_dcn20(struct irq_service *irq_service, enum dc_irq_source source)
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
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
index aee4b37999f1..f60a203e7188 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.h
@@ -31,4 +31,6 @@
 struct irq_service *dal_irq_service_dcn20_create(
 	struct irq_service_init_data *init_data);
 
+uint32_t dal_get_hpd_state_dcn20(struct irq_service *irq_service, enum dc_irq_source source);
+
 #endif
-- 
2.25.1

