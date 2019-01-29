From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add AMDGPU_IB_FLAG_GET_START_SYNCOBJ to
 expose scheduled fence
Date: Tue, 29 Jan 2019 16:54:34 -0500
Message-ID: <CAAxE2A4GaY4-osO6GfC-zG9ofxu2wjWZJ74Jds1ntqXZba_vQw@mail.gmail.com>
References: <20190128215239.32498-1-maraeo@gmail.com>
 <762485e9-7fe4-3ffb-16a4-f83436871451@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1673364955=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <762485e9-7fe4-3ffb-16a4-f83436871451-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1673364955==
Content-Type: multipart/alternative; boundary="000000000000ec701905809fd8b3"

--000000000000ec701905809fd8b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 3:01 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Am 28.01.19 um 22:52 schrieb Marek Ol=C5=A1=C3=A1k:
> > From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> >
> > Normal syncobjs signal when an IB finishes. Start syncobjs signal when
> > an IB starts.
>
> That approach has quite a number of problems (for example you can't
> allocate memory at this point).
>

Even if I drop this patch, can you describe all the problems with it?
Andrey and I would like to understand this.

Thanks,
Marek

--000000000000ec701905809fd8b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Jan 29, 2019 at 3:01 AM Christian K=C3=B6nig &lt;<a href=3D"=
mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoenig.leichtzu=
merken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Am 28.01.19 um 22:52 schrieb Marek Ol=C5=A1=C3=A1k:<br>
&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; Normal syncobjs signal when an IB finishes. Start syncobjs signal when=
<br>
&gt; an IB starts.<br>
<br>
That approach has quite a number of problems (for example you can&#39;t <br=
>
allocate memory at this point).<br></blockquote><div><br></div><div>Even if=
 I drop this patch, can you describe all the problems with it? Andrey and I=
 would like to understand this.<br></div><div><br></div><div>Thanks,</div><=
div>Marek</div></div></div>

--000000000000ec701905809fd8b3--

--===============1673364955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1673364955==--
