From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: Extends amdgpu vm definitions
Date: Thu, 8 Aug 2019 16:23:58 +0000
Message-ID: <BL0PR12MB2580C9220232DA47486E5E0080D70@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <1565145062-16674-1-git-send-email-Oak.Zeng@amd.com>
 <3e4f2f68-8840-d85c-052e-fc54dbf45fd4@gmail.com>,
 <BL0PR12MB2580601F44DB50051768070080D70@BL0PR12MB2580.namprd12.prod.outlook.com>
 <BN6PR12MB1809D2F0A97155733CA3FC6EF7D70@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1317560450=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809D2F0A97155733CA3FC6EF7D70-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mirza, Jimshed" <Jimshed.Mirza-5C7GfCeVMHo@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Keely,
 Sean" <Sean.Keely-5C7GfCeVMHo@public.gmane.org>

--===============1317560450==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR12MB2580C9220232DA47486E5E0080D70BL0PR12MB2580namp_"

--_000_BL0PR12MB2580C9220232DA47486E5E0080D70BL0PR12MB2580namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

+@Mirza, Jimshed<mailto:Jimshed.Mirza-5C7GfCeVMHo@public.gmane.org>: do we have the ability to s=
noop another GPU's cache, in a multiple GPU system?

Regards,
Oak

From: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, August 8, 2019 12:10 PM
To: Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Christian.Koenig@amd.c=
om>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; Keely, Sean <Sean.Keely@amd.c=
om>
Subject: Re: [PATCH 1/5] drm/amdgpu: Extends amdgpu vm definitions

The snoop bit is for snooping the CPU cache by the GPU when doing system me=
mory mappings.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oa=
k.Zeng-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, August 8, 2019 12:02 PM
To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org<mailto:Christian.Koenig@amd=
.com>>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>=
 <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>=
; Keely, Sean <Sean.Keely-5C7GfCeVMHo@public.gmane.org<mailto:Sean.Keely-5C7GfCeVMHo@public.gmane.org>>
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
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ckoenig.le=
ichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Wednesday, August 7, 2019 4:42 AM
To: Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>>; amd-gfx-PD4FTy7X32k@public.gmane.org=
eedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>=
; Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org<mailto:Christian.Koenig@amd.c=
om>>; Keely, Sean <Sean.Keely-5C7GfCeVMHo@public.gmane.org<mailto:Sean.Keely-5C7GfCeVMHo@public.gmane.org>>
Subject: Re: [PATCH 1/5] drm/amdgpu: Extends amdgpu vm definitions

Am 07.08.19 um 04:31 schrieb Zeng, Oak:
> Add definition of all supported mtypes. The RW mtype is recently
> introduced for arcturus. Also add definition for the
> cachable/snoopable bit, which will be used later in this series.
>
> Change-Id: I96fc9bb4b6b1e62bdc10b600d8aaa6a802128d6d
> Signed-off-by: Oak Zeng <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BL0PR12MB2580C9220232DA47486E5E0080D70BL0PR12MB2580namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">&#43;<a id=3D"OWAAM94D75218BDAB4D8080182546162D8937"=
 href=3D"mailto:Jimshed.Mirza-5C7GfCeVMHo@public.gmane.org"><span style=3D"font-family:&quot;Cal=
ibri&quot;,sans-serif;text-decoration:none">@Mirza, Jimshed</span></a>: do =
we have the ability to snoop another GPU&#8217;s cache, in a
 multiple GPU system?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Oak<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Thursday, August 8, 2019 12:10 PM<br>
<b>To:</b> Zeng, Oak &lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian &lt;Christ=
ian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; Keely, Sean &lt;=
Sean.Keely-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/5] drm/amdgpu: Extends amdgpu vm definitions<o=
:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">The sno=
op bit is for snooping the CPU cache by the GPU when doing system memory ma=
ppings.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Zeng, Oak &lt;<a href=3D"mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">Oak.Zeng-5C7GfCeVMHo@public.gmane.org</a>&gt=
;<br>
<b>Sent:</b> Thursday, August 8, 2019 12:02 PM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org=
">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">Fe=
lix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;; Keely, Sean &lt;<a href=3D"mailto:Sean.Keely@=
amd.com">Sean.Keely-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 1/5] drm/amdgpu: Extends amdgpu vm definitions</=
span> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">Hi Christian,<br>
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
From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.=
com">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
<br>
Sent: Wednesday, August 7, 2019 4:42 AM<br>
To: Zeng, Oak &lt;<a href=3D"mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">Oak.Zeng-5C7GfCeVMHo@public.gmane.org</a>&=
gt;; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
Cc: Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">Felix.Kue=
hling-5C7GfCeVMHo@public.gmane.org</a>&gt;; Koenig, Christian &lt;<a href=3D"mailto:Christian.Ko=
enig-5C7GfCeVMHo@public.gmane.org">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;; Keely, Sean &lt;<a href=3D"=
mailto:Sean.Keely-5C7GfCeVMHo@public.gmane.org">Sean.Keely-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Subject: Re: [PATCH 1/5] drm/amdgpu: Extends amdgpu vm definitions<br>
<br>
Am 07.08.19 um 04:31 schrieb Zeng, Oak:<br>
&gt; Add definition of all supported mtypes. The RW mtype is recently <br>
&gt; introduced for arcturus. Also add definition for the <br>
&gt; cachable/snoopable bit, which will be used later in this series.<br>
&gt;<br>
&gt; Change-Id: I96fc9bb4b6b1e62bdc10b600d8aaa6a802128d6d<br>
&gt; Signed-off-by: Oak Zeng &lt;<a href=3D"mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">Oak.Ze=
ng-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
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
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_BL0PR12MB2580C9220232DA47486E5E0080D70BL0PR12MB2580namp_--

--===============1317560450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1317560450==--
