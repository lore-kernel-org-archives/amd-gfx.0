Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFD5C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 12:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D2710E8BD;
	Thu, 27 Mar 2025 12:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l91Rd8CA";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 616DB10E8BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 12:56:46 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-301001bc6a8so197823a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743080206; x=1743685006; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjp9DxiepWWu9updNVck6BZezJY7SrbPiOL1udhXcjg=;
 b=l91Rd8CAIr+goxx4/xkLxcc33KATEwNCRhFB3u/MznlpknipmvL4YTIvjBkU66is5x
 O6q95u0CgyiGkNxFIav30ZsLzwk6O+tBQKVd4Ru4Di/aObr2NasMfob6S5PvjGj1Y1T2
 e+vc23lRsWL+t6oXlw2jEr4chYBfIHItHIILIK3oohPJyKIWM/bP+fwUauU8pUwEJQYP
 WwTnWmqolUVZXmM8RQ+akFkKDj9CJvV4F4yugP/K/v20/bCn+rCfVcxlHGtRgGVE/Kwu
 +lh5jfcFXhHVC25ad+zJzddT/v44Ztwb2e9msRvYmmmXBsLY9gelsLT/QVUIFN4vmluL
 7T7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743080206; x=1743685006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjp9DxiepWWu9updNVck6BZezJY7SrbPiOL1udhXcjg=;
 b=Ax9I1+BCVd59DLDqMGXtcDpR4wFJlN2mZ2VoImth4F8E+AvcmFZ+TqlLnS3GgELLHe
 pOJPvBpL3DIcy0g38Gub8j8kSLGVXkUTOWulwGziXGoF/ARr0iH8z0ZAgJ7fcq1DbEDM
 snkFM5cGF7hT+/1Lej6m72sa5AL/9wnDSM7WevMK8/xOU8Ye6TmwPXgO667fnrpYXezH
 S1Gjpz5LlMCBlQmJf7ygk0CjKEFRJhS21FWdUsJRGB1FhPcC56J7yRW6zWjw+h+x/A4F
 w9liiRNcd7y5ubhbIDGV8l5N88m4NTd6t8p39dJKBwX0id7OgEeiLJwszgV0+K/zi7cq
 SkeA==
X-Gm-Message-State: AOJu0Ywcgvv1U+fNuOegti2w5qgSqTutmv4h8GPBaBqeYCnfw4LrRajk
 bkYV8T/6WaVMyS1LZcru98kAKirVM3uzUY/4COZOfzhSzdB1QVjd0i26arLd16KDeGFM9H0/R9h
 QW/QLR1CJwrz82gXJRkp3Kd1ak4wd5w==
X-Gm-Gg: ASbGncvkORai9xEsstRUv3s4OF4iSu3w6O7kLFvKbayyQPJTfcj7/SBo6yNElO9dPWE
 Qv/xFqkiNS57zbrojhGyEuK2QTHG1sp/htbk0BJtCkJ+MGOFQ0K7dWCzi+2cyTWPwfcqACfN24T
 W19kfk7AqTlT7ynRSVDFppORoy2LYgETq5wD2i
X-Google-Smtp-Source: AGHT+IHJScOZd9NKRWF+mKdUTn/ofhyZU5xhm7F2mhkd6rJvNRovayYBwFleCxY1NVqWpHZeWUh8ERykuS3BXGfco/w=
X-Received: by 2002:a17:90b:4d07:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-303b1dba5e1mr1606082a91.0.1743080205500; Thu, 27 Mar 2025
 05:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250326121323.2451998-1-flora.cui@amd.com>
In-Reply-To: <20250326121323.2451998-1-flora.cui@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Mar 2025 08:56:33 -0400
X-Gm-Features: AQ5f1Jr5CxDia-vp8eQSb87QcvZmpoJraGmnVPYZSel-1LfD23l8vxZ8-D5F600
Message-ID: <CADnq5_P7P2isydN6wQVBjv6V49-26UUZTvPWYDXMa7qm6=VJAA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/ip_discovery: add missing ip_discovery fw
To: Flora Cui <flora.cui@amd.com>
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Mar 26, 2025 at 8:23=E2=80=AFAM Flora Cui <flora.cui@amd.com> wrote=
:
>
> Signed-off-by: Flora Cui <flora.cui@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index dc2713ec95a5..9e738fae2b74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -120,6 +120,8 @@ MODULE_FIRMWARE("amdgpu/vega20_ip_discovery.bin");
>  MODULE_FIRMWARE("amdgpu/raven_ip_discovery.bin");
>  MODULE_FIRMWARE("amdgpu/raven2_ip_discovery.bin");
>  MODULE_FIRMWARE("amdgpu/picasso_ip_discovery.bin");
> +MODULE_FIRMWARE("amdgpu/arcturus_ip_discovery.bin");
> +MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
>
>  #define mmIP_DISCOVERY_VERSION  0x16A00
>  #define mmRCC_CONFIG_MEMSIZE   0xde3
> --
> 2.43.0
>
