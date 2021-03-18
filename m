Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D00CC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 08:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9251164E21
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 08:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9251164E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qtec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 442A46E1AA;
	Thu, 18 Mar 2021 08:34:53 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DA66E1AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 08:34:52 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id ce10so2589997ejb.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 01:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtec.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TGI8HIQlc4uaCPugxl2JDwGzxpy1JYs+5hYiFdwZIn4=;
 b=JHznz+RlAzfthyHdm4DXDxFzqBAGb+To7jbFrFPGg1J8RBHYexcZoqiGSSofvrjX2t
 nPHfdm613VsfXavQiZJYsxJkK9fzmAA2q9SwR/vJY9U3QGOXUiuFWtlsu5ySOonOrY9f
 vYg8B32bjUhCxH9JpXr/IfmJUUzZWXTRjEzyhgkE10BmFMVRvgdeFwysSJEzyMcEzVsx
 hiBzus8RSHx/T/7f+Mo/cY1cWKd+3MrMJzJaA1xJzc7ynrhLb50g1zE7NJkp+pF3EGQp
 785qiDE5otl8YdCjWvspELG7FamIPz1KwFQOPz+ADm6w6yHFrjFV+jnn+wJXzuAbn+hl
 f6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TGI8HIQlc4uaCPugxl2JDwGzxpy1JYs+5hYiFdwZIn4=;
 b=A8I9dSGSnAbxZVd5ukqf+oRQt82CdKt2h3WfMkmvrIPNpk71Tx0nR5DcrGi2ompo4/
 nD9l0faGk6ZaZQ0EIvm77aXvQJMfy25vAZBvGHLv+Ay7Qu+g8afrrmw+up/YenZQRzi9
 Ahl0oHi6GFCntBcVw74n8SAoEe0zTFShUk/FG5GY22u3JB4IVvdrmhFCaLbmTMX5kp0J
 tpU/RhzQB/svzdifvCrMPXtdgrnGd1HsNZmD/rr2d6cCjyZ5yMfFxrtIKJ6B8eGbzhNh
 Kzm8VauMtelSGLj7r/27d8R68MipFuwu+L+pDAi5ZGA4O24AGS7ruFUMdl0x3uT4GToT
 Wyaw==
X-Gm-Message-State: AOAM530NBbwjLbTOMXJwpCFBpkg9lJVk5xrJM8WmUb/k83T5XoMS41L9
 kHSCFUJ1FaA30YqSDQ0yLR1nDA==
X-Google-Smtp-Source: ABdhPJybE5Kdxq92QLKVUG8Nhp0he0ishzyEmigHj7338liUP4XJbTsowAkqIM8U1qmXN+OPvVRe4Q==
X-Received: by 2002:a17:906:d71:: with SMTP id
 s17mr40870466ejh.126.1616056490945; 
 Thu, 18 Mar 2021 01:34:50 -0700 (PDT)
Received: from localhost (cpe.ge-3-0-8-100.ryvnqe10.dk.customer.tdc.net.
 [80.197.57.18])
 by smtp.gmail.com with ESMTPSA id bt14sm1316462edb.92.2021.03.18.01.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 01:34:50 -0700 (PDT)
From: Daniel Gomez <daniel@qtec.com>
To: 
Subject: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
Date: Thu, 18 Mar 2021 09:32:36 +0100
Message-Id: <20210318083236.43578-1-daniel@qtec.com>
X-Mailer: git-send-email 2.30.2
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dagmcr@gmail.com,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Daniel Gomez <daniel@qtec.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If userptr pages have been pinned but not bounded,
they remain uncleared.

Signed-off-by: Daniel Gomez <daniel@qtec.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index e8c66d10478f..bbcc6264d48f 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -485,13 +485,14 @@ static void radeon_ttm_backend_unbind(struct ttm_bo_device *bdev, struct ttm_tt
 	struct radeon_ttm_tt *gtt = (void *)ttm;
 	struct radeon_device *rdev = radeon_get_rdev(bdev);
 
+	if (gtt->userptr)
+		radeon_ttm_tt_unpin_userptr(bdev, ttm);
+
 	if (!gtt->bound)
 		return;
 
 	radeon_gart_unbind(rdev, gtt->offset, ttm->num_pages);
 
-	if (gtt->userptr)
-		radeon_ttm_tt_unpin_userptr(bdev, ttm);
 	gtt->bound = false;
 }
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
