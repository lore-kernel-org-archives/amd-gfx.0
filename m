Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE00C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 18:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6BB10E226;
	Mon, 14 Aug 2023 18:03:06 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D19110E226
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 18:03:05 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1c4d7103ef5so1009481fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692036185; x=1692640985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N838FwxdKWBfmd6tjzMIYLDItPCxOEfwubTrqOPE6rM=;
 b=IjkFAYijFVUqNabfpK6xuPQ/zWJWObT2zUhlenzpMNI6as7b0tJ+fZwNgt00e8p198
 xQIcm7oShnps2W/qcchaF/Rx29riPlwZd+MvuXFiGEJ5nkH0GIyqMMvEfe+eiWRVu9k7
 aPO2rCOQSmh1uNBA1HcBp74oghGqPwcIsWb94jaRUuH9bkw1EiTF4jFdEUkGz2tl6J9l
 oTqofFbgVhTgRO+DWNwndrlk3YyUbuhMt/9O1jCoadl8P7d6VouQLX9RQI2WN8LCCIJA
 IISigq92J/Yve8OKmKxcF+l2mJ7RLYiVvLeOFcCBJmSYfAF3ao9q7Kn2qUTGoszxK5xV
 7UTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692036185; x=1692640985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N838FwxdKWBfmd6tjzMIYLDItPCxOEfwubTrqOPE6rM=;
 b=ddwKi8adcXEFZmyWu3KE6QLU9+OjfGnRPocGvJfaxb22USh/v3aquAb2N2ai8rD23i
 NHkr10A/zIZh1bnSsbZ2pDXhK523ZLKZL81ZAz7tqY+T/og6LmE+t1aPkjvqF59ozuUU
 B5zJSadace4dTjZTE+ta2ipKqzrCW5bR7lGB+HN6byiasCag9HxUhcg5slP7uPcfBo0Q
 GUVh6D5WQKjTerEc9J5EwTR3ZIZaoZ7OvvWe7G3z1fuGBBSJBQgNY2SGrDCoIED7qLYl
 +aUdxgpK82W8DyxWZeHT7+42q23xQmkxLLdQ1DJJTIpvAXcaLv2z09S+aaTdgwqQDzrf
 v8GQ==
X-Gm-Message-State: AOJu0YzoVBRU4+OVmYltBFMuNASarpyZNXNaSw3tNWOcb7qUezgvKC9h
 ivkrs22Q23Gp484xBQKft/HXpjR55INL+76q3hA=
X-Google-Smtp-Source: AGHT+IH3JjI6nh5/4daNdzrBwnNJzO6CjkACAyiVKBmlGheHLvkjEOSRojfZZziswVDV8ze9P9oabQHTfsNzkPvYn1I=
X-Received: by 2002:a05:6870:178c:b0:1b0:3821:f09b with SMTP id
 r12-20020a056870178c00b001b03821f09bmr6340339oae.13.1692036184811; Mon, 14
 Aug 2023 11:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230810115612.23428-1-guozihua@huawei.com>
In-Reply-To: <20230810115612.23428-1-guozihua@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Aug 2023 14:02:53 -0400
Message-ID: <CADnq5_PtdevnCt-R__KsL7KD=1cExNqCPubjEzSs72wEmON1Yw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: Remove duplicated includes
To: GUO Zihua <guozihua@huawei.com>
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com, Xinhui.Pan@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Thu, Aug 10, 2023 at 8:33=E2=80=AFAM GUO Zihua <guozihua@huawei.com> wro=
te:
>
> Remove duplicated includes in amdgpu_amdkfd_gpuvm.c and amdgpu_ttm.c.
> Resolves checkincludes message.
>
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a136fba9f29b..7d6daf8d2bfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -39,7 +39,6 @@
>  #include "amdgpu_xgmi.h"
>  #include "kfd_priv.h"
>  #include "kfd_smi_events.h"
> -#include <drm/ttm/ttm_tt.h>
>
>  /* Userptr restore delay, just long enough to allow consecutive VM
>   * changes to accumulate
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index dea848bb55c1..f5aa1362c818 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -49,7 +49,6 @@
>  #include <drm/ttm/ttm_tt.h>
>
>  #include <drm/amdgpu_drm.h>
> -#include <drm/drm_drv.h>
>
>  #include "amdgpu.h"
>  #include "amdgpu_object.h"
> --
> 2.17.1
>
