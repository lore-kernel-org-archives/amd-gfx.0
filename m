Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D30C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 13:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE6D10E5BA;
	Tue, 23 Jul 2024 13:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hMLTUs+6";
	dkim-atps=neutral
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC20B10E0FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1721660632;
 bh=94V2FOBhQb+tZMxWV3mDiMf6SrdiLsoT8QBihrvghmc=;
 h=Subject:From:To:Date:From;
 b=hMLTUs+6zNBdAX3EzTb7Aax50txR+SwpL1BJvX6ryBoNRbYHTwmlLZV22hcnpQeEj
 6KdgSQ6vmqGPz/1BseDPQoY/9zZ1bulegOf9W3oJaaxpuB/wX0UCW9nAeTuL/3JOEP
 o7ByB016SP3w89dSMw+2GSCWAgUiIfdJ+AAqTsMZr/VcK6tZkCKbrP8QYIKsfdS/6H
 2tRhoyzYAtRVnG9Tmb4rS0xNMDaZ/liV4TPUcQHzdFMlNNeSFdUtRKEgLzWl4kDAAw
 9/n3Mf4LcHBsXuE0qmEjE0LD3rJeUsR3mAJZ3vhvyyIFiD6O5aWZ7UlcbG9nwsBIu7
 as7t6cAXWo75g==
Received: from [100.127.186.53] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: mfilion)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3999A378001E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 15:03:52 +0000 (UTC)
Message-ID: <ee97d3761853c735c02bcb1d285916b715ef086e.camel@collabora.com>
Subject: Reminder - The Call for Proposals is open for XDC 2024!
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Mon, 22 Jul 2024 11:03:50 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 23 Jul 2024 13:02:18 +0000
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

Reminder -=C2=A0The CfP is now open for talks, workshops=C2=A0and demos at =
XDC
2024. The deadline for submissions is Monday, 12 August 2024.

https://indico.freedesktop.org/event/6/abstracts/

While any serious proposal will be gratefully=C2=A0considered, topics of
interest to X.Org and freedesktop.org developers are encouraged. The
program focus is on new development, ongoing challenges and anything
else that will spark discussions among attendees in the hallway track.

We are open to talks across all layers of the graphics stack, from the
kernel to desktop environments / graphical applications and about how
to make things better for the developers who build them. Head to the
CfP page to learn more!
=C2=A0=C2=A0=C2=A0
As usual, the conference is free of charge and open to the general
public. If you plan on attending, please make sure to register as early
as possible!

And don't forget, you can follow us on Mastodon for all the latest
updates and to stay connected:

=C2=A0=C2=A0=C2=A0=C2=A0https://floss.social/@XOrgDevConf

Best,

Mark
