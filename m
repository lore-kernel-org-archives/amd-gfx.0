Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43ACECAAD1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 20:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD6410E2BC;
	Wed, 31 Aug 2022 20:34:05 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D466610E2C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 20:34:02 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id h5so19124454ejb.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=BWCSto+d0Sdc3pu/dI6kfALxAxUh8nbvYhfQQse8Du4=;
 b=UqbaQCMQ8Ir0eFvGxnTJYodezvei/7SOzMXpuyww0mYZ3xZ4NBiWOHcuGfUW3JFyx6
 R9kOGei6YDc8ev/0UcWn+l1CYEt7H7an7s0unDOVanZTtppwMC/vEFfqNTie1tlekpiW
 bNhtEh95IhzL1atWzqECkFsv0tRezF/kKuHKL6kf89H4D4OGlyxQJQ5gBmJQFqBH8xk/
 T2ZZdn1ddK2rX1PgY25w1qd2Ae8olxOLVUy4GGw34dvLyCJT6IC86ek+E/DH3i0++g1n
 LiF76NTYdlhO+1mG8Wr+gxS9znLiCMWDPcbk+zJZS7dFcMdp7u7kz7I8mbZ0iq+OS9Sz
 M6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=BWCSto+d0Sdc3pu/dI6kfALxAxUh8nbvYhfQQse8Du4=;
 b=5DDciDUCssD0CuCmRGsLm2N+hEMSqVR0ng+kuuUqBesQNgCZD0hAvlT6L62tgd+ORV
 Q/3nO7qQn2Wusn43kaDZobF+uZoJgcOyDtPq9z+ZTnMDjxM8Clu4fYfbXgE1gZAAskrd
 jLLRrV7bRKgtpsaMIClrjQfGUpb7AxRMtwrraCTGzJfr3ROsYR7ub7733YEy/byL3tbS
 7tzQ98Wa/u5c/3gnYtnYEnMBdlATNbWxhCPSnosRpyFherSJtYtqqjfq+Rh9xvvEOa5p
 ryvghONWCyPf17YJK3TgjVJWacpsXvxG8PD91sQtOc2fPVUoyh3bB1hgauAD0/ezuIMG
 Mj+Q==
X-Gm-Message-State: ACgBeo0uhEb3GUysL/5qjuEypCtLUaNcZT9/UP4t9auH04lmRpJ26DMo
 HUJ/RefUxNPxOhPT79U/ZNmGEG2nbaIleZ4BD1efhg==
X-Google-Smtp-Source: AA6agR7EtnTzAoLqrkdRQji8od/wdsUejedlsqe6yDsRzJ4GH4pBLANa9tDTlmIUZyZjCCW75+Y2PPCFUGpfNE6atE0=
X-Received: by 2002:a17:907:7242:b0:741:770b:dfc6 with SMTP id
 ds2-20020a170907724200b00741770bdfc6mr12548822ejc.203.1661978041297; Wed, 31
 Aug 2022 13:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <630fa8c5.moZxX4/JNtIfjYQO%lkp@intel.com>
In-Reply-To: <630fa8c5.moZxX4/JNtIfjYQO%lkp@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Aug 2022 22:33:50 +0200
Message-ID: <CACRpkdb8bEyNrc7_gN+Lt-W_um56YfhOAcXgqEXsToGpvswmKA@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 7fd22855300e693668c3397771b3a2b3948f827a
To: kernel test robot <lkp@intel.com>
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
Cc: dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-wpan@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 31, 2022 at 8:32 PM kernel test robot <lkp@intel.com> wrote:

> |-- alpha-allyesconfig
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
> |-- alpha-randconfig-r024-20220830
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw

Fixed in this patch:
https://lore.kernel.org/linux-arch/20220818092059.103884-1-linus.walleij@linaro.org/

> |-- parisc-randconfig-r012-20220831
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw

Working on this one!

> |-- sparc-allyesconfig
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
> |-- sparc-buildonly-randconfig-r005-20220830
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
> |-- sparc64-buildonly-randconfig-r006-20220830
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
> |-- sparc64-randconfig-c042-20220830
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq

Fixed in this patch:
https://lore.kernel.org/linux-arch/20220831195553.129866-1-linus.walleij@linaro.org/

Yours,
Linus Walleij
