Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDACAE732FD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 18:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CA610E683;
	Thu, 28 Sep 2023 18:00:58 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4607910E683
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 18:00:57 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3af6cd01323so131551b6e.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695924056; x=1696528856; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jf7ScwygjQ2jf4AqpxHi4jRt6wSUGgNirGCrHubekSk=;
 b=Jefvf80AORQOgTZ/YymzyndhVQD6yQSv/+nPM6lmpLto0vNB6W23CfxFvtagGGnxOM
 KKQKxaKrPPc4uv4pKZIfG4vP5Ed49mT+I0Mr7qVZBZ+RejiIlit/Ggf6QmbAZLz3sxzo
 UvhwLDiUKZKynoWzeE0bAR65V/vhLNJxAgV0q/ypb1X6MuvI1Q8ANeFzbyaXNkoLPooA
 dsd8oYGcKNrTJCPzqOcrgp29Tdw0W7J9VC6mJ/Q4DfLp2+/hsyMRWUryJknXFX5kDJsB
 SXMUvqzWsHZw35sgpSbqFidMlsQa4UTbBPLcBZU5QuhrbSeorTAhIwHsFgmFqB7WEzKD
 dekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695924056; x=1696528856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jf7ScwygjQ2jf4AqpxHi4jRt6wSUGgNirGCrHubekSk=;
 b=Y1u/S+Mz477E2CX1NkXfbbhwQ9GFy3L82Qp1/GxnBHbrAx2lHkk/5OVPgu8Yb1xLit
 IDhr1gVxKM46mukoDUqMYxj/8+84/DvXH+reaBN3YaKlYZHXh/lyhHystcsqMaHrhI2e
 QucLiWonWhhz9eZoYIQ6sC5SzIW3UPP6Zp2lX2GwVa+zRGCC5SYCCWD6tHvthenvwGTg
 yTTmas9pNiJ1W8DG8AsaI6Az+p9r+lFetF5RuvP7anl9eQZPK4VWrcleft6CERZrGFKe
 opdGKqHDOal9S7o2q2j5RRaf+J07cFGS+6jskutjkMbWKlIzAWp83RY5VoT7SX9U1C9n
 3wrw==
X-Gm-Message-State: AOJu0YwxlZIhSPevh6Otg2u2+/0KTpxNiva1YCuo/kA34KBdX/whn9Bq
 vvBEYyEelpw/Cb5TWstoqN95rgJo19agjGsg4eM=
X-Google-Smtp-Source: AGHT+IGKXt0xSHlAm601LvV0qT4645pgVZtZMWe+PMCSak1LUkBPD86q1BCqTMAlzzAuU4scAQtW/iNbQ4E95L/JjDg=
X-Received: by 2002:a05:6808:b28:b0:3a4:225d:82c0 with SMTP id
 t8-20020a0568080b2800b003a4225d82c0mr1924328oij.31.1695924056416; Thu, 28 Sep
 2023 11:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230926225955.386553-1-mario.limonciello@amd.com>
In-Reply-To: <20230926225955.386553-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Sep 2023 14:00:45 -0400
Message-ID: <CADnq5_NHQhUZ9DzNtOy67Hx1g2_ZeBfKPC6O22YY_bzSJsMiUw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix Navi3x boot and hotplug problems
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jun.ma2@amd.com,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 28, 2023 at 12:41=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On some OEM systems multiple navi3x dGPUS are triggering RAS errors
> and BACO errors.
>
> These errors come from elements of the OEM system that weren't part of
> original test environment.  This series addresses those problems.
>
> NOTE: Although this series touches two subsystems, I would prefer to
> take this all through DRM because there is a workaround in linux-next
> that I would like to be reverted at the same time as picking up the first
> two patches.

FWIW, the workaround is not in linux-next yet.  At the time I thought
it was already fixed by the fixes in ucsi and power supply when we
first encountered this.

Alex

>
> Mario Limonciello (3):
>   drm/amd: Fix detection of _PR3 on the PCIe root port
>   power: supply: Don't count 'unknown' scope power supplies
>   Revert "drm/amd/pm: workaround for the wrong ac power detection on smu
>     13.0.0"
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
>  drivers/power/supply/power_supply_core.c             | 2 +-
>  4 files changed, 5 insertions(+), 3 deletions(-)
>
> --
> 2.34.1
>
