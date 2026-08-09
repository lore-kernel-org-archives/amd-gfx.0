Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9512DC5B56D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 221A510E6A5;
	Mon, 10 Aug 2026 06:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vby2HHiU";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB1D10E11E
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 08:52:06 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so904934a91.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Aug 2026 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265526; x=1786870326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c/m4TAD904Gpx4jOO1f1keOOyQGwoQabIUB++Z17kjo=;
 b=Vby2HHiUSTa0dlvG7FaLi5H5IXH7AfPzr/dSjYLSdWUFxufhBztSfQ/t1F45eVEG53
 AjrpOumeYpruhzOUVzMBwm9aF6Y+lVPDzGN7VkihsbyJq/BCemWGrRMUisTyfSJApr9a
 NdPI4E7YB6EUDTT20hT1msD9K0I4L9fHzr9KCx6vGVSiOUsfWNcZFV+V4rr7Q7yA0Lcs
 AeJa+FSpM8OezbYGv1gRDVUtOmtSLsbTXBdIEoNjSNxpBGf5T5Vv9JPGXabp+ieVeLMf
 b5+np4SQYU6TW27OswGI2EAHZ5makFEriDUBUt2MSsV3/iwOZKXbAUYlNdrx7Pyx5RpX
 N2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265526; x=1786870326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c/m4TAD904Gpx4jOO1f1keOOyQGwoQabIUB++Z17kjo=;
 b=ihI7OcwqKlzhDq3+NmqgprthTi2uH+sY2AvuLBEFdTWHLAdHYvu+fs5CZuZIRyUtMF
 pg3sidllt22QuLOrHCrpJOaw7i8XKdj1nUzYCOtwAlcICeHl3K6AktqoUnt8Gqk+B5rW
 Qmwsuwj4Fm6FHruokG5DkOL9mRkW+cAcM7ZFIcsiqYkuxb7cltY3C+ok50rUU6Vx+NX6
 RvtB0v46uk2qp/iu0QFPGEbzU/8ebDAFIBm+SVEeLkBAqUtUERvoJemh4n1YeHnAdkED
 jT87iK++1heTzfstOVVyUnIh2xnJUkQ+Xbkhfm7ssF2XjdSUDWNGTVAk3cbJdQRRknpT
 nLWw==
X-Gm-Message-State: AOJu0YyibuaJsb5aqM3JpBpI15RJBJf+YO+Rpel3ohe/WfzSYiJ/oKLS
 jfiNT+4O8J5qKnVNaSgHWZArKo1RS8DYJ7SpjNSTIMCwjAM61FD4aJLo
X-Gm-Gg: AR+sD12eKYHeCilOdLHi3CgdVtmLQEx6sIg46ZU6HOoZ3cQhikyQHOvYdDRbMnFCD4Y
 r/ZuSQrDlJ1zle/WOoZWIMtpqH8mo7vgOL+aSyMLKQbLM6zMtChw1GeFNPxLQxvRmAm1Mzv3bbr
 SZWeCcV7hkAC9gPkcSmKQNqKXirTB5peH4vJ1ZxPDS5/Vc1Ym47I1xrQbj1bIGG3XL8NimgLvAi
 zH8wBm9V7G8zxpAOl21nTJcJtXX8CSTUElHefdnwA7/iJEnN++19im/hHWcvzrv2V1qStPEMsta
 PHcYiFgNb911dSpm88MjHgaR8pgo1WykgDEDBGCqhQ69bvjwb25KWfGmQqdqGa9mvIEU+W2WihL
 UhlOLa7rMoVhsXYFed4+1UhXAvPuY6UwKC3HxixL+HZoV+TeNA01Fo2AcSYxSJekVUHGwKY5ytA
 K18YUCHmQdYMY+4X4bpG+wQMlPj/EdLNnvm/KKSkGw/gNmDwa97+8DwRlDT72oxm9OjCcLDzLzM
 vXnLYRSAzU=
X-Received: by 2002:a05:6a20:a111:b0:3bf:7eb5:9459 with SMTP id
 adf61e73a8af0-3cb85ef9202mr36500133637.20.1786265525696; 
 Sun, 09 Aug 2026 01:52:05 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:52:05 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 6/6] drm/amdgpu/ras: Fix delayed work cancellation order
 during teardown
Date: Sun,  9 Aug 2026 08:47:35 +0000
Message-ID: <20260809084735.9743-7-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

In amdgpu_ras_fini(), cancel_delayed_work_sync() is currently called
after ACA subsystems and locks are destroyed. Similarly, in
amdgpu_ras_recovery_fini(), mutex_destroy(&con->page_rsv_lock) is
called before cancel_delayed_work_sync(&con->page_retirement_dwork).

If delayed work runs while teardown is in progress, it can attempt
to acquire destroyed mutexes, leading to locking violations and
potential use-after-free conditions.

Fix this by moving cancel_delayed_work_sync() and cancel_work_sync()
prior to mutex destruction and subsystem teardown in both functions,
ensuring all pending work is synchronously canceled while locks
remain intact.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 764cd4950408..23b9844d9f1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3994,15 +3994,14 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 	if (con->page_retirement_thread)
 		kthread_stop(con->page_retirement_thread);
 
+	cancel_work_sync(&con->recovery_work);
+	cancel_delayed_work_sync(&con->page_retirement_dwork);
+
 	atomic_set(&con->page_retirement_req_cnt, 0);
 	atomic_set(&con->poison_creation_count, 0);
 
 	mutex_destroy(&con->page_rsv_lock);
 
-	cancel_work_sync(&con->recovery_work);
-
-	cancel_delayed_work_sync(&con->page_retirement_dwork);
-
 	amdgpu_ras_ecc_log_fini(&con->umc_ecc_log);
 
 	mutex_lock(&con->recovery_lock);
@@ -4751,6 +4750,8 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	if (!adev->ras_enabled || !con)
 		return 0;
 
+	cancel_delayed_work_sync(&con->ras_counte_delay_work);
+
 	amdgpu_ras_critical_region_fini(adev);
 	mutex_destroy(&con->critical_region_lock);
 
@@ -4785,8 +4786,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	if (AMDGPU_RAS_GET_FEATURES(con->features))
 		amdgpu_ras_disable_all_features(adev, 0);
 
-	cancel_delayed_work_sync(&con->ras_counte_delay_work);
-
 	amdgpu_ras_set_context(adev, NULL);
 	kfree(con);
 
-- 
2.54.0

