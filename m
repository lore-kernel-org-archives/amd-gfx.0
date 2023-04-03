Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF7CC761AF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 19:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B55D710E1B0;
	Mon,  3 Apr 2023 19:41:22 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D8610E1A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 19:41:19 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 l10-20020a05600c1d0a00b003f04bd3691eso3867517wms.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Apr 2023 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1680550877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jeihcfukgEVdleWTzZvtjv81OMqMHDJ4MNDRBvosf9w=;
 b=QAChqaneuBG+aMnrz0m53k+wnMZ8xvjACevW8eT4V+BciT++1q+2YGIM7bpuHE7CbS
 7nYPi30ASA4H+rjTbV6JbJAgyBgmGsUv6tg2h3sFQYDrqOTQwV2v4ZYlXqvAH+FLuiM3
 V9n7i5fzaN3AAYTB/pHZugYEF4AJkwuhH9mnY9Y8IjKczce0ttduntpy/qJGu5reGwWs
 wemQ+ZWyoVKz7aVsQlu5qt3XyBiHcdXBIvGiY1nUnsNT6KwnXgIW86qm6kTnSOXdK5+i
 dMs0AdlHjl21IbXBr0A/qj67SdQ4XWw9IDOemtglSbdmUpfhHl/GBuYm2EtQ4r5xfUvg
 2f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680550877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jeihcfukgEVdleWTzZvtjv81OMqMHDJ4MNDRBvosf9w=;
 b=S++5Rf4lnL5F7w0Ho2PEh1U7O82JywJdD6Ya/h3uci/52upUFfWpGZ1dWUg2YrT1vM
 ncHgwahf7zIgTqd67Yjqv4te7GPmLvOJNMBBiieRBhasbcnTSlLir16xydlCBOrzL/GQ
 i3XkzYqsfb+KUcefHz35Tx6w3gCnZMNx2OlQnTAorPRlgQPA+D92fZ1vZoNAGGzTAphf
 ZyiOvWEDLKO0Szg0d4VvjCVx4fdgZZv8YD5B5I5WsdZc/YkiSUpgypPz8Zn58u56If+e
 jQQ956fhC0wk08eYcXVOUTBb7/F07JXbyxlj8Ee6GnAjB8YGReZz60PhP/bViyGw1LR3
 ulOg==
X-Gm-Message-State: AAQBX9dcIECuPt6XMTEIRMOCybDdkelYdU2XLX72iMbwQkiDlSduJkzy
 Iq967WRi67rleEv0K6KW7LkR3w==
X-Google-Smtp-Source: AKy350ZugkhHY/2mxIMYNHBkqx30+syG2zupYyi0bllEk5Jq3cP7PWoj1FUolku4GnuaseopCZmD0A==
X-Received: by 2002:a05:600c:225a:b0:3ed:9576:34ce with SMTP id
 a26-20020a05600c225a00b003ed957634cemr421533wmm.9.1680550877507; 
 Mon, 03 Apr 2023 12:41:17 -0700 (PDT)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a7bcb11000000b003ef5db16176sm13036342wmj.32.2023.04.03.12.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Apr 2023 12:41:17 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 4/4] drm/amd/amdgpu: Check RLIMIT_GPUPRIO in priority
 permissions
Date: Mon,  3 Apr 2023 20:40:58 +0100
Message-Id: <20230403194058.25958-5-joshua@froggi.es>
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

Add support for the new RLIMIT_GPUPRIO when doing the priority
checks creating an amdgpu_ctx.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 8ec255091c4a..4ac645455bc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -28,6 +28,8 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_ras.h"
 #include <linux/nospec.h>
+#include <linux/sched/signal.h>
+#include <uapi/asm-generic/resource.h>
 
 #define to_amdgpu_ctx_entity(e)	\
 	container_of((e), struct amdgpu_ctx_entity, entity)
@@ -94,11 +96,16 @@ amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
 static int amdgpu_ctx_priority_permit(struct drm_file *filp,
 				      int32_t priority)
 {
+	enum drm_sched_priority in_drm_priority, rlim_drm_priority;
+
 	if (!amdgpu_ctx_priority_is_valid(priority))
 		return -EINVAL;
 
-	/* NORMAL and below are accessible by everyone */
-	if (priority <= AMDGPU_CTX_PRIORITY_NORMAL)
+	/* Check priority against RLIMIT to see what is allowed. */
+	in_drm_priority = amdgpu_ctx_to_drm_sched_prio(priority);
+	rlim_drm_priority = (enum drm_sched_priority)rlimit(RLIMIT_GPUPRIO);
+
+	if (in_drm_priority <= rlim_drm_priority)
 		return 0;
 
 	if (capable(CAP_SYS_NICE))
-- 
2.40.0

