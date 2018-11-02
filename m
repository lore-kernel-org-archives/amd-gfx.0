From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: prevent an integer wraparound of
 cpu_map_count
Date: Fri, 2 Nov 2018 15:42:57 -0400
Message-ID: <CAAxE2A7tPd3iBF60kQ3ENQadcZjadqKyh59x9XrYMhNaZaY27Q@mail.gmail.com>
References: <20181023190733.15251-1-maraeo@gmail.com>
 <7690cf4c-5eff-85e4-885c-2ecc9dc01c25@gmail.com>
 <CAAxE2A50X-XGvyx7GcZnnAC4p-bRnXrQpjQZ1D-8pD5ir3QdMQ@mail.gmail.com>
 <e8cf4264-f211-70b3-01ec-34d0eb5e7edb@daenzer.net>
 <CAAxE2A59+J7-jdYobFMMFDhS0oPLS8MgJXzV-Z=N7jhMr9rcdg@mail.gmail.com>
 <CAAxE2A7kA_W3xeK01F7jthfMyEij3TFy_G7=A5_vsduNVrKpbQ@mail.gmail.com>
 <79fe6959-6f43-5c3b-8fa1-69d43498cdd4@daenzer.net>
 <e434a695-a6c4-14f7-deff-5420d08311f7@amd.com>
 <CAAxE2A7aZ2YiJN0P8KD1F=ncj17ds1x2Dmkka-tHR7Y5vrOOBQ@mail.gmail.com>
 <7ca0e170-5a2b-a6ed-4d2e-13d9b32011a7@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1212114630=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7ca0e170-5a2b-a6ed-4d2e-13d9b32011a7-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1212114630==
Content-Type: multipart/alternative; boundary="000000000000289a4f0579b3c022"

--000000000000289a4f0579b3c022
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 2, 2018 at 3:39 AM Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
wrote:

> Am 31.10.18 um 23:12 schrieb Marek Ol=C5=A1=C3=A1k:
>
> On Wed, Oct 31, 2018 at 3:59 AM Koenig, Christian <
> Christian.Koenig-5C7GfCeVMHo@public.gmane.org> wrote:
>
>> Am 30.10.18 um 16:59 schrieb Michel D=C3=A4nzer:
>> > On 2018-10-30 4:52 p.m., Marek Ol=C5=A1=C3=A1k wrote:
>> >> On Tue, Oct 30, 2018, 11:49 AM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8@public.gmane.org=
m> wrote:
>> >>> On Tue, Oct 30, 2018, 4:20 AM Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org=
>
>> wrote:
>> >>>
>> >>>> On 2018-10-29 10:15 p.m., Marek Ol=C5=A1=C3=A1k wrote:
>> >>>>> You and I discussed this extensively internally a while ago. It's
>> >>>> expected
>> >>>>> and correct behavior. Mesa doesn't unmap some buffers and never
>> will.
>> >>>> It doesn't need to keep mapping the same buffer over and over again
>> >>>> though, does it?
>> >>>>
>> >>> It doesnt map it again. It just doesnt unmap. So the next map call
>> just
>> >>> returns the pointer. It's correct to stop the counter wraparound.
>> >>>
>> >> Mesa doesn't track whether a buffer is already mapped. Libdrm tracks
>> that.
>> >> It's a feature of libdrm to return the same pointer and expect infini=
te
>> >> number of map calls.
>> > That's not what the reference counting in libdrm is intended for. It's
>> > for keeping track of how many independent callers have mapped the
>> > buffer. Mesa should remember that it mapped a buffer and not map it
>> again.
>>
>> Well if Mesa just wants to query the existing mapping then why not add a
>> amdgpu_bo_get_cpu_ptr() which just queries if a CPU mapping exists and
>> if yes returns the appropriate pointer or NULL otherwise?
>>
>> I mean when we want to abstract everything in libdrm then we just need
>> to add the functions we need to use this abstraction.
>>
>
> That can be future work for the sake of cleanliness and clarity, but it
> would be a waste of time and wouldn't help old Mesa.
>
>
> That it doesn't help old Mesa is unfortunate, but this is clearly a bug i=
n
> Mesa.
>
> If old Mesa is broken then we should fix it by updating it and not add
> workarounds for specific clients in libdrm.
>

It's not a workaround. We made a decision with amdgpu to share code by
moving portions of the Mesa winsys into libdrm. The map_count is part of
that. It's highly desirable to continue with code sharing. There is nothing
broken with Mesa. Mesa won't check whether a buffer is already mapped.
That's the responsibility of libdrm as part of code sharing and we don't
want to duplicate the same logic in Mesa. It's all part of the intended
design.

Marek

--000000000000289a4f0579b3c022
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Nov 2,=
 2018 at 3:39 AM Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@a=
md.com">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">



<div text=3D"#000000" bgcolor=3D"#FFFFFF">
<div class=3D"m_7102524736659915582moz-cite-prefix">Am 31.10.18 um 23:12 sc=
hrieb Marek Ol=C5=A1=C3=A1k:<br>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div class=3D"gmail_quote">
<div dir=3D"ltr">On Wed, Oct 31, 2018 at 3:59 AM Koenig, Christian &lt;<a h=
ref=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Christian.Koenig@=
amd.com</a>&gt; wrote:<br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Am 30.10.18 um 16:59 schrieb Michel D=C3=A4nzer:<br>
&gt; On 2018-10-30 4:52 p.m., Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt;&gt; On Tue, Oct 30, 2018, 11:49 AM Marek Ol=C5=A1=C3=A1k &lt;<a href=
=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wro=
te:<br>
&gt;&gt;&gt; On Tue, Oct 30, 2018, 4:20 AM Michel D=C3=A4nzer &lt;<a href=
=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;=
 wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 2018-10-29 10:15 p.m., Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt;&gt;&gt;&gt;&gt; You and I discussed this extensively internally a whil=
e ago. It&#39;s<br>
&gt;&gt;&gt;&gt; expected<br>
&gt;&gt;&gt;&gt;&gt; and correct behavior. Mesa doesn&#39;t unmap some buff=
ers and never will.<br>
&gt;&gt;&gt;&gt; It doesn&#39;t need to keep mapping the same buffer over a=
nd over again<br>
&gt;&gt;&gt;&gt; though, does it?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; It doesnt map it again. It just doesnt unmap. So the next map =
call just<br>
&gt;&gt;&gt; returns the pointer. It&#39;s correct to stop the counter wrap=
around.<br>
&gt;&gt;&gt;<br>
&gt;&gt; Mesa doesn&#39;t track whether a buffer is already mapped. Libdrm =
tracks that.<br>
&gt;&gt; It&#39;s a feature of libdrm to return the same pointer and expect=
 infinite<br>
&gt;&gt; number of map calls.<br>
&gt; That&#39;s not what the reference counting in libdrm is intended for. =
It&#39;s<br>
&gt; for keeping track of how many independent callers have mapped the<br>
&gt; buffer. Mesa should remember that it mapped a buffer and not map it ag=
ain.<br>
<br>
Well if Mesa just wants to query the existing mapping then why not add a <b=
r>
amdgpu_bo_get_cpu_ptr() which just queries if a CPU mapping exists and <br>
if yes returns the appropriate pointer or NULL otherwise?<br>
<br>
I mean when we want to abstract everything in libdrm then we just need <br>
to add the functions we need to use this abstraction.<br>
</blockquote>
<div><br>
</div>
<div>That can be future work for the sake of cleanliness and clarity, but i=
t would be a waste of time and wouldn&#39;t help old Mesa.</div>
</div>
</div>
</blockquote>
<br>
That it doesn&#39;t help old Mesa is unfortunate, but this is clearly a bug=
 in Mesa.<br>
<br>
If old Mesa is broken then we should fix it by updating it and not add work=
arounds for specific clients in libdrm.<br></div></blockquote><div><br></di=
v><div>It&#39;s not a workaround. We made a decision with amdgpu to share c=
ode by moving portions of the Mesa winsys into libdrm. The map_count is par=
t of that. It&#39;s highly desirable to continue with code sharing. There i=
s nothing broken with Mesa. Mesa won&#39;t check whether a buffer is alread=
y mapped. That&#39;s the responsibility of libdrm as part of code sharing a=
nd we don&#39;t want to duplicate the same logic in Mesa. It&#39;s all part=
 of the intended design.<br></div><div><br></div><div>Marek<br></div></div>=
</div>

--000000000000289a4f0579b3c022--

--===============1212114630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1212114630==--
