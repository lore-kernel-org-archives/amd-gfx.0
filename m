Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9255AC3DA7D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 14:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CF310E027;
	Thu,  5 Jan 2023 14:36:01 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3102010E027
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 14:35:59 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 v15-20020a9d69cf000000b006709b5a534aso22580618oto.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jan 2023 06:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iUkPYK1iLfRZhcWrD5hqYUGCsBdG7XRaH7Lv04rHE4=;
 b=PlsemODosOH0uggwM7zhZ4GdZBr+vIoPX8LNdewqFvaz9DuwYGSrfgm+BSGG4MXC6Z
 WWPDeMhZvc+qA5AecjAQVS9athrDAEL0SqBDHyWcA7jaY/SwWuar3qm9lKh5bBesAoF3
 xIDt7tY7ZeCCsCUb38aUhwK3ysn66mM6EiUK7HCTdVvauuYwiu59fp7gyZ9FEAsUgr74
 6qXGIf0CtLJcMc6QYYOOBCWOEbHUX2e71X+mgOqv8gVASAsolyRi74kbyVgJFixdbGNa
 IfezYYzMmtHNdA3/E3dsIsuNwlDEim4ns36mAIhSHAx4RGVnznhC4IadsapTCiC+XDwr
 dcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1iUkPYK1iLfRZhcWrD5hqYUGCsBdG7XRaH7Lv04rHE4=;
 b=01jIIz7yNPqyhK2UGLxSNFlIVxKpNP1TPU8vG02ppp2LPZpucG+JVmxNgoyXorq30K
 jaN2fJo6I9TAJgFluoCHLpDOX9MMWzBYny2xEJrDTwVn07lTU6/QbJoW0b+uoVROwrKA
 pcb4VVFOp3h2vjeXv/92F5p/xbC53MJv46l8jbEzd/7DE/PVJYaPsL4DwOfWo5U9GBpx
 5sU5uvGZN1X5GXaNLp3P9F/uoDPaAcwJ61BWuTksUfxRXsKuJVzGHfa0T08Q/RD+zq/f
 x0usPj3EKLkBsr6DiLzeAW00JXLUWow5/QT4+7QjpgwnCBLXgv0BGElZu5AlT/SeH0xB
 yilw==
X-Gm-Message-State: AFqh2kqk25OicU5fPonkfNM7sFo2eZKRtw/gw9mXViu8LTmg3WRCyEOH
 xBu52YKCAb7mO3P/cCNd+bNaL+EpUHgmOrQcwPI=
X-Google-Smtp-Source: AMrXdXtDCro/9Hf3A08qGZiJp3un/A620Uf7u48ju0zimVsZ186w5lTcDggk6VG7wLTrcqwqPCGYm//7a4RoyuEuRAU=
X-Received: by 2002:a9d:6ac6:0:b0:671:cacb:681f with SMTP id
 m6-20020a9d6ac6000000b00671cacb681fmr3221674otq.233.1672929356960; Thu, 05
 Jan 2023 06:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20230105111703.52695-1-christian.koenig@amd.com>
 <20230105111703.52695-2-christian.koenig@amd.com>
In-Reply-To: <20230105111703.52695-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Jan 2023 09:35:45 -0500
Message-ID: <CADnq5_MW-g8FbLNgmk2KHev6KAk7GwDsRRyYP_uc8mA4qk4c2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix missing dma_fence_put in error path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 5, 2023 at 6:17 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> When the fence can't be added we need to drop the reference.
>
> Suggested-by: Bert Karwatzki <spasswolf@web.de>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sync.c
> index bac7976975bd..dcd8c066bc1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -391,8 +391,10 @@ int amdgpu_sync_push_to_job(struct amdgpu_sync *sync=
, struct amdgpu_job *job)
>
>                 dma_fence_get(f);
>                 r =3D drm_sched_job_add_dependency(&job->base, f);
> -               if (r)
> +               if (r) {
> +                       dma_fence_put(f);
>                         return r;
> +               }
>         }
>         return 0;
>  }
> --
> 2.34.1
>
