Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D10CCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5164910EB60;
	Fri, 10 Oct 2025 08:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="PLFrbydU";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E1510EA85
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 15:06:29 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-3ecdb10a612so774405f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1760022388; x=1760627188;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9kNNIboTBu/rgfEeqjlIf4OLiFoNCoyw80MDr+LA5Y0=;
 b=PLFrbydUjiYpBRNpwwxVwgaZDbhSW5H1HoixH4cxJ0n9kvIZroTY15Hav67htc71u1
 TuM9b0zxZhZbKsdtbL6KLN8DfKkrUYqylVa6W9iiWfmBi21Gi1tZeLA03kdnUVn0rgk0
 2vrkk0JmwRE31VhMEdjgHFFoaSF5JUkFOiuDHAcFr8Rzme93kEZEr3Wf1SFe7OkjFPDZ
 TBk+sdQ9CpBTvR0zxphhWqipGvFjnP+XFTWjL0uN9LU5ow2ynuhK0CXWjNVYBg5sDDNA
 +p2VwxqTy1SEx5gFUxmMOjyH/9qvHSD6bjE8T3+W0myK7msLRI/vW3noJ3tPEn3IX8Tl
 s/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760022388; x=1760627188;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kNNIboTBu/rgfEeqjlIf4OLiFoNCoyw80MDr+LA5Y0=;
 b=v7Dwucl8bN1tEZRSpYbCHpbohY91Rhjes1p4xtrKzfjuBXjw6HAw7pAjL8Pj5Xecha
 8Mn3fmjgqO182Ow9AKTqQtLgd5liWJa/uYLuoDoTXxCbYfOh1l9ICxmXDpectcEBGTMr
 livbe2U+cbKgOf8oKrG7Igdenx6XGRcyO+En2sCaSv5gr2gSLLdl4cxxLsuNqn8o3fx0
 WKZvQGdU+xnQZAqxAKvb9yACZi6ZyWQzLl6T6k/E2l9inqOHfG9SOhkzKOFickN68XVF
 i8f28Ydpbs5GuWoVWinSnXv7M5U09MakubLEVq2HYgouWlhDp+RHR7SllucLXXITAY/q
 6O+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURnF2rdkaFBmjh1x24uLHMTddwDFQWlruoOMFuMzowcNWgV+mIsY9TRi36QZykO5V37z7ZHTTY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNY8mW+hTfpNHu14Qteuq1+CkqtFgkhZWj+O7rDTEzk7SL8guo
 ICB/xQ7jq1ByZz8O9DgiabhA0TcjBjgV6eNU8oiTj1smFawsESpRTp90ZpE1o8t13wcLP2Um/w=
 =
X-Google-Smtp-Source: AGHT+IF28pI3nDsq06k40pR3d1KWdnq7Bmqmwn+5p1/UbYexmHQrk0yWcmBoTkVBvwdXntL/+LqRUcL0
X-Received: from wmhf15.prod.google.com ([2002:a7b:cc0f:0:b0:46f:b153:bfb7])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41c6:b0:426:cd4b:4b36
 with SMTP id ffacd0b85a97d-426cd4b4b50mr143095f8f.58.1760022387953; Thu, 09
 Oct 2025 08:06:27 -0700 (PDT)
Date: Thu,  9 Oct 2025 17:06:21 +0200
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp;
 fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=ardb@kernel.org;
 h=from:subject; bh=BfB8Vi7bZ1cD+rxey05bluTEmM0Q6lYE5jThs99t4Pg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP5+TxG4RyBuTtFVdNaFojs743b5qHJd6D1WPaRB32LZ
 r1fLOPRUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACay8jUjw61dyq5Z+TtXinnZ
 7X1o/vriK/GTMUvCpv3Si3roP2+Rujkjw9YKwd/iohuiu2Y1beXKSlprMTmh7G2Qv6+mq8GfWMs
 z3AA=
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251009150621.3886079-2-ardb+git@google.com>
Subject: [PATCH] drm/amd: Permit DC_FP_START/END only in non-FP compilation
 units
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 10 Oct 2025 08:03:12 +0000
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

From: Ard Biesheuvel <ardb@kernel.org>

Test the existing CPP macro _LINUX_FPU_COMPILATION_UNIT, which is set
when building source files that are permitted to use floating point,
in the implementation of DC_FP_START/END so that those are only usable
in non-FP code. This is a requirement of the generic kernel mode FPU
API, as some architectures (i.e., arm64) cannot safely enable FP codegen
in arbitrary code.

Cc: Austin Zheng <austin.zheng@amd.com>
Cc: Jun Lei <jun.lei@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/os_types.h      | 2 --
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h b/drivers/gpu/d=
rm/amd/display/amdgpu_dm/dc_fpu.h
index b8275b397920..4e921632bc4e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
@@ -31,4 +31,12 @@ void dc_assert_fp_enabled(void);
 void dc_fpu_begin(const char *function_name, const int line);
 void dc_fpu_end(const char *function_name, const int line);
=20
+#ifndef _LINUX_FPU_COMPILATION_UNIT
+#define DC_FP_START()	dc_fpu_begin(__func__, __LINE__)
+#define DC_FP_END()	dc_fpu_end(__func__, __LINE__)
+#else
+#define DC_FP_START()	BUILD_BUG()
+#define DC_FP_END()	BUILD_BUG()
+#endif
+
 #endif /* __DC_FPU_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/am=
d/display/dc/os_types.h
index 782316348941..6af831710489 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -55,8 +55,6 @@
=20
 #if defined(CONFIG_DRM_AMD_DC_FP)
 #include "amdgpu_dm/dc_fpu.h"
-#define DC_FP_START() dc_fpu_begin(__func__, __LINE__)
-#define DC_FP_END() dc_fpu_end(__func__, __LINE__)
 #endif /* CONFIG_DRM_AMD_DC_FP */
=20
 /*
--=20
2.51.0.710.ga91ca5db03-goog

