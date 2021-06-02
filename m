Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E163C47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 07:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8FF61376
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 07:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8FF61376
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BE96EB6F;
	Wed,  2 Jun 2021 07:59:14 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100A96E086
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 07:59:13 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 66-20020a9d02c80000b02903615edf7c1aso1645062otl.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qGvUg7g5napozN81BeHjEpK95x/aqYy7PtsRq+Mdc5E=;
 b=R2tiPBsEGIDqXjwieTtACdfLOACuaDag9L/+f51fjJzSJVyFPpA4Ljp4ORadpaYtV5
 Mlnas7VvWSWOQlvmFbOTBWru/Kqi7e6JOi3NEABL2STqfmKj4CLKAqG5699uGT62lK9V
 77GTdcmFKg0zAhDz/vaX5UtGE4fPZVGtGYPe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qGvUg7g5napozN81BeHjEpK95x/aqYy7PtsRq+Mdc5E=;
 b=ailtKmZ9TnyC6x/qiQHRofadg1HvhQMpURINgyIYMnXra4v/D27U+kBCnWnZ1eTO1Y
 JwBaOIF0r0UrbCC9WwCDDCRHR+u0xA+z8jgMKrR2rjxyBOhrnSOL7qxaMNzTifefoty7
 ES8LWqkmUnfOrwVjf+SFLQuMsC6ni0jYUzGAxTZY3kw7bJigja/8jW6KfW+sqeLHolFT
 JAFq8W6IMchNA0ErePpFb84jwxdoq+D0kRb8iUgNQJlp0rCMYNhdSFfe3JRkNQizjn5L
 NCqAzvbw5K+kpKnVyGWE9SZK91vexeZ7jiKpKg7SBeOOVrKCCFJ5SdjgtaFsz8HhhnBh
 2hGg==
X-Gm-Message-State: AOAM5317qgNqQg0meHPIs5ngOZEenOWdj0wmHMcgOdw+ABUS4ifVl8kJ
 eftO9aWfDXuLufWj9SpP0rHySbMeHtiRzH4NOTH9sg==
X-Google-Smtp-Source: ABdhPJx1g/OLNyZ55JeYwk8dci0GheN+3UPp7HULJgUiGCuX7h7dda+hPxqK58LjJBKBSzmk1iqT2eOTTTlVd5WmOMI=
X-Received: by 2002:a9d:4008:: with SMTP id m8mr15846097ote.188.1622620752246; 
 Wed, 02 Jun 2021 00:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210601201702.23316-1-andrey.grodzovsky@amd.com>
In-Reply-To: <20210601201702.23316-1-andrey.grodzovsky@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 2 Jun 2021 09:59:01 +0200
Message-ID: <CAKMK7uFoLmOFCTkPMm4mMSScF0xa+MnHvY2FVmfBUM8b8S0_PQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] libdrm tests for hot-unplug feature
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 1, 2021 at 10:17 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
> Adding some tests to acompany the recently added hot-unplug
> feature. For now the test suite is disabled until the feature
> propagates from drm-misc-next to drm-next.
>
> Andrey Grodzovsky (7):
>   tests/amdgpu: Fix valgrind warning
>   xf86drm: Add function to retrieve char device path
>   test/amdgpu: Add helper functions for hot unplug
>   test/amdgpu/hotunplug: Add test suite for GPU unplug
>   test/amdgpu/hotunplug: Add basic test
>   tests/amdgpu/hotunplug: Add unplug with cs test.
>   tests/amdgpu/hotunplug: Add hotunplug with exported bo test

Given how nasty hotunplug is I really think collaborating on igt tests
on this would be best for everyone ... do we have to keep doing
parallel tests here for amdgpu?
-Daniel

>  tests/amdgpu/amdgpu_test.c     |  42 +++-
>  tests/amdgpu/amdgpu_test.h     |  26 +++
>  tests/amdgpu/basic_tests.c     |   5 +-
>  tests/amdgpu/hotunplug_tests.c | 357 +++++++++++++++++++++++++++++++++
>  tests/amdgpu/meson.build       |   1 +
>  xf86drm.c                      |  23 +++
>  xf86drm.h                      |   1 +
>  7 files changed, 450 insertions(+), 5 deletions(-)
>  create mode 100644 tests/amdgpu/hotunplug_tests.c
>
> --
> 2.25.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
