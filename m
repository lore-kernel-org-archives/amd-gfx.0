From: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Subject: Re: [PATCH 02/11] dma-buf: add new dma_fence_chain container v4
Date: Fri, 15 Feb 2019 13:11:30 -0600
Message-ID: <CAOFGe977e+vyJFaYs9F07ydL0+r387t43_d4qcwCf-HT+ToF=A@mail.gmail.com>
References: <20181207095601.2058-1-david1.zhou@amd.com>
 <20181207095601.2058-2-david1.zhou@amd.com>
 <6c2adaf5-6871-20be-a26d-182f8ca8ab8a@intel.com>
 <e170ceed-fdb7-8b4a-93d7-e565641390b3@amd.com>
 <bbae2023-8dee-692e-9549-40779a202587@intel.com>
 <CAOFGe96HUkzHPJKYT-07X3vMvCRD-=Hba1=Ke24qt_PY2vn0YQ@mail.gmail.com>
 <a0b27d87-50f2-56ce-1db7-5a1dc005a798@gmail.com>
 <CAOFGe9611MqmsvdvZS4_vuJjrrUAmjK5-41Z6tpaxTHJsB8CwA@mail.gmail.com>
 <f933f9ec-6e69-f9df-f12f-5f1844a2ad37@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1192149333=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f933f9ec-6e69-f9df-f12f-5f1844a2ad37-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Lionel Landwerlin <lionel.g.landwerlin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

--===============1192149333==
Content-Type: multipart/alternative; boundary="0000000000009504720581f38b41"

--0000000000009504720581f38b41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 12:33 PM Koenig, Christian <Christian.Koenig-urvtwAKJhsc@public.gmane.org=
m>
wrote:

> Am 15.02.19 um 19:16 schrieb Jason Ekstrand:
>
> On Fri, Feb 15, 2019 at 11:51 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> Am 15.02.19 um 17:49 schrieb Jason Ekstrand:
>>
>> On Fri, Feb 15, 2019 at 9:52 AM Lionel Landwerlin via dri-devel <
>> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> wrote:
>>
>>> On 15/02/2019 14:32, Koenig, Christian wrote:
>>> > Am 15.02.19 um 15:23 schrieb Lionel Landwerlin:
>>> >> Hi Christian, David,
>>> >>
>>> >> For timeline semaphore we need points to signaled in order.
>>> >> I'm struggling to understand how this fence-chain implementation
>>> >> preserves ordering of the seqnos.
>>> >>
>>> >> One of the scenario I can see an issue happening is when you have a
>>> >> timeline with points 1 & 2 and userspace submits for 2 different
>>> >> engines :
>>> >>      - first with let's say a blitter style engine on point 2
>>> >>      - then a 3d style engine on point 1
>>> > Yeah, and where exactly is the problem?
>>> >
>>> > Seqno 1 will signal when the 3d style engine finishes work.
>>> >
>>> > And seqno 2 will signal when both seqno 1 is signaled and the blitter
>>> > style engine has finished its work.
>>>
>>
>> That's an interesting interpretation of the spec.  I think it's legal an=
d
>> I could see that behavior may be desirable in some ways.
>>
>>
>> Well we actually had this discussion multiple times now, both internally
>> as well as on the mailing list. Please also see the previous mails with
>> Daniel on this topic.
>>
>
> I dug through dri-devel and read everything I could find with a search fo=
r
> "timeline semaphore"  I didn't find all that much but this did come up on=
ce.
>
>
> Need to dig through my mails as well, that was back in November/December
> last year.
>
>
>
>> My initial suggestion was actually to exactly what Leonid suggested as
>> well.
>>
>> And following this I used a rather simple container for the
>> implementation, e.g. just a ring buffer indexed by the sequence number. =
In
>> this scenario userspace can specify on syncobj creation time how big the
>> window for sequence numbers should be, e.g. in this implementation how b=
ig
>> the ring buffer would be.
>>
>> This was rejected by our guys who actually wrote a good part of the
>> Vulkan specification. Daniel then has gone into the same direction durin=
g
>> the public discussion.
>>
>
> I agree with whoever said that specifying a ringbuffer size is
> unacceptable.  I'm not really sure how that's relevant though.  Is a
> ringbuffer required to implement the behavior that is being suggested
> here?  Genuine question; I'm trying to get back up to speed.
>
>
> Using a ring buffer was just an example how we could do it if we follow m=
y
> and Lionel's suggestion.
>
> Key point is that we could simplify the implementation massively if
> sequence numbers don't need to depend on each other.
>
> In other words we just see the syncobj as container where fences are adde=
d
> and retrieved from instead of something actively involved in the signalin=
g.
>

In principal, I think this is a reasonable argument.  Having it involved in
signalling doesn't seem terrible to me but it would mean that a driver
wouldn't be able to detect that the fence it's waiting on actually belongs
to itself and optimize things.


> Main reason we didn't do it this way is because the AMD Vulkan team has
> rejected this approach.
>

Clearly, there's not quite as much agreement as I'd thought there was.  Oh,
well, that's why we have these discussions.


> Additional to that chaining sequence numbers together is really the more
> defensive approach, e.g. it is less likely that applications can shoot
> themselves in the foot.
>

Yeah, I can see how the "everything prior to n must be signalled" could be
safer.  I think both wait-any and wait-all have their ups and downs.  It
just took me by surprise.


>
>  4. If you do get into a sticky situation, you can unblock an entire
>> timeline by using the CPU signal ioctl to set it to a high value.
>>
>>
>> Well I think that this could be problematic as well. Keep in mind that
>> main use case for this is sharing timelines between processes.
>>
>> In other words you don't want applications to be able to mess with it to
>> much.
>>
>
> Cross-process is exactly why you want it.  Suppose you're a compositor an=
d
> you have a timeline shared with another application and you've submitted
> work which waits on it.  Then you get a notification somehow (SIGHUP?) th=
at
> the client has died leaving you hanging.  What do you do?  You take the
> semaphore that's shared with you and the client and whack it to UINT64_MA=
X
> to unblock yourself.  Of course, this can be abused and that's always the
> risk you take with timelines.
>
>
> My last status is that basically everybody agrees now that wait before
> signal in the kernel is forbidden.
>

Agreed.  I'm not saying that wait before signal in the kernel should be a
thing.  I think we're all agreed that wait-before-signal with the current
GEM infrastructure is utter insanity.

However, timeline syncobjs are both a kernel wait mechanism (only for time
points that already have a known-to-signal dma_fence) and a userspace wait
mechanism (which can wait for things which haven't materialized yet).  The
whacking to UINT64_MAX would be to unblock waiting userspace threads as you
mentioned below.

That said, in the case that I suggested here, if the client process died,
got kicked off the GPU, or whatever, then the kernel has likely declared
it's context a loss and signalled all dma_fences associated with it.  If
this is true, then whacking it to UINT64_MAX still works to unblock the
timeline because there would be nothing else pending to signal time
points.  Worst case, the process crashed and left valid GPU work pending in
the kernel and the compositor ends up waiting a little while longer for
said work to complete.

Ok, I think I'm reasonably convinced that the wait-all behaviour implied by
the chaining approach, while unexpected, isn't harmful.

--Jason

--0000000000009504720581f38b41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Feb 15, 2019 at 12:33 PM Koenig, Christian &lt;<a href=3D"ma=
ilto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">



<div bgcolor=3D"#FFFFFF">
<div class=3D"gmail-m_-4383219934271622999moz-cite-prefix">Am 15.02.19 um 1=
9:16 schrieb Jason Ekstrand:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div class=3D"gmail_quote">
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 15, 2019 at 11:51 AM Chri=
stian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" ta=
rget=3D"_blank">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<div class=3D"gmail-m_-4383219934271622999gmail-m_5249618168223624859moz-ci=
te-prefix">Am 15.02.19 um 17:49 schrieb Jason Ekstrand:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div class=3D"gmail_quote">
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 15, 2019 at 9:52 AM Lione=
l Landwerlin via dri-devel &lt;<a href=3D"mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org" target=3D"_blank">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; wrote:<br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
On 15/02/2019 14:32, Koenig, Christian wrote:<br>
&gt; Am 15.02.19 um 15:23 schrieb Lionel Landwerlin:<br>
&gt;&gt; Hi Christian, David,<br>
&gt;&gt;<br>
&gt;&gt; For timeline semaphore we need points to signaled in order.<br>
&gt;&gt; I&#39;m struggling to understand how this fence-chain implementati=
on<br>
&gt;&gt; preserves ordering of the seqnos.<br>
&gt;&gt;<br>
&gt;&gt; One of the scenario I can see an issue happening is when you have =
a<br>
&gt;&gt; timeline with points 1 &amp; 2 and userspace submits for 2 differe=
nt<br>
&gt;&gt; engines :<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 - first with let&#39;s say a blitter styl=
e engine on point 2<br>
&gt;&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 - then a 3d style engine on point 1<br>
&gt; Yeah, and where exactly is the problem?<br>
&gt;<br>
&gt; Seqno 1 will signal when the 3d style engine finishes work.<br>
&gt;<br>
&gt; And seqno 2 will signal when both seqno 1 is signaled and the blitter<=
br>
&gt; style engine has finished its work.<br>
</blockquote>
<div><br>
</div>
<div>That&#39;s an interesting interpretation of the spec.=C2=A0 I think it=
&#39;s legal and I could see that behavior may be desirable in some ways.<b=
r>
</div>
</div>
</div>
</blockquote>
<br>
Well we actually had this discussion multiple times now, both internally as=
 well as on the mailing list. Please also see the previous mails with Danie=
l on this topic.<br>
</div>
</blockquote>
<div><br>
</div>
<div>I dug through dri-devel and read everything I could find with a search=
 for &quot;timeline semaphore&quot;=C2=A0 I didn&#39;t find all that much b=
ut this did come up once.<br>
</div>
</div>
</div>
</blockquote>
<br>
Need to dig through my mails as well, that was back in November/December la=
st year.<br>
<br>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div class=3D"gmail_quote">
<div>=C2=A0</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<div bgcolor=3D"#FFFFFF">My initial suggestion was actually to exactly what=
 Leonid suggested as well.<br>
<br>
And following this I used a rather simple container for the implementation,=
 e.g. just a ring buffer indexed by the sequence number. In this scenario u=
serspace can specify on syncobj creation time how big the window for sequen=
ce numbers should be, e.g. in this
 implementation how big the ring buffer would be.<br>
<br>
This was rejected by our guys who actually wrote a good part of the Vulkan =
specification. Daniel then has gone into the same direction during the publ=
ic discussion.<br>
</div>
</blockquote>
<div><br>
</div>
<div>I agree with whoever said that specifying a ringbuffer size is unaccep=
table.=C2=A0 I&#39;m not really sure how that&#39;s relevant though.=C2=A0 =
Is a ringbuffer required to implement the behavior that is being suggested =
here?=C2=A0 Genuine question; I&#39;m trying to get back up
 to speed.<br>
</div>
</div>
</div>
</blockquote>
<br>
Using a ring buffer was just an example how we could do it if we follow my =
and Lionel&#39;s suggestion.<br>
<br>
Key point is that we could simplify the implementation massively if sequenc=
e numbers don&#39;t need to depend on each other.<br>
<br>
In other words we just see the syncobj as container where fences are added =
and retrieved from instead of something actively involved in the signaling.
<br></div></blockquote><div><br></div><div>In principal, I think this is a =
reasonable argument.=C2=A0 Having it involved in signalling doesn&#39;t see=
m terrible to me but it would mean that a driver wouldn&#39;t be able to de=
tect that the fence it&#39;s waiting on actually belongs to itself and opti=
mize things.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div bgcolor=3D"#FFFFFF">
Main reason we didn&#39;t do it this way is because the AMD Vulkan team has=
 rejected this approach.<br></div></blockquote><div><br></div><div>Clearly,=
 there&#39;s not quite as much agreement as I&#39;d thought there was.=C2=
=A0 Oh, well, that&#39;s why we have these discussions.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"=
#FFFFFF">
Additional to that chaining sequence numbers together is really the more de=
fensive approach, e.g. it is less likely that applications can shoot themse=
lves in the foot.<br></div></blockquote><div><br></div><div>Yeah, I can see=
 how the &quot;everything prior to n must be signalled&quot; could be safer=
.=C2=A0 I think both wait-any and wait-all have their ups and downs.=C2=A0 =
It just took me by surprise.<br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div bgcolor=3D"#FFFFFF">
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div class=3D"gmail_quote">
<div><br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<div bgcolor=3D"#FFFFFF">
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div class=3D"gmail_quote">
<div>=C2=A04. If you do get into a sticky situation, you can unblock an ent=
ire timeline by using the CPU signal ioctl to set it to a high value.
<br>
</div>
</div>
</div>
</blockquote>
<br>
Well I think that this could be problematic as well. Keep in mind that main=
 use case for this is sharing timelines between processes.<br>
<br>
In other words you don&#39;t want applications to be able to mess with it t=
o much.<br>
</div>
</blockquote>
<div><br>
</div>
<div>Cross-process is exactly why you want it.=C2=A0 Suppose you&#39;re a c=
ompositor and you have a timeline shared with another application and you&#=
39;ve submitted work which waits on it.=C2=A0 Then you get a notification s=
omehow (SIGHUP?) that the client has died leaving
 you hanging.=C2=A0 What do you do?=C2=A0 You take the semaphore that&#39;s=
 shared with you and the client and whack it to UINT64_MAX to unblock yours=
elf.=C2=A0 Of course, this can be abused and that&#39;s always the risk you=
 take with timelines.<br>
</div>
</div>
</div>
</blockquote>
<br>
My last status is that basically everybody agrees now that wait before sign=
al in the kernel is forbidden.<br></div></blockquote><div><br></div><div>Ag=
reed.=C2=A0 I&#39;m not saying that wait before signal in the kernel should=
 be a thing.=C2=A0 I think we&#39;re all agreed that wait-before-signal wit=
h the current GEM infrastructure is utter insanity.</div><div><br></div><di=
v>However, timeline syncobjs are both a kernel wait mechanism (only for tim=
e points that already have a known-to-signal dma_fence) and a userspace wai=
t mechanism (which can wait for things which haven&#39;t materialized yet).=
=C2=A0 The whacking to UINT64_MAX would be to unblock waiting userspace thr=
eads as you mentioned below.<br></div><div><br></div><div>That said, in the=
 case that I suggested here, if the client process died, got kicked off the=
 GPU, or whatever, then the kernel has likely declared it&#39;s context a l=
oss and signalled all dma_fences associated with it.=C2=A0 If this is true,=
 then whacking it to UINT64_MAX still works to unblock the timeline because=
 there would be nothing else pending to signal time points.=C2=A0 Worst cas=
e, the process crashed and left valid GPU work pending in the kernel and th=
e compositor ends up waiting a little while longer for said work to complet=
e.<br></div><div><br></div><div>Ok, I think I&#39;m reasonably convinced th=
at the wait-all behaviour implied by the chaining approach, while unexpecte=
d, isn&#39;t harmful.</div><div><br></div><div>--Jason<br></div></div></div=
>

--0000000000009504720581f38b41--

--===============1192149333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1192149333==--
