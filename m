Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F55606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mwdl7B4f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 271A610E14A;
	Fri, 20 Nov 2026 17:38:16 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB49112BF2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 17:24:28 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1012683f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795195466; x=1795800266; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oF6Jw5HZh2v0ySGxiOrn6/3LXveCfm60jSr9AEkx+Mg=;
 b=Mwdl7B4f9F1JoVfxvnH8XNsE1EWX1Z7zuf8K3UhuK8Qum9xCNjWOtW2APbUkwiMuny
 UYRrrKsac6YHnRhlDt0k/7rKPBev98Jlnr6E1WitlIZ8mLBEy84NMmC/kIepAeAjC4/x
 BFk2gk2Rkdfwl+1QaIKGSqBw3kBfIs2eOwRoZYN/sbvSRiw/vpc8BstZEC3HuEG537te
 /qzROfmffsHfSBUs+iWNw8AE9r9LZr6Gj7xOdt6pE/H8ACzy+W06lZ4SQY5HyxfqHA5N
 Gc6atmVWKZV0oIR0E63JkhynF4hXjY1m7a8sbJT7QXL/UaDOMCtdKZ3qBfJDAzDzQTOj
 c3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795195466; x=1795800266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oF6Jw5HZh2v0ySGxiOrn6/3LXveCfm60jSr9AEkx+Mg=;
 b=voKVWQ57oz1teyf7h32nZ8xhZHs5/nfXMcctsAbtNKLmvWtCmeKjbBJaRr7dUAmk2a
 F7wIQfU2N3ryTwn7tYjgjD0eh0iECFvXCgu3cHpkFpZjfer7D+BGux2FAgjm6um3hbXX
 GS2C5Rp0Fx051A15DgDdg75tAMBZ+2h0bXNdgzTDJ76lUX+pfTjkryPGgQ5meKpXdeEH
 ByTVXRnMQO5PlOZyntZphbxyp7JT3Iv93CX57Q81tjQOdEhzZLfKP1EfklGOhLqKqJ2Z
 0L287H5231kVjbbQUgEsLuRVqTdSEnIRBm7pzsFVcteUV9QqjI1rng0tq62IAy2L4vml
 eAxg==
X-Gm-Message-State: APuU4Z+drDupnuGyeoxbKufeRJ5cxisTPi3S3WF5QUcLOxJsGpiBoiMR
 Ofr6xGRI46BXaljBSQE2g2hdjcoPBxn7GHcNQ1vjW9E2D8yMojUXE+WP+cccOSjX
X-Gm-Gg: AYBFou3chvmDvumnGHMldZ6PfpuNY2HE5NFDOSKVrxtSnNjVklD22XPyWlkJ3iaRqIH
 zE4mNUnGc1sGeQb63cnjF1QLQD55ExdkQJgObrXZpuAiQNNEWtwfr8fc+l5yQB2dwpAvTJQGNVv
 +5PXMvGNBkSr55fvUdvHk1+JBQa2L6TgVSv3jcOy8EduqxB6W36+yxWRXQDBymim412IYyxzg88
 c6mmroe2fByfiTurlZ/rt/Xx6AMyGt5sARnGgSs9VDg6HZrt6PvzsdbtTAiYNH/KFJtyBZcTJgt
 iaG0mf56HYNQ5nlKvMH8SYVnKkLNnRVNeP9JI7OycKyBQYu3yX9wHXwSFyNGezfOQ4x17pWncmf
 cn9tiURRR5Lgm6HxPgTBtqlophhdePaPnnWGOaOUFnZelzOuATPKYXMZkoY+3ts81CjXisuj3ED
 +v5mEhb3MndAcU1E85KLgSucE7Ipf0BMtwlRKVFp/IAoELY0cDBUehIJLJ0Q+WtzHiJyA47Lrh+
 lO7jgllK/TaMYHe9y5sKXgquloL6tRLjwoCnE9fU7Z10FmSW1+YSgBkJQK03ykkO1eH/bYTRDob
 nh/EkFHvNyFuIAatcFU0HEOYJIQfMRhjZZwrvXBsvc7aTxKNFhAiNpNpd/a+aoGuvKqzw3W2yOg
 8OlkWW4riV5BUaNS4/93VePZHVlKuDkXMTQYdQ49BmAaNcvZ4C2TChFng
X-Received: by 2002:a05:600c:5306:b0:4bb:6ac0:6dc1 with SMTP id
 5b1f17b1804b1-4bb887c994cmr92585465e9.2.1795195466501; 
 Fri, 20 Nov 2026 09:24:26 -0800 (PST)
Received: from Arbeitszimmer.fritz.box
 ([2001:9e8:db29:4c00:a7d0:374b:43f1:90ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c3csm6924137f8f.36.2026.11.20.09.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 09:24:26 -0800 (PST)
From: Christoph Berliner <caberliner@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Jiqian.Chen@amd.com,
 Christoph Berliner <caberliner@gmail.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx9: factor out HQD deactivation and fix its
 timeout check
Date: Fri, 20 Nov 2026 18:24:06 +0100
Message-ID: <20261120172407.64651-2-caberliner@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120172407.64651-1-caberliner@gmail.com>
References: <20261120172407.64651-1-caberliner@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 17:38:15 +0000
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

gfx_v9_0_deactivate_kcq_hqd() polls CP_HQD_ACTIVE for adev->usec_timeout
iterations, but then compares the loop counter against
AMDGPU_MAX_USEC_TIMEOUT. Unless both values happen to be equal, the
manual CP_HQD_ACTIVE=0 fallback for a timed-out dequeue request is never
reached. Compare against the actual loop bound.

Move the per-queue deactivation into gfx_v9_0_deactivate_hqd() so it can
be reused for queues that are not kernel compute rings, and use
dev_dbg() instead of DRM_DEBUG() while at it. No functional change other
than the timeout check.

Fixes: c3988a7ad479 ("drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2")
Assisted-by: Claude Code
Signed-off-by: Christoph Berliner <caberliner@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 50 ++++++++++++++++-----------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9d87ebbc4..b60b6fa88 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4076,35 +4076,43 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return r;
 }
 
+/* caller must hold srbm_mutex and have selected me/pipe/queue */
+static bool gfx_v9_0_deactivate_hqd(struct amdgpu_device *adev,
+				    u32 me, u32 pipe, u32 queue)
+{
+	int j;
+
+	/* disable the queue if it's active */
+	if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK))
+		return false;
+
+	WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
+	for (j = 0; j < adev->usec_timeout; j++) {
+		if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) &
+		      CP_HQD_ACTIVE__ACTIVE_MASK))
+			break;
+		udelay(1);
+	}
+	if (j == adev->usec_timeout) {
+		dev_dbg(adev->dev, "comp_%u_%u_%u dequeue request failed.\n",
+			me, pipe, queue);
+		/* Manual disable if dequeue request times out */
+		WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
+	}
+	WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0);
+
+	return true;
+}
+
 static void gfx_v9_0_deactivate_kcq_hqd(struct amdgpu_device *adev)
 {
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	for (int i = 0; i < adev->gfx.num_compute_rings; i++) {
-		u32 tmp;
 		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
 
 		mutex_lock(&adev->srbm_mutex);
 		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
-		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
-		/* disable the queue if it's active */
-		if (tmp & CP_HQD_ACTIVE__ACTIVE_MASK) {
-			int j;
-
-			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
-			for (j = 0; j < adev->usec_timeout; j++) {
-				tmp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
-				if (!(tmp & CP_HQD_ACTIVE__ACTIVE_MASK))
-					break;
-				udelay(1);
-			}
-			if (j == AMDGPU_MAX_USEC_TIMEOUT) {
-				DRM_DEBUG("comp_%u_%u_%u dequeue request failed.\n",
-							ring->me, ring->pipe, ring->queue);
-				/* Manual disable if dequeue request times out */
-				WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
-			}
-			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0);
-		}
+		gfx_v9_0_deactivate_hqd(adev, ring->me, ring->pipe, ring->queue);
 		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	}
-- 
2.56.1

