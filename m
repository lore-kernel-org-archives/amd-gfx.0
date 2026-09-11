Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EA3C88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 18:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D0910F6AE;
	Fri, 11 Sep 2026 18:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JQoQINvv";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD6410F6AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 18:44:40 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1ab18b3e6so30734a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 11:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789152280; cv=none;
 d=google.com; s=arc-20260327;
 b=krx0pSxsoWhh+Ismnstd2bzFvimXgvfuEDd2yvpUw5y/LVq0q4n3tzVUWLzG6OCEr2
 NCwXk7nb6/OV1nbuuwEyMfjjg/vfcLUYjOgGceAhM0u3mRYuepuct93hpKzFCZRjxjAu
 8nH9L0dXOFOP5UtwtIPhLcjOxBsDlc8+uMpt0bdGF+FB7VGCHfsNLxIMDmd7wAPkGifU
 gvzZAaoR8sC0emFBXLYS5v1K99n/cp9hEjnhPh1CcJx4kOtQV+AHRiibqr2GJLgIbooR
 6FqT+qtyGiACXm4EcWFeUgyTfceCGz47kYCwQIYYTK548FaeDXE4oCwzZDxrNN6BUaU0
 tDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jC5fq7nm8oZ1i9jXDH5cXnPmpfq/9mdxp2N9sOdJoMw=;
 fh=MV8xSw5YdrK5iIewyHRxo4ax7j3M5t3LyeF9RNB5UuI=;
 b=gQ/TqPfB+h0WAggYDgtbBfsNBFeyUsXA8sBxtYwqvpnAUCQg/SpvFJko3hvHivW27j
 CeTV5nhDk+4IAbriplqND3gwszcKMseuf8hMFyVlIfFai6tKbZuMAjHjaEC+8Oeh66bm
 BPt/+YVJ6+q0IRHK1uuR0GFqc21tqI8OEvRkLFRhpqsFGutc6RhLYV8Nc4lFSmVsCHGq
 cdrGpcuvgBuZhaeBAorq1gcXyjarvVdWSqDES0FmrH1+kqGiOOy/Luq5L97ZSz8kuKk8
 0RtGyZ2O3l0ZYSl+EMSwARCHkPir3CbM9yoHnpqDNc3hV+g8MS60ddZnOcfptIy/CPH0
 1I1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789152280; x=1789757080; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jC5fq7nm8oZ1i9jXDH5cXnPmpfq/9mdxp2N9sOdJoMw=;
 b=JQoQINvvRtXK/ltHolJbn3C534r87AAdri8fBv8wnbvocNL7xma5s+2poQqQII+PIv
 JRKZ22PnKfx6/qQaHYMgia44C1BNK8QzvJhqK+f9oqiSfK6/RUh+t2jWbAiORlM0BIwm
 UieCH9wT+Fc6XcnMsHE5QivBRr4G78E0m19awPSj2TQjrV2Lbe4ejAIxF1hU821G1UsN
 eEXEIbYFiBL+HsQ4McsBNhxRjTiHGTaXJvjhWFRpwQAwdVoU3Fvg1uQznvhAx+I2sKwq
 Fh6iOlC3ARv+OosfueweYiwqaClAHwTBlTeZOV350GyElPChKbqxixDk1TcJIXaVgpfn
 QYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789152280; x=1789757080;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jC5fq7nm8oZ1i9jXDH5cXnPmpfq/9mdxp2N9sOdJoMw=;
 b=H0IycViH3SBsztKOvTFCdmptSpwSGzK4yC/RUuSMrb6K53wConisODK92WxL0DJOyJ
 ODwqMwS0x3Eo/YSdyjYViDjcX0RfrVMqtwLjf7S/lc4Bv+Y0bcQ3kT1nLnvwH571gXEW
 sR0fiNif9MQdJ7zilsXh0v+g21AucKowEj58nRW/D57glKLu7uoFGt8t6mZmlaUmHcH8
 7LeCnCFnpth4Q9AnMW4m3p22ykoMd1CbkxVP3DHHMZMzB8tVt7+25FNv8D+fmbY/Ffzv
 4ia+ZPcULybAXzFvbEDQD5TihLcRzrWAbRLiN749pO2FprNbZchYCXvJ3Vq8oeotlIJX
 a/yw==
X-Gm-Message-State: AFuF++nA4vGrqJDl7KlbOjQk0Ls94fqj/7Aq9Q/zMRnqzHdJQBsCMDOh
 AZjYPcCE6x+y1EAJMgvrgGU34Dx1I46KbMU2/QtE5j2X01UNYy53LCxrEZkJMfQ0+h3PZQ/UahG
 K2ws9NB6e/z5MpAUxbPspPhLcTLIBM2Q=
X-Gm-Gg: AYBFou2E13/FJet/D7+t3fCihKa/WfJeI3dLeP0pjQFytQTWVEpknt3u8d2MaplR6vC
 pY10UBn8lYEpYFHCotTKU0HgEO5XMznL7WgFVsYCQ/Lc/SO5O39wrfmKO+ITKc9HqXC436q2Sgq
 uCZXYfaAnv3TNC6/WfToSYWfql/Ah5NSTszhotrK6R7nIljwruuHZ5usEdItYfJzvIWd5N5yyTQ
 aRk67KNzffqX/blJ1Q0/7/Cz81edUW+D9ngUMQX6r6zm4gjhRJA2ytwrL869rOv1Nn8We2NCtH3
 +H5j4LI5sQzWExiPxLnEKfIOKYEqCYK/7vzkKwzN1+eKVauAtCAllMeXlebZOYUTa3d693Jm6V3
 KJZA9yV3Ge5yg1K/7R7evzVG5c7422CRnzI/O8MuxVA==
X-Received: by 2002:a17:90b:2dc5:b0:398:bad2:c10 with SMTP id
 98e67ed59e1d1-39d9c5d42fcmr5772596a91.6.1789152279634; Fri, 11 Sep 2026
 11:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260908181052.381126-1-timur.kristof@gmail.com>
In-Reply-To: <20260908181052.381126-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Sep 2026 14:44:27 -0400
X-Gm-Features: AcwNN1UYSA-tnwlkU0c6jc8ty18BRjtzuMdwlyZkMLevKYJ84pLb3kk-xdKT61g
Message-ID: <CADnq5_Oa0t+SWTdD9zEfKsNLUUFBL9jcnSJndjJHRn7yODq=RA@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm/amdgpu/sdma: Improve existing SDMA queue resets
 (v4)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com, 
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
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

On Tue, Sep 8, 2026 at 2:35=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@gm=
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

Applied the series.  Thanks!

Alex

> Changes in v2:
>
> * Added a fix for an issue in SDMA v4.4.2
> * Further simplified some code
>
> Changes in v3:
>
> * Fixed typo (wrong scheduler for page ring)
>
> Changes in v4:
>
> * Added helper function to clear ring contents and pointers
>
> Timur Krist=C3=B3f (9):
>   drm/amdgpu/sdma: Remove unimplemented soft_reset() for SDMA and SI DMA
>   drm/amdgpu/sdma: Remove superfluous rlc_resume and rlc_stop functions
>   drm/amdgpu/sdma: Fix executing duplicate commands after recovery on
>     SDMA v4.4.2
>   drm/amdgpu/sdma: Remove unnecessary guilty tracking of SDMA queues
>   drm/amdgpu: Add amdgpu_ring_clear_ring_and_ptrs()
>   drm/amdgpu/sdma: Clear SDMA rings after reset before starting them
>   drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
>   drm/amdgpu/sdma: Always handle kernel queues in
>     amdgpu_sdma_reset_engine()
>   drm/amdgpu/sdma: Use common SDMA legacy queue reset on SDMA v4.4.2
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  21 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 102 +++++++----
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
>  15 files changed, 121 insertions(+), 488 deletions(-)
>
> --
> 2.55.0
>
