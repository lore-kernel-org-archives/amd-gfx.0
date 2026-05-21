Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C01CD6E4B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F9E10E57B;
	Tue, 26 May 2026 07:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lEiM8gWh";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B48210E410
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 12:01:20 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-bd01481e592so866378966b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 05:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779364879; cv=none;
 d=google.com; s=arc-20240605;
 b=HKu3jykMxSO2dYE7EF7yEXQOckUcbf1+hNvA55O0yJCW1y2/RCu0zp/EIxk0H2WAhx
 jnLL6rPrArVp8pyMjuFlznEJJa61SQ7Ih74ShdAz8OmUDmlj7tjgSk/kcjgE+6ChuDOi
 O02ZCKEIMQi59YNoD2iNfywFKA4Swuj7lDBB4o5Vo4fYSHUgjcWRyoFKNjQToESH1o1i
 Bh6IyUqMfBtD92tQtlycRSJZEI4us4+ae1Nq1HhWoMtToh8oq396YtrbORLUH63D8/mn
 A+FtwMjkGxXlO+KSlsY17Cg2Yn5gC9H72m4mUEqjwSB0nNe7kgo3dpyGELumc04ffLEo
 OBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N0WRCQ+KH01CpayEYyy7mrrqhMaV2Yzdg1bxdqWZuZw=;
 fh=x3MbhV0y/onqlSJqJVm4PAVIL+gLCDtYBd9uED7x/KI=;
 b=NNUADhJI94Svr0ZTKBdiS7HVbHiDDmYxlEd+03UpnfH5+tkVXFejf7AO7C7UxwTpAf
 W5ZJzvmaGVHPbC7ISIXxXVEVZ94vYm1iC3tT1y6qQBceDrhIp+Kmxso/n+vFR+SGfmxG
 UqSj/X/pukLJymQ5YX3FTsQbNOHZCzVIV9kAZMmueB1Fv/u143zZi/bODyJs1lhMYi+9
 iSeBHAE5JLvx9rQ4pb8ptZZK96ksjYx7F0e8dEU9XoZPelIfDWxmFxy0dQXM6k2ZleIG
 ProHWMevn/FR24pL8AW5B2pObjdvaL+Z3JJC5jouExTm+ytwVyhicP4VhKSNwSAz/qP/
 MoWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779364879; x=1779969679; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0WRCQ+KH01CpayEYyy7mrrqhMaV2Yzdg1bxdqWZuZw=;
 b=lEiM8gWhVP4eLbY3W6O5NraQyCnMxIA1Qd2K/Xy8m2TUhoh/fSuFK7nK/7zibjuBog
 n1oXUoiWUGSG6QVurgy2SpW2gJtkan26laD/mEA3R0DmnxtVqw4BQL8s9yIyQArYu73B
 2309gY5oIG8P2Y1eheYd5ven8JnQpUvRxCPkuIrgrb8LEtGhNvV7/BEyquWTW8qtveoo
 mziT/GcKxex2Q0Cckb7y3S5U6Ew0gDLm7HXq35HW+u+Int4On1KVNrslLG1LHOp7fzEY
 zne6aGY8SibzAOa88Q8Vucv0oAVdhKnmy3Qpx0WAbC/moym4TGOHk4F/CpA4yrU0aJ+9
 vbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779364879; x=1779969679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N0WRCQ+KH01CpayEYyy7mrrqhMaV2Yzdg1bxdqWZuZw=;
 b=YQiEsxziZtIa3O+a/KnR67Ld/hit6i9KpGb3CvPMHvHaiOZnEpMCDgEeOkgXl1RgTS
 /nXV2MvUlFGsPENSB8AO6l9Z/A6v/O9RSlPynPIChqAUerk7Rw+Sc1aO2OfJN1VjTZN0
 jA67iHki8CXS+EeFXoMG0uANsVrxgUNHDMMccQ2CR1NzLn9l5EvBIZYpKNS96EJQpzLi
 GVVb00peCagLjqhrbB5pQycc0NwkOqNEOsQlRpD8hPXoL7FiILbd8INpL+Pqc0W9Wf3+
 qFSMeCLORcG0ir/Iv83tRg+WbAHwZ1bl6ntZbmAszqgM7OlLWYjv9W9DTweDQoQUJ6dI
 36Cw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VIXw8hOhOxNdr0/3CaPQoZsJ+YsfCIQsjRdzvsGYhIJdxAq/KBNQf1q3qZjI7RQqr1A0UhUhD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFMVGyOAbNH9r7XF19b0SKIViHF/Rs+t7oBkSQ3kczWBELsN2U
 HvMw/zGBN7Onlw2OqsquoeahS0tdwe2GbZC4gGKOa16AG2xaNtdzfI08yS38FHg30edgRy5ZHDR
 kaFdXbPrLMmTsuz92eJBbatb3unEjwgs=
X-Gm-Gg: Acq92OE4BRlu6FALrvge40/CqUbbJ2knQBk6Ytg/LWzfo7oX7pUJD0ZVGuP0kPQNo3k
 kQ15Oc7KZWqMXudleh7RhwTCdgmWhXpQnFlgzZN0w9iGEv/UnZ6nX5pepwUfKU+gwwpZ6eZp6lU
 3KasTW2SmYDUoFgzs8wyaDAKxNEQeBG76nzojmPzf6DlncUKFHmQK5cqCADuZy7gkr47UGgaVf8
 IP8eB379yiQfj+bWMPvG6TYVGWowoylwJI1SWN7G2PhMrPu9SZOloUtuAx9qPBUGLdUWGCWZora
 7fwukyp85v49apClp3gSMq9P4jM7SMTER3Vvt5A=
X-Received: by 2002:a17:907:2845:b0:bdb:e19d:5257 with SMTP id
 a640c23a62f3a-bdc152607demr109803166b.29.1779364876921; Thu, 21 May 2026
 05:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260520225245.2962-1-spasswolf@web.de>
 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de> <878q9dvzh0.ffs@tglx>
 <50e5e76bc13256e3f5b3301e92f159957c3d6762.camel@web.de>
 <CAGudoHGk1CP3gRQLCV85AFHKx6vBEyKySOn4J+AZVAP2FkrN3g@mail.gmail.com>
 <70676dae700e6a40989315bf31ea269a509ddc0f.camel@web.de>
In-Reply-To: <70676dae700e6a40989315bf31ea269a509ddc0f.camel@web.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 May 2026 14:01:04 +0200
X-Gm-Features: AVHnY4Jlf-yrDim2uzOH0TXtokw0U7b4OPXVrImpSSlCPvkxIq7CNbdejhw5Too
Message-ID: <CAGudoHEX=Su_ehV8nNP_6Onfh=hB6uiyTTCojR7nSOkEj6zh4Q@mail.gmail.com>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
 viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 26 May 2026 07:53:08 +0000
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

On Thu, May 21, 2026 at 1:51=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
>
> >
> > Can you please do the following:
> > 1. go back to the known crashing-tag, add my fix, verify you still get
> > the amd splat and then try out the fix provided by Thomas
> > 2. regardless if the above helps, can you boot a kernel built with
> > CONFIG_KASAN=3Dy
> >
> > fwiw I verified my patch works fine with KASAN, including by
> > intentionally miscalculating the size of the target buffer and seeing
> > a nice splat from it so I'm confident I'm not corrupting anything.
> > However, as there are new mallocs + free flying around at early boot,
> > it is *plausible* amd was getting zeroed memory without asking for it
> > and it worked by accident.
>
> I think the warnning from amdgpu is only displayed with CONFIG_LOCKDEP=3D=
y, so
> your "improved fix" does not silence the warning from amdgpu.
>
> The additional fix from Thomas fixes the amdgpu warning.
>

I just wanted to confirm my patch does not *cause* issues, at worst
uncovers them.

> I also built the kernel with CONFIG_KASAN and get no error messages.
>

nice

I presume Thomas will handle getting the amdgpu patch to the right
people, I think it will be fine to drop all the mailing lists and the
cc's. :-)

So overall I think we are done here.

Thank you for testing and sorry for the breakage.
