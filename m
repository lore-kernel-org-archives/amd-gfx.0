Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CA5CC6B3A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 08:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627EB1121A5;
	Thu, 15 Oct 2026 08:21:45 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C2F10E9D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 16:41:39 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-533202fe429so1288981cf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 09:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996098; cv=none;
 d=google.com; s=arc-20260327;
 b=YqqdqqTzjsM8N7AAqh5QOwvR9XWGwvauCswy0MzwGjQ+F2c1AVXpwiLa/S4CsvPN98
 +Ds7sbTvqS73FLnMvmdbzyxyD/vqMqFLJCxMbF8LurStkWp7PNM6KAD0PihSlIj/eipD
 MT2USXmxjPxUC8yGPfnwOcBbEws0GJSIpKZcv7N5rBZPi0lVcpeVU62kEien8aQ/Ai7Z
 m6MMUqutQWnJa+ycoKQBtqsto8MpP+t7gr19aNmKe9WOBo+ZYtsOgTNsnrWPz11tsOqy
 oYYMFYnVbjgpvRV3WD2V7oSCBRHSVV22bNyL1h9pmOMVEQprvACD949i6Lku6vGspWZu
 ZuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
 fh=TCBfGgBailcmX9fUB/dPGU//Kd8RsTT6VpWB72srQpU=;
 b=dKZiYgDtDDQIrg8k+41i5d0WS1lmtZNnXeJFJs3fVcaKlt0ixTlWqFpKVcxP/NqhMj
 cBlki/8SGxiek2ZpdlD19jwKoZBRtvSBBFpK6UmDwxjRR9brgySS5GqfbgY9OXe/72Vi
 c5bbhkoH3PClXCw193sexk8/owSOZytMKTFCVlfrMqQYtgbAKoJup/aMBxtygq1KCesW
 fqhJ9WXg6/r8Q+ez0hqNi6vMCqSVKQVuMRO6YTWhTCNqqhDPZrFiGPFUx0JM291H8vMn
 5z0oMTfzmMUZfzrhqMYkftuP9NDdLnjTyJzNhJh0ZrKZG3OaLStVyn21ABrMEbDir9ld
 94/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791996098; x=1792600898;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
 b=CVpVzMiKUSfq6swH4BzcS8fzbY7EQE/3ygYIu6JLRW6Kw5pduYpPT/BKCu1npw5ueK
 oVzback8qYUY3b5priKHbjbmysHdZHA4+wPQ4Pd2D6/ocN5KYpnpdeCU2sqYwsH7QTG/
 6dsjzyCMSK+twgg7UreLqRQDuppT/rnlCWIdKoj6rFmQSKvnazjTFQJfBvNUULkWRkOT
 Bml3tqKUNWVZPq0DREoNwc5Ut4HIbWEQWZLHrlwP6UOiB4ztZB516OTcUceHT75tynt2
 G+ke8JxnNMwhjVG8QemFwyb1nO3g7nrw9bSEmQjM2pE511MqsAsPP3xR1nMcXjUts5cz
 tn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996098; x=1792600898;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
 b=aXwg2D58DhHPMJx8aOJ3+EgkfYx+SvaLDyTKKT23JtgEofWqbOa12QBjXxnVSA/peL
 10/mlpF0HLNdNu8SHV08thwJiIQZNWrR2iGB/NNCTF8qHOfHPks8etbZ/rNaNWW1xq2n
 EXmyTKYarwx4fQpjlkxTtS8CQ4i45KVaF9GYE+FO4jaCg0k1LHtuKwXdCeb5XZL2hvvM
 dpfIb39SrNKTvdxvfhFOwadF7oAcj8OqRhOyaZaQF1RIhG8b6Qk3qKRkJWnhiNXCxotz
 NfXrGOHC7fbuset6cGrYSB8+W7RfmjD4CaCy/aA1f61lzGY4CCy6qNVtWt8bS4p6WySS
 Cjfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzUNCGoOUDZsrUjkMGapiD1DH5aCiMoBlHt3RIL7AKckAcBpPeSHkw5JL3Rbgl6veQPDVo1gxh@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIZp36Zp10c3GiVviW5Ywgs1e51rufjf3eFLucZSStZEvv1vKex
 b5GVeLK1jYM7XmZyFdXMP/HPeOdRwjqdhPuQPxNkpY2yO6KcdfYKM6Wt2vclnIUDRxdKfCYwfUO
 E+IrydtnUbSz88xU60f+4cwwc52+XiZe1aMKC6WiH
X-Gm-Gg: AYBFou32flq0BiUsFVMmvjlwvjrtlZAZTOUZpNnMUP8N/yP42YdCbgTrbLCv6iJ8MBi
 +Mn1IfeKtlMr3+q3dx3U0v+ztny2OiBkQAES5AW7S2qXwZkUMR5z4AvJh6aSh3Vnh+84gJk5Vif
 6PIhUaBc4NSM0/zPsW1DIdrRDo2KWlxVx09B4/nJXQetM4uKc7My+TnGcSNV1R4JqsbFEu7tLMv
 66dOpubGcfHOS8MgwicG9ZS/37pHskyQ4HLLQtqrwOJtBAdxzXlBS4CXLIA7TZQERSH0DEvt/L7
 qqc3zkNwOxHYDN8qU0TxFELe/GsJ0Kbv4Q16w+AVH6JMqT04Ilq1zTksJWMxSjDMOdXLoKKYTwW
 kJ5RVQcfFXQ==
X-Received: by 2002:a05:622a:1108:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-5360573c96fmr14813151cf.5.1791996097367; Wed, 14 Oct 2026
 09:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
 <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Oct 2026 09:41:25 -0700
X-Gm-Features: AclHuK8_g-YOJgMR77fEpf5RTsveF4u_ERdXz6lvoN6wh_uF7KP8ZsaUSV1ti8A
Message-ID: <CAP-5=fVLWh4uay2HGy6DOpZmtTr5WAd-TehAkN+P-pQgq_BZhg@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct
 kobj_type::release
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>,
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
> On Wed, Oct 14, 2026 at 07:36:41AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 13, 2026 at 03:39:35PM -0700, Ian Rogers wrote:
> > > Clang supports the 'require_explicit_initialization' attribute on str=
uct
> > > fields to enforce that the field is explicitly initialized when an
> > > aggregate object is constructed, emitting -Wuninitialized-explicit-in=
it
> > > (enabled by default) if the field is omitted.
> > >
> > > Following discussion at the Linux Plumbers Conference [1], this serie=
s
> > > introduces __require_explicit_initialization in
> > > include/linux/compiler_attributes.h and applies it to
> > > struct kobj_type::release.
> >
> > Cool, sorry I missed that talk.
>
> Yeah, I'm really liking these compile-time checks. :)
>
> >
> > > As Documentation/core-api/kobject.rst notes:
> > >   "One important point cannot be overstated: every kobject must have =
a
> > >   release() method, and the kobject must persist (in a consistent sta=
te)
> > >   until that method is called. If these constraints are not met, the =
code
> > >   is flawed."
> > >
> > > Annotating struct kobj_type::release caught 30 struct kobj_type
> > > definitions across the tree that omitted .release:
> > > - Patches 2-10 fix 10 struct kobj_type definitions where dynamically
> > >   allocated kobjects, ksets, or enclosing structures were either leak=
ed on
> > >   kobject_put() or freed prematurely before kobject release (risking =
a
> > >   use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=3Dy).
> > > - Patch 11 annotates struct kobj_type::release with
> > >   __require_explicit_initialization and explicitly sets .release =3D =
NULL
> > >   (with explanatory comments) on the remaining legacy struct kobj_typ=
e
> > >   definitions whose kobjects are static, per-CPU, or embedded in devm=
- or
> > >   parent-managed structures.
> >
> > Sounds great, but let's fix up the users before adding the attribute.
> > Looks like some of these need another version so it might take a bit of
> > time to get them all merged.
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

I'm happy with that. I'm working to address/incorporate the other
feedback for a v2 of this series, but I can drop individual patches
that have already been merged. Thanks, everyone, for the positive
reception in getting this landed, I plan to follow up with patch
series for the other uses I found.

Thanks!
Ian

> --
> Kees Cook
