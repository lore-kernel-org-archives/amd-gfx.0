From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
Subject: Re: [PATCH][drm-next] drm/amd/powerplay: fix off-by-one upper bounds
 limit checks
Date: Fri, 2 Aug 2019 01:45:49 +0000
Message-ID: <BN8PR12MB3283A2B485985BF91F21760CA2D90@BN8PR12MB3283.namprd12.prod.outlook.com>
References: <20190801111541.13627-1-colin.king@canonical.com>,
 <CADnq5_OqLtvBWXJhT9c=kxK3HeXSEDdfYS1N7Dh68kbiiLk5+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0266235005=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_OqLtvBWXJhT9c=kxK3HeXSEDdfYS1N7Dh68kbiiLk5+w@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>, Colin King <colin.king@canonical.com>
Cc: David Airlie <airlied@linux.ie>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, Rex Zhu <rex.zhu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0266235005==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB3283A2B485985BF91F21760CA2D90BN8PR12MB3283namp_"

--_000_BN8PR12MB3283A2B485985BF91F21760CA2D90BN8PR12MB3283namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Friday, August 2, 2019 2:53 AM
To: Colin King <colin.king@canonical.com>
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Rex Zhu <rex.zhu@amd.com>; Qua=
n, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>=
; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <Davi=
d1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ff=
wll.ch>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Maling list - DRI de=
velopers <dri-devel@lists.freedesktop.org>; kernel-janitors@vger.kernel.org=
 <kernel-janitors@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][drm-next] drm/amd/powerplay: fix off-by-one upper boun=
ds limit checks

On Thu, Aug 1, 2019 at 7:15 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are two occurrances of off-by-one upper bound checking of indexes
> causing potential out-of-bounds array reads. Fix these.
>
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: cb33363d0e85 ("drm/amd/powerplay: add smu feature name support")
> Fixes: 6b294793e384 ("drm/amd/powerplay: add smu message name support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm=
/amd/powerplay/amdgpu_smu.c
> index d029a99e600e..b64113740eb5 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -38,7 +38,7 @@ static const char* __smu_message_names[] =3D {
>
>  const char *smu_get_message_name(struct smu_context *smu, enum smu_messa=
ge_type type)
>  {
> -       if (type < 0 || type > SMU_MSG_MAX_COUNT)
> +       if (type < 0 || type >=3D SMU_MSG_MAX_COUNT)
>                 return "unknown smu message";
>         return __smu_message_names[type];
>  }
> @@ -51,7 +51,7 @@ static const char* __smu_feature_names[] =3D {
>
>  const char *smu_get_feature_name(struct smu_context *smu, enum smu_featu=
re_mask feature)
>  {
> -       if (feature < 0 || feature > SMU_FEATURE_COUNT)
> +       if (feature < 0 || feature >=3D SMU_FEATURE_COUNT)
>                 return "unknown smu feature";
>         return __smu_feature_names[feature];
>  }
[kevin]:
thanks correct it.
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
BR
Kevin
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--_000_BN8PR12MB3283A2B485985BF91F21760CA2D90BN8PR12MB3283namp_
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
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Friday, August 2, 2019 2:53 AM<br>
<b>To:</b> Colin King &lt;colin.king@canonical.com&gt;<br>
<b>Cc:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Rex Zhu &lt;rex.z=
hu@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd=
.com&gt;; Zhou, David(ChunMing) &lt;David1.Zhou@amd.com&gt;; David Airlie
 &lt;airlied@linux.ie&gt;; Daniel Vetter &lt;daniel@ffwll.ch&gt;; amd-gfx l=
ist &lt;amd-gfx@lists.freedesktop.org&gt;; Maling list - DRI developers &lt=
;dri-devel@lists.freedesktop.org&gt;; kernel-janitors@vger.kernel.org &lt;k=
ernel-janitors@vger.kernel.org&gt;; LKML &lt;linux-kernel@vger.kernel.org&g=
t;<br>
<b>Subject:</b> Re: [PATCH][drm-next] drm/amd/powerplay: fix off-by-one upp=
er bounds limit checks</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On Thu, Aug 1, 2019 at 7:15 AM Colin King &lt;coli=
n.king@canonical.com&gt; wrote:<br>
&gt;<br>
&gt; From: Colin Ian King &lt;colin.king@canonical.com&gt;<br>
&gt;<br>
&gt; There are two occurrances of off-by-one upper bound checking of indexe=
s<br>
&gt; causing potential out-of-bounds array reads. Fix these.<br>
&gt;<br>
&gt; Addresses-Coverity: (&quot;Out-of-bounds read&quot;)<br>
&gt; Fixes: cb33363d0e85 (&quot;drm/amd/powerplay: add smu feature name sup=
port&quot;)<br>
&gt; Fixes: 6b294793e384 (&quot;drm/amd/powerplay: add smu message name sup=
port&quot;)<br>
&gt; Signed-off-by: Colin Ian King &lt;colin.king@canonical.com&gt;<br>
<br>
Applied.&nbsp; thanks!<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 &#43;&#43;--<br>
&gt;&nbsp; 1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/=
drm/amd/powerplay/amdgpu_smu.c<br>
&gt; index d029a99e600e..b64113740eb5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; @@ -38,7 &#43;38,7 @@ static const char* __smu_message_names[] =3D {<b=
r>
&gt;<br>
&gt;&nbsp; const char *smu_get_message_name(struct smu_context *smu, enum s=
mu_message_type type)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type &lt; 0 || type &gt; SMU=
_MSG_MAX_COUNT)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type &lt; 0 || type &gt;=
=3D SMU_MSG_MAX_COUNT)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;unknown smu message&quot;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return __smu_message_n=
ames[type];<br>
&gt;&nbsp; }<br>
&gt; @@ -51,7 &#43;51,7 @@ static const char* __smu_feature_names[] =3D {<b=
r>
&gt;<br>
&gt;&nbsp; const char *smu_get_feature_name(struct smu_context *smu, enum s=
mu_feature_mask feature)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (feature &lt; 0 || feature &g=
t; SMU_FEATURE_COUNT)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (feature &lt; 0 || featur=
e &gt;=3D SMU_FEATURE_COUNT)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;unknown smu feature&quot;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return __smu_feature_n=
ames[feature];<br>
&gt;&nbsp; }</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">thanks correct it.<br>
</div>
<div class=3D"PlainText">Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt=
;</div>
<div class=3D"PlainText">BR<br>
</div>
<div class=3D"PlainText">Kevin</div>
<div class=3D"PlainText">&gt; --<br>
&gt; 2.20.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; dri-devel mailing list<br>
&gt; dri-devel@lists.freedesktop.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel">h=
ttps://lists.freedesktop.org/mailman/listinfo/dri-devel</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN8PR12MB3283A2B485985BF91F21760CA2D90BN8PR12MB3283namp_--

--===============0266235005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0266235005==--
