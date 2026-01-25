Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30555C88E71
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC5B10E3DB;
	Mon, 26 Jan 2026 08:09:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Zzxs8gHF";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A659410E06B
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769357205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6XHVeVhJgsFiFSaz4pxwz0WF8NA7U9e0c68zypE8Q6g=;
 b=Zzxs8gHFoJgFTimprGxlocrDzFlW2yf8dc9dwzHn0Ql4AirrE/R0mJN4ry7z5NclGRzCye
 65TqcmO8XfVDZSYtDXBqVAVBU0ek/iiFz2a43KBrGIEEuepu30W7Mz/M6QnxZ3udLaMttw
 7iCJpxh05U6xbfs9Q9lu2mA0A3wxG1w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-IolnCAo-OX6IbJfKHl6ZvQ-1; Sun,
 25 Jan 2026 11:06:41 -0500
X-MC-Unique: IolnCAo-OX6IbJfKHl6ZvQ-1
X-Mimecast-MFC-AGG-ID: IolnCAo-OX6IbJfKHl6ZvQ_1769357199
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05828195608D; Sun, 25 Jan 2026 16:06:39 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP
 id 1F3C330001A7; Sun, 25 Jan 2026 16:06:32 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Sun, 25 Jan 2026 17:06:38 +0100 (CET)
Date: Sun, 25 Jan 2026 17:06:31 +0100
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
Subject: [PATCH v2 0/7] don't abuse task_struct.group_leader
Message-ID: <aXY_h8i78n6yD9JY@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Andrew, can you take these simple cleanups?

The patches do not depend on each other, this series just removes
the usage of ->group_leader when it is "obviously unnecessary".

I am going to move ->group_leader from task_struct to signal_struct
or at least add the new task_group_leader() helper. So I will send
more tree-wide changes on top of this series.

Link to V1: https://lore.kernel.org/all/aTV1KYdcDGvjXHos@redhat.com/

V2 doesn't differ, I only added the acks I got (thanks!).

7/7 was not reviewed, but looks really trivial.

Oleg.
---

 drivers/android/binder.c                         |  9 ++++-----
 drivers/android/binder_alloc.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  5 +----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 10 ----------
 drivers/gpu/drm/panfrost/panfrost_gem.c          |  2 +-
 drivers/gpu/drm/panthor/panthor_gem.c            |  2 +-
 drivers/infiniband/core/umem_odp.c               |  4 ++--
 net/core/netclassid_cgroup.c                     |  2 +-
 9 files changed, 12 insertions(+), 26 deletions(-)

