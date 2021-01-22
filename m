Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1231BC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 23:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B0D23B51
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 23:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B0D23B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2C86EA6D;
	Fri, 22 Jan 2021 23:12:55 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063166EA6D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 23:12:53 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id j8so1821568oon.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 15:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Os8k03BqbtSOL3+fuAtyokdDSmCdkOBvDHH+wPmtqa8=;
 b=VUVhWJjnutD/X0Gv3gTC/depzXb1lkOvR0EjD/4d4/hML0wkqZg9FDvU8v1+aKp2Ck
 gizd1l5hsGh6NXOuXbTW7mrENAFB0FBpQX5YPT5oQSdgkBBR7KCCHSROvWIO+1+gRYjr
 6JjRsQMrR8/wy6h2tQZr1P2XW2n/pc1FYsAjVyi5rGvjHby+sIDIia1BK2xMgGGRzOLu
 9504+5hIOZClxCQ5kSk0gZBrGV8g95aSbFMxsrafavmOis8R0qgWu4Mlbp4TCgpWSljZ
 qrkGoQnzHRur6VZjn3Y4f06sEuOxA0AHCy3tcW77VLNAXolroQZE7soXU3xyay1tFyu7
 5fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Os8k03BqbtSOL3+fuAtyokdDSmCdkOBvDHH+wPmtqa8=;
 b=Pq5tIh122icBX6NolFIiaTAxCRYCjxRGb1Lmdqzsh00Hxq0Y88ZPFV+cNILWas3hFJ
 x0uXeeoQUG8nCP/SGtbsy+AZPqVCglFxwC63oKeBRSv3QfE3H7CE/2vIR7qj2SfmkKrB
 Ht5upd3xJib7cj/ttdPvycCuZoDDt+fPcP+BqAJoj8yNtJNLkBbkTVqZi2L0UNEUTRnh
 O7x1NBO0M4Q+0hVQ0lDEu7mhgA0eJtgRuVMH2wcfD+f/EIcqT2eZiH0dtWZgwBCyvqV0
 1pFlvGBpRDeuCAzRmrb3gbV2T4hPIXr2nP/UBnV3W/TAzgy75cqjHDdtUnffAKtB7ZcX
 joWw==
X-Gm-Message-State: AOAM531e0UCGlPfTrylaVK9ysY2jw7tvafPT0UnIwN7ZWGTCfHRda2oE
 06UzhkcwNE0drj01g2IfdlFb/g79PKUPYmGzOkQ=
X-Google-Smtp-Source: ABdhPJz0JhQkXjD2pwtlsLPpSoy+ATIhEzILngEMYGM4zf0Dzu5moB8HbxAn1STWD9DZm2dE7efa+6Tg6aWX7fArvL4=
X-Received: by 2002:a4a:bc8d:: with SMTP id m13mr5395753oop.72.1611357173349; 
 Fri, 22 Jan 2021 15:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20210121084131.866028-1-evan.quan@amd.com>
In-Reply-To: <20210121084131.866028-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Jan 2021 18:12:41 -0500
Message-ID: <CADnq5_NAi6C4Kxo7pvRPupppFLYpdas0Pjch+o_d6EN26QMN=A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: correct string parsing for extra separator
 characters case
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 21, 2021 at 3:41 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Supplement of previous fix "2d873f24dfaf drm/amdgpu/pm: Account for extra
> separator characters in sysfs interface".
>
> Change-Id: Ie9e9a78ad8530ba4b46ea27e28559d5dcda5c033
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index ba1539f6e0ce..ac150e63dd25 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1866,6 +1866,8 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>                 memcpy(buf_cpy, buf, count-i);
>                 tmp_str = buf_cpy;
>                 while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
> +                       if (strlen(sub_str) == 0)
> +                               continue;
>                         ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
>                         if (ret)
>                                 return -EINVAL;
> --
> 2.29.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
