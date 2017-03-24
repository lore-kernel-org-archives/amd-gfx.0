From: Julien Isorce <julien.isorce@gmail.com>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Fri, 24 Mar 2017 09:50:36 +0000
Message-ID: <CAHWPjbXbAo8CVSJDK1GzN=M4pMobMw9XVQVfVeGVM4H=n36vuQ@mail.gmail.com>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
 <CAGCDoEGuMVnv6rA-y5XDbc6hiNWiTg6nt4e4u2dZObeY8roKXA@mail.gmail.com>
 <8020e778-c9c8-e67b-428a-436f2f1c0d7b@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1663818969=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <8020e778-c9c8-e67b-428a-436f2f1c0d7b@daenzer.net>
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
Cc: amd-gfx@lists.freedesktop.org, Zachary Michaels <zmichaels@oblong.com>, Julien Isorce <jisorce@oblong.com>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

--===============1663818969==
Content-Type: multipart/alternative; boundary=94eb2c123994f7023b054b76ecef

--94eb2c123994f7023b054b76ecef
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michel,

(Just for other readers my reply has been delayed on the mailing lists and
should have been on second position)

We have actually spotted this /0/i/ but somehow I convinced myself it was
intentional. The reason I found was that you wanted to set the fpfn only if
there is 2 placements, which means it will try to move from accessible to
inaccessible.

I will have a go with that change and let you know. I do not remember if I
tried it for this soft lockup. But for sure it does not solve the hard
lockup that Zach also mentioned at the end of his reply. I am saying that
because this other issue has some similarities (same ioctl call).

But in general, isn't "radeon_lockup_timeout" supposed to detect this
situation ?

Thx
Julien


On 24 March 2017 at 09:24, Michel D=C3=A4nzer <michel@daenzer.net> wrote:

> On 23/03/17 06:26 PM, Julien Isorce wrote:
> > Hi Michel,
> >
> > When it happens, the main thread of our gl based app is stuck on a
> > ioctl(RADEON_CS). I set RADEON_THREAD=3Dfalse to ease the debugging but
> > same thing happens if true. Other threads are only si_shader:0,1,2,3 an=
d
> > are doing nothing, just waiting for jobs. I can also do sudo gdb -p
> > $(pidof Xorg) to block the X11 server, to make sure there is no ping
> > pong between 2 processes. All other processes are not loading
> > dri/radeonsi_dri.so . And adding a few traces shows that the above ioct=
l
> > call is looping for ever on
> > https://github.com/torvalds/linux/blob/master/drivers/gpu/
> drm/ttm/ttm_bo.c#L819
> > <https://github.com/torvalds/linux/blob/master/drivers/gpu/
> drm/ttm/ttm_bo.c#L819> and
> > comes from
> > mesa https://cgit.freedesktop.org/mesa/mesa/tree/src/gallium/
> winsys/radeon/drm/radeon_drm_cs.c#n454
> > .
> >
> > After adding even more traces I can see that the bo, which is being
> > indefinitely evicted, has the flag RADEON_GEM_NO_CPU_ACCESS.
> > And it gets 3 potential placements after calling "radeon_evict_flags".
> >  1: VRAM cpu inaccessible, fpfn is 65536
> >  2: VRAM cpu accessible, fpfn is 0
> >  3: GTT, fpfn is 0
> >
> > And it looks like it continuously succeeds to move on the second
> > placement. So I might be wrong but it looks it is not even a ping pong
> > between VRAM accessible / not accessible, it just keeps being blited in
> > the CPU accessible part of the VRAM.
>
> Thanks for the detailed description! AFAICT this can only happen due to
> a silly mistake I made in this code. Does this fix it?
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/
> radeon_ttm.c
> index 5c7cf644ba1d..37d68cd1f272 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -213,8 +213,8 @@ static void radeon_evict_flags(struct
> ttm_buffer_object *bo,
>                         rbo->placement.num_busy_placement =3D 0;
>                         for (i =3D 0; i < rbo->placement.num_placement; i=
++)
> {
>                                 if (rbo->placements[i].flags &
> TTM_PL_FLAG_VRAM) {
> -                                       if (rbo->placements[0].fpfn < fpf=
n)
> -                                               rbo->placements[0].fpfn =
=3D
> fpfn;
> +                                       if (rbo->placements[i].fpfn < fpf=
n)
> +                                               rbo->placements[i].fpfn =
=3D
> fpfn;
>                                 } else {
>                                         rbo->placement.busy_placement =3D
>                                                 &rbo->placements[i];
>
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--94eb2c123994f7023b054b76ecef
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Michel,<div><br></div><div>(Just for other readers my r=
eply has been delayed on the mailing lists and should have been on second p=
osition)</div><div><br></div><div>We have actually spotted this /0/i/ but s=
omehow I convinced myself it was intentional. The reason I found was that y=
ou wanted to set the fpfn only if there is 2 placements, which means it wil=
l try to move from accessible to inaccessible.</div><div><br></div><div>I w=
ill have a go with that change and let you know. I do not remember if I tri=
ed it for this soft lockup. But for sure it does not solve the hard lockup =
that Zach also mentioned at the end of his reply. I am saying that because =
this other issue has some similarities (same ioctl call).</div><div><br></d=
iv><div><span style=3D"font-size:12.8px">But in general, isn&#39;t &quot;ra=
deon_lockup_timeout&quot; supposed to detect this situation ?</span><br></d=
iv><div><br></div><div>Thx</div><div>Julien</div><div><br></div></div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 24 March 2017 at 09=
:24, Michel D=C3=A4nzer <span dir=3D"ltr">&lt;<a href=3D"mailto:michel@daen=
zer.net" target=3D"_blank">michel@daenzer.net</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 23/03=
/17 06:26 PM, Julien Isorce wrote:<br>
&gt; Hi Michel,<br>
&gt;<br>
&gt; When it happens, the main thread of our gl based app is stuck on a<br>
&gt; ioctl(RADEON_CS). I set RADEON_THREAD=3Dfalse to ease the debugging bu=
t<br>
&gt; same thing happens if true. Other threads are only si_shader:0,1,2,3 a=
nd<br>
&gt; are doing nothing, just waiting for jobs. I can also do sudo gdb -p<br=
>
&gt; $(pidof Xorg) to block the X11 server, to make sure there is no ping<b=
r>
&gt; pong between 2 processes. All other processes are not loading<br>
&gt; dri/radeonsi_dri.so . And adding a few traces shows that the above ioc=
tl<br>
&gt; call is looping for ever on<br>
&gt; <a href=3D"https://github.com/torvalds/linux/blob/master/drivers/gpu/d=
rm/ttm/ttm_bo.c#L819" rel=3D"noreferrer" target=3D"_blank">https://github.c=
om/torvalds/<wbr>linux/blob/master/drivers/gpu/<wbr>drm/ttm/ttm_bo.c#L819</=
a><br>
&gt; &lt;<a href=3D"https://github.com/torvalds/linux/blob/master/drivers/g=
pu/drm/ttm/ttm_bo.c#L819" rel=3D"noreferrer" target=3D"_blank">https://gith=
ub.com/torvalds/<wbr>linux/blob/master/drivers/gpu/<wbr>drm/ttm/ttm_bo.c#L8=
19</a>&gt; and<br>
&gt; comes from<br>
&gt; mesa <a href=3D"https://cgit.freedesktop.org/mesa/mesa/tree/src/galliu=
m/winsys/radeon/drm/radeon_drm_cs.c#n454" rel=3D"noreferrer" target=3D"_bla=
nk">https://cgit.freedesktop.org/<wbr>mesa/mesa/tree/src/gallium/<wbr>winsy=
s/radeon/drm/radeon_drm_<wbr>cs.c#n454</a><br>
&gt; .<br>
&gt;<br>
&gt; After adding even more traces I can see that the bo, which is being<br=
>
&gt; indefinitely evicted, has the flag RADEON_GEM_NO_CPU_ACCESS.<br>
&gt; And it gets 3 potential placements after calling &quot;radeon_evict_fl=
ags&quot;.<br>
&gt;=C2=A0 1: VRAM cpu inaccessible, fpfn is 65536<br>
&gt;=C2=A0 2: VRAM cpu accessible, fpfn is 0<br>
&gt;=C2=A0 3: GTT, fpfn is 0<br>
&gt;<br>
&gt; And it looks like it continuously succeeds to move on the second<br>
&gt; placement. So I might be wrong but it looks it is not even a ping pong=
<br>
&gt; between VRAM accessible / not accessible, it just keeps being blited i=
n<br>
&gt; the CPU accessible part of the VRAM.<br>
<br>
</div></div>Thanks for the detailed description! AFAICT this can only happe=
n due to<br>
a silly mistake I made in this code. Does this fix it?<br>
<br>
diff --git a/drivers/gpu/drm/radeon/<wbr>radeon_ttm.c b/drivers/gpu/drm/rad=
eon/<wbr>radeon_ttm.c<br>
index 5c7cf644ba1d..37d68cd1f272 100644<br>
--- a/drivers/gpu/drm/radeon/<wbr>radeon_ttm.c<br>
+++ b/drivers/gpu/drm/radeon/<wbr>radeon_ttm.c<br>
@@ -213,8 +213,8 @@ static void radeon_evict_flags(struct ttm_buffer_object=
 *bo,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rbo-&gt;placement.num_busy_<wbr>placement =3D 0;<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; rbo-&gt;placement.num_plac=
ement; i++) {<br>
</span><span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rbo-&gt;=
placements[i].flags &amp; TTM_PL_FLAG_VRAM) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rbo-&=
gt;placements[0].fpfn &lt; fpfn)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0rbo-&gt;placements[0].fpfn =3D fpfn;<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (rbo-&gt;placements[i].fpfn &lt; fpfn)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0rbo-&gt;placements[i].fpfn =3D fpfn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rbo-&gt;=
placement.busy_placement =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;rbo-&gt;placements[i];<br>
<span class=3D"im HOEnZb"><br>
<br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</span><div class=3D"HOEnZb"><div class=3D"h5">____________________________=
__<wbr>_________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesk=
top.<wbr>org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/l=
istinfo/dri-devel</a><br>
</div></div></blockquote></div><br></div>

--94eb2c123994f7023b054b76ecef--

--===============1663818969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1663818969==--
