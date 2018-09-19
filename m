From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v2 0/6] Fix legacy DPMS changes with MST
Date: Wed, 19 Sep 2018 19:08:57 -0400
Message-ID: <20180919230913.16894-1-lyude@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>, Gustavo Padovan <gustavo@padovan.org>, Thierry Reding <treding@nvidia.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Ilia Mirkin <imirkin@alum.mit.edu>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Lyude Paul <lyude@redhat.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig>
List-Id: amd-gfx.lists.freedesktop.org

There's two major things this patchset does:
 - Add drm_dp_mst_connector_atomic_check() so drivers don't need to use
   ->best_encoder() to prevent modesets on zombie MST connectors. We'll
   use this later for implementing MST fallback retraining as well.
 - Fix DPMS on->off changes failing with legacy modesetting users after
   an MST connector's topology has disappeared, which resulted in CRTCs
   being left on when they shouldn't have been

Lyude Paul (6):
  drm/dp_mst: Introduce drm_dp_mst_connector_atomic_check()
  drm/nouveau: Unbreak nv50_mstc->best_encoder()
  drm/i915: Leave intel_conn->mst_port set, use mst_port_gone instead
  drm/i915: Skip vcpi allocation for MSTB ports that are gone
  drm/i915: Fix intel_dp_mst_best_encoder()
  drm/amdgpu/dm/mst: Use drm_dp_mst_connector_atomic_check()

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 12 +++
 drivers/gpu/drm/drm_dp_mst_topology.c         | 76 +++++++++++++++++++
 drivers/gpu/drm/i915/intel_dp_mst.c           | 46 ++++++-----
 drivers/gpu/drm/i915/intel_drv.h              |  1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 25 +++---
 include/drm/drm_dp_mst_helper.h               |  3 +
 6 files changed, 132 insertions(+), 31 deletions(-)

-- 
2.17.1
