From: Christopher James Halse Rogers <christopher.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH 7/7 v2] drm/radeon: Refuse to migrate a prime BO to VRAM.
 (v2)
Date: Tue, 04 Apr 2017 08:03:05 +0000
Message-ID: <CAPMmPEzA=0Ucux4QLjZv+55Fd=8v=BquFhCGH6PS4BpoFLak8g@mail.gmail.com>
References: <20170329002720.11445-7-raof@ubuntu.com>
 <20170403033523.22639-1-raof@ubuntu.com>
 <20170403033523.22639-2-raof@ubuntu.com>
 <4fe38f82-c9d5-c212-fa05-08c2b4684c4e@vodafone.de>
 <CADnq5_OFk+Z+5sW7wyVt1UwpKdpmc88PJ-1mLNfPiDqaNq+ADA@mail.gmail.com>
 <c9417139-b930-040b-c186-e99b8ecc3474@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0881929291=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c9417139-b930-040b-c186-e99b8ecc3474-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Christopher James Halse Rogers <raof-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0881929291==
Content-Type: multipart/alternative; boundary=001a114315ee4395f0054c52b5f9

--001a114315ee4395f0054c52b5f9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I also haven't tested it on hardware (all my hardware seems to be supported
by amdgpu), but the only times we touch prime_shared_count are:
1) It's set to 1 in radeon_gem_prime_import_sg_table. This shouldn't be
called in the self-import case (and isn't, as far as I can tell), and
2) It's incremented in radeon_gem_prime_pin, right after the bo is pinned
to GTT, so cannot be migrated to VRAM anyway (unless there's an unmatched
radeon_bo_unpin call somewhere else?).

On Tue, 4 Apr 2017 at 02:30 Christian K=C3=B6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> =
wrote:

> Am 03.04.2017 um 17:51 schrieb Alex Deucher:
> > On Mon, Apr 3, 2017 at 4:24 AM, Christian K=C3=B6nig <deathsimple@vodaf=
one.de>
> wrote:
> >> Am 03.04.2017 um 05:35 schrieb raof-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org:
> >>> From: Christopher James Halse Rogers
> >>> <christopher.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> >>>
> >>> BOs shared via dma-buf, either imported or exported, cannot sensibly =
be
> >>> migrated to VRAM
> >>> without breaking the dma-buf sharing. Refuse userspace requests to
> migrate
> >>> to VRAM,
> >>> ensure such BOs are not migrated during command submission, and refus=
e
> to
> >>> pin them
> >>> to VRAM.
> >>>
> >>> v2: Don't pin BOs in GTT. Instead, refuse to migrate BOs to VRAM.
> >>>
> >>> Signed-off-by: Christopher James Halse Rogers
> >>> <christopher.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> >>
> >> Patches #4, #6 and this one (#7) are Reviewed-by: Christian K=C3=B6nig
> >> <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
> > Will this cause any issues with self sharing?  E.g., the standard use
> > case with a single GPU and DRI3?
>
> No, the code from amdgpu to count the number of times we really shared a
> BO with somebody was ported over to radeon as far as I can see.
>
> So that should work fine, but I haven't double checked or tested it.
>
> Christian.
>
> >
> > Alex
> >
> >>
> >>> ---
> >>>    drivers/gpu/drm/radeon/radeon_cs.c     | 10 ++++++++++
> >>>    drivers/gpu/drm/radeon/radeon_gem.c    |  4 ++++
> >>>    drivers/gpu/drm/radeon/radeon_object.c |  5 +++++
> >>>    3 files changed, 19 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/radeon/radeon_cs.c
> >>> b/drivers/gpu/drm/radeon/radeon_cs.c
> >>> index a8442f7196d6..df6b58c08544 100644
> >>> --- a/drivers/gpu/drm/radeon/radeon_cs.c
> >>> +++ b/drivers/gpu/drm/radeon/radeon_cs.c
> >>> @@ -164,6 +164,16 @@ static int radeon_cs_parser_relocs(struct
> >>> radeon_cs_parser *p)
> >>>                          p->relocs[i].allowed_domains =3D domain;
> >>>                  }
> >>>    +             /* Objects shared as dma-bufs cannot be moved to VRA=
M
> */
> >>> +               if (p->relocs[i].robj->prime_shared_count) {
> >>> +                       p->relocs[i].allowed_domains &=3D
> >>> ~RADEON_GEM_DOMAIN_VRAM;
> >>> +                       if (!p->relocs[i].allowed_domains) {
> >>> +                               DRM_ERROR("BO associated with dma-buf
> >>> cannot "
> >>> +                                         "be moved to VRAM\n");
> >>> +                               return -EINVAL;
> >>> +                       }
> >>> +               }
> >>> +
> >>>                  p->relocs[i].tv.bo =3D &p->relocs[i].robj->tbo;
> >>>                  p->relocs[i].tv.shared =3D !r->write_domain;
> >>>    diff --git a/drivers/gpu/drm/radeon/radeon_gem.c
> >>> b/drivers/gpu/drm/radeon/radeon_gem.c
> >>> index 96683f5b2b1b..067ea7d7658a 100644
> >>> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> >>> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> >>> @@ -120,6 +120,10 @@ static int radeon_gem_set_domain(struct
> >>> drm_gem_object *gobj,
> >>>                          return r;
> >>>                  }
> >>>          }
> >>> +       if (domain =3D=3D RADEON_GEM_DOMAIN_VRAM &&
> robj->prime_shared_count)
> >>> {
> >>> +               /* A BO that is associated with a dma-buf cannot be
> >>> sensibly migrated to VRAM */
> >>> +               return -EINVAL;
> >>> +       }
> >>>          return 0;
> >>>    }
> >>>    diff --git a/drivers/gpu/drm/radeon/radeon_object.c
> >>> b/drivers/gpu/drm/radeon/radeon_object.c
> >>> index 74b276060c20..bec2ec056de4 100644
> >>> --- a/drivers/gpu/drm/radeon/radeon_object.c
> >>> +++ b/drivers/gpu/drm/radeon/radeon_object.c
> >>> @@ -352,6 +352,11 @@ int radeon_bo_pin_restricted(struct radeon_bo *b=
o,
> >>> u32 domain, u64 max_offset,
> >>>                  return 0;
> >>>          }
> >>> +       if (bo->prime_shared_count && domain =3D=3D
> RADEON_GEM_DOMAIN_VRAM) {
> >>> +               /* A BO shared as a dma-buf cannot be sensibly
> migrated to
> >>> VRAM */
> >>> +               return -EINVAL;
> >>> +       }
> >>> +
> >>>          radeon_ttm_placement_from_domain(bo, domain);
> >>>          for (i =3D 0; i < bo->placement.num_placement; i++) {
> >>>                  /* force to pin into visible video ram */
> >>
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>

--001a114315ee4395f0054c52b5f9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I also haven&#39;t tested it on hardware (all my=
 hardware seems to be supported by amdgpu), but the only times we touch pri=
me_shared_count are:<br></div>1) It&#39;s set to 1 in radeon_gem_prime_impo=
rt_sg_table. This shouldn&#39;t be called in the self-import case (and isn&=
#39;t, as far as I can tell), and<br></div>2) It&#39;s incremented in radeo=
n_gem_prime_pin, right after the bo is pinned to GTT, so cannot be migrated=
 to VRAM anyway (unless there&#39;s an unmatched radeon_bo_unpin call somew=
here else?).<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tu=
e, 4 Apr 2017 at 02:30 Christian K=C3=B6nig &lt;<a href=3D"mailto:deathsimp=
le-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">Am 03.04.2017 um 17:51 schrieb Alex Deucher:<br class=
=3D"gmail_msg">
&gt; On Mon, Apr 3, 2017 at 4:24 AM, Christian K=C3=B6nig &lt;<a href=3D"ma=
ilto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">deathsi=
mple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt; wrote:<br class=3D"gmail_msg">
&gt;&gt; Am 03.04.2017 um 05:35 schrieb <a href=3D"mailto:raof-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org" =
class=3D"gmail_msg" target=3D"_blank">raof-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org</a>:<br class=3D"gmai=
l_msg">
&gt;&gt;&gt; From: Christopher James Halse Rogers<br class=3D"gmail_msg">
&gt;&gt;&gt; &lt;<a href=3D"mailto:christopher.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" =
class=3D"gmail_msg" target=3D"_blank">christopher.halse.rogers-Z7WLFzj8eWPnSPmRt5Z81g@public.gmane.org=
m</a>&gt;<br class=3D"gmail_msg">
&gt;&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt;&gt; BOs shared via dma-buf, either imported or exported, cannot se=
nsibly be<br class=3D"gmail_msg">
&gt;&gt;&gt; migrated to VRAM<br class=3D"gmail_msg">
&gt;&gt;&gt; without breaking the dma-buf sharing. Refuse userspace request=
s to migrate<br class=3D"gmail_msg">
&gt;&gt;&gt; to VRAM,<br class=3D"gmail_msg">
&gt;&gt;&gt; ensure such BOs are not migrated during command submission, an=
d refuse to<br class=3D"gmail_msg">
&gt;&gt;&gt; pin them<br class=3D"gmail_msg">
&gt;&gt;&gt; to VRAM.<br class=3D"gmail_msg">
&gt;&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt;&gt; v2: Don&#39;t pin BOs in GTT. Instead, refuse to migrate BOs t=
o VRAM.<br class=3D"gmail_msg">
&gt;&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt;&gt; Signed-off-by: Christopher James Halse Rogers<br class=3D"gmai=
l_msg">
&gt;&gt;&gt; &lt;<a href=3D"mailto:christopher.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" =
class=3D"gmail_msg" target=3D"_blank">christopher.halse.rogers-Z7WLFzj8eWPnSPmRt5Z81g@public.gmane.org=
m</a>&gt;<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; Patches #4, #6 and this one (#7) are Reviewed-by: Christian K=C3=
=B6nig<br class=3D"gmail_msg">
&gt;&gt; &lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" class=3D"gmail_msg=
" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;.<br class=3D"gmail_msg=
">
&gt; Will this cause any issues with self sharing?=C2=A0 E.g., the standard=
 use<br class=3D"gmail_msg">
&gt; case with a single GPU and DRI3?<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
No, the code from amdgpu to count the number of times we really shared a<br=
 class=3D"gmail_msg">
BO with somebody was ported over to radeon as far as I can see.<br class=3D=
"gmail_msg">
<br class=3D"gmail_msg">
So that should work fine, but I haven&#39;t double checked or tested it.<br=
 class=3D"gmail_msg">
<br class=3D"gmail_msg">
Christian.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Alex<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt;&gt; ---<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/radeon/radeon_cs.c=C2=A0 =C2=A0 =
=C2=A0| 10 ++++++++++<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/radeon/radeon_gem.c=C2=A0 =C2=A0 =
|=C2=A0 4 ++++<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/radeon/radeon_object.c |=C2=A0 5 =
+++++<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 3 files changed, 19 insertions(+)<br class=3D"gma=
il_msg">
&gt;&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/radeon/radeon_cs.c<br class=3D"gm=
ail_msg">
&gt;&gt;&gt; b/drivers/gpu/drm/radeon/radeon_cs.c<br class=3D"gmail_msg">
&gt;&gt;&gt; index a8442f7196d6..df6b58c08544 100644<br class=3D"gmail_msg"=
>
&gt;&gt;&gt; --- a/drivers/gpu/drm/radeon/radeon_cs.c<br class=3D"gmail_msg=
">
&gt;&gt;&gt; +++ b/drivers/gpu/drm/radeon/radeon_cs.c<br class=3D"gmail_msg=
">
&gt;&gt;&gt; @@ -164,6 +164,16 @@ static int radeon_cs_parser_relocs(struct=
<br class=3D"gmail_msg">
&gt;&gt;&gt; radeon_cs_parser *p)<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;relocs[i].allowed_domains =3D domain;<br =
class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
}<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* Objects shared as dma-bufs cannot be moved to VRAM */<br class=3D"gmail_=
msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-=
&gt;relocs[i].robj-&gt;prime_shared_count) {<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;relocs[i].allowed_domains &amp;=3D<br class=
=3D"gmail_msg">
&gt;&gt;&gt; ~RADEON_GEM_DOMAIN_VRAM;<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (!p-&gt;relocs[i].allowed_domains) {<br class=3D=
"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;BO asso=
ciated with dma-buf<br class=3D"gmail_msg">
&gt;&gt;&gt; cannot &quot;<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&quot;be moved to VRAM\n&quot;);<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br clas=
s=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br c=
lass=3D"gmail_msg">
&gt;&gt;&gt; +<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
p-&gt;relocs[i].<a href=3D"http://tv.bo" rel=3D"noreferrer" class=3D"gmail_=
msg" target=3D"_blank">tv.bo</a> =3D &amp;p-&gt;relocs[i].robj-&gt;tbo;<br =
class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
p-&gt;relocs[i].tv.shared =3D !r-&gt;write_domain;<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 diff --git a/drivers/gpu/drm/radeon/radeon_gem.c<=
br class=3D"gmail_msg">
&gt;&gt;&gt; b/drivers/gpu/drm/radeon/radeon_gem.c<br class=3D"gmail_msg">
&gt;&gt;&gt; index 96683f5b2b1b..067ea7d7658a 100644<br class=3D"gmail_msg"=
>
&gt;&gt;&gt; --- a/drivers/gpu/drm/radeon/radeon_gem.c<br class=3D"gmail_ms=
g">
&gt;&gt;&gt; +++ b/drivers/gpu/drm/radeon/radeon_gem.c<br class=3D"gmail_ms=
g">
&gt;&gt;&gt; @@ -120,6 +120,10 @@ static int radeon_gem_set_domain(struct<b=
r class=3D"gmail_msg">
&gt;&gt;&gt; drm_gem_object *gobj,<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
}<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (domain =3D=3D RADEON_GEM_DOMAI=
N_VRAM &amp;&amp; robj-&gt;prime_shared_count)<br class=3D"gmail_msg">
&gt;&gt;&gt; {<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* A B=
O that is associated with a dma-buf cannot be<br class=3D"gmail_msg">
&gt;&gt;&gt; sensibly migrated to VRAM */<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 -EINVAL;<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br class=3D"gmail_=
msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 }<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 diff --git a/drivers/gpu/drm/radeon/radeon_object=
.c<br class=3D"gmail_msg">
&gt;&gt;&gt; b/drivers/gpu/drm/radeon/radeon_object.c<br class=3D"gmail_msg=
">
&gt;&gt;&gt; index 74b276060c20..bec2ec056de4 100644<br class=3D"gmail_msg"=
>
&gt;&gt;&gt; --- a/drivers/gpu/drm/radeon/radeon_object.c<br class=3D"gmail=
_msg">
&gt;&gt;&gt; +++ b/drivers/gpu/drm/radeon/radeon_object.c<br class=3D"gmail=
_msg">
&gt;&gt;&gt; @@ -352,6 +352,11 @@ int radeon_bo_pin_restricted(struct radeo=
n_bo *bo,<br class=3D"gmail_msg">
&gt;&gt;&gt; u32 domain, u64 max_offset,<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return 0;<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bo-&gt;prime_shared_count &amp=
;&amp; domain =3D=3D RADEON_GEM_DOMAIN_VRAM) {<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* A B=
O shared as a dma-buf cannot be sensibly migrated to<br class=3D"gmail_msg"=
>
&gt;&gt;&gt; VRAM */<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 -EINVAL;<br class=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt;&gt;&gt; +<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 radeon_ttm_placement_from_do=
main(bo, domain);<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; bo-&gt;=
placement.num_placement; i++) {<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* force to pin into visible video ram */<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; _______________________________________________<br class=3D"gmail_=
msg">
&gt;&gt; amd-gfx mailing list<br class=3D"gmail_msg">
&gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_ms=
g" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_ms=
g">
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.fre=
edesktop.org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
&gt; _______________________________________________<br class=3D"gmail_msg"=
>
&gt; amd-gfx mailing list<br class=3D"gmail_msg">
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" t=
arget=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_msg">
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
</blockquote></div>

--001a114315ee4395f0054c52b5f9--

--===============0881929291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0881929291==--
