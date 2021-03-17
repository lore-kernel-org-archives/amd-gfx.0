Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96754C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 16:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1704664E0F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 16:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1704664E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qtec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 845A86E83A;
	Wed, 17 Mar 2021 16:09:12 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7DA6E83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 16:09:11 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id x21so2947098eds.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtec.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LASiUJZzM9SBb9BxKINWFm41CPO6shbrsdTJEhF0yaI=;
 b=AcdBsvvDD2mwFdfxN/x9OEPZ9qMAuRMrKpdDV1i4T21fK6CjXwy9q2ec5vuUyhqSVU
 YxhQhmA2y8qF98lT8KeMsaGZPfVofrohBN4qyucfteUQI0I61JRe1UVjhPHK1PeaFQMA
 ucoRKbeWZNzY2G9CoetUJPJeJzegqAsY6/rh2iY23vl6MTgxFjhNGCIpBJhmp6a+qQlz
 CGLbNnuYh9DsXSx7OCVwbOiraQT/36gokUTMi3A0zCOo1FIhnkrJL5OyaKUTHFIl0Its
 nyBFM+XbIHW6ggbvMmmx1j9dHPQ8meFDMtsPe3h+6BxVenrUVbC/mPFole2mcp4CFu7A
 0YLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LASiUJZzM9SBb9BxKINWFm41CPO6shbrsdTJEhF0yaI=;
 b=HqPw9fBdEJiJ9KDSZzn/ocoefIPDXJF3GXWJnv7SQ33nvC709MGX4h2ljy/sBpsD3M
 KvIkWyNI3hcab2aRWwctuRtT8g69RsTmRXtnCfYI6m1EGi0vgMag4KcvjhpO5geDBTlW
 EeE1c1BrtSbEGA1BKKL5WgW8BbFKk1F+dITUxrPKFMNziXGwW5k5Dx8X6/OVwtjFMgjv
 KrmXzqNQLZK+xomGC1FTpAvneSY4UJqbHZHjahuN45bVHEjClxkkeWguJYeWjzt7G2fI
 BcTdy352I3swD1mk0MlvL90bo2TQ/BOFqRbw4lWyYQJk0YA6xOh5gUAJk4DRaP4rta7o
 upKA==
X-Gm-Message-State: AOAM530juK6Fo03aOJRlG7vkKrgWol0jCY4JiPXADxjvs61du160qKvg
 jM0UJa4iM5ENs9PPrmxQqe4nfA==
X-Google-Smtp-Source: ABdhPJw8pAC+ltODr7pfOGR0W+UPfJGOqgti1MYP3D5tSM/qw4/LpsgROfHRX/6VU5kN534YcFcn7Q==
X-Received: by 2002:a05:6402:22b5:: with SMTP id
 cx21mr43085461edb.27.1615997349970; 
 Wed, 17 Mar 2021 09:09:09 -0700 (PDT)
Received: from localhost (cpe.ge-3-0-8-100.ryvnqe10.dk.customer.tdc.net.
 [80.197.57.18])
 by smtp.gmail.com with ESMTPSA id q11sm11728843ejr.36.2021.03.17.09.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 09:09:09 -0700 (PDT)
From: Daniel Gomez <daniel@qtec.com>
To: 
Subject: [PATCH] drm/amdgpu/ttm: Fix memory leak userptr pages
Date: Wed, 17 Mar 2021 17:08:37 +0100
Message-Id: <20210317160840.36019-1-daniel@qtec.com>
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
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Likun Gao <Likun.Gao@amd.com>, dagmcr@gmail.com,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Dave Airlie <airlied@redhat.com>, Daniel Gomez <daniel@qtec.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If userptr pages have been pinned but not bounded,
they remain uncleared.

Signed-off-by: Daniel Gomez <daniel@qtec.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9fd2157b133a..50c2b4827c13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1162,13 +1162,13 @@ static void amdgpu_ttm_backend_unbind(struct ttm_bo_device *bdev,
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
 	int r;
 
-	if (!gtt->bound)
-		return;
-
 	/* if the pages have userptr pinning then clear that first */
 	if (gtt->userptr)
 		amdgpu_ttm_tt_unpin_userptr(bdev, ttm);
 
+	if (!gtt->bound)
+		return;
+
 	if (gtt->offset == AMDGPU_BO_INVALID_OFFSET)
 		return;
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
