From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu: Extends amdgpu vm definitions
Date: Thu, 8 Aug 2019 16:09:40 +0000
Message-ID: <BN6PR12MB1809D2F0A97155733CA3FC6EF7D70@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1565145062-16674-1-git-send-email-Oak.Zeng@amd.com>
 <3e4f2f68-8840-d85c-052e-fc54dbf45fd4@gmail.com>,
 <BL0PR12MB2580601F44DB50051768070080D70@BL0PR12MB2580.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0208976851=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BL0PR12MB2580601F44DB50051768070080D70-b4cIHhjg/p/XzH18dTCKOgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Keely,
 Sean" <Sean.Keely-5C7GfCeVMHo@public.gmane.org>

--===============0208976851==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809D2F0A97155733CA3FC6EF7D70BN6PR12MB1809namp_"

--_000_BN6PR12MB1809D2F0A97155733CA3FC6EF7D70BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The snoop bit is for snooping the CPU cache by the GPU when doing system me=
mory mappings.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zeng, Oa=
k <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, August 8, 2019 12:02 PM
To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; Keely, Sean <Sean.Keely@amd.c=
om>
Subject: RE: [PATCH 1/5] drm/amdgpu: Extends amdgpu vm definitions

Hi Christian,

My understanding of the snoop bit (C bit in the PTE definition) is to probe=
 remote gpu's L2 cache after this gpu write remote gpu's vram. Is this corr=
ect? I am still checking this point with HW engineer.

If this is correct, then the snooping (or probing) is a way to maintain cer=
tain cache coherency when one memory is access by two masters (for example =
two gpu). With existing AMDGPU_VM_ definitions in amdgpu_drm.h, how does a =
user implement the request like: I want a trunk of vram physically in a rem=
ote gpu, I want to access it in a uncached way (AMDGPU_VM_MTYPE_UC) but I w=
ant to probe remote gpu's cache when I modify this vram.

>From PTE's definition, both C bit and mtype and R/W/X bits are just flags t=
o enable user to program page access behavior. Any detail reason why we sho=
uldn't expose the snoop bit?

Regards,
Oak

-----Original Message-----
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, August 7, 2019 4:42 AM
To: Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Christian.=
Koenig-5C7GfCeVMHo@public.gmane.org>; Keely, Sean <Sean.Keely-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu: Extends amdgpu vm definitions

Am 07.08.19 um 04:31 schrieb Zeng, Oak:
> Add definition of all supported mtypes. The RW mtype is recently
> introduced for arcturus. Also add definition for the
> cachable/snoopable bit, which will be used later in this series.
>
> Change-Id: I96fc9bb4b6b1e62bdc10b600d8aaa6a802128d6d
> Signed-off-by: Oak Zeng <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 9 +++++++--
>   include/uapi/drm/amdgpu_drm.h          | 4 ++++
>   2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 2eda3a8..7a77477 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -80,8 +80,13 @@ struct amdgpu_bo_list_entry;
>   #define AMDGPU_PTE_MTYPE_VG10(a)    ((uint64_t)(a) << 57)
>   #define AMDGPU_PTE_MTYPE_VG10_MASK  AMDGPU_PTE_MTYPE_VG10(3ULL)
>
> -#define AMDGPU_MTYPE_NC 0
> -#define AMDGPU_MTYPE_CC 2
> +enum amdgpu_mtype {
> +     AMDGPU_MTYPE_NC =3D 0,
> +     AMDGPU_MTYPE_WC =3D 1,
> +     AMDGPU_MTYPE_CC =3D 2,
> +     AMDGPU_MTYPE_UC =3D 3,
> +     AMDGPU_MTYPE_RW =3D 4,
> +};
>
>   #define AMDGPU_PTE_DEFAULT_ATC  (AMDGPU_PTE_SYSTEM      \
>                                   | AMDGPU_PTE_SNOOPED    \
> diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h index ca97b68..2889663 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -503,6 +503,10 @@ struct drm_amdgpu_gem_op {
>   #define AMDGPU_VM_MTYPE_CC          (3 << 5)
>   /* Use UC MTYPE instead of default MTYPE */
>   #define AMDGPU_VM_MTYPE_UC          (4 << 5)
> +/* Use RW MTYPE instead of default MTYPE */
> +#define AMDGPU_VM_MTYPE_RW           (5 << 5)

> +/* Cacheable/snoopable */
> +#define AMDGPU_VM_PAGE_SNOOPED               (1 << 9)

That's a rather big NAK. Cache snooping is not something userspace is allow=
ed to be aware of.

Christian.

>
>   struct drm_amdgpu_gem_va {
>        /** GEM object handle */

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809D2F0A97155733CA3FC6EF7D70BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The snoop bit is for snooping the CPU cache by the GPU when doing system me=
mory mappings.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zeng, Oak &lt;Oak.Zeng-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
<b>Sent:</b> Thursday, August 8, 2019 12:02 PM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; Keely, Sean &lt;=
Sean.Keely-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH 1/5] drm/amdgpu: Extends amdgpu vm definitions</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Christian,<br>
<br>
My understanding of the snoop bit (C bit in the PTE definition) is to probe=
 remote gpu's L2 cache after this gpu write remote gpu's vram. Is this corr=
ect? I am still checking this point with HW engineer.<br>
<br>
If this is correct, then the snooping (or probing) is a way to maintain cer=
tain cache coherency when one memory is access by two masters (for example =
two gpu). With existing AMDGPU_VM_ definitions in amdgpu_drm.h, how does a =
user implement the request like:
 I want a trunk of vram physically in a remote gpu, I want to access it in =
a uncached way (AMDGPU_VM_MTYPE_UC) but I want to probe remote gpu's cache =
when I modify this vram.<br>
<br>
>From PTE's definition, both C bit and mtype and R/W/X bits are just flags t=
o enable user to program page access behavior. Any detail reason why we sho=
uldn't expose the snoop bit?<br>
<br>
Regards,<br>
Oak<br>
<br>
-----Original Message-----<br>
From: Christian K=F6nig &lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; <br>
Sent: Wednesday, August 7, 2019 4:42 AM<br>
To: Zeng, Oak &lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian &lt;C=
hristian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; Keely, Sean &lt;Sean.Keely-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: Re: [PATCH 1/5] drm/amdgpu: Extends amdgpu vm definitions<br>
<br>
Am 07.08.19 um 04:31 schrieb Zeng, Oak:<br>
&gt; Add definition of all supported mtypes. The RW mtype is recently <br>
&gt; introduced for arcturus. Also add definition for the <br>
&gt; cachable/snoopable bit, which will be used later in this series.<br>
&gt;<br>
&gt; Change-Id: I96fc9bb4b6b1e62bdc10b600d8aaa6a802128d6d<br>
&gt; Signed-off-by: Oak Zeng &lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 9 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; | 4 &#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 2 files changed, 11 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; index 2eda3a8..7a77477 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; @@ -80,8 &#43;80,13 @@ struct amdgpu_bo_list_entry;<br>
&gt;&nbsp;&nbsp; #define AMDGPU_PTE_MTYPE_VG10(a)&nbsp;&nbsp;&nbsp; ((uint6=
4_t)(a) &lt;&lt; 57)<br>
&gt;&nbsp;&nbsp; #define AMDGPU_PTE_MTYPE_VG10_MASK&nbsp; AMDGPU_PTE_MTYPE_=
VG10(3ULL)<br>
&gt;&nbsp;&nbsp; <br>
&gt; -#define AMDGPU_MTYPE_NC 0<br>
&gt; -#define AMDGPU_MTYPE_CC 2<br>
&gt; &#43;enum amdgpu_mtype {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_MTYPE_NC =3D 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_MTYPE_WC =3D 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_MTYPE_CC =3D 2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_MTYPE_UC =3D 3,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_MTYPE_RW =3D 4,<br>
&gt; &#43;};<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define AMDGPU_PTE_DEFAULT_ATC&nbsp; (AMDGPU_PTE_SYSTEM&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | AMDGPU_PTE_SNO=
OPED&nbsp;&nbsp;&nbsp; \<br>
&gt; diff --git a/include/uapi/drm/amdgpu_drm.h <br>
&gt; b/include/uapi/drm/amdgpu_drm.h index ca97b68..2889663 100644<br>
&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt; &#43;&#43;&#43; b/include/uapi/drm/amdgpu_drm.h<br>
&gt; @@ -503,6 &#43;503,10 @@ struct drm_amdgpu_gem_op {<br>
&gt;&nbsp;&nbsp; #define AMDGPU_VM_MTYPE_CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; (3 &lt;&lt; 5)<br>
&gt;&nbsp;&nbsp; /* Use UC MTYPE instead of default MTYPE */<br>
&gt;&nbsp;&nbsp; #define AMDGPU_VM_MTYPE_UC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; (4 &lt;&lt; 5)<br>
&gt; &#43;/* Use RW MTYPE instead of default MTYPE */<br>
&gt; &#43;#define AMDGPU_VM_MTYPE_RW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (5 &lt;&lt; 5)<br>
<br>
&gt; &#43;/* Cacheable/snoopable */<br>
&gt; &#43;#define AMDGPU_VM_PAGE_SNOOPED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 9)<br>
<br>
That's a rather big NAK. Cache snooping is not something userspace is allow=
ed to be aware of.<br>
<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct drm_amdgpu_gem_va {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** GEM object handle */<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809D2F0A97155733CA3FC6EF7D70BN6PR12MB1809namp_--

--===============0208976851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0208976851==--
