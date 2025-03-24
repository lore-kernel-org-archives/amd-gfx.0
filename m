Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E13C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 18:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64B610E277;
	Mon, 24 Mar 2025 18:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vywai0r1";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3301C10E277
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 18:21:05 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ff5544af03so1454994a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742840465; x=1743445265; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpZYGzIvYe7agRLJpsJCHMnRv3Zt4E5A6+iFWQoWTN0=;
 b=Vywai0r1BAe1Gel0gQUiZxW+GZU2zvyFDQe9KdytVKbhEPNiBmky3uOes6pFES0khp
 g7aZuiZGqn6Mw5GSfz64GAkOkWyyHXao4Xwdc26483clYGOwT965DyZFueiumVA4XWod
 V8iClEa2RA9fy9G+TeEhYGxm5qihy0f3FScdGrwaEBrdb3wtW7xGr17tnOVMOU4P9Qtm
 iZEjjHkghBmmBNAHExDfehNFa3ZfdIeZsFRKzLXyLWUNu2wKnMrddWUsCSKj51Zm7NC/
 NqijjkLKbaOWYUxUtN3vc0xJByhAmhpZoBzcd4TwHCP75fWHJnI4x586/k+hJG+S5Ydr
 yrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742840465; x=1743445265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cpZYGzIvYe7agRLJpsJCHMnRv3Zt4E5A6+iFWQoWTN0=;
 b=C1Fd4NPR9m1tuGD4xyJNNkzAuixlZttsoy8kkNmjTsMen+8vsIo24b/8TNErL6MOPo
 ny7B8zUHXajfXaq8P5qtUXIWUkw9ZNmOnIrMu+u0vkqhQFjSyYwySw7r6STontlx89Jp
 EkIst1i2J1Lh0xbp61XR6kyDE53O6e0WwtScgljgGieZeg2b0rvFDO+FfA2PfY0R05hv
 8A7sMPQyermwLKGV4ND9Ky5ZaruL990iVq19AGUTCO1zOWon2wSaNrVhcf0p1jSU72it
 uE980E3dShrypp4h+fE3bZ5MeNdzpduwdFFIGFOl6WoS/Vq8Adijjku7MFFEnK/uxHhG
 wQ4A==
X-Gm-Message-State: AOJu0YxUH2wH/z+4/XoNzoPTViP6u87EiktX7Qon+UzmQfEPBycmLsq5
 3nEY00HIPmORYD0gYLdto2UicS2Ph2EdkIXw/CiZhuzipL9mfpde0IHVEX8dS2USRwSheNUore8
 v3/s3dzKb3c5unjwSjVMk5ziKVqg=
X-Gm-Gg: ASbGncv+Zfb1zMsa+9Vu8f+pxi+NoNaJnRYj/DYVBdus01Ss+1NxR7Im6DRh7+FetGQ
 NuILsGV8c764BfjDD8t6RszwG/tLxJuZ788ltvhkhw7eYnmYPka5q9yC9NsYiJRTp9wdIhBmHvt
 CNvs0uAXacPAvl5BAOnahVHRjmqA==
X-Google-Smtp-Source: AGHT+IG1L3hLA8LxfqSqTcx/IWUexOMHh0LGFsAUlftq4oDbwLNVg2+WQ6YqvgTf3qE+JK4Fjpl/V1VkLtz+2Vq3U4o=
X-Received: by 2002:a17:90b:1647:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-3030fb1fbc7mr7805002a91.0.1742840464484; Mon, 24 Mar 2025
 11:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
 <20250322183746.86002-6-alexandre.f.demers@gmail.com>
In-Reply-To: <20250322183746.86002-6-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 14:20:52 -0400
X-Gm-Features: AQ5f1JpP3LqxOxk8c_m_E6sQXAA6mVT5PC4w5O0q07AmcbM0-rcHb3TIHBQ_AC0
Message-ID: <CADnq5_MKMrECPyheRymSxEYXA535kJURMng1AHsusp8WWvuUNw@mail.gmail.com>
Subject: Re: [PATCH 6/5] drm/amdgpu: fix style in dce_v8_0.c and in vi.c
To: Alexandre Demers <alexandre.f.demers@gmail.com>
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

On Sat, Mar 22, 2025 at 2:48=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Bring things on a single line and fix spacing.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 10 +++-------
>  drivers/gpu/drm/amd/amdgpu/vi.c       |  8 ++++++++
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index f008615343c3..533851beb27c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -3233,8 +3233,7 @@ static const struct amd_ip_funcs dce_v8_0_ip_funcs =
=3D {
>         .set_powergating_state =3D dce_v8_0_set_powergating_state,
>  };
>
> -static void
> -dce_v8_0_encoder_mode_set(struct drm_encoder *encoder,
> +static void dce_v8_0_encoder_mode_set(struct drm_encoder *encoder,
>                           struct drm_display_mode *mode,
>                           struct drm_display_mode *adjusted_mode)
>  {
> @@ -3330,8 +3329,7 @@ static void dce_v8_0_ext_commit(struct drm_encoder =
*encoder)
>
>  }
>
> -static void
> -dce_v8_0_ext_mode_set(struct drm_encoder *encoder,
> +static void dce_v8_0_ext_mode_set(struct drm_encoder *encoder,
>                       struct drm_display_mode *mode,
>                       struct drm_display_mode *adjusted_mode)
>  {
> @@ -3343,8 +3341,7 @@ static void dce_v8_0_ext_disable(struct drm_encoder=
 *encoder)
>
>  }
>
> -static void
> -dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
> +static void dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
>  {
>
>  }
> @@ -3407,7 +3404,6 @@ static void dce_v8_0_encoder_add(struct amdgpu_devi=
ce *adev,
>                         amdgpu_encoder->devices |=3D supported_device;
>                         return;
>                 }
> -
>         }
>
>         /* add a new one */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu=
/vi.c
> index a83505815d39..bcabcf27c3d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -61,19 +61,27 @@
>
>  #include "vid.h"
>  #include "vi.h"
> +
>  #include "gmc_v8_0.h"
>  #include "gmc_v7_0.h"
> +
>  #include "gfx_v8_0.h"
> +
>  #include "sdma_v2_4.h"
>  #include "sdma_v3_0.h"
> +
>  #include "dce_v10_0.h"
>  #include "dce_v11_0.h"
> +
>  #include "iceland_ih.h"
>  #include "tonga_ih.h"
>  #include "cz_ih.h"
> +
>  #include "uvd_v5_0.h"
>  #include "uvd_v6_0.h"
> +
>  #include "vce_v3_0.h"
> +
>  #if defined(CONFIG_DRM_AMD_ACP)>  #include "amdgpu_acp.h"
>  #endif

What is the reason for these changes?  Unless this actually fixes some
style warning, I'd drop this change.

Alex


> --
> 2.49.0
>
