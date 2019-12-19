Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E03C2D0C1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 14:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F01A227BF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 14:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb/L/S4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F01A227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1086F6EB7F;
	Thu, 19 Dec 2019 14:08:59 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2326EB7F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 14:08:57 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id d73so5576753wmd.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 06:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2uR6rr15BRHMymaEFYOUXLS9zgKBwEyVcNbBJdvAbQc=;
 b=Bb/L/S4fYQHASJ/GdXo2WT5fJmxkJwntmSjTgOnG3+zZcI5Inm1M4YpVkMBVINC447
 IfX53PW8aolujo8C+oDe/WQFZRBFDvSSCKxuoilufndGobxRIW13C55Ls5EsvTlumWkt
 TfifHFX7AHMgDG+dyhSfhxm1eZBrN1Hmc833PZ61Euvt+gNSx0IIDmTwGkQs46ZLu0D/
 jSL89fr1i82fYvyLu+cUse8kyKakmF77ARE/ml9D0Nlay0nXVacdn1Ad9UbEDfqe4rit
 xBGhucfXL1oHToSnyCoemqSuD4qER98uHVsb0376+D30EMWxDw9T+w9iyC0Kj8LdjVBz
 wmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2uR6rr15BRHMymaEFYOUXLS9zgKBwEyVcNbBJdvAbQc=;
 b=lLbIEFw8o/Vg94RP0DMVXFPsEijQ0gXDNxug5V3H7z/X9a3ce+CRA0brIsYZO03Q6N
 Yyubu776b1oZeOc6yYC954Ovy9zvF/goqukb05N5lbeLjH4M8AQ6niI6lWTIG2cpsWyO
 xN8QCBMwqkpDkqC69xTA6rNT0Yk/LK3/w49iQ860gAxZ6RJKX2rb0qJWQXiqjHGc4Nl2
 3bF7qEb73u4gPI8xJTzyrkfWqOL8L4BuY0jS9SJjJVZ+3/nsk+RIw/WAYqoAUpAkkv/4
 ThI4ejzAcgiigB4tQRLVwiHHkZrvf3eQLW2lmrwQO3/ZEVvrnF4h9StAK9Savg0jg1ok
 3OfA==
X-Gm-Message-State: APjAAAXOaXsM40iCpz5K878zdlaSxbKc3iJDZzne7oMUCmv65Z4Mn+rg
 hdSMzwjvfHWRb04xYedaNxTFp30jvkdjhv+9giU=
X-Google-Smtp-Source: APXvYqwzp9AGIa8WY6Dkv+xFw3jIexVWORQiJf5K1b78kyjD9mbfmE8s22yFWllpEuzfJdDbiazXoE8m0qNUg95Ryjk=
X-Received: by 2002:a1c:e909:: with SMTP id q9mr10734150wmc.30.1576764536436; 
 Thu, 19 Dec 2019 06:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com>
 <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
 <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
 <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com>
In-Reply-To: <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Dec 2019 09:08:44 -0500
Message-ID: <CADnq5_OObnKTP7-tBmPz75R5qXs8ubRxgfX-qkBnzqcox0TZyQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
To: Daniel Drake <drake@endlessm.com>
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

On Mon, Dec 16, 2019 at 4:00 AM Daniel Drake <drake@endlessm.com> wrote:
>
> Hi Alex,
>
> On Mon, Nov 25, 2019 at 1:17 PM Daniel Drake <drake@endlessm.com> wrote:
> > Unfortunately not. The original issue still exists (dead gfx after
> > resume from s2idle) and also when I trigger execution of the suspend
> > or runtime suspend routines the power usage increases around 1.5W as
> > before.
> >
> > Have you confirmed that amdgpu s2idle is working on platforms you have in hand?
>
> Any further ideas here? Or any workarounds that you would consider?

I think there may be some AMD specific handling needed in
drivers/acpi/sleep.c.  My understanding from reading the modern
standby documents from MS is that each vendor needs to provide a
platform specific PEP driver.  I'm not sure how much of that current
code is Intel specific or not.

Alex

>
> This platform has been rather tricky but all of the other problems are
> now solved:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f897e60a12f0b9146357780d317879bce2a877dc
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d21b8adbd475dba19ac2086d3306327b4a297418
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=406857f773b082bc88edfd24967facf4ed07ac85
> https://patchwork.kernel.org/patch/11263477/
>
> amdgpu is the only breakage left before Linux can be shipped on this
> family of products.
>
> Thanks
> Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
