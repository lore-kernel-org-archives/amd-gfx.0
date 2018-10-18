From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: increase the size of HQD EOP buffers
Date: Thu, 18 Oct 2018 15:46:49 -0400
Message-ID: <CAAxE2A7Jv_FJ5_YPpn7O1g2LhMkOiSPh9nvuih3FRfdXfAvp=A@mail.gmail.com>
References: <20181005210144.13999-1-maraeo@gmail.com>
 <20181005210144.13999-2-maraeo@gmail.com>
 <CADnq5_M-uz+ABbZpm1-SFS26f1Q8T-w00FwXiMxj9HeAx8PhQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1429499190=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_M-uz+ABbZpm1-SFS26f1Q8T-w00FwXiMxj9HeAx8PhQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1429499190==
Content-Type: multipart/alternative; boundary="0000000000006614c40578860eac"

--0000000000006614c40578860eac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 9, 2018 at 12:17 PM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Fri, Oct 5, 2018 at 5:01 PM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
> >
> > From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> >
> > Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
>
> Any reason not to bump the size for gfx7 as well?
>

No, I just don't know if gfx7 supports the same size.

Marek

--0000000000006614c40578860eac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue, Oct 9,=
 2018 at 12:17 PM Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"=
>alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">On Fri, Oct 5, 2018 at 5:01 PM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mail=
to:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak=
@amd.com" target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-<br>
<br>
Any reason not to bump the size for gfx7 as well?<br></blockquote><div><br>=
</div><div>No, I just don&#39;t know if gfx7 supports the same size.</div><=
div><br></div><div>Marek</div><br></div></div>

--0000000000006614c40578860eac--

--===============1429499190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1429499190==--
