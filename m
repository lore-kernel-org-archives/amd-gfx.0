Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DB8C3ABDA
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 20:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5350B10E732;
	Wed, 14 May 2025 20:23:52 +0000 (UTC)
X-Greylist: delayed 318 seconds by postgrey-1.36 at gabe;
 Wed, 14 May 2025 08:16:35 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E7110E3B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
 s=s1-ionos; t=1747210593; x=1747815393; i=christian@heusel.eu;
 bh=yp19kCTXAzlQPM0VTZ+xoHXpUu2B4qVH44q0U8wInjk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:In-Reply-To:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=D09Qmo+xZqP6QdJ8VrvrSGWByxxpl/NU6xds75qku4KstCh3EezLoxKhQZ1nKeIn
 kAlkVGgzfwpwvs9XZAgwBTANliMe/8X+AwYir43LDcW2Slhj5S8eQF2n33GTaqTbC
 K2T943PBBVjuyizZS5pFbx9Vfok429zi09kJRPbU1Vj5PW+hneRELKociwCGNhXA+
 fEC9BKBrG+9jwdKdqaVRP03jJg4xd9Kun8IPQ3OJQYAgX3HUhPJo4UuVo/fb4+DhN
 LMTDDCJnu62V+LNTC5fjlyUHOcCLRjgNlAu2MuFP9AhClSErFktV7y91vd5ohHP66
 njoIhluSrClBqDfhlA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([129.206.223.183]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MTiLj-1uPGm30G4r-00Ytic; Wed, 14 May 2025 10:11:02 +0200
Date: Wed, 14 May 2025 10:11:00 +0200
From: Christian Heusel <christian@heusel.eu>
To: Wayne Lin <Wayne.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages
Message-ID: <90f81e59-1f85-4c2a-9d6e-879898f83fa8@heusel.eu>
References: <20250513032026.838036-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5jbs3dkqzer36ufa"
Content-Disposition: inline
In-Reply-To: <20250513032026.838036-1-Wayne.Lin@amd.com>
X-Provags-ID: V03:K1:BmqfP4SKpP6Umy+E17qUujc5PYF8npHNNs8NIAE+FvHJhDNihjl
 XNhapen9poo0Yb5ZttPs6i3vwNg7GqLL3+DJwUQOZ+KOH+x7ehXV1RbshQp/bLvKJISd3lg
 j5/iUO2WbY3WZbUkjpDf2uf+LeUxjW9BWF3IV7qEuUBOqwmvPwA2/Jt0dOdubMkC93r3gXn
 Wwns+MjrnWIkwa+cbXJ0Q==
UI-OutboundReport: notjunk:1;M01:P0:erzyHcUfyUQ=;fb+UK2eIQfVs9TJYozWeIBZYeuw
 UoH62B7tdZcDKvrrMVqesyCyw6s1mNfSS+RW7ZNm9sGdpq8Q9LZLzrjaDRpqkDaX35ZuLYfPw
 9RmcvJ0xgQdXPdl77P1U8scXzdL9EbQetckKyi5sOKOQtxZ7lj7Uniw0YMB4+pjk3uQrB2VdE
 r8bAsM54y41ldiHHnO6xEQ30qvlxtDAPp5V8J6GV6jBxGd6d1PbFGEtEskxmfweNiDJH8cGnX
 Zhgd3nmtPGMZCe4eokOq4UOHRWFx3MbEjBkMbusYvbzz5ls6Mk9TLGVZq3A+cw7OCclb+cxH6
 TEpUgnX02t8DBHdwK159kXOuMYHhBv1xHoeL7tdqX6vGgRU+vllilCyruP1B6OmJAElbCNACn
 dgMmFMMoJgjW1uf2VADKrITa0MWE97/9t7O1nvfYfnAV3Z7m3AhseAYBnTyn6A0rnjv6OBRIf
 B6RmPFFpbaxJ9E7zSTPkn9gxvVsFZDo7junE+8uYCQ+X4FkHldEyotzAsaa6EmBCQRCgk71ha
 2jsUOMY38qziC00Gf3wqaVW274tu5ZM/fErMsjrbrha/iGvoWEh+obJURN1vNSrrNAJIq25Su
 HuG0rRLhN4Owk2f18y1VSaktKOdRnU3UuB8qjwkRT4UinLDdT9uDP9KIEyGzOoTALETc5lR0e
 MR/FxuW68s+HMDBQbJAU4s7HHD68K2utomN1PPPu19l79jYrmgHN+oz3MjkPEVROZG8t3NbkW
 KIVWI4HrAdfnms3vSvyQ88aP0MdF46s03dPqs3ZSx6W1Q+oHQ6RsAvc6R9XyUaRXXlsX2TjsM
 XHq2iaTyQMStRbf6mwbq9pxKNHBbVmTXQgRn4JL3bBUyQMHQdR6qGFKMmb/N4WKKn0xGP7zjr
 5XeUZsnE1N2gtAQ1cxUQZI/8zMMRaW5y/11EcN8N6bctZDC6qrrDorTNTVtQJuhsnL95IlQoy
 1duhWoGln5O7B2luBqUaqCgOfeDJh9xBybAp30+/NMjkY10l4HYZMOA6AG1fijRrnVY9z7bk7
 V6nXwhaCtcCwhjgnk5vKSe0PxlJBIbBWXAkjesplIfw39qknvwBhQlzziyIBqoSx2uqeMRXHt
 gAJ/RTpR2j+paZfJ1UeptTkKJWsTTuEG+zBv6WXvDQ/elGVzTL2pB26ycwbCWMWCLyCS16G1g
 sB/tj9QcuJMlHycEeOjpTgRMauyS96s7oLczSPZ8sNK71Pzvvm3NkZOcEPSU447dCKcF/ILvn
 hm/FKbI5pAWC7ZxUCGtEeYlsnJRQAjDh2WX2ge31ePXvSurESkRsSkKD7oiPyhGSxtDcfHb2p
 RHDimC067J0KbVha5r0HS78g7w3LxvSmiRPnVyUnC1j8E8lm7PBJv28/NW6z/2mXEeOqj3j+7
 I3a6ULlyMxjprtVxULrb5lu6klq2PrJjxXcYLVzsQ8aMeScf7tj4F1DcTb
X-Mailman-Approved-At: Wed, 14 May 2025 20:23:51 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--5jbs3dkqzer36ufa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages
MIME-Version: 1.0

On 25/05/13 11:20AM, Wayne Lin wrote:
> It's expected that we'll encounter temporary exceptions
> during aux transactions. Adjust logging from drm_info to
> drm_dbg_dp to prevent flooding with unnecessary log messages.
>=20
> Fixes: 6285f12bc54c ("drm/amd/display: Fix wrong handling for AUX_DEFER c=
ase")
> Cc: stable@vger.kernel.org
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

If it's not already applied it would of course be nice if credit for my
report could be added to the change:

Reported-by: Christian Heusel <christian@heusel.eu>
Link: https://lore.kernel.org/all/32c592ea-0afd-4753-a81d-73021b8e193c@heus=
el.eu/

Have a nice day everyone!
Chris

--5jbs3dkqzer36ufa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmgkUBQACgkQwEfU8yi1
JYU6SA/9GeRVNamI6JTz/D6bxRsFu94z5RLpIctlu5hzQ9xLgbE5eQeAysRme9DX
k3Q2wDY/aO9nNKDFQkeZHmFX7nUZh/dgA5nKiOkYoF335WjpZEsZ6W90KF8PJtaS
DuKdf+bocyc7pzgp+Hd0oIJxD7ZF35FCX7u3p8m+MD6PoTNSdhfcK5iZ9oAMEfD8
ypmrU2fnLcDfsArm4nHa8AqcfEoUZ64XQxcRv1gn8srr1Sx2XrU7JC+SiEbTEeeI
kchaJipEwvWVplQ0sLbs3RxEYTms7dtJUIvHiwuGf9ey0xXRK9SRYQPrAxB8WvBc
VSTgNgvrn0WQmY2/7cxaMsZPmbH0FxQygJ3ERQDSgPJa9e77iSmD5LJ6W851mYbg
JGkjBICBepDVt5RKpirnYoJiPCOqgPHhgnHMbBOriDHO8HIg/Uvdlj6bcSDzeJ+h
tMxZcHUS6HJrSBDAyqV3WU1vWhwiCTb5Hn9U8KHrrk3BZl5BQoPdOolWtASL02FS
70jjKa5qt79ki6fHoij43RhXgqIcYze+qW1qxQijS2yxx1eKzvcT3LvHzqIzAJE6
ssMxX8OM7jPIi4HuG0/ban1xQQmsLLph1GVaXmkK7L5qzqbuHTycfj4s5aZ61kIq
seb/DUYf2a1rt0Syp4xR7eASIQH7QEkevRKjbWPzKx9u7UdTGHM=
=Bfpm
-----END PGP SIGNATURE-----

--5jbs3dkqzer36ufa--
