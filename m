Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830C8C433E7
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 15:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18EC722261
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 15:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qo2N+pvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EC722261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2B376ECFB;
	Fri,  9 Oct 2020 15:46:30 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF9E6ECFB
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 15:46:29 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e2so10304959wme.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Oct 2020 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=++4W0UQ1Ro/3isAPuU5SCGB6rNuPtRoosOIgwmP9hb0=;
 b=qo2N+pvrr4aT5DTyJzXPcxoauX2fYaVC1JVVcofFORErt4Uea9bn6/w7PqZuYndnH7
 DcsXjpVr6UU2dwOaiEG66o1Add9QRHxfFt+jQMoftQsSblSRwFNy0dXrKKDUCNyTKr1H
 Ye6BXJuyialcExUgSsmBYnw/Nt3E+pzPyqTvbhFKTSbcqb8+6K73edAE3lOCbpeTF2Ow
 gsFTjFyMzC60/a0TZDqNE6vz3j+bxgm06Hww35bHrI+4SuuJk0lLfZXzwzW4hLIBo4+Z
 4nnZbvYj1Ia9hN720q+/pAjZ+R2o4d1UcuEt9+Vv2anQfgVA6i7RZeQmnfWPgFw7NVyJ
 NzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=++4W0UQ1Ro/3isAPuU5SCGB6rNuPtRoosOIgwmP9hb0=;
 b=q9ejR8AYTUbg5/j1GiAAeL8gnZff5fWhsxIDlkrQHUtzL9k5Fh4jCZDVbW7LE/zmt1
 8ISkiodapwG/DYHLMEvK1FBEgNgGaO+w0rG/AXLuDbMU5G56IvvariZ8CU0389besB10
 9c7DyZ0+ETih9Iz9U2kRQKjvj3t7vQuHroHHo1vSWkJlnJvGX9c2ioS33lGY8FwJ5Xmr
 h9rhiP9x9U+xAG14RYzP7+nVDDdDPEo4XW2tAIVEyAzPRvoNzAPt3st1xB+WzA4IuyGG
 3hKA7DZ5fAirZHhvD35H6DDjFPtqEsCyQZ82EU4g6/LZZXEEvjWML8d6do9u45I9jYRI
 wIRg==
X-Gm-Message-State: AOAM531A9LJv50RK5Q5tyiKM2P4u7Cn5h5yI/NLVItgbO2a/UcefDswU
 JjLyZuEqGhckcFZ1tnV8SzCe8VlTgnTwp6aBCPo=
X-Google-Smtp-Source: ABdhPJzxOc2TP11VK6UMPt7QvZDSZP+DjklXL5xEgNcma3xdWnXaUJP1haLYMMDicEo6IOAfAhoGzVUJ6WKsF8te52A=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr10591649wmk.73.1602258388544; 
 Fri, 09 Oct 2020 08:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201009074758.74370-1-yebin10@huawei.com>
In-Reply-To: <20201009074758.74370-1-yebin10@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Oct 2020 11:46:17 -0400
Message-ID: <CADnq5_P37pV3np43WSn2cYhYLhFCpnsAoqsBOjqD0+9QNF=FBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix inconsistent of format with argument type
 in amdgpu_xgmi.c
To: Ye Bin <yebin10@huawei.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Fri, Oct 9, 2020 at 8:51 AM Ye Bin <yebin10@huawei.com> wrote:
>
> Fix follow warning:
> [drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:249]: (warning) %d in format
> string (no. 1) requires 'int' but the argument type is 'unsigned int'.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 1162913c8bf4..54c358e71f9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -246,7 +246,7 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
>
>         adev->df.funcs->set_fica(adev, ficaa_pie_status_in, 0, 0);
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", error_count);
> +       return snprintf(buf, PAGE_SIZE, "%u\n", error_count);
>  }
>
>
> --
> 2.16.2.dirty
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
