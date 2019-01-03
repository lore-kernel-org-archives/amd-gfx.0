From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/psp: make get_fw_type and prep_cmd_buf to
 be common interfaces
Date: Thu, 3 Jan 2019 14:50:56 +0000
Message-ID: <DM5PR12MB18201B8A10EA6123CA1F1C19F78D0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1546524044-8359-1-git-send-email-Hawking.Zhang@amd.com>,
 <1546524044-8359-2-git-send-email-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1028011065=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1546524044-8359-2-git-send-email-Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1028011065==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB18201B8A10EA6123CA1F1C19F78D0DM5PR12MB1820namp_"

--_000_DM5PR12MB18201B8A10EA6123CA1F1C19F78D0DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Hawking =
Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, January 3, 2019 9:00:44 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhang, Hawking
Subject: [PATCH 2/2] drm/amdgpu/psp: make get_fw_type and prep_cmd_buf to b=
e common interfaces

get_fw_type and prep_cmd_buf should be common interface
instead of IP specific ones

Change-Id: I115a8d3fafdbe143008b3698ad3a5f3bd4b87481
Signed-off-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 94 +++++++++++++++++++++++++++++=
+++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 --
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c  | 90 -----------------------------=
--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 75 --------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 72 -------------------------
 5 files changed, 93 insertions(+), 241 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 8189a90..53c2d60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -501,6 +501,98 @@ static int psp_hw_start(struct psp_context *psp)
         return 0;
 }

+static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
+                          enum psp_gfx_fw_type *type)
+{
+       switch (ucode->ucode_id) {
+       case AMDGPU_UCODE_ID_SDMA0:
+               *type =3D GFX_FW_TYPE_SDMA0;
+               break;
+       case AMDGPU_UCODE_ID_SDMA1:
+               *type =3D GFX_FW_TYPE_SDMA1;
+               break;
+       case AMDGPU_UCODE_ID_CP_CE:
+               *type =3D GFX_FW_TYPE_CP_CE;
+               break;
+       case AMDGPU_UCODE_ID_CP_PFP:
+               *type =3D GFX_FW_TYPE_CP_PFP;
+               break;
+       case AMDGPU_UCODE_ID_CP_ME:
+               *type =3D GFX_FW_TYPE_CP_ME;
+               break;
+       case AMDGPU_UCODE_ID_CP_MEC1:
+               *type =3D GFX_FW_TYPE_CP_MEC;
+               break;
+       case AMDGPU_UCODE_ID_CP_MEC1_JT:
+               *type =3D GFX_FW_TYPE_CP_MEC_ME1;
+               break;
+       case AMDGPU_UCODE_ID_CP_MEC2:
+               *type =3D GFX_FW_TYPE_CP_MEC;
+               break;
+       case AMDGPU_UCODE_ID_CP_MEC2_JT:
+               *type =3D GFX_FW_TYPE_CP_MEC_ME2;
+               break;
+       case AMDGPU_UCODE_ID_RLC_G:
+               *type =3D GFX_FW_TYPE_RLC_G;
+               break;
+       case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL:
+               *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_CNTL;
+               break;
+       case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM:
+               *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_GPM_MEM;
+               break;
+       case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM:
+               *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_MEM;
+               break;
+       case AMDGPU_UCODE_ID_SMC:
+               *type =3D GFX_FW_TYPE_SMU;
+               break;
+       case AMDGPU_UCODE_ID_UVD:
+               *type =3D GFX_FW_TYPE_UVD;
+               break;
+       case AMDGPU_UCODE_ID_UVD1:
+               *type =3D GFX_FW_TYPE_UVD1;
+               break;
+       case AMDGPU_UCODE_ID_VCE:
+               *type =3D GFX_FW_TYPE_VCE;
+               break;
+       case AMDGPU_UCODE_ID_VCN:
+               *type =3D GFX_FW_TYPE_VCN;
+               break;
+       case AMDGPU_UCODE_ID_DMCU_ERAM:
+               *type =3D GFX_FW_TYPE_DMCU_ERAM;
+               break;
+       case AMDGPU_UCODE_ID_DMCU_INTV:
+               *type =3D GFX_FW_TYPE_DMCU_ISR;
+               break;
+       case AMDGPU_UCODE_ID_MAXIMUM:
+       default:
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
+static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
+                                      struct psp_gfx_cmd_resp *cmd)
+{
+       int ret;
+       uint64_t fw_mem_mc_addr =3D ucode->mc_addr;
+
+       memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
+       cmd->cmd_id =3D GFX_CMD_ID_LOAD_IP_FW;
+       cmd->cmd.cmd_load_ip_fw.fw_phy_addr_lo =3D lower_32_bits(fw_mem_mc_=
addr);
+       cmd->cmd.cmd_load_ip_fw.fw_phy_addr_hi =3D upper_32_bits(fw_mem_mc_=
addr);
+       cmd->cmd.cmd_load_ip_fw.fw_size =3D ucode->ucode_size;
+
+       ret =3D psp_get_fw_type(ucode, &cmd->cmd.cmd_load_ip_fw.fw_type);
+       if (ret)
+               DRM_ERROR("Unknown firmware type\n");
+
+       return ret;
+}
+
 static int psp_np_fw_load(struct psp_context *psp)
 {
         int i, ret;
@@ -522,7 +614,7 @@ static int psp_np_fw_load(struct psp_context *psp)
                         /*skip ucode loading in SRIOV VF */
                         continue;

-               ret =3D psp_prep_cmd_buf(ucode, psp->cmd);
+               ret =3D psp_prep_load_ip_fw_cmd_buf(ucode, psp->cmd);
                 if (ret)
                         return ret;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 3ee573b..2ef98cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -65,8 +65,6 @@ struct psp_funcs
         int (*init_microcode)(struct psp_context *psp);
         int (*bootloader_load_sysdrv)(struct psp_context *psp);
         int (*bootloader_load_sos)(struct psp_context *psp);
-       int (*prep_cmd_buf)(struct amdgpu_firmware_info *ucode,
-                           struct psp_gfx_cmd_resp *cmd);
         int (*ring_init)(struct psp_context *psp, enum psp_ring_type ring_=
type);
         int (*ring_create)(struct psp_context *psp,
                            enum psp_ring_type ring_type);
@@ -176,7 +174,6 @@ struct psp_xgmi_topology_info {
         struct psp_xgmi_node_info       nodes[AMDGPU_XGMI_MAX_CONNECTED_NO=
DES];
 };

-#define psp_prep_cmd_buf(ucode, type) (psp)->funcs->prep_cmd_buf((ucode), =
(type))
 #define psp_ring_init(psp, type) (psp)->funcs->ring_init((psp), (type))
 #define psp_ring_create(psp, type) (psp)->funcs->ring_create((psp), (type)=
)
 #define psp_ring_stop(psp, type) (psp)->funcs->ring_stop((psp), (type))
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c
index f2e937a9..77c2bc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -38,75 +38,6 @@ MODULE_FIRMWARE("amdgpu/raven_asd.bin");
 MODULE_FIRMWARE("amdgpu/picasso_asd.bin");
 MODULE_FIRMWARE("amdgpu/raven2_asd.bin");

-static int
-psp_v10_0_get_fw_type(struct amdgpu_firmware_info *ucode, enum psp_gfx_fw_=
type *type)
-{
-       switch(ucode->ucode_id) {
-       case AMDGPU_UCODE_ID_SDMA0:
-               *type =3D GFX_FW_TYPE_SDMA0;
-               break;
-       case AMDGPU_UCODE_ID_SDMA1:
-               *type =3D GFX_FW_TYPE_SDMA1;
-               break;
-       case AMDGPU_UCODE_ID_CP_CE:
-               *type =3D GFX_FW_TYPE_CP_CE;
-               break;
-       case AMDGPU_UCODE_ID_CP_PFP:
-               *type =3D GFX_FW_TYPE_CP_PFP;
-               break;
-       case AMDGPU_UCODE_ID_CP_ME:
-               *type =3D GFX_FW_TYPE_CP_ME;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC1:
-               *type =3D GFX_FW_TYPE_CP_MEC;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC1_JT:
-               *type =3D GFX_FW_TYPE_CP_MEC_ME1;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC2:
-               *type =3D GFX_FW_TYPE_CP_MEC;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC2_JT:
-               *type =3D GFX_FW_TYPE_CP_MEC_ME2;
-               break;
-       case AMDGPU_UCODE_ID_RLC_G:
-               *type =3D GFX_FW_TYPE_RLC_G;
-               break;
-       case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL:
-               *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_CNTL;
-               break;
-       case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM:
-               *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_GPM_MEM;
-               break;
-       case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM:
-               *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_MEM;
-               break;
-       case AMDGPU_UCODE_ID_SMC:
-               *type =3D GFX_FW_TYPE_SMU;
-               break;
-       case AMDGPU_UCODE_ID_UVD:
-               *type =3D GFX_FW_TYPE_UVD;
-               break;
-       case AMDGPU_UCODE_ID_VCE:
-               *type =3D GFX_FW_TYPE_VCE;
-               break;
-       case AMDGPU_UCODE_ID_VCN:
-               *type =3D GFX_FW_TYPE_VCN;
-               break;
-       case AMDGPU_UCODE_ID_DMCU_ERAM:
-               *type =3D GFX_FW_TYPE_DMCU_ERAM;
-               break;
-       case AMDGPU_UCODE_ID_DMCU_INTV:
-               *type =3D GFX_FW_TYPE_DMCU_ISR;
-               break;
-       case AMDGPU_UCODE_ID_MAXIMUM:
-       default:
-               return -EINVAL;
-       }
-
-       return 0;
-}
-
 static int psp_v10_0_init_microcode(struct psp_context *psp)
 {
         struct amdgpu_device *adev =3D psp->adev;
@@ -158,26 +89,6 @@ static int psp_v10_0_init_microcode(struct psp_context =
*psp)
         return err;
 }

-static int psp_v10_0_prep_cmd_buf(struct amdgpu_firmware_info *ucode,
-                                 struct psp_gfx_cmd_resp *cmd)
-{
-       int ret;
-       uint64_t fw_mem_mc_addr =3D ucode->mc_addr;
-
-       memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
-
-       cmd->cmd_id =3D GFX_CMD_ID_LOAD_IP_FW;
-       cmd->cmd.cmd_load_ip_fw.fw_phy_addr_lo =3D lower_32_bits(fw_mem_mc_=
addr);
-       cmd->cmd.cmd_load_ip_fw.fw_phy_addr_hi =3D upper_32_bits(fw_mem_mc_=
addr);
-       cmd->cmd.cmd_load_ip_fw.fw_size =3D ucode->ucode_size;
-
-       ret =3D psp_v10_0_get_fw_type(ucode, &cmd->cmd.cmd_load_ip_fw.fw_ty=
pe);
-       if (ret)
-               DRM_ERROR("Unknown firmware type\n");
-
-       return ret;
-}
-
 static int psp_v10_0_ring_init(struct psp_context *psp,
                                enum psp_ring_type ring_type)
 {
@@ -454,7 +365,6 @@ static int psp_v10_0_mode1_reset(struct psp_context *ps=
p)

 static const struct psp_funcs psp_v10_0_funcs =3D {
         .init_microcode =3D psp_v10_0_init_microcode,
-       .prep_cmd_buf =3D psp_v10_0_prep_cmd_buf,
         .ring_init =3D psp_v10_0_ring_init,
         .ring_create =3D psp_v10_0_ring_create,
         .ring_stop =3D psp_v10_0_ring_stop,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index 0c6e7f9..f71384b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -40,60 +40,6 @@ MODULE_FIRMWARE("amdgpu/vega20_ta.bin");
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS           0x3010024

-static int
-psp_v11_0_get_fw_type(struct amdgpu_firmware_info *ucode, enum psp_gfx_fw_=
type *type)
-{
-       switch (ucode->ucode_id) {
-       case AMDGPU_UCODE_ID_SDMA0:
-               *type =3D GFX_FW_TYPE_SDMA0;
-               break;
-       case AMDGPU_UCODE_ID_SDMA1:
-               *type =3D GFX_FW_TYPE_SDMA1;
-               break;
-       case AMDGPU_UCODE_ID_CP_CE:
-               *type =3D GFX_FW_TYPE_CP_CE;
-               break;
-       case AMDGPU_UCODE_ID_CP_PFP:
-               *type =3D GFX_FW_TYPE_CP_PFP;
-               break;
-       case AMDGPU_UCODE_ID_CP_ME:
-               *type =3D GFX_FW_TYPE_CP_ME;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC1:
-               *type =3D GFX_FW_TYPE_CP_MEC;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC1_JT:
-               *type =3D GFX_FW_TYPE_CP_MEC_ME1;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC2:
-               *type =3D GFX_FW_TYPE_CP_MEC;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC2_JT:
-               *type =3D GFX_FW_TYPE_CP_MEC_ME2;
-               break;
-       case AMDGPU_UCODE_ID_RLC_G:
-               *type =3D GFX_FW_TYPE_RLC_G;
-               break;
-       case AMDGPU_UCODE_ID_SMC:
-               *type =3D GFX_FW_TYPE_SMU;
-               break;
-       case AMDGPU_UCODE_ID_UVD:
-               *type =3D GFX_FW_TYPE_UVD;
-               break;
-       case AMDGPU_UCODE_ID_VCE:
-               *type =3D GFX_FW_TYPE_VCE;
-               break;
-       case AMDGPU_UCODE_ID_UVD1:
-               *type =3D GFX_FW_TYPE_UVD1;
-               break;
-       case AMDGPU_UCODE_ID_MAXIMUM:
-       default:
-               return -EINVAL;
-       }
-
-       return 0;
-}
-
 static int psp_v11_0_init_microcode(struct psp_context *psp)
 {
         struct amdgpu_device *adev =3D psp->adev;
@@ -267,26 +213,6 @@ static int psp_v11_0_bootloader_load_sos(struct psp_co=
ntext *psp)
         return ret;
 }

-static int psp_v11_0_prep_cmd_buf(struct amdgpu_firmware_info *ucode,
-                                struct psp_gfx_cmd_resp *cmd)
-{
-       int ret;
-       uint64_t fw_mem_mc_addr =3D ucode->mc_addr;
-
-       memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
-
-       cmd->cmd_id =3D GFX_CMD_ID_LOAD_IP_FW;
-       cmd->cmd.cmd_load_ip_fw.fw_phy_addr_lo =3D lower_32_bits(fw_mem_mc_=
addr);
-       cmd->cmd.cmd_load_ip_fw.fw_phy_addr_hi =3D upper_32_bits(fw_mem_mc_=
addr);
-       cmd->cmd.cmd_load_ip_fw.fw_size =3D ucode->ucode_size;
-
-       ret =3D psp_v11_0_get_fw_type(ucode, &cmd->cmd.cmd_load_ip_fw.fw_ty=
pe);
-       if (ret)
-               DRM_ERROR("Unknown firmware type\n");
-
-       return ret;
-}
-
 static int psp_v11_0_ring_init(struct psp_context *psp,
                               enum psp_ring_type ring_type)
 {
@@ -753,7 +679,6 @@ static const struct psp_funcs psp_v11_0_funcs =3D {
         .init_microcode =3D psp_v11_0_init_microcode,
         .bootloader_load_sysdrv =3D psp_v11_0_bootloader_load_sysdrv,
         .bootloader_load_sos =3D psp_v11_0_bootloader_load_sos,
-       .prep_cmd_buf =3D psp_v11_0_prep_cmd_buf,
         .ring_init =3D psp_v11_0_ring_init,
         .ring_create =3D psp_v11_0_ring_create,
         .ring_stop =3D psp_v11_0_ring_stop,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.c
index 79694ff..c63de94 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -47,57 +47,6 @@ MODULE_FIRMWARE("amdgpu/vega12_asd.bin");

 static uint32_t sos_old_versions[] =3D {1517616, 1510592, 1448594, 1446554=
};

-static int
-psp_v3_1_get_fw_type(struct amdgpu_firmware_info *ucode, enum psp_gfx_fw_t=
ype *type)
-{
-       switch(ucode->ucode_id) {
-       case AMDGPU_UCODE_ID_SDMA0:
-               *type =3D GFX_FW_TYPE_SDMA0;
-               break;
-       case AMDGPU_UCODE_ID_SDMA1:
-               *type =3D GFX_FW_TYPE_SDMA1;
-               break;
-       case AMDGPU_UCODE_ID_CP_CE:
-               *type =3D GFX_FW_TYPE_CP_CE;
-               break;
-       case AMDGPU_UCODE_ID_CP_PFP:
-               *type =3D GFX_FW_TYPE_CP_PFP;
-               break;
-       case AMDGPU_UCODE_ID_CP_ME:
-               *type =3D GFX_FW_TYPE_CP_ME;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC1:
-               *type =3D GFX_FW_TYPE_CP_MEC;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC1_JT:
-               *type =3D GFX_FW_TYPE_CP_MEC_ME1;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC2:
-               *type =3D GFX_FW_TYPE_CP_MEC;
-               break;
-       case AMDGPU_UCODE_ID_CP_MEC2_JT:
-               *type =3D GFX_FW_TYPE_CP_MEC_ME2;
-               break;
-       case AMDGPU_UCODE_ID_RLC_G:
-               *type =3D GFX_FW_TYPE_RLC_G;
-               break;
-       case AMDGPU_UCODE_ID_SMC:
-               *type =3D GFX_FW_TYPE_SMU;
-               break;
-       case AMDGPU_UCODE_ID_UVD:
-               *type =3D GFX_FW_TYPE_UVD;
-               break;
-       case AMDGPU_UCODE_ID_VCE:
-               *type =3D GFX_FW_TYPE_VCE;
-               break;
-       case AMDGPU_UCODE_ID_MAXIMUM:
-       default:
-               return -EINVAL;
-       }
-
-       return 0;
-}
-
 static int psp_v3_1_init_microcode(struct psp_context *psp)
 {
         struct amdgpu_device *adev =3D psp->adev;
@@ -277,26 +226,6 @@ static int psp_v3_1_bootloader_load_sos(struct psp_con=
text *psp)
         return ret;
 }

-static int psp_v3_1_prep_cmd_buf(struct amdgpu_firmware_info *ucode,
-                                struct psp_gfx_cmd_resp *cmd)
-{
-       int ret;
-       uint64_t fw_mem_mc_addr =3D ucode->mc_addr;
-
-       memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
-
-       cmd->cmd_id =3D GFX_CMD_ID_LOAD_IP_FW;
-       cmd->cmd.cmd_load_ip_fw.fw_phy_addr_lo =3D lower_32_bits(fw_mem_mc_=
addr);
-       cmd->cmd.cmd_load_ip_fw.fw_phy_addr_hi =3D upper_32_bits(fw_mem_mc_=
addr);
-       cmd->cmd.cmd_load_ip_fw.fw_size =3D ucode->ucode_size;
-
-       ret =3D psp_v3_1_get_fw_type(ucode, &cmd->cmd.cmd_load_ip_fw.fw_typ=
e);
-       if (ret)
-               DRM_ERROR("Unknown firmware type\n");
-
-       return ret;
-}
-
 static int psp_v3_1_ring_init(struct psp_context *psp,
                               enum psp_ring_type ring_type)
 {
@@ -615,7 +544,6 @@ static const struct psp_funcs psp_v3_1_funcs =3D {
         .init_microcode =3D psp_v3_1_init_microcode,
         .bootloader_load_sysdrv =3D psp_v3_1_bootloader_load_sysdrv,
         .bootloader_load_sos =3D psp_v3_1_bootloader_load_sos,
-       .prep_cmd_buf =3D psp_v3_1_prep_cmd_buf,
         .ring_init =3D psp_v3_1_ring_init,
         .ring_create =3D psp_v3_1_ring_create,
         .ring_stop =3D psp_v3_1_ring_stop,
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB18201B8A10EA6123CA1F1C19F78D0DM5PR12MB1820namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Hawking Zhang &lt;Hawking.Zha=
ng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, January 3, 2019 9:00:44 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhang, Hawking<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu/psp: make get_fw_type and prep_cmd_b=
uf to be common interfaces</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">get_fw_type and prep_cmd_buf should be common inte=
rface<br>
instead of IP specific ones<br>
<br>
Change-Id: I115a8d3fafdbe143008b3698ad3a5f3bd4b87481<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 94 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |&nbsp; 3 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v10_0.c&nbsp; | 90 -------------------=
------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v11_0.c&nbsp; | 75 -------------------=
-------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v3_1.c&nbsp;&nbsp; | 72 --------------=
-----------<br>
&nbsp;5 files changed, 93 insertions(&#43;), 241 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 8189a90..53c2d60 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -501,6 &#43;501,98 @@ static int psp_hw_start(struct psp_context *psp)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; enum psp_gfx_fw_type *type)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ucode-&gt;ucode_id) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA0:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_SDMA0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA1:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_SDMA1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_CE:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_CP_CE;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_PFP:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_CP_PFP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_ME:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_CP_ME;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC1:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC1_JT:<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC_ME1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC2:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC2_JT:<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC_ME2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_G:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_RLC_G;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_RESTORE_=
LIST_CNTL:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_CNTL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_RESTORE_=
LIST_GPM_MEM:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_GPM_MEM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_RESTORE_=
LIST_SRM_MEM:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_MEM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SMC:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_SMU;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_UVD:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_UVD;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_UVD1:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_UVD1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_VCE:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_VCE;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_VCN:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_VCN;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_DMCU_ERAM:<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_DMCU_ERAM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_DMCU_INTV:<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_DMCU_ISR;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_MAXIMUM:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *uc=
ode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; struct psp_gfx_cmd_resp *cmd)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t fw_mem_mc_addr =3D ucode=
-&gt;mc_addr;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_=
gfx_cmd_resp));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_LOA=
D_IP_FW;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_phy=
_addr_lo =3D lower_32_bits(fw_mem_mc_addr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_phy=
_addr_hi =3D upper_32_bits(fw_mem_mc_addr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_siz=
e =3D ucode-&gt;ucode_size;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_get_fw_type(ucode, &a=
mp;cmd-&gt;cmd.cmd_load_ip_fw.fw_type);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_ERROR(&quot;Unknown firmware type\n&quot;);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int psp_np_fw_load(struct psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret;<br>
@@ -522,7 &#43;614,7 @@ static int psp_np_fw_load(struct psp_context *psp)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*ski=
p ucode loading in SRIOV VF */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_prep_cmd_buf(ucode, psp-&gt;cmd);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D psp_prep_load_ip_fw_cmd_buf(ucode, psp-&gt;cmd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h<br>
index 3ee573b..2ef98cc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
@@ -65,8 &#43;65,6 @@ struct psp_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*init_microcode)(stru=
ct psp_context *psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*bootloader_load_sysd=
rv)(struct psp_context *psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*bootloader_load_sos)=
(struct psp_context *psp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*prep_cmd_buf)(struct amdgpu_fir=
mware_info *ucode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct psp_gfx_cmd_resp *cmd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*ring_init)(struct ps=
p_context *psp, enum psp_ring_type ring_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*ring_create)(struct =
psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; enum psp_ring_type ring_type);<br>
@@ -176,7 &#43;174,6 @@ struct psp_xgmi_topology_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_xgmi_node_info&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nodes[AMDGPU_XGMI_MAX_CONNECTED_NODES];=
<br>
&nbsp;};<br>
&nbsp;<br>
-#define psp_prep_cmd_buf(ucode, type) (psp)-&gt;funcs-&gt;prep_cmd_buf((uc=
ode), (type))<br>
&nbsp;#define psp_ring_init(psp, type) (psp)-&gt;funcs-&gt;ring_init((psp),=
 (type))<br>
&nbsp;#define psp_ring_create(psp, type) (psp)-&gt;funcs-&gt;ring_create((p=
sp), (type))<br>
&nbsp;#define psp_ring_stop(psp, type) (psp)-&gt;funcs-&gt;ring_stop((psp),=
 (type))<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c<br>
index f2e937a9..77c2bc3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
@@ -38,75 &#43;38,6 @@ MODULE_FIRMWARE(&quot;amdgpu/raven_asd.bin&quot;);<b=
r>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/picasso_asd.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/raven2_asd.bin&quot;);<br>
&nbsp;<br>
-static int<br>
-psp_v10_0_get_fw_type(struct amdgpu_firmware_info *ucode, enum psp_gfx_fw_=
type *type)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch(ucode-&gt;ucode_id) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_SDMA0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_SDMA1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_CE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_CE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_PFP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_PFP;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_ME:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_ME;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC1_JT:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC_ME1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC2_JT:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC_ME2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_G:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_RLC_G;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_RESTORE_LIST=
_CNTL:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_CNTL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_RESTORE_LIST=
_GPM_MEM:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_GPM_MEM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_RESTORE_LIST=
_SRM_MEM:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_MEM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SMC:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_SMU;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_UVD:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_UVD;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_VCE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_VCE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_VCN:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_VCN;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_DMCU_ERAM:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_DMCU_ERAM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_DMCU_INTV:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_DMCU_ISR;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_MAXIMUM:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int psp_v10_0_init_microcode(struct psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
@@ -158,26 &#43;89,6 @@ static int psp_v10_0_init_microcode(struct psp_cont=
ext *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;}<br>
&nbsp;<br>
-static int psp_v10_0_prep_cmd_buf(struct amdgpu_firmware_info *ucode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd)<b=
r>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t fw_mem_mc_addr =3D ucode-&gt=
;mc_addr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_=
cmd_resp));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_LOAD_IP=
_FW;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_phy_add=
r_lo =3D lower_32_bits(fw_mem_mc_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_phy_add=
r_hi =3D upper_32_bits(fw_mem_mc_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_size =
=3D ucode-&gt;ucode_size;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_v10_0_get_fw_type(ucode, =
&amp;cmd-&gt;cmd.cmd_load_ip_fw.fw_type);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Unknown firmware type\n&quot;);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
&nbsp;static int psp_v10_0_ring_init(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum psp_ring_type ring_type)<br>
&nbsp;{<br>
@@ -454,7 &#43;365,6 @@ static int psp_v10_0_mode1_reset(struct psp_context=
 *psp)<br>
&nbsp;<br>
&nbsp;static const struct psp_funcs psp_v10_0_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_microcode =3D psp_v1=
0_0_init_microcode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .prep_cmd_buf =3D psp_v10_0_prep_cmd_=
buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ring_init =3D psp_v10_0_r=
ing_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ring_create =3D psp_v10_0=
_ring_create,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ring_stop =3D psp_v10_0_r=
ing_stop,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c<br>
index 0c6e7f9..f71384b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
@@ -40,60 &#43;40,6 @@ MODULE_FIRMWARE(&quot;amdgpu/vega20_ta.bin&quot;);<b=
r>
&nbsp;/* address block */<br>
&nbsp;#define smnMP1_FIRMWARE_FLAGS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x3010024<br>
&nbsp;<br>
-static int<br>
-psp_v11_0_get_fw_type(struct amdgpu_firmware_info *ucode, enum psp_gfx_fw_=
type *type)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ucode-&gt;ucode_id) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_SDMA0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_SDMA1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_CE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_CE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_PFP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_PFP;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_ME:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_ME;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC1_JT:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC_ME1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC2_JT:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC_ME2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_G:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_RLC_G;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SMC:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_SMU;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_UVD:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_UVD;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_VCE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_VCE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_UVD1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_UVD1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_MAXIMUM:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int psp_v11_0_init_microcode(struct psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
@@ -267,26 &#43;213,6 @@ static int psp_v11_0_bootloader_load_sos(struct ps=
p_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int psp_v11_0_prep_cmd_buf(struct amdgpu_firmware_info *ucode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t fw_mem_mc_addr =3D ucode-&gt=
;mc_addr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_=
cmd_resp));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_LOAD_IP=
_FW;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_phy_add=
r_lo =3D lower_32_bits(fw_mem_mc_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_phy_add=
r_hi =3D upper_32_bits(fw_mem_mc_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_size =
=3D ucode-&gt;ucode_size;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_v11_0_get_fw_type(ucode, =
&amp;cmd-&gt;cmd.cmd_load_ip_fw.fw_type);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Unknown firmware type\n&quot;);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
&nbsp;static int psp_v11_0_ring_init(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum psp_ring_type ring_type)<br>
&nbsp;{<br>
@@ -753,7 &#43;679,6 @@ static const struct psp_funcs psp_v11_0_funcs =3D {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_microcode =3D psp_v1=
1_0_init_microcode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bootloader_load_sysdrv =
=3D psp_v11_0_bootloader_load_sysdrv,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bootloader_load_sos =3D p=
sp_v11_0_bootloader_load_sos,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .prep_cmd_buf =3D psp_v11_0_prep_cmd_=
buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ring_init =3D psp_v11_0_r=
ing_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ring_create =3D psp_v11_0=
_ring_create,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ring_stop =3D psp_v11_0_r=
ing_stop,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.c<br>
index 79694ff..c63de94 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c<br>
@@ -47,57 &#43;47,6 @@ MODULE_FIRMWARE(&quot;amdgpu/vega12_asd.bin&quot;);<=
br>
&nbsp;<br>
&nbsp;static uint32_t sos_old_versions[] =3D {1517616, 1510592, 1448594, 14=
46554};<br>
&nbsp;<br>
-static int<br>
-psp_v3_1_get_fw_type(struct amdgpu_firmware_info *ucode, enum psp_gfx_fw_t=
ype *type)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch(ucode-&gt;ucode_id) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_SDMA0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_SDMA1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_CE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_CE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_PFP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_PFP;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_ME:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_ME;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC1_JT:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC_ME1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC2_JT:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_CP_MEC_ME2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_G:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_RLC_G;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SMC:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_SMU;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_UVD:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_UVD;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_VCE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *type =3D GFX_FW_TYPE_VCE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_MAXIMUM:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int psp_v3_1_init_microcode(struct psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
@@ -277,26 &#43;226,6 @@ static int psp_v3_1_bootloader_load_sos(struct psp=
_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int psp_v3_1_prep_cmd_buf(struct amdgpu_firmware_info *ucode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t fw_mem_mc_addr =3D ucode-&gt=
;mc_addr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(cmd, 0, sizeof(struct psp_gfx_=
cmd_resp));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd_id =3D GFX_CMD_ID_LOAD_IP=
_FW;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_phy_add=
r_lo =3D lower_32_bits(fw_mem_mc_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_phy_add=
r_hi =3D upper_32_bits(fw_mem_mc_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_load_ip_fw.fw_size =
=3D ucode-&gt;ucode_size;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_v3_1_get_fw_type(ucode, &=
amp;cmd-&gt;cmd.cmd_load_ip_fw.fw_type);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Unknown firmware type\n&quot;);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
&nbsp;static int psp_v3_1_ring_init(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum psp_ring_type ring_type)<br>
&nbsp;{<br>
@@ -615,7 &#43;544,6 @@ static const struct psp_funcs psp_v3_1_funcs =3D {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_microcode =3D psp_v3=
_1_init_microcode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bootloader_load_sysdrv =
=3D psp_v3_1_bootloader_load_sysdrv,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bootloader_load_sos =3D p=
sp_v3_1_bootloader_load_sos,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .prep_cmd_buf =3D psp_v3_1_prep_cmd_b=
uf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ring_init =3D psp_v3_1_ri=
ng_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ring_create =3D psp_v3_1_=
ring_create,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ring_stop =3D psp_v3_1_ri=
ng_stop,<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB18201B8A10EA6123CA1F1C19F78D0DM5PR12MB1820namp_--

--===============1028011065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1028011065==--
