Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F25CD6E7B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 20:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B6C112BF4;
	Fri,  5 Jun 2026 20:01:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y1VaYjPh";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8EB5112BF4
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 20:01:06 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-137dd497007so153119c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2026 13:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689666; cv=none;
 d=google.com; s=arc-20240605;
 b=AmR5pHhmZA/C7AdRVgB1bc+RtdZduPGpDL8D35B/kfOlJC+G11mTtV9E6RE8Rl9jAS
 shbuffwLZClr8SjN2R8F7lnwE4hVy9dAsDvCLVQUoiFe8iU1AI++nEwi6IqattaKYGxG
 9k6AQP/IC6ilbbdf4jWVMYeAlhdhUfxOMTv+gxfPqVUh8rPfzwkcdttb+FazIe5YlSGe
 IhCKzBrgN2/N1aHZws5dFKvyYZ8f+ZjXqwTlaQihWVw2F7m4YHsVI3j9bmH5IAW2idn8
 rDWMT2rZQcmU8Gb18WXDQRbJe32Xa2xkAb3ZSZBXEK96eH7MBv6yVSpqRVFqyZ9GhVeE
 pB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7hSjI/CZiQmcHMj8kBffuEiW8ty251XfcMvIvtBcU9s=;
 fh=CzcPj9XYmeHjzG9UJpbG6xTiatwYlIgfsKbQQnfe8A0=;
 b=gZN7sRhQ66EbMpeSoJAn7C68phKPbY+dshRGpB/oy6yEmKJF0/3GHTsgTIjY3268+6
 Wh3TacLKIM3UJddGC0ADSx8B64yj7CGVsKA1mgInYVvRxQfEF7Lbt0+KCX5anRPPppV7
 xEr4DGuSbI4Qu6O/ZbP3DSvZggB1eujNKCuJBZQ8xLmm87trZYbj62om13T0aZD+dq6r
 n4p0W2qXk1y9ojTnmaWBLt/hPVk1DvzFyRqbWGNftaVRV6cVNkn6r6HBenk+pS2VzVYF
 4snZ+migSXFgyEFSRM2Bj8C61QlyfacFRB7Su3Yx21baGd3FzcADl87Kz/j+v7EqXNB3
 bKiQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780689666; x=1781294466; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hSjI/CZiQmcHMj8kBffuEiW8ty251XfcMvIvtBcU9s=;
 b=Y1VaYjPhCPWzKnhSaAZLTJ/5+iGaWJTPW+l3arCDLXQCxfCfcmTCxVzuEAOM0c9KyX
 GlQzwu13dNHQn7PjT18Zvxl5pv5JydcEg0Y0uowbXJi3Krmq5wVS19kPSa1Kpm7X+cut
 Om93EhpDhYW8LhmoFa5/+3uq901lO4sWP0zJFjoF3Va7byrUIj3fU8bZWPjfdZStPNjJ
 gQR6kBjTDuYzO6WrqEO7IxSc4IAX5kvCRu/wlFWhFAUno5NoDhYfeQyzVXwZI7QW2jBs
 IllDXrXirE/CsSEd9nQ+rob/wkqsEGmU5dAD285D9sa9iF4g6MAwNd4l8mfORMHRqyNn
 i8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780689666; x=1781294466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7hSjI/CZiQmcHMj8kBffuEiW8ty251XfcMvIvtBcU9s=;
 b=KtngM/XBEDL6jiw8qu2LRDotna0keFqvCchGeX5fbs2zjRuDKsAMiJ3vIxrvq+/fDn
 v4IszliN5pXMnfjMN/75K3J0Oh58Zl/R3H5ygA913PaUL6Ak5lybTiWNX1iztzmpe7QR
 DA0sOB7KCx3ldCNHU7+7Yn+me8PUOYcbkvWJ/Ge/cyljs/ULLR8SDTG8RM47jSuvyghH
 DvAurrkh0W/SoYzOOViAZMDPywZ+gvuxc6f7lqPOJ3JSLYrI58Wml9yIp0nftlc6nQHq
 /JUhKwPOUG2fyzbNtqbRcPlKNI2exIFoz841gFN6BtYkmwGiplFCZ281NrLEZ+QEUcDQ
 qJNg==
X-Gm-Message-State: AOJu0YyG0ek9lbu/vVAuABp/X8LZCLQeO9LNHD5fGqRX6Ak42jJIfxp1
 mDut/G8Si4SZyoOSZ8KJfvb4hgj7jamQQusE+3m6us8PoD8KF5SUJ5BPy/5rleQlUotdFJKjKQy
 rr3+l/c3cqW0z/jXMMq6/+3V7ov8wHOg=
X-Gm-Gg: Acq92OGpQVG7tKzSnY1fXgfVOCp75U20kaf8fh58NMgiTUUOHrv3ar/6hCcapLdKJgI
 Tn6jf93jzStWIRqSZXNdh/V1jnRz/SjIcQvH6S40/ST5jc2y3SRG5gNUOW0+RSu3poQtUZHp1nM
 wpcAsIZCPZ6pQDuqLJ+rIlYYgQJiql+jmAZoZCKzG3u6mRqL8dNIw4YgLpSu3xcSfip7cJW9wzh
 aa/RSy1K46sXrMnCTZqNLFxqqXFkw31yAsQIoGUJB23CZoG8Yrj3DNCMzlDmxWjeAQvRh2YShRp
 KM0mIeU3jnUjEPSH7Jx7d1ifQBD6oxIvEUIh5tfxxg0v1NEFMiNn5myygIgqTL9olp3juh3TPXp
 imYrh
X-Received: by 2002:a05:7022:238c:b0:135:1b3a:bffb with SMTP id
 a92af1059eb24-13806669d9amr1045723c88.0.1780689665851; Fri, 05 Jun 2026
 13:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260605154920.1314590-1-asad.kamal@amd.com>
In-Reply-To: <20260605154920.1314590-1-asad.kamal@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jun 2026 16:00:54 -0400
X-Gm-Features: AVHnY4IQA-vTBN0Qyyf4SoCGSV1NMnWY95TCiaqeoADXfFYdmMVwZALmUmZV8ss
Message-ID: <CADnq5_MO7q3E99QZhkLqYGAJP8m6kH7Mf2ATkut6kPikehB10g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
To: Asad Kamal <asad.kamal@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lijo.lazar@amd.com, hawking.zhang@amd.com, 
 le.ma@amd.com, shiwu.zhang@amd.com, alexander.deucher@amd.com, 
 kevinyang.wang@amd.com, srinivasan.shanmugam@amd.com
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

On Fri, Jun 5, 2026 at 11:59=E2=80=AFAM Asad Kamal <asad.kamal@amd.com> wro=
te:
>
> The cleaner shader sysfs path allocates a 16-dword (64 byte) IB but
> incorrectly fills (align_mask + 1) dwords. On GFX rings align_mask is
> 0xff, so the loop wrote 256 dwords into a 64-byte buffer, causing a
> kernel page fault.

It would be better to set the job alloc size to
ring->funcs->align_mask + 1.  The whole point of the align mask is to
align to the hardware's fetch boundary.

Alex

>
> The IB only needs to be a minimal NOP shell to schedule the job; the
> cleaner shader itself is emitted on the ring via emit_cleaner_shader().
> Fill 16 dwords to match the allocation.
>
> Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running cleaner=
 shader")
>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index ff5a55f5f3c9..f2c536929446 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1694,7 +1694,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct=
 amdgpu_ring *ring)
>         struct amdgpu_job *job;
>         struct amdgpu_ib *ib;
>         void *owner;
> -       int i, r;
> +       int r;
>
>         /* Initialize the scheduler entity */
>         r =3D drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMAL,
> @@ -1722,9 +1722,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct=
 amdgpu_ring *ring)
>         job->run_cleaner_shader =3D true;
>
>         ib =3D &job->ibs[0];
> -       for (i =3D 0; i <=3D ring->funcs->align_mask; ++i)
> -               ib->ptr[i] =3D ring->funcs->nop;
> -       ib->length_dw =3D ring->funcs->align_mask + 1;
> +       memset32(ib->ptr, ring->funcs->nop, 16);
> +       ib->length_dw =3D 16;
>
>         f =3D amdgpu_job_submit(job);
>
> --
> 2.46.0
>
