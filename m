From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: Add comments to gmc structure
Date: Thu, 7 Nov 2019 18:02:07 +0000
Message-ID: <BL0PR12MB25808E11A26B24C319F3121080780@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <1573061209-13148-1-git-send-email-Oak.Zeng@amd.com>,
 <CADnq5_OinRnn+39TiX2SQkoBwwMPRO2vt0nTSLkwSBq-Mw2vBQ@mail.gmail.com>
 <DM6PR12MB2778E5EB97BBDE1FBFB3DA12F0780@DM6PR12MB2778.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0008490919=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM6PR12MB2778E5EB97BBDE1FBFB3DA12F0780-lmeGfMZKVrFSet88YzIdmgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0008490919==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL0PR12MB25808E11A26B24C319F3121080780BL0PR12MB2580namp_"

--_000_BL0PR12MB25808E11A26B24C319F3121080780BL0PR12MB2580namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Yong,

That has been submitted.

MC address is the address sent to memory controller bus to address the phys=
ical memory. In many places it is also called physical address.

Logical address is the address before it is translated to physical address.=
 The translation can be either linear or through page table. Under VMID0, l=
ogical address of some apertures (AGP, FB) are linearly mapped to MC addres=
s. (I think in our driver implementation, logical address =3D=3D MC address=
). But Gart aperture is mapped through gpuvm (gart) page table - the mapped=
 address can also be called virtual address.

Under VMID1~15, it is user space virtual address (can also be called logica=
l address), mapped through gpuvm page tables.

So virtual address is one type of logical address. Virtual address is usual=
ly mapped through page table/vm.

Just my understanding.

Regards,
Oak

From: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, November 7, 2019 12:16 PM
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Cc: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Christian.=
Koenig-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Add comments to gmc structure

If this is not submitted, I would like to see some comments regarding the e=
xplanation of MC address and logical address, which I prefer to mention as =
GPU physical/virtual address.

Regards,
Yong


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<m=
ailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Thursday, November 7, 2019 9:02 AM
To: Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>>
Cc: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>=
; Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org<mailto:Christian.Koenig@amd.c=
om>>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Subject: Re: [PATCH] drm/amdgpu: Add comments to gmc structure

On Wed, Nov 6, 2019 at 12:27 PM Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oak.Zeng=
@amd.com>> wrote:
>
> Explain fields like aper_base, agp_start etc. The definition
> of those fields are confusing as they are from different view
> (CPU or GPU). Add comments for easier understand.
>
> Change-Id: I02c2a27cd0dbc205498eb86aafa722f2e0c25fe6
> Signed-off-by: Oak Zeng <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>>

Same comments as the previous version.  With those addressed,
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deuch=
er-5C7GfCeVMHo@public.gmane.org>>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index 555d8e5..1356ff9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -127,18 +127,44 @@ struct amdgpu_xgmi {
>  };
>
>  struct amdgpu_gmc {
> +       /* FB's physical address in MMIO space (for CPU to
> +        * map FB). This is different compared to the apg/
> +        * gart/vram_start/end field as the later is from
> +        * GPU's view and aper_base is from CPU's view.
> +        */
>         resource_size_t         aper_size;
>         resource_size_t         aper_base;
>         /* for some chips with <=3D 32MB we need to lie
>          * about vram size near mc fb location */
>         u64                     mc_vram_size;
>         u64                     visible_vram_size;
> +       /* APG aperture start and end in MC address space
> +        * Driver find a hole in the MC address space
> +        * to place AGP by setting MC_VM_AGP_BOT/TOP registers
> +        * Under VMID0, logical address =3D=3D MC address
> +        * AGP aperture is used to simulate FB in ZFB case
> +        */
>         u64                     agp_size;
>         u64                     agp_start;
>         u64                     agp_end;
> +       /* GART aperture start and end in MC address space
> +        * Driver find a hole in the MC address space
> +        * to place GART by setting VM_CONTEXT0_PAGE_TABLE_START/END_ADDR
> +        * registers
> +        * Under VMID0, logical address inside GART aperture will
> +        * be translated through gpuvm gart page table to access
> +        * paged system memory
> +        */
>         u64                     gart_size;
>         u64                     gart_start;
>         u64                     gart_end;
> +       /* Frame buffer aperture of this GPU device. Different from
> +        * fb_start (see below), this only covers the local GPU device.
> +        * Driver get fb_start from MC_VM_FB_LOCATION_BASE (set by vbios)
> +        * and calculate vram_start of this local device by adding an
> +        * offset inside the XGMI hive.
> +        * Under VMID0, logical address =3D=3D MC address
> +        */
>         u64                     vram_start;
>         u64                     vram_end;
>         /* FB region , it's same as local vram region in single GPU, in X=
GMI
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BL0PR12MB25808E11A26B24C319F3121080780BL0PR12MB2580namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
span.EmailStyle18
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
<p class=3D"MsoNormal">Hi Yong,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">That has been submitted. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">MC address is the address sent to memory controller =
bus to address the physical memory. In many places it is also called physic=
al address.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Logical address is the address before it is translat=
ed to physical address. The translation can be either linear or through pag=
e table. Under VMID0, logical address of some apertures (AGP, FB) are linea=
rly mapped to MC address. (I think
 in our driver implementation, logical address =3D=3D MC address). But Gart=
 aperture is mapped through gpuvm (gart) page table &#8211; the mapped addr=
ess can also be called virtual address.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Under VMID1~15, it is user space virtual address (ca=
n also be called logical address), mapped through gpuvm page tables.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So virtual address is one type of logical address. V=
irtual address is usually mapped through page table/vm.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Just my understanding.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Oak<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt; <b=
r>
<b>Sent:</b> Thursday, November 7, 2019 12:16 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; Zeng, Oak &lt;Oak.Ze=
ng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christia=
n &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add comments to gmc structure<o:p><=
/o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">If this=
 is not submitted, I would like to see some comments regarding the explanat=
ion of MC address and logical address, which I prefer to mention as GPU phy=
sical/virtual address.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Regards=
,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Yong<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;</span><a href=3D"mailto:amd-gfx-bounce=
s@lists.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><span sty=
le=3D"color:black">&gt; on behalf of Alex Deucher
 &lt;</span><a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<=
/a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> Thursday, November 7, 2019 9:02 AM<br>
<b>To:</b> Zeng, Oak &lt;</span><a href=3D"mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">Oak.Zen=
g@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;</span><a href=3D"mailto:Felix.Kuehling@amd.=
com">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;; Koenig, Ch=
ristian &lt;</span><a href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">Christian.Ko=
enig-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><span style=3D=
"color:black">&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add comments to gmc structure</span=
> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">On Wed, Nov 6, 2019 at 12:27 PM Zeng, Oak &lt;<a hre=
f=3D"mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">Oak.Zeng-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Explain fields like aper_base, agp_start etc. The definition<br>
&gt; of those fields are confusing as they are from different view<br>
&gt; (CPU or GPU). Add comments for easier understand.<br>
&gt;<br>
&gt; Change-Id: I02c2a27cd0dbc205498eb86aafa722f2e0c25fe6<br>
&gt; Signed-off-by: Oak Zeng &lt;<a href=3D"mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">Oak.Ze=
ng-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
Same comments as the previous version.&nbsp; With those addressed,<br>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">=
alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 26 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 26 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h<br>
&gt; index 555d8e5..1356ff9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; @@ -127,18 &#43;127,44 @@ struct amdgpu_xgmi {<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; struct amdgpu_gmc {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FB's physical address in =
MMIO space (for CPU to<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * map FB). This is dif=
ferent compared to the apg/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * gart/vram_start/end =
field as the later is from<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * GPU's view and aper_=
base is from CPU's view.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aper_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aper_base;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* for some chips with=
 &lt;=3D 32MB we need to lie<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * about vram siz=
e near mc fb location */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mc_vram_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; visible_vram_size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* APG aperture start and en=
d in MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Driver find a hole i=
n the MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to place AGP by sett=
ing MC_VM_AGP_BOT/TOP registers<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Under VMID0, logical=
 address =3D=3D MC address<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * AGP aperture is used=
 to simulate FB in ZFB case<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; agp_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; agp_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; agp_end;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GART aperture start and e=
nd in MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Driver find a hole i=
n the MC address space<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to place GART by set=
ting VM_CONTEXT0_PAGE_TABLE_START/END_ADDR<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * registers<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Under VMID0, logical=
 address inside GART aperture will<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * be translated throug=
h gpuvm gart page table to access<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * paged system memory<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; gart_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; gart_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; gart_end;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Frame buffer aperture of =
this GPU device. Different from<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fb_start (see below)=
, this only covers the local GPU device.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Driver get fb_start =
from MC_VM_FB_LOCATION_BASE (set by vbios)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and calculate vram_s=
tart of this local device by adding an<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * offset inside the XG=
MI hive.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Under VMID0, logical=
 address =3D=3D MC address<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; vram_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; vram_end;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FB region , it's sa=
me as local vram region in single GPU, in XGMI<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
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

--_000_BL0PR12MB25808E11A26B24C319F3121080780BL0PR12MB2580namp_--

--===============0008490919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0008490919==--
