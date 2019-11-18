From: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Date: Mon, 18 Nov 2019 09:28:57 +0000
Message-ID: <MN2PR12MB3838E0228F0AB2E58DB9109DF04D0@MN2PR12MB3838.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>,
 <06a979a0-0795-88cb-f1d9-80255165f0e4@gmail.com>,
 <DM5PR12MB182063DB1ACAD38C768ECAC3F7700@DM5PR12MB1820.namprd12.prod.outlook.com>,
 <1f6819bc-cf46-4f34-a569-9ba39a9c6559@email.android.com>,
 <DM6PR12MB32097BA0BE4D40FF431A6E11F9700@DM6PR12MB3209.namprd12.prod.outlook.com>
 <DM6PR12MB3209676F6F84150C08400C93F9700@DM6PR12MB3209.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0839607660=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM6PR12MB3209676F6F84150C08400C93F9700-lmeGfMZKVrEA9tGwT7oCEgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>, "Tuikov,
 Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0839607660==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3838E0228F0AB2E58DB9109DF04D0MN2PR12MB3838namp_"

--_000_MN2PR12MB3838E0228F0AB2E58DB9109DF04D0MN2PR12MB3838namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for reviews.

As Christian's suggestion, I added drm_version checking, for the older driv=
er, security test suites are disabled.
I create a remote branch for libdrm: remotes/origin/aaliu/for-tmz-support

BR,
Aaron Liu

From: Olsak, Marek <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>
Sent: Saturday, November 16, 2019 3:53 AM
To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexa=
nder.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Liu, Aaron <Aaron=
.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org=
>; Tuikov, Luben <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>; Liu, Leo <Leo.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers

The way this is upstreamed is that you submit the kernel and userspace patc=
hes for review at the same time. When they see the userspace patches, the k=
ernel patches will be accepted. When the kernel patches land in the Dave's =
or Linus's tree, the userspace patches can be pushed.

Marek
________________________________
From: Olsak, Marek <Marek.Olsak-5C7GfCeVMHo@public.gmane.org<mailto:Marek.Olsak-5C7GfCeVMHo@public.gmane.org>>
Sent: November 15, 2019 14:34
To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org<mailto:Christian.Koenig@amd=
.com>>; Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deuc=
her-5C7GfCeVMHo@public.gmane.org>>
Cc: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ckoenig.leic=
htzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>; Liu, Aaron <Aaron.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Aaron.Liu@amd.=
com>>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>; Huan=
g, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org<mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org>>; Tuikov, Luben <Luben.=
Tuikov-5C7GfCeVMHo@public.gmane.org<mailto:Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>>; Liu, Leo <Leo.Liu-5C7GfCeVMHo@public.gmane.org<mai=
lto:Leo.Liu-5C7GfCeVMHo@public.gmane.org>>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers

In the kernel tree, you need to do "make headers_install". Then copy amdgpu=
_drm.h from ./usr/ to the libdrm tree and discard parts that we can't upstr=
eam (freesync).

Marek
________________________________
From: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org<mailto:Christian.Koenig@a=
md.com>>
Sent: November 15, 2019 10:08
To: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deucher@=
amd.com>>
Cc: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ckoenig.leic=
htzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>; Liu, Aaron <Aaron.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Aaron.Liu@amd.=
com>>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>; Olsa=
k, Marek <Marek.Olsak-5C7GfCeVMHo@public.gmane.org<mailto:Marek.Olsak-5C7GfCeVMHo@public.gmane.org>>; Huang, Ray <Ray=
.Huang-5C7GfCeVMHo@public.gmane.org<mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org>>; Tuikov, Luben <Luben.Tuikov@amd.=
com<mailto:Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>>; Liu, Leo <Leo.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Leo.Liu=
@amd.com>>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers

I know, that's the usual chicken and egg problem with updating libdrm.

But we should update the file with the kernel version and not pick all chan=
ges line by line.

Christian.

Am 15.11.2019 15:49 schrieb "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org=
<mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>:
We can't land the kernel side until we have real userspace (e.g., Mesa) tha=
t uses the TMZ interfaces.  The unit tests are not enough.

Alex


________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ckoenig.le=
ichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Friday, November 15, 2019 7:56 AM
To: Liu, Aaron <Aaron.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Aaron.Liu-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Olsak, Marek <Marek.Olsak-5C7GfCeVMHo@public.gmane.org<mailto:Marek.Olsak-5C7GfCeVMHo@public.gmane.org>>; Huang, =
Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org<mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org>>; Tuikov, Luben <Luben.Tui=
kov-5C7GfCeVMHo@public.gmane.org<mailto:Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>>; Deucher, Alexander <Alexander.De=
ucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>; Liu, Leo <Leo.Liu-5C7GfCeVMHo@public.gmane.org=
<mailto:Leo.Liu-5C7GfCeVMHo@public.gmane.org>>; Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org<mail=
to:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers

Am 15.11.19 um 04:34 schrieb Aaron Liu:
> From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org<mailto:ray.huang-5C7GfCeVMHo@public.gmane.org>>
>
> To align the kernel uapi change from Alex:
>
> "Add a flag to the GEM_CREATE ioctl to create encrypted buffers. Buffers =
with
> this flag set will be created with the TMZ bit set in the PTEs or engines
> accessing them. This is required in order to properly access the data fro=
m the
> engines."
>
> We will use GEM_CREATE_ENCRYPTED flag for secure buffer allocation.
>
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org<mailto:ray.huang-5C7GfCeVMHo@public.gmane.org>>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deu=
cher-5C7GfCeVMHo@public.gmane.org>>

Please read up on how amdpu_drm.h is updated. The change must first land
upstream and then the file is synced up somehow semi-automatic.

Christian.

> ---
>   include/drm/amdgpu_drm.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
> index 5c28aa7..1a95e37 100644
> --- a/include/drm/amdgpu_drm.h
> +++ b/include/drm/amdgpu_drm.h
> @@ -141,6 +141,11 @@ extern "C" {
>    * releasing the memory
>    */
>   #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE      (1 << 9)
> +/* Flag that BO will be encrypted and that the TMZ bit should be
> + * set in the PTEs when mapping this buffer via GPUVM or
> + * accessing it with various hw blocks
> + */
> +#define AMDGPU_GEM_CREATE_ENCRYPTED          (1 << 10)
>
>   /* Hybrid specific */
>   /* Flag that the memory allocation should be from top of domain */

--_000_MN2PR12MB3838E0228F0AB2E58DB9109DF04D0MN2PR12MB3838namp_
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
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Thanks for reviews.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As Christian&#8217;s suggestion, I added drm_version=
 checking, for the older driver, security test suites are disabled.<o:p></o=
:p></p>
<p class=3D"MsoNormal">I create a remote branch for libdrm: <span style=3D"=
color:red">
remotes/origin/aaliu/for-tmz-support</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Aaron Liu<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Olsak, Marek &lt;Marek.Olsak-5C7GfCeVMHo@public.gmane.org&gt=
; <br>
<b>Sent:</b> Saturday, November 16, 2019 3:53 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; Liu,=
 Aaron &lt;Aaron.Liu-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Huang, Ray=
 &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Tuikov, Luben &lt;Luben.Tuikov-5C7GfCeVMHo@public.gmane.org&gt;; Liu=
, Leo &lt;Leo.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted b=
uffers<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">The way=
 this is upstreamed is that you submit the kernel and userspace patches for=
 review at the same time. When they see the userspace patches, the kernel p=
atches will be accepted. When the kernel
 patches land in the Dave's or Linus's tree, the userspace patches can be p=
ushed.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Marek<o=
:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Olsak, Marek &lt;</span><a href=3D"mailto:Marek.Ols=
ak-5C7GfCeVMHo@public.gmane.org">Marek.Olsak-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> November 15, 2019 14:34<br>
<b>To:</b> Koenig, Christian &lt;</span><a href=3D"mailto:Christian.Koenig@=
amd.com">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;; Deuc=
her, Alexander &lt;</span><a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Alex=
ander.Deucher-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;<br>
<b>Cc:</b> Christian K=F6nig &lt;</span><a href=3D"mailto:ckoenig.leichtzum=
erken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><span style=3D"color:b=
lack">&gt;; Liu, Aaron &lt;</span><a href=3D"mailto:Aaron.Liu-5C7GfCeVMHo@public.gmane.org">Aaro=
n.Liu-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><span style=3D=
"color:black">&gt;; Huang, Ray &lt;</span><a href=3D"mailto:Ray.Huang@amd.c=
om">Ray.Huang-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;;
 Tuikov, Luben &lt;</span><a href=3D"mailto:Luben.Tuikov-5C7GfCeVMHo@public.gmane.org">Luben.Tui=
kov-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;; Liu, Leo &lt;</span><a hre=
f=3D"mailto:Leo.Liu-5C7GfCeVMHo@public.gmane.org">Leo.Liu-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black"=
>&gt;<br>
<b>Subject:</b> Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted b=
uffers</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">In the =
kernel tree, you need to do &quot;make headers_install&quot;. Then copy amd=
gpu_drm.h from ./usr/ to the libdrm tree and discard parts that we can't up=
stream (freesync).<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Marek<o=
:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Koenig, Christian &lt;</span><a href=3D"mailto:Chri=
stian.Koenig-5C7GfCeVMHo@public.gmane.org">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:blac=
k">&gt;<br>
<b>Sent:</b> November 15, 2019 10:08<br>
<b>To:</b> Deucher, Alexander &lt;</span><a href=3D"mailto:Alexander.Deuche=
r@amd.com">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;<br=
>
<b>Cc:</b> Christian K=F6nig &lt;</span><a href=3D"mailto:ckoenig.leichtzum=
erken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><span style=3D"color:b=
lack">&gt;; Liu, Aaron &lt;</span><a href=3D"mailto:Aaron.Liu-5C7GfCeVMHo@public.gmane.org">Aaro=
n.Liu-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><span style=3D=
"color:black">&gt;; Olsak, Marek &lt;</span><a href=3D"mailto:Marek.Olsak@a=
md.com">Marek.Olsak-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;;
 Huang, Ray &lt;</span><a href=3D"mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org">Ray.Huang@amd.c=
om</a><span style=3D"color:black">&gt;; Tuikov, Luben &lt;</span><a href=3D=
"mailto:Luben.Tuikov-5C7GfCeVMHo@public.gmane.org">Luben.Tuikov-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:=
black">&gt;; Liu, Leo &lt;</span><a href=3D"mailto:Leo.Liu-5C7GfCeVMHo@public.gmane.org">Leo.Liu=
@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Subject:</b> Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted b=
uffers</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">I know, that's the usual chicken and egg problem wit=
h updating libdrm.
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">But we should update the file with the kernel versio=
n and not pick all changes line by line.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Christian.<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Am 15.11.2019 15:49 schrieb &quot;Deucher, Alexander=
&quot; &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Alexander.Deucher@a=
md.com</a>&gt;:<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">We can'=
t land the kernel side until we have real userspace (e.g., Mesa) that uses =
the TMZ interfaces.&nbsp; The unit tests are not enough.<o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
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
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Christian K=F6nig &lt;</span><a href=3D"mailto:ckoe=
nig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><span sty=
le=3D"color:black">&gt;<br>
<b>Sent:</b> Friday, November 15, 2019 7:56 AM<br>
<b>To:</b> Liu, Aaron &lt;</span><a href=3D"mailto:Aaron.Liu-5C7GfCeVMHo@public.gmane.org">Aaron=
.Liu-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><span style=3D=
"color:black">&gt;<br>
<b>Cc:</b> Olsak, Marek &lt;</span><a href=3D"mailto:Marek.Olsak-5C7GfCeVMHo@public.gmane.org">M=
arek.Olsak-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;; Huang, Ray &lt;</sp=
an><a href=3D"mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org">Ray.Huang-5C7GfCeVMHo@public.gmane.org</a><span style=3D=
"color:black">&gt;; Tuikov, Luben &lt;</span><a href=3D"mailto:Luben.Tuikov=
@amd.com">Luben.Tuikov-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;;
 Deucher, Alexander &lt;</span><a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"=
>Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;; Liu, Leo &l=
t;</span><a href=3D"mailto:Leo.Liu-5C7GfCeVMHo@public.gmane.org">Leo.Liu-5C7GfCeVMHo@public.gmane.org</a><span style=
=3D"color:black">&gt;; Koenig, Christian &lt;</span><a href=3D"mailto:Chris=
tian.Koenig-5C7GfCeVMHo@public.gmane.org">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black=
">&gt;<br>
<b>Subject:</b> Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted b=
uffers</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 15.11.19 um 04:34 =
schrieb Aaron Liu:<br>
&gt; From: Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">ray.huang@amd=
.com</a>&gt;<br>
&gt;<br>
&gt; To align the kernel uapi change from Alex:<br>
&gt;<br>
&gt; &quot;Add a flag to the GEM_CREATE ioctl to create encrypted buffers. =
Buffers with<br>
&gt; this flag set will be created with the TMZ bit set in the PTEs or engi=
nes<br>
&gt; accessing them. This is required in order to properly access the data =
from the<br>
&gt; engines.&quot;<br>
&gt;<br>
&gt; We will use GEM_CREATE_ENCRYPTED flag for secure buffer allocation.<br=
>
&gt;<br>
&gt; Signed-off-by: Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">ray.=
huang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.=
com">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
Please read up on how amdpu_drm.h is updated. The change must first land <b=
r>
upstream and then the file is synced up somehow semi-automatic.<br>
<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; include/drm/amdgpu_drm.h | 5 &#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 1 file changed, 5 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h<br>
&gt; index 5c28aa7..1a95e37 100644<br>
&gt; --- a/include/drm/amdgpu_drm.h<br>
&gt; &#43;&#43;&#43; b/include/drm/amdgpu_drm.h<br>
&gt; @@ -141,6 &#43;141,11 @@ extern &quot;C&quot; {<br>
&gt;&nbsp;&nbsp;&nbsp; * releasing the memory<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 9)<br>
&gt; &#43;/* Flag that BO will be encrypted and that the TMZ bit should be<=
br>
&gt; &#43; * set in the PTEs when mapping this buffer via GPUVM or<br>
&gt; &#43; * accessing it with various hw blocks<br>
&gt; &#43; */<br>
&gt; &#43;#define AMDGPU_GEM_CREATE_ENCRYPTED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 10)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /* Hybrid specific */<br>
&gt;&nbsp;&nbsp; /* Flag that the memory allocation should be from top of d=
omain */<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3838E0228F0AB2E58DB9109DF04D0MN2PR12MB3838namp_--

--===============0839607660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0839607660==--
