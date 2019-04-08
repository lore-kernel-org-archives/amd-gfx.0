From: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu: Make default ras error type to none
Date: Mon, 8 Apr 2019 14:19:02 +0000
Message-ID: <SN6PR12MB28003555AFCF1943B10B2D04872C0@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <SN6PR12MB28008223E7F115D82C363B1D872C0@SN6PR12MB2800.namprd12.prod.outlook.com>,
 <MN2PR12MB3344154AD2705C8DE945FB8AE42C0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0870686486=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344154AD2705C8DE945FB8AE42C0-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Quan,
 Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0870686486==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB28003555AFCF1943B10B2D04872C0SN6PR12MB2800namp_"

--_000_SN6PR12MB28003555AFCF1943B10B2D04872C0SN6PR12MB2800namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Wait, this patchset intriduced a bug. will fix that later.

Currently, all ras ta cmds must be performed with corresponding ras objects=
.
So if vbios enable ras for us, we need set up the ras objects as soon as po=
ssible, otherwise the status does not match. This patch moves the ras_enabl=
e_all who set up the ras objects after all IP's initialization. So it is im=
possible to perform a ras ta disable cmd as there is no object.

there are 2 scenarios,
1) ras is enabled by vbios.
case enable:
enable_on_boot will bypass psp, just set up object.
case disable:
enable_on_boot need set up object first, then perform a ras ta disable cmd =
and update the object.

2) ras is disabled when boot by default.
case enable:
enable_on_boot will make a ras ta enable cmd and set up object.
case disable:
do nothing.

This patch only handle #1 case enable and #2 case enable and case disable. =
Will fix #1 case enable later.

Evan, the question you raised is good.
Performing a ras ta disable cmd without a ras object makes the code logic i=
ncorrect. looks a little weird, but code is simple.
________________________________
From: Quan, Evan
Sent: Monday, April 8, 2019 8:17:44 PM
To: Pan, Xinhui; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: RE: [PATCH 1/5] drm/amdgpu: Make default ras error type to none

This series is fine. Please feel free to add my RB.
But it reminds me another thing: it's a little weird to enable all RAS feat=
ures and disable those not needed afterwards.
Is it possible to only enable those which are really needed(no disablement =
will be needed then)?

Regards,
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Pan,
> Xinhui
> Sent: 2019=1B$BG/=1B(B4=1B$B7n=1B(B8=1B$BF|=1B(B 15:08
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 1/5] drm/amdgpu: Make default ras error type to none
>
> Unless IP has implemented its own ras, use ERROR_NONE as the default type=
.
>
> Signed-off-by: xinhui pan <xinhui.pan-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 +++++++++++++++------
> ---
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 2b7a420d5a1f..6cbf1d34c5b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -664,11 +664,13 @@ static int amdgpu_ras_enable_all_features(struct
> amdgpu_device *adev,
>        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>        int ras_block_count =3D AMDGPU_RAS_BLOCK_COUNT;
>        int i;
> +     const enum amdgpu_ras_error_type default_ras_type =3D
> +             AMDGPU_RAS_ERROR__NONE;
>
>        for (i =3D 0; i < ras_block_count; i++) {
>                struct ras_common_if head =3D {
>                        .block =3D i,
> -                     .type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
> +                     .type =3D default_ras_type,
>                        .sub_block_index =3D 0,
>                };
>                strcpy(head.name, ras_block_str(i));
> @@ -1474,9 +1476,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>
>        amdgpu_ras_mask &=3D AMDGPU_RAS_BLOCK_MASK;
>
> -     if (con->flags & AMDGPU_RAS_FLAG_INIT_BY_VBIOS)
> -             amdgpu_ras_enable_all_features(adev, 1);
> -
>        if (amdgpu_ras_fs_init(adev))
>                goto fs_out;
>
> @@ -1504,18 +1503,25 @@ void amdgpu_ras_post_init(struct
> amdgpu_device *adev)
>        if (!con)
>                return;
>
> -     /* We enable ras on all hw_supported block, but as boot parameter
> might
> -      * disable some of them and one or more IP has not implemented
> yet.
> -      * So we disable them on behalf.
> -      */
>        if (con->flags & AMDGPU_RAS_FLAG_INIT_BY_VBIOS) {
> +             /* Set up all other IPs which are not implemented. There is=
 a
> +              * tricky thing that IP's actual ras error type should be
> +              * MULTI_UNCORRECTABLE, but as driver does not handle it,
> so
> +              * ERROR_NONE make sense anyway.
> +              */
> +             amdgpu_ras_enable_all_features(adev, 1);
> +
> +             /* We enable ras on all hw_supported block, but as boot
> +              * parameter might disable some of them and one or more IP
> has
> +              * not implemented yet. So we disable them on behalf.
> +              */
>                list_for_each_entry_safe(obj, tmp, &con->head, node) {
>                        if (!amdgpu_ras_is_supported(adev, obj-
> >head.block)) {
>                                amdgpu_ras_feature_enable(adev, &obj-
> >head, 0);
>                                /* there should be no any reference. */
>                                WARN_ON(alive_obj(obj));
>                        }
> -             };
> +             }
>        }
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_SN6PR12MB28003555AFCF1943B10B2D04872C0SN6PR12MB2800namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Wait, this patchset intriduced a bug. will fix that later.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Currently, all ras ta cmds must be performed with corresponding ras objects=
.<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
So if vbios enable ras for us, we need set up the ras objects as soon as po=
ssible, otherwise the status does not match. This patch moves the ras_enabl=
e_all who set up the ras objects after all IP's initialization. So it is im=
possible to perform a ras ta disable
 cmd as there is no object.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
there are 2 scenarios,<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
1) ras is enabled by vbios. <br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
case enable:<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
enable_on_boot will bypass psp, just set up object.<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
case disable:<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
enable_on_boot need set up object first, then perform a ras ta disable cmd =
and update the object.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
2) ras is disabled when boot by default.<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
case enable:<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
enable_on_boot will make a ras ta enable cmd and set up object.<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
case disable:<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
do nothing.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
This patch only handle #1 case enable and #2 case enable and case disable. =
Will fix #1 case enable later.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Evan, the question you raised is good.<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Performing a ras ta disable cmd without a ras object makes the code logic i=
ncorrect. looks a little weird, but code is simple.</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Monday, April 8, 2019 8:17:44 PM<br>
<b>To:</b> Pan, Xinhui; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> RE: [PATCH 1/5] drm/amdgpu: Make default ras error type to =
none</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">This series is fine. Please feel free to add my RB=
.<br>
But it reminds me another thing: it's a little weird to enable all RAS feat=
ures and disable those not needed afterwards.<br>
Is it possible to only enable those which are really needed(no disablement =
will be needed then)?<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of Pan,<br>
&gt; Xinhui<br>
&gt; Sent: 2019=1B$BG/=1B(B4=1B$B7n=1B(B8=1B$BF|=1B(B 15:08<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH 1/5] drm/amdgpu: Make default ras error type to none<b=
r>
&gt; <br>
&gt; Unless IP has implemented its own ras, use ERROR_NONE as the default t=
ype.<br>
&gt; <br>
&gt; Signed-off-by: xinhui pan &lt;xinhui.pan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 24 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------<br>
&gt; ---<br>
&gt;&nbsp; 1 file changed, 15 insertions(&#43;), 9 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; index 2b7a420d5a1f..6cbf1d34c5b4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; @@ -664,11 &#43;664,13 @@ static int amdgpu_ras_enable_all_features(st=
ruct<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D a=
mdgpu_ras_get_context(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ras_block_count =3D AMDG=
PU_RAS_BLOCK_COUNT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; const enum amdgpu_ras_error_type default=
_ras_type =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; AMDGPU_RAS_ERROR__NONE;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ras_blo=
ck_count; i&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct ras_common_if head =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block =
=3D i,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .type =3D<br>
&gt; AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .type =3D default_r=
as_type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sub_bl=
ock_index =3D 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; strcpy(head.name, ras_block_str(i));<br>
&gt; @@ -1474,9 &#43;1476,6 @@ int amdgpu_ras_init(struct amdgpu_device *ad=
ev)<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_mask &amp;=3D AMD=
GPU_RAS_BLOCK_MASK;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (con-&gt;flags &amp; AMDGPU_RAS_FLAG_INIT=
_BY_VBIOS)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_ras_enable_all_features(adev, 1);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_fs_init(adev)=
)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto fs_out;<br>
&gt; <br>
&gt; @@ -1504,18 &#43;1503,25 @@ void amdgpu_ras_post_init(struct<br>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!con)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* We enable ras on all hw_supported block, =
but as boot parameter<br>
&gt; might<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * disable some of them and one or more=
 IP has not implemented<br>
&gt; yet.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * So we disable them on behalf.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (con-&gt;flags &amp; AMDG=
PU_RAS_FLAG_INIT_BY_VBIOS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Set up all other IPs which are not implemented. There is a<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * tricky thing that IP's actual ras error type should be<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * MULTI_UNCORRECTABLE, but as driver does not handle it,<br>
&gt; so<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * ERROR_NONE make sense anyway.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_ras_enable_all_features(adev, 1);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* We enable ras on all hw_supported block, but as boot<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * parameter might disable some of them and one or more IP<br>
&gt; has<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * not implemented yet. So we disable them on behalf.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(obj, tmp, &amp;con-&gt;head, n=
ode) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!am=
dgpu_ras_is_supported(adev, obj-<br>
&gt; &gt;head.block)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_feature_enable(adev, &a=
mp;obj-<br>
&gt; &gt;head, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* there should be no any referenc=
e. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(alive_obj(obj));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; };<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; --<br>
&gt; 2.17.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_SN6PR12MB28003555AFCF1943B10B2D04872C0SN6PR12MB2800namp_--

--===============0870686486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0870686486==--
