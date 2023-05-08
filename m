Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77423C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 13:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829C110E2D2;
	Mon,  8 May 2023 13:14:35 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F8710E1CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 09:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1683539246; i=shadow_7@gmx.net;
 bh=fY0cjz0aqo/NXg1sY+cyoc+w2RT+Hoj2mfkMtp2GIwo=;
 h=X-UI-Sender-Class:From:To:Subject:Date;
 b=I7ZPVF0YWr0VmvToCO4FI2rHQLHz6y8GkHojhrTZKL3+bHxWTJ2v8n0CfIYh8h9BC
 iYdnR6wzeJxW9hkE3Jk/SEdMrD30U9DKNvg4ERybfSm/ybX03BIy7BgeoKlkDSnxkR
 yG0VKD5WpFfYzfKnIsBeVXgMGvHtoByAfLduOuqQz7lPYTUr/1eaJpFj6FcqwbJaLP
 P1haVIOOjt85HYDsjqQo5UX87HXDzIpan9czwOKUUqau1z6R58/n1VyXFOnSz/mWOl
 /YBi21DK0ecTaHIPsacMEkhXUMHF8AfOaCBtbITn7x/eer2JPd/mYwfuTsaZmGLUkY
 HPyrOpfXL+bJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [194.94.225.5] ([194.94.225.5]) by web-mail.gmx.net
 (3c-app-gmx-bap45.server.lan [172.19.172.115]) (via HTTP); Mon, 8 May 2023
 11:47:26 +0200
MIME-Version: 1.0
Message-ID: <trinity-beb88f27-1916-4221-9418-e979c4c70f34-1683539246483@3c-app-gmx-bap45>
From: Stefan K <Shadow_7@gmx.net>
To: amd-gfx@lists.freedesktop.org
Subject: Problem: Lenovo T14 Gen2 with external monitor - no luks prompt
Content-Type: text/plain; charset=UTF-8
Date: Mon, 8 May 2023 11:47:26 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:iQqWMhuQ7sK8lsWkbUElMxi88Pozdcc9xK0CFP6Co99XrIDaTqxLNpAwJv4WzfVnRQXbS
 E4x2S4aoRmCy8F0HuKo3bpoB4GaspwxsPEUrLu8igaJgMtx0q8U4dVJGybyLUC7OVwPRj6SSFR4b
 en3/3Jjopr6eNYpfI4ytebPjaZrvBJR0cgzb53+CoZikiMAuJNULybVi02sfW43gCGCXy7GR8YWZ
 bIplnpmUhv6bXDWCw6ikUNPrFbNBO+kD9bMKNl67JZc6uK2Qldsa4SEdh9tixRcJFNj7zHkQMu+O
 Q0=
UI-OutboundReport: notjunk:1;M01:P0:RKU10PjbCvo=;Ql6J8PN7iD+7998QOeJECrsFWd6
 eJsqjfXLr2V8magy55ClKH2rNG8aqOk34qvPb9UNyBeJUieoqqBU0YF6d5oWldLwdHl5x0aee
 Jhz9FIclHYY1tkXoQFvQSjLhMKD9VvrHXu/FdpqC/ueJuEBrF/3wol3VdT7sT9lZZGnqq2zHo
 7McCLRg3AKmqJataEXrWEiuZhsPCZgYcPOrAxzAvcgcpwZt7SxPuImAB6ZeMBc0qLSsjQdSlv
 9gp4+PA0YkevgfvKnGZs0HcVUQjzYb71YeLWIixuQ1Nd8R6UkxhvRGe0T0dcyCU6z1JEh0kKz
 L+BDaotmdIxztqvg6hBEP9Uw7y7V/EI8SJNyMQy0SYN/q79fRoqA24QOdBDEema7nuCofsSFL
 LF613ko+KRhnmUkXkRMVa2r0zuz4CUc3DCD8baLCQslLO0Qo86YmCHA3G9SuhrojxEb7lIq2A
 ziL0lLpNP+/zJWgx/vTVsdvHb0yyEEOYKX4VsBaeC7UkFjZpYhmA15FVPSoX5ckuST4LbNILQ
 lpEPvhdA/K6G0cWMUJSr7igv8Z8cqkMGydtS9yfnAeIN9aSvFiM01UG6JUbAbByhl9F277Zv0
 g2YyLGpCIS2jZLEBoA+LfzHK74hZAEhduhw3oWGkgMtE7gbPDeDIDjtZ/Fh+ZiDDvoCXUW9EZ
 oe4GDYXHLlkvih0VzAeh9/LQNqLIxmTg53Syu4/svAxFfDgJBukj72F74hD04n7w6502+wGAV
 cutGEnkPMdHoOzjHm0VcsDh5GW6vgd6DyNp4bMkupqc1Dsfru3koDcirvngX55CgTf+7IfltE
 pqDSo70hJQPNtzTY8IqPO0H7HYtOFVm5067pqJfc7mRaU=
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 08 May 2023 13:14:32 +0000
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

Hello,

I hope this is the right place to get help.
I using Debian Bookworm/12 and with Kernel 6.1 I'd some issues with extern=
al displays: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1033637

With Kernel 6.3 it's much better and it works, more or less. But when I bo=
ot and I need to type my password to encrypt my disk the external displays=
 are in sleep mode, I can type it blind and after 'ENTER' I got my KDE-log=
in screen, since it is in a very early boot-state I don't know how to get =
useful logs or something like that.

How can I help you to help me to fix this (bug)? Most information you can =
get from the Debian-Bug above.

Thanks in advanced!

best regards
Stefan
