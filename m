From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amdgpu: Uninitialized variable in
 amdgpu_ttm_backend_bind()
Date: Wed, 9 Aug 2017 13:30:46 +0300
Message-ID: <20170809103046.mhj7mhe3qwy5ozvy@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Flora Cui <Flora.Cui@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

My static checker complains that it's possible for "r" to be
uninitialized.  It used to be set to zero so this returns it to the old
behavior.

Fixes: 98a7f88ce9a9 ("drm/amdgpu: bind BOs with GTT space allocated directly v2")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e6f9a54c959d..b5f2a08757d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -753,7 +753,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_tt *ttm,
 				   struct ttm_mem_reg *bo_mem)
 {
 	struct amdgpu_ttm_tt *gtt = (void*)ttm;
-	int r;
+	int r = 0;
 
 	if (gtt->userptr) {
 		r = amdgpu_ttm_tt_pin_userptr(ttm);
