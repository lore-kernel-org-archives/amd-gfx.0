Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16508CCD19F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 17:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A63EA10E49D;
	Mon, 20 Oct 2025 17:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AyPxJ7eh";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92B810E49D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:33:04 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-290a38a2fe4so4080375ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760981584; x=1761586384; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VI2PtJUq4Sc30HWOhQj8ldzwhG1vYDstA/zAjK88nRU=;
 b=AyPxJ7ehtvGnlu7gVium/xO3xN5ndGmZKE5fbNq1Z5zNw7IMlYvk+iwlm3LyHz328e
 ttMqDe4NExxijF27WiSaeQQydWVFgku86re+HOcQv8oj6nTsFwmTOl55zEMEvinL/UQS
 A1O3AgSqB9+gTEwl+Zz8wkWB7zdEMhFic5SYqqiK6kkvLwxJNmQz14iOdBktG1fMPoXZ
 6Yi9LeMp0TlKDmGox3pb1j3xz3khU/LDkKxAxV0HVzHT/SHz8WI0aDCN1IQjczvoIwaZ
 OA2SVPZAjxj6Mx7nvq5AD/c+r41yT5kuVaVG5Ldbx3f54Kf2jEzrDPfkaRy4j1JOTD0D
 g1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760981584; x=1761586384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VI2PtJUq4Sc30HWOhQj8ldzwhG1vYDstA/zAjK88nRU=;
 b=a97C8VLOzTisJEQDGaqhzdqkzKYpMJbXHsnWvYlsea0i0isxZ16IWCaiHD+EpLPwta
 v8uamakGRUukSXAsmr6J5otTtLzjzF99H6yDBeRvInBwzrZrbgchShUDH2IwSyLDmi/d
 Xvg5J8oaUIaNLu2Gw40q6rt95Rm9hnnj/cUH5N4WDHAJkoUkyJM16kveptNc8KZosOAU
 74QGScFgDMcmfNKm0YMjTbH1/50dzYjl09F6DfOufiTN5OQ1Ef+cG45ND1gGRLVMKQxN
 klTEHHwqPcDsI06tBIfDuHQty/svRo03yWDNwnGA0rQGtqWbeLrX2AtL3HDmatw2upBn
 LQ2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsibDnV9xORRuZjAgTRSQvzu7TqOAZUvWUr+nbaB97QfE6sgIe0U67hLzf+lMRpsW1eU7GnSzh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzV6mt3Yde03hkl8LcogPu8CNaryrL+DZQGHk355P/Axzy3MusU
 QUXGjQW69RhSlD4mVabrHgS8lS1cbBl0gDDA4ioMuHtJElU0t5uHEftstWioIO/ncQWw/Hoj0dT
 YgGMDQ3huOV8seR2NByHYkYmpf5+ke4Y=
X-Gm-Gg: ASbGncuIMMg/bk8ba4wzz1XmGYH4/9+q2TJhF2yOUujlEbgejdZzJZ8w59jkb1Cv3yq
 Cy3DDNO8QkKMRwLwYJngKYlO3MuZNVMn9zJ1oUwG7a0fEclYrhs+JXugPflTTGwrfjZnfHFiiIX
 5NIohi0M0N4RnYWaXoc2ZrK9IL1MjLwnNuLGzzZyZH8gatf872bT2QpHER1jSLbtza2zg/P9JEm
 pJ58aTBPJVeFu3ZJCwVS0wnbxzF/8dGzK4fYrlIYExAeCTMHZ+igpNlDUzqAhL4cqUfKok=
X-Google-Smtp-Source: AGHT+IFU+KqAEkbMCW8Xf53JYAtbqincSoO/rgEjO02snl6niQ+EZQMNsesNeWJPPWOHadiHVfJVBWRPjcMTziYcl0I=
X-Received: by 2002:a17:903:8c8:b0:277:c230:bfca with SMTP id
 d9443c01a7336-292d3e57324mr1368175ad.4.1760981584179; Mon, 20 Oct 2025
 10:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251018054451.259432-1-daniel@0x0f.com>
In-Reply-To: <20251018054451.259432-1-daniel@0x0f.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 13:32:51 -0400
X-Gm-Features: AS18NWD66tyW2gm21ozKGA5vxvXrn7M693EyUTlpuxSeBNhOvz2jwM0dQyB4ats
Message-ID: <CADnq5_MBLAOsam77vZME=rjOoDMXL_+J+grxXVGz2ekxO=512w@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/radeon: fix up some badness when probe fails
To: Daniel Palmer <daniel@0x0f.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, wuhoipok@gmail.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

Alex

On Sat, Oct 18, 2025 at 1:51=E2=80=AFAM Daniel Palmer <daniel@0x0f.com> wro=
te:
>
> I have been trying to get a Radeon 9250 running on an Amiga 4000[0].
>
> On that setup it fails to find the BIOS and the probe fails which is
> expected but then a bunch of WARN_ON()s etc are triggered.
>
> I though maybe this is "m68k problems" so I bought an old x86 board and
> there if I have a different primary VGA card the BIOS part of the
> probe fails in the same way and the same scary messages[1] are showing
> up in the console.
>
> It seems like the probe failure path wasn't tested when some previous
> cleaning up happened.
>
> I'll fix the issues with not finding the BIOS if the card wasn't
> initialised in the normal x86 way later.
>
> 0 - https://lore.kernel.org/lkml/20251007092313.755856-1-daniel@thingy.jp=
/
> 1 - https://gist.github.com/fifteenhex/b971bd62c49383a0558395c62c05ce3b
>
> Daniel Palmer (3):
>   drm/radeon: Clean up pdev->dev instances in probe
>   drm/radeon: Do not kfree() devres managed rdev
>   drm/radeon: Remove calls to drm_put_dev()
>
>  drivers/gpu/drm/radeon/radeon_drv.c | 34 ++++++++---------------------
>  drivers/gpu/drm/radeon/radeon_kms.c |  1 -
>  2 files changed, 9 insertions(+), 26 deletions(-)
>
> --
> 2.51.0
>
