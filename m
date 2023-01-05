Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9809C3DA7A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 16:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE6910E761;
	Thu,  5 Jan 2023 16:58:41 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835B110E761
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 16:58:39 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 n65-20020a17090a2cc700b0021bc5ef7a14so2634749pjd.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jan 2023 08:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C28Vu9xfz/pUMaILk2HgB57u0ZMAPVpPod7tgpaG7Po=;
 b=XWzPujB2kcAQ1TRVT3BpXHws4nH7Jp2f9ePxrw08uomXJslRxU6VEqB7NqnX+xlRHa
 cf748crr/kl5TI4cZ+PgVphkG2lTW3q3B8vXaVG2ofNL9E70oTWbwnbUVQ16V7+MJrBz
 wo2XhvTKg22qC/Z8oraxWJPAM3qKub6W+8TCtuMxZWxR4qaqbGyE05D+w7BMFREZPrZB
 x0ODSU9HoyltxmibIG3nuiW+6gHvvYAir/fD6GePGZp0M8aNWoG+x2kwwJWdg668kuhF
 5VhubgIUYOXqwlU4redjJYEMgjxApXCGJc9VEfXatQn9rGzrkAkSr8W48EnDPijg5mpf
 RF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C28Vu9xfz/pUMaILk2HgB57u0ZMAPVpPod7tgpaG7Po=;
 b=bnczR17lU3ZVvOXcKkqJl1WA50XLHDwJ0aZb8qR0HKLEsJcAx5KJbiR4RKxs0USNVe
 haoYt02dKP8udayM9LfXoC3a9uO/AfYfRiT+7cu0sZ4oEaTxeuyAS1vo9TI1xXn8FvgY
 p5wrM4yAweTWNQa9tNLZN+heibB6RBNca+XH+XUAVLyqpnbo9HvUhc1ynWTd39RW54k4
 SIRaloruoK5GJzqORqfxXiKK4ubV3sJ/Kz/tYCyt73lgusKINaFMHLMr2uGZvUfqES6f
 /2hBTsC2ENlgyKGlCsZDcVoiN0IYv0DVJiEVQCxYYTleZ6visBcelNMEyiiTSwGUwO5H
 WMbA==
X-Gm-Message-State: AFqh2kpMPDG5xdauYE2snlsbcxNVr19jCFD72S/5zE+Y9ZFrjNZQjdY6
 NiTvX5eek947HLZRTz/F1RySLsrm3Mag3O1kkRn3qheS
X-Google-Smtp-Source: AMrXdXukp5pbG/YUhaagqEn5bbT695az5Q3RborYBTyCMu41hbDpqaGGA38ZFh6hagv4jKgxMie/820Nyick5E5qx7w=
X-Received: by 2002:a05:6870:c59c:b0:150:d9aa:4011 with SMTP id
 ba28-20020a056870c59c00b00150d9aa4011mr810762oab.96.1672937437188; Thu, 05
 Jan 2023 08:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20230105111703.52695-1-christian.koenig@amd.com>
 <20230105111703.52695-2-christian.koenig@amd.com>
In-Reply-To: <20230105111703.52695-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Jan 2023 11:50:25 -0500
Message-ID: <CADnq5_OdokG3VZxp0FE-zbvBoLiZcWQkxhcHCwa7ZMCvx2FkOw@mail.gmail.com>
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

please add:
Cc: stable@vger.kernel.org # 6.1.x
When you push this series.

Alex

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
