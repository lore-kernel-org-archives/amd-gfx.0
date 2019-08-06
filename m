From: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: fix compile error about readq/writeq on arm ARCH
Date: Tue, 6 Aug 2019 18:31:56 +0800
Message-ID: <20190806103156.3778-1-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, hawking.zhang@amd.com, dennis.li@amd.com, broonie@kernel.org
Cc: Tao Zhou <tao.zhou1@amd.com>, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org
List-Id: amd-gfx.lists.freedesktop.org

readq/writeq can't be found on arm architecture, implement them
with 32 bits operations

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f62d4f30e810..aaf7f31cf8df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -29,6 +29,7 @@
 #include <linux/kthread.h>
 #include <linux/console.h>
 #include <linux/slab.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
-- 
2.17.1
