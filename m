Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA0DC63798
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 16:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6677C2067C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 16:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6iolgns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6677C2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017F36EA18;
	Wed, 25 Nov 2020 16:21:45 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4EB6EA18
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 16:21:43 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id l2so5253653qkf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 08:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wuu0TdBaE7X9MNuc4OUMie7sUkUK5i0TBExB/az8Wfc=;
 b=b6iolgnsG7lkXsczWfYH+Mb6ZXkstXTFMgQzjvXEAonhQ8/SUlHE2ufX1B1m+ZnKb6
 9xpeVX1CsShUCJJDHSMgK3JRBSr3IqBYRodgkkJJH2C3JgI76X7e87D2wGbLLRf7sp0A
 tF376PlrUaNYoNqBFKaNMUZOdLSS9mffBtwerdRn6dj3jMk+MXB4f2dLltjy6k5CGTHb
 tmhsJGpI1vydzkvX3nYbxXfGoB7zfYcCSEo9eWmEmR0bAo7ZzaVwLQMTkERV0IaSsGxm
 p2bhPqQI+dp33yXYm0tbhPzBC0I+V7GV+an05BIBqTP6P7m0IONDyd9vmGAgh/OCC4OT
 KZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wuu0TdBaE7X9MNuc4OUMie7sUkUK5i0TBExB/az8Wfc=;
 b=ced/UaqkRl6hDMitO33tYEKxOYoSnXMUlEI9T1XV0hdwxuJ5KGuy2assIp1TUTysJn
 cgTmu1Y+i20PNTH3R0S5HuTAGoiJOlJTSzqmyyjiVbTo953cFAoLf8U2oluKxsvX4cf7
 6+EOWk+UxhbZ4ANmVWfzYYsbSbqmK8+etnC3zqqFkro3HJJ7xEdYranvGg1aoUgIkYO6
 GNjMbQhrqnPA3fknm7FbOSda4GsJXuyIuSU1QK3MhasLIq92FKu1G4EqLdtkLiSqvmSj
 /O8BoV5MTYjop7nREJsbIU8OYJPnA8utQunkE6FplW9da/IOFTPVq4AfqB8Keck9h43J
 3XEA==
X-Gm-Message-State: AOAM533TF8QywBybAPwDaLEN4nmKQQ1+SET0un8S2V1sf8qgRjGcH2Rj
 7DjVj9yWWudXEifwG8BC9T7wzxpN8MA=
X-Google-Smtp-Source: ABdhPJxRiJExUjq4SDvJ15q0cRJvQOHW8RDGecm9qBbzmYbXfabWlZiOu2K3Nf0rBTsmv+9+S40RKg==
X-Received: by 2002:a37:a110:: with SMTP id k16mr4209220qke.285.1606321302780; 
 Wed, 25 Nov 2020 08:21:42 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id u24sm3093367qtb.33.2020.11.25.08.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 08:21:41 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: fix mode2 reset sequence for vangogh
Date: Wed, 25 Nov 2020 11:21:31 -0500
Message-Id: <20201125162132.237264-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201125162132.237264-1-alexander.deucher@amd.com>
References: <20201125162132.237264-1-alexander.deucher@amd.com>
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

We need to save and restore PCI config space.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 34 ++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 221a29cdc0aa..70d6556cd01d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -336,6 +336,38 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 	return ret;
 }
 
+static int nv_asic_mode2_reset(struct amdgpu_device *adev)
+{
+	u32 i;
+	int ret = 0;
+
+	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
+
+	/* disable BM */
+	pci_clear_master(adev->pdev);
+
+	amdgpu_device_cache_pci_state(adev->pdev);
+
+	ret = amdgpu_dpm_mode2_reset(adev);
+	if (ret)
+		dev_err(adev->dev, "GPU mode2 reset failed\n");
+
+	amdgpu_device_load_pci_state(adev->pdev);
+
+	/* wait for asic to come out of reset */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		u32 memsize = adev->nbio.funcs->get_memsize(adev);
+
+		if (memsize != 0xffffffff)
+			break;
+		udelay(1);
+	}
+
+	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
+
+	return ret;
+}
+
 static bool nv_asic_supports_baco(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = &adev->smu;
@@ -392,7 +424,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 		break;
 	case AMD_RESET_METHOD_MODE2:
 		dev_info(adev->dev, "MODE2 reset\n");
-		ret = amdgpu_dpm_mode2_reset(adev);
+		ret = nv_asic_mode2_reset(adev);
 		break;
 	default:
 		dev_info(adev->dev, "MODE1 reset\n");
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
