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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104C3C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C00207DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv+/7+SS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C00207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F2A789FED;
	Mon,  1 Jun 2020 18:03:05 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1986489FED
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:04 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id q8so9920801qkm.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xZTiYMkfOIHhjZGJryvAw8dcGMRaNpkuFSzN8XA+I0s=;
 b=Sv+/7+SSZff8ImktbMiRLqXUxSkdk76DyD1prRZrSXKLLMv0tju8L7RdnfNbnQsBit
 dP02SMFa5fVa5t3NejM0FDzomDHBKI5vPYFqTcATiDp1R/itp4VpBS0gDpyHU/opxaHE
 4qIT63T8eKz2xU/hE1AN2r5CsRnj3nuCheM2THQNKDMUFK90XfnIt1FpmtMSVUExDQDe
 Rp4BzSiXwL7UaxF7yCUpELhjrtCrmRgzFAv/V+W+lg9CNcfAu9VPVTUAGOiWgXwYbkaa
 pFtumtUO53fYcUPLPTc3VPWrQSHHviIKOxLCF7WjakSVy1JrZQkM6YYURWKLWA0nZbiQ
 2mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xZTiYMkfOIHhjZGJryvAw8dcGMRaNpkuFSzN8XA+I0s=;
 b=YZdV7WDdoJ/ZJM0KvPli8mLuqE8HLlQjcbvMWsTcATvr3kVu/ol/EcjGZs7f/5AJII
 DKHFTfNlHDDtKwlpojLb8qAmuQtEKPWk9Mgpoj/koNhcidtoSrqnlz7wF5iTZoCHuUTQ
 rnBtxau7oPD4Kd7tiOBPsaaxR7Dme9S/aLJxyAt6VvmxepQtVPlhaSNWa56nxfAk3uUX
 CXCsJkO6DL4foNGdKo9ffRV1yQA16ZQwA7Jbp+24kbqRG+mZtbNOSCBdEKfxU3NFVBnU
 fiIVr00tZpgEq2sUPkjgbMetHN1v0doSix/1NCZ8kZhZPE39O9iKE16ieHe3doQcDVIT
 66AA==
X-Gm-Message-State: AOAM53196/ONdd1YCQOWNEkoQL/lvUv4gjvAAVDybd7VxdT5lW1PAE1c
 oBQ2FS8ZNU5r8TajIGV4qw+7PO/0
X-Google-Smtp-Source: ABdhPJwbj9Dlp/GR0mKVpOokBMEEK2Gq/Jv5AzuThJ7AZwMB/dUOpXYkXL1q2kBrjL7mXVWWf+/kzg==
X-Received: by 2002:a05:620a:1388:: with SMTP id
 k8mr21132319qki.216.1591034582088; 
 Mon, 01 Jun 2020 11:03:02 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:01 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 013/207] drm/amdgpu: initialize IP offset for sienna_cichlid
 (v2)
Date: Mon,  1 Jun 2020 13:59:25 -0400
Message-Id: <20200601180239.1267430-10-alexander.deucher@amd.com>
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

Add IP offset headers and state.

V2: squash in updates (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |    2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |    3 +
 drivers/gpu/drm/amd/amdgpu/nv.h               |    1 +
 .../drm/amd/amdgpu/sienna_cichlid_reg_init.c  |   54 +
 .../amd/include/sienna_cichlid_ip_offset.h    | 1168 +++++++++++++++++
 5 files changed, 1227 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sienna_cichlid_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 210d57a4afc8..0fdcb71a4feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -68,7 +68,7 @@ amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce
 amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
-	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o
+	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 642d18e70860..9466dc52df53 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -407,6 +407,9 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 		navi12_reg_base_init(adev);
 		break;
+	case CHIP_SIENNA_CICHLID:
+		sienna_cichlid_reg_base_init(adev);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index 82e6cb432f3d..b6a95f0122fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -32,4 +32,5 @@ int nv_set_ip_blocks(struct amdgpu_device *adev);
 int navi10_reg_base_init(struct amdgpu_device *adev);
 int navi14_reg_base_init(struct amdgpu_device *adev);
 int navi12_reg_base_init(struct amdgpu_device *adev);
+int sienna_cichlid_reg_base_init(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid_reg_init.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid_reg_init.c
new file mode 100644
index 000000000000..5ee69f70c49b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid_reg_init.c
@@ -0,0 +1,54 @@
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
+#include "amdgpu.h"
+#include "nv.h"
+
+#include "soc15_common.h"
+#include "soc15_hw_ip.h"
+#include "sienna_cichlid_ip_offset.h"
+
+int sienna_cichlid_reg_base_init(struct amdgpu_device *adev)
+{
+	/* HW has more IP blocks,  only initialized the blocke needed by driver */
+	uint32_t i;
+	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
+		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
+		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
+		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
+		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
+		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
+		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
+		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(VCN_BASE.instance[i]));
+		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
+		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DCN_BASE.instance[i]));
+		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
+		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SDMA2_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SDMA3_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
+		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
+	}
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h b/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
new file mode 100644
index 000000000000..06800c6fa049
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/sienna_cichlid_ip_offset.h
@@ -0,0 +1,1168 @@
+/*
+ * Copyright (C) 2019  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _sienna_cichlid_ip_offset_HEADER
+#define _sienna_cichlid_ip_offset_HEADER
+
+#define MAX_INSTANCE                                        7
+#define MAX_SEGMENT                                         5
+
+
+struct IP_BASE_INSTANCE
+{
+    unsigned int segment[MAX_SEGMENT];
+};
+
+struct IP_BASE
+{
+    struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
+};
+
+
+static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C00, 0x02408C00, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0 } },
+                                        { { 0x00016E00, 0x02401C00, 0, 0, 0 } },
+                                        { { 0x00017000, 0x02402000, 0, 0, 0 } },
+                                        { { 0x00017200, 0x02402400, 0, 0, 0 } },
+                                        { { 0x0001B000, 0x0242D800, 0, 0, 0 } },
+                                        { { 0x0001B200, 0x0242DC00, 0, 0, 0 } },
+                                        { { 0x0001B400, 0x0242E000, 0, 0, 0 } } } };
+static const struct IP_BASE DF_BASE = { { { { 0x00007000, 0x0240B800, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DIO_BASE = { { { { 0x02404000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DPCS_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE FUSE_BASE = { { { { 0x00017400, 0x02401400, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE GC_BASE = { { { { 0x00001260, 0x0000A000, 0x0001C000, 0x02402C00, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE HDA_BASE = { { { { 0x004C0000, 0x02404800, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE HDP_BASE = { { { { 0x00000F20, 0x0240A400, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MMHUB_BASE = { { { { 0x0001A000, 0x02408800, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0x00DC0000, 0x00E00000, 0x00E40000, 0x0243FC00 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MP1_BASE = { { { { 0x00016000, 0x00DC0000, 0x00E00000, 0x00E40000, 0x0243FC00 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE OSSSYS_BASE = { { { { 0x000010A0, 0x0240A000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE PCIE0_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SDMA0_BASE = { { { { 0x00001260, 0x0000A000, 0x0001C000, 0x02402C00, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SDMA1_BASE = { { { { 0x00001260, 0x0000A000, 0x0001C000, 0x02402C00, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SMUIO_BASE = { { { { 0x00016800, 0x00016A00, 0x00440000, 0x02401000, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE THM_BASE = { { { { 0x00016600, 0x02400C00, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x02425800, 0, 0, 0 } },
+                                        { { 0x00054000, 0x02425C00, 0, 0, 0 } },
+                                        { { 0x00094000, 0x02426000, 0, 0, 0 } },
+                                        { { 0x000D4000, 0x02426400, 0, 0, 0 } },
+                                        { { 0x00114000, 0x02426800, 0, 0, 0 } },
+                                        { { 0x00154000, 0x02426C00, 0, 0, 0 } },
+                                        { { 0x00194000, 0x02427000, 0, 0, 0 } } } };
+static const struct IP_BASE USB0_BASE = { { { { 0x0242A800, 0x05B00000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE VCN_BASE = { { { { 0x00007800, 0x00007E00, 0x02403000, 0, 0 } },
+                                        { { 0x00007B00, 0x00012000, 0x02445000, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+
+
+#define ATHUB_BASE__INST0_SEG0                     0x00000C00
+#define ATHUB_BASE__INST0_SEG1                     0x02408C00
+#define ATHUB_BASE__INST0_SEG2                     0
+#define ATHUB_BASE__INST0_SEG3                     0
+#define ATHUB_BASE__INST0_SEG4                     0
+
+#define ATHUB_BASE__INST1_SEG0                     0
+#define ATHUB_BASE__INST1_SEG1                     0
+#define ATHUB_BASE__INST1_SEG2                     0
+#define ATHUB_BASE__INST1_SEG3                     0
+#define ATHUB_BASE__INST1_SEG4                     0
+
+#define ATHUB_BASE__INST2_SEG0                     0
+#define ATHUB_BASE__INST2_SEG1                     0
+#define ATHUB_BASE__INST2_SEG2                     0
+#define ATHUB_BASE__INST2_SEG3                     0
+#define ATHUB_BASE__INST2_SEG4                     0
+
+#define ATHUB_BASE__INST3_SEG0                     0
+#define ATHUB_BASE__INST3_SEG1                     0
+#define ATHUB_BASE__INST3_SEG2                     0
+#define ATHUB_BASE__INST3_SEG3                     0
+#define ATHUB_BASE__INST3_SEG4                     0
+
+#define ATHUB_BASE__INST4_SEG0                     0
+#define ATHUB_BASE__INST4_SEG1                     0
+#define ATHUB_BASE__INST4_SEG2                     0
+#define ATHUB_BASE__INST4_SEG3                     0
+#define ATHUB_BASE__INST4_SEG4                     0
+
+#define ATHUB_BASE__INST5_SEG0                     0
+#define ATHUB_BASE__INST5_SEG1                     0
+#define ATHUB_BASE__INST5_SEG2                     0
+#define ATHUB_BASE__INST5_SEG3                     0
+#define ATHUB_BASE__INST5_SEG4                     0
+
+#define ATHUB_BASE__INST6_SEG0                     0
+#define ATHUB_BASE__INST6_SEG1                     0
+#define ATHUB_BASE__INST6_SEG2                     0
+#define ATHUB_BASE__INST6_SEG3                     0
+#define ATHUB_BASE__INST6_SEG4                     0
+
+#define CLK_BASE__INST0_SEG0                       0x00016C00
+#define CLK_BASE__INST0_SEG1                       0x02401800
+#define CLK_BASE__INST0_SEG2                       0
+#define CLK_BASE__INST0_SEG3                       0
+#define CLK_BASE__INST0_SEG4                       0
+
+#define CLK_BASE__INST1_SEG0                       0x00016E00
+#define CLK_BASE__INST1_SEG1                       0x02401C00
+#define CLK_BASE__INST1_SEG2                       0
+#define CLK_BASE__INST1_SEG3                       0
+#define CLK_BASE__INST1_SEG4                       0
+
+#define CLK_BASE__INST2_SEG0                       0x00017000
+#define CLK_BASE__INST2_SEG1                       0x02402000
+#define CLK_BASE__INST2_SEG2                       0
+#define CLK_BASE__INST2_SEG3                       0
+#define CLK_BASE__INST2_SEG4                       0
+
+#define CLK_BASE__INST3_SEG0                       0x00017200
+#define CLK_BASE__INST3_SEG1                       0x02402400
+#define CLK_BASE__INST3_SEG2                       0
+#define CLK_BASE__INST3_SEG3                       0
+#define CLK_BASE__INST3_SEG4                       0
+
+#define CLK_BASE__INST4_SEG0                       0x0001B000
+#define CLK_BASE__INST4_SEG1                       0x0242D800
+#define CLK_BASE__INST4_SEG2                       0
+#define CLK_BASE__INST4_SEG3                       0
+#define CLK_BASE__INST4_SEG4                       0
+
+#define CLK_BASE__INST5_SEG0                       0x0001B200
+#define CLK_BASE__INST5_SEG1                       0x0242DC00
+#define CLK_BASE__INST5_SEG2                       0
+#define CLK_BASE__INST5_SEG3                       0
+#define CLK_BASE__INST5_SEG4                       0
+
+#define CLK_BASE__INST6_SEG0                       0x0001B400
+#define CLK_BASE__INST6_SEG1                       0x0242E000
+#define CLK_BASE__INST6_SEG2                       0
+#define CLK_BASE__INST6_SEG3                       0
+#define CLK_BASE__INST6_SEG4                       0
+
+#define DF_BASE__INST0_SEG0                        0x00007000
+#define DF_BASE__INST0_SEG1                        0x0240B800
+#define DF_BASE__INST0_SEG2                        0
+#define DF_BASE__INST0_SEG3                        0
+#define DF_BASE__INST0_SEG4                        0
+
+#define DF_BASE__INST1_SEG0                        0
+#define DF_BASE__INST1_SEG1                        0
+#define DF_BASE__INST1_SEG2                        0
+#define DF_BASE__INST1_SEG3                        0
+#define DF_BASE__INST1_SEG4                        0
+
+#define DF_BASE__INST2_SEG0                        0
+#define DF_BASE__INST2_SEG1                        0
+#define DF_BASE__INST2_SEG2                        0
+#define DF_BASE__INST2_SEG3                        0
+#define DF_BASE__INST2_SEG4                        0
+
+#define DF_BASE__INST3_SEG0                        0
+#define DF_BASE__INST3_SEG1                        0
+#define DF_BASE__INST3_SEG2                        0
+#define DF_BASE__INST3_SEG3                        0
+#define DF_BASE__INST3_SEG4                        0
+
+#define DF_BASE__INST4_SEG0                        0
+#define DF_BASE__INST4_SEG1                        0
+#define DF_BASE__INST4_SEG2                        0
+#define DF_BASE__INST4_SEG3                        0
+#define DF_BASE__INST4_SEG4                        0
+
+#define DF_BASE__INST5_SEG0                        0
+#define DF_BASE__INST5_SEG1                        0
+#define DF_BASE__INST5_SEG2                        0
+#define DF_BASE__INST5_SEG3                        0
+#define DF_BASE__INST5_SEG4                        0
+
+#define DF_BASE__INST6_SEG0                        0
+#define DF_BASE__INST6_SEG1                        0
+#define DF_BASE__INST6_SEG2                        0
+#define DF_BASE__INST6_SEG3                        0
+#define DF_BASE__INST6_SEG4                        0
+
+#define DIO_BASE__INST0_SEG0                       0x02404000
+#define DIO_BASE__INST0_SEG1                       0
+#define DIO_BASE__INST0_SEG2                       0
+#define DIO_BASE__INST0_SEG3                       0
+#define DIO_BASE__INST0_SEG4                       0
+
+#define DIO_BASE__INST1_SEG0                       0
+#define DIO_BASE__INST1_SEG1                       0
+#define DIO_BASE__INST1_SEG2                       0
+#define DIO_BASE__INST1_SEG3                       0
+#define DIO_BASE__INST1_SEG4                       0
+
+#define DIO_BASE__INST2_SEG0                       0
+#define DIO_BASE__INST2_SEG1                       0
+#define DIO_BASE__INST2_SEG2                       0
+#define DIO_BASE__INST2_SEG3                       0
+#define DIO_BASE__INST2_SEG4                       0
+
+#define DIO_BASE__INST3_SEG0                       0
+#define DIO_BASE__INST3_SEG1                       0
+#define DIO_BASE__INST3_SEG2                       0
+#define DIO_BASE__INST3_SEG3                       0
+#define DIO_BASE__INST3_SEG4                       0
+
+#define DIO_BASE__INST4_SEG0                       0
+#define DIO_BASE__INST4_SEG1                       0
+#define DIO_BASE__INST4_SEG2                       0
+#define DIO_BASE__INST4_SEG3                       0
+#define DIO_BASE__INST4_SEG4                       0
+
+#define DIO_BASE__INST5_SEG0                       0
+#define DIO_BASE__INST5_SEG1                       0
+#define DIO_BASE__INST5_SEG2                       0
+#define DIO_BASE__INST5_SEG3                       0
+#define DIO_BASE__INST5_SEG4                       0
+
+#define DIO_BASE__INST6_SEG0                       0
+#define DIO_BASE__INST6_SEG1                       0
+#define DIO_BASE__INST6_SEG2                       0
+#define DIO_BASE__INST6_SEG3                       0
+#define DIO_BASE__INST6_SEG4                       0
+
+#define DCN_BASE__INST0_SEG0                       0x00000012
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+#define DCN_BASE__INST0_SEG3                       0x00009000
+#define DCN_BASE__INST0_SEG4                       0x02403C00
+
+#define DCN_BASE__INST1_SEG0                       0
+#define DCN_BASE__INST1_SEG1                       0
+#define DCN_BASE__INST1_SEG2                       0
+#define DCN_BASE__INST1_SEG3                       0
+#define DCN_BASE__INST1_SEG4                       0
+
+#define DCN_BASE__INST2_SEG0                       0
+#define DCN_BASE__INST2_SEG1                       0
+#define DCN_BASE__INST2_SEG2                       0
+#define DCN_BASE__INST2_SEG3                       0
+#define DCN_BASE__INST2_SEG4                       0
+
+#define DCN_BASE__INST3_SEG0                       0
+#define DCN_BASE__INST3_SEG1                       0
+#define DCN_BASE__INST3_SEG2                       0
+#define DCN_BASE__INST3_SEG3                       0
+#define DCN_BASE__INST3_SEG4                       0
+
+#define DCN_BASE__INST4_SEG0                       0
+#define DCN_BASE__INST4_SEG1                       0
+#define DCN_BASE__INST4_SEG2                       0
+#define DCN_BASE__INST4_SEG3                       0
+#define DCN_BASE__INST4_SEG4                       0
+
+#define DCN_BASE__INST5_SEG0                       0
+#define DCN_BASE__INST5_SEG1                       0
+#define DCN_BASE__INST5_SEG2                       0
+#define DCN_BASE__INST5_SEG3                       0
+#define DCN_BASE__INST5_SEG4                       0
+
+#define DCN_BASE__INST6_SEG0                       0
+#define DCN_BASE__INST6_SEG1                       0
+#define DCN_BASE__INST6_SEG2                       0
+#define DCN_BASE__INST6_SEG3                       0
+#define DCN_BASE__INST6_SEG4                       0
+
+#define DPCS_BASE__INST0_SEG0                      0x00000012
+#define DPCS_BASE__INST0_SEG1                      0x000000C0
+#define DPCS_BASE__INST0_SEG2                      0x000034C0
+#define DPCS_BASE__INST0_SEG3                      0x00009000
+#define DPCS_BASE__INST0_SEG4                      0x02403C00
+
+#define DPCS_BASE__INST1_SEG0                      0
+#define DPCS_BASE__INST1_SEG1                      0
+#define DPCS_BASE__INST1_SEG2                      0
+#define DPCS_BASE__INST1_SEG3                      0
+#define DPCS_BASE__INST1_SEG4                      0
+
+#define DPCS_BASE__INST2_SEG0                      0
+#define DPCS_BASE__INST2_SEG1                      0
+#define DPCS_BASE__INST2_SEG2                      0
+#define DPCS_BASE__INST2_SEG3                      0
+#define DPCS_BASE__INST2_SEG4                      0
+
+#define DPCS_BASE__INST3_SEG0                      0
+#define DPCS_BASE__INST3_SEG1                      0
+#define DPCS_BASE__INST3_SEG2                      0
+#define DPCS_BASE__INST3_SEG3                      0
+#define DPCS_BASE__INST3_SEG4                      0
+
+#define DPCS_BASE__INST4_SEG0                      0
+#define DPCS_BASE__INST4_SEG1                      0
+#define DPCS_BASE__INST4_SEG2                      0
+#define DPCS_BASE__INST4_SEG3                      0
+#define DPCS_BASE__INST4_SEG4                      0
+
+#define DPCS_BASE__INST5_SEG0                      0
+#define DPCS_BASE__INST5_SEG1                      0
+#define DPCS_BASE__INST5_SEG2                      0
+#define DPCS_BASE__INST5_SEG3                      0
+#define DPCS_BASE__INST5_SEG4                      0
+
+#define DPCS_BASE__INST6_SEG0                      0
+#define DPCS_BASE__INST6_SEG1                      0
+#define DPCS_BASE__INST6_SEG2                      0
+#define DPCS_BASE__INST6_SEG3                      0
+#define DPCS_BASE__INST6_SEG4                      0
+
+#define FUSE_BASE__INST0_SEG0                      0x00017400
+#define FUSE_BASE__INST0_SEG1                      0x02401400
+#define FUSE_BASE__INST0_SEG2                      0
+#define FUSE_BASE__INST0_SEG3                      0
+#define FUSE_BASE__INST0_SEG4                      0
+
+#define FUSE_BASE__INST1_SEG0                      0
+#define FUSE_BASE__INST1_SEG1                      0
+#define FUSE_BASE__INST1_SEG2                      0
+#define FUSE_BASE__INST1_SEG3                      0
+#define FUSE_BASE__INST1_SEG4                      0
+
+#define FUSE_BASE__INST2_SEG0                      0
+#define FUSE_BASE__INST2_SEG1                      0
+#define FUSE_BASE__INST2_SEG2                      0
+#define FUSE_BASE__INST2_SEG3                      0
+#define FUSE_BASE__INST2_SEG4                      0
+
+#define FUSE_BASE__INST3_SEG0                      0
+#define FUSE_BASE__INST3_SEG1                      0
+#define FUSE_BASE__INST3_SEG2                      0
+#define FUSE_BASE__INST3_SEG3                      0
+#define FUSE_BASE__INST3_SEG4                      0
+
+#define FUSE_BASE__INST4_SEG0                      0
+#define FUSE_BASE__INST4_SEG1                      0
+#define FUSE_BASE__INST4_SEG2                      0
+#define FUSE_BASE__INST4_SEG3                      0
+#define FUSE_BASE__INST4_SEG4                      0
+
+#define FUSE_BASE__INST5_SEG0                      0
+#define FUSE_BASE__INST5_SEG1                      0
+#define FUSE_BASE__INST5_SEG2                      0
+#define FUSE_BASE__INST5_SEG3                      0
+#define FUSE_BASE__INST5_SEG4                      0
+
+#define FUSE_BASE__INST6_SEG0                      0
+#define FUSE_BASE__INST6_SEG1                      0
+#define FUSE_BASE__INST6_SEG2                      0
+#define FUSE_BASE__INST6_SEG3                      0
+#define FUSE_BASE__INST6_SEG4                      0
+
+#define GC_BASE__INST0_SEG0                        0x00001260
+#define GC_BASE__INST0_SEG1                        0x0000A000
+#define GC_BASE__INST0_SEG2                        0x0001C000
+#define GC_BASE__INST0_SEG3                        0x02402C00
+#define GC_BASE__INST0_SEG4                        0
+
+#define GC_BASE__INST1_SEG0                        0
+#define GC_BASE__INST1_SEG1                        0
+#define GC_BASE__INST1_SEG2                        0
+#define GC_BASE__INST1_SEG3                        0
+#define GC_BASE__INST1_SEG4                        0
+
+#define GC_BASE__INST2_SEG0                        0
+#define GC_BASE__INST2_SEG1                        0
+#define GC_BASE__INST2_SEG2                        0
+#define GC_BASE__INST2_SEG3                        0
+#define GC_BASE__INST2_SEG4                        0
+
+#define GC_BASE__INST3_SEG0                        0
+#define GC_BASE__INST3_SEG1                        0
+#define GC_BASE__INST3_SEG2                        0
+#define GC_BASE__INST3_SEG3                        0
+#define GC_BASE__INST3_SEG4                        0
+
+#define GC_BASE__INST4_SEG0                        0
+#define GC_BASE__INST4_SEG1                        0
+#define GC_BASE__INST4_SEG2                        0
+#define GC_BASE__INST4_SEG3                        0
+#define GC_BASE__INST4_SEG4                        0
+
+#define GC_BASE__INST5_SEG0                        0
+#define GC_BASE__INST5_SEG1                        0
+#define GC_BASE__INST5_SEG2                        0
+#define GC_BASE__INST5_SEG3                        0
+#define GC_BASE__INST5_SEG4                        0
+
+#define GC_BASE__INST6_SEG0                        0
+#define GC_BASE__INST6_SEG1                        0
+#define GC_BASE__INST6_SEG2                        0
+#define GC_BASE__INST6_SEG3                        0
+#define GC_BASE__INST6_SEG4                        0
+
+#define HDA_BASE__INST0_SEG0                       0x004C0000
+#define HDA_BASE__INST0_SEG1                       0x02404800
+#define HDA_BASE__INST0_SEG2                       0
+#define HDA_BASE__INST0_SEG3                       0
+#define HDA_BASE__INST0_SEG4                       0
+
+#define HDA_BASE__INST1_SEG0                       0
+#define HDA_BASE__INST1_SEG1                       0
+#define HDA_BASE__INST1_SEG2                       0
+#define HDA_BASE__INST1_SEG3                       0
+#define HDA_BASE__INST1_SEG4                       0
+
+#define HDA_BASE__INST2_SEG0                       0
+#define HDA_BASE__INST2_SEG1                       0
+#define HDA_BASE__INST2_SEG2                       0
+#define HDA_BASE__INST2_SEG3                       0
+#define HDA_BASE__INST2_SEG4                       0
+
+#define HDA_BASE__INST3_SEG0                       0
+#define HDA_BASE__INST3_SEG1                       0
+#define HDA_BASE__INST3_SEG2                       0
+#define HDA_BASE__INST3_SEG3                       0
+#define HDA_BASE__INST3_SEG4                       0
+
+#define HDA_BASE__INST4_SEG0                       0
+#define HDA_BASE__INST4_SEG1                       0
+#define HDA_BASE__INST4_SEG2                       0
+#define HDA_BASE__INST4_SEG3                       0
+#define HDA_BASE__INST4_SEG4                       0
+
+#define HDA_BASE__INST5_SEG0                       0
+#define HDA_BASE__INST5_SEG1                       0
+#define HDA_BASE__INST5_SEG2                       0
+#define HDA_BASE__INST5_SEG3                       0
+#define HDA_BASE__INST5_SEG4                       0
+
+#define HDA_BASE__INST6_SEG0                       0
+#define HDA_BASE__INST6_SEG1                       0
+#define HDA_BASE__INST6_SEG2                       0
+#define HDA_BASE__INST6_SEG3                       0
+#define HDA_BASE__INST6_SEG4                       0
+
+#define HDP_BASE__INST0_SEG0                       0x00000F20
+#define HDP_BASE__INST0_SEG1                       0x0240A400
+#define HDP_BASE__INST0_SEG2                       0
+#define HDP_BASE__INST0_SEG3                       0
+#define HDP_BASE__INST0_SEG4                       0
+
+#define HDP_BASE__INST1_SEG0                       0
+#define HDP_BASE__INST1_SEG1                       0
+#define HDP_BASE__INST1_SEG2                       0
+#define HDP_BASE__INST1_SEG3                       0
+#define HDP_BASE__INST1_SEG4                       0
+
+#define HDP_BASE__INST2_SEG0                       0
+#define HDP_BASE__INST2_SEG1                       0
+#define HDP_BASE__INST2_SEG2                       0
+#define HDP_BASE__INST2_SEG3                       0
+#define HDP_BASE__INST2_SEG4                       0
+
+#define HDP_BASE__INST3_SEG0                       0
+#define HDP_BASE__INST3_SEG1                       0
+#define HDP_BASE__INST3_SEG2                       0
+#define HDP_BASE__INST3_SEG3                       0
+#define HDP_BASE__INST3_SEG4                       0
+
+#define HDP_BASE__INST4_SEG0                       0
+#define HDP_BASE__INST4_SEG1                       0
+#define HDP_BASE__INST4_SEG2                       0
+#define HDP_BASE__INST4_SEG3                       0
+#define HDP_BASE__INST4_SEG4                       0
+
+#define HDP_BASE__INST5_SEG0                       0
+#define HDP_BASE__INST5_SEG1                       0
+#define HDP_BASE__INST5_SEG2                       0
+#define HDP_BASE__INST5_SEG3                       0
+#define HDP_BASE__INST5_SEG4                       0
+
+#define HDP_BASE__INST6_SEG0                       0
+#define HDP_BASE__INST6_SEG1                       0
+#define HDP_BASE__INST6_SEG2                       0
+#define HDP_BASE__INST6_SEG3                       0
+#define HDP_BASE__INST6_SEG4                       0
+
+#define MMHUB_BASE__INST0_SEG0                     0x0001A000
+#define MMHUB_BASE__INST0_SEG1                     0x02408800
+#define MMHUB_BASE__INST0_SEG2                     0
+#define MMHUB_BASE__INST0_SEG3                     0
+#define MMHUB_BASE__INST0_SEG4                     0
+
+#define MMHUB_BASE__INST1_SEG0                     0
+#define MMHUB_BASE__INST1_SEG1                     0
+#define MMHUB_BASE__INST1_SEG2                     0
+#define MMHUB_BASE__INST1_SEG3                     0
+#define MMHUB_BASE__INST1_SEG4                     0
+
+#define MMHUB_BASE__INST2_SEG0                     0
+#define MMHUB_BASE__INST2_SEG1                     0
+#define MMHUB_BASE__INST2_SEG2                     0
+#define MMHUB_BASE__INST2_SEG3                     0
+#define MMHUB_BASE__INST2_SEG4                     0
+
+#define MMHUB_BASE__INST3_SEG0                     0
+#define MMHUB_BASE__INST3_SEG1                     0
+#define MMHUB_BASE__INST3_SEG2                     0
+#define MMHUB_BASE__INST3_SEG3                     0
+#define MMHUB_BASE__INST3_SEG4                     0
+
+#define MMHUB_BASE__INST4_SEG0                     0
+#define MMHUB_BASE__INST4_SEG1                     0
+#define MMHUB_BASE__INST4_SEG2                     0
+#define MMHUB_BASE__INST4_SEG3                     0
+#define MMHUB_BASE__INST4_SEG4                     0
+
+#define MMHUB_BASE__INST5_SEG0                     0
+#define MMHUB_BASE__INST5_SEG1                     0
+#define MMHUB_BASE__INST5_SEG2                     0
+#define MMHUB_BASE__INST5_SEG3                     0
+#define MMHUB_BASE__INST5_SEG4                     0
+
+#define MMHUB_BASE__INST6_SEG0                     0
+#define MMHUB_BASE__INST6_SEG1                     0
+#define MMHUB_BASE__INST6_SEG2                     0
+#define MMHUB_BASE__INST6_SEG3                     0
+#define MMHUB_BASE__INST6_SEG4                     0
+
+#define MP0_BASE__INST0_SEG0                       0x00016000
+#define MP0_BASE__INST0_SEG1                       0x00DC0000
+#define MP0_BASE__INST0_SEG2                       0x00E00000
+#define MP0_BASE__INST0_SEG3                       0x00E40000
+#define MP0_BASE__INST0_SEG4                       0x0243FC00
+
+#define MP0_BASE__INST1_SEG0                       0
+#define MP0_BASE__INST1_SEG1                       0
+#define MP0_BASE__INST1_SEG2                       0
+#define MP0_BASE__INST1_SEG3                       0
+#define MP0_BASE__INST1_SEG4                       0
+
+#define MP0_BASE__INST2_SEG0                       0
+#define MP0_BASE__INST2_SEG1                       0
+#define MP0_BASE__INST2_SEG2                       0
+#define MP0_BASE__INST2_SEG3                       0
+#define MP0_BASE__INST2_SEG4                       0
+
+#define MP0_BASE__INST3_SEG0                       0
+#define MP0_BASE__INST3_SEG1                       0
+#define MP0_BASE__INST3_SEG2                       0
+#define MP0_BASE__INST3_SEG3                       0
+#define MP0_BASE__INST3_SEG4                       0
+
+#define MP0_BASE__INST4_SEG0                       0
+#define MP0_BASE__INST4_SEG1                       0
+#define MP0_BASE__INST4_SEG2                       0
+#define MP0_BASE__INST4_SEG3                       0
+#define MP0_BASE__INST4_SEG4                       0
+
+#define MP0_BASE__INST5_SEG0                       0
+#define MP0_BASE__INST5_SEG1                       0
+#define MP0_BASE__INST5_SEG2                       0
+#define MP0_BASE__INST5_SEG3                       0
+#define MP0_BASE__INST5_SEG4                       0
+
+#define MP0_BASE__INST6_SEG0                       0
+#define MP0_BASE__INST6_SEG1                       0
+#define MP0_BASE__INST6_SEG2                       0
+#define MP0_BASE__INST6_SEG3                       0
+#define MP0_BASE__INST6_SEG4                       0
+
+#define MP1_BASE__INST0_SEG0                       0x00016000
+#define MP1_BASE__INST0_SEG1                       0x00DC0000
+#define MP1_BASE__INST0_SEG2                       0x00E00000
+#define MP1_BASE__INST0_SEG3                       0x00E40000
+#define MP1_BASE__INST0_SEG4                       0x0243FC00
+
+#define MP1_BASE__INST1_SEG0                       0
+#define MP1_BASE__INST1_SEG1                       0
+#define MP1_BASE__INST1_SEG2                       0
+#define MP1_BASE__INST1_SEG3                       0
+#define MP1_BASE__INST1_SEG4                       0
+
+#define MP1_BASE__INST2_SEG0                       0
+#define MP1_BASE__INST2_SEG1                       0
+#define MP1_BASE__INST2_SEG2                       0
+#define MP1_BASE__INST2_SEG3                       0
+#define MP1_BASE__INST2_SEG4                       0
+
+#define MP1_BASE__INST3_SEG0                       0
+#define MP1_BASE__INST3_SEG1                       0
+#define MP1_BASE__INST3_SEG2                       0
+#define MP1_BASE__INST3_SEG3                       0
+#define MP1_BASE__INST3_SEG4                       0
+
+#define MP1_BASE__INST4_SEG0                       0
+#define MP1_BASE__INST4_SEG1                       0
+#define MP1_BASE__INST4_SEG2                       0
+#define MP1_BASE__INST4_SEG3                       0
+#define MP1_BASE__INST4_SEG4                       0
+
+#define MP1_BASE__INST5_SEG0                       0
+#define MP1_BASE__INST5_SEG1                       0
+#define MP1_BASE__INST5_SEG2                       0
+#define MP1_BASE__INST5_SEG3                       0
+#define MP1_BASE__INST5_SEG4                       0
+
+#define MP1_BASE__INST6_SEG0                       0
+#define MP1_BASE__INST6_SEG1                       0
+#define MP1_BASE__INST6_SEG2                       0
+#define MP1_BASE__INST6_SEG3                       0
+#define MP1_BASE__INST6_SEG4                       0
+
+#define NBIO_BASE__INST0_SEG0                      0x00000000
+#define NBIO_BASE__INST0_SEG1                      0x00000014
+#define NBIO_BASE__INST0_SEG2                      0x00000D20
+#define NBIO_BASE__INST0_SEG3                      0x00010400
+#define NBIO_BASE__INST0_SEG4                      0x0241B000
+
+#define NBIO_BASE__INST1_SEG0                      0
+#define NBIO_BASE__INST1_SEG1                      0
+#define NBIO_BASE__INST1_SEG2                      0
+#define NBIO_BASE__INST1_SEG3                      0
+#define NBIO_BASE__INST1_SEG4                      0
+
+#define NBIO_BASE__INST2_SEG0                      0
+#define NBIO_BASE__INST2_SEG1                      0
+#define NBIO_BASE__INST2_SEG2                      0
+#define NBIO_BASE__INST2_SEG3                      0
+#define NBIO_BASE__INST2_SEG4                      0
+
+#define NBIO_BASE__INST3_SEG0                      0
+#define NBIO_BASE__INST3_SEG1                      0
+#define NBIO_BASE__INST3_SEG2                      0
+#define NBIO_BASE__INST3_SEG3                      0
+#define NBIO_BASE__INST3_SEG4                      0
+
+#define NBIO_BASE__INST4_SEG0                      0
+#define NBIO_BASE__INST4_SEG1                      0
+#define NBIO_BASE__INST4_SEG2                      0
+#define NBIO_BASE__INST4_SEG3                      0
+#define NBIO_BASE__INST4_SEG4                      0
+
+#define NBIO_BASE__INST5_SEG0                      0
+#define NBIO_BASE__INST5_SEG1                      0
+#define NBIO_BASE__INST5_SEG2                      0
+#define NBIO_BASE__INST5_SEG3                      0
+#define NBIO_BASE__INST5_SEG4                      0
+
+#define NBIO_BASE__INST6_SEG0                      0
+#define NBIO_BASE__INST6_SEG1                      0
+#define NBIO_BASE__INST6_SEG2                      0
+#define NBIO_BASE__INST6_SEG3                      0
+#define NBIO_BASE__INST6_SEG4                      0
+
+#define OSSSYS_BASE__INST0_SEG0                    0x000010A0
+#define OSSSYS_BASE__INST0_SEG1                    0x0240A000
+#define OSSSYS_BASE__INST0_SEG2                    0
+#define OSSSYS_BASE__INST0_SEG3                    0
+#define OSSSYS_BASE__INST0_SEG4                    0
+
+#define OSSSYS_BASE__INST1_SEG0                    0
+#define OSSSYS_BASE__INST1_SEG1                    0
+#define OSSSYS_BASE__INST1_SEG2                    0
+#define OSSSYS_BASE__INST1_SEG3                    0
+#define OSSSYS_BASE__INST1_SEG4                    0
+
+#define OSSSYS_BASE__INST2_SEG0                    0
+#define OSSSYS_BASE__INST2_SEG1                    0
+#define OSSSYS_BASE__INST2_SEG2                    0
+#define OSSSYS_BASE__INST2_SEG3                    0
+#define OSSSYS_BASE__INST2_SEG4                    0
+
+#define OSSSYS_BASE__INST3_SEG0                    0
+#define OSSSYS_BASE__INST3_SEG1                    0
+#define OSSSYS_BASE__INST3_SEG2                    0
+#define OSSSYS_BASE__INST3_SEG3                    0
+#define OSSSYS_BASE__INST3_SEG4                    0
+
+#define OSSSYS_BASE__INST4_SEG0                    0
+#define OSSSYS_BASE__INST4_SEG1                    0
+#define OSSSYS_BASE__INST4_SEG2                    0
+#define OSSSYS_BASE__INST4_SEG3                    0
+#define OSSSYS_BASE__INST4_SEG4                    0
+
+#define OSSSYS_BASE__INST5_SEG0                    0
+#define OSSSYS_BASE__INST5_SEG1                    0
+#define OSSSYS_BASE__INST5_SEG2                    0
+#define OSSSYS_BASE__INST5_SEG3                    0
+#define OSSSYS_BASE__INST5_SEG4                    0
+
+#define OSSSYS_BASE__INST6_SEG0                    0
+#define OSSSYS_BASE__INST6_SEG1                    0
+#define OSSSYS_BASE__INST6_SEG2                    0
+#define OSSSYS_BASE__INST6_SEG3                    0
+#define OSSSYS_BASE__INST6_SEG4                    0
+
+#define PCIE0_BASE__INST0_SEG0                     0x00000000
+#define PCIE0_BASE__INST0_SEG1                     0x00000014
+#define PCIE0_BASE__INST0_SEG2                     0x00000D20
+#define PCIE0_BASE__INST0_SEG3                     0x00010400
+#define PCIE0_BASE__INST0_SEG4                     0x0241B000
+
+#define PCIE0_BASE__INST1_SEG0                     0
+#define PCIE0_BASE__INST1_SEG1                     0
+#define PCIE0_BASE__INST1_SEG2                     0
+#define PCIE0_BASE__INST1_SEG3                     0
+#define PCIE0_BASE__INST1_SEG4                     0
+
+#define PCIE0_BASE__INST2_SEG0                     0
+#define PCIE0_BASE__INST2_SEG1                     0
+#define PCIE0_BASE__INST2_SEG2                     0
+#define PCIE0_BASE__INST2_SEG3                     0
+#define PCIE0_BASE__INST2_SEG4                     0
+
+#define PCIE0_BASE__INST3_SEG0                     0
+#define PCIE0_BASE__INST3_SEG1                     0
+#define PCIE0_BASE__INST3_SEG2                     0
+#define PCIE0_BASE__INST3_SEG3                     0
+#define PCIE0_BASE__INST3_SEG4                     0
+
+#define PCIE0_BASE__INST4_SEG0                     0
+#define PCIE0_BASE__INST4_SEG1                     0
+#define PCIE0_BASE__INST4_SEG2                     0
+#define PCIE0_BASE__INST4_SEG3                     0
+#define PCIE0_BASE__INST4_SEG4                     0
+
+#define PCIE0_BASE__INST5_SEG0                     0
+#define PCIE0_BASE__INST5_SEG1                     0
+#define PCIE0_BASE__INST5_SEG2                     0
+#define PCIE0_BASE__INST5_SEG3                     0
+#define PCIE0_BASE__INST5_SEG4                     0
+
+#define PCIE0_BASE__INST6_SEG0                     0
+#define PCIE0_BASE__INST6_SEG1                     0
+#define PCIE0_BASE__INST6_SEG2                     0
+#define PCIE0_BASE__INST6_SEG3                     0
+#define PCIE0_BASE__INST6_SEG4                     0
+
+#define SDMA0_BASE__INST0_SEG0                     0x00001260
+#define SDMA0_BASE__INST0_SEG1                     0x0000A000
+#define SDMA0_BASE__INST0_SEG2                     0x0001C000
+#define SDMA0_BASE__INST0_SEG3                     0x02402C00
+#define SDMA0_BASE__INST0_SEG4                     0
+
+#define SDMA0_BASE__INST1_SEG0                     0
+#define SDMA0_BASE__INST1_SEG1                     0
+#define SDMA0_BASE__INST1_SEG2                     0
+#define SDMA0_BASE__INST1_SEG3                     0
+#define SDMA0_BASE__INST1_SEG4                     0
+
+#define SDMA0_BASE__INST2_SEG0                     0
+#define SDMA0_BASE__INST2_SEG1                     0
+#define SDMA0_BASE__INST2_SEG2                     0
+#define SDMA0_BASE__INST2_SEG3                     0
+#define SDMA0_BASE__INST2_SEG4                     0
+
+#define SDMA0_BASE__INST3_SEG0                     0
+#define SDMA0_BASE__INST3_SEG1                     0
+#define SDMA0_BASE__INST3_SEG2                     0
+#define SDMA0_BASE__INST3_SEG3                     0
+#define SDMA0_BASE__INST3_SEG4                     0
+
+#define SDMA0_BASE__INST4_SEG0                     0
+#define SDMA0_BASE__INST4_SEG1                     0
+#define SDMA0_BASE__INST4_SEG2                     0
+#define SDMA0_BASE__INST4_SEG3                     0
+#define SDMA0_BASE__INST4_SEG4                     0
+
+#define SDMA0_BASE__INST5_SEG0                     0
+#define SDMA0_BASE__INST5_SEG1                     0
+#define SDMA0_BASE__INST5_SEG2                     0
+#define SDMA0_BASE__INST5_SEG3                     0
+#define SDMA0_BASE__INST5_SEG4                     0
+
+#define SDMA0_BASE__INST6_SEG0                     0
+#define SDMA0_BASE__INST6_SEG1                     0
+#define SDMA0_BASE__INST6_SEG2                     0
+#define SDMA0_BASE__INST6_SEG3                     0
+#define SDMA0_BASE__INST6_SEG4                     0
+
+#define SDMA1_BASE__INST0_SEG0                     0x00001260
+#define SDMA1_BASE__INST0_SEG1                     0x0000A000
+#define SDMA1_BASE__INST0_SEG2                     0x0001C000
+#define SDMA1_BASE__INST0_SEG3                     0x02402C00
+#define SDMA1_BASE__INST0_SEG4                     0
+
+#define SDMA1_BASE__INST1_SEG0                     0
+#define SDMA1_BASE__INST1_SEG1                     0
+#define SDMA1_BASE__INST1_SEG2                     0
+#define SDMA1_BASE__INST1_SEG3                     0
+#define SDMA1_BASE__INST1_SEG4                     0
+
+#define SDMA1_BASE__INST2_SEG0                     0
+#define SDMA1_BASE__INST2_SEG1                     0
+#define SDMA1_BASE__INST2_SEG2                     0
+#define SDMA1_BASE__INST2_SEG3                     0
+#define SDMA1_BASE__INST2_SEG4                     0
+
+#define SDMA1_BASE__INST3_SEG0                     0
+#define SDMA1_BASE__INST3_SEG1                     0
+#define SDMA1_BASE__INST3_SEG2                     0
+#define SDMA1_BASE__INST3_SEG3                     0
+#define SDMA1_BASE__INST3_SEG4                     0
+
+#define SDMA1_BASE__INST4_SEG0                     0
+#define SDMA1_BASE__INST4_SEG1                     0
+#define SDMA1_BASE__INST4_SEG2                     0
+#define SDMA1_BASE__INST4_SEG3                     0
+#define SDMA1_BASE__INST4_SEG4                     0
+
+#define SDMA1_BASE__INST5_SEG0                     0
+#define SDMA1_BASE__INST5_SEG1                     0
+#define SDMA1_BASE__INST5_SEG2                     0
+#define SDMA1_BASE__INST5_SEG3                     0
+#define SDMA1_BASE__INST5_SEG4                     0
+
+#define SDMA1_BASE__INST6_SEG0                     0
+#define SDMA1_BASE__INST6_SEG1                     0
+#define SDMA1_BASE__INST6_SEG2                     0
+#define SDMA1_BASE__INST6_SEG3                     0
+#define SDMA1_BASE__INST6_SEG4                     0
+
+#define SMUIO_BASE__INST0_SEG0                     0x00016800
+#define SMUIO_BASE__INST0_SEG1                     0x00016A00
+#define SMUIO_BASE__INST0_SEG2                     0x00440000
+#define SMUIO_BASE__INST0_SEG3                     0x02401000
+#define SMUIO_BASE__INST0_SEG4                     0
+
+#define SMUIO_BASE__INST1_SEG0                     0
+#define SMUIO_BASE__INST1_SEG1                     0
+#define SMUIO_BASE__INST1_SEG2                     0
+#define SMUIO_BASE__INST1_SEG3                     0
+#define SMUIO_BASE__INST1_SEG4                     0
+
+#define SMUIO_BASE__INST2_SEG0                     0
+#define SMUIO_BASE__INST2_SEG1                     0
+#define SMUIO_BASE__INST2_SEG2                     0
+#define SMUIO_BASE__INST2_SEG3                     0
+#define SMUIO_BASE__INST2_SEG4                     0
+
+#define SMUIO_BASE__INST3_SEG0                     0
+#define SMUIO_BASE__INST3_SEG1                     0
+#define SMUIO_BASE__INST3_SEG2                     0
+#define SMUIO_BASE__INST3_SEG3                     0
+#define SMUIO_BASE__INST3_SEG4                     0
+
+#define SMUIO_BASE__INST4_SEG0                     0
+#define SMUIO_BASE__INST4_SEG1                     0
+#define SMUIO_BASE__INST4_SEG2                     0
+#define SMUIO_BASE__INST4_SEG3                     0
+#define SMUIO_BASE__INST4_SEG4                     0
+
+#define SMUIO_BASE__INST5_SEG0                     0
+#define SMUIO_BASE__INST5_SEG1                     0
+#define SMUIO_BASE__INST5_SEG2                     0
+#define SMUIO_BASE__INST5_SEG3                     0
+#define SMUIO_BASE__INST5_SEG4                     0
+
+#define SMUIO_BASE__INST6_SEG0                     0
+#define SMUIO_BASE__INST6_SEG1                     0
+#define SMUIO_BASE__INST6_SEG2                     0
+#define SMUIO_BASE__INST6_SEG3                     0
+#define SMUIO_BASE__INST6_SEG4                     0
+
+#define THM_BASE__INST0_SEG0                       0x00016600
+#define THM_BASE__INST0_SEG1                       0x02400C00
+#define THM_BASE__INST0_SEG2                       0
+#define THM_BASE__INST0_SEG3                       0
+#define THM_BASE__INST0_SEG4                       0
+
+#define THM_BASE__INST1_SEG0                       0
+#define THM_BASE__INST1_SEG1                       0
+#define THM_BASE__INST1_SEG2                       0
+#define THM_BASE__INST1_SEG3                       0
+#define THM_BASE__INST1_SEG4                       0
+
+#define THM_BASE__INST2_SEG0                       0
+#define THM_BASE__INST2_SEG1                       0
+#define THM_BASE__INST2_SEG2                       0
+#define THM_BASE__INST2_SEG3                       0
+#define THM_BASE__INST2_SEG4                       0
+
+#define THM_BASE__INST3_SEG0                       0
+#define THM_BASE__INST3_SEG1                       0
+#define THM_BASE__INST3_SEG2                       0
+#define THM_BASE__INST3_SEG3                       0
+#define THM_BASE__INST3_SEG4                       0
+
+#define THM_BASE__INST4_SEG0                       0
+#define THM_BASE__INST4_SEG1                       0
+#define THM_BASE__INST4_SEG2                       0
+#define THM_BASE__INST4_SEG3                       0
+#define THM_BASE__INST4_SEG4                       0
+
+#define THM_BASE__INST5_SEG0                       0
+#define THM_BASE__INST5_SEG1                       0
+#define THM_BASE__INST5_SEG2                       0
+#define THM_BASE__INST5_SEG3                       0
+#define THM_BASE__INST5_SEG4                       0
+
+#define THM_BASE__INST6_SEG0                       0
+#define THM_BASE__INST6_SEG1                       0
+#define THM_BASE__INST6_SEG2                       0
+#define THM_BASE__INST6_SEG3                       0
+#define THM_BASE__INST6_SEG4                       0
+
+#define UMC_BASE__INST0_SEG0                       0x00014000
+#define UMC_BASE__INST0_SEG1                       0x02425800
+#define UMC_BASE__INST0_SEG2                       0
+#define UMC_BASE__INST0_SEG3                       0
+#define UMC_BASE__INST0_SEG4                       0
+
+#define UMC_BASE__INST1_SEG0                       0x00054000
+#define UMC_BASE__INST1_SEG1                       0x02425C00
+#define UMC_BASE__INST1_SEG2                       0
+#define UMC_BASE__INST1_SEG3                       0
+#define UMC_BASE__INST1_SEG4                       0
+
+#define UMC_BASE__INST2_SEG0                       0x00094000
+#define UMC_BASE__INST2_SEG1                       0x02426000
+#define UMC_BASE__INST2_SEG2                       0
+#define UMC_BASE__INST2_SEG3                       0
+#define UMC_BASE__INST2_SEG4                       0
+
+#define UMC_BASE__INST3_SEG0                       0x000D4000
+#define UMC_BASE__INST3_SEG1                       0x02426400
+#define UMC_BASE__INST3_SEG2                       0
+#define UMC_BASE__INST3_SEG3                       0
+#define UMC_BASE__INST3_SEG4                       0
+
+#define UMC_BASE__INST4_SEG0                       0x00114000
+#define UMC_BASE__INST4_SEG1                       0x02426800
+#define UMC_BASE__INST4_SEG2                       0
+#define UMC_BASE__INST4_SEG3                       0
+#define UMC_BASE__INST4_SEG4                       0
+
+#define UMC_BASE__INST5_SEG0                       0x00154000
+#define UMC_BASE__INST5_SEG1                       0x02426C00
+#define UMC_BASE__INST5_SEG2                       0
+#define UMC_BASE__INST5_SEG3                       0
+#define UMC_BASE__INST5_SEG4                       0
+
+#define UMC_BASE__INST6_SEG0                       0x00194000
+#define UMC_BASE__INST6_SEG1                       0x02427000
+#define UMC_BASE__INST6_SEG2                       0
+#define UMC_BASE__INST6_SEG3                       0
+#define UMC_BASE__INST6_SEG4                       0
+
+#define USB0_BASE__INST0_SEG0                      0x0242A800
+#define USB0_BASE__INST0_SEG1                      0x05B00000
+#define USB0_BASE__INST0_SEG2                      0
+#define USB0_BASE__INST0_SEG3                      0
+#define USB0_BASE__INST0_SEG4                      0
+
+#define USB0_BASE__INST1_SEG0                      0
+#define USB0_BASE__INST1_SEG1                      0
+#define USB0_BASE__INST1_SEG2                      0
+#define USB0_BASE__INST1_SEG3                      0
+#define USB0_BASE__INST1_SEG4                      0
+
+#define USB0_BASE__INST2_SEG0                      0
+#define USB0_BASE__INST2_SEG1                      0
+#define USB0_BASE__INST2_SEG2                      0
+#define USB0_BASE__INST2_SEG3                      0
+#define USB0_BASE__INST2_SEG4                      0
+
+#define USB0_BASE__INST3_SEG0                      0
+#define USB0_BASE__INST3_SEG1                      0
+#define USB0_BASE__INST3_SEG2                      0
+#define USB0_BASE__INST3_SEG3                      0
+#define USB0_BASE__INST3_SEG4                      0
+
+#define USB0_BASE__INST4_SEG0                      0
+#define USB0_BASE__INST4_SEG1                      0
+#define USB0_BASE__INST4_SEG2                      0
+#define USB0_BASE__INST4_SEG3                      0
+#define USB0_BASE__INST4_SEG4                      0
+
+#define USB0_BASE__INST5_SEG0                      0
+#define USB0_BASE__INST5_SEG1                      0
+#define USB0_BASE__INST5_SEG2                      0
+#define USB0_BASE__INST5_SEG3                      0
+#define USB0_BASE__INST5_SEG4                      0
+
+#define USB0_BASE__INST6_SEG0                      0
+#define USB0_BASE__INST6_SEG1                      0
+#define USB0_BASE__INST6_SEG2                      0
+#define USB0_BASE__INST6_SEG3                      0
+#define USB0_BASE__INST6_SEG4                      0
+
+#define VCN_BASE__INST0_SEG0                       0x00007800
+#define VCN_BASE__INST0_SEG1                       0x00007E00
+#define VCN_BASE__INST0_SEG2                       0x02403000
+#define VCN_BASE__INST0_SEG3                       0
+#define VCN_BASE__INST0_SEG4                       0
+
+#define VCN_BASE__INST1_SEG0                       0x00007B00
+#define VCN_BASE__INST1_SEG1                       0x00012000
+#define VCN_BASE__INST1_SEG2                       0x02445000
+#define VCN_BASE__INST1_SEG3                       0
+#define VCN_BASE__INST1_SEG4                       0
+
+#define VCN_BASE__INST2_SEG0                       0
+#define VCN_BASE__INST2_SEG1                       0
+#define VCN_BASE__INST2_SEG2                       0
+#define VCN_BASE__INST2_SEG3                       0
+#define VCN_BASE__INST2_SEG4                       0
+
+#define VCN_BASE__INST3_SEG0                       0
+#define VCN_BASE__INST3_SEG1                       0
+#define VCN_BASE__INST3_SEG2                       0
+#define VCN_BASE__INST3_SEG3                       0
+#define VCN_BASE__INST3_SEG4                       0
+
+#define VCN_BASE__INST4_SEG0                       0
+#define VCN_BASE__INST4_SEG1                       0
+#define VCN_BASE__INST4_SEG2                       0
+#define VCN_BASE__INST4_SEG3                       0
+#define VCN_BASE__INST4_SEG4                       0
+
+#define VCN_BASE__INST5_SEG0                       0
+#define VCN_BASE__INST5_SEG1                       0
+#define VCN_BASE__INST5_SEG2                       0
+#define VCN_BASE__INST5_SEG3                       0
+#define VCN_BASE__INST5_SEG4                       0
+
+#define VCN_BASE__INST6_SEG0                       0
+#define VCN_BASE__INST6_SEG1                       0
+#define VCN_BASE__INST6_SEG2                       0
+#define VCN_BASE__INST6_SEG3                       0
+#define VCN_BASE__INST6_SEG4                       0
+
+#endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
