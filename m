Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE38CC6B2A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C78D210FD2B;
	Wed, 14 Oct 2026 12:47:42 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F09410FCF1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 11:29:08 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-35e8253292cso11216eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 04:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791977348; cv=none;
 d=google.com; s=arc-20260327;
 b=EDNEdxdA1Fa5ntzHhiAmAR9ZfgFRKjgPprOpUXCC4YWj5IKLr9Qp+QWgi92UWrUHbY
 krO3acOglJ6+UI6SXNxzyHiTKZgemCWdmYqX2+OnV+prpQTcOAMF8CIXLbFvLOLT+kp+
 aHmOFWOY5392tnaOtNCm+equUXsRLqcUI1+QxnoJw4lQsocpFNqJ7eoOeGM8nmmk3+9M
 aegv7722HThj4+d+Zdh/irq1eETte51/u9LGSD3F7B1Lx1q0cAmtiaNjR9R7IVTPVr8s
 exe60BrwpRzbd9XH3Xsdg0rAwX97VWrLf3988UcVm9rJYtc27Pxo58DJ8FevJneyfa7w
 +ywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
 fh=r9nnneDzLoVwR9/MCNbW/1xpvZcG7+QcI12rTfoDPuM=;
 b=dADQPVHGFlsSMH+KvpaaTaCf0NmXNgR30Wcd2p4C3ttvQrtUkyHNZ8Iip/xo43wZdl
 RQdlJK2KuUY9EIB3iX/OghRAbf2UbT7JGpFmWQh8VIhFY24s7yKKnSo0Ca8TmoXOMH/t
 Fst+1p/v+HHqveVtRNWWOJFALc1T/JD/F6vmgC94oOlFMvB1hOP9N3Pjtt9lYel9LFeq
 5uYBUKWgllcbxGZRjwTaVYXjwMDpyk3Hpuj1KKAr6fxeWRLtjXXqJVP7M760eXDQwBHo
 Jb46Rwvd9draioiFxzDSJY6HUi0NRBP9H4mjwtyCWIsd7wmSOYW7Lj7sovddQW5W2ENp
 Gmrg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791977348; x=1792582148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
 b=XkdFS9nKuMkap6AwWaSj38bobcTfI5jJw6mfcf2Alpnr+uVPQiPhOYV6sJog+k119v
 SGxnjaFREuoIo+j4k/HADeMK+1JkIeUKrnBYp5HictQ0BsJbobjfhbO7cryCpGHfnmoZ
 kxRiOzEq65HQxYb9DAyKaVKNgozmq05xB8ULTJsLD/lrTnVKZqik+JnJ/SFrLslzCqOw
 G5uCzEc38MXNlFD6cdsygVH1WKb95FjD69PSZahT/5ePhwiad243JH3BFrhCa27/0l2S
 tZjvuNtE8HhL1sax7IZTdxWVMSjVyrBCYTwSWbKEXrCfNCDy1DFIUwlncvg2lsFTGMms
 uUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977348; x=1792582148;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
 b=xQ2mgLNt+Hb6XMld3F1mgQ+uHOeGtuAkSDMd1Y41fuUL9Njm6wNhwqMRePrahC3Rdq
 5q7BYRpShnZS5nLvK5H4b6c2OTW8YJQ52Jh4didOBhC0Z7fXwQ+a2WVJn42+MFUV7Gwc
 7lnOHuAT09sHewarjmZDu5w/7W0xC7pv8HD6bOlw3i0Vgd08WwJim/Nd32Vh1aBpfB7y
 WZRO16kR7o6gzEYZqRmhgvM1C4fFf5kqiccqkVjKy2+HnrbopLECGPkzIBaXn2HDHbvf
 qWNHzC377MEN/G9IXsioG+OqdrzlYT3qtVZh9y39H7iGkaBOeUFHn80ImAG2ONp59L9u
 HwTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdNslRkIHnxacRXJ7m7qoIHwDGlc8PEZ7lgwQly93vpPE3bPtCq8jHotywjH35C9zTo3lZsxxW@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI/XytSZCyXOWta8hTxkpd4+FGW2C4Wf6TO/A33tgKiI/IInZNe
 prmMJa+2HMAT+Sw8UasEQKYhLSCoaSkv07zf4yU/351lnv8qpxREkxsOAa8orOrnqIQ5YLnav/e
 bUurq4+jAp1pkbuL9P5eursXIhwHsIC4=
X-Gm-Gg: AYBFou0LT8jg8w17El9RI0rWs4IoLZRpK6309pXbJZfiS0eURP7q0Y3MTKml5Sefz8W
 zIZCN30TBHc4eyMiCUlTb7JifDO6QL4Y0Ja8rOQOqxYGeRHD/0H+3EltV6Lg5XmDQRtIUCwCms0
 wmFGi7PhEhk/f6woagtcNpWKSpOKqdaQmJa3FaoPsvgVDdy+8Z3G/A8P1njD2hzRL19aQiOCWQv
 LJHP7s8AFwziHoEP/IqGhJTy081mgxBrIH7JsKLj72gaO+WcClN8QGwUJ+Orlr0+1UgjAMFl2Ui
 NeqlhKaZzSEcDzln7jWWO7Jq1RNLzXcw9l7AxcTvP9HyKoc5p6qWhEsRek1IHmiPYLsw0CMHPIS
 hi1BMtjBs9FU87BJ3z9fGui5d2d//U9on8JLPfoeVPmHygpgSnUH+S9l+jk2Ig0Ik66rms5gQYY
 4twhlm7dZO2Qo8sPmI9tcGF7RSYCWuUfVj0RRTcQH8juPtqi7lCek=
X-Received: by 2002:a05:693c:6215:b0:35b:cb8a:8ce7 with SMTP id
 5a478bee46e88-35bcb8a919dmr14326600eec.1.1791977347656; Wed, 14 Oct 2026
 04:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-2-irogers@google.com>
In-Reply-To: <20261013223946.1836757-2-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 13:28:55 +0200
X-Gm-Features: AclHuK8qVHO7HVQy6LgzcUgjYcQf3EimC6SJcN58PVqcWVdOf6T45eXZNeTLsEY
Message-ID: <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add
 __require_explicit_initialization macro
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
 Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, 
 Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 driver-core@lists.linux.dev, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> +/*
> + * Optional: not supported by gcc
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#require-ex=
plicit-initialization
> + */
> +#if __has_attribute(__require_explicit_initialization__)
> +# define __require_explicit_initialization __attribute__((__require_expl=
icit_initialization__))
> +#else
> +# define __require_explicit_initialization
> +#endif

The LPC slides mention Clang 14+, but from a quick test in Compiler
Explorer and a `git log --grep` on the LLVM repository to confirm, it
seems the attribute was introduced in Clang 20+, no?

If that is correct, then it is not available in all LLVM versions we
support (LLVM 17+), so we should add:

     * Optional: only supported since clang >=3D 20.0

With that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
