Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD226C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 21:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C9260F11
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 21:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 44C9260F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F9F6E05C;
	Mon, 16 Aug 2021 21:03:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A666E05C
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 21:03:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAFldqt/eKUmj6aZHvHxcTDkdTJQFiUtoKlmhaaG9NP6sSaZHg1GJGD3fSDakZiK7CAj89+B3NbPeR64SKPNeMt1TrF1dZrYN67q6PMPqrbQq5M0NgXtIE1dA0e8rPCzT7VaBpCedNdQzYJTgrLpcD0wjfb7+nL11SR14TgxMvS9kCD+9AoEYjWsWbHiY2boccXj/wkNqtXK9F+kzU7k2CfkR9WgPqwLvpGJMtd0elrOqzrViZs51MU/TudQSDYg0SHaLhvNokVvyJSIHym6PAQWdxI5SYfDusjDm6a6hZWgdBzTtvrfgEdkKaRBGSjmRyqBpv6voGsV1fA9LKRJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utm50Fms8iJ2ZrlEfX+Gv6O1vC7zNnffpF7OWrQrAww=;
 b=Bh+5/muE8aaCRI9irq2z8gANvCGOe8f9zEtpgociipK8+T2kvUcJ9dbsx60cZG4iIjs93ZYfMIsiYWd/FMuTpfarYRTzyLCucumqyYrK9rCq9o2cRsYLPoupxAVc1ZuuyCfZlTDDBZEak0omGtc7q1bRHKwKULx8xc7Wf38RiZdkGXT60spuKJLMaOJ1uyRI0wnOWiexmzGN1lXgLyZ6Ky5tdx49tCwR/1YatCVVRU9MOdPMgMMF2u0ZTiZH2bCjCYy+KAKX27VLzujjyS+D8r//23ZYFr2Z/1r7hHylp9bJah9NtHqT5l1W2mqJ9gDunWRdTzSdsPij09R4aNX22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utm50Fms8iJ2ZrlEfX+Gv6O1vC7zNnffpF7OWrQrAww=;
 b=vhY4XP8rkXnq2EWh7x/llApPSG8aLGwhofTAx6H0UoX1SYNzyyE7K2MEWDXpIcvQINCB1fNwxDetbwVL1o4ZMRTToq3T0ejzr7puDIP2eqbHx/pOSJQxrnpTtHo3r/HTyrjUTwfUcGkepcIdk3fst4j2beTEvPoz7ErBaPQ0C9U=
Received: from BN6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:404:65::12)
 by BL0PR12MB2436.namprd12.prod.outlook.com (2603:10b6:207:42::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Mon, 16 Aug
 2021 21:03:30 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::43) by BN6PR17CA0002.outlook.office365.com
 (2603:10b6:404:65::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Mon, 16 Aug 2021 21:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Mon, 16 Aug 2021 21:03:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 16:03:29 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 16 Aug 2021 16:03:28 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 1/6] drm/amd/display: Add DP 2.0 Audio Package Generator
Date: Mon, 16 Aug 2021 16:59:14 -0400
Message-ID: <20210816205919.614691-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816205919.614691-1-Jerry.Zuo@amd.com>
References: <20210816205919.614691-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4f8dcdc-172e-48c1-65fb-08d960f94cdb
X-MS-TrafficTypeDiagnostic: BL0PR12MB2436:
X-Microsoft-Antispam-PRVS: <BL0PR12MB243663B1B9DA3831C676E804E5FD9@BL0PR12MB2436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvNg+fmEVBFN+YjQngpy3M1bn7Q+PjRxQRFgbtsX2T/xf9idZBuPWU7o/M1SEIZ4Z5gKuwXVrijlUk+AyW1m6GJsbBS4F/NbOl6zVpM537CSjYnj9UtNgeHDeVL8EaPMgG+o/CKXRhzz4VgnnkHKXIB/jCyJCALfNJxhUUPluC2uNOCs5tvfG9iTgPbl2QK62NlzUZuxkdlzQryk/ZdkLOBZPZrzdNnhh+SBFX5D4Ds2tE7VSMivCHZWuiUmc4CzgiU4vJ/95VqEX6Vz/R4wnNou37GXBv36TvAjG7FPMKHC7ftM9Iy6CZRB3zAjGqkKJIp68Zsh6sSqmY7h0dViqJebmQBd1LDz+6AZVqUwQindUKLLU64bu2sVYQM4fEvLXRw3QDkAR1ayEkrmA5YkThoEA4WW0qvVhLFa74re02Kg7QCyVdLV/AaCrsuQJx2W6wnFGcB44dfJV2kDfjkteSLpZn57uun5HpHPrd/lO01p766jDpxV/dut3L9ycSFw/O6TolV5H29J4N+lJ/mamBeEd4lip5nTJh8yAzClXIvqBxafpFcuPV68gh3f3w7Y3GMqL/jjyci5toIbQz879AaONffIrvyqU2oCraSguvy05KbGXA5LQHfGgx2qTMT9AUJJkaILv1NPY3TLQqkNA9k+2OOA8x3FguXKqpunGSoYyTJWLX1QWjo6lCF0MWIMh6vmNNomGr8EVuwNEhs5j6gs89Jk4L7XJT0dwn01oH33EOIn/R48UnSb0jdBueeoycoABiBOiYbaT0p7uyCOdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(70586007)(70206006)(6666004)(110136005)(86362001)(7696005)(54906003)(316002)(426003)(336012)(4326008)(83380400001)(186003)(2616005)(478600001)(8936002)(36756003)(26005)(1076003)(6636002)(5660300002)(82310400003)(82740400003)(34020700004)(30864003)(356005)(81166007)(36860700001)(8676002)(2906002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 21:03:30.1766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f8dcdc-172e-48c1-65fb-08d960f94cdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2436
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

HW Blocks:

                    +-----+
                    | HDA |
                    +-----+
                       |
                       |
    HPO ===============|=============
     |                 v
     |              +-----+
     |              | APG |
     v              +-----+

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   3 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  | 173 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.h  | 115 ++++++++++++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  38 ++++
 4 files changed, 328 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 4bab97acb155..bc2087f6dcb2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -11,7 +11,8 @@
 # Makefile for dcn31.
 
 DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_hwseq.o dcn31_init.o dcn31_hubp.o \
-	dcn31_dccg.o dcn31_optc.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o
+	dcn31_dccg.o dcn31_optc.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
+	dcn31_apg.o
 
 ifdef CONFIG_X86
 CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := -msse
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
new file mode 100644
index 000000000000..6bd7a0626665
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
@@ -0,0 +1,173 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ *  and/or sell copies of the Software, and to permit persons to whom the
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
+#include "dc_bios_types.h"
+#include "hw_shared.h"
+#include "dcn31_apg.h"
+#include "reg_helper.h"
+
+#define DC_LOGGER \
+		apg31->base.ctx->logger
+
+#define REG(reg)\
+	(apg31->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	apg31->apg_shift->field_name, apg31->apg_mask->field_name
+
+
+#define CTX \
+	apg31->base.ctx
+
+
+static void apg31_enable(
+	struct apg *apg)
+{
+	struct dcn31_apg *apg31 = DCN31_APG_FROM_APG(apg);
+
+	/* Reset APG */
+	REG_UPDATE(APG_CONTROL, APG_RESET, 1);
+	REG_WAIT(APG_CONTROL,
+			APG_RESET_DONE, 1,
+			1, 10);
+	REG_UPDATE(APG_CONTROL, APG_RESET, 0);
+	REG_WAIT(APG_CONTROL,
+			APG_RESET_DONE, 0,
+			1, 10);
+
+	/* Enable APG */
+	REG_UPDATE(APG_CONTROL2, APG_ENABLE, 1);
+}
+
+static void apg31_disable(
+	struct apg *apg)
+{
+	struct dcn31_apg *apg31 = DCN31_APG_FROM_APG(apg);
+
+	/* Disable APG */
+	REG_UPDATE(APG_CONTROL2, APG_ENABLE, 0);
+}
+
+static union audio_cea_channels speakers_to_channels(
+	struct audio_speaker_flags speaker_flags)
+{
+	union audio_cea_channels cea_channels = {0};
+
+	/* these are one to one */
+	cea_channels.channels.FL = speaker_flags.FL_FR;
+	cea_channels.channels.FR = speaker_flags.FL_FR;
+	cea_channels.channels.LFE = speaker_flags.LFE;
+	cea_channels.channels.FC = speaker_flags.FC;
+
+	/* if Rear Left and Right exist move RC speaker to channel 7
+	 * otherwise to channel 5
+	 */
+	if (speaker_flags.RL_RR) {
+		cea_channels.channels.RL_RC = speaker_flags.RL_RR;
+		cea_channels.channels.RR = speaker_flags.RL_RR;
+		cea_channels.channels.RC_RLC_FLC = speaker_flags.RC;
+	} else {
+		cea_channels.channels.RL_RC = speaker_flags.RC;
+	}
+
+	/* FRONT Left Right Center and REAR Left Right Center are exclusive */
+	if (speaker_flags.FLC_FRC) {
+		cea_channels.channels.RC_RLC_FLC = speaker_flags.FLC_FRC;
+		cea_channels.channels.RRC_FRC = speaker_flags.FLC_FRC;
+	} else {
+		cea_channels.channels.RC_RLC_FLC = speaker_flags.RLC_RRC;
+		cea_channels.channels.RRC_FRC = speaker_flags.RLC_RRC;
+	}
+
+	return cea_channels;
+}
+
+static void apg31_se_audio_setup(
+	struct apg *apg,
+	unsigned int az_inst,
+	struct audio_info *audio_info)
+{
+	struct dcn31_apg *apg31 = DCN31_APG_FROM_APG(apg);
+
+	uint32_t speakers = 0;
+	uint32_t channels = 0;
+
+	ASSERT(audio_info);
+	/* This should not happen.it does so we don't get BSOD*/
+	if (audio_info == NULL)
+		return;
+
+	speakers = audio_info->flags.info.ALLSPEAKERS;
+	channels = speakers_to_channels(audio_info->flags.speaker_flags).all;
+
+	/* DisplayPort only allows for one audio stream with stream ID 0 */
+	REG_UPDATE(APG_CONTROL2, APG_DP_AUDIO_STREAM_ID, 0);
+
+	/* When running in "pair mode", pairs of audio channels have their own enable
+	 * this is for really old audio drivers */
+	REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, 0xF);
+	// REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, channels);
+
+	/* Disable forced mem power off */
+	REG_UPDATE(APG_MEM_PWR, APG_MEM_PWR_FORCE, 0);
+
+	apg31_enable(apg);
+}
+
+static void apg31_audio_mute_control(
+	struct apg *apg,
+	bool mute)
+{
+	if (mute)
+		apg31_disable(apg);
+	else
+		apg31_enable(apg);
+}
+
+static struct apg_funcs dcn31_apg_funcs = {
+	.se_audio_setup			= apg31_se_audio_setup,
+	.audio_mute_control		= apg31_audio_mute_control,
+	.enable_apg			= apg31_enable,
+	.disable_apg			= apg31_disable,
+};
+
+void apg31_construct(struct dcn31_apg *apg31,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dcn31_apg_registers *apg_regs,
+	const struct dcn31_apg_shift *apg_shift,
+	const struct dcn31_apg_mask *apg_mask)
+{
+	apg31->base.ctx = ctx;
+
+	apg31->base.inst = inst;
+	apg31->base.funcs = &dcn31_apg_funcs;
+
+	apg31->regs = apg_regs;
+	apg31->apg_shift = apg_shift;
+	apg31->apg_mask = apg_mask;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h
new file mode 100644
index 000000000000..24f568e120d8
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h
@@ -0,0 +1,115 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifndef __DAL_DCN31_AGP_H__
+#define __DAL_DCN31_AGP_H__
+
+
+#define DCN31_APG_FROM_APG(apg)\
+	container_of(apg, struct dcn31_apg, base)
+
+#define APG_DCN31_REG_LIST(id) \
+	SRI(APG_CONTROL, APG, id), \
+	SRI(APG_CONTROL2, APG, id),\
+	SRI(APG_MEM_PWR, APG, id),\
+	SRI(APG_DBG_GEN_CONTROL, APG, id)
+
+struct dcn31_apg_registers {
+	uint32_t APG_CONTROL;
+	uint32_t APG_CONTROL2;
+	uint32_t APG_MEM_PWR;
+	uint32_t APG_DBG_GEN_CONTROL;
+};
+
+
+#define DCN31_APG_MASK_SH_LIST(mask_sh)\
+	SE_SF(APG0_APG_CONTROL, APG_RESET, mask_sh),\
+	SE_SF(APG0_APG_CONTROL, APG_RESET_DONE, mask_sh),\
+	SE_SF(APG0_APG_CONTROL2, APG_ENABLE, mask_sh),\
+	SE_SF(APG0_APG_CONTROL2, APG_DP_AUDIO_STREAM_ID, mask_sh),\
+	SE_SF(APG0_APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, mask_sh),\
+	SE_SF(APG0_APG_MEM_PWR, APG_MEM_PWR_FORCE, mask_sh)
+
+#define APG_DCN31_REG_FIELD_LIST(type) \
+		type APG_RESET;\
+		type APG_RESET_DONE;\
+		type APG_ENABLE;\
+		type APG_DP_AUDIO_STREAM_ID;\
+		type APG_DBG_AUDIO_CHANNEL_ENABLE;\
+		type APG_MEM_PWR_FORCE
+
+struct dcn31_apg_shift {
+	APG_DCN31_REG_FIELD_LIST(uint8_t);
+};
+
+struct dcn31_apg_mask {
+	APG_DCN31_REG_FIELD_LIST(uint32_t);
+};
+
+struct apg {
+	const struct apg_funcs *funcs;
+	struct dc_context *ctx;
+	int inst;
+};
+
+struct apg_funcs {
+
+	void (*setup_hdmi_audio)(
+		struct apg *apg);
+
+	void (*se_audio_setup)(
+		struct apg *apg,
+		unsigned int az_inst,
+		struct audio_info *audio_info);
+
+	void (*audio_mute_control)(
+		struct apg *apg,
+		bool mute);
+
+	void (*enable_apg)(
+		struct apg *apg);
+
+	void (*disable_apg)(
+		struct apg *apg);
+};
+
+
+
+struct dcn31_apg {
+	struct apg base;
+	const struct dcn31_apg_registers *regs;
+	const struct dcn31_apg_shift *apg_shift;
+	const struct dcn31_apg_mask *apg_mask;
+};
+
+void apg31_construct(struct dcn31_apg *apg3,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dcn31_apg_registers *apg_regs,
+	const struct dcn31_apg_shift *apg_shift,
+	const struct dcn31_apg_mask *apg_mask);
+
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index a7702d3c75cd..7355864117e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -52,6 +52,7 @@
 #include "dcn30/dcn30_vpg.h"
 #include "dcn30/dcn30_afmt.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
+#include "dcn31/dcn31_apg.h"
 #include "dcn31/dcn31_dio_link_encoder.h"
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
@@ -457,6 +458,26 @@ static const struct dcn30_afmt_mask afmt_mask = {
 	DCN3_AFMT_MASK_SH_LIST(_MASK)
 };
 
+#define apg_regs(id)\
+[id] = {\
+	APG_DCN31_REG_LIST(id)\
+}
+
+static const struct dcn31_apg_registers apg_regs[] = {
+	apg_regs(0),
+	apg_regs(1),
+	apg_regs(2),
+	apg_regs(3)
+};
+
+static const struct dcn31_apg_shift apg_shift = {
+	DCN31_APG_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn31_apg_mask apg_mask = {
+		DCN31_APG_MASK_SH_LIST(_MASK)
+};
+
 #define stream_enc_regs(id)\
 [id] = {\
 	SE_DCN3_REG_LIST(id)\
@@ -1260,6 +1281,23 @@ static struct afmt *dcn31_afmt_create(
 	return &afmt3->base;
 }
 
+static struct apg *dcn31_apg_create(
+	struct dc_context *ctx,
+	uint32_t inst)
+{
+	struct dcn31_apg *apg31 = kzalloc(sizeof(struct dcn31_apg), GFP_KERNEL);
+
+	if (!apg31)
+		return NULL;
+
+	apg31_construct(apg31, ctx, inst,
+			&apg_regs[inst],
+			&apg_shift,
+			&apg_mask);
+
+	return &apg31->base;
+}
+
 static struct stream_encoder *dcn31_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx)
-- 
2.25.1

