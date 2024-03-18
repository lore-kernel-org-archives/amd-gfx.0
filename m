Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6B0C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 19:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3110810E471;
	Mon, 18 Mar 2024 19:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MpmUVzVx";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3120C10E471
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 19:57:34 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-29df0ca87d1so3061888a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710791853; x=1711396653; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QGIqKIf5xy9ynvKu1NEI7crP+xVez3/7TEEn05YdgY=;
 b=MpmUVzVxWLUtCZNlFZqVSooh/inDj845+MZ2mWeLRw9hW/SYqSv1NRkX6HB5joBOmH
 4OoET1pbTW3UB5Dw3BtHL09AFa1WSOhVX30JkGiRqwpRES5BL7WtlfTn00W7aF31BAev
 L2iB8l76193isi/I/aVdtSq+T2Vkb5QpxAINXBf9d8Np2Lr/jhapUfE004DbavYMa/m4
 efzpEXK4yYn5BhMnF7XydGKMoLge165MsRooykHIY/C515ANIdvsvCSMWIEoX/WLltsK
 QcKgJqjo5j5DELERcZstsq4clXjaH8YTvhppilSL1qYbg7+fjujOuAApP33prjEeUi0O
 JanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710791853; x=1711396653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0QGIqKIf5xy9ynvKu1NEI7crP+xVez3/7TEEn05YdgY=;
 b=EBChxsfN9pFVinMqYvu9dtEAwrgTmFGqHASWcS484X+aYQ2MmzV0HiHpAWL6drWb95
 LtmfkO7iRkNgN7aBd57IuomfYlp4cffAcOSfv8p0OsqGKwtbUp4M259r6Uo3PazyfTLB
 FPVDLj7NlQjrVUkbFJqF185uaTBucwkFc5888zs/p31yi3JAVuV1p725RcVPyTH7QZhZ
 kd1E4+POBHPw+k+KLif61WR/Zak/2vjZiLrFrNx35vgWC3ictImZ93SUqzJ8CzdzvFC7
 IiYv0+DFJqlo2nG3XcJoC547bggQfnqMo7J0yFCgVrMafL5xgK5MQs/nFySe7SfUUVq1
 Wc8g==
X-Gm-Message-State: AOJu0YwNWxCVR8Qnk2HPCJC9V+bvMEzCrpggoFwBjwClEPw1wSH6+OAC
 JwqSgoz+mHNdoBg2otQN4GVC4ccCAi6ZgGV3T9PI2R6s9fNA2rBwMY9EaHN7fL1qOSDJDP/wsJW
 epNftoT0SpsVrE5nNcEDEeqaxJIX4tNP6
X-Google-Smtp-Source: AGHT+IHBnyuTmZYf2KDWHgbaXbb5GyKHgvFkAMgKDATYJVcLDfFDp/HEBdjKchN846P6gjKBS4hw7gkWwzTVzHk2ZTs=
X-Received: by 2002:a17:90a:fb4b:b0:29b:f928:68fb with SMTP id
 iq11-20020a17090afb4b00b0029bf92868fbmr10769885pjb.26.1710791853557; Mon, 18
 Mar 2024 12:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240318065211.11097-1-kkartaltepe@gmail.com>
 <CADnq5_MxfDSaOoD9J2DfdkM2wzX_HfRPkLv8CSSVPzJSKi1aUQ@mail.gmail.com>
 <CACawnnzv5Ro32h3wJ_5EQ=9k=b8mGA4FEGjXbWTUP-jdmWERBg@mail.gmail.com>
 <CADnq5_N4eZ9LbDRLwbAv0NVnmp1GrMwp+cDs4tP0FHwf1r7YRg@mail.gmail.com>
 <CACawnnz17jd4f+VrVhx5oH_DmOSb7jSLGZnmj0PcOZeQ+=UD5A@mail.gmail.com>
 <CADnq5_Mj_9=hBC47K5urr5VLTiaUQsv1Lib0uPTq8-XGSDh-tw@mail.gmail.com>
In-Reply-To: <CADnq5_Mj_9=hBC47K5urr5VLTiaUQsv1Lib0uPTq8-XGSDh-tw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Mar 2024 15:57:21 -0400
Message-ID: <CADnq5_OtProx-8d_0epm9TrYtE_rHLYDhEb6XrK9bgOPi7MicQ@mail.gmail.com>
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

On Mon, Mar 18, 2024 at 3:52=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Mon, Mar 18, 2024 at 12:06=E2=80=AFPM Kurt Kartaltepe <kkartaltepe@gma=
il.com> wrote:
> >
> > On Mon, Mar 18, 2024 at 8:42=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Mon, Mar 18, 2024 at 10:19=E2=80=AFAM Kurt Kartaltepe <kkartaltepe=
@gmail.com> wrote:
> > > >
> > > > On Mon, Mar 18, 2024 at 6:37=E2=80=AFAM Alex Deucher <alexdeucher@g=
mail.com> wrote:
> > > > >
> > > > > On Mon, Mar 18, 2024 at 4:47=E2=80=AFAM Kurt Kartaltepe <kkartalt=
epe@gmail.com> wrote:
> > > > > >
> > > > > > These checks prevent using amdgpu with the pcie=3Dassign-busses=
 parameter
> > > > > > which will re-address devices from their acpi values.
> > > > > >
> > > > > > Signed-off-by: Kurt Kartaltepe <kkartaltepe@gmail.com>
> > > > >
> > > > > This will likely break multi-GPU functionality.  The BDF values a=
re
> > > > > how the sbios/driver differentiates between the VFCT images.  If =
you
> > > > > have multiple GPUs in the system, the driver won't be able to fig=
ure
> > > > > out which one goes with which GPU an you may end up assigning the
> > > > > wrong image to the wrong device.
> > > > >
> > > > > Alex
> > > >
> > > > The vendor and device portions must be correct in the existing
> > > > kernels, so device type differentiation should already work without
> > > > BDF values.
> > > >
> > > > So does that mean the concern is images are different for devices w=
ith
> > > > the same vendor:device pairs? There are sites out there dedicated t=
o
> > > > dumping AMD's video roms which seem to suggest all discrete devices
> > > > would be fine loading the same rom. Is there another platform you a=
re
> > > > thinking of where devices with the same vendor:device values would
> > > > need different images?
> > >
> > > That is incorrect.  The vbios images are board specific.  Using the
> > > wrong image can cause a lot of problems.  The vbios exists to handle
> > > board specific design variations (e.g., the number and type of displa=
y
> > > connectors, the i2c/aux channel mappings, board specific clock and
> > > voltage settings, etc.).  The PCI DID just indicates the chip used on
> > > the board.  The actual board design varies with each AIB vendor (e.g.=
,
> > > Sapphire and XFX both make 7900XTX boards, but they can have very
> > > different configurations.
> >
> > Thanks for the explanation, that makes sense.
> >
> > Is my understanding correct that IGPUs (my case) simply won't have
> > vbios available in any other mechanism. If so perhaps this isnt
> > feasible in amdgpu as the BDF information is lost in reassignment.
>
> Depends on the platform, but recent ones use VFCT.  That said, there
> should only ever be one IGPU in the system so I think we could just
> rely on the VID and DID for APUs in this case and check everything for
> dGPUs.

Is there a reason why you need this option?  Even beyond this, I could
envision other problems related to APUs and ACPI if these changed.

Alex
