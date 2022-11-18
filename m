Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEA7C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 15:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2091610E191;
	Fri, 18 Nov 2022 15:30:32 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8B4E10E191
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 15:30:27 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id m22so13816931eji.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 07:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NzYUZvQmI1I+AH0A+ButWdNS0jMmFgT8YSDbj9Hq1w8=;
 b=ImFJ2dXlAnrh/Dmw9daIf1JSS9bJCuyAil2tPUKky8uwpjO4dslphaQNyfNY5tMV9Z
 6uv9HE5+H3sF2/rXoJpfLqhadMVSOBCLeBnmOF7ZXpc5exKTuDh4DVv2KXLboWPV6gef
 5JdeknPcrszpzBYHBWbdZCw8feH3hnuvgjooJbaugrC8JPNYCHLQR30dHXj+PCE1v2co
 7DzKXjJZsRSJH8dnWIdPkDhQC4NWU6Qbs3pfpVPhfLQQz+QOFpkLCTr+X8xFwCP8LDO1
 Sj8BwincTLsYIQwCGF6wPb6zEphVfkwh1uLUbeBgM4czHcZicHFAJl+8IngcInol+ZV6
 EWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NzYUZvQmI1I+AH0A+ButWdNS0jMmFgT8YSDbj9Hq1w8=;
 b=phSePJNTNMR8n3D2ocHBTqr4NzoHflscDZ+PtSbUM+tLMtljCI4b2mTCtlLuOP13Cy
 H/jW0II2j4KkzcR496fsj7ynHnIcwKCD3IRLDetRNqJ+HGrqBoUKCOm2s6FqqKoSfyEM
 Xp1owOvCp1NFc6RuGbPOksvXX0C0y4u5QiSaqIqsH62/bXQ8DrYHKWIGdV5SS7G9Gnh+
 lLhgsBRNiPBGwoytmFM/Rc1K9O4cljYo7qLAq/MyfgtR8jEBMjhWrXEdJFjcfuAEy7T6
 GffvSrC6zqttj/ajZ0inOm4Cn2v3/vs1i1l71EMCfexqchFgrecYQtPIPp1nq6TTvyIQ
 xqrA==
X-Gm-Message-State: ANoB5pk3Jds1DF3oGgGNeCBEOI6U2GxpLPrLMkfIEveKKuwjaoYh7Akg
 Hqdh/cHYVRZHMT4eZ/sYtwMquWuBD04=
X-Google-Smtp-Source: AA0mqf4p/8z8i5e6g2nDf0Ugc08b4lsdTodgYJGGf+DtqNlEnivW+pKpKtLgywfr1sEwAaIv8izFdA==
X-Received: by 2002:a17:906:1b15:b0:7ad:dc7e:1b8d with SMTP id
 o21-20020a1709061b1500b007addc7e1b8dmr6300734ejg.276.1668785426251; 
 Fri, 18 Nov 2022 07:30:26 -0800 (PST)
Received: from EliteBook.fritz.box ([2a02:908:1256:79a0:6df3:758:835a:3ec8])
 by smtp.gmail.com with ESMTPSA id
 bv15-20020a170906b1cf00b007a4e02e32ffsm1812592ejb.60.2022.11.18.07.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Nov 2022 07:30:25 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: handle gang submit before VMID
Date: Fri, 18 Nov 2022 16:30:23 +0100
Message-Id: <20221118153023.312582-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise it can happen that not all gang members can get a VMID
assigned and we deadlock.

Signed-off-by: Christian König <christian.koenig@amd.com>
Tested-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Timur Kristóf <timur.kristof@gmail.com>
Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index cd968e781077..abb99cff8b4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -254,6 +254,9 @@ static struct dma_fence *amdgpu_job_dependency(struct drm_sched_job *sched_job,
 			DRM_ERROR("Error adding fence (%d)\n", r);
 	}
 
+	if (!fence && job->gang_submit)
+		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
+
 	while (fence == NULL && vm && !job->vmid) {
 		r = amdgpu_vmid_grab(vm, ring, &job->sync,
 				     &job->base.s_fence->finished,
@@ -264,9 +267,6 @@ static struct dma_fence *amdgpu_job_dependency(struct drm_sched_job *sched_job,
 		fence = amdgpu_sync_get_fence(&job->sync);
 	}
 
-	if (!fence && job->gang_submit)
-		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
-
 	return fence;
 }
 
-- 
2.25.1

