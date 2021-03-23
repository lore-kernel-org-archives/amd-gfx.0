Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6174C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 15:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C8C61983
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 15:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C8C61983
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130436E150;
	Tue, 23 Mar 2021 15:14:19 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD466E150;
 Tue, 23 Mar 2021 15:14:17 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 68-20020a9d0f4a0000b02901b663e6258dso19751163ott.13; 
 Tue, 23 Mar 2021 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X2/dvppl9EFycIbzir/9o2eLnvUFv2pJ4xfdH+MA8QM=;
 b=UYL7rLim99JevyGztNbHniK+OkVfhlRvzTAL3RkiH8/YQTtZTQTM6+dc0rvPvDc2eP
 o/5tgadaF2WWFKuJfSiVvaxfxamcwfN1D80bNBUKwo1u96pAZRa+OCuybj1dmJI4IWAf
 PlIA1zuFfV+0jKBBp7Kc6qhSo3IVU60AV5w1d+QQCxjnQLzt7UaMtQx4qQiJyI1Z6yap
 +9VUSFj19N8glrhb1A4IqQU5icycGjm9mq7t9VX5wvQoSRTYcgMzm1aTrsenoUUYwGle
 XWlJ84ApF9FXH6EN3rh4CJuUB11mVfpKNhcpIGaJ6oeZbOOOkrdAZKTs/uDG8DA7Sruz
 sDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X2/dvppl9EFycIbzir/9o2eLnvUFv2pJ4xfdH+MA8QM=;
 b=uXR6B0WwuX3wFRsFYHuz8NqBY8NHDWYcN/vuZDWufP012GFatzLDw7VVudMiP3N6RF
 Cap0dlwWzhNHdFKw4NX4wnxdaJW1ZVQmtfBHYHwOTR7qk3r9XE5F/AwEpwlSdK3AMQB8
 U0kyiCudl23Mm1Gaq6jlBkN7AEOOM1vUq9bAVllIfYjpSGCIcv1C3jms+We3CeQaNc2g
 sVOrJetwusvj3UVKnDnpJvUgIGghbRW/JgOyU7FbxsccphYDxVNzxjBBKbYf4HdYG8lq
 LYseUZibuSj/TRk7EUJLqkQu3W242YXzAYru/dROdo3266EdnzvEFa7jGxboo2CBCV52
 FbCQ==
X-Gm-Message-State: AOAM531KsOfyPM6oMbK0rUA4oe4TjPnVOYYa2W/VFBv5iFWXqsIylIjO
 9C0/UWNLcEg81hKnFV+lFhFVGMQ4KIv/JPsVrOs=
X-Google-Smtp-Source: ABdhPJxccxo6qay1Ja8B5rRGkZ84PCoqVfKLkENwqOk7ApRciBrgC59v5U9P9CD7fq7Ef1XGJlgxtw+h+XkfyAT3oxU=
X-Received: by 2002:a9d:750e:: with SMTP id r14mr4876999otk.311.1616512457068; 
 Tue, 23 Mar 2021 08:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210323011923.133284-1-wanjiabing@vivo.com>
In-Reply-To: <20210323011923.133284-1-wanjiabing@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Mar 2021 11:14:05 -0400
Message-ID: <CADnq5_MWQPaSjKY5ky2xSacUr5_fP0uDiw8TU3HVA6QC6NvAtA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: Remove duplicate includes
To: Wan Jiabing <wanjiabing@vivo.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 kael_w@yeah.net, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Same patch was already applied recently.

Thanks,

Alex

On Mon, Mar 22, 2021 at 9:19 PM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> ../hw_ddc.h, ../hw_gpio.h and ../hw_hpd.h have been included
> at line 32, so remove them.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  .../gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c    | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c b/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
> index 66e4841f41e4..ca335ea60412 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/dce110/hw_factory_dce110.c
> @@ -48,10 +48,6 @@
>  #define REGI(reg_name, block, id)\
>         mm ## block ## id ## _ ## reg_name
>
> -#include "../hw_gpio.h"
> -#include "../hw_ddc.h"
> -#include "../hw_hpd.h"
> -
>  #include "reg_helper.h"
>  #include "../hpd_regs.h"
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
