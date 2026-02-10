Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C5BEA8138
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 15:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D667710E5B9;
	Tue, 10 Feb 2026 15:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cnWI6HFr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0FC10E5B9;
 Tue, 10 Feb 2026 15:51:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 515B2442DF;
 Tue, 10 Feb 2026 15:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8BDC116C6;
 Tue, 10 Feb 2026 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770738695;
 bh=q++is72bj4uWTYoc+vkSxji6zhNdE9WWO1UbEw2tudU=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
 b=cnWI6HFr1xnNHjshPC4yDw5r3+LkkXpVxaFR3h2hnFByRL3mXa2IZkAWf26KgNLHG
 P7Qo5hWsg6/4z9qOyshZWKCSOBKbiGeS9Z6a/2f9Dxu4si/Al+lkTj0Wn/QV/jN7N0
 ZBAb2QM7//B7b2eK/anIQ/bEhWHa+8YbEnjMKVdzI5yXLDPyn1cBrAeIL8/DlNtWhr
 tfMPvfCdHpCEpIpG+vveOFecl/QePKAD8y1bvSOV84opabNTBxS0cYwe9z0mUJPL+7
 XiX7IgAzzf2ceJD+gaS3/eAd/8XwnDw1XsQdk86Bb6bC3KRkQ+ReQuaJT5kdQleZK5
 /4xNZoC+I20pg==
Message-ID: <5c9aeeb9e9d9c0609028dc3637eb9dc4@kernel.org>
Date: Tue, 10 Feb 2026 15:51:32 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v7 18/22] drm/tests: hdmi: Add tests for the
 color_format property
In-Reply-To: <20260121-color-format-v7-18-ef790dae780c@collabora.com>
References: <20260121-color-format-v7-18-ef790dae780c@collabora.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, "Alex
 Deucher" <alexander.deucher@amd.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Andy Yan" <andy.yan@rock-chips.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "David
 Airlie" <airlied@gmail.com>, "Dmitry Baryshkov" <lumag@kernel.org>, "Harry
 Wentland" <harry.wentland@amd.com>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Jani
 Nikula" <jani.nikula@linux.intel.com>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Jonathan Corbet" <corbet@lwn.net>, "Joonas
 Lahtinen" <joonas.lahtinen@linux.intel.com>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Leo
 Li" <sunpeng.li@amd.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Rob Herring" <robh@kernel.org>, "Robert Foss" <rfoss@kernel.org>, "Rodrigo
 Siqueira" <siqueira@igalia.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Sandy
 Huang" <hjc@rock-chips.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Tvrtko
 Ursulin" <tursulin@ursulin.net>
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

On Wed, 21 Jan 2026 15:45:25 +0100, Nicolas Frattaroli wrote:
> Add some KUnit tests to check the color_format property is working as
> expected with the HDMI state helper.
> 
> Existing tests are extended to also test the DRM_COLOR_FORMAT_AUTO case,
> in order to avoid duplicating test cases. For the explicitly selected
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
