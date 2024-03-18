Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6A8C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 15:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E32D710EC42;
	Mon, 18 Mar 2024 15:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TpHloNaK";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A817710FB12
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 15:42:17 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so2859073a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776537; x=1711381337; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNMID9rIAjtiYdFfLqmjnw8pXYyoO6P4SV2c34sS1Uw=;
 b=TpHloNaKYy4L+DMOTqy9NUINDqzMyOzAV1PzvBN3ZymuAN6z/PW545/ZaGHM8cZxbB
 eLeOq/cXnuCllgVI1rE9nPHBpDbMMk3PIOdOhZrsVm5bGGqkO5TMsfkWMYPt7NV/gnQJ
 chn9RDwvYW4p+gVePKfe559rfxfo4EZxfgWuHo/hxAuC5jOn/b7MdDi3wjPRX9UiuCqn
 /FwB7nR/Qt7cgbxR5g10y1z6EyjgbHczQ1S2D8Yggt49wNk89g4VOg4XpaN6z9N01OLl
 LUcb8Kq8ApHYtu4B/jLnw2mMSl+XsQrceF9y9ugBxd1wgff8VlkTNErJ+WBNk/nMudOa
 ESfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776537; x=1711381337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNMID9rIAjtiYdFfLqmjnw8pXYyoO6P4SV2c34sS1Uw=;
 b=oShaGt5tRbX9f52/nGuI2XNa7lGCmEv3osJzhrwsBwKm39pfDBf9Ws7DoxQOAVb4cP
 4QanyApFpbCYnH4axcRebYX2Oa0/rei/EZqk5FcXo4zuEhYx+02ydR7DzCsEblCeSHbD
 mCtvakr+WliE6SX7BPgdOvCsaJawxjN+hK/Gm8zHQZJDV6LPYqCY1Q/bYdIWzd98NZzZ
 QBhI+XnZq0CqJMaOHDDrgbcaNvaRuBtGSqIe7Vg2GzT+S74XS0bU41VO2RpFxpHaLlHD
 99rCSpZKcJIG6NjPers86xwTjpEWq58AL7/PjSdfIDzV01WiSZnqDB/8LroiETE2cKOk
 lqNQ==
X-Gm-Message-State: AOJu0YxysXXT+a1lH9UlTZHbmmufTjJzcWVxgUcCDMrFcZzc7IlB8d0x
 QCJPbW8Ypl7kXd9ym/OjnWtOp5KZDZX/rqgIbl3M9FtHoqiOnK/HxZxgkSa325AVUfQtN7iKKgv
 34FBppFVtC/yHX8Iemb3k2iBPEvg=
X-Google-Smtp-Source: AGHT+IH8aBHSH0gwfvepC5GfKjgZH85XumtoC/OnHuTgrt4mBqtmVjmQ1Ng4KUc2r7lL6SYTEruKdhF8OcrwJNul6CU=
X-Received: by 2002:a17:90a:8006:b0:29c:e2b:ace8 with SMTP id
 b6-20020a17090a800600b0029c0e2bace8mr9812346pjn.35.1710776536976; Mon, 18 Mar
 2024 08:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240318065211.11097-1-kkartaltepe@gmail.com>
 <CADnq5_MxfDSaOoD9J2DfdkM2wzX_HfRPkLv8CSSVPzJSKi1aUQ@mail.gmail.com>
 <CACawnnzv5Ro32h3wJ_5EQ=9k=b8mGA4FEGjXbWTUP-jdmWERBg@mail.gmail.com>
In-Reply-To: <CACawnnzv5Ro32h3wJ_5EQ=9k=b8mGA4FEGjXbWTUP-jdmWERBg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Mar 2024 11:42:04 -0400
Message-ID: <CADnq5_N4eZ9LbDRLwbAv0NVnmp1GrMwp+cDs4tP0FHwf1r7YRg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove pci address checks from acpi_vfct_bios
To: Kurt Kartaltepe <kkartaltepe@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Mar 18, 2024 at 10:19=E2=80=AFAM Kurt Kartaltepe <kkartaltepe@gmail=
.com> wrote:
>
> On Mon, Mar 18, 2024 at 6:37=E2=80=AFAM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Mon, Mar 18, 2024 at 4:47=E2=80=AFAM Kurt Kartaltepe <kkartaltepe@gm=
ail.com> wrote:
> > >
> > > These checks prevent using amdgpu with the pcie=3Dassign-busses param=
eter
> > > which will re-address devices from their acpi values.
> > >
> > > Signed-off-by: Kurt Kartaltepe <kkartaltepe@gmail.com>
> >
> > This will likely break multi-GPU functionality.  The BDF values are
> > how the sbios/driver differentiates between the VFCT images.  If you
> > have multiple GPUs in the system, the driver won't be able to figure
> > out which one goes with which GPU an you may end up assigning the
> > wrong image to the wrong device.
> >
> > Alex
>
> The vendor and device portions must be correct in the existing
> kernels, so device type differentiation should already work without
> BDF values.
>
> So does that mean the concern is images are different for devices with
> the same vendor:device pairs? There are sites out there dedicated to
> dumping AMD's video roms which seem to suggest all discrete devices
> would be fine loading the same rom. Is there another platform you are
> thinking of where devices with the same vendor:device values would
> need different images?

That is incorrect.  The vbios images are board specific.  Using the
wrong image can cause a lot of problems.  The vbios exists to handle
board specific design variations (e.g., the number and type of display
connectors, the i2c/aux channel mappings, board specific clock and
voltage settings, etc.).  The PCI DID just indicates the chip used on
the board.  The actual board design varies with each AIB vendor (e.g.,
Sapphire and XFX both make 7900XTX boards, but they can have very
different configurations.

Alex

>
> (Sorry this is my first patch to the mailing list and I am replying
> with gmail, I hope it doesnt break things).
>
> --Kurt Kartaltepe
