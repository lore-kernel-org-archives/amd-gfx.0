Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E929FC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F83E10E484;
	Wed, 14 Dec 2022 20:22:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA9010E479
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh58a6+BziYdcCQLPzH6KDNYkUoz4X0oF1n+4kLmtheYd3XvjSM/anCJ7lDD+LknsmISvlU4C+iaHsIHhz6m90POjejqCWrmIuVCcL/GczhukeNzvQKtAHJqF4qxniYdDRYOQLeLQAHtnuyoe3U1AfP7r9MlQie8ep0jU1HMblEsekWvwv6mFI1BcIwGG9RkJCvj4vatQ63BwEhKlqwSP9uMez3k0Atckmof1vHnSujvfXSp+YVKLF1GeCvgBAO3h7QD7ZLL4GkgoUWT6Gdf4PxbeNfVkGVE+dUxomnXQV8et2SlbPyxHq2V/Z1q8BOJJTSAxME0svfrJCFgITpbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y649iYeuT9LW2ABRkVp+di5xuqBKAGrzqPj+a50bD8k=;
 b=Ol0ztxhmwIYGkHXAW8kbz2SNsrBj04VdNsZYhKtUZc1V/1QHY8R1r8zMKrJjBLY/vfunNrE0pT2Bzojnijya+rCLNBzOokCrIjB1tf1EEttarUoLSL9UDc4FjUx/c3MahtVW9GslfnzsDov/Ru3s4QckJglC6pUpEO/iGyFD8OLrHbtbCfPFeX8hTK+ErwUi1isB4bdUWM0dpObgJUZmPcj9cGQ3WMf4juaOVJaPapK1S8dYm5glRSkJvv7/FVB61Y62EFczaBfYGTffDbw+KgCTRi2R3RRudIMESKr0PhksqP3bAjXIHB6yxJGJCMSqvzcmMbC761VEt+Jtos2zVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y649iYeuT9LW2ABRkVp+di5xuqBKAGrzqPj+a50bD8k=;
 b=Wfe+3Epphh150bZYH/+Yb5kvyvtf879Gfpd0uu0mpIAm1a8E/reHMho3Z017MIo3InPub/q4gr1jfGvd6A5Vp+JFKOmTuPJH2bq+NLTDI4ssrhFSZdEMVcn4pO6INmr6SXAMOKzzgYqnU2Sq1Xhgxgpak5n8IDEhGPQ53SOzadI=
Received: from MW4PR03CA0102.namprd03.prod.outlook.com (2603:10b6:303:b7::17)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:22:01 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::f2) by MW4PR03CA0102.outlook.office365.com
 (2603:10b6:303:b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:00 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:55 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 12:21:55 -0800
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:21:54 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/18] drm/amd/display: Refactor ABM code flow
Date: Wed, 14 Dec 2022 15:21:29 -0500
Message-ID: <20221214202141.1721178-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: d82305e8-d95c-41fd-66ac-08dade10db88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DChDKaRp1pMFhSo3sJEbFFKwazYxrGQXxBWK094dXDRAjNxRr78Cmw213kJJ0xGaXm/VykL3KdacuXvEYLmr7fptJAhVCZi3IG65g7upirTT4ADMTkV8vCXkLHjIUXbo1+vY+5L1mtzz+BofkT8aAFAv1+7GnHgWWZRTrKpOBcU3pnQkCQpZxbbMP4Gn9yNbnW9WqEcpkiFxc136l82kWgaxceaZNnYmARxi3MjHaAUG6yId3K51rZQhFQGvcTRDP+uu++ttAsc1/FgtPeP680QsQNHuOfy8IuLAUs0v8apbBvwaM5a0Mx+L7eD7KL6Xkjrh8OWAWF5o1GY7v0Hktr7e1XUs+Vsxsumke1hD+xizctiI6iBnSm9OCvJeI6H3+yR/2pzhghdnPAT7gbY1GpD8Gm8ZrEfCoYvgduswevMutwT5qUCwnH+8Y4cYFBIjqMt4xdqOnQVGcybnLe4B0pUaOO/XUoYNHR/i8ibm72d4kYugX1BLlLZBnSERfKfH6j4O8B49bw8ci86/DDjZoVWuc1zBN42BSIpMrUX8p7/4aU6+p1uuBbHSuan5nHze6fSOafRwQeBZCySQkajMz3wOychcxkA305alUgtnANbAyFWiINtBDF6UslcZMs4lFwVkgp7iiArVl+QKMOg/a97590SvQe80ZBA1pF5mDqVHcmTqlE6DLBO35jWwukMqtp34vkYs/Zc0y/GtoXLTEcZRaSMltLj1N6dCxp3Edx4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(356005)(7696005)(40460700003)(82740400003)(478600001)(36860700001)(86362001)(81166007)(4326008)(316002)(8676002)(70586007)(26005)(2906002)(186003)(6916009)(5660300002)(44832011)(30864003)(70206006)(41300700001)(336012)(8936002)(47076005)(2616005)(1076003)(54906003)(83380400001)(40480700001)(6666004)(426003)(82310400005)(66899015)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:00.8776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82305e8-d95c-41fd-66ac-08dade10db88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
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
 Leon Huang <Leon.Huang1@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Chun-Liang Chang <chun-liang.chang@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leon Huang <Leon.Huang1@amd.com>

[Why&How]
Recent ABM flow is highly coupled with backlight control on
LCD, refactor ABM control flow to be extensible to support different
panel types(e.g. LCD/OLED/miniLED)

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Reviewed-by: Chun-Liang Chang <chun-liang.chang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 249 +++++++----------
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c | 259 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |  45 +++
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  62 ++---
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   6 +
 7 files changed, 427 insertions(+), 201 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c14205e3183f..2896157b37da 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1434,7 +1434,9 @@ union dpcd_sink_ext_caps {
 		uint8_t hdr_aux_backlight_control : 1;
 		uint8_t reserved_1 : 2;
 		uint8_t oled : 1;
-		uint8_t reserved : 3;
+		uint8_t reserved_2 : 1;
+		uint8_t miniled : 1;
+		uint8_t reserved : 1;
 	} bits;
 	uint8_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dce/Makefile b/drivers/gpu/drm/amd/display/dc/dce/Makefile
index 0d7db132a20f..31354fe57cd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce/Makefile
@@ -29,9 +29,10 @@
 DCE = dce_audio.o dce_stream_encoder.o dce_link_encoder.o dce_hwseq.o \
 dce_mem_input.o dce_clock_source.o dce_scl_filters.o dce_transform.o \
 dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o dce_aux.o \
-dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o dce_panel_cntl.o \
+dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o dmub_abm_lcd.o dce_panel_cntl.o \
 dmub_hw_lock_mgr.o dmub_outbox.o
 
+
 AMD_DAL_DCE = $(addprefix $(AMDDALPATH)/dc/dce/,$(DCE))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCE)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index fb0dec4ed3a6..e668d0315a4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -24,212 +24,153 @@
  */
 
 #include "dmub_abm.h"
-#include "dce_abm.h"
+#include "dmub_abm_lcd.h"
 #include "dc.h"
-#include "dc_dmub_srv.h"
-#include "dmub/dmub_srv.h"
 #include "core_types.h"
-#include "dm_services.h"
-#include "reg_helper.h"
-#include "fixed31_32.h"
-
-#include "atom.h"
 
 #define TO_DMUB_ABM(abm)\
 	container_of(abm, struct dce_abm, base)
 
-#define REG(reg) \
-	(dce_abm->regs->reg)
+#define ABM_FEATURE_NO_SUPPORT	0
+#define ABM_LCD_SUPPORT			1
 
-#undef FN
-#define FN(reg_name, field_name) \
-	dce_abm->abm_shift->field_name, dce_abm->abm_mask->field_name
+static unsigned int abm_feature_support(struct abm *abm, unsigned int panel_inst)
+{
+	struct dc_context *dc = abm->ctx;
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	int i;
+	int edp_num;
+	unsigned int ret = ABM_FEATURE_NO_SUPPORT;
 
-#define CTX \
-	dce_abm->base.ctx
+	get_edp_links(dc->dc, edp_links, &edp_num);
 
-#define DISABLE_ABM_IMMEDIATELY 255
+	for (i = 0; i < edp_num; i++) {
+		if (edp_links[i]->link_status.link_active
+			&& panel_inst == i)
+			break;
+	}
 
+	if (i < edp_num) {
+		ret = ABM_LCD_SUPPORT;
+	}
 
+	return ret;
+}
 
-static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
+static void dmub_abm_init_ex(struct abm *abm, uint32_t backlight)
 {
-	union dmub_rb_cmd cmd;
-	uint32_t fractional_pwm = (dc->dc->config.disable_fractional_pwm == false) ? 1 : 0;
-	uint32_t edp_id_count = dc->dc_edp_id_count;
-	int i;
-	uint8_t panel_mask = 0;
-
-	for (i = 0; i < edp_id_count; i++)
-		panel_mask |= 0x01 << i;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.abm_set_pwm_frac.header.type = DMUB_CMD__ABM;
-	cmd.abm_set_pwm_frac.header.sub_type = DMUB_CMD__ABM_SET_PWM_FRAC;
-	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.fractional_pwm = fractional_pwm;
-	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
-	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.panel_mask = panel_mask;
-	cmd.abm_set_pwm_frac.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pwm_frac_data);
-
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
-	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-	dc_dmub_srv_wait_idle(dc->dmub_srv);
+	dmub_abm_init(abm, backlight);
 }
 
-static void dmub_abm_init(struct abm *abm, uint32_t backlight)
+static unsigned int dmub_abm_get_current_backlight_ex(struct abm *abm)
 {
-	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
-
-	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x3);
-	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x1);
-	REG_WRITE(DC_ABM1_LS_SAMPLE_RATE, 0x3);
-	REG_WRITE(DC_ABM1_LS_SAMPLE_RATE, 0x1);
-	REG_WRITE(BL1_PWM_BL_UPDATE_SAMPLE_RATE, 0x1);
-
-	REG_SET_3(DC_ABM1_HG_MISC_CTRL, 0,
-			ABM1_HG_NUM_OF_BINS_SEL, 0,
-			ABM1_HG_VMAX_SEL, 1,
-			ABM1_HG_BIN_BITWIDTH_SIZE_SEL, 0);
-
-	REG_SET_3(DC_ABM1_IPCSC_COEFF_SEL, 0,
-			ABM1_IPCSC_COEFF_SEL_R, 2,
-			ABM1_IPCSC_COEFF_SEL_G, 4,
-			ABM1_IPCSC_COEFF_SEL_B, 2);
+	return dmub_abm_get_current_backlight(abm);
+}
 
-	REG_UPDATE(BL1_PWM_CURRENT_ABM_LEVEL,
-			BL1_PWM_CURRENT_ABM_LEVEL, backlight);
+static unsigned int dmub_abm_get_target_backlight_ex(struct abm *abm)
+{
+	return dmub_abm_get_target_backlight(abm);
+}
 
-	REG_UPDATE(BL1_PWM_TARGET_ABM_LEVEL,
-			BL1_PWM_TARGET_ABM_LEVEL, backlight);
+static bool dmub_abm_set_level_ex(struct abm *abm, uint32_t level)
+{
+	bool ret = false;
+	unsigned int feature_support, i;
+	uint8_t panel_mask0 = 0;
 
-	REG_UPDATE(BL1_PWM_USER_LEVEL,
-			BL1_PWM_USER_LEVEL, backlight);
+	for (i = 0; i < MAX_NUM_EDP; i++) {
+		feature_support = abm_feature_support(abm, i);
 
-	REG_UPDATE_2(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES,
-			ABM1_LS_MIN_PIXEL_VALUE_THRES, 0,
-			ABM1_LS_MAX_PIXEL_VALUE_THRES, 1000);
+		if (feature_support == ABM_LCD_SUPPORT)
+			panel_mask0 |= (0x01 << i);
+	}
 
-	REG_SET_3(DC_ABM1_HGLS_REG_READ_PROGRESS, 0,
-			ABM1_HG_REG_READ_MISSED_FRAME_CLEAR, 1,
-			ABM1_LS_REG_READ_MISSED_FRAME_CLEAR, 1,
-			ABM1_BL_REG_READ_MISSED_FRAME_CLEAR, 1);
+	if (panel_mask0)
+		ret = dmub_abm_set_level(abm, level, panel_mask0);
 
-	dmub_abm_enable_fractional_pwm(abm->ctx);
+	return ret;
 }
 
-static unsigned int dmub_abm_get_current_backlight(struct abm *abm)
+static bool dmub_abm_init_config_ex(struct abm *abm,
+	const char *src,
+	unsigned int bytes,
+	unsigned int inst)
 {
-	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
-	unsigned int backlight = REG_READ(BL1_PWM_CURRENT_ABM_LEVEL);
+	unsigned int feature_support;
 
-	/* return backlight in hardware format which is unsigned 17 bits, with
-	 * 1 bit integer and 16 bit fractional
-	 */
-	return backlight;
-}
+	feature_support = abm_feature_support(abm, inst);
 
-static unsigned int dmub_abm_get_target_backlight(struct abm *abm)
-{
-	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
-	unsigned int backlight = REG_READ(BL1_PWM_TARGET_ABM_LEVEL);
+	if (feature_support == ABM_LCD_SUPPORT)
+		dmub_abm_init_config(abm, src, bytes, inst);
 
-	/* return backlight in hardware format which is unsigned 17 bits, with
-	 * 1 bit integer and 16 bit fractional
-	 */
-	return backlight;
+	return true;
 }
 
-static bool dmub_abm_set_level(struct abm *abm, uint32_t level)
+static bool dmub_abm_set_pause_ex(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int stream_inst)
 {
-	union dmub_rb_cmd cmd;
-	struct dc_context *dc = abm->ctx;
-	struct dc_link *edp_links[MAX_NUM_EDP];
-	int i;
-	int edp_num;
-	uint8_t panel_mask = 0;
-
-	get_edp_links(dc->dc, edp_links, &edp_num);
-
-	for (i = 0; i < edp_num; i++) {
-		if (edp_links[i]->link_status.link_active)
-			panel_mask |= (0x01 << i);
-	}
+	bool ret = false;
+	unsigned int feature_support;
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.abm_set_level.header.type = DMUB_CMD__ABM;
-	cmd.abm_set_level.header.sub_type = DMUB_CMD__ABM_SET_LEVEL;
-	cmd.abm_set_level.abm_set_level_data.level = level;
-	cmd.abm_set_level.abm_set_level_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
-	cmd.abm_set_level.abm_set_level_data.panel_mask = panel_mask;
-	cmd.abm_set_level.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_level_data);
+	feature_support = abm_feature_support(abm, panel_inst);
 
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
-	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-	dc_dmub_srv_wait_idle(dc->dmub_srv);
+	if (feature_support == ABM_LCD_SUPPORT)
+		ret = dmub_abm_set_pause(abm, pause, panel_inst, stream_inst);
 
-	return true;
+	return ret;
 }
 
-static bool dmub_abm_init_config(struct abm *abm,
-	const char *src,
-	unsigned int bytes,
-	unsigned int inst)
+static bool dmub_abm_set_pipe_ex(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
 {
-	union dmub_rb_cmd cmd;
-	struct dc_context *dc = abm->ctx;
-	uint8_t panel_mask = 0x01 << inst;
+	bool ret = false;
+	unsigned int feature_support;
 
-	// TODO: Optimize by only reading back final 4 bytes
-	dmub_flush_buffer_mem(&dc->dmub_srv->dmub->scratch_mem_fb);
+	feature_support = abm_feature_support(abm, panel_inst);
 
-	// Copy iramtable into cw7
-	memcpy(dc->dmub_srv->dmub->scratch_mem_fb.cpu_addr, (void *)src, bytes);
+	if (feature_support == ABM_LCD_SUPPORT)
+		ret = dmub_abm_set_pipe(abm, otg_inst, option, panel_inst);
 
-	memset(&cmd, 0, sizeof(cmd));
-	// Fw will copy from cw7 to fw_state
-	cmd.abm_init_config.header.type = DMUB_CMD__ABM;
-	cmd.abm_init_config.header.sub_type = DMUB_CMD__ABM_INIT_CONFIG;
-	cmd.abm_init_config.abm_init_config_data.src.quad_part = dc->dmub_srv->dmub->scratch_mem_fb.gpu_addr;
-	cmd.abm_init_config.abm_init_config_data.bytes = bytes;
-	cmd.abm_init_config.abm_init_config_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
-	cmd.abm_init_config.abm_init_config_data.panel_mask = panel_mask;
+	return ret;
+}
 
-	cmd.abm_init_config.header.payload_bytes = sizeof(struct dmub_cmd_abm_init_config_data);
+static bool dmub_abm_set_event_ex(struct abm *abm, unsigned int full_screen, unsigned int video_mode,
+		unsigned int hdr_mode, unsigned int panel_inst)
+{
+	bool ret = false;
+	unsigned int feature_support;
 
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
-	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-	dc_dmub_srv_wait_idle(dc->dmub_srv);
+	feature_support = abm_feature_support(abm, panel_inst);
 
-	return true;
+	return ret;
 }
 
-static bool dmub_abm_set_pause(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int stream_inst)
+static bool dmub_abm_set_backlight_level_pwm_ex(struct abm *abm,
+		unsigned int backlight_pwm_u16_16,
+		unsigned int frame_ramp,
+		unsigned int controller_id,
+		unsigned int panel_inst)
 {
-	union dmub_rb_cmd cmd;
-	struct dc_context *dc = abm->ctx;
-	uint8_t panel_mask = 0x01 << panel_inst;
+	bool ret = false;
+	unsigned int feature_support;
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.abm_pause.header.type = DMUB_CMD__ABM;
-	cmd.abm_pause.header.sub_type = DMUB_CMD__ABM_PAUSE;
-	cmd.abm_pause.abm_pause_data.enable = pause;
-	cmd.abm_pause.abm_pause_data.panel_mask = panel_mask;
-	cmd.abm_set_level.header.payload_bytes = sizeof(struct dmub_cmd_abm_pause_data);
+	feature_support = abm_feature_support(abm, panel_inst);
 
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
-	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-	dc_dmub_srv_wait_idle(dc->dmub_srv);
+	if (feature_support == ABM_LCD_SUPPORT)
+		ret = dmub_abm_set_backlight_level(abm, backlight_pwm_u16_16, frame_ramp, panel_inst);
 
-	return true;
+	return ret;
 }
 
 static const struct abm_funcs abm_funcs = {
-	.abm_init = dmub_abm_init,
-	.set_abm_level = dmub_abm_set_level,
-	.get_current_backlight = dmub_abm_get_current_backlight,
-	.get_target_backlight = dmub_abm_get_target_backlight,
-	.init_abm_config = dmub_abm_init_config,
-	.set_abm_pause = dmub_abm_set_pause,
+	.abm_init = dmub_abm_init_ex,
+	.set_abm_level = dmub_abm_set_level_ex,
+	.get_current_backlight = dmub_abm_get_current_backlight_ex,
+	.get_target_backlight = dmub_abm_get_target_backlight_ex,
+	.init_abm_config = dmub_abm_init_config_ex,
+	.set_abm_pause = dmub_abm_set_pause_ex,
+	.set_pipe_ex = dmub_abm_set_pipe_ex,
+	.set_abm_event = dmub_abm_set_event_ex,
+	.set_backlight_level_pwm = dmub_abm_set_backlight_level_pwm_ex,
+
 };
 
 static void dmub_abm_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
new file mode 100644
index 000000000000..a235ab0fbd6f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -0,0 +1,259 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
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
+#include "dmub_abm.h"
+#include "dce_abm.h"
+#include "dc.h"
+#include "dc_dmub_srv.h"
+#include "dmub/dmub_srv.h"
+#include "core_types.h"
+#include "dm_services.h"
+#include "reg_helper.h"
+#include "fixed31_32.h"
+
+#include "atom.h"
+
+#define TO_DMUB_ABM(abm)\
+	container_of(abm, struct dce_abm, base)
+
+#define REG(reg) \
+	(dce_abm->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	dce_abm->abm_shift->field_name, dce_abm->abm_mask->field_name
+
+#define CTX \
+	dce_abm->base.ctx
+
+#define DISABLE_ABM_IMMEDIATELY 255
+
+
+
+static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
+{
+	union dmub_rb_cmd cmd;
+	uint32_t fractional_pwm = (dc->dc->config.disable_fractional_pwm == false) ? 1 : 0;
+	uint32_t edp_id_count = dc->dc_edp_id_count;
+	int i;
+	uint8_t panel_mask = 0;
+
+	for (i = 0; i < edp_id_count; i++)
+		panel_mask |= 0x01 << i;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_set_pwm_frac.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_pwm_frac.header.sub_type = DMUB_CMD__ABM_SET_PWM_FRAC;
+	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.fractional_pwm = fractional_pwm;
+	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
+	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.panel_mask = panel_mask;
+	cmd.abm_set_pwm_frac.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pwm_frac_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+
+void dmub_abm_init(struct abm *abm, uint32_t backlight)
+{
+	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
+
+	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x3);
+	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x1);
+	REG_WRITE(DC_ABM1_LS_SAMPLE_RATE, 0x3);
+	REG_WRITE(DC_ABM1_LS_SAMPLE_RATE, 0x1);
+	REG_WRITE(BL1_PWM_BL_UPDATE_SAMPLE_RATE, 0x1);
+
+	REG_SET_3(DC_ABM1_HG_MISC_CTRL, 0,
+			ABM1_HG_NUM_OF_BINS_SEL, 0,
+			ABM1_HG_VMAX_SEL, 1,
+			ABM1_HG_BIN_BITWIDTH_SIZE_SEL, 0);
+
+	REG_SET_3(DC_ABM1_IPCSC_COEFF_SEL, 0,
+			ABM1_IPCSC_COEFF_SEL_R, 2,
+			ABM1_IPCSC_COEFF_SEL_G, 4,
+			ABM1_IPCSC_COEFF_SEL_B, 2);
+
+	REG_UPDATE(BL1_PWM_CURRENT_ABM_LEVEL,
+			BL1_PWM_CURRENT_ABM_LEVEL, backlight);
+
+	REG_UPDATE(BL1_PWM_TARGET_ABM_LEVEL,
+			BL1_PWM_TARGET_ABM_LEVEL, backlight);
+
+	REG_UPDATE(BL1_PWM_USER_LEVEL,
+			BL1_PWM_USER_LEVEL, backlight);
+
+	REG_UPDATE_2(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES,
+			ABM1_LS_MIN_PIXEL_VALUE_THRES, 0,
+			ABM1_LS_MAX_PIXEL_VALUE_THRES, 1000);
+
+	REG_SET_3(DC_ABM1_HGLS_REG_READ_PROGRESS, 0,
+			ABM1_HG_REG_READ_MISSED_FRAME_CLEAR, 1,
+			ABM1_LS_REG_READ_MISSED_FRAME_CLEAR, 1,
+			ABM1_BL_REG_READ_MISSED_FRAME_CLEAR, 1);
+
+	dmub_abm_enable_fractional_pwm(abm->ctx);
+}
+
+unsigned int dmub_abm_get_current_backlight(struct abm *abm)
+{
+	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
+	unsigned int backlight = REG_READ(BL1_PWM_CURRENT_ABM_LEVEL);
+
+	/* return backlight in hardware format which is unsigned 17 bits, with
+	 * 1 bit integer and 16 bit fractional
+	 */
+	return backlight;
+}
+
+unsigned int dmub_abm_get_target_backlight(struct abm *abm)
+{
+	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
+	unsigned int backlight = REG_READ(BL1_PWM_TARGET_ABM_LEVEL);
+
+	/* return backlight in hardware format which is unsigned 17 bits, with
+	 * 1 bit integer and 16 bit fractional
+	 */
+	return backlight;
+}
+
+bool dmub_abm_set_level(struct abm *abm, uint32_t level, uint8_t panel_mask)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_set_level.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_level.header.sub_type = DMUB_CMD__ABM_SET_LEVEL;
+	cmd.abm_set_level.abm_set_level_data.level = level;
+	cmd.abm_set_level.abm_set_level_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
+	cmd.abm_set_level.abm_set_level_data.panel_mask = panel_mask;
+	cmd.abm_set_level.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_level_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
+}
+
+void dmub_abm_init_config(struct abm *abm,
+	const char *src,
+	unsigned int bytes,
+	unsigned int inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+	uint8_t panel_mask = 0x01 << inst;
+
+	// TODO: Optimize by only reading back final 4 bytes
+	dmub_flush_buffer_mem(&dc->dmub_srv->dmub->scratch_mem_fb);
+
+	// Copy iramtable into cw7
+	memcpy(dc->dmub_srv->dmub->scratch_mem_fb.cpu_addr, (void *)src, bytes);
+
+	memset(&cmd, 0, sizeof(cmd));
+	// Fw will copy from cw7 to fw_state
+	cmd.abm_init_config.header.type = DMUB_CMD__ABM;
+	cmd.abm_init_config.header.sub_type = DMUB_CMD__ABM_INIT_CONFIG;
+	cmd.abm_init_config.abm_init_config_data.src.quad_part = dc->dmub_srv->dmub->scratch_mem_fb.gpu_addr;
+	cmd.abm_init_config.abm_init_config_data.bytes = bytes;
+	cmd.abm_init_config.abm_init_config_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
+	cmd.abm_init_config.abm_init_config_data.panel_mask = panel_mask;
+
+	cmd.abm_init_config.header.payload_bytes = sizeof(struct dmub_cmd_abm_init_config_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+}
+
+bool dmub_abm_set_pause(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int stream_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+	uint8_t panel_mask = 0x01 << panel_inst;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_pause.header.type = DMUB_CMD__ABM;
+	cmd.abm_pause.header.sub_type = DMUB_CMD__ABM_PAUSE;
+	cmd.abm_pause.abm_pause_data.enable = pause;
+	cmd.abm_pause.abm_pause_data.panel_mask = panel_mask;
+	cmd.abm_set_level.header.payload_bytes = sizeof(struct dmub_cmd_abm_pause_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
+}
+
+bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+	uint32_t ramping_boundary = 0xFFFF;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
+	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
+	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
+	cmd.abm_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pipe_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
+}
+
+bool dmub_abm_set_backlight_level(struct abm *abm,
+		unsigned int backlight_pwm_u16_16,
+		unsigned int frame_ramp,
+		unsigned int panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_set_backlight.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
+	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = frame_ramp;
+	cmd.abm_set_backlight.abm_set_backlight_data.backlight_user_level = backlight_pwm_u16_16;
+	cmd.abm_set_backlight.abm_set_backlight_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
+	cmd.abm_set_backlight.abm_set_backlight_data.panel_mask = (0x01 << panel_inst);
+	cmd.abm_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_backlight_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
new file mode 100644
index 000000000000..55cf4ec98475
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
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
+#ifndef __DMUB_ABM_LCD_H__
+#define __DMUB_ABM_LCD_H__
+
+#include "abm.h"
+
+void dmub_abm_init(struct abm *abm, uint32_t backlight);
+bool dmub_abm_set_level(struct abm *abm, uint32_t level, uint8_t panel_mask);
+unsigned int dmub_abm_get_current_backlight(struct abm *abm);
+unsigned int dmub_abm_get_target_backlight(struct abm *abm);
+void dmub_abm_init_config(struct abm *abm,
+	const char *src,
+	unsigned int bytes,
+	unsigned int inst);
+bool dmub_abm_set_pause(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int stream_inst);
+bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst);
+bool dmub_abm_set_backlight_level(struct abm *abm,
+		unsigned int backlight_pwm_u16_16,
+		unsigned int frame_ramp,
+		unsigned int panel_inst);
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 69cc192a7e71..69b2f277d41e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -137,28 +137,6 @@ void dcn21_PLAT_58856_wa(struct dc_state *context, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->dpms_off = true;
 }
 
-static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
-{
-	union dmub_rb_cmd cmd;
-	struct dc_context *dc = abm->ctx;
-	uint32_t ramping_boundary = 0xFFFF;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
-	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
-	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
-	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
-	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
-	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
-	cmd.abm_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pipe_data);
-
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
-	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-	dc_dmub_srv_wait_idle(dc->dmub_srv);
-
-	return true;
-}
-
 void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 {
 	struct abm *abm = pipe_ctx->stream_res.abm;
@@ -172,9 +150,9 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 		return;
 	}
 
-	if (abm && panel_cntl) {
-		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
-				panel_cntl->inst);
+	if (abm && panel_cntl && abm->funcs->set_pipe_ex) {
+		abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
+			panel_cntl->inst);
 		panel_cntl->funcs->store_backlight_level(panel_cntl);
 	}
 }
@@ -191,18 +169,16 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 		return;
 	}
 
-	if (abm && panel_cntl)
-		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+	if (abm && panel_cntl && abm->funcs->set_pipe_ex)
+		abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+
 }
 
 bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp)
 {
-	union dmub_rb_cmd cmd;
 	struct dc_context *dc = pipe_ctx->stream->ctx;
-	struct abm *abm = pipe_ctx->stream_res.abm;
-	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 
 	if (dc->dc->res_pool->dmcu) {
@@ -210,21 +186,17 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 		return true;
 	}
 
-	if (abm && panel_cntl)
-		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.abm_set_backlight.header.type = DMUB_CMD__ABM;
-	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
-	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = frame_ramp;
-	cmd.abm_set_backlight.abm_set_backlight_data.backlight_user_level = backlight_pwm_u16_16;
-	cmd.abm_set_backlight.abm_set_backlight_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
-	cmd.abm_set_backlight.abm_set_backlight_data.panel_mask = (0x01 << panel_cntl->inst);
-	cmd.abm_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_backlight_data);
-
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
-	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-	dc_dmub_srv_wait_idle(dc->dmub_srv);
+	if (pipe_ctx->stream_res.abm != NULL) {
+		struct abm *abm = pipe_ctx->stream_res.abm;
+		uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
+
+		if (abm && panel_cntl && abm->funcs->set_pipe_ex)
+			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+
+		if (panel_cntl && abm->funcs->set_backlight_level_pwm)
+			abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
+			frame_ramp, 0, panel_cntl->inst);
+	}
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index ecb4191b6e64..db5cf9acafe6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -55,6 +55,12 @@ struct abm_funcs {
 			unsigned int bytes,
 			unsigned int inst);
 	bool (*set_abm_pause)(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int otg_inst);
+	bool (*set_pipe_ex)(struct abm *abm,
+			unsigned int otg_inst,
+			unsigned int option,
+			unsigned int panel_inst);
+	bool (*set_abm_event)(struct abm *abm, unsigned int full_screen, unsigned int video_mode,
+			unsigned int hdr_mode, unsigned int panel_inst);
 };
 
 #endif
-- 
2.39.0

