From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Reorganize *_flush_gpu_tlb() for kfd to
 use
Date: Tue, 23 Oct 2018 21:31:01 +0000
Message-ID: <BL0PR12MB250058AE33487BB6D86DE290F0F50@BL0PR12MB2500.namprd12.prod.outlook.com>
References: <1540318546-1468-1-git-send-email-Yong.Zhao@amd.com>,
 <367bc700-8dae-1877-5b77-b28f0ba2e118@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1919232818=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <367bc700-8dae-1877-5b77-b28f0ba2e118-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, brahma_sw_dev <brahma_sw_dev-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1919232818==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR12MB250058AE33487BB6D86DE290F0F50BL0PR12MB2500namp_"

--_000_BL0PR12MB250058AE33487BB6D86DE290F0F50BL0PR12MB2500namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Revised accordingly, and pushed. Thanks!


Yong

________________________________
From: Kuehling, Felix
Sent: Tuesday, October 23, 2018 4:37:45 PM
To: Zhao, Yong; brahma_sw_dev; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/2] drm/amdgpu: Reorganize *_flush_gpu_tlb() for kfd t=
o use

It occurred to me that the flush_type is a hardware-specific value, but
you're using it in a hardware-abstracted interface. If the meaning of
the flush type values changes in future HW-generations, we'll need to
define an abstract enum that gets translated to the respective HW values
in the HW-specific code.

Anyway, this works for now.

One more cosmetic comment inline ...

Other than that the series is Reviewed-by: Felix Kuehling
<Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

Regards,
  Felix

On 2018-10-23 2:15 p.m., Zhao, Yong wrote:
> Add a flush_type parameter to that series of functions.
>
> Change-Id: I3dcd71955297c53b181f82e7078981230c642c01
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c    |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c    |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 19 ++++++++++---------
>  6 files changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gart.c
> index 11fea28..9a212aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -248,7 +248,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, ui=
nt64_t offset,
>        }
>        mb();
>        amdgpu_asic_flush_hdp(adev, NULL);
> -     amdgpu_gmc_flush_gpu_tlb(adev, 0);
> +     amdgpu_gmc_flush_gpu_tlb(adev, 0, 0);
>        return 0;
>  }
>
> @@ -331,7 +331,7 @@ int amdgpu_gart_bind(struct amdgpu_device *adev, uint=
64_t offset,
>
>        mb();
>        amdgpu_asic_flush_hdp(adev, NULL);
> -     amdgpu_gmc_flush_gpu_tlb(adev, 0);
> +     amdgpu_gmc_flush_gpu_tlb(adev, 0, 0);
>        return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index 6fa7ef4..4c5f18c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -64,7 +64,7 @@ struct amdgpu_vmhub {
>  struct amdgpu_gmc_funcs {
>        /* flush the vm tlb via mmio */
>        void (*flush_gpu_tlb)(struct amdgpu_device *adev,
> -                           uint32_t vmid);
> +                           uint32_t vmid, uint32_t flush_type);
>        /* flush the vm tlb via ring */
>        uint64_t (*emit_flush_gpu_tlb)(struct amdgpu_ring *ring, unsigned =
vmid,
>                                       uint64_t pd_addr);
> @@ -151,7 +151,7 @@ struct amdgpu_gmc {
>        struct amdgpu_xgmi xgmi;
>  };
>
> -#define amdgpu_gmc_flush_gpu_tlb(adev, vmid) (adev)->gmc.gmc_funcs->flus=
h_gpu_tlb((adev), (vmid))
> +#define amdgpu_gmc_flush_gpu_tlb(adev, vmid, type) (adev)->gmc.gmc_funcs=
->flush_gpu_tlb((adev), (vmid), (type))
>  #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_=
funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
>  #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc=
_funcs->emit_pasid_mapping((r), (vmid), (pasid))
>  #define amdgpu_gmc_set_pte_pde(adev, pt, idx, addr, flags) (adev)->gmc.g=
mc_funcs->set_pte_pde((adev), (pt), (idx), (addr), (flags))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v6_0.c
> index e1c2b4e..2821d1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -358,7 +358,8 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *ade=
v)
>        return 0;
>  }
>
> -static void gmc_v6_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t =
vmid)
> +static void gmc_v6_0_flush_gpu_tlb(struct amdgpu_device *adev,
> +                             uint32_t vmid, uint32_t flush_type)
>  {
>        WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
>  }
> @@ -580,7 +581,7 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device =
*adev)
>        else
>                gmc_v6_0_set_fault_enable_default(adev, true);
>
> -     gmc_v6_0_flush_gpu_tlb(adev, 0);
> +     gmc_v6_0_flush_gpu_tlb(adev, 0, 0);
>        dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX)=
.\n",
>                 (unsigned)(adev->gmc.gart_size >> 20),
>                 (unsigned long long)table_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index 910c4ce..761dcfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -430,7 +430,8 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *ade=
v)
>   *
>   * Flush the TLB for the requested page table (CIK).
>   */
> -static void gmc_v7_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t =
vmid)
> +static void gmc_v7_0_flush_gpu_tlb(struct amdgpu_device *adev,
> +                             uint32_t vmid, uint32_t flush_type)
>  {
>        /* bits 0-15 are the VM contexts0-15 */
>        WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
> @@ -698,7 +699,7 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device =
*adev)
>                WREG32(mmCHUB_CONTROL, tmp);
>        }
>
> -     gmc_v7_0_flush_gpu_tlb(adev, 0);
> +     gmc_v7_0_flush_gpu_tlb(adev, 0, 0);
>        DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>                 (unsigned)(adev->gmc.gart_size >> 20),
>                 (unsigned long long)table_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index 1d3265c..531aaf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -611,7 +611,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *ade=
v)
>   * Flush the TLB for the requested page table (CIK).
>   */
>  static void gmc_v8_0_flush_gpu_tlb(struct amdgpu_device *adev,
> -                                     uint32_t vmid)
> +                             uint32_t vmid, uint32_t flush_type)
>  {
>        /* bits 0-15 are the VM contexts0-15 */
>        WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
> @@ -920,7 +920,7 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device =
*adev)
>        else
>                gmc_v8_0_set_fault_enable_default(adev, true);
>
> -     gmc_v8_0_flush_gpu_tlb(adev, 0);
> +     gmc_v8_0_flush_gpu_tlb(adev, 0, 0);
>        DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>                 (unsigned)(adev->gmc.gart_size >> 20),
>                 (unsigned long long)table_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index f35d7a5..79d8a84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -293,14 +293,15 @@ static void gmc_v9_0_set_irq_funcs(struct amdgpu_de=
vice *adev)
>        adev->gmc.vm_fault.funcs =3D &gmc_v9_0_irq_funcs;
>  }
>
> -static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid)
> +static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
> +                                     uint32_t flush_type)
>  {
>        u32 req =3D 0;
>
>        /* invalidate using legacy mode on vmid*/

This comment is no longer accurate.


>        req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
>                            PER_VMID_INVALIDATE_REQ, 1 << vmid);
> -     req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, 0);
> +     req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flus=
h_type);
>        req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_P=
TES, 1);
>        req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_P=
DE0, 1);
>        req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_P=
DE1, 1);
> @@ -362,24 +363,24 @@ static signed long  amdgpu_kiq_reg_write_reg_wait(s=
truct amdgpu_device *adev,
>   */
>
>  /**
> - * gmc_v9_0_flush_gpu_tlb - gart tlb flush callback
> + * gmc_v9_0_flush_gpu_tlb - tlb flush with certain type
>   *
>   * @adev: amdgpu_device pointer
>   * @vmid: vm instance to flush
> + * @flush_type: the flush type
>   *
> - * Flush the TLB for the requested page table.
> + * Flush the TLB for the requested page table using certain type.
>   */
>  static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev,
> -                                     uint32_t vmid)
> +                             uint32_t vmid, uint32_t flush_type)
>  {
> -     /* Use register 17 for GART */
>        const unsigned eng =3D 17;
>        unsigned i, j;
>        int r;
>
>        for (i =3D 0; i < AMDGPU_MAX_VMHUBS; ++i) {
>                struct amdgpu_vmhub *hub =3D &adev->vmhub[i];
> -             u32 tmp =3D gmc_v9_0_get_invalidate_req(vmid);
> +             u32 tmp =3D gmc_v9_0_get_invalidate_req(vmid, flush_type);
>
>                if (adev->gfx.kiq.ring.ready &&
>                    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))=
 &&
> @@ -429,7 +430,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct am=
dgpu_ring *ring,
>  {
>        struct amdgpu_device *adev =3D ring->adev;
>        struct amdgpu_vmhub *hub =3D &adev->vmhub[ring->funcs->vmhub];
> -     uint32_t req =3D gmc_v9_0_get_invalidate_req(vmid);
> +     uint32_t req =3D gmc_v9_0_get_invalidate_req(vmid, 0);
>        unsigned eng =3D ring->vm_inv_eng;
>
>        amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 + (2 * vmid),
> @@ -1122,7 +1123,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_devic=
e *adev)
>
>        gfxhub_v1_0_set_fault_enable_default(adev, value);
>        mmhub_v1_0_set_fault_enable_default(adev, value);
> -     gmc_v9_0_flush_gpu_tlb(adev, 0);
> +     gmc_v9_0_flush_gpu_tlb(adev, 0, 0);
>
>        DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>                 (unsigned)(adev->gmc.gart_size >> 20),

--_000_BL0PR12MB250058AE33487BB6D86DE290F0F50BL0PR12MB2500namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Revised accordingly, and pushed. =
Thanks!</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Yong</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Tuesday, October 23, 2018 4:37:45 PM<br>
<b>To:</b> Zhao, Yong; brahma_sw_dev; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Reorganize *_flush_gpu_tlb() fo=
r kfd to use</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It occurred to me that the flush_type is a hardwar=
e-specific value, but<br>
you're using it in a hardware-abstracted interface. If the meaning of<br>
the flush type values changes in future HW-generations, we'll need to<br>
define an abstract enum that gets translated to the respective HW values<br=
>
in the HW-specific code.<br>
<br>
Anyway, this works for now.<br>
<br>
One more cosmetic comment inline ...<br>
<br>
Other than that the series is Reviewed-by: Felix Kuehling<br>
&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
On 2018-10-23 2:15 p.m., Zhao, Yong wrote:<br>
&gt; Add a flush_type parameter to that series of functions.<br>
&gt;<br>
&gt; Change-Id: I3dcd71955297c53b181f82e7078981230c642c01<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |&nbsp; 4 &#43;&#43;--<=
br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp; |&nbsp; 4 &#43;&#4=
3;--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c&nbsp;&nbsp;&nbsp; |&nbsp; =
5 &#43;&#43;&#43;--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c&nbsp;&nbsp;&nbsp; |&nbsp; =
5 &#43;&#43;&#43;--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c&nbsp;&nbsp;&nbsp; |&nbsp; =
4 &#43;&#43;--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp; | 19 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&gt;&nbsp; 6 files changed, 22 insertions(&#43;), 19 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_gart.c<br>
&gt; index 11fea28..9a212aa 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c<br>
&gt; @@ -248,7 &#43;248,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *a=
dev, uint64_t offset,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, =
NULL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_flush_gpu_tlb(adev, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_flush_gpu_tlb(adev, 0, 0);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; @@ -331,7 &#43;331,7 @@ int amdgpu_gart_bind(struct amdgpu_device *ade=
v, uint64_t offset,<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, =
NULL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_flush_gpu_tlb(adev, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_flush_gpu_tlb(adev, 0, 0);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h<br>
&gt; index 6fa7ef4..4c5f18c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; @@ -64,7 &#43;64,7 @@ struct amdgpu_vmhub {<br>
&gt;&nbsp; struct amdgpu_gmc_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flush the vm tlb via mmio=
 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*flush_gpu_tlb)(struct=
 amdgpu_device *adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t vmid);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t vmid, uint32_t flush_type);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flush the vm tlb via ring=
 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t (*emit_flush_gpu_tl=
b)(struct amdgpu_ring *ring, unsigned vmid,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uint64_t pd_addr);<br>
&gt; @@ -151,7 &#43;151,7 @@ struct amdgpu_gmc {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_xgmi xgmi;<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; -#define amdgpu_gmc_flush_gpu_tlb(adev, vmid) (adev)-&gt;gmc.gmc_funcs=
-&gt;flush_gpu_tlb((adev), (vmid))<br>
&gt; &#43;#define amdgpu_gmc_flush_gpu_tlb(adev, vmid, type) (adev)-&gt;gmc=
.gmc_funcs-&gt;flush_gpu_tlb((adev), (vmid), (type))<br>
&gt;&nbsp; #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)-&gt;ade=
v-&gt;gmc.gmc_funcs-&gt;emit_flush_gpu_tlb((r), (vmid), (addr))<br>
&gt;&nbsp; #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)-&gt;ad=
ev-&gt;gmc.gmc_funcs-&gt;emit_pasid_mapping((r), (vmid), (pasid))<br>
&gt;&nbsp; #define amdgpu_gmc_set_pte_pde(adev, pt, idx, addr, flags) (adev=
)-&gt;gmc.gmc_funcs-&gt;set_pte_pde((adev), (pt), (idx), (addr), (flags))<b=
r>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v6_0.c<br>
&gt; index e1c2b4e..2821d1d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
&gt; @@ -358,7 &#43;358,8 @@ static int gmc_v6_0_mc_init(struct amdgpu_devi=
ce *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -static void gmc_v6_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32=
_t vmid)<br>
&gt; &#43;static void gmc_v6_0_flush_gpu_tlb(struct amdgpu_device *adev,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid, uint32_t flush_type)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVM_INVALIDATE_REQUE=
ST, 1 &lt;&lt; vmid);<br>
&gt;&nbsp; }<br>
&gt; @@ -580,7 &#43;581,7 @@ static int gmc_v6_0_gart_enable(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; gmc_v6_0_set_fault_enable_default(adev, true);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; gmc_v6_0_flush_gpu_tlb(adev, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v6_0_flush_gpu_tlb(adev, 0, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot=
;PCIE GART of %uM enabled (table at 0x%016llX).\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned)(adev-&gt;gmc.gart_size &gt;&gt; 20),<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long long)table_addr);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v7_0.c<br>
&gt; index 910c4ce..761dcfb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
&gt; @@ -430,7 &#43;430,8 @@ static int gmc_v7_0_mc_init(struct amdgpu_devi=
ce *adev)<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * Flush the TLB for the requested page table (CIK).<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -static void gmc_v7_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32=
_t vmid)<br>
&gt; &#43;static void gmc_v7_0_flush_gpu_tlb(struct amdgpu_device *adev,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid, uint32_t flush_type)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bits 0-15 are the VM cont=
exts0-15 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVM_INVALIDATE_REQUE=
ST, 1 &lt;&lt; vmid);<br>
&gt; @@ -698,7 &#43;699,7 @@ static int gmc_v7_0_gart_enable(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WREG32(mmCHUB_CONTROL, tmp);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; gmc_v7_0_flush_gpu_tlb(adev, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v7_0_flush_gpu_tlb(adev, 0, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;PCIE GART of =
%uM enabled (table at 0x%016llX).\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned)(adev-&gt;gmc.gart_size &gt;&gt; 20),<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long long)table_addr);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v8_0.c<br>
&gt; index 1d3265c..531aaf3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
&gt; @@ -611,7 &#43;611,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_devi=
ce *adev)<br>
&gt;&nbsp;&nbsp; * Flush the TLB for the requested page table (CIK).<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; static void gmc_v8_0_flush_gpu_tlb(struct amdgpu_device *adev,<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ui=
nt32_t vmid)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid, uint32_t flush_type)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bits 0-15 are the VM cont=
exts0-15 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVM_INVALIDATE_REQUE=
ST, 1 &lt;&lt; vmid);<br>
&gt; @@ -920,7 &#43;920,7 @@ static int gmc_v8_0_gart_enable(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; gmc_v8_0_set_fault_enable_default(adev, true);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; gmc_v8_0_flush_gpu_tlb(adev, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v8_0_flush_gpu_tlb(adev, 0, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;PCIE GART of =
%uM enabled (table at 0x%016llX).\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned)(adev-&gt;gmc.gart_size &gt;&gt; 20),<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long long)table_addr);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index f35d7a5..79d8a84 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -293,14 &#43;293,15 @@ static void gmc_v9_0_set_irq_funcs(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vm_fault.funcs =
=3D &amp;gmc_v9_0_irq_funcs;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid)<br>
&gt; &#43;static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; uint32_t flush_type)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 req =3D 0;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* invalidate using legacy m=
ode on vmid*/<br>
<br>
This comment is no longer accurate.<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req =3D REG_SET_FIELD(req, V=
M_INVALIDATE_ENG0_REQ,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; PER_VMID_INVALIDATE_REQ, 1 &lt;&lt; vmid);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; req =3D REG_SET_FIELD(req, VM_INVALIDATE_ENG=
0_REQ, FLUSH_TYPE, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; req =3D REG_SET_FIELD(req, VM_INVALIDATE=
_ENG0_REQ, FLUSH_TYPE, flush_type);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req =3D REG_SET_FIELD(req, V=
M_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req =3D REG_SET_FIELD(req, V=
M_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req =3D REG_SET_FIELD(req, V=
M_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);<br>
&gt; @@ -362,24 &#43;363,24 @@ static signed long&nbsp; amdgpu_kiq_reg_writ=
e_reg_wait(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; <br>
&gt;&nbsp; /**<br>
&gt; - * gmc_v9_0_flush_gpu_tlb - gart tlb flush callback<br>
&gt; &#43; * gmc_v9_0_flush_gpu_tlb - tlb flush with certain type<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * @adev: amdgpu_device pointer<br>
&gt;&nbsp;&nbsp; * @vmid: vm instance to flush<br>
&gt; &#43; * @flush_type: the flush type<br>
&gt;&nbsp;&nbsp; *<br>
&gt; - * Flush the TLB for the requested page table.<br>
&gt; &#43; * Flush the TLB for the requested page table using certain type.=
<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev,<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ui=
nt32_t vmid)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid, uint32_t flush_type)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Use register 17 for GART */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const unsigned eng =3D 17;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned i, j;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_=
MAX_VMHUBS; &#43;&#43;i) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_vmhub *hub =3D &amp;adev-&gt;vmhub[i];<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; u32 tmp =3D gmc_v9_0_get_invalidate_req(vmid);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; u32 tmp =3D gmc_v9_0_get_invalidate_req(vmid, flush_type);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.kiq.ring.ready &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_sriov_runtime(adev) || =
!amdgpu_sriov_vf(adev)) &amp;&amp;<br>
&gt; @@ -429,7 &#43;430,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(st=
ruct amdgpu_ring *ring,<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ring-&gt;adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vmhub *hub =3D=
 &amp;adev-&gt;vmhub[ring-&gt;funcs-&gt;vmhub];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t req =3D gmc_v9_0_get_invalidate_req=
(vmid);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t req =3D gmc_v9_0_get_invalidate=
_req(vmid, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned eng =3D ring-&gt;vm=
_inv_eng;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_wreg(ring, =
hub-&gt;ctx0_ptb_addr_lo32 &#43; (2 * vmid),<br>
&gt; @@ -1122,7 &#43;1123,7 @@ static int gmc_v9_0_gart_enable(struct amdgp=
u_device *adev)<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v1_0_set_fault_enable=
_default(adev, value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v1_0_set_fault_enable_=
default(adev, value);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; gmc_v9_0_flush_gpu_tlb(adev, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v9_0_flush_gpu_tlb(adev, 0, 0);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;PCIE GART of =
%uM enabled (table at 0x%016llX).\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned)(adev-&gt;gmc.gart_size &gt;&gt; 20),<b=
r>
</div>
</span></font></div>
</body>
</html>

--_000_BL0PR12MB250058AE33487BB6D86DE290F0F50BL0PR12MB2500namp_--

--===============1919232818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1919232818==--
