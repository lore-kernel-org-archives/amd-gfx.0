Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F73CD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 15:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2946510E7F6;
	Mon, 11 May 2026 15:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D8MFl2EU";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E298310E7E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 15:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbKYRFymCvPiqM9WgQBArSsiWHF+iYWmwnfojogE6FJy8Z5nrB21XTrL4uc4DBh0iski8vbq/FV9tOwPxLhmGOmj8YeN9fuiNn/s49uUHgP2NdTTJ30zIeniEUCq/zs+j7npu9RQhZtt2Spdrt+7S8p+hGtddAgc08yHsHpF8mYMdal/IO57WB/9ne5tdaRJWrMdJSiTKpZmfRojQaSFAH5utSMpS4VbM3XHg1bGhKhMJogJn9HkHasuowDKkylVOzk38Qy17vy4Pn5hwrnTcg+jTTh4Q2845nQ44rZJ4lxn3TY7naxjgRgI/hZEDU2qKpQGN2hg4dU3S7K5r8CyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygBqKkT2DuwVrZcZkjxLoj8cqeNaI75WoeHOh+AYu5w=;
 b=x7842XuV5mWN97bFZ86WZkoB65sVk1n7yKeuDpkzjeHUvSW2bfvU9paf9+E4j6l9YQmDMqhSUSYTMOz95dzPcUHmi3JUMEf5QuqwWzvIjuu28calUJr3kPL/q/akPauuAzrO/MUGUtmBfXC0pvT4VeA+VCMJ+UtBMlZ1EZV6DrkcQVDRf4Vg3JtuoygiC0n+QhanzVrtTqnJ+dOxEuCQJSfoloj99LBGSfdWZ0NceZckbLeX7W0Jk6+JiJaJPQ+3683E5rxYu4JFb0JkIOce5+Jgu3yd5Tx7zMpV0A7rtJL5cnxUD8KwSaSAPudlAOI+QsU6ql1x+aNS9fgViAkSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygBqKkT2DuwVrZcZkjxLoj8cqeNaI75WoeHOh+AYu5w=;
 b=D8MFl2EUeLkhDybcmBrG0tJnUFE/iyzDMhrwDoiMMTkp0dz38g3pEh/0cOrbBRcPfGuK7ch0Yre6hQDXosJBnDYlrzlNTqgLepBQR8z9aEzIR61MrWR12YtGMK9KgbsuLVHO6xH+zuubt25HF3qqnMpN6H36jC6ApI69oH2GekE=
Received: from MW4PR04CA0259.namprd04.prod.outlook.com (2603:10b6:303:88::24)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:52:22 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::6b) by MW4PR04CA0259.outlook.office365.com
 (2603:10b6:303:88::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 15:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 15:52:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 10:52:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 10:52:19 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 10:52:19 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jerry.Zuo@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH RESEND v3 03/14] drm/amd/display: add HDMI 2.1 FRL base
 support to DML 2.0
Date: Mon, 11 May 2026 11:52:00 -0400
Message-ID: <20260511155212.73586-4-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511155212.73586-1-harry.wentland@amd.com>
References: <20260511155212.73586-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: feb1b688-e4cf-4810-5f17-08deaf7549df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799003|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yVLIRNrrYKpfVb673Uu7rn0ZNVfHVKBVbG+FAhfBXm9hcGYKED5AyiHUvJWyAudSZauk5J282G6B53JWNuKoBNlAnJ/qzIGz0G94OeJev5X3IbHn5ic19fGeVDlhry8c0MYS8U8ETX0n6KEmZz/7BgLCGitJaC5M2629ZMVCatG5C5Gp0J/V+/0AMVezPaWsdhSCUdTyKyty7dBM92ExoikVZtAf0GXc7ZAo8Fi4rPpW0ZOBE6wQ/u/qBoLRmpJRvpNtmp0Rs55ipXBCqmuqv6oxPC5M8ZcoCK8s9sB2HIBOeQlOie7NjoAG4cCVR9HUkVMV8OtUSVro8D21gUuqalU5uEYmwJjQ1u6Jx3tKCLsNpiHOC/GjbZRwt5TmDo0lM8SJ2KFfxrjBPEs+M2gAVMSVAb7/vGxK9saAq2gR/Y0ohYcZl0OcN88S3xmY32caEKNuzBXM3XTdleNBPF82rP/AdgVMCHQ1/5+D3ZhtPBLYr45IIhYbLCsLjj2HxiZyogw3IYfoXsVz02zQVFIv/JOTvGp/0HkZ+8S7y7KeXrhKostG1+vg2lfySncmw15/GE36RzD7bB4yri5zCC1mBuPerQlKottjYcaSIWBqGbqzRRsO/M+SHO4hJsGsqdK7SyoJXa3VwiZDNzfUjoog1SI59ORt45C5Hk+p+v+GUkvaVo5qcg+0j2ayM9Kdf1JYMz53crDeHTcVOcp639B5mGSN2m5KJhWnIsqbV/cn+wA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799003)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cMoqT0oNePfj/2t6EZqbwrvTclLdzAKO29wivFtAbn+m9qDvXwelj3BCQGUqiY1mcjyildmm2gLXyxB/pDYqIM4vb5eS8GXr61UP5odZpf+F/RgAvRvLwIVaR8orRV/kmpx8Cfc1Dee9iF2WukloKjsix5iWQCihhoDJLQMuaIFyEQskE6HBZMUuBuUiQhBddv0J+neE+eZYnfH4i+ZegMyDoV9KFJVDmj5PONjzLH/OdG1sTAmZmu/NxVWu07A5Xn6eMWWXF2IvlATTyYc/McHrbwwewh0BQGj9rUKx8ejzNWgFvyL2X8FmAypyRXKQWSd1hYHnOJ7OnM1sQqo1lF2I1D1Je5eUPpbsmi8lXyi7xGss8lXZX+bwJ15Vk6Ue2DMOHZXwk1ueX4eFCts21xUrLXrSFYgFGN2B0RcoCLqdpFh/RvK+LXB7OXmj+Na4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:52:21.7783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb1b688-e4cf-4810-5f17-08deaf7549df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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

Add HDMI FRL bits to DML 2.0
---
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   2 +
 .../amd/display/dc/dml2_0/display_mode_core.c | 104 ++++-
 .../amd/display/dc/dml2_0/display_mode_util.c |   3 +
 .../dml2_0/dml21/dml21_translation_helper.c   |   4 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |   1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  29 +-
 .../src/dml2_core/dml2_core_shared_types.h    |   3 +
 .../lib_frl_cap_check.c                       | 396 +++++++++++++++++
 .../lib_frl_cap_check.h                       |  90 ++++
 .../dc/dml2_0/dml2_translation_helper.c       |   4 +
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |   2 +
 .../amd/display/dc/dml2_0/dml_frl_cap_chk.c   | 413 ++++++++++++++++++
 .../amd/display/dc/dml2_0/dml_frl_cap_chk.h   | 109 +++++
 13 files changed, 1153 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 8a451c36fdb3..44e00c2b7ac7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -80,6 +80,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2_0/dml21/dml21_wrapper.o := $(dml2_ccflags)
 DML2 = display_mode_core.o display_mode_util.o dml2_wrapper_fpu.o dml2_wrapper.o \
 		dml2_utils.o dml2_policy.o dml2_translation_helper.o dml2_dc_resource_mgmt.o dml2_mall_phantom.o \
 		dml_display_rq_dlg_calc.o
+DML2 += dml_frl_cap_chk.o
 
 AMD_DAL_DML2 = $(addprefix $(AMDDALPATH)/dc/dml2_0/,$(DML2))
 
@@ -102,6 +103,7 @@ DML21 += src/dml2_pmo/dml2_pmo_factory.o
 DML21 += src/dml2_pmo/dml2_pmo_dcn4_fams2.o
 DML21 += src/dml2_pmo/dml2_pmo_dcn42.o
 DML21 += src/dml2_standalone_libraries/lib_float_math.o
+DML21 += src/dml2_standalone_libraries/lib_frl_cap_check.o
 DML21 += dml21_translation_helper.o
 DML21 += dml21_wrapper.o
 DML21 += dml21_wrapper_fpu.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
index 16514f1e4ed9..1ef4ac8ccbb6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
@@ -27,6 +27,8 @@
 #include "display_mode_core.h"
 #include "display_mode_util.h"
 #include "display_mode_lib_defines.h"
+#include "dml_frl_cap_chk.h"
+#include "lib_frl_cap_check.h"
 
 #include "dml_assert.h"
 
@@ -864,7 +866,7 @@ static dml_uint_t dscceComputeDelay(
 	// #all other modes operate at 1 pixel per clock
 	else if (pixelFormat == dml_444)
 		pixelsPerClock = 1;
-	else if (pixelFormat == dml_n422)
+	else if (pixelFormat == dml_n422 || Output == dml_hdmifrl)
 		pixelsPerClock = 2;
 	else
 		pixelsPerClock = 1;
@@ -884,7 +886,7 @@ static dml_uint_t dscceComputeDelay(
 	w = sliceWidth / pixelsPerClock;
 
 	//422 mode has an additional cycle of delay
-	if (pixelFormat == dml_420 || pixelFormat == dml_444 || pixelFormat == dml_n422)
+	if (pixelFormat == dml_420 || pixelFormat == dml_444 || pixelFormat == dml_n422 || Output == dml_hdmifrl)
 		s = 0;
 	else
 		s = 1;
@@ -947,7 +949,7 @@ static dml_uint_t dscComputeDelay(enum dml_output_format_class pixelFormat, enum
 		Delay = Delay + 1;
 		// sft
 		Delay = Delay + 1;
-	} else if (pixelFormat == dml_n422) {
+	} else if (pixelFormat == dml_n422 || (Output == dml_hdmifrl && pixelFormat != dml_444)) {
 	// sfr
 	Delay = Delay + 2;
 	// dsccif
@@ -2741,20 +2743,44 @@ static dml_float_t TruncToValidBPP(
 	dml_uint_t NonDSCBPP1;
 	dml_uint_t NonDSCBPP2;
 
+	frl_cap_chk_result hdmifrlresult = FRL_CAP_CHK_OK;
+	frl_cap_chk_params hdmifrlparams = { 0 };
+	frl_cap_chk_intermediates hdmifrlinter = { 0 };
+
+	hdmifrlparams.lanes = Lanes;
+	hdmifrlparams.f_pixel_clock_nominal = PixelClock * 1000000;
+	hdmifrlparams.r_bit_nominal = LinkBitRate * 1000000;
+	hdmifrlparams.layout = AudioLayout;
+	hdmifrlparams.f_audio = AudioRate * 1000;
+	hdmifrlparams.h_active = HActive;
+	hdmifrlparams.h_blank = HTotal - HActive;
+	hdmifrlparams.bpc = (dml_uint_t)(DesiredBPP / 3);
+	hdmifrlparams.compressed = DSCEnable;
+	hdmifrlparams.slices = DSCSlices;
+	hdmifrlparams.slice_width = (dml_uint_t)(dml_ceil((dml_float_t) HActive / DSCSlices, 1.0));
+	hdmifrlparams.bpp_target = DesiredBPP;
+
 	if (Format == dml_420) {
 		NonDSCBPP0 = 12;
 		NonDSCBPP1 = 15;
 		NonDSCBPP2 = 18;
 		MinDSCBPP = 6;
 		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1.0 / 16;
+		hdmifrlparams.pixel_encoding = PIXEL_ENCODING_420;
+		hdmifrlparams.bpc = (dml_uint_t) (DesiredBPP / 1.5);
 	} else if (Format == dml_444) {
 		NonDSCBPP0 = 24;
 		NonDSCBPP1 = 30;
 		NonDSCBPP2 = 36;
 		MinDSCBPP = 8;
 		MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16;
+		hdmifrlparams.pixel_encoding = PIXEL_ENCODING_444;
+		hdmifrlparams.bpc = (dml_uint_t) (DesiredBPP / 3.0);
 	} else {
-		if (Output == dml_hdmi) {
+		hdmifrlparams.pixel_encoding = PIXEL_ENCODING_422;
+		hdmifrlparams.bpc = (dml_uint_t) (DesiredBPP / 2.0);
+
+		if (Output == dml_hdmi || Output == dml_hdmifrl) {
 			NonDSCBPP0 = 24;
 			NonDSCBPP1 = 24;
 			NonDSCBPP2 = 24;
@@ -2763,7 +2789,7 @@ static dml_float_t TruncToValidBPP(
 			NonDSCBPP1 = 20;
 			NonDSCBPP2 = 24;
 	}
-	if (Format == dml_n422) {
+	if (Format == dml_n422 || Output == dml_hdmifrl) {
 		MinDSCBPP = 7;
 			MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
 		} else {
@@ -2772,7 +2798,11 @@ static dml_float_t TruncToValidBPP(
 		}
 	}
 
-	if (Output == dml_dp2p0) {
+	if (Output == dml_hdmifrl) {
+		hdmifrlresult = frl_cap_chk_inter(&hdmifrlparams, &hdmifrlinter);
+		MaxLinkBPP = (1 - hdmifrlinter.overhead_max) * dml_min(hdmifrlinter.r_frl_char_min * 16.0 * (dml_float_t) Lanes / hdmifrlinter.f_pixel_clock_max + 24.0 * (dml_float_t) TB_BORROWED_MAX / (dml_float_t) HActive,
+														(hdmifrlinter.r_frl_char_min * 16.0 * (dml_float_t)Lanes / hdmifrlinter.f_pixel_clock_max * (dml_float_t) HTotal - 16.0 * (dml_float_t) hdmifrlinter.blank_audio_min) / (dml_float_t) HActive);
+	} else if (Output == dml_dp2p0) {
 		MaxLinkBPP = LinkBitRate * Lanes / PixelClock * 128.0 / 132.0 * 383.0 / 384.0 * 65536.0 / 65540.0;
 	} else if (DSCEnable && Output == dml_dp) {
 		MaxLinkBPP = LinkBitRate / 10.0 * 8.0 * Lanes / PixelClock * (1 - 2.4 / 100);
@@ -2824,6 +2854,8 @@ static dml_float_t TruncToValidBPP(
 		if (!((DSCEnable == false && (DesiredBPP == NonDSCBPP2 || DesiredBPP == NonDSCBPP1 || DesiredBPP == NonDSCBPP0)) ||
 				(DSCEnable && DesiredBPP >= MinDSCBPP && DesiredBPP <= MaxDSCBPP))) {
 			return __DML_DPP_INVALID__;
+		} else if ((Output == dml_hdmifrl && hdmifrlresult != FRL_CAP_CHK_OK) || (Output != dml_hdmifrl && MaxLinkBPP < DesiredBPP)) {
+			return __DML_DPP_INVALID__;
 		} else {
 			return DesiredBPP;
 		}
@@ -5516,6 +5548,66 @@ static void CalculateOutputLink(
 					*OutputRate = dml_output_rate_dp_rate_hbr3;
 				}
 			}
+		} else if (Output == dml_hdmifrl) {
+			if (DSCEnable == dml_dsc_enable) {
+				*RequiresDSC = true;
+				LinkDSCEnable = true;
+				*RequiresFEC = true;
+			} else {
+				*RequiresDSC = false;
+				LinkDSCEnable = false;
+				*RequiresFEC = false;
+			}
+			*OutBpp = 0;
+			if (PHYCLKD18PerState >= 3000 / 18) {
+				*OutBpp = TruncToValidBPP(3000, 3, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				//OutputTypeAndRate = Output & "3x3";
+				*OutputType = dml_output_type_hdmifrl;
+				*OutputRate = dml_output_rate_hdmi_rate_3x3;
+			}
+			if (*OutBpp == 0 && PHYCLKD18PerState >= 6000 / 18) {
+				*OutBpp = TruncToValidBPP(6000, 3, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				//OutputTypeAndRate = Output & "6x3";
+				*OutputType = dml_output_type_hdmifrl;
+				*OutputRate = dml_output_rate_hdmi_rate_6x3;
+			}
+			if (*OutBpp == 0 && PHYCLKD18PerState >= 6000 / 18) {
+				*OutBpp = TruncToValidBPP(6000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				//OutputTypeAndRate = Output & "6x4";
+				*OutputType = dml_output_type_hdmifrl;
+				*OutputRate = dml_output_rate_hdmi_rate_6x4;
+			}
+			if (*OutBpp == 0 && PHYCLKD18PerState >= 8000 / 18) {
+				*OutBpp = TruncToValidBPP(8000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				//OutputTypeAndRate = Output & "8x4";
+				*OutputType = dml_output_type_hdmifrl;
+				*OutputRate = dml_output_rate_hdmi_rate_8x4;
+			}
+			if (*OutBpp == 0 && PHYCLKD18PerState >= 10000 / 18) {
+				*OutBpp = TruncToValidBPP(10000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				if (*OutBpp == 0 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0 && PHYCLKD18PerState < 12000 / 18) {
+					*RequiresDSC = true;
+					LinkDSCEnable = true;
+					*RequiresFEC = true;
+					*OutBpp = TruncToValidBPP(10000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				}
+				//OutputTypeAndRate = Output & "10x4";
+				*OutputType = dml_output_type_hdmifrl;
+				*OutputRate = dml_output_rate_hdmi_rate_10x4;
+			}
+
+			if (*OutBpp == 0 && PHYCLKD18PerState >= 12000 / 18) {
+				*OutBpp = TruncToValidBPP(12000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				if (*OutBpp == 0 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
+					*RequiresDSC = true;
+					LinkDSCEnable = true;
+					*RequiresFEC = true;
+					*OutBpp = TruncToValidBPP(12000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				}
+				//OutputTypeAndRate = Output & "12x4";
+				*OutputType = dml_output_type_hdmifrl;
+				*OutputRate = dml_output_rate_hdmi_rate_12x4;
+			}
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
index 3939a0d8b835..a8519f547dce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
@@ -393,6 +393,7 @@ void dml_print_mode_support(struct display_mode_lib_st *mode_lib, dml_uint_t j)
 	dml_print("DML: MODE SUPPORT:     DISPCLK DPPCLK Support                     : %s\n", mode_lib->ms.support.DISPCLK_DPPCLK_Support[j] == true ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT:     Total Available Pipes Support              : %s\n", mode_lib->ms.support.TotalAvailablePipesSupport[j] == true ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT:     Number Of OTG Support                      : %s\n", mode_lib->ms.support.NumberOfOTGSupport == true ? "Supported" : "NOT Supported");
+	dml_print("DML: MODE SUPPORT:     Number Of HDMI FRL Support                 : %s\n", mode_lib->ms.support.NumberOfHDMIFRLSupport == true ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT:     Number Of DP2p0 Support                    : %s\n", mode_lib->ms.support.NumberOfDP2p0Support == true ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT:     Writeback Latency Support                  : %s\n", mode_lib->ms.support.WritebackLatencySupport == true ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT:     Writeback Scale Ratio And Taps Support     : %s\n", mode_lib->ms.support.WritebackScaleRatioAndTapsSupport == true ? "Supported" : "NOT Supported");
@@ -451,6 +452,8 @@ void dml_print_dml_mode_support_info(const struct dml_mode_support_info_st *supp
 		dml_print("DML: support: NotEnoughLanesForMSO = 0x%x\n", support->NotEnoughLanesForMSO);
 	if (!fail_only || support->NumberOfOTGSupport == 0)
 		dml_print("DML: support: NumberOfOTGSupport = 0x%x\n", support->NumberOfOTGSupport);
+	if (!fail_only || support->NumberOfHDMIFRLSupport == 0)
+		dml_print("DML: support: NumberOfHDMIFRLSupport = 0x%x\n", support->NumberOfHDMIFRLSupport);
 	if (!fail_only || support->NumberOfDP2p0Support == 0)
 		dml_print("DML: support: NumberOfDP2p0Support = 0x%x\n", support->NumberOfDP2p0Support);
 	if (!fail_only || support->NonsupportedDSCInputBPC == 1)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index d89fd876975e..75dfeed1a066 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -213,6 +213,9 @@ static void populate_dml21_output_config_from_stream_state(struct dml2_link_outp
 	case SIGNAL_TYPE_DVI_DUAL_LINK:
 		output->output_encoder = dml2_hdmi;
 		break;
+	case SIGNAL_TYPE_HDMI_FRL:
+		output->output_encoder = dml2_hdmifrl;
+		break;
 	default:
 			output->output_encoder = dml2_dp;
 	}
@@ -247,6 +250,7 @@ static void populate_dml21_output_config_from_stream_state(struct dml2_link_outp
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 	case SIGNAL_TYPE_EDP:
 	case SIGNAL_TYPE_VIRTUAL:
+	case SIGNAL_TYPE_HDMI_FRL:
 	default:
 		output->output_dp_link_rate = dml2_dp_rate_na;
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index 858e7bbc511f..c983869e0fa3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -66,6 +66,7 @@ struct dml2_core_ip_params core_dcn4_ip_caps_base = {
 	.cursor_64bpp_support = true,
 	.dynamic_metadata_vm_enabled = false,
 
+	.max_num_hdmi_frl_outputs = 1,
 	.max_num_dp2p0_outputs = 4,
 	.max_num_dp2p0_streams = 4,
 	.imall_supported = 1,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 827bd9143c87..f338e733318e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7,6 +7,7 @@
 #include "dml2_core_dcn4_calcs.h"
 #include "dml2_debug.h"
 #include "lib_float_math.h"
+#include "lib_frl_cap_check.h"
 #include "dml_top_types.h"
 
 #define DML2_MAX_FMT_420_BUFFER_WIDTH 4096
@@ -1294,19 +1295,39 @@ static double TruncToValidBPP(
 	unsigned int NonDSCBPP2;
 	enum dml2_odm_mode ODMMode;
 
+	enum lib_frl_cap_check_status hdmifrlresult = LIB_FRL_CAP_CHECK_OK;
+
+	l->hdmifrlparams.lanes = (int)Lanes;
+	l->hdmifrlparams.f_pixel_clock_nominal = PixelClock * 1000000;
+	l->hdmifrlparams.r_bit_nominal = LinkBitRate * 1000000;
+	l->hdmifrlparams.layout = (int)AudioLayout;
+	l->hdmifrlparams.f_audio = AudioRate * 1000;
+	l->hdmifrlparams.h_active = (int)HActive;
+	l->hdmifrlparams.h_blank = (int)(HTotal - HActive);
+	l->hdmifrlparams.bpc = (int)(DesiredBPP / 3);
+	l->hdmifrlparams.compressed = DSCEnable;
+	l->hdmifrlparams.slices = (int)DSCSlices;
+	l->hdmifrlparams.slice_width = (int)(math_ceil2((double)HActive / DSCSlices, 1.0));
+	l->hdmifrlparams.bpp_target = DesiredBPP;
 	if (Format == dml2_420) {
 		NonDSCBPP0 = 12;
 		NonDSCBPP1 = 15;
 		NonDSCBPP2 = 18;
 		MinDSCBPP = 6;
 		MaxDSCBPP = 16;
+		l->hdmifrlparams.pixel_encoding = LIB_FRL_CAP_CHECK_PIXEL_ENCODING_420;
+		l->hdmifrlparams.bpc = (int)(DesiredBPP / 1.5);
 	} else if (Format == dml2_444) {
 		NonDSCBPP0 = 24;
 		NonDSCBPP1 = 30;
 		NonDSCBPP2 = 36;
 		MinDSCBPP = 8;
 		MaxDSCBPP = 16;
+		l->hdmifrlparams.pixel_encoding = LIB_FRL_CAP_CHECK_PIXEL_ENCODING_444;
+		l->hdmifrlparams.bpc = (int)(DesiredBPP / 3.0);
 	} else {
+		l->hdmifrlparams.pixel_encoding = LIB_FRL_CAP_CHECK_PIXEL_ENCODING_422;
+		l->hdmifrlparams.bpc = (int)(DesiredBPP / 2.0);
 
 		if (Output == dml2_hdmi || Output == dml2_hdmifrl) {
 			NonDSCBPP0 = 24;
@@ -1326,7 +1347,11 @@ static double TruncToValidBPP(
 		}
 	}
 
-	if (Output == dml2_dp2p0) {
+	if (Output == dml2_hdmifrl) {
+		hdmifrlresult = frl_cap_check_intermediates(&l->hdmifrlparams, &l->hdmifrlinter);
+		MaxLinkBPP = (1 - l->hdmifrlinter.overhead_max) * math_min2(l->hdmifrlinter.r_frl_char_min * 16.0 * (double)Lanes / l->hdmifrlinter.f_pixel_clock_max + 24.0 * (double)DML2_FRL_CHK_TB_BORROWED_MAX / (double)HActive,
+			(l->hdmifrlinter.r_frl_char_min * 16.0 * (double)Lanes / l->hdmifrlinter.f_pixel_clock_max * (double)HTotal - 16.0 * (double)l->hdmifrlinter.blank_audio_min) / (double)HActive);
+	} else if (Output == dml2_dp2p0) {
 		MaxLinkBPP = LinkBitRate * Lanes / PixelClock * 128.0 / 132.0 * 383.0 / 384.0 * 65536.0 / 65540.0;
 	} else if (DSCEnable && Output == dml2_dp) {
 		MaxLinkBPP = LinkBitRate / 10.0 * 8.0 * Lanes / PixelClock * (1 - 2.4 / 100);
@@ -1364,6 +1389,8 @@ static double TruncToValidBPP(
 		if (!((DSCEnable == false && (DesiredBPP == NonDSCBPP2 || DesiredBPP == NonDSCBPP1 || DesiredBPP == NonDSCBPP0)) ||
 			(DSCEnable && DesiredBPP >= MinDSCBPP && DesiredBPP <= MaxDSCBPP))) {
 			return __DML2_CALCS_DPP_INVALID__;
+		} else if ((Output == dml2_hdmifrl && hdmifrlresult != LIB_FRL_CAP_CHECK_OK) || (Output != dml2_hdmifrl && MaxLinkBPP < DesiredBPP)) {
+			return __DML2_CALCS_DPP_INVALID__;
 		} else {
 			return DesiredBPP;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 080bc3c3d244..11e295253f72 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -8,6 +8,7 @@
 #include "dml2_external_lib_deps.h"
 #include "dml_top_display_cfg_types.h"
 #include "dml_top_types.h"
+#include "lib_frl_cap_check.h"
 
 #define __DML_VBA_DEBUG__
 #define __DML2_CALCS_MAX_VRATIO_PRE_OTO__ 4.0 //<brief max vratio for one-to-one prefetch bw scheduling
@@ -1522,6 +1523,8 @@ struct dml2_core_shared_CalculateSwathAndDETConfiguration_locals {
 };
 
 struct dml2_core_shared_TruncToValidBPP_locals {
+	struct lib_frl_cap_check_params hdmifrlparams;
+	struct lib_frl_cap_check_intermediates hdmifrlinter;
 };
 
 struct dml2_core_shared_CalculateDETBufferSize_locals {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.c
new file mode 100644
index 000000000000..d62cdf8566cc
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2024 Advanced Micro Devices, Inc.
+
+#include "lib_float_math.h"
+#include "lib_frl_cap_check.h"
+
+#define frl_dump_var(fmt, var) {}
+#define frl_print(fmt, ...) {}
+
+static const double   EPSILON = 0.01;
+static const double   DBL_EPSILON = 2.2204460492503131e-16;
+static const int      C_FRL_CB = 510;
+static const double   OVERHEAD_M = 0.003;  /* %   */
+static const double   TOLERANCE_PIXEL_CLOCK = 0.005;  /* %   */
+static const double   TOLERANCE_AUDIO_CLOCK = 1000;   /* ppm */
+static const int      TOLERANCE_FRL_BIT = 300;    /* ppm */
+static const int      ACR_RATE_MAX = 1500;
+const int             DML2_FRL_CHK_TB_BORROWED_MAX = 400;
+
+static enum lib_frl_cap_check_status frl_cap_check_common(struct lib_frl_cap_check_intermediates *inter, struct lib_frl_cap_check_params *params)
+{
+	double   audio_bw_reserve = (params->compressed ? 192000.0 : 0.0);
+	/*
+		if (getenv("DEBUG_FRL_CAP_CHK"))
+		{
+			printf("frl_cap_chk inputs:\n");
+			printf("-------------------\n");
+			frl_dump_var("%i", params->lanes);
+			frl_dump_var("%le", params->f_pixel_clock_nominal);
+			frl_dump_var("%le", params->r_bit_nominal);
+			frl_dump_var("%i", params->audio_packet_type);
+			frl_dump_var("%le", params->f_audio);
+			frl_dump_var("%i", params->h_active);
+			frl_dump_var("%i", params->h_blank);
+			frl_dump_var("%i", params->bpc);
+			frl_dump_var("%i", params->pixel_encoding);
+			frl_dump_var("%i", params->compressed);
+			frl_dump_var("%i", params->slices);
+			frl_dump_var("%i", params->slice_width);
+			frl_dump_var("%le", params->bpp_target);
+			frl_dump_var("%i", params->layout);
+			frl_dump_var("%i", params->acat);
+			printf("frl_cap_chk outputs:\n");
+			printf("---------------------\n");
+		}
+	*/
+	inter->c_frl_sb = 4 * C_FRL_CB + params->lanes;
+	inter->overhead_sb = (double)params->lanes / inter->c_frl_sb;
+	inter->overhead_rs = 8.0 * 4.0 / inter->c_frl_sb;
+	inter->overhead_map = 2.5 / inter->c_frl_sb;
+	inter->overhead_min = inter->overhead_sb + inter->overhead_rs + inter->overhead_map;
+	inter->overhead_max = inter->overhead_min + OVERHEAD_M;
+	inter->f_pixel_clock_max = params->f_pixel_clock_nominal * (1.0 + TOLERANCE_PIXEL_CLOCK);
+	inter->t_line = (params->h_active + params->h_blank) / inter->f_pixel_clock_max;
+	inter->r_bit_min = params->r_bit_nominal * (1.0 - TOLERANCE_FRL_BIT / 1000000.0);
+	inter->r_frl_char_min = inter->r_bit_min / 18.0;
+	inter->c_frl_line = math_floor(inter->t_line * inter->r_frl_char_min * params->lanes);
+	/*
+		if (getenv("DEBUG_FRL_CAP_CHK"))
+		{
+			frl_dump_var("%i", inter->c_frl_sb);
+			frl_dump_var("%le", inter->overhead_sb);
+			frl_dump_var("%le", inter->overhead_rs);
+			frl_dump_var("%le", inter->overhead_map);
+			frl_dump_var("%le", inter->overhead_min);
+			frl_dump_var("%le", inter->overhead_max);
+			frl_dump_var("%le", inter->f_pixel_clock_max);
+			frl_dump_var("%le", inter->t_line);
+			frl_dump_var("%le", inter->r_bit_min);
+			frl_dump_var("%le", inter->r_frl_char_min);
+			frl_dump_var("%le", inter->c_frl_line);
+		}
+	*/
+	switch (params->audio_packet_type) {
+	case 0x02:
+		/* unsupported
+	case 0x07:
+		*/
+		if (params->layout == 0)
+			inter->ap = 0.25;
+		else if (params->layout == 1)
+			inter->ap = 1.0;
+		break;
+	case 0x08:
+		inter->ap = 0.25;
+		break;
+	case 0x09:
+		/* unsupported
+	case 0x0e:
+	case 0x0f:
+		*/
+		inter->ap = 1.0;
+		break;
+		/* unsupported
+	case 0x0b:
+	case 0x0c:
+		if (acat == 0x01)
+			ap = 2.0;
+		else if (acat == 0x02)
+			ap = 3.0;
+		else if (acat == 0x03)
+			ap = 4.0;
+		break;
+		*/
+	case 0x07:
+	case 0x0e:
+	case 0x0f:
+	case 0x0b:
+	case 0x0c:
+		// Unsupported audio format
+		return LIB_FRL_CAP_CHECK_ERROR_UNSUPPORTED_AUDIO;
+	default:
+		inter->ap = 0.0;
+	}
+
+	inter->r_ap = (math_max2(audio_bw_reserve, params->f_audio * inter->ap) + 2 * ACR_RATE_MAX) * (1 + TOLERANCE_AUDIO_CLOCK / 1000000.0);
+	inter->avg_audio_packets_line = inter->r_ap * inter->t_line;
+	inter->audio_packets_line = (int)math_ceil(inter->avg_audio_packets_line);
+	inter->blank_audio_min = 32 + 32 * inter->audio_packets_line; // h_blank_audio_min or hc_blank_audio_min
+
+	params->audio_packets_line = inter->audio_packets_line;
+	/*
+		if (getenv("DEBUG_FRL_CAP_CHK"))
+		{
+			frl_dump_var("%le", inter->ap);
+			frl_dump_var("%le", inter->r_ap);
+			frl_dump_var("%le", inter->avg_audio_packets_line);
+			frl_dump_var("%i", inter->audio_packets_line);
+			frl_dump_var("%i", inter->blank_audio_min);
+		}
+	*/
+	return LIB_FRL_CAP_CHECK_OK;
+}
+
+
+static enum lib_frl_cap_check_status frl_cap_check_uncompressed(struct lib_frl_cap_check_params *params, struct lib_frl_cap_check_intermediates *inter)
+{
+	enum lib_frl_cap_check_status res;
+
+	int k_420;
+	double k_cd;
+	int c_frl_free;
+	int c_frl_rc_margin;
+	int c_frl_rc_savings;
+	int bpp;
+	double bytes_line;
+	int tb_active;
+	int tb_blank;
+	double f_tb_average;
+	double t_active_ref;
+	double t_blank_ref;
+	double t_active_min;
+	double t_blank_min;
+	double t_borrowed;
+	double tb_borrowed;
+	int c_frl_actual_payload;
+	double utilization;
+	double margin;
+
+	res = frl_cap_check_common(inter, params);
+	if (res != LIB_FRL_CAP_CHECK_OK) {
+		return res;
+	}
+
+	k_420 = params->pixel_encoding == LIB_FRL_CAP_CHECK_PIXEL_ENCODING_420 ? 2 : 1;
+	k_cd = params->pixel_encoding == LIB_FRL_CAP_CHECK_PIXEL_ENCODING_422 ? 1.0 : params->bpc / 8.0;
+	c_frl_free = (int)math_max2(params->h_blank * k_cd / k_420 - 32 * (1 + inter->audio_packets_line) - 7, 0);
+	c_frl_rc_margin = 4;
+	c_frl_rc_savings = (int)math_floor(math_max2(((7.0 / 8.0) * c_frl_free) - c_frl_rc_margin, 0.0));
+	bpp = (int)(24 * k_cd / k_420);
+	bytes_line = bpp * params->h_active / 8.0;
+	tb_active = (int)math_ceil(bytes_line / 3);
+	tb_blank = (int)math_ceil(params->h_blank * k_cd / k_420);
+	/*
+		if (getenv("DEBUG_FRL_CAP_CHK"))
+		{
+			frl_dump_var("%i", k_420);
+			frl_dump_var("%le", k_cd);
+			frl_dump_var("%i", c_frl_free);
+			frl_dump_var("%i", c_frl_rc_margin);
+			frl_dump_var("%i", c_frl_rc_savings);
+			frl_dump_var("%i", bpp);
+			frl_dump_var("%le", bytes_line);
+			frl_dump_var("%i", tb_active);
+			frl_dump_var("%i", tb_blank);
+		}
+	*/
+	if (!(inter->blank_audio_min <= tb_blank)) {
+		frl_dump_var("%i", inter->blank_audio_min);
+		frl_dump_var("%i", tb_blank);
+		return LIB_FRL_CAP_CHECK_ERROR_AUDIO_BW;
+	}
+
+	f_tb_average = (inter->f_pixel_clock_max / (params->h_active + params->h_blank)) * (tb_active + tb_blank);
+	t_active_ref = inter->t_line * ((double)params->h_active / (params->h_active + params->h_blank));
+	t_blank_ref = inter->t_line * ((double)params->h_blank / (params->h_active + params->h_blank));
+	t_active_min = (3.0 / 2.0) * tb_active / (params->lanes * inter->r_frl_char_min * (1.0 - inter->overhead_max));
+	t_blank_min = tb_blank / (params->lanes * inter->r_frl_char_min * (1.0 - inter->overhead_max));
+	/*
+		if (getenv("DEBUG_FRL_CAP_CHK"))
+		{
+			frl_dump_var("%le", f_tb_average);
+			frl_dump_var("%le", t_active_ref);
+			frl_dump_var("%le", t_blank_ref);
+			frl_dump_var("%le", t_active_min);
+			frl_dump_var("%le", t_blank_min);
+		}
+	*/
+	if ((t_active_ref >= t_active_min) && (t_blank_ref >= t_blank_min)) {
+		t_borrowed = 0;
+		params->borrow_mode = LIB_FRL_CAP_CHECK_BORROW_MODE_NONE;
+	} else if ((t_active_ref < t_active_min) && (t_blank_ref >= t_blank_min)) {
+		t_borrowed = t_active_min - t_active_ref;
+		params->borrow_mode = LIB_FRL_CAP_CHECK_BORROW_MODE_FROM_BLANK;
+	} else
+		return LIB_FRL_CAP_CHECK_ERROR_BORROW;
+
+	tb_borrowed = math_ceil(t_borrowed * f_tb_average);
+	/*
+		if (getenv("DEBUG_FRL_CAP_CHK"))
+		{
+			frl_dump_var("%le", tb_borrowed);
+			frl_dump_var("%i", params->borrow_mode);
+	}
+	*/
+	if (!(tb_borrowed <= DML2_FRL_CHK_TB_BORROWED_MAX))
+		return LIB_FRL_CAP_CHECK_ERROR_MAX_BORROW;
+
+	c_frl_actual_payload = (int)math_ceil((3.0 / 2.0) * tb_active) + tb_blank - c_frl_rc_savings;
+	utilization = c_frl_actual_payload / inter->c_frl_line;
+	margin = 1.0 - (utilization + inter->overhead_max);
+	/*
+		if (getenv("DEBUG_FRL_CAP_CHK"))
+		{
+			frl_dump_var("%i",  c_frl_actual_payload);
+			frl_dump_var("%le", utilization);
+			frl_dump_var("%le", margin);
+		}
+	*/
+	if (margin < 0 && math_fabs(margin) > EPSILON)
+		return LIB_FRL_CAP_CHECK_ERROR_MARGIN;
+
+	return LIB_FRL_CAP_CHECK_OK;
+}
+
+static enum lib_frl_cap_check_status frl_cap_check_compressed(struct lib_frl_cap_check_params *params, struct lib_frl_cap_check_intermediates *inter)
+{
+	enum lib_frl_cap_check_status res;
+
+	int      c_frl_available;
+	int      c_frl_active_available;
+	int      c_frl_blank_available;
+	int      bytes_target;
+	int      hc_active_target;
+	int      hc_blank_target_est1;
+	int      hc_blank_target_est2;
+	int      hc_blank_target;
+	double   f_tb_average;
+	double   t_active_ref;
+	double   t_blank_ref;
+	double   t_active_target;
+	double   t_blank_target;
+	double   tb_borrowed;
+	int      c_frl_actual_target_payload;
+	double   utilization_targeted;
+	double   margin_target;
+#if defined(DEBUG_FRL_CAP_CHK)
+	double   tb_delta;
+	double   tb_delta_limit;
+	int      tb_worst;
+#endif
+
+	res = frl_cap_check_common(inter, params);
+	if (res != LIB_FRL_CAP_CHECK_OK)
+		return res;
+
+	c_frl_available = (int)math_floor((1 - inter->overhead_max) * inter->c_frl_line);
+	c_frl_active_available = (int)math_floor(c_frl_available * ((double)params->h_active / (params->h_active + params->h_blank)));
+	(void)c_frl_active_available;
+	c_frl_blank_available = (int)math_floor(c_frl_available * ((double)params->h_blank / (params->h_active + params->h_blank)));
+	(void)c_frl_blank_available;
+	bytes_target = params->slices * (int)math_ceil(params->bpp_target * params->slice_width / 8.0);
+
+	if (!params->bypass_hc_target_calc)
+		hc_active_target = (int)math_ceil(bytes_target / 3.0);
+	else
+		hc_active_target = params->hc_active_target;
+
+	hc_blank_target_est1 = (int)math_ceil(hc_active_target * ((double)params->h_blank / params->h_active));
+	hc_blank_target_est2 = (int)math_max2(hc_blank_target_est1, inter->blank_audio_min);
+
+	if (!params->bypass_hc_target_calc) {
+		hc_blank_target = 4 * (int)math_floor(math_min2(hc_blank_target_est2, c_frl_available - 3.0 / 2.0 * hc_active_target) / 4.0);
+
+		params->hc_active_target = hc_active_target;
+		params->hc_blank_target = hc_blank_target;
+	} else {
+		hc_blank_target = params->hc_blank_target;
+	}
+	/*
+		if (getenv("DEBUG_FRL_CAP_CHK"))
+		{
+			frl_dump_var("%i", c_frl_available);
+			frl_dump_var("%i", c_frl_active_available);
+			frl_dump_var("%i", c_frl_blank_available);
+			frl_dump_var("%i", bytes_target);
+			frl_dump_var("%i", hc_active_target);
+			frl_dump_var("%i", hc_blank_target_est1);
+			frl_dump_var("%i", hc_blank_target_est2);
+			frl_dump_var("%i", hc_blank_target);
+		}
+	*/
+	if (!(inter->blank_audio_min <= hc_blank_target)) {
+		frl_dump_var("%i", inter->blank_audio_min);
+		frl_dump_var("%i", hc_blank_target);
+		return LIB_FRL_CAP_CHECK_ERROR_AUDIO_BW;
+	}
+
+	f_tb_average = inter->f_pixel_clock_max / (params->h_active + params->h_blank) * (hc_active_target + hc_blank_target);
+	t_active_ref = inter->t_line * ((double)params->h_active / (params->h_active + params->h_blank));
+	t_blank_ref = inter->t_line - t_active_ref; // * ((double) params->h_blank / (params->h_active + params->h_blank));
+	t_active_target = math_max2((hc_active_target / f_tb_average), (3.0 / 2.0 * hc_active_target) / (params->lanes * inter->r_frl_char_min * (1.0 - inter->overhead_max)));
+	t_blank_target = inter->t_line - t_active_target;
+
+	tb_borrowed = t_active_target * f_tb_average - hc_active_target;
+#if defined(DEBUG_FRL_CAP_CHK)
+	tb_delta = math_fabs(t_active_target - t_active_ref) * (hc_active_target + hc_blank_target_est1) / inter->t_line;
+		{
+			frl_dump_var("%le", f_tb_average);
+			frl_dump_var("%le", t_active_ref);
+			frl_dump_var("%le", t_blank_ref);
+			frl_dump_var("%le", t_active_target);
+			frl_dump_var("%le", t_blank_target);
+			frl_dump_var("%le", tb_delta);
+		}
+#endif
+	if (t_blank_target - t_blank_ref > DBL_EPSILON) {
+#if defined(DEBUG_FRL_CAP_CHK)
+		tb_delta_limit = (t_active_ref - hc_active_target / f_tb_average) * (hc_active_target + hc_blank_target_est1) / inter->t_line;
+#endif
+		params->borrow_mode = LIB_FRL_CAP_CHECK_BORROW_MODE_FROM_ACTIVE;
+	} else if (t_active_target - t_active_ref > DBL_EPSILON) {
+#if defined(DEBUG_FRL_CAP_CHK)
+		tb_delta_limit = tb_delta;
+#endif
+		params->borrow_mode = LIB_FRL_CAP_CHECK_BORROW_MODE_FROM_BLANK;
+	} else {
+#if defined(DEBUG_FRL_CAP_CHK)
+		tb_delta_limit = 0;
+#endif
+		params->borrow_mode = LIB_FRL_CAP_CHECK_BORROW_MODE_NONE;
+	}
+
+#if defined(DEBUG_FRL_CAP_CHK)
+	tb_worst = (int)math_ceil(math_max2(tb_borrowed, tb_delta_limit));
+
+		{
+			frl_dump_var("%le", tb_delta_limit);
+			frl_dump_var("%le", tb_borrowed);
+			frl_dump_var("%i", params->borrow_mode);
+			frl_dump_var("%i", tb_worst);
+		}
+#endif
+	if (!(tb_borrowed <= DML2_FRL_CHK_TB_BORROWED_MAX))
+		return LIB_FRL_CAP_CHECK_ERROR_MAX_BORROW;
+
+	c_frl_actual_target_payload = (int)math_ceil(3.0 / 2.0 * hc_active_target) + hc_blank_target;
+	utilization_targeted = c_frl_actual_target_payload / inter->c_frl_line;
+	margin_target = 1.0 - (utilization_targeted + inter->overhead_max);
+#if defined(DEBUG_FRL_CAP_CHK)
+		{
+			frl_dump_var("%i", c_frl_actual_target_payload);
+			frl_dump_var("%le", utilization_targeted);
+			frl_dump_var("%le", margin_target);
+		}
+#endif
+	// oversubscribed bandwidth relative to margin
+	if (margin_target < 0 && math_fabs(margin_target) > EPSILON)
+		return LIB_FRL_CAP_CHECK_ERROR_MARGIN;
+
+	return LIB_FRL_CAP_CHECK_OK;
+}
+
+enum lib_frl_cap_check_status frl_cap_check(struct lib_frl_cap_check_params *params)
+{
+	struct lib_frl_cap_check_intermediates inter;
+	return frl_cap_check_intermediates(params, &inter);
+}
+
+enum lib_frl_cap_check_status frl_cap_check_intermediates(struct lib_frl_cap_check_params *params, struct lib_frl_cap_check_intermediates *inter)
+{
+	if (params->compressed)
+		return frl_cap_check_compressed(params, inter);
+	return frl_cap_check_uncompressed(params, inter);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.h
new file mode 100644
index 000000000000..aa2764856546
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.h
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2024 Advanced Micro Devices, Inc.
+
+#ifndef __LIB_FRL_CAP_CHECK_H__
+#define __LIB_FRL_CAP_CHECK_H__
+
+#include "dml2_external_lib_deps.h"
+
+extern const int DML2_FRL_CHK_TB_BORROWED_MAX;
+
+enum lib_frl_cap_check_pixel_encoding {
+	LIB_FRL_CAP_CHECK_PIXEL_ENCODING_444,
+	LIB_FRL_CAP_CHECK_PIXEL_ENCODING_422,
+	LIB_FRL_CAP_CHECK_PIXEL_ENCODING_420
+};
+
+enum lib_frl_cap_check_borrow_mode {
+	LIB_FRL_CAP_CHECK_BORROW_MODE_NONE,
+	LIB_FRL_CAP_CHECK_BORROW_MODE_FROM_ACTIVE,
+	LIB_FRL_CAP_CHECK_BORROW_MODE_FROM_BLANK
+};
+
+enum lib_frl_cap_check_status {
+	LIB_FRL_CAP_CHECK_OK = 0,
+
+	LIB_FRL_CAP_CHECK_ERROR_AUDIO_BW = -1,
+	LIB_FRL_CAP_CHECK_ERROR_BORROW = -2,
+	LIB_FRL_CAP_CHECK_ERROR_MAX_BORROW = -3,
+	LIB_FRL_CAP_CHECK_ERROR_MARGIN = -4,
+
+	LIB_FRL_CAP_CHECK_ERROR_UNSUPPORTED_AUDIO = -1000
+};
+
+struct lib_frl_cap_check_intermediates {
+	int c_frl_sb;
+	double overhead_sb;
+	double overhead_rs;
+	double overhead_map;
+	double overhead_min;
+	double overhead_max;
+	double f_pixel_clock_max;
+	double t_line;
+	double r_bit_min;
+	double r_frl_char_min;
+	double c_frl_line;
+	double ap;
+	double r_ap;
+	double avg_audio_packets_line;
+	int audio_packets_line;
+	int blank_audio_min;
+};
+
+struct lib_frl_cap_check_params {
+	int lanes;
+	double f_pixel_clock_nominal; /* Pixel Clock rate (Hz) */
+	double r_bit_nominal; /* FRL bitrate (bps) */
+	int audio_packet_type;
+	double f_audio; /* Audio rate (Hz) */
+	int h_active; /* Active pixels per line */
+	int h_blank; /* Blanking pixels per line */
+	int bpc; /* Bits per component */
+
+	enum lib_frl_cap_check_pixel_encoding pixel_encoding;
+
+	bool compressed;
+	bool bypass_hc_target_calc;
+
+	/* DSC parameters */
+	int slices;
+	int slice_width;
+	double bpp_target;
+
+	int layout; /* not supported */
+	int acat; /* not supported */
+
+	/* outputs */
+	int audio_packets_line;
+
+	/* inputs or outputs */
+	int hc_active_target;
+	int hc_blank_target;
+
+	enum lib_frl_cap_check_borrow_mode borrow_mode;
+};
+
+enum lib_frl_cap_check_status frl_cap_check(struct lib_frl_cap_check_params *params);
+enum lib_frl_cap_check_status frl_cap_check_intermediates(struct lib_frl_cap_check_params *params, struct lib_frl_cap_check_intermediates *inter);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
index 0d8ff236c6d0..166f10b8862f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
@@ -808,6 +808,9 @@ static void populate_dml_output_cfg_from_stream_state(struct dml_output_cfg_st *
 	case SIGNAL_TYPE_DVI_DUAL_LINK:
 		out->OutputEncoder[location] = dml_hdmi;
 		break;
+	case SIGNAL_TYPE_HDMI_FRL:
+		out->OutputEncoder[location] = dml_hdmifrl;
+		break;
 	default:
 		out->OutputEncoder[location] = dml_dp;
 	}
@@ -883,6 +886,7 @@ static void populate_dml_output_cfg_from_stream_state(struct dml_output_cfg_st *
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 	case SIGNAL_TYPE_EDP:
 	case SIGNAL_TYPE_VIRTUAL:
+	case SIGNAL_TYPE_HDMI_FRL:
 	default:
 		out->OutputLinkDPRate[location] = dml_dp_rate_na;
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
index 1bc81e26a11f..cc8a603ce0f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
@@ -173,6 +173,8 @@ bool is_dtbclk_required(const struct dc *dc, struct dc_state *context)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
+		if (dc_is_hdmi_frl_signal(context->res_ctx.pipe_ctx[i].stream->signal))
+			return true;
 		if (is_dp2p0_output_encoder(&context->res_ctx.pipe_ctx[i]))
 			return true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c
new file mode 100644
index 000000000000..a638c0d6d765
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c
@@ -0,0 +1,413 @@
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
+#include "dml_frl_cap_chk.h"
+#include "display_mode_util.h"
+#include "lib_frl_cap_check.h"
+
+#define frl_dump_var(fmt, var) {}
+#define frl_print(fmt, ...) {}
+#include "dcn_calc_math.h"
+#define fabs(var) dcn_bw_fabs(var)
+#define floor(var) dcn_bw_floor(var)
+#define ceil(var) dcn_bw_ceil(var)
+
+#if !defined(TB_BORROWED_MAX)
+#define TB_BORROWED_MAX 400
+#endif
+
+static const double   EPSILON               = 0.01;
+static const double   DBL_EPSILON           = 2.2204460492503131e-16;
+static const int      C_FRL_CB              = 510;
+static const double   OVERHEAD_M            = 0.003;  /* %   */
+static const double   TOLERANCE_PIXEL_CLOCK = 0.005;  /* %   */
+static const double   TOLERANCE_AUDIO_CLOCK = 1000;   /* ppm */
+static const int      TOLERANCE_FRL_BIT     = 300;    /* ppm */
+static const int      ACR_RATE_MAX          = 1500;
+
+static frl_cap_chk_result frl_cap_chk_common(frl_cap_chk_intermediates *inter, frl_cap_chk_params *params)
+{
+	double   audio_bw_reserve = (params->compressed ? 192000.0 : 0.0);
+/*
+	if (getenv("DEBUG_FRL_CAP_CHK"))
+	{
+		printf("frl_cap_chk inputs:\n");
+		printf("-------------------\n");
+		frl_dump_var("%i", params->lanes);
+		frl_dump_var("%le", params->f_pixel_clock_nominal);
+		frl_dump_var("%le", params->r_bit_nominal);
+		frl_dump_var("%i", params->audio_packet_type);
+		frl_dump_var("%le", params->f_audio);
+		frl_dump_var("%i", params->h_active);
+		frl_dump_var("%i", params->h_blank);
+		frl_dump_var("%i", params->bpc);
+		frl_dump_var("%i", params->pixel_encoding);
+		frl_dump_var("%i", params->compressed);
+		frl_dump_var("%i", params->slices);
+		frl_dump_var("%i", params->slice_width);
+		frl_dump_var("%le", params->bpp_target);
+		frl_dump_var("%i", params->layout);
+		frl_dump_var("%i", params->acat);
+		printf("frl_cap_chk outputs:\n");
+		printf("---------------------\n");
+	}
+*/
+	inter->c_frl_sb = 4 * C_FRL_CB + params->lanes;
+	inter->overhead_sb = (double) params->lanes / inter->c_frl_sb;
+	inter->overhead_rs = 8.0 * 4.0 / inter->c_frl_sb;
+	inter->overhead_map = 2.5 / inter->c_frl_sb;
+	inter->overhead_min = inter->overhead_sb + inter->overhead_rs + inter->overhead_map;
+	inter->overhead_max = inter->overhead_min + OVERHEAD_M;
+	inter->f_pixel_clock_max = params->f_pixel_clock_nominal * (1.0 + TOLERANCE_PIXEL_CLOCK);
+	inter->t_line = (params->h_active + params->h_blank) / inter->f_pixel_clock_max;
+	inter->r_bit_min = params->r_bit_nominal * (1.0 - TOLERANCE_FRL_BIT / 1000000.0);
+	inter->r_frl_char_min = inter->r_bit_min / 18.0;
+	inter->c_frl_line = floor(inter->t_line * inter->r_frl_char_min * params->lanes);
+/*
+	if (getenv("DEBUG_FRL_CAP_CHK"))
+	{
+		frl_dump_var("%i", inter->c_frl_sb);
+		frl_dump_var("%le", inter->overhead_sb);
+		frl_dump_var("%le", inter->overhead_rs);
+		frl_dump_var("%le", inter->overhead_map);
+		frl_dump_var("%le", inter->overhead_min);
+		frl_dump_var("%le", inter->overhead_max);
+		frl_dump_var("%le", inter->f_pixel_clock_max);
+		frl_dump_var("%le", inter->t_line);
+		frl_dump_var("%le", inter->r_bit_min);
+		frl_dump_var("%le", inter->r_frl_char_min);
+		frl_dump_var("%le", inter->c_frl_line);
+	}
+*/
+	switch (params->audio_packet_type) {
+	case 0x02:
+		/* unsupported
+	case 0x07:
+		*/
+		if (params->layout == 0)
+			inter->ap = 0.25;
+		else if (params->layout == 1)
+			inter->ap = 1.0;
+		break;
+	case 0x08:
+		inter->ap = 0.25;
+		break;
+	case 0x09:
+		/* unsupported
+	case 0x0e:
+	case 0x0f:
+		*/
+		inter->ap = 1.0;
+		break;
+		/* unsupported
+	case 0x0b:
+	case 0x0c:
+		if (acat == 0x01)
+			ap = 2.0;
+		else if (acat == 0x02)
+			ap = 3.0;
+		else if (acat == 0x03)
+			ap = 4.0;
+		break;
+		*/
+	case 0x07:
+	case 0x0e:
+	case 0x0f:
+	case 0x0b:
+	case 0x0c:
+		// Unsupported audio format
+		return FRL_CAP_CHK_ERROR_UNSUPPORTED_AUDIO;
+	default:
+		inter->ap = 0.0;
+	}
+
+	inter->r_ap                   = (dml_max(audio_bw_reserve, params->f_audio * inter->ap) + 2 * ACR_RATE_MAX) * (1 + TOLERANCE_AUDIO_CLOCK / 1000000.0);
+	inter->avg_audio_packets_line = inter->r_ap * inter->t_line;
+	inter->audio_packets_line     = (int)ceil(inter->avg_audio_packets_line);
+	inter->blank_audio_min        = 32 + 32 * inter->audio_packets_line; // h_blank_audio_min or hc_blank_audio_min
+
+	params->audio_packets_line = inter->audio_packets_line;
+/*
+	if (getenv("DEBUG_FRL_CAP_CHK"))
+	{
+		frl_dump_var("%le", inter->ap);
+		frl_dump_var("%le", inter->r_ap);
+		frl_dump_var("%le", inter->avg_audio_packets_line);
+		frl_dump_var("%i", inter->audio_packets_line);
+		frl_dump_var("%i", inter->blank_audio_min);
+	}
+*/
+	return FRL_CAP_CHK_OK;
+}
+
+
+static frl_cap_chk_result frl_cap_chk_uncompressed(frl_cap_chk_params *params, frl_cap_chk_intermediates *inter)
+{
+	frl_cap_chk_result	res;
+
+	int k_420;
+	double k_cd;
+	int c_frl_free;
+	int c_frl_rc_margin;
+	int c_frl_rc_savings;
+	int bpp;
+	double bytes_line;
+	int tb_active;
+	int tb_blank ;
+	double f_tb_average;
+	double t_active_ref;
+	double t_blank_ref;
+	double t_active_min;
+	double t_blank_min;
+	double t_borrowed;
+	double tb_borrowed;
+	int c_frl_actual_payload;
+	double utilization;
+	double margin;
+
+	res = frl_cap_chk_common(inter, params);
+	if (res != FRL_CAP_CHK_OK) {
+		return res;
+	}
+
+	k_420 = params->pixel_encoding == PIXEL_ENCODING_420 ? 2 : 1;
+	k_cd = params->pixel_encoding == PIXEL_ENCODING_422 ? 1.0 : params->bpc / 8.0;
+	c_frl_free = (int)dml_max(params->h_blank * k_cd / k_420 - 32 * (1 + inter->audio_packets_line) - 7, 0);
+	c_frl_rc_margin = 4;
+	c_frl_rc_savings = (int)floor(dml_max(((7.0/8.0) * c_frl_free) - c_frl_rc_margin, 0.0));
+	bpp = (int)(24 * k_cd / k_420);
+	bytes_line = bpp * params->h_active / 8.0;
+	tb_active = (int)ceil(bytes_line / 3);
+	tb_blank = (int)ceil(params->h_blank * k_cd / k_420);
+/*
+	if (getenv("DEBUG_FRL_CAP_CHK"))
+	{
+		frl_dump_var("%i", k_420);
+		frl_dump_var("%le", k_cd);
+		frl_dump_var("%i", c_frl_free);
+		frl_dump_var("%i", c_frl_rc_margin);
+		frl_dump_var("%i", c_frl_rc_savings);
+		frl_dump_var("%i", bpp);
+		frl_dump_var("%le", bytes_line);
+		frl_dump_var("%i", tb_active);
+		frl_dump_var("%i", tb_blank);
+	}
+*/
+	if (!(inter->blank_audio_min <= tb_blank)) {
+		frl_dump_var("%i", inter->blank_audio_min);
+		frl_dump_var("%i", tb_blank);
+		return FRL_CAP_CHK_ERROR_AUDIO_BW;
+	}
+
+	f_tb_average = (inter->f_pixel_clock_max / (params->h_active + params->h_blank)) * (tb_active + tb_blank);
+	t_active_ref = inter->t_line * ((double) params->h_active / (params->h_active + params->h_blank));
+	t_blank_ref  = inter->t_line * ((double) params->h_blank / (params->h_active + params->h_blank));
+	t_active_min = (3.0 / 2.0) * tb_active / (params->lanes * inter->r_frl_char_min * (1.0 - inter->overhead_max));
+	t_blank_min  = tb_blank / (params->lanes * inter->r_frl_char_min * (1.0 - inter->overhead_max));
+/*
+	if (getenv("DEBUG_FRL_CAP_CHK"))
+	{
+		frl_dump_var("%le", f_tb_average);
+		frl_dump_var("%le", t_active_ref);
+		frl_dump_var("%le", t_blank_ref);
+		frl_dump_var("%le", t_active_min);
+		frl_dump_var("%le", t_blank_min);
+	}
+*/
+	if ((t_active_ref >= t_active_min) && (t_blank_ref >= t_blank_min)) {
+		t_borrowed = 0;
+		params->borrow_mode = BORROW_MODE_NONE;
+	} else if ((t_active_ref < t_active_min) && (t_blank_ref >= t_blank_min)) {
+		t_borrowed = t_active_min - t_active_ref;
+		params->borrow_mode = BORROW_MODE_FROM_BLANK;
+	} else
+		return FRL_CAP_CHK_ERROR_BORROW;
+
+	tb_borrowed = ceil(t_borrowed * f_tb_average);
+/*
+	if (getenv("DEBUG_FRL_CAP_CHK"))
+	{
+		frl_dump_var("%le", tb_borrowed);
+		frl_dump_var("%i", params->borrow_mode);
+}
+*/
+	if (!(tb_borrowed <= TB_BORROWED_MAX))
+		return FRL_CAP_CHK_ERROR_MAX_BORROW;
+
+	c_frl_actual_payload = (int)ceil((3.0/2.0) * tb_active) + tb_blank - c_frl_rc_savings;
+	utilization          = c_frl_actual_payload / inter->c_frl_line;
+	margin               = 1.0 - (utilization + inter->overhead_max);
+/*
+	if (getenv("DEBUG_FRL_CAP_CHK"))
+	{
+		frl_dump_var("%i",  c_frl_actual_payload);
+		frl_dump_var("%le", utilization);
+		frl_dump_var("%le", margin);
+	}
+*/
+	if (margin < 0 && fabs(margin) > EPSILON)
+		return FRL_CAP_CHK_ERROR_MARGIN;
+
+	return FRL_CAP_CHK_OK;
+}
+
+
+
+static frl_cap_chk_result frl_cap_chk_compressed(frl_cap_chk_params *params, frl_cap_chk_intermediates *inter)
+{
+	frl_cap_chk_result          res;
+
+	int      c_frl_available;
+	int      c_frl_active_available;
+	int      c_frl_blank_available;
+	int      bytes_target;
+	int      hc_active_target;
+	int      hc_blank_target_est1;
+	int      hc_blank_target_est2;
+	int      hc_blank_target;
+	double   f_tb_average;
+	double   t_active_ref;
+	double   t_blank_ref;
+	double   t_active_target;
+	double   t_blank_target;
+	double   tb_borrowed;
+	int      c_frl_actual_target_payload;
+	double   utilization_targeted;
+	double   margin_target;
+
+	res = frl_cap_chk_common(inter, params);
+	if (res != FRL_CAP_CHK_OK)
+		return res;
+
+	c_frl_available        = (int)floor((1 - inter->overhead_max) * inter->c_frl_line);
+	c_frl_active_available = (int)floor(c_frl_available * ((double) params->h_active / (params->h_active + params->h_blank)));
+	(void) c_frl_active_available;
+	c_frl_blank_available  = (int)floor(c_frl_available * ((double) params->h_blank / (params->h_active + params->h_blank)));
+	(void) c_frl_blank_available;
+	bytes_target           = params->slices * (int)ceil(params->bpp_target * params->slice_width / 8.0);
+
+	if (!params->bypass_hc_target_calc)
+		hc_active_target = (int)ceil(bytes_target / 3.0);
+	else
+		hc_active_target = params->hc_active_target;
+
+	hc_blank_target_est1   = (int)ceil(hc_active_target * ((double) params->h_blank / params->h_active));
+	hc_blank_target_est2   = (int)dml_max(hc_blank_target_est1, inter->blank_audio_min);
+
+	if (!params->bypass_hc_target_calc) {
+		hc_blank_target = 4 * (int)floor(dml_min(hc_blank_target_est2, c_frl_available - 3.0/2.0 * hc_active_target) / 4.0);
+
+		params->hc_active_target = hc_active_target;
+		params->hc_blank_target = hc_blank_target;
+	} else {
+		hc_blank_target  = params->hc_blank_target;
+	}
+/*
+	if (getenv("DEBUG_FRL_CAP_CHK"))
+	{
+		frl_dump_var("%i", c_frl_available);
+		frl_dump_var("%i", c_frl_active_available);
+		frl_dump_var("%i", c_frl_blank_available);
+		frl_dump_var("%i", bytes_target);
+		frl_dump_var("%i", hc_active_target);
+		frl_dump_var("%i", hc_blank_target_est1);
+		frl_dump_var("%i", hc_blank_target_est2);
+		frl_dump_var("%i", hc_blank_target);
+	}
+*/
+	if (!(inter->blank_audio_min <= hc_blank_target)) {
+		frl_dump_var("%i", inter->blank_audio_min);
+		frl_dump_var("%i", hc_blank_target);
+		return FRL_CAP_CHK_ERROR_AUDIO_BW;
+	}
+
+	f_tb_average    = inter->f_pixel_clock_max / (params->h_active + params->h_blank) * (hc_active_target + hc_blank_target);
+	t_active_ref    = inter->t_line * ((double) params->h_active / (params->h_active + params->h_blank));
+	t_blank_ref     = inter->t_line - t_active_ref; // * ((double) params->h_blank / (params->h_active + params->h_blank));
+	t_active_target = dml_max((hc_active_target / f_tb_average), (3.0/2.0 * hc_active_target)/(params->lanes * inter->r_frl_char_min * (1.0 - inter->overhead_max)));
+	t_blank_target  = inter->t_line - t_active_target;
+
+	tb_borrowed     = t_active_target * f_tb_average - hc_active_target;
+/*
+	if (getenv("DEBUG_FRL_CAP_CHK"))
+	{
+		frl_dump_var("%le", f_tb_average);
+		frl_dump_var("%le", t_active_ref);
+		frl_dump_var("%le", t_blank_ref);
+		frl_dump_var("%le", t_active_target);
+		frl_dump_var("%le", t_blank_target);
+		frl_dump_var("%le", tb_delta);
+	}
+*/
+	if (t_blank_target - t_blank_ref > DBL_EPSILON) {
+		params->borrow_mode = BORROW_MODE_FROM_ACTIVE;
+	} else if (t_active_target - t_active_ref > DBL_EPSILON) {
+		params->borrow_mode = BORROW_MODE_FROM_BLANK;
+	} else {
+		params->borrow_mode = BORROW_MODE_NONE;
+	}
+
+/*
+	if (getenv("DEBUG_FRL_CAP_CHK"))
+	{
+		frl_dump_var("%le", tb_delta_limit);
+		frl_dump_var("%le", tb_borrowed);
+		frl_dump_var("%i", params->borrow_mode);
+		frl_dump_var("%i", tb_worst);
+	}
+*/
+	if (!(tb_borrowed <= TB_BORROWED_MAX))
+		return FRL_CAP_CHK_ERROR_MAX_BORROW;
+
+	c_frl_actual_target_payload = (int)ceil(3.0/2.0 * hc_active_target) + hc_blank_target;
+	utilization_targeted        = c_frl_actual_target_payload / inter->c_frl_line;
+	margin_target               = 1.0 - (utilization_targeted + inter->overhead_max);
+/*
+	if (getenv("DEBUG_FRL_CAP_CHK"))
+	{
+		frl_dump_var("%i", c_frl_actual_target_payload);
+		frl_dump_var("%le", utilization_targeted);
+		frl_dump_var("%le", margin_target);
+	}
+*/
+	// oversubscribed bandwidth relative to margin
+	if (margin_target < 0 && fabs(margin_target) > EPSILON)
+		return FRL_CAP_CHK_ERROR_MARGIN;
+
+	return FRL_CAP_CHK_OK;
+}
+
+frl_cap_chk_result frl_cap_chk(frl_cap_chk_params *params)
+{
+	frl_cap_chk_intermediates   inter;
+	return frl_cap_chk_inter(params, &inter);
+}
+
+frl_cap_chk_result frl_cap_chk_inter(frl_cap_chk_params *params, frl_cap_chk_intermediates *inter)
+{
+	if (params->compressed)
+		return frl_cap_chk_compressed(params, inter);
+	return frl_cap_chk_uncompressed(params, inter);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h
new file mode 100644
index 000000000000..87ac9b94e98b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h
@@ -0,0 +1,109 @@
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
+#ifndef __DML_FRL_CAP_CHK_H__
+#define __DML_FRL_CAP_CHK_H__
+
+#include "os_types.h"
+
+typedef enum {
+	PIXEL_ENCODING_444,
+	PIXEL_ENCODING_422,
+	PIXEL_ENCODING_420
+} enum_pixel_encoding;
+
+typedef enum {
+	BORROW_MODE_NONE,
+	BORROW_MODE_FROM_ACTIVE,
+	BORROW_MODE_FROM_BLANK
+} enum_borrow_mode;
+
+typedef enum {
+	FRL_CAP_CHK_OK = 0,
+
+	FRL_CAP_CHK_ERROR_AUDIO_BW = -1,
+	FRL_CAP_CHK_ERROR_BORROW = -2,
+	FRL_CAP_CHK_ERROR_MAX_BORROW = -3,
+	FRL_CAP_CHK_ERROR_MARGIN = -4,
+
+	FRL_CAP_CHK_ERROR_UNSUPPORTED_AUDIO = -1000
+} frl_cap_chk_result;
+
+typedef struct {
+	int c_frl_sb;
+	double overhead_sb;
+	double overhead_rs;
+	double overhead_map;
+	double overhead_min;
+	double overhead_max;
+	double f_pixel_clock_max;
+	double t_line;
+	double r_bit_min;
+	double r_frl_char_min;
+	double c_frl_line;
+	double ap;
+	double r_ap;
+	double avg_audio_packets_line;
+	int audio_packets_line;
+	int blank_audio_min;
+} frl_cap_chk_intermediates;
+
+typedef struct {
+	int lanes;
+	double f_pixel_clock_nominal; /* Pixel Clock rate (Hz) */
+	double r_bit_nominal; /* FRL bitrate (bps) */
+	int audio_packet_type;
+	double f_audio; /* Audio rate (Hz) */
+	int h_active; /* Active pixels per line */
+	int h_blank; /* Blanking pixels per line */
+	int bpc; /* Bits per component */
+
+	enum_pixel_encoding pixel_encoding;
+
+	bool compressed;
+	bool bypass_hc_target_calc;
+
+	/* DSC parameters */
+	int slices;
+	int slice_width;
+	double bpp_target;
+
+	int layout; /* not supported */
+	int acat; /* not supported */
+
+	/* outputs */
+	int audio_packets_line;
+
+	/* inputs or outputs */
+	int hc_active_target;
+	int hc_blank_target;
+
+	enum_borrow_mode borrow_mode;
+} frl_cap_chk_params;
+
+frl_cap_chk_result frl_cap_chk(frl_cap_chk_params *params);
+frl_cap_chk_result frl_cap_chk_inter(frl_cap_chk_params *params, frl_cap_chk_intermediates *inter);
+
+#endif
-- 
2.54.0

