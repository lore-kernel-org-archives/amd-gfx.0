From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>
Subject: [PATCH 06/18] drm: use ARRAY_SIZE
Date: Sun,  1 Oct 2017 15:30:44 -0400
Message-ID: <20171001193101.8898-7-jeremy.lefaure@lse.epita.fr>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Using the ARRAY_SIZE macro improves the readability of the code. Also,
it is not always useful to use a variable to store this constant
calculated at compile time nor to re-invent the ARRAY_SIZE macro.

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

Signed-off-by: Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c           |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           |  9 +++++----
 drivers/gpu/drm/gma500/psb_intel_sdvo.c         |  9 ++++-----
 drivers/gpu/drm/i915/gvt/vgpu.c                 |  3 ++-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c |  7 ++++---
 drivers/gpu/drm/via/via_verifier.c              | 10 ++++------
 6 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index dfc10b1baea0..304862e2a8a6 100644
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
index deeaee1457ef..180726f4f34e 100644
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
diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
index e787d376ba67..84507912be84 100644
--- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
+++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
@@ -37,6 +37,7 @@
 #include "psb_drv.h"
 #include "psb_intel_sdvo_regs.h"
 #include "psb_intel_reg.h"
+#include <linux/kernel.h>
 
 #define SDVO_TMDS_MASK (SDVO_OUTPUT_TMDS0 | SDVO_OUTPUT_TMDS1)
 #define SDVO_RGB_MASK  (SDVO_OUTPUT_RGB0 | SDVO_OUTPUT_RGB1)
@@ -62,8 +63,6 @@ static const char *tv_format_names[] = {
 	"SECAM_60"
 };
 
-#define TV_FORMAT_NUM  (sizeof(tv_format_names) / sizeof(*tv_format_names))
-
 struct psb_intel_sdvo {
 	struct gma_encoder base;
 
@@ -148,7 +147,7 @@ struct psb_intel_sdvo_connector {
 	int force_audio;
 
 	/* This contains all current supported TV format */
-	u8 tv_format_supported[TV_FORMAT_NUM];
+	u8 tv_format_supported[ARRAY_SIZE(tv_format_names)];
 	int   format_supported_num;
 	struct drm_property *tv_format;
 
@@ -1709,7 +1708,7 @@ psb_intel_sdvo_set_property(struct drm_connector *connector,
 	}
 
 	if (property == psb_intel_sdvo_connector->tv_format) {
-		if (val >= TV_FORMAT_NUM)
+		if (val >= ARRAY_SIZE(tv_format_names))
 			return -EINVAL;
 
 		if (psb_intel_sdvo->tv_format_index ==
@@ -2269,7 +2268,7 @@ static bool psb_intel_sdvo_tv_create_property(struct psb_intel_sdvo *psb_intel_s
 		return false;
 
 	psb_intel_sdvo_connector->format_supported_num = 0;
-	for (i = 0 ; i < TV_FORMAT_NUM; i++)
+	for (i = 0 ; i < ARRAY_SIZE(tv_format_names); i++)
 		if (format_map & (1 << i))
 			psb_intel_sdvo_connector->tv_format_supported[psb_intel_sdvo_connector->format_supported_num++] = i;
 
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 02c61a1ad56a..9c6d2849c5b7 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -31,6 +31,7 @@
  *
  */
 
+#include <linux/kernel.h>
 #include "i915_drv.h"
 #include "gvt.h"
 #include "i915_pvinfo.h"
@@ -116,7 +117,7 @@ int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
 	 */
 	low_avail = gvt_aperture_sz(gvt) - HOST_LOW_GM_SIZE;
 	high_avail = gvt_hidden_sz(gvt) - HOST_HIGH_GM_SIZE;
-	num_types = sizeof(vgpu_types) / sizeof(vgpu_types[0]);
+	num_types = ARRAY_SIZE(vgpu_types);
 
 	gvt->types = kzalloc(num_types * sizeof(struct intel_vgpu_type),
 			     GFP_KERNEL);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
index b58ee99f7bfc..9cc10e438b3d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
@@ -36,6 +36,8 @@
 #include <subdev/i2c.h>
 #include <subdev/vga.h>
 
+#include <linux/kernel.h>
+
 #define bioslog(lvl, fmt, args...) do {                                        \
 	nvkm_printk(init->subdev, lvl, info, "0x%08x[%c]: "fmt,                \
 		    init->offset, init_exec(init) ?                            \
@@ -2271,8 +2273,6 @@ static struct nvbios_init_opcode {
 	[0xaa] = { init_reserved },
 };
 
-#define init_opcode_nr (sizeof(init_opcode) / sizeof(init_opcode[0]))
-
 int
 nvbios_exec(struct nvbios_init *init)
 {
@@ -2281,7 +2281,8 @@ nvbios_exec(struct nvbios_init *init)
 	init->nested++;
 	while (init->offset) {
 		u8 opcode = nvbios_rd08(bios, init->offset);
-		if (opcode >= init_opcode_nr || !init_opcode[opcode].exec) {
+		if (opcode >= ARRAY_SIZE(init_opcode) ||
+		    !init_opcode[opcode].exec) {
 			error("unknown opcode 0x%02x\n", opcode);
 			return -EINVAL;
 		}
diff --git a/drivers/gpu/drm/via/via_verifier.c b/drivers/gpu/drm/via/via_verifier.c
index 0677bbf4ec7e..fb2609434df7 100644
--- a/drivers/gpu/drm/via/via_verifier.c
+++ b/drivers/gpu/drm/via/via_verifier.c
@@ -34,6 +34,7 @@
 #include <drm/drm_legacy.h>
 #include "via_verifier.h"
 #include "via_drv.h"
+#include <linux/kernel.h>
 
 typedef enum {
 	state_command,
@@ -1102,10 +1103,7 @@ setup_hazard_table(hz_init_t init_table[], hazard_t table[], int size)
 
 void via_init_command_verifier(void)
 {
-	setup_hazard_table(init_table1, table1,
-			   sizeof(init_table1) / sizeof(hz_init_t));
-	setup_hazard_table(init_table2, table2,
-			   sizeof(init_table2) / sizeof(hz_init_t));
-	setup_hazard_table(init_table3, table3,
-			   sizeof(init_table3) / sizeof(hz_init_t));
+	setup_hazard_table(init_table1, table1, ARRAY_SIZE(init_table1));
+	setup_hazard_table(init_table2, table2, ARRAY_SIZE(init_table2));
+	setup_hazard_table(init_table3, table3, ARRAY_SIZE(init_table3));
 }
-- 
2.14.1
