Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7672BC35E17
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA5A246A2
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP2Chq11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA5A246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040396E0D1;
	Thu, 27 Feb 2020 20:15:06 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66D656E0C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 20:15:02 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id n1so316142ywe.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 12:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L5BstrvMODLRP/mnMW5Hqw6r+0iGnfwVqVzVLQ+9e24=;
 b=VP2Chq111HQOOY7aMXmHxmsHErAcpbv+pdqdegFn+TzmeSdy4vQfA62lxqWWx6nfHd
 LUs9SIKj7YOo/oqxhCpj0r0UVmu/S6nrIvMEOXWmi/2apu+rOSLScfHPxkDWzgctg0JA
 OJiUGSDCRyTV6VcK5Qh+2JxvgACHkxzDkheJ6oC14LC+YE8CI/pOzvv+NNoGaQkvJYTL
 bmIsqYyvqc9ePXGSB8LY2ng07hCPj3+B1pB04sBiq42x+rFA4u7UbkKf9sMae5vHVsMg
 /unvxCVTsKecGaSIslqdG+DtO/zfK6GvZb0yE9R6/YGb9REhV+nXaGIW5moMXEKc7pjy
 BfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L5BstrvMODLRP/mnMW5Hqw6r+0iGnfwVqVzVLQ+9e24=;
 b=hafg54EeIERTJavdLVA8OOXmyxIxtdjawaEwXFNRZd4hW8CVq6vLtz2278vyqpjKdr
 IyFYnQWMWtNFr24iyW+ZG8ir5oQMlm2+YMBtCggW6FTcZ813/ZOXAzOjPiK/v3MIy/dw
 39oZHDLwnsB8CJxIxEhtILkAFik63xymOsEO/FSKK+73Er1NEiDF/e6zQPxrad4v5xkP
 WQxHrip4numhcDYIgbuyYyPBtxs0HVnXP7L/XRh9mW7ci1ohwWT0NpHXycFKq+4VBui0
 3t8okyIKSw7DbSNxPtwogcxIV6dDXzcL/oDgx9o/+nyyFQKm7HHbEsXfXz84iC1l2M2Q
 aWAA==
X-Gm-Message-State: APjAAAW4rTen/WdLxTSCIUDIdpN3fcEfhicg95T22lCL6BweRDPTH9ez
 9NxcIzDV/QwxDWku3YZHaQTbPiL3
X-Google-Smtp-Source: APXvYqwtjLWFytxEW/Gn91Xme4SC9Ol8BLsA2aZr0nGjb14n5F2zhtZdoxhH3wiAxFDa1PCGvdo0PQ==
X-Received: by 2002:a81:3888:: with SMTP id f130mr1107956ywa.138.1582834501418; 
 Thu, 27 Feb 2020 12:15:01 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j72sm3042228ywj.60.2020.02.27.12.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 12:15:00 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/gfx: fix indentation in new rlc spm code
Date: Thu, 27 Feb 2020 15:14:50 -0500
Message-Id: <20200227201450.185953-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227201450.185953-1-alexander.deucher@amd.com>
References: <20200227201450.185953-1-alexander.deucher@amd.com>
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

fixes warnings with -Wmisleading-indentation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index cb3421e25adc..0dc3ed694fe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1016,9 +1016,9 @@ static int gfx_v10_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-    /* init spm vmid with 0xf */
-    if (adev->gfx.rlc.funcs->update_spm_vmid)
-        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+	/* init spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 397c62c58436..733d398c61cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3346,9 +3346,9 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-    /* init spm vmid with 0xf */
-    if (adev->gfx.rlc.funcs->update_spm_vmid)
-        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+	/* init spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 294abff9efb7..393a1324daa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1318,9 +1318,9 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-    /* init spm vmid with 0xf */
-    if (adev->gfx.rlc.funcs->update_spm_vmid)
-        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+	/* init spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1d5fd5f17a30..9962ef80da92 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1847,9 +1847,9 @@ static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
 		break;
 	}
 
-    /* init spm vmid with 0xf */
-    if (adev->gfx.rlc.funcs->update_spm_vmid)
-        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+	/* init spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
 
 	return 0;
 }
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
