From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: correct data type to avoid overflow
Date: Tue, 26 Mar 2019 12:59:59 +0000
Message-ID: <BN6PR12MB18090D618069382420423226F75F0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190322180630.19021-1-evan.quan@amd.com>
 <20190322180630.19021-2-evan.quan@amd.com>,
 <MN2PR12MB3344F0FCFB363AA00DB5207BE45F0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1216458277=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344F0FCFB363AA00DB5207BE45F0-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1216458277==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18090D618069382420423226F75F0BN6PR12MB1809namp_"

--_000_BN6PR12MB18090D618069382420423226F75F0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Quan, Ev=
an <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, March 26, 2019 6:15 AM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 2/2] drm/amd/powerplay: correct data type to avoid over=
flow

Ping..

> -----Original Message-----
> From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> Sent: 2019=1B$BG/=1B(B3=1B$B7n=1B(B23=1B$BF|=1B(B 2:07
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 2/2] drm/amd/powerplay: correct data type to avoid
> overflow
>
> Avoid left shift overflow.
>
> Change-Id: If03f4f4d440b6d742d8eaa23d0bae6ddd21c01ea
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h
> b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h
> index b90089a4fb6a..195c4ae67058 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h
> @@ -165,7 +165,7 @@
>  #define FEATURE_DS_FCLK_MASK            (1 << FEATURE_DS_FCLK_BIT       =
     )
>  #define FEATURE_DS_MP1CLK_MASK          (1 <<
> FEATURE_DS_MP1CLK_BIT          )
>  #define FEATURE_DS_MP0CLK_MASK          (1 <<
> FEATURE_DS_MP0CLK_BIT          )
> -#define FEATURE_XGMI_MASK               (1 << FEATURE_XGMI_BIT          =
     )
> +#define FEATURE_XGMI_MASK               (1ULL <<
> FEATURE_XGMI_BIT               )
>  #define FEATURE_ECC_MASK                (1ULL << FEATURE_ECC_BIT        =
        )
>
>  #define DPM_OVERRIDE_DISABLE_SOCCLK_PID             0x00000001
> --
> 2.21.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18090D618069382420423226F75F0BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd.=
com&gt;<br>
<b>Sent:</b> Tuesday, March 26, 2019 6:15 AM<br>
<b>To:</b> Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd/powerplay: correct data type to avo=
id overflow</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping..<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: 2019=1B$BG/=1B(B3=1B$B7n=1B(B23=1B$BF|=1B(B 2:07<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH 2/2] drm/amd/powerplay: correct data type to avoid<br>
&gt; overflow<br>
&gt; <br>
&gt; Avoid left shift overflow.<br>
&gt; <br>
&gt; Change-Id: If03f4f4d440b6d742d8eaa23d0bae6ddd21c01ea<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h | 2 &#43;-<b=
r>
&gt;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h<br>
&gt; b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h<br>
&gt; index b90089a4fb6a..195c4ae67058 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h<=
br>
&gt; @@ -165,7 &#43;165,7 @@<br>
&gt;&nbsp; #define FEATURE_DS_FCLK_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; FEATURE_DS_FCLK_BIT&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<br>
&gt;&nbsp; #define FEATURE_DS_MP1CLK_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; (1 &lt;&lt;<br>
&gt; FEATURE_DS_MP1CLK_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; )<br>
&gt;&nbsp; #define FEATURE_DS_MP0CLK_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; (1 &lt;&lt;<br>
&gt; FEATURE_DS_MP0CLK_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; )<br>
&gt; -#define FEATURE_XGMI_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; FEATURE_XGMI_BIT&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; )<br>
&gt; &#43;#define FEATURE_XGMI_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt;<br>
&gt; FEATURE_XGMI_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<br>
&gt;&nbsp; #define FEATURE_ECC_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; FEATURE_E=
CC_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; )<br>
&gt; <br>
&gt;&nbsp; #define DPM_OVERRIDE_DISABLE_SOCCLK_PID&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001<br>
&gt; --<br>
&gt; 2.21.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18090D618069382420423226F75F0BN6PR12MB1809namp_--

--===============1216458277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1216458277==--
