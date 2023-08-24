Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D9BC6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 09:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 656E410E116;
	Thu, 24 Aug 2023 09:00:00 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B971C10E116;
 Thu, 24 Aug 2023 08:59:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 228F366430;
 Thu, 24 Aug 2023 08:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED30C433C7;
 Thu, 24 Aug 2023 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692867597;
 bh=pRjABeYbdZ7kYm0kauhfXEU9jP8GasEtUcwhn21dCxc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ectU467xo6X3YBcQDP+/ngOU7WPTPgRDxCHrpluWN392Mlc60axx3vIIX48VsgoDN
 PpRyrP5/+WdC+2ykQLyOeTetMwu/huJ3eZd8i0LSxlom3CPb3lrf4rgBp8s0eX8avr
 BGfWzbgxOTfIlW+pAY0WIEqoHeTxo/6sOY5QZAkYbyAkN19q9/PRObJOfOAPQjH1uq
 yuz+qZ9oGjn0YECu1cNAX2T+ncu2eKxivxlqKZpSZVNj2O7+WanBFUfataSOnZA+79
 SeT2jrZPjluftwVKxhf8sdBqKhIPd8Cn9wX8U0ZFVrF46L28H4hVpTzZP/2UJTdUE/
 2QZdbUc7UizJQ==
From: Maxime Ripard <mripard@kernel.org>
To: Lee Jones <lee@kernel.org>
In-Reply-To: <20230824073710.2677348-1-lee@kernel.org>
References: <20230824073710.2677348-1-lee@kernel.org>
Subject: Re: [PATCH (set 1) 00/20] Rid W=1 warnings from GPU
Message-Id: <169286759481.453038.12943953579128536191.b4-ty@kernel.org>
Date: Thu, 24 Aug 2023 10:59:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
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
Cc: Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Fabio Estevam <festevam@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, David Airlie <airlied@gmail.com>,
 NXP Linux Team <linux-imx@nxp.com>, amd-gfx@lists.freedesktop.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Danilo Krummrich <dakr@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
 Stanley Yang <Stanley.Yang@amd.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linaro-mm-sig@lists.linaro.org, linux-tegra@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org,
 Hyun Kwon <hyun.kwon@xilinx.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 Jerome Glisse <glisse@freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Gourav Samaiya <gsamaiya@nvidia.com>,
 Shawn Guo <shawnguo@kernel.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 24 Aug 2023 08:36:45 +0100, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Danilo Krummrich <dakr@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Gourav Samaiya <gsamaiya@nvidia.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> Cc: Jerome Glisse <glisse@freedesktop.org>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: "Maíra Canal" <mairacanal@riseup.net>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: nouveau@lists.freedesktop.org
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime

