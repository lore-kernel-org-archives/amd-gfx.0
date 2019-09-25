From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/amd/display: prevent memory leak
Date: Tue, 24 Sep 2019 23:23:56 -0500
Message-ID: <20190925042407.31383-1-navid.emamdoost@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eric Yang <Eric.Yang2@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>, David Francis <David.Francis@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Aidan Wood <Aidan.Wood@amd.com>, Ken Chalmers <ken.chalm>
List-Id: amd-gfx.lists.freedesktop.org

In dcn*_create_resource_pool the allocated memory should be released if
construct pool fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index afc61055eca1..1787b9bf800a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -1091,6 +1091,7 @@ struct resource_pool *dce100_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index c66fe170e1e8..318e9c2e2ca8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -1462,6 +1462,7 @@ struct resource_pool *dce110_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool, asic_id))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 3ac4c7e73050..3199d493d13b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -1338,6 +1338,7 @@ struct resource_pool *dce112_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 7d08154e9662..bb497f43f6eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -1203,6 +1203,7 @@ struct resource_pool *dce120_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 5a89e462e7cc..59305e411a66 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1570,6 +1570,7 @@ struct resource_pool *dcn10_create_resource_pool(
 	if (construct(init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
-- 
2.17.1
