Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43730C25B4F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 09:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6212710E599;
	Thu,  9 May 2024 09:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OEUZZ8vF";
	dkim-atps=neutral
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49B71131AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 19:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715197141;
 bh=EMoh6ibnBlSUQl1yoaNN8vNpQ2RppWN97oATY4a6MVk=;
 h=Subject:From:To:Date:From;
 b=OEUZZ8vFJqc85ucokUaryvlgC1XdlYdIV3vFt8cixH55uYlOziOyXfTm50/YOXcUd
 QBK5vFfECZLx63BpMpXZbz/aF40r/lB92Vi++6Pmgbsgu7OttG0FMxim+Qcw0cmn5a
 dWRv9RlbTyL1bOFkGoKQ/HhhcY3wEyDtATIx9XOLW5gQ93QmAdRivN7OcB0dixQ0MK
 ZByIOfwXhkHHd/52/vXDZN2oucXeRkndz1aYUWDNtN9DYevdDOfxVrzvbQbMb478Ow
 liyV/7NW2PXOrPZGb49lBMze7hHdKo6b5WAuI6nBoLhCxp+dulLE5sPlAJxJsPqV0L
 N18sd3mbfX56g==
Received: from [100.127.186.53] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: mfilion)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 047153782065
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 19:39:00 +0000 (UTC)
Message-ID: <f5e77f6b68035f4c12d0784a2de83925fb674a49.camel@collabora.com>
Subject: 2024 X.Org Developers Conference - October 9-11,
 =?ISO-8859-1?Q?Montr=E9al=2C?= Canada
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Wed, 08 May 2024 15:38:56 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 09 May 2024 09:11:44 +0000
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

Hello!

We're delighted to announce that the 2024 X.Org Developers Conference
(XDC) will be taking place on October 9 to 11 in Montr=C3=A9al, Canada, co-
located with the GStreamer Conference & Hackfest 2024 which will be
running from October 7 to 10. Join us for a freedesktop week in
Montr=C3=A9al!

XDC is the event for developers working on all things Open graphics
(Linux kernel, Mesa, DRM, Wayland, X11, etc.).

New this year: XDC 2024 will feature two full days of talks followed by
a day dedicated to workshops, meetings & hacking.

XDC 2024 website: https://indico.freedesktop.org/event/6/

The in-person venue is the Concordia University Conference Centre,
located within the John Molson School of Business.

Concordia University Conference Centre
1450 Guy St., Montreal, Quebec, Canada, H3H 0A1
https://goo.gl/maps/9nDyTvKtf7X1JuJc9

As usual, XDC will be free of charge and open to the general public.

Registration & Call for Proposals will be opening soon, stay tuned!

Best regards,

Mark Filion, on behalf of X.org

