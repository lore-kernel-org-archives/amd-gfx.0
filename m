Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CDFC3ABD9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 15:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C49910E669;
	Wed, 14 May 2025 15:32:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AOzq8jlV";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B16610E669
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 15:32:49 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b2414d565edso382265a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747236769; x=1747841569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uA2uWlTogQ4mlO6szHzy6P82I+tV300mKpLvgOQQ64Q=;
 b=AOzq8jlVDdovGmUUUvxADswh/TdQmvnggaady5JtojjJsrxH9qm9TnoeboKnyWQgk6
 Xk3+6q5UmAr2vOgsdMxrE5ARvWSLgPWRFPomCbKk5P/mEGWKNjlg4YGNQHFoGdM1S+qJ
 eszAkIOvVudLuvx8HIxjTuu+5Mf0enyOEuAObUOrBrF+GmTYUmTAoI2Dblpql4DG0drn
 K24aY2j1uI62rmruXukXV8ECHRntQHoKD+YkyhyUGUiAMpKOoDzaLW5RzJbD9EVQAgnt
 PmeydQzwrud5BJPHvCxc0rWeyCGMFRjzrnMFFC7AgZYEckDcGmgF+LA3U3sblplfYSpz
 R7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747236769; x=1747841569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uA2uWlTogQ4mlO6szHzy6P82I+tV300mKpLvgOQQ64Q=;
 b=bsLYFtdAYGbLxoF3BRIX3uLGtyGgn+0wcf+VDxZOHLUvfIyxqpZj8LJQx2tX3pOQr7
 i5pxiSRRGIO6pU27o31OfHCpOkmaQOiJOA8P4b8aIWqMqkVrJ4bha6UOmKbo7xd9yhKB
 Ut138mhzZzxTSyTmOUw3MGfrvSRbcDSODspY4+w6pNoKEmsl7UYvKoaqJr/7wBIngXIZ
 EPaq5scKu2MP2JporYnvNNYW5h8kPZltUIioe0Ig1ELx9f1ycc7OWe2d2fIWxa5g9K5F
 zbQKtrumLigmQonStO/+Bw21IT4oOJQBUiyHZGBDdScs1tNyAaaO3zCY0c3bVD2X4KQe
 64mg==
X-Gm-Message-State: AOJu0YyB5iNwKYcR5VWTL0e1//ju6yXqkmAF85eysAk/FXEKAGACV1k9
 IRGDow1qeqIB/GMBspSXVKQbpRA0WHj/gFWTDkUWd9dXLGYOQrFraTk3kfHVyLtYxFHYOKoNdDJ
 2WABbCHWlAvMFV2d/HYnjuouB0FM=
X-Gm-Gg: ASbGnct6tHIpg3ZKhNASoEu/Di3Bhw070JMa6v/36LzTmkBH7t7CEbp94xayGXGrwnZ
 Xh45TGUCsi8j70e89ATkVE3BsP96Df89jw9nDtlu6jio8/mb4yS7AzNmzRkZrtv0vj2y1BJtuEu
 TM8EFC+Y1MbhgZjrJ6slq+ZU2Q2SUX43HD
X-Google-Smtp-Source: AGHT+IFgQITF5uI5NQsQl4sHyt8Q8R2W7lZ9VF1QYEU450sbMP/AY6liue31FMre7n9iKyQ5k4xxboK8+HF+HoEOO+8=
X-Received: by 2002:a17:903:986:b0:22f:d4e7:e7ca with SMTP id
 d9443c01a7336-231980fa693mr23391755ad.6.1747236768816; Wed, 14 May 2025
 08:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250512022016.395502-1-Prike.Liang@amd.com>
In-Reply-To: <20250512022016.395502-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 May 2025 11:32:37 -0400
X-Gm-Features: AX0GCFs6bk1FNaZHrxqMQUvJ_dl4_HyziNOdQ2DuGUtlJpwPtWjp2P-bhHsmYNQ
Message-ID: <CADnq5_Oept2rLB4Wi1eVYt_8V-sZzUkM_rSw1-h64kSmHKhMxQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: lock the eviction fence for wq signals it
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
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

On Sun, May 11, 2025 at 10:21=E2=80=AFPM Prike Liang <Prike.Liang@amd.com> =
wrote:
>
> Lock and refer to the eviction fence before the eviction fence
> schedules work queue tries to signal it.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 1a7469543db5..d5f176fef357 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -108,12 +108,18 @@ amdgpu_eviction_fence_suspend_worker(struct work_st=
ruct *work)
>         struct amdgpu_eviction_fence *ev_fence;
>
>         mutex_lock(&uq_mgr->userq_mutex);
> +       spin_lock(&evf_mgr->ev_fence_lock);
>         ev_fence =3D evf_mgr->ev_fence;
> -       if (!ev_fence)
> +       spin_unlock(&evf_mgr->ev_fence_lock);
> +
> +       if (ev_fence)
> +               dma_fence_get(&ev_fence->base);
> +       else
>                 goto unlock;
>
>         amdgpu_userq_evict(uq_mgr, ev_fence);
>
> +       dma_fence_put(&ev_fence->base);
>  unlock:
>         mutex_unlock(&uq_mgr->userq_mutex);
>  }
> --
> 2.34.1
>
