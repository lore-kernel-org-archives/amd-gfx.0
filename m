Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387F6C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 17:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED79C6135D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 17:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED79C6135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C886EA90;
	Wed, 29 Sep 2021 17:46:45 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 986826EA90
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 17:46:43 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id 24so3966327oix.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4nJQFt/S2H5D0H7H9+y7Wu6Nj6VrA0d4FaVAfEhU+eY=;
 b=ob+WZ28bxkbLYx3yR9KFE0knODgkc5lKcP90ybxvhvOmZMtSyNmJd4izLb1USTaDNm
 dISAwlvD6vTB6GzCm+A+hjdV5cFomZZRytRu010amliLHP+VA98yWUUzmBCzUrPC5Cqb
 caqaO16aV8TT76dtTkWeSHXHArjD6ortkpnKj5Wm5+lNwiwhK9ThjRlpth6aRCaDitJ+
 VBb+NdOuCiBr3cDFKKUo1fXxsyOiey4pGPKmozu1uZHsU8BU745cJxKoDdivDDWXor5P
 8TqRygZj2qmxqzQeQUqonndFEtlJF5pJCYR+Hqp0DioaOgMw6EvTe6KLqcGIUPEIK5m+
 gJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4nJQFt/S2H5D0H7H9+y7Wu6Nj6VrA0d4FaVAfEhU+eY=;
 b=ElH6sHLuS978QC/m57T1ZSKj1iYGlUYZv2cdOL/nzvE9M2jbYPJQMMXzJwwdtuQ1qU
 XWjyDVduY5GeUrHNRNqshoDUdammzdR58vi18NH6RbDzuShDodCffCp6c5KPGrH7gt11
 f5LHnk6VDgCxl6aQbprYhx2Wy2hV5+NYfh3HbKmw3Pek1qZEIMqnTL3CJLGI+MqXdBGh
 b3f5wG5eQx5IesxC/kql8TtN6ilyTarrQrXrp8QKsIpyYHpLNLdiyczNwscngN9rey3z
 4PTG/bDN6j7z3WvHf5movTel0T0yN9rzH08y/APxEsFGWpAY8gx9aUM0RLlO6MIGQLUC
 WutA==
X-Gm-Message-State: AOAM531PZ9w0DixyZ5jePEFbBvREnmb2AsJemc9pZLi0B5BPRITnNpkU
 2GGg0xoM5BwJyxnguD4x3xuosNakg2B3mTB1lOW2xQ2K
X-Google-Smtp-Source: ABdhPJyv5DdJPNJXoSVIUpygjRNoQGVWW0+TvC5d6wkgSnj3ytp1uR7G4kg1km3rdcoyQRMvqeAOp1tyqsiIiFjym7U=
X-Received: by 2002:aca:706:: with SMTP id 6mr8732448oih.5.1632937602914; Wed,
 29 Sep 2021 10:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210927190746.675991-1-alexander.deucher@amd.com>
In-Reply-To: <20210927190746.675991-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Sep 2021 13:46:31 -0400
Message-ID: <CADnq5_MiXM3LGLi=427Wi7DUm4UwtNp7hBBA9Z6ri20KHXCw3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: remove unused variable
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

On Mon, Sep 27, 2021 at 3:08 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> No longer used, drop it.
>
> Fixes: 1e07005161fc ("drm/amd/display: add function to convert hw to dpcd lane settings")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 029cc78bc9e9..5eb40dcff315 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -520,7 +520,6 @@ static void dpcd_set_lt_pattern_and_lane_settings(
>
>         uint8_t dpcd_lt_buffer[5] = {0};
>         union dpcd_training_pattern dpcd_pattern = { {0} };
> -       uint32_t lane;
>         uint32_t size_in_bytes;
>         bool edp_workaround = false; /* TODO link_prop.INTERNAL */
>         dpcd_base_lt_offset = DP_TRAINING_PATTERN_SET;
> @@ -1020,7 +1019,6 @@ enum dc_status dpcd_set_lane_settings(
>         uint32_t offset)
>  {
>         union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = {{{0}}};
> -       uint32_t lane;
>         unsigned int lane0_set_address;
>         enum dc_status status;
>
> --
> 2.31.1
>
