Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED82CC7EE22
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 08:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C3610E233;
	Wed,  3 May 2023 08:36:11 +0000 (UTC)
Received: from mblankhorst.nl (lankhorst.se
 [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B7C10E21F;
 Wed,  3 May 2023 08:36:08 +0000 (UTC)
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
 intel-xe@lists.freedesktop.org
Subject: [RFC PATCH 3/4] drm/ttm: Handle -EAGAIN in ttm_resource_alloc as
 -ENOSPC.
Date: Wed,  3 May 2023 10:34:59 +0200
Message-Id: <20230503083500.645848-4-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
References: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Maxime Ripard <mripard@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 David Airlie <airlied@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This allows the drm cgroup controller to return no space is available..

XXX: This is a hopeless simplification that changes behavior, and
returns -ENOSPC even if we could evict ourselves from the current
cgroup.

Ideally, the eviction code becomes cgroup aware, and will force eviction
from the current cgroup or its parents.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bd5dae4d1624..e057d5d8f09a 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -731,6 +731,8 @@ static int ttm_bo_mem_force_space(struct ttm_buffer_object *bo,
 		ret = ttm_resource_alloc(bo, place, mem);
 		if (likely(!ret))
 			break;
+		if (ret == -EAGAIN)
+			return -ENOSPC;
 		if (unlikely(ret != -ENOSPC))
 			return ret;
 		ret = ttm_mem_evict_first(bdev, man, place, ctx,
@@ -783,7 +785,7 @@ int ttm_bo_mem_space(struct ttm_buffer_object *bo,
 
 		type_found = true;
 		ret = ttm_resource_alloc(bo, place, mem);
-		if (ret == -ENOSPC)
+		if (ret == -ENOSPC || ret == -EAGAIN)
 			continue;
 		if (unlikely(ret))
 			goto error;
-- 
2.34.1

