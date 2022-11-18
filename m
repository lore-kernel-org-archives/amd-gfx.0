Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930EFC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF4310E74A;
	Fri, 18 Nov 2022 16:00:13 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8055810E765
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:00:09 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 j1-20020a4ad181000000b0049e6e8c13b4so836713oor.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 08:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVl0sPKDOY4ALovvD3/pqNYlaPCFBFHOWX1p36dj/bs=;
 b=atHQWTRiyMhBlPqeznji0CFn7ILO8skgIKX3n/0oQdu5Ez5XKKFFcBtE7HOE7zqO+2
 KoUNk5+I2NQXHzui1tjkj2WLQgdYZDAgdVb2U0YPK+PEpQ5Jb6Th/7u+iwj6vioMBch3
 T9dPefrSf+sSG5yJAJmu/fm1GJN0MiUkOv9ls5/xbdQFZpLgGN6SIMeBRSpKsO8zcGuC
 AZxSgY7m4KyOPqFdVrGkk3Ws5+U3VB/cUQHofwSEMaK3fDcBZxEyv+Dg7GVf1LlR+34C
 zkajeVBdcRmYPCiFkBRe5lNVuJVC5b1i8Ds9I3kHxR7DjNHa4/6oGXPSrjovptdsgxJG
 WAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SVl0sPKDOY4ALovvD3/pqNYlaPCFBFHOWX1p36dj/bs=;
 b=lT/g4f5B4d7OxR3Ol3oV5qNKvHRf5mf1L7kbcFHAY/3n1tRqP/EyUREHULRD2sKai0
 0Gn5D++6RqRPQdjNl4jdUNboNXyaiYdvMcjG9PEyMHXxg1ROBcrgkRnv1/IOj/eIgiot
 40q5a0zbCPjgbjbRfvCVk5GB37PbotBzp59YusGPbG0+SuM/OwqGx/2rXxncY2eCD9fN
 aOKtQfD/pe9K9dridsGnTMSqmaiHwGzq6qBkCFoMt6f0XTCJ0mbydeDj5w8zl/+Adr1B
 94pqjRqN3n9pLKaffbJFnH73Blcbjy0QhqxznOMI38YjCT4NhAvYPY+qpIs3tD9VO+0L
 ofzw==
X-Gm-Message-State: ANoB5plMM+tWepvEUo2ina++H9dHPWdJiDfZTkd42CGdVOKni0MQo92m
 DhEQO/dhX2onSLHdsV/w5XLMmr0OF6pFvRkiC4M=
X-Google-Smtp-Source: AA0mqf76enzueSEEpXKo196/GWYk47OwxCeFxkOR3gMrujeuVF8ZIdB1GFR21IKexiQsFj+s5+HHTRAudfyQUbVC8gI=
X-Received: by 2002:a4a:4005:0:b0:49f:4579:ccc8 with SMTP id
 n5-20020a4a4005000000b0049f4579ccc8mr3722549ooa.70.1668787208751; Fri, 18 Nov
 2022 08:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20221118153023.312582-1-christian.koenig@amd.com>
In-Reply-To: <20221118153023.312582-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Nov 2022 10:59:57 -0500
Message-ID: <CADnq5_O8LtcH20CoY7Rgsi6h9S_NFxLsLeBSGwGC=ZkYiNBDGQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: handle gang submit before VMID
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
Cc: Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 18, 2022 at 10:30 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Otherwise it can happen that not all gang members can get a VMID
> assigned and we deadlock.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Tested-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Acked-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index cd968e781077..abb99cff8b4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -254,6 +254,9 @@ static struct dma_fence *amdgpu_job_dependency(struct=
 drm_sched_job *sched_job,
>                         DRM_ERROR("Error adding fence (%d)\n", r);
>         }
>
> +       if (!fence && job->gang_submit)
> +               fence =3D amdgpu_device_switch_gang(ring->adev, job->gang=
_submit);
> +
>         while (fence =3D=3D NULL && vm && !job->vmid) {
>                 r =3D amdgpu_vmid_grab(vm, ring, &job->sync,
>                                      &job->base.s_fence->finished,
> @@ -264,9 +267,6 @@ static struct dma_fence *amdgpu_job_dependency(struct=
 drm_sched_job *sched_job,
>                 fence =3D amdgpu_sync_get_fence(&job->sync);
>         }
>
> -       if (!fence && job->gang_submit)
> -               fence =3D amdgpu_device_switch_gang(ring->adev, job->gang=
_submit);
> -
>         return fence;
>  }
>
> --
> 2.25.1
>
