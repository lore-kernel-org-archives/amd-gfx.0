From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] drm/i915: Before pageflip,
 also wait for shared dmabuf fences.
Date: Sat, 29 Oct 2016 13:58:27 +0000
Message-ID: <CAHbf0-EY2OM_HgxTjmMi4-f5TQ8fkqf5XYBxHZtJVsnSpxPyyA@mail.gmail.com>
References: <3f4643cb-52a9-d7ae-439b-5f6fc6e718cc@vodafone.de>
 <20160922063625.GD22164@dvetter-linux.ger.corp.intel.com>
 <b95726e7-6bf6-a1b8-2a63-0758b1b185e2@vodafone.de>
 <CAKMK7uF13M7d8qRRwKs_8M-QHjnuB7k3jshTUDnccTTQf6unog@mail.gmail.com>
 <ddf99e2a-5f9a-41b9-9fde-af7bfd522572@vodafone.de>
 <CAKMK7uEidoKbTO-m3KSz8UmQhF+uorg2-cWY8UpOXjZ_9MCxLg@mail.gmail.com>
 <d2430ff8-43bd-bff2-9b02-847cabfd56c0@vodafone.de>
 <ed1a57a4-1409-6d07-998a-2b54f466f710@daenzer.net>
 <20160923120954.GH22164@dvetter-linux.ger.corp.intel.com>
 <8c21f70a-7f96-480e-9784-93f2d48f52bb@daenzer.net>
 <20160926080419.GV20761@phenom.ffwll.local>
 <CAHbf0-HZ6EotqwgvkxRTdRF97xB3qBA=DRKAzaAXguV_PR_P8w@mail.gmail.com>
 <d74d34a7-5221-d282-d9d1-b0e1007fc0c7@daenzer.net>
 <c77a2cb9-1f0e-f1a3-aedd-a111cd6ba8e8@vodafone.de>
 <e92512c7-4fb5-6fa1-e93f-0322d1537c46@daenzer.net>
 <CAHbf0-GGMWZrhB+PKpc-QbD__6fqB4pQVFfN+gzLWNhi+DuG3Q@mail.gmail.com>
 <720351a2-7597-aee3-58ce-9d65cad5762f@daenzer.net>
 <7eb19a73-a558-d2e6-bd8d-34fe95045dfd@gmail.com>
 <CAHbf0-H0owRAp_VXWd84E03OiPKXSE0jZ1=+OAtvoKuoSyt_=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0360916782=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHbf0-H0owRAp_VXWd84E03OiPKXSE0jZ1=+OAtvoKuoSyt_=A@mail.gmail.com>
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
To: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0360916782==
Content-Type: multipart/alternative; boundary=001a113677f41ce5f50540015f19

--001a113677f41ce5f50540015f19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I turned on vsync and everything works great in tomb raider

:D

Thanks again to everyone who made this possible

On Fri, 28 Oct 2016 at 19:37 Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org> wrote:

> Hi Mario
>
> That fixes the tearing, it's been replaced with a strange stutter, like
> it's only showing half the number of frames being reported - it's really
> noticeable in tomb raider
>
> Thanks for your work on this, the stutter is much more manageable than th=
e
> tearing was
>
> I've attached the patch that applies cleanly to 4.10-wip
>
>
>
> On Fri, 28 Oct 2016 at 18:37 Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
>
>
>
> On 10/28/2016 03:34 AM, Michel D=C3=A4nzer wrote:
> > On 27/10/16 10:33 PM, Mike Lothian wrote:
> >>
> >> Just another gentle ping to see where you are with this?
> >
> > I haven't got a chance to look into this any further.
> >
> >
>
> Fwiw., as a proof of concept, the attached experimental patch does work
> as tested on Intel HD Haswell + AMD R9 380 Tonga under amdgpu and
> DRI3/Present when applied to drm-next (updated from a few days ago).
> With DRI_PRIME=3D1 tearing for page-flipped fullscreen windows is gone
> under all loads. The tearing with "windowed" windows now looks as
> expected for regular tearing not related to Prime.
>
> ftrace confirms the i915 driver's pageflip function is waiting on the
> fence in reservation_object_wait_timeout_rcu() as it should.
>
> That entry->tv.shared needs to be set false for such buffers in
> amdgpu_bo_list_set() makes sense to me, as that is part of the buffer
> validation for command stream submission. There are other places in the
> driver where tv.shared is set, which i didn't check so far.
>
> I don't know which of these would need to be updated with a "exported
> bo" check as well, e.g., for video decoding or maybe gpu compute? Adding
> or removing the check to amdgpu_gem_va_update_vm(), e.g., made no
> difference. I assume that makes sense because that functions seems to
> deal with amdgpu internal vm page tables or page table entries for such
> a bo, not with something visible to external clients?
>
> All i can say is it fixes 3D rendering under DRI3 + Prime + pageflipping
> without causing any obvious new problems.
>
> -mario
>
>

--001a113677f41ce5f50540015f19
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I turned on vsync and everything works great in tomb raide=
r<div><br></div><div>:D</div><div><br></div><div>Thanks again to everyone w=
ho made this possible</div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr">On Fri, 28 Oct 2016 at 19:37 Mike Lothian &lt;<a href=3D"mailto:mike@=
fireburn.co.uk">mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div dir=3D"ltr" class=3D"gmail_msg">Hi Mario<div class=3D"=
gmail_msg"><br class=3D"gmail_msg"></div><div class=3D"gmail_msg">That fixe=
s the tearing, it&#39;s been replaced with a strange stutter, like it&#39;s=
 only showing half the number of frames being reported - it&#39;s really no=
ticeable in tomb raider</div><div class=3D"gmail_msg"><br class=3D"gmail_ms=
g"></div><div class=3D"gmail_msg">Thanks for your work on this, the stutter=
 is much more manageable than the tearing was</div><div class=3D"gmail_msg"=
><br class=3D"gmail_msg"></div><div class=3D"gmail_msg">I&#39;ve attached t=
he patch that applies cleanly to 4.10-wip</div></div><div dir=3D"ltr" class=
=3D"gmail_msg"><div class=3D"gmail_msg"><br class=3D"gmail_msg"></div><div =
class=3D"gmail_msg">=C2=A0<br class=3D"gmail_msg"><br class=3D"gmail_msg"><=
div class=3D"gmail_quote gmail_msg"><div dir=3D"ltr" class=3D"gmail_msg">On=
 Fri, 28 Oct 2016 at 18:37 Mario Kleiner &lt;<a href=3D"mailto:mario.kleine=
r.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">mario.kleiner.de@gmai=
l.com</a>&gt; wrote:<br class=3D"gmail_msg"></div><blockquote class=3D"gmai=
l_quote gmail_msg" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><br class=3D"gmail_msg">
<br class=3D"gmail_msg">
On 10/28/2016 03:34 AM, Michel D=C3=A4nzer wrote:<br class=3D"gmail_msg">
&gt; On 27/10/16 10:33 PM, Mike Lothian wrote:<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; Just another gentle ping to see where you are with this?<br class=
=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; I haven&#39;t got a chance to look into this any further.<br class=3D"=
gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Fwiw., as a proof of concept, the attached experimental patch does work<br =
class=3D"gmail_msg">
as tested on Intel HD Haswell + AMD R9 380 Tonga under amdgpu and<br class=
=3D"gmail_msg">
DRI3/Present when applied to drm-next (updated from a few days ago).<br cla=
ss=3D"gmail_msg">
With DRI_PRIME=3D1 tearing for page-flipped fullscreen windows is gone<br c=
lass=3D"gmail_msg">
under all loads. The tearing with &quot;windowed&quot; windows now looks as=
<br class=3D"gmail_msg">
expected for regular tearing not related to Prime.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
ftrace confirms the i915 driver&#39;s pageflip function is waiting on the<b=
r class=3D"gmail_msg">
fence in reservation_object_wait_timeout_rcu() as it should.<br class=3D"gm=
ail_msg">
<br class=3D"gmail_msg">
That entry-&gt;tv.shared needs to be set false for such buffers in<br class=
=3D"gmail_msg">
amdgpu_bo_list_set() makes sense to me, as that is part of the buffer<br cl=
ass=3D"gmail_msg">
validation for command stream submission. There are other places in the<br =
class=3D"gmail_msg">
driver where tv.shared is set, which i didn&#39;t check so far.<br class=3D=
"gmail_msg">
<br class=3D"gmail_msg">
I don&#39;t know which of these would need to be updated with a &quot;expor=
ted<br class=3D"gmail_msg">
bo&quot; check as well, e.g., for video decoding or maybe gpu compute? Addi=
ng<br class=3D"gmail_msg">
or removing the check to amdgpu_gem_va_update_vm(), e.g., made no<br class=
=3D"gmail_msg">
difference. I assume that makes sense because that functions seems to<br cl=
ass=3D"gmail_msg">
deal with amdgpu internal vm page tables or page table entries for such<br =
class=3D"gmail_msg">
a bo, not with something visible to external clients?<br class=3D"gmail_msg=
">
<br class=3D"gmail_msg">
All i can say is it fixes 3D rendering under DRI3 + Prime + pageflipping<br=
 class=3D"gmail_msg">
without causing any obvious new problems.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-mario<br class=3D"gmail_msg">
</blockquote></div></div></div></blockquote></div>

--001a113677f41ce5f50540015f19--

--===============0360916782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0360916782==--
