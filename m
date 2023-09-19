Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B52CD5BA6
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E0310E3A3;
	Tue, 19 Sep 2023 12:08:46 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B21410E262
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 12:08:30 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-532aaba8747so1337322a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695125309; x=1695730109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PswyLDt5Y/gNWLQwDD0IlJy/Gm47UTufcOrjKbUrdyI=;
 b=IjD1X5dOt3zKdebPfoMhdyrhYLTt4RgAR2O9XiA0hFsICMszt5blmnOe1WzV5Bs2vs
 mR+0VBGnPhz8eTHmTfPp5LNjWWy9CNwmXOMygzrTqTzwO/+HZyipuVo0OmZX3Rlfb1CJ
 gp3e67DAecKisjrBdQECFsR33EWFpNWDETEDLhI6AnmEevkD/JuPLR9QKHx/PVtxVeDr
 zDjeWeaBSUuSigWpTm3RysTU+cxAK99dID+1KQjwn4ejRc1KH2Bmhjy2DoQeAzL49j/0
 BOvulq8hWb6tmd/JbeZDTczLDAPk2tp8oiSn6lug04AU0VB1Zw44jfazvQ+K7SSSG78G
 Z1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695125309; x=1695730109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PswyLDt5Y/gNWLQwDD0IlJy/Gm47UTufcOrjKbUrdyI=;
 b=CaGTavMWXgqDZaHzb7CO0dytAv8dBasMUZ0jTmr2r7Cu0cqBnCr2O1xGEXbOxvs6Tk
 WfnAKKJpLZ7XZw9UWy8IW7xtndrkYQVM5atJ0pdE3DlzTz4nBp8Ht0dR8mB9Jn6RPYMJ
 Wqo/UBVQ4CCsV72UzVliX1LFK1RPHUNH1ewDGp9i+QzYsAH0wNRXLxPmP6oL3zB7K+XK
 XB/uSaG/KB5h2XnSrA7/KYqA/K0R0Pm5x6FlqfZj+IdKDBDvi4HgcxmoItavdgleNGgn
 j+SoPZy4zgWHgsLyEIluPZdx+U+PmAtzWkW3CloxgMOTTcWmYvCA8qa5WSFQc2YImyZU
 mrLg==
X-Gm-Message-State: AOJu0YzbaPOtfHQEjkYw9d94yTOwcyCeu7RqPSga4Ea7l2ICcAI9oKLH
 PCi0bBVDmvHgxCfcEj1qGNc=
X-Google-Smtp-Source: AGHT+IEsy+rrb7uo6eAquiR0seI2YPsryFjjrKqidmGP4nhjXdEyTLupZdZ9P+RCTcFHKS3bCt4JqA==
X-Received: by 2002:a05:6402:b16:b0:525:469a:fc47 with SMTP id
 bm22-20020a0564020b1600b00525469afc47mr9481809edb.22.1695125308771; 
 Tue, 19 Sep 2023 05:08:28 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bc:9900:21a0:f69e:f2eb:dcf5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b0052a1a623267sm7283100edt.62.2023.09.19.05.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:08:28 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alexdeucher@gmail.com, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/11] drm/amdgpu: fix and cleanup
 gmc_v11_0_flush_gpu_tlb_pasid
Date: Tue, 19 Sep 2023 14:08:19 +0200
Message-Id: <20230919120822.95241-8-christian.koenig@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 63 ++++++++------------------
 1 file changed, 19 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index b2de44e811cc..a129166a721c 100644
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

