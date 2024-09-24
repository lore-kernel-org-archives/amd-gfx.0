Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D140FCF9C71
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 06:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2B010E4D3;
	Tue, 24 Sep 2024 06:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EcBA7Qss";
	dkim-atps=neutral
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com
 [209.85.219.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCC510E4D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 06:16:16 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id
 3f1490d57ef6-e1a7e54b898so4154045276.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Sep 2024 23:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727158575; x=1727763375; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcweUFHFW/KJCW3gKD065UQS3lsmUsHAhy70Femt8O8=;
 b=EcBA7QssVrFlbR9tpASLkuzIepXvpQZS2alGs7SFqmlcArsJJikVY3lrbSS1q/q0gB
 6XEILUNzcnwqNqi0UF/KtOkZ4g1q2emm8wkVyeNCAxj9DgHAJ5iOAwHLWbDBWcg1/AAp
 6VBK8wRQ757nXCeZr4sko/lqd7583byAGZXl0DdFtetk3ip2MY/F+Ey9SwGnIs3hNFwp
 noD0uipef5FC5y+ohNy4fEo2Vi8ecefawPE0Y0Y8O9+MGcPHv7LfWtfpXkzoniihkC7+
 YgPUQRHTHqG7PRjvtUoSZlG0yqbBRERFvzop8qVxagrdqE5M/pz/Vw+gMmXEW7Jy5Iuv
 MjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727158575; x=1727763375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZcweUFHFW/KJCW3gKD065UQS3lsmUsHAhy70Femt8O8=;
 b=gUGtK1JpXBmT6N4o2k9rohfz1CE45meUDUSYU4oilzzrXKyt8abOv5Sa2b258k5zE8
 EieL/Fiz/pZ03tFguZvrCD2nqAvFKS+V1mVATXEJVvgVfYKlgDQ1rqrAdWa6tiLoIeEd
 b2A/tVhICiEIUBm+oS4QcuNImA0P9UOWMPd9rsZERQvsO+tIaO1pwmlS5XcWK5vxSFeo
 8NphG0uYO+Nd7aO1U7i+V/YhGSQIKPKXVKVzPLyY4diwxBd6mK0qjF1cgZd8FlUGKQOv
 X4hj/YOzj0E9rb6910qpXc2Xc+nkY9VkAYpjn6EQMve6hxBzgQIuD5pJK2XRAI59Y3U4
 cTaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdlGDCpGumVTIF6vHGhRDa2L8kL52JpY7cGzRmiwLgdnEB56A+wc+VW4j3aHjeM9KPgXMqaw6t@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynSakI4qlFhnXkVoOHpTYR+KvZzp7fLZf7ssuriZ/dM3XRObT6
 8JzzrSO10cIQO7Rr4IGi8MZyxqoT8iQvGYXlMfjFNwRbxSWmE73j4kzBP4jAV70aymfo9RgTOW/
 9+BRM9C8C+zYklV60sc26oQ9nQDm+ZfhpdxNX9w==
X-Google-Smtp-Source: AGHT+IEF5j0JkBVAgP1jTlkYufGIlKJxFTmmd49IaW+yK41rQF/NpMRTMvOPM1xHJnDTOa2dEHhH9wuEn2USXNPEeWM=
X-Received: by 2002:a05:690c:89:b0:6b1:4948:f689 with SMTP id
 00721157ae682-6dff290379dmr105980107b3.34.1727158574971; Mon, 23 Sep 2024
 23:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240924022600.1441969-1-vignesh.raman@collabora.com>
In-Reply-To: <20240924022600.1441969-1-vignesh.raman@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 24 Sep 2024 08:16:04 +0200
Message-ID: <CAA8EJprUUUc0iDph-HPrW1anrdnzYju7+JERQdHbwxvznq=H4w@mail.gmail.com>
Subject: Re: [PATCH v1] docs/gpu: ci: update flake tests requirements
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
 robdclark@gmail.com, guilherme.gallo@collabora.com, 
 sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
 mripard@kernel.org, rodrigo.vivi@intel.com, 
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Tue, 24 Sept 2024 at 04:26, Vignesh Raman
<vignesh.raman@collabora.com> wrote:
>
> Update the documentation to require linking to a relevant GitLab
> issue for each new flake entry instead of an email report. Added
> specific GitLab issue URLs for i915, xe and other drivers.
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  Documentation/gpu/automated_testing.rst | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/gpu/automated_testing.rst b/Documentation/gpu/automated_testing.rst
> index 2d5a28866afe..f73b8939dc3a 100644
> --- a/Documentation/gpu/automated_testing.rst
> +++ b/Documentation/gpu/automated_testing.rst
> @@ -67,20 +67,25 @@ Lists the tests that for a given driver on a specific hardware revision are
>  known to behave unreliably. These tests won't cause a job to fail regardless of
>  the result. They will still be run.
>
> -Each new flake entry must be associated with a link to the email reporting the
> -bug to the author of the affected driver, the board name or Device Tree name of
> -the board, the first kernel version affected, the IGT version used for tests,
> -and an approximation of the failure rate.
> +Each new flake entry must include a link to the relevant GitLab issue, the board
> +name or Device Tree name, the first kernel version affected, the IGT version used
> +for tests and an approximation of the failure rate.
>
>  They should be provided under the following format::
>
> -  # Bug Report: $LORE_OR_PATCHWORK_URL
> +  # Bug Report: $GITLAB_ISSUE
>    # Board Name: broken-board.dtb
>    # Linux Version: 6.6-rc1
>    # IGT Version: 1.28-gd2af13d9f
>    # Failure Rate: 100
>    flaky-test
>
> +The GitLab issue must include the logs and the pipeline link. Use the appropriate
> +link below to create an issue.
> +https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/ for i915 drivers
> +https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/ for xe drivers

drm/msm for msm driver, please. Otherwise we can easily miss such issues.

> +https://gitlab.freedesktop.org/drm/misc/kernel/-/issues for other drivers
> +
>  drivers/gpu/drm/ci/${DRIVER_NAME}-${HW_REVISION}-skips.txt
>  -----------------------------------------------------------
>
> --
> 2.43.0
>


-- 
With best wishes
Dmitry
