Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A948AC6FD1C
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Mar 2023 13:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01CF110E1E2;
	Sat, 11 Mar 2023 13:13:51 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4FA10E1E2
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Mar 2023 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dxYxJlmgjkq/4ajujbG+Cq5Qw7wpEte3CdOtR7xEpTY=; b=YWBP8Gwkc8iwXqeamVAhUP3AZU
 YZ1EMNzoHrLAaCY24eMAR8o24KXX4ruMMJGhIFEmqGa8eQF93uJc1VUkIEz8lqBIuWSXSodtqLZNC
 vXYZkSVX+//uQqD9OReOnO0zsXh1ihIUzPbTdYN7uPXa+mjOr0I9KH4wLEp12wbNN1IvtYMUzV+Ib
 YoaSMUVaoNj6SF1BieRVv3IO3EImkMg5agy6uydlT4tCDwmi6RtjqIAWF98K5kFgMQtBGQFPHYFs5
 oX70NO7CyzSoiE6gGdAi59Q85lQUIHa6spgeuhYUQqjFwCgIWxpOX1YdDPpTn6aGRDtBPsLZKjWWC
 215SxnKg==;
Received: from [38.44.66.31] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1paz2h-004Wey-8g; Sat, 11 Mar 2023 14:13:47 +0100
Date: Sat, 11 Mar 2023 12:13:00 -0100
From: Melissa Wen <mwen@igalia.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH] drm/amd/display: Set MPC_SPLIT_DYNAMIC for DCN301
Message-ID: <20230311131300.tw5dgrkbrscmclg3@mail.igalia.com>
References: <20230309181838.463319-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4q2la4okw67dqlxn"
Content-Disposition: inline
In-Reply-To: <20230309181838.463319-1-Rodrigo.Siqueira@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--4q2la4okw67dqlxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/09, Rodrigo Siqueira wrote:
> Since DC version 3.2.226, DC started to use a new internal commit
> sequence that better deals with hardware limitations. Usually, DC adopts
> split pipe dynamics to improve the display bandwidth and, in some cases,
> to save power. This commit sets MPC_SPLIT_DYNAMIC for DCN301, improving
> the bandwidth and fixing the cursor bug on KDE when it tries hardware
> rotation.

Hi Siqueira,

Thanks for the work on allowing this pipe split policy change. I've
tested SteamDeck system behavior with this change and overall LGTM.

=46rom my previous tests on HW rotation, I don't see glitches when
splitting pipe, the issue only appears on one-pipe setup, but Xaver is
the best person to validate this on KDE environment.

Thanks,
Reviewed-by: Melissa Wen <mwen@igalia.com>

>=20
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2247
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Xaver Hugl <xaver.hugl@gmail.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index b93b4498dba4..5ac2a272c380 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -687,7 +687,7 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {
>  	.disable_clock_gate =3D true,
>  	.disable_pplib_clock_request =3D true,
>  	.disable_pplib_wm_range =3D true,
> -	.pipe_split_policy =3D MPC_SPLIT_AVOID,
> +	.pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
>  	.force_single_disp_pipe_split =3D false,
>  	.disable_dcc =3D DCC_ENABLE,
>  	.vsr_support =3D true,
> --=20
> 2.39.2
>=20

--4q2la4okw67dqlxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmQMflIACgkQwqF3j0dL
ehzC6w/8CM0VrOgfQGglxlza2V1/x2dWUw9q6npcaSZtMfsZX//6SatIm2SVb8YZ
rwT24Wd6xjTC6BYdh00EYC28P+gMIDa5h8r+ryCzZrJkXqu17FqchRjrjopXExtt
G5tXYqby/RxTVcMnD/yn/OgamjkrA52he5UyvJB8NAJwpspb4IyxQvjXNtZiLOO2
UGPH3+B9lStnUL8w1IcEzIT5Pupu3sEv0LGGPrzK8GhyGc265xrDoChILDqDumRC
FViSRdCfUl5yoQXVPQEzHzTQ1NHbW1Gk47jexIHzryyfDHoH2C6AH+Q3PY5ygzKs
juJsqA7zRIw4qfudayOA/OZOI102OGLxohcY6nKYj4WyqrqsZ6ceH9ZEUiOO3fU6
//BPBVJE1w7M29f0Kde6jgz4Jfl97iLgzL0mNbNIoeUnpS25pjWhe9zKSwEeplG1
hfhg7Vsqx0ng27sjSGio1ABcZ8fCwFzcQnklHKY0BwXZ+f5PsYPUK6ee2zCbyper
tWQGuogaWonrAYBZj1JGW5sdxJzw8P+EdV574G3bI18ceq9Q3QtVTp6FUOyp3m4v
T6hveb4fOtx9L5SGcHzVazh9PUVg2xTvo21LFv40uLHblEvK8uF3pMhs7eNe6pS6
4BdJ22QhZGZpmcOwnCoFl4QBX8S2y9Gzb0zVB7gDwVvHRemK3H8=
=jtV3
-----END PGP SIGNATURE-----

--4q2la4okw67dqlxn--
