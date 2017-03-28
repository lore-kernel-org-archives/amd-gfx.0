From: Julien Isorce <julien.isorce@gmail.com>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Tue, 28 Mar 2017 09:24:43 +0100
Message-ID: <CAHWPjbX8rv2FJniBjfYtqtXo-iCjvC9bNem0kv4bfbp=gbSBAQ@mail.gmail.com>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
 <CAOfP2NDoHof0UhQbz53N9WW8jLH3yC_e+ESrTbdd9Ldb6RYg=Q@mail.gmail.com>
 <5f26f8a1-e5bd-ca7a-c7ee-08c8f04f2110@daenzer.net>
 <CAHWPjbUEQCr4Qox5W-C8LYep7-fH=3FV_qhYydpOg2LvqGbZUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0328191419=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAHWPjbUEQCr4Qox5W-C8LYep7-fH=3FV_qhYydpOg2LvqGbZUw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Zachary Michaels <zmichaels@oblong.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Julien Isorce <jisorce@oblong.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0328191419==
Content-Type: multipart/alternative; boundary=001a1142987e2ea1e5054bc63117

--001a1142987e2ea1e5054bc63117
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michel,

About the hard lockup, I noticed that I cannot have it with the following
conditions:

1. soft lockup fix (the 0->i change which avoids infinite loop)
2. Your suggestion: (!(rbo->flags & RADEON_GEM_CPU_ACCESS)
3. radeon.gartsize=3D512 radeon.vramlimit=3D1024 (any other values above do=
 not
help, for example (1024, 1024) or (1024, 2048))

Without 1 and 2, but with 3, our test reproduces the soft lockup (just
discovered few days ago).
Without 3 (and with or without 1., 2.), our test reproduces the hard lockup
which one does not give any info in kern.log (sometimes some NUL ^@
characters but not always).

We are converting this repro test to a piglit test in order to share it but
it will take some times. But to simplify it continuously uploads images
with a size picked randomly and up to 4K. So TTM's eviction mechanism is
hit a lot.

(The card is a ForePro W600 Cape Verde 2048M )

I am happy to try any other suggestion.

Thx
Julien

On 24 March 2017 at 19:01, Julien Isorce <julien.isorce@gmail.com> wrote:

> Hi Michel,
>
> No this change does not help on the other issue (hard lockup).
> I have no tried it in combination with the 0 -> i change.
>
> Thx anyway.
> Julien
>
>
> On 24 March 2017 at 10:03, Michel D=C3=A4nzer <michel@daenzer.net> wrote:
>
>> On 24/03/17 12:31 AM, Zachary Michaels wrote:
>> >
>> > I should also note that we are experiencing another issue where the
>> > kernel locks up in similar circumstances. As Julien noted, we get no
>> > output, and the watchdogs don't seem to work. It may be the case that
>> > Xorg and our process are calling ttm_bo_mem_force_space concurrently,
>> > but I don't think we have enough information yet to say for
>> > sure. Reverting this commit does not fix that issue. I have some small
>> > amount of evidence indicating that bos flagged for CPU access are
>> > getting placed in CPU inaccessible memory. Could that cause this sort =
of
>> > kernel lockup?
>>
>> Possibly, does this help?
>>
>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c
>> b/drivers/gpu/drm/radeon/radeon_ttm.c
>> index 37d68cd1f272..40d1bb467a71 100644
>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
>> @@ -198,7 +198,8 @@ static void radeon_evict_flags(struct
>> ttm_buffer_object *bo,
>>         case TTM_PL_VRAM:
>>                 if (rbo->rdev->ring[radeon_copy_ring_index(rbo->rdev)].r=
eady
>> =3D=3D false)
>>                         radeon_ttm_placement_from_domain(rbo,
>> RADEON_GEM_DOMAIN_CPU);
>> -               else if (rbo->rdev->mc.visible_vram_size <
>> rbo->rdev->mc.real_vram_size &&
>> +               else if (!(rbo->flags & RADEON_GEM_CPU_ACCESS) &&
>> +                        rbo->rdev->mc.visible_vram_size <
>> rbo->rdev->mc.real_vram_size &&
>>                          bo->mem.start < (rbo->rdev->mc.visible_vram_siz=
e
>> >> PAGE_SHIFT)) {
>>                         unsigned fpfn =3D rbo->rdev->mc.visible_vram_siz=
e
>> >> PAGE_SHIFT;
>>                         int i;
>>
>>
>>
>> --
>> Earthling Michel D=C3=A4nzer               |               http://www.am=
d.com
>> Libre software enthusiast             |             Mesa and X developer
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>
>

--001a1142987e2ea1e5054bc63117
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">Hi Michel,</span><div sty=
le=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8px"><div>Abou=
t the hard lockup, I noticed that I cannot have it with the following condi=
tions:</div><div><br></div><div>1. soft lockup fix (the 0-&gt;i change whic=
h avoids infinite loop)</div><div>2. Your suggestion:=C2=A0<span style=3D"f=
ont-size:12.8px">(!(rbo-&gt;flags &amp; RADEON_GEM_CPU_ACCESS)</span></div>=
<div>3. radeon.gartsize=3D512 radeon.vramlimit=3D1024 (any other values abo=
ve do not help, for example (1024, 1024) or (1024, 2048))</div><div><br></d=
iv><div>Without 1 and 2, but with 3, our test reproduces the soft lockup (j=
ust discovered few days ago).</div><div>Without 3 (and with or without 1., =
2.), our test reproduces the hard lockup which one does not give any info i=
n kern.log (sometimes some NUL ^@ characters but not always).</div><div><br=
></div><div><span style=3D"font-size:12.8px">We are converting this repro t=
est to a piglit test in order to share it but it will take some times. But =
to simplify it continuously uploads images with a size picked randomly and =
up to 4K. So TTM&#39;s eviction mechanism is hit a lot.</span><br></div><di=
v><br></div><div>(The card is a ForePro W600 Cape Verde 2048M )</div><div><=
br></div><div>I am happy to try any other suggestion.</div><div><br></div><=
div>Thx</div><div>Julien</div></div></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On 24 March 2017 at 19:01, Julien Isorce <span dir=
=3D"ltr">&lt;<a href=3D"mailto:julien.isorce@gmail.com" target=3D"_blank">j=
ulien.isorce@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div dir=3D"ltr">Hi Michel,<div><br></div><div>No this change does not =
help on the other issue (hard lockup).</div><div>I have no tried it in comb=
ination with the 0 -&gt; i change.=C2=A0</div><div><br></div><div>Thx anywa=
y.</div><span class=3D"HOEnZb"><font color=3D"#888888"><div>Julien</div><di=
v><br></div></font></span></div><div class=3D"HOEnZb"><div class=3D"h5"><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 24 March 2017 at =
10:03, Michel D=C3=A4nzer <span dir=3D"ltr">&lt;<a href=3D"mailto:michel@da=
enzer.net" target=3D"_blank">michel@daenzer.net</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><span>On 24/03/17 12:31 AM, Zachary Michaels w=
rote:<br>
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
diff --git a/drivers/gpu/drm/radeon/radeo<wbr>n_ttm.c b/drivers/gpu/drm/rad=
eon/radeo<wbr>n_ttm.c<br>
index 37d68cd1f272..40d1bb467a71 100644<br>
--- a/drivers/gpu/drm/radeon/radeo<wbr>n_ttm.c<br>
+++ b/drivers/gpu/drm/radeon/radeo<wbr>n_ttm.c<br>
@@ -198,7 +198,8 @@ static void radeon_evict_flags(struct ttm_buffer_object=
 *bo,<br>
<span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TTM_PL_VRAM:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rbo-&gt;rdev-&g=
t;ring[radeon_copy_r<wbr>ing_index(rbo-&gt;rdev)].ready =3D=3D false)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 radeon_ttm_placement_from_doma<wbr>in(rbo, RADEON_GEM_DOMAIN_CPU=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (rbo-&gt;rd=
ev-&gt;mc.visible_vram_si<wbr>ze &lt; rbo-&gt;rdev-&gt;mc.real_vram_size &a=
mp;&amp;<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (!(r=
bo-&gt;flags &amp; RADEON_GEM_CPU_ACCESS) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rbo-&gt;rdev-&gt;mc.visible_vram_siz<wbr>e &lt; rbo-&gt;rdev-&gt=
;mc.real_vram_size &amp;&amp;<br>
<span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0bo-&gt;mem.start &lt; (rbo-&gt;rdev-&gt;mc.visible_vra=
m_si<wbr>ze &gt;&gt; PAGE_SHIFT)) {<br>
</span><span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 unsigned fpfn =3D rbo-&gt;rdev-&gt;mc.visible_vram_si=
z<wbr>e &gt;&gt; PAGE_SHIFT;<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int i;<br>
<div class=3D"m_-1054403314543400146HOEnZb"><div class=3D"m_-10544033145434=
00146h5"><br>
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
<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dri-de=
vel@lists.freedesktop.or<wbr>g</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/l=
istinfo/dri-devel</a><br>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a1142987e2ea1e5054bc63117--

--===============0328191419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0328191419==--
