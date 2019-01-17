From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH v2] drm: radeon: add a missing break in evergreen_cs_handle_reg
Date: Thu, 17 Jan 2019 21:40:47 +0100
Message-ID: <20190117204047.1262-1-malat@debian.org>
References: <20190114202652.15204-1-malat@debian.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114202652.15204-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Mathieu Malaterre <malat@debian.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

In commit dd220a00e8bd ("drm/radeon/kms: add support for streamout v7")
case statements were added without a terminating break statement. This
commit adds the missing break. This was discovered during a compilation
with W=1.

This commit removes the following warning:

  drivers/gpu/drm/radeon/evergreen_cs.c:1301:11: warning: this statement may fall through [-Wimplicit-fallthrough=]

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Fixes: dd220a00e8bd ("drm/radeon/kms: add support for streamout v7")
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Add missing break statement, instead of marking it as fall through

 drivers/gpu/drm/radeon/evergreen_cs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index f471537c852f..1e14c6921454 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -1299,6 +1299,7 @@ static int evergreen_cs_handle_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
 			return -EINVAL;
 		}
 		ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
+		break;
 	case CB_TARGET_MASK:
 		track->cb_target_mask = radeon_get_ib_value(p, idx);
 		track->cb_dirty = true;
-- 
2.19.2
