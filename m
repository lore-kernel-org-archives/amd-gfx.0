Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84322CD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2178010F0DD;
	Wed, 17 Jun 2026 19:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YG6qRehA";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE8810F0CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:46 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-460166910e6so106640f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723685; x=1782328485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjFh587+4DmAa5bxDGxN9fBvDXxHsUivWEAyVQMvmno=;
 b=YG6qRehAcvje6VZ8TZJqWB/1UrdKs21mkRrw8OimLlDNphsPt81Wz0q6t46upkjkye
 4uVsTQKFMNn7R6iGW2qE0720eo8FL3aZM4jfvBX0vBHoGWV8ymg/mWlTIQtZ7wgfEtye
 JOaudB8LsJ3KeHknFYopOfQOyL6KNQfS/mVMDRkoHLSg0c/8YwduxvvNQvcg6x9KZSKg
 REIX97Amm348rvBMRKhsb8RFqpWN1fz+pxLx5T0PXKPi0SwruvYty5OwUzrjVcKxq+TX
 Bl/dxM50xAidhq3wZqJ9i3DDu4xWuUTP4qd5JvOoxmOTubNXqgOmHzqexkis+MbBSC42
 t9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723685; x=1782328485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fjFh587+4DmAa5bxDGxN9fBvDXxHsUivWEAyVQMvmno=;
 b=EEJyKbko+b74k9vbj3ENZTt8uW4k3JDtP6I8KRB2a7F5KMtyeEbOBaofeD7nalrHPp
 lZ2zpch1gVkYi+3JtIGBUWJdGa1u3sXhOKhKrLNs+UTYCgYZsT1SMtEOJgaWYXXFHiw8
 2LQ6BlqxqYKwWB/dz3j4bEnCoG9+KGKYiRp+FSi43ZTlsD3ekIM8B8Og8jJVLLptBOAj
 4B1af+KPIcROsHxsZc+vZ9GIF3Y7j4G7kHRGNW6Z8KsGIGKkNfSFCeyZDh7iH2Y7DMC0
 bnmoftwGxGEO1qgQYiaViJNU+HZGPbn5J+OgDCjemIYxjxwn52h0Y47hHD7iOy2AoZY7
 xOTA==
X-Gm-Message-State: AOJu0YzVUcwJ2IH/xRc5PS0HFR+Ug9inlIFQyqWmKO7jsL6CnLqFUxVy
 rGGXKRrIbwc9Dc0i8NosUaGdPk3hRGI1OmNJwuFfUoArD/9KosO+G2VKyXlk5Q==
X-Gm-Gg: Acq92OEcaNAuGI7CmnVkYE1jhiDSRnIsahuAs3P8dVXiyksgemjjXvyih+gBgugd9ZJ
 jleBt4oQdhE2rZx3rJtNZnxZztBP9tw8oOJCPgsFTFNxJ21DzuLjhV0GhUMWRWdzP8VT78e/RtJ
 Ht5ndF0X9U3zy5NQ37F/qsslknOo+fpvJtlbXWKfZBDrVn4+gHqOyFgfw1xyVnI7lxyVhWIZxNh
 5WMPvg1Rkia1rGYxkQIbzJ5bPk+QJAmQCKgg912COgFVTIag7js+CvkPnDiEQKVJS5y4nc2Lukn
 K66ka97rltajU6oDJQ5urmbPaek0bFHD9m+IZQcGrpSY2O+lSwd4yxNTwYRtKAoigDPgW0Ly7QR
 merOk7wMs1kNOO3YBirdJsqRCsXBHw+3wP8BW+OtUWQUw9GC+Jg9c+kCCGV+kOuJXG+H2ueJQDk
 SZvaBB6PDxiHjh2X2FhVQ6gFtCEcJDRckDnBLiu2g/udutJhhTK/Fnkg==
X-Received: by 2002:a7b:c3da:0:b0:490:9d1b:f086 with SMTP id
 5b1f17b1804b1-492381f0798mr8827165e9.14.1781723684671; 
 Wed, 17 Jun 2026 12:14:44 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:44 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 11/17] drm/amdgpu: Add IP block soft reset as a GPU recovery
 method
Date: Wed, 17 Jun 2026 21:14:22 +0200
Message-ID: <20260617191428.1784083-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617191428.1784083-1-timur.kristof@gmail.com>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
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

Implement IP block soft reset as a recovery method that fits into
the current GPU recovery code as opposed to being hacked into the
full GPU reset code path.

This can gracefully handle GPU hangs when other reset methods
are not available or have failed. It makes sure to minimize
collateral damage (ie. affected non-guilty jobs) and does a
backup and restore on all affected queues.

Note that some of the new helpers may be useful for other
reset types as well, which we can explore later.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c   | 154 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h   |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 171 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   5 +
 7 files changed, 355 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7c5ca9e44d54..cf216af827bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -307,6 +307,7 @@ extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
 #define AMDGPU_RESET_TYPE_SOFT_RECOVERY (1 << 1) /* soft recovery, eg. kill shaders */
 #define AMDGPU_RESET_TYPE_PER_QUEUE (1 << 2) /* per queue */
 #define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per pipe */
+#define AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET (1 << 4) /* soft-resets an IP block */
 
 /* max cursor sizes (in pixels) */
 #define CIK_CURSOR_WIDTH 128
@@ -1133,6 +1134,7 @@ struct amdgpu_device {
 	bool                            debug_vm_userptr;
 	bool                            debug_disable_ce_logs;
 	bool                            debug_enable_ce_cs;
+	bool                            debug_disable_ip_block_soft_reset;
 
 	/* Protection for the following isolation structure */
 	struct mutex                    enforce_isolation_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 53aa2d438da5..5ab9f847f9e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -146,7 +146,8 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_SMU_POOL = BIT(7),
 	AMDGPU_DEBUG_VM_USERPTR = BIT(8),
 	AMDGPU_DEBUG_DISABLE_RAS_CE_LOG = BIT(9),
-	AMDGPU_DEBUG_ENABLE_CE_CS = BIT(10)
+	AMDGPU_DEBUG_ENABLE_CE_CS = BIT(10),
+	AMDGPU_DEBUG_DISABLE_IP_BLOCK_SOFT_RESET = BIT(11),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2291,6 +2292,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: allowing command submission to CE engine\n");
 		adev->debug_enable_ce_cs = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_IP_BLOCK_SOFT_RESET) {
+		pr_info("debug: IP block soft reset disabled\n");
+		adev->debug_disable_ip_block_soft_reset = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 6aa54156bbc9..65505bc50399 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -409,3 +409,157 @@ bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 
 	return false;
 }
+
+/**
+ * amdgpu_ip_from_ring() - Find IP block type corresponding to ring type.
+ *
+ * @ring_type: The ring type whose IP block you are looking for.
+ */
+static enum amd_ip_block_type amdgpu_ip_from_ring(const enum amdgpu_ring_type ring_type)
+{
+	switch (ring_type) {
+	case AMDGPU_RING_TYPE_GFX:
+	case AMDGPU_RING_TYPE_COMPUTE:
+		return AMD_IP_BLOCK_TYPE_GFX;
+
+	case AMDGPU_RING_TYPE_SDMA:
+		return AMD_IP_BLOCK_TYPE_SDMA;
+
+	case AMDGPU_RING_TYPE_UVD:
+	case AMDGPU_RING_TYPE_UVD_ENC:
+		return AMD_IP_BLOCK_TYPE_UVD;
+
+	case AMDGPU_RING_TYPE_VCE:
+		return AMD_IP_BLOCK_TYPE_VCE;
+
+	case AMDGPU_RING_TYPE_VCN_DEC:
+	case AMDGPU_RING_TYPE_VCN_ENC:
+		return AMD_IP_BLOCK_TYPE_VCN;
+
+	case AMDGPU_RING_TYPE_VCN_JPEG:
+		return AMD_IP_BLOCK_TYPE_JPEG;
+
+	case AMDGPU_RING_TYPE_VPE:
+		return AMD_IP_BLOCK_TYPE_VPE;
+
+	default:
+		return AMD_IP_BLOCK_TYPE_NUM;
+	}
+}
+
+/**
+ * amdgpu_ring_mask_from_ip() - Find mask of ring types corresponding to an IP block type.
+ *
+ * @ip_type: The IP block type whose rings you are looking for.
+ */
+static u32 amdgpu_ring_mask_from_ip(const enum amd_ip_block_type ip_type)
+{
+	switch (ip_type) {
+	case AMD_IP_BLOCK_TYPE_GFX:
+		return BIT(AMDGPU_RING_TYPE_GFX) | BIT(AMDGPU_RING_TYPE_COMPUTE);
+
+	case AMD_IP_BLOCK_TYPE_SDMA:
+		return BIT(AMDGPU_RING_TYPE_SDMA);
+
+	case AMD_IP_BLOCK_TYPE_UVD:
+		return BIT(AMDGPU_RING_TYPE_UVD) | BIT(AMDGPU_RING_TYPE_UVD_ENC);
+
+	case AMD_IP_BLOCK_TYPE_VCE:
+		return BIT(AMD_IP_BLOCK_TYPE_VCE);
+
+	case AMD_IP_BLOCK_TYPE_VCN:
+		return BIT(AMDGPU_RING_TYPE_VCN_DEC) | BIT(AMDGPU_RING_TYPE_VCN_ENC);
+
+	case AMD_IP_BLOCK_TYPE_JPEG:
+		return BIT(AMDGPU_RING_TYPE_VCN_JPEG);
+
+	case AMD_IP_BLOCK_TYPE_VPE:
+		return BIT(AMDGPU_RING_TYPE_VPE);
+
+	default:
+		return 0;
+	}
+}
+
+/**
+ * amdgpu_filter_rings() - Filter rings according to a mask.
+ *
+ * @adev: amdgpu_device pointer
+ * @ring_type_mask: Mask of ring types you are looking for
+ * @out_rings: Array of rings which is going to be filled
+ * @out_num_rings: Number of rings which were filtered
+ */
+static void amdgpu_filter_rings(struct amdgpu_device *adev, const u32 ring_type_mask,
+				struct amdgpu_ring **out_rings, u32 *out_num_rings)
+{
+	u32 num_rings = 0;
+	int i;
+
+	for (i = 0; i < adev->num_rings; ++i) {
+		if (BIT(adev->rings[i]->funcs->type) & ring_type_mask)
+			out_rings[num_rings++] = adev->rings[i];
+	}
+
+	*out_num_rings = num_rings;
+}
+
+/**
+ * amdgpu_device_ip_soft_reset() - Perform a graceful soft reset on an IP block.
+ *
+ * @guilty_ring: The ring which is guilty of causing a reset.
+ * @guilty_fence: The fence which didn't signal.
+ *
+ * IP block soft reset is used when attempting to recover
+ * from a GPU hang in a situation where a more fine grained
+ * reset type isn't available or didn't work. This effectively
+ * resets all rings that belong to the same device IP block
+ * and re-initializes the device IP block.
+ *
+ * The reset is handled gracefully, meaning that we try to
+ * minimize collateral damage (ie. avoid rejecting non-guilty jobs)
+ * as well as back up and restore the contents of all rings
+ * so that the system can move on from the hang.
+ */
+int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
+				struct amdgpu_fence *guilty_fence)
+{
+	struct amdgpu_device *adev = guilty_ring->adev;
+	struct amdgpu_ring *rings[AMDGPU_MAX_RINGS];
+	struct amdgpu_ip_block *ip_block;
+	enum amd_ip_block_type ip_type;
+	u32 num_rings, ring_type_mask;
+	int r;
+
+	ip_type = amdgpu_ip_from_ring(guilty_ring->funcs->type);
+	ip_block = amdgpu_device_ip_get_ip_block(adev, ip_type);
+
+	if (!ip_block || !ip_block->version->funcs->soft_reset) {
+		dev_warn(adev->dev, "IP block soft reset not supported on %s\n",
+			 ip_block->version->funcs->name);
+		return -EOPNOTSUPP;
+	}
+
+	dev_err(adev->dev, "Starting %s IP block soft reset\n",
+		ip_block->version->funcs->name);
+
+	ring_type_mask = amdgpu_ring_mask_from_ip(ip_type);
+	amdgpu_filter_rings(adev, ring_type_mask, rings, &num_rings);
+
+	amdgpu_device_lock_reset_domain(adev->reset_domain);
+	amdgpu_multi_ring_reset_helper_begin(rings, num_rings, guilty_ring, guilty_fence);
+
+	r = ip_block->version->funcs->soft_reset(ip_block);
+
+	r = amdgpu_multi_ring_reset_helper_end(rings, num_rings, guilty_ring, r);
+	amdgpu_device_unlock_reset_domain(adev->reset_domain);
+
+	if (r) {
+		dev_err(adev->dev, "Failed %s IP block soft reset: %d\n",
+			ip_block->version->funcs->name, r);
+		return r;
+	}
+
+	dev_err(adev->dev, "Successful %s IP block soft reset\n",
+		ip_block->version->funcs->name);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 1d0df6d93957..d0fc21e4f2b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -84,6 +84,9 @@ enum amd_hw_ip_block_type {
 #define IP_VERSION_SUBREV(ver) ((ver) & 0xF)
 #define IP_VERSION_MAJ_MIN_REV(ver) ((ver) >> 8)
 
+struct amdgpu_ring;
+struct amdgpu_fence;
+
 struct amdgpu_ip_map_info {
 	/* Map of logical to actual dev instances/mask */
 	uint32_t dev_inst[MAX_HWIP][HWIP_MAX_INSTANCE];
@@ -150,5 +153,7 @@ bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
 			    enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			       enum amd_ip_block_type block_type);
+int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
+				struct amdgpu_fence *guilty_fence);
 
 #endif /* __AMDGPU_IP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ce3c209a6ba7..b5c2d1d4d883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -151,6 +151,17 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 
+	/* Attempt an IP block soft reset, if supported. */
+	if (amdgpu_gpu_recovery &&
+	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET)) {
+		r = amdgpu_device_ip_soft_reset(ring, job->hw_fence);
+		if (!r) {
+			atomic_inc(&ring->adev->gpu_reset_counter);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
+			goto exit;
+		}
+	}
+
 	if (dma_fence_get_status(&s_job->s_fence->finished) == 0)
 		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 80fbbcbe2d84..8062135e73a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -881,6 +881,177 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	return 0;
 }
 
+/**
+ * amdgpu_multi_ring_reset_helper_begin() - Prepare multiple rings for a reset.
+ *
+ * @rings: Pointer to an array of amdgpu rings that are affected.
+ * @num_rings: Number of rings in the array.
+ * @guilty_ring: The ring which is guilty of causing a reset.
+ * @guilty_fence: The fence which didn't signal on the guilty ring.
+ *
+ * Useful when performing a GPU reset method that affects
+ * multiple rings at the same time, such as an IP block soft
+ * reset. For example, a GFX IP block soft reset will affect
+ * every graphics and compute queue.
+ *
+ * This function should be called before such a reset.
+ *
+ * Prepare the affected rings before the reset, make sure to
+ * minimize collateral damage, and backup the contents of
+ * the rings. Then the caller can call the actual HW specific
+ * reset function.
+ *
+ * After the reset is complete, the caller should then call
+ * amdgpu_multi_ring_reset_helper_end() to restore the rings.
+ */
+void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_ring **rings, u32 num_rings,
+					  struct amdgpu_ring *guilty_ring,
+					  struct amdgpu_fence *guilty_fence)
+{
+	struct amdgpu_device *adev = guilty_ring->adev;
+	struct amdgpu_fence *ring_guilty_fence;
+	struct amdgpu_ring *ring;
+	bool rings_busy;
+	int i;
+	u32 t;
+
+	for (i = 0; i < num_rings; ++i) {
+		ring = rings[i];
+
+		/* Don't accept new submissions on the ring. */
+		if (amdgpu_ring_sched_ready(ring) && !drm_sched_is_stopped(&ring->sched))
+			drm_sched_wqueue_stop(&ring->sched);
+
+		/*
+		 * Clear the preempt condition to stop the ring
+		 * from starting its next submission. This ensures
+		 * that only the currently executing submission
+		 * can be rejected because of the reset and helps
+		 * minimize collateral damage.
+		 */
+		if (ring->funcs->init_cond_exec)
+			amdgpu_ring_set_preempt_cond_exec(ring, false);
+	}
+
+	/* Flush HDP cache so the GPU can see the updated COND_EXEC values */
+	amdgpu_device_flush_hdp(adev, NULL);
+
+	/*
+	 * Give some time for non-guilty rings to finish their
+	 * current submission, to try to minimize collateral damage.
+	 *
+	 * Note that this just a best effort, but really there
+	 * is no way to really know which ring is actually responsible
+	 * because different rings may share resources, eg. a compute
+	 * ring may hog shader engines, causing a graphics ring to hang.
+	 */
+	for (t = 0; t < adev->usec_timeout; t += 10000) {
+		rings_busy = false;
+
+		/* Check if any of the non-guilty rings are busy */
+		for (i = 0; i < num_rings; ++i) {
+			ring = rings[i];
+
+			if (ring == guilty_ring)
+				continue;
+
+			rings_busy |=
+				atomic_read(&ring->fence_drv.last_seq) !=
+				READ_ONCE(ring->fence_drv.sync_seq);
+		}
+
+		if (!rings_busy)
+			break;
+
+		mdelay(10);
+	}
+
+	for (i = 0; i < num_rings; ++i) {
+		ring = rings[i];
+
+		/*
+		 * Find guilty fences, ie. the fences that didn't signal
+		 * on each ring. At this point there is no way to know
+		 * which one is really responsible for the hang, and no
+		 * way to save any of them, so we treat all of them as guilty.
+		 */
+		ring_guilty_fence =
+			ring == guilty_ring ? guilty_fence :
+			amdgpu_ring_find_guilty_fence(ring);
+
+		/*
+		 * Backup current contents of the ring.
+		 * The helper takes care to only reemit unsignalled fences
+		 * so we don't have to worry about that here.
+		 */
+		amdgpu_ring_reset_helper_begin(ring, ring_guilty_fence);
+	}
+}
+
+/**
+ * amdgpu_multi_ring_reset_helper_end() - Prepare multiple rings for a reset.
+ *
+ * @rings: Pointer to an array of amdgpu rings that are affected.
+ * @num_rings: Number of rings in the array.
+ * @guilty_ring: The ring which is guilty of causing a reset.
+ * @ret: Return code from the reset function.
+ *
+ * After calling amdgpu_multi_ring_reset_helper_end()
+ * and executing the actual reset method, call this
+ * function to restore normal operation.
+ *
+ * In case the reset failed, this function should still
+ * be called to restore some state, but it won't attempt to
+ * fully restore the ring contents.
+ */
+int amdgpu_multi_ring_reset_helper_end(struct amdgpu_ring **rings, u32 num_rings,
+				       struct amdgpu_ring *guilty_ring, int ret)
+{
+	struct amdgpu_device *adev = guilty_ring->adev;
+	struct amdgpu_ring *ring;
+	int i, r;
+
+	/* Set preempt condition, rings are now allowed to execute submissions */
+	for (i = 0; i < num_rings; ++i) {
+		ring = rings[i];
+
+		if (ring->funcs->init_cond_exec)
+			amdgpu_ring_set_preempt_cond_exec(ring, true);
+	}
+
+	/* Flush HDP cache so the GPU can see the updated COND_EXEC values */
+	amdgpu_device_flush_hdp(adev, NULL);
+
+	/* If the reset was unsuccessful, return without restoring anything. */
+	if (ret)
+		return ret;
+
+	/* Restore contents of all rings */
+	for (i = 0; i < num_rings; ++i) {
+		ring = rings[i];
+
+		r = amdgpu_ring_reset_helper_end(ring, ring->guilty_fence);
+		if (r) {
+			dev_err(adev->dev,
+				"Failed to recover ring %s after soft reset\n",
+				ring->name);
+			return r;
+		}
+	}
+
+	/* Accept submissions on all rings again */
+	for (i = 0; i < num_rings; ++i) {
+		ring = rings[i];
+
+		if (!amdgpu_ring_sched_ready(ring))
+			continue;
+
+		drm_sched_wqueue_start(&ring->sched);
+	}
+
+	return 0;
+}
+
 bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
 					 u32 reset_type)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 71cd9bb12f75..c272e0b028ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -595,6 +595,11 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence);
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence);
+void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_ring **rings, u32 num_rings,
+					  struct amdgpu_ring *guilty_ring,
+					  struct amdgpu_fence *guilty_fence);
+int amdgpu_multi_ring_reset_helper_end(struct amdgpu_ring **rings, u32 num_rings,
+				       struct amdgpu_ring *guilty_ring, int ret);
 bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
 					 u32 reset_type);
 #endif
-- 
2.54.0

