Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89035C4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7AB2072D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dmOTSxSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7AB2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CF56E179;
	Fri, 20 Mar 2020 15:11:53 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770051.outbound.protection.outlook.com [40.107.77.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA766E179
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtZRFxOqy6ft4PiIheX+hwrCUlu/0H3Pj5cTDDmwlY7S5W2EEcUzjxlsegNiowvpxQsYnIZ6IH/PlGgfP4xpR/en/uvxkX87QQdW2EFMT7ALFPnEpTwV7JdZX/QGxiD0FO6JorjFF5TN+lMBcvHtQQoOZY2Wq5YaxmBAaumazliK32BG9R/Mi5qSvJD4QhU9EfdSmyw35Ujiz6vb0IKY0N+fC9G0gYH853rf54eoe79bTpPD3GksVhVYtCaWW8i0cu+rkIvfpyUyzhvdTviBJVjgiM3uWZQ4pSF+xr9LOIFtsCvOZ91Sfe49tChidwy079iBZMWTEjt+JpVAo4J97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfB6FPQWGmS85rvLSssryw2g76mPRTwj6rmR+tYwMRU=;
 b=SfzNfI2Ft0Rs+NrOZfFULBkNWp9IS9+jWx/CukxrzirrKJtHKArPp8RCUZVEHb6mJc6OM5FURgbFm5tG7xbUQ02TI5edYLOfJTPn7tHDQ3BtbEoSPgx8ggKQw/20r93h94UXuOvokCkn8UXdLj2F8EePlXVvYTif337/NwTtEk7GqUzHmAqDmLd00eUrdPCbiXb9ILukv/9oPUcSrFmPlYUNjBLFVEMC+UKTv45MKiaXxp4+K7prnrCdV4yu+rdeLq0VPqlnFXZZwxsOsuQUO90DWROR1U8B0nKligKJqDoIWBZi9neZyf9INyLCzwpjEtnF5Zbp1qbHskYH8hH7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfB6FPQWGmS85rvLSssryw2g76mPRTwj6rmR+tYwMRU=;
 b=dmOTSxSRgzgzajtKWVsYlNDEhyAnv2xGvjrj+z4sAn58gZ+fbZcpGcU60Aenjwp72Iq2yh9K+XlijID3wwyP5jQptCPFGksmi5lX3n2tUQh+HPyyfG4xoBK1NZDv4IgddtZCaNAxWacf9r9+/sOi4bP7m6ouG3B323klGY//sc0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:49 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/12] drm/amd/display: Add ABM driver implementation
Date: Fri, 20 Mar 2020 11:11:20 -0400
Message-Id: <20200320151128.2039940-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:48 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7a83483-c8c2-4686-e9d7-08d7cce10384
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257214ADD8EF322235FA707598F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(6486002)(36756003)(5660300002)(30864003)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJ9DRSsUeEhi1UDGqZVhNCH+lma2LM2Lvy/gxIAnjBMGmJqGo5c4Bgl5/NMm6b8DTXZqXTKAXPTN5bvvRwtmOmDadMeiyW+BHdoup8+Vk6WUUH1zN1D74GamV0NrNr8jY1Y6zqHxtFBtimhow5z55BV0/PXxlVlkMPBE6xxjK3TAKuvzMu+PXTJ3K051gtRcQugjw5HRoZ1GmZpanc8cAU3iSlCmeKeCcUShAQJC0Z3VN2QXtrf502FtCevD/ZhPi58QWsgrV9+om7UHHnrq5rMr5XCtynl7zjnwCl1u2BsoWcbCRAOZ0vUkosmsK2RBg9j6dnb/hZqNS36Ecju3mZ+jZxbfido31ikQCv5aptVEeCP/Z9C0NZjll+JGxhSpoi1z7XscFwzcjsvg2i7mg5ZQOxQp20wqLfyLNBz2lnk8kGAPULIhzkIMeCe9D5K9
X-MS-Exchange-AntiSpam-MessageData: Q5ZSjQWX7vD6IkddQT8SsC8Ipfw2ixD17j8pO9Msx5BPOR+oZwveKKiXuTpfGZSMG73sC09QuZVB/HA6P9d91fpTfLLKwSDF9KOJ70Lj2akbHGCYT4W8KrQOzAgVm03jMsWLAL5TrHZLG2evABvp6n5J9524Mh6Mihi+xFfP+fI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a83483-c8c2-4686-e9d7-08d7cce10384
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:49.6793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFqzsvTV1rBU0byuPj3E9xye0gjBa48VV6a3tZOj1G3DjZFg3B/HhkLNdUX5ZwedgbeoDAL+Ps83lfMiz0njTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Moving ABM from DMCU to DMCUB.

[How]
Add ABM driver files and implementation.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 417 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h |  40 ++
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  41 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   4 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  11 +
 .../amd/display/modules/power/power_helpers.c |  21 +-
 8 files changed, 514 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h

diff --git a/drivers/gpu/drm/amd/display/dc/dce/Makefile b/drivers/gpu/drm/amd/display/dc/dce/Makefile
index fbfcff700971..b31a1b71dab0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce/Makefile
@@ -29,7 +29,7 @@
 DCE = dce_audio.o dce_stream_encoder.o dce_link_encoder.o dce_hwseq.o \
 dce_mem_input.o dce_clock_source.o dce_scl_filters.o dce_transform.o \
 dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o dce_aux.o \
-dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o
+dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o
 
 AMD_DAL_DCE = $(addprefix $(AMDDALPATH)/dc/dce/,$(DCE))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index b8a3fc505c9b..a4dae31400fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -447,6 +447,7 @@ static const struct abm_funcs dce_funcs = {
 	.set_backlight_level_pwm = dce_abm_set_backlight_level_pwm,
 	.get_current_backlight = dce_abm_get_current_backlight,
 	.get_target_backlight = dce_abm_get_target_backlight,
+	.load_abm_config = NULL,
 	.set_abm_immediate_disable = dce_abm_immediate_disable
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
new file mode 100644
index 000000000000..1d9100f8c0ba
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -0,0 +1,417 @@
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
+#include "../../dmub/inc/dmub_srv.h"
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
+static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+	uint32_t ramping_boundary = 0xFFFF;
+
+	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
+	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
+	cmd.abm_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pipe_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.abm_set_pipe.header);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
+}
+
+static unsigned int calculate_16_bit_backlight_from_pwm(struct dce_abm *dce_abm)
+{
+	uint64_t current_backlight;
+	uint32_t round_result;
+	uint32_t bl_period, bl_int_count;
+	uint32_t bl_pwm, fractional_duty_cycle_en;
+	uint32_t bl_period_mask, bl_pwm_mask;
+
+	REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, &bl_period);
+	REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD_BITCNT, &bl_int_count);
+
+	REG_GET(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, &bl_pwm);
+	REG_GET(BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN, &fractional_duty_cycle_en);
+
+	if (bl_int_count == 0)
+		bl_int_count = 16;
+
+	bl_period_mask = (1 << bl_int_count) - 1;
+	bl_period &= bl_period_mask;
+
+	bl_pwm_mask = bl_period_mask << (16 - bl_int_count);
+
+	if (fractional_duty_cycle_en == 0)
+		bl_pwm &= bl_pwm_mask;
+	else
+		bl_pwm &= 0xFFFF;
+
+	current_backlight = (uint64_t)bl_pwm << (1 + bl_int_count);
+
+	if (bl_period == 0)
+		bl_period = 0xFFFF;
+
+	current_backlight = div_u64(current_backlight, bl_period);
+	current_backlight = (current_backlight + 1) >> 1;
+
+	current_backlight = (uint64_t)(current_backlight) * bl_period;
+
+	round_result = (uint32_t)(current_backlight & 0xFFFFFFFF);
+
+	round_result = (round_result >> (bl_int_count-1)) & 1;
+
+	current_backlight >>= bl_int_count;
+	current_backlight += round_result;
+
+	return (uint32_t)(current_backlight);
+}
+
+static void dmcub_set_backlight_level(
+	struct dce_abm *dce_abm,
+	uint32_t backlight_pwm_u16_16,
+	uint32_t frame_ramp,
+	uint32_t otg_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dce_abm->base.ctx;
+	unsigned int backlight_8_bit = 0;
+	uint32_t s2;
+
+	if (backlight_pwm_u16_16 & 0x10000)
+		// Check for max backlight condition
+		backlight_8_bit = 0xFF;
+	else
+		// Take MSB of fractional part since backlight is not max
+		backlight_8_bit = (backlight_pwm_u16_16 >> 8) & 0xFF;
+
+	dmub_abm_set_pipe(&dce_abm->base, otg_inst);
+
+	if (otg_inst == 0)
+		frame_ramp = 0;
+
+	cmd.abm_set_backlight.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
+	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = frame_ramp;
+	cmd.abm_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_backlight_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.abm_set_backlight.header);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	// Update requested backlight level
+	s2 = REG_READ(BIOS_SCRATCH_2);
+
+	s2 &= ~ATOM_S2_CURRENT_BL_LEVEL_MASK;
+	backlight_8_bit &= (ATOM_S2_CURRENT_BL_LEVEL_MASK >>
+				ATOM_S2_CURRENT_BL_LEVEL_SHIFT);
+	s2 |= (backlight_8_bit << ATOM_S2_CURRENT_BL_LEVEL_SHIFT);
+
+	REG_WRITE(BIOS_SCRATCH_2, s2);
+}
+
+static void dmub_abm_init(struct abm *abm)
+{
+	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
+	unsigned int backlight = calculate_16_bit_backlight_from_pwm(dce_abm);
+
+	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x103);
+	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x101);
+	REG_WRITE(DC_ABM1_LS_SAMPLE_RATE, 0x103);
+	REG_WRITE(DC_ABM1_LS_SAMPLE_RATE, 0x101);
+	REG_WRITE(BL1_PWM_BL_UPDATE_SAMPLE_RATE, 0x101);
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
+}
+
+static unsigned int dmub_abm_get_current_backlight(struct abm *abm)
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
+static unsigned int dmub_abm_get_target_backlight(struct abm *abm)
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
+static bool dmub_abm_set_level(struct abm *abm, uint32_t level)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	cmd.abm_set_level.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_level.header.sub_type = DMUB_CMD__ABM_SET_LEVEL;
+	cmd.abm_set_level.abm_set_level_data.level = level;
+	cmd.abm_set_level.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_level_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.abm_set_level.header);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
+}
+
+static bool dmub_abm_immediate_disable(struct abm *abm)
+{
+	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
+
+	dmub_abm_set_pipe(abm, DISABLE_ABM_IMMEDIATELY);
+
+	abm->stored_backlight_registers.BL_PWM_CNTL =
+		REG_READ(BL_PWM_CNTL);
+	abm->stored_backlight_registers.BL_PWM_CNTL2 =
+		REG_READ(BL_PWM_CNTL2);
+	abm->stored_backlight_registers.BL_PWM_PERIOD_CNTL =
+		REG_READ(BL_PWM_PERIOD_CNTL);
+
+	REG_GET(LVTMA_PWRSEQ_REF_DIV, BL_PWM_REF_DIV,
+		&abm->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
+
+	return true;
+}
+
+static bool dmub_abm_init_backlight(struct abm *abm)
+{
+	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
+	uint32_t value;
+
+	/* It must not be 0, so we have to restore them
+	 * Bios bug w/a - period resets to zero,
+	 * restoring to cache values which is always correct
+	 */
+	REG_GET(BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, &value);
+
+	if (value == 0 || value == 1) {
+		if (abm->stored_backlight_registers.BL_PWM_CNTL != 0) {
+			REG_WRITE(BL_PWM_CNTL,
+				abm->stored_backlight_registers.BL_PWM_CNTL);
+			REG_WRITE(BL_PWM_CNTL2,
+				abm->stored_backlight_registers.BL_PWM_CNTL2);
+			REG_WRITE(BL_PWM_PERIOD_CNTL,
+				abm->stored_backlight_registers.BL_PWM_PERIOD_CNTL);
+			REG_UPDATE(LVTMA_PWRSEQ_REF_DIV,
+				BL_PWM_REF_DIV,
+				abm->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
+		} else {
+			/* TODO: Note: This should not really happen since VBIOS
+			 * should have initialized PWM registers on boot.
+			 */
+			REG_WRITE(BL_PWM_CNTL, 0xC000FA00);
+			REG_WRITE(BL_PWM_PERIOD_CNTL, 0x000C0FA0);
+		}
+	} else {
+		abm->stored_backlight_registers.BL_PWM_CNTL =
+				REG_READ(BL_PWM_CNTL);
+		abm->stored_backlight_registers.BL_PWM_CNTL2 =
+				REG_READ(BL_PWM_CNTL2);
+		abm->stored_backlight_registers.BL_PWM_PERIOD_CNTL =
+				REG_READ(BL_PWM_PERIOD_CNTL);
+
+		REG_GET(LVTMA_PWRSEQ_REF_DIV, BL_PWM_REF_DIV,
+				&abm->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
+	}
+
+	// Have driver take backlight control
+	// TakeBacklightControl(true)
+	value = REG_READ(BIOS_SCRATCH_2);
+	value |= ATOM_S2_VRI_BRIGHT_ENABLE;
+	REG_WRITE(BIOS_SCRATCH_2, value);
+
+	// Enable the backlight output
+	REG_UPDATE(BL_PWM_CNTL, BL_PWM_EN, 1);
+
+	// Unlock group 2 backlight registers
+	REG_UPDATE(BL_PWM_GRP1_REG_LOCK,
+			BL_PWM_GRP1_REG_LOCK, 0);
+
+	return true;
+}
+
+static bool dmub_abm_set_backlight_level_pwm(
+		struct abm *abm,
+		unsigned int backlight_pwm_u16_16,
+		unsigned int frame_ramp,
+		unsigned int otg_inst,
+		bool use_smooth_brightness)
+{
+	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
+
+	dmcub_set_backlight_level(dce_abm,
+			backlight_pwm_u16_16,
+			frame_ramp,
+			otg_inst);
+
+	return true;
+}
+
+static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
+{
+	union dmub_rb_cmd cmd;
+	uint32_t fractional_pwm = (dc->dc->config.disable_fractional_pwm == false) ? 1 : 0;
+
+	cmd.abm_set_pwm_frac.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_pwm_frac.header.sub_type = DMUB_CMD__ABM_SET_PWM_FRAC;
+	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.fractional_pwm = fractional_pwm;
+	cmd.abm_set_pwm_frac.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pwm_frac_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.abm_set_pwm_frac.header);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+
+static bool dmub_abm_load_config(struct abm *abm,
+	unsigned int start_offset,
+	const char *src,
+	unsigned int bytes)
+{
+	return true;
+}
+
+static const struct abm_funcs abm_funcs = {
+	.abm_init = dmub_abm_init,
+	.set_abm_level = dmub_abm_set_level,
+	.init_backlight = dmub_abm_init_backlight,
+	.set_pipe = dmub_abm_set_pipe,
+	.set_backlight_level_pwm = dmub_abm_set_backlight_level_pwm,
+	.get_current_backlight = dmub_abm_get_current_backlight,
+	.get_target_backlight = dmub_abm_get_target_backlight,
+	.set_abm_immediate_disable = dmub_abm_immediate_disable,
+	.load_abm_config = dmub_abm_load_config,
+};
+
+static void dmub_abm_construct(
+	struct dce_abm *abm_dce,
+	struct dc_context *ctx,
+	const struct dce_abm_registers *regs,
+	const struct dce_abm_shift *abm_shift,
+	const struct dce_abm_mask *abm_mask)
+{
+	struct abm *base = &abm_dce->base;
+
+	base->ctx = ctx;
+	base->funcs = &abm_funcs;
+	base->stored_backlight_registers.BL_PWM_CNTL = 0;
+	base->stored_backlight_registers.BL_PWM_CNTL2 = 0;
+	base->stored_backlight_registers.BL_PWM_PERIOD_CNTL = 0;
+	base->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV = 0;
+	base->dmcu_is_running = false;
+
+	abm_dce->regs = regs;
+	abm_dce->abm_shift = abm_shift;
+	abm_dce->abm_mask = abm_mask;
+
+	dmub_abm_enable_fractional_pwm(ctx);
+}
+
+struct abm *dmub_abm_create(
+	struct dc_context *ctx,
+	const struct dce_abm_registers *regs,
+	const struct dce_abm_shift *abm_shift,
+	const struct dce_abm_mask *abm_mask)
+{
+	struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_KERNEL);
+
+	if (abm_dce == NULL) {
+		BREAK_TO_DEBUGGER();
+		return NULL;
+	}
+
+	dmub_abm_construct(abm_dce, ctx, regs, abm_shift, abm_mask);
+
+	return &abm_dce->base;
+}
+
+void dmub_abm_destroy(struct abm **abm)
+{
+	struct dce_abm *abm_dce = TO_DMUB_ABM(*abm);
+
+	kfree(abm_dce);
+	*abm = NULL;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h
new file mode 100644
index 000000000000..3a5d5ac7a86e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h
@@ -0,0 +1,40 @@
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
+#ifndef __DMUB_ABM_H__
+#define __DMUB_ABM_H__
+
+#include "abm.h"
+#include "dce_abm.h"
+
+struct abm *dmub_abm_create(
+	struct dc_context *ctx,
+	const struct dce_abm_registers *regs,
+	const struct dce_abm_shift *abm_shift,
+	const struct dce_abm_mask *abm_mask);
+
+void dmub_abm_destroy(struct abm **abm);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index deda1a6b603b..1849f7f9142c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -85,6 +85,7 @@
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
 #include "dce/dmub_psr.h"
+#include "dce/dmub_abm.h"
 
 #define SOC_BOUNDING_BOX_VALID false
 #define DC_LOGGER_INIT(logger)
@@ -991,9 +992,12 @@ static void dcn21_resource_destruct(struct dcn21_resource_pool *pool)
 		pool->base.dp_clock_source = NULL;
 	}
 
-
-	if (pool->base.abm != NULL)
-		dce_abm_destroy(&pool->base.abm);
+	if (pool->base.abm != NULL) {
+		if (pool->base.abm->ctx->dc->debug.disable_dmcu)
+			dmub_abm_destroy(&pool->base.abm);
+		else
+			dce_abm_destroy(&pool->base.abm);
+	}
 
 	if (pool->base.dmcu != NULL)
 		dce_dmcu_destroy(&pool->base.dmcu);
@@ -1855,14 +1859,16 @@ static bool dcn21_resource_construct(
 		goto create_fail;
 	}
 
-	pool->base.dmcu = dcn21_dmcu_create(ctx,
-			&dmcu_regs,
-			&dmcu_shift,
-			&dmcu_mask);
-	if (pool->base.dmcu == NULL) {
-		dm_error("DC: failed to create dmcu!\n");
-		BREAK_TO_DEBUGGER();
-		goto create_fail;
+	if (!dc->debug.disable_dmcu) {
+		pool->base.dmcu = dcn21_dmcu_create(ctx,
+				&dmcu_regs,
+				&dmcu_shift,
+				&dmcu_mask);
+		if (pool->base.dmcu == NULL) {
+			dm_error("DC: failed to create dmcu!\n");
+			BREAK_TO_DEBUGGER();
+			goto create_fail;
+		}
 	}
 
 	if (dc->debug.disable_dmcu) {
@@ -1875,15 +1881,16 @@ static bool dcn21_resource_construct(
 		}
 	}
 
-	pool->base.abm = dce_abm_create(ctx,
+	if (dc->debug.disable_dmcu)
+		pool->base.abm = dmub_abm_create(ctx,
+			&abm_regs,
+			&abm_shift,
+			&abm_mask);
+	else
+		pool->base.abm = dce_abm_create(ctx,
 			&abm_regs,
 			&abm_shift,
 			&abm_mask);
-	if (pool->base.abm == NULL) {
-		dm_error("DC: failed to create abm!\n");
-		BREAK_TO_DEBUGGER();
-		goto create_fail;
-	}
 
 	pool->base.pp_smu = dcn21_pp_smu_create(ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index d607b3191954..9cca0ca30fee 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -60,6 +60,10 @@ struct abm_funcs {
 
 	unsigned int (*get_current_backlight)(struct abm *abm);
 	unsigned int (*get_target_backlight)(struct abm *abm);
+	bool (*load_abm_config)(struct abm *abm,
+			unsigned int start_offset,
+			const char *src,
+			unsigned int bytes);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 10b5fa9d2588..0a996e575b9f 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -303,6 +303,16 @@ struct dmub_rb_cmd_abm_set_pwm_frac {
 	struct dmub_cmd_abm_set_pwm_frac_data abm_set_pwm_frac_data;
 };
 
+struct dmub_cmd_abm_init_config_data {
+	union dmub_addr src;
+	uint16_t bytes;
+};
+
+struct dmub_rb_cmd_abm_init_config {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_abm_init_config_data abm_init_config_data;
+};
+
 union dmub_rb_cmd {
 	struct dmub_rb_cmd_read_modify_write read_modify_write;
 	struct dmub_rb_cmd_reg_field_update_sequence reg_field_update_seq;
@@ -324,6 +334,7 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_abm_set_level abm_set_level;
 	struct dmub_rb_cmd_abm_set_ambient_level abm_set_ambient_level;
 	struct dmub_rb_cmd_abm_set_pwm_frac abm_set_pwm_frac;
+	struct dmub_rb_cmd_abm_init_config abm_init_config;
 };
 
 #pragma pack(pop)
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index e75a4bb94488..8bf1bdd0f457 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -24,6 +24,9 @@
 
 #include "power_helpers.h"
 #include "dc/inc/hw/dmcu.h"
+#include "dc/inc/hw/abm.h"
+#include "dc.h"
+#include "core_types.h"
 
 #define DIV_ROUNDUP(a, b) (((a)+((b)/2))/(b))
 
@@ -653,19 +656,27 @@ bool dmcu_load_iram(struct dmcu *dmcu,
 {
 	unsigned char ram_table[IRAM_SIZE];
 	bool result = false;
+	struct abm *abm = dmcu->ctx->dc->res_pool->abm;
 
-	if (dmcu == NULL)
+	if (dmcu == NULL && abm == NULL)
 		return false;
 
-	if (!dmcu->funcs->is_dmcu_initialized(dmcu))
+	if (dmcu && !dmcu->funcs->is_dmcu_initialized(dmcu))
 		return true;
 
 	memset(&ram_table, 0, sizeof(ram_table));
 
-	if (dmcu->dmcu_version.abm_version == 0x24) {
+	// In the case where abm is implemented on dmcub,
+	// dmcu object will be null.
+	// ABM 2.4 and up are implemented on dmcub
+	if (dmcu == NULL) {
 		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
-		result = dmcu->funcs->load_iram(
-				dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
+		result = abm->funcs->load_abm_config(
+			abm, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
+	} else if (dmcu->dmcu_version.abm_version == 0x24) {
+		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
+			result = dmcu->funcs->load_iram(
+					dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
 	} else if (dmcu->dmcu_version.abm_version == 0x23) {
 		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
 
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
