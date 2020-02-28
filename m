Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A15C3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 10:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6C224691
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 10:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="TuzPHmKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6C224691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 917926EF32;
	Fri, 28 Feb 2020 10:44:33 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37956EF32
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 10:44:31 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id m10so9055956wmc.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 02:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qzJJnF2P8v7o31Ml9N5Di+8zMyH/5FFUkGvyONKT3Nc=;
 b=TuzPHmKOeb4yf8+T7Vm+KWfWmVjwGqB3u+YF7p1Ewxglh20LdRWcFPJGWdRar4+rFg
 qKvHyUnqTTQ3nmqTCfCHQ6yvrYo/eifVKrVqr6OIpWEBSt5XO49GYFq5xfNXkEsDEUeA
 KMzL5tEApE7nPn0U2hss2M9WzLyBjMXEKhp1QrPS4v5sbRr51TZTCx515LQ5LoDZv1co
 OYvfTYZVQ/pK9Pqb/UawvcoadIC40Wqnt30qhqeFeqcXT1qAHzQ6pfRdZJe1rTiSZ4sf
 Z3ctRnlfcNzZw1h+8ZP5B3A2BYNsU43HImYXyGF8MJ5mm8SdS/amamVzVJ6ZVD/CV7Rf
 k8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qzJJnF2P8v7o31Ml9N5Di+8zMyH/5FFUkGvyONKT3Nc=;
 b=WBYaYduNiG/r4hoaoglqn+NhwUpVqtRYHzaRkEW20cVRLKVE0lEI4n8mxbbBJonV44
 BdDfleyg5cho6FJRxGX329z86fZA/pIVU0qKaToUofYDGG9wJ8C/+/Yj9eaJa8ULTj7j
 odcdrWMvgsO1K+jnoNtJiGjDWC1FBI6muNejJ/BJmLSaoyRhubnr3VH/Ptn/tu3t86q/
 7A27ipCy+Klk4PT5yCi9CfbNJEwLBCfGgNmetSIllU/4uS/k0fTu0jL4UCbjvcYHhZMn
 JIGN0HgPshuKjyHjP6MsxXC5Qb4NboyLIa0f6eJhL+CXFlCzd5g2VNjzUuMUr6tAgoiL
 l40A==
X-Gm-Message-State: APjAAAVGc6pkQFWi/v9vz5x9TYRaDtZqNHM1q0RjfrGJDUqNBAq8vIIt
 lbpviEuTCOSgCJuQuY6XUWGDlGHZlMZVajceStf8KA==
X-Google-Smtp-Source: APXvYqxjMlpQYAoaSV79eB5XA4OXS8HLHE+ajKuLAKlYwTaFiXhXgcbYIoZ/XZtJyerWrQcz15snt38n9vUy+lCVotc=
X-Received: by 2002:a05:600c:21c4:: with SMTP id
 x4mr4328201wmj.147.1582886670440; 
 Fri, 28 Feb 2020 02:44:30 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
 <ece8ebe3-40ec-2457-02da-4fef19cbe8f6@intel.com>
 <6d2ec570f957b4504fb70e0b1f0632712a99dc0c.camel@collabora.com>
In-Reply-To: <6d2ec570f957b4504fb70e0b1f0632712a99dc0c.camel@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 28 Feb 2020 10:43:49 +0000
Message-ID: <CAPj87rO7BuKQj2Kei3T7RdkFq5=TiuShBvtrPU2sn0iqMfXSTg@mail.gmail.com>
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and impact
 on services
To: Erik Faye-Lund <erik.faye-lund@collabora.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>,
 gstreamer-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 28 Feb 2020 at 10:06, Erik Faye-Lund
<erik.faye-lund@collabora.com> wrote:
> On Fri, 2020-02-28 at 11:40 +0200, Lionel Landwerlin wrote:
> > Yeah, changes on vulkan drivers or backend compilers should be
> > fairly
> > sandboxed.
> >
> > We also have tools that only work for intel stuff, that should never
> > trigger anything on other people's HW.
> >
> > Could something be worked out using the tags?
>
> I think so! We have the pre-defined environment variable
> CI_MERGE_REQUEST_LABELS, and we can do variable conditions:
>
> https://docs.gitlab.com/ee/ci/yaml/#onlyvariablesexceptvariables
>
> That sounds like a pretty neat middle-ground to me. I just hope that
> new pipelines are triggered if new labels are added, because not
> everyone is allowed to set labels, and sometimes people forget...

There's also this which is somewhat more robust:
https://gitlab.freedesktop.org/mesa/mesa/merge_requests/2569

Cheers,
Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
