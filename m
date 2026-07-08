Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D25C44501
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 13:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C94310E5EB;
	Wed,  8 Jul 2026 13:12:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="VcSrPo4Y";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE9510F133
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 12:56:46 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3811f512167so814855a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1783515405; x=1784120205; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/XT7b2MY1g30rwbWj7DfLHgK4V3JDBrTCuhHZX7pWY=;
 b=VcSrPo4YQ2WDJfIxyj/qUugeSa/5RVg3BW0HPviCjXfVC6DplbxNQIWz7+zKSP1udr
 HsaowQRyPyShPHALAIC+Xq0ujyUqZeBJANfFwznMyN/+3O6Nmp5dqwSmvOgNLYtpP9ta
 YwbMWYkyWWAoPgoZ6pD38w+nNcxGb9s61zhqm/cRg2PY4EgIVjZlnjCTRUvRHuGYXCJo
 QQobK03AewRAd/j2qDhY5LNdrWrk1FjwcSkIerilLAcDouOvL8ApD9hGcvu3iaynJV20
 DC9p8A75g4sCrIjH82Y4pOz2Vdq0wCfHS3km7/f2Vx0XFfhp+12YvhhSalIYK7fyFNqp
 0saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783515405; x=1784120205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q/XT7b2MY1g30rwbWj7DfLHgK4V3JDBrTCuhHZX7pWY=;
 b=LdNBaFeN9MTp0zjopHRWZRerL38tONljzjeh66RoKVrEP+82ZrR5WnJlXlb7gplpAM
 SdvCrLn2r8OzzguRShdyeUYmlkVXMM2OuwPNmbOtPuWCZAi96srTvH/aHVofhC62jXiK
 9LNuGv0fo4WRVhMlvBc7mf/gfwT3sKrTS2Ns4yvQfCRL0gXxn/po3ZwtaUgRVD+nFHhm
 aFKAgZY1WCPumPd+Z2Qu+19CnnQYaHUiHLFjv0jhOwV99l1BCDXtWOtn/ybxDSUMKNp3
 PrG5D9/88wsgm/x7ZUGYpiEuAVNWVbmKSaUIE3UYksrLtg8d/wLnvgUqh1M6K0rhV3Wg
 s4XA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrc7G3Y+nt9aSl2izgSni4aj/1CbEvWUpy4e06c09GrZL/MlTLDCTKbqAwWW1r/3Zwb861YwHbc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEUTDu4yTVwbUdRsFF9ls6k6eGU3rHN2ZrgZhMwX/uFjq13QVS
 opO6Q+9jRtJN4xD2KW3KdPfhoVo6zFvMR75aP1gmLUw6fpSQ+3VXzvCwaXoxADo3sl4=
X-Gm-Gg: AfdE7cm1g2XbfD+uMqzryl7kSF+wUinJbozpgb/Oo5uEENJsvW4Fxkokik1T7ZMstN9
 vxwaBdhBZsSZ212P+NP77SWEu4EuAXzCwqh4Ms8SXfrDWYJCIRKHhwDmUPDWKQJbkqlB560PZu2
 0l8ndRlPW1W223uh3uK72izkm0gFIcUiZ+DDWqA0vL9o0MnedSkOQijQ5Un1O/IKHfX8yDEdURe
 IH6fRHQDhgHP6axde1nZWnm7qh9QM2es/QXu9B/SMxTJJN2EYlsUzTFLqhDXsVjf1GbpO2nLO3x
 hLh90kcbQpJR3BTCzp2MJQSY42Ea6SCwL6elFd0DYv3Kc82jmJfHQ7+/7JiZ+8xoN0qZsULtskV
 WTGcs2IewPtB1qTpMrAoHc9zRE4tDL/VKqWvX4M5EFuDD0BwThwiEWZ5Q39tH1md3tvmpI5pXia
 BtN1Pq5+Ts/TLJ97ARtutp+ztuOg==
X-Received: by 2002:a17:90b:1cc6:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-3893f694da8mr2644317a91.4.1783515405516; 
 Wed, 08 Jul 2026 05:56:45 -0700 (PDT)
Received: from localhost.localdomain ([179.100.68.126])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117462f5c7sm23026107eec.0.2026.07.08.05.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 05:56:45 -0700 (PDT)
From: Ulisses Paixao <ulissespaixao@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ulisses Paixao <ulissespaixao@usp.br>, Felipe Sousa <felipesousa@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v5] drm/amd/amdgpu: remove duplicated code in gfx_v11 and
 gfx_v12
Date: Wed,  8 Jul 2026 09:56:36 -0300
Message-Id: <20260708125636.8103-1-ulissespaixao@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b12cbd03-9e11-44ff-9ce1-8afb82379b53@amd.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Jul 2026 13:12:03 +0000
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
v5:
Return early on adv->gfx.disable_kq check.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 42 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 27 +---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +---------------
 4 files changed, 46 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca87669..50e265abe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -830,6 +830,48 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
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
+	/*
+	 * The scheduler only handles kernel queues so this is a no-op
+	 * without them.
+	 */
+	if (adev->gfx.disable_kq)
+		return;
+
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

