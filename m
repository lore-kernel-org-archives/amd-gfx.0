Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F4C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649B1206DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrMpXJAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649B1206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A1176E7EF;
	Thu, 28 May 2020 21:35:41 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D9ED6E7EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 21:35:39 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id w1so403651qkw.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4iItGOestRmZEkHG7p+LtFLLwhBJ3BbBfoY5JGTbWa8=;
 b=QrMpXJAqH7hD8jSMR38tuqZbGnpnG9ul9AyyDCff0Hesg0Z10qdz1jeAky/ZM9xWy1
 crHX1VMOZKa6QnFt5kvkGSiygZYlSnoTaaLAuxcO4wfVHnjk3by9HR+7l3LHs8k8oOLU
 suS7aJXcI+9eyMBofiAmt/6RQLUYcWM1QgyOZd/gtyzGUD2TWK9rrB2F3eUTcUAfJTq5
 9GCm4P/0mrEJDXB2/HCWn4ug5npMt8NYKsmvIHWevoPX5AZtMua2BaAD1QrbWcljFhC4
 AEt5OSBKlVqP6ry1MlqczY/NwNPz4UzyDenU73Jyp0bSkwEgJmaMiiiwejTOLN+TzOGU
 XV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4iItGOestRmZEkHG7p+LtFLLwhBJ3BbBfoY5JGTbWa8=;
 b=aKwid3P0tFkMspgu3yWi++9feppTSGr/L9IJLhpCxQtYFAcfxBejRTl92DBUJGLdpB
 j+1XlNi2dk/nnIcRVrZYhIyQDHbFAfYHR23kKqvVcidSfE837g9UvumqsdhSU6tnr9IB
 skHk4W7t6H4Zw3m9FxSfqpimpZRNVCoxcMLdTv4IU3WrWvr3pR8ljCKDqhf7PpomaD40
 RW2djMiDEgfbD+WehG2ebRkk7vk+J+FPS3AhDC23YT21GFxaGpMmMDsTPUqyRsNuc7gx
 clVLzqB0vSaBGElz2plXchGDBGsW46QS4AeAZHKltYZCij2E5u0pI3P6Hap2COZoy1oF
 XjHw==
X-Gm-Message-State: AOAM531SSXS9WWs1DjJmo+Afa8HCaJwM9orno7dA3vXj1SYOS8JGQpNk
 /w5PLAXfFFZndxMdh+LDYtGk+OXM
X-Google-Smtp-Source: ABdhPJxGTaCPgipRyfknEi8QPMtk8LURXF6BiF+veXKQiDFgxmfkLn/jnRWVy/qeH4yf6xY9ER1XZQ==
X-Received: by 2002:a37:b57:: with SMTP id 84mr4734573qkl.364.1590701738288;
 Thu, 28 May 2020 14:35:38 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k43sm7027851qtk.67.2020.05.28.14.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 14:35:37 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdgpu: clean up discovery testing
Date: Thu, 28 May 2020 17:35:25 -0400
Message-Id: <20200528213529.673145-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528213529.673145-1-alexander.deucher@amd.com>
References: <20200528213529.673145-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than checking of the variable is enabled and the
chip is the right family check for the presence of the
discovery table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 716f1f7ebe3d..febcecc5c6b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1533,7 +1533,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 
 	adev->firmware.gpu_info_fw = NULL;
 
-	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
+	if (adev->discovery_bin) {
 		amdgpu_discovery_get_gfx_info(adev);
 		return 0;
 	}
@@ -3363,7 +3363,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		amdgpu_pmu_fini(adev);
-	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
+	if (adev->discovery_bin)
 		amdgpu_discovery_fini(adev);
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
