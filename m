Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6463C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD732399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipwDFrNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD732399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7EF6ED72;
	Fri, 25 Sep 2020 20:11:35 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B216ED75
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:35 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id f142so4064436qke.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hWgP8zDBjSBdxoW0JuFFRsc6hfdGhhTMo0RFTbVy4TQ=;
 b=ipwDFrNqGaJQyFBkm3KeSQCKqKOM6GXXwaQpAfJ+uxWPuxgif+JuMQ0/LT2QQ+9p7U
 JXn5OluYYJkkCHu12Xy3FSMPr+mbvn598Q2J0O8YBabL8+oSLTigfU6IGXC1ZfzFi/Kj
 qJ4IT+rWw2YjS7G4loFlSVb5mAN1Wli26lhYjiytIwPVg+QrmkCtV9FM1mSO3DcvLr41
 FOYLuQ5+v7KDjc2YwBMShGVW22LlsDT6ToYYgvfM14UUYjRKsQctO1a6fAv8o+8nrV8r
 9LPjKuIGRTEXWAgT4GKq7i0ghOVfb1tyczFQrXwfId40yLlqZECokxlFhDqJ/TURKstL
 YiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hWgP8zDBjSBdxoW0JuFFRsc6hfdGhhTMo0RFTbVy4TQ=;
 b=ipzg9bUSRbOdxSNUlGR5UjrMY1ououW4BjgWS6nmOIdPKOHQbOA1MoYKZfVu72KDlg
 TabL6ulUenEIza0jo73ySCFWwHnNlt+881Sryy73I92FYcFH5ddUbrexIZGgfqk8zd5o
 UNe08HTkuA7Ntm+1JM4sHpJSHCjwkRlPn9MID8YGUbWEqY4AFE8B0z+KhCN5Bp+VvldH
 7DP31pB+ffxfZzuVPYjk5ZSIPnLg18EZxq97PC9hq7RZfMQGt6+aPtcA13PgXc0wDs33
 WcGyagqTonGMaRjWUKfB0nRzanfzr7ZJparmmZhOkN5n4jHlv435uQS/2AjE2o77drHn
 xNOw==
X-Gm-Message-State: AOAM530YePweqREKV+XQa84CsKz2CikNQENZQptG+iECUSQ0Jj2ntdVU
 s4tB58J7PjCJ1xF4K7T3drJeZez8W2I=
X-Google-Smtp-Source: ABdhPJy/HGB6+AWCtKRZSbWQfxRKk+RjfVgw2oV5GjK4WNxuoLDVByh3YE9ISvycUQdHrYzB+SPXGw==
X-Received: by 2002:a05:620a:1411:: with SMTP id
 d17mr1713280qkj.325.1601064694498; 
 Fri, 25 Sep 2020 13:11:34 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:34 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/45] drm/amdgpu/powerplay: add smu v11.5 firmware header for
 vangogh (v2)
Date: Fri, 25 Sep 2020 16:10:12 -0400
Message-Id: <20200925201029.1738724-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

This patch is to add smu v11.5 firmware header for vangogh

v2: squash in updates

Signed-off-by: Xiaojian Du <xiaojian.du@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h | 120 ++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
new file mode 100644
index 000000000000..abf13abd3919
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
@@ -0,0 +1,120 @@
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
+ */
+
+#ifndef __SMU_V11_5_0_PMFW_H__
+#define __SMU_V11_5_0_PMFW_H__
+
+#include "smu11_driver_if_vangogh.h"
+
+#pragma pack(push, 1)
+
+#define ENABLE_DEBUG_FEATURES
+
+// Feature Control Defines
+#define FEATURE_CCLK_DPM_BIT           0
+#define FEATURE_FAN_CONTROLLER_BIT     1
+#define FEATURE_DATA_CALCULATION_BIT   2
+#define FEATURE_PPT_BIT                3
+#define FEATURE_TDC_BIT                4
+#define FEATURE_THERMAL_BIT            5
+#define FEATURE_FIT_BIT                6
+#define FEATURE_EDC_BIT                7
+#define FEATURE_PLL_POWER_DOWN_BIT     8
+#define FEATURE_ULV_BIT                9
+#define FEATURE_VDDOFF_BIT            10
+#define FEATURE_VCN_DPM_BIT           11
+#define FEATURE_CSTATE_BOOST_BIT      12
+#define FEATURE_FCLK_DPM_BIT          13
+#define FEATURE_SOCCLK_DPM_BIT        14
+#define FEATURE_MP0CLK_DPM_BIT        15
+#define FEATURE_LCLK_DPM_BIT          16
+#define FEATURE_SHUBCLK_DPM_BIT       17
+#define FEATURE_DCFCLK_DPM_BIT        18
+#define FEATURE_GFX_DPM_BIT           19
+#define FEATURE_DS_GFXCLK_BIT         20
+#define FEATURE_DS_SOCCLK_BIT         21
+#define FEATURE_DS_LCLK_BIT           22
+#define FEATURE_DS_DCFCLK_BIT         23
+#define FEATURE_DS_SHUBCLK_BIT        24
+#define FEATURE_GFX_TEMP_VMIN_BIT     25
+#define FEATURE_S0I2_BIT              26
+#define FEATURE_WHISPER_MODE_BIT      27
+#define FEATURE_DS_FCLK_BIT           28
+#define FEATURE_DS_SMNCLK_BIT         29
+#define FEATURE_DS_MP1CLK_BIT         30
+#define FEATURE_DS_MP0CLK_BIT         31
+#define FEATURE_SMU_LOW_POWER_BIT     32
+#define FEATURE_FUSE_PG_BIT           33
+#define FEATURE_GFX_DEM_BIT           34
+#define FEATURE_PSI_BIT               35
+#define FEATURE_PROCHOT_BIT           36
+#define FEATURE_CPUOFF_BIT            37
+#define FEATURE_STAPM_BIT             38
+#define FEATURE_S0I3_BIT              39
+#define FEATURE_DF_CSTATES_BIT        40
+#define FEATURE_PERF_LIMIT_BIT        41
+#define FEATURE_CORE_DLDO_BIT         42
+#define FEATURE_RSMU_LOW_POWER_BIT    43
+#define FEATURE_SMN_LOW_POWER_BIT     44
+#define FEATURE_THM_LOW_POWER_BIT     45
+#define FEATURE_SMUIO_LOW_POWER_BIT   46
+#define FEATURE_MP1_LOW_POWER_BIT     47
+#define FEATURE_DS_VCN_BIT            48
+#define FEATURE_CPPC_BIT              49
+#define FEATURE_OS_CSTATES_BIT        50
+#define FEATURE_ISP_DPM_BIT           51
+#define FEATURE_A55_DPM_BIT           52
+#define FEATURE_CVIP_DSP_DPM_BIT      53
+#define FEATURE_MSMU_LOW_POWER_BIT    54
+#define FEATURE_SOC_VOLTAGE_MON_BIT   55
+#define FEATURE_ATHUB_PG_BIT          56
+#define FEATURE_ECO_DEEPCSTATE_BIT    57
+#define FEATURE_CC6                   58
+#define NUM_FEATURES                  59
+
+typedef struct {
+  // MP1_EXT_SCRATCH0
+  uint32_t DpmHandlerID         : 8;
+  uint32_t ActivityMonitorID    : 8;
+  uint32_t DpmTimerID           : 8;
+  uint32_t spare0               : 8;
+  // MP1_EXT_SCRATCH1
+  uint32_t GfxStatus            : 2;
+  uint32_t GfxoffStatus         : 8;
+  uint32_t CpuOff               : 1;
+  uint32_t VddOff               : 1;
+  uint32_t InUlv                : 1;
+  uint32_t InS0i2               : 2;
+  uint32_t InWhisperMode        : 1;
+  uint32_t spare1               : 16;
+  // MP1_EXT_SCRATCH2
+  uint32_t P2JobHandler			: 32;
+  // MP1_EXT_SCRATCH3
+//  uint32_t spare2               : 32;
+  // MP1_EXT_SCRATCH4:6 are used by Kernel
+} FwStatus_t;
+
+
+#pragma pack(pop)
+
+#endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
