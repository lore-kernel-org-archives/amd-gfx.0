Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A356C3F2C0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C91F246A0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PhG78KEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C91F246A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F1E6ED45;
	Thu, 27 Feb 2020 21:27:19 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56CC6ED45
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:27:16 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id a142so730889oii.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=53gRMBJrJ+la068BpgpeS9MvOB3v8Crv2gV5zCitRF4=;
 b=PhG78KEPgow20wemDEzeImA40/CuNsSFuDsT/XEp/QQGVqN6vIa5qNUqPIvnF2ottA
 uNl1BdrgGnLrYDDyNxhjwQPlzpKG0GynOaJ1dva71D7BjU4oUm/DimSOy1LST81ZGK6z
 NZNxQezRld7jYfF+RdkSDI+RuWI3WzXLHn95k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=53gRMBJrJ+la068BpgpeS9MvOB3v8Crv2gV5zCitRF4=;
 b=CfX/Ipmo0GNBPySHEllq/1FoUb4FPnzshOHb/YUaIiHkAR9AQRzonejXVgBIVOmJIa
 w/3RzAt8t17229zjGyVJfwrvpy39nYHNr82K7IxBXHdbzTCdcKp79VASqw262xak5pKc
 w0VqoOcga8a8hUJO/hx2Qd/AaiuW3yjhNj7A3Ze1z3PZreaWKu4+JVBK3HbbsuLOHedl
 YXqObOwr/fJjt4C9MdiPiE7iFQPbMLh2Gc2TXBSLLh+KFT+xjtsn/BDA9cTPRAWKgFEN
 zyEFm0PHPak1rQNz5JcWbuKYclj4ZInfNyprkDlK+yin56qi9JmcMcA0Uo4UMYrbIufu
 qnZQ==
X-Gm-Message-State: APjAAAUkRpWkoL+gbt28fOa5nOzbnNUfk4Vv5yWrynEgJSm6qSsfiDfO
 mDsf9yE3a39Z3Ftt0jFSE8v2IcMhWpnScOugzxa4ZQ==
X-Google-Smtp-Source: APXvYqxrmwIIYpIUdfUeFAdLWb1JhkAvU4sEORizQCbTX2XxKpPE9DO4bzkdQ0PSrofOs/Ssn3ptbNPWgsoHCxXJc/U=
X-Received: by 2002:aca:2407:: with SMTP id n7mr851548oic.14.1582838835977;
 Thu, 27 Feb 2020 13:27:15 -0800 (PST)
MIME-Version: 1.0
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 27 Feb 2020 22:27:04 +0100
Message-ID: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
Subject: gitlab.fd.o financial situation and impact on services
To: gstreamer-devel@lists.freedesktop.org, Xorg Members List <members@x.org>, 
 Mesa Dev <mesa-dev@lists.freedesktop.org>, 
 "X.Org development" <xorg-devel@lists.x.org>,
 wayland <wayland-devel@lists.freedesktop.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>
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
Cc: "X.Org Foundation Board" <board@foundation.x.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

You might have read the short take in the X.org board meeting minutes
already, here's the long version.

The good news: gitlab.fd.o has become very popular with our
communities, and is used extensively. This especially includes all the
CI integration. Modern development process and tooling, yay!

The bad news: The cost in growth has also been tremendous, and it's
breaking our bank account. With reasonable estimates for continued
growth we're expecting hosting expenses totalling 75k USD this year,
and 90k USD next year. With the current sponsors we've set up we can't
sustain that. We estimate that hosting expenses for gitlab.fd.o
without any of the CI features enabled would total 30k USD, which is
within X.org's ability to support through various sponsorships, mostly
through XDC.

Note that X.org does no longer sponsor any CI runners themselves,
we've stopped that. The huge additional expenses are all just in
storing and serving build artifacts and images to outside CI runners
sponsored by various companies. A related topic is that with the
growth in fd.o it's becoming infeasible to maintain it all on
volunteer admin time. X.org is therefore also looking for admin
sponsorship, at least medium term.

Assuming that we want cash flow reserves for one year of gitlab.fd.o
(without CI support) and a trimmed XDC and assuming no sponsor payment
meanwhile, we'd have to cut CI services somewhere between May and June
this year. The board is of course working on acquiring sponsors, but
filling a shortfall of this magnitude is neither easy nor quick work,
and we therefore decided to give an early warning as soon as possible.
Any help in finding sponsors for fd.o is very much appreciated.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
