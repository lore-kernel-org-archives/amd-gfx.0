Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12309CF9C74
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 09:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15D310E6A0;
	Tue, 24 Sep 2024 09:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="E+cJTeJ/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D8610E6A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ilELQIOmlBTWcFmZloJw0lZvjZOiTfcxYVEUCcR6Fog=; b=E+cJTeJ/RCKT7FxEbeJU/tIGSb
 igKtvWNG0lufP3vZ++tsOLQfebhIz2T/aydk+8rj2s2UD6rc/j40eKm1l8F0TfJuOHqpAeqZWaJzq
 7DCIv4ILqBSkQVu8jRzcEMUzuVx2Hii+BjNvU0YStAsi66XfFvaVClXV8Yzf0hieBuwpnEs9l0bEP
 jthsrlGS5t/1Jb9D9kJSTnCQu5RjcKRvx7u4v/iroOt5hqLrg7uwt0iFxD8cuZ0cx8cEZQwCsPzXS
 xfuqIgjruNBJHfrAKdeyvZJmgLE+mk69zgwQX9SUoif8KOYrli4Vbfg1A67TsKw4aSTdUtL5ypU34
 c9Pr6s3g==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1st2D5-000KQg-DT; Tue, 24 Sep 2024 11:51:55 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Remove the while loop from
 amdgpu_job_prepare_job
Date: Tue, 24 Sep 2024 10:51:45 +0100
Message-ID: <20240924095145.2281-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240924095145.2281-1-tursulin@igalia.com>
References: <20240924095145.2281-1-tursulin@igalia.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

While loop makes it sound like amdgpu_vmid_grab() potentially needs to be
called multiple times to produce a fence, while in reality all code paths
either return an error, assign a valid job->vmid or assign a vmid which
will be valid once the returned fence signals.

Therefore we can remove the loop to make it clear the call does not need
to be repeated.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
---
I stared for a good while, going back and forth, and couldn't see that the
while loop is needed. But maybe I missed something?
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index d11cb0ad8c49..85f10b59d09c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -356,7 +356,7 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 	if (job->gang_submit)
 		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
 
-	while (!fence && job->vm && !job->vmid) {
+	if (!fence && job->vm && !job->vmid) {
 		r = amdgpu_vmid_grab(job->vm, ring, job, &fence);
 		if (r) {
 			dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);
-- 
2.46.0

