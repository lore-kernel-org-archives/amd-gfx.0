From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amd/powerplay: Fix missing break in switch
Date: Fri, 25 Jan 2019 15:55:33 -0600
Message-ID: <20190125215533.GA4878@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
List-Id: amd-gfx.lists.freedesktop.org

Add missing break statement in order to prevent the code from falling
through to the default case.

The resoning for this is that pclk_vol_table is an automatic variable.
So, it makes no sense to update it just before falling through to the
default case and return -EINVAL.

This bug was found thanks to the ongoing efforts to enabling
-Wimplicit-fallthrough.

Fixes: cd70f3d6e3fa ("drm/amd/powerplay: PP/DAL interface changes for dynamic clock switch")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index f95c5f50eb0f..5273de3c5b98 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1033,6 +1033,7 @@ static int smu10_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
 		break;
 	case amd_pp_dpp_clock:
 		pclk_vol_table = pinfo->vdd_dep_on_dppclk;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1
