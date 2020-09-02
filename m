Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2F8C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 15:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DEC2072A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 15:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="eZ98yo2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DEC2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 522766E93C;
	Wed,  2 Sep 2020 15:52:00 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC89E6E939
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 15:51:58 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id c19so3442625wmd.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Pa2v9R6HR7b/pDUYXflnHBdnCYt3kzuoYpeXOCOC/0=;
 b=eZ98yo2h+IpDJLHCAVg8pf4bQQgrrIR3kqyEA32yLbuOIAxFXAHlNiG3QbWcP7ywsy
 WSAnNq1k9mjIEbTfbSEc4xWQSBsdFRiXAEXK8SVGRrbziQLqcuKbHACDywoe2UpM71N0
 TeqesAsn88r+ap2tQ3UZYEa7OdLOGaxhjDnVkUEWM8JS1GbEvbCXvyjflRaazc22R4qT
 FBhiXiEcz65Os4fadPmo7VRE7TE09DiA53DYdT8Q8ERCgloBxR8zyDW7DOIErenD2r8J
 e1KUxOtSZ8cC70htTe8s1GoBV/H+R/JRPJYgd0vH5Aq62d8L+mRQ1rwfTL2mHoiaaQA9
 //Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Pa2v9R6HR7b/pDUYXflnHBdnCYt3kzuoYpeXOCOC/0=;
 b=Gki6GX62u8t58W3G9QZXuR1zjoT0cR2wCtDEp0g3smVIJjBAT14WsPOrEQJ05pDOQK
 lK1e0q9phmP8m4T3wVSCmyi9mbP5tZLh/fwTkqLeHP5Ix5EEV7DpjdWOVT3QduTVZftX
 lGIZaVmfGqYkc7+8unG9c3aJH+xJ0hZ7Lmfmmce5XkZj0rBGZvU92mAm1AqBDdxMWzJy
 gN0DeXrCYmXThWtYF/mJ8saDVDWFfypdqHs5EaIrSFLJn/nO5fl6ujpul236/FczSIld
 HSzTJXnVhTOxXY6dwnPTKE8Vjy0xwe2cnDx/6LFrTxQbhB75qQOd9VIlha9CKGEx2MAk
 HWxA==
X-Gm-Message-State: AOAM532wxdroMq7cX2PrJu86Y2x+ZRcerhJBL9sUSrJchkbmFh0rouQo
 Le+TT+upc8H1CB3F+ayvkfCztPy1iNnOSZhNV6EL2w==
X-Google-Smtp-Source: ABdhPJxklWTXMbj7XCA3kgOdPIvgEd3TL5aPW8f4PM0qZ3BrOBbmA9oFX/7bFJ8UP75W3LTR457EfJLG8lWVB1pU0ts=
X-Received: by 2002:a05:600c:20b:: with SMTP id
 11mr1324349wmi.147.1599061917500; 
 Wed, 02 Sep 2020 08:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200902010645.26943-1-luben.tuikov@amd.com>
 <BDD53312-3A34-4761-A7C3-6FDFE66A6C1F@amd.com>
 <e6916b3b-60cd-e223-4f87-478aab3b2468@amd.com>
 <62D0EAA9-E3AD-4FA7-AC24-9F5F9C594EB2@amd.com>
 <0f336bb9-5d78-30ed-d217-c5905d1dc08a@amd.com>
 <CAPj87rMRemGSZGoPV-BYrAZCK26aB-rFsKL6hVPRsha_850SXQ@mail.gmail.com>
 <20a86ddb-df88-225d-a33d-7feec82a46c2@amd.com>
In-Reply-To: <20a86ddb-df88-225d-a33d-7feec82a46c2@amd.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 2 Sep 2020 16:51:46 +0100
Message-ID: <CAPj87rMKNZfP1=kfsHPbRaJtHMAEKY+87p6uTAt=Hh76FwZVcw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Use implicit kref infra
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Luben,

On Wed, 2 Sep 2020 at 16:16, Luben Tuikov <luben.tuikov@amd.com> wrote:
> Not sure how I can do this when someone doesn't want to read up on
> the kref infrastructure. Can you help?
>
> When someone starts off with "My understanding of ..." (as in the OP) you know you're
> in trouble and in for a rough times.
>
> Such is the nature of world-wide open-to-everyone mailing lists where
> anyone can put forth an argument, regardless of their level of understanding.
> The more obfuscated an argument, the more uncertainty.
>
> If one knows the kref infrastructure, it just clicks, no explanation
> necessary.

Evidently there are more points of view than yours. Evidently your
method of persuasion is also not working, because this thread is now
getting quite long and not converging on your point of view (which you
are holding to be absolutely objectively correct).

I think you need to re-evaluate the way in which you speak to people,
considering that it costs nothing to be polite and considerate, and
also takes effort to be rude and dismissive.

Cheers,
Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
