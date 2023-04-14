Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BC7C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6DD810EDB8;
	Fri, 14 Apr 2023 15:54:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF8810EDBA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIz4V4Dd7g+C0+PV5/cUci1X4nStXmBKUARHuNusuuWyTRYZ07grQ++/+0Pzf6pE8VjmNFo4DSKjwSjVLCo7oOw8y+h0nmrSbti/KNKQQOWNNn7fpUxaO8skW5YkGnr4F2lwDOlpmz1ucshtX4cdXtbMRq9a0qUbRJ9+uBH2TRhV5Hxq56YiDIrKcjTnceJKi+ZZSCU7UNpBtk/oaN4eb+YpxrHb+KgH3Nkinb0k3fFq7cMAYxeTnxwlnppOyhE7otr3lmMbz2ZY/rA7NZfnrLlGLY5cP0y0PtzVYN5pHxhgvaqvD8T0m5ni/jJAbweX8m3fAQVSi8mTIFixTbK99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icWRlRokks1yiTxnXXpoeZ4cAPhU1MtyXM/RLDVbDb8=;
 b=mjgKo9fwSbI8vQgYnQrtG1z4nAcGT0MNiVQYLv4jqClKM4w8faWcdlkNifrz8yRwXfduDO8o/6SB7oiy3w99+/96QpJxJHbu/YqLVX8NNhJNSYNBhn/DhCPhmiPfkxL/Qp3+Ng4LAIGSvrR3t0pi5SVNbvUSHh5JqiyShqdIXKKUKhXsqSvLNo+IAD4g2ZY9DdMU61HV65O0tqM6Hotts0FCcP4/Po5FGFOoftpOVApGEn1eW00Bhz3LYHYxRWjAdZ2lag7FYSXhQZGH/q9lUDLlSxmypLmC65MTZkPf7x6R6wrKEgY7JrH1Gbw3x86fZ9sdik7WH6H/LjTQ2M32Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icWRlRokks1yiTxnXXpoeZ4cAPhU1MtyXM/RLDVbDb8=;
 b=xbabd/B3sv7ll10vxo1tM7Pf8ANJUSYLnwb4gz+2ueyZMPJcbFYRxVViE+cOq+WMUzZmWS6KZdLRc5rgjN+lbb9j1tWZLSK8vghe7J0/ySnHVZJsFsIr3JZY4Vwwt4x5pExwfrF9FFVwtCQYZmEtE+5eHI2eG+xXHHKpqo4+4pY=
Received: from DS7PR07CA0019.namprd07.prod.outlook.com (2603:10b6:5:3af::7) by
 CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.28; Fri, 14 Apr 2023 15:53:59 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::4f) by DS7PR07CA0019.outlook.office365.com
 (2603:10b6:5:3af::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:53:59 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:53:57 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/66] drm/amd/display: Refactor ABM feature
Date: Fri, 14 Apr 2023 11:52:32 -0400
Message-ID: <20230414155330.5215-9-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f649386-2ec8-4367-8584-08db3d0075fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIwek+6uo3vq9imKPFfCfYfCV0desT+rxD/UAtvcxDjCJdNP3YBYLbqahJmDXKbJbEc/urC8kkFiDnH7izKb3LpQLQPH2XAnGwX1Y9+XTToPJ19ZH8u375Bd97vNF5x9zmAYya0dJ/He3aM+flCD8iS3ToQ3r6lNoCBwpXYv+VC9KxRKvrjYNqWPnw/qOxVcr/rJetbmH31atBzZjGjACFbESaNK6CnD58uoYDOQOP//czcAKcAJlUYSsxCCKHZe04xcgT1ZWCMEBHUrJMXIIBTqMsmpYlm5kLKoLCUATIJ+YyB7W3ePoJ/HbzrOF4oTgluLXiV4oE4IkOZpnCYyJ7cjiw1aSzZx1/n6zXgxf2k2r0AGDbJgYoDP3LjGxXcShAD4qSocDwx5UrY2Wt45yTr3RGOwnf5v54WW5moEPS9rbT5BXY2/ZOsrk6BmzMGejhvwBbtBJ2S1iAv331symsE14Q/HTOReq7PcLWwfFRkbhBjyy8fOFTQVzOdjcE1c5OGUO2mBlm4Si5Li+yH4UwLhgJTBEDWfvXbfm6kFsjDskI1JgJtLDbT7kdaevVxpY0iIzDsnpZB2HfZJxtypw/ffW13TpBkMYTisehPXwYnQhwts7M+1OFgas7NjffwaLEeIZUZDuajU9DHoPKBW+MG+pMCtIGIUs4rZmFl3ToOy3zqTWsQBaGpSAqshicSskSGCiQiMNJA+cNpB0rmm4pj1r79VLs8HiFyh20+i/lQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(47076005)(83380400001)(426003)(336012)(6666004)(16526019)(26005)(1076003)(54906003)(186003)(478600001)(30864003)(5660300002)(2906002)(36756003)(70586007)(356005)(81166007)(316002)(82310400005)(70206006)(4326008)(41300700001)(82740400003)(6916009)(40460700003)(2616005)(8676002)(8936002)(40480700001)(86362001)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:53:59.1078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f649386-2ec8-4367-8584-08db3d0075fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
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
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leon Huang <Leon.Huang1@amd.com>

[Why]
Refactor ABM feature and implement inbox command for DMUB.

[How]
Implement the ioctl to send inbox command to DMUB.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 264 +++++++---------
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c | 286 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |  46 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   6 +
 5 files changed, 442 insertions(+), 162 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h

diff --git a/drivers/gpu/drm/amd/display/dc/dce/Makefile b/drivers/gpu/drm/amd/display/dc/dce/Makefile
index 0d7db132a20f..01490c9ba958 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce/Makefile
@@ -29,7 +29,7 @@
 DCE = dce_audio.o dce_stream_encoder.o dce_link_encoder.o dce_hwseq.o \
 dce_mem_input.o dce_clock_source.o dce_scl_filters.o dce_transform.o \
 dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o dce_aux.o \
-dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o dce_panel_cntl.o \
+dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o dmub_abm_lcd.o dce_panel_cntl.o \
 dmub_hw_lock_mgr.o dmub_outbox.o
 
 AMD_DAL_DCE = $(addprefix $(AMDDALPATH)/dc/dce/,$(DCE))
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 9fc48208c2e4..a66f83a61402 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -24,212 +24,151 @@
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
+	dc_get_edp_links(dc->dc, edp_links, &edp_num);
 
-#define DISABLE_ABM_IMMEDIATELY 255
+	for (i = 0; i < edp_num; i++) {
+		if (panel_inst == i)
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
+	bool ret = false;
+	unsigned int feature_support;
 
-	dc_get_edp_links(dc->dc, edp_links, &edp_num);
-
-	for (i = 0; i < edp_num; i++) {
-		if (edp_links[i]->link_status.link_active)
-			panel_mask |= (0x01 << i);
-	}
-
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
 };
 
 static void dmub_abm_construct(
@@ -256,16 +195,19 @@ struct abm *dmub_abm_create(
 	const struct dce_abm_shift *abm_shift,
 	const struct dce_abm_mask *abm_mask)
 {
-	struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_KERNEL);
+	if (ctx->dc->caps.dmcub_support) {
+		struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_KERNEL);
 
-	if (abm_dce == NULL) {
-		BREAK_TO_DEBUGGER();
-		return NULL;
-	}
+		if (abm_dce == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
 
-	dmub_abm_construct(abm_dce, ctx, regs, abm_shift, abm_mask);
+		dmub_abm_construct(abm_dce, ctx, regs, abm_shift, abm_mask);
 
-	return &abm_dce->base;
+		return &abm_dce->base;
+	}
+	return NULL;
 }
 
 void dmub_abm_destroy(struct abm **abm)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
new file mode 100644
index 000000000000..4055d271ac57
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -0,0 +1,286 @@
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
+#ifdef _WIN32
+#include "atombios.h"
+#else
+#include "atom.h"
+#endif
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
+#ifndef TRIM_AMBIENT_GAMMA
+void dmub_abm_set_ambient_level(struct abm *abm, unsigned int ambient_lux, uint8_t panel_mask)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	if (ambient_lux > 0xFFFF)
+		ambient_lux = 0xFFFF;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_set_ambient_level.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_ambient_level.header.sub_type = DMUB_CMD__ABM_SET_AMBIENT_LEVEL;
+	cmd.abm_set_ambient_level.abm_set_ambient_level_data.ambient_lux = ambient_lux;
+	cmd.abm_set_ambient_level.abm_set_ambient_level_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
+	cmd.abm_set_ambient_level.abm_set_ambient_level_data.panel_mask = panel_mask;
+	cmd.abm_set_ambient_level.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_ambient_level_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+#endif
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
index 000000000000..00b4e268768e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
@@ -0,0 +1,46 @@
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
+
+bool dmub_abm_set_pause(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int stream_inst);
+bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst);
+bool dmub_abm_set_backlight_level(struct abm *abm,
+		unsigned int backlight_pwm_u16_16,
+		unsigned int frame_ramp,
+		unsigned int panel_inst);
+#endif
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
2.34.1

