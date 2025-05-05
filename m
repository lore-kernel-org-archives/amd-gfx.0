Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79F8C3ABB6
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 23:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A7110E628;
	Mon,  5 May 2025 23:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j7KJM8xZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC7310E627;
 Mon,  5 May 2025 23:23:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D2FDF4A77B;
 Mon,  5 May 2025 23:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F522C4CEE4;
 Mon,  5 May 2025 23:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746487386;
 bh=PUoU3kFI4BLvkins4qhJssnKl2gATCFExsBo1yCK+EA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j7KJM8xZwJ/UnxXphfZgwKRAj7VVBv1ZcqSUuKBufVSRXrFOjR/4X/1SSK21WZRVj
 3K20kvqSTMr4pE23GDUtILM18Rpb9Mq+oVQPN2BffkjooCmlnK+CoASoJMd42UPc8o
 aGaJu84UUz+R6YIxY17q50dq6AZJ0TjPNkW66o6xGdqHrMmdDe8sPoh+dxR8Fr+krJ
 ng5kaYfKsLjAe/uVSUPtGRbNgvgh5sKzgbm8ip6D4oD5igB1LG/Q4L4hFtlVh7mBmO
 1wHo8AeR0ESr/vrtzbwnM2viWLxRd3faEpAPowWj4/lMgIlP3aMxMKFCfRfEIim2pW
 K8jFRkro1IWiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Felix.Kuehling@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 42/79] drm/amdkfd: KFD release_work possible
 circular locking
Date: Mon,  5 May 2025 19:21:14 -0400
Message-Id: <20250505232151.2698893-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 1b9366c601039d60546794c63fbb83ce8e53b978 ]

If waiting for gpu reset done in KFD release_work, thers is WARNING:
possible circular locking dependency detected

  #2  kfd_create_process
        kfd_process_mutex
          flush kfd release work

  #1  kfd release work
        wait for amdgpu reset work

  #0  amdgpu_device_gpu_reset
        kgd2kfd_pre_reset
          kfd_process_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&p->release_work));
                  lock((wq_completion)kfd_process_wq);
                  lock((work_completion)(&p->release_work));
   lock((wq_completion)amdgpu-reset-dev);

To fix this, KFD create process move flush release work outside
kfd_process_mutex.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 662e4d973f13a..b07deeb987475 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -277,6 +277,14 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	if (thread->group_leader->mm != thread->mm)
 		return ERR_PTR(-EINVAL);
 
+	/* If the process just called exec(3), it is possible that the
+	 * cleanup of the kfd_process (following the release of the mm
+	 * of the old process image) is still in the cleanup work queue.
+	 * Make sure to drain any job before trying to recreate any
+	 * resource for this process.
+	 */
+	flush_workqueue(kfd_process_wq);
+
 	/*
 	 * take kfd processes mutex before starting of process creation
 	 * so there won't be a case where two threads of the same process
@@ -289,14 +297,6 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
-		/* If the process just called exec(3), it is possible that the
-		 * cleanup of the kfd_process (following the release of the mm
-		 * of the old process image) is still in the cleanup work queue.
-		 * Make sure to drain any job before trying to recreate any
-		 * resource for this process.
-		 */
-		flush_workqueue(kfd_process_wq);
-
 		process = create_process(thread);
 		if (IS_ERR(process))
 			goto out;
-- 
2.39.5

