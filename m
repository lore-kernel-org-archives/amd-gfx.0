Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFBAC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFEF10E7A5;
	Wed, 28 Sep 2022 19:03:41 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4B110E7A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:03:35 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 j17-20020a9d7f11000000b0065a20212349so8745510otq.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=r2brQRNapH8f0IjepWQXDpTqbSNUKb4X1pLYaWVnXyc=;
 b=fMbumbWU8ddV/xPCxpbAgukg2dORwptxMxIm+qcK3Cg/BpCBkw2IOagPxrMd0qmkqQ
 eCygPCmvZlUgPW6+5Q6L1DTnQnccWYkeUQgu3gUTXQ5oPKTBLvYIK14XnHtHK+KoS1Ec
 MKe0u+IQ6b4tMXg0sO/ZJw15g5Rpqwd0WITeUIUCD36l6CE846wZnSjN+3FaBTz16mpd
 SGYxWDWY0oFE2u2mZRs1muqvxAuQK4p5gfaX5CIEuwhQPttpgPLLQpCVUOUHHXuYm7TR
 Hh4RhkaRs5bXUUnv50ZWg5XawvNcvmsxxt6qNdJcHsrMQzKxn8cXyWHTi1F/t6CSSAJh
 ZoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=r2brQRNapH8f0IjepWQXDpTqbSNUKb4X1pLYaWVnXyc=;
 b=G9JFXH/wQDdK3NHGNX9L5uoA6WN+Aq9bJamCHtuH8Tdz8TT1NznZHpxYYtQCZrIfhm
 zFnJ5Mo0Avq1S5V8RbtqC2SNPZY/4r4TgDm7rJm31t8ZoP486Htm+lGZUbj/X6ZVaJpz
 qbyfUzUSm0OxM9Juz5hgasWtvYHMdiMZ6J0GvGC5PfuNX2PZ6e3JGFnJ1l75nfsjl6fw
 Ejue+DBrdktW0V6l2LtfGcHvjCBdgWkwSxK+VWYQHpTEKjJli0vSFgHRPCwAMm8RVwGN
 N1hsJ2tzspiDJYKD8/kRxOGCja5fEIDQI7WILvMUuTjmvoinxiYGom2t3uKIVK18Rv+p
 g0Ug==
X-Gm-Message-State: ACrzQf3XcFmbS2RZwLJcjmjR0yIMY7eR7Z2N35t634qIawoewUaBRcJe
 l4Q8pD+mbnOkW6VJ15a1MdPi0e0v2eTuY1us/UY=
X-Google-Smtp-Source: AMsMyM7ZVpuBz7Mdr/jUA0koud+DZnmE6ilFLXqxIkF9urbQZk5B6iR5kVvqbu+hyRYRvdcRd3yJ0cLT2+TmBW4Povk=
X-Received: by 2002:a9d:376:0:b0:655:b4bc:fd6e with SMTP id
 109-20020a9d0376000000b00655b4bcfd6emr15395754otv.233.1664391815055; Wed, 28
 Sep 2022 12:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220928152117.1602358-1-Graham.Sider@amd.com>
In-Reply-To: <20220928152117.1602358-1-Graham.Sider@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Sep 2022 15:03:23 -0400
Message-ID: <CADnq5_PtRaLyzLGPcWm5Y_hwerWOPCuuYoe27ChikBxUApzKgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove switch from amdgpu_gmc_noretry_set
To: Graham Sider <Graham.Sider@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 28, 2022 at 11:22 AM Graham Sider <Graham.Sider@amd.com> wrote:
>
> Simplify the logic in amdgpu_gmc_noretry_set by getting rid of the
> switch. Also set noretry=1 as default for GFX 10.3.0 and greater since
> retry faults are not supported.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 48 +++++--------------------
>  1 file changed, 9 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index aebc384531ac..34233a74248c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -572,45 +572,15 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>  void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>  {
>         struct amdgpu_gmc *gmc = &adev->gmc;
> -
> -       switch (adev->ip_versions[GC_HWIP][0]) {
> -       case IP_VERSION(9, 0, 1):
> -       case IP_VERSION(9, 3, 0):
> -       case IP_VERSION(9, 4, 0):
> -       case IP_VERSION(9, 4, 1):
> -       case IP_VERSION(9, 4, 2):
> -       case IP_VERSION(10, 3, 3):
> -       case IP_VERSION(10, 3, 4):
> -       case IP_VERSION(10, 3, 5):
> -       case IP_VERSION(10, 3, 6):
> -       case IP_VERSION(10, 3, 7):
> -               /*
> -                * noretry = 0 will cause kfd page fault tests fail
> -                * for some ASICs, so set default to 1 for these ASICs.
> -                */
> -               if (amdgpu_noretry == -1)
> -                       gmc->noretry = 1;
> -               else
> -                       gmc->noretry = amdgpu_noretry;
> -               break;
> -       default:
> -               /* Raven currently has issues with noretry
> -                * regardless of what we decide for other
> -                * asics, we should leave raven with
> -                * noretry = 0 until we root cause the
> -                * issues.
> -                *
> -                * default this to 0 for now, but we may want
> -                * to change this in the future for certain
> -                * GPUs as it can increase performance in
> -                * certain cases.
> -                */
> -               if (amdgpu_noretry == -1)
> -                       gmc->noretry = 0;
> -               else
> -                       gmc->noretry = amdgpu_noretry;
> -               break;
> -       }
> +       uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
> +       bool noretry_default = (gc_ver == IP_VERSION(9, 0, 1) ||
> +                               gc_ver == IP_VERSION(9, 3, 0) ||
> +                               gc_ver == IP_VERSION(9, 4, 0) ||
> +                               gc_ver == IP_VERSION(9, 4, 1) ||
> +                               gc_ver == IP_VERSION(9, 4, 2) ||
> +                               gc_ver >= IP_VERSION(10, 3, 0));
> +
> +       gmc->noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
>  }
>
>  void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
> --
> 2.25.1
>
