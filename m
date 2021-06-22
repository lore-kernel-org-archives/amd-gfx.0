Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE0C49EA4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 14:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D63461027
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 14:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D63461027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B846E528;
	Tue, 22 Jun 2021 14:10:25 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4436E511;
 Tue, 22 Jun 2021 14:10:23 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 750991FD71;
 Tue, 22 Jun 2021 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624371022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bU53poMO4PuJvduCjmpKhTk2SV5pJ0hIOyB1sAQvWk=;
 b=CIprfmBLErp2ozHKGhJVaDf2DTYTMHNYyqo4D3OHVkRfSIedW+duNbCLYGEjG9gx04LDW/
 ERSAjzqEiNIkDI5VVXkxnmayOwA66pQAYeekgYJqBL4Tex+itVRDuq7X0j7+wADWactC1D
 PBO0htaLIoRWSa40Ho5i56PWASUziPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624371022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bU53poMO4PuJvduCjmpKhTk2SV5pJ0hIOyB1sAQvWk=;
 b=L+2yJktmWahSssG9Tl2gY+GAejbeMsdWrF6LmbvMMEQ4APnJLo656rk3W729JAiAy8b2wg
 UmAXsr7h7UEkC0Cg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 7A74111A98;
 Tue, 22 Jun 2021 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624371022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bU53poMO4PuJvduCjmpKhTk2SV5pJ0hIOyB1sAQvWk=;
 b=CIprfmBLErp2ozHKGhJVaDf2DTYTMHNYyqo4D3OHVkRfSIedW+duNbCLYGEjG9gx04LDW/
 ERSAjzqEiNIkDI5VVXkxnmayOwA66pQAYeekgYJqBL4Tex+itVRDuq7X0j7+wADWactC1D
 PBO0htaLIoRWSa40Ho5i56PWASUziPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624371022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bU53poMO4PuJvduCjmpKhTk2SV5pJ0hIOyB1sAQvWk=;
 b=L+2yJktmWahSssG9Tl2gY+GAejbeMsdWrF6LmbvMMEQ4APnJLo656rk3W729JAiAy8b2wg
 UmAXsr7h7UEkC0Cg==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id WAYRHU3v0WD3UAAALh3uQQ
 (envelope-from <tzimmermann@suse.de>); Tue, 22 Jun 2021 14:10:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, james.qian.wang@arm.com,
 liviu.dudau@arm.com, mihail.atanassov@arm.com, brian.starkey@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, krzysztof.kozlowski@canonical.com,
 xinliang.liu@linaro.org, tiantao6@hisilicon.com, john.stultz@linaro.org,
 kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
 laurentiu.palcu@oss.nxp.com, l.stach@pengutronix.de,
 p.zabel@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 chunkuang.hu@kernel.org, matthias.bgg@gmail.com, bskeggs@redhat.com,
 tomba@kernel.org, hjc@rock-chips.com, heiko@sntech.de,
 benjamin.gaignard@linaro.org, yannick.fertre@foss.st.com,
 philippe.cornu@foss.st.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, wens@csie.org, jernej.skrabec@gmail.com,
 thierry.reding@gmail.com, jonathanh@nvidia.com, jyri.sarha@iki.fi,
 emma@anholt.net, linux-graphics-maintainer@vmware.com, zackr@vmware.com,
 hyun.kwon@xilinx.com, laurent.pinchart@ideasonboard.com,
 michal.simek@xilinx.com
Subject: [PATCH v2 17/22] drm/tegra: Don't set struct drm_device.irq_enabled
Date: Tue, 22 Jun 2021 16:09:57 +0200
Message-Id: <20210622141002.11590-18-tzimmermann@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622141002.11590-1-tzimmermann@suse.de>
References: <20210622141002.11590-1-tzimmermann@suse.de>
MIME-Version: 1.0
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
Cc: linux-samsung-soc@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev,
 linux-rockchip@lists.infradead.org, linux-mediatek@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-tegra@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The field drm_device.irq_enabled is only used by legacy drivers
with userspace modesetting. Don't set it in tegra.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tegra/drm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index f96c237b2242..8d27c21ddf48 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1188,13 +1188,6 @@ static int host1x_drm_probe(struct host1x_device *dev)
 			goto device;
 	}
 
-	/*
-	 * We don't use the drm_irq_install() helpers provided by the DRM
-	 * core, so we need to set this manually in order to allow the
-	 * DRM_IOCTL_WAIT_VBLANK to operate correctly.
-	 */
-	drm->irq_enabled = true;
-
 	/* syncpoints are used for full 32-bit hardware VBLANK counters */
 	drm->max_vblank_count = 0xffffffff;
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
