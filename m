Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1EFC2D0CF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 09:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CC9207FF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 09:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="zIlhGEr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CC9207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD7C6E1A4;
	Mon, 16 Dec 2019 09:00:49 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E856E1A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 09:00:47 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id j5so5182718qtq.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4qbT+I3jm/2znfx77rItPHA5w5yjCMeZJROKsiWB1gc=;
 b=zIlhGEr6sueDlec+SsoI3zWPpi4Nv3bf842JXqAfjxNMrahRhW//FxbL0HYYRSkooN
 x9v99HFGa8JOfAHCEDtWd/Eak1J1dK8+dEgR/LNPq8jlcMH5z5QKl29pThUrWXcl15Di
 GzC9za+SPVtQRqgOp8B/jvRRKspsNQAE5KnwMlRoD68wSaT2MUj4FiSbP+SJZJn/H+HC
 90WwBS5If2YXeNAxBR1Tm4MZfQ93jrn8DalTFEMzE9xjn8Dj92MYEL4653Hfu0VL1zWo
 kx5eqHdB7tE9x9csuK5RcbMyR9YQHvOMzW+MKIKpcZNxNejBH+/V6di2iWcN085zuzUS
 hCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4qbT+I3jm/2znfx77rItPHA5w5yjCMeZJROKsiWB1gc=;
 b=WZd/5W4l9pYV465tkTzAXfyOd3LEwJBz2fqIZsTHTKW4Aa/885EuqXudXvft03wF1T
 1zvBpVlJ0lquPbtgstArzdqMtjLYNlsJ/Jm479bwsZ4UspFADjx+G0No0qKBoC0hC2rI
 2ySNcyPEqTiop9lj9UscvHv2wfJgoBwjK7UM1qlDi8malSHy3kx9XTC+XxvVKrk3w7jq
 KhjQqF0LvZ6ZzJMfL2qVSNdOeh87BM0Rt3z875sxgT+v1pAU6HXwv5DnnzKm6xzCW4aA
 Fq2cYrZN5PdBBKx5h9taQjb/qAMoQtFohKJkj5AoaQlEg+81ogDE/v3ZT/Hoi4w9FyqH
 7eCg==
X-Gm-Message-State: APjAAAX+3eHahLJREqxhAI6UUS8cauZnbT7R4Bv4uGlD+A5WfAswSc8O
 t11VWATjxnILnWsVsJ2S2Sd00WXTMUk5gvPUWIvT/w==
X-Google-Smtp-Source: APXvYqxFw0PixT6czuXw2KjQpezDgMGtxaaLVVUxBSilC7n3O/FSvVnHvBWJt563rU52HGEH6/IzU5WC0dCNqjLOXLM=
X-Received: by 2002:aed:2f01:: with SMTP id l1mr23183037qtd.391.1576486846418; 
 Mon, 16 Dec 2019 01:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com>
 <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
 <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
In-Reply-To: <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
From: Daniel Drake <drake@endlessm.com>
Date: Mon, 16 Dec 2019 17:00:35 +0800
Message-ID: <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com>
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

Hi Alex,

On Mon, Nov 25, 2019 at 1:17 PM Daniel Drake <drake@endlessm.com> wrote:
> Unfortunately not. The original issue still exists (dead gfx after
> resume from s2idle) and also when I trigger execution of the suspend
> or runtime suspend routines the power usage increases around 1.5W as
> before.
>
> Have you confirmed that amdgpu s2idle is working on platforms you have in hand?

Any further ideas here? Or any workarounds that you would consider?

This platform has been rather tricky but all of the other problems are
now solved:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f897e60a12f0b9146357780d317879bce2a877dc
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d21b8adbd475dba19ac2086d3306327b4a297418
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=406857f773b082bc88edfd24967facf4ed07ac85
https://patchwork.kernel.org/patch/11263477/

amdgpu is the only breakage left before Linux can be shipped on this
family of products.

Thanks
Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
