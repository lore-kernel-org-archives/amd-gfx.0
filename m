Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C62C47074
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 08:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DEAE10E07B;
	Wed, 10 Jan 2024 08:01:54 +0000 (UTC)
X-Greylist: delayed 43452 seconds by postgrey-1.36 at gabe;
 Tue, 09 Jan 2024 20:27:35 UTC
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B9ED10E4F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 20:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1704832053; x=1705091253;
 bh=7ixb2tpHW/RPQRaleHpRoSAeVz0mjPyGFVu5un9CyUU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=v36KztCccWvaxt/5/OCOdiDh5bqgwLK7nvGoSd8RMWMx3DS/QmnGNieicUAO1++XJ
 hfh5abfL2wVxggBy5q1/NfNZ1TuGuBRat14AF/e8ojbGlu5Bkd+WoDB5vK+hH8bBmW
 0CzAVbbU6pOGmFE5xyVowNGMt8HxuSLAu8porSlFh+825wmCRr87iNEVMjrnUUMC/b
 NYK+wsOrrzSMVOsHAwCTp9LWVwWmtrugOQZADj0gZ+Hmg+Ih6X7yrVpWhG5Md/sHvs
 H3zddnUBTpibieBmvxESVBioNx7RDDNAZ/4hT5NMd2DwRitSEh7ouohHPfZPzfZrtG
 oq9ld25scrq1g==
Date: Tue, 09 Jan 2024 20:27:14 +0000
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
From: Alexander Koskovich <AKoskovich@protonmail.com>
Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
Message-ID: <Z8njgokdcTunZi6xnF-M7IGXA4_xj14qJE91X07_kII2oHfXkYWS45kIoKR3en9EIFyylWj5U_VFOjZkqcgbN_14JkeMlNtsRc13Jjvro58=@protonmail.com>
In-Reply-To: <BL1PR12MB5144D58D8EDA16731BA48102F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <xgXz7D0Xgjysg4ZLJpfd1ryjeEoM2fKFn9W5WIGBGxc6WSxcYxTZPzwKRNbqPYcDIf8P1zuDr5SYqSvl36GqzW8TimxvO7BGDq5S_zv8v3g=@protonmail.com>
 <BL1PR12MB5144D58D8EDA16731BA48102F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
Feedback-ID: 37836827:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 10 Jan 2024 08:01:54 +0000
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

Doe AMD have documentation on the i2c data that gets sent currently though?=
 I was hoping to figure out what you need to change in the command that get=
s sent to change stuff like brightness, color (red, green, blue), rainbow, =
morse code, etc.

On Tuesday, January 9th, 2024 at 10:10 AM, Deucher, Alexander <Alexander.De=
ucher@amd.com> wrote:


>=20
>=20
> [Public]
>=20
> > -----Original Message-----
> > From: Alexander Koskovich AKoskovich@protonmail.com
> > Sent: Monday, January 8, 2024 7:22 PM
> > To: Deucher, Alexander Alexander.Deucher@amd.com
> > Cc: amd-gfx@lists.freedesktop.org
> > Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
> >=20
> > Currently the reference cooler from AMD does not have an existing RGB
> > controller for OpenRGB, that's why I was looking for documentation on t=
he
> > I2C commands to send to the second SMU, so I don't risk bricking my car=
d by
> > sending wrong commands during development somehow.
> >=20
> > writeSetCMDWithData:
> > **************************************************************
> > adli2c.iSize =3D sizeof(ADLI2C)
> > adli2c.iAction =3D ADL_DL_I2C_ACTIONWRITE
> > adli2c.iAddress =3D 0xb4
> > adli2c.iSpeed =3D 100
> > 0 --------------------------------------------------
> > Dev 0: ADL_Display_WriteAndReadSMUI2C(0, &adli2c) =3D 0 adli2c.iDataSiz=
e =3D
> > 24 i2cData[0]~[24]
> > 40 51 2c 01 00 00 ff 00 ff ff ff cc 00 cc 00 00 00 ff ff ff ff ff ff ff
> >=20
> > From the RGB app's logs this is an example of what the official AMD
> > application on Windows is sending when it changes colors on the RGB str=
ip.
> >=20
> > From this can it be assumed the AMD card is using the latter method you
> > mentioned with the second SMU I2C bus, in which case no driver changes
> > would be needed?
>=20
>=20
>=20
> IIRC, each AIB/OEM uses its own preferred RGB controller. The reference b=
oard just defines which i2c buses can be used. The RGB control application =
is just a userspace app provided by the AIB/OEM that calls ADL to talk to w=
hichever i2c bus the vendor put their RGB controller on. On Linux you can d=
o something similar using the i2c_dev module to open a connection to the i2=
c bus driver provided by the kernel. I believe that is what openRGB does to=
day. It looks like you already have the programming sequence above.
>=20
> Alex
>=20
> > On Monday, January 8th, 2024 at 5:32 PM, Deucher, Alexander
> > Alexander.Deucher@amd.com wrote:
> >=20
> > > [Public]
> > >=20
> > > > -----Original Message-----
> > > > From: amd-gfx amd-gfx-bounces@lists.freedesktop.org On Behalf Of
> > > > Alexander Koskovich
> > > > Sent: Sunday, January 7, 2024 11:19 PM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Subject: Documentation for RGB strip on RX 7900 XTX (Reference)
> > > >=20
> > > > Hello,
> > > >=20
> > > > I was wondering if AMD would be able provide any documentation for
> > > > the RGB strip on the reference cooler
> > > > (https://www.amd.com/en/products/graphics/amd-radeon-rx-7900xtx)?
> > > > It
> > > > looks to be handled via I2C commands to the SMU, but having proper
> > > > documentation would be extremely helpful.
> > >=20
> > > It depends on the AIB/OEM and how they designed the specific board. T=
he
> > > RGB controller will either be attached to the DDCVGA i2c bus on the d=
isplay
> > > hardware or the second SMU i2c bus. The former will require changes t=
o the
> > > amdgpu display code to register display i2c buses that are not used b=
y the
> > > display connectors on the board so they can be used by 3rd party appl=
ications.
> > > Currently we only register i2c buses used for display connectors. The=
 latter
> > > buses are already registered with the i2c subsystem since they are us=
ed for
> > > other things like EEPROMs on server and workstation cards and should =
be
> > > available via standard Linux i2c APIs. I'm not sure what i2c LED cont=
rollers each
> > > AIB vendor uses off hand. https://openrgb.org/index.html would probab=
ly be
> > > a good resource for that information.
> > >=20
> > > Alex
