From: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] [RFC] drm/radeon: clear WC flag when moving bo from vram
 to gtt
Date: Mon, 24 Apr 2017 11:01:09 +0100
Message-ID: <CAHWPjbVvs70ucs69zC+6j-NyET1AWNFQ=JndKOqZRZA8v6m9+Q@mail.gmail.com>
References: <1493026928-30134-1-git-send-email-jisorce@oblong.com>
 <e602b898-ee7d-e744-5a08-0ab7d0f63d83@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1025598449=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e602b898-ee7d-e744-5a08-0ab7d0f63d83-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, michel.daenzer-5C7GfCeVMHo@public.gmane.org, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1025598449==
Content-Type: multipart/alternative; boundary=001a114e5a54c29c64054de6af18

--001a114e5a54c29c64054de6af18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24 April 2017 at 10:51, Christian K=C3=B6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> w=
rote:

> Am 24.04.2017 um 11:42 schrieb Julien Isorce:
>
>> But re-add the flag is the bo is moved back to vram.
>>
>> This fixes "ring 0/3 stalled" issue which happens when the driver
>> evicts bo from vram to gtt, at least on TAHITI and CAPVERDE.
>>
>
> Interesting find, but NAK on the approach for fixing it.
>

Thx for the comments.


>
> If WC mappings don't work for TAHITI and CAPVERDE we need to figure out
> why or at least disable them for those hardware generations in general.
>

Should I extend
https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/radeon/radeo=
n_object.c?h=3Damd-staging-4.9#n228
to BONAIRE (which will include VERDE and TAHITI) ? (to match
https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/radeon/radeo=
n_ib.c?h=3Damd-staging-4.9#n199
 )

>
> Disabling WC for BOs swapped out from VRAM won't buy us much if the BO wa=
s
> initially created in GTT anyway.


Initially created in VRAM:
https://cgit.freedesktop.org/mesa/mesa/tree/src/gallium/drivers/radeon/r600=
_buffer_common.c#n164


>
>
> Christian.
>
>
>
>> I do not know the exact reason among the following:
>>    - si_copy_dma from vram to gtt is slow if WC
>>         (only for the non-visible part ? specific cases ?)
>>    - Allow snooping (SNOOPED flag from radeon_vm_bo_update).
>>    - WC should not be set at all for bo in the GTT
>>          (same reason why WC is only set for vram domain,
>>           see mesa::r600_init_resource_fields since mesa commit 5b6a0b7
>>               "gallium/radeon: set GTT WC on tiled textures")
>>    - Bug in WC
>>    - Same reason as why radeon_sa_bo_manager_init is not passing
>>      WC flags if older than CHIP_BONAIRE (see 810b73d1
>>          drm/radeon: Use write-combined CPU mappings of IBs on >=3D CIK)
>>    - Same as b738ca5d
>>          Revert "drm/radeon: Use write-combined CPU mappings of ring ...=
"
>>    - Same as 96ea47c0
>>          drm/radeon: Disable uncacheable CPU mappings of GTT with RV6xx
>>          see https://bugs.freedesktop.org/show_bug.cgi?id=3D91268#c2
>>
>> https://bugs.freedesktop.org/show_bug.cgi?id=3D100712
>> ---
>>   drivers/gpu/drm/radeon/radeon.h        |  1 +
>>   drivers/gpu/drm/radeon/radeon_object.c |  1 +
>>   drivers/gpu/drm/radeon/radeon_ttm.c    | 13 +++++++++++++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/radeon/radeon.h
>> b/drivers/gpu/drm/radeon/radeon.h
>> index 7a39a35..9847f4e 100644
>> --- a/drivers/gpu/drm/radeon/radeon.h
>> +++ b/drivers/gpu/drm/radeon/radeon.h
>> @@ -518,6 +518,7 @@ struct radeon_bo {
>>         struct radeon_mn                *mn;
>>         struct list_head                mn_list;
>> +       u32                             vram_flags;
>>   };
>>   #define gem_to_radeon_bo(gobj) container_of((gobj), struct radeon_bo,
>> gem_base)
>>   diff --git a/drivers/gpu/drm/radeon/radeon_object.c
>> b/drivers/gpu/drm/radeon/radeon_object.c
>> index a557869..870f6b0 100644
>> --- a/drivers/gpu/drm/radeon/radeon_object.c
>> +++ b/drivers/gpu/drm/radeon/radeon_object.c
>> @@ -228,6 +228,7 @@ int radeon_bo_create(struct radeon_device *rdev,
>>                                        RADEON_GEM_DOMAIN_CPU);
>>         bo->flags =3D flags;
>> +       bo->vram_flags =3D 0;
>>         /* PCI GART is always snooped */
>>         if (!(rdev->flags & RADEON_IS_PCIE))
>>                 bo->flags &=3D ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c
>> b/drivers/gpu/drm/radeon/radeon_ttm.c
>> index d07ff84..a8743bd 100644
>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
>> @@ -440,6 +440,19 @@ static int radeon_bo_move(struct ttm_buffer_object
>> *bo,
>>                 r =3D radeon_move_ram_vram(bo, evict, interruptible,
>>                                             no_wait_gpu, new_mem);
>>         } else {
>> +               /* Clear WC flag when moving bo from vram to gtt. */
>> +               if (old_mem->mem_type =3D=3D TTM_PL_VRAM && new_mem->mem=
_type
>> =3D=3D TTM_PL_TT) {
>> +                       if (rbo->flags & RADEON_GEM_GTT_WC) {
>> +                               rbo->vram_flags |=3D RADEON_GEM_GTT_WC;
>> +                               rbo->flags &=3D ~RADEON_GEM_GTT_WC;
>> +                       }
>> +               /* Re-add WC flag when moving back from gtt to vram. */
>> +               } else if (old_mem->mem_type =3D=3D TTM_PL_TT &&
>> new_mem->mem_type =3D=3D TTM_PL_VRAM) {
>> +                       if (rbo->vram_flags & RADEON_GEM_GTT_WC) {
>> +                               rbo->flags |=3D RADEON_GEM_GTT_WC;
>> +                               rbo->vram_flags &=3D ~RADEON_GEM_GTT_WC;
>> +                       }
>> +               }
>>                 r =3D radeon_move_blit(bo, evict, no_wait_gpu, new_mem,
>> old_mem);
>>         }
>>
>>
>
>
>

--001a114e5a54c29c64054de6af18
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 24 April 2017 at 10:51, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=3D"_blank">deathsimple@vodafon=
e.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><span class=3D"gmail-">Am 24.04.2017 um 11:42 schrieb Julien Isorce:<b=
r>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
But re-add the flag is the bo is moved back to vram.<br>
<br>
This fixes &quot;ring 0/3 stalled&quot; issue which happens when the driver=
<br>
evicts bo from vram to gtt, at least on TAHITI and CAPVERDE.<br>
</blockquote>
<br></span>
Interesting find, but NAK on the approach for fixing it.<br></blockquote><d=
iv><br></div><div>Thx for the comments.<br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
If WC mappings don&#39;t work for TAHITI and CAPVERDE we need to figure out=
 why or at least disable them for those hardware generations in general.<br=
></blockquote><div><br></div><div>Should I extend <a href=3D"https://cgit.f=
reedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/radeon/radeon_object.c?h=
=3Damd-staging-4.9#n228">https://cgit.freedesktop.org/~agd5f/linux/tree/dri=
vers/gpu/drm/radeon/radeon_object.c?h=3Damd-staging-4.9#n228</a> to BONAIRE=
 (which will include VERDE and TAHITI) ? (to match <a href=3D"https://cgit.=
freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/radeon/radeon_ib.c?h=3Dam=
d-staging-4.9#n199">https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/=
gpu/drm/radeon/radeon_ib.c?h=3Damd-staging-4.9#n199</a>=C2=A0)<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Disabling WC for BOs swapped out from VRAM won&#39;t buy us much if the BO =
was initially created in GTT anyway.</blockquote><div><br></div><div>Initia=
lly created in VRAM:=C2=A0<a href=3D"https://cgit.freedesktop.org/mesa/mesa=
/tree/src/gallium/drivers/radeon/r600_buffer_common.c#n164">https://cgit.fr=
eedesktop.org/mesa/mesa/tree/src/gallium/drivers/radeon/r600_buffer_common.=
c#n164</a></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
Christian.</font></span><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"=
><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I do not know the exact reason among the following:<br>
=C2=A0 =C2=A0- si_copy_dma from vram to gtt is slow if WC<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (only for the non-visible part ? specific cases=
 ?)<br>
=C2=A0 =C2=A0- Allow snooping (SNOOPED flag from radeon_vm_bo_update).<br>
=C2=A0 =C2=A0- WC should not be set at all for bo in the GTT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(same reason why WC is only set for vram =
domain,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 see mesa::r600_init_resource_field<wbr>s=
 since mesa commit 5b6a0b7<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;gallium/radeon: set =
GTT WC on tiled textures&quot;)<br>
=C2=A0 =C2=A0- Bug in WC<br>
=C2=A0 =C2=A0- Same reason as why radeon_sa_bo_manager_init is not passing<=
br>
=C2=A0 =C2=A0 =C2=A0WC flags if older than CHIP_BONAIRE (see 810b73d1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm/radeon: Use write-combined CPU mappin=
gs of IBs on &gt;=3D CIK)<br>
=C2=A0 =C2=A0- Same as b738ca5d<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Revert &quot;drm/radeon: Use write-combin=
ed CPU mappings of ring ...&quot;<br>
=C2=A0 =C2=A0- Same as 96ea47c0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm/radeon: Disable uncacheable CPU mappi=
ngs of GTT with RV6xx<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0see <a href=3D"https://bugs.freedesktop.o=
rg/show_bug.cgi?id=3D91268#c2" rel=3D"noreferrer" target=3D"_blank">https:/=
/bugs.freedesktop.org/s<wbr>how_bug.cgi?id=3D91268#c2</a><br>
<br>
<a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D100712" rel=3D"no=
referrer" target=3D"_blank">https://bugs.freedesktop.org/s<wbr>how_bug.cgi?=
id=3D100712</a><br>
---<br>
=C2=A0 drivers/gpu/drm/radeon/radeon.<wbr>h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 1 +<br>
=C2=A0 drivers/gpu/drm/radeon/radeon_<wbr>object.c |=C2=A0 1 +<br>
=C2=A0 drivers/gpu/drm/radeon/radeon_<wbr>ttm.c=C2=A0 =C2=A0 | 13 +++++++++=
++++<br>
=C2=A0 3 files changed, 15 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/radeon/radeo<wbr>n.h b/drivers/gpu/drm/radeon/=
radeo<wbr>n.h<br>
index 7a39a35..9847f4e 100644<br>
--- a/drivers/gpu/drm/radeon/radeo<wbr>n.h<br>
+++ b/drivers/gpu/drm/radeon/radeo<wbr>n.h<br>
@@ -518,6 +518,7 @@ struct radeon_bo {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct radeon_mn=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 *mn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct list_head=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 mn_list;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vram_flags;<b=
r>
=C2=A0 };<br>
=C2=A0 #define gem_to_radeon_bo(gobj) container_of((gobj), struct radeon_bo=
, gem_base)<br>
=C2=A0 diff --git a/drivers/gpu/drm/radeon/radeo<wbr>n_object.c b/drivers/g=
pu/drm/radeon/radeo<wbr>n_object.c<br>
index a557869..870f6b0 100644<br>
--- a/drivers/gpu/drm/radeon/radeo<wbr>n_object.c<br>
+++ b/drivers/gpu/drm/radeon/radeo<wbr>n_object.c<br>
@@ -228,6 +228,7 @@ int radeon_bo_create(struct radeon_device *rdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RADEON_GE=
M_DOMAIN_CPU);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;flags =3D flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bo-&gt;vram_flags =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* PCI GART is always snooped */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(rdev-&gt;flags &amp; RADEON_IS_PCIE))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;flags &amp;=
=3D ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);<br>
diff --git a/drivers/gpu/drm/radeon/radeo<wbr>n_ttm.c b/drivers/gpu/drm/rad=
eon/radeo<wbr>n_ttm.c<br>
index d07ff84..a8743bd 100644<br>
--- a/drivers/gpu/drm/radeon/radeo<wbr>n_ttm.c<br>
+++ b/drivers/gpu/drm/radeon/radeo<wbr>n_ttm.c<br>
@@ -440,6 +440,19 @@ static int radeon_bo_move(struct ttm_buffer_object *bo=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D radeon_move_r=
am_vram(bo, evict, interruptible,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 no_wait_gpu, new_mem);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Clear WC flag wh=
en moving bo from vram to gtt. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (old_mem-&gt;mem=
_type =3D=3D TTM_PL_VRAM &amp;&amp; new_mem-&gt;mem_type =3D=3D TTM_PL_TT) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rbo-&gt;flags &amp; RADEON_GEM_GTT_WC) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rbo-&gt;vram_flags |=3D RADEON_GEM_GT=
T_WC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rbo-&gt;flags &amp;=3D ~RADEON_GEM_GT=
T_WC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Re-add WC flag w=
hen moving back from gtt to vram. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (old_mem-=
&gt;mem_type =3D=3D TTM_PL_TT &amp;&amp; new_mem-&gt;mem_type =3D=3D TTM_PL=
_VRAM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rbo-&gt;vram_flags &amp; RADEON_GEM_GTT_WC) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rbo-&gt;flags |=3D RADEON_GEM_GTT_WC;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rbo-&gt;vram_flags &amp;=3D ~RADEON_G=
EM_GTT_WC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D radeon_move_b=
lit(bo, evict, no_wait_gpu, new_mem, old_mem);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 <br>
</blockquote>
<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a114e5a54c29c64054de6af18--

--===============1025598449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1025598449==--
