From: Helen Koike <helen.koike@collabora.com>
Subject: [PATCH v2 0/5] drm: Fix fb changes for async updates
Date: Mon, 11 Mar 2019 23:21:58 -0300
Message-ID: <20190312022204.2775-1-helen.koike@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com
Cc: andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, boris.brezillon@collabora.com, David Airlie <airlied@linux.ie>, Sean Paul <seanpaul@google.com>, kernel@collabora.com, harry.wentland@amd.com, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>, Helen Koike <helen.koike@collabora.com>, Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>, Russell King <rmk+kernel@armlinux.org.uk>, eric@anholt.net, Alex Deucher <alexander.deucher@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Anthony Koo <Anthony.Koo@amd.com>, amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@li>
List-Id: amd-gfx.lists.freedesktop.org

Hello,

This series fixes the slow down in performance introduced by
"[PATCH v2] drm: Block fb changes for async plane updates" where async update
falls back to a sync update, causing igt failures of type:

    "CRITICAL: completed 97 cursor updated in a period of 30 flips, we
    expect to complete approximately 15360 updates, with the threshold set
    at 7680"

Please read the commit message of "drm: don't block fb changes for async
plane updates" to understand how it works.

I tested on the rockchip, on i915 and on vc4 with igt plane_cursor_legacy and
kms_cursor_legacy and I didn't see any regressions.

I couldn't test on MSM and AMD because I don't have the hardware
I would appreciate if anyone could help me testing those.

v1 link: https://patchwork.kernel.org/cover/10837847/

Thanks!
Helen

Changes in v2:
- added reviewed-by tag
- update CC stable and Fixes tag
- Added reviewed-by tag
- updated CC stable and Fixes tag
- Change the order of the patch in the series, add this as the last one.
- Add documentation
- s/ballanced/balanced

Helen Koike (5):
  drm/rockchip: fix fb references in async update
  drm/amd: fix fb references in async update
  drm/msm: fix fb references in async update
  drm/vc4: fix fb references in async update
  drm: don't block fb changes for async plane updates

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 drivers/gpu/drm/drm_atomic_helper.c           | 20 ++++-----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    |  4 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   | 42 +++++++++++--------
 drivers/gpu/drm/vc4/vc4_plane.c               |  2 +-
 include/drm/drm_modeset_helper_vtables.h      |  5 +++
 6 files changed, 45 insertions(+), 31 deletions(-)

-- 
2.20.1
