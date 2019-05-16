From: Daniel Kasak <d.j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Hard lockups with ROCM
Date: Thu, 16 May 2019 10:33:03 +1000
Message-ID: <CAF73Y=R96zUxCAEKopSvGReqB+sEFWcHhXSKnR98rpetMbKf4Q@mail.gmail.com>
References: <CAF73Y=QuYq3ALtP6xiPyqS+jm_TJCQQDyQ+WA5ZJG8EhWSKiTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0940686179=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAF73Y=QuYq3ALtP6xiPyqS+jm_TJCQQDyQ+WA5ZJG8EhWSKiTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0940686179==
Content-Type: multipart/alternative; boundary="0000000000006ef8540588f66b81"

--0000000000006ef8540588f66b81
Content-Type: text/plain; charset="UTF-8"

On Mon, May 13, 2019 at 11:44 AM Daniel Kasak <d.j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hi all. I had version 2.2.0 of the ROCM stack running on a 5.0.x and 5.1.0
> kernel. Things were going great with various boinc GPU tasks. But there is
> a setiathome GPU task which reliably gives me a hard lockup within about 30
> minutes of running. I actually had to do *two* emergency re-installs over
> the past week. Perhaps part of this was my fault ( running btrfs with lzo
> compression on my root partition ... ). But absolutely part of this was the
> hard lockups. I've tested all kinds of other things ( eg rebuilding lots of
> stuff under Gentoo ) ... I don't have a general stability issue even under
> hours of high load. But after restarting boinc with that same setiathome
> task ... <bang>!
>
> If someone wants me to sacrifice another installation, they can point me
> to instructions for trying to gather more information.
>
> Anyway ... perhaps more work around detecting and recovering from GPU
> lockups is in order?
>
> Dan
>

<sigh>

That's what I was afraid of :(

--0000000000006ef8540588f66b81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, May 13, 2019 at 11:44 AM Daniel Kasak &lt;<a href=3D"mailto:=
d.j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">d.j.kasak.dk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi all.=
 I had version 2.2.0 of the ROCM stack running on a 5.0.x and 5.1.0 kernel.=
 Things were going great with various boinc GPU tasks. But there is a setia=
thome GPU task which reliably gives me a hard lockup within about 30 minute=
s of running. I actually had to do *two* emergency re-installs over the pas=
t week. Perhaps part of this was my fault ( running btrfs with lzo compress=
ion on my root partition ... ). But absolutely part of this was the hard lo=
ckups. I&#39;ve tested all kinds of other things ( eg rebuilding lots of st=
uff under Gentoo ) ... I don&#39;t have a general stability issue even unde=
r hours of high load. But after restarting boinc with that same setiathome =
task ... &lt;bang&gt;!</div><div><br></div><div>If someone wants me to sacr=
ifice another installation, they can point me to instructions for trying to=
 gather more information.</div><div><br></div><div>Anyway ... perhaps more =
work around detecting and recovering from GPU lockups is in order?</div><di=
v><br></div><div>Dan<br></div></div></blockquote><div><br></div><div>&lt;si=
gh&gt;</div><div><br></div><div>That&#39;s what I was afraid of :(<br></div=
></div></div>

--0000000000006ef8540588f66b81--

--===============0940686179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0940686179==--
