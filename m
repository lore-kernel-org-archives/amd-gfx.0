From: Jeremy Newton <alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Issue with amd-staging-4.7 on rx480
Date: Wed, 5 Oct 2016 22:54:41 -0400
Message-ID: <CAHOSEu8-fa0RznKX7s-vbU_1g_eCaa-ZBp=0ySP5X_VqJA13Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0882946322=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0882946322==
Content-Type: multipart/alternative; boundary=001a1148390a51f176053e296ae5

--001a1148390a51f176053e296ae5
Content-Type: text/plain; charset=UTF-8

Hello,

I'm currently regularly building and using the amd-staging-4.7 linux
branch, which can be found here:

https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-4.7

It seems that one of the commits pushed on 2016-10-03 broke something, and
I just wanted to give the devs a heads up in case no one noticed. I'm
guessing it was caused by one of the commits in the range of e3bb40f all
the way up to 78d1842.

I'm using an RX480, polaris10. The issue seems to have two symptoms:
- Plymouth (the boot splash screen) seems to get visually corrupted or just
blacked out.
- After login, the screen just remains black until I hard reset.

Reverting back to 8f877a8 seems to fix it. I'm using Fedora 24 with GNOME.
As well, I haven't had time to bisect, but I can do so if desired.

Thanks!

--001a1148390a51f176053e296ae5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"text-align:right"><div style=3D"text-a=
lign:start">Hello,</div><div style=3D"text-align:start"><br></div><div styl=
e=3D"text-align:start">I&#39;m currently regularly building and using the a=
md-staging-4.7 linux branch, which can be found here:</div><div style=3D"te=
xt-align:start"><br></div><div style=3D"text-align:start"><a href=3D"https:=
//cgit.freedesktop.org/~agd5f/linux/log/?h=3Damd-staging-4.7">https://cgit.=
freedesktop.org/~agd5f/linux/log/?h=3Damd-staging-4.7</a></div><div style=
=3D"text-align:start"><br></div><div style=3D"text-align:start">It seems th=
at one of the commits pushed on 2016-10-03 broke something, and I just want=
ed to give the devs a heads up in case no one noticed. I&#39;m guessing it =
was caused by one of the commits in the range of e3bb40f all the way up to =
78d1842.</div><div style=3D"text-align:start"><br></div><div style=3D"text-=
align:start">I&#39;m using an RX480, polaris10. The issue seems to have two=
 symptoms:</div><div style=3D"text-align:start">- Plymouth (the boot splash=
 screen) seems to get visually corrupted or just blacked out.</div><div sty=
le=3D"text-align:start">- After login, the screen just remains black until =
I hard reset.</div><div style=3D"text-align:start"><br></div><div style=3D"=
text-align:start">Reverting back to 8f877a8 seems to fix it. I&#39;m using =
Fedora 24 with GNOME. As well, I haven&#39;t had time to bisect, but I can =
do so if desired.</div><div style=3D"text-align:start"><br></div><div style=
=3D"text-align:start">Thanks!</div></span></div></div>

--001a1148390a51f176053e296ae5--

--===============0882946322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0882946322==--
