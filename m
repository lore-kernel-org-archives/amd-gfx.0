From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: fix copy error in powerplay.
Date: Fri, 9 Jun 2017 03:26:22 +0000
Message-ID: <CY4PR12MB1687375F92DE73DAB39BEAA0FBCE0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1496908250-25003-1-git-send-email-Rex.Zhu@amd.com>,
 <CY4PR17MB14001A40EC08FFA206779E5BC8C90@CY4PR17MB1400.namprd17.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1277770770=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR17MB14001A40EC08FFA206779E5BC8C90-wNFeZrXzOlam8K7ZFAZNYX+GY4YGzQ7gvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: William Lewis <minutemaidpark-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1277770770==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687375F92DE73DAB39BEAA0FBCE0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687375F92DE73DAB39BEAA0FBCE0CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>>s/diable/disable/

>>Also, why not make "Failed" lower-case at the same time?


Of course. thanks.


Best Regards

Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of William =
Lewis <minutemaidpark-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Sent: Thursday, June 8, 2017 8:47:58 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/powerplay: fix copy error in powerplay.



On 06/08/2017 02:50 AM, Rex Zhu wrote:
> should disable led dpm feature when stop dpm.
>
> Change-Id: I9d78459ff2467d2eba0b26d9696138f7eba484a0
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index 9338aca..b6df00c 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -2702,9 +2702,9 @@ static int vega10_stop_dpm(struct pp_hwmgr *hwmgr, =
uint32_t bitmap)
>
>        if(data->smu_features[GNLD_LED_DISPLAY].supported =3D=3D true){
>                PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr->smu=
mgr,
> -                             true, data->smu_features[GNLD_LED_DISPLAY].=
smu_feature_bitmap),
> -             "Attempt to Enable LED DPM feature Failed!", return -EINVAL=
);
> -             data->smu_features[GNLD_LED_DISPLAY].enabled =3D true;
> +                             false, data->smu_features[GNLD_LED_DISPLAY]=
.smu_feature_bitmap),
> +             "Attempt to diable LED DPM feature Failed!", return -EINVAL=
);

s/diable/disable/

Also, why not make "Failed" lower-case at the same time?

> +             data->smu_features[GNLD_LED_DISPLAY].enabled =3D false;
>        }
>
>        for (i =3D 0; i < GNLD_DPM_MAX; i++) {

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1687375F92DE73DAB39BEAA0FBCE0CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p><font size=3D"2"><span style=3D"font-size:10pt">&gt;&gt;s/diable/disable=
/<br>
<br>
&gt;&gt;Also, why not make &quot;Failed&quot; lower-case at the same time?<=
/span></font></p>
<p><br>
</p>
<p>Of course. thanks.</p>
<p><br>
</p>
<p>Best Regards</p>
<p>Rex<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of William Lewis &lt;minutemai=
dpark-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, June 8, 2017 8:47:58 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: fix copy error in powerplay.=
</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText"><br>
<br>
On 06/08/2017 02:50 AM, Rex Zhu wrote:<br>
&gt; should disable led dpm feature when stop dpm.<br>
&gt;<br>
&gt; Change-Id: I9d78459ff2467d2eba0b26d9696138f7eba484a0<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 6 &#4=
3;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; 1 file changed, 3 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index 9338aca..b6df00c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -2702,9 &#43;2702,9 @@ static int vega10_stop_dpm(struct pp_hwmgr *=
hwmgr, uint32_t bitmap)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(data-&gt;smu_features[GNL=
D_LED_DISPLAY].supported =3D=3D true){<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr-&=
gt;smumgr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; true, data-&gt;smu_features[GNLD_LED_DISPLAY].smu_=
feature_bitmap),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &quot;Attempt to Enable LED DPM feature Failed!&quot;, return -EINVAL);=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data-&gt;smu_features[GNLD_LED_DISPLAY].enabled =3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; false, data-&gt;smu_features[GNLD_LED_DISPLAY]=
.smu_feature_bitmap),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &quot;Attempt to diable LED DPM feature Failed!&quot;, return -EINV=
AL);<br>
<br>
s/diable/disable/<br>
<br>
Also, why not make &quot;Failed&quot; lower-case at the same time?<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-&gt;smu_features[GNLD_LED_DISPLAY].enabled =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; GNLD_DP=
M_MAX; i&#43;&#43;) {<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB1687375F92DE73DAB39BEAA0FBCE0CY4PR12MB1687namp_--

--===============1277770770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1277770770==--
