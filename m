From: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Tue, 11 Jul 2017 12:44:32 -0700
Message-ID: <CAOFGe966V=urjgObfUcofwsvSt78t4o_QGP5ix-AiPOGN1iaQA@mail.gmail.com>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
 <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
 <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ@mail.gmail.com>
 <fe27d2f8-760b-c2d4-9474-7eaaae560086@vodafone.de>
 <CAOFGe95oZz-O743v7J6gpVuUqvPjdeifAcuoaZe8bf1HUNXm+Q@mail.gmail.com>
 <20170711072110.oziftm34o54plbvv@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2033640899=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170711072110.oziftm34o54plbvv-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2033640899==
Content-Type: multipart/alternative; boundary="001a11497fe2bbc9bf05540fed2c"

--001a11497fe2bbc9bf05540fed2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 12:22 AM, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org> wrote:

> On Mon, Jul 10, 2017 at 02:09:42PM -0700, Jason Ekstrand wrote:
> > On Mon, Jul 10, 2017 at 9:15 AM, Christian K=C3=B6nig <
> deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> > wrote:
> >
> > > Am 10.07.2017 um 17:52 schrieb Jason Ekstrand:
> > >
> > > On Mon, Jul 10, 2017 at 8:45 AM, Christian K=C3=B6nig <
> deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> > > wrote:
> > >
> > >> Am 10.07.2017 um 17:28 schrieb Jason Ekstrand:
> > >>
> > >> On Wed, Jul 5, 2017 at 6:04 PM, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > >> [SNIP]
> > >> So, reading some CTS tests again, and I think we have a problem here=
.
> > >> The Vulkan spec allows you to wait on a fence that is in the
> unsignaled
> > >> state.
> > >>
> > >>
> > >> At least on the closed source driver that would be illegal as far as=
 I
> > >> know.
> > >>
> > >
> > > Then they are doing workarounds in userspace.  There are definitely C=
TS
> > > tests for this:
> > >
> > > https://github.com/KhronosGroup/VK-GL-CTS/blob/
> master/external/vulkancts/
> > > modules/vulkan/synchronization/vktSynchronizationBasicFenceTe
> sts.cpp#L74
> > >
> > >
> > >> You can't wait on a semaphore before the signal operation is send
> down to
> > >> the kerel.
> > >>
> > >
> > > We (Intel) deal with this today by tracking whether or not the fence
> has
> > > been submitted and using a condition variable in userspace to sort it
> all
> > > out.
> > >
> > >
> > > Which sounds exactly like what AMD is doing in it's drivers as well.
> > >
> >
> > Which doesn't work cross-process so...
> >
> > > If we ever want to share fences across processes (which we do), then
> this
> > > needs to be sorted in the kernel.
> > >
> > >
> > > That would clearly get a NAK from my side, even Microsoft forbids wai=
t
> > > before signal because you can easily end up in deadlock situations.
> > >
> >
> > Please don't NAK things that are required by the API specification and
> CTS
> > tests.  That makes it very hard for people like me to get their jobs
> done.
> > :-)
> >
> > Now, as for whether or not it's a good idea.  First off, we do have
> > timeouts an a status querying mechanism so an application can just set =
a
> > timeout of 1s and do something if it times out.  Second, if the
> application
> > is a compositor or something else that doesn't trust its client, it
> > shouldn't be using the OPAQUE_FD mechanism of Vulkan semaphore/fence
> > sharing anyway.  For those scenarios, they can require the untrusted
> client
> > to use FENCE_FD (sync file) and they have all of the usual guarantees
> about
> > when the work got submitted, etc.
> >
> > Also, I'm more than happy to put this all behind a flag so it's not the
> > default behavior.
>
> Android had a similar requirement to have a fence fd before the fence
> existed in hwc1, before they fixed that in hwc2. But it's probably still
> useful for deeply pipelined renderes with littel memory, aka tiled
> renderers on phones.
>
> The idea we've tossed around is to create a so-called future fence. In th=
e
> kernel if you try to deref a future fence, the usual thing that happens i=
s
> you'll block (interruptibly, which we can because fence lookup might
> fail), _until_ a real fence shows up and can be returned. That implements
> the uapi expectations without risking deadlocks in the kernel, albeit wit=
h
> a bit much blocking. Still better than doing the same in userspace (since
> in userspace you probably need to do that when importing the fence, not a=
t
> execbuf time).
>

Yes, I'm aware of the future fence idea.  However, that's not really all
that related.  We're not talking about blocking GPU work here.  We're
talking about the CPU wait API having support for "wait for submit and
signal" behavior instead of just "wait for signal".

--001a11497fe2bbc9bf05540fed2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Jul 11, 2017 at 12:22 AM, Daniel Vetter <span dir=3D"ltr">&lt;<a href=
=3D"mailto:daniel-/w4YWyX8dFk@public.gmane.org" target=3D"_blank">daniel-/w4YWyX8dFk@public.gmane.org</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=
=3D"h5">On Mon, Jul 10, 2017 at 02:09:42PM -0700, Jason Ekstrand wrote:<br>
&gt; On Mon, Jul 10, 2017 at 9:15 AM, Christian K=C3=B6nig &lt;<a href=3D"m=
ailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt; Am 10.07.2017 um 17:52 schrieb Jason Ekstrand:<br>
&gt; &gt;<br>
&gt; &gt; On Mon, Jul 10, 2017 at 8:45 AM, Christian K=C3=B6nig &lt;<a href=
=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; Am 10.07.2017 um 17:28 schrieb Jason Ekstrand:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Wed, Jul 5, 2017 at 6:04 PM, Dave Airlie &lt;<a href=3D"ma=
ilto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt; [SNIP]<br>
&gt; &gt;&gt; So, reading some CTS tests again, and I think we have a probl=
em here.<br>
&gt; &gt;&gt; The Vulkan spec allows you to wait on a fence that is in the =
unsignaled<br>
&gt; &gt;&gt; state.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; At least on the closed source driver that would be illegal as=
 far as I<br>
&gt; &gt;&gt; know.<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Then they are doing workarounds in userspace.=C2=A0 There are def=
initely CTS<br>
&gt; &gt; tests for this:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://github.com/KhronosGroup/VK-GL-CTS/blob/master/=
external/vulkancts/" rel=3D"noreferrer" target=3D"_blank">https://github.co=
m/<wbr>KhronosGroup/VK-GL-CTS/blob/<wbr>master/external/vulkancts/</a><br>
&gt; &gt; modules/vulkan/<wbr>synchronization/<wbr>vktSynchronizationBasicF=
enceTe<wbr>sts.cpp#L74<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; You can&#39;t wait on a semaphore before the signal operation=
 is send down to<br>
&gt; &gt;&gt; the kerel.<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; We (Intel) deal with this today by tracking whether or not the fe=
nce has<br>
&gt; &gt; been submitted and using a condition variable in userspace to sor=
t it all<br>
&gt; &gt; out.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Which sounds exactly like what AMD is doing in it&#39;s drivers a=
s well.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Which doesn&#39;t work cross-process so...<br>
&gt;<br>
&gt; &gt; If we ever want to share fences across processes (which we do), t=
hen this<br>
&gt; &gt; needs to be sorted in the kernel.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; That would clearly get a NAK from my side, even Microsoft forbids=
 wait<br>
&gt; &gt; before signal because you can easily end up in deadlock situation=
s.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Please don&#39;t NAK things that are required by the API specification=
 and CTS<br>
&gt; tests.=C2=A0 That makes it very hard for people like me to get their j=
obs done.<br>
&gt; :-)<br>
&gt;<br>
&gt; Now, as for whether or not it&#39;s a good idea.=C2=A0 First off, we d=
o have<br>
&gt; timeouts an a status querying mechanism so an application can just set=
 a<br>
&gt; timeout of 1s and do something if it times out.=C2=A0 Second, if the a=
pplication<br>
&gt; is a compositor or something else that doesn&#39;t trust its client, i=
t<br>
&gt; shouldn&#39;t be using the OPAQUE_FD mechanism of Vulkan semaphore/fen=
ce<br>
&gt; sharing anyway.=C2=A0 For those scenarios, they can require the untrus=
ted client<br>
&gt; to use FENCE_FD (sync file) and they have all of the usual guarantees =
about<br>
&gt; when the work got submitted, etc.<br>
&gt;<br>
&gt; Also, I&#39;m more than happy to put this all behind a flag so it&#39;=
s not the<br>
&gt; default behavior.<br>
<br>
</div></div>Android had a similar requirement to have a fence fd before the=
 fence<br>
existed in hwc1, before they fixed that in hwc2. But it&#39;s probably stil=
l<br>
useful for deeply pipelined renderes with littel memory, aka tiled<br>
renderers on phones.<br>
<br>
The idea we&#39;ve tossed around is to create a so-called future fence. In =
the<br>
kernel if you try to deref a future fence, the usual thing that happens is<=
br>
you&#39;ll block (interruptibly, which we can because fence lookup might<br=
>
fail), _until_ a real fence shows up and can be returned. That implements<b=
r>
the uapi expectations without risking deadlocks in the kernel, albeit with<=
br>
a bit much blocking. Still better than doing the same in userspace (since<b=
r>
in userspace you probably need to do that when importing the fence, not at<=
br>
execbuf time).<span class=3D"HOEnZb"><font color=3D"#888888"><br>
</font></span></blockquote></div><br></div><div class=3D"gmail_extra">Yes, =
I&#39;m aware of the future fence idea.=C2=A0 However, that&#39;s not reall=
y all that related.=C2=A0 We&#39;re not talking about blocking GPU work her=
e.=C2=A0 We&#39;re talking about the CPU wait API having support for &quot;=
wait for submit and signal&quot; behavior instead of just &quot;wait for si=
gnal&quot;.<br></div></div>

--001a11497fe2bbc9bf05540fed2c--

--===============2033640899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2033640899==--
