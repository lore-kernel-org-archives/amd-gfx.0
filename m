From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/amd/display: memory leak
Date: Mon, 16 Sep 2019 22:20:44 -0500
Message-ID: <20190917032106.32342-1-navid.emamdoost@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eric Yang <Eric.Yang2@amd.com>, Jun Lei <Jun.Lei@amd.com>, David Francis <David.Francis@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Aidan Wood <Aidan.Wood@amd.com>, Ken Chalmers <ken.chalm>
List-Id: amd-gfx.lists.freedesktop.org

In dcn*_clock_source_create when dcn20_clk_src_construct fails allocated
clk_src needs release.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
 7 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 6248c8455314..21de230b303a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -667,7 +667,8 @@ struct clock_source *dce100_clock_source_create(
 		clk_src->base.dp_clk_src = dp_clk_src;
 		return &clk_src->base;
 	}
-
+
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 764329264c3b..0cb83b0e0e1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -714,6 +714,7 @@ struct clock_source *dce110_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index c6136e0ed1a4..147d77173e2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -687,6 +687,7 @@ struct clock_source *dce112_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 4a6ba3173a5a..0b5eeff17d00 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -500,6 +500,7 @@ static struct clock_source *dce120_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 860a524ebcfa..952440893fbb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -701,6 +701,7 @@ struct clock_source *dce80_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index a12530a3ab9c..3f25e8da5396 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -786,6 +786,7 @@ struct clock_source *dcn10_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b949e202d6cb..418fdcf1f492 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -955,6 +955,7 @@ struct clock_source *dcn20_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src)
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
-- 
2.17.1
