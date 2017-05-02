From: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm: fourcc byteorder: drop DRM_FORMAT_BIG_ENDIAN
Date: Tue, 2 May 2017 17:27:24 +0300
Message-ID: <20170502172724.31188e2d@eldfell>
References: <20170502133404.15354-1-kraxel@redhat.com>
 <20170502133404.15354-2-kraxel@redhat.com>
 <CACvgo52FeXVixjmRpv3xO=kRFTbmBu5vmyzAs=VF_v+nLAO=ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1949203300=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo52FeXVixjmRpv3xO=kRFTbmBu5vmyzAs=VF_v+nLAO=ag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Michel =?UTF-8?B?RMOkbnplcg==?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--===============1949203300==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pabG35BSM5d5rmoP.316cS_"; protocol="application/pgp-signature"

--Sig_/pabG35BSM5d5rmoP.316cS_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 2 May 2017 14:53:43 +0100
Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi Gerd,
>=20
> I did not have the change to follow through the discussion.
> Pardon if my suggestion have already been discussed.
>=20
> On 2 May 2017 at 14:34, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > It's unused.
> >
> > Suggested-by: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  include/uapi/drm/drm_fourcc.h     | 2 --
> >  drivers/gpu/drm/drm_fourcc.c      | 3 +--
> >  drivers/gpu/drm/drm_framebuffer.c | 2 +-
> >  3 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourc=
c.h
> > index 995c8f9c69..305bc34be0 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -33,8 +33,6 @@ extern "C" {
> >  #define fourcc_code(a, b, c, d) ((__u32)(a) | ((__u32)(b) << 8) | \
> >                                  ((__u32)(c) << 16) | ((__u32)(d) << 24=
))
> >
> > -#define DRM_FORMAT_BIG_ENDIAN (1<<31) /* format is big endian instead =
of little endian */
> > - =20
>=20
> Weston references DRM_FORMAT_BIG_ENDIAN thus this patch will lead to
> build breakage.
> That is never fun, so please carefully coordinate with the Weston devs
> to minimise the fireworks.
>=20
> Personally I would leave the symbol, since it's UAPI and document that
> should not be used. Not my call, so feel free to ignore.

Hi,

indeed, weston does have one occurrence of it. I don't think it has
actually been needed in practice ever, but removing it will cause a
build failure:
https://cgit.freedesktop.org/wayland/weston/tree/libweston/gl-renderer.c?id=
=3D2.0.0#n1820
Funnily enough, it's only ever used to get rid of the bit, "just in
case".

I also think that this patch requires more comments than the
commit message has at the moment.

Removing the definition also removes the possibility to describe a lot
of pixel formats, so that should definitely be mentioned. I think it
would also be good to have some kind of justified claim that no
hardware actually needs the pixel formats this is removing (e.g. RGB565
BE). Maybe this was already in the long discussions, but I feel it
should be summarized in the commit message.


Thanks,
pq

--Sig_/pabG35BSM5d5rmoP.316cS_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlkIl0wACgkQI1/ltBGq
qqczShAAoH9sCnAQZ7uPsUfZ310OnV7WkK8buXjbs6QpqoFP9gq7GTmzLI7hWnIj
p+L5rdekhTRnZqpKWp2K+sNQPJ8oKF+jnq6YJBWpjgxQ6JCBtSYBJDYdvqMJfb7x
SUDGzTX8fle+bug1DllT+8/JlElmfaiAuE/cRYExq5xEtU3rZNnTwo6RsVubTjpf
0CBqfUHG1QWAsc+6hCsJVbFlpCNw0Au22WCWFsGvTWo7CI+uPeIB/hEXfsXifovl
gyWvEIvXMLwRZskMpua1SAjOBGys6XlPFlvLHPDiWtB+N6nCF7+hI5i3scpu0llt
6U31TTh8uzzOxEl0VldZbwJ2WcDwoy2imm3VGn6clLgjH0dpKUP9JElbop2TMZDK
8reGGVmTfOAQejcDoJm5Vz/hs5Hhs6FqN5MOU+sm4J6RBqOpMgSZr1wyd4VDUVUL
zBHaBZt2NHPXt/qd3OsoLYtqowP3w4OkEvkPjXoFiad+APW1mQYw0MimAoh33/jH
9ziPev4evawkdQN/jsnNx7ApuIQcK7kyAqdzN1YSpFaMcD6dYPnnQLfhHuE0Rzde
l9o/uokbPxPE9jIJC+rLTQPzW/f3AjgEQobf8gmpvTagN/ba+7XmRvOPyaKavYwa
PKzevL9uu32ULf5nZBcg1j4drMxUqviZUYdD4J/NINnsK3ED1Rg=
=l81H
-----END PGP SIGNATURE-----

--Sig_/pabG35BSM5d5rmoP.316cS_--

--===============1949203300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1949203300==--
