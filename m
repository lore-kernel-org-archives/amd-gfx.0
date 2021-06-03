Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1419C47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 21:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFCC6139A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 21:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFCC6139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44026EEAA;
	Thu,  3 Jun 2021 21:11:55 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBA06EE9E
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 21:11:53 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id q5so7226261wrm.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Jun 2021 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=qo81W0COu/9T+MtdH15dWO35zb4IKBH3tap7L13Ay+g=;
 b=Ep1C99k65ha6o9n/Xnv083Ka95kqOxU0nc+P1Su4LgSF7LEKJoAw+0C8/4y3YWA1Uk
 9jmI+6Kg3RoJYHfcWvod76BaO3A0UqaPypcfqM4GZ8bcRyRWiPfoGo4yubuBwZwQAuBH
 WuAqsi7sTEuX8lJzK1mBf4J7nel1IMd5d6hks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qo81W0COu/9T+MtdH15dWO35zb4IKBH3tap7L13Ay+g=;
 b=ARBwMx5J3oN82o1ACarOefH++U+GVg/cOwiFtfPAQ/T1EfFWm7l3qOmW8pFRFL+OP4
 LWNFfbsi/3Gtyqzqoc4hSxmqmSxaGBW6QOksQ1ukH7Q93vUEZ2Sosfj4uBqLemdcHpzl
 K9JnTX8z1fiosKJ10Aq/aWaO5+bgRVyiKHqHuELhUdkW7KTvSuhKkvZu8OslohLVZyxf
 SqrsikYmaNH0zC8rqpr9wGD46b9oY9MsGIT7U33dPSMqSL78a5NIp+T2NXaKKTwsfM7N
 JVKATz5jB2kd4LMVjkK0vM347iuqv3fIgcga8Uqjcy6Ei0M8Pi2FiArUvcMt/xTvaN1k
 r4qQ==
X-Gm-Message-State: AOAM531BUlh4RdNPMwMgCpDDycrcQzz4r5k6e+bZx8myhvZ9DEJyCIUn
 di1e524//b3npB7JRITzU/Rk0Q==
X-Google-Smtp-Source: ABdhPJx8yjSE12ygh5q4XzGrGDcVw6g7J7uRZbzliCwqbFJIqvVK1qA/BT1I8/4oa8K2GVWvDzxesA==
X-Received: by 2002:adf:a489:: with SMTP id g9mr387883wrb.103.1622754712405;
 Thu, 03 Jun 2021 14:11:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id a1sm5056623wrg.92.2021.06.03.14.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 14:11:51 -0700 (PDT)
Date: Thu, 3 Jun 2021 23:11:50 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH 0/7] libdrm tests for hot-unplug feature
Message-ID: <YLlFlq1orNnGLXRH@phenom.ffwll.local>
References: <20210601201702.23316-1-andrey.grodzovsky@amd.com>
 <CAKMK7uFoLmOFCTkPMm4mMSScF0xa+MnHvY2FVmfBUM8b8S0_PQ@mail.gmail.com>
 <de4b3521-42f7-7fc2-7271-e4fa3cd91708@amd.com>
 <baf1d1f8-48c7-ed83-8e42-a4a317bfa74d@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <baf1d1f8-48c7-ed83-8e42-a4a317bfa74d@amd.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
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
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 03, 2021 at 10:22:37AM -0400, Andrey Grodzovsky wrote:
> Ping
> =

> Andrey
> =

> On 2021-06-02 10:20 a.m., Andrey Grodzovsky wrote:
> > =

> > On 2021-06-02 3:59 a.m., Daniel Vetter wrote:
> > > On Tue, Jun 1, 2021 at 10:17 PM Andrey Grodzovsky
> > > <andrey.grodzovsky@amd.com> wrote:
> > > > Adding some tests to acompany the recently added hot-unplug
> > > > feature. For now the test suite is disabled until the feature
> > > > propagates from drm-misc-next to drm-next.
> > > > =

> > > > Andrey Grodzovsky (7):
> > > > =A0=A0 tests/amdgpu: Fix valgrind warning
> > > > =A0=A0 xf86drm: Add function to retrieve char device path
> > > > =A0=A0 test/amdgpu: Add helper functions for hot unplug
> > > > =A0=A0 test/amdgpu/hotunplug: Add test suite for GPU unplug
> > > > =A0=A0 test/amdgpu/hotunplug: Add basic test
> > > > =A0=A0 tests/amdgpu/hotunplug: Add unplug with cs test.
> > > > =A0=A0 tests/amdgpu/hotunplug: Add hotunplug with exported bo test
> > > Given how nasty hotunplug is I really think collaborating on igt tests
> > > on this would be best for everyone ... do we have to keep doing
> > > parallel tests here for amdgpu?
> > > -Daniel
> > =

> > AFAIK as far as AMD goes a lot of developers use libdrm for regression
> > testing
> > while developing their features and also QA as i can see from some
> > internal ticket
> > specifically opened for failing to pass libdrm tests. From my bitter
> > experience with
> > GPU reset - features which are not part of a common use case such as
> > device loading,
> > mode setting or commands submissions tend to very quickly break as
> > people develop
> > features but never test them in those uncommon use cases - this is why I
> > feel it will be
> > very helpful to include those tests in libdrm.
> > =

> > Also given that this is libdrm amdgpu code it fits naturally into libdr=
m.
> > =

> > Regarding IGT - as you may remember I have them there too -
> > https://gitlab.freedesktop.org/agrodzov/igt-gpu-tools/-/commits/master
> > I hit some compile breakage on debian platform there which i need to
> > resolve before i will submit for review there too.

Why can't amd run the igt tests? Afaiui on the display side this is
happening already, at least sometimes.

And yes regression tests matter, it just feels silly that we need to have
them 2x for amdgpu. For old stuff the old repo is all fine, but for new
feature it looks a bit silly.
-Daniel

> > =

> > Andrey
> > =

> > =

> > > =

> > > > =A0 tests/amdgpu/amdgpu_test.c=A0=A0=A0=A0 |=A0 42 +++-
> > > > =A0 tests/amdgpu/amdgpu_test.h=A0=A0=A0=A0 |=A0 26 +++
> > > > =A0 tests/amdgpu/basic_tests.c=A0=A0=A0=A0 |=A0=A0 5 +-
> > > > =A0 tests/amdgpu/hotunplug_tests.c | 357
> > > > +++++++++++++++++++++++++++++++++
> > > > =A0 tests/amdgpu/meson.build=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> > > > =A0 xf86drm.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0 23 +++
> > > > =A0 xf86drm.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0 1 +
> > > > =A0 7 files changed, 450 insertions(+), 5 deletions(-)
> > > > =A0 create mode 100644 tests/amdgpu/hotunplug_tests.c
> > > > =

> > > > -- =

> > > > 2.25.1
> > > > =

> > > =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
