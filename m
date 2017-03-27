From: Zachary Michaels <zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: Override fpfn for all VRAM placements in
 radeon_evict_flags
Date: Mon, 27 Mar 2017 09:38:57 -0700
Message-ID: <CAOfP2NAx=ynrON5NHz0TKBuFns3UyecOWvjxLriuoy0jJ3swPw@mail.gmail.com>
References: <20170327005843.2009-1-michel@daenzer.net>
 <9485c238-d562-c363-f108-0c736af440eb@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1977746167=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9485c238-d562-c363-f108-0c736af440eb-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1977746167==
Content-Type: multipart/alternative; boundary=001a114660e0d423af054bb8fadc

--001a114660e0d423af054bb8fadc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for the help and the quick turnaround!

On Sun, Mar 26, 2017 at 11:36 PM, Christian K=C3=B6nig <deathsimple@vodafon=
e.de>
wrote:

> Am 27.03.2017 um 02:58 schrieb Michel D=C3=A4nzer:
>
>> From: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>>
>> We were accidentally only overriding the first VRAM placement. For BOs
>> with the RADEON_GEM_NO_CPU_ACCESS flag set,
>> radeon_ttm_placement_from_domain creates a second VRAM placment with
>> fpfn =3D=3D 0. If VRAM is almost full, the first VRAM placement with
>> fpfn > 0 may not work, but the second one with fpfn =3D=3D 0 always will
>> (the BO's current location trivially satisfies it). Because "moving"
>> the BO to its current location puts it back on the LRU list, this
>> results in an infinite loop.
>>
>> Fixes: 2a85aedd117c ("drm/radeon: Try evicting from CPU accessible to
>>                        inaccessible VRAM first")
>> Reported-by: Zachary Michaels <zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>
>> Reported-and-Tested-by: Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
>
> ---
>>   drivers/gpu/drm/radeon/radeon_ttm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c
>> b/drivers/gpu/drm/radeon/radeon_ttm.c
>> index 5c7cf644ba1d..37d68cd1f272 100644
>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
>> @@ -213,8 +213,8 @@ static void radeon_evict_flags(struct
>> ttm_buffer_object *bo,
>>                         rbo->placement.num_busy_placement =3D 0;
>>                         for (i =3D 0; i < rbo->placement.num_placement;
>> i++) {
>>                                 if (rbo->placements[i].flags &
>> TTM_PL_FLAG_VRAM) {
>> -                                       if (rbo->placements[0].fpfn <
>> fpfn)
>> -                                               rbo->placements[0].fpfn =
=3D
>> fpfn;
>> +                                       if (rbo->placements[i].fpfn <
>> fpfn)
>> +                                               rbo->placements[i].fpfn =
=3D
>> fpfn;
>>                                 } else {
>>                                         rbo->placement.busy_placement =
=3D
>>                                                 &rbo->placements[i];
>>
>
>
>

--001a114660e0d423af054bb8fadc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the help and the quick turnaround!<br><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sun, Mar 26, 2017 at 11=
:36 PM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a href=3D"mailto:deaths=
imple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=3D"_blank">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Am 27.03.2017 um=
 02:58 schrieb Michel D=C3=A4nzer:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org" targ=
et=3D"_blank">michel.daenzer-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
We were accidentally only overriding the first VRAM placement. For BOs<br>
with the RADEON_GEM_NO_CPU_ACCESS flag set,<br>
radeon_ttm_placement_from_doma<wbr>in creates a second VRAM placment with<b=
r>
fpfn =3D=3D 0. If VRAM is almost full, the first VRAM placement with<br>
fpfn &gt; 0 may not work, but the second one with fpfn =3D=3D 0 always will=
<br>
(the BO&#39;s current location trivially satisfies it). Because &quot;movin=
g&quot;<br>
the BO to its current location puts it back on the LRU list, this<br>
results in an infinite loop.<br>
<br>
Fixes: 2a85aedd117c (&quot;drm/radeon: Try evicting from CPU accessible to<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0inaccessible VRAM first&quot;)<br>
Reported-by: Zachary Michaels &lt;<a href=3D"mailto:zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org" t=
arget=3D"_blank">zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
Reported-and-Tested-by: Julien Isorce &lt;<a href=3D"mailto:jisorce@oblong.=
com" target=3D"_blank">jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
Signed-off-by: Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel.daenzer@amd.=
com" target=3D"_blank">michel.daenzer-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
</blockquote>
<br></span>
Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<div class=3D"HOEn=
Zb"><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
---<br>
=C2=A0 drivers/gpu/drm/radeon/radeon_<wbr>ttm.c | 4 ++--<br>
=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/radeon/radeo<wbr>n_ttm.c b/drivers/gpu/drm/rad=
eon/radeo<wbr>n_ttm.c<br>
index 5c7cf644ba1d..37d68cd1f272 100644<br>
--- a/drivers/gpu/drm/radeon/radeo<wbr>n_ttm.c<br>
+++ b/drivers/gpu/drm/radeon/radeo<wbr>n_ttm.c<br>
@@ -213,8 +213,8 @@ static void radeon_evict_flags(struct ttm_buffer_object=
 *bo,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rbo-&gt;placement.num_busy_placem<wbr>ent =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 for (i =3D 0; i &lt; rbo-&gt;placement.num_placement; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rbo-&gt;placements[i].flags &amp=
; TTM_PL_FLAG_VRAM) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rbo-&=
gt;placements[0].fpfn &lt; fpfn)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0rbo-&gt;placements[0].fpfn =3D fpfn;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rbo-&=
gt;placements[i].fpfn &lt; fpfn)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0rbo-&gt;placements[i].fpfn =3D fpfn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rbo-&gt;=
placement.busy_placement =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;rbo-&gt;placements[i];<br>
</blockquote>
<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a114660e0d423af054bb8fadc--

--===============1977746167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1977746167==--
