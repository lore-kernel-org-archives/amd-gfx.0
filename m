Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD53C2BD09
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 07:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392B710EC28;
	Fri, 12 Jul 2024 07:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Zrc8B2/z";
	dkim-atps=neutral
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B62510EAA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 14:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1720709853;
 bh=Y+wAWAFTXevIAj9CS2cKzDzafDJ2NYFrO0uWvlIyreg=;
 h=Subject:From:To:Date:From;
 b=Zrc8B2/zALAaOMD7Oo56ZSZWu/QJYOfgLUKK4DnuIGa5xeY0KgeRsZWBFijzKxpr1
 jaaVQSBKHplMS2fSfhRm7SFizQOqnyl7WV0NyjUoROPU31WljzWmDNS5rU2iCYpryc
 zffEYHV3GgCVEFGZKaMqlwiTKy0vaZxqIQvYzGMDYc7uTpwsNUINkV4R4el8sUon7T
 8q/Cngw7h7PWKgYWzPD3jsk6ragEGx5MbbmlVKGMj3hCA2kE0P9rFUvVKWGC48OEDb
 kmDZA7Qpq3n+KHbrjXyERT2bIOobz6/89B018htjnIk289XZ0yziz5RZokVElzdaNX
 k2LMH4YYQJXtg==
Received: from [100.127.186.53] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: mfilion)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 07B64378065F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 14:57:32 +0000 (UTC)
Message-ID: <9e8981a98a022e9ab4c6dd2408488c0c26058167.camel@collabora.com>
Subject: XDC 2024: Registration & Call for Proposals now open!
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Thu, 11 Jul 2024 10:57:17 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 12 Jul 2024 07:17:21 +0000
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

Registration & Call for Proposals are now open for XDC 2024, which will
take place at the Concordia University Conference Centre in Montr=C3=A9al,
Canada on October 9 to 11.=20

New this year: XDC 2024 will feature two full days dedicated to talks
followed by a day dedicated to workshops, meetings & hacking.
All workshops and meetings will take place on the last day.

    https://xdc2024.x.org
  =20
As usual, the conference is free of charge and open to the general
public. If you plan on attending, please make sure to register as early
as possible!
=20
In order to register as attendee, you will therefore need to register
via the XDC website.

    https://indico.freedesktop.org/event/6/registrations/

In addition to registration, the CfP is now open for talks, workshops
and demos at XDC 2024. While any serious proposal will be gratefully
considered, topics of interest to X.Org and freedesktop.org developers
are encouraged. The program focus is on new development, ongoing
challenges and anything else that will spark discussions among
attendees in the hallway track.

We are open to talks across all layers of the graphics stack, from the
kernel to desktop environments / graphical applications and about how
to make things better for the developers who build them. Head to the
CfP page to learn more:

    https://indico.freedesktop.org/event/6/abstracts/

The deadline for submissions Monday, 12 August 2024.

We are looking forward to seeing you in Montr=C3=A9al! If you have any
questions,
please send me an email (mfilion at collabora.com),
adding on CC the X.org board (board at foundation.x.org).

And don't forget, you can follow us on Mastodon for all the latest
updates and to stay connected:

    https://floss.social/@XOrgDevConf

Best,

Mark
