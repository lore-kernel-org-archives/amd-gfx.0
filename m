Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FBBC433E1
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 07:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10662073A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 07:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="q1a8xJM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10662073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A05AB6E9B3;
	Thu,  9 Jul 2020 07:36:57 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A706E9AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 07:36:55 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id q5so1226915wru.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KKtQly4ao6B6nwRWEDkHlPwVhDZwmTFzlBzK230IGUs=;
 b=q1a8xJM/Q9Wj785BtNlEuDFVR1eQk54JebnUrlGorLvEHVMtqdFOuaGKrTYCsphJ1h
 jdn7d6bEOoYqm6Dc8k5LjNzJMPs7sqOYl93W/0yr7CIrm1h2/Lv3g+fhNpsEY21yKMZh
 ju/lEovQ160zqDVi53k34kcqcJLZdTHFacxSS0a8W4cpfdDptcuxHSPlubyxOMMuaSBC
 zAyYruzxGOJbmMUqmjN2Chf/XWhBZgAcu1tmI7ShCPPddj04M/M8Yf8LAduuKxgJQlTV
 rIzd0KYtUf5G7qRV/73bX9CHJ9uhQaanPFGitTqRJCgzv1EMfeBg/7UHJHVTRmYqPihB
 A8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KKtQly4ao6B6nwRWEDkHlPwVhDZwmTFzlBzK230IGUs=;
 b=Lh3ExVgF9SY7ftKmj2qnuk1Pnx9kD1oG0K+UNVth0m4R0ZjJSwyiG2tvs4Jbo9GCnt
 vHewvGg474VHMTS+uTHFnxvbNFzwATJgBDtJwFsEfbQ0Khr2O13l07bbRdNG5iWW+IQx
 +OyRmEdvjD6YN8WHUAQpO5Yjf8jR/xYZF/WGwqk294/xqXQpzl9FXQrOOC3orlGKdJTE
 f5vn3Dm4JvdpeCwdfKzCAI2YFNIIEjusED9sQ7wsFwXeVNl7+d8Xq2qfkpy5mJlYwEdz
 GsmCK2yFsAz6bcPIvidDcu8elV9PCMxs/zDersoBehWVkHeMsDMTkTF2E+rNNOuzHm2h
 AoNg==
X-Gm-Message-State: AOAM5300NtV2IAF6+q7tRDD/cQQQ8wLIoWKwv/FWTu2AXCU/SFvuGrC/
 7Olz540vGQ1mhBPcdG5qaJqbdUiki9cMwlZyM4h10w==
X-Google-Smtp-Source: ABdhPJwOIE8GoaZZk1aSRinMLKGhWIbTpQIZ0IBDLoLaRN5k6dzJvrX8BOXeDjMLQXA3ybdstuq5y6Y6MSCOm3lN/7s=
X-Received: by 2002:adf:f9c8:: with SMTP id w8mr60764235wrr.354.1594280214366; 
 Thu, 09 Jul 2020 00:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-4-daniel.vetter@ffwll.ch>
In-Reply-To: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 9 Jul 2020 08:36:43 +0100
Message-ID: <CAPj87rO4mm-+sQbP07cgM8-=b6Q8Jbh5G0FsV8rwYx2hnEzPkA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/25] dma-buf.rst: Document why idenfinite
 fences are a bad idea
To: Daniel Vetter <daniel.vetter@ffwll.ch>
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, linux-rdma@vger.kernel.org,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Steve Pronovost <spronovo@microsoft.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Jesse Natalie <jenatali@microsoft.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On Tue, 7 Jul 2020 at 21:13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Comes up every few years, gets somewhat tedious to discuss, let's
> write this down once and for all.

Thanks for writing this up! I wonder if any of the notes from my reply
to the previous-version thread would be helpful to more explicitly
encode the carrot of dma-fence's positive guarantees, rather than just
the stick of 'don't do this'. ;) Either way, this is:
Acked-by: Daniel Stone <daniels@collabora.com>

> What I'm not sure about is whether the text should be more explicit in
> flat out mandating the amdkfd eviction fences for long running compute
> workloads or workloads where userspace fencing is allowed.

... or whether we just say that you can never use dma-fence in
conjunction with userptr.

Cheers,
Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
