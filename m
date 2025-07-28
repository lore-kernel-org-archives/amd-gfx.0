Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EA7C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 17:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5A210E54B;
	Mon, 28 Jul 2025 17:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h4ZTpNmE";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF00910E54B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 17:17:58 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-31ec2ac984eso257916a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753723078; x=1754327878; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uH+ktUl9/ifCjNK/A+5z2Aqh3zIuFdvKcZy1lSwN0rA=;
 b=h4ZTpNmEINELP+45YGTuJ0uPlhCPMW0uySCG5SbhouH3x/6PzK9+Q9QNTdb+cuZge8
 4X9KtAmaNsJ6km5lKBulPDhqoQ0mJf1+Yzn9xIog18dUaLTxAySDQqk5/0eL2gs8Iza3
 de3axIXsNIXlH/JCQHzMUTBHI/0SPmDkmmueHgPITQ7JgAyTpkr0GAnMcmOAZKYEcaV8
 e8mK8UF1HcKFxJ9awkNbmGjkbzsfNjodS+1po7NUujBIIGcljF7N9R3dUv11aqFj+HKb
 5uO57xSAOaedkw67qH5d/shopqrRnXWqAAeXixkm77JbKp8uHYsOeDNKvFt76MNjQpL1
 7ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753723078; x=1754327878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uH+ktUl9/ifCjNK/A+5z2Aqh3zIuFdvKcZy1lSwN0rA=;
 b=iX4K4R/J5+0WvRY87YYXP4qlqWQis3KytX1cPR9qRVAM90H7KvsDbuMGFn+i9/9mR9
 mGoPese2k9q5DS2hnkX/lXI3GqHTvLlXnGrUw/ejTMCsS9c6Lp6NhAdmdD/4QT2O4fVC
 2oXD7yJZCh0U8hu8PwGaN62GlLF/s0+exgGHX7TMy8g9lK/JUVi+5IenNFEpi+VhkVao
 49VNIitJf/E0pUgt3sEfvQh0gMNOAsx1jySkrq6hfK24M+nwdcmyvmqE21ZxIDDW7BCT
 2r2XRB/ar8qbMR45XSRLnZInxpa2AG4QHWv416hXS/H70q9InuV2msvmAUrLtBfFLRgO
 rXvg==
X-Gm-Message-State: AOJu0YymxWA4W8fi/16I6GvegT2db4KgRe1sGaScN5H7fisvc4h8M5EG
 U/dhBPfgN6CHb5rFmr8MINUSV8eLUDuOzkJgTp8wkWPMJVksKFaNDW4yWDU6YkY/dZf3+dyifuE
 SHsX63vXU5u6IfhHnfx+RXHavw8KZmWQ=
X-Gm-Gg: ASbGncuuMIlFHrwKpoI8xBV2unMGlgNHOLuNnaIzkjPhGyTX9/NhZxiESOxGjWoOBMK
 rYV9aYT3D5h7GTf3mf6ZhzL73M9d26iv/UUeqfu0quxPrzeqxv/i8jKWBYVdP1ibSNDoqMA/AnQ
 YKz7xB6fulb7zHgznWn7oOXae9uWlOYKO60w3j4WTv/HcLg9gCyJv9Fq4K48LMG43ilgcCDnfA2
 fvxh/kpugoV0UcF39I=
X-Google-Smtp-Source: AGHT+IG40z7xtdj0AudMoMPkzjB7C2RADGHHqJMLLqlTWWtavnUKWdIM5GtE/55Jd+DFOuWPqEwPSAPi33tYL8SbAz4=
X-Received: by 2002:a17:90b:33cd:b0:31e:e880:8b83 with SMTP id
 98e67ed59e1d1-31ee88093a3mr2571285a91.3.1753723078360; Mon, 28 Jul 2025
 10:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <1103498267.150074445.1752966181999.JavaMail.root@zimbra39-e7.priv.proxad.net>
 <20250720141318.4845-1-ydirson@free.fr>
 <20250720141318.4845-3-ydirson@free.fr>
In-Reply-To: <20250720141318.4845-3-ydirson@free.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 13:17:45 -0400
X-Gm-Features: Ac12FXwG77S71lmXWIJyzmwrCQRPnLBWFRURiARWMX1h7Fz5BpyfVARwSYSs3B8
Message-ID: <CADnq5_OZ3_apakBCNem+S3TaKwACO=NWGbNzCPRoxEwQ66jW2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: fix module parameter description
To: Yann Dirson <ydirson@free.fr>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Applied the first two patches with some minor changes.

Alex

On Sun, Jul 20, 2025 at 10:14=E2=80=AFAM Yann Dirson <ydirson@free.fr> wrot=
e:
>
> Signed-off-by: Yann Dirson <ydirson@free.fr>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 4db92e0a60da..f940068caf72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -885,7 +885,7 @@ module_param_named(dcfeaturemask, amdgpu_dc_feature_m=
ask, uint, 0444);
>
>  /**
>   * DOC: dcdebugmask (uint)
> - * Override display features enabled. See enum DC_DEBUG_MASK in drivers/=
gpu/drm/amd/include/amd_shared.h.
> + * Debug options enabled. See enum DC_DEBUG_MASK in drivers/gpu/drm/amd/=
include/amd_shared.h.
>   */
>  MODULE_PARM_DESC(dcdebugmask, "all debug options disabled (default))");
>  module_param_named(dcdebugmask, amdgpu_dc_debug_mask, uint, 0444);
> --
> 2.39.5
>
