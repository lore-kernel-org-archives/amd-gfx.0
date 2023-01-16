Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B773C46467
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 14:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4ED10E2B3;
	Mon, 16 Jan 2023 14:41:24 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C2D10E2B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v2vxThehneTotw9TlTfzkgndCuWTo/iJbjZ6qzY4Qvw=; b=KhXPKtNglSJeF/I58+/ZiJNlYg
 Oz+Vldw7VU7MOfaib50PW7mezkb8AExheu4IaqOlWMxgDniQN4Ct8bx3/5Oi0WGCrNvmKX60zoCM4
 7+ObzVrWkl0G3POsVyW8rm8mj8TrEYJx8WkEjp5EuGQha7WKh6Wh761JtDaw4QLo0Vp1FQe6zJ+Sb
 EiPfTXL08/cvD6Rzzfn/o/ytzgJiKkirAlan6Qq3/BZ8VE+JACR+IDKGlZlDmV7YPK0HKUTFkNDLj
 CiFJN0vnuXdy8FJ8xxjbuhWiDTTVGdlDmKtSgTVYtMNKvkVoNsjfnF/X5/XOqBLvIa5UfTVBa8eUm
 7blwsY8A==;
Received: from [38.44.66.31] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pHQfo-009sMv-H3; Mon, 16 Jan 2023 15:41:20 +0100
Date: Mon, 16 Jan 2023 13:41:09 -0100
From: Melissa Wen <mwen@igalia.com>
To: Joshua Ashton <joshua@froggi.es>
Subject: Re: [PATCH v2] drm/amd/display: Calculate output_color_space after
 pixel encoding adjustment
Message-ID: <20230116144109.y4dyhlkfjw2bpxzk@mail.igalia.com>
References: <20230110194338.281829-1-joshua@froggi.es>
 <20230110201221.671544-1-joshua@froggi.es>
 <20230116143517.lcckjls3eaxvc7r6@mail.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z2qx6ygxfusbvnzu"
Content-Disposition: inline
In-Reply-To: <20230116143517.lcckjls3eaxvc7r6@mail.igalia.com>
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--z2qx6ygxfusbvnzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01/16, Melissa Wen wrote:
> On 01/10, Joshua Ashton wrote:
> > Code in get_output_color_space depends on knowing the pixel encoding to
> > determine whether to pick between eg. COLOR_SPACE_SRGB or
> > COLOR_SPACE_YCBCR709 for transparent RGB -> YCbCr 4:4:4 in the driver.
> >=20
> > v2: Fixed patch being accidentally based on a personal feature branch, =
oops!
> >=20
> > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index b4d60eedbcbf..9da71ee8fcc4 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -5341,8 +5341,6 @@ static void fill_stream_properties_from_drm_displ=
ay_mode(
> > =20
> >  	timing_out->aspect_ratio =3D get_aspect_ratio(mode_in);
> > =20
> > -	stream->output_color_space =3D get_output_color_space(timing_out);
> > -
> >  	stream->out_transfer_func->type =3D TF_TYPE_PREDEFINED;
> >  	stream->out_transfer_func->tf =3D TRANSFER_FUNCTION_SRGB;
> >  	if (stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A) {
> > @@ -5353,6 +5351,8 @@ static void fill_stream_properties_from_drm_displ=
ay_mode(
> >  			adjust_colour_depth_from_display_info(timing_out, info);
> >  		}
> >  	}
> > +
> > +	stream->output_color_space =3D get_output_color_space(timing_out);
>=20
> LGTM.
>=20
> I see that we were ignoring the updated value of pixel_encoding in the
> previous point. Nice catch!
>=20
> Reviewed-by: Melissa Wen <mwen@igalia.com>

BTW, I think it deserves a fixes tag to:

Fixes: ea117312ea9f ("drm/amd/display: Reduce HDMI pixel encoding if max cl=
ock is exceeded")

>=20
> >  }
> > =20
> >  static void fill_audio_info(struct audio_info *audio_info,
> > --=20
> > 2.39.0
> >=20



--z2qx6ygxfusbvnzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmPFYgUACgkQwqF3j0dL
ehzWhw/9Fo4mWnB47pfN5tVYe0OJBbfXrVc60oNuNKlydn5iatmQgWZXGs2iWtkS
6Gm2iZXMnI4gkdafPKFNPnpnjb3yiBgOuKNA8wS5KWyF57ECP+Rk/GyVEB5ruahD
dHcZ+QkGGVg5NNSskV/p6EqVqp0lGjzlVSlVz1EH4087YwINy5MSXx6jY1MdOlsH
GsXxzZe0rWivjkxk1p0CG5EzkRzpcM+rOcIw7kVqbhoggtZlmJKcEqxXVgNaGd2q
A8cFna5ipwaeOhPrm7QD1+A0M+YJyHwVVmOx3rTx4j2ryWoOoX46fpaI4FQnOJnW
HBcXJU95nb2x7PDzYwaq+Rn2IoYoTr5O3E1gN/+RJxjk7ZxEsny5q4rt3B2SOJD4
qY7SAkqBBuXEto0zORIIOoXxetdF+epcMNYdgX4IQQb9Vh5ZWEmnsbjx04p8UMzH
hPqklLC0lIHrDys0C3HpUmIxS3n3JT5TCUnAbbRtOBVYbmTeMhSerVTNcgco6gwy
3SN6rrXg1lMMI+PN050FpRAzGnmi4uzlZezOJOdvp6WK/OG9+fD6c0v820bx2UW1
0YSWy6UTvberYB8jmjXNPOnqFERyFfW4BnHg4s9u7iEFN4FnxfgURGCPP/pYlxJm
qj99YKwIYpwnLKxERlc+DtD/5GkNkdGctSq0AsTAjTIy1Q0jAMY=
=GKeS
-----END PGP SIGNATURE-----

--z2qx6ygxfusbvnzu--
