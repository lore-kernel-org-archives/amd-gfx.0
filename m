From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm/amd/powerplay: rv: Use designated initializers
Date: Tue, 25 Jul 2017 14:47:56 -0700
Message-ID: <20170725214756.GA102262@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Hawking Zhang <Hawking.Zhang@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

As done for vega10 in commit 3ddd396f6b57 ("drm/amd/powerplay: Use
designated initializers") mark other tableFunction entries with designated
initializers. The randstruct plugin requires designated initializers for
structures that are entirely function pointers.

Cc: Rex Zhu <Rex.Zhu@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
If I can get an Ack for this, I'll carry it in the gcc-plugins tree, unless
you think this is worth landing for v4.13, in which case, please take it
now. :)

Thanks!
---
 drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
index 4c7f430b36eb..8e6cfd89c7e0 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
@@ -308,8 +308,8 @@ static int rv_tf_set_num_active_display(struct pp_hwmgr *hwmgr, void *input,
 }
 
 static const struct phm_master_table_item rv_set_power_state_list[] = {
-	{ NULL, rv_tf_set_clock_limit },
-	{ NULL, rv_tf_set_num_active_display },
+	{ .tableFunction = rv_tf_set_clock_limit },
+	{ .tableFunction = rv_tf_set_num_active_display },
 	{ }
 };
 
@@ -382,7 +382,7 @@ static int rv_tf_disable_gfx_off(struct pp_hwmgr *hwmgr,
 }
 
 static const struct phm_master_table_item rv_disable_dpm_list[] = {
-	{NULL, rv_tf_disable_gfx_off},
+	{ .tableFunction = rv_tf_disable_gfx_off },
 	{ },
 };
 
@@ -407,7 +407,7 @@ static int rv_tf_enable_gfx_off(struct pp_hwmgr *hwmgr,
 }
 
 static const struct phm_master_table_item rv_enable_dpm_list[] = {
-	{NULL, rv_tf_enable_gfx_off},
+	{ .tableFunction = rv_tf_enable_gfx_off },
 	{ },
 };
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
