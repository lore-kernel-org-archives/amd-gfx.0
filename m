From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: move static CSA address to top of address
 space
Date: Tue, 23 Jan 2018 13:44:59 +0000
Message-ID: <BLUPR12MB044994791174D013A88B302284E30@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <20180122104404.1239-1-christian.koenig@amd.com>
 <20180122104404.1239-3-christian.koenig@amd.com>
 <MWHPR1201MB0127D1F3C71A0C2D99A64603FDE30@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <BLUPR12MB04494E357187195CC3C90B0584E30@BLUPR12MB0449.namprd12.prod.outlook.com>
 <BLUPR12MB0449A76D5FB31F4C46AD8BB384E30@BLUPR12MB0449.namprd12.prod.outlook.com>
 <99bd1b34-e10e-800d-fd35-8166a452fd3e@gmail.com>
 <BLUPR12MB044956D60F5A8551D1CE427784E30@BLUPR12MB0449.namprd12.prod.outlook.com>,
 <5b3ef38e-eb44-75a8-3300-4e892de11dab@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0765743553=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5b3ef38e-eb44-75a8-3300-4e892de11dab-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "He, Roger" <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0765743553==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB044994791174D013A88B302284E30BLUPR12MB0449namp_"

--_000_BLUPR12MB044994791174D013A88B302284E30BLUPR12MB0449namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

looks this is HSA feature to me that CPU and GPU share the same virtual add=
ress ....


Ack-by: Monk Liu <monk.liu-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Koenig, Christian
Sent: Tuesday, January 23, 2018 8:51:21 PM
To: Liu, Monk; He, Roger; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 3/3] drm/amdgpu: move static CSA address to top of addr=
ess space

The ATC (or alternatively HMM) maps the CPU addresses into the GPU address =
space.

Now on Linux the lower range (0x0-0x7fffffffffff) is used for the userspace=
 address space on the CPU, so when we want to use that on the GPU it must b=
e free of other mappings.

GFX8 and GFX7 hardware had a separate flag which address space to use in th=
e memory instructions, but on GFX9 it's all one big shared address space an=
d we need to make sure that we don't kick each others feet.

Had to move the addresses Mesa use as well because of this and older VCE fi=
rmware unfortunately was buggy regarding this as well.

Regards,
Christian.

Am 23.01.2018 um 13:43 schrieb Liu, Monk:

OK I see, but why HMM/ATC/SVN want  low 8MB range ? why they cannot use hig=
h range address ?


________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org><mailto:ckoenig.l=
eichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, January 23, 2018 4:26:21 PM
To: Liu, Monk; He, Roger; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx@list=
s.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: move static CSA address to top of addr=
ess space

Any bug introduced by original design ? I don't see why 8MB- 8KB as the sta=
rt vm address of CSA has any trouble compared with top range ?
On gfx9 we need the lower address range (0x0-0x7fffffffffff) for HMM/ATC/SV=
M. If we map the 8k CSA in there and hit it by accident then the GPU will n=
ot do what it is supposed to do :)

I could limit the change to only gfx9, but I think the code will be simpler=
 if we change both gfx8 and gfx9.

Besides, please note that you also need modify gfx8/9 source to align emit_=
cs/de_meta with your change
That was the design flaw I was talking about. In other words I couldn't fin=
d the code where that address was actually used.

We should use the macro define in those functions as well. Going to send fi=
xed for this in a minute.

Thanks,
Christian.

Am 23.01.2018 um 04:23 schrieb Liu, Monk:

anyway I prefer no change on that part unless there issues or bug need to f=
ix by the change.

the CSA address is for use by CPG h/w not s/w, and since 8MB is a reserved =
range for each VM I don't see

it's a design flaw with it

________________________________
From: Liu, Monk
Sent: Tuesday, January 23, 2018 11:20:35 AM
To: He, Roger; Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-=
gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: move static CSA address to top of addr=
ess space


Any bug introduced by original design ? I don't see why 8MB- 8KB as the sta=
rt vm address of CSA has any trouble compared with top range ? Besides, ple=
ase note that you also need modify gfx8/9 source to align emit_cs/de_meta w=
ith your change



________________________________
From: He, Roger
Sent: Tuesday, January 23, 2018 10:36:31 AM
To: Christian K=F6nig; Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-=
gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: move static CSA address to top of addr=
ess space



-----Original Message-----
From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of C=
hristian K?nig
Sent: Monday, January 22, 2018 6:44 PM
To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org><mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32k@public.gmane.org=
eedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: [PATCH 3/3] drm/amdgpu: move static CSA address to top of address =
space

There seems to be a design flaw with this since the address of the static C=
SA is never exported anywhere.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christia=
n.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 15 +++++++--------  drivers/gpu=
/drm/amd/amdgpu/amdgpu_virt.h |  6 ++++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e7dfb7b44b4b..c7d24af03e3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -55,11 +55,10 @@ void amdgpu_free_static_csa(struct amdgpu_device *adev)=
 {

 /*
  * amdgpu_map_static_csa should be called during amdgpu_vm_init
- * it maps virtual address "AMDGPU_VA_RESERVED_SIZE - AMDGPU_CSA_SIZE"
- * to this VM, and each command submission of GFX should use this virtual
- * address within META_DATA init package to support SRIOV gfx preemption.
+ * it maps virtual address "AMDGPU_CSA_VADDR" to this VM, and each
+ command
+ * submission of GFX should use this virtual address within META_DATA
+ init
+ * package to support SRIOV gfx preemption.
  */
-
 int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm=
,
                           struct amdgpu_bo_va **bo_va)
 {
@@ -90,7 +89,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
                 return -ENOMEM;
         }

-       r =3D amdgpu_vm_alloc_pts(adev, (*bo_va)->base.vm, AMDGPU_CSA_VADDR=
,
+       r =3D amdgpu_vm_alloc_pts(adev, (*bo_va)->base.vm,
+AMDGPU_CSA_VADDR(adev),
                                 AMDGPU_CSA_SIZE);
         if (r) {
                 DRM_ERROR("failed to allocate pts for static CSA, err=3D%d=
\n", r); @@ -99,9 +98,9 @@ int amdgpu_map_static_csa(struct amdgpu_device *=
adev, struct amdgpu_vm *vm,
                 return r;
         }

-       r =3D amdgpu_vm_bo_map(adev, *bo_va, AMDGPU_CSA_VADDR, 0, AMDGPU_CS=
A_SIZE,
-                            AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
-                            AMDGPU_PTE_EXECUTABLE);
+       r =3D amdgpu_vm_bo_map(adev, *bo_va, AMDGPU_CSA_VADDR(adev), 0,
+                            AMDGPU_CSA_SIZE, AMDGPU_PTE_READABLE |
+                            AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_EXECUTABLE);

         if (r) {
                 DRM_ERROR("failed to do bo_map on static CSA, err=3D%d\n",=
 r); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_virt.h
index 6a83425aa9ed..499362b55e45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -251,8 +251,10 @@ struct amdgpu_virt {
         uint32_t gim_feature;
 };

-#define AMDGPU_CSA_SIZE    (8 * 1024)
-#define AMDGPU_CSA_VADDR   (AMDGPU_VA_RESERVED_SIZE - AMDGPU_CSA_SIZE)
+#define AMDGPU_CSA_SIZE                (8 * 1024)
+#define AMDGPU_CSA_VADDR(adev) \
        +       (((adev)->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT) + \
        +        AMDGPU_VA_RESERVED_SIZE)

If I  understand your intention correctly, it should be that:
+       (((adev)->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT)  - \
+        AMDGPU_VA_RESERVED_SIZE)

Thanks
Roger(Hongbo.He)

 #define amdgpu_sriov_enabled(adev) \
 ((adev)->virt.caps & AMDGPU_SRIOV_CAPS_ENABLE_IOV)
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_BLUPR12MB044994791174D013A88B302284E30BLUPR12MB0449namp_
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
<p style=3D"margin-top:0;margin-bottom:0">looks this is HSA feature to me t=
hat CPU and GPU share the same virtual address ....</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Ack-by: Monk Liu &lt;monk.liu@amd=
.com&gt;</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian<br>
<b>Sent:</b> Tuesday, January 23, 2018 8:51:21 PM<br>
<b>To:</b> Liu, Monk; He, Roger; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amdgpu: move static CSA address to top =
of address space</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">The ATC (or alternatively HMM) maps the CP=
U addresses into the GPU address space.<br>
<br>
Now on Linux the lower range (0x0-0x7fffffffffff) is used for the userspace=
 address space on the CPU, so when we want to use that on the GPU it must b=
e free of other mappings.<br>
<br>
GFX8 and GFX7 hardware had a separate flag which address space to use in th=
e memory instructions, but on GFX9 it's all one big shared address space an=
d we need to make sure that we don't kick each others feet.<br>
<br>
Had to move the addresses Mesa use as well because of this and older VCE fi=
rmware unfortunately was buggy regarding this as well.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 23.01.2018 um 13:43 schrieb Liu, Monk:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">OK I see, but why HMM/ATC/SVN wa=
nt&nbsp; low 8MB range ? why they cannot use high range address ?</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:ckoenig.leichtzumerken@=
gmail.com">
&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
<b>Sent:</b> Tuesday, January 23, 2018 4:26:21 PM<br>
<b>To:</b> Liu, Monk; He, Roger; <a class=3D"x_moz-txt-link-abbreviated" hr=
ef=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amdgpu: move static CSA address to top =
of address space</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_x_moz-cite-prefix">
<blockquote type=3D"cite">Any bug introduced by original design ? I don't s=
ee why 8MB- 8KB as the start vm address of CSA has any trouble compared wit=
h top range ?</blockquote>
On gfx9 we need the lower address range (0x0-0x7fffffffffff) for HMM/ATC/SV=
M. If we map the 8k CSA in there and hit it by accident then the GPU will n=
ot do what it is supposed to do :)<br>
<br>
I could limit the change to only gfx9, but I think the code will be simpler=
 if we change both gfx8 and gfx9.<br>
<br>
<blockquote type=3D"cite">Besides, please note that you also need modify gf=
x8/9 source to align emit_cs/de_meta with your change</blockquote>
That was the design flaw I was talking about. In other words I couldn't fin=
d the code where that address was actually used.<br>
<br>
We should use the macro define in those functions as well. Going to send fi=
xed for this in a minute.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 23.01.2018 um 04:23 schrieb Liu, Monk:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div id=3D"x_x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; c=
olor:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">anyway I prefer no change on tha=
t part unless there issues or bug need to fix by the change.</p>
<p style=3D"margin-top:0; margin-bottom:0">the CSA address is for use by CP=
G h/w not s/w, and since 8MB is a reserved range for each VM I don't see</p=
>
<p style=3D"margin-top:0; margin-bottom:0">it's a design flaw with it<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Liu, Monk<br>
<b>Sent:</b> Tuesday, January 23, 2018 11:20:35 AM<br>
<b>To:</b> He, Roger; Christian K=F6nig; <a class=3D"x_x_moz-txt-link-abbre=
viated" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amdgpu: move static CSA address to top =
of address space</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_x_x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt;=
 color:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">Any bug introduced by original d=
esign ? I don't see why 8MB- 8KB as the start vm address of CSA has any tro=
uble compared with top range ? Besides, please note that you also need modi=
fy gfx8/9 source to align emit_cs/de_meta
 with your change</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-ser=
if" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> He, Roger<br>
<b>Sent:</b> Tuesday, January 23, 2018 10:36:31 AM<br>
<b>To:</b> Christian K=F6nig; Liu, Monk; <a class=3D"x_x_moz-txt-link-abbre=
viated" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> RE: [PATCH 3/3] drm/amdgpu: move static CSA address to top =
of address space</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size=
:11pt">
<div class=3D"x_x_x_PlainText"><br>
<br>
-----Original Message-----<br>
From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mai=
lto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf Of Christian K?nig=
<br>
Sent: Monday, January 22, 2018 6:44 PM<br>
To: Liu, Monk <a class=3D"x_x_moz-txt-link-rfc2396E" href=3D"mailto:Monk.Li=
u@amd.com">
&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>; <a class=3D"x_x_moz-txt-link-abbreviated" hre=
f=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
Subject: [PATCH 3/3] drm/amdgpu: move static CSA address to top of address =
space<br>
<br>
There seems to be a design flaw with this since the address of the static C=
SA is never exported anywhere.<br>
<br>
Signed-off-by: Christian K=F6nig <a class=3D"x_x_moz-txt-link-rfc2396E" hre=
f=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 15 &#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;--------&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |&nbsp;=
 6 &#43;&#43;&#43;&#43;--<br>
&nbsp;2 files changed, 11 insertions(&#43;), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index e7dfb7b44b4b..c7d24af03e3e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -55,11 &#43;55,10 @@ void amdgpu_free_static_csa(struct amdgpu_device *a=
dev) {<br>
&nbsp;<br>
&nbsp;/*<br>
&nbsp; * amdgpu_map_static_csa should be called during amdgpu_vm_init<br>
- * it maps virtual address &quot;AMDGPU_VA_RESERVED_SIZE - AMDGPU_CSA_SIZE=
&quot;<br>
- * to this VM, and each command submission of GFX should use this virtual<=
br>
- * address within META_DATA init package to support SRIOV gfx preemption.<=
br>
&#43; * it maps virtual address &quot;AMDGPU_CSA_VADDR&quot; to this VM, an=
d each <br>
&#43; command<br>
&#43; * submission of GFX should use this virtual address within META_DATA =
<br>
&#43; init<br>
&#43; * package to support SRIOV gfx preemption.<br>
&nbsp; */<br>
-<br>
&nbsp;int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_v=
m *vm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct amdgpu_bo_va **bo_va)<br>
&nbsp;{<br>
@@ -90,7 &#43;89,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_alloc_pts(adev, (*bo_=
va)-&gt;base.vm, AMDGPU_CSA_VADDR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_alloc_pts(adev, (=
*bo_va)-&gt;base.vm, <br>
&#43;AMDGPU_CSA_VADDR(adev),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_CSA_SIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to allocate pts for static CSA=
, err=3D%d\n&quot;, r); @@ -99,9 &#43;98,9 @@ int amdgpu_map_static_csa(str=
uct amdgpu_device *adev, struct amdgpu_vm *vm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_bo_map(adev, *bo_va, =
AMDGPU_CSA_VADDR, 0, AMDGPU_CSA_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; AMDGPU_PTE_EXECUTABLE);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_bo_map(adev, *bo_=
va, AMDGPU_CSA_VADDR(adev), 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; AMDGPU_CSA_SIZE, AMDGPU_PTE_READABLE |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_EXECUTABLE);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to do bo_map on static CSA, er=
r=3D%d\n&quot;, r); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b=
/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
index 6a83425aa9ed..499362b55e45 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
@@ -251,8 &#43;251,10 @@ struct amdgpu_virt {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gim_feature;<br>
&nbsp;};<br>
&nbsp;<br>
-#define AMDGPU_CSA_SIZE&nbsp;&nbsp;&nbsp; (8 * 1024)<br>
-#define AMDGPU_CSA_VADDR&nbsp;&nbsp; (AMDGPU_VA_RESERVED_SIZE - AMDGPU_CSA=
_SIZE)<br>
&#43;#define AMDGPU_CSA_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (8 * 1024)<br>
&#43;#define AMDGPU_CSA_VADDR(adev) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (((adev)-&gt;vm_manager.max_pfn &lt;&lt; AMDGPU_GPU_PAGE_SHIFT) &=
#43; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; AMDGPU_VA_RESERVED_SIZE)<br>
&nbsp;<br>
If I&nbsp; understand your intention correctly, it should be that: <br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((adev)-&gt;vm_manager.max_pfn &=
lt;&lt; AMDGPU_GPU_PAGE_SHIFT)&nbsp; - \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VA_RESERVED_SIZE)<br=
>
<br>
Thanks<br>
Roger(Hongbo.He)<br>
<br>
&nbsp;#define amdgpu_sriov_enabled(adev) \<br>
&nbsp;((adev)-&gt;virt.caps &amp; AMDGPU_SRIOV_CAPS_ENABLE_IOV)<br>
--<br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"x_x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</blockquote>
<br>
</div>
</blockquote>
<br>
</div>
</body>
</html>

--_000_BLUPR12MB044994791174D013A88B302284E30BLUPR12MB0449namp_--

--===============0765743553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0765743553==--
