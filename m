From: Lyude Paul <lyude@redhat.com>
Subject: [WIP PATCH 00/15] MST refcounting/atomic helpers cleanup
Date: Thu, 13 Dec 2018 20:25:29 -0500
Message-ID: <20181214012604.13746-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, David Airlie <airlied@linux.ie>, Maxime Ripard <maxime.ripard@bootlin.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Lyude Paul <lyude@redhat.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Karol Herbst <karolherbst@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Ilia Mirkin <imirkin@alum.mit.edu>
List-Id: amd-gfx.lists.freedesktop.org

This is a WIP version of the series I've been working on for a while now
to get all of the atomic DRM drivers in the tree to use the atomic MST
helpers, and to make the atomic MST helpers actually idempotent. Turns
out it's a lot more difficult to do that without also fixing how port
and branch device refcounting works so that it actually makes sense,
since the current upstream implementation requires a ton of magic in the
atomic helpers to work around properly and in many situations just plain
doesn't work as intended.

This patch series is starting to get bigger, and since there's still a
few bits here and there regarding the new refcount implementation that I
haven't quite decided on yet I figured I should get an opinion from
everyone else.

Currently I've got a couple of thoughts on how I could improve this
further:

* Get rid of drm_dp_mst_get_*_validated() entirely - I'm 90% sure that
  with the new refcounting scheme we might not actually need port
  validation at all anymore, assuming we make the use of malloc references
  in all of the DRM drivers. Either way, I don't think validation was ever
  actually a concept that worked: without malloc references, the port or
  branch device that's being passed to drm_dp_mst_get_*_validated()
  could be freed which also in turn means that that the stale pointer
  could in theory have gotten reused for a new port and thus-cause us to
  consider a freed port validated.
* Get rid of drm_dp_mst_get_vcpi_slots() - with malloc references, I
  don't think there's any use for this either
* Get rid of drm_dp_mst_reset_vcpi_slots() - I think the only time this
  function ever made sense was with port validation? Honestly, I wonder
  if we ever needed this at all...

Note: I haven't applied some of the comments from the reviews for the
series this is based off of:

drm/dp_mst: Improve VCPI helpers, use in nouveau
https://patchwork.freedesktop.org/series/51414/

This is just getting put on the ML so I can get some feedback on this.

Lyude Paul (15):
  drm/dp_mst: Remove bogus conditional in drm_dp_update_payload_part1()
  drm/dp_mst: Refactor drm_dp_update_payload_part1()
  drm/dp_mst: Introduce new refcounting scheme for mstbs and ports
  drm/dp_mst: Stop releasing VCPI when removing ports from topology
  drm/dp_mst: Fix payload deallocation on hotplugs using malloc refs
  drm/i915: Keep malloc references to MST ports
  drm/nouveau: Remove bogus cleanup in nv50_mstm_add_connector()
  drm/nouveau: Remove unnecessary VCPI checks in nv50_msto_cleanup()
  drm/nouveau: Fix potential use-after-frees for MSTCs
  drm/nouveau: Stop unsetting mstc->port, use malloc refs
  drm/nouveau: Grab payload lock in nv50_msto_payload()
  drm/dp_mst: Add some atomic state iterator macros
  drm/dp_mst: Start tracking per-port VCPI allocations
  drm/dp_mst: Check payload count in drm_dp_mst_atomic_check()
  drm/nouveau: Use atomic VCPI helpers for MST

 .../gpu/dp-mst/topology-figure-1.dot          |  31 +
 .../gpu/dp-mst/topology-figure-2.dot          |  37 +
 .../gpu/dp-mst/topology-figure-3.dot          |  40 +
 Documentation/gpu/drm-kms-helpers.rst         | 125 ++-
 drivers/gpu/drm/drm_dp_mst_topology.c         | 910 ++++++++++++++----
 drivers/gpu/drm/i915/intel_connector.c        |   4 +
 drivers/gpu/drm/i915/intel_display.c          |   4 +
 drivers/gpu/drm/i915/intel_dp_mst.c           |  66 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |  94 +-
 include/drm/drm_dp_mst_helper.h               | 139 ++-
 10 files changed, 1178 insertions(+), 272 deletions(-)
 create mode 100644 Documentation/gpu/dp-mst/topology-figure-1.dot
 create mode 100644 Documentation/gpu/dp-mst/topology-figure-2.dot
 create mode 100644 Documentation/gpu/dp-mst/topology-figure-3.dot

-- 
2.19.2
