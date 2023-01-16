Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2BCC54EBE
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 20:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4770010E4C6;
	Mon, 16 Jan 2023 20:16:04 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB68910E4BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 20:16:01 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id v17so2955523oie.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 12:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QigZbi52NqRvig/LROqmqUOaJynFzx/7ysmQqfPxLG0=;
 b=RawWag+RwGRb3zw7CSVLZngFKebaOwk+6MUWvIAOaaFtVk8jsVObJ8YocxfOYPWRUV
 Imw2VdvU3b0rgVAfWMIeXXV5SRMFt1/MxSS1hvURKctMLQ7je5t86k8gwoJX/aWm9ZGx
 K+UofYHxDnDucRYlumlFsz/RKEtW3sgATRhhcKzp3W9Ywko09zCSoJpacKeJr+K7k8js
 u2koTGUbR76DXl0+rlmJyXoxHFs5sYiU+NxCDy5gYXKoaTnzSb50ro0YJci9ANx8iSDH
 ieYLXsRomxWnyq/uHOnbzggY2no4sEtsErPR7CFv9AarQTwOgRs9C/x4AV2Egi2dqZKM
 epQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QigZbi52NqRvig/LROqmqUOaJynFzx/7ysmQqfPxLG0=;
 b=sYMX9opOBtzZ5YztfU1yAhnrEM5w7AQS0vcok/w1Ri42lEk1FWmhhQS3QhBd5j/L95
 ztI/5Uj+C3wLsx9aAhiSAYAvuapghmR1x23aEY7fNRYvo7YcbEXM9U22a10ooI7y2UCi
 Ig2IrCLV8lyDwAc64n0xaqNOqclfeZjEhXno05iWdopK00x+SUSD4yDuYtkz6YyWqVh0
 obuiV6H+iQpejaY9uk6eN9WrxIjmRZnov5VHmWwLIry7i9dhHdernnYGYYi53rp1N4Fd
 ir4bCAqKstATYCHZ9wpkaL+HPSjUbkL87qdVDLG/tk0F1a9q6an2Hsx8JcLdooOPy/AO
 lMPA==
X-Gm-Message-State: AFqh2kpuYCbWgHqkubYzZ93zRa/YSW4i5/KkeM2n5SMUvHM3XA+DGEYA
 nwBfh2ZRqRoyKW/bOgkgHcJ5pwRIUGcBpieMFtCRj7sA
X-Google-Smtp-Source: AMrXdXt+YHtj3EtkD4eK9ggn6WHjqWqsMi8fCPvED/K855RHYB5sXeuZUpMPqKDlJk9Xuhrstalhj7DaL9rnNE41Us4=
X-Received: by 2002:a05:6808:4387:b0:35b:d93f:cbc4 with SMTP id
 dz7-20020a056808438700b0035bd93fcbc4mr34938oib.96.1673900161117; Mon, 16 Jan
 2023 12:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20230116201218.5113-1-christian.koenig@amd.com>
In-Reply-To: <20230116201218.5113-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jan 2023 15:15:49 -0500
Message-ID: <CADnq5_OghKCnPJ_eGZQ=de2zaXfC6syG_h_NYCQrPLM8dT=ACQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix amdgpu_job_free_resources v2
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
Cc: amd-gfx@lists.freedesktop.org, thong.thai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 16, 2023 at 3:12 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> It can be that neither fence were initialized when we run out of UVD
> streams for example.
>
> v2: fix typo breaking compile
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index f4a3122352de..6b73c074aa25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -154,8 +154,14 @@ void amdgpu_job_free_resources(struct amdgpu_job *jo=
b)
>         struct dma_fence *f;
>         unsigned i;
>
> -       /* use sched fence if available */
> -       f =3D job->base.s_fence ? &job->base.s_fence->finished :  &job->h=
w_fence;
> +       /* Check if any fences where initialized */
> +       if (job->base.s_fence && job->base.s_fence->finished.ops)
> +               f =3D &job->base.s_fence->finished;
> +       else if (job->hw_fence.ops)
> +               f =3D &job->hw_fence;
> +       else
> +               f =3D NULL;
> +
>         for (i =3D 0; i < job->num_ibs; ++i)
>                 amdgpu_ib_free(ring->adev, &job->ibs[i], f);
>  }
> --
> 2.34.1
>
