Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DFDCEBF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 07:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3183F10EC3A;
	Fri, 27 Sep 2024 07:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IloIFCHQ";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E88710E1E8;
 Fri, 27 Sep 2024 07:45:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7804DA4529C;
 Fri, 27 Sep 2024 07:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D42C4CEC7;
 Fri, 27 Sep 2024 07:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727423154;
 bh=muHlqJ7iEOLfJfdfnWfRQ+Z4rZB4TQDLw6WtJrxW/FY=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
 b=IloIFCHQVPrmcLnhS3Iihmfb/Rcd24BcaORt9mlaW+c37RrYEgtgRNkITVY51uovw
 bl5kjuT3ljwQiEQHrZVjBP7+Vx0RUkuMDqg1oDhtTGroKD/xCIr22LVQhMB1yuP68s
 SZSI/1KRueCUqGo7kSSWyUcJMEw/wZu2wEIvkUkZEUo2ZNmxktazbBQfpOZU+EugIm
 8h/BPS2wdxXpxWRGlJ5UvYdO5vqB74ndbB/67+qxPXVd+cprGszrfx145c0svxxFqg
 whyEQjU8IM1LLGgb68qfvB7beaP5QcLEDjE9vM5e3EvC/a/WFLOOkD/DkrWkMA/cLn
 oFcajaknfB5fg==
Message-ID: <545585e6f2e9d0bbe35f0a2785838cfa@kernel.org>
Date: Fri, 27 Sep 2024 07:45:51 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Vignesh Raman" <vignesh.raman@collabora.com>
Subject: Re: [PATCH v3] docs/gpu: ci: update flake tests requirements
In-Reply-To: <20240927052416.1833889-1-vignesh.raman@collabora.com>
References: <20240927052416.1833889-1-vignesh.raman@collabora.com>
Cc: airlied@gmail.com, amd-gfx@lists.freedesktop.org, daniel@ffwll.ch,
 daniels@collabora.com, deborah.brouwer@collabora.com,
 dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
 guilherme.gallo@collabora.com, helen.koike@collabora.com,
 intel-gfx@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 mripard@kernel.org, quic_abhinavk@quicinc.com, robdclark@gmail.com,
 rodrigo.vivi@intel.com, sergi.blanch.torne@collabora.com,
 virtualization@lists.linux.dev, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
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

On Fri, 27 Sep 2024 10:54:14 +0530, Vignesh Raman wrote:
> Update the documentation to specify linking to a relevant GitLab
> issue or email report for each new flake entry. Added specific
> GitLab issue urls for i915, msm and amdgpu driver.
> 
> Acked-by: Abhinav Kumar <quic_abhinavk@quicinc.com> # msm
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
