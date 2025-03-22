Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49707C36007
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 18:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4A010E154;
	Sat, 22 Mar 2025 18:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GpTFWvzk";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D540E10E154
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 18:37:55 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7c59e7039eeso427578685a.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668675; x=1743273475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=maO3oc1cWfyDp8XRSrISoZXYCsHuY79X82z8MOKcUU4=;
 b=GpTFWvzk6ch42LGF3TOw5PeaClKTyhE0PBt7e3pKHpvQTwx/73hVfy7wLOsO2jtmCO
 IryNBsv5cENLsUQToKGfwB+jAnII7Nd6VIzblsICfpvdCoLZMcBD0Jy8aIbZpSqTTKdJ
 6HL+YBBIn31XbdAOg0oTnaMu+RRaiqpzGQBb0FDznvI1pIYpHEabKxz5w0OGJhXvh5Bq
 oEZ2uxwOCkY7xMVQnzNlmfNP+2lAHCcYhXu25n5DKAq7W1XwqxaH7uQ6tDJ5kYJQODSV
 uljjm86bzMreS8INyiR/ji6URIWrIdL+e22AbMfz1X4xlOoYgN/u/OENYCQLd5Wi/6A+
 jYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668675; x=1743273475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maO3oc1cWfyDp8XRSrISoZXYCsHuY79X82z8MOKcUU4=;
 b=nnGtAaln0cHTLr6xIYt7Jd4VSPffc8mhFmFJBtU0/s2g2Xsoo3bGrBiuQTCAS4eDPE
 hzartepQEOT1G9heXxoL5NT5vgsAh4rcUXEky3uVMFUgKITbS9nlSGIUnjsuBtAXKLZT
 xwHfeejWwH2M07V9QEgoYjzgGLkDdZ7L+55yAi1LvCBGkFaSKJufESBXawSvQAOECJ8M
 HO2e9vARmSC4PhaKAeNdCG1ZSYBHZFAXmdI8sUMwOEk3rUtIE6YU6AtoisGn12zPphlQ
 sgcgQkhjlzEiuIO0FTAA8mcVt/Lb3jxBwK5lhIG3AcEXgMMv7VrwG0VD+iEiCw8J/05B
 IKiw==
X-Gm-Message-State: AOJu0Yy3t8/wJJtssP/PUcNSN4LTQuoqSW7vdTWKNN+7FmdRWi87aP/c
 u83k64COYocXbU5bb6LdWL1tVV3NRl+VlanWAuw67eKpaVkxe2IWosvj0A==
X-Gm-Gg: ASbGncvMA/eqpsofJdvEZeNIFxeux/SxLwCpVsBfjX5vaJGJso0PYdcFhY+ms595Ok8
 QiN787P7nIb2Y4mW/s417cnyK50LLzfxAc1mj3fZSo9nDngtgXNYZZSIr4YYJxVPXTFHdAs5NBH
 0rQ26clG6EH46j29q6rPmwcELbg90SscFOWzW/LRwTizmw5T3z9Bd2C/Dq4mUO4QKjIiZ6uFb2A
 NiKMbld1eSPM1o9UJbIC/HD6+7ZfnBiIgqXdFMjRFhiw2EIIX0m0dVYvMOYeFbLGoaaWCIFfIRy
 BOKl3+DS+RjgZfTjTVL4z1E+vJJAL7p0LIds2ZwuI6eCfkQN8o3mM12GErt6CcBE19I=
X-Google-Smtp-Source: AGHT+IH4HOhk5g3YUDLZi2OHx6FszwWAcPqhNkP9s2kdXlMKLhz7RyCM3Ad/uTwpe7QsAmVlTgdPwQ==
X-Received: by 2002:a05:620a:394a:b0:7c5:5768:40b3 with SMTP id
 af79cd13be357-7c5ba1de27amr1167950785a.45.1742668674566; 
 Sat, 22 Mar 2025 11:37:54 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec688sm279895085a.64.2025.03.22.11.37.53
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:37:54 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: use gmc_v7_0_is_idle() since it is available
 under GMC7
Date: Sat, 22 Mar 2025 14:37:42 -0400
Message-ID: <20250322183746.86002-2-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
References: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
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

gmc_v7_0_is_idle() does exactly what we need, so use it.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index b6016f11956e..1a8df3caedb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1156,17 +1156,10 @@ static bool gmc_v7_0_is_idle(void *handle)
 static int gmc_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned int i;
-	u32 tmp;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		/* read MC_STATUS */
-		tmp = RREG32(mmSRBM_STATUS) & (SRBM_STATUS__MCB_BUSY_MASK |
-					       SRBM_STATUS__MCB_NON_DISPLAY_BUSY_MASK |
-					       SRBM_STATUS__MCC_BUSY_MASK |
-					       SRBM_STATUS__MCD_BUSY_MASK |
-					       SRBM_STATUS__VMC_BUSY_MASK);
-		if (!tmp)
+		if (gmc_v7_0_is_idle(adev))
 			return 0;
 		udelay(1);
 	}
-- 
2.49.0

