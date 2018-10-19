From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: Expose *_setup_vm_pt_regs for kfd to use
Date: Fri, 19 Oct 2018 15:50:31 +0000
Message-ID: <BL0PR12MB2500351B2791A94A561FD563F0F90@BL0PR12MB2500.namprd12.prod.outlook.com>
References: <1539897169-23047-1-git-send-email-Yong.Zhao@amd.com>
 <1539897169-23047-2-git-send-email-Yong.Zhao@amd.com>,
 <46157ae3-b195-6d42-b3d1-4d685d3ec9db@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0901218768=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <46157ae3-b195-6d42-b3d1-4d685d3ec9db-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, brahma_sw_dev <brahma_sw_dev-5C7GfCeVMHo@public.gmane.org>

--===============0901218768==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR12MB2500351B2791A94A561FD563F0F90BL0PR12MB2500namp_"

--_000_BL0PR12MB2500351B2791A94A561FD563F0F90BL0PR12MB2500namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Fixed as suggested, added the descriptions, and pushed them. Thanks.

Yong
________________________________
From: Koenig, Christian
Sent: Friday, October 19, 2018 3:14:14 AM
To: Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; brahma_sw_dev
Subject: Re: [PATCH 2/3] drm/amdgpu: Expose *_setup_vm_pt_regs for kfd to u=
se

Am 18.10.18 um 23:13 schrieb Zhao, Yong:
> Change-Id: I2ea27c4749a454506fecf75bb5b78b09bde9cb28
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 20 +++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h    |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 20 +++++++++++++++-----
>   3 files changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v1_0.c
> index ceb7847..34145a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -35,15 +35,25 @@ u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device=
 *adev)
>        return (u64)RREG32_SOC15(GC, 0, mmMC_VM_FB_OFFSET) << 24;
>   }
>
> +void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t v=
mid,
> +                             uint64_t value)

I would rather give the parameter some meaningful name, e.g.
page_table_base or similar.

> +{
> +     /* two registers distance between mmVM_CONTEXT0_* to mmVM_CONTEXT1_=
* */
> +     int offset =3D mmVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32
> +                     - mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
> +
> +     WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
> +                             offset * vmid, lower_32_bits(value));
> +
> +     WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
> +                             offset * vmid, upper_32_bits(value));
> +}
> +
>   static void gfxhub_v1_0_init_gart_pt_regs(struct amdgpu_device *adev)
>   {
>        uint64_t value =3D amdgpu_gmc_pd_addr(adev->gart.bo);
>
> -     WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
> -                  lower_32_bits(value));
> -
> -     WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
> -                  upper_32_bits(value));
> +     gfxhub_v1_0_setup_vm_pt_regs(adev, 0, value);

Since that function is now a mostly meaningless wrapper I would just go
ahead and call gfxhub_v1_0_setup_vm_pt_regs directly as long as it
doesn't duplicates the code to much.

Same applies of course to the mmhub variant.

Apart from that looks good to me,
Christian.

>   }
>
>   static void gfxhub_v1_0_init_gart_aperture_regs(struct amdgpu_device *a=
dev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.h
> index b030ca5..008ab08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
> @@ -27,4 +27,10 @@
>   extern const struct amd_ip_funcs gmc_v9_0_ip_funcs;
>   extern const struct amdgpu_ip_block_version gmc_v9_0_ip_block;
>
> +/* amdgpu_amdkfd*.c */
> +void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t v=
mid,
> +                             uint64_t value);
> +void mmhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vm=
id,
> +                             uint64_t value);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v1_0.c
> index 14649f8..8e18be0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -52,15 +52,25 @@ u64 mmhub_v1_0_get_fb_location(struct amdgpu_device *=
adev)
>        return base;
>   }
>
> +void mmhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vm=
id,
> +                             uint64_t value)
> +{
> +     /* two registers distance between mmVM_CONTEXT0_* to mmVM_CONTEXT1_=
* */
> +     int offset =3D mmVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32
> +                     - mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
> +
> +     WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO=
32,
> +                     offset * vmid, lower_32_bits(value));
> +
> +     WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI=
32,
> +                     offset * vmid, upper_32_bits(value));
> +}
> +
>   static void mmhub_v1_0_init_gart_pt_regs(struct amdgpu_device *adev)
>   {
>        uint64_t value =3D amdgpu_gmc_pd_addr(adev->gart.bo);
>
> -     WREG32_SOC15(MMHUB, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
> -                  lower_32_bits(value));
> -
> -     WREG32_SOC15(MMHUB, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
> -                  upper_32_bits(value));
> +     mmhub_v1_0_setup_vm_pt_regs(adev, 0, value);
>   }
>
>   static void mmhub_v1_0_init_gart_aperture_regs(struct amdgpu_device *ad=
ev)


--_000_BL0PR12MB2500351B2791A94A561FD563F0F90BL0PR12MB2500namp_
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
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;">
Fixed as suggested, added the descriptions, and pushed them. Thanks.</div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;">
<br>
</div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;">
Yong</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian<br>
<b>Sent:</b> Friday, October 19, 2018 3:14:14 AM<br>
<b>To:</b> Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; brahma_sw_dev<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdgpu: Expose *_setup_vm_pt_regs for k=
fd to use</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 18.10.18 um 23:13 schrieb Zhao, Yong:<br>
&gt; Change-Id: I2ea27c4749a454506fecf75bb5b78b09bde9cb28<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 20 &#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h&nbsp;&nbsp;&nbsp; |&=
nbsp; 6 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c&nbsp; | 20 &#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----<b=
r>
&gt;&nbsp;&nbsp; 3 files changed, 36 insertions(&#43;), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/dr=
m/amd/amdgpu/gfxhub_v1_0.c<br>
&gt; index ceb7847..34145a6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c<br>
&gt; @@ -35,15 &#43;35,25 @@ u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu=
_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (u64)RREG32_SOC15(GC,=
 0, mmMC_VM_FB_OFFSET) &lt;&lt; 24;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uin=
t32_t vmid,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value)<br>
<br>
I would rather give the parameter some meaningful name, e.g. <br>
page_table_base or similar.<br>
<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* two registers distance between mmVM_C=
ONTEXT0_* to mmVM_CONTEXT1_* */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int offset =3D mmVM_CONTEXT1_PAGE_TABLE_=
BASE_ADDR_LO32<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - mmVM_CONTEXT0_PAG=
E_TABLE_BASE_ADDR_LO32;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0=
_PAGE_TABLE_BASE_ADDR_LO32,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; offset * vmid, lower_32_bits(value));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0=
_PAGE_TABLE_BASE_ADDR_HI32,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; offset * vmid, upper_32_bits(value));<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static void gfxhub_v1_0_init_gart_pt_regs(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value =3D amdgpu_gm=
c_pd_addr(adev-&gt;gart.bo);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE=
_BASE_ADDR_LO32,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(value));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE=
_BASE_ADDR_HI32,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(value));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v1_0_setup_vm_pt_regs(adev, 0, va=
lue);<br>
<br>
Since that function is now a mostly meaningless wrapper I would just go <br=
>
ahead and call gfxhub_v1_0_setup_vm_pt_regs directly as long as it <br>
doesn't duplicates the code to much.<br>
<br>
Same applies of course to the mmhub variant.<br>
<br>
Apart from that looks good to me,<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfxhub_v1_0_init_gart_aperture_regs(struct amd=
gpu_device *adev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.h<br>
&gt; index b030ca5..008ab08 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h<br>
&gt; @@ -27,4 &#43;27,10 @@<br>
&gt;&nbsp;&nbsp; extern const struct amd_ip_funcs gmc_v9_0_ip_funcs;<br>
&gt;&nbsp;&nbsp; extern const struct amdgpu_ip_block_version gmc_v9_0_ip_bl=
ock;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;/* amdgpu_amdkfd*.c */<br>
&gt; &#43;void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uin=
t32_t vmid,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value);<br>
&gt; &#43;void mmhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint=
32_t vmid,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm=
/amd/amdgpu/mmhub_v1_0.c<br>
&gt; index 14649f8..8e18be0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
&gt; @@ -52,15 &#43;52,25 @@ u64 mmhub_v1_0_get_fb_location(struct amdgpu_d=
evice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return base;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;void mmhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint=
32_t vmid,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* two registers distance between mmVM_C=
ONTEXT0_* to mmVM_CONTEXT1_* */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int offset =3D mmVM_CONTEXT1_PAGE_TABLE_=
BASE_ADDR_LO32<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - mmVM_CONTEXT0_PAG=
E_TABLE_BASE_ADDR_LO32;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTE=
XT0_PAGE_TABLE_BASE_ADDR_LO32,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset * vmid, lowe=
r_32_bits(value));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTE=
XT0_PAGE_TABLE_BASE_ADDR_HI32,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset * vmid, uppe=
r_32_bits(value));<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static void mmhub_v1_0_init_gart_pt_regs(struct amdgpu_dev=
ice *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value =3D amdgpu_gm=
c_pd_addr(adev-&gt;gart.bo);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmVM_CONTEXT0_PAGE_TA=
BLE_BASE_ADDR_LO32,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(value));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmVM_CONTEXT0_PAGE_TA=
BLE_BASE_ADDR_HI32,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(value));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v1_0_setup_vm_pt_regs(adev, 0, val=
ue);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void mmhub_v1_0_init_gart_aperture_regs(struct amdg=
pu_device *adev)<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL0PR12MB2500351B2791A94A561FD563F0F90BL0PR12MB2500namp_--

--===============0901218768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0901218768==--
