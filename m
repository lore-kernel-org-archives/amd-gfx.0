Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CA4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 19:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B932CC1B1D;
	Mon, 25 Jul 2022 19:28:23 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2A27C1A70
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 19:20:15 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id z18so2924312edb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XVDIZFYcquyDU30LBhCPD/PXD8V3Ex6g+/4Jt+pCRG0=;
 b=AzQOEmHT1inFFysvEynnDtRbqEeUYeR3B2ZfONqWXZGdpODf9tTWJBIMwQvdfinCE6
 8EN+GqBKJQTMGcSZ9cYlGyaoEZMlReop1K92FAHZ1Kc+VjrcDKpUg8JJP71bsnkzKbs3
 mRPrDdQCmFJwtfI+xqu7XqXj1zo3TG0h/Dd74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XVDIZFYcquyDU30LBhCPD/PXD8V3Ex6g+/4Jt+pCRG0=;
 b=fUayBtlDP1u53X33Xoe+thmfDWP2/6S2/iV3eTrnpXQV4R7DrHbiyxHKElXSaTyQdx
 7EmKzr5hlCs5sGzH280Va4j8koi29K8AieZzdpvEZiTwEy8EvFn5ESZUbo5LF9mfX2/K
 3Cwzz8ruvpb5A1T2QFhiezMlkcPwkEvDEx+R+6c832SEivcVK82cJqNLD9yfLJrtYB1z
 qT+6SoMkdUy4z+LGe0oPZ2X+0DrrBBYyeR8klMShJ1IRGyV/rWBplR9oDyKZGjOmenrk
 ODCxN2Ys7LebA36mgr2t42Y9dyoTWPrOEUkmwkwVsI76uXYv9mCJvMLoTjLjb48PImUs
 362Q==
X-Gm-Message-State: AJIora9y5ka5eBln//TvVFpNkZXLlPcFtpLWLpqDr/wWiT3y34hgo2PD
 nA+xzEU7jOE/WNe02PuuKwjGvw8X3quc5+vD
X-Google-Smtp-Source: AGRyM1sM+A4sSkQfBAPgRUdsoskQ+gu9CMFRhYRD7f73ZtwFtYnTA+uoU9RNcZ7BTV+1M651pkpTGg==
X-Received: by 2002:a05:6402:26c8:b0:43c:1ce4:e9a4 with SMTP id
 x8-20020a05640226c800b0043c1ce4e9a4mr4343138edd.26.1658776814011; 
 Mon, 25 Jul 2022 12:20:14 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com.
 [209.85.221.53]) by smtp.gmail.com with ESMTPSA id
 h12-20020a170906718c00b0072aed3b2158sm5616457ejk.45.2022.07.25.12.20.13
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Jul 2022 12:20:13 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id k11so16911911wrx.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 12:20:13 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr8625583wrh.193.1658776813045; Mon, 25
 Jul 2022 12:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220725123918.1903255-1-mpe@ellerman.id.au>
In-Reply-To: <20220725123918.1903255-1-mpe@ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Jul 2022 12:19:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
Message-ID: <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 25 Jul 2022 19:28:22 +0000
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
Cc: dan@danny.cz, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 tpearson@raptorengineering.com, alexdeucher@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 25, 2022 at 5:39 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Further digging shows that the build failures only occur with compilers
> that default to 64-bit long double.

Where the heck do we have 'long double' things anywhere in the kernel?

I tried to grep for it, and failed miserably. I found some constants
that would qualify, but they were in the v4l colorspaces-details.rst
doc file.

Strange.

             Linus
