Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A995AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 22:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2CF610E438;
	Mon, 14 Mar 2022 22:11:57 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B20B10E435;
 Mon, 14 Mar 2022 22:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647295916; x=1678831916;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=TmF4FvJhy8r4L46VPu1Ph2AwpXhixIyOHXK6V+ZN30g=;
 b=PJDtXRu/WIGZOCihMXF/ypBGKmv6O5O6I4gLXq/3BB4NsXiwgCvG0Yh2
 mDSo4nAiEmI4ncJnjXKz9/m5KXTBad7iXGw8t6Ak/b6sdBaz6dxR/F/pF
 EDyrHrL6ikBu3vcICNQM1x1jcNxpNEJ6wVTL2eXK8fZ0RFyxfXUYfHued
 DAgT5Pn53yNY7TwuCLyM2X1eV9xKnMP4GRcVRJUcyXH6tG8P5snjx3xdW
 5swA5UfLsivskCzI1BBdbd947h3RohwemlIhcOBkCtjiS70ACtynJuF5U
 N2RdqVkiyPFD/IVdvC2MpujLY1afivGvcgmZ8vNonjsQ41QzQxQK60YZc w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="316877952"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; d="scan'208";a="316877952"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 15:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; d="scan'208";a="556641142"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.151])
 by orsmga008.jf.intel.com with SMTP; 14 Mar 2022 15:11:44 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Tue, 15 Mar 2022 00:11:43 +0200
Date: Tue, 15 Mar 2022 00:11:43 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 00/22] drm: Review of mode copies
Message-ID: <Yi+9n0eGn3rNKb4X@intel.com>
References: <20220218100403.7028-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220218100403.7028-1-ville.syrjala@linux.intel.com>
X-Patchwork-Hint: comment
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
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Emma Anholt <emma@anholt.net>, Neil Armstrong <narmstrong@baylibre.com>,
 Xinliang Liu <xinliang.liu@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Sam Ravnborg <sam@ravnborg.org>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Chen Feng <puck.chen@hisilicon.com>, Alain Volmat <alain.volmat@foss.st.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Leo Li <sunpeng.li@amd.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Maxime Ripard <mripard@kernel.org>, Nikola Cornij <nikola.cornij@amd.com>,
 John Stultz <john.stultz@linaro.org>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomba@kernel.org>,
 Jyri Sarha <jyri.sarha@iki.fi>, Sandy Huang <hjc@rock-chips.com>,
 Robert Foss <robert.foss@linaro.org>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Alex Deucher <alexander.deucher@amd.com>, Tian Tao <tiantao6@hisilicon.com>,
 freedreno@lists.freedesktop.org,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 18, 2022 at 12:03:41PM +0200, Ville Syrjala wrote:
>   drm: Add drm_mode_init()
>   drm/bridge: Use drm_mode_copy()
>   drm/imx: Use drm_mode_duplicate()
>   drm/panel: Use drm_mode_duplicate()
>   drm/vc4: Use drm_mode_copy()
These have been pushed to drm-misc-next.

>   drm/amdgpu: Remove pointless on stack mode copies
>   drm/amdgpu: Use drm_mode_init() for on-stack modes
>   drm/amdgpu: Use drm_mode_copy()
amdgpu ones are reviewed, but I'll leave them for the
AMD folks to push to whichever tree they prefer.


The rest are still in need of review:
>   drm/radeon: Use drm_mode_copy()
>   drm/gma500: Use drm_mode_copy()
>   drm/hisilicon: Use drm_mode_init() for on-stack modes
>   drm/msm: Nuke weird on stack mode copy
>   drm/msm: Use drm_mode_init() for on-stack modes
>   drm/msm: Use drm_mode_copy()
>   drm/mtk: Use drm_mode_init() for on-stack modes
>   drm/rockchip: Use drm_mode_copy()
>   drm/sti: Use drm_mode_copy()
>   drm/tilcdc: Use drm_mode_copy()
>   drm/i915: Use drm_mode_init() for on-stack modes
>   drm/i915: Use drm_mode_copy()
>   drm: Use drm_mode_init() for on-stack modes
>   drm: Use drm_mode_copy()

-- 
Ville Syrjälä
Intel
