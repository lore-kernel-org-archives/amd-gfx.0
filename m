Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B554C77B6D
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Apr 2023 01:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D96410F36B;
	Sat,  1 Apr 2023 01:43:46 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7317B10F36B;
 Sat,  1 Apr 2023 01:43:43 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E2BF76240C;
 Sat,  1 Apr 2023 01:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DB2C433D2;
 Sat,  1 Apr 2023 01:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680313421;
 bh=7H5totHyxq4yVx5iYXOEPlYPqoU+uIYlMPC64nUrdwM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XtQbddcQYVSSB7Ww2/TNrj9z9NeZJttypjjwTqxhm4hCHbNTAOgqCSAaRxJzJnuqB
 8z7estf+dD3t2PWe6k9Vu9adKJLr/qty2HNAQnSlln7f6VliHU90lGF3p8uHHq37Mp
 nB0XOWGBTbvjP01/SOez/XhobyEJrn6cVZ2ePKYsj5JjDf4NGEto7BZ6jQ5SuhC17q
 S8tfvtUGHPwydu6Yk73/BRJz01Hy2SlDQF18CM19pE4YGUQEVjSc3hxGKeI3L3p1Mv
 jfz6QxmU/8kUYr7lb3Xe62L/KBfUHnEfTZtOs5froxSYHt1J5HeaGlnUNek/pINbTs
 zx/58O/YRi1MQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 22/24] drm/amdgpu: Force signal hw_fences that are
 embedded in non-sched jobs
Date: Fri, 31 Mar 2023 21:42:38 -0400
Message-Id: <20230401014242.3356780-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230401014242.3356780-1-sashal@kernel.org>
References: <20230401014242.3356780-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>, Sasha Levin <sashal@kernel.org>,
 Jack.Xiao@amd.com, andrey.grodzovsky@amd.com, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, slark_xiao@163.com, gpiccoli@igalia.com,
 Luben Tuikov <luben.tuikov@amd.com>, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>, Likun.Gao@amd.com,
 Jiadong.Zhu@amd.com, airlied@gmail.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: YuBiao Wang <YuBiao.Wang@amd.com>

[ Upstream commit 033c56474acf567a450f8bafca50e0b610f2b716 ]

[Why]
For engines not supporting soft reset, i.e. VCN, there will be a failed
ib test before mode 1 reset during asic reset. The fences in this case
are never signaled and next time when we try to free the sa_bo, kernel
will hang.

[How]
During pre_asic_reset, driver will clear job fences and afterwards the
fences' refcount will be reduced to 1. For drm_sched_jobs it will be
released in job_free_cb, and for non-sched jobs like ib_test, it's meant
to be released in sa_bo_free but only when the fences are signaled. So
we have to force signal the non_sched bad job's fence during
pre_asic_reset or the clear is not complete.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 6fdb679321d0d..3cc1929285fc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -624,6 +624,15 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
 		ptr = &ring->fence_drv.fences[i];
 		old = rcu_dereference_protected(*ptr, 1);
 		if (old && old->ops == &amdgpu_job_fence_ops) {
+			struct amdgpu_job *job;
+
+			/* For non-scheduler bad job, i.e. failed ib test, we need to signal
+			 * it right here or we won't be able to track them in fence_drv
+			 * and they will remain unsignaled during sa_bo free.
+			 */
+			job = container_of(old, struct amdgpu_job, hw_fence);
+			if (!job->base.s_fence && !dma_fence_is_signaled(old))
+				dma_fence_signal(old);
 			RCU_INIT_POINTER(*ptr, NULL);
 			dma_fence_put(old);
 		}
-- 
2.39.2

