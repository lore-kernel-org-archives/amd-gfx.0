Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648F6EB64DC
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 15:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3EF110E4BB;
	Wed, 21 Jun 2023 15:38:47 +0000 (UTC)
X-Greylist: delayed 1316 seconds by postgrey-1.36 at gabe;
 Tue, 20 Jun 2023 22:17:46 UTC
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk
 [95.217.213.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9474C10E19C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 22:17:46 +0000 (UTC)
Received: from [213.219.167.32] (helo=deadeye)
 by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <ben@decadent.org.uk>)
 id 1qBjKD-0006Bd-GM; Tue, 20 Jun 2023 23:55:45 +0200
Received: from ben by deadeye with local (Exim 4.96)
 (envelope-from <ben@decadent.org.uk>) id 1qBjKD-00BBOs-03;
 Tue, 20 Jun 2023 23:55:45 +0200
Message-ID: <2e6faab830d01849a8eec6871d66787db455864e.camel@decadent.org.uk>
Subject: Re: Possible missing firmware
 /lib/firmware/amdgpu/sienna_cichlid_mes.bin navi10_mes.bin for module amdgpu
From: Ben Hutchings <ben@decadent.org.uk>
To: amd-gfx@lists.freedesktop.org
Date: Tue, 20 Jun 2023 23:55:37 +0200
References: <168258140711.32181.12062781302326675605.reportbug@atzlinux-arm64>
In-Reply-To: <168258140711.32181.12062781302326675605.reportbug@atzlinux-arm64>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-CpMhR66BW1jvhP/b8PUy"
User-Agent: Evolution 3.48.2-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Mailman-Approved-At: Wed, 21 Jun 2023 15:38:42 +0000
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
Cc: 1034903@bugs.debian.org,
 xiao sheng =?UTF-8?Q?wen=28=E8=82=96=E7=9B=9B=E6=96=87=EF=BC=89?=
 <atzlinux@sina.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--=-CpMhR66BW1jvhP/b8PUy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Apr 2023 15:43:28 +0800 xiao sheng wen(=E8=82=96=E7=9B=9B=E6=96=
=87=EF=BC=89
<atzlinux@sina.com> wrote:
> Package: firmware-amd-graphics
> Version: 20230310-1~exp1
> Severity: normal
> X-Debbugs-Cc: atzlinux@sina.com
>=20
> Hi,
>=20
>=C2=A0 When I upgrade to kernel 5.10.0-22-arm64, there are following error
>=C2=A0 infos:
>=20
> W: Possible missing firmware /lib/firmware/amdgpu/sienna_cichlid_mes.bin =
for module amdgpu
> W: Possible missing firmware /lib/firmware/amdgpu/navi10_mes.bin for modu=
le amdgpu
[...]

I see that the amdgpu driver has had references to these files for
several years, but they've never been added to linux-firmware.git.
More recently amdgpu added:

MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes.bin");
MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes_2.bin");
MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");

and these are also missing from linux-firmware.git.

Is this firmware intended to be available to the public?

Ben.

--=20
Ben Hutchings
compatible: Gracefully accepts erroneous data from any source


--=-CpMhR66BW1jvhP/b8PUy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmSSIFoACgkQ57/I7JWG
EQkYzg/6AxdDEJUyLct4JRfBmMjJH5ItKcwwOkCXdfnOe8/481WSwXaZ8gE+P+8u
hFePtUPTALCK0YGi1eSEwbh5YPl3DEC2S+FtorIeXUFQlUrQjP1lnXFZ7YcQrnCi
PfxIunxQMF1xZgvGzs89WpbUHvJKKhlocUdsQiqgSFQ7lst94pAAcNkx1jFD+4CQ
4kdzfDwpxdDGLSYbz3Dj/CYeumLSD9xYXoVjrmrrblkjYQfbd7Z3rdG5tLtkIKXI
POL2cR6+fyWyz3wAa1BZSms1haYhSQIuT1NI3ARAhDMAfi/9vl5kOAgQVYvPPYZP
kjtUqk7mNDRUjndS7tc7t+IfRs4kD5x//EO0okp0VKet1Gy1jKI2TpeH/o20eDzG
T8RKt3xGXAf/ttE+sXUR/j6ucGxuHidW00yFRra+t05PN5k/FkdDhJRPKuHoJ56m
Lv+LA10wnxvRJvdeVdrE3kDw5/b6quNJ1kF7Jt8R/lCfmaMvXSsvoqDUEQ6YYy4D
o1kLvZ3fWQ67gSBGFW5Vk9RMHGSm8OCDOF3aMJV5c5Z15tICDAZgX8cvIYD1ciaa
WO1lkJTjxIRIafWE+Zg2X7O7ok//2rBl4fxOEfi7lBDdwqJNNoYG7EVq/z4+ZI/6
qgOc0zsOBbKAj2UlChMf7qFmccu+uD8B47nOBt5pmaL4tka8mVc=
=B9TS
-----END PGP SIGNATURE-----

--=-CpMhR66BW1jvhP/b8PUy--
