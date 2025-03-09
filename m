Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEABC28B28
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Mar 2025 23:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DA7610E375;
	Sun,  9 Mar 2025 23:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qy9itTtl";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5BB510E375
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Mar 2025 23:51:57 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5238b366e2aso3659912e0c.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Mar 2025 16:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741564316; x=1742169116; darn=lists.freedesktop.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWhXPyvsSLFGFlbhP5pCLB5ahngpmHSZ0rAufAZq7OM=;
 b=Qy9itTtlnIxO+Kr3jA2XNA7Lq1Ge86N+rSyeAf6FiZcIqri+HPOHHn/2aCOzkUlqit
 ldXsxUG1VNIROZ/YJktrCvcTKboreD5BpPO3UgZub83PwCm3OXTEpKBqJbrqVMdolb55
 hV+nuHvoEd/zTzmf5ZKrF35zxCD6PIyRDQDnUf+JqS5AGQJmDUbu5EM4d3xDac/1rvgp
 aHI7UILAxf3kYGqYS0RgU894LoXE+aNk2+J45Dtyf/T7vrjl1RhDfne2rIlWJF4dzf5u
 HrFgIjk1N1l2I5RrccoTFBmF8ONP7W57ALrrEiB9Ccpqm/v1wkx+qaAtOm069u+Zu083
 3nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741564316; x=1742169116;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWhXPyvsSLFGFlbhP5pCLB5ahngpmHSZ0rAufAZq7OM=;
 b=HMdh8On0k0Ff+MVYLz4SVZj2roaXlm0DZi/12UdwM/KwUv11Y5Ljz8pOH6gwJmuj4N
 zyW+jES6BuR/vVahkvbXEH7mWCORuqwruU5T4RwQNKacr9s7vnpyI+8AndO0M1Dm4CGV
 VV1+ajFH5kaUe26Jh2t3y/eMSagzZu8soA0A+M5YS/8BE2HOi1VUW89/Gtq48gNYUIgK
 m7w0neKBnsCllkSbVgT7OZAOyFO6n8Jax8cXyLEy+hpFTXYQVU1ELYUi3SqL8Ib1IR3a
 UUXuayNEOl9AQD5e26hLb4WKmCcoCbu91Z9V6Aa5t6P5EYEyNtoU4KdLcEq3nTgYxMip
 KEIw==
X-Gm-Message-State: AOJu0YwVBySlYovvF7WZj9DMaZChHN4NyA4pZo6iZjgmcyUQKzbkAp9T
 O++Bk9kBbcfuOKSFFWrCV2e3MdypVzv6JT6yEwtTs3gaJ+i0F+AlEo60NPgvQAI9lRNHv0/O0af
 sMj1bNMcvEPWeLO5gOT6mVconIIE6h0bZ
X-Gm-Gg: ASbGncv/Oq5a24Lme76hH4MMvjwTnmksWTAaYg7d97pcVdLYuHegs7gRumnENjj+70c
 nMLTrPa732LJI3BE6wDurip0Nzoh+sA/D52PAol0yT9ynN4OuNhAnk3qL+Nnx9yG0UFeT+Evcex
 trZAwiuma4aOsx60cUQxlNIyYf
X-Google-Smtp-Source: AGHT+IGaoqj00PTgJaT0uEabpbYJ511UwXAdgmbarhQl5LWLLek5Jtpc/hERu7W9zGHnKhx7LVIqURJmZuYCgdjsw2g=
X-Received: by 2002:a05:6122:54b:b0:520:4996:7cf2 with SMTP id
 71dfb90a1353d-523e417412amr6716160e0c.10.1741564316400; Sun, 09 Mar 2025
 16:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250309164852.3936628-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250309164852.3936628-1-alexandre.f.demers@gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sun, 9 Mar 2025 19:51:45 -0400
X-Gm-Features: AQ5f1JrEq-MnltI03cY9wxMLOE8vlMUJIuPfZvJcrUrbLlqqZiEwRJipXfY30II
Message-ID: <CAPEhTTGLUwnW6sRbTkmn9fnUCtx_ktF_jgK-YsZnk2snEcciQQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Uniformize defines between DCE6, DCE8 and DCE10
To: amd-gfx@lists.freedesktop.org
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

On Sun, Mar 9, 2025 at 12:49=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Keep a uniform way of where and how variables are defined between
> DCE6, DCE8 and DCE10. It is easier to understand the code, their
> similarities and their modifications.
>
> Since sid.h is being wired up in dce_v6_0.c, duplicated defines need to b=
e
> cleaned up in sid.h and si_enums.h.
>
> V4:
> * Reorder patches so each one compiles properly.
> * Remove drm-amdgpu-add-defines-for-pin_offsets-in-DCE8.patch since it wa=
s
> already approved and applied.
>
> A bigger round of cleanup is coming to remove more of the duplicated and
> unused defines found in sid.h and si_enums.h and continue the uniformizat=
ion.
>
> Alexandre Demers (3):
>   drm/amdgpu: fix warning and errors caused by duplicated defines in
>     sid.h
>   drm/amdgpu: move and fix X_GB_ADDR_CONFIG_GOLDEN values
>   drm/amdgpu: add or move defines for DCE6 in sid.h
>
The descriptions of the 3 patches were edited before I sent them, but
I didn't think of the cover letter. They are:
drm/amdgpu: prepare DCE6 uniformisation with DCE8 and DCE10
drm/amdgpu: fix SI's GB_ADDR_CONFIG_GOLDEN values and wire up sid.h in GFX6
drm/amdgpu: finish wiring up sid.h in DCE6

Alexandre

>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c |  73 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c |  15 +-
>  drivers/gpu/drm/amd/amdgpu/si.c       |  68 ++---
>  drivers/gpu/drm/amd/amdgpu/si_enums.h |  12 -
>  drivers/gpu/drm/amd/amdgpu/sid.h      | 369 ++------------------------
>  5 files changed, 111 insertions(+), 426 deletions(-)
>
> --
> 2.48.1
>
