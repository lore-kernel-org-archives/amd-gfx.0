Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19315ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 15:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B12510E023;
	Tue, 30 Aug 2022 15:31:09 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FE310E140
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 15:31:02 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-11e7e0a63e2so16689720fac.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=L3JfqPlWoXQXnoZCxJi9a2glYoEy4hDoDn0XI1feFZo=;
 b=VUacOFIDOMUH5jD1VoLGGgV00v7TjqXumBQJYdjJa+tpCQgqkG0rkG1a7c+epa7kcn
 tf4k4MYABJXI9qejF9AbfgNIKaC2uASPUfkI1hdz4NzcC1RqLAG5u3YGfI0K7EGraIz2
 IhmBtLIH8W9ovfKZCFgvUrDTM4/Do2sZGgVZgvNhwD/s5SxPGIx/kguoKD09QOGOb795
 us3J6aOd7ujbr6pRKi4RCD9Z/T2KB6/oEQYUvTpwkQeYHOYDgsB8xMGOnJrqMWGjBJ6g
 F3u8YCA9Yhq+5hEUW7WCenZqY/PP9wyYmVlUQ+i4M+cJMKIIydC2vmQ42LxJbLYO39e5
 RJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=L3JfqPlWoXQXnoZCxJi9a2glYoEy4hDoDn0XI1feFZo=;
 b=ggIovKphY63OqSkx8GeNXn2ZMlEmBtPheiBRQC8Qoex2JYiu0zxlTyINucL/RcdCj4
 aCn7XB5u3NCMUJsGOV4w7eNZ/Eh5y6u0wvcaH/HX6O+j5Gn1bbHZH4qNQfyi/oMPaIip
 i0Zoxw34TkmIHiPCGkPjJ6X2BVJm5BDKOyAP5ttSv3z9l2jICDMmHMB1OIDZytzmw4OC
 LBPEXRVjviUc2w/HVw55TCFvmftGhn/giSpAsc8lIG3ZTo0c68RHNhWyWWE5PINK2h7f
 b/lO3N4adeLYAYT8s7ILsUzByKSfWSi5x+EO4epqv93Qf9hd/vex4HgK6qr57AQpXr1x
 Mqpw==
X-Gm-Message-State: ACgBeo1LQiyDEaJFOw9jdtrlNHU8Fir/BG5ishm35BSAsx1hWcQS5yyj
 XhFrrcQsRMSAq4tT5ySv+LbSatnkw5G8bPA28ww=
X-Google-Smtp-Source: AA6agR78WXrkFoaGFD0/WqxB9M3vrF2ur7KwhtgGwYrR0BY3qoSpdJs0SAJaiccLGSQFcvpEiGqMbT/r9Hl609lN/h8=
X-Received: by 2002:a05:6808:2187:b0:344:eccd:3fc5 with SMTP id
 be7-20020a056808218700b00344eccd3fc5mr10186465oib.46.1661873461996; Tue, 30
 Aug 2022 08:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220830152335.3539841-1-yifan1.zhang@amd.com>
In-Reply-To: <20220830152335.3539841-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Aug 2022 11:30:50 -0400
Message-ID: <CADnq5_M_0T7wbJkOUtisK1QChQmRnW8QXLqfO400yD2kTyOGgQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: zero the sdma_hqd_mask of 2nd SDMA engine
 for SDMA 6.0.1
To: Yifan Zhang <yifan1.zhang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Jack.Xiao@amd.com,
 Xiaojian.Du@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 30, 2022 at 11:24 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> there is only one SDMA engine in SDMA 6.0.1, the sdma_hqd_mask has to be
> zeroed for the 2nd engine, otherwise MES scheduler will consider 2nd
> engine exists and map/unmap SDMA queues to the non-existent engine.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index fe82b8b19a4e..f876fd62ab81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -185,6 +185,14 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                         adev->mes.sdma_hqd_mask[i] = 0xfc;
>         }
>
> +       /* there is only one SDMA engine in SDMA 6.0.1, the sdma_hqd_mask
> +        * has to be zeroed for the 2nd engine, otherwise MES scheduler will
> +        * consider 2nd engine exists and map/unmap SDMA queues to the non-existent
> +        * engine.
> +        */
> +       if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(6, 0, 1))

How about checking for the number of instances rather than a specific
IP version?
E.g.,
if (adev->sdma.num_instances == 1)

This makes things more future proof for newer SDMA 6.x IPs.

Alex

> +               adev->mes.sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES - 1] = 0;
> +
>         r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs);
>         if (r) {
>                 dev_err(adev->dev,
> --
> 2.37.1
>
