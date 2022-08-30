Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728AEECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 07:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F0B10E20A;
	Wed, 31 Aug 2022 07:27:55 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2138010E1C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 21:35:21 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHLFD2T0Bz4xFt;
 Wed, 31 Aug 2022 07:35:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
 s=201702; t=1661895312;
 bh=mhDMj97/cwy9nV1CJZuH1+jaN2sLZLf37N5Gvxr7HD8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=a7WyLcbjYd13wO8jHSxM+s+rnYNnrWGpzonNK/Qftc+pBJjAvORQ83RM9ExnR0wQG
 3mvzL9ZkLr/aq+/2uOhUcpseTHlKWQdZ39GHCTDFwz1xgg2vJPoySN43hr+DTHIBBL
 QChUcuxXVn75YiHIx7W7Wsawzih/RpMRzoIUSBT9wZ9falcb7/cTAsXs3M9qv3DO49
 0kv585C3CtB5JEws8n64JoHWEwndR8k6+AFGZRKkx/jfJ3FQGkuzxwdBhw8Gi0e7hW
 UXjCzsEHXuj+D5saQhxVjTCTJY9KXbCOdeTkhdKljgzNZ5mGkip3wZ9Z19OifDc9uc
 hEo6nGmHXu1Qw==
Date: Wed, 31 Aug 2022 07:34:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/display: fix documentation for
 amdgpu_dm_update_freesync_caps()
Message-ID: <20220831073457.0ce6de4c@canb.auug.org.au>
In-Reply-To: <20220830133217.1770055-2-alexander.deucher@amd.com>
References: <20220830133217.1770055-1-alexander.deucher@amd.com>
 <20220830133217.1770055-2-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZxCdLPLF4CnPPu7gjTIfJvL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Mailman-Approved-At: Wed, 31 Aug 2022 07:27:51 +0000
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--Sig_/ZxCdLPLF4CnPPu7gjTIfJvL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Tue, 30 Aug 2022 09:32:17 -0400 Alex Deucher <alexander.deucher@amd.com>=
 wrote:
>
> Document missing parameter.
>=20
> Fixes: 8889a13f99e5 ("drm/amd/display: Add some extra kernel doc to amdgp=
u_dm")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 15d51d300b34..4e24b75efcfe 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9938,6 +9938,7 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_con=
nector *aconnector,
>   * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
>   *
>   * @aconnector: Connector to query.
> + * @edid: EDID from monitor
>   *
>   * Amdgpu supports Freesync in DP and HDMI displays, and it is required =
to keep
>   * track of some of the display information in the internal data struct =
used by
> --=20
> 2.37.1
>=20

That is not the problem I reported (though that also needed fixing)

I reported:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:9951: warning: Excess fun=
ction parameter 'aconnector' description in 'amdgpu_dm_update_freesync_caps'

The parameter is actually "connector" (no 'a'), so the line above the
one you added needs fixing as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZxCdLPLF4CnPPu7gjTIfJvL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMOgoEACgkQAVBC80lX
0Gw6sQf/aOnlsW0gU+Nbhz+15N1/4mRA/ZKb/MVZ2gdruhXLmooKqAwNvYhH6SNr
XG5CTNq1XQ5eYFAPTwsvQa48/w7j0BX33W7ie99aeHp1/WeHGbQ2l741/WvI+Ghh
/nH+N2SDbJYyjao40QgRWGIDHIOr0d0jueSDqyckJ37RHmekNTfs4AjNc7SqZAGF
XoFONzP2Lwog5h2SJXYnwDOjRfNs53NJLNbMp0YKy3kq2X4iqfrYRISqsDY08qgv
iiFiYTJ5kGHsnrv48EpmrcHWg4g2cOPFHdOPTSr/ISLlAytUnvCjHVGgCaWXLLpJ
bq3GthlpXC3WTCx07j/+hmNY3Q8APA==
=3ti4
-----END PGP SIGNATURE-----

--Sig_/ZxCdLPLF4CnPPu7gjTIfJvL--
