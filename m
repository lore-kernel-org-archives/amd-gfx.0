Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50184C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 08:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B17410E36D;
	Wed, 10 Jan 2024 08:01:55 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454E410E4EF
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 23:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1704841286; x=1705100486;
 bh=LZmVqhsHJSzkz7VL5lKnsUDcm+YTFQwyz0yZMgnoMzo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=YK6qmmrNAlQ7JwnYObKqTEA9QgzjaXObDQ90+YALewAi4c14zxMP+zT7fkd3Fugt8
 Ie3xbPK787gzNNWAd4bWj5FKbYdey/ow5hCdzPutARywi3ygzemgWVWvqjCXW1ym/D
 oEEXsQEFK7BxnFQy/Zx9xH2rNAcDTreHN4KxXTEWU9vWXCDi7g+vbujOFjwgJpNUPc
 I2TkmkHJH+89OaOF6tpijPpk/fKMTbEMbFsAQWgJq0Svl9h9jNmQLg/Xk6hgst1e3P
 DYsPslLj9cl4mGYyCoyM6yEu7UQf8TcWuJ4Q2C77jfwzPCsdJxdjGqfu0L1bihczbL
 Kn8ISueeed2cQ==
Date: Tue, 09 Jan 2024 23:01:11 +0000
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
From: Alexander Koskovich <AKoskovich@protonmail.com>
Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
Message-ID: <CQ1lqxoKApOV23Hn7-TzeyTw7bFRmjd50jWjrW_Uv6aezf4MU4myw_tl_EyPWJ0oKocBEhCHbSuKvJdo9Su3-RM6pB35mPwWmukIf8og6hs=@protonmail.com>
In-Reply-To: <BL1PR12MB51448DA153067FE1F635FEB1F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <xgXz7D0Xgjysg4ZLJpfd1ryjeEoM2fKFn9W5WIGBGxc6WSxcYxTZPzwKRNbqPYcDIf8P1zuDr5SYqSvl36GqzW8TimxvO7BGDq5S_zv8v3g=@protonmail.com>
 <BL1PR12MB5144D58D8EDA16731BA48102F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <Z8njgokdcTunZi6xnF-M7IGXA4_xj14qJE91X07_kII2oHfXkYWS45kIoKR3en9EIFyylWj5U_VFOjZkqcgbN_14JkeMlNtsRc13Jjvro58=@protonmail.com>
 <BL1PR12MB5144B46479ABF320088A4976F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <q_oRbF5mexY0ttw_MbcyqUd1KQIr1Ny7pg5sCCcIpor4AKUwktVDvuwoUpW0JO-rJXxJnyB5zOQ4JDYGRM2vNWeC2tMAsEto2JHlN6o-4Tk=@protonmail.com>
 <BL1PR12MB5144D4968D7C79D30F9D63F1F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BL1PR12MB51448DA153067FE1F635FEB1F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
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

I initially tried reaching out to the Coolermaster technical email, but I g=
ot no response. Is there a better contact for something like this?



On Tuesday, January 9th, 2024 at 5:58 PM, Deucher, Alexander <Alexander.Deu=
cher@amd.com> wrote:


>=20
>=20
> [Public]
>=20
> > -----Original Message-----
> > From: amd-gfx amd-gfx-bounces@lists.freedesktop.org On Behalf Of
> > Deucher, Alexander
> > Sent: Tuesday, January 9, 2024 5:29 PM
> > To: Alexander Koskovich AKoskovich@protonmail.com
> > Cc: amd-gfx@lists.freedesktop.org
> > Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
> >=20
> > > -----Original Message-----
> > > From: Alexander Koskovich AKoskovich@protonmail.com
> > > Sent: Tuesday, January 9, 2024 4:59 PM
> > > To: Deucher, Alexander Alexander.Deucher@amd.com
> > > Cc: amd-gfx@lists.freedesktop.org
> > > Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
> > >=20
> > > Is the AIB/OEM for this board not AMD?
> > > https://www.amd.com/en/products/graphics/amd-radeon-rx-7900xtx
> >=20
> > I'll double check (we usually don't produce reference boards with RGB),=
 but
> > my understanding is that if any of the boards available for sale on amd=
.com
> > has RGB controls, the RGB control is provided by a third party vendor.
>=20
>=20
>=20
> CoolerMaster provides the RGB solution. See:
> https://www.amd.com/en/support/graphics/amd-radeon-rx-7000-series/amd-rad=
eon-rx-7900-series/amd-radeon-rx-7900xtx
>=20
> Alex
>=20
> > Alex
> >=20
> > > On Tuesday, January 9th, 2024 at 4:53 PM, Deucher, Alexander
> > > Alexander.Deucher@amd.com wrote:
> > >=20
> > > > [AMD Official Use Only - General]
> > > >=20
> > > > > -----Original Message-----
> > > > > From: Alexander Koskovich AKoskovich@protonmail.com
> > > > > Sent: Tuesday, January 9, 2024 3:27 PM
> > > > > To: Deucher, Alexander Alexander.Deucher@amd.com
> > > > > Cc: amd-gfx@lists.freedesktop.org
> > > > > Subject: RE: Documentation for RGB strip on RX 7900 XTX
> > > > > (Reference)
> > > > >=20
> > > > > Doe AMD have documentation on the i2c data that gets sent
> > > > > currently though? I was hoping to figure out what you need to
> > > > > change in the command that gets sent to change stuff like
> > > > > brightness, color (red, green, blue), rainbow, morse code, etc.
> > > >=20
> > > > It depends on the LED controller used by the AIB/OEM. The
> > > > programming
> > > > sequence is dependent on the LED controller.
> > > >=20
> > > > Alex
> > > >=20
> > > > > On Tuesday, January 9th, 2024 at 10:10 AM, Deucher, Alexander
> > > > > Alexander.Deucher@amd.com wrote:
> > > > >=20
> > > > > > [Public]
> > > > > >=20
> > > > > > > -----Original Message-----
> > > > > > > From: Alexander Koskovich AKoskovich@protonmail.com
> > > > > > > Sent: Monday, January 8, 2024 7:22 PM
> > > > > > > To: Deucher, Alexander Alexander.Deucher@amd.com
> > > > > > > Cc: amd-gfx@lists.freedesktop.org
> > > > > > > Subject: RE: Documentation for RGB strip on RX 7900 XTX
> > > > > > > (Reference)
> > > > > > >=20
> > > > > > > Currently the reference cooler from AMD does not have an
> > > > > > > existing RGB controller for OpenRGB, that's why I was looking
> > > > > > > for documentation on the I2C commands to send to the second
> > > > > > > SMU, so I don't risk bricking my card by sending wrong
> > > > > > > commands during development somehow.
> > > > > > >=20
> > > > > > > writeSetCMDWithData:
> > >=20
> > > **************************************************************
> > >=20
> > > > > > > adli2c.iSize =3D sizeof(ADLI2C)
> > > > > > > adli2c.iAction =3D ADL_DL_I2C_ACTIONWRITE adli2c.iAddress =3D=
 0xb4
> > > > > > > adli2c.iSpeed =3D 100
> > > > > > > 0 --------------------------------------------------
> > > > > > > Dev 0: ADL_Display_WriteAndReadSMUI2C(0, &adli2c) =3D 0
> > > > > > > adli2c.iDataSize =3D
> > > > > > > 24 i2cData[0]~[24]
> > > > > > > 40 51 2c 01 00 00 ff 00 ff ff ff cc 00 cc 00 00 00 ff ff ff f=
f
> > > > > > > ff ff ff
> > > > > > >=20
> > > > > > > From the RGB app's logs this is an example of what the
> > > > > > > official AMD application on Windows is sending when it change=
s
> > > > > > > colors on the
> > > > > > > RGB strip.
> > > > > > >=20
> > > > > > > From this can it be assumed the AMD card is using the latter
> > > > > > > method you mentioned with the second SMU I2C bus, in which
> > > > > > > case no driver changes would be needed?
> > > > > >=20
> > > > > > IIRC, each AIB/OEM uses its own preferred RGB controller. The
> > > > > > reference board just defines which i2c buses can be used. The
> > > > > > RGB control application is just a userspace app provided by the
> > > > > > AIB/OEM that calls ADL to talk to whichever i2c bus the vendor
> > > > > > put their RGB controller on. On Linux you can do something
> > > > > > similar using the i2c_dev module to open a connection to the i2=
c
> > > > > > bus driver
> > > > > > provided by the kernel. I believe that is what openRGB does tod=
ay.
> > > > > > It looks like you already have the programming sequence above.
> > > > > >=20
> > > > > > Alex
> > > > > >=20
> > > > > > > On Monday, January 8th, 2024 at 5:32 PM, Deucher, Alexander
> > > > > > > Alexander.Deucher@amd.com wrote:
> > > > > > >=20
> > > > > > > > [Public]
> > > > > > > >=20
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: amd-gfx amd-gfx-bounces@lists.freedesktop.org On
> > > > > > > > > Behalf Of Alexander Koskovich
> > > > > > > > > Sent: Sunday, January 7, 2024 11:19 PM
> > > > > > > > > To: amd-gfx@lists.freedesktop.org
> > > > > > > > > Subject: Documentation for RGB strip on RX 7900 XTX
> > > > > > > > > (Reference)
> > > > > > > > >=20
> > > > > > > > > Hello,
> > > > > > > > >=20
> > > > > > > > > I was wondering if AMD would be able provide any
> > > > > > > > > documentation for the RGB strip on the reference cooler
> > > > > > > > > (https://www.amd.com/en/products/graphics/amd-radeon-rx-
> > > > > > > > > 7900xtx)?
> > > > > > > > > It
> > > > > > > > > looks to be handled via I2C commands to the SMU, but
> > > > > > > > > having proper documentation would be extremely helpful.
> > > > > > > >=20
> > > > > > > > It depends on the AIB/OEM and how they designed the specifi=
c
> > > > > > > > board. The RGB controller will either be attached to the
> > > > > > > > DDCVGA i2c bus on the display hardware or the second SMU i2=
c
> > > > > > > > bus. The former will require changes to the amdgpu display
> > > > > > > > code to register display i2c buses that are not used by the
> > > > > > > > display connectors on the board so they can be used by 3rd
> > > > > > > > party
> > > > > > > > applications.
> > > > > > > > Currently we only register i2c buses used for display conne=
ctors.
> > > > > > > > The latter buses are already registered with the i2c
> > > > > > > > subsystem since they are used for other things like EEPROMs
> > > > > > > > on server and workstation cards and should be available via
> > > > > > > > standard Linux i2c APIs. I'm not sure what i2c LED
> > > > > > > > controllers each AIB vendor uses off hand.
> > > > > > > > https://openrgb.org/index.html would probably be a good res=
ource
> > > > > > > > for that information.
> > > > > > > >=20
> > > > > > > > Alex
