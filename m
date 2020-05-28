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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EFDC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42A7206DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv6u3TyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42A7206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7BE6E7F5;
	Thu, 28 May 2020 21:35:43 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E166E7F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 21:35:42 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id w1so403774qkw.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ER+cNtYZuoeyVlg3bP6CiwSPvcL7pxu8W79p6v4Cxj8=;
 b=Qv6u3TyT+W4CHLIki4IGoZrCHLh/jINkcX/NPB7BzsAhTaJYwvoO8ejSLRiZFdlv9c
 7NHXDhqjM22NZCk6qcSIK/EarLlVnS2HVkgoFCOvu3bCOcPOJOsjcv6JgbCyAGjNBaYA
 rprovrON4xiOr+d0CZlnffMXhwpPwl3iYaPZB/WPRr9wmtTSxJ/qb8VPdEpiqQv6tnqs
 Bap6jTYB6jhxobj48NpoWtRXm/qCJr0zAdKqZo+YhC5JH7LgLF+w6w8WLVGGEsUEzCLr
 rvabo+Pd5m1G8WudVxrrhiFSPBo9ZYbQuHGOGV1jBhxkBzeCo3zpHC2gnCDap/jKzHnZ
 Aw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ER+cNtYZuoeyVlg3bP6CiwSPvcL7pxu8W79p6v4Cxj8=;
 b=Pqn5jMCcwal1H7b1Q4/LSz+lu4jw6TIiluNvh0+XSWUupKUJlNOuDFlQ54SS+qmOx9
 yvLIfS92b477usFKwayZvgJT7Lnxpe5tMjB+m5gdy6xLRmXGSLN64KR6c/i3oJ5WmyaD
 5LKzXbkvyVghv1nd3OIC9uHKVUyHP6lETYAQXtFQzVtL3jnwBFPfhyirsAztuWk3mnfW
 LN1uvIDkrJBO55OIg3czVraRWa4FaLanaQ8lKAQajTv0bJbGkAEXOXrKFd7KAdpTVPqu
 py3Ov8L7h+J05Rv1opLalrY60sx0iPVwWjWwM5CjyMQ8dQ6EjweCEgz+XOBRtTQZwRyR
 +mOQ==
X-Gm-Message-State: AOAM532GaArL/Mlisl7zuxBT5wcga3EB3fXYsF4UuH2B1ciwXr4+6zYL
 vPNVKFYOpJjZmq11Zjw9jydfW+Up
X-Google-Smtp-Source: ABdhPJwGbeT7m80b/lY+YiStfAODV9JInS8TuJ5r+RBpc1NyRma+L1Ci3JGiduUhRHwfjomCrZrohw==
X-Received: by 2002:a37:9c55:: with SMTP id f82mr4854095qke.225.1590701741400; 
 Thu, 28 May 2020 14:35:41 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k43sm7027851qtk.67.2020.05.28.14.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 14:35:40 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amdgpu/nv: remove some dead code
Date: Thu, 28 May 2020 17:35:28 -0400
Message-Id: <20200528213529.673145-5-alexander.deucher@amd.com>
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

navi never supported the pci config reset.  Neither did
vega.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 34 ---------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 61eea26922ce..0f927fcff0d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -254,31 +254,6 @@ static int nv_read_register(struct amdgpu_device *adev, u32 se_num,
 	return -EINVAL;
 }
 
-#if 0
-static void nv_gpu_pci_config_reset(struct amdgpu_device *adev)
-{
-	u32 i;
-
-	dev_info(adev->dev, "GPU pci config reset\n");
-
-	/* disable BM */
-	pci_clear_master(adev->pdev);
-	/* reset */
-	amdgpu_pci_config_reset(adev);
-
-	udelay(100);
-
-	/* wait for asic to come out of reset */
-	for (i = 0; i < adev->usec_timeout; i++) {
-		u32 memsize = nbio_v2_3_get_memsize(adev);
-		if (memsize != 0xffffffff)
-			break;
-		udelay(1);
-	}
-
-}
-#endif
-
 static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 {
 	u32 i;
@@ -336,15 +311,6 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 
 static int nv_asic_reset(struct amdgpu_device *adev)
 {
-
-	/* FIXME: it doesn't work since vega10 */
-#if 0
-	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
-
-	nv_gpu_pci_config_reset(adev);
-
-	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
-#endif
 	int ret = 0;
 	struct smu_context *smu = &adev->smu;
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
