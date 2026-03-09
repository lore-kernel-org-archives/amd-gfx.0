Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF0BF4180B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 15:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E33B10E539;
	Mon,  9 Mar 2026 15:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U4L5dPhP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C457A10E533;
 Mon,  9 Mar 2026 15:21:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AFA5843E9F;
 Mon,  9 Mar 2026 15:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C57CC4CEF7;
 Mon,  9 Mar 2026 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773069684;
 bh=yjH9Qy6R6RruoyUt8z/lT2greWmRoBg2fSGT8Nm76Q8=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
 b=U4L5dPhPxfqs4JNxt0xMlRXLGgEgFbnOQkZVlti2gjv5KyyiBwar0P13MLfQ9bubh
 qoAYnquJqnlBkPmCiE6OKMAJ4v/QiqauKhbUAXkoMJ8Y9RrRG0IkIJ28p7FTw5mPql
 6plPQyAshZdZ5b7qevch3261+Fjqvboq/GTm2b9uI8FmPBQU/hkEKtdTz8FnEoRKLC
 ZEBYDl4se1JJHja0XWGGDOuK36m958TCJ/Yj3Lycd18LJwFnAXMo5fB6XXjPurHM9o
 oyMWVj8KaTN+fQHJ+Vc+dbKpr6WF/9ejDtfgkMgS/2g73umL5BRttrc8oPU2gxO28Q
 8m+T8znrqdNyQ==
Message-ID: <c693c826ce1791fbab960af03ed75138@kernel.org>
Date: Mon, 09 Mar 2026 15:21:21 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v10 02/22] drm/display: hdmi-state-helper: Use default
 case for unsupported formats
In-Reply-To: <20260305-color-format-v10-2-a58c68a11868@collabora.com>
References: <20260305-color-format-v10-2-a58c68a11868@collabora.com>
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
 Huang" <hjc@rock-chips.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Tvrtko Ursulin" <tursulin@ursulin.net>
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

On Thu, 5 Mar 2026 15:19:28 +0100, Nicolas Frattaroli wrote:
> Switch statements that do not handle all possible values of an
> enumeration will generate a warning during compilation. In preparation
> for adding a COUNT value to the end of the enum, this needs to be dealt
> with.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
