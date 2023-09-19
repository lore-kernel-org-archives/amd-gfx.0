Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB04CD5BA0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9136910E3A0;
	Tue, 19 Sep 2023 12:08:35 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B226D10E262
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 12:08:29 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53136a13cd4so2077426a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695125308; x=1695730108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AuVxbGX4UoGr7WJuLn7FYq4tdxRLKv8jFplEc+yX4gI=;
 b=boBliB2KLSLzhpFKedosd8FkunRgxz5IclTrU9fYOWqJtBGvlj4o5+MLbFHzU+6VoN
 ltqlt4V3wIfYLuxfGI8avr0GZGkJmhoeMeMZgM/XTCsQwHztWhKGnx9AS+ibSTDCwAI0
 h/IAX768sVVHrIgx4BSxnfFlyuL8jvX5zj/dYoeYZN8prLKlECMBMaqzVTrsw8hu035R
 RLbnnQt53XZxdBxXeQlWzdX1/79PRFerLH9ivL0HpOHEEWJYYfg3hZyiVUmqaHf5a/fe
 WoG6XYDajIb5dXW02ingLVQ0Ki+LhUQCB8hX/gct7ZwreeFCTU2uNKtxxNn3m26Hh/wT
 iX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695125308; x=1695730108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AuVxbGX4UoGr7WJuLn7FYq4tdxRLKv8jFplEc+yX4gI=;
 b=qKHNENvLi2r4dvimQw9dY+PhkASPZjKzVaWC93wbvKEntJuIKrSyr9Wrn/miV4ZMqx
 SHBR3KuRTRilfuIdxA3r1f1z686S/++fvZ1JN11nw9Iu1s8OPMR+MZwy1IbSXdbk+0eM
 avZAQkYo9xsB4Ry9XWtETxyBDJsxpUDhRJRDT2GDJm2zfLjluTKXxXOu84XhRQaC35BF
 Q6HGEA+kY5UnLQuiMGdIZTHUxMveiSUJlp5igf23n8bOCNXKMSQl8tvbhQGpPbfGSJ9u
 rC4OnVuEtSVGI0kpxwmQTqlw8/GbcWwuEmWvVWAKTqK7YoIqHHH0k0Y+zfvYHZg5vN+F
 HyCw==
X-Gm-Message-State: AOJu0Yx4uBD44lRJi0GfzFLWDJD3jDkAv45P3E+uGfGsFrvaFDPOUz+E
 AzXHL5vB3I4pmcl5a5jO0RE=
X-Google-Smtp-Source: AGHT+IEkVJa7WN+HSjnxJNSGOXHFffyHrKqeLKIHn+GaVsmHyfRFjUo/fAHX7exdFSHFCEcbVkBA/A==
X-Received: by 2002:aa7:d8d7:0:b0:52b:d169:b374 with SMTP id
 k23-20020aa7d8d7000000b0052bd169b374mr9634884eds.3.1695125308085; 
 Tue, 19 Sep 2023 05:08:28 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bc:9900:21a0:f69e:f2eb:dcf5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b0052a1a623267sm7283100edt.62.2023.09.19.05.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:08:27 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alexdeucher@gmail.com, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/11] drm/amdgpu: cleanup gmc_v10_0_flush_gpu_tlb_pasid
Date: Tue, 19 Sep 2023 14:08:18 +0200
Message-Id: <20230919120822.95241-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919120822.95241-1-christian.koenig@amd.com>
References: <20230919120822.95241-1-christian.koenig@amd.com>
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

The same PASID can be used by more than one VMID, reset each of them.

Use the common KIQ handling.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 66 ++++++++------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 70c953919089..5cc77c207dbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -343,57 +343,27 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					uint16_t pasid, uint32_t flush_type,
 					bool all_hub, uint32_t inst)
 {
+	uint16_t queried;
 	int vmid, i;
-	signed long r;
-	uint32_t seq;
-	uint16_t queried_pasid;
-	bool ret;
-	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT : adev->usec_timeout;
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
-		r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
-		if (r < 1) {
-			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
-			return -ETIME;
-		}
-
-		return 0;
-	}
 
 	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
-
-		ret = gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
-				&queried_pasid);
-		if (ret	&& queried_pasid == pasid) {
-			if (all_hub) {
-				for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
-					gmc_v10_0_flush_gpu_tlb(adev, vmid,
-							i, flush_type);
-			} else {
-				gmc_v10_0_flush_gpu_tlb(adev, vmid,
-						AMDGPU_GFXHUB(0), flush_type);
-			}
-			if (!adev->enable_mes)
-				break;
+		bool valid;
+
+		valid = gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
+								  &queried);
+		if (!valid || queried != pasid)
+			continue;
+
+		if (all_hub) {
+			for_each_set_bit(i, adev->vmhubs_mask,
+					 AMDGPU_MAX_VMHUBS)
+				gmc_v10_0_flush_gpu_tlb(adev, vmid, i,
+							flush_type);
+		} else {
+			gmc_v10_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
+						flush_type);
 		}
 	}
-
 	return 0;
 }
 
@@ -1012,8 +982,10 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 
 static int gmc_v10_0_hw_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v10_0_init_golden_registers(adev);
-- 
2.34.1

