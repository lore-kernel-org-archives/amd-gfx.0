Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344C9CD98EE
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 07:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE90B10EE4A;
	Wed, 17 Jun 2026 07:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=post.cz header.i=@post.cz header.b="To3mGY8g";
	dkim-atps=neutral
X-Greylist: delayed 1119 seconds by postgrey-1.36 at gabe;
 Tue, 16 Jun 2026 22:20:33 UTC
Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.78.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2ECE10E0B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 22:20:33 +0000 (UTC)
Received: from email.seznam.cz by smtpc-mxe-844b97bc4b-29p4c
 (smtpc-mxe-844b97bc4b-29p4c [2a02:598:64:8a00::1000:a8b])
 id 183de2480821a33b1895101e; Wed, 17 Jun 2026 00:20:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=post.cz; s=szn1;
 t=1781648432; bh=NW7VllBvdlma7tFCVfLBkPR1+y0RgKDAZXIoK35DFQA=;
 h=From:To:Subject:Date:Message-Id:Mime-Version:Content-Type;
 b=To3mGY8gQr12Ru8fhgkSRBFwkNsfBt4tApuDl3MEvMBG2XXQxB29h+t2XRk7MlzlZ
 f+aoqxn6ZdXiNo6p//fMjpHWBJ4wJAdNjSG0oL6Af2u4luwdK2cWZ+ucKS6tpbiBpF
 ffTTyJd57zv7bfrNpwurWTbSEggiPgq8dc+WRLenNau1ddOHj/VJbcgAyyDLyNxoRv
 snwrxIXq931CpRy04BpX/4Cgxj0ykMAmZYATTEkc1iM8P0VaB9K3hnX9zTXqQvh634
 qBhKLZ6gdtg8kOQ3EQ0qAqfhlaAvyqbTEMRgyYpZeLx9wm6w8Pxyh91duvR2damEVP
 jMN9Zr50iFpfA==
Received: from unknown ([2a0b:9280:a52:0:9e7c:2ab9:aa5:90e6])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Wed, 17 Jun 2026 00:01:32 +0200 (CEST)
From: =?utf-8?q?Zden=C4=9Bk_Kop=C5=99iv=C3=ADk?= <zdenek.koprivik@post.cz>
To: <amd-gfx@lists.freedesktop.org>
Subject: =?utf-8?q?=5BBUG=5D_Zero-fill_formatting_error_for_GPU_power_metr?=
 =?utf-8?q?ics_in_amdgpu=5Fpm=5Finfo?=
Date: Wed, 17 Jun 2026 00:01:32 +0200 (CEST)
Message-Id: <3o8.g4Jl.34rkhuHwbax.1gCSUy@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.2.5)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: multipart/alternative;
 boundary="=_5bf85124248b4b4226b4c4c4=8cb4469b-1aea-57de-805f-dacd03b8f9c3_="
X-Mailman-Approved-At: Wed, 17 Jun 2026 07:14:49 +0000
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


--=_5bf85124248b4b4226b4c4c4=8cb4469b-1aea-57de-805f-dacd03b8f9c3_=
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,
I noticed a minor string-formatting issue in the 'amdgpu_pm_info' debugfs =

output when reading power consumption of my Radeon 780M.

The output fails to zero-fill the fractional portion of the Wattage readou=
t 
to 3 decimal places. For example, when the hardware returns a value 
corresponding to 3.084 W (3084 mW), the driver seems to format it as "3.84=
 
W" instead of "3.084 W".

System Info:
- GPU: AMD Radeon 780M (gfx1103)

- Kernel Version: 7.0


Kind regards,

Zdenek

--=_5bf85124248b4b4226b4c4c4=8cb4469b-1aea-57de-805f-dacd03b8f9c3_=
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body>Hello,<br>I noticed a minor string-formatting issue in the 'am=
dgpu_pm_info' debugfs output when reading power consumption of my Radeon 7=
80M.<br><br>The output fails to zero-fill the fractional portion of the Wa=
ttage readout to 3 decimal places. For example, when the hardware returns =
a value corresponding to 3.084 W (3084 mW), the driver seems to format it =
as "3.84 W" instead of "3.084 W".<br><br>System Info:<br>- GPU: AMD Radeon=
 780M (gfx1103)<br><div>- Kernel Version: 7.0</div><br><div>Kind regards,<=
/div><div>Zdenek</div></body></html>
--=_5bf85124248b4b4226b4c4c4=8cb4469b-1aea-57de-805f-dacd03b8f9c3_=--

