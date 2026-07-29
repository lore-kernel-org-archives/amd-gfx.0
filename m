Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AB6C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 13:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C794D10EC3A;
	Wed, 29 Jul 2026 13:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ljg11bEm";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 750AE10EC22
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 13:24:46 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-385b78b4f9bso38103a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 06:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785331486; cv=none;
 d=google.com; s=arc-20260327;
 b=P8Q1gyzC0+ExHrtLlxHL6izYM6fxeGddEs8qy9n6xT4gsnFYfag8H49n0XvrgGjZLx
 FJO9WDofBJn19N+QjTwjryZncUB8I48/z5YvpfnioqBUPzMTFOm1cIvQtdFFcFs1WBLd
 ZbAtpNHM4a/nGNRFfqHfv27SAcu1WG6dIpYKGS8Nuqe++mmqS25OPBFOEBZHgWA7Ulus
 tHIUAKDtMu8wdTWF0ycuioxmkyYL8uC2Ph7ZPu6MxkvDNEChhaT5ueAerw7Wex92fRjU
 TRKwu5+wiCAITHQWnEjTw8EbfOHsZlV1PqOoMqV+m8MozuWqNd5BdpHKpshIgPTeyj87
 jWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FMxHAg20evSZle1OQ/hLhWCF0lxvl+hBcpKqdq68BZs=;
 fh=/n2BunVncN5SjtENtLyfU2FR5m0ifX1II0MEVkMBXr4=;
 b=qjBTX+Ma8Z0jW34GgJfsJNjnNNzXlvJtK1yiV82OOsTogLpXrwioJLq1rCudn/FXPr
 QuTtxghy74EM1sHHCbNqHau5mwy5QSKKCFvVG9YGWW1qrAl50MTPZl6OmH5eNtf5pr29
 ZYpqD45IT+Wh92J/P4vTTiplXWzotl4oq1EursX0JFiCk7pnGMafCzLRoWHcu9ZluGyW
 +iRjUR+QmdA6ZIAzSZcgPp/RGLvcQRK80f4iSLIbZSVwRQe/MXO0skUIC+2xM6f5ZDJY
 vW0IuSV8MUKjEkhyGGIX0B/K0f1I3irxlifhHVdaApsoIW2/A9FAgiprswJ/KnencsVr
 dGZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785331486; x=1785936286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FMxHAg20evSZle1OQ/hLhWCF0lxvl+hBcpKqdq68BZs=;
 b=ljg11bEmHvkotAPgTdf6ctacYvIilthOX5NvxF7riR4iylUTsuCBJoyr+lAVS0Kuua
 ZSL61YnZ0bnxmEcp8tYdHX3Cz5q8+cEU64LI8dKdS9b0Wi0JQqyULjbqs9KZKZmw6QUK
 y9rZa/N01YHr6FGhGfdnbg6xfn607Ifx8Ilouc3/uf7RgvR5xzXm2M8s9KxjJzExEhjx
 jjV08HAn33xZSunRZwSwmOpxDg6eNPtnivxRei8zrvWxo5HUKXmn4CDJ8eu32lSgZovj
 lbCYtMzpdsf1mexKimw88VeOGvgaI1B9rFJyQvZcW1DaNK2TyOUC+Kwvm6PQXdWlBkBL
 HJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785331486; x=1785936286;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FMxHAg20evSZle1OQ/hLhWCF0lxvl+hBcpKqdq68BZs=;
 b=k9yvRnNI5aQZjgUryalhw99QEfTcw+iNrgSm+zK3jTwVinweWcUEfkuBUAR7PSYcAW
 HV/fiWMuf6vNm/wYjnzSmfr6jrA8vjA7oR4xdZ45HCvy7eoWSL/LgpbdoFkPzFfjRI1e
 FHlgO59FraB8wF+oF4q6Hfx8bdX7JJ+KuWaGDLoItLUXS0KJnpDL9xyT2ADL/Sg6Vd9A
 p1f4M/AmaUAIGUeAfJuJRefjoTV4lCLdFV3TO1y0YYlPhetCuSKDnol5ux0mewUhl5I1
 TTVam1YgWCltZvi3LWUZxpgmBWMYHPjmKP5esh3Ts+vx2FTMPX08JFNt6isqbYCN7NYd
 MdOw==
X-Gm-Message-State: AOJu0YzIONlB1Tmp2yEy8cI5dNwBQXCGa4ILYVDxAb2f4JECHrnGZA2w
 B37XFGuyo+sBYfGA9wwogFNfzqrPhOiikKV0x5rkBtIc1EnuFNeUFgsLSUCPnWv4YGFM6dAdKID
 ZxLSvxoAkGJtkYsCsKczrJrEysVt8R8WfHA==
X-Gm-Gg: AR+sD101CfHVuopJoXSZc4dass3o2OQOEaXM89hIABURoT/oZMpoEwUIDC/CFb1VCvs
 qNrayswe04qgVVpEtQipc/VpehxjYcaFR0wqkUADt1PruEWHXgdGFez0TOPjOKUbtNRn4YQnMCV
 FFQm9f3UuK/yIT/HeOH3vztH3OnKEtebM9Wtzsj6y6kX3RAbcoGJlARteDBuflVuJJTG2gH1C4b
 f3vF7JZNDg/wZtTvycSPv4aRWEUrM2mG+A/iB0a//xAFsUpp5K2XdmLor7MUqI8hhxV6CEHtfp9
 i9WYH0MjlK2/VO3j7q7Ztra3L/OjzL/HuJm0GQzYkt6gcOyOVf4Y99ibQjTrA2P3RhMjtXR0ixr
 2Hle93i9kg3MHPy3Kc2HZkrjsNJMHZ+o=
X-Received: by 2002:a17:90b:3a0e:b0:38e:7069:7117 with SMTP id
 98e67ed59e1d1-38f6a1ad171mr6178956a91.0.1785331485948; Wed, 29 Jul 2026
 06:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260728234626.86008-1-teobsn@gmail.com>
In-Reply-To: <20260728234626.86008-1-teobsn@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Jul 2026 09:24:33 -0400
X-Gm-Features: AUfX_mxTF-LZlWrjXh4LBoMXhrUraGcVIVWGEA4djUJLfvmV7rvBy26t_YHkV14
Message-ID: <CADnq5_NEU98wff+MiLObBByUUMNkkz7XLZ9MUnGNr1e0B+EKvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Add PPTable power limit quirk for ASUS G14
 GA402R
To: Teodor Bostan <teobsn@gmail.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kenneth.feng@amd.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, 
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org
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

+ Kevin

On Wed, Jul 29, 2026 at 9:23=E2=80=AFAM Teodor Bostan <teobsn@gmail.com> wr=
ote:
>
> ASUS ROG Zephyrus G14 (2022) GA402RJ and GA402RK laptops use custom AC
> power limits of 100W (RX 6700S) and 105W (RX 6800S). On resume from
> suspend, the SMU firmware resets to the reference vBIOS default of 80W,
> hard-capping GPU performance.
>
> Override SocketPowerLimitAc in sienna_cichlid_patch_pptable_quirk for
> these subsystem IDs so the driver restores the platform's intended AC
> power limit when reloading PPTable during boot and resume.
>
> Signed-off-by: Teodor Bostan <teobsn@gmail.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index cef628752..10d330edb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -479,6 +479,7 @@ static int sienna_cichlid_patch_pptable_quirk(struct =
smu_context *smu)
>         struct amdgpu_device *adev =3D smu->adev;
>         uint32_t *board_reserved;
>         uint16_t *freq_table_gfx;
> +       uint16_t *power_limit;
>         uint32_t i;
>
>         /* Fix some OEM SKU specific stability issues */
> @@ -501,6 +502,18 @@ static int sienna_cichlid_patch_pptable_quirk(struct=
 smu_context *smu)
>                 }
>         }
>
> +       /* Fix some OEM SKU specific power limit issues */
> +       if ((adev->pdev->device =3D=3D 0x73EF) &&
> +           (adev->pdev->subsystem_vendor =3D=3D 0x1043)) {
> +               if (adev->pdev->subsystem_device =3D=3D 0x1DEC) {
> +                       GET_PPTABLE_MEMBER(SocketPowerLimitAc, &power_lim=
it);
> +                       power_limit[PPT_THROTTLER_PPT0] =3D 100;
> +               } else if (adev->pdev->subsystem_device =3D=3D 0x1DCC) {
> +                       GET_PPTABLE_MEMBER(SocketPowerLimitAc, &power_lim=
it);
> +                       power_limit[PPT_THROTTLER_PPT0] =3D 105;
> +               }
> +       }
> +
>         return 0;
>  }
>
> --
> 2.55.0
>
