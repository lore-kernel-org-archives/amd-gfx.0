Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D82C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 22:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 581CA10F6F3;
	Wed,  4 May 2022 22:24:24 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F23510F6EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 22:24:23 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 1-20020a05600c248100b00393fbf11a05so4038691wms.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 May 2022 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6Ga5TkI0yD0gofCst1yemXxDxcwdSFNMnOHhUlbf2Po=;
 b=emo1I8RO+J/FmkNRHVQO39lYHQjhypX7OU7l3XJ35s065wi99NnN7oHnJL8CAPPkEs
 d4510bDOEydkUllul++8Bo7/sqQU27qsS4OcsC/kGcQWj9Y2PugTIMkkZQS6RdW1uZlv
 Ab77cAS4AOVGkqMqriFHQMnrUmvfzfx5regECUQ2aV17kkluqKs8m8z8fbDOuMko8wbp
 /t1pckf7ZPUcCbiEpe4g5FDTyI2MQigvY96ZqB9cJc6D6Sa3BE623hmvBCx8J6tLExD7
 Wv89nr0YVK2Hv1LO+shybEJVSPAG/vgexc1zTGfykEzLmcv9inYanra//bNu+TuDqze7
 gXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6Ga5TkI0yD0gofCst1yemXxDxcwdSFNMnOHhUlbf2Po=;
 b=aPynMUnQs0ktK2uxCcG66C4Xp47N9Z9r3svauqVJBI82NSg8ai7fPnUS6hbZXQgxq+
 5tLZJjKkV78U6SVvWyG/busChpitS0YdlKms2NxPDu3LqXma2TQc0Ms8s3te/nsP+XNe
 PeeEo+90YMqNfT0fCrR8nzfyhGhaV2BJrz6lQc0SAfPp1cZTCkCqcZPIfwAVJytxiZjn
 g91lK19b4pIGiTBDer98yb+tQWu5jJ94gY1uIM6s1V7c5G61RS7+11pHhLoN96Ogqc9n
 iyO0WRx0zxh9MBcOyCoZub2X2uZN7MQxF/x322t2XMJqY6Q9FXh96ad8VM+y8YP8U+kh
 Y4sw==
X-Gm-Message-State: AOAM533p9Syw5bi4F23KiLogubzaU4TxVPCXR3fiUn8gJpUDfLb1eOtS
 gU1L9ZHugrdUmVvLemNPAIvIwpUs8zAaNQ==
X-Google-Smtp-Source: ABdhPJy2wES4qLRpAjqZPO9y0N+a0NbfFPrqxszP060FDqPbojiXcK97AeU558zclXt3+JgVJslInw==
X-Received: by 2002:a05:600c:1c93:b0:394:4942:3518 with SMTP id
 k19-20020a05600c1c9300b0039449423518mr1470189wms.82.1651703061291; 
 Wed, 04 May 2022 15:24:21 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:f40e:900::24e])
 by smtp.gmail.com with ESMTPSA id
 f11-20020adfc98b000000b0020c5253d910sm13340443wrh.92.2022.05.04.15.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 May 2022 15:24:20 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/gfx10: Avoid uninitialised variable 'index'
Date: Wed,  4 May 2022 23:24:13 +0100
Message-Id: <20220504222414.95884-2-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504222414.95884-1-mike@fireburn.co.uk>
References: <20220504222414.95884-1-mike@fireburn.co.uk>
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
Cc: Mike Lothian <mike@fireburn.co.uk>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This stops clang complaining:

drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3846:6: warning: variable 'index' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
        if (ring->is_mes_queue) {
            ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3903:30: note: uninitialized use occurs here
        amdgpu_device_wb_free(adev, index);
                                    ^~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3846:2: note: remove the 'if' if its condition is always false
        if (ring->is_mes_queue) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3839:16: note: initialize the variable 'index' to silence this warning
        unsigned index;
                      ^
                       = 0

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index fc289ee54a47..043f8bc37f21 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3900,7 +3900,8 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		amdgpu_ib_free(adev, &ib, NULL);
 	dma_fence_put(f);
 err1:
-	amdgpu_device_wb_free(adev, index);
+	if (!ring->is_mes_queue)
+		amdgpu_device_wb_free(adev, index);
 	return r;
 }
 
-- 
2.35.1

