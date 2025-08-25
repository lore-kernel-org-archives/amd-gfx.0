Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898CECA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 00:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8548310E226;
	Mon, 25 Aug 2025 00:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lC/FBdKJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FDDF10E226
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 00:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5cm4ZlFPff2FAtv2mdQBNSTJFoMiekuhqO56f8Y7mxA=; b=lC/FBdKJoqo6sXaiTjpG8r7sKR
 WCJSkjeIjhKfh+wLPnzEB44tc+l2dl0wPPZ3k6w75RadJflDWC6CzPUOHMXlCIPmrM91h8lbLMf7x
 GLNsGGPLe9Fdv1GfC4OVu8gXN4/vU1Yg5d8TuapdcwgKXMFpmzGGNA+xP0u1sfq7k0XDYpvWv4Xi8
 js/ES4OCRIc5zHMpS4+iLZuWyGUp0jaYbbISfZDbFEkvBmxcNuPHszcTKttzYi1SBG21IbQjc53mm
 3gqwNQJPF1nXTLZc2wMdJYeDwJVweaccRgPHYphQvNFi/jvfFLIcvyHJVW4lNOP0gaut89oQws2W0
 mor3yR9Q==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uqLNh-001AML-BG; Mon, 25 Aug 2025 02:48:17 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v2 2/2] drm/amdgpu/vcn: Change amdgpu_vcn_sw_fini return to
 void
Date: Sun, 24 Aug 2025 18:46:41 -0600
Message-ID: <20250825004800.3851474-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825004800.3851474-1-siqueira@igalia.com>
References: <20250825004800.3851474-1-siqueira@igalia.com>
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

The function amdgpu_vcn_sw_fini() returns an integer, but this number is
always 0. This commit changes the amdgpu_vcn_sw_fini() return to void,
and eliminates all checks to this return across different VCNs.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 9 +++------
 11 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c18..4ceb67febaae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -257,12 +257,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 	return 0;
 }
 
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
+void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 {
 	int j;
 
 	if (adev->vcn.harvest_config & (1 << i))
-		return 0;
+		return;
 
 	amdgpu_bo_free_kernel(
 		&adev->vcn.inst[i].dpg_sram_bo,
@@ -292,8 +292,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 
 	mutex_destroy(&adev->vcn.inst[i].vcn_pg_lock);
 	mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
-
-	return 0;
 }
 
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b3fb1d0e43fc..e2911eb915ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -516,7 +516,7 @@ enum vcn_ring_type {
 
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i);
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i);
+void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
 int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index c74947705d77..66dc3b5d01eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -230,11 +230,11 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	jpeg_v1_0_sw_fini(ip_block);
 
-	r = amdgpu_vcn_sw_fini(adev, 0);
+	amdgpu_vcn_sw_fini(adev, 0);
 
 	kfree(adev->vcn.ip_dump);
 
-	return r;
+	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index b115137ab2d6..c4e2659f8933 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -267,9 +267,9 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 
-	r = amdgpu_vcn_sw_fini(adev, 0);
+	amdgpu_vcn_sw_fini(adev, 0);
 
-	return r;
+	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 3a7c137a83ef..748351e2da7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -465,9 +465,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 		r = amdgpu_vcn_suspend(adev, i);
 		if (r)
 			return r;
-		r = amdgpu_vcn_sw_fini(adev, i);
-		if (r)
-			return r;
+		amdgpu_vcn_sw_fini(adev, i);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 95173156f956..a615d6a0a698 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -349,9 +349,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		r = amdgpu_vcn_sw_fini(adev, i);
-		if (r)
-			return r;
+		amdgpu_vcn_sw_fini(adev, i);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1785786a72f8..7e425cda388f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -302,11 +302,8 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		r = amdgpu_vcn_sw_fini(adev, i);
-		if (r)
-			return r;
-	}
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		amdgpu_vcn_sw_fini(adev, i);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index bae1ad4484ed..5fbd755fc24c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -283,11 +283,8 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		r = amdgpu_vcn_sw_fini(adev, i);
-		if (r)
-			return r;
-	}
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		amdgpu_vcn_sw_fini(adev, i);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 75c884a8f556..514c4e7e806e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -270,9 +270,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		r = amdgpu_vcn_sw_fini(adev, i);
-		if (r)
-			return r;
+		amdgpu_vcn_sw_fini(adev, i);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 455f829b8bb9..92da911a5e4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -232,11 +232,8 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		r = amdgpu_vcn_sw_fini(adev, i);
-		if (r)
-			return r;
-	}
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		amdgpu_vcn_sw_fini(adev, i);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 7cb21e2b4eb0..b8097718882c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -245,14 +245,11 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		r = amdgpu_vcn_sw_fini(adev, i);
-		if (r)
-			return r;
-	}
-
 	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		amdgpu_vcn_sw_fini(adev, i);
+
 	return 0;
 }
 
-- 
2.47.2

