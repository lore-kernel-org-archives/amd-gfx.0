Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FF8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 22:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D174D10F6F9;
	Wed,  4 May 2022 22:24:25 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E91B10F6F9
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 22:24:24 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id x18so3824230wrc.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 May 2022 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+/Ezgj22Gmozpp6q9eARUGO5yKzKZ533U097jBrpUGM=;
 b=G8nzAihdhI3jBu34ysc6XoWdbJ5Ryxy3rCX8J/uU6ClY5Yzqp1QWiy4lXHj2PoZyJm
 e3cQfKVvfmo20/hjeHqqsz401Sp0rVOjtYNwBikg6eVVJMd09nUN5z1f5p0h7TbWn34m
 Qd49TkASZ2sP4bguW+KMm3KGdEST98m64Y6AHF+MSJWjIskjlM0nfpu4y5FW1TxMbPDu
 xBYeoYYlPtfpKl3x9S+/mZUa0EM71oVvF+DmTxEYGq4HTL4Vzc0ldd6kqR6Pj8Zcmcgs
 cWt5vBdfBq3X5g4Lt4A3LsEm7o5wkI1iS/DtMCeD32jTK5rtYAdGPO8Cf1d1aKRPEZnr
 +/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+/Ezgj22Gmozpp6q9eARUGO5yKzKZ533U097jBrpUGM=;
 b=FqyCCLC+eXehCh8Cm4BZiDsW1Wu5jLRJQq0VhLBKCQA1yDJgh51/f88LgLs65HwQxk
 DzQdPGwayFgQM+xRs44tzuoS/8dUAOEJl4aecGoLFUcXjFBmQ8fS77ma4GI1CYTzEXg7
 35RUHwW+7TKkmMWPbbFEchrXFb2JOO2idQVqTEsa4Gn2/1GtqZDy3brfqLzIoBz/0vtO
 LlisN093n5e6xmzPICWZYww6PakN8gpvlwZkYqHBagINTBt8ras6f4/sb3GQJabV71IB
 5VHIO9zK0w4pXTGEQ64b52pYrxlJ0lDbvBbI1rpDOdERTJqiWhx05javX8pVEwFW8dvI
 Ad7g==
X-Gm-Message-State: AOAM532UiE+d6DkJuIgWd6aVQua82duGlCq0paxNKT0MunCVf3Es2Iga
 kHjMVV+LhQ/ovy2kGPWi0P+jaYFNq9ql5g==
X-Google-Smtp-Source: ABdhPJxn8sWuQGxvrpLyIMhRlRjXk643psCoFltZTuYK9Q9nl+44dtwmgobZrCuzPddxTbV0y1fARw==
X-Received: by 2002:a05:6000:508:b0:1e4:a027:d147 with SMTP id
 a8-20020a056000050800b001e4a027d147mr18110101wrf.315.1651703062387; 
 Wed, 04 May 2022 15:24:22 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:f40e:900::24e])
 by smtp.gmail.com with ESMTPSA id
 f11-20020adfc98b000000b0020c5253d910sm13340443wrh.92.2022.05.04.15.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 May 2022 15:24:21 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/gfx11: Avoid uninitialised variable 'index'
Date: Wed,  4 May 2022 23:24:14 +0100
Message-Id: <20220504222414.95884-3-mike@fireburn.co.uk>
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

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:376:6: warning: variable 'index' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
        if (ring->is_mes_queue) {
            ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:433:30: note: uninitialized use occurs here
        amdgpu_device_wb_free(adev, index);
                                    ^~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:376:2: note: remove the 'if' if its condition is always false
        if (ring->is_mes_queue) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:364:16: note: initialize the variable 'index' to silence this warning
        unsigned index;
                      ^
                       = 0

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 141c64636577..c5655128fd9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -430,7 +430,8 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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

