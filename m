Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB0ACA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 21:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7882810E293;
	Wed, 20 Aug 2025 21:47:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H8rvnbXV";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C597810E293
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 21:47:43 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2445813f6d1so573145ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 14:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755726463; x=1756331263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3gQkhXDlsglVRh/T49UjP/ev+Nb7d7xnbZD9YHLimQ=;
 b=H8rvnbXV+e4wBd8vk16gfJTLJJXmZBDgaS4+WtLFzmKYi/MtTAmQq5+AReNm0jzsqk
 U6ti8oILPDW7SiXENc0wtKpm/0bTY5r20IBtMtTsSbA8SuNGrE9aKvkbQ2f1EXP4ncWp
 7gZKxUOEjjGPukc/m93zS96I65XzKk1hJ/KaFPZJwT/eskiYNsDwK23c77tRnWuIm+yA
 AtXMoJJ3U5SPLlfwhmjshx+23Zgv4HOqeXrKWyqDVadvsAGCMwEGVNVfVRCljY2Hhmnb
 cI/3Q1UfKUdSf+tPwJHqTQmdpr5YtXohv1IPCXZgvmj3b2NOO7zOLSGyWtNrMxwrhD5N
 F8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755726463; x=1756331263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3gQkhXDlsglVRh/T49UjP/ev+Nb7d7xnbZD9YHLimQ=;
 b=it+XG5YtReQG42VrsfYCheYT0kRrt7j2/Ju65AcLDUaekqNOqEA17Hn6+mpyMe3JJf
 zD88aRAOuag2Mlz2lJdCYak7ghkcPDZBx0/kNlsaGhg4PXVEUhXaTkvZGFsN90RrgpHl
 zZAHz7krwzyZr+s7HqNLsfK7sNDhzIqAFrRpQr0UAKbkbS8HOtmIvTw5hcW9bFIwP5f+
 24uoL4W8J1y7pcsnITrnX6hmY7vYGZ+YWKshuXzQzoynMWpxfVv9Y9oYX3znwh3zPazO
 kzL97Yq168anX06DDjKumVd0HXeblP9GEtr5+sOKKvll//Jt9dQIb39lKVcPjXZJXbsl
 GAmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPShevSgQu9Sa+L4N1rfSy4Fp9EBTpp3ajq5gKgEsQRuOFcNwuPcSmZg9AXuQPW0eYq1ya8T07@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywl5Tp+Basf1wjZlbgtGj+N+h35RH6acIRplCNgUCD9soQCr/Ym
 Th20szRD/WgqkbMaED7cXvYZChtm9ALt/5sHhe+GEfHYHD1WpbZ67o22hESyDA2o17O+xw9VADz
 tjpp3sBatHQLG1/Px3Mxikv8FZ4iOtYlD1F9c
X-Gm-Gg: ASbGnct7AYn0DvosAoYrhs49GQXH01vLyz0xQmVfh7S6Q85qKvM1WfxAO5RJbfUou8o
 chNF4xs7Q+1kPXpmJqUijwxLsora/Drc8LG43sNU/IJIwvISiBnYG/FjXEcf9IxqQEg9Rp9OUuv
 0vyT9SINHW77QotXdzWdEw6jB3TQHeDrDMApCrlGv5FmNdSygSorFPiFksTF2Aa1WtlVQvP4x96
 iQDQBI=
X-Google-Smtp-Source: AGHT+IFkfuitAbucoytc0YQwaGQCO1akEmB/6sCQEMEvqcyaDnC4H9p8bi4v+uFwFl1vSJCpH2TFgkzS4VBrElj4eEU=
X-Received: by 2002:a17:902:ea06:b0:234:f1b5:6e9b with SMTP id
 d9443c01a7336-245febf32cfmr1995275ad.1.1755726463240; Wed, 20 Aug 2025
 14:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Aug 2025 17:47:31 -0400
X-Gm-Features: Ac12FXzOoBWKBSEh4bYiiUVhhpm0XkszzuE4Xx9WX7rglAM1jN2mvDaC7DL1l6c
Message-ID: <CADnq5_MZy3hpz4UCCve9Nwm0DseTkeNQe6GL7wc+kj6NUqxzaw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] drm/amdgpu: add MMIO-remap singleton BO for HDP
 flush
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

On Wed, Aug 20, 2025 at 7:58=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This series introduces a kernel-managed singleton BO representing the
> MMIO-remap (HDP flush) page and exposes it to userspace through a new
> GEM domain.
>
> Design ------
> - A tiny (1-page) TTM bucket is introduced for AMDGPU_PL_MMIO_REMAP
>   (mirroring doorbells).
> - A singleton BO is created during amdgpu_ttm_init() and freed at
>   fini().
> - The BO is kernel-owned and never evicted.
> - amdgpu_gem_create_ioctl() recognizes the new GEM domain bit
>   (AMDGPU_GEM_DOMAIN_MMIO_REMAP) and returns a handle to the pre-created
> singleton BO, enforcing size/alignment checks.
> - Userspace thus gets a stable GEM handle and can mmap it to issue HDP
>   flushes.
>
> * Only compilation tested so far (x86_64, defconfig + amdgpu enabled).
> * No runtime validation yet.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
>
> Srinivasan Shanmugam (7):
>   drm/amdgpu/uapi: add AMDGPU_GEM_DOMAIN_MMIO_REMAP
>   drm/amdgpu: Add New TTM Placement - AMDGPU_PL_MMIO_REMAP and wire up
>     plumbing
>   drm/amdgpu: Plumbing for MMIO_REMAP memtype and user-visible strings
>   drm/amdgpu: Add mmio_remap fields to amdgpu_device
>   drm/amdgpu: Implement TTM handling for MMIO_REMAP placement
>   drm/amdgpu: Create Singleton MMIO_REMAP BO and Initialize its pool
>   drm/amdgpu: Return Handle to MMIO_REMAP Singleton for GEM Create

You also need a patch which sets adev->mmio_remap.base and
adev->mmio_remap.size.
E.g.,

adev->mmio_remap.base =3D adev->rmmio_remap.bus_addr;
adev->mmio_remap.size =3D 4096;

Better yet, replace adev->rmmio_remap.bus_addr with
adev->mmio_remap.base and just use that everywhere.

Alex

>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   7 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  56 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  13 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   2 +
>  .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 112 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   3 +-
>  include/drm/ttm/ttm_resource.h                |   2 +-
>  include/uapi/drm/amdgpu_drm.h                 |   8 +-
>  10 files changed, 198 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
>
