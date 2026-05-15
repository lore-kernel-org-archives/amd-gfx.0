Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F52DCD4851
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 13:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FD310E114;
	Fri, 15 May 2026 13:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hOFe+DeP";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA4B710E114
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 13:16:13 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12db2e9b3bcso643549c88.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 06:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778850973; cv=none;
 d=google.com; s=arc-20240605;
 b=Vjg8nghssSgVbFZt3f73/xICPLkmHqa9jFqxwYCba/eszudepIFxP3ZVaMrKClNeDy
 +z/jmo3g1fXPLxbwbMPxYFGm0gozITRFIfz8iy6r6tNZRl+3tEqqfLrH82YeUGebAftH
 zj2DrpLwvtN+8h3TYQp6wSnOq2kDiDt735g7H/dxGjR09YBP09n5J+cjQYEPuF/5TN47
 H4qT9NqYIAKPuY4WN/TX08XxOcKInI9usrCsFPvoF7oebmtnFoRqzOW78+MMx5RXwQG8
 dFQ5Is90REyBtVg/ZdslLAWTrglcfz5L7RgnVurT4Nz/jBG8DdUYfZUU+cazlpu9hIl3
 OQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9asJTe7aSNikApxeusIi/XV7LA4zQhy54jLW6s1d78Q=;
 fh=HDzJXKq6+BcC9IDJJmH/fdctV+F1KY93tbVQrUaZ8lY=;
 b=Sqb6Es6hs7EUKyfQCwwJSpvUokqUQcK5/NF31Nj68kD7texp468Y2FNNXeQ8yekdOC
 /d8pPpFohKChE1m35MVIq4sYaX3yVXgDl/kUL6xjKuhrRsC6CJXuvZFUBmISSOFBZxlc
 q2bmXZrSyKJ4DXoE6Pa+xjoHkbL327gm9LKOea1vlqkioQh0qID8s55yfpe9Q1oWDBv4
 4t7+n7/jHn/+Zg7MMlKlFE/yquCFA59DbdKrm+TPkHyHhqRv+nQP/UMePMg2UIHfG3pG
 IQHt6Mxbv94+ArbULEk1ut9HDBJMTgn6ZejDAVTuyDF+0KhAuGqt+K+vSbB9N88wao+1
 sC2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778850973; x=1779455773; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9asJTe7aSNikApxeusIi/XV7LA4zQhy54jLW6s1d78Q=;
 b=hOFe+DePDKnY/V2kObL/OLipjwtGBjJdxJlKHXJM13KA1UCNQCvFUBNIkwKKeTpXvi
 BlkG2CUVp8EtQ278j343S80btDeJrww4UDkDiQ9i+0lnq3WsTQbfEHHdud8vxa6FX54h
 D3GLp2aoKuRXntfxFTN05tw8pZyOiQV3PgFY04Y8ivRP+lxQaAaEvjQqED3oyz76SvJl
 RjoBqlkd22e3t7+d3ZEyea+dn2xeaIIkflJdSkcz+2pwpgY79K/GFDvnWbIU5K6BfRBg
 4q2b2WzjYYM0v8QxAyXPBvwrnWt+yB79mDBcU9f7McmqfQ50YrMb/V8znkYT5p3byqD8
 cytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850973; x=1779455773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9asJTe7aSNikApxeusIi/XV7LA4zQhy54jLW6s1d78Q=;
 b=LLKiUbNwHuvcjVfjpmrLVdA3ZqYLjoXXLiYHIZXZ4Cq8B7yvUQIyMt18AJR+0WCxUz
 NGNU1UCkuKvXZVlzqxnjA0CR3EEc7RAXteQeGfmdTZ7J3oODGySOiSV/J5Z/yJL2f+Ke
 smKIk37wulYGQXxfhbYOZNnz2Qj1WyBEi0+KeA52OYyxZDAMmXGvrPe3QHyvPJUdXXIR
 KTFpHH3yXXnl3HXDMWsI6ky9IpbaFsnkm2N6Vj86RoBL/uVj8K/2NboDs4/m7BAWbewR
 mVVrxL6LLymLQTOltsKnhweEW7iWVCKT+UXfnlcIA0oexycCuIzhEXkTiaTakt9AaNG8
 uMKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hnQyHQ7OlvYRxGBlIHd1PZYh6Y5tLFMUn+VqqOlahxWljQckz0NcYSwrMF/OaqVizTQnXO8mE@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy71+uozBO9PgHBa+0pQvfYh/yhsDbOC82aS+JmzLk2W8mt0BM9
 ukQNYgTLLvu8LE5V+a91qgH3HE9gTsfXzEQoXr2TLuynRGmHWF9L22XbumOwvGb1qosCdTMD4ox
 D6sudQ9TvPHx0TRSffOtJyNpT651EVqZrXg==
X-Gm-Gg: Acq92OGiVji7nsysoYFNLoNqxvrCuvKsVw8QNxXYfKXe1oSEi5jVPO6n1Ucco1hrXA3
 +34PGPnVxz4d1wUfmwt5cCXYlXi12VLp6cCJnU2ZZqLTI0sF2diCZn/jYR2dKFCS3ZCpLbvFfUU
 c9yYN2UupuhwNYx2nXjtpl6ZpbiC1u/FiaRaR7MzJKXQjR/N34JS9QyGWJa401Dc6MEfUWT3G0D
 FH7spozlOEFKCeCdsWjB0LJ8rXrAT0tC/xtyqzfJrII4mwcaP1FCC1yF8NtaJDROd+glMdeoxAe
 /Fgpnc5WXxHqsRmUKbDU+YE6O7/8SbrWTmaaKhOmic3f7btxGHarq54VPYcLEtMiM9Dvxg==
X-Received: by 2002:a05:7022:79a:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-1350494f30fmr806572c88.5.1778850972810; Fri, 15 May 2026
 06:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260514072701.2299075-1-sunil.khatri@amd.com>
In-Reply-To: <20260514072701.2299075-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 May 2026 09:15:59 -0400
X-Gm-Features: AVHnY4KtfKENif0IEylmJsXdUm_n4ef3ZxJEiLerlLyqDRCCJIQmh_xZpWkE_ug
Message-ID: <CADnq5_Mjh3cR9pxDW_so6zVLS-k1Sr9x0pbCw_vACn_-7-03LQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: Use atomic operation to achieve lockless
 serialization
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

On Thu, May 14, 2026 at 3:27=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> In amdgpu_seq64_alloc there is a possibility that two difference cores
> from two separate NODES can try to and could get the same free slot.
> So this fixes that race here using atomic test_and_set clear operations.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_seq64.c
> index a0b479d5fff1..f4be19223588 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -175,11 +175,14 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, =
u64 *va,
>  {
>         unsigned long bit_pos;
>
> -       bit_pos =3D find_first_zero_bit(adev->seq64.used, adev->seq64.num=
_sem);
> -       if (bit_pos >=3D adev->seq64.num_sem)
> -               return -ENOSPC;
> +       for (;;) {
> +               bit_pos =3D find_first_zero_bit(adev->seq64.used, adev->s=
eq64.num_sem);
> +               if (bit_pos >=3D adev->seq64.num_sem)
> +                       return -ENOSPC;
>
> -       __set_bit(bit_pos, adev->seq64.used);
> +               if (!test_and_set_bit(bit_pos, adev->seq64.used))
> +                       break;
> +       }
>
>         *va =3D bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
>
> @@ -205,7 +208,7 @@ void amdgpu_seq64_free(struct amdgpu_device *adev, u6=
4 va)
>
>         bit_pos =3D (va - amdgpu_seq64_get_va_base(adev)) / sizeof(u64);
>         if (bit_pos < adev->seq64.num_sem)
> -               __clear_bit(bit_pos, adev->seq64.used);
> +               clear_bit(bit_pos, adev->seq64.used);
>  }
>
>  /**
> --
> 2.34.1
>
