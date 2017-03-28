From: Julien Isorce <julien.isorce@gmail.com>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Tue, 28 Mar 2017 12:00:00 +0100
Message-ID: <CAHWPjbUhw6Bbb6TyQ1EMAid4hbMp8gLx64G6cK7e=-RkDCTB0g@mail.gmail.com>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
 <CAOfP2NDoHof0UhQbz53N9WW8jLH3yC_e+ESrTbdd9Ldb6RYg=Q@mail.gmail.com>
 <5f26f8a1-e5bd-ca7a-c7ee-08c8f04f2110@daenzer.net>
 <CAHWPjbUEQCr4Qox5W-C8LYep7-fH=3FV_qhYydpOg2LvqGbZUw@mail.gmail.com>
 <CAHWPjbX8rv2FJniBjfYtqtXo-iCjvC9bNem0kv4bfbp=gbSBAQ@mail.gmail.com>
 <8c7a81e7-40c6-f2c0-b647-576b8dc4e5e0@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0168766278=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <8c7a81e7-40c6-f2c0-b647-576b8dc4e5e0@daenzer.net>
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
Cc: Zachary Michaels <zmichaels@oblong.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Julien Isorce <jisorce@oblong.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0168766278==
Content-Type: multipart/alternative; boundary=f403045dd8647e18a6054bc85c00

--f403045dd8647e18a6054bc85c00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 28 March 2017 at 10:36, Michel D=C3=A4nzer <michel@daenzer.net> wrote:

> On 28/03/17 05:24 PM, Julien Isorce wrote:
> > Hi Michel,
> >
> > About the hard lockup, I noticed that I cannot have it with the
> > following conditions:
> >
> > 1. soft lockup fix (the 0->i change which avoids infinite loop)
> > 2. Your suggestion: (!(rbo->flags & RADEON_GEM_CPU_ACCESS)
> > 3. radeon.gartsize=3D512 radeon.vramlimit=3D1024 (any other values abov=
e do
> > not help, for example (1024, 1024) or (1024, 2048))
> >
> > Without 1 and 2, but with 3, our test reproduces the soft lockup (just
> > discovered few days ago).
> > Without 3 (and with or without 1., 2.), our test reproduces the hard
> > lockup which one does not give any info in kern.log (sometimes some NUL
> > ^@ characters but not always).
>
> What exactly does "hard lockup" mean? What are the symptoms?
>
>
Screens are frozen, cannot ssh, no mouse/keyboard, no kernel panic.
Requires hard reboot.
After reboot, nothing in /var/crash, nothing in /sys/fs/pstore, nothing in
kern.log except sometimes some nul characters ^@.
Adding traces it looks like the test app was still in a ioctl(RADEON_CS)
but it is difficult to rely on that since this is called a lot.
Using a serial console did not show additional debug messages. kgdb was not
useful but probably worth another attempt.

--f403045dd8647e18a6054bc85c00
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 28 March 2017 at 10:36, Michel D=C3=A4nzer <span dir=3D"ltr">&lt;<a href=
=3D"mailto:michel@daenzer.net" target=3D"_blank">michel@daenzer.net</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span c=
lass=3D"m_2777511630697423611gmail-">On 28/03/17 05:24 PM, Julien Isorce wr=
ote:<br>
&gt; Hi Michel,<br>
&gt;<br>
&gt; About the hard lockup, I noticed that I cannot have it with the<br>
&gt; following conditions:<br>
&gt;<br>
&gt; 1. soft lockup fix (the 0-&gt;i change which avoids infinite loop)<br>
&gt; 2. Your suggestion: (!(rbo-&gt;flags &amp; RADEON_GEM_CPU_ACCESS)<br>
&gt; 3. radeon.gartsize=3D512 radeon.vramlimit=3D1024 (any other values abo=
ve do<br>
&gt; not help, for example (1024, 1024) or (1024, 2048))<br>
&gt;<br>
&gt; Without 1 and 2, but with 3, our test reproduces the soft lockup (just=
<br>
&gt; discovered few days ago).<br>
&gt; Without 3 (and with or without 1., 2.), our test reproduces the hard<b=
r>
&gt; lockup which one does not give any info in kern.log (sometimes some NU=
L<br>
&gt; ^@ characters but not always).<br>
<br>
</span>What exactly does &quot;hard lockup&quot; mean? What are the symptom=
s?<br>
<div class=3D"m_2777511630697423611gmail-HOEnZb"><div class=3D"m_2777511630=
697423611gmail-h5"><br></div></div></blockquote><div><br></div><div>Screens=
 are frozen, cannot ssh, no mouse/keyboard, no kernel panic. Requires hard =
reboot.</div><div>After reboot, nothing in /var/crash, nothing in /sys/fs/p=
store, nothing in kern.log except sometimes some nul characters ^@.</div><d=
iv>Adding traces it looks like the test app was still in a ioctl(RADEON_CS)=
 but it is difficult to rely on that since this is called a lot.</div><div>=
Using a serial console did not show additional debug messages. kgdb was not=
 useful but probably worth another attempt.</div><div><br></div></div></div=
></div>

--f403045dd8647e18a6054bc85c00--

--===============0168766278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0168766278==--
