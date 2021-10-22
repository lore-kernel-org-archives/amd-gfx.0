Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F36BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 03:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A735A619E4
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 03:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A735A619E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AB06E580;
	Fri, 22 Oct 2021 03:19:36 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDED66E580
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 03:19:34 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id n63so3405065oif.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 20:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A3OeesecSPS5jPn+mzQ+RE1Slmw1wYD2rq/HDK4nRs4=;
 b=cjIGa8mwHvZjSB1Iuq+ACObDRgIcKMeJrzFIaw9clQ6vOxpdxEAlR4g9TwsrBQMA2a
 plLH2BOOnBJoZbf0/tSZNxh303tZPtPgV3x5pD+LJmlv/cVo8I2GmfIZJhiVdJaWwF/x
 RkpGnwpOyxFviNKCNXdNbHysltk1mmUX/zW85TwkbbwpAeuYeHRoCY5h41+PNzuzAGHy
 vZOtJyxsqf0FbIfy6afimG42i6ZHpcTzgU/mOxz0Nfl1JeCYoYH1LUNsJBNLG12Lyzq6
 cyRn0qRb0lf4Pta1wVNRsKB50LVjG21ZPh9ELsQcGK3Tl5f0uHafTiEY1NkY9c80GI5X
 1l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A3OeesecSPS5jPn+mzQ+RE1Slmw1wYD2rq/HDK4nRs4=;
 b=snLaxYFrLoMGJCfBD0dqzABLAoy+qgEiEWifXBVLKn2SXp/1U9Z0fC2eyeVCaLSp7r
 02mv2yOs6v3HYBCJbRQ0PW1sIQd3yZ7s1BvskIImlZcAsE+DZC3Y/3Jp4xB559iJ79w5
 uiwhiPwNPBEVQGWJUZ0szSsrYvucwCVBiZyz9Sa45NNsT+QMlq8bETQrcQmEd28Iib4y
 tBQRhuyxtz3txlJqndnzKF1bZrdxsy1qwFMaYg2xdfGD08pe/JYWCM/A1nmsjUT+ntlV
 8BwrfoVFODe4FclZQy3bUp0TF0coEhqsSbrtLVO+DLhDc9D8lsy8z9Twcz2nYKTZiSvf
 fRvw==
X-Gm-Message-State: AOAM5307fTplVSeKg4t4qPrwfUSTcJ+j2Nt+sWgjcckGmeefx5RY3foz
 qfVeAoBK4O37OXWnCsbSBGPaviA9ld31h2TAnkw=
X-Google-Smtp-Source: ABdhPJy75NoyfE09ji7/uUO5pxNXcCMGZc9C7ETVnxibBLSNJVQOYWsZ3ogxwGH6YkSZ2IPCJix6urQusNHiSm9XeXw=
X-Received: by 2002:aca:d6d2:: with SMTP id n201mr7205509oig.120.1634872774086; 
 Thu, 21 Oct 2021 20:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211019153051.306142-1-alexander.deucher@amd.com>
In-Reply-To: <20211019153051.306142-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Oct 2021 23:19:23 -0400
Message-ID: <CADnq5_Mpd3fnMx+vgNdgqrinB1dJPSE7mRnKitTh_ebcbBEdUg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/smu11.0: add missing IP version check
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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

Ping?

On Tue, Oct 19, 2021 at 11:31 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Add missing check in smu_v11_0_init_display_count(),
>
> Fixes: af3b89d3a639d5 ("drm/amdgpu/smu11.0: convert to IP version checking")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 5c1703cc25fd..28b7c0562b99 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -755,6 +755,7 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
>          */
>         if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 11) ||
>             adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 5, 0) ||
> +           adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 12) ||
>             adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 13))
>                 return 0;
>
> --
> 2.31.1
>
