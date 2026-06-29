Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C6FC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 14:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB34B10E0A8;
	Mon, 29 Jun 2026 14:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r/hTYChV";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED0F10E0A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 14:32:28 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30bb87c90deso415214eec.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 07:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782743548; cv=none;
 d=google.com; s=arc-20260327;
 b=YqoK2xnxXy560/FsQyJo8Il22nvL6eWZunINKKsaOUKUyXAcRA0xKcJ6+3ifqADcBo
 Ko5UA/a8a+oEGL+OrFGKwbxJqZlUuAngNua4EcRgqLu6iHozvlbvuNcOILDp0QwTU4uM
 FAWbUfuhxSFW9dT9EraWFOmKkrHR6Pauj/X1ameCAyKG4TvZhVdGX8ioIp+FUeUAL7Wv
 GbYN4qEcgk6MKQfILHWsm3Pg2i0wkUmg4h+A8oIYrQu0XvdfXNzBGZXsv2ZQ+kxBV0EZ
 IEZtlZs0uamfsfZ2x8i7bf7hwehqJxGkj35iYsU4/Y8hGBMWcav+bJm6N3X3VIrm4VSH
 Nyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zn2RTWG+7KtVxaFXk9+GhVnb0LL8p4SIJkvmEHWAvvs=;
 fh=7V2yT+l046HyCsE8F5buuq78LXEvPpwwGry+LtHLCHA=;
 b=Qu89dN3bYHpssD0WdGoC2HZfxyGDhxuez9ZvdK9Lm/G24iVdqWFBRZSXlLSY7lPmO2
 nBeVKIv8/1M9QKr8xZ9Dk6s+WJyRF0uRAM3i386R6S65V0cTmjcC4H0/RiatbHKKOoDv
 5HeUDJDlQEKyiTz4G7kVeestB3JWp2d4/1VVXKlGsDqcV9BwjJiKWWkSirwt5zUZBSm3
 ruc+FHUDm+UrxCXe0tabJy2RuyCr+TBmwHWK3L5W/dcWAXNlfTSKX713f6q6l5xx52xs
 RgoYfQ9x+VOan4cv1yggFde/oYC3dddjNtzW1XABxQO2906bNst+qcNhJSWOyc4gCrLh
 D2CQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782743548; x=1783348348; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zn2RTWG+7KtVxaFXk9+GhVnb0LL8p4SIJkvmEHWAvvs=;
 b=r/hTYChVk4yBoxVgDtDWLF/0/QMPGYw9Fqvd6Aq+ybBg523cxsCsgpISyK1fqgQXv9
 afXisJa4PY1fASjtj4SrM/9YzgBTKZP6b6liiOm53j4oQwgcEbfqnlUZ2dmBEpfYO3QE
 xQske9+2IWZi0RResOsSg0UXGKCsOCMMRb26byCiAtV1DdfdThCxO2+E9O/p2E7jUwFZ
 TVm2rNX+Av84kxSy9DgR/8r/oMVePi4uGMusbh34bb69Olf8I+lvWkw/tRUMKjkbMYgi
 8i5AyIg4ajCT9yI+lYPfKc1Jj97q1t4E+sctRGG1F4fNy8MUZ7k053Bn9lGeQX83wSIe
 Rp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782743548; x=1783348348;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zn2RTWG+7KtVxaFXk9+GhVnb0LL8p4SIJkvmEHWAvvs=;
 b=agj/oMdeJMsdYsuRpbGQCdya5U+CM5RPydf01JHT33owVoF1VU0663S4AdS8Il4gAy
 CXAMjIcmW9AjKQ+r+hE9lUBCEjWvf05TdhGtsVqJMzBaOHHpWTncCFvBbJIXz2+WKdBw
 kppxE+QKLV6pJxex/iv+UCgWW9XcuT4SBCASxoKg5OS8bLNGDQwohGBiSkvcsB5S4ieO
 fscLtpc+rAdJeDHz81esW7q35lvY1m/goBemum76S+7xXvTsoD6Ez14TdzATpNNjPKuW
 J3iF6fctkbbRpYlSG4Po72PRvdtMvnaViSdlOHe4jvYBNjNv5PP/sKNvk8VqyG0bMdlu
 C9SA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sob9oe4h1iz53AhoTkIdRCxx/Z6rToY5Neh3aO309Guasz/eS3MxmpirMoDDr6uKuS0sW01V+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRhhfOVxPjwL5GtSdo5qmUsF54zFSo3Qq1I40jjVdFUEwGg1Kx
 965rQqlyjgIVPvQWXmhg8Mv86xk/zM1wb7kR1zRFhOWw5vfAoA90KnUJrNyJrHC0KTLHL/4T3iQ
 CrX6tE19QajK+7RGcYeNeL0fMpsUm90rN6w==
X-Gm-Gg: AfdE7cmnLA38dbwF8USb9i6pYLPchFbsZ2i7DwPcVK/4UtIjg4jfGbebIbCKdAHt7nY
 n+psHggDY3MrqCYULVopN1OqMqyM1BcW96R7C8Lvk2lRsP0vroctlzb+w/9ZeYiFdBmYVCzRAY+
 2JyeAaT2rQ36vgvlOn7pczR88NrqtGMYmVpyyYmgC+Q73S816dRadPV1+ysSEQXClEyvJBrS4o6
 Nvhe/jEdNQW1ifpurZtXYB8GAAd78Q+01EpXVPxZGQr9anV5PX+mWVnhmdhtTPlqgwiXKuCpidK
 RJVrD2abf2A0dM94toGbzhBL87ir35d+v6XvNdkjBbIJj/DIOe5a4X2D17oj/wjdZFMVWg==
X-Received: by 2002:a05:7022:6295:b0:137:fea7:9297 with SMTP id
 a92af1059eb24-139dba00013mr6819111c88.1.1782743548050; Mon, 29 Jun 2026
 07:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260628061951.1562536-1-geoffrey.mcrae@amd.com>
In-Reply-To: <20260628061951.1562536-1-geoffrey.mcrae@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Jun 2026 10:32:16 -0400
X-Gm-Features: AVVi8Cf4wi4zSrLdCPkfdvAYYQ3VlQa4yr3bujz7NAjbbge4hNyuWbw2izfpcFM
Message-ID: <CADnq5_P0h7w1qcso3gG6kbscmFEPG8gK3kz_HZGojoj=mFLBNQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: Add NULL check for mes_hung_db_array
 allocation
To: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
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

On Sun, Jun 28, 2026 at 2:29=E2=80=AFAM Geoffrey McRae <geoffrey.mcrae@amd.=
com> wrote:
>
> kcalloc but does not check for failure. If the allocation fails, the
> pointer remains NULL but the function returns success. Subsequent code
> using this buffer will dereference a NULL pointer, causing a kernel
> oops. Add a check to return -ENOMEM if the allocation fails.
>
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 6c0dde3786e3..261ddc19c840 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -250,11 +250,16 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                                 goto error_doorbell;
>                         }
>                 }
> -       }
>
> -       adev->gfx.mec.mes_hung_db_array =3D
> -               kcalloc(amdgpu_mes_get_hung_queue_db_array_size(adev),
> -                       sizeof(u32), GFP_KERNEL);
> +               adev->gfx.mec.mes_hung_db_array =3D
> +                       kcalloc(amdgpu_mes_get_hung_queue_db_array_size(a=
dev),
> +                               sizeof(u32), GFP_KERNEL);
> +
> +               if (!adev->gfx.mec.mes_hung_db_array) {
> +                       r =3D -ENOMEM;
> +                       goto error_doorbell;
> +               }
> +       }
>
>         return 0;
>
> --
> 2.43.0
>
