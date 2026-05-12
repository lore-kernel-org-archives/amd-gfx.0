Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93004CD4F35
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 07:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A698310ED23;
	Wed, 13 May 2026 07:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="Z/SusmNw";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C453D10E215
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 14:01:53 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2f53c6af46eso386892eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778594513; x=1779199313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vlzeRCGXQHDoiU445JgrUjhM/Fxu9dKmbf7Dmmy0kyk=;
 b=Z/SusmNwF31P68pAKe2k8W39rXvuugNryDxWSPItsAOlULDYvjhtdgeCXh1UgGxYXx
 x2X9VsX5DcGWBGGl7l0EQquK+Xbxd7Tlbg8x1z79MkheyYwT4z6pLFp4mBbaHkEcrh7m
 TB/4d47gidyqXO2ZfNmYX0QZ9D5sLnk0M6n81e90Zt3zRg9FTFgQGQ49nmR/xyKPQ11L
 mOb/2djxdwlvkTWL5GDdqG2Jcgm6RjWQrGGS4+DWsU0sWU1pC/gWNM+9Um6rVFvem/FA
 PpAIPKHN/XsmfnUr1SfcilmtbrnjaB2l+597mloAM8oVnuo3Qn409vgCDNvrADfOxkQo
 0/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778594513; x=1779199313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlzeRCGXQHDoiU445JgrUjhM/Fxu9dKmbf7Dmmy0kyk=;
 b=muwHyvTrEkR65z3ZJ0Nw5l6EPSB1Rxo2oDCmxFiOmttZaBuMdTC0uLUuH+W1En48yU
 6b6LQDNO1KjIwyrAlxaQouXVoyUR4XD7rlnEbwf/v56CwGq56D/N6Fap6+6kOht8zwl+
 SD0EtYl9hW3GWy+d8jJW8O94DhlW8+ltLOuTQhphYZlRABg+CZltM7RQvLZMnrqZDrP2
 Vnzf3w+IBow8pohjOdN7sveI2Si2m3uH2G27bHVIr/b3ccW+b80tLmFLYw9FTL1lISy+
 K1zb0dG481qCAGUo6fH9ULzdBKlA6NMuVN1DGFge05uSr3po0kqzBYzNzolD+c2ngvXB
 Ckdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dbogy7qhxjK5jv+3sS20mmIImMnzm8v0LZZzn40Cu06yAWH+xGrXZgnxa4lRYhvv+Xm19DFJJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrrIDNycRgo0ggTS9rGkmTv2cyUnH3DWUI60KtyRC43fJaJd06
 z9Jqo3lplReduCsLQrB/5Tudnul7S/YNUmE5TE/yN87t681O/VChnRevEU1jxGtM14Q=
X-Gm-Gg: Acq92OHlNAxo02Q4A7I6Xn0LYwInl00JoecVuArE6YH6QEoRHR0aWecIwE0qG1zcDHu
 aMiht2/Nftjl8ah1lxirdDUCbKlLOlazCtKvkYQnxkv1Uufz0yA7vF3TTOGyjeY0rJM36CQokGk
 PxAQpYqrHZNQyWKS5efnmGFWPntK9x0dDJ8vT8gUfqurIHq+YRQ0ldGrPNhhrDQczluz5MYKY/L
 JjV3HjANLCVbYwfwSxLUaokWx5exhhhF1K16u2VLYau1E5xH3KFGNNT3qtvN0LJXvpaFYKieqUs
 PPPDZMH28zB/W9BGthtw/tPHksPKIU3keZY99O71k/OTL9Ca3I+e0HlMy4eYp+6oq+V5/uHswN5
 yDdQ6idxrJqu8QFaX8+pO+y0CiPMx1L4mFcwKq4FvtqSonQEAD6zp29Luye7p49yee0DP2L5KJ1
 9+cUK7+NNTwzTBIqy/rKO6+3zMjGAWTNoftLRJRI6blAiPK0cuIA==
X-Received: by 2002:a05:693c:2c02:b0:2d4:62f0:b2e1 with SMTP id
 5a478bee46e88-2f564430643mr5786104eec.0.1778594512263; 
 Tue, 12 May 2026 07:01:52 -0700 (PDT)
Received: from Haru.. ([2804:1b1:f980:4df5:7d73:b89a:b932:2c0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm22377608eec.23.2026.05.12.07.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:01:51 -0700 (PDT)
From: Leonardo Cesar <leonardocesar@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Leonardo Cesar <leonardocesar@usp.br>, kernel test robot <lkp@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix inconsistent indenting in
 amdgpu_gfx_ring_preempt_ib
Date: Tue, 12 May 2026 11:01:29 -0300
Message-ID: <20260512140142.6610-1-leonardocesar@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:56:32 +0000
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

Fixes a whitespace indentation issue reported by the smatch static
checker tool.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605081621.Euvx7ORX-lkp@intel.com/
Signed-off-by: Leonardo César <leonardocesar@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f7ebead09..d213a0cdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2725,7 +2725,7 @@ int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
 	}
 
 	/* deassert preemption condition */
-    amdgpu_ring_set_preempt_cond_exec(ring, true);
+	amdgpu_ring_set_preempt_cond_exec(ring, true);
 
 	if (i >= adev->usec_timeout) {
 		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
-- 
2.43.0

