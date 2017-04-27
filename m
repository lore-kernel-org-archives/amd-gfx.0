From: "Panariti, David" <David.Panariti-5C7GfCeVMHo@public.gmane.org>
Subject: CZ EDC param and support
Date: Thu, 27 Apr 2017 22:13:22 +0000
Message-ID: <BN6PR12MB1889CED9632BAE0144E8AE1795100@BN6PR12MB1889.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_BN6PR12MB1889CED9632BAE0144E8AE1795100BN6PR12MB1889namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: gpudriverdevsupport <gpudriverdevsupport-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--_004_BN6PR12MB1889CED9632BAE0144E8AE1795100BN6PR12MB1889namp_
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1889CED9632BAE0144E8AE1795100BN6PR12MB1889namp_"

--_000_BN6PR12MB1889CED9632BAE0144E8AE1795100BN6PR12MB1889namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The changes in the workarounds function use DRM_INFO rather than DRM_DEBUG =
because CZs with EDC are often used in embedded environments and any info c=
an be useful especially in the case of an intermittent problem.

>From e1ce383592c275b58ad95bd80b5479af8c1f9dae Mon Sep 17 00:00:00 2001
From: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 14 Apr 2017 13:41:52 -0400
Subject: [PATCH 1/3] drm/amdgpu: Moved gfx_v8_0_select_se_sh() in lieu of
re-redundant prototype.

Will be needed for the rest of the EDC workarounds patch.

Change-Id: Ie586ab38a69e98a91c6cb5747e285ce8bfdd1c86
Signed-off-by: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
---
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 46 +++++++++++++++++---------------=
---
1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 2ff5f19..27b57cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1500,6 +1500,29 @@ static int gfx_v8_0_kiq_init(struct amdgpu_device *a=
dev)
               return 0;
}
+static void gfx_v8_0_select_se_sh(struct amdgpu_device *adev,
+                                                               u32 se_num,=
 u32 sh_num, u32 instance)
+{
+             u32 data;
+
+             if (instance =3D=3D 0xffffffff)
+                             data =3D REG_SET_FIELD(0, GRBM_GFX_INDEX, INS=
TANCE_BROADCAST_WRITES, 1);
+             else
+                             data =3D REG_SET_FIELD(0, GRBM_GFX_INDEX, INS=
TANCE_INDEX, instance);
+
+             if (se_num =3D=3D 0xffffffff)
+                             data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, =
SE_BROADCAST_WRITES, 1);
+             else
+                             data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, =
SE_INDEX, se_num);
+
+             if (sh_num =3D=3D 0xffffffff)
+                             data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, =
SH_BROADCAST_WRITES, 1);
+             else
+                             data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, =
SH_INDEX, sh_num);
+
+             WREG32(mmGRBM_GFX_INDEX, data);
+}
+
static const u32 vgpr_init_compute_shader[] =3D
{
               0x7e000209, 0x7e020208,
@@ -3556,29 +3579,6 @@ static void gfx_v8_0_tiling_mode_table_init(struct a=
mdgpu_device *adev)
               }
}
-static void gfx_v8_0_select_se_sh(struct amdgpu_device *adev,
-                                                                u32 se_num=
, u32 sh_num, u32 instance)
-{
-              u32 data;
-
-              if (instance =3D=3D 0xffffffff)
-                              data =3D REG_SET_FIELD(0, GRBM_GFX_INDEX, IN=
STANCE_BROADCAST_WRITES, 1);
-              else
-                              data =3D REG_SET_FIELD(0, GRBM_GFX_INDEX, IN=
STANCE_INDEX, instance);
-
-              if (se_num =3D=3D 0xffffffff)
-                              data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,=
 SE_BROADCAST_WRITES, 1);
-              else
-                              data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,=
 SE_INDEX, se_num);
-
-              if (sh_num =3D=3D 0xffffffff)
-                              data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,=
 SH_BROADCAST_WRITES, 1);
-              else
-                              data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,=
 SH_INDEX, sh_num);
-
-              WREG32(mmGRBM_GFX_INDEX, data);
-}
-
static u32 gfx_v8_0_create_bitmask(u32 bit_width)
{
               return (u32)((1ULL << bit_width) - 1);
--
2.7.4


>From 38fac8cab73dbc07e0ee7599b52106bc09dd32ea Mon Sep 17 00:00:00 2001
From: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
Date: Mon, 24 Apr 2017 11:05:45 -0400
Subject: [PATCH 2/3] drm/amdgpu: Complete Carrizo EDC (Error Detection and
Correction) workarounds.

The workarounds are unconditionally performed on CZs with EDC enabled.
EDC detects uncorrected ECC errors and uses data poisoning to prevent
corrupted compute results from being used (read).
EDC enabled CZs are often used in embedded environments.

Change-Id: I84c261785329beeb797f11efbe0ec35790f2996c
Signed-off-by: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
---
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 148 ++++++++++++++++++++++++-------=
---
1 file changed, 106 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 27b57cb..2f5bf5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1645,35 +1645,92 @@ static const u32 sgpr2_init_regs[] =3D
               mmCOMPUTE_USER_DATA_9, 0xedcedc09,
};
-static const u32 sec_ded_counter_registers[] =3D
-{
-              mmCPC_EDC_ATC_CNT,
-              mmCPC_EDC_SCRATCH_CNT,
-              mmCPC_EDC_UCODE_CNT,
-              mmCPF_EDC_ATC_CNT,
-              mmCPF_EDC_ROQ_CNT,
-              mmCPF_EDC_TAG_CNT,
-              mmCPG_EDC_ATC_CNT,
-              mmCPG_EDC_DMA_CNT,
-              mmCPG_EDC_TAG_CNT,
-              mmDC_EDC_CSINVOC_CNT,
-              mmDC_EDC_RESTORE_CNT,
-              mmDC_EDC_STATE_CNT,
-              mmGDS_EDC_CNT,
-              mmGDS_EDC_GRBM_CNT,
-              mmGDS_EDC_OA_DED,
-              mmSPI_EDC_CNT,
-              mmSQC_ATC_EDC_GATCL1_CNT,
-              mmSQC_EDC_CNT,
-              mmSQ_EDC_DED_CNT,
-              mmSQ_EDC_INFO,
-              mmSQ_EDC_SEC_CNT,
-              mmTCC_EDC_CNT,
-              mmTCP_ATC_EDC_GATCL1_CNT,
-              mmTCP_EDC_CNT,
-              mmTD_EDC_CNT
+struct reg32_counter_name_map {
+             uint32_t rnmap_addr;   /* Counter register address */
+             const char *rnmap_name;           /* Name of the counter */
+             size_t rnmap_num_instances;  /* Number of block instances */
};
+#define DEF_mmREG32_NAME_MAP_ELEMENT(reg, num_instances) {             \
+             .rnmap_addr =3D mm##reg,                                     =
                                      \
+             .rnmap_name =3D #reg,                                        =
                            \
+             .rnmap_num_instances =3D num_instances                       =
                     \
+}
+
+/* See GRBM_GFX_INDEX, et. al. registers. */
+static const struct reg32_counter_name_map sec_ded_counter_registers[] =3D=
 {
+             DEF_mmREG32_NAME_MAP_ELEMENT(SQC_EDC_CNT, 2),
+             DEF_mmREG32_NAME_MAP_ELEMENT(SQC_ATC_EDC_GATCL1_CNT, 2),
+
+             DEF_mmREG32_NAME_MAP_ELEMENT(SQ_EDC_SEC_CNT, 8),
+             DEF_mmREG32_NAME_MAP_ELEMENT(SQ_EDC_DED_CNT, 8),
+             DEF_mmREG32_NAME_MAP_ELEMENT(TCP_EDC_CNT, 8),
+             DEF_mmREG32_NAME_MAP_ELEMENT(TCP_ATC_EDC_GATCL1_CNT, 8),
+             DEF_mmREG32_NAME_MAP_ELEMENT(TD_EDC_CNT, 8),
+
+             DEF_mmREG32_NAME_MAP_ELEMENT(TCC_EDC_CNT, 4),
+
+             DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_ATC_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_SCRATCH_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_UCODE_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_ATC_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_ROQ_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_TAG_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_ATC_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_DMA_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_TAG_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_CSINVOC_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_STATE_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_RESTORE_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(GDS_EDC_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(GDS_EDC_GRBM_CNT, 1),
+             DEF_mmREG32_NAME_MAP_ELEMENT(SPI_EDC_CNT, 1),
+};
+
+static int gfx_v8_0_edc_clear_counters(struct amdgpu_device *adev)
+{
+             int ci, se, sh, i;
+             uint32_t count;
+             int r =3D 0;
+
+             mutex_lock(&adev->grbm_idx_mutex);
+
+             for (ci =3D 0; ci < ARRAY_SIZE(sec_ded_counter_registers); ++=
ci) {
+                             const struct reg32_counter_name_map *cp =3D
+                                             sec_ded_counter_registers + c=
i;
+                             const char *name =3D cp->rnmap_name;
+
+                             for (se =3D 0; se < adev->gfx.config.max_shad=
er_engines; ++se) {
+                                             for (sh =3D 0; sh < adev->gfx=
.config.max_sh_per_se; ++sh) {
+                                                             for (i =3D 0;=
 i < cp->rnmap_num_instances; ++i) {
+                                                                          =
   gfx_v8_0_select_se_sh(adev, se, sh, i);
+                                                                          =
   count =3D RREG32(cp->rnmap_addr);
+                                                                          =
   count =3D RREG32(cp->rnmap_addr);
+                                                                          =
   if (count !=3D 0) {
+                                                                          =
                   /*
+                                                                          =
                   * Workaround failed.
+                                                                          =
                   * If people are interested
+                                                                          =
                   * in EDC at all, they will
+                                                                          =
                   * want to know which
+                                                                          =
                   * counters had problems.
+                                                                          =
                   */
+                                                                          =
                   DRM_WARN("EDC counter %s is 0x%08x, but should be 0\n.",
+                                                                          =
                                   name, count);
+                                                                          =
                   r =3D -EINVAL;
+                                                                          =
                   goto ret;
+                                                                          =
   }
+                                                             }
+                                             }
+                             }
+             }
+
+ret:
+             gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfffffff=
f);
+             mutex_unlock(&adev->grbm_idx_mutex);
+
+             return r;
+}
+
static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
{
               struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[0];
@@ -1681,18 +1738,36 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct a=
mdgpu_device *adev)
               struct fence *f =3D NULL;
               int r, i;
               u32 tmp;
+             u32 dis_bit;
               unsigned total_size, vgpr_offset, sgpr_offset;
               u64 gpu_addr;
-              /* only supported on CZ */
-              if (adev->asic_type !=3D CHIP_CARRIZO)
+             if (adev->asic_type !=3D CHIP_CARRIZO) {
+                             /* EDC is only supported on CZ */
+                             return 0;
+             }
+
+        DRM_INFO("Detected Carrizo.\n");
+
+             tmp =3D RREG32(mmCC_GC_EDC_CONFIG);
+             dis_bit =3D REG_GET_FIELD(tmp, CC_GC_EDC_CONFIG, DIS_EDC);
+             if (dis_bit) {
+                             /* On Carrizo, EDC may be disabled by a fuse.=
 */
+                             DRM_INFO("EDC hardware is disabled, GC_EDC_CO=
NFIG: 0x%08x.\n",
+                                             tmp);
                               return 0;
+             }
                /* bail if the compute ring is not ready */
               if (!ring->ready)
                               return 0;
-              tmp =3D RREG32(mmGB_EDC_MODE);
+             DRM_INFO("Applying EDC workarounds.\n");
+
+             /*
+             * Interested parties can enable EDC using debugfs register re=
ads and
+             * writes.
+             */
               WREG32(mmGB_EDC_MODE, 0);
                total_size =3D
@@ -1817,18 +1892,7 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct am=
dgpu_device *adev)
                               goto fail;
               }
-              tmp =3D REG_SET_FIELD(tmp, GB_EDC_MODE, DED_MODE, 2);
-              tmp =3D REG_SET_FIELD(tmp, GB_EDC_MODE, PROP_FED, 1);
-              WREG32(mmGB_EDC_MODE, tmp);
-
-              tmp =3D RREG32(mmCC_GC_EDC_CONFIG);
-              tmp =3D REG_SET_FIELD(tmp, CC_GC_EDC_CONFIG, DIS_EDC, 0) | 1=
;
-              WREG32(mmCC_GC_EDC_CONFIG, tmp);
-
-
-              /* read back registers to clear the counters */
-              for (i =3D 0; i < ARRAY_SIZE(sec_ded_counter_registers); i++=
)
-                              RREG32(sec_ded_counter_registers[i]);
+             gfx_v8_0_edc_clear_counters(adev);
 fail:
               amdgpu_ib_free(adev, &ib, NULL);
--
2.7.4


>From ec4803205582c1011f5ced1ead70ee244268b4b8 Mon Sep 17 00:00:00 2001
From: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
Date: Wed, 26 Apr 2017 10:13:06 -0400
Subject: [PATCH 3/3] drm/amdgpu: Add kernel parameter to control use of
ECC/EDC.

Allow various kinds of memory integrity methods (e.g. ECC/EDC) to be enable=
d
or disabled.  By default, all features are disabled.

EDC is Error Detection and Correction.  It can detect ECC errors and do 0 o=
r
more of: count SEC (single error corrected) and DED (double error detected,
i.e. uncorrected ECC error), halt the affected block, interrupt the CPU.
Currently, only counting errors is supported.

Signed-off-by: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
---
drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  4 ++++
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 34 +++++++++++++++++++++++++++--=
---
drivers/gpu/drm/amd/include/amd_shared.h | 14 +++++++++++++
4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 4a16e3c..0322392 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -111,6 +111,7 @@ extern int amdgpu_prim_buf_per_se;
extern int amdgpu_pos_buf_per_se;
extern int amdgpu_cntl_sb_buf_per_se;
extern int amdgpu_param_buf_per_se;
+extern unsigned amdgpu_ecc_flags;
 #define AMDGPU_DEFAULT_GTT_SIZE_MB                      3072ULL /* 3GB by =
default */
#define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS                   3000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index ead00d7..00e16ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -110,6 +110,7 @@ int amdgpu_prim_buf_per_se =3D 0;
int amdgpu_pos_buf_per_se =3D 0;
int amdgpu_cntl_sb_buf_per_se =3D 0;
int amdgpu_param_buf_per_se =3D 0;
+unsigned amdgpu_ecc_flags =3D 0;
 MODULE_PARM_DESC(vramlimit, "Restrict VRAM for testing, in megabytes");
module_param_named(vramlimit, amdgpu_vram_limit, int, 0600);
@@ -235,6 +236,9 @@ module_param_named(cntl_sb_buf_per_se, amdgpu_cntl_sb_b=
uf_per_se, int, 0444);
MODULE_PARM_DESC(param_buf_per_se, "the size of Off-Chip Pramater Cache per=
 Shader Engine (default depending on gfx)");
module_param_named(param_buf_per_se, amdgpu_param_buf_per_se, int, 0444);
+MODULE_PARM_DESC(ecc_flags, "ECC/EDC enable flags (0 =3D disable ECC/EDC (=
default))");
+module_param_named(ecc_flags, amdgpu_ecc_flags, uint, 0444);
+
 static const struct pci_device_id pciidlist[] =3D {
#ifdef  CONFIG_DRM_AMDGPU_SI
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 2f5bf5f..05cab7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1708,7 +1708,7 @@ static int gfx_v8_0_edc_clear_counters(struct amdgpu_=
device *adev)
                                                                           =
    count =3D RREG32(cp->rnmap_addr);
                                                                           =
    if (count !=3D 0) {
                                                                           =
                    /*
-                                                                          =
                    * Workaround failed.
+                                                                          =
                   * EDC workaround failed.
                                                                           =
                     * If people are interested
                                                                           =
                     * in EDC at all, they will
                                                                           =
                     * want to know which
@@ -1747,14 +1747,24 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct a=
mdgpu_device *adev)
                               return 0;
               }
-        DRM_INFO("Detected Carrizo.\n");
+             DRM_INFO("Detected Carrizo.\n");
                tmp =3D RREG32(mmCC_GC_EDC_CONFIG);
               dis_bit =3D REG_GET_FIELD(tmp, CC_GC_EDC_CONFIG, DIS_EDC);
               if (dis_bit) {
-                              /* On Carrizo, EDC may be disabled by a fuse=
. */
-                              DRM_INFO("EDC hardware is disabled, GC_EDC_C=
ONFIG: 0x%08x.\n",
-                                              tmp);
+                             /* On Carrizo, EDC may be disabled permanentl=
y by a fuse. */
+                             DRM_INFO("Carrizo EDC hardware is disabled, G=
C_EDC_CONFIG: 0x%08x.\n",
+                                             tmp);
+                             return 0;
+             }
+
+             /*
+             * Check if EDC has been requested by a kernel parameter.
+             * For Carrizo, EDC is the best/safest mode WRT error handling=
.
+             */
+             if (!(amdgpu_ecc_flags
+                   & (AMD_ECC_SUPPORT_BEST | AMD_ECC_SUPPORT_EDC))) {
+                             DRM_INFO("EDC support has not been requested.=
\n");
                               return 0;
               }
@@ -1892,6 +1902,20 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct am=
dgpu_device *adev)
                               goto fail;
               }
+             /* 00 - GB_EDC_DED_MODE_LOG: Count DED errors but do not halt=
 */
+             tmp =3D REG_SET_FIELD(tmp, GB_EDC_MODE, DED_MODE, 0);
+             /* Do not propagate the errors to the next block. */
+             tmp =3D REG_SET_FIELD(tmp, GB_EDC_MODE, PROP_FED, 0);
+             WREG32(mmGB_EDC_MODE, tmp);
+
+             tmp =3D RREG32(mmCC_GC_EDC_CONFIG);
+
+             /*
+             * Clear EDC_DISABLE bit so the counters are available.
+             */
+             tmp =3D REG_SET_FIELD(tmp, CC_GC_EDC_CONFIG, DIS_EDC, 0);
+             WREG32(mmCC_GC_EDC_CONFIG, tmp);
+
               gfx_v8_0_edc_clear_counters(adev);
 fail:
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index 2ccf44e..c4fd013 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -179,6 +179,20 @@ struct amd_pp_profile {
#define AMD_PG_SUPPORT_GFX_QUICK_MG                                (1 << 11=
)
#define AMD_PG_SUPPORT_GFX_PIPELINE                     (1 << 12)
+/*
+ * ECC flags
+ * Allows the user to choose what kind of error detection/correction is us=
ed.
+ * Currently, EDC is supported on Carrizo.
+ *
+ * The AMD_ECC_SUPPORT_BEST bit is used to allow a user to have the driver
+ * set what it thinks is best/safest mode.  This may not be the same as th=
e
+ * default, depending on the GPU and the application.
+ * Using a single bit makes it easy to request the best support without
+ * needing to know all currently supported modes.
+ */
+#define AMD_ECC_SUPPORT_BEST                                     (1 << 0)
+#define AMD_ECC_SUPPORT_EDC                                       (1 << 1)
+
enum amd_pm_state_type {
               /* not used for dpm */
               POWER_STATE_TYPE_DEFAULT,
--
2.7.4


--_000_BN6PR12MB1889CED9632BAE0144E8AE1795100BN6PR12MB1889namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">The changes in the workarounds function use DRM_INFO=
 rather than DRM_DEBUG because CZs with EDC are often used in embedded envi=
ronments and any info can be useful especially in the case of an intermitte=
nt problem.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">From e1ce383592c275b58ad95bd80b5479af8c1f9dae Mon Se=
p 17 00:00:00 2001<o:p></o:p></p>
<p class=3D"MsoNormal">From: David Panariti &lt;David.Panariti-5C7GfCeVMHo@public.gmane.org&gt;<=
o:p></o:p></p>
<p class=3D"MsoNormal">Date: Fri, 14 Apr 2017 13:41:52 -0400<o:p></o:p></p>
<p class=3D"MsoNormal">Subject: [PATCH 1/3] drm/amdgpu: Moved gfx_v8_0_sele=
ct_se_sh() in lieu of<o:p></o:p></p>
<p class=3D"MsoNormal">re-redundant prototype.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Will be needed for the rest of the EDC workarounds p=
atch.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Change-Id: Ie586ab38a69e98a91c6cb5747e285ce8bfdd1c86=
<o:p></o:p></p>
<p class=3D"MsoNormal">Signed-off-by: David Panariti &lt;David.Panariti@amd=
.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 46 &#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;------------------<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 23 insertions(&#43;), 23 deletions(-=
)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b=
/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 2ff5f19..27b57cb 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_=
0.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1500,6 &#43;1500,29 @@ static int gfx_v8_0_kiq_i=
nit(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&#43;static void gfx_v8_0_select_se_sh(struct amdgpu=
_device *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &nbsp; u32 se_num, u32 sh_num, u32 instance)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;{<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (instance =3D=3D 0xffffffff)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(0, GR=
BM_GFX_INDEX, INSTANCE_BROADCAST_WRITES, 1);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(0, GR=
BM_GFX_INDEX, INSTANCE_INDEX, instance);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (se_num =3D=3D 0xffffffff)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data,=
 GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data,=
 GRBM_GFX_INDEX, SE_INDEX, se_num);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (sh_num =3D=3D 0xffffffff)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data,=
 GRBM_GFX_INDEX, SH_BROADCAST_WRITES, 1);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data,=
 GRBM_GFX_INDEX, SH_INDEX, sh_num);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRBM_GFX_INDEX, data);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;}<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">static const u32 vgpr_init_compute_shader[] =3D<o:p>=
</o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7e000209, 0x7e020208,<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -3556,29 &#43;3579,6 @@ static void gfx_v8_0_tili=
ng_mode_table_init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-static void gfx_v8_0_select_se_sh(struct amdgpu_dev=
ice *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &nbsp; u32 se_num, u32 sh_num, u32 instance)<o:p></o:p></p>
<p class=3D"MsoNormal">-{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (instance =3D=3D 0xffffffff)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(0, =
GRBM_GFX_INDEX, INSTANCE_BROADCAST_WRITES, 1);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(0, =
GRBM_GFX_INDEX, INSTANCE_INDEX, instance);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (se_num =3D=3D 0xffffffff)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, GRBM_GFX_INDEX, SE_INDEX, se_num);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (sh_num =3D=3D 0xffffffff)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, GRBM_GFX_INDEX, SH_BROADCAST_WRITES, 1);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, GRBM_GFX_INDEX, SH_INDEX, sh_num);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRBM_GFX_INDEX, data);<o:p></o:p></p>
<p class=3D"MsoNormal">-}<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">static u32 gfx_v8_0_create_bitmask(u32 bit_width)<o:=
p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (u32)((1ULL &lt;&lt; bit_width) - 1=
);<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.7.4<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">From 38fac8cab73dbc07e0ee7599b52106bc09dd32ea Mon Se=
p 17 00:00:00 2001<o:p></o:p></p>
<p class=3D"MsoNormal">From: David Panariti &lt;David.Panariti-5C7GfCeVMHo@public.gmane.org&gt;<=
o:p></o:p></p>
<p class=3D"MsoNormal">Date: Mon, 24 Apr 2017 11:05:45 -0400<o:p></o:p></p>
<p class=3D"MsoNormal">Subject: [PATCH 2/3] drm/amdgpu: Complete Carrizo ED=
C (Error Detection and<o:p></o:p></p>
<p class=3D"MsoNormal">Correction) workarounds.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The workarounds are unconditionally performed on CZs=
 with EDC enabled.<o:p></o:p></p>
<p class=3D"MsoNormal">EDC detects uncorrected ECC errors and uses data poi=
soning to prevent<o:p></o:p></p>
<p class=3D"MsoNormal">corrupted compute results from being used (read).<o:=
p></o:p></p>
<p class=3D"MsoNormal">EDC enabled CZs are often used in embedded environme=
nts.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Change-Id: I84c261785329beeb797f11efbe0ec35790f2996c=
<o:p></o:p></p>
<p class=3D"MsoNormal">Signed-off-by: David Panariti &lt;David.Panariti@amd=
.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 148 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 106 insertions(&#43;), 42 deletions(=
-)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b=
/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 27b57cb..2f5bf5f 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_=
0.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1645,35 &#43;1645,92 @@ static const u32 sgpr2_i=
nit_regs[] =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCOMPUTE_USER_DATA_9, 0xedcedc09,<o:p></o=
:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-static const u32 sec_ded_counter_registers[] =3D<o:=
p></o:p></p>
<p class=3D"MsoNormal">-{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmCPC_EDC_ATC_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmCPC_EDC_SCRATCH_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmCPC_EDC_UCODE_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmCPF_EDC_ATC_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmCPF_EDC_ROQ_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmCPF_EDC_TAG_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmCPG_EDC_ATC_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmCPG_EDC_DMA_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmCPG_EDC_TAG_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmDC_EDC_CSINVOC_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmDC_EDC_RESTORE_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmDC_EDC_STATE_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmGDS_EDC_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmGDS_EDC_GRBM_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmGDS_EDC_OA_DED,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_EDC_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmSQC_ATC_EDC_GATCL1_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmSQC_EDC_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmSQ_EDC_DED_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmSQ_EDC_INFO,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmSQ_EDC_SEC_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCC_EDC_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_ATC_EDC_GATCL1_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_EDC_CNT,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mmTD_EDC_CNT<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;struct reg32_counter_name_map {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rnmap_addr;&nbsp;&nbsp; /* Counter regis=
ter address */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; const char *rnmap_name;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Name of the counter */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; size_t rnmap_num_instances;&nbsp; /* Number of bl=
ock instances */<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#define DEF_mmREG32_NAME_MAP_ELEMENT(reg, num_i=
nstances) {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; .rnmap_addr =3D mm##reg,&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; .rnmap_name =3D #reg,&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
\<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; .rnmap_num_instances =3D num_instances&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;}<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;/* See GRBM_GFX_INDEX, et. al. registers. */<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;static const struct reg32_counter_name_map sec_=
ded_counter_registers[] =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(SQC_EDC_CNT, 2),<o:p=
></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(SQC_ATC_EDC_GATCL1_C=
NT, 2),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(SQ_EDC_SEC_CNT, 8),<=
o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(SQ_EDC_DED_CNT, 8),<=
o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(TCP_EDC_CNT, 8),<o:p=
></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(TCP_ATC_EDC_GATCL1_C=
NT, 8),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(TD_EDC_CNT, 8),<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(TCC_EDC_CNT, 4),<o:p=
></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_ATC_CNT, 1),=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_SCRATCH_CNT,=
 1),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_UCODE_CNT, 1=
),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_ATC_CNT, 1),=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_ROQ_CNT, 1),=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_TAG_CNT, 1),=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_ATC_CNT, 1),=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_DMA_CNT, 1),=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_TAG_CNT, 1),=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_CSINVOC_CNT, =
1),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_STATE_CNT, 1)=
,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_RESTORE_CNT, =
1),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(GDS_EDC_CNT, 1),<o:p=
></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(GDS_EDC_GRBM_CNT, 1)=
,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DEF_mmREG32_NAME_MAP_ELEMENT(SPI_EDC_CNT, 1),<o:p=
></o:p></p>
<p class=3D"MsoNormal">&#43;};<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;static int gfx_v8_0_edc_clear_counters(struct a=
mdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;{<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; int ci, se, sh, i;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t count;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;grbm_idx_mutex);<o:p></o=
:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; for (ci =3D 0; ci &lt; ARRAY_SIZE(sec_ded_counter=
_registers); &#43;&#43;ci) {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct reg32_counter_n=
ame_map *cp =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sec_ded=
_counter_registers &#43; ci;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name =3D cp-&gt;=
rnmap_name;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (se =3D 0; se &lt; adev-=
&gt;gfx.config.max_shader_engines; &#43;&#43;se) {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (sh=
 =3D 0; sh &lt; adev-&gt;gfx.config.max_sh_per_se; &#43;&#43;sh) {<o:p></o:=
p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; for (i =3D 0; i &lt; cp-&gt;rnmap_num_instances; &#43;&#43;i)=
 {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_select_se_sh(adev, se, sh, i);<=
o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D RREG32(cp-&gt;rnmap_addr);<o:p=
></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D RREG32(cp-&gt;rnmap_addr);<o:p=
></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (count !=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Workaround failed=
.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If people are int=
erested<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in EDC at all, th=
ey will<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * want to know whic=
h<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * counters had prob=
lems.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;EDC =
counter %s is 0x%08x, but should be 0\n.&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; name, count);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -EINVAL;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto ret;<o:p></o:p=
></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;ret:<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xfffffff=
f, 0xffffffff);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;}<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">static int gfx_v8_0_do_edc_gpr_workarounds(struct am=
dgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt=
;gfx.compute_ring[0];<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1681,18 &#43;1738,36 @@ static int gfx_v8_0_do_e=
dc_gpr_workarounds(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct fence *f =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; u32 dis_bit;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned total_size, vgpr_offset, sgpr_off=
set;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 gpu_addr;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* only supported on CZ */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_CARRIZO)<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_CARRIZO) {<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* EDC is only supported on =
CZ */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_=
INFO(&quot;Detected Carrizo.\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmCC_GC_EDC_CONFIG);<o:p></o:p></p=
>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; dis_bit =3D REG_GET_FIELD(tmp, CC_GC_EDC_CONFIG, =
DIS_EDC);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (dis_bit) {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* On Carrizo, EDC may be di=
sabled by a fuse. */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;EDC hardware =
is disabled, GC_EDC_CONFIG: 0x%08x.\n&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp);<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bail if the compute ring is not r=
eady */<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring-&gt;ready)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmGB_EDC_MODE);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;Applying EDC workarounds.\n&quot;)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * Interested parties can enable EDC using debugfs=
 register reads and<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * writes.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGB_EDC_MODE, 0);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_size =3D<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1817,18 &#43;1892,7 @@ static int gfx_v8_0_do_ed=
c_gpr_workarounds(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GB_EDC_MODE, DED_MOD=
E, 2);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GB_EDC_MODE, PROP_FE=
D, 1);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGB_EDC_MODE, tmp);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmCC_GC_EDC_CONFIG);<o:p></o:p><=
/p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CC_GC_EDC_CONFIG, DI=
S_EDC, 0) | 1;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCC_GC_EDC_CONFIG, tmp);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* read back registers to clear the counters */=
<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(sec_ded_counter=
_registers); i&#43;&#43;)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32(sec_ded_counter_reg=
isters[i]);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_edc_clear_counters(adev);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;fail:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ib_free(adev, &amp;ib, NULL);<o:p><=
/o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.7.4<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">From ec4803205582c1011f5ced1ead70ee244268b4b8 Mon Se=
p 17 00:00:00 2001<o:p></o:p></p>
<p class=3D"MsoNormal">From: David Panariti &lt;David.Panariti-5C7GfCeVMHo@public.gmane.org&gt;<=
o:p></o:p></p>
<p class=3D"MsoNormal">Date: Wed, 26 Apr 2017 10:13:06 -0400<o:p></o:p></p>
<p class=3D"MsoNormal">Subject: [PATCH 3/3] drm/amdgpu: Add kernel paramete=
r to control use of<o:p></o:p></p>
<p class=3D"MsoNormal">ECC/EDC.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Allow various kinds of memory integrity methods (e.g=
. ECC/EDC) to be enabled<o:p></o:p></p>
<p class=3D"MsoNormal">or disabled.&nbsp; By default, all features are disa=
bled.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">EDC is Error Detection and Correction.&nbsp; It can =
detect ECC errors and do 0 or<o:p></o:p></p>
<p class=3D"MsoNormal">more of: count SEC (single error corrected) and DED =
(double error detected,<o:p></o:p></p>
<p class=3D"MsoNormal">i.e. uncorrected ECC error), halt the affected block=
, interrupt the CPU.<o:p></o:p></p>
<p class=3D"MsoNormal">Currently, only counting errors is supported.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: David Panariti &lt;David.Panariti@amd=
.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 1 &#43;<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp; |&nbsp=
; 4 &#43;&#43;&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nb=
sp; | 34 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----<=
o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/include/amd_shared.h | 14 &#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">4 files changed, 48 insertions(&#43;), 5 deletions(-=
)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/d=
rivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 4a16e3c..0322392 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.=
h<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -111,6 &#43;111,7 @@ extern int amdgpu_prim_buf_p=
er_se;<o:p></o:p></p>
<p class=3D"MsoNormal">extern int amdgpu_pos_buf_per_se;<o:p></o:p></p>
<p class=3D"MsoNormal">extern int amdgpu_cntl_sb_buf_per_se;<o:p></o:p></p>
<p class=3D"MsoNormal">extern int amdgpu_param_buf_per_se;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;extern unsigned amdgpu_ecc_flags;<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;#define AMDGPU_DEFAULT_GTT_SIZE_MB&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3072ULL /* 3GB by default */<o:p></=
o:p></p>
<p class=3D"MsoNormal">#define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 3000<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<o:p></o:p></p>
<p class=3D"MsoNormal">index ead00d7..00e16ac 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
drv.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -110,6 &#43;110,7 @@ int amdgpu_prim_buf_per_se =
=3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">int amdgpu_pos_buf_per_se =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">int amdgpu_cntl_sb_buf_per_se =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">int amdgpu_param_buf_per_se =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;unsigned amdgpu_ecc_flags =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;MODULE_PARM_DESC(vramlimit, &quot;Restrict VRA=
M for testing, in megabytes&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">module_param_named(vramlimit, amdgpu_vram_limit, int=
, 0600);<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -235,6 &#43;236,9 @@ module_param_named(cntl_sb_b=
uf_per_se, amdgpu_cntl_sb_buf_per_se, int, 0444);<o:p></o:p></p>
<p class=3D"MsoNormal">MODULE_PARM_DESC(param_buf_per_se, &quot;the size of=
 Off-Chip Pramater Cache per Shader Engine (default depending on gfx)&quot;=
);<o:p></o:p></p>
<p class=3D"MsoNormal">module_param_named(param_buf_per_se, amdgpu_param_bu=
f_per_se, int, 0444);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&#43;MODULE_PARM_DESC(ecc_flags, &quot;ECC/EDC enabl=
e flags (0 =3D disable ECC/EDC (default))&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;module_param_named(ecc_flags, amdgpu_ecc_flags,=
 uint, 0444);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;static const struct pci_device_id pciidlist[] =
=3D {<o:p></o:p></p>
<p class=3D"MsoNormal">#ifdef&nbsp; CONFIG_DRM_AMDGPU_SI<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b=
/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 2f5bf5f..05cab7e 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_=
0.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1708,7 &#43;1708,7 @@ static int gfx_v8_0_edc_cl=
ear_counters(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D RREG32(cp-&gt;rnmap_add=
r);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (count !=3D 0) {<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p=
></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Workaround fail=
ed.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * EDC workaround fa=
iled.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* If p=
eople are interested<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* in E=
DC at all, they will<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* want=
 to know which<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1747,14 &#43;1747,24 @@ static int gfx_v8_0_do_e=
dc_gpr_workarounds(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO=
(&quot;Detected Carrizo.\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;Detected Carrizo.\n&quot;);<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmCC_GC_EDC_CONFIG);<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dis_bit =3D REG_GET_FIELD(tmp, CC_GC_EDC_C=
ONFIG, DIS_EDC);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dis_bit) {<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* On Carrizo, EDC may be =
disabled by a fuse. */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;EDC hardwar=
e is disabled, GC_EDC_CONFIG: 0x%08x.\n&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp);=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* On Carrizo, EDC may be di=
sabled permanently by a fuse. */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;Carrizo EDC h=
ardware is disabled, GC_EDC_CONFIG: 0x%08x.\n&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp);<o=
:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * Check if EDC has been requested by a kernel par=
ameter.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * For Carrizo, EDC is the best/safest mode WRT er=
ror handling.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_ecc_flags<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; (AMD_ECC_SUP=
PORT_BEST | AMD_ECC_SUPPORT_EDC))) {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;EDC support h=
as not been requested.\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1892,6 &#43;1902,20 @@ static int gfx_v8_0_do_ed=
c_gpr_workarounds(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /* 00 - GB_EDC_DED_MODE_LOG: Count DED errors but=
 do not halt */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GB_EDC_MODE, DED_MODE,=
 0);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /* Do not propagate the errors to the next block.=
 */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GB_EDC_MODE, PROP_FED,=
 0);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGB_EDC_MODE, tmp);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmCC_GC_EDC_CONFIG);<o:p></o:p></p=
>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * Clear EDC_DISABLE bit so the counters are avail=
able.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CC_GC_EDC_CONFIG, DIS_=
EDC, 0);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCC_GC_EDC_CONFIG, tmp);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_edc_clear_counters(adev);<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;fail:<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/include/amd_shared.=
h b/drivers/gpu/drm/amd/include/amd_shared.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 2ccf44e..c4fd013 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/include/amd_shared.h<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/amd_sh=
ared.h<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -179,6 &#43;179,20 @@ struct amd_pp_profile {<o:p=
></o:p></p>
<p class=3D"MsoNormal">#define AMD_PG_SUPPORT_GFX_QUICK_MG&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 11)<o:p></o:p></p>
<p class=3D"MsoNormal">#define AMD_PG_SUPPORT_GFX_PIPELINE&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 12)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&#43;/*<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; * ECC flags<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; * Allows the user to choose what kind of error=
 detection/correction is used.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; * Currently, EDC is supported on Carrizo.<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43; *<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; * The AMD_ECC_SUPPORT_BEST bit is used to allo=
w a user to have the driver<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; * set what it thinks is best/safest mode.&nbsp=
; This may not be the same as the<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; * default, depending on the GPU and the applic=
ation.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; * Using a single bit makes it easy to request =
the best support without<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; * needing to know all currently supported mode=
s.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#define AMD_ECC_SUPPORT_BEST&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 0)<o:p></o:p></=
p>
<p class=3D"MsoNormal">&#43;#define AMD_ECC_SUPPORT_EDC&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 1)<o=
:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">enum amd_pm_state_type {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* not used for dpm */<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; POWER_STATE_TYPE_DEFAULT,<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.7.4<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BN6PR12MB1889CED9632BAE0144E8AE1795100BN6PR12MB1889namp_--

--_004_BN6PR12MB1889CED9632BAE0144E8AE1795100BN6PR12MB1889namp_
Content-Type: application/octet-stream; name="all-edc.patch"
Content-Description: all-edc.patch
Content-Disposition: attachment; filename="all-edc.patch"; size=14445;
	creation-date="Thu, 27 Apr 2017 22:12:19 GMT";
	modification-date="Thu, 27 Apr 2017 21:59:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlMWNlMzgzNTkyYzI3NWI1OGFkOTViZDgwYjU0NzlhZjhjMWY5ZGFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBQYW5hcml0aSA8RGF2aWQuUGFuYXJpdGlAYW1kLmNv
bT4KRGF0ZTogRnJpLCAxNCBBcHIgMjAxNyAxMzo0MTo1MiAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
MS8zXSBkcm0vYW1kZ3B1OiBNb3ZlZCBnZnhfdjhfMF9zZWxlY3Rfc2Vfc2goKSBpbiBsaWV1IG9m
CiByZS1yZWR1bmRhbnQgcHJvdG90eXBlLgoKV2lsbCBiZSBuZWVkZWQgZm9yIHRoZSByZXN0IG9m
IHRoZSBFREMgd29ya2Fyb3VuZHMgcGF0Y2guCgpDaGFuZ2UtSWQ6IEllNTg2YWIzOGE2OWU5OGE5
MWM2Y2I1NzQ3ZTI4NWNlOGJmZGQxYzg2ClNpZ25lZC1vZmYtYnk6IERhdmlkIFBhbmFyaXRpIDxE
YXZpZC5QYW5hcml0aUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OF8wLmMgfCA0NiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjhfMC5jCmluZGV4IDJmZjVmMTkuLjI3YjU3Y2IgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwpAQCAtMTUwMCw2ICsxNTAwLDI5IEBAIHN0YXRpYyBp
bnQgZ2Z4X3Y4XzBfa2lxX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJcmV0dXJu
IDA7CiB9CiAKK3N0YXRpYyB2b2lkIGdmeF92OF8wX3NlbGVjdF9zZV9zaChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKKwkJCQkgIHUzMiBzZV9udW0sIHUzMiBzaF9udW0sIHUzMiBpbnN0YW5j
ZSkKK3sKKwl1MzIgZGF0YTsKKworCWlmIChpbnN0YW5jZSA9PSAweGZmZmZmZmZmKQorCQlkYXRh
ID0gUkVHX1NFVF9GSUVMRCgwLCBHUkJNX0dGWF9JTkRFWCwgSU5TVEFOQ0VfQlJPQURDQVNUX1dS
SVRFUywgMSk7CisJZWxzZQorCQlkYXRhID0gUkVHX1NFVF9GSUVMRCgwLCBHUkJNX0dGWF9JTkRF
WCwgSU5TVEFOQ0VfSU5ERVgsIGluc3RhbmNlKTsKKworCWlmIChzZV9udW0gPT0gMHhmZmZmZmZm
ZikKKwkJZGF0YSA9IFJFR19TRVRfRklFTEQoZGF0YSwgR1JCTV9HRlhfSU5ERVgsIFNFX0JST0FE
Q0FTVF9XUklURVMsIDEpOworCWVsc2UKKwkJZGF0YSA9IFJFR19TRVRfRklFTEQoZGF0YSwgR1JC
TV9HRlhfSU5ERVgsIFNFX0lOREVYLCBzZV9udW0pOworCisJaWYgKHNoX251bSA9PSAweGZmZmZm
ZmZmKQorCQlkYXRhID0gUkVHX1NFVF9GSUVMRChkYXRhLCBHUkJNX0dGWF9JTkRFWCwgU0hfQlJP
QURDQVNUX1dSSVRFUywgMSk7CisJZWxzZQorCQlkYXRhID0gUkVHX1NFVF9GSUVMRChkYXRhLCBH
UkJNX0dGWF9JTkRFWCwgU0hfSU5ERVgsIHNoX251bSk7CisKKwlXUkVHMzIobW1HUkJNX0dGWF9J
TkRFWCwgZGF0YSk7Cit9CisKIHN0YXRpYyBjb25zdCB1MzIgdmdwcl9pbml0X2NvbXB1dGVfc2hh
ZGVyW10gPQogewogCTB4N2UwMDAyMDksIDB4N2UwMjAyMDgsCkBAIC0zNTU2LDI5ICszNTc5LDYg
QEAgc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfdGlsaW5nX21vZGVfdGFibGVfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAl9CiB9CiAKLXN0YXRpYyB2b2lkIGdmeF92OF8wX3NlbGVjdF9z
ZV9zaChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKLQkJCQkgIHUzMiBzZV9udW0sIHUzMiBz
aF9udW0sIHUzMiBpbnN0YW5jZSkKLXsKLQl1MzIgZGF0YTsKLQotCWlmIChpbnN0YW5jZSA9PSAw
eGZmZmZmZmZmKQotCQlkYXRhID0gUkVHX1NFVF9GSUVMRCgwLCBHUkJNX0dGWF9JTkRFWCwgSU5T
VEFOQ0VfQlJPQURDQVNUX1dSSVRFUywgMSk7Ci0JZWxzZQotCQlkYXRhID0gUkVHX1NFVF9GSUVM
RCgwLCBHUkJNX0dGWF9JTkRFWCwgSU5TVEFOQ0VfSU5ERVgsIGluc3RhbmNlKTsKLQotCWlmIChz
ZV9udW0gPT0gMHhmZmZmZmZmZikKLQkJZGF0YSA9IFJFR19TRVRfRklFTEQoZGF0YSwgR1JCTV9H
RlhfSU5ERVgsIFNFX0JST0FEQ0FTVF9XUklURVMsIDEpOwotCWVsc2UKLQkJZGF0YSA9IFJFR19T
RVRfRklFTEQoZGF0YSwgR1JCTV9HRlhfSU5ERVgsIFNFX0lOREVYLCBzZV9udW0pOwotCi0JaWYg
KHNoX251bSA9PSAweGZmZmZmZmZmKQotCQlkYXRhID0gUkVHX1NFVF9GSUVMRChkYXRhLCBHUkJN
X0dGWF9JTkRFWCwgU0hfQlJPQURDQVNUX1dSSVRFUywgMSk7Ci0JZWxzZQotCQlkYXRhID0gUkVH
X1NFVF9GSUVMRChkYXRhLCBHUkJNX0dGWF9JTkRFWCwgU0hfSU5ERVgsIHNoX251bSk7Ci0KLQlX
UkVHMzIobW1HUkJNX0dGWF9JTkRFWCwgZGF0YSk7Ci19Ci0KIHN0YXRpYyB1MzIgZ2Z4X3Y4XzBf
Y3JlYXRlX2JpdG1hc2sodTMyIGJpdF93aWR0aCkKIHsKIAlyZXR1cm4gKHUzMikoKDFVTEwgPDwg
Yml0X3dpZHRoKSAtIDEpOwotLSAKMi43LjQKCgpGcm9tIDM4ZmFjOGNhYjczZGJjMDdlMGVlNzU5
OWI1MjEwNmJjMDlkZDMyZWEgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IERhdmlkIFBh
bmFyaXRpIDxEYXZpZC5QYW5hcml0aUBhbWQuY29tPgpEYXRlOiBNb24sIDI0IEFwciAyMDE3IDEx
OjA1OjQ1IC0wNDAwClN1YmplY3Q6IFtQQVRDSCAyLzNdIGRybS9hbWRncHU6IENvbXBsZXRlIENh
cnJpem8gRURDIChFcnJvciBEZXRlY3Rpb24gYW5kCiBDb3JyZWN0aW9uKSB3b3JrYXJvdW5kcy4K
ClRoZSB3b3JrYXJvdW5kcyBhcmUgdW5jb25kaXRpb25hbGx5IHBlcmZvcm1lZCBvbiBDWnMgd2l0
aCBFREMgZW5hYmxlZC4KRURDIGRldGVjdHMgdW5jb3JyZWN0ZWQgRUNDIGVycm9ycyBhbmQgdXNl
cyBkYXRhIHBvaXNvbmluZyB0byBwcmV2ZW50CmNvcnJ1cHRlZCBjb21wdXRlIHJlc3VsdHMgZnJv
bSBiZWluZyB1c2VkIChyZWFkKS4KRURDIGVuYWJsZWQgQ1pzIGFyZSBvZnRlbiB1c2VkIGluIGVt
YmVkZGVkIGVudmlyb25tZW50cy4KCkNoYW5nZS1JZDogSTg0YzI2MTc4NTMyOWJlZWI3OTdmMTFl
ZmJlMGVjMzU3OTBmMjk5NmMKU2lnbmVkLW9mZi1ieTogRGF2aWQgUGFuYXJpdGkgPERhdmlkLlBh
bmFyaXRpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAu
YyB8IDE0OCArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMTA2IGluc2VydGlvbnMoKyksIDQyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjhfMC5jCmluZGV4IDI3YjU3Y2IuLjJmNWJmNWYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y4XzAuYwpAQCAtMTY0NSwzNSArMTY0NSw5MiBAQCBzdGF0aWMgY29uc3Qg
dTMyIHNncHIyX2luaXRfcmVnc1tdID0KIAltbUNPTVBVVEVfVVNFUl9EQVRBXzksIDB4ZWRjZWRj
MDksCiB9OwogCi1zdGF0aWMgY29uc3QgdTMyIHNlY19kZWRfY291bnRlcl9yZWdpc3RlcnNbXSA9
Ci17Ci0JbW1DUENfRURDX0FUQ19DTlQsCi0JbW1DUENfRURDX1NDUkFUQ0hfQ05ULAotCW1tQ1BD
X0VEQ19VQ09ERV9DTlQsCi0JbW1DUEZfRURDX0FUQ19DTlQsCi0JbW1DUEZfRURDX1JPUV9DTlQs
Ci0JbW1DUEZfRURDX1RBR19DTlQsCi0JbW1DUEdfRURDX0FUQ19DTlQsCi0JbW1DUEdfRURDX0RN
QV9DTlQsCi0JbW1DUEdfRURDX1RBR19DTlQsCi0JbW1EQ19FRENfQ1NJTlZPQ19DTlQsCi0JbW1E
Q19FRENfUkVTVE9SRV9DTlQsCi0JbW1EQ19FRENfU1RBVEVfQ05ULAotCW1tR0RTX0VEQ19DTlQs
Ci0JbW1HRFNfRURDX0dSQk1fQ05ULAotCW1tR0RTX0VEQ19PQV9ERUQsCi0JbW1TUElfRURDX0NO
VCwKLQltbVNRQ19BVENfRURDX0dBVENMMV9DTlQsCi0JbW1TUUNfRURDX0NOVCwKLQltbVNRX0VE
Q19ERURfQ05ULAotCW1tU1FfRURDX0lORk8sCi0JbW1TUV9FRENfU0VDX0NOVCwKLQltbVRDQ19F
RENfQ05ULAotCW1tVENQX0FUQ19FRENfR0FUQ0wxX0NOVCwKLQltbVRDUF9FRENfQ05ULAotCW1t
VERfRURDX0NOVAorc3RydWN0IHJlZzMyX2NvdW50ZXJfbmFtZV9tYXAgeworCXVpbnQzMl90IHJu
bWFwX2FkZHI7CS8qIENvdW50ZXIgcmVnaXN0ZXIgYWRkcmVzcyAqLworCWNvbnN0IGNoYXIgKnJu
bWFwX25hbWU7CS8qIE5hbWUgb2YgdGhlIGNvdW50ZXIgKi8KKwlzaXplX3Qgcm5tYXBfbnVtX2lu
c3RhbmNlczsgIC8qIE51bWJlciBvZiBibG9jayBpbnN0YW5jZXMgKi8KIH07CiAKKyNkZWZpbmUg
REVGX21tUkVHMzJfTkFNRV9NQVBfRUxFTUVOVChyZWcsIG51bV9pbnN0YW5jZXMpIHsJXAorCS5y
bm1hcF9hZGRyID0gbW0jI3JlZywJCQkJCVwKKwkucm5tYXBfbmFtZSA9ICNyZWcsCQkJCQlcCisJ
LnJubWFwX251bV9pbnN0YW5jZXMgPSBudW1faW5zdGFuY2VzCQkJXAorfQorCisvKiBTZWUgR1JC
TV9HRlhfSU5ERVgsIGV0LiBhbC4gcmVnaXN0ZXJzLiAqLworc3RhdGljIGNvbnN0IHN0cnVjdCBy
ZWczMl9jb3VudGVyX25hbWVfbWFwIHNlY19kZWRfY291bnRlcl9yZWdpc3RlcnNbXSA9IHsKKwlE
RUZfbW1SRUczMl9OQU1FX01BUF9FTEVNRU5UKFNRQ19FRENfQ05ULCAyKSwKKwlERUZfbW1SRUcz
Ml9OQU1FX01BUF9FTEVNRU5UKFNRQ19BVENfRURDX0dBVENMMV9DTlQsIDIpLAorCisJREVGX21t
UkVHMzJfTkFNRV9NQVBfRUxFTUVOVChTUV9FRENfU0VDX0NOVCwgOCksCisJREVGX21tUkVHMzJf
TkFNRV9NQVBfRUxFTUVOVChTUV9FRENfREVEX0NOVCwgOCksCisJREVGX21tUkVHMzJfTkFNRV9N
QVBfRUxFTUVOVChUQ1BfRURDX0NOVCwgOCksCisJREVGX21tUkVHMzJfTkFNRV9NQVBfRUxFTUVO
VChUQ1BfQVRDX0VEQ19HQVRDTDFfQ05ULCA4KSwKKwlERUZfbW1SRUczMl9OQU1FX01BUF9FTEVN
RU5UKFREX0VEQ19DTlQsIDgpLAorCisJREVGX21tUkVHMzJfTkFNRV9NQVBfRUxFTUVOVChUQ0Nf
RURDX0NOVCwgNCksCisKKwlERUZfbW1SRUczMl9OQU1FX01BUF9FTEVNRU5UKENQQ19FRENfQVRD
X0NOVCwgMSksCisJREVGX21tUkVHMzJfTkFNRV9NQVBfRUxFTUVOVChDUENfRURDX1NDUkFUQ0hf
Q05ULCAxKSwKKwlERUZfbW1SRUczMl9OQU1FX01BUF9FTEVNRU5UKENQQ19FRENfVUNPREVfQ05U
LCAxKSwKKwlERUZfbW1SRUczMl9OQU1FX01BUF9FTEVNRU5UKENQRl9FRENfQVRDX0NOVCwgMSks
CisJREVGX21tUkVHMzJfTkFNRV9NQVBfRUxFTUVOVChDUEZfRURDX1JPUV9DTlQsIDEpLAorCURF
Rl9tbVJFRzMyX05BTUVfTUFQX0VMRU1FTlQoQ1BGX0VEQ19UQUdfQ05ULCAxKSwKKwlERUZfbW1S
RUczMl9OQU1FX01BUF9FTEVNRU5UKENQR19FRENfQVRDX0NOVCwgMSksCisJREVGX21tUkVHMzJf
TkFNRV9NQVBfRUxFTUVOVChDUEdfRURDX0RNQV9DTlQsIDEpLAorCURFRl9tbVJFRzMyX05BTUVf
TUFQX0VMRU1FTlQoQ1BHX0VEQ19UQUdfQ05ULCAxKSwKKwlERUZfbW1SRUczMl9OQU1FX01BUF9F
TEVNRU5UKERDX0VEQ19DU0lOVk9DX0NOVCwgMSksCisJREVGX21tUkVHMzJfTkFNRV9NQVBfRUxF
TUVOVChEQ19FRENfU1RBVEVfQ05ULCAxKSwKKwlERUZfbW1SRUczMl9OQU1FX01BUF9FTEVNRU5U
KERDX0VEQ19SRVNUT1JFX0NOVCwgMSksCisJREVGX21tUkVHMzJfTkFNRV9NQVBfRUxFTUVOVChH
RFNfRURDX0NOVCwgMSksCisJREVGX21tUkVHMzJfTkFNRV9NQVBfRUxFTUVOVChHRFNfRURDX0dS
Qk1fQ05ULCAxKSwKKwlERUZfbW1SRUczMl9OQU1FX01BUF9FTEVNRU5UKFNQSV9FRENfQ05ULCAx
KSwKK307CisKK3N0YXRpYyBpbnQgZ2Z4X3Y4XzBfZWRjX2NsZWFyX2NvdW50ZXJzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQoreworCWludCBjaSwgc2UsIHNoLCBpOworCXVpbnQzMl90IGNv
dW50OworCWludCByID0gMDsKKworCW11dGV4X2xvY2soJmFkZXYtPmdyYm1faWR4X211dGV4KTsK
KworCWZvciAoY2kgPSAwOyBjaSA8IEFSUkFZX1NJWkUoc2VjX2RlZF9jb3VudGVyX3JlZ2lzdGVy
cyk7ICsrY2kpIHsKKwkJY29uc3Qgc3RydWN0IHJlZzMyX2NvdW50ZXJfbmFtZV9tYXAgKmNwID0K
KwkJCXNlY19kZWRfY291bnRlcl9yZWdpc3RlcnMgKyBjaTsKKwkJY29uc3QgY2hhciAqbmFtZSA9
IGNwLT5ybm1hcF9uYW1lOworCisJCWZvciAoc2UgPSAwOyBzZSA8IGFkZXYtPmdmeC5jb25maWcu
bWF4X3NoYWRlcl9lbmdpbmVzOyArK3NlKSB7CisJCQlmb3IgKHNoID0gMDsgc2ggPCBhZGV2LT5n
ZnguY29uZmlnLm1heF9zaF9wZXJfc2U7ICsrc2gpIHsKKwkJCQlmb3IgKGkgPSAwOyBpIDwgY3At
PnJubWFwX251bV9pbnN0YW5jZXM7ICsraSkgeworCQkJCQlnZnhfdjhfMF9zZWxlY3Rfc2Vfc2go
YWRldiwgc2UsIHNoLCBpKTsKKwkJCQkJY291bnQgPSBSUkVHMzIoY3AtPnJubWFwX2FkZHIpOwor
CQkJCQljb3VudCA9IFJSRUczMihjcC0+cm5tYXBfYWRkcik7CisJCQkJCWlmIChjb3VudCAhPSAw
KSB7CisJCQkJCQkvKgorCQkJCQkJICogV29ya2Fyb3VuZCBmYWlsZWQuCisJCQkJCQkgKiBJZiBw
ZW9wbGUgYXJlIGludGVyZXN0ZWQKKwkJCQkJCSAqIGluIEVEQyBhdCBhbGwsIHRoZXkgd2lsbAor
CQkJCQkJICogd2FudCB0byBrbm93IHdoaWNoCisJCQkJCQkgKiBjb3VudGVycyBoYWQgcHJvYmxl
bXMuCisJCQkJCQkgKi8KKwkJCQkJCURSTV9XQVJOKCJFREMgY291bnRlciAlcyBpcyAweCUwOHgs
IGJ1dCBzaG91bGQgYmUgMFxuLiIsCisJCQkJCQkJIG5hbWUsIGNvdW50KTsKKwkJCQkJCXIgPSAt
RUlOVkFMOworCQkJCQkJZ290byByZXQ7CisJCQkJCX0KKwkJCQl9CisJCQl9CisJCX0KKwl9CisK
K3JldDoKKwlnZnhfdjhfMF9zZWxlY3Rfc2Vfc2goYWRldiwgMHhmZmZmZmZmZiwgMHhmZmZmZmZm
ZiwgMHhmZmZmZmZmZik7CisJbXV0ZXhfdW5sb2NrKCZhZGV2LT5ncmJtX2lkeF9tdXRleCk7CisK
KwlyZXR1cm4gcjsKK30KKwogc3RhdGljIGludCBnZnhfdjhfMF9kb19lZGNfZ3ByX3dvcmthcm91
bmRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCXN0cnVjdCBhbWRncHVfcmluZyAq
cmluZyA9ICZhZGV2LT5nZnguY29tcHV0ZV9yaW5nWzBdOwpAQCAtMTY4MSwxOCArMTczOCwzNiBA
QCBzdGF0aWMgaW50IGdmeF92OF8wX2RvX2VkY19ncHJfd29ya2Fyb3VuZHMoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiAJc3RydWN0IGZlbmNlICpmID0gTlVMTDsKIAlpbnQgciwgaTsKIAl1
MzIgdG1wOworCXUzMiBkaXNfYml0OwogCXVuc2lnbmVkIHRvdGFsX3NpemUsIHZncHJfb2Zmc2V0
LCBzZ3ByX29mZnNldDsKIAl1NjQgZ3B1X2FkZHI7CiAKLQkvKiBvbmx5IHN1cHBvcnRlZCBvbiBD
WiAqLwotCWlmIChhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9DQVJSSVpPKQorCWlmIChhZGV2LT5h
c2ljX3R5cGUgIT0gQ0hJUF9DQVJSSVpPKSB7CisJCS8qIEVEQyBpcyBvbmx5IHN1cHBvcnRlZCBv
biBDWiAqLworCQlyZXR1cm4gMDsKKwl9CisKKyAgICAgICAgRFJNX0lORk8oIkRldGVjdGVkIENh
cnJpem8uXG4iKTsKKworCXRtcCA9IFJSRUczMihtbUNDX0dDX0VEQ19DT05GSUcpOworCWRpc19i
aXQgPSBSRUdfR0VUX0ZJRUxEKHRtcCwgQ0NfR0NfRURDX0NPTkZJRywgRElTX0VEQyk7CisJaWYg
KGRpc19iaXQpIHsKKwkJLyogT24gQ2Fycml6bywgRURDIG1heSBiZSBkaXNhYmxlZCBieSBhIGZ1
c2UuICovCisJCURSTV9JTkZPKCJFREMgaGFyZHdhcmUgaXMgZGlzYWJsZWQsIEdDX0VEQ19DT05G
SUc6IDB4JTA4eC5cbiIsCisJCQl0bXApOwogCQlyZXR1cm4gMDsKKwl9CiAKIAkvKiBiYWlsIGlm
IHRoZSBjb21wdXRlIHJpbmcgaXMgbm90IHJlYWR5ICovCiAJaWYgKCFyaW5nLT5yZWFkeSkKIAkJ
cmV0dXJuIDA7CiAKLQl0bXAgPSBSUkVHMzIobW1HQl9FRENfTU9ERSk7CisJRFJNX0lORk8oIkFw
cGx5aW5nIEVEQyB3b3JrYXJvdW5kcy5cbiIpOworCisJLyoKKwkgKiBJbnRlcmVzdGVkIHBhcnRp
ZXMgY2FuIGVuYWJsZSBFREMgdXNpbmcgZGVidWdmcyByZWdpc3RlciByZWFkcyBhbmQKKwkgKiB3
cml0ZXMuCisJICovCiAJV1JFRzMyKG1tR0JfRURDX01PREUsIDApOwogCiAJdG90YWxfc2l6ZSA9
CkBAIC0xODE3LDE4ICsxODkyLDcgQEAgc3RhdGljIGludCBnZnhfdjhfMF9kb19lZGNfZ3ByX3dv
cmthcm91bmRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlnb3RvIGZhaWw7CiAJfQog
Ci0JdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIEdCX0VEQ19NT0RFLCBERURfTU9ERSwgMik7Ci0J
dG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIEdCX0VEQ19NT0RFLCBQUk9QX0ZFRCwgMSk7Ci0JV1JF
RzMyKG1tR0JfRURDX01PREUsIHRtcCk7Ci0KLQl0bXAgPSBSUkVHMzIobW1DQ19HQ19FRENfQ09O
RklHKTsKLQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ0NfR0NfRURDX0NPTkZJRywgRElTX0VE
QywgMCkgfCAxOwotCVdSRUczMihtbUNDX0dDX0VEQ19DT05GSUcsIHRtcCk7Ci0KLQotCS8qIHJl
YWQgYmFjayByZWdpc3RlcnMgdG8gY2xlYXIgdGhlIGNvdW50ZXJzICovCi0JZm9yIChpID0gMDsg
aSA8IEFSUkFZX1NJWkUoc2VjX2RlZF9jb3VudGVyX3JlZ2lzdGVycyk7IGkrKykKLQkJUlJFRzMy
KHNlY19kZWRfY291bnRlcl9yZWdpc3RlcnNbaV0pOworCWdmeF92OF8wX2VkY19jbGVhcl9jb3Vu
dGVycyhhZGV2KTsKIAogZmFpbDoKIAlhbWRncHVfaWJfZnJlZShhZGV2LCAmaWIsIE5VTEwpOwot
LSAKMi43LjQKCgpGcm9tIGVjNDgwMzIwNTU4MmMxMDExZjVjZWQxZWFkNzBlZTI0NDI2OGI0Yjgg
TW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IERhdmlkIFBhbmFyaXRpIDxEYXZpZC5QYW5h
cml0aUBhbWQuY29tPgpEYXRlOiBXZWQsIDI2IEFwciAyMDE3IDEwOjEzOjA2IC0wNDAwClN1Ympl
Y3Q6IFtQQVRDSCAzLzNdIGRybS9hbWRncHU6IEFkZCBrZXJuZWwgcGFyYW1ldGVyIHRvIGNvbnRy
b2wgdXNlIG9mCiBFQ0MvRURDLgoKQWxsb3cgdmFyaW91cyBraW5kcyBvZiBtZW1vcnkgaW50ZWdy
aXR5IG1ldGhvZHMgKGUuZy4gRUNDL0VEQykgdG8gYmUgZW5hYmxlZApvciBkaXNhYmxlZC4gIEJ5
IGRlZmF1bHQsIGFsbCBmZWF0dXJlcyBhcmUgZGlzYWJsZWQuCgpFREMgaXMgRXJyb3IgRGV0ZWN0
aW9uIGFuZCBDb3JyZWN0aW9uLiAgSXQgY2FuIGRldGVjdCBFQ0MgZXJyb3JzIGFuZCBkbyAwIG9y
Cm1vcmUgb2Y6IGNvdW50IFNFQyAoc2luZ2xlIGVycm9yIGNvcnJlY3RlZCkgYW5kIERFRCAoZG91
YmxlIGVycm9yIGRldGVjdGVkLAppLmUuIHVuY29ycmVjdGVkIEVDQyBlcnJvciksIGhhbHQgdGhl
IGFmZmVjdGVkIGJsb2NrLCBpbnRlcnJ1cHQgdGhlIENQVS4KQ3VycmVudGx5LCBvbmx5IGNvdW50
aW5nIGVycm9ycyBpcyBzdXBwb3J0ZWQuCgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBQYW5hcml0aSA8
RGF2aWQuUGFuYXJpdGlAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaCAgICAgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jICB8ICA0ICsrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgICAg
fCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCB8IDE0ICsrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdl
ZCwgNDggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdS5oCmluZGV4IDRhMTZlM2MuLjAzMjIzOTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdS5oCkBAIC0xMTEsNiArMTExLDcgQEAgZXh0ZXJuIGludCBhbWRncHVfcHJpbV9idWZf
cGVyX3NlOwogZXh0ZXJuIGludCBhbWRncHVfcG9zX2J1Zl9wZXJfc2U7CiBleHRlcm4gaW50IGFt
ZGdwdV9jbnRsX3NiX2J1Zl9wZXJfc2U7CiBleHRlcm4gaW50IGFtZGdwdV9wYXJhbV9idWZfcGVy
X3NlOworZXh0ZXJuIHVuc2lnbmVkIGFtZGdwdV9lY2NfZmxhZ3M7CiAKICNkZWZpbmUgQU1ER1BV
X0RFRkFVTFRfR1RUX1NJWkVfTUIJCTMwNzJVTEwgLyogM0dCIGJ5IGRlZmF1bHQgKi8KICNkZWZp
bmUgQU1ER1BVX1dBSVRfSURMRV9USU1FT1VUX0lOX01TCSAgICAgICAgMzAwMApkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCmluZGV4IGVhZDAwZDcuLjAwZTE2YWMgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKQEAgLTExMCw2ICsxMTAsNyBAQCBp
bnQgYW1kZ3B1X3ByaW1fYnVmX3Blcl9zZSA9IDA7CiBpbnQgYW1kZ3B1X3Bvc19idWZfcGVyX3Nl
ID0gMDsKIGludCBhbWRncHVfY250bF9zYl9idWZfcGVyX3NlID0gMDsKIGludCBhbWRncHVfcGFy
YW1fYnVmX3Blcl9zZSA9IDA7Cit1bnNpZ25lZCBhbWRncHVfZWNjX2ZsYWdzID0gMDsKIAogTU9E
VUxFX1BBUk1fREVTQyh2cmFtbGltaXQsICJSZXN0cmljdCBWUkFNIGZvciB0ZXN0aW5nLCBpbiBt
ZWdhYnl0ZXMiKTsKIG1vZHVsZV9wYXJhbV9uYW1lZCh2cmFtbGltaXQsIGFtZGdwdV92cmFtX2xp
bWl0LCBpbnQsIDA2MDApOwpAQCAtMjM1LDYgKzIzNiw5IEBAIG1vZHVsZV9wYXJhbV9uYW1lZChj
bnRsX3NiX2J1Zl9wZXJfc2UsIGFtZGdwdV9jbnRsX3NiX2J1Zl9wZXJfc2UsIGludCwgMDQ0NCk7
CiBNT0RVTEVfUEFSTV9ERVNDKHBhcmFtX2J1Zl9wZXJfc2UsICJ0aGUgc2l6ZSBvZiBPZmYtQ2hp
cCBQcmFtYXRlciBDYWNoZSBwZXIgU2hhZGVyIEVuZ2luZSAoZGVmYXVsdCBkZXBlbmRpbmcgb24g
Z2Z4KSIpOwogbW9kdWxlX3BhcmFtX25hbWVkKHBhcmFtX2J1Zl9wZXJfc2UsIGFtZGdwdV9wYXJh
bV9idWZfcGVyX3NlLCBpbnQsIDA0NDQpOwogCitNT0RVTEVfUEFSTV9ERVNDKGVjY19mbGFncywg
IkVDQy9FREMgZW5hYmxlIGZsYWdzICgwID0gZGlzYWJsZSBFQ0MvRURDIChkZWZhdWx0KSkiKTsK
K21vZHVsZV9wYXJhbV9uYW1lZChlY2NfZmxhZ3MsIGFtZGdwdV9lY2NfZmxhZ3MsIHVpbnQsIDA0
NDQpOworCiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBwY2lpZGxpc3RbXSA9
IHsKICNpZmRlZiAgQ09ORklHX0RSTV9BTURHUFVfU0kKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjhfMC5jCmluZGV4IDJmNWJmNWYuLjA1Y2FiN2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y4XzAuYwpAQCAtMTcwOCw3ICsxNzA4LDcgQEAgc3RhdGljIGludCBnZnhfdjhfMF9l
ZGNfY2xlYXJfY291bnRlcnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQkJCWNvdW50
ID0gUlJFRzMyKGNwLT5ybm1hcF9hZGRyKTsKIAkJCQkJaWYgKGNvdW50ICE9IDApIHsKIAkJCQkJ
CS8qCi0JCQkJCQkgKiBXb3JrYXJvdW5kIGZhaWxlZC4KKwkJCQkJCSAqIEVEQyB3b3JrYXJvdW5k
IGZhaWxlZC4KIAkJCQkJCSAqIElmIHBlb3BsZSBhcmUgaW50ZXJlc3RlZAogCQkJCQkJICogaW4g
RURDIGF0IGFsbCwgdGhleSB3aWxsCiAJCQkJCQkgKiB3YW50IHRvIGtub3cgd2hpY2gKQEAgLTE3
NDcsMTQgKzE3NDcsMjQgQEAgc3RhdGljIGludCBnZnhfdjhfMF9kb19lZGNfZ3ByX3dvcmthcm91
bmRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlyZXR1cm4gMDsKIAl9CiAKLSAgICAg
ICAgRFJNX0lORk8oIkRldGVjdGVkIENhcnJpem8uXG4iKTsKKwlEUk1fSU5GTygiRGV0ZWN0ZWQg
Q2Fycml6by5cbiIpOwogCiAJdG1wID0gUlJFRzMyKG1tQ0NfR0NfRURDX0NPTkZJRyk7CiAJZGlz
X2JpdCA9IFJFR19HRVRfRklFTEQodG1wLCBDQ19HQ19FRENfQ09ORklHLCBESVNfRURDKTsKIAlp
ZiAoZGlzX2JpdCkgewotCQkvKiBPbiBDYXJyaXpvLCBFREMgbWF5IGJlIGRpc2FibGVkIGJ5IGEg
ZnVzZS4gKi8KLQkJRFJNX0lORk8oIkVEQyBoYXJkd2FyZSBpcyBkaXNhYmxlZCwgR0NfRURDX0NP
TkZJRzogMHglMDh4LlxuIiwKLQkJCXRtcCk7CisJCS8qIE9uIENhcnJpem8sIEVEQyBtYXkgYmUg
ZGlzYWJsZWQgcGVybWFuZW50bHkgYnkgYSBmdXNlLiAqLworCQlEUk1fSU5GTygiQ2Fycml6byBF
REMgaGFyZHdhcmUgaXMgZGlzYWJsZWQsIEdDX0VEQ19DT05GSUc6IDB4JTA4eC5cbiIsCisJCQkg
dG1wKTsKKwkJcmV0dXJuIDA7CisJfQorCisJLyoKKwkgKiBDaGVjayBpZiBFREMgaGFzIGJlZW4g
cmVxdWVzdGVkIGJ5IGEga2VybmVsIHBhcmFtZXRlci4KKwkgKiBGb3IgQ2Fycml6bywgRURDIGlz
IHRoZSBiZXN0L3NhZmVzdCBtb2RlIFdSVCBlcnJvciBoYW5kbGluZy4KKwkgKi8KKwlpZiAoIShh
bWRncHVfZWNjX2ZsYWdzCisJICAgICAgJiAoQU1EX0VDQ19TVVBQT1JUX0JFU1QgfCBBTURfRUND
X1NVUFBPUlRfRURDKSkpIHsKKwkJRFJNX0lORk8oIkVEQyBzdXBwb3J0IGhhcyBub3QgYmVlbiBy
ZXF1ZXN0ZWQuXG4iKTsKIAkJcmV0dXJuIDA7CiAJfQogCkBAIC0xODkyLDYgKzE5MDIsMjAgQEAg
c3RhdGljIGludCBnZnhfdjhfMF9kb19lZGNfZ3ByX3dvcmthcm91bmRzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQogCQlnb3RvIGZhaWw7CiAJfQogCisJLyogMDAgLSBHQl9FRENfREVEX01P
REVfTE9HOiBDb3VudCBERUQgZXJyb3JzIGJ1dCBkbyBub3QgaGFsdCAqLworCXRtcCA9IFJFR19T
RVRfRklFTEQodG1wLCBHQl9FRENfTU9ERSwgREVEX01PREUsIDApOworCS8qIERvIG5vdCBwcm9w
YWdhdGUgdGhlIGVycm9ycyB0byB0aGUgbmV4dCBibG9jay4gKi8KKwl0bXAgPSBSRUdfU0VUX0ZJ
RUxEKHRtcCwgR0JfRURDX01PREUsIFBST1BfRkVELCAwKTsKKwlXUkVHMzIobW1HQl9FRENfTU9E
RSwgdG1wKTsKKworCXRtcCA9IFJSRUczMihtbUNDX0dDX0VEQ19DT05GSUcpOworCisJLyoKKwkg
KiBDbGVhciBFRENfRElTQUJMRSBiaXQgc28gdGhlIGNvdW50ZXJzIGFyZSBhdmFpbGFibGUuCisJ
ICovCisJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENDX0dDX0VEQ19DT05GSUcsIERJU19FREMs
IDApOworCVdSRUczMihtbUNDX0dDX0VEQ19DT05GSUcsIHRtcCk7CisKIAlnZnhfdjhfMF9lZGNf
Y2xlYXJfY291bnRlcnMoYWRldik7CiAKIGZhaWw6CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRl
L2FtZF9zaGFyZWQuaAppbmRleCAyY2NmNDRlLi5jNGZkMDEzIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKQEAgLTE3OSw2ICsxNzksMjAgQEAgc3RydWN0IGFtZF9w
cF9wcm9maWxlIHsKICNkZWZpbmUgQU1EX1BHX1NVUFBPUlRfR0ZYX1FVSUNLX01HCQkoMSA8PCAx
MSkKICNkZWZpbmUgQU1EX1BHX1NVUFBPUlRfR0ZYX1BJUEVMSU5FCQkoMSA8PCAxMikKIAorLyoK
KyAqIEVDQyBmbGFncworICogQWxsb3dzIHRoZSB1c2VyIHRvIGNob29zZSB3aGF0IGtpbmQgb2Yg
ZXJyb3IgZGV0ZWN0aW9uL2NvcnJlY3Rpb24gaXMgdXNlZC4KKyAqIEN1cnJlbnRseSwgRURDIGlz
IHN1cHBvcnRlZCBvbiBDYXJyaXpvLgorICoKKyAqIFRoZSBBTURfRUNDX1NVUFBPUlRfQkVTVCBi
aXQgaXMgdXNlZCB0byBhbGxvdyBhIHVzZXIgdG8gaGF2ZSB0aGUgZHJpdmVyCisgKiBzZXQgd2hh
dCBpdCB0aGlua3MgaXMgYmVzdC9zYWZlc3QgbW9kZS4gIFRoaXMgbWF5IG5vdCBiZSB0aGUgc2Ft
ZSBhcyB0aGUKKyAqIGRlZmF1bHQsIGRlcGVuZGluZyBvbiB0aGUgR1BVIGFuZCB0aGUgYXBwbGlj
YXRpb24uCisgKiBVc2luZyBhIHNpbmdsZSBiaXQgbWFrZXMgaXQgZWFzeSB0byByZXF1ZXN0IHRo
ZSBiZXN0IHN1cHBvcnQgd2l0aG91dAorICogbmVlZGluZyB0byBrbm93IGFsbCBjdXJyZW50bHkg
c3VwcG9ydGVkIG1vZGVzLgorICovCisjZGVmaW5lIEFNRF9FQ0NfU1VQUE9SVF9CRVNUCQkJKDEg
PDwgMCkKKyNkZWZpbmUgQU1EX0VDQ19TVVBQT1JUX0VEQwkJCSgxIDw8IDEpCisKIGVudW0gYW1k
X3BtX3N0YXRlX3R5cGUgewogCS8qIG5vdCB1c2VkIGZvciBkcG0gKi8KIAlQT1dFUl9TVEFURV9U
WVBFX0RFRkFVTFQsCi0tIAoyLjcuNAoK

--_004_BN6PR12MB1889CED9632BAE0144E8AE1795100BN6PR12MB1889namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_BN6PR12MB1889CED9632BAE0144E8AE1795100BN6PR12MB1889namp_--
