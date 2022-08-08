Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4801CC00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 18:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB66410ED59;
	Mon,  8 Aug 2022 18:59:09 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B488711A479
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9x2SWaFcISJplNGMOY/BMFhqELcBE0VUuTRaKhmIL4U=; b=Ea+usjXEshJ9vOKSbXWKbw5YU3
 GKOAu3gmfLsv5XGZNvjCBmbQM0Y2ITnuj7xCzlbKDQHz6Hgpn2QKpB5YnHrwzSA/48s4ZYSJ02Yf3
 nLyROu8oY6qjcXwj09rbie5js18PXIECqdKTQdw3fcoqTcZDlURS4ttT5+pxkdGq5dcUbYznUiQd0
 6F0Le1dznobH8ot/g38RJwiObsaSpoAWUDeUWMXiQoCftdNk+fJDzxgJZEqnH8qv564iTzIj5KxqF
 lDxtNytNgFx56KXAb3LDqrpATvUhmx1wlvZKcr5hKQion5juyDaUyQK1yzcziJoUxPcEU9SZUTE5z
 ygxTI3mg==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oL7qc-0030JL-6s; Mon, 08 Aug 2022 20:51:30 +0200
Date: Mon, 8 Aug 2022 17:51:17 -0100
From: Melissa Wen <mwen@igalia.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] drm/amd/display: set panel orientation before
 drm_dev_register
Message-ID: <20220808185117.nuncv3kw67mjc66f@mail.igalia.com>
References: <20220803162402.3412968-1-mwen@igalia.com>
 <20220803162952.odxi24tb6krgt42n@mail.igalia.com>
 <xI-NVvuRaXc7nwH0mpaawuQCjch9XHttx_WHUdA449IE17gUq2QxChCzWZTV6v64fItGWakt4KnFAEOwVX4ILsh947KphoLyrwID2g3gcAI=@emersion.fr>
 <187d9428-c776-cbae-8054-172b106d9c4c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nvodltlb3ynp2qxf"
Content-Disposition: inline
In-Reply-To: <187d9428-c776-cbae-8054-172b106d9c4c@redhat.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Simon Ser <contact@emersion.fr>,
 Xinhui.Pan@amd.com, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, nikola.cornij@amd.com,
 Sean Paul <seanpaul@chromium.org>, kernel-dev@igalia.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, christian.koenig@amd.com,
 sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--nvodltlb3ynp2qxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08/08, Hans de Goede wrote:
> Hi,
>=20
> On 8/5/22 19:34, Simon Ser wrote:
> > Hi,
> >=20
> > Have you seen [1] and [2]? CC'ing Sean and Hans, it seems like there's
> > a disagreement regarding probing early vs. setting the initial value to
> > UNKNOWN.
>=20
> At least for the discussions I've been involved in so far
> (see the links in the originak email) it was possible to retreive
> the panel orientation before calling drm_dev_register() and IIRC some
> changes were merged (I've at least reviewed them) to add a new
> callback to the panel drivers to get the orientation from the panel
> driver before registering the connector fixing the ordering problem
> for those cases.
>=20
> > If a driver doesn't fetch EDIDs before exposing them to user-space,
> > then there is an amount of time where the connectors are exposed as
> > CONNECTED but their EDID and mode list isn't properly set. But maybe
> > that's what the GETCONNECTOR IOCTLs is supposed to do: probe the
> > connector, fetch its EDID, return the proper mode list. So maybe
> > drivers shouldn't probe early and should let user-space request probes?
> > In which case we could create the panel orientation prop with "Normal",
> > and update it accordingly when probing.
>=20
> I guess that if in some cases it really is not possible to get
> the orientation before calling drm_dev_register() then this is
> an acceptable solution, as long as the orientation gets set
> properly before the first GETCONNECTOR IOCTL finishes then
> userspace will never know the difference since it needs to do
> the GETCONNECTOR to enumerate the connectors properties anyways.
>=20
> > At any rate, I've tested v2 on the Deck and it works properly.
> >=20
> > Tested-by: Simon Ser <contact@emersion.fr>
>=20
> I'm not aware of which patch's v2 you are talking about here, link ?

Hi Hans,

Here is v2: https://lore.kernel.org/amd-gfx/20220804161349.3561177-1-mwen@i=
galia.com/

Anyway, let me cc'ing you all there.

Best Regards,

Melissa

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
>=20
> >=20
> > Thanks,
> >=20
> > Simon
> >=20
> > [1]: https://lore.kernel.org/dri-devel/CAMavQKJUpYP8jo2JDGMYNBGtbPSSO7z=
9BAComm5JQoty=3DHPtJg@mail.gmail.com/
> > [2]: https://lore.kernel.org/dri-devel/20220530081910.3947168-1-hsinyi@=
chromium.org/
> >=20
>=20

--nvodltlb3ynp2qxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmLxWyUACgkQwqF3j0dL
ehxrEg/7BE6zSkKxwEmu/ql1Fmhxe1+uGBsjk+zY1XzJK/NI3+3zYjcPZJaYd+kA
kN0AoTdTHwCBUh2WuCgfhnFSZ6jNrH25kzhf1dnk+oop6k5J87smtliYyDy6M10A
LqhG0lFsDrWyxXoaqwjiJ1rXOAEHXxvZESheNwoDB0QYI1u3X2+ScSYBsX7Oq6GM
cNU1w9iPc5QH8NhI2rexprszmcJ8KNOujmhBpsXzfgaHSdwexYA7h+FybJOpRiUa
FWjzfsPqKcK/i2HftZO77C0oJTf7MS1I2zGPtASGI5OZJ2Io3sKU9dE0qW9e2YJe
T00MRDEaKocPu5LeAEXopk6kBoVpnvMeYRmHwbuAeZIiz2+AMFwvIVhOg6FoChf9
KNLChqTE+fH2uEPYpZSOYEjrn4D+g+NP8ZLBB6Ucl8wVp/0/jjTLKgMcWvO04Znt
bbI6vSctRBOZrpDP3cvCDAAM0ccB9uai9YCzwqprMFvYAVcpp9dRcGGSSjGA2yYp
V3i5umI/T7JugONeDsqBeU6t6Rg9wvx+m1FWj5upvZ+kCLQk5uUGeq8BtqxjEKwm
Aj+uSybzR6UfNY7uTKGocXfhqkHUon0LBQkCVIJN0Qbx//1o3FcfgRoFgtHx0a7P
/Dq+QzQu1gdrn6N8dKfRHFvRuM2mOy3nLCuwvJ+excg8stVGW/c=
=x4SP
-----END PGP SIGNATURE-----

--nvodltlb3ynp2qxf--
