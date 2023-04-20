Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A68EC77B76
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 11:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F0BE10EBFC;
	Thu, 20 Apr 2023 11:58:03 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7372010E28A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 11:58:01 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id sz19so5856369ejc.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681991879; x=1684583879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPWF50phvovWb6tYxEH8mMltpUSXFpLVUZZtI4Y7SjQ=;
 b=mimpfzQY9svs4sU+lAwtk1fUE7/Z0Xe0PqE+WBVuaBnpgYs2kZbyC2JmAqunKhN218
 jWcC2d1WLuxJaKvipMeNR35ugj3eXqyYlQesLOCEaFd4xFpiXaTCdQtwOANzGG+jLES2
 rmBe4YxJ4sR7GO48hEQmYkNrHh16qACWq0kJrfiBLWPvUBwGD/zlkr0vsONhLs4MzVV5
 Q+oGfjB+/I9dBhpdFShK3F6sYNMVB9F635X3qH/A6lIpsjeYZ2+YSY0KRVuwfBy0Nf+A
 5vjKkRwMSZbKsWK4Q75X3k7ZQQrD5NYpTsikEA4Bg5sm5KC0izXdevJZf+mjhtswB0mY
 2kRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681991879; x=1684583879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPWF50phvovWb6tYxEH8mMltpUSXFpLVUZZtI4Y7SjQ=;
 b=Ut8NO+TkoQp7KkyOp2hEiTzrLrZ2OnbdCEWz44+Biwe8UlU8oe6keYFmi2JJoKF9JF
 ccG/qSDIKxPcjwyjHmLbW2wTtFZdBA2Cylzeq3cHrTkk2lf6F9n6Y9MuhykU5UcwcGu9
 rmU/LZhv88L53mx2yTdYzKi5Vl7EqxbRCvvHfa7If16ygzkeyr1PiQSTKr7kh+H/0KUL
 FUNRxRl8KTycvLmky+cWlSiKV5Q23lRPKpjeM6cKT3XhQ/qGnzDKnS1cLy8VFcHXqfEl
 RK6NvV6F1KYoHhsxiqbtF9sJWF9Hi7YH4lZW4COoBmdu9DwYr0FIxFH29ldQ4o4FKW4y
 EPNQ==
X-Gm-Message-State: AAQBX9cKgra2moEdpQ8ehu35nrtVaP26/R369UsFjfkrbpHcjUf+Cw5/
 v6rWS0GA0bEB13WwFPRLUAtL3JkNVbCsTg==
X-Google-Smtp-Source: AKy350YtzGRDTrzzBBy6apdmk32bYVAYELHBAnSL+HI9yvSo5Eplf+RoFsArlRUzuggcmFk6HpnuJQ==
X-Received: by 2002:a17:906:17ce:b0:94f:1:8468 with SMTP id
 u14-20020a17090617ce00b0094f00018468mr1286765eje.17.1681991879335; 
 Thu, 20 Apr 2023 04:57:59 -0700 (PDT)
Received: from able.fritz.box (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a170906645400b0095342bfb701sm689385ejn.16.2023.04.20.04.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 04:57:58 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu: abort submissions during prepare on error
Date: Thu, 20 Apr 2023 13:57:50 +0200
Message-Id: <20230420115752.31470-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420115752.31470-1-christian.koenig@amd.com>
References: <20230420115752.31470-1-christian.koenig@amd.com>
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
Cc: luben.tuikov@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Forward errors from previous submissions to this one.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 0a950c1c8782..5462f0406b02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -256,16 +256,27 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 	struct dma_fence *fence = NULL;
 	int r;
 
+	/* Ignore soft recovered fences here */
+	r = drm_sched_entity_error(s_entity);
+	if (r && r != -ENODATA)
+		goto error;
+
 	if (job->gang_submit)
 		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
 
 	while (!fence && job->vm && !job->vmid) {
 		r = amdgpu_vmid_grab(job->vm, ring, job, &fence);
-		if (r)
+		if (r) {
 			DRM_ERROR("Error getting VM ID (%d)\n", r);
+			goto error;
+		}
 	}
 
 	return fence;
+
+error:
+	dma_fence_set_error(&job->base.s_fence->finished, r);
+	return NULL;
 }
 
 static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
-- 
2.34.1

