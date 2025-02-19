Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E853C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 09:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08462892AA;
	Wed, 19 Feb 2025 09:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s4QJu6OX";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C5E892AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 09:49:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 8D4B1A41EF9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 09:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5D2C4CED1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739958551;
 bh=WiJtGyijnTolZiQAprxhjQpCNTmmPeAe/13v/bUoM0E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=s4QJu6OXnngrW9SavgZHOErIX8TbgDtfYiIkY3BVY9a0/VsGFXNRJr3zTN4ziVgx0
 n2UKkyr1w18onYbQkaQvct/ZjJhYv9lXyWQzMLuuzlQXuCQWAFzA6bIcc6Elcs0AaH
 5YR8PpDroGOCSjtgF9QQfO+85O1mjrpitfAGYs9g08VxKRmhfDx3RQ0OUgL+1KLqDE
 zFuBPw93R/Tyfp8lYT7FzAE1OyeQkH7XZ6Q+3vybfKe1ZazV0hG1fVINvk4oL8ybTX
 1dP+DOXynjAP/31nAFFz+KifLQy/zuFXYO5Z1OqYr1ivU+TjmLMu/7T9GntjQ5uL1Z
 qPfbeyHp893Hw==
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-ab744d5e567so125763366b.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 01:49:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXOc36DCXiCovXLNFKb66wE6EySyqdj1FIKINrLBO2huf8QA0EKEnAlGZrSvW5zrVRawCUK7/8q@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yza710RuFBx4PekGi+3mVp65xKaECVLKrU7lZql32DWWfnGSbRq
 8GFFqNIAbX1NnLlPPvlHPnWZxvXJQB44uEUfQtovu1eygUMP6Ww+a0fG6CJBaZGpiMfJmPVuyHY
 0knrbIpOHZWfS+tBlP32GhPVd8JM=
X-Google-Smtp-Source: AGHT+IHyn/QXaRB+dV33EFQe1SjGf1/yaS8648vX9OqMNYv+/PAWR6w/r4Lb7gWybn6Q0yovB9Qry8TtLZ74MONVR44=
X-Received: by 2002:a17:907:d48f:b0:abb:dbc2:bfb6 with SMTP id
 a640c23a62f3a-abbdbc2c5d4mr108949766b.10.1739958549626; Wed, 19 Feb 2025
 01:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn>
 <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
 <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
 <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
 <20250211233056.q47mp5askk7qrxcp@jpoimboe>
 <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>
 <20250213025108.svqgj5nzseqs6qox@jpoimboe>
 <CAAhV-H5mYGnxHPxAeXkHo2XBvi-RtPjDQRBnDiDyKVtFv-ZBBQ@mail.gmail.com>
 <20250218174632.gwseuvgezj7eni2j@jpoimboe>
In-Reply-To: <20250218174632.gwseuvgezj7eni2j@jpoimboe>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 19 Feb 2025 17:49:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Vwhsrp-y=pLa6xh=nVEOZy4wu2mPj00ES=OjsM7vruA@mail.gmail.com>
X-Gm-Features: AWEUYZkJg7i0Hi0dLJ-jmeSaIFLF4cxfJR3uG1xj_DycnwEjbfACIhG8y_rl1dY
Message-ID: <CAAhV-H4Vwhsrp-y=pLa6xh=nVEOZy4wu2mPj00ES=OjsM7vruA@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Peter Zijlstra <peterz@infradead.org>,
 loongarch@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Feb 19, 2025 at 1:46=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Mon, Feb 17, 2025 at 11:13:43AM +0800, Huacai Chen wrote:
> > On Thu, Feb 13, 2025 at 10:51=E2=80=AFAM Josh Poimboeuf <jpoimboe@kerne=
l.org> wrote:
> > >
> > > On Wed, Feb 12, 2025 at 03:22:45PM +0800, Huacai Chen wrote:
> > > > > The new series now has 7 patches:
> > > > >
> > > > > Tiezhu Yang (7):
> > > > >   objtool: Handle various symbol types of rodata
> > > > >   objtool: Handle different entry size of rodata
> > > > >   objtool: Handle PC relative relocation type
> > > > >   objtool/LoongArch: Add support for switch table
> > > > >   objtool/LoongArch: Add support for goto table
> > > > >   LoongArch: Enable jump table for objtool
> > > > >   LoongArch: Convert unreachable() to BUG()
> > > > >
> > > > > I was planning on queueing all 7.
> > > > >
> > > > > In particular, patch 6 should stay with the objtool patches since
> > > > > they're directly related.
> > > > >
> > > > > But I was also just going to grab 7 as well.
> > > > >
> > > > > Please let me know if you disagree.
> > > > What about you merge the first 5 patches, and then I merge the last=
 2
> > > > to the loongarch tree? (I prefer to merge the whole series to the
> > > > loongarch tree with your acked-by, but that may be inconvenient to
> > > > you).
> > >
> > > I want the first 5 patches to go through the -tip tree because we'll
> > > have other patches depending on them.
> > >
> > > I'll go ahead and take the first 5.
> > >
> > > If you take in patches 6 & 7 separately, that might introduce a lot o=
f
> > > warnings.  But it's up to you.
> > >
> > > For patches 6 & 7:
> > >
> > > Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > OK, please take the first 5 patches, I will merge your objtool/core to
> > the loongarch tree and then apply the last 2 to avoid build warnings.
>
> Looks like that's not going to work.  Without patch 7 I'm getting a
> warning (upgraded to a build error with a pending change to upgrade
> objtool warnings to errors):
>
> arch/loongarch/kernel/machine_kexec.o: error: objtool: kexec_reboot() fal=
ls through to next function crash_shutdown_secondary()
> arch/loongarch/kernel/machine_kexec.o: error: objtool:   kexec_reboot+0x1=
c: (branch)
> arch/loongarch/kernel/machine_kexec.o: error: objtool:   kexec_reboot+0x0=
: <=3D=3D=3D (sym)
> arch/loongarch/kernel/machine_kexec.o: error: objtool: 1 warning(s) upgra=
ded to errors
>
> And that would break bisection anyway, so that really needs to come
> before the others.
OK, then please take the whole series of V7, but please exchange the
order of Patch-6 and Patch-7 (I think the enablement should be the
last for bisection).
For V7: Acked-by: Huacai Chen <chenhuacai@loongson.cn>


Huacai

>
> --
> Josh
