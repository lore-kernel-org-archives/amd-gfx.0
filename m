Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94AECA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549E310EA20;
	Thu, 28 Aug 2025 15:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="blfhQqry";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C33C10EA20
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:20:33 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-248e3eade89so1145405ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756394433; x=1756999233; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlL2ooZNN/Sdc9QmNFQCL7KvIqRnmqRrGz/O75DCxL4=;
 b=blfhQqryAgC6FN27Agwo+sryjf92/6xYFi025qoqrBPHwpugdFmzQjNwbvpbvKTwCB
 +sOKiLi0AtkZh9+6ITE6vYFY4IjdxIcLQbb9hBeDdSgf5LaoQViitRnqXSSSRThVKC6n
 gwxKQVi7EB83H4WdG+itO3XHXf7VQiLS4bBzdjAqjoyXrkVX3d3zvkVKtrJhsJzJBtDU
 APwWJEsaahT+edMOuuZ83vvenKa/QNHqbuxJ0gYZlEE+tapT925XtVBpublfmh27NPVT
 H2rvFbrCIq/SfORvRhSCB1dFmSJQMWiRBEf1DSFaw4aDhud0bqSghfT3ZxQM7T7DZU+v
 /vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394433; x=1756999233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlL2ooZNN/Sdc9QmNFQCL7KvIqRnmqRrGz/O75DCxL4=;
 b=vVr8crKA7o0fnk5lvNClEfZmRbtvTXpZ+UykOUtOWoqW3YmyGddBcJfAk5fwojtF/x
 +Xt+7U2OE42px2IKxVCCVOPQRVyushcJde3uDrcmJ5BJSN9kSJ3XXO9y0vylrREIjZ9t
 /2F5KT7Ekge3WnLxu5Y/SpFmZ9hZDBvMImNhcd+PFRID+CTw/2tXceR5/Wi7NMVgwYtH
 0Aycb+d0JSOzoZGS3ruGoLIXIA05tzpx0K+uU2HlC590JEv2BMtOn520BZx26V7zL3VV
 ieVoW0JfI/tL4SyVro0hq3s24/Av9oOf9ecxdK+4X0K5q1F2sWDDA2SduKDRNlA1vjMM
 raGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhID9jXjvmXy2Z9nCJixaHoU+Bb4HUeTVb2pQLeFswXyNJ6B0DjUH1Q9Q6OILNZ3F4XYMqPOpf@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9wkyUU72KOIP2Ha+sIXTMxAAboHbeAXV7bHoHIpLdbuujg5ta
 bygAEjJgN/RS7dhSRPNNGotd5awm251p61hglbevlnK9lLgwTdRK9HUGUxAUGOwnzzLRwL9qIWK
 /M3vpxP2DQ/X5QT69b7+l83TtfvZtie9TvA==
X-Gm-Gg: ASbGncviQXOSP6pMWgULM9qIK/dczWc+G7AHZdc6CB7eEi8QrpqFSyg80mm6MRIe7NJ
 f78Jq6t9l7bdVBoCjFjk0qFbx+p31WzDMfX9holrF7E8jo2CxMOVu4GWpukId/Cs9LeE5SYwFSm
 SQEtqL9QMrRPtw5VnsQO1aN/+4+uCCOMW/DtVOe90aiKZUB4SqNpqbddQvYaZXf8YIIS7TZK6Zn
 pLwItxgXo7RM0hfpg==
X-Google-Smtp-Source: AGHT+IFjTWC5p4YWjM3Fz14eEpgFpz0H94AKIkR5ZJYp6G5jUjvN01l2A2dOoDBUsl7B/anycDsE7Hp4nwlAJkdecA0=
X-Received: by 2002:a17:903:41c6:b0:248:dd61:46e8 with SMTP id
 d9443c01a7336-248dd6169edmr17859565ad.5.1756394432835; Thu, 28 Aug 2025
 08:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250828070420.3948568-1-srinivasan.shanmugam@amd.com>
 <20250828070420.3948568-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250828070420.3948568-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 11:20:20 -0400
X-Gm-Features: Ac12FXy9Wji9EhtYg7hjHu9v_K8_PXTq2K-PRT9xUeU35Z_wDbdSr1M9GAdGxd8
Message-ID: <CADnq5_P=5NiBYBT1JLceXJhB5T4dA2NwMaER1r2r7DSHfjUGDQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] drm/amdgpu/uapi: Introduce
 AMDGPU_GEM_DOMAIN_MMIO_REMAP
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Aug 28, 2025 at 5:53=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Add a new GEM domain bit AMDGPU_GEM_DOMAIN_MMIO_REMAP to allow
> userspace to request the MMIO remap (HDP flush) page via GEM_CREATE.
>
> - include/uapi/drm/amdgpu_drm.h:
>   * define AMDGPU_GEM_DOMAIN_MMIO_REMAP
>   * include the bit in AMDGPU_GEM_DOMAIN_MASK
>
> v2: Add early reject in amdgpu_gem_create_ioctl() (Alex).
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
>  include/uapi/drm/amdgpu_drm.h           | 8 ++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index e3f65977eeee..d3c369742124 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -465,6 +465,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, v=
oid *data,
>         /* always clear VRAM */
>         flags |=3D AMDGPU_GEM_CREATE_VRAM_CLEARED;
>
> +       if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
> +               return -EINVAL;
> +
>         /* create a gem object to contain this object in */
>         if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>             AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index bdedbaccf776..fc44e301adbb 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -103,6 +103,8 @@ extern "C" {
>   *
>   * %AMDGPU_GEM_DOMAIN_DOORBELL Doorbell. It is an MMIO region for
>   * signalling user mode queues.
> + *
> + * %AMDGPU_GEM_DOMAIN_MMIO_REMAP       MMIO remap page (special mapping =
for HDP flushing).
>   */
>  #define AMDGPU_GEM_DOMAIN_CPU          0x1
>  #define AMDGPU_GEM_DOMAIN_GTT          0x2
> @@ -111,13 +113,15 @@ extern "C" {
>  #define AMDGPU_GEM_DOMAIN_GWS          0x10
>  #define AMDGPU_GEM_DOMAIN_OA           0x20
>  #define AMDGPU_GEM_DOMAIN_DOORBELL     0x40
> +#define AMDGPU_GEM_DOMAIN_MMIO_REMAP   0x80
>  #define AMDGPU_GEM_DOMAIN_MASK         (AMDGPU_GEM_DOMAIN_CPU | \
>                                          AMDGPU_GEM_DOMAIN_GTT | \
>                                          AMDGPU_GEM_DOMAIN_VRAM | \
>                                          AMDGPU_GEM_DOMAIN_GDS | \
>                                          AMDGPU_GEM_DOMAIN_GWS | \
> -                                        AMDGPU_GEM_DOMAIN_OA | \
> -                                        AMDGPU_GEM_DOMAIN_DOORBELL)
> +                                        AMDGPU_GEM_DOMAIN_OA | \
> +                                        AMDGPU_GEM_DOMAIN_DOORBELL | \
> +                                        AMDGPU_GEM_DOMAIN_MMIO_REMAP)
>
>  /* Flag that CPU access will be required for the case of VRAM domain */
>  #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED  (1 << 0)
> --
> 2.34.1
>
