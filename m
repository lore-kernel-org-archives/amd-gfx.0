Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E8C4320E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 17:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3154560FD9
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 17:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3154560FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C1A6E203;
	Tue, 17 Aug 2021 17:20:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA266E203
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 17:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhFoOSt0PscnyTkUF4I1ikGJchjA3Dk/nl4pJHteLfKAtHwTVRGN9WoKOAyxewh8gAGKXMZr9CMyLy1dkCh9w4lT2c886V7IOubR06Rwqyf+FtjAEYCsvbLhKpvMnWinytIyQM2EwoIaLoByBhZF2sb8/vahRYa8bU1q8GVQ2ZGcHMMbqsot1Goyfd/Lu829fELoR2KeRCVLG5rrEBABzVf1fLLHjeC58KQ4RqMEpFxILBj7bRpaf/kTtcXTW0Tu6URpny6ffJ3DAat176suP7EvjSzo+o+R2M9k3+NpMKgkSXfcqLUS4LuzxptkbPk9fd2S+vCe9KrhPxqkDIXG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utm50Fms8iJ2ZrlEfX+Gv6O1vC7zNnffpF7OWrQrAww=;
 b=P9Owbltl8I4WPJOBt2Hd8h8dYGw0To6S1bBa4186ZNeiSanjyPiD6ON0jF3QYTMD4sdiDYp48pPQi7iS0iaJAx5/nJOwzLUH17WfPNigSWfMbLTcVTXP5hIBQ8gKR5RkLYvtxUR3DMJ7ZohlPCfnIuoepp965OfsmCJLIzVRV8ayKSiAXVVujugjz4hIaSoTRtEwu2g5SKL0bq2LtBwktEcSR8S5T98U1zETBvIN+JAea/pAjqx1T3q0KTXgunNrHP2KissWMA/D0ot/aoaXOCf0n4OF+5rWolAwED904vrG83cZk3gbeneeJiJ3inty5UbJL4lxAZG2ue20lBeYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utm50Fms8iJ2ZrlEfX+Gv6O1vC7zNnffpF7OWrQrAww=;
 b=FI39EeEDXtx0wdTpDSFlteNoyclWG7IhQYD3JHpPfWgSL5y+9FRL/0WOuvQUVbi3HYGt52ZpvINZ7WmIus//DKUtXrNYpqBpIhKpr+KrJsyZgneyCpa7JvbskJXBtiUAnOmFzLRCuCgcWP2xLtvRYD55cYIdflZZ/M+KXC+yeN4=
Received: from DS7PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:3bb::8) by
 DM5PR12MB2520.namprd12.prod.outlook.com (2603:10b6:4:b9::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.22; Tue, 17 Aug 2021 17:20:34 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::6e) by DS7PR03CA0063.outlook.office365.com
 (2603:10b6:5:3bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17 via Frontend
 Transport; Tue, 17 Aug 2021 17:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 17:20:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 12:20:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 12:20:33 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 17 Aug 2021 12:20:31 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v2 1/6] drm/amd/display: Add DP 2.0 Audio Package Generator
Date: Tue, 17 Aug 2021 13:20:01 -0400
Message-ID: <20210817172006.777655-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817172006.777655-1-Jerry.Zuo@amd.com>
References: <20210817172006.777655-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44c08544-44ab-4b55-43b8-08d961a352b9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2520:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25202EC7F64DF5CB3331C29DE5FE9@DM5PR12MB2520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30vU48HZQhFhkwmjZjloM5hoVWEBoh112o2p8MjXjefckCrOcBW5KrOSyAOad8IqgPh8Qzh3s/WMxMGdy4S3S6UzquIWwvLG0SilVfSQ4MQtUtzcPhCk8enRAHI3zMibeuRyF5k5gWf1ZhoSzxjtyfpFEaPao85/Y33IaiA5QWt1pIh96rDslmOXgX7bYijh7HBsrU/U9YyVuxUDMN48hoOCPA9gsxqnSsKoqmrqI2h8qTv6+IkQASOfZQ7vBPExhu94Uo+1hGEEiRbGBOyZdUlRbddKPRccZGALByL2M+2DUhrevaco9OrpVQhc7WFAkdSV0n61koan3AKgxbqkzpiGr469F40WArvVnZZGIBvAbNKmxdwimRL2eRU7DOfeeCGE2OmzKq2O2+BclfnCQgf57wBSa0I73N1mAZZN05+OHUpx9gBwLaopfiSB20fqg6ynbolkxH5Yqhijo2exqOw+ZuQtcwdwjZ5YaoAA9bNTEl+4btyw9doIkFnHE+SokjaUTCUpDYplM845BeNOAsTV6v/Ajf2SVyXSZMc9RTPr9b1Me0tqV2mO+nppA/dwgXsquWj6cFvLLReZbnxoy1BQOjobK7YuL7JWMt5Z/vF5GaWHm1BADuw1YD1tP6h/UZPZC9y1kyDN5psoFv3zdayKhJ05OD0NEDJqq6e4nChyvRcsCHdaMDy9ojmLucHBsL/bLcxl0dgcXWUuOZ8ZZ9Z8K0PpxCtg/bTbdQvOdd/dJt3VmgQSwZoHCSbey/C5jJLwOJqibWnsi7ejuPdraA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(83380400001)(336012)(47076005)(54906003)(6666004)(110136005)(2906002)(316002)(86362001)(5660300002)(186003)(6636002)(2616005)(8676002)(1076003)(426003)(30864003)(8936002)(36860700001)(81166007)(26005)(82310400003)(34020700004)(356005)(4326008)(7696005)(70206006)(70586007)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 17:20:34.4113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c08544-44ab-4b55-43b8-08d961a352b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2520
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

