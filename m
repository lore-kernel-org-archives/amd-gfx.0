Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C419C54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 09:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF6610F88F;
	Tue, 19 Mar 2024 09:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XDBMXUk8";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD8010F58A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 14:19:35 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-513d717269fso4389222e87.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710771574; x=1711376374; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76jK/ARKKeFVpWmJze+n0eS6xxzaNLiSycBwOm9i61s=;
 b=XDBMXUk8t2VggObzcoj0tGr2ZWzQ2joJ9MFSQVy0Hrtp9cF48P3UcXiG7lnhsSmKvz
 baiu+0EbsvfdaQQbOIFal+clShlY90AcTgy2AxpyqkDUBi5YDSQ48rt+RKgJEvWGrjA1
 ffgyikvzYga9M3maGrV7Q4I9LErqt1GQ1up6a/bTpEJivJ/D0Oscu5mvOfEnL9o8xe2B
 D76WjHhepFo+j28zyAD1RrdNCw/l3/ex/Z6YBC6ZWinKsNhLQ8JCEnNvI/vV/4BZ2ct6
 HESxJZ8Lf8jFJQ7eZFuCWKlDY4e3Yi6MP9mGsyM3hvlX36DTjxSjTLZhBKEe8ucC/lZN
 oH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710771574; x=1711376374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76jK/ARKKeFVpWmJze+n0eS6xxzaNLiSycBwOm9i61s=;
 b=Gsv7PhGgotBKGs/U7aC48M67QffyRtkwd87MSAivCnACvu4qoEj6xt1HHG+IRLNQd7
 7QPycNBZmdTWbNJhd8xLnMxbhtIV0mGrfPfQMBW6qADw/9vx2lWr9xrcCnknKvzZmX7+
 y0qe4hqqcF2326Zh4z34Pev0piZmkT2mBTZ8Co4ZXR7qLAk1h1uZjtgCBzyRyeFI/0Tj
 h+TbqzbrlqhYhFaALWns81ztXSft6j6xmGJfnUMgDQ7WVZi6HPtYhI+XekBOWXEl8I5y
 k3s7Up82/cQo1OlAz7SpzbIJdrsHzIeb9oD04jxXhygvbtQL9L5eDygysigQJQiE9yz/
 Okeg==
X-Gm-Message-State: AOJu0Yw28hi/kXH2Kjc1H+D6P8lXixuLvDQbLybXH2AB0w32Nrpdpxul
 PvQtJ6jsAx6sT9fsff960BijkPHtHy7Wr+r40Z3quG73yb2gDQ3nNVme+Yk8VZbu0h9rHT/l5f4
 YqE/XcPWIO362noQg6LV+4haCWBc=
X-Google-Smtp-Source: AGHT+IHBS2/ts9lWGbTLTSENq3NYJ/7+kwHZdgTe8sxrHSUGlm6Q7XH10Z1TaEfPAUlQsivDAbxVVFT93HvXZutpzhA=
X-Received: by 2002:a05:6512:473:b0:513:da61:9b46 with SMTP id
 x19-20020a056512047300b00513da619b46mr6173158lfd.53.1710771573371; Mon, 18
 Mar 2024 07:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240318065211.11097-1-kkartaltepe@gmail.com>
 <CADnq5_MxfDSaOoD9J2DfdkM2wzX_HfRPkLv8CSSVPzJSKi1aUQ@mail.gmail.com>
In-Reply-To: <CADnq5_MxfDSaOoD9J2DfdkM2wzX_HfRPkLv8CSSVPzJSKi1aUQ@mail.gmail.com>
From: Kurt Kartaltepe <kkartaltepe@gmail.com>
Date: Mon, 18 Mar 2024 07:19:21 -0700
Message-ID: <CACawnnzv5Ro32h3wJ_5EQ=9k=b8mGA4FEGjXbWTUP-jdmWERBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove pci address checks from acpi_vfct_bios
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 19 Mar 2024 09:00:19 +0000
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

On Mon, Mar 18, 2024 at 6:37=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Mon, Mar 18, 2024 at 4:47=E2=80=AFAM Kurt Kartaltepe <kkartaltepe@gmai=
l.com> wrote:
> >
> > These checks prevent using amdgpu with the pcie=3Dassign-busses paramet=
er
> > which will re-address devices from their acpi values.
> >
> > Signed-off-by: Kurt Kartaltepe <kkartaltepe@gmail.com>
>
> This will likely break multi-GPU functionality.  The BDF values are
> how the sbios/driver differentiates between the VFCT images.  If you
> have multiple GPUs in the system, the driver won't be able to figure
> out which one goes with which GPU an you may end up assigning the
> wrong image to the wrong device.
>
> Alex

The vendor and device portions must be correct in the existing
kernels, so device type differentiation should already work without
BDF values.

So does that mean the concern is images are different for devices with
the same vendor:device pairs? There are sites out there dedicated to
dumping AMD's video roms which seem to suggest all discrete devices
would be fine loading the same rom. Is there another platform you are
thinking of where devices with the same vendor:device values would
need different images?

(Sorry this is my first patch to the mailing list and I am replying
with gmail, I hope it doesnt break things).

--Kurt Kartaltepe
