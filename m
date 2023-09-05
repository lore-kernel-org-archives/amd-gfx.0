Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD129C83F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFE110E432;
	Tue,  5 Sep 2023 06:04:30 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D006410E42A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:23 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52889bc61b6so2767883a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893862; x=1694498662; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaAW/aPTzY26KkOV2iSqQrocEcYnKSuubtj1na4kHjc=;
 b=q6m7ynyJUyfuFGq9J1cCEvG3HHKeX7kS0xGGxa/HbVF4XYFHRwFo5BnjMxcWwTizj6
 dKliU4NkhpO5RQcLtRW926wui8fXg1P1u47KDimjCz9Sw8awnnRp739/qJy48jT5R7Gg
 2XfF59l2ktMpRPIo6GN2ZV1Iptg5mX4qjQt6e8LlyTlgl9Wu2NqqVr8pwVDMX36mhx/H
 hOojJyE3sBAqDBRgKEce7wLks2byIBsp4FmzVX+FBv9R+cqk6cxNfm1ojC4eSTvf/Ijd
 yl4RQ2a1a4u8uB/PAjrETMxSMw6XDhO9TqGPlO/gn6OIeBnWkLwPXzS9bNcSUp7ZJWV3
 ICHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893862; x=1694498662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IaAW/aPTzY26KkOV2iSqQrocEcYnKSuubtj1na4kHjc=;
 b=SQ8wl9k0ZfT+N13vSvvKta2mYhKRbsg7O5jHLVdkSiq+eNFulQiCOeZg6A9ZD3A9KE
 qiBQ5fNxomslJ05qUxYM68lf9p/hmjcicBsWynBbyWb8E3D25eGQIfeqr/FVj5epOTYb
 8pEhXp9w1CpavNKw/yi+ll3jPrvcpbHdKuye12Et8GCH28OLcSTQ/ROBMXAJoVruGgdW
 kaduB0w9T7KV0+ZMlOojZv1RslBVZUXmsNGjZak7HG+xlpDtA/6I5ewmbOaHRHo7Fpta
 RwBxpT8h7UqXKscn5HMr0NxYgjO3mj3bsPo9OD1b8zyTgDPNQ+IuF0u/OYVo+XKb5b47
 sZNw==
X-Gm-Message-State: AOJu0YylXTo51PkOomZG78poA+0sZ84cFJReCMP5f8YFUr8DpwQgaDBq
 V2anGQeDqB1x6vrL5+zigWtM6ntmpeoa4NOC
X-Google-Smtp-Source: AGHT+IFgeTyFrMgI1Jir6eHK3dnwRG325Eh22OrQy2i4ZQRpTwkWd+kh5FK8QR+b2hwmHpz5rDw4Pg==
X-Received: by 2002:aa7:cd7a:0:b0:522:2711:873 with SMTP id
 ca26-20020aa7cd7a000000b0052227110873mr9771547edb.1.1693893862207; 
 Mon, 04 Sep 2023 23:04:22 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:21 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/11] drm/amdgpu: cleanup gmc_v10_0_flush_gpu_tlb_pasid
Date: Tue,  5 Sep 2023 08:04:11 +0200
Message-Id: <20230905060415.1400-8-christian.koenig@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 66 ++++++++------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 1f70c57bcd69..407ddb926941 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -341,57 +341,27 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
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
 
@@ -1009,8 +979,10 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 
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

