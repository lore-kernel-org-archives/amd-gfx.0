From: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Fri, 24 Mar 2017 19:01:07 +0000
Message-ID: <CAHWPjbUEQCr4Qox5W-C8LYep7-fH=3FV_qhYydpOg2LvqGbZUw@mail.gmail.com>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
 <CAOfP2NDoHof0UhQbz53N9WW8jLH3yC_e+ESrTbdd9Ldb6RYg=Q@mail.gmail.com>
 <5f26f8a1-e5bd-ca7a-c7ee-08c8f04f2110@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0888087782=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5f26f8a1-e5bd-ca7a-c7ee-08c8f04f2110-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Zachary Michaels <zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>

--===============0888087782==
Content-Type: multipart/alternative; boundary=f403045e31eabc06ab054b7e9d1b

--f403045e31eabc06ab054b7e9d1b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michel,

No this change does not help on the other issue (hard lockup).
I have no tried it in combination with the 0 -> i change.

Thx anyway.
Julien


On 24 March 2017 at 10:03, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

> On 24/03/17 12:31 AM, Zachary Michaels wrote:
> >
> > I should also note that we are experiencing another issue where the
> > kernel locks up in similar circumstances. As Julien noted, we get no
> > output, and the watchdogs don't seem to work. It may be the case that
> > Xorg and our process are calling ttm_bo_mem_force_space concurrently,
> > but I don't think we have enough information yet to say for
> > sure. Reverting this commit does not fix that issue. I have some small
> > amount of evidence indicating that bos flagged for CPU access are
> > getting placed in CPU inaccessible memory. Could that cause this sort o=
f
> > kernel lockup?
>
> Possibly, does this help?
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/
> radeon_ttm.c
> index 37d68cd1f272..40d1bb467a71 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -198,7 +198,8 @@ static void radeon_evict_flags(struct
> ttm_buffer_object *bo,
>         case TTM_PL_VRAM:
>                 if (rbo->rdev->ring[radeon_copy_ring_index(rbo->rdev)].re=
ady
> =3D=3D false)
>                         radeon_ttm_placement_from_domain(rbo,
> RADEON_GEM_DOMAIN_CPU);
> -               else if (rbo->rdev->mc.visible_vram_size <
> rbo->rdev->mc.real_vram_size &&
> +               else if (!(rbo->flags & RADEON_GEM_CPU_ACCESS) &&
> +                        rbo->rdev->mc.visible_vram_size <
> rbo->rdev->mc.real_vram_size &&
>                          bo->mem.start < (rbo->rdev->mc.visible_vram_size
> >> PAGE_SHIFT)) {
>                         unsigned fpfn =3D rbo->rdev->mc.visible_vram_size
> >> PAGE_SHIFT;
>                         int i;
>
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--f403045e31eabc06ab054b7e9d1b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Michel,<div><br></div><div>No this change does not help=
 on the other issue (hard lockup).</div><div>I have no tried it in combinat=
ion with the 0 -&gt; i change.=C2=A0</div><div><br></div><div>Thx anyway.</=
div><div>Julien</div><div><br></div></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On 24 March 2017 at 10:03, Michel D=C3=A4nzer <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">m=
ichel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
span class=3D"">On 24/03/17 12:31 AM, Zachary Michaels wrote:<br>
&gt;<br>
&gt; I should also note that we are experiencing another issue where the<br=
>
&gt; kernel locks up in similar circumstances. As Julien noted, we get no<b=
r>
&gt; output, and the watchdogs don&#39;t seem to work. It may be the case t=
hat<br>
&gt; Xorg and our process are calling ttm_bo_mem_force_space concurrently,<=
br>
&gt; but I don&#39;t think we have enough information yet to say for<br>
&gt; sure. Reverting this commit does not fix that issue. I have some small=
<br>
&gt; amount of evidence indicating that bos flagged for CPU access are<br>
&gt; getting placed in CPU inaccessible memory. Could that cause this sort =
of<br>
&gt; kernel lockup?<br>
<br>
</span>Possibly, does this help?<br>
<br>
diff --git a/drivers/gpu/drm/radeon/<wbr>radeon_ttm.c b/drivers/gpu/drm/rad=
eon/<wbr>radeon_ttm.c<br>
index 37d68cd1f272..40d1bb467a71 100644<br>
--- a/drivers/gpu/drm/radeon/<wbr>radeon_ttm.c<br>
+++ b/drivers/gpu/drm/radeon/<wbr>radeon_ttm.c<br>
@@ -198,7 +198,8 @@ static void radeon_evict_flags(struct ttm_buffer_object=
 *bo,<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TTM_PL_VRAM:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rbo-&gt;rdev-&g=
t;ring[radeon_copy_<wbr>ring_index(rbo-&gt;rdev)].ready =3D=3D false)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 radeon_ttm_placement_from_<wbr>domain(rbo, RADEON_GEM_DOMAIN_CPU=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (rbo-&gt;rd=
ev-&gt;mc.visible_vram_<wbr>size &lt; rbo-&gt;rdev-&gt;mc.real_vram_size &a=
mp;&amp;<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (!(r=
bo-&gt;flags &amp; RADEON_GEM_CPU_ACCESS) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rbo-&gt;rdev-&gt;mc.visible_vram_<wbr>size &lt; rbo-&gt;rdev-&gt=
;mc.real_vram_size &amp;&amp;<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo-&gt;mem.start &lt; (rbo-&gt;rdev-&gt;m=
c.visible_vram_<wbr>size &gt;&gt; PAGE_SHIFT)) {<br>
</span><span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned fpfn =3D rbo-&gt;rdev-&gt;mc.vi=
sible_vram_<wbr>size &gt;&gt; PAGE_SHIFT;<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int i;<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
______________________________<wbr>_________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.<wbr>org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/l=
istinfo/dri-devel</a><br>
</div></div></blockquote></div><br></div>

--f403045e31eabc06ab054b7e9d1b--

--===============0888087782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0888087782==--
