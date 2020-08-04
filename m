Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79821C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F7920842
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIOl0w4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F7920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF4C6E4B6;
	Tue,  4 Aug 2020 20:46:41 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A456E16B;
 Tue,  4 Aug 2020 20:46:39 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r4so35669169wrx.9;
 Tue, 04 Aug 2020 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hmLYwEdYmReif4AtTx6zmAM3miB1yj7XFy+BqIPWbw4=;
 b=KIOl0w4FwboDnjvjlkqqDu1OxofAxj/P73GbkdF6hsdLTq6DT2SsS3LmeyPcIBTH4P
 a85SOTO5omchO0S+jZnLgzVZqagTfWXAhVLEFkamDKJ5hJ6vpPgYHLqK6oWBz8EJT99g
 qBtxhf4VmhsjgiSApBiatweeiwuYPMEfsoi8vesL4CN6e3l8QLzsxfzObitW/1yjOYkw
 e3/mST69yrjb0xbS4p3bQFUTLobAhgj/ByjPFZTP+/5yLkjfXjHgwQ+vzEbES/EYq9Pi
 vk6fshP2rBNSwtpzD8qf97jA6raVzDEK3D2nMYXqxbq1MvJyEndZAH5f7QOeZiWK+aGn
 tkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hmLYwEdYmReif4AtTx6zmAM3miB1yj7XFy+BqIPWbw4=;
 b=ukOIMPgX6YQi5nQtEKD5k65e3G+kfwQCxSlAeCau8xNSkSKGcLZPNykhgusKlJBejt
 95w025lkCnd4gX+m5QPsl6BRP/0k2KruUgY0fgNLSLbCEaghDAE9+wOV2WGbdbIoHBdF
 Tr8hSPccNZPk5ixKJsADjB3y+wiHHR9ESdmDH8Efhqu++q6jkhG+GpqGpb8bWUuMGJZB
 2ffJI+YjmTt65giiNCPW8gkoIXKgE3bdi6ItG60AYbh/2KfLMdrVyLPMbUxj3VNiExS4
 sRAUQAJWFJgyq15R3TPyVImV+AVUXjCR3BDD+x4lD9yK8XXsuT5zRLJdVaoyxd1ntyGr
 +rSQ==
X-Gm-Message-State: AOAM532GOSblNYvG56dEBIv1ti8Ggsbw6Hpw570pw17YZAgOLXtZBuhf
 wUuYtlcMqzELskHYV3cAkZ8ekZFqzOMZFXF2is8=
X-Google-Smtp-Source: ABdhPJzJkwBm0KFsobN5hiTTc96hoQzGbYvZRBWimBwQZafGM9AQIiNnCGIfLHhFbLoTlubG3YteOYX+yBrSy/Cdia8=
X-Received: by 2002:adf:a351:: with SMTP id d17mr20682645wrb.111.1596573998509; 
 Tue, 04 Aug 2020 13:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2020 16:46:27 -0400
Message-ID: <CADnq5_Na7hB-AQ9WqEhop=GLMb=q8jZuVjUKBDhu9Xs+kNtZTw@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd/display: Constify static resource_funcs
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied the series.  Thanks!

Alex

On Tue, Aug 4, 2020 at 4:08 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Constify a couple of instances of resource_funcs that are never
> modified to allow the compiler to put it in read-only memory.
>
> The other drivers in drivers/gpu/drm/amd/display/dc already have
> these as const.
>
> Rikard Falkeborn (3):
>   drm/amd/display: Constify dcn20_res_pool_funcs
>   drm/amd/display: Constify dcn21_res_pool_funcs
>   drm/amd/display: Constify dcn30_res_pool_funcs
>
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
