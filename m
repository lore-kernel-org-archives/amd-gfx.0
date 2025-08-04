Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F59C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 14:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9E710E211;
	Mon,  4 Aug 2025 14:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nY5ITAs6";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E5F510E211
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:58:34 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b350c85cf4eso509758a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754319514; x=1754924314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7/ASt/irUPb2g601c2QDSCmGB9ne3khsU9MiNt4vQ4=;
 b=nY5ITAs6T/XbOR7rFFgKBQ3zIxWhxSS5r4JV1axEFWYkDnFphne0Ctu/WX8w26pNyf
 m2iTm7Blw2oldch0m0M02+ZfoNBbSTzTDVjbjCCztc8mDwh1kKKVFh/pY78JU4PbFTFH
 PQMgDK67ZqoWUZbRiCMFoAqthYu0tabt7Orb4VEbgo1mg7CQdusVr5SqIv+pLf63t+eu
 E/jHRGYwXULDZHqICeGYF+1qYOf8vbNVILbNFqf5xotfvpreeJnNuCbwZF73u5z53Af4
 DgscYuQct+E3NpnjnDJd8/YTEM/y1JTD2wy9Zb9Fq+s6o8DVG/BgTbiMMQ1xMHuE5M5B
 sPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754319514; x=1754924314;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7/ASt/irUPb2g601c2QDSCmGB9ne3khsU9MiNt4vQ4=;
 b=nz1mqLAiwOfh0UasWHZrXBD5X4JaYWUCiEiPRLgFCsRKyfpuDLYg+7/qxQk2825WZa
 hjRJ6faY5o9yM2pBuKvoAKTEHnOs8UDrTplLsK4teLVgDJNTt6gpugMDI04kw1+t4otk
 gBOH3O7z5C/rf3qJ/nDYw1LjefB/l6lBxJ6+9RKzKRBW8AFgmRe3TJgceZ1KexpvC/Qb
 nF0rdTbH5nVmVJCOInOaeIThTqqh2rn7cc7Ouw0opxxDD2O/1ZrYcwiOugDmCYkkcmCU
 IIvsgDLVDRfm7LJCAZVNOavZmZVGKuijc9Js/cvXKb7P+sU07jvc5Cweqy2Qd3zjeuyl
 eeRA==
X-Gm-Message-State: AOJu0YzAsqZB1gV+27PZn6Vs/9PjVrP4HJQhZ83yPLccbXGnmPy8Vvog
 xppKfMlJ6uSzALEtkyv3/a7qBq9epQektDc7GMiT4mAT0WyFoEp8pNcqeoQhXGmTls13Ork24Ue
 U+XaaGvBXMxlQayMV7XJ5mhcL8R8Z6beVbQ==
X-Gm-Gg: ASbGncvJQCmHVJsmC0LXLEIqAk5jY47E5ABO/Gnjkw+09Z8snJJW0Etobal/haK7ZYd
 LmopA1vxusq5Di0hik/qi7iVcVHtnegdkEBS4T164defLyAIPeuDSIlcZKy/0Rj7G7SMgMgj+XW
 QO5nVCoARNQaAQiCnXNpVRfCIUs8nET28lLdJlFgQK4q9bGGIlJGTZpX++mgCFpPZb9jpvzP4o1
 9DZ7KmT
X-Google-Smtp-Source: AGHT+IHnKvKiNnjlutaqdoCUWb0lWfV5Y9kAcO0MqZsWa0lJGxMv3NvJtDT1awL/N72gQsh33nqXYiAys09W1DIvQ+U=
X-Received: by 2002:a17:90b:3e8b:b0:31e:a421:4de1 with SMTP id
 98e67ed59e1d1-321162baaf8mr5566304a91.5.1754319513895; Mon, 04 Aug 2025
 07:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250731224951.8631-1-xaver.hugl@kde.org>
In-Reply-To: <20250731224951.8631-1-xaver.hugl@kde.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 10:58:22 -0400
X-Gm-Features: Ac12FXwybowAQCCms396RCTCdCKzGr7u5lfBU9xfKB_GCNmaaQpYGuGENmin-H4
Message-ID: <CADnq5_PQf9qY1+UBzd7C-dbs6mWifCapsywwrfoQrFX1+ypi_Q@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/amdgpu_discovery: increase timeout limit for IFWI
 init
To: Xaver Hugl <xaver.hugl@kde.org>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
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

On Thu, Jul 31, 2025 at 6:49=E2=80=AFPM Xaver Hugl <xaver.hugl@kde.org> wro=
te:
>
> With a timeout of only 1 second, my rx 5700XT fails to initialize,
> so this increases the timeout to 2s.
>
> Closes https://gitlab.freedesktop.org/drm/amd/-/issues/3697
>
> Signed-off-by: Xaver Hugl <xaver.hugl@kde.org>
> Cc: stable@vger.kernel.org

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 6d34eac0539d..ae6908b57d78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -275,7 +275,7 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,
>         int i, ret =3D 0;
>
>         if (!amdgpu_sriov_vf(adev)) {
> -               /* It can take up to a second for IFWI init to complete o=
n some dGPUs,
> +               /* It can take up to two seconds for IFWI init to complet=
e on some dGPUs,
>                  * but generally it should be in the 60-100ms range.  Nor=
mally this starts
>                  * as soon as the device gets power so by the time the OS=
 loads this has long
>                  * completed.  However, when a card is hotplugged via e.g=
., USB4, we need to
> @@ -283,7 +283,7 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,
>                  * continue.
>                  */
>
> -               for (i =3D 0; i < 1000; i++) {
> +               for (i =3D 0; i < 2000; i++) {
>                         msg =3D RREG32(mmMP0_SMN_C2PMSG_33);
>                         if (msg & 0x80000000)
>                                 break;
> --
> 2.50.1
>
