Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C7FD3E77A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 20:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B7A10E6F2;
	Wed, 10 Dec 2025 20:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jqJR6CHP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0CE10E768
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 20:15:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3EB136019F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 20:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DADC4CEF1;
 Wed, 10 Dec 2025 20:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765397723;
 bh=VOCrKuJUakkBlob5LwCCKVNDNhvJt0jiK93UmRDD4NE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jqJR6CHPGVqWxMMBtxAfdAWhNHvBETdJbUJEfj+iKEKRepunZzijOA/7qX9SYgZ4i
 aqXQtCN5MlYKppjLL2KazmtAISuZMb0PLEP41radUlyeUCsd2Oo/YMpttg6A3QF3OS
 fmSVQNpOmwOMzbH+D9OQLg/0YZRtAaF86lZBd6bClw+g6t7KuaUsfKYkPqZpFXoBU4
 cbbuVJCmHRGDkCRVP9Ge+fbGcM3+DGU46IzH7C0tjUgzwNpNDPQuDAWhsXaLVqk6si
 vWKipavPD4/CVPE0VZC3FmFEFeH644RtanwoMvb4KgCxgbZwyoXhGjYKjULQ6OoYKn
 ZGEPC+ztnXwcw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 2/3] amdkfd: Don't rebuild node tree when calling
 kfd_topology_update_sysfs()
Date: Wed, 10 Dec 2025 14:15:09 -0600
Message-ID: <20251210201510.3000-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210201510.3000-1-superm1@kernel.org>
References: <20251210201510.3000-1-superm1@kernel.org>
MIME-Version: 1.0
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

There is no need to remove all the nodes and rebuild them.  The content
will be the same.  Instead check whether the node was created and skip
the creation.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a0990dd2378c1..b65f29294e2d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -650,8 +650,8 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 	uint32_t i, num_attrs;
 	struct attribute **attrs;
 
-	if (WARN_ON(dev->kobj_node))
-		return -EEXIST;
+	if (dev->kobj_node)
+		return 0;
 
 	/*
 	 * Creating the sysfs folders
@@ -888,8 +888,6 @@ static int kfd_topology_update_sysfs(void)
 			return ret;
 	}
 
-	kfd_remove_sysfs_node_tree();
-
 	return kfd_build_sysfs_node_tree();
 }
 
-- 
2.43.0

