From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: page_table_base already have the flags
 needed
Date: Tue, 23 Oct 2018 21:15:41 +0000
Message-ID: <BL0PR12MB25006DC56817C2B7F00F093BF0F50@BL0PR12MB2500.namprd12.prod.outlook.com>
References: <1540233186-3456-1-git-send-email-Yong.Zhao@amd.com>
 <1540233186-3456-2-git-send-email-Yong.Zhao@amd.com>
 <BL0PR12MB2500DD8AAC17A29418807EC2F0F50@BL0PR12MB2500.namprd12.prod.outlook.com>,
 <f2a19dc1-db2f-1c85-b940-d024fea31792@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1910448889=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f2a19dc1-db2f-1c85-b940-d024fea31792-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, brahma_sw_dev <brahma_sw_dev-5C7GfCeVMHo@public.gmane.org>

--===============1910448889==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR12MB25006DC56817C2B7F00F093BF0F50BL0PR12MB2500namp_"

--_000_BL0PR12MB25006DC56817C2B7F00F093BF0F50BL0PR12MB2500namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Pushed. Thanks!


Yong

________________________________
From: Kuehling, Felix
Sent: Tuesday, October 23, 2018 4:43:05 PM
To: Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; brahma_sw_dev
Subject: Re: [PATCH 2/2] drm/amdkfd: page_table_base already have the flags=
 needed

The series is Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>


On 2018-10-23 1:00 p.m., Zhao, Yong wrote:
>
> How about those two patches?
>
>
> Yong
>
> ------------------------------------------------------------------------
> *From:* Zhao, Yong
> *Sent:* Monday, October 22, 2018 2:33:26 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; brahma_sw_dev
> *Cc:* Zhao, Yong
> *Subject:* [PATCH 2/2] drm/amdkfd: page_table_base already have the
> flags needed
>
> The flags are added when calling amdgpu_gmc_pd_addr().
>
> Change-Id: Idd85b1ac35d3d100154df8229ea20721d9a7045c
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 5 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h             | 1 +
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 54c3690..60b5f56c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -978,7 +978,6 @@ static void set_vm_context_page_table_base(struct
> kgd_dev *kgd, uint32_t vmid,
>                  uint64_t page_table_base)
>  {
>          struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> -       uint64_t base =3D page_table_base | AMDGPU_PTE_VALID;
>
>          if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
>                  pr_err("trying to set page table base for wrong VMID
> %u\n",
> @@ -990,7 +989,7 @@ static void set_vm_context_page_table_base(struct
> kgd_dev *kgd, uint32_t vmid,
>           * now, all processes share the same address space size, like
>           * on GFX8 and older.
>           */
> -       mmhub_v1_0_setup_vm_pt_regs(adev, vmid, base);
> +       mmhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);
>
> -       gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, base);
> +       gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 53ff86d..dec8e64 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -507,6 +507,7 @@ struct qcm_process_device {
>           * All the memory management data should be here too
>           */
>          uint64_t gds_context_area;
> +       /* Contains page table flags such as AMDGPU_PTE_VALID since
> gfx9 */
>          uint64_t page_table_base;
>          uint32_t sh_mem_config;
>          uint32_t sh_mem_bases;
> --
> 2.7.4
>

--_000_BL0PR12MB25006DC56817C2B7F00F093BF0F50BL0PR12MB2500namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Pushed. Thanks!</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Yong</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Tuesday, October 23, 2018 4:43:05 PM<br>
<b>To:</b> Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; brahma_sw_dev<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdkfd: page_table_base already have th=
e flags needed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The series is Reviewed-by: Felix Kuehling &lt;Feli=
x.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
<br>
On 2018-10-23 1:00 p.m., Zhao, Yong wrote:<br>
&gt;<br>
&gt; How about those two patches?<br>
&gt;<br>
&gt;<br>
&gt; Yong<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Zhao, Yong<br>
&gt; *Sent:* Monday, October 22, 2018 2:33:26 PM<br>
&gt; *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; brahma_sw_dev<br>
&gt; *Cc:* Zhao, Yong<br>
&gt; *Subject:* [PATCH 2/2] drm/amdkfd: page_table_base already have the<br=
>
&gt; flags needed<br>
&gt; &nbsp;<br>
&gt; The flags are added when calling amdgpu_gmc_pd_addr().<br>
&gt;<br>
&gt; Change-Id: Idd85b1ac35d3d100154df8229ea20721d9a7045c<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 5 &#43;&#43;=
---<br>
&gt; &nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 &#43;<br>
&gt; &nbsp;2 files changed, 3 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; index 54c3690..60b5f56c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br=
>
&gt; @@ -978,7 &#43;978,6 @@ static void set_vm_context_page_table_base(str=
uct<br>
&gt; kgd_dev *kgd, uint32_t vmid,<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_table_base)<br>
&gt; &nbsp;{<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device =
*adev =3D get_amdgpu_device(kgd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t base =3D page_table_bas=
e | AMDGPU_PTE_VALID;<br>
&gt; &nbsp;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_amdkfd_is=
_kfd_vmid(adev, vmid)) {<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;trying to set page table base for w=
rong VMID<br>
&gt; %u\n&quot;,<br>
&gt; @@ -990,7 &#43;989,7 @@ static void set_vm_context_page_table_base(str=
uct<br>
&gt; kgd_dev *kgd, uint32_t vmid,<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * now, all proc=
esses share the same address space size, like<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on GFX8 and o=
lder.<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v1_0_setup_vm_pt_regs(adev=
, vmid, base);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v1_0_setup_vm_pt_regs(=
adev, vmid, page_table_base);<br>
&gt; &nbsp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v1_0_setup_vm_pt_regs(ade=
v, vmid, base);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v1_0_setup_vm_pt_regs=
(adev, vmid, page_table_base);<br>
&gt; &nbsp;}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; index 53ff86d..dec8e64 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -507,6 &#43;507,7 @@ struct qcm_process_device {<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * All the memor=
y management data should be here too<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gds_context_=
area;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Contains page table flags=
 such as AMDGPU_PTE_VALID since<br>
&gt; gfx9 */<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_table_b=
ase;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sh_mem_confi=
g;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sh_mem_bases=
;<br>
&gt; -- <br>
&gt; 2.7.4<br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL0PR12MB25006DC56817C2B7F00F093BF0F50BL0PR12MB2500namp_--

--===============1910448889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1910448889==--
