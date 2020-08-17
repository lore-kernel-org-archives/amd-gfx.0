Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E627AC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 06:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06FD20716
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 06:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06FD20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D086E051;
	Mon, 17 Aug 2020 06:31:34 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47626E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 06:31:33 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 149BDAD73;
 Mon, 17 Aug 2020 06:31:57 +0000 (UTC)
Subject: Re: TTM/nouveau conflict in drm-misc-next
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <2f7ae285-b51e-409f-9110-534bb68ec0ad@email.android.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <737111f0-3789-5e7d-3862-ca1a7c5050e8@suse.de>
Date: Mon, 17 Aug 2020 08:31:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2f7ae285-b51e-409f-9110-534bb68ec0ad@email.android.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1875208030=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1875208030==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u3dIidn9r3ohvCD92s0BvgEbxSiZZsTfC"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u3dIidn9r3ohvCD92s0BvgEbxSiZZsTfC
Content-Type: multipart/mixed; boundary="QjsVuS16iLAbXpRvnGF42ggzpRcmYMQLP";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Message-ID: <737111f0-3789-5e7d-3862-ca1a7c5050e8@suse.de>
Subject: Re: TTM/nouveau conflict in drm-misc-next
References: <2f7ae285-b51e-409f-9110-534bb68ec0ad@email.android.com>
In-Reply-To: <2f7ae285-b51e-409f-9110-534bb68ec0ad@email.android.com>

--QjsVuS16iLAbXpRvnGF42ggzpRcmYMQLP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 14.08.20 um 18:21 schrieb Koenig, Christian:
>=20
>=20
> Am 14.08.2020 17:53 schrieb Alex Deucher <alexdeucher@gmail.com>:
>=20
>     On Fri, Aug 14, 2020 at 11:22 AM Christian K=C3=B6nig
>     <christian.koenig@amd.com> wrote:
>     >
>     > Hey Thomas & Alex,
>     >
>     > well the TTM and Nouveau changes look good to me, but this comple=
tely
>     > broke amdgpu.
>     >
>     > Alex any idea what is going on here?
>=20
>     What's broken in amdgpu?=C2=A0 There shouldn't be any ttm changes i=
n amdgpu
>     for drm-next.=C2=A0 Those all go through drm-misc.
>=20
>=20
> It's not a TTM change.
>=20
> The backmerge of drm-next into drm-misc-next broke amdgpu so that even
> glxgears doesn't work anymore.
>=20
> But each individual merge head still works fine as far as I can say.
>=20
> Any idea how to track that down?

The backmerge brought in

  Fixes: 16e6eea29d7b ("Merge tag 'amd-drm-fixes-5.9-2020-08-07' ...)

which has quite a few commit. Maybe it's in one of them.

Best regards
Thomas

>=20
> Christian.
>=20
>=20
>     Alex
>=20
>     >
>     > Regards,
>     > Christian.
>     >
>     > Am 12.08.20 um 21:10 schrieb Thomas Zimmermann:
>     > > Hi Christian and Ben,
>     > >
>     > > I backmerged drm-next into drm-misc-next and had a conflict bet=
ween ttm
>     > > and nouveau. struct ttm_mem_res got renamed to struct ttm_resou=
rce. I
>     > > updated nouveau to the new name, test-built, and pushed the res=
ult to
>     > > drm-misc-next. If either of you has a minute, you may want to d=
ouble
>     > > check the merge.
>     > >
>     > > Best regards
>     > > Thomas
>     > >
>     >
>     > _______________________________________________
>     > amd-gfx mailing list
>     > amd-gfx@lists.freedesktop.org
>     > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C0=
1%7Cchristian.koenig%40amd.com%7Ca1aefc1ee22a4e733df908d8406a395c%7C3dd89=
61fe4884e608e11a82d994e183d%7C0%7C0%7C637330172275088649&amp;sdata=3DX2ZJ=
UETwoq884Xtg66sDudjXB%2F3s%2BgRglnh33gpU4Hc%3D&amp;reserved=3D0
>=20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--QjsVuS16iLAbXpRvnGF42ggzpRcmYMQLP--

--u3dIidn9r3ohvCD92s0BvgEbxSiZZsTfC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl86JEMUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiMHBgf/d9PW3aNNPItTrvpgAi31Cb65hbII
k2c/B1KEOa8xAwREGKszpgeunCdszVENj1Rs9o95Wdh0MXSqCtI09onnJORBiySr
87oNUkQWIp0Ujo5MUHigxeyWDEINwXDRYx3oNqUbthvhxTQEkuPbgXnJAsn0qAWU
lCk5VRdxqKkAVyUL2+v8H9GwJ+ugWdm3lp5VvzwecrI8Yy2w0QxKlXfz9DzdGlvz
SFoWnNAbv0Eqo0mZT4jnD/WrXENnD+JPcCgWS5plBYqCeZ7vPWM6Qtvshs/zNdzm
a82msWiPDTyesNZwvOcLFUSjZGhEsInAI819vakgzPxJUvlS04FbNVz1Vw==
=3FZH
-----END PGP SIGNATURE-----

--u3dIidn9r3ohvCD92s0BvgEbxSiZZsTfC--

--===============1875208030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1875208030==--
