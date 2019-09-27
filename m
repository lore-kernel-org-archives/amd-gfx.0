From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: initlialize smu->is_apu is false by
 default
Date: Fri, 27 Sep 2019 09:05:00 +0000
Message-ID: <MN2PR12MB329616541147F2B0A31DA62AA2810@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190927065727.22272-1-kevin1.wang@amd.com>,
 <MN2PR12MB3536BA16A58AE0E5E6424063FB810@MN2PR12MB3536.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0121235172=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3536BA16A58AE0E5E6424063FB810-rweVpJHSKTovpq7YPKzLfQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============0121235172==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329616541147F2B0A31DA62AA2810MN2PR12MB3296namp_"

--_000_MN2PR12MB329616541147F2B0A31DA62AA2810MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

this member should be initialize in smu driver.
by default should be set "false".

Best Regards,
Kevin
________________________________
From: Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, September 27, 2019 4:37 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: initlialize smu->is_apu is false by=
 default

Does use the default value (false) for the Boolean variable of is_apu not e=
nough for identifying DGPU?
Anyway, initialize the is_apu during smu early initialize also fine and the=
 patch is

Reviewed-by: Prike Liang <Prike.Liang-5C7GfCeVMHo@public.gmane.org>

Thanks,
Prike
> -----Original Message-----
> From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
> Sent: Friday, September 27, 2019 2:58 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth
> <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>; Wang,
> Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH] drm/amd/powerplay: initlialize smu->is_apu is false by
> default
>
> the member of is_apu in smu_context need to initlialize by default.
>
> set default value is false (dGPU)
>
> for patch:
>        drm/amd/powerplay: bypass dpm_context null pointer check guard
>        for some smu series
>
> Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 7b995b0834eb..6a64f765fcd4 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -712,6 +712,7 @@ static int smu_early_init(void *handle)
>
>        smu->adev =3D adev;
>        smu->pm_enabled =3D !!amdgpu_dpm;
> +     smu->is_apu =3D false;
>        mutex_init(&smu->mutex);
>
>        return smu_set_funcs(adev);
> --
> 2.17.1


--_000_MN2PR12MB329616541147F2B0A31DA62AA2810MN2PR12MB3296namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
this member should be initialize in smu driver.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">by default should be set &quot;false&quot;.<=
/span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, September 27, 2019 4:37 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.=
Feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: initlialize smu-&gt;is_apu i=
s false by default</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Does use the default value (false) for the Boolean=
 variable of is_apu not enough for identifying DGPU?&nbsp;&nbsp;
<br>
Anyway, initialize the is_apu during smu early initialize also fine and the=
 patch is
<br>
<br>
Reviewed-by: Prike Liang &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Thanks,<br>
Prike<br>
&gt; -----Original Message-----<br>
&gt; From: Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Friday, September 27, 2019 2:58 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth<br>
&gt; &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Liang, Prike &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;=
; Wang,<br>
&gt; Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH] drm/amd/powerplay: initlialize smu-&gt;is_apu is fals=
e by<br>
&gt; default<br>
&gt; <br>
&gt; the member of is_apu in smu_context need to initlialize by default.<br=
>
&gt; <br>
&gt; set default value is false (dGPU)<br>
&gt; <br>
&gt; for patch:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: bypass dp=
m_context null pointer check guard<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for some smu series<br>
&gt; <br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 1 &#43;<br>
&gt;&nbsp; 1 file changed, 1 insertion(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; index 7b995b0834eb..6a64f765fcd4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; @@ -712,6 &#43;712,7 @@ static int smu_early_init(void *handle)<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;adev =3D adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;pm_enabled =3D !!amd=
gpu_dpm;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;is_apu =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;mute=
x);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_set_funcs(adev);<=
br>
&gt; --<br>
&gt; 2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB329616541147F2B0A31DA62AA2810MN2PR12MB3296namp_--

--===============0121235172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0121235172==--
