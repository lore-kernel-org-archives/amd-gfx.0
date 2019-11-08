From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amd/display: fix dereference of pointer aconnector when it is null
Date: Fri,  8 Nov 2019 14:38:14 +0000
Message-ID: <20191108143814.118856-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Mikita Lipski <mikita.lipski@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

Currently pointer aconnector is being dereferenced by the call to
to_dm_connector_state before it is being null checked, this could
lead to a null pointer dereference.  Fix this by checking that
aconnector is null before dereferencing it.

Addresses-Coverity: ("Dereference before null check")
Fixes: 5133c6241d9c ("drm/amd/display: Add MST atomic routines")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index e3cda6984d28..72e677796a48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -193,12 +193,11 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
 	 * that blocks before commit guaranteeing that the state
 	 * is not gonna be swapped while still in use in commit tail */
 
-	dm_conn_state = to_dm_connector_state(aconnector->base.state);
-
-
 	if (!aconnector || !aconnector->mst_port)
 		return false;
 
+	dm_conn_state = to_dm_connector_state(aconnector->base.state);
+
 	mst_mgr = &aconnector->mst_port->mst_mgr;
 
 	if (!mst_mgr->mst_state)
-- 
2.20.1
