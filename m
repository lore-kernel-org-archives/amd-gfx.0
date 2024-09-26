Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2524CCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 07:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9F510EAAB;
	Thu, 26 Sep 2024 07:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cyaTfnQS";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8AA10EAAB
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 07:29:30 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5356ab89665so789402e87.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 00:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727335768; x=1727940568; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qDfxbQPwiokVDYdYi9MFG3A73Xy2Dn6HJeQAftMAmZo=;
 b=cyaTfnQSFf6ddmHIcL/dYLh9JLKQnNWcr3lcTgrjoEsSo2NpgyaAV0Egqq/bxM94pA
 IY0MoGYkxnWZctELdO8DbkbJF7dOtaKhdOe+IyRJbrdEjY8oG9aSsbvOTVB5+M8TVyeV
 eECK6/CkULRn3aMTp1rVzvQoLGkKds0YOu10lUGR60htY1c+WhFCavzpndE08uQvyIV4
 PBqMPDE+uvRz4wW0Nk1VpmckdzNt6sZsH/qWmyDhhdUsGvHihJPVZhS8duTH0h4FS4mP
 y+hySODT0SUvFX3qzcU3Z/6YtNgDBcOZi/eMIhoj1JcoypJGHCQUCHhHenRizuFpMhqK
 C7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727335768; x=1727940568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDfxbQPwiokVDYdYi9MFG3A73Xy2Dn6HJeQAftMAmZo=;
 b=eEDHo4+ZVJ85D2Oxo8mw4e1JvmGBBJ2bPegB5vfUrZSXL+uYHu2oBvGPB1E3HRvrkM
 mNW08Rk1+1XEZt8iJHmuN+YT8QXEYzOJEhMrCySGebBijfCdrfHNfzzK7G5xiqsGFK8E
 LNVhdEQTpWQPOZi2gPz0pNm1OaYQE/uiNnljVzbLK08k4wrZCJbXr6IY6zINeSKS7bLJ
 bTAt867gkl9Dy/cZgkD/rX3Htc1qB7ylazaxF+CFEGmqk+yRbOTMX8e7h706LKZYiWMi
 JRcfHUi3f98T8eWKXVpCbt19jRfLpGZmArymzPS1/n+cO3wCmU0x4XuW7+PGzWyJ+vGv
 xPGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3r3K1hzLue1KCiE4npiQX0b1BDjc5TfpLTR6uN8ucK6eYFlSNjle0RR4z65n2FmWSQ+CMXyA0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEQ8vRGCyLY4MM+Rb/RjaA/n94la6EIkmSBBy84WDT+aC+bzdE
 KegCv0buSZlWo9egxN8vRfibT1eTQyUMkzW85BnL83xbjTHSjAiHHTNZA+EBQlQ=
X-Google-Smtp-Source: AGHT+IE8t/WEuR6wLLC+FMdDPRvo5sy/HJiTMb2ns4dr6CTbA9nkOna0DOKv3ZWAngvCWp8t9wgrZg==
X-Received: by 2002:a05:6512:2243:b0:52c:8c4d:f8d6 with SMTP id
 2adb3069b0e04-5387755ba36mr3075446e87.45.1727335768286; 
 Thu, 26 Sep 2024 00:29:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-537a85e061dsm737595e87.44.2024.09.26.00.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 00:29:27 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:29:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 robdclark@gmail.com, 
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 deborah.brouwer@collabora.com, 
 mripard@kernel.org, rodrigo.vivi@intel.com, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/gpu: ci: update flake tests requirements
Message-ID: <llzzzcfbb5gpdcldobqsl5yqgac6cpgcs4r5jh7sbbsuwhchua@avub3pj2by4z>
References: <20240926070653.1773597-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926070653.1773597-1-vignesh.raman@collabora.com>
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

On Thu, Sep 26, 2024 at 12:36:49PM GMT, Vignesh Raman wrote:
> Update the documentation to require linking to a relevant GitLab
> issue for each new flake entry instead of an email report. Added
> specific GitLab issue URLs for i915, xe and other drivers.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
> - Add gitlab issue link for msm driver.
> 
> ---
>  Documentation/gpu/automated_testing.rst | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/gpu/automated_testing.rst b/Documentation/gpu/automated_testing.rst
> index 2d5a28866afe..f918fe56f2b0 100644
> --- a/Documentation/gpu/automated_testing.rst
> +++ b/Documentation/gpu/automated_testing.rst
> @@ -67,20 +67,26 @@ Lists the tests that for a given driver on a specific hardware revision are
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
> +https://gitlab.freedesktop.org/drm/i915/kernel/-/issues for i915 driver
> +https://gitlab.freedesktop.org/drm/xe/kernel/-/issues for xe driver
> +https://gitlab.freedesktop.org/drm/msm/-/issues for msm driver

Ack for the MSM part.

> +https://gitlab.freedesktop.org/drm/misc/kernel/-/issues for other drivers

-- 
With best wishes
Dmitry
