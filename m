Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AE7C636D3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 08:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A968410EC92;
	Fri, 10 Feb 2023 08:04:10 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA7D10EC55
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 04:51:26 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id be8so5317198plb.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Feb 2023 20:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/p6GNpoWLwqRjkpemdg8r3B7YOn9VfnVEzWKh2GHgSQ=;
 b=mEtjIioleyGxYaWuQJaM9p/AxjJefiyXu8LvsMl3AaQryOfcQO+xfqyhuhj365eu1a
 VUd0vp9Y82wY4p5q7ciGrkQb3Q0pe2zuRNz7mpYuIUfypr4gKRJiSwcVFEEp3ROamt7m
 f2o0mcQ3EgkUlGtesmnyMPr6HrhJJA2Ruprd1ynnLyufZgZtgemKhsi3eDuODbrrNhHB
 mA/8oAfhdOG9+uUcSsPvyLanaDiqNIXatrwJlPNq1j9BVApCRbxk9iwtk5wWoRGELver
 8DpVkbsJHDyhJi8Zb+iXnkLj1W5w3xGyD/F6OSgWf+nDQkwi/NcMbz19PXiTc5stxZbr
 dchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/p6GNpoWLwqRjkpemdg8r3B7YOn9VfnVEzWKh2GHgSQ=;
 b=aRwtiksSU3hEFAx6IzYZoBp1Ew8+Qf2QJLF+I6sMsP0U9SkBu7VLquHbva0X4EoyfT
 Qy6UW9JE33mV5GpdzaWivawpWmfMwup95QtJrKc+skeSt2SXCCGfM3OtniQcSqgls/DA
 +qdLq1SuwZlT4+xf4nTr/TecyHkCWe0TmouCSdAcI5F1WG0td+t9OMnZZwviTd+uHQy4
 wlSDA3GZSm+zQpFOR/6/bqwO0Rpy8cKL4pxkjyRImXcBEakKTIwm9XOq8toN/4wh7Uek
 0+dzdq7Zddwf7SxtVJorHYgMcmaekxGJkukZAYppb2Tv4LK42wLEu0sX4NMFcAPiXhFT
 BKKQ==
X-Gm-Message-State: AO0yUKURMD261mD4dW2XwVWJLw9YGlLEjiQXYmPVTsGatUYDNaI3TCj4
 bo6qdMst7BfB63f4Zu9fbOY=
X-Google-Smtp-Source: AK7set8jSnGNm0tfiKRiMixhQZ/VY+kgsPUh9U4OTggadOBbCV4OPfkKzZmoBDm/AM7I3UA3B9lqiA==
X-Received: by 2002:a05:6a20:8f04:b0:bc:c07a:f6c with SMTP id
 b4-20020a056a208f0400b000bcc07a0f6cmr18379114pzk.16.1676004686432; 
 Thu, 09 Feb 2023 20:51:26 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Feb 2023 20:51:26 -0800 (PST)
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 9/9] drm/amdgpu: register a vga_switcheroo client for all
 GPUs that are not thunderbolt attached
Date: Fri, 10 Feb 2023 15:48:26 +1100
Message-Id: <20230210044826.9834-10-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210044826.9834-1-orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Feb 2023 08:04:04 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Rander Wang <rander.wang@intel.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Evan Quan <evan.quan@amd.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Kerem Karabay <kekrby@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Jack Xiao <Jack.Xiao@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 Takashi Iwai <tiwai@suse.com>, Aditya Garg <gargaditya08@live.com>,
 Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kerem Karabay <kekrby@gmail.com>

Commit 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
vga_switcheroo") made amdgpu only register a vga_switcheroo client for
GPU's with PX, however AMD GPUs in dual gpu Apple Macbooks do need to
register, but don't have PX. Instead of AMD's PX, they use apple-gmux.

Revert to the old logic of registering for all non-thunderbolt gpus,
like radeon and nouveau.

Fixes: 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and vga_switcheroo")
Signed-off-by: Kerem Karabay <kekrby@gmail.com>
[Orlando Chamberlain <orlandoch.dev@gmail.com>: add commit description]
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f28a8c02f64..0bb553a61552 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3919,12 +3919,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
 
-	if (amdgpu_device_supports_px(ddev)) {
-		px = true;
-		vga_switcheroo_register_client(adev->pdev,
-					       &amdgpu_switcheroo_ops, px);
+	px = amdgpu_device_supports_px(ddev);
+
+	if (!pci_is_thunderbolt_attached(adev->pdev))
+		vga_switcheroo_register_client(adev->pdev, &amdgpu_switcheroo_ops, px);
+
+	if (px)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
-	}
 
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
@@ -4048,10 +4049,13 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	kfree(adev->bios);
 	adev->bios = NULL;
-	if (amdgpu_device_supports_px(adev_to_drm(adev))) {
+
+	if (!pci_is_thunderbolt_attached(adev->pdev))
 		vga_switcheroo_unregister_client(adev->pdev);
+
+	if (amdgpu_device_supports_px(adev_to_drm(adev)))
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
-	}
+
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_unregister(adev->pdev);
 
-- 
2.39.1

