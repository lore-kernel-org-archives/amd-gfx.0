Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F12CD609C2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 16:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3AE10E7C5;
	Tue, 16 Dec 2025 16:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OgcYwrJz";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5938510E7C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 16:41:39 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2a08c65fceeso6098145ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 08:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765903299; x=1766508099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXgcKUIHvWk+7yUkth40E1IYhWwgwVRRl8DrUzK2OfM=;
 b=OgcYwrJzqEyCS+9mMCmJBQmEjcPhbfXB8RYz7VS2/8p0CWJUua0hgxPu7TzBYqxN85
 RLi7hMYO95E6YHxTqy08F75Fk+DsTi/GU3g59qNkUfirZKVCSLkaoWxfnHRTV3rtohot
 R2ZiiwpaxRgQZiQGDFCJeZmk/7xGNtptIR8MrDcncZFkNt6PiYq4u+26NLlj0fRGMPJB
 Z/hhj5AGzUi2K3dkUmn10G7FSNiys6jECagkSgCfybQdH2Gi1hS+Ry+E04YdEs2vqah4
 pNxj46V/5vr63MBa2pRCkZ3vm6csxTOldXEAY+1nztlP4r6TrdAWvcy0ug2k74fcxMiX
 UyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765903299; x=1766508099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IXgcKUIHvWk+7yUkth40E1IYhWwgwVRRl8DrUzK2OfM=;
 b=BvLI/Q+4FppHuel2YVkwKKxuCxJxZwGjp1dD+S/eAhtlYVUltYRD2+emVEnEuRtYCO
 S9UEMJgQPLZ5v6AEbNm/+hRj/vP6aG0gimb2leqIekvqL3Sv0UwzRGrWX8sZBVAwd69R
 HjO+NNUbaoHCt1/avaJ4O6pG1aaDnJyCois5rvSKoP6T0M/ZIucFy7EU0iUp5dJWoIop
 TfWj3ifvD3g/eYvU38+zqkRj7dcBC2mKvhJK8LlSykQ3XidL/3ApGcnfh38lhA7SuP3B
 s+mQsnarW/5D4lPy2r5zUeZEVmPA3CXWzHSNLpaFXifRqP4+huAkOdztcqFv5DpWHWE1
 lJgQ==
X-Gm-Message-State: AOJu0YzNNE0ihCdqq/7/m6ui428KEe7iNJhNkkQsPBL1AzTHrhT/JulL
 Qk50sG0Apq1i621sX6imU8Itd+PrKprG3gg6ec293CcwZ5zJIK6omC44HMp9PNx36JvmccH+XgI
 r95Azrq/RW9yHdlfyPWLG4d7z5wAAYeG92L+w
X-Gm-Gg: AY/fxX5yyIS7Rkg84n5fWAMY3xFQsE5NBw4hs/d5fXRrJsjZYnRuK5ahBi6YhnBNcka
 wqBxCX8ou1H17aeDHxOdi8klM5i0vZEyXlocsN3mGEWi+p7eqSQuzQRNf2DFepAkP45zwDR+XbS
 gOTBLaFi2g7uRHC0CNHs6WhneZv10Y7/sHvohnCDHUWwUJrDCNCwOmAfL9d7KeC+0pPgpJb6hkE
 2/66vTkV/p38nw6eh5ESrelVRrWZelkysCzjFHqcHo58wBYhIL5LY/M5ULydxnl2j5AMDDm
X-Google-Smtp-Source: AGHT+IErCVuiBNwamjOtLtqr+s5osQHZRYcIA3UVeT/65HCVBw9K/QiFKyxuaRHRlUP+c5AzF5BD6UVOz+Qakxum77s=
X-Received: by 2002:a05:7022:fa2:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-11f34874285mr6273376c88.0.1765903298709; Tue, 16 Dec 2025
 08:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-6-lijo.lazar@amd.com>
In-Reply-To: <20251203130436.745633-6-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 11:41:26 -0500
X-Gm-Features: AQt7F2rlGDPT3nNgNgHU_8RnCVlG-hc1-jeIsAmDETJCwnFBGoSXUUHjEx_gg3U
Message-ID: <CADnq5_MTMPDT9a-g-SY03HaHuaKpue9ZiKNMebgX7GsrB37yKw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 05/10] drm/amdgpu: Add cwsr to device init/fini
 sequence
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Wed, Dec 3, 2025 at 8:05=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Initialize cwsr handler related info during device initialization.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7a0213a07023..43848e905ae5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -77,6 +77,7 @@
>  #include "amdgpu_reset.h"
>  #include "amdgpu_virt.h"
>  #include "amdgpu_dev_coredump.h"
> +#include "amdgpu_cwsr.h"
>
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> @@ -3324,6 +3325,12 @@ static int amdgpu_device_ip_init(struct amdgpu_dev=
ice *adev)
>
>         r =3D amdgpu_cper_init(adev);
>
> +       if (!r) {
> +               r =3D amdgpu_cwsr_init(adev);
> +               if (r =3D=3D -EOPNOTSUPP)
> +                       r =3D 0;
> +       }
> +
>  init_failed:
>
>         return r;
> @@ -3713,6 +3720,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_devi=
ce *adev)
>  {
>         int i, r;
>
> +       amdgpu_cwsr_fini(adev);
>         amdgpu_cper_fini(adev);
>
>         if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
> --
> 2.49.0
>
