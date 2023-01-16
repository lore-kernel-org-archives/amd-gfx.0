Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07E3C54EBE
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 14:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDB410E0B5;
	Mon, 16 Jan 2023 14:35:30 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0BD10E0B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=efWTBqEEyvoJaQG1I94AIeRUujEWBbXJDoc31Tk7bkE=; b=sgZLDE0OKMbHDOusiCv+Mv+G3X
 /vAyXtE1QFKneLRLnI5OjByysXRoOa5u4IvkpNa8GYPGpWTRWxurbrbJzJrWPPOQwsSg6a/mrh7bS
 v5hS4BgBs7DspMdRwdI5qAKR8Ul73hiTBzBLK0FcG9IbyHWt6sKpdNRer5vnLiBlmapWruzipMdfS
 qsyyFxgQQVjih0b4zQy84iMJPK2aWFX3FWNgm9qOMduRA+tCgpO58mqa+j3mrBzidMp/md+KdWYfI
 PDg+NYalT9z5F1TOTGUhrSbLENuwrIBbze/2RXXsUNzPuLQd7RcR0fFCBNvD3q0QImkPDPOtdQ0/P
 TGI3HEYw==;
Received: from [38.44.66.31] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pHQa5-009sA4-Uj; Mon, 16 Jan 2023 15:35:26 +0100
Date: Mon, 16 Jan 2023 13:35:17 -0100
From: Melissa Wen <mwen@igalia.com>
To: Joshua Ashton <joshua@froggi.es>
Subject: Re: [PATCH v2] drm/amd/display: Calculate output_color_space after
 pixel encoding adjustment
Message-ID: <20230116143517.lcckjls3eaxvc7r6@mail.igalia.com>
References: <20230110194338.281829-1-joshua@froggi.es>
 <20230110201221.671544-1-joshua@froggi.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n2rvt4vzssvw3gkq"
Content-Disposition: inline
In-Reply-To: <20230110201221.671544-1-joshua@froggi.es>
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


--n2rvt4vzssvw3gkq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01/10, Joshua Ashton wrote:
> Code in get_output_color_space depends on knowing the pixel encoding to
> determine whether to pick between eg. COLOR_SPACE_SRGB or
> COLOR_SPACE_YCBCR709 for transparent RGB -> YCbCr 4:4:4 in the driver.
>=20
> v2: Fixed patch being accidentally based on a personal feature branch, oo=
ps!
>=20
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b4d60eedbcbf..9da71ee8fcc4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5341,8 +5341,6 @@ static void fill_stream_properties_from_drm_display=
_mode(
> =20
>  	timing_out->aspect_ratio =3D get_aspect_ratio(mode_in);
> =20
> -	stream->output_color_space =3D get_output_color_space(timing_out);
> -
>  	stream->out_transfer_func->type =3D TF_TYPE_PREDEFINED;
>  	stream->out_transfer_func->tf =3D TRANSFER_FUNCTION_SRGB;
>  	if (stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A) {
> @@ -5353,6 +5351,8 @@ static void fill_stream_properties_from_drm_display=
_mode(
>  			adjust_colour_depth_from_display_info(timing_out, info);
>  		}
>  	}
> +
> +	stream->output_color_space =3D get_output_color_space(timing_out);

LGTM.

I see that we were ignoring the updated value of pixel_encoding in the
previous point. Nice catch!

Reviewed-by: Melissa Wen <mwen@igalia.com>

>  }
> =20
>  static void fill_audio_info(struct audio_info *audio_info,
> --=20
> 2.39.0
>=20

--n2rvt4vzssvw3gkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmPFYJ4ACgkQwqF3j0dL
ehwGoRAAm4Fxjr4bGsgw94GNGyl5ftmksS49WYJhnOK4sBA6VVPSzM8vutGAe9uz
PuzU2WWPS+5sG/ip+k7rs2zTGonKmmO7HUte/FCyX1rZ0YkZtRoaaLZP/Xk4IQwd
axt4fGSUZiWP8lpZ7LzxnnnhxQX0K5QbgynctjWXaqwX8WuGhlW8t+9iO1Gm+vcn
Z04j7H84aoW01nYh5Rzsyy7HK/aenb0/ykn5M3beyInJk089KkGiEg39TdBSsZnf
0zbd4zCfyHBJQiV3C9jd4M6ACR4YIUCjAgLdXdQEUlj7XI5jLzIuoP1ocuiwafj7
hVmV2Uqz9mZ76SScYe5AE0VHzRijfjyMednXtwt9RByG+mLmPqYnK3Rwxh1vSuUa
Me9vVM1erNrhrzl5YHm4r9+ILFAmu/9p8A0j90YZHiO81PekByjzr2OHOEbYE18r
4aDeFIVxP36SxWqBWrPLV4unxi9W7EvlojVDbuRzZcXn9hcCluSNNtaJHXR0veGl
wkgS58+WlczIBHDp39QE4ZkGjAOg2ujEN/n+YIynLZiT2CWLzuN8hu5K4LHbUHen
kidYdiw+3zgksQZWaHHStgsddTjHtAXeDEahdF7WmvtSqccelK9RG3Fh0YG3O+5D
8JMjOMqcy8AcQJ3+gCjKY/GeCaEWHuj69oaK7O1jFgH6AhyEKHw=
=vys5
-----END PGP SIGNATURE-----

--n2rvt4vzssvw3gkq--
