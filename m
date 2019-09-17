From: Daniel Liu <danielliu861-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: build failed for DCN2.1
Date: Tue, 17 Sep 2019 14:07:04 +0800
Message-ID: <CAADsLEuwzqqoVyR+q_mnj+7H9Bkz-euWi7aCpWeHDypY-3zSzA@mail.gmail.com>
References: <1568624607-19067-1-git-send-email-danielliu861@gmail.com>
 <CAKwvOdn8-T3Q=LhiGu6H7dCpwXXrNAjpKJA5z0d+N4qB8bOapQ@mail.gmail.com>
 <20190916221203.GM4352@sirena.co.uk> <20190916223615.GP4352@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1918636147=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190916223615.GP4352-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
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
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Li,
 Sun peng (Leo)" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org, Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roman.Li-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Jun.Lei-5C7GfCeVMHo@public.gmane.org, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <christian.koenig-5C7GfCeVMHo@public.gmane.org>

--===============1918636147==
Content-Type: multipart/alternative; boundary="0000000000004623600592b98809"

--0000000000004623600592b98809
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Welcome^_^!

Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> =E4=BA=8E2019=E5=B9=B49=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=886:36=E5=86=99=E9=81=93=EF=BC=9A

> On Mon, Sep 16, 2019 at 11:12:03PM +0100, Mark Brown wrote:
> > On Mon, Sep 16, 2019 at 01:51:15PM -0700, Nick Desaulniers wrote:
> >
> > > + Mark
> > > I think this was a result of the resolved merge conflict.  See the
> > > -next only commit titled:
> > >     Merge remote-tracking branch 'drm/drm-next'
>
> > Yes, the DRM and the Kbuild people really need to coordinate with each
> > other here I fear, it's pretty bad that stuff like this has to be done
> > in a merge at all :/ The fact that make doesn't detect a missing endif
> > is also concerning.
>
> Applied now, thanks Xinpeng.
>

--0000000000004623600592b98809
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Welcome^_^!</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Mark Brown &lt;<a href=3D"mailto:broonie@kern=
el.org">broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>&gt; =E4=BA=8E2019=E5=B9=B49=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=886:36=E5=86=99=E9=81=93=EF=BC=9A<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Sep 16, 201=
9 at 11:12:03PM +0100, Mark Brown wrote:<br>
&gt; On Mon, Sep 16, 2019 at 01:51:15PM -0700, Nick Desaulniers wrote:<br>
&gt; <br>
&gt; &gt; + Mark<br>
&gt; &gt; I think this was a result of the resolved merge conflict.=C2=A0 S=
ee the<br>
&gt; &gt; -next only commit titled:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Merge remote-tracking branch &#39;drm/drm-next=
&#39;<br>
<br>
&gt; Yes, the DRM and the Kbuild people really need to coordinate with each=
<br>
&gt; other here I fear, it&#39;s pretty bad that stuff like this has to be =
done<br>
&gt; in a merge at all :/ The fact that make doesn&#39;t detect a missing e=
ndif<br>
&gt; is also concerning.<br>
<br>
Applied now, thanks Xinpeng.<br>
</blockquote></div>

--0000000000004623600592b98809--

--===============1918636147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1918636147==--
