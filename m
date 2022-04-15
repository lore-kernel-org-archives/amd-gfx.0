Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4993C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 15:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510A810E08B;
	Fri, 15 Apr 2022 15:04:18 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF9F10E08B
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 15:04:16 +0000 (UTC)
Received: by mail-il1-x12f.google.com with SMTP id t4so4958538ilo.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ac6j8dxZS0Fy6Ls0ZSU2jPsiof9G9DoZqF5ZWQRNW4k=;
 b=C+JMD1Uz4yP1WBK4VCUEsLZhJwGPx6YPICQsDHdQoG9Wr479MI5fTvcnlxD7y+udUw
 cdf/AQaEV/mUv/uFGptCgCmV/jOg4aN+2QKySw0FPKwPWVDKsFj3KM11xSdGC6fLNrs4
 cqjbxGhCtxKOSxatvRCdGwQsv0mHp2BIB4eBHy98wMPWZ7G4TCXi1VIsyo2WTzADN6rz
 QJrp6baq9jXwJUFBEtcPNNTQXyRg8Gdt/98pJ8SEpPsd1vlWqr3iTJmnFQw2Q8gmNvGP
 FjYLJOQnap+hEFdosjRAZr783qXpmfQPOtw7PXeM5N8f+jzoTUqnKng9b8rkAzg0KHGP
 iciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ac6j8dxZS0Fy6Ls0ZSU2jPsiof9G9DoZqF5ZWQRNW4k=;
 b=TX+heMhW4DVrXMWvlhZqY/2PukhVXj2JGMUR9lM9btmRqxN2NGVJttUV5Nng3Hd0vP
 etJq9Gwl0mUqkaD4+5n9oE5sOljTqtSS4So+RVLJpYBqxdDM66rH4L+I/zxHzd0JXLkD
 gd0AZPIOwKRvPpzsccpJczsMXA1quaZISrolep7Tzul0F7GuGv7psTCNC6EX8dXvCZ60
 DAlX9tPq6w92XqSaL6pmgsAuP+48TkCz/LTEcUMhT2t9Nla5Fqnzc1D6rReKwppBjUAL
 ka8kYpvf5jkQjGPPoj+cBN48OB/HYG1FNh5hwtELWMZ3fSYoyBqMXjvJ9yora0/Aordq
 0G3w==
X-Gm-Message-State: AOAM532k2Yf3HPdmE5yagvxAh7dwtdrV8rfXZquaSbWOY0PrcX28scK7
 L0XA8mCPPmJyOyGj/LhWayjdjuamB6C/u1fMwhiLQaXYCuU=
X-Google-Smtp-Source: ABdhPJzBJn2oxswRxzuvPtwleudzItgvWcUn6Jau0FFb+Xfm95U4IWQKCwsFwcqM1Myt0bm/ptAMezegmPKHNlGnW24=
X-Received: by 2002:a05:6e02:188c:b0:2cb:febf:48f8 with SMTP id
 o12-20020a056e02188c00b002cbfebf48f8mr584738ilu.223.1650035055954; Fri, 15
 Apr 2022 08:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMvbhF-mcZd+mfSUVpYShvKmFiQ6pb+j2eosBr-kvsxE+202g@mail.gmail.com>
 <fae30821-f0b8-440a-a0d1-4c2a7d37ec07@molgen.mpg.de>
 <CAAMvbhFcD_YuoZEM+LyY6Yga9foR5mUBqPZP9TPpto5o4EGo1Q@mail.gmail.com>
 <28aa9e6b-5267-ea95-9a61-7c488fa97cdc@molgen.mpg.de>
In-Reply-To: <28aa9e6b-5267-ea95-9a61-7c488fa97cdc@molgen.mpg.de>
From: James Dutton <james.dutton@gmail.com>
Date: Fri, 15 Apr 2022 16:03:39 +0100
Message-ID: <CAAMvbhHyzJ2W5ooQB5LvGiCkoO1a473YFaMZ5aLeYK22L6hJgA@mail.gmail.com>
Subject: Re: Vega 56 failing to process EDID from VR Headset
To: Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I have raised a bug:
https://gitlab.freedesktop.org/drm/amd/-/issues/1975

I have also attached a patch to the bug, that fixes the CR negotiation problem.
My Oculus Rift S headset now works, with the included patch.
The patch fixes DP CR and EQ negotiation.

Kind Regards

James
