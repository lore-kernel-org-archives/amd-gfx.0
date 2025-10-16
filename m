Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41175CCD183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 18:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE8510EA6F;
	Thu, 16 Oct 2025 18:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YVyuCBVm";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFB8C10EA6F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 18:55:37 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-26808b24a00so1672785ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760640937; x=1761245737; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2h3cQ7MqwvYxJe0e9/tI2IT5VDSWY7ET10/CmcJCSsE=;
 b=YVyuCBVm4IarfTU8uzoQeL70olzQIzdgTo9iMJi9adCsqc7GO2tOPD7aZCWGvMqVit
 zPG0VrOirI0WjEpbpP/dEsS3XE9z8hyKykCBOVcoyonFOcophzhbYNtIkdyz74I4gBbZ
 OYOb0EyvDfNZ2U6tyMRJ/4pJdtJKYCoFl9wojgZa3dMAsiTk8B/1BwjUyIVZeJl/jVKJ
 GpFDv0gUYIxlfKKVu20bK93hMLfHYHBrTeKpGBluk/uaOXdAZOKqgf5PD/n38ojANzHh
 Ym46GpXMAc8bV6ag1JPSK3I/yYXYHzKYDQ6H3dWANPARwKgT9Fi9J2oywnRb06nRp7nD
 iHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760640937; x=1761245737;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2h3cQ7MqwvYxJe0e9/tI2IT5VDSWY7ET10/CmcJCSsE=;
 b=Ya1Bll8C02VGhUUvQHnM1LWg8YIifoUvVmDoqSEpV1dpudJpy5JOE6weWoCgs7nATx
 bZH2iZCc89HtnZgcTvmwe/2Xx0oiZRY/Bd+Mz8pJ3TOwwASy1NNdHINTQvR8GhfQ7qbU
 VUhB9Kjbhjzo+vUHq1GwjiaIGx03/Id8cTchrPTZZ+vKihT5PxieDqQYLL/ahA+84Nzu
 MjV7IBDhVypevFkobuVbs4dxJP/SuTZjYymCkladYe5lM+drYXwrx8rScRiWrTk85+pg
 CFK3knfyofukaoSTyWilzv8+lWnlgfUiU93vGLEOkA880tuHf381fg6WkE1QLlWhWUsJ
 3Jrg==
X-Gm-Message-State: AOJu0YxOt8pI7RKrbm+KOr35hlTFHfbLLfzOkXlZ+6CEbV+ICnki5ISU
 V1V4HADitbtqPoJvQbg3GsonQI9vsUCSFwTaUffbEHmWIfn8DKXW+5a3HAL0CDrXTvyp2pAlmnC
 A5OmWByktWYjM6AZ1NgGHNmtDc5qOCJah+Q==
X-Gm-Gg: ASbGnctsUhSkUb8SdYG33zI+Sl5WFzxxwo5ZW+Q4Vfn/Ec/XXpEIbeE53WJ7qYbnxUE
 pYOaW6yV1+99H7La3oXfOOIuQx80N6/9cYP4fWL0Xo1Xdm+oh6CPPWKYKRu0/N0GRmvjtyKCHeG
 ZxH5u7AGpuHgV/kXiPb68R5/0JSZDdI0hboNRaJLS+QOuMoGlCf4585gm02DetTdoX3Mz2+tpFG
 WyPKcrhS1JMuXCkfE+wGSk7Y/dmIxTHGOGUAxi1cSnpBxpVkTNB8NqIJdzD
X-Google-Smtp-Source: AGHT+IGvHLkW00L/VZvDee+4p6SoLUtbSbWePyRAbSF17h2uqQbYtcOJYwCz38dcWQG3dsipr79Ls682tClh94epr4A=
X-Received: by 2002:a17:903:1a44:b0:261:500a:5742 with SMTP id
 d9443c01a7336-290ccbcfca4mr5142385ad.10.1760640937174; Thu, 16 Oct 2025
 11:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251016023644.3143128-1-kevinyang.wang@amd.com>
In-Reply-To: <20251016023644.3143128-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Oct 2025 14:55:25 -0400
X-Gm-Features: AS18NWDzI_i-IOf2dXYZDj8VD6eROBEcijCNTTWz33-j45VaB63xwqEdUXZe30g
Message-ID: <CADnq5_OaJavuQf=LgBzQKAXmCxoZMnUwXAOgo-NV=toY4qawXw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: fix missed lock in
 amdgpu_gfx_profile_ring_begin_use()
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com, 
 alexander.deucher@amd.com
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

On Wed, Oct 15, 2025 at 11:26=E2=80=AFPM Yang Wang <kevinyang.wang@amd.com>=
 wrote:
>
> the gfx driver need to hold lock (adev->gfx.workload_profile_mutex) befor=
e
> access "adev->gfx.workload_profile_active" varible.
>
> Fixes: 9e34d8d1a1abe ("drm/amdgpu/gfx: adjust workload profile handling")
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 7f02e36ccc1e..59329e8ffb86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2249,11 +2249,10 @@ void amdgpu_gfx_profile_ring_begin_use(struct amd=
gpu_ring *ring)
>          * the delayed work so there is no one else to set it to false
>          * and we don't care if someone else sets it to true.
>          */
> -       if (adev->gfx.workload_profile_active)
> -               return;

Per the comment above, this should be safe.

Alex

> -
>         mutex_lock(&adev->gfx.workload_profile_mutex);
> -       if (!adev->gfx.workload_profile_active) {
> +       if (adev->gfx.workload_profile_active) {
> +               goto out_unlock;
> +       } else {
>                 r =3D amdgpu_dpm_switch_power_profile(adev, profile, true=
);
>                 if (r)
>                         dev_warn(adev->dev, "(%d) failed to disable %s po=
wer profile mode\n", r,
> @@ -2261,6 +2260,8 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgp=
u_ring *ring)
>                                  "fullscreen 3D" : "compute");
>                 adev->gfx.workload_profile_active =3D true;
>         }
> +
> +out_unlock:
>         mutex_unlock(&adev->gfx.workload_profile_mutex);
>  }
>
> --
> 2.34.1
>
