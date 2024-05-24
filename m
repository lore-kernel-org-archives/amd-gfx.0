Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0791C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 13:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC0110E1FB;
	Fri, 24 May 2024 13:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bd1+U66G";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E4F10EAB7
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 13:18:48 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-681a4422f49so626113a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716556728; x=1717161528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZD5jP0xz4NBhWN8Zgsp2iFPrsWGp03cRwKrWdar1DE=;
 b=Bd1+U66GL3IQUw83WOnLmXLM4fu9nphKOPtTlpVD8iAPD4fplz4tf3nYS+r1vXvNJb
 FmmSnl0gwVZB46pu85I8aDx9457QMRqG9u4ag9QDU3xjJoqcOg9l1XfCdk9YxgD80fkt
 mTJ+3yDXbqzXCOYlEPT4lG2k5AZe4iZbWN04pIYUxyLW59HRx/SU0S53pD92UblOuleF
 Jj09hacl+7sQbKmD2c4HSlkQfUifazhhBu3yqjrG1UU/B0ND5Wl0wTzLaCsozt7C+Eiu
 46kKwApipGaTGmqoNI6YGZwScDyuww1bQHRB6mR9JtLU63RnES9R4YHDU5cg7FQ+MioZ
 jE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716556728; x=1717161528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZD5jP0xz4NBhWN8Zgsp2iFPrsWGp03cRwKrWdar1DE=;
 b=lh34UTtfLknzxFVovheRs6gxjjMadoEepZC36Hud+hpnQL3UIQibi6qFqWas9jldxM
 drpNmJ487+ZiA9fIDwVznbxndkHiATE7cdNWi8twt2vYqqoqYb6h3lrOAhFnNTr6VY62
 sfuW1FGplQAad174MPS4BRY39WlQIowmaNBF/vmjVZ82y3ovwbcpR8do/S37f5GyovIr
 n/qPw0V7kRMjHTNAAU9euO9vN5TvBpvjNRJDCQgTos4CbC9NW+M1ZiqC5LNhG7h19Q3Y
 tvxpCKUGVAVOZb6hVrcml4w6l8SYL+8rmuQdW/kCyPZetNtkHbDRA+B4Ubu8Yumlvt9i
 mPMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWldqrSMS5AE5ESHQo/cQPqg5C2KCRzDVi4LaETeyVB5FPkTaM0TcSST8ERYuNVxuy8hrMycW27Zf3u226ycqmOT7SaZkg5z2zgr6d6fg==
X-Gm-Message-State: AOJu0Yxhvm95dTPyI0Ay2rb4K/R14q3YRbFnsA9A4ank+Y3jt7IQo4lE
 h1SrWu2nZeGFKttgvpD9Z1uF70Z4L5zLL3HvgRyvPh4YFWbDCfuu1OkNufNTtEs7F5azmZMGGZN
 ULbDYBzWrSOx+vl9tnIgjWWWYYv0=
X-Google-Smtp-Source: AGHT+IE8pCp8W5E13VNHTBajd1iiFRN6k3JoN7VIxHp3GdM/LrEcuL4DsERnr62fGGcgTS9Bh/R3Y3m/qNihJWl6krM=
X-Received: by 2002:a17:90a:c394:b0:2ae:346d:47cc with SMTP id
 98e67ed59e1d1-2bf5f715486mr2416381a91.38.1716556727885; Fri, 24 May 2024
 06:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <eeffaec3-df63-4e55-ab7a-064a65c00efa@roeck-us.net>
 <CADnq5_NmKyTBbE6=V+XdEKStnjcyYSHyHqdkgBen4UhPnVKimQ@mail.gmail.com>
In-Reply-To: <CADnq5_NmKyTBbE6=V+XdEKStnjcyYSHyHqdkgBen4UhPnVKimQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 May 2024 09:18:36 -0400
Message-ID: <CADnq5_Ndzw5Gre=yyPKyFNX5yFWjTCMg2xqrn6tEj6h8t-nAYg@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Guenter Roeck <linux@roeck-us.net>
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Morton <akpm@linux-foundation.org>, 
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

On Fri, May 24, 2024 at 9:17=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Fri, May 24, 2024 at 5:16=E2=80=AFAM Guenter Roeck <linux@roeck-us.net=
> wrote:
> >
> > Hi,
> >
> > On Fri, Mar 29, 2024 at 12:18:28AM -0700, Samuel Holland wrote:
> > > Now that all previously-supported architectures select
> > > ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol inst=
ead
> > > of the existing list of architectures. It can also take advantage of =
the
> > > common kernel-mode FPU API and method of adjusting CFLAGS.
> > >
> > > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >
> > With this patch in the mainline kernel, I get the following build error
> > when trying to build powerpc:ppc32_allmodconfig.
> >
> > powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/displa=
y_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/amdgpu_=
dm/amdgpu_dm_helpers.o uses soft float
> > powerpc64-linux-ld: failed to merge target specific data of file driver=
s/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
> >
> > [ repeated many times ]
> >
> > The problem is no longer seen after reverting this patch.
>
> Should be fixed with this patch:
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/5f56be33f33dd1d50b943=
3f842c879a20dc00f5b
> Will pull it into my -fixes branch.
>

Nevermind, this is something else.

Alex


> Alex
>
> >
> > Guenter
