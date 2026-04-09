Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC468E99052
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A1C10E8C3;
	Fri, 10 Apr 2026 07:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="a3wim/He";
	dkim-atps=neutral
X-Greylist: delayed 346 seconds by postgrey-1.36 at gabe;
 Thu, 09 Apr 2026 13:39:48 UTC
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A199D10E0D2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1775741987; x=1776346787; i=spasswolf@web.de;
 bh=LrVCsFpWUSr8cnxda89ZpTbNc2BFVJrcDv9d4LO1vgE=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=a3wim/Hem/kez/tZBmxI9iGm52huq/Z/qIb5qap8rk5F2ZWaNv53UGzvr0nzBCHZ
 y+qXNDQdlYtQseYwESCV4rVslalSFYn4MXkBb/C1J9LsH+8hpC8GMeBvNUBq7zVat
 MZdFZ+n/yI4Y/x0IaEDBnc64ROLckgpflCdPv0OacA3u7qG3pa0y/BZW+LGUNcNMX
 5RjbW59QtsMVYAYzBVr9u2YozPABhuBE+q7LThwGrj/yvc1i+OuyPp6K+gEZ4VUM9
 ET9g4QOMZBQXQVOighW9Ig2qElzMyaqtA6VamDvDk+0bJ3fjgmcZtO4U4Zjb5zY52
 mHMLdpBSGDyhiFC68w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1vZIqc2R0y-00ZeHa; Thu, 09
 Apr 2026 15:33:58 +0200
Message-ID: <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
Cc: "Varone, Dillon" <Dillon.Varone@amd.com>, spasswolf@web.de, "Hung, Alex"
 <Alex.Hung@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
 "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-next@vger.kernel.org"
 <linux-next@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
 <linux-rt-devel@lists.linux.dev>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Thu, 09 Apr 2026 15:33:57 +0200
In-Reply-To: <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260409131411.10598-1-spasswolf@web.de>
 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GX4I2Xq7iTVSXwmjy1AN7uzYHCc5OIuGIUDUmG3WLxG1OI0Qe/6
 Daw18jcza5avsyEo/ZKLQhzpNzkPY2Zm7CUVOoZ1Tn0K6hURVUZzIqZcgctTYIwoBtX79If
 2hz45U3NaaesFbeuIiSqOXg6xllwJMlJ2Jg7tDeQ4c9IOuFEvr8F/agETvtU5r9YzVNR8t0
 EwSC7ooYJeFg9vMC50Usw==
UI-OutboundReport: notjunk:1;M01:P0:rVLMFJy7GTE=;MYysgB1gvgqbgsjDyyalwjV8XZX
 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
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:07:32 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am Donnerstag, dem 09.04.2026 um 13:30 +0000 schrieb Ostrowski, Rafal:
>=20
>=20
>=20
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> Hi Bert,
>=20
>=20
> Sorry that you experience this issue.
>=20
>=20
> Do you have all these 3 patches?:
> "drm/amd/display: Move FPU Guards From DML To DC - Part 1"
> "drm/amd/display: Move FPU Guards From DML To DC - Part 2"
> "drm/amd/display: Move FPU Guards From DML To DC - Part 3"
>=20
>=20
> These are highly dependent on each other.
>=20
>=20
> Kind Regards,
> Rafal
>=20

The crashes also occur when all three patches are applied.

Bert Karwatzki
