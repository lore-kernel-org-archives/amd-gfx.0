Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E1A606A330
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bp3J5uNw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90E6F10FC5C;
	Wed, 11 Nov 2026 16:22:12 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFBA10FC5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 16:22:05 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-7cc30120465so28432137.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 08:22:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794414124; cv=none;
 d=google.com; s=arc-20260327;
 b=gsJtj8dGUE/1j5eHrJ5peBMOIclI2XDGeBGCe2jGBphQ5tI+81A+4C+f5B0ncNWZw2
 9jcYv/6AITms8F1kS53UP2czQPGmBdqYdthXJ7Qw8njxLDWnj57PhZlOwK7dwB24EA+8
 nVjFsTOzRpfNUtEDyPqtore+bzSdr3AXckVSyqMzvgPZVNtkx00AkHXwBiLMAcUfaEQV
 9P7GVrtCapsHXAsOwZHht1LymHc6lTKGjbkyMw8g+5Lu9hCL2Yeo+EZO25MNzVAo6RUI
 Kp2SwoqoRupCR4Md847/TUD0HOFLR1zXGknRWVftDANQ0Sd58XNYB8HBCGvze0sjcHuM
 cHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VEmKr9XjWd6SJafMK/s6uXcGULEcqUlVNrdZViHwMeQ=;
 fh=9cBf2yFc+4w5CA8GXo247EkhlY7VvnJldDC/CCHmQrM=;
 b=RHct2hdhNHzUg+MlwGhtn4Qs8yOxs1SSP1IpQHdtZsKt/A1zD6CVGDuNK9VLQIAghx
 r5YwmspQpOMMn02LYdOt4zGg6sD7bbnwhG9WPPkQXuKoFgzci7Ijs8+HDaXsOjoTun8c
 aiZZ95cwuKISMxFkM1541SXKyyc0N8/Ft7eiSHHkkyPvyBVQRJgPUA5aXnQNXh+eca8E
 H9QmSeOyMtAa96xWuLmbRaSJctBCrttu6v0XqpoLIsC4TdqdbBt3Z5rUerqqU2xeoTnJ
 HqTy+61surm0dMViFPzVXeqk3FApEIP9woRdDaXl3BdF1zDYT0PdDoINUNI+yQAt7PK1
 byxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794414124; x=1795018924; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VEmKr9XjWd6SJafMK/s6uXcGULEcqUlVNrdZViHwMeQ=;
 b=Bp3J5uNwVboZw0L/UUXi0w//kIAtSiz+eyLDtVtcAOfMu6jLq2gb0ZEkF2UNSjS7X1
 DdU+/97pe139Kop0JQMwt6h05yebcq0Y3/iipDWDyY0XQytjrnnaqu6xx7CY8q8fUK1F
 fYkcT436nW2c+5WjQkSy2/ex0XXUhkQ5r7REuhlAIMR5r6isn+nuTEJOAkONyednSq+p
 j1w1MqwD5+6wKBmvBF/BF6QIgDmWspmLMQ+03r2U1RVzpjkxrNU4cDqxVScc4bsCZZo7
 +QhQXt2ltmujPkRglaBPw6jchvsudFw3UlKf/kvFVx6fwuclUmD3GSL3ziEtCvQjF7Ve
 gFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794414124; x=1795018924;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VEmKr9XjWd6SJafMK/s6uXcGULEcqUlVNrdZViHwMeQ=;
 b=k0Qx8cr9n7tyrc5RjWMlmF5YnImm8I+ZOTwaOEzrxlWu4qu9Kn3UfDdyNiYOvr2O5E
 XwBACBZS5ViwXJ4zx/6rla0RqKmmaiqS8mcyrYmS7Kh54HO1HUElMqwoKxwzwCromBeS
 e7OLRuCmA53VzGgyXjh5kB4nwpkDPMNM4Uys365YOfTIuEuhSG/vkGnMXihIwlz9UxgE
 s3iReH+K3Yhw9BvwHDzIRkcYbF4k4Wir2BmDogiqZNQNx7rAlB7R5nvxAubhRVQaLQUu
 o7o+ihu+wJlP9sV2pi1zLn7TKXGjIsVoINxHPXO38dMmw8AqA0fM1cwVNKgkmX/lyFv3
 ephw==
X-Forwarded-Encrypted: i=1;
 AL+hErF8Y6iN6cm7qme1mKnQ7DBEMMeZgEr5lmXjdUO2Z1EXx8BByvepXGcbnPVb0pon6rkuyIcvz778@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8HugzE3kDDJjrmNVxzZ8Tyjyp9Pqsleq/A1oValGnErDKEKyoe
 f63zhIhGBAZfpmXF/QGbe9JItsdHaVwlLebXhjk4RNSZn9vqXz/LrgodQuHYN54z3gmhxP4mGyO
 BQYHfyfO2NBy1QiqHIVH1N7NHEdtSUTw=
X-Gm-Gg: AYBFou3klAhKpcbiBSd1HTaFAMOYJnEQOy9llGu4+3RXlUULjGDbT3eff285SWsl2qH
 P9XcNHFXTqn2jR9RUgiFO1/wiXswRCpZRP2YITm5KD75fM7VoPwA/TwBnCKfPKCJdrymUJXAfk9
 Cq8i83SWfZ12T2hRxl/0GN8iviLjGfYrCwH0hBjDBKFiVxANAJpFSPCwFlnBHmItu+qRRErsokV
 gyeUfDUoBQLs5KnZ98LNXE5ugC8BweDnQ0PN7HNCYnERVqJxvlnqDvyCNZLKlY7r7dnDooN5Hew
 UiwgTMahMlHfmnXerQS67K9eypSxd9RrT6mU9g2oztt9K51tjdYHfaY+kJTCdizQyJazE9j8tgI
 ahU57jwNvIqZs0qQELL55LrFUOfuGYDUGngcw3eCin9e+ST+mFHIcNCncR3SejItdlyxwy39Pcy
 jayTvaaJYsS2eGkayJ6SlKnRZouYQg0tfhTsYBRrwZ6ExaaOPKOZ7TSdowaZg=
X-Received: by 2002:a05:6122:870d:b0:5ec:b681:f4ca with SMTP id
 71dfb90a1353d-5ee1c433357mr1222074e0c.4.1794414124275; Wed, 11 Nov 2026
 08:22:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104150632.33843-1-sinha.aryan03@gmail.com>
In-Reply-To: <20261104150632.33843-1-sinha.aryan03@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 11:21:51 -0500
X-Gm-Features: AclHuK_SVfsU1onLelID_Qe8h47UVP46ohV1eNk_tzZkaP2m6CnheQmaf2PAlsY
Message-ID: <CADnq5_N7zDDuE-S6Jyg7q706H3SW6WuM4eOTBcEU90boYJG=PA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix kernel-doc in amdgpu_ualink.c
To: Aryan Sinha <sinha.aryan03@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 9:11=E2=80=AFAM Aryan Sinha <sinha.aryan03@gmail.com=
> wrote:
>
> The two comments do not describe what follows them. The one above
> amdgpu_ualink_npa_vm_unmap_range() is missing the ualink prefix, and the =
other one for amdgpu_ualink_gart_npa_addr() sits above two defines instead =
of the function, so kernel-doc attaches it to the first defined one.
>
> hence, Move the defines up and fix the name.
> The description also had a stray blank line splitting it in two and said =
dst_accid_id where it meant dst_accel_id, so join & fix it back up.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202609241952.zFr1FYRB-lkp@intel.com/
> Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
for patch 1.  I'm skipping patch 2 because I find str_enable_disable()
harder to understand and just as long to write as the current code.

Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ualink.c
> index 6cd3927a7..f875209e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -4631,7 +4631,7 @@ static int amdgpu_ualink_npa_vm_map_range(struct am=
dgpu_device *adev, struct amd
>  }
>
>  /**
> - * amdgpu_npa_vm_unmap_range - Unmap a range from the NPA VM
> + * amdgpu_ualink_npa_vm_unmap_range - Unmap a range from the NPA VM
>   * @adev: amdgpu device pointer
>   * @bo: buffer object backing the mapping
>   * @pte_flags: page table entry flags
> @@ -4727,6 +4727,9 @@ static u64 amdgpu_ualink_npa_addr(struct amdgpu_dev=
ice *adev, u32 type,
>         return npa;
>  }
>
> +#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT                41
> +#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_MASK         GENMASK_ULL(50, 4=
1)
> +
>  /**
>   * amdgpu_ualink_gart_npa_addr - Get GART-mapped NPA address for ring bu=
ffer
>   * @adev: amdgpu device pointer
> @@ -4734,18 +4737,12 @@ static u64 amdgpu_ualink_npa_addr(struct amdgpu_d=
evice *adev, u32 type,
>   * @src_accel_id: Source accelerator ID
>   * @dst_accel_id: Destination accelerator ID
>   *
> - * Computes the NPA address suitable for GART mapping by adding dst_acci=
d_id to
> - * NPA address to access remote by SDMA.
> -
> - * clears the source GPU ID bits from the NPA address which is set for
> - * address-identification mode.
> + * Computes the NPA address suitable for GART mapping by adding dst_acce=
l_id to
> + * NPA address to access remote by SDMA. It also clears the source GPU I=
D bits
> + * from the NPA address which is set for address-identification mode.
>   *
>   * Return: NPA address adjusted for GART mapping
>   */
> -
> -#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT                41
> -#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_MASK         GENMASK_ULL(50, 4=
1)
> -
>  static u64 amdgpu_ualink_gart_npa_addr(struct amdgpu_device *adev, u32 t=
ype,
>                                         u32 src_accel_id, u32 dst_accel_i=
d)
>  {
> --
> 2.46.0
>
