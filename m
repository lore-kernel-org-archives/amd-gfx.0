Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B80C88E6B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DAED10E3D6;
	Mon, 26 Jan 2026 08:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FV0NObKJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052A210E36A
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769357271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=HX7g4ZyLO3QeN4rHwQXwu4GirpPKoFXznz/m5O/wqpg=;
 b=FV0NObKJnN+AoPnAJ2lOx2WgFZSfPpEbnFPbJnWAptrKOgY0FNOOdJDdorHN90+VN3ZqRm
 2h0WmY0ePGBsu3pi2gHF9Xj7RzS9aeNN0Z14M/g2/pQiI698lmOzGvhTeh6xvhTM9GF7rq
 FigC8ymkDbg5O1blWvD6F2C28HAVtIk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-8vLhMG4tMRe8EuN-kyIaCA-1; Sun,
 25 Jan 2026 11:07:46 -0500
X-MC-Unique: 8vLhMG4tMRe8EuN-kyIaCA-1
X-Mimecast-MFC-AGG-ID: 8vLhMG4tMRe8EuN-kyIaCA_1769357264
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B313A195608D; Sun, 25 Jan 2026 16:07:43 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP
 id EDD351800665; Sun, 25 Jan 2026 16:07:37 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Sun, 25 Jan 2026 17:07:43 +0100 (CET)
Date: Sun, 25 Jan 2026 17:07:36 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Leon Romanovsky <leon@kernel.org>,
 Steven Price <steven.price@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 4/7] drm/amd: kill the outdated "Only the pthreads
 threading model is supported" checks
Message-ID: <aXY_yLVHd63UlWtm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXY_h8i78n6yD9JY@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mailman-Approved-At: Mon, 26 Jan 2026 08:09:08 +0000
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

Nowaday task->group_leader->mm != task->mm is only possible if
a) task is not a group leader and b) task->group_leader->mm == NULL
because task->group_leader has already exited using sys_exit().

I don't think that drm/amd tries to detect/nack this case.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  3 ---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a0f8ba382b9e..e44f158a11f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2551,9 +2551,6 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 	vm->task_info->task.pid = current->pid;
 	get_task_comm(vm->task_info->task.comm, current);
 
-	if (current->group_leader->mm != current->mm)
-		return;
-
 	vm->task_info->tgid = current->tgid;
 	get_task_comm(vm->task_info->process_name, current->group_leader);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a085faac9fe1..f8ef18a3aa71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -833,12 +833,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	if (!(thread->mm && mmget_not_zero(thread->mm)))
 		return ERR_PTR(-EINVAL);
 
-	/* Only the pthreads threading model is supported. */
-	if (thread->group_leader->mm != thread->mm) {
-		mmput(thread->mm);
-		return ERR_PTR(-EINVAL);
-	}
-
 	/* If the process just called exec(3), it is possible that the
 	 * cleanup of the kfd_process (following the release of the mm
 	 * of the old process image) is still in the cleanup work queue.
@@ -918,10 +912,6 @@ struct kfd_process *kfd_get_process(const struct task_struct *thread)
 	if (!thread->mm)
 		return ERR_PTR(-EINVAL);
 
-	/* Only the pthreads threading model is supported. */
-	if (thread->group_leader->mm != thread->mm)
-		return ERR_PTR(-EINVAL);
-
 	process = find_process(thread, false);
 	if (!process)
 		return ERR_PTR(-EINVAL);
-- 
2.52.0

