From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: page_table_base already have the flags
 needed
Date: Tue, 23 Oct 2018 17:00:49 +0000
Message-ID: <BL0PR12MB2500DD8AAC17A29418807EC2F0F50@BL0PR12MB2500.namprd12.prod.outlook.com>
References: <1540233186-3456-1-git-send-email-Yong.Zhao@amd.com>,
 <1540233186-3456-2-git-send-email-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1130044011=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540233186-3456-2-git-send-email-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, brahma_sw_dev <brahma_sw_dev-5C7GfCeVMHo@public.gmane.org>

--===============1130044011==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR12MB2500DD8AAC17A29418807EC2F0F50BL0PR12MB2500namp_"

--_000_BL0PR12MB2500DD8AAC17A29418807EC2F0F50BL0PR12MB2500namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

How about those two patches?


Yong

________________________________
From: Zhao, Yong
Sent: Monday, October 22, 2018 2:33:26 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; brahma_sw_dev
Cc: Zhao, Yong
Subject: [PATCH 2/2] drm/amdkfd: page_table_base already have the flags nee=
ded

The flags are added when calling amdgpu_gmc_pd_addr().

Change-Id: Idd85b1ac35d3d100154df8229ea20721d9a7045c
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 5 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h             | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 54c3690..60b5f56c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -978,7 +978,6 @@ static void set_vm_context_page_table_base(struct kgd_d=
ev *kgd, uint32_t vmid,
                 uint64_t page_table_base)
 {
         struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
-       uint64_t base =3D page_table_base | AMDGPU_PTE_VALID;

         if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
                 pr_err("trying to set page table base for wrong VMID %u\n"=
,
@@ -990,7 +989,7 @@ static void set_vm_context_page_table_base(struct kgd_d=
ev *kgd, uint32_t vmid,
          * now, all processes share the same address space size, like
          * on GFX8 and older.
          */
-       mmhub_v1_0_setup_vm_pt_regs(adev, vmid, base);
+       mmhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);

-       gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, base);
+       gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 53ff86d..dec8e64 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -507,6 +507,7 @@ struct qcm_process_device {
          * All the memory management data should be here too
          */
         uint64_t gds_context_area;
+       /* Contains page table flags such as AMDGPU_PTE_VALID since gfx9 */
         uint64_t page_table_base;
         uint32_t sh_mem_config;
         uint32_t sh_mem_bases;
--
2.7.4


--_000_BL0PR12MB2500DD8AAC17A29418807EC2F0F50BL0PR12MB2500namp_
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
<p style=3D"margin-top:0;margin-bottom:0">How about those two patches?</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Yong</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhao, Yong<br>
<b>Sent:</b> Monday, October 22, 2018 2:33:26 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; brahma_sw_dev<br>
<b>Cc:</b> Zhao, Yong<br>
<b>Subject:</b> [PATCH 2/2] drm/amdkfd: page_table_base already have the fl=
ags needed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The flags are added when calling amdgpu_gmc_pd_add=
r().<br>
<br>
Change-Id: Idd85b1ac35d3d100154df8229ea20721d9a7045c<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 5 &#43;&#43;---<b=
r>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 &#43;<br>
&nbsp;2 files changed, 3 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index 54c3690..60b5f56c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -978,7 &#43;978,6 @@ static void set_vm_context_page_table_base(struct k=
gd_dev *kgd, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint64_t page_table_base)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D get_amdgpu_device(kgd);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t base =3D page_table_base | A=
MDGPU_PTE_VALID;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_amdkfd_is_kfd_=
vmid(adev, vmid)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_err(&quot;trying to set page table base for wrong =
VMID %u\n&quot;,<br>
@@ -990,7 &#43;989,7 @@ static void set_vm_context_page_table_base(struct k=
gd_dev *kgd, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * now, all processes=
 share the same address space size, like<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on GFX8 and older.=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v1_0_setup_vm_pt_regs(adev, vmi=
d, base);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v1_0_setup_vm_pt_regs(adev,=
 vmid, page_table_base);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v1_0_setup_vm_pt_regs(adev, vm=
id, base);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v1_0_setup_vm_pt_regs(adev=
, vmid, page_table_base);<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index 53ff86d..dec8e64 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -507,6 &#43;507,7 @@ struct qcm_process_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * All the memory man=
agement data should be here too<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gds_context_area;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Contains page table flags such=
 as AMDGPU_PTE_VALID since gfx9 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_table_base;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sh_mem_config;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sh_mem_bases;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL0PR12MB2500DD8AAC17A29418807EC2F0F50BL0PR12MB2500namp_--

--===============1130044011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1130044011==--
