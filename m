Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC99C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 18:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C54360F0F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 18:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C54360F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244A06E95F;
	Wed, 28 Jul 2021 18:17:46 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54DC6E941;
 Wed, 28 Jul 2021 18:17:44 +0000 (UTC)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F328A1FFE2;
 Wed, 28 Jul 2021 18:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627496263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KkuD/5IO6SD7ce+UPtjyg20a19G2X3nHYhRJOqT0Bdw=;
 b=tvVgGx/9A8fG9bN+tRoZ/CKJvKkiPTL1Mrd5uwO2nrys/ou1XcFjoqbEYk9FIsEqbF1Orw
 OXmZdyb6IghieveZFqcEPG1R0EAity+mYga77zO2u9tjNyXE3MnXhr74Kk8cY+dvaK8WdY
 FN1b5AqC/8cKNcsfO+wEQwyKTSTNOWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627496263;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KkuD/5IO6SD7ce+UPtjyg20a19G2X3nHYhRJOqT0Bdw=;
 b=zATz+7KQERsHaII4t+Z+EycsMUxmluJ5ACWlh4Vb1XzQuGhdrke19azA5FnPEYdy3C9JPf
 mpBW79x+7ZS5wgAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6382113AAE;
 Wed, 28 Jul 2021 18:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id Bc/WFkafAWFhOwAAGKfGzw
 (envelope-from <tzimmermann@suse.de>); Wed, 28 Jul 2021 18:17:42 +0000
Subject: Re: [PATCH 03/14] drm/atmel-hlcdc: Convert to Linux IRQ interfaces
To: Sam Ravnborg <sam@ravnborg.org>, Dan.Sneddon@microchip.com
References: <20210727182721.17981-1-tzimmermann@suse.de>
 <20210727182721.17981-4-tzimmermann@suse.de> <YQFi96yaYbTG4OO7@ravnborg.org>
 <e28b1a2f-015c-c81b-eb64-5323df9ed35d@microchip.com>
 <YQF7bKyeup8n3awU@ravnborg.org>
 <3d2f6b84-dd07-d925-a8b8-2bfd5fc736d9@microchip.com>
 <YQGdxtV0BGZ8VOpm@ravnborg.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <2f04b986-6b41-62f9-1587-23818b841655@suse.de>
Date: Wed, 28 Jul 2021 20:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQGdxtV0BGZ8VOpm@ravnborg.org>
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
 jyri.sarha@iki.fi, Nicolas.Ferre@microchip.com, christian.koenig@amd.com,
 robdclark@gmail.com, kernel@pengutronix.de, alexander.deucher@amd.com,
 shawnguo@kernel.org, brian.starkey@arm.com
Content-Type: multipart/mixed; boundary="===============1026355180=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1026355180==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="z5DcqH4YdYEkUnOCPMsd2sQaAzMEoIc0d"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z5DcqH4YdYEkUnOCPMsd2sQaAzMEoIc0d
Content-Type: multipart/mixed; boundary="tPOuA2F7YMAM99rTZLmEwmHcAK0ClGc2a";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>, Dan.Sneddon@microchip.com
Cc: daniel@ffwll.ch, airlied@linux.ie, alexander.deucher@amd.com,
 christian.koenig@amd.com, liviu.dudau@arm.com, brian.starkey@arm.com,
 bbrezillon@kernel.org, Nicolas.Ferre@microchip.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, stefan@agner.ch,
 alison.wang@nxp.com, patrik.r.jakobsson@gmail.com,
 anitha.chrisanthus@intel.com, robdclark@gmail.com, edmund.j.dea@intel.com,
 sean@poorly.run, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, jyri.sarha@iki.fi, tomba@kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Message-ID: <2f04b986-6b41-62f9-1587-23818b841655@suse.de>
Subject: Re: [PATCH 03/14] drm/atmel-hlcdc: Convert to Linux IRQ interfaces
References: <20210727182721.17981-1-tzimmermann@suse.de>
 <20210727182721.17981-4-tzimmermann@suse.de> <YQFi96yaYbTG4OO7@ravnborg.org>
 <e28b1a2f-015c-c81b-eb64-5323df9ed35d@microchip.com>
 <YQF7bKyeup8n3awU@ravnborg.org>
 <3d2f6b84-dd07-d925-a8b8-2bfd5fc736d9@microchip.com>
 <YQGdxtV0BGZ8VOpm@ravnborg.org>
In-Reply-To: <YQGdxtV0BGZ8VOpm@ravnborg.org>

--tPOuA2F7YMAM99rTZLmEwmHcAK0ClGc2a
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 28.07.21 um 20:11 schrieb Sam Ravnborg:
> Hi Dan,
>=20
> thanks for the quick feedback!
>=20
> On Wed, Jul 28, 2021 at 05:50:34PM +0000, Dan.Sneddon@microchip.com wro=
te:
>> On 7/28/21 8:44 AM, Sam Ravnborg wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
>>>
>>> Hi Dan,
>>>
>>> On Wed, Jul 28, 2021 at 03:11:08PM +0000, Dan.Sneddon@microchip.com w=
rote:
>>>> On 7/28/21 7:00 AM, Sam Ravnborg wrote:
>>>>> [You don't often get email from sam@ravnborg.org. Learn why this is=
 important at http://aka.ms/LearnAboutSenderIdentification.]
>>>>>
>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you k=
now the content is safe
>>>>>
>>>>> Hi Dan,
>>>>>
>>>>> I hope you can fine to test this patch from Thomas.
>>>>> If this works then we can forget about my attempt to do the same.
>>>>
>>>> I'll test this as soon as I can and let you know.
>>>
>>> Thanks, crossing my fingers... (which explains the funny spelling fro=
m
>>> time to time)
>>>
>>>           Sam
>>> So I ran the test on an A5D27 XULT board with a PDA5 display.  Our
>> graphics demos that come with our linux4sam releases seem to run just
>> fine.  modetest -v seems to run just fine.  However, vbltest returns
>> "drmWaitVBlank (relative) failed ret: -1".  I don't understand why
>> modetest -v is working and vbltest isn't, but that's what I'm seeing.

Thanks for testing.

>=20
> Strange indeed.
>=20
>=20
> Just to be sure...
> Can you confirm that vbltest is working OK *before* this patch?

Yes, can you please verify that it regressed. If so, this would mean=20
that the driver misses vblank interrupts with the patch applied.

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


--tPOuA2F7YMAM99rTZLmEwmHcAK0ClGc2a--

--z5DcqH4YdYEkUnOCPMsd2sQaAzMEoIc0d
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmEBn0UFAwAAAAAACgkQlh/E3EQov+Dv
ZQ//dpBUrckWr6btF65QYYcLf78PaIWbdxIhBXVqGmypsQNfO9H9AGTnfDXGk5o1QgPaWz9SO88d
79AILOJGaG3c2eDr+aNOspwYajjcM4n2n4NWl86g4cE8KH2oayKm/G+ZqNEU+j40quLUu/94qCRz
Mp1bVO3qoyR2Y9W8Ms6wY5ryI9Fds9XvCfHqi3Ug2WKEzR9aR+WFZYw2R+bchfUK5U8Jy5PFo1il
C06KR14AHUj5JMWAZakI/nVqHwvD1DGbu87q4o9au/eo2ue9FGvhmSbOtKli/SCLHsel4aslvkcN
jFd1MC2yahweN1uzxSJ+UeJMV8aIyX2PASK61TUtAF87XLB8P5vMCrX32TelBYqbgu0DB14HHk+b
TAD3bqDCrVYI5KEuXjlfG+HD8YD7KoxVx8tlqWZuzf+NWimoRmqkRiSOmlLr40iiPW4CrWlHEHlk
XRSpSg/fahYbFCOEVTJqO5TNZMgFZM3jUR/BXagMvvr4YyD4/H8QC+8hhAbGcOjSVCU6+CeiE94a
XPThBhF34m7f7IzBShrcQNmyXp2xhhnBjPNuVBwmzI6nO+JivflzU/mjVfKTtnqHmpW9NdkgSJwg
mrXE9z3HsAqpwf4O0i+pgRNoZZA5K74rHVks2MFD5RhearMVVBdD6yHRRnXR3xQ/AMG0u6KGYKn5
TcQ=
=R3xJ
-----END PGP SIGNATURE-----

--z5DcqH4YdYEkUnOCPMsd2sQaAzMEoIc0d--

--===============1026355180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1026355180==--
