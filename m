Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF39EC83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 17:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70DD610E554;
	Mon, 28 Jul 2025 17:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gBQR6/G9";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7248D10E554
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 17:22:15 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-313067339e9so744405a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753723335; x=1754328135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXeRmTIR5gEOmYDzAg8UBzI1wwlCnqXBPcJfOwWd29w=;
 b=gBQR6/G9H5zI1+kvpPbizM1lJbxDRcvjKPZ7MPk3ot+BnpXBEq3z8qxWmzwiEJbcB7
 7Y1im/agU8MHT1PvCflzW8nQdrzYTxCUotIvyNtj09+9QQmjmOqlwffc4wbgz/OaCVUu
 OqvJz8VKavYylNiHEJHqvPKg+lLMYD9FFO057cGLM2MoHYLb8e7+CBuGepD7fRybek3n
 ksbkTmAZx39h7VB1q2+IXEW9R/twQgovbse27xHmph793uar4zKRJWO9mdWnNY9PgZBg
 A8k1exMxfzLrTHDJxVMwc4LBi1TDwlSK7FeNlNueHFGMQvlivjgFgCIHiZaLNcH0PugK
 zEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753723335; x=1754328135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZXeRmTIR5gEOmYDzAg8UBzI1wwlCnqXBPcJfOwWd29w=;
 b=Xcc25m6j5nylwy4/a6drFx5L69TJKrNaa78GS0fTHoLohVhmvumfjnqu0VrEkGKBjN
 3BYqaxAIg9CkyWui4ptiAHpk40Ub5w7umjhynncGHbctmA+DUGjzjbBaO8hbH3Eg8l7s
 KYtvwKI5A483kMXS6Rd8QTBy5+aC7RXvpTgaydcT8z1RyVbiu6IbvUzwxHRiQ4r9wjAe
 gh4jJpT2CnUEM9+FI6mMDxP42oflCGauRKPsSpdQfqW27hzeav4yWUKQGVG3dGoZmsOc
 efo1+ZjvpoXDjo4341XncKp4dqjmPt7+sHnowWijeMYrwflSb91e5Iq9LgFRgtyl4dR3
 MNBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd+SEdK8AFIhxFiQGj9vQsrV+aDVmdWIYgEAwetvayPkUIGCEzwiHM9zhqh0W4TkuC9B7jjyWe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrrQjyNUKCHmfTeP5jlp6tR9uQMSacpKfrCNYcJA1tElpIYThD
 Z0A4w7jcU3N8aSQ/yRdW9NQphsRDJamJECW32d7DbW37vIE2uvOX0+gsYg+Su8JzG2cs0Ola1Pu
 p0Wthefwjbuv3tFbPbiYwwfHVUGTAFtJI1g==
X-Gm-Gg: ASbGncuVpA/dRsDBqwzHRIAnE/kpLFBAY/nScu13ZidEKMBLXTtOJe3czIDkG7DxB8J
 KKU3UrtfHL7BMAvo+L8X70zz8m9PNO2CVRhLqYaijOTpYbXYjWjSIzjIAfBS0uovKDvlFQehWBl
 oukKtlASyp4uDjmBNgdIRdh+9luKIncSdEKqoHdRjbZstkxL4VjYm56/pn9O/+91LePstmG6SkS
 1t4lvs6
X-Google-Smtp-Source: AGHT+IEg9gOR3zSAMOVau+/fwHzqqNMJuHfFOiKVHfqTRf2oUjdV1aCBVZqn+gj2ofReeItzm07POyBxwf265DvPf9A=
X-Received: by 2002:a17:90b:4f49:b0:31c:3871:27ad with SMTP id
 98e67ed59e1d1-31e77667556mr7383398a91.0.1753723334730; Mon, 28 Jul 2025
 10:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250721133630.1307201-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250721133630.1307201-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 13:22:02 -0400
X-Gm-Features: Ac12FXzYazXkdWjF0IgZxUSA8BEZtVtOYWJCN3cRtdd-slGXkz7uJ05yscREPOc
Message-ID: <CADnq5_MWMyOwS=OS85hgx0xUSvbozaWruzoW7p9ih3qJmntw9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix kdoc style in amdgpu_fence.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Jul 21, 2025 at 9:53=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> The initial comment block before
> amdgpu_fence_driver_guilty_force_completion() incorrectly used '/**' but
> is not a kernel-doc comment, causing build warnings.
>
> Fixes the below with gcc W=3D1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:742: warning: This comment star=
ts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guid=
e/kernel-doc.rst
>  * Kernel queue reset handling
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 3f2080aecd5a..2c84d36b5437 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -738,7 +738,7 @@ void amdgpu_fence_driver_force_completion(struct amdg=
pu_ring *ring)
>  }
>
>
> -/**
> +/*
>   * Kernel queue reset handling
>   *
>   * The driver can reset individual queues for most engines, but those qu=
eues
> --
> 2.34.1
>
