Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE9606ACC0
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oIQ0Kx6W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B40112700;
	Thu, 22 Oct 2026 15:12:33 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052D1112710
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 15:12:28 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-99091419d56so44539241.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792681947; cv=none;
 d=google.com; s=arc-20260327;
 b=lCAVFZQqf0/VBlRx05hjprlpHqo1GTBHlxpnxillNeLfBzmbHm1E3AYTgR0g/91GDJ
 q53C8laJF3vR8qjNO2ZjaoknK9q5+e0Zba9IM1vGunGwqv3Nzfh5CG+gF3MDZnxw2oxH
 fwY93X5jp+O5u3wKo47+73OF/sq8azAEzsk6ybdJfgJUfhjNPSsJpZDQZ4vJu+OTWlCA
 AenDdC1FFZkklyNohG+GBSlXP4WUAzAGfUHUVirf/X3/ktwyOFrIXne+sq1qOZxjdfh2
 qawcZlWLFoJ7zZYDCpQ2jLMgj3nfFGXV7ZhoUhcY26aNaYAUIfdKl1XnhtDfCF2KyPQO
 hadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y6tRRI63BHu6BkuvJZ93X8sv4xfpLog4Vlfs+glJY/A=;
 fh=Curf08LNx8Aj4zLRiAGWkm5n/2YakB+Nh835LlZv6S4=;
 b=d7Hn2ya8XJAGEqaYr9Yg1Ps4nERyd+BNsbV9U5/jxjDKaxYdnj3s5YfU974U4ZCbPO
 wmunfNz2txbd8/yT0IgDHO2OsPv/iKeKSGCi5rNEyZXmYFyQgib03spHhh+lRRy83qGK
 hjZ1j66h9xdazPzoGQ8bEA03EyNI9cLflACE2eLeQ0vZkCs9cvfsqIgWYyRCdl1lZel2
 /uyhThvqcdR2EDHBgb2UjkXb8DfCvc2VPqqvpDEM4KlOjJsjMtuJtN7ZgIbHNlL13aPJ
 U5ow8PmY2b0enMpLaVoOf71/3/A6Pfp/06AbI/G21qTKrjveb3FZacKXQsH6M6w5/GU3
 sK1Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792681947; x=1793286747; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y6tRRI63BHu6BkuvJZ93X8sv4xfpLog4Vlfs+glJY/A=;
 b=oIQ0Kx6Ww9JQDbgSoplZnTB+9DZaWUpvswWWNY1guUySuMN/EVzlLl4MLF8dGMCvxr
 iFHSkdK3D7VH2KDl+Abb89TZPjLOVZ4ssk5SnyabAeTGI/+tNGsxUTFk35GHtV59I+KS
 SNBXb0zlNDhezeLEBZnFBtRa61+VqXDlnSI2og/Gs3Eg4DGT21uCZ6xQeHROCNPiTiMM
 V+JixLGhea/BHKS4H+ihUL6L3EaTTiCSXHOnWMxYz3ScDDe18S84yLf9dmJ/HR0MPI20
 v2kD3DEdyG22b+cgXxD/OSv/TyKJ2aSObg3E6FCB65DnCE5diD4PabJneiF0ISJ4fnUv
 GkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792681947; x=1793286747;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y6tRRI63BHu6BkuvJZ93X8sv4xfpLog4Vlfs+glJY/A=;
 b=dLt6EEqqgyWsF6dYEV8SgEQy8bmC0/2zGGaV0eOYf4T0MXyv0QmK2eYEnJQLLofTCJ
 LAn9BDCCxmu8i1JsMM+KWNkfPFb8mk3OakRwLKIfqUDowFiDMrJpq54Vd+4LWIqznlBa
 FdYXMmXJ9YWHIJ/JD2RP6TyYBpmMrA8FGy0PUn1RPSzzQXDRd3vfcxLZvn6fdJM3mVEp
 80q5igdZ2K6hHSHsQY8nKggyJtjyZ5GRNd2kswJm1MFaHwCQSdXYepfZSS2/IvqK4rZu
 inDdi+uC3JNwY8SHdvQzZ2kDpGXWF8gYhA1qqV99ogkzHEi7dKUiLHHf6M55ZR5txZR4
 2uaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByLqJchpekGz/ttK7gVIBnvz+KIiUK8ruyHTaBzIuF7OqUFY9nvlc1vbf78202K8qr/q9s+RtSy@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKFIM7gLviN+F8QQ6P4lKFepBojzgKhEhWsMwwyaCj3j31nPGpN
 wHTSQ/Mr9zZHbXVJJEMyMEpuq1lFm3rumlMsc85GHoNOZCZJUQBpZfB4zZQ0OD/KJxfI1+68Pyj
 T2UJMP18oGsLZoOrmPmKSdZNgccpnrak=
X-Gm-Gg: AYBFou2FqGUfHs9GyWOgDPN5I7SQRGyKP1Vd2Onu7fxh7qwVKdn4mrunaRa1OrMY3cX
 fOmN3ImPmI7bXP04ds+bWZJq/feDf7ZctBCHzm7O7ejl1VeEs6/p/r6Y6c0G7XEmGI1K08xWf9z
 HBWy6wtzYKWrZfNFJC33kdGvqyRXQwTeNOBndgH0EAiO9eYGFYYhBCAbFBVybqrRvl+ruAlqHLU
 bEyCZ/BkaJGHpYCXczJAx4J8ZyyfwKAjIrUfYIqmnBhnOPXPZ+BJuiTFnQrbizgFdF8HFeoCu2x
 lmOhDIGL9fOuSBcbuQPGe8TT1+UVVFIPwRs5I88euO1Ayt7vb1Wh8+fIADupMD98uQnDy071kCK
 f8zLnva0wsmBHroX8+RzdeFj9SexTGgab5ieroMfXgxRocbpSzM/5WdupnkMfujM8vpOwtr40oP
 mnQVX4L2XL67EmpM58s4fovG8pKK8ZYsaaPabs6a4DzlF3
X-Received: by 2002:a05:6122:5219:10b0:5ea:cc1d:173e with SMTP id
 71dfb90a1353d-5eaebc1422dmr1548043e0c.1.1792681946761; Thu, 22 Oct 2026
 08:12:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022114754.865669-1-mptagliari@gmail.com>
In-Reply-To: <20261022114754.865669-1-mptagliari@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2026 11:12:12 -0400
X-Gm-Features: AclHuK_pmpA8FYbBRpXzvreBUaKMzQ3M_QgHr4Byziz9NDrFFS95zIqKnggaqPY
Message-ID: <CADnq5_Mvjyi+a_2zhSg0cmNUm7nKCK3kD8_0+mcFYeZzbQ-d2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/radeon: fix VCE1 encoding on SI by handling
 the VCE interrupt
To: Matheus Tagliari <mptagliari@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 9:21=E2=80=AFAM Matheus Tagliari <mptagliari@gmail.=
com> wrote:
>
> Hardware H.264 encoding with the VCE block on SI GPUs (radeon driver)
> hangs the GPU after a few dozen frames.  I hit it with the KDE Plasma
> RDP server, which encodes through VAAPI, and reproduced it with a
> plain "ffmpeg -vaapi_device ... -c:v h264_vaapi" test on a Radeon HD
> 8870M (Cape Verde).
>
> The VCE1 code never enables the VCE trap interrupt and the SI (and
> Trinity) interrupt handlers do not process it, unlike the CIK code and
> amdgpu.  Patch 1 adds the handlers, patch 2 enables the interrupt.
>
> Results on Debian 6.12.113 (see patch 2 for numbers): hang before,
> none after, and 34 fps instead of ~4 fps for the workaround that avoids
> the hang.  The KDE RDP server (KRDP) itself, driven by a local FreeRDP
> client, now encodes on the VCE ring for several minutes (about 40
> fences per second on ring 6 in the radeon_fence_emit tracepoint) with a
> clean kernel log.
>
> Two caveats:
>
>  - I have not worked out why the missing interrupt turns into ring
>    lockups instead of only added latency.  What I know is that the
>    hang needs the VCE ring to wait on a hardware semaphore (disabling
>    only the waiting side, or both sides, of radeon_vce_semaphore_emit()
>    avoids it) and that handling the interrupt makes it go away with
>    the semaphores left enabled.  If someone knows why, I would be glad
>    to improve the commit message.
>  - The Trinity/Richland change has not been tested on that hardware.
>
> The series was developed and tested on Debian's 6.12.113 with the
> radeon module built out of tree.  It applies cleanly on drm-next
> (fad06cf), where drivers/gpu/drm/radeon builds without warnings (W=3D1,
> allmodconfig) both after patch 1 and with the whole series.
>
> v1: https://lore.kernel.org/r/20261021114122.94008-1-mptagliari@gmail.com
>
> Changes in v2:
>  - Patch 2: only enable VCE_SYS_INT_EN for VCE1 (family < CHIP_BONAIRE).
>    vce_v1_0_start() is also reached on CIK (vce_v1_0_init() from cik.c,
>    kv_dpm), where the register is at a different offset and is already
>    enabled by vce_v2_0_resume(); v1 would have written the VCE1 offset
>    there.  Thanks to the automated review of v1 for pointing this out.
>  - Patch 1: unchanged.
>
> Matheus Tagliari (2):
>   drm/radeon: process the VCE interrupt on SI and Trinity
>   drm/radeon/vce1: enable the VCE trap interrupt

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
and applied.

Alex

>
>  drivers/gpu/drm/radeon/evergreen.c | 14 ++++++++++++++
>  drivers/gpu/drm/radeon/si.c        | 14 ++++++++++++++
>  drivers/gpu/drm/radeon/sid.h       |  2 ++
>  drivers/gpu/drm/radeon/vce_v1_0.c  |  9 +++++++++
>  4 files changed, 39 insertions(+)
>
>
> base-commit: fad06cfaf385787b9ffa2f73f049d42dbe1de57f
> --
> 2.47.3
>
