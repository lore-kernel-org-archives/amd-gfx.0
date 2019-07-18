From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: change sysfs pp_dpm_xxx format for
 navi10
Date: Thu, 18 Jul 2019 08:40:58 +0000
Message-ID: <BN8PR12MB3283E46FC5AFEAFE75E04435A2C80@BN8PR12MB3283.namprd12.prod.outlook.com>
References: <20190718080142.26040-1-kevin1.wang@amd.com>,
 <MN2PR12MB3344E71BF98AB9178B871D00E4C80@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0833817387=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344E71BF98AB9178B871D00E4C80-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng,
 Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============0833817387==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB3283E46FC5AFEAFE75E04435A2C80BN8PR12MB3283namp_"

--_000_BN8PR12MB3283E46FC5AFEAFE75E04435A2C80BN8PR12MB3283namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Evan,


1. the other clock type also will check dpm fine grained support.

2. i will change code to v2 to avoid below case

    0: 300M *
    1: 300M
     2: 1800M


Best Regards,

Kevin

________________________________
From: Quan, Evan
Sent: Thursday, July 18, 2019 4:16:22 PM
To: Wang, Kevin(Yang); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Feng, Kenneth; Huang, Ray; Xu, Feifei
Subject: RE: [PATCH] drm/amd/powerplay: change sysfs pp_dpm_xxx format for =
navi10

1. Please commonilzie a new API e.g. smu_is_fine_grained_dpm which can be s=
hared for other clocks in future.
2. if the current clock is same as min or max, the output will be a little =
strange
    0: 300M *
    1: 300M
     2: 1800M
Please check how raven handle this situation.

Regards,
Evan
> -----Original Message-----
> From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
> Sent: Thursday, July 18, 2019 4:02 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Quan, Evan
> <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Xu, Feifei
> <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH] drm/amd/powerplay: change sysfs pp_dpm_xxx format for
> navi10
>
> the navi10 gfxclk (sclk) support fine grained DPM,
> so use level 1 to show current dpm freq in sysfs pp_dpm_xxx
>
> Change-Id: Idae2424f8cc91fe94cebe7f3103e112b4f912fbc
> Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 41 +++++++++++++++++--
> ---
>  1 file changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 895a4e592d5a..ef60b92fef6c 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -632,6 +632,10 @@ static int navi10_print_clk_levels(struct smu_contex=
t
> *smu,
>  {
>        int i, size =3D 0, ret =3D 0;
>        uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
> +     uint32_t freq_values[3] =3D {0};
> +     uint32_t clk_index =3D 0, mark_index =3D 0;
> +     PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> +     DpmDescriptor_t *dpm_desc =3D NULL;
>
>        switch (clk_type) {
>        case SMU_GFXCLK:
> @@ -641,25 +645,46 @@ static int navi10_print_clk_levels(struct
> smu_context *smu,
>        case SMU_UCLK:
>        case SMU_FCLK:
>        case SMU_DCEFCLK:
> +             clk_index =3D smu_clk_get_index(smu, clk_type);
> +             dpm_desc =3D &pptable->DpmDescriptor[clk_index];
> +
>                ret =3D smu_get_current_clk_freq(smu, clk_type, &cur_value=
);
>                if (ret)
>                        return size;
> -             /* 10KHz -> MHz */
> -             cur_value =3D cur_value / 100;
> -
> -             size +=3D sprintf(buf, "current clk: %uMhz\n", cur_value);
>
>                ret =3D smu_get_dpm_level_count(smu, clk_type, &count);
>                if (ret)
>                        return size;
>
> -             for (i =3D 0; i < count; i++) {
> -                     ret =3D smu_get_dpm_freq_by_index(smu, clk_type, i,
> &value);
> +             /* 0 - Fine grained DPM, 1 - Discrete DPM */
> +             if (dpm_desc->SnapToDiscrete =3D=3D 1) {
> +                     /* 10KHz -> MHz */
> +                     cur_value =3D cur_value / 100;
> +                     for (i =3D 0; i < count; i++) {
> +                             ret =3D smu_get_dpm_freq_by_index(smu,
> clk_type, i, &value);
> +                             if (ret)
> +                                     return size;
> +
> +                             size +=3D sprintf(buf + size, "%d: %uMhz %s=
\n",
> i, value,
> +                                             cur_value =3D=3D value ? "*=
" : "");
> +                     }
> +             } else {
> +                     ret =3D smu_get_dpm_freq_by_index(smu, clk_type, 0,
> &freq_values[0]);
> +                     if (ret)
> +                             return size;
> +                     ret =3D smu_get_dpm_freq_by_index(smu, clk_type,
> count - 1, &freq_values[2]);
>                        if (ret)
>                                return size;
>
> -                     size +=3D sprintf(buf + size, "%d: %uMhz %s\n", i, =
value,
> -                                     cur_value =3D=3D value ? "*" : "");
> +                     freq_values[1] =3D cur_value / 100;
> +                     mark_index =3D cur_value =3D=3D freq_values[0] ? 0 =
:
> +                                  cur_value =3D=3D freq_values[2] ? 2 : =
1;
> +
> +                     for (i =3D 0; i < 3; i++) {
> +                             size +=3D sprintf(buf + size, "%d: %uMhz %s=
\n",
> i, freq_values[i],
> +                                             i =3D=3D mark_index ? "*" :=
 "");
> +                     }
> +
>                }
>                break;
>        default:
> --
> 2.22.0


--_000_BN8PR12MB3283E46FC5AFEAFE75E04435A2C80BN8PR12MB3283namp_
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
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;">
<p style=3D"margin-top:0; margin-bottom:0">Hi Evan,</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"font-size:12pt">1=
.</span><span style=3D"font-size:12pt">&nbsp;</span><span style=3D"font-siz=
e:12pt">the other&nbsp;clock type also will check dpm fine grained support.=
</span></p>
<div><span style=3D"font-size:12pt"></span></div>
<p></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"font-size:12pt">2=
. i will change code to v2 to avoid below case<span style=3D"color:rgb(33,3=
3,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px"></span><=
/span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"font-size:12pt"><=
span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Seg=
oe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; f=
ont-size:14.6667px">&nbsp; &nbsp; 0: 300M *</span><br style=3D"color:rgb(33=
,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP=
&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&nbsp;&nbsp;&nbsp; 1: 300M</span><br style=3D"color:rg=
b(33,33,33); font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; font-size:14.6667px">
<span style=3D"color:rgb(33,33,33); font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont; =
font-size:14.6667px">&nbsp;&nbsp;&nbsp;&nbsp; 2: 1800M</span></span></p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Best Regards,</p>
<p style=3D"margin-top:0; margin-bottom:0">Kevin</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Thursday, July 18, 2019 4:16:22 PM<br>
<b>To:</b> Wang, Kevin(Yang); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Feng, Kenneth; Huang, Ray; Xu, Feifei<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: change sysfs pp_dpm_xxx form=
at for navi10</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">1. Please commonilzie a new API e.g. smu_is_fine_g=
rained_dpm which can be shared for other clocks in future.<br>
2. if the current clock is same as min or max, the output will be a little =
strange<br>
&nbsp;&nbsp;&nbsp; 0: 300M *<br>
&nbsp;&nbsp;&nbsp; 1: 300M<br>
&nbsp;&nbsp;&nbsp;&nbsp; 2: 1800M<br>
Please check how raven handle this situation.<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Thursday, July 18, 2019 4:02 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan<br>
&gt; &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Xu, F=
eifei<br>
&gt; &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
&gt; Subject: [PATCH] drm/amd/powerplay: change sysfs pp_dpm_xxx format for=
<br>
&gt; navi10<br>
&gt; <br>
&gt; the navi10 gfxclk (sclk) support fine grained DPM,<br>
&gt; so use level 1 to show current dpm freq in sysfs pp_dpm_xxx<br>
&gt; <br>
&gt; Change-Id: Idae2424f8cc91fe94cebe7f3103e112b4f912fbc<br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 41 &#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&gt; ---<br>
&gt;&nbsp; 1 file changed, 33 insertions(&#43;), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; index 895a4e592d5a..ef60b92fef6c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; @@ -632,6 &#43;632,10 @@ static int navi10_print_clk_levels(struct smu=
_context<br>
&gt; *smu,<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, size =3D 0, ret =3D 0=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cur_value =3D 0, va=
lue =3D 0, count =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t freq_values[3] =3D {0};<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_index =3D 0, mark_index =3D=
 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D smu-&gt;smu_table=
.driver_pptable;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; DpmDescriptor_t *dpm_desc =3D NULL;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (clk_type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_GFXCLK:<br>
&gt; @@ -641,25 &#43;645,46 @@ static int navi10_print_clk_levels(struct<br=
>
&gt; smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_UCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_FCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_DCEFCLK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; clk_index =3D smu_clk_get_index(smu, clk_type);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; dpm_desc =3D &amp;pptable-&gt;DpmDescriptor[clk_index];<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D smu_get_current_clk_freq(smu, clk_type, &amp;cu=
r_value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
size;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* 10KHz -&gt; MHz */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cur_value =3D cur_value / 100;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; size &#43;=3D sprintf(buf, &quot;current clk: %uMhz\n&quot;, cur_value)=
;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D smu_get_dpm_level_count(smu, clk_type, &amp;cou=
nt);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
size;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D 0; i &lt; count; i&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_dpm_fre=
q_by_index(smu, clk_type, i,<br>
&gt; &amp;value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* 0 - Fine grained DPM, 1 - Discrete DPM */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (dpm_desc-&gt;SnapToDiscrete =3D=3D 1) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 10KHz -&gt; MHz =
*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_value =3D cur_v=
alue / 100;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt=
; count; i&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_dpm_freq_by_index(smu,<br>
&gt; clk_type, i, &amp;value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return size;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%d=
: %uMhz %s\n&quot;,<br>
&gt; i, value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_value =3D=3D value ? =
&quot;*&quot; : &quot;&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_dpm=
_freq_by_index(smu, clk_type, 0,<br>
&gt; &amp;freq_values[0]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_dpm=
_freq_by_index(smu, clk_type,<br>
&gt; count - 1, &amp;freq_values[2]);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret=
)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(b=
uf &#43; size, &quot;%d: %uMhz %s\n&quot;, i, value,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu=
r_value =3D=3D value ? &quot;*&quot; : &quot;&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D =
cur_value / 100;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mark_index =3D cur_=
value =3D=3D freq_values[0] ? 0 :<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_value =3D=3D=
 freq_values[2] ? 2 : 1;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt=
; 3; i&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%d=
: %uMhz %s\n&quot;,<br>
&gt; i, freq_values[i],<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D=3D mark_index ? &qu=
ot;*&quot; : &quot;&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; --<br>
&gt; 2.22.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN8PR12MB3283E46FC5AFEAFE75E04435A2C80BN8PR12MB3283namp_--

--===============0833817387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0833817387==--
