From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Enable scatter gather display support
Date: Thu, 12 Apr 2018 12:40:29 -0400
Message-ID: <CAAxE2A4msxZa19Cvv6giMDDYg57-M_qawgFRM2aaK6sUERuqSA@mail.gmail.com>
References: <1522189371-13767-1-git-send-email-Samuel.Li@amd.com>
 <7cc47f78-66eb-148d-96a2-b97760f767bf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0618704673=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7cc47f78-66eb-148d-96a2-b97760f767bf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

--===============0618704673==
Content-Type: multipart/alternative; boundary="00000000000042ba310569a96cce"

--00000000000042ba310569a96cce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you be more specific, Christian? Mesa has this, I don't think it needs
anything else:
https://cgit.freedesktop.org/mesa/mesa/commit/?id=3D7d2079908d9ef05ec3f35b7=
078833e57846cab5b

Marek

On Wed, Mar 28, 2018 at 3:46 AM, Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Am 28.03.2018 um 00:22 schrieb Samuel Li:
>
>> It's auto by default. For CZ/ST, auto setting enables sg display
>> when vram size is small; otherwise still uses vram.
>> This patch fixed some potential hang issue introduced by change
>> "allow framebuffer in GART memory as well" due to CZ/ST hardware
>> limitation.
>>
>
> Well that is still a NAK.
>
> As discussed now multiple times please implement the necessary changes in
> Mesa.
>
> Regards,
> Christian.
>
>
>
>> v2: Change default setting to auto, also some misc changes.
>> Signed-off-by: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 10 ++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.h       |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |  4 ++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c            |  2 ++
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++-
>>   6 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index a7e2229..c942362 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -129,6 +129,7 @@ extern int amdgpu_lbpw;
>>   extern int amdgpu_compute_multipipe;
>>   extern int amdgpu_gpu_recovery;
>>   extern int amdgpu_emu_mode;
>> +extern int amdgpu_sg_display;
>>     #ifdef CONFIG_DRM_AMDGPU_SI
>>   extern int amdgpu_si_support;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index 5495b29..1e7b950 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -513,8 +513,14 @@ uint32_t amdgpu_display_framebuffer_domains(struct
>> amdgpu_device *adev)
>>   #if defined(CONFIG_DRM_AMD_DC)
>>         if (adev->asic_type >=3D CHIP_CARRIZO && adev->asic_type <
>> CHIP_RAVEN &&
>>             adev->flags & AMD_IS_APU &&
>> -           amdgpu_device_asic_has_dc_support(adev->asic_type))
>> -               domain |=3D AMDGPU_GEM_DOMAIN_GTT;
>> +           amdgpu_device_asic_has_dc_support(adev->asic_type)) {
>> +               if (amdgpu_sg_display =3D=3D 1)
>> +                       domain =3D AMDGPU_GEM_DOMAIN_GTT;
>> +               else if (amdgpu_sg_display =3D=3D -1) {
>> +                       if (adev->gmc.real_vram_size <
>> AMDGPU_SG_THRESHOLD)
>> +                               domain =3D AMDGPU_GEM_DOMAIN_GTT;
>> +               }
>> +       }
>>   #endif
>>         return domain;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
>> index 2b11d80..2b25393 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
>> @@ -23,6 +23,8 @@
>>   #ifndef __AMDGPU_DISPLAY_H__
>>   #define __AMDGPU_DISPLAY_H__
>>   +#define AMDGPU_SG_THRESHOLD  (256*1024*1024)
>> +
>>   uint32_t amdgpu_display_framebuffer_domains(struct amdgpu_device
>> *adev);
>>   struct drm_framebuffer *
>>   amdgpu_display_user_framebuffer_create(struct drm_device *dev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 1bfce79..19f11a5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -132,6 +132,7 @@ int amdgpu_lbpw =3D -1;
>>   int amdgpu_compute_multipipe =3D -1;
>>   int amdgpu_gpu_recovery =3D -1; /* auto */
>>   int amdgpu_emu_mode =3D 0;
>> +int amdgpu_sg_display =3D -1;
>>     MODULE_PARM_DESC(vramlimit, "Restrict VRAM for testing, in
>> megabytes");
>>   module_param_named(vramlimit, amdgpu_vram_limit, int, 0600);
>> @@ -290,6 +291,9 @@ module_param_named(gpu_recovery,
>> amdgpu_gpu_recovery, int, 0444);
>>   MODULE_PARM_DESC(emu_mode, "Emulation mode, (1 =3D enable, 0 =3D disab=
le)");
>>   module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);
>>   +MODULE_PARM_DESC(sg_display, "Enable scatter gather display, (1 =3D
>> enable, 0 =3D disable, -1 =3D auto");
>> +module_param_named(sg_display, amdgpu_sg_display, int, 0444);
>> +
>>   #ifdef CONFIG_DRM_AMDGPU_SI
>>     #if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>> index 1206301..f57c355 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>> @@ -138,6 +138,8 @@ static int amdgpufb_create_pinned_object(struct
>> amdgpu_fbdev *rfbdev,
>>         mode_cmd->pitches[0] =3D amdgpu_align_pitch(adev, mode_cmd->widt=
h,
>> cpp,
>>                                                   fb_tiled);
>>         domain =3D amdgpu_display_framebuffer_domains(adev);
>> +       if (domain & AMDGPU_GEM_DOMAIN_GTT)
>> +               DRM_DEBUG_DRIVER("Scatter gather display: enabled\n");
>>         height =3D ALIGN(mode_cmd->height, 8);
>>         size =3D mode_cmd->pitches[0] * height;
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 68ab325..7e9f247 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -3074,7 +3074,8 @@ static int dm_plane_helper_prepare_fb(struct
>> drm_plane *plane,
>>                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>>         r =3D amdgpu_bo_pin(rbo, domain, &afb->address);
>> -
>> +       rbo->preferred_domains =3D domain;
>> +       rbo->allowed_domains =3D domain;
>>         amdgpu_bo_unreserve(rbo);
>>         if (unlikely(r !=3D 0)) {
>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000042ba310569a96cce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Can you be more specific, Christian? Mesa has this, I=
 don&#39;t think it needs anything else:<br><a href=3D"https://cgit.freedes=
ktop.org/mesa/mesa/commit/?id=3D7d2079908d9ef05ec3f35b7078833e57846cab5b">h=
ttps://cgit.freedesktop.org/mesa/mesa/commit/?id=3D7d2079908d9ef05ec3f35b70=
78833e57846cab5b</a><br><br></div>Marek<br></div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">On Wed, Mar 28, 2018 at 3:46 AM, Christian =
K=C3=B6nig <span dir=3D"ltr">&lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com" target=3D"_blank">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Am 28.03.2018 um=
 00:22 schrieb Samuel Li:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
It&#39;s auto by default. For CZ/ST, auto setting enables sg display<br>
when vram size is small; otherwise still uses vram.<br>
This patch fixed some potential hang issue introduced by change<br>
&quot;allow framebuffer in GART memory as well&quot; due to CZ/ST hardware<=
br>
limitation.<br>
</blockquote>
<br></span>
Well that is still a NAK.<br>
<br>
As discussed now multiple times please implement the necessary changes in M=
esa.<br>
<br>
Regards,<br>
Christian.<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
v2: Change default setting to auto, also some misc changes.<br>
Signed-off-by: Samuel Li &lt;<a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target=3D=
"_blank">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_display.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 10 ++++++++--<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_display.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 2 ++<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_drv.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 4 ++++<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_fb.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0 drivers/gpu/drm/amd/display/am<wbr>dgpu_dm/amdgpu_dm.c |=C2=A0 3 ++-=
<br>
=C2=A0 6 files changed, 19 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/a<wbr>mdgpu.h<br>
index a7e2229..c942362 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu.h<br>
@@ -129,6 +129,7 @@ extern int amdgpu_lbpw;<br>
=C2=A0 extern int amdgpu_compute_multipipe;<br>
=C2=A0 extern int amdgpu_gpu_recovery;<br>
=C2=A0 extern int amdgpu_emu_mode;<br>
+extern int amdgpu_sg_display;<br>
=C2=A0 =C2=A0 #ifdef CONFIG_DRM_AMDGPU_SI<br>
=C2=A0 extern int amdgpu_si_support;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.c b/drivers/gpu=
/drm/amd/amdgpu/a<wbr>mdgpu_display.c<br>
index 5495b29..1e7b950 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.c<br>
@@ -513,8 +513,14 @@ uint32_t amdgpu_display_framebuffer_dom<wbr>ains(struc=
t amdgpu_device *adev)<br>
=C2=A0 #if defined(CONFIG_DRM_AMD_DC)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;asic_type &gt;=3D CHIP_CARRIZO &am=
p;&amp; adev-&gt;asic_type &lt; CHIP_RAVEN &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;flags &amp; AMD_IS_APU &=
amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_device_asic_has_dc_sup<wbr=
>port(adev-&gt;asic_type))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0domain |=3D AMDGPU_=
GEM_DOMAIN_GTT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_device_asic_has_dc_sup<wbr=
>port(adev-&gt;asic_type)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_sg_displ=
ay =3D=3D 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0domain =3D AMDGPU_GEM_DOMAIN_GTT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (amdgpu_sg_=
display =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (adev-&gt;gmc.real_vram_size &lt; AMDGPU_SG_THRESHOLD)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D AMDGPU_GEM_DOMAIN_GTT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 #endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return domain;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.h b/drivers/gpu=
/drm/amd/amdgpu/a<wbr>mdgpu_display.h<br>
index 2b11d80..2b25393 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_display.h<br>
@@ -23,6 +23,8 @@<br>
=C2=A0 #ifndef __AMDGPU_DISPLAY_H__<br>
=C2=A0 #define __AMDGPU_DISPLAY_H__<br>
=C2=A0 +#define AMDGPU_SG_THRESHOLD=C2=A0 (256*1024*1024)<br>
+<br>
=C2=A0 uint32_t amdgpu_display_framebuffer_dom<wbr>ains(struct amdgpu_devic=
e *adev);<br>
=C2=A0 struct drm_framebuffer *<br>
=C2=A0 amdgpu_display_user_framebuffe<wbr>r_create(struct drm_device *dev,<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/a<wbr>mdgpu_drv.c<br>
index 1bfce79..19f11a5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_drv.c<br>
@@ -132,6 +132,7 @@ int amdgpu_lbpw =3D -1;<br>
=C2=A0 int amdgpu_compute_multipipe =3D -1;<br>
=C2=A0 int amdgpu_gpu_recovery =3D -1; /* auto */<br>
=C2=A0 int amdgpu_emu_mode =3D 0;<br>
+int amdgpu_sg_display =3D -1;<br>
=C2=A0 =C2=A0 MODULE_PARM_DESC(vramlimit, &quot;Restrict VRAM for testing, =
in megabytes&quot;);<br>
=C2=A0 module_param_named(vramlimit, amdgpu_vram_limit, int, 0600);<br>
@@ -290,6 +291,9 @@ module_param_named(gpu_recover<wbr>y, amdgpu_gpu_recove=
ry, int, 0444);<br>
=C2=A0 MODULE_PARM_DESC(emu_mode, &quot;Emulation mode, (1 =3D enable, 0 =
=3D disable)&quot;);<br>
=C2=A0 module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);<br>
=C2=A0 +MODULE_PARM_DESC(sg_display, &quot;Enable scatter gather display, (=
1 =3D enable, 0 =3D disable, -1 =3D auto&quot;);<br>
+module_param_named(sg_display<wbr>, amdgpu_sg_display, int, 0444);<br>
+<br>
=C2=A0 #ifdef CONFIG_DRM_AMDGPU_SI<br>
=C2=A0 =C2=A0 #if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_M=
ODU<wbr>LE)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_fb.c b/drivers/gpu/drm/=
amd/amdgpu/a<wbr>mdgpu_fb.c<br>
index 1206301..f57c355 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_fb.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_fb.c<br>
@@ -138,6 +138,8 @@ static int amdgpufb_create_pinned_object(<wbr>struct am=
dgpu_fbdev *rfbdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_cmd-&gt;pitches[0] =3D amdgpu_align_pitch(=
adev, mode_cmd-&gt;width, cpp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fb_tiled);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 domain =3D amdgpu_display_framebuffer_dom<wbr>a=
ins(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (domain &amp; AMDGPU_GEM_DOMAIN_GTT)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG_DRIVER(&q=
uot;Scatter gather display: enabled\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 height =3D ALIGN(mode_cmd-&gt;height, 8);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D mode_cmd-&gt;pitches[0] * height;<br>
diff --git a/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c<br>
index 68ab325..7e9f247 100644<br>
--- a/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c<br>
@@ -3074,7 +3074,8 @@ static int dm_plane_helper_prepare_fb(str<wbr>uct drm=
_plane *plane,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 domain =3D AMDGPU_G=
EM_DOMAIN_VRAM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_bo_pin(rbo, domain, &amp;afb-&gt;a=
ddress);<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rbo-&gt;preferred_domains =3D domain;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rbo-&gt;allowed_domains =3D domain;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_unreserve(rbo);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(r !=3D 0)) {<br>
</blockquote>
<br></div></div><div class=3D"HOEnZb"><div class=3D"h5">
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</div></div></blockquote></div><br></div>

--00000000000042ba310569a96cce--

--===============0618704673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0618704673==--
