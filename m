Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D0DC00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 17:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E74691D7F;
	Tue, 26 Jul 2022 17:16:42 +0000 (UTC)
X-Greylist: delayed 6513 seconds by postgrey-1.36 at gabe;
 Tue, 26 Jul 2022 17:16:39 UTC
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFD712A21A
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 17:16:39 +0000 (UTC)
Date: Tue, 26 Jul 2022 17:16:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1658855796; x=1659114996;
 bh=hQbzFUm+dHNfHIyDdAOczccxQxH/3HHwZAYVER46YgU=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=LAJbFYbEDZXg3eMawTS4DUKsmmFZMunNW1EktqFFg/AT6jL2a5wEbohbsR42EcVFa
 Sw6YyURZalIRIBvX0IMDPGHk9DoUqDLbAZAwh4PfymCw+XQ3GuyKyUZB8BrGDfMR2O
 WZ52j6DcWFX6IxboO+1b2tmoIoE+x48BZfmDvkXxhYzTQe+44/B+HATNL9B6+D+/6E
 V4/3nsW38Y9fpLwEfCuipb5VhNX3BWkkKYQDnKPPqc5fQZxO5sEbRT463kISzNqrJI
 ljsBv5WwcOWcXM0U91rRibr+HUCDJKQaCirjTTkvhJSwNR36G4ygljsg0LbQImSuRr
 F6r2zm5PjIsog==
To: Dan Carpenter <dan.carpenter@oracle.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [bug report] drm/amd/display: use FB pitch to fill
 dc_cursor_attributes
Message-ID: <cbypZeWipHExtaeCmHWExFVvXUW4Vb4jOgRzJ4ZTnDxddTFbsFqj66QeTCHCWW1ektFQqdVcdmlK6jxa_1hpm9_z36k-J8dFz_q7e1MbIas=@emersion.fr>
In-Reply-To: <20220726154748.GQ2338@kadam>
References: <YuAGLYvbtrrgBH0U@kili>
 <1JPWbfs9ltu7lsg8hK1KCCiKY9S6tjFGGGF13vR28hS9_FtOSHoSoS9rmHM4suOoa9fs8H8zcQiz0uFiuCpx8uOfV0CoRKBVwbKp8rKeozs=@emersion.fr>
 <20220726154748.GQ2338@kadam>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, July 26th, 2022 at 17:47, Dan Carpenter <dan.carpenter@oracle.c=
om> wrote:

> On Tue, Jul 26, 2022 at 03:27:54PM +0000, Simon Ser wrote:
>
> > plane->state->fb is NULL iff afb is NULL. There is an early return to
> > make sure the dereferences don't cause a segfault.
>
>
> Are you talking about this:
>
> if (!plane->state->fb && !old_plane_state->fb)
>
> return;
>
> Should the && be ||?

Ah, sorry, the reason why this doesn't segfault is different:
get_cursor_position() will leave position.enable =3D false if there is no
FB, and we have an early return for that. This also guards crtc_state.
