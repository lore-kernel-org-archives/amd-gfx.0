Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60368C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 15:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AE310E22D;
	Wed, 24 May 2023 15:24:57 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBD610E226
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 15:24:54 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-19eb96bffd4so319222fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684941893; x=1687533893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAC9tdMb00S7yd2Qf7Jaa3NnA2f8JU7AOomtKdITQvI=;
 b=rHVRhWiVNo8Ptid8T7AyT84Kwm/PoclvEJSwzlMRGPv73iACRkBbKnpWVrKW4lW77i
 ak/xvQ0QTXv/m7uml8G319NPKHDembanuyDjvDXRIGhqp5FkCilQYzZ0uzcIqfb9TYub
 USoO0Og31mtUG3LwBhs+xiTQEqR16yOFgbaBWHQpufUI30leldT86hBjL4lfUFo4QzV3
 w9ny2NwIz55zaJftqkw+uLciFkwBWu00Dz+MDZbsY6vwXZhnddYQ+U0g9lngbdbBGQ9z
 ctPGb3hRLUCr8kJHi6SgvJ/mAKNOsrY7s1R+mdlcFbei0Bx0Ar5Uc5JCIq3gRXvAX29x
 2yMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684941893; x=1687533893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QAC9tdMb00S7yd2Qf7Jaa3NnA2f8JU7AOomtKdITQvI=;
 b=bKlQcFdHVCI7eO4plvvZ3CmXFA3I6XveIUTWbZJak51cT/FvPEnuhrVIjLGIomI0El
 /31nmR8bxbV5mrW33G3NUPQSx+uDFQUlxw/MXEKak7wc48r55LC65dPuDJHuGpKOAAL0
 7S61O0JE/OD3u1qYsaSPl+RHTnNtxVaylLJFKvqlIkOF1I78JsMASoddX6WMrms+bTxJ
 NR62n96iT7yM/ndp1wvGNMaMlRLP6tP/UxNQuHS0KNGDnAUF112xh8M0VDgMquYzScIC
 ByftasFgd3sTvFfeQUQBPovPrVvpXtP0ELDZN95b/11Aqsvee0ZpDUGQg/qEGAMKuDWt
 Qi2g==
X-Gm-Message-State: AC+VfDxCYr4Lmd3uvoipwFST2CqRL6QLXC3PIJJ4r8x0Uw2HIu/whYSt
 yiC5PaY1DeW//4jcUCiPFar1bAkEAJBrn2u095kkNhrK
X-Google-Smtp-Source: ACHHUZ43talidFo06wpMjTULiZc21dEndO1R63o15NTGsrzHdFvkCIOmWsphvWQvtEH7HB46+0G4MZLBt2c54z7jWDc=
X-Received: by 2002:a05:6870:b7af:b0:196:5925:24cc with SMTP id
 ed47-20020a056870b7af00b00196592524ccmr91629oab.21.1684941893207; Wed, 24 May
 2023 08:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230524152138.3631037-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230524152138.3631037-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 May 2023 11:24:41 -0400
Message-ID: <CADnq5_P-K2C2WaNKTfmCxRSKcKRw4Ttr+a7ey0Rn3N5oaCGwZA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix defined but not used gfx9_cs_data in
 gfx_v9_4_3.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 24, 2023 at 11:22=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> gcc with W=3D1
> In file included from drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:33:
> drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h:939:36: warning: =E2=80=98gf=
x9_cs_data=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>   939 | static const struct cs_section_def gfx9_cs_data[] =3D {
>       |
>
> gfx9_cs_data is not used in gfx_v9_4_3.c, hence remove its
> include in gfx_v9_4_3.c
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index ed41a7862d9f..bdaea50cafe7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -29,7 +29,6 @@
>  #include "soc15_common.h"
>  #include "vega10_enum.h"
>
> -#include "clearstate_gfx9.h"
>  #include "v9_structs.h"
>
>  #include "ivsrcid/gfx/irqsrcs_gfx_9_0.h"
> --
> 2.25.1
>
