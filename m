Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1F8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 23:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4202C10E1CF;
	Mon, 20 Dec 2021 23:21:05 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF2110E1CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 23:21:04 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4JHwZ819t1zDrMn;
 Mon, 20 Dec 2021 15:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1640042464; bh=hUVZI9RRRrNBWbBSiggSndufgqFi5hXLJv2iAUPvV7g=;
 h=From:To:Cc:Subject:Date:From;
 b=NFeo+mw6L4V+qvLkZy+6yiExRfiVYqBtIzN0mNgylClAC60qrHQnl5HwkwQhO5RzU
 N9qa02DLarl5w81pcj/IN/iswnaKXuh19UpUBdJmdS7y2YDzYWPW2ZbhVg/ENUYH6M
 nWii31wZoDelWIexduKdujGkrLSP5pnhPFvm7K+o=
X-Riseup-User-ID: 6F296A08885F3E1DDD8F2A7EB62073D7C28AE43E1187C893D8703BD309466C30
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4JHwZ438gDz1y4f;
 Mon, 20 Dec 2021 15:21:00 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, sunpeng.li@amd.com,
 Xinhui.Pan@amd.com, qingqing.zhuo@amd.com, jasdeep.dhillon@amd.com,
 mwen@igalia.com
Subject: [PATCH v2] drm/amd/display: move calcs folder into DML
Date: Mon, 20 Dec 2021 20:20:47 -0300
Message-Id: <20211220232047.1327228-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The calcs folder has FPU code on it, which should be isolated inside the
DML folder as per https://patchwork.freedesktop.org/series/93042/.

This commit aims single-handedly to correct the location of such FPU
code and does not refactor any functions.

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 68 -------------------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 13 +++-
 .../amd/display/dc/{ => dml}/calcs/bw_fixed.c |  0
 .../display/dc/{ => dml}/calcs/calcs_logger.h |  0
 .../display/dc/{ => dml}/calcs/custom_float.c |  0
 .../display/dc/{ => dml}/calcs/dce_calcs.c    |  0
 .../dc/{ => dml}/calcs/dcn_calc_auto.c        |  0
 .../dc/{ => dml}/calcs/dcn_calc_auto.h        |  0
 .../dc/{ => dml}/calcs/dcn_calc_math.c        |  0
 .../display/dc/{ => dml}/calcs/dcn_calcs.c    |  0
 11 files changed, 13 insertions(+), 70 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/calcs/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/bw_fixed.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/calcs_logger.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/custom_float.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dce_calcs.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calc_auto.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calc_auto.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calc_math.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calcs.c (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index b1f0d6260226..1872adc96a00 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -23,7 +23,7 @@
 # Makefile for Display Core (dc) component.
 #
 
-DC_LIBS = basics bios calcs clk_mgr dce gpio irq virtual
+DC_LIBS = basics bios clk_mgr dce gpio irq virtual
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 DC_LIBS += dcn20
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
deleted file mode 100644
index f3c00f479e1c..000000000000
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ /dev/null
@@ -1,68 +0,0 @@
-#
-# Copyright 2017 Advanced Micro Devices, Inc.
-# Copyright 2019 Raptor Engineering, LLC
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
-# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-# OTHER DEALINGS IN THE SOFTWARE.
-#
-#
-# Makefile for the 'calcs' sub-component of DAL.
-# It calculates Bandwidth and Watermarks values for HW programming
-#
-
-ifdef CONFIG_X86
-calcs_ccflags := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-calcs_ccflags := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-calcs_ccflags += -mpreferred-stack-boundary=4
-else
-calcs_ccflags += -msse2
-endif
-endif
-
-CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calcs.o := $(calcs_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o := $(calcs_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calcs.o := $(calcs_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o := $(calcs_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o := $(calcs_rcflags)
-
-BW_CALCS = dce_calcs.o bw_fixed.o custom_float.o
-
-ifdef CONFIG_DRM_AMD_DC_DCN
-BW_CALCS += dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o
-endif
-
-AMD_DAL_BW_CALCS = $(addprefix $(AMDDALPATH)/dc/calcs/,$(BW_CALCS))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_BW_CALCS)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index eee6672bd32d..82f26da6778e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -73,6 +73,11 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
+
+CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
+
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
@@ -94,7 +99,11 @@ CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_rcflags)
 
-DML = display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
+
+DML = display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 DML += dcn20/dcn20_fpu.o
@@ -105,6 +114,8 @@ DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
 DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
 DML += dcn301/dcn301_fpu.o
 DML += dsc/rc_calc_fpu.o
+DML += calcs/dce_calcs.o calcs/bw_fixed.o calcs/custom_float.o
+DML += calcs/dcn_calcs.o calcs/dcn_calc_math.o calcs/dcn_calc_auto.o
 endif
 
 AMD_DAL_DML = $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h b/drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/custom_float.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/custom_float.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
-- 
2.34.1

