From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/display: make function tables const
Date: Sat, 7 Jul 2018 13:47:55 +0000
Message-ID: <CY4PR12MB16870A93EA293740DA6452D8FB460@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180706122201.34465-1-christian.koenig@amd.com>
 <20180706122201.34465-2-christian.koenig@amd.com>
 <8b1e05c0-3b43-13cd-761c-c7b342d52364@amd.com>
 <CY4PR12MB1687241A8A0FF74C10E93985FB460@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <d4676482-caba-c691-fe95-9f034e8eb1b9@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1368587775=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d4676482-caba-c691-fe95-9f034e8eb1b9-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Lipski, Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>

--===============1368587775==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16870A93EA293740DA6452D8FB460CY4PR12MB1687namp_"

--_000_CY4PR12MB16870A93EA293740DA6452D8FB460CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Christian,


As I am ooo on vocation, Can display team help to check this issue or just =
revert the patch?


I verified on Polaris11 and Vega10. From pp side, this is no difference bet=
ween tonga and polaris10.


Best Regards

Rex



________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Saturday, July 7, 2018 8:30 PM
To: Zhu, Rex; Wentland, Harry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Michel D=E4nz=
er
Cc: Lipski, Mikita
Subject: Re: [PATCH 2/2] drm/amd/display: make function tables const

That's a completely different issue. I'm running into it with just a Tonga =
in my system.

According to my bisecting the problematic patch seems to be:
commit 3fdadbfe1edf4168b2515083af5651c95aeb299d (refs/bisect/bad)
Author: Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org><mailto:rex.zhu-5C7GfCeVMHo@public.gmane.org>
Date:   Thu Jul 5 19:22:50 2018 +0800

    drm/amd/pp: Implement get_performance_level for legacy dgpu

    display can get clock info through this function.
    implement this function for vega10 and old asics.
    from vega12, there is no power state management,
    so need to add new interface to notify display
    the clock info

    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org><mailto:alexander.=
deucher-5C7GfCeVMHo@public.gmane.org>
    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org><mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Please fix and/or revert immediately, cause that is quite a show stopper fo=
r my testing.

Thanks,
Christian.

Am 07.07.2018 um 03:51 schrieb Zhu, Rex:

Add Michel,


seems Michel found a similar issue. Please see the kern.log.


Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Harry Wentland <harry.wentland-urvtwAKJhsc@public.gmane.org=
m><mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, July 6, 2018 9:32 PM
To: Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx@lists.f=
reedesktop.org>
Cc: Lipski, Mikita
Subject: Re: [PATCH 2/2] drm/amd/display: make function tables const

On 2018-07-06 08:22 AM, Christian K=F6nig wrote:
> It is good practice to make global function tables const to avoid
> accidental override.
>
> Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christ=
ian.koenig-5C7GfCeVMHo@public.gmane.org>

Well, this is embarassing. Can't believe I didn't spot this.

Series is
Reviewed-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org><mailto:harry.wentland@=
amd.com>

Now I wonder where else we might have this issue. Time to review all of our=
 other function pointers.

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c         | 6 +++---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h          | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers=
/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> index bae752332a9f..85686d917636 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> @@ -729,7 +729,7 @@ static bool dce_mi_program_surface_flip_and_addr(
>        return true;
>  }
>
> -static struct mem_input_funcs dce_mi_funcs =3D {
> +static const struct mem_input_funcs dce_mi_funcs =3D {
>        .mem_input_program_display_marks =3D dce_mi_program_display_marks,
>        .allocate_mem_input =3D dce_mi_allocate_dmif,
>        .free_mem_input =3D dce_mi_free_dmif,
> @@ -741,7 +741,7 @@ static struct mem_input_funcs dce_mi_funcs =3D {
>        .mem_input_is_flip_pending =3D dce_mi_is_flip_pending
>  };
>
> -static struct mem_input_funcs dce112_mi_funcs =3D {
> +static const struct mem_input_funcs dce112_mi_funcs =3D {
>        .mem_input_program_display_marks =3D dce112_mi_program_display_mar=
ks,
>        .allocate_mem_input =3D dce_mi_allocate_dmif,
>        .free_mem_input =3D dce_mi_free_dmif,
> @@ -753,7 +753,7 @@ static struct mem_input_funcs dce112_mi_funcs =3D {
>        .mem_input_is_flip_pending =3D dce_mi_is_flip_pending
>  };
>
> -static struct mem_input_funcs dce120_mi_funcs =3D {
> +static const struct mem_input_funcs dce120_mi_funcs =3D {
>        .mem_input_program_display_marks =3D dce120_mi_program_display_mar=
ks,
>        .allocate_mem_input =3D dce_mi_allocate_dmif,
>        .free_mem_input =3D dce_mi_free_dmif,
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b=
/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> index 0564c8e31252..9b9fc3d96c07 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> @@ -1011,7 +1011,7 @@ void dce110_free_mem_input_v(
>  {
>  }
>
> -static struct mem_input_funcs dce110_mem_input_v_funcs =3D {
> +static const struct mem_input_funcs dce110_mem_input_v_funcs =3D {
>        .mem_input_program_display_marks =3D
>                        dce_mem_input_v_program_display_marks,
>        .mem_input_program_chroma_display_marks =3D
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h b/drivers/=
gpu/drm/amd/display/dc/inc/hw/mem_input.h
> index 47f1dc5a43b7..da89c2edb07c 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
> @@ -64,7 +64,7 @@ struct stutter_modes {
>  };
>
>  struct mem_input {
> -     struct mem_input_funcs *funcs;
> +     const struct mem_input_funcs *funcs;
>        struct dc_context *ctx;
>        struct dc_plane_address request_address;
>        struct dc_plane_address current_address;
>
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.





--_000_CY4PR12MB16870A93EA293740DA6452D8FB460CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Hi Christian,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<p style=3D"margin-top:0;margin-bottom:0">As I am ooo on vocation, Can disp=
lay team help to check this issue or just revert the patch?&nbsp;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I verified on Polaris11 and Vega1=
0. From pp side,&nbsp;<span style=3D"font-size: 12pt;">this is no differenc=
e between tonga and polaris10.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Saturday, July 7, 2018 8:30 PM<br>
<b>To:</b> Zhu, Rex; Wentland, Harry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Michel=
 D=E4nzer<br>
<b>Cc:</b> Lipski, Mikita<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/display: make function tables const=
</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3DWindows-1252">
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">That's a completely different issue. I'm r=
unning into it with just a Tonga in my system.<br>
<br>
According to my bisecting the problematic patch seems to be:<br>
<blockquote type=3D"cite">commit 3fdadbfe1edf4168b2515083af5651c95aeb299d (=
refs/bisect/bad)<br>
Author: Rex Zhu <a class=3D"x_moz-txt-link-rfc2396E OWAAutoLink" href=3D"ma=
ilto:rex.zhu-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk277154" previewremoved=3D"true">
&lt;rex.zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
Date:&nbsp;&nbsp; Thu Jul 5 19:22:50 2018 &#43;0800<br>
<br>
&nbsp;&nbsp;&nbsp; drm/amd/pp: Implement get_performance_level for legacy d=
gpu<br>
&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; display can get clock info through this function.<br>
&nbsp;&nbsp;&nbsp; implement this function for vega10 and old asics.<br>
&nbsp;&nbsp;&nbsp; from vega12, there is no power state management,<br>
&nbsp;&nbsp;&nbsp; so need to add new interface to notify display<br>
&nbsp;&nbsp;&nbsp; the clock info<br>
&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; Reviewed-by: Alex Deucher <a class=3D"x_moz-txt-link-rfc=
2396E OWAAutoLink" href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk146=
122" previewremoved=3D"true">
&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&nbsp;&nbsp;&nbsp; Signed-off-by: Rex Zhu <a class=3D"x_moz-txt-link-rfc239=
6E OWAAutoLink" href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk302170" previewr=
emoved=3D"true">
&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
</blockquote>
<br>
Please fix and/or revert immediately, cause that is quite a show stopper fo=
r my testing.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 07.07.2018 um 03:51 schrieb Zhu, Rex:<br>
</div>
<blockquote type=3D"cite">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"">
<p style=3D"margin-top:0; margin-bottom:0">Add Michel,</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">seems Michel found a similar iss=
ue. Please see the kern.log.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0; margin-bottom:0">Rex</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Cal=
ibri, sans-serif" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"x_moz-txt-link-rfc2396E OWAAutoLink" href=3D"mailto:amd-gfx-bou=
nces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"LPlnk278165" previewremoved=3D"true">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Harry Wentla=
nd <a class=3D"x_moz-txt-link-rfc2396E OWAAutoLink" href=3D"mailto:harry.we=
ntland-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk85431" previewremoved=3D"true">
&lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Friday, July 6, 2018 9:32 PM<br>
<b>To:</b> Christian K=F6nig; <a class=3D"x_moz-txt-link-abbreviated OWAAut=
oLink" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"LPlnk393200" pre=
viewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Lipski, Mikita<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/display: make function tables const=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On 2018-07-06 08:22 AM, Christian K=F6nig wrote:=
<br>
&gt; It is good practice to make global function tables const to avoid<br>
&gt; accidental override.<br>
&gt; <br>
&gt; Signed-off-by: Christian K=F6nig <a class=3D"x_moz-txt-link-rfc2396E O=
WAAutoLink" href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk802671" pre=
viewremoved=3D"true">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
Well, this is embarassing. Can't believe I didn't spot this.<br>
<br>
Series is<br>
Reviewed-by: Harry Wentland <a class=3D"x_moz-txt-link-rfc2396E OWAAutoLink=
" href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk560847" previewremoved=
=3D"true">
&lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
Now I wonder where else we might have this issue. Time to review all of our=
 other function pointers.<br>
<br>
Harry<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 6 &#43;&#43;&#43;---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c | 2 &=
#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<br>
&gt;&nbsp; 3 files changed, 5 insertions(&#43;), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_mem_input.c<br>
&gt; index bae752332a9f..85686d917636 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c<b=
r>
&gt; @@ -729,7 &#43;729,7 @@ static bool dce_mi_program_surface_flip_and_ad=
dr(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -static struct mem_input_funcs dce_mi_funcs =3D {<br>
&gt; &#43;static const struct mem_input_funcs dce_mi_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_input_program_display_m=
arks =3D dce_mi_program_display_marks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .allocate_mem_input =3D dce_=
mi_allocate_dmif,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .free_mem_input =3D dce_mi_f=
ree_dmif,<br>
&gt; @@ -741,7 &#43;741,7 @@ static struct mem_input_funcs dce_mi_funcs =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_input_is_flip_pending =
=3D dce_mi_is_flip_pending<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; -static struct mem_input_funcs dce112_mi_funcs =3D {<br>
&gt; &#43;static const struct mem_input_funcs dce112_mi_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_input_program_display_m=
arks =3D dce112_mi_program_display_marks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .allocate_mem_input =3D dce_=
mi_allocate_dmif,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .free_mem_input =3D dce_mi_f=
ree_dmif,<br>
&gt; @@ -753,7 &#43;753,7 @@ static struct mem_input_funcs dce112_mi_funcs =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_input_is_flip_pending =
=3D dce_mi_is_flip_pending<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; -static struct mem_input_funcs dce120_mi_funcs =3D {<br>
&gt; &#43;static const struct mem_input_funcs dce120_mi_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_input_program_display_m=
arks =3D dce120_mi_program_display_marks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .allocate_mem_input =3D dce_=
mi_allocate_dmif,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .free_mem_input =3D dce_mi_f=
ree_dmif,<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.=
c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c<br>
&gt; index 0564c8e31252..9b9fc3d96c07 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_inp=
ut_v.c<br>
&gt; @@ -1011,7 &#43;1011,7 @@ void dce110_free_mem_input_v(<br>
&gt;&nbsp; {<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -static struct mem_input_funcs dce110_mem_input_v_funcs =3D {<br>
&gt; &#43;static const struct mem_input_funcs dce110_mem_input_v_funcs =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_input_program_display_m=
arks =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce_mem=
_input_v_program_display_marks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mem_input_program_chroma_di=
splay_marks =3D<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h b/drive=
rs/gpu/drm/amd/display/dc/inc/hw/mem_input.h<br>
&gt; index 47f1dc5a43b7..da89c2edb07c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h<br=
>
&gt; @@ -64,7 &#43;64,7 @@ struct stutter_modes {<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; struct mem_input {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct mem_input_funcs *funcs;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; const struct mem_input_funcs *funcs;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_plane_address requ=
est_address;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_plane_address curr=
ent_address;<br>
&gt; <br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"x_moz-txt-link-abbreviated OWAAutoLink" href=3D"mailto:amd-gfx@=
lists.freedesktop.org" id=3D"LPlnk502422" previewremoved=3D"true">amd-gfx@l=
ists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk757106" class=3D"x_OWAAutoLink" previewremoved=3D"true">https://lists.fr=
eedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15309280054370.5139627939483356" style=3D"margin-bot=
tom:20px; overflow:auto; width:100%; text-indent:0px" contenteditable=3D"fa=
lse">
<table id=3D"LPContainer_15309280054340.885055010626419" cellspacing=3D"0" =
style=3D"width:90%; background-color:rgb(255,255,255); overflow:auto; paddi=
ng-top:20px; padding-bottom:20px; margin-top:20px; border-top:1px dotted rg=
b(200,200,200); border-bottom:1px dotted rgb(200,200,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"x_TextCell_15309280054350.09207141975106015" colspan=3D"2" style=
=3D"vertical-align:top; padding:0px; display:table-cell">
<div id=3D"LPTitle_15309280054360.5322745038679628" style=3D""><a id=3D"LPU=
rlAnchor_15309280054360.6263051860853015" href=3D"https://lists.freedesktop=
.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-decoration:n=
one">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15309280054360.6664147003914225" style=3D"">lists.fre=
edesktop.org</div>
<div id=3D"LPDescription_15309280054370.5356504301440415" style=3D"">Subscr=
ibing to amd-gfx: Subscribe to amd-gfx by filling out the following form. U=
se of all freedesktop.org lists is subject to our Code of Conduct.</div>
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
</blockquote>
<br>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16870A93EA293740DA6452D8FB460CY4PR12MB1687namp_--

--===============1368587775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1368587775==--
