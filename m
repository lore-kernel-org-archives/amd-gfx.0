Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34656CCD1BC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 19:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B4010E08C;
	Thu, 23 Oct 2025 19:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cR9CP0wm";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA4D10E08C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 19:02:19 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7a275143acdso72806b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761246139; x=1761850939; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jSE6efL+eygooGf4aajoMP2c/goChzVEJJet+7N6KE=;
 b=cR9CP0wmy00IF4WalLWvpw6TKyzAYfFcBGtrM4sPZ+G6k/cbSPGFPYdoL0q7m8F73Y
 U74xFKremJAtsegVTBY1eAosXuAX4KxZbJ55yEDdMsyzJybiGcBIzc0jP11fwxAWgGVg
 oMDcXk6KXV8fJZVv7KQq/HQjL/5okwh5bDY39dVscR7TqMviqCarsFlwRxJAI6IKsBrH
 WiBbMo0fIQ7rxgNW4uUWQKB6TSk9mdllj0vZfH7VdT0/QI6u07qvzrm4vQS9PRSg3b4R
 cDQpF6Y+KuLJCIuD8HBZnj6SoGg/QvFEd5meAmzA2nQxmAW75Pgu3Ox0Guq8pU+GFWaj
 t8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761246139; x=1761850939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jSE6efL+eygooGf4aajoMP2c/goChzVEJJet+7N6KE=;
 b=IJmc8DmZEoX9X3kUCfFNWqOZqkpnxls5TRB33hVe360e4ajeeCqqUge43/bpTilMos
 VRRT75VVMZfjjgPprdM9a+w9K0fTWK8P/Ux2lM2YFdtJy/JgHZHjcZf8a77i45vnZj8u
 6mDz8leI433XQJ2P+A1lYdyeWWOBV9WFStLePmK1CKFlM1Onra7kJbbgD2dUw+/GTv4z
 mIjlRfCbHb9OWcJ1E5RIcxEUNN4V3gmNb5ft1zUy09EwQyMpNPTNuhOgULOnOr2GKDaw
 mdFGssWafbXblLJ381PBLgR5ZRnMoM6n5N5lftrAnDu1Hw/I21dvvrEjKaGJpqOSto/I
 QL4w==
X-Gm-Message-State: AOJu0YzWeefApx1IiRJY4qMvZZdxdpnqwNWzAdOmkUPx9R05V/UDP1XH
 yCTE+gZ8qUcP8ZdWpFTFkegsTCvz5MOt3NJ3tMKQfsKoiii3lp3eVCRzmUJLHZutZH1yFqSpmKo
 EAKB3zwmD+F3ekqcyXR3/WLmCAUfNB/iHDg==
X-Gm-Gg: ASbGncv87vJpYah2ja3AeIOXAxyTgcx3G4PCpd0SoXmdr58KDP6kqPViC4qWOOGJb5Q
 0J03wKShSROmqrJj7ljDlf6rJduxT55qxLgaefDm/MU+9zeiHDdrivtC2hZUFhhE6knAp0bwpDW
 rfgJPc4hUyHKp80FG1TscMQ63TStto4MgcR+cXUh0Dc6LWznoFpEUjl9wmt8YrnGjh9EyF4sPsC
 gfO/5B/FG3NhAg6+FzN4BAqbSc9Yq9oESrXGm1zZZYnBqUiKP0BAC9F50hXdrydJFc5Cs8=
X-Google-Smtp-Source: AGHT+IFa5Fbx5f3NavK521r6w44ewrhrsb4H4qajdUd8JJEUgmqzvYutWoCW0mi1tfhiIc+E2KdZj/CTajBvFlocz8Q=
X-Received: by 2002:a17:903:234d:b0:290:8d7b:4041 with SMTP id
 d9443c01a7336-290cc7d4ac9mr158427655ad.10.1761246139239; Thu, 23 Oct 2025
 12:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251022212026.1785896-1-alexander.deucher@amd.com>
In-Reply-To: <20251022212026.1785896-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Oct 2025 15:02:07 -0400
X-Gm-Features: AS18NWCph5UHmFGgbiWNnmtFHkhI96VkqMs-xMHJcW4igBNlCoEtcxK225xeook
Message-ID: <CADnq5_My0DMdKpPRDeKrTXU_zXhV=xMGChFsLSDzM7MjO81BRg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

Alex

On Wed, Oct 22, 2025 at 5:26=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> If we don't end up initializing the fences, free then when
> we free the job.
>
> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 3d396ab625f33..8ad8b16e96760 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -295,6 +295,11 @@ static void amdgpu_job_free_cb(struct drm_sched_job =
*s_job)
>
>         amdgpu_sync_free(&job->explicit_sync);
>
> +       if (!job->hw_fence->base.ops)
> +               kfree(job->hw_fence);
> +       if (!job->hw_vm_fence->base.ops)
> +               kfree(job->hw_vm_fence);
> +
>         kfree(job);
>  }
>
> @@ -324,6 +329,11 @@ void amdgpu_job_free(struct amdgpu_job *job)
>         if (job->gang_submit !=3D &job->base.s_fence->scheduled)
>                 dma_fence_put(job->gang_submit);
>
> +       if (!job->hw_fence->base.ops)
> +               kfree(job->hw_fence);
> +       if (!job->hw_vm_fence->base.ops)
> +               kfree(job->hw_vm_fence);
> +
>         kfree(job);
>  }
>
> --
> 2.51.0
>
