From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 7/7] drm/amd/amdgpu: Comment out currently unused SI DPM
 struct
Date: Wed, 7 Sep 2016 14:49:51 +0000
Message-ID: <CY4PR12MB1768FBB1CC469E0C27182B9FF7F80@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20160906161844.21370-1-tom.stdenis@amd.com>
 <20160906161844.21370-8-tom.stdenis@amd.com>,
 <MWHPR12MB16946A5F5069CA4CAE4ABA7BF7F80@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0911552730=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB16946A5F5069CA4CAE4ABA7BF7F80-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0911552730==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768FBB1CC469E0C27182B9FF7F80CY4PR12MB1768namp_"

--_000_CY4PR12MB1768FBB1CC469E0C27182B9FF7F80CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


Would love to but unfortunately I don't have a tahiti_le (or any SI) part t=
o test it on.


Cheers,

Tom


________________________________
From: Deucher, Alexander
Sent: Wednesday, September 7, 2016 10:45
To: 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: RE: [PATCH 7/7] drm/amd/amdgpu: Comment out currently unused SI DP=
M struct

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Tom St Denis
> Sent: Tuesday, September 06, 2016 12:19 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: StDenis, Tom
> Subject: [PATCH 7/7] drm/amd/amdgpu: Comment out currently unused SI
> DPM struct
>
> The tahiti_le structure is not currently used.  Comment it out
> to avoid warnings.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

Might be worth assigning this on the Tahiti LE boards to see if it helps wi=
th the Tahiti LE bug.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/si_dpm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index 7b9debefd64a..92a041755e8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -340,6 +340,7 @@ static const struct si_dte_data dte_data_tahiti =3D
>        false
>  };
>
> +#if 0
>  static const struct si_dte_data dte_data_tahiti_le =3D
>  {
>        { 0x1E8480, 0x7A1200, 0x2160EC0, 0x3938700, 0 },
> @@ -357,6 +358,7 @@ static const struct si_dte_data dte_data_tahiti_le =
=3D
>        85,
>        true
>  };
> +#endif
>
>  static const struct si_dte_data dte_data_tahiti_pro =3D
>  {
> --
> 2.9.3
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1768FBB1CC469E0C27182B9FF7F80CY4PR12MB1768namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi Alex,</p>
<p><br>
</p>
<p>Would love to but unfortunately I don't have a tahiti_le (or any SI) par=
t to test it on.</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<=
br>
<b>Sent:</b> Wednesday, September 7, 2016 10:45<br>
<b>To:</b> 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> RE: [PATCH 7/7] drm/amd/amdgpu: Comment out currently unuse=
d SI DPM struct</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Tom St Denis<br>
&gt; Sent: Tuesday, September 06, 2016 12:19 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: StDenis, Tom<br>
&gt; Subject: [PATCH 7/7] drm/amd/amdgpu: Comment out currently unused SI<b=
r>
&gt; DPM struct<br>
&gt; <br>
&gt; The tahiti_le structure is not currently used.&nbsp; Comment it out<br=
>
&gt; to avoid warnings.<br>
&gt; <br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Might be worth assigning this on the Tahiti LE boards to see if it helps wi=
th the Tahiti LE bug.<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/si_dpm.c | 2 &#43;&#43;<br>
&gt;&nbsp; 1 file changed, 2 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/si_dpm.c<br>
&gt; index 7b9debefd64a..92a041755e8e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/si_dpm.c<br>
&gt; @@ -340,6 &#43;340,7 @@ static const struct si_dte_data dte_data_tahit=
i =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false<br>
&gt;&nbsp; };<br>
&gt; <br>
&gt; &#43;#if 0<br>
&gt;&nbsp; static const struct si_dte_data dte_data_tahiti_le =3D<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x1E8480, 0x7A1200, 0x2160=
EC0, 0x3938700, 0 },<br>
&gt; @@ -357,6 &#43;358,7 @@ static const struct si_dte_data dte_data_tahit=
i_le =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true<br>
&gt;&nbsp; };<br>
&gt; &#43;#endif<br>
&gt; <br>
&gt;&nbsp; static const struct si_dte_data dte_data_tahiti_pro =3D<br>
&gt;&nbsp; {<br>
&gt; --<br>
&gt; 2.9.3<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1768FBB1CC469E0C27182B9FF7F80CY4PR12MB1768namp_--

--===============0911552730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0911552730==--
