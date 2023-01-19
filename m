Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EC9C46467
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 18:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D2A10E0E9;
	Thu, 19 Jan 2023 18:21:57 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F3710E0E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 18:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Yxxabfy+YmV+u63yUiYb9125u6etJvMJCDlIUmODJsY=; b=F3TAhDJKCHwJJMo50QbCppbn1Q
 KALnrGbctbfT5tVLKZA2nPWuw4AwRVNcsWCNwm1KBBQ9h0qY/7opJr8PrP2CQSrs9sNdB2IThW4Zj
 PNA99xvi26dymAyLonWUw3nxJperZLkwyxgBeY08tUxb3/wYKglb4NxSfYwQdvgKEmjEdC+jrNEXw
 TUYVxn/m2wTAWIqNE1M198/TdEhW3XfJGeSE/ne9t+Cll6eZi621TDfZ+YvT5MNPp1ku2e1qfJLKQ
 Wy4HrIGUT2WLIaMeqdSrHmZDlbvXMDN3VxD1HDblBpx2VAqZpToDSiv9OlPISHvhK1yWowJc15Wx6
 cJJYNySg==;
Received: from [38.44.66.31] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pIZXt-00CXPO-4Z; Thu, 19 Jan 2023 19:21:53 +0100
Date: Thu, 19 Jan 2023 17:21:42 -0100
From: Melissa Wen <mwen@igalia.com>
To: Joshua Ashton <joshua@froggi.es>
Subject: Re: [PATCH 2/2] drm/amd/display: Remove unused display_content_support
Message-ID: <20230119182142.hgy7od6zveolys3v@mail.igalia.com>
References: <20230117212620.11262-1-joshua@froggi.es>
 <20230117212620.11262-2-joshua@froggi.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2irw3f7xiqlh7422"
Content-Disposition: inline
In-Reply-To: <20230117212620.11262-2-joshua@froggi.es>
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--2irw3f7xiqlh7422
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01/17, Joshua Ashton wrote:
> This was never filled in and thus never truly used.
>=20
> Checking the EDID for content_type support is not required for sending
> the avi infoframe packet.
>=20
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> ---
>  drivers/gpu/drm/amd/display/dc/dc_stream.h |  1 -
>  drivers/gpu/drm/amd/display/dc/dc_types.h  | 14 --------------
>  2 files changed, 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm=
/amd/display/dc/dc_stream.h
> index 51dc30706e43..a499c0952ea0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -182,7 +182,6 @@ struct dc_stream_state {
>  	 */
>  	struct link_encoder *link_enc;
>  	struct dc_panel_patch sink_patches;
> -	union display_content_support content_support;
>  	struct dc_crtc_timing timing;
>  	struct dc_crtc_timing_adjust adjust;
>  	struct dc_info_packet vrr_infopacket;
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/=
amd/display/dc/dc_types.h
> index c73a655bd687..862af36027e7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
> @@ -175,18 +175,6 @@ struct dc_edid {
> =20
>  #define AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS 20
> =20
> -union display_content_support {
> -	unsigned int raw;
> -	struct {
> -		unsigned int valid_content_type :1;
> -		unsigned int game_content :1;
> -		unsigned int cinema_content :1;
> -		unsigned int photo_content :1;
> -		unsigned int graphics_content :1;
> -		unsigned int reserved :27;
> -	} bits;
> -};
> -
>  struct dc_panel_patch {
>  	unsigned int dppowerup_delay;
>  	unsigned int extra_t12_ms;
> @@ -219,8 +207,6 @@ struct dc_edid_caps {
>  	uint32_t audio_latency;
>  	uint32_t video_latency;
> =20
> -	union display_content_support content_support;
> -
LGTM.

It depends on the previous patch, but if the first patch are fine, they
are both:

Reviewed-by: Melissa Wen <mwen@igalia.com>

CC'ing AMD DC folks again since I don't know if it's in use by other
platforms. But it'd be nice to get rid of this or have a
comment/explanation, if not.

>  	uint8_t qs_bit;
>  	uint8_t qy_bit;
> =20
> --=20
> 2.39.0
>=20

--2irw3f7xiqlh7422
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmPJijYACgkQwqF3j0dL
ehz7jA//YsNz38eeh/oEyj/1LMKE2xSvoRXxi4jyV32s5KkH2h9gbddcFBjvFyV4
XTSH1MNAcehynu5uxJIL4PVrW6v4JeT612nGgrHDEUlCWMMLNMLF2HdpGyKJXnOl
vxTC/PcShFfirFVTThiCbedMM8rWGBFM9hennCV0M0rnD7RGz9Uqm9IMJceA3xjC
x2kC32jyCxvUL7KcRBmY41hP1axDpyaY81NHYdQiHDAStUMqReMWACAbAjgLTqNf
Niy7e7HJc16op3E2VFsef0kaBCdhcyOiz6bilPCgdPafyoQQJhMvLbsJ3s111aQA
Lb+AB1+I13stj6KJ2lKAaBD58KlEilFdUy2M8kjZjYFtgQD6PfnwB6DHRys5kCSN
07RilPINe3ZMOkOi1WrV556KR44UVM25MpL4DdLfbgqsdGvIzJDe3RYVdIgsoL2h
mKBes3n1Ry8rsmOKCL4rE97PAOQ7JYKtwXo067HwSgzXZnB7yzRULdk9MVkrYy2v
cFtavO4g8WzArC46ZrOgVQlBoQE9Uwed5WHnKMk+kMD9MLKqKsZFGO8+2Ig85Rdv
tOFiIkmAnANsn4nGq4WNiG0PZCdLwhbJaZjjdqBcZIFkH0zXgK1p0H8cTyCWzxMh
U9pmHgsaMGoJSP5qL+RAn76VGheDWeE1Mcb/485ogFtOsxIqvL0=
=9HJl
-----END PGP SIGNATURE-----

--2irw3f7xiqlh7422--
