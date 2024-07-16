Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78440C3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 07:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C132A10E9C3;
	Wed, 17 Jul 2024 07:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fj+2RrNH";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C583910E292
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721155807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pzRoH2dkpKJ+tNxF6vNNYOOrETVk0csHzuU1v7tcjP4=;
 b=fj+2RrNHtPl9AMoTcaLCqMeEbe2XaNFDoszUwnjV7hJiZBqrHQo0BmJr8FenQAp44MrMuM
 V+xwP8YeiqhHzQhSJZ5uCi1vheFVh3fRysfse3CLaMXsN3F+w3GANbz1FQH/kZ2x76qO7W
 pj3TcksNIBKgbglmmEpXhaNtujQNtbs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-n7-nBV3qMSSfJG9QX4YURA-1; Tue,
 16 Jul 2024 14:50:04 -0400
X-MC-Unique: n7-nBV3qMSSfJG9QX4YURA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B2C01955D4B; Tue, 16 Jul 2024 18:50:03 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.88])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0AE119560B2; Tue, 16 Jul 2024 18:50:01 +0000 (UTC)
From: Masatake YAMATO <yamato@redhat.com>
To: amd-gfx@lists.freedesktop.org
Cc: fbstachura@gmail.com,
	Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH] drm/amdgpu: fix unbalanced parentheses in a #if0 region
Date: Wed, 17 Jul 2024 03:49:54 +0900
Message-ID: <20240716184954.2338421-1-yamato@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 17 Jul 2024 07:23:13 +0000
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

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 06d787385ad4..27188dadfbcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -741,12 +741,12 @@ static bool vce_v4_0_check_soft_reset(void *handle)
 	 */
 	mutex_lock(&adev->grbm_idx_mutex);
 	WREG32_FIELD(GRBM_GFX_INDEX, INSTANCE_INDEX, 0);
-	if (RREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_STATUS) & AMDGPU_VCE_STATUS_BUSY_MASK) {
+	if (RREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_STATUS) & AMDGPU_VCE_STATUS_BUSY_MASK)) {
 		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE0, 1);
 		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE1, 1);
 	}
 	WREG32_FIELD(GRBM_GFX_INDEX, INSTANCE_INDEX, 0x10);
-	if (RREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_STATUS) & AMDGPU_VCE_STATUS_BUSY_MASK) {
+	if (RREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_STATUS) & AMDGPU_VCE_STATUS_BUSY_MASK)) {
 		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE0, 1);
 		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET, SOFT_RESET_VCE1, 1);
 	}
@@ -936,16 +936,16 @@ static int vce_v4_0_set_clockgating_state(void *handle,
 
 		if (enable) {
 			/* initialize VCE_CLOCK_GATING_A: Clock ON/OFF delay */
-			uint32_t data = RREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_CLOCK_GATING_A);
+			uint32_t data = RREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_CLOCK_GATING_A));
 			data &= ~(0xf | 0xff0);
 			data |= ((0x0 << 0) | (0x04 << 4));
-			WREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_CLOCK_GATING_A, data);
+			WREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_CLOCK_GATING_A), data);
 
 			/* initialize VCE_UENC_CLOCK_GATING: Clock ON/OFF delay */
-			data = RREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_UENC_CLOCK_GATING);
+			data = RREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_UENC_CLOCK_GATING));
 			data &= ~(0xf | 0xff0);
 			data |= ((0x0 << 0) | (0x04 << 4));
-			WREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_UENC_CLOCK_GATING, data);
+			WREG32(SOC15_REG_OFFSET(VCE, 0, mmVCE_UENC_CLOCK_GATING), data);
 		}
 
 		vce_v4_0_set_vce_sw_clock_gating(adev, enable);
-- 
2.45.2

