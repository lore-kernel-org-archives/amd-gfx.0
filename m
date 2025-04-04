Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FC8C36010
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 05:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A85F10E2F0;
	Fri,  4 Apr 2025 05:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kJZ+FQbs";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C32BD10E2EF
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 05:42:39 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7c5e39d1e0eso159984985a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Apr 2025 22:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743745358; x=1744350158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mcddbv3UtNlwB95lqIyYt+SeFiyoyaeS6b8krEcrIxk=;
 b=kJZ+FQbsHS8vE/tcCqiMi+4pAS32f/GLCR4LJ0u/BVBvyCDc3h45lnhI/EjKpoT91V
 qT+OK7q1cFdA0jiguFC8UwwQJ0ZbIHyysMAlc/5ZtkL9MLcVhZ3ALesnOxE8/uIeqiN0
 +UlzXShmotsbhYnUrVb+KkTPM9k3dcVYwi0ti/orKcxA6Us1tpk49L9NwuZ/ME9Wm3Wq
 tm1rC/sTyV/U7piuALROMmKRI4j3Y9yznelidPdWygSWaLWBQfLqhN2mrYb+sQr6vslT
 e7VJWw4hUDwpF/kI4nXpRa0NTOuJXk3PZD7lOXikzVIt4tbZuS06cCmPRp++MjATcjC8
 dNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743745358; x=1744350158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcddbv3UtNlwB95lqIyYt+SeFiyoyaeS6b8krEcrIxk=;
 b=wB9A5M6CRjjKXfCfuwGI9u064FKxeCC27P8IVhC8E/F5lMwDQ40DKdqyK+Ho3F2LPX
 kHCWhjLgkfFkBvHaAO0f4kW93GxxC+YhgQ2FMyXZG/YLYM1Hn4gDL17cnbiAJWCRRP0T
 dqUfXOKH1zCWc0QKDxpEua91d0Lr3fhqA+6pTVe5+2L3mb7IGkJV8e56KMGyIPIWHcf2
 3XZgG9GZrTGbOdscL/bG2N5Dtd7rPKnDBR3/f9bcpvqrCOxbiHSbHL/C5kAXsh5T9FKk
 HZ6ryCI3qoX7Gw1+t8TYkZjI9WGWxwixRsU4mvrM+QyhaOse4rm9MiL2XfSNIMySniVo
 nSKQ==
X-Gm-Message-State: AOJu0YytkwXfeXlwm3Wz9XJWdkmbZWwuvhIHchWmhP+Oi0+zlJzYwIdj
 uuIY9eBG9MLfDCL4dNerb1f4ZMfex4wTu6+1/Irz7nj3NhWwBUxtLDf31w==
X-Gm-Gg: ASbGnctlevzPYtnSvE2Iy3hQCmkH9X/Kn1UQq6Nnx3iUN5pPE0vW9YFNv9g2DqFebnq
 Rpz3EAUYz7YyxD0WkY9YKQvaywgmCrHPgQl31sjdhaHEBNhs74E7D/OLm1+qw/sMZYQdvNkGoce
 DWTuoLq6S3g/P3i3oBeS9WVGWqAUF3WS3/PJe6dK7deN0jIEPIaGTAYW6QWkYYboOJ6f5xxUydO
 0HyJMalGdGz5cOD3ja1YTCaogzjFcM8Vh53Um+Fv62SQnvJmMsIUhNTFqmyiz2ssYJ0+i+5iNts
 tT6VUFDeVIgpJsDLbtLf5BTbpdpCEE2XFLH6MNkH/7QHe1WENh/mV+FPTPj0G/zJL5jO
X-Google-Smtp-Source: AGHT+IHjqp8r/rHYbPNemnX1gs1f7g6jc9RnzSRrnXHI2RfOV32463Sbbz5IO3ss/nKYD0xyOuIF2Q==
X-Received: by 2002:a05:620a:190f:b0:7c5:49e3:3347 with SMTP id
 af79cd13be357-7c774dd7061mr238537585a.35.1743745358501; 
 Thu, 03 Apr 2025 22:42:38 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76e96e566sm171746385a.63.2025.04.03.22.42.37
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 22:42:37 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/display/dc: reclassify DCE6 resources and hw
 sequencer
Date: Fri,  4 Apr 2025 01:42:24 -0400
Message-ID: <20250404054225.101791-2-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404054225.101791-1-alexandre.f.demers@gmail.com>
References: <20250404054225.101791-1-alexandre.f.demers@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Classify DCE6 resource and sequencer as they are for other DCE versions

Put dce60_resource.c and .h under amd/display/dc/resource/dce60
Put and rename dce60_hw_sequencer.c and .h under amd/display/dc/hwss/dce60

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/Makefile |  3 +--
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  | 24 ++++++++++++-------
 .../dce60/dce60_hwseq.c}                      |  2 +-
 .../dce60/dce60_hwseq.h}                      |  0
 .../gpu/drm/amd/display/dc/resource/Makefile  | 24 ++++++++++++-------
 .../dc/{ => resource}/dce60/dce60_resource.c  |  2 +-
 .../dc/{ => resource}/dce60/dce60_resource.h  |  0
 7 files changed, 35 insertions(+), 20 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{dce60/dce60_hw_sequencer.c => hwss/dce60/dce60_hwseq.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/{dce60/dce60_hw_sequencer.h => hwss/dce60/dce60_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce60/dce60_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce60/dce60_resource.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/Makefile b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
index eede83ad91fa..824f73eb3326 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
@@ -25,8 +25,7 @@
 
 CFLAGS_$(AMDDALPATH)/dc/dce60/dce60_resource.o = -Wno-override-init
 
-DCE60 = dce60_timing_generator.o dce60_hw_sequencer.o \
-	dce60_resource.o
+DCE60 = dce60_timing_generator.o
 
 AMD_DAL_DCE60 = $(addprefix $(AMDDALPATH)/dc/dce60/,$(DCE60))
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/Makefile b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
index 40ecebea1ba0..49079cc2a255 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
@@ -27,6 +27,22 @@
 #  DCE
 ###############################################################################
 
+HWSS_DCE60 = dce60_hwseq.o
+
+AMD_DAL_HWSS_DCE60 = $(addprefix $(AMDDALPATH)/dc/hwss/dce60/,$(HWSS_DCE60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE60)
+
+###############################################################################
+
+HWSS_DCE80 = dce80_hwseq.o
+
+AMD_DAL_HWSS_DCE80 = $(addprefix $(AMDDALPATH)/dc/hwss/dce80/,$(HWSS_DCE80))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE80)
+
+###############################################################################
+
 HWSS_DCE = dce_hwseq.o
 
 AMD_DAL_HWSS_DCE = $(addprefix $(AMDDALPATH)/dc/hwss/dce/,$(HWSS_DCE))
@@ -65,14 +81,6 @@ AMD_DAL_HWSS_DCE120 = $(addprefix $(AMDDALPATH)/dc/hwss/dce120/,$(HWSS_DCE120))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE120)
 
-###############################################################################
-
-HWSS_DCE80 = dce80_hwseq.o
-
-AMD_DAL_HWSS_DCE80 = $(addprefix $(AMDDALPATH)/dc/hwss/dce80/,$(HWSS_DCE80))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE80)
-
 ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
 # DCN
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
index 1fdeef47e4dc..d503bd054558 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
@@ -26,7 +26,7 @@
 #include "dm_services.h"
 #include "dc.h"
 #include "core_types.h"
-#include "dce60_hw_sequencer.h"
+#include "dce60_hwseq.h"
 
 #include "dce/dce_hwseq.h"
 #include "dce110/dce110_hwseq.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/resource/Makefile b/drivers/gpu/drm/amd/display/dc/resource/Makefile
index 09320344d8e9..7f38957e81ad 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/resource/Makefile
@@ -27,6 +27,22 @@
 #  DCE
 ###############################################################################
 
+RESOURCE_DCE60 = dce60_resource.o
+
+AMD_DAL_RESOURCE_DCE60 = $(addprefix $(AMDDALPATH)/dc/resource/dce60/,$(RESOURCE_DCE60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCE60)
+
+###############################################################################
+
+RESOURCE_DCE80 = dce80_resource.o
+
+AMD_DAL_RESOURCE_DCE80 = $(addprefix $(AMDDALPATH)/dc/resource/dce80/,$(RESOURCE_DCE80))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCE80)
+
+###############################################################################
+
 RESOURCE_DCE100 = dce100_resource.o
 
 AMD_DAL_RESOURCE_DCE100 = $(addprefix $(AMDDALPATH)/dc/resource/dce100/,$(RESOURCE_DCE100))
@@ -57,14 +73,6 @@ AMD_DAL_RESOURCE_DCE120 = $(addprefix $(AMDDALPATH)/dc/resource/dce120/,$(RESOUR
 
 AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCE120)
 
-###############################################################################
-
-RESOURCE_DCE80 = dce80_resource.o
-
-AMD_DAL_RESOURCE_DCE80 = $(addprefix $(AMDDALPATH)/dc/resource/dce80/,$(RESOURCE_DCE80))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCE80)
-
 ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
 # DCN
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 889f314cac65..737c1b1d861a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -48,7 +48,7 @@
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
-#include "dce60/dce60_hw_sequencer.h"
+#include "dce60/dce60_hwseq.h"
 #include "dce100/dce100_resource.h"
 #include "dce/dce_panel_cntl.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.h
-- 
2.49.0

