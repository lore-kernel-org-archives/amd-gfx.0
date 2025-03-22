Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B12C3600A
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635BB10E869;
	Sat, 22 Mar 2025 01:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z5BwcEBM";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FBC10E855
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:22 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-476ab588f32so36721991cf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608041; x=1743212841; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ttv0OEqH0eHHJ+Qegm/OO8v4t8Fr0wPSRBoABXC8GZg=;
 b=Z5BwcEBMJycTp8+gSy2As3PAIA+7mvgwu+A0uUBuJ/BqJ9WhtmgYLE7WieZLQ+6RbW
 QBE4W4gxQJo2Lzq+t+nEFytnAbfTIRCySHyRP5SJvp2i/hodJRg7rt3Sig+kD4IVjdv3
 hgdCZitTtFPk+EHrVzS7maP7RBbl9CNwhNjJPHR8KFTzPttPsfd8fylnYCT5suznZvkP
 Jwhw+7JetOPRLNA1dPst9Gtn8Rrxz/2AztDT/NBiVdSarH0GJ6uG/5/+z8fyCRvMVmqI
 S7iUWa/6tDzzRlFMpQ99EqVCiWmEy1LKnhRjNbwFaCaEH3kc8/es6WGXsFuEwXmaApxK
 hgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608041; x=1743212841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttv0OEqH0eHHJ+Qegm/OO8v4t8Fr0wPSRBoABXC8GZg=;
 b=oCVufq3cSjzafMrXmfyTXN6nKLZCmjkTT7y9tt+aPg+yCMKEPWxxlR9XQce/km75bG
 hDvpHetdrZBJh80zYQ7j4vCUJAQ/P98sRKx8N81gyoeAFnVk3e1pI6TwyBihSrx5/vBw
 T3LXTFwyvhFI6F2Y7xYrw00/KcehQvtHdGFTYBbt5c7PUERiuz7EO5xaGeA6pfa3ZNAM
 sIUXrr099hc+DiCfayVIg98/sXugQiAwuCZTqO6qNMY7k2hr6qw1AoBEjBbKZ6TV6EzK
 tItvjdYYLIB2HUwnsXq2vUH/TGsAxPT7IOu4K8TQ3XAvlvmyts/cbjRxExObj69gmxbt
 DRrw==
X-Gm-Message-State: AOJu0Ywl1MON6zamIrJbJUazLCuHEXxR83ejS02QPv6L+9WJ/KlpQf8c
 y+JITBvr/ZZ9UnlZYrRI3iRCBY8T83S+o5o5m1DpvYl2e//Sh/buHposIQ==
X-Gm-Gg: ASbGncsXpMdfvhuSCnwRmsulbyNcknEqJiifLjPWOiACy3xbu5Kshla5OxEfR18aVv8
 9t/3XZr8NR1I3HjFCq8mzqdFfI/CE9FSQ07otoHThPESgXm+Mig/0Acj3ps2DHis7QUv+4/QFYW
 MK9uaL3iR4luXl20jZv9snLfgAgb+tNmt3foDpyVk0CMMMoIRDKBSjH42zRLmqFYdyXmSmoSgKq
 Q4uQDTiXFLPUq/tK8OVaqwtH0Cs0pXVnaYPabrdqKD+W/TFdcGARptPMIfD7N4XhSL6kefoxH98
 4AsA4ZNhyGs/JHgqNiF3enHrBgndgzK7mF0XEaEmNRbGJTjLqRTmpjqWprpgqlHQe2s=
X-Google-Smtp-Source: AGHT+IGnowSuP4RfWbC52w7fhDGH6mhT3aD9QWHHx2BjxLa24jmCqdv5e7Uu9BWVbJyKB2QrXcBAhA==
X-Received: by 2002:a05:622a:5a93:b0:476:aa36:d674 with SMTP id
 d75a77b69052e-4771ddd216dmr90953451cf.28.1742608040995; 
 Fri, 21 Mar 2025 18:47:20 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.20
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:20 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/18] drm/amdgpu: make GFX6 easier to read
Date: Fri, 21 Mar 2025 21:46:54 -0400
Message-ID: <20250322014700.62356-13-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
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

Just fix the style and add a comment for reading easiness

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 5f85c3b63971..f34980c79a7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1731,10 +1731,14 @@ static void gfx_v6_0_constants_init(struct amdgpu_device *adev)
 	gfx_v6_0_get_cu_info(adev);
 	gfx_v6_0_config_init(adev);
 
-	WREG32(mmCP_QUEUE_THRESHOLDS, ((0x16 << CP_QUEUE_THRESHOLDS__ROQ_IB1_START__SHIFT) |
-				       (0x2b << CP_QUEUE_THRESHOLDS__ROQ_IB2_START__SHIFT)));
-	WREG32(mmCP_MEQ_THRESHOLDS, (0x30 << CP_MEQ_THRESHOLDS__MEQ1_START__SHIFT) |
-				    (0x60 << CP_MEQ_THRESHOLDS__MEQ2_START__SHIFT));
+	WREG32(mmCP_QUEUE_THRESHOLDS,
+		((0x16 << CP_QUEUE_THRESHOLDS__ROQ_IB1_START__SHIFT) |
+		(0x2b << CP_QUEUE_THRESHOLDS__ROQ_IB2_START__SHIFT)));
+
+	/* set HW defaults for 3D engine */
+	WREG32(mmCP_MEQ_THRESHOLDS,
+		(0x30 << CP_MEQ_THRESHOLDS__MEQ1_START__SHIFT) |
+		(0x60 << CP_MEQ_THRESHOLDS__MEQ2_START__SHIFT));
 
 	sx_debug_1 = RREG32(mmSX_DEBUG_1);
 	WREG32(mmSX_DEBUG_1, sx_debug_1);
-- 
2.48.1

