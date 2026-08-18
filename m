Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19824C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 13:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9669B10EB2E;
	Tue, 18 Aug 2026 13:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ncf9CSgv";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3380510E032
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 13:01:56 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-4a453848173so206176b6e.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 06:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787058115; cv=none;
 d=google.com; s=arc-20260327;
 b=a1wOCNm0Gj5hm6jUcUacImA5Zkoi50LnZsLntTzBLmPLP+Cdzkz12JOVvmIAiq6BXM
 DLDRY6NSgTQErsFuPJL61ro8CR1s8p1meWaSD3zJKn5WI5K8Z8R5b8VrQdeRybvNuoEg
 JSr9+m0+d4VE+IrBq7Cd+/1iU/BXIPlh7MjayB3BB2t4Rlr/JjMdTvyvEBaZgaRfk2/J
 aXi6xh0oEZxI9vvq03mZBdbWz+7QtZEa4/vr8T2KCWbrp5FDr+5bWzu+MdWLM9+65e8p
 wBBIO/BDCCdQvUbI9pr8LQH6ITaTR+4B2gKh62nMp9Je6HTJOEGEZv5hW4iW6tCLx2XY
 OgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2sR3aNG32XYVP0yTYM0eLVTqpaeukTauG89+RJpryw4=;
 fh=eY+WzZbkypk4uBfBl0Eoavwx5Q6W8lCbLTZCqd9EjKw=;
 b=hPuAPSvd9taO+K0qOX1qK5zb2NOh0nQy/h1vJCiUh8tfCCtgFqsCW1o5OF7xf/aCNH
 i3E7QQbTgwM6IzwIQ6w/Lvv3L7meCvpdoyH7vJqJMdumfBztYHmWbrCz4Jvfc2Gskcwu
 Bu4pbZP5TnpQYXNcPz51GQmKKmvBrUk+qf1+VChjpjsWTrN9+isnedyu9LzEyf8jGi7l
 zGdHE9v+eYofYzufmwdAz6V9BKDonzzZ21n/awpnft/b49HVd3EgFm0trWfFj70DJG00
 kcIo+/V+JQAkGIloddaTi17OoqmpryxGN3KRw3uF8gRZ6emgBjHQyx4IgXWnuHjr76Mh
 do0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787058115; x=1787662915; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2sR3aNG32XYVP0yTYM0eLVTqpaeukTauG89+RJpryw4=;
 b=Ncf9CSgvV2IIFjoHBGw7LAax9y/iosgbJ8wiAEGIpIcIo2WOhkqvw0eTi553kIUYmO
 9NRLBOhpFkBjljgsZpv2+EveOyBjxZIDzieo/jZA6L87TNLIhY1RaLPiERV/vZR51LLM
 Gf+JjcDMVbyEnK0tpnpgg6WKfGvgOH5nChPe9DOMSl/Vgz54tIdHu6+/KocAjuQTrcmw
 sSicne08rVd7C+9opH8xVmzbxOPBxvgwf1I2UNfOqDsTDAtPbytQE7OEkabxmasRomaA
 8QDF2W9+Lr/kZnfgX73jTpXsgKL8R9/2ypGYzqm4xYIiiFkF5nthNgqyeOrguScJ4uRA
 qh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787058115; x=1787662915;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2sR3aNG32XYVP0yTYM0eLVTqpaeukTauG89+RJpryw4=;
 b=ZIBbm/HfoqivcMypcpTUXvFgUHk4Gpy+c2e5SFL548x735AWsqavtP9cf6L1EG+8qR
 KxzU/FGv8eubS6w2hm5DwGq+zAmkMFNY+QxDmyBQNq9ooPRWwFYIIbDXRUhtlMBOtCU2
 9mu7yycMfIflVF63lwhauz7acRIDxo9BjHxGq0C4QXm96W1yJqtApFfn92Ikquykr1ii
 rJBgfan95D7RvzM+XLobdOhn/ejXQlO7/GIJ+vesJTLaefO5vie8ukvMmoXIvNpfQPmG
 W8Ryo0wfJ+dRaIn6bAmiYa3V8V/VnMC/Pwdh3XDYfZuSgg3Lxanl7fzjPLnrhla+mKj1
 fVvw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/Y5D5skUuBWFXMgANqhLZNtHLqZgmAL7JMu1jFGjfFo6N5k/xpOAWfPBrGkhtN4pg15lm8fbw@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxl6jP1QcBdNevQcek0jA+dgEZM0Qgs8FFFCBqCxXUJbyde2sAE
 A8wRf2M9y0hZT9neiPtLLRSFmJJeaqy8J5woK/4O7yANmniKmop9apk4uqDIh1YfAB9XXpfqTRE
 W6G1ss8yYqo8D0Zuvz4eWcrVkiALIAD8=
X-Gm-Gg: AR+sD121SvOVRXOptqaYViG2XVyyManUVkcZynYHiSGvPWkSZlhVcA9O+Tesz+DeIeg
 biVUt48hL39xoU9bjYMBtkhH2P14+si9A/CBxiQHSSsQpV3o9X43HbnfOFsmcn1r56gjX6jEq0b
 4QWaI32Df4vK8ChBIcHVRgkVm+kH49dAvLgzWeJnoQuBNvMkXQ4NikwWvMCxzan67gPsByzCxBZ
 ZRLx0xaKRQTKzTf8ZzzuW0opsB48O3SmMx4tb/v9gHFws7GTjVNobSSVRnsyr1oTC+eCb6BDvqI
 tI0pZYuUht900d8SPyL+zKECRrPRHsGza3gF5SHipVDqCTrt2R/Ue7Y4ajr+n2O+zKbA57Kcuym
 LPgq330ZjaOsHdyugQ9qPbFMre8zRNqc=
X-Received: by 2002:a05:6808:c3ec:b0:4a4:866:c2c0 with SMTP id
 5614622812f47-4b241e6d577mr17018295b6e.4.1787058114852; Tue, 18 Aug 2026
 06:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
In-Reply-To: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2026 09:01:43 -0400
X-Gm-Features: AcwNN1UXAiURzTZQGebzSaY2iCS4gaObvwtT6Z8fqDgop-twaX7uT_DzQ37n52g
Message-ID: <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
To: Amin Gattout <amin.gattout@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Tue, Aug 18, 2026 at 7:10=E2=80=AFAM Amin Gattout <amin.gattout@gmail.co=
m> wrote:
>
> strcpy() has been deprecated because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  No functional changes.
>
> Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mca.c
> index cc6d1a4e4c3a..1caa393c44d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *ad=
ev)
>                 return err;
>         }
>
> -       strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> +       strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
>         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
>         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK_=
_MP0;
>         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORREC=
TABLE;
> @@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *=
adev)
>                 return err;
>         }
>
> -       strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> +       strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
>         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
>         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK_=
_MP1;
>         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORREC=
TABLE;
> @@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device =
*adev)
>                 return err;
>         }
>
> -       strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> +       strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
>         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
>         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK_=
_MPIO;
>         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORREC=
TABLE;
>
> ---
> base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> change-id: 20260818-amdgpu-strcpy-0e92d18299c6
>
> Best regards,
> --
> Amin Gattout <amin.gattout@gmail.com>
>
