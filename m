Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE274C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 02:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF0310EA13;
	Thu, 13 Apr 2023 02:49:27 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FF610EA13
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 02:49:25 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-183f4efa98aso22336455fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 19:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681354163; x=1683946163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eV9+XNddzm1+UzfseBDE1svOoKVj42ndjWoyi9SZB0k=;
 b=L855lw4UYT4/CqlYHi1eQ4UPpa3XbGjHzFuwde/7vp5fkhFWoXi36/WHdeZXeZa2Hr
 60s2tlDTV0M67DbJrEMJBTiUFIW2R0LHjw2Xe81v8LFb1gP7SQJR5sqxMFfh8UTMpAB3
 8fyXRKPvRVZHnxeHEK6AIq1ipVpjCnMwwLGByVFrTh/WvKp3zYjNE4whhig7ATdnHpJj
 KjZ6h0q6bBcG5gRDw+P+rkDzwqUI9TR5JruIvAXOfh+lfaSmJsDNuDUh/Z931zXCa0m+
 iwGj9HkGs6+gtE4/jG1Wv/QZDbgv6U3fI91EyT0whs9EkxdOSGB+X6/1kduXFnaLYix8
 o2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681354163; x=1683946163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eV9+XNddzm1+UzfseBDE1svOoKVj42ndjWoyi9SZB0k=;
 b=DFWaU6Rrybohtez3r1C0P+lHtSl25xOgu3Q8KXuqHvouZeZhUMNFHNhzHnl8Y4S6pi
 paYGYv5E/GzBuTH+GW8YPdDC0wKpMewei79yV9WXJC/9/edHXIx6viztRJ38Fn2qJszk
 kksGFbhSQ1OS8oaasYlHWNWyxpFh/nkVRwJSKDbluiXmeZVGXdGHpMBD8GeQT7SCrYSp
 Lu2mCMcApC5zfE8ReDZuO7nYJ2BItuaPY8tuKcc+TTFpcHgvMILpxW8MQQzwOIgMfsqn
 vcuKm16vhdLFvtN5eL+IFdMZu4fG2MW/IOAJ8PhElBXBA6TQNmrELSTGiP1exVdcEKjM
 XUKw==
X-Gm-Message-State: AAQBX9fadTTKOszF3r0uGahPikLvFvkdeH5UPqpT9BBF6dEE5u13ak9p
 5kV/NqcrxZ7KyG9aEknQF8QxQKb2HuQWqyXW0vM=
X-Google-Smtp-Source: AKy350ZW6HmiT606YUHkEpmuR/jKulOsjFhfeMdO04ITWkUkc1tAf+5HVvYmj5Y71l8Q/FqQBUAjtD/nXWLS1Qvx5+8=
X-Received: by 2002:a05:6870:390d:b0:184:2e38:c7af with SMTP id
 b13-20020a056870390d00b001842e38c7afmr556358oap.3.1681354163503; Wed, 12 Apr
 2023 19:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230413023406.3111352-1-li.ma@amd.com>
In-Reply-To: <20230413023406.3111352-1-li.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Apr 2023 22:49:12 -0400
Message-ID: <CADnq5_OyshRbebpyk-eZoz=akYf8RVN8+E2kjPp=jj8dEYQ3Cg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reserve the old gc_11_0_*_mes.bin
To: Li Ma <li.ma@amd.com>
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
Cc: Alexander.Deucher@amd.com, yifan1.zhang@amd.com, xiaojian.du@amd.com,
 amd-gfx@lists.freedesktop.org, tim.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 12, 2023 at 10:35=E2=80=AFPM Li Ma <li.ma@amd.com> wrote:
>
> Fixes: 0f486b64b8d4 ("drm/amd/amdgpu: introduce gc_*_mes_2.bin v2")
> Reserve the MOUDLE_FIRMWARE declaration of gc_11_0_*_mes.bin
> to avoid falling back to old mes bin failure via autoload.

typo.  Should read:
to fix falling back to olad mes bin on failure via autoload.

>
> Signed-off-by: Li Ma <li.ma@amd.com>

With the above fixed:

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 7e8c15cd8dc2..45280f047180 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -32,14 +32,19 @@
>  #include "v11_structs.h"
>  #include "mes_v11_api_def.h"
>
> +MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
>
> --
> 2.25.1
>
