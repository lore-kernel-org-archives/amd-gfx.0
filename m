Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22E7C83F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0375B10E42E;
	Tue,  5 Sep 2023 06:04:26 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6360C10E42B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:24 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so2839024a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893863; x=1694498663; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzg20wHPv+q7Gk6Nq1Mqo2bgC7J10ecxifs4mul0aOs=;
 b=qilYaDf+nLvCI3nD5GZhgy8MN2acTdhKr1XSatjScR4StJ63usy76MqrOZbdAtVa+F
 gUA1kuSJ2kUVz82BjBe972syOB6XdJ2EWuja9Pp1TWlKuXPejqaAwyuAo9HNkWZaHaJW
 6XO9hcn4RjiuqVhi+wD846334D+Qxs0DFf3Pe5mQiKv/DccYMtUfbuCWbet43ZeQhryP
 BRqsJCratVGK0nljtawPStFf7t/iAWl58gnjIQEC1/M8kJrmIMf42oDS1UKc3drVgzGp
 MKy5Pm5lfYr6SHZ5eyYsj1O1UVhAz3wYI/MhAfQkJQIeGgFGMJNeQXNQsotpb4/fYyc+
 nwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893863; x=1694498663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pzg20wHPv+q7Gk6Nq1Mqo2bgC7J10ecxifs4mul0aOs=;
 b=GCUhKWStzJm3fufibbB52oB3VPW8RUmakdSrUu5kAIG81490kEM81I1NTDPsutt6i/
 6MYSplTug/q+D0MZpH3Ffnuc3u5Ata8uPKGYVGJSFrylmlLHcKo+dphNYtLf6iVB2Bc9
 RVu19RC0Fr66t6ruLzKj3bM45t7srHwG8kurHoMkjUnlKwrKh5/R2uU4TEtqhCyuadFn
 Zvt6sl7FiUDZdmIcE/JqTMMAXwT3pPWh7Nba88Da+fIHG6o4dzYFQUV83qznYqlPLHWx
 iyZMkCQT9K5bTWG5cWqpe54inM0v5iQtT188sG6NAi+4WnGxweOPe6KM5USQg3TTcxcr
 89+A==
X-Gm-Message-State: AOJu0Yy92n9MBp9r9TFRmAHu+Ol7iZ+3/TJF8glyUn73RD6P67gisL/Y
 0XRm5BQKqzFyrfxmHAyn3Pyibp3v6YB/kXHH
X-Google-Smtp-Source: AGHT+IHIbD8KgpRlJ2JO9njPKCTyaGrR7QTa7Z0MK0fD2Tcwp2wC8xTcBqJpX4VEo5NJfHz5RBM5WQ==
X-Received: by 2002:a50:ee17:0:b0:52b:d169:b372 with SMTP id
 g23-20020a50ee17000000b0052bd169b372mr9307753eds.4.1693893862800; 
 Mon, 04 Sep 2023 23:04:22 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:22 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/11] drm/amdgpu: fix and cleanup
 gmc_v11_0_flush_gpu_tlb_pasid
Date: Tue,  5 Sep 2023 08:04:12 +0200
Message-Id: <20230905060415.1400-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905060415.1400-1-christian.koenig@amd.com>
References: <20230905060415.1400-1-christian.koenig@amd.com>
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The same PASID can be used by more than one VMID, reset each of them.

Use the common KIQ handling.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 63 ++++++++------------------
 1 file changed, 19 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3c3ad3f17c6a..aa39c1087e44 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -303,54 +303,27 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					uint16_t pasid, uint32_t flush_type,
 					bool all_hub, uint32_t inst)
 {
+	uint16_t queried;
 	int vmid, i;
-	signed long r;
-	uint32_t seq;
-	uint16_t queried_pasid;
-	bool ret;
-	struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-
-	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
-		spin_lock(&adev->gfx.kiq[0].ring_lock);
-		/* 2 dwords flush + 8 dwords fence */
-		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
-		kiq->pmf->kiq_invalidate_tlbs(ring,
-					pasid, flush_type, all_hub);
-		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-		if (r) {
-			amdgpu_ring_undo(ring);
-			spin_unlock(&adev->gfx.kiq[0].ring_lock);
-			return -ETIME;
-		}
-
-		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq[0].ring_lock);
-		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
-		if (r < 1) {
-			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
-			return -ETIME;
-		}
-
-		return 0;
-	}
 
 	for (vmid = 1; vmid < 16; vmid++) {
-
-		ret = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
-				&queried_pasid);
-		if (ret	&& queried_pasid == pasid) {
-			if (all_hub) {
-				for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
-					gmc_v11_0_flush_gpu_tlb(adev, vmid,
-							i, flush_type);
-			} else {
-				gmc_v11_0_flush_gpu_tlb(adev, vmid,
-						AMDGPU_GFXHUB(0), flush_type);
-			}
+		bool valid;
+
+		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
+							      &queried);
+		if (!valid || queried == pasid)
+			continue;
+
+		if (all_hub) {
+			for_each_set_bit(i, adev->vmhubs_mask,
+					 AMDGPU_MAX_VMHUBS)
+				gmc_v11_0_flush_gpu_tlb(adev, vmid, i,
+							flush_type);
+		} else {
+			gmc_v11_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
+						flush_type);
 		}
 	}
-
 	return 0;
 }
 
@@ -918,8 +891,10 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 
 static int gmc_v11_0_hw_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v11_0_init_golden_registers(adev);
-- 
2.34.1

