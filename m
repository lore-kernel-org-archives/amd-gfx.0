Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B980FC282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 21:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475EC10E1C2;
	Mon, 17 Mar 2025 21:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Og2H+QKC";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A5D010E1AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 21:35:26 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-21f8f3bd828so9754925ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742247326; x=1742852126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVxxhb7O56xynAQqbxG0M3q/faEv984KSYd2TegLLQQ=;
 b=Og2H+QKCFIXNpj90ACl6Pl6nBEBHWVG0aK2rX5itZf73il1bwnrifKV+Ofa7ZF8Vji
 yURBhuFyvoA6hj976htM31OxtS+Di47sn4BP6JvxFuZpLaV2M9AzFQxE/XFR/vqpryVp
 1Av/oMSWIiBW2kxOlUC/A1b9XuI/TyDGGnfzTWDritWuAIQAikQHa+CO+J0EoWBhkzFz
 X/dF1Ozg1D6aRpHj5cqZtx7SipTdyCS41KmAuhXk5GrPEWa7UHOXO0JuocaDZPxbzD/q
 CehOlPfB+rSdyVrl74RcRMhzFb6hvLJj2tlbIUUFSuoHGAlg7gFsOeHENGRKvSgYEc+D
 9erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742247326; x=1742852126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVxxhb7O56xynAQqbxG0M3q/faEv984KSYd2TegLLQQ=;
 b=H3Wbv2i9O6yaXhBONbEUnEBsL8J2hqOEZYV1NHm4VS9ZATqvR3heKf6LyI/W9kuAgo
 fGL2eAsmciQetd7f7guMx+ktRMAexNghHpoYZjUK9aQuDmzx3nfakhXLZ8f1/yqbDZW3
 kXzIswsT0V36hv5bf4YgE1uTStx6NGKarVTdd92Pp4XYanP7rUW9W2kyn0nStbnxnT0V
 puCducb311z+4Dj0iDxQ0HuhhJ+atwNPteWhSrCpTfXQeEawhkswW4b7Nz2RauFyeDCq
 FWUJEFOu876AQbinG2ZsfKsooK3G9LVKF3BD1EmoCnY3l1dvsqShSzy/xiVvWQBNwoIC
 B9YA==
X-Gm-Message-State: AOJu0Yx0Ovlf5ZrllqyI2dbPiKz3D1FXmCjT2x/cSb9jc6C9fPMOyNAF
 9EFzc0m17wVHY3kRuJ+i3g5hwc5zV1ibHdwk1sjHybYdR5EJD+F0iJyJEZ5v3+O22jCMdm4uXFA
 zI+abIoZysy5rNgetFZQwlEAjM1U=
X-Gm-Gg: ASbGnctEtBlClN77hr6MMFDRQ0LkursCEOjhlnD1Lm7DD+wVuYE583z8Ord7liH5xUf
 3+b0SPwCftwoIlF6/uTcbXIwqBKnLbN2N8oULK0sUIPW8lE05qhFq+AJQDJ0iakBhEhIU6DsWPm
 YM3tLk0zEAoMwHtxMfQYman0xNgg==
X-Google-Smtp-Source: AGHT+IHgbPzuhOLG4ZGeCGOkcnLYbpc41AO7z7BBRxIbQ1mCYoKwMg8INCbXB3I+241ATjuKroF8UwjnEY1cScNAtc0=
X-Received: by 2002:a17:902:db0d:b0:224:1ed8:40e9 with SMTP id
 d9443c01a7336-225e0b14a53mr65267535ad.13.1742247325657; Mon, 17 Mar 2025
 14:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250317210327.7699-1-yunpa@amd.com>
In-Reply-To: <20250317210327.7699-1-yunpa@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Mar 2025 17:35:13 -0400
X-Gm-Features: AQ5f1Joie3UMU3iRxfDVuFhdnJuefBDpWa4x8JrdtyzFSFKhxgvz4hZkn2mqWFg
Message-ID: <CADnq5_P6VjpesN-8MS1qDVWeO1Lm0zceXhdQgy=1hYfaRCfoqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable amdgpu_ras_resume for gfx 9.5.0
To: Ellen Pan <yunpa@amd.com>
Cc: amd-gfx@lists.freedesktop.org, shravankumar.gande@amd.com, 
 Victor.Skvortsov@amd.com, Ahmad.Rehman@amd.com, 
 root <root@ubuntu.myguest.virtualbox.org>
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

On Mon, Mar 17, 2025 at 5:13=E2=80=AFPM Ellen Pan <yunpa@amd.com> wrote:
>
> From: root <root@Ubuntu.myguest.virtualbox.org>
>
> This enables ras to be resumed after gpu recovery on mi350 sriov.
>
> Signed-off-by: root <root@Ubuntu.myguest.virtualbox.org>

Please fix up your git config to use your email address.

Alex

> Change-Id: I77e81e751cf7f31481c6f2ee6bd86758722fd2d4
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7ca2ebdd3c95..7ac7fb45d286 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5324,6 +5324,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2=
) ||
>             amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3=
) ||
>             amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4=
) ||
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0=
) ||
>             amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(11, 0, =
3))
>                 amdgpu_ras_resume(adev);
>
> --
> 2.25.1
>
