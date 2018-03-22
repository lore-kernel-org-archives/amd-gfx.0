From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/6] drm/amd/pp: Lock powerplay when reset pp table
Date: Thu, 22 Mar 2018 13:44:23 +0000
Message-ID: <CY4PR12MB16878FF235D78E9C0A3A722BFBA90@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1521718818-22687-1-git-send-email-Rex.Zhu@amd.com>
 <1521718818-22687-3-git-send-email-Rex.Zhu@amd.com>,
 <CADnq5_PoA0JtqbsepaX0D0RMxTwDi89Uw9DHmvL7tzXduk_EaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1990831494=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PoA0JtqbsepaX0D0RMxTwDi89Uw9DHmvL7tzXduk_EaA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============1990831494==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16878FF235D78E9C0A3A722BFBA90CY4PR12MB1687namp_"

--_000_CY4PR12MB16878FF235D78E9C0A3A722BFBA90CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Please see inline.

Best Regards
Rex
________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, March 22, 2018 9:17 PM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH 3/6] drm/amd/pp: Lock powerplay when reset pp table

On Thu, Mar 22, 2018 at 7:40 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> Change-Id: Ib02cd71593bee9606822a466a56f2d01ac2e04cc
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Please include a commit description.  It's not clear to me what's
happening here.

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 28 +++++++++++++--------=
------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/=
drm/amd/powerplay/amd_powerplay.c
> index 5d7d9ec..1ae4905 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -31,8 +31,6 @@
>  #include "amdgpu.h"
>  #include "hwmgr.h"
>
> -static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_id,
> -               enum amd_pm_state_type *user_state);
>
>  static const struct amd_pm_funcs pp_dpm_funcs;
>
> @@ -146,10 +144,12 @@ static int pp_late_init(void *handle)
>         struct amdgpu_device *adev =3D handle;
>         struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
>
> -       if (hwmgr && hwmgr->pm_en)
> -               pp_dpm_dispatch_tasks(hwmgr,
> +       if (hwmgr && hwmgr->pm_en) {
> +               mutex_lock(&hwmgr->smu_lock);
> +               hwmgr_handle_task(hwmgr,
>                                         AMD_PP_TASK_COMPLETE_INIT, NULL);
> -
> +               mutex_unlock(&hwmgr->smu_lock);
> +       }
>         return 0;
>  }

Rex : use hwmgr_handle_task instand of  pp_dpm_dispatch_tasks. because i th=
ink it is not make sense that call
pp_function in ip_function.

> @@ -620,7 +620,7 @@ static int amd_powerplay_reset(void *handle)
>  static int pp_dpm_set_pp_table(void *handle, const char *buf, size_t siz=
e)
>  {
>         struct pp_hwmgr *hwmgr =3D handle;
> -       int ret =3D 0;
> +       int ret =3D -ENOMEM;
>
>         if (!hwmgr || !hwmgr->pm_en)
>                 return -EINVAL;
> @@ -630,28 +630,28 @@ static int pp_dpm_set_pp_table(void *handle, const =
char *buf, size_t size)
>                 hwmgr->hardcode_pp_table =3D kmemdup(hwmgr->soft_pp_table=
,
>                                                    hwmgr->soft_pp_table_s=
ize,
>                                                    GFP_KERNEL);
> -               if (!hwmgr->hardcode_pp_table) {
> -                       mutex_unlock(&hwmgr->smu_lock);
> -                       return -ENOMEM;
> -               }
> +               if (!hwmgr->hardcode_pp_table)
> +                       goto err;
>         }
>
>         memcpy(hwmgr->hardcode_pp_table, buf, size);
>
>         hwmgr->soft_pp_table =3D hwmgr->hardcode_pp_table;
> -       mutex_unlock(&hwmgr->smu_lock);
>
>         ret =3D amd_powerplay_reset(handle);
>         if (ret)
> -               return ret;
> +               goto err;
>
>         if (hwmgr->hwmgr_func->avfs_control) {
>                 ret =3D hwmgr->hwmgr_func->avfs_control(hwmgr, false);
>                 if (ret)
> -                       return ret;
> +                       goto err;
>         }
> -
> +       mutex_unlock(&hwmgr->smu_lock);
>         return 0;
> +err:
> +       mutex_unlock(&hwmgr->smu_lock);
> +       return ret;
>  }


Rex: unlock mutex until  set pp table complete to avoid other pp functions =
were called simultaneously<http://www.baidu.com/link?url=3D8RpXVOm53HQyZI9h=
-ZIs8Ipio9NEDj98vxJiiM0Wx4hbUUpanLuj7jZHEnm0Javd7_rpySIGVAwaxX_ICV-y2nDz_TZ=
qF8mzUGZT8RPrw2WCcNsGFsoAh9nirArCSm9s>.


>  static int pp_dpm_force_clock_level(void *handle,
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...




--_000_CY4PR12MB16878FF235D78E9C0A3A722BFBA90CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Please see inline.</p>
<br>
Best Regards
<div>Rex<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, March 22, 2018 9:17 PM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 3/6] drm/amd/pp: Lock powerplay when reset pp ta=
ble</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Mar 22, 2018 at 7:40 AM, Rex Zhu &lt;Rex.Z=
hu-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; Change-Id: Ib02cd71593bee9606822a466a56f2d01ac2e04cc<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Please include a commit description.&nbsp; It's not clear to me what's<br>
happening here.<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 28 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--------------<br>
&gt;&nbsp; 1 file changed, 14 insertions(&#43;), 14 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; index 5d7d9ec..1ae4905 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; @@ -31,8 &#43;31,6 @@<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;&nbsp; #include &quot;hwmgr.h&quot;<br>
&gt;<br>
&gt; -static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_=
id,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum amd_pm_state_type *user_state);<br>
&gt;<br>
&gt;&nbsp; static const struct amd_pm_funcs pp_dpm_funcs;<br>
&gt;<br>
&gt; @@ -146,10 &#43;144,12 @@ static int pp_late_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *=
adev =3D handle;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr=
 =3D adev-&gt;powerplay.pp_handle;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr &amp;&amp; hwmgr-&gt;p=
m_en)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pp_dpm_dispatch_tasks(hwmgr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr &amp;&amp; hwmgr-&=
gt;pm_en) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hwmgr_handle_task(hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_PP_TASK_COMPLETE_INIT, NULL);<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
<br>
Rex : use&nbsp;<span style=3D"font-family: Calibri, Helvetica, sans-serif, =
EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoC=
olorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSym=
bols; font-size: 14.6667px;">hwmgr_handle_task instand of &nbsp;<span style=
=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Col=
or Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI =
Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px=
;">pp_dpm_dispatch_tasks.
 because i think it is not make sense that&nbsp;call&nbsp;</span></span></d=
iv>
<div class=3D"PlainText"><span style=3D"font-family: Calibri, Helvetica, sa=
ns-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&qu=
ot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;=
, EmojiSymbols; font-size: 14.6667px;"><span style=3D"font-family: Calibri,=
 Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Seg=
oe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Andro=
id Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">pp_function
 in ip_function.&nbsp;</span></span></div>
<div class=3D"PlainText">&nbsp;<br>
&gt; @@ -620,7 &#43;620,7 @@ static int amd_powerplay_reset(void *handle)<b=
r>
&gt;&nbsp; static int pp_dpm_set_pp_table(void *handle, const char *buf, si=
ze_t size)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr=
 =3D handle;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -ENOMEM;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&=
gt;pm_en)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; @@ -630,28 &#43;630,28 @@ static int pp_dpm_set_pp_table(void *handle,=
 const char *buf, size_t size)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hardcode_pp_table =3D kmemdup(hwmgr-&gt=
;soft_pp_table,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;soft_pp_table_size,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; GFP_KERNEL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!hwmgr-&gt;hardcode_pp_table) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unloc=
k(&amp;hwmgr-&gt;smu_lock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENO=
MEM;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;hardcode_pp_table)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hwmgr-&gt;hardc=
ode_pp_table, buf, size);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;soft_pp_tabl=
e =3D hwmgr-&gt;hardcode_pp_table;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_=
lock);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amd_powerplay_=
reset(handle);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto err;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_fu=
nc-&gt;avfs_control) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-&gt;hwmgr_func-&gt;avfs_control(hwm=
gr, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;=
smu_lock);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;err:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;=
smu_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
<br>
<br>
Rex: unlock mutex until &nbsp;set pp table complete to avoid other pp funct=
ions were called&nbsp;<a target=3D"_blank" hidefocus=3D"true" href=3D"http:=
//www.baidu.com/link?url=3D8RpXVOm53HQyZI9h-ZIs8Ipio9NEDj98vxJiiM0Wx4hbUUpa=
nLuj7jZHEnm0Javd7_rpySIGVAwaxX_ICV-y2nDz_TZqF8mzUGZT8RPrw2WCcNsGFsoAh9nirAr=
CSm9s" style=3D"color: rgb(51, 51, 51); text-decoration: none; font-size: 1=
3px; font-family: arial;" id=3D"LPlnk788007" previewremoved=3D"true">simult=
aneously</a>.</div>
<div class=3D"PlainText"><br>
<br>
&gt;&nbsp; static int pp_dpm_force_clock_level(void *handle,<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk522444" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15217258717160.7688091820158907" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15217258717130.22908408943618563" role=3D"presenta=
tion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255=
, 255); position: relative; overflow: auto; padding-top: 20px; padding-bott=
om: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); bord=
er-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15217258717140.47403618146898485" colspan=3D"2" style=3D=
"vertical-align: top; position: relative; padding: 0px; display: table-cell=
;">
<div id=3D"LPRemovePreviewContainer_15217258717140.3350244639142821"></div>
<div id=3D"LPTitle_15217258717140.3623822377742081" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15217258717150.7344540130325998" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15217258717150.5144749743928732" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15217258717150.4169471652740233" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16878FF235D78E9C0A3A722BFBA90CY4PR12MB1687namp_--

--===============1990831494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1990831494==--
