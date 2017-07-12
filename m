From: Jason Ekstrand <jason@jlekstrand.net>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Wed, 12 Jul 2017 08:53:55 -0700
Message-ID: <CAOFGe95mj1G_Ap0oOPFyatZWEbEk_Kwo8Wn_E+eYS16Nhz_huQ@mail.gmail.com>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
 <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
 <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ@mail.gmail.com>
 <fe27d2f8-760b-c2d4-9474-7eaaae560086@vodafone.de>
 <CAOFGe95oZz-O743v7J6gpVuUqvPjdeifAcuoaZe8bf1HUNXm+Q@mail.gmail.com>
 <0c81dd81-e84a-2381-3ce1-e08450929da8@daenzer.net>
 <c7a44542-acca-09e1-5ea5-bf9938921e54@vodafone.de>
 <CAOFGe95cnFJCEAO6k8emWFWaAZdMPrdHjQos02peuWe6Ve1wvw@mail.gmail.com>
 <2a0f44cc-b893-153c-9852-b1b4855e386e@vodafone.de>
 <CAPM=9twkH4H0Buxpb7nKAMawNxouWCombhfAh++pNpSZNMLRow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1467814648=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAPM=9twkH4H0Buxpb7nKAMawNxouWCombhfAh++pNpSZNMLRow@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1467814648==
Content-Type: multipart/alternative; boundary="94eb2c0df180d5c9d2055420d270"

--94eb2c0df180d5c9d2055420d270
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 1:39 AM, Dave Airlie <airlied@gmail.com> wrote:

> On 12 July 2017 at 17:39, Christian K=C3=B6nig <deathsimple@vodafone.de> =
wrote:
> > Am 11.07.2017 um 17:43 schrieb Jason Ekstrand:
> >
> > On Tue, Jul 11, 2017 at 12:17 AM, Christian K=C3=B6nig <
> deathsimple@vodafone.de>
> > wrote:
> >>
> >> [SNIP]
> >>>>>
> >>>>>      If we ever want to share fences across processes (which we do)=
,
> >>>>>      then this needs to be sorted in the kernel.
> >>>>
> >>>>      That would clearly get a NAK from my side, even Microsoft forbi=
ds
> >>>>      wait before signal because you can easily end up in deadlock
> >>>> situations.
> >>>>
> >>>> Please don't NAK things that are required by the API specification a=
nd
> >>>> CTS tests.
> >>>
> >>> There is no requirement for every aspect of the Vulkan API
> specification
> >>> to be mirrored 1:1 in the kernel <-> userspace API. We have to work o=
ut
> >>> what makes sense at each level.
> >>
> >>
> >> Exactly, if we have a synchronization problem between two processes th=
at
> >> should be solved in userspace.
> >>
> >> E.g. if process A hasn't submitted it's work to the kernel it should
> flush
> >> it's commands before sending a flip event to the compositor.
> >
> >
> > Ok, I think there is some confusion here on what is being proposed.  He=
re
> > are some things that are *not* being proposed:
> >
> >  1. This does *not* allow a client to block another client's GPU work
> > indefinitely.  This is entirely for a CPU wait API to allow for a "wait
> for
> > submit" as well as a "wait for finish".
> >
> > Yeah, that is a rather good point.
> >
> >  2. This is *not* for system compositors that need to be robust against
> > malicious clients.
> >
> > I can see the point, but I think the kernel interface should still be
> idiot
> > prove even in the unlikely case the universe suddenly stops to produce
> > idiots.
>

Fair enough.  Maybe I've spent too much time in the Vulkan world where
being an idiot is, theoretically, disallowed.  And, by "disallowed", I mean
that you're free to be one with the understanding that your process may get
straight-up killed on *any* API violation.


> > The expected use for the OPAQUE_FD is two very tightly integrated
> processes
> > which trust each other but need to be able to share synchronization
> > primitives.
> >
> > Well, that raises a really important question: What is the actual use
> case
> > for this if not communication between client and compositor?
>
> VR clients and compositors.
>

Yeah, that.  Wouldn't they want the same security guarantees as your OS
compositor?  One would think, but none of the people making VR compositors
seem to care all that much about the case of malicious clients.  In
general, they run a fairly closed platform where they aren't really running
"arbitrary" apps on their compositor.  Also, they tend to write both the
client and server sides of the VR compositor protocol and the only thing
the app touches is their API.  I'm not going to try too hard to justify
their lack of concern about deadlock, but there it is.


> > Could we do this "in userspace"?  Yes, with added kernel API.  we would
> need
> > some way of strapping a second FD onto a syncobj or combining two FDs
> into
> > one to send across the wire or something like that, then add a shared
> memory
> > segment, and then pile on a bunch of code to do cross-process condition
> > variables and state tracking.  I really don't see how that's a better
> > solution than adding a flag to the kernel API to just do what we want.
> >
> > Way to complicated.
> >
> > My thinking was rather to optionally allow a single page to be mmap()ed
> into
> > the process address space from the fd and then put a futex, pthread_con=
d
> or
> > X shared memory fence or anything like that into it.
>

A single page + fence sounds a lot like a DRM BO.  One of my original plans
for implementing the feature was to just use a single-page BO and do some
userspace stuff in the mapped page.  There are two problems here:

1) It could be very easy for a malicious client to map the page and then
mess up whatever CPU data structure I use for the semaphore.  I could
probably make it robust but there is an attack vector there that's going to
be tricky.
2) I have no way, on import, to tell the difference between a 4K memory
object and a fence.

Then syncobj came along and promised to solve all my problems...


> Is that easier than just waiting in the kernel, I'm not sure how
> optimised we need this path to be.
>

I don't think so.  I think it's more-or-less the same code regardless of
how it's done.  The advantage of doing it in the kernel is that it's
standardized (we don't have to both go write that userspace code) and it
doesn't have the problems stated above.

--94eb2c0df180d5c9d2055420d270
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Jul 12, 2017 at 1:39 AM, Dave Airlie <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:airlied@gmail.com" target=3D"_blank">airlied@gmail.com</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=
=3D"h5">On 12 July 2017 at 17:39, Christian K=C3=B6nig &lt;<a href=3D"mailt=
o:deathsimple@vodafone.de">deathsimple@vodafone.de</a>&gt; wrote:<br>
&gt; Am 11.07.2017 um 17:43 schrieb Jason Ekstrand:<br>
&gt;<br>
&gt; On Tue, Jul 11, 2017 at 12:17 AM, Christian K=C3=B6nig &lt;<a href=3D"=
mailto:deathsimple@vodafone.de">deathsimple@vodafone.de</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; [SNIP]<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 If we ever want to share fences ac=
ross processes (which we do),<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 then this needs to be sorted in th=
e kernel.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 That would clearly get a NAK from my s=
ide, even Microsoft forbids<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 wait before signal because you can eas=
ily end up in deadlock<br>
&gt;&gt;&gt;&gt; situations.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Please don&#39;t NAK things that are required by the API s=
pecification and<br>
&gt;&gt;&gt;&gt; CTS tests.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; There is no requirement for every aspect of the Vulkan API spe=
cification<br>
&gt;&gt;&gt; to be mirrored 1:1 in the kernel &lt;-&gt; userspace API. We h=
ave to work out<br>
&gt;&gt;&gt; what makes sense at each level.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Exactly, if we have a synchronization problem between two processe=
s that<br>
&gt;&gt; should be solved in userspace.<br>
&gt;&gt;<br>
&gt;&gt; E.g. if process A hasn&#39;t submitted it&#39;s work to the kernel=
 it should flush<br>
&gt;&gt; it&#39;s commands before sending a flip event to the compositor.<b=
r>
&gt;<br>
&gt;<br>
&gt; Ok, I think there is some confusion here on what is being proposed.=C2=
=A0 Here<br>
&gt; are some things that are *not* being proposed:<br>
&gt;<br>
&gt;=C2=A0 1. This does *not* allow a client to block another client&#39;s =
GPU work<br>
&gt; indefinitely.=C2=A0 This is entirely for a CPU wait API to allow for a=
 &quot;wait for<br>
&gt; submit&quot; as well as a &quot;wait for finish&quot;.<br>
&gt;<br>
&gt; Yeah, that is a rather good point.<br>
&gt;<br>
&gt;=C2=A0 2. This is *not* for system compositors that need to be robust a=
gainst<br>
&gt; malicious clients.<br>
&gt;<br>
&gt; I can see the point, but I think the kernel interface should still be =
idiot<br>
&gt; prove even in the unlikely case the universe suddenly stops to produce=
<br>
&gt; idiots.<br></div></div></blockquote><div><br></div><div>Fair enough.=
=C2=A0 Maybe I&#39;ve spent too much time in the Vulkan world where being a=
n idiot is, theoretically, disallowed.=C2=A0 And, by &quot;disallowed&quot;=
, I mean that you&#39;re free to be one with the understanding that your pr=
ocess may get straight-up killed on *any* API violation.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D=
"h5">
&gt; The expected use for the OPAQUE_FD is two very tightly integrated proc=
esses<br>
&gt; which trust each other but need to be able to share synchronization<br=
>
&gt; primitives.<br>
&gt;<br>
&gt; Well, that raises a really important question: What is the actual use =
case<br>
&gt; for this if not communication between client and compositor?<br>
<br>
</div></div>VR clients and compositors.<span class=3D""><br></span></blockq=
uote><div><br></div><div>Yeah, that.=C2=A0 Wouldn&#39;t they want the same =
security guarantees as your OS compositor?=C2=A0 One would think, but none =
of the people making VR compositors seem to care all that much about the ca=
se of malicious clients.=C2=A0 In general, they run a fairly closed platfor=
m where they aren&#39;t really running &quot;arbitrary&quot; apps on their =
compositor.=C2=A0 Also, they tend to write both the client and server sides=
 of the VR compositor protocol and the only thing the app touches is their =
API.=C2=A0 I&#39;m not going to try too hard to justify their lack of conce=
rn about deadlock, but there it is.<br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><span class=3D"">
&gt; Could we do this &quot;in userspace&quot;?=C2=A0 Yes, with added kerne=
l API.=C2=A0 we would need<br>
&gt; some way of strapping a second FD onto a syncobj or combining two FDs =
into<br>
&gt; one to send across the wire or something like that, then add a shared =
memory<br>
&gt; segment, and then pile on a bunch of code to do cross-process conditio=
n<br>
&gt; variables and state tracking.=C2=A0 I really don&#39;t see how that&#3=
9;s a better<br>
&gt; solution than adding a flag to the kernel API to just do what we want.=
<br>
&gt;<br>
&gt; Way to complicated.<br>
&gt;<br>
&gt; My thinking was rather to optionally allow a single page to be mmap()e=
d into<br>
&gt; the process address space from the fd and then put a futex, pthread_co=
nd or<br>
&gt; X shared memory fence or anything like that into it.<br></span></block=
quote><div><br></div><div>A single page + fence sounds a lot like a DRM BO.=
=C2=A0 One of my original plans for implementing the feature was to just us=
e a single-page BO and do some userspace stuff in the mapped page.=C2=A0 Th=
ere are two problems here:<br><br>1) It could be very easy for a malicious =
client to map the page and then mess up whatever CPU data structure I use f=
or the semaphore.=C2=A0 I could probably make it robust but there is an att=
ack vector there that&#39;s going to be tricky.<br>2) I have no way, on imp=
ort, to tell the difference between a 4K memory object and a fence.<br><br>=
Then syncobj came along and promised to solve all my problems...<br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">
</span>Is that easier than just waiting in the kernel, I&#39;m not sure how=
<br>
optimised we need this path to be.<span class=3D"HOEnZb"><font color=3D"#88=
8888"><br>
</font></span></blockquote></div><br></div><div class=3D"gmail_extra">I don=
&#39;t think so.=C2=A0 I think it&#39;s more-or-less the same code regardle=
ss of how it&#39;s done.=C2=A0 The advantage of doing it in the kernel is t=
hat it&#39;s standardized (we don&#39;t have to both go write that userspac=
e code) and it doesn&#39;t have the problems stated above.<br></div></div>

--94eb2c0df180d5c9d2055420d270--

--===============1467814648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1467814648==--
