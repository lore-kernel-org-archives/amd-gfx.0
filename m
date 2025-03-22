Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A93DC35FFC
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 18:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA9510E163;
	Sat, 22 Mar 2025 18:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQyPYn55";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A5A10E169
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 18:37:58 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7c5b8d13f73so258918185a.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 11:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668677; x=1743273477; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dtNCr0vxCsZMtk27zzXOjhkrGn/c4s+pRVuX2X7uk1o=;
 b=hQyPYn55LvMiYuRrve5JMdtg+n/ofOnPyWqgERbMWg84inn3U4dObvjdiFehillQk9
 OR0lWjm8s5M6IM6QlhgF0c5K94nnBbNJmSl+9t4WLEmKv2i+zu55RqoOizl31p4kmCz+
 KwOBhrF8Nz2eTCftr2GZwYFnpjD0OZadhEKBuArGH4IVQYNT0TF/IT+UwQEZypdENhL/
 lWYmn1JUf7d+iabXGqdlTym05Br5YSETkxsIfHUtlewDf3Fj4RbXUIqS315hV6QN/UQj
 fdvaAU77+76AhUR8Um96gFKlCWxVoDrPoCfjURAKEZuWWbhycE18btaVoTVArxcDrunH
 DZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668677; x=1743273477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dtNCr0vxCsZMtk27zzXOjhkrGn/c4s+pRVuX2X7uk1o=;
 b=stsBkdi61w6HSc8vN4UZNu/KHpzir0LQyljG2sRo8qiT5VH/4LM1mVJ3it3g1pucea
 pbCaS41jckQ/vT/kuYvBrk+5Jl+0EdnSIBC5KMR2onYkLKXq3fmb2HlfpHQ/9WSBrtrT
 zlH8/KYcJEbBNmU17BN8CvHXL9vhIOgwnVzr/L9aF3fXDy8DfyzGpsmlAlOZmuOTSt9T
 XGOZW/EvKdpomo3QGKHpHTzcBsruRbQKbyHHMmCEZ+q+R9ym69BGgEFB5ysp0Oh+qFXv
 TI2PWrlFxd3KzQYPSzWa55k9YQdiHwJ5+adrHlI98EvlanNWjZiZJ/ibGWVMTBEMW4dU
 3Brg==
X-Gm-Message-State: AOJu0YxHG5Jh4GCV1DFJ848AXzxUhMftWahZzmRgkvNk9Ff7Ly4qj8kP
 aYGhyxEngyvCiF5HyU1r/QOS6Hvau2GOAG1f0pa+PM/gBmRe662r2evzuw==
X-Gm-Gg: ASbGnctd7Z8DaPa7s3WPbO7SxXUqZ5PVZh7+Jr0Fxuc6JeDjzXA63PSbHCoE+h6LYr9
 rHSK7bZnFNe3bqgZhx/807cjhZTvmUVvxVMvoTet0u5YvFYl/1qijN8V+JZ/Wof9l9zNhsb/8np
 RbIp6+hisY8EspYtcwn9+rc+P38gwA1tXe8itkIyll3RVGtPHlf8CNR9IsdUTukJ1ZgB+8UJG+U
 3ePNy4mBjU+c3muf80koZ79DryvLp1oLTWnOt8Z7qa9/ABwhNNtgMARPUR7bhhbRtducZWlvmOr
 gCZEKRTdXttNAVESm2rKh39TtrER0h+/149N8zUpWwCfTlgRUDGpNuiVNm7mpEv3oOg=
X-Google-Smtp-Source: AGHT+IH4/btHwes6RwZgrfydLlk2D3fMSH4hquGik4S2qS8/UtAAMr/GK/5VJ5jhxK8FFqcgr5CvYw==
X-Received: by 2002:a05:620a:d96:b0:7c5:6bd5:2ea3 with SMTP id
 af79cd13be357-7c5ba1fc70dmr1256363785a.56.1742668677513; 
 Sat, 22 Mar 2025 11:37:57 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec688sm279895085a.64.2025.03.22.11.37.56
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:37:57 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/5] drm/amdgpu: fix style in dce_v8_0.c and in vi.c
Date: Sat, 22 Mar 2025 14:37:46 -0400
Message-ID: <20250322183746.86002-6-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
References: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
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

Bring things on a single line and fix spacing.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 10 +++-------
 drivers/gpu/drm/amd/amdgpu/vi.c       |  8 ++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index f008615343c3..533851beb27c 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -3233,8 +3233,7 @@ static const struct amd_ip_funcs dce_v8_0_ip_funcs = {
 	.set_powergating_state = dce_v8_0_set_powergating_state,
 };
 
-static void
-dce_v8_0_encoder_mode_set(struct drm_encoder *encoder,
+static void dce_v8_0_encoder_mode_set(struct drm_encoder *encoder,
 			  struct drm_display_mode *mode,
 			  struct drm_display_mode *adjusted_mode)
 {
@@ -3330,8 +3329,7 @@ static void dce_v8_0_ext_commit(struct drm_encoder *encoder)
 
 }
 
-static void
-dce_v8_0_ext_mode_set(struct drm_encoder *encoder,
+static void dce_v8_0_ext_mode_set(struct drm_encoder *encoder,
 		      struct drm_display_mode *mode,
 		      struct drm_display_mode *adjusted_mode)
 {
@@ -3343,8 +3341,7 @@ static void dce_v8_0_ext_disable(struct drm_encoder *encoder)
 
 }
 
-static void
-dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
+static void dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
 {
 
 }
@@ -3407,7 +3404,6 @@ static void dce_v8_0_encoder_add(struct amdgpu_device *adev,
 			amdgpu_encoder->devices |= supported_device;
 			return;
 		}
-
 	}
 
 	/* add a new one */
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a83505815d39..bcabcf27c3d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -61,19 +61,27 @@
 
 #include "vid.h"
 #include "vi.h"
+
 #include "gmc_v8_0.h"
 #include "gmc_v7_0.h"
+
 #include "gfx_v8_0.h"
+
 #include "sdma_v2_4.h"
 #include "sdma_v3_0.h"
+
 #include "dce_v10_0.h"
 #include "dce_v11_0.h"
+
 #include "iceland_ih.h"
 #include "tonga_ih.h"
 #include "cz_ih.h"
+
 #include "uvd_v5_0.h"
 #include "uvd_v6_0.h"
+
 #include "vce_v3_0.h"
+
 #if defined(CONFIG_DRM_AMD_ACP)
 #include "amdgpu_acp.h"
 #endif
-- 
2.49.0

