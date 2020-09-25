Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE3C4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 15:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0812520715
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 15:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0812520715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9566C8999C;
	Fri, 25 Sep 2020 15:04:25 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15E0C89991;
 Fri, 25 Sep 2020 15:04:24 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BCC31AE35;
 Fri, 25 Sep 2020 15:04:22 +0000 (UTC)
Subject: Re: CONFIG_AMDGPU triggers full rebuild
To: christian.koenig@amd.com, dri-devel <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <e7f5e4ae-7a6a-0a3c-666c-05180a8fe726@suse.de>
 <5d0d4c05-a42a-a3d2-87a1-8520ab64a062@gmail.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <6e51415d-abf8-352a-565d-22208c0cf84d@suse.de>
Date: Fri, 25 Sep 2020 17:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5d0d4c05-a42a-a3d2-87a1-8520ab64a062@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0830129449=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0830129449==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DiluMnPQF5PGYkElUtkGv6K6MtgdAddEu"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DiluMnPQF5PGYkElUtkGv6K6MtgdAddEu
Content-Type: multipart/mixed; boundary="KkWUM8EXFiAqg3RGQh1RGi9G74YebMf1J";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: christian.koenig@amd.com, dri-devel <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Message-ID: <6e51415d-abf8-352a-565d-22208c0cf84d@suse.de>
Subject: Re: CONFIG_AMDGPU triggers full rebuild
References: <e7f5e4ae-7a6a-0a3c-666c-05180a8fe726@suse.de>
 <5d0d4c05-a42a-a3d2-87a1-8520ab64a062@gmail.com>
In-Reply-To: <5d0d4c05-a42a-a3d2-87a1-8520ab64a062@gmail.com>

--KkWUM8EXFiAqg3RGQh1RGi9G74YebMf1J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Christian

Am 25.09.20 um 16:54 schrieb Christian K=C3=B6nig:
> Maybe MMU notifiers? But honestly I don't know for sure.

I checked. In my current config MMU_NOTIFIERS is y and DRM_AMDGPU is n.
So it shouldn't have triggered the rebuilds, I guess.

Anyway, thanks for trying to help.

Best regards
Thomas

>=20
> Christian.
>=20
> Am 25.09.20 um 16:29 schrieb Thomas Zimmermann:
>> Hi,
>>
>> whenever I change the option CONFIG_AMDGPU, I have to rebuild the whol=
e
>> kernel. I guess it auto-selects some architecture-specific feature. Th=
at
>> full rebuild might be avoidable if I could enable that feature permane=
ntly.
>>
>> Any ideas what this could be and how to avoid the full rebuilt?
>>
>> Best regards
>> Thomas
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--KkWUM8EXFiAqg3RGQh1RGi9G74YebMf1J--

--DiluMnPQF5PGYkElUtkGv6K6MtgdAddEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl9uBvYUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiO+LAf+OPyHPDIBioZnyTRBHI7FgNNMzBYg
83SZxkpBeBLiUs2lNr8eFScu2SHhXef41eiYaCPUY6eosiTWeipWM/xDSt3QsiH9
hsEMUwU9ZO905t7vQ7/cTCKOVgWgD4SjSzd91+Utp8htRmpmRP3DD2jpRNBSqZO8
LqEvvPrlBJl+VX8J35Mw0g7keBXfhnxVjESv0JemM1zZCp5sqH9dqQD+rgCdRMEG
Zd99n/uPJat3OdJ5F/IU6XcbCQIkLxk3pYwMe7UcukB8hS42bh3ouNjmPgoRJGNs
nihSF9z3V8Cg6B2sTitNPiPWhjTVJan8YGtyExqab+r1Gfkk7iR1mGXccg==
=R9Bp
-----END PGP SIGNATURE-----

--DiluMnPQF5PGYkElUtkGv6K6MtgdAddEu--

--===============0830129449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0830129449==--
