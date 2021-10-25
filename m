Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD50C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 16:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC5560EDF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 16:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EC5560EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19266E15D;
	Mon, 25 Oct 2021 16:15:39 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 333FD6E15D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 16:15:39 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 l10-20020a056830154a00b00552b74d629aso15664287otp.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WcEqmjTq6sUFbsspuARmKSbYNmD9qlEzKlyYw0EYB2E=;
 b=A+ZfiUunuVYM0Ix+01Yn7SWaGeqwMmFfZXuXbl0Sz5K8A+nM3tLcZDiL0m+AwRxd00
 hYyu72SJvYDQQlz/TsJZoApCVM72+qeSSYWGF54TkPT5E2Iu9up0tS45PD8aCtk3J7SO
 /YtTdjgPyN71EgBgH+mQwaE1B/TGTxpZr5y7pVBuqyeE9v9TTP+tAV+T+NOwALKVxnNI
 W0DOiydPev+9m2gVoBzbyx1QddV3w9es4p7/H5LQ/qVrfbHlUIRSNBlV/szN0WOYx4Dd
 Wx0JxdFmYxUNjHKhYn7birnumBtB1CG0viNg5UIGZjPkgUSfTWrr1ZB1QaBtxSt4Qnrt
 Cggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WcEqmjTq6sUFbsspuARmKSbYNmD9qlEzKlyYw0EYB2E=;
 b=yCyCDajZ4ktyiWF/c43cokB3PWbNZ5OGWqt1AZJhejTfGsti6UlWEMJCuwPTenE/xJ
 HtDFRBAHzxh023R/fp8OmNl5GfPEXOtwor57LIlbcVP8W9Fh4+AWYSue5EnHD/Yq1KxT
 jZCfCWgSJ7LoP9PRPLu8kmsXF8bFLTitSfd9np7GIUspWccmHawB7/ch4MMwHfEqclnM
 90WGUT+w7qXxt4yiaEfJiF/LfOyqYHrPuskZOfQ9nK/S+ILQWfkgjC5dAcLSf7AxiUnI
 M9EKF1gS2z97xUfj9T8YNAYis2YPt5RVtfbPk19tpmmi7WKDs4ekObn0luWqg5mQXukV
 FSoQ==
X-Gm-Message-State: AOAM530VkhwFTqVLrC3FizNGnD21ov1a0dbntdgG4yOb2H45kDOG1pwO
 b+g4FZgcJLf+WLpprUl+F576Io0RPgXjmhiyqIAgrhWMhv4=
X-Google-Smtp-Source: ABdhPJx+FH/hSFAMnRxDBJzBsgZjf+A2mrqBWiCemN7cwN06VdECiCZyKumC4R6ubW9dc82A/3xoxdtqJLsQJIwyLZA=
X-Received: by 2002:a9d:1b4f:: with SMTP id l73mr14748087otl.200.1635178538366; 
 Mon, 25 Oct 2021 09:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211025160220.51401-1-luben.tuikov@amd.com>
In-Reply-To: <20211025160220.51401-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Oct 2021 12:15:27 -0400
Message-ID: <CADnq5_Nm5yDwFrAYPUohASVR+US4wgwZ1KwuCtU33waLMJU8ug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Restore information reporting in RAS
To: Luben Tuikov <luben.tuikov@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Kent Russell <kent.russell@amd.com>, 
 Alex Deucher <Alexander.Deucher@amd.com>
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

On Mon, Oct 25, 2021 at 12:02 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> A recent patch took away the reporting of number of RAS records and
> the threshold due to the way it was edited/spliced on top of the code.
> This patch restores this reporting.
>
> Cc: Kent Russell <kent.russell@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Fixes: 07df2fb092d09e ("drm/amdgpu: Add kernel parameter support for ignoring bad page threshold")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index ae64ca02ccc4f8..05117eda105b55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1112,7 +1112,10 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>                                 res = 0;
>                         } else {
>                                 *exceed_err_limit = true;
> -                               dev_err(adev->dev, "GPU will not be initialized. Replace this GPU or increase the threshold.");
> +                               dev_err(adev->dev,
> +                                       "RAS records:%d exceed threshold:%d, "
> +                                       "GPU will not be initialized. Replace this GPU or increase the threshold",
> +                                       control->ras_num_recs, ras->bad_page_cnt_threshold);
>                         }
>                 }
>         } else {
>
> base-commit: b60bccb408c831c685b2a257eff575bcda2cbe9d
> --
> 2.33.1.558.g2bd2f258f4
>
