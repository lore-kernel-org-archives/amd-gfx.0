From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix a typo
Date: Thu, 22 Jun 2017 15:33:54 +0000
Message-ID: <DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0@DM5PR12MB1257.namprd12.prod.outlook.com>
References: <1498099356-31332-1-git-send-email-AlexBin.Xie@amd.com>,
 <5ff65f82-9d15-4606-7e25-e4f75c172aed@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1216592691=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5ff65f82-9d15-4606-7e25-e4f75c172aed-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
Cc: "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>

--===============1216592691==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0DM5PR12MB1257namp_"

--_000_DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0DM5PR12MB1257namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Christian,


In fact, the change from spinlock to atomic is quite painful. When I starte=
d, I thought it was easy but later I found there might be race condition he=
re and there. Now I think the change looks more robust. In kernel source, t=
here are several other drivers used the same trick.


On the other hand, I think the logic itself might be optimized considering =
the locking. But I had spent quite some effort to maintain original logic.


Thanks,

Alex Bin


From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Thursday, June 22, 2017 3:35 AM
To: Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/3] drm/amdgpu: fix a typo

Am 22.06.2017 um 04:42 schrieb Alex Xie:
> Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

With the commit message fixed as Michel suggested patches #1 and #2 are
Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org> as well.

On patch #3 Marek needs to take a look, cause I don't know the logic
behind that.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 7635f38..94c27fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -494,7 +494,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pars=
er *p,
>                                 &e->user_invalidated) && e->user_pages) {
>
>                                /* We acquired a page array, but somebody
> -                              * invalidated it. Free it an try again
> +                              * invalidated it. Free it and try again
>                                 */
>                                release_pages(e->user_pages,
>                                              e->robj->tbo.ttm->num_pages,



--_000_DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0DM5PR12MB1257namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi Christian,</p>
<p><br>
</p>
<p>In fact, the change from spinlock to atomic is quite painful. When I sta=
rted, I thought it was easy but later I found there might be race condition=
 here and there. Now I think the change looks more robust. In kernel source=
, there are several other drivers
 used the same trick.</p>
<p><br>
</p>
<p>On the other hand, I think the logic itself might be optimized consideri=
ng the locking. But I had spent quite some effort to maintain original logi=
c.<br>
</p>
<p><br>
</p>
<p>Thanks,</p>
<p>Alex Bin<br>
</p>
<p><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Christian K=F6nig &=
lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, June 22, 2017 3:35 AM<br>
<b>To:</b> Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amdgpu: fix a typo</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Am 22.06.2017 um 04:42 schrieb Alex Xie:<br>
&gt; Signed-off-by: Alex Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
With the commit message fixed as Michel suggested patches #1 and #2 are <br=
>
Reviewed-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt; as well.<br=
>
<br>
On patch #3 Marek needs to take a look, cause I don't know the logic <br>
behind that.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 &#43;-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_cs.c<br>
&gt; index 7635f38..94c27fc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; @@ -494,7 &#43;494,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_=
cs_parser *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;e-&gt;user_invalidated)=
 &amp;&amp; e-&gt;user_pages) {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We acquired a page array, but s=
omebody<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * invalidated it. Free it an try again<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * invalidated it. Free it and try again<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_pages(e-&gt;user_pages,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e-&gt;robj-&gt;tbo.ttm-&g=
t;num_pages,<br>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0DM5PR12MB1257namp_--

--===============1216592691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1216592691==--
