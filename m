Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92787C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 14:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16BCF10E3FC;
	Tue,  9 Jan 2024 14:06:43 +0000 (UTC)
X-Greylist: delayed 101035 seconds by postgrey-1.36 at gabe;
 Tue, 09 Jan 2024 08:23:25 UTC
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com
 [51.77.79.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33B810E397
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1704788600; x=1705047800;
 bh=xqQd+5usJRoZedk70Q1REyWfc3Uep2PM8g0X5Tty358=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=PcgpazN2TRXRm0Sq17vfFN8gu1Ci9PI9BZM29XFFQsh6mA22qyX06JdrF8giOuyP3
 IUILRlGaGsmu9rk/mx4yOXbVQdObIpAEtJnWhxeU8mJC+i5VMxj6AZYRycDN70Qd5i
 3PKoB3uNgv9HNgubFj+MInIO5XsZZZnAdnekwKMf6S73dw87UJEgZF20CjEqOt9CSl
 kH3P3BaDS64xEhWXKbb8fswHl2UWPgySPMye/u5BFdmTkM9lwFPazGWn/aRR+7hLcn
 5mo3qIxjctle5j2XpoYQxhtzQLdTKhtscsHc35ENGJvtWbdKdzPn3FK76Q/DAen4a6
 f8D7SXRkn1agg==
Date: Tue, 09 Jan 2024 08:23:03 +0000
To: =?utf-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
From: Alexander Koskovich <AKoskovich@protonmail.com>
Subject: Re: Documentation for RGB strip on RX 7900 XTX (Reference)
Message-ID: <x5k4aAAKV_idHdVtHJSqsc8HjaGPyGe36A9cpXQl_tBbqgHrQ8TaVKm_zoQRodcwfFuGUj4GnnNASL5a7SKfL1H-NH5X4ma5G_vRkXSG35o=@protonmail.com>
In-Reply-To: <1b679a75-27ee-4682-8bf1-c0defcd9e949@gmail.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <1b679a75-27ee-4682-8bf1-c0defcd9e949@gmail.com>
Feedback-ID: 37836827:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 09 Jan 2024 14:06:41 +0000
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for the info, will take a look.

Also just to clarify, this is the first party AMD 7900 XTX, not a third par=
ty AIB (e.g. Sapphire, ASRock, etc).


On Tuesday, January 9th, 2024 at 3:02 AM, Christian K=C3=B6nig <ckoenig.lei=
chtzumerken@gmail.com> wrote:


>
>
> Am 08.01.24 um 23:32 schrieb Deucher, Alexander:
>
> > [Public]
> >
> > > -----Original Message-----
> > > From: amd-gfx amd-gfx-bounces@lists.freedesktop.org On Behalf Of
> > > Alexander Koskovich
> > > Sent: Sunday, January 7, 2024 11:19 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Subject: Documentation for RGB strip on RX 7900 XTX (Reference)
> > >
> > > Hello,
> > >
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
>
>
>
> It might also be a good idea to look some of the ATOMBIOS tables found
> on your device.
>
> Those tables are filled in by the AIB/OEM with the information which
> connectors (HDMI, DVI, DP etc...) are on the board and I bet that the
> information which RGB controller is used and where to find it is
> somewhere in there as well.
>
> Adding Harry from our display team, might be that he has some more hints
> as well.
>
> Christian.
>
> > Alex
