From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: The problem "ring gfx timeout" are experienced yet another AMD
 GPU Vega 8 user
Date: Tue, 26 Feb 2019 14:56:29 -0500
Message-ID: <CAAxE2A4Xdsutk=teU=vi_Gnr2tuwinu6_JSfkoqTGwd1NrSpxQ@mail.gmail.com>
References: <CABXGCsMas72q52GYvH+5Po-KDPfqu74XO_YznqJKnp+-+1Mnww@mail.gmail.com>
 <e92cffb7-6627-6f52-70de-e09d9bdbbe0a@amd.com>
 <CAAxE2A4tM-OoxcnLw14M8aZJLPLnPm2aN4fpTVQX_aUyJ9OBNw@mail.gmail.com>
 <CABXGCsMJKKu6DxvKvD8U6Ffkmt8KinNS96w4ygZ7xaemvEhocg@mail.gmail.com>
 <CAAxE2A6US6YBpESnwqm-EGsDapOVVfbHXxdrkjG1UddFPO0mOQ@mail.gmail.com>
 <CABXGCsOWGpop=5_a6nrRoqWSWagkMg_sYCPL8ZuSuByvcDDu+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1453893482=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CABXGCsOWGpop=5_a6nrRoqWSWagkMg_sYCPL8ZuSuByvcDDu+w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1453893482==
Content-Type: multipart/alternative; boundary="0000000000002e69210582d176f5"

--0000000000002e69210582d176f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sadly, the logs don't contain any clue as to why it hangs.

It would be helpful to check if the hang can be reproduced on Vega 56 or 64
as well.

Marek

On Tue, Feb 26, 2019 at 7:51 AM Mikhail Gavrilov <
mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Tue, 26 Feb 2019 at 00:40, Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> >
> > Some shaders are stuck at "s_load_dwordx4 s[32:35], s[36:37], 0x0", but
> that might mean all sorts of things.
> >
> > Do you also have the dmesg log?
> >
> > Marek
>
> All files together here:
> https://mega.nz/#F!c4RwAYDJ!0ds-bVIftIDV4KCQOaDIsw
>
> --
> Best Regards,
> Mike Gavrilov.
>

--0000000000002e69210582d176f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sadly, the logs don&#39;t contain any clue as to why =
it hangs.</div><div><br></div><div>It would be helpful to check if the hang=
 can be reproduced on Vega 56 or 64 as well.<br></div><div><br></div><div>M=
arek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Feb 26, 2019 at 7:51 AM Mikhail Gavrilov &lt;<a hre=
f=3D"mailto:mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tu=
e, 26 Feb 2019 at 00:40, Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo=
@gmail.com" target=3D"_blank">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Some shaders are stuck at &quot;s_load_dwordx4 s[32:35], s[36:37], 0x0=
&quot;, but that might mean all sorts of things.<br>
&gt;<br>
&gt; Do you also have the dmesg log?<br>
&gt;<br>
&gt; Marek<br>
<br>
All files together here:<br>
<a href=3D"https://mega.nz/#F!c4RwAYDJ!0ds-bVIftIDV4KCQOaDIsw" rel=3D"noref=
errer" target=3D"_blank">https://mega.nz/#F!c4RwAYDJ!0ds-bVIftIDV4KCQOaDIsw=
</a><br>
<br>
--<br>
Best Regards,<br>
Mike Gavrilov.<br>
</blockquote></div>

--0000000000002e69210582d176f5--

--===============1453893482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1453893482==--
