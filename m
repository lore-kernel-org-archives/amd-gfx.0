Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329F7C54E68
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 09:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812D610F898;
	Tue, 19 Mar 2024 09:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W+YMLkNp";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 531AC10F25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 16:06:33 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-512bde3d197so3762255e87.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710777991; x=1711382791; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4BJ7HjPCjvvpEAf1eppVTHpsS5y7v9DKRUkirxYWlc=;
 b=W+YMLkNpMftuCcWLggzFXXf35DYpX37c9j7PGmKTbSlqlGpDTtujeBsFrC4IDKyqLX
 nSuxXEFC5HrDooU0fz97BFJ3qTZssEv8URSlf824RoCGMFJdd6eZCzcwDoKtH20pDoWw
 I8r9eGCVnpEf3Da0k16V5+WtgyovXz+oChDyyGFpeanQiQM//6/q/NwCHVU5l/tRy0mU
 hO73Xvbj/UaK4OMtl2WKvrhDLEcp20+pMKLR+yM6n1A+yXWCvhp/uRy/hYsfdw5LGBAw
 5fujkC8azzLJE4PVkjBVB1zfcyZ7Y73xhi2Ho34Iuc0eSPGsEX9OyJ/JU5e2uu05SGTh
 GvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710777991; x=1711382791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4BJ7HjPCjvvpEAf1eppVTHpsS5y7v9DKRUkirxYWlc=;
 b=AN8Ww1JecCIJTKNkFFixczsl9aOOcKIs4eqfstBJplKAmOFAPcFT1t0xTxgQMLCuGD
 ZajWiNxnFn3qeReIxCC98NhhyGNmpDFlwAg5TEHRQ7zoai9yccdIeyB8hSkgZNGlezaR
 AR9f9LhJtOxpHBvrXieWT0J7lo2mz8vdgTvBx13ARLBP3FusUSIu4KYWPUU9ofp1WlTv
 HqBf64gAKdV0RnrhbQp3tk1DRlkJLiC8ehQdT42WCQmG4Ynbbly8mdI+9K+h+LyXxk8k
 7FyDjbTp3dzfScMxGhJXLcFcIxLctDPY8e8B17hV4sTYQKJWfZKJixpu0Sg6U1reIIBA
 Sg/A==
X-Gm-Message-State: AOJu0YzmG1Ni8hSswXL2OeccTTYYUEt8R3rSLLzPu1BNsFYumbCIZtQt
 4YpK0EC4OIXxbq5oaXRybC181WAseQsUDGIK2tFC/d1UjA78r/oJHeN1XchdRTPkijAtnGp3dPM
 j+6lxs46zVLKbair29xgYcmdl4LpLXZUf2FA=
X-Google-Smtp-Source: AGHT+IFV5kzm56cczAZbIUNWmCLBBsDkKf5L2l/OaHPYJZ3pz0Qi+5KcWZD98MbXZzj+ooFUu3gDb3q6kRLNUePurzM=
X-Received: by 2002:ac2:5983:0:b0:513:c54d:7bd1 with SMTP id
 w3-20020ac25983000000b00513c54d7bd1mr8343124lfn.35.1710777990980; Mon, 18 Mar
 2024 09:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240318065211.11097-1-kkartaltepe@gmail.com>
 <CADnq5_MxfDSaOoD9J2DfdkM2wzX_HfRPkLv8CSSVPzJSKi1aUQ@mail.gmail.com>
 <CACawnnzv5Ro32h3wJ_5EQ=9k=b8mGA4FEGjXbWTUP-jdmWERBg@mail.gmail.com>
 <CADnq5_N4eZ9LbDRLwbAv0NVnmp1GrMwp+cDs4tP0FHwf1r7YRg@mail.gmail.com>
In-Reply-To: <CADnq5_N4eZ9LbDRLwbAv0NVnmp1GrMwp+cDs4tP0FHwf1r7YRg@mail.gmail.com>
From: Kurt Kartaltepe <kkartaltepe@gmail.com>
Date: Mon, 18 Mar 2024 09:06:19 -0700
Message-ID: <CACawnnz17jd4f+VrVhx5oH_DmOSb7jSLGZnmj0PcOZeQ+=UD5A@mail.gmail.com>
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

On Mon, Mar 18, 2024 at 8:42=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Mon, Mar 18, 2024 at 10:19=E2=80=AFAM Kurt Kartaltepe <kkartaltepe@gma=
il.com> wrote:
> >
> > On Mon, Mar 18, 2024 at 6:37=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Mon, Mar 18, 2024 at 4:47=E2=80=AFAM Kurt Kartaltepe <kkartaltepe@=
gmail.com> wrote:
> > > >
> > > > These checks prevent using amdgpu with the pcie=3Dassign-busses par=
ameter
> > > > which will re-address devices from their acpi values.
> > > >
> > > > Signed-off-by: Kurt Kartaltepe <kkartaltepe@gmail.com>
> > >
> > > This will likely break multi-GPU functionality.  The BDF values are
> > > how the sbios/driver differentiates between the VFCT images.  If you
> > > have multiple GPUs in the system, the driver won't be able to figure
> > > out which one goes with which GPU an you may end up assigning the
> > > wrong image to the wrong device.
> > >
> > > Alex
> >
> > The vendor and device portions must be correct in the existing
> > kernels, so device type differentiation should already work without
> > BDF values.
> >
> > So does that mean the concern is images are different for devices with
> > the same vendor:device pairs? There are sites out there dedicated to
> > dumping AMD's video roms which seem to suggest all discrete devices
> > would be fine loading the same rom. Is there another platform you are
> > thinking of where devices with the same vendor:device values would
> > need different images?
>
> That is incorrect.  The vbios images are board specific.  Using the
> wrong image can cause a lot of problems.  The vbios exists to handle
> board specific design variations (e.g., the number and type of display
> connectors, the i2c/aux channel mappings, board specific clock and
> voltage settings, etc.).  The PCI DID just indicates the chip used on
> the board.  The actual board design varies with each AIB vendor (e.g.,
> Sapphire and XFX both make 7900XTX boards, but they can have very
> different configurations.

Thanks for the explanation, that makes sense.

Is my understanding correct that IGPUs (my case) simply won't have
vbios available in any other mechanism. If so perhaps this isnt
feasible in amdgpu as the BDF information is lost in reassignment.

--Kurt Kartaltepe
