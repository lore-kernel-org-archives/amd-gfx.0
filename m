Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0094E748E7
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Sep 2023 20:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F8F10E181;
	Sat, 30 Sep 2023 20:18:34 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796AD10E181
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Sep 2023 20:18:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6810D602E0;
 Sat, 30 Sep 2023 20:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1471C433C8;
 Sat, 30 Sep 2023 20:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696105110;
 bh=FTlwwgmgFwVTZLLMsU57H1kZgpJ32lA2eayUmZZAFx0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CIf0m6kTiLVmN7vphVVTDYVxtcA4zyYjmfiYHMlH96MAEvj7/X4JN20CtuRsbECYD
 H/CrCdw/GrmuVwnFhZhYkcbVFO/lmXXbqxGvI6PJWDyozRDaweQWgOmas9ozjn3iyT
 9QItmVMox2fl713LAOO8P/bIdUBkArOe7B5ilyyk9dbU8aMyZFcDmqY7M3TZu7uCSQ
 6FLEimcs9X0Fl/ds6Dl0zq70xHjEakA+Hyv28eehdHI858aYZhkNfOUCm3Ahzgqs+1
 zr0WbMfVSTp5RMAjntTA25X0F0nhjDiDlSuUxoE70khv6ZC3N90gp526bZywSCvLPL
 neZLvDetlKMfQ==
Received: by mercury (Postfix, from userid 1000)
 id 3236B10603F9; Sat, 30 Sep 2023 22:18:26 +0200 (CEST)
Date: Sat, 30 Sep 2023 22:18:26 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/3] power: supply: Don't count 'unknown' scope power
 supplies
Message-ID: <20230930201826.biy27esyw4ttxt4p@mercury.elektranox.org>
References: <20230926225955.386553-1-mario.limonciello@amd.com>
 <20230926225955.386553-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4p2i5gnoe5rlcwny"
Content-Disposition: inline
In-Reply-To: <20230926225955.386553-3-mario.limonciello@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jun.ma2@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-pm@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--4p2i5gnoe5rlcwny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 26, 2023 at 05:59:54PM -0500, Mario Limonciello wrote:
> On some systems AMD Navi3x dGPU triggers RAS errors on startup; but
> only if the amdgpu kernel module is not part of the initramfs.
> This is because the hardware is not properly programmed for the
> AC/DC state of the system when it is loaded later in boot.

I don't understand the last sentence. As far as I can see
i2c_dw_pci_probe() either does not registers UCSI at all or
with the dGPU properties (and thus scope) set.

> The AC/DC state of the system is incorrect specifically when UCSI power
> supplies have been initialized.  These power supplies are marked as
> POWER_SUPPLY_SCOPE_UNKNOWN scope. As they're 'offline' the power
> supply count is increased but the resultant return value is
> power_supply_is_system_supplied() 0.
>=20
> To fix this look explicitly for `POWER_SUPPLY_SCOPE_SYSTEM` power
> supplies before incrementing the count. If no system power supply
> is found then the system is assumed to be on AC.
>=20
> Cc: stable@vger.kernel.org
> Tested-by: David Perry <David.Perry@amd.com>
> Fixes: 95339f40a8b6 ("power: supply: Fix logic checking if system is runn=
ing from battery")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

This effectively fully disables supply detection for UCSI, because
it is never set to POWER_SUPPLY_SCOPE_SYSTEM. Please fix the amdgpu
init part instead.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index d325e6dbc770..3de6e6d00815 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -349,7 +349,7 @@ static int __power_supply_is_system_supplied(struct d=
evice *dev, void *data)
>  	unsigned int *count =3D data;
> =20
>  	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
> -		if (ret.intval =3D=3D POWER_SUPPLY_SCOPE_DEVICE)
> +		if (ret.intval !=3D POWER_SUPPLY_SCOPE_SYSTEM)
>  			return 0;
> =20
>  	(*count)++;
> --=20
> 2.34.1
>=20

--4p2i5gnoe5rlcwny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUYgocACgkQ2O7X88g7
+pq7lA//a6K7B++DJWK3qkFLkvZrvZfxhxBV7WbHyZ/uCAaUihZnq2ItQVwlZlRE
W4NvbCAtY4ifJhEaf+kpFSVF6xF2LEr0sw6Z6tsa822T+w+icl/+23elZwrJzuG5
xA66zaamIYkyVeirbMo/FW8YokslGc+LPzzl2VlPiv2YjupS0+US48HON00gFc8t
OsGo9CAqbpXRMe9GZAtun0oVni/pMV3NZp9U1RVdfepE7GPuHQEQKxSjQnbf92/k
hbgTNAA1ehb0I60YbCyyeoFkJvGVA5FMxmetlFQ5oR7Idb6AHhvU3Qs4jhFApC1Q
yqX5tn2ieZS8gzhhUj0YPvFjJ8qXqDX6TKnjeUzcy3FzF1lZg5WiVqkVtFEHTClK
cWPfr0MpMEDgnvcKWs9TJQb4cUNB1te5slrip86Goh0Au/RlL5cSsQDhx5U+vsCc
Tz9S+lgkqUDTzmQ7/ecjZwiihXb49Uq4bLRm9ir9vNkOJNFCnoum6UboVh/UbROJ
qN7HKK/HPdSlCdfNwfRsJMBj7q7uQj8SZZSRyGKA3k7BFiu2VmG0poM+nbK1gye7
Q0qHZSZo+UrdUqWEhS0zMDz/udJwCZvfrIxAo1DKwEyPwNNOynVmAMEtOGASUiV8
zxIHpH/ys1uLHSRop1O66W3uNxF+I1k6dljKdSIWxemE0CJo8bc=
=skRU
-----END PGP SIGNATURE-----

--4p2i5gnoe5rlcwny--
