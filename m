Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9128CCA472
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 12:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6187E10E18E;
	Tue,  7 Oct 2025 12:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R6AI/CKX";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5EB410E195
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 12:37:02 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b631a684a9fso81824a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Oct 2025 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759840622; x=1760445422; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QfZkwDwk+QQyswzpSf/9cHMyu5z64RMa1paTC1qoJI=;
 b=R6AI/CKXG4VzREWj/wqBaOSS9itO7VovuzDxXMPREFl6EwD+PtwaPbFHds+oD3h0+1
 U8VnEpmieHrJoZ0ug92Zgd5eqoK6+4VEWMOd/dhY9L7peqJ0tH/aXTPPxRLVF59sCFHW
 ogE0OtAZcHnubQTGTwHtzxNFygdTKlfGyAo1htiTXdJcoFBIlZ18X5uHGDRmwSHGvRQM
 i/edLVmTPn615WuY1vLlDW5CD+XS4zFlkXRCl3wYDL6oCxnRPKd1p7PNf78i9GCjDJzt
 nt0OtQAo66yhtVIo3ZTn+JgChgbWvPJyODcSeDMbAkv8/Oy4k+iFyciNru0i5rJxpGEo
 ogvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759840622; x=1760445422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QfZkwDwk+QQyswzpSf/9cHMyu5z64RMa1paTC1qoJI=;
 b=wbqcTfHx6fNpfyL9Ae4P+jrTURvJSq0KqEb15MUOrzdnH6ubLFoykeO5rG7lQg8OI1
 AFxlb279GtZSAUIWclugBCiv82ZcGU6wXF15PQmQwuhSXO2iAJSpPLG7P24KcbBQkKAS
 XO2opAvhSCw9ZEWeSnIZXq5A/touZLO0hhZOzQFHadZRHLpuJJn+7QSeNJF8sJwq6Vw5
 3nuLevDsBJto11CsutRiW7Q8RMfMFxJg6OKpNphHqTVZBfq1f6mv8jpm8198B1/HdkjD
 UZMm5UDaNxAaK36J6N5A6Epv8DNGWc/CbiO4MiMsDxhH2YyzEw97fVG7AaFEMCqCLRxa
 +EPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFouKjE1tKASuojbZh6NG2cD9FwMR4n957VBP1HYiGeGRAdQP2cfnoNonE7LE8dpBglCatdZal@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYfAa8+Wbr4oz7ab+F7xDXvBnRlUuiTYXpglspjI34rcTFhlOT
 NOjEswHlp2cqRJzaDz+4fjvocAlEkpPVWqcwt/2amqfoaaZFIV7tcNeabz3qJa/uTCKWjKuuoUF
 y/o4JTBaPwFVYYrflMSrIIjY6DMYekTc=
X-Gm-Gg: ASbGncsF3hGxVw6Xa3rU/3ROUnbbkQzv5rx/r6gMy1bwoJINqZNYPXQVqkotraue5BP
 tFcVKXJo24ZQUfIcmkdYAbPXY03bxf7SgsaqswanqIa/Wtn3BBCldwTaHhqaS6Fmrsd4SimNwwl
 yr2DGk2g5x7UeA4dpLeYleMuvvVMORfGz68pvk6BQkbBNogEXt2Q2rdHyIuM8WjBOoBD+11aSxr
 LCSIxhti3UZojU8BtYQs0DMTxKjOpU=
X-Google-Smtp-Source: AGHT+IH5Na4m7qeXIOMATGIdl+nhKbH9dWwAnnC2K/UUgAzvDLsy6xfk1LYkcbiGIToZSdHXMXFiOyBDzqLSv3zrmsU=
X-Received: by 2002:a17:902:c405:b0:27e:da7d:32d2 with SMTP id
 d9443c01a7336-28e9a65421amr116844885ad.7.1759840622073; Tue, 07 Oct 2025
 05:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20251007091925.18470-1-christian.koenig@amd.com>
In-Reply-To: <20251007091925.18470-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Oct 2025 08:36:50 -0400
X-Gm-Features: AS18NWDffffBx9BcIrNKW55ONF4tRpuU6GW19FTXBmwu42FqUdovtdhs_nFqTGs
Message-ID: <CADnq5_O5GZHfU8kr+RXfD=J=oh042yXkD+M6WeWT0e6CEK_3kg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: hide VRAM sysfs attributes on GPUs without
 VRAM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Tue, Oct 7, 2025 at 5:26=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Otherwise accessing them can cause a crash.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index a5adb2ed9b3c..9d934c07fa6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -234,6 +234,9 @@ static umode_t amdgpu_vram_attrs_is_visible(struct ko=
bject *kobj,
>             !adev->gmc.vram_vendor)
>                 return 0;
>
> +       if (!ttm_resource_manager_used(&adev->mman.vram_mgr.manager))
> +               return 0;
> +
>         return attr->mode;
>  }
>
> --
> 2.43.0
>
