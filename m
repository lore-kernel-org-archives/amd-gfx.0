Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FADC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71A62074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOmv2IIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71A62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85DC56E9F1;
	Mon,  1 Jun 2020 18:30:23 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8286E9F1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:22 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id l3so499279qvo.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KlBLqQJWM5AQe5sspaIK23vGWpDLACdBoglPwcnc3yU=;
 b=XOmv2IIMqgx/wbFmCHmRex4e1L9/Qc0z4A29OkN/UMtdP0wF9g/z+DqRow066QM5h9
 heW8vqHymhZxVJoFY8/pkvSb6IeE6oJ90vFfllvWt/PqxISSmxuQQBq6Hx0Q5C5uJ8CU
 Q9yb+l7XLykOHQRe1UaGua5uQrRnuWHnSMuhRD4pfrxFoEdqnTLLZJvyKLS19yhhevXh
 98ObOWGxO9rWMhLCNM7Zd49MYoM6NJvzr2LhdEP3/+0w+i0wKqCruK2QlLvb4SIb11n+
 iYCDcSGzX5Oj4j0UvBmqffDRHSKtAuc3qWXduDb/6w2glISaksoqWFowZMiLFDzREnN+
 N+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KlBLqQJWM5AQe5sspaIK23vGWpDLACdBoglPwcnc3yU=;
 b=T6s1+eqr/fiUufo6WTiFPGOLRMzAOaZ8VDdaFlxEAu0diheEbqdQwoUkk/AjzlqMUF
 6yLApVeqPl6HrmwwLTTf2KAerKx6F3RbCtu7+kfHMjb0fdOSqg12LRwOS0ywFpeGHcv8
 qTaa6leEq+/w7XMgR94PVtvU6Z48QWJOvbSR0Gqxctk05wYy8vFTuukSdHYAl01JEOAM
 GqzqEEPvIlR722ZM21z8AIcaK1LZtDvcKSb8e5VNeC+aY/hfeSmUFeFfm6WpODfKAc4D
 GJ0m1PNSkbUg0hEK3lTgNJVhgkXfteIpMaUNHrXL6MZXuNTNV30MrVGSPmquyPmn/cpj
 ZBpA==
X-Gm-Message-State: AOAM532QOclt64RRnjzMY9GFnnuGdOkHKC00+Y7QDRx6QtpojV5kMIHC
 XCOL0twWXPWTnzLVF745yoWZHSbK
X-Google-Smtp-Source: ABdhPJw5uc/7tdn4mzDi3DmN74oefGpZD2srx2Os9NlyQ405AXyIB4WF76KP44ocmjIMC8Zlskfxvw==
X-Received: by 2002:ad4:438c:: with SMTP id s12mr7011651qvr.200.1591036220897; 
 Mon, 01 Jun 2020 11:30:20 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:20 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 206/207] drm/amd/display: Add DCN3 blocks to Makefile
Date: Mon,  1 Jun 2020 14:29:25 -0400
Message-Id: <20200601182926.1267958-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182926.1267958-1-alexander.deucher@amd.com>
References: <20200601182926.1267958-1-alexander.deucher@amd.com>
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  4 ++
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 54 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn30/Makefile

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 6e3dddc73246..e0f4f1be1618 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -32,6 +32,10 @@ DC_LIBS += dcn10 dml
 DC_LIBS += dcn21
 endif
 
+ifdef CONFIG_DRM_AMD_DC_DCN3_0
+DC_LIBS += dcn30
+endif
+
 DC_LIBS += dce120
 
 DC_LIBS += dce112
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
new file mode 100644
index 000000000000..025637a83c3b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -0,0 +1,54 @@
+# 
+# Copyright 2020 Advanced Micro Devices, Inc.
+# 
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+# 
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+# 
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+# 
+# Authors: AMD
+# 
+# 
+
+
+DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
+	dcn30_dccg.o dcn30_hwseq.o dcn30_mpc.o dcn30_vpg.o \
+	dcn30_afmt.o dcn30_dio_stream_encoder.o dcn30_dwb.o \
+	dcn30_dpp_cm.o dcn30_dwb_cm.o dcn30_cm_common.o dcn30_mmhubbub.o \
+	dcn30_dio_link_encoder.o dcn30_resource.o
+
+
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse -mpreferred-stack-boundary=4
+
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
+ifdef CONFIG_CC_IS_GCC
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+IS_OLD_GCC = 1
+endif
+endif
+
+ifdef IS_OLD_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mpreferred-stack-boundary=4
+else
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -msse2
+endif
+
+AMD_DAL_DCN30 = $(addprefix $(AMDDALPATH)/dc/dcn30/,$(DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCN30)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
