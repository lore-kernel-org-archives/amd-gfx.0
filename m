Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11697C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA45610E251;
	Fri, 21 Feb 2025 15:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eRAWAlY4";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D738610E251
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:16:43 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-220cb083491so4653305ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 07:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740151003; x=1740755803; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkQGcE6r8wub/lD2EMiM7DFrpCugjTMwJN4etFMj2IY=;
 b=eRAWAlY4W4+SaECRR6BsonRyJOnEghf3gpHfbct4eOF2Sn2ZD6ylh9Zz9NWi12a67R
 DP6VXkP30CrBBK9uKtnMeXgiimbqDVrdpJv1M5A0xQ1VeR+47/bVotmxQAWw1aPcC+MF
 IsA56JtdNTA03BcjAFb49baBrwSg5KPjRMwA64RBLRTOYp0/YjFYy30AbHZ71Lq1DvOS
 fyZzmp8nca5Ns5H66++/FCrYX+7TmNrSmXEp6bvQiVzCcgP5hxyfWorryutP4nEH3xsz
 ZK+/ESoyQIzozNz80azq2srmh7oiBb2dsB/ZBYBVemGuPJPk5v8eM2LcJRf7FQgkJd1l
 ZbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740151003; x=1740755803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkQGcE6r8wub/lD2EMiM7DFrpCugjTMwJN4etFMj2IY=;
 b=tDVmhPOkhqNmXhUmYaq3f6UWs3SYp5xnteXPoGRK/a1oeY7/TKpamEGyO61ADXEKj9
 EtKr18oi9VNIf6dL/FMTSsiV5XNYuYELQ2tkSX4N4DZz8R2PIwlNiuS5XZ52l50/frDR
 xDAHWc/Uj89HQbkcRdS+E/AIrqfQDp0zWvjPtALr0jLRn3QqbZDr0GMmANY2BIRQQj3+
 Nb968wJRFk3DA/kk/xVwzcYvoDJxXQMIpvd5SeNOPfOFz8SCFb8lKRcnjFWKs1O46r0s
 et8QTY1greflyA0fAjQKn21Gs34gZdbP+eu33yjTd4KdewE3yeM+RPBd3WzH966st0uN
 f3MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3DCH9i4Tn3p4W6+fxdu13xnUDq4eD84ODmOHmVvcLtoDRWfEm57jcNXiw11KGyobpZgljTUnN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxN4ZZibphbux0Gd1XpdGiIIOjo5R2HYZn47kFTbAQGpwCmkW7j
 tD24n25U6oFWIle5p1fq0c9kSrzWc/WAK0UU7lB2NTHZui29CwWYjN8gpQVUZb2wXrTE1eqCyga
 i4kPYQ0uwzlNEgIXFNOF+ro13FExGLw==
X-Gm-Gg: ASbGncsb9L51acebVRPJE4v/wic1JegWdwVCsNvk+ipib2qmh64H4N0APiU1Tg8flVD
 UTAz6alnprDDT8ZsKXjcQOv4N618TTfaKfPn1lBKHZsqKguNBYdpVSWyP82hC0fD3DyVNaY1It4
 Ko2NVzqAM=
X-Google-Smtp-Source: AGHT+IFZkBLEZfbGNV8Evm9yhKGNXQ3q/hpBssyMy9b5Q2A6vTOimuM2TFAJf92zn+Li6iB7EHRt+xxFFwNUw/Iaa78=
X-Received: by 2002:a17:903:2351:b0:221:7b4a:4774 with SMTP id
 d9443c01a7336-2219ff61f54mr21205575ad.8.1740151003217; Fri, 21 Feb 2025
 07:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20250221131734.37754-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20250221131734.37754-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2025 10:16:31 -0500
X-Gm-Features: AWEUYZn8mlfR5e7EFx5R9YbIoFcn7saRAkbPATkpKEY9FNsNKrtOsGQTC8-rxhg
Message-ID: <CADnq5_O1+FnWcq_-rhfmfuVxg2Ux-CB3HOd+JWv1aQ6NJdUuGw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: init return value in
 amdgpu_ttm_clear_buffer
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
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

On Fri, Feb 21, 2025 at 10:13=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Otherwise an uninitialized value can be returned if
> amdgpu_res_cleared returns true for all regions.
>
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index a30985c8f539..e8d7c23f22c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2295,7 +2295,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>         struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
>         struct amdgpu_res_cursor cursor;
>         u64 addr;
> -       int r;
> +       int r =3D 0;
>
>         if (!adev->mman.buffer_funcs_enabled)
>                 return -EINVAL;
> --
> 2.43.0
>
