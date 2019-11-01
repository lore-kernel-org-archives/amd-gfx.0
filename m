From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
Subject: [PATCH] drivers: gpu: amdgpu: Remove @dev from
 amdgpu_gem_prime_export documentation
Date: Fri, 1 Nov 2019 21:33:12 +0530
Message-ID: <20191101160312.GA11047@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com, chris@chris-wilson.co.uk, emil.velikov@collabora.com, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

The function does not have a "dev" argument, so remove it from
the documentation. This fixes the following documentation
build warning:

./drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:335:
	warning: Excess function parameter 'dev' description in
	'amdgpu_gem_prime_export'

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 61f108ec2b5c..4917b548b7f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -321,7 +321,6 @@ const struct dma_buf_ops amdgpu_dmabuf_ops = {
 
 /**
  * amdgpu_gem_prime_export - &drm_driver.gem_prime_export implementation
- * @dev: DRM device
  * @gobj: GEM BO
  * @flags: Flags such as DRM_CLOEXEC and DRM_RDWR.
  *
-- 
2.21.0
