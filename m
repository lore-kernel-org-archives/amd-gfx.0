Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7E1C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 14:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC4310E743;
	Fri, 18 Nov 2022 14:11:13 +0000 (UTC)
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAEE710E6FE;
 Fri, 18 Nov 2022 11:53:11 +0000 (UTC)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1668772387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=S0tk9zvEh9i3RpeDgKq2csbzg/78Ce7ScjSDjvtVy4w=;
 b=ZmV/V7mfYlM5CynFgGpfPcqhwVGjI/BtMQIRjv3GIh+F/3m0fq84tB+XkvGbSJzsObh98i
 UsbmerxlTGiIh+AvkKKpNI1fmlswJ15luLfdx7O0iYzCIwlm2RNKNYqFTr3/8+XPmcU5ow
 aR/p0WC2AbLQOYuuoGYKfT1tHFzXBoQ=
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2] amdgpu: nbio_v7_4: Add pointer check
Date: Fri, 18 Nov 2022 14:53:06 +0300
Message-Id: <20221118115306.128293-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Nov 2022 14:11:10 +0000
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
Cc: lvc-project@linuxtesting.org, avid Airlie <airlied@linux.ie>,
 trufanov@swemel.ru, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, vfh@swemel.ru, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return value of a function 'amdgpu_ras_find_obj' is dereferenced 
at nbio_v7_4.c:325 without checking for null

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index eadc9526d33f..0f2ac99de864 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -304,6 +304,9 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 	struct ras_err_data err_data = {0, 0, 0, NULL};
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	if (!obj)
+		return;
 
 	bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL);
 	if (REG_GET_FIELD(bif_doorbell_intr_cntl,
 		BIF_DOORBELL_INT_CNTL, RAS_CNTLR_INTERRUPT_STATUS)) {
-- 
2.25.1

