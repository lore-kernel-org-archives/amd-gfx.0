From: "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Remove check which is not valid for certain
 VBIOS
Date: Thu, 9 Nov 2017 02:45:37 +0000
Message-ID: <CY1PR12MB0474FC2F5E1C6649D74BED018C570@CY1PR12MB0474.namprd12.prod.outlook.com>
References: <1510123790-23412-1-git-send-email-Ken.Wang@amd.com>,
 <CADnq5_PyfvnstOUNRyuK6v_DVo3xo0b2YajuNjuNVed0m3EjfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0268172703=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PyfvnstOUNRyuK6v_DVo3xo0b2YajuNjuNVed0m3EjfQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0268172703==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB0474FC2F5E1C6649D74BED018C570CY1PR12MB0474namp_"

--_000_CY1PR12MB0474FC2F5E1C6649D74BED018C570CY1PR12MB0474namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

It fixes some headless board VBIOS which will be failed to load.

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, November 8, 2017 10:38:37 PM
To: Wang, Ken
Cc: amd-gfx list
Subject: Re: [PATCH] drm/amdgpu: Remove check which is not valid for certai=
n VBIOS

On Wed, Nov 8, 2017 at 1:49 AM,  <Ken.Wang-5C7GfCeVMHo@public.gmane.org> wrote:
> From: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

What cases does this fix?  I'm guessing VFCT or some other platform
method for getting the vbios?

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

>
> Signed-off-by: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index c21adf6..057e1ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -59,12 +59,6 @@ static bool check_atom_bios(uint8_t *bios, size_t size=
)
>                 return false;
>         }
>
> -       tmp =3D bios[0x18] | (bios[0x19] << 8);
> -       if (bios[tmp + 0x14] !=3D 0x0) {
> -               DRM_INFO("Not an x86 BIOS ROM\n");
> -               return false;
> -       }
> -
>         bios_header_start =3D bios[0x48] | (bios[0x49] << 8);
>         if (!bios_header_start) {
>                 DRM_INFO("Can't locate bios header\n");
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY1PR12MB0474FC2F5E1C6649D74BED018C570CY1PR12MB0474namp_
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
<p>It fixes some headless board VBIOS which will be failed to load.<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, November 8, 2017 10:38:37 PM<br>
<b>To:</b> Wang, Ken<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Remove check which is not valid for=
 certain VBIOS</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:10pt;=
">
<div class=3D"PlainText">On Wed, Nov 8, 2017 at 1:49 AM,&nbsp; &lt;Ken.Wang=
@amd.com&gt; wrote:<br>
&gt; From: Ken Wang &lt;Ken.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
What cases does this fix?&nbsp; I'm guessing VFCT or some other platform<br=
>
method for getting the vbios?<br>
<br>
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
&gt;<br>
&gt; Signed-off-by: Ken Wang &lt;Ken.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 6 ------<br>
&gt;&nbsp; 1 file changed, 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_bios.c<br>
&gt; index c21adf6..057e1ec 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
&gt; @@ -59,12 &#43;59,6 @@ static bool check_atom_bios(uint8_t *bios, size=
_t size)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D bios[0x18] | (bios[0x19]=
 &lt;&lt; 8);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bios[tmp &#43; 0x14] !=3D 0x=
0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;Not an x86 BIOS ROM\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return false;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bios_header_start =3D =
bios[0x48] | (bios[0x49] &lt;&lt; 8);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bios_header_start=
) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;Can't locate bios header\n&quot;);=
<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CY1PR12MB0474FC2F5E1C6649D74BED018C570CY1PR12MB0474namp_--

--===============0268172703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0268172703==--
