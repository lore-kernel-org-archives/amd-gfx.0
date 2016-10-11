From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: used cached gca values for
 vi_read_register
Date: Tue, 11 Oct 2016 13:20:20 +0000
Message-ID: <CY4PR12MB1768C25486E504D61CBD8C24F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1476115696-29640-1-git-send-email-alexander.deucher@amd.com>
 <1476115696-29640-4-git-send-email-alexander.deucher@amd.com>
 <57FCD5F9.6050809@gmail.com>
 <CY4PR12MB1768837F1247030A2662183EF7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <BN6PR12MB17643865565D007D3629FDADF7DA0@BN6PR12MB1764.namprd12.prod.outlook.com>,
 <57FCE4DB.5020404@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0413636943=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57FCE4DB.5020404-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0413636943==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768C25486E504D61CBD8C24F7DA0CY4PR12MB1768namp_"

--_000_CY4PR12MB1768C25486E504D61CBD8C24F7DA0CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Andy,


Ha, I'm 1 step away (that was my last bad commit) from determining that.  I=
'll finish up for formality sake but I suspect that is the bad one.


Cheers,

Tom


________________________________
From: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, October 11, 2016 09:10
To: StDenis, Tom; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: Re: [PATCH 4/4] drm/amdgpu: used cached gca values for vi_read_reg=
ister

StDenis, Tom wrote:
> Actually NAK that, I don't have the cache patch internally.  So my Tonga =
crash is something else.

Yes, seems the boot fail starts with the tip commit =3D

drm/amdgpu: move align_mask and nop into ring funcs as well
They are constant as well.

Will also reply to that patch.

>
>
> Tom
>
>
> ________________________________
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of StDeni=
s, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
> Sent: Tuesday, October 11, 2016 08:11
> To: Andy Furniss; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Deucher, Alexander
> Subject: Re: [PATCH 4/4] drm/amdgpu: used cached gca values for vi_read_r=
egister
>
>
> Yup, my Tonga system dies on modprobe with the tip of stg-4.7 this mornin=
g.
>
>
> Tom
>
>
> ________________________________
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Andy F=
urniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Sent: Tuesday, October 11, 2016 08:07
> To: Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Deucher, Alexander
> Subject: Re: [PATCH 4/4] drm/amdgpu: used cached gca values for vi_read_r=
egister
>
> Alex Deucher wrote:
>> Using the cached values has less latency for bare metal and SR-IOV,
>> and prevents reading back bogus values if the engine is powergated.
>
> I can't startx since this on r9285.
>
> Seems there are further issues later in current 4.9-wip =3D I die on
> driver load, will see if that's related or one of Christians patches late=
r.
>
> Also anyone on list have shutdown/reboot issues - I can't for the past
> few 4.9-wips (I did tag on to someone elses bug, but that's gone quiet).
>
> One thing at a time this commit for me, boots into fbcon OK but then
> segfaults -
>
> [    19.694] (II) AIGLX: Loaded and initialized radeonsi
> [    19.694] (II) GLX: Initialized DRI2 GL provider for screen 0
> [    19.694] (EE)
> [    19.694] (EE) Backtrace:
> [    19.717] (EE) 0: /usr/libexec/Xorg (OsSigHandler+0x29) [0x5853b9]
> [    19.726] (EE) 1: /lib/libc.so.6 (killpg+0x40) [0x7f97e86cb68f]
> [    19.756] (EE) 2: /usr/lib/dri/radeonsi_dri.so
> (amdgpu_surface_init+0x486) [0x7f97e1a40746]
> [    19.757] (EE) 3: /usr/lib/dri/radeonsi_dri.so
> (r600_texture_create_object+0xd7) [0x7f97e1a5dfe7]
> [    19.759] (EE) 4: /usr/lib/dri/radeonsi_dri.so
> (r600_texture_create+0x75) [0x7f97e1a5ea15]
> [    19.771] (EE) 5: /usr/lib/dri/radeonsi_dri.so
> (st_texture_create+0x5b) [0x7f97e178af1b]
> [    19.773] (EE) 6: /usr/lib/dri/radeonsi_dri.so
> (guess_and_alloc_texture+0x1ac) [0x7f97e173ae9c]
> [    19.774] (EE) 7: /usr/lib/dri/radeonsi_dri.so
> (st_AllocTextureImageBuffer+0x3a4) [0x7f97e173b3d4]
> [    19.775] (EE) 8: /usr/lib/dri/radeonsi_dri.so (st_TexImage+0x6c)
> [0x7f97e173f9ac]
> [    19.786] (EE) 9: /usr/lib/dri/radeonsi_dri.so
> (_mesa_get_fallback_texture+0x193) [0x7f97e16cb763]
> [    19.786] (EE) 10: /usr/lib/dri/radeonsi_dri.so
> (_mesa_update_texture+0x1a7) [0x7f97e16d1c37]
> [    19.787] (EE) 11: /usr/lib/dri/radeonsi_dri.so
> (_mesa_update_state_locked+0x683) [0x7f97e16b00e3]
> [    19.787] (EE) 12: /usr/lib/dri/radeonsi_dri.so
> (_mesa_update_state+0x11) [0x7f97e16b0441]
> [    19.787] (EE) 13: /usr/lib/dri/radeonsi_dri.so
> (_mesa_EGLImageTargetTexture2DOES+0x168) [0x7f97e16c5c88]
> [    19.802] (EE) 14: /usr/lib/xorg/modules/libglamoregl.so
> (glamor_create_texture_from_image+0xaa) [0x7f97d93bf89a]
> [    19.803] (EE) 15: /usr/lib/xorg/modules/libglamoregl.so
> (glamor_egl_create_textured_pixmap+0x12d) [0x7f97d93bfafd]
> [    19.803] (EE) 16: /usr/lib/xorg/modules/libglamoregl.so
> (glamor_egl_create_textured_screen+0x33) [0x7f97d93bfc23]
> [    19.811] (EE) 17: /usr/lib/xorg/modules/drivers/amdgpu_drv.so
> (amdgpu_glamor_create_screen_resources+0x67) [0x7f97e2ea7cf7]
> [    19.812] (EE) 18: /usr/lib/xorg/modules/drivers/amdgpu_drv.so
> (AMDGPUCreateScreenResources_KMS+0x27e) [0x7f97e2e9fe3e]
> [    19.813] (EE) 19: /usr/libexec/Xorg
> (xf86CrtcCreateScreenResources+0x2e) [0x4a3b7e]
> [    19.814] (EE) 20: /usr/libexec/Xorg (dix_main+0x26e) [0x438ebe]
> [    19.815] (EE) 21: /lib/libc.so.6 (__libc_start_main+0xf0)
> [0x7f97e86b85e0]
> [    19.816] (EE) 22: /usr/libexec/Xorg (_start+0x29) [0x424659]
> [    19.816] (EE)
> [    19.816] (EE) Segmentation fault at address 0x4023321cc
> [    19.816] (EE)
> Fatal server error:
> [    19.816] (EE) Caught signal 11 (Segmentation fault). Server aborting
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...



> amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/m=
ailman/listinfo/amd-gfx>
> lists.freedesktop.org
> To see the collection of prior postings to the list, visit the amd-gfx Ar=
chives. Using amd-gfx: To post a message to all the list members, send emai=
l ...
>
>
>
>


--_000_CY4PR12MB1768C25486E504D61CBD8C24F7DA0CY4PR12MB1768namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi Andy,</p>
<p><br>
</p>
<p>Ha, I'm 1 step away (that was my last bad commit) from determining that.=
 &nbsp;I'll finish up for formality sake but I suspect that is the bad one.=
</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Andy Furniss &lt;ad=
f.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 11, 2016 09:10<br>
<b>To:</b> StDenis, Tom; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH 4/4] drm/amdgpu: used cached gca values for vi_r=
ead_register</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">StDenis, Tom wrote:<br>
&gt; Actually NAK that, I don't have the cache patch internally.&nbsp; So m=
y Tonga crash is something else.<br>
<br>
Yes, seems the boot fail starts with the tip commit =3D<br>
<br>
drm/amdgpu: move align_mask and nop into ring funcs as well<br>
They are constant as well.<br>
<br>
Will also reply to that patch.<br>
<br>
&gt;<br>
&gt;<br>
&gt; Tom<br>
&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf =
of StDenis, Tom &lt;Tom.StDenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Tuesday, October 11, 2016 08:11<br>
&gt; To: Andy Furniss; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Deucher, Alexander<br>
&gt; Subject: Re: [PATCH 4/4] drm/amdgpu: used cached gca values for vi_rea=
d_register<br>
&gt;<br>
&gt;<br>
&gt; Yup, my Tonga system dies on modprobe with the tip of stg-4.7 this mor=
ning.<br>
&gt;<br>
&gt;<br>
&gt; Tom<br>
&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf =
of Andy Furniss &lt;adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; Sent: Tuesday, October 11, 2016 08:07<br>
&gt; To: Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Deucher, Alexander<br>
&gt; Subject: Re: [PATCH 4/4] drm/amdgpu: used cached gca values for vi_rea=
d_register<br>
&gt;<br>
&gt; Alex Deucher wrote:<br>
&gt;&gt; Using the cached values has less latency for bare metal and SR-IOV=
,<br>
&gt;&gt; and prevents reading back bogus values if the engine is powergated=
.<br>
&gt;<br>
&gt; I can't startx since this on r9285.<br>
&gt;<br>
&gt; Seems there are further issues later in current 4.9-wip =3D I die on<b=
r>
&gt; driver load, will see if that's related or one of Christians patches l=
ater.<br>
&gt;<br>
&gt; Also anyone on list have shutdown/reboot issues - I can't for the past=
<br>
&gt; few 4.9-wips (I did tag on to someone elses bug, but that's gone quiet=
).<br>
&gt;<br>
&gt; One thing at a time this commit for me, boots into fbcon OK but then<b=
r>
&gt; segfaults -<br>
&gt;<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.694] (II) AIGLX: Loaded and initialized radeons=
i<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.694] (II) GLX: Initialized DRI2 GL provider for=
 screen 0<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.694] (EE)<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.694] (EE) Backtrace:<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.717] (EE) 0: /usr/libexec/Xorg (OsSigHandler&#4=
3;0x29) [0x5853b9]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.726] (EE) 1: /lib/libc.so.6 (killpg&#43;0x40) [=
0x7f97e86cb68f]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.756] (EE) 2: /usr/lib/dri/radeonsi_dri.so<br>
&gt; (amdgpu_surface_init&#43;0x486) [0x7f97e1a40746]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.757] (EE) 3: /usr/lib/dri/radeonsi_dri.so<br>
&gt; (r600_texture_create_object&#43;0xd7) [0x7f97e1a5dfe7]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.759] (EE) 4: /usr/lib/dri/radeonsi_dri.so<br>
&gt; (r600_texture_create&#43;0x75) [0x7f97e1a5ea15]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.771] (EE) 5: /usr/lib/dri/radeonsi_dri.so<br>
&gt; (st_texture_create&#43;0x5b) [0x7f97e178af1b]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.773] (EE) 6: /usr/lib/dri/radeonsi_dri.so<br>
&gt; (guess_and_alloc_texture&#43;0x1ac) [0x7f97e173ae9c]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.774] (EE) 7: /usr/lib/dri/radeonsi_dri.so<br>
&gt; (st_AllocTextureImageBuffer&#43;0x3a4) [0x7f97e173b3d4]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.775] (EE) 8: /usr/lib/dri/radeonsi_dri.so (st_T=
exImage&#43;0x6c)<br>
&gt; [0x7f97e173f9ac]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.786] (EE) 9: /usr/lib/dri/radeonsi_dri.so<br>
&gt; (_mesa_get_fallback_texture&#43;0x193) [0x7f97e16cb763]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.786] (EE) 10: /usr/lib/dri/radeonsi_dri.so<br>
&gt; (_mesa_update_texture&#43;0x1a7) [0x7f97e16d1c37]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.787] (EE) 11: /usr/lib/dri/radeonsi_dri.so<br>
&gt; (_mesa_update_state_locked&#43;0x683) [0x7f97e16b00e3]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.787] (EE) 12: /usr/lib/dri/radeonsi_dri.so<br>
&gt; (_mesa_update_state&#43;0x11) [0x7f97e16b0441]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.787] (EE) 13: /usr/lib/dri/radeonsi_dri.so<br>
&gt; (_mesa_EGLImageTargetTexture2DOES&#43;0x168) [0x7f97e16c5c88]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.802] (EE) 14: /usr/lib/xorg/modules/libglamoreg=
l.so<br>
&gt; (glamor_create_texture_from_image&#43;0xaa) [0x7f97d93bf89a]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.803] (EE) 15: /usr/lib/xorg/modules/libglamoreg=
l.so<br>
&gt; (glamor_egl_create_textured_pixmap&#43;0x12d) [0x7f97d93bfafd]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.803] (EE) 16: /usr/lib/xorg/modules/libglamoreg=
l.so<br>
&gt; (glamor_egl_create_textured_screen&#43;0x33) [0x7f97d93bfc23]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.811] (EE) 17: /usr/lib/xorg/modules/drivers/amd=
gpu_drv.so<br>
&gt; (amdgpu_glamor_create_screen_resources&#43;0x67) [0x7f97e2ea7cf7]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.812] (EE) 18: /usr/lib/xorg/modules/drivers/amd=
gpu_drv.so<br>
&gt; (AMDGPUCreateScreenResources_KMS&#43;0x27e) [0x7f97e2e9fe3e]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.813] (EE) 19: /usr/libexec/Xorg<br>
&gt; (xf86CrtcCreateScreenResources&#43;0x2e) [0x4a3b7e]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.814] (EE) 20: /usr/libexec/Xorg (dix_main&#43;0=
x26e) [0x438ebe]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.815] (EE) 21: /lib/libc.so.6 (__libc_start_main=
&#43;0xf0)<br>
&gt; [0x7f97e86b85e0]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.816] (EE) 22: /usr/libexec/Xorg (_start&#43;0x2=
9) [0x424659]<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.816] (EE)<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.816] (EE) Segmentation fault at address 0x40233=
21cc<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.816] (EE)<br>
&gt; Fatal server error:<br>
&gt; [&nbsp;&nbsp;&nbsp; 19.816] (EE) Caught signal 11 (Segmentation fault)=
. Server aborting<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk683572" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14761919710690.7909482946435269" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14761919710650.21217846862968748" cellspacing=3D"0=
" style=3D"width: 90%; background-color: rgb(255, 255, 255); position: rela=
tive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: =
20px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted =
rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14761919710670.6703100046398087" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14761919710670.9148237221026945"></div>
<div id=3D"LPTitle_14761919710670.5541633888025892" style=3D"top: 0px; colo=
r: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_14761919710680.020901425608859103" href=3D"https://lis=
ts.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"tex=
t-decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14761919710680.9158180300381105" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14761919710680.6459750253713015" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
&gt; amd-gfx Info Page - lists.freedesktop.org&lt;https://lists.freedesktop=
.org/mailman/listinfo/amd-gfx&gt;<br>
&gt; lists.freedesktop.org<br>
&gt; To see the collection of prior postings to the list, visit the amd-gfx=
 Archives. Using amd-gfx: To post a message to all the list members, send e=
mail ...<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1768C25486E504D61CBD8C24F7DA0CY4PR12MB1768namp_--

--===============0413636943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0413636943==--
