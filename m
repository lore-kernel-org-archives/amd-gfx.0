Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B96AC35DE1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 13:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3C82064A
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 13:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4byQMGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3C82064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44806EACD;
	Tue, 25 Feb 2020 13:39:51 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C7E6EABD
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 13:39:49 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id n127so415615ywd.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 05:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zbye+0QK2dyYGt6xCggEo48zYHx0bB1eFskmt885bOg=;
 b=M4byQMGj1WQ3C2R+8Tq33G39oIy/UTdAyY/GbW4Q8aUVAlf9c1zPVgj0OASkIwZx1N
 bau+2MR0tyRIGUSmb6gl8Mzy9PZsg77jIh4KlXjQeR8fibAfOjDfghZLzCMBy1IkXhq4
 eGcKwySxUGHmrArT3/p87vEjXOYolGpzHPFCNlT1ua9f2UWu5Su7XlrZKwk//Fk3/uXR
 7NPIyzM72v5nrW1mtb9YUWy2IfFkRx0DwCKjMefswQlXqwalU9x89/wk0DySKFYi44+d
 h7siiW3J3XI8UnOg2dZbenz2uTvralxt7nlJEwYBx+7GC+PjqrEajxMyZxjCVN4Ym7lw
 E+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zbye+0QK2dyYGt6xCggEo48zYHx0bB1eFskmt885bOg=;
 b=LWp0Y6t6uO1NsCs3otMkH/BABXEgtdIq3PrSbHQhOfIJ6dxF/ZYpGLpQjxbmyIQyx2
 OEGRvhgjDTk2c927N5uJ+96VHwYfnHt/lq8UAsZ3PBbQ2ybT25nC6dCVo51GoSEsQ220
 tw64GmsNu2/qI8/dJ+lCnafyzClbPOILdL8czQL3iRgCde+CK9LOSY5tWl0NYe5IHa8s
 trV1GuTNuV+ST8LbqXuPbdjGWxRP+C0gEdjzmo9ubVMP420AjpxqnlM/A1wYX4aK8CII
 Ry+XI1UBzxJAZit3ndWN+leJWsjcOLKoAKyvZoUfRQk7+w3kTgzyVwacuYS/gsNwPMEn
 cE5w==
X-Gm-Message-State: APjAAAUci1HmgK8IDpcFT39AgAoEIbGUo09jZc9vkbp0gczKc37aHjVP
 NI+Zozme8Q8+ML3bRQsp9lHISh39Qd0gqQ==
X-Google-Smtp-Source: APXvYqzDhYRsul8T4+PmkkjJqqUccubRgp3NsAy4tRUjnaa+yAkyHUmXxCm48C4+mBZPer33kRj8Kw==
X-Received: by 2002:a25:c654:: with SMTP id k81mr50444920ybf.85.1582637988639; 
 Tue, 25 Feb 2020 05:39:48 -0800 (PST)
Received: from brihaspati.amd.com
 (p200300C58F2CDD00254CE01175F766E4.dip0.t-ipconnect.de.
 [2003:c5:8f2c:dd00:254c:e011:75f7:66e4])
 by smtp.gmail.com with ESMTPSA id 132sm6814352ywt.92.2020.02.25.05.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 05:39:48 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: use amdgpu_ring_test_helper when possible
Date: Tue, 25 Feb 2020 14:42:47 +0100
Message-Id: <20200225134247.16162-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_ring_test_helper already handles ring->sched.ready correctly

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 9 ++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c  | 6 ++----
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0f960b498792..7403588684b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -477,7 +477,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
 					   RESET_QUEUES, 0, 0);
 
-	return amdgpu_ring_test_ring(kiq_ring);
+	return amdgpu_ring_test_helper(kiq_ring);
 }
 
 int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 36ce67ce4800..7703be14390e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3156,12 +3156,7 @@ static int gfx_v10_0_kiq_enable_kgq(struct amdgpu_device *adev)
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.gfx_ring[i]);
 
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r) {
-		DRM_ERROR("kfq enable failed\n");
-		kiq_ring->sched.ready = false;
-	}
-	return r;
+	return amdgpu_ring_test_helper(kiq_ring);
 }
 #endif
 
@@ -3777,7 +3772,7 @@ static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
 					   PREEMPT_QUEUES, 0, 0);
 
-	return amdgpu_ring_test_ring(kiq_ring);
+	return amdgpu_ring_test_helper(kiq_ring);
 }
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 5af66a24b0a2..8ed9d42783e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -743,11 +743,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 			sdma_v5_0_enable(adev, true);
 		}
 
-		r = amdgpu_ring_test_ring(ring);
-		if (r) {
-			ring->sched.ready = false;
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
 			return r;
-		}
 
 		if (adev->mman.buffer_funcs_ring == ring)
 			amdgpu_ttm_set_buffer_funcs_status(adev, true);
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
