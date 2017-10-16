From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>
Subject: [PATCH] drm/amdgpu: use ARRAY_SIZE
Date: Sun, 15 Oct 2017 22:29:23 -0400
Message-ID: <20171016022924.18772-1-jeremy.lefaure@lse.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: Thierry Reding <treding@nvidia.com>, =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Using the ARRAY_SIZE macro improves the readability of the code.

Found with Coccinelle with the following semantic patch:
@r depends on (org || report)@
type T;
T[] E;
position p;
@@
(
 (sizeof(E)@p /sizeof(*E))
|
 (sizeof(E)@p /sizeof(E[...]))
|
 (sizeof(E)@p /sizeof(T))
)

Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>
---
This patch was part of a bigger patch [1] reviewed by Thierry Reding
before it was split in several patches.

[1]: https://patchwork.kernel.org/patch/9979843/

 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 147e92b3a959..c9f542b4e05c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -20,6 +20,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <linux/kernel.h>
 #include <linux/firmware.h>
 #include <drm/drmP.h>
 #include "amdgpu.h"
@@ -3952,10 +3953,10 @@ static int gfx_v8_0_init_save_restore_list(struct amdgpu_device *adev)
 				adev->gfx.rlc.reg_list_format_size_bytes >> 2,
 				unique_indices,
 				&indices_count,
-				sizeof(unique_indices) / sizeof(int),
+				ARRAY_SIZE(unique_indices),
 				indirect_start_offsets,
 				&offset_count,
-				sizeof(indirect_start_offsets)/sizeof(int));
+				ARRAY_SIZE(indirect_start_offsets));
 
 	/* save and restore list */
 	WREG32_FIELD(RLC_SRM_CNTL, AUTO_INCR_ADDR, 1);
@@ -3977,14 +3978,14 @@ static int gfx_v8_0_init_save_restore_list(struct amdgpu_device *adev)
 	/* starting offsets starts */
 	WREG32(mmRLC_GPM_SCRATCH_ADDR,
 		adev->gfx.rlc.starting_offsets_start);
-	for (i = 0; i < sizeof(indirect_start_offsets)/sizeof(int); i++)
+	for (i = 0; i < ARRAY_SIZE(indirect_start_offsets); i++)
 		WREG32(mmRLC_GPM_SCRATCH_DATA,
 				indirect_start_offsets[i]);
 
 	/* unique indices */
 	temp = mmRLC_SRM_INDEX_CNTL_ADDR_0;
 	data = mmRLC_SRM_INDEX_CNTL_DATA_0;
-	for (i = 0; i < sizeof(unique_indices) / sizeof(int); i++) {
+	for (i = 0; i < ARRAY_SIZE(unique_indices); i++) {
 		if (unique_indices[i] != 0) {
 			WREG32(temp + i, unique_indices[i] & 0x3FFFF);
 			WREG32(data + i, unique_indices[i] >> 20);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 99a5b3b92e8e..7f15bb2c5233 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -20,6 +20,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <linux/kernel.h>
 #include <linux/firmware.h>
 #include <drm/drmP.h>
 #include "amdgpu.h"
@@ -1730,10 +1731,10 @@ static int gfx_v9_0_init_rlc_save_restore_list(struct amdgpu_device *adev)
 				adev->gfx.rlc.reg_list_format_size_bytes >> 2,
 				unique_indirect_regs,
 				&unique_indirect_reg_count,
-				sizeof(unique_indirect_regs)/sizeof(int),
+				ARRAY_SIZE(unique_indirect_regs),
 				indirect_start_offsets,
 				&indirect_start_offsets_count,
-				sizeof(indirect_start_offsets)/sizeof(int));
+				ARRAY_SIZE(indirect_start_offsets));
 
 	/* enable auto inc in case it is disabled */
 	tmp = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_CNTL));
@@ -1770,12 +1771,12 @@ static int gfx_v9_0_init_rlc_save_restore_list(struct amdgpu_device *adev)
 	/* write the starting offsets to RLC scratch ram */
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_SCRATCH_ADDR),
 		adev->gfx.rlc.starting_offsets_start);
-	for (i = 0; i < sizeof(indirect_start_offsets)/sizeof(int); i++)
+	for (i = 0; i < ARRAY_SIZE(indirect_start_offsets); i++)
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_SCRATCH_DATA),
 			indirect_start_offsets[i]);
 
 	/* load unique indirect regs*/
-	for (i = 0; i < sizeof(unique_indirect_regs)/sizeof(int); i++) {
+	for (i = 0; i < ARRAY_SIZE(unique_indirect_regs); i++) {
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_INDEX_CNTL_ADDR_0) + i,
 			unique_indirect_regs[i] & 0x3FFFF);
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_INDEX_CNTL_DATA_0) + i,
-- 
2.14.2
