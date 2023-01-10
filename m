Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B35C678D6
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB0E10E608;
	Tue, 10 Jan 2023 16:57:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1481610E609
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltTevhgCoaBflxDURxBCyjIZ60e0I7DFF/47h9+eY119G7Xd20fvrMP1i3ozr3PpW2sozuTOCt2ezMkRm14VONKszVDepnrN6FP498dVSR4Gk5hJX0INC2+2jk41gVnLcS9rQPU946+urfO3HZi/B9qD6WszT5Q0eCUHoY/cEDLAwA7nGKCN0IkrkiQrKpzZoaAlkTLr1aiRTbHc2/BQfvnd64zxKSqR+O6ZhldEsW79qvSd6lsuvfMeDYcm9fzFTsSTV/mPplYRHPjaH0Kwm0XRy48DDrYl93H9vgqRivDHcimlii77rMRZzxstg6AMwx4c/sYz8oml6TLuhirvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTSjGbhxNOeKYufLpCH4DcGbtEfgn4l+aWajdCBelI4=;
 b=Vg7hXXRMCb5xj6pGTN6xjTnh8eKCzHOyEePreTRdyXNF2iXz0/lYjbM/vHIaC4m5RhI6eXnQNtSRWJ5JUU7OT36EgWTt1IP63g85INNHdXQc+8biFA90dK2o9TcZ5zSk0yYKi9ryq0fqYXdxZXXjdECH6JMvEp+y3BudpQMF6lBm9ii15XRunnMXNELIVixAwPMXGzR28l80ESjOafkHWBMFriuwjRhfzJ1HpqlLMsGQ8KXeOw0SRylLKinmxUn75GrWfSErBYq2JFj9444sunqHe7Kh2YPuoB+CDRryWKUSSZSzIvNt0VuMZXsSH25z3hxOQ5fF6sHZMpTOVjIGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTSjGbhxNOeKYufLpCH4DcGbtEfgn4l+aWajdCBelI4=;
 b=DaNIWD9Y10E7pkxeESswOGsMdg+BNSNG1IQcR9v5qr5/ylT4qvVNGxZ+AXuNurMNOklOILosavKAv+ZYSRZ5WLy4TG0s5LK3xd4CfRTsbdPtc5BSPpIfTYrY3vuOImdhE95KiEWw+upfECNoKoI8vuQvwKuHPuAv+LbNkj4L53Q=
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:57:05 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::de) by MW4PR04CA0210.outlook.office365.com
 (2603:10b6:303:86::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:57:04 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:56:48 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/37] drm/amd/display: refactor hpd logic from dc_link to
 link_hpd
Date: Tue, 10 Jan 2023 11:55:04 -0500
Message-ID: <20230110165535.3358492-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|MN2PR12MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a291ab9-12f3-4bfe-0aa5-08daf32bb3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlez/UHpNi42+T5GRh6TUblWwWYc/btMyWjwrhs8nVhgxU5NGIrDg1xcavibic/5a5kMSHQ+uRByTDgf0ymfo63Yo5RQoI+QNwVh/wIVrSI70itogvN0rK0InUKqdjBgANz7LnCy0YkwN6ARkIfCS4q/BhmKjwRg/cS1ATPfxM87PhIbQIEp05HgxlxonrN7BTmI2lGgedCwg/ZlaYIcMfCiivyMMBSWNuVl8fVnug/B6A0aK2T3shNN8gKYLZUMuMgNxjBhhi3MeNUdKnvXoQWT9CIedseE2vTZeB4ZBtqgITOyKq5YK9LoQqHW7wyFXF5DUtGrc+TI/Z1pXe1Y+UCvh4jbHQwsq+MSwLgjeG5BR5w+sjig+0h5cIODTRK4GJw0YrKuYweLcm+X8YyIR4H00/mVNhND4n8rbfmKy+ccjnURjLiYzAlUVusG3PQqOGGXS+IOynXoz9z6RBDvUplAuImQunJC1nc64sAZtKXjBilzFUbDVavuIr4HR7Pu5qk7ZcBKGTbQoqRYuHq5scmnIA4noTn658adM6uhBgh5uE1TP3IYB5A30vOhVjkiIKeyD+6UUwWiO4E5moQMu4CiahwyPrRLNUL2LKDCLqKr2x/LoY9eDwD6tIEyD5CqLTDOcVG5FW97VXlQV8Lrjvyo4ECqZOctCt1JOZeznsX7OEzGvnoR0qe0QEC2/bDeVnnl6rg7+2EXJgjS1N4qrRLE4GRnZFyes2c2NWFE3qs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(356005)(81166007)(8676002)(54906003)(86362001)(6916009)(70206006)(83380400001)(4326008)(70586007)(40460700003)(41300700001)(426003)(5660300002)(2906002)(8936002)(316002)(2616005)(1076003)(82310400005)(40480700001)(336012)(30864003)(16526019)(186003)(26005)(47076005)(6666004)(7696005)(36860700001)(478600001)(66899015)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:57:04.8414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a291ab9-12f3-4bfe-0aa5-08daf32bb3ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Factor out hpd handling logic from generic dc link file.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 224 +---------------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  16 --
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  22 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  47 ++++
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   3 +-
 .../gpu/drm/amd/display/dc/link/link_hpd.c    | 240 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/link/link_hpd.h    |  47 ++++
 8 files changed, 357 insertions(+), 245 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hpd.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hpd.h

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ee20b4d3afd4..13e33f581e73 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -36,6 +36,7 @@
 #include "dc_link_dpia.h"
 #include "dc_link_ddc.h"
 #include "link_hwss.h"
+#include "link.h"
 #include "opp.h"
 
 #include "link_encoder.h"
@@ -52,6 +53,7 @@
 #include "inc/link_enc_cfg.h"
 #include "inc/link_dpcd.h"
 #include "link/link_dp_trace.h"
+#include "link/link_hpd.h"
 
 #include "dc/dcn30/dcn30_vpg.h"
 
@@ -102,108 +104,6 @@ static void dc_link_destruct(struct dc_link *link)
 		dc_sink_release(link->remote_sinks[i]);
 }
 
-struct gpio *get_hpd_gpio(struct dc_bios *dcb,
-			  struct graphics_object_id link_id,
-			  struct gpio_service *gpio_service)
-{
-	enum bp_result bp_result;
-	struct graphics_object_hpd_info hpd_info;
-	struct gpio_pin_info pin_info;
-
-	if (dcb->funcs->get_hpd_info(dcb, link_id, &hpd_info) != BP_RESULT_OK)
-		return NULL;
-
-	bp_result = dcb->funcs->get_gpio_pin_info(dcb,
-		hpd_info.hpd_int_gpio_uid, &pin_info);
-
-	if (bp_result != BP_RESULT_OK) {
-		ASSERT(bp_result == BP_RESULT_NORECORD);
-		return NULL;
-	}
-
-	return dal_gpio_service_create_irq(gpio_service,
-					   pin_info.offset,
-					   pin_info.mask);
-}
-
-/*
- *  Function: program_hpd_filter
- *
- *  @brief
- *     Programs HPD filter on associated HPD line
- *
- *  @param [in] delay_on_connect_in_ms: Connect filter timeout
- *  @param [in] delay_on_disconnect_in_ms: Disconnect filter timeout
- *
- *  @return
- *     true on success, false otherwise
- */
-static bool program_hpd_filter(const struct dc_link *link)
-{
-	bool result = false;
-	struct gpio *hpd;
-	int delay_on_connect_in_ms = 0;
-	int delay_on_disconnect_in_ms = 0;
-
-	if (link->is_hpd_filter_disabled)
-		return false;
-	/* Verify feature is supported */
-	switch (link->connector_signal) {
-	case SIGNAL_TYPE_DVI_SINGLE_LINK:
-	case SIGNAL_TYPE_DVI_DUAL_LINK:
-	case SIGNAL_TYPE_HDMI_TYPE_A:
-		/* Program hpd filter */
-		delay_on_connect_in_ms = 500;
-		delay_on_disconnect_in_ms = 100;
-		break;
-	case SIGNAL_TYPE_DISPLAY_PORT:
-	case SIGNAL_TYPE_DISPLAY_PORT_MST:
-		/* Program hpd filter to allow DP signal to settle */
-		/* 500:	not able to detect MST <-> SST switch as HPD is low for
-		 * only 100ms on DELL U2413
-		 * 0: some passive dongle still show aux mode instead of i2c
-		 * 20-50: not enough to hide bouncing HPD with passive dongle.
-		 * also see intermittent i2c read issues.
-		 */
-		delay_on_connect_in_ms = 80;
-		delay_on_disconnect_in_ms = 0;
-		break;
-	case SIGNAL_TYPE_LVDS:
-	case SIGNAL_TYPE_EDP:
-	default:
-		/* Don't program hpd filter */
-		return false;
-	}
-
-	/* Obtain HPD handle */
-	hpd = get_hpd_gpio(link->ctx->dc_bios, link->link_id,
-			   link->ctx->gpio_service);
-
-	if (!hpd)
-		return result;
-
-	/* Setup HPD filtering */
-	if (dal_gpio_open(hpd, GPIO_MODE_INTERRUPT) == GPIO_RESULT_OK) {
-		struct gpio_hpd_config config;
-
-		config.delay_on_connect = delay_on_connect_in_ms;
-		config.delay_on_disconnect = delay_on_disconnect_in_ms;
-
-		dal_irq_setup_hpd_filter(hpd, &config);
-
-		dal_gpio_close(hpd);
-
-		result = true;
-	} else {
-		ASSERT_CRITICAL(false);
-	}
-
-	/* Release HPD handle */
-	dal_gpio_destroy_irq(&hpd);
-
-	return result;
-}
-
 bool dc_link_wait_for_t12(struct dc_link *link)
 {
 	if (link->connector_signal == SIGNAL_TYPE_EDP && link->dc->hwss.edp_wait_for_T12) {
@@ -226,7 +126,6 @@ bool dc_link_wait_for_t12(struct dc_link *link)
 bool dc_link_detect_sink(struct dc_link *link, enum dc_connection_type *type)
 {
 	uint32_t is_hpd_high = 0;
-	struct gpio *hpd_pin;
 
 	if (link->connector_signal == SIGNAL_TYPE_LVDS) {
 		*type = dc_connection_single;
@@ -250,17 +149,9 @@ bool dc_link_detect_sink(struct dc_link *link, enum dc_connection_type *type)
 		return true;
 	}
 
-	/* todo: may need to lock gpio access */
-	hpd_pin = get_hpd_gpio(link->ctx->dc_bios, link->link_id,
-			       link->ctx->gpio_service);
-	if (!hpd_pin)
+	if (!query_hpd_status(link, &is_hpd_high))
 		goto hpd_gpio_failure;
 
-	dal_gpio_open(hpd_pin, GPIO_MODE_INTERRUPT);
-	dal_gpio_get_value(hpd_pin, &is_hpd_high);
-	dal_gpio_close(hpd_pin);
-	dal_gpio_destroy_irq(&hpd_pin);
-
 	if (is_hpd_high) {
 		*type = dc_connection_single;
 		/* TODO: need to do the actual detection */
@@ -1367,58 +1258,6 @@ bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
 	return is_local_sink_detect_success && !is_delegated_to_mst_top_mgr;
 }
 
-bool dc_link_get_hpd_state(struct dc_link *dc_link)
-{
-	uint32_t state;
-
-	dal_gpio_lock_pin(dc_link->hpd_gpio);
-	dal_gpio_get_value(dc_link->hpd_gpio, &state);
-	dal_gpio_unlock_pin(dc_link->hpd_gpio);
-
-	return state;
-}
-
-static enum hpd_source_id get_hpd_line(struct dc_link *link)
-{
-	struct gpio *hpd;
-	enum hpd_source_id hpd_id;
-
-	hpd_id = HPD_SOURCEID_UNKNOWN;
-
-	hpd = get_hpd_gpio(link->ctx->dc_bios, link->link_id,
-			   link->ctx->gpio_service);
-
-	if (hpd) {
-		switch (dal_irq_get_source(hpd)) {
-		case DC_IRQ_SOURCE_HPD1:
-			hpd_id = HPD_SOURCEID1;
-		break;
-		case DC_IRQ_SOURCE_HPD2:
-			hpd_id = HPD_SOURCEID2;
-		break;
-		case DC_IRQ_SOURCE_HPD3:
-			hpd_id = HPD_SOURCEID3;
-		break;
-		case DC_IRQ_SOURCE_HPD4:
-			hpd_id = HPD_SOURCEID4;
-		break;
-		case DC_IRQ_SOURCE_HPD5:
-			hpd_id = HPD_SOURCEID5;
-		break;
-		case DC_IRQ_SOURCE_HPD6:
-			hpd_id = HPD_SOURCEID6;
-		break;
-		default:
-			BREAK_TO_DEBUGGER();
-		break;
-		}
-
-		dal_gpio_destroy_irq(&hpd);
-	}
-
-	return hpd_id;
-}
-
 static enum channel_id get_ddc_line(struct dc_link *link)
 {
 	struct ddc *ddc;
@@ -1583,7 +1422,7 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 	if (link->dc->res_pool->funcs->link_init)
 		link->dc->res_pool->funcs->link_init(link);
 
-	link->hpd_gpio = get_hpd_gpio(link->ctx->dc_bios, link->link_id,
+	link->hpd_gpio = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
 				      link->ctx->gpio_service);
 
 	if (link->hpd_gpio) {
@@ -4531,51 +4370,6 @@ void core_link_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 	dc->hwss.set_avmute(pipe_ctx, enable);
 }
 
-/**
- *  dc_link_enable_hpd_filter:
- *     If enable is true, programs HPD filter on associated HPD line using
- *     delay_on_disconnect/delay_on_connect values dependent on
- *     link->connector_signal
- *
- *     If enable is false, programs HPD filter on associated HPD line with no
- *     delays on connect or disconnect
- *
- *  @link:   pointer to the dc link
- *  @enable: boolean specifying whether to enable hbd
- */
-void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
-{
-	struct gpio *hpd;
-
-	if (enable) {
-		link->is_hpd_filter_disabled = false;
-		program_hpd_filter(link);
-	} else {
-		link->is_hpd_filter_disabled = true;
-		/* Obtain HPD handle */
-		hpd = get_hpd_gpio(link->ctx->dc_bios, link->link_id, link->ctx->gpio_service);
-
-		if (!hpd)
-			return;
-
-		/* Setup HPD filtering */
-		if (dal_gpio_open(hpd, GPIO_MODE_INTERRUPT) == GPIO_RESULT_OK) {
-			struct gpio_hpd_config config;
-
-			config.delay_on_connect = 0;
-			config.delay_on_disconnect = 0;
-
-			dal_irq_setup_hpd_filter(hpd, &config);
-
-			dal_gpio_close(hpd);
-		} else {
-			ASSERT_CRITICAL(false);
-		}
-		/* Release HPD handle */
-		dal_gpio_destroy_irq(&hpd);
-	}
-}
-
 void dc_link_set_drive_settings(struct dc *dc,
 				struct link_training_settings *lt_settings,
 				const struct dc_link *link)
@@ -4663,16 +4457,6 @@ void dc_link_set_preferred_training_settings(struct dc *dc,
 		dc_link_set_preferred_link_settings(dc, &link->preferred_link_setting, link);
 }
 
-void dc_link_enable_hpd(const struct dc_link *link)
-{
-	dc_link_dp_enable_hpd(link);
-}
-
-void dc_link_disable_hpd(const struct dc_link *link)
-{
-	dc_link_dp_disable_hpd(link);
-}
-
 void dc_link_set_test_pattern(struct dc_link *link,
 			      enum dp_test_pattern test_pattern,
 			      enum dp_test_pattern_color_space test_pattern_color_space,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d74ffc89810f..51945593f74b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5866,22 +5866,6 @@ void detect_edp_sink_caps(struct dc_link *link)
 			sizeof(link->dpcd_caps.alpm_caps.raw));
 }
 
-void dc_link_dp_enable_hpd(const struct dc_link *link)
-{
-	struct link_encoder *encoder = link->link_enc;
-
-	if (encoder != NULL && encoder->funcs->enable_hpd != NULL)
-		encoder->funcs->enable_hpd(encoder);
-}
-
-void dc_link_dp_disable_hpd(const struct dc_link *link)
-{
-	struct link_encoder *encoder = link->link_enc;
-
-	if (encoder != NULL && encoder->funcs->enable_hpd != NULL)
-		encoder->funcs->disable_hpd(encoder);
-}
-
 static bool is_dp_phy_pattern(enum dp_test_pattern test_pattern)
 {
 	if ((DP_TEST_PATTERN_PHY_PATTERN_BEGIN <= test_pattern &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 1226ecb625b4..fbd6f11a63db 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -479,10 +479,6 @@ enum link_training_result dc_link_dp_sync_lt_attempt(
 
 bool dc_link_dp_sync_lt_end(struct dc_link *link, bool link_down);
 
-void dc_link_dp_enable_hpd(const struct dc_link *link);
-
-void dc_link_dp_disable_hpd(const struct dc_link *link);
-
 bool dc_link_dp_set_test_pattern(
 	struct dc_link *link,
 	enum dp_test_pattern test_pattern,
@@ -493,6 +489,21 @@ bool dc_link_dp_set_test_pattern(
 
 bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap);
 
+/**
+ *****************************************************************************
+ *  Function: dc_link_enable_hpd_filter
+ *
+ *  @brief
+ *     If enable is true, programs HPD filter on associated HPD line to default
+ *     values dependent on link->connector_signal
+ *
+ *     If enable is false, programs HPD filter on associated HPD line with no
+ *     delays on connect or disconnect
+ *
+ *  @param [in] link: pointer to the dc link
+ *  @param [in] enable: boolean specifying whether to enable hbd
+ *****************************************************************************
+ */
 void dc_link_enable_hpd_filter(struct dc_link *link, bool enable);
 
 bool dc_link_is_dp_sink_present(struct dc_link *link);
@@ -565,9 +576,6 @@ void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map);
 /* restore link resource allocation state from a snapshot */
 void dc_restore_link_res_map(const struct dc *dc, uint32_t *map);
 void dc_link_clear_dprx_states(struct dc_link *link);
-struct gpio *get_hpd_gpio(struct dc_bios *dcb,
-		struct graphics_object_id link_id,
-		struct gpio_service *gpio_service);
 void dp_trace_reset(struct dc_link *link);
 bool dc_dp_trace_is_initialized(struct dc_link *link);
 unsigned long long dc_dp_trace_get_lt_end_timestamp(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 16e3b079fc56..358431f0d98a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -46,6 +46,7 @@
 #include "link_encoder.h"
 #include "link_enc_cfg.h"
 #include "link_hwss.h"
+#include "link.h"
 #include "dc_link_dp.h"
 #include "dccg.h"
 #include "clock_source.h"
@@ -737,7 +738,7 @@ void dce110_edp_wait_for_hpd_ready(
 
 	/* obtain HPD */
 	/* TODO what to do with this? */
-	hpd = get_hpd_gpio(ctx->dc_bios, connector, ctx->gpio_service);
+	hpd = link_get_hpd_gpio(ctx->dc_bios, connector, ctx->gpio_service);
 
 	if (!hpd) {
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
new file mode 100644
index 000000000000..51ddf7a34d98
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -0,0 +1,47 @@
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
+#ifndef __DC_LINK_H__
+#define __DC_LINK_H__
+
+/* FILE POLICY AND INTENDED USAGE:
+ *
+ * This header declares link functions exposed to dc. All functions must have
+ * "link_" as prefix. For example link_run_my_function. This header is strictly
+ * private in dc and should never be included in other header files. dc
+ * components should include this header in their .c files in order to access
+ * functions in link folder. This file should never include any header files in
+ * link folder. If there is a need to expose a function declared in one of
+ * header files in side link folder, you need to move the function declaration
+ * into this file and prefix it with "link_".
+ */
+#include "core_types.h"
+#include "dc_link.h"
+
+struct gpio *link_get_hpd_gpio(struct dc_bios *dcb,
+		struct graphics_object_id link_id,
+		struct gpio_service *gpio_service);
+
+#endif /* __DC_LINK_HPD_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index 054c2a727eb2..835a2febf2db 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -23,7 +23,8 @@
 # It abstracts the control and status of back end pipe such as DIO, HPO, DPIA,
 # PHY, HPD, DDC and etc).
 
-LINK = link_hwss_dio.o link_hwss_dpia.o link_hwss_hpo_dp.o link_dp_trace.o
+LINK = link_hwss_dio.o link_hwss_dpia.o link_hwss_hpo_dp.o link_dp_trace.o \
+link_hpd.o
 
 AMD_DAL_LINK = $(addprefix $(AMDDALPATH)/dc/link/,$(LINK))
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hpd.c b/drivers/gpu/drm/amd/display/dc/link/link_hpd.c
new file mode 100644
index 000000000000..5f39dfe06e9a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hpd.c
@@ -0,0 +1,240 @@
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
+/* FILE POLICY AND INTENDED USAGE:
+ *
+ * This file implements functions that manage basic HPD components such as gpio.
+ * It also provides wrapper functions to execute HPD related programming. This
+ * file only manages basic HPD functionality. It doesn't manage detection or
+ * feature or signal specific HPD behaviors.
+ */
+#include "link_hpd.h"
+#include "gpio_service_interface.h"
+
+bool dc_link_get_hpd_state(struct dc_link *dc_link)
+{
+	uint32_t state;
+
+	dal_gpio_lock_pin(dc_link->hpd_gpio);
+	dal_gpio_get_value(dc_link->hpd_gpio, &state);
+	dal_gpio_unlock_pin(dc_link->hpd_gpio);
+
+	return state;
+}
+
+void dc_link_enable_hpd(const struct dc_link *link)
+{
+	struct link_encoder *encoder = link->link_enc;
+
+	if (encoder != NULL && encoder->funcs->enable_hpd != NULL)
+		encoder->funcs->enable_hpd(encoder);
+}
+
+void dc_link_disable_hpd(const struct dc_link *link)
+{
+	struct link_encoder *encoder = link->link_enc;
+
+	if (encoder != NULL && encoder->funcs->enable_hpd != NULL)
+		encoder->funcs->disable_hpd(encoder);
+}
+
+void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
+{
+	struct gpio *hpd;
+
+	if (enable) {
+		link->is_hpd_filter_disabled = false;
+		program_hpd_filter(link);
+	} else {
+		link->is_hpd_filter_disabled = true;
+		/* Obtain HPD handle */
+		hpd = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id, link->ctx->gpio_service);
+
+		if (!hpd)
+			return;
+
+		/* Setup HPD filtering */
+		if (dal_gpio_open(hpd, GPIO_MODE_INTERRUPT) == GPIO_RESULT_OK) {
+			struct gpio_hpd_config config;
+
+			config.delay_on_connect = 0;
+			config.delay_on_disconnect = 0;
+
+			dal_irq_setup_hpd_filter(hpd, &config);
+
+			dal_gpio_close(hpd);
+		} else {
+			ASSERT_CRITICAL(false);
+		}
+		/* Release HPD handle */
+		dal_gpio_destroy_irq(&hpd);
+	}
+}
+
+struct gpio *link_get_hpd_gpio(struct dc_bios *dcb,
+			  struct graphics_object_id link_id,
+			  struct gpio_service *gpio_service)
+{
+	enum bp_result bp_result;
+	struct graphics_object_hpd_info hpd_info;
+	struct gpio_pin_info pin_info;
+
+	if (dcb->funcs->get_hpd_info(dcb, link_id, &hpd_info) != BP_RESULT_OK)
+		return NULL;
+
+	bp_result = dcb->funcs->get_gpio_pin_info(dcb,
+		hpd_info.hpd_int_gpio_uid, &pin_info);
+
+	if (bp_result != BP_RESULT_OK) {
+		ASSERT(bp_result == BP_RESULT_NORECORD);
+		return NULL;
+	}
+
+	return dal_gpio_service_create_irq(gpio_service,
+					   pin_info.offset,
+					   pin_info.mask);
+}
+
+bool query_hpd_status(struct dc_link *link, uint32_t *is_hpd_high)
+{
+	struct gpio *hpd_pin = link_get_hpd_gpio(
+			link->ctx->dc_bios, link->link_id,
+			link->ctx->gpio_service);
+	if (!hpd_pin)
+		return false;
+
+	dal_gpio_open(hpd_pin, GPIO_MODE_INTERRUPT);
+	dal_gpio_get_value(hpd_pin, is_hpd_high);
+	dal_gpio_close(hpd_pin);
+	dal_gpio_destroy_irq(&hpd_pin);
+	return true;
+}
+
+enum hpd_source_id get_hpd_line(struct dc_link *link)
+{
+	struct gpio *hpd;
+	enum hpd_source_id hpd_id;
+
+		hpd_id = HPD_SOURCEID_UNKNOWN;
+
+	hpd = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
+			   link->ctx->gpio_service);
+
+	if (hpd) {
+		switch (dal_irq_get_source(hpd)) {
+		case DC_IRQ_SOURCE_HPD1:
+			hpd_id = HPD_SOURCEID1;
+		break;
+		case DC_IRQ_SOURCE_HPD2:
+			hpd_id = HPD_SOURCEID2;
+		break;
+		case DC_IRQ_SOURCE_HPD3:
+			hpd_id = HPD_SOURCEID3;
+		break;
+		case DC_IRQ_SOURCE_HPD4:
+			hpd_id = HPD_SOURCEID4;
+		break;
+		case DC_IRQ_SOURCE_HPD5:
+			hpd_id = HPD_SOURCEID5;
+		break;
+		case DC_IRQ_SOURCE_HPD6:
+			hpd_id = HPD_SOURCEID6;
+		break;
+		default:
+			BREAK_TO_DEBUGGER();
+		break;
+		}
+
+		dal_gpio_destroy_irq(&hpd);
+	}
+
+	return hpd_id;
+}
+
+bool program_hpd_filter(const struct dc_link *link)
+{
+	bool result = false;
+	struct gpio *hpd;
+	int delay_on_connect_in_ms = 0;
+	int delay_on_disconnect_in_ms = 0;
+
+	if (link->is_hpd_filter_disabled)
+		return false;
+	/* Verify feature is supported */
+	switch (link->connector_signal) {
+	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+	case SIGNAL_TYPE_DVI_DUAL_LINK:
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+		/* Program hpd filter */
+		delay_on_connect_in_ms = 500;
+		delay_on_disconnect_in_ms = 100;
+		break;
+	case SIGNAL_TYPE_DISPLAY_PORT:
+	case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		/* Program hpd filter to allow DP signal to settle */
+		/* 500:	not able to detect MST <-> SST switch as HPD is low for
+		 * only 100ms on DELL U2413
+		 * 0: some passive dongle still show aux mode instead of i2c
+		 * 20-50: not enough to hide bouncing HPD with passive dongle.
+		 * also see intermittent i2c read issues.
+		 */
+		delay_on_connect_in_ms = 80;
+		delay_on_disconnect_in_ms = 0;
+		break;
+	case SIGNAL_TYPE_LVDS:
+	case SIGNAL_TYPE_EDP:
+	default:
+		/* Don't program hpd filter */
+		return false;
+	}
+
+	/* Obtain HPD handle */
+	hpd = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
+			   link->ctx->gpio_service);
+
+	if (!hpd)
+		return result;
+
+	/* Setup HPD filtering */
+	if (dal_gpio_open(hpd, GPIO_MODE_INTERRUPT) == GPIO_RESULT_OK) {
+		struct gpio_hpd_config config;
+
+		config.delay_on_connect = delay_on_connect_in_ms;
+		config.delay_on_disconnect = delay_on_disconnect_in_ms;
+
+		dal_irq_setup_hpd_filter(hpd, &config);
+
+		dal_gpio_close(hpd);
+
+		result = true;
+	} else {
+		ASSERT_CRITICAL(false);
+	}
+
+	/* Release HPD handle */
+	dal_gpio_destroy_irq(&hpd);
+
+	return result;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hpd.h b/drivers/gpu/drm/amd/display/dc/link/link_hpd.h
new file mode 100644
index 000000000000..3d122def0c88
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hpd.h
@@ -0,0 +1,47 @@
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
+#ifndef __DC_LINK_HPD_H__
+#define __DC_LINK_HPD_H__
+#include "link.h"
+
+enum hpd_source_id get_hpd_line(struct dc_link *link);
+/*
+ *  Function: program_hpd_filter
+ *
+ *  @brief
+ *     Programs HPD filter on associated HPD line to default values.
+ *
+ *  @return
+ *     true on success, false otherwise
+ */
+bool program_hpd_filter(const struct dc_link *link);
+/* Query hot plug status of USB4 DP tunnel.
+ * Returns true if HPD high.
+ */
+bool dpia_query_hpd_status(struct dc_link *link);
+bool query_hpd_status(struct dc_link *link, uint32_t *is_hpd_high);
+#endif /* __DC_LINK_HPD_H__ */
-- 
2.39.0

