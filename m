Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAF6D1D480
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 16:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E95D10E791;
	Thu,  8 Jan 2026 16:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DJszzEnK";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3570C10E791
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 16:11:12 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-5ecff6ad721so126642137.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Jan 2026 08:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767888671; x=1768493471; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKkvDupx57dp1bwwUHgSYHPAHQDLKaNR2pdTSvi1dQ4=;
 b=DJszzEnKYoSblpdNt9BC7+0AqG9HfNikezA2khWTVvK7TnKLk/ioLxoxRUsjunCYbf
 DYaf+SIsNkbBeZVxhGWniwRDOkE9kFdvfjbbejTrzEM+Uhw16ABXvtrt2nARx0EbWFj0
 vphw258zi6XLiD7wVmuXgvpdPANTxm+RFQLR9Ja33aa9Pf6xz7zIv4CeLrPwcklo/BkI
 +H/V4jP+/MNycOngHnmxuSwcVPhthr6kWuyXkfMexER/ktnQOOPDdlPKVMbToVdChM1J
 x5YTdpj/WBoOaSB+eMnmdQq3Vyhp8lHn/Dl0wxAcu2/pCvikh/x5vmyGA2YvhxGs3wqI
 BdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888671; x=1768493471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BKkvDupx57dp1bwwUHgSYHPAHQDLKaNR2pdTSvi1dQ4=;
 b=jE06F/7yJea1tRKS3Q4m/smOgx9MXfITZZKZ+VQUWWHh3tR0CSRs6HrFx2cFfUavGV
 GiW7PUWB8YKfv64jc/Q3x+eE58to+2WJpAleGrW38AwJ1PZyZiStZttzQPhEeWbZxHI8
 ubNrZ8DXCN6wHCS0rPq/VtYuqxZtNgolnv5r+m0fgWpcImy1gKDbuf9eJvFRFFlL09C2
 kM+5zmIBI4s3h44EWVW8txZ6+sPTahU8TLTd/iKtA/Dho639ACiabBMLbaw/ov3usGIG
 wmEPrOkWlFBEf9i0c0KWtG+f8kLS/2Y8iUWGdyR7dMRe+m1E6zDH5C1XxZHpZB6omzzT
 3cog==
X-Gm-Message-State: AOJu0Yz0T8StvJaaLdEsFqwPDSrnRWkciz/wKqnWZTApuKJ9itDODR7F
 kPsiG05woiq0mxbcgaarByU0bjd25hmXw4Ca7LWJaSZyhmZS9QMqU2vwt16lHAo8ycsgdzxGc5C
 DOzOF8vRQbUg483rPW7UIJCyRndeXb+kUeQ==
X-Gm-Gg: AY/fxX6NnOwtvN4UJUQmorxPXf4UcrdEja4jYVjQ1XFoRnOpHDzYp8tcVrpBphil4dX
 6pvdkJ42Egp+W9Vvcd3J0yR9Zvrp/TrpykKe1DhgLUtViS6fi6bKmE4Pxus9kxRkL3o9QKo8Npk
 F0LfvK+9UiUUlTR6/ob7u6ZsEwepNJh4eygzfziveEHVNcjmlZzKGE7V8ZcOJICwgOvi8x72FST
 V6I7Iz5nccv03YPzn76gCj5hDYL/01K9wfxDnKQgJWHj5FnzjfXohohIG5ERWf2xwrQ4ZHw
X-Google-Smtp-Source: AGHT+IGe4ErUdKWiTo5+O29fzzqcej3DDhy+hbdJ/i7jyi5pfFO1eGOgFm3202Ew/3/g4hwCgROb0k9D7UC+4XCFIjg=
X-Received: by 2002:a05:6102:a82:b0:5eb:fc32:9361 with SMTP id
 ada2fe7eead31-5ecb0602900mr1285392137.0.1767888670571; Thu, 08 Jan 2026
 08:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20260108160032.1114678-1-xiaogang.chen@amd.com>
In-Reply-To: <20260108160032.1114678-1-xiaogang.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Jan 2026 11:10:57 -0500
X-Gm-Features: AQt7F2ohBAt5Z0Zh1OFthBqypkjQ0o3NNOUE--hI_NddTRFFYTJ1XGHBwmd0rYY
Message-ID: <CADnq5_Pw12DGXWn86AQkfW5xrxYf5nbmTKgLX8aD7saVj0eTQg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Use correct address to setup gart page
 table for vram access
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Jan 8, 2026 at 11:08=E2=80=AFAM Xiaogang.Chen <xiaogang.chen@amd.co=
m> wrote:
>
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Fixes: 68a5940841684 ("drm/amdgpu/gart: Add helper to bind VRAM pages (v2=
)")
>
> Use dst input parameter to setup gart page table entries instead of using=
 fixed
> location.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gart.c
> index 16c3b78e50cb..ec911dce345f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -375,7 +375,7 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint=
64_t offset,
>   * @start_page: first page to map in the GART aperture
>   * @num_pages: number of pages to be mapped
>   * @flags: page table entry flags
> - * @dst: CPU address of the GART table
> + * @dst: valid CPU address of GART table, cannot be null
>   *
>   * Binds a BO that is allocated in VRAM to the GART page table
>   * (all ASICs).
> @@ -396,7 +396,7 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device =
*adev, uint64_t pa,
>                 return;
>
>         for (i =3D 0; i < num_pages; ++i) {
> -               amdgpu_gmc_set_pte_pde(adev, adev->gart.ptr,
> +               amdgpu_gmc_set_pte_pde(adev, dst,
>                         start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, fl=
ags);
>         }
>
> --
> 2.34.1
>
