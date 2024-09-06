Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F13E6FE41
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 18:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C12E10EAE1;
	Fri,  6 Sep 2024 18:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hOER9/GN";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8527710EAE3
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 18:51:29 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-53658e2d828so189994e87.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Sep 2024 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725648687; x=1726253487; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRkzaF+INMGyNgh8kxikeSbP2MwJGClbp9spCWx4ZwQ=;
 b=hOER9/GNKI2ofUeOcXDvVP8GNTYiUUJDX1OgnyhkmseCgJAGm0MmLRLV7iKbI+bdGm
 MslQQ7CmmeG6enJgzw0PMtidZG7+tsvPiT2WiRrHMzWxnJ7MgToDcYzyzgVEcW2EOe70
 JwE/QKGoLjB0L6l18rnwtaXxJEdLJS6ju/2cn3mxzG3TO/pTX+ygzsTHeOywS3xixqne
 xi3qIRlIlFBm2XW9h+2GD+iSRuZQUnUt0/253Ukitq1CkCoRq54p65o/kVitIO2ZTV0Y
 /q8AZGJeyO9jzaKGJ5ocFIoB1NzOy/ndgzi9b6q2VcV8RA4woXNeEp+r9fs93TlupqYp
 Tgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725648687; x=1726253487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRkzaF+INMGyNgh8kxikeSbP2MwJGClbp9spCWx4ZwQ=;
 b=dHRVGMtRN6gnMU9j/4rxRfIzmeSSgorSFHuDys7X1usYr0trtx7bBDPr55VFA199KM
 x4JNdCC4ZLesv97jcobGOmixXXrWvtiB4eovpabqLZ3MeFu+M7AyGPJDc/7G9ObMnlL6
 JguVUbIHhCA1G2IrqS1bpNOgFy/6abvkYF0NT4z3BZuFuZwHVpOqFjn4Ukt2PppNEkz7
 p8VR0TD0qIZS3UGolWoCexrrNa932khcTvNimpkPF9P8B64EBSPpD3AJRSoBHNZc4cTn
 YEo+FQS5w5NJmJlKcISIK+DWuJljwJo4ODExJLSbCZqEJOrGdFkngQsSH3ERdpyA8eVw
 A72g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCTy2wAliH3alu2wX3dguCC0nz0RWJJKX7+xZI7S2j23ovFQNelqi/VHzFK5ArXL7LSzb2y5P8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwE3ljHUWo2pjfYnfzlL4QstfIkxSyy56oNtvzdwfeHxCJd//gA
 3qrxXzX1QnsHVnb9iut+DbdaWjZNNN8s93VNF+gb3imcdffQu0XU+rJQHRHP1bxeETJa4KR9SA1
 MxpnJlB6mnOolstVNSZz4z2RGzV8IPA==
X-Google-Smtp-Source: AGHT+IEpmIsGdb1w2p2DQJTo/LgAG0EDJ3Tp4hEz8QsUx3ziceH2DzFKyIfesw+2D19sKaaSagew10vZ47xhhHunINs=
X-Received: by 2002:a05:6512:3ba4:b0:535:4144:d785 with SMTP id
 2adb3069b0e04-5365881cf56mr1291408e87.11.1725648687124; Fri, 06 Sep 2024
 11:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240829172645.1678920-1-alexander.deucher@amd.com>
 <c52a3df8-dcad-4fc7-8051-b8a05e1b49f2@amd.com>
 <CAAxE2A6HqOqx3jYkGDtHYd=NRSWY__+JYE6enF=skcpwYBtYhQ@mail.gmail.com>
 <CADnq5_MqtR9govD=dyWt79Roit8n4danMNJVQYUo6Sg0TD=y3Q@mail.gmail.com>
In-Reply-To: <CADnq5_MqtR9govD=dyWt79Roit8n4danMNJVQYUo6Sg0TD=y3Q@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 6 Sep 2024 14:50:50 -0400
Message-ID: <CAAxE2A4DWxbRdVthZVLtGAkgggctXrj9x5G=b4Dn16u=tu0wEw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM
 allocations
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Fri, Sep 6, 2024 at 1:53=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Fri, Sep 6, 2024 at 10:18=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gma=
il.com> wrote:
> >
> > Can you also bump the DRM version, so that userspace knows when to
> > skip its own clear?
>
> Sure, although going forward, it might be better to migrate to a
> generic flags query in the INFO ioctl so we can just check for various
> feature bits so we can backport functionality to older kernels more
> easily.

How it's exposed is up to you.

Marek
