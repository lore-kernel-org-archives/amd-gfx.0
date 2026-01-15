Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FF9D3CCAD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 04:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EED510E6B1;
	Thu, 15 Jan 2026 04:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EQk5MSEY";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8101010E6B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 04:15:54 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-59b8364e4ccso585854e87.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768450552; x=1769055352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWbFRgVf/RX+hNnhNl1m3KoBqdnsaNRs2wJDQeHSfW0=;
 b=EQk5MSEYYPFOoB8wxlusDKeJxTdoGPDucLN4xgMOhNgXLdGNRmjVGO4vSuJfno7FwA
 fiXAV+FoKZqtaflsKHQHY13gmVX5d9QUwplYP8MyONCH/ZhRI8aGiAIlewPGerDBeLuU
 tbVJhjq9KH1x7fHPSQLxtUCafzbJupmnTofx/6JWYK5ywrRbP86zVbjUqAuYsOQprMKB
 b2B1e9nTsGKSHcDBt+mItBM0q1D3HeueulyUP8rxV2AwdZjc5f+pWM2h3uPTQeIoIw/2
 RiyJWj20AvOLGLS5Y5elEcg7ZdotRolunJhnw++/ON4N83wKb3MRSihXdBLB8r6y/Y58
 1nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768450552; x=1769055352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YWbFRgVf/RX+hNnhNl1m3KoBqdnsaNRs2wJDQeHSfW0=;
 b=vbVJy4U8LaPf5qz592fBpnJpAbxc2TA4jIrkOdzemRn66xM0KkrBPg80CJOxejyzBW
 VRmeslopHQFU44YA/NA+kSH1YwfVBt465FuEgvAf1/rOdx+VWDgyGeYpcpKCL1ZkCphE
 ejvz2YOjmPf+8D5+WhNuQTnGSW5lssomL47UPWA9VUfHAUg/oOVqgkoJRdcj/yzsXpW5
 Ir8YJR2KOW2vfe4Dky2werqRYwYVwcHxPCUJuCUai1Whh9Tmha6cbvGeDeEbFmUTgFKP
 4U0FAPi6jfqNm+oNTpWbq4IIUfOlqN/YmY1iNbkPNEd5OFbWRgnBMn9MM1w9MQel9h/w
 CD9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCwcjC+56Df3ZQqi7BU5Cfgj2356QiezBqTndtvp3HqgzjkYdZYlDdoRTVduz9fXlaCyuWwYE9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUiiQjdYZDucBQwqSb+ypQKTyRf8bPmAAhFQoBAJ/cS5MmAyet
 RkasatTISbX81PwaoBzPEwoolm4NUUPkxUjCb5XzhjJcWhJoU33sZENsndruRbyBkMc/rIvSDQq
 MqcrE1aQjTCRS4RfPuTGNWcbM+yoBNUk=
X-Gm-Gg: AY/fxX7GUf/EkYcoh/c53Pyy2Aeqm5wNy9DZJNS335IRnI1RBwbiz3pxdUv/sc1x93l
 mdYInhgG+10xV8EmZmKG/qicR20G+EizFV+pg9dD6UeLXPacAEzt7yHkWH1v2VY9djce8mmJdOt
 c1NNvdaSQi11ZK0cUGKp88pCe/K8GeJOGZcaiKTNmn3Ix5T4cugIPSHv/aGI4vyDQUE1TPfnLVa
 RghQo5vHxLWD0W7/+ILh18kYvgy8Gm0q0VKICfxXlvl7EK1460Qim/ro5rLAArnbHK192Ym
X-Received: by 2002:a05:6512:2314:b0:595:7fed:aae9 with SMTP id
 2adb3069b0e04-59ba0f65187mr1512690e87.12.1768450552306; Wed, 14 Jan 2026
 20:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20260115025548.621264-1-Jiqian.Chen@amd.com>
In-Reply-To: <20260115025548.621264-1-Jiqian.Chen@amd.com>
From: Amos Jianjun Kong <kongjianjun@gmail.com>
Date: Thu, 15 Jan 2026 12:15:38 +0800
X-Gm-Features: AZwV_QhhH---C9lyrWmJA-En51bRt-JPAOcO015O4fVZ11WYibok_BJJrBtnLyw
Message-ID: <CAFeW=paBoemhGFkra+qf7CwrmoQSEXKwsLJ1rzS+CL91_3=x1w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>
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

On Thu, Jan 15, 2026 at 11:02=E2=80=AFAM Jiqian Chen <Jiqian.Chen@amd.com> =
wrote:
>
> If drm_sched_job_init fails, hw_vm_fence is not freed currently,
> then cause memory leak.
>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
> v1->v2 changes:
> * assign the return code of drm_sched_job_init and check that instead.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 7f5d01164897..1daa9145b217 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -219,8 +219,11 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>         if (!entity)
>                 return 0;

I have a question that may not be related to the PATCH.

Why not check 'entity' at the beginning of function amdgpu_job_alloc()?
Currently if the 'entity' is invalid, the allocated 3 structs won't be rele=
ased.


> -       return drm_sched_job_init(&(*job)->base, entity, 1, owner,
> -                                 drm_client_id);
> +       r =3D drm_sched_job_init(&(*job)->base, entity, 1, owner, drm_cli=
ent_id);
> +       if (!r)
> +               return 0;
> +
> +       kfree((*job)->hw_vm_fence);

The V2 looks good, it's already addressed the problem mentioned by Christia=
n.

Reviewed-by: Amos Kong <kongjianjun@gmail.com>

>  err_fence:
>         kfree((*job)->hw_fence);
> --
> 2.34.1
>
