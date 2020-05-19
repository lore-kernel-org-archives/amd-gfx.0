Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B1BC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 18:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8DD206C3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 18:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxN7zMqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8DD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE7AE6E06E;
	Tue, 19 May 2020 18:59:40 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743DA6E06E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 18:59:39 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id b3so654581oib.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=sssLFQ/L9ksaQy4U+NlXM4xPeHiVi1oWupMyk4slAA0=;
 b=mxN7zMqM//ZE12+8RaIypunZ7XCSgpfvbA9eE/zlLgReHL6oXzoKbBZFxz1Ha/1N+x
 YST8BuMiG7iVqcGpgOo7Mhy6UXgaCRDZY4FzQqubQoHcrJgIqJOFm11riAEY+iJcunUr
 NixZGURMdtVRsu+gIeG23TzwyAZnbY9KumURWmcv1QRHs7PN7c5/huGwnFMB2EiS6Za2
 dnx7Yhx05dNfzi1TbjNyHhmX1GUZqCF2hWD1vhQd+npmBDlc7cm+UdruaKGT4+Y0M8/b
 rBjxIxWBIVLDH+/oJ29q8M5kUpdFac1J5O2E2EdRKgIwW04OAIZZ6vYDMFVkZ+iXNSY8
 kQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=sssLFQ/L9ksaQy4U+NlXM4xPeHiVi1oWupMyk4slAA0=;
 b=MtpfeArifiKgc5KjOpU27UZyPbDxCQXNt2Ky81zP37d0KOOheyP9VE7vMwb28h9gT6
 r8HpgRogDR9CpeYTcLvIin6ik/aJOQtk2hXDf93VijF25XY8kpXFE3f0+rne4aWD7aLI
 PvhNKThdJs+H/i/pmAM7dG1MkcPxxftv7C21WmeZmD+0Ly2GUQx6JgRhWppmbwse5Mr8
 k7dZFQK6SlrgIjZHKLkn2YtclY9XeMWz3/fJuPPA35SWsZ8Yvc+REcGSLvg0S5lpSkXr
 LyRax8yv4JkYmsHQZp/WGSsz1YJRYFhi0T68eRzcCTgMWUWOWl5MhS/mWiDmALbf9Lm+
 HjoA==
X-Gm-Message-State: AOAM533W0HT5bhPQe31LoMqdVcURTvGUHNElX5V4TBsnHGcPuSLAtJus
 EGtLtQ5bJOk5tYNRM6X5k8fF8L9pHXJa/aYfjPIvOg1+9yI=
X-Google-Smtp-Source: ABdhPJw+UNPAKM/sCZseXlJf5nK81VVqkKNk9J/Y0sxjlsVgwT0EcBx8g/o8ifGNS0Wt0nGdqO/fHXI+PZwshLXYuCk=
X-Received: by 2002:a54:418f:: with SMTP id 15mr632291oiy.109.1589914778266;
 Tue, 19 May 2020 11:59:38 -0700 (PDT)
MIME-Version: 1.0
From: Javad Karabi <karabijavad@gmail.com>
Date: Tue, 19 May 2020 13:59:27 -0500
Message-ID: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
Subject: slow rx 5600 xt fps
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

given this setup:
laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2 -hdmi-> monitor
DRI_PRIME=1 glxgears gears gives me ~300fps

given this setup:
laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2
laptop -hdmi-> monitor

glx gears gives me ~1800fps

this doesnt make sense to me because i thought that having the monitor
plugged directly into the card should give best performance.

theres another really weird issue...

given setup 1, where the monitor is plugged in to the card:
when i close the laptop lid, my monitor is "active" and whatnot, and i
can "use it" in a sense

however, heres the weirdness:
the mouse cursor will move along the monitor perfectly smooth and
fine, but all the other updates to the screen are delayed by about 2
or 3 seconds.
that is to say, its as if the laptop is doing everything (e.g. if i
open a terminal, the terminal will open, but it will take 2 seconds
for me to see it)

its almost as if all the frames and everything are being drawn, and
the laptop is running fine and everything, but i simply just dont get
to see it on the monitor, except for one time every 2 seconds.

its hard to articulate, because its so bizarre. its not like, a "low
fps" per se, because the cursor is totally smooth. but its that
_everything else_ is only updated once every couple seconds.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
