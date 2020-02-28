Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ED1C3F2D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 08:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF202467B
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 08:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="2HG/oIGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF202467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2444F6EE2E;
	Fri, 28 Feb 2020 08:00:19 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBDF6EE50
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 08:00:15 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id f19so2181276wmh.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 00:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UuBs2+Hd3ZijsIUd+4BFI9Nm7vJa4nyEbzAyJbBYI6g=;
 b=2HG/oIGlOwAr2Mm+dznW7fE6KJkApAZXTtYKqmeibq0CfLyJ3zGpxBwxlh5Qms0yK6
 xAMkorM5TllA6zg7P5MJrBqeHQ4o9xu4oUQKixgs+hBcTOII/1oI8qQgRp6Acfr8FAuY
 uSMbrspJ/WGYwvYae6ZcQQOGtgmvUu3ZLf53M7CY1Z+Y6p0LHwoqU0dG9nFRYPtnO6tS
 LgewjWjGl24xwXu5X9RZJbklmawIJbrbWQ0bCMx2WNPvmTmMRInw6GhZaJZdRPwZpUiz
 wHsltb2fG42V0fFCjPOkt+cO+VOm/Vy9MPLTcYleb5qrLHkRLvx9FzM2qYmDlfGcaJeZ
 qBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UuBs2+Hd3ZijsIUd+4BFI9Nm7vJa4nyEbzAyJbBYI6g=;
 b=F+UM7qHKcEyuYCgmrDEK0CqkXtvvDmUSj7CHDqq/rMmpe/tSpdUG4ZkuwlqdTA+X7t
 Zdkrk3bQi3z+vmGb1oeBE9nvC1IlVzmpYeCPtzH6F4xvGRC5bL9fED0roMX4g1gpL6aO
 I4Nm9ONaVBEbo51TSLgjsXf6cN2KE4Wz7oxQWFpO3HGDlIEygF2cKGAGSiPn74Gy9bp6
 7uybAhBMYBljMkCHSquVojKIUr6Cjhpky/IS9mx5xODVBc8e5vH+mBOJ71NG057he7Eb
 Sx4OgNxn2lP97ZPZbunh/p6ciSSQRp9oq4JYsRrv/X/wrHP/TTzv5NWTlzJZwszotbaz
 Cj7Q==
X-Gm-Message-State: APjAAAV+eNIN+C5lqyy6/YfKFL0txCW3FX8mvwaAlJM5sl01oECeQmlK
 hvwTAT/4xjLVpg82oFJBOMCIZnePheYqGLjVEcxBkg==
X-Google-Smtp-Source: APXvYqxg+wHrxOqZlt348pf0cVqzRt3fiT4J5hZpwrt6+4iK40Av6zWOyMBPZrOaPIy+xhyASlWJYzcKeu8Qj5qDb0g=
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr3541794wmh.84.1582876814250; 
 Fri, 28 Feb 2020 00:00:14 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAEdQ38Hr-L6rg80Gf18QNM7eK-QDK0BBU-9tChT6VxrP+T4qCw@mail.gmail.com>
In-Reply-To: <CAEdQ38Hr-L6rg80Gf18QNM7eK-QDK0BBU-9tChT6VxrP+T4qCw@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 28 Feb 2020 07:59:33 +0000
Message-ID: <CAPj87rOhwLPGHaHvPrZ6j8zufO8VqiwNFoBGFjx95yHr3cBm3Q@mail.gmail.com>
Subject: Re: gitlab.fd.o financial situation and impact on services
To: Matt Turner <mattst88@gmail.com>
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>,
 gstreamer-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Matt,

On Thu, 27 Feb 2020 at 23:45, Matt Turner <mattst88@gmail.com> wrote:
> We're paying 75K USD for the bandwidth to transfer data from the
> GitLab cloud instance. i.e., for viewing the https site, for
> cloning/updating git repos, and for downloading CI artifacts/images to
> the testing machines (AFAIU).

I believe that in January, we had $2082 of network cost (almost
entirely egress; ingress is basically free) and $1750 of cloud-storage
cost (almost all of which was download). That's based on 16TB of
cloud-storage (CI artifacts, container images, file uploads, Git LFS)
egress and 17.9TB of other egress (the web service itself, repo
activity). Projecting that out gives us roughly $45k of network
activity alone, so it looks like this figure is based on a projected
increase of ~50%.

The actual compute capacity is closer to $1150/month.

> I was not aware that we were being charged for anything wrt GitLab
> hosting yet (and neither was anyone on my team at Intel that I've
> asked). This... kind of needs to be communicated.
>
> A consistent concern put forth when we were discussing switching to
> GitLab and building CI was... how do we pay for it. It felt like that
> concern was always handwaved away. I heard many times that if we
> needed more runners that we could just ask Google to spin up a few
> more. If we needed testing machines they'd be donated. No one
> mentioned that all the while we were paying for bandwidth... Perhaps
> people building the CI would make different decisions about its
> structure if they knew it was going to wipe out the bank account.

The original answer is that GitLab themselves offered to sponsor
enough credit on Google Cloud to get us started. They used GCP
themselves so they could assist us (me) in getting bootstrapped, which
was invaluable. After that, Google's open-source program office
offered to sponsor us for $30k/year, which was I believe last April.
Since then the service usage has increased roughly by a factor of 10,
so our 12-month sponsorship is no longer enough to cover 12 months.

> What percentage of the bandwidth is consumed by transferring CI
> images, etc? Wouldn't 75K USD would be enough to buy all the testing
> machines we need and host them within Google or wherever so we don't
> need to pay for huge amounts of bandwidth?

Unless the Google Cloud Platform starts offering DragonBoards, it
wouldn't reduce our bandwidth usage as the corporate network is
treated separately for egress.

Cheers,
Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
