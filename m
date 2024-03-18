Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CDCC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 19:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C33B10F895;
	Mon, 18 Mar 2024 19:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MM4u+VQY";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E4F10F895
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 19:52:58 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-29de4e12d12so3312238a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710791577; x=1711396377; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8W+cRZjxh6mwLG/if9OMCSZCsuHDvdTjytzwkWY3o6E=;
 b=MM4u+VQYmHlJJYcQkqykgl62579W/jJTtfKy8cNL/y1qjmKxPUrNR1Oxy/W+LPKBU/
 GMiGTdRBGDWXBjuPcCG8I7zkgHjAZWeOBMQlpC1y2qqLfnFpflJvfxP4FFUDadcuQOjU
 gJxGy60lI953F38fjfu+7KKxDg1t4MFN+kZK7/LSGf0bcGKxS6JJWl/QBwLn53wh++LV
 t7Cfjxi3soeRTtJ67zxQRt9ZXeB8hL3T0hxIfpUioc8fFHFsWr40pPdEo36AQqDVxIQ6
 vs2n2wJ/GhSry7Xwpqf81LlUAh74n9/FWMv/9mBaPQIhL2zavkVcBbYKo5IDtRr6aX+L
 f/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710791577; x=1711396377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8W+cRZjxh6mwLG/if9OMCSZCsuHDvdTjytzwkWY3o6E=;
 b=rnu5f2dw4hQSNMRQzhrnI7Onwp1+upiUMobDjrFqLibC5n/tIOrIPY1+HhsUKtXo+f
 gtVRydJwdCUMXMAqQ9FMsUSpxcbj5UiStDId66BBpS9k2rDO0ASoEykyl651VIggMBx1
 NzG9R2DcqKUBCZ6ojeI6/Lgq7PI4zZzs1KNS0z7/NaCnM8JLMGsi5ar6Kk6AK0wnC6QJ
 9wf3DZoRYTx9tOtQ6bSd9cHCNkECL/VwVpbV6Rlq5vAFQm5VWdFeRS2e3bdJbVWIucGY
 M92pASl9tzxzuKTvNp1+icvXeoO9tGvUOqHt4ht5HrKwdKRGQ6ldrUacHSRmon6A8VBi
 gCxg==
X-Gm-Message-State: AOJu0YzHJtmgNC31ExE2Su9zbGNHpJD/8iaOGsDSm+4wcJHak3nfJzgB
 Mbgu5yFFLHMZRz1WW01X3DHRRmqbX1rE18qqidt9nrOANGcKV6hvSX2pkYrZtrY8otfAb94eZIA
 +UYjF3q6tkuk7eK55+WRbqugSr/VSvyO5
X-Google-Smtp-Source: AGHT+IEKeGsvxVPip0hf5cZhD8oEFugbkPB3iUJCIX7ObW00AU3Z8Nsq7qru4GTcInNY7PsEJDEobzJY10hcaab24Fg=
X-Received: by 2002:a17:90a:3ec7:b0:29b:10bc:acaf with SMTP id
 k65-20020a17090a3ec700b0029b10bcacafmr8264922pjc.30.1710791577426; Mon, 18
 Mar 2024 12:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240318065211.11097-1-kkartaltepe@gmail.com>
 <CADnq5_MxfDSaOoD9J2DfdkM2wzX_HfRPkLv8CSSVPzJSKi1aUQ@mail.gmail.com>
 <CACawnnzv5Ro32h3wJ_5EQ=9k=b8mGA4FEGjXbWTUP-jdmWERBg@mail.gmail.com>
 <CADnq5_N4eZ9LbDRLwbAv0NVnmp1GrMwp+cDs4tP0FHwf1r7YRg@mail.gmail.com>
 <CACawnnz17jd4f+VrVhx5oH_DmOSb7jSLGZnmj0PcOZeQ+=UD5A@mail.gmail.com>
In-Reply-To: <CACawnnz17jd4f+VrVhx5oH_DmOSb7jSLGZnmj0PcOZeQ+=UD5A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Mar 2024 15:52:45 -0400
Message-ID: <CADnq5_Mj_9=hBC47K5urr5VLTiaUQsv1Lib0uPTq8-XGSDh-tw@mail.gmail.com>
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

On Mon, Mar 18, 2024 at 12:06=E2=80=AFPM Kurt Kartaltepe <kkartaltepe@gmail=
.com> wrote:
>
> On Mon, Mar 18, 2024 at 8:42=E2=80=AFAM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Mon, Mar 18, 2024 at 10:19=E2=80=AFAM Kurt Kartaltepe <kkartaltepe@g=
mail.com> wrote:
> > >
> > > On Mon, Mar 18, 2024 at 6:37=E2=80=AFAM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> > > >
> > > > On Mon, Mar 18, 2024 at 4:47=E2=80=AFAM Kurt Kartaltepe <kkartaltep=
e@gmail.com> wrote:
> > > > >
> > > > > These checks prevent using amdgpu with the pcie=3Dassign-busses p=
arameter
> > > > > which will re-address devices from their acpi values.
> > > > >
> > > > > Signed-off-by: Kurt Kartaltepe <kkartaltepe@gmail.com>
> > > >
> > > > This will likely break multi-GPU functionality.  The BDF values are
> > > > how the sbios/driver differentiates between the VFCT images.  If yo=
u
> > > > have multiple GPUs in the system, the driver won't be able to figur=
e
> > > > out which one goes with which GPU an you may end up assigning the
> > > > wrong image to the wrong device.
> > > >
> > > > Alex
> > >
> > > The vendor and device portions must be correct in the existing
> > > kernels, so device type differentiation should already work without
> > > BDF values.
> > >
> > > So does that mean the concern is images are different for devices wit=
h
> > > the same vendor:device pairs? There are sites out there dedicated to
> > > dumping AMD's video roms which seem to suggest all discrete devices
> > > would be fine loading the same rom. Is there another platform you are
> > > thinking of where devices with the same vendor:device values would
> > > need different images?
> >
> > That is incorrect.  The vbios images are board specific.  Using the
> > wrong image can cause a lot of problems.  The vbios exists to handle
> > board specific design variations (e.g., the number and type of display
> > connectors, the i2c/aux channel mappings, board specific clock and
> > voltage settings, etc.).  The PCI DID just indicates the chip used on
> > the board.  The actual board design varies with each AIB vendor (e.g.,
> > Sapphire and XFX both make 7900XTX boards, but they can have very
> > different configurations.
>
> Thanks for the explanation, that makes sense.
>
> Is my understanding correct that IGPUs (my case) simply won't have
> vbios available in any other mechanism. If so perhaps this isnt
> feasible in amdgpu as the BDF information is lost in reassignment.

Depends on the platform, but recent ones use VFCT.  That said, there
should only ever be one IGPU in the system so I think we could just
rely on the VID and DID for APUs in this case and check everything for
dGPUs.

Alex
