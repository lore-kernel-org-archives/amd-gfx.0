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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21A0C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547572399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToNCXEVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547572399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E626ED78;
	Fri, 25 Sep 2020 20:11:39 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141246ED78
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:37 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id a4so3105614qth.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CuykHKMn5sUvAkFYXIE99o7vuPOSNCSlqfofiVB9EH8=;
 b=ToNCXEVe4gfE8gvGsMc7JuvPIdIpoL13zPxJBMADTzGedc/b0FFYXuvyfW+ng748gy
 M0oAmsARgBZQwluXciIMnpnUAV9x2HzjGndwcsQhYMKCFYV8spqO5uUwC0rYGc2za7Oy
 0CU7m0f00ghtEQqzAfbmJpDuxk1dobDbDhdPG7ETslRktl+7lTGUJh1iKGnaVlGVa8ln
 ypht+EsZP2SqBkQQzvg/7000CcO+FEPZQJqNU+39jN6Gq083i2oQqTxUkRUXHRtzlkoa
 EGFeezDYsLJ24QF1W926f3MQlG/6KeYNOzqhDtEHauqusBXy0rEXCVKa/dX99VmhkW4g
 QlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CuykHKMn5sUvAkFYXIE99o7vuPOSNCSlqfofiVB9EH8=;
 b=RlJ61FwtuKK44B5pUAno2sxxzR5QWMvx5u3lnclLKwR50Gr0OI+Ads3Po5s7+fejnJ
 1AQB1w59gDQ2bXzSCpfP/TdoYKpVbyf/ANijt2idauOvZDKuKFVuLOmY2UWt4G0E/PM+
 vKvC4pPZ2+d6TLeFciDMn7fERucN4ovPooi1DxF1CPgYK38pZFLTSEnUXPNdDf5noM/D
 G1mwrdJHU0zStuc/5W18CYMz3ST83WMkvwiGGe8WQ1/tKoMbYHg7CvsNaK0ElI13igis
 F2TNmdpWYzvaCtMAT2Uogmj/OEVpSOqBxGK6qzSkGRSUgsjzXtr+3E6f3kJIxzwCXgLN
 cVYQ==
X-Gm-Message-State: AOAM532CTHUHnuzW2RUdWc/4e0gzXngAZCjAhoPKddTiLYLi0NFH/1By
 KcaB5Z8AlqgC5AqRktby128g4L2SYmQ=
X-Google-Smtp-Source: ABdhPJyzx8e15t+kPL2Fj5FG74FfbgZSawwPmHgfk4/mGDtt9fiLdZA27Z5BNZVnSM1yW3Lu6AoPlQ==
X-Received: by 2002:aed:2c61:: with SMTP id f88mr1462167qtd.388.1601064695949; 
 Fri, 25 Sep 2020 13:11:35 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:35 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/45] drm/amdgpu/powerplay: add smu v11.5 smc header for
 vangogh
Date: Fri, 25 Sep 2020 16:10:13 -0400
Message-Id: <20200925201029.1738724-29-alexander.deucher@amd.com>
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

This patch is to add smu v11.5 smc header for vangogh.

Signed-off-by: Xiaojian Du <xiaojian.du@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h | 86 ++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
new file mode 100644
index 000000000000..55c1b151a68d
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
@@ -0,0 +1,86 @@
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
+#ifndef SMU_11_5_0_PPSMC_H
+#define SMU_11_5_0_PPSMC_H
+
+// SMU Response Codes:
+#define PPSMC_Result_OK 0x1
+#define PPSMC_Result_Failed 0xFF
+#define PPSMC_Result_UnknownCmd 0xFE
+#define PPSMC_Result_CmdRejectedPrereq 0xFD
+#define PPSMC_Result_CmdRejectedBusy 0xFC
+
+// Message Definitions:
+#define PPSMC_MSG_TestMessage 0x1
+#define PPSMC_MSG_GetSmuVersion 0x2
+#define PPSMC_MSG_GetDriverIfVersion 0x3
+#define PPSMC_MSG_EnableGfxOff 0x4
+#define PPSMC_MSG_DisableGfxOff 0x5
+#define PPSMC_MSG_PowerDownIspByTile 0x6 // ISP is power gated by default
+#define PPSMC_MSG_PowerUpIspByTile 0x7
+#define PPSMC_MSG_PowerDownVcn 0x8 // VCN is power gated by default
+#define PPSMC_MSG_PowerUpVcn 0x9
+#define PPSMC_MSG_spare 0xA
+#define PPSMC_MSG_SetHardMinVcn 0xB // For wireless display
+#define PPSMC_MSG_SetMinVideoGfxclkFreq	0xC //Sets SoftMin for GFXCLK. Arg is in MHz
+#define PPSMC_MSG_ActiveProcessNotify 0xD
+#define PPSMC_MSG_SetHardMinIspiclkByFreq 0xE
+#define PPSMC_MSG_SetHardMinIspxclkByFreq 0xF
+#define PPSMC_MSG_SetDriverDramAddrHigh 0x10
+#define PPSMC_MSG_SetDriverDramAddrLow 0x11
+#define PPSMC_MSG_TransferTableSmu2Dram 0x12
+#define PPSMC_MSG_TransferTableDram2Smu 0x13
+#define PPSMC_MSG_GfxDeviceDriverReset 0x14 //mode 2 reset during TDR
+#define PPSMC_MSG_GetEnabledSmuFeatures 0x15
+#define PPSMC_MSG_spare1 0x16
+#define PPSMC_MSG_SetHardMinSocclkByFreq 0x17
+#define PPSMC_MSG_SetMinVideoFclkFreq 0x18
+#define PPSMC_MSG_SetSoftMinVcn 0x19
+#define PPSMC_MSG_EnablePostCode 0x1A
+#define PPSMC_MSG_GetGfxclkFrequency 0x1B
+#define PPSMC_MSG_GetFclkFrequency 0x1C
+#define PPSMC_MSG_AllowGfxOff 0x1D
+#define PPSMC_MSG_DisallowGfxOff 0x1E
+#define PPSMC_MSG_SetSoftMaxGfxClk 0x1F
+#define PPSMC_MSG_SetHardMinGfxClk 0x20
+#define PPSMC_MSG_SetSoftMaxSocclkByFreq 0x21
+#define PPSMC_MSG_SetSoftMaxFclkByFreq 0x22
+#define PPSMC_MSG_SetSoftMaxVcn 0x23
+#define PPSMC_MSG_GpuChangeState 0x24 //FIXME AHOLLA - check how to do for VGM
+#define PPSMC_MSG_SetPowerLimitPercentage 0x25
+#define PPSMC_MSG_PowerDownJpeg 0x26
+#define PPSMC_MSG_PowerUpJpeg 0x27
+#define PPSMC_MSG_SetHardMinFclkByFreq 0x28
+#define PPSMC_MSG_SetSoftMinSocclkByFreq 0x29
+#define PPSMC_MSG_PowerUpCvip 0x2A
+#define PPSMC_MSG_PowerDownCvip 0x2B
+#define PPSMC_Message_Count 0x2C
+
+//Argument for  PPSMC_MSG_GpuChangeState
+enum {
+  GpuChangeState_D0Entry = 1,
+  GpuChangeState_D3Entry,
+};
+
+#endif
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
