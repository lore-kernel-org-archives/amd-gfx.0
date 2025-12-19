Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A01D78778
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 13:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8552E10EEE8;
	Fri, 19 Dec 2025 13:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Eaq11tzo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ADC610E48E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2eKBcYoymfdePOBsE+5WP8HZUgZcmDq7UM5ilBHPOXI=; b=Eaq11tzo7qVvML7to5hhTuL2Sy
 V10pk66F+mK4/scHwPSsbrHv5HPBDqfv+VqeHf3JiHserekNWDy4ooRMAzzFe96K/Bo8LyRKjvfeJ
 LjdHI7F9JySUmybCKj64skl9lEcEPESP7hf1nHD7d2YED0ZphwYnyS/Xmn7NxwzEv8c2RoKcdY8Nl
 hS48YbiTwvLabqiSdaoeKloIWlFqr39bx2UXfV1KOSm+goW2QJ9/c3mYyr7O2RYxpQKhDDEfaZYPo
 x0LlinNWcSd3mjk05uC2tzlsA57TJwJmXhI19b01Kb2bXKxaKQYj2BGHNc52cwD4qK1EQIAOQDIFy
 MogVvQEA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vWakC-00EeQP-Aa; Fri, 19 Dec 2025 14:42:08 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 01/12] drm/amdgpu/mes: Remove idr leftovers
Date: Fri, 19 Dec 2025 13:41:54 +0000
Message-ID: <20251219134205.25450-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
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

Commit
cb17fff3a254 ("drm/amdgpu/mes: remove unused functions")
removed most of the code using these IDRs but forgot to remove the struct
members and init/destroy paths.

There is also interrupt handling code in SDMA 5.0 and 5.2 which appears to
be using it, but is is unreachable since nothing ever allocates the
relevant IDR. We replace those with one time warnings just to avoid any
functional difference, but it is also possible they should be removed.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: cb17fff3a254 ("drm/amdgpu/mes: remove unused functions")
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  9 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c  | 18 +++---------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c  | 18 +++---------------
 4 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9c182ce501af..505619d504ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -94,9 +94,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 	adev->mes.adev = adev;
 
-	idr_init(&adev->mes.pasid_idr);
-	idr_init(&adev->mes.gang_id_idr);
-	idr_init(&adev->mes.queue_id_idr);
 	ida_init(&adev->mes.doorbell_ida);
 	spin_lock_init(&adev->mes.queue_id_lock);
 	mutex_init(&adev->mes.mutex_hidden);
@@ -218,9 +215,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 				      adev->mes.query_status_fence_offs[i]);
 	}
 
-	idr_destroy(&adev->mes.pasid_idr);
-	idr_destroy(&adev->mes.gang_id_idr);
-	idr_destroy(&adev->mes.queue_id_idr);
 	ida_destroy(&adev->mes.doorbell_ida);
 	mutex_destroy(&adev->mes.mutex_hidden);
 	return r;
@@ -248,9 +242,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 
 	amdgpu_mes_doorbell_free(adev);
 
-	idr_destroy(&adev->mes.pasid_idr);
-	idr_destroy(&adev->mes.gang_id_idr);
-	idr_destroy(&adev->mes.queue_id_idr);
 	ida_destroy(&adev->mes.doorbell_ida);
 	mutex_destroy(&adev->mes.mutex_hidden);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e989225b354b..f45129277479 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -68,9 +68,6 @@ struct amdgpu_mes {
 
 	struct mutex                    mutex_hidden;
 
-	struct idr                      pasid_idr;
-	struct idr                      gang_id_idr;
-	struct idr                      queue_id_idr;
 	struct ida                      doorbell_ida;
 
 	spinlock_t                      queue_id_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 8ddc4df06a1f..ab9e6199b01d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1704,24 +1704,12 @@ static int sdma_v5_0_process_trap_irq(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
-	uint32_t mes_queue_id = entry->src_data[0];
-
 	DRM_DEBUG("IH: SDMA trap\n");
 
-	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
-		struct amdgpu_mes_queue *queue;
-
-		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
-
-		spin_lock(&adev->mes.queue_id_lock);
-		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
-		if (queue) {
-			DRM_DEBUG("process smda queue id = %d\n", mes_queue_id);
-			amdgpu_fence_process(queue->ring);
-		}
-		spin_unlock(&adev->mes.queue_id_lock);
+	if (drm_WARN_ON_ONCE(&adev->ddev,
+			     adev->enable_mes &&
+			     (entry->src_data[0] & AMDGPU_FENCE_MES_QUEUE_FLAG)))
 		return 0;
-	}
 
 	switch (entry->client_id) {
 	case SOC15_IH_CLIENTID_SDMA0:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 51101b0aa2fa..4f78dd93939c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1617,24 +1617,12 @@ static int sdma_v5_2_process_trap_irq(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
-	uint32_t mes_queue_id = entry->src_data[0];
-
 	DRM_DEBUG("IH: SDMA trap\n");
 
-	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
-		struct amdgpu_mes_queue *queue;
-
-		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
-
-		spin_lock(&adev->mes.queue_id_lock);
-		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
-		if (queue) {
-			DRM_DEBUG("process smda queue id = %d\n", mes_queue_id);
-			amdgpu_fence_process(queue->ring);
-		}
-		spin_unlock(&adev->mes.queue_id_lock);
+	if (drm_WARN_ON_ONCE(&adev->ddev,
+			     adev->enable_mes &&
+			     (entry->src_data[0] & AMDGPU_FENCE_MES_QUEUE_FLAG)))
 		return 0;
-	}
 
 	switch (entry->client_id) {
 	case SOC15_IH_CLIENTID_SDMA0:
-- 
2.51.1

