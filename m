Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D286AC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 05:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF4660C3E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 05:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7477A6EC7C;
	Wed, 28 Jul 2021 05:19:21 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08ACD6E027;
 Wed, 28 Jul 2021 05:19:19 +0000 (UTC)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C8DE22261;
 Wed, 28 Jul 2021 05:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627449558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YmfSl7/J4rPd2qBHbKNtkwTubic3cXWaOLC2leTR4LQ=;
 b=flb5jOJ92JPke2khTYzDgIbsylLsXyNyM6OVWk0FuamSZTMSE3j6bP5WF7lXoKURFzC2oc
 EPA1hSj2ydTwmd8y1IAvGDQ3N+o4DOrWYcx3u4CmZ0vGGUL/lz+9WUmk1j7gjStY0P0is7
 M/5pbOrnyI7W7A6IIv3hyVC5kBtra78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627449558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YmfSl7/J4rPd2qBHbKNtkwTubic3cXWaOLC2leTR4LQ=;
 b=T9onue0syqQ44Ixg7sUrHDrRX6fbDHpFQhyZOpb3WKaG/d8NOOnLWjUBv15JpeQjFGKh41
 jn0fnx2mvsHJzpAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AB22A13CF4;
 Wed, 28 Jul 2021 05:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id RqfLKNXoAGFdVQAAGKfGzw
 (envelope-from <tzimmermann@suse.de>); Wed, 28 Jul 2021 05:19:17 +0000
Subject: Re: [PATCH 00/14] drm: Make DRM's IRQ helpers legacy
To: Sam Ravnborg <sam@ravnborg.org>
References: <20210727182721.17981-1-tzimmermann@suse.de>
 <YQBVyuPuf9InsY7g@ravnborg.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <d11b4688-b05e-8936-50dc-22eee9dd2983@suse.de>
Date: Wed, 28 Jul 2021 07:19:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQBVyuPuf9InsY7g@ravnborg.org>
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
Cc: airlied@linux.ie, liviu.dudau@arm.com, stefan@agner.ch,
 amd-gfx@lists.freedesktop.org, anitha.chrisanthus@intel.com,
 patrik.r.jakobsson@gmail.com, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, daniel@ffwll.ch, edmund.j.dea@intel.com,
 s.hauer@pengutronix.de, alison.wang@nxp.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, dri-devel@lists.freedesktop.org, sean@poorly.run,
 linux-arm-kernel@lists.infradead.org, tomba@kernel.org, bbrezillon@kernel.org,
 jyri.sarha@iki.fi, nicolas.ferre@microchip.com, christian.koenig@amd.com,
 robdclark@gmail.com, kernel@pengutronix.de, alexander.deucher@amd.com,
 shawnguo@kernel.org, brian.starkey@arm.com
Content-Type: multipart/mixed; boundary="===============1449518652=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1449518652==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XYIqRf9rflDQEkfaVzrzYZxOjhzcpsV4c"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XYIqRf9rflDQEkfaVzrzYZxOjhzcpsV4c
Content-Type: multipart/mixed; boundary="GmOTuz8b5Zd4f7WcpPA58UjJwmtsS3ps4";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: daniel@ffwll.ch, airlied@linux.ie, alexander.deucher@amd.com,
 christian.koenig@amd.com, liviu.dudau@arm.com, brian.starkey@arm.com,
 bbrezillon@kernel.org, nicolas.ferre@microchip.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, stefan@agner.ch,
 alison.wang@nxp.com, patrik.r.jakobsson@gmail.com,
 anitha.chrisanthus@intel.com, robdclark@gmail.com, edmund.j.dea@intel.com,
 sean@poorly.run, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, jyri.sarha@iki.fi, tomba@kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Message-ID: <d11b4688-b05e-8936-50dc-22eee9dd2983@suse.de>
Subject: Re: [PATCH 00/14] drm: Make DRM's IRQ helpers legacy
References: <20210727182721.17981-1-tzimmermann@suse.de>
 <YQBVyuPuf9InsY7g@ravnborg.org>
In-Reply-To: <YQBVyuPuf9InsY7g@ravnborg.org>

--GmOTuz8b5Zd4f7WcpPA58UjJwmtsS3ps4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sam

Am 27.07.21 um 20:51 schrieb Sam Ravnborg:
> Hi Thomas,
>=20
> On Tue, Jul 27, 2021 at 08:27:07PM +0200, Thomas Zimmermann wrote:
>> DRM's IRQ helpers are only helpful for old, non-KMS drivers. Move
>> the code behind CONFIG_DRM_LEGACY. Convert KMS drivers to Linux
>> IRQ interfaces.
>>
>> DRM provides IRQ helpers for setting up, receiving and removing IRQ
>> handlers. It's an abstraction over plain Linux functions. The code
>> is mid-layerish with several callbacks to hook into the rsp drivers.
>> Old UMS driver have their interrupts enabled via ioctl, so these
>> abstractions makes some sense. Modern KMS manage all their interrupts
>> internally. Using the DRM helpers adds indirection without benefits.
>>
>> Most KMs drivers already use Linux IRQ functions instead of DRM's
>> abstraction layer. Patches 1 to 12 convert the remaining ones.
>> The patches also resolve a bug for devices without assigned interrupt
>> number. DRM helpers don't test for IRQ_NOTCONNECTED, so drivers do
>> not detect if the device has no interrupt assigned.
>=20
> Before diving into a review of these..
> Any specific reason devm_request_irq is not used?

Thanks for looking at the patches.

Switching to devm_ definately makes sense in the longer term.
  I didn't do this here to not change the order of clean-up operations=20
in general. And some of the drivers have dedicated IRQ clean-up code,=20
which might depend on the correct order as well.

Best regards
Thomas

>=20
> 	Sam
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--GmOTuz8b5Zd4f7WcpPA58UjJwmtsS3ps4--

--XYIqRf9rflDQEkfaVzrzYZxOjhzcpsV4c
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmEA6NUFAwAAAAAACgkQlh/E3EQov+Ap
UQ//YR7yzSptLZNGuqp9g/OkDCywROMgVcE14mlYlrq4f0aQRcmfMsJDtEZN+CVtryarPnUlKZ0j
8u+N8xFcBhIFTxqblkyIPu6Ex/dVzxjoDVWXkJX4UBeI5+QHxzyV+JQlEBKFbePlRa8yFUN863gO
dX68d1UC4djOb39EgLF+oIYHzWOKnfgOQ5iw8OCiMz35sNG3jiwiCpUqWXrXWhMtg6p0Byv+/2eA
XUILsWClwUhOn2j3qEnibjikbtxP3pxGN5D+ZbjWCzzgU88iJCjzns2IBalLtEKF/1rOHyhqh+7T
xOtRQiLH9pDCNJu0qzQj8u3v5MbGkQ2Kd1AshVzSuXHRwMB4Meu8KmuzByEE0QXcCmKIDLWGVqxc
MHlQq4OPDHe2lTs6np2DaenFVYCXKz7RMsYKaRvPsarN4B/lYEc1XBjMAF3ssyZ/SbaiFeLGvHGE
OYX9ZqFAyaBAE4A3V88tIJjHuPqhjilkdv4azHsD0nGP+AkUSMXNcukO5aUug+7BAtyYC020cl62
QuJWg4pvxgstJYbibzNjLqChvIWV/ZNUgN4j2g5HOgf8NylRCF4ZxNhkTdQ638UtKQtIj/rht2Mw
vDP4PP4VlQR+vAorMusCFjyRxBZKC4uE9QNjI97yM/mlUtR0XeVLHnxYyzr/3+zldyrb8/AN5EH0
SC0=
=2i7L
-----END PGP SIGNATURE-----

--XYIqRf9rflDQEkfaVzrzYZxOjhzcpsV4c--

--===============1449518652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1449518652==--
