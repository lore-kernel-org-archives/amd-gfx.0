Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C64C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 09:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C684A20656
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 09:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="rBu3ZBBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C684A20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A03E6E8B8;
	Thu, 11 Jun 2020 09:03:50 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28996E8B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 09:03:48 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id k26so4261977wmi.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=611EZXoXvMC0wgvkSoDqQkuDX4b96jfM5TQTQEW07+g=;
 b=rBu3ZBBsiU7BegTaLT92EmVcTqTQ1ln4TngPt+QtaRUJwZJvFNvlbvL3HcjTBtXw9H
 G1BFGLxRjII2qe+n6Wb4wAjp/MIbndhkzRvvFKrM4W8lQT+ibssLtH8TT46cMB5P5uU3
 5NUykMXB6wJxIim5uZLsueE9Lb1sMJwsx7fkaWRSDcEwhKWAYhiGyzIwnkpl/z6oq0Or
 4x+BtmbF9c7Gs6DTj+RsOX7oSNj6Q0tkv5onPLhaBIsEtG4yxV9T70vq8ePrXAlDNpD8
 5sB2zFwst0zY2C9XYIlAcPCJ2JUIt9V9Hjz4+vjSenZxVun25fMG+8FtkYQcjlFwLPq+
 dTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=611EZXoXvMC0wgvkSoDqQkuDX4b96jfM5TQTQEW07+g=;
 b=UON7+aKKimMPo/nPFlYm3iLMUseP6qRiuthLaYip3jTwlT5nQ0QcwCFHRxAKIBbE5x
 KvWrVMVa8S8vM689HNKhnYidKaQ9dn/4zcbrUkCcmH6jHXz/ata+r9FHGaFJcMUS8zNZ
 gOejiDssNBNSUSK8I7pLRGwQvJetGxGAV5PaLB5z20/fA6YQL9KIslL02l+pmIojtQ+R
 75x2dYn1Ws/aBnj3px2Dv8joU64qG0IZDALZg5/K9dYTr+JgbIOuODCQrBXCMzsBBMr2
 Finj4oN1bIxuoqjI10Nyd1qIeAx+9XZsUdZ0aw4Azrhms0me1HUiK5JJ0oMosmDbVwWh
 Bp0g==
X-Gm-Message-State: AOAM532C7XtozO67pKejitjA6x2yBGBQzpFralbh8nn4DLywQBVV0wN5
 pm2wQoM7T3ylL7UbP4tRjVhRlWEcIzbdAWQfvf3dQA==
X-Google-Smtp-Source: ABdhPJxPKKxxiM1BfEdkh9RUDLtOEwohJAfgWmxAu+vR7pTgkQ6fdURfjYcm3A4r4/Ejum+DBwaGettYUqKJ7IOPnc8=
X-Received: by 2002:a1c:6a01:: with SMTP id f1mr6984797wmc.52.1591866227178;
 Thu, 11 Jun 2020 02:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch>
 <159186243606.1506.4437341616828968890@build.alporthouse.com>
 <CAPM=9ty6r1LuXAH_rf98GH0R9yN3x8xzKPjZG3QyvokpQBR-Hg@mail.gmail.com>
In-Reply-To: <CAPM=9ty6r1LuXAH_rf98GH0R9yN3x8xzKPjZG3QyvokpQBR-Hg@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 11 Jun 2020 10:01:46 +0100
Message-ID: <CAPj87rM0S2OPssf+WA+pjanT-0Om3yuUM1zUJCv4qTx5VYE=Fw@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/18] dma-fence: basic lockdep annotations
To: Dave Airlie <airlied@gmail.com>
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
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On Thu, 11 Jun 2020 at 09:44, Dave Airlie <airlied@gmail.com> wrote:
> On Thu, 11 Jun 2020 at 18:01, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > Introducing a global lockmap that cannot capture the rules correctly,
>
> Can you document the rules all drivers should be following then,
> because from here it looks to get refactored every version of i915,
> and it would be nice if we could all aim for the same set of things
> roughly. We've already had enough problems with amdgpu vs i915 vs
> everyone else with fences, if this stops that in the future then I'd
> rather we have that than just some unwritten rules per driver and
> untestable.

As someone who has sunk a bunch of work into explicit-fencing
awareness in my compositor so I can never be blocked, I'd be
disappointed if the infrastructure was ultimately pointless because
the documented fencing rules were \_o_/ or thereabouts. Lockdep
definitely isn't my area of expertise so I can't comment on the patch
per se, but having something to ensure we don't hit deadlocks sure
seems a lot better than nothing.

Cheers,
Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
