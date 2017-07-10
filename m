From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu/atom: fix atom_fw check
Date: Mon, 10 Jul 2017 16:07:39 +0200
Message-ID: <CAAxE2A7Ti3CT9WMW0GTDAJpELEHp0PSdpW7+P_KwZPYoOvqFTg@mail.gmail.com>
References: <1499284272-5182-1-git-send-email-alexander.deucher@amd.com>
 <CAAxE2A7AB8++syrYURoW7umJMej_Y=gOM=w7_y097QeCEBDSnw@mail.gmail.com>
 <BN6PR12MB16525C20C2DD5827C30EA71BF7A90@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1363449016=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16525C20C2DD5827C30EA71BF7A90-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1363449016==
Content-Type: multipart/alternative; boundary="001a1139442a7391d50553f71dde"

--001a1139442a7391d50553f71dde
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 3:49 PM, Deucher, Alexander <
Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> wrote:

> > -----Original Message-----
> > From: Marek Ol=C5=A1=C3=A1k [mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> > Sent: Saturday, July 08, 2017 7:08 PM
> > To: Alex Deucher
> > Cc: amd-gfx mailing list; Deucher, Alexander
> > Subject: Re: [PATCH 1/3] drm/amdgpu/atom: fix atom_fw check
> >
> > Hi Alex,
> >
> > This commit causes that clock_crystal_freq is 0 on Raven, demoting
> > OpenGL support from 4.5 to 3.2. Can I revert?
>
> The problem is, it's just reading garbage right now.  It would be better
> to just hardcode the reference clock until I can figure out where the
> reference clock is in atomfirmware.
>

OK. I'll find a way to work around it in Mesa.

Marek

--001a1139442a7391d50553f71dde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Jul 10, 2017 at 3:49 PM, Deucher, Alexander <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Alexander.Deucher=
@amd.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">&gt; -----Original Message-----<br>
&gt; From: Marek Ol=C5=A1=C3=A1k [mailto:<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]<br>
&gt; Sent: Saturday, July 08, 2017 7:08 PM<br>
&gt; To: Alex Deucher<br>
&gt; Cc: amd-gfx mailing list; Deucher, Alexander<br>
&gt; Subject: Re: [PATCH 1/3] drm/amdgpu/atom: fix atom_fw check<br>
&gt;<br>
&gt; Hi Alex,<br>
&gt;<br>
&gt; This commit causes that clock_crystal_freq is 0 on Raven, demoting<br>
&gt; OpenGL support from 4.5 to 3.2. Can I revert?<br>
<br>
</span>The problem is, it&#39;s just reading garbage right now.=C2=A0 It wo=
uld be better to just hardcode the reference clock until I can figure out w=
here the reference clock is in atomfirmware.<br></blockquote><div><br></div=
><div>OK. I&#39;ll find a way to work around it in Mesa.<br><br></div><div>=
Marek<br></div></div></div></div>

--001a1139442a7391d50553f71dde--

--===============1363449016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1363449016==--
