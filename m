Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3080C38142
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 08:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D30B10E192;
	Mon, 23 Jan 2023 08:45:45 +0000 (UTC)
X-Greylist: delayed 368 seconds by postgrey-1.36 at gabe;
 Mon, 23 Jan 2023 06:39:32 UTC
Received: from phoenix.flosstools.org (phoenix.flosstools.org [185.15.229.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E0C10E30A;
 Mon, 23 Jan 2023 06:39:32 +0000 (UTC)
Received: from turnagra.localnet (adsl-84-226-16-207.adslplus.ch
 [84.226.16.207])
 by phoenix.flosstools.org (Postfix) with ESMTPSA id 13715D8BC5C;
 Mon, 23 Jan 2023 07:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org;
 s=flosstools.odyx.user; t=1674455599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cYfj5w5AvKZDq7wbkVExi9uw24Z6F3TMhV4+dEf1v94=;
 b=hUK2dlS530nveWt258t31SgzhUOZ75GSQgzfesbygOf7lkvIUaEb4S08pxFwLBaRAJoiNo
 +YEnNIZCH8Aszq9LjR1yudffN9MlMPcxbzkkWNKBRR7WpeLrsMmkB4BsXOmqGulJaoYgmS
 DS1ocUr676FZugm0w2m2thrhoyWsvik=
From: Didier 'OdyX' Raboud <odyx@debian.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 0/7] Fix MST on amdgpu
Date: Sun, 22 Jan 2023 20:12:57 +0100
Message-ID: <4499220.LvFx2qVVIh@turnagra>
Organization: Debian - The Universal OS
In-Reply-To: <20230119235200.441386-1-harry.wentland@amd.com>
References: <20230119235200.441386-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2311774.ElGaqSPkdT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Mailman-Approved-At: Mon, 23 Jan 2023 08:45:43 +0000
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
Cc: stable@vger.kernel.org, stanislav.lisovskiy@intel.com, jerry.zuo@amd.com,
 bskeggs@redhat.com, Wayne.Lin@amd.com, Harry Wentland <harry.wentland@amd.com>,
 ville.syrjala@linux.intel.com, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--nextPart2311774.ElGaqSPkdT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Didier 'OdyX' Raboud <odyx@debian.org>
Subject: Re: [PATCH 0/7] Fix MST on amdgpu
Date: Sun, 22 Jan 2023 20:12:57 +0100
Message-ID: <4499220.LvFx2qVVIh@turnagra>
Organization: Debian - The Universal OS
In-Reply-To: <20230119235200.441386-1-harry.wentland@amd.com>
References: <20230119235200.441386-1-harry.wentland@amd.com>
MIME-Version: 1.0

=46or the whole series, as rebased on v6.1.7. Tested on this Thinkpad X13 A=
MD=20
Gen2:

Tested-By: Didier Raboud <odyx@debian.org>

Le vendredi, 20 janvier 2023, 00.51:53 h CET Harry Wentland a =E9crit :
> MST has been broken on amdgpu after a refactor in drm_dp_mst
> code that was aligning drm_dp_mst more closely with the atomic
> model.
>=20
> The gitlab issue: https://gitlab.freedesktop.org/drm/amd/-/issues/2171
>=20
> This series fixes it.


=2D-=20
    OdyX

--nextPart2311774.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTjpQ0b6NokWkvBQbzqgwvGpoTNfAUCY82KuQAKCRDqgwvGpoTN
fGdzAQDkKemGCY1aSI+/GyRfJUtLZgXXylk8Tg36JH4RRGAR4wEA5//nKnCu/FpM
O88czFy7eTo+6saQtOcDKoHmp8JHowk=
=1KOM
-----END PGP SIGNATURE-----

--nextPart2311774.ElGaqSPkdT--



