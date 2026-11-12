Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACA606A323
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uTovLjrJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D310B11213D;
	Thu, 12 Nov 2026 13:56:07 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F99112037
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 11:42:10 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c445c95d553so54584066b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 03:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794483729; x=1795088529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iiTq5jxGUFxvsq1kUCHUV3RAjcxHJF+gW2Fj5QoC1YA=;
 b=uTovLjrJrt2bc70j6rcCDD4yj3VCF+RIsCUUvMHX/RzV6lS2O9B47Nto4A99omFCzW
 0L6K3OmED3IHCTDqG7vMOxqIoe6vn5+3sy/bA6ZPTEctkwOLDyx6ggc+xbiu13nNa6Sm
 PzaS3M80fJGIx4tJoAy1MHFJwKbpd55IzjNEYFuAs20NtLqtUdfO6MNMBhKBYs7fEJ/W
 c9ziPwy8UmceTkeUhltHxr4k/1nPOo/j5DiewIZDQfpuNTdVvUVObXHNZ+0Zf4C4K0rE
 9cLUK0D8lTDskyZROy4N/V8bPVfsL6nYbbsuVruZCrVmpgR2D1SfeQmkTPHoEFeG2Xqf
 bYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794483729; x=1795088529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iiTq5jxGUFxvsq1kUCHUV3RAjcxHJF+gW2Fj5QoC1YA=;
 b=UAzMh29F7Aj3E0amsmqUjmRAo6ByAZvcaFKj+Zr9CsOw7oRIDv2f5B1/i2/Kyvpi5h
 0RMpEBMoQNytXrK1TtatD0yW8AytZBy2D/pT4qGZNjQzvyLDB/evHfDcZYxRwlWfoLl5
 evw1uf/qiLli76qMx4R5LBV/X0nw4oiHmxX34jaRPT/6heZgs/Qc/BcnszkDf0Sf7LWw
 vEpzU9bAt0aHdmQaS3zdM1smKWzQxCtAzCLsyoEMO+0Axe1RIzxw5vhXn4VGjsp3O2WD
 G/nPeT61lXLXFaYfzWliU+E4Hsy7J9MncuLNZWSFpTU8EdBwcGWqeHgzoSPf3BnOwYFW
 YzDA==
X-Gm-Message-State: APuU4Z96jkUl8fn5pWr2r+OFnZRhkdqPna+Rm62gjp8K7HO424tpzMMB
 niXnk0/ErI1dCmZTSebuNOqJL5o3mPSgP+Gs9nAwqusITEfXO+OepfgRbbwCVBMq
X-Gm-Gg: AYBFou3I2jSv/rxQCmY4xqJ/MFs+AEItSmK2fr0xOwksC4p7xm11au+fyqCjWOy7Ob/
 NcfouYqH+x7qOvV/S8TyHthBZaR5UYfjKbZynUVQ8ewFeGSHHGkTnhMf6VwuKqpwI3ICmh270hg
 PInrONbWZYqneqXlMkq9kRtIjPjgyZtyPDBl/IuBqmJLlZU+Lh9TDdY6s0PrdUmdxORBqA6vtqK
 MbUk6CNAUzkfFq9co0PFs0F5vXjvTE+5jVANQoi0Al9RpUR4rYstKva+dm1a0EGt5Uxc7i4EBtN
 6mjtL5MHjOEWA7VCVvWb2e0tZxVsAQ2KyGn6RgJFIiNdWy2sUeWiatono+aN6vFYfRAsk7zCC0l
 5MdBbOX+n7k4ZrUC7Es+spOcOd5ZBWOle96gt+vm6s9ldg95mnPRWpo/wEkWO1XBi+mJQeqr6oB
 /c6mdLK4AjsMgCU4Glb/ATuevufMF9HTyxi9IK80eXdgYhUyQM/tMoCLlAYmrzX0vkipeRvJmxO
 SmTBAqQHCyX4JlE8sW9xGXWTcbfwrvCR++ywUZJsxVcQYC76RkG2u/n/x53ibPzXvqQ7dHDjqmV
 GPC9s2wXjzwziMH2KmU/UaU822Wz/cGffAseU83AUV8xt/Qzg70jpTg0+oUXGWbxwE1wtJrXnhU
 0HcV/UkANf5gB70CTotXwiiPGUPfLEYh2Suxb8UxJgTlxmAOY7DmkUfQEnax6spgrgNk0cnDUHE
 FfFXKitbbxveox4EJ+g77Yl6PUONFAcBvtViFNKP8JIPk5tc0gflGg94MrQkhc4JH81x86EzHfG
 +MeOZTFphMNmROHas6jC1ub27mJ4RPvYKu+/05eySKVPRNmHNYyK3/94y8bGy1Dm4TyeSjc4QMG
 ALR+8wGvmQm/uS82geBf/MplGTd6DwmM0A6PmzXc6K4TUAOE3XX1SDUvLInwCQHIIY4qZ4XpDCB
 AQ3v0i5fhl5Tn2vf4LpLISA==
X-Received: by 2002:a17:907:96a5:b0:c41:e75e:5889 with SMTP id
 a640c23a62f3a-c5066b5bba0mr436488366b.33.1794483728981; 
 Thu, 12 Nov 2026 03:42:08 -0800 (PST)
Received: from albatros (ip-091-065-217-039.vkd74.pools.vodafone-ip.de.
 [91.65.217.39]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a3a6bc5sm337618166b.3.2026.11.12.03.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 03:42:08 -0800 (PST)
From: Erhan Bilgili <erhan.bilgili@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, jesse.zhang@amd.com,
 Erhan Bilgili <erhan.bilgili@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix UserQ slot availability checks
Date: Thu, 12 Nov 2026 12:40:49 +0100
Message-ID: <20261112114049.327046-1-erhan.bilgili@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:56:07 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The compute and DMA queries check each other's disable_uq flags.
When the flags differ, this can hide available slots or report slots
for disabled UserQs.

Check gfx.disable_uq for compute and sdma.disable_uq for DMA.

Fixes: 78d0a27ae0e2 ("drm/amdgpu: Add user queue instance count in HW IP info")
Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 14a72a406d37..c026a07bc050 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -474,7 +474,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			    !adev->gfx.compute_ring[i].no_user_submission)
 				++num_rings;
 
-		if (!adev->sdma.disable_uq) {
+		if (!adev->gfx.disable_uq) {
 			for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
 				num_slots += hweight32(adev->mes.compute_hqd_mask[i]);
 		}
@@ -489,7 +489,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			    !adev->sdma.instance[i].ring.no_user_submission)
 				++num_rings;
 
-		if (!adev->gfx.disable_uq) {
+		if (!adev->sdma.disable_uq) {
 			for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
 				num_slots += hweight32(adev->mes.sdma_hqd_mask[i]);
 		}
-- 
2.56.1

