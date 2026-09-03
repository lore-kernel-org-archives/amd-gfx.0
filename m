Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E38C624DB
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 20:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06E410E0F5;
	Thu,  3 Sep 2026 20:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iHCfmuCH";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A249210E0F5
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 20:48:16 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-39b1c184ec7so23951a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 13:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788468496; cv=none;
 d=google.com; s=arc-20260327;
 b=YrZsWLg5q+nDnf4KluuaWzFJbsix6q2X65hPvmHFe8eEn+rcKkTOKiBcHnO5Uoamo4
 slMq9joEOtb92cLOfw8qWrQhHA5KpUWbp4M5BwZmZDqGd7LBy+RjB98NUbwm4YtYgnHB
 4dz7KARRJggJ6vbY81huPhQ7hFMnl9bb34A5A9RhCKur5PooHz/cUZTZMOGrXtDZzwre
 BtKAj8qqiZq8k6dWTO2lTHYil03NK0ey07GoB85AeT+PifNsdJcXofe5OcnRROKG/I5D
 T2tlYL8pj18Qex0nxxmKV6TFF2cIRzaHOgJ4NGkm8if6eH6JCzx+Vj0aKDaAXPEaRl71
 +vQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wie3Qz2DAChoEhlO2nZoIlkb+fnjr3Kog7JNPughu64=;
 fh=ebTNwso63II8DpA1nWkka4IVKto+41y3i16bbjXht00=;
 b=NSOUJDKN5/gIyl94TDHbNHK/NkRLuVbTWsDzyi8fbDTxEh8Y+8dHZfJZtAHzxUs5Gd
 o+75CDXgS5WqtgrwGHrBYPGsih18jeiF04Gb8Hsw0MzlyOa+A0PTAhD0hfhNmp6jaHmH
 5wVNWtm0MSKzaE4ii4Cj7bolPujD0520DRtp3pvIuX/05CYHjZ6afu7HnhwP+JLRtiRn
 VO4E2zrlMM6GK074OmkRakl5rTl1w/KWhPh+jwn7PirdU78yNnqYCvE6Nxb3RsDHHcp6
 Krw7gQurevd4Kf483vgs+Ff1H6OUEkw3rzNp3ny1aD6/dGnEo0b2syYEZW/noZ7kU5pE
 BvUA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788468496; x=1789073296; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wie3Qz2DAChoEhlO2nZoIlkb+fnjr3Kog7JNPughu64=;
 b=iHCfmuCHnRphdMFW/iW5q8+CZ8f+KDpzOsElL1q36Un+CsmH45Zv8BIZ/R5n3urF9u
 w0RppyKMlxdJ7S+5s2ONNfYIKkN6tI37RINqOwD/2trqKcfTphrp3zjNi2U8Jahi6764
 58vNHUQOGAWMyegZsr7ju2j89NGTmDKOK23gYOjMu5Xrn+zIijY4FeOSL8+RELvYFlmz
 b59frHYWf4w8F7tEXUvlyl8h6A5qI1CL7bIsomcikRTWUy7RXxe+goF0xo5QsIrQ18c9
 oXeK4He0izspk1/MqfZHznthWSOetBShP7DA+1jAjfJjbH8uCQ5JELdgTJZbe0BqNAli
 KqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788468496; x=1789073296;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wie3Qz2DAChoEhlO2nZoIlkb+fnjr3Kog7JNPughu64=;
 b=b9MyT73jgGsrnFKtFhhiJb5jzpRWtBLc+ac1OnSJQMQesJ2s6Prjl52JTmArDoo4T2
 CsMQkatRp5Ok6vWr+WQFDTGmq8fmcO1h/4i//HBzpg5xrzKYktgaIK8QrO6ZcD8sOOy/
 imEiXXeBHyIdoKHjmabQv1sF0StA6oLRprcJ+eEeKYmGsdIl6Mx9IWjoDi1yxFT4rrZa
 rjaqQplbbrcs+UCSWhg5QeDW7dqzd74OU/UsBHD3wPVr4/1YcLIQU/LjT+PT0N76e6gc
 k1nv64kflb+v9yxzurKl+x3YGuHT5yA/ZYxqa5QBYTDhysoIn5CV7N7CXAonKY3txL08
 +OSw==
X-Gm-Message-State: AFuF++lQULkxmMhbnllEfSwz+vvijtDfLHWj9R6d0gUt2GhntchSx4Kw
 McNcfL7ZSm9fLewDd6Hz26UWwVA4O8RHI3RWWCyn2SotxyREI4gU7As6XogIAgAWJxT2WYfuNzY
 JVoW2r9o0BPh0noMHdPWW5GnPitD4PqI=
X-Gm-Gg: AYBFou31kNzgEU7fryfwrPHfSUc2CjSViIG9RvQDPiJVcJH8bm+BQqfSJKsqjAV44ZJ
 WaKdnV7Hagjm4TRj36WAqIFyotLs0S5e5ZJN2sNO8XqGdXwgfAW8uGlpnp5Kvn+h0bmvaazhWUb
 BZdgxYbugGDU1G0cKtpWY3NSzyzratJB6RIPf7aYHmAPmWb0izq0qlJVY3dtM37kj3aCQApwDeG
 dTkIUoCM5epxm7mPQaEbmRP69DMUchyEWI5DpE0qhLQQadAClUzmiTbMU9LCxO5p4b0xfdz+fqO
 lfmw0G1SAqsbl4nOV6YdOeZzNkUAGSoXPWOP9GJo3PdW6UEQTkLapZ3j8pOLDrNzqFKZOvOIr2E
 XO2y2NjixdFyjdcL5ItqRk++9G5BBDPpQW3wvSzaWm+96
X-Received: by 2002:a17:90b:4b86:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-39b26252efemr1037601a91.4.1788468495954; Thu, 03 Sep 2026
 13:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260901084115.262457-1-timur.kristof@gmail.com>
In-Reply-To: <20260901084115.262457-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Sep 2026 16:48:03 -0400
X-Gm-Features: AcwNN1W80dHH0sETMVSqweFB5FyCVaQrr84emMiK9c1qqtVirNHRJLkciPOii_8
Message-ID: <CADnq5_MVOcNtF1zDiF5ONK3oMN7igJmY2AFCVdUjUfnb9APCrg@mail.gmail.com>
Subject: Re: [PATCH 0/8] drm/amdgpu/sdma: Improve existing SDMA queue resets
 (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
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

On Tue, Sep 1, 2026 at 4:50=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> Improve SDMA queue reset for SDMA v4.4.2, v5.0, v5.2
> and also moves some functionality from backend-specific
> code to common code in the amdgpu_sdma.c file.
>
> This prepares for implementing SDMA recovery
> on more generations, as the same logic can be shared
> with all SDMA HW generations that don't use the MES.
> The actual recovery implementation for various
> older SDMA versions will come in subsequent patch series
> after this one is accepted.
>
> Changes in v2:
>
> * Added a fix for an issue in SDMA v4.4.2
> * Further simplified some code

Just one typo in patch 7, with that fixed the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Timur Krist=C3=B3f (8):
>   drm/amdgpu/sdma: Remove unimplemented soft_reset() for SDMA and SI DMA
>   drm/amdgpu/sdma: Remove superfluous rlc_resume and rlc_stop functions
>   drm/amdgpu/sdma: Fix executing duplicate commands after recovery on
>     SDMA v4.4.2
>   drm/amdgpu/sdma: Remove unnecessary guilty tracking of SDMA queues
>   drm/amdgpu/sdma: Clear SDMA rings after reset before starting them
>   drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
>   drm/amdgpu/sdma: Always handle kernel queues in
>     amdgpu_sdma_reset_engine()
>   drm/amdgpu/sdma: Use common SDMA legacy queue reset on SDMA v4.4.2
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 109 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  11 +-
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  32 ----
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  30 ----
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  38 +----
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  40 +----
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 158 ++----------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  60 +------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  52 +-----
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  27 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  27 ---
>  drivers/gpu/drm/amd/amdgpu/si_dma.c           |   7 -
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |   2 +-
>  15 files changed, 109 insertions(+), 488 deletions(-)
>
> --
> 2.55.0
>
