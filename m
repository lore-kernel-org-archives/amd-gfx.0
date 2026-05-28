Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEFECD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 18:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3080210F55A;
	Thu, 28 May 2026 18:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M66bGZXq";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8626E10F55A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 18:43:53 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30436e8f582so849822eec.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 11:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779993833; cv=none;
 d=google.com; s=arc-20240605;
 b=cqLOgbZfm34GbhQj/2nRNSfOYuodGMPEpvdWCI65xv0c+gNwRiW6P494egUGzcSiQp
 tkoifeQy1ssj3DoyO42DrZ8Ix0g3Eurun061xkGXSV5p7iMmil5yNqCiWtyKzbBCxjn3
 kb0eo30usk3kRSI/iKjnTFrok1wwPZMPe/lx4GoJF7rhPfmLovANPM+tukIxpcDqXXlN
 zEQCNF1vp38xvuVSqyUBaLDJauY3g/mZiy+N9+i9SvS/WLSnI0wU1LExOOjEqIxh7YW/
 jz+p538t5CcMMJWiGuSTLMwsbQPzw3YmtxruwAJFV/W9hmTU+j9816I3mejH0/Skoo2g
 AyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ko95xw76BDQndPkeigI/Zefailss2NHCrXUSHZbN1AY=;
 fh=mMwEBgaqB8GWe/mzFZQyewDVYtlOSQWYolYL+wVyf6Y=;
 b=TXVPLWxASv5f5sI14qK8E8+lCwrlxnlayLR7aJInXqSjysOOGV2Yv5DMhcJs3g4gDY
 nIxMF/5TyKll0QwTNpaatVKl3DqCfoQXAfFm9rU2ffgppgoZYZDcv31CXy7Iwgt6vW8h
 GtHuLHc+AYWXE3aAV3vZxgZBxoCSBcjieX8AoB6wmWF3rifmZgtY72BaYDgUBhiOXFB0
 uTX8t93VSQC5Zs1hkLAHLuRUGhvvqz3a7PQgVlTib2bfgGenDnILt6jd0HfRNcuNYSIt
 F+/bUUgJXZAPe8mUol655dHUa0cuG435+Oyvn7yHxHGtMHPOh9775iRX8ETQZiHq1Zwn
 6k1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779993833; x=1780598633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ko95xw76BDQndPkeigI/Zefailss2NHCrXUSHZbN1AY=;
 b=M66bGZXqYKdSCvg8ILVso15kHE1kN7fJJ72BdY4GbSh3iVvuqxvwG/Abh5aHK84cED
 LSQLhPe22LGjPTDZQQ0sRXST3/zha+JlxKf2QLWyn2P98ttPYHB8gWcuhIPpT3rTyrsc
 J2bSJ03KjMWjsFKpfWvjoO7NQeqY3+DCAyntWN0MJYkPbln/BWBnmV0pNFJpTcv+Dlmn
 e1To7pf6NRQpId2LBPRww/oyYUIvyz348miio1qDTzUljuWNWe7lccAkWD3iDtfyJhEH
 SSGg3g1fNyq/wENDSktY5aCwmvFBeW8zfgkyHD9XHPiYVEu0Roxn3v60UOox773y7DF4
 fDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779993833; x=1780598633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ko95xw76BDQndPkeigI/Zefailss2NHCrXUSHZbN1AY=;
 b=VpTfLdBgjvN8fPy5ndPM7v9DaUDQuN0oE/rV6p0QMzsPcdpcnGirB8XoeqzkegrPfy
 OLlIcfzc+AuGAV4DXQ4iQaV4aSmot3xgpA7NB5Ctuc/ZqANC6xLoSlJY2OwQAtJk3SHH
 +fmwlHfGbtm9daJ6wqy/8haiNZ7J+m8E9nCGQqOrbqkF18i92FqW/heHZJPKLEIMJ4zJ
 ehKWn/xi64Dlk0dBHo27aEVP7SDWjiIhsrdVDWAoc/QvHkMYbWG+0eTQJ3Fg9zMJErvt
 PYbHz/1mxopl5seeTKCOGW9/UBSA7S0UNVHhxv53KgEniKdLOZ/eud9Z3PiYDIl1IE1Q
 5ZLQ==
X-Gm-Message-State: AOJu0YwdwRLkpDDM/+JdOVoL7AhCA3WnvSpkv1tne+Ftf5/ISnwAYwoZ
 rhMjYq2pp+dq6K3sa2oxi/8oYmqaVYIgUCBt8GtxSbjGG1L37NzQOhnooRMdx6Rq8IKP1rCX7k+
 EcgxxrpO2T3y0XUW93M8FZ13H8KtOEAI=
X-Gm-Gg: Acq92OG766TCi4kmHSjfbSl2msSmy0zDHN6ow7phwWFS2/XL/ATljzsUAK2fKWPZ5B2
 7C3ZlVxdWN2fmBo2rna/fyjcakSJE+qninKhQpSWXO2NwZFRbDqR7SCfG/3kRVAKXxNeyJT6dt3
 cFsxZkx9gTNw8w1G4BzxR3DR/oMfphgDbAinrp6F3STaxf8PGJhu6z4edNMPqLh9LivvIXf7xcd
 1cYmBKKQbDfwxGcSQa7i5SQiOWWSGBkn58jwQ6c8dSyJ8ccxQzu4u8V32NiFDg57kFeIiCPu7WX
 7x1Ad72ujQ5e7mZ4lmEehxn7d1JC3fei9FhUSSsIZGD916QSCUbAW4V83pJsZOQYmcOjEQeHaBu
 cEPSYPzMREJF8Vfw=
X-Received: by 2002:a05:7022:4391:b0:137:100a:69ee with SMTP id
 a92af1059eb24-137a88d30b5mr29349c88.7.1779993832622; Thu, 28 May 2026
 11:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260528154709.824142-1-boyuan.zhang@amd.com>
In-Reply-To: <20260528154709.824142-1-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 14:43:40 -0400
X-Gm-Features: AVHnY4KgW0jEcwMqwQeCxxFfUJMXUzF4KCMRHay5Z4GIZdw-bfowNthrVp8HxzI
Message-ID: <CADnq5_PN6a8yXbeCtA1a2DO9nXB0VVpBRDCKSQzHrPAe66UT_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vce: fix integer overflow in image size
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, leo.liu@amd.com
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

On Thu, May 28, 2026 at 11:54=E2=80=AFAM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Fix a security vulnerability where malicious VCE command streams
> with oversized dimensions (e.g. 65536=C3=9765536) cause 32-bit integer
> overflow, wrapping the calculated buffer size to 0. This bypasses
> validation and allows GPU firmware to perform out-of-bound memory
> access.
>
> The fix uses 64-bit arithmetic to detect overflow and rejects
> invalid dimensions before they reach the hardware.
>
> V2: remove redundant check
> V3: modify max height value
> V4: remove size64
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index efdebd9c0a1f..d2f1a9a1d338 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -877,9 +877,19 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser=
 *p,
>                                 goto out;
>                         }
>
> -                       *size =3D amdgpu_ib_get_value(ib, idx + 8) *
> -                               amdgpu_ib_get_value(ib, idx + 10) *
> -                               8 * 3 / 2;
> +                       uint32_t width =3D amdgpu_ib_get_value(ib, idx + =
8);
> +                       uint32_t height =3D amdgpu_ib_get_value(ib, idx +=
 10);

Mixed declarations and code; older compilers will complain about this.
With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +
> +                       if (width =3D=3D 0 || height =3D=3D 0 ||
> +                           width > 4096 || height > 2304) {
> +                               DRM_ERROR("invalid VCE image size: %ux%u\=
n",
> +                                         width, height);
> +                               r =3D -EINVAL;
> +                               goto out;
> +                       }
> +
> +                       *size =3D width * height * 8 * 3 / 2;
> +
>                         break;
>
>                 case 0x04000001: /* config extension */
> --
> 2.43.0
>
