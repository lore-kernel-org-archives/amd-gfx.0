Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854F7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 21:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C3460EE2
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 21:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38C3460EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB506E864;
	Mon, 27 Sep 2021 21:37:16 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F546E872
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 21:37:15 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 q26-20020a4adc5a000000b002918a69c8eeso6479374oov.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 14:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p7rMBu1JVmjcHzDG68/56/VZDdc1BL1xwLYd7kqXCKA=;
 b=L2pQv7La1QrykFZoLb7xXjQKdzdOEnpNy6eyvvOL+qQUEKi97tfwh4iPlcRylbH8eZ
 RKAeV8I9mXFHZV3WufL7ZtnASWWxPmUPPphxFAUssV5VTwtnHkimO+utmqSazr9WRF8N
 yhA54BbYsUi8DCVX6tZc7JvJhVkkVU8CQETlCuJKySZLgQqmBIpKqu52+Z7yfbzFe3fD
 fMYKFsfdbGnSS4MijAWypCUYst8XhnrhorVxuteBVo+0acDMQHMrkALC0EMPXKdTlwuR
 FuqLktJ4/X6qQ7uyks81VoDSqU/oDvqE4qY3LjFN8VE6fvkGZDCwr/sredQKJtQjuqPC
 MLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p7rMBu1JVmjcHzDG68/56/VZDdc1BL1xwLYd7kqXCKA=;
 b=Y5qF3GUp6I2RMhYJOV9QwuYDE203s0hd847F1j91xP0/g3E54hFtHz/Psomo9AT2v+
 Ww9ZybF32VhsTMIAC+pZrlpdm2es5zw+xnVG4/MSV9EwroZv7BCjmIVcT25ItupQkx3O
 DYNe+hS0/TS8exXpfkqaZkIeWu++CE9r6Fal83ff9ny1GauTH1uAxWay5tFYuKAjshuM
 iup3vzMcRcTUlVdf7vWsWcm+wPiLCQun8TeClJZ+Pny6Ovuow5B8x9aIhAKiaQ7kEkaE
 clZSWPqNzdObLzigObseJ6hB0GntJyeh0FfB0rMjGTzdimOH1uDzd+R1D8nsXvwtFoTO
 W3JQ==
X-Gm-Message-State: AOAM531tUZN2vLFDTX7/CzN9WEZ2noqsN5D2RqncVYcNY2c/rYLZfWMz
 cZNLDyYYz+r8aj/qj7ax/feEMTJ52yp3aP1m90KMyHNMWek=
X-Google-Smtp-Source: ABdhPJyiDyPYBK8RPa5xjmbnY7KMNf3vcdNWumr5YNZneQe0CUF4/E24GBU+yjJbm9ayeJM9rsc+aAt3dd/tRpZBlDk=
X-Received: by 2002:a4a:a6c6:: with SMTP id i6mr1766229oom.73.1632778635042;
 Mon, 27 Sep 2021 14:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <CH0PR12MB520112519F74BF4E6F2A9FAE9EA79@CH0PR12MB5201.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB520112519F74BF4E6F2A9FAE9EA79@CH0PR12MB5201.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Sep 2021 17:37:04 -0400
Message-ID: <CADnq5_Nkc53ws2Z5YM+Ges+Jgg9QfrLt9oMJbjy8_EJVC9PaOg@mail.gmail.com>
Subject: Re: [PATCH 02/02 v2] drm/amd/display: add cyan_skillfish display
 support
To: "Liu, Zhan" <Zhan.Liu@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Charlene" <Charlene.Liu@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Sep 27, 2021 at 5:16 PM Liu, Zhan <Zhan.Liu@amd.com> wrote:
>
> [Public]
>
> [Why]
> add display related cyan_skillfish files in.
>
> makefile controlled by CONFIG_DRM_AMD_DC_DCN201 flag.
>
> Signed-off-by: Charlene Liu <charlene.liu@amd.com>
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> Reviewed-by: Charlene Liu <charlene.liu@amd.com>
> Acked-by: Jun Lei <jun.lei@amd.com>
> ---
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1d6cc93..0c669e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1968,6 +1968,9 @@
>         case CHIP_VANGOGH:
>                 chip_name = "vangogh";
>                 break;
> +       case CHIP_CYAN_SKILLFISH:
> +               chip_name = "cyan_skillfish";
> +               break;
>         case CHIP_YELLOW_CARP:
>                 chip_name = "yellow_carp";
>                 break;

Sorry I missed this before.  This change is unnecessary.  there is no
gpu_info firmware for cyan skillfish.  Please drop this hunk.  With
that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex
