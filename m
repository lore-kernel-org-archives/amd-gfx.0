Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA97FC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E72420814
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNM20u4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E72420814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 670DA6E0A0;
	Thu, 28 May 2020 14:08:36 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D1E66E0A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:08:35 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id l11so28114121wru.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vy2EoBVW8HywCRRWYheQSvqd4s+qXJOJxWG239SlmIc=;
 b=FNM20u4Iftoa+6jWHKFZtGzzLR7ydfZ4WGXGHK6lSA9I7f2UbAQ7DnJ6ii89o8TXaz
 eBWUgdumBZpadNaNrCn+wonELE4B63JVLuUoht1YOg23Lfo+3BBwc/5mz+Cqy3RbIVC0
 Ja4fcR8lXAGpRH2CK8vXW9SeYEwiewsqUtLczfgAgw8jpWo9/V5lYaBtLnnyKSt4c61l
 XydlYx4/GrbwJfbExFuUvd8NWeb4QQUttRuBTsbZUEqBhX9KBDZg+NQOWunAXP4Hu6Eg
 gUa2K/MK+a+6tX4HNAUBynwVx0CHream63RXiQyx7KSRpL1t1URQMDnhElsrfQYBn1/n
 bYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vy2EoBVW8HywCRRWYheQSvqd4s+qXJOJxWG239SlmIc=;
 b=K+ucs3lWJ0hNAwYSgDcWCKFSYjaWpLxquS8tVvKcOSD/J8Be/IEr2Ga3BnkfC3DE1C
 CcdJKvRmEMx1Y/Pq18ivS+6b84sheEHzc2xNVm0MofKz8gWtlxiqvyRRYQEdNS/isW5L
 sGpq4qQhBt6QLnFWk3L4B1+N+sOBRtNR/O0ufniyAUytp60lriJEu0MuSToxJyJpvCtI
 cz6IhUc9/djLs2PSY1gYMbLNJNoxTRjj8pUz5WT2Ktz8EOpF8oyQh2eQJwWNkxQY8T2e
 itt+qYUvGVcAAGGxW8+NkvddSRLYLZ3+qZLhIupSt3ics2FYB8cJD319BrRBHYbwLfdv
 u6/Q==
X-Gm-Message-State: AOAM530s19p7wCL17/zAohJmXQhJYFmAw7wUe9Y0KtZ0ZckU2Sb5tr4V
 jPL/0GlD/wdwxy7SWyl9SrklSM3RGHy6CqqEYeFnNQ==
X-Google-Smtp-Source: ABdhPJyAJXrnhX1XlSX1sjgiDVh8N5U/g6xIhaGUV5yhiLcgPSIgjlZu2huenaFRo2rM/s1j3HiQ58kgHyvWUBuYSFo=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr3643762wrq.362.1590674913874; 
 Thu, 28 May 2020 07:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200528134807.5665-1-harry.wentland@amd.com>
In-Reply-To: <20200528134807.5665-1-harry.wentland@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2020 10:08:22 -0400
Message-ID: <CADnq5_MoT580EM=yO_Oib17Y0T9xghnnADmanRr7gnTsiY6OTg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: disable dcn20 abm feature for
 bring up"
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Alexander Monakov <amonakov@ispras.ru>,
 Hersen Wu <hersenxs.wu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Michael Chiu <Michael.Chiu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 28, 2020 at 9:47 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> This reverts commit 96cb7cf13d8530099c256c053648ad576588c387.
>
> This change was used for DCN2 bringup and is no longer desired.
> In fact it breaks backlight on DCN2 systems.
>
> Cc: Alexander Monakov <amonakov@ispras.ru>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: Michael Chiu <Michael.Chiu@amd.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ddc979e3eebe..acd4874e0743 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1356,7 +1356,7 @@ static int dm_late_init(void *handle)
>         unsigned int linear_lut[16];
>         int i;
>         struct dmcu *dmcu = NULL;
> -       bool ret = false;
> +       bool ret;
>
>         if (!adev->dm.fw_dmcu)
>                 return detect_mst_link_for_all_connectors(adev->ddev);
> @@ -1377,13 +1377,10 @@ static int dm_late_init(void *handle)
>          */
>         params.min_abm_backlight = 0x28F;
>
> -       /* todo will enable for navi10 */
> -       if (adev->asic_type <= CHIP_RAVEN) {
> -               ret = dmcu_load_iram(dmcu, params);
> +       ret = dmcu_load_iram(dmcu, params);
>
> -               if (!ret)
> -                       return -EINVAL;
> -       }
> +       if (!ret)
> +               return -EINVAL;
>
>         return detect_mst_link_for_all_connectors(adev->ddev);
>  }
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
