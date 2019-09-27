From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: Export setup_vm_pt_regs() logic for
 gfxhub 2.0
Date: Fri, 27 Sep 2019 13:21:22 +0000
Message-ID: <BN6PR12MB18092F889AAB39833EA2210DF7810@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190925181527.17091-1-Yong.Zhao@amd.com>,
 <5d25ca56-6604-c7dc-a669-f0feabd5dc5f@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1460370766=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5d25ca56-6604-c7dc-a669-f0feabd5dc5f-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1460370766==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18092F889AAB39833EA2210DF7810BN6PR12MB1809namp_"

--_000_BN6PR12MB18092F889AAB39833EA2210DF7810BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Kuehling=
, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, September 26, 2019 6:26 PM
To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: Export setup_vm_pt_regs() logic for gf=
xhub 2.0

For GFXv9 you made an equivalent change for both GFXHub and MMHub
("drm/amdgpu: Expose *_setup_vm_pt_regs for kfd to use"). Your GFXv9
commit was also reviewed by Alex and Christian. You should get at least
one of them to Ack or Review this change.

For GFXv10 you're only changing the GFXHub. I suspect that's because KFD
doesn't care about MMHub on GFXv10. That's fine with me.

You can add
Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

Thanks,
   Felix

On 2019-09-25 2:15 p.m., Zhao, Yong wrote:
> The KFD code will call this function later.
>
> Change-Id: I88a53368cdee719b2c75393e5cdbd8290584548e
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 20 ++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h |  2 ++
>   2 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v2_0.c
> index a9238735d361..b601c6740ef5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -46,21 +46,25 @@ u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device=
 *adev)
>        return (u64)RREG32_SOC15(GC, 0, mmGCMC_VM_FB_OFFSET) << 24;
>   }
>
> -static void gfxhub_v2_0_init_gart_pt_regs(struct amdgpu_device *adev)
> +void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t v=
mid,
> +                             uint64_t page_table_base)
>   {
> -     uint64_t value =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> +     /* two registers distance between mmGCVM_CONTEXT0_* to mmGCVM_CONTE=
XT1_* */
> +     int offset =3D mmGCVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32
> +                     - mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
>
> +     WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO3=
2,
> +                             offset * vmid, lower_32_bits(page_table_bas=
e));
>
> -     WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
> -                  lower_32_bits(value));
> -
> -     WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
> -                  upper_32_bits(value));
> +     WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI3=
2,
> +                             offset * vmid, upper_32_bits(page_table_bas=
e));
>   }
>
>   static void gfxhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *a=
dev)
>   {
> -     gfxhub_v2_0_init_gart_pt_regs(adev);
> +     uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> +
> +     gfxhub_v2_0_setup_vm_pt_regs(adev, 0, pt_base);
>
>        WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
>                     (u32)(adev->gmc.gart_start >> 12));
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v2_0.h
> index 06807940748b..392b8cd94fc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h
> @@ -31,5 +31,7 @@ void gfxhub_v2_0_set_fault_enable_default(struct amdgpu=
_device *adev,
>                                          bool value);
>   void gfxhub_v2_0_init(struct amdgpu_device *adev);
>   u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *adev);
> +void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t v=
mid,
> +                             uint64_t page_table_base);
>
>   #endif
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18092F889AAB39833EA2210DF7810BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Kuehling, Felix &lt;Felix.Kue=
hling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, September 26, 2019 6:26 PM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amdgpu: Export setup_vm_pt_regs() logic=
 for gfxhub 2.0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For GFXv9 you made an equivalent change for both G=
FXHub and MMHub
<br>
(&quot;drm/amdgpu: Expose *_setup_vm_pt_regs for kfd to use&quot;). Your GF=
Xv9 <br>
commit was also reviewed by Alex and Christian. You should get at least <br=
>
one of them to Ack or Review this change.<br>
<br>
For GFXv10 you're only changing the GFXHub. I suspect that's because KFD <b=
r>
doesn't care about MMHub on GFXv10. That's fine with me.<br>
<br>
You can add<br>
Reviewed-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Thanks,<br>
&nbsp;&nbsp; Felix<br>
<br>
On 2019-09-25 2:15 p.m., Zhao, Yong wrote:<br>
&gt; The KFD code will call this function later.<br>
&gt;<br>
&gt; Change-Id: I88a53368cdee719b2c75393e5cdbd8290584548e<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 20 &#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h |&nbsp; 2 &#43;&#=
43;<br>
&gt;&nbsp;&nbsp; 2 files changed, 14 insertions(&#43;), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/dr=
m/amd/amdgpu/gfxhub_v2_0.c<br>
&gt; index a9238735d361..b601c6740ef5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c<br>
&gt; @@ -46,21 &#43;46,25 @@ u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu=
_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (u64)RREG32_SOC15(GC,=
 0, mmGCMC_VM_FB_OFFSET) &lt;&lt; 24;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static void gfxhub_v2_0_init_gart_pt_regs(struct amdgpu_device *adev)=
<br>
&gt; &#43;void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uin=
t32_t vmid,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_table_base)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value =3D amdgpu_gmc_pd_addr(adev-&=
gt;gart.bo);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* two registers distance between mmGCVM=
_CONTEXT0_* to mmGCVM_CONTEXT1_* */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int offset =3D mmGCVM_CONTEXT1_PAGE_TABL=
E_BASE_ADDR_LO32<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - mmGCVM_CONTEXT0_P=
AGE_TABLE_BASE_ADDR_LO32;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEX=
T0_PAGE_TABLE_BASE_ADDR_LO32,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; offset * vmid, lower_32_bits(page_table_base))=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TAB=
LE_BASE_ADDR_LO32,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(value));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCVM_CONTEXT0_PAGE_TAB=
LE_BASE_ADDR_HI32,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(value));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEX=
T0_PAGE_TABLE_BASE_ADDR_HI32,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; offset * vmid, upper_32_bits(page_table_base))=
;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfxhub_v2_0_init_gart_aperture_regs(struct amd=
gpu_device *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v2_0_init_gart_pt_regs(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgpu_gmc_pd_addr(=
adev-&gt;gart.bo);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v2_0_setup_vm_pt_regs(adev, 0, pt=
_base);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCVM_C=
ONTEXT0_PAGE_TABLE_START_ADDR_LO32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_s=
tart &gt;&gt; 12));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h b/drivers/gpu/dr=
m/amd/amdgpu/gfxhub_v2_0.h<br>
&gt; index 06807940748b..392b8cd94fc0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h<br>
&gt; @@ -31,5 &#43;31,7 @@ void gfxhub_v2_0_set_fault_enable_default(struct=
 amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; bool value);<br>
&gt;&nbsp;&nbsp; void gfxhub_v2_0_init(struct amdgpu_device *adev);<br>
&gt;&nbsp;&nbsp; u64 gfxhub_v2_0_get_mc_fb_offset(struct amdgpu_device *ade=
v);<br>
&gt; &#43;void gfxhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uin=
t32_t vmid,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_table_base);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #endif<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18092F889AAB39833EA2210DF7810BN6PR12MB1809namp_--

--===============1460370766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1460370766==--
