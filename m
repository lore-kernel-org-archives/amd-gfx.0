Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EEFC88E6F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1FD710E3CA;
	Mon, 26 Jan 2026 08:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="f2CdZlU3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE91F10E36A
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769357278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=pehOQwRLVUnKwmfNDz7t+7CRyqZIDgEsusANGj0Uc5c=;
 b=f2CdZlU3m9k9V78eLZpM9AvbXtA9UrxLMfxm+JY0KlkdXJl9tlHl6z7s0vzavmPeBLZin0
 vtWXPCW0jH9hxrIPVm9COzp7F9YJxSRMsB6DQjPS0zDk6UUlCaBCSwdzN5hi8oRO8jTf6Y
 YPTAS27k72Z7ld270E6asQXG+CrlAlc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-EJ_A6oNuP3CBRjhniGKd5Q-1; Sun,
 25 Jan 2026 11:07:53 -0500
X-MC-Unique: EJ_A6oNuP3CBRjhniGKd5Q-1
X-Mimecast-MFC-AGG-ID: EJ_A6oNuP3CBRjhniGKd5Q_1769357271
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFD5118003FC; Sun, 25 Jan 2026 16:07:51 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP
 id D1A1B1955F66; Sun, 25 Jan 2026 16:07:45 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Sun, 25 Jan 2026 17:07:51 +0100 (CET)
Date: Sun, 25 Jan 2026 17:07:44 +0100
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
Subject: [PATCH v2 5/7] drm/pan*: don't abuse current->group_leader
Message-ID: <aXY_0MrQBZWKbbmA@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXY_h8i78n6yD9JY@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Cleanup and preparation to simplify the next changes.

Use current->tgid instead of current->group_leader->pid.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
Acked-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
 drivers/gpu/drm/panthor/panthor_gem.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 8041b65c6609..1ff1f2c8b726 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -17,7 +17,7 @@
 static void panfrost_gem_debugfs_bo_add(struct panfrost_device *pfdev,
 					struct panfrost_gem_object *bo)
 {
-	bo->debugfs.creator.tgid = current->group_leader->pid;
+	bo->debugfs.creator.tgid = current->tgid;
 	get_task_comm(bo->debugfs.creator.process_name, current->group_leader);
 
 	mutex_lock(&pfdev->debugfs.gems_lock);
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index fbde78db270a..29cc57efc4b9 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -27,7 +27,7 @@ static void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo)
 	struct panthor_device *ptdev = container_of(bo->base.base.dev,
 						    struct panthor_device, base);
 
-	bo->debugfs.creator.tgid = current->group_leader->pid;
+	bo->debugfs.creator.tgid = current->tgid;
 	get_task_comm(bo->debugfs.creator.process_name, current->group_leader);
 
 	mutex_lock(&ptdev->gems.lock);
-- 
2.52.0

