From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amdgpu: fix spelling mistake: "suuport"-> "support"
Date: Mon, 24 Jul 2017 23:45:01 +0100
Message-ID: <20170724224501.17037-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Chunming Zhou <David1.Zhou@amd.com>, Jerry.Zhang@amd.com, Edward O'Callaghan <funfunctor@folklore1984.net>, Alex Xie <AlexBin.Xie@amd.com>, Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in WARN_ONCE message

Signed-off-by: Colin Ian King <colin.king@canoical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5795f81369f0..06f11e2a32af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1301,7 +1301,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_pte_update_params *params,
 
 		if (params->shadow) {
 			if (WARN_ONCE(use_cpu_update,
-				"CPU VM update doesn't suuport shadow pages"))
+				"CPU VM update doesn't support shadow pages"))
 				return 0;
 
 			if (!pt->shadow)
-- 
2.11.0
