Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A92C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 13:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B1E3899B7;
	Tue, 18 Jun 2024 13:24:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YPxKKbQP";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C00CE899B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 13:24:02 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so39146495ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718717042; x=1719321842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ne8Mlm2iHImTerP59opru8QlFgsVaZtkmNEFrBf1hY=;
 b=YPxKKbQP1mHiFF6Vin7vdwQgKdKa/kL67NsikpKaps6+ubOr7TTu3t7csla8XWCiDL
 5F0wHzOQnUhB7El1IC3yTbQsgo97DPEY0ytxTnhCIQPPQNzhzAfnW2jGjCZQ1pY+WpqL
 8LQGZVQP6ZfKPZYHBgJOx+gRxEVYbx8HMLoYuKDauEsAuOcUpjNgDR6ktz/D+S7PN8EA
 6SuGztV1PsQioy63F/VOD5hhLHA6hvoAuAtrv2rCJYxXTSyofhQoI7TxBwEUYV+RDXz4
 qwiuCPCaN6yXvxwfFylrDKY1p5bXhog+udUDqUfSFPy4avz393MgpfOZJTV0gItTNdr+
 fxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718717042; x=1719321842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Ne8Mlm2iHImTerP59opru8QlFgsVaZtkmNEFrBf1hY=;
 b=UNBiE3k2MG7b0QPs6d9p9j87sfS7bB9V+qkjuOEDZOmj1UvIuHa7/9K2vmhGEW4Igm
 Uyey3tnjZ/C2Bxoyr5I7zvpVz1vcXY09f2boS0vBpdd7FDpnfnpA1hUNuajaELKKJy9h
 pxvCBcJPPxxGTfBBGjkCAeIyhRGWmPKdqXcUMKU5efMPodpUrPObbwzo3+0Jv4H/IanL
 rI6A2YuU3hSHwx/T4o3De+BOoZJPuLhVFpYkkmx0BC/h5DrUo/csKA0id+wIpk2iP9gu
 U4btq9Rqgk56a1EU9gj0+B2olu+ReVIUsn8leeBgdXOGq9nF39aRdDNlhc1bQuynUbJV
 k3vA==
X-Gm-Message-State: AOJu0Yx2Y0jFffGtKis+0z0UpwQkows+stYe5wIIcogO8W9I+3Dp3Aq5
 EhIuTUMoesw3xw+Eoz42uTedxiXDAE90LTHls5goz0lGZYJTtjVilIlsQ79P/pEBaLFickuY9SX
 4oHT7ofzE1zC3+bXBCaxzL04wOUpkXA==
X-Google-Smtp-Source: AGHT+IFS0NxH4QToe2h0lmMz3gk+flE3qPMqOqt856ZbXA3qJRG1OtgCeCgKe7BZ0BHD055C4BgmVVvijeAG0Enuv3Q=
X-Received: by 2002:a17:902:ecc6:b0:1f7:3bb3:abb5 with SMTP id
 d9443c01a7336-1f8625c070amr142188515ad.8.1718717042127; Tue, 18 Jun 2024
 06:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240618130033.3721-1-Frank.Min@amd.com>
 <SA1PR12MB565900CF1142A9A43F8B0921E9CE2@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB565900CF1142A9A43F8B0921E9CE2@SA1PR12MB5659.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Jun 2024 09:23:50 -0400
Message-ID: <CADnq5_NhFZS5Fbwr796Rw5kvqVKfWSS-gejPx5wdErVc0SFkKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update MTYPE mapping for gfx12
To: "Min, Frank" <Frank.Min@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
 "Gao, Likun" <Likun.Gao@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
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

On Tue, Jun 18, 2024 at 9:07=E2=80=AFAM Min, Frank <Frank.Min@amd.com> wrot=
e:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> From: Frank Min <Frank.Min@amd.com>
>
> gfx12 only support MTYPE UC and NC, so update it accordingly.
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index 26122c8cfcc3..61db331adcc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -464,10 +464,6 @@ static uint64_t gmc_v12_0_map_mtype(struct amdgpu_de=
vice *adev, uint32_t flags)
>                 return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
>         case AMDGPU_VM_MTYPE_NC:
>                 return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
> -       case AMDGPU_VM_MTYPE_WC:
> -               return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_WC);
> -       case AMDGPU_VM_MTYPE_CC:
> -               return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_CC);
>         case AMDGPU_VM_MTYPE_UC:
>                 return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_UC);
>         default:
> --
> 2.34.1
>
