Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F73C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 16:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A72361108
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 16:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A72361108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739D76EE55;
	Fri, 17 Sep 2021 16:22:34 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1941D6E02B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 16:22:33 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 67-20020a9d0449000000b00546e5a8062aso1473253otc.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 09:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d6UdQGKX2roiV1JMYHMnVyevfGMqOqtCIBxz/mzHdCw=;
 b=bzpCRhCLF+BXjoUlT1W9P7aOBoYu91Yt8j7VdR7GftEpGolTvdc5XMkePMX4tWfWEz
 HY4ZTC1xSbOzyNSoi+7T6gW+CBNQ0fRwjBuGq9mpOd7L09gywSxkT9byOo0qJ9bRm019
 D3RRsBDTutOnv+OXh1MHDkwXLiLzTxKwZ9/C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d6UdQGKX2roiV1JMYHMnVyevfGMqOqtCIBxz/mzHdCw=;
 b=F/yY6QEQ0LBFmIyeF7nSKymUpB3eeq5FzbgOl0AIfcbfrOmp4cPMNzINs39XfI1Lq3
 hMbJDdiniJVPkgTLxfor+DnYwcfVXl5VdGsTI3R/qNvJsh44eqfo/iF4S0aaJRl1luR4
 oKDk2Tt6Ekmpg0gB1DPn4tZMtCt/6glHyTsfjRBAIZFZrxXjwjszlefSju2/wqchca5Q
 TlpeG0TNRT3VAWqCGkY/IxGTYclwLatanCQNLsD9axFUdiDf65HftBRduodsYxIgNWoU
 EaVWW4akY2t57cJQwaFKfI9/O/ifOUmkswLQ329bsYceXv8WZwZQJv1lmhpGYisIUa2I
 5h4Q==
X-Gm-Message-State: AOAM533rxHIUN2ll3l9ZdinDMFUii45G8bGQM1ecPf6lzxWs6tkKtZmK
 A95hZb4GEaGYvsaKJOxSSQ2oxLIlDUpTV/F+Iy4GLQ==
X-Google-Smtp-Source: ABdhPJzNn7/XgFdOwYTGvNp8CKSb7L3KqMjJ8mZACL8n6QprxtGLoZqwzXFKTqxdR4iycYxcqq7JfcPJp9tWfFFqbuE=
X-Received: by 2002:a9d:724a:: with SMTP id a10mr10089647otk.323.1631895752168; 
 Fri, 17 Sep 2021 09:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210917161540.822282-1-alexander.deucher@amd.com>
 <20210917161540.822282-2-alexander.deucher@amd.com>
In-Reply-To: <20210917161540.822282-2-alexander.deucher@amd.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 17 Sep 2021 18:22:20 +0200
Message-ID: <CAKMK7uGL01nrMBaRs6P_FKREDj6B7vxa4hqnWrW6oSYcj5g_6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: add Andrey as the DRM GPU scheduler
 maintainer
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, 
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>
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

On Fri, Sep 17, 2021 at 6:15 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Now that the scheduler is being used by more and more
> drivers, we need someone to maintain it.  Andrey has
> stepped up to maintain the scheduler.
>
> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Cc: airlied@gmail.com
> Cc: daniel.vetter@ffwll.ch
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 379092f34fff..9d567e66a65f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6369,6 +6369,14 @@ T:       git git://anongit.freedesktop.org/drm/drm-misc
>  F:     drivers/gpu/drm/ttm/
>  F:     include/drm/ttm/
>
> +DRM GPU SCHEDULER
> +M:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> +L:     dri-devel@lists.freedesktop.org
> +S:     Maintained
> +T:     git git://anongit.freedesktop.org/drm/drm-misc
> +F:     drivers/gpu/drm/scheduler/
> +F:     include/drm/gpu_scheduler.h

Ack: me
-Daniel

> +
>  DSBR100 USB FM RADIO DRIVER
>  M:     Alexey Klimov <klimov.linux@gmail.com>
>  L:     linux-media@vger.kernel.org
> --
> 2.31.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
