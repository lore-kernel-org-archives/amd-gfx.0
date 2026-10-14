Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E35CC6B3D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 08:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046851121D5;
	Thu, 15 Oct 2026 08:21:51 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0B710EEB8
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 16:44:44 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so38177035e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 09:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996283; cv=none;
 d=google.com; s=arc-20260327;
 b=QxQf7KA8v8w7nc7SSsgMEJClIMH+tGsShb8Nke82S1WVVNuP/uLI7OUqGdypQc05sf
 XCS1i4xJjEW3IhzIQu5U5S3PN62nQoOjj46AlYEkTMeikHPPI2GHZRWi6Ryk8xuM45Sg
 eDS+iXCIUq2Z/Hh1xLSntDSPV+M/9/+f32HVJtcj4fpDyiQ2cSrceRUnKJZXRoV9/xNW
 /Ns8Mbr8O7enu7Pl/vjzra3zW/75YuDBZMxGx6o6zXtMEC5XBRj4V0v+TkioESAIlF1n
 tPXjPWFwijFG930H2P+P/EEPuCPfVyP+gNu9WS4Oq0m/U3NlRQ1ypIr0wxbMpqFtI3gd
 ahvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
 fh=9UhvL3zPJEXyQGN7qS9wzFXzpJAqYePsmNBaGJHHeW4=;
 b=HKFC0AS4h1E+tyPrDYyr83ZY1gpb5DisVjeGL+9z2C6+M6DxPOoRfX8pQa29WAz8bI
 x8vi2BQoI59dj2eGmTEKFFFwcsRNazwUwufH4M6HSRFjzRFBH6Yns/2+Hb4eBhoVM3KJ
 1KdyhawW6GuRqenRwx+7hKnWC+ER31X+8uijOpEuic3Z2XGF6hvgCtIy7H7UgN4JmO5q
 CnC8mxc0RnDDwaIeoAFCSyBCO9UrP+tptL1no4guAz04DSjDPSnZFbDjjUy/3d+4z14j
 QAinSMdAGRa/U4UYJhD0YzXRlyh9vdbFRe984uysTfOqwQrPd0HG3uYV+LFFZapWQcEr
 B2GA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791996283; x=1792601083;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
 b=ZReJNgdfC/q5Pfj68Q+6y9L6c/Es/fQ8caAJ9Kq5ytloCYUppTXSPFjPHACHbbLzHw
 z/50jN+e5h1Xjkds3yi5snJZk5VnI7bjSSRA2/bEs9AdDSx4yoKUGPiwMwD+IHmDztlI
 Y3Kqk83zyXj54fJlLq1O15uKCCOQgpbwtmP2j+5UQjiiq6saHLOJHxDbB+5VHt3bx6pr
 VIUrJ1pL0qTVnbSecsIq/sVZJnmJW3PRYTjB5CALSbTjyj6tHwnr1OgfCO2qBngVeS+n
 oNKxX4jK3FIx6W00Cn9etpphccOxlReGmPvOz6md0jNAm0G85V10OsUHr4aMW0m/YBbP
 BhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996283; x=1792601083;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
 b=LWMeC+cC+znyGto5f0MreaAUw/BPEmrSd7P7BHL5Q3gWWlHXaHGUzgEdpfoT5YrKgT
 J+QnM4QF8Not/lZskvz08Jtvl4vCDmvMYIT493+YlYsrbQ1WrDibdBLZaJUmw0OFF7vO
 FDCBLnl6C6wwGa3BD+UclT5059IKU5wzhxldMvU62a9mzljQh6e6xFkZnpjz3UP9tqaZ
 sdeWBpdoTU9yDazw4w7gl5tC/SU9F7JSGxbgeN6dxzkBJuXkGDm4X3w/buUBF4PQ2HYm
 VdB3shSrIjIBI7/IEl5mTCec2tKsKl89/wNr0WlYpVYYxcjvHW0eCdf8xnd/6R8Ii+3z
 lrLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2TFV2IF3b9yyzT6Kmk70Nxw08U4WoUN8VAUN7WXvIiITgBwtZYpETF/XFo3hjoLYX3qC5cnjK@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKT6C1eMHWjtWGukCapFxJCPmcsQe9CPlhamkKJimtj7yrUiQ5R
 Os/a/OCKsmUekh+GVqTSZqUkvlXAuKO0QDSGnl1Qi0NJFMlnFco4+SUoPdoGu+S3kYSY3l0p4Dw
 mbN/P25G06cxWWv4ArQgosgLrUYKc+BqZ0QbqmW1K
X-Gm-Gg: AYBFou1VicQ18Hfv5/dj+YsYO8hqB40KlikBBYgYJXmU6Gh2fmp1WiSZq/cpLqDLiFB
 YF870B/p/Y9QE3NwQinpJ2Ej1bJrG3pokPdmd96e7Lv2Wzh2/02FPyrDPD8C17gPA0i8bci9jh0
 fxFcFbUCzBHExCThvQqEyNX+dJFX7YyPawM31er3LIkYXxqJ7DKp3jMQWdWyw8jHPr6IlfYrEP/
 JDnMf9ZG2el+yjZps9cL4qWvAqoCvva8BxMq/bKUOegWkGisjhMNX3a67PusT78tzAg2XH0eAhs
 z+iN6fISF9UdYBi+unx5aNTlcATmzbRhODo7esdWIE01f1jNWbmrUJw2cOSVNTjm540YD8m9+4+
 6BSN21Umb5qQCYK7FBlVyyejRXDK0ZnLbpJSWMDhOUMuIhDpsOHX9Xc/KylIAikGN+pylD829II
 2+2Y7cBh8/YmQAo9rE1IxdquDQ/pmESq3Q5hjuiE+pmjdRvTQ55D4L
X-Received: by 2002:a05:600c:354a:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a18e3ef23cmr329192565e9.0.1791996281614; Wed, 14 Oct 2026
 09:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-2-irogers@google.com>
 <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
 <202610140937.B68C8C9AAC@keescook>
In-Reply-To: <202610140937.B68C8C9AAC@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 14 Oct 2026 09:44:29 -0700
X-Gm-Features: AclHuK9LUe2FvddsKjj0vYiArabpm2vrSaqioSsrjl7koqqOn_VyYRh6l-6milM
Message-ID: <CAKwvOdm6nO6skW4-AZtmzpGoNyO126L_AN3Mz2fu23+3QXcshg@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add
 __require_explicit_initialization macro
To: Kees Cook <kees@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Nayna Jain <nayna@linux.ibm.com>, 
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
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:21:44 +0000
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

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 01:28:55PM +0200, Miguel Ojeda wrote:
> > On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > +/*
> > > + * Optional: not supported by gcc
> > > + *
> > > + * clang: https://clang.llvm.org/docs/AttributeReference.html#requir=
e-explicit-initialization
> > > + */
> > > +#if __has_attribute(__require_explicit_initialization__)
> > > +# define __require_explicit_initialization __attribute__((__require_=
explicit_initialization__))
> > > +#else
> > > +# define __require_explicit_initialization
> > > +#endif
> >
> > The LPC slides mention Clang 14+, but from a quick test in Compiler
> > Explorer and a `git log --grep` on the LLVM repository to confirm, it
> > seems the attribute was introduced in Clang 20+, no?
> >
> > If that is correct, then it is not available in all LLVM versions we
> > support (LLVM 17+), so we should add:
> >
> >      * Optional: only supported since clang >=3D 20.0
> >
> > With that:
> >
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Yup, I can confirm, I only see it with 20+ too.

Fix up the comment and have a coin, witcher.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> --
> Kees Cook



--=20
Thanks,
~Nick Desaulniers
