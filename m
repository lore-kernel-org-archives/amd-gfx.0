From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: De-numberify golden SI registers
Date: Fri, 16 Dec 2016 15:04:39 +0000
Message-ID: <CY4PR12MB17685A0FE018598D10CCA849F79C0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20161216135001.5735-1-tom.stdenis@amd.com>,
 <e7cd0847-f1eb-b28d-1138-f015eadcbe35@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_CY4PR12MB17685A0FE018598D10CCA849F79C0CY4PR12MB1768namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e7cd0847-f1eb-b28d-1138-f015eadcbe35-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--_004_CY4PR12MB17685A0FE018598D10CCA849F79C0CY4PR12MB1768namp_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB17685A0FE018598D10CCA849F79C0CY4PR12MB1768namp_"

--_000_CY4PR12MB17685A0FE018598D10CCA849F79C0CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

umr + script (attached).


You'll need a relatively new build of umr (on master) that supports forcing=
 an asic by name then you use this as


unnum.sh <asic_name>

<paste_lines_of_golden_data>

<hit CTRL+D>


then it spits out the new lines replacing things with registers where found=
.


It'd in theory work with vega10/etc once I add one last commit to the amd-t=
emp-soc15 branch.


Cheers,

Tom


________________________________
From: Wentland, Harry
Sent: Friday, December 16, 2016 10:02
To: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: Re: [PATCH] drm/amd/amdgpu: De-numberify golden SI registers

Nice. Do you have a script to do this or is this all done by hand?

Reviewed-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

Harry

On 2016-12-16 08:50 AM, Tom St Denis wrote:
> Where possible replace numeric constants in the table
> with their register names.
>
> Compile tested + executed on a Tahiti.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/si.c | 975 ++++++++++++++++++++--------------=
------
>  1 file changed, 492 insertions(+), 483 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu=
/si.c
> index c46b0159007d..9bf7afb2f74e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -40,337 +40,343 @@
>  #include "dce_v6_0.h"
>  #include "si.h"
>  #include "dce_virtual.h"
> +#include "gca/gfx_6_0_d.h"
> +#include "oss/oss_1_0_d.h"
> +#include "gmc/gmc_6_0_d.h"
> +#include "dce/dce_6_0_d.h"
> +#include "uvd/uvd_4_0_d.h"
>
>  static const u32 tahiti_golden_registers[] =3D
>  {
> -     0x17bc, 0x00000030, 0x00000011,
> -     0x2684, 0x00010000, 0x00018208,
> -     0x260c, 0xffffffff, 0x00000000,
> -     0x260d, 0xf00fffff, 0x00000400,
> -     0x260e, 0x0002021c, 0x00020200,
> -     0x031e, 0x00000080, 0x00000000,
> +     mmAZALIA_SCLK_CONTROL, 0x00000030, 0x00000011,
> +     mmCB_HW_CONTROL, 0x00010000, 0x00018208,
> +     mmDB_DEBUG, 0xffffffff, 0x00000000,
> +     mmDB_DEBUG2, 0xf00fffff, 0x00000400,
> +     mmDB_DEBUG3, 0x0002021c, 0x00020200,
> +     mmDCI_CLK_CNTL, 0x00000080, 0x00000000,
>        0x340c, 0x000000c0, 0x00800040,
>        0x360c, 0x000000c0, 0x00800040,
> -     0x16ec, 0x000000f0, 0x00000070,
> -     0x16f0, 0x00200000, 0x50100000,
> -     0x1c0c, 0x31000311, 0x00000011,
> -     0x09df, 0x00000003, 0x000007ff,
> -     0x0903, 0x000007ff, 0x00000000,
> -     0x2285, 0xf000001f, 0x00000007,
> -     0x22c9, 0xffffffff, 0x00ffffff,
> -     0x22c4, 0x0000ff0f, 0x00000000,
> -     0xa293, 0x07ffffff, 0x4e000000,
> -     0xa0d4, 0x3f3f3fff, 0x2a00126a,
> +     mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070,
> +     mmFBC_MISC, 0x00200000, 0x50100000,
> +     mmDIG0_HDMI_CONTROL, 0x31000311, 0x00000011,
> +     mmMC_ARB_WTM_CNTL_RD, 0x00000003, 0x000007ff,
> +     mmMC_XPB_P2P_BAR_CFG, 0x000007ff, 0x00000000,
> +     mmPA_CL_ENHANCE, 0xf000001f, 0x00000007,
> +     mmPA_SC_FORCE_EOV_MAX_CNTS, 0xffffffff, 0x00ffffff,
> +     mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000,
> +     mmPA_SC_MODE_CNTL_1, 0x07ffffff, 0x4e000000,
> +     mmPA_SC_RASTER_CONFIG, 0x3f3f3fff, 0x2a00126a,
>        0x000c, 0xffffffff, 0x0040,
>        0x000d, 0x00000040, 0x00004040,
> -     0x2440, 0x07ffffff, 0x03000000,
> -     0x23a2, 0x01ff1f3f, 0x00000000,
> -     0x23a1, 0x01ff1f3f, 0x00000000,
> -     0x2418, 0x0000007f, 0x00000020,
> -     0x2542, 0x00010000, 0x00010000,
> -     0x2b05, 0x00000200, 0x000002fb,
> -     0x2b04, 0xffffffff, 0x0000543b,
> -     0x2b03, 0xffffffff, 0xa9210876,
> -     0x2234, 0xffffffff, 0x000fff40,
> -     0x2235, 0x0000001f, 0x00000010,
> -     0x0504, 0x20000000, 0x20fffed8,
> -     0x0570, 0x000c0fc0, 0x000c0400,
> -     0x052c, 0x0fffffff, 0xffffffff,
> -     0x052d, 0x0fffffff, 0x0fffffff,
> -     0x052e, 0x0fffffff, 0x0fffffff,
> -     0x052f, 0x0fffffff, 0x0fffffff
> +     mmSPI_CONFIG_CNTL, 0x07ffffff, 0x03000000,
> +     mmSQ_DED_CNT, 0x01ff1f3f, 0x00000000,
> +     mmSQ_SEC_CNT, 0x01ff1f3f, 0x00000000,
> +     mmSX_DEBUG_1, 0x0000007f, 0x00000020,
> +     mmTA_CNTL_AUX, 0x00010000, 0x00010000,
> +     mmTCP_ADDR_CONFIG, 0x00000200, 0x000002fb,
> +     mmTCP_CHAN_STEER_HI, 0xffffffff, 0x0000543b,
> +     mmTCP_CHAN_STEER_LO, 0xffffffff, 0xa9210876,
> +     mmVGT_FIFO_DEPTHS, 0xffffffff, 0x000fff40,
> +     mmVGT_GS_VERTEX_REUSE, 0x0000001f, 0x00000010,
> +     mmVM_CONTEXT0_CNTL, 0x20000000, 0x20fffed8,
> +     mmVM_L2_CG, 0x000c0fc0, 0x000c0400,
> +     mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff, 0xffffffff,
> +     mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff, 0x0fffffff,
> +     mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff, 0x0fffffff,
> +     mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff, 0x0fffffff,
>  };
>
>  static const u32 tahiti_golden_registers2[] =3D
>  {
> -     0x0319, 0x00000001, 0x00000001
> +     mmMCIF_MEM_CONTROL, 0x00000001, 0x00000001,
>  };
>
>  static const u32 tahiti_golden_rlc_registers[] =3D
>  {
> -     0x263e, 0xffffffff, 0x12011003,
> -     0x3109, 0xffffffff, 0x00601005,
> +     mmGB_ADDR_CONFIG, 0xffffffff, 0x12011003,
> +     mmRLC_LB_PARAMS, 0xffffffff, 0x00601005,
>        0x311f, 0xffffffff, 0x10104040,
>        0x3122, 0xffffffff, 0x0100000a,
> -     0x30c5, 0xffffffff, 0x00000800,
> -     0x30c3, 0xffffffff, 0x800000f4,
> -     0x3d2a, 0x00000008, 0x00000000
> +     mmRLC_LB_CNTR_MAX, 0xffffffff, 0x00000800,
> +     mmRLC_LB_CNTL, 0xffffffff, 0x800000f4,
> +     mmUVD_CGC_GATE, 0x00000008, 0x00000000,
>  };
>
>  static const u32 pitcairn_golden_registers[] =3D
>  {
> -     0x17bc, 0x00000030, 0x00000011,
> -     0x2684, 0x00010000, 0x00018208,
> -     0x260c, 0xffffffff, 0x00000000,
> -     0x260d, 0xf00fffff, 0x00000400,
> -     0x260e, 0x0002021c, 0x00020200,
> -     0x031e, 0x00000080, 0x00000000,
> +     mmAZALIA_SCLK_CONTROL, 0x00000030, 0x00000011,
> +     mmCB_HW_CONTROL, 0x00010000, 0x00018208,
> +     mmDB_DEBUG, 0xffffffff, 0x00000000,
> +     mmDB_DEBUG2, 0xf00fffff, 0x00000400,
> +     mmDB_DEBUG3, 0x0002021c, 0x00020200,
> +     mmDCI_CLK_CNTL, 0x00000080, 0x00000000,
>        0x340c, 0x000300c0, 0x00800040,
>        0x360c, 0x000300c0, 0x00800040,
> -     0x16ec, 0x000000f0, 0x00000070,
> -     0x16f0, 0x00200000, 0x50100000,
> -     0x1c0c, 0x31000311, 0x00000011,
> -     0x0ab9, 0x00073ffe, 0x000022a2,
> -     0x0903, 0x000007ff, 0x00000000,
> -     0x2285, 0xf000001f, 0x00000007,
> -     0x22c9, 0xffffffff, 0x00ffffff,
> -     0x22c4, 0x0000ff0f, 0x00000000,
> -     0xa293, 0x07ffffff, 0x4e000000,
> -     0xa0d4, 0x3f3f3fff, 0x2a00126a,
> +     mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070,
> +     mmFBC_MISC, 0x00200000, 0x50100000,
> +     mmDIG0_HDMI_CONTROL, 0x31000311, 0x00000011,
> +     mmMC_SEQ_PMG_PG_HWCNTL, 0x00073ffe, 0x000022a2,
> +     mmMC_XPB_P2P_BAR_CFG, 0x000007ff, 0x00000000,
> +     mmPA_CL_ENHANCE, 0xf000001f, 0x00000007,
> +     mmPA_SC_FORCE_EOV_MAX_CNTS, 0xffffffff, 0x00ffffff,
> +     mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000,
> +     mmPA_SC_MODE_CNTL_1, 0x07ffffff, 0x4e000000,
> +     mmPA_SC_RASTER_CONFIG, 0x3f3f3fff, 0x2a00126a,
>        0x000c, 0xffffffff, 0x0040,
>        0x000d, 0x00000040, 0x00004040,
> -     0x2440, 0x07ffffff, 0x03000000,
> -     0x2418, 0x0000007f, 0x00000020,
> -     0x2542, 0x00010000, 0x00010000,
> -     0x2b05, 0x000003ff, 0x000000f7,
> -     0x2b04, 0xffffffff, 0x00000000,
> -     0x2b03, 0xffffffff, 0x32761054,
> -     0x2235, 0x0000001f, 0x00000010,
> -     0x0570, 0x000c0fc0, 0x000c0400,
> -     0x052c, 0x0fffffff, 0xffffffff,
> -     0x052d, 0x0fffffff, 0x0fffffff,
> -     0x052e, 0x0fffffff, 0x0fffffff,
> -     0x052f, 0x0fffffff, 0x0fffffff
> +     mmSPI_CONFIG_CNTL, 0x07ffffff, 0x03000000,
> +     mmSX_DEBUG_1, 0x0000007f, 0x00000020,
> +     mmTA_CNTL_AUX, 0x00010000, 0x00010000,
> +     mmTCP_ADDR_CONFIG, 0x000003ff, 0x000000f7,
> +     mmTCP_CHAN_STEER_HI, 0xffffffff, 0x00000000,
> +     mmTCP_CHAN_STEER_LO, 0xffffffff, 0x32761054,
> +     mmVGT_GS_VERTEX_REUSE, 0x0000001f, 0x00000010,
> +     mmVM_L2_CG, 0x000c0fc0, 0x000c0400,
> +     mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff, 0xffffffff,
> +     mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff, 0x0fffffff,
> +     mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff, 0x0fffffff,
> +     mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff, 0x0fffffff,
>  };
>
>  static const u32 pitcairn_golden_rlc_registers[] =3D
>  {
> -     0x263e, 0xffffffff, 0x12011003,
> -     0x3109, 0xffffffff, 0x00601004,
> +     mmGB_ADDR_CONFIG, 0xffffffff, 0x12011003,
> +     mmRLC_LB_PARAMS, 0xffffffff, 0x00601004,
>        0x311f, 0xffffffff, 0x10102020,
>        0x3122, 0xffffffff, 0x01000020,
> -     0x30c5, 0xffffffff, 0x00000800,
> -     0x30c3, 0xffffffff, 0x800000a4
> +     mmRLC_LB_CNTR_MAX, 0xffffffff, 0x00000800,
> +     mmRLC_LB_CNTL, 0xffffffff, 0x800000a4,
>  };
>
>  static const u32 verde_pg_init[] =3D
>  {
> -     0x0d4f, 0xffffffff, 0x40000,
> -     0x0d4e, 0xffffffff, 0x200010ff,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x7007,
> -     0x0d4e, 0xffffffff, 0x300010ff,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x400000,
> -     0x0d4e, 0xffffffff, 0x100010ff,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x120200,
> -     0x0d4e, 0xffffffff, 0x500010ff,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x1e1e16,
> -     0x0d4e, 0xffffffff, 0x600010ff,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x171f1e,
> -     0x0d4e, 0xffffffff, 0x700010ff,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4f, 0xffffffff, 0x0,
> -     0x0d4e, 0xffffffff, 0x9ff,
> -     0x0d40, 0xffffffff, 0x0,
> -     0x0d41, 0xffffffff, 0x10000800,
> -     0x0d41, 0xffffffff, 0xf,
> -     0x0d41, 0xffffffff, 0xf,
> -     0x0d40, 0xffffffff, 0x4,
> -     0x0d41, 0xffffffff, 0x1000051e,
> -     0x0d41, 0xffffffff, 0xffff,
> -     0x0d41, 0xffffffff, 0xffff,
> -     0x0d40, 0xffffffff, 0x8,
> -     0x0d41, 0xffffffff, 0x80500,
> -     0x0d40, 0xffffffff, 0x12,
> -     0x0d41, 0xffffffff, 0x9050c,
> -     0x0d40, 0xffffffff, 0x1d,
> -     0x0d41, 0xffffffff, 0xb052c,
> -     0x0d40, 0xffffffff, 0x2a,
> -     0x0d41, 0xffffffff, 0x1053e,
> -     0x0d40, 0xffffffff, 0x2d,
> -     0x0d41, 0xffffffff, 0x10546,
> -     0x0d40, 0xffffffff, 0x30,
> -     0x0d41, 0xffffffff, 0xa054e,
> -     0x0d40, 0xffffffff, 0x3c,
> -     0x0d41, 0xffffffff, 0x1055f,
> -     0x0d40, 0xffffffff, 0x3f,
> -     0x0d41, 0xffffffff, 0x10567,
> -     0x0d40, 0xffffffff, 0x42,
> -     0x0d41, 0xffffffff, 0x1056f,
> -     0x0d40, 0xffffffff, 0x45,
> -     0x0d41, 0xffffffff, 0x10572,
> -     0x0d40, 0xffffffff, 0x48,
> -     0x0d41, 0xffffffff, 0x20575,
> -     0x0d40, 0xffffffff, 0x4c,
> -     0x0d41, 0xffffffff, 0x190801,
> -     0x0d40, 0xffffffff, 0x67,
> -     0x0d41, 0xffffffff, 0x1082a,
> -     0x0d40, 0xffffffff, 0x6a,
> -     0x0d41, 0xffffffff, 0x1b082d,
> -     0x0d40, 0xffffffff, 0x87,
> -     0x0d41, 0xffffffff, 0x310851,
> -     0x0d40, 0xffffffff, 0xba,
> -     0x0d41, 0xffffffff, 0x891,
> -     0x0d40, 0xffffffff, 0xbc,
> -     0x0d41, 0xffffffff, 0x893,
> -     0x0d40, 0xffffffff, 0xbe,
> -     0x0d41, 0xffffffff, 0x20895,
> -     0x0d40, 0xffffffff, 0xc2,
> -     0x0d41, 0xffffffff, 0x20899,
> -     0x0d40, 0xffffffff, 0xc6,
> -     0x0d41, 0xffffffff, 0x2089d,
> -     0x0d40, 0xffffffff, 0xca,
> -     0x0d41, 0xffffffff, 0x8a1,
> -     0x0d40, 0xffffffff, 0xcc,
> -     0x0d41, 0xffffffff, 0x8a3,
> -     0x0d40, 0xffffffff, 0xce,
> -     0x0d41, 0xffffffff, 0x308a5,
> -     0x0d40, 0xffffffff, 0xd3,
> -     0x0d41, 0xffffffff, 0x6d08cd,
> -     0x0d40, 0xffffffff, 0x142,
> -     0x0d41, 0xffffffff, 0x2000095a,
> -     0x0d41, 0xffffffff, 0x1,
> -     0x0d40, 0xffffffff, 0x144,
> -     0x0d41, 0xffffffff, 0x301f095b,
> -     0x0d40, 0xffffffff, 0x165,
> -     0x0d41, 0xffffffff, 0xc094d,
> -     0x0d40, 0xffffffff, 0x173,
> -     0x0d41, 0xffffffff, 0xf096d,
> -     0x0d40, 0xffffffff, 0x184,
> -     0x0d41, 0xffffffff, 0x15097f,
> -     0x0d40, 0xffffffff, 0x19b,
> -     0x0d41, 0xffffffff, 0xc0998,
> -     0x0d40, 0xffffffff, 0x1a9,
> -     0x0d41, 0xffffffff, 0x409a7,
> -     0x0d40, 0xffffffff, 0x1af,
> -     0x0d41, 0xffffffff, 0xcdc,
> -     0x0d40, 0xffffffff, 0x1b1,
> -     0x0d41, 0xffffffff, 0x800,
> -     0x0d42, 0xffffffff, 0x6c9b2000,
> -     0x0d44, 0xfc00, 0x2000,
> -     0x0d51, 0xffffffff, 0xfc0,
> -     0x0a35, 0x00000100, 0x100
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x40000,
> +     mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x200010ff,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x7007,
> +     mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x300010ff,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x400000,
> +     mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x100010ff,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x120200,
> +     mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x500010ff,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x1e1e16,
> +     mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x600010ff,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x171f1e,
> +     mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x700010ff,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,
> +     mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x9ff,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x0,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x10000800,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xf,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xf,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x4,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x1000051e,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xffff,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xffff,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x8,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x80500,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x12,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x9050c,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x1d,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xb052c,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x2a,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x1053e,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x2d,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x10546,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x30,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xa054e,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x3c,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x1055f,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x3f,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x10567,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x42,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x1056f,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x45,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x10572,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x48,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x20575,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x4c,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x190801,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x67,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x1082a,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x6a,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x1b082d,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x87,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x310851,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xba,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x891,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xbc,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x893,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xbe,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x20895,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xc2,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x20899,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xc6,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x2089d,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xca,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x8a1,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xcc,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x8a3,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xce,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x308a5,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xd3,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x6d08cd,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x142,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x2000095a,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x1,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x144,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x301f095b,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x165,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xc094d,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x173,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xf096d,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x184,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x15097f,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x19b,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xc0998,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x1a9,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x409a7,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x1af,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xcdc,
> +     mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x1b1,
> +     mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x800,
> +     mmGMCON_RENG_EXECUTE, 0xffffffff, 0x6c9b2000,
> +     mmGMCON_MISC2, 0xfc00, 0x2000,
> +     mmGMCON_MISC3, 0xffffffff, 0xfc0,
> +     mmMC_PMG_AUTO_CFG, 0x00000100, 0x100,
>  };
>
>  static const u32 verde_golden_rlc_registers[] =3D
>  {
> -     0x263e, 0xffffffff, 0x02010002,
> -     0x3109, 0xffffffff, 0x033f1005,
> +     mmGB_ADDR_CONFIG, 0xffffffff, 0x02010002,
> +     mmRLC_LB_PARAMS, 0xffffffff, 0x033f1005,
>        0x311f, 0xffffffff, 0x10808020,
>        0x3122, 0xffffffff, 0x00800008,
> -     0x30c5, 0xffffffff, 0x00001000,
> -     0x30c3, 0xffffffff, 0x80010014
> +     mmRLC_LB_CNTR_MAX, 0xffffffff, 0x00001000,
> +     mmRLC_LB_CNTL, 0xffffffff, 0x80010014,
>  };
>
>  static const u32 verde_golden_registers[] =3D
>  {
> -     0x17bc, 0x00000030, 0x00000011,
> -     0x2684, 0x00010000, 0x00018208,
> -     0x260c, 0xffffffff, 0x00000000,
> -     0x260d, 0xf00fffff, 0x00000400,
> -     0x260e, 0x0002021c, 0x00020200,
> -     0x031e, 0x00000080, 0x00000000,
> +     mmAZALIA_SCLK_CONTROL, 0x00000030, 0x00000011,
> +     mmCB_HW_CONTROL, 0x00010000, 0x00018208,
> +     mmDB_DEBUG, 0xffffffff, 0x00000000,
> +     mmDB_DEBUG2, 0xf00fffff, 0x00000400,
> +     mmDB_DEBUG3, 0x0002021c, 0x00020200,
> +     mmDCI_CLK_CNTL, 0x00000080, 0x00000000,
>        0x340c, 0x000300c0, 0x00800040,
>        0x360c, 0x000300c0, 0x00800040,
> -     0x16ec, 0x000000f0, 0x00000070,
> -     0x16f0, 0x00200000, 0x50100000,
> -     0x1c0c, 0x31000311, 0x00000011,
> -     0x0ab9, 0x00073ffe, 0x000022a2,
> -     0x0903, 0x000007ff, 0x00000000,
> -     0x2285, 0xf000001f, 0x00000007,
> -     0x22c9, 0xffffffff, 0x00ffffff,
> -     0x22c4, 0x0000ff0f, 0x00000000,
> -     0xa293, 0x07ffffff, 0x4e000000,
> -     0xa0d4, 0x3f3f3fff, 0x0000124a,
> +     mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070,
> +     mmFBC_MISC, 0x00200000, 0x50100000,
> +     mmDIG0_HDMI_CONTROL, 0x31000311, 0x00000011,
> +     mmMC_SEQ_PMG_PG_HWCNTL, 0x00073ffe, 0x000022a2,
> +     mmMC_XPB_P2P_BAR_CFG, 0x000007ff, 0x00000000,
> +     mmPA_CL_ENHANCE, 0xf000001f, 0x00000007,
> +     mmPA_SC_FORCE_EOV_MAX_CNTS, 0xffffffff, 0x00ffffff,
> +     mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000,
> +     mmPA_SC_MODE_CNTL_1, 0x07ffffff, 0x4e000000,
> +     mmPA_SC_RASTER_CONFIG, 0x3f3f3fff, 0x0000124a,
>        0x000c, 0xffffffff, 0x0040,
>        0x000d, 0x00000040, 0x00004040,
> -     0x2440, 0x07ffffff, 0x03000000,
> -     0x23a2, 0x01ff1f3f, 0x00000000,
> -     0x23a1, 0x01ff1f3f, 0x00000000,
> -     0x2418, 0x0000007f, 0x00000020,
> -     0x2542, 0x00010000, 0x00010000,
> -     0x2b05, 0x000003ff, 0x00000003,
> -     0x2b04, 0xffffffff, 0x00000000,
> -     0x2b03, 0xffffffff, 0x00001032,
> -     0x2235, 0x0000001f, 0x00000010,
> -     0x0570, 0x000c0fc0, 0x000c0400,
> -     0x052c, 0x0fffffff, 0xffffffff,
> -     0x052d, 0x0fffffff, 0x0fffffff,
> -     0x052e, 0x0fffffff, 0x0fffffff,
> -     0x052f, 0x0fffffff, 0x0fffffff
> +     mmSPI_CONFIG_CNTL, 0x07ffffff, 0x03000000,
> +     mmSQ_DED_CNT, 0x01ff1f3f, 0x00000000,
> +     mmSQ_SEC_CNT, 0x01ff1f3f, 0x00000000,
> +     mmSX_DEBUG_1, 0x0000007f, 0x00000020,
> +     mmTA_CNTL_AUX, 0x00010000, 0x00010000,
> +     mmTCP_ADDR_CONFIG, 0x000003ff, 0x00000003,
> +     mmTCP_CHAN_STEER_HI, 0xffffffff, 0x00000000,
> +     mmTCP_CHAN_STEER_LO, 0xffffffff, 0x00001032,
> +     mmVGT_GS_VERTEX_REUSE, 0x0000001f, 0x00000010,
> +     mmVM_L2_CG, 0x000c0fc0, 0x000c0400,
> +     mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff, 0xffffffff,
> +     mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff, 0x0fffffff,
> +     mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff, 0x0fffffff,
> +     mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff, 0x0fffffff,
>  };
>
>  static const u32 oland_golden_registers[] =3D
>  {
> -     0x17bc, 0x00000030, 0x00000011,
> -     0x2684, 0x00010000, 0x00018208,
> -     0x260c, 0xffffffff, 0x00000000,
> -     0x260d, 0xf00fffff, 0x00000400,
> -     0x260e, 0x0002021c, 0x00020200,
> -     0x031e, 0x00000080, 0x00000000,
> +     mmAZALIA_SCLK_CONTROL, 0x00000030, 0x00000011,
> +     mmCB_HW_CONTROL, 0x00010000, 0x00018208,
> +     mmDB_DEBUG, 0xffffffff, 0x00000000,
> +     mmDB_DEBUG2, 0xf00fffff, 0x00000400,
> +     mmDB_DEBUG3, 0x0002021c, 0x00020200,
> +     mmDCI_CLK_CNTL, 0x00000080, 0x00000000,
>        0x340c, 0x000300c0, 0x00800040,
>        0x360c, 0x000300c0, 0x00800040,
> -     0x16ec, 0x000000f0, 0x00000070,
> -     0x16f0, 0x00200000, 0x50100000,
> -     0x1c0c, 0x31000311, 0x00000011,
> -     0x0ab9, 0x00073ffe, 0x000022a2,
> -     0x0903, 0x000007ff, 0x00000000,
> -     0x2285, 0xf000001f, 0x00000007,
> -     0x22c9, 0xffffffff, 0x00ffffff,
> -     0x22c4, 0x0000ff0f, 0x00000000,
> -     0xa293, 0x07ffffff, 0x4e000000,
> -     0xa0d4, 0x3f3f3fff, 0x00000082,
> +     mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070,
> +     mmFBC_MISC, 0x00200000, 0x50100000,
> +     mmDIG0_HDMI_CONTROL, 0x31000311, 0x00000011,
> +     mmMC_SEQ_PMG_PG_HWCNTL, 0x00073ffe, 0x000022a2,
> +     mmMC_XPB_P2P_BAR_CFG, 0x000007ff, 0x00000000,
> +     mmPA_CL_ENHANCE, 0xf000001f, 0x00000007,
> +     mmPA_SC_FORCE_EOV_MAX_CNTS, 0xffffffff, 0x00ffffff,
> +     mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000,
> +     mmPA_SC_MODE_CNTL_1, 0x07ffffff, 0x4e000000,
> +     mmPA_SC_RASTER_CONFIG, 0x3f3f3fff, 0x00000082,
>        0x000c, 0xffffffff, 0x0040,
>        0x000d, 0x00000040, 0x00004040,
> -     0x2440, 0x07ffffff, 0x03000000,
> -     0x2418, 0x0000007f, 0x00000020,
> -     0x2542, 0x00010000, 0x00010000,
> -     0x2b05, 0x000003ff, 0x000000f3,
> -     0x2b04, 0xffffffff, 0x00000000,
> -     0x2b03, 0xffffffff, 0x00003210,
> -     0x2235, 0x0000001f, 0x00000010,
> -     0x0570, 0x000c0fc0, 0x000c0400,
> -     0x052c, 0x0fffffff, 0xffffffff,
> -     0x052d, 0x0fffffff, 0x0fffffff,
> -     0x052e, 0x0fffffff, 0x0fffffff,
> -     0x052f, 0x0fffffff, 0x0fffffff
> +     mmSPI_CONFIG_CNTL, 0x07ffffff, 0x03000000,
> +     mmSX_DEBUG_1, 0x0000007f, 0x00000020,
> +     mmTA_CNTL_AUX, 0x00010000, 0x00010000,
> +     mmTCP_ADDR_CONFIG, 0x000003ff, 0x000000f3,
> +     mmTCP_CHAN_STEER_HI, 0xffffffff, 0x00000000,
> +     mmTCP_CHAN_STEER_LO, 0xffffffff, 0x00003210,
> +     mmVGT_GS_VERTEX_REUSE, 0x0000001f, 0x00000010,
> +     mmVM_L2_CG, 0x000c0fc0, 0x000c0400,
> +     mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff, 0xffffffff,
> +     mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff, 0x0fffffff,
> +     mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff, 0x0fffffff,
> +     mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff, 0x0fffffff,
> +
>  };
>
>  static const u32 oland_golden_rlc_registers[] =3D
>  {
> -     0x263e, 0xffffffff, 0x02010002,
> -     0x3109, 0xffffffff, 0x00601005,
> +     mmGB_ADDR_CONFIG, 0xffffffff, 0x02010002,
> +     mmRLC_LB_PARAMS, 0xffffffff, 0x00601005,
>        0x311f, 0xffffffff, 0x10104040,
>        0x3122, 0xffffffff, 0x0100000a,
> -     0x30c5, 0xffffffff, 0x00000800,
> -     0x30c3, 0xffffffff, 0x800000f4
> +     mmRLC_LB_CNTR_MAX, 0xffffffff, 0x00000800,
> +     mmRLC_LB_CNTL, 0xffffffff, 0x800000f4,
>  };
>
>  static const u32 hainan_golden_registers[] =3D
>  {
>        0x17bc, 0x00000030, 0x00000011,
> -     0x2684, 0x00010000, 0x00018208,
> -     0x260c, 0xffffffff, 0x00000000,
> -     0x260d, 0xf00fffff, 0x00000400,
> -     0x260e, 0x0002021c, 0x00020200,
> +     mmCB_HW_CONTROL, 0x00010000, 0x00018208,
> +     mmDB_DEBUG, 0xffffffff, 0x00000000,
> +     mmDB_DEBUG2, 0xf00fffff, 0x00000400,
> +     mmDB_DEBUG3, 0x0002021c, 0x00020200,
>        0x031e, 0x00000080, 0x00000000,
>        0x3430, 0xff000fff, 0x00000100,
>        0x340c, 0x000300c0, 0x00800040,
> @@ -379,63 +385,63 @@ static const u32 hainan_golden_registers[] =3D
>        0x16ec, 0x000000f0, 0x00000070,
>        0x16f0, 0x00200000, 0x50100000,
>        0x1c0c, 0x31000311, 0x00000011,
> -     0x0ab9, 0x00073ffe, 0x000022a2,
> -     0x0903, 0x000007ff, 0x00000000,
> -     0x2285, 0xf000001f, 0x00000007,
> -     0x22c9, 0xffffffff, 0x00ffffff,
> -     0x22c4, 0x0000ff0f, 0x00000000,
> -     0xa293, 0x07ffffff, 0x4e000000,
> -     0xa0d4, 0x3f3f3fff, 0x00000000,
> +     mmMC_SEQ_PMG_PG_HWCNTL, 0x00073ffe, 0x000022a2,
> +     mmMC_XPB_P2P_BAR_CFG, 0x000007ff, 0x00000000,
> +     mmPA_CL_ENHANCE, 0xf000001f, 0x00000007,
> +     mmPA_SC_FORCE_EOV_MAX_CNTS, 0xffffffff, 0x00ffffff,
> +     mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000,
> +     mmPA_SC_MODE_CNTL_1, 0x07ffffff, 0x4e000000,
> +     mmPA_SC_RASTER_CONFIG, 0x3f3f3fff, 0x00000000,
>        0x000c, 0xffffffff, 0x0040,
>        0x000d, 0x00000040, 0x00004040,
> -     0x2440, 0x03e00000, 0x03600000,
> -     0x2418, 0x0000007f, 0x00000020,
> -     0x2542, 0x00010000, 0x00010000,
> -     0x2b05, 0x000003ff, 0x000000f1,
> -     0x2b04, 0xffffffff, 0x00000000,
> -     0x2b03, 0xffffffff, 0x00003210,
> -     0x2235, 0x0000001f, 0x00000010,
> -     0x0570, 0x000c0fc0, 0x000c0400,
> -     0x052c, 0x0fffffff, 0xffffffff,
> -     0x052d, 0x0fffffff, 0x0fffffff,
> -     0x052e, 0x0fffffff, 0x0fffffff,
> -     0x052f, 0x0fffffff, 0x0fffffff
> +     mmSPI_CONFIG_CNTL, 0x03e00000, 0x03600000,
> +     mmSX_DEBUG_1, 0x0000007f, 0x00000020,
> +     mmTA_CNTL_AUX, 0x00010000, 0x00010000,
> +     mmTCP_ADDR_CONFIG, 0x000003ff, 0x000000f1,
> +     mmTCP_CHAN_STEER_HI, 0xffffffff, 0x00000000,
> +     mmTCP_CHAN_STEER_LO, 0xffffffff, 0x00003210,
> +     mmVGT_GS_VERTEX_REUSE, 0x0000001f, 0x00000010,
> +     mmVM_L2_CG, 0x000c0fc0, 0x000c0400,
> +     mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff, 0xffffffff,
> +     mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff, 0x0fffffff,
> +     mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff, 0x0fffffff,
> +     mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff, 0x0fffffff,
>  };
>
>  static const u32 hainan_golden_registers2[] =3D
>  {
> -     0x263e, 0xffffffff, 0x2011003
> +     mmGB_ADDR_CONFIG, 0xffffffff, 0x2011003,
>  };
>
>  static const u32 tahiti_mgcg_cgcg_init[] =3D
>  {
> -     0x3100, 0xffffffff, 0xfffffffc,
> -     0x200b, 0xffffffff, 0xe0000000,
> -     0x2698, 0xffffffff, 0x00000100,
> -     0x24a9, 0xffffffff, 0x00000100,
> -     0x3059, 0xffffffff, 0x00000100,
> -     0x25dd, 0xffffffff, 0x00000100,
> -     0x2261, 0xffffffff, 0x06000100,
> -     0x2286, 0xffffffff, 0x00000100,
> -     0x24a8, 0xffffffff, 0x00000100,
> -     0x30e0, 0xffffffff, 0x00000100,
> -     0x22ca, 0xffffffff, 0x00000100,
> -     0x2451, 0xffffffff, 0x00000100,
> -     0x2362, 0xffffffff, 0x00000100,
> -     0x2363, 0xffffffff, 0x00000100,
> -     0x240c, 0xffffffff, 0x00000100,
> -     0x240d, 0xffffffff, 0x00000100,
> -     0x240e, 0xffffffff, 0x00000100,
> -     0x240f, 0xffffffff, 0x00000100,
> -     0x2b60, 0xffffffff, 0x00000100,
> -     0x2b15, 0xffffffff, 0x00000100,
> -     0x225f, 0xffffffff, 0x06000100,
> -     0x261a, 0xffffffff, 0x00000100,
> -     0x2544, 0xffffffff, 0x00000100,
> -     0x2bc1, 0xffffffff, 0x00000100,
> -     0x2b81, 0xffffffff, 0x00000100,
> -     0x2527, 0xffffffff, 0x00000100,
> -     0x200b, 0xffffffff, 0xe0000000,
> +     mmRLC_CGTT_MGCG_OVERRIDE, 0xffffffff, 0xfffffffc,
> +     mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000,
> +     mmCB_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_BCI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_CP_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_GDS_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_IA_CLK_CTRL, 0xffffffff, 0x06000100,
> +     mmCGTT_PA_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_PC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_RLC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SPI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SQ_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SQG_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL0, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL1, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL2, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL3, 0xffffffff, 0x00000100,
> +     mmCGTT_TCI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_TCP_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_VGT_CLK_CTRL, 0xffffffff, 0x06000100,
> +     mmDB_CGTT_CLK_CTRL_0, 0xffffffff, 0x00000100,
> +     mmTA_CGTT_CTRL, 0xffffffff, 0x00000100,
> +     mmTCA_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmTCC_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmTD_CGTT_CTRL, 0xffffffff, 0x00000100,
> +     mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000,
>        0x2458, 0xffffffff, 0x00010000,
>        0x2459, 0xffffffff, 0x00030002,
>        0x245a, 0xffffffff, 0x00040007,
> @@ -516,55 +522,55 @@ static const u32 tahiti_mgcg_cgcg_init[] =3D
>        0x24a5, 0xffffffff, 0x00000015,
>        0x24a6, 0xffffffff, 0x00140013,
>        0x24a7, 0xffffffff, 0x00170016,
> -     0x2454, 0xffffffff, 0x96940200,
> -     0x21c2, 0xffffffff, 0x00900100,
> -     0x311e, 0xffffffff, 0x00000080,
> -     0x3101, 0xffffffff, 0x0020003f,
> +     mmCGTS_SM_CTRL_REG, 0xffffffff, 0x96940200,
> +     mmCP_RB_WPTR_POLL_CNTL, 0xffffffff, 0x00900100,
> +     mmRLC_GCPM_GENERAL_3, 0xffffffff, 0x00000080,
> +     mmRLC_CGCG_CGLS_CTRL, 0xffffffff, 0x0020003f,
>        0x000c, 0xffffffff, 0x0000001c,
>        0x000d, 0x000f0000, 0x000f0000,
>        0x0583, 0xffffffff, 0x00000100,
> -     0x0409, 0xffffffff, 0x00000100,
> -     0x040b, 0x00000101, 0x00000000,
> -     0x082a, 0xffffffff, 0x00000104,
> -     0x0993, 0x000c0000, 0x000c0000,
> -     0x0992, 0x000c0000, 0x000c0000,
> -     0x1579, 0xff000fff, 0x00000100,
> +     mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x00000100,
> +     mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x00000000,
> +     mmMC_MEM_POWER_LS, 0xffffffff, 0x00000104,
> +     mmMC_CITF_MISC_WR_CG, 0x000c0000, 0x000c0000,
> +     mmMC_CITF_MISC_RD_CG, 0x000c0000, 0x000c0000,
> +     mmCGTT_DRM_CLK_CTRL0, 0xff000fff, 0x00000100,
>        0x157a, 0x00000001, 0x00000001,
> -     0x0bd4, 0x00000001, 0x00000001,
> -     0x0c33, 0xc0000fff, 0x00000104,
> -     0x3079, 0x00000001, 0x00000001,
> +     mmHDP_MEM_POWER_LS, 0x00000001, 0x00000001,
> +     mmHDP_XDP_CGTT_BLK_CTRL, 0xc0000fff, 0x00000104,
> +     mmCP_MEM_SLP_CNTL, 0x00000001, 0x00000001,
>        0x3430, 0xfffffff0, 0x00000100,
> -     0x3630, 0xfffffff0, 0x00000100
> +     0x3630, 0xfffffff0, 0x00000100,
>  };
>  static const u32 pitcairn_mgcg_cgcg_init[] =3D
>  {
> -     0x3100, 0xffffffff, 0xfffffffc,
> -     0x200b, 0xffffffff, 0xe0000000,
> -     0x2698, 0xffffffff, 0x00000100,
> -     0x24a9, 0xffffffff, 0x00000100,
> -     0x3059, 0xffffffff, 0x00000100,
> -     0x25dd, 0xffffffff, 0x00000100,
> -     0x2261, 0xffffffff, 0x06000100,
> -     0x2286, 0xffffffff, 0x00000100,
> -     0x24a8, 0xffffffff, 0x00000100,
> -     0x30e0, 0xffffffff, 0x00000100,
> -     0x22ca, 0xffffffff, 0x00000100,
> -     0x2451, 0xffffffff, 0x00000100,
> -     0x2362, 0xffffffff, 0x00000100,
> -     0x2363, 0xffffffff, 0x00000100,
> -     0x240c, 0xffffffff, 0x00000100,
> -     0x240d, 0xffffffff, 0x00000100,
> -     0x240e, 0xffffffff, 0x00000100,
> -     0x240f, 0xffffffff, 0x00000100,
> -     0x2b60, 0xffffffff, 0x00000100,
> -     0x2b15, 0xffffffff, 0x00000100,
> -     0x225f, 0xffffffff, 0x06000100,
> -     0x261a, 0xffffffff, 0x00000100,
> -     0x2544, 0xffffffff, 0x00000100,
> -     0x2bc1, 0xffffffff, 0x00000100,
> -     0x2b81, 0xffffffff, 0x00000100,
> -     0x2527, 0xffffffff, 0x00000100,
> -     0x200b, 0xffffffff, 0xe0000000,
> +     mmRLC_CGTT_MGCG_OVERRIDE, 0xffffffff, 0xfffffffc,
> +     mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000,
> +     mmCB_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_BCI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_CP_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_GDS_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_IA_CLK_CTRL, 0xffffffff, 0x06000100,
> +     mmCGTT_PA_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_PC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_RLC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SPI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SQ_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SQG_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL0, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL1, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL2, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL3, 0xffffffff, 0x00000100,
> +     mmCGTT_TCI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_TCP_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_VGT_CLK_CTRL, 0xffffffff, 0x06000100,
> +     mmDB_CGTT_CLK_CTRL_0, 0xffffffff, 0x00000100,
> +     mmTA_CGTT_CTRL, 0xffffffff, 0x00000100,
> +     mmTCA_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmTCC_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmTD_CGTT_CTRL, 0xffffffff, 0x00000100,
> +     mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000,
>        0x2458, 0xffffffff, 0x00010000,
>        0x2459, 0xffffffff, 0x00030002,
>        0x245a, 0xffffffff, 0x00040007,
> @@ -615,53 +621,54 @@ static const u32 pitcairn_mgcg_cgcg_init[] =3D
>        0x2496, 0xffffffff, 0x00100013,
>        0x2497, 0xffffffff, 0x00120011,
>        0x2498, 0xffffffff, 0x00150014,
> -     0x2454, 0xffffffff, 0x96940200,
> -     0x21c2, 0xffffffff, 0x00900100,
> -     0x311e, 0xffffffff, 0x00000080,
> -     0x3101, 0xffffffff, 0x0020003f,
> +     mmCGTS_SM_CTRL_REG, 0xffffffff, 0x96940200,
> +     mmCP_RB_WPTR_POLL_CNTL, 0xffffffff, 0x00900100,
> +     mmRLC_GCPM_GENERAL_3, 0xffffffff, 0x00000080,
> +     mmRLC_CGCG_CGLS_CTRL, 0xffffffff, 0x0020003f,
>        0x000c, 0xffffffff, 0x0000001c,
>        0x000d, 0x000f0000, 0x000f0000,
>        0x0583, 0xffffffff, 0x00000100,
> -     0x0409, 0xffffffff, 0x00000100,
> -     0x040b, 0x00000101, 0x00000000,
> -     0x082a, 0xffffffff, 0x00000104,
> -     0x1579, 0xff000fff, 0x00000100,
> +     mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x00000100,
> +     mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x00000000,
> +     mmMC_MEM_POWER_LS, 0xffffffff, 0x00000104,
> +     mmCGTT_DRM_CLK_CTRL0, 0xff000fff, 0x00000100,
>        0x157a, 0x00000001, 0x00000001,
> -     0x0bd4, 0x00000001, 0x00000001,
> -     0x0c33, 0xc0000fff, 0x00000104,
> -     0x3079, 0x00000001, 0x00000001,
> +     mmHDP_MEM_POWER_LS, 0x00000001, 0x00000001,
> +     mmHDP_XDP_CGTT_BLK_CTRL, 0xc0000fff, 0x00000104,
> +     mmCP_MEM_SLP_CNTL, 0x00000001, 0x00000001,
>        0x3430, 0xfffffff0, 0x00000100,
> -     0x3630, 0xfffffff0, 0x00000100
> +     0x3630, 0xfffffff0, 0x00000100,
>  };
> +
>  static const u32 verde_mgcg_cgcg_init[] =3D
>  {
> -     0x3100, 0xffffffff, 0xfffffffc,
> -     0x200b, 0xffffffff, 0xe0000000,
> -     0x2698, 0xffffffff, 0x00000100,
> -     0x24a9, 0xffffffff, 0x00000100,
> -     0x3059, 0xffffffff, 0x00000100,
> -     0x25dd, 0xffffffff, 0x00000100,
> -     0x2261, 0xffffffff, 0x06000100,
> -     0x2286, 0xffffffff, 0x00000100,
> -     0x24a8, 0xffffffff, 0x00000100,
> -     0x30e0, 0xffffffff, 0x00000100,
> -     0x22ca, 0xffffffff, 0x00000100,
> -     0x2451, 0xffffffff, 0x00000100,
> -     0x2362, 0xffffffff, 0x00000100,
> -     0x2363, 0xffffffff, 0x00000100,
> -     0x240c, 0xffffffff, 0x00000100,
> -     0x240d, 0xffffffff, 0x00000100,
> -     0x240e, 0xffffffff, 0x00000100,
> -     0x240f, 0xffffffff, 0x00000100,
> -     0x2b60, 0xffffffff, 0x00000100,
> -     0x2b15, 0xffffffff, 0x00000100,
> -     0x225f, 0xffffffff, 0x06000100,
> -     0x261a, 0xffffffff, 0x00000100,
> -     0x2544, 0xffffffff, 0x00000100,
> -     0x2bc1, 0xffffffff, 0x00000100,
> -     0x2b81, 0xffffffff, 0x00000100,
> -     0x2527, 0xffffffff, 0x00000100,
> -     0x200b, 0xffffffff, 0xe0000000,
> +     mmRLC_CGTT_MGCG_OVERRIDE, 0xffffffff, 0xfffffffc,
> +     mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000,
> +     mmCB_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_BCI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_CP_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_GDS_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_IA_CLK_CTRL, 0xffffffff, 0x06000100,
> +     mmCGTT_PA_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_PC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_RLC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SPI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SQ_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SQG_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL0, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL1, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL2, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL3, 0xffffffff, 0x00000100,
> +     mmCGTT_TCI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_TCP_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_VGT_CLK_CTRL, 0xffffffff, 0x06000100,
> +     mmDB_CGTT_CLK_CTRL_0, 0xffffffff, 0x00000100,
> +     mmTA_CGTT_CTRL, 0xffffffff, 0x00000100,
> +     mmTCA_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmTCC_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmTD_CGTT_CTRL, 0xffffffff, 0x00000100,
> +     mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000,
>        0x2458, 0xffffffff, 0x00010000,
>        0x2459, 0xffffffff, 0x00030002,
>        0x245a, 0xffffffff, 0x00040007,
> @@ -712,55 +719,56 @@ static const u32 verde_mgcg_cgcg_init[] =3D
>        0x2496, 0xffffffff, 0x00100013,
>        0x2497, 0xffffffff, 0x00120011,
>        0x2498, 0xffffffff, 0x00150014,
> -     0x2454, 0xffffffff, 0x96940200,
> -     0x21c2, 0xffffffff, 0x00900100,
> -     0x311e, 0xffffffff, 0x00000080,
> -     0x3101, 0xffffffff, 0x0020003f,
> +     mmCGTS_SM_CTRL_REG, 0xffffffff, 0x96940200,
> +     mmCP_RB_WPTR_POLL_CNTL, 0xffffffff, 0x00900100,
> +     mmRLC_GCPM_GENERAL_3, 0xffffffff, 0x00000080,
> +     mmRLC_CGCG_CGLS_CTRL, 0xffffffff, 0x0020003f,
>        0x000c, 0xffffffff, 0x0000001c,
>        0x000d, 0x000f0000, 0x000f0000,
>        0x0583, 0xffffffff, 0x00000100,
> -     0x0409, 0xffffffff, 0x00000100,
> -     0x040b, 0x00000101, 0x00000000,
> -     0x082a, 0xffffffff, 0x00000104,
> -     0x0993, 0x000c0000, 0x000c0000,
> -     0x0992, 0x000c0000, 0x000c0000,
> -     0x1579, 0xff000fff, 0x00000100,
> +     mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x00000100,
> +     mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x00000000,
> +     mmMC_MEM_POWER_LS, 0xffffffff, 0x00000104,
> +     mmMC_CITF_MISC_WR_CG, 0x000c0000, 0x000c0000,
> +     mmMC_CITF_MISC_RD_CG, 0x000c0000, 0x000c0000,
> +     mmCGTT_DRM_CLK_CTRL0, 0xff000fff, 0x00000100,
>        0x157a, 0x00000001, 0x00000001,
> -     0x0bd4, 0x00000001, 0x00000001,
> -     0x0c33, 0xc0000fff, 0x00000104,
> -     0x3079, 0x00000001, 0x00000001,
> +     mmHDP_MEM_POWER_LS, 0x00000001, 0x00000001,
> +     mmHDP_XDP_CGTT_BLK_CTRL, 0xc0000fff, 0x00000104,
> +     mmCP_MEM_SLP_CNTL, 0x00000001, 0x00000001,
>        0x3430, 0xfffffff0, 0x00000100,
> -     0x3630, 0xfffffff0, 0x00000100
> +     0x3630, 0xfffffff0, 0x00000100,
>  };
> +
>  static const u32 oland_mgcg_cgcg_init[] =3D
>  {
> -     0x3100, 0xffffffff, 0xfffffffc,
> -     0x200b, 0xffffffff, 0xe0000000,
> -     0x2698, 0xffffffff, 0x00000100,
> -     0x24a9, 0xffffffff, 0x00000100,
> -     0x3059, 0xffffffff, 0x00000100,
> -     0x25dd, 0xffffffff, 0x00000100,
> -     0x2261, 0xffffffff, 0x06000100,
> -     0x2286, 0xffffffff, 0x00000100,
> -     0x24a8, 0xffffffff, 0x00000100,
> -     0x30e0, 0xffffffff, 0x00000100,
> -     0x22ca, 0xffffffff, 0x00000100,
> -     0x2451, 0xffffffff, 0x00000100,
> -     0x2362, 0xffffffff, 0x00000100,
> -     0x2363, 0xffffffff, 0x00000100,
> -     0x240c, 0xffffffff, 0x00000100,
> -     0x240d, 0xffffffff, 0x00000100,
> -     0x240e, 0xffffffff, 0x00000100,
> -     0x240f, 0xffffffff, 0x00000100,
> -     0x2b60, 0xffffffff, 0x00000100,
> -     0x2b15, 0xffffffff, 0x00000100,
> -     0x225f, 0xffffffff, 0x06000100,
> -     0x261a, 0xffffffff, 0x00000100,
> -     0x2544, 0xffffffff, 0x00000100,
> -     0x2bc1, 0xffffffff, 0x00000100,
> -     0x2b81, 0xffffffff, 0x00000100,
> -     0x2527, 0xffffffff, 0x00000100,
> -     0x200b, 0xffffffff, 0xe0000000,
> +     mmRLC_CGTT_MGCG_OVERRIDE, 0xffffffff, 0xfffffffc,
> +     mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000,
> +     mmCB_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_BCI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_CP_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_GDS_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_IA_CLK_CTRL, 0xffffffff, 0x06000100,
> +     mmCGTT_PA_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_PC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_RLC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SPI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SQ_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SQG_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL0, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL1, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL2, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL3, 0xffffffff, 0x00000100,
> +     mmCGTT_TCI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_TCP_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_VGT_CLK_CTRL, 0xffffffff, 0x06000100,
> +     mmDB_CGTT_CLK_CTRL_0, 0xffffffff, 0x00000100,
> +     mmTA_CGTT_CTRL, 0xffffffff, 0x00000100,
> +     mmTCA_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmTCC_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmTD_CGTT_CTRL, 0xffffffff, 0x00000100,
> +     mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000,
>        0x2458, 0xffffffff, 0x00010000,
>        0x2459, 0xffffffff, 0x00030002,
>        0x245a, 0xffffffff, 0x00040007,
> @@ -791,55 +799,56 @@ static const u32 oland_mgcg_cgcg_init[] =3D
>        0x2473, 0xffffffff, 0x0000000b,
>        0x2474, 0xffffffff, 0x000a0009,
>        0x2475, 0xffffffff, 0x000d000c,
> -     0x2454, 0xffffffff, 0x96940200,
> -     0x21c2, 0xffffffff, 0x00900100,
> -     0x311e, 0xffffffff, 0x00000080,
> -     0x3101, 0xffffffff, 0x0020003f,
> +     mmCGTS_SM_CTRL_REG, 0xffffffff, 0x96940200,
> +     mmCP_RB_WPTR_POLL_CNTL, 0xffffffff, 0x00900100,
> +     mmRLC_GCPM_GENERAL_3, 0xffffffff, 0x00000080,
> +     mmRLC_CGCG_CGLS_CTRL, 0xffffffff, 0x0020003f,
>        0x000c, 0xffffffff, 0x0000001c,
>        0x000d, 0x000f0000, 0x000f0000,
>        0x0583, 0xffffffff, 0x00000100,
> -     0x0409, 0xffffffff, 0x00000100,
> -     0x040b, 0x00000101, 0x00000000,
> -     0x082a, 0xffffffff, 0x00000104,
> -     0x0993, 0x000c0000, 0x000c0000,
> -     0x0992, 0x000c0000, 0x000c0000,
> -     0x1579, 0xff000fff, 0x00000100,
> +     mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x00000100,
> +     mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x00000000,
> +     mmMC_MEM_POWER_LS, 0xffffffff, 0x00000104,
> +     mmMC_CITF_MISC_WR_CG, 0x000c0000, 0x000c0000,
> +     mmMC_CITF_MISC_RD_CG, 0x000c0000, 0x000c0000,
> +     mmCGTT_DRM_CLK_CTRL0, 0xff000fff, 0x00000100,
>        0x157a, 0x00000001, 0x00000001,
> -     0x0bd4, 0x00000001, 0x00000001,
> -     0x0c33, 0xc0000fff, 0x00000104,
> -     0x3079, 0x00000001, 0x00000001,
> +     mmHDP_MEM_POWER_LS, 0x00000001, 0x00000001,
> +     mmHDP_XDP_CGTT_BLK_CTRL, 0xc0000fff, 0x00000104,
> +     mmCP_MEM_SLP_CNTL, 0x00000001, 0x00000001,
>        0x3430, 0xfffffff0, 0x00000100,
> -     0x3630, 0xfffffff0, 0x00000100
> +     0x3630, 0xfffffff0, 0x00000100,
>  };
> +
>  static const u32 hainan_mgcg_cgcg_init[] =3D
>  {
> -     0x3100, 0xffffffff, 0xfffffffc,
> -     0x200b, 0xffffffff, 0xe0000000,
> -     0x2698, 0xffffffff, 0x00000100,
> -     0x24a9, 0xffffffff, 0x00000100,
> -     0x3059, 0xffffffff, 0x00000100,
> -     0x25dd, 0xffffffff, 0x00000100,
> -     0x2261, 0xffffffff, 0x06000100,
> -     0x2286, 0xffffffff, 0x00000100,
> -     0x24a8, 0xffffffff, 0x00000100,
> -     0x30e0, 0xffffffff, 0x00000100,
> -     0x22ca, 0xffffffff, 0x00000100,
> -     0x2451, 0xffffffff, 0x00000100,
> -     0x2362, 0xffffffff, 0x00000100,
> -     0x2363, 0xffffffff, 0x00000100,
> -     0x240c, 0xffffffff, 0x00000100,
> -     0x240d, 0xffffffff, 0x00000100,
> -     0x240e, 0xffffffff, 0x00000100,
> -     0x240f, 0xffffffff, 0x00000100,
> -     0x2b60, 0xffffffff, 0x00000100,
> -     0x2b15, 0xffffffff, 0x00000100,
> -     0x225f, 0xffffffff, 0x06000100,
> -     0x261a, 0xffffffff, 0x00000100,
> -     0x2544, 0xffffffff, 0x00000100,
> -     0x2bc1, 0xffffffff, 0x00000100,
> -     0x2b81, 0xffffffff, 0x00000100,
> -     0x2527, 0xffffffff, 0x00000100,
> -     0x200b, 0xffffffff, 0xe0000000,
> +     mmRLC_CGTT_MGCG_OVERRIDE, 0xffffffff, 0xfffffffc,
> +     mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000,
> +     mmCB_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_BCI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_CP_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_GDS_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_IA_CLK_CTRL, 0xffffffff, 0x06000100,
> +     mmCGTT_PA_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_PC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_RLC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SC_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SPI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SQ_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SQG_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL0, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL1, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL2, 0xffffffff, 0x00000100,
> +     mmCGTT_SX_CLK_CTRL3, 0xffffffff, 0x00000100,
> +     mmCGTT_TCI_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_TCP_CLK_CTRL, 0xffffffff, 0x00000100,
> +     mmCGTT_VGT_CLK_CTRL, 0xffffffff, 0x06000100,
> +     mmDB_CGTT_CLK_CTRL_0, 0xffffffff, 0x00000100,
> +     mmTA_CGTT_CTRL, 0xffffffff, 0x00000100,
> +     mmTCA_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmTCC_CGTT_SCLK_CTRL, 0xffffffff, 0x00000100,
> +     mmTD_CGTT_CTRL, 0xffffffff, 0x00000100,
> +     mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000,
>        0x2458, 0xffffffff, 0x00010000,
>        0x2459, 0xffffffff, 0x00030002,
>        0x245a, 0xffffffff, 0x00040007,
> @@ -870,22 +879,22 @@ static const u32 hainan_mgcg_cgcg_init[] =3D
>        0x2473, 0xffffffff, 0x0000000b,
>        0x2474, 0xffffffff, 0x000a0009,
>        0x2475, 0xffffffff, 0x000d000c,
> -     0x2454, 0xffffffff, 0x96940200,
> -     0x21c2, 0xffffffff, 0x00900100,
> -     0x311e, 0xffffffff, 0x00000080,
> -     0x3101, 0xffffffff, 0x0020003f,
> +     mmCGTS_SM_CTRL_REG, 0xffffffff, 0x96940200,
> +     mmCP_RB_WPTR_POLL_CNTL, 0xffffffff, 0x00900100,
> +     mmRLC_GCPM_GENERAL_3, 0xffffffff, 0x00000080,
> +     mmRLC_CGCG_CGLS_CTRL, 0xffffffff, 0x0020003f,
>        0x000c, 0xffffffff, 0x0000001c,
>        0x000d, 0x000f0000, 0x000f0000,
>        0x0583, 0xffffffff, 0x00000100,
>        0x0409, 0xffffffff, 0x00000100,
> -     0x082a, 0xffffffff, 0x00000104,
> -     0x0993, 0x000c0000, 0x000c0000,
> -     0x0992, 0x000c0000, 0x000c0000,
> -     0x0bd4, 0x00000001, 0x00000001,
> -     0x0c33, 0xc0000fff, 0x00000104,
> -     0x3079, 0x00000001, 0x00000001,
> +     mmMC_MEM_POWER_LS, 0xffffffff, 0x00000104,
> +     mmMC_CITF_MISC_WR_CG, 0x000c0000, 0x000c0000,
> +     mmMC_CITF_MISC_RD_CG, 0x000c0000, 0x000c0000,
> +     mmHDP_MEM_POWER_LS, 0x00000001, 0x00000001,
> +     mmHDP_XDP_CGTT_BLK_CTRL, 0xc0000fff, 0x00000104,
> +     mmCP_MEM_SLP_CNTL, 0x00000001, 0x00000001,
>        0x3430, 0xfffffff0, 0x00000100,
> -     0x3630, 0xfffffff0, 0x00000100
> +     0x3630, 0xfffffff0, 0x00000100,
>  };
>
>  static u32 si_pcie_rreg(struct amdgpu_device *adev, u32 reg)
>

--_000_CY4PR12MB17685A0FE018598D10CCA849F79C0CY4PR12MB1768namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>umr &#43; script (attached).</p>
<p><br>
</p>
<p>You'll need a relatively new build of umr (on master) that supports forc=
ing an asic by name then you use this as</p>
<p><br>
</p>
<p>unnum.sh &lt;asic_name&gt;</p>
<p>&lt;paste_lines_of_golden_data&gt;</p>
<p>&lt;hit CTRL&#43;D&gt;</p>
<p><br>
</p>
<p>then it spits out the new lines replacing things with registers where fo=
und.</p>
<p><br>
</p>
<p>It'd in theory work with vega10/etc once I add one last commit to the am=
d-temp-soc15 branch.</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wentland, Harry<br>
<b>Sent:</b> Friday, December 16, 2016 10:02<br>
<b>To:</b> Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: De-numberify golden SI register=
s</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Nice. Do you have a script to do this or is this a=
ll done by hand?<br>
<br>
Reviewed-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Harry<br>
<br>
On 2016-12-16 08:50 AM, Tom St Denis wrote:<br>
&gt; Where possible replace numeric constants in the table<br>
&gt; with their register names.<br>
&gt;<br>
&gt; Compile tested &#43; executed on a Tahiti.<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/si.c | 975 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-=
-------------------<br>
&gt;&nbsp; 1 file changed, 492 insertions(&#43;), 483 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amd=
gpu/si.c<br>
&gt; index c46b0159007d..9bf7afb2f74e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/si.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/si.c<br>
&gt; @@ -40,337 &#43;40,343 @@<br>
&gt;&nbsp; #include &quot;dce_v6_0.h&quot;<br>
&gt;&nbsp; #include &quot;si.h&quot;<br>
&gt;&nbsp; #include &quot;dce_virtual.h&quot;<br>
&gt; &#43;#include &quot;gca/gfx_6_0_d.h&quot;<br>
&gt; &#43;#include &quot;oss/oss_1_0_d.h&quot;<br>
&gt; &#43;#include &quot;gmc/gmc_6_0_d.h&quot;<br>
&gt; &#43;#include &quot;dce/dce_6_0_d.h&quot;<br>
&gt; &#43;#include &quot;uvd/uvd_4_0_d.h&quot;<br>
&gt;<br>
&gt;&nbsp; static const u32 tahiti_golden_registers[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x17bc, 0x00000030, 0x00000011,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2684, 0x00010000, 0x00018208,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260c, 0xffffffff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260d, 0xf00fffff, 0x00000400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260e, 0x0002021c, 0x00020200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x031e, 0x00000080, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmAZALIA_SCLK_CONTROL, 0x00000030, 0x000=
00011,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_HW_CONTROL, 0x00010000, 0x00018208,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG, 0xffffffff, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG2, 0xf00fffff, 0x00000400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG3, 0x0002021c, 0x00020200,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDCI_CLK_CNTL, 0x00000080, 0x00000000,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x340c, 0x000000c0, 0x008000=
40,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x360c, 0x000000c0, 0x008000=
40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x16ec, 0x000000f0, 0x00000070,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x16f0, 0x00200000, 0x50100000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x1c0c, 0x31000311, 0x00000011,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x09df, 0x00000003, 0x000007ff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0903, 0x000007ff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2285, 0xf000001f, 0x00000007,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22c9, 0xffffffff, 0x00ffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22c4, 0x0000ff0f, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xa293, 0x07ffffff, 0x4e000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xa0d4, 0x3f3f3fff, 0x2a00126a,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_MISC, 0x00200000, 0x50100000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDIG0_HDMI_CONTROL, 0x31000311, 0x00000=
011,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_ARB_WTM_CNTL_RD, 0x00000003, 0x0000=
07ff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_XPB_P2P_BAR_CFG, 0x000007ff, 0x0000=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_CL_ENHANCE, 0xf000001f, 0x00000007,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_FORCE_EOV_MAX_CNTS, 0xffffffff, =
0x00ffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, =
0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_MODE_CNTL_1, 0x07ffffff, 0x4e000=
000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_RASTER_CONFIG, 0x3f3f3fff, 0x2a0=
0126a,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c, 0xffffffff, 0x0040,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000d, 0x00000040, 0x000040=
40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2440, 0x07ffffff, 0x03000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x23a2, 0x01ff1f3f, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x23a1, 0x01ff1f3f, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2418, 0x0000007f, 0x00000020,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2542, 0x00010000, 0x00010000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b05, 0x00000200, 0x000002fb,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b04, 0xffffffff, 0x0000543b,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b03, 0xffffffff, 0xa9210876,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2234, 0xffffffff, 0x000fff40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2235, 0x0000001f, 0x00000010,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0504, 0x20000000, 0x20fffed8,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0570, 0x000c0fc0, 0x000c0400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052c, 0x0fffffff, 0xffffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052d, 0x0fffffff, 0x0fffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052e, 0x0fffffff, 0x0fffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052f, 0x0fffffff, 0x0fffffff<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_CONFIG_CNTL, 0x07ffffff, 0x0300000=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSQ_DED_CNT, 0x01ff1f3f, 0x00000000,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSQ_SEC_CNT, 0x01ff1f3f, 0x00000000,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSX_DEBUG_1, 0x0000007f, 0x00000020,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CNTL_AUX, 0x00010000, 0x00010000,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_ADDR_CONFIG, 0x00000200, 0x000002f=
b,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_HI, 0xffffffff, 0x00005=
43b,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_LO, 0xffffffff, 0xa9210=
876,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVGT_FIFO_DEPTHS, 0xffffffff, 0x000fff4=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVGT_GS_VERTEX_REUSE, 0x0000001f, 0x000=
00010,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_CONTEXT0_CNTL, 0x20000000, 0x20fffe=
d8,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_L2_CG, 0x000c0fc0, 0x000c0400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff,=
 0xffffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 tahiti_golden_registers2[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0319, 0x00000001, 0x00000001<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMCIF_MEM_CONTROL, 0x00000001, 0x000000=
01,<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 tahiti_golden_rlc_registers[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x263e, 0xffffffff, 0x12011003,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3109, 0xffffffff, 0x00601005,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGB_ADDR_CONFIG, 0xffffffff, 0x12011003=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_PARAMS, 0xffffffff, 0x00601005,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x311f, 0xffffffff, 0x101040=
40,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3122, 0xffffffff, 0x010000=
0a,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30c5, 0xffffffff, 0x00000800,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30c3, 0xffffffff, 0x800000f4,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3d2a, 0x00000008, 0x00000000<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_CNTR_MAX, 0xffffffff, 0x0000080=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_CNTL, 0xffffffff, 0x800000f4,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmUVD_CGC_GATE, 0x00000008, 0x00000000,<=
br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 pitcairn_golden_registers[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x17bc, 0x00000030, 0x00000011,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2684, 0x00010000, 0x00018208,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260c, 0xffffffff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260d, 0xf00fffff, 0x00000400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260e, 0x0002021c, 0x00020200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x031e, 0x00000080, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmAZALIA_SCLK_CONTROL, 0x00000030, 0x000=
00011,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_HW_CONTROL, 0x00010000, 0x00018208,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG, 0xffffffff, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG2, 0xf00fffff, 0x00000400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG3, 0x0002021c, 0x00020200,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDCI_CLK_CNTL, 0x00000080, 0x00000000,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x340c, 0x000300c0, 0x008000=
40,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x360c, 0x000300c0, 0x008000=
40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x16ec, 0x000000f0, 0x00000070,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x16f0, 0x00200000, 0x50100000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x1c0c, 0x31000311, 0x00000011,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0ab9, 0x00073ffe, 0x000022a2,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0903, 0x000007ff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2285, 0xf000001f, 0x00000007,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22c9, 0xffffffff, 0x00ffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22c4, 0x0000ff0f, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xa293, 0x07ffffff, 0x4e000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xa0d4, 0x3f3f3fff, 0x2a00126a,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_MISC, 0x00200000, 0x50100000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDIG0_HDMI_CONTROL, 0x31000311, 0x00000=
011,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_SEQ_PMG_PG_HWCNTL, 0x00073ffe, 0x00=
0022a2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_XPB_P2P_BAR_CFG, 0x000007ff, 0x0000=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_CL_ENHANCE, 0xf000001f, 0x00000007,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_FORCE_EOV_MAX_CNTS, 0xffffffff, =
0x00ffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, =
0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_MODE_CNTL_1, 0x07ffffff, 0x4e000=
000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_RASTER_CONFIG, 0x3f3f3fff, 0x2a0=
0126a,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c, 0xffffffff, 0x0040,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000d, 0x00000040, 0x000040=
40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2440, 0x07ffffff, 0x03000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2418, 0x0000007f, 0x00000020,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2542, 0x00010000, 0x00010000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b05, 0x000003ff, 0x000000f7,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b04, 0xffffffff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b03, 0xffffffff, 0x32761054,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2235, 0x0000001f, 0x00000010,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0570, 0x000c0fc0, 0x000c0400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052c, 0x0fffffff, 0xffffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052d, 0x0fffffff, 0x0fffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052e, 0x0fffffff, 0x0fffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052f, 0x0fffffff, 0x0fffffff<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_CONFIG_CNTL, 0x07ffffff, 0x0300000=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSX_DEBUG_1, 0x0000007f, 0x00000020,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CNTL_AUX, 0x00010000, 0x00010000,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_ADDR_CONFIG, 0x000003ff, 0x000000f=
7,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_HI, 0xffffffff, 0x00000=
000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_LO, 0xffffffff, 0x32761=
054,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVGT_GS_VERTEX_REUSE, 0x0000001f, 0x000=
00010,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_L2_CG, 0x000c0fc0, 0x000c0400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff,=
 0xffffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 pitcairn_golden_rlc_registers[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x263e, 0xffffffff, 0x12011003,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3109, 0xffffffff, 0x00601004,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGB_ADDR_CONFIG, 0xffffffff, 0x12011003=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_PARAMS, 0xffffffff, 0x00601004,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x311f, 0xffffffff, 0x101020=
20,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3122, 0xffffffff, 0x010000=
20,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30c5, 0xffffffff, 0x00000800,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30c3, 0xffffffff, 0x800000a4<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_CNTR_MAX, 0xffffffff, 0x0000080=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_CNTL, 0xffffffff, 0x800000a4,<b=
r>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 verde_pg_init[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x40000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4e, 0xffffffff, 0x200010ff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x7007,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4e, 0xffffffff, 0x300010ff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x400000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4e, 0xffffffff, 0x100010ff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x120200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4e, 0xffffffff, 0x500010ff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x1e1e16,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4e, 0xffffffff, 0x600010ff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x171f1e,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4e, 0xffffffff, 0x700010ff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4f, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d4e, 0xffffffff, 0x9ff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x10000800,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0xf,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0xf,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x4,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x1000051e,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0xffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0xffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x8,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x80500,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x12,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x9050c,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x1d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0xb052c,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x2a,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x1053e,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x2d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x10546,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x30,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0xa054e,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x3c,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x1055f,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x3f,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x10567,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x42,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x1056f,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x45,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x10572,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x48,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x20575,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x4c,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x190801,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x67,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x1082a,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x6a,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x1b082d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x87,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x310851,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0xba,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x891,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0xbc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x893,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0xbe,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x20895,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0xc2,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x20899,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0xc6,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x2089d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0xca,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x8a1,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0xcc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x8a3,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0xce,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x308a5,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0xd3,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x6d08cd,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x142,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x2000095a,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x1,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x144,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x301f095b,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x165,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0xc094d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x173,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0xf096d,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x184,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x15097f,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x19b,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0xc0998,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x1a9,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x409a7,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x1af,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0xcdc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d40, 0xffffffff, 0x1b1,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d41, 0xffffffff, 0x800,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d42, 0xffffffff, 0x6c9b2000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d44, 0xfc00, 0x2000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0d51, 0xffffffff, 0xfc0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0a35, 0x00000100, 0x100<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x40000=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x2000=
10ff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x7007,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x3000=
10ff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x40000=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x1000=
10ff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x12020=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x5000=
10ff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x1e1e1=
6,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x6000=
10ff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x171f1=
e,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x7000=
10ff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_WRITE, 0xffffffff, 0x0,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_PGFSM_CONFIG, 0xffffffff, 0x9ff,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x0,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x100=
00800,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xf,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xf,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x4,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x100=
0051e,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xfff=
f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xfff=
f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x8,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x805=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x12=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x905=
0c,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x1d=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xb05=
2c,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x2a=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x105=
3e,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x2d=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x105=
46,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x30=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xa05=
4e,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x3c=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x105=
5f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x3f=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x105=
67,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x42=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x105=
6f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x45=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x105=
72,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x48=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x205=
75,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x4c=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x190=
801,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x67=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x108=
2a,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x6a=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x1b0=
82d,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x87=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x310=
851,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xba=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x891=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xbc=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x893=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xbe=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x208=
95,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xc2=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x208=
99,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xc6=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x208=
9d,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xca=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x8a1=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xcc=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x8a3=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xce=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x308=
a5,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0xd3=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x6d0=
8cd,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x14=
2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x200=
0095a,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x1,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x14=
4,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x301=
f095b,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x16=
5,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xc09=
4d,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x17=
3,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xf09=
6d,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x18=
4,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x150=
97f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x19=
b,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xc09=
98,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x1a=
9,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x409=
a7,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x1a=
f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0xcdc=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_INDEX, 0xffffffff, 0x1b=
1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_RAM_DATA, 0xffffffff, 0x800=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_RENG_EXECUTE, 0xffffffff, 0x6c9b=
2000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_MISC2, 0xfc00, 0x2000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGMCON_MISC3, 0xffffffff, 0xfc0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_PMG_AUTO_CFG, 0x00000100, 0x100,<br=
>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 verde_golden_rlc_registers[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x263e, 0xffffffff, 0x02010002,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3109, 0xffffffff, 0x033f1005,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGB_ADDR_CONFIG, 0xffffffff, 0x02010002=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_PARAMS, 0xffffffff, 0x033f1005,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x311f, 0xffffffff, 0x108080=
20,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3122, 0xffffffff, 0x008000=
08,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30c5, 0xffffffff, 0x00001000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30c3, 0xffffffff, 0x80010014<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_CNTR_MAX, 0xffffffff, 0x0000100=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_CNTL, 0xffffffff, 0x80010014,<b=
r>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 verde_golden_registers[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x17bc, 0x00000030, 0x00000011,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2684, 0x00010000, 0x00018208,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260c, 0xffffffff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260d, 0xf00fffff, 0x00000400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260e, 0x0002021c, 0x00020200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x031e, 0x00000080, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmAZALIA_SCLK_CONTROL, 0x00000030, 0x000=
00011,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_HW_CONTROL, 0x00010000, 0x00018208,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG, 0xffffffff, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG2, 0xf00fffff, 0x00000400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG3, 0x0002021c, 0x00020200,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDCI_CLK_CNTL, 0x00000080, 0x00000000,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x340c, 0x000300c0, 0x008000=
40,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x360c, 0x000300c0, 0x008000=
40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x16ec, 0x000000f0, 0x00000070,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x16f0, 0x00200000, 0x50100000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x1c0c, 0x31000311, 0x00000011,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0ab9, 0x00073ffe, 0x000022a2,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0903, 0x000007ff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2285, 0xf000001f, 0x00000007,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22c9, 0xffffffff, 0x00ffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22c4, 0x0000ff0f, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xa293, 0x07ffffff, 0x4e000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xa0d4, 0x3f3f3fff, 0x0000124a,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_MISC, 0x00200000, 0x50100000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDIG0_HDMI_CONTROL, 0x31000311, 0x00000=
011,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_SEQ_PMG_PG_HWCNTL, 0x00073ffe, 0x00=
0022a2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_XPB_P2P_BAR_CFG, 0x000007ff, 0x0000=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_CL_ENHANCE, 0xf000001f, 0x00000007,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_FORCE_EOV_MAX_CNTS, 0xffffffff, =
0x00ffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, =
0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_MODE_CNTL_1, 0x07ffffff, 0x4e000=
000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_RASTER_CONFIG, 0x3f3f3fff, 0x000=
0124a,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c, 0xffffffff, 0x0040,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000d, 0x00000040, 0x000040=
40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2440, 0x07ffffff, 0x03000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x23a2, 0x01ff1f3f, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x23a1, 0x01ff1f3f, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2418, 0x0000007f, 0x00000020,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2542, 0x00010000, 0x00010000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b05, 0x000003ff, 0x00000003,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b04, 0xffffffff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b03, 0xffffffff, 0x00001032,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2235, 0x0000001f, 0x00000010,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0570, 0x000c0fc0, 0x000c0400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052c, 0x0fffffff, 0xffffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052d, 0x0fffffff, 0x0fffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052e, 0x0fffffff, 0x0fffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052f, 0x0fffffff, 0x0fffffff<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_CONFIG_CNTL, 0x07ffffff, 0x0300000=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSQ_DED_CNT, 0x01ff1f3f, 0x00000000,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSQ_SEC_CNT, 0x01ff1f3f, 0x00000000,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSX_DEBUG_1, 0x0000007f, 0x00000020,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CNTL_AUX, 0x00010000, 0x00010000,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_ADDR_CONFIG, 0x000003ff, 0x0000000=
3,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_HI, 0xffffffff, 0x00000=
000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_LO, 0xffffffff, 0x00001=
032,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVGT_GS_VERTEX_REUSE, 0x0000001f, 0x000=
00010,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_L2_CG, 0x000c0fc0, 0x000c0400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff,=
 0xffffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 oland_golden_registers[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x17bc, 0x00000030, 0x00000011,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2684, 0x00010000, 0x00018208,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260c, 0xffffffff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260d, 0xf00fffff, 0x00000400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260e, 0x0002021c, 0x00020200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x031e, 0x00000080, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmAZALIA_SCLK_CONTROL, 0x00000030, 0x000=
00011,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_HW_CONTROL, 0x00010000, 0x00018208,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG, 0xffffffff, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG2, 0xf00fffff, 0x00000400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG3, 0x0002021c, 0x00020200,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDCI_CLK_CNTL, 0x00000080, 0x00000000,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x340c, 0x000300c0, 0x008000=
40,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x360c, 0x000300c0, 0x008000=
40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x16ec, 0x000000f0, 0x00000070,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x16f0, 0x00200000, 0x50100000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x1c0c, 0x31000311, 0x00000011,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0ab9, 0x00073ffe, 0x000022a2,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0903, 0x000007ff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2285, 0xf000001f, 0x00000007,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22c9, 0xffffffff, 0x00ffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22c4, 0x0000ff0f, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xa293, 0x07ffffff, 0x4e000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xa0d4, 0x3f3f3fff, 0x00000082,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmFBC_MISC, 0x00200000, 0x50100000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDIG0_HDMI_CONTROL, 0x31000311, 0x00000=
011,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_SEQ_PMG_PG_HWCNTL, 0x00073ffe, 0x00=
0022a2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_XPB_P2P_BAR_CFG, 0x000007ff, 0x0000=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_CL_ENHANCE, 0xf000001f, 0x00000007,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_FORCE_EOV_MAX_CNTS, 0xffffffff, =
0x00ffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, =
0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_MODE_CNTL_1, 0x07ffffff, 0x4e000=
000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_RASTER_CONFIG, 0x3f3f3fff, 0x000=
00082,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c, 0xffffffff, 0x0040,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000d, 0x00000040, 0x000040=
40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2440, 0x07ffffff, 0x03000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2418, 0x0000007f, 0x00000020,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2542, 0x00010000, 0x00010000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b05, 0x000003ff, 0x000000f3,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b04, 0xffffffff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b03, 0xffffffff, 0x00003210,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2235, 0x0000001f, 0x00000010,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0570, 0x000c0fc0, 0x000c0400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052c, 0x0fffffff, 0xffffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052d, 0x0fffffff, 0x0fffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052e, 0x0fffffff, 0x0fffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052f, 0x0fffffff, 0x0fffffff<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_CONFIG_CNTL, 0x07ffffff, 0x0300000=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSX_DEBUG_1, 0x0000007f, 0x00000020,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CNTL_AUX, 0x00010000, 0x00010000,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_ADDR_CONFIG, 0x000003ff, 0x000000f=
3,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_HI, 0xffffffff, 0x00000=
000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_LO, 0xffffffff, 0x00003=
210,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVGT_GS_VERTEX_REUSE, 0x0000001f, 0x000=
00010,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_L2_CG, 0x000c0fc0, 0x000c0400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff,=
 0xffffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt; &#43;<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 oland_golden_rlc_registers[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x263e, 0xffffffff, 0x02010002,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3109, 0xffffffff, 0x00601005,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGB_ADDR_CONFIG, 0xffffffff, 0x02010002=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_PARAMS, 0xffffffff, 0x00601005,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x311f, 0xffffffff, 0x101040=
40,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3122, 0xffffffff, 0x010000=
0a,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30c5, 0xffffffff, 0x00000800,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30c3, 0xffffffff, 0x800000f4<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_CNTR_MAX, 0xffffffff, 0x0000080=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_LB_CNTL, 0xffffffff, 0x800000f4,<b=
r>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 hainan_golden_registers[] =3D<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x17bc, 0x00000030, 0x000000=
11,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2684, 0x00010000, 0x00018208,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260c, 0xffffffff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260d, 0xf00fffff, 0x00000400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x260e, 0x0002021c, 0x00020200,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_HW_CONTROL, 0x00010000, 0x00018208,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG, 0xffffffff, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG2, 0xf00fffff, 0x00000400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_DEBUG3, 0x0002021c, 0x00020200,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x031e, 0x00000080, 0x000000=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3430, 0xff000fff, 0x000001=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x340c, 0x000300c0, 0x008000=
40,<br>
&gt; @@ -379,63 &#43;385,63 @@ static const u32 hainan_golden_registers[] =
=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x16ec, 0x000000f0, 0x000000=
70,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x16f0, 0x00200000, 0x501000=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1c0c, 0x31000311, 0x000000=
11,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0ab9, 0x00073ffe, 0x000022a2,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0903, 0x000007ff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2285, 0xf000001f, 0x00000007,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22c9, 0xffffffff, 0x00ffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22c4, 0x0000ff0f, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xa293, 0x07ffffff, 0x4e000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0xa0d4, 0x3f3f3fff, 0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_SEQ_PMG_PG_HWCNTL, 0x00073ffe, 0x00=
0022a2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_XPB_P2P_BAR_CFG, 0x000007ff, 0x0000=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_CL_ENHANCE, 0xf000001f, 0x00000007,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_FORCE_EOV_MAX_CNTS, 0xffffffff, =
0x00ffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, =
0x00000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_MODE_CNTL_1, 0x07ffffff, 0x4e000=
000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmPA_SC_RASTER_CONFIG, 0x3f3f3fff, 0x000=
00000,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c, 0xffffffff, 0x0040,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000d, 0x00000040, 0x000040=
40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2440, 0x03e00000, 0x03600000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2418, 0x0000007f, 0x00000020,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2542, 0x00010000, 0x00010000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b05, 0x000003ff, 0x000000f1,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b04, 0xffffffff, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b03, 0xffffffff, 0x00003210,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2235, 0x0000001f, 0x00000010,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0570, 0x000c0fc0, 0x000c0400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052c, 0x0fffffff, 0xffffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052d, 0x0fffffff, 0x0fffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052e, 0x0fffffff, 0x0fffffff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x052f, 0x0fffffff, 0x0fffffff<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSPI_CONFIG_CNTL, 0x03e00000, 0x0360000=
0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmSX_DEBUG_1, 0x0000007f, 0x00000020,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CNTL_AUX, 0x00010000, 0x00010000,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_ADDR_CONFIG, 0x000003ff, 0x000000f=
1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_HI, 0xffffffff, 0x00000=
000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCP_CHAN_STEER_LO, 0xffffffff, 0x00003=
210,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVGT_GS_VERTEX_REUSE, 0x0000001f, 0x000=
00010,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_L2_CG, 0x000c0fc0, 0x000c0400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff,=
 0xffffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff,=
 0x0fffffff,<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 hainan_golden_registers2[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x263e, 0xffffffff, 0x2011003<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGB_ADDR_CONFIG, 0xffffffff, 0x2011003,=
<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const u32 tahiti_mgcg_cgcg_init[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3100, 0xffffffff, 0xfffffffc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x200b, 0xffffffff, 0xe0000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2698, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x24a9, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3059, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x25dd, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2261, 0xffffffff, 0x06000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2286, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x24a8, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30e0, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22ca, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2451, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2362, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2363, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240c, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240d, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240e, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240f, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b60, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b15, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x225f, 0xffffffff, 0x06000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x261a, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2544, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2bc1, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b81, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2527, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x200b, 0xffffffff, 0xe0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGTT_MGCG_OVERRIDE, 0xffffffff, 0x=
fffffffc,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_CGTT_SCLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_BCI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_CP_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_GDS_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_IA_CLK_CTRL, 0xffffffff, 0x060001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PA_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PC_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_RLC_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SC_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SPI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQ_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQG_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL0, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL1, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL2, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL3, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCP_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_VGT_CLK_CTRL, 0xffffffff, 0x06000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_CGTT_CLK_CTRL_0, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CGTT_CTRL, 0xffffffff, 0x00000100,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCA_CGTT_SCLK_CTRL, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCC_CGTT_SCLK_CTRL, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTD_CGTT_CTRL, 0xffffffff, 0x00000100,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2458, 0xffffffff, 0x000100=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2459, 0xffffffff, 0x000300=
02,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x245a, 0xffffffff, 0x000400=
07,<br>
&gt; @@ -516,55 &#43;522,55 @@ static const u32 tahiti_mgcg_cgcg_init[] =3D=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x24a5, 0xffffffff, 0x000000=
15,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x24a6, 0xffffffff, 0x001400=
13,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x24a7, 0xffffffff, 0x001700=
16,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2454, 0xffffffff, 0x96940200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x21c2, 0xffffffff, 0x00900100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x311e, 0xffffffff, 0x00000080,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3101, 0xffffffff, 0x0020003f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_SM_CTRL_REG, 0xffffffff, 0x969402=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_RB_WPTR_POLL_CNTL, 0xffffffff, 0x00=
900100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_GCPM_GENERAL_3, 0xffffffff, 0x0000=
0080,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGCG_CGLS_CTRL, 0xffffffff, 0x0020=
003f,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c, 0xffffffff, 0x000000=
1c,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000d, 0x000f0000, 0x000f00=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0583, 0xffffffff, 0x000001=
00,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0409, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x040b, 0x00000101, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x082a, 0xffffffff, 0x00000104,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0993, 0x000c0000, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0992, 0x000c0000, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x1579, 0xff000fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x=
00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x000=
00000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_MEM_POWER_LS, 0xffffffff, 0x0000010=
4,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_CITF_MISC_WR_CG, 0x000c0000, 0x000c=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_CITF_MISC_RD_CG, 0x000c0000, 0x000c=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_DRM_CLK_CTRL0, 0xff000fff, 0x0000=
0100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x157a, 0x00000001, 0x000000=
01,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0bd4, 0x00000001, 0x00000001,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0c33, 0xc0000fff, 0x00000104,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3079, 0x00000001, 0x00000001,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_MEM_POWER_LS, 0x00000001, 0x000000=
01,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_XDP_CGTT_BLK_CTRL, 0xc0000fff, 0x0=
0000104,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_MEM_SLP_CNTL, 0x00000001, 0x0000000=
1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3430, 0xfffffff0, 0x000001=
00,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3630, 0xfffffff0, 0x00000100<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; 0x3630, 0xfffffff0, 0x00000100,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; static const u32 pitcairn_mgcg_cgcg_init[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3100, 0xffffffff, 0xfffffffc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x200b, 0xffffffff, 0xe0000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2698, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x24a9, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3059, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x25dd, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2261, 0xffffffff, 0x06000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2286, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x24a8, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30e0, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22ca, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2451, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2362, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2363, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240c, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240d, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240e, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240f, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b60, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b15, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x225f, 0xffffffff, 0x06000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x261a, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2544, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2bc1, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b81, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2527, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x200b, 0xffffffff, 0xe0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGTT_MGCG_OVERRIDE, 0xffffffff, 0x=
fffffffc,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_CGTT_SCLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_BCI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_CP_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_GDS_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_IA_CLK_CTRL, 0xffffffff, 0x060001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PA_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PC_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_RLC_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SC_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SPI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQ_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQG_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL0, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL1, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL2, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL3, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCP_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_VGT_CLK_CTRL, 0xffffffff, 0x06000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_CGTT_CLK_CTRL_0, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CGTT_CTRL, 0xffffffff, 0x00000100,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCA_CGTT_SCLK_CTRL, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCC_CGTT_SCLK_CTRL, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTD_CGTT_CTRL, 0xffffffff, 0x00000100,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2458, 0xffffffff, 0x000100=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2459, 0xffffffff, 0x000300=
02,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x245a, 0xffffffff, 0x000400=
07,<br>
&gt; @@ -615,53 &#43;621,54 @@ static const u32 pitcairn_mgcg_cgcg_init[] =
=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2496, 0xffffffff, 0x001000=
13,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2497, 0xffffffff, 0x001200=
11,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2498, 0xffffffff, 0x001500=
14,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2454, 0xffffffff, 0x96940200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x21c2, 0xffffffff, 0x00900100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x311e, 0xffffffff, 0x00000080,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3101, 0xffffffff, 0x0020003f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_SM_CTRL_REG, 0xffffffff, 0x969402=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_RB_WPTR_POLL_CNTL, 0xffffffff, 0x00=
900100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_GCPM_GENERAL_3, 0xffffffff, 0x0000=
0080,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGCG_CGLS_CTRL, 0xffffffff, 0x0020=
003f,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c, 0xffffffff, 0x000000=
1c,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000d, 0x000f0000, 0x000f00=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0583, 0xffffffff, 0x000001=
00,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0409, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x040b, 0x00000101, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x082a, 0xffffffff, 0x00000104,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x1579, 0xff000fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x=
00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x000=
00000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_MEM_POWER_LS, 0xffffffff, 0x0000010=
4,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_DRM_CLK_CTRL0, 0xff000fff, 0x0000=
0100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x157a, 0x00000001, 0x000000=
01,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0bd4, 0x00000001, 0x00000001,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0c33, 0xc0000fff, 0x00000104,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3079, 0x00000001, 0x00000001,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_MEM_POWER_LS, 0x00000001, 0x000000=
01,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_XDP_CGTT_BLK_CTRL, 0xc0000fff, 0x0=
0000104,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_MEM_SLP_CNTL, 0x00000001, 0x0000000=
1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3430, 0xfffffff0, 0x000001=
00,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3630, 0xfffffff0, 0x00000100<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; 0x3630, 0xfffffff0, 0x00000100,<br>
&gt;&nbsp; };<br>
&gt; &#43;<br>
&gt;&nbsp; static const u32 verde_mgcg_cgcg_init[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3100, 0xffffffff, 0xfffffffc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x200b, 0xffffffff, 0xe0000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2698, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x24a9, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3059, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x25dd, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2261, 0xffffffff, 0x06000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2286, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x24a8, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30e0, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22ca, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2451, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2362, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2363, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240c, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240d, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240e, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240f, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b60, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b15, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x225f, 0xffffffff, 0x06000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x261a, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2544, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2bc1, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b81, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2527, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x200b, 0xffffffff, 0xe0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGTT_MGCG_OVERRIDE, 0xffffffff, 0x=
fffffffc,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_CGTT_SCLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_BCI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_CP_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_GDS_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_IA_CLK_CTRL, 0xffffffff, 0x060001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PA_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PC_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_RLC_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SC_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SPI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQ_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQG_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL0, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL1, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL2, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL3, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCP_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_VGT_CLK_CTRL, 0xffffffff, 0x06000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_CGTT_CLK_CTRL_0, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CGTT_CTRL, 0xffffffff, 0x00000100,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCA_CGTT_SCLK_CTRL, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCC_CGTT_SCLK_CTRL, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTD_CGTT_CTRL, 0xffffffff, 0x00000100,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2458, 0xffffffff, 0x000100=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2459, 0xffffffff, 0x000300=
02,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x245a, 0xffffffff, 0x000400=
07,<br>
&gt; @@ -712,55 &#43;719,56 @@ static const u32 verde_mgcg_cgcg_init[] =3D<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2496, 0xffffffff, 0x001000=
13,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2497, 0xffffffff, 0x001200=
11,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2498, 0xffffffff, 0x001500=
14,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2454, 0xffffffff, 0x96940200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x21c2, 0xffffffff, 0x00900100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x311e, 0xffffffff, 0x00000080,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3101, 0xffffffff, 0x0020003f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_SM_CTRL_REG, 0xffffffff, 0x969402=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_RB_WPTR_POLL_CNTL, 0xffffffff, 0x00=
900100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_GCPM_GENERAL_3, 0xffffffff, 0x0000=
0080,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGCG_CGLS_CTRL, 0xffffffff, 0x0020=
003f,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c, 0xffffffff, 0x000000=
1c,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000d, 0x000f0000, 0x000f00=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0583, 0xffffffff, 0x000001=
00,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0409, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x040b, 0x00000101, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x082a, 0xffffffff, 0x00000104,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0993, 0x000c0000, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0992, 0x000c0000, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x1579, 0xff000fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x=
00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x000=
00000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_MEM_POWER_LS, 0xffffffff, 0x0000010=
4,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_CITF_MISC_WR_CG, 0x000c0000, 0x000c=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_CITF_MISC_RD_CG, 0x000c0000, 0x000c=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_DRM_CLK_CTRL0, 0xff000fff, 0x0000=
0100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x157a, 0x00000001, 0x000000=
01,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0bd4, 0x00000001, 0x00000001,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0c33, 0xc0000fff, 0x00000104,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3079, 0x00000001, 0x00000001,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_MEM_POWER_LS, 0x00000001, 0x000000=
01,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_XDP_CGTT_BLK_CTRL, 0xc0000fff, 0x0=
0000104,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_MEM_SLP_CNTL, 0x00000001, 0x0000000=
1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3430, 0xfffffff0, 0x000001=
00,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3630, 0xfffffff0, 0x00000100<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; 0x3630, 0xfffffff0, 0x00000100,<br>
&gt;&nbsp; };<br>
&gt; &#43;<br>
&gt;&nbsp; static const u32 oland_mgcg_cgcg_init[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3100, 0xffffffff, 0xfffffffc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x200b, 0xffffffff, 0xe0000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2698, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x24a9, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3059, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x25dd, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2261, 0xffffffff, 0x06000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2286, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x24a8, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30e0, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22ca, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2451, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2362, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2363, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240c, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240d, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240e, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240f, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b60, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b15, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x225f, 0xffffffff, 0x06000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x261a, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2544, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2bc1, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b81, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2527, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x200b, 0xffffffff, 0xe0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGTT_MGCG_OVERRIDE, 0xffffffff, 0x=
fffffffc,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_CGTT_SCLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_BCI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_CP_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_GDS_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_IA_CLK_CTRL, 0xffffffff, 0x060001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PA_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PC_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_RLC_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SC_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SPI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQ_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQG_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL0, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL1, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL2, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL3, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCP_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_VGT_CLK_CTRL, 0xffffffff, 0x06000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_CGTT_CLK_CTRL_0, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CGTT_CTRL, 0xffffffff, 0x00000100,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCA_CGTT_SCLK_CTRL, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCC_CGTT_SCLK_CTRL, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTD_CGTT_CTRL, 0xffffffff, 0x00000100,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2458, 0xffffffff, 0x000100=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2459, 0xffffffff, 0x000300=
02,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x245a, 0xffffffff, 0x000400=
07,<br>
&gt; @@ -791,55 &#43;799,56 @@ static const u32 oland_mgcg_cgcg_init[] =3D<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2473, 0xffffffff, 0x000000=
0b,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2474, 0xffffffff, 0x000a00=
09,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2475, 0xffffffff, 0x000d00=
0c,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2454, 0xffffffff, 0x96940200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x21c2, 0xffffffff, 0x00900100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x311e, 0xffffffff, 0x00000080,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3101, 0xffffffff, 0x0020003f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_SM_CTRL_REG, 0xffffffff, 0x969402=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_RB_WPTR_POLL_CNTL, 0xffffffff, 0x00=
900100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_GCPM_GENERAL_3, 0xffffffff, 0x0000=
0080,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGCG_CGLS_CTRL, 0xffffffff, 0x0020=
003f,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c, 0xffffffff, 0x000000=
1c,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000d, 0x000f0000, 0x000f00=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0583, 0xffffffff, 0x000001=
00,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0409, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x040b, 0x00000101, 0x00000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x082a, 0xffffffff, 0x00000104,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0993, 0x000c0000, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0992, 0x000c0000, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x1579, 0xff000fff, 0x00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x=
00000100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x000=
00000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_MEM_POWER_LS, 0xffffffff, 0x0000010=
4,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_CITF_MISC_WR_CG, 0x000c0000, 0x000c=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_CITF_MISC_RD_CG, 0x000c0000, 0x000c=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_DRM_CLK_CTRL0, 0xff000fff, 0x0000=
0100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x157a, 0x00000001, 0x000000=
01,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0bd4, 0x00000001, 0x00000001,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0c33, 0xc0000fff, 0x00000104,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3079, 0x00000001, 0x00000001,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_MEM_POWER_LS, 0x00000001, 0x000000=
01,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_XDP_CGTT_BLK_CTRL, 0xc0000fff, 0x0=
0000104,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_MEM_SLP_CNTL, 0x00000001, 0x0000000=
1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3430, 0xfffffff0, 0x000001=
00,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3630, 0xfffffff0, 0x00000100<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; 0x3630, 0xfffffff0, 0x00000100,<br>
&gt;&nbsp; };<br>
&gt; &#43;<br>
&gt;&nbsp; static const u32 hainan_mgcg_cgcg_init[] =3D<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3100, 0xffffffff, 0xfffffffc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x200b, 0xffffffff, 0xe0000000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2698, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x24a9, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3059, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x25dd, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2261, 0xffffffff, 0x06000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2286, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x24a8, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x30e0, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x22ca, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2451, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2362, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2363, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240c, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240d, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240e, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x240f, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b60, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b15, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x225f, 0xffffffff, 0x06000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x261a, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2544, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2bc1, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2b81, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2527, 0xffffffff, 0x00000100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x200b, 0xffffffff, 0xe0000000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGTT_MGCG_OVERRIDE, 0xffffffff, 0x=
fffffffc,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCB_CGTT_SCLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_BCI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_CP_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_GDS_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_IA_CLK_CTRL, 0xffffffff, 0x060001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PA_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_PC_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_RLC_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SC_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SPI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQ_CLK_CTRL, 0xffffffff, 0x000001=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SQG_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL0, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL1, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL2, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_SX_CLK_CTRL3, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCI_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_TCP_CLK_CTRL, 0xffffffff, 0x00000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTT_VGT_CLK_CTRL, 0xffffffff, 0x06000=
100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmDB_CGTT_CLK_CTRL_0, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTA_CGTT_CTRL, 0xffffffff, 0x00000100,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCA_CGTT_SCLK_CTRL, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTCC_CGTT_SCLK_CTRL, 0xffffffff, 0x0000=
0100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmTD_CGTT_CTRL, 0xffffffff, 0x00000100,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2458, 0xffffffff, 0x000100=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2459, 0xffffffff, 0x000300=
02,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x245a, 0xffffffff, 0x000400=
07,<br>
&gt; @@ -870,22 &#43;879,22 @@ static const u32 hainan_mgcg_cgcg_init[] =3D=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2473, 0xffffffff, 0x000000=
0b,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2474, 0xffffffff, 0x000a00=
09,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2475, 0xffffffff, 0x000d00=
0c,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x2454, 0xffffffff, 0x96940200,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x21c2, 0xffffffff, 0x00900100,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x311e, 0xffffffff, 0x00000080,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3101, 0xffffffff, 0x0020003f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCGTS_SM_CTRL_REG, 0xffffffff, 0x969402=
00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_RB_WPTR_POLL_CNTL, 0xffffffff, 0x00=
900100,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_GCPM_GENERAL_3, 0xffffffff, 0x0000=
0080,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_CGCG_CGLS_CTRL, 0xffffffff, 0x0020=
003f,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000c, 0xffffffff, 0x000000=
1c,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000d, 0x000f0000, 0x000f00=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0583, 0xffffffff, 0x000001=
00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0409, 0xffffffff, 0x000001=
00,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x082a, 0xffffffff, 0x00000104,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0993, 0x000c0000, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0992, 0x000c0000, 0x000c0000,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0bd4, 0x00000001, 0x00000001,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x0c33, 0xc0000fff, 0x00000104,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3079, 0x00000001, 0x00000001,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_MEM_POWER_LS, 0xffffffff, 0x0000010=
4,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_CITF_MISC_WR_CG, 0x000c0000, 0x000c=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmMC_CITF_MISC_RD_CG, 0x000c0000, 0x000c=
0000,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_MEM_POWER_LS, 0x00000001, 0x000000=
01,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmHDP_XDP_CGTT_BLK_CTRL, 0xc0000fff, 0x0=
0000104,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmCP_MEM_SLP_CNTL, 0x00000001, 0x0000000=
1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3430, 0xfffffff0, 0x000001=
00,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; 0x3630, 0xfffffff0, 0x00000100<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; 0x3630, 0xfffffff0, 0x00000100,<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static u32 si_pcie_rreg(struct amdgpu_device *adev, u32 reg)<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB17685A0FE018598D10CCA849F79C0CY4PR12MB1768namp_--

--_004_CY4PR12MB17685A0FE018598D10CCA849F79C0CY4PR12MB1768namp_
Content-Type: application/x-shellscript; name="unnum.sh"
Content-Description: unnum.sh
Content-Disposition: attachment; filename="unnum.sh"; size=439;
	creation-date="Fri, 16 Dec 2016 15:03:18 GMT";
	modification-date="Fri, 16 Dec 2016 15:03:18 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKIwkweDE3YmMsIDB4MDAwMDAwMzAsIDB4MDAwMDAwMTEsCgpybSAtZiAvdG1w
L3VuLnR4dAp3aGlsZSByZWFkIGxpbmU7IGRvCglsPWBlY2hvICR7bGluZX0gfCB0ciAnLCcgJyAn
YAoJYWRkcj1gZWNobyAke2x9IHwgYXdrICd7IHByaW50ICQxOyB9J2AKCW1hc2s9YGVjaG8gJHts
fSB8IGF3ayAneyBwcmludCAkMjsgfSdgCgl2YWx1ZT1gZWNobyAke2x9IHwgYXdrICd7IHByaW50
ICQzOyB9J2AKCglyZWc9YHVtciAtZiAkMSAtbHUgJHthZGRyfSAwIHwgaGVhZCAtbjEgfCBhd2sg
J3sgcHJpbnQgJDE7IH0nYAoJaWYgWyAiJHtyZWd9IiA9PSAiIiBdOyB0aGVuIHJlZz0ke2FkZHJ9
OyBmaQoJcHJpbnRmICJcdCR7cmVnfSwgJHttYXNrfSwgJHt2YWx1ZX0sXG4iID4+IC90bXAvdW4u
dHh0CmRvbmUKZWNobwplY2hvCmVjaG8KY2F0IC90bXAvdW4udHh0Cg==

--_004_CY4PR12MB17685A0FE018598D10CCA849F79C0CY4PR12MB1768namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_CY4PR12MB17685A0FE018598D10CCA849F79C0CY4PR12MB1768namp_--
