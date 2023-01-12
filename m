Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4EAC54EBC
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 14:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBAB10E8F2;
	Thu, 12 Jan 2023 14:05:40 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8D410E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 14:05:39 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 f5-20020a9d5f05000000b00684c0c2eb3fso1560399oti.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 06:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n71UOiGds9dqpvPic03BWL1oPR249647GGlAjvB0zWY=;
 b=YCX/kKbZ6unkRpKXdzk3Nos6IQTIoQ9BfLt6rYXFcDPoLBQ86MFX0apN1jaJkK2L5g
 CDPWLZ6o2X3u60WsGAu1lpHxfYTSkSaW02k7QtR+lRmEDSNT1BhnKBcmVTJz7umQuOWO
 zo1j5QscI1pToe82Ax0D+/tykQPSv96aNm006yQliFe6l0gixjXYPXzZfhjWfZJDANeM
 1Ul7rYepyAJ8eqsSqT9IKTmSW7w1VrYF+FAuI1EmDWGWc72UstaGQq8dGIIrGeFnhOHP
 gr6OFdVLtD/exUxfvslRBBjkLRAqyD0VFxJ8xgpTXH1K3wbGcEcYfO2urVi1da5ulQNc
 qsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n71UOiGds9dqpvPic03BWL1oPR249647GGlAjvB0zWY=;
 b=4lRM0QgvHOrQrl9LglHkW4d5hnofFjAO06dwtRoVa9hNjh1ilCfkRDAFSdWGqoSRNd
 JDJuE0QvcmiH4JWOQlrRQBgl4Mx3RXieOCD5ppi6Ck8swSC3T+rvfxN8BJt61FCMam4t
 lEJdOV1bPeAmm9xZu3L3C32kj+sys7rUU0pV9CVFhhUhkMFbIYoMWCknzRZMWa46Ui7R
 +VY/YiAi7zSRlqCYEaPcYeINkuCfbZGQLu45kmB++1UCC0DQJRq6tdgqCF6MtYFXOqSQ
 uc/Y5cWXPhwe5aPguKN7lovZklVqb/hUHsLypEtkS3Rwd5T5GQDqBaATYLIapHtKPCs/
 FUTg==
X-Gm-Message-State: AFqh2kqqAg7iNIU1hEgg3HSw8Gg1id98ZegTvlNDx0GKoFXX98NCDOLf
 1/VMWAk/iebYSTzSaxUpzC3/OR/huBrfs+DVKz8Eq6tKoNs=
X-Google-Smtp-Source: AMrXdXumgvOIKIDxSDZtkzkutzG5Jw1PeAxKAdSjj65slWTixgxMAF/ZhVRJTcJfmsqR79n1O95m7pbYERlYrH0JhRo=
X-Received: by 2002:a9d:489:0:b0:684:bedc:4f54 with SMTP id
 9-20020a9d0489000000b00684bedc4f54mr255978otm.233.1673532338466; Thu, 12 Jan
 2023 06:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20230112134811.495086-1-christian.koenig@amd.com>
In-Reply-To: <20230112134811.495086-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Jan 2023 09:05:26 -0500
Message-ID: <CADnq5_NC93kgwPZxv550JxtzMDb6=Y9Pi4DAED5B1sZiiTx-vQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_job_free_resources
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, thong.thai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 12, 2023 at 8:48 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> It can be that neither fence were initialized when we run out of UVD
> streams for example.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2324

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 9e549923622b..28929c6219a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -161,8 +161,14 @@ void amdgpu_job_free_resources(struct amdgpu_job *jo=
b)
>         struct dma_fence *f;
>         unsigned i;
>
> -       /* use sched fence if available */
> -       f =3D job->base.s_fence ? &job->base.s_fence->finished :  &job->h=
w_fence;
> +       /* Check if any fences where initialized */
> +       if (job->base.s_fence && job->base.s_fence->finished->ops)
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
> 2.25.1
>
