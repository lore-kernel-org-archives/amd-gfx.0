Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD18DC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BF52077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3Ab5Z2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BF52077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF0B6E297;
	Mon,  1 Jun 2020 18:04:01 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C1556E297
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:00 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id v79so9908582qkb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8+Cr+a+OEV6N+ExgNxDePkgALyjDyVJCu7LYO+G6zhI=;
 b=O3Ab5Z2eJsceM1qveMfdFMkvi2hz1BQVXlAIb97GSThOmb0/0ueOhES7BRSXKyy8ly
 fQsl8CprhGxvhc6N8C0SnTqc9x8Oql1OSZxvGG5izr4mX/hbgbAh1yXWaQtjYwFvpcWy
 CNFH/ehZoV6tDup7S64rHQ4a/rdfRsG++L4F83u9PdbwmBQV/Oxa2T7IPTszPvaejAgf
 FZBw1zUBY7iyZluZErP5Ckc+4yIyIMAQre5J6eFD4NueccxnekPEENI9BKoRPw/0qa5U
 KbpyTU/ykR8oRVQuWk8mdz3bGNuDXU00ZR51NWay0Gy9DdsfunWlkJP4VvPHjygh77pH
 Mx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8+Cr+a+OEV6N+ExgNxDePkgALyjDyVJCu7LYO+G6zhI=;
 b=RWQAZ4jAdrCP1bGlOuMcoa1BL8uPZtUshrqXHGsN7uF5o6zEbhhQm8uJ7XJFEaOcQy
 v9R/cr06AvVzO9DnsEYPHyknrNcqh+kz5hEwBPKHRlGmgjUPRFcDgTYxuA7j58cW6X/q
 8f3F0CGYUCCiHJgJ7IIyg6M7cD2UNs3fgEuzTbUxdQuZOX3GRYi0/FLIrKFjEXJW5E+P
 oK5oR5SY/Bd9F38XN/7n9+YscK7azb+gzQTrnTqOgzlPGXsiSdkoE37yj/yeV45KckmA
 vclaokX4L0QalSvpnkL+5amogGMGGf+PzrFw/sPryFkzXnwiNWRuWmwVQ4pla1OpT1Kg
 Xuog==
X-Gm-Message-State: AOAM532fmrS+8eufG3pdSN+OjHMPp6JKL5gylHG4Q1wpdRYt1Rek2k1S
 HtXftkVDXJhODKajPkvD/hQ5TplB
X-Google-Smtp-Source: ABdhPJzJxthc+CRGXiVb76BBDYpYiAivNfdmOXej3WvQaRuEEqGZfhO4Q5bKcswBwzogf1NBFk1MNw==
X-Received: by 2002:a37:a89:: with SMTP id 131mr20713775qkk.92.1591034639321; 
 Mon, 01 Jun 2020 11:03:59 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:58 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 051/207] drm/amdgpu: add support for athub v2.1
Date: Mon,  1 Jun 2020 14:00:03 -0400
Message-Id: <20200601180239.1267430-48-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add athub v2.1 function and support to compile it.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   3 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c | 100 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.h |  30 +++++++
 3 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v2_1.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index e78674121dfe..38b6ec10751f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -163,7 +163,8 @@ amdgpu-y += \
 # add ATHUB block
 amdgpu-y += \
 	athub_v1_0.o \
-	athub_v2_0.o
+	athub_v2_0.o \
+	athub_v2_1.o
 
 # add amdkfd interfaces
 amdgpu-y += amdgpu_amdkfd.o
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
new file mode 100644
index 000000000000..0219bd6ce1b2
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
@@ -0,0 +1,100 @@
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
+ */
+
+#include "amdgpu.h"
+#include "athub_v2_1.h"
+
+#include "athub/athub_2_1_0_offset.h"
+#include "athub/athub_2_1_0_sh_mask.h"
+#include "navi10_enum.h"
+
+#include "soc15_common.h"
+
+static void
+athub_v2_1_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+					    bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(ATHUB, 0, mmATHUB_MISC_CNTL);
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG))
+		data |= ATHUB_MISC_CNTL__CG_ENABLE_MASK;
+	else
+		data &= ~ATHUB_MISC_CNTL__CG_ENABLE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(ATHUB, 0, mmATHUB_MISC_CNTL, data);
+}
+
+static void
+athub_v2_1_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+					   bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(ATHUB, 0, mmATHUB_MISC_CNTL);
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS) &&
+	    (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
+		data |= ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
+	else
+		data &= ~ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
+
+	if(def != data)
+		WREG32_SOC15(ATHUB, 0, mmATHUB_MISC_CNTL, data);
+}
+
+int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
+			       enum amd_clockgating_state state)
+{
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		athub_v2_1_update_medium_grain_clock_gating(adev,
+				state == AMD_CG_STATE_GATE ? true : false);
+		athub_v2_1_update_medium_grain_light_sleep(adev,
+				state == AMD_CG_STATE_GATE ? true : false);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+void athub_v2_1_get_clockgating(struct amdgpu_device *adev, u32 *flags)
+{
+	int data;
+
+	/* AMD_CG_SUPPORT_ATHUB_MGCG */
+	data = RREG32_SOC15(ATHUB, 0, mmATHUB_MISC_CNTL);
+	if (data & ATHUB_MISC_CNTL__CG_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_ATHUB_MGCG;
+
+	/* AMD_CG_SUPPORT_ATHUB_LS */
+	if (data & ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_ATHUB_LS;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.h b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.h
new file mode 100644
index 000000000000..5e6824c0f591
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.h
@@ -0,0 +1,30 @@
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
+ */
+#ifndef __ATHUB_V2_1_H__
+#define __ATHUB_V2_1_H__
+
+int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
+			       enum amd_clockgating_state state);
+void athub_v2_1_get_clockgating(struct amdgpu_device *adev, u32 *flags);
+
+#endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
