Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE98C624C6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 08:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C6EF10E5B8;
	Tue,  1 Sep 2026 08:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F32TaK3M";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0405A10E3D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 08:41:33 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso51508755e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788252091; x=1788856891; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VJflXVvbqbsFAjh2dc5ouPHmJPrEoNOe0H35zTZpaW8=;
 b=F32TaK3MTIyluTO7UgHUlbUV/jsRiaVWKa3nUuKlP1IMQOjacpOF87BJcufZme6AvX
 kV877t+tevl2pfjyqtfAPI7xQtPZmrjNhRDCznjKM+29/OvLJAJT0sGsXWRiKABIH8uh
 jyDT9tQSHtonrXEmGJGnPSjDwWvu5HIDKDdA/qBecag1DFfYX8bEBxNF9mdiLJVU9xii
 583aJBey2/4/+fa+yN4oWDY9/a+uj2Vpzczn9/TjkkLxiWeXfnexrHqU4hjS7EdCg9GC
 49AcKP1bPYh6z5v/ZB56ePicIhzszFP9FGuWKpKy1LqcxiNXFstGRef01fBvFWaqEDCu
 C44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788252091; x=1788856891;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VJflXVvbqbsFAjh2dc5ouPHmJPrEoNOe0H35zTZpaW8=;
 b=N8S4OyCTW/s6CbfaKHWWFtFBOlXO8pFB6x//B24momIoWGh+OsbBvEAh6GNrjOI3PU
 Sqg0sTC6I6MuITLtfWuvRuF3WJJs/DBqcHW0q3pWUqjhwMpHVcHBjYgqFn+a1SKvpZAq
 SAH8Tm0UCNRYK1q4+oDBN7KFA/w/JuOTB9NiMl7Z85eXCA07BwA5Fnk2n9LhBTMv9ACx
 btup8pSkOA+ckQpMcV1O5NSsqrOyyKOHCCvSZQvhbIQkEjWW5v8M6fGW+rtQM6N/rig8
 x4nncqLKZa5fCp+B3aJ5aI+X0F6AA9yzSfIFjgWbRgmw9MK12vTkK+aKPx0tBoIHeAl6
 XVsw==
X-Gm-Message-State: AFuF++mRnfe5SlogJN+cHZTBv6OYFvKM/zMygPulDzST+hRRh/z16ttp
 z2oiaigswohaHVZzzKYoCOoCnYmI8uM7cEZeaHzO0NvShVDGTY43QM0RTbW8vylJ/qc=
X-Gm-Gg: AR+sD11ZMM2NHx1dwpBjMRxSCch40o3mkZfW8z6zGwjT0k5igU5MhVFoQzvNO6s2aKO
 tRgTsLjnge41whPRKEjAtL77DmfdFaJRtaueb+T9aGZ/CaSoRXzorOcxqKjC5PRrC60y5TLxWLj
 ElGgC9bt64zIvGVWUQk2/RubP/u0pB+HT4IHRU65re6p4+NayQE+JdlU4LApcNKIm9DgHQVYozz
 P2cn19xNhEOzj7gp0jJ44eD1GnT2pav01omVPSWdI9PNljJd37oHMJFcFaloINugvthTxJ2j4LL
 UP4MyUp6GgErcPUhZsUNIH22WRWMG8/KyuCPnkhzc8xsqC7VqGvfKZpHVMwwul5p0dv9i8Y/1Zu
 Tbo5T2mk2f7f0mQy2CaIqDQvC+kS4d9GZKCYfVqJk8VDAoQgOTLNZbguV/8RMAQdkgucxWbuezp
 9gwgPTCOFC2TbQR3xbdWd7XojeFLC/uZVQbUEytetXICkOPzgCVL1FESBeYWdbW1KkV5gOSmB7m
 adX99w8ALQ8Dplpir4xPOw=
X-Received: by 2002:a05:600c:354f:b0:493:c47f:3c55 with SMTP id
 5b1f17b1804b1-49b91c1ece1mr573692215e9.5.1788252091124; 
 Tue, 01 Sep 2026 01:41:31 -0700 (PDT)
Received: from Timur-Max (athedsl-4457084.home.otenet.gr. [79.129.242.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce08b8esm47139235e9.3.2026.09.01.01.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 01:41:30 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/8] drm/amdgpu/sdma: Remove unnecessary guilty tracking of
 SDMA queues
Date: Tue,  1 Sep 2026 10:41:11 +0200
Message-ID: <20260901084115.262457-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901084115.262457-1-timur.kristof@gmail.com>
References: <20260901084115.262457-1-timur.kristof@gmail.com>
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

amdgpu_sdma_reset_engine() saves and restores contents of
both the SDMA gfx queue and the paging queue, so it's
not necessary to track which queue was guilty anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 --------------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 8a78d6967716..055dd2522ecd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -79,9 +79,6 @@ struct amdgpu_sdma_instance {
 	uint64_t		sdma_fw_gpu_addr;
 	uint32_t		*sdma_fw_ptr;
 	struct mutex		engine_reset_mutex;
-	/* track guilty state of GFX and PAGE queues */
-	bool			gfx_guilty;
-	bool			page_guilty;
 	const struct amdgpu_sdma_funcs   *funcs;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 890513d7c18f..77f385b9ef53 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1404,9 +1404,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
-		/* Initialize guilty flags for GFX and PAGE queues */
-		adev->sdma.instance[i].gfx_guilty = false;
-		adev->sdma.instance[i].page_guilty = false;
 		adev->sdma.instance[i].funcs = &sdma_v4_4_2_sdma_funcs;
 
 		ring = &adev->sdma.instance[i].ring;
@@ -1577,15 +1574,6 @@ static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t instance_id, bool is_page_queue)
-{
-	uint32_t reg_offset = is_page_queue ? regSDMA_PAGE_CONTEXT_STATUS : regSDMA_GFX_CONTEXT_STATUS;
-	uint32_t context_status = RREG32(sdma_v4_4_2_get_reg_offset(adev, instance_id, reg_offset));
-
-	/* Check if the SELECTED bit is set */
-	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
-}
-
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   unsigned int vmid,
 				   struct amdgpu_fence *timedout_fence)
@@ -1603,19 +1591,11 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 instance_id = ring->me;
 	u32 inst_mask;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	/* Check if this queue is the guilty one */
-	adev->sdma.instance[instance_id].gfx_guilty =
-		sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
-	if (adev->sdma.has_page_queue)
-		adev->sdma.instance[instance_id].page_guilty =
-			sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
-
 	/* stop queue */
 	inst_mask = 1 << ring->me;
 	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
-- 
2.55.0

