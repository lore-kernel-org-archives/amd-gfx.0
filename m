Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72800C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 21:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E22660F46
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 21:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E22660F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C20689DA2;
	Tue, 14 Sep 2021 21:56:30 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC5389C9A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 21:56:28 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B2956121D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 21:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631656588;
 bh=Ll67rbRc4gUJ+9O6OdSRmSgY9jfPA8IAo6JjA+x1hKU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Udg92vXYImQdyjpQl+ASXx87nMDQoj2aOOHovGwilHCR+klPFzIhRcEeFsGQXmfUt
 xpdhwREuaTG2c15927DSgbzrValOG471FoHq6NaYXbkbT6TrP+lLXNMGCqtNEy7+xp
 NOIu4AGcWgrdEzEp2dRut4gVfP/nFzIIyWW+hPncI9AWEGZ1OgLt0oV8WIFnfpkCuz
 I0djqguPVpltb8MdQWCFYuXN5/RY+Kwn2OtgFLw1RNBB9V/n3Kyafkdh9mrRUVZjIb
 IP/R3j+anRGh1ql3vIqGSX/KwXD2NHEeTASgPPQc3ix2iY2FmlcOS37kWa8VXjPcdx
 mQ1DyoNaymn3Q==
Received: by mail-wr1-f47.google.com with SMTP id i23so587122wrb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 14:56:28 -0700 (PDT)
X-Gm-Message-State: AOAM532rzTiB6JH5aPmzh+fJTyvloFXVMahiJyWwSJCFllUWeB6XL2dE
 u+Bf4I1Gtqx9++yNfczLqA4k0KDOu5sOsFTKSn4=
X-Google-Smtp-Source: ABdhPJwsJiXicBpos94epT3BeGaurFR0M7Eaki/aPYqnwGuBJ4F62qUa2Keqa9OxSn+hcsUV7Is58Qm+qSntB7EzDHY=
X-Received: by 2002:a5d:528b:: with SMTP id c11mr1274072wrv.369.1631656587222; 
 Tue, 14 Sep 2021 14:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210914210508.10627-1-harry.wentland@amd.com>
In-Reply-To: <20210914210508.10627-1-harry.wentland@amd.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 14 Sep 2021 23:56:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a243ruO-7H79yZ49_+5RVQk4V7kE_=Ffy7Gko-um_0VBA@mail.gmail.com>
Message-ID: <CAK8P3a243ruO-7H79yZ49_+5RVQk4V7kE_=Ffy7Gko-um_0VBA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Reduce stack size for
 dml21_ModeSupportAndSystemConfigurationFull
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Nick Desaulniers <ndesaulniers@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 xinhui pan <Xinhui.Pan@amd.com>, Nathan Chancellor <nathan@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>, llvm@lists.linux.dev
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 14, 2021 at 11:05 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> [Why & How]
> With Werror enabled in the kernel we were failing the clang build since
> dml21_ModeSupportAndSystemConfigurationFull's stack frame is 1064 when
> building with clang, and exceeding the default 1024 stack frame limit.
>
> The culprit seems to be the Pipe struct, so pull the relevant block
> out into its own sub-function.

I suspect it's not the Pipe struct but rather the way that you call another
function with a crazy number of arguments here. After your change,
this likely gets inlined and you avoid the problem, so the patch ends
up doing the right thing.

If you do more patches like this, I would suggest mentioning the new
stack usage of the calling function and the new noinline function, to
make sure that the combined number isn't actually worse than the old
number.

You can get these numbers by recompiling the file with the frame
size warning set to a low value, e.g. adding -Wframe-larger-than=100
to the command line.

Acked-by: Arnd Bergmann <arnd@arndb.de>
