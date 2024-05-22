Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4539EC25B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 13:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D017D10EEA4;
	Wed, 22 May 2024 13:54:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PN6D+yU/";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBFD410EEBA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 13:54:06 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2bd70bd741bso682465a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716386046; x=1716990846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzT0fBhjsPdQXNDMBIkRHXF/bN2AxsKxnrcEhdkNBT8=;
 b=PN6D+yU/70f9jdj8pot/fslAISRX/xpWO/hmxCDAO+5AyCPWX8W5IFjYLH7Y6CAM17
 ayGYfH1/L6ljBGVL0AncB6YvXfjKmc2jh5I9hXMKhEs6mFbUmCMb6A7cI0W3I56j50Wl
 TBjFrJf1EYNkp+y6fZFlHbByxFeuijy7UzUZAzYQSIBAok8I6FMKq7BacSjzr8vpUyqc
 d2/ypvZP32WlVnFtUuI/AXJTQZn3AczhZsghki6lsKpDYLdzeOwXnJzkDhNh65PZm7/h
 tgPA//bC1XWut/jVQzUMI8x6pQ7zK17uSaMPrYqOvdU71Uhrl5mtO3Fe/molX8shtHDS
 iC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716386046; x=1716990846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzT0fBhjsPdQXNDMBIkRHXF/bN2AxsKxnrcEhdkNBT8=;
 b=HfAjwCZR0SqQUxW82gOa/JtYEsu6zIzgdRmxbJEwK0ON3hSaFjJOpkH6uxay2oVVm2
 /hsTo3GPsKiX9IF2kvd8CV2P5YFTCy9vhNoAv6hOGHDzAQsKS8RS7B36+4F6O1DRs017
 cM5o6eWFUgLvn28hVT8hiZpliRESKHnMzQN77kWAPKla1HceedRNJwqJgh8abDYq1tsu
 OMOga1THWxHdze687Re9mTNLSz2ZgUsEYdUXjHKDqScD3Sf4eY/ltAXtQWoyc6C8Z9Oe
 BuXsvzfZUBf1+cS5k8tKl5kpOKTkjywWmDYFFalZTNEwbOj5AqwyVDZNHtnE2ctrNqmY
 XZqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpDiooXIvSolStwzoKjlsqfDYIcPYfpqQ77vEe2z0D9OXhNRU7fieblQ+V7dJM59e8PQUxwH+WnoEHnjZkIrH5tv8Gr3BneCqI95trGQ==
X-Gm-Message-State: AOJu0YyuXXes+uyokcQC0JY5iVaTBIA97vdT/Ttv/FDEVPXOiolGD3qV
 n+mH80oqIinklB7pO2bXQ3UELpeaCFr2TBHyQgMO+T5cKXahA+HwZkH6BZzmNP7g03ns9tIhTG8
 LNS3jt5zNsKjXzszmhtP4COi8c3w=
X-Google-Smtp-Source: AGHT+IHkiPhmmsweepjsyWXkuyMLLnGy3rFFDH+ywnfAu0Tp1WJYhERqB4ix6rOSg1fen2cdGAZ3F9wLeSWB24SqIRc=
X-Received: by 2002:a17:90b:145:b0:2b4:32be:4442 with SMTP id
 98e67ed59e1d1-2bd6037a798mr16837875a91.9.1716386046227; Wed, 22 May 2024
 06:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240522072950.9162-1-sunil.khatri@amd.com>
In-Reply-To: <20240522072950.9162-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 May 2024 09:53:54 -0400
Message-ID: <CADnq5_OcKf+xjFpJa_2VJOdLd3UMqi5VWuo44dP-HhmVXSgPFA@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] ipdump support for gfx10 and gfx11
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Wed, May 22, 2024 at 3:30=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> With this support for gfx10 and gfx11 ipdump is complete.
> Also added dev_info needed fields for devcoredump.

A few comments on patch 4.  The rest are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Sunil Khatri (10):
>   drm/amdgpu: rename the ip_dump to ip_dump_core
>   drm/amdgpu: Add cp queues support fro gfx10 in ipdump
>   drm/amdgpu: add gfx queue support of gfx10 in ipdump
>   drm/amdgpu: add prints while ip register dump
>   drm/amdgpu: add more device info to the devcoredump
>   drm/amdgpu: Add missing offsets in gc_11_0_0_offset.h
>   drm/amdgpu: add gfx11 registers support in ipdump
>   drm/amdgpu: add print support for gfx11 ipdump
>   drm/amdgpu: add cp queue registers for gfx11 ipdump
>   drm/amdgpu: add gfx queue support for gfx11 ipdump
>
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  21 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 220 +++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 323 +++++++++++++++++-
>  .../include/asic_reg/gc/gc_11_0_0_offset.h    |  10 +
>  6 files changed, 564 insertions(+), 16 deletions(-)
>
> --
> 2.34.1
>
