Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5539DC7EE2E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 08:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C128F10E1FC;
	Wed,  3 May 2023 08:36:02 +0000 (UTC)
Received: from mblankhorst.nl (lankhorst.se
 [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E47789167;
 Wed,  3 May 2023 08:36:00 +0000 (UTC)
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org,
 intel-xe@lists.freedesktop.org
Subject: [RFC PATCH 0/4]  Add support for DRM cgroup memory accounting.
Date: Wed,  3 May 2023 10:34:56 +0200
Message-Id: <20230503083500.645848-1-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

RFC as I'm looking for comments.

For long running compute, it can be beneficial to partition the GPU memory
between cgroups, so each cgroup can use its maximum amount of memory without
interfering with other scheduled jobs. Done properly, this can alleviate the
need for eviction, which might result in a job being terminated if the GPU
doesn't support mid-thread preemption or recoverable page faults.

This is done by adding a bunch of knobs to cgroup:
drm.capacity: Shows maximum capacity of each resource region.
drm.max: Display or limit max amount of memory.
drm.current: Current amount of memory in use.

TTM has not been made cgroup aware yet, so instead of evicting from
the current cgroup to stay within the cgroup limits, it simply returns
the error -ENOSPC to userspace.

I've used Tvrtko's cgroup controller series as a base, but it implemented
scheduling weight, not memory accounting, so I only ended up keeping the
base patch.

Xe is not upstream yet, so the driver specific patch will only apply on
https://gitlab.freedesktop.org/drm/xe/kernel

Maarten Lankhorst (3):
  drm/cgroup: Add memory accounting to DRM cgroup
  drm/ttm: Handle -EAGAIN in ttm_resource_alloc as -ENOSPC.
  drm/xe: Add support for the drm cgroup

Tvrtko Ursulin (1):
  cgroup: Add the DRM cgroup controller

 Documentation/admin-guide/cgroup-v2.rst    |  46 ++
 Documentation/gpu/drm-compute.rst          |  54 ++
 drivers/gpu/drm/ttm/ttm_bo.c               |   4 +-
 drivers/gpu/drm/xe/xe_device.c             |   4 +
 drivers/gpu/drm/xe/xe_device_types.h       |   4 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c       |  21 +-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h |   5 +
 include/linux/cgroup_drm.h                 |  90 ++++
 include/linux/cgroup_subsys.h              |   4 +
 init/Kconfig                               |   7 +
 kernel/cgroup/Makefile                     |   1 +
 kernel/cgroup/drm.c                        | 557 +++++++++++++++++++++
 12 files changed, 794 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/gpu/drm-compute.rst
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

-- 
2.34.1

