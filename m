Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4166C4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6485F208A9
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6485F208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184756ECEA;
	Fri, 25 Sep 2020 14:29:36 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B2A6ECEA;
 Fri, 25 Sep 2020 14:29:35 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E1393AEA2;
 Fri, 25 Sep 2020 14:29:33 +0000 (UTC)
To: dri-devel <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: CONFIG_AMDGPU triggers full rebuild
Message-ID: <e7f5e4ae-7a6a-0a3c-666c-05180a8fe726@suse.de>
Date: Fri, 25 Sep 2020 16:29:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
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
Content-Type: multipart/mixed; boundary="===============0259102185=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0259102185==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FCYlPvSobQc4FLFylqGr9WvYc5BskF5lw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FCYlPvSobQc4FLFylqGr9WvYc5BskF5lw
Content-Type: multipart/mixed; boundary="EJ9fEwxZLb7Y7f0SXXJRND0msh2nlhCLL";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: dri-devel <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Message-ID: <e7f5e4ae-7a6a-0a3c-666c-05180a8fe726@suse.de>
Subject: CONFIG_AMDGPU triggers full rebuild

--EJ9fEwxZLb7Y7f0SXXJRND0msh2nlhCLL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

whenever I change the option CONFIG_AMDGPU, I have to rebuild the whole
kernel. I guess it auto-selects some architecture-specific feature. That
full rebuild might be avoidable if I could enable that feature permanentl=
y.

Any ideas what this could be and how to avoid the full rebuilt?

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--EJ9fEwxZLb7Y7f0SXXJRND0msh2nlhCLL--

--FCYlPvSobQc4FLFylqGr9WvYc5BskF5lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl9t/soUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiNF3Af/SDh245RuXSjq3ti1xXlpSCxnsIrD
zcltr53jmV+1KIBPOYNyvI4/jHeL2b36gMlkx6WPHy3/wfTLCTlasnKHQrVWmLxY
/GM7F/ezbN5uZIKvhL0XS52Rt9TA4sc4WS0NCNubH3bGcalQUqbl7ZOHHRJweXZF
bwkii8gcz3JjGrS2E1Nt8wBjZYLVbB/SWUgwFmgJKvDOKrN7ZpCGt6r0P4Qzyxkf
gSaInqAvUAtImoBHByZKr7lIT11/zPZHW/CPUuLF+H9PgybknXM2qJ7MFdJM4OeA
gzkYOj6r8FSx9X4MdUK9RRDsaHPXQUd+l2FWpwJdh0KAK2HTqhIj1rf4xA==
=sPgD
-----END PGP SIGNATURE-----

--FCYlPvSobQc4FLFylqGr9WvYc5BskF5lw--

--===============0259102185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0259102185==--
