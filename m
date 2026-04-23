Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEEBFAD3E7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EC510EACC;
	Thu, 23 Apr 2026 01:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fE+X65kY";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A7810EACA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:16:26 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so48908615e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776906985; x=1777511785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OiyejOykGnNbuhyCLDyfR1N0o6da2TPJfqIN8kd8BF4=;
 b=fE+X65kYiA2eHUUePOY3T30cWHLtk+2ihbPBXaI9RisZetEpVkqpGEdQKMJpleKXz1
 wNVu1v+RVW42yrzhAS5f+0/VTK7VOnRb89YVKT71XnD9i4SK1CxInLtlvBQnOG4vkYgS
 3nPM3M4SxVAtad4CFn0/nqZHucL5hUgaQkfmDCm4o1HSOJ5c/rq5+ceVJYaBAKQZAFp+
 16+JqxyfZxgTGotGI91JXMd1khgt8vpwJk8PyPHczuQfoo9kC0tEdfpHnXQd+uXpwXAm
 DodaMz/5sIMm3ITepicbkHWe7zZiL+H8JbhErv/KeacTrpmIkzeJZJmfPiNmV8EqseIF
 pmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906985; x=1777511785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OiyejOykGnNbuhyCLDyfR1N0o6da2TPJfqIN8kd8BF4=;
 b=cmhVjV0rO4VdYSWmbMnnP0J1+/Pa5Rynd4mH5SeLwM7VCsSXy1LqBPisj4F3Svlc9M
 ub54sm03WRHP6BBvreRkE/ZJNfcQ9l94MAHFSxmRmFs9Mp2Mt+p4Vz+L5qd0L8w/OjSM
 p81N19iNXh8KPaMkHqpWllmhO6b6ZGN2axCZttR2apO9AnnLmMJp7e4Q+lCLe+I+3pcE
 uztqkwRLA+beZHyU1dJ40f7/vHag9FnX1y2Sf5T/t6JFlQfjIqg+DgR09XtF9W7KlP+0
 g2xE2MCU2gKMf435QC6/PpLAdLGJ2fuBtPQEBn9eSTZ5g7kruXtKyqE4a+redmNn9EIM
 beVQ==
X-Gm-Message-State: AOJu0Yz875G7+0EMx2YuwOHYznps3/zEzmngG4t0MLo+86QyPkbyl6vJ
 +9VzPtsoHn9nd1CFpuIGLHg1LyA6Vd0h0VvAVQZrLSXYnM6jr27WPFxum7egxw==
X-Gm-Gg: AeBDietW1/nPPRF8Ac2AFlJRBr/pdyi8vuBTq+0NtqflPuLVuMc6zbPN2+jpVa7q/x+
 vThLcRTbxEEmHRrAafPMdAU1q5RfPfWWhpNWZrpUEO4XkMVam3w6jxElQqgX9S9N0VXvNvkhbCu
 KTOizD38YxBRB7kT5KfVXh65q2yFMY0TeUwmjADO8mZxZoRjc8p2UpFRLA/zr9niFG/u46CBprK
 v1PjTpOMQrYpdMr5CkJNcbdzP5giCfbNd+WCnL/TvNlDeMJIhsQqXK8dCeV23Skpkl++YON9aDB
 0+XIp5fcM4Su9iG5dlKrHw4a1L3q2x1vzPDm9oRJgZjYamyuqTSR8EgzKeMsFfDTcFhQy/dks0Y
 BbgfiiOUycpwv5Wm8ZYqFJR1OuCWHjAdSD9jmNA1czdmKOAvoZO7wZiNN60T4O8kuWAoHxr9mDv
 /4+Q/hzuWfoY8Ziuwfb5sQ9czyDVkQYl8AuPF6mPoYunsiWBIKRlLStW9hi7hW0NgcD22oMsbUb
 56tuA==
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5d with SMTP id
 5b1f17b1804b1-48a55743e96mr138514785e9.7.1776906984721; 
 Wed, 22 Apr 2026 18:16:24 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm370664435e9.3.2026.04.22.18.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 18:16:24 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, John Olender <john.olender@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/11] drm/amdgpu/vce1: Stop using amdgpu_vce_resume
Date: Thu, 23 Apr 2026 03:16:10 +0200
Message-ID: <20260423011614.309180-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423011614.309180-1-timur.kristof@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The VCE1 firmware works slightly differently and is already
loaded by vce_v1_0_load_fw(). It doesn't actually need to
call amdgpu_vce_resume().

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index c8e7297fd7ca3..db8cc97a72d8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -178,7 +178,7 @@ static void vce_v1_0_init_cg(struct amdgpu_device *adev)
 }
 
 /**
- * vce_v1_0_load_fw_signature - load firmware signature into VCPU BO
+ * vce_v1_0_load_fw() - load firmware signature into VCPU BO
  *
  * @adev: amdgpu_device pointer
  *
@@ -186,7 +186,7 @@ static void vce_v1_0_init_cg(struct amdgpu_device *adev)
  * This function finds the signature appropriate for the current
  * ASIC and writes that into the VCPU BO.
  */
-static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
+static int vce_v1_0_load_fw(struct amdgpu_device *adev)
 {
 	const struct common_firmware_header *hdr;
 	struct vce_v1_0_fw_signature *sign;
@@ -232,6 +232,8 @@ static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	memset_io(&cpu_addr[0], 0, amdgpu_bo_size(adev->vce.vcpu_bo));
+
 	cpu_addr += (256 - 64) / 4;
 	memcpy_toio(&cpu_addr[0], &sign->val[i].nonce[0], 16);
 	cpu_addr[4] = cpu_to_le32(le32_to_cpu(sign->length) + 64);
@@ -592,10 +594,7 @@ static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vce_resume(adev);
-	if (r)
-		return r;
-	r = vce_v1_0_load_fw_signature(adev);
+	r = vce_v1_0_load_fw(adev);
 	if (r)
 		return r;
 	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
@@ -714,10 +713,7 @@ static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_vce_resume(adev);
-	if (r)
-		return r;
-	r = vce_v1_0_load_fw_signature(adev);
+	r = vce_v1_0_load_fw(adev);
 	if (r)
 		return r;
 	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
-- 
2.53.0

