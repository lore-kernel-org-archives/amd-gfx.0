From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 0/6] drm/amdgpu: Fix incorrect encoder API usages
Date: Thu, 26 Sep 2019 18:51:02 -0400
Message-ID: <20190926225122.31455-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@linux.ie>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Francis <david.francis@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "David (ChunMing) Zhou" <david1.zhou@amd.com>, "Jerry (Fangzhi) Zuo" <jerry.zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>, Thomas Lim <thomas.lim@amd.com>, Lyude Paul <lyude@redhat.com>, Mario Kleiner <mario.kleiner.de@gmail.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Dingchen Zhang <dingchen.zhang@amd.com>, Brajeswar Ghosh <brajeswar.linux@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@>
List-Id: amd-gfx.lists.freedesktop.org

Noticed this while trying to respin my MST suspend/resume patch series.
It's not technically possible (at least until someone moves amdgpu
away from the deprecated drm_device->driver->{load,unload} hooks) for
amdgpu to properly register all of it's encoders before registering with
userspace. However, amdgpu also apparently adds and removes encoders
along with MST connectors - which is a much bigger issue as userspace
applications definitely do not expect this type of behavior.

So, let's fix it and add some WARNs() so new drivers don't accidentally
make this mistake in the future.

Lyude Paul (6):
  drm/amdgpu/dm/mst: Don't create MST topology managers for eDP ports
  drm/amdgpu/dm/mst: Remove unnecessary NULL check
  drm/amdgpu/dm/mst: Use ->atomic_best_encoder
  drm/amdgpu/dm/mst: Make MST encoders per-CRTC and fix encoder usage
  drm/amdgpu/dm/mst: Report possible_crtcs incorrectly, for now
  drm/encoder: WARN() when adding/removing encoders after device
    registration

 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  3 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 -
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 46 ++++++++++---------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  3 ++
 drivers/gpu/drm/drm_encoder.c                 | 31 ++++++++++---
 6 files changed, 70 insertions(+), 29 deletions(-)

-- 
2.21.0
