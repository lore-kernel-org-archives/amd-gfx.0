Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871D8C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 08:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE0BC10E6D5;
	Tue,  9 Jan 2024 08:24:18 +0000 (UTC)
X-Greylist: delayed 72190 seconds by postgrey-1.36 at gabe;
 Tue, 09 Jan 2024 00:22:38 UTC
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch
 [185.70.40.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5864F10E345
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 00:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1704759756; x=1705018956;
 bh=zW7EUi01wY33qTJ4ozzoYZtdwcQPADBEmJ9Ygjx4taQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=uozsjLLQQWDPDmdII+uqoZ9T8c3W1/gzTX8afWR4N34K791ucV/nEecEmOpjxuvp7
 RrHB6EjD+0dGrIChZdwTzLlkPrzo/oXWuwkve/cE17jAkm6ao3S4t/ZsG/Gj3nkJDB
 cBcRtWSQ9X6/0ssZ3rdVPpDhRb8McdtTvGiGJH/nYS6DmsVyCBYfEa8P+rtJcbLllu
 ySOkSuqLkLGRSxN6EPjMjbn1enZWXBF8UfvPqPXnroD3KoZ330oFq7Fjl/cHs7D7Bq
 LD9D3qPEadBd5enEQLInYgqoQZummxoczUILIXJ6i8Wi3M+DtiTjsmgXauFSkXADDr
 kNbiTelFgwPUg==
Date: Tue, 09 Jan 2024 00:22:16 +0000
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
From: Alexander Koskovich <AKoskovich@protonmail.com>
Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
Message-ID: <xgXz7D0Xgjysg4ZLJpfd1ryjeEoM2fKFn9W5WIGBGxc6WSxcYxTZPzwKRNbqPYcDIf8P1zuDr5SYqSvl36GqzW8TimxvO7BGDq5S_zv8v3g=@protonmail.com>
In-Reply-To: <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
Feedback-ID: 37836827:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 09 Jan 2024 08:24:17 +0000
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently the reference cooler from AMD does not have an existing RGB contr=
oller for OpenRGB, that's why I was looking for documentation on the I2C co=
mmands to send to the second SMU, so I don't risk bricking my card by sendi=
ng wrong commands during development somehow.

writeSetCMDWithData:
**************************************************************
adli2c.iSize =3D sizeof(ADLI2C)
adli2c.iAction =3D ADL_DL_I2C_ACTIONWRITE
adli2c.iAddress =3D 0xb4
adli2c.iSpeed =3D 100
0 --------------------------------------------------
Dev 0: ADL_Display_WriteAndReadSMUI2C(0, &adli2c) =3D 0
adli2c.iDataSize =3D 24
i2cData[0]~[24]
40 51 2c 01 00 00 ff 00 ff ff ff cc 00 cc 00 00 00 ff ff ff ff ff ff ff

From the RGB app's logs this is an example of what the official AMD applica=
tion on Windows is sending when it changes colors on the RGB strip.

From this can it be assumed the AMD card is using the latter method you men=
tioned with the second SMU I2C bus, in which case no driver changes would b=
e needed?


On Monday, January 8th, 2024 at 5:32 PM, Deucher, Alexander <Alexander.Deuc=
her@amd.com> wrote:


>=20
>=20
> [Public]
>=20
> > -----Original Message-----
> > From: amd-gfx amd-gfx-bounces@lists.freedesktop.org On Behalf Of
> > Alexander Koskovich
> > Sent: Sunday, January 7, 2024 11:19 PM
> > To: amd-gfx@lists.freedesktop.org
> > Subject: Documentation for RGB strip on RX 7900 XTX (Reference)
> >=20
> > Hello,
> >=20
> > I was wondering if AMD would be able provide any documentation for the
> > RGB strip on the reference cooler
> > (https://www.amd.com/en/products/graphics/amd-radeon-rx-7900xtx)? It
> > looks to be handled via I2C commands to the SMU, but having proper
> > documentation would be extremely helpful.
>=20
>=20
> It depends on the AIB/OEM and how they designed the specific board. The R=
GB controller will either be attached to the DDCVGA i2c bus on the display =
hardware or the second SMU i2c bus. The former will require changes to the =
amdgpu display code to register display i2c buses that are not used by the =
display connectors on the board so they can be used by 3rd party applicatio=
ns. Currently we only register i2c buses used for display connectors. The l=
atter buses are already registered with the i2c subsystem since they are us=
ed for other things like EEPROMs on server and workstation cards and should=
 be available via standard Linux i2c APIs. I'm not sure what i2c LED contro=
llers each AIB vendor uses off hand. https://openrgb.org/index.html would p=
robably be a good resource for that information.
>=20
> Alex
