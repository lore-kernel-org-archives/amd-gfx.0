Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33EDC76196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 19:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D4510E176;
	Mon,  3 Apr 2023 19:41:20 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C9E10E185
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 19:41:16 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 v20-20020a05600c471400b003ed8826253aso56983wmo.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Apr 2023 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1680550875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFmiqpkCTFnjtf4my3WK3tS/w7ej04x/lzeSFwb3rYY=;
 b=YqN1soupUIAmrp0wYyCdXGtkFaPd2VA3aa61JIlPlNUHbqDhXCn7/qmBf7b7+opIEk
 +Fnq3D7BP5l3LBPYU7junoPZ/HyjKcxicHcJ8ypefIMdhiow66RuMP+Waq6MneOrho/C
 t9C+Vw6OeAWhjKfcsaW/0Yqe4U0lh4IgRFRaA88R3wLHGGi9aH9TYl9Yqnyt6++RdYrC
 72stou26QuIyZ7qwRzradlWGiQnRO0I6pPPiKmDZ8DutPSI4CF/KDcQEtCxhiPWFN1jo
 n3NqqVOIxQ8RjaV/J0ZAleVDZnL+UW0oGqki4Pf5IvTmZh+FwHpDK2o46Rymsz9gI9O1
 eEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680550875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFmiqpkCTFnjtf4my3WK3tS/w7ej04x/lzeSFwb3rYY=;
 b=t5cGN9X2jy9aztCOyp7JDh06swq2tUTbTq5CHOHrwIbhJ2WUaMbJuXamuEgTifxdPg
 i9thiuigVigH2R8Wy1EECEUZ2h1f3c/h0ZF34oOj0lEqr9qMM242PY691uELnXLoi7/P
 +GUf2eVUqukkSgbZ2PuZyZnbjdbJ2IUAO8FRHVvb0KpcYDNYyOLl0PE9Dy2fJUJJYSYb
 9/0nnMRVslB+zqLMFS/aHGWHyztUGc5UP3jkrFHhe5kmfitA0mjk+bWfmrgMPQJeetYG
 eJe5CzAb03cEDlYwSGfVL+ANlPeDQSE1IUM7BDBKqTFQVTS9ydfi6ZDoS1BbzrUELVLG
 PwyQ==
X-Gm-Message-State: AAQBX9dZZg7yR1u5ap1kLQxSzNKQixG5suM0b/sv9Wl6OLXvXZF7sZd6
 nRh0Xa8P8aCh4J5Yuqe1hkQ4ug==
X-Google-Smtp-Source: AKy350Yh5yTxinihKbIM/Y9VPkw8VbxSG/Vln+iAV1Ckvhwi3vj/k7P3pOEQHDVlZsqUxvhLHD9fsg==
X-Received: by 2002:a7b:c4d3:0:b0:3ed:b590:96e6 with SMTP id
 g19-20020a7bc4d3000000b003edb59096e6mr417958wmk.4.1680550874973; 
 Mon, 03 Apr 2023 12:41:14 -0700 (PDT)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a7bcb11000000b003ef5db16176sm13036342wmj.32.2023.04.03.12.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Apr 2023 12:41:14 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 1/4] drm/scheduler: Add DRM_SCHED_PRIORITY_VERY_HIGH
Date: Mon,  3 Apr 2023 20:40:55 +0100
Message-Id: <20230403194058.25958-2-joshua@froggi.es>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403194058.25958-1-joshua@froggi.es>
References: <20230403194058.25958-1-joshua@froggi.es>
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
Cc: Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This allows AMDGPU scheduler priority above normal to be expressed
using the DRM_SCHED_PRIORITY enum.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
 drivers/gpu/drm/msm/msm_gpu.h           | 2 +-
 include/drm/gpu_scheduler.h             | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index d2139ac12159..8ec255091c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -79,7 +79,7 @@ amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
 		return DRM_SCHED_PRIORITY_HIGH;
 
 	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
-		return DRM_SCHED_PRIORITY_HIGH;
+		return DRM_SCHED_PRIORITY_VERY_HIGH;
 
 	/* This should not happen as we sanitized userspace provided priority
 	 * already, WARN if this happens.
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index fc1c0d8611a8..e3495712b236 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -336,7 +336,7 @@ struct msm_gpu_perfcntr {
  * DRM_SCHED_PRIORITY_KERNEL priority level is treated specially in some
  * cases, so we don't use it (no need for kernel generated jobs).
  */
-#define NR_SCHED_PRIORITIES (1 + DRM_SCHED_PRIORITY_HIGH - DRM_SCHED_PRIORITY_MIN)
+#define NR_SCHED_PRIORITIES (1 + DRM_SCHED_PRIORITY_VERY_HIGH - DRM_SCHED_PRIORITY_MIN)
 
 /**
  * struct msm_file_private - per-drm_file context
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 9935d1e2ff69..a62071660602 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -55,6 +55,7 @@ enum drm_sched_priority {
 	DRM_SCHED_PRIORITY_MIN,
 	DRM_SCHED_PRIORITY_NORMAL,
 	DRM_SCHED_PRIORITY_HIGH,
+	DRM_SCHED_PRIORITY_VERY_HIGH,
 	DRM_SCHED_PRIORITY_KERNEL,
 
 	DRM_SCHED_PRIORITY_COUNT,
-- 
2.40.0

