Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C54C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 07:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A8810EE06;
	Wed,  1 Jul 2026 07:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="dfJnc/NP";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEF310E267
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 20:55:53 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-13a97ffb312so4409634c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782852953; x=1783457753; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q15Zw2luJWYA16XSjllrT6+cPa1JqXGGEaoXxQ4s5kU=;
 b=dfJnc/NPECC2Y+r+sWzyDXH/R4v4ZvqFwGmRpCf+INRg+xhH5+aLOkAZt1KW/ANiMs
 vMsneIXqtbe/sq/aNQdvYVSTrh429VRA/xzZ8N2msxtg3Jcr8+CmvCkVcAj8fqZaFJLV
 /ehJWRWWQt/SiyLPjRBMSk6eGiZO/2JlI/n9NNZGdTgQ7M7+YTefEZQxGwA7dl9g0otR
 dQY5HXVTwJE5HTaEjMkmrSbtOCnIlsiiEWEuqRDg+hozUA5U18uCBECBz76RpdnDNIPx
 zf9dDgJOBFzhFFgS2EVhoNMCUAih4VOjIfGylEi2VtbCODUTeaan1OjGGM9G8y8ZZPCO
 HO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782852953; x=1783457753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q15Zw2luJWYA16XSjllrT6+cPa1JqXGGEaoXxQ4s5kU=;
 b=M0c66Z37hM33Ru6oWtdNzdgt5UxZ3wodELIqRbAN52AH0Z16H/rkX1PDxg697ZS8mn
 I2tnY8CVfAOXBfHaCCZEsUHN+A4IoXiPhb8HYp/UyrgMSdDTqOC8+06febujyv2XBWSi
 xK496h95Rg1zMGo0iInUavLOEdNaMkN2JAPyU07k2DLK3tYAb0yXZJdPPgCmYvPfRha9
 UURfaIK3f4rBod1yuC9XY+RIZT5TLwcluSvZ1k7YGx755cDQ0IMinpoM44mtvqxTOEul
 0+kg9j/pOQ0iXeXV6cLBkaJ55OAF6piZcwWvZwEZQT3sbQotEAyYT9k1G9JgkhHzfilS
 LQ8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvhZkL0drdAYqezbOtr60oGOlUhAXN7FFUp1trewY3V0rVAwOrgFFTbqUa9PGUHq3exCIjKCZj@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSHNrq8ozXyar6LIuG8sBrVxZQr5fAQP0PEZ60hZBk3XuH9NEH
 UWTsz31j8TN6EPm6jhjhEPErjTNoNicRowNNF2VRANB+co6ciNx0jkS1/qikw+sbXvs=
X-Gm-Gg: AfdE7cne4eB9f8sxVjfPxPNhm51WMLqpepvXFsYY2/0jmsOsjzPCuK6GZCEy/Rojzvu
 VtTmGcJ/MDyNyDMAL4cZQDRZ718bYYXk4P0tRY7PDjca/Gi/rRE+jky+PzSY7W8+dSN482wDylk
 GrF2uOXcNm69H64K/YNbGDHJyJpnaZJFM+LGCanZ2XN9FNP1yLQnhDDdqUKcxsasDwOau1N3yWG
 3gnRn4MyoyJFmjzyHy4BGnSEkwNC0imdSN1yK7c6ThDVVAYQIjGCGYgerU0PIcgpcFPwlzRHmx+
 hoMKaiGMKdqWCB9v7OYIvy3ciGLQc+L6WBGqESEF9bw2RTKizBn2aUPHQTE5BU8Np/onN4f2eGK
 V5RpRTeG0UXcuZWixXZ8LKndspff2TxNqQVV4hVyY1Ku26qMA0qs+CXPh63Mv5zSb9+waaPWcLX
 pQFmnfauvSULpYOqx6+xUg0uIIYg==
X-Received: by 2002:a05:7300:6401:b0:30c:38ed:46b0 with SMTP id
 5a478bee46e88-30ee135837emr3998893eec.16.1782852952717; 
 Tue, 30 Jun 2026 13:55:52 -0700 (PDT)
Received: from localhost.localdomain ([179.100.109.21])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee327cea7sm12321464eec.31.2026.06.30.13.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 13:55:52 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v4] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
Date: Tue, 30 Jun 2026 17:55:45 -0300
Message-Id: <20260630205545.23920-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:11:03 +0000
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
Note that v2 was already reviewed by Christian.

v4:
Restore the adev->gfx.disable_kq check to prevent falsely triggering
scheduler faults on idle kernel rings when MES is managing user queues.

v3:
Return early if the ring is found in the gfx rings loop.

v2:
Keep the HW-specific decoding in gfx_v11_0.c and gfx_v12_0.c.
Remove the redundant check for adev->gfx.disable_kq.
Simplify the search loop in amdgpu_gfx_handle_priv_fault to iterate over
all gfx and compute rings without a switch statement.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 36 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +------------------
 4 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca87669..98035129a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -830,6 +830,42 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
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
+ * the faulty ring (gfx or compute) and triggering a scheduler fault
+ */
+void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
+					u8 me_id, u8 pipe_id, u8 queue_id)
+{
+	struct amdgpu_ring *ring;
+	int i;
+	
+	if (!adev->gfx.disable_kq) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			if (ring->me == me_id && ring->pipe == pipe_id &&
+			    ring->queue == queue_id) {
+				drm_sched_fault(&ring->sched);
+				return;
+			}
+		}
+	
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			ring = &adev->gfx.compute_ring[i];
+			if (ring->me == me_id && ring->pipe == pipe_id &&
+			    ring->queue == queue_id)
+				drm_sched_fault(&ring->sched);
+		}
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

