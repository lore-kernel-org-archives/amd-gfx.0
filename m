Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7233CE81E03
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 14:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23F210E52B;
	Fri,  6 Oct 2023 14:41:38 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6207A10E503
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 14:41:36 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6c0b8f42409so1438783a34.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Oct 2023 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696603295; x=1697208095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5el8Mbm6LcJs00amjXpCFgptw7qWLnZzi2ICOdpjeM=;
 b=jsIKQK1oUukUYwiZNFJf9m/WVz9ZHIvw9cGSCWe5q5Pmu+GtIOP141pEfYUaRvgqGS
 310BmJbipNbiFoI6Q7JS7GrMNgptVwiDi0EPMxYkErjEF8s/a7oHwyfx6UNIEP6O5JgL
 y+KiI//capaQ2pNMZOLdWupaZsTkPFk3tIsdaiNuTFIeJMoZ6Imyu5NXcJ3VoSJVeyba
 7Lvfs8A0AS/LIySKez+KUR1LUHax77WMCq+aXGh6ceQtjSlVxUmJAwd5B7PLngCgHUxm
 F7nS17LPngHavO9mSgiFZUqC67FakcqUm5zLsSmJdDuTrlOXAI5m730xmU5+S4unE7AR
 lFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696603295; x=1697208095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5el8Mbm6LcJs00amjXpCFgptw7qWLnZzi2ICOdpjeM=;
 b=cT0dXh2xRf+TBK7BjDGtACwTBEevwS1RK2C6eEurDwS81r+7B9xniclv9cMqjGytPS
 B27bUlotHCqWTcqDXhE0+X9s8pCppNpTI8EJLUJaFW8MQv7knBlYzO0YBAvHTBZ6sY0F
 PSR5UwP0tj0DMHx2Cp+hb71VMv3XSLLMW5NI468QiZ/sPDYUeuZOorK+TGQZoeKujHcy
 1e/HQLRJpN6m7Gyqv9Lp3B5RvLrMCjhXpRTlIy1h84R1Mrv8115agYvX0ETu8hzxFtFw
 F5I4KDxWaT3lNrijlcV9tmUNeAK6tczBmwGFB/rpE0cyRvdbx50syG95b0Idj0esMqWZ
 lgKA==
X-Gm-Message-State: AOJu0YwW6EA5T+UD7vs7aubk6UrNowuyyn9rejjm78FZC6vq1yLtTZ+J
 lJmb5eezRt4u+bsyk/2zuXZr1nDDZ5ridk3oIgsxK9yp
X-Google-Smtp-Source: AGHT+IHMvgji3bCEH5yk17L+mhk15M5xu4KXzwW/5s9ZVx4GSPCtvQYcsekIh1JlGJhf0UFcSjfj01fia7gSsvyAuC0=
X-Received: by 2002:a05:6871:6a1:b0:1d6:bf60:a088 with SMTP id
 l33-20020a05687106a100b001d6bf60a088mr8569531oao.56.1696603295494; Fri, 06
 Oct 2023 07:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231006121151.1502-1-christian.koenig@amd.com>
In-Reply-To: <20231006121151.1502-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Oct 2023 10:41:24 -0400
Message-ID: <CADnq5_OWrymPNsokVdM1gSjc168k2VKzKoZfV8q6TW9BXYpeuw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing NULL check
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
Cc: amd-gfx@lists.freedesktop.org, samuel.pitoiset@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 6, 2023 at 9:07=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> bo->tbo.resource can easily be NULL here.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Add a link to the bug report?  With that:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.h
> index f3ee83cdf97e..d28e21baef16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -252,7 +252,7 @@ static inline bool amdgpu_bo_in_cpu_visible_vram(stru=
ct amdgpu_bo *bo)
>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>         struct amdgpu_res_cursor cursor;
>
> -       if (bo->tbo.resource->mem_type !=3D TTM_PL_VRAM)
> +       if (!bo->tbo.resource || bo->tbo.resource->mem_type !=3D TTM_PL_V=
RAM)
>                 return false;
>
>         amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor=
);
> --
> 2.34.1
>
