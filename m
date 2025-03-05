Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BCCC19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 18:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D30610E028;
	Wed,  5 Mar 2025 18:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DaBXiHEn";
	dkim-atps=neutral
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6268510E028
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 18:04:10 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-86c29c0acdfso229076241.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Mar 2025 10:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741197849; x=1741802649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uTquZMRhy0qdPa8LAFerUZ10kaLangBgxUM7aKFSkg=;
 b=DaBXiHEn54nrulM3iasPBQT1sSgmxJtCkMKDjJWGe+ZjuMjmQ6ZwJG3sGCw8QitRRZ
 LQRRIHYPlwJ2bHG2z0Bejg9XE73k4hUA/xhMMDUGIs2kLRx/cF9+kgUHJgXWYrIV0op9
 BOclNLkQfO9rVvMArq+4jmuPMipjItIZkqe4bKI5m28jkcd4Xa1F6ajBDqIGksSgsVbn
 3JjRemlw6E6Z1VDAMl809u8Fv3citl0wCIxDR1R8eDD76LVqXnS7W+N18KtKXw+l8pbA
 hJxFJGTjgAGWjyCCcC0n1pasUdZQgVz+KtizL8yrGE/f6FeY8qwBVbVgVemkEd9R/Fll
 3jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741197849; x=1741802649;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4uTquZMRhy0qdPa8LAFerUZ10kaLangBgxUM7aKFSkg=;
 b=DNOstTweNUiY8uS29FGqZzyKqBUnd3QMqfK2t9Dk6ELbPrEhxHiJ5+QTCYLL78D1jV
 G8OeapwLNujJu8YpkfCxV04M74gEisYrET8alIuCCcJrWPfGWNmEZPb8omDpwFMrLlig
 Q359ITaTbnt1kx58NM/N3EYs/25fZ0K61w0CXVCZwUIyQD29qArEZxzXUODoJs39EMYM
 VClurXx0qr2A34c6XmhRJ7IDmi18ENQsdFyS+ZAszfAiFBxcEtNNDbLsBemH1FcHCE95
 ljZtezwmHrafhOduiUuOspKQuK01xrpQvcQHlEpGAU0/DVVuGi8zv2F9keesRugWzCdB
 ao8A==
X-Gm-Message-State: AOJu0Yzvz7xLVNLzuFRzkzpFj7wczkh70kVa+SvV8pWBsEpuVVOsV95t
 Vf+a4cCqRHTtEIeOf1/tYghww01LEgb9T1gtErfojB6qdvTlxRgmOMk8/kKeeimJRWRvgbj193W
 2VVHGN0qEuRJ4Y1ocZwCy6IPnMHuKuMWZ
X-Gm-Gg: ASbGncsN5SdzzHh/OIMoQaSzdOLuLYV9jquvQSMuxigF/+VOfl2BNCX2vsBGc/EmhUc
 F1O5RAKfWiT8vYGwx/sLWyAJRZguNVXlc0mhapaVyIAJxFiABk8AKwDhNzXSAzf7+fS/+Rtnk2s
 zIHG+rI0E5Uoz7fSKcWbGKt/a3
X-Google-Smtp-Source: AGHT+IFR0rdLQwu+2oxp0axiayXgnCvNJm0rMNTPKvyiOrb63MRTkqIT49KiMPsTpJ2pI7TCvWLioYd+dafUeNJg9mk=
X-Received: by 2002:a05:6122:458e:b0:520:af9c:c058 with SMTP id
 71dfb90a1353d-523c616be5cmr2331069e0c.5.1741197849108; Wed, 05 Mar 2025
 10:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20250301023130.31277-1-alexandre.f.demers@gmail.com>
 <CAPEhTTFAy=+SXPNk4vEeYo0bpFuBPb+yvBE9QVCMZnML7PMmQw@mail.gmail.com>
In-Reply-To: <CAPEhTTFAy=+SXPNk4vEeYo0bpFuBPb+yvBE9QVCMZnML7PMmQw@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Wed, 5 Mar 2025 13:03:58 -0500
X-Gm-Features: AQ5f1JqfUeKdvkro02JruqIcDXHdRGV6o-vDOrp4hlB464fiyUCh12Vn3LcodHs
Message-ID: <CAPEhTTHpFeSywrgM1kTL=o+-h8-FnT-dwTArgRrV67sS_x8+Yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Uniformize defines between DCE6, DCE8 and DCE10
To: amd-gfx@lists.freedesktop.org, Alexander Deucher <alexdeucher@gmail.com>
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

Ok, so wiring up sid.h in dce_v6_0.c brought a lot of redefinitions.
Fixing them is not the problem, but it spreads out a bit over the two
files.

I'm having an issue with the following:
In si_enums.h, we have :
#define TAHITI_GB_ADDR_CONFIG_GOLDEN        0x12011003
#define VERDE_GB_ADDR_CONFIG_GOLDEN         0x02010002
#define HAINAN_GB_ADDR_CONFIG_GOLDEN        0x02011003

However, under sid.h, we have:
#define TAHITI_GB_ADDR_CONFIG_GOLDEN 0x12011003
#define VERDE_GB_ADDR_CONFIG_GOLDEN 0x12010002
#define HAINAN_GB_ADDR_CONFIG_GOLDEN 0x02010001

The values under sid.h are exactly the same under both radeon and
amdgpu, so I would be inclined to think they are the good ones.
However, gfx_v6_0.c uses the si_enums.h definitions.

Alex, what do you think of it?

On Sat, Mar 1, 2025 at 4:35=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> On Fri, Feb 28, 2025 at 9:31=E2=80=AFPM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > Keep a uniform way of where and how variables are defined between
> > DCE6, DCE8 and DCE10. It is easier to understand the code, their
> > similarities and their modifications.
> >
> > Alexandre Demers (2):
> >   drm/amdgpu: add or move defines for DCE6 in sid.h
> >   drm/amdgpu: add defines for pin_offsets in DCE8
> >
> >  drivers/gpu/drm/amd/amdgpu/cikd.h     |  9 ++++
> >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 63 ++++++++++++++-------------
> >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 14 +++---
> >  drivers/gpu/drm/amd/amdgpu/si_enums.h |  7 ---
> >  drivers/gpu/drm/amd/amdgpu/sid.h      | 29 +++++++++---
> >  5 files changed, 71 insertions(+), 51 deletions(-)
> >
> > --
> > 2.48.1
> >
>
> Please, don't consider this series. Adding sid.h throws out a lot of
> redefinition. This needs to be
> fixed first. I'll send a v3 once done.
>
> Alexandre
