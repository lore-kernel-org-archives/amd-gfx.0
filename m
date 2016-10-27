From: Mike Lothian <mike@fireburn.co.uk>
Subject: Re: [PATCH] drm/i915: Before pageflip,
 also wait for shared dmabuf fences.
Date: Thu, 27 Oct 2016 13:33:47 +0000
Message-ID: <CAHbf0-GGMWZrhB+PKpc-QbD__6fqB4pQVFfN+gzLWNhi+DuG3Q@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1127761413=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <e92512c7-4fb5-6fa1-e93f-0322d1537c46@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>, Daniel Vetter <daniel@ffwll.ch>
Cc: Nayan Deshmukh <nayan26deshmukh@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1127761413==
Content-Type: multipart/alternative; boundary=001a11443c3a34aeab053fd8cb26

--001a11443c3a34aeab053fd8cb26
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

Just another gentle ping to see where you are with this?

Cheers

Mike

On Wed, 12 Oct 2016 at 01:40 Michel D=C3=A4nzer <michel@daenzer.net> wrote:

> On 11/10/16 09:04 PM, Christian K=C3=B6nig wrote:
> > Am 11.10.2016 um 05:58 schrieb Michel D=C3=A4nzer:
> >> On 07/10/16 09:34 PM, Mike Lothian wrote:
> >>> This has discussion has gone a little quiet
> >>>
> >>> Was there any agreement about what needed doing to get this working
> >>> for i965/amdgpu?
> >> Christian, do you see anything which could prevent the solution I
> >> outlined from working?
> >
> > I thought about that approach as well, but unfortunately it also has a
> > couple of downsides. Especially keeping the exclusive fence set while w=
e
> > actually don't need it isn't really clean either.
>
> I was wondering if it's possible to have a singleton pseudo exclusive
> fence which is used for all BOs. That might keep the overhead acceptably
> low.
>
>
> > I'm currently a bit busy with other tasks and so put Nayan on a road to
> > get a bit into the kernel driver (he asked for that anyway).
> >
> > Implementing the simple workaround to sync when we export the DMA-buf
> > should be something like 20 lines of code and fortunately Nayan has an
> > I+A system and so can actually test it.
> >
> > If it turns out to be more problematic or somebody really starts to nee=
d
> > it I'm going to hack on that myself a bit more.
>
> If you mean only syncing when a DMA-buf is exported, that's not enough,
> as I explained before. The BOs being shared are long-lived, and
> synchronization between GPUs is required for every command stream
> submission.
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--001a11443c3a34aeab053fd8cb26
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>Just another gentle ping to see wher=
e you are with this?</div><div><br></div><div>Cheers</div><div><br></div><d=
iv>Mike</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, =
12 Oct 2016 at 01:40 Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel@daenze=
r.net">michel@daenzer.net</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">On 11/10/16 09:04 PM, Christian K=C3=B6nig wrote:<br class=3D"gmail_m=
sg">
&gt; Am 11.10.2016 um 05:58 schrieb Michel D=C3=A4nzer:<br class=3D"gmail_m=
sg">
&gt;&gt; On 07/10/16 09:34 PM, Mike Lothian wrote:<br class=3D"gmail_msg">
&gt;&gt;&gt; This has discussion has gone a little quiet<br class=3D"gmail_=
msg">
&gt;&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt;&gt; Was there any agreement about what needed doing to get this wo=
rking<br class=3D"gmail_msg">
&gt;&gt;&gt; for i965/amdgpu?<br class=3D"gmail_msg">
&gt;&gt; Christian, do you see anything which could prevent the solution I<=
br class=3D"gmail_msg">
&gt;&gt; outlined from working?<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; I thought about that approach as well, but unfortunately it also has a=
<br class=3D"gmail_msg">
&gt; couple of downsides. Especially keeping the exclusive fence set while =
we<br class=3D"gmail_msg">
&gt; actually don&#39;t need it isn&#39;t really clean either.<br class=3D"=
gmail_msg">
<br class=3D"gmail_msg">
I was wondering if it&#39;s possible to have a singleton pseudo exclusive<b=
r class=3D"gmail_msg">
fence which is used for all BOs. That might keep the overhead acceptably<br=
 class=3D"gmail_msg">
low.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt; I&#39;m currently a bit busy with other tasks and so put Nayan on a ro=
ad to<br class=3D"gmail_msg">
&gt; get a bit into the kernel driver (he asked for that anyway).<br class=
=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Implementing the simple workaround to sync when we export the DMA-buf<=
br class=3D"gmail_msg">
&gt; should be something like 20 lines of code and fortunately Nayan has an=
<br class=3D"gmail_msg">
&gt; I+A system and so can actually test it.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; If it turns out to be more problematic or somebody really starts to ne=
ed<br class=3D"gmail_msg">
&gt; it I&#39;m going to hack on that myself a bit more.<br class=3D"gmail_=
msg">
<br class=3D"gmail_msg">
If you mean only syncing when a DMA-buf is exported, that&#39;s not enough,=
<br class=3D"gmail_msg">
as I explained before. The BOs being shared are long-lived, and<br class=3D=
"gmail_msg">
synchronization between GPUs is required for every command stream<br class=
=3D"gmail_msg">
submission.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
--<br class=3D"gmail_msg">
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_b=
lank">http://www.amd.com</a><br class=3D"gmail_msg">
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br cla=
ss=3D"gmail_msg">
</blockquote></div>

--001a11443c3a34aeab053fd8cb26--

--===============1127761413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1127761413==--
