From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Date: Fri, 15 Nov 2019 14:49:47 +0000
Message-ID: <DM5PR12MB182063DB1ACAD38C768ECAC3F7700@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>,
 <06a979a0-0795-88cb-f1d9-80255165f0e4@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0468583008=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <06a979a0-0795-88cb-f1d9-80255165f0e4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Tuikov, Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, "Olsak,
 Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Liu,
 Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0468583008==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB182063DB1ACAD38C768ECAC3F7700DM5PR12MB1820namp_"

--_000_DM5PR12MB182063DB1ACAD38C768ECAC3F7700DM5PR12MB1820namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

We can't land the kernel side until we have real userspace (e.g., Mesa) tha=
t uses the TMZ interfaces.  The unit tests are not enough.

Alex


________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, November 15, 2019 7:56 AM
To: Liu, Aaron <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Cc: Olsak, Marek <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Tui=
kov, Luben <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Liu, Leo <Leo.Liu-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Christian.Koenig@amd=
.com>
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers

Am 15.11.19 um 04:34 schrieb Aaron Liu:
> From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
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
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

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


--_000_DM5PR12MB182063DB1ACAD38C768ECAC3F7700DM5PR12MB1820namp_
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
We can't land the kernel side until we have real userspace (e.g., Mesa) tha=
t uses the TMZ interfaces.&nbsp; The unit tests are not enough.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Christian K=F6nig &=
lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, November 15, 2019 7:56 AM<br>
<b>To:</b> Liu, Aaron &lt;Aaron.Liu-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Olsak, Marek &lt;Marek.Olsak-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray &lt;Ray.Hua=
ng-5C7GfCeVMHo@public.gmane.org&gt;; Tuikov, Luben &lt;Luben.Tuikov-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Alexan=
der &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Liu, Leo &lt;Leo.Liu-5C7GfCeVMHo@public.gmane.org&gt;; Ko=
enig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted b=
uffers</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 15.11.19 um 04:34 schrieb Aaron Liu:<br>
&gt; From: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
&gt; Signed-off-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
omain */<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB182063DB1ACAD38C768ECAC3F7700DM5PR12MB1820namp_--

--===============0468583008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0468583008==--
