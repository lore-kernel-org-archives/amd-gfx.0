Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E949FCD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7529710E51D;
	Wed,  6 May 2026 07:50:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="miNyr8iq";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83ED810E458
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 17:50:23 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-57513733658so885610e0c.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778003422; x=1778608222; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsyB8L0ph4cC4uwcAMz3kIiPlavHdL5/IakECCF4TVU=;
 b=miNyr8iqeRjwcirjt+PVRqT4abzC7FGaopot77puDrpt0KzZwabTdbdTh0HDeoXbLJ
 d2oNweUS7Ob2V0LEA0UVVZWoox0wfK2t+w9TWsxpkeaj4QnLWG9c+ftXG7ASfA9nFIn3
 gMZJwy/57alC8z6/Nvt7SiDa01sedfc022mXaIq8e7Z1+wLHddgmfzlGacgMkmw9aQZY
 8oA2TbLWTyXlKpgXPbgMiEI/DqWT1ioDyU9iqiTyg069gWmzusnpEOOOSOUweDg7Zpof
 cNrBjhgeGg9r8niG3A0gRCKlkNQ5ZwjCGz4PBXd3jYqyDsFrzQWhCywguK/EkSc38ccJ
 3Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778003422; x=1778608222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XsyB8L0ph4cC4uwcAMz3kIiPlavHdL5/IakECCF4TVU=;
 b=Y1Zl8qikqsjQACol8VQKZ2Xo3wzfmR6HtVVtwg7CZ8ECz6x3O1gTputW+kkAadjvuy
 REy9oVz7iDsa/8wBszdCQQtwWrASQnyEP8+ApQwkonR9w8NR+AEZrdCGee/ke+G6t+pu
 ckPujtnzw7ynjisKNXDmgecPK3g0GIIHow4nSOSl4PBvQsxRYbjC8IvkDhVWc21Vw7Zm
 SmbNonnpckDErMdIfcX1Iap2PFXyp9QI9FNXdfee4S5KpTTFpqH0QnsdXyGV6Or7B808
 iGJKLI3GXrmfyvYWuYPNp1x5svOiCiWzbzekoIRwBTeDkd1xOrQTDT2kbcrwM0qOeVQa
 F3wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iXkoqjelOlRyx79XAwTwcqB9W8fOWq2ZhIzhK4uT5jLX+PUExoX3wu2LvRZxSLGqZ9AggsZto@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykdUPCdK9olIJjEyo7DpV55mxezgz24FPaa78svrneilUhyJb3
 nxRZF+b2w1z8768oUqwpmMgSyi2CFpUJDNyls3SmefWzUMY44Ogq2Tv78l4pdsh84ck=
X-Gm-Gg: AeBDievmUfYy2Zb6Ut4pXP5zko68jtE6/P989vifkgtOFP3aQe2UDJvLFeWMDmO7+vN
 4mDTatjo+iSQKYLEbmOISz9nE3NLIsmSbXsrZjSjIEZIlNOds5LJpdoj+1IBuAFfT1uljs4qP0q
 gQ2oSBlCHs9OhiEcPqCbL7iX9cfVreOpxihJn5+6gz1VoWGdl/RF9mdz9rbqwd34/Xoh7uZlRed
 WssYgxNkVQkpgEHwei9m4pcq4UYtfWXkdFqDtVpuqYLgy1CwH8VI00WSWHRd4GKB/XHfMiwDKsN
 urlvgqOPTNF7lFIBM+zKUyRnarhIgayl9Lg1KHmAd+HuT3to9M+Wo9/PXm0hW7PLMijQVaGl2sA
 zhU3TrUhi1GIUYWPOCmf6Q9fnTmrpDJs835Ze9gL02EufOFa9RIVocNIiY7vq1QfiWpuv7+RRds
 4S8w7VFHacZmh/792McjPmLYSuptlJlHMPNE5cG0P1U5BoIEI=
X-Received: by 2002:a05:6122:8294:b0:56f:694e:1f10 with SMTP id
 71dfb90a1353d-5755958167amr79509e0c.5.1778003422048; 
 Tue, 05 May 2026 10:50:22 -0700 (PDT)
Received: from localhost.localdomain ([152.234.115.70])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5749f835632sm8442672e0c.5.2026.05.05.10.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:50:21 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
Date: Tue,  5 May 2026 14:50:06 -0300
Message-Id: <20260505175006.13519-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fe76a5db-7d18-4f67-be38-723a5821a818@amd.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 May 2026 07:50:24 +0000
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

The functions gfx_v11_0_handle_priv_fault and
gfx_v12_0_handle_priv_fault share the same logic for searching and
triggering a scheduler fault on a ring. This patch moves the shared
ring-searching logic to a common function, amdgpu_gfx_handle_priv_fault,
in amdgpu_gfx.c. The hardware-specific decoding of ring IDs remains in
the version-specific files to maintain proper architectural separation.

Signed-off-by: Ulisses Paixao <ulissespaixao@usp.br>
Co-developed-by: Felipe Sousa <felipesousa@usp.br>
Signed-off-by: Felipe Sousa <felipesousa@usp.br>

---
v3:
Return early if the ring is found in the gfx rings loop.

v2:
Keep the HW-specific decoding in gfx_v11_0.c and gfx_v12_0.c.
Remove the redundant check for adev->gfx.disable_kq.
Simplify the search loop in amdgpu_gfx_handle_priv_fault to iterate over
all gfx and compute rings without a switch statement.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 34 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +-------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +-------------------
 4 files changed, 38 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca87669..0e9f9fec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -830,6 +830,40 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	return r;
 }
 
+/**
+ * amdgpu_gfx_handle_priv_fault - Handle privileged instruction fault
+ *
+ * @adev: amdgpu_device pointer
+ * @me_id: micro-engine ID of the faulty ring
+ * @pipe_id: pipe ID of the faulty ring
+ * @queue_id: queue ID of the faulty ring
+ *
+ * This function handles privileged instruction faults by identifying
+ * the faulty ring (gfx or compute) and triggering a scheduler fault.
+ */
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					u8 me_id, u8 pipe_id, u8 queue_id)
+{
+	struct amdgpu_ring *ring;
+	int i;
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+		ring = &adev->gfx.gfx_ring[i];
+		if (ring->me == me_id && ring->pipe == pipe_id &&
+		    ring->queue == queue_id) {
+			drm_sched_fault(&ring->sched);
+			return;
+		}
+	}
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		ring = &adev->gfx.compute_ring[i];
+		if (ring->me == me_id && ring->pipe == pipe_id &&
+		    ring->queue == queue_id)
+			drm_sched_fault(&ring->sched);
+	}
+}
+
 static void amdgpu_gfx_do_off_ctrl(struct amdgpu_device *adev, bool enable,
 				   bool no_delay)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b4..0b2f6ce85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -611,6 +611,8 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
 						struct amdgpu_ring *ring);
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					u8 me_id, u8 pipe_id, u8 queue_id);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2c6f1e25c..888c9f3c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6688,37 +6688,12 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
 	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
 
 	me_id = (entry->ring_id & 0x0c) >> 2;
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	if (!adev->gfx.disable_kq) {
-		switch (me_id) {
-		case 0:
-			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-				ring = &adev->gfx.gfx_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		default:
-			BUG();
-			break;
-		}
-	}
+	amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
 }
 
 static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6baac533a..3f0d29372 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5019,37 +5019,12 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
 	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
 
 	me_id = (entry->ring_id & 0x0c) >> 2;
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	if (!adev->gfx.disable_kq) {
-		switch (me_id) {
-		case 0:
-			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-				ring = &adev->gfx.gfx_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
-					drm_sched_fault(&ring->sched);
-			}
-			break;
-		default:
-			BUG();
-			break;
-		}
-	}
+	amdgpu_gfx_handle_priv_fault(adev, me_id, pipe_id, queue_id);
 }
 
 static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.34.1

