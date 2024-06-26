Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20C2C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0933110E009;
	Wed, 26 Jun 2024 18:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ahdFcbAM";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD9C10E13A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:32:01 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-79c072af217so183393485a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426720; x=1720031520; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giXeL1T29/nTDOKDvLkgD031Zfv7oEQtlx7MuaJHbhc=;
 b=ahdFcbAMVaJzuC/YDn9Sph+gP70fwnAdGAGk2AEx5RTl0bngaOLZ2WE1GD/dLZG/tJ
 HARoafAu1vebo7/zKWx+wmdwExQ6I82d1juRp6txXLVN3u79UK8E6JEKi9nqIsVfIB3b
 2VduZ7Hi7ppgg6fPtVcz3N3aWHLKyo6EDaxr8NcsiVFe3ixSg0YOeO9e5Ze2pQ8oRArh
 12K9HbbJ+sCF18CO8yG79SQTplqB6w99O8Tk4gMFhk+0hSW9sziwZ7174yZGATsk4/SS
 0uqTL8zTShrUW4Bagb913nYyp868EexLRfr4Ty/gfQNeOye7q0sPuUUFWJ9oqK7EOsUs
 gv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426720; x=1720031520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=giXeL1T29/nTDOKDvLkgD031Zfv7oEQtlx7MuaJHbhc=;
 b=qFp/qYnVwm1nCJqyrVg/t1q4Ir5T7Q3MT+J2aAnVauNucvTtN3Os9YWwnoB4UOTlGV
 62NGdvS462N1M3IAio1cqAbgOvHpl2U7lebWMAE68m9tC8BZaMJ5HWolbBvJzMa26WVF
 NGT+8uGjYelTnSPi5jrQsO/OsJ92Bif81jI2pc8V0lpGwPPk8jAc4rH6FjZeNEuxURKd
 cxFaRYoq6WUEy5ev96yPqSZvkVSPZ1VmcixmUnqonAjFjJeHdAgMxYLl1UrSMAb5fOsc
 yQw7+tgeYTMbPKVHzf3jdLb1902/kmvou1PrN4SicUUiHloGhi/wsttWd82r5MpOapSJ
 3E+A==
X-Gm-Message-State: AOJu0YxKkNUZgbjzo3Xygu7JiMZ71z5pNbY1K8bBI6mjzj6kKOIsQtT7
 5gMLPNxXEdJ9i5o+/aDT/1EFJMhieM7thF9iQiYLr2orpTkdqoZiYrAwNg==
X-Google-Smtp-Source: AGHT+IHfBEmS2KMysuWenpn4RkFtFkLskyQ2yyeh0cPwBy96Ai5PSBbJpdEoLCTe7twMIYfkMxeEGA==
X-Received: by 2002:ad4:5bc4:0:b0:6b4:fcf7:2a31 with SMTP id
 6a1803df08f44-6b5409df67bmr135209046d6.28.1719426719042; 
 Wed, 26 Jun 2024 11:31:59 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:31:58 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 04/13] drm/amdgpu/gfx12: remove GDS leftovers
Date: Wed, 26 Jun 2024 14:31:26 -0400
Message-Id: <20240626183135.8606-4-marek.olsak@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626183135.8606-1-marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
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

GDS doesn't exist in gfx12. The incomplete packet allows userspace to hang
the hw from the kernel.

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a638696b2142..ccb26f78252a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4108,21 +4108,6 @@ static void gfx_v12_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 		/* inherit vmid from mqd */
 		control |= 0x40000000;
 
-	/* Currently, there is a high possibility to get wave ID mismatch
-	 * between ME and GDS, leading to a hw deadlock, because ME generates
-	 * different wave IDs than the GDS expects. This situation happens
-	 * randomly when at least 5 compute pipes use GDS ordered append.
-	 * The wave IDs generated by ME are also wrong after suspend/resume.
-	 * Those are probably bugs somewhere else in the kernel driver.
-	 *
-	 * Writing GDS_COMPUTE_MAX_WAVE_ID resets wave ID counters in ME and
-	 * GDS to 0 for this ring (me/pipe).
-	 */
-	if (ib->flags & AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID) {
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SET_CONFIG_REG, 1));
-		amdgpu_ring_write(ring, regGDS_COMPUTE_MAX_WAVE_ID);
-	}
-
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
 	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
@@ -4721,7 +4706,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
 		8 + /* FENCE for VM_FLUSH */
-		20 + /* GDS switch */
 		5 + /* COND_EXEC */
 		7 + /* HDP_flush */
 		4 + /* VGT_flush */
-- 
2.34.1

