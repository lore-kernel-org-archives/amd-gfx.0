From: Daniel Kasak <d.j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Hard lockups with ROCM
Date: Mon, 13 May 2019 11:44:11 +1000
Message-ID: <CAF73Y=QuYq3ALtP6xiPyqS+jm_TJCQQDyQ+WA5ZJG8EhWSKiTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0020501746=="
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

--===============0020501746==
Content-Type: multipart/alternative; boundary="00000000000066fa0e0588bb1097"

--00000000000066fa0e0588bb1097
Content-Type: text/plain; charset="UTF-8"

Hi all. I had version 2.2.0 of the ROCM stack running on a 5.0.x and 5.1.0
kernel. Things were going great with various boinc GPU tasks. But there is
a setiathome GPU task which reliably gives me a hard lockup within about 30
minutes of running. I actually had to do *two* emergency re-installs over
the past week. Perhaps part of this was my fault ( running btrfs with lzo
compression on my root partition ... ). But absolutely part of this was the
hard lockups. I've tested all kinds of other things ( eg rebuilding lots of
stuff under Gentoo ) ... I don't have a general stability issue even under
hours of high load. But after restarting boinc with that same setiathome
task ... <bang>!

If someone wants me to sacrifice another installation, they can point me to
instructions for trying to gather more information.

Anyway ... perhaps more work around detecting and recovering from GPU
lockups is in order?

Dan

--00000000000066fa0e0588bb1097
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all. I had version 2.2.0 of the ROCM stack running=
 on a 5.0.x and 5.1.0 kernel. Things were going great with various boinc GP=
U tasks. But there is a setiathome GPU task which reliably gives me a hard =
lockup within about 30 minutes of running. I actually had to do *two* emerg=
ency re-installs over the past week. Perhaps part of this was my fault ( ru=
nning btrfs with lzo compression on my root partition ... ). But absolutely=
 part of this was the hard lockups. I&#39;ve tested all kinds of other thin=
gs ( eg rebuilding lots of stuff under Gentoo ) ... I don&#39;t have a gene=
ral stability issue even under hours of high load. But after restarting boi=
nc with that same setiathome task ... &lt;bang&gt;!</div><div><br></div><di=
v>If someone wants me to sacrifice another installation, they can point me =
to instructions for trying to gather more information.</div><div><br></div>=
<div>Anyway ... perhaps more work around detecting and recovering from GPU =
lockups is in order?</div><div><br></div><div>Dan<br></div></div>

--00000000000066fa0e0588bb1097--

--===============0020501746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0020501746==--
