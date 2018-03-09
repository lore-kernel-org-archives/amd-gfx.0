From: Dawson Dias <thexerothermicsclerodermoid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Ryzen 5 2400G Stuttering since 2018-03-07
Date: Fri, 9 Mar 2018 17:00:16 +0530
Message-ID: <CAFuwKQO7yO4UAjrtdfc2kHJ+wOYdsURyCvSdPx7FmxVQ__kjtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0073988708=="
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

--===============0073988708==
Content-Type: multipart/alternative; boundary="001a1140b778060c010566f91fa3"

--001a1140b778060c010566f91fa3
Content-Type: text/plain; charset="UTF-8"

Hello

I'm experiencing extreme stuttering in X on my Ryzen 2400G. This stuttering
can be noticed even while only moving the mouse.
Said stuttering does not exist under Wayland.

This constant stuttering started on 2018-03-07 with the patches that were
pushed on that day. Stuttering occurs on both branches drm-next-4.17
(f6c3b601bd490eda08c27b03607448abd4b4841b) and drm-next-4.17-wip
(6896a66bc6d0fcb69b6be564fa43f02c09348b72).

dmesg.log <https://bpaste.net/raw/06e6dcc4545b>
journalctl.log <https://bpaste.net/raw/f6f3dc8d108d>

What sort of information do we require to pinpoint the source of this
regression and fix it?

-Dawson Dias

--001a1140b778060c010566f91fa3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello<div><br></div><div>I&#39;m experiencing extreme stut=
tering in X on my Ryzen 2400G. This stuttering can be noticed even while on=
ly moving the mouse.</div><div>Said stuttering does not exist under Wayland=
.</div><div><br></div><div>This constant stuttering started on 2018-03-07 w=
ith the patches that were pushed on that day. Stuttering occurs on both bra=
nches drm-next-4.17 (f6c3b601bd490eda08c27b03607448abd4b4841b) and drm-next=
-4.17-wip (6896a66bc6d0fcb69b6be564fa43f02c09348b72).</div><div><br></div><=
div><a href=3D"https://bpaste.net/raw/06e6dcc4545b">dmesg.log</a></div><div=
><a href=3D"https://bpaste.net/raw/f6f3dc8d108d">journalctl.log</a></div><d=
iv><br></div><div>What sort of information do we require to pinpoint the so=
urce of this regression and fix it?</div><div><br></div><div><div class=3D"=
gmail_extra"><div><div class=3D"gmail_signature"><div dir=3D"ltr"><div clas=
s=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"arial, helvetica, sans=
-serif">-Dawson Dias</font></div></div></div></div></div></div></div></div>

--001a1140b778060c010566f91fa3--

--===============0073988708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0073988708==--
