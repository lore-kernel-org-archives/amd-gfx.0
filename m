Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46306D3B7E8
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 08:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D4610E3C1;
	Mon,  8 Dec 2025 08:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="Qil8YnZ4";
	dkim-atps=neutral
X-Greylist: delayed 532 seconds by postgrey-1.36 at gabe;
 Sun, 07 Dec 2025 22:14:26 UTC
Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E6210E021
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Dec 2025 22:14:26 +0000 (UTC)
Received: from relay15 (localhost [127.0.0.1])
 by relay15.grserver.gr (Proxmox) with ESMTP id EA36743E1C
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Dec 2025 22:05:31 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay15.grserver.gr (Proxmox) with ESMTPS id 72A5C43D7A
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Dec 2025 22:05:31 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id D1BCB200E86
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 00:05:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1765145131;
 bh=wzkfHtx9sNZurtampKv05WSyL3P8rvoGP0JV8hZn+24=;
 h=Received:From:Subject:To;
 b=Qil8YnZ4eKn66dG6Pa41YO6py/G5O5tm47kdFi4OBHCkIs33SGVqwYRwEzEQVJtA4
 cXjUkGY8M3imU88kccVWNeirDI1Y4KxxobQPgVlXZgywv7n7w3E0VgYuuWBSjQUlF6
 lFoYR4TXFJJFYWVGPBK3qpRx0+DWkelAeS3nuqUJ2yG/RcW9Hy3p1FTTvcMiaeVwU9
 +3UHBiA8s3CmAw5bITeZAAlKWL6fd+5uEcRTZm4QGYB1uJtAmr51mq8SteK/OSWVJF
 g0OnVP4pRptEEpKwoq6fFrfpCFhETj6ECb/3Xiy39oBYjL+7j1/7nSQXtc8EBR9o8f
 ECJKRT3SFZ9wA==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-37b999d0c81so28656261fa.2
 for <amd-gfx@lists.freedesktop.org>;
 Sun, 07 Dec 2025 14:05:30 -0800 (PST)
X-Gm-Message-State: AOJu0YwLiWWjhHupf6isJuhu8RrnQ1IqFhsuFZdOYz3i/JUXt9USVRni
 5jnLOFJ98l8XcHabk/3/ukGyu+TAYy2FWd4Y+TW5dXTKYV6F9MfUDR5tkpY5fG/45Xb/zWbSn9A
 dNxtrCzro/vs2J7u/63EOlHHn5xx6Zt8=
X-Google-Smtp-Source: AGHT+IFZf/zLYwm1ReJIdr+OnHEOtwqlrHiuQufM6fZWbevAR+wwX3zMT6r0IoiHf1LeznvSm94TicsbcZacBWPRODk=
X-Received: by 2002:a2e:a989:0:b0:37b:a664:acea with SMTP id
 38308e7fff4ca-37ed1fd609emr14408931fa.12.1765145130461; Sun, 07 Dec 2025
 14:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20251207194910.122711-1-superm1@kernel.org>
In-Reply-To: <20251207194910.122711-1-superm1@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 7 Dec 2025 23:05:19 +0100
X-Gmail-Original-Message-ID: <CAGwozwFXvHJY_WOZXjBWhoFTt1rcsLX=1n5p49=S2HyF+EvdHQ@mail.gmail.com>
X-Gm-Features: AQt7F2prqmdiyDuwF93GCWCOy_84nSlYcNSrBj0IiuWBnTf5ISAkm8URERcCYgQ
Message-ID: <CAGwozwFXvHJY_WOZXjBWhoFTt1rcsLX=1n5p49=S2HyF+EvdHQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Runtime suspend for APUs
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <176514513101.2017317.1142650437417502740@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Dec 2025 08:21:28 +0000
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

On Sun, 7 Dec 2025 at 20:49, Mario Limonciello (AMD) <superm1@kernel.org> wrote:
>
> Set up APUs to follow similar policies as dGPUs in that they can
> potentially runtime suspend.  If an APU is runtime suspended then
> prepare it for the matching system state (s0ix or s3) so that steps
> can be skipped when runtime suspended.
>
> The thought with this series is that if the compositor has turned
> off displays and no other work is running an APU's GPU can enter
> runtime PM. If the system later enters system suspend the GPU steps
> can be skipped because the GPU is already in the runtime PM state
> to match the intended system state.

The compositor or a game probably has assets on the GPU. If they are
frozen, would the amdgpu driver be able to suspend?

> It's important to note that default runtime PM policy will prevent
> entering runtime PM when displays are connected. This can be changed
> by setting amdgpu.runpm=-2.
>
> This series isn't yet tested, I just share it for feedback on
> the approach. If anyone wants to test it as well, please feel free.
>
> Cc: Antheas Kapenekakis <lkml@antheas.dev>
>
> Mario Limonciello (AMD) (1):
>   drm/amd: Expand runtime suspend to APUs
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 17 +++++++++++++++--
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  1 +
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> --
> 2.43.0
>
>

