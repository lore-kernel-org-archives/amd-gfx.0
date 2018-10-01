From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: VegaM DP dpms issue
Date: Mon, 1 Oct 2018 11:17:30 +0100
Message-ID: <CAHbf0-Ga449y3L-nrM6SGGiG9OUFa=-rTUFKXnmuSvmUx4c5dw@mail.gmail.com>
References: <CAFiZx5yVF+0uZUQMwQVXRs4Bms9Q0J85ZHr84ThyKioQg9w0oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1547436941=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFiZx5yVF+0uZUQMwQVXRs4Bms9Q0J85ZHr84ThyKioQg9w0oQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Louis Garcia <louisgtwo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1547436941==
Content-Type: multipart/alternative; boundary="000000000000914f270577281d43"

--000000000000914f270577281d43
Content-Type: text/plain; charset="UTF-8"

Hi

I'm pretty sure unless you're offloading using DRI_PRIME=1 then it'll be
your Intel graphics that'll be driving the displays

I'd recommend you raise a bug on https://bugs.freedesktop.org/ under DRI
then DRM/Intel

Make sure you attach your dmesg and Xorg.0.log and hopefully they'll be
able to help

Cheers

Mike

On Sun, 30 Sep 2018 at 17:23 Louis Garcia <louisgtwo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I am having an issue with intel NUC8i7HNK with AMD Vega M. I have three
> Dell U2415 monitors connected to one mDP daisychained. When the monitors go
> to sleep (dpms) trying to wake up the monitors after half hour or more
> fails, touching the keyboard and mouse. Only way is a hard reboot. Same
> monitors connected to other systems wake up fine. I seen old bug reports on
> this issue but seems I'm hitting this bug again.
>
> If this is not the proper list please let me kno. --Thanks
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000914f270577281d43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>I&#39;m pretty sure unless you&#39;r=
e offloading using DRI_PRIME=3D1 then it&#39;ll be your Intel graphics that=
&#39;ll be driving the displays</div><div><br></div><div>I&#39;d recommend =
you raise a bug on=C2=A0<a href=3D"https://bugs.freedesktop.org/">https://b=
ugs.freedesktop.org/</a>=C2=A0under DRI then DRM/Intel</div><div><br></div>=
<div>Make sure you attach your dmesg and Xorg.0.log and hopefully they&#39;=
ll be able to help</div><div><br></div><div>Cheers</div><div><br></div><div=
>Mike=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On S=
un, 30 Sep 2018 at 17:23 Louis Garcia &lt;<a href=3D"mailto:louisgtwo@gmail=
.com">louisgtwo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><div dir=3D"ltr"><div>I am having an issue with intel NUC8i7HNK with =
AMD Vega M. I have three Dell U2415 monitors connected to one mDP daisychai=
ned. When the monitors go to sleep (dpms) trying to wake up the monitors af=
ter half hour or more fails, touching the keyboard and mouse. Only way is a=
 hard reboot. Same monitors connected to other systems wake up fine. I seen=
 old bug reports on this issue but seems I&#39;m hitting this bug again.</d=
iv><div><br></div><div>If this is not the proper list please let me kno. --=
Thanks<br></div></div>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--000000000000914f270577281d43--

--===============1547436941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1547436941==--
