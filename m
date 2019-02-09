From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: The problem "ring gfx timeout" are experienced yet another AMD
 GPU Vega 8 user
Date: Sat, 9 Feb 2019 12:01:06 -0500
Message-ID: <CAAxE2A4tM-OoxcnLw14M8aZJLPLnPm2aN4fpTVQX_aUyJ9OBNw@mail.gmail.com>
References: <CABXGCsMas72q52GYvH+5Po-KDPfqu74XO_YznqJKnp+-+1Mnww@mail.gmail.com>
 <e92cffb7-6627-6f52-70de-e09d9bdbbe0a@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0669174590=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e92cffb7-6627-6f52-70de-e09d9bdbbe0a-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: mikhail <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0669174590==
Content-Type: multipart/alternative; boundary="000000000000436abf058179060e"

--000000000000436abf058179060e
Content-Type: text/plain; charset="UTF-8"

I don't see any attachments here.

Marek

On Sat, Feb 9, 2019, 11:37 AM Grodzovsky, Andrey <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org
wrote:

> +Marek
>
> Can't find the last fence seqno from mmCP_EOP_LAST_FENCE_LO in gfx ring
> dump (probably that seqno wasn't really the last if the register was
> dumped several times before) but since waves were dumped could be some
> shader issue. Marek, could you please give it a quick look ?
>
> Andrey
>
> On 2/9/19 7:53 AM, Mikhail Gavrilov wrote:
> > Hi Andrey,
> > in our Linux chat yet another AMD GPU user complains on problem with
> > `ring gfx timeout`.
> > He said that problem happens when he played in the game "Hearts of Iron
> 4".
> > His config:
> > - APU: Ryzen 2200G
> > - Kernel: 4.20.6
> > - LLVM: 7.0.0
> > - MESA: 18.2.8
> >
> > All logs which he collected with UMR I attach it here.
> >
> > Can you look please what happened with his GPU?
> >
> > --
> > Best Regards,
> > Mike Gavrilov.
>

--000000000000436abf058179060e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I don&#39;t see any attachments here.<div dir=3D"auto"><b=
r></div><div dir=3D"auto">Marek</div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr">On Sat, Feb 9, 2019, 11:37 AM Grodzovsky, Andrey &lt;<a hre=
f=3D"mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org">Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org</a> wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">+Marek<br>
<br>
Can&#39;t find the last fence seqno from mmCP_EOP_LAST_FENCE_LO in gfx ring=
 <br>
dump (probably that seqno wasn&#39;t really the last if the register was <b=
r>
dumped several times before) but since waves were dumped could be some <br>
shader issue. Marek, could you please give it a quick look ?<br>
<br>
Andrey<br>
<br>
On 2/9/19 7:53 AM, Mikhail Gavrilov wrote:<br>
&gt; Hi Andrey,<br>
&gt; in our Linux chat yet another AMD GPU user complains on problem with<b=
r>
&gt; `ring gfx timeout`.<br>
&gt; He said that problem happens when he played in the game &quot;Hearts o=
f Iron 4&quot;.<br>
&gt; His config:<br>
&gt; - APU: Ryzen 2200G<br>
&gt; - Kernel: 4.20.6<br>
&gt; - LLVM: 7.0.0<br>
&gt; - MESA: 18.2.8<br>
&gt;<br>
&gt; All logs which he collected with UMR I attach it here.<br>
&gt;<br>
&gt; Can you look please what happened with his GPU?<br>
&gt;<br>
&gt; --<br>
&gt; Best Regards,<br>
&gt; Mike Gavrilov.<br>
</blockquote></div>

--000000000000436abf058179060e--

--===============0669174590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0669174590==--
