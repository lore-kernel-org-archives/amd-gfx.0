From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Remove double lock from gfx v6
Date: Wed, 7 Sep 2016 14:25:52 +0000
Message-ID: <CY4PR12MB1768F120EDCAA8B6FA762AFBF7F80@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20160907120739.17385-1-tom.stdenis@amd.com>,
 <0b05a9be-a9de-bcf9-5b39-772dbbec5424@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1022016863=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0b05a9be-a9de-bcf9-5b39-772dbbec5424-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1022016863==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768F120EDCAA8B6FA762AFBF7F80CY4PR12MB1768namp_"

--_000_CY4PR12MB1768F120EDCAA8B6FA762AFBF7F80CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks, I'll push this today after I get a RB/ACK/NAK on the last two clean=
ups


https://lists.freedesktop.org/archives/amd-gfx/2016-September/002039.html


(note: I changed one of the dev_warn to dev_err to match the original messa=
ge type)


and


https://lists.freedesktop.org/archives/amd-gfx/2016-September/002042.html


Tom


________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Wednesday, September 7, 2016 08:33
To: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: Re: [PATCH] drm/amd/amdgpu: Remove double lock from gfx v6

Am 07.09.2016 um 14:07 schrieb Tom St Denis:
> The function gfx_v6_0_get_cu_info() was taking the
> grbm_idx_mutex which was then taken by a dependent
> function gfx_v6_0_get_cu_active_bitmap().
>
> This patch removes the select from the parent function
> to avoid the double lock.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index a6b76170b9c5..a1484b8f7eb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -3193,13 +3193,11 @@ static void gfx_v6_0_get_cu_info(struct amdgpu_de=
vice *adev)
>
>        memset(cu_info, 0, sizeof(*cu_info));
>
> -     mutex_lock(&adev->grbm_idx_mutex);
>        for (i =3D 0; i < adev->gfx.config.max_shader_engines; i++) {
>                for (j =3D 0; j < adev->gfx.config.max_sh_per_se; j++) {
>                        mask =3D 1;
>                        ao_bitmap =3D 0;
>                        counter =3D 0;
> -                     gfx_v6_0_select_se_sh(adev, i, j, 0xffffffff);
>                        bitmap =3D gfx_v6_0_get_cu_active_bitmap(adev, i, =
j);
>                        cu_info->bitmap[i][j] =3D bitmap;
>
> @@ -3215,8 +3213,6 @@ static void gfx_v6_0_get_cu_info(struct amdgpu_devi=
ce *adev)
>                        ao_cu_mask |=3D (ao_bitmap << (i * 16 + j * 8));
>                }
>        }
> -     gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> -     mutex_unlock(&adev->grbm_idx_mutex);
>
>        cu_info->number =3D active_cu_number;
>        cu_info->ao_cu_mask =3D ao_cu_mask;



--_000_CY4PR12MB1768F120EDCAA8B6FA762AFBF7F80CY4PR12MB1768namp_
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
<p>Thanks, I'll push this today after I get a RB/ACK/NAK on the last two cl=
eanups</p>
<p><br>
</p>
<p><a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2016-September=
/002039.html" class=3D"OWAAutoLink" id=3D"LPlnk756299">https://lists.freede=
sktop.org/archives/amd-gfx/2016-September/002039.html</a><br>
</p>
<p><br>
</p>
<p>(note: I changed one of the dev_warn to dev_err to match the original me=
ssage type)</p>
<p><br>
</p>
<p>and</p>
<p><br>
</p>
<p><a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2016-September=
/002042.html" class=3D"OWAAutoLink" id=3D"LPlnk212711">https://lists.freede=
sktop.org/archives/amd-gfx/2016-September/002042.html</a><br>
</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &=
lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, September 7, 2016 08:33<br>
<b>To:</b> Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Remove double lock from gfx v6<=
/font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Am 07.09.2016 um 14:07 schrieb Tom St Denis:<br>
&gt; The function gfx_v6_0_get_cu_info() was taking the<br>
&gt; grbm_idx_mutex which was then taken by a dependent<br>
&gt; function gfx_v6_0_get_cu_active_bitmap().<br>
&gt;<br>
&gt; This patch removes the select from the parent function<br>
&gt; to avoid the double lock.<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Reviewed-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 4 ----<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v6_0.c<br>
&gt; index a6b76170b9c5..a1484b8f7eb2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&gt; @@ -3193,13 &#43;3193,11 @@ static void gfx_v6_0_get_cu_info(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(cu_info, 0, sizeof(*c=
u_info));<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;grbm_idx_mutex);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&g=
t;gfx.config.max_shader_engines; i&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;gfx.config.max_sh_per_se;=
 j&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask =
=3D 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ao_bitm=
ap =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; counter=
 =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v6_0_select_se_sh(a=
dev, i, j, 0xffffffff);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap =
=3D gfx_v6_0_get_cu_active_bitmap(adev, i, j);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu_info=
-&gt;bitmap[i][j] =3D bitmap;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -3215,8 &#43;3213,6 @@ static void gfx_v6_0_get_cu_info(struct amdg=
pu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ao_cu_m=
ask |=3D (ao_bitmap &lt;&lt; (i * 16 &#43; j * 8));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; gfx_v6_0_select_se_sh(adev, 0xffffffff, 0xff=
ffffff, 0xffffffff);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<=
br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu_info-&gt;number =3D activ=
e_cu_number;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu_info-&gt;ao_cu_mask =3D a=
o_cu_mask;<br>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1768F120EDCAA8B6FA762AFBF7F80CY4PR12MB1768namp_--

--===============1022016863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1022016863==--
