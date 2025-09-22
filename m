Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4923ACA100F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 18:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B6B10E1DC;
	Mon, 22 Sep 2025 18:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HU2itRvc";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0F710E1DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 18:46:13 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-33056307257so676247a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758566773; x=1759171573; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AuikjmjAxn0SeVI3LssvS6CWrOTyNFCYMMBUEWMtSjs=;
 b=HU2itRvcM9EU0uBg6Jj7Sp4nMrTdkAory+fVa4xue3QoUQpJUdfgycKcs38ssXJfGO
 KvIKc+iWHdxmhpYBNroAJG8qGjxJ62eYUYmGEANeSyG8Q0Bh2oxReQdJyb3kY1AOss2O
 3p8DC4j2HeNGx+u00XeurIEcHpv2HSmkRjUQLCdke3LJGWli58f9QB7aE8GjM1cSiXbo
 jV96pKmU9LnZZZEoTtpv0xXtxbt9i9vMui0Ivkab3BNkiCONb7fFaURhxGo7uMYWZ1d+
 38ORQlwrrMTDi97HJufR85i3pUMQZ2wWUMSnK8MNZ+A997J694UvDWLiSlxGt5TXZOtX
 M/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566773; x=1759171573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AuikjmjAxn0SeVI3LssvS6CWrOTyNFCYMMBUEWMtSjs=;
 b=RhgwKMwTpno9rCfHf7M5apKWszpxu+brx17q+xLQULkO53v8Fcy25B8Bsjdzmezx11
 I0XDZiKaksvEsONFAkDv+Us9veiIER0ACXhf12U14vTfIFY5hPNIGkUYyg/OOJjzOzQo
 /lbKYrU80mC/KalPzqU0bGLaZd0dNmrN46AuCagLDvFfHoCQz0Z3HzrTydy4WKWfClnC
 2JIs29mRZ1sbJCtlaS8SPgw5ltx1GdipLw3kiYCeAMPzivtrFvruSSjYAZOydi5gLZyk
 eKW5cPaN5eMAS7gQ9wQEzqSLat9zPTYaISuGyZFnka52wb2kP8EfBSBkz1/qw9InMr3O
 bb2A==
X-Gm-Message-State: AOJu0YxBq7fGIh7m1KGEWAdozaGB+s/0uajR4poKtn9s0TVwuKu6Fkjm
 lI+81p4TBKs0p/Bvqv/xhK9Y0eG1dTAD3By06hBnygOGb0bjb6W9vVFQBIoLgT9JARisyR0SwDC
 dWtItOjCTmiYHYLvgPXCNWWUU3bd4TCA=
X-Gm-Gg: ASbGncstE7ihDFAl6zVHEBd3RwTXAkbDiurMEEgyQB5AUP3bTTCavlynKC2yWMwFzKj
 l16AD0wwtLKULzTDF87in38K4y7ZagIFnd+f9Mbcqe869doR2Q26XyFU8rHCrGHA1jLu8nbW1mi
 ThkzNXSHSRwzj0X4QC7nGVosQz5906Yb3q07nG0R44J5+CNwdrtqKAXRQ6oHvWk/p7iu5nR0saW
 WVY6P8=
X-Google-Smtp-Source: AGHT+IG/HD9vulrGzOdw5kex0BbJ39nuMLeOdWYKPyXwTfdKLPjPRV4e2JTXgkhEpieuFZI6sCiB4OZxo/8Rwj4478Y=
X-Received: by 2002:a17:90b:4b4f:b0:330:3fb7:d874 with SMTP id
 98e67ed59e1d1-330983a5927mr9606003a91.8.1758566773153; Mon, 22 Sep 2025
 11:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250916080809.993236-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250916080809.993236-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Sep 2025 14:46:00 -0400
X-Gm-Features: AS18NWAfqC8WKeevcCwTg3vzPgT8sx9asCL5MMT0vT2liNPcK2TKNaHAlw_Pohs
Message-ID: <CADnq5_MyK6cbhTnVpYN5q4TkUWRq+YtK7=zAQtnf3HMNsL0Lew@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Add fallback to pipe reset if KCQ ring
 reset fails
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
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

On Tue, Sep 16, 2025 at 4:08=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> From: Lijo Lazar <lijo.lazar@amd.com>
>
> Add a fallback mechanism to attempt pipe reset when KCQ reset
> fails to recover the ring. After performing the KCQ reset and
> queue remapping, test the ring functionality. If the ring test
> fails, initiate a pipe reset as an additional recovery step.
>
> v2: fix the typo (Lijo)
> v3: try pipeline reset when kiq mapping fails (Lijo)
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 8ba66d4dfe86..77f9d5b9a556 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3560,6 +3560,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring =
*ring,
>         struct amdgpu_device *adev =3D ring->adev;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[ring->xcc_id];
>         struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> +       int reset_mode =3D AMDGPU_RESET_TYPE_PER_QUEUE;
>         unsigned long flags;
>         int r;
>
> @@ -3597,6 +3598,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring =
*ring,
>                 if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TY=
PE_PER_PIPE))
>                         return -EOPNOTSUPP;
>                 r =3D gfx_v9_4_3_reset_hw_pipe(ring);
> +               reset_mode =3D AMDGPU_RESET_TYPE_PER_PIPE;
>                 dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->na=
me,
>                                 r ? "failed" : "successfully");
>                 if (r)
> @@ -3619,10 +3621,20 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_rin=
g *ring,
>         r =3D amdgpu_ring_test_ring(kiq_ring);
>         spin_unlock_irqrestore(&kiq->ring_lock, flags);
>         if (r) {
> +               if (reset_mode =3D=3D AMDGPU_RESET_TYPE_PER_QUEUE)
> +                       goto pipe_reset;
> +
>                 dev_err(adev->dev, "fail to remap queue\n");
>                 return r;
>         }
>
> +       if (reset_mode =3D=3D AMDGPU_RESET_TYPE_PER_QUEUE) {
> +               r =3D amdgpu_ring_test_ring(ring);
> +               if (r)
> +                       goto pipe_reset;
> +       }
> +
> +
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>
> --
> 2.49.0
>
