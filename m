From: Jason Ekstrand <jason@jlekstrand.net>
Subject: Re: [rfc] drm sync objects (search for spock)
Date: Tue, 9 May 2017 15:23:02 -0700
Message-ID: <CAOFGe958OKg847Ls+zuiVuZn4zR9SCckdbJA3SB92YskN_8bCg@mail.gmail.com>
References: <20170426032833.1455-1-airlied@gmail.com>
 <373f3919-2f52-44c0-89b9-0c10b7b7bed4@vodafone.de>
 <CAPM=9tz_S1Y87PxFTw_+SM2f+g9hUvFviKtb9xR=2xLpSCjEAA@mail.gmail.com>
 <d5a06d12-7829-ddf6-6021-a5a0117036d9@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1653093067=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <d5a06d12-7829-ddf6-6021-a5a0117036d9@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1653093067==
Content-Type: multipart/alternative; boundary=94eb2c1b5366934fc0054f1ecccc

--94eb2c1b5366934fc0054f1ecccc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2017 at 7:57 AM, Christian K=C3=B6nig <deathsimple@vodafone=
.de>
wrote:

> Am 26.04.2017 um 11:57 schrieb Dave Airlie:
>
>> On 26 April 2017 at 18:45, Christian K=C3=B6nig <deathsimple@vodafone.de=
>
>> wrote:
>>
>>> Am 26.04.2017 um 05:28 schrieb Dave Airlie:
>>>
>>>> Okay I've gone around the sun with these a few times, and
>>>> pretty much implemented what I said last week.
>>>>
>>>> This is pretty much a complete revamp.
>>>>
>>>> 1. sync objects are self contained drm objects, they
>>>> have a file reference so can be passed between processes.
>>>>
>>>> 2. Added a sync object wait interface modelled on the vulkan
>>>> fence waiting API.
>>>>
>>>> 3. sync_file interaction is explicitly different than
>>>> opaque fd passing, you import a sync file state into an
>>>> existing syncobj, or create a new sync_file from an
>>>> existing syncobj. This means no touching the sync file code
>>>> at all. \o/
>>>>
>>>
I've done a quick scan over the patches and I like the API.  It almost
looks as if Santa read my wish list. :-)

That said, it was a "quick scan" so don't take this as any sort of actual
code review.  It'll probably be a little while before I get a chance to sit
down and look at i915 again but things seem reasonable.


> Doesn't that break the Vulkan requirement that if a sync_obj is exported =
to
>>> an fd and imported on the other side we get the same sync_obj again?
>>>
>>> In other words the fd is exported and imported only once and the
>>> expectation
>>> is that we fence containing it will change on each signaling operation.
>>>
>>> As far as I can see with the current implementation you get two
>>> sync_objects
>>> on in the exporting process and one in the importing one.
>>>
>> Are you talking about using sync_file interop for vulkan, then yes
>> that would be wrong.
>>
>> But that isn't how this works, see 1. above the sync obj has a 1:1
>> mapping with an
>> opaque fd (non-sync_file) that is only used for interprocess passing
>> of the syncobj.
>>
>
> Ah, ok that makes some more sense.
>
> You can interoperate with sync_files by importing/exporting the
>> syncobj fence into
>> and out of them but that aren't meant for passing the fds around, more
>> for where you
>> get a sync_file fd from somewhere else and you want to use it and
>> vice-versa.
>>
>
> I would prefer dealing only with one type of fd in userspace, but that
> approach should work as well.
>
> I'd like to move any drm APIs away from sync_file to avoid the fd wastage=
s,
>>
>
> That sounds like it make sense, but I would still rather vote for
> extending the sync_file interface than deprecating it with another one.
>
> I'd also like to move the driver specific fences to syncobj where I can.
>>
>
> I'm pretty sure that is not a good idea.
>
> Beating the sequence based fence values we currently use for CPU sync in
> performance would be pretty hard. E.g. at least on amdgpu we can even che=
ck
> those by doing a simple 64bit read from a memory address, without IOCTL o=
r
> any other overhead involved.
>
> Regards,
> Christian.
>
>
>
>> Dave.
>>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--94eb2c1b5366934fc0054f1ecccc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Apr 26, 2017 at 7:57 AM, Christian K=C3=B6nig <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:deathsimple@vodafone.de" target=3D"_blank">deathsimp=
le@vodafone.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
 class=3D"m_7196519087789463477HOEnZb"><div class=3D"m_7196519087789463477h=
5">Am 26.04.2017 um 11:57 schrieb Dave Airlie:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 26 April 2017 at 18:45, Christian K=C3=B6nig &lt;<a href=3D"mailto:death=
simple@vodafone.de" target=3D"_blank">deathsimple@vodafone.de</a>&gt; wrote=
:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Am 26.04.2017 um 05:28 schrieb Dave Airlie:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Okay I&#39;ve gone around the sun with these a few times, and<br>
pretty much implemented what I said last week.<br>
<br>
This is pretty much a complete revamp.<br>
<br>
1. sync objects are self contained drm objects, they<br>
have a file reference so can be passed between processes.<br>
<br>
2. Added a sync object wait interface modelled on the vulkan<br>
fence waiting API.<br>
<br>
3. sync_file interaction is explicitly different than<br>
opaque fd passing, you import a sync file state into an<br>
existing syncobj, or create a new sync_file from an<br>
existing syncobj. This means no touching the sync file code<br>
at all. \o/<br>
</blockquote></blockquote></blockquote></div></div></blockquote><div><br></=
div><div>I&#39;ve done a quick scan over the patches and I like the API.=C2=
=A0 It almost looks as if Santa read my wish list. :-)<br><br></div><div>Th=
at said, it was a &quot;quick scan&quot; so don&#39;t take this as any sort=
 of actual code review.=C2=A0 It&#39;ll probably be a little while before I=
 get a chance to sit down and look at i915 again but things seem reasonable=
.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"m_=
7196519087789463477HOEnZb"><div class=3D"m_7196519087789463477h5"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

Doesn&#39;t that break the Vulkan requirement that if a sync_obj is exporte=
d to<br>
an fd and imported on the other side we get the same sync_obj again?<br>
<br>
In other words the fd is exported and imported only once and the expectatio=
n<br>
is that we fence containing it will change on each signaling operation.<br>
<br>
As far as I can see with the current implementation you get two sync_object=
s<br>
on in the exporting process and one in the importing one.<br>
</blockquote>
Are you talking about using sync_file interop for vulkan, then yes<br>
that would be wrong.<br>
<br>
But that isn&#39;t how this works, see 1. above the sync obj has a 1:1<br>
mapping with an<br>
opaque fd (non-sync_file) that is only used for interprocess passing<br>
of the syncobj.<br>
</blockquote>
<br></div></div>
Ah, ok that makes some more sense.<span><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
You can interoperate with sync_files by importing/exporting the<br>
syncobj fence into<br>
and out of them but that aren&#39;t meant for passing the fds around, more<=
br>
for where you<br>
get a sync_file fd from somewhere else and you want to use it and vice-vers=
a.<br>
</blockquote>
<br></span>
I would prefer dealing only with one type of fd in userspace, but that appr=
oach should work as well.<span><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I&#39;d like to move any drm APIs away from sync_file to avoid the fd wasta=
ges,<br>
</blockquote>
<br></span>
That sounds like it make sense, but I would still rather vote for extending=
 the sync_file interface than deprecating it with another one.<span><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I&#39;d also like to move the driver specific fences to syncobj where I can=
.<br>
</blockquote>
<br></span>
I&#39;m pretty sure that is not a good idea.<br>
<br>
Beating the sequence based fence values we currently use for CPU sync in pe=
rformance would be pretty hard. E.g. at least on amdgpu we can even check t=
hose by doing a simple 64bit read from a memory address, without IOCTL or a=
ny other overhead involved.<br>
<br>
Regards,<br>
Christian.<div class=3D"m_7196519087789463477HOEnZb"><div class=3D"m_719651=
9087789463477h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Dave.<br>
</blockquote>
<br>
<br>
______________________________<wbr>_________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dri-de=
vel@lists.freedesktop.or<wbr>g</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/l=
istinfo/dri-devel</a><br>
</div></div></blockquote></div><br></div></div>

--94eb2c1b5366934fc0054f1ecccc--

--===============1653093067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1653093067==--
