From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Don't warn on destroying a pinned BO
Date: Mon, 23 Jul 2018 18:30:52 +0100
Message-ID: <CAHbf0-F6YnM8Udn1dPJcca_TZvybz-MLiDWUPmMQfk--Lri+qw@mail.gmail.com>
References: <20180719153955.23910-1-michel@daenzer.net>
 <b39b0ced-3a54-b18c-0e90-e829b21afd17@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0513129223=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b39b0ced-3a54-b18c-0e90-e829b21afd17-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0513129223==
Content-Type: multipart/alternative; boundary="000000000000a5955a0571ae02ec"

--000000000000a5955a0571ae02ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I was hitting this

Feel free to add my tested by

Tested-by: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>

Cheers

Mike

On Mon, 23 Jul 2018 at 17:50 Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

> On 2018-07-19 05:39 PM, Michel D=C3=A4nzer wrote:
> > From: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
> >
> > The warning turned out to be not so useful, as BO destruction tends to
> > be deferred to a workqueue.
> >
> > Also, we should be preventing any damage from this now, so not really
> > important anymore to fix code doing this.
> >
> > Signed-off-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > index b12526ce1a9d..3010f0136de9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -89,7 +89,7 @@ static void amdgpu_ttm_bo_destroy(struct
> ttm_buffer_object *tbo)
> >       struct amdgpu_device *adev =3D amdgpu_ttm_adev(tbo->bdev);
> >       struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(tbo);
> >
> > -     if (WARN_ON_ONCE(bo->pin_count > 0))
> > +     if (bo->pin_count > 0)
> >               amdgpu_bo_subtract_pin_size(bo);
> >
> >       if (bo->kfd_bo)
> >
>
> Any feedback?
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000a5955a0571ae02ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>I was hitting this</div><div><br></d=
iv><div>Feel free to add my tested by</div><div><br></div><div>Tested-by: M=
ike Lothian &lt;<a href=3D"mailto:mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org">mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org<=
/a>&gt;</div><div><br></div><div>Cheers</div><div><br></div><div>Mike</div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, 23 Jul 2018 a=
t 17:50 Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel=
@daenzer.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 2018=
-07-19 05:39 PM, Michel D=C3=A4nzer wrote:<br>
&gt; From: Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank">michel.daenzer-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; <br>
&gt; The warning turned out to be not so useful, as BO destruction tends to=
<br>
&gt; be deferred to a workqueue.<br>
&gt; <br>
&gt; Also, we should be preventing any damage from this now, so not really<=
br>
&gt; important anymore to fix code doing this.<br>
&gt; <br>
&gt; Signed-off-by: Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel.daenzer=
@amd.com" target=3D"_blank">michel.daenzer-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index b12526ce1a9d..3010f0136de9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -89,7 +89,7 @@ static void amdgpu_ttm_bo_destroy(struct ttm_buffer_=
object *tbo)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D amdgpu_ttm_ad=
ev(tbo-&gt;bdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(tb=
o);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (WARN_ON_ONCE(bo-&gt;pin_count &gt; 0))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (bo-&gt;pin_count &gt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_subtra=
ct_pin_size(bo);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bo-&gt;kfd_bo)<br>
&gt; <br>
<br>
Any feedback?<br>
<br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--000000000000a5955a0571ae02ec--

--===============0513129223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0513129223==--
