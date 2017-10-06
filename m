From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Set the correct value for PDEs/PTEs of ATC
 memory on Raven
Date: Fri, 6 Oct 2017 19:02:40 +0000
Message-ID: <CY4PR12MB1430E2480393A89A98B0A6A2F0710@CY4PR12MB1430.namprd12.prod.outlook.com>
References: <1507304133-21510-1-git-send-email-yong.zhao@amd.com>,
 <ff321dde-dac3-9f51-266a-bca5ada11e5c@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1491078092=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ff321dde-dac3-9f51-266a-bca5ada11e5c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============1491078092==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1430E2480393A89A98B0A6A2F0710CY4PR12MB1430namp_"

--_000_CY4PR12MB1430E2480393A89A98B0A6A2F0710CY4PR12MB1430namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks. Pushed.


Yong

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, October 6, 2017 1:16:36 PM
To: Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Set the correct value for PDEs/PTEs of ATC=
 memory on Raven

Am 06.10.2017 um 17:35 schrieb Yong Zhao:
> From: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
>
> Without the additional bits set in PDEs/PTEs, the ATC memory access
> would have failed on Raven.
>
> Change-Id: I28429ef6d39cdb01dc6f17fea4264ee22d7121d4
> Signed-off-by: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Nice solution for the define. Patch is Reviewed-by: Christian K=F6nig
<christian.koenig-5C7GfCeVMHo@public.gmane.org>.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  9 ++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 10 ++++++++++
>   2 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index bca9eeb..d98d58a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -328,9 +328,10 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_devi=
ce *adev,
>                                AMDGPU_GEM_CREATE_SHADOW);
>
>        if (vm->pte_support_ats) {
> -             init_value =3D AMDGPU_PTE_SYSTEM;
> +             init_value =3D AMDGPU_PTE_DEFAULT_ATC;
>                if (level !=3D adev->vm_manager.num_level - 1)
>                        init_value |=3D AMDGPU_PDE_PTE;
> +
>        }
>
>        /* walk over the address space and allocate the page tables */
> @@ -2017,7 +2018,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *ade=
v,
>                list_del(&mapping->list);
>
>                if (vm->pte_support_ats)
> -                     init_pte_value =3D AMDGPU_PTE_SYSTEM;
> +                     init_pte_value =3D AMDGPU_PTE_DEFAULT_ATC;
>
>                r =3D amdgpu_vm_bo_update_mapping(adev, NULL, NULL, vm,
>                                                mapping->start, mapping->l=
ast,
> @@ -2629,7 +2630,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
>
>                if (adev->asic_type =3D=3D CHIP_RAVEN) {
>                        vm->pte_support_ats =3D true;
> -                     init_pde_value =3D AMDGPU_PTE_SYSTEM | AMDGPU_PDE_P=
TE;
> +                     init_pde_value =3D AMDGPU_PTE_DEFAULT_ATC
> +                                     | AMDGPU_PDE_PTE;
> +
>                }
>        } else
>                vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_m=
ode &
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 66efbc2..5d0cfc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -73,6 +73,16 @@ struct amdgpu_bo_list_entry;
>   #define AMDGPU_PTE_MTYPE(a)    ((uint64_t)a << 57)
>   #define AMDGPU_PTE_MTYPE_MASK       AMDGPU_PTE_MTYPE(3ULL)
>
> +/* For Raven */
> +#define AMDGPU_MTYPE_CC 2
> +
> +#define AMDGPU_PTE_DEFAULT_ATC  (AMDGPU_PTE_SYSTEM      \
> +                                | AMDGPU_PTE_SNOOPED    \
> +                                | AMDGPU_PTE_EXECUTABLE \
> +                                | AMDGPU_PTE_READABLE   \
> +                                | AMDGPU_PTE_WRITEABLE  \
> +                                | AMDGPU_PTE_MTYPE(AMDGPU_MTYPE_CC))
> +
>   /* How to programm VM fault handling */
>   #define AMDGPU_VM_FAULT_STOP_NEVER  0
>   #define AMDGPU_VM_FAULT_STOP_FIRST  1



--_000_CY4PR12MB1430E2480393A89A98B0A6A2F0710CY4PR12MB1430namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>Thanks. Pushed.</p>
<p><br>
</p>
<p>Yong<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &=
lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, October 6, 2017 1:16:36 PM<br>
<b>To:</b> Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Set the correct value for PDEs/PTEs=
 of ATC memory on Raven</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Am 06.10.2017 um 17:35 schrieb Yong Zhao:<br>
&gt; From: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Without the additional bits set in PDEs/PTEs, the ATC memory access<br=
>
&gt; would have failed on Raven.<br>
&gt;<br>
&gt; Change-Id: I28429ef6d39cdb01dc6f17fea4264ee22d7121d4<br>
&gt; Signed-off-by: Yong Zhao &lt;yong.zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Nice solution for the define. Patch is Reviewed-by: Christian K=F6nig <br>
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |&nbsp; 9 &#43;&#43=
;&#43;&#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 10 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 2 files changed, 16 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index bca9eeb..d98d58a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -328,9 &#43;328,10 @@ static int amdgpu_vm_alloc_levels(struct amdg=
pu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_CREATE_SHADOW);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;pte_support_ats) =
{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; init_value =3D AMDGPU_PTE_SYSTEM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; init_value =3D AMDGPU_PTE_DEFAULT_ATC;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (level !=3D adev-&gt;vm_manager.num_level - 1)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_va=
lue |=3D AMDGPU_PDE_PTE;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* walk over the address spa=
ce and allocate the page tables */<br>
&gt; @@ -2017,7 &#43;2018,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; list_del(&amp;mapping-&gt;list);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (vm-&gt;pte_support_ats)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pte_value =3D AMDG=
PU_PTE_SYSTEM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pte_value =3D =
AMDGPU_PTE_DEFAULT_ATC;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_bo_update_mapping(adev, NULL, NULL, vm,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;s=
tart, mapping-&gt;last,<br>
&gt; @@ -2629,7 &#43;2630,9 @@ int amdgpu_vm_init(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_RAVEN) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;=
pte_support_ats =3D true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pde_value =3D AMDG=
PU_PTE_SYSTEM | AMDGPU_PDE_PTE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pde_value =3D =
AMDGPU_PTE_DEFAULT_ATC<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | AMDGPU_PDE_PTE;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update =3D !!(adev-&gt;vm_manager.vm=
_update_mode &amp;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.h<br>
&gt; index 66efbc2..5d0cfc9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; @@ -73,6 &#43;73,16 @@ struct amdgpu_bo_list_entry;<br>
&gt;&nbsp;&nbsp; #define AMDGPU_PTE_MTYPE(a)&nbsp;&nbsp;&nbsp; ((uint64_t)a=
 &lt;&lt; 57)<br>
&gt;&nbsp;&nbsp; #define AMDGPU_PTE_MTYPE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; AMDGPU_PTE_MTYPE(3ULL)<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;/* For Raven */<br>
&gt; &#43;#define AMDGPU_MTYPE_CC 2<br>
&gt; &#43;<br>
&gt; &#43;#define AMDGPU_PTE_DEFAULT_ATC&nbsp; (AMDGPU_PTE_SYSTEM&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | AMDGPU_PTE_SNOOPED&nbsp;&n=
bsp;&nbsp; \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | AMDGPU_PTE_EXECUTABLE \<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | AMDGPU_PTE_READABLE&nbsp;&=
nbsp; \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | AMDGPU_PTE_WRITEABLE&nbsp;=
 \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | AMDGPU_PTE_MTYPE(AMDGPU_MT=
YPE_CC))<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; /* How to programm VM fault handling */<br>
&gt;&nbsp;&nbsp; #define AMDGPU_VM_FAULT_STOP_NEVER&nbsp; 0<br>
&gt;&nbsp;&nbsp; #define AMDGPU_VM_FAULT_STOP_FIRST&nbsp; 1<br>
<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB1430E2480393A89A98B0A6A2F0710CY4PR12MB1430namp_--

--===============1491078092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1491078092==--
