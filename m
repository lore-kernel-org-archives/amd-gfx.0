From: Zachary Michaels <zmichaels@oblong.com>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Thu, 23 Mar 2017 08:31:01 -0700
Message-ID: <CAOfP2NDoHof0UhQbz53N9WW8jLH3yC_e+ESrTbdd9Ldb6RYg=Q@mail.gmail.com>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0271376360=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Julien Isorce <jisorce@oblong.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0271376360==
Content-Type: multipart/alternative; boundary=94eb2c0b6b9088e801054b67904f

--94eb2c0b6b9088e801054b67904f
Content-Type: text/plain; charset=UTF-8

>
> Was userspace maybe performing concurrent CPU access to the BOs in
> question?


As far as I know Julien has demonstrated that this is not the case.


> I hope we can find a better solution.


Understood -- I thought you might not want to take this patch, but I went
ahead and sent it out because Christian requested it, and it seems like he
doesn't think VRAM bos should ever evict back to VRAM at all?

Is my understanding of the original commit correct in that it tries to
rewrite the eviction placements of CPU accessible bos so that they are
either size zero (fpfn and lpfn = start of inaccessible VRAM) or they are
in inaccessible VRAM (fpfn = start of inaccessible VRAM and lpfn = 0)?

In this case, to me it seems that the simplest fix would be to iterate
using i to rewrite all the VRAM placements instead of just the first one
(rbo->placements[i] instead of rbo->placements[0]). In the case where
RADEON_GEM_NO_CPU_ACCESS
is set, the second placement will be in CPU accessible VRAM, and that
doesn't seem correct to me as there is no longer any sort of ordering for
evictions. (Unfortunately I'm not currently in a position to test whether
this fixes our issue.) Sorry, I meant to make a note of this originally.

Also, I don't claim to understand this code well enough, but I wonder: if
these sorts of evictions are desirable, would it make more sense to treat
CPU inaccessible/accessible VRAM as distinct entities with their own lrus?

I should also note that we are experiencing another issue where the kernel
locks up in similar circumstances. As Julien noted, we get no output, and
the watchdogs don't seem to work. It may be the case that Xorg and our
process are calling ttm_bo_mem_force_space concurrently, but I don't think
we have enough information yet to say for sure. Reverting this commit does
not fix that issue. I have some small amount of evidence indicating that
bos flagged for CPU access are getting placed in CPU inaccessible memory.
Could that cause this sort of kernel lockup?

Thanks for your help.

--94eb2c0b6b9088e801054b67904f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Was userspace maybe performin=
g concurrent CPU access to the BOs in question?</blockquote><div><br></div>=
<div>As far as I know Julien has demonstrated that this is not the case.=C2=
=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>I hope we can find a better solution.</blockquote><div><br></div><div><div=
>Understood -- I thought you might not want to take this patch, but I went =
ahead and sent it out because Christian requested it, and it seems like he =
doesn&#39;t think VRAM bos should ever evict back to VRAM at all?</div><div=
><br></div><div>Is my understanding of the original commit correct in that =
it tries to rewrite the eviction placements of CPU accessible bos so that t=
hey are either size zero (fpfn and lpfn =3D start of inaccessible VRAM) or =
they are in inaccessible VRAM (fpfn =3D start of inaccessible VRAM and lpfn=
 =3D 0)?</div><div><br></div><div>In this case, to me it seems that the sim=
plest fix would be to iterate using i to rewrite all the VRAM placements in=
stead of just the first one (rbo-&gt;placements[i] instead of rbo-&gt;place=
ments[0]). In the case where=C2=A0<span style=3D"font-size:12.8px">RADEON_G=
EM_NO_CPU_ACCESS is set, the second placement will be in CPU accessible VRA=
M, and that doesn&#39;t seem correct to me as there is no longer any sort o=
f ordering for evictions.</span>=C2=A0(Unfortunately I&#39;m not currently =
in a position to test whether this fixes our issue.) Sorry, I meant to make=
 a note of this originally.</div><div><br></div><div>Also, I don&#39;t clai=
m to understand this code well enough, but I wonder: if these sorts of evic=
tions are desirable, would it make more sense to treat CPU inaccessible/acc=
essible VRAM as distinct entities with their own lrus?</div><div><br></div>=
<div>I should also note that we are experiencing another issue where the ke=
rnel locks up in similar circumstances. As Julien noted, we get no output, =
and the watchdogs don&#39;t seem to work. It may be the case that Xorg and =
our process are calling ttm_bo_mem_force_space concurrently, but I don&#39;=
t think we have enough information yet to say for sure.=C2=A0Reverting this=
 commit does not fix that issue.=C2=A0I have some small amount of evidence =
indicating that bos flagged for CPU access are getting placed in CPU inacce=
ssible memory. Could that cause this sort of kernel lockup?</div></div><div=
><br></div><div>Thanks for your help.</div></div></div></div>

--94eb2c0b6b9088e801054b67904f--

--===============0271376360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0271376360==--
