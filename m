From: Helen Koike <helen.koike@collabora.com>
Subject: [PATCH v3 0/4] async vs amend - UAPI
Date: Fri, 12 Apr 2019 09:58:23 -0300
Message-ID: <20190412125827.5877-1-helen.koike@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>
Cc: dnicoara@chromium.org, daniels@collabora.com, alexandros.frantzis@collabora.com, daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org, tomasz Figa <tfiga@chromium.org>, tina.zhang@intel.com, boris.brezillon@collabora.com, Sean Paul <seanpaul@google.com>, kernel@collabora.com, nicholas.kazlauskas@amd.com, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Helen Koike <helen.koike@collabora.com>, Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>, linux-doc@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, Alex Deucher <alexander.deucher@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Anthony Koo <Anthon>
List-Id: amd-gfx.lists.freedesktop.org


Hi,

This patch series is an attempt to clarify some concepts and how things
are hooked inside drm.

There are two main concepts that are similar but different and are
causing some confusion:

    - Asynchronous update: is the ability change the hw state at any time, not
    only during vblank.

    - Amend update: is the ability to perform 1000 commits to be applied as soon
    as possible without waiting for 1000 vblanks.

async updates can be seen as amend, but the opposite is not true.
Please see documentation on the commit
	"drm/atomic: rename async_{update,check} to amend_{update,check}"
for a more detailed explanation.

To perform an async update, we already have the DRM_MODE_PAGE_FLIP_ASYNC
flag in the atomic API and it is already being used by amdgpu in the
atomic path.

The first two commits clarifies these differences. The last two are
RFCs that exposes new async and amend features to userspace.

We introduce in this series the flag DRM_MODE_ATOMIC_AMEND to expose
the amend feature to userspace.
The main reasons to expose this through atomic api is to avoid mixing legacy
with modern/atomic API (since their interactions are not well defined)
and to be able to explicitly manage the cursor plane.

And the last commit hooks the current async implementations with the
DRM_MODE_PAGE_FLIP_ASYNC flag.

Please, see the message in each commit and the documentation that was
added for more details and let me know what you think.

Thanks
Helen

Changes in v3:
- rebase tree
- rebase on top of renaming async_update to amend_update
- improve documentation
- don't fall back to a normal commit if amend is not possible when
requested through the atomic api

Changes in v2:
- rebase tree
- do not fall back to a non-async update if if there isn't any
pending commit to amend

Changes in v1:
- https://patchwork.freedesktop.org/patch/243088/
- Only enable it if userspace requests it.
- Only allow async update for cursor type planes.
- Rename ASYNC_UPDATE for ATOMIC_AMEND.

Helen Koike (4):
  drm/uapi: add documentation for atomic flags
  drm/atomic: rename async_{update,check} to amend_{update,check}
  drm/atomic: add ATOMIC_AMEND flag to the Atomic IOCTL.
  drm/atomic: hook atomic_async_{check,update} with PAGE_FLIP_ASYNC flag

 Documentation/gpu/drm-kms-helpers.rst         |   8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  15 +-
 drivers/gpu/drm/drm_atomic_helper.c           | 157 ++++++++++++++----
 drivers/gpu/drm/drm_atomic_uapi.c             |   9 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    |   6 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  12 +-
 drivers/gpu/drm/vc4/vc4_kms.c                 |   4 +-
 drivers/gpu/drm/vc4/vc4_plane.c               |   6 +
 include/drm/drm_atomic.h                      |   4 +-
 include/drm/drm_atomic_helper.h               |   9 +-
 include/drm/drm_modeset_helper_vtables.h      |  69 ++++++--
 include/uapi/drm/drm_mode.h                   |  27 ++-
 12 files changed, 264 insertions(+), 62 deletions(-)

-- 
2.20.1
