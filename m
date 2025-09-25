Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6827ACAC5BA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 19:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF0F010E2DA;
	Thu, 25 Sep 2025 19:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SGz/XuAs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70ED510E2DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 19:43:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 07B7B4550D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 19:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF66DC113CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 19:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758829388;
 bh=p9m63qbztqA2ZqEB3vay13lZfWLkiMoeU3IbsD91HtQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=SGz/XuAsTcbinLOkMaW3WcuGwlFZyjFoUUa46dWdmi/brQ1lON5MX5V8MZ15S05C6
 rvD/OTN1fjCHqI0nvjZfQmiL09uMKwEcstJra8PLJkWUZFdNeZczW3E9pZnwoTuv5/
 nyXhQWuRWq70tnEAc8N5jQFOA2ev30fqyrgt4GTIikqMf4zxXC6F0S1JHjLEd7cXLQ
 iA19uDSt6bAT93TPe0gE/Ary/xQwOJSO0lpLZrXyXWBs4REdf77yB6wZaEVGueamSc
 sC4/68uoOFBQ22Si8MlcING/n/vVR0s/mae/eSwopo8dw610JUHoo6NKF7HtljFD8u
 KQzJfBLVQ9Acw==
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-355102ff142so420270fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 12:43:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU1dcIH6vDTTaydwpmciz8czWF2MZjUJnfNHwGGihGLdw07G8N8qgUITqWGoxM/vXEwfau+4bTy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFKviQazw0q+wYy5RhYTtC1qYVcj4yUlZctmvFE14ZIaG42s2P
 Zd3WaRtNlm6YM5Xgoo9re9vLIh39d+op9l4hc6IUlZefS86cD4t59oGXgh66gM1SeXFPG/awN75
 Yd8P70m1K6T5pS3i7BYSUe6Us2qZg8GQ=
X-Google-Smtp-Source: AGHT+IE0ATqGlqZj1sCcE+gRnWpmVL5hKu3YF8bbl3xq78q2hcxItFzplLROHYVH/k48RmO/ChuvoYn9fUH38EOxfJA=
X-Received: by 2002:a05:6871:487:b0:321:2c50:30cb with SMTP id
 586e51a60fabf-35ebfac6d20mr1946262fac.12.1758829388150; Thu, 25 Sep 2025
 12:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250925185108.2968494-1-superm1@kernel.org>
In-Reply-To: <20250925185108.2968494-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 21:42:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jCnmQSXRfSxD8rmn1Y=yuq-tSeOv3AgryowLJErZYRgQ@mail.gmail.com>
X-Gm-Features: AS18NWAaKYsDERrfCLjBdjk_K5aGDYw84ebSbsufMfMQNSWk0Kcqs8ZuEg2bUSE
Message-ID: <CAJZ5v0jCnmQSXRfSxD8rmn1Y=yuq-tSeOv3AgryowLJErZYRgQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fixes for hybrid sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Samuel Zhang <guoqing.zhang@amd.com>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:HIBERNATION (aka Software Suspend,
 aka swsusp)" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Sep 25, 2025 at 8:51=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Ionut Nechita reported recently a hibernate failure, but in debugging
> the issue it's actually not a hibernate failure; but a hybrid sleep
> failure.
>
> Multiple changes related to the change of when swap is disabled in
> the suspend sequence contribute to the failure.  See the individual
> patches for details.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
>
> As it touches two subsystems it either needs to go through linux-pm
> or drm.  Patch 3 has an Ack from Alex, this should merge through
> linux-pm.
> ---
> v3:
>  * Push all calls for gfp mask changes into power_down()
> Mario Limonciello (AMD) (3):
>   PM: hibernate: Fix hybrid-sleep
>   PM: hibernate: Add pm_hibernation_mode_is_suspend()
>   drm/amd: Fix hybrid sleep
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
>  include/linux/suspend.h                 |  2 ++
>  kernel/power/hibernate.c                | 14 ++++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> --

All applied as 6.18 material, thanks!
