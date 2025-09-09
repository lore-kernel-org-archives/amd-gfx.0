Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5809ACA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 13:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5E310E706;
	Tue,  9 Sep 2025 13:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cfzY2zjQ";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE78510E706
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 13:04:00 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-24aacdf40a2so14267885ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757423040; x=1758027840; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S//34kv4YyoaVA0VToN7iyF0o3HCXGX39bZt9+j2mFY=;
 b=cfzY2zjQ3O3zgGkxzPbNeimzK+VhG8t7C+SQQkHJcaGT27U9bU+gkphxUTahiGYcNc
 ul5TR8A03gQ4owmsU7xxa/umG4eJdECzDY5R1yyy3yIdyxGDtFPGf3Ye3npoenogSbzm
 x8se2JGOT6yhVe3YUP4ureGAU4K/8SiIgaQaH6HuY6Mj01iu5hZxbQjrPSwV6k5nedAO
 9g+W+62adlU9oG+ppx4vLX05hLjFFo5d6ZnJVM4GdcFlS8SR15EGFdjQBxMqXdulqGx6
 u0QwXJfla+tEZYDwFJhTQRoa8tl8RXdZhjQrBTagK9pUV/CH4pzPjIsEntrjzKLMDTEs
 55EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757423040; x=1758027840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S//34kv4YyoaVA0VToN7iyF0o3HCXGX39bZt9+j2mFY=;
 b=n3kkoxEgtk0ZUaXtog/RXA6odPTRn7XDFQpFItPE+q6DNJazWXIELHLJpdrIrqEgaI
 8lI9QdPkzf9LpVI2k2OkjkKXG3arkWckQEOtlQM+hqhSxDl4bwx8kM/8zUa0Qb0FF1Bn
 UfztQ1NwJWDBJheEcD73QycVVXMoTbBUyIfLvcjI25SFZhnlIx13mjj4jlHLj9tmgx1g
 HpSquXnXLlmiwFycaRk2CmmYChngUtwQYsl6w7YIOd/dUjOIqLdfS9hY3vM0CSqFEhpF
 6o/amoJt5b5U9IsgY2J+vpXiPCH2l1qp7CUngPixwQuseFBTeN4kOJSD1dB1E49Vugm5
 /EPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDRIU4Ec5yki80DAhq3sYGXcdEIEOh9RdDsHggZwxAQysTptcG3VbUJ+IFwtjcSIK/UEGiY1ZM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjyCv5hESEwLtSe8u76skyrshKcRhC+NIBs1jnVAdabj69Wisc
 8W1peJhvzZxWWZ/lnZLIhWDesqe8qKL+uApbrsPNqgEydi7SbkpTLdz6kmDCI6IR7vX8z54p7xW
 K2U8/wAcmYPLnzvCEQuJuvb0jrD0j8RU=
X-Gm-Gg: ASbGnctUHy0Kn6x2cndH+bnA+zMaxPDVt5Hwy/RjfwFypSLci1hNxK/L1CaiGUt5mMX
 Vkj0vcVYlmkUqwnHLJMu1TiuOYK0KP5kkHGBKVGzhWNDelh731r8yeD2LWsakCKzOAS9YJp+xpx
 KYOPsKV+8lv7lL1b5hesC8twHL5Ma53OMZElQR+7btDXgK28Zc2CahBdBVSJNVMqMgKgX8JLlUI
 P/TWtg+SMdj17mGcw==
X-Google-Smtp-Source: AGHT+IGRBxYEbLLG7ZikotbrdTaUnM4gOvEio6VH36wgab4BI5/mbOsGEC+6C01L/0G1HLVTpDK790L+Yd0ALAL4HlE=
X-Received: by 2002:a17:902:c203:b0:24c:b1f4:88cc with SMTP id
 d9443c01a7336-251757bab71mr63331905ad.9.1757423040088; Tue, 09 Sep 2025
 06:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250908232134.2223198-1-siqueira@igalia.com>
 <0c1d66d1-0a73-4846-82b3-46f1e3889e8b@amd.com>
In-Reply-To: <0c1d66d1-0a73-4846-82b3-46f1e3889e8b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 09:03:48 -0400
X-Gm-Features: Ac12FXy-c9A3l2AyCItD829C2wlym0CVvZdeycI9lYoi0_nF5jWDxchAG1e7RY0
Message-ID: <CADnq5_N5ae3h+EES5meomp_OnWmT+gj9ZuFQaONoxa7S+siPDQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Remove multiple instances of volatile from amdgpu
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

Applied.  Thanks!

On Tue, Sep 9, 2025 at 4:34=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the enti=
re series.
>
> Could be that this uncovers a bunch of missing memory barriers, but that =
is pretty much the intended purpose.
>
> Thanks for taking care of that,
> Christian.
>
> On 09.09.25 01:15, Rodrigo Siqueira wrote:
> > In a series that reworked the CSB manipulation, Christian noticed the
> > use of volatile in some of the function parameters and pointed out that
> > the use of volatile in amdgpu is probably wrong [1]. He also shared the
> > following link about this topic:
> >
> >   https://docs.kernel.org/process/volatile-considered-harmful.html
> >
> > After reading the documentation and inspecting multiple parts of the
> > code, this series was created to remove many parts that use volatile.
> > The three rare cases where volatile should be used served as a guide fo=
r
> > making this series.
> >
> > [1] https://lore.kernel.org/amd-gfx/b1c2d811-132a-47e5-a13f-086125b849b=
5@amd.com/
> >
> > Thanks
> >
> > Rodrigo Siqueira (5):
> >   drm/amdgpu: Remove volatile from CSB functions
> >   drm/amdgpu: Remove volatile from RLC files
> >   drm/amdgpu: Remove volatile from ring manipulation
> >   drm/amdgpu: Remove volatile from amdgpu and amdgpu_ih headers
> >   drm/amdgpu: Remove volatile references from VCN
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 ++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  6 +++---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  6 +++---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h   |  6 +++---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 12 ++++++------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c  |  4 ++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h  |  8 ++++----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 10 +++++-----
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  5 ++---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  5 ++---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  5 ++---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  7 +++----
> >  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  5 ++---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  3 +--
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 +--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 10 +++++-----
> >  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 10 +++++-----
> >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 12 ++++++------
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 14 +++++++-------
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 12 ++++++------
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 10 +++++-----
> >  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +++++-----
> >  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 12 ++++++------
> >  24 files changed, 87 insertions(+), 94 deletions(-)
> >
>
