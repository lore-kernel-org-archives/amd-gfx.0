Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BD1C4725D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 08:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55DF910E55F;
	Wed, 10 Jan 2024 08:01:58 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EDAB10E578
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 02:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1704853256; x=1705112456;
 bh=PTL1Y/lIheUkjK5/p5eVpwLSqEm07l+Syq+vsgP4zUg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Wi8XRRgl/Xv6v50ePIw4NH7J+XLytQVE+FB5HN8bYlOSJ0+OyjYPL0rwxbAOSAMca
 MysYMVy209zPfq9zm/jyJERhjdOYKBBqxO1PxSXDGqhMKtMSk7zWsQRZOnw7VBfzYQ
 QmOdkYumzQXEN0H7tBmL4mrC/DPKd3J2QDYC1okT+6gavgl3M1C1yhFVcsH8HaPCL+
 KBXkETwNnpmUUflRNiw+W4zUHVU64GBhiHutMJ4DXNCzvm5XLAjbGJBavoSJMprSq4
 x6zwzH3eYqWfveUx4kwqdst2gmby1pffmD/o98cMWTRC8UnbI11HVGXKFKZOA2w4P8
 hc0mU0pZPjN4A==
Date: Wed, 10 Jan 2024 02:20:40 +0000
To: =?utf-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
From: Alexander Koskovich <AKoskovich@protonmail.com>
Subject: Re: Documentation for RGB strip on RX 7900 XTX (Reference)
Message-ID: <V1DvhMMvcMsI7dtFmlkI47ANQn6mZIrZbA1ONvsXABCU-9Xfss9ULOs_9Ult1ydgnppu2fNEMqDlU00jrSEXdI8kh2ioGRqVTsy7IUstgeM=@protonmail.com>
In-Reply-To: <1b679a75-27ee-4682-8bf1-c0defcd9e949@gmail.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <1b679a75-27ee-4682-8bf1-c0defcd9e949@gmail.com>
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

Are there any userspace utilities for checking out the ATOMBIOS tables? Hav=
e never done so and all the utilities I've found online are too old for thi=
s card (at least it refuses to open the VBIOS for this card).


On Tuesday, January 9th, 2024 at 3:02 AM, Christian K=C3=B6nig <ckoenig.lei=
chtzumerken@gmail.com> wrote:


>=20
>=20
> Am 08.01.24 um 23:32 schrieb Deucher, Alexander:
>=20
> > [Public]
> >=20
> > > -----Original Message-----
> > > From: amd-gfx amd-gfx-bounces@lists.freedesktop.org On Behalf Of
> > > Alexander Koskovich
> > > Sent: Sunday, January 7, 2024 11:19 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Subject: Documentation for RGB strip on RX 7900 XTX (Reference)
> > >=20
> > > Hello,
> > >=20
> > > I was wondering if AMD would be able provide any documentation for th=
e
> > > RGB strip on the reference cooler
> > > (https://www.amd.com/en/products/graphics/amd-radeon-rx-7900xtx)? It
> > > looks to be handled via I2C commands to the SMU, but having proper
> > > documentation would be extremely helpful.
> > > It depends on the AIB/OEM and how they designed the specific board. T=
he RGB controller will either be attached to the DDCVGA i2c bus on the disp=
lay hardware or the second SMU i2c bus. The former will require changes to =
the amdgpu display code to register display i2c buses that are not used by =
the display connectors on the board so they can be used by 3rd party applic=
ations. Currently we only register i2c buses used for display connectors. T=
he latter buses are already registered with the i2c subsystem since they ar=
e used for other things like EEPROMs on server and workstation cards and sh=
ould be available via standard Linux i2c APIs. I'm not sure what i2c LED co=
ntrollers each AIB vendor uses off hand. https://openrgb.org/index.html wou=
ld probably be a good resource for that information.
>=20
>=20
>=20
> It might also be a good idea to look some of the ATOMBIOS tables found
> on your device.
>=20
> Those tables are filled in by the AIB/OEM with the information which
> connectors (HDMI, DVI, DP etc...) are on the board and I bet that the
> information which RGB controller is used and where to find it is
> somewhere in there as well.
>=20
> Adding Harry from our display team, might be that he has some more hints
> as well.
>=20
> Christian.
>=20
> > Alex
