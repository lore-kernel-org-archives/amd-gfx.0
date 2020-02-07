Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ACEC2D0B1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 04:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59723222C2
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 04:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="uddvL1JO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59723222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0F96E85D;
	Fri,  7 Feb 2020 04:52:37 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151AA6E85D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 04:52:36 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id h12so1022667qtu.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2020 20:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zD+SD3a85WaBxn1quERCa86dJtVc2O8o6GA7qwBXCJo=;
 b=uddvL1JO80blrtkaBfjv1aHwZ4HIytAKy0DI5CT9/O4us4MST76ZlsrdKQysjeImgW
 w3Rx79nuHFyMRNvG7GnsVnVipDncm8zE7nRpEr7FqIPPz+nnKLNEXI2N76W3/ZLZkT5Z
 Y+BlQr+helxKkejSPCoOc9+BTLIWiwLQ03l+TqRQxvE+nKlsNfS120O2c1Iubg5+ZFQO
 mLIoBeBnxdYYchquUqH0Cg9qF9NKVYhKYgC1vSkUjq5URuH7BKhqIKwelatUjTN1YoQl
 aI//XrgBlQA4abFi3U/VDYgOreY2cfEO+w03A5k1j7T7RMvtX94WDRb/ZOl/0/s+XH7w
 IDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zD+SD3a85WaBxn1quERCa86dJtVc2O8o6GA7qwBXCJo=;
 b=llfeJCIO+aciQksWHuJa2OY0f/tJt+N/C+a57ZJUl0wsuPv1khuPAghIfAMk86AsAm
 kDPS4xFiXn4Ov9oFSaXSelj5HeZ6WgmLhMnRH9T22teOXVOb61eC+tz8J8dDMyTMciJT
 8VhKUwFHIJWns4vQ21aqRKtdtKqbzCojbZBl6ADyl4ZR+R/m2dMcjNBpOhoeCSwl7trK
 soAAo+GZYNxix/BWADkOGSSa6+Zcp023Fz2ZDQSImJ0qeSUp+NAXudwncCEVYOFXbzaS
 dzANAAeE/oC3MqLjZQRJSRaPIi8yF8OwsMH7ZNamiVx0EkIX+RXn8avbZHK2erQfsXBN
 zLWA==
X-Gm-Message-State: APjAAAUR+yauBFHa0922zcZJIQBOliItd8x/sCVO58jggRlH1yHA0FLI
 /qo1EF/Ifh43WpVU7TzEDm9Vga0WR8gr7pmWLyDgjA==
X-Google-Smtp-Source: APXvYqxdMLigY2gCSUFZRs79VGs+uC4dThA5WCs4e+pUPAKLGhvcheCYWpetzZ/p8JD1bZZO+ae2gLnu+ndNSyfimRU=
X-Received: by 2002:ac8:59:: with SMTP id i25mr5804123qtg.110.1581051155016;
 Thu, 06 Feb 2020 20:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com>
 <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
 <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
 <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com>
 <CADnq5_OObnKTP7-tBmPz75R5qXs8ubRxgfX-qkBnzqcox0TZyQ@mail.gmail.com>
 <CAD8Lp44FKuEsmdK+zDX_-ZYQEnqjQM-z6nnfE-CJ62mutd+scA@mail.gmail.com>
 <CADnq5_PNGr4=MqpBeKbhxJ-gpniSCj7L0wO5_V6mjuwpKoaCAg@mail.gmail.com>
In-Reply-To: <CADnq5_PNGr4=MqpBeKbhxJ-gpniSCj7L0wO5_V6mjuwpKoaCAg@mail.gmail.com>
From: Daniel Drake <drake@endlessm.com>
Date: Fri, 7 Feb 2020 12:52:23 +0800
Message-ID: <CAD8Lp47vOdyG+BSzFy2URULz4icXYHW7SMW9zBEt4nfz804XTw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Chunming Zhou <David1.Zhou@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 16, 2020 at 11:15 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> It's just papering over the problem.  It would be better from a power
> perspective for the driver to just not suspend and keep running like
> normal.  When the driver is not suspended runtime things like clock
> and power gating are active which keep the GPU power at a minimum.

Until we have a better solution, are there any strategies we could
apply here to avoid the suspend as you say?
e.g. DMI quirk these products to disable suspend? Or disable suspend
on all s2idle setups?

This would certainly be better than the current situation of the
machine becoming unusable on resume.

> I talked to our sbios team and they seem to think our S0ix
> implementation works pretty differently from Intel's.  I'm not really
> an expert on this area however.  We have a new team ramping on up this
> for Linux however.

Thanks for following up on this internally! Can I lend a product
sample to the new team so that they have direct access?

Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
