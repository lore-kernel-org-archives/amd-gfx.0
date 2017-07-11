From: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Tue, 11 Jul 2017 08:43:23 -0700
Message-ID: <CAOFGe95cnFJCEAO6k8emWFWaAZdMPrdHjQos02peuWe6Ve1wvw@mail.gmail.com>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
 <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
 <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ@mail.gmail.com>
 <fe27d2f8-760b-c2d4-9474-7eaaae560086@vodafone.de>
 <CAOFGe95oZz-O743v7J6gpVuUqvPjdeifAcuoaZe8bf1HUNXm+Q@mail.gmail.com>
 <0c81dd81-e84a-2381-3ce1-e08450929da8@daenzer.net>
 <c7a44542-acca-09e1-5ea5-bf9938921e54@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0615829623=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c7a44542-acca-09e1-5ea5-bf9938921e54-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0615829623==
Content-Type: multipart/alternative; boundary="001a11497fe24fd2aa05540c8f7c"

--001a11497fe24fd2aa05540c8f7c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 12:17 AM, Christian K=C3=B6nig <deathsimple@vodafon=
e.de>
wrote:

> Am 11.07.2017 um 04:36 schrieb Michel D=C3=A4nzer:
>
>> On 11/07/17 06:09 AM, Jason Ekstrand wrote:
>>
>>> On Mon, Jul 10, 2017 at 9:15 AM, Christian K=C3=B6nig
>>> <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> wrote:
>>>
>>>      Am 10.07.2017 um 17:52 schrieb Jason Ekstrand:
>>>
>>>>      On Mon, Jul 10, 2017 at 8:45 AM, Christian K=C3=B6nig
>>>>      <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> wrote:
>>>>
>>>>          Am 10.07.2017 um 17:28 schrieb Jason Ekstrand:
>>>>
>>>>>          On Wed, Jul 5, 2017 at 6:04 PM, Dave Airlie
>>>>>          <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>>>>          [SNIP]
>>>>>          So, reading some CTS tests again, and I think we have a
>>>>>          problem here.  The Vulkan spec allows you to wait on a fence
>>>>>          that is in the unsignaled state.
>>>>>
>>>>          At least on the closed source driver that would be illegal as
>>>>          far as I know.
>>>>
>>>>
>>>>      Then they are doing workarounds in userspace.  There are
>>>>      definitely CTS tests for this:
>>>>
>>>>      https://github.com/KhronosGroup/VK-GL-CTS/blob/master/
>>>> external/vulkancts/modules/vulkan/synchronization/vktSync
>>>> hronizationBasicFenceTests.cpp#L74
>>>>      <https://github.com/KhronosGroup/VK-GL-CTS/blob/master/
>>>> external/vulkancts/modules/vulkan/synchronization/vktSync
>>>> hronizationBasicFenceTests.cpp#L74>
>>>>
>>>>          You can't wait on a semaphore before the signal operation is
>>>>          send down to the kerel.
>>>>
>>>>
>>>>      We (Intel) deal with this today by tracking whether or not the
>>>>      fence has been submitted and using a condition variable in
>>>>      userspace to sort it all out.
>>>>
>>>      Which sounds exactly like what AMD is doing in it's drivers as wel=
l.
>>>
>>>
>>> Which doesn't work cross-process so...
>>>
>> Surely it can be made to work by providing suitable kernel APIs to
>> userspace?
>>
>
> Well, that's exactly what Jason proposed to do, but I'm not very keen of
> that.
>
>      If we ever want to share fences across processes (which we do),
>>>>      then this needs to be sorted in the kernel.
>>>>
>>>      That would clearly get a NAK from my side, even Microsoft forbids
>>>      wait before signal because you can easily end up in deadlock
>>> situations.
>>>
>>> Please don't NAK things that are required by the API specification and
>>> CTS tests.
>>>
>> There is no requirement for every aspect of the Vulkan API specification
>> to be mirrored 1:1 in the kernel <-> userspace API. We have to work out
>> what makes sense at each level.
>>
>
> Exactly, if we have a synchronization problem between two processes that
> should be solved in userspace.
>
> E.g. if process A hasn't submitted it's work to the kernel it should flus=
h
> it's commands before sending a flip event to the compositor.
>

Ok, I think there is some confusion here on what is being proposed.  Here
are some things that are *not* being proposed:

 1. This does *not* allow a client to block another client's GPU work
indefinitely.  This is entirely for a CPU wait API to allow for a "wait for
submit" as well as a "wait for finish".
 2. This is *not* for system compositors that need to be robust against
malicious clients.

The expected use for the OPAQUE_FD is two very tightly integrated processes
which trust each other but need to be able to share synchronization
primitives.  One of the things they need to be able to do (as per the
Vulkan API) with those synchronization primitives is a "wait for submit and
finish" operation.  I'm happy for the kernel to have separate APIs for
"wait for submit" and "wait for finish" if that's more palatable but i
don't really see why there is such a strong reaction to the "wait for
submit and finish" behavior.

Could we do this "in userspace"?  Yes, with added kernel API.  we would
need some way of strapping a second FD onto a syncobj or combining two FDs
into one to send across the wire or something like that, then add a shared
memory segment, and then pile on a bunch of code to do cross-process
condition variables and state tracking.  I really don't see how that's a
better solution than adding a flag to the kernel API to just do what we
want.

--001a11497fe24fd2aa05540c8f7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Jul 11, 2017 at 12:17 AM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=3D"_blank">deathsimple@voda=
fone.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=
=3D"HOEnZb"><div class=3D"h5">Am 11.07.2017 um 04:36 schrieb Michel D=C3=A4=
nzer:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 11/07/17 06:09 AM, Jason Ekstrand wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Mon, Jul 10, 2017 at 9:15 AM, Christian K=C3=B6nig<br>
&lt;<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=3D"_blank">deathsimpl=
e@vodafone.de</a> &lt;mailto:<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" tar=
get=3D"_blank">deathsimple@vodafone.d<wbr>e</a>&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0Am 10.07.2017 um 17:52 schrieb Jason Ekstrand:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0On Mon, Jul 10, 2017 at 8:45 AM, Christian K=C3=B6nig<b=
r>
=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=
=3D"_blank">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a> &lt;mailto:<a href=3D"mailto:deaths=
imple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=3D"_blank">deathsimple@vodafone.d<wbr>e</a>&gt;&g=
t; wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Am 10.07.2017 um 17:28 schrieb Jason Ekst=
rand:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On Wed, Jul 5, 2017 at 6:04 PM, Dave Airl=
ie<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
target=3D"_blank">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &lt;mailto:<a href=3D"mailto:airlie=
d@gmail.com" target=3D"_blank">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&gt; wrote:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[SNIP]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0So, reading some CTS tests again, and I t=
hink we have a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0problem here.=C2=A0 The Vulkan spec allow=
s you to wait on a fence<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0that is in the unsignaled state.<br>
</blockquote>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0At least on the closed source driver that=
 would be illegal as<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0far as I know.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0Then they are doing workarounds in userspace.=C2=A0 The=
re are<br>
=C2=A0 =C2=A0 =C2=A0definitely CTS tests for this:<br>
<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/KhronosGroup/VK-GL-CTS/bl=
ob/master/external/vulkancts/modules/vulkan/synchronization/vktSynchronizat=
ionBasicFenceTests.cpp#L74" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/KhronosGro<wbr>up/VK-GL-CTS/blob/master/<wbr>external/vulkancts/mo=
dules/<wbr>vulkan/synchronization/vktSync<wbr>hronizationBasicFenceTests.<w=
br>cpp#L74</a><br>
=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/KhronosGroup/VK-GL-CT=
S/blob/master/external/vulkancts/modules/vulkan/synchronization/vktSynchron=
izationBasicFenceTests.cpp#L74" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/KhronosGr<wbr>oup/VK-GL-CTS/blob/master/<wbr>external/vulkanct=
s/modules/<wbr>vulkan/synchronization/vktSync<wbr>hronizationBasicFenceTest=
s.<wbr>cpp#L74</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0You can&#39;t wait on a semaphore before =
the signal operation is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0send down to the kerel.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0We (Intel) deal with this today by tracking whether or =
not the<br>
=C2=A0 =C2=A0 =C2=A0fence has been submitted and using a condition variable=
 in<br>
=C2=A0 =C2=A0 =C2=A0userspace to sort it all out.<br>
</blockquote>
=C2=A0 =C2=A0 =C2=A0Which sounds exactly like what AMD is doing in it&#39;s=
 drivers as well.<br>
<br>
<br>
Which doesn&#39;t work cross-process so...<br>
</blockquote>
Surely it can be made to work by providing suitable kernel APIs to<br>
userspace?<br>
</blockquote>
<br></div></div>
Well, that&#39;s exactly what Jason proposed to do, but I&#39;m not very ke=
en of that.<span class=3D""><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0If we ever want to share fences across processes (which=
 we do),<br>
=C2=A0 =C2=A0 =C2=A0then this needs to be sorted in the kernel.<br>
</blockquote>
=C2=A0 =C2=A0 =C2=A0That would clearly get a NAK from my side, even Microso=
ft forbids<br>
=C2=A0 =C2=A0 =C2=A0wait before signal because you can easily end up in dea=
dlock situations.<br>
<br>
Please don&#39;t NAK things that are required by the API specification and<=
br>
CTS tests.<br>
</blockquote>
There is no requirement for every aspect of the Vulkan API specification<br=
>
to be mirrored 1:1 in the kernel &lt;-&gt; userspace API. We have to work o=
ut<br>
what makes sense at each level.<br>
</blockquote>
<br></span>
Exactly, if we have a synchronization problem between two processes that sh=
ould be solved in userspace.<br>
<br>
E.g. if process A hasn&#39;t submitted it&#39;s work to the kernel it shoul=
d flush it&#39;s commands before sending a flip event to the compositor.<br=
>
</blockquote></div><br></div><div class=3D"gmail_extra">Ok, I think there i=
s some confusion here on what is being proposed.=C2=A0 Here are some things=
 that are *not* being proposed:<br><br></div><div class=3D"gmail_extra">=C2=
=A01. This does *not* allow a client to block another client&#39;s GPU work=
 indefinitely.=C2=A0 This is entirely for a CPU wait API to allow for a &qu=
ot;wait for submit&quot; as well as a &quot;wait for finish&quot;.<br></div=
><div class=3D"gmail_extra">=C2=A02. This is *not* for system compositors t=
hat need to be robust against malicious clients.<br><br></div><div class=3D=
"gmail_extra">The expected use for the OPAQUE_FD is two very tightly integr=
ated processes which trust each other but need to be able to share synchron=
ization primitives.=C2=A0 One of the things they need to be able to do (as =
per the Vulkan API) with those synchronization primitives is a &quot;wait f=
or submit and finish&quot; operation.=C2=A0 I&#39;m happy for the kernel to=
 have separate APIs for &quot;wait for submit&quot; and &quot;wait for fini=
sh&quot; if that&#39;s more palatable but i don&#39;t really see why there =
is such a strong reaction to the &quot;wait for submit and finish&quot; beh=
avior.<br><br></div><div class=3D"gmail_extra">Could we do this &quot;in us=
erspace&quot;?=C2=A0 Yes, with added kernel API.=C2=A0 we would need some w=
ay of strapping a second FD onto a syncobj or combining two FDs into one to=
 send across the wire or something like that, then add a shared memory segm=
ent, and then pile on a bunch of code to do cross-process condition variabl=
es and state tracking.=C2=A0 I really don&#39;t see how that&#39;s a better=
 solution than adding a flag to the kernel API to just do what we want.<br>=
</div></div>

--001a11497fe24fd2aa05540c8f7c--

--===============0615829623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0615829623==--
