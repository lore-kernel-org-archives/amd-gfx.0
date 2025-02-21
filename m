Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946D5C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 22:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A13A10EB3F;
	Fri, 21 Feb 2025 22:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SGaN73kr";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC7B10EB3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 22:01:54 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2fc95e20e72so636249a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 14:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740175314; x=1740780114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz3M0SMi6W9NOUeRUo5Hso2eKAtmo3QvGPIBfijqr7g=;
 b=SGaN73kraiAJSRIAm8vlw5X9E8S9qxQMFm07b3phPXIh/U90KAq5SvCRPBSWaIFcGY
 rh6DNOxoq4EmnyafkikH5cPbX0P4mY75V0xT32AULVkwzzgEAWY1qBggWo8i/Vl4GhK/
 cq/+ghT1+UkGhRw0MLa3gd+aKuTrrh1q8nbXBWBLJ3sMExSI9kycfHVb/8deem8KLDoq
 mAGSuF7C2+4O/L+M/GmAQBXuwgivnjWvxFJ8OZeSOCeoJy2j6VB7HS2Q4U8K8Bg25aC9
 I20+LA+VmpB7PyjKYMFC8RcYB6f7rNegqgWLMsJfdEGgC1hcRM2C3k6f1SEycvQG/wla
 S4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740175314; x=1740780114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uz3M0SMi6W9NOUeRUo5Hso2eKAtmo3QvGPIBfijqr7g=;
 b=M31x6EfvXtHMFI/k4EZapITsGOzJuSxN+hm6dgLbZtz1GjHq2Qlzi0I57XzDwCrOMZ
 irKWEdBHngCYu209DeW6iyndAfqf+HwBGyz7H8rEdAViDEMGd8Gr9jWHe1Cxq7Mb8m/U
 fymapLVXG1qrf9MDTCqygG7GsWuCaCfJOir7YcSZjCHslmgesS+XM7vvhqdKH+0cee68
 RuN1F42PED2CF0OdFIvJ1/cc6lY5Dnr8ecQGEsc0QIKxQnX5Y0aDrn6s3XFsRPO6P7GL
 YciPXVUSuVPGa0ybTqRP3n9sBT25rvPqC8q2m4PeO4MyID2NK4gqRzv0ejljCd0VEHfh
 ydbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8ZgqKB8ErP5Dvtj+AZ9x09n+4B/J+Wm7j+BAVD0r2y+5Q03g1NyMnFt/8QkNaRcq0mdu6QgDv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0raOY+/N7xrFt8+az8Xx1ym12cjSa+JLLsyEp2yO8g1/8T7AW
 U4aVGxlNztz1cwee/9FzAVryrHqkSjpm1mXM3jE/D1lnX/6PGiJ8bjMr14thWreISkY2/8mvynp
 Rg6KN98YNdJDk9XWkl9aAxStXw50+Iom3
X-Gm-Gg: ASbGnct+cuWbiwLbRLAQM9+X+pST2yTIuNJdbuHYrCH2U6R+VklhGtN0LTsb0Qr2Edx
 X7vGIryoW986NgDOZrvFKenmW4OwPohyB93BnbmkExw0izx1SfIm5UfcO5REYObZPxrY3hnX5U7
 yE35UmCEc=
X-Google-Smtp-Source: AGHT+IFyI+Zj4wXtbFE39qOE7Hy0ERnFITe94ACaG9+v4GnKcNbVB8A1WdFqSeEv7aDziDIDt4yO1NYRFXBgOCXQCTs=
X-Received: by 2002:a17:90b:1e05:b0:2fa:17d2:158 with SMTP id
 98e67ed59e1d1-2fce75dfdb1mr3123448a91.0.1740175313738; Fri, 21 Feb 2025
 14:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20250221131734.37754-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20250221131734.37754-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2025 17:01:41 -0500
X-Gm-Features: AWEUYZmLLHrHR-yGpFohFLObqcZTutKrxkqXvapLXrJzEiXCIkJDl3DFX89wRq0
Message-ID: <CADnq5_Pzk05JkkkLa5qQTpSRKGW3fcGGFABs_vriJB42txDn5A@mail.gmail.com>
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

Possibly closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3812

> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
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
