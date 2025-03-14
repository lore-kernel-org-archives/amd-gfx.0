Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C5EC35FF8
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 08:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D711610E9AB;
	Fri, 14 Mar 2025 08:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="owLJ1WJu";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57AC310E9AB;
 Fri, 14 Mar 2025 08:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1741942766;
 bh=dO2g62Nlwp+u8LGId8NUD6lLWl2ArcKsTpjA88vbPVo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=owLJ1WJu0YKFv0vCeABK86Cs/4CF+m+pf5V2jGXI5Th+cqcCaysIujd1olFmyZou5
 BCH9bEIqNTJqx1LnT4yxIuzQofiE/ZmInPnWe0LdLTgbdS4E7MnSSROdWsAZmRNFIz
 E57s7m+GwOo0FVvu/yTb63il4pNmhvdRSvBNyYx0AUBBgppteciBMEnkMP1bigrN9n
 FE8PjZ1TMZLHsZNg5OX+KHgCP8hcGn5LKLQMbGVlb+NrziOiD1kfWAbgOtjjughYo2
 oPCPP/nflkUJDGUVQesX6PZE5MxUzbvkSpbLSsda6Fn2xQHqxvinFdcXt3g7WPcH2z
 UW8sjJvbCRGrw==
Received: from debian.. (unknown [103.163.65.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CA66717E0ABD;
 Fri, 14 Mar 2025 09:59:21 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.fornazier@gmail.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, robdclark@gmail.com, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, valentine.burley@collabora.com,
 lumag@kernel.org, quic_abhinavk@quicinc.com, mripard@kernel.org,
 jani.nikula@linux.intel.com, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] drm/ci: arm64.config: mediatek: enable PHY drivers
Date: Fri, 14 Mar 2025 14:28:52 +0530
Message-ID: <20250314085858.39328-4-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314085858.39328-1-vignesh.raman@collabora.com>
References: <20250314085858.39328-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The mediatek display driver fails to probe on mt8173-elm-hana and
mt8183-kukui-jacuzzi-juniper-sku16 in v6.14-rc4 due to missing PHY
configurations.

Enable the following PHY drivers for MediaTek platforms:
- CONFIG_PHY_MTK_HDMI=y for HDMI display
- CONFIG_PHY_MTK_MIPI_DSI=y for DSI display

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/arm64.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index a8fca079921b..fddfbd4d2493 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -193,6 +193,8 @@ CONFIG_PWM_MTK_DISP=y
 CONFIG_MTK_CMDQ=y
 CONFIG_REGULATOR_DA9211=y
 CONFIG_DRM_ANALOGIX_ANX7625=y
+CONFIG_PHY_MTK_HDMI=y
+CONFIG_PHY_MTK_MIPI_DSI=y
 
 # For nouveau.  Note that DRM must be a module so that it's loaded after NFS is up to provide the firmware.
 CONFIG_ARCH_TEGRA=y
-- 
2.47.2

